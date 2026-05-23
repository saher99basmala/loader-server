const express = require("express");
const fetch = require("node-fetch");

const app = express();
const PORT = process.env.PORT || 3000;

const SECRET = "MY_SECRET_123";
const KEY = "XOR_SECRET_789";

function xor(buffer, key) {
  const k = Buffer.from(key);

  for (let i = 0; i < buffer.length; i++) {
    buffer[i] ^= k[i % k.length];
  }

  return buffer;
}

app.get("/script", async (req, res) => {

  if (req.query.key !== "12345") {
    return res.send('gg.alert("اسكربت الجامع\\nقريباً!")');
  }

  if (req.headers["x-secret"] !== SECRET) {
    return res.send('gg.alert("اسكربت الجامع\\nقريباً!")');
  }

  try {

    const r = await fetch(
      "ضع_رابط_الملف_الحقيقي_هنا"
    );

    let buffer = await r.buffer();

    if (!buffer || buffer.length < 10) {
      return res.send("ERROR");
    }

    const encrypted = xor(buffer, KEY);

    res.send(encrypted.toString("base64"));

  } catch {

    res.send("ERROR");

  }

});

app.listen(PORT, () => {
  console.log("Server running...");
});
