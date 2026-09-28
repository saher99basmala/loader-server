"use strict";

const express = require("express");
const zlib = require("zlib");
const crypto = require("crypto");

const router = express.Router();

const SEND_BOX_BASE =
  "https://township.playrix.com/api/1/SendBox?cityId=";

const AES_KEY = Buffer.from("Wucai6oj0sheiX3p", "utf8");

/*
  Verified from the APK:
  - SendBox endpoint
  - application/octet-stream
  - box_type = collections_send_card
  - friend_type = send_friend
  - fields: box_type, card_id, col_et, col_id,
    friend_type, from, seed, sendCounter, set_id, to, type
  - AES-128-GCM key literal used by the APK.

  The XML parser below extracts the values that are actually
  present in the supplied save. It deliberately does NOT invent
  missing live session values such as ts-token.
*/

function escRe(s) {
  return String(s).replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function unesc(s) {
  return String(s ?? "")
    .replace(/&quot;/g, '"')
    .replace(/&apos;/g, "'")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&amp;/g, "&");
}

function getVar(xml, name) {
  const re = new RegExp(
    '<Var\\s[^>]*name="' + escRe(name) + '"[^>]*v="([^"]*)"',
    "i"
  );
  const m = String(xml).match(re);
  return m ? unesc(m[1]) : null;
}

function all(regex, text) {
  const out = [];
  let m;
  regex.lastIndex = 0;
  while ((m = regex.exec(text)) !== null) out.push(m);
  return out;
}

function parseOwnedCards(xml) {
  const text = String(xml);
  const result = [];

  const blockRe =
    /<DataElem\s+name="OwnedCards"\s+type="dataStore">(.*?)<\/DataElem>/gis;

  const blocks = all(blockRe, text);

  for (const block of blocks) {
    const inner = block[1];

    const elemRe =
      /<DataElem\s+name="cardId"\s+type="string"\s+value="([^"]+)"\s*\/>\s*<DataElem\s+name="generatedCount"\s+type="int"\s+value="(-?\d+)"\s*\/>\s*<DataElem\s+name="inStockCount"\s+type="int"\s+value="(-?\d+)"\s*\/>\s*<DataElem\s+name="isNew"\s+type="bool"\s+value="([^"]+)"\s*\/>\s*<DataElem\s+name="maxInStockCount"\s+type="int"\s+value="(-?\d+)"/gis;

    for (const m of all(elemRe, inner)) {
      const inStock = Number(m[3]);

      if (inStock > 0) {
        result.push({
          cardId: unesc(m[1]),
          generatedCount: Number(m[2]),
          inStockCount: inStock,
          isNew: String(m[4]).toLowerCase() === "true" || m[4] === "1",
          maxInStockCount: Number(m[5])
        });
      }
    }
  }

  /*
    Fallback for saves where attributes are separated by other fields.
  */
  if (!result.length) {
    const generic =
      /<DataElem\s+name="cardId"\s+type="string"\s+value="([^"]+)"\s*\/>([\s\S]{0,800}?)<DataElem\s+name="inStockCount"\s+type="int"\s+value="(-?\d+)"/gi;

    for (const m of all(generic, text)) {
      const n = Number(m[3]);
      if (n > 0) {
        result.push({
          cardId: unesc(m[1]),
          generatedCount: null,
          inStockCount: n,
          isNew: null,
          maxInStockCount: null
        });
      }
    }
  }

  const map = new Map();

  for (const c of result) {
    if (!map.has(c.cardId)) {
      map.set(c.cardId, { ...c });
    } else {
      map.get(c.cardId).inStockCount += c.inStockCount;
      if (c.generatedCount != null)
        map.get(c.cardId).generatedCount =
          (map.get(c.cardId).generatedCount || 0) + c.generatedCount;
    }
  }

  return [...map.values()];
}

