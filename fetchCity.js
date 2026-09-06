/*

fetchCity.js

يحافظ على طلب FetchCity القديم

AES-128-GCM كما في النسخة العاملة

ts-gpid = new

نفس JSON القديم

نفس headers

نفس ts-id

body = ciphertext فقط

فك AES من ts-id الخاص بالاستجابة

محاولة GZIP / ZLIB / RAW DEFLATE

ثم استخراج result.data

Base64

SaveCrypto 0x79 / 0x54 / 0x1F

LZ4

تعديل XML بعد فك جميع الطبقات

إرجاع XML

التعديلات:

Var cityId يصبح فارغاً

Var Device يصبح ASUS_Z01QD

لا يغيّر بقية السيرفر.

*/

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
"d192KFBTVDZLSDBPSkIwNHh4PlJDMyFrUngqfCsyNV5PU2guWCcmTj5gbTlLZklXb3xTMmpoYmMgZlRkN2FTWjZSQmdRYkwpZlcxMWI8J0dXJ00pTiNsbF5xWntdOmJhakBudjlLZUXlgKDgnJkUyeSo8biZSak9lb2lPRTNbP0lMTys/ZFNAdXxddlZJSGdpdnR3I19ybG9nTD9yY2xKa0EyVjZkSF9hdiB1OWZ3JFZnaiVBdEJHK2RSRSg6bih0SSdiNDc/c3phSU5rbTh7PDdqTCN0O1NKO0knX3ZyVkNveiFvcGg0cC9kdW1UKDZ4ezNRfiZtbWEpJS9+QlJjbm9qeVRmVC55cW4mc2s5ajtheTNwZyssY2NKRz1URXUySy0qZCVJVSpZMk4pLn17VVBfTip4P1pdX2wsXXZ+J21ydkIpdUcuc3cyUCVRK3xOUUxgPklmeUx3ZF0sST9mK2lnOm84cyNMUk15KCQwWTJWelhCRVZ+UXVCZ1J+eVplb2gtY0NAcUA+Ni1WdlQyLFpTV2xVfnRoKyUwfFdfaVBsfU0wdW4/cHlkcXVsYHxaTGB1N3JtMUwwZXd6NGM5KmZuUlpGOjgoOyYlNltHbj4sTFhXOUY/UVE0MSg6NXN2ckdWI3snMyldMi82b5lbXzpxVGRCaDhPeUI8I1EhVSVRJ1tkK3IlKU9CT3V5XSE9fWFnMEdQNlp+YCs5PnJGJmBfOF59Tn5YMDJEKUgjfWFPKTA4dHF4OixPJmZOcHtSJFc+KU1CZUxpfFJYOi56JzVCJWddMTNFZiB5JUs/e1JBcGdrey4xKSxBT1toVXlJLm98cUBwXiBNczFJNyBadWI6YSdPNFknXzA7WG1afnZLPW5KI3dZQ2Njbl5Dekp1NDxmNW9neV19I0s1RklsS25ud1RfXmRWQVpndl1EIFdJdEBzbCFpPSlxeG5XaA==",
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
x => x.toString(16).padStart(2, "0")
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
Math.min(buf.length, 512)
)
.toString("utf8")
.trimStart();

return (
text.startsWith("<") ||
text.startsWith("<?xml")
);

}

// ============================================================
// 0x79 TABLE
// ============================================================

function build79Table(seed) {

const table =
Buffer.alloc(TABLE_SIZE);

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

// ============================================================
// 0x79 DECODER
// ============================================================

function xorDecode79(raw) {

if (!Buffer.isBuffer(raw)) {
raw = Buffer.from(raw);
}

if (raw.length < 8) {
throw new Error(
بيانات 0x79 قصيرة: ${raw.length}
);
}

const headerValue =
u32le(raw, 1);

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
u32le(raw, 4);

const seed =
add32(
rawSeed,
4
);

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
// 0x54 DECODER
// ============================================================

function decode54Layer(raw) {

if (!Buffer.isBuffer(raw)) {
raw = Buffer.from(raw);
}

if (raw.length < 4) {
throw new Error(
بيانات 0x54 قصيرة: ${raw.length}
);
}

if (raw[0] !== 0x54) {
throw new Error(
بيانات 0x54 غير صحيحة. Magic=${bufferMagic(raw)}
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
            i % FETCH54_TABLE.length    
        ]    
    ) & 0xFF;

}

return out;

}

// ============================================================
// TRANSPORT DECODER
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
[FetchCity] SaveCrypto type=0x${type     .toString(16)     .padStart(2, "0")}
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
        `صيغة FetchCity غير مدعومة حالياً: 0x${type    
            .toString(16)    
            .padStart(2, "0")}`    
    );

}

}

