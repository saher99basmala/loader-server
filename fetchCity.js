const express = require("express");
const crypto = require("crypto");
const zlib = require("zlib");
const fetch = require("node-fetch");

const router = express.Router();

/* =========================================================
   CONFIG
========================================================= */

const AES_KEY = Buffer.from(
    process.env.FETCHCITY_AES_KEY || "Wucai6oj0sheiX3p",
    "utf8"
);

const ENDPOINT =
    process.env.FETCHCITY_ENDPOINT ||
    "https://township.playrix.com/api/1/FetchCity?cityId=";

const TIMEOUT_MS =
    Number(process.env.FETCHCITY_TIMEOUT_MS || 25000);

/* =========================================================
   FETCHCITY CONSTANTS
========================================================= */

const TABLE_SIZE = 0x2D7;
const PROCESS_XOR = 0x396A8;
const TOTAL_XOR = 0xC5EED;
const TABLE_MULTIPLIER = 0x5BD1E995;

const LZ4_MAGIC =
    Buffer.from([
        0x04,
        0x22,
        0x4D,
        0x18
    ]);

/* =========================================================
   0x54 TABLE
========================================================= */

const FETCH54_TABLE = Buffer.from(
    "d192KFBTVDZLSDBPSkIwNHh4PlJDMyFrUngqfCsyNV5PU2guWCcmTj5gbTlLZklXb3xTMmpoYmMgZlRkN2FTWjZSQmdRYkwpZlcxMWI8J0dXJ00pTiNsbF5xWntdOmJhakBudjlLZUXlgKDgnJkUyeSo8biZSak9lb2lPRTNbP0lMTys/ZFNAdXxddlZJSGdpdnR3I19ybG9nTD9yY2xKa0EyVjZkSF9hdiB1OWZ3JFZnaiVBdEJHK2RSRSg6bih0SSdiNDc/c3phSU5rbTh7PDdqTCN0O1NKO0knX3ZyVkNveiFvcGg0cC9kdW1UKDZ4ezNRfiZtbWEpJS9+QlJjbm9qeVRmVC55cW4mc2s5ajtheTNwZyssY2NKRz1URXUySy0qZCVJVSpZMk4pLn17VVBfTip4P1pdX2wsXXZ+J21ydkIpdUcuc3cyUCVRK3xOUUxgPklmeUx3ZF0sST9mK2lnOm84cyNMUk15KCQwWTJWelhCRVZ+UXVCZ1J+eVplb2gtY0NAcUA+Ni1WdlQyLFpTV2xVfnRoKyUwfFdfaVBsfU0wdW4/cHlkcXVsYHxaTGB1N3JtMUwwZXd6NGM5KmZuUlpGOjgoOyYlNltHbj4sTFhXOUY/UVE0MSg6NXN2ckdWI3snMyldMi82bG5bc1lkczpxVGRCaDhPeUI8I1EhVSVRJ1tkK3IlKU9CT3V5XSE9fWFnMEdQNlp+YCs5PnJGJmBfOF59Tn5YMDJEKUgjfWFPKTA4dHF4OixPJmZOcHtSJFc+KU1CZUxpfFJYOi56JzVCJWddMTNFZiB5JUs/e1JBcGdrey4xKSxBT1toVXlJLm98cUBwXiBNczFJNyBadWI6YSdPNFknXzA7WG1afnZLPW5KI3dZQ2Njbl5Dekp1NDxmNW9neV19I0s1RklsS25ud1RfXmRWQVpndl1EIFdJdEBzbCFpPSlxeG5XaA==",
    "base64"
);

/* =========================================================
   BASIC UTILITIES
========================================================= */

