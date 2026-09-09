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
    "d192KFBTVDZLSDBPSkIwNHh4PlJDMyFrUngqfCsyNV5PU2guWCcmTj5gbTlLZklXb3xTMmpoYmMgZlRkN2FTWjZSQmdRYkwpZlcxMWI8J0dXJ00pTiNsbF5xWntdOmJhakBudjlLZUXlgKDgnJkUyeSo8biZSak9lb2lPRTNbP0lMTys/ZFNAdXxddlZJSGdpdnR3I19ybG9nTD9yY2xKa0EyVjZkSF9hdiB1OWZ3JFZnaiVBdEJHK2RSRSg6bih0SSdiNDc/c3phSU5rbTh7PDdqTCN0O1NKO0knX3ZyVkNveiFvcGg0cC9kdW1UKDZ4ezNRfiZtbWEpJS9+QlJjbm9qeVRmVC55cW4mc2s5ajtheTNwZyssY2NKRz1URXUySy0qZCVJVSpZMk4pLn17VVBfTip4P1pdX2wsXXZ+J21ydkIpdUcuc3cyUCVRK3xOUUxgPklmeUx3ZF0sST9mK2lnOm84cyNMUk15KCQwWTJWelhCRVZ+UXVCZ1J+eVplb2gtY0NAcUA+Ni1WdlQyLFpTV2xVfnRoKyUwfFdfaVBsfU0wdW4/cHlkcXVsYHxaTGB1N3JtMUwwZXd6NGM5KmZuUlpGOjgoOyYlNltHbj4sTFhXOUY/UVE0MSg6NXN2ckdWI3snMyldMi82bG5bc1lkczpxVGRCaDhPeUI8I1EhVSVRJ1tkK3IlKU9CT3V5XSE9fWFnMEdQNlp+YCs5PnJGJmBfOF59Tn5YMDJEKUgjfWFPKTA4dHF4OixPJmZOcHtSJFc+KU1CZUxpfFJYOi56JzVCJWddMTNFZiB5JUs/e1JBcGdrey4xKSxBT1toVXlJLm98cUBwXiBNczFJNyBadWI6YSdPNFknXzA7WG1afnZLPW5KI3dZQ2Njbl5Dekp1NDxmNW9neV19I0s1RklsS25ud1RfXmRWQVpndl1EIFdJdEBzbCFpPSlxeG5XaA==",
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
            `LZ4: ط·آ§ط¸â€‍ط·آ­ط·آ¬ط¸â€¦ ط·آ§ط¸â€‍ط¸â€ ط·آ§ط·ع¾ط·آ¬ط·ط›ط¸ظ¹ط·آ± ط¸â€¦ط·آ·ط·آ§ط·آ¨ط¸â€ڑ. expected=${expectedSize}, actual=${dstPos}`
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
            `ط·ع¾ط¸â€¦ ط¸ظ¾ط¸ئ’ ط·آ·ط·آ¨ط¸â€ڑط·آ§ط·ع¾ FetchCity ط¸â€‍ط¸ئ’ط¸â€  ط·آ§ط¸â€‍ط¸â€¦ط·آ±ط·آ­ط¸â€‍ط·آ© ط·آ§ط¸â€‍ط·ع¾ط·آ§ط¸â€‍ط¸ظ¹ط·آ© ط·ط›ط¸ظ¹ط·آ±ط¸â€¦ط·آ¹ط·آ±ط¸ث†ط¸ظ¾ط·آ©. Magic=${bufferMagic(data)}`
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
            "LZ4: ط·آ§ط¸â€‍ط·آ­ط·آ¬ط¸â€¦ ط·آ§ط¸â€‍ط¸â€ ط·آ§ط·ع¾ط·آ¬ط·ط›ط¸ظ¹ط·آ± ط·آµط·آ­ط¸ظ¹ط·آ­\n" +
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

    // ط¸ظ¹ط·آ¬ط·آ¨ ط·آ£ط¸ث† ط¸ظ¹ط·آ¨ط·آ¯ط·آ£ ط·آ¨ط¸â‚¬ 0x79
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

        // ط·آ§ط¸â€‍ط¸â€¦ط·آ·ط·آ§ط·آ¨ط¸â€ڑط¸â€° ط·آ§ط¸â€‍ط·آ£ط·آ³ط·آ§ط·آ³ط¸ظ¹ط·آ©: city_name
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
// ============================================================
// COPY FARM ENGINE - NEW
// ============================================================
// ============================================================

