const express = require("express");
const fetch = require("node-fetch");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/script", async (req, res) => {

  // 🔐 التحقق من المفتاح
  if (req.query.key !== "12345") {
    return res.send("DENIED");
  }

  // 🔍 قراءة User-Agent
  const ua = req.headers["user-agent"] || "";

  // 🚫 إذا مو طلب من سكربت (مثل المتصفح)
  if (!ua.includes("okhttp")) {
    return res.send("السلام عليكم");
  }

  try {
    // 📥 جلب المحتوى من Pastebin
    const r = await fetch("https://pastebin.com/raw/F43kqh4s");
    const t = await r.text();

    // 🔐 تحويل إلى Base64
    const encoded = Buffer.from(t).toString("base64");

    // 📤 إرسال للمستخدم
    res.send(encoded);

  } catch (e) {
    res.send("ERROR");
  }
});

app.listen(PORT, () => console.log("Server running..."));
