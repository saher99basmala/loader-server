const express = require("express");
const fetch = require("node-fetch");
const session = require("express-session");
const app = express();

const view = require("./view");
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

/*==========================
  CHECK KEY
==========================*/

app.get("/api/check", async (req, res) => {

  const key = req.query.key;

  if (!key) {
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

  const today = new Date();
  const expire = new Date(item.expireat);

  if (expire < today) {

    await supabase
      .from("keys")
      .update({ status: "expired" })
      .eq("key", key);

    return res.json({ status: "expired" });
  }

  return res.json({
    status: item.status
  });

});

/*==========================
  CHECK PASSWORD
==========================*/

app.get("/api/check-password", async (req, res) => {

  const password = req.query.password;

  if (!password) {
    return res.send("INVALID");
  }

  const { data: item, error } = await supabase
    .from("keys")
    .select("*")
    .eq("key", password)
    .single();

  if (error || !item) {
    return res.send("INVALID");
  }

  if (item.status !== "active") {
    return res.send("INVALID");
  }

  const today = new Date();
  const expire = new Date(item.expireat);

  if (expire < today) {

    await supabase
      .from("keys")
      .update({ status: "expired" })
      .eq("key", password);

    return res.send("EXPIRED");
  }

  return res.send("OK");

});

/*==========================
  SCRIPT
==========================*/

app.get("/script", async (req, res) => {

  if (req.query.key !== "12345") {
    return res.send("DENIED");
  }

  if (req.headers["x-secret"] !== SECRET) {
    return res.send("السلام عليكم");
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

    res.send("ERROR");

  }

});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
