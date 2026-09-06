const express = require("express");
const fetch = require("node-fetch");
const crypto = require("crypto");
const zlib = require("zlib");

const router = express.Router();

/* =========================================================
   الإعدادات
   ========================================================= */

const AES_KEY =
  process.env.AES_KEY || "Wucai6oj0sheiX3p";

const UPSTREAM_URL =
  "https://township.playrix.com/api/1/FetchCity?cityId=";

const REQUEST_TIMEOUT = 25000;

/* =========================================================
   SaveCrypto constants
   ========================================================= */

const TABLE_SIZE = 0x2d7; // 727
const C = 0x5bd1e995;
const PROCESS_XOR = 0x396a8;
const TOTAL_XOR = 0xc5eed;

const LZ4_MAGIC = Buffer.from([
  0x04,
  0x22,
  0x4d,
  0x18
]);

/*
 * SaveCrypto.smali
 * FETCH54_TABLE
 */
const FETCH54_TABLE = Buffer.from(
  "d192KFBTVDZLSDBPSkIwNHh4PlJDMyFrUngqfCsyNV5PU2guWCcmTj5gbTlLZklXb3xTMmpoYmMgZlRkN2FTWjZSQmdRYkwpZlcxMWI8J0dXJ00pTiNsbF5xWntdOmJhakBudjlZUXlgKDgnJkUyeSo8biZSak9lb2lPRTNbP0lMTys/ZFNAdXxddlZJSGdpdnR3I19ybG9nTD9yY2xKa0EyVjZkSF9hdiB1OWZ3JFZnaiVBdEJHK2RSRSg6bih0SSdiNDc/c3phSU5rbTh7PDdqTCN0O1NKO0knX3ZyVkNveiFvcGg0cC9kdW1UKDZ4ezNRfiZtbWEpJS9+QlJjbm9qeVRmVC55cW4mc2s5ajtheTNwZyssY2NKRz1URXUySy0qZCVJVSpZMk4pLn17VVBfTip4P1pdX2wsXXZ+J21ydkIpdUcuc3cyUCVRK3xOUUxgPklmeUx3ZF0sST9mK2lnOm84cyNMUk15KCQwWTJWelhCRVZ+UXVCZ1J+eVplb2gtY0NAcUA+Ni1WdlQyLFpTV2xVfnRoKyUwfFdfaVBsfU0wdW4/cHlkcXVsYHxaTGB1N3JtMUwwZXd6NGM5KmZuUlpGOjgoOyYlNltHbj4sTFhXOUY/UVE0MSg6NXN2ckdWI3snMyldMi82bG5bc1lkczpxVGRCaDhPeUI8I1EhVSVRJ1tkK3IlKU9CT3V5XSE9fWFnMEdQNlp+YCs5PnJGJmBfOF59Tn5YMDJEKUgjfWFPKTA4dHF4OixPJmZOcHtSJFc+KU1CZUxpfFJYOi56JzVCJWddMTNFZiB5JUs/e1JBcGdrey4xKSxBT1toVXlJLm98cUBwXiBNczFJNyBadWI6YSdPNFknXzA7WG1afnZLPW5KI3dZQ2Njbl5Dekp1NDxmNW9neV19I0s1RklsS25ud1RfXmRWQVpndl1EIFdJdEBzbCFpPSlxeG5XaA==",
  "base64"
);

/* =========================================================
   أدوات عامة
   ========================================================= */

function u32(n) {
  return Number(BigInt.asUintN(32, BigInt(n)));
}

function readU32LE(buf, offset) {
  if (offset + 4 > buf.length) {
    throw new Error("readU32LE خارج حدود البيانات.");
  }

  return (
    (buf[offset] & 0xff) |
    ((buf[offset + 1] & 0xff) << 8) |
    ((buf[offset + 2] & 0xff) << 16) |
    ((buf[offset + 3] & 0xff) << 24)
  ) >>> 0;
}

function writeU32LE(buf, offset, value) {
  value >>>= 0;

  buf[offset] = value & 0xff;
  buf[offset + 1] = (value >>> 8) & 0xff;
  buf[offset + 2] = (value >>> 16) & 0xff;
  buf[offset + 3] = (value >>> 24) & 0xff;
}

