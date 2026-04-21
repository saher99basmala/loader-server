const express = require("express");
const fetch = require("node-fetch");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/script", async (req, res) => {

  if (req.query.key !== "12345") {
    return res.send("DENIED");
  }

  const ua = req.headers["user-agent"] || "";

  // 🔒 السماح فقط للسكربت
  if (!ua.toLowerCase().includes("okhttp")) {
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
