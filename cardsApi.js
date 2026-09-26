// cardsApi.js
"use strict";

const express = require("express");
const { XMLParser } = require("fast-xml-parser");

const router = express.Router();

const parser = new XMLParser({
  ignoreAttributes: false,
  attributeNamePrefix: "@_",
  trimValues: false,
  parseTagValue: false,
  parseAttributeValue: false
});

function arr(value) {
  if (value == null) return [];
  return Array.isArray(value) ? value : [value];
}

function valueOf(value) {
  if (value == null) return "";
  if (typeof value === "object") {
    if (value["@_value"] != null) return value["@_value"];
    if (value["@_v"] != null) return value["@_v"];
    if (value["#text"] != null) return value["#text"];
  }
  return value;
}

function typedValue(value) {
  const v = valueOf(value);
  if (v === "") return "";
  if (typeof v === "number") return v;
  if (typeof v === "string") {
    if (/^-?\d+$/.test(v)) return Number(v);
    if (/^-?\d+\.\d+$/.test(v)) return Number(v);
  }
  return v;
}

function findNamed(node, wantedName, out = []) {
  if (node == null) return out;

  if (Array.isArray(node)) {
    for (const item of node) findNamed(item, wantedName, out);
    return out;
  }

  if (typeof node !== "object") return out;

  for (const [key, value] of Object.entries(node)) {
    if (key === wantedName) {
      for (const item of arr(value)) out.push(item);
    }
    if (value && typeof value === "object") {
      findNamed(value, wantedName, out);
    }
  }

  return out;
}

function findValue(root, names) {
  const wanted = new Set(Array.isArray(names) ? names : [names]);

  function walk(node) {
    if (node == null) return null;

    if (Array.isArray(node)) {
      for (const item of node) {
        const result = walk(item);
        if (result != null) return result;
      }
      return null;
    }

    if (typeof node !== "object") return null;

    for (const [key, value] of Object.entries(node)) {
      const clean = key.startsWith("@_") ? key.slice(2) : key;

      if (wanted.has(clean)) {
        return valueOf(value);
      }

      if (value && typeof value === "object") {
        const result = walk(value);
        if (result != null) return result;
      }
    }

    return null;
  }

  return walk(root);
}

function findDataElemsByName(node, wantedName, result = []) {
  if (node == null) return result;

  if (Array.isArray(node)) {
    for (const item of node) {
      findDataElemsByName(item, wantedName, result);
    }
    return result;
  }

  if (typeof node !== "object") return result;

  if (node["@_name"] === wantedName) {
    result.push(node);
  }

  for (const value of Object.values(node)) {
    if (value && typeof value === "object") {
      findDataElemsByName(value, wantedName, result);
    }
  }

  return result;
}

function getDataElemValue(node, wantedName) {
  const matches = findDataElemsByName(node, wantedName, []);
  if (!matches.length) return "";
  return String(matches[0]["@_value"] ?? "");
}

// ============================================================
// REAL Township OwnedCards structure:
// DataElem name="OwnedCards" type="array"
//   -> DataElem type="dataStore"
//      -> DataElem name="cardId" value="card_03"
//      -> DataElem name="inStockCount" value="4"
// ============================================================