function startsWithAscii(buf, str) {
  const b = Buffer.from(str, "utf8");

  if (buf.length < b.length) {
    return false;
  }

  return buf.subarray(0, b.length).equals(b);
}

function isXml(buf) {
  if (!Buffer.isBuffer(buf) || buf.length === 0) {
    return false;
  }

  const text = buf.toString("utf8").replace(/^\s+/, "");

  return (
    text.startsWith("<root") ||
    text.startsWith("<?xml") ||
    text.startsWith("<")
  );
}

function trimXml(buf) {
  const xmlEnd = Buffer.from("</root>", "utf8");
  const index = buf.lastIndexOf(xmlEnd);

  if (index !== -1) {
    return buf.subarray(0, index + xmlEnd.length);
  }

  let end = buf.length;

  while (
    end > 0 &&
    (buf[end - 1] === 0 ||
      buf[end - 1] === 0x09 ||
      buf[end - 1] === 0x0a ||
      buf[end - 1] === 0x0d ||
      buf[end - 1] === 0x20)
  ) {
    end--;
  }

  return buf.subarray(0, end);
}

/* =========================================================
   SaveCrypto 0x79
   ========================================================= */

function makeSaveTable(headerValue, seed) {
  const table = Buffer.alloc(TABLE_SIZE);

  const r15 = u32(
    BigInt(
      u32(headerValue ^ 4)
    ) * BigInt(C)
  );

  let ebp = u32(seed);

  let pos = 0;

  while (pos < TABLE_SIZE) {
    let eax = u32(
      BigInt(ebp) * BigInt(C)
    );

    let ecx = u32(
      eax ^ (eax >>> 24)
    );

    eax = u32(
      BigInt(ecx) * BigInt(C)
    );

    eax = u32(
      eax ^ r15
    );

    ecx = u32(
      eax ^ (eax >>> 13)
    );

    eax = u32(
      BigInt(ecx) * BigInt(C)
    );

    ebp = u32(
      eax ^ (eax >>> 15)
    );

    for (let n = 0; n < 4 && pos + n < TABLE_SIZE; n++) {
      table[pos + n] =
        (ebp >>> (n * 8)) & 0xff;
    }

    pos += 4;
  }

  return table;
}

