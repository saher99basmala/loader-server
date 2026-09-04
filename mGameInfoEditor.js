/*
========================================
mGameInfoEditor.js
========================================
*/


/*
========================================
تعديل Var عام
========================================
*/

function changeVar(
    xml,
    varName,
    newValue
) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    const text =
        xml.toString("utf8");

    const escapedName =
        String(varName).replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const pattern =
        new RegExp(
            `<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])[^>]*>`
        );

    const match =
        text.match(pattern);

    if (!match) {

        throw new Error(
            `لم يتم العثور على Var: ${varName}`
        );

    }

    const oldElement =
        match[0];

    const newValueString =
        String(newValue)
            .replace(/&/g, "&amp;")
            .replace(/"/g, "&quot;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;");

    const newElement =
        oldElement.replace(
            /(\bv\s*=\s*)(["'])[^"']*\2/,
            `$1"${newValueString}"`
        );

    if (
        newElement === oldElement
    ) {

        return Buffer.from(
            text,
            "utf8"
        );

    }

    return Buffer.from(
        text.replace(
            oldElement,
            newElement
        ),
        "utf8"
    );
}


/*
========================================
تعديل DataElem عام
========================================
*/

function changeDataElem(
    xml,
    elemName,
    newValue
) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    const text =
        xml.toString("utf8");

    const escapedName =
        String(elemName).replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const pattern =
        new RegExp(
            `<DataElem\\b(?=[^>]*\\bname=["']${escapedName}["'])[^>]*>`
        );

    const match =
        text.match(pattern);

    if (!match) {

        throw new Error(
            `لم يتم العثور على DataElem: ${elemName}`
        );

    }

    const oldElement =
        match[0];

    const valuePattern =
        /(\bvalue\s*=\s*)(["'])([^"']*)\2/;

    const valueMatch =
        oldElement.match(valuePattern);

    if (!valueMatch) {

        throw new Error(
            `لم يتم العثور على الخاصية value داخل ${elemName}`
        );

    }

    const newValueString =
        String(newValue)
            .replace(/&/g, "&amp;")
            .replace(/"/g, "&quot;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;");

    const newElement =
        oldElement.replace(
            valuePattern,
            `$1$2${newValueString}$2`
        );

    if (
        newElement === oldElement
    ) {

        return Buffer.from(
            text,
            "utf8"
        );

    }

    return Buffer.from(
        text.replace(
            oldElement,
            newElement
        ),
        "utf8"
    );
}


/*
========================================
تعديل المستوى
========================================
*/

function changeLevel(
    xml,
    newLevel
) {

    newLevel =
        Number(newLevel);

    if (
        !Number.isInteger(newLevel) ||
        newLevel < 0
    ) {

        throw new Error(
            "المستوى يجب أن يكون رقمًا صحيحًا"
        );

    }

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    const text =
        xml.toString("utf8");

    const pattern =
        /<Var\b(?=[^>]*\bname=["']levelup["'])[^>]*>/;

    const match =
        text.match(pattern);

    if (!match) {

        throw new Error(
            'لم يتم العثور على عنصر name="levelup"'
        );

    }

    const oldElement =
        match[0];

    const newElement =
        oldElement.replace(
            /(\bv=["'])[^"']*(["'])/,
            `$1${newLevel}$2`
        );

    if (
        newElement === oldElement
    ) {

        return Buffer.from(
            text,
            "utf8"
        );

    }

    const updated =
        text.replace(
            oldElement,
            newElement
        );

    return Buffer.from(
        updated,
        "utf8"
    );
}


/*
========================================
القيم الثابتة
========================================
*/

const UNLOCKED_FRAMES_VALUE =
    "JBsYDjhUWyATVlUjXw==,VEdYLhJsA309Gy0tFgIwCCM=";


const UNLOCKED_STYLES_VALUE =
    "gold,festival,cooking,bsboste,neon,default,animatedUnderwaterViolet,easter";


const UNLOCKED_EXP_RANKS_VALUE =
    "ciIfESAGOAQUVgEpVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0BqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVgApVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0FqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg8pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A05qCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg4pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A09qCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwcpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkZqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwYpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkdqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwUpVw84CH0QVzMnERINWg==,ciIfESAGOAQUVwQpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkRqCTkMGRU/MSEXEA9UlE=,PxceLTU3ASA9AkVqCTkMGRU/MSEXEA9UlE=";


/*
========================================
فتح جميع الكروت 1 - 150
========================================
*/

function unlockAllCards(
    xml
) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    const text =
        xml.toString("utf8");

    const openPattern =
        /<DataElem\b(?=[^>]*\bname=["']OwnedCards["'])[^>]*>/;

    const openMatch =
        text.match(openPattern);

    if (!openMatch) {

        throw new Error(
            "لم يتم العثور على OwnedCards"
        );

    }

    const start =
        openMatch.index;

    const openTag =
        openMatch[0];

    let position =
        start + openTag.length;

    let depth =
        1;

    let end =
        -1;

    const tagPattern =
        /<DataElem\b[^>]*>|<\/DataElem\s*>/g;

    tagPattern.lastIndex =
        position;

    let tagMatch;

    while (
        (tagMatch = tagPattern.exec(text)) !== null
    ) {

        const tag =
            tagMatch[0];

        if (
            /^<DataElem\b[^>]*\/\s*>$/i.test(tag)
        ) {

            continue;

        }

        if (
            /^<DataElem\b/i.test(tag)
        ) {

            depth++;

        }

        else if (
            /^<\/DataElem/i.test(tag)
        ) {

            depth--;

            if (
                depth === 0
            ) {

                end =
                    tagMatch.index;

                break;

            }

        }

    }

    if (
        end === -1
    ) {

        throw new Error(
            "لم يتم العثور على نهاية OwnedCards"
        );

    }

    let cards =
        "";

    for (
        let i = 1;
        i <= 150;
        i++
    ) {

        const cardId =
            `card_${String(i).padStart(2, "0")}`;

        cards += `
<DataElem type="dataStore">
<DataElem name="cardId" type="string" value="${cardId}"/>
<DataElem name="generatedCount" type="int" value="1000"/>
<DataElem name="inStockCount" type="int" value="1000"/>
<DataElem name="isNew" type="bool" value="false"/>
<DataElem name="maxInStockCount" type="int" value="1000"/>
</DataElem>`;

    }

    const updated =
        text.substring(
            0,
            start + openTag.length
        ) +
        cards +
        text.substring(
            end
        );

    return Buffer.from(
        updated,
        "utf8"
    );
}


/*
========================================
فتح جميع توسعات الأراضي
========================================

يضيف توسعات expandBuy إلى Buildings.

إذا كان bid موجودًا مسبقًا:
لا يتم تكراره.

القيم مأخوذة من القائمة التي أرسلتها.
========================================
*/

function unlockLandExpansions(
    xml
) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    let text =
        xml.toString("utf8");

    const buildingsOpen =
        text.indexOf(
            "<Buildings>"
        );

    if (
        buildingsOpen === -1
    ) {

        throw new Error(
            "لم يتم العثور على <Buildings>"
        );

    }

    const buildingsClose =
        text.indexOf(
            "</Buildings>",
            buildingsOpen
        );

    if (
        buildingsClose === -1
    ) {

        throw new Error(
            "لم يتم العثور على </Buildings>"
        );

    }

    /*
    ========================================
    قائمة توسعات الأراضي
    ========================================
    */

    const expansions = [

        ["1YaUwW-JGN", 20, 11],
        ["1YaUwW-JGM", 17, 11],
        ["1YaUwW-JGL", 44, 29],
        ["1YaUwW-JGK", 41, 26],
        ["1YaUwW-JGJ", 38, 26],
        ["1YaUwW-JGI", 35, 23],
        ["1YaUwW-JGH", 2, 26],
        ["1YaUwW-JGG", 5, 20],
        ["1YaUwW-JGF", 5, 23],
        ["1YaUwW-JGE", 41, 29],
        ["1YaUwW-JGD", 44, 32],
        ["1YaUwW-JGC", 23, 14],
        ["1YaUwW-JGB", 26, 17],
        ["1YaUwW-JGA", 8, 17],
        ["1YaUwW-JFZ", 11, 14],
        ["1YaUwW-JFY", 17, 14],
        ["1YaUwW-JFX", 20, 14],
        ["1YaUwW-JFW", 8, 20],
        ["1YaUwW-JFV", 11, 17],
        ["1YaUwW-JFU", 14, 14],
        ["1YaUwW-JFT", 14, 17],
        ["1YaUwW-JFS", 8, 23],
        ["1YaUwW-JFR", 11, 20],
        ["1YaUwW-JFQ", 5, 26],
        ["1YaUwW-JFP", 2, 29],
        ["1YaUwW-JFO", 2, 32],
        ["1YaUwW-JFN", 5, 32],
        ["1YaUwW-JFM", 5, 29],
        ["1YaUwW-JFL", 8, 29],
        ["1YaUwW-JFK", 8, 26],
        ["1YaUwW-JFJ", 11, 23],
        ["1YaUwW-JFI", 14, 20],
        ["1YaUwW-JFH", 17, 17],
        ["1YaUwW-JFG", 2, 41],
        ["1YaUwW-JFF", 8, 32],
        ["1YaUwW-JFE", 2, 35],
        ["1YaUwW-JFD", 2, 47],
        ["1YaUwW-JFC", 2, 44],
        ["1YaUwW-JFB", 5, 47],
        ["1YaUwW-JFA", 5, 44],
        ["1YaUwW-JEZ", 2, 38],
        ["1YaUwW-JEY", 5, 41],
        ["1YaUwW-JEX", 5, 38],
        ["1YaUwW-JEW", 5, 35],
        ["1YaUwW-JEV", 8, 47],
        ["1YaUwW-JEU", 8, 44],
        ["1YaUwW-JET", 11, 26],
        ["1YaUwW-JES", 14, 23],
        ["1YaUwW-JER", 17, 20],
        ["1YaUwW-JEQ", 20, 17],
        ["1YaUwW-JEP", 23, 17],
        ["1YaUwW-JEO", 11, 32],
        ["1YaUwW-JEN", 14, 29],
        ["1YaUwW-JEM", 17, 26],
        ["1YaUwW-JEL", 20, 23],
        ["1YaUwW-JEK", 23, 20],
        ["1YaUwW-JEJ", 11, 29],
        ["1YaUwW-JEI", 14, 26],
        ["1YaUwW-JEH", 17, 23],
        ["1YaUwW-JEG", 8, 35],
        ["1YaUwW-JEF", 20, 20],

        ["1YaUwW-Vkd", 11, 35],
        ["1YaUwW-Vkc", 14, 32],
        ["1YaUwW-Vkb", 17, 29],
        ["1YaUwW-Vka", 20, 26],
        ["1YaUwW-Vjz", 23, 23],
        ["1YaUwW-Vjy", 26, 20],
        ["1YaUwW-Vjx", 29, 20],
        ["1YaUwW-Vjw", 32, 23],
        ["1YaUwW-Vju", 8, 38],
        ["1YaUwW-Vjt", 8, 41],
        ["1YaUwW-Vjs", 20, 29],

        ["1YaUwW-qmY", 38, 32],
        ["1YaUwW-HBk", 26, 23],
        ["1YaUwW-OIv", 29, 23],
        ["1YaUwW-pWV", 41, 32],
        ["1YaUwW-ccU", 35, 32],
        ["1YaUwW-Apb", 32, 32],
        ["1YaUwW-INg", 35, 26],
        ["1YaUwW-Giw", 32, 26],
        ["1YaUwW-j38", 29, 26],
        ["1YaUwW-ygp", 26, 26],
        ["1YaUwW-JEE", 23, 26],
        ["1YaUwW-ovu", 38, 29],
        ["1YaUwW-6PK", 35, 29],
        ["1YaUwW-g5j", 32, 29],
        ["1YaUwW-5yT", 29, 29],
        ["1YaUwW-UFF", 26, 29],
        ["1YaUwW-Fp3", 23, 29],
        ["1YaUwW-fRx", 29, 32],
        ["1YaUwW-XQj", 26, 32],
        ["1YaUwW-O7m", 23, 32],
        ["1YaUwW-EKm", 20, 32],
        ["1YaUwW-WbF", 17, 32],

        ["1YaUwW-hCw", 41, 35],
        ["1YaUwW-hTn", 44, 35],
        ["1YaUwW-g42", 38, 35],
        ["1YaUwW-mcU", 35, 35],
        ["1YaUwW-xvV", 32, 35],
        ["1YaUwW-EMR", 29, 35],
        ["1YaUwW-5kU", 26, 35],
        ["1YaUwW-3gR", 23, 35],
        ["1YaUwW-kst", 20, 35],
        ["1YaUwW-4ps", 17, 35],
        ["1YaUwW-OLj", 14, 35],
        ["1YaUwS-M3e", 11, 38],

        ["1YaUwW-8PU", 41, 41],
        ["1YaUwW-pjN", 44, 38],
        ["1YaUwW-Nh5", 41, 38],
        ["1YaUwW-1VW", 38, 38],

        ["1ZPSgh-111", 44, 26],
        ["1ZPSgh-112", 23, 11],
        ["1ZPSgh-113", 29, 17]
    ];


    /*
    ========================================
    إضافة التوسعات
    ========================================
    */

    let additions =
        "";

    let added =
        0;

    for (
        const expansion of expansions
    ) {

        const bid =
            expansion[0];

        const i =
            expansion[1];

        const j =
            expansion[2];

        /*
        منع التكرار
        */

        const bidPattern =
            new RegExp(
                `"bid"\\s*:\\s*["']${bid.replace(
                    /[.*+?^${}()|[\]\\]/g,
                    "\\$&"
                )}["']`
            );

        if (
            bidPattern.test(
                text.slice(
                    buildingsOpen,
                    buildingsClose
                )
            )
        ) {

            continue;

        }

        additions +=
            `<Object data='{"bid":"${bid}","i":${i},"j":${j},"storeId":"expandBuy","state":1}'/>`;

        added++;

    }


    /*
    ========================================
    لا توجد إضافات جديدة
    ========================================
    */

    if (
        additions.length === 0
    ) {

        return Buffer.from(
            text,
            "utf8"
        );

    }


    /*
    ========================================
    إدخال التوسعات قبل </Buildings>
    ========================================
    */

    text =
        text.slice(
            0,
            buildingsClose
        ) +
        additions +
        text.slice(
            buildingsClose
        );


    return Buffer.from(
        text,
        "utf8"
    );
}


/*
========================================
EDITORS
========================================
*/

const EDITORS = {

    /*
    المستوى
    */

    level: function(
        xml,
        value
    ) {

        return changeLevel(
            xml,
            value
        );

    },


    /*
    اسم المدينة
    */

    townName: function(
        xml,
        value
    ) {

        return changeVar(
            xml,
            "townName",
            value
        );

    },


    /*
    إنجاز التعاون
    */

    achievementTeamwork: function(
        xml,
        value
    ) {

        return changeVar(
            xml,
            "Achievement_Teamwork",
            value
        );

    },


    /*
    مستويات المحاولة الأولى
    */

    firstAttemptM3Levels: function(
        xml,
        value
    ) {

        return changeVar(
            xml,
            "FirstAttemptM3Levels",
            value
        );

    },


    /*
    مجموعات البطاقات المكتملة
    */

    fullCardCollections: function(
        xml,
        value
    ) {

        return changeVar(
            xml,
            "FullCardCollections",
            value
        );

    },


    /*
    الحيوات المرسلة
    */

    livesSent: function(
        xml,
        value
    ) {

        return changeVar(
            xml,
            "LivesSent",
            value
        );

    },


    /*
    مستويات M3 المكتملة
    */

    m3CompLvls: function(
        xml,
        value
    ) {

        return changeVar(
            xml,
            "m3_comp_lvls",
            value
        );

    },


    /*
    مهام السباق المكتملة
    */

    regataTasksCompleted: function(
        xml,
        value
    ) {

        return changeVar(
            xml,
            "RegataTasksCompleted",
            value
        );

    },


    /*
    فتح الإطارات
    */

    unlockedFrames: function(
        xml
    ) {

        return changeDataElem(
            xml,
            "UnlockedFrames",
            UNLOCKED_FRAMES_VALUE
        );

    },


    /*
    فتح الستايلات
    */

    unlockedStyles: function(
        xml
    ) {

        return changeDataElem(
            xml,
            "UnlockedStyles",
            UNLOCKED_STYLES_VALUE
        );

    },


    /*
    فتح رتب الخبرة
    */

    unlockedExpRanks: function(
        xml
    ) {

        return changeDataElem(
            xml,
            "UnlockedExpRanks",
            UNLOCKED_EXP_RANKS_VALUE
        );

    },


    /*
    فتح الكروت 1 - 150
    */

    unlockAllCards: function(
        xml
    ) {

        return unlockAllCards(
            xml
        );

    },


    /*
    فتح جميع توسعات الأراضي
    */

    unlockLandExpansions: function(
        xml
    ) {

        return unlockLandExpansions(
            xml
        );

    }

};


/*
========================================
APPLY EDITS
========================================
*/

function applyEdits(
    xml,
    edits
) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    let result =
        xml;

    /*
    ========================================
    التحقق من صيغة التعديلات
    ========================================
    */

    if (
        !edits ||
        typeof edits !== "object" ||
        Array.isArray(edits)
    ) {

        throw new Error(
            "صيغة التعديلات غير صحيحة"
        );

    }


    /*
    ========================================
    تنفيذ التعديلات
    ========================================
    */

    for (
        const editName in edits
    ) {

        if (
            !Object.prototype.hasOwnProperty.call(
                edits,
                editName
            )
        ) {

            continue;

        }

        const editor =
            EDITORS[
                editName
            ];

        if (!editor) {

            throw new Error(
                `تعديل غير معروف: ${editName}`
            );

        }

        result =
            editor(
                result,
                edits[
                    editName
                ]
            );

    }

    return result;
}


/*
========================================
EXPORT
========================================
*/

module.exports = {

    applyEdits,

    changeVar,

    changeDataElem,

    changeLevel,

    unlockAllCards,

    unlockLandExpansions

};
