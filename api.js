const express = require("express");
const router = express.Router();
const { supabase } = require("./supabase");

const API_KEY = "BS_SECRET_123";

function generateKey() {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    let result = "BS-";

    for (let i = 0; i < 8; i++) {
        result += chars[Math.floor(Math.random() * chars.length)];
    }

    return result;
}

function formatDate(date) {
    return date.toISOString().split("T")[0];
}

/* =========================
   CREATE KEY
========================= */
router.post("/create_key", async (req, res) => {

    if (req.headers["x-api-key"] !== API_KEY) {
        return res.status(401).json({
            status: "unauthorized"
        });
    }

    const { name, deviceid, days } = req.body;

    if (!name || !deviceid) {
        return res.json({
            status: "error",
            message: "البيانات ناقصة"
        });
    }

    // 🔥 تحقق من التكرار
    const { data: existing } = await supabase
        .from("keys")
        .select("id")
        .eq("deviceid", deviceid)
        .maybeSingle();

    if (existing) {
        return res.json({
            status: "duplicate"
        });
    }

    const created = new Date();
    const expire = new Date();
    expire.setDate(expire.getDate() + parseInt(days || 10));

    const key = generateKey();

    const { error } = await supabase
        .from("keys")
        .insert([{
            name,
            deviceid,
            key,
            createdat: formatDate(created),
            expireat: formatDate(expire),
            status: "active"
        }]);

    if (error) {

        // 🔐 حماية إضافية لو bypass
        if (error.code === "23505") {
            return res.json({
                status: "duplicate"
            });
        }

        return res.json({
            status: "error",
            message: error.message
        });
    }

    res.json({
        status: "success",
        key,
        expireat: formatDate(expire)
    });
});

/* =========================
   EXTEND KEY
========================= */
router.post("/extend_key", async (req, res) => {

    if (req.headers["x-api-key"] !== API_KEY) {
        return res.status(401).json({
            status: "unauthorized"
        });
    }

    const { key, days } = req.body;

    if (!key || !days) {
        return res.json({
            status: "error",
            message: "البيانات ناقصة"
        });
    }

    const { data } = await supabase
        .from("keys")
        .select("*")
        .eq("key", key)
        .single();

    if (!data) {
        return res.json({
            status: "not_found"
        });
    }

    let expire = new Date(data.expireat);
    const now = new Date();

    if (expire < now) {
        expire = now;
    }

    expire.setDate(expire.getDate() + parseInt(days));

    const { error } = await supabase
        .from("keys")
        .update({
            expireat: formatDate(expire),
            status: "active"
        })
        .eq("key", key);

    if (error) {
        return res.json({
            status: "error",
            message: error.message
        });
    }

    res.json({
        status: "success",
        expireat: formatDate(expire)
    });
});

module.exports = router;
