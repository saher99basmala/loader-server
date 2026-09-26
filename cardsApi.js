"use strict";

const express = require("express");
const { XMLParser } = require("fast-xml-parser");

const router = express.Router();

const parser = new XMLParser({
  ignoreAttributes: false,
  attributeNamePrefix: "@_",
  trimValues: false,
  parseTagValue: false,
  parseAttributeValue: false,
  arrayMode: false
});

// ============================================================
// Helpers
// ============================================================

function arr(value) {
  if (value == null) return [];
  return Array.isArray(value) ? value : [value];
}

function valueOf(value) {
  if (value == null) return "";

  if (typeof value === "object") {
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

// ============================================================
// Recursive search
// ============================================================

function findNamed(node, wantedName, out = []) {
  if (node == null) return out;

  if (Array.isArray(node)) {
    for (const item of node) {
      findNamed(item, wantedName, out);
    }
    return out;
  }

  if (typeof node !== "object") {
    return out;
  }

  for (const [key, value] of Object.entries(node)) {
    if (key === wantedName) {
      for (const item of arr(value)) {
        out.push(item);
      }
    }

    if (
      value &&
      typeof value === "object"
    ) {
      findNamed(value, wantedName, out);
    }
  }

  return out;
}

function fieldsOf(node) {
  if (!node || typeof node !== "object") {
    return {};
  }

  return node;
}

// ============================================================
// Find attribute from XML node
// ============================================================

function attr(node, ...names) {
  if (!node || typeof node !== "object") {
    return "";
  }

  for (const name of names) {
    const key = name.startsWith("@_")
      ? name
      : "@_" + name;

    if (node[key] != null) {
      return valueOf(node[key]);
    }

    if (node[name] != null) {
      return valueOf(node[name]);
    }
  }

  return "";
}

// ============================================================
// Cards
// ============================================================

function extractCards(root) {
  const ownedCardsNodes = findNamed(
    root,
    "OwnedCards"
  );

  const cards = [];

  for (const owned of ownedCardsNodes) {
    const cardNodes = findNamed(
      owned,
      "Card"
    );

    for (const card of cardNodes) {
      const cardId = attr(
        card,
        "cardId",
        "card_id",
        "id"
      );

      const inStockCount = Number(
        attr(
          card,
          "inStockCount",
          "in_stock_count"
        ) || 0
      );

      const generatedCount = Number(
        attr(
          card,
          "generatedCount",
          "generated_count"
        ) || 0
      );

      const maxInStockCount = Number(
        attr(
          card,
          "maxInStockCount",
          "max_in_stock_count"
        ) || 0
      );

      const isNewRaw = attr(
        card,
        "isNew",
        "is_new"
      );

      const isNew =
        isNewRaw === "1" ||
        isNewRaw === "true";

      if (!cardId) continue;

      cards.push({
        cardId: String(cardId),
        inStockCount,
        generatedCount,
        maxInStockCount,
        isNew
      });
    }
  }

  // Fallback:
  // بعض XML structures قد تكون Card مباشرة تحت OwnedCards
  if (cards.length === 0) {
    const allCards = findNamed(
      root,
      "Card"
    );

    for (const card of allCards) {
      const cardId = attr(
        card,
        "cardId",
        "card_id",
        "id"
      );

      const inStockCount = Number(
        attr(
          card,
          "inStockCount",
          "in_stock_count"
        ) || 0
      );

      if (!cardId) continue;

      cards.push({
        cardId: String(cardId),
        inStockCount,
        generatedCount: Number(
          attr(card, "generatedCount") || 0
        ),
        maxInStockCount: Number(
          attr(card, "maxInStockCount") || 0
        ),
        isNew:
          attr(card, "isNew") === "1"
      });
    }
  }

  // إزالة التكرار حسب cardId
  const map = new Map();

  for (const card of cards) {
    if (!map.has(card.cardId)) {
      map.set(card.cardId, {
        ...card
      });
    } else {
      const old = map.get(card.cardId);

      old.inStockCount +=
        Number(card.inStockCount || 0);

      old.generatedCount = Math.max(
        Number(old.generatedCount || 0),
        Number(card.generatedCount || 0)
      );

      old.maxInStockCount = Math.max(
        Number(old.maxInStockCount || 0),
        Number(card.maxInStockCount || 0)
      );

      old.isNew =
        old.isNew || card.isNew;
    }
  }

  return Array.from(map.values());
}

// ============================================================
// Generic value search
// ============================================================

function findValue(root, names) {
  const wanted = new Set(
    Array.isArray(names) ? names : [names]
  );

  function walk(node) {
    if (node == null) return null;

    if (Array.isArray(node)) {
      for (const item of node) {
        const result = walk(item);
        if (result != null) return result;
      }

      return null;
    }

    if (typeof node !== "object") {
      return null;
    }

    for (const [key, value] of Object.entries(node)) {
      const clean = key.startsWith("@_")
        ? key.substring(2)
        : key;

      if (wanted.has(clean)) {
        return valueOf(value);
      }

      if (
        value &&
        typeof value === "object"
      ) {
        const result = walk(value);

        if (result != null) {
          return result;
        }
      }
    }

    return null;
  }

  return walk(root);
}

// ============================================================
// Meta
// ============================================================

function extractMeta(root) {
  return {
    cityId:
      findValue(root, [
        "cityId",
        "city_id"
      ]) || "",

    gameId:
      findValue(root, [
        "gameId",
        "game_id"
      ]) || "",

    experience:
      typedValue(
        findValue(root, [
          "experience"
        ]) || ""
      )
  };
}

// ============================================================
// Friends
// ============================================================

function extractFriends(root) {
  const friendNodes = findNamed(
    root,
    "friend"
  );

  const friends = [];

  const seen = new Set();

  for (const friend of friendNodes) {
    if (
      !friend ||
      typeof friend !== "object"
    ) {
      continue;
    }

    const cityId = String(
      attr(
        friend,
        "city_id",
        "cityId",
        "id",
        "friend_id",
        "friendId"
      ) || ""
    );

    if (!cityId) {
      continue;
    }

    if (seen.has(cityId)) {
      continue;
    }

    seen.add(cityId);

    const cityName = String(
      attr(
        friend,
        "city_name",
        "cityName"
      ) || ""
    );

    const rawName = String(
      attr(
        friend,
        "name"
      ) || ""
    );

    const levelRaw = attr(
      friend,
      "level"
    );

    const xpRaw = attr(
      friend,
      "xp"
    );

    const pic = String(
      attr(
        friend,
        "pic"
      ) || ""
    );

    const level =
      levelRaw === ""
        ? null
        : Number(levelRaw);

    const xp =
      xpRaw === ""
        ? null
        : Number(xpRaw);

    // في XML الحالي name غالباً فارغ،
    // لذلك city_name هو الاسم المعروض.
    const displayName =
      cityName ||
      rawName ||
      cityId;

    friends.push({
      id: cityId,
      cityId: cityId,

      name: displayName,
      cityName: cityName,

      level:
        Number.isFinite(level)
          ? level
          : null,

      xp:
        Number.isFinite(xp)
          ? xp
          : null,

      pic: pic
    });
  }

  return friends;
}

// ============================================================
// Get XML
// ============================================================

function getXml(req) {
  if (
    req.body &&
    typeof req.body.xml === "string"
  ) {
    return req.body.xml;
  }

  if (
    req.body &&
    typeof req.body.myXml === "string"
  ) {
    return req.body.myXml;
  }

  return "";
}

// ============================================================
// Make Send Job
// ============================================================

function makeJob(xml, friend, cards) {
  return {
    type: "send_all_cards",

    friend: {
      id:
        friend.id ||
        friend.cityId,

      cityId:
        friend.cityId ||
        friend.id,

      name:
        friend.name ||
        friend.cityName ||
        "",

      cityName:
        friend.cityName ||
        friend.name ||
        "",

      level:
        friend.level,

      xp:
        friend.xp,

      pic:
        friend.pic || ""
    },

    cards: cards.map(card => ({
      cardId: card.cardId,
      quantity: Number(
        card.inStockCount || 0
      ),

      inStockCount: Number(
        card.inStockCount || 0
      ),

      generatedCount: Number(
        card.generatedCount || 0
      ),

      maxInStockCount: Number(
        card.maxInStockCount || 0
      ),

      isNew: !!card.isNew
    })),

    totalCards:
      cards.reduce(
        (sum, card) =>
          sum +
          Number(card.inStockCount || 0),
        0
      )
  };
}

// ============================================================
// Authorized Sender
// ============================================================

async function sendAuthorized(job) {
  const url =
    process.env.CARD_SEND_URL || "";

  const token =
    process.env.CARD_SEND_TOKEN || "";

  // Preview mode إذا لم يتم ضبط endpoint
  if (!url) {
    return {
      success: true,

      mode: "preview",

      message:
        "CARD_SEND_URL غير مضبوط؛ تم إنشاء مهمة الإرسال فقط.",

      friend: job.friend,

      totalCards:
        job.totalCards,

      cardsFound:
        job.cards.length,

      sent: 0,

      created: 0,

      failed: 0,

      notFound: 0,

      job
    };
  }

  const headers = {
    "Content-Type":
      "application/json",

    "Accept":
      "application/json"
  };

  if (token) {
    headers.Authorization =
      "Bearer " + token;
  }

  const response =
    await fetch(
      url,
      {
        method: "POST",
        headers,
        body: JSON.stringify(job)
      }
    );

  const text =
    await response.text();

  let data;

  try {
    data = JSON.parse(text);
  } catch (_) {
    data = {
      raw: text
    };
  }

  if (!response.ok) {
    return {
      success: false,

      mode: "authorized",

      status:
        response.status,

      message:
        "CARD_SEND_URL returned HTTP " +
        response.status,

      response: data,

      friend: job.friend,

      totalCards:
        job.totalCards,

      cardsFound:
        job.cards.length
    };
  }

  return {
    success: true,

    mode: "authorized",

    friend:
      data.friend ||
      job.friend,

    totalCards:
      data.totalCards != null
        ? data.totalCards
        : job.totalCards,

    cardsFound:
      data.cardsFound != null
        ? data.cardsFound
        : job.cards.length,

    sent:
      data.sent != null
        ? data.sent
        : data.sentCards != null
          ? data.sentCards
          : 0,

    sentCards:
      data.sentCards != null
        ? data.sentCards
        : data.sent != null
          ? data.sent
          : 0,

    created:
      data.created != null
        ? data.created
        : 0,

    failed:
      data.failed != null
        ? data.failed
        : 0,

    notFound:
      data.notFound != null
        ? data.notFound
        : 0,

    response: data
  };
}

// ============================================================
// POST /analyze
// ============================================================

router.post(
  "/analyze",
  (req, res) => {
    try {
      const xml = getXml(req);

      if (!xml) {
        return res.status(400).json({
          success: false,
          error:
            "XML is required"
        });
      }

      const root =
        parser.parse(xml);

      const meta =
        extractMeta(root);

      const friends =
        extractFriends(root);

      const cards =
        extractCards(root);

      const activeCards =
        cards.filter(
          card =>
            Number(
              card.inStockCount || 0
            ) > 0
        );

      const totalCards =
        activeCards.reduce(
          (sum, card) =>
            sum +
            Number(
              card.inStockCount || 0
            ),
          0
        );

      return res.json({
        success: true,

        meta,

        friends,

        cards: activeCards,

        distinctCards:
          activeCards.length,

        totalCards
      });

    } catch (error) {
      console.error(
        "[CARDS] analyze error:",
        error
      );

      return res.status(500).json({
        success: false,

        error:
          error.message ||
          String(error)
      });
    }
  }
);

// ============================================================
// POST /send-all
// ============================================================

router.post(
  "/send-all",
  async (req, res) => {
    try {
      const xml =
        getXml(req);

      if (!xml) {
        return res.status(400).json({
          success: false,
          error:
            "XML is required"
        });
      }

      const root =
        parser.parse(xml);

      const friends =
        extractFriends(root);

      const cards =
        extractCards(root);

      const activeCards =
        cards.filter(
          card =>
            Number(
              card.inStockCount || 0
            ) > 0
        );

      // --------------------------------------------------------
      // Resolve friend
      // --------------------------------------------------------

      const requestedFriendId =
        req.body.friendId ||
        req.body.friend_id ||
        (
          req.body.friend &&
          (
            req.body.friend.id ||
            req.body.friend.cityId ||
            req.body.friend.city_id
          )
        );

      if (!requestedFriendId) {
        return res.status(400).json({
          success: false,
          error:
            "friendId is required"
        });
      }

      const friend =
        friends.find(
          item =>
            String(item.id) ===
            String(requestedFriendId)
        );

      if (!friend) {
        return res.status(404).json({
          success: false,
          error:
            "Friend not found in XML",

          friendId:
            requestedFriendId,

          availableFriends:
            friends
        });
      }

      // --------------------------------------------------------
      // Build one job containing ALL cards
      // --------------------------------------------------------

      const job =
        makeJob(
          xml,
          friend,
          activeCards
        );

      console.log(
        "[CARDS] Send all:",
        {
          friend:
            friend.cityName ||
            friend.name,

          cityId:
            friend.cityId,

          level:
            friend.level,

          xp:
            friend.xp,

          pic:
            friend.pic,

          distinctCards:
            activeCards.length,

          totalCards:
            job.totalCards
        }
      );

      // --------------------------------------------------------
      // Send through configured authorized endpoint
      // --------------------------------------------------------

      const result =
        await sendAuthorized(
          job
        );

      return res.json({
        ...result,

        success:
          result.success !== false,

        friend: result.friend || {
          id: friend.id,
          cityId: friend.cityId,
          name: friend.name,
          cityName: friend.cityName,
          level: friend.level,
          xp: friend.xp,
          pic: friend.pic
        }
      });

    } catch (error) {
      console.error(
        "[CARDS] send-all error:",
        error
      );

      return res.status(500).json({
        success: false,

        error:
          error.message ||
          String(error)
      });
    }
  }
);

module.exports = router;
