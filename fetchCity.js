/* ============================================================
   fetchCity.js
   COMPLETE SERVER
   ============================================================ */

"use strict";

const express = require("express");
const crypto = require("crypto");
const zlib = require("zlib");

const app = express();

const PORT = Number(process.env.PORT || 3000);

const AES_KEY = Buffer.from(
    process.env.FETCHCITY_AES_KEY || "Wucai6oj0sheiX3p",
    "utf8"
);

const ENDPOINT =
    process.env.FETCHCITY_ENDPOINT ||
    "https://township.playrix.com/api/1/FetchCity?cityId=";

const TIMEOUT_MS =
    Number(process.env.FETCHCITY_TIMEOUT_MS || 25000);

/* ============================================================
   JSON
   ============================================================ */

app.use(
    express.json({
        limit: "50mb"
    })
);

app.use(
    express.urlencoded({
        extended: true,
        limit: "50mb"
    })
);

/* ============================================================
   SAVECRYPTO CONSTANTS
   ============================================================ */

const TABLE_SIZE = 0x2D7;
const PROCESS_XOR = 0x396A8;
const TOTAL_XOR = 0xC5EED;
const TABLE_MULTIPLIER = 0x5BD1E995;

const LZ4_MAGIC = Buffer.from([
    0x04,
    0x22,
    0x4D,
    0x18
]);

/* ============================================================
   FETCH54 TABLE
   ============================================================ */

const FETCH54_TABLE = Buffer.from(
    "d192KFBTVDZLSDBPSkIwNHh4PlJDMyFrUngqfCsyNV5PU2guWCcmTj5gbTlLZklXb3xTMmpoYmMgZlRkN2FTWjZSQmdRYkwpZlcxMWI8J0dXJ00pTiNsbF5xWntdOmJhakBudjlLZUXlgKDgnJkUyeSo8biZSak9lb2lPRTNbP0lMTys/ZFNAdXxddlZJSGdpdnR3I19ybG9nTD9yY2xKa0EyVjZkSF9hdiB1OWZ3JFZnaiVBdEJHK2RSRSg6bih0SSdiNDc/c3phSU5rbTh7PDdqTCN0O1NKO0knX3ZyVkNveiFvcGg0cC9kdW1UKDZ4ezNRfiZtbWEpJS9+QlJjbm9qeVRmVC55cW4mc2s5ajtheTNwZyssY2NKRz1URXUySy0qZCVJVSpZMk4pLn17VVBfTip4P1pdX2wsXXZ+J21ydkIpdUcuc3cyUCVRK3xOUUxgPklmeUx3ZF0sST9mK2lnOm84cyNMUk15KCQwWTJWelhCRVZ+UXVCZ1J+eVplb2gtY0NAcUA+Ni1WdlQyLFpTV2xVfnRoKyUwfFdfaVBsfU0wdW4/cHlkcXVsYHxaTGB1N3JtMUwwZXd6NGM5KmZuUlpGOjgoOyYlNltHbj4sTFhXOUY/UVE0MSg6NXN2ckdWI3snMyldMi82bG5bc1lkczpxVGRCaDhPeUI8I1EhVSVRJ1tkK3IlKU9CT3V5XSE9fWFnMEdQNlp+YCs5PnJGJmBfOF59Tn5YMDJEKUgjfWFPKTA4dHF4OixPJmZOcHtSJFc+KU1CZUxpfFJYOi56JzVCJWddMTNFZiB5JUs/e1JBcGdrey4xKSxBT1toVXlJLm98cUBwXiBNczFJNyBadWI6YSdPNFknXzA7WG1afnZLPW5KI3dZQ2Njbl5Dekp1NDxmNW9neV19I0s1RklsS25ud1RfXmRWQVpndl1EIFdJdEBzbCFpPSlxeG5XaA==",
    "base64"
);

/* ============================================================
   FETCH IMPLEMENTATION
   ============================================================ */

let fetchImpl;

try {
    fetchImpl =
        globalThis.fetch ||
        require("node-fetch");
} catch (e) {
    fetchImpl = require("node-fetch");
}

/* ============================================================
   BASIC UTILS
   ============================================================ */

function u32le(buf, offset) {

    if (
        !Buffer.isBuffer(buf) ||
        offset < 0 ||
        offset + 4 > buf.length
    ) {
        throw new Error(
            "u32le خارج حدود البيانات"
        );
    }

    return (
        (
            buf[offset] |
            (buf[offset + 1] << 8) |
            (buf[offset + 2] << 16) |
            (buf[offset + 3] << 24)
        ) >>> 0
    );
}

function xor32(a, b) {
    return (a ^ b) >>> 0;
}

function add32(a, b) {
    return (a + b) >>> 0;
}

function sub32(a, b) {
    return (a - b) >>> 0;
}

function bufferMagic(buf) {

    if (
        !Buffer.isBuffer(buf) ||
        buf.length < 4
    ) {
        return "";
    }

    return Array.from(
        buf.subarray(0, 4)
    )
        .map(
            x =>
                x
                    .toString(16)
                    .padStart(2, "0")
        )
        .join(" ");
}

function u24le(buf, offset) {

    if (
        !Buffer.isBuffer(buf) ||
        offset + 3 > buf.length
    ) {
        throw new Error(
            "u24le خارج حدود البيانات"
        );
    }

    return (
        buf[offset] |
        (buf[offset + 1] << 8) |
        (buf[offset + 2] << 16)
    ) >>> 0;
}

function isLz4Magic(buf) {

    return (
        Buffer.isBuffer(buf) &&
        buf.length >= 4 &&
        buf[0] === 0x04 &&
        buf[1] === 0x22 &&
        buf[2] === 0x4D &&
        buf[3] === 0x18
    );
}

function isGzip(buf) {

    return (
        Buffer.isBuffer(buf) &&
        buf.length >= 2 &&
        buf[0] === 0x1F &&
        buf[1] === 0x8B
    );
}