// هذه الأقسام تبقى من الحفظ الرئيسي ولا يتم استبدالها
// حتى لا يتم نقل بيانات الجهاز/الحساب/المشتريات/الجلسات
// الخاصة بالمزرعة الأخرى.

const COPY_FARM_KEEP_MAIN = new Set([

    "Devices",
    "DeviceCompatibility",
    "FriendsReferralSystem",
    "ACService",
    "Sessions",
    "ChatLivesInbox",

    "FriendIds",
    "FollowedFriendIds",
    "FollowerIds",
    "NewFollowerIds",
    "InvitedFriends",
    "LastHelperIds",

    "SentGifts",
    "ReceivedGifts",
    "ReceivedBoxes",
    "OfflineBoxes",
    "ComingLetters",

    "ClanMail",
    "MyClan",

    "incompleteIAP",
    "incompletePurchases",
    "consumedPurchases",
    "AlternativePaymentsTransactions",
    "PurchaseAttempts",

    "BankManager",
    "coupons",

    "Local",
    "GameInfoPatcher",

    "OtherPlayerProfilesLogicFeatureComponent",
    "PushNotifDeviceInfo",

    "IdfaAction",
    "AgeRestrictionsManager"
]);

// ============================================================
// COPY FARM XML TOP LEVEL PARSER
// ============================================================

function copyFarmGetTagName(
    token
) {

    const match =
        token.match(
            /^<\s*([A-Za-z_][A-Za-z0-9_.:-]*)/
        );

    return match
        ? match[1]
        : "";
}

function copyFarmIsClosingTag(
    token
) {

    return /^<\s*\//.test(
        token
    );
}

function copyFarmIsOpeningTag(
    token
) {

    return (
        /^<\s*[A-Za-z_][A-Za-z0-9_.:-]*/.test(
            token
        ) &&
        !/^<\s*\//.test(token) &&
        !/^<\s*!/.test(token) &&
        !/^<\s*\?/.test(token)
    );
}

function copyFarmIsSelfClosingTag(
    token
) {

    return /\/\s*>$/.test(
        token
    );
}

function copyFarmFindTopLevelSections(
    xml
) {

    const sections = [];

    const rootMatch =
        xml.match(
            /<root\b[^>]*>/i
        );

    if (!rootMatch) {

        throw new Error(
            "COPY FARM: root XML غير موجود"
        );
    }

    const rootStart =
        rootMatch.index;

    const rootEnd =
        xml.lastIndexOf(
            "</root>"
        );

    if (
        rootEnd === -1 ||
        rootEnd <= rootStart
    ) {

        throw new Error(
            "COPY FARM: </root> غير موجود"
        );
    }

    const bodyStart =
        rootStart +
        rootMatch[0].length;

    const body =
        xml.slice(
            bodyStart,
            rootEnd
        );

    const tokenRegex =
        /<[^>]+>/g;

    const stack = [];

    let match;

    while (
        (match =
            tokenRegex.exec(body)) !== null
    ) {

        const token =
            match[0];

        const tokenStart =
            match.index;

        const absoluteStart =
            bodyStart +
            tokenStart;

        if (
            /^<\s*(\?|!)/.test(
                token
            )
        ) {

            continue;
        }

        if (
            copyFarmIsClosingTag(
                token
            )
        ) {

            const closingName =
                copyFarmGetTagName(
                    token
                );

            const open =
                stack.pop();

            if (
                open &&
                open.name ===
                    closingName
            ) {

                if (
                    open.depth === 1
                ) {

                    sections.push({

                        name:
                            open.name,

                        start:
                            open.start,

                        end:
                            absoluteStart +
                            token.length,

                        xml:
                            xml.slice(
                                open.start,
                                absoluteStart +
                                token.length
                            )
                    });
                }
            }

            continue;
        }

        if (
            copyFarmIsOpeningTag(
                token
            )
        ) {

            const name =
                copyFarmGetTagName(
                    token
                );

            if (
                !name
            ) {

                continue;
            }

            if (
                copyFarmIsSelfClosingTag(
                    token
                )
            ) {

                if (
                    stack.length === 0
                ) {

                    sections.push({

                        name:
                            name,

                        start:
                            absoluteStart,

                        end:
                            absoluteStart +
                            token.length,

                        xml:
                            token
                    });
                }

                continue;
            }

            stack.push({

                name:
                    name,

                start:
                    absoluteStart,

                depth:
                    stack.length + 1
            });
        }
    }

    return sections;
}

