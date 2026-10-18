"use strict";

/*
 * Standalone license server for Render.
 * It does not import or modify the existing server files.
 *
 * Endpoints:
 *   GET  /health
 *   POST /license/activate
 *   POST /license/check
 *   POST /license/release       (admin secret required)
 *   GET  /admin                 (admin secret in login form)
 *
 * Environment:
 *   PORT=3001
 *   LICENSE_ADMIN_SECRET=<long random secret>
 *   LICENSE_SIGNING_SECRET=<long random secret>
 *   LICENSE_STORE=/var/data/licenses.json  (use a Render persistent disk)
 */

const express = require("express");
const crypto = require("crypto");
const fs = require("fs");
const path = require("path");

const app = express();
app.disable("x-powered-by");
app.use(express.json({ limit: "64kb" }));
app.use(express.urlencoded({ extended: false, limit: "64kb" }));

const PORT = Number(process.env.PORT || 3001);
const ADMIN_SECRET = process.env.LICENSE_ADMIN_SECRET;
const SIGNING_SECRET = process.env.LICENSE_SIGNING_SECRET;
const STORE = process.env.LICENSE_STORE || path.join(__dirname, "licenses.json");
const MAX_DEVICE_ID = 256;

if (!ADMIN_SECRET || ADMIN_SECRET.length < 24) {
  throw new Error("LICENSE_ADMIN_SECRET must be set and at least 24 characters long");
}
if (!SIGNING_SECRET || SIGNING_SECRET.length < 32) {
  throw new Error("LICENSE_SIGNING_SECRET must be set and at least 32 characters long");
}

function ensureStore() {
  fs.mkdirSync(path.dirname(STORE), { recursive: true });
  if (!fs.existsSync(STORE)) {
    fs.writeFileSync(STORE, JSON.stringify({ version: 1, licenses: {} }, null, 2));
  }
}

function readStore() {
  ensureStore();
  try {
    const value = JSON.parse(fs.readFileSync(STORE, "utf8"));
    if (!value || typeof value !== "object" || !value.licenses) throw new Error("bad store");
    return value;
  } catch (error) {
    throw new Error(`Cannot read license store: ${error.message}`);
  }
}

function writeStore(store) {
  ensureStore();
  const tmp = `${STORE}.${process.pid}.tmp`;
  fs.writeFileSync(tmp, JSON.stringify(store, null, 2), { mode: 0o600 });
  fs.renameSync(tmp, STORE);
}

function secretEquals(a, b) {
  const left = Buffer.from(String(a || ""));
  const right = Buffer.from(String(b || ""));
  return left.length === right.length && crypto.timingSafeEqual(left, right);
}

function adminOnly(req, res, next) {
  const supplied = req.get("x-admin-secret") || req.body?.adminSecret || req.query?.adminSecret;
  if (!secretEquals(supplied, ADMIN_SECRET)) return res.status(401).json({ ok: false, error: "unauthorized" });
  next();
}

function normalizeKey(value) {
  return String(value || "").trim().toUpperCase().replace(/\s+/g, "");
}

function normalizeDevice(value) {
  const device = String(value || "").trim();
  if (!device || device.length > MAX_DEVICE_ID) return null;
  return device;
}

function hashDevice(deviceId) {
  return crypto.createHash("sha256").update(deviceId).digest("hex");
}

function makeKey() {
  const raw = crypto.randomBytes(15).toString("hex").toUpperCase();
  return `TW-${raw.slice(0, 5)}-${raw.slice(5, 10)}-${raw.slice(10, 15)}-${raw.slice(15, 20)}-${raw.slice(20)}`;
}

function parseDays(value, fallback = 30) {
  const days = Number(value ?? fallback);
  if (!Number.isInteger(days) || days < 1 || days > 3650) return null;
  return days;
}

function isoAfterDays(days) {
  return new Date(Date.now() + days * 86400000).toISOString();
}

function isActive(item) {
  return item && item.status === "active" && new Date(item.expiresAt).getTime() > Date.now();
}

function publicLicense(item) {
  return {
    key: item.key,
    status: isActive(item) ? "active" : (item.status === "revoked" ? "revoked" : "expired"),
    deviceBound: Boolean(item.deviceHash),
    expiresAt: item.expiresAt,
    createdAt: item.createdAt,
    label: item.label || ""
  };
}

function signedResponse(item, deviceId) {
  const payload = `${item.key}.${hashDevice(deviceId)}.${item.expiresAt}`;
  const signature = crypto.createHmac("sha256", SIGNING_SECRET).update(payload).digest("hex");
  return { ok: true, license: publicLicense(item), signature };
}

