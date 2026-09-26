const express = require("express");
const { XMLParser } = require("fast-xml-parser");
const router = express.Router();

const parser = new XMLParser({
    ignoreAttributes: false,
    attributeNamePrefix: "@_",
    trimValues: false
});

function arr(v) {
    if (v == null) return [];
    return Array.isArray(v) ? v : [v];
}

function valueOf(node) {
    if (!node || typeof node !== "object") return undefined;
    if (node["@_value"] !== undefined) return node["@_value"];
    if (node["@_v"] !== undefined) return node["@_v"];
    return undefined;
}

function typedValue(node) {
    const value = valueOf(node);
    if (value === undefined) return undefined;

    const type = String(node["@_type"] || "").toLowerCase();

    if (["int", "int32", "int64", "float", "double"].includes(type)) {
        const n = Number(value);
        return Number.isFinite(n) ? n : 0;
    }

    if (["bool", "boolean"].includes(type)) {
        return value === true || value === "true" || value === "1";
    }

    return value;
}

function findNamed(root, name) {
    const seen = new Set();

    function walk(node) {
        if (!node || typeof node !== "object" || seen.has(node)) return null;
        seen.add(node);

        for (const [key, value] of Object.entries(node)) {
            if (key === "DataElem") {
                for (const item of arr(value)) {
                    if (item && typeof item === "object" && item["@_name"] === name) {
                        return item;
                    }
                    const hit = walk(item);
                    if (hit) return hit;
                }
            } else if (value && typeof value === "object") {
                const hit = walk(value);
                if (hit) return hit;
            }
        }
        return null;
    }

    return walk(root);
}

function fieldsOf(node) {
    const out = {};
    if (!node) return out;

    for (const item of arr(node.DataElem)) {
        if (!item || typeof item !== "object" || !item["@_name"]) continue;
        out[item["@_name"]] = typedValue(item);
    }

    return out;
}

function extractCards(xml) {
    const doc = parser.parse(xml);
    const owned = findNamed(doc, "OwnedCards");

    if (!owned) {
        throw new Error("OwnedCards was not found in XML");
    }

    const map = new Map();

    for (const entry of arr(owned.DataElem)) {
        if (!entry || typeof entry !== "object") continue;

        const f = fieldsOf(entry);
        const cardId = f.cardId == null ? "" : String(f.cardId);
        const count = Number(f.inStockCount || 0);

        if (!cardId || !Number.isFinite(count) || count <= 0) continue;

        if (!map.has(cardId)) {
            map.set(cardId, {
                cardId,
                count: 0,
                generatedCount: Number(f.generatedCount || 0),
                isNew: Boolean(f.isNew),
                maxInStockCount: Number(f.maxInStockCount || 0)
            });
        }

        map.get(cardId).count += count;
    }

    const cards = [...map.values()];

    return {
        cards,
        distinctCards: cards.length,
        totalCards: cards.reduce((n, c) => n + c.count, 0)
    };
}

function findValue(root, names) {
    const wanted = new Set(names);
    const seen = new Set();

    function walk(node) {
        if (!node || typeof node !== "object" || seen.has(node)) return undefined;
        seen.add(node);

        for (const [key, value] of Object.entries(node)) {
            if (key === "DataElem") {
                for (const item of arr(value)) {
                    if (item && typeof item === "object" && wanted.has(item["@_name"])) {
                        return typedValue(item);
                    }
                    const hit = walk(item);
                    if (hit !== undefined) return hit;
                }
            } else if (value && typeof value === "object") {
                const hit = walk(value);
                if (hit !== undefined) return hit;
            }
        }
        return undefined;
    }

    return walk(root);
}

function extractMeta(xml) {
    const doc = parser.parse(xml);

    return {
        cityId: findValue(doc, ["cityId", "city_id"]),
        gameId: findValue(doc, ["gameId", "game_id"]),
        townName: findValue(doc, ["townName", "city_name"]),
        experience: findValue(doc, ["experience"])
    };
}

