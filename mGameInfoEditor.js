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

    /*
    نفس القيمة = نجاح
    */

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

    /*
    نفس القيمة = نجاح
    */

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

    /*
    نفس المستوى = نجاح
    */

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
    "ciIfESAGOAQUVgEpVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0BqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVgApVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0FqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg8pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A05qCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg4pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A09qCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwcpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkZqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwYpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkdqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwUpVw84CH0QVzMnERINWg==,ciIfESAGOAQUVwQpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkRqCTkMGRU/MSEXEA9UUlE=,PxceLTU3ASA9AkVqCTkMGRU/MSEXEA9UUlE=";


/*
========================================
فتح جميع الكروت 1 - 150
========================================

كل بطاقة يتم إنشاؤها بالقيم:

generatedCount = 1000
inStockCount = 1000
maxInStockCount = 1000

والكروت:

card_01
card_02
...
card_150
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

    /*
    البحث عن OwnedCards
    */

    const openPattern =
        /<DataElem\b(?=[^>]*\bname=["']OwnedCards["'])[^>]*>/;

    const openMatch =
        text.match(openPattern);

    if (!openMatch) {

        throw new Error(
            'لم يتم العثور على OwnedCards'
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

    /*
    البحث عن نهاية OwnedCards
    */

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

        /*
        تجاهل DataElem ذاتية الإغلاق
        */

        if (
            /^<DataElem\b[^>]*\/\s*>$/i.test(tag)
        ) {

            continue;

        }

        /*
        DataElem مفتوح
        */

        if (
            /^<DataElem\b/i.test(tag)
        ) {

            depth++;

        }

        /*
        DataElem مغلق
        */

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

    /*
    ========================================
    إنشاء الكروت
    ========================================
    */

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

    /*
    ========================================
    استبدال محتوى OwnedCards
    ========================================
    */

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
    فتح وإظهار الكروت 1 - 150
    بقيمة 1000 تلقائيًا
    */

    unlockAllCards: function(
        xml
    ) {

        return unlockAllCards(
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
    حماية إضافية
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
    تنفيذ التعديلات بالترتيب
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
            EDITORS[editName];

        if (!editor) {

            throw new Error(
                `تعديل غير معروف: ${editName}`
            );

        }

        result =
            editor(
                result,
                edits[editName]
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

    unlockAllCards

};
