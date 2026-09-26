const express = require("express");
const { XMLParser } = require("fast-xml-parser");

const router = express.Router();

const parser = new XMLParser({
  ignoreAttributes: false,
  attributeNamePrefix: "@_",
  textNodeName: "#text",
  trimValues: false,
});

function arr(value) {
  if (value == null) return [];
  return Array.isArray(value) ? value : [value];
}

function attr(node, name, fallback = "") {
  if (!node || typeof node !== "object") return fallback;
  return node[`@_${name}`] ?? fallback;
}

function toInt(value, fallback = 0) {
  const n = Number.parseInt(String(value ?? ""), 10);
  return Number.isFinite(n) ? n : fallback;
}

function walk(node, callback, path = []) {
  if (node == null) return;

  if (Array.isArray(node)) {
    node.forEach((item, i) => walk(item, callback, path.concat(i)));
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

function parseXml(xml) {
  if (typeof xml !== "string" || !xml.trim()) {
    throw new Error("myXml is empty");
  }

  return parser.parse(xml);
}

/*
 * ============================================================
 * OwnedCards
 * ============================================================
 */

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

  /*
   * Merge duplicate card IDs if they appear more than once.
   */
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

/*
 * ============================================================
 * Friends
 * ============================================================
 */

function findFriends(root) {
  const result = [];
  const seen = new Set();

  const friendsList = findFirstByName(
    root,
    "FriendsList"
  );

  if (!friendsList) {
    return result;
  }

  walk(friendsList, (node) => {
    const cityId =
      attr(node, "cityId") ||
      attr(node, "cityID") ||
      attr(node, "gameId") ||
      attr(node, "id");

    const name =
      attr(node, "name") ||
      attr(node, "cityName") ||
      attr(node, "townName") ||
      attr(node, "friendName");

    if (!cityId) {
      return;
    }

    const key = String(cityId);

    if (seen.has(key)) {
      return;
    }

    seen.add(key);

    result.push({
      friendId: key,
      name: String(name || key),
      cityId: key,
      gameId: String(
        attr(node, "gameId", "")
      ),
      pic: String(
        attr(node, "MyPicture") ||
        attr(node, "pic") ||
        attr(node, "picture") ||
        ""
      ),
      raw: node,
    });
  });

  return result;
}

/*
 * ============================================================
 * City metadata
 * ============================================================
 */

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

/*
 * ============================================================
 * Build all card jobs
 * ============================================================
 */

function buildCardJobs(
  cards,
  friend,
  meta
) {
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
        cityId: meta.cityId,
        gameId: meta.gameId,
        name: meta.name,
      },

      to: {
        cityId: friend.friendId,
        gameId:
          friend.gameId ||
          friend.friendId,
        name: friend.name,
      },
    }));
}

/*
 * ============================================================
 * Build complete XML data
 * ============================================================
 */

function buildPayload(body) {
  const root = parseXml(
    body.myXml
  );

  const friends =
    findFriends(root);

  const cards =
    findOwnedCards(root);

  const meta =
    extractMeta(root);

  return {
    root,
    friends,
    cards,
    meta,
  };
}

/*
 * ============================================================
 * Select friend
 * ============================================================
 */

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

/*
 * ============================================================
 * Authorized sending configuration
 * ============================================================
 */

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

/*
 * ============================================================
 * POST to authorized endpoint
 * ============================================================
 */

async function postAuthorized(
  payload
) {
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
        body: JSON.stringify(
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

/*
 * ============================================================
 * ANALYZE
 *
 * POST /api/cards/analyze
 *
 * {
 *   "myXml": "..."
 * }
 * ============================================================
 */

router.post(
  "/analyze",
  (req, res) => {
    try {
      const {
        myXml,
      } = req.body || {};

      const {
        friends,
        cards,
        meta,
      } =
        buildPayload({
          myXml,
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

      res.json({
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

      res.status(400).json({
        success: false,
        error:
          error.message,
      });
    }
  }
);

/*
 * ============================================================
 * SEND ALL
 *
 * POST /api/cards/send-all
 *
 * {
 *   "myXml": "...",
 *   "friendId": "..."
 * }
 *
 * المستخدم يختار الصديق فقط.
 * كل البطاقات التي inStockCount > 0 يتم إرسالها.
 * ============================================================
 */

router.post(
  "/send-all",
  async (req, res) => {
    try {
      const {
        myXml,
        friendId,
      } = req.body || {};

      const {
        friends,
        cards,
        meta,
      } =
        buildPayload({
          myXml,
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

      if (
        !activeCards.length
      ) {
        return res
          .status(400)
          .json({
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

      /*
       * البيانات التي سترسل إلى
       * endpoint المصرح به.
       */

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

      /*
       * إرسال فعلي.
       * لا يوجد preview هنا.
       */

      const remote =
        await postAuthorized(
          outbound
        );

      const remoteSuccess =
        remote?.success === true ||
        remote?.ok === true ||
        remote?.status ===
          "success";

      const sent =
        toInt(
          remote?.sent ??
            remote?.sentCards ??
            remote?.summary?.sent ??
            (
              remoteSuccess
                ? outbound.summary
                    .totalCards
                : 0
            ),
          0
        );

      const created =
        toInt(
          remote?.created ??
            remote?.added ??
            remote?.summary
              ?.created ??
            0,
          0
        );

      const notFound =
        toInt(
          remote?.notFound ??
            remote?.summary
              ?.notFound ??
            0,
          0
        );

      const failed =
        toInt(
          remote?.failed ??
            remote?.summary
              ?.failed ??
            (
              remoteSuccess
                ? 0
                : outbound.summary
                    .totalCards
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

      return res
        .status(status)
        .json({
          success: false,

          mode:
            "live",

          error:
            error.message,

          remote:
            error.response ||
            null,
        });
    }
  }
);

module.exports = router;
