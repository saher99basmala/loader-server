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


function changeLevel(xml, newLevel) {

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


const UNLOCKED_FRAMES_VALUE =
    "JBsYDjhUWyATVlUjXw==,VEdYLhJsA309Gy0tFgIwCCM=";


const UNLOCKED_STYLES_VALUE =
    "gold,festival,cooking,bsboste,neon,default,animatedUnderwaterViolet,easter";


const UNLOCKED_EXP_RANKS_VALUE =
    "ciIfESAGOAQUVgEpVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0BqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVgApVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0FqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg8pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A05qCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg4pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A09qCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAUVwcpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkZqCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVwYpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkdqCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVwUpVw84CH0QVzMnERINWg==,ciIfESAGOAQUVwQpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkRqCTkMGRU/MSEXEA9UlE=,PxceLTU3ASA9AkVqCTkMGRU/MSEXEA9UlE=";


/*
========================================
فتح جميع الكروت 1 - 150
========================================
*/

function unlockAllCards(xml) {

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
            'لم يتم العثور على OwnedCards'
        );
    }

    const start =
        openMatch.index;

    const openTag =
        openMatch[0];

    let position =
        start + openTag.length;

    let depth = 1;
    let end = -1;

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

            if (depth === 0) {
                end =
                    tagMatch.index;

                break;
            }
        }
    }

    if (end === -1) {
        throw new Error(
            "لم يتم العثور على نهاية OwnedCards"
        );
    }

    let cards = "";

    for (let i = 1; i <= 150; i++) {

        const cardId =
            `card_${String(i).padStart(2, "0")}`;

        cards += `
<DataElem type="dataStore">
<DataElem name="cardId" type="string" value="${cardId}"/>
<DataElem name="generatedCount" type="int" value="1"/>
<DataElem name="inStockCount" type="int" value="1"/>
<DataElem name="isNew" type="bool" value="false"/>
<DataElem name="maxInStockCount" type="int" value="1"/>
</DataElem>`;
    }

    const updated =
        text.substring(0, start + openTag.length) +
        cards +
        text.substring(end);

    return Buffer.from(
        updated,
        "utf8"
    );
}


/*
========================================
تعديل عدد جميع الكروت 1 - 150
========================================

مثلاً:

cardsCount = 100

سيصبح:

generatedCount = 100
inStockCount = 100
maxInStockCount = 100

للكروت:

card_01
card_02
...
card_150
========================================
*/

function changeAllCardsCount(
    xml,
    count
) {

    count =
        Number(count);

    if (
        !Number.isInteger(count) ||
        count < 0
    ) {
        throw new Error(
            "عدد الكروت يجب أن يكون رقمًا صحيحًا"
        );
    }

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    let text =
        xml.toString("utf8");

    for (let i = 1; i <= 150; i++) {

        const cardId =
            `card_${String(i).padStart(2, "0")}`;

        const escapedCardId =
            cardId.replace(
                /[.*+?^${}()|[\]\\]/g,
                "\\$&"
            );

        const pattern =
            new RegExp(
                `<DataElem\\b(?=[^>]*\\bname=["']cardId["'])(?=[^>]*\\bvalue=["']${escapedCardId}["'])[^>]*>[\\s\\S]*?<\\/DataElem>`
            );

        const match =
            text.match(pattern);

        if (!match) {
            continue;
        }

        let cardBlock =
            match[0];

        /*
        generatedCount
        */

        cardBlock =
            cardBlock.replace(
                /(<DataElem\b(?=[^>]*\bname=["']generatedCount["'])[^>]*\bvalue=["'])[^"']*(["'])/,
                `$1${count}$2`
            );

        /*
        inStockCount
        */

        cardBlock =
            cardBlock.replace(
                /(<DataElem\b(?=[^>]*\bname=["']inStockCount["'])[^>]*\bvalue=["'])[^"']*(["'])/,
                `$1${count}$2`
            );

        /*
        maxInStockCount
        */

        cardBlock =
            cardBlock.replace(
                /(<DataElem\b(?=[^>]*\bname=["']maxInStockCount["'])[^>]*\bvalue=["'])[^"']*(["'])/,
                `$1${count}$2`
            );

        text =
            text.replace(
                match[0],
                cardBlock
            );
    }

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

    level: function(xml, value) {

        return changeLevel(
            xml,
            value
        );
    },


    townName: function(xml, value) {

        return changeVar(
            xml,
            "townName",
            value
        );
    },


    achievementTeamwork: function(xml, value) {

        return changeVar(
            xml,
            "Achievement_Teamwork",
            value
        );
    },


    firstAttemptM3Levels: function(xml, value) {

        return changeVar(
            xml,
            "FirstAttemptM3Levels",
            value
        );
    },


    fullCardCollections: function(xml, value) {

        return changeVar(
            xml,
            "FullCardCollections",
            value
        );
    },


    livesSent: function(xml, value) {

        return changeVar(
            xml,
            "LivesSent",
            value
        );
    },


    m3CompLvls: function(xml, value) {

        return changeVar(
            xml,
            "m3_comp_lvls",
            value
        );
    },


    regataTasksCompleted: function(xml, value) {

        return changeVar(
            xml,
            "RegataTasksCompleted",
            value
        );
    },


    unlockedFrames: function(xml) {

        return changeDataElem(
            xml,
            "UnlockedFrames",
            UNLOCKED_FRAMES_VALUE
        );
    },


    unlockedStyles: function(xml) {

        return changeDataElem(
            xml,
            "UnlockedStyles",
            UNLOCKED_STYLES_VALUE
        );
    },


    unlockedExpRanks: function(xml) {

        return changeDataElem(
            xml,
            "UnlockedExpRanks",
            UNLOCKED_EXP_RANKS_VALUE
        );
    },


    unlockAllCards: function(xml) {

        return unlockAllCards(
            xml
        );
    },


    cardsCount: function(xml, value) {

        return changeAllCardsCount(
            xml,
            value
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

    unlockAllCards,

    changeAllCardsCount

};
