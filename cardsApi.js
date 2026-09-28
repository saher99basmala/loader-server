const express = require("express");
const { XMLParser } = require("fast-xml-parser");

const router = express.Router();

const parser = new XMLParser({
  ignoreAttributes: false,
  attributeNamePrefix: "@_",
  textNodeName: "#text",
  trimValues: false,
});

function attr(node, name, fallback = "") {
  if (!node || typeof node !== "object") return fallback;
  return node[`@_${name}`] ?? fallback;
}

function parseXml(xml) {
  if (typeof xml !== "string" || !xml.trim()) {
    throw new Error("myXml is empty");
  }

  return parser.parse(xml);
}

function walk(node, callback, path = []) {
  if (node == null) return;

  if (Array.isArray(node)) {
    node.forEach((item, i) => {
      walk(item, callback, path.concat(i));
    });
    return;
  }

  if (typeof node !== "object") return;

  callback(node, path);

  for (const [key, value] of Object.entries(node)) {
    if (key.startsWith("@_")) continue;
    walk(value, callback, path.concat(key));
  }
}

function findNodesByName(root, name) {
  const result = [];

  walk(root, (node, path) => {
    const last = path[path.length - 1];

    if (last === name) {
      result.push(node);
    }
  });

  return result;
}

function findFirstByName(root, name) {
  const nodes = findNodesByName(root, name);
  return nodes.length ? nodes[0] : null;
}

function collectVars(root) {
  const result = [];

  walk(root, (node) => {
    const name = attr(node, "name");

    if (name) {
      result.push({
        name,
        value: attr(node, "v", attr(node, "value", "")),
        node,
      });
    }
  });

  return result;
}

function getVar(root, name, fallback = "") {
  const vars = collectVars(root);

  const item = vars.find((v) => v.name === name);

  return item ? item.value : fallback;
}

function toInt(value, fallback = 0) {
  const n = Number.parseInt(String(value ?? ""), 10);

  return Number.isFinite(n) ? n : fallback;
}

/* ============================================================
   CARDS
   ============================================================ */

function findOwnedCards(root) {
  const owned = findFirstByName(root, "OwnedCards");

  if (!owned) {
    return [];
  }

  const candidates = [];

  walk(owned, (node, path) => {
    const cardId = attr(node, "cardId");
    const inStock = attr(node, "inStockCount");

    if (cardId !== "" && inStock !== "") {
      candidates.push({
        cardId: String(cardId),

        generatedCount: toInt(
          attr(node, "generatedCount"),
          0
        ),

        inStockCount: toInt(
          inStock,
          0
        ),

        isNew: String(
          attr(node, "isNew", "false")
        ),

        maxInStockCount: toInt(
          attr(node, "maxInStockCount"),
          0
        ),

        path,
      });
    }
  });

  const map = new Map();

  for (const card of candidates) {
    const old = map.get(card.cardId);

    if (!old) {
      map.set(card.cardId, {
        cardId: card.cardId,
        generatedCount: card.generatedCount,
        inStockCount: card.inStockCount,
        isNew: card.isNew,
        maxInStockCount: card.maxInStockCount,
      });
    } else {
      old.generatedCount += card.generatedCount;
      old.inStockCount += card.inStockCount;

      old.maxInStockCount = Math.max(
        old.maxInStockCount,
        card.maxInStockCount
      );
    }
  }

  return Array.from(map.values());
}

/* ============================================================
   FRIENDS
   ============================================================ */

/*
 * مهم:
 *
 * ملف XML يحتوي على:
 *
 * <friend
 *     city_id="..."
 *     city_name="..."
 *     pic="..."
 *     ...
 * />
 *
 * لذلك لا نعتمد فقط على FriendsList.
 */

