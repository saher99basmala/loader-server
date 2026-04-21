const express = require("express");
const fetch = require("node-fetch");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/script", async (req, res) => {

  if (req.query.key !== "12345") {
    return res.send("DENIED");
  }

  const ua = req.headers["user-agent"] || "";

  // منع المتصفح
  if (ua.includes("Mozilla") || ua.includes("Chrome") || ua.includes("Safari")) {
    return res.send("السلام عليكم");
  }

  try {
    const r = await fetch("https://pastebin.com/raw/F43kqh4s");
    const t = await r.text();

    const encoded = Buffer.from(t).toString("base64");

    res.send(encoded);

  } catch (e) {
    res.send("ERROR");
  }
});

app.listen(PORT, () => console.log("Server running"));
