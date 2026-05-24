const express = require("express");
const fetch = require("node-fetch");

const app = express();
const view = require("./view");

const PORT = process.env.PORT || 3000;

const SECRET = "MY_SECRET_123";
const KEY = "XOR_SECRET_789";

app.use("/", view);

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
    return res.send("تم سحب جميع معلومات جهازك😉");
  }

  try {

    let buffer = Buffer.from(
`gg.alert("ايوجد تحديث")`
    );

    if (!buffer || buffer.length < 10) {
      return res.send("ERROR");
    }

    const encrypted = xor(buffer, KEY);

    res.send(encrypted.toString("base64"));

  } catch {
    res.send("ERROR");
  }
});

app.listen(PORT, () => console.log("Server running..."));
