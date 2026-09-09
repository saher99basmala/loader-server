const express = require("express");
const fetch = require("node-fetch");
const session = require("express-session");

const view = require("./view");
const api = require("./api");
const desbanApi = require("./desbanApi");
const supabase = require("./supabase");

const mGameInfoDecoder = require("./mGameInfoDecoder");
const mGameInfoEditor = require("./mGameInfoEditor");

const fetchCity = require("./fetchCity");
const fetchCity2 = require("./fetchCity2");

const cityCache = require("./cityCache");

const app = express();

const PORT = process.env.PORT || 3000;
const SECRET = process.env.SERVER_SECRET || "MY_SECRET_123";

// ===============================
// Middleware
// ===============================

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.use(
  session({
    secret: SECRET,
    resave: false,
    saveUninitialized: false,
  })
);

// ===============================
// Main Routes
// ===============================

app.use("/", view);

app.use("/api", api);
app.use("/api", desbanApi);

// ===============================
// Fetch City
// ===============================

// النسخة الأصلية - لا تلمسها
app.use("/api", fetchCity);

// النسخة الثانية
app.use("/api2", fetchCity2);

// ===============================
// City Cache
// ===============================

app.use("/api", cityCache);

// ===============================
// Game Info Decoder
// ===============================

app.post(
  "/api/decode",
  express.raw({ type: "application/octet-stream", limit: "50mb" }),
  async (req, res) => {
    try {
      const result = await mGameInfoDecoder.decodeFile(req.body);

      res.json(result);
    } catch (error) {
      console.error("Decode error:", error);

      res.status(500).json({
        error: error.message || "Decode failed",
      });
    }
  }
);

// ===============================
// Game Info Editor
// ===============================

app.post(
  "/api/edit",
  express.raw({ type: "application/octet-stream", limit: "50mb" }),
  async (req, res) => {
    try {
      let edits = {};

      if (req.query.edits) {
        try {
          edits = JSON.parse(req.query.edits);
        } catch (e) {
          return res.status(400).json({
            error: "Invalid edits JSON",
          });
        }
      }

      const result = await mGameInfoEditor.applyEdits(req.body, edits);

      res.send(result);
    } catch (error) {
      console.error("Edit error:", error);

      res.status(500).json({
        error: error.message || "Edit failed",
      });
    }
  }
);

// ===============================
// Check Key
// ===============================

app.get("/api/check", async (req, res) => {
  try {
    const { key, deviceid } = req.query;

    if (!key || !deviceid) {
      return res.status(400).json({
        error: "Missing key or deviceid",
      });
    }

    const { data, error } = await supabase
      .from("keys")
      .select("*")
      .eq("key", key)
      .single();

    if (error || !data) {
      return res.status(404).json({
        error: "Key not found",
      });
    }

    // ربط الجهاز بالمفتاح
    if (!data.deviceid) {
      const { error: updateError } = await supabase
        .from("keys")
        .update({
          deviceid: deviceid,
        })
        .eq("key", key);

      if (updateError) {
        console.error("Device bind error:", updateError);

        return res.status(500).json({
          error: "Failed to bind device",
        });
      }
    } else if (data.deviceid !== deviceid) {
      return res.status(403).json({
        error: "another_device",
      });
    }

    // التحقق من الحظر
    if (data.banned) {
      return res.status(403).json({
        error: "banned",
      });
    }

    // حساب الوقت المتبقي
    if (data.expires_at) {
      const now = new Date();
      const expires = new Date(data.expires_at);

      if (expires <= now) {
        return res.status(403).json({
          error: "expired",
        });
      }

      const diff = expires.getTime() - now.getTime();

      const totalMinutes = Math.floor(diff / 60000);

      const days = Math.floor(totalMinutes / 1440);
      const hours = Math.floor((totalMinutes % 1440) / 60);
      const minutes = totalMinutes % 60;

      return res.json({
        success: true,
        days,
        hours,
        minutes,
      });
    }

    return res.json({
      success: true,
      days: 0,
      hours: 0,
      minutes: 0,
    });
  } catch (error) {
    console.error("Check error:", error);

    res.status(500).json({
      error: error.message || "Check failed",
    });
  }
});

// ===============================
// Script
// ===============================

app.get("/script", async (req, res) => {
  try {
    const { key } = req.query;
    const xSecret = req.headers["x-secret"];

    if (key !== "12345") {
      return res.status(403).send("Invalid key");
    }

    if (xSecret !== SECRET) {
      return res.status(403).send("روح نام يا حبيبي 😂");
    }

    const response = await fetch(
      "https://pastebin.com/raw/JnWRrGcn"
    );

    if (!response.ok) {
      throw new Error(`Pastebin request failed: ${response.status}`);
    }

    const script = await response.text();

    res.type("text/plain").send(script);
  } catch (error) {
    console.error("Script error:", error);

    res.status(500).send("Failed to fetch script");
  }
});

// ===============================
// Health
// ===============================

app.get("/health", (req, res) => {
  res.json({
    status: "ok",
  });
});

// ===============================
// Start Server
// ===============================

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});
