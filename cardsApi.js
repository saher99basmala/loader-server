'use strict';

const express = require('express');
const { XMLParser } = require('fast-xml-parser');

const router = express.Router();

/* ============================================================
   XML PARSER
============================================================ */

const parser = new XMLParser({
    ignoreAttributes: false,
    attributeNamePrefix: '@_',
    trimValues: false,
    parseTagValue: false,
    parseAttributeValue: false
});


/* ============================================================
   HELPERS
============================================================ */

function arr(v) {
    if (v == null) return [];
    return Array.isArray(v) ? v : [v];
}

function s(v) {
    return v == null ? '' : String(v);
}

function getBody(req) {
    if (typeof req.body === 'string') {
        try {
            return JSON.parse(req.body);
        } catch (_) {
            return {
                xml: req.body
            };
        }
    }

    return req.body || {};
}


/* ============================================================
   RECURSIVE WALK
============================================================ */

function walk(node, fn, seen = new Set()) {
    if (
        !node ||
        typeof node !== 'object' ||
        seen.has(node)
    ) {
        return;
    }

    seen.add(node);

    fn(node);

    for (const value of Object.values(node)) {
        if (
            !value ||
            typeof value !== 'object'
        ) {
            continue;
        }

        for (const item of arr(value)) {
            if (
                item &&
                typeof item === 'object'
            ) {
                walk(item, fn, seen);
            }
        }
    }
}


/* ============================================================
   VALUE
============================================================ */

function valueOf(node) {
    if (
        !node ||
        typeof node !== 'object'
    ) {
        return undefined;
    }

    if (node['@_value'] !== undefined) {
        return node['@_value'];
    }

    if (node['@_v'] !== undefined) {
        return node['@_v'];
    }

    return undefined;
}


/* ============================================================
   FIELD
============================================================ */

function getField(node, names) {
    if (
        !node ||
        typeof node !== 'object'
    ) {
        return undefined;
    }

    for (const name of names) {
        if (
            node['@_' + name] !== undefined
        ) {
            return node['@_' + name];
        }
    }

    for (const child of arr(node.DataElem)) {
        if (
            !child ||
            typeof child !== 'object'
        ) {
            continue;
        }

        const name =
            child['@_name'];

        if (
            name &&
            names.includes(name)
        ) {
            const value =
                valueOf(child);

            if (value !== undefined) {
                return value;
            }
        }
    }

    return undefined;
}


/* ============================================================
   META
============================================================ */

function extractMeta(xml) {
    const doc = parser.parse(xml);

    const find = names => {
        let result;

        walk(doc, node => {
            if (result !== undefined) {
                return;
            }

            const name =
                node['@_name'];

            if (
                !name ||
                !names.includes(name)
            ) {
                return;
            }

            const value =
                valueOf(node);

            if (value !== undefined) {
                result = value;
            }
        });

        return result;
    };

    return {
        cityId:
            find([
                'cityId',
                'city_id'
            ]) || null,

        gameId:
            find([
                'gameId',
                'game_id'
            ]) || null,

        townName:
            find([
                'townName',
                'city_name',
                'name'
            ]) || null,

        experience:
            find([
                'experience'
            ]) || null,

        totalSendCards:
            Number(
                find([
                    'totalSendCards'
                ]) || 0
            ) || 0
    };
}


/* ============================================================
   FRIENDS
   SOURCE:
   bs.xml
============================================================ */

