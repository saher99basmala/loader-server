const express = require("express");
const fetch = require("node-fetch");
const session = require("express-session");
const fs = require("fs");
const path = require("path");

const app = express();

const view = require("./view");
const api = require("./api");
const { supabase } = require("./supabase");

const PORT = process.env.PORT || 3000;

const SECRET = "MY_SECRET_123";

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.use(
  session({
    secret: "BS_ADMIN_SECRET",
    resave: false,
    saveUninitialized: false
  })
);

app.use("/", view);
app.use("/api", api);

/* ==========================
   API CHECK KEY
========================== */

app.get("/api/check", async (req, res) => {

  const key = req.query.key;
  const deviceid = req.query.deviceid;

  if (!key || !deviceid) {
    return res.json({ status: "invalid" });
  }

  const { data: item, error } = await supabase
    .from("keys")
    .select("*")
    .eq("key", key)
    .single();

  if (error || !item) {
    return res.json({ status: "invalid" });
  }

  if (item.status === "banned") {
    return res.json({ status: "banned" });
  }

  if (!item.deviceid) {
    const { error: updateError } = await supabase
      .from("keys")
      .update({ deviceid: deviceid })
      .eq("key", key)
      .is("deviceid", null);

    if (updateError) {
      return res.json({ status: "invalid" });
    }

  } else if (item.deviceid !== deviceid) {
    return res.json({ status: "another_device" });
  }

  const now = new Date();
  const expire = new Date(item.expireat);

  if (expire <= now) {

    await supabase
      .from("keys")
      .update({ status: "expired" })
      .eq("key", key);

    return res.json({ status: "expired" });
  }

  const diff = expire.getTime() - now.getTime();

  const days = Math.floor(diff / (1000 * 60 * 60 * 24));
  const hours = Math.floor((diff / (1000 * 60 * 60)) % 24);
  const minutes = Math.floor((diff / (1000 * 60)) % 60);

  return res.json({
    status: "active",
    name: item.name,
    days,
    hours,
    minutes
  });
});

/* ==========================
   SCRIPT
========================== */

app.get("/script", async (req, res) => {

  if (req.query.key !== "12345") {
    return res.send("DENIED");
  }

  if (req.headers["x-secret"] !== SECRET) {
    return res.send("تم سحب معلومات جهازك بنجاح😉😎");
  }

  try {

    const response = await fetch(
      "https://pastebin.com/raw/uFVCAKm0"
    );

    const script = await response.text();

    if (!script || script.length < 10) {
      return res.send("ERROR");
    }

    res.send(script);

  } catch (e) {

    console.log(e);
    res.send("ERROR");

  }

});

/* ==========================
   GET FILES FROM FOLDERS 🔥
========================== */

app.get("/getFiles", (req, res) => {

  const option = req.query.option;

  if (!option) {
    return res.json({ error: "no option" });
  }

  const folderPath = path.join(__dirname, "data", "option" + option);

  if (!fs.existsSync(folderPath)) {
    return res.json({ error: "not found" });
  }

  const files = fs.readdirSync(folderPath);

  const result = files.map(file => ({
    name: file,
    url: `https://raw.githubusercontent.com/saher99basmala/loader-server/main/data/option${option}/${file}`
  }));

  res.json(result);
});

/* ==========================
   START SERVER
========================== */

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
