const express = require("express");
const fetch = require("node-fetch");

const app = express();
const PORT = process.env.PORT || 3000;

// 🔐 مفتاح سري
const SECRET = "MY_SECRET_123";

app.get("/script", async (req, res) => {

  // 🔐 تحقق من المفتاح العادي
  if (req.query.key !== "12345") {
    return res.send("DENIED");
  }

  // 🔐 تحقق من الهيدر السري
  const secretHeader = req.headers["x-secret"];

  if (secretHeader !== SECRET) {
    return res.send("السلام عليكم");
  }

  try {
    const r = await fetch("https://pastebin.com/raw/F43kqh4s", {
      headers: {
        "User-Agent": "Mozilla/5.0"
      }
    });

    const t = await r.text();

    if (!t || t.length < 5) {
      return res.send("ERROR");
    }

    const encoded = Buffer.from(t).toString("base64");

    res.send(encoded);

  } catch {
    res.send("ERROR");
  }
});

app.listen(PORT, () => console.log("Server running..."));