// ============================================================
// FIND TOP LEVEL SECTION
// ============================================================

function copyFarmFindSection(
    xml,
    sectionName
) {

    const sections =
        copyFarmFindTopLevelSections(
            xml
        );

    for (
        const section of sections
    ) {

        if (
            section.name ===
            sectionName
        ) {

            return section;
        }
    }

    return null;
}

// ============================================================
// REPLACE TOP LEVEL SECTION
// ============================================================

function copyFarmReplaceSection(
    xml,
    sectionName,
    replacement
) {

    const existing =
        copyFarmFindSection(
            xml,
            sectionName
        );

    if (
        existing
    ) {

        return (
            xml.slice(
                0,
                existing.start
            ) +
            replacement +
            xml.slice(
                existing.end
            )
        );
    }

    const rootEnd =
        xml.lastIndexOf(
            "</root>"
        );

    if (
        rootEnd === -1
    ) {

        throw new Error(
            "COPY FARM: root end غير موجود أثناء الإضافة"
        );
    }

    return (
        xml.slice(
            0,
            rootEnd
        ) +
        "\n" +
        replacement +
        "\n" +
        xml.slice(
            rootEnd
        )
    );
}

// ============================================================
// COPY TOP LEVEL SECTIONS
// ============================================================

function copyFarmReplaceTopLevelSections(
    mainXml,
    friendXml
) {

    let result =
        mainXml;

    const friendSections =
        copyFarmFindTopLevelSections(
            friendXml
        );

    let copied = 0;
    let skipped = 0;

    for (
        const section of friendSections
    ) {

        const name =
            section.name;

        if (
            COPY_FARM_KEEP_MAIN.has(
                name
            )
        ) {

            skipped++;

            console.log(
                `[CopyFarm] KEEP MAIN: ${name}`
            );

            continue;
        }

        if (
            !section.xml ||
            section.xml.length === 0
        ) {

            continue;
        }

        result =
            copyFarmReplaceSection(
                result,
                name,
                section.xml
            );

        copied++;

        console.log(
            `[CopyFarm] COPIED: ${name}`
        );
    }

    console.log(
        `[CopyFarm] top-level copied=${copied} skipped=${skipped}`
    );

    return result;
}

// ============================================================
// DECODE SAVE WITH LAYERS
// ============================================================

