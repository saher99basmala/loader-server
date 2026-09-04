// ============================================
// mGameInfoEditor.js
// جميع تعديلات mGameInfo.xml
// ============================================


// ============================================
// تعديل Var عام
// ============================================

function changeVar(xml, varName, newValue) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    const text = xml.toString("utf8");

    const escapedName =
        String(varName).replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const pattern =
        new RegExp(
            `<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])[^>]*>`
        );

    const match = text.match(pattern);

    if (!match) {
        throw new Error(
            `لم يتم العثور على Var: ${varName}`
        );
    }

    const oldElement = match[0];

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

    // القيمة الجديدة هي نفسها القديمة
    if (newElement === oldElement) {
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


// ============================================
// تعديل DataElem عام
// ============================================

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

    // القيمة الجديدة هي نفسها القديمة
    if (newElement === oldElement) {
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


// ============================================
// تعديل المستوى
// ============================================

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

    if (newElement === oldElement) {
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


// ============================================
// قيم الإطارات والستايلات ورتب الخبرة
// ============================================

const UNLOCKED_FRAMES_VALUE =
    "JBsYDjhUWyATVlUjXw==,VEdYLhJsA309Gy0tFgIwCCM=";


const UNLOCKED_STYLES_VALUE =
    "gold,festival,cooking,bsboste,neon,default,animatedUnderwaterViolet,easter";


const UNLOCKED_EXP_RANKS_VALUE =
    "ciIfESAGOAQUVgEpVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0BqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVgApVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0FqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg8pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A05qCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg4pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A09qCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwcpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkZqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwYpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkdqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwUpVw84CH0QVzMnERINWg==,ciIfESAGOAQUVwQpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkRqCTkMGRU/MSEXEA9UUlE=,PxceLTU3ASA9AkVqCTkMGRU/MSEXEA9UUlE=";


// ============================================
// فتح جميع الكروت من 1 إلى 150
// ============================================

function unlockAllCards(xml) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    const text =
        xml.toString("utf8");

    const pattern =
        /<DataElem\b(?=[^>]*\bname=["']OwnedCards["'])[^>]*>/;

    const match =
        text.match(pattern);

    if (!match) {
        throw new Error(
            'لم يتم العثور على DataElem: OwnedCards'
        );
    }

    const start =
        match.index + match[0].length;

    /*
     * نبحث عن نهاية OwnedCards.
     * العناصر الموجودة بداخله كلها DataElem،
     * ونحدد الإغلاق الخاص بالـ array اعتمادًا
     * على البنية المتوقعة.
     */

    let depth = 1;
    let position = start;

    const tagPattern =
        /<\/?DataElem\b[^>]*>/g;

    tagPattern.lastIndex = start;

    let end = -1;
    let tag;

    while (
        (tag = tagPattern.exec(text)) !== null
    ) {

        const tagText = tag[0];

        if (
            /^<DataElem\b/i.test(tagText) &&
            !/\/>$/.test(tagText)
        ) {
            depth++;
        }

        if (
            /^<\/DataElem>/i.test(tagText)
        ) {
            depth--;

            if (depth === 0) {
                end = tag.index;
                break;
            }
        }
    }

    if (end === -1) {
        throw new Error(
            "تعذر تحديد نهاية OwnedCards"
        );
    }

    let cards = "";

    for (let i = 1; i <= 150; i++) {

        const cardId =
            `card_${String(i).padStart(2, "0")}`;

        cards +=
            `<DataElem type="dataStore">` +
            `<DataElem name="cardId" type="string" value="${cardId}"/>` +
            `<DataElem name="generatedCount" type="int" value="1"/>` +
            `<DataElem name="inStockCount" type="int" value="1"/>` +
            `<DataElem name="isNew" type="bool" value="false"/>` +
            `<DataElem name="maxInStockCount" type="int" value="1"/>` +
            `</DataElem>`;
    }

    const updated =
        text.slice(0, start) +
        cards +
        text.slice(end);

    return Buffer.from(
        updated,
        "utf8"
    );
}


// ============================================
// قائمة التعديلات
// ============================================

const EDITORS = {

    // ----------------------------------------
    // المستوى
    // ----------------------------------------

    level: function(xml, value) {

        return changeLevel(
            xml,
            value
        );

    },


    // ----------------------------------------
    // اسم المدينة
    // ----------------------------------------

    townName: function(xml, value) {

        return changeVar(
            xml,
            "townName",
            value
        );

    },


    // ----------------------------------------
    // إنجاز التعاون
    // ----------------------------------------

    achievementTeamwork: function(xml, value) {

        return changeVar(
            xml,
            "Achievement_Teamwork",
            value
        );

    },


    // ----------------------------------------
    // مستويات المحاولة الأولى
    // ----------------------------------------

    firstAttemptM3Levels: function(xml, value) {

        return changeVar(
            xml,
            "FirstAttemptM3Levels",
            value
        );

    },


    // ----------------------------------------
    // مجموعات البطاقات المكتملة
    // ----------------------------------------

    fullCardCollections: function(xml, value) {

        return changeVar(
            xml,
            "FullCardCollections",
            value
        );

    },


    // ----------------------------------------
    // الحيوات المرسلة
    // ----------------------------------------

    livesSent: function(xml, value) {

        return changeVar(
            xml,
            "LivesSent",
            value
        );

    },


    // ----------------------------------------
    // مستويات M3 المكتملة
    // ----------------------------------------

    m3CompLvls: function(xml, value) {

        return changeVar(
            xml,
            "m3_comp_lvls",
            value
        );

    },


    // ----------------------------------------
    // مهام السباق المكتملة
    // ----------------------------------------

    regataTasksCompleted: function(xml, value) {

        return changeVar(
            xml,
            "RegataTasksCompleted",
            value
        );

    },


    // ----------------------------------------
    // الإطارات
    // ----------------------------------------

    unlockedFrames: function(xml) {

        return changeDataElem(
            xml,
            "UnlockedFrames",
            UNLOCKED_FRAMES_VALUE
        );

    },


    // ----------------------------------------
    // الستايلات
    // ----------------------------------------

    unlockedStyles: function(xml) {

        return changeDataElem(
            xml,
            "UnlockedStyles",
            UNLOCKED_STYLES_VALUE
        );

    },


    // ----------------------------------------
    // رتب الخبرة
    // ----------------------------------------

    unlockedExpRanks: function(xml) {

        return changeDataElem(
            xml,
            "UnlockedExpRanks",
            UNLOCKED_EXP_RANKS_VALUE
        );

    },


    // ----------------------------------------
    // فتح جميع الكروت 1 - 150
    // ----------------------------------------

    unlockAllCards: function(xml) {

        return unlockAllCards(
            xml
        );

    }

};


// ============================================
// تنفيذ التعديلات
// ============================================

function applyEdits(
    xml,
    edits
) {

    if (!Array.isArray(edits)) {
        throw new Error(
            "قائمة التعديلات غير صحيحة"
        );
    }

    let result =
        xml;

    for (
        const edit of edits
    ) {

        if (
            !edit ||
            !edit.type
        ) {
            continue;
        }

        const editor =
            EDITORS[edit.type];

        if (!editor) {
            throw new Error(
                `التعديل غير معروف: ${edit.type}`
            );
        }

        result =
            editor(
                result,
                edit.value
            );

    }

    return result;
}


// ============================================
// التصدير
// ============================================

module.exports = {

    changeVar,
    changeDataElem,
    changeLevel,
    unlockAllCards,
    applyEdits

};
