'use strict';

const express = require('express');
const fetch = require('node-fetch');
const crypto = require('crypto');
const zlib = require('zlib');
const { XMLParser } = require('fast-xml-parser');

const router = express.Router();

/*
 * Rebuilt from the uploaded Clone Town APK / extracted smali.
 * /send-all is the complete path:
 *   bs.xml -> credentials/friends
 *   my.xml -> cards/counters/collection data
 *   build box -> gzip -> AES-128-GCM -> SendBox
 *   decrypt real game response -> return it to Lua
 */

const KEY = Buffer.from('Wucai6oj0sheiX3p', 'utf8');
const SENDBOX = 'https://township.playrix.com/api/1/SendBox?cityId=';

const parser = new XMLParser({
    ignoreAttributes: false,
    attributeNamePrefix: '@_',
    trimValues: false,
    parseTagValue: false,
    parseAttributeValue: false
});

function arr(v) {
    if (v == null) return [];
    return Array.isArray(v) ? v : [v];
}

function s(v) {
    return v == null ? '' : String(v);
}

function blank(v) {
    return !s(v).trim();
}

function hex(buf) {
    return Buffer.from(buf).toString('hex');
}

function unhex(str) {
    if (!/^[0-9a-fA-F]*$/.test(str) || str.length % 2) {
        throw new Error('invalid hex');
    }
    return Buffer.from(str, 'hex');
}

function qjsonPairs(pairs) {
    const obj = {};
    for (const [key, value] of pairs) obj[key] = value;
    return JSON.stringify(obj);
}

function getBody(req) {
    if (typeof req.body === 'string') {
        try {
            return JSON.parse(req.body);
        } catch (_) {
            return { xml: req.body };
        }
    }
    return req.body || {};
}

function walk(node, fn, seen = new Set()) {
    if (!node || typeof node !== 'object' || seen.has(node)) return;
    seen.add(node);
    fn(node);

    for (const value of Object.values(node)) {
        if (!value || typeof value !== 'object') continue;
        for (const item of arr(value)) {
            if (item && typeof item === 'object') {
                walk(item, fn, seen);
            }
        }
    }
}

function findNamed(root, names) {
    const wanted = new Set(names);
    let result = null;

    walk(root, node => {
        if (result) return;
        const name = node['@_name'];
        if (name && wanted.has(name)) result = node;
    });

    return result;
}

function valueOf(node) {
    if (!node || typeof node !== 'object') return undefined;
    if (node['@_value'] !== undefined) return node['@_value'];
    if (node['@_v'] !== undefined) return node['@_v'];
    return undefined;
}

function getField(node, names) {
    if (!node || typeof node !== 'object') return undefined;

    for (const name of names) {
        if (node['@_' + name] !== undefined) {
            return node['@_' + name];
        }
    }

    for (const child of arr(node.DataElem)) {
        if (!child || typeof child !== 'object') continue;
        const name = child['@_name'];
        if (name && names.includes(name)) {
            const value = valueOf(child);
            if (value !== undefined) return value;
        }
    }

    return undefined;
}

/* ------------------------------------------------------------
   FRIENDS: bs.xml
------------------------------------------------------------ */

function extractFriends(xml) {
    const doc = parser.parse(xml);
    const friends = [];
    const seen = new Set();

    function add(node) {
        if (!node || typeof node !== 'object') return;

        const id = s(
            node['@_city_id'] ||
            node['@_cityId'] ||
            node['@_friendId'] ||
            node['@_id'] ||
            ''
        ).trim();

        if (!id || seen.has(id)) return;

        const name = s(
            node['@_city_name'] ||
            node['@_cityName'] ||
            node['@_friendName'] ||
            node['@_name'] ||
            ''
        );

        const pic = s(
            node['@_pic'] ||
            node['@_picture'] ||
            node['@_avatar'] ||
            ''
        );

        seen.add(id);
        friends.push({ id, name, pic });
    }

    walk(doc, node => {
        const tag = s(node['@_name']);

        if (/friend/i.test(tag)) {
            for (const child of arr(node.friend)) add(child);
            for (const child of arr(node.DataElem)) add(child);
        }

        if (
            node['@_city_id'] ||
            node['@_cityId'] ||
            node['@_friendId']
        ) {
            add(node);
        }
    });

    return friends;
}

