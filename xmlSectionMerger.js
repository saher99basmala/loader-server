'use strict';

const fs = require('fs');
const path = require('path');

const TARGET_FILE = path.join(__dirname, 'BS32.xml');


// ============================================================
// الأقسام التي يتم استبدالها بالكامل من المصدر
// ============================================================

const SECTION_TAGS = [
    'TownGround',
    'Buildings',
    'UnlockedStyles',
    'UnlockedFrames',
    'UnlockedExpRanks',
    'UnlockedBadges',
    'ZooInfo',
    'Paddocks',
    'ZooQuests',
    'Trains',
    'Skins',
    'AVATAR_IDS',
    'MIGRATE_AVATAR_IDS'
];


// ============================================================
// المتغيرات التي يتم استبدالها بالكامل من المصدر
// ============================================================

const VAR_NAMES = [
    'NewChatEmoji',
    'UnlockedChatEmoji',
    'levelup',
    'townName',
    'unlockAllCards',
    'achievementTeamwork',
    'firstAttemptM3Levels',
    'fullCardCollections',
    'livesSent',
    'm3CompLvls',
    'regataTasksCompleted',
    'unlockAllAvatars'
];


// ============================================================
// جميع متغيرات الأفاتار
// ============================================================

const AVATAR_VAR_RE =
    /^(?:MigrateUnlocked_ava\d+|Unlocked_ava\d+)$/i;


// ============================================================
// Escape RegExp
// ============================================================

function escapeRegExp(value) {
    return String(value).replace(
        /[.*+?^${}()|[\]\\]/g,
        '\\$&'
    );
}


// ============================================================
// البحث عن بداية Tag
// ============================================================

function findTagStart(xml, tag, fromIndex = 0) {

    const re = new RegExp(
        `<${escapeRegExp(tag)}(?:\\s|>|/)`,
        'ig'
    );

    re.lastIndex = fromIndex;

    const match = re.exec(xml);

    return match
        ? match.index
        : -1;
}


// ============================================================
// إيجاد نهاية Tag
// مع دعم علامات الاقتباس
// ============================================================

function findTagEnd(xml, start) {

    let quote = null;

    for (
        let i = start;
        i < xml.length;
        i++
    ) {

        const ch = xml[i];

        if (quote) {

            if (ch === quote) {
                quote = null;
            }

            continue;
        }

        if (
            ch === '"' ||
            ch === "'"
        ) {

            quote = ch;

            continue;
        }

        if (ch === '>') {
            return i;
        }
    }

    return -1;
}


// ============================================================
// استخراج Section كامل
//
// مثال:
//
// <Buildings>
//     ...
// </Buildings>
//
// يتم أخذ الجزء كاملًا كما هو من المصدر.
// ============================================================

function extractTag(
    xml,
    tag,
    fromIndex = 0
) {

    const start =
        findTagStart(
            xml,
            tag,
            fromIndex
        );

    if (start < 0) {
        return null;
    }

    const openEnd =
        findTagEnd(
            xml,
            start
        );

    if (openEnd < 0) {
        return null;
    }

    const opening =
        xml.slice(
            start,
            openEnd + 1
        );


    // --------------------------------------------------------
    // Self Closing
    // --------------------------------------------------------

    if (
        /\/\s*>$/.test(opening)
    ) {

        return {
            tag,
            start,
            end: openEnd + 1,
            text: xml.slice(
                start,
                openEnd + 1
            )
        };
    }


    // --------------------------------------------------------
    // Block
    // --------------------------------------------------------

    const tokenRe =
        new RegExp(
            `<\\/?${escapeRegExp(tag)}(?:\\s|>|/)`,
            'ig'
        );

    tokenRe.lastIndex =
        openEnd + 1;

    let depth = 1;
    let match;

    while (
        (match = tokenRe.exec(xml))
    ) {

        const tokenStart =
            match.index;

        const tokenEnd =
            findTagEnd(
                xml,
                tokenStart
            );

        if (tokenEnd < 0) {
            return null;
        }

        const token =
            xml.slice(
                tokenStart,
                tokenEnd + 1
            );


        // ----------------------------------------------------
        // Closing
        // ----------------------------------------------------

        if (
            /^<\//.test(token)
        ) {

            depth--;

            if (depth === 0) {

                return {
                    tag,
                    start,
                    end: tokenEnd + 1,
                    text: xml.slice(
                        start,
                        tokenEnd + 1
                    )
                };
            }

        }


        // ----------------------------------------------------
        // Opening nested tag
        // ----------------------------------------------------

        else if (
            !/\/\s*>$/.test(token)
        ) {

            depth++;
        }

        tokenRe.lastIndex =
            tokenEnd + 1;
    }

    return null;
}


