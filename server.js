const express = require("express");
const fetch = require("node-fetch");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/script", async (req, res) => {

  // 🔐 تحقق المفتاح
  if (req.query.key !== "12345") {
    return res.send("DENIED");
  }

  // 🔍 قراءة User-Agent
  const ua = req.headers["user-agent"] || "";

  // 🧪 طباعة في Logs (مهم)
  console.log("User-Agent:", ua);

  try {
    console.log("Fetching from Pastebin...");

    const r = await fetch("https://pastebin.com/raw/F43kqh4s", {
      headers: {
        "User-Agent": "Mozilla/5.0"
      }
    });

    console.log("Status:", r.status);

    const t = await r.text();

    console.log("Length:", t.length);

    if (!t || t.length < 5) {
      return res.send("EMPTY");
    }

    // 🔐 تشفير
    const encoded = Buffer.from(t).toString("base64");

    res.send(encoded);

  } catch (e) {
    console.log("ERROR:", e);
    res.send("ERROR");
  }
});

app.listen(PORT, () => console.log("Server running..."));