/* ------------------------------------------------------------
   CARDS: my.xml
------------------------------------------------------------ */

function extractCards(xml) {
    const doc = parser.parse(xml);
    const owned = findNamed(doc, [
        'OwnedCards',
        'ownedCards',
        'OwnedCard'
    ]);

    if (!owned) {
        throw new Error('OwnedCards was not found in my.xml');
    }

    const map = new Map();

    walk(owned, node => {
        const cardId = getField(node, [
            'cardId',
            'card_id',
            'CardId',
            'id'
        ]);

        const stock = getField(node, [
            'inStockCount',
            'in_stock_count',
            'InStockCount',
            'stockCount'
        ]);

        if (cardId === undefined || stock === undefined) return;

        const id = s(cardId).trim();
        const count = Number(stock);

        if (!id || !Number.isFinite(count) || count <= 0) return;

        const generated = Number(
            getField(node, [
                'generatedCount',
                'generated_count'
            ]) || 0
        );

        const maxStock = Number(
            getField(node, [
                'maxInStockCount',
                'max_in_stock_count'
            ]) || 0
        );

        const isNew = getField(node, [
            'isNew',
            'is_new'
        ]);

        if (!map.has(id)) {
            map.set(id, {
                cardId: id,
                count: 0,
                generatedCount: Number.isFinite(generated) ? generated : 0,
                isNew: s(isNew || 'false'),
                maxInStockCount: Number.isFinite(maxStock) ? maxStock : 0
            });
        }

        map.get(id).count += count;
    });

    const cards = [...map.values()];
    const totalCopies = cards.reduce((n, c) => n + c.count, 0);

    return {
        cards,
        distinctCards: cards.length,
        totalCopies,
        totalCards: totalCopies
    };
}

/* ------------------------------------------------------------
   my.xml metadata
------------------------------------------------------------ */

function extractMeta(xml) {
    const doc = parser.parse(xml);
    const find = names => {
        let result;
        walk(doc, node => {
            if (result !== undefined) return;
            const name = node['@_name'];
            if (!name || !names.includes(name)) return;
            const value = valueOf(node);
            if (value !== undefined) result = value;
        });
        return result;
    };

    return {
        cityId: find(['cityId', 'city_id']) || null,
        gameId: find(['gameId', 'game_id']) || null,
        townName: find(['townName', 'city_name', 'name']) || null,
        experience: find(['experience']) || null,
        totalSendCards: Number(find(['totalSendCards']) || 0) || 0
    };
}

/* ------------------------------------------------------------
   AUTH / VERSION DATA: bs.xml

   The uploaded bs.xml contains the same values the APK feeds
   into the SendBox request:
     <Version version="..." FVer="..." ... />
     <AWS cityId="..." token="..." />
     PushNotifDeviceInfo also carries bver/fver as fallback.
------------------------------------------------------------ */

function extractGameConfig(bsXml, cardsXml) {
    const version = bsXml.match(
        /<Version\b[^>]*\bversion="([^"]+)"[^>]*\bFVer="([^"]+)"/i
    );

    const aws = bsXml.match(
        /<AWS\b[^>]*\bcityId="([^"]+)"[^>]*\btoken="([^"]+)"[^>]*>/i
    );

    const push = bsXml.match(
        /<PushNotifDeviceInfo\b([^>]*)\/?>(?:<\/PushNotifDeviceInfo>)?/i
    );

    const pushAttrs = push ? push[1] : '';

    const bverMatch = pushAttrs.match(/\bbver="([^"]+)"/i);
    const fverMatch = pushAttrs.match(/\bfver="([^"]+)"/i);

    const cityId = aws ? aws[1] : '';
    const token = aws ? aws[2] : '';
    const bver = version ? version[1] : (bverMatch ? bverMatch[1] : '');
    const fver = version ? version[2] : (fverMatch ? fverMatch[1] : '');

    let ownCityName = 'Township';
    let ownPic = 'ava0';

    const source = String(cardsXml || '') + '\n' + String(bsXml || '');

    const nameMatch = source.match(
        /<Var\s[^>]*name="name"[^>]*v="([^"]+)"/i
    );
    const picMatch = source.match(
        /<Var\s[^>]*name="MyPicture"[^>]*v="([^"]+)"/i
    );

    if (nameMatch && nameMatch[1]) ownCityName = nameMatch[1];
    if (picMatch && picMatch[1]) ownPic = picMatch[1];

    return {
        ownCityId: cityId.trim(),
        ownToken: token.trim(),
        ownCityName,
        ownPic,
        bver: bver.trim(),
        fver: fver.trim(),
        userAgentVersion: bver.trim()
    };
}