function looksLikeXml(buf) {

    if (
        !Buffer.isBuffer(buf) ||
        buf.length === 0
    ) {
        return false;
    }

    const text =
        buf
            .subarray(
                0,
                Math.min(
                    buf.length,
                    512
                )
            )
            .toString("utf8")
            .replace(/^\uFEFF/, "")
            .trimStart();

    return (
        text.startsWith("<") ||
        text.startsWith("<?xml")
    );
}

function looksLikeJson(buf) {

    if (
        !Buffer.isBuffer(buf) ||
        buf.length === 0
    ) {
        return false;
    }

    const text =
        buf
            .subarray(
                0,
                Math.min(
                    buf.length,
                    512
                )
            )
            .toString("utf8")
            .trimStart();

    return (
        text.startsWith("{") ||
        text.startsWith("[")
    );
}

/* ============================================================
   0x79
   OLD ALGORITHM
   ============================================================ */

function build79Table(seed) {

    const table =
        Buffer.alloc(
            TABLE_SIZE
        );

    let state =
        seed >>> 0;

    for (
        let i = 0;
        i < TABLE_SIZE;
        i++
    ) {

        state =
            Math.imul(
                state,
                TABLE_MULTIPLIER
            ) >>> 0;

        table[i] =
            (state >>> 24) & 0xFF;
    }

    return table;
}

function xorDecode79(raw) {

    if (!Buffer.isBuffer(raw)) {
        raw = Buffer.from(raw);
    }

    if (raw.length < 8) {

        throw new Error(
            `بيانات 0x79 قصيرة: ${raw.length}`
        );
    }

    if (raw[0] !== 0x79) {

        throw new Error(
            `بيانات 0x79 غير صحيحة. Magic=${bufferMagic(raw)}`
        );
    }

    const headerValue =
        u32le(
            raw,
            1
        );

    const total =
        raw.length >>> 0;

    const derived =
        xor32(
            TOTAL_XOR,
            total
        );

    let processLenU32 =
        sub32(
            headerValue,
            derived
        );

    processLenU32 =
        xor32(
            processLenU32,
            PROCESS_XOR
        );

    const maxProcessLen =
        Math.max(
            0,
            total - 8
        );

    const processLen =
        Math.min(
            maxProcessLen,
            processLenU32 >>> 0
        );

    const rawSeed =
        u32le(
            raw,
            4
        );

    const seed =
        add32(
            rawSeed,
            4
        );

    const table =
        build79Table(
            seed
        );

    const out =
        Buffer.from(
            raw.subarray(
                8,
                8 + processLen
            )
        );

    if (
        out.length === 0
    ) {
        return out;
    }

    out[0] =
        (
            out[0] ^
            table[0]
        ) & 0xFF;

    for (
        let i = 1;
        i < out.length;
        i++
    ) {

        const current =
            out[i];

        const previousDecoded =
            out[i - 1];

        const delta =
            (
                current -
                previousDecoded
            ) & 0xFF;

        out[i] =
            (
                delta ^
                table[
                    i % TABLE_SIZE
                ]
            ) & 0xFF;
    }

    return out;
}

/* ============================================================
   0x54
   OLD ALGORITHM
   ============================================================ */

function decode54Layer(raw) {

    if (!Buffer.isBuffer(raw)) {
        raw = Buffer.from(raw);
    }

    if (raw.length < 4) {

        throw new Error(
            `بيانات 0x54 قصيرة: ${raw.length}`
        );
    }

    if (raw[0] !== 0x54) {

        throw new Error(
            `بيانات 0x54 غير صحيحة. Magic=${bufferMagic(raw)}`
        );
    }

    let processLen =
        (
            (
                (raw[1] & 0xFF) ^
                FETCH54_TABLE[0]
            ) |
            (
                (raw[2] & 0xFF) << 8
            )
        ) >>> 0;

    processLen =
        Math.min(
            processLen,
            raw.length - 3
        );

    const out =
        Buffer.from(
            raw.subarray(3)
        );

    if (
        out.length === 0
    ) {
        return out;
    }

    out[0] =
        (
            out[0] -
            0x54
        ) & 0xFF;

    const count =
        Math.min(
            processLen,
            out.length
        );

    for (
        let i = 0;
        i < count;
        i++
    ) {

        if (i > 0) {

            out[i] =
                (
                    out[i] -
                    out[i - 1]
                ) & 0xFF;
        }

        out[i] =
            (
                out[i] ^
                FETCH54_TABLE[
                    i %
                    FETCH54_TABLE.length
                ]
            ) & 0xFF;
    }

    return out;
}

/* ============================================================
   TRANSPORT
   ============================================================ */

function decodeTransport(raw) {

    if (!Buffer.isBuffer(raw)) {
        raw = Buffer.from(raw);
    }

    if (
        raw.length === 0
    ) {
        return raw;
    }

    const type =
        raw[0];

    console.log(
        `[FetchCity] SaveCrypto type=0x${type
            .toString(16)
            .padStart(2, "0")}`
    );

    switch (type) {

        case 0x79:
            return xorDecode79(raw);

        case 0x54:
            return decode54Layer(raw);

        case 0x1F:
            return raw;

        default:
            throw new Error(
                `نوع FetchCity غير مدعوم: 0x${type
                    .toString(16)
                    .padStart(2, "0")}`
            );
    }
}

/* ============================================================
   LZ4 BLOCK
   ============================================================ */

