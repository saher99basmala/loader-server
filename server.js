const express = require("express");
const fetch = require("node-fetch");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/script", async (req, res) => {

  // 🔐 التحقق من المفتاح
  if (req.query.key !== "12345") {
    return res.send("DENIED");
  }

  // 🔍 التحقق من نوع الطلب
  const ua = req.headers["user-agent"] || "";

  // 👤 إذا فتحه متصفح عادي
  if (ua.includes("Mozilla")) {
    return res.send("السلام عليكم");
  }

  try {
    const r = await fetch("https://pastebin.com/raw/F43kqh4s");
    const t = await r.text();

    // 🔐 تشفير
    const encoded = Buffer.from(t).toString("base64");

    res.send(encoded);

  } catch {
    res.send("ERROR");
  }
});

app.listen(PORT, () => console.log("Server running"));