function extractFriends(xml) {
    if (
        typeof xml !== 'string' ||
        !xml.trim()
    ) {
        throw new Error(
            'Friends XML is empty'
        );
    }

    const doc =
        parser.parse(xml);

    const friends = [];
    const seen = new Set();

    const idNames = new Set([
        'cityId',
        'city_id',
        'gameId',
        'friendId',
        'friend_id',
        'id'
    ]);

    const nameNames = new Set([
        'name',
        'cityName',
        'city_name',
        'townName',
        'friendName'
    ]);

    function add(node) {
        if (
            !node ||
            typeof node !== 'object'
        ) {
            return;
        }

        let id = '';
        let name = '';
        let pic = '';

        for (
            const [key, value]
            of Object.entries(node)
        ) {
            if (
                !key.startsWith('@_')
            ) {
                continue;
            }

            const field =
                key.slice(2);

            if (
                !id &&
                idNames.has(field)
            ) {
                id =
                    s(value).trim();
            }

            if (
                !name &&
                nameNames.has(field)
            ) {
                name =
                    s(value);
            }

            if (
                field === 'pic' ||
                field === 'picture' ||
                field === 'avatar'
            ) {
                pic =
                    s(value);
            }
        }

        if (!id) {
            const value =
                valueOf(node);

            if (
                value != null &&
                s(value).trim()
            ) {
                id =
                    s(value).trim();
            }
        }

        if (
            !id ||
            seen.has(id)
        ) {
            return;
        }

        seen.add(id);

        friends.push({
            id,
            name,
            pic
        });
    }

    walk(doc, node => {
        const nodeName =
            s(node['@_name']);

        if (
            nodeName === 'FriendsList' ||
            /friend/i.test(nodeName)
        ) {
            for (
                const child
                of arr(node.DataElem)
            ) {
                add(child);
            }
        }

        if (
            node['@_cityId'] ||
            node['@_city_id'] ||
            node['@_friendId']
        ) {
            add(node);
        }
    });

    return friends;
}


/* ============================================================
   CARDS
   SOURCE:
   my.xml
============================================================ */

function extractCards(xml) {
    if (
        typeof xml !== 'string' ||
        !xml.trim()
    ) {
        throw new Error(
            'Cards XML is empty'
        );
    }

    const doc =
        parser.parse(xml);

    /*
     * لا نبحث عن البطاقات في bs.xml.
     * هذا الدالة تستقبل my.xml فقط.
     */

    let owned =
        null;

    walk(doc, node => {
        if (owned) {
            return;
        }

        const name =
            node['@_name'];

        if (
            name === 'OwnedCards' ||
            name === 'ownedCards' ||
            name === 'OwnedCard'
        ) {
            owned = node;
        }
    });

    if (!owned) {
        throw new Error(
            'OwnedCards was not found in cards XML'
        );
    }

    const map =
        new Map();

    walk(owned, node => {
        const cardId =
            getField(node, [
                'cardId',
                'card_id',
                'CardId',
                'id'
            ]);

        const stock =
            getField(node, [
                'inStockCount',
                'in_stock_count',
                'InStockCount',
                'stockCount'
            ]);

        if (
            cardId === undefined ||
            stock === undefined
        ) {
            return;
        }

        const id =
            s(cardId).trim();

        const count =
            Number(stock);

        if (
            !id ||
            !Number.isFinite(count) ||
            count <= 0
        ) {
            return;
        }

        const generated =
            Number(
                getField(node, [
                    'generatedCount',
                    'generated_count'
                ]) || 0
            );

        const maxStock =
            Number(
                getField(node, [
                    'maxInStockCount',
                    'max_in_stock_count'
                ]) || 0
            );

        const isNew =
            getField(node, [
                'isNew',
                'is_new'
            ]);

        if (!map.has(id)) {
            map.set(id, {
                cardId: id,
                count: 0,

                generatedCount:
                    Number.isFinite(generated)
                        ? generated
                        : 0,

                isNew:
                    s(isNew || 'false'),

                maxInStockCount:
                    Number.isFinite(maxStock)
                        ? maxStock
                        : 0
            });
        }

        map.get(id).count += count;
    });

    const cards =
        [...map.values()];

    const totalCopies =
        cards.reduce(
            (total, card) =>
                total + card.count,
            0
        );

    return {
        cards,

        distinctCards:
            cards.length,

        totalCopies,

        totalCards:
            totalCopies
    };
}


/* ============================================================
   ANALYZE BOTH FILES
============================================================ */