function saveCryptoXorDecode(raw) {
  if (raw.length < 8) {
    throw new Error(
      "البيانات المشفرة 0x79 أقصر من الرأس المطلوب."
    );
  }

  if ((raw[0] & 0xff) !== 0x79) {
    throw new Error(
      "البيانات ليست بصيغة SaveCrypto 0x79."
    );
  }

  /*
   * headerValue = bytes 1..3 little endian
   */
  const headerValue =
    (raw[1] & 0xff) |
    ((raw[2] & 0xff) << 8) |
    ((raw[3] & 0xff) << 16);

  const total = raw.length;

  const derived =
    u32(TOTAL_XOR ^ total);

  let processLenU32 =
    u32(headerValue - derived);

  processLenU32 =
    u32(processLenU32 ^ PROCESS_XOR);

  const processLen =
    Math.min(
      total - 8,
      processLenU32
    );

  if (processLen <= 0) {
    throw new Error(
      "طول بيانات SaveCrypto 0x79 غير صالح."
    );
  }

  const rawSeed =
    readU32LE(raw, 4);

  const seed =
    u32(rawSeed + 4);

  const table =
    makeSaveTable(
      headerValue,
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
    (out[0] ^ table[0]) & 0xff;

  for (let i = 1; i < out.length; i++) {
    const delta =
      (out[i] - out[i - 1]) & 0xff;

    out[i] =
      (delta ^ table[i % TABLE_SIZE]) & 0xff;
  }

  return out;
}

/* =========================================================
   LZ4
   ========================================================= */

function hasLz4Magic(buf) {
  return (
    buf.length >= 4 &&
    buf[0] === 0x04 &&
    buf[1] === 0x22 &&
    buf[2] === 0x4d &&
    buf[3] === 0x18
  );
}

/*
 * LZ4 block decompressor
 */
function lz4DecompressBlock(input, expectedSize) {
  const output = Buffer.alloc(expectedSize);

  let ip = 0;
  let op = 0;

  while (ip < input.length) {
    const token = input[ip++];

    let literalLength =
      token >>> 4;

    if (literalLength === 15) {
      let b;

      do {
        if (ip >= input.length) {
          throw new Error(
            "LZ4 literal length غير صالح."
          );
        }

        b = input[ip++];
        literalLength += b;
      } while (b === 255);
    }

    if (
      ip + literalLength >
      input.length
    ) {
      throw new Error(
        "بيانات LZ4 غير مكتملة."
      );
    }

    if (
      op + literalLength >
      output.length
    ) {
      throw new Error(
        "LZ4 تجاوز حجم XML المتوقع."
      );
    }

    input.copy(
      output,
      op,
      ip,
      ip + literalLength
    );

    ip += literalLength;
    op += literalLength;

    if (ip >= input.length) {
      break;
    }

    if (ip + 2 > input.length) {
      throw new Error(
        "LZ4 match offset ناقص."
      );
    }

    const offset =
      input[ip] |
      (input[ip + 1] << 8);

    ip += 2;

    if (
      offset <= 0 ||
      offset > op
    ) {
      throw new Error(
        "LZ4 match offset غير صالح."
      );
    }

    let matchLength =
      token & 0x0f;

    if (matchLength === 15) {
      let b;

      do {
        if (ip >= input.length) {
          throw new Error(
            "LZ4 match length غير صالح."
          );
        }

        b = input[ip++];
        matchLength += b;
      } while (b === 255);
    }

    matchLength += 4;

    if (
      op + matchLength >
      output.length
    ) {
      throw new Error(
        "LZ4 match تجاوز حجم XML المتوقع."
      );
    }

    let ref = op - offset;

    for (
      let i = 0;
      i < matchLength;
      i++
    ) {
      output[op++] =
        output[ref++];
    }
  }

  if (op !== expectedSize) {
    throw new Error(
      `حجم LZ4 الناتج غير مطابق. المتوقع=${expectedSize} الناتج=${op}`
    );
  }

  return output;
}

function lz4DecompressSaveStage(stage) {
  if (!hasLz4Magic(stage)) {
    throw new Error(
      "بيانات LZ4 لا تحتوي على Magic صحيح."
    );
  }

  if (stage.length < 8) {
    throw new Error(
      "مرحلة LZ4 أقصر من الرأس."
    );
  }

  const expectedSize =
    readU32LE(stage, 4);

  if (
    expectedSize >
    0x7fffffff
  ) {
    throw new Error(
      "حجم XML بعد الفك غير منطقي."
    );
  }

  const compressed =
    stage.subarray(8);

  return lz4DecompressBlock(
    compressed,
    expectedSize
  );
}

/* =========================================================
   FetchCity 0x54
   ========================================================= */

function decode54Layer(raw) {
  if (!Buffer.isBuffer(raw)) {
    raw = Buffer.from(raw);
  }

  if (raw.length < 4) {
    throw new Error(
      "بيانات FetchCity 0x54 أقصر من الرأس المطلوب."
    );
  }

  if ((raw[0] & 0xff) !== 0x54) {
    throw new Error(
      "البيانات ليست بصيغة 0x54."
    );
  }

  /*
   * Smali:
   *
   * processLen =
   *     (raw[1] ^ FETCH54_TABLE[0])
   *     | (raw[2] << 8)
   */
  let processLen =
    ((raw[1] & 0xff) ^
      (FETCH54_TABLE[0] & 0xff)) |
    ((raw[2] & 0xff) << 8);

  processLen =
    Math.min(
      processLen,
      raw.length - 3
    );

  /*
   * copyOfRange(raw, 3, raw.length)
   */
  const out =
    Buffer.from(
      raw.subarray(3)
    );

  if (out.length === 0) {
    return out;
  }

  /*
   * out[0] -= 0x54
   */
  out[0] =
    (out[0] - 0x54) & 0xff;

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
    /*
     * i > 0:
     * current - previous
     */
    if (i > 0) {
      out[i] =
        (out[i] - out[i - 1]) & 0xff;
    }

    /*
     * XOR table
     */
    const key =
      FETCH54_TABLE[
        i % FETCH54_TABLE.length
      ] & 0xff;

    out[i] =
      (out[i] ^ key) & 0xff;
  }

  return out;
}

