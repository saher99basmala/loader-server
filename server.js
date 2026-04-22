const express = require("express");
const fetch = require("node-fetch");

const app = express();
const PORT = process.env.PORT || 3000;

const SECRET = "MY_SECRET_123";
const KEY = "XOR_SECRET_789";

// 🔐 XOR
function xor(buffer, key) {
  const k = Buffer.from(key);
  for (let i = 0; i < buffer.length; i++) {
    buffer[i] ^= k[i % k.length];
  }
  return buffer;
}

app.get("/script", async (req, res) => {

  if (req.query.key !== "12345") {
    return res.send("DENIED");
  }

  if (req.headers["x-secret"] !== SECRET) {
    return res.send("السلام عليكم");
  }

  try {
    const r = await fetch("https://pastebin.com/raw/2ffkvPe8", {
      headers: { "User-Agent": "Mozilla/5.0" }
    });

    let buffer = await r.buffer();

    if (!buffer || buffer.length < 10) {
      return res.send("ERROR");
    }

    // 🔥 تشفير إضافي
    const encrypted = xor(buffer, KEY);

    res.send(encrypted.toString("base64"));

  } catch {
    res.send("ERROR");
  }
});

app.listen(PORT, () => console.log("Server running..."));