function decodeSaveWithLayers(
    input
) {

    let data =
        Buffer.from(
            input
        );

    const layers = [];

    let rounds = 0;

    while (
        data.length > 0 &&
        rounds < 12
    ) {

        rounds++;

        if (
            looksLikeXml(
                data
            )
        ) {

            return {

                xml:
                    trimXml(
                        data
                    ),

                layers:
                    layers
            };
        }

        if (
            isGzip(
                data
            )
        ) {

            layers.push({

                type:
                    "gzip"
            });

            data =
                zlib.gunzipSync(
                    data
                );

            continue;
        }

        if (
            isLz4Magic(
                data
            )
        ) {

            layers.push({

                type:
                    "lz4"
            });

            data =
                decodeLz4Container(
                    data
                );

            continue;
        }

        if (
            data[0] === 0x79
        ) {

            if (
                data.length < 8
            ) {

                throw new Error(
                    "COPY FARM: 0x79 layer قصيرة"
                );
            }

            const headerValue =
                u32le(
                    data,
                    1
                );

            const total =
                data.length >>> 0;

            const derived =
                xor32(
                    TOTAL_XOR,
                    total
                );

            const processLenU32 =
                xor32(
                    sub32(
                        headerValue,
                        derived
                    ),
                    PROCESS_XOR
                );

            const processLen =
                Math.min(
                    Math.max(
                        0,
                        total - 8
                    ),
                    processLenU32 >>> 0
                );

            const rawSeed =
                u32le(
                    data,
                    4
                );

            layers.push({

                type:
                    "79",

                rawSeed:
                    rawSeed,

                processLen:
                    processLen
            });

            data =
                xorDecode79(
                    data
                );

            continue;
        }

        if (
            data[0] === 0x54
        ) {

            if (
                data.length < 3
            ) {

                throw new Error(
                    "COPY FARM: 0x54 layer قصيرة"
                );
            }

            const processLen =
                (
                    (
                        (
                            data[1] ^
                            FETCH54_TABLE[0]
                        ) & 0xff
                    ) |
                    (
                        data[2] << 8
                    )
                ) >>> 0;

            layers.push({

                type:
                    "54",

                processLen:
                    Math.min(
                        processLen,
                        data.length - 3
                    )
            });

            data =
                decode54Layer(
                    data
                );

            continue;
        }

        if (
            data[0] === 0x1F
        ) {

            layers.push({

                type:
                    "raw-1f",

                data:
                    Buffer.from(
                        data
                    )
            });

            break;
        }

        throw new Error(
            `COPY FARM: layer غير معروف. magic=${bufferMagic(data)}`
        );
    }

    if (
        looksLikeXml(
            data
        )
    ) {

        return {

            xml:
                trimXml(
                    data
                ),

            layers:
                layers
        };
    }

    throw new Error(
        `COPY FARM: لم يتم الوصول إلى XML. magic=${bufferMagic(data)}`
    );
}

// ============================================================
// ENCODE 0x79
// ============================================================

function encode79Layer(
    decoded,
    rawSeed,
    processLen
) {

    if (
        !Buffer.isBuffer(
            decoded
        )
    ) {

        decoded =
            Buffer.from(
                decoded
            );
    }

    const actualLen =
        Math.min(
            processLen == null
                ? decoded.length
                : processLen,
            decoded.length
        );

    const table =
        build79Table(
            add32(
                rawSeed,
                4
            )
        );

    const encodedPayload =
        Buffer.from(
            decoded
                .subarray(
                    0,
                    actualLen
                )
        );

    if (
        encodedPayload.length > 0
    ) {

        encodedPayload[0] =
            (
                encodedPayload[0] ^
                table[0]
            ) & 0xff;

        for (
            let i = 1;
            i < decoded.length &&
            i < actualLen;
            i++
        ) {

            encodedPayload[i] =
                (
                    (
                        decoded[i] ^
                        table[
                            i %
                            TABLE_SIZE
                        ]
                    ) +
                    decoded[i - 1]
                ) & 0xff;
        }
    }

    const total =
        actualLen +
        8;

    const derived =
        xor32(
            TOTAL_XOR,
            total
        );

    const encodedProcess =
        xor32(
            actualLen,
            PROCESS_XOR
        );

    const headerValue =
        add32(
            encodedProcess,
            derived
        );

    const out =
        Buffer.alloc(
            total
        );

    out[0] =
        0x79;

    out.writeUInt32LE(
        headerValue >>> 0,
        1
    );

    out.writeUInt32LE(
        rawSeed >>> 0,
        4
    );

    encodedPayload.copy(
        out,
        8
    );

    return out;
}