function extractFriends(xml) {
    const doc = parser.parse(xml);
    const result = [];
    const seen = new Set();

    function add(id, extra = {}) {
        if (id == null || String(id).trim() === "") return;
        id = String(id);
        if (seen.has(id)) return;
        seen.add(id);
        result.push({ id, ...extra });
    }

    function walk(node) {
        if (!node || typeof node !== "object") return;

        for (const [key, value] of Object.entries(node)) {
            if (key !== "DataElem") {
                if (value && typeof value === "object") walk(value);
                continue;
            }

            for (const item of arr(value)) {
                if (!item || typeof item !== "object") continue;

                if (item["@_name"] === "FriendsList") {
                    for (const x of arr(item.DataElem)) {
                        if (x && typeof x === "object") {
                            const id = x["@_value"] ?? x["@_v"];
                            if (id != null) add(id);
                        }
                    }
                }

                walk(item);
            }
        }
    }

    walk(doc);
    return result;
}

function getXml(req) {
    if (typeof req.body === "string" && req.body.trim()) return req.body;
    if (req.body && typeof req.body.xml === "string") return req.body.xml;
    if (req.body && typeof req.body.myXml === "string") return req.body.myXml;
    throw new Error("XML is missing");
}

function makeJob(xml, friend) {
    const meta = extractMeta(xml);
    const inventory = extractCards(xml);

    return {
        type: "collections_send_card",
        cityId: meta.cityId ?? null,
        gameId: meta.gameId ?? null,
        townName: meta.townName ?? null,
        experience: meta.experience ?? null,
        friend,
        cards: inventory.cards,
        distinctCards: inventory.distinctCards,
        totalCards: inventory.totalCards
    };
}

async function sendAuthorized(job) {
    const url = process.env.CARD_SEND_URL;

    if (!url) {
        return {
            sent: false,
            mode: "preview",
            reason: "CARD_SEND_URL is not configured"
        };
    }

    const headers = {
        "Content-Type": "application/json"
    };

    if (process.env.CARD_SEND_TOKEN) {
        headers.Authorization = `Bearer ${process.env.CARD_SEND_TOKEN}`;
    }

    const response = await fetch(url, {
        method: "POST",
        headers,
        body: JSON.stringify(job)
    });

    const text = await response.text();

    let body;
    try {
        body = JSON.parse(text);
    } catch {
        body = text;
    }

    if (!response.ok) {
        const error = new Error(`Card API returned HTTP ${response.status}`);
        error.status = response.status;
        error.response = body;
        throw error;
    }

    return {
        sent: true,
        status: response.status,
        response: body
    };
}

/*
POST /api/cards/analyze

Body:
{
    "xml": "..."
}
or:
{
    "myXml": "..."
}
*/
router.post("/analyze", (req, res) => {
    try {
        const xml = getXml(req);
        const meta = extractMeta(xml);
        const friends = extractFriends(xml);
        const inventory = extractCards(xml);

        res.json({
            ok: true,
            meta,
            friends,
            cards: inventory.cards,
            distinctCards: inventory.distinctCards,
            totalCards: inventory.totalCards
        });
    } catch (e) {
        console.error("[CARDS] analyze:", e);
        res.status(400).json({
            ok: false,
            error: e.message
        });
    }
});

/*
POST /api/cards/send-all

Body:
{
    "xml": "...",
    "friend": {
        "id": "..."
    }
}

لا يوجد اختيار بطاقات.
كل بطاقة لها inStockCount > 0 تدخل تلقائيًا.
*/
router.post("/send-all", async (req, res) => {
    try {
        const xml = getXml(req);
        const rawFriend = req.body && (req.body.friend || req.body.friendId);

        if (!rawFriend) {
            return res.status(400).json({
                ok: false,
                error: "friend or friendId is required"
            });
        }

        const friend = typeof rawFriend === "string"
            ? { id: rawFriend }
            : rawFriend;

        const job = makeJob(xml, friend);

        console.log("[CARDS] send-all", {
            friend: friend.id,
            distinctCards: job.distinctCards,
            totalCards: job.totalCards
        });

        const delivery = await sendAuthorized(job);

        res.json({
            ok: true,
            friend: job.friend,
            distinctCards: job.distinctCards,
            totalCards: job.totalCards,
            cards: job.cards,
            delivery
        });
    } catch (e) {
        console.error("[CARDS] send-all:", e);

        res.status(e.status || 400).json({
            ok: false,
            error: e.message,
            response: e.response
        });
    }
});

module.exports = router;