function issueAccessToken(item, deviceId) {
  const token = crypto.randomBytes(32).toString("hex");
  item.tokenHash = crypto.createHash("sha256").update(token).digest("hex");
  item.tokenDeviceHash = hashDevice(deviceId);
  item.tokenIssuedAt = new Date().toISOString();
  return token;
}

function findByAccessToken(token, deviceId, store) {
  if (!token || !deviceId) return null;
  const tokenHash = crypto.createHash("sha256").update(String(token)).digest("hex");
  const deviceHash = hashDevice(deviceId);
  return Object.values(store.licenses).find((item) =>
    item.tokenHash === tokenHash && item.tokenDeviceHash === deviceHash && isActive(item)
  ) || null;
}

app.get("/health", (_req, res) => res.json({ ok: true, service: "standalone-license-server" }));

// Client endpoint: first activation binds the key permanently to one device.
app.post("/license/activate", (req, res) => {
  const key = normalizeKey(req.body?.key);
  const deviceId = normalizeDevice(req.body?.deviceId);
  if (!key || !deviceId) return res.status(400).json({ ok: false, error: "key and deviceId are required" });

  const store = readStore();
  const item = store.licenses[key];
  if (!item) return res.status(404).json({ ok: false, error: "invalid_license" });
  if (item.status === "revoked") return res.status(403).json({ ok: false, error: "license_revoked" });
  if (!isActive(item)) return res.status(403).json({ ok: false, error: "license_expired" });

  const deviceHash = hashDevice(deviceId);
  if (item.deviceHash && item.deviceHash !== deviceHash) {
    return res.status(409).json({ ok: false, error: "license_bound_to_another_device" });
  }

  if (!item.deviceHash) {
    item.deviceHash = deviceHash;
    item.boundAt = new Date().toISOString();
    writeStore(store);
  }
  return res.json(signedResponse(item, deviceId));
});

// Client endpoint: checks the existing binding without exposing the device ID.
app.post("/license/check", (req, res) => {
  const key = normalizeKey(req.body?.key);
  const deviceId = normalizeDevice(req.body?.deviceId);
  if (!key || !deviceId) return res.status(400).json({ ok: false, error: "key and deviceId are required" });

  const store = readStore();
  const item = store.licenses[key];
  if (!item) return res.status(404).json({ ok: false, error: "invalid_license" });
  if (item.status === "revoked") return res.status(403).json({ ok: false, error: "license_revoked" });
  if (!isActive(item)) return res.status(403).json({ ok: false, error: "license_expired" });
  if (item.deviceHash !== hashDevice(deviceId)) return res.status(409).json({ ok: false, error: "license_bound_to_another_device" });
  return res.json(signedResponse(item, deviceId));
});

// Compatibility route for the existing APK. The APK posts key, hwid, ts and sig
// to /auth/login and expects this response shape. The server still enforces the
// one-device binding and license expiry; the old client signature is accepted as
// a compatibility field because the APK's original signing secret is not present.
app.post("/auth/login", (req, res) => {
  const key = normalizeKey(req.body?.key);
  const deviceId = normalizeDevice(req.body?.hwid);
  if (!key || !deviceId) return res.status(400).json({ ok: false, msg: "key and hwid are required", error: "invalid_request" });

  const store = readStore();
  const item = store.licenses[key];
  if (!item) return res.status(404).json({ ok: false, msg: "Chave inválida.", error: "not_found", blocked: false });
  if (item.status === "revoked") return res.status(403).json({ ok: false, msg: "Chave revogada.", error: "key_revoked", blocked: true });
  if (!isActive(item)) return res.status(403).json({ ok: false, msg: "Chave expirada.", error: "key_expired", blocked: true });

  const deviceHash = hashDevice(deviceId);
  if (item.deviceHash && item.deviceHash !== deviceHash) {
    return res.status(409).json({ ok: false, msg: "Esta chave está مرتبطة بجهاز آخر.", error: "device_limit", blocked: true });
  }
  if (!item.deviceHash) {
    item.deviceHash = deviceHash;
    item.boundAt = new Date().toISOString();
  }
  const accessToken = issueAccessToken(item, deviceId);
  writeStore(store);
  return res.json({
    ok: true,
    access_token: accessToken,
    refresh_token: accessToken,
    expiry: item.expiresAt,
    note: item.label || "Licensed by your server",
    send_cards: true,
    tools: ["township"]
  });
});