function lz4DecompressBlock(
    src,
    expectedSize
) {

    let srcPos = 0;
    let dstPos = 0;

    const output =
        Buffer.alloc(
            expectedSize
        );

    while (
        srcPos < src.length &&
        dstPos < expectedSize
    ) {

        const token =
            src[srcPos++];

        let literalLength =
            token >>> 4;

        if (
            literalLength === 15
        ) {

            let value;

            do {

                if (
                    srcPos >=
                    src.length
                ) {
                    throw new Error(
                        "LZ4: literal length خارج البيانات"
                    );
                }

                value =
                    src[srcPos++];

                literalLength +=
                    value;

            } while (
                value === 255
            );
        }

        if (
            srcPos +
            literalLength >
            src.length
        ) {
            throw new Error(
                "LZ4: literals خارج البيانات"
            );
        }

        if (
            dstPos +
            literalLength >
            expectedSize
        ) {
            throw new Error(
                "LZ4: output overflow أثناء literals"
            );
        }

        src.copy(
            output,
            dstPos,
            srcPos,
            srcPos +
            literalLength
        );

        srcPos +=
            literalLength;

        dstPos +=
            literalLength;

        if (
            srcPos >=
            src.length
        ) {
            break;
        }

        if (
            srcPos + 2 >
            src.length
        ) {
            throw new Error(
                "LZ4: offset ناقص"
            );
        }

        const offset =
            src[srcPos] |
            (
                src[srcPos + 1] <<
                8
            );

        srcPos += 2;

        if (
            offset === 0
        ) {
            throw new Error(
                "LZ4: offset = 0"
            );
        }

        if (
            offset >
            dstPos
        ) {
            throw new Error(
                `LZ4: offset أكبر من output: ${offset} > ${dstPos}`
            );
        }

        let matchLength =
            token & 0x0F;

        if (
            matchLength === 15
        ) {

            let value;

            do {

                if (
                    srcPos >=
                    src.length
                ) {
                    throw new Error(
                        "LZ4: match length خارج البيانات"
                    );
                }

                value =
                    src[srcPos++];

                matchLength +=
                    value;

            } while (
                value === 255
            );
        }

        matchLength += 4;

        if (
            dstPos +
            matchLength >
            expectedSize
        ) {
            throw new Error(
                "LZ4: output overflow أثناء match"
            );
        }

        for (
            let i = 0;
            i < matchLength;
            i++
        ) {

            output[
                dstPos + i
            ] =
                output[
                    dstPos -
                    offset +
                    i
                ];
        }

        dstPos +=
            matchLength;
    }

    if (
        dstPos !==
        expectedSize
    ) {
        throw new Error(
            `LZ4: الحجم غير مطابق. expected=${expectedSize}, actual=${dstPos}`
        );
    }

    return output;
}

function decodeLz4Container(raw) {

    if (
        !isLz4Magic(raw)
    ) {
        throw new Error(
            `LZ4 magic غير صحيح: ${bufferMagic(raw)}`
        );
    }

    if (
        raw.length < 8
    ) {
        throw new Error(
            "LZ4 container قصير"
        );
    }

    const expectedSize =
        u32le(
            raw,
            4
        );

    const compressed =
        raw.subarray(8);

    console.log(
        `[FetchCity] LZ4 expectedSize=${expectedSize}, compressed=${compressed.length}`
    );

    return lz4DecompressBlock(
        compressed,
        expectedSize
    );
}

/* ============================================================
   XML
   ============================================================ */

function trimXml(buf) {

    if (!Buffer.isBuffer(buf)) {
        buf = Buffer.from(buf);
    }

    const text =
        buf.toString("utf8");

    const rootEnd =
        text.lastIndexOf(
            "</root>"
        );

    if (
        rootEnd !== -1
    ) {

        return Buffer.from(
            text.slice(
                0,
                rootEnd +
                "</root>".length
            ),
            "utf8"
        );
    }

    let end =
        buf.length;

    while (
        end > 0
    ) {

        const c =
            buf[end - 1];

        if (
            c === 0x00 ||
            c === 0x09 ||
            c === 0x0A ||
            c === 0x0D ||
            c === 0x20
        ) {
            end--;
        } else {
            break;
        }
    }

    return buf.subarray(
        0,
        end
    );
}