function extractCards(root) {
  const cards = [];
  const ownedCardsArrays = findDataElemsByName(root, "OwnedCards", []);

  for (const ownedCardsArray of ownedCardsArrays) {
    let entries = ownedCardsArray.DataElem;
    if (!entries) continue;
    if (!Array.isArray(entries)) entries = [entries];

    for (const entry of entries) {
      if (!entry || typeof entry !== "object") continue;
      if (entry["@_type"] !== "dataStore") continue;

      const cardId = getDataElemValue(entry, "cardId");
      if (!cardId) continue;

      const generatedCount = Number(getDataElemValue(entry, "generatedCount") || 0);
      const inStockCount = Number(getDataElemValue(entry, "inStockCount") || 0);
      const maxInStockCount = Number(getDataElemValue(entry, "maxInStockCount") || 0);
      const isNewValue = getDataElemValue(entry, "isNew");

      cards.push({
        cardId: String(cardId),
        generatedCount,
        inStockCount,
        maxInStockCount,
        isNew: isNewValue === "true" || isNewValue === "1"
      });
    }
  }

  const map = new Map();

  for (const card of cards) {
    if (!map.has(card.cardId)) {
      map.set(card.cardId, { ...card });
    } else {
      const old = map.get(card.cardId);
      old.inStockCount += card.inStockCount;
      old.generatedCount = Math.max(old.generatedCount, card.generatedCount);
      old.maxInStockCount = Math.max(old.maxInStockCount, card.maxInStockCount);
      old.isNew = old.isNew || card.isNew;
    }
  }

  const result = Array.from(map.values());

  console.log("[CARDS] distinct:", result.length);
  console.log(
    "[CARDS] total in stock:",
    result.reduce((sum, card) => sum + Number(card.inStockCount || 0), 0)
  );

  return result;
}

function extractMeta(root) {
  return {
    cityId: findValue(root, ["cityId", "city_id"]) || "",
    gameId: findValue(root, ["gameId", "game_id"]) || "",
    experience: typedValue(findValue(root, ["experience"]) || "")
  };
}

function extractFriends(root) {
  const friendNodes = findNamed(root, "friend");
  const friends = [];
  const seen = new Set();

  for (const friend of friendNodes) {
    if (!friend || typeof friend !== "object") continue;

    const cityId = String(
      friend["@_city_id"] ??
      friend["@_cityId"] ??
      friend["@_id"] ??
      friend["@_friend_id"] ??
      friend["@_friendId"] ??
      ""
    );

    if (!cityId || seen.has(cityId)) continue;
    seen.add(cityId);

    const cityName = String(
      friend["@_city_name"] ??
      friend["@_cityName"] ??
      ""
    );

    const rawName = String(friend["@_name"] ?? "");

    const levelRaw = friend["@_level"];
    const xpRaw = friend["@_xp"];

    const level = levelRaw === undefined || levelRaw === "" ? null : Number(levelRaw);
    const xp = xpRaw === undefined || xpRaw === "" ? null : Number(xpRaw);

    const pic = String(friend["@_pic"] ?? "");

    friends.push({
      id: cityId,
      cityId,
      name: cityName || rawName || cityId,
      cityName,
      level: Number.isFinite(level) ? level : null,
      xp: Number.isFinite(xp) ? xp : null,
      pic
    });
  }

  return friends;
}

function getXml(req) {
  if (req.body && typeof req.body.xml === "string") return req.body.xml;
  if (req.body && typeof req.body.myXml === "string") return req.body.myXml;
  return "";
}

function makeJob(friend, cards) {
  return {
    type: "send_all_cards",
    friend: {
      id: friend.id,
      cityId: friend.cityId,
      name: friend.name,
      cityName: friend.cityName,
      level: friend.level,
      xp: friend.xp,
      pic: friend.pic
    },
    cards: cards.map(card => ({
      cardId: card.cardId,
      quantity: Number(card.inStockCount || 0),
      inStockCount: Number(card.inStockCount || 0),
      generatedCount: Number(card.generatedCount || 0),
      maxInStockCount: Number(card.maxInStockCount || 0),
      isNew: !!card.isNew
    })),
    totalCards: cards.reduce(
      (sum, card) => sum + Number(card.inStockCount || 0),
      0
    )
  };
}

