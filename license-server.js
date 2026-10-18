"use strict";

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
const SUPABASE_URL = String(process.env.SUPABASE_URL || "").replace(/\/$/, "");
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
const STORE = process.env.LICENSE_STORE || path.join(__dirname, "licenses.json");
const USE_SUPABASE = Boolean(SUPABASE_URL && SUPABASE_KEY);

if (!ADMIN_SECRET || ADMIN_SECRET.length < 24) {
    throw new Error("LICENSE_ADMIN_SECRET must be set and at least 24 characters long");
}

if (!SIGNING_SECRET || SIGNING_SECRET.length < 32) {
    throw new Error("LICENSE_SIGNING_SECRET must be set and at least 32 characters long");
}

function eq(a, b) {
    const x = Buffer.from(String(a || ""));
    const y = Buffer.from(String(b || ""));

    return x.length === y.length && crypto.timingSafeEqual(x, y);
}

function keyOf(v) {
    return String(v || "").trim().toUpperCase().replace(/\s+/g, "");
}

function deviceOf(v) {
    const x = String(v || "").trim();
    return x && x.length <= 256 ? x : null;
}

function deviceHash(x) {
    return crypto.createHash("sha256").update(x).digest("hex");
}

function newKey() {
    const x = crypto.randomBytes(15).toString("hex").toUpperCase();

    return `TW-${x.slice(0, 5)}-${x.slice(5, 10)}-${x.slice(10, 15)}-${x.slice(15, 20)}-${x.slice(20)}`;
}

function active(x) {
    return x &&
        x.status === "active" &&
        new Date(x.expiresAt).getTime() > Date.now();
}

function publicLicense(x) {
    return {
        key: x.key,
        status: active(x)
            ? "active"
            : x.status === "revoked"
                ? "revoked"
                : "expired",
        deviceBound: Boolean(x.deviceHash),
        expiresAt: x.expiresAt,
        createdAt: x.createdAt,
        label: x.label || ""
    };
}

function isoDays(n) {
    return new Date(Date.now() + n * 86400000).toISOString();
}

function days(v) {
    const n = Number(v ?? 30);

    return Number.isInteger(n) && n >= 1 && n <= 3650
        ? n
        : null;
}

function mapIn(r) {
    return {
        key: r.key,
        status: r.status,
        label: r.label || "",
        deviceHash: r.device_hash ?? r.deviceHash ?? null,
        boundAt: r.bound_at ?? r.boundAt ?? null,
        tokenHash: r.token_hash ?? r.tokenHash ?? null,
        tokenDeviceHash: r.token_device_hash ?? r.tokenDeviceHash ?? null,
        tokenIssuedAt: r.token_issued_at ?? r.tokenIssuedAt ?? null,
        createdAt: r.created_at ?? r.createdAt,
        expiresAt: r.expires_at ?? r.expiresAt
    };
}

function mapOut(x) {
    return {
        key: x.key,
        status: x.status,
        label: x.label || "",
        device_hash: x.deviceHash || null,
        bound_at: x.boundAt || null,
        token_hash: x.tokenHash || null,
        token_device_hash: x.tokenDeviceHash || null,
        token_issued_at: x.tokenIssuedAt || null,
        created_at: x.createdAt,
        expires_at: x.expiresAt
    };
}

function ensureFile() {
    fs.mkdirSync(path.dirname(STORE), { recursive: true });

    if (!fs.existsSync(STORE)) {
        fs.writeFileSync(
            STORE,
            JSON.stringify({ version: 1, licenses: {} }, null, 2),
            { mode: 0o600 }
        );
    }
}

function fileRead() {
    ensureFile();
    return JSON.parse(fs.readFileSync(STORE, "utf8"));
}

function fileWrite(s) {
    ensureFile();

    const t = `${STORE}.${process.pid}.tmp`;

    fs.writeFileSync(t, JSON.stringify(s, null, 2), { mode: 0o600 });
    fs.renameSync(t, STORE);
}

