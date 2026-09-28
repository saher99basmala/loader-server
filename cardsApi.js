'use strict';

const express = require('express');
const crypto = require('crypto');
const zlib = require('zlib');
const { XMLParser } = require('fast-xml-parser');

const router = express.Router();
const parser = new XMLParser({
  ignoreAttributes: false,
  attributeNamePrefix: '@_',
  trimValues: false,
  parseTagValue: false,
  parseAttributeValue: false
});

const KEY = Buffer.from('Wucai6oj0sheiX3p', 'utf8');
const SENDBOX = 'https://township.playrix.com/api/1/SendBox?cityId=';

function arr(v) { return v == null ? [] : Array.isArray(v) ? v : [v]; }
function s(v) { return v == null ? '' : String(v); }
function blank(v) { return !s(v).trim(); }

function qjsonPairs(pairs) {
  const o = {};
  for (const [k, v] of pairs) o[k] = v;
  return JSON.stringify(o);
}

function hex(buf) { return Buffer.from(buf).toString('hex'); }
function unhex(str) {
  if (!/^[0-9a-fA-F]*$/.test(str) || str.length % 2) throw new Error('invalid hex');
  return Buffer.from(str, 'hex');
}

function encryptPayload(json) {
  const gz = zlib.gzipSync(Buffer.from(json, 'utf8'));
  const iv = crypto.randomBytes(12);
  const cipher = crypto.createCipheriv('aes-128-gcm', KEY, iv, { authTagLength: 16 });
  const encrypted = Buffer.concat([cipher.update(gz), cipher.final()]);
  const tag = cipher.getAuthTag();
  return {
    body: encrypted,
    tsId: '002' + hex(iv) + hex(tag)
  };
}

function decryptResponse(tsId, body) {
  if (!/^002/i.test(tsId) || tsId.length !== 59) throw new Error('response ts-id invalid');
  const iv = unhex(tsId.slice(3, 27));
  const tag = unhex(tsId.slice(27, 59));
  const decipher = crypto.createDecipheriv('aes-128-gcm', KEY, iv, { authTagLength: 16 });
  decipher.setAuthTag(tag);
  let out = Buffer.concat([decipher.update(Buffer.from(body)), decipher.final()]);
  if (out.length >= 2 && out[0] === 0x1f && out[1] === 0x8b) out = zlib.gunzipSync(out);
  return out.toString('utf8');
}

function walk(node, fn, seen = new Set()) {
  if (!node || typeof node !== 'object' || seen.has(node)) return;
  seen.add(node);
  fn(node);
  for (const v of Object.values(node)) {
    if (v && typeof v === 'object') {
      for (const x of arr(v)) if (x && typeof x === 'object') walk(x, fn, seen);
    }
  }
}

function findNamed(root, names) {
  const wanted = new Set(names);
  let hit;
  walk(root, node => {
    if (hit) return;
    if (node['@_name'] && wanted.has(node['@_name'])) hit = node;
  });
  return hit;
}

function valueOf(node) {
  if (!node || typeof node !== 'object') return undefined;
  return node['@_value'] !== undefined ? node['@_value'] : node['@_v'];
}

function fieldsOf(node) {
  const out = {};
  for (const x of arr(node && node.DataElem)) {
    if (x && typeof x === 'object' && x['@_name']) out[x['@_name']] = valueOf(x);
  }
  return out;
}

function extractCards(xml) {
  const doc = parser.parse(xml);
  const owned = findNamed(doc, ['OwnedCards']);
  if (!owned) throw new Error('OwnedCards was not found in XML');
  const map = new Map();
  for (const entry of arr(owned.DataElem)) {
    if (!entry || typeof entry !== 'object') continue;
    const f = fieldsOf(entry);
    const id = s(f.cardId).trim();
    const count = Number(f.inStockCount || 0);
    if (!id || !Number.isFinite(count) || count <= 0) continue;
    if (!map.has(id)) map.set(id, { cardId: id, count: 0 });
    map.get(id).count += count;
  }
  const cards = [...map.values()];
  return {
    cards,
    distinctCards: cards.length,
    totalCopies: cards.reduce((n, x) => n + x.count, 0)
  };
}

function extractMeta(xml) {
  const get = name => {
    const re = new RegExp('(?:DataElem|Var)\\s[^>]*name=[\"\\\']' + name + '[\"\\\'][^>]*(?:value|v)=[\"\\\']([^\"\\\']*)[\"\\\']', 'i');
    const m = xml.match(re);
    return m ? m[1] : null;
  };
  return {
    cityId: get('cityId') || get('city_id') || null,
    gameId: get('gameId') || get('game_id') || null,
    townName: get('townName') || get('name') || null,
    experience: get('experience') || null,
    totalSendCards: Number(get('totalSendCards') || 0) || 0
  };
}

