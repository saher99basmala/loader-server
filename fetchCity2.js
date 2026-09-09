/* ========================================
   fetchCity.js
======================================== */

const express = require("express");
const crypto = require("crypto");
const zlib = require("zlib");
const fetch = require("node-fetch");

const router = express.Router();

// ============================================================
// CONFIG
// ============================================================

const AES_KEY = Buffer.from(
    process.env.FETCHCITY_AES_KEY || "Wucai6oj0sheiX3p",
    "utf8"
);

const ENDPOINT =
    process.env.FETCHCITY_ENDPOINT ||
    "https://township.playrix.com/api/1/FetchCity?cityId=";

const TIMEOUT_MS =
    Number(process.env.FETCHCITY_TIMEOUT_MS || 25000);

// ============================================================
// SAVECRYPTO CONSTANTS - FETCHCITY
// ============================================================

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

// ============================================================
// FETCH54 TABLE
// ============================================================

const FETCH54_TABLE = Buffer.from(
    "d192KFBTVDZLSDBPSkIwNHh4PlJDMyFrUngqfCsyNV5PU2guWCcmTj5gbTlLZklXb3xTMmpoYmMgZlRkN2FTWjZSQmdRYkwpZlcxMWI8J0dXJ00pTiNsbF5xWntdOmJhakBudjlZUXlgKDgnJkUyeSo8biZSak9lb2lPRTNbP0lMTys/ZFNAdXxddlZJSGdpdnR3I19ybG9nTD9yY2xKa0EyVjZkSF9hdiB1OWZ3JFZnaiVBdEJHK2RSRSg6bih0SSdiNDc/c3phSU5rbTh7PDdqTCN0O1NKO0knX3ZyVkNveiFvcGg0cC9kdW1UKDZ4ezNRfiZtbWEpJS9+QlJjbm9qeVRmVC55cW4mc2s5ajtheTNwZyssY2NKRz1URXUySy0qZCVJVSpZMk4pLn17VVBfTip4P1pdX2wsXXZ+J21ydkIpdUcuc3cyUCVRK3xOUUxgPklmeUx3ZF0sST9mK2lnOm84cyNMUk15KCQwWTJWelhCRVZ+UXVCZ1J+eVplb2gtY0NAcUA+Ni1WdlQyLFpTV2xVfnRoKyUwfFdfaVBsfU0wdW4/cHlkcXVsYHxaTGB1N3JtMUwwZXd6NGM5KmZuUlpGOjgoOyYlNltHbj4sTFhXOUY/UVE0MSg6NXN2ckdWI3snMyldMi82bG5bc1lkczpxVGRCaDhPeUI8I1EhVSVRJ1tkK3IlKU9CT3V5XSE9fWFnMEdQNlp+YCs5PnJGJmBfOF59Tn5YMDJEKUgjfWFPKTA4dHF4OixPJmZOcHtSJFc+KU1CZUxpfFJYOi56JzVCJWddMTNFZiB5JUs/e1JBcGdrey4xKSxBT1toVXlJLm98cUBwXiBNczFJNyBadWI6YSdPNFknXzA7WG1afnZLPW5KI3dZQ2Njbl5Dekp1NDxmNW9neV19I0s1RklsS25ud1RfXmRWQVpndl1EIFdJdEBzbCFpPSlxeG5XaA==",
    "base64"
);

// ============================================================
// UTILS
// ============================================================

