/*
========================================
mGameInfoEditor.js
========================================

- طھط¹ط¯ظٹظ„ Vars
- طھط¹ط¯ظٹظ„ DataElem
- طھط¹ط¯ظٹظ„ Level
- ظپطھط­ ط¬ظ…ظٹط¹ ط§ظ„ط¨ط·ط§ظ‚ط§طھ
- ظپطھط­ طھظˆط³ط¹ط§طھ ط§ظ„ط£ط±ط§ط¶ظٹ
- ظپطھط­ ط¬ظ…ظٹط¹ ط§ظ„ظ€ Avatars
- ظپطھط­ ط¬ظ…ظٹط¹ ط§ظ„ظ€ Stickers / Chat Emojis
- طھط¹ط¯ظٹظ„ Regata Tasks
========================================
*/


/*
========================================
طھط¹ط¯ظٹظ„ Var ط¹ط§ظ…
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
            `ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ Var: ${varName}`
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
طھط¹ط¯ظٹظ„ DataElem ط¹ط§ظ…
========================================
*/

function _nonNegativeInteger(value, label) {
    const text = String(value ?? '').trim();
    if (!/^\d+$/.test(text)) throw new Error(`${label} يجب أن يكون عددًا صحيحًا غير سالب.`);
    const number = Number(text);
    if (!Number.isSafeInteger(number)) throw new Error(`${label} أكبر من الحد المدعوم.`);
    return number;
}

function _positiveInteger(value, label) {
    const number = _nonNegativeInteger(value, label);
    if (number <= 0) throw new Error(`${label} يجب أن يكون أكبر من صفر.`);
    return number;
}