function findFriendsFromXml(xml) {
  const result = [];
  const seen = new Set();

  /*
   * نقرأ friend مباشرة من النص الأصلي.
   * هذا أكثر أمانًا مع XML الخاص باللعبة.
   */

  const friendRegex = /<friend\b([^>]*?)\/?>/gi;

  let match;

  while ((match = friendRegex.exec(xml)) !== null) {
    const attrs = match[1] || "";

    function getAttr(name) {
      const regex = new RegExp(
        `\\b${name}\\s*=\\s*["']([^"']*)["']`,
        "i"
      );

      const found = attrs.match(regex);

      return found ? found[1] : "";
    }

    const cityId =
      getAttr("city_id") ||
      getAttr("cityId") ||
      getAttr("gameId") ||
      getAttr("id");

    if (!cityId) {
      continue;
    }

    const cityName =
      getAttr("city_name") ||
      getAttr("cityName") ||
      getAttr("name") ||
      "";

    const pic =
      getAttr("pic") ||
      getAttr("MyPicture") ||
      getAttr("picture") ||
      "";

    const gameId =
      getAttr("gameId") ||
      "";

    const level =
      getAttr("level");

    const xp =
      getAttr("xp");

    const fver =
      getAttr("fver");

    const key = String(cityId);

    if (seen.has(key)) {
      continue;
    }

    seen.add(key);

    result.push({
      friendId: key,

      cityId: key,

      name: String(
        cityName || key
      ),

      cityName: String(
        cityName || key
      ),

      pic: String(pic),

      gameId: String(gameId),

      level:
        level === ""
          ? null
          : toInt(level, 0),

      xp:
        xp === ""
          ? null
          : toInt(xp, 0),

      fver:
        fver === ""
          ? null
          : toInt(fver, 0),

      raw: {
        city_id: key,
        city_name: String(cityName),
        pic: String(pic),
        name: String(getAttr("name")),
        level: level,
        xp: xp,
        fver: fver,
        gameId: gameId,
      },
    });
  }

  return result;
}

/*
 * احتياط:
 * إذا كان XML في نسخة معينة يحتوي FriendsList
 * بدل friend المباشر، نحاول أيضًا قراءته.
 */

function findFriendsFromParsedXml(root) {
  const result = [];
  const seen = new Set();

  const friendsList =
    findFirstByName(root, "FriendsList");

  if (!friendsList) {
    return result;
  }

  walk(friendsList, (node) => {
    const cityId =
      attr(node, "city_id") ||
      attr(node, "cityId") ||
      attr(node, "cityID") ||
      attr(node, "gameId") ||
      attr(node, "id");

    if (!cityId) {
      return;
    }

    const name =
      attr(node, "city_name") ||
      attr(node, "cityName") ||
      attr(node, "name") ||
      attr(node, "townName") ||
      attr(node, "friendName");

    const key = String(cityId);

    if (seen.has(key)) {
      return;
    }

    seen.add(key);

    result.push({
      friendId: key,
      cityId: key,
      name: String(name || key),

      cityName: String(
        name || key
      ),

      gameId: String(
        attr(node, "gameId", "")
      ),

      pic: String(
        attr(node, "pic") ||
        attr(node, "MyPicture") ||
        attr(node, "picture") ||
        ""
      ),

      raw: node,
    });
  });

  return result;
}

function findFriends(root, xml) {
  /*
   * الطريقة الأولى:
   * القراءة المباشرة من XML.
   */
  const directFriends =
    findFriendsFromXml(xml);

  if (directFriends.length > 0) {
    return directFriends;
  }

  /*
   * الطريقة الثانية:
   * من parsed XML.
   */
  return findFriendsFromParsedXml(root);
}

/* ============================================================
   CITY META
   ============================================================ */

function extractMeta(root) {
  const cityId =
    getVar(root, "gameId") ||
    getVar(root, "cityId") ||
    "";

  const cityName =
    getVar(root, "name") ||
    getVar(root, "townName") ||
    "";

  return {
    cityId: String(cityId),

    gameId: String(
      getVar(root, "gameId", "")
    ),

    name: String(cityName),

    picture: String(
      getVar(root, "MyPicture", "")
    ),

    experience: toInt(
      getVar(root, "experience", "0"),
      0
    ),
  };
}

/* ============================================================
   CARD JOBS
   ============================================================ */

