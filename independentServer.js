"use strict";

const express = require("express");
const fs = require("fs");
const path = require("path");
const crypto = require("crypto");

const router = express.Router();


// ============================================================
// CONFIG
// ============================================================

const OUTPUT_DIR =
    process.env.INDEPENDENT_OUTPUT_DIR ||
    path.join(__dirname, "independent_output");

const MAX_XML_SIZE =
    50 * 1024 * 1024;


// ============================================================
// إنشاء مجلد الإخراج
// ============================================================

try {

    fs.mkdirSync(
        OUTPUT_DIR,
        {
            recursive: true
        }
    );

} catch (e) {

    console.error(
        "[Independent] Cannot create output directory:",
        e
    );

}


// ============================================================
// أدوات عامة
// ============================================================

function makeId() {

    return (
        Date.now().toString(36) +
        "_" +
        crypto.randomBytes(5).toString("hex")
    );
}


function asText(body) {

    if (Buffer.isBuffer(body)) {

        return body.toString("utf8");

    }

    if (typeof body === "string") {

        return body;

    }

    return String(body || "");
}


function isXml(text) {

    if (!text) {
        return false;
    }

    const s =
        text
            .replace(/^\uFEFF/, "")
            .trim();

    return (
        s.startsWith("<?xml") ||
        s.startsWith("<root") ||
        s.startsWith("<Local") ||
        s.startsWith("<Global")
    );
}


// ============================================================
// XML helpers
// ============================================================

function normalizeBom(xml) {

    return String(xml || "")
        .replace(/^\uFEFF/, "");
}


function normalizeLineEndings(xml) {

    return String(xml || "")
        .replace(/\r\n/g, "\n")
        .replace(/\r/g, "\n");
}


/*
 * يحافظ على محتوى XML كما هو تقريبًا،
 * ويزيل المسافات الزائدة فقط في بداية/نهاية الملف.
 */
function trimXml(xml) {

    return String(xml || "")
        .replace(/^\s+/, "")
        .replace(/\s+$/, "");
}


/*
 * التأكد من وجود XML declaration.
 *
 * لا نضيف declaration تلقائيًا إذا كان الملف
 * يحتوي أصلًا على declaration.
 */
function normalizeXmlDeclaration(xml) {

    let text =
        String(xml || "");

    text =
        text.replace(
            /^\s*<\?xml[^>]*\?>\s*/i,
            ""
        );

    return (
        '<?xml version="1.0" encoding="UTF-8"?>\n' +
        text
    );
}


// ============================================================
// استخراج معلومات XML
// ============================================================

function getRootName(xml) {

    const match =
        String(xml || "").match(
            /<([A-Za-z_][\w:.-]*)\b[^>]*>/i
        );

    if (!match) {
        return null;
    }

    return match[1];
}


function countMatches(xml, regex) {

    const text =
        String(xml || "");

    const flags =
        regex.flags.includes("g")
            ? regex.flags
            : regex.flags + "g";

    const r =
        new RegExp(
            regex.source,
            flags
        );

    let count = 0;

    while (r.exec(text) !== null) {
        count++;
    }

    return count;
}


function getXmlStats(xml) {

    const text =
        String(xml || "");

    return {

        bytes:
            Buffer.byteLength(
                text,
                "utf8"
            ),

        chars:
            text.length,

        vars:
            countMatches(
                text,
                /<Var\b/gi
            ),

        objects:
            countMatches(
                text,
                /<Object\b/gi
            ),

        items:
            countMatches(
                text,
                /<item\b/gi
            ),

        dataElems:
            countMatches(
                text,
                /<DataElem\b/gi
            ),

        root:
            getRootName(text)
    };
}


// ============================================================
// Var helpers
// ============================================================

/*
 * مطابق لفكرة U0 في التطبيق:
 *
 * حذف Var عندما يكون name مساويًا للاسم المطلوب.
 *
 * هذه الدالة عامة ولا تحتوي قائمة خاصة بحظر الحساب.
 */