function collectionSetId(xml, cardId) {
  const m = s(cardId).match(/^card_(\d+)$/i);
  if (!m) return 'set_01';
  const n = Number(m[1]);

  let x = xml.match(/<DataElem\s+name="configId"\s+type="string"\s+value="CardCollections_(\d+)"/i);
  if (x && x[1]) return x[1];

  x = xml.match(/<DataElem\s+name="pinnedCardCollectionsBalanceId"\s+type="string"\s+value="CardC(\d+)_Balance"/i);
  if (x && x[1]) return x[1];

  const block = xml.match(/<DataElem\s+name="LastSeenSetProgress"\s+type="dataStore">([\s\S]*?)<\/DataElem>/i);
  if (block) {
    const re = /<DataElem\s+name="(set_\d+)"\s+type="int"\s+value="(\d+)"\s*\/>/gi;
    let sum = 0;
    let z;
    while ((z = re.exec(block[1]))) {
      sum += Number(z[2]);
      if (n <= sum) return z[1].toLowerCase();
    }
  }

  return `set_${String(Math.floor((n - 1) / 10) + 1).padStart(2, '0')}`;
}

function extractFriends(xml) {
  const doc = parser.parse(xml);
  const out = [];
  const seen = new Set();
  const idNames = new Set(['cityId', 'city_id', 'gameId', 'friendId', 'friend_id', 'id']);
  const nameNames = new Set(['name', 'cityName', 'city_name', 'townName', 'friendName']);

  function add(obj) {
    if (!obj || typeof obj !== 'object') return;
    let id = null, name = null, pic = null;
    for (const [k, v] of Object.entries(obj)) {
      if (!k.startsWith('@_')) continue;
      const n = k.slice(2);
      if (idNames.has(n) && blank(id)) id = v;
      if (nameNames.has(n) && blank(name)) name = v;
      if (n === 'pic' || n === 'picture' || n === 'avatar') pic = v;
    }
    if (id == null) {
      const v = valueOf(obj);
      if (v != null && String(v).trim()) id = v;
    }
    if (id == null || !String(id).trim()) return;
    id = String(id).trim();
    if (seen.has(id)) return;
    seen.add(id);
    out.push({ id, name: name == null ? '' : String(name), pic: pic == null ? '' : String(pic) });
  }

  walk(doc, node => {
    if (node['@_name'] === 'FriendsList' || /friend/i.test(String(node['@_name'] || ''))) {
      for (const x of arr(node.DataElem)) add(x);
    }
    if (node['@_cityId'] || node['@_city_id'] || node['@_friendId']) add(node);
  });

  return out;
}

function buildBox(cfg, friend, cardId, setId, sendCounter, colEt, seed) {
  const from = qjsonPairs([
    ['city_id', cfg.ownCityId],
    ['friend_city_name', friend.name || '' ],
    ['pic', cfg.ownPic || 'ava0']
  ]);

  const box = qjsonPairs([
    ['afg', 3],
    ['box_type', 'collections_send_card'],
    ['card_id', cardId],
    ['col_et', colEt],
    ['col_id', setId],
    ['friend_type', 'send_friend'],
    ['from', from],
    ['seed', String(seed)],
    ['sendCounter', sendCounter],
    ['set_id', setId],
    ['to', friend.id],
    ['type', 'box']
  ]);

  return qjsonPairs([
    ['box', box],
    ['cityId', cfg.ownCityId],
    ['to_cityId', friend.id]
  ]);
}

function colEtNow(nowSec = Math.floor(Date.now() / 1000)) {
  const day = 86400;
  const nine = 32400;
  const base = Math.floor(nowSec / day) * day;
  let t = base + nine;
  if (t <= nowSec) t = base + 118800;
  return t;
}

function configFrom(req) {
  const b = req.body || {};
  const c = b.config || {};
  return {
    ownCityId: s(c.ownCityId || b.ownCityId || process.env.CARD_OWN_CITY_ID).trim(),
    ownToken: s(c.ownToken || b.ownToken || process.env.CARD_OWN_TOKEN).trim(),
    ownCityName: s(c.ownCityName || b.ownCityName || process.env.CARD_OWN_CITY_NAME || 'Township'),
    ownPic: s(c.ownPic || b.ownPic || process.env.CARD_OWN_PIC || 'ava0'),
    bver: s(c.bver || b.bver || process.env.CARD_BVER).trim(),
    fver: s(c.fver || b.fver || process.env.CARD_FVER).trim(),
    seed: s(c.seed || b.seed || process.env.CARD_SEED || '').trim(),
    userAgentVersion: s(c.userAgentVersion || b.userAgentVersion || process.env.CARD_USER_AGENT_VERSION || '').trim()
  };
}

function validateConfig(c) {
  for (const k of ['ownCityId', 'ownToken', 'bver', 'fver', 'seed']) {
    if (blank(c[k])) throw new Error(`Missing card config: ${k}`);
  }
}

