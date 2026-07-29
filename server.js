const express = require("express");
const fetch = require("node-fetch");
const session = require("express-session");
const fs = require("fs");
const path = require("path");
const SECRET = "MY_SECRET_123";
const { supabase } = require("./supabase");
const view = require("./view");
const api = require("./api");

const app = express();
const PORT = process.env.PORT || 3000;

/* ==========================
   إعدادات أساسية
========================== */

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
   دالة التحقق الموحدة 🔐
========================== */

async function checkKey(key, deviceid) {
  if (!key || !deviceid) return { ok: false };

  const { data: item } = await supabase
    .from("keys")
    .select("*")
    .eq("key", key)
    .single();

  if (!item) return { ok: false };

  if (item.status === "banned") {
    return { ok: false, status: "banned" };
  }

  // ربط أول جهاز
  if (!item.deviceid) {
    await supabase
      .from("keys")
      .update({ deviceid })
      .eq("key", key)
      .is("deviceid", null);
  } else if (item.deviceid !== deviceid) {
    return { ok: false, status: "another_device" };
  }

  // التحقق من الانتهاء
  const now = new Date();
  const expire = new Date(item.expireat);

  if (expire <= now) {
    await supabase
      .from("keys")
      .update({ status: "expired" })
      .eq("key", key);

    return { ok: false, status: "expired" };
  }

  return { ok: true, item };
}

/* ==========================
   API CHECK
========================== */

app.get("/api/check", async (req, res) => {
  const { key, deviceid } = req.query;

  const result = await checkKey(key, deviceid);

  if (!result.ok) {
    return res.json({ status: result.status || "invalid" });
  }

  const item = result.item;

  const now = new Date();
  const expire = new Date(item.expireat);

  const diff = expire - now;

  const days = Math.floor(diff / (1000 * 60 * 60 * 24));
  const hours = Math.floor((diff / (1000 * 60 * 60)) % 24);
  const minutes = Math.floor((diff / (1000 * 60)) % 60);

  res.json({
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
   GET FILES (محمي)
========================== */

app.get("/getFiles", async (req, res) => {
  const { key, deviceid, option } = req.query;

  const result = await checkKey(key, deviceid);

  if (!result.ok) {
    return res.json({ status: result.status || "invalid" });
  }

  const folderPath = path.join(__dirname, "data", "option" + option);

  if (!fs.existsSync(folderPath)) {
    return res.json({ error: "not found" });
  }

  const files = fs.readdirSync(folderPath);

  const resultFiles = files.map(file => ({
    name: file,
    url: `${req.protocol}://${req.get("host")}/file?f=${option}/${file}&key=${key}&deviceid=${deviceid}`
  }));

  res.json(resultFiles);
});

/* ==========================
   تحميل ملف واحد (محمي)
========================== */

app.get("/file", async (req, res) => {
  const { key, deviceid, f } = req.query;

  const result = await checkKey(key, deviceid);

  if (!result.ok) {
    return res.send("DENIED");
  }

  const filePath = path.join(__dirname, "data", f);

  if (!fs.existsSync(filePath)) {
    return res.send("NOT FOUND");
  }

  res.sendFile(filePath);
});

/* ==========================
   تشغيل السيرفر
========================== */

app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