// ============================================================
// LZ4 BLOCK
// ============================================================

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

// --------------------------------    
// Literal length    
// --------------------------------    

let literalLength =    
    token >>> 4;    

if (literalLength === 15) {    

    let value;    

    do {    

        if (    
            srcPos >=    
            src.length    
        ) {    
            throw new Error(    
                "LZ4: literal length خارج البيانات"    
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
        "LZ4: literals خارج البيانات"    
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
    srcPos + literalLength    
);    

srcPos +=    
    literalLength;    

dstPos +=    
    literalLength;    

// آخر sequence    
if (    
    srcPos >= src.length    
) {    
    break;    
}    

// --------------------------------    
// Match offset    
// --------------------------------    

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

// --------------------------------    
// Match length    
// --------------------------------    

let matchLength =    
    token & 0x0F;    

if (matchLength === 15) {    

    let value;    

    do {    

        if (    
            srcPos >=    
            src.length    
        ) {    
            throw new Error(    
                "LZ4: match length خارج البيانات"    
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
LZ4: الحجم الناتج غير متطابق. expected=${expectedSize}, actual=${dstPos}
);
}

return output;

}

// ============================================================
// LZ4 CONTAINER
// ============================================================

function decodeLz4Container(raw) {

if (!isLz4Magic(raw)) {
throw new Error(
LZ4 magic غير صحيح: ${bufferMagic(raw)}
);
}

if (raw.length < 8) {
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
raw.subarray(8);

console.log(
[FetchCity] LZ4 expectedSize=${expectedSize}, compressed=${compressed.length}
);

return lz4DecompressBlock(
compressed,
expectedSize
);

}

// ============================================================
// XML TRIM
// ============================================================

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
        rootEnd +    
        "</root>".length    
    ),    
    "utf8"    
);

}

let end =
buf.length;

while (end > 0) {

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

// ============================================================
// XML EDITOR
// ============================================================

function editCityXml(xml) {

if (!Buffer.isBuffer(xml)) {
xml = Buffer.from(xml);
}

let text =
xml.toString("utf8");

// --------------------------------------------------------
// cityId
// أي:
//
// <Var name="cityId" v="iwnfGnr9SP"/>
//
// تصبح:
//
// <Var name="cityId" v=""/>
// --------------------------------------------------------

text =
text.replace(
/(<Var\s+name=["']cityId["']\s+v=["'])[^"']*(["'])/g,
"$1$2"
);

// --------------------------------------------------------
// Device
// أي قيمة:
//
// <Var name="Device" v="Infinix X6812"/>
//
// تصبح دائماً:
//
// <Var name="Device" v="ASUS_Z01QD"/>
// --------------------------------------------------------

text =
text.replace(
/(<Var\s+name=["']Device["']\s+v=["'])[^"']*(["'])/g,
"$1ASUS_Z01QD$2"
);

console.log(
"[FetchCity] XML modifications applied: cityId cleared, Device=ASUS_Z01QD"
);

return Buffer.from(
text,
"utf8"
);

}

// ============================================================
// COMPLETE SAVE DECODER
// ============================================================

function decodeSaveCity(cityBytes) {

let data =
Buffer.from(cityBytes);

console.log(
[FetchCity] cityBytes=${data.length} magic=${bufferMagic(data)}
);

let rounds = 0;

while (
data.length > 0 &&
rounds < 8
) {

rounds++;    

// --------------------------------    
// XML    
// --------------------------------    

if (looksLikeXml(data)) {    

    console.log(    
        `[FetchCity] XML detected after ${rounds - 1} layer(s)`    
    );    

    return trimXml(data);    
}    

// --------------------------------    
// LZ4    
// --------------------------------    

if (isLz4Magic(data)) {    

    console.log(    
        "[FetchCity] LZ4 container detected"    
    );    

    data =    
        decodeLz4Container(    
            data    
        );    

    continue;    
}    

// --------------------------------    
// GZIP    
// --------------------------------    

if (isGzip(data)) {    

    console.log(    
        "[FetchCity] GZIP detected"    
    );    

    data =    
        zlib.gunzipSync(    
            data    
        );    

    continue;    
}    

// --------------------------------    
// SaveCrypto    
// --------------------------------    

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
    `تم فك طبقات FetchCity لكن المرحلة التالية غير معروفة. Magic=${bufferMagic(data)}`    
);

}

if (looksLikeXml(data)) {
return trimXml(data);
}

throw new Error(
تعذر الوصول إلى XML. Magic=${bufferMagic(data)}
);

}

// ============================================================
// ENCRYPT REQUEST
// ============================================================

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
cipher.update(
plaintext
),
cipher.final()
]);

const tag =
cipher.getAuthTag();

/*

مهم:

body = ciphertext فقط

tag داخل ts-id
*/


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
// DECRYPT RESPONSE
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
ts-id غير صالح: ${tsId}
);
}

