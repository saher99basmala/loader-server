const express = require("express");
const fetch = require("node-fetch");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/script", async (req, res) => {
  if (req.query.key !== "12345") return res.send("DENIED");

  try {
    const r = await fetch("https://pastebin.com/raw/eenW85wk");
    const t = await r.text();

    res.send(Buffer.from(t).toString("base64"));
  } catch {
    res.send("ERROR");
  }
});

app.listen(PORT);
