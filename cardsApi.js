'use strict';

const express = require('express');
const fetch = require('node-fetch');
const crypto = require('crypto');
const zlib = require('zlib');
const { XMLParser } = require('fast-xml-parser');

const router = express.Router();

/* ============================================================
   CONFIG
============================================================ */

const KEY = Buffer.from(
    'Wucai6oj0sheiX3p',
    'utf8'
);

const SENDBOX =
    'https://township.playrix.com/api/1/SendBox?cityId=';


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


function blank(v) {
    return !s(v).trim();
}


function hex(buf) {
    return Buffer
        .from(buf)
        .toString('hex');
}


function unhex(str) {
    if (
        !/^[0-9a-fA-F]*$/.test(str) ||
        str.length % 2 !== 0
    ) {
        throw new Error('invalid hex');
    }

    return Buffer.from(str, 'hex');
}


function qjsonPairs(pairs) {
    const obj = {};

    for (const [key, value] of pairs) {
        obj[key] = value;
    }

    return JSON.stringify(obj);
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
        if (!value || typeof value !== 'object') {
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
   FIND NAMED NODE
============================================================ */

function findNamed(root, names) {
    const wanted = new Set(names);
    let result = null;

    walk(root, node => {
        if (result) return;

        const name = node['@_name'];

        if (
            name &&
            wanted.has(name)
        ) {
            result = node;
        }
    });

    return result;
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

        const name = child['@_name'];

        if (
            name &&
            names.includes(name)
        ) {
            const value = valueOf(child);

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

            const name = node['@_name'];

            if (
                !name ||
                !names.includes(name)
            ) {
                return;
            }

            const value = valueOf(node);

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
============================================================ */

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
        if (
            !node ||
            typeof node !== 'object'
        ) {
            return;
        }

        let id = '';
        let name = '';
        let pic = '';

        for (const [key, value] of Object.entries(node)) {
            if (!key.startsWith('@_')) {
                continue;
            }

            const field = key.slice(2);

            if (
                !id &&
                idNames.has(field)
            ) {
                id = s(value).trim();
            }

            if (
                !name &&
                nameNames.has(field)
            ) {
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

            if (
                value != null &&
                s(value).trim()
            ) {
                id = s(value).trim();
            }
        }

        if (!id || seen.has(id)) {
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
============================================================ */

function extractCards(xml) {
    const doc = parser.parse(xml);

    const owned = findNamed(doc, [
        'OwnedCards',
        'ownedCards',
        'OwnedCard'
    ]);

    if (!owned) {
        throw new Error(
            'OwnedCards was not found in XML'
        );
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

        if (
            cardId === undefined ||
            stock === undefined
        ) {
            return;
        }

        const id = s(cardId).trim();
        const count = Number(stock);

        if (
            !id ||
            !Number.isFinite(count) ||
            count <= 0
        ) {
            return;
        }

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

    const cards = [...map.values()];

    const totalCopies = cards.reduce(
        (total, card) =>
            total + card.count,
        0
    );

    return {
        cards,
        distinctCards: cards.length,
        totalCopies,
        totalCards: totalCopies
    };
}


/* ============================================================
   COLLECTION SET
============================================================ */

function collectionSetId(xml, cardId) {
    const match =
        s(cardId).match(
            /^card_(\d+)$/i
        );

    if (!match) {
        return 'set_01';
    }

    const cardNumber =
        Number(match[1]);


    let x = xml.match(
        /<DataElem\s+name="configId"\s+type="string"\s+value="CardCollections_(\d+)"/i
    );

    if (
        x &&
        x[1]
    ) {
        return x[1];
    }


    x = xml.match(
        /<DataElem\s+name="pinnedCardCollectionsBalanceId"\s+type="string"\s+value="CardC(\d+)_Balance"/i
    );

    if (
        x &&
        x[1]
    ) {
        return x[1];
    }


    const block = xml.match(
        /<DataElem\s+name="LastSeenSetProgress"\s+type="dataStore">([\s\S]*?)<\/DataElem>/i
    );

    if (block) {
        const re =
            /<DataElem\s+name="(set_\d+)"\s+type="int"\s+value="(\d+)"\s*\/>/gi;

        let sum = 0;
        let z;

        while (
            (z = re.exec(block[1]))
        ) {
            sum += Number(z[2]);

            if (
                cardNumber <= sum
            ) {
                return z[1].toLowerCase();
            }
        }
    }

    return (
        'set_' +
        String(
            Math.floor(
                (cardNumber - 1) / 10
            ) + 1
        ).padStart(2, '0')
    );
}


/* ============================================================
   COLLECTION EXPIRATION
============================================================ */

function colEtNow(
    nowSec =
        Math.floor(
            Date.now() / 1000
        )
) {
    const day = 86400;
    const nine = 32400;

    const base =
        Math.floor(
            nowSec / day
        ) * day;

    let result =
        base + nine;

    if (result <= nowSec) {
        result =
            base + 118800;
    }

    return result;
}


/* ============================================================
   SEED
============================================================ */

function generateSeed() {
    const buffer =
        crypto.randomBytes(4);

    const n =
        buffer.readInt32BE(0);

    const unsigned =
        n >>> 1;

    const remainder =
        unsigned % 90000;

    return 10000 + remainder;
}


/* ============================================================
   ENCRYPT
============================================================ */

function encryptPayload(json) {
    const gz =
        zlib.gzipSync(
            Buffer.from(
                json,
                'utf8'
            )
        );

    const iv =
        crypto.randomBytes(12);

    const cipher =
        crypto.createCipheriv(
            'aes-128-gcm',
            KEY,
            iv,
            {
                authTagLength: 16
            }
        );

    const encrypted =
        Buffer.concat([
            cipher.update(gz),
            cipher.final()
        ]);

    const tag =
        cipher.getAuthTag();

    return {
        body: encrypted,

        tsId:
            '002' +
            hex(iv) +
            hex(tag)
    };
}


/* ============================================================
   DECRYPT RESPONSE
============================================================ */

function decryptResponse(tsId, body) {
    if (
        !/^002/i.test(tsId) ||
        tsId.length !== 59
    ) {
        throw new Error(
            'response ts-id invalid'
        );
    }

    const iv =
        unhex(
            tsId.slice(
                3,
                27
            )
        );

    const tag =
        unhex(
            tsId.slice(
                27,
                59
            )
        );

    const decipher =
        crypto.createDecipheriv(
            'aes-128-gcm',
            KEY,
            iv,
            {
                authTagLength: 16
            }
        );

    decipher.setAuthTag(tag);

    let output =
        Buffer.concat([
            decipher.update(
                Buffer.from(body)
            ),
            decipher.final()
        ]);

    if (
        output.length >= 2 &&
        output[0] === 0x1f &&
        output[1] === 0x8b
    ) {
        output =
            zlib.gunzipSync(output);
    }

    return output.toString('utf8');
}


/* ============================================================
   SERVER CONFIG
============================================================ */

function configFromEnv() {
    return {
        ownCityId:
            s(
                process.env.CARD_OWN_CITY_ID
            ).trim(),

        ownToken:
            s(
                process.env.CARD_OWN_TOKEN
            ).trim(),

        ownCityName:
            s(
                process.env.CARD_OWN_CITY_NAME ||
                'Township'
            ),

        ownPic:
            s(
                process.env.CARD_OWN_PIC ||
                'ava0'
            ),

        bver:
            s(
                process.env.CARD_BVER
            ).trim(),

        fver:
            s(
                process.env.CARD_FVER
            ).trim(),

        userAgentVersion:
            s(
                process.env.CARD_USER_AGENT_VERSION ||
                ''
            ).trim()
    };
}


/* ============================================================
   VALIDATE CONFIG
============================================================ */

function validateConfig(config) {
    for (
        const key
        of [
            'ownCityId',
            'ownToken',
            'bver',
            'fver'
        ]
    ) {
        if (
            blank(config[key])
        ) {
            throw new Error(
                `Missing server config: ${key}`
            );
        }
    }
}


/* ============================================================
   BUILD BOX
============================================================ */

function buildBox(
    config,
    friend,
    cardId,
    setId,
    sendCounter,
    colEt,
    seed
) {
    const from =
        qjsonPairs([
            [
                'city_id',
                config.ownCityId
            ],

            [
                'friend_city_name',
                friend.name || ''
            ],

            [
                'pic',
                config.ownPic || 'ava0'
            ]
        ]);

    const box =
        qjsonPairs([
            [
                'afg',
                3
            ],

            [
                'box_type',
                'collections_send_card'
            ],

            [
                'card_id',
                cardId
            ],

            [
                'col_et',
                colEt
            ],

            [
                'col_id',
                setId
            ],

            [
                'friend_type',
                'send_friend'
            ],

            [
                'from',
                from
            ],

            [
                'seed',
                String(seed)
            ],

            [
                'sendCounter',
                sendCounter
            ],

            [
                'set_id',
                setId
            ],

            [
                'to',
                friend.id
            ],

            [
                'type',
                'box'
            ]
        ]);

    return qjsonPairs([
        [
            'box',
            box
        ],

        [
            'cityId',
            config.ownCityId
        ],

        [
            'to_cityId',
            friend.id
        ]
    ]);
}


/* ============================================================
   SEND ONE
============================================================ */

async function sendOne(
    config,
    friend,
    cardId,
    setId,
    sendCounter
) {
    const seed =
        generateSeed();

    const payload =
        buildBox(
            config,
            friend,
            cardId,
            setId,
            sendCounter,
            colEtNow(),
            seed
        );

    const encrypted =
        encryptPayload(
            payload
        );

    const url =
        SENDBOX +
        encodeURIComponent(
            config.ownCityId
        );

    const headers = {
        'Content-Type':
            'application/octet-stream',

        'IsNewClanUIEnabled':
            'true',

        'User-Agent':
            `Township/${config.userAgentVersion || config.bver} (Android 13)`,

        'ts-bp':
            'g',

        'ts-bver':
            config.bver,

        'ts-fver':
            config.fver,

        'ts-gpid':
            'new',

        'ts-id':
            encrypted.tsId,

        'ts-token':
            config.ownToken,

        'x-version':
            config.bver
    };

    const response =
        await fetch(
            url,
            {
                method: 'POST',
                headers,
                body: encrypted.body
            }
        );

    const raw =
        Buffer.from(
            await response.arrayBuffer()
        );

    const responseTsId =
        response.headers.get(
            'ts-id'
        ) || '';

    let decoded = '';
    let parsed = null;
    let decryptError = null;

    if (
        responseTsId &&
        raw.length
    ) {
        try {
            decoded =
                decryptResponse(
                    responseTsId,
                    raw
                );

            try {
                parsed =
                    JSON.parse(
                        decoded
                    );
            } catch (_) {
                parsed = null;
            }

        } catch (error) {
            decryptError =
                error.message;
        }
    }

    let resultObject = null;

    if (
        parsed &&
        parsed.result &&
        typeof parsed.result === 'object'
    ) {
        resultObject =
            parsed.result;
    }

    /*
     * لا نعتبر HTTP 200 وحده نجاحًا.
     */
    const hasEmptyResult =
        resultObject &&
        Object.keys(resultObject).length === 0;

    const accepted =
        response.status >= 200 &&
        response.status < 300 &&
        hasEmptyResult;

    return {
        cardId,
        setId,
        sendCounter,
        seed,

        httpStatus:
            response.status,

        accepted:
            Boolean(accepted),

        responseTsId,

        response:
            parsed,

        responseText:
            decoded ||
            (
                raw.length
                    ? raw.toString('utf8')
                    : ''
            ),

        decryptError
    };
}


/* ============================================================
   BODY
============================================================ */

function getBody(req) {
    if (
        typeof req.body === 'string'
    ) {
        try {
            return JSON.parse(
                req.body
            );
        } catch (_) {
            return {
                xml: req.body
            };
        }
    }

    return req.body || {};
}


/* ============================================================
   ANALYZE
============================================================ */

router.post('/analyze', (req, res) => {
    try {
        const body =
            getBody(req);

        const xml =
            body.xml ||
            body.myXml;

        if (!xml) {
            return res.status(400).json({
                ok: false,
                error: 'XML is missing'
            });
        }

        const meta =
            extractMeta(xml);

        const friends =
            extractFriends(xml);

        const inventory =
            extractCards(xml);

        console.log(
            '[CARDS] ANALYZE',
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
            '[CARDS] analyze:',
            error
        );

        return res.status(400).json({
            ok: false,
            error: error.message
        });
    }
});


/* ============================================================
   SELECT FRIEND
============================================================ */

router.post('/select', (req, res) => {
    try {
        const body =
            getBody(req);

        const xml =
            body.xml ||
            body.myXml;

        const friend =
            body.friend;

        if (!xml) {
            return res.status(400).json({
                ok: false,
                error: 'XML is missing'
            });
        }

        if (
            !friend ||
            !friend.id
        ) {
            return res.status(400).json({
                ok: false,
                error: 'friend.id is required'
            });
        }

        const friends =
            extractFriends(xml);

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
                    'Selected friend was not found in XML'
            });
        }

        const inventory =
            extractCards(xml);

        return res.json({
            ok: true,

            friend:
                selected,

            distinctCards:
                inventory.distinctCards,

            totalCopies:
                inventory.totalCopies,

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
            error: error.message
        });
    }
});


/* ============================================================
   SEND ALL
============================================================ */

router.post('/send-all', async (req, res) => {
    try {
        const body =
            getBody(req);

        const xml =
            body.xml ||
            body.myXml;

        if (!xml) {
            return res.status(400).json({
                ok: false,
                error: 'XML is missing'
            });
        }


        /* ----------------------------------------------------
           CONFIG
        ---------------------------------------------------- */

        const config =
            configFromEnv();

        const meta =
            extractMeta(xml);


        /*
         * إذا لم يتم تحديد City ID في البيئة،
         * نستخدم City ID الموجود داخل XML.
         */
        if (
            blank(config.ownCityId) &&
            !blank(meta.cityId)
        ) {
            config.ownCityId =
                s(meta.cityId).trim();
        }


        validateConfig(config);


        /* ----------------------------------------------------
           FRIEND
        ---------------------------------------------------- */

        let friend;

        if (
            body.friend &&
            typeof body.friend === 'object'
        ) {
            friend = {
                id:
                    body.friend.id,

                name:
                    body.friend.name || '',

                pic:
                    body.friend.pic || ''
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

        friend.id =
            s(friend.id).trim();

        friend.name =
            s(friend.name);

        friend.pic =
            s(friend.pic);


        if (!friend.id) {
            return res.status(400).json({
                ok: false,
                error: 'friendId is required'
            });
        }


        /* ----------------------------------------------------
           VERIFY FRIEND
        ---------------------------------------------------- */

        const friends =
            extractFriends(xml);

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
                    'Selected friend was not found in XML'
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


        /* ----------------------------------------------------
           CARDS
        ---------------------------------------------------- */

        const inventory =
            extractCards(xml);

        const ids =
            inventory.cards
                .map(
                    card =>
                        card.cardId
                )
                .filter(Boolean);


        if (!ids.length) {
            return res.status(400).json({
                ok: false,
                error:
                    'No sendable cards found'
            });
        }


        /* ----------------------------------------------------
           COUNTER
        ---------------------------------------------------- */

        const startCounter =
            Number.isFinite(
                Number(
                    meta.totalSendCards
                )
            )
                ? Number(
                    meta.totalSendCards
                )
                : 0;


        const results = [];


        /* ----------------------------------------------------
           SEND
        ---------------------------------------------------- */

        for (
            let i = 0;
            i < ids.length;
            i++
        ) {
            const cardId =
                ids[i];

            const setId =
                collectionSetId(
                    xml,
                    cardId
                );

            const sendCounter =
                startCounter + i;

            try {
                console.log(
                    '[CARDS] SEND',
                    {
                        cardId,
                        setId,
                        friendId:
                            friend.id,
                        sendCounter
                    }
                );

                const result =
                    await sendOne(
                        config,
                        friend,
                        cardId,
                        setId,
                        sendCounter
                    );

                results.push(
                    result
                );

                console.log(
                    '[CARDS] RESULT',
                    {
                        cardId:
                            result.cardId,

                        status:
                            result.httpStatus,

                        accepted:
                            result.accepted,

                        response:
                            result.response
                    }
                );

            } catch (error) {
                results.push({
                    cardId,
                    setId,
                    sendCounter,
                    accepted: false,
                    error:
                        error.message
                });

                console.error(
                    '[CARDS] SEND ERROR',
                    {
                        cardId,
                        error:
                            error.message
                    }
                );
            }
        }


        /* ----------------------------------------------------
           RESULT
        ---------------------------------------------------- */

        const accepted =
            results.filter(
                item =>
                    item.accepted === true
            );

        const failed =
            results.filter(
                item =>
                    item.accepted !== true
            );


        return res.json({
            ok:
                failed.length === 0,

            friend,

            distinctCards:
                inventory.distinctCards,

            totalCopies:
                inventory.totalCopies,

            totalCards:
                ids.length,

            sentCards:
                accepted.length,

            failed:
                failed.length,

            totalSendCardsBefore:
                startCounter,

            totalSendCardsAfter:
                startCounter +
                ids.length,

            sentCardIds:
                accepted.map(
                    item =>
                        item.cardId
                ),

            failedCards:
                failed,

            results
        });

    } catch (error) {
        console.error(
            '[CARDS] send-all:',
            error
        );

        return res.status(400).json({
            ok: false,
            error: error.message
        });
    }
});


/* ============================================================
   EXPORT
============================================================ */

module.exports = router;
