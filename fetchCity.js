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
// SAVECRYPTO CONSTANTS
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
// GENERAL UTILS
// ============================================================

function u32le(buf, offset) {

    if (offset + 4 > buf.length) {
        throw new Error(
            `u32le خارج حدود البيانات: offset=${offset}, size=${buf.length}`
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

    if (!buf || buf.length < 1) {
        return "";
    }

    return Array.from(
        buf.subarray(
            0,
            Math.min(8, buf.length)
        )
    )
        .map(
            x =>
                x
                    .toString(16)
                    .padStart(2, "0")
        )
        .join(" ");
}


function bufferHex(buf, count = 32) {

    if (!buf || !buf.length) {
        return "";
    }

    return Array.from(
        buf.subarray(
            0,
            Math.min(count, buf.length)
        )
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


function looksLikeTextJson(buf) {

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
            .replace(/^\uFEFF/, "")
            .trimStart();

    return (
        text.startsWith("{") ||
        text.startsWith("[")
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
            .replace(/^\uFEFF/, "")
            .trimStart();

    return (
        text.startsWith("<root") ||
        text.startsWith("<?xml") ||
        text.startsWith("<")
    );
}


function trimJsonBuffer(buf) {

    if (!Buffer.isBuffer(buf)) {
        buf = Buffer.from(buf);
    }

    let text =
        buf
            .toString("utf8")
            .replace(/^\uFEFF/, "")
            .trim();

    const firstObject =
        text.indexOf("{");

    const firstArray =
        text.indexOf("[");

    let start = -1;

    if (
        firstObject !== -1 &&
        firstArray !== -1
    ) {

        start =
            Math.min(
                firstObject,
                firstArray
            );

    } else if (
        firstObject !== -1
    ) {

        start = firstObject;

    } else if (
        firstArray !== -1
    ) {

        start = firstArray;
    }

    if (start > 0) {
        text = text.slice(start);
    }

    const lastObject =
        text.lastIndexOf("}");

    const lastArray =
        text.lastIndexOf("]");

    const end =
        Math.max(
            lastObject,
            lastArray
        );

    if (end !== -1) {

        text =
            text.slice(
                0,
                end + 1
            );
    }

    return Buffer.from(
        text.trim(),
        "utf8"
    );
}


// ============================================================
// FETCHCITY 0x79
// ============================================================
// هذه الخوارزمية خاصة بملفات LocalInfo / IDs.
// لا يتم افتراض أنها طبقة بعد 0x54 في FetchCity.
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

    if (raw[0] !== 0x79) {

        throw new Error(
            `Magic 0x79 غير صحيح: ${bufferMagic(raw)}`
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

    console.log(
        `[79] header=${headerValue} total=${total} processLen=${processLen} seed=${seed}`
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

    console.log(
        `[54] processLen=${processLen} output=${out.length}`
    );

    console.log(
        `[54] output magic=${bufferMagic(out)}`
    );

    console.log(
        `[54] output first32=${bufferHex(out, 32)}`
    );

    return out;
}


// ============================================================
// LZ4
// ============================================================

function lz4DecompressBlock(
    src,
    expectedSize
) {

    if (!Buffer.isBuffer(src)) {
        src = Buffer.from(src);
    }

    if (
        expectedSize <= 0 ||
        expectedSize > 1024 * 1024 * 512
    ) {

        throw new Error(
            `LZ4 expectedSize غير صالح: ${expectedSize}`
        );
    }

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
                        "LZ4: literal length خارج حدود البيانات"
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
                "LZ4: literals خارج حدود البيانات"
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

        /*
         * آخر sequence في LZ4 يمكن أن يكون literals فقط.
         */
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
                    srcPos >=
                    src.length
                ) {

                    throw new Error(
                        "LZ4: match length خارج حدود البيانات"
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

        /*
         * مهم:
         * النسخ يتم byte-by-byte حتى يعمل overlap
         * الصحيح الخاص بـ LZ4.
         */
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
            `LZ4: الحجم الناتج غير مطابق. expected=${expectedSize}, actual=${dstPos}`
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

    console.log(
        `[FetchCity] LZ4 compressed first32=${bufferHex(compressed, 32)}`
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

    return Buffer.from(
        text,
        "utf8"
    );
}


// ============================================================
// FETCHCITY SAVE DECODER
// ============================================================
//
// المسار:
//
// FetchCity JSON
//      ↓
// base64
//      ↓
// 0x54
//      ↓
// LZ4 إذا كان magic فعلاً
//      ↓
// XML
//
// لا يتم تشغيل 0x79 تلقائياً هنا.
// ============================================================

function decodeSaveCity(cityBytes) {

    let data =
        Buffer.from(
            cityBytes
        );

    console.log(
        `[FetchCity] cityBytes=${data.length} magic=${bufferMagic(data)}`
    );

    console.log(
        `[FetchCity] cityBytes first32=${bufferHex(data, 32)}`
    );


    // --------------------------------------------------------
    // Round 1
    // --------------------------------------------------------

    if (
        looksLikeXml(data)
    ) {

        console.log(
            "[FetchCity] XML already available"
        );

        return trimXml(
            data
        );
    }


    // --------------------------------------------------------
    // gzip
    // --------------------------------------------------------

    if (
        isGzip(data)
    ) {

        console.log(
            "[FetchCity] gzip detected"
        );

        data =
            zlib.gunzipSync(
                data
            );

        console.log(
            `[FetchCity] after gzip size=${data.length} magic=${bufferMagic(data)}`
        );
    }


    // --------------------------------------------------------
    // 0x54
    // --------------------------------------------------------

    if (
        data.length > 0 &&
        data[0] === 0x54
    ) {

        console.log(
            "[FetchCity] 0x54 detected"
        );

        data =
            decode54Layer(
                data
            );

        console.log(
            `[FetchCity] AFTER 0x54 size=${data.length} magic=${bufferMagic(data)}`
        );

        console.log(
            `[FetchCity] AFTER 0x54 first32=${bufferHex(data, 32)}`
        );
    }


    // --------------------------------------------------------
    // XML بعد 0x54
    // --------------------------------------------------------

    if (
        looksLikeXml(data)
    ) {

        console.log(
            "[FetchCity] XML detected after 0x54"
        );

        return trimXml(
            data
        );
    }


    // --------------------------------------------------------
    // LZ4 بعد 0x54
    // --------------------------------------------------------

    if (
        isLz4Magic(data)
    ) {

        console.log(
            "[FetchCity] LZ4 detected after 0x54"
        );

        data =
            decodeLz4Container(
                data
            );

        console.log(
            `[FetchCity] AFTER LZ4 size=${data.length} magic=${bufferMagic(data)}`
        );

        console.log(
            `[FetchCity] AFTER LZ4 first32=${bufferHex(data, 32)}`
        );
    }


    // --------------------------------------------------------
    // XML بعد LZ4
    // --------------------------------------------------------

    if (
        looksLikeXml(data)
    ) {

        console.log(
            "[FetchCity] XML detected after LZ4"
        );

        return trimXml(
            data
        );
    }


    // --------------------------------------------------------
    // JSON
    // --------------------------------------------------------

    if (
        looksLikeTextJson(data)
    ) {

        console.log(
            "[FetchCity] JSON detected"
        );

        return trimJsonBuffer(
            data
        );
    }


    // --------------------------------------------------------
    // إذا ظهر 0x79 هنا
    // لا نفكه تلقائياً لأن 0x79 معروف حالياً
    // كمسار LocalInfo.
    // --------------------------------------------------------

    if (
        data.length > 0 &&
        data[0] === 0x79
    ) {

        throw new Error(
            "ظهر 0x79 بعد مسار FetchCity/0x54. " +
            "هذا يحتاج تأكيد ترتيب الطبقات قبل تطبيق خوارزمية LocalInfo 0x79. " +
            `magic=${bufferMagic(data)} size=${data.length} first32=${bufferHex(data, 32)}`
        );
    }


    // --------------------------------------------------------
    // gzip بعد أي طبقة
    // --------------------------------------------------------

    if (
        isGzip(data)
    ) {

        console.log(
            "[FetchCity] gzip detected in final stage"
        );

        data =
            zlib.gunzipSync(
                data
            );

        if (
            looksLikeXml(data)
        ) {

            return trimXml(
                data
            );
        }

        if (
            looksLikeTextJson(data)
        ) {

            return trimJsonBuffer(
                data
            );
        }
    }


    // --------------------------------------------------------
    // غير معروف
    // --------------------------------------------------------

    throw new Error(
        "تعذر الوصول إلى XML بعد فك FetchCity. " +
        `size=${data.length} ` +
        `magic=${bufferMagic(data)} ` +
        `first32=${bufferHex(data, 32)}`
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
        hex.length < 56
    ) {

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

    decipher.setAuthTag(
        tag
    );

    return Buffer.concat([
        decipher.update(body),
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
        `[FetchCity] decrypted size=${decrypted.length} magic=${bufferMagic(decrypted)}`
    );

    console.log(
        `[FetchCity] decrypted first32=${bufferHex(decrypted, 32)}`
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


    /*
     * أحياناً يكون المحتوى JSON مباشرة.
     */
    if (
        looksLikeTextJson(
            decrypted
        )
    ) {

        return decrypted;
    }


    /*
     * وأحياناً يمكن أن يكون binary SaveCrypto
     * مباشرة بعد AES.
     */
    if (
        decrypted.length > 0 &&
        (
            decrypted[0] === 0x54 ||
            decrypted[0] === 0x79 ||
            isLz4Magic(decrypted)
        )
    ) {

        return decrypted;
    }


    throw new Error(
        "تعذر فك ضغط استجابة FetchCity. " +
        `magic=${bufferMagic(decrypted)} ` +
        `size=${decrypted.length} ` +
        `first32=${bufferHex(decrypted, 32)}`
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


        console.log(
            `[FetchCity] upstream HTTP=${response.status} size=${responseBody.length} magic=${bufferMagic(responseBody)}`
        );


        if (!response.ok) {

            throw new Error(
                `Upstream HTTP ${response.status}: ` +
                responseBody.toString("utf8")
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


        const decrypted =
            decryptResponse(
                responseBody,
                responseTsId
            );


        const uncompressed =
            decompressResponse(
                decrypted
            );


        console.log(
            `[FetchCity] response data size=${uncompressed.length} magic=${bufferMagic(uncompressed)}`
        );


        const text =
            uncompressed
                .toString("utf8")
                .trim();


        try {

            return JSON.parse(
                text
            );

        } catch (error) {

            throw new Error(
                "FetchCity response بعد AES/decompression ليس JSON صالح. " +
                `magic=${bufferMagic(uncompressed)} ` +
                `size=${uncompressed.length} ` +
                `first32=${bufferHex(uncompressed, 32)}`
            );
        }

    } finally {

        clearTimeout(
            timer
        );
    }
}


// ============================================================
// FETCHCITY API
// ============================================================
//
// Lua يرسل فقط:
//
// {
//     "city_id": "...",
//     "city_name": "...",
//     "level": 16
// }
//
// city_id = SaveId أو city_id حسب المصدر.
// السيرفر يستخدم city_id كـ fetchCityId.
//
// cityVer = 0 داخلياً.
// ============================================================

async function handleFetchCity(
    req,
    res
) {

    try {

        const body =
            req.body ||
            {};


        const cityId =
            String(
                body.city_id || ""
            ).trim();


        const cityName =
            String(
                body.city_name || ""
            ).trim();


        const level =
            Number(
                body.level || 0
            );


        if (!cityId) {

            return res
                .status(400)
                .json({

                    ok: false,

                    error:
                        "city_id مطلوب"
                });
        }


        if (
            !Number.isFinite(level) ||
            level < 0
        ) {

            return res
                .status(400)
                .json({

                    ok: false,

                    error:
                        "level غير صالح"
                });
        }


        console.log(
            "[FetchCity] incoming:",
            {
                city_id: cityId,
                city_name: cityName,
                level: level
            }
        );


        const cityVer =
            0;


        const json =
            await requestFetchCity(
                cityId,
                cityVer
            );


        if (
            !json ||
            !json.result ||
            typeof json.result.data !== "string"
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


        console.log(
            `[FetchCity] result.data decoded size=${cityBytes.length} magic=${bufferMagic(cityBytes)}`
        );


        const xml =
            decodeSaveCity(
                cityBytes
            );


        const modifiedXml =
            editCityXml(
                xml
            );


        res.set(
            "Content-Type",
            "application/xml; charset=utf-8"
        );

        res.set(
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

    if (
        data[0] !== 0x79
    ) {

        throw new Error(
            `Magic الملف غير صحيح: ${bufferMagic(data)}`
        );
    }

    const hl =
        data[1] |
        (data[2] << 8) |
        (data[3] << 16);

    const hs =
        (
            data[4] |
            (data[5] << 8) |
            (data[6] << 16) |
            (data[7] << 24)
        ) >>> 0;

    const srcSize =
        data.length;

    console.log(
        `[IDs] 0x79 hl=${hl} hs=${hs} srcSize=${srcSize}`
    );

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

    console.log(
        `[IDs] calculated sf=${sf} actual=${actual}`
    );

    if (
        actual <= 0
    ) {

        throw new Error(
            `حجم البيانات بعد فك 0x79 غير صالح: sf=${sf}, srcSize=${srcSize}`
        );
    }

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
            data[
                8 + i
            ];
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


// ============================================================
// FRIEND LZ4
// ============================================================

function friendIsLz4(
    data
) {

    return (
        data &&
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
        data.length < 8
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

    if (
        size <= 0
    ) {

        throw new Error(
            `LZ4: الحجم غير صالح: ${size}`
        );
    }

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
                readByte() <<
                8
            );

        if (
            offset === 0
        ) {

            throw new Error(
                "LZ4: Offset غير صالح"
            );
        }

        if (
            offset >
            outLen
        ) {

            throw new Error(
                `LZ4: Offset أكبر من البيانات الناتجة: ${offset} > ${outLen}`
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
                    "LZ4: الحجم الناتج تجاوز المتوقع"
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
            `LZ4: الحجم الناتج غير صحيح Expected=${size} Actual=${outLen}`
        );
    }

    return output;
}


// ============================================================
// FRIEND FILE -> DATA
// ============================================================

function decodeFriendFile(
    data
) {

    if (!Buffer.isBuffer(data)) {
        data = Buffer.from(data);
    }

    if (
        data.length === 0
    ) {

        throw new Error(
            "ملف فارغ"
        );
    }

    console.log(
        `[IDs] decode input size=${data.length}`
    );

    console.log(
        `[IDs] decode input magic=${bufferMagic(data)}`
    );


    if (
        looksLikeTextJson(data)
    ) {

        return trimJsonBuffer(
            data
        );
    }


    if (
        looksLikeXml(data)
    ) {

        return trimXml(
            data
        );
    }


    if (
        data[0] !== 0x79
    ) {

        throw new Error(
            "نوع غير مدعوم. " +
            `Magic=${bufferMagic(data)}`
        );
    }


    let payload =
        friendXorDecode(
            data
        );


    console.log(
        `[IDs] after 0x79 size=${payload.length}`
    );

    console.log(
        `[IDs] after 0x79 magic=${bufferMagic(payload)}`
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

        console.log(
            `[IDs] after LZ4 size=${payload.length}`
        );
    }


    if (
        looksLikeXml(payload)
    ) {

        return trimXml(
            payload
        );
    }


    if (
        looksLikeTextJson(payload)
    ) {

        return trimJsonBuffer(
            payload
        );
    }


    if (
        isGzip(payload)
    ) {

        payload =
            zlib.gunzipSync(
                payload
            );

        if (
            looksLikeXml(payload)
        ) {

            return trimXml(
                payload
            );
        }

        return trimJsonBuffer(
            payload
        );
    }


    return friendTrimData(
        payload
    );
}


function friendTrimData(
    data
) {

    if (!Buffer.isBuffer(data)) {
        data = Buffer.from(data);
    }

    const text =
        data
            .toString("utf8")
            .replace(
                /^\uFEFF/,
                ""
            )
            .trim();

    if (
        text.startsWith("{") ||
        text.startsWith("[")
    ) {

        return trimJsonBuffer(
            data
        );
    }

    if (
        text.startsWith("<")
    ) {

        return trimXml(
            data
        );
    }

    return data;
}


// ============================================================
// XML ATTRIBUTE HELPERS
// ============================================================

function parseXmlAttributes(
    tagText
) {

    const attrs = {};

    const regex =
        /([A-Za-z_][A-Za-z0-9_.:-]*)\s*=\s*(?:"([^"]*)"|'([^']*)')/g;

    let match;

    while (
        (match = regex.exec(tagText)) !== null
    ) {

        attrs[
            match[1]
        ] =
            match[2] !== undefined
                ? match[2]
                : match[3];
    }

    return attrs;
}


// ============================================================
// XML ENTITY DECODER
// ============================================================

function xmlDecodeEntities(
    value
) {

    if (
        value === undefined ||
        value === null
    ) {

        return "";
    }

    let text =
        String(value);

    text =
        text.replace(
            /&#x([0-9a-fA-F]+);/g,
            function(_, hex) {

                try {

                    return String.fromCodePoint(
                        parseInt(
                            hex,
                            16
                        )
                    );

                } catch (_) {

                    return _;
                }
            }
        );

    text =
        text.replace(
            /&#([0-9]+);/g,
            function(_, dec) {

                try {

                    return String.fromCodePoint(
                        parseInt(
                            dec,
                            10
                        )
                    );

                } catch (_) {

                    return _;
                }
            }
        );

    text =
        text.replace(
            /&quot;/g,
            '"'
        );

    text =
        text.replace(
            /&apos;/g,
            "'"
        );

    text =
        text.replace(
            /&lt;/g,
            "<"
        );

    text =
        text.replace(
            /&gt;/g,
            ">"
        );

    text =
        text.replace(
            /&amp;/g,
            "&"
        );

    return text;
}


// ============================================================
// CLEAN STRING
// ============================================================

function cleanString(
    value
) {

    if (
        value === undefined ||
        value === null
    ) {

        return "";
    }

    return String(
        value
    ).trim();
}


// ============================================================
// EXTRACT FRIENDS FROM XML
// ============================================================

function extractFriendsFromXml(
    xml
) {

    const friends = [];

    const seen =
        new Set();

    const friendOpenRegex =
        /<friend\b([^>]*?)(?:\/>|>)/gi;

    let match;

    while (
        (match = friendOpenRegex.exec(xml)) !== null
    ) {

        const attrs =
            parseXmlAttributes(
                match[1]
            );

        const cityId =
            cleanString(
                xmlDecodeEntities(
                    attrs.city_id ||
                    attrs.cityId ||
                    ""
                )
            );

        if (!cityId) {
            continue;
        }

        if (
            seen.has(cityId)
        ) {

            continue;
        }

        seen.add(cityId);

        friends.push({

            city_id:
                cityId,

            city_name:
                cleanString(
                    xmlDecodeEntities(
                        attrs.city_name ||
                        attrs.cityName ||
                        ""
                    )
                ),

            name:
                cleanString(
                    xmlDecodeEntities(
                        attrs.name ||
                        ""
                    )
                ),

            level:
                cleanString(
                    attrs.level ||
                    ""
                ),

            fetched_city_ver:
                cleanString(
                    attrs.fetched_city_ver ||
                    "0"
                )
        });
    }

    return friends;
}


// ============================================================
// FIND XML TAG SAFELY
// ============================================================

function extractComponentTags(
    xml
) {

    const tags = [];

    const regex =
        /<OtherPlayerProfilesLogicFeatureComponent\b[\s\S]*?\/?>/gi;

    let match;

    while (
        (match = regex.exec(xml)) !== null
    ) {

        tags.push(
            match[0]
        );
    }

    return tags;
}


// ============================================================
// GET ONE XML ATTRIBUTE
// ============================================================

function getXmlAttribute(
    tagText,
    attributeName
) {

    const regex =
        new RegExp(
            "\\b" +
            attributeName.replace(
                /[.*+?^${}()|[\]\\]/g,
                "\\$&"
            ) +
            "\\s*=\\s*(['\"])([\\s\\S]*?)\\1",
            "i"
        );

    const match =
        regex.exec(
            tagText
        );

    if (!match) {
        return null;
    }

    return match[2];
}


// ============================================================
// EXTRACT ProfilesCache
// ============================================================

function extractProfilesCacheFromXml(
    xml
) {

    const saveIds = [];

    const seen =
        new Set();

    const componentTags =
        extractComponentTags(
            xml
        );

    console.log(
        `[IDs] OtherPlayerProfilesLogicFeatureComponent tags=${componentTags.length}`
    );


    for (
        const tag of componentTags
    ) {

        let raw =
            getXmlAttribute(
                tag,
                "ProfilesCache"
            );

        if (
            raw === null
        ) {

            continue;
        }


        raw =
            xmlDecodeEntities(
                raw
            );


        raw =
            raw.trim();


        if (
            !raw.startsWith("[")
        ) {

            continue;
        }


        let profiles;

        try {

            profiles =
                JSON.parse(
                    raw
                );

        } catch (
            error
        ) {

            console.error(
                "[IDs] ProfilesCache JSON parse failed:",
                error.message
            );

            continue;
        }


        if (
            !Array.isArray(
                profiles
            )
        ) {

            continue;
        }


        for (
            const profile of profiles
        ) {

            if (
                !profile ||
                typeof profile !== "object"
            ) {

                continue;
            }


            const saveId =
                cleanString(
                    profile.saveId
                );


            if (!saveId) {
                continue;
            }


            if (
                seen.has(
                    saveId
                )
            ) {

                continue;
            }


            seen.add(
                saveId
            );


            const name =
                cleanString(
                    profile.cityname ??
                    profile.cityName ??
                    profile.name ??
                    ""
                );


            const level =
                cleanString(
                    profile.level ??
                    ""
                );


            saveIds.push({

                save_id:
                    saveId,

                name:
                    name,

                level:
                    level
            });
        }
    }


    console.log(
        `[IDs] extracted saveIds=${saveIds.length}`
    );

    return saveIds;
}


// ============================================================
// EXTRACT BOTH XML LISTS
// ============================================================

function extractXmlLists(
    xml
) {

    const friends =
        extractFriendsFromXml(
            xml
        );

    const saveIds =
        extractProfilesCacheFromXml(
            xml
        );

    return {
        friends,
        saveIds
    };
}


// ============================================================
// JSON HELPERS
// ============================================================

function firstValue(
    object,
    keys
) {

    for (
        const key of keys
    ) {

        if (
            Object.prototype.hasOwnProperty.call(
                object,
                key
            )
        ) {

            const value =
                object[key];

            if (
                value !== undefined &&
                value !== null
            ) {

                return value;
            }
        }
    }

    return "";
}


// ============================================================
// JSON SAVE RECORDS
// ============================================================

function extractSaveRecords(
    root
) {

    const records = [];

    const seen =
        new Set();


    function visit(
        value,
        inheritedName,
        inheritedLevel
    ) {

        if (
            Array.isArray(value)
        ) {

            for (
                const item of value
            ) {

                visit(
                    item,
                    inheritedName,
                    inheritedLevel
                );
            }

            return;
        }


        if (
            !value ||
            typeof value !== "object"
        ) {

            return;
        }


        const ownName =
            cleanString(
                firstValue(
                    value,
                    [
                        "cityname",
                        "cityName",
                        "city_name",
                        "name",
                        "playerName",
                        "player_name",
                        "username",
                        "nickname"
                    ]
                )
            );


        const ownLevel =
            cleanString(
                firstValue(
                    value,
                    [
                        "level",
                        "Level"
                    ]
                )
            );


        const saveId =
            cleanString(
                firstValue(
                    value,
                    [
                        "saveId",
                        "saveID",
                        "save_id",
                        "saveid"
                    ]
                )
            );


        const name =
            ownName ||
            inheritedName ||
            "";


        const level =
            ownLevel ||
            inheritedLevel ||
            "";


        if (
            saveId
        ) {

            const key =
                [
                    saveId,
                    name,
                    level
                ].join("|");


            if (
                !seen.has(
                    key
                )
            ) {

                seen.add(
                    key
                );


                records.push({

                    save_id:
                        saveId,

                    name:
                        name,

                    level:
                        level,

                    city_id:
                        cleanString(
                            firstValue(
                                value,
                                [
                                    "cityId",
                                    "cityID",
                                    "city_id"
                                ]
                            )
                        ),

                    city_ver:
                        cleanString(
                            firstValue(
                                value,
                                [
                                    "cityVer",
                                    "city_ver",
                                    "fetched_city_ver"
                                ]
                            )
                        )
                });
            }
        }


        for (
            const key of Object.keys(value)
        ) {

            const child =
                value[key];

            if (
                child &&
                typeof child === "object"
            ) {

                visit(
                    child,
                    name,
                    level
                );
            }
        }
    }


    visit(
        root,
        "",
        ""
    );


    return records;
}


// ============================================================
// DECODE FRIENDS API
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
            `[IDs] encrypted file size=${encryptedFile.length}`
        );


        let decoded;

        try {

            decoded =
                decodeFriendFile(
                    encryptedFile
                );

        } catch (
            decodeError
        ) {

            console.error(
                "[IDs] decodeFriendFile ERROR:",
                decodeError &&
                decodeError.stack
                    ? decodeError.stack
                    : decodeError
            );

            return res
                .status(500)
                .json({

                    ok: false,

                    stage:
                        "decode",

                    error:
                        String(
                            decodeError &&
                            decodeError.message
                                ? decodeError.message
                                : decodeError
                        )
                });
        }


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


        // ====================================================
        // XML
        // ====================================================

        if (
            looksLikeXml(
                decoded
            )
        ) {

            const xml =
                trimXml(
                    decoded
                );


            const lists =
                extractXmlLists(
                    xml.toString("utf8")
                );


            console.log(
                `[IDs] friends=${lists.friends.length}`
            );

            console.log(
                `[IDs] saveIds=${lists.saveIds.length}`
            );


            return res
                .status(200)
                .json({

                    ok: true,

                    count:
                        lists.friends.length,

                    friends:
                        lists.friends,

                    saveIds:
                        lists.saveIds
                });
        }


        // ====================================================
        // JSON
        // ====================================================

        const text =
            decoded
                .toString(
                    "utf8"
                )
                .replace(
                    /^\uFEFF/,
                    ""
                )
                .trim();


        let json;

        try {

            json =
                JSON.parse(
                    text
                );

        } catch (
            parseError
        ) {

            return res
                .status(500)
                .json({

                    ok: false,

                    stage:
                        "json_parse",

                    error:
                        "بعد فك الملف لم يتم الحصول على XML أو JSON صالح",

                    parseError:
                        parseError.message
                });
        }


        const records =
            extractSaveRecords(
                json
            );


        const saveIds =
            records.map(
                record => ({

                    save_id:
                        record.save_id,

                    name:
                        record.name,

                    level:
                        record.level
                })
            );


        return res
            .status(200)
            .json({

                ok: true,

                count:
                    records.length,

                ids:
                    records,

                saveIds:
                    saveIds
            });

    } catch (
        err
    ) {

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
// SAVE INFO
// ============================================================

async function handleSaveInfo(
    req,
    res
) {

    try {

        const body =
            req.body ||
            {};


        const saveId =
            cleanString(
                body.saveId ||
                body.save_id
            );


        const cityname =
            cleanString(
                body.cityname ||
                body.cityName ||
                body.name
            );


        const level =
            cleanString(
                body.level
            );


        if (
            !saveId
        ) {

            return res
                .status(400)
                .json({

                    ok: false,

                    error:
                        "saveId مطلوب"
                });
        }


        console.log(
            "[SaveInfo]",
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

                saveId:
                    saveId,

                cityname:
                    cityname,

                level:
                    level
            });

    } catch (
        err
    ) {

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
// BODY PARSERS
// ============================================================

router.use(
    express.json({
        limit: "5mb"
    })
);


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
    "/save-info",
    handleSaveInfo
);


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
// MODULE
// ============================================================

console.log(
    "[FetchCity] module loaded"
);


module.exports =
    router;