function removeXmlVarExact(
    xml,
    fieldName
) {

    if (
        !fieldName ||
        typeof fieldName !== "string"
    ) {

        return xml;
    }

    const escaped =
        fieldName.replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const pattern =
        new RegExp(
            "\\s*<Var\\b[^>]*name\\s*=\\s*['\"]" +
            escaped +
            "['\"][^>]*/>\\s*",
            "gis"
        );

    return String(xml || "")
        .replace(
            pattern,
            "\n"
        );
}


/*
 * مطابق لفكرة V0:
 *
 * يبحث عن Var يبدأ اسمه بالقيمة المطلوبة
 * ويمكن أن يحتوي الاسم على suffix.
 */
function removeXmlVarPrefix(
    xml,
    fieldPrefix
) {

    if (
        !fieldPrefix ||
        typeof fieldPrefix !== "string"
    ) {

        return xml;
    }

    const escaped =
        fieldPrefix.replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const pattern =
        new RegExp(
            "\\s*<Var\\b[^>]*name\\s*=\\s*['\"]" +
            escaped +
            "[^'\"]*['\"][^>]*/>\\s*",
            "gis"
        );

    return String(xml || "")
        .replace(
            pattern,
            "\n"
        );
}


// ============================================================
// تنظيف XML العام
// ============================================================

function cleanXml(xml) {

    let result =
        normalizeBom(xml);

    result =
        normalizeLineEndings(result);

    /*
     * لا نعدل قيم اللعبة أو الهوية أو بيانات الحساب.
     * التنظيف هنا شكلي/بنيوي فقط.
     */

    result =
        result.replace(
            /[ \t]+\n/g,
            "\n"
        );

    result =
        result.replace(
            /\n{4,}/g,
            "\n\n\n"
        );

    result =
        trimXml(result);

    return result;
}


// ============================================================
// فحص بنية XML
// ============================================================

function validateBasicXml(xml) {

    const text =
        String(xml || "").trim();

    if (!text) {

        return {
            ok: false,
            reason: "empty_xml"
        };

    }

    if (!isXml(text)) {

        return {
            ok: false,
            reason: "not_xml"
        };

    }

    /*
     * فحص بسيط جدًا للأقواس.
     * لا نستعمل XML parser خارجي حتى يبقى
     * الملف مستقلًا ولا يحتاج dependency إضافية.
     */

    const openTags =
        countMatches(
            text,
            /<([A-Za-z_][\w:.-]*)\b[^>]*>/g
        );

    const closeTags =
        countMatches(
            text,
            /<\/([A-Za-z_][\w:.-]*)\s*>/g
        );

    /*
     * هذا ليس parser كاملًا.
     * لذلك نستخدمه كمؤشر فقط.
     */
    const looksReasonable =
        openTags > 0 &&
        closeTags > 0;

    return {

        ok:
            looksReasonable,

        reason:
            looksReasonable
                ? "ok"
                : "invalid_structure",

        root:
            getRootName(text),

        openTags,

        closeTags
    };
}


// ============================================================
// حفظ الملفات
// ============================================================

function saveFile(
    filename,
    data
) {

    const safeName =
        path.basename(filename);

    const fullPath =
        path.join(
            OUTPUT_DIR,
            safeName
        );

    fs.writeFileSync(
        fullPath,
        data
    );

    return fullPath;
}


// ============================================================
// POST /process-xml
// ============================================================