// ============================================================
// ENCODE 0x54
// ============================================================

function encode54Layer(
    decoded,
    processLen
) {

    if (
        !Buffer.isBuffer(
            decoded
        )
    ) {

        decoded =
            Buffer.from(
                decoded
            );
    }

    const count =
        Math.min(
            processLen == null
                ? decoded.length
                : processLen,
            decoded.length
        );

    const out =
        Buffer.alloc(
            decoded.length +
            3
        );

    out[0] =
        0x54;

    out[1] =
        (
            (count & 0xff) ^
            FETCH54_TABLE[0]
        ) & 0xff;

    out[2] =
        (
            count >>> 8
        ) & 0xff;

    if (
        count > 0
    ) {

        out[3] =
            (
                decoded[0] +
                0x54
            ) & 0xff;

        for (
            let i = 1;
            i < count;
            i++
        ) {

            out[
                3 + i
            ] =
                (
                    (
                        decoded[i] ^
                        FETCH54_TABLE[
                            i %
                            FETCH54_TABLE.length
                        ]
                    ) +
                    decoded[i - 1]
                ) & 0xff;
        }
    }

    if (
        count <
        decoded.length
    ) {

        decoded.copy(
            out,
            3 + count,
            count
        );
    }

    return out;
}

// ============================================================
// XXHASH32 FOR LZ4 HEADER
// ============================================================

function xxhash32(
    input,
    seed = 0
) {

    if (
        !Buffer.isBuffer(
            input
        )
    ) {

        input =
            Buffer.from(
                input
            );
    }

    const PRIME1 =
        0x9E3779B1;

    const PRIME2 =
        0x85EBCA77;

    const PRIME3 =
        0xC2B2AE3D;

    const PRIME4 =
        0x27D4EB2F;

    const PRIME5 =
        0x165667B1;

    let p = 0;

    const end =
        input.length;

    let h;

    if (
        input.length >= 16
    ) {

        let v1 =
            (
                seed +
                PRIME1 +
                PRIME2
            ) >>> 0;

        let v2 =
            (
                seed +
                PRIME2
            ) >>> 0;

        let v3 =
            seed >>> 0;

        let v4 =
            (
                seed -
                PRIME1
            ) >>> 0;

        const limit =
            end -
            16;

        while (
            p <= limit
        ) {

            v1 =
                Math.imul(
                    (
                        v1 +
                        Math.imul(
                            input.readUInt32LE(
                                p,
                                true
                            ),
                            PRIME2
                        )
                    ) >>> 0,
                    PRIME1
                ) >>> 0;

            v1 =
                (
                    (v1 << 13) |
                    (v1 >>> 19)
                ) >>> 0;

            p += 4;

            v2 =
                Math.imul(
                    (
                        v2 +
                        Math.imul(
                            input.readUInt32LE(
                                p
                            ),
                            PRIME2
                        )
                    ) >>> 0,
                    PRIME1
                ) >>> 0;

            v2 =
                (
                    (v2 << 13) |
                    (v2 >>> 19)
                ) >>> 0;

            p += 4;

            v3 =
                Math.imul(
                    (
                        v3 +
                        Math.imul(
                            input.readUInt32LE(
                                p
                            ),
                            PRIME2
                        )
                    ) >>> 0,
                    PRIME1
                ) >>> 0;

            v3 =
                (
                    (v3 << 13) |
                    (v3 >>> 19)
                ) >>> 0;

            p += 4;

            v4 =
                Math.imul(
                    (
                        v4 +
                        Math.imul(
                            input.readUInt32LE(
                                p
                            ),
                            PRIME2
                        )
                    ) >>> 0,
                    PRIME1
                ) >>> 0;

            v4 =
                (
                    (v4 << 13) |
                    (v4 >>> 19)
                ) >>> 0;

            p += 4;
        }

        h =
            (
                (
                    (
                        (v1 << 1) |
                        (v1 >>> 31)
                    ) +
                    (
                        (v2 << 7) |
                        (v2 >>> 25)
                    )
                ) ^
                0
            ) >>> 0;

        h =
            (
                h +
                (
                    (v3 << 12) |
                    (v3 >>> 20)
                ) +
                (
                    (v4 << 18) |
                    (v4 >>> 14)
                )
            ) >>> 0;

    } else {

        h =
            (
                seed +
                PRIME5
            ) >>> 0;
    }

    h =
        (
            h +
            input.length
        ) >>> 0;

    while (
        p + 4 <=
        end
    ) {

        h =
            (
                h +
                Math.imul(
                    input.readUInt32LE(
                        p
                    ),
                    PRIME3
                )
            ) >>> 0;

        h =
            Math.imul(
                (
                    (h << 17) |
                    (h >>> 15)
                ) >>> 0,
                PRIME4
            ) >>> 0;

        p += 4;
    }

    while (
        p < end
    ) {

        h =
            (
                h +
                Math.imul(
                    input[p],
                    PRIME5
                )
            ) >>> 0;

        h =
            Math.imul(
                (
                    (h << 11) |
                    (h >>> 21)
                ) >>> 0,
                PRIME1
            ) >>> 0;

        p++;
    }

    h =
        (
            h ^
            (h >>> 15)
        ) >>> 0;

    h =
        Math.imul(
            h,
            PRIME2
        ) >>> 0;

    h =
        (
            h ^
            (h >>> 13)
        ) >>> 0;

    h =
        Math.imul(
            h,
            PRIME3
        ) >>> 0;

    h =
        (
            h ^
            (h >>> 16)
        ) >>> 0;

    return h >>> 0;
}

