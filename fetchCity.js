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
    //
    // هنا نتوقف.
    // لا نفك SaveCrypto.
    // نعيد الملف كما يستلمه التطبيق بعد Base64.
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


    return {
        cityId,
        bytes: cityBytes
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


        res.set(
            "Content-Type",
            "application/octet-stream"
        );

        res.set(
            "Content-Disposition",
            `attachment; filename="friend_${result.cityId}.bin"`
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