// ============================================================
// استخراج Var كامل
//
// مهم:
// يتم أخذ الـ Var كاملًا من المصدر.
// لا يتم دمج قيمة v القديمة مع الجديدة.
// ============================================================

function extractVar(
    xml,
    name,
    fromIndex = 0
) {

    const escaped =
        escapeRegExp(name);


    // --------------------------------------------------------
    // Self Closing Var
    //
    // <Var name="..." .../>
    // --------------------------------------------------------

    const selfRe =
        new RegExp(
            `<Var\\b[^>]*\\bname\\s*=\\s*(['"])${escaped}\\1[^>]*\\/\\s*>`,
            'i'
        );

    selfRe.lastIndex =
        fromIndex;

    const selfMatch =
        selfRe.exec(xml);

    if (selfMatch) {

        return {
            start: selfMatch.index,
            end:
                selfMatch.index +
                selfMatch[0].length,
            text: selfMatch[0]
        };
    }


    // --------------------------------------------------------
    // Block Var
    //
    // <Var name="...">
    // ...
    // </Var>
    // --------------------------------------------------------

    const blockRe =
        new RegExp(
            `<Var\\b[^>]*\\bname\\s*=\\s*(['"])${escaped}\\1[^>]*>`,
            'i'
        );

    blockRe.lastIndex =
        fromIndex;

    const blockMatch =
        blockRe.exec(xml);

    if (!blockMatch) {
        return null;
    }

    const openStart =
        blockMatch.index;

    const openEnd =
        findTagEnd(
            xml,
            openStart
        );

    if (openEnd < 0) {
        return null;
    }

    const closeRe =
        /<\/Var\s*>/ig;

    closeRe.lastIndex =
        openEnd + 1;

    const closeMatch =
        closeRe.exec(xml);

    if (!closeMatch) {
        return null;
    }

    return {
        start: openStart,
        end:
            closeMatch.index +
            closeMatch[0].length,
        text:
            xml.slice(
                openStart,
                closeMatch.index +
                closeMatch[0].length
            )
    };
}


// ============================================================
// استخراج جميع Vars المطابقة
// ============================================================