function validateConfig(cfg) {
    for (const key of ['ownCityId', 'ownToken', 'bver', 'fver']) {
        if (blank(cfg[key])) {
            throw new Error(
                `SendBox config missing in bs.xml: ${key}`
            );
        }
    }
}

/* ------------------------------------------------------------
   COLLECTION SET
------------------------------------------------------------ */

function collectionSetId(xml, cardId) {
    const match = s(cardId).match(/^card_(\d+)$/i);
    if (!match) return 'set_01';

    const cardNumber = Number(match[1]);

    let x = xml.match(
        /<DataElem\s+name="configId"\s+type="string"\s+value="CardCollections_(\d+)"/i
    );

    if (x && x[1]) return x[1];

    x = xml.match(
        /<DataElem\s+name="pinnedCardCollectionsBalanceId"\s+type="string"\s+value="CardC(\d+)_Balance"/i
    );

    if (x && x[1]) return x[1];

    const block = xml.match(
        /<DataElem\s+name="LastSeenSetProgress"\s+type="dataStore">([\s\S]*?)<\/DataElem>/i
    );

    if (block) {
        const re =
            /<DataElem\s+name="(set_\d+)"\s+type="int"\s+value="(\d+)"\s*\/>/gi;

        let sum = 0;
        let z;

        while ((z = re.exec(block[1]))) {
            sum += Number(z[2]);
            if (cardNumber <= sum) return z[1].toLowerCase();
        }
    }

    return 'set_' + String(
        Math.floor((cardNumber - 1) / 10) + 1
    ).padStart(2, '0');
}

/* ------------------------------------------------------------
   COLLECTION EXPIRATION
------------------------------------------------------------ */

function colEtNow(nowSec = Math.floor(Date.now() / 1000)) {
    const day = 86400;
    const nine = 32400;
    const base = Math.floor(nowSec / day) * day;

    let result = base + nine;

    if (result <= nowSec) {
        result = base + 118800;
    }

    return result;
}

/* ------------------------------------------------------------
   SEED
------------------------------------------------------------ */

function generateSeed() {
    const buffer = crypto.randomBytes(4);
    const n = buffer.readInt32BE(0);
    const unsigned = n >>> 1;
    return 10000 + (unsigned % 90000);
}

/* ------------------------------------------------------------
   EXACT BOX SHAPE FROM APK
------------------------------------------------------------ */

