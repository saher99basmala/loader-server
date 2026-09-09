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
        throw new Error(
            "u32le خارج حدود البيانات"
        );
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
                Math.min(
                    buf.length,
                    512
                )
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
        raw.subarray(
            8
        );

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
        buf.toString(
            "utf8"
        );

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
        xml.toString(
            "utf8"
        );

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

// ============================================================
// COMPLETE FETCHCITY SAVE DECODER
// ============================================================

function decodeSaveCity(cityBytes) {
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
            `تعذر فك FetchCity. Magic=${bufferMagic(data)}`
        );
    }

    if (
        looksLikeXml(data)
    ) {
        return trimXml(
            data
        );
    }

    throw new Error(
        `تعذر الوصول إلى XML. Magic=${bufferMagic(data)}`
    );
}

// ============================================================
// AES REQUEST
// ============================================================

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

// ============================================================
// RESPONSE DECOMPRESSION
// ============================================================

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

    } catch (gzipError) {
        console.log(
            "[FetchCity] GZIP failed"
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

    } catch (zlibError) {
        console.log(
            "[FetchCity] ZLIB failed"
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

    } catch (rawError) {
        console.log(
            "[FetchCity] RAW DEFLATE failed"
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
        encryptRequest(
            requestJson
        );

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
                encodeURIComponent(
                    cityId
                ),
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

        if (!responseTsId) {
            throw new Error(
                "Upstream response missing ts-id"
            );
        }

        console.log(
            `[FetchCity] upstream status=${response.status}`
        );

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

        const json =
            JSON.parse(
                text
            );

        return json;

    } finally {
        clearTimeout(
            timer
        );
    }
}

// ============================================================
// FRIEND FILE DECODER
// ============================================================

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
            seed ^ data.length
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
            "LZ4: البيانات قصيرة"
        );
    }

    const size =
        friendReadU32(
            data,
            4
        );

    let src = 8;

    let output =
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
                "LZ4: البيانات غير مكتملة"
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
                    "LZ4: تجاوز حجم الإخراج"
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
            "LZ4: الحجم غير مطابق\n" +
            "Expected: " +
            size +
            "\nActual: " +
            outLen
        );
    }

    return output;
}

function friendTrimXml(
    data
) {
    const marker =
        Buffer.from(
            "</root>"
        );

    const pos =
        data.lastIndexOf(
            marker
        );

    if (
        pos !== -1
    ) {
        return data.subarray(
            0,
            pos +
            marker.length
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
// decodeFriendFile
// ============================================================

function decodeFriendFile(
    data
) {
    if (
        !Buffer.isBuffer(data)
    ) {
        data =
            Buffer.from(
                data
            );
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
                .padStart(
                    2,
                    "0"
                )
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

    return friendTrimXml(
        payload
    );
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

    if (
        doubleQuote
    ) {
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

    if (
        singleQuote
    ) {
        return singleQuote[1];
    }

    return "";
}

// ============================================================
// NORMALIZE CITY NAME
// ============================================================

function normalizeCityName(
    value
) {
    return String(
        value || ""
    )
        .trim()
        .replace(
            /\s+/g,
            " "
        )
        .toLowerCase();
}

// ============================================================
// FRIEND VERSION
// ============================================================

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

// ============================================================
// FRIENDS
// ============================================================

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
                ),

            saveId: ""
        });
    }

    return friends;
}

// ============================================================
// SAVE PROFILES / saveId
// ============================================================

function parseSaveProfiles(
    xml
) {
    const profiles = [];

    const regex =
        /<OtherPlayerProfilesLogicFeatureComponent\b[^>]*>/i;

    const match =
        xml.match(
            regex
        );

    if (!match) {
        console.log(
            "[Friends] OtherPlayerProfilesLogicFeatureComponent not found"
        );

        return profiles;
    }

    const tag =
        match[0];

    const profilesCache =
        attrFromXmlTag(
            tag,
            "ProfilesCache"
        );

    if (!profilesCache) {
        console.log(
            "[Friends] ProfilesCache not found"
        );

        return profiles;
    }

    let parsed;

    try {
        parsed =
            JSON.parse(
                profilesCache
            );

    } catch (err) {
        console.error(
            "[Friends] ProfilesCache JSON parse failed:",
            err.message
        );

        return profiles;
    }

    if (
        !Array.isArray(
            parsed
        )
    ) {
        console.log(
            "[Friends] ProfilesCache is not an array"
        );

        return profiles;
    }

    for (
        const profile of parsed
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
                profile.saveId || ""
            ).trim();

        if (
            !saveId
        ) {
            continue;
        }

        const cityname =
            String(
                profile.cityname || ""
            ).trim();

        const level =
            String(
                profile.level || ""
            ).trim();

        profiles.push({
            cityname:
                cityname,

            saveId:
                saveId,

            level:
                level
        });
    }

    console.log(
        `[Friends] saveProfiles=${profiles.length}`
    );

    return profiles;
}