function buildCardJobs(cards, friend, meta) {
  return cards
    .filter(
      (card) =>
        card.inStockCount > 0
    )
    .map((card) => ({
      cardId: card.cardId,

      quantity:
        card.inStockCount,

      generatedCount:
        card.generatedCount,

      inStockCount:
        card.inStockCount,

      isNew:
        card.isNew,

      maxInStockCount:
        card.maxInStockCount,

      from: {
        cityId:
          meta.cityId,

        gameId:
          meta.gameId,

        name:
          meta.name,
      },

      to: {
        cityId:
          friend.friendId,

        gameId:
          friend.gameId ||
          friend.friendId,

        name:
          friend.name,
      },
    }));
}

/* ============================================================
   BUILD PAYLOAD
   ============================================================ */

function buildPayload(body) {
  if (!body) {
    throw new Error(
      "Request body is empty"
    );
  }

  const xml = body.myXml;

  const root =
    parseXml(xml);

  const friends =
    findFriends(
      root,
      xml
    );

  const cards =
    findOwnedCards(root);

  const meta =
    extractMeta(root);

  console.log(
    `[CARDS] Friends found: ${friends.length}`
  );

  console.log(
    `[CARDS] Cards found: ${cards.length}`
  );

  return {
    root,
    friends,
    cards,
    meta,
  };
}

/* ============================================================
   SELECT FRIEND
   ============================================================ */

function selectFriend(
  friends,
  friendId
) {
  const wanted =
    String(friendId || "");

  if (!wanted) {
    throw new Error(
      "friendId is required"
    );
  }

  const friend =
    friends.find(
      (f) =>
        String(f.friendId) === wanted ||
        String(f.cityId) === wanted ||
        String(f.gameId) === wanted
    );

  if (!friend) {
    throw new Error(
      `Friend not found: ${wanted}`
    );
  }

  return friend;
}

/* ============================================================
   REMOTE CONFIG
   ============================================================ */

function requiredConfig() {
  const url =
    process.env.CARD_SEND_URL;

  if (!url) {
    throw new Error(
      "CARD_SEND_URL is not configured. Configure the authorized card-send endpoint before sending."
    );
  }

  return {
    url,

    token:
      process.env.CARD_SEND_TOKEN ||
      "",

    tsBver:
      process.env.CARD_TS_BVER ||
      "",

    tsFver:
      process.env.CARD_TS_FVER ||
      "",

    xVersion:
      process.env.CARD_X_VERSION ||
      "",
  };
}

/* ============================================================
   REMOTE POST
   ============================================================ */

async function postAuthorized(payload) {
  const config =
    requiredConfig();

  const headers = {
    "content-type":
      "application/json",

    accept:
      "application/json",
  };

  if (config.token) {
    headers.authorization =
      `Bearer ${config.token}`;

    headers["ts-token"] =
      config.token;
  }

  if (config.tsBver) {
    headers["ts-bver"] =
      config.tsBver;
  }

  if (config.tsFver) {
    headers["ts-fver"] =
      config.tsFver;
  }

  if (config.xVersion) {
    headers["x-version"] =
      config.xVersion;
  }

  const response =
    await fetch(
      config.url,
      {
        method: "POST",

        headers,

        body:
          JSON.stringify(
            payload
          ),
      }
    );

  const raw =
    await response.text();

  let data;

  try {
    data =
      raw
        ? JSON.parse(raw)
        : {};
  } catch {
    data = {
      raw,
    };
  }

  if (!response.ok) {
    const error =
      new Error(
        `Card send endpoint returned HTTP ${response.status}`
      );

    error.status =
      response.status;

    error.response =
      data;

    throw error;
  }

  return data;
}

/* ============================================================
   ANALYZE
   ============================================================ */

