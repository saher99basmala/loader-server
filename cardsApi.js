'use strict';

const express = require('express');
const fetch = require('node-fetch');
const crypto = require('crypto');
const zlib = require('zlib');
const { XMLParser } = require('fast-xml-parser');

const app = express();

app.use(express.json({ limit: '20mb' }));
app.use(express.text({
    type: ['text/xml', 'application/xml'],
    limit: '20mb'
}));

const PORT =
    Number(process.env.PORT || 3000);

const parser =
    new XMLParser({
        ignoreAttributes: false,
        attributeNamePrefix: '@_',
        trimValues: false,
        parseTagValue: false,
        parseAttributeValue: false
    });

const KEY =
    Buffer.from(
        'Wucai6oj0sheiX3p',
        'utf8'
    );

const SENDBOX =
    'https://township.playrix.com/api/1/SendBox?cityId=';


/* ============================================================
   HELPERS
============================================================ */

function arr(v) {
    return v == null
        ? []
        : Array.isArray(v)
            ? v
            : [v];
}


function s(v) {
    return v == null
        ? ''
        : String(v);
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
        str.length % 2
    ) {
        throw new Error(
            'invalid hex'
        );
    }

    return Buffer.from(
        str,
        'hex'
    );
}


function qjsonPairs(pairs) {

    const o = {};

    for (
        const [k, v]
        of pairs
    ) {
        o[k] = v;
    }

    return JSON.stringify(o);
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
   DECRYPT
============================================================ */

function decryptResponse(
    tsId,
    body
) {

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

    let out =
        Buffer.concat([
            decipher.update(
                Buffer.from(body)
            ),
            decipher.final()
        ]);

    if (
        out.length >= 2 &&
        out[0] === 0x1f &&
        out[1] === 0x8b
    ) {
        out =
            zlib.gunzipSync(out);
    }

    return out.toString('utf8');
}


/* ============================================================
   RECURSIVE WALK
============================================================ */

function walk(
    node,
    fn,
    seen = new Set()
) {

    if (
        !node ||
        typeof node !== 'object' ||
        seen.has(node)
    ) {
        return;
    }

    seen.add(node);

    fn(node);

    for (
        const value
        of Object.values(node)
    ) {

        if (
            value &&
            typeof value === 'object'
        ) {

            for (
                const x
                of arr(value)
            ) {

                if (
                    x &&
                    typeof x === 'object'
                ) {

                    walk(
                        x,
                        fn,
                        seen
                    );
                }
            }
        }
    }
}


/* ============================================================
   FIND NAMED NODE
============================================================ */

function findNamed(
    root,
    names
) {

    const wanted =
        new Set(names);

    let hit = null;

    walk(
        root,
        node => {

            if (hit) {
                return;
            }

            const name =
                node['@_name'];

            if (
                name &&
                wanted.has(name)
            ) {
                hit = node;
            }
        }
    );

    return hit;
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

    if (
        node['@_value'] !== undefined
    ) {
        return node['@_value'];
    }

    if (
        node['@_v'] !== undefined
    ) {
        return node['@_v'];
    }

    return undefined;
}


/* ============================================================
   FIELD
============================================================ */

function getField(
    node,
    names
) {

    if (
        !node ||
        typeof node !== 'object'
    ) {
        return undefined;
    }


    for (
        const name
        of names
    ) {

        if (
            node['@_' + name] !== undefined
        ) {

            return node[
                '@_' + name
            ];
        }
    }


    for (
        const child
        of arr(node.DataElem)
    ) {

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

            if (
                value !== undefined
            ) {

                return value;
            }
        }
    }


    return undefined;
}


/* ============================================================
   EXTRACT CARDS
============================================================ */

