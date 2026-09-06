const express = require("express");
const fetch = require("node-fetch");
const crypto = require("crypto");
const zlib = require("zlib");

const router = express.Router();

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
// SaveCrypto
// ============================================================

const SAVE_TABLE_SIZE = 0x2D7;
const SAVE_C = 0x5BD1E995;
const SAVE_PROCESS_XOR = 0x396A8;
const SAVE_TOTAL_XOR = 0xC5EED;

const LZ4_MAGIC = Buffer.from([
    0x04,
    0x22,
    0x4D,
    0x18
]);


// ------------------------------------------------------------
// unsigned 32-bit
// ------------------------------------------------------------

function u32(value) {
    return value >>> 0;
}


// ------------------------------------------------------------
// U32 little endian
// ------------------------------------------------------------

function readU32LE(buffer, offset) {

    return (
        buffer[offset] |
        (buffer[offset + 1] << 8) |
        (buffer[offset + 2] << 16) |
        (buffer[offset + 3] << 24)
    ) >>> 0;
}


// ============================================================
// SaveCrypto table
// ============================================================

function makeSaveTable(headerValue, seed) {

    const table =
        Buffer.alloc(
            SAVE_TABLE_SIZE
        );

    let r15 =
        u32(
            Math.imul(
                u32(headerValue ^ 4),
                SAVE_C
            )
        );

    let ebp =
        u32(seed);

    let pos = 0;

    while (pos < SAVE_TABLE_SIZE) {

        let eax =
            u32(
                Math.imul(
                    ebp,
                    SAVE_C
                )
            );

        let ecx =
            u32(
                eax ^
                (eax >>> 24)
            );

        eax =
            u32(
                Math.imul(
                    ecx,
                    SAVE_C
                )
            );

        eax =
            u32(
                eax ^
                r15
            );

        ecx =
            u32(
                eax ^
                (eax >>> 13)
            );

        eax =
            u32(
                Math.imul(
                    ecx,
                    SAVE_C
                )
            );

        ebp =
            u32(
                eax ^
                (eax >>> 15)
            );


        if (pos < SAVE_TABLE_SIZE)
            table[pos] =
                ebp & 0xFF;

        if (pos + 1 < SAVE_TABLE_SIZE)
            table[pos + 1] =
                (ebp >>> 8) & 0xFF;

        if (pos + 2 < SAVE_TABLE_SIZE)
            table[pos + 2] =
                (ebp >>> 16) & 0xFF;

        if (pos + 3 < SAVE_TABLE_SIZE)
            table[pos + 3] =
                (ebp >>> 24) & 0xFF;

        pos += 4;
    }

    return table;
}


// ============================================================
// فك طبقة 0x79
// ============================================================

function saveCryptoXorDecode(raw) {

    if (!Buffer.isBuffer(raw)) {
        raw = Buffer.from(raw);
    }

    if (raw.length < 8) {
        throw new Error(
            "SaveCrypto: encrypted data is too short"
        );
    }

    if (raw[0] !== 0x79) {
        throw new Error(
            "SaveCrypto: invalid 0x79 header"
        );
    }


    // --------------------------------------------------------
    // headerValue = 24-bit little endian
    // --------------------------------------------------------

    const headerValue =
        raw[1] |
        (raw[2] << 8) |
        (raw[3] << 16);


    const total =
        raw.length;


    // --------------------------------------------------------
    // derived = TOTAL_XOR XOR total
    // --------------------------------------------------------

    const derived =
        u32(
            SAVE_TOTAL_XOR ^
            total
        );


    // --------------------------------------------------------
    // processLen =
    //
    // ((headerValue - derived) XOR PROCESS_XOR)
    // --------------------------------------------------------

    let processLenU32 =
        u32(
            headerValue -
            derived
        );

    processLenU32 =
        u32(
            processLenU32 ^
            SAVE_PROCESS_XOR
        );


    const available =
        total - 8;

    const processLen =
        Math.min(
            available,
            processLenU32
        );


    if (processLen <= 0) {
        throw new Error(
            "SaveCrypto: invalid process length"
        );
    }


    // --------------------------------------------------------
    // rawSeed
    // --------------------------------------------------------

    const rawSeed =
        readU32LE(
            raw,
            4
        );


    const seed =
        u32(
            rawSeed + 4
        );


    // --------------------------------------------------------
    // Generate table
    // --------------------------------------------------------

    const table =
        makeSaveTable(
            headerValue,
            seed
        );


    // --------------------------------------------------------
    // encrypted body
    // --------------------------------------------------------

    const out =
        Buffer.from(
            raw.subarray(
                8,
                8 + processLen
            )
        );


    // --------------------------------------------------------
    // first byte
    // --------------------------------------------------------

    out[0] =
        (
            out[0] ^
            table[0]
        ) & 0xFF;


    // --------------------------------------------------------
    // remaining bytes
    //
    // delta = current - previousDecoded
    // plain  = delta XOR table
    // --------------------------------------------------------

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
                    i % SAVE_TABLE_SIZE
                ]
            ) & 0xFF;
    }


    return out;
}