function parseFriends(xml) {
  const text = String(xml);
  const friends = [];

  /*
    FriendsList entries differ slightly between save versions.
    We first locate friend blocks and then read common fields.
  */
  const listBlocks = all(
    /<DataElem\s+name="FriendsList"\s+type="dataStore">([\s\S]*?)<\/DataElem>/gi,
    text
  );

  const source = listBlocks.length ? listBlocks.map(x => x[1]).join("\n") : text;

  const friendBlocks = all(
    /<DataElem\s+name="([^"]+)"\s+type="dataStore">([\s\S]*?)<\/DataElem>/gi,
    source
  );

  for (const b of friendBlocks) {
    const inner = b[2];

    const city =
      (inner.match(/name="cityId"[^>]*value="([^"]+)"/i) || [])[1] ||
      (inner.match(/name="city_id"[^>]*value="([^"]+)"/i) || [])[1];

    if (!city) continue;

    const name =
      (inner.match(/name="name"[^>]*value="([^"]+)"/i) || [])[1] ||
      (inner.match(/name="cityName"[^>]*value="([^"]+)"/i) || [])[1] ||
      b[1];

    const pic =
      (inner.match(/name="MyPicture"[^>]*value="([^"]+)"/i) || [])[1] ||
      (inner.match(/name="pic"[^>]*value="([^"]+)"/i) || [])[1] ||
      "";

    const level =
      (inner.match(/name="level"[^>]*value="(-?\d+)"/i) || [])[1] || null;

    const xp =
      (inner.match(/name="experience"[^>]*value="(-?\d+)"/i) || [])[1] ||
      null;

    friends.push({
      id: unesc(city),
      cityId: unesc(city),
      name: unesc(name),
      pic: unesc(pic),
      level: level == null ? null : Number(level),
      xp: xp == null ? null : Number(xp)
    });
  }

  const unique = new Map();

  for (const f of friends) {
    if (!unique.has(f.cityId)) unique.set(f.cityId, f);
  }

  return [...unique.values()];
}

function parseCollectionData(xml) {
  const text = String(xml);

  const configId =
    (text.match(
      /<DataElem\s+name="configId"\s+type="string"\s+value="CardCollections_(\d+)"/i
    ) || [])[1] || null;

  const pinned =
    (text.match(
      /<DataElem\s+name="pinnedCardCollectionsBalanceId"\s+type="string"\s+value="CardC(\d+)_Balance"/i
    ) || [])[1] || null;

  const collectionId =
    (text.match(
      /<DataElem\s+name="first"\s+type="string"\s+value="collectionId"\s*\/>\s*<DataElem\s+name="second"\s+type="string"\s+value="(\d+)"/i
    ) || [])[1] || null;

  const lastSeen = {};

  const progressBlock =
    (text.match(
      /<DataElem\s+name="LastSeenSetProgress"\s+type="dataStore">([\s\S]*?)<\/DataElem>/i
    ) || [])[1] || "";

  for (const m of all(
    /<DataElem\s+name="(set_\d+)"\s+type="int"\s+value="(-?\d+)"\s*\/>/gi,
    progressBlock
  )) {
    lastSeen[m[1]] = Number(m[2]);
  }

  return {
    configId,
    pinnedCollection: pinned,
    collectionId,
    lastSeenSetProgress: lastSeen
  };
}

function analyze(xml) {
  const cards = parseOwnedCards(xml);
  const friends = parseFriends(xml);
  const collections = parseCollectionData(xml);

  return {
    success: true,
    friends,
    cards,
    distinctCards: cards.length,
    totalCards: cards.reduce((n, c) => n + c.inStockCount, 0),
    collections,
    cityId: getVar(xml, "cityId"),
    gameId: getVar(xml, "gameId"),
    experience: getVar(xml, "experience"),
    townName: getVar(xml, "townName")
  };
}

/*
  These are the five values whose final arithmetic/dataflow was
  not proven completely from LC/i->I in the available source.
  The function maps only values directly supported by XML and
  refuses to fabricate the remaining values.
*/
function buildCardRecord(card, context) {
  return {
    box_type: "collections_send_card",
    card_id: card.cardId,
    col_et: context.col_et ?? null,
    col_id: context.col_id ?? context.collectionId ?? null,
    friend_type: "send_friend",
    from: context.from ?? null,
    seed: context.seed ?? null,
    sendCounter: context.sendCounter ?? null,
    set_id: context.set_id ?? null,
    to: context.to ?? null,
    type: context.type ?? null
  };
}

function encodeSendPayload(records) {
  /*
    APK crypto path confirmed:
    UTF-8 -> GZIP -> AES/GCM/NoPadding
    random 12-byte IV
    128-bit authentication tag.
  */
  const json = JSON.stringify(records);
  const gz = zlib.gzipSync(Buffer.from(json, "utf8"));

  const iv = crypto.randomBytes(12);
  const cipher = crypto.createCipheriv("aes-128-gcm", AES_KEY, iv);
  const encrypted = Buffer.concat([
    cipher.update(gz),
    cipher.final()
  ]);

  const tag = cipher.getAuthTag();

  return {
    iv,
    encrypted,
    tag,
    raw: Buffer.concat([iv, encrypted, tag])
  };
}

