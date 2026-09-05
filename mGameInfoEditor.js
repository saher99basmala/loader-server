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
    "ciIfESAGOAQUVgEpVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0BqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVgApVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0FqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg8pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A05qCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVg4pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A09qCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVwcpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkZqCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVwYpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkdqCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVwUpVw84CH0QVzMnERINWg==,ciIfESAGOAQUVwQpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkRqCTkMGRU/MSEXEA9UlE=,PxceLTU3ASA9AkVqCTkMGRU/MSEXEA9UlE=";


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

يبحث عن:

<Object ... "storeId":"expandBuy" ... />

ثم يحذف العنصر بالكامل.
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

    let removed =
        0;

    const pattern =
        /<Object\b[^>]*\bdata='[^']*"storeId":"expandBuy"[^']*'\s*\/>/gi;

    text =
        text.replace(
            pattern,
            function() {

                removed++;

                return "";

            }
        );

    const result =
        Buffer.from(
            text,
            "utf8"
        );

    result.removed =
        removed;

    return result;
}


/*
========================================
قائمة Avatars
========================================

نفس قائمة IDs الموجودة في Smali.
========================================
*/

const AVATAR_IDS =
    "116-167,168-221,223,225-248,254,256-258,261,263-265,267-300,302-310,312-315,317-336,338-341,346,350,6,95,34,397,50,30,100-104,0,1,10-18,21-24,3,32,35-39,364,370,371,373,377,382-385,387-394,4,43,45-49,5,51-53,55,58-64,66,67,69,7,70,72-74,77-81,8,84,85,9,94,96-98,33,31,27,26,25,29,28,398,19,2,20,264,379,380,44,48,1390,1391";


/*
========================================
قائمة Migration Avatars
========================================
*/

const MIGRATE_AVATAR_IDS =
    "25-29";


/*
========================================
تحويل النطاقات إلى IDs
========================================

مثال:

116-119,223,225-227

يصبح:

116
117
118
119
223
225
226
227
========================================
*/

function parseRanges(
    value
) {

    const result =
        [];

    const parts =
        String(value)
            .split(",");

    for (
        const part of parts
    ) {

        const item =
            part.trim();

        if (!item) {
            continue;
        }

        if (
            item.includes("-")
        ) {

            const range =
                item.split("-");

            const start =
                Number(range[0]);

            const end =
                Number(range[1]);

            if (
                !Number.isInteger(start) ||
                !Number.isInteger(end)
            ) {

                continue;

            }

            const from =
                Math.min(
                    start,
                    end
                );

            const to =
                Math.max(
                    start,
                    end
                );

            for (
                let i = from;
                i <= to;
                i++
            ) {

                result.push(i);

            }

        } else {

            const number =
                Number(item);

            if (
                Number.isInteger(number)
            ) {

                result.push(number);

            }

        }

    }

    return [
        ...new Set(result)
    ];
}


/*
========================================
تشفير XML للنصوص
========================================
*/

function escapeXml(
    value
) {

    return String(value)
        .replace(
            /&/g,
            "&amp;"
        )
        .replace(
            /"/g,
            "&quot;"
        )
        .replace(
            /</g,
            "&lt;"
        )
        .replace(
            />/g,
            "&gt;"
        );
}


/*
========================================
إضافة / تحديث Avatar Var
========================================

Unlocked:

<Var name="Unlocked_ava116" v="1" t="b"/>

Migration:

<Var name="MigrateUnlocked_ava25" v="1"/>
========================================
*/