// ============================================================
// LZ4 ENCODE
// ============================================================

function encodeLz4Uncompressed(
    decoded
) {

    if (
        !Buffer.isBuffer(
            decoded
        )
    ) {

        decoded =
            Buffer.from(
                decoded
            );
    }

    const parts = [];

    const length =
        decoded.length;

    let literalLength =
        length;

    let token =
        Math.min(
            literalLength,
            15
        ) << 4;

    parts.push(
        Buffer.from([
            token
        ])
    );

    if (
        literalLength >= 15
    ) {

        let remaining =
            literalLength -
            15;

        while (
            remaining >= 255
        ) {

            parts.push(
                Buffer.from([
                    255
                ])
            );

            remaining -=
                255;
        }

        parts.push(
            Buffer.from([
                remaining
            ])
        );
    }

    parts.push(
        decoded
    );

    const compressed =
        Buffer.concat(
            parts
        );

    const header =
        Buffer.from([
            0x60,
            0x70
        ]);

    const headerChecksum =
        (
            xxhash32(
                header
            ) >>>
            8
        ) & 0xff;

    const out =
        Buffer.alloc(
            4 +
            2 +
            1 +
            4 +
            compressed.length
        );

    LZ4_MAGIC.copy(
        out,
        0
    );

    out[4] =
        0x60;

    out[5] =
        0x70;

    out[6] =
        headerChecksum;

    out.writeUInt32LE(
        length >>> 0,
        7
    );

    compressed.copy(
        out,
        11
    );

    return out;
}

// ============================================================
// RE-ENCODE COMPLETE SAVE
// ============================================================

