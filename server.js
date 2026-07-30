const express = require("express");
const fetch = require("node-fetch");
const session = require("express-session");

const app = express();

const view = require("./view");
const api = require("./api");
const { supabase } = require("./supabase");

const PORT = process.env.PORT || 3000;
const SECRET = "MY_SECRET_123";

/* ✅ Test routes */
app.get("/", (req, res) => {
  res.send("MAIN WORKS");
});

app.get("/admin/login", (req, res) => {
  res.send("LOGIN WORKS");
});

/* Middlewares */
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.use(
  session({
    secret: "BS_ADMIN_SECRET",
    resave: false,
    saveUninitialized: false
  })
);

/* Routes */
app.use("/", view);
app.use("/api", api);

/* SCRIPT */
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

/* START */
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
