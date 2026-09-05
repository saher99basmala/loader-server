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


// ==========================
// GZIP
// ==========================

function gzip(data) {
    return zlib.gzipSync(data);
}

function gunzip(data) {
    return zlib.gunzipSync(data);
}


// ==========================
// AES-128-GCM REQUEST
// ==========================

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


// ==========================
// TS-ID PARSER
// ==========================

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


// ==========================
// AES-128-GCM RESPONSE
// ==========================

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


// ==========================
// VALIDATION
// ==========================

function validateInput(value, name) {

    if (
        typeof value !== "string" ||
        value.trim() === ""
    ) {
        throw new Error(
            `Missing ${name}`
        );
    }
}


function validateCityId(cityId) {

    if (
        !/^[A-Za-z0-9_-]{3,64}$/.test(cityId)
    ) {
        throw new Error(
            "Invalid cityId"
        );
    }
}


// ==========================
// FETCH CITY
// ==========================

async function fetchCity({
    cityId,
    cityVer,
    bver,
    fver
}) {

    validateCityId(cityId);

    validateInput(
        String(cityVer),
        "cityVer"
    );

    validateInput(
        bver,
        "bver"
    );

    validateInput(
        fver,
        "fver"
    );


    // نفس JSON الموجود في Android
    const requestJson =
        `{"cityId":"","cityVer":${cityVer},"fetchCityId":"${cityId}","important":true}`;


    const requestBytes =
        Buffer.from(
            requestJson,
            "utf8"
        );


    // GZIP
    const compressed =
        gzip(requestBytes);


    // AES-128-GCM
    const encrypted =
        encryptRequest(
            compressed
        );


    // ==========================
    // REQUEST TO UPSTREAM
    // ==========================

    const controller =
        new AbortController();

    const timer =
        setTimeout(
            () => controller.abort(),
            TIMEOUT_MS
        );


    let response;

    try {

        response = await fetch(
            ENDPOINT +
            encodeURIComponent(cityId),
            {
                method: "POST",

                headers: {
                    "Accept-Encoding": "identity",

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


    // ==========================
    // HTTP STATUS
    // ==========================

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


    // ==========================
    // RESPONSE TS-ID
    // ==========================

    const responseTsId =
        response.headers.get(
            "ts-id"
        );


    if (!responseTsId) {

        throw new Error(
            "Upstream response has no ts-id"
        );
    }


    // ==========================
    // RESPONSE BODY
    // ==========================

    const responseBody =
        Buffer.from(
            await response.arrayBuffer()
        );


    // AES-GCM decrypt
    const decrypted =
        decryptResponse(
            responseBody,
            responseTsId
        );


    // GZIP decompress
    const jsonText =
        gunzip(
            decrypted
        ).toString(
            "utf8"
        );


    // ==========================
    // JSON
    // ==========================

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


    // ==========================
    // result.data
    // ==========================

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


    // ==========================
    // BASE64 DECODE ONLY
    // ==========================
    //
    // لا نفك SaveCrypto.
    // الملف الداخلي يبقى كما استلمه العميل.
    //

    const cityBytes =
        Buffer.from(
            encodedCity,
            "base64"
        );


    return {
        cityId,
        bytes: cityBytes,
        encodedCity,
        upstream: json
    };
}


// ==========================
// GET /api/fetch-city
// ==========================

router.get("/", async (req, res) => {

    try {

        const result =
            await fetchCity({

                cityId:
                    String(
                        req.query.cityId || ""
                    ),

                cityVer:
                    String(
                        req.query.cityVer || ""
                    ),

                bver:
                    String(
                        req.query.bver || ""
                    ),

                fver:
                    String(
                        req.query.fver || ""
                    )
            });


        res.set(
            "Content-Type",
            "application/octet-stream"
        );

        res.set(
            "Content-Disposition",
            `attachment; filename="${result.cityId}.bin"`
        );

        return res.send(
            result.bytes
        );

    } catch (e) {

        console.error(
            "FetchCity error:",
            e
        );

        return res.status(400).json({

            status: "error",

            error:
                e.message
        });
    }
});


// ==========================
// POST /api/fetch-city
// ==========================

router.post("/", async (req, res) => {

    try {

        const result =
            await fetchCity({

                cityId:
                    String(
                        req.body.cityId || ""
                    ),

                cityVer:
                    String(
                        req.body.cityVer || ""
                    ),

                bver:
                    String(
                        req.body.bver || ""
                    ),

                fver:
                    String(
                        req.body.fver || ""
                    )
            });


        res.set(
            "Content-Type",
            "application/octet-stream"
        );

        res.set(
            "Content-Disposition",
            `attachment; filename="${result.cityId}.bin"`
        );

        return res.send(
            result.bytes
        );

    } catch (e) {

        console.error(
            "FetchCity error:",
            e
        );

        return res.status(400).json({

            status: "error",

            error:
                e.message
        });
    }
});


// ==========================
// EXPORT
// ==========================

module.exports = router;