function encodeSaveWithLayers(
    xml,
    layers
) {

    let data =
        Buffer.isBuffer(
            xml
        )
            ? Buffer.from(
                xml
            )
            : Buffer.from(
                String(xml),
                "utf8"
            );

    for (
        let i =
            layers.length - 1;
        i >= 0;
        i--
    ) {

        const layer =
            layers[i];

        switch (
            layer.type
        ) {

            case "gzip":

                data =
                    zlib.gzipSync(
                        data
                    );

                break;

            case "lz4":

                data =
                    encodeLz4Uncompressed(
                        data
                    );

                break;

            case "79":

                data =
                    encode79Layer(
                        data,
                        layer.rawSeed,
                        data.length
                    );

                break;

            case "54":

                data =
                    encode54Layer(
                        data,
                        layer.processLen == null
                            ? data.length
                            : data.length
                    );

                break;

            case "raw-1f":

                throw new Error(
                    "COPY FARM: لا يمكن إعادة ترميز raw-1f تلقائيًا"
                );

            default:

                throw new Error(
                    `COPY FARM: layer encoder غير معروف: ${layer.type}`
                );
        }
    }

    return data;
}

// ============================================================
// FIND FETCHCITY DATA
// ============================================================

async function fetchFriendCityXml(
    cityId,
    cityVer
) {

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
            "COPY FARM: FetchCity لم يرجع result.data"
        );
    }

    const cityBytes =
        Buffer.from(
            json.result.data,
            "base64"
        );

    console.log(
        `[CopyFarm] fetched bytes=${cityBytes.length} magic=${bufferMagic(cityBytes)}`
    );

    const xml =
        decodeSaveCity(
            cityBytes
        );

    return {

        xml:
            xml,

        cityBytes:
            cityBytes
    };
}

// ============================================================
// COPY FARM INFO API
// ============================================================