async function sb(pathname, options = {}) {
    const r = await fetch(`${SUPABASE_URL}/rest/v1/${pathname}`, {
        ...options,
        headers: {
            apikey: SUPABASE_KEY,
            Authorization: `Bearer ${SUPABASE_KEY}`,
            "Content-Type": "application/json",
            ...(options.headers || {})
        }
    });

    const text = await r.text();

    let body;

    try {
        body = text ? JSON.parse(text) : null;
    } catch {
        body = text;
    }

    if (!r.ok) {
        throw new Error(
            `Supabase ${r.status}: ${
                typeof body === "string" ? body : JSON.stringify(body)
            }`
        );
    }

    return body;
}

async function all() {
    if (!USE_SUPABASE) {
        const s = fileRead();
        return Object.values(s.licenses);
    }

    const rows = await sb("licenses?select=*");

    return rows.map(mapIn);
}

async function one(key) {
    if (!USE_SUPABASE) {
        const s = fileRead();
        return s.licenses[key] || null;
    }

    const rows = await sb(
        `licenses?key=eq.${encodeURIComponent(key)}&select=*&limit=1`
    );

    return rows[0] ? mapIn(rows[0]) : null;
}

async function save(x) {
    if (!USE_SUPABASE) {
        const s = fileRead();

        s.licenses[x.key] = x;

        fileWrite(s);
        return;
    }

    await sb("licenses?on_conflict=key", {
        method: "POST",
        headers: {
            Prefer: "resolution=merge-duplicates,return=minimal"
        },
        body: JSON.stringify(mapOut(x))
    });
}

async function admin(req, res, next) {
    const got =
        req.get("x-admin-secret") ||
        req.body?.adminSecret ||
        req.query?.adminSecret;

    if (!eq(got, ADMIN_SECRET)) {
        return res.status(401).json({
            ok: false,
            error: "unauthorized"
        });
    }

    next();
}

function signed(x, d) {
    const sig = crypto
        .createHmac("sha256", SIGNING_SECRET)
        .update(`${x.key}.${deviceHash(d)}.${x.expiresAt}`)
        .digest("hex");

    return {
        ok: true,
        license: publicLicense(x),
        signature: sig
    };
}

function token(x, d) {
    const t = crypto.randomBytes(32).toString("hex");

    x.tokenHash = crypto
        .createHash("sha256")
        .update(t)
        .digest("hex");

    x.tokenDeviceHash = deviceHash(d);
    x.tokenIssuedAt = new Date().toISOString();

    return t;
}

async function byToken(t, d) {
    if (!t || !d) {
        return null;
    }

    const h = crypto
        .createHash("sha256")
        .update(String(t))
        .digest("hex");

    return (
        await all()
    ).find(
        x =>
            x.tokenHash === h &&
            x.tokenDeviceHash === deviceHash(d) &&
            active(x)
    ) || null;
}

app.get("/health", async (_q, r) => {
    r.json({
        ok: true,
        service: "standalone-license-server",
        storage: USE_SUPABASE ? "supabase" : "json"
    });
});

app.post("/license/activate", async (req, res) => {
    try {
        const k = keyOf(req.body?.key);
        const d = deviceOf(req.body?.deviceId);

        if (!k || !d) {
            return res.status(400).json({
                ok: false,
                error: "key and deviceId are required"
            });
        }

        const x = await one(k);

        if (!x) {
            return res.status(404).json({
                ok: false,
                error: "invalid_license"
            });
        }

        if (x.status === "revoked") {
            return res.status(403).json({
                ok: false,
                error: "license_revoked"
            });
        }

        if (!active(x)) {
            return res.status(403).json({
                ok: false,
                error: "license_expired"
            });
        }

        const h = deviceHash(d);

        if (x.deviceHash && x.deviceHash !== h) {
            return res.status(409).json({
                ok: false,
                error: "license_bound_to_another_device"
            });
        }

        if (!x.deviceHash) {
            x.deviceHash = h;
            x.boundAt = new Date().toISOString();

            await save(x);
        }

        res.json(signed(x, d));
    } catch (e) {
        res.status(500).json({
            ok: false,
            error: "storage_error",
            message: e.message
        });
    }
});