router.post(
  "/analyze",
  (req, res) => {
    try {
      const {
        myXml
      } =
        req.body || {};

      const {
        friends,
        cards,
        meta
      } =
        buildPayload({
          myXml
        });

      const activeCards =
        cards.filter(
          (c) =>
            c.inStockCount > 0
        );

      const totalCards =
        activeCards.reduce(
          (sum, card) =>
            sum +
            card.inStockCount,
          0
        );

      return res.json({
        success: true,

        mode: "ready",

        city: meta,

        friends,

        cards,

        activeCards,

        distinctCards:
          activeCards.length,

        totalCards,

        message:
          "تم تحليل XML بنجاح. اختر الصديق فقط وسيتم إرسال كل البطاقات الموجودة بالمخزون.",
      });

    } catch (error) {
      console.error(
        "[CARDS] analyze error:",
        error
      );

      return res.status(400).json({
        success: false,

        error:
          error.message,

        friends: [],

        cards: [],

        activeCards: [],

        distinctCards: 0,

        totalCards: 0,
      });
    }
  }
);

/* ============================================================
   SEND ALL
   ============================================================ */

router.post(
  "/send-all",
  async (req, res) => {
    try {
      const {
        myXml,
        friendId
      } =
        req.body || {};

      const {
        friends,
        cards,
        meta
      } =
        buildPayload({
          myXml
        });

      const friend =
        selectFriend(
          friends,
          friendId
        );

      const activeCards =
        cards.filter(
          (card) =>
            card.inStockCount > 0
        );

      if (!activeCards.length) {
        return res.status(400).json({
          success: false,

          error:
            "لا توجد بطاقات متوفرة في OwnedCards.",

          city: meta,

          friend,

          distinctCards: 0,

          totalCards: 0,
        });
      }

      const cardJobs =
        buildCardJobs(
          activeCards,
          friend,
          meta
        );

      const outbound = {
        operation:
          "send_all_cards",

        cityId:
          meta.cityId,

        gameId:
          meta.gameId,

        from: {
          cityId:
            meta.cityId,

          gameId:
            meta.gameId,

          name:
            meta.name,
        },

        to: {
          cityId:
            friend.friendId,

          gameId:
            friend.gameId ||
            friend.friendId,

          name:
            friend.name,

          pic:
            friend.pic,
        },

        cards:
          cardJobs,

        summary: {
          distinctCards:
            cardJobs.length,

          totalCards:
            cardJobs.reduce(
              (sum, card) =>
                sum +
                card.quantity,
              0
            ),
        },
      };

      console.log(
        `[CARDS] Sending ${outbound.summary.totalCards} cards (${outbound.summary.distinctCards} types) to ${friend.name} [${friend.friendId}]`
      );

      const remote =
        await postAuthorized(
          outbound
        );

      const remoteSuccess =
        remote?.success === true ||
        remote?.ok === true ||
        remote?.status === "success";

      const sent =
        toInt(
          remote?.sent ??
          remote?.sentCards ??
          remote?.summary?.sent ??
          (
            remoteSuccess
              ? outbound.summary.totalCards
              : 0
          ),
          0
        );

      const created =
        toInt(
          remote?.created ??
          remote?.added ??
          remote?.summary?.created ??
          0,
          0
        );

      const notFound =
        toInt(
          remote?.notFound ??
          remote?.summary?.notFound ??
          0,
          0
        );

      const failed =
        toInt(
          remote?.failed ??
          remote?.summary?.failed ??
          (
            remoteSuccess
              ? 0
              : outbound.summary.totalCards
          ),
          0
        );

      return res.json({
        success:
          remoteSuccess,

        mode:
          "live",

        city:
          meta,

        friend,

        requested: {
          distinctCards:
            outbound.summary
              .distinctCards,

          totalCards:
            outbound.summary
              .totalCards,
        },

        result: {
          sent,

          created,

          notFound,

          failed,
        },

        remote,
      });

    } catch (error) {
      console.error(
        "[CARDS] send-all error:",
        error
      );

      const status =
        error.status &&
        Number.isInteger(
          error.status
        )
          ? error.status
          : 500;

      return res.status(status).json({
        success: false,

        mode: "live",

        error:
          error.message,

        remote:
          error.response ||
          null,
      });
    }
  }
);

/* ============================================================
   EXPORT
   ============================================================ */

module.exports = router;
