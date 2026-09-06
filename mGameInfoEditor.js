/*
========================================
mGameInfoEditor.js
========================================
*/

function changeVar(xml, varName, newValue) {
    if (!Buffer.isBuffer(xml)) xml = Buffer.from(xml);
    const text = xml.toString("utf8");

    const escapedName = String(varName).replace(
        /[.*+?^${}()|[\]\\]/g,
        "\\$&"
    );

    const regex = new RegExp(
        '(<Var\\b[^>]*\\bname="' +
        escapedName +
        '"[^>]*\\bv=")[^"]*(")',
        "i"
    );

    return Buffer.from(
        text.replace(regex, "$1" + String(newValue) + "$2"),
        "utf8"
    );
}

function changeDataElem(xml, elemName, newValue) {
    if (!Buffer.isBuffer(xml)) xml = Buffer.from(xml);
    const text = xml.toString("utf8");

    const escapedName = String(elemName).replace(
        /[.*+?^${}()|[\]\\]/g,
        "\\$&"
    );

    const regex = new RegExp(
        '(<DataElem\\b[^>]*\\bname="' +
        escapedName +
        '"[^>]*\\bvalue=")[^"]*(")',
        "i"
    );

    return Buffer.from(
        text.replace(regex, "$1" + String(newValue) + "$2"),
        "utf8"
    );
}