function editCityXml(xml) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    let text =
        xml.toString("utf8");

    text =
        text.replace(
            /<Var\b[^>]*\/?>/gi,
            function(tag) {

                if (
                    /\bname\s*=\s*["']cityId["']/i
                        .test(tag)
                ) {

                    const valueRegex =
                        /(\bv\s*=\s*["'])[^"']*(["'])/i;

                    if (
                        valueRegex.test(tag)
                    ) {

                        return tag.replace(
                            valueRegex,
                            "$1$2"
                        );
                    }

                    return tag.replace(
                        /\/?>$/,
                        ' v=""/>'
                    );
                }

                if (
                    /\bname\s*=\s*["']Device["']/i
                        .test(tag)
                ) {

                    const valueRegex =
                        /(\bv\s*=\s*["'])[^"']*(["'])/i;

                    if (
                        valueRegex.test(tag)
                    ) {

                        return tag.replace(
                            valueRegex,
                            "$1ASUS_Z01QD$2"
                        );
                    }

                    return tag.replace(
                        /\/?>$/,
                        ' v="ASUS_Z01QD"/>'
                    );
                }

                return tag;
            }
        );

    console.log(
        "[FetchCity] XML modifications applied"
    );

    console.log(
        "[FetchCity] cityId = empty"
    );

    console.log(
        "[FetchCity] Device = ASUS_Z01QD"
    );

    return Buffer.from(
        text,
        "utf8"
    );
}

/* ============================================================
   FRIEND DECODER - OLD EXACT ALGORITHM
   ============================================================ */

const FRIEND_TABLE_SIZE = 0x2D7;

function friendU32(v) {
    return v >>> 0;
}

function friendReadU32(
    data,
    pos
) {

    if (
        pos + 4 >
        data.length
    ) {
        throw new Error(
            "بيانات غير كافية لقراءة UInt32"
        );
    }

    return (
        data[pos] |
        (data[pos + 1] << 8) |
        (data[pos + 2] << 16) |
        (data[pos + 3] << 24)
    ) >>> 0;
}

function friendU32Bytes(v) {

    v =
        friendU32(v);

    return Buffer.from([
        v & 0xff,
        (v >>> 8) & 0xff,
        (v >>> 16) & 0xff,
        (v >>> 24) & 0xff
    ]);
}

function friendMmh2(
    data,
    seed
) {

    const m =
        0x5bd1e995;

    let h =
        friendU32(
            seed ^
            data.length
        );

    let i = 0;
    let length =
        data.length;

    while (
        length >= 4
    ) {

        let k =
            friendReadU32(
                data,
                i
            );

        k =
            Math.imul(
                k,
                m
            ) >>> 0;

        k =
            (
                k ^
                (k >>> 24)
            ) >>> 0;

        k =
            Math.imul(
                k,
                m
            ) >>> 0;

        h =
            Math.imul(
                h,
                m
            ) >>> 0;

        h =
            (
                h ^
                k
            ) >>> 0;

        i += 4;
        length -= 4;
    }

    if (
        length === 3
    ) {

        h =
            (
                h ^
                (data[i + 2] << 16)
            ) >>> 0;
    }

    if (
        length >= 2
    ) {

        h =
            (
                h ^
                (data[i + 1] << 8)
            ) >>> 0;
    }

    if (
        length >= 1
    ) {

        h =
            (
                h ^
                data[i]
            ) >>> 0;

        h =
            Math.imul(
                h,
                m
            ) >>> 0;
    }

    h =
        (
            h ^
            (h >>> 13)
        ) >>> 0;

    h =
        Math.imul(
            h,
            m
        ) >>> 0;

    h =
        (
            h ^
            (h >>> 15)
        ) >>> 0;

    return h >>> 0;
}

function friendGetHashTable(
    length,
    seed
) {

    const table =
        Buffer.alloc(
            FRIEND_TABLE_SIZE
        );

    let h =
        friendU32(seed);

    let i = 0;

    while (
        i <
        FRIEND_TABLE_SIZE
    ) {

        const v =
            friendU32Bytes(
                h
            );

        h =
            friendMmh2(
                v,
                length
            );

        const hb =
            friendU32Bytes(
                h
            );

        for (
            let j = 0;
            j < 4 &&
            i + j <
            FRIEND_TABLE_SIZE;
            j++
        ) {

            table[
                i + j
            ] =
                hb[j];
        }

        i += 4;
    }

    return table;
}

function friendXorDecode(
    data
) {

    if (
        data.length < 8
    ) {
        throw new Error(
            "الملف صغير جداً"
        );
    }

    const hl =
        data[1] |
        (data[2] << 8) |
        (data[3] << 16);

    const hs =
        data[4] |
        (data[5] << 8) |
        (data[6] << 16) |
        (data[7] << 24);

    const srcSize =
        data.length;

    const table =
        friendGetHashTable(
            hl,
            friendU32(
                4 + hs
            )
        );

    const sf =
        friendU32(
            (
                hl -
                friendU32(
                    0xC5EED ^
                    srcSize
                )
            ) ^
            0x396A8
        );

    const actual =
        Math.min(
            sf,
            srcSize - 8
        );

    const out =
        Buffer.alloc(
            actual
        );

    for (
        let i = 0;
        i < actual;
        i++
    ) {

        out[i] =
            data[8 + i];
    }

    let j = 0;

    for (
        let i = 0;
        i < out.length;
        i++
    ) {

        if (
            i > 0
        ) {

            out[i] =
                (
                    out[i] -
                    out[i - 1]
                ) & 0xff;
        }

        out[i] =
            (
                out[i] ^
                table[j]
            ) & 0xff;

        j++;

        if (
            j >=
            FRIEND_TABLE_SIZE
        ) {
            j = 0;
        }
    }

    return out;
}

function friendIsLz4(
    data
) {

    return (
        data.length >= 4 &&
        data[0] === 0x04 &&
        data[1] === 0x22 &&
        data[2] === 0x4D &&
        data[3] === 0x18
    );
}

function friendLz4Decompress(
    data
) {

    if (
        data.length < 9
    ) {
        throw new Error(
            "LZ4: البيانات صغيرة جداً"
        );
    }

    const size =
        friendReadU32(
            data,
            4
        );

    let src = 8;

    const output =
        Buffer.alloc(
            size
        );

    let outLen = 0;

    function readByte() {

        if (
            src >=
            data.length
        ) {
            throw new Error(
                "LZ4: نهاية بيانات غير متوقعة"
            );
        }

        return data[
            src++
        ];
    }

    while (
        src <
        data.length &&
        outLen <
        size
    ) {

        const token =
            readByte();

        let literalLen =
            token >>> 4;

        if (
            literalLen === 15
        ) {

            let b;

            do {

                b =
                    readByte();

                literalLen +=
                    b;

            } while (
                b === 255
            );
        }

        if (
            src +
            literalLen >
            data.length
        ) {
            throw new Error(
                "LZ4: Literal خارج النطاق"
            );
        }

        if (
            outLen +
            literalLen >
            size
        ) {
            throw new Error(
                "LZ4: حجم Literal غير صحيح"
            );
        }

        for (
            let i = 0;
            i < literalLen;
            i++
        ) {

            output[
                outLen++
            ] =
                data[
                    src++
                ];
        }

        if (
            outLen >=
            size
        ) {
            break;
        }

        if (
            src + 2 >
            data.length
        ) {
            throw new Error(
                "LZ4: لا يوجد Offset"
            );
        }

        const offset =
            readByte() |
            (
                readByte() << 8
            );

        if (
            offset === 0
        ) {
            throw new Error(
                "LZ4: Offset غير صالح"
            );
        }

        let matchLen =
            token & 0x0F;

        if (
            matchLen === 15
        ) {

            let b;

            do {

                b =
                    readByte();

                matchLen +=
                    b;

            } while (
                b === 255
            );
        }

        matchLen += 4;

        const start =
            outLen -
            offset;

        if (
            start < 0
        ) {
            throw new Error(
                "LZ4: Offset خارج النطاق"
            );
        }

        for (
            let i = 0;
            i < matchLen;
            i++
        ) {

            if (
                outLen >=
                size
            ) {
                throw new Error(
                    "LZ4: الحجم تجاوز المتوقع"
                );
            }

            output[
                outLen++
            ] =
                output[
                    start +
                    (i % offset)
                ];
        }
    }

    if (
        outLen !==
        size
    ) {
        throw new Error(
            "LZ4: الحجم الناتج غير صحيح\n" +
            "Expected: " +
            size +
            "\nActual: " +
            outLen
        );
    }

    return output;
}

/* ============================================================
   DECODE FRIEND FILE
   ============================================================ */

function decodeFriendFile(
    data
) {

    if (
        !Buffer.isBuffer(data)
    ) {
        data =
            Buffer.from(data);
    }

    if (
        data.length === 0
    ) {
        throw new Error(
            "الملف فارغ"
        );
    }

    if (
        data[0] === 0x3C
    ) {
        return data;
    }

    if (
        data[0] !== 0x79
    ) {
        throw new Error(
            "نوع غير مدعوم\nMagic: 0x" +
            data[0]
                .toString(16)
                .padStart(2, "0")
        );
    }

    let payload =
        friendXorDecode(
            data
        );

    if (
        friendIsLz4(
            payload
        )
    ) {

        payload =
            friendLz4Decompress(
                payload
            );
    }

    return trimXml(
        payload
    );
}

/* ============================================================
   XML ATTRIBUTE HELPERS
   ============================================================ */

function xmlDecodeEntities(
    value
) {

    return String(
        value || ""
    )
        .replace(
            /&quot;/g,
            '"'
        )
        .replace(
            /&apos;/g,
            "'"
        )
        .replace(
            /&lt;/g,
            "<"
        )
        .replace(
            /&gt;/g,
            ">"
        )
        .replace(
            /&amp;/g,
            "&"
        );
}

function attrFromXmlTag(
    tag,
    name
) {

    const d =
        tag.match(
            new RegExp(
                name +
                '\\s*=\\s*"([^"]*)"',
                "i"
            )
        );

    if (d) {
        return xmlDecodeEntities(
            d[1]
        );
    }

    const s =
        tag.match(
            new RegExp(
                name +
                "\\s*=\\s*'([^']*)'",
                "i"
            )
        );

    if (s) {
        return xmlDecodeEntities(
            s[1]
        );
    }

    return "";
}

/* ============================================================
   FRIEND VERSION
   ============================================================ */

function parseFriendVersion(
    xml
) {

    const versionTag =
        xml.match(
            /<Version\b[^>]*>/i
        );

    if (
        !versionTag
    ) {
        return {
            bver: "",
            fver: ""
        };
    }

    return {
        bver:
            attrFromXmlTag(
                versionTag[0],
                "version"
            ),

        fver:
            attrFromXmlTag(
                versionTag[0],
                "FVer"
            )
    };
}

/* ============================================================
   FRIENDS
   ============================================================ */

function parseFriends(
    xml
) {

    const friends = [];

    const regex =
        /<friend\b[^>]*\/>/gi;

    let match;

    while (
        (match =
            regex.exec(xml)) !== null
    ) {

        const tag =
            match[0];

        const cityId =
            attrFromXmlTag(
                tag,
                "city_id"
            );

        if (
            !cityId
        ) {
            continue;
        }

        friends.push({
            city_id:
                cityId,

            city_name:
                attrFromXmlTag(
                    tag,
                    "city_name"
                ),

            name:
                attrFromXmlTag(
                    tag,
                    "name"
                ),

            level:
                attrFromXmlTag(
                    tag,
                    "level"
                ),

            xp:
                attrFromXmlTag(
                    tag,
                    "xp"
                ),

            likes:
                attrFromXmlTag(
                    tag,
                    "likes"
                ),

            lang:
                attrFromXmlTag(
                    tag,
                    "lang"
                ),

            flw:
                attrFromXmlTag(
                    tag,
                    "flw"
                ),

            help:
                attrFromXmlTag(
                    tag,
                    "help"
                ),

            fetched_city_ver:
                attrFromXmlTag(
                    tag,
                    "fetched_city_ver"
                ),

            bc:
                attrFromXmlTag(
                    tag,
                    "bc"
                )
        });
    }

    return dedupeBy(
        friends,
        x => x.city_id
    );
}

/* ============================================================
   ProfilesCache -> saveId
   ============================================================ */

function extractSaveIdsFromProfilesCache(
    xml
) {

    const result = [];

    const regex =
        /<OtherPlayerProfilesLogicFeatureComponent\b[^>]*\bProfilesCache\s*=\s*(['"])([\s\S]*?)\1[^>]*\/?>/i;

    const match =
        regex.exec(xml);

    if (
        !match
    ) {
        return result;
    }

    const rawJson =
        xmlDecodeEntities(
            match[2]
        );

    let profiles;

    try {

        profiles =
            JSON.parse(
                rawJson
            );

    } catch (err) {

        throw new Error(
            "ProfilesCache JSON parse failed: " +
            err.message
        );
    }

    if (
        !Array.isArray(
            profiles
        )
    ) {
        return result;
    }

    for (
        const profile of profiles
    ) {

        if (
            !profile ||
            typeof profile !==
            "object"
        ) {
            continue;
        }

        const saveId =
            String(
                profile.saveId ??
                profile.save_id ??
                ""
            ).trim();

        if (
            !saveId
        ) {
            continue;
        }

        const name =
            String(
                profile.cityname ??
                profile.cityName ??
                profile.name ??
                ""
            ).trim();

        const level =
            String(
                profile.level ??
                ""
            ).trim();

        result.push({
            save_id:
                saveId,

            name:
                name,

            level:
                level
        });
    }

    return dedupeBy(
        result,
        x => x.save_id
    );
}

/* ============================================================
   GENERIC SAVE RECORDS
   ============================================================ */

function extractSaveRecords(
    value
) {

    const records = [];

    function walk(node) {

        if (!node) {
            return;
        }

        if (
            Array.isArray(node)
        ) {

            for (
                const item of node
            ) {
                walk(item);
            }

            return;
        }

        if (
            typeof node !==
            "object"
        ) {
            return;
        }

        const saveId =
            node.saveId ??
            node.save_id ??
            node.saveID;

        if (
            saveId
        ) {

            records.push({
                save_id:
                    String(
                        saveId
                    ).trim(),

                name:
                    String(
                        node.cityname ??
                        node.cityName ??
                        node.name ??
                        ""
                    ).trim(),

                level:
                    String(
                        node.level ??
                        ""
                    ).trim()
            });
        }

        for (
            const key of Object.keys(node)
        ) {
            walk(node[key]);
        }
    }

    walk(value);

    return dedupeBy(
        records,
        x => x.save_id
    );
}

function dedupeBy(
    arr,
    keyFn
) {

    const seen =
        new Set();

    const out = [];

    for (
        const item of arr
    ) {

        const key =
            keyFn(item);

        if (
            !key ||
            seen.has(key)
        ) {
            continue;
        }

        seen.add(key);
        out.push(item);
    }

    return out;
}

/* ============================================================
   DECODE CITY
   ============================================================ */

function decodeSaveCity(
    cityBytes
) {

    let data =
        Buffer.from(
            cityBytes
        );

    console.log(
        `[FetchCity] cityBytes=${data.length} magic=${bufferMagic(data)}`
    );

    let rounds = 0;

    while (
        data.length > 0 &&
        rounds < 8
    ) {

        rounds++;

        if (
            looksLikeXml(data)
        ) {

            console.log(
                `[FetchCity] XML detected after ${rounds - 1} layer(s)`
            );

            return trimXml(
                data
            );
        }

        if (
            isLz4Magic(data)
        ) {

            console.log(
                "[FetchCity] LZ4 container detected"
            );

            data =
                decodeLz4Container(
                    data
                );

            continue;
        }

        if (
            isGzip(data)
        ) {

            console.log(
                "[FetchCity] GZIP detected"
            );

            data =
                zlib.gunzipSync(
                    data
                );

            continue;
        }

        const type =
            data[0];

        if (
            type === 0x79 ||
            type === 0x54 ||
            type === 0x1F
        ) {

            const before =
                data;

            data =
                decodeTransport(
                    data
                );

            console.log(
                `[FetchCity] layer ${rounds}: ${bufferMagic(before)} -> ${bufferMagic(data)}`
            );

            continue;
        }

        throw new Error(
            "تعذر فك طبقات FetchCity. " +
            `Magic=${bufferMagic(data)}`
        );
    }

    if (
        looksLikeXml(data)
    ) {
        return trimXml(data);
    }

    throw new Error(
        "تعذر الوصول إلى XML. " +
        `Magic=${bufferMagic(data)}`
    );
}

/* ============================================================
   AES REQUEST
   ============================================================ */

function encryptRequest(
    requestJson
) {

    const iv =
        crypto.randomBytes(
            12
        );

    const cipher =
        crypto.createCipheriv(
            "aes-128-gcm",
            AES_KEY,
            iv
        );

    const plaintext =
        Buffer.from(
            requestJson,
            "utf8"
        );

    const ciphertext =
        Buffer.concat([
            cipher.update(
                plaintext
            ),
            cipher.final()
        ]);

    const tag =
        cipher.getAuthTag();

    const tsId =
        "002" +
        iv.toString("hex") +
        tag.toString("hex");

    return {
        body:
            ciphertext,

        tsId:
            tsId
    };
}

/* ============================================================
   AES RESPONSE
   ============================================================ */

function decryptResponse(
    body,
    tsId
) {

    if (
        !tsId
    ) {
        throw new Error(
            "استجابة FetchCity لا تحتوي ts-id"
        );
    }

    if (
        typeof tsId !== "string" ||
        !tsId.startsWith("002")
    ) {
        throw new Error(
            `ts-id غير صالح: ${tsId}`
        );
    }

    const hex =
        tsId.slice(3);

    if (
        hex.length <
        24 + 32
    ) {
        throw new Error(
            `ts-id قصير: ${tsId}`
        );
    }

    const ivHex =
        hex.slice(
            0,
            24
        );

    const tagHex =
        hex.slice(
            24,
            24 + 32
        );

    const iv =
        Buffer.from(
            ivHex,
            "hex"
        );

    const tag =
        Buffer.from(
            tagHex,
            "hex"
        );

    const decipher =
        crypto.createDecipheriv(
            "aes-128-gcm",
            AES_KEY,
            iv
        );

    decipher.setAuthTag(
        tag
    );

    return Buffer.concat([
        decipher.update(
            body
        ),
        decipher.final()
    ]);
}

/* ============================================================
   RESPONSE DECOMPRESSION
   ============================================================ */

function decompressResponse(
    decrypted
) {

    console.log(
        `[FetchCity] decrypted size=${decrypted.length}`
    );

    console.log(
        `[FetchCity] decrypted magic=${bufferMagic(decrypted)}`
    );

    try {

        const result =
            zlib.gunzipSync(
                decrypted
            );

        console.log(
            "[FetchCity] compression = GZIP"
        );

        return result;

    } catch (e) {

        console.log(
            "[FetchCity] GZIP failed:",
            e.message
        );
    }

    try {

        const result =
            zlib.inflateSync(
                decrypted
            );

        console.log(
            "[FetchCity] compression = ZLIB"
        );

        return result;

    } catch (e) {

        console.log(
            "[FetchCity] ZLIB failed:",
            e.message
        );
    }

    try {

        const result =
            zlib.inflateRawSync(
                decrypted
            );

        console.log(
            "[FetchCity] compression = RAW DEFLATE"
        );

        return result;

    } catch (e) {

        console.log(
            "[FetchCity] RAW DEFLATE failed:",
            e.message
        );
    }

    const text =
        decrypted
            .toString("utf8")
            .trim();

    if (
        text.startsWith("{") ||
        text.startsWith("[")
    ) {

        console.log(
            "[FetchCity] response = plain JSON"
        );

        return decrypted;
    }

    throw new Error(
        "تعذر فك ضغط استجابة FetchCity. " +
        `magic=${bufferMagic(decrypted)} ` +
        `size=${decrypted.length}`
    );
}

/* ============================================================
   REQUEST PLAYRIX
   ============================================================ */

async function requestFetchCity(
    cityId,
    cityVer
) {

    const requestJson =
        `{"cityId":"","cityVer":${cityVer},"fetchCityId":"${cityId}","important":true}`;

    console.log(
        `[FetchCity] request cityId=${cityId} cityVer=${cityVer}`
    );

    const encrypted =
        encryptRequest(
            requestJson
        );

    const controller =
        new AbortController();

    const timer =
        setTimeout(
            () =>
                controller.abort(),
            TIMEOUT_MS
        );

    try {

        const response =
            await fetchImpl(
                ENDPOINT +
                encodeURIComponent(
                    cityId
                ),
                {
                    method:
                        "POST",

                    headers: {
                        "Accept-Encoding":
                            "identity",

                        "Content-Type":
                            "application/octet-stream",

                        "User-Agent":
                            "okhttp/4.9.0",

                        "ts-bp":
                            "i",

                        "ts-bver":
                            "bver",

                        "ts-fver":
                            "fver",

                        "ts-gpid":
                            "new",

                        "ts-id":
                            encrypted.tsId
                    },

                    body:
                        encrypted.body,

                    signal:
                        controller.signal
                }
            );

        const responseBody =
            Buffer.from(
                await response.arrayBuffer()
            );

        console.log(
            `[FetchCity] upstream status=${response.status}`
        );

        if (
            !response.ok
        ) {

            const text =
                responseBody.toString(
                    "utf8"
                );

            throw new Error(
                `Upstream HTTP ${response.status}: ${text}`
            );
        }

        const responseTsId =
            response.headers.get(
                "ts-id"
            );

        if (
            !responseTsId
        ) {
            throw new Error(
                "Upstream response missing ts-id"
            );
        }

        const decrypted =
            decryptResponse(
                responseBody,
                responseTsId
            );

        const uncompressed =
            decompressResponse(
                decrypted
            );

        const text =
            uncompressed.toString(
                "utf8"
            );

        console.log(
            `[FetchCity] JSON size=${text.length}`
        );

        let json;

        try {

            json =
                JSON.parse(
                    text
                );

        } catch (e) {

            throw new Error(
                "Upstream response JSON parse failed: " +
                e.message
            );
        }

        return json;

    } finally {

        clearTimeout(
            timer
        );
    }
}

/* ============================================================
   ROOT / HEALTH
   ============================================================ */

app.get(
    "/",
    (req, res) => {

        res.json({
            ok: true,
            service:
                "fetchCity",
            status:
                "online"
        });
    }
);

app.get(
    "/health",
    (req, res) => {

        res.json({
            ok: true
        });
    }
);

/* ============================================================
   /decode-friends
   RAW APPLICATION/OCTET-STREAM
   ============================================================ */

async function handleDecodeFriends(
    req,
    res
) {

    try {

        let encryptedFile =
            req.body;

        if (
            !Buffer.isBuffer(
                encryptedFile
            )
        ) {

            return res
                .status(400)
                .json({
                    ok: false,
                    error:
                        "يجب إرسال الملف بصيغة application/octet-stream"
                });
        }

        if (
            encryptedFile.length === 0
        ) {

            return res
                .status(400)
                .json({
                    ok: false,
                    error:
                        "الملف فارغ"
                });
        }

        console.log(
            `[Friends] encrypted file size=${encryptedFile.length}`
        );

        console.log(
            `[Friends] encrypted magic=${bufferMagic(encryptedFile)}`
        );

        const xmlBuffer =
            decodeFriendFile(
                encryptedFile
            );

        const xml =
            xmlBuffer
                .toString("utf8")
                .replace(
                    /^\uFEFF/,
                    ""
                )
                .trim();

        console.log(
            `[Friends] decoded XML size=${xml.length}`
        );

        if (
            !xml.startsWith("<")
        ) {

            throw new Error(
                "بعد فك الملف لم يتم الحصول على XML"
            );
        }

        const version =
            parseFriendVersion(
                xml
            );

        const friends =
            parseFriends(
                xml
            );

        const saveIds =
            extractSaveIdsFromProfilesCache(
                xml
            );

        console.log(
            `[Friends] bver=${version.bver}`
        );

        console.log(
            `[Friends] fver=${version.fver}`
        );

        console.log(
            `[Friends] friends=${friends.length}`
        );

        console.log(
            `[Friends] saveIds=${saveIds.length}`
        );

        return res
            .status(200)
            .json({

                ok: true,

                bver:
                    version.bver,

                fver:
                    version.fver,

                friends:
                    friends,

                saveIds:
                    saveIds
            });

    } catch (err) {

        console.error(
            "[Friends] DECODE ERROR:",
            err &&
            err.stack
                ? err.stack
                : err
        );

        return res
            .status(500)
            .json({

                ok: false,

                error:
                    err &&
                    err.message
                        ? err.message
                        : String(err)
            });
    }
}

app.post(
    "/decode-friends",
    express.raw({
        type:
            "application/octet-stream",

        limit:
            "50mb"
    }),
    handleDecodeFriends
);

/* ============================================================
   /decode-friends-json
   ============================================================ */

app.post(
    "/decode-friends-json",
    async (req, res) => {

        try {

            let inputBuffer =
                null;

            if (
                req.body &&
                req.body.base64
            ) {

                inputBuffer =
                    Buffer.from(
                        String(
                            req.body.base64
                        )
                            .replace(
                                /^data:[^,]+,/,
                                ""
                            ),
                        "base64"
                    );
            }

            if (
                !inputBuffer &&
                req.body &&
                req.body.data
            ) {

                inputBuffer =
                    Buffer.from(
                        String(
                            req.body.data
                        )
                            .replace(
                                /^data:[^,]+,/,
                                ""
                            ),
                        "base64"
                    );
            }

            if (
                !inputBuffer
            ) {

                return res
                    .status(400)
                    .json({

                        ok: false,

                        error:
                            "Missing base64/data"
                    });
            }

            const decoded =
                decodeFriendFile(
                    inputBuffer
                );

            const text =
                decoded
                    .toString("utf8")
                    .trim();

            let friends = [];
            let saveIds = [];

            if (
                looksLikeXml(
                    decoded
                )
            ) {

                friends =
                    parseFriends(
                        text
                    );

                saveIds =
                    extractSaveIdsFromProfilesCache(
                        text
                    );

            } else if (
                looksLikeJson(
                    decoded
                )
            ) {

                const json =
                    JSON.parse(
                        text
                    );

                saveIds =
                    extractSaveRecords(
                        json
                    );
            }

            return res
                .status(200)
                .json({

                    ok: true,

                    friends:
                        friends,

                    saveIds:
                        saveIds,

                    xml:
                        looksLikeXml(
                            decoded
                        )
                            ? text
                            : null
                });

        } catch (err) {

            console.error(
                "[decode-friends-json] ERROR:",
                err
            );

            return res
                .status(500)
                .json({

                    ok: false,

                    error:
                        err.message ||
                        String(err)
                });
        }
    }
);

/* ============================================================
   /save-info
   ============================================================ */

app.post(
    "/save-info",
    async (req, res) => {

        try {

            const body =
                req.body ||
                {};

            const saveId =
                String(
                    body.saveId ??
                    body.save_id ??
                    ""
                ).trim();

            const cityname =
                String(
                    body.cityname ??
                    body.cityName ??
                    body.name ??
                    ""
                ).trim();

            const level =
                String(
                    body.level ??
                    ""
                ).trim();

            if (
                !saveId
            ) {

                return res
                    .status(400)
                    .json({

                        ok: false,

                        error:
                            "saveId is required"
                    });
            }

            console.log(
                "[save-info]",
                {
                    saveId,
                    cityname,
                    level
                }
            );

            return res
                .status(200)
                .json({

                    ok: true,

                    saveId,

                    cityname,

                    level
                });

        } catch (err) {

            console.error(
                "[save-info] ERROR:",
                err
            );

            return res
                .status(500)
                .json({

                    ok: false,

                    error:
                        err.message ||
                        String(err)
                });
        }
    }
);

/* ============================================================
   /fetch-city
   LUA SENDS ONLY:
   {
      city_id,
      city_name,
      level
   }
   ============================================================ */

app.post(
    "/fetch-city",
    async (req, res) => {

        try {

            const body =
                req.body ||
                {};

            /*
             * مهم:
             * لا نستقبل cityId
             * لا نستقبل fetchCityId
             * لا نستقبل cityVer
             *
             * Lua يرسل فقط:
             * city_id
             * city_name
             * level
             */

            const cityId =
                String(
                    body.city_id ??
                    ""
                ).trim();

            const cityName =
                String(
                    body.city_name ??
                    ""
                ).trim();

            const level =
                String(
                    body.level ??
                    ""
                ).trim();

            if (
                !cityId
            ) {

                return res
                    .status(400)
                    .json({

                        ok: false,

                        error:
                            "city_id is required"
                    });
            }

            /*
             * داخلي فقط.
             * Lua لا يرسله.
             */

            const cityVer =
                0;

            console.log(
                "[fetch-city] incoming:",
                {
                    city_id:
                        cityId,

                    city_name:
                        cityName,

                    level:
                        level,

                    cityVer:
                        cityVer
                }
            );

            /*
             * هنا:
             *
             * saveId
             *     ↓
             * city_id
             *     ↓
             * FetchCity cityId
             */

            const json =
                await requestFetchCity(
                    cityId,
                    cityVer
                );

            if (
                !json ||
                !json.result ||
                typeof json.result.data !==
                "string"
            ) {

                throw new Error(
                    "Upstream JSON لا يحتوي result.data"
                );
            }

            const base64 =
                json.result.data;

            console.log(
                `[FetchCity] Base64 length=${base64.length}`
            );

            const cityBytes =
                Buffer.from(
                    base64,
                    "base64"
                );

            console.log(
                `[FetchCity] decoded Base64 bytes=${cityBytes.length} magic=${bufferMagic(cityBytes)}`
            );

            const xml =
                decodeSaveCity(
                    cityBytes
                );

            console.log(
                `[FetchCity] XML size=${xml.length}`
            );

            const modifiedXml =
                editCityXml(
                    xml
                );

            console.log(
                `[FetchCity] Modified XML size=${modifiedXml.length}`
            );

            res.setHeader(
                "Content-Type",
                "application/xml; charset=utf-8"
            );

            res.setHeader(
                "Cache-Control",
                "no-store"
            );

            return res
                .status(200)
                .send(
                    modifiedXml
                );

        } catch (err) {

            console.error(
                "[FetchCity] ERROR:",
                err &&
                err.stack
                    ? err.stack
                    : err
            );

            return res
                .status(500)
                .json({

                    ok: false,

                    error:
                        err &&
                        err.message
                            ? err.message
                            : String(err)
                });
        }
    }
);

/* ============================================================
   ERROR HANDLER
   ============================================================ */

app.use(
    (
        err,
        req,
        res,
        next
    ) => {

        console.error(
            "[server] unhandled error:",
            err
        );

        if (
            res.headersSent
        ) {
            return next(err);
        }

        return res
            .status(500)
            .json({

                ok: false,

                error:
                    err.message ||
                    String(err)
            });
    }
);

/* ============================================================
   START
   ============================================================ */

app.listen(
    PORT,
    "0.0.0.0",
    () => {

        console.log(
            `Server running on port ${PORT}`
        );

        console.log(
            "Routes:"
        );

        console.log(
            "  GET  /"
        );

        console.log(
            "  GET  /health"
        );

        console.log(
            "  POST /decode-friends"
        );

        console.log(
            "  POST /decode-friends-json"
        );

        console.log(
            "  POST /save-info"
        );

        console.log(
            "  POST /fetch-city"
        );
    }
);