async function sendOne(cfg, friend, cardId, setId, sendCounter) {
  const payload = buildBox(cfg, friend, cardId, setId, sendCounter, colEtNow(), cfg.seed);
  const enc = encryptPayload(payload);
  const url = SENDBOX + encodeURIComponent(cfg.ownCityId);
  const headers = {
    'Content-Type': 'application/octet-stream',
    'IsNewClanUIEnabled': 'true',
    'User-Agent': `Township/${cfg.userAgentVersion || cfg.bver} (Android 13)`,
    'ts-bp': 'g',
    'ts-bver': cfg.bver,
    'ts-fver': cfg.fver,
    'ts-gpid': 'new',
    'ts-id': enc.tsId,
    'ts-token': cfg.ownToken,
    'x-version': cfg.bver
  };

  const r = await fetch(url, { method: 'POST', headers, body: enc.body });
  const raw = Buffer.from(await r.arrayBuffer());
  const responseTsId = r.headers.get('ts-id') || '';
  let decoded = '';
  let parsed = null;
  let decryptError = null;

  if (responseTsId && raw.length) {
    try {
      decoded = decryptResponse(responseTsId, raw);
      try { parsed = JSON.parse(decoded); } catch (_) {}
    } catch (e) { decryptError = e.message; }
  }

  const resultObject = parsed && parsed.result && typeof parsed.result === 'object' ? parsed.result : null;
  const accepted = r.status >= 200 && r.status < 300 && resultObject && Object.keys(resultObject).length === 0;

  return {
    cardId,
    setId,
    sendCounter,
    httpStatus: r.status,
    accepted: Boolean(accepted),
    responseTsId,
    response: parsed,
    responseText: decoded || (raw.length ? raw.toString('utf8') : ''),
    decryptError
  };
}

router.post('/analyze', (req, res) => {
  try {
    const xml = typeof req.body === 'string' ? req.body : (req.body && (req.body.xml || req.body.myXml));
    if (!xml) throw new Error('XML is missing');
    const meta = extractMeta(xml);
    const inventory = extractCards(xml);
    res.json({ ok: true, meta, friends: extractFriends(xml), cards: inventory.cards, distinctCards: inventory.distinctCards, totalCopies: inventory.totalCopies });
  } catch (e) {
    res.status(400).json({ ok: false, error: e.message });
  }
});

router.post('/send-all', async (req, res) => {
  try {
    const b = req.body || {};
    const xml = typeof b === 'string' ? b : (b.xml || b.myXml);
    if (!xml) throw new Error('XML is missing');
    const cfg = configFrom(req);
    validateConfig(cfg);

    const friend = typeof b.friend === 'object' && b.friend ? b.friend : {
      id: b.friendId || b.toCityId || b.to_cityId,
      name: b.friendName || b.cityName || '',
      pic: b.friendPic || b.pic || ''
    };
    friend.id = s(friend.id).trim();
    friend.name = s(friend.name);
    if (!friend.id) throw new Error('friendId is required');

    const inv = extractCards(xml);
    let ids = Array.isArray(b.cardIds) && b.cardIds.length ? b.cardIds.map(s) : inv.cards.map(x => x.cardId);
    ids = [...new Set(ids.map(x => x.trim()).filter(Boolean))];
    if (!ids.length) throw new Error('No sendable cards found');

    const meta = extractMeta(xml);
    const startCounter = Number.isFinite(Number(b.startCounter)) ? Number(b.startCounter) : meta.totalSendCards;
    const results = [];
    for (let i = 0; i < ids.length; i++) {
      const cardId = ids[i];
      const setId = collectionSetId(xml, cardId);
      try {
        results.push(await sendOne(cfg, friend, cardId, setId, startCounter + i));
      } catch (e) {
        results.push({ cardId, setId, sendCounter: startCounter + i, accepted: false, error: e.message });
      }
    }

    const accepted = results.filter(x => x.accepted);
    const failed = results.filter(x => !x.accepted);
    res.json({
      ok: failed.length === 0,
      friend,
      totalCards: ids.length,
      sentCards: accepted.length,
      failed: failed.length,
      totalSendCardsBefore: startCounter,
      totalSendCardsAfter: startCounter + ids.length,
      sentCardIds: accepted.map(x => x.cardId),
      failedCards: failed,
      results
    });
  } catch (e) {
    res.status(400).json({ ok: false, error: e.message });
  }
});

router.post('/send-one', async (req, res) => {
  try {
    const b = req.body || {};
    const xml = b.xml || b.myXml;
    if (!xml) throw new Error('XML is missing');
    const cfg = configFrom(req);
    validateConfig(cfg);
    const friend = b.friend || { id: b.friendId, name: b.friendName || '' };
    friend.id = s(friend.id).trim();
    if (!friend.id) throw new Error('friendId is required');
    const cardId = s(b.cardId).trim();
    if (!cardId) throw new Error('cardId is required');
    const meta = extractMeta(xml);
    const setId = collectionSetId(xml, cardId);
    const sendCounter = Number.isFinite(Number(b.sendCounter)) ? Number(b.sendCounter) : meta.totalSendCards;
    const result = await sendOne(cfg, friend, cardId, setId, sendCounter);
    res.status(result.accepted ? 200 : 502).json({ ok: result.accepted, result });
  } catch (e) {
    res.status(400).json({ ok: false, error: e.message });
  }
});

module.exports = router;