function changeLevel(xml, newLevel) {
    if (!Buffer.isBuffer(xml)) xml = Buffer.from(xml);

    let text = xml.toString("utf8");

    const patterns = [
        /(<Var\b[^>]*\bname="Level"[^>]*\bv=")[^"]*(")/i,
        /(<Var\b[^>]*\bname="level"[^>]*\bv=")[^"]*(")/i,
        /(<DataElem\b[^>]*\bname="Level"[^>]*\bvalue=")[^"]*(")/i,
        /(<DataElem\b[^>]*\bname="level"[^>]*\bvalue=")[^"]*(")/i
    ];

    for (const regex of patterns) {
        if (regex.test(text)) {
            text = text.replace(
                regex,
                "$1" + String(newLevel) + "$2"
            );
            break;
        }
    }

    return Buffer.from(text, "utf8");
}

const UNLOCKED_FRAMES_VALUE =
    "JBsYDjhUWyATVlUjXw==,VEdYLhJsA309Gy0tFgIwCCM=";

const UNLOCKED_STYLES_VALUE =
    "gold,festival,cooking,bsboste,neon,default,animatedUnderwaterViolet,easter";

const UNLOCKED_EXP_RANKS_VALUE =
    "ciIfESAGOAQUVgEpVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0BqCTkMGRU/MSEXEA9UUlE=,ciIfESAGOAQUVgApVw84CH0QVzMnERINWg==,PxceLTU3ASA9A0FqCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVg8pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A05qCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVg4pVw84CH0QVzMnERINWg==,PxceLTU3ASA9A09qCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVgcpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkZqCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVwYpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkdqCTkMGRU/MSEXEA9UlE=,ciIfESAGOAQUVwUpVw84CH0QVzMnERINWg==,ciIfESAGOAQUVwQpVw84CH0QVzMnERINWg==,PxceLTU3ASA9AkRqCTkMGRU/MSEXEA9UlE=,PxceLTU3ASA9AkVqCTkMGRU/MSEXEA9UlE=";

const ALL_CHAT_EMOJI_IDS =
    "sp4,sp5,sp6,sp7,sp8,sp9,sp1," +
    "st1,st2,st3,st4,st5,st6,st7,st8,st9,st10," +
    "st11,st12,st13,st14,st15,st16,st17,st18,st19," +
    "st22,st23,st24,st25,st26,st27,st28,st29,st30," +
    "st31,st32,st34,st35,st36,st37," +
    "st39,st40,st41,st42,st43,st44,st45,st46,st47," +
    "st48,st49,st50,st51,st52,st53,st54,st55,st56," +
    "st57,st58,st59,st60,st61,st62,st63,st64,st65," +
    "st66,st67,st68,st69,st70,st71,st72,st73,st74," +
    "st75,st76,st77,st78,st79,st80," +
    "sp10,sp11,sp12,sp13,sp14,sp15,sp16,sp17,sp18,sp19," +
    "sp20,sp21,sp22,sp23,sp24,sp25,sp26,sp27," +
    "v1,v2,v3";

function unlockAllCards(xml) {
    if (!Buffer.isBuffer(xml)) xml = Buffer.from(xml);

    let text = xml.toString("utf8");

    const regex =
        /(<DataElem\b[^>]*\bname="OwnedCards"[^>]*>)[\s\S]*?(<\/DataElem>)/i;

    if (!regex.test(text)) {
        return Buffer.from(text, "utf8");
    }

    let cards = "";

    for (let i = 1; i <= 150; i++) {
        const id = "card_" + String(i).padStart(2, "0");

        cards +=
            '<DataElem type="dataStore">' +
            '<DataElem name="cardId" type="string" value="' + id + '"/>' +
            '<DataElem name="generatedCount" type="int" value="1000"/>' +
            '<DataElem name="inStockCount" type="int" value="1000"/>' +
            '<DataElem name="isNew" type="bool" value="false"/>' +
            '<DataElem name="maxInStockCount" type="int" value="1000"/>' +
            '</DataElem>';
    }

    text = text.replace(
        regex,
        "$1" + cards + "$2"
    );

    return Buffer.from(text, "utf8");
}

function unlockLandExpansions(xml) {
    if (!Buffer.isBuffer(xml)) xml = Buffer.from(xml);

    let text = xml.toString("utf8");

    text = text.replace(
        /<Object\b[^>]*\bdata=['"][^'"]*storeId['"]\s*:\s*['"]expandBuy['"][^'"]*['"]\s*\/>/gi,
        ""
    );

    return Buffer.from(text, "utf8");
}

const AVATAR_IDS =
    "116-167,168-221,223,225-248,254,256-258,261,263-265,267-300,302-310,312-315,317-336,338-341,346,350,6,95,34,397,50,30,100-104,0,1,10-18,21-24,3,32,35-39,364,370,371,373,377,382-385,387-394,4,43,45-49,5,51-53,55,58-64,66,67,69,7,70,72-74,77-81,8,84,85,9,94,96-98,33,31,27,26,25,29,28,398,19,2,20,264,379,380,44,48,1390,1391";

const MIGRATE_AVATAR_IDS = "25-29";

function parseRanges(value) {
    const result = [];

    if (!value) return result;

    for (const raw of String(value).split(",")) {
        const part = raw.trim();

        if (!part) continue;

        if (part.includes("-")) {
            const range = part.split("-");

            const start = parseInt(range[0], 10);
            const end = parseInt(range[1], 10);

            if (
                Number.isFinite(start) &&
                Number.isFinite(end)
            ) {
                const step = start <= end ? 1 : -1;

                for (
                    let i = start;
                    step > 0 ? i <= end : i >= end;
                    i += step
                ) {
                    result.push(String(i));
                }
            }
        } else {
            result.push(part);
        }
    }

    return result;
}

function escapeXml(value) {
    return String(value)
        .replace(/&/g, "&amp;")
        .replace(/"/g, "&quot;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/'/g, "&apos;");
}

function setAvatarVar(text, name) {
    const escapedName = String(name).replace(
        /[.*+?^${}()|[\]\\]/g,
        "\\$&"
    );

    const regex = new RegExp(
        '(<Var\\b[^>]*\\bname="' +
        escapedName +
        '"[^>]*\\bv=")[^"]*(")',
        "i"
    );

    if (regex.test(text)) {
        return text.replace(
            regex,
            "$11$2"
        );
    }

    const varXml =
        '<Var name="' +
        escapeXml(name) +
        '" v="1"/>';

    const globalEnd =
        text.search(/<\/Global>/i);

    if (globalEnd !== -1) {
        return (
            text.slice(0, globalEnd) +
            varXml +
            text.slice(globalEnd)
        );
    }

    return text;
}

function unlockAllAvatars(xml) {
    if (!Buffer.isBuffer(xml)) xml = Buffer.from(xml);

    let text = xml.toString("utf8");

    for (const id of parseRanges(AVATAR_IDS)) {
        text = setAvatarVar(
            text,
            "Unlocked_ava" + id
        );
    }

    for (const id of parseRanges(MIGRATE_AVATAR_IDS)) {
        text = setAvatarVar(
            text,
            "MigrateUnlocked_ava" + id
        );
    }

    return Buffer.from(text, "utf8");
}

function parseChatEmojiList(value) {
    const result = [];
    const seen = new Set();

    if (
        value === null ||
        value === undefined
    ) {
        return result;
    }

    for (const part of String(value).split(/[,|]/)) {
        const item = part.trim();

        if (!item) continue;

        if (!seen.has(item)) {
            seen.add(item);
            result.push(item);
        }
    }

    return result;
}

function mergeChatEmojiLists(
    oldValue,
    currentValue
) {
    const result = [];
    const seen = new Set();

    for (const item of [
        ...parseChatEmojiList(oldValue),
        ...parseChatEmojiList(currentValue)
    ]) {
        if (!seen.has(item)) {
            seen.add(item);
            result.push(item);
        }
    }

    return result.join(",");
}

function formatChatEmojiValue(value) {
    if (
        value === null ||
        value === undefined
    ) {
        return "";
    }

    return (
        "," +
        String(value).replace(/,/g, ",,") +
        ","
    );
}

function getVarValue(text, varName) {
    const escapedName = String(varName).replace(
        /[.*+?^${}()|[\]\\]/g,
        "\\$&"
    );

    const regex = new RegExp(
        '<Var\\b[^>]*\\bname="' +
        escapedName +
        '"[^>]*\\bv="([^"]*)"',
        "i"
    );

    const match = text.match(regex);

    return match ? match[1] : null;
}

function setChatEmojiVar(
    text,
    name,
    newValue
) {
    const escapedName = String(name).replace(
        /[.*+?^${}()|[\]\\]/g,
        "\\$&"
    );

    const regex = new RegExp(
        '(<Var\\b[^>]*\\bname="' +
        escapedName +
        '"[^>]*\\bv=")[^"]*(")',
        "i"
    );

    if (regex.test(text)) {
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
        text.search(/<\/Global>/i);

    if (globalEnd !== -1) {
        return (
            text.slice(0, globalEnd) +
            varXml +
            text.slice(globalEnd)
        );
    }

    return text;
}

function changeChatEmojiVar(
    xml,
    varName,
    newValue
) {
    if (!Buffer.isBuffer(xml)) xml = Buffer.from(xml);

    let text = xml.toString("utf8");

    const oldValue =
        getVarValue(text, varName);

    const merged =
        mergeChatEmojiLists(
            oldValue,
            newValue
        );

    text =
        setChatEmojiVar(
            text,
            varName,
            formatChatEmojiValue(merged)
        );

    return Buffer.from(text, "utf8");
}

function unlockChatEmojis(
    xml,
    value = ALL_CHAT_EMOJI_IDS
) {
    if (!Buffer.isBuffer(xml)) xml = Buffer.from(xml);

    let text = xml.toString("utf8");

    for (
        const name of [
            "NewChatEmoji",
            "UnlockedChatEmoji"
        ]
    ) {
        const oldValue =
            getVarValue(
                text,
                name
            );

        const merged =
            mergeChatEmojiLists(
                oldValue,
                value
            );

        text =
            setChatEmojiVar(
                text,
                name,
                formatChatEmojiValue(merged)
            );
    }

    return Buffer.from(text, "utf8");
}


/*
========================================
Complete Mission Adventure
========================================
*/

function setAdventureDataElem(
    text,
    elemName,
    newValue
) {
    const escapedName =
        String(elemName).replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const regex =
        new RegExp(
            '(<DataElem\\b[^>]*\\bname="' +
            escapedName +
            '"[^>]*\\bvalue=")[^"]*(")',
            "i"
        );

    if (!regex.test(text)) {
        return text;
    }

    return text.replace(
        regex,
        "$1" +
        escapeXml(newValue) +
        "$2"
    );
}

function getAdventureDataElem(
    text,
    elemName
) {
    const escapedName =
        String(elemName).replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const regex =
        new RegExp(
            '<DataElem\\b[^>]*\\bname="' +
            escapedName +
            '"[^>]*\\bvalue="([^"]*)"',
            "i"
        );

    const match =
        text.match(regex);

    return match
        ? match[1]
        : null;
}

function setAdventureAttribute(
    text,
    elementName,
    attributeName,
    newValue
) {
    const escapedElement =
        String(elementName).replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const escapedAttribute =
        String(attributeName).replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    const regex =
        new RegExp(
            '(<' +
            escapedElement +
            '\\b[^>]*\\b' +
            escapedAttribute +
            '=\\")[^"]*(\\")',
            "i"
        );

    return text.replace(
        regex,
        "$1" +
        escapeXml(newValue) +
        "$2"
    );
}

function completeMissionAdventure(
    xml,
    options = {}
) {
    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    let text =
        xml.toString("utf8");

    const side12of13 =
        options.side12of13 === true;

    if (
        options.sideQuestsCompleted !== undefined
    ) {
        let count =
            Number(
                options.sideQuestsCompleted
            );

        if (Number.isFinite(count)) {

            if (side12of13) {
                count =
                    Math.min(
                        count,
                        12
                    );
            }

            text =
                setAdventureDataElem(
                    text,
                    "side_quests_completed",
                    count
                );
        }
    }

    if (
        options.completePreciousEgg === true
    ) {
        text =
            setAdventureDataElem(
                text,
                "SQ_PreciousEgg",
                9
            );
    }

    if (
        options.mainQuestsFinished === true
    ) {
        text =
            setAdventureDataElem(
                text,
                "isMainQuestsFinished",
                "true"
            );
    }

    if (
        options.sideQuestsFinished === true
    ) {
        text =
            setAdventureDataElem(
                text,
                "isSideQuestsFinished",
                side12of13
                    ? "false"
                    : "true"
            );
    }

    if (
        options.allQuestsFinished === true
    ) {
        text =
            setAdventureDataElem(
                text,
                "isAllQuestsFinished",
                "true"
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

    unlockedFrames: (xml) =>
        changeVar(
            xml,
            "UnlockedFrames",
            UNLOCKED_FRAMES_VALUE
        ),

    unlockedStyles: (xml) =>
        changeVar(
            xml,
            "UnlockedStyles",
            UNLOCKED_STYLES_VALUE
        ),

    unlockedExpRanks: (xml) =>
        changeVar(
            xml,
            "UnlockedExpRanks",
            UNLOCKED_EXP_RANKS_VALUE
        ),

    cards: (xml) =>
        unlockAllCards(xml),

    land: (xml) =>
        unlockLandExpansions(xml),

    avatars: (xml) =>
        unlockAllAvatars(xml),

    chatEmojis: (xml) =>
        unlockChatEmojis(
            xml,
            ALL_CHAT_EMOJI_IDS
        ),

    newChatEmoji: (xml) =>
        changeChatEmojiVar(
            xml,
            "NewChatEmoji",
            ALL_CHAT_EMOJI_IDS
        ),

    unlockedChatEmoji: (xml) =>
        changeChatEmojiVar(
            xml,
            "UnlockedChatEmoji",
            ALL_CHAT_EMOJI_IDS
        ),

    completeMissionAdventure: (xml) =>
        completeMissionAdventure(
            xml,
            {
                side12of13: false,
                sideQuestsCompleted: 12,
                mainQuestsFinished: true,
                sideQuestsFinished: true,
                allQuestsFinished: true,
                completePreciousEgg: true
            }
        )
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

    if (Array.isArray(edits)) {

        for (const key of edits) {

            if (
                typeof EDITORS[key] ===
                "function"
            ) {
                result =
                    EDITORS[key](result);
            }
        }

        return result;
    }

    if (
        typeof edits === "object"
    ) {

        for (
            const [key, enabled]
            of Object.entries(edits)
        ) {

            if (
                enabled &&
                typeof EDITORS[key] ===
                "function"
            ) {
                result =
                    EDITORS[key](result);
            }
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
    completeMissionAdventure,
    setAdventureAttribute,
    setAdventureDataElem,
    getAdventureDataElem,
    applyEdits,
    EDITORS,
    ALL_CHAT_EMOJI_IDS,
    AVATAR_IDS,
    MIGRATE_AVATAR_IDS,
    UNLOCKED_FRAMES_VALUE,
    UNLOCKED_STYLES_VALUE,
    UNLOCKED_EXP_RANKS_VALUE
};