app.post("/license/check", async (req, res) => {
    try {
        const k = keyOf(req.body?.key);
        const d = deviceOf(req.body?.deviceId);
        const x = await one(k);

        if (!x) {
            return res.status(404).json({
                ok: false,
                error: "invalid_license"
            });
        }

        if (x.status === "revoked") {
            return res.status(403).json({
                ok: false,
                error: "license_revoked"
            });
        }

        if (!active(x)) {
            return res.status(403).json({
                ok: false,
                error: "license_expired"
            });
        }

        if (!d || x.deviceHash !== deviceHash(d)) {
            return res.status(409).json({
                ok: false,
                error: "license_bound_to_another_device"
            });
        }

        res.json(signed(x, d));
    } catch (e) {
        res.status(500).json({
            ok: false,
            error: "storage_error",
            message: e.message
        });
    }
});

/*
 * تسجيل الدخول:
 * يقبل المسار القديم والجديد دون تغيير منطق الترخيص.
 */
app.post(
    ["/auth/login", "/api/auth/login"],
    async (req, res) => {
        try {
            const k = keyOf(req.body?.key);
            const d = deviceOf(req.body?.hwid);
            const x = await one(k);

            if (!k || !d) {
                return res.status(400).json({
                    ok: false,
                    msg: "key and hwid are required",
                    error: "invalid_request"
                });
            }

            if (!x) {
                return res.status(404).json({
                    ok: false,
                    msg: "Chave inválida.",
                    error: "not_found",
                    blocked: false
                });
            }

            if (x.status === "revoked") {
                return res.status(403).json({
                    ok: false,
                    msg: "Chave revogada.",
                    error: "key_revoked",
                    blocked: true
                });
            }

            if (!active(x)) {
                return res.status(403).json({
                    ok: false,
                    msg: "Chave expirada.",
                    error: "key_expired",
                    blocked: true
                });
            }

            const h = deviceHash(d);

            if (x.deviceHash && x.deviceHash !== h) {
                return res.status(409).json({
                    ok: false,
                    msg: "Esta chave está ligada a outro dispositivo.",
                    error: "device_limit",
                    blocked: true
                });
            }

            x.deviceHash = x.deviceHash || h;
            x.boundAt = x.boundAt || new Date().toISOString();

            const t = token(x, d);

            await save(x);

            res.json({
                ok: true,
                access_token: t,
                refresh_token: t,
                expiry: x.expiresAt,
                note: x.label || "Licensed by your server",
                send_cards: true,
                tools: ["township"]
            });
        } catch (e) {
            res.status(500).json({
                ok: false,
                error: "storage_error",
                message: e.message
            });
        }
    }
);

app.post("/PHP/auth_challenge.php", (_q, r) => {
    r.json({
        ok: true,
        challenge: crypto.randomBytes(32).toString("hex")
    });
});

app.post("/PHP/tool_saves.php", async (req, res) => {
    try {
        const x = await byToken(req.body?.token, req.body?.hwid);

        if (!x) {
            return res.status(401).json({
                ok: false,
                error: "NOT_AUTHENTICATED",
                blocked: true
            });
        }

        res.json({
            ok: true,
            saves: [],
            tools: ["township"]
        });
    } catch (e) {
        res.status(500).json({
            ok: false,
            error: "storage_error",
            message: e.message
        });
    }
});

app.post("/license/release", admin, async (req, res) => {
    const x = await one(keyOf(req.body?.key));

    if (!x) {
        return res.status(404).json({
            ok: false,
            error: "not_found"
        });
    }

    x.deviceHash = null;
    x.boundAt = null;
    x.tokenHash = null;
    x.tokenDeviceHash = null;
    x.tokenIssuedAt = null;

    await save(x);

    res.json({
        ok: true,
        license: publicLicense(x)
    });
});

