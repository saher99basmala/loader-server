/* ========================================
   fetchCity.js
   FetchCity -> Base64 -> SaveCrypto -> XML
======================================== */

const express = require("express");
const crypto = require("crypto");
const zlib = require("zlib");
const fetch = require("node-fetch");

const router = express.Router();

/* ============================================================
   CONFIG
============================================================ */

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
   SAVECRYPTO CONSTANTS
============================================================ */

const TABLE_SIZE = 0x2D7;
const PROCESS_XOR = 0x396A8;
const TOTAL_XOR = 0xC5EED;
const TABLE_MULTIPLIER = 0x5BD1E995;

/* ============================================================
   FETCH54 TABLE
============================================================ */

const FETCH54_TABLE = Buffer.from(
    "d192KFBTVDZLSDBPSkIwNHh4PlJDMyFrUngqfCsyNV5PU2guWCcmTj5gbTlLZklXb3xTMmpoYmMgZlRkN2FTWjZSQmdRYkwpZlcxMWI8J0dXJ00pTiNsbF5xWntdOmJhakBudjlLZUXlgKDgnJkUyeSo8biZSak9lb2lPRTNbP0lMTys/ZFNAdXxddlZJSGdpdnR3I19ybG9nTD9yY2xKa0EyVjZkSF9hdiB1OWZ3JFZnaiVBdEJHK2RSRSg6bih0SSdiNDc/c3phSU5rbTh7PDdqTCN0O1NKO0knX3ZyVkNveiFvcGg0cC9kdW1UKDZ4ezNRfiZtbWEpJS9+QlJjbm9qeVRmVC55cW4mc2s5ajtheTNwZyssY2NKRz1URXUySy0qZCVJVSpZMk4pLn17VVBfTip4P1pdX2wsXXZ+J21ydkIpdUcuc3cyUCVRK3xOUUxgPklmeUx3ZF0sST9mK2lnOm84cyNMUk15KCQwWTJWelhCRVZ+UXVCZ1J+eVplb2gtY0NAcUA+Ni1WdlQyLFpTV2xVfnRoKyUwfFdfaVBsfU0wdW4/cHlkcXVsYHxaTGB1N3JtMUwwZXd6NGM5KmZuUlpGOjgoOyYlNltHbj4sTFhXOUY/UVE0MSg6NXN2ckdWI3snMyldMi82bG5bc1lkczpxVGRCaDhPeUI8I1EhVSVRJ1tkK3IlKU9CT3V5XSE9fWFnMEdQNlp+YCs5PnJGJmBfOF59Tn5YMDJEKUgjfWFPKTA4dHF4OixPJmZOcHtSJFc+KU1CZUxpfFJYOi56JzVCJWddMTNFZiB5JUs/e1JBcGdrey4xKSxBT1toVXlJLm98cUBwXiBNczFJNyBadWI6YSdPNFknXzA7WG1afnZLPW5KI3dZQ2Njbl5Dekp1NDxmNW9neV19I0s1RklsS25ud1RfXmRWQVpndl1EIFdJdEBzbCFpPSlxeG5XaA==",
    "base64"
);

/* ============================================================
   UTILS
============================================================ */

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