router.post(
    "/process-xml",

    express.raw({
        type: [
            "application/xml",
            "text/xml",
            "application/octet-stream",
            "text/plain"
        ],

        limit: "50mb"
    }),

    async (req, res) => {

        const jobId =
            makeId();

        try {

            let xml =
                asText(req.body);

            if (
                Buffer.byteLength(
                    xml,
                    "utf8"
                ) > MAX_XML_SIZE
            ) {

                return res.status(413).json({

                    success: false,

                    error:
                        "XML file is too large",

                    jobId
                });
            }


            // ------------------------------------------------
            // 1. فحص الملف الأصلي
            // ------------------------------------------------

            const before =
                getXmlStats(xml);

            const validation =
                validateBasicXml(xml);


            if (!validation.ok) {

                return res.status(400).json({

                    success: false,

                    error:
                        validation.reason,

                    jobId,

                    input:
                        before
                });
            }


            // ------------------------------------------------
            // 2. تنظيف عام
            // ------------------------------------------------

            const originalXml =
                xml;

            xml =
                cleanXml(xml);


            // ------------------------------------------------
            // 3. إحصائيات الناتج
            // ------------------------------------------------

            const after =
                getXmlStats(xml);


            // ------------------------------------------------
            // 4. حفظ الأصل والناتج
            // ------------------------------------------------

            const inputFile =
                "input_" +
                jobId +
                ".xml";

            const outputFile =
                "output_" +
                jobId +
                ".xml";


            const inputPath =
                saveFile(
                    inputFile,
                    originalXml
                );


            const outputPath =
                saveFile(
                    outputFile,
                    xml
                );


            console.log(
                "[Independent] processed:",
                jobId
            );

            console.log(
                "[Independent] input:",
                inputPath
            );

            console.log(
                "[Independent] output:",
                outputPath
            );


            // ------------------------------------------------
            // 5. إعادة الملف نفسه
            // ------------------------------------------------

            res.set(
                "Content-Type",
                "application/xml; charset=utf-8"
            );

            res.set(
                "Content-Disposition",
                'attachment; filename="' +
                outputFile +
                '"'
            );

            res.set(
                "X-Independent-Job",
                jobId
            );


            return res.send(
                Buffer.from(
                    xml,
                    "utf8"
                )
            );


        } catch (e) {

            console.error(
                "[Independent] process error:",
                e
            );

            return res.status(500).json({

                success: false,

                error:
                    e.message,

                jobId
            });
        }
    }
);


// ============================================================
// POST /analyze-xml
// ============================================================

router.post(
    "/analyze-xml",

    express.raw({
        type: [
            "application/xml",
            "text/xml",
            "application/octet-stream",
            "text/plain"
        ],

        limit: "50mb"
    }),

    (req, res) => {

        try {

            const xml =
                asText(req.body);

            const validation =
                validateBasicXml(xml);

            const stats =
                getXmlStats(xml);


            return res.json({

                success:
                    validation.ok,

                validation,

                stats
            });


        } catch (e) {

            console.error(
                "[Independent] analyze error:",
                e
            );

            return res.status(500).json({

                success: false,

                error:
                    e.message
            });
        }
    }
);


// ============================================================
// GET /health
// ============================================================

router.get(
    "/health",

    (req, res) => {

        return res.json({

            status:
                "ok",

            module:
                "independent",

            outputDir:
                OUTPUT_DIR,

            timestamp:
                new Date().toISOString()
        });
    }
);


// ============================================================
// GET /file/:name
// ============================================================

router.get(
    "/file/:name",

    (req, res) => {

        try {

            const filename =
                path.basename(
                    req.params.name
                );

            const fullPath =
                path.join(
                    OUTPUT_DIR,
                    filename
                );


            if (
                !fs.existsSync(
                    fullPath
                )
            ) {

                return res.status(404).json({

                    success: false,

                    error:
                        "File not found"
                });
            }


            return res.sendFile(
                fullPath
            );


        } catch (e) {

            console.error(
                "[Independent] file error:",
                e
            );

            return res.status(500).json({

                success: false,

                error:
                    e.message
            });
        }
    }
);


// ============================================================
// معلومات الوحدة
// ============================================================

router.get(
    "/",

    (req, res) => {

        return res.json({

            module:
                "Independent XML Processor",

            status:
                "ready",

            endpoints: {

                health:
                    "GET /api/independent/health",

                analyze:
                    "POST /api/independent/analyze-xml",

                process:
                    "POST /api/independent/process-xml",

                file:
                    "GET /api/independent/file/:name"
            }
        });
    }
);


// ============================================================
// Export
// ============================================================

module.exports =
    router;
