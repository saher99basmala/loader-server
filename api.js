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

// إنشاء مفتاح جديد
router.post("/create_key", async (req, res) => {

    if (req.headers["x-api-key"] !== API_KEY) {
        return res.status(401).json({
            success: false,
            message: "Unauthorized"
        });
    }

    const { name, deviceid, days } = req.body;

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
        return res.json({
            success: false,
            message: error.message
        });
    }

    res.json({
        success: true,
        key,
        expireat: formatDate(expire)
    });

});

// تمديد الاشتراك
router.post("/extend_key", async (req, res) => {

    if (req.headers["x-api-key"] !== API_KEY) {
        return res.status(401).json({
            success: false,
            message: "Unauthorized"
        });
    }

    const { key, days } = req.body;

    if (!key || !days) {
        return res.json({
            success: false,
            message: "يرجى إدخال المفتاح وعدد الأيام."
        });
    }

    const { data, error } = await supabase
        .from("keys")
        .select("*")
        .eq("key", key)
        .single();

    if (error || !data) {
        return res.json({
            success: false,
            message: "المفتاح غير موجود."
        });
    }

    if (data.status !== "active") {
        return res.json({
            success: false,
            message: "لا يمكن تمديد هذا المفتاح."
        });
    }

    let expire = new Date(data.expireat);
    const now = new Date();

    // إذا انتهى الاشتراك يبدأ من اليوم
    if (expire < now) {
        expire = now;
    }

    expire.setDate(expire.getDate() + parseInt(days));

    const { error: updateError } = await supabase
        .from("keys")
        .update({
            expireat: formatDate(expire)
        })
        .eq("key", key);

    if (updateError) {
        return res.json({
            success: false,
            message: updateError.message
        });
    }

    res.json({
        success: true,
        message: "تم تمديد الاشتراك بنجاح.",
        expireat: formatDate(expire)
    });

});

module.exports = router;