function _changeVerifiedMoney(xml, varName, value, label) {
    const amount = _nonNegativeInteger(value, label);
    const updated = changeVar(xml, varName, String(amount));
    const text = updated.toString('utf8');
    const escapedName = String(varName).replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const verify = text.match(new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])[^>]*\\bv\\s*=\\s*(["'])([^"']*)\\1`, 'i'));
    if (!verify || Number(verify[2]) !== amount) throw new Error(`فشل التحقق من ${label}.`);
    return updated;
}

function _changeVerifiedDataElem(xml, elemName, value, label) {
    const amount = _nonNegativeInteger(value, label);
    const updated = changeDataElem(xml, elemName, String(amount));
    const text = updated.toString('utf8');
    const escapedName = String(elemName).replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const verify = text.match(new RegExp(`<DataElem\\b(?=[^>]*\\bname=["']${escapedName}["'])[^>]*\\bvalue\\s*=\\s*(["'])([^"']*)\\1`, 'i'));
    if (!verify || Number(verify[2]) !== amount) throw new Error(`فشل التحقق من ${label}.`);
    return updated;
}

function _changeCoupon(xml, couponName, value) {
    const amount = _positiveInteger(value, `القسيمة ${couponName}`);
    const source = Buffer.isBuffer(xml) ? xml.toString('utf8') : String(xml);
    const varPattern = /<Var\b(?=[^>]*\bname=["']GivingOffersDeferred["'])[^>]*>/i;
    const match = source.match(varPattern);
    let entries = [];
    if (match) {
        const valueMatch = match[0].match(/\bv\s*=\s*(["'])([^"']*)\1/i);
        if (valueMatch) {
            for (const item of valueMatch[2].split(',')) {
                const pair = item.split(':');
                if (pair.length === 2 && /^[A-Za-z][A-Za-z0-9_]{0,100}$/.test(pair[0].trim()) && /^\d+$/.test(pair[1].trim())) {
                    entries.push([pair[0].trim(), pair[1].trim()]);
                }
            }
        }
    }
    const merged = new Map(entries);
    merged.set(couponName, String(amount));
    const encoded = Array.from(merged, ([name, count]) => `${name}:${count}`).join(',');
    const escaped = encoded.replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    let updated;
    if (match) {
        const element = match[0];
        const valueAttr = /\bv\s*=\s*(["'])[^"']*\1/i;
        const replacement = valueAttr.test(element) ? element.replace(valueAttr, `v="${escaped}"`) : element.replace(/\s*\/?>$/, ` v="${escaped}"$&`);
        updated = source.replace(element, replacement);
    } else {
        const globalEnd = source.search(/<\/Global\s*>/i);
        if (globalEnd < 0) throw new Error('لم يتم العثور على قسم Global لإضافة GivingOffersDeferred.');
        updated = source.slice(0, globalEnd) + `<Var name="GivingOffersDeferred" v="${escaped}"/>` + source.slice(globalEnd);
    }
    const verify = updated.match(varPattern);
    if (!verify || !new RegExp(`(?:^|,)${couponName}:${amount}(?:,|$)`).test((verify[0].match(/\bv\s*=\s*(["'])([^"']*)\1/i) || [])[2] || '')) {
        throw new Error(`فشل التحقق من القسيمة ${couponName}.`);
    }
    return Buffer.from(updated, 'utf8');
}

function _insertVerifiedGlobalVar(xml, name, value, label) {
    const amount = _nonNegativeInteger(value, label);
    const source = Buffer.isBuffer(xml) ? xml.toString('utf8') : String(xml);
    const globalEnd = source.search(/<\/Global\s*>/i);
    if (globalEnd < 0) throw new Error(`لم يتم العثور على قسم Global لإضافة ${name}.`);
    const inserted = source.slice(0, globalEnd) + `<Var name="${name}" v="${amount}" t="i"/>` + source.slice(globalEnd);
    const escapedName = name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const verify = inserted.match(new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])[^>]*\\bv\\s*=\\s*(["'])([^"']*)\\1`, 'i'));
    if (!verify || Number(verify[2]) !== amount) throw new Error(`فشل التحقق من إضافة ${label}.`);
    return Buffer.from(inserted, 'utf8');
}

const APP_RESOURCE_TARGETS = Object.freeze({
    GoldBullion: 'GoldBullionCounter',
    SilverBullion: 'SilverBullionCounter',
    BronzeBullion: 'BronzeBullionCounter',
    PlatinumBullion: 'PlatinumBullionCounter',
    energy_expedition: 'expeditionEnergy',
    star: 'currentTokens'
});

function changeMoney(xml, value) {
    return _changeVerifiedMoney(xml, 'money', value, 'النقود');
}

function changeMoneyCash(xml, value) {
    return _changeVerifiedMoney(xml, 'moneyCash', value, 'T-Cash');
}

function changeGameStartDate(xml, value) {
    const date = String(value ?? '').trim();
    if (!/^(0[1-9]|1[0-2])\/\d{4}$/.test(date)) throw new Error('صيغة التاريخ يجب أن تكون MM/yyyy مثل 09/2026.');
    const [monthText, yearText] = date.split('/');
    const timestamp = Math.floor(Date.UTC(Number(yearText), Number(monthText) - 1, 1) / 1000);
    if (!Number.isSafeInteger(timestamp) || timestamp < 0) throw new Error('التاريخ غير صالح.');
    const updated = _changeVerifiedMoney(xml, 'gameStartDate', timestamp, 'التاريخ');
    const match = updated.toString('utf8').match(new RegExp(`<Var\\b(?=[^>]*\\bname=["']gameStartDate["'])[^>]*\\bv\\s*=\\s*(["'])([^"']*)\\1`, 'i'));
    if (!match) throw new Error('فشل التحقق من التاريخ.');
    const storedDate = new Date(Number(match[2]) * 1000);
    const verified = `${String(storedDate.getUTCMonth() + 1).padStart(2, '0')}/${storedDate.getUTCFullYear()}`;
    if (verified !== date) throw new Error('فشل التحقق من التاريخ.');
    return updated;
}

function changeBarnCapacity(xml, value) {
    const amount = _nonNegativeInteger(value, 'ترقية الحظيرة');
    const duplicate = (514698188 ^ amount) >>> 0;
    const setOrInsert = (input, name, number) => {
        const source = Buffer.isBuffer(input) ? input : Buffer.from(input);
        const text = source.toString('utf8');
        const escapedName = String(name).replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        if (new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])`, 'i').test(text)) {
            return _changeVerifiedMoney(source, name, number, `ترقية الشونة ${name}`);
        }
        const varsEnd = text.search(/<\/Vars\s*>/i);
        if (varsEnd < 0) throw new Error(`لم يتم العثور على قسم Vars لإضافة ${name}.`);
        const inserted = text.slice(0, varsEnd) + `<Var name="${name}" v="${number}" t="i"/>` + text.slice(varsEnd);
        const result = Buffer.from(inserted, 'utf8');
        const verify = result.toString('utf8').match(new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])[^>]*\\bv\\s*=\\s*(["'])([^"']*)\\1`, 'i'));
        if (!verify || Number(verify[2]) !== number) throw new Error(`فشل التحقق من إضافة ${name}.`);
        return result;
    };
    let updated = setOrInsert(xml, 'WareHouseCashUpgrade', amount);
    updated = setOrInsert(updated, 'WHUdup', duplicate);
    updated = setOrInsert(updated, 'gv_barn_upg', amount);
    return updated;
}

function changeFrameCoins(xml, value) {
    const amount = _nonNegativeInteger(value, 'عملات الإطار');
    const source = Buffer.isBuffer(xml) ? xml.toString('utf8') : String(xml);
    const name = 'LR2_Currency';
    const escapedName = name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const existing = new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])`, 'i');
    let updated;
    if (existing.test(source)) {
        updated = _changeVerifiedMoney(source, name, amount, 'عملات الإطار').toString('utf8');
    } else {
        // التطبيق الأصلي يضيف LR2_Currency قبل أول Var في ملف الحفظ.
        const insertion = `<Var name="${name}" v="${amount}" t="i"/>`;
        const result = source.replace(/<Var\s/i, `${insertion}\n<Var `);
        if (result === source) throw new Error('لم يتم العثور على عقدة Var لإضافة LR2_Currency.');
        updated = result;
    }
    const verify = updated.match(new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])[^>]*\\bv\\s*=\\s*(["'])([^"']*)\\1`, 'i'));
    if (!verify || Number(verify[2]) !== amount) throw new Error('فشل التحقق من عملات الإطار بعد التعديل.');
    return Buffer.from(updated, 'utf8');
}

const APP_EVENT_BLOCKS = Object.freeze([
    'DragonNest', 'DragonNestController', 'TrainJourney', 'TrainJourneyController',
    'FlipTheTile', 'FlipTheTileController', 'MayorsBreak', 'MayorsDuties',
    'MedalChallenges', 'MedalChallengesController', 'ZenMatchEvent'
]);

function _findDataElemBlock(text, name, fromIndex) {
    const startRe = new RegExp(`<DataElem\\b(?=[^>]*\\bname=["']${name.replace(/[.*+?^${}()|[\\]\\]/g, '\\$&')}["'])[^>]*>`, 'i');
    const match = startRe.exec(text.slice(fromIndex || 0));
    if (!match) return null;
    const start = (fromIndex || 0) + match.index;
    const opening = match[0];
    if (/\/\s*>$/.test(opening)) return {start, end: start + opening.length};
    let depth = 1;
    const tokenRe = /<DataElem\b[^>]*>|<\/DataElem\s*>/gi;
    tokenRe.lastIndex = start + opening.length;
    let token;
    while ((token = tokenRe.exec(text))) {
        if (/^<\/DataElem/i.test(token[0])) depth--;
        else if (!/\/\s*>$/.test(token[0])) depth++;
        if (depth === 0) return {start, end: tokenRe.lastIndex};
    }
    return null;
}

function showAllEvents(xml) {
    const source = Buffer.isBuffer(xml) ? xml.toString('utf8') : String(xml);
    let updated = source;
    let changed = 0;
    for (const blockName of APP_EVENT_BLOCKS) {
        const block = _findDataElemBlock(updated, blockName, 0);
        if (!block) continue;
        let body = updated.slice(block.start, block.end);
        body = body.replace(/(<DataElem\b(?=[^>]*\bname=["'](?:currentState|state|State)["'])[^>]*\bvalue=["'])([^"']*)(["'])/i,
            (all, prefix, value, suffix) => /^(Disabled|Disable|Inactive|None|idle|Locked|active|enabled)$/i.test(value) ? prefix + 'Active' + suffix : all);
        body = body.replace(/(<DataElem\b(?=[^>]*\bname=["']IsHidden["'])[^>]*\bvalue=["'])[^"']*(["'])/gi, '$1false$2');
        body = body.replace(/(<DataElem\b(?=[^>]*\bname=["']IsEventActive["'])[^>]*\bvalue=["'])[^"']*(["'])/gi, '$1true$2');
        body = body.replace(/(<DataElem\b(?=[^>]*\bname=["'](?:IsTimeOver|isTimeOut)["'])[^>]*\bvalue=["'])[^"']*(["'])/gi, '$1false$2');
        if (body !== updated.slice(block.start, block.end)) {
            updated = updated.slice(0, block.start) + body + updated.slice(block.end);
            changed++;
        }
    }
    if (changed === 0) return Buffer.from(source, 'utf8');
    for (const blockName of APP_EVENT_BLOCKS) {
        const block = _findDataElemBlock(updated, blockName, 0);
        if (!block) continue;
        const body = updated.slice(block.start, block.end);
        if (/name=["']IsHidden["'][^>]*value=["']true["']/i.test(body) ||
            /name=["']IsEventActive["'][^>]*value=["']false["']/i.test(body) ||
            /name=["'](?:IsTimeOver|isTimeOut)["'][^>]*value=["']true["']/i.test(body)) {
            throw new Error(`فشل التحقق من الحدث ${blockName}.`);
        }
    }
    return Buffer.from(updated, 'utf8');
}

function changeResource(xml, value) {
    let options = value;
    if (typeof options === 'string') {
        try { options = JSON.parse(options); } catch (_) { throw new Error('إعداد المورد يجب أن يكون JSON صالحًا.'); }
    }
    if (!options || typeof options !== 'object' || Array.isArray(options)) throw new Error('إعداد المورد غير صحيح.');
    const name = String(options.name ?? options.key ?? '').trim();
    if (!/^[A-Za-z][A-Za-z0-9_]{0,100}$/.test(name)) throw new Error('اسم المورد غير صالح.');
    if (/^Coupon[A-Za-z0-9_]*$/.test(name) || name === 'freeExpansion' || name === 'freeAmbarInc') {
        return _changeCoupon(xml, name, options.value);
    }
    const target = APP_RESOURCE_TARGETS[name] || name;
    if (name === 'star') {
        return _changeVerifiedDataElem(xml, target, options.value, `المورد ${name}`);
    }
    const text = Buffer.isBuffer(xml) ? xml.toString('utf8') : String(xml);
    const escapedName = target.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    if (new RegExp(`<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])`, 'i').test(text)) {
        return _changeVerifiedMoney(xml, target, options.value, `المورد ${name}`);
    }
    if (new RegExp(`<DataElem\\b(?=[^>]*\\bname=["']${escapedName}["'])`, 'i').test(text)) {
        return _changeVerifiedDataElem(xml, target, options.value, `المورد ${name}`);
    }
    return _insertVerifiedGlobalVar(xml, target, options.value, `المورد ${name}`);
}

function changeBarnItem(xml, value) {
    let options = value;
    if (typeof options === 'string') {
        try { options = JSON.parse(options); } catch (_) { throw new Error('إعداد عنصر الشونة غير صالح.'); }
    }
    if (!options || typeof options !== 'object' || Array.isArray(options)) throw new Error('إعداد عنصر الشونة غير صحيح.');
    const name = String(options.name ?? '').trim();
    if (!/^[A-Za-z][A-Za-z0-9_]{0,100}$/.test(name)) throw new Error('اسم عنصر الشونة غير صالح.');
    return _changeVerifiedMoney(xml, `${name}Counter`, options.value, `عنصر الشونة ${name}`);
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
            `ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ DataElem: ${elemName}`
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
            `ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط§ظ„ط®ط§طµظٹط© value ط¯ط§ط®ظ„ ${elemName}`
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
طھط¹ط¯ظٹظ„ ط§ظ„ظ…ط³طھظˆظ‰
========================================

ط§ظ„ظ…ط³طھظˆظ‰ ط§ظ„ط­ظ‚ظٹظ‚ظٹ ظپظٹ ط§ظ„ط­ظپط¸:

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
            "ط§ظ„ظ…ط³طھظˆظ‰ ظٹط¬ط¨ ط£ظ† ظٹظƒظˆظ† ط±ظ‚ظ…ظ‹ط§ طµط­ظٹط­ظ‹ط§"
        );

    }

    if (!Buffer.isBuffer(xml)) {
        xml = Buffer.from(xml);
    }

    const text =
        xml.toString("utf8");

    /*
    ط§ظ„ط¨ط­ط« ط¹ظ†:

    name="levelup"

    ط³ظˆط§ط، ظƒط§ظ†طھ ط¹ظ„ط§ظ…ط§طھ ط§ظ„ط§ظ‚طھط¨ط§ط³
    " ط£ظˆ '
    */

    const pattern =
        /<Var\b(?=[^>]*\bname=["']levelup["'])[^>]*>/i;

    const match =
        text.match(pattern);

    if (!match) {

        throw new Error(
            'ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط¹ظ†طµط± name="levelup"'
        );

    }

    const oldElement =
        match[0];

    /*
    طھط؛ظٹظٹط± ظ‚ظٹظ…ط© v ظپظ‚ط·
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
    طھط£ظƒظٹط¯ ط£ظ† ط§ظ„ظ‚ظٹظ…ط© طھط؛ظٹط±طھ ظپط¹ظ„ظٹظ‹ط§
    */

    const verify =
        updated.match(
            /<Var\b(?=[^>]*\bname=["']levelup["'])[^>]*>/i
        );

    if (!verify) {

        throw new Error(
            'ظپط´ظ„ ط§ظ„طھط­ظ‚ظ‚ ظ…ظ† طھط¹ط¯ظٹظ„ levelup'
        );

    }

    return Buffer.from(
        updated,
        "utf8"
    );
}


/*
========================================
ط§ظ„ظ‚ظٹظ… ط§ظ„ط«ط§ط¨طھط©
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
            "ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ OwnedCards"
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
            "ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ظ†ظ‡ط§ظٹط© OwnedCards"
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
    ط§ظ„ط´ظƒظ„ ط§ظ„ط£ط³ط§ط³ظٹ
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
    ط¯ط¹ظ… ط§ظ„ط´ظƒظ„ ط¨ط§ط³طھط®ط¯ط§ظ… "
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
    ط§ظ„ط¨ط­ط« ط¹ظ† Regata
    */

    const regataRegex =
        /(<Regata\b.*?<\/Regata>)/s;

    const regataMatch =
        text.match(
            regataRegex
        );

    if (!regataMatch) {

        throw new Error(
            "ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ ط¹ظ†طµط± Regata"
        );

    }

    const originalRegata =
        regataMatch[1];

    let regata =
        originalRegata;


    /*
    ط­ط°ظپ MyOldTask ط§ظ„ظ‚ط¯ظٹظ…ط©
    */

    regata =
        regata.replace(
            /<MyOldTask\b[^>]*\/>/gi,
            ""
        );


    /*
    ط§ط³طھط®ط±ط§ط¬ user
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
    ط§ظ„ط¨ط­ط« ط¹ظ† FreeTask
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
            "ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ FreeTask ظٹط¨ط¯ط£ ط¨ظ€ match3_"
        );

    }


    /*
    ط§ظ„ط¨ط­ط« ط¹ظ† Vars
    */

    const varsMatch =
        regata.match(
            /<Vars\b/i
        );

    if (!varsMatch) {

        throw new Error(
            "ظ„ظ… ظٹطھظ… ط§ظ„ط¹ط«ظˆط± ط¹ظ„ظ‰ Vars ط¯ط§ط®ظ„ Regata"
        );

    }

    const varsIndex =
        varsMatch.index;


    /*
    ط§ط³طھط®ط±ط§ط¬ target
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
    طھط¬ظ‡ظٹط² ط§ظ„ظ…ظ‡ط§ظ…
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
    ط¥ط¯ط®ط§ظ„ ط§ظ„ظ…ظ‡ط§ظ… ظ‚ط¨ظ„ Vars
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
    ط§ط³طھط¨ط¯ط§ظ„ Regata
    */

    text =
        text
            .split(originalRegata)
            .join(regata);


    /*
    طھظ†ط¸ظٹظپ
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
Golden Tickets
========================================

These editors operate on the decoded mGameInfo XML.  The application stores
the current season as a real <SeasonTicket> or <SeasonPass> element (not only
as a DataElem named SeasonTicket).  Keep the DataElem fallback for older saves.
*/
function _xmlAttr(tag, name) {
    const re = new RegExp("\\b" + name + "\\s*=\\s*([\\\"'])(.*?)\\1", "i");
    const m = tag.match(re);
    return m ? m[2] : null;
}
function _setXmlAttr(tag, name, value) {
    const re = new RegExp("(\\b" + name + "\\s*=\\s*)([\\\"'])[^\\\"']*\\2", "i");
    if (re.test(tag)) return tag.replace(re, '$1"' + String(value) + '"');
    return tag.replace(/\s*\/?>$/, ' ' + name + '="' + String(value) + '"$&');
}
function _findNamedDataElem(text, names, from = 0) {
    const wanted = new Set(names.map(String));
    const openRe = /<DataElem\b[^>]*>/gi;
    openRe.lastIndex = from;
    let m;
    while ((m = openRe.exec(text))) {
        const tag = m[0];
        if (/\/\s*>$/.test(tag)) continue;
        const name = _xmlAttr(tag, 'name');
        if (!wanted.has(name)) continue;
        let depth = 1;
        const tokenRe = /<DataElem\b[^>]*>|<\/DataElem\s*>/gi;
        tokenRe.lastIndex = openRe.lastIndex;
        let t;
        while ((t = tokenRe.exec(text))) {
            if (/^<DataElem\b/i.test(t[0]) && !/\/\s*>$/.test(t[0])) depth++;
            else if (/^<\/DataElem/i.test(t[0])) {
                depth--;
                if (depth === 0) return {start:m.index, end:t.index+t[0].length, open:tag};
            }
        }
        throw new Error('بنية DataElem غير مكتملة: ' + name);
    }
    return null;
}
function _findXmlElement(text, names, from = 0) {
    const wanted = new Set(names.map(String));
    const openRe = /<([A-Za-z_][\w:.-]*)\b[^>]*>/g;
    openRe.lastIndex = from;
    let m;
    while ((m = openRe.exec(text))) {
        const tagName = m[1];
        if (!wanted.has(tagName) || /\/\s*>$/.test(m[0])) continue;
        const closeRe = new RegExp(`<\\/${tagName.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\s*>`, 'gi');
        closeRe.lastIndex = openRe.lastIndex;
        const close = closeRe.exec(text);
        if (!close) throw new Error('بنية XML غير مكتملة: ' + tagName);
        return {start: m.index, end: close.index + close[0].length, open: m[0], name: tagName};
    }
    return null;
}
function _findSeasonElement(text) {
    return _findXmlElement(text, ['SeasonTicket', 'SeasonPass']) ||
        _findNamedDataElem(text, ['SeasonTicket', 'SeasonPass']);
}
function _findNamedContainer(text, name) {
    const hit = _findXmlElement(text, [name]);
    if (hit) return hit;
    return _findNamedDataElem(text, [name]);
}
function _maxStageScore(road) {
    const scores = [];
    for (const match of road.matchAll(/<(?:Stage\b[^>]*|DataElem\b[^>]*\bname\s*=\s*["']Stage["'][^>]*)>/gi)) {
        const score = _xmlAttr(match[0], 'score');
        if (score !== null && /^-?\d+$/.test(score.trim())) scores.push(Number(score));
    }
    return scores.length ? Math.max(...scores) : -1;
}
function unlockGoldenTicket(xml) {
    const text = Buffer.isBuffer(xml) ? xml.toString('utf8') : String(xml);
    if (!text.trim()) throw new Error('XML فارغ.');
    const hit = _findSeasonElement(text);
    if (!hit) throw new Error('لم يتم العثور على SeasonTicket أو SeasonPass');
    let block = text.slice(hit.start, hit.end);
    const originalId = _xmlAttr(hit.open, 'id');
    const roads = ['FreeRoad', 'PremiumRoad'].map(name => _findNamedContainer(block, name));
    if (roads.some(road => !road)) throw new Error('لم يتم العثور على مراحل FreeRoad / PremiumRoad داخل التذكرة الحالية');
    const maxScore = Math.max(...roads.map(road => _maxStageScore(block.slice(road.start, road.end))));
    if (!Number.isFinite(maxScore) || maxScore < 0) throw new Error('لم يتم العثور على score صالح داخل مراحل التذكرة');
    let updatedBlock = block;
    const seasonOpen = hit.open;
    let updatedOpen = _setXmlAttr(seasonOpen, 'premium', '1');
    updatedOpen = _setXmlAttr(updatedOpen, 'score', String(maxScore));
    updatedBlock = updatedOpen + block.slice(seasonOpen.length);
    for (const name of ['FreeRoad', 'PremiumRoad']) {
        const road = _findNamedContainer(updatedBlock, name);
        const roadText = updatedBlock.slice(road.start, road.end);
        const cleaned = roadText.replace(/\s+rewardGiven\s*=\s*(["'])[^"']*\1/gi, '');
        updatedBlock = updatedBlock.slice(0, road.start) + cleaned + updatedBlock.slice(road.end);
    }
    let resultText = text.slice(0, hit.start) + updatedBlock + text.slice(hit.end);
    resultText = resultText.replace(/(\blastSeenScoreInHUD\s*=\s*["'])[^"']*(["'])/gi, `$1${maxScore}$2`);
    resultText = resultText.replace(/(\bnewStageAvailableInHUD\s*=\s*["'])[^"']*(["'])/gi, (m, prefix, suffix) => prefix + '0' + suffix);
    const verify = _findSeasonElement(resultText);
    if (!verify || !_xmlAttr(verify.open, 'premium') || _xmlAttr(verify.open, 'premium') !== '1' ||
        Number(_xmlAttr(verify.open, 'score')) < maxScore ||
        !verify || /\brewardGiven\s*=/i.test(resultText.slice(verify.start, verify.end)) ||
        (originalId !== null && _xmlAttr(verify.open, 'id') !== originalId)) {
        throw new Error('فشل التحقق من فتح التذكرة الذهبية');
    }
    return Buffer.from(resultText, 'utf8');
}
function unlockGoldenTicket2(xml) {
    const text = Buffer.isBuffer(xml) ? xml.toString('utf8') : String(xml);
    const city = _findNamedDataElem(text, ['CityTicket']);
    if (!city) throw new Error('لم يتم العثور على CityTicket');
    const cityText = text.slice(city.start, city.end);
    const level = _findNamedDataElem(cityText, ['CityTicketLevel']);
    if (!level) throw new Error('لم يتم العثور على CityTicketLevel داخل CityTicket');
    const desired = '<DataElem name="CityTicketLevel" type="dataStore"><DataElem name="cm" type="double" value="1.0000000000000000"/><DataElem name="level" type="string" value="Vip"/><DataElem name="rewards" type="dataStore"><DataElem name="g" type="dataStore"><DataElem name="c" type="int" value="0"/><DataElem name="collected" type="bool" value="true"/><DataElem name="points" type="int" value="0"/><DataElem name="selected" type="bool" value="true"/><DataElem name="t" type="string" value=""/></DataElem><DataElem name="v" type="dataStore"><DataElem name="c" type="int" value="0"/><DataElem name="collected" type="bool" value="true"/><DataElem name="points" type="int" value="0"/><DataElem name="selected" type="bool" value="true"/><DataElem name="t" type="string" value=""/></DataElem></DataElem></DataElem>';
    const newCity = cityText.slice(0, level.start) + desired + cityText.slice(level.end);
    const out = text.slice(0, city.start) + newCity + text.slice(city.end);
    if (!/name="CityTicketLevel"/.test(newCity) || !/value="Vip"/.test(newCity)) throw new Error('فشل التحقق من التذكرة الذهبية 2');
    return Buffer.from(out, 'utf8');
}
/*
========================================
Train editor
========================================
The game stores each train as an XML <train> tag whose v attribute contains
an XML-escaped JSON object.  This mirrors G2.b/G2.c from the application:
product slots are numbered 1..5, orderBlue is represented by 1, and the
optional clearBox operation removes the old order/helper fields.
*/
function _decodeXmlEntities(value) {
    return String(value)
        .replace(/&apos;/g, "'")
        .replace(/&quot;/g, '"')
        .replace(/&lt;/g, '<')
        .replace(/&gt;/g, '>')
        .replace(/&amp;/g, '&');
}
function _encodeXmlEntities(value) {
    return String(value)
        .replace(/&/g, '&amp;')
        .replace(/'/g, '&apos;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
}
function _trainSection(text) {
    const limit = text.search(/<Ernie\b/i);
    const endLimit = limit < 0 ? text.length : limit;
    const open = /<Trains\b[^>]*>/i.exec(text.slice(0, endLimit));
    if (!open) throw new Error('لم أجد قسم <Trains> الرئيسي.');
    const start = open.index + open[0].length;
    const closeRel = text.slice(start, endLimit).search(/<\/Trains\s*>/i);
    if (closeRel < 0) throw new Error('قسم <Trains> غير مكتمل.');
    return {start, end: start + closeRel, closeEnd: start + closeRel + text.slice(start + closeRel).match(/^<\/Trains\s*>/i)[0].length};
}
function _trainRecords(text) {
    const section = _trainSection(text);
    const body = text.slice(section.start, section.end);
    const records = [];
    const re = /<train\s+v\s*=\s*(["'])(.*?)\1\s*\/\s*>/gis;
    let match;
    while ((match = re.exec(body))) {
        let data;
        try {
            data = JSON.parse(_decodeXmlEntities(match[2]));
        } catch (error) {
            throw new Error('بيانات قطار غير صالحة بصيغة JSON.');
        }
        if (!data || typeof data !== 'object' || Array.isArray(data)) throw new Error('بنية بيانات القطار غير متوقعة.');
        records.push({match, data, start: match.index, end: match.index + match[0].length});
    }
    if (!records.length) throw new Error('لم أجد قطارات قابلة للقراءة داخل قسم Trains الرئيسي.');
    return {section, body, records};
}
function _trainOptions(value, requireIndex) {
    let options = value;
    if (typeof options === 'string') {
        try { options = JSON.parse(options); } catch (_) { throw new Error('إعدادات القطار يجب أن تكون JSON صالحًا.'); }
    }
    if (!options || typeof options !== 'object' || Array.isArray(options)) throw new Error('إعدادات القطار غير صحيحة.');
    const trainIndex = Number(options.trainIndex);
    const boxIndex = Number(options.boxIndex);
    if (requireIndex && (!Number.isInteger(trainIndex) || trainIndex < 1)) throw new Error('رقم القطار غير صحيح.');
    if (requireIndex && (!Number.isInteger(boxIndex) || boxIndex < 1 || boxIndex > 5)) throw new Error('رقم الصندوق يجب أن يكون بين 1 و5.');
    const productId = String(options.productId ?? '').trim();
    if (!productId) throw new Error('كود المنتج فارغ.');
    const productCount = Number(options.productCount);
    if (!Number.isInteger(productCount) || productCount < 0) throw new Error('كمية المنتج يجب أن تكون عددًا صحيحًا غير سالب.');
    const orderBlue = options.orderBlue === true || options.orderBlue === 1 || options.orderBlue === '1' || options.orderBlue === 'true';
    const clearBox = options.clearBox === true || options.clearBox === 1 || options.clearBox === '1' || options.clearBox === 'true';
    return {trainIndex, boxIndex, productId, productCount, orderBlue, clearBox, orderBlueTime: options.orderBlueTime};
}
function _applyTrainSlot(data, boxIndex, options) {
    const suffix = String(boxIndex);
    data['productId_' + suffix] = options.productId;
    data['productCount_' + suffix] = options.productCount;
    if (options.orderBlue) {
        data['orderBlue_' + suffix] = 1;
        if (!Object.prototype.hasOwnProperty.call(data, 'orderBlueTime_' + suffix)) {
            const supplied = Number(options.orderBlueTime);
            data['orderBlueTime_' + suffix] = Number.isFinite(supplied) && supplied > 0 ? Math.floor(supplied) : Math.floor(Date.now() / 1000);
        }
    } else {
        delete data['orderBlue_' + suffix];
        delete data['orderBlueTime_' + suffix];
    }
    if (options.clearBox) {
        for (const key of [
            'orderId_' + suffix, 'productDone_' + suffix, 'checked_' + suffix,
            'productSpent' + suffix, 'cashSpent' + suffix, 'expEarned' + suffix,
            'couponsSpent' + suffix, 'cardPack' + suffix,
            'orderFriend_' + suffix + '_city_id', 'orderFriend_' + suffix + '_friend_city_name',
            'orderFriend_' + suffix + '_pic', 'orderFriend_' + suffix + '_friend_type'
        ]) delete data[key];
    }
}
function _editTrains(xml, value, allTrains) {
    const text = Buffer.isBuffer(xml) ? xml.toString('utf8') : String(xml);
    const options = _trainOptions(value, !allTrains);
    const parsed = _trainRecords(text);
    if (!allTrains && options.trainIndex > parsed.records.length) throw new Error(`القطار ${options.trainIndex} غير موجود. الموجود ${parsed.records.length}.`);
    const targets = allTrains ? parsed.records.map((_, index) => index + 1) : [options.trainIndex];
    const replacements = new Map();
    for (const trainIndex of targets) {
        const record = parsed.records[trainIndex - 1];
        const next = {...record.data};
        const boxes = allTrains ? [1, 2, 3, 4, 5] : [options.boxIndex];
        for (const boxIndex of boxes) _applyTrainSlot(next, boxIndex, options);
        replacements.set(record.start, `<train v='${_encodeXmlEntities(JSON.stringify(next))}'/>`);
    }
    let updatedBody = parsed.body;
    for (const record of [...parsed.records].reverse()) {
        const replacement = replacements.get(record.start);
        if (replacement) updatedBody = updatedBody.slice(0, record.start) + replacement + updatedBody.slice(record.end);
    }
    const resultText = text.slice(0, parsed.section.start) + updatedBody + text.slice(parsed.section.end);
    const verified = _trainRecords(resultText).records;
    for (const trainIndex of targets) {
        const data = verified[trainIndex - 1].data;
        const boxes = allTrains ? [1, 2, 3, 4, 5] : [options.boxIndex];
        for (const boxIndex of boxes) {
            const suffix = String(boxIndex);
            if (data['productId_' + suffix] !== options.productId || Number(data['productCount_' + suffix]) !== options.productCount ||
                (Number(data['orderBlue_' + suffix] || 0) === 1) !== options.orderBlue) throw new Error('فشل التحقق من صندوق القطار بعد التعديل.');
            if (options.clearBox) {
                const forbidden = [
                    'orderId_' + suffix, 'productDone_' + suffix, 'checked_' + suffix,
                    'productSpent' + suffix, 'cashSpent' + suffix, 'expEarned' + suffix,
                    'couponsSpent' + suffix, 'cardPack' + suffix,
                    'orderFriend_' + suffix + '_city_id', 'orderFriend_' + suffix + '_friend_city_name',
                    'orderFriend_' + suffix + '_pic', 'orderFriend_' + suffix + '_friend_type'
                ];
                if (forbidden.some(key => Object.prototype.hasOwnProperty.call(data, key))) throw new Error('فشل تنظيف بيانات صندوق القطار.');
            }
        }
    }
    return Buffer.from(resultText, 'utf8');
}
/*
========================================
المظاهر والديكورات — منطق التطبيق
========================================
*/
const APP_SKINS_XML = "<Skins>\n\t\t<type id=\"Sheep\" available=\"Skin_Sheep_butterfly_71|Skin_Sheep_halloween2022|Skin_Sheep_lunarNY2022|Skin_Sheep_easter2023|Skin_Sheep_nordicGod|Skin_Sheep_detective|Skin_Sheep_sweet|Skin_Sheep_robinHood|Skin_Sheep_brazil|Skin_Sheep_rocknroll|Skin_Sheep_knight|Skin_Sheep_wildwest2024|Skin_Sheep_birthday2024|Skin_Sheep_birthday2024s|Skin_Sheep_egypt|Skin_Sheep_christmas2024|Skin_Sheep_allinclusive2025|Skin_Sheep_hellas2025|Skin_Sheep_masquerade|Skin_Sheep_Default|Skin_Sheep_Birthday_2025|Skin_Sheep_Halloween2025|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"Helicopter\" available=\"Skin_Helicopter_butterfly_71|Skin_Helicopter_Resort|Skin_Helicopter_Travel|Skin_Helicopter_Sport|Skin_Helicopter_cinderella|Skin_Helicopter_detective|Skin_Helicopter_halloween2023|Skin_Helicopter_brazil|Skin_Helicopter_easter2024|Skin_Helicopter_atlantis|Skin_Helicopter_pirate2024|Skin_Helicopter_disco|Skin_Helicopter_mars2025|Skin_Helicopter_Ufo|Skin_Helicopter_Robot|Skin_Helicopter_sport|Skin_Helicopter_Arabic|Skin_Helicopter_travel|Skin_Helicopter_Sleigh|Skin_Helicopter_Gatsby|Skin_Helicopter_masquerade|Skin_Helicopter_cny2025|Skin_Helicopter_Ufo:2|Skin_Helicopter_Sleigh:2|Skin_Helicopter_Harvest|Skin_Helicopter_Robot:2|Skin_Helicopter_Default|Skin_Helicopter_Birthday_2025|Skin_Helicopter_christmas_67|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"Airplane\" available=\"Skin_Airplane_carnival_70|Skin_Airplane_movie|Skin_Airplane_christmas2022|Skin_Airplane_easter2023|Skin_Airplane_sweet|Skin_Airplane_winterSport|Skin_Airplane_ireland|Skin_Airplane_spy|Skin_Airplane_allinclusive|Skin_Airplane_fashion|Skin_Airplane_arab|Skin_Airplane_SP3:2|Skin_Airplane_halloween2021:2|Skin_Airplane_space|Skin_Airplane_rock|Skin_Airplane_classicmusic|Skin_Airplane_Default|Skin_Airplane_Halloween2025|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"Chicken\" available=\"Skin_Chicken_easter_72|Skin_Chicken_travel|Skin_Chicken_theatrical|Skin_Chicken_sport|Skin_Chicken_cinderella|Skin_Chicken_jungle|Skin_Chicken_sweet|Skin_Chicken_christmas2023|Skin_Chicken_ireland|Skin_Chicken_hellas|Skin_Chicken_allinclusive|Skin_Chicken_birthday2024|Skin_Chicken_halloween2024|Skin_Chicken_fashion|Skin_Chicken_disco|Skin_Chicken_mars2025|Skin_Chicken_cny2025|Skin_Chicken_Default|Skin_Chicken_Birthday_2025|Skin_Chicken_Birthday_2025s|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"TrainStation\" available=\"Skin_TrainStation_prehistoric|Skin_TrainStation_theatrical|Skin_TrainStation_lunarNY2022|Skin_TrainStation_mars|Skin_TrainStation_robinHood|Skin_TrainStation_rocknroll|Skin_TrainStation_knight|Skin_TrainStation_italy2024|Skin_TrainStation_halloween2024|Skin_TrainStation_christmas2024|Skin_TrainStation_festival|Skin_TrainStation_hellas2025|Skin_TrainStation_Default|Skin_TrainStation_western|Skin_TrainStation_easter|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"HelicopterPlace\" available=\"Skin_HelicopterPlace_butterfly_71|Skin_HelicopterPlace_Travel|Skin_HelicopterPlace_Sport|Skin_HelicopterPlace_cinderella|Skin_HelicopterPlace_detective|Skin_HelicopterPlace_halloween2023|Skin_HelicopterPlace_brazil|Skin_HelicopterPlace_easter2024|Skin_HelicopterPlace_atlantis|Skin_HelicopterPlace_pirate2024|Skin_HelicopterPlace_disco|Skin_HelicopterPlace_mars2025|Skin_HelicopterPlace_masquerade|Skin_HelicopterPlace_cny2025|Skin_HelicopterPlace_Sleigh|Skin_HelicopterPlace_Harvest|Skin_HelicopterPlace_Arabic|Skin_HelicopterPlace_Resort|Skin_HelicopterPlace_Default|Skin_HelicopterPlace_Birthday_2025|Skin_HelicopterPlace_christmas_67|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"Harbor\" available=\"Skin_Harbor_easter_72|Skin_Harbor_halloween2022|Skin_Harbor_valentinesDay|Skin_Harbor_nordicGod|Skin_Harbor_jungle|Skin_Harbor_christmas2023|Skin_Harbor_CNY|Skin_Harbor_hellas|Skin_Harbor_wildwest2024|Skin_Harbor_birthday2024|Skin_Harbor_egypt|Skin_Harbor_allinclusive2025|Skin_Harbor_arctic|Skin_Harbor_japan|Skin_Harbor_SP9|Skin_Harbor_venice|Skin_Harbor_Default|Skin_Harbor_ST1|Skin_Harbor_paris|Skin_Harbor_ST8|Skin_Harbor_ST35|Skin_Harbor_ST43|Skin_Harbor_ST51|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"Airport\" available=\"Skin_Airport_carnival_70|Skin_Airport_christmas2022|Skin_Airport_sweet|Skin_Airport_winterSport|Skin_Airport_ireland|Skin_Airport_spy|Skin_Airport_allinclusive|Skin_Airport_arab|Skin_Airport_SP3|Skin_Airport_rock|Skin_Airport_halloween2021|Skin_Airport_easter2023|Skin_Airport_classicmusic|Skin_Airport_fashion|Skin_Airport_Default|Skin_Airport_movie|Skin_Airport_Halloween2025|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"Ship\" available=\"Skin_Ship_easter_72|Skin_Ship_halloween2022|Skin_Ship_valentinesDay|Skin_Ship_nordicGod|Skin_Ship_jungle|Skin_Ship_christmas2023|Skin_Ship_CNY|Skin_Ship_hellas|Skin_Ship_wildwest2024|Skin_Ship_birthday2024|Skin_Ship_egypt|Skin_Ship_allinclusive2025|Skin_Ship_Default|Skin_Ship_ST1|Skin_Ship_paris|Skin_Ship_venice|Skin_Ship_arctic|Skin_Ship_japan|Skin_Ship_SP9|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"Train\" available=\"Skin_Train_prehistoric|Skin_Train_theatrical|Skin_Train_lunarNY2022|Skin_Train_mars|Skin_Train_robinHood|Skin_Train_rocknroll|Skin_Train_knight|Skin_Train_italy2024|Skin_Train_halloween2024|Skin_Train_christmas2024|Skin_Train_festival|Skin_Train_hellas2025|Skin_Train_easter|Skin_Train_christmas|Skin_Train_SP5|Skin_Train_SP8|Skin_Train_western|Skin_Train_Default1|Skin_Train_SP2:2|Skin_Train_ST45|Skin_Train_ST50|Skin_Train_ST47|Skin_Train_ST24,Skin_Train_mars|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"Cow\" available=\"Skin_Cow_carnival_70|Skin_Cow_movie|Skin_Cow_christmas2022|Skin_Cow_valentine|Skin_Cow_mars|Skin_Cow_sweet2|Skin_Cow_sweet|Skin_Cow_halloween2023|Skin_Cow_winterSport|Skin_Cow_CNY|Skin_Cow_easter2024|Skin_Cow_spy|Skin_Cow_atlantis|Skin_Cow_italy2024|Skin_Cow_birthday2024|Skin_Cow_pirate2024|Skin_Cow_festival|Skin_Cow_arab|Skin_Cow_arctic|Skin_Cow_japan|Skin_Cow_pirate20|Skin_Cow_classicmusic|Skin_Cow_Birthday_2025|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"Pig\" available=\"Skin_Pig_CNY|Skin_Pig_valentinesDay|\" needViewUpgradeEffect=\"0\"/>\n\t\t<type id=\"Fortress\" available=\"Skin_Fortress_aztecs|Skin_Fortress_Pirate1|Skin_Fortress_Pirate2|Skin_Fortress_Pirate3|Skin_Fortress_Gatsby1|Skin_Fortress_Gatsby2|Skin_Fortress_Gatsby3|Skin_Fortress_Christmas|Skin_Fortress_paris|Skin_Fortress_easter|Skin_Fortress_Halloween2021_1|Skin_Fortress_Halloween2021_2|Skin_Fortress_Halloween2021_3|Skin_Fortress_prehistoric|\" needViewUpgradeEffect=\"0\"/>\n\t\t<item id=\"Sheep2\" current=\"Skin_Sheep_Default\"/>\n\t\t<item id=\"Sheep0\" current=\"Skin_Sheep_Halloween2025\"/>\n\t\t<item id=\"Helicopter\" current=\"Skin_Helicopter_christmas_67\"/>\n\t\t<item id=\"Train1\" current=\"Skin_Train_SP5\"/>\n\t\t<item id=\"HelicopterPlace\" current=\"Skin_HelicopterPlace_christmas_67\"/>\n\t\t<item id=\"Chicken0\" current=\"Skin_Chicken_halloween2024\"/>\n\t\t<item id=\"Cow1\" current=\"Skin_Cow_halloween2023\"/>\n\t\t<item id=\"Train2\" current=\"Skin_Train_SP5\"/>\n\t\t<item id=\"Ship2\" current=\"Skin_Ship_halloween2022\"/>\n\t\t<item id=\"Sheep1\" current=\"Skin_Sheep_Halloween2025\"/>\n\t\t<item id=\"TrainStation\" current=\"Skin_TrainStation_halloween2024\"/>\n\t\t<item id=\"Airplane\" current=\"Skin_Airplane_Halloween2025\"/>\n\t\t<item id=\"Chicken2\" current=\"Skin_Chicken_halloween2024\"/>\n\t\t<item id=\"Train0\" current=\"Skin_Train_SP5\"/>\n\t\t<item id=\"Pig1\" current=\"Skin_Pig_valentinesDay\"/>\n\t\t<item id=\"Ship0\" current=\"Skin_Ship_halloween2022\"/>\n\t\t<item id=\"Pig2\" current=\"Skin_Pig_Default\"/>\n\t\t<item id=\"Fortress\" current=\"Skin_Fortress_Halloween2021_3\"/>\n\t\t<item id=\"Pig0\" current=\"Skin_Pig_valentinesDay\"/>\n\t\t<item id=\"Harbor\" current=\"Skin_Harbor_halloween2022\"/>\n\t\t<item id=\"Cow2\" current=\"Skin_Cow_halloween2023\"/>\n\t\t<item id=\"Airport\" current=\"Skin_Airport_Halloween2025\"/>\n\t\t<item id=\"Ship1\" current=\"Skin_Ship_halloween2022\"/>\n\t\t<item id=\"Ship3\" current=\"Skin_Ship_halloween2022\"/>\n\t\t<item id=\"Cow0\" current=\"Skin_Cow_halloween2023\"/>\n\t\t<item id=\"Chicken1\" current=\"Skin_Chicken_halloween2024\"/>\n\t</Skins>";
const APP_DECOR_XML = "<FragmentedBeautyManager>\n\t\t<Buildings>\n\t\t\t<ExpeditionDecoration guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration>\n\t\t\t<ExpeditionDecoration10 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration10>\n\t\t\t<ExpeditionDecoration11 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration11>\n\t\t\t<ExpeditionDecoration12 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration12>\n\t\t\t<ExpeditionDecoration13 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"0\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration13>\n\t\t\t<ExpeditionDecoration14 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"0\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration14>\n\t\t\t<ExpeditionDecoration15 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"0\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration15>\n\t\t\t<ExpeditionDecoration16 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"0\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration16>\n\t\t\t<ExpeditionDecoration17 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"0\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration17>\n\t\t\t<ExpeditionDecoration18 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"0\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration18>\n\t\t\t<ExpeditionDecoration19 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"0\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration19>\n\t\t\t<ExpeditionDecoration2 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part3 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration2>\n\t\t\t<ExpeditionDecoration3 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration3>\n\t\t\t<ExpeditionDecoration4 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration4>\n\t\t\t<ExpeditionDecoration5 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration5>\n\t\t\t<ExpeditionDecoration6 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration6>\n\t\t\t<ExpeditionDecoration7 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration7>\n\t\t\t<ExpeditionDecoration8 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration8>\n\t\t\t<ExpeditionDecoration9 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</ExpeditionDecoration9>\n\t\t\t<Merge2Decoration1 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part3 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration1>\n\t\t\t<Merge2Decoration10 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration10>\n\t\t\t<Merge2Decoration11 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration11>\n\t\t\t<Merge2Decoration12 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration12>\n\t\t\t<Merge2Decoration2 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part3 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration2>\n\t\t\t<Merge2Decoration3 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part3 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration3>\n\t\t\t<Merge2Decoration4 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part3 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration4>\n\t\t\t<Merge2Decoration5 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part3 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration5>\n\t\t\t<Merge2Decoration6 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part3 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration6>\n\t\t\t<Merge2Decoration7 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part3 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration7>\n\t\t\t<Merge2Decoration8 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"0\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part2 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration8>\n\t\t\t<Merge2Decoration9 guid=\"\">\n\t\t\t\t<base active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t\t<part1 active=\"1\" beenSetOnField=\"1\"/>\n\t\t\t</Merge2Decoration9>\n\t\t</Buildings>\n\t</FragmentedBeautyManager>";

function _xmlEscape(value) {
    return String(value).replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}
function _replaceOrInsert(text, pattern, replacement) {
    if (pattern.test(text)) return text.replace(pattern, replacement);
    const end = text.lastIndexOf("</");
    if (end < 0) throw new Error("لم يتم العثور على موضع XML للإضافة");
    return text.slice(0, end) + replacement + "\n" + text.slice(end);
}
function _selectedList(value, key) {
    const obj = value && typeof value === "object" && !Array.isArray(value) ? value : {selected: value};
    const list = obj[key] || [];
    if (!Array.isArray(list) || list.length === 0) throw new Error("لم يتم اختيار أي عنصر");
    return [...new Set(list.map(x => String(x).trim()).filter(Boolean))];
}
function editSkinsLikeApp(xml, value) {
    const selected = new Set(_selectedList(value, "selected"));
    const types = [];
    for (const match of APP_SKINS_XML.matchAll(/<type\b[^>]*\bid="([^"]+)"[^>]*\bavailable="([^"]*)"[^>]*\/>/gi)) {
        const ids = [...new Set(match[2].split(/[|,]/).map(x => x.trim()).filter(x => selected.has(x)))];
        if (ids.length) types.push(`<type id="${_xmlEscape(match[1])}" available="${_xmlEscape(ids.join("|"))}|" needViewUpgradeEffect="0"/>`);
    }
    const items = [];
    for (const match of APP_SKINS_XML.matchAll(/<item\b[^>]*\bid="([^"]+)"[^>]*\bcurrent="([^"]*)"[^>]*\/>/gi)) {
        if (selected.has(match[2].trim())) items.push(`<item id="${_xmlEscape(match[1])}" current="${_xmlEscape(match[2].trim())}"/>`);
    }
    if (!types.length && !items.length) throw new Error("المظاهر المحددة غير موجودة في كتالوج التطبيق");
    const block = `<Skins>\n\t\t${types.concat(items).join("\n\t\t")}\n\t</Skins>`;
    return Buffer.from(_replaceOrInsert(Buffer.isBuffer(xml) ? xml.toString("utf8") : String(xml), /<Skins\b[^>]*>[\s\S]*?<\/Skins>/i, block), "utf8");
}
function _incrementStash(text, items, count) {
    let stash = text.match(/<BuildingsStash\b[^>]*>[\s\S]*?<\/BuildingsStash>/i);
    let body = stash ? (stash[0].match(/<BuildingsStash\b[^>]*>([\s\S]*?)<\/BuildingsStash>/i) || ["", ""])[1] : "";
    for (const id of items) {
        const pattern = new RegExp(`<Building\\b[^>]*\\bid=["']${id.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}["'][^>]*\\bcount=["'](\\d+)["'][^>]*/?>`, "i");
        const found = body.match(pattern);
        if (found) body = body.replace(found[0], found[0].replace(/\bcount=["']\d+["']/i, `count="${Number(found[1]) + count}"`));
        else body += `\n<Building id="${_xmlEscape(id)}" count="${count}"/>`;
    }
    const replacement = `<BuildingsStash>${body}\n</BuildingsStash>`;
    return stash ? text.replace(stash[0], replacement) : _replaceOrInsert(text, /<FragmentedBeautyManager\b[^>]*>[\s\S]*?<\/FragmentedBeautyManager>/i, m => m + "\n" + replacement);
}
function editDecorLikeApp(xml, value) {
    const obj = value && typeof value === "object" ? value : {};
    const items = _selectedList(obj, "items");
    const count = Math.max(1, Math.floor(Number(obj.count || 1)));
    if (!Number.isFinite(count)) throw new Error("عدد الديكورات غير صالح");
    let text = Buffer.isBuffer(xml) ? xml.toString("utf8") : String(xml);
    text = _replaceOrInsert(text, /<FragmentedBeautyManager\b[^>]*>[\s\S]*?<\/FragmentedBeautyManager>/i, APP_DECOR_XML);
    return Buffer.from(_incrementStash(text, items, count), "utf8");
}

function enableAllSkins(xml) {
    const text = Buffer.isBuffer(xml) ? xml.toString("utf8") : String(xml);
    const match = text.match(/<Skins\b[^>]*>[\s\S]*?<\/Skins>/i);
    if (!match) throw new Error("لم يتم العثور على عقدة Skins");
    const normalized = match[0].replace(/\bavailable=(['"])(.*?)\1/gi, (full, quote, value) => {
        const values = [...new Set(value.split(/[|,]/).map(v => v.trim()).filter(Boolean))];
        if (!values.length) return full;
        return `available="${values.join("|")}|"`;
    });
    return Buffer.from(text.replace(match[0], normalized), "utf8");
}

function enableAllDecorations(xml) {
    const text = Buffer.isBuffer(xml) ? xml.toString("utf8") : String(xml);
    const manager = text.match(/<FragmentedBeautyManager\b[^>]*>[\s\S]*?<\/FragmentedBeautyManager>/i);
    if (!manager) throw new Error("لم يتم العثور على عقدة FragmentedBeautyManager");
    const buildings = manager[0].match(/<Buildings\b[^>]*>[\s\S]*?<\/Buildings>/i);
    if (!buildings) throw new Error("لم يتم العثور على عقدة Buildings داخل FragmentedBeautyManager");
    let changed = 0;
    const body = buildings[0].replace(/<[^>]+>/g, tag => {
        if (/^<\//.test(tag) || /^<Buildings\b/i.test(tag)) return tag;
        let next = tag;
        if (/\bactive\s*=/.test(next)) next = next.replace(/\bactive\s*=\s*(["'])[^"']*\1/i, 'active="1"');
        if (/\bbeenSetOnField\s*=/.test(next)) next = next.replace(/\bbeenSetOnField\s*=\s*(["'])[^"']*\1/i, 'beenSetOnField="1"');
        if (next !== tag) changed++;
        return next;
    });
    if (!changed) throw new Error("لم يتم العثور على عناصر ديكور قابلة للتفعيل");
    const updatedManager = manager[0].replace(buildings[0], body);
    return Buffer.from(text.replace(manager[0], updatedManager), "utf8");
}

/*
========================================
EDITORS
========================================
*/

const EDITORS = {
    trainBox:
        function(xml, value) {
            return _editTrains(xml, value, false);
        },
    trainAll:
        function(xml, value) {
            return _editTrains(xml, value, true);
        },
    goldenTicket:
        function(xml) {
            return unlockGoldenTicket(xml);
        },
    goldenTicket2:
        function(xml) {
            return unlockGoldenTicket2(xml);
        },

    money:
        function(xml, value) {
            return changeMoney(xml, value);
        },
    moneyCash:
        function(xml, value) {
            return changeMoneyCash(xml, value);
        },
    gameStartDate:
        function(xml, value) {
            return changeGameStartDate(xml, value);
        },
    barnCapacity:
        function(xml, value) {
            return changeBarnCapacity(xml, value);
        },
    frameCoins:
        function(xml, value) {
            return changeFrameCoins(xml, value);
        },
    showAllEvents:
        function(xml) {
            return showAllEvents(xml);
        },
    resource:
        function(xml, value) {
            return changeResource(xml, value);
        },
    resourceBatch:
        function(xml, value) {
            if (!Array.isArray(value) || value.length === 0) throw new Error('دفعة الموارد فارغة أو غير صحيحة.');
            let result = Buffer.isBuffer(xml) ? xml : Buffer.from(xml);
            for (const item of value) result = changeResource(result, item);
            return result;
        },
    coupon:
        function(xml, value) {
            let options = value;
            if (typeof options === 'string') {
                try { options = JSON.parse(options); } catch (_) { throw new Error('إعداد القسيمة يجب أن يكون JSON صالحًا.'); }
            }
            if (!options || typeof options !== 'object' || Array.isArray(options)) throw new Error('إعداد القسيمة غير صحيح.');
            const name = String(options.name ?? '').trim();
            if (!/^Coupon[A-Za-z0-9_]*$/.test(name) && name !== 'freeExpansion' && name !== 'freeAmbarInc') throw new Error(`اسم القسيمة غير معروف: ${name}`);
            return _changeCoupon(xml, name, options.value);
        },
    barnItem:
        function(xml, value) {
            return changeBarnItem(xml, value);
        },
    barnBatch:
        function(xml, value) {
            if (!Array.isArray(value) || value.length === 0) throw new Error('دفعة الشونة فارغة أو غير صحيحة.');
            let result = Buffer.isBuffer(xml) ? xml : Buffer.from(xml);
            for (const item of value) result = changeBarnItem(result, item);
            return result;
        },


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

    skins:
        function(xml, value) {
            return editSkinsLikeApp(xml, value);
        },

    allDecor:
        function(xml, value) {
            return editDecorLikeApp(xml, value);
        },

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
            ط¯ط¹ظ… ط§ظ„ط´ظƒظ„ ط§ظ„ط¬ط¯ظٹط¯:

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
            ط¥ط°ط§ طھظ… ط¥ط±ط³ط§ظ„ ظ‚ظٹظ…ط© ظˆط§ط­ط¯ط©
            */

            return changeRegataTasks(
                xml,
                value,
                135
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

    ظ…ط«ط§ظ„:

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
                    `طھط¹ط¯ظٹظ„ ط؛ظٹط± ظ…ط¹ط±ظˆظپ: ${key}`
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
            "طµظٹط؛ط© ط§ظ„طھط¹ط¯ظٹظ„ط§طھ ط؛ظٹط± طµط­ظٹط­ط©"
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
                `طھط¹ط¯ظٹظ„ ط؛ظٹط± ظ…ط¹ط±ظˆظپ: ${key}`
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
        ظ‚ظٹظ…ط© ط¹ط§ط¯ظٹط©
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
    editTrainBox: function(xml, options) {
        return _editTrains(xml, options, false);
    },
    editAllTrains: function(xml, options) {
        return _editTrains(xml, options, true);
    },
    unlockGoldenTicket,
    unlockGoldenTicket2,

    changeVar,

    changeMoney,
    changeMoneyCash,
    changeGameStartDate,
    changeBarnCapacity,
    changeFrameCoins,
    showAllEvents,
    changeResource,
    changeBarnItem,

    changeDataElem,

    editSkinsLikeApp,

    editDecorLikeApp,

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

    ALL_CHAT_EMOJI_IDS,

    AVATAR_IDS,

    MIGRATE_AVATAR_IDS,

    UNLOCKED_FRAMES_VALUE,

    UNLOCKED_STYLES_VALUE,

    UNLOCKED_EXP_RANKS_VALUE,
    
    UNLOCKED_BADGES_VALUE

};
