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
            "u32le ط·آ®ط·آ§ط·آ±ط·آ¬ ط·آ­ط·آ¯ط¸ث†ط·آ¯ ط·آ§ط¸â€‍ط·آ¨ط¸ظ¹ط·آ§ط¸â€ ط·آ§ط·ع¾"
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
            `ط·آ¨ط¸ظ¹ط·آ§ط¸â€ ط·آ§ط·ع¾ 0x79 ط¸â€ڑط·آµط¸ظ¹ط·آ±ط·آ©: ${raw.length}`
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
            `ط·آ¨ط¸ظ¹ط·آ§ط¸â€ ط·آ§ط·ع¾ 0x54 ط¸â€ڑط·آµط¸ظ¹ط·آ±ط·آ©: ${raw.length}`
        );
    }

    if (raw[0] !== 0x54) {

        throw new Error(
            `ط·آ¨ط¸ظ¹ط·آ§ط¸â€ ط·آ§ط·ع¾ 0x54 ط·ط›ط¸ظ¹ط·آ± ط·آµط·آ­ط¸ظ¹ط·آ­ط·آ©. Magic=${bufferMagic(raw)}`
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
                `ط¸â€ ط¸ث†ط·آ¹ FetchCity ط·ط›ط¸ظ¹ط·آ± ط¸â€¦ط·آ¯ط·آ¹ط¸ث†ط¸â€¦ ط·آ­ط·آ§ط¸â€‍ط¸ظ¹ط·آ§ط¸â€¹: 0x${type
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
                        "LZ4: literal length ط·آ®ط·آ§ط·آ±ط·آ¬ ط·آ§ط¸â€‍ط·آ¨ط¸ظ¹ط·آ§ط¸â€ ط·آ§ط·ع¾"
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
                "LZ4: literals ط·آ®ط·آ§ط·آ±ط·آ¬ ط·آ§ط¸â€‍ط·آ¨ط¸ظ¹ط·آ§ط¸â€ ط·آ§ط·ع¾"
            );
        }

        if (
            dstPos +
            literalLength >
            expectedSize
        ) {

            throw new Error(
                "LZ4: output overflow ط·آ£ط·آ«ط¸â€ ط·آ§ط·طŒ literals"
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
                "LZ4: offset ط¸â€ ط·آ§ط¸â€ڑط·آµ"
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
                `LZ4: offset ط·آ£ط¸ئ’ط·آ¨ط·آ± ط¸â€¦ط¸â€  output: ${offset} > ${dstPos}`
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
                        "LZ4: match length ط·آ®ط·آ§ط·آ±ط·آ¬ ط·آ§ط¸â€‍ط·آ¨ط¸ظ¹ط·آ§ط¸â€ ط·آ§ط·ع¾"
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
                "LZ4: output overflow ط·آ£ط·آ«ط¸â€ ط·آ§ط·طŒ match"
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
            `LZ4: ط·آ§ط¸â€‍ط·آ­ط·آ¬ط¸â€¦ ط·آ§ط¸â€‍ط¸â€ ط·آ§ط·ع¾ط·آ¬ ط·ط›ط¸ظ¹ط·آ± ط¸â€¦ط·آ·ط·آ§ط·آ¨ط¸â€ڑ. expected=${expectedSize}, actual=${dstPos}`
        );
    }

    return output;
}

function decodeLz4Container(raw) {

    if (
        !isLz4Magic(raw)
    ) {

        throw new Error(
            `LZ4 magic ط·ط›ط¸ظ¹ط·آ± ط·آµط·آ­ط¸ظ¹ط·آ­: ${bufferMagic(raw)}`
        );
    }

    if (
        raw.length < 8
    ) {

        throw new Error(
            "LZ4 container ط¸â€ڑط·آµط¸ظ¹ط·آ±"
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
            `ط·ع¾ط¸â€¦ ط¸ظ¾ط¸ئ’ ط·آ·ط·آ¨ط¸â€ڑط·آ§ط·ع¾ FetchCity ط¸â€‍ط¸ئ’ط¸â€  ط·آ§ط¸â€‍ط¸â€¦ط·آ±ط·آ­ط¸â€‍ط·آ© ط·آ§ط¸â€‍ط·ع¾ط·آ§ط¸â€‍ط¸ظ¹ط·آ© ط·ط›ط¸ظ¹ط·آ± ط¸â€¦ط·آ¹ط·آ±ط¸ث†ط¸ظ¾ط·آ©. Magic=${bufferMagic(data)}`
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
        `ط·ع¾ط·آ¹ط·آ°ط·آ± ط·آ§ط¸â€‍ط¸ث†ط·آµط¸ث†ط¸â€‍ ط·آ¥ط¸â€‍ط¸â€° XML. Magic=${bufferMagic(data)}`
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
            "ط·آ§ط·آ³ط·ع¾ط·آ¬ط·آ§ط·آ¨ط·آ© FetchCity ط¸â€‍ط·آ§ ط·ع¾ط·آ­ط·ع¾ط¸ث†ط¸ظ¹ ts-id"
        );
    }

    if (
        typeof tsId !== "string" ||
        !tsId.startsWith("002")
    ) {

        throw new Error(
            `ts-id ط·ط›ط¸ظ¹ط·آ± ط·آµط·آ§ط¸â€‍ط·آ­: ${tsId}`
        );
    }

    const hex =
        tsId.slice(3);

    if (
        hex.length <
        24 + 32
    ) {

        throw new Error(
            `ts-id ط¸â€ڑط·آµط¸ظ¹ط·آ±: ${tsId}`
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
        "ط·ع¾ط·آ¹ط·آ°ط·آ± ط¸ظ¾ط¸ئ’ ط·آ¶ط·ط›ط·آ· ط·آ§ط·آ³ط·ع¾ط·آ¬ط·آ§ط·آ¨ط·آ© FetchCity. " +
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
                    "cityId ط¸â€¦ط·آ·ط¸â€‍ط¸ث†ط·آ¨"
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
                    "cityVer ط·ط›ط¸ظ¹ط·آ± ط·آµط·آ§ط¸â€‍ط·آ­"
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
                "Upstream JSON ط¸â€‍ط·آ§ ط¸ظ¹ط·آ­ط·ع¾ط¸ث†ط¸ظ¹ result.data"
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

function friendReadU32(
    data,
    pos
) {

    if (
        pos + 4 >
        data.length
    ) {

        throw new Error(
            "ط·آ¨ط¸ظ¹ط·آ§ط¸â€ ط·آ§ط·ع¾ ط·ط›ط¸ظ¹ط·آ± ط¸ئ’ط·آ§ط¸ظ¾ط¸ظ¹ط·آ© ط¸â€‍ط¸â€ڑط·آ±ط·آ§ط·طŒط·آ© UInt32"
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
            "ط·آ§ط¸â€‍ط¸â€¦ط¸â€‍ط¸ظ¾ ط·آµط·ط›ط¸ظ¹ط·آ± ط·آ¬ط·آ¯ط·آ§ط¸â€¹"
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
            "LZ4: ط·آ§ط¸â€‍ط·آ¨ط¸ظ¹ط·آ§ط¸â€ ط·آ§ط·ع¾ ط·آµط·ط›ط¸ظ¹ط·آ±ط·آ© ط·آ¬ط·آ¯ط·آ§ط¸â€¹"
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
                "LZ4: ط¸â€ ط¸â€،ط·آ§ط¸ظ¹ط·آ© ط·آ¨ط¸ظ¹ط·آ§ط¸â€ ط·آ§ط·ع¾ ط·ط›ط¸ظ¹ط·آ± ط¸â€¦ط·ع¾ط¸ث†ط¸â€ڑط·آ¹ط·آ©"
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
                "LZ4: Literal ط·آ®ط·آ§ط·آ±ط·آ¬ ط·آ§ط¸â€‍ط¸â€ ط·آ·ط·آ§ط¸â€ڑ"
            );
        }

        if (
            outLen +
            literalLen >
            size
        ) {

            throw new Error(
                "LZ4: ط·آ­ط·آ¬ط¸â€¦ Literal ط·ط›ط¸ظ¹ط·آ± ط·آµط·آ­ط¸ظ¹ط·آ­"
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
                "LZ4: ط¸â€‍ط·آ§ ط¸ظ¹ط¸ث†ط·آ¬ط·آ¯ Offset"
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
                "LZ4: Offset ط·ط›ط¸ظ¹ط·آ± ط·آµط·آ§ط¸â€‍ط·آ­"
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
                "LZ4: Offset ط·آ®ط·آ§ط·آ±ط·آ¬ ط·آ§ط¸â€‍ط¸â€ ط·آ·ط·آ§ط¸â€ڑ"
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
                    "LZ4: ط·آ§ط¸â€‍ط·آ­ط·آ¬ط¸â€¦ ط·آ§ط¸â€‍ط¸â€ ط·آ§ط·ع¾ط·آ¬ ط·ع¾ط·آ¬ط·آ§ط¸ث†ط·آ² ط·آ§ط¸â€‍ط¸â€¦ط·ع¾ط¸ث†ط¸â€ڑط·آ¹"
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
            "LZ4: ط·آ§ط¸â€‍ط·آ­ط·آ¬ط¸â€¦ ط·آ§ط¸â€‍ط¸â€ ط·آ§ط·ع¾ط·آ¬ ط·ط›ط¸ظ¹ط·آ± ط·آµط·آ­ط¸ظ¹ط·آ­\n" +
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
            "ط¸â€¦ط¸â€‍ط¸ظ¾ ط¸ظ¾ط·آ§ط·آ±ط·ط›"
        );
    }

    // XML ط·آ£ط·آµط¸â€‍ط·آ§ط¸â€¹
    if (
        data[0] === 0x3C
    ) {

        return data;
    }

    // ط¸ظ¹ط·آ¬ط·آ¨ ط·آ£ط¸â€  ط¸ظ¹ط·آ¨ط·آ¯ط·آ£ ط·آ¨ط¸â‚¬ 0x79
    if (
        data[0] !== 0x79
    ) {

        throw new Error(
            "ط¸â€ ط¸ث†ط·آ¹ ط·ط›ط¸ظ¹ط·آ± ط¸â€¦ط·آ¯ط·آ¹ط¸ث†ط¸â€¦\nMagic: 0x" +
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

function decodeXmlEntities(value) {
    return String(value || "")
        .replace(/&quot;/gi, "\"")
        .replace(/&apos;/gi, "'")
        .replace(/&#39;/gi, "'")
        .replace(/&#x27;/gi, "'")
        .replace(/&lt;/gi, "<")
        .replace(/&gt;/gi, ">")
        .replace(/&amp;/gi, "&");
}

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

        return decodeXmlEntities(doubleQuote[1]);
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

        return decodeXmlEntities(singleQuote[1]);
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

            // ط·آ³ط¸ظ¹ط·آ¶ط·آ§ط¸ظ¾ saveId ط·آ¨ط·آ¹ط·آ¯ ط¸â€ڑط·آ±ط·آ§ط·طŒط·آ© ProfilesCache
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
            typeof profile !== "object"
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
            "[Friends] ط¸â€‍ط·آ§ ط·ع¾ط¸ث†ط·آ¬ط·آ¯ saveProfiles ط¸â€‍ط·آ±ط·آ¨ط·آ·ط¸â€،ط·آ§"
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

        // ط·آ£ط¸ث†ط¸â€‍ saveId ط¸â€‍ط¸â€ ط¸ظ¾ط·آ³ ط·آ§ط¸â€‍ط·آ§ط·آ³ط¸â€¦ ط¸ظ¹ط·آ¨ط¸â€ڑط¸â€° ط¸â€،ط¸ث† ط·آ§ط¸â€‍ط¸â€¦ط·آ³ط·ع¾ط·آ®ط·آ¯ط¸â€¦
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

        // ط·آ§ط¸â€‍ط¸â€¦ط·آ·ط·آ§ط·آ¨ط¸â€ڑط·آ© ط·آ§ط¸â€‍ط·آ£ط·آ³ط·آ§ط·آ³ط¸ظ¹ط·آ©: city_name
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

        // ط·آ§ط·آ­ط·ع¾ط¸ظ¹ط·آ§ط·آ·ط¸ظ¹ط·آ§ط¸â€¹: name
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
                        "ط¸ظ¹ط·آ¬ط·آ¨ ط·آ¥ط·آ±ط·آ³ط·آ§ط¸â€‍ .123.xml ط·آ¨ط·آµط¸ظ¹ط·ط›ط·آ© application/octet-stream"
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
                        "ط·آ§ط¸â€‍ط¸â€¦ط¸â€‍ط¸ظ¾ ط¸ظ¾ط·آ§ط·آ±ط·ط›"
                });
        }

        console.log(
            `[Friends] encrypted file size=${encryptedFile.length}`
        );

        console.log(
            `[Friends] encrypted magic=${bufferMagic(encryptedFile)}`
        );

        // ====================================================
        // decodeFile ط·آ§ط¸â€‍ط·آ­ط¸â€ڑط¸ظ¹ط¸â€ڑط¸ظ¹
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
                "ط·آ¨ط·آ¹ط·آ¯ ط¸ظ¾ط¸ئ’ .123.xml ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ­ط·آµط¸ث†ط¸â€‍ ط·آ¹ط¸â€‍ط¸â€° XML"
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
                "ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° Version.version"
            );
        }

        if (
            !version.fver
        ) {

            throw new Error(
                "ط¸â€‍ط¸â€¦ ط¸ظ¹ط·ع¾ط¸â€¦ ط·آ§ط¸â€‍ط·آ¹ط·آ«ط¸ث†ط·آ± ط·آ¹ط¸â€‍ط¸â€° Version.FVer"
            );
        }

        // ====================================================
        // ط·آ§ط·آ³ط·ع¾ط·آ®ط·آ±ط·آ§ط·آ¬ friends
        // ====================================================

        const friends =
            parseFriends(
                xml
            );

        // ====================================================
        // ط·آ§ط·آ³ط·ع¾ط·آ®ط·آ±ط·آ§ط·آ¬ saveId ط¸â€¦ط¸â€  ProfilesCache
        // ====================================================

        const saveProfiles =
            parseSaveProfiles(
                xml
            );

        // ====================================================
        // ط·آ±ط·آ¨ط·آ· saveId ط¸â€¦ط·آ¹ friends
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
        // ط·آ·ط·آ¨ط·آ§ط·آ¹ط·آ© ط¸â€ ط·ع¾ط¸ظ¹ط·آ¬ط·آ© ط·آ§ط¸â€‍ط·آ±ط·آ¨ط·آ·
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
// APP ACCOUNT RESTORE MERGE (isolated endpoint; leaves existing routes intact)
// The Android app applies donor progress first, then selected city/zoo sections.
// ============================================================
function restoreEscapeRegExp(value) {
    return String(value).replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}
function restoreFindTag(xml, name, fromIndex = 0) {
    const nameRe = restoreEscapeRegExp(name);
    const tokenRe = new RegExp(`<\\/?${nameRe}\\b[^>]*>`, "gi");
    tokenRe.lastIndex = Math.max(0, fromIndex);
    const first = tokenRe.exec(xml);
    if (!first) return null;
    const firstToken = first[0];
    if (/^<\/?/.test(firstToken) && /^<\w+[^>]*\/>$/.test(firstToken)) {
        return { text: firstToken, start: first.index, end: first.index + firstToken.length };
    }
    let depth = 0;
    tokenRe.lastIndex = first.index;
    let token;
    while ((token = tokenRe.exec(xml)) !== null) {
        const raw = token[0];
        if (/^<\//.test(raw)) depth--;
        else if (!/\/\s*>$/.test(raw)) depth++;
        if (depth === 0) {
            return { text: xml.slice(first.index, token.index + raw.length), start: first.index, end: token.index + raw.length };
        }
    }
    return null;
}
function restoreReplaceTag(xml, name, replacement) {
    const block = restoreFindTag(xml, name);
    if (!block) return xml;
    return xml.slice(0, block.start) + replacement + xml.slice(block.end);
}
function restoreAttr(tag, attr) {
    const re = new RegExp(`\\b${restoreEscapeRegExp(attr)}\\s*=\\s*(["'])(.*?)\\1`, "i");
    const match = tag.match(re);
    return match ? match[2] : null;
}
function restoreCopySection(donorXml, baseXml, name) {
    const donor = restoreFindTag(donorXml, name);
    if (!donor) return baseXml;
    const base = restoreFindTag(baseXml, name);
    if (base) return baseXml.slice(0, base.start) + donor.text + baseXml.slice(base.end);
    const rootClose = /<\/root\s*>/i.exec(baseXml);
    if (!rootClose) return baseXml;
    return baseXml.slice(0, rootClose.index) + donor.text + "\n" + baseXml.slice(rootClose.index);
}
function restoreVarTag(xml, name) {
    const escaped = restoreEscapeRegExp(name);
    const re = new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escaped}["'])[^>]*(?:\\/>|>[\\s\\S]*?<\\/Var\\s*>)`, "i");
    const m = re.exec(xml);
    return m ? m[0] : null;
}
function restoreCopyVar(donorXml, baseXml, name) {
    const donor = restoreVarTag(donorXml, name);
    if (!donor) return baseXml;
    const escaped = restoreEscapeRegExp(name);
    const re = new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escaped}["'])[^>]*(?:\\/>|>[\\s\\S]*?<\\/Var\\s*>)`, "i");
    if (re.test(baseXml)) return baseXml.replace(re, () => donor);
    const vars = restoreFindTag(baseXml, "Vars");
    if (!vars) return baseXml;
    const insertAt = baseXml.lastIndexOf("</Vars>", vars.end);
    if (insertAt < 0) return baseXml;
    return baseXml.slice(0, insertAt) + donor + "\n    " + baseXml.slice(insertAt);
}
function restoreCopyVarsByName(donorXml, baseXml, names, insertInto = "Vars") {
    const wanted = new Set(names);
    if (!wanted.size) return baseXml;
    const donorTags = new Map();
    for (const tag of donorXml.match(/<Var\b[^>]*\/>/gi) || []) {
        const name = restoreAttr(tag, "name");
        if (name && wanted.has(name)) donorTags.set(name, tag);
    }
    if (!donorTags.size) return baseXml;
    const present = new Set();
    baseXml = baseXml.replace(/<Var\b[^>]*\/>/gi, tag => {
        const name = restoreAttr(tag, "name");
        if (!name || !donorTags.has(name)) return tag;
        present.add(name);
        return donorTags.get(name);
    });
    const missing = [];
    for (const [name, tag] of donorTags) if (!present.has(name)) missing.push(tag);
    if (missing.length) {
        const vars = restoreFindTag(baseXml, insertInto);
        if (vars) {
            const closeAt = baseXml.lastIndexOf(`</${insertInto}>`, vars.end);
            if (closeAt >= 0) baseXml = baseXml.slice(0, closeAt) + missing.join("\n    ") + "\n    " + baseXml.slice(closeAt);
        }
    }
    return baseXml;
}
function restoreVarValue(xml, name) {
    const tag = restoreVarTag(xml, name);
    return tag ? restoreAttr(tag, "v") : null;
}
function restoreSetVar(xml, name, value) {
    const escaped = restoreEscapeRegExp(name);
    const tagRe = new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escaped}["'])[^>]*/?>`, "i");
    if (tagRe.test(xml)) {
        return xml.replace(tagRe, tag => {
            const valueRe = /(\bv=["'])[^"']*(["'])/i;
            if (valueRe.test(tag)) return tag.replace(valueRe, (_, a, b) => a + String(value) + b);
            const ending = /\s*\/>$/.exec(tag);
            if (ending) return tag.slice(0, ending.index) + ` v="${String(value)}"` + tag.slice(ending.index);
            return tag.replace(/>$/, ` v="${String(value)}">`);
        });
    }
    const insertion = `<Var name="${name}" v="${String(value)}"/>`;
    const global = restoreFindTag(xml, "Global");
    if (global) return xml.slice(0, global.end - "</Global>".length) + insertion + "\n  " + xml.slice(global.end - "</Global>".length);
    const vars = restoreFindTag(xml, "Vars");
    if (vars) return xml.slice(0, vars.end - "</Vars>".length) + insertion + "\n    " + xml.slice(vars.end - "</Vars>".length);
    return xml;
}
function restoreSetIntVar(xml, name, value) {
    const escaped = restoreEscapeRegExp(name);
    const replacement = `<Var name="${name}" v="${String(value)}" t="i"/>`;
    const re = new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escaped}["'])[^>]*/>`, "i");
    if (re.test(xml)) return xml.replace(re, () => replacement);
    const global = restoreFindTag(xml, "Global");
    if (!global) return restoreSetVar(xml, name, value);
    const closeAt = global.end - "</Global>".length;
    return xml.slice(0, closeAt) + replacement + "\n  " + xml.slice(closeAt);
}
function restoreCopyWholeVarGroups(donorXml, baseXml) {
    const groups = [
        ["moneyCash"], ["money"], ["levelup"],
        ["m3_comp_lvls", "M3Ch_mainM3", "STLM3"],
        ["FirstAttemptM3Levels"], ["LivesSent"],
        ["Achievement_Teamwork"], ["FullCardCollections"],
        ["RegataTasksCompleted"], ["gameStartDate"],
        ["expeditionEnergy"], ["depth"], ["likes"]
    ];
    for (const names of groups) {
        let value = null;
        for (const name of names) {
            value = restoreVarValue(donorXml, name);
            if (value !== null) break;
        }
        if (value !== null) {
            for (const name of names) baseXml = restoreSetVar(baseXml, name, value);
        }
    }
    return baseXml;
}
function restoreCopyNamedDataElems(donorXml, baseXml, names, insertMissing = false) {
    for (const name of names) {
        const escaped = restoreEscapeRegExp(name);
        const re = new RegExp(`<DataElem\\b(?=[^>]*\\bname=["']${escaped}["'])[^>]*/?>`, "i");
        const donor = re.exec(donorXml);
        if (!donor) continue;
        if (re.test(baseXml)) baseXml = baseXml.replace(re, () => donor[0]);
        else if (insertMissing) {
            const rootClose = /<\/root\s*>/i.exec(baseXml);
            if (rootClose) baseXml = baseXml.slice(0, rootClose.index) + donor[0] + "\n" + baseXml.slice(rootClose.index);
        }
    }
    return baseXml;
}
function restorePhaseOne(baseXml, donorXml) {
    // Scalar progression/resources transferred by Android C.k.
    const direct = ["money", "moneyCash", "EarnedCoins", "residents", "wheatCounter",
        "plowFieldsAchiev", "defaultOrdersCount", "match3Life", "Match3Lives_infTime",
        "Achievement_IncreasedPopulation", "Achievement_PlowedFields", "Achievement_BuiltFactories",
        "Achievement_SpentCoins", "Achievement_EarneCoins", "spentCash", "earnedCash", "timeInGame"];
    for (const name of direct) baseXml = restoreCopyVar(donorXml, baseXml, name);
    baseXml = restoreCopyWholeVarGroups(donorXml, baseXml);

    const level = restoreVarValue(donorXml, "levelup");
    const xp = restoreVarValue(donorXml, "experience");
    if (level !== null && xp !== null) {
        baseXml = restoreSetVar(baseXml, "levelup", level);
        baseXml = restoreSetVar(baseXml, "experience", xp);
        const parsedXp = Number.parseInt(xp, 10);
        const n = Number.isFinite(parsedXp) ? parsedXp : 0;
        baseXml = restoreSetVar(baseXml, "sexpx", String((509438470 ^ n) | 0));
    }
    baseXml = restoreCopyNamedDataElems(donorXml, baseXml, ["Common_prevQuestId", "lastContiniouslyCompletedQuest"]);
    // The native app marks donor completed QB tasks as value=4.
    const qb = /<DataElem\s+name="(QB_\d+_\d+)"\s+type="int"\s+value="4"\s*\/?\s*>/gi;
    let match;
    while ((match = qb.exec(donorXml)) !== null) {
        const name = match[1];
        const re = new RegExp(`<DataElem\\s+name=["']${restoreEscapeRegExp(name)}["'][^>]*/?>`, "i");
        const tag = `<DataElem name="${name}" type="int" value="4"/>`;
        if (re.test(baseXml)) baseXml = baseXml.replace(re, tag);
        else baseXml = baseXml.replace(/(<DataElem\s+name="Common_prevQuestId"[^>]*\/>)/i, `${tag}\n    $1`);
    }
    for (const name of ["HarvestForTime", "SeasonTicketCenter"]) baseXml = restoreCopySection(donorXml, baseXml, name);
    const donorTips = new Set(Array.from(donorXml.matchAll(/<v\s+n="(CHT_[^"]+)"/g), m => m[1]));
    for (const id of donorTips) {
        if (!new RegExp(`<v\\s+n="${restoreEscapeRegExp(id)}"`).test(baseXml)) {
            const seen = restoreFindTag(baseXml, "SeenTips");
            if (seen) baseXml = baseXml.slice(0, seen.end - "</SeenTips>".length) + `<v n="${id}"/>\n` + baseXml.slice(seen.end - "</SeenTips>".length);
        }
    }
    const stateNames = Array.from(donorXml.matchAll(/<Var\s+name="([^"]+_state)"[^/]*\/>/gi), m => m[1]);
    baseXml = restoreCopyVarsByName(donorXml, baseXml, stateNames);
    baseXml = restoreCopyNamedDataElems(donorXml, baseXml, ["UnlockedBadges", "UnlockedExpRanks", "UnlockedFrames", "UnlockedStyles"], true);
    for (const name of ["Skins", "BuildingsStash", "FragmentedBeautyManager"]) baseXml = restoreCopySection(donorXml, baseXml, name);
    const unlocked = new Map(Array.from(donorXml.matchAll(/<Var\s+name="(Unlocked_ava\d+)"\s+v="([^"]*)"[^/]*\/>/g), m => [m[1], m[2]]));
    baseXml = restoreCopyVarsByName(donorXml, baseXml, Array.from(unlocked.keys()), "Global");
    return baseXml;
}
function restoreReplaceUser(xml, baseUser) {
    if (!baseUser) return xml;
    return xml.replace(/\buser=(['"])[^'"]*\1/g, `user="${baseUser}"`);
}
function restoreCopyFilteredGlobal(donorXml, baseXml) {
    const global = restoreFindTag(donorXml, "Global");
    if (!global) return baseXml;
    const blocked = new Set(["deviceId", "advId", "cityId", "gameId", "facebookId", "Device", "DeviceLang",
        "PrevFBID", "PrevGCID", "FBIsAuthorized", "MyClanId", "prevMyClanId", "MyClanJoinRegataId",
        "MyClanNotExistLeaderId", "TrackNewDevice_TrackedDevices", "CCSecretApps", "CCSecretB", "CCSecretInstall",
        "CCSecretM", "NotificationAuthStatus", "newNotificationAuthStatus", "ProgressComplainer_SessionId",
        "Action_sessionsForSubsCounter", "EnteredGameAfterInstallDay", "gardenscapesInstallTime",
        "Secret", "DeviceId", "SessionId", "InstallId", "Udid", "UDID"]);
    const socialWords = ["friend", "clan", "regata", "social", "facebook", "fb", "gift", "help", "like", "chat", "mail", "invite", "leaderboard", "rating"];
    const vars = global.text.match(/<Var\b[^>]*\/>/gi) || [];
    const toCopy = [];
    for (const tag of vars) {
        const name = restoreAttr(tag, "name");
        if (!name || blocked.has(name) || restoreAttr(tag, "v") === null) continue;
        const lower = name.toLowerCase();
        const allowed = lower.includes("m3") || name.includes("Boost") || name.startsWith("Achievement_") ||
            name.startsWith("AchReward_") || name.startsWith("BLvl_") || name.startsWith("QB_") ||
            name.includes("Quest") || name.includes("Event") || name.includes("Season") || name.startsWith("CHT_") ||
            name.endsWith("_state") || name.includes("Tutorial") || name.includes("Hint") || name.includes("Seen") ||
            name.includes("Shown") || socialWords.some(word => lower.includes(word));
        if (allowed) toCopy.push(name);
    }
    baseXml = restoreCopyVarsByName(donorXml, baseXml, toCopy, "Global");

    const donorCoupons = restoreFindTag(donorXml, "coupons");
    if (donorCoupons) {
        const couponIds = new Set(["HireDealer", "LoadTrainAirport", "UpgradeFactory", "UpgradeTrain", "UpgradeIsland"]);
        const coupons = donorCoupons.text.match(/<coupon\b[^>]*\/>/gi) || [];
        for (const tag of coupons) {
            const id = restoreAttr(tag, "id");
            if (!couponIds.has(id)) continue;
            const count = Math.max(0, Math.min(10, Number.parseInt(restoreAttr(tag, "count") || "0", 10) || 0));
            const replacement = `<coupon id="${id}" count="${count}"/>`;
            const baseBlock = restoreFindTag(baseXml, "coupons");
            if (!baseBlock) continue;
            const re = new RegExp(`<coupon\\b(?=[^>]*\\bid=["']${restoreEscapeRegExp(id)}["'])[^>]*/>`, "i");
            if (re.test(baseBlock.text)) {
                const updated = baseBlock.text.replace(re, replacement);
                baseXml = baseXml.slice(0, baseBlock.start) + updated + baseXml.slice(baseBlock.end);
            } else {
                const insertion = baseBlock.end - baseBlock.start - "</coupons>".length;
                baseXml = baseXml.slice(0, baseBlock.start + insertion) + replacement + "\n  " + baseXml.slice(baseBlock.start + insertion);
            }
        }
    }
    const whu = restoreVarValue(donorXml, "WareHouseCashUpgrade");
    if (whu !== null) {
        const n = Number.parseInt(whu, 10);
        if (Number.isFinite(n)) {
            baseXml = restoreSetVar(baseXml, "WareHouseCashUpgrade", n);
            baseXml = restoreSetIntVar(baseXml, "WHUdup", (514698188 ^ n) | 0);
        }
    }
    return baseXml;
}
function restoreTransferGlobalInventory(donorXml, baseXml) {
    const donorGlobal = restoreFindTag(donorXml, "Global");
    const baseGlobal = restoreFindTag(baseXml, "Global");
    if (!donorGlobal || !baseGlobal) return baseXml;
    const resources = new Set([
        "wheat",
        "corn",
        "carrot",
        "sugarcane",
        "cotton",
        "strawberry",
        "tomat",
        "pine",
        "potato",
        "cacao",
        "rubberTree",
        "rubber",
        "silk",
        "shelk",
        "pepper",
        "rice",
        "roseSeed",
        "jasmine",
        "coffee",
        "soybean",
        "teabush",
        "mint",
        "peanut",
        "lavender",
        "cork",
        "milk",
        "egg",
        "wool",
        "bacon",
        "honeycomb",
        "mushroom",
        "downFeather",
        "bigFeather",
        "clay",
        "apple",
        "peach",
        "watermelon",
        "plum",
        "grapes",
        "fish",
        "shrimp",
        "lobster",
        "scallop",
        "pearl",
        "seaweed",
        "banana",
        "coconut",
        "pineapple",
        "olive",
        "lemon",
        "aloe",
        "mango1",
        "cowfeed",
        "chickenfeed",
        "sheepfeed",
        "pigfeed",
        "beefeed",
        "mushroomfeed",
        "flour",
        "bread",
        "cookie",
        "bagel",
        "pizza",
        "potatobread",
        "bananabread",
        "mushroomPie",
        "strudel",
        "marinepizza",
        "dough",
        "cream",
        "cheese",
        "butter",
        "yogurt",
        "peachyogurt",
        "sugar",
        "syrup",
        "caramel",
        "candy",
        "caramelapple",
        "jellybeans",
        "toffee",
        "candystick",
        "lollipop",
        "honeycandy",
        "fruitjelly",
        "chocobar",
        "teacandies",
        "mintlollipops",
        "cottonCandy",
        "chocolate",
        "icecream",
        "frozenyogurt",
        "fruitice",
        "eskimo",
        "pineapplesorbet",
        "roseSorbet",
        "parfait",
        "mintchocolateicecream",
        "muffin",
        "brownie",
        "cupcake",
        "doughnut",
        "cheesecake",
        "limepie",
        "coconutmacaroon",
        "honeycake",
        "strawberrycake",
        "weddingcake",
        "coffeecake",
        "chocolatecake",
        "carrotcake",
        "mintcake",
        "tiramisu",
        "chips",
        "popcorn",
        "cornchips",
        "granola",
        "canape",
        "glazedbacon",
        "puffedrice",
        "saltedpeanut",
        "frenchfries",
        "sandwich",
        "cheeseburger",
        "bakedpotatoes",
        "fishburger",
        "fish_chips",
        "peanot_crepes",
        "hot_dog",
        "corndog",
        "cheese_coney",
        "carrot_hotdog",
        "taco",
        "nachos",
        "burrito",
        "jalapeno",
        "falafel",
        "hummus",
        "guacamole",
        "bacon_eggs",
        "pancake",
        "milkshake",
        "grap_fizz",
        "chocolate_smoothie",
        "watermelon_fresh",
        "tropical_mix",
        "cold_tea",
        "minticetea",
        "applefresh",
        "espresso",
        "cappuccino",
        "mokachino",
        "hot_chocolate",
        "blacktea",
        "whitetea",
        "rosetea",
        "tibettea",
        "oolong",
        "appletea",
        "coconut_raf",
        "woolfabric",
        "cottonfabric",
        "silkfabric",
        "nylonthread",
        "shirt",
        "sweater",
        "coat",
        "hat",
        "suit",
        "tiroleanHat",
        "eveningdress",
        "dress",
        "flipflops",
        "sandals",
        "sneakers",
        "boots",
        "heels",
        "downBoots",
        "downJacket",
        "bathrobeslippers",
        "paper",
        "papertowel",
        "wallpapers",
        "book",
        "stickers",
        "marker",
        "eraser",
        "corkboard",
        "table",
        "chair",
        "couch",
        "bed",
        "floor_lamp",
        "pillow",
        "duvet",
        "tissue",
        "dispenser",
        "lounge",
        "sushi",
        "lobster_nigiri",
        "scallopsushi",
        "soup",
        "misosoup",
        "corn_soup",
        "mushroomSoup",
        "gazpacho",
        "bouillabaisse",
        "seaweadsalad",
        "seaweedsalad",
        "mushroomSalad",
        "seafood_salad",
        "nicoise",
        "rice_noodle",
        "thai_sauce",
        "sauce",
        "quiche",
        "fried_fish",
        "rice_casserole",
        "baked_lobster",
        "lobster_newburg",
        "scallopskew",
        "grilledMeat",
        "ratatouille",
        "profiteroles",
        "gyoza",
        "readylunch",
        "frozenvegetables",
        "seafoodcocktail",
        "oliveoil",
        "bruschetta",
        "arrabbiata",
        "ravioli",
        "lasagna",
        "mole",
        "vegancheesecake",
        "jam",
        "strawberry_jam",
        "peach_jam",
        "watermelon_jam",
        "plum_jam"
    ]);
    const rawItems = new Set([
        "TNT",
        "pick",
        "axe",
        "drill",
        "jackhammer",
        "powersaw",
        "gem1",
        "gem2",
        "gem3",
        "sgc1x",
        "sgc2x",
        "sgc3x",
        "o1",
        "o2",
        "o3",
        "o4",
        "o5",
        "m1",
        "m2",
        "m3",
        "sm1x",
        "sm2x",
        "sm3x",
        "BronzeBullionCounter",
        "SilverBullionCounter",
        "GoldBullionCounter",
        "PlatinumBullionCounter",
        "sbbcx",
        "ssbcx",
        "sgbcx",
        "spbcx"
    ]);
    const directCounters = new Set([
        "paintRedMat",
        "pick",
        "Plita",
        "hammerMat",
        "nailMat",
        "Glass",
        "jackhammer",
        "Brick",
        "powersaw",
        "drill",
        "TNT",
        "axe"
    ]);
    const bullion = new Set(["BronzeBullion", "SilverBullion", "GoldBullion", "PlatinumBullion"]);
    const wanted = new Set(rawItems);
    for (const id of resources) {
        if (bullion.has(id)) continue;
        wanted.add(directCounters.has(id) ? id : id + "Counter");
    }
    const donorVars = new Map();
    for (const tag of donorGlobal.text.match(/<Var\b[^>]*\/>/gi) || []) {
        const name = restoreAttr(tag, "name");
        if (name && !donorVars.has(name)) donorVars.set(name, tag);
    }
    const transfer = new Map();
    for (const id of resources) {
        if (bullion.has(id)) continue;
        const name = directCounters.has(id) ? id : id + "Counter";
        const tag = donorVars.get(name);
        if (!tag) continue;
        const n = Number.parseInt(restoreAttr(tag, "v"), 10);
        if (Number.isFinite(n) && n >= 1) transfer.set(name, `<Var name="${name}" v="${n}" t="i"/>`);
    }
    for (const name of rawItems) {
        const tag = donorVars.get(name);
        if (!tag || !/^-?\d+$/.test(restoreAttr(tag, "v") || "")) continue;
        transfer.set(name, tag);
    }
    if (!transfer.size) return baseXml;
    const present = new Set();
    let globalText = baseGlobal.text.replace(/<Var\b[^>]*\/>/gi, tag => {
        const name = restoreAttr(tag, "name");
        if (!name || !transfer.has(name)) return tag;
        present.add(name);
        return transfer.get(name);
    });
    const missing = [];
    for (const [name, tag] of transfer) if (!present.has(name)) missing.push(tag);
    if (missing.length) {
        const closeAt = globalText.lastIndexOf("</Global>");
        if (closeAt >= 0) globalText = globalText.slice(0, closeAt) + missing.join("\n  ") + "\n  " + globalText.slice(closeAt);
    }
    return baseXml.slice(0, baseGlobal.start) + globalText + baseXml.slice(baseGlobal.end);
}
function restoreCopyArtInfo(donorXml, baseXml) {
    const donor = restoreFindTag(donorXml, "ArtInfo");
    if (!donor) return baseXml;
    const base = restoreFindTag(baseXml, "ArtInfo");
    if (base) return baseXml.slice(0, base.start) + donor.text + baseXml.slice(base.end);
    const laboratoryEnd = /<Laboratory\b[^>]*\/>|<\/Laboratory\s*>/i.exec(baseXml);
    if (laboratoryEnd) {
        const end = laboratoryEnd.index + laboratoryEnd[0].length;
        return baseXml.slice(0, end) + "\n  " + donor.text + baseXml.slice(end);
    }
    const stash = /<BuildingsStash\b/i.exec(baseXml);
    if (stash) return baseXml.slice(0, stash.index) + donor.text + "\n  " + baseXml.slice(stash.index);
    const rootClose = /<\/root\s*>/i.exec(baseXml);
    return rootClose ? baseXml.slice(0, rootClose.index) + donor.text + "\n" + baseXml.slice(rootClose.index) : baseXml;
}
function restoreActiveSeasonTicket(xml) {
    const starts = /<SeasonTicket\b[^>]*>/gi;
    let match;
    while ((match = starts.exec(xml)) !== null) {
        if (xml.slice(Math.max(0, match.index - 4), match.index).endsWith("Prev")) continue;
        const block = restoreFindTag(xml, "SeasonTicket", match.index);
        if (block) return block;
    }
    return null;
}
function restoreCopySeasonTicketBoosts(donorXml, baseXml) {
    const donor = restoreActiveSeasonTicket(donorXml);
    const base = restoreActiveSeasonTicket(baseXml);
    if (!donor || !base) return baseXml;
    const names = ["SP_BoostSpeedUpBuildings", "SP_BoostSpeedUpHarvest", "SP_BoostSpeedUpFarms",
        "SP_BoostStorageCapacity", "SP_BoostSpeedUpAir", "SP_BoostSpeedUpTrains", "SP_BoostTrainMats"];
    let ticket = base.text;
    for (const name of names) {
        const donorTag = restoreVarTag(donor.text, name);
        if (!donorTag) continue;
        const escaped = restoreEscapeRegExp(name);
        const varRe = new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escaped}["'])[^>]*(?:\\/>|>[\\s\\S]*?<\\/Var\\s*>)`, "i");
        if (varRe.test(ticket)) ticket = ticket.replace(varRe, () => donorTag);
        else if (/<Vars\s*\/>/i.test(ticket)) ticket = ticket.replace(/<Vars\s*\/>/i, `<Vars>\n        ${donorTag}\n      </Vars>`);
        else if (/<\/Vars\s*>/i.test(ticket)) ticket = ticket.replace(/<\/Vars\s*>/i, `        ${donorTag}\n      </Vars>`);
        else ticket = ticket.replace(/<\/SeasonTicket\s*>/i, `  <Vars>\n        ${donorTag}\n      </Vars>\n    </SeasonTicket>`);
    }
    return baseXml.slice(0, base.start) + ticket + baseXml.slice(base.end);
}
const RESTORE_ACHIEVEMENT_DEFAULTS = ["marketBoom", "miner", "earthCenter", "strategyReserv", "factoryUpgrader", "collector", "teamwork", "casinoGame", "sendShips", "islandGoods", "collectBacon", "collectHoney", "collectorIslands", "progressWave", "downFeather", "metropolis", "community_developer", "entrepreneur", "lead_Architect", "population_boom", "construction_manager", "endless_fields", "magnate", "wacky_farmer", "urbanist_club", "honorary_freeman", "senior_train_driver", "road_champ", "production_genius", "customer_service_pro", "model_chicken_coop", "milky_way", "mushroom", "wool_art", "seaweed", "donate", "regataChampion", "match3_achievement"];
const RESTORE_ACHIEVEMENT_THRESHOLDS = {"marketBoom": {"Achievement_MarketBoom": 16000}, "miner": {"Achievement_Miner": 14000}, "earthCenter": {"Achievement_EarthCenter": 17000}, "strategyReserv": {"Achievement_StrategyReserv": 3500}, "factoryUpgrader": {"Achievement_FactoryUpgrader": 42}, "collector": {"Achievement_Collector": 25}, "teamwork": {"Achievement_Teamwork": 20000}, "casinoGame": {"Achievement_CasinoGame": 4000}, "sendShips": {"Achievement_sendShips": 18000}, "islandGoods": {"Achievement_islandGoods": 110000}, "collectBacon": {"Achievement_CollectBacon": 15500}, "collectHoney": {"Achievement_CollectHoney": 14500}, "collectorIslands": {"Achievement_CollectorIslands": 30}, "progressWave": {"Achievement_progressWave": 165}, "downFeather": {"Achievement_DownFeather": 14000}, "metropolis": {"Achievement_IncreasedPopulation": 29000, "Achievement_IncreasedPopulation_Current": 12000}, "community_developer": {"Achievement_CommunityDeveloper": 70, "Achievement_CommunityDeveloper_Current": 70}, "entrepreneur": {"Achievement_FillOrders": 7100}, "lead_Architect": {"Achievement_BuiltHouses": 130, "Achievement_BuiltHouses_Current": 26}, "population_boom": {"Achievement_IncreasedPopulation": 29000, "Achievement_IncreasedPopulation_Current": 12000}, "construction_manager": {"Achievement_BuiltFactories": 45, "Achievement_BuiltFactories_Current": 45}, "endless_fields": {"Achievement_PlowedFields": 740000}, "magnate": {"Achievement_EarneCoins": 700000000}, "wacky_farmer": {"Achievement_GetFields": 132}, "urbanist_club": {"Achievement_ExpandField": 390}, "honorary_freeman": {"Achievement_EnteredGame": 235, "Achievement_EnteredGame_Current": 15}, "senior_train_driver": {"Achievement_SentTrain": 2300}, "road_champ": {"Achievement_BuiltRoad": 440, "Achievement_BuiltRoad_Current": 440}, "production_genius": {"Achievement_ProducedProducts": 400000}, "customer_service_pro": {"Achievement_FillOrders": 7100}, "model_chicken_coop": {"Achievement_CollectEggs": 60000}, "milky_way": {"Achievement_CollectMilk": 108000}, "mushroom": {"Achievement_CollectMushroom": 14600}, "wool_art": {"Achievement_CollectWool": 21200}, "seaweed": {"Achievement_seaweed": 20000}, "donate": {"Achievement_donate": 12500}, "regataChampion": {"Achievement_regataChampion": 1}, "match3_achievement": {"Achievement_CompleteMatch3Levels": 56000}};
function restoreApplyAchievementRules(xml) {
    const rewards = new Set(RESTORE_ACHIEVEMENT_DEFAULTS);
    for (const match of xml.matchAll(/AchReward_([A-Za-z0-9_]+)/g)) rewards.add(match[1]);
    const updates = new Map();
    for (const key of rewards) {
        updates.set("AchReward_" + key, 4);
        const thresholds = RESTORE_ACHIEVEMENT_THRESHOLDS[key] || {};
        for (const [name, limit] of Object.entries(thresholds)) {
            const current = Number.parseInt(restoreVarValue(xml, name) || "0", 10) || 0;
            updates.set(name, Math.max(current, limit));
        }
    }
    const global = restoreFindTag(xml, "Global");
    if (!global) return xml;
    const present = new Set();
    let text = global.text.replace(/<Var\b[^>]*\/>/gi, tag => {
        const name = restoreAttr(tag, "name");
        if (!name || !updates.has(name)) return tag;
        present.add(name);
        return `<Var name="${name}" v="${updates.get(name)}" t="i"/>`;
    });
    const missing = [];
    for (const [name, value] of updates) if (!present.has(name)) missing.push(`<Var name="${name}" v="${value}" t="i"/>`);
    if (missing.length) {
        const closeAt = text.lastIndexOf("</Global>");
        if (closeAt >= 0) text = text.slice(0, closeAt) + missing.join("\n  ") + "\n  " + text.slice(closeAt);
    }
    return xml.slice(0, global.start) + text + xml.slice(global.end);
}
function restoreMergeDeferredCoupons(donorXml, baseXml) {
    const donorGlobal = restoreFindTag(donorXml, "Global");
    const accepted = ["HireDealer", "LoadTrainAirport", "UpgradeFactory", "UpgradeTrain", "UpgradeIsland"];
    const mapped = new Map();
    const coupons = donorGlobal && restoreFindTag(donorGlobal.text, "coupons");
    if (coupons) {
        for (const tag of coupons.text.match(/<coupon\b[^>]*\/>/gi) || []) {
            const id = restoreAttr(tag, "id");
            if (!accepted.includes(id)) continue;
            const n = Number.parseInt(restoreAttr(tag, "count"), 10);
            if (Number.isFinite(n) && n > 0) mapped.set("Coupon" + id, Math.min(n, 10));
        }
    }
    if (!mapped.size) for (const id of accepted) mapped.set("Coupon" + id, 3);
    const current = restoreVarValue(baseXml, "GivingOffersDeferred") || "";
    const combined = new Map();
    for (const item of current.split(",")) {
        const match = /^\s*([^:]+)\s*:\s*(-?\d+)\s*$/.exec(item);
        if (match) combined.set(match[1], Number.parseInt(match[2], 10));
    }
    for (const [name, count] of mapped) combined.set(name, count);
    const value = Array.from(combined, ([name, count]) => `${name}:${count}`).join(",");
    return restoreSetVar(baseXml, "GivingOffersDeferred", value);
}
function restorePhaseTwo(baseXml, donorXml) {
    const baseUser = (baseXml.match(/<Object\b[^>]*\buser="([^"]+)"/i) || [])[1];
    const donorUser = (donorXml.match(/<Object\b[^>]*\buser="([^"]+)"/i) || [])[1];
    // App transfers donor TownGround/Buildings to the target save, rewriting user IDs.
    let groundDonor = restoreFindTag(donorXml, "TownGround", (donorXml.indexOf("</Zoo>") + 6) || 0);
    let buildingsDonor = groundDonor ? restoreFindTag(donorXml, "Buildings", groundDonor.start) : null;
    if (groundDonor) {
        let ground = restoreReplaceUser(groundDonor.text, baseUser);
        const startFrom = (baseXml.indexOf("</Zoo>") + 6) || 0;
        const groundBase = restoreFindTag(baseXml, "TownGround", startFrom);
        if (groundBase) baseXml = baseXml.slice(0, groundBase.start) + ground + baseXml.slice(groundBase.end);
        if (buildingsDonor) {
            const building = restoreReplaceUser(buildingsDonor.text, baseUser);
            const currentGround = restoreFindTag(baseXml, "TownGround", startFrom);
            const bBase = restoreFindTag(baseXml, "Buildings", currentGround ? currentGround.start : startFrom);
            if (bBase) baseXml = baseXml.slice(0, bBase.start) + building + baseXml.slice(bBase.end);
        }
    }
    if (donorUser && baseUser && donorUser !== baseUser) {
        // Ensure copied top-level user-bound objects point to target account.
        for (const tag of ["TownGround", "Buildings"]) {
            const block = restoreFindTag(baseXml, tag, (baseXml.indexOf("</Zoo>") + 6) || 0);
            if (block) baseXml = baseXml.slice(0, block.start) + restoreReplaceUser(block.text, baseUser) + baseXml.slice(block.end);
        }
    }
    baseXml = restoreApplyAchievementRules(baseXml);
    baseXml = restoreCopyFilteredGlobal(donorXml, baseXml);
    baseXml = restoreTransferGlobalInventory(donorXml, baseXml);
    for (const tag of ["Zoo", "ZooInfo", "ZooQuests"]) baseXml = restoreCopySection(donorXml, baseXml, tag);
    baseXml = restoreCopyArtInfo(donorXml, baseXml);
    for (const tag of ["Trains", "IslandsInfo", "Minigames", "DataStoreCollapseQuests", "QuestsBook", "DataStoreCollection",
        "AirInfo", "AirOrders", "MapOrders", "Helic", "LevelInfo", "DailyBonusRewardDay6", "VipDailyBonusRewardDay6", "Upgrade",
        "TimedEntityManager"]) baseXml = restoreCopySection(donorXml, baseXml, tag);
    if (restoreFindTag(donorXml, "Minigames") && restoreFindTag(baseXml, "Minigames")) {
        for (const tag of ["Mail", "ClanMail", "ReceivedGivings", "Balloons", "Ernie", "MagicBeansCenter"]) {
            baseXml = restoreCopySection(donorXml, baseXml, tag);
        }
    }
    baseXml = restoreCopySeasonTicketBoosts(donorXml, baseXml);
    for (const name of ["MyBadge", "MyPicture", "MyTheme", "MyFrame", "MyStyle", "townName",
        "m3Line", "m3Bomb", "m3RainbowBall", "m3Mallet", "m3HorizontalLine", "m3VerticalLine", "m3Reshuffle"]) {
        const value = restoreVarValue(donorXml, name);
        if (value !== null) baseXml = restoreSetVar(baseXml, name, value);
    }
    if (restoreFindTag(donorXml, "Minigames") && restoreFindTag(baseXml, "Minigames")) {
        baseXml = restoreMergeDeferredCoupons(donorXml, baseXml);
    }
    return baseXml;
}
function mergeRestoreXml(baseXml, donorXml) {
    if (typeof baseXml !== "string" || typeof donorXml !== "string" || !baseXml.trim().startsWith("<") || !donorXml.trim().startsWith("<")) {
        throw new Error("يجب إرسال ملفي XML صالحين: serverXml وملف الصديق المفكوك");
    }
    let result = restorePhaseOne(baseXml.trim(), donorXml.trim());
    result = restorePhaseTwo(result, donorXml.trim());
    if (!result.includes("</root>")) throw new Error("XML الناتج غير مكتمل");
    return result;
}
function decodeRestoreLocalFile(input) {
    const raw = Buffer.isBuffer(input) ? input : Buffer.from(input || "");
    if (!raw.length) throw new Error("ملف الحساب المحلي فارغ");
    const decoders = [decodeFriendFile, decodeSaveCity];
    const failures = [];
    for (const decode of decoders) {
        try {
            const decoded = looksLikeXml(raw) ? raw : decode(raw);
            const xml = trimXml(decoded).toString("utf8").replace(/^\uFEFF/, "").trim();
            if (/<root(?:\s|>)/i.test(xml) && xml.includes("</root>")) return xml;
            failures.push("الناتج لم يبدأ بعنصر root");
        } catch (error) {
            failures.push(String(error && error.message ? error.message : error));
        }
    }
    throw new Error(`تعذر فك ملف الحساب المحلي بصيغة LocalInfo/FetchCity: ${failures.join(" | ")}`);
}
function mergeRestorePhase(baseXml, donorXml, phase) {
    if (typeof baseXml !== "string" || typeof donorXml !== "string" ||
        !baseXml.trim().startsWith("<") || !donorXml.trim().startsWith("<")) {
        throw new Error("يجب إرسال ملفي XML صالحين");
    }
    const normalizedPhase = Number(phase || 1);
    let result = baseXml.trim();
    if (normalizedPhase === 1) result = restorePhaseOne(result, donorXml.trim());
    else if (normalizedPhase === 2) result = restorePhaseTwo(result, donorXml.trim());
    else throw new Error("phase يجب أن يكون 1 أو 2");
    if (!result.includes("</root>")) throw new Error("XML الناتج غير مكتمل");
    return result;
}

async function handleRestoreAccount(req, res) {
    try {
        const rawBody = Buffer.isBuffer(req.body) ? req.body : null;
        const body = rawBody ? {} : (req.body || {});
        const cityId = String(body.cityId || body.fetchCityId || (req.query && req.query.cityId) || "").trim();
        const cityVer = Number(body.cityVer || body.cver || (req.query && req.query.cityVer) || 0);
        const phase = Number(body.phase || (req.query && req.query.phase) || 1);
        let serverXml = body.serverXml || body.baseXml || "";
        if (rawBody) serverXml = decodeRestoreLocalFile(rawBody);
        else if (body.serverXmlBase64) serverXml = decodeRestoreLocalFile(Buffer.from(String(body.serverXmlBase64), "base64"));
        if (!cityId) return res.status(400).json({ ok: false, error: "cityId مطلوب" });
        if (!serverXml) return res.status(400).json({ ok: false, error: "serverXml مطلوب: XML الحساب الحالي" });
        if (!Number.isFinite(cityVer) || cityVer < 0) return res.status(400).json({ ok: false, error: "cityVer غير صالح" });
        const upstream = await requestFetchCity(cityId, cityVer);
        if (!upstream || !upstream.result || typeof upstream.result.data !== "string") throw new Error("Upstream JSON لا يحتوي result.data");
        const decodedDonor = decodeSaveCity(Buffer.from(upstream.result.data, "base64"));
        const donorXml = (Buffer.isBuffer(decodedDonor) ? decodedDonor.toString("utf8") : String(decodedDonor)).replace(/^\uFEFF/, "").trim();
        const merged = mergeRestorePhase(String(serverXml), donorXml, phase);
        console.log(`[Restore] phase=${phase} cityId=${cityId} base=${String(serverXml).length} donor=${donorXml.length} result=${merged.length}`);
        res.status(200).set("Content-Type", "application/xml; charset=utf-8").set("Cache-Control", "no-store");
        return res.send(merged);
    } catch (err) {
        console.error("[Restore] ERROR:", err && err.stack ? err.stack : err);
        return res.status(500).json({ ok: false, error: String(err && err.message ? err.message : err) });
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

router.post(
    "/restore-account",
    express.raw({
        type: "application/octet-stream",
        limit: "50mb"
    }),
    handleRestoreAccount
);

console.log(
    "[FetchCity] module loaded"
);

module.exports = router;