function extractCards(xml) {

    const doc =
        parser.parse(xml);

    const owned =
        findNamed(
            doc,
            [
                'OwnedCards',
                'ownedCards',
                'OwnedCard'
            ]
        );


    if (!owned) {

        throw new Error(
            'OwnedCards was not found in XML'
        );
    }


    const map =
        new Map();


    walk(
        owned,
        node => {

            const cardId =
                getField(
                    node,
                    [
                        'cardId',
                        'card_id',
                        'CardId',
                        'id'
                    ]
                );


            const stock =
                getField(
                    node,
                    [
                        'inStockCount',
                        'in_stock_count',
                        'InStockCount',
                        'stockCount'
                    ]
                );


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
                    getField(
                        node,
                        [
                            'generatedCount',
                            'generated_count'
                        ]
                    ) || 0
                );


            const maxStock =
                Number(
                    getField(
                        node,
                        [
                            'maxInStockCount',
                            'max_in_stock_count'
                        ]
                    ) || 0
                );


            const isNew =
                getField(
                    node,
                    [
                        'isNew',
                        'is_new'
                    ]
                );


            if (
                !map.has(id)
            ) {

                map.set(
                    id,
                    {
                        cardId: id,
                        count: 0,
                        generatedCount:
                            Number.isFinite(
                                generated
                            )
                                ? generated
                                : 0,
                        isNew:
                            String(
                                isNew || 'false'
                            ),
                        maxInStockCount:
                            Number.isFinite(
                                maxStock
                            )
                                ? maxStock
                                : 0
                    }
                );
            }


            const item =
                map.get(id);

            item.count += count;
        }
    );


    const cards =
        [...map.values()];


    const totalCopies =
        cards.reduce(
            (
                total,
                card
            ) =>
                total +
                card.count,
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
   META
============================================================ */

function extractMeta(xml) {

    const doc =
        parser.parse(xml);


    const find =
        names => {

            let result;


            walk(
                doc,
                node => {

                    if (
                        result !== undefined
                    ) {
                        return;
                    }


                    const name =
                        node['@_name'];


                    if (
                        name &&
                        names.includes(name)
                    ) {

                        const value =
                            valueOf(node);


                        if (
                            value !== undefined
                        ) {

                            result = value;
                        }
                    }
                }
            );


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

    const doc =
        parser.parse(xml);

    const out = [];

    const seen =
        new Set();


    const idNames =
        new Set([
            'cityId',
            'city_id',
            'gameId',
            'friendId',
            'friend_id',
            'id'
        ]);


    const nameNames =
        new Set([
            'name',
            'cityName',
            'city_name',
            'townName',
            'friendName'
        ]);


    function add(obj) {

        if (
            !obj ||
            typeof obj !== 'object'
        ) {
            return;
        }


        let id = null;
        let name = null;
        let pic = null;


        for (
            const [
                key,
                value
            ]
            of Object.entries(obj)
        ) {

            if (
                !key.startsWith('@_')
            ) {
                continue;
            }


            const n =
                key.slice(2);


            if (
                idNames.has(n) &&
                blank(id)
            ) {

                id = value;
            }


            if (
                nameNames.has(n) &&
                blank(name)
            ) {

                name = value;
            }


            if (
                n === 'pic' ||
                n === 'picture' ||
                n === 'avatar'
            ) {

                pic = value;
            }
        }


        if (id == null) {

            const v =
                valueOf(obj);


            if (
                v != null &&
                String(v).trim()
            ) {

                id = v;
            }
        }


        if (
            id == null ||
            !String(id).trim()
        ) {
            return;
        }


        id =
            String(id).trim();


        if (
            seen.has(id)
        ) {
            return;
        }


        seen.add(id);


        out.push({

            id,

            name:
                name == null
                    ? ''
                    : String(name),

            pic:
                pic == null
                    ? ''
                    : String(pic)
        });
    }


    walk(
        doc,
        node => {

            if (
                node['@_name'] ===
                    'FriendsList'
                ||
                /friend/i.test(
                    String(
                        node['@_name'] || ''
                    )
                )
            ) {

                for (
                    const x
                    of arr(node.DataElem)
                ) {

                    add(x);
                }
            }


            if (
                node['@_cityId'] ||
                node['@_city_id'] ||
                node['@_friendId']
            ) {

                add(node);
            }
        }
    );


    return out;
}


/* ============================================================
   COLLECTION SET
============================================================ */

function collectionSetId(
    xml,
    cardId
) {

    const m =
        s(cardId).match(
            /^card_(\d+)$/i
        );


    if (!m) {
        return 'set_01';
    }


    const n =
        Number(m[1]);


    let x =
        xml.match(
            /<DataElem\s+name="configId"\s+type="string"\s+value="CardCollections_(\d+)"/i
        );


    if (
        x &&
        x[1]
    ) {

        return x[1];
    }


    x =
        xml.match(
            /<DataElem\s+name="pinnedCardCollectionsBalanceId"\s+type="string"\s+value="CardC(\d+)_Balance"/i
        );


    if (
        x &&
        x[1]
    ) {

        return x[1];
    }


    const block =
        xml.match(
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

            sum +=
                Number(z[2]);


            if (
                n <= sum
            ) {

                return z[1].toLowerCase();
            }
        }
    }


    return (
        'set_' +
        String(
            Math.floor(
                (n - 1) / 10
            ) + 1
        ).padStart(
            2,
            '0'
        )
    );
}


/* ============================================================
   COL ET
============================================================ */

function colEtNow(
    nowSec =
        Math.floor(
            Date.now() / 1000
        )
) {

    const day =
        86400;

    const nine =
        32400;

    const base =
        Math.floor(
            nowSec / day
        ) * day;


    let t =
        base + nine;


    if (
        t <= nowSec
    ) {

        t =
            base + 118800;
    }


    return t;
}


/* ============================================================
   SEED
============================================================ */

function generateSeed() {

    const b =
        crypto.randomBytes(4);


    const n =
        b.readInt32BE(0);


    const unsigned =
        n >>> 1;


    const remainder =
        unsigned % 90000;


    return 10000 + remainder;
}


/* ============================================================
   BUILD BOX
============================================================ */

function buildBox(
    cfg,
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
                cfg.ownCityId
            ],

            [
                'friend_city_name',
                friend.name || ''
            ],

            [
                'pic',
                cfg.ownPic || 'ava0'
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
            cfg.ownCityId
        ],

        [
            'to_cityId',
            friend.id
        ]
    ]);
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
   VALIDATE