// ============================================================
// ATTACH saveId TO FRIENDS
// ============================================================

function attachSaveIdsToFriends(
    friends,
    saveProfiles
) {
    if (
        !Array.isArray(friends)
    ) {
        return [];
    }

    if (
        !Array.isArray(saveProfiles) ||
        saveProfiles.length === 0
    ) {
        console.log(
            "[Friends] لا توجد saveProfiles"
        );

        return friends;
    }

    const profileMap =
        new Map();

    for (
        const profile of saveProfiles
    ) {
        const key =
            normalizeCityName(
                profile.cityname
            );

        if (
            !key ||
            !profile.saveId
        ) {
            continue;
        }

        if (
            !profileMap.has(key)
        ) {
            profileMap.set(
                key,
                profile.saveId
            );
        }
    }

    let matched = 0;

    for (
        const friend of friends
    ) {
        const cityNameKey =
            normalizeCityName(
                friend.city_name
            );

        const friendNameKey =
            normalizeCityName(
                friend.name
            );

        let saveId = "";

        if (
            cityNameKey &&
            profileMap.has(
                cityNameKey
            )
        ) {
            saveId =
                profileMap.get(
                    cityNameKey
                );
        }

        if (
            !saveId &&
            friendNameKey &&
            profileMap.has(
                friendNameKey
            )
        ) {
            saveId =
                profileMap.get(
                    friendNameKey
                );
        }

        if (
            saveId
        ) {
            friend.saveId =
                saveId;

            matched++;
        }
    }

    console.log(
        `[Friends] saveId matched=${matched}/${friends.length}`
    );

    return friends;
}

// ============================================================
// ============================================================
// NEW MERGE SYSTEM
// ============================================================
// ============================================================