async function postRaw(url, body, headers = {}) {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), 30000);

  try {
    const response = await fetch(url, {
      method: "POST",
      headers,
      body,
      signal: controller.signal
    });

    const text = await response.text();

    return {
      status: response.status,
      ok: response.ok,
      text
    };
  } finally {
    clearTimeout(timer);
  }
}

router.post("/analyze", express.json({ limit: "25mb" }), (req, res) => {
  try {
    const xml = req.body?.myXml;

    if (!xml || typeof xml !== "string") {
      return res.status(400).json({
        success: false,
        error: "myXml is required"
      });
    }

    return res.json(analyze(xml));
  } catch (e) {
    return res.status(500).json({
      success: false,
      error: String(e?.message || e)
    });
  }
});

router.post("/send-all", express.json({ limit: "25mb" }), async (req, res) => {
  try {
    const xml = req.body?.myXml;
    const friendId =
      req.body?.friendId ||
      req.body?.friend?.cityId ||
      req.body?.friend?.id;

    if (!xml || typeof xml !== "string") {
      return res.status(400).json({
        success: false,
        error: "myXml is required"
      });
    }

    if (!friendId) {
      return res.status(400).json({
        success: false,
        error: "friendId is required"
      });
    }

    const parsed = analyze(xml);

    const friend =
      parsed.friends.find(
        f => String(f.cityId) === String(friendId)
      ) || {
        cityId: String(friendId),
        id: String(friendId),
        name: String(friendId),
        pic: ""
      };

    /*
      Do not silently invent the five unresolved values.
      Return the complete analysis so the caller can see exactly
      what was extracted.
    */
    const unresolved = parsed.cards.filter(c => {
      const r = buildCardRecord(c, {
        collectionId: parsed.collections.collectionId,
        to: friend.cityId
      });

      return (
        r.col_et == null ||
        r.seed == null ||
        r.sendCounter == null ||
        r.set_id == null
      );
    }).length;

    if (unresolved > 0) {
      return res.status(422).json({
        success: false,
        mode: "analysis-only",
        error:
          "The APK-derived five-field dataflow is not fully resolved; refusing to fabricate SendBox values.",
        friend,
        distinctCards: parsed.distinctCards,
        totalCards: parsed.totalCards,
        unresolvedCards: unresolved,
        collections: parsed.collections,
        cards: parsed.cards
      });
    }

    const session = req.body?.session || {};

    if (!session.token) {
      return res.status(400).json({
        success: false,
        error: "Live ts-token is required for an authorized SendBox request."
      });
    }

    const records = parsed.cards.map(card =>
      buildCardRecord(card, {
        ...req.body?.payloadContext,
        to: friend.cityId
      })
    );

    const encoded = encodeSendPayload(records);

    const cityId =
      session.cityId ||
      parsed.cityId;

    if (!cityId) {
      return res.status(400).json({
        success: false,
        error: "cityId is required."
      });
    }

    const headers = {
      "Content-Type": "application/octet-stream",
      "Accept": "*/*",
      "IsNewClanUIEnabled": "true",
      "User-Agent":
        session.userAgent ||
        "okhttp/4.9.3",
      "ts-bp": session.tsBp || "g",
      "ts-bver": session.tsBver || "",
      "ts-fver": session.tsFver || "",
      "ts-gpid": "new",
      "ts-token": session.token,
      "x-version": session.xVersion || ""
    };

    const response = await postRaw(
      SEND_BOX_BASE + encodeURIComponent(cityId),
      encoded.raw,
      headers
    );

    return res.status(response.ok ? 200 : 502).json({
      success: response.ok,
      mode: "sendbox",
      friend,
      distinctCards: parsed.distinctCards,
      totalCards: parsed.totalCards,
      sentCards: response.ok ? parsed.totalCards : 0,
      httpCode: response.status,
      serverResponse: response.text
    });
  } catch (e) {
    return res.status(500).json({
      success: false,
      error: String(e?.message || e)
    });
  }
});

module.exports = router;
