'use strict';

const express = require("express");

const {
    mergeIntoTarget,
    TARGET_FILE
} = require("./xmlSectionMerger");

const router = express.Router();

/*
 * ============================================================
 * XML BODY
 * ============================================================
 *
 * نستقبل XML كنص خام.
 *
 * الحد الأقصى 20MB.
 * ============================================================
 */

router.use(
    express.text({
        type: [
            "application/xml",
            "text/xml",
            "text/plain",
            "application/octet-stream"
        ],
        limit: "20mb"
    })
);

/*
 * ============================================================
 * POST /api/xml-transfer/merge
 * ============================================================
 *
 * Lua يرسل:
 *
 * Content-Type: application/xml
 *
 * Body:
 * source XML
 *
 * السيرفر:
 *
 * source XML
 *      +
 * BS32.xml
 *      ↓
 * merge
 *      ↓
 * save BS32.xml
 *      ↓
 * return modified BS32.xml
 *
 * ============================================================
 */

router.post("/merge", (req, res) => {
    try {

        const sourceXml = req.body;

        /*
         * إذا لم يصل XML، فقط نرجع خطأ للطلب نفسه.
         */
        if (
            typeof sourceXml !== "string" ||
            !sourceXml.trim()
        ) {
            return res.status(400).json({
                success: false,
                error: "XML source is empty"
            });
        }

        /*
         * تنفيذ الدمج.
         *
         * الأقسام غير الموجودة في المصدر
         * يتم تخطيها تلقائياً.
         */
        const result =
            mergeIntoTarget(sourceXml);

        /*
         * نرجع XML الكامل بعد الدمج.
         */
        res.status(200);

        res.set(
            "Content-Type",
            "application/xml; charset=utf-8"
        );

        res.set(
            "X-XML-Merge",
            "success"
        );

        res.set(
            "X-XML-Target",
            "BS32.xml"
        );

        return res.send(
            result.xml
        );

    } catch (error) {

        console.error(
            "[XML TRANSFER] merge failed:",
            error
        );

        return res.status(500).json({
            success: false,
            error: "XML merge failed",
            message: error.message
        });
    }
});

/*
 * ============================================================
 * GET /api/xml-transfer/status
 * ============================================================
 */

router.get("/status", (req, res) => {
    try {

        const fs = require("fs");

        const exists =
            fs.existsSync(TARGET_FILE);

        return res.json({
            success: true,
            target: "BS32.xml",
            exists
        });

    } catch (error) {

        return res.status(500).json({
            success: false,
            error: error.message
        });
    }
});

module.exports = router;