/* =========================================================
   Transport decoder
   ========================================================= */

function decodeTransport(raw) {
  if (!Buffer.isBuffer(raw)) {
    raw = Buffer.from(raw);
  }

  if (raw.length === 0) {
    throw new Error(
      "بيانات FetchCity فارغة."
    );
  }

  const type =
    raw[0] & 0xff;

  switch (type) {
    case 0x79:
      return saveCryptoXorDecode(raw);

    case 0x54:
      return decode54Layer(raw);

    case 0x1f:
      /*
       * SaveCrypto.decodeTransport:
       * 0x1F -> raw unchanged
       */
      return raw;

    default:
      throw new Error(
        `صيغة FetchCity غير مدعومة حالياً: 0x${type
          .toString(16)
          .padStart(2, "0")
          .toUpperCase()}`
      );
  }
}

/* =========================================================
   فك البيانات النهائية
   ========================================================= */

function decodeFetchCityData(raw) {
  if (!Buffer.isBuffer(raw)) {
    raw = Buffer.from(raw);
  }

  if (raw.length === 0) {
    throw new Error(
      "بيانات المدينة فارغة."
    );
  }

  /*
   * XML واضح
   */
  if (isXml(raw)) {
    return trimXml(raw);
  }

  const type =
    raw[0] & 0xff;

  /*
   * 0x79:
   *
   * decodeTransport -> xorDecode
   * ثم الناتج LZ4 stage
   */
  if (type === 0x79) {
    const stage =
      saveCryptoXorDecode(raw);

    if (isXml(stage)) {
      return trimXml(stage);
    }

    if (hasLz4Magic(stage)) {
      const xml =
        lz4DecompressSaveStage(stage);

      return trimXml(xml);
    }

    /*
     * أحياناً قد يكون الناتج gzip
     */
    if (
      stage.length >= 2 &&
      stage[0] === 0x1f &&
      stage[1] === 0x8b
    ) {
      return trimXml(
        zlib.gunzipSync(stage)
      );
    }

    throw new Error(
      `تم فك 0x79 لكن الناتج غير معروف. Magic=${stage.subarray(0, 8).toString("hex")}`
    );
  }

  /*
   * 0x54:
   *
   * decodeTransport -> decode54Layer
   *
   * بعدها نتحقق من شكل الناتج.
   */
  if (type === 0x54) {
    const stage =
      decode54Layer(raw);

    if (isXml(stage)) {
      return trimXml(stage);
    }

    if (hasLz4Magic(stage)) {
      const xml =
        lz4DecompressSaveStage(stage);

      return trimXml(xml);
    }

    if (
      stage.length >= 2 &&
      stage[0] === 0x1f &&
      stage[1] === 0x8b
    ) {
      return trimXml(
        zlib.gunzipSync(stage)
      );
    }

    /*
     * في حالة كان الناتج طبقة أخرى
     * نعرض الـ magic للتشخيص.
     */
    throw new Error(
      `تم فك طبقة 0x54 لكن المرحلة التالية غير معروفة. Magic=${stage.subarray(0, 16).toString("hex")}`
    );
  }

  /*
   * 0x1F:
   * decodeTransport يرجع raw.
   * غالباً gzip.
   */
  if (type === 0x1f) {
    if (
      raw.length >= 2 &&
      raw[0] === 0x1f &&
      raw[1] === 0x8b
    ) {
      return trimXml(
        zlib.gunzipSync(raw)
      );
    }

    if (isXml(raw)) {
      return trimXml(raw);
    }

    throw new Error(
      `بيانات 0x1F ليست XML أو GZIP معروفاً. Magic=${raw.subarray(0, 16).toString("hex")}`
    );
  }

  throw new Error(
    `صيغة البيانات غير مدعومة: 0x${type
      .toString(16)
      .padStart(2, "0")
      .toUpperCase()}`
  );
}