router.post(
    '/analyze-files',
    (req, res) => {

        try {

            const body =
                getBody(req);

            /*
             * bs.xml
             */
            const friendsXml =
                body.friendsXml ||
                body.bsXml ||
                body.bs;

            /*
             * my.xml
             */
            const cardsXml =
                body.cardsXml ||
                body.myXml;

            if (
                typeof friendsXml !== 'string' ||
                !friendsXml.trim()
            ) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'friendsXml is missing'
                });
            }

            if (
                typeof cardsXml !== 'string' ||
                !cardsXml.trim()
            ) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'cardsXml is missing'
                });
            }

            console.log(
                '[CARDS] ANALYZE FILES',
                {
                    friendsXmlLength:
                        friendsXml.length,

                    cardsXmlLength:
                        cardsXml.length
                }
            );

            const friends =
                extractFriends(
                    friendsXml
                );

            const inventory =
                extractCards(
                    cardsXml
                );

            const meta =
                extractMeta(
                    cardsXml
                );

            console.log(
                '[CARDS] RESULT',
                {
                    cityId:
                        meta.cityId,

                    friends:
                        friends.length,

                    distinctCards:
                        inventory.distinctCards,

                    totalCopies:
                        inventory.totalCopies
                }
            );

            return res.json({
                ok: true,

                meta,

                friends,

                cards:
                    inventory.cards,

                distinctCards:
                    inventory.distinctCards,

                totalCopies:
                    inventory.totalCopies,

                totalCards:
                    inventory.totalCards
            });

        } catch (error) {

            console.error(
                '[CARDS] analyze-files:',
                error
            );

            return res.status(400).json({
                ok: false,
                error:
                    error.message
            });
        }
    }
);


/* ============================================================
   ANALYZE
   BACKWARD COMPATIBILITY
============================================================ */

router.post(
    '/analyze',
    (req, res) => {

        try {

            const body =
                getBody(req);

            const xml =
                body.xml ||
                body.myXml;

            if (!xml) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'XML is missing'
                });
            }

            /*
             * هذا endpoint القديم مخصص للبطاقات.
             * لا يستخدم bs.xml.
             */

            const meta =
                extractMeta(xml);

            const inventory =
                extractCards(xml);

            return res.json({
                ok: true,

                meta,

                friends: [],

                cards:
                    inventory.cards,

                distinctCards:
                    inventory.distinctCards,

                totalCopies:
                    inventory.totalCopies,

                totalCards:
                    inventory.totalCards
            });

        } catch (error) {

            console.error(
                '[CARDS] analyze:',
                error
            );

            return res.status(400).json({
                ok: false,
                error:
                    error.message
            });
        }
    }
);


/* ============================================================
   SELECT FRIEND
   bs.xml = FRIENDS
   my.xml = CARDS
============================================================ */

router.post(
    '/select',
    (req, res) => {

        try {

            const body =
                getBody(req);

            const friendsXml =
                body.friendsXml ||
                body.bsXml ||
                body.bs;

            const cardsXml =
                body.cardsXml ||
                body.myXml;

            const friend =
                body.friend;

            if (
                typeof friendsXml !== 'string' ||
                !friendsXml.trim()
            ) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'friendsXml is missing'
                });
            }

            if (
                typeof cardsXml !== 'string' ||
                !cardsXml.trim()
            ) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'cardsXml is missing'
                });
            }

            if (
                !friend ||
                !friend.id
            ) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'friend.id is required'
                });
            }

            const friends =
                extractFriends(
                    friendsXml
                );

            const selected =
                friends.find(
                    x =>
                        String(x.id) ===
                        String(friend.id)
                );

            if (!selected) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'Selected friend was not found in bs.xml'
                });
            }

            const inventory =
                extractCards(
                    cardsXml
                );

            const meta =
                extractMeta(
                    cardsXml
                );

            return res.json({
                ok: true,

                friend:
                    selected,

                meta,

                distinctCards:
                    inventory.distinctCards,

                totalCopies:
                    inventory.totalCopies,

                totalCards:
                    inventory.totalCards,

                cards:
                    inventory.cards
            });

        } catch (error) {

            console.error(
                '[CARDS] select:',
                error
            );

            return res.status(400).json({
                ok: false,
                error:
                    error.message
            });
        }
    }
);


