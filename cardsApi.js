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

/* ============================================================
   Helpers
============================================================ */

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

function numberValue(value, fallback = 0) {
    const n = Number(valueOf(value));
    return Number.isFinite(n) ? n : fallback;
}

/* ============================================================
   Recursive search
============================================================ */

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

        if (value && typeof value === "object") {
            findNamed(value, wantedName, out);
        }
    }

    return out;
}

function findValue(root, names) {

    const wanted = new Set(
        Array.isArray(names) ? names : [names]
    );

    function walk(node) {

        if (node == null) {
            return null;
        }

        if (Array.isArray(node)) {

            for (const item of node) {
                const result = walk(item);

                if (result != null) {
                    return result;
                }
            }

            return null;
        }

        if (typeof node !== "object") {
            return null;
        }

        for (const [key, value] of Object.entries(node)) {

            const cleanKey =
                key.startsWith("@_")
                    ? key.slice(2)
                    : key;

            if (wanted.has(cleanKey)) {
                return valueOf(value);
            }

            if (value && typeof value === "object") {

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

/* ============================================================
   DataElem helpers
============================================================ */

function findDataElemsByName(
    node,
    wantedName,
    result = []
) {
    if (node == null) {
        return result;
    }

    if (Array.isArray(node)) {

        for (const item of node) {
            findDataElemsByName(
                item,
                wantedName,
                result
            );
        }

        return result;
    }

    if (typeof node !== "object") {
        return result;
    }

    if (node["@_name"] === wantedName) {
        result.push(node);
    }

    for (const value of Object.values(node)) {

        if (value && typeof value === "object") {
            findDataElemsByName(
                value,
                wantedName,
                result
            );
        }
    }

    return result;
}

function getDataElemValue(node, name) {

    const matches =
        findDataElemsByName(
            node,
            name,
            []
        );

    if (!matches.length) {
        return "";
    }

    return String(
        matches[0]["@_value"] ?? ""
    );
}

/* ============================================================
   Extract OwnedCards
============================================================ */

function extractCards(root) {

    const cards = [];

    const ownedCardsArrays =
        findDataElemsByName(
            root,
            "OwnedCards",
            []
        );

    for (const ownedCardsArray of ownedCardsArrays) {

        let entries =
            ownedCardsArray.DataElem;

        if (!entries) {
            continue;
        }

        if (!Array.isArray(entries)) {
            entries = [entries];
        }

        for (const entry of entries) {

            if (!entry || typeof entry !== "object") {
                continue;
            }

            if (entry["@_type"] !== "dataStore") {
                continue;
            }

            const cardId =
                getDataElemValue(
                    entry,
                    "cardId"
                );

            if (!cardId) {
                continue;
            }

            const generatedCount =
                numberValue(
                    getDataElemValue(
                        entry,
                        "generatedCount"
                    )
                );

            const inStockCount =
                numberValue(
                    getDataElemValue(
                        entry,
                        "inStockCount"
                    )
                );

            const maxInStockCount =
                numberValue(
                    getDataElemValue(
                        entry,
                        "maxInStockCount"
                    )
                );

            const isNewValue =
                getDataElemValue(
                    entry,
                    "isNew"
                );

            cards.push({
                cardId: String(cardId),
                generatedCount,
                inStockCount,
                maxInStockCount,
                isNew:
                    isNewValue === "true" ||
                    isNewValue === "1"
            });
        }
    }

    /*
     * دمج أي تكرار لنفس cardId
     */
    const map = new Map();

    for (const card of cards) {

        if (!map.has(card.cardId)) {

            map.set(
                card.cardId,
                { ...card }
            );

            continue;
        }

        const old =
            map.get(card.cardId);

        old.inStockCount +=
            card.inStockCount;

        old.generatedCount =
            Math.max(
                old.generatedCount,
                card.generatedCount
            );

        old.maxInStockCount =
            Math.max(
                old.maxInStockCount,
                card.maxInStockCount
            );

        old.isNew =
            old.isNew ||
            card.isNew;
    }

    return Array.from(map.values());
}

/* ============================================================
   Extract Friends
============================================================ */

function extractFriends(root) {

    const friendNodes =
        findNamed(
            root,
            "friend"
        );

    const friends = [];
    const seen = new Set();

    for (const friend of friendNodes) {

        if (!friend || typeof friend !== "object") {
            continue;
        }

        const cityId = String(
            friend["@_city_id"] ??
            friend["@_cityId"] ??
            friend["@_id"] ??
            friend["@_friend_id"] ??
            friend["@_friendId"] ??
            ""
        );

        if (!cityId) {
            continue;
        }

        if (seen.has(cityId)) {
            continue;
        }

        seen.add(cityId);

        const cityName = String(
            friend["@_city_name"] ??
            friend["@_cityName"] ??
            ""
        );

        const rawName =
            String(
                friend["@_name"] ?? ""
            );

        const levelRaw =
            friend["@_level"];

        const xpRaw =
            friend["@_xp"];

        const level =
            levelRaw === undefined ||
            levelRaw === ""
                ? null
                : Number(levelRaw);

        const xp =
            xpRaw === undefined ||
            xpRaw === ""
                ? null
                : Number(xpRaw);

        const pic =
            String(
                friend["@_pic"] ?? ""
            );

        friends.push({

            id: cityId,

            cityId,

            name:
                cityName ||
                rawName ||
                cityId,

            cityName,

            level:
                Number.isFinite(level)
                    ? level
                    : null,

            xp:
                Number.isFinite(xp)
                    ? xp
                    : null,

            pic
        });
    }

    return friends;
}

/* ============================================================
   Meta
============================================================ */

function extractMeta(root) {

    return {

        cityId:
            String(
                findValue(
                    root,
                    ["cityId", "city_id"]
                ) || ""
            ),

        gameId:
            String(
                findValue(
                    root,
                    ["gameId", "game_id"]
                ) || ""
            ),

        experience:
            numberValue(
                findValue(
                    root,
                    ["experience"]
                ),
                0
            )
    };
}

/* ============================================================
   XML input
============================================================ */

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

/* ============================================================
   Build one SEND-ALL job
============================================================ */

function makeJob(friend, cards, meta) {

    const sendCards =
        cards
            .filter(
                card =>
                    Number(
                        card.inStockCount
                    ) > 0
            )
            .map(card => ({

                cardId:
                    card.cardId,

                quantity:
                    Number(
                        card.inStockCount
                    ),

                inStockCount:
                    Number(
                        card.inStockCount
                    ),

                generatedCount:
                    Number(
                        card.generatedCount
                    ),

                maxInStockCount:
                    Number(
                        card.maxInStockCount
                    ),

                isNew:
                    !!card.isNew
            }));

    const totalCards =
        sendCards.reduce(
            (sum, card) =>
                sum +
                Number(
                    card.quantity || 0
                ),
            0
        );

    return {

        type:
            "send_all_cards",

        from: {
            cityId:
                meta.cityId,

            gameId:
                meta.gameId
        },

        friend: {

            id:
                friend.id,

            cityId:
                friend.cityId,

            name:
                friend.name,

            cityName:
                friend.cityName,

            level:
                friend.level,

            xp:
                friend.xp,

            pic:
                friend.pic
        },

        cards:
            sendCards,

        distinctCards:
            sendCards.length,

        totalCards
    };
}

/* ============================================================
   Authorized sender
============================================================ */

async function sendAuthorized(job) {

    const url =
        process.env.CARD_SEND_URL || "";

    const token =
        process.env.CARD_SEND_TOKEN || "";

    /*
     * إذا لم يتم تحديد API مصرح به:
     * لا يتم إرسال شيء للخارج.
     * يرجع Preview فقط.
     */
    if (!url) {

        return {

            success: true,

            mode:
                "preview",

            message:
                "CARD_SEND_URL غير مضبوط؛ تم إنشاء مهمة الإرسال فقط.",

            friend:
                job.friend,

            distinctCards:
                job.distinctCards,

            totalCards:
                job.totalCards,

            sent:
                0,

            sentCards:
                0,

            created:
                0,

            failed:
                0,

            notFound:
                0,

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

                method:
                    "POST",

                headers,

                body:
                    JSON.stringify(job)
            }
        );

    const text =
        await response.text();

    let data;

    try {

        data =
            JSON.parse(text);

    } catch (_) {

        data = {
            raw: text
        };
    }

    if (!response.ok) {

        return {

            success: false,

            mode:
                "authorized",

            status:
                response.status,

            message:
                "CARD_SEND_URL returned HTTP " +
                response.status,

            response:
                data,

            friend:
                job.friend,

            distinctCards:
                job.distinctCards,

            totalCards:
                job.totalCards
        };
    }

    return {

        success: true,

        mode:
            "authorized",

        friend:
            data.friend ||
            job.friend,

        distinctCards:
            data.distinctCards ??
            data.cardsFound ??
            job.distinctCards,

        totalCards:
            data.totalCards ??
            job.totalCards,

        sent:
            data.sent ??
            data.sentCards ??
            0,

        sentCards:
            data.sentCards ??
            data.sent ??
            0,

        created:
            data.created ??
            0,

        failed:
            data.failed ??
            0,

        notFound:
            data.notFound ??
            0,

        response:
            data
    };
}

/* ============================================================
   POST /api/cards/analyze
============================================================ */

router.post(
    "/analyze",
    (req, res) => {

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
                            card.inStockCount
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

            console.log(
                "[CARDS] ANALYZE",
                {
                    friends:
                        friends.length,

                    distinctCards:
                        activeCards.length,

                    totalCards
                }
            );

            return res.json({

                success: true,

                meta,

                friends,

                cards:
                    activeCards,

                distinctCards:
                    activeCards.length,

                totalCards
            });

        } catch (error) {

            console.error(
                "[CARDS] ANALYZE ERROR",
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

/* ============================================================
   POST /api/cards/send-all
============================================================ */

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
                            card.inStockCount
                        ) > 0
                );

            /*
             * Lua يرسل friendId فقط.
             */
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
                        "friendId is required",

                    friends
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

            if (!activeCards.length) {

                return res.status(400).json({

                    success: false,

                    error:
                        "No cards with inStockCount > 0 were found",

                    cardsDetected:
                        cards.length,

                    totalCards:
                        0
                });
            }

            /*
             * هنا يتم تجهيز جميع البطاقات.
             * لا يوجد اختيار بطاقة.
             * لا يوجد quantity من المستخدم.
             */
            const job =
                makeJob(
                    friend,
                    activeCards,
                    meta
                );

            console.log(
                "[CARDS] SEND ALL",
                {
                    friend:
                        friend.name,

                    cityId:
                        friend.cityId,

                    distinctCards:
                        job.distinctCards,

                    totalCards:
                        job.totalCards
                }
            );

            const result =
                await sendAuthorized(job);

            return res.json({

                ...result,

                success:
                    result.success !== false,

                friend:
                    result.friend ||
                    friend
            });

        } catch (error) {

            console.error(
                "[CARDS] SEND-ALL ERROR",
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

/* ============================================================
   Export
============================================================ */

module.exports = router;