// الأقسام التي يتم نسخها من Friend -> Main
//
// unlockAllCards كان مكررًا في القائمة الأصلية.
// يتم استخدام Set لاحقًا حتى يتم التعامل معه كقسم واحد.

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
// FIND COMPLETE <Var> SECTION
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
        regex.exec(
            xml
        );

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

    // self closing
    if (
        /\/>\s*$/.test(
            openingTag
        )
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
// FIND BUILDINGS SECTIONS
// ============================================================
//
// المطلوب:
// يبدأ القسم بالضبط من:
//
// </TownGround><Buildings><Object
//
// وينتهي عند </Buildings> المطابق.
//
// يتم هنا حساب <Buildings> و </Buildings>
// بدل الاعتماد على أول </Buildings> بشكل أعمى.
//

function findBuildingsSections(
    xml
) {
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

        if (
            start === -1
        ) {
            break;
        }

        // موضع <Buildings> داخل الـ marker
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

        if (
            end === -1
        ) {
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

    // من الأخير للأول حتى لا تتغير offsets
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
// COPY LEVELUP TO END
// ============================================================
//
// المطلوب يبدأ من:
//
// <Var name="levelup" v="1089" t="i"/>
//
// وليس فقط الـ Var.
// يتم أخذ كل شيء من هذا الموضع
// حتى نهاية Friend XML.
//

function copyLevelupToEnd(
    mainXml,
    friendXml
) {
    const LEVELUP_REGEX =
        /<Var\b[^>]*\bname\s*=\s*["']levelup["'][^>]*\/?>/i;

    const mainMatch =
        LEVELUP_REGEX.exec(
            mainXml
        );

    if (!mainMatch) {
        throw new Error(
            'Main XML لا يحتوي <Var name="levelup"...>'
        );
    }

    const friendMatch =
        LEVELUP_REGEX.exec(
            friendXml
        );

    if (!friendMatch) {
        throw new Error(
            'Friend XML لا يحتوي <Var name="levelup"...>'
        );
    }

    const mainStart =
        mainMatch.index;

    const friendStart =
        friendMatch.index;

    const result =
        mainXml.slice(
            0,
            mainStart
        ) +
        friendXml.slice(
            friendStart
        );

    console.log(
        "[Merge] copied levelup -> END"
    );

    return result;
}

// ============================================================
// MERGE FRIEND INTO MAIN
// ============================================================

function mergeFriendIntoMain(
    mainXml,
    friendXml
) {
    if (
        Buffer.isBuffer(mainXml)
    ) {
        mainXml =
            mainXml.toString(
                "utf8"
            );
    }

    if (
        Buffer.isBuffer(friendXml)
    ) {
        friendXml =
            friendXml.toString(
                "utf8"
            );
    }

    mainXml =
        String(
            mainXml
        ).replace(
            /^\uFEFF/,
            ""
        );

    friendXml =
        String(
            friendXml
        ).replace(
            /^\uFEFF/,
            ""
        );

    console.log(
        `[Merge] main size=${mainXml.length}`
    );

    console.log(
        `[Merge] friend size=${friendXml.length}`
    );

    // 1. Buildings
    let result =
        copyBothBuildingsSections(
            mainXml,
            friendXml
        );

    // 2. الأقسام المطلوبة
    result =
        copyNamedSections(
            result,
            friendXml
        );

    // 3. levelup -> END
    result =
        copyLevelupToEnd(
            result,
            friendXml
        );

    console.log(
        `[Merge] final main size=${result.length}`
    );

    return Buffer.from(
        result,
        "utf8"
    );
}

// ============================================================
// NEW RAW MERGE MODE
// ============================================================
//
// Lua يرسل:
//
// Content-Type: application/octet-stream
// X-City-Id: cityId
// X-City-Ver: cityVer
//
// Body = mGameInfo.xml المشفر
//
// السيرفر يرجع mGameInfo.xml المعدل فقط.
//

async function handleRawMerge(
    req,
    res
) {
    try {
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
                    "Main file فارغ"
                );
        }

        const cityId =
            String(
                req.headers[
                    "x-city-id"
                ] || ""
            ).trim();

        const cityVer =
            Number(
                req.headers[
                    "x-city-ver"
                ] || 0
            );

        if (!cityId) {
            return res
                .status(400)
                .send(
                    "X-City-Id مفقود"
                );
        }

        if (
            !Number.isFinite(
                cityVer
            ) ||
            cityVer < 0
        ) {
            return res
                .status(400)
                .send(
                    "X-City-Ver غير صحيح"
                );
        }

        console.log(
            `[Merge] incoming cityId=${cityId} cityVer=${cityVer}`
        );

        console.log(
            `[Merge] main encrypted size=${mainEncrypted.length}`
        );

        console.log(
            `[Merge] main encrypted magic=${bufferMagic(mainEncrypted)}`
        );

        // ====================================================
        // فك mGameInfo.xml
        // ====================================================

        const mainXmlBuffer =
            decodeFriendFile(
                mainEncrypted
            );

        const mainXml =
            mainXmlBuffer
                .toString("utf8")
                .replace(
                    /^\uFEFF/,
                    ""
                )
                .trim();

        console.log(
            `[Merge] decoded main XML size=${mainXml.length}`
        );

        if (
            !mainXml.startsWith("<")
        ) {
            throw new Error(
                "Main file بعد فك التشفير ليس XML"
            );
        }

        // ====================================================
        // جلب Friend من Playrix
        // ====================================================

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

        const base64 =
            upstream.result.data;

        console.log(
            `[Merge] Friend Base64 length=${base64.length}`
        );

        const friendBytes =
            Buffer.from(
                base64,
                "base64"
            );

        console.log(
            `[Merge] Friend bytes=${friendBytes.length} magic=${bufferMagic(friendBytes)}`
        );

        // ====================================================
        // فك Friend
        // ====================================================

        const friendXmlBuffer =
            decodeSaveCity(
                friendBytes
            );

        const friendXml =
            (
                Buffer.isBuffer(
                    friendXmlBuffer
                )
                    ? friendXmlBuffer.toString(
                          "utf8"
                      )
                    : String(
                          friendXmlBuffer
                      )
            )
                .replace(
                    /^\uFEFF/,
                    ""
                )
                .trim();

        console.log(
            `[Merge] decoded Friend XML size=${friendXml.length}`
        );

        if (
            !friendXml.startsWith("<")
        ) {
            throw new Error(
                "Friend file بعد فك التشفير ليس XML"
            );
        }

        // ====================================================
        // MERGE
        // ====================================================

        const modifiedMain =
            mergeFriendIntoMain(
                mainXml,
                friendXml
            );

        console.log(
            `[Merge] modified main size=${modifiedMain.length}`
        );

        // ====================================================
        // RESPONSE
        // ====================================================

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
            "[Merge] ERROR:",
            err &&
            err.stack
                ? err.stack
                : err
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
// FETCHCITY API - OLD JSON MODE
// ============================================================

async function handleFetchCity(
    req,
    res
) {
    try {

        // ====================================================
        // NEW RAW MODE
        // ====================================================

        const contentType =
            String(
                req.headers[
                    "content-type"
                ] || ""
            ).toLowerCase();

        if (
            contentType.startsWith(
                "application/octet-stream"
            )
        ) {
            return handleRawMerge(
                req,
                res
            );
        }

        // ====================================================
        // OLD JSON MODE
        // ====================================================

        let body =
            req.body || {};

        // حماية إضافية إذا وصل JSON كـ Buffer
        if (
            Buffer.isBuffer(
                body
            )
        ) {
            try {
                body =
                    JSON.parse(
                        body.toString(
                            "utf8"
                        )
                    );
            } catch (e) {
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

        if (
            !Number.isFinite(
                cityVer
            ) ||
            cityVer < 0
        ) {
            return res
                .status(400)
                .send(
                    "cityVer غير صالح"
                );
        }

        console.log(
            `[FetchCity] incoming cityId=${cityId} cityVer=${cityVer}`
        );

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

        res.status(200);

        res.set(
            "Content-Type",
            "application/xml; charset=utf-8"
        );

        res.set(
            "Cache-Control",
            "no-store"
        );

        return res.send(
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
// DECODE FRIEND FILE API
// ============================================================

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
            `[Friends] encrypted file size=${encryptedFile.length}`
        );

        console.log(
            `[Friends] encrypted magic=${bufferMagic(encryptedFile)}`
        );

        // ====================================================
        // decodeFile
        // ====================================================

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
                "الملف بعد فك التشفير ليس XML"
            );
        }

        const version =
            parseFriendVersion(
                xml
            );

        if (
            !version.bver
        ) {
            throw new Error(
                "لم يتم العثور على Version.version"
            );
        }

        if (
            !version.fver
        ) {
            throw new Error(
                "لم يتم العثور على Version.FVer"
            );
        }

        // ====================================================
        // استخراج friends
        // ====================================================

        const friends =
            parseFriends(
                xml
            );

        // ====================================================
        // استخراج saveId
        // ====================================================

        const saveProfiles =
            parseSaveProfiles(
                xml
            );

        // ====================================================
        // ربط saveId
        // ====================================================

        attachSaveIdsToFriends(
            friends,
            saveProfiles
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
            `[Friends] saveProfiles=${saveProfiles.length}`
        );

        // ====================================================
        // عرض النتائج
        // ====================================================

        for (
            const friend of friends
        ) {
            if (
                friend.saveId
            ) {
                console.log(
                    `[Friends] MATCH city_name="${friend.city_name}" city_id="${friend.city_id}" saveId="${friend.saveId}"`
                );
            }
        }

        // ====================================================
        // RESPONSE
        // ====================================================

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
                    String(
                        err &&
                        err.message
                            ? err.message
                            : err
                    )
            });
    }
}

// ============================================================
// ROUTES
// ============================================================

// القديم
router.post(
    "/",
    handleFetchCity
);

// الجديد + القديم
//
// مهم:
// octet-stream يتم تحويله إلى Buffer.
// JSON لا يزال يمر إلى السلوك القديم.

router.post(
    "/fetch-city",
    express.raw({
        type:
            "application/octet-stream",

        limit:
            "50mb"
    }),
    handleFetchCity
);

// decode friends
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

console.log(
    "[FetchCity] module loaded"
);

module.exports = router;