function u32le(buf, off) {
    return (
        (buf[off] |
            (buf[off + 1] << 8) |
            (buf[off + 2] << 16) |
            (buf[off + 3] << 24)) >>> 0
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

function bufferMagic(buf, magic) {
    if (!Buffer.isBuffer(buf)) {
        return false;
    }

    if (buf.length < magic.length) {
        return false;
    }

    return buf.subarray(
        0,
        magic.length
    ).equals(magic);
}

function isLz4Magic(buf) {
    return bufferMagic(
        buf,
        LZ4_MAGIC
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
    if (!Buffer.isBuffer(buf)) {
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
            .toString(
                "utf8"
            )
            .replace(
                /^\uFEFF/,
                ""
            )
            .trimStart();

    return (
        text.startsWith("<root") ||
        text.startsWith("<?xml")
    );
}

/* =========================================================
   FETCHCITY 0x79
========================================================= */

function build79Table(seed) {
    const table =
        Buffer.alloc(
            TABLE_SIZE
        );

    let value =
        seed >>> 0;

    for (
        let i = 0;
        i < TABLE_SIZE;
        i++
    ) {
        value =
            Math.imul(
                value,
                TABLE_MULTIPLIER
            ) >>> 0;

        value =
            add32(
                value,
                0x6D2B79F5
            );

        table[i] =
            (
                value ^
                (value >>> 16)
            ) & 0xFF;
    }

    return table;
}

function xorDecode79(raw) {
    if (
        !Buffer.isBuffer(raw) ||
        raw.length < 8
    ) {
        throw new Error(
            "0x79 buffer too small"
        );
    }

    if (raw[0] !== 0x79) {
        throw new Error(
            "Invalid 0x79 header"
        );
    }

    const headerValue =
        raw[1] |
        (raw[2] << 8) |
        (raw[3] << 16);

    const total =
        raw.length;

    const derived =
        xor32(
            TOTAL_XOR,
            total
        );

    let processLen =
        xor32(
            headerValue,
            derived
        ) ^
        PROCESS_XOR;

    processLen >>>= 0;

    const maxLen =
        Math.max(
            0,
            total - 8
        );

    if (
        processLen > maxLen
    ) {
        processLen =
            maxLen;
    }

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
            raw.subarray(8)
        );

    const count =
        Math.min(
            processLen,
            out.length
        );

    if (count > 0) {
        out[0] =
            (
                out[0] ^
                table[0]
            ) & 0xFF;

        for (
            let i = 1;
            i < count;
            i++
        ) {
            const current =
                out[i];

            const previous =
                out[i - 1];

            out[i] =
                (
                    (
                        current -
                        previous
                    ) & 0xFF
                ) ^
                table[
                    i % TABLE_SIZE
                ];
        }
    }

    return out;
}

/* =========================================================
   FETCHCITY 0x54
========================================================= */

function decode54Layer(raw) {
    if (
        !Buffer.isBuffer(raw) ||
        raw.length < 3
    ) {
        throw new Error(
            "0x54 buffer too small"
        );
    }

    if (raw[0] !== 0x54) {
        throw new Error(
            "Invalid 0x54 header"
        );
    }

    let processLen =
        (
            raw[1] ^
            FETCH54_TABLE[0]
        ) |
        (raw[2] << 8);

    const maxLen =
        Math.max(
            0,
            raw.length - 3
        );

    if (
        processLen > maxLen
    ) {
        processLen =
            maxLen;
    }

    const out =
        Buffer.from(
            raw.subarray(3)
        );

    const count =
        Math.min(
            processLen,
            out.length
        );

    if (count > 0) {

        out[0] =
            (
                out[0] -
                0x54
            ) & 0xFF;

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

            out[i] ^=
                FETCH54_TABLE[
                    i %
                    FETCH54_TABLE.length
                ];
        }
    }

    return out;
}

/* =========================================================
   TRANSPORT DECODER
========================================================= */

function decodeTransport(raw) {

    if (
        !Buffer.isBuffer(raw) ||
        raw.length === 0
    ) {
        throw new Error(
            "Empty transport data"
        );
    }

    switch (raw[0]) {

        case 0x79:
            return xorDecode79(
                raw
            );

        case 0x54:
            return decode54Layer(
                raw
            );

        case 0x1F:
            return raw;

        default:
            throw new Error(
                "Unknown transport header: 0x" +
                raw[0]
                    .toString(16)
                    .padStart(2, "0")
            );
    }
}

/* =========================================================
   LZ4 BLOCK DECOMPRESSOR
========================================================= */

function lz4DecompressBlock(
    src,
    expectedSize
) {
    const out =
        Buffer.alloc(
            expectedSize
        );

    let srcPos = 0;
    let dstPos = 0;

    while (
        srcPos < src.length &&
        dstPos < expectedSize
    ) {

        const token =
            src[srcPos++];

        let literalLen =
            token >>> 4;

        if (
            literalLen === 15
        ) {

            let b;

            do {
                if (
                    srcPos >=
                    src.length
                ) {
                    throw new Error(
                        "LZ4 literal length overflow"
                    );
                }

                b =
                    src[srcPos++];

                literalLen += b;

            } while (
                b === 255
            );
        }

        if (
            srcPos +
            literalLen >
            src.length
        ) {
            throw new Error(
                "LZ4 literal exceeds input"
            );
        }

        if (
            dstPos +
            literalLen >
            expectedSize
        ) {
            throw new Error(
                "LZ4 literal exceeds output"
            );
        }

        src.copy(
            out,
            dstPos,
            srcPos,
            srcPos +
                literalLen
        );

        srcPos +=
            literalLen;

        dstPos +=
            literalLen;

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
                "LZ4 missing match offset"
            );
        }

        const offset =
            src[srcPos] |
            (src[srcPos + 1] << 8);

        srcPos += 2;

        if (
            offset === 0 ||
            offset > dstPos
        ) {
            throw new Error(
                "Invalid LZ4 offset"
            );
        }

        let matchLen =
            token & 0x0F;

        if (
            matchLen === 15
        ) {

            let b;

            do {
                if (
                    srcPos >=
                    src.length
                ) {
                    throw new Error(
                        "LZ4 match length overflow"
                    );
                }

                b =
                    src[srcPos++];

                matchLen += b;

            } while (
                b === 255
            );
        }

        matchLen += 4;

        if (
            dstPos +
            matchLen >
            expectedSize
        ) {
            throw new Error(
                "LZ4 match exceeds output"
            );
        }

        let matchPos =
            dstPos -
            offset;

        for (
            let i = 0;
            i < matchLen;
            i++
        ) {
            out[dstPos++] =
                out[matchPos++];
        }
    }

    if (
        dstPos !== expectedSize
    ) {
        throw new Error(
            "LZ4 output size mismatch: " +
            dstPos +
            " != " +
            expectedSize
        );
    }

    return out;
}