// ============================================================
// مقارنة LZ4 magic
// ============================================================

function hasLz4Magic(buffer) {

    if (buffer.length < 4)
        return false;

    return (
        buffer[0] === LZ4_MAGIC[0] &&
        buffer[1] === LZ4_MAGIC[1] &&
        buffer[2] === LZ4_MAGIC[2] &&
        buffer[3] === LZ4_MAGIC[3]
    );
}


// ============================================================
// LZ4 Block Decompressor
// ============================================================

function lz4DecompressBlock(
    compressed,
    expectedSize
) {

    const output =
        Buffer.alloc(
            expectedSize
        );

    let src = 0;
    let dst = 0;


    while (
        src < compressed.length
    ) {

        const token =
            compressed[src++];


        // ----------------------------------------------------
        // literal length
        // ----------------------------------------------------

        let literalLength =
            token >>> 4;


        if (
            literalLength === 15
        ) {

            let byte;

            do {

                if (
                    src >= compressed.length
                ) {
                    throw new Error(
                        "LZ4: invalid literal length"
                    );
                }

                byte =
                    compressed[src++];

                literalLength += byte;

            } while (
                byte === 255
            );
        }


        // ----------------------------------------------------
        // copy literals
        // ----------------------------------------------------

        if (
            src + literalLength >
            compressed.length
        ) {
            throw new Error(
                "LZ4: literal exceeds input"
            );
        }

        if (
            dst + literalLength >
            expectedSize
        ) {
            throw new Error(
                "LZ4: literal exceeds output"
            );
        }


        compressed.copy(
            output,
            dst,
            src,
            src + literalLength
        );


        src +=
            literalLength;

        dst +=
            literalLength;


        // ----------------------------------------------------
        // Last sequence can contain literals only
        // ----------------------------------------------------

        if (
            src >= compressed.length
        ) {
            break;
        }


        // ----------------------------------------------------
        // match offset
        // ----------------------------------------------------

        if (
            src + 2 >
            compressed.length
        ) {
            throw new Error(
                "LZ4: missing match offset"
            );
        }


        const offset =
            compressed[src] |
            (compressed[src + 1] << 8);

        src += 2;


        if (
            offset <= 0 ||
            offset > dst
        ) {
            throw new Error(
                "LZ4: invalid match offset"
            );
        }


        // ----------------------------------------------------
        // match length
        // ----------------------------------------------------

        let matchLength =
            token & 0x0F;


        if (
            matchLength === 15
        ) {

            let byte;

            do {

                if (
                    src >= compressed.length
                ) {
                    throw new Error(
                        "LZ4: invalid match length"
                    );
                }

                byte =
                    compressed[src++];

                matchLength += byte;

            } while (
                byte === 255
            );
        }


        matchLength += 4;


        if (
            dst + matchLength >
            expectedSize
        ) {
            throw new Error(
                "LZ4: match exceeds output"
            );
        }


        // ----------------------------------------------------
        // overlapping copy
        // ----------------------------------------------------

        let matchPos =
            dst - offset;


        for (
            let i = 0;
            i < matchLength;
            i++
        ) {

            output[dst++] =
                output[matchPos++];

        }
    }


    if (
        dst !== expectedSize
    ) {
        throw new Error(
            `LZ4: output size mismatch (${dst}/${expectedSize})`
        );
    }


    return output;
}


// ============================================================
// فك مرحلة LZ4 الخاصة بـ SaveCrypto
// ============================================================

