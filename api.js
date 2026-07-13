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

module.exports = router;