function buildBox(cfg, friend, cardId, setId, sendCounter, colEt, seed) {
    const from = qjsonPairs([
        ['city_id', cfg.ownCityId],
        ['friend_city_name', friend.name || ''],
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

/* ------------------------------------------------------------
   APK: GZIP -> AES-128-GCM
------------------------------------------------------------ */

function encryptPayload(json) {
    const gz = zlib.gzipSync(Buffer.from(json, 'utf8'));
    const iv = crypto.randomBytes(12);

    const cipher = crypto.createCipheriv(
        'aes-128-gcm',
        KEY,
        iv,
        { authTagLength: 16 }
    );

    const encrypted = Buffer.concat([
        cipher.update(gz),
        cipher.final()
    ]);

    const tag = cipher.getAuthTag();

    return {
        body: encrypted,
        tsId: '002' + hex(iv) + hex(tag)
    };
}

/* ------------------------------------------------------------
   APK: AES-128-GCM RESPONSE DECRYPTION
------------------------------------------------------------ */

function decryptResponse(tsId, body) {
    if (!/^002/i.test(tsId) || tsId.length !== 59) {
        throw new Error('response ts-id invalid');
    }

    const iv = unhex(tsId.slice(3, 27));
    const tag = unhex(tsId.slice(27, 59));

    const decipher = crypto.createDecipheriv(
        'aes-128-gcm',
        KEY,
        iv,
        { authTagLength: 16 }
    );

    decipher.setAuthTag(tag);

    let output = Buffer.concat([
        decipher.update(Buffer.from(body)),
        decipher.final()
    ]);

    if (
        output.length >= 2 &&
        output[0] === 0x1f &&
        output[1] === 0x8b
    ) {
        output = zlib.gunzipSync(output);
    }

    return output.toString('utf8');
}

/* ------------------------------------------------------------
   ONE SENDBOX REQUEST
------------------------------------------------------------ */

async function sendOne(cfg, friend, cardId, setId, sendCounter) {
    const seed = generateSeed();

    const payload = buildBox(
        cfg,
        friend,
        cardId,
        setId,
        sendCounter,
        colEtNow(),
        seed
    );

    const encrypted = encryptPayload(payload);

    const url =
        SENDBOX +
        encodeURIComponent(cfg.ownCityId);

    const headers = {
        'Content-Type': 'application/octet-stream',
        'IsNewClanUIEnabled': 'true',
        'User-Agent': `Township/${cfg.userAgentVersion || cfg.bver} (Android 13)`,
        'ts-bp': 'g',
        'ts-bver': cfg.bver,
        'ts-fver': cfg.fver,
        'ts-gpid': 'new',
        'ts-id': encrypted.tsId,
        'ts-token': cfg.ownToken,
        'x-version': cfg.bver
    };

    const response = await fetch(url, {
        method: 'POST',
        headers,
        body: encrypted.body
    });

    const raw = Buffer.from(
        await response.arrayBuffer()
    );

    const responseTsId =
        response.headers.get('ts-id') || '';

    let decoded = '';
    let parsed = null;
    let decryptError = null;

    if (responseTsId && raw.length) {
        try {
            decoded = decryptResponse(
                responseTsId,
                raw
            );

            try {
                parsed = JSON.parse(decoded);
            } catch (_) {
                parsed = null;
            }
        } catch (error) {
            decryptError = error.message;
        }
    }

    const resultObject =
        parsed &&
        parsed.result &&
        typeof parsed.result === 'object'
            ? parsed.result
            : null;

    /* APK logs distinguish accepted from a successful HTTP code. */
    const accepted =
        response.status >= 200 &&
        response.status < 300 &&
        resultObject &&
        Object.keys(resultObject).length === 0;

    return {
        cardId,
        setId,
        sendCounter,
        seed,
        httpStatus: response.status,
        accepted: Boolean(accepted),
        responseTsId,
        response: parsed,
        responseText:
            decoded ||
            (raw.length ? raw.toString('utf8') : ''),
        decryptError
    };
}

/* ------------------------------------------------------------
   ANALYZE BOTH FILES
------------------------------------------------------------ */

router.post('/analyze-files', (req, res) => {
    try {
        const body = getBody(req);

        const friendsXml =
            body.friendsXml ||
            body.bsXml ||
            body.bs;

        const cardsXml =
            body.cardsXml ||
            body.myXml;

        if (!friendsXml) {
            return res.status(400).json({
                ok: false,
                error: 'friendsXml is missing'
            });
        }

        if (!cardsXml) {
            return res.status(400).json({
                ok: false,
                error: 'cardsXml is missing'
            });
        }

        const friends = extractFriends(friendsXml);
        const inventory = extractCards(cardsXml);
        const meta = extractMeta(cardsXml);
        const config = extractGameConfig(friendsXml, cardsXml);

        return res.json({
            ok: true,
            meta,
            game: {
                cityId: config.ownCityId,
                bver: config.bver,
                fver: config.fver
            },
            friends,
            cards: inventory.cards,
            distinctCards: inventory.distinctCards,
            totalCopies: inventory.totalCopies,
            totalCards: inventory.totalCards
        });
    } catch (error) {
        console.error('[CARDS] analyze-files:', error);
        return res.status(400).json({
            ok: false,
            error: error.message
        });
    }
});

/* ------------------------------------------------------------
   SEND-ALL: COMPLETE OPERATION
------------------------------------------------------------ */

router.post('/send-all', async (req, res) => {
    try {
        const body = getBody(req);

        const friendsXml =
            body.friendsXml ||
            body.bsXml ||
            body.bs;

        const cardsXml =
            body.cardsXml ||
            body.myXml ||
            body.xml;

        if (!friendsXml) {
            return res.status(400).json({
                ok: false,
                error: 'friendsXml/bsXml is missing'
            });
        }

        if (!cardsXml) {
            return res.status(400).json({
                ok: false,
                error: 'cardsXml/myXml is missing'
            });
        }

        /* 1. Read the same auth/version material the APK uses. */
        const cfg = extractGameConfig(
            friendsXml,
            cardsXml
        );

        validateConfig(cfg);

        /* 2. Read friends from bs.xml. */
        const friends = extractFriends(
            friendsXml
        );

        /* 3. Read cards/counter from my.xml. */
        const inventory = extractCards(
            cardsXml
        );

        const meta = extractMeta(
            cardsXml
        );

        /* 4. Resolve selected friend. */
        let friend;

        if (
            body.friend &&
            typeof body.friend === 'object'
        ) {
            friend = {
                id: body.friend.id,
                name: body.friend.name || '',
                pic: body.friend.pic || ''
            };
        } else {
            friend = {
                id:
                    body.friendId ||
                    body.toCityId ||
                    body.to_cityId,
                name:
                    body.friendName ||
                    body.cityName ||
                    '',
                pic:
                    body.friendPic ||
                    body.pic ||
                    ''
            };
        }

        friend.id = s(friend.id).trim();
        friend.name = s(friend.name);
        friend.pic = s(friend.pic);

        if (!friend.id) {
            return res.status(400).json({
                ok: false,
                error: 'friendId is required'
            });
        }

        const known = friends.find(
            item => String(item.id) === String(friend.id)
        );

        if (!known) {
            return res.status(400).json({
                ok: false,
                error:
                    'Selected friend was not found in bs.xml'
            });
        }

        if (!friend.name) friend.name = known.name;
        if (!friend.pic) friend.pic = known.pic;

        /* 5. One request for every distinct owned card. */
        const ids = inventory.cards
            .map(card => card.cardId)
            .filter(Boolean);

        if (!ids.length) {
            return res.status(400).json({
                ok: false,
                error: 'No sendable cards found in my.xml'
            });
        }

        const startCounter = Number.isFinite(
            Number(meta.totalSendCards)
        )
            ? Number(meta.totalSendCards)
            : 0;

        const results = [];

        for (let i = 0; i < ids.length; i++) {
            const cardId = ids[i];
            const setId = collectionSetId(
                cardsXml,
                cardId
            );
            const sendCounter =
                startCounter + i;

            try {
                console.log('[CARDS] SEND', {
                    cardId,
                    setId,
                    friendId: friend.id,
                    sendCounter
                });

                const result = await sendOne(
                    cfg,
                    friend,
                    cardId,
                    setId,
                    sendCounter
                );

                results.push(result);

                console.log('[CARDS] RESULT', {
                    cardId: result.cardId,
                    status: result.httpStatus,
                    accepted: result.accepted
                });
            } catch (error) {
                results.push({
                    cardId,
                    setId,
                    sendCounter,
                    accepted: false,
                    error: error.message
                });
            }
        }

        const accepted = results.filter(
            item => item.accepted === true
        );

        const failed = results.filter(
            item => item.accepted !== true
        );

        /*
         * Important: the response contains the decoded response
         * returned by SendBox for every card. Nothing is fabricated
         * as a success response.
         */
        return res.json({
            ok: failed.length === 0,
            friend,
            game: {
                cityId: cfg.ownCityId,
                bver: cfg.bver,
                fver: cfg.fver
            },
            distinctCards: inventory.distinctCards,
            totalCopies: inventory.totalCopies,
            totalCards: ids.length,
            sentCards: accepted.length,
            failed: failed.length,
            totalSendCardsBefore: startCounter,
            totalSendCardsAfter:
                startCounter + ids.length,
            sentCardIds: accepted.map(
                item => item.cardId
            ),
            failedCards: failed,
            results
        });
    } catch (error) {
        console.error('[CARDS] send-all:', error);

        return res.status(400).json({
            ok: false,
            error: error.message
        });
    }
});

router.get('/health', (_req, res) => {
    res.json({
        ok: true,
        service: 'cardsApi',
        sendBox: SENDBOX
    });
});

module.exports = router;