/* ============================================================
   SEND-ALL PREPARATION
============================================================ */

/*
 * هذا endpoint لا يرسل إلى خدمة اللعبة.
 *
 * وظيفته:
 * 1. قراءة bs.xml.
 * 2. قراءة my.xml.
 * 3. التحقق من الصديق.
 * 4. استخراج البطاقات.
 * 5. تجهيز قائمة العملية.
 *
 * يمكن لاحقاً ربط طبقة الإرسال
 * بواجهة مصرح بها من خدمتك.
 */

router.post(
    '/send-all',
    async (req, res) => {

        try {

            const body =
                getBody(req);

            const friendsXml =
                body.friendsXml ||
                body.bsXml ||
                body.bs;

            const cardsXml =
                body.cardsXml ||
                body.myXml;

            if (
                typeof friendsXml !== 'string' ||
                !friendsXml.trim()
            ) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'friendsXml is missing'
                });
            }

            if (
                typeof cardsXml !== 'string' ||
                !cardsXml.trim()
            ) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'cardsXml is missing'
                });
            }

            const friends =
                extractFriends(
                    friendsXml
                );

            const inventory =
                extractCards(
                    cardsXml
                );

            const meta =
                extractMeta(
                    cardsXml
                );

            let friend;

            if (
                body.friend &&
                typeof body.friend === 'object'
            ) {

                friend = {
                    id:
                        s(
                            body.friend.id
                        ).trim(),

                    name:
                        s(
                            body.friend.name
                        ),

                    pic:
                        s(
                            body.friend.pic
                        )
                };

            } else {

                friend = {
                    id:
                        s(
                            body.friendId ||
                            body.toCityId ||
                            body.to_cityId
                        ).trim(),

                    name:
                        s(
                            body.friendName ||
                            body.cityName
                        ),

                    pic:
                        s(
                            body.friendPic ||
                            body.pic
                        )
                };
            }

            if (!friend.id) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'friendId is required'
                });
            }

            const known =
                friends.find(
                    item =>
                        String(item.id) ===
                        String(friend.id)
                );

            if (!known) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'Selected friend was not found in bs.xml'
                });
            }

            if (!friend.name) {
                friend.name =
                    known.name;
            }

            if (!friend.pic) {
                friend.pic =
                    known.pic;
            }

            const cards =
                inventory.cards
                    .map(card => ({
                        cardId:
                            card.cardId,

                        count:
                            card.count,

                        generatedCount:
                            card.generatedCount,

                        isNew:
                            card.isNew,

                        maxInStockCount:
                            card.maxInStockCount
                    }));

            if (!cards.length) {
                return res.status(400).json({
                    ok: false,
                    error:
                        'No sendable cards found in my.xml'
                });
            }

            console.log(
                '[CARDS] SEND PREPARED',
                {
                    friendId:
                        friend.id,

                    cards:
                        cards.length,

                    totalCopies:
                        inventory.totalCopies
                }
            );

            return res.json({
                ok: true,

                mode:
                    'prepared',

                message:
                    'Files analyzed successfully. Sending to the game service is not performed by this endpoint.',

                friend,

                meta,

                distinctCards:
                    inventory.distinctCards,

                totalCopies:
                    inventory.totalCopies,

                totalCards:
                    cards.length,

                cards
            });

        } catch (error) {

            console.error(
                '[CARDS] send-all:',
                error
            );

            return res.status(400).json({
                ok: false,
                error:
                    error.message
            });
        }
    }
);


/* ============================================================
   HEALTH
============================================================ */

router.get(
    '/health',
    (req, res) => {

        return res.json({
            ok: true,
            service:
                'cardsApi',
            sources: {
                friends:
                    'bs.xml',

                cards:
                    'my.xml'
            }
        });

    }
);


/* ============================================================
   EXPORT
============================================================ */

module.exports = router;
