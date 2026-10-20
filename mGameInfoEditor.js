/*
========================================
mGameInfoEditor.js
========================================

- تعديل Vars
- تعديل DataElem
- تعديل Level
- فتح جميع البطاقات
- فتح توسعات الأراضي
- فتح جميع الـ Avatars
- فتح جميع الـ Stickers / Chat Emojis
- تعديل Regata Tasks
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

المستوى الحقيقي في الحفظ:

<Var name="levelup" v="1089" t="i"/>

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

    /*
    البحث عن:

    name="levelup"

    سواء كانت علامات الاقتباس
    " أو '
    */

    const pattern =
        /<Var\b(?=[^>]*\bname=["']levelup["'])[^>]*>/i;

    const match =
        text.match(pattern);

    if (!match) {

        throw new Error(
            'لم يتم العثور على عنصر name="levelup"'
        );

    }

    const oldElement =
        match[0];

    /*
    تغيير قيمة v فقط
    */

    const newElement =
        oldElement.replace(
            /(\bv\s*=\s*)(["'])[^"']*\2/i,
            `$1"${newLevel}"`
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

    /*
    تأكيد أن القيمة تغيرت فعليًا
    */

    const verify =
        updated.match(
            /<Var\b(?=[^>]*\bname=["']levelup["'])[^>]*>/i
        );

    if (!verify) {

        throw new Error(
            'فشل التحقق من تعديل levelup'
        );

    }

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
    "JBsYDjhUWyATVlUjXw==,VEdYLhJsA3Y9Gy0tFgIwCCM=,VEdYLhJsA3c9Gy0tFgIwCCM=,VEdYLhJsA3U9Gy0tFgIwCCM=,VFBKNx5FUig9Gy0tFgIwCCM=,VEdYLhJsA3A9Gy0tFgIwCCM=,VEdYLhJsA3E9Gy0tFgIwCCM=,VEdYLhJsA3I9Gy0tFgIwCCM=,VEdYLhJsA3M9Gy0tFgIwCCM=,fbwcfgtQVl0mEVRb,VEdYLhJsA3w9Gy0tFgIwCCM=,VEdYLhJsA309Gy0tFgIwCCM=,VEdYLhJsAnQ9Gy0tFgIwCCM=,VEdYLhJsAnU9Gy0tFgIwCCM=";


const UNLOCKED_STYLES_VALUE =
    "festival,easter,cooking,Gold,neon,glow,animatedUnderwaterViolet,flame,valentine,christmas,halloween,summer,default,pink,dragon,bubble,bevel,pumpkin,train";


const UNLOCKED_EXP_RANKS_VALUE =
    "ciIfESAGOAQUVgApVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0FqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVgEpVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0BqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg8pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A05qCTkMGRU/MSEXEA9UUlE=,PxceLTU3ASA9A09qCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVg4pVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkZqCTkMGRU/MSEXEA9UUlE=,PxceLTU3ASA9AkdqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwcpVw84CH0QVzMnERINWg==,ciIfESAGOAQUVwYpVw84CH0QVzMnERINWg==,ciIfESAGOAQUVwUpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkRqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwQpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkVqCTkMGRU/MSEXEA9UUlE=,PxceLTU3ASA9AkJqCTkMGRU/MSEXEA9UUlE=,PxceLTU3ASA9AkNqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwMpVw84CH0QVzMnERINWg==,ciIfESAGOAQUVwIpVw84CH0QVzMnERINWg==,ciIfESAGOAQUVwEpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkBqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVwApVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkFqCTkMGRU/MSEXEA9UUlE=";

const UNLOCKED_BADGES_VALUE =
" UVIgUB8QfkM4NA44Bz0XVw0vCBEWXQ==,USVTHSoRQlYJCDkDWRI/DykOExRTNys=,VRsrKRc4Zl4UFAUpVw84CH0QVzMnERINWg==,GC4qFQIJX3o9QURqCTkMGRU/MSEXEA9UUlE=,UVIgUB8QfkA4NA44Bz0XVw0vCBEWXQ==,USVTHSoRQlUJCDkDWRI/DykOExRTNys=,UVIgUB8QfkE4NA44Bz0XVw0vCBEWXQ==,USVTHSoRQlQJCDkDWRI/DykOExRTNys=,UVIgUB8QfkY4NA44Bz0XVw0vCBEWXQ==,USVTHSoRQlMJCDkDWRI/DykOExRTNys=,UVIgUB8Qfkc4NA44Bz0XVw0vCBEWXQ==,USVTHSoRQlIJCDkDWRI/DykOExRTNys=,UVIgUB8QfkQ4NA44Bz0XVw0vCBEWXQ==,USVTHSoRQlEJCDkDWRI/DykOExRTNys=,UVIgUB8QfkU4NA44Bz0XVw0vCBEWXQ==,USVTHSoRQlAJCDkDWRI/DykOExRTNys="; 
/*
========================================
STICKER / CHAT EMOJI IDs
========================================
*/

const ALL_CHAT_EMOJI_IDS =
    "sp4,sp5,sp6,sp7,sp8,sp9,sp1," +
    "st1,st2,st3,st4,st5,st6,st7,st8,st9,st10," +
    "st11,st12,st13,st14,st15,st16,st17,st18,st19," +
    "st22,st23,st24,st25,st26,st27,st28,st29,st30," +
    "st31,st32," +
    "st34,st35,st36,st37," +
    "st39,st40,st41,st42,st43,st44,st45,st46,st47," +
    "st48,st49,st50,st51,st52,st53,st54,st55,st56," +
    "st57,st58,st59,st60,st61,st62,st63,st64,st65," +
    "st66,st67,st68,st69,st70,st71,st72,st73,st74," +
    "st75,st76,st77,st78,st79,st80," +
    "sp10,sp11,sp12,sp13,sp14,sp15,sp16,sp17,sp18,sp19," +
    "sp20,sp21,sp22,sp23,sp24,sp25,sp26,sp27," +
    "v1,v2,v3";


/*
========================================
Cards
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
        /<DataElem\b(?=[^>]*\bname=["']OwnedCards["'])[^>]*>/i;

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
        /<DataElem\b[^>]*>|<\/DataElem\s*>/gi;

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

        cards +=
            `<DataElem type="dataStore">` +
            `<DataElem name="cardId" type="string" value="${cardId}"/>` +
            `<DataElem name="generatedCount" type="int" value="1000"/>` +
            `<DataElem name="inStockCount" type="int" value="1000"/>` +
            `<DataElem name="isNew" type="bool" value="false"/>` +
            `<DataElem name="maxInStockCount" type="int" value="1000"/>` +
            `</DataElem>`;

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
Land Expansions
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

    /*
    الشكل الأساسي
    */

    const patternSingle =
        /<Object\b[^>]*\bdata='[^']*"storeId":"expandBuy"[^']*'\s*\/>/gi;

    text =
        text.replace(
            patternSingle,
            function() {

                removed++;

                return "";

            }
        );

    /*
    دعم الشكل باستخدام "
    */

    const patternDouble =
        /<Object\b[^>]*\bdata="[^"]*"storeId"\s*:\s*"expandBuy"[^"]*"\s*\/>/gi;

    text =
        text.replace(
            patternDouble,
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
Avatar IDs
========================================
*/

const AVATAR_IDS =
    "116-167,168-221,223,225-248,254,256-258,261,263-265,267-300,302-310,312-315,317-336,338-341,346,350,6,95,34,397,50,30,100-104,0,1,10-18,21-24,3,32,35-39,364,370,371,373,377,382-385,387-394,4,43,45-49,5,51-53,55,58-64,66,67,69,7,70,72-74,77-81,8,84,85,9,94,96-98,33,31,27,26,25,29,28,398,19,2,20,264,379,380,44,48,1390,1391";


const MIGRATE_AVATAR_IDS =
    "25-29";


/*
========================================
Parse ranges
========================================
*/

function parseRanges(
    value
) {

    const result = [];

    if (!value) {
        return result;
    }

    const parts =
        String(value).split(",");

    for (const raw of parts) {

        const part =
            raw.trim();

        if (!part) {
            continue;
        }

        if (part.includes("-")) {

            const range =
                part.split("-");

            const start =
                parseInt(range[0], 10);

            const end =
                parseInt(range[1], 10);

            if (
                Number.isFinite(start) &&
                Number.isFinite(end)
            ) {

                const step =
                    start <= end ? 1 : -1;

                for (
                    let i = start;
                    step > 0 ? i <= end : i >= end;
                    i += step
                ) {

                    result.push(
                        String(i)
                    );

                }
            }

        } else {

            result.push(part);

        }
    }

    return result;
}


/*
========================================
XML Escape
========================================
*/

function escapeXml(
    value
) {

    return String(value)
        .replace(/&/g, "&amp;")
        .replace(/"/g, "&quot;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/'/g, "&apos;");
}


/*
========================================
Avatar Var
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

    const regex =
        new RegExp(
            '(<Var\\b[^>]*\\bname="' +
            escapedName +
            '"[^>]*\\bv=")[^"]*(")',
            "i"
        );

    const replacement =
        "$1" +
        "1" +
        "$2";

    if (
        regex.test(text)
    ) {

        return text.replace(
            regex,
            replacement
        );

    }

    const varXml =
        '<Var name="' +
        escapeXml(name) +
        '" v="1"' +
        (
            migrate
                ? ""
                : ' t="b"'
        ) +
        "/>";

    const globalEnd =
        text.search(
            /<\/Global>/i
        );

    if (
        globalEnd !== -1
    ) {

        return (
            text.slice(
                0,
                globalEnd
            ) +
            varXml +
            text.slice(
                globalEnd
            )
        );

    }

    return text;
}


/*
========================================
Unlock All Avatars
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

    const avatarIds =
        parseRanges(
            AVATAR_IDS
        );

    for (const id of avatarIds) {

        text =
            setAvatarVar(
                text,
                "Unlocked_ava" + id,
                false
            );

    }

    const migrateIds =
        parseRanges(
            MIGRATE_AVATAR_IDS
        );

    for (const id of migrateIds) {

        text =
            setAvatarVar(
                text,
                "MigrateUnlocked_ava" + id,
                true
            );

    }

    return Buffer.from(
        text,
        "utf8"
    );
}


/*
========================================
Chat Emoji Parser
========================================
*/

function parseChatEmojiList(
    value
) {

    const result = [];

    const seen =
        new Set();

    if (
        value === null ||
        value === undefined
    ) {

        return result;

    }

    const parts =
        String(value).split(/[,|]/);

    for (const part of parts) {

        const item =
            part.trim();

        if (!item) {
            continue;
        }

        if (!seen.has(item)) {

            seen.add(item);

            result.push(item);

        }
    }

    return result;
}


/*
========================================
Chat Emoji Merge
========================================
*/

function mergeChatEmojiLists(
    oldValue,
    currentValue
) {

    const result = [];

    const seen =
        new Set();

    const oldList =
        parseChatEmojiList(
            oldValue
        );

    const currentList =
        parseChatEmojiList(
            currentValue
        );

    for (const item of oldList) {

        if (!seen.has(item)) {

            seen.add(item);

            result.push(item);

        }
    }

    for (const item of currentList) {

        if (!seen.has(item)) {

            seen.add(item);

            result.push(item);

        }
    }

    return result.join(",");
}


/*
========================================
Chat Emoji Format
========================================
*/

function formatChatEmojiValue(
    value
) {

    if (
        value === null ||
        value === undefined
    ) {

        return "";

    }

    return (
        "," +
        String(value).replace(
            /,/g,
            ",,"
        ) +
        ","
    );
}


/*
========================================
Get Var Value
========================================
*/

function getVarValue(
    text,
    varName
) {

    const escapedName =
        String(varName).replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const regex =
        new RegExp(
            '<Var\\b[^>]*\\bname="' +
            escapedName +
            '"[^>]*\\bv="([^"]*)"',
            "i"
        );

    const match =
        text.match(regex);

    if (!match) {

        return null;

    }

    return match[1];
}


/*
========================================
Set Chat Emoji Var
========================================
*/

function setChatEmojiVar(
    text,
    name,
    newValue
) {

    const escapedName =
        String(name).replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const regex =
        new RegExp(
            '(<Var\\b[^>]*\\bname="' +
            escapedName +
            '"[^>]*\\bv=")[^"]*(")',
            "i"
        );

    if (
        regex.test(text)
    ) {

        return text.replace(
            regex,
            "$1" +
            escapeXml(newValue) +
            "$2"
        );

    }

    const varXml =
        '<Var name="' +
        escapeXml(name) +
        '" v="' +
        escapeXml(newValue) +
        '"/>';

    const globalEnd =
        text.search(
            /<\/Global>/i
        );

    if (
        globalEnd !== -1
    ) {

        return (
            text.slice(
                0,
                globalEnd
            ) +
            varXml +
            text.slice(
                globalEnd
            )
        );

    }

    return text;
}


/*
========================================
Change Chat Emoji Var
========================================
*/

function changeChatEmojiVar(
    xml,
    varName,
    newValue
) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    let text =
        xml.toString("utf8");

    const oldValue =
        getVarValue(
            text,
            varName
        );

    const merged =
        mergeChatEmojiLists(
            oldValue,
            newValue
        );

    const formatted =
        formatChatEmojiValue(
            merged
        );

    text =
        setChatEmojiVar(
            text,
            varName,
            formatted
        );

    return Buffer.from(
        text,
        "utf8"
    );
}


/*
========================================
Unlock All Chat Emojis / Stickers
========================================
*/

function unlockChatEmojis(
    xml,
    value = ALL_CHAT_EMOJI_IDS
) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    let text =
        xml.toString("utf8");

    const oldNew =
        getVarValue(
            text,
            "NewChatEmoji"
        );

    const mergedNew =
        mergeChatEmojiLists(
            oldNew,
            value
        );

    const formattedNew =
        formatChatEmojiValue(
            mergedNew
        );

    text =
        setChatEmojiVar(
            text,
            "NewChatEmoji",
            formattedNew
        );


    const oldUnlocked =
        getVarValue(
            text,
            "UnlockedChatEmoji"
        );

    const mergedUnlocked =
        mergeChatEmojiLists(
            oldUnlocked,
            value
        );

    const formattedUnlocked =
        formatChatEmojiValue(
            mergedUnlocked
        );

    text =
        setChatEmojiVar(
            text,
            "UnlockedChatEmoji",
            formattedUnlocked
        );

    return Buffer.from(
        text,
        "utf8"
    );
}


/*
========================================
REGATA TASKS
========================================
*/

const REGATA_MAX_TASK_COUNT =
    105;

const REGATA_MAX_TASK_POINT =
    135;

const REGATA_START_REAL_END_TIME =
    0x692cb050;

const REGATA_REAL_END_TIME_STEP =
    0x7080;


/*
========================================
Normalize Regata Integer
========================================
*/

function normalizeRegataInteger(
    value,
    defaultValue,
    maxValue
) {

    const parsed =
        parseInt(
            value,
            10
        );

    if (
        !Number.isFinite(parsed)
    ) {

        return defaultValue;

    }

    return Math.max(
        1,
        Math.min(
            maxValue,
            parsed
        )
    );
}


/*
========================================
Change Regata Tasks
========================================
*/

function changeRegataTasks(
    xml,
    taskCount = 105,
    taskPoint = 135
) {

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    let text =
        xml.toString("utf8");

    taskCount =
        normalizeRegataInteger(
            taskCount,
            105,
            REGATA_MAX_TASK_COUNT
        );

    taskPoint =
        normalizeRegataInteger(
            taskPoint,
            135,
            REGATA_MAX_TASK_POINT
        );


    /*
    البحث عن Regata
    */

    const regataRegex =
        /(<Regata\b.*?<\/Regata>)/s;

    const regataMatch =
        text.match(
            regataRegex
        );

    if (!regataMatch) {

        throw new Error(
            "لم يتم العثور على عنصر Regata"
        );

    }

    const originalRegata =
        regataMatch[1];

    let regata =
        originalRegata;


    /*
    حذف MyOldTask القديمة
    */

    regata =
        regata.replace(
            /<MyOldTask\b[^>]*\/>/gi,
            ""
        );


    /*
    استخراج user
    */

    const userMatch =
        regata.match(
            /\buser="([^"]*)"/i
        );

    const user =
        userMatch
            ? userMatch[1]
            : "";


    /*
    البحث عن FreeTask
    */

    const freeTaskRegex =
        /<FreeTask\b[^>]*\bid="([^"]*)"/gi;

    let freeTaskId =
        null;

    let freeTaskMatch;

    while (
        (
            freeTaskMatch =
                freeTaskRegex.exec(regata)
        ) !== null
    ) {

        const id =
            freeTaskMatch[1];

        if (
            String(id).startsWith(
                "match3_"
            )
        ) {

            freeTaskId =
                id;

            break;

        }
    }


    if (!freeTaskId) {

        throw new Error(
            "لم يتم العثور على FreeTask يبدأ بـ match3_"
        );

    }


    /*
    البحث عن Vars
    */

    const varsMatch =
        regata.match(
            /<Vars\b/i
        );

    if (!varsMatch) {

        throw new Error(
            "لم يتم العثور على Vars داخل Regata"
        );

    }

    const varsIndex =
        varsMatch.index;


    /*
    استخراج target
    */

    let target =
        freeTaskId.substring(7);

    const lastUnderscore =
        target.lastIndexOf("_");

    if (
        lastUnderscore > 0
    ) {

        target =
            target.substring(
                0,
                lastUnderscore
            );

    }


    /*
    تجهيز المهام
    */

    let tasks =
        "";

    for (
        let i = 0;
        i < taskCount;
        i++
    ) {

        const realEndTime =
            REGATA_START_REAL_END_TIME +
            (
                i *
                REGATA_REAL_END_TIME_STEP
            );

        tasks +=
            '<MyOldTask' +
            ' id="' +
            escapeXml(freeTaskId) +
            '"' +
            ' type="event_order"' +
            ' eventType="Match3"' +
            ' target="' +
            escapeXml(target) +
            '"' +
            ' user="' +
            escapeXml(user) +
            '"' +
            ' num="' +
            String(i + 6) +
            '"' +
            ' ver="1"' +
            ' takenCounter="' +
            String(i + 2) +
            '"' +
            ' score="' +
            String(taskPoint) +
            '"' +
            ' realEndTime="' +
            String(realEndTime) +
            '"' +
            '/>';

    }


    /*
    إدخال المهام قبل Vars
    */

    regata =
        regata.slice(
            0,
            varsIndex
        ) +
        tasks +
        regata.slice(
            varsIndex
        );


    /*
    استبدال Regata
    */

    text =
        text
            .split(originalRegata)
            .join(regata);


    /*
    تنظيف
    */

    text =
        text.replace(
            /[\n\r\t]/g,
            ""
        );

    text =
        text.replace(
            / {2,}/g,
            " "
        );

    text =
        text.trim();


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


/*
========================================
SMALI ADDITIONS (merged without changing existing editors)
========================================
*/

function changeVarIfPresent(xml, varName, newValue) {
    try {
        return changeVar(xml, varName, newValue);
    } catch (error) {
        return Buffer.isBuffer(xml) ? xml : Buffer.from(xml);
    }
}

function changeManyVars(xml, values) {
    let result = Buffer.isBuffer(xml) ? xml : Buffer.from(xml);
    if (!values || typeof values !== "object" || Array.isArray(values)) {
        throw new Error("صيغة المتغيرات العامة غير صحيحة");
    }
    for (const [name, value] of Object.entries(values)) {
        result = changeVarIfPresent(result, name, value);
    }
    return result;
}

function setExpeditionEnergy(xml, value) {
    const amount = Number(value);
    if (!Number.isInteger(amount) || amount < 0) {
        throw new Error("طاقة Expedition يجب أن تكون رقمًا صحيحًا موجبًا أو صفرًا");
    }
    return changeManyVars(xml, { expeditionEnergy: amount });
}

function setTimedMultipliers(xml, value = 2) {
    const multiplier = Number(value);
    if (!Number.isFinite(multiplier) || multiplier <= 0) {
        throw new Error("قيمة المضاعف يجب أن تكون أكبر من صفر");
    }
    const safe = String(multiplier);
    const block = `<TimedEntityManager configVersion="1">` +
        `\n\t<item entityType="MayorsQuestsMultiplier" multiplier="${safe}"/>` +
        `\n\t<item entityType="Competition1vs1Multiplier" multiplier="${safe}"/>` +
        `\n\t<item entityType="Merge2EnergyMultiplier" multiplier="${safe}"/>` +
        `\n\t<item entityType="ShortContestNote" multiplier="${safe}"/>` +
        `\n\t<item entityType="BigContestCup" multiplier="${safe}"/>` +
        `\n\t<item entityType="ExpeditionEnergyMultiplier" multiplier="${safe}"/>` +
        `\n\t<item entityType="ArcheryMultiplier" multiplier="${safe}"/>` +
        `\n\t<item entityType="EventScoreMultiplier" multiplier="${safe}"/>` +
        `\n\t<item entityType="RoomScoreMultiplier" multiplier="${safe}"/>` +
        `\n\t<item entityType="CascadeMultiplier" multiplier="${safe}"/>` +
        `\n\t<item entityType="SeasonMiniGameProgressMultiplier" multiplier="${safe}"/>` +
        `\n\t<item entityType="RegataMiniGameProgressMultiplier" multiplier="${safe}"/>` +
        `\n</TimedEntityManager>`;
    const text = (Buffer.isBuffer(xml) ? xml : Buffer.from(xml)).toString("utf8");
    const pattern = /<TimedEntityManager\b[^>]*>[\s\S]*?<\/TimedEntityManager>|<TimedEntityManager\b[^>]*\/>/i;
    const updated = pattern.test(text) ? text.replace(pattern, block) : `${text}\n${block}\n`;
    return Buffer.from(updated, "utf8");
}


// وظائف ItemActivity المستخرجة من ItemActivity.smali، مع إبقاء المحررات السابقة كما هي.
function iaVars(xml, values, overwrite = false) {
    let out = Buffer.isBuffer(xml) ? xml : Buffer.from(xml);
    if (!values || typeof values !== "object" || Array.isArray(values)) return out;
    for (const [name, raw] of Object.entries(values)) {
        const n = Number(raw);
        if (!Number.isFinite(n)) continue;
        // changeManyVars يستخدم نفس صيغة Global/Var الحالية ولا ينشئ نسخًا مكررة.
        const current = Number(getVarValue(out.toString("utf8"), name));
        const value = overwrite || !Number.isFinite(current) ? n : current + n;
        out = changeManyVars(out, { [name]: value });
    }
    return out;
}
function iaList(value) {
    return Array.isArray(value) ? [...new Set(value.map(String).map(x => x.trim()).filter(Boolean))] : [];
}
function iaMergeSkins(xml, value) {
    const ids = iaList(value);
    if (!ids.length) return Buffer.isBuffer(xml) ? xml : Buffer.from(xml);
    let s = (Buffer.isBuffer(xml) ? xml : Buffer.from(xml)).toString("utf8");
    s = s.replace(/(<type\b[^>]*\bavailable=["'])([^"']*)(["'][^>]*>)/gi, (m, a, old, z) => `${a}${[...new Set(old.split(/[|,]/).concat(ids).map(x => x.trim()).filter(Boolean))].join("|")}${z}`);
    return Buffer.from(s);
}
function iaApply(xml, o = {}) {
    let out = Buffer.isBuffer(xml) ? xml : Buffer.from(xml);
    const vars = { ...(o.globalVars || {}), ...(o.itemValues || {}), ...(o.barnItems || {}) };
    for (const k of ["money", "moneyCash", "expeditionEnergy", "AirScore"]) if (o[k] !== undefined) vars[k] = o[k];
    out = iaVars(out, vars);
    out = iaVars(out, o.stats);
    if (o.eventToken !== undefined) out = iaVars(out, { "TrainJourney.CurrencyProvider.Amount": o.eventToken, "TrainJourney.CurrencyProvider.TokensEarned": o.eventToken }, true);
    if (o.tradeLogicTokens !== undefined) out = iaVars(out, { additionalTokens: o.tradeLogicTokens }, true);
    if (o.yearAccount !== undefined) out = iaVars(out, { gameStartDate: o.yearAccount }, true);
    if (o.level && typeof o.level === "object") out = iaVars(out, o.level, true);
    const u = o.specialUnlocks || {};
    if (u.badges) out = EDITORS.unlockedBadges(out);
    if (u.expRanks) out = EDITORS.unlockedExpRanks(out);
    if (u.frames) out = EDITORS.unlockedFrames(out);
    if (u.styles) out = EDITORS.unlockedStyles(out);
    if (o.stickers) { out = EDITORS.newChatEmoji(out); out = EDITORS.unlockedChatEmoji(out); }
    if (o.avatarProfile) out = EDITORS.unlockAllAvatars(out);
    if (o.expandLand) out = EDITORS.unlockLandExpansions(out);
    if (o.unlockAchievementProfile) out = iaVars(out, { GivingOffersDeferred: 1 }, true);
    if (o.maxFactoryTrainIsland) out = iaVars(out, { factoryMaxLevel: o.maxFactoryTrainIsland, trainMaxLevel: o.maxFactoryTrainIsland, islandMaxLevel: o.maxFactoryTrainIsland }, true);
    if (o.museumArtifact) out = iaVars(out, { RequestedDiggingMuseumResources: 1, RequestedMuseumResources: 1 }, true);
    const st = o.seasonTicket || {};
    if (st.goldenTicket) out = iaVars(out, { premium: 1, score: 2000 }, true);
    if (st.extraBarn) out = iaVars(out, { freeAmbarInc: 1 }, false);
    if (st.speedUpAir) out = iaVars(out, { SP_BoostSpeedUpAir: 1 }, true);
    if (st.speedUpFarms) out = iaVars(out, { SP_BoostSpeedUpFarms: 1 }, true);
    if (st.speedUpHarvest) out = iaVars(out, { SP_BoostSpeedUpHarvest: 1 }, true);
    if (st.speedUpBuildings) out = iaVars(out, { SP_BoostSpeedUpBuildings: 1 }, true);
    if (o.x2Days) out = setTimedMultipliers(out, Number(o.x2Days) || 2);
    if (o.skins) out = iaMergeSkins(out, o.skins);
    // All Decor في التطبيق يمرر المعرفات المختارة والعدد؛ نخزنها عبر محرر الديكور الموجود إن توفر.
    if (o.decorations && EDITORS.allDecorations) out = EDITORS.allDecorations(out, { ids: iaList(o.decorations), count: Number(o.decorationCount) || 1 });
    if (o.marketSlots) out = iaVars(out, { slotsCount: o.marketSlots }, true);
    if (o.mineDepth) out = iaVars(out, { mineDepth: o.mineDepth }, false);
    return out;
}

const EDITORS = {

    itemActivity: (xml, value) => iaApply(xml, value || {}),


    /*
    Level
    */

    level:
        function(
            xml,
            value
        ) {

            return changeLevel(
                xml,
                value
            );

        },


    /*
    Town Name
    */

    townName:
        function(
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
    Achievement Teamwork
    */

    achievementTeamwork:
        function(
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
    First Attempt M3 Levels
    */

    firstAttemptM3Levels:
        function(
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
    Full Card Collections
    */

    fullCardCollections:
        function(
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
    Lives Sent
    */

    livesSent:
        function(
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
    M3 Completed Levels
    */

    m3CompLvls:
        function(
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
    Regata Tasks Completed
    */

    regataTasksCompleted:
        function(
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
    Frames
    */

    unlockedFrames:
        function(
            xml
        ) {

            return changeDataElem(
                xml,
                "UnlockedFrames",
                UNLOCKED_FRAMES_VALUE
            );

        },


    /*
    Styles
    */

    unlockedStyles:
        function(
            xml
        ) {

            return changeDataElem(
                xml,
                "UnlockedStyles",
                UNLOCKED_STYLES_VALUE
            );

        },


    /*
    Experience Ranks
    */

    unlockedExpRanks:
        function(
            xml
        ) {

            return changeDataElem(
                xml,
                "UnlockedExpRanks",
                UNLOCKED_EXP_RANKS_VALUE
            );

        },
    /*
    Badges
    */

    UnlockedBadges:
        function(
            xml
        ) {

            return changeDataElem(
                xml,
                "UnlockedBadges",
                UNLOCKED_BADGES_VALUE
            );

        },

    /*
    Cards
    */

    unlockAllCards:
        function(
            xml
        ) {

            return unlockAllCards(
                xml
            );

        },


    /*
    Land
    */

    unlockLandExpansions:
        function(
            xml
        ) {

            return unlockLandExpansions(
                xml
            );

        },


    /*
    Avatars
    */

    unlockAllAvatars:
        function(
            xml
        ) {

            return unlockAllAvatars(
                xml
            );

        },


    /*
    Stickers
    */

    chatEmojis:
        function(
            xml
        ) {

            return unlockChatEmojis(
                xml,
                ALL_CHAT_EMOJI_IDS
            );

        },


    /*
    NewChatEmoji
    */

    newChatEmoji:
        function(
            xml
        ) {

            return changeChatEmojiVar(
                xml,
                "NewChatEmoji",
                ALL_CHAT_EMOJI_IDS
            );

        },


    /*
    UnlockedChatEmoji
    */

    unlockedChatEmoji:
        function(
            xml
        ) {

            return changeChatEmojiVar(
                xml,
                "UnlockedChatEmoji",
                ALL_CHAT_EMOJI_IDS
            );

        },


    /*
    Regata Tasks
    */

    regataTasks:
        function(
            xml,
            value
        ) {

            /*
            دعم الشكل الجديد:

            {
                taskCount: 105,
                taskPoint: 135
            }
            */

            if (
                value &&
                typeof value === "object" &&
                !Array.isArray(value)
            ) {

                return changeRegataTasks(
                    xml,
                    value.taskCount,
                    value.taskPoint
                );

            }

            /*
            إذا تم إرسال قيمة واحدة
            */

            return changeRegataTasks(
                xml,
                value,
                135
            );

        },


    /* Smali exposes the lowercase form; retain the old uppercase key too. */
    unlockedBadges:
        function(xml) {
            return changeDataElem(xml, "UnlockedBadges", UNLOCKED_BADGES_VALUE);
        },

    expeditionEnergy:
        function(xml, value) {
            return setExpeditionEnergy(xml, value);
        },

    timedMultipliers:
        function(xml, value) {
            return setTimedMultipliers(xml, value === undefined ? 2 : value);
        },

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

    let result =
        Buffer.isBuffer(xml)
            ? xml
            : Buffer.from(xml);


    if (!edits) {

        return result;

    }


    /*
    ========================================
    Array
    ========================================

    مثال:

    [
        "unlockAllCards",
        "unlockAllAvatars",
        "chatEmojis"
    ]
    */

    if (
        Array.isArray(edits)
    ) {

        for (
            const key of edits
        ) {

            if (
                typeof EDITORS[key] !==
                "function"
            ) {

                throw new Error(
                    `تعديل غير معروف: ${key}`
                );

            }

            result =
                EDITORS[key](
                    result
                );

        }

        return result;
    }


    /*
    ========================================
    Object
    ========================================
    */

    if (
        typeof edits !== "object"
    ) {

        throw new Error(
            "صيغة التعديلات غير صحيحة"
        );

    }


    for (
        const [
            key,
            enabled
        ]
        of Object.entries(edits)
    ) {

        const editor =
            EDITORS[key];

        if (!editor) {

            throw new Error(
                `تعديل غير معروف: ${key}`
            );

        }


        /*
        ====================================
        Regata
        ====================================
        */

        if (
            key === "regataTasks" &&
            enabled &&
            typeof enabled === "object" &&
            !Array.isArray(enabled)
        ) {

            result =
                editor(
                    result,
                    enabled
                );

            continue;

        }


        /*
        ====================================
        Boolean
        ====================================
        */

        if (
            enabled === true
        ) {

            result =
                editor(
                    result
                );

            continue;

        }


        /*
        ====================================
        قيمة عادية
        ====================================
        */

        if (
            enabled !== false &&
            enabled !== null &&
            enabled !== undefined
        ) {

            result =
                editor(
                    result,
                    enabled
                );

        }

    }


    return result;
}


/*
========================================
EXPORTS
========================================
*/

module.exports = {

    applyEdits,

    changeVar,

    changeDataElem,

    changeLevel,

    unlockAllCards,

    unlockLandExpansions,

    unlockAllAvatars,

    parseRanges,

    escapeXml,

    parseChatEmojiList,

    mergeChatEmojiLists,

    formatChatEmojiValue,

    getVarValue,

    setChatEmojiVar,

    changeChatEmojiVar,

    unlockChatEmojis,

    changeRegataTasks,

    normalizeRegataInteger,

    REGATA_MAX_TASK_COUNT,

    REGATA_MAX_TASK_POINT,

    REGATA_START_REAL_END_TIME,

    REGATA_REAL_END_TIME_STEP,

    EDITORS,

    changeManyVars,

    setExpeditionEnergy,

    setTimedMultipliers,

    ALL_CHAT_EMOJI_IDS,

    AVATAR_IDS,

    MIGRATE_AVATAR_IDS,

    UNLOCKED_FRAMES_VALUE,

    UNLOCKED_STYLES_VALUE,

    UNLOCKED_EXP_RANKS_VALUE,
    
    UNLOCKED_BADGES_VALUE

};
