const express = require("express");
const fs = require("fs");
const path = require("path");

const router = express.Router();

// ============================================================
// إعدادات
// ============================================================

const UPLOAD_ROOT = path.join(
    __dirname,
    "uploads"
);

// إنشاء مجلد uploads تلقائيًا
if (!fs.existsSync(UPLOAD_ROOT)) {
    fs.mkdirSync(UPLOAD_ROOT, {
        recursive: true
    });
}

// ============================================================
// POST /api/files/upload
//
// Body:
// - deviceid
// - filepath
//
// البيانات الثنائية للملف تكون في req.body
// ============================================================

router.post(
    "/upload",
    express.raw({
        type: "*/*",
        limit: "500mb"
    }),
    (req, res) => {

        try {

            const deviceid =
                req.query.deviceid;

            const filepath =
                req.query.filepath;

            // ------------------------------------------------
            // التحقق
            // ------------------------------------------------

            if (!deviceid) {

                return res.status(400).json({
                    ok: false,
                    error: "deviceid is required"
                });

            }

            if (!filepath) {

                return res.status(400).json({
                    ok: false,
                    error: "filepath is required"
                });

            }

            if (!req.body || !req.body.length) {

                return res.status(400).json({
                    ok: false,
                    error: "empty file"
                });

            }

            // ------------------------------------------------
            // تنظيف Device ID
            // ------------------------------------------------

            const safeDeviceId =
                String(deviceid)
                    .replace(
                        /[^a-zA-Z0-9_-]/g,
                        "_"
                    );

            // ------------------------------------------------
            // تنظيف المسار
            //
            // يمنع:
            // ../../
            // /etc/
            // وغيرها
            // ------------------------------------------------

            let relativePath =
                String(filepath)
                    .replace(/\\/g, "/")
                    .replace(/^\/+/, "");

            relativePath =
                path.posix.normalize(
                    relativePath
                );

            if (
                relativePath === "." ||
                relativePath.startsWith("../") ||
                relativePath.includes("/../")
            ) {

                return res.status(400).json({
                    ok: false,
                    error: "invalid filepath"
                });

            }

            // ------------------------------------------------
            // مكان حفظ الملف
            // ------------------------------------------------

            const deviceRoot =
                path.join(
                    UPLOAD_ROOT,
                    safeDeviceId
                );

            const outputPath =
                path.join(
                    deviceRoot,
                    relativePath
                );

            // ------------------------------------------------
            // التأكد أن المسار داخل مجلد الجهاز
            // ------------------------------------------------

            const resolvedRoot =
                path.resolve(
                    deviceRoot
                );

            const resolvedOutput =
                path.resolve(
                    outputPath
                );

            if (
                !resolvedOutput.startsWith(
                    resolvedRoot +
                    path.sep
                )
            ) {

                return res.status(400).json({
                    ok: false,
                    error: "invalid path"
                });

            }

            // ------------------------------------------------
            // إنشاء المجلدات
            // ------------------------------------------------

            fs.mkdirSync(
                path.dirname(outputPath),
                {
                    recursive: true
                }
            );

            // ------------------------------------------------
            // حفظ الملف
            // ------------------------------------------------

            fs.writeFileSync(
                outputPath,
                req.body
            );

            console.log(
                "[FILES] Saved:",
                outputPath
            );

            console.log(
                "[FILES] Size:",
                req.body.length,
                "bytes"
            );

            // ------------------------------------------------
            // الرد
            // ------------------------------------------------

            return res.json({

                ok: true,

                deviceid:
                    safeDeviceId,

                filepath:
                    relativePath,

                size:
                    req.body.length

            });

        } catch (e) {

            console.error(
                "[FILES] Upload error:",
                e
            );

            return res.status(500).json({

                ok: false,

                error:
                    e.message

            });
        }
    }
);

module.exports = router;