function extractMatchingVars(
    xml,
    regex
) {

    const result = [];

    const varRe =
        /<Var\b[^>]*\bname\s*=\s*(['"])(.*?)\1[^>]*\/\s*>/gi;

    let match;

    while (
        (match = varRe.exec(xml))
    ) {

        const name =
            match[2];

        regex.lastIndex = 0;

        if (
            regex.test(name)
        ) {

            result.push({
                name,
                start: match.index,
                end:
                    match.index +
                    match[0].length,
                text: match[0]
            });
        }
    }

    return result;
}


// ============================================================
// إدخال قبل </root>
// فقط إذا لم يكن القسم موجودًا في السيرفر.
// ============================================================

function insertBeforeRootClose(
    xml,
    block
) {

    const rootClose =
        xml.search(
            /<\/root\s*>/i
        );

    if (rootClose < 0) {

        return (
            xml +
            '\n' +
            block
        );
    }

    return (
        xml.slice(
            0,
            rootClose
        ) +
        '\n' +
        block +
        '\n' +
        xml.slice(rootClose)
    );
}


// ============================================================
// استبدال Section
//
// المصدر موجود:
//     يستبدل القسم الموجود في السيرفر بالكامل.
//
// المصدر غير موجود:
//     لا يفعل أي شيء.
//
// ============================================================

function replaceTag(
    target,
    source,
    tag
) {

    const sourceBlock =
        extractTag(
            source,
            tag
        );

    // --------------------------------------------------------
    // غير موجود في المصدر = تخطي
    // --------------------------------------------------------

    if (!sourceBlock) {

        return {
            xml: target,
            changed: false,
            reason: 'source_not_found'
        };
    }


    // --------------------------------------------------------
    // البحث عن القسم في السيرفر
    // --------------------------------------------------------

    const targetBlock =
        extractTag(
            target,
            tag
        );


    // --------------------------------------------------------
    // موجود في السيرفر
    // استبداله بالكامل
    // --------------------------------------------------------

    if (targetBlock) {

        return {
            xml:
                target.slice(
                    0,
                    targetBlock.start
                ) +

                sourceBlock.text +

                target.slice(
                    targetBlock.end
                ),

            changed: true,
            action: 'replaced'
        };
    }


    // --------------------------------------------------------
    // غير موجود في السيرفر
    // نضع نسخة المصدر كما هي
    // --------------------------------------------------------

    return {
        xml:
            insertBeforeRootClose(
                target,
                sourceBlock.text
            ),

        changed: true,
        action: 'inserted'
    };
}


// ============================================================
// استبدال Var
//
// يأخذ الـ Var من المصدر كاملًا.
//
// مثال:
//
// المصدر:
// <Var name="UnlockedChatEmoji" v=",st43,,st42,"/>
//
// النتيجة:
// <Var name="UnlockedChatEmoji" v=",st43,,st42,"/>
//
// بدون أي قيمة قديمة من BS32.xml
// ============================================================

function replaceVar(
    target,
    source,
    name
) {

    const sourceVar =
        extractVar(
            source,
            name
        );


    // --------------------------------------------------------
    // غير موجود في المصدر = تخطي
    // --------------------------------------------------------

    if (!sourceVar) {

        return {
            xml: target,
            changed: false,
            reason: 'source_not_found'
        };
    }


    // --------------------------------------------------------
    // البحث في السيرفر
    // --------------------------------------------------------

    const targetVar =
        extractVar(
            target,
            name
        );


    // --------------------------------------------------------
    // موجود
    // استبداله بالكامل بنسخة المصدر
    // --------------------------------------------------------

    if (targetVar) {

        return {
            xml:
                target.slice(
                    0,
                    targetVar.start
                ) +

                sourceVar.text +

                target.slice(
                    targetVar.end
                ),

            changed: true,
            action: 'replaced'
        };
    }


    // --------------------------------------------------------
    // غير موجود
    // إدخال نسخة المصدر
    // --------------------------------------------------------

    return {
        xml:
            insertBeforeRootClose(
                target,
                sourceVar.text
            ),

        changed: true,
        action: 'inserted'
    };
}


// ============================================================
// استبدال جميع Vars الخاصة بالأفاتار
//
// Unlocked_ava1
// Unlocked_ava2
// Unlocked_ava3
//
// MigrateUnlocked_ava1
// MigrateUnlocked_ava2
// ...
//
// كل Var يستبدل بالكامل بنسخة المصدر.
// ============================================================

function replaceAllMatchingVars(
    target,
    source,
    regex
) {

    const sourceVars =
        extractMatchingVars(
            source,
            regex
        );

    let result =
        target;

    let count = 0;


    for (
        const sourceVar of sourceVars
    ) {

        const targetVar =
            extractVar(
                result,
                sourceVar.name
            );


        // ----------------------------------------------------
        // موجود في السيرفر
        // ----------------------------------------------------

        if (targetVar) {

            result =
                result.slice(
                    0,
                    targetVar.start
                ) +

                sourceVar.text +

                result.slice(
                    targetVar.end
                );

        }


        // ----------------------------------------------------
        // غير موجود في السيرفر
        // ----------------------------------------------------

        else {

            result =
                insertBeforeRootClose(
                    result,
                    sourceVar.text
                );
        }

        count++;
    }


    return {
        xml: result,
        count
    };
}


// ============================================================
// الدمج
//
// مبدأ هذه الدالة:
//
// BS32.xml = قالب السيرفر.
//
// كل قسم موجود في المصدر:
// يتم أخذ نسخته الكاملة ووضعها مكان نسخة السيرفر.
//
// أي شيء غير موجود في المصدر:
// يبقى كما هو في السيرفر.
//
// لا يتم دمج المحتويات الداخلية.
// ============================================================

function mergeSections(
    sourceXml,
    targetXml
) {

    if (
        typeof sourceXml !== 'string' ||
        !sourceXml.trim()
    ) {

        throw new TypeError(
            'sourceXml is required'
        );
    }

    if (
        typeof targetXml !== 'string' ||
        !targetXml.trim()
    ) {

        throw new TypeError(
            'targetXml is required'
        );
    }


    let result =
        targetXml;

    const logs = [];


    // ========================================================
    // الأقسام
    // ========================================================

    for (
        const tag of SECTION_TAGS
    ) {

        const merged =
            replaceTag(
                result,
                sourceXml,
                tag
            );

        result =
            merged.xml;


        if (
            merged.changed
        ) {

            logs.push({
                type: 'section',
                name: tag,
                action: merged.action
            });
        }
    }


    // ========================================================
    // Object
    //
    // Object تابع لـ Buildings.
    //
    // لذلك لا يتم وضع Object في root.
    // عندما نستبدل Buildings كاملًا،
    // تأتي جميع Objects الموجودة بداخله من المصدر.
    // ========================================================

    const sourceBuildings =
        extractTag(
            sourceXml,
            'Buildings'
        );

    if (sourceBuildings) {

        logs.push({
            type: 'section',
            name: 'Object',
            action: 'included_with_Buildings'
        });
    }


    // ========================================================
    // Vars المحددة
    // ========================================================

    for (
        const name of VAR_NAMES
    ) {

        const merged =
            replaceVar(
                result,
                sourceXml,
                name
            );

        result =
            merged.xml;


        if (
            merged.changed
        ) {

            logs.push({
                type: 'var',
                name,
                action: merged.action
            });
        }
    }


    // ========================================================
    // Avatar Vars
    // ========================================================

    const avatarResult =
        replaceAllMatchingVars(
            result,
            sourceXml,
            AVATAR_VAR_RE
        );

    result =
        avatarResult.xml;


    if (
        avatarResult.count > 0
    ) {

        logs.push({
            type: 'vars',
            name:
                'MigrateUnlocked_ava* / Unlocked_ava*',
            count:
                avatarResult.count
        });
    }


    // ========================================================
    // النتيجة
    // ========================================================

    return {
        xml: result,
        logs
    };
}


// ============================================================
// قراءة BS32.xml من السيرفر
// ============================================================

function readTargetXml() {

    if (
        !fs.existsSync(
            TARGET_FILE
        )
    ) {

        throw new Error(
            `Target XML not found: ${TARGET_FILE}`
        );
    }

    return fs.readFileSync(
        TARGET_FILE,
        'utf8'
    );
}


// ============================================================
// حفظ BS32.xml
// ============================================================
//
// يتم الحفظ بشكل مؤقت ثم الاستبدال.
// ============================================================

function writeTargetXml(xml) {

    const tempFile =
        TARGET_FILE + '.tmp';

    fs.writeFileSync(
        tempFile,
        xml,
        'utf8'
    );

    fs.renameSync(
        tempFile,
        TARGET_FILE
    );
}


// ============================================================
// Merge Into Target
// ============================================================

function mergeIntoTarget(
    sourceXml
) {

    const targetXml =
        readTargetXml();

    const merged =
        mergeSections(
            sourceXml,
            targetXml
        );


    writeTargetXml(
        merged.xml
    );


    return {
        xml: merged.xml,
        logs: merged.logs,
        targetFile: TARGET_FILE
    };
}


// ============================================================
// Exports
// ============================================================

module.exports = {

    TARGET_FILE,

    SECTION_TAGS,

    VAR_NAMES,

    mergeSections,

    mergeIntoTarget,

    readTargetXml,

    writeTargetXml

};