function isGzip(buf) {
    return (
        buf &&
        buf.length >= 2 &&
        buf[0] === 0x1F &&
        buf[1] === 0x8B
    );
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

function looksLikeXml(buf) {
    if (!buf || buf.length === 0) {
        return false;
    }

    const text =
        buf.subarray(
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

/* ============================================================
   0x79
============================================================ */

function build79Table(seed) {
    const table = Buffer.alloc(TABLE_SIZE);

    let state = seed >>> 0;

    for (let i = 0; i < TABLE_SIZE; i++) {
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
        (TOTAL_XOR ^ total) >>> 0;

    let processLenU32 =
        (
            (
                headerValue -
                derived
            ) ^
            PROCESS_XOR
        ) >>> 0;

    const maxProcessLen =
        Math.max(0, total - 8);

    const processLen =
        Math.min(
            maxProcessLen,
            processLenU32
        );

    const rawSeed =
        u32le(raw, 4);

    const seed =
        (rawSeed + 4) >>> 0;

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

    for (let i = 1; i < out.length; i++) {
        const current = out[i];
        const previousDecoded = out[i - 1];

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

    const header1 =
        raw[1] & 0xFF;

    const header2 =
        raw[2] & 0xFF;

    let processLen =
        (
            (header1 ^ FETCH54_TABLE[0]) |
            (header2 << 8)
        ) >>> 0;

    const payloadLength =
        raw.length - 3;

    console.log(
        `[FetchCity][54] raw=${raw.length}`
    );

    console.log(
        `[FetchCity][54] header=` +
        `${header1.toString(16).padStart(2, "0")} ` +
        `${header2.toString(16).padStart(2, "0")}`
    );

    console.log(
        `[FetchCity][54] table[0]=` +
        FETCH54_TABLE[0]
            .toString(16)
            .padStart(2, "0")
    );

    console.log(
        `[FetchCity][54] processLen=${processLen}`
    );

    console.log(
        `[FetchCity][54] payload=${payloadLength}`
    );

    if (processLen > payloadLength) {
        processLen = payloadLength;

        console.log(
            `[FetchCity][54] processLen clipped=${processLen}`
        );
    }

    const out =
        Buffer.from(
            raw.subarray(3)
        );

    if (out.length === 0) {
        return out;
    }

    /*
     * مهم:
     * أول بايت في طبقة 0x54 يبدأ بطرح 0x54.
     * بعد ذلك يتم فك differential ثم XOR.
     */

    for (let i = 0; i < processLen; i++) {

        if (i === 0) {

            out[i] =
                (
                    out[i] -
                    0x54
                ) & 0xFF;

        } else {

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

    console.log(
        `[FetchCity][54] decoded magic=${bufferMagic(out)}`
    );

    if (isGzip(out)) {
        console.log(
            "[FetchCity][54] الناتج GZIP ✅"
        );
    } else {
        console.log(
            "[FetchCity][54] الناتج ليس GZIP ❌"
        );
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
                `نوع SaveCrypto غير مدعوم: 0x${type
                    .toString(16)
                    .padStart(2, "0")}`
            );
    }
}

/* ============================================================
   LZ4
============================================================ */

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

        if (literalLength === 15) {

            let value;

            do {

                if (srcPos >= src.length) {
                    throw new Error(
                        "LZ4: literal length خارج البيانات"
                    );
                }

                value =
                    src[srcPos++];

                literalLength += value;

            } while (value === 255);
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
                "LZ4: output overflow"
            );
        }

        src.copy(
            output,
            dstPos,
            srcPos,
            srcPos + literalLength
        );

        srcPos += literalLength;
        dstPos += literalLength;

        if (srcPos >= src.length) {
            break;
        }

        if (srcPos + 2 > src.length) {
            throw new Error(
                "LZ4: offset ناقص"
            );
        }

        const offset =
            src[srcPos] |
            (src[srcPos + 1] << 8);

        srcPos += 2;

        if (offset === 0) {
            throw new Error(
                "LZ4: offset = 0"
            );
        }

        if (offset > dstPos) {
            throw new Error(
                `LZ4: offset أكبر من output: ${offset} > ${dstPos}`
            );
        }

        let matchLength =
            token & 0x0F;

        if (matchLength === 15) {

            let value;

            do {

                if (srcPos >= src.length) {
                    throw new Error(
                        "LZ4: match length خارج البيانات"
                    );
                }

                value =
                    src[srcPos++];

                matchLength += value;

            } while (value === 255);
        }

        matchLength += 4;

        if (
            dstPos +
            matchLength >
            expectedSize
        ) {
            throw new Error(
                "LZ4: output overflow"
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

        dstPos += matchLength;
    }

    if (dstPos !== expectedSize) {
        throw new Error(
            `LZ4: الحجم غير مطابق. expected=${expectedSize}, actual=${dstPos}`
        );
    }

    return output;
}

function decodeLz4Container(raw) {

    if (!isLz4Magic(raw)) {
        throw new Error(
            `LZ4 magic غير صحيح: ${bufferMagic(raw)}`
        );
    }

    if (raw.length < 8) {
        throw new Error(
            "LZ4 container قصير"
        );
    }

    const expectedSize =
        u32le(raw, 4);

    const compressed =
        raw.subarray(8);

    console.log(
        `[FetchCity] LZ4 expected=${expectedSize} compressed=${compressed.length}`
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
        text.lastIndexOf("</root>");

    if (rootEnd !== -1) {

        return Buffer.from(
            text.slice(
                0,
                rootEnd + 7
            ),
            "utf8"
        );
    }

    return buf;
}

/* ============================================================
   CITY DECODER
============================================================ */

function decodeSaveCity(cityBytes) {

    let data =
        Buffer.from(cityBytes);

    console.log(
        `[FetchCity] cityBytes=${data.length} magic=${bufferMagic(data)}`
    );

    let rounds = 0;

    while (
        data.length > 0 &&
        rounds < 12
    ) {

        rounds++;

        console.log(
            `[FetchCity] layer ${rounds} input=` +
            `${bufferMagic(data)} size=${data.length}`
        );

        /*
         * XML
         */

        if (looksLikeXml(data)) {

            console.log(
                `[FetchCity] XML detected after ${rounds - 1} layer(s) ✅`
            );

            return trimXml(data);
        }

        /*
         * GZIP
         */

        if (isGzip(data)) {

            console.log(
                `[FetchCity] GZIP detected size=${data.length}`
            );

            try {

                data =
                    zlib.gunzipSync(data);

                console.log(
                    `[FetchCity] GZIP decoded successfully size=${data.length} magic=${bufferMagic(data)}`
                );

                continue;

            } catch (gzipError) {

                console.error(
                    "[FetchCity] GZIP ERROR:",
                    gzipError.message
                );

                /*
                 * نجرب zlib raw فقط كاختبار إضافي.
                 */

                try {

                    data =
                        zlib.inflateSync(data);

                    console.log(
                        "[FetchCity] ZLIB fallback succeeded"
                    );

                    continue;

                } catch (zlibError) {

                    console.error(
                        "[FetchCity] ZLIB fallback failed:",
                        zlibError.message
                    );
                }

                throw new Error(
                    "فشل فك GZIP بعد 0x54: " +
                    gzipError.message
                );
            }
        }

        /*
         * LZ4
         */

        if (isLz4Magic(data)) {

            console.log(
                "[FetchCity] LZ4 detected"
            );

            data =
                decodeLz4Container(data);

            continue;
        }

        /*
         * SaveCrypto
         */

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
                `[FetchCity] layer ${rounds}: ` +
                `${bufferMagic(before)} -> ` +
                `${bufferMagic(data)}`
            );

            continue;
        }

        throw new Error(
            `طبقة غير معروفة بعد ${rounds} مرحلة. ` +
            `Magic=${bufferMagic(data)}`
        );
    }

    if (looksLikeXml(data)) {
        return trimXml(data);
    }

    throw new Error(
        `تعذر الوصول إلى XML. Magic=${bufferMagic(data)} size=${data.length}`
    );
}

/* ============================================================
   AES REQUEST
============================================================ */

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

/* ============================================================
   AES RESPONSE
============================================================ */

function decryptResponse(body, tsId) {

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

    if (hex.length < 56) {
        throw new Error(
            `ts-id قصير: ${tsId}`
        );
    }

    const iv =
        Buffer.from(
            hex.slice(0, 24),
            "hex"
        );

    const tag =
        Buffer.from(
            hex.slice(24, 56),
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

/* ============================================================
   RESPONSE DECOMPRESSION
============================================================ */

function decompressResponse(decrypted) {

    console.log(
        `[FetchCity] decrypted size=${decrypted.length}`
    );

    console.log(
        `[FetchCity] decrypted magic=${bufferMagic(decrypted)}`
    );

    try {

        return zlib.gunzipSync(
            decrypted
        );

    } catch (_) {}

    try {

        return zlib.inflateSync(
            decrypted
        );

    } catch (_) {}

    try {

        return zlib.inflateRawSync(
            decrypted
        );

    } catch (_) {}

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
        `magic=${bufferMagic(decrypted)} size=${decrypted.length}`
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
                        "Accept-Encoding": "identity",
                        "Content-Type": "application/octet-stream",
                        "User-Agent": "okhttp/4.9.0",
                        "ts-bp": "i",
                        "ts-bver": "bver",
                        "ts-fver": "fver",
                        "ts-gpid": "new",
                        "ts-id": encrypted.tsId
                    },

                    body: encrypted.body,
                    signal: controller.signal
                }
            );

        const responseBody =
            Buffer.from(
                await response.arrayBuffer()
            );

        console.log(
            `[FetchCity] upstream status=${response.status}`
        );

        if (!response.ok) {

            throw new Error(
                `Upstream HTTP ${response.status}: ` +
                responseBody.toString("utf8")
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
            decompressResponse(
                decrypted
            );

        const text =
            uncompressed.toString("utf8");

        console.log(
            `[FetchCity] JSON size=${text.length}`
        );

        return JSON.parse(text);

    } finally {

        clearTimeout(timer);
    }
}

/* ============================================================
   FETCHCITY API
============================================================ */

async function handleFetchCity(req, res) {

    try {

        const body =
            req.body || {};

        const cityId =
            String(
                body.city_id || ""
            ).trim();

        const cityName =
            String(
                body.city_name || ""
            ).trim();

        const level =
            String(
                body.level || ""
            ).trim();

        if (!cityId) {

            return res
                .status(400)
                .json({
                    ok: false,
                    error: "city_id مطلوب"
                });
        }

        console.log(
            `[FetchCity] requested saveId=${cityId} name=${cityName} level=${level}`
        );

        /*
         * saveId القادم من Lua
         * يستخدم كـ fetchCityId عند Playrix.
         */

        const cityVer = 0;

        const result =
            await requestFetchCity(
                cityId,
                cityVer
            );

        if (
            !result ||
            !result.result ||
            !result.result.data
        ) {

            return res
                .status(502)
                .json({
                    ok: false,
                    error:
                        "Playrix لم يرجع result.data"
                });
        }

        const base64 =
            String(
                result.result.data
            );

        console.log(
            `[FetchCity] Base64 length=${base64.length}`
        );

        /*
         * Base64 -> .city
         */

        const cityBytes =
            Buffer.from(
                base64,
                "base64"
            );

        console.log(
            `[FetchCity] decoded city bytes=${cityBytes.length} magic=${bufferMagic(cityBytes)}`
        );

        /*
         * فك المدينة بالكامل
         */

        const xmlBuffer =
            decodeSaveCity(
                cityBytes
            );

        if (
            !xmlBuffer ||
            xmlBuffer.length === 0
        ) {

            throw new Error(
                "فك المدينة أعطى ملفًا فارغًا"
            );
        }

        const xml =
            xmlBuffer.toString("utf8");

        console.log(
            `[FetchCity] OPEN XML size=${Buffer.byteLength(xml, "utf8")}`
        );

        console.log(
            `[FetchCity] OPEN XML magic=${bufferMagic(
                Buffer.from(xml, "utf8")
            )}`
        );

        if (!xml.trimStart().startsWith("<")) {

            throw new Error(
                "بعد فك المدينة لم يتم الوصول إلى XML"
            );
        }

        /*
         * إرسال XML مفتوح إلى Lua
         */

        res.set(
            "Content-Type",
            "application/xml; charset=utf-8"
        );

        res.set(
            "Content-Disposition",
            `inline; filename="${cityId}.xml"`
        );

        res.set(
            "Cache-Control",
            "no-store"
        );

        return res.send(xml);

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

/* ============================================================
   FRIEND FILE DECODER
============================================================ */

const FRIEND_TABLE_SIZE = 0x2D7;

function friendU32(v) {
    return v >>> 0;
}

function friendReadU32(data, pos) {

    if (pos + 4 > data.length) {
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
    let length =
        data.length;

    while (length >= 4) {

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
        i < FRIEND_TABLE_SIZE
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
            i + j < FRIEND_TABLE_SIZE;
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

    if (data.length < 8) {
        throw new Error(
            "الملف صغير جدًا"
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
                    data.length
                )
            ) ^
            0x396A8
        );

    const actual =
        Math.min(
            sf,
            data.length - 8
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

    const size =
        friendReadU32(
            data,
            4
        );

    let src = 8;
    let outLen = 0;

    const output =
        Buffer.alloc(size);

    function readByte() {

        if (src >= data.length) {
            throw new Error(
                "LZ4: نهاية غير متوقعة"
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

        if (literalLen === 15) {

            let b;

            do {

                b = readByte();
                literalLen += b;

            } while (b === 255);
        }

        for (
            let i = 0;
            i < literalLen;
            i++
        ) {

            output[outLen++] =
                readByte();
        }

        if (outLen >= size) {
            break;
        }

        const offset =
            readByte() |
            (readByte() << 8);

        if (offset === 0) {
            throw new Error(
                "LZ4: offset = 0"
            );
        }

        let matchLen =
            token & 0x0F;

        if (matchLen === 15) {

            let b;

            do {

                b = readByte();
                matchLen += b;

            } while (b === 255);
        }

        matchLen += 4;

        const start =
            outLen -
            offset;

        if (start < 0) {
            throw new Error(
                "LZ4: offset خارج النطاق"
            );
        }

        for (
            let i = 0;
            i < matchLen;
            i++
        ) {

            output[outLen++] =
                output[
                    start +
                    (i % offset)
                ];
        }
    }

    if (outLen !== size) {
        throw new Error(
            `LZ4 size mismatch: expected=${size} actual=${outLen}`
        );
    }

    return output;
}

function friendTrimXml(data) {

    const marker =
        Buffer.from("</root>");

    const pos =
        data.lastIndexOf(marker);

    if (pos !== -1) {

        return data.subarray(
            0,
            pos + marker.length
        );
    }

    return data;
}

function decodeFriendFile(data) {

    if (!Buffer.isBuffer(data)) {
        data =
            Buffer.from(data);
    }

    if (data.length === 0) {
        throw new Error(
            "الملف فارغ"
        );
    }

    if (data[0] === 0x3C) {
        return data;
    }

    if (data[0] !== 0x79) {
        throw new Error(
            "نوع ملف الأصدقاء غير مدعوم. Magic=0x" +
            data[0]
                .toString(16)
                .padStart(2, "0")
        );
    }

    let payload =
        friendXorDecode(data);

    if (friendIsLz4(payload)) {
        payload =
            friendLz4Decompress(payload);
    }

    return friendTrimXml(payload);
}

/* ============================================================
   XML ATTR
============================================================ */

function attrFromXmlTag(tag, name) {

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

/* ============================================================
   FRIEND VERSION
============================================================ */

function parseFriendVersion(xml) {

    const tag =
        xml.match(
            /<Version\b[^>]*>/i
        );

    if (!tag) {
        return {
            bver: "",
            fver: ""
        };
    }

    return {
        bver:
            attrFromXmlTag(
                tag[0],
                "version"
            ),

        fver:
            attrFromXmlTag(
                tag[0],
                "FVer"
            )
    };
}

/* ============================================================
   FRIENDS
============================================================ */

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
            city_id: cityId,

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

    return friends;
}

/* ============================================================
   DECODE FRIENDS API
============================================================ */

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
                    error: "الملف فارغ"
                });
        }

        console.log(
            `[Friends] encrypted size=${encryptedFile.length}`
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
                .replace(/^\uFEFF/, "")
                .trim();

        const version =
            parseFriendVersion(xml);

        const friends =
            parseFriends(xml);

        return res
            .status(200)
            .json({
                ok: true,
                bver: version.bver,
                fver: version.fver,
                friends
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

/* ============================================================
   ROUTES
============================================================ */

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