============================================================ */

function validateConfig(c) {

    for (
        const k
        of [
            'ownCityId',
            'ownToken',
            'bver',
            'fver'
        ]
    ) {

        if (
            blank(c[k])
        ) {

            throw new Error(
                `Missing server config: ${k}`
            );
        }
    }
}


/* ============================================================
   SEND ONE
============================================================ */

async function sendOne(
    cfg,
    friend,
    cardId,
    setId,
    sendCounter
) {

    const seed =
        generateSeed();


    const payload =
        buildBox(
            cfg,
            friend,
            cardId,
            setId,
            sendCounter,
            colEtNow(),
            seed
        );


    const enc =
        encryptPayload(
            payload
        );


    const url =
        SENDBOX +
        encodeURIComponent(
            cfg.ownCityId
        );


    const headers = {

        'Content-Type':
            'application/octet-stream',

        'IsNewClanUIEnabled':
            'true',

        'User-Agent':
            `Township/${cfg.userAgentVersion || cfg.bver} (Android 13)`,

        'ts-bp':
            'g',

        'ts-bver':
            cfg.bver,

        'ts-fver':
            cfg.fver,

        'ts-gpid':
            'new',

        'ts-id':
            enc.tsId,

        'ts-token':
            cfg.ownToken,

        'x-version':
            cfg.bver
    };


    const r =
        await fetch(
            url,
            {
                method: 'POST',
                headers,
                body: enc.body
            }
        );


    const raw =
        Buffer.from(
            await r.arrayBuffer()
        );


    const responseTsId =
        r.headers.get(
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

            } catch (_) {}

        } catch (e) {

            decryptError =
                e.message;
        }
    }


    const resultObject =
        parsed &&
        parsed.result &&
        typeof parsed.result === 'object'
            ? parsed.result
            : null;


    const accepted =
        r.status >= 200 &&
        r.status < 300 &&
        resultObject &&
        Object.keys(
            resultObject
        ).length === 0;


    return {

        cardId,

        setId,

        sendCounter,

        seed,

        httpStatus:
            r.status,

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

app.post(
    '/api/cards/analyze',
    (req, res) => {

        try {

            const b =
                getBody(req);


            const xml =
                b.xml ||
                b.myXml;


            if (!xml) {

                throw new Error(
                    'XML is missing'
                );
            }


            const meta =
                extractMeta(
                    xml
                );


            const inventory =
                extractCards(
                    xml
                );


            const friends =
                extractFriends(
                    xml
                );


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


            res.json({

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

        } catch (e) {

            console.error(
                '[CARDS] analyze:',
                e
            );


            res.status(400).json({

                ok: false,

                error:
                    e.message
            });
        }
    }
);


/* ============================================================
   SEND ALL
============================================================ */

app.post(
    '/api/cards/send-all',
    async (req, res) => {

        try {

            const b =
                getBody(req);


            const xml =
                b.xml ||
                b.myXml;


            if (!xml) {

                throw new Error(
                    'XML is missing'
                );
            }


            const cfg =
                configFromEnv();


            const meta =
                extractMeta(
                    xml
                );


            /*
             * إذا لم يتم وضع CARD_OWN_CITY_ID
             * نستخدم cityId الموجود في XML.
             */
            if (
                blank(
                    cfg.ownCityId
                ) &&
                !blank(
                    meta.cityId
                )
            ) {

                cfg.ownCityId =
                    s(
                        meta.cityId
                    ).trim();
            }


            validateConfig(
                cfg
            );


            let friend;


            if (
                b.friend &&
                typeof b.friend === 'object'
            ) {

                friend = {

                    id:
                        b.friend.id,

                    name:
                        b.friend.name || '',

                    pic:
                        b.friend.pic || ''
                };

            } else {

                friend = {

                    id:
                        b.friendId ||
                        b.toCityId ||
                        b.to_cityId,

                    name:
                        b.friendName ||
                        b.cityName ||
                        '',

                    pic:
                        b.friendPic ||
                        b.pic ||
                        ''
                };
            }


            friend.id =
                s(
                    friend.id
                ).trim();


            friend.name =
                s(
                    friend.name
                );


            friend.pic =
                s(
                    friend.pic
                );


            if (
                !friend.id
            ) {

                throw new Error(
                    'friendId is required'
                );
            }


            /*
             * التأكد أن الصديق موجود
             * في XML المرسل.
             */
            const friends =
                extractFriends(
                    xml
                );


            const known =
                friends.find(
                    x =>
                        x.id ===
                        friend.id
                );


            if (!known) {

                throw new Error(
                    'Selected friend was not found in XML'
                );
            }


            if (
                !friend.name
            ) {

                friend.name =
                    known.name;
            }


            if (
                !friend.pic
            ) {

                friend.pic =
                    known.pic;
            }


            const inv =
                extractCards(
                    xml
                );


            const ids =
                [
                    ...new Set(
                        inv.cards
                            .map(
                                x =>
                                    x.cardId
                            )
                            .filter(
                                Boolean
                            )
                    )
                ];


            if (
                !ids.length
            ) {

                throw new Error(
                    'No sendable cards found'
                );
            }


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


                try {

                    const result =
                        await sendOne(
                            cfg,
                            friend,
                            cardId,
                            setId,
                            startCounter + i
                        );


                    results.push(
                        result
                    );

                } catch (e) {

                    results.push({

                        cardId,

                        setId,

                        sendCounter:
                            startCounter + i,

                        accepted:
                            false,

                        error:
                            e.message
                    });
                }
            }


            const accepted =
                results.filter(
                    x =>
                        x.accepted
                );


            const failed =
                results.filter(
                    x =>
                        !x.accepted
                );


            res.json({

                ok:
                    failed.length === 0,

                friend,

                distinctCards:
                    inv.distinctCards,

                totalCopies:
                    inv.totalCopies,

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
                        x =>
                            x.cardId
                    ),

                failedCards:
                    failed,

                results
            });

        } catch (e) {

            console.error(
                '[CARDS] send-all:',
                e
            );


            res.status(400).json({

                ok: false,

                error:
                    e.message
            });
        }
    }
);


/* ============================================================
   HEALTH
============================================================ */

app.get(
    '/health',
    (_req, res) => {

        res.json({
            ok: true
        });
    }
);


/* ============================================================
   START
============================================================ */

app.listen(
    PORT,
    () => {

        console.log(
            `[CARDS] server listening on ${PORT}`
        );

    }
);