async function handleCopyFarmInfo(
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

                    ok:
                        false,

                    error:
                        "COPY FARM INFO: أرسل ملف الأصدقاء بصيغة application/octet-stream"
                });
        }

        if (
            encryptedFile.length === 0
        ) {

            return res
                .status(400)
                .json({

                    ok:
                        false,

                    error:
                        "COPY FARM INFO: الملف فارغ"
                });
        }

        console.log(
            `[CopyFarm] friend file size=${encryptedFile.length}`
        );

        const xmlBuffer =
            decodeFriendFile(
                encryptedFile
            );

        const xml =
            xmlBuffer
                .toString(
                    "utf8"
                )
                .replace(
                    /^\uFEFF/,
                    ""
                )
                .trim();

        const friends =
            parseFriends(
                xml
            );

        const saveProfiles =
            parseSaveProfiles(
                xml
            );

        attachSaveIdsToFriends(
            friends,
            saveProfiles
        );

        const cities =
            friends.map(
                friend => ({

                    city_id:
                        friend.city_id,

                    city_name:
                        friend.city_name,

                    name:
                        friend.name,

                    level:
                        friend.level,

                    xp:
                        friend.xp,

                    likes:
                        friend.likes,

                    lang:
                        friend.lang,

                    fetched_city_ver:
                        friend.fetched_city_ver,

                    save_id:
                        friend.saveId || ""
                })
            );

        console.log(
            `[CopyFarm] cities=${cities.length}`
        );

        return res
            .status(200)
            .json({

                ok:
                    true,

                count:
                    cities.length,

                cities:
                    cities
            });

    } catch (err) {

        console.error(
            "[CopyFarm] INFO ERROR:",
            err &&
            err.stack
                ? err.stack
                : err
        );

        return res
            .status(500)
            .json({

                ok:
                    false,

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
// COPY FARM API
// ============================================================

async function handleCopyFarm(
    req,
    res
) {

    try {

        const mainSave =
            req.body;

        if (
            !Buffer.isBuffer(
                mainSave
            )
        ) {

            return res
                .status(400)
                .send(
                    "COPY FARM: أرسل الحفظ الرئيسي بصيغة application/octet-stream"
                );
        }

        if (
            mainSave.length === 0
        ) {

            return res
                .status(400)
                .send(
                    "COPY FARM: الحفظ الرئيسي فارغ"
                );
        }

        const cityId =
            String(
                req.headers["x-city-id"] ||
                req.headers["x-friend-city-id"] ||
                ""
            ).trim();

        const cityVerHeader =
            String(
                req.headers["x-city-ver"] ||
                req.headers["x-fetched-city-ver"] ||
                "0"
            ).trim();

        const cityVer =
            Number(
                cityVerHeader
            );

        if (
            !cityId
        ) {

            return res
                .status(400)
                .send(
                    "COPY FARM: x-city-id مفقود"
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
                    "COPY FARM: x-city-ver غير صالح"
                );
        }

        console.log(
            `[CopyFarm] mainSave=${mainSave.length}`
        );

        console.log(
            `[CopyFarm] selected cityId=${cityId} cityVer=${cityVer}`
        );

        // ====================================================
        // DECODE MAIN SAVE
        // ====================================================

        const mainDecoded =
            decodeSaveWithLayers(
                mainSave
            );

        const mainXml =
            mainDecoded.xml
                .toString(
                    "utf8"
                );

        console.log(
            `[CopyFarm] main XML=${mainDecoded.xml.length}`
        );

        console.log(
            `[CopyFarm] main layers=${mainDecoded.layers
                .map(
                    x =>
                        x.type
                )
                .join(" -> ")}`
        );

        // ====================================================
        // FETCH FRIEND
        // ====================================================

        const friendResult =
            await fetchFriendCityXml(
                cityId,
                cityVer
            );

        const friendXml =
            friendResult.xml
                .toString(
                    "utf8"
                );

        console.log(
            `[CopyFarm] friend XML=${friendResult.xml.length}`
        );

        // ====================================================
        // BASIC VALIDATION
        // ====================================================

        if (
            !mainXml.includes(
                "<root"
            )
        ) {

            throw new Error(
                "COPY FARM: الحفظ الرئيسي ليس XML صالحًا"
            );
        }

        if (
            !friendXml.includes(
                "<root"
            )
        ) {

            throw new Error(
                "COPY FARM: حفظ الصديق ليس XML صالحًا"
            );
        }

        // ====================================================
        // COPY
        // ====================================================

        const mergedXml =
            copyFarmReplaceTopLevelSections(
                mainXml,
                friendXml
            );

        console.log(
            `[CopyFarm] merged XML=${mergedXml.length}`
        );

        // ====================================================
        // KEEP MAIN ACCOUNT IDENTIFIERS
        // ====================================================

        let finalXml =
            mergedXml;

        finalXml =
            finalXml.replace(
                /<Var\b[^>]*\bname=["']cityId["'][^>]*\bv=["'][^"']*["'][^>]*\/?>/gi,
                function(tag) {

                    return tag;
                }
            );

        // ====================================================
        // RE-ENCODE USING MAIN SAVE LAYERS
        // ====================================================

        const encoded =
            encodeSaveWithLayers(
                finalXml,
                mainDecoded.layers
            );

        console.log(
            `[CopyFarm] final encoded size=${encoded.length}`
        );

        console.log(
            `[CopyFarm] final magic=${bufferMagic(encoded)}`
        );

        // ====================================================
        // RESPONSE
        // ====================================================

        res.status(
            200
        );

        res.set(
            "Content-Type",
            "application/octet-stream"
        );

        res.set(
            "Content-Disposition",
            'attachment; filename="LocalInfo.xml"'
        );

        res.set(
            "Cache-Control",
            "no-store"
        );

        return res.send(
            encoded
        );

    } catch (err) {

        console.error(
            "[CopyFarm] ERROR:",
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

// ============================================================
// NEW COPY FARM ROUTES
// ============================================================

router.post(
    "/copy-farm-info",
    express.raw({
        type: "application/octet-stream",
        limit: "50mb"
    }),
    handleCopyFarmInfo
);

router.post(
    "/copy-farm",
    express.raw({
        type: "application/octet-stream",
        limit: "100mb"
    }),
    handleCopyFarm
);

console.log(
    "[FetchCity] module loaded"
);

console.log(
    "[CopyFarm] /copy-farm-info loaded"
);

console.log(
    "[CopyFarm] /copy-farm loaded"
);

module.exports = router;