app.get("/admin", (_q, r) => {
    r.type("html").send(adminPage());
});

app.get("/admin/licenses", admin, async (_q, r) => {
    r.json({
        ok: true,
        licenses: (await all()).map(publicLicense)
    });
});

app.post("/admin/licenses", admin, async (req, res) => {
    const n = days(req.body?.days);

    if (!n) {
        return res.status(400).json({
            ok: false,
            error: "days must be an integer from 1 to 3650"
        });
    }

    let k;

    do {
        k = newKey();
    } while (await one(k));

    const x = {
        key: k,
        status: "active",
        label: String(req.body?.label || "").slice(0, 120),
        deviceHash: null,
        boundAt: null,
        tokenHash: null,
        tokenDeviceHash: null,
        tokenIssuedAt: null,
        createdAt: new Date().toISOString(),
        expiresAt: isoDays(n)
    };

    await save(x);

    res.status(201).json({
        ok: true,
        key: k,
        license: publicLicense(x)
    });
});

app.post("/admin/licenses/:key/revoke", admin, async (req, res) => {
    const x = await one(keyOf(req.params.key));

    if (!x) {
        return res.status(404).json({
            ok: false,
            error: "not_found"
        });
    }

    x.status = "revoked";

    await save(x);

    res.json({
        ok: true,
        license: publicLicense(x)
    });
});

function adminPage() {
    return `<!doctype html>
<meta charset="utf-8">
<title>License Admin</title>
<style>
body{font:15px system-ui;max-width:980px;margin:30px auto;padding:0 16px;background:#111;color:#eee}
input,button{padding:9px;margin:4px;border-radius:6px;border:1px solid #555;background:#222;color:#eee}
button{cursor:pointer;background:#1769aa}
.row{border-bottom:1px solid #333;padding:10px 0}
.muted{color:#aaa}
code{color:#8fe3ff}
</style>

<h1>License Admin</h1>
<p class="muted">Each key can be bound to one device only.</p>

<form id="f">
<input id="secret" type="password" placeholder="Admin secret" required>
<input id="days" type="number" value="30" min="1" max="3650">
<input id="label" placeholder="Label (optional)">
<button>Create key</button>
</form>

<p id="out"></p>
<h2>Licenses</h2>
<div id="list">Loading...</div>

<script>
const $=id=>document.getElementById(id);
const h=()=>({
    'x-admin-secret':$('secret').value,
    'content-type':'application/json'
});

async function load(){
    const r=await fetch('/admin/licenses',{headers:h()});
    const j=await r.json();

    $('list').innerHTML=(j.licenses||[]).map(x=>
        '<div class="row"><code>'+x.key+'</code> — '+x.status+
        ' — expires '+x.expiresAt+' — '+
        (x.deviceBound?'bound':'free')+
        ' <button onclick="release(\\''+x.key+'\\')">Release device</button></div>'
    ).join('')||'No licenses';
}

async function release(key){
    await fetch('/license/release',{
        method:'POST',
        headers:h(),
        body:JSON.stringify({key})
    });
    load();
}

$('f').onsubmit=async e=>{
    e.preventDefault();

    const r=await fetch('/admin/licenses',{
        method:'POST',
        headers:h(),
        body:JSON.stringify({
            days:Number($('days').value),
            label:$('label').value
        })
    });

    const j=await r.json();

    $('out').textContent=j.key
        ?'Created: '+j.key
        :JSON.stringify(j);

    load();
};

$('secret').onchange=load;
load();
</script>`;
}

app.listen(PORT, "0.0.0.0", () => {
    console.log(
        `License server listening on ${PORT}; storage=${
            USE_SUPABASE ? "supabase" : "json"
        }`
    );
});