const hex =
tsId.slice(3);

if (
hex.length <
24 + 32
) {
throw new Error(
ts-id قصير: ${tsId}
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
decipher.update(body),
decipher.final()
]);

}

// ============================================================
// FLEXIBLE RESPONSE DECOMPRESSION
// ============================================================

function decompressResponse(
decrypted
) {

console.log(
[FetchCity] decrypted size=${decrypted.length}
);

console.log(
[FetchCity] decrypted magic=${bufferMagic(decrypted)}
);

// --------------------------------
// GZIP
// --------------------------------

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

// --------------------------------
// ZLIB
// --------------------------------

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

// --------------------------------
// RAW DEFLATE
// --------------------------------

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

// --------------------------------
// Plain JSON
// --------------------------------

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
magic=${bufferMagic(decrypted)}  +
size=${decrypted.length}
);

}

// ============================================================
// REQUEST FETCHCITY
// ============================================================

async function requestFetchCity(
cityId,
cityVer
) {

const requestJson =
{"cityId":"","cityVer":${cityVer},"fetchCityId":"${cityId}","important":true};

console.log(
[FetchCity] request cityId=${cityId} cityVer=${cityVer}
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

                /*    
                 * القيمة القديمة العاملة    
                 */    
                "ts-gpid":    
                    "new",    

                "ts-id":    
                    encrypted.tsId    
            },    

            /*    
             * لا نضيف GCM tag هنا    
             */    
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

// --------------------------------    
// Upstream error    
// --------------------------------    

if (!response.ok) {    

    const text =    
        responseBody.toString(    
            "utf8"    
        );    

    throw new Error(    
        `Upstream HTTP ${response.status}: ${text}`    
    );    
}    

// --------------------------------    
// Response ts-id    
// --------------------------------    

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

// --------------------------------    
// AES-GCM    
// --------------------------------    

const decrypted =    
    decryptResponse(    
        responseBody,    
        responseTsId    
    );    

// --------------------------------    
// Compression    
// --------------------------------    

const uncompressed =    
    decompressResponse(    
        decrypted    
    );    

// --------------------------------    
// JSON    
// --------------------------------    

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

clearTimeout(timer);

}

}

// ============================================================
// HANDLE FETCHCITY
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
            "cityId مطلوب"    
        );    
}    

if (    
    !Number.isFinite(cityVer) ||    
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

// ================================================    
// الطلب القديم    
// ================================================    

const json =    
    await requestFetchCity(    
        cityId,    
        cityVer    
    );    

// ================================================    
// result.data    
// ================================================    

if (    
    !json ||    
    !json.result ||    
    typeof json.result.data !== "string"    
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

// ================================================    
// Base64    
// ================================================    

const cityBytes =    
    Buffer.from(    
        base64,    
        "base64"    
    );    

console.log(    
    `[FetchCity] decoded Base64 bytes=${cityBytes.length} magic=${bufferMagic(cityBytes)}`    
);    

// ================================================    
// SaveCrypto    
// ================================================    

const xml =    
    decodeSaveCity(    
        cityBytes    
    );    

console.log(    
    `[FetchCity] XML size=${xml.length}`    
);    

// ================================================    
// تعديل XML    
// ================================================    

const modifiedXml =    
    editCityXml(    
        xml    
    );    

console.log(    
    `[FetchCity] Modified XML size=${modifiedXml.length}`    
);    

// ================================================    
// Return XML    
// ================================================    

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
// ROUTES
// ============================================================

/*

مع:

app.use("/api", fetchCity)

يعمل:

POST /api/

POST /api/fetch-city
*/

router.post(
"/",
handleFetchCity
);

router.post(
"/fetch-city",
handleFetchCity
);

// ============================================================
// EXPORT
// ============================================================

console.log(
"[FetchCity] module loaded"
);

module.exports = router;
