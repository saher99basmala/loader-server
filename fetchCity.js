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
            "u32le ط®ط§ط±ط¬ ط­ط¯ظˆط¯ ط§ظ„ط¨ظٹط§ظ†ط§طھ"
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
            `ط¨ظٹط§ظ†ط§طھ 0x79 ظ‚طµظٹط±ط©: ${raw.length}`
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
            `ط¨ظٹط§ظ†ط§طھ 0x54 ظ‚طµظٹط±ط©: ${raw.length}`
        );
    }

    if (raw[0] !== 0x54) {

        throw new Error(
            `ط¨ظٹط§ظ†ط§طھ 0x54 ط؛ظٹط± طµط­ظٹط­ط©. Magic=${bufferMagic(raw)}`
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
                `ظ†ظˆط¹ FetchCity ط؛ظٹط± ظ…ط¯ط¹ظˆظ… ط­ط§ظ„ظٹط§ظ‹: 0x${type
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
                        "LZ4: literal length ط®ط§ط±ط¬ ط§ظ„ط¨ظٹط§ظ†ط§طھ"
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
                "LZ4: literals ط®ط§ط±ط¬ ط§ظ„ط¨ظٹط§ظ†ط§طھ"
            );
        }

        if (
            dstPos +
            literalLength >
            expectedSize
        ) {

            throw new Error(
                "LZ4: output overflow ط£ط«ظ†ط§ط، literals"
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
                "LZ4: offset ظ†ط§ظ‚طµ"
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
                `LZ4: offset ط£ظƒط¨ط± ظ…ظ† output: ${offset} > ${dstPos}`
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
                        "LZ4: match length ط®ط§ط±ط¬ ط§ظ„ط¨ظٹط§ظ†ط§طھ"
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
                "LZ4: output overflow ط£ط«ظ†ط§ط، match"
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
            `LZ4: ط§ظ„ط­ط¬ظ… ط§ظ„ظ†ط§طھط¬ ط؛ظٹط± ظ…ط·ط§ط¨ظ‚. expected=${expectedSize}, actual=${dstPos}`
        );
    }

    return output;
}

function decodeLz4Container(raw) {

    if (
        !isLz4Magic(raw)
    ) {

        throw new Error(
            `LZ4 magic ط؛ظٹط± طµط­ظٹط­: ${bufferMagic(raw)}`
        );
    }

    if (
        raw.length < 8
    ) {

        throw new Error(
            "LZ4 container ظ‚طµظٹط±"
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
            `طھظ… ظپظƒ ط·ط¨ط‚ط§طھ FetchCity ظ„ظƒظ† ط§ظ„ظ…ط±ط­ظ„ط© ط§ظ„طھط§ظ„ظٹط© ط؛ظٹط± ظ…ط¹ط±ظˆظپط©. Magic=${bufferMagic(data)}`
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
        `طھط¹ط°ط± ط§ظ„ظˆطµظˆظ„ ط¥ظ„ظ‰ XML. Magic=${bufferMagic(data)}`
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
            "ط§ط³طھط¬ط§ط¨ط© FetchCity ظ„ط§ طھط­طھظˆظٹ ts-id"
        );
    }

    if (
        typeof tsId !== "string" ||
        !tsId.startsWith("002")
    ) {

        throw new Error(
            `ts-id ط؛ظٹط± طµط§ظ„ط­: ${tsId}`
        );
    }

    const hex =
        tsId.slice(3);

    if (
        hex.length <
        24 + 32
    ) {

        throw new Error(
            `ts-id ظ‚طµطٹط±: ${tsId}`
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
        "طھط¹ط°ط± ظپظƒ ط¶ط؛ط· ط§ط³طھط¬ط§ط¨ط© FetchCity. " +
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
// FETCHCITY API
// ============================================================

async function handleFetchCity(
    req,
    res
) {

    try {

        const body =
            req.body || {};

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
                    "cityId ظ…ط·ظ„ظˆط¨"
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
                    "cityVer ط؛ظٹط± طµط§ظ„ط­"
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
                "Upstream JSON ظ„ط§ ظٹط­طھظˆظٹ result.data"
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
// FRIEND FILE DECODER
// ============================================================

const FRIEND_TABLE_SIZE = 0x2D7;

function friendU32(v) {
    return v >>> 0;
}

function friendReadU32(data, pos) {

    if (pos + 4 > data.length) {

        throw new Error(
            "ط¨ظٹط§ظ†ط§طھ ط؛ظٹط± ظƒط§ظپظٹط© ظ„ظ‚ط±ط§ط،ط© UInt32"
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
            "ط§ظ„ظ…ظ„ظپ طµط؛ظٹط± ط¬ط¯ظ‹ط§"
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
            "LZ4: ط§ظ„ط¨ظٹط§ظ†ط§طھ طµط؛ظٹط±ط© ط¬ط¯ظ‹ط§"
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
                "LZ4: ظ†ظ‡ط§ظٹط© ط¨ظٹط§ظ†ط§طھ ط؛ظٹط± ظ…طھظˆظ‚ط¹ط©"
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
                "LZ4: Literal ط®ط§ط±ط¬ ط§ظ„ظ†ط·ط§ظ‚"
            );
        }

        if (
            outLen +
            literalLen >
            size
        ) {

            throw new Error(
                "LZ4: ط­ط¬ظ… Literal ط؛ظٹط± طµط­ظٹط­"
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
                "LZ4: ظ„ط§ ظٹظˆط¬ط¯ Offset"
            );
        }

        const offset =
            readByte() |
            (
                readByte() <<
                8
            );

        if (
            offset === 0
        ) {

            throw new Error(
                "LZ4: Offset ط؛ظٹط± طµط§ظ„ط­"
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
                "LZ4: Offset ط®ط§ط±ط¬ ط§ظ„ظ†ط·ط§ظ‚"
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
                    "LZ4: ط§ظ„ط­ط¬ظ… ط§ظ„ظ†ط§طھط¬ طھط¬ط§ظˆط² ط§ظ„ظ…طھظˆظ‚ط¹"
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
            "LZ4: ط§ظ„ط­ط¬ظ… ط§ظ„ظ†ط§طھط¬ ط؛ظٹط± طµط­ظٹط­\n" +
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
// EXACT decodeFile()
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
            "ظ…ظ„ظپ ظپط§ط±ط؛"
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
            "ظ†ظˆط¹ ط؛ظٹط± ظ…ط¯ط¹ظˆظ…\nMagic: 0x" +
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
// XML ATTRIBUTE
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
// VERSION
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
// ALL IDs
// ============================================================

function parseAllIds(
    xml
) {

    const ids = [];
    const seen = new Set();

    function addId(
        id,
        type,
        tag
    ) {

        if (
            id === undefined ||
            id === null
        ) {
            return;
        }

        id =
            String(id).trim();

        if (!id) {
            return;
        }

        if (seen.has(id)) {
            return;
        }

        seen.add(id);

        ids.push({

            id: id,

            type:
                type || "",

            tag:
                tag || ""
        });
    }

    const tagRegex =
        /<([A-Za-z_][\w:.-]*)\b([^>]*)>/g;

    let match;

    while (
        (match =
            tagRegex.exec(xml)) !== null
    ) {

        const tagName =
            match[1];

        const attrs =
            match[2] || "";

        const attrRegex =
            /\b([A-Za-z_][\w:.-]*)\s*=\s*(["'])(.*?)\2/g;

        let attr;

        while (
            (attr =
                attrRegex.exec(attrs)) !== null
        ) {

            const name =
                attr[1];

            const value =
                attr[3];

            if (
                /^(?:id|city_id|cityId|friend_id|friendId|player_id|playerId|user_id|userId|uid)$/i
                    .test(name)
            ) {

                addId(
                    value,
                    name,
                    tagName
                );
            }
        }
    }

    const varRegex =
        /<Var\b([^>]*)>/gi;

    while (
        (match =
            varRegex.exec(xml)) !== null
    ) {

        const attrs =
            match[1] || "";

        const nameMatch =
            /\bname\s*=\s*(["'])(.*?)\1/i
                .exec(attrs);

        const valueMatch =
            /\bv\s*=\s*(["'])(.*?)\1/i
                .exec(attrs);

        if (
            nameMatch &&
            valueMatch
        ) {

            const name =
                nameMatch[2];

            const value =
                valueMatch[2];

            if (
                /(?:id|uid|city)/i
                    .test(name)
            ) {

                addId(
                    value,
                    name,
                    "Var"
                );
            }
        }
    }

    return ids;
}

// ============================================================
// DECODE FILE API
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
                        "ظٹط¬ط¨ ط¥ط±ط³ط§ظ„ ط§ظ„ظ…ظ„ظپ ط¨طµظٹط؛ط© application/octet-stream"
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
                        "ط§ظ„ظ…ظ„ظپ ظپط§ط±ط؛"
                });
        }

        console.log(
            `[IDs] encrypted file size=${encryptedFile.length}`
        );

        console.log(
            `[IDs] encrypted magic=${bufferMagic(encryptedFile)}`
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
            `[IDs] decoded XML size=${xml.length}`
        );

        if (
            !xml.startsWith("<")
        ) {

            throw new Error(
                "ط¨ط¹ط¯ ظپظƒ ط§ظ„ظ…ظ„ظپ ظ„ظ… ظٹطھظ… ط§ظ„ط­طµظˆظ„ ط¹ظ„ظ‰ XML"
            );
        }

        const version =
            parseFriendVersion(
                xml
            );

        const ids =
            parseAllIds(
                xml
            );

        console.log(
            `[IDs] bver=${version.bver}`
        );

        console.log(
            `[IDs] fver=${version.fver}`
        );

        console.log(
            `[IDs] ids=${ids.length}`
        );

        return res
            .status(200)
            .json({

                ok: true,

                bver:
                    version.bver,

                fver:
                    version.fver,

                ids:
                    ids
            });

    } catch (err) {

        console.error(
            "[IDs] DECODE ERROR:",
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

router.post(
    "/",
    handleFetchCity
);

router.post(
    "/fetch-city",
    handleFetchCity
);

router.post(
    "/decode-friends",
    express.raw({
        type: "application/octet-stream",
        limit: "50mb"
    }),
    handleDecodeFriends
);

console.log(
    "[FetchCity] module loaded"
);

module.exports = router;