function setAvatarVar(
    text,
    name,
    migrate = false
) {

    const escapedName =
        String(name).replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const pattern =
        new RegExp(
            `<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])[^>]*\\/?>`,
            "i"
        );

    const match =
        text.match(
            pattern
        );

    const safeName =
        escapeXml(
            name
        );

    const newElement =
        migrate
            ? `<Var name="${safeName}" v="1"/>`
            : `<Var name="${safeName}" v="1" t="b"/>`;

    /*
    ========================================
    إذا كان موجودًا:
    استبدله
    ========================================
    */

    if (match) {

        return text.replace(
            match[0],
            newElement
        );

    }

    /*
    ========================================
    إذا لم يكن موجودًا:
    أضفه قبل </Global>
    ========================================
    */

    const globalEnd =
        text.search(
            /<\/Global\s*>/i
        );

    if (
        globalEnd !== -1
    ) {

        return (
            text.substring(
                0,
                globalEnd
            ) +
            newElement +
            "\n" +
            text.substring(
                globalEnd
            )
        );

    }

    /*
    ========================================
    إذا لم يوجد Global:
    أضفه قبل نهاية العنصر الجذر
    ========================================
    */

    const rootEnd =
        text.lastIndexOf(
            "</"
        );

    if (
        rootEnd !== -1
    ) {

        return (
            text.substring(
                0,
                rootEnd
            ) +
            newElement +
            "\n" +
            text.substring(
                rootEnd
            )
        );

    }

    /*
    ========================================
    كحل أخير
    ========================================
    */

    return (
        text +
        "\n" +
        newElement
    );
}


/*
========================================
فتح جميع Avatars
========================================
*/

function unlockAllAvatars(
    xml
) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    let text =
        xml.toString("utf8");

    /*
    ========================================
    تحويل قائمة Avatars
    ========================================
    */

    const avatarIds =
        parseRanges(
            AVATAR_IDS
        );

    /*
    ========================================
    تحويل قائمة Migration
    ========================================
    */

    const migrateIds =
        parseRanges(
            MIGRATE_AVATAR_IDS
        );

    /*
    ========================================
    إضافة Unlocked_ava
    ========================================
    */

    for (
        const id of avatarIds
    ) {

        text =
            setAvatarVar(
                text,
                `Unlocked_ava${id}`,
                false
            );

    }

    /*
    ========================================
    إضافة MigrateUnlocked_ava
    ========================================
    */

    for (
        const id of migrateIds
    ) {

        text =
            setAvatarVar(
                text,
                `MigrateUnlocked_ava${id}`,
                true
            );

    }

    const result =
        Buffer.from(
            text,
            "utf8"
        );

    /*
    ========================================
    معلومات إضافية للـ Server
    ========================================
    */

    result.avatarCount =
        avatarIds.length;

    result.migrateAvatarCount =
        migrateIds.length;

    return result;
}


/*
========================================
EDITORS
========================================
*/

const EDITORS = {

    /*
    ========================================
    Level
    ========================================
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
    ========================================
    Town Name
    ========================================
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
    ========================================
    Achievement Teamwork
    ========================================
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
    ========================================
    First Attempt M3 Levels
    ========================================
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
    ========================================
    Full Card Collections
    ========================================
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
    ========================================
    Lives Sent
    ========================================
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
    ========================================
    Match 3 Complete Levels
    ========================================
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
    ========================================
    Regata Tasks Completed
    ========================================
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
    ========================================
    Unlocked Frames
    ========================================
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
    ========================================
    Unlocked Styles
    ========================================
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
    ========================================
    Unlocked Experience Ranks
    ========================================
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
    ========================================
    فتح جميع الكروت
    ========================================
    */

    unlockAllCards: function(
        xml
    ) {

        return unlockAllCards(
            xml
        );

    },


    /*
    ========================================
    فتح جميع توسعات الأراضي
    ========================================
    */

    unlockLandExpansions: function(
        xml
    ) {

        return unlockLandExpansions(
            xml
        );

    },


    /*
    ========================================
    فتح جميع Avatars
    ========================================
    */

    unlockAllAvatars: function(
        xml
    ) {

        return unlockAllAvatars(
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

    if (
        !edits ||
        typeof edits !== "object" ||
        Array.isArray(edits)
    ) {

        throw new Error(
            "صيغة التعديلات غير صحيحة"
        );

    }

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

    unlockLandExpansions,

    unlockAllAvatars

};