/* =========================================================
   LZ4 CONTAINER
========================================================= */

function decodeLz4Container(
    raw
) {
    if (
        !isLz4Magic(raw)
    ) {
        throw new Error(
            "Invalid LZ4 container"
        );
    }

    if (
        raw.length < 8
    ) {
        throw new Error(
            "LZ4 container too small"
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

    return lz4DecompressBlock(
        compressed,
        expectedSize
    );
}

/* =========================================================
   XML TRIM
========================================================= */

function trimXml(
    buf
) {
    let xml;

    if (
        Buffer.isBuffer(buf)
    ) {
        xml =
            buf.toString(
                "utf8"
            );
    } else {
        xml =
            String(buf || "");
    }

    xml =
        xml.replace(
            /^\uFEFF/,
            ""
        );

    const end =
        xml.lastIndexOf(
            "</root>"
        );

    if (
        end !== -1
    ) {
        xml =
            xml.substring(
                0,
                end +
                "</root>".length
            );
    }

    return xml.trim();
}

/* =========================================================
   CITY XML EDIT
========================================================= */

function editCityXml(
    xml
) {
    xml =
        String(
            xml || ""
        );

    xml =
        xml.replace(
            /(<Var\b[^>]*\bname=["']cityId["'][^>]*\bvalue=["'])[^"']*(["'][^>]*\/?>)/i,
            "$1$2"
        );

    xml =
        xml.replace(
            /(<Var\b[^>]*\bname=["']Device["'][^>]*\bvalue=["'])[^"']*(["'][^>]*\/?>)/i,
            "$1ASUS_Z01QD$2"
        );

    return xml;
}

/* =========================================================
   COMPLETE CITY DECODER
========================================================= */

function decodeSaveCity(
    cityBytes
) {
    let current =
        Buffer.from(
            cityBytes
        );

    for (
        let layer = 0;
        layer < 8;
        layer++
    ) {

        if (
            looksLikeXml(
                current
            )
        ) {
            return trimXml(
                current
            );
        }

        if (
            isLz4Magic(
                current
            )
        ) {
            current =
                decodeLz4Container(
                    current
                );

            continue;
        }

        if (
            isGzip(
                current
            )
        ) {
            current =
                zlib.gunzipSync(
                    current
                );

            continue;
        }

        if (
            current[0] === 0x79 ||
            current[0] === 0x54 ||
            current[0] === 0x1F
        ) {
            current =
                decodeTransport(
                    current
                );

            continue;
        }

        throw new Error(
            "Unknown city layer: 0x" +
            current[0]
                .toString(16)
                .padStart(2, "0")
        );
    }

    throw new Error(
        "Maximum city decode layers exceeded"
    );
}

/* =========================================================
   CITY XML PARSING
========================================================= */

function xmlAttr(
    tag,
    name
) {
    const re =
        new RegExp(
            "\\b" +
            name +
            "\\s*=\\s*[\"']([^\"']*)[\"']",
            "i"
        );

    const match =
        String(tag).match(
            re
        );

    return match
        ? match[1]
        : "";
}

function parseCityInfo(
    xml
) {
    xml =
        String(
            xml || ""
        );

    let cityId = "";
    let cityName = "";
    let name = "";
    let level = "";
    let cityVer = "";

    /*
      نحاول أولاً من Var / Version / PushNotifDeviceInfo
      لأن بنية city XML قد تختلف بين الإصدارات.
    */

    const cityIdPatterns = [
        /<Var\b[^>]*\bname=["']cityId["'][^>]*\bvalue=["']([^"']*)["']/i,
        /<Var\b[^>]*\bname=["']CityId["'][^>]*\bvalue=["']([^"']*)["']/i,
        /\bcityId=["']([^"']+)["']/i
    ];

    for (
        const pattern of cityIdPatterns
    ) {
        const m =
            xml.match(
                pattern
            );

        if (
            m &&
            m[1]
        ) {
            cityId =
                m[1];

            break;
        }
    }

    const cityNamePatterns = [
        /<Var\b[^>]*\bname=["']cityName["'][^>]*\bvalue=["']([^"']*)["']/i,
        /<Var\b[^>]*\bname=["']CityName["'][^>]*\bvalue=["']([^"']*)["']/i,
        /<Var\b[^>]*\bname=["']city_name["'][^>]*\bvalue=["']([^"']*)["']/i
    ];

    for (
        const pattern of cityNamePatterns
    ) {
        const m =
            xml.match(
                pattern
            );

        if (
            m &&
            m[1]
        ) {
            cityName =
                m[1];

            break;
        }
    }

    const versionMatch =
        xml.match(
            /<Version\b[^>]*\bversion=["']([^"']+)["']/i
        );

    if (
        versionMatch
    ) {
        cityVer =
            versionMatch[1];
    }

    const fverMatch =
        xml.match(
            /<Version\b[^>]*\bFVer=["']([^"']+)["']/i
        );

    /*
      بعض نسخ المدينة تحتوي بيانات المستوى/الاسم
      في أكثر من component، لذلك نبحث بعدة طرق.
    */

    const levelPatterns = [
        /\blvl=["']([^"']+)["']/i,
        /\blevel=["']([^"']+)["']/i,
        /\bLevel=["']([^"']+)["']/i
    ];

    for (
        const pattern of levelPatterns
    ) {
        const m =
            xml.match(
                pattern
            );

        if (
            m &&
            m[1]
        ) {
            level =
                m[1];

            break;
        }
    }

    const namePatterns = [
        /\bpname=["']([^"']*)["']/i,
        /\bcityname=["']([^"']*)["']/i,
        /\bcity_name=["']([^"']*)["']/i
    ];

    for (
        const pattern of namePatterns
    ) {
        const m =
            xml.match(
                pattern
            );

        if (
            m &&
            m[1] &&
            m[1].trim() !== ""
        ) {
            name =
                m[1];

            break;
        }
    }

    /*
      إذا لم نستخرج cityId من Var، نستخدم
      PushNotifDeviceInfo فقط كـ fallback.
    */

    if (
        cityId === ""
    ) {
        const push =
            xml.match(
                /<PushNotifDeviceInfo\b[^>]*\/?>/i
            );

        if (
            push
        ) {
            cityId =
                xmlAttr(
                    push[0],
                    "cityId"
                );
        }
    }

    if (
        cityName === ""
    ) {
        const push =
            xml.match(
                /<PushNotifDeviceInfo\b[^>]*\/?>/i
            );

        if (
            push
        ) {
            cityName =
                xmlAttr(
                    push[0],
                    "pname"
                );
        }
    }

    if (
        level === ""
    ) {
        const push =
            xml.match(
                /<PushNotifDeviceInfo\b[^>]*\/?>/i
            );

        if (
            push
        ) {
            level =
                xmlAttr(
                    push[0],
                    "lvl"
                );
        }
    }

    return {
        city_id: cityId,
        city_name: cityName,
        name: name,
        level: level,
        cityVer: cityVer,
        fver:
            fverMatch
                ? fverMatch[1]
                : ""
    };
}

/* =========================================================
   AES
========================================================= */

function encryptRequest(
    payload
) {
    const iv =
        crypto.randomBytes(
            16
        );

    const cipher =
        crypto.createCipheriv(
            "aes-128-cbc",
            AES_KEY,
            iv
        );

    const encrypted =
        Buffer.concat([
            cipher.update(
                Buffer.from(
                    payload,
                    "utf8"
                )
            ),
            cipher.final()
        ]);

    return Buffer.concat([
        iv,
        encrypted
    ]);
}

function decryptResponse(
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
        data.length < 16
    ) {
        throw new Error(
            "Encrypted response too small"
        );
    }

    const iv =
        data.subarray(
            0,
            16
        );

    const encrypted =
        data.subarray(
            16
        );

    const decipher =
        crypto.createDecipheriv(
            "aes-128-cbc",
            AES_KEY,
            iv
        );

    return Buffer.concat([
        decipher.update(
            encrypted
        ),
        decipher.final()
    ]);
}

/* =========================================================
   RESPONSE DECOMPRESSION
========================================================= */

function decompressResponse(
    data
) {
    let current =
        Buffer.from(
            data
        );

    for (
        let i = 0;
        i < 8;
        i++
    ) {

        if (
            looksLikeXml(
                current
            )
        ) {
            return trimXml(
                current
            );
        }

        if (
            isGzip(
                current
            )
        ) {
            current =
                zlib.gunzipSync(
                    current
                );

            continue;
        }

        if (
            isLz4Magic(
                current
            )
        ) {
            current =
                decodeLz4Container(
                    current
                );

            continue;
        }

        if (
            current[0] === 0x79 ||
            current[0] === 0x54 ||
            current[0] === 0x1F
        ) {
            current =
                decodeTransport(
                    current
                );

            continue;
        }

        break;
    }

    return current;
}

/* =========================================================
   FETCH CITY REQUEST
========================================================= */

async function requestFetchCity(
    cityId,
    cityVer
) {
    const requestBody =
        JSON.stringify({
            cityId: "",
            cityVer:
                Number(cityVer) || 0,
            fetchCityId:
                String(cityId),
            important: true
        });

    const encrypted =
        encryptRequest(
            requestBody
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
                    String(cityId)
                ),
                {
                    method: "POST",

                    headers: {
                        "Content-Type":
                            "application/octet-stream",

                        "ts-id":
                            String(
                                Date.now()
                            )
                    },

                    body:
                        encrypted,

                    signal:
                        controller.signal
                }
            );

        const body =
            await response.buffer();

        if (
            !response.ok
        ) {
            throw new Error(
                "Playrix HTTP " +
                response.status +
                ": " +
                body
                    .subarray(
                        0,
                        1000
                    )
                    .toString(
                        "utf8"
                    )
            );
        }

        return body;

    } finally {

        clearTimeout(
            timer
        );
    }
}

/* =========================================================
   FETCHCITY HANDLER
========================================================= */

async function handleFetchCity(
    req,
    res
) {
    try {

        const body =
            req.body || {};

        const cityId =
            String(
                body.cityId || ""
            ).trim();

        const cityVer =
            Number(
                body.cityVer || 0
            );

        if (
            cityId === ""
        ) {
            return res
                .status(400)
                .json({
                    ok: false,
                    error:
                        "cityId is required"
                });
        }

        const encrypted =
            await requestFetchCity(
                cityId,
                cityVer
            );

        const decrypted =
            decryptResponse(
                encrypted
            );

        const xmlBuffer =
            decompressResponse(
                decrypted
            );

        let xml =
            Buffer.isBuffer(
                xmlBuffer
            )
                ? xmlBuffer.toString(
                      "utf8"
                  )
                : String(
                      xmlBuffer
                  );

        xml =
            trimXml(
                xml
            );

        if (
            !xml.match(
                /^<root\b/i
            )
        ) {
            throw new Error(
                "Decoded response is not XML"
            );
        }

        xml =
            editCityXml(
                xml
            );

        return res
            .status(200)
            .send(
                xml
            );

    } catch (err) {

        console.error(
            "[fetch-city]",
            err
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

/* =========================================================
   NEW:
   DECODE .CITY CACHE FILE
========================================================= */

async function handleDecodeCityCache(
    req,
    res
) {
    try {

        const data =
            req.body;

        if (
            !Buffer.isBuffer(data) ||
            data.length === 0
        ) {
            return res
                .status(400)
                .json({
                    ok: false,
                    error:
                        "Empty .city file"
                });
        }

        console.log(
            "[decode-city-cache] received:",
            data.length,
            "bytes"
        );

        /*
          هنا بالضبط نستخدم نفس decoder
          الموجود أصلًا في السيرفر.

          0x54 موجود داخل decodeSaveCity().
        */

        const xml =
            decodeSaveCity(
                data
            );

        if (
            !xml ||
            !xml.match(
                /^<root\b/i
            )
        ) {
            throw new Error(
                "Decoded .city is not valid XML"
            );
        }

        const info =
            parseCityInfo(
                xml
            );

        /*
          لا نسمح بإرجاع مدينة بدون ID،
          لأن الـLua يحتاج الـID الحقيقي
          المتغير الخاص بالمدينة.
        */

        if (
            !info.city_id
        ) {
            throw new Error(
                "city_id was not found in decoded city XML"
            );
        }

        return res
            .status(200)
            .json({
                ok: true,

                city_id:
                    info.city_id,

                city_name:
                    info.city_name,

                name:
                    info.name,

                level:
                    info.level,

                cityVer:
                    info.cityVer,

                fver:
                    info.fver
            });

    } catch (err) {

        console.error(
            "[decode-city-cache]",
            err
        );

        return res
            .status(400)
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

/* =========================================================
   FRIEND .123.XML DECODER
========================================================= */

function friendMmh2(
    input
) {
    let h =
        0x9747b28c;

    for (
        let i = 0;
        i < input.length;
        i++
    ) {

        h ^= input.charCodeAt(i);

        h =
            Math.imul(
                h,
                0x5bd1e995
            );

        h ^=
            h >>> 13;
    }

    h =
        Math.imul(
            h,
            0x5bd1e995
        );

    h ^=
        h >>> 13;

    return h >>> 0;
}

function friendGetHashTable(
    seed
) {
    const table =
        Buffer.alloc(
            0x2D7
        );

    let x =
        seed >>> 0;

    for (
        let i = 0;
        i < table.length;
        i++
    ) {

        x =
            Math.imul(
                x ^ (x >>> 13),
                0x5bd1e995
            ) >>> 0;

        x =
            (
                x +
                0x6D2B79F5
            ) >>> 0;

        table[i] =
            (
                x ^
                (x >>> 16)
            ) & 0xff;
    }

    return table;
}

function friendXorDecode(
    raw
) {
    if (
        !Buffer.isBuffer(raw) ||
        raw.length < 8
    ) {
        throw new Error(
            "Friend file too small"
        );
    }

    if (
        raw[0] !== 0x79
    ) {
        throw new Error(
            "Invalid friend header"
        );
    }

    const seed =
        u32le(
            raw,
            4
        );

    const table =
        friendGetHashTable(
            seed
        );

    const out =
        Buffer.from(
            raw.subarray(
                8
            )
        );

    for (
        let i = 0;
        i < out.length;
        i++
    ) {
        out[i] ^=
            table[
                i %
                table.length
            ];
    }

    return out;
}

function friendIsLz4(
    buf
) {
    return isLz4Magic(
        buf
    );
}

function friendLz4Decompress(
    buf
) {
    if (
        buf.length < 8
    ) {
        throw new Error(
            "Friend LZ4 too small"
        );
    }

    return decodeLz4Container(
        buf
    );
}

function friendTrimXml(
    buf
) {
    return trimXml(
        buf
    );
}

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
            "Empty friend file"
        );
    }

    if (
        data[0] === 0x3C
    ) {
        return friendTrimXml(
            data
        );
    }

    if (
        data[0] !== 0x79
    ) {
        throw new Error(
            "Unsupported friend file header"
        );
    }

    let current =
        friendXorDecode(
            data
        );

    if (
        friendIsLz4(
            current
        )
    ) {
        current =
            friendLz4Decompress(
                current
            );
    }

    return friendTrimXml(
        current
    );
}

/* =========================================================
   FRIEND VERSION
========================================================= */

function parseFriendVersion(
    xml
) {
    const match =
        String(
            xml || ""
        ).match(
            /<Version\b[^>]*\bversion=["']([^"']*)["'][^>]*\bFVer=["']([^"']*)["']/i
        );

    if (!match) {
        return {
            bver: "",
            fver: ""
        };
    }

    return {
        bver:
            match[1] || "",

        fver:
            match[2] || ""
    };
}

/* =========================================================
   FRIEND PARSER
========================================================= */

function parseFriends(
    xml
) {
    const friends = [];

    const source =
        String(
            xml || ""
        );

    const regex =
        /<friend\b[^>]*\/>|<friend\b[^>]*>[\s\S]*?<\/friend>/gi;

    let match;

    while (
        (match =
            regex.exec(
                source
            ))
    ) {

        const tag =
            match[0];

        const city_id =
            xmlAttr(
                tag,
                "city_id"
            );

        if (
            !city_id
        ) {
            continue;
        }

        friends.push({
            city_id,

            city_name:
                xmlAttr(
                    tag,
                    "city_name"
                ),

            name:
                xmlAttr(
                    tag,
                    "name"
                ),

            level:
                xmlAttr(
                    tag,
                    "level"
                ),

            xp:
                xmlAttr(
                    tag,
                    "xp"
                ),

            likes:
                xmlAttr(
                    tag,
                    "likes"
                ),

            lang:
                xmlAttr(
                    tag,
                    "lang"
                ),

            flw:
                xmlAttr(
                    tag,
                    "flw"
                ),

            help:
                xmlAttr(
                    tag,
                    "help"
                ),

            fetched_city_ver:
                xmlAttr(
                    tag,
                    "fetched_city_ver"
                ),

            bc:
                xmlAttr(
                    tag,
                    "bc"
                )
        });
    }

    return friends;
}

/* =========================================================
   DECODE FRIENDS HANDLER
========================================================= */

async function handleDecodeFriends(
    req,
    res
) {
    try {

        const data =
            req.body;

        if (
            !Buffer.isBuffer(data) ||
            data.length === 0
        ) {
            return res
                .status(400)
                .json({
                    ok: false,
                    error:
                        "Empty friend file"
                });
        }

        const xml =
            decodeFriendFile(
                data
            );

        const version =
            parseFriendVersion(
                xml
            );

        const friends =
            parseFriends(
                xml
            );

        return res
            .status(200)
            .json({
                ok: true,

                bver:
                    version.bver,

                fver:
                    version.fver,

                friends
            });

    } catch (err) {

        console.error(
            "[decode-friends]",
            err
        );

        return res
            .status(400)
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

/* =========================================================
   ROUTES
========================================================= */

router.post(
    "/",
    express.json({
        limit: "5mb"
    }),
    handleFetchCity
);

router.post(
    "/fetch-city",
    express.json({
        limit: "5mb"
    }),
    handleFetchCity
);

/*
  الملف .city يتم إرساله RAW
  وليس JSON.
*/
router.post(
    "/decode-city-cache",
    express.raw({
        type:
            "application/octet-stream",

        limit:
            "50mb"
    }),
    handleDecodeCityCache
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

/* =========================================================
   EXPORT
========================================================= */

module.exports = router;