async function sendAuthorized(job) {
  const url = process.env.CARD_SEND_URL || "";
  const token = process.env.CARD_SEND_TOKEN || "";

  if (!url) {
    return {
      success: true,
      mode: "preview",
      message: "CARD_SEND_URL غير مضبوط؛ تم إنشاء مهمة الإرسال فقط.",
      friend: job.friend,
      totalCards: job.totalCards,
      cardsFound: job.cards.length,
      sent: 0,
      sentCards: 0,
      created: 0,
      failed: 0,
      notFound: 0,
      job
    };
  }

  const headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  if (token) headers.Authorization = "Bearer " + token;

  const response = await fetch(url, {
    method: "POST",
    headers,
    body: JSON.stringify(job)
  });

  const text = await response.text();

  let data;
  try {
    data = JSON.parse(text);
  } catch (_) {
    data = { raw: text };
  }

  if (!response.ok) {
    return {
      success: false,
      mode: "authorized",
      status: response.status,
      message: "CARD_SEND_URL returned HTTP " + response.status,
      response: data,
      friend: job.friend,
      totalCards: job.totalCards,
      cardsFound: job.cards.length
    };
  }

  return {
    success: true,
    mode: "authorized",
    friend: data.friend || job.friend,
    totalCards: data.totalCards ?? job.totalCards,
    cardsFound: data.cardsFound ?? job.cards.length,
    sent: data.sent ?? data.sentCards ?? 0,
    sentCards: data.sentCards ?? data.sent ?? 0,
    created: data.created ?? 0,
    failed: data.failed ?? 0,
    notFound: data.notFound ?? 0,
    response: data
  };
}

// ============================================================
// POST /analyze
// ============================================================

router.post("/analyze", (req, res) => {
  try {
    const xml = getXml(req);

    if (!xml) {
      return res.status(400).json({
        success: false,
        error: "XML is required"
      });
    }

    const root = parser.parse(xml);
    const meta = extractMeta(root);
    const friends = extractFriends(root);
    const cards = extractCards(root);

    const activeCards = cards.filter(
      card => Number(card.inStockCount || 0) > 0
    );

    const totalCards = activeCards.reduce(
      (sum, card) => sum + Number(card.inStockCount || 0),
      0
    );

    console.log("[CARDS] analyze:", {
      friends: friends.length,
      distinctCards: activeCards.length,
      totalCards
    });

    return res.json({
      success: true,
      meta,
      friends,
      cards: activeCards,
      distinctCards: activeCards.length,
      totalCards
    });
  } catch (error) {
    console.error("[CARDS] analyze error:", error);

    return res.status(500).json({
      success: false,
      error: error.message || String(error)
    });
  }
});

// ============================================================
// POST /send-all
// ============================================================

router.post("/send-all", async (req, res) => {
  try {
    const xml = getXml(req);

    if (!xml) {
      return res.status(400).json({
        success: false,
        error: "XML is required"
      });
    }

    const root = parser.parse(xml);
    const friends = extractFriends(root);
    const cards = extractCards(root);

    const activeCards = cards.filter(
      card => Number(card.inStockCount || 0) > 0
    );

    const requestedFriendId =
      req.body.friendId ||
      req.body.friend_id ||
      (req.body.friend &&
        (req.body.friend.id ||
          req.body.friend.cityId ||
          req.body.friend.city_id));

    if (!requestedFriendId) {
      return res.status(400).json({
        success: false,
        error: "friendId is required"
      });
    }

    const friend = friends.find(
      item => String(item.id) === String(requestedFriendId)
    );

    if (!friend) {
      return res.status(404).json({
        success: false,
        error: "Friend not found in XML",
        friendId: requestedFriendId,
        availableFriends: friends
      });
    }

    if (activeCards.length === 0) {
      return res.status(400).json({
        success: false,
        error: "No cards with inStockCount > 0 were found in OwnedCards",
        cardsDetected: cards.length,
        totalCards: 0
      });
    }

    const job = makeJob(friend, activeCards);

    console.log("[CARDS] send-all:", {
      friend: friend.cityName || friend.name,
      cityId: friend.cityId,
      level: friend.level,
      xp: friend.xp,
      pic: friend.pic,
      distinctCards: activeCards.length,
      totalCards: job.totalCards
    });

    const result = await sendAuthorized(job);

    return res.json({
      ...result,
      success: result.success !== false,
      friend: result.friend || friend
    });
  } catch (error) {
    console.error("[CARDS] send-all error:", error);

    return res.status(500).json({
      success: false,
      error: error.message || String(error)
    });
  }
});

module.exports = router;