// The APK may request this challenge after a legacy signature mismatch. It is
// deliberately a harmless challenge endpoint; it does not grant access itself.
app.post("/PHP/auth_challenge.php", (req, res) => {
  res.json({ ok: true, challenge: crypto.randomBytes(32).toString("hex") });
});

// Minimal compatibility response for the APK's optional tool-saves request.
app.post("/PHP/tool_saves.php", (req, res) => {
  const store = readStore();
  const item = findByAccessToken(req.body?.token, req.body?.hwid, store);
  if (!item) return res.status(401).json({ ok: false, error: "NOT_AUTHENTICATED", blocked: true });
  res.json({ ok: true, saves: [], tools: ["township"] });
});

app.post("/license/release", adminOnly, (req, res) => {
  const key = normalizeKey(req.body?.key);
  if (!key) return res.status(400).json({ ok: false, error: "key is required" });
  const store = readStore();
  const item = store.licenses[key];
  if (!item) return res.status(404).json({ ok: false, error: "not_found" });
  item.deviceHash = null;
  item.boundAt = null;
  writeStore(store);
  res.json({ ok: true, license: publicLicense(item) });
});

function adminPage() {
  return `<!doctype html><meta charset="utf-8"><title>License Admin</title>
<style>body{font:15px system-ui;max-width:980px;margin:30px auto;padding:0 16px;background:#111;color:#eee}input,button{padding:9px;margin:4px;border-radius:6px;border:1px solid #555;background:#222;color:#eee}button{cursor:pointer;background:#1769aa}.row{border-bottom:1px solid #333;padding:10px 0}.muted{color:#aaa}code{color:#8fe3ff}</style>
<h1>License Admin</h1><p class="muted">Each key can be bound to one device only.</p>
<form id="f"><input id="secret" type="password" placeholder="Admin secret" required><input id="days" type="number" value="30" min="1" max="3650"><input id="label" placeholder="Label (optional)"><button>Create key</button></form>
<p id="out"></p><h2>Licenses</h2><div id="list">Loading...</div>
<script>
const $=id=>document.getElementById(id); const h=()=>({'x-admin-secret':$('secret').value,'content-type':'application/json'});
async function load(){const r=await fetch('/admin/licenses',{headers:h()});const j=await r.json();$('list').innerHTML=(j.licenses||[]).map(x=>'<div class="row"><code>'+x.key+'</code> — '+x.status+' — expires '+x.expiresAt+' — '+(x.deviceBound?'bound':'free')+' <button onclick="release(\\''+x.key+'\\')">Release device</button></div>').join('')||'No licenses';}
async function release(key){await fetch('/license/release',{method:'POST',headers:h(),body:JSON.stringify({key})});load();}
$('f').onsubmit=async e=>{e.preventDefault();const r=await fetch('/admin/licenses',{method:'POST',headers:h(),body:JSON.stringify({days:Number($('days').value),label:$('label').value})});const j=await r.json();$('out').textContent=j.key?'Created: '+j.key:JSON.stringify(j);load();};
$('secret').onchange=load; load();
</script>`;
}

app.get("/admin", (_req, res) => res.type("html").send(adminPage()));

app.get("/admin/licenses", adminOnly, (req, res) => {
  const store = readStore();
  res.json({ ok: true, licenses: Object.values(store.licenses).map(publicLicense) });
});

app.post("/admin/licenses", adminOnly, (req, res) => {
  const days = parseDays(req.body?.days);
  if (!days) return res.status(400).json({ ok: false, error: "days must be an integer from 1 to 3650" });
  const store = readStore();
  let key;
  do key = makeKey(); while (store.licenses[key]);
  const item = { key, status: "active", label: String(req.body?.label || "").slice(0, 120), deviceHash: null, boundAt: null, createdAt: new Date().toISOString(), expiresAt: isoAfterDays(days) };
  store.licenses[key] = item;
  writeStore(store);
  res.status(201).json({ ok: true, key, license: publicLicense(item) });
});

app.post("/admin/licenses/:key/revoke", adminOnly, (req, res) => {
  const store = readStore();
  const key = normalizeKey(req.params.key);
  const item = store.licenses[key];
  if (!item) return res.status(404).json({ ok: false, error: "not_found" });
  item.status = "revoked";
  writeStore(store);
  res.json({ ok: true, license: publicLicense(item) });
});

app.listen(PORT, "0.0.0.0", () => console.log(`Standalone license server listening on ${PORT}`));
