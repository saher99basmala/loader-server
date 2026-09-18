/**
 * Binary helpers for the supplied CryptoEngine boundary.
 *
 * The supplied engine exposes encode/decode around a custom XOR/hash/LZ4 format.
 * This module deliberately keeps that boundary explicit. XML text processing
 * does not invoke it unless the request supplies encoded bytes.
 */
"use strict";
const zlib = require("node:zlib");

function decodeBase64(input) {
  return Buffer.from(String(input), "base64");
}

function encodeBase64(buf) {
  return Buffer.from(buf).toString("base64");
}

function compress(buffer) {
  return zlib.deflateRawSync(Buffer.from(buffer));
}

function decompress(buffer) {
  return zlib.inflateRawSync(Buffer.from(buffer));
}

module.exports = { decodeBase64, encodeBase64, compress, decompress };
