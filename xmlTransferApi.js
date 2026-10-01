/*
 * xmlTransferApi.js
 *
 * Drop-in replacement for the existing XML Transfer API.
 *
 * Mounted by server.js as:
 *   app.use("/api/xml-transfer", xmlTransferApi);
 *
 * Endpoint:
 *   POST /api/xml-transfer/merge
 *
 * JSON:
 * {
 *   "myXml": "...",       // target XML; optional if BS32.xml exists
 *   "friendXml": "...",  // source XML
 *   "copySkins": false
 * }
 *
 * The target fallback is:
 *   ./BS32.xml
 *
 * This lets the GameGuardian Lua script send BOTH files.
 * No extra server endpoint is required.
 */

const express = require("express");
const fs = require("fs");
const path = require("path");

const router = express.Router();
const copyDesign = require("./desbanApi");

const MAX_XML = 50 * 1024 * 1024;
const DEFAULT_TARGET = path.join(process.cwd(), "BS32.xml");

function isXml(value) {
    return (
        typeof value === "string" &&
        value.length > 0 &&
        value.length <= MAX_XML &&
        /<root\b[^>]*>/i.test(value) &&
        /<\/root\s*>/i.test(value)
    );
}

function firstString(...values) {
    for (const value of values) {
        if (typeof value === "string" && value.trim()) {
            return value;
        }
    }
    return "";
}

function readTargetFromServer() {
    if (!fs.existsSync(DEFAULT_TARGET)) {
        return null;
    }

    const xml = fs.readFileSync(DEFAULT_TARGET, "utf8");

    return isXml(xml) ? xml : null;
}

router.get("/status", (req, res) => {
    const targetExists = fs.existsSync(DEFAULT_TARGET);

    return res.json({
        ok: true,
        service: "XML Transfer + Copy Design",
        endpoint: "/api/xml-transfer/merge",
        serverTarget: "BS32.xml",
        serverTargetExists: targetExists
    });
});

router.post("/merge", async (req, res) => {
    try {
        const body = req.body || {};

        // Lua normally sends both files.
        // If targetXml is absent, use ./BS32.xml on the server.
        let targetXml = firstString(
            body.myXml,
            body.targetXml
        );

        const sourceXml = firstString(
            body.friendXml,
            body.sourceXml,
            body.friend
        );

        if (!targetXml) {
            targetXml = readTargetFromServer();
        }

        if (!isXml(targetXml)) {
            return res.status(400).json({
                ok: false,
                status: "invalid_target_xml",
                error:
                    "target XML is missing/invalid and ./BS32.xml was not usable"
            });
        }

        if (!isXml(sourceXml)) {
            return res.status(400).json({
                ok: false,
                status: "invalid_source_xml",
                error: "friendXml/sourceXml is required and must be valid XML"
            });
        }

        const copySkins =
            body.copySkins === true ||
            body.copySkins === 1 ||
            body.copySkins === "1";

        console.log("[XML Transfer] /merge");
        console.log("[XML Transfer] target length:", targetXml.length);
        console.log("[XML Transfer] source length:", sourceXml.length);

        const result = copyDesign.processCopyDesign(
            targetXml,
            sourceXml,
            { copySkins }
        );

        return res.status(200).json({
            ok: true,
            status: "success",
            xml: result.xml,
            stats: result.stats
        });

    } catch (e) {
        console.error("[XML Transfer] merge error:", e);

        return res.status(500).json({
            ok: false,
            status: "server_error",
            error: e.message
        });
    }
});

module.exports = router;
