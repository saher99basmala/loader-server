'use strict';

const express = require('express');
const { XMLParser } = require('fast-xml-parser');

const router = express.Router();

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

function walk(node, fn, seen = new Set()) {
    if (!node || typeof node !== 'object' || seen.has(node)) {
        return;
    }

    seen.add(node);
    fn(node);

    for (const value of Object.values(node)) {
        if (!value || typeof value !== 'object') continue;

        for (const x of arr(value)) {
            if (x && typeof x === 'object') {
                walk(x, fn, seen);
            }
        }
    }
}

function valueOf(node) {
    if (!node || typeof node !== 'object') {
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

function getField(node, names) {
    if (!node || typeof node !== 'object') {
        return undefined;
    }

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

            if (value !== undefined) {
                return value;
            }
        }
    }

    return undefined;
}

function findNamed(root, names) {
    const wanted = new Set(names);
    let result = null;

    walk(root, node => {
        if (result) return;

        const name = node['@_name'];

        if (name && wanted.has(name)) {
            result = node;
        }
    });

    return result;
}

function extractMeta(xml) {
    const doc = parser.parse(xml);

    const find = names => {
        let result;

        walk(doc, node => {
            if (result !== undefined) return;

            const name = node['@_name'];

            if (!name || !names.includes(name)) return;

            const value = valueOf(node);

            if (value !== undefined) {
                result = value;
            }
        });

        return result;
    };

    return {
        cityId: find(['cityId', 'city_id']) || null,
        gameId: find(['gameId', 'game_id']) || null,
        townName:
            find(['townName', 'city_name', 'name']) || null,
        experience: find(['experience']) || null
    };
}

function extractFriends(xml) {
    const doc = parser.parse(xml);

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
        if (!node || typeof node !== 'object') return;

        let id = '';
        let name = '';
        let pic = '';

        for (const [key, value] of Object.entries(node)) {
            if (!key.startsWith('@_')) continue;

            const field = key.slice(2);

            if (!id && idNames.has(field)) {
                id = s(value).trim();
            }

            if (!name && nameNames.has(field)) {
                name = s(value);
            }

            if (
                field === 'pic' ||
                field === 'picture' ||
                field === 'avatar'
            ) {
                pic = s(value);
            }
        }

        if (!id) {
            const value = valueOf(node);

            if (value != null) {
                id = s(value).trim();
            }
        }

        if (!id || seen.has(id)) return;

        seen.add(id);

        friends.push({
            id,
            name,
            pic
        });
    }

    walk(doc, node => {
        const nodeName = s(node['@_name']);

        if (
            nodeName === 'FriendsList' ||
            /friend/i.test(nodeName)
        ) {
            for (const child of arr(node.DataElem)) {
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

function extractCards(xml) {
    const doc = parser.parse(xml);

    const owned = findNamed(doc, [
        'OwnedCards',
        'ownedCards',
        'OwnedCard'
    ]);

    if (!owned) {
        throw new Error('OwnedCards was not found in XML');
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

        if (cardId === undefined || stock === undefined) {
            return;
        }

        const id = s(cardId).trim();
        const count = Number(stock);

        if (!id || !Number.isFinite(count) || count <= 0) {
            return;
        }

        if (!map.has(id)) {
            map.set(id, {
                cardId: id,
                count: 0
            });
        }

        map.get(id).count += count;
    });

    const cards = [...map.values()];

    const totalCopies = cards.reduce(
        (total, card) => total + card.count,
        0
    );

    return {
        cards,
        distinctCards: cards.length,
        totalCopies
    };
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

/*
 * تحليل XML
 */
router.post('/analyze', (req, res) => {
    try {
        const body = getBody(req);
        const xml = body.xml || body.myXml;

        if (!xml) {
            return res.status(400).json({
                ok: false,
                error: 'XML is missing'
            });
        }

        const meta = extractMeta(xml);
        const friends = extractFriends(xml);
        const inventory = extractCards(xml);

        return res.json({
            ok: true,
            meta,
            friends,
            cards: inventory.cards,
            distinctCards: inventory.distinctCards,
            totalCopies: inventory.totalCopies,
            totalCards: inventory.totalCopies
        });

    } catch (error) {
        console.error('[CARDS] analyze:', error);

        return res.status(400).json({
            ok: false,
            error: error.message
        });
    }
});

/*
 * استقبال الصديق المختار.
 * لا ينفذ أي طلب خارجي لتعديل اللعبة.
 */
router.post('/select', (req, res) => {
    try {
        const body = getBody(req);

        const xml = body.xml || body.myXml;
        const friend = body.friend;

        if (!xml) {
            return res.status(400).json({
                ok: false,
                error: 'XML is missing'
            });
        }

        if (!friend || !friend.id) {
            return res.status(400).json({
                ok: false,
                error: 'friend.id is required'
            });
        }

        const friends = extractFriends(xml);

        const selected = friends.find(
            x => String(x.id) === String(friend.id)
        );

        if (!selected) {
            return res.status(400).json({
                ok: false,
                error: 'Selected friend was not found in XML'
            });
        }

        const inventory = extractCards(xml);

        return res.json({
            ok: true,

            friend: selected,

            distinctCards:
                inventory.distinctCards,

            totalCopies:
                inventory.totalCopies,

            cards:
                inventory.cards
        });

    } catch (error) {
        console.error('[CARDS] select:', error);

        return res.status(400).json({
            ok: false,
            error: error.message
        });
    }
});

module.exports = router;