/* =========================================================
   GZIP
   ========================================================= */

function gzip(data) {
  return zlib.gzipSync(data);
}

function gunzip(data) {
  return zlib.gunzipSync(data);
}

/* =========================================================
   AES-GCM
   ========================================================= */

function getAesKey() {
  const key = Buffer.from(
    AES_KEY,
    "utf8"
  );

  if (key.length !== 16) {
    throw new Error(
      "AES_KEY يجب أن يكون 16 بايت."
    );
  }

  return key;
}

function encryptRequest(payload) {
  const key =
    getAesKey();

  const iv =
    crypto.randomBytes(12);

  const cipher =
    crypto.createCipheriv(
      "aes-128-gcm",
      key,
      iv
    );

  const encrypted =
    Buffer.concat([
      cipher.update(payload),
      cipher.final()
    ]);

  const tag =
    cipher.getAuthTag();

  /*
   * ts-id:
   * 002 + IV hex + TAG hex
   */
  const tsId =
    "002" +
    iv.toString("hex") +
    tag.toString("hex");

  return {
    body: Buffer.concat([
      encrypted,
      tag
    ]),
    iv,
    tag,
    tsId
  };
}

function parseTsId(tsId) {
  if (
    typeof tsId !== "string" ||
    !tsId.startsWith("002") ||
    tsId.length !== 59
  ) {
    throw new Error(
      `ts-id غير صالح: ${tsId}`
    );
  }

  const ivHex =
    tsId.slice(3, 27);

  const tagHex =
    tsId.slice(27, 59);

  return {
    iv: Buffer.from(
      ivHex,
      "hex"
    ),
    tag: Buffer.from(
      tagHex,
      "hex"
    )
  };
}

function decryptResponse(data, tsId) {
  const key =
    getAesKey();

  const {
    iv,
    tag
  } = parseTsId(tsId);

  if (data.length < 16) {
    throw new Error(
      "استجابة AES قصيرة جداً."
    );
  }

  /*
   * التطبيق يرسل encrypted + tag
   */
  const ciphertext =
    data.subarray(
      0,
      data.length - 16
    );

  const responseTag =
    data.subarray(
      data.length - 16
    );

  /*
   * استخدم tag الموجود في الاستجابة
   */
  const decipher =
    crypto.createDecipheriv(
      "aes-128-gcm",
      key,
      iv
    );

  decipher.setAuthTag(
    responseTag
  );

  return Buffer.concat([
    decipher.update(ciphertext),
    decipher.final()
  ]);
}

/* =========================================================
   HTTP helpers
   ========================================================= */

async function fetchWithTimeout(
  url,
  options,
  timeout
) {
  const controller =
    new AbortController();

  const timer =
    setTimeout(
      () => controller.abort(),
      timeout
    );

  try {
    return await fetch(
      url,
      {
        ...options,
        signal:
          controller.signal
      }
    );
  } finally {
    clearTimeout(timer);
  }
}

/* =========================================================
   FetchCity
   ========================================================= */