function lz4DecompressSaveStage(stage) {

    if (
        !Buffer.isBuffer(stage)
    ) {
        stage =
            Buffer.from(stage);
    }


    if (
        stage.length < 8
    ) {
        throw new Error(
            "SaveCrypto: LZ4 stage is too short"
        );
    }


    if (
        !hasLz4Magic(stage)
    ) {
        throw new Error(
            "SaveCrypto: invalid LZ4 magic"
        );
    }


    const expectedSize =
        readU32LE(
            stage,
            4
        );


    if (
        expectedSize >
        0x7FFFFFFF
    ) {
        throw new Error(
            "SaveCrypto: invalid XML size"
        );
    }


    const compressed =
        stage.subarray(
            8
        );


    return lz4DecompressBlock(
        compressed,
        expectedSize
    );
}


// ============================================================
// trimXml
// ============================================================

function trimXml(data) {

    const closingTag =
        Buffer.from(
            "</root>",
            "utf8"
        );


    let lastIndex = -1;


    for (
        let i = 0;
        i <= data.length - closingTag.length;
        i++
    ) {

        let match = true;

        for (
            let j = 0;
            j < closingTag.length;
            j++
        ) {

            if (
                data[i + j] !==
                closingTag[j]
            ) {
                match = false;
                break;
            }
        }


        if (match) {
            lastIndex = i;
        }
    }


    if (
        lastIndex >= 0
    ) {

        return data.subarray(
            0,
            lastIndex +
            closingTag.length
        );
    }


    // --------------------------------------------------------
    // fallback: remove trailing zero bytes
    // --------------------------------------------------------

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
// فك SaveCrypto كامل
// ============================================================

function decodeSaveCrypto(raw) {

    if (
        !Buffer.isBuffer(raw)
    ) {
        raw =
            Buffer.from(raw);
    }


    if (
        raw.length === 0
    ) {
        throw new Error(
            "SaveCrypto: empty data"
        );
    }


    // --------------------------------------------------------
    // XML واضح أصلًا
    // --------------------------------------------------------

    if (
        raw[0] !== 0x79
    ) {

        const text =
            raw
                .toString("utf8")
                .trimStart();

        if (
            text.startsWith("<root")
        ) {
            return Buffer.from(
                text,
                "utf8"
            );
        }


        throw new Error(
            "الملف ليس mGameInfo مشفراً بصيغة 0x79 ولا XML واضحاً."
        );
    }


    // --------------------------------------------------------
    // 0x79
    // --------------------------------------------------------

    const stage =
        saveCryptoXorDecode(
            raw
        );


    // --------------------------------------------------------
    // LZ4
    // --------------------------------------------------------

    const xml =
        lz4DecompressSaveStage(
            stage
        );


    // --------------------------------------------------------
    // trim XML
    // --------------------------------------------------------

    return trimXml(
        xml
    );
}


// ============================================================
// أدوات الضغط
// ============================================================

function gzip(data) {
    return zlib.gzipSync(data);
}

function gunzip(data) {
    return zlib.gunzipSync(data);
}


// ============================================================
// تشفير طلب FetchCity
// ============================================================

function encryptRequest(plain) {

    const iv = crypto.randomBytes(12);

    const cipher = crypto.createCipheriv(
        "aes-128-gcm",
        AES_KEY,
        iv
    );

    const ciphertext = Buffer.concat([
        cipher.update(plain),
        cipher.final()
    ]);

    const tag = cipher.getAuthTag();

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
// قراءة ts-id
// ============================================================

function parseTsId(tsId) {

    if (
        !tsId ||
        !tsId.startsWith("002") ||
        tsId.length !== 59
    ) {
        throw new Error("Invalid upstream ts-id");
    }

    return {
        iv: Buffer.from(
            tsId.slice(3, 27),
            "hex"
        ),

        tag: Buffer.from(
            tsId.slice(27, 59),
            "hex"
        )
    };
}


// ============================================================
// فك استجابة FetchCity
// ============================================================

function decryptResponse(body, tsId) {

    const {
        iv,
        tag
    } = parseTsId(tsId);

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
// التحقق
// ============================================================

function validateCityId(cityId) {

    if (
        typeof cityId !== "string" ||
        !/^[A-Za-z0-9_-]{3,64}$/.test(cityId)
    ) {
        throw new Error("Invalid cityId");
    }
}


function validateText(value, name) {

    if (
        typeof value !== "string" ||
        value.trim() === ""
    ) {
        throw new Error(`Missing ${name}`);
    }
}


// ============================================================
// FetchCity
// ============================================================

async function fetchCity({
    cityId,
    cityVer,
    bver,
    fver
}) {

    validateCityId(cityId);

    validateText(
        String(cityVer),
        "cityVer"
    );

    validateText(
        bver,
        "bver"
    );

    validateText(
        fver,
        "fver"
    );


    // نفس JSON المستخدم في التطبيق
    const requestJson =
        `{"cityId":"","cityVer":${cityVer},"fetchCityId":"${cityId}","important":true}`;


    console.log(
        "[FetchCity] cityId:",
        cityId
    );

    console.log(
        "[FetchCity] cityVer:",
        cityVer
    );

    console.log(
        "[FetchCity] bver:",
        bver
    );

    console.log(
        "[FetchCity] fver:",
        fver
    );


    // UTF-8
    const requestBytes =
        Buffer.from(
            requestJson,
            "utf8"
        );


    // GZIP
    const compressed =
        gzip(requestBytes);


    // AES-GCM
    const encrypted =
        encryptRequest(compressed);


    const controller =
        new AbortController();

    const timer =
        setTimeout(
            () => controller.abort(),
            TIMEOUT_MS
        );


    let response;

    try {

        response =
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
                            bver,

                        "ts-fver":
                            fver,

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

    } finally {

        clearTimeout(timer);
    }


    // ========================================================
    // فحص HTTP
    // ========================================================

    if (!response.ok) {

        const text =
            await response
                .text()
                .catch(() => "");

        throw new Error(
            `FetchCity upstream HTTP ${response.status}` +
            (
                text
                    ? `: ${text.slice(0, 500)}`
                    : ""
            )
        );
    }


    // ========================================================
    // ts-id للاستجابة
    // ========================================================

    const responseTsId =
        response.headers.get(
            "ts-id"
        );


    if (!responseTsId) {

        throw new Error(
            "Upstream response has no ts-id"
        );
    }


    // ========================================================
    // Body
    // ========================================================

    const responseBody =
        Buffer.from(
            await response.arrayBuffer()
        );


    // ========================================================
    // فك AES
    // ========================================================

    const decrypted =
        decryptResponse(
            responseBody,
            responseTsId
        );


    // ========================================================
    // فك GZIP
    // ========================================================

    const jsonText =
        gunzip(decrypted)
            .toString("utf8");


    let json;

    try {

        json =
            JSON.parse(
                jsonText
            );

    } catch (e) {

        throw new Error(
            "Invalid decrypted FetchCity JSON response"
        );
    }


    // ========================================================
    // استخراج result.data
    // ========================================================

    const encodedCity =
        json &&
        json.result &&
        json.result.data;


    if (
        typeof encodedCity !== "string" ||
        !encodedCity
    ) {

        throw new Error(
            "FetchCity response does not contain result.data"
        );
    }


    // ========================================================
    // Base64 -> bytes
    // ========================================================

    const cityBytes =
        Buffer.from(
            encodedCity,
            "base64"
        );


    console.log(
        "[FetchCity] received:",
        cityBytes.length,
        "bytes"
    );


    // ========================================================
    // SaveCrypto 0x79 -> LZ4 -> XML
    // ========================================================

    const xmlBytes =
        decodeSaveCrypto(
            cityBytes
        );


    const xml =
        xmlBytes.toString(
            "utf8"
        );


    console.log(
        "[SaveCrypto] decoded XML:",
        xmlBytes.length,
        "bytes"
    );


    return {
        cityId,
        bytes: xmlBytes,
        xml
    };
}


// ============================================================
// POST
// ============================================================
//
// Lua يرسل:
//
// {
//   cityId: "...",
//   cityVer: 123,
//   bver: "...",
//   fver: "..."
// }
//
// ============================================================

router.post("/", async (req, res) => {

    try {

        const cityId =
            String(
                req.body.cityId || ""
            );

        const cityVer =
            String(
                req.body.cityVer ?? "0"
            );

        const bver =
            String(
                req.body.bver || ""
            );

        const fver =
            String(
                req.body.fver || ""
            );


        console.log(
            "[API] FetchCity request:",
            {
                cityId,
                cityVer,
                bver,
                fver
            }
        );


        const result =
            await fetchCity({
                cityId,
                cityVer,
                bver,
                fver
            });


        // ====================================================
        // الآن نعيد XML المفكوك
        // ====================================================

        res.set(
            "Content-Type",
            "application/xml; charset=utf-8"
        );

        res.set(
            "Content-Disposition",
            `attachment; filename="friend_${result.cityId}.xml"`
        );


        return res.send(
            result.bytes
        );


    } catch (e) {

        console.error(
            "[FetchCity ERROR]",
            e
        );


        return res.status(400).json({

            status: "error",

            error:
                e.message
        });
    }
});


module.exports = router;
