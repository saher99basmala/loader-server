"use strict";

// ============================================================
// fetchCityCleaner.js
// XML Cleaner
// ============================================================

function normalizeXml(xml) {

    let text =
        Buffer.isBuffer(xml)
            ? xml.toString("utf8")
            : String(xml || "");

    // إزالة BOM
    text =
        text.replace(
            /^\uFEFF/,
            ""
        );

    // توحيد نهاية الأسطر
    text =
        text.replace(
            /\r\n/g,
            "\n"
        );

    text =
        text.replace(
            /\r/g,
            "\n"
        );

    // قص أي بيانات بعد </root>
    const rootEnd =
        text.lastIndexOf("</root>");

    if (
        rootEnd !== -1
    ) {

        text =
            text.slice(
                0,
                rootEnd +
                "</root>".length
            );
    }

    return text.trim();
}


// ============================================================
// XML validation
// ============================================================

function validateXml(xml) {

    const text =
        normalizeXml(xml);

    if (!text) {

        throw new Error(
            "XML فارغ"
        );
    }

    if (
        !text.startsWith("<")
    ) {

        throw new Error(
            "البيانات ليست XML"
        );
    }

    return text;
}


// ============================================================
// CLEAN
// ============================================================

function cleanFetchCityXml(xml) {

    console.log(
        "[Cleaner] بدء تنظيف XML"
    );

    const cleaned =
        validateXml(xml);

    console.log(
        "[Cleaner] XML input size:",
        Buffer.byteLength(
            cleaned,
            "utf8"
        )
    );

    console.log(
        "[Cleaner] تنظيف XML انتهى"
    );

    return Buffer.from(
        cleaned,
        "utf8"
    );
}


// ============================================================
// EXPORT
// ============================================================

module.exports = {

    cleanFetchCityXml,

    normalizeXml,

    validateXml
};