async function fetchCity({
  cityId,
  cityVer,
  bver,
  fver
}) {
  if (!cityId) {
    throw new Error(
      "cityId مفقود."
    );
  }

  cityVer =
    Number.isFinite(Number(cityVer))
      ? Number(cityVer)
      : 0;

  const payload =
    Buffer.from(
      JSON.stringify({
        cityId: "",
        cityVer,
        fetchCityId: cityId,
        important: true
      }),
      "utf8"
    );

  /*
   * gzip
   */
  const gzipped =
    gzip(payload);

  /*
   * AES-GCM
   */
  const encrypted =
    encryptRequest(gzipped);

  const url =
    UPSTREAM_URL +
    encodeURIComponent(cityId);

  const headers = {
    "Accept-Encoding":
      "identity",

    "Content-Type":
      "application/octet-stream",

    "User-Agent":
      "okhttp/4.9.0",

    "ts-bp":
      "i",

    "ts-bver":
      String(bver || ""),

    "ts-fver":
      String(fver || ""),

    "ts-gpid":
      crypto
        .randomBytes(8)
        .toString("hex"),

    "ts-id":
      encrypted.tsId
  };

  const response =
    await fetchWithTimeout(
      url,
      {
        method: "POST",
        headers,
        body: encrypted.body
      },
      REQUEST_TIMEOUT
    );

  const responseBytes =
    Buffer.from(
      await response.arrayBuffer()
    );

  if (!response.ok) {
    let text =
      responseBytes.toString(
        "utf8"
      );

    throw new Error(
      `Upstream HTTP ${response.status}: ${text.slice(0, 1000)}`
    );
  }

  /*
   * فك AES-GCM
   */
  const decrypted =
    decryptResponse(
      responseBytes,
      encrypted.tsId
    );

  /*
   * فك gzip
   */
  let jsonBytes;

  if (
    decrypted.length >= 2 &&
    decrypted[0] === 0x1f &&
    decrypted[1] === 0x8b
  ) {
    jsonBytes =
      gunzip(decrypted);
  } else {
    jsonBytes =
      decrypted;
  }

  let json;

  try {
    json =
      JSON.parse(
        jsonBytes.toString(
          "utf8"
        )
      );
  } catch (e) {
    throw new Error(
      `تعذر قراءة JSON من FetchCity: ${e.message}`
    );
  }

  if (
    !json ||
    !json.result ||
    typeof json.result.data !==
      "string"
  ) {
    throw new Error(
      "استجابة FetchCity لا تحتوي result.data."
    );
  }

  /*
   * result.data = Base64
   */
  let cityBytes;

  try {
    cityBytes =
      Buffer.from(
        json.result.data,
        "base64"
      );
  } catch (e) {
    throw new Error(
      `تعذر فك Base64 الخاص بالمدينة: ${e.message}`
    );
  }

  if (cityBytes.length === 0) {
    throw new Error(
      "result.data بعد Base64 فارغة."
    );
  }

  /*
   * هنا النقطة المهمة:
   *
   * 0x79
   * 0x54
   * 0x1F
   * XML
   */
  const xml =
    decodeFetchCityData(
      cityBytes
    );

  return {
    xml,
    cityBytes
  };
}

/* =========================================================
   POST /api/fetch-city
   ========================================================= */

router.post(
  "/fetch-city",
  express.json({
    limit: "1mb"
  }),
  async (req, res) => {
    try {
      const {
        cityId,
        cityVer,
        bver,
        fver
      } = req.body || {};

      if (!cityId) {
        return res
          .status(400)
          .json({
            status: "error",
            error:
              "cityId مفقود."
          });
      }

      console.log(
        `[FetchCity] cityId=${cityId} cityVer=${cityVer} bver=${bver} fver=${fver}`
      );

      const result =
        await fetchCity({
          cityId,
          cityVer,
          bver,
          fver
        });

      console.log(
        `[FetchCity] OK cityId=${cityId} xml=${result.xml.length} bytes`
      );

      res.status(200);

      res.set(
        "Content-Type",
        "application/xml; charset=utf-8"
      );

      res.set(
        "Content-Disposition",
        `attachment; filename="friend_${cityId}.xml"`
      );

      return res.send(
        result.xml
      );

    } catch (e) {
      console.error(
        "[FetchCity ERROR]",
        e
      );

      return res
        .status(400)
        .json({
          status: "error",
          error:
            e &&
            e.message
              ? e.message
              : String(e)
        });
    }
  }
);

/* =========================================================
   Health
   ========================================================= */

router.get(
  "/health",
  (req, res) => {
    res.json({
      status: "ok",
      service: "fetch-city",
      fetch54Table:
        FETCH54_TABLE.length,
      tableSize:
        TABLE_SIZE
    });
  }
);

/* =========================================================
   Export
   ========================================================= */

module.exports = router;