function u32le(buf, offset) {
    if (offset + 4 > buf.length) {
        throw new Error("u32le خارج حدود البيانات");
    }

    return (
        (
            buf[offset] |
            (buf[offset + 1] << 8) |
            (buf[offset + 2] << 16) |
            (buf[offset + 3] * 0x1000000)
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
    if (!buf || buf.length < 4) {
        return "";
    }

    return Array.from(buf.subarray(0, 4))
        .map(x =>
            x.toString(16).padStart(2, "0")
        )
        .join(" ");
}

function isLz4Magic(buf) {
    return (
        buf &&
        buf.length >= 4 &&
        buf[0] === 0x04 &&
        buf[1] === 0x22 &&
        buf[2] === 0x4D &&
        buf[3] === 0x18
    );
}

function isGzip(buf) {
    return (
        buf &&
        buf.length >= 2 &&
        buf[0] === 0x1F &&
        buf[1] === 0x8B
    );
}

function looksLikeXml(buf) {
    if (!buf || buf.length === 0) {
        return false;
    }

    const text =
        buf
            .subarray(
                0,
                Math.min(buf.length, 512)
            )
            .toString("utf8")
            .trimStart();

    return (
        text.startsWith("<") ||
        text.startsWith("<?xml")
    );
}

// ============================================================
// FETCHCITY 0x79
// ============================================================

function build79Table(seed) {
    const table =
        Buffer.alloc(TABLE_SIZE);

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

    const headerValue =
        u32le(raw, 1);

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
        u32le(raw, 4);

    const seed =
        add32(
            rawSeed,
            4
        );

    const table =
        build79Table(seed);

    const out =
        Buffer.from(
            raw.subarray(
                8,
                8 + processLen
            )
        );

    if (out.length === 0) {
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

// ============================================================
// FETCHCITY 0x54
// ============================================================

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

    if (out.length === 0) {
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

// ============================================================
// FETCHCITY TRANSPORT
// ============================================================

function decodeTransport(raw) {
    if (!Buffer.isBuffer(raw)) {
        raw = Buffer.from(raw);
    }

    if (raw.length === 0) {
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
                `نوع FetchCity غير معروف: 0x${type
                    .toString(16)
                    .padStart(2, "0")}`
            );
    }
}

// ============================================================
// FETCHCITY LZ4
// ============================================================

function lz4DecompressBlock(
    src,
    expectedSize
) {
    let srcPos = 0;
    let dstPos = 0;

    const output =
        Buffer.alloc(expectedSize);

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
                    srcPos >= src.length
                ) {
                    throw new Error(
                        "LZ4: literal length غير مكتمل"
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
                "LZ4: literals غير مكتملة"
            );
        }

        if (
            dstPos +
            literalLength >
            expectedSize
        ) {
            throw new Error(
                "LZ4: output overflow في literals"
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
            srcPos >= src.length
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
                src[srcPos + 1] << 8
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
            offset > dstPos
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
                    srcPos >= src.length
                ) {
                    throw new Error(
                        "LZ4: match length غير مكتمل"
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
                "LZ4: output overflow في match"
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
        dstPos !== expectedSize
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
        u32le(raw, 4);

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

// ============================================================
// FETCHCITY XML
// ============================================================

function trimXml(buf) {
    if (!Buffer.isBuffer(buf)) {
        buf = Buffer.from(buf);
    }

    const text =
        buf.toString("utf8");

    const rootEnd =
        text.lastIndexOf("</root>");

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

// ============================================================
// OLD CITY XML EDIT
// ============================================================

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

    return Buffer.from(
        text,
        "utf8"
    );
}

// ============================================================
// COMPLETE FETCHCITY SAVE DECODER
// ============================================================

function decodeSaveCity(cityBytes) {
    let data =
        Buffer.from(cityBytes);

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

            return trimXml(data);
        }

        if (
            isLz4Magic(data)
        ) {
            console.log(
                "[FetchCity] LZ4 container detected"
            );

            data =
                decodeLz4Container(data);

            continue;
        }

        if (
            isGzip(data)
        ) {
            console.log(
                "[FetchCity] GZIP detected"
            );

            data =
                zlib.gunzipSync(data);

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
                decodeTransport(data);

            console.log(
                `[FetchCity] layer ${rounds}: ${bufferMagic(before)} -> ${bufferMagic(data)}`
            );

            continue;
        }

        throw new Error(
            `تعذر فك FetchCity. Magic=${bufferMagic(data)}`
        );
    }

    if (
        looksLikeXml(data)
    ) {
        return trimXml(data);
    }

    throw new Error(
        `تعذر الوصول إلى XML. Magic=${bufferMagic(data)}`
    );
}

// ============================================================
// AES REQUEST
// ============================================================

function encryptRequest(requestJson) {
    const iv =
        crypto.randomBytes(12);

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
            cipher.update(plaintext),
            cipher.final()
        ]);

    const tag =
        cipher.getAuthTag();

    const tsId =
        "002" +
        iv.toString("hex") +
        tag.toString("hex");

    return {
        body: ciphertext,
        tsId
    };
}

// ============================================================
// AES RESPONSE
// ============================================================

function decryptResponse(
    body,
    tsId
) {
    if (!tsId) {
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
        hex.length < 24 + 32
    ) {
        throw new Error(
            `ts-id قصير: ${tsId}`
        );
    }

    const ivHex =
        hex.slice(0, 24);

    const tagHex =
        hex.slice(24, 24 + 32);

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

    decipher.setAuthTag(tag);

    return Buffer.concat([
        decipher.update(body),
        decipher.final()
    ]);
}

// ============================================================
// RESPONSE DECOMPRESSION
// ============================================================

function decompressResponse(decrypted) {
    console.log(
        `[FetchCity] decrypted size=${decrypted.length}`
    );

    console.log(
        `[FetchCity] decrypted magic=${bufferMagic(decrypted)}`
    );

    try {
        const result =
            zlib.gunzipSync(decrypted);

        console.log(
            "[FetchCity] compression = GZIP"
        );

        return result;

    } catch (_) {}

    try {
        const result =
            zlib.inflateSync(decrypted);

        console.log(
            "[FetchCity] compression = ZLIB"
        );

        return result;

    } catch (_) {}

    try {
        const result =
            zlib.inflateRawSync(decrypted);

        console.log(
            "[FetchCity] compression = RAW DEFLATE"
        );

        return result;

    } catch (_) {}

    const text =
        decrypted
            .toString("utf8")
            .trim();

    if (
        text.startsWith("{") ||
        text.startsWith("[")
    ) {
        return decrypted;
    }

    throw new Error(
        "تعذر فك استجابة FetchCity. " +
        `magic=${bufferMagic(decrypted)} ` +
        `size=${decrypted.length}`
    );
}

// ============================================================
// REQUEST PLAYRIX
// ============================================================

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
        encryptRequest(requestJson);

    const controller =
        new AbortController();

    const timer =
        setTimeout(
            () => controller.abort(),
            TIMEOUT_MS
        );

    try {
        const response =
            await fetch(
                ENDPOINT +
                encodeURIComponent(cityId),
                {
                    method: "POST",

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

        if (!response.ok) {
            throw new Error(
                `Upstream HTTP ${response.status}: ${responseBody.toString("utf8")}`
            );
        }

        const responseTsId =
            response.headers.get("ts-id");

        if (!responseTsId) {
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
            decompressResponse(decrypted);

        return JSON.parse(
            uncompressed.toString("utf8")
        );

    } finally {
        clearTimeout(timer);
    }
}

// ============================================================
// FRIEND FILE DECODER
// ============================================================

const FRIEND_TABLE_SIZE = 0x2D7;

function friendU32(v) {
    return v >>> 0;
}

function friendReadU32(data, pos) {
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

function friendMmh2(data, seed) {
    const m =
        0x5bd1e995;

    let h =
        friendU32(
            seed ^ data.length
        );

    let i = 0;
    let length = data.length;

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

    if (length === 3) {
        h =
            (
                h ^
                (data[i + 2] << 16)
            ) >>> 0;
    }

    if (length >= 2) {
        h =
            (
                h ^
                (data[i + 1] << 8)
            ) >>> 0;
    }

    if (length >= 1) {
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
            friendU32Bytes(h);

        h =
            friendMmh2(
                v,
                length
            );

        const hb =
            friendU32Bytes(h);

        for (
            let j = 0;
            j < 4 &&
            i + j <
            FRIEND_TABLE_SIZE;
            j++
        ) {
            table[i + j] =
                hb[j];
        }

        i += 4;
    }

    return table;
}

function friendXorDecode(data) {
    if (
        data.length < 8
    ) {
        throw new Error(
            "الملف قصير"
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
            friendU32(4 + hs)
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
        Buffer.alloc(actual);

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
        if (i > 0) {
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
            j >= FRIEND_TABLE_SIZE
        ) {
            j = 0;
        }
    }

    return out;
}

function friendIsLz4(data) {
    return (
        data.length >= 4 &&
        data[0] === 0x04 &&
        data[1] === 0x22 &&
        data[2] === 0x4D &&
        data[3] === 0x18
    );
}

function friendLz4Decompress(data) {
    if (
        data.length < 9
    ) {
        throw new Error(
            "LZ4: البيانات قصيرة"
        );
    }

    const size =
        friendReadU32(data, 4);

    let src = 8;

    const output =
        Buffer.alloc(size);

    let outLen = 0;

    function readByte() {
        if (
            src >= data.length
        ) {
            throw new Error(
                "LZ4: البيانات غير مكتملة"
            );
        }

        return data[src++];
    }

    while (
        src < data.length &&
        outLen < size
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

                literalLen += b;

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
                "LZ4: Literal غير مكتمل"
            );
        }

        if (
            outLen +
            literalLen >
            size
        ) {
            throw new Error(
                "LZ4: Literal أكبر من الحجم"
            );
        }

        for (
            let i = 0;
            i < literalLen;
            i++
        ) {
            output[outLen++] =
                data[src++];
        }

        if (
            outLen >= size
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
            (readByte() << 8);

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

                matchLen += b;

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
                outLen >= size
            ) {
                throw new Error(
                    "LZ4: تجاوز حجم الإخراج"
                );
            }

            output[outLen++] =
                output[
                    start +
                    (i % offset)
                ];
        }
    }

    if (
        outLen !== size
    ) {
        throw new Error(
            "LZ4: الحجم غير مطابق\n" +
            "Expected: " +
            size +
            "\nActual: " +
            outLen
        );
    }

    return output;
}

function friendTrimXml(data) {
    const marker =
        Buffer.from("</root>");

    const pos =
        data.lastIndexOf(marker);

    if (
        pos !== -1
    ) {
        return data.subarray(
            0,
            pos + marker.length
        );
    }

    let end =
        data.length;

    while (
        end > 0 &&
        data[end - 1] === 0
    ) {
        end--;
    }

    return data.subarray(
        0,
        end
    );
}

// ============================================================
// DECODE FRIEND FILE
// ============================================================

function decodeFriendFile(data) {
    if (!Buffer.isBuffer(data)) {
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
            "نوع ملف غير معروف\nMagic: 0x" +
            data[0]
                .toString(16)
                .padStart(2, "0")
        );
    }

    let payload =
        friendXorDecode(data);

    if (
        friendIsLz4(payload)
    ) {
        payload =
            friendLz4Decompress(payload);
    }

    return friendTrimXml(payload);
}

// ============================================================
// FRIEND XML ATTRIBUTE
// ============================================================

function attrFromXmlTag(
    tag,
    name
) {
    const doubleQuote =
        tag.match(
            new RegExp(
                name +
                '\\s*=\\s*"([^"]*)"',
                "i"
            )
        );

    if (doubleQuote) {
        return doubleQuote[1];
    }

    const singleQuote =
        tag.match(
            new RegExp(
                name +
                "\\s*=\\s*'([^']*)'",
                "i"
            )
        );

    if (singleQuote) {
        return singleQuote[1];
    }

    return "";
}

// ============================================================
// FRIEND VERSION
// ============================================================

function parseFriendVersion(xml) {
    const versionTag =
        xml.match(
            /<Version\b[^>]*>/i
        );

    if (!versionTag) {
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

// ============================================================
// FRIENDS
// ============================================================

function parseFriends(xml) {
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

        if (!cityId) {
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
                ),

            saveId: ""
        });
    }

    return friends;
}

// ============================================================
// SAVE PROFILES
// ============================================================

function parseSaveProfiles(xml) {
    const profiles = [];

    const regex =
        /<OtherPlayerProfilesLogicFeatureComponent\b[^>]*>/i;

    const match =
        xml.match(regex);

    if (!match) {
        return profiles;
    }

    const profilesCache =
        attrFromXmlTag(
            match[0],
            "ProfilesCache"
        );

    if (!profilesCache) {
        return profiles;
    }

    let parsed;

    try {
        parsed =
            JSON.parse(profilesCache);
    } catch (_) {
        return profiles;
    }

    if (!Array.isArray(parsed)) {
        return profiles;
    }

    for (
        const profile of parsed
    ) {
        if (
            !profile ||
            typeof profile !== "object"
        ) {
            continue;
        }

        const saveId =
            String(
                profile.saveId || ""
            ).trim();

        if (!saveId) {
            continue;
        }

        profiles.push({
            cityname:
                String(
                    profile.cityname || ""
                ).trim(),

            saveId:
                saveId,

            level:
                String(
                    profile.level || ""
                ).trim()
        });
    }

    return profiles;
}

// ============================================================
// NORMALIZE
// ============================================================

function normalizeCityName(value) {
    return String(value || "")
        .trim()
        .replace(/\s+/g, " ")
        .toLowerCase();
}

// ============================================================
// ATTACH saveId
// ============================================================

function attachSaveIdsToFriends(
    friends,
    saveProfiles
) {
    if (
        !Array.isArray(friends) ||
        !Array.isArray(saveProfiles)
    ) {
        return friends;
    }

    const map =
        new Map();

    for (
        const profile of saveProfiles
    ) {
        const key =
            normalizeCityName(
                profile.cityname
            );

        if (
            key &&
            profile.saveId &&
            !map.has(key)
        ) {
            map.set(
                key,
                profile.saveId
            );
        }
    }

    for (
        const friend of friends
    ) {
        const cityName =
            normalizeCityName(
                friend.city_name
            );

        const friendName =
            normalizeCityName(
                friend.name
            );

        let saveId = "";

        if (
            cityName &&
            map.has(cityName)
        ) {
            saveId =
                map.get(cityName);
        }

        if (
            !saveId &&
            friendName &&
            map.has(friendName)
        ) {
            saveId =
                map.get(friendName);
        }

        if (saveId) {
            friend.saveId =
                saveId;
        }
    }

    return friends;
}

// ============================================================
// ============================================================
// MERGE SYSTEM
// ============================================================
// ============================================================

const COPY_VAR_NAMES = [
    "chatEmojis",
    "unlockAllAvatars",
    "unlockAllCards",
    "unlockAllCards",
    "unlockedExpRanks",
    "unlockedStyles",
    "unlockedFrames",
    "regataTasksCompleted",
    "m3CompLvls",
    "livesSent",
    "fullCardCollections",
    "firstAttemptM3Levels",
    "townName",
    "achievementTeamwork"
];

// ============================================================
// ESCAPE REGEX
// ============================================================

function escapeRegex(value) {
    return String(value).replace(
        /[.*+?^${}()|[\]\\]/g,
        "\\$&"
    );
}

// ============================================================
// FIND COMPLETE VAR
// ============================================================

function findVarSection(
    xml,
    name
) {
    const safeName =
        escapeRegex(name);

    const regex =
        new RegExp(
            `<Var\\b[^>]*\\bname\\s*=\\s*["']${safeName}["'][^>]*>`,
            "i"
        );

    const match =
        regex.exec(xml);

    if (!match) {
        return null;
    }

    const start =
        match.index;

    const openingTag =
        match[0];

    const openingEnd =
        start +
        openingTag.length;

    if (
        /\/>\s*$/.test(openingTag)
    ) {
        return {
            start,
            end: openingEnd,
            text:
                xml.slice(
                    start,
                    openingEnd
                )
        };
    }

    let depth = 1;

    const tagRegex =
        /<\/?Var\b[^>]*>/gi;

    tagRegex.lastIndex =
        openingEnd;

    let tagMatch;

    while (
        (tagMatch =
            tagRegex.exec(xml)) !== null
    ) {
        const tag =
            tagMatch[0];

        if (
            /^<Var\b/i.test(tag) &&
            !/\/>\s*$/.test(tag)
        ) {
            depth++;
            continue;
        }

        if (
            /^<\/Var\b/i.test(tag)
        ) {
            depth--;

            if (
                depth === 0
            ) {
                const end =
                    tagMatch.index +
                    tag.length;

                return {
                    start,
                    end,
                    text:
                        xml.slice(
                            start,
                            end
                        )
                };
            }
        }
    }

    throw new Error(
        `Var section غير مكتمل: ${name}`
    );
}

// ============================================================
// COPY NAMED SECTIONS
// ============================================================

function copyNamedSections(
    mainXml,
    friendXml
) {
    let result =
        mainXml;

    const names =
        [
            ...new Set(
                COPY_VAR_NAMES
            )
        ];

    for (
        const name of names
    ) {
        const friendSection =
            findVarSection(
                friendXml,
                name
            );

        if (!friendSection) {
            throw new Error(
                `Friend XML لا يحتوي القسم: ${name}`
            );
        }

        const mainSection =
            findVarSection(
                result,
                name
            );

        if (!mainSection) {
            throw new Error(
                `Main XML لا يحتوي القسم: ${name}`
            );
        }

        result =
            result.slice(
                0,
                mainSection.start
            ) +
            friendSection.text +
            result.slice(
                mainSection.end
            );

        console.log(
            `[Merge] copied Var "${name}"`
        );
    }

    return result;
}

// ============================================================
// FIND BUILDINGS
// ============================================================

function findBuildingsSections(xml) {
    const START =
        "</TownGround><Buildings><Object";

    const sections = [];

    let searchFrom = 0;

    while (true) {
        const start =
            xml.indexOf(
                START,
                searchFrom
            );

        if (start === -1) {
            break;
        }

        const buildingsOpen =
            xml.indexOf(
                "<Buildings",
                start
            );

        if (
            buildingsOpen === -1
        ) {
            throw new Error(
                "Buildings opening tag غير موجود"
            );
        }

        const tagRegex =
            /<\/?Buildings\b[^>]*>/gi;

        tagRegex.lastIndex =
            buildingsOpen;

        let depth = 0;
        let end = -1;

        let match;

        while (
            (match =
                tagRegex.exec(xml)) !== null
        ) {
            const tag =
                match[0];

            if (
                /^<Buildings\b/i.test(tag) &&
                !/\/>\s*$/.test(tag)
            ) {
                depth++;
                continue;
            }

            if (
                /^<\/Buildings\b/i.test(tag)
            ) {
                depth--;

                if (
                    depth === 0
                ) {
                    end =
                        match.index +
                        match[0].length;

                    break;
                }
            }
        }

        if (end === -1) {
            throw new Error(
                "Buildings section غير مكتمل"
            );
        }

        sections.push({
            start,
            end,
            text:
                xml.slice(
                    start,
                    end
                )
        });

        searchFrom =
            end;
    }

    return sections;
}

// ============================================================
// COPY BOTH BUILDINGS
// ============================================================

function copyBothBuildingsSections(
    mainXml,
    friendXml
) {
    const mainSections =
        findBuildingsSections(
            mainXml
        );

    const friendSections =
        findBuildingsSections(
            friendXml
        );

    if (
        mainSections.length !== 2
    ) {
        throw new Error(
            `Main XML يجب أن يحتوي قسمي Buildings بالضبط. الموجود=${mainSections.length}`
        );
    }

    if (
        friendSections.length !== 2
    ) {
        throw new Error(
            `Friend XML يجب أن يحتوي قسمي Buildings بالضبط. الموجود=${friendSections.length}`
        );
    }

    let result =
        mainXml;

    for (
        let i = 1;
        i >= 0;
        i--
    ) {
        const mainSection =
            mainSections[i];

        const friendSection =
            friendSections[i];

        result =
            result.slice(
                0,
                mainSection.start
            ) +
            friendSection.text +
            result.slice(
                mainSection.end
            );

        console.log(
            `[Merge] copied Buildings section ${i + 1}/2`
        );
    }

    return result;
}

// ============================================================
// COPY LEVELUP -> END
// ============================================================

function copyLevelupToEnd(
    mainXml,
    friendXml
) {
    const LEVELUP_REGEX =
        /<Var\b[^>]*\bname\s*=\s*["']levelup["'][^>]*\/>/i;

    const mainMatch =
        LEVELUP_REGEX.exec(
            mainXml
        );

    const friendMatch =
        LEVELUP_REGEX.exec(
            friendXml
        );

    if (!mainMatch) {
        throw new Error(
            'Main XML لا يحتوي Var levelup'
        );
    }

    if (!friendMatch) {
        throw new Error(
            'Friend XML لا يحتوي Var levelup'
        );
    }

    return (
        mainXml.slice(
            0,
            mainMatch.index
        ) +
        friendXml.slice(
            friendMatch.index
        )
    );
}

// ============================================================
// MERGE
// ============================================================

function mergeFriendIntoMain(
    mainXml,
    friendXml
) {
    if (
        Buffer.isBuffer(mainXml)
    ) {
        mainXml =
            mainXml.toString("utf8");
    }

    if (
        Buffer.isBuffer(friendXml)
    ) {
        friendXml =
            friendXml.toString("utf8");
    }

    mainXml =
        String(mainXml)
            .replace(/^\uFEFF/, "")
            .trim();

    friendXml =
        String(friendXml)
            .replace(/^\uFEFF/, "")
            .trim();

    console.log(
        `[Merge] MAIN XML=${mainXml.length}`
    );

    console.log(
        `[Merge] FRIEND XML=${friendXml.length}`
    );

    // 1
    let result =
        copyBothBuildingsSections(
            mainXml,
            friendXml
        );

    // 2
    result =
        copyNamedSections(
            result,
            friendXml
        );

    // 3
    result =
        copyLevelupToEnd(
            result,
            friendXml
        );

    console.log(
        `[Merge] FINAL XML=${result.length}`
    );

    return Buffer.from(
        result,
        "utf8"
    );
}

// ============================================================
// RAW MERGE
// ============================================================
//
// مهم جدًا:
//
// هذا الطلب يستقبل mGameInfo.xml فقط.
//
// لا نستخرج منه cityId.
// لا نستخرج منه cityVer.
// لا نستخرج منه saveId.
// لا نعدّل XML قبل جلب Friend.
//
// cityId و cityVer يأتيان من LocalInfo
// الذي تم التعامل معه في /decode-friends.
//
// ============================================================

async function handleRawMerge(
    req,
    res
) {
    try {
        // ----------------------------------------------------
        // 1. MAIN FILE
        // ----------------------------------------------------

        const mainEncrypted =
            req.body;

        if (
            !Buffer.isBuffer(
                mainEncrypted
            )
        ) {
            return res
                .status(400)
                .send(
                    "Main file يجب أن يكون application/octet-stream"
                );
        }

        if (
            mainEncrypted.length === 0
        ) {
            return res
                .status(400)
                .send(
                    "mGameInfo.xml فارغ"
                );
        }

        // ----------------------------------------------------
        // 2. المعلومات القادمة من LocalInfo
        // ----------------------------------------------------

        const cityId =
            String(
                req.headers["x-city-id"] || ""
            ).trim();

        const cityVer =
            Number(
                req.headers["x-city-ver"] || 0
            );

        if (!cityId) {
            return res
                .status(400)
                .send(
                    "X-City-Id مفقود"
                );
        }

        if (
            !Number.isFinite(cityVer) ||
            cityVer < 0
        ) {
            return res
                .status(400)
                .send(
                    "X-City-Ver غير صحيح"
                );
        }

        console.log(
            "========================================"
        );

        console.log(
            "[Merge] START"
        );

        console.log(
            `[Merge] cityId=${cityId}`
        );

        console.log(
            `[Merge] cityVer=${cityVer}`
        );

        console.log(
            `[Merge] main encrypted size=${mainEncrypted.length}`
        );

        console.log(
            `[Merge] main magic=${bufferMagic(mainEncrypted)}`
        );

        // ----------------------------------------------------
        // 3. فك mGameInfo فقط
        // ----------------------------------------------------
        //
        // لا editCityXml هنا.
        // لا استخراج معلومات.
        // فقط فك التشفير.
        //

        const mainXmlBuffer =
            decodeFriendFile(
                mainEncrypted
            );

        let mainXml =
            mainXmlBuffer
                .toString("utf8")
                .replace(/^\uFEFF/, "")
                .trim();

        console.log(
            `[Merge] main decoded size=${mainXml.length}`
        );

        if (
            !mainXml.startsWith("<")
        ) {
            throw new Error(
                "mGameInfo بعد فك التشفير ليس XML"
            );
        }

        console.log(
            "[Merge] mGameInfo decoded successfully"
        );

        // ----------------------------------------------------
        // 4. الآن فقط جلب مدينة الصديق
        // ----------------------------------------------------

        console.log(
            "[Merge] fetching friend city..."
        );

        const upstream =
            await requestFetchCity(
                cityId,
                cityVer
            );

        if (
            !upstream ||
            !upstream.result ||
            typeof upstream.result.data !==
                "string"
        ) {
            throw new Error(
                "FetchCity أعاد استجابة غير صالحة"
            );
        }

        const friendBytes =
            Buffer.from(
                upstream.result.data,
                "base64"
            );

        console.log(
            `[Merge] friend encrypted size=${friendBytes.length}`
        );

        console.log(
            `[Merge] friend magic=${bufferMagic(friendBytes)}`
        );

        // ----------------------------------------------------
        // 5. فك Friend
        // ----------------------------------------------------

        const friendXmlBuffer =
            decodeSaveCity(
                friendBytes
            );

        let friendXml =
            friendXmlBuffer
                .toString("utf8")
                .replace(/^\uFEFF/, "")
                .trim();

        if (
            !friendXml.startsWith("<")
        ) {
            throw new Error(
                "Friend بعد فك التشفير ليس XML"
            );
        }

        console.log(
            `[Merge] friend decoded size=${friendXml.length}`
        );

        // ----------------------------------------------------
        // 6. دمج Friend -> Main
        // ----------------------------------------------------

        console.log(
            "[Merge] copying Buildings..."
        );

        console.log(
            "[Merge] copying requested Vars..."
        );

        console.log(
            "[Merge] copying levelup -> END..."
        );

        const modifiedMain =
            mergeFriendIntoMain(
                mainXml,
                friendXml
            );

        // ----------------------------------------------------
        // 7. إرسال Main المعدل فقط
        // ----------------------------------------------------

        console.log(
            `[Merge] final result=${modifiedMain.length}`
        );

        console.log(
            "[Merge] DONE"
        );

        console.log(
            "========================================"
        );

        res.status(200);

        res.set(
            "Content-Type",
            "application/xml; charset=utf-8"
        );

        res.set(
            "Cache-Control",
            "no-store"
        );

        res.set(
            "Content-Disposition",
            'attachment; filename="mGameInfo.xml"'
        );

        return res.send(
            modifiedMain
        );

    } catch (err) {
        console.error(
            "========================================"
        );

        console.error(
            "[Merge] ERROR:"
        );

        console.error(
            err &&
            err.stack
                ? err.stack
                : err
        );

        console.error(
            "========================================"
        );

        return res
            .status(500)
            .send(
                String(
                    err &&
                    err.message
                        ? err.message
                        : err
                )
            );
    }
}

// ============================================================
// OLD JSON MODE
// ============================================================

async function handleFetchCity(
    req,
    res
) {
    try {
        let body =
            req.body || {};

        if (
            Buffer.isBuffer(body)
        ) {
            try {
                body =
                    JSON.parse(
                        body.toString("utf8")
                    );
            } catch (_) {
                return res
                    .status(400)
                    .send(
                        "JSON غير صالح"
                    );
            }
        }

        const cityId =
            String(
                body.cityId ||
                body.fetchCityId ||
                ""
            ).trim();

        const cityVer =
            Number(
                body.cityVer || 0
            );

        if (!cityId) {
            return res
                .status(400)
                .send(
                    "cityId مفقود"
                );
        }

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

        const cityBytes =
            Buffer.from(
                json.result.data,
                "base64"
            );

        const xml =
            decodeSaveCity(
                cityBytes
            );

        const modifiedXml =
            editCityXml(xml);

        res.status(200);

        res.set(
            "Content-Type",
            "application/xml; charset=utf-8"
        );

        return res.send(
            modifiedXml
        );

    } catch (err) {
        console.error(
            "[FetchCity] ERROR:",
            err
        );

        return res
            .status(500)
            .send(
                String(
                    err.message || err
                )
            );
    }
}

// ============================================================
// DECODE FRIENDS
// ============================================================
//
// هذا هو الجزء الخاص بالملف الأول LocalInfo.xml.
//
// منه فقط نأخذ:
// cityId
// cityVer
// friends
// saveId
//
// mGameInfo لا يدخل هنا إطلاقًا.
// ============================================================

async function handleDecodeFriends(
    req,
    res
) {
    try {
        const encryptedFile =
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
                        "يجب إرسال الملف كـ application/octet-stream"
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
            `[Friends] LocalInfo encrypted size=${encryptedFile.length}`
        );

        // ----------------------------------------------------
        // فك LocalInfo
        // ----------------------------------------------------

        const xmlBuffer =
            decodeFriendFile(
                encryptedFile
            );

        const xml =
            xmlBuffer
                .toString("utf8")
                .replace(/^\uFEFF/, "")
                .trim();

        if (
            !xml.startsWith("<")
        ) {
            throw new Error(
                "LocalInfo بعد فك التشفير ليس XML"
            );
        }

        // ----------------------------------------------------
        // Version
        // ----------------------------------------------------

        const version =
            parseFriendVersion(xml);

        if (!version.bver) {
            throw new Error(
                "لم يتم العثور على Version.version"
            );
        }

        if (!version.fver) {
            throw new Error(
                "لم يتم العثور على Version.FVer"
            );
        }

        // ----------------------------------------------------
        // Friends
        // ----------------------------------------------------

        const friends =
            parseFriends(xml);

        // ----------------------------------------------------
        // saveProfiles
        // ----------------------------------------------------

        const saveProfiles =
            parseSaveProfiles(xml);

        // ----------------------------------------------------
        // saveId
        // ----------------------------------------------------

        attachSaveIdsToFriends(
            friends,
            saveProfiles
        );

        console.log(
            `[Friends] friends=${friends.length}`
        );

        console.log(
            `[Friends] saveProfiles=${saveProfiles.length}`
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

                saveProfiles:
                    saveProfiles
            });

    } catch (err) {
        console.error(
            "[Friends] DECODE ERROR:",
            err
        );

        return res
            .status(500)
            .json({
                ok: false,

                error:
                    String(
                        err.message || err
                    )
            });
    }
}

// ============================================================
// ROUTES
// ============================================================

// ------------------------------------------------------------
// القديم
// ------------------------------------------------------------

router.post(
    "/",
    handleFetchCity
);

// ------------------------------------------------------------
// العملية الجديدة
// ------------------------------------------------------------
//
// Body:
// mGameInfo.xml المشفر فقط
//
// Headers:
// X-City-Id
// X-City-Ver
//
// ------------------------------------------------------------

router.post(
    "/fetch-city",
    express.raw({
        type:
            "application/octet-stream",

        limit:
            "50mb"
    }),
    handleRawMerge
);

// ------------------------------------------------------------
// LocalInfo.xml
// ------------------------------------------------------------

router.post(
    "/decode-friends",
    express.raw({
        type:
            "application/octet-stream",

        limit:
            "50mb"
    }),
    handleDecodeFriends
);

// ============================================================
// LOADED
// ============================================================

console.log(
    "[FetchCity] module loaded"
);

module.exports = router;
