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
    "VEdYLhJsBm49Gy0tFgIwCCM=,VEdYLhJsBnM9Gy0tFgIwCCM=,VFBKNx5FUig9Gy0tFgIwCCM=,VEdYLhJsA3A9Gy0tFgIwCCM=,VEdYLhJsA3E9Gy0tFgIwCCM=,VEdYLhJsA3I9Gy0tFgIwCCM=,VEdYLhJsA3M9Gy0tFgIwCCM=,fbwcfgtQVl0mEVRb,VEdYLhJsA3w9Gy0tFgIwCCM=,VEdYLhJsA309Gy0tFgIwCCM=,VEdYLhJsAnQ9Gy0tFgIwCCM=,VEdYLhJsAnU9Gy0tFgIwCCM=,VEdYLhJsA3c9Gy0tFgIwCCM=,VgwuOhMVEB0qD1IpRhp6X30QVzMnERINWg==,VEdYLhJsBnQ9Gy0tFgIwCCM=,5bwcfgtQVl0mEVRb,Z8pyyL7TfVJRJ1MfKSka,VEdYLhJsBnE9Gy0tFgIwCCM=,VEdYLhJsBnY9Gy0tFgIwCCM=,VEdYLhJsAiA9Gy0tFgIwCCM=,VEdYLhJsAiE9Gy0tFgIwCCM=,VEdYLhJsAiI9Gy0tFgIwCCM=,VEdYLhJsAiM9Gy0tFgIwCCM=,VEdYLhJsAiQ9Gy0tFgIwCCM=,VEdYLhJsAiU9Gy0tFgIwCCM=,VEdYLhJsAiY9Gy0tFgIwCCM=,VEdYLhJsAic9Gy0tFgIwCCM=,VEdYLhJsAig9Gy0tFgIwCCM=,VEdYLhJsAik9Gy0tFgIwCCM=,VEdYLhJsAio9Gy0tFgIwCCM=,VEdYLhJsAis9Gy0tFgIwCCM=,VEdYLhJsAiw9Gy0tFgIwCCM=,VEdYLhJsAi09Gy0tFgIwCCM=,VEdYLhJsAi49Gy0tFgIwCCM=,VEdYLhJsAi89Gy0tFgIwCCM=,VEdYLhJsAjA9Gy0tFgIwCCM=,VEdYLhJsAjE9Gy0tFgIwCCM=,VEdYLhJsAjI9Gy0tFgIwCCM=,VEdYLhJsAjM9Gy0tFgIwCCM=,VEdYLhJsAjQ9Gy0tFgIwCCM=,VEdYLhJsAjU9Gy0tFgIwCCM=,VEdYLhJsAjY9Gy0tFgIwCCM=,VEdYLhJsAjc9Gy0tFgIwCCM=,VEdYLhJsAjg9Gy0tFgIwCCM=,VEdYLhJsAjk9Gy0tFgIwCCM=,VEdYLhJsAjo9Gy0tFgIwCCM=,VEdYLhJsAjs9Gy0tFgIwCCM=,VEdYLhJsAjw9Gy0tFgIwCCM=,VEdYLhJsAj09Gy0tFgIwCCM=,VEdYLhJsAj49Gy0tFgIwCCM=,VEdYLhJsAj89Gy0tFgIwCCM=,VEdYLhJsAkA9Gy0tFgIwCCM=,VEdYLhJsAkE9Gy0tFgIwCCM=,VEdYLhJsAkI9Gy0tFgIwCCM=,VEdYLhJsAkM9Gy0tFgIwCCM=,VEdYLhJsAkQ9Gy0tFgIwCCM=,VEdYLhJsAkU9Gy0tFgIwCCM=,VEdYLhJsAkY9Gy0tFgIwCCM=,VEdYLhJsAkc9Gy0tFgIwCCM=,VEdYLhJsAkg9Gy0tFgIwCCM=,VEdYLhJsAkk9Gy0tFgIwCCM=,VEdYLhJsAko9Gy0tFgIwCCM=,VEdYLhJsAks9Gy0tFgIwCCM=,VEdYLhJsAkw9Gy0tFgIwCCM=,VEdYLhJsAk09Gy0tFgIwCCM=,DEBUVCYoAjklVRkrKxQAPg==,VEdYLhJsAk89Gy0tFgIwCCM=,VEdYLhJsAlA9Gy0tFgIwCCM=,VEdYLhJsAlE9Gy0tFgIwCCM=,VEdYLhJsAlI9Gy0tFgIwCCM=,VEdYLhJsAlM9Gy0tFgIwCCM=,VEdYLhJsAlQ9Gy0tFgIwCCM=,VEdYLhJsAlU9Gy0tFgIwCCM=,VEdYLhJsAlY9Gy0tFgIwCCM=,VEdYLhJsAlc9Gy0tFgIwCCM=,VEdYLhJsAlg9Gy0tFgIwCCM=,VEdYLhJsAlk9Gy0tFgIwCCM=,VEdYLhJsAlo9Gy0tFgIwCCM=,VEdYLhJsAls9Gy0tFgIwCCM=,VEdYLhJsAlw9Gy0tFgIwCCM=,VEdYLhJsAl09Gy0tFgIwCCM=,VEdYLhJsAl49Gy0tFgIwCCM=,VEdYLhJsAl89Gy0tFgIwCCM=,VEdYLhJsAmA9Gy0tFgIwCCM=,VEdYLhJsAmE9Gy0tFgIwCCM=,VEdYLhJsAmI9Gy0tFgIwCCM=,VEdYLhJsAmM9Gy0tFgIwCCM=,VEdYLhJsAmQ9Gy0tFgIwCCM=,VEdYLhJsAmU9Gy0tFgIwCCM=,VEdYLhJsAmY9Gy0tFgIwCCM=,VEdYLhJsAmc9Gy0tFgIwCCM=,VEdYLhJsAmg9Gy0tFgIwCCM=,VEdYLhJsAmk9Gy0tFgIwCCM=,VEdYLhJsAmo9Gy0tFgIwCCM=,VEdYLhJsAms9Gy0tFgIwCCM=,VEdYLhJsAmw9Gy0tFgIwCCM=,VEdYLhJsAm09Gy0tFgIwCCM=,VEdYLhJsAm49Gy0tFgIwCCM=,VEdYLhJsAm89Gy0tFgIwCCM=,VEdYLhJsAnA9Gy0tFgIwCCM=,VEdYLhJsAnE9Gy0tFgIwCCM=,VEdYLhJsAnI9Gy0tFgIwCCM=,VEdYLhJsAnM9Gy0tFgIwCCM=,VEdYLhJsAnY9Gy0tFgIwCCM=,VEdYLhJsAnc9Gy0tFgIwCCM=,VEdYLhJsAng9Gy0tFgIwCCM=,VEdYLhJsAnk9Gy0tFgIwCCM=,VEdYLhJsAno9Gy0tFgIwCCM=,VEdYLhJsAns9Gy0tFgIwCCM=,VEdYLhJsAnw9Gy0tFgIwCCM=,VEdYLhJsAn09Gy0tFgIwCCM=,VEdYLhJsAn49Gy0tFgIwCCM=,VEdYLhJsAn89Gy0tFgIwCCM=,VEdYLhJsADA9Gy0tFgIwCCM=,VEdYLhJsADE9Gy0tFgIwCCM=,VEdYLhJsADI9Gy0tFgIwCCM=,VEdYLhJsADM9Gy0tFgIwCCM=,VEdYLhJsADQ9Gy0tFgIwCCM=,VEdYLhJsADU9Gy0tFgIwCCM=,VEdYLhJsADY9Gy0tFgIwCCM=,VEdYLhJsADc9Gy0tFgIwCCM=,VEdYLhJsADg9Gy0tFgIwCCM=,VEdYLhJsADk9Gy0tFgIwCCM=,VEdYLhJsAEE9Gy0tFgIwCCM=,VEdYLhJsAEI9Gy0tFgIwCCM=,VEdYLhJsAEM9Gy0tFgIwCCM=,VEdYLhJsAEQ9Gy0tFgIwCCM=,VEdYLhJsAEU9Gy0tFgIwCCM=,VEdYLhJsAEY9Gy0tFgIwCCM=,VEdYLhJsAEc9Gy0tFgIwCCM=,VEdYLhJsAEg9Gy0tFgIwCCM=,VEdYLhJsAEk9Gy0tFgIwCCM=,VEdYLhJsAEo9Gy0tFgIwCCM=,VEdYLhJsAEs9Gy0tFgIwCCM=,VEdYLhJsAEw9Gy0tFgIwCCM=,VEdYLhJsAE09Gy0tFgIwCCM=,DEBUVCYoADklVRkrKxQAPg==,VEdYLhJsAE89Gy0tFgIwCCM=,VEdYLhJsAFA9Gy0tFgIwCCM=,VEdYLhJsAFE9Gy0tFgIwCCM=,VEdYLhJsAFI9Gy0tFgIwCCM=,VEdYLhJsAFM9Gy0tFgIwCCM=,VEdYLhJsAFQ9Gy0tFgIwCCM=,VEdYLhJsAFU9Gy0tFgIwCCM=,VEdYLhJsAFY9Gy0tFgIwCCM=,VEdYLhJsAFc9Gy0tFgIwCCM=,VEdYLhJsAFg9Gy0tFgIwCCM=,VEdYLhJsAFk9Gy0tFgIwCCM=,VEdYLhJsAFo9Gy0tFgIwCCM=,VEdYLhJsAGA9Gy0tFgIwCCM=,VEdYLhJsAGE9Gy0tFgIwCCM=,VEdYLhJsAGI9Gy0tFgIwCCM=,VEdYLhJsAGM9Gy0tFgIwCCM=,VEdYLhJsAGQ9Gy0tFgIwCCM=,VEdYLhJsAGU9Gy0tFgIwCCM=,VEdYLhJsAGY9Gy0tFgIwCCM=,VEdYLhJsAGc9Gy0tFgIwCCM=,VEdYLhJsAGg9Gy0tFgIwCCM=,VEdYLhJsAGk9Gy0tFgIwCCM=,VEdYLhJsAGo9Gy0tFgIwCCM=,VEdYLhJsAGs9Gy0tFgIwCCM=,VEdYLhJsAGw9Gy0tFgIwCCM=,VEdYLhJsAG09Gy0tFgIwCCM=,VEdYLhJsAG49Gy0tFgIwCCM=,VEdYLhJsAG89Gy0tFgIwCCM=,VEdYLhJsAHA9Gy0tFgIwCCM=,VEdYLhJsAHE9Gy0tFgIwCCM=,VEdYLhJsAHI9Gy0tFgIwCCM=,VEdYLhJsAHM9Gy0tFgIwCCM=,VEdYLhJsAHQ9Gy0tFgIwCCM=,VEdYLhJsAHU9Gy0tFgIwCCM=,VEdYLhJsAHY9Gy0tFgIwCCM=,VEdYLhJsAHc9Gy0tFgIwCCM=,VEdYLhJsAHg9Gy0tFgIwCCM=,VEdYLhJsAHk9Gy0tFgIwCCM=,VEdYLhJsAHo9Gy0tFgIwCCM=,VEdYLhJsAHs9Gy0tFgIwCCM=,VEdYLhJsAHw9Gy0tFgIwCCM=,VEdYLhJsAH09Gy0tFgIwCCM=,VEdYLhJsAH49Gy0tFgIwCCM=,VEdYLhJsAH89Gy0tFgIwCCM=,VEdYLhJsATA9Gy0tFgIwCCM=,VEdYLhJsATE9Gy0tFgIwCCM=,VEdYLhJsATI9Gy0tFgIwCCM=,VEdYLhJsATM9Gy0tFgIwCCM=,VEdYLhJsATQ9Gy0tFgIwCCM=,VEdYLhJsATU9Gy0tFgIwCCM=,VEdYLhJsATY9Gy0tFgIwCCM=,VEdYLhJsATc9Gy0tFgIwCCM=,VEdYLhJsATg9Gy0tFgIwCCM=,VEdYLhJsATk9Gy0tFgIwCCM=,VEdYLhJsAUE9Gy0tFgIwCCM=,VEdYLhJsAUI9Gy0tFgIwCCM=,VEdYLhJsAUM9Gy0tFgIwCCM=,VEdYLhJsAUQ9Gy0tFgIwCCM=,VEdYLhJsAUU9Gy0tFgIwCCM=,VEdYLhJsAUY9Gy0tFgIwCCM=,VEdYLhJsAUc9Gy0tFgIwCCM=,VEdYLhJsAUg9Gy0tFgIwCCM=,VEdYLhJsAUk9Gy0tFgIwCCM=,VEdYLhJsAUo9Gy0tFgIwCCM=,VEdYLhJsAUs9Gy0tFgIwCCM=,VEdYLhJsAUw9Gy0tFgIwCCM=,VEdYLhJsAU09Gy0tFgIwCCM=,DEBUVCYoATklVRkrKxQAPg==,VEdYLhJsAU89Gy0tFgIwCCM=,VEdYLhJsAVA9Gy0tFgIwCCM=,VEdYLhJsAVE9Gy0tFgIwCCM=,VEdYLhJsAVI9Gy0tFgIwCCM=,VEdYLhJsAVM9Gy0tFgIwCCM=,VEdYLhJsAVQ9Gy0tFgIwCCM=,VEdYLhJsAVU9Gy0tFgIwCCM=,VEdYLhJsAVY9Gy0tFgIwCCM=,VEdYLhJsAVc9Gy0tFgIwCCM=,VEdYLhJsAVg9Gy0tFgIwCCM=,VEdYLhJsAVk9Gy0tFgIwCCM=,VEdYLhJsAVo9Gy0tFgIwCCM=,VEdYLhJsAWA9Gy0tFgIwCCM=,VEdYLhJsAWE9Gy0tFgIwCCM=,VEdYLhJsAWI9Gy0tFgIwCCM=,VEdYLhJsAWM9Gy0tFgIwCCM=,VEdYLhJsAWQ9Gy0tFgIwCCM=,VEdYLhJsAWU9Gy0tFgIwCCM=,VEdYLhJsAWY9Gy0tFgIwCCM=,VEdYLhJsAWc9Gy0tFgIwCCM=,VEdYLhJsAWg9Gy0tFgIwCCM=,VEdYLhJsAWk9Gy0tFgIwCCM=,VEdYLhJsAWo9Gy0tFgIwCCM=,VEdYLhJsAWs9Gy0tFgIwCCM=,VEdYLhJsAWw9Gy0tFgIwCCM=,VEdYLhJsAW09Gy0tFgIwCCM=,VEdYLhJsAW49Gy0tFgIwCCM=,VEdYLhJsAW89Gy0tFgIwCCM=,VEdYLhJsAXA9Gy0tFgIwCCM=,VEdYLhJsAXE9Gy0tFgIwCCM=,VEdYLhJsAXI9Gy0tFgIwCCM=,VEdYLhJsAXM9Gy0tFgIwCCM=,VEdYLhJsAXQ9Gy0tFgIwCCM=,VEdYLhJsAXU9Gy0tFgIwCCM=,VEdYLhJsAXY9Gy0tFgIwCCM=,VEdYLhJsAXc9Gy0tFgIwCCM=,VEdYLhJsAXg9Gy0tFgIwCCM=,VEdYLhJsAXk9Gy0tFgIwCCM=,VEdYLhJsAXo9Gy0tFgIwCCM=,VEdYLhJsAXs9Gy0tFgIwCCM=,VEdYLhJsAXw9Gy0tFgIwCCM=,VEdYLhJsAX09Gy0tFgIwCCM=,VEdYLhJsAX49Gy0tFgIwCCM=,VEdYLhJsAX89Gy0tFgIwCCM=,VEdYLhJsAzA9Gy0tFgIwCCM=,VEdYLhJsAzE9Gy0tFgIwCCM=,VEdYLhJsAzI9Gy0tFgIwCCM=,VEdYLhJsAzM9Gy0tFgIwCCM=,VEdYLhJsAzQ9Gy0tFgIwCCM=,VEdYLhJsAzU9Gy0tFgIwCCM=,VEdYLhJsAzY9Gy0tFgIwCCM=,VEdYLhJsAzc9Gy0tFgIwCCM=,VEdYLhJsAzg9Gy0tFgIwCCM=,VEdYLhJsAzk9Gy0tFgIwCCM=,VEdYLhJsA0E9Gy0tFgIwCCM=,VEdYLhJsA0I9Gy0tFgIwCCM=,VEdYLhJsA0M9Gy0tFgIwCCM=,VEdYLhJsA0Q9Gy0tFgIwCCM=,VEdYLhJsA0U9Gy0tFgIwCCM=,VEdYLhJsA0Y9Gy0tFgIwCCM=,VEdYLhJsA0c9Gy0tFgIwCCM=,VEdYLhJsA0g9Gy0tFgIwCCM=,VEdYLhJsA0k9Gy0tFgIwCCM=,VEdYLhJsA0o9Gy0tFgIwCCM=,VEdYLhJsA0s9Gy0tFgIwCCM=,VEdYLhJsA0w9Gy0tFgIwCCM=,VEdYLhJsA009Gy0tFgIwCCM=,DEBUVCYoAzklVRkrKxQAPg==,VEdYLhJsA089Gy0tFgIwCCM=,VEdYLhJsA1A9Gy0tFgIwCCM=,VEdYLhJsA1E9Gy0tFgIwCCM=,VEdYLhJsA1I9Gy0tFgIwCCM=,VEdYLhJsA1M9Gy0tFgIwCCM=,VEdYLhJsA1Q9Gy0tFgIwCCM=,VEdYLhJsA1U9Gy0tFgIwCCM=,VEdYLhJsA1Y9Gy0tFgIwCCM=,VEdYLhJsA1c9Gy0tFgIwCCM=,VEdYLhJsA1g9Gy0tFgIwCCM=,VEdYLhJsA1k9Gy0tFgIwCCM=,VEdYLhJsA1o9Gy0tFgIwCCM=,VEdYLhJsA2A9Gy0tFgIwCCM=,VEdYLhJsA2E9Gy0tFgIwCCM=,VEdYLhJsA2I9Gy0tFgIwCCM=,VEdYLhJsA2M9Gy0tFgIwCCM=,VEdYLhJsA2Q9Gy0tFgIwCCM=,VEdYLhJsA2U9Gy0tFgIwCCM=,VEdYLhJsA2Y9Gy0tFgIwCCM=,VEdYLhJsA2c9Gy0tFgIwCCM=,VEdYLhJsA2g9Gy0tFgIwCCM=,VEdYLhJsA2k9Gy0tFgIwCCM=,VEdYLhJsA2o9Gy0tFgIwCCM=,VEdYLhJsA2s9Gy0tFgIwCCM=,VEdYLhJsA2w9Gy0tFgIwCCM=,VEdYLhJsA209Gy0tFgIwCCM=,VEdYLhJsA249Gy0tFgIwCCM=,VEdYLhJsA289Gy0tFgIwCCM=,VEdYLhJsA3Q9Gy0tFgIwCCM=,VEdYLhJsA3g9Gy0tFgIwCCM=,VEdYLhJsA3k9Gy0tFgIwCCM=,VEdYLhJsA3o9Gy0tFgIwCCM=,VEdYLhJsA3s9Gy0tFgIwCCM=,VEdYLhJsA349Gy0tFgIwCCM=,VEdYLhJsA389Gy0tFgIwCCM=,VEdYLhJsBDA9Gy0tFgIwCCM=,VEdYLhJsBDE9Gy0tFgIwCCM=,VEdYLhJsBDI9Gy0tFgIwCCM=,VEdYLhJsBDM9Gy0tFgIwCCM=,VEdYLhJsBDQ9Gy0tFgIwCCM=,VEdYLhJsBDU9Gy0tFgIwCCM=,VEdYLhJsBDY9Gy0tFgIwCCM=,VEdYLhJsBDc9Gy0tFgIwCCM=,VEdYLhJsBDg9Gy0tFgIwCCM=,VEdYLhJsBDk9Gy0tFgIwCCM=,VEdYLhJsBEE9Gy0tFgIwCCM=,VEdYLhJsBEI9Gy0tFgIwCCM=,VEdYLhJsBEM9Gy0tFgIwCCM=,VEdYLhJsBEQ9Gy0tFgIwCCM=,VEdYLhJsBEU9Gy0tFgIwCCM=,VEdYLhJsBEY9Gy0tFgIwCCM=,VEdYLhJsBEc9Gy0tFgIwCCM=,VEdYLhJsBEg9Gy0tFgIwCCM=,VEdYLhJsBEk9Gy0tFgIwCCM=,VEdYLhJsBEo9Gy0tFgIwCCM=,VEdYLhJsBEs9Gy0tFgIwCCM=,VEdYLhJsBEw9Gy0tFgIwCCM=,VEdYLhJsBE09Gy0tFgIwCCM=,DEBUVCYoBDklVRkrKxQAPg==,VEdYLhJsBE89Gy0tFgIwCCM=,VEdYLhJsBFA9Gy0tFgIwCCM=,VEdYLhJsBFE9Gy0tFgIwCCM=,VEdYLhJsBFI9Gy0tFgIwCCM=,VEdYLhJsBFM9Gy0tFgIwCCM=,VEdYLhJsBFQ9Gy0tFgIwCCM=,VEdYLhJsBFU9Gy0tFgIwCCM=,VEdYLhJsBFY9Gy0tFgIwCCM=,VEdYLhJsBFc9Gy0tFgIwCCM=,VEdYLhJsBFg9Gy0tFgIwCCM=,VEdYLhJsBFk9Gy0tFgIwCCM=,VEdYLhJsBFo9Gy0tFgIwCCM=,VEdYLhJsBGA9Gy0tFgIwCCM=,VEdYLhJsBGE9Gy0tFgIwCCM=,VEdYLhJsBGI9Gy0tFgIwCCM=,VEdYLhJsBGM9Gy0tFgIwCCM=,VEdYLhJsBGQ9Gy0tFgIwCCM=,VEdYLhJsBGU9Gy0tFgIwCCM=,VEdYLhJsBGY9Gy0tFgIwCCM=,VEdYLhJsBGc9Gy0tFgIwCCM=,VEdYLhJsBGg9Gy0tFgIwCCM=,VEdYLhJsBGk9Gy0tFgIwCCM=,VEdYLhJsBGo9Gy0tFgIwCCM=,VEdYLhJsBGs9Gy0tFgIwCCM=,VEdYLhJsBGw9Gy0tFgIwCCM=,VEdYLhJsBG09Gy0tFgIwCCM=,VEdYLhJsBG49Gy0tFgIwCCM=,VEdYLhJsBG89Gy0tFgIwCCM=,VEdYLhJsBHA9Gy0tFgIwCCM=,VEdYLhJsBHE9Gy0tFgIwCCM=,VEdYLhJsBHI9Gy0tFgIwCCM=,VEdYLhJsBHM9Gy0tFgIwCCM=,VEdYLhJsBHQ9Gy0tFgIwCCM=,VEdYLhJsBHU9Gy0tFgIwCCM=,VEdYLhJsBHY9Gy0tFgIwCCM=,VEdYLhJsBHc9Gy0tFgIwCCM=,VEdYLhJsBHg9Gy0tFgIwCCM=,VEdYLhJsBHk9Gy0tFgIwCCM=,VEdYLhJsBHo9Gy0tFgIwCCM=,VEdYLhJsBHs9Gy0tFgIwCCM=,VEdYLhJsBHw9Gy0tFgIwCCM=,VEdYLhJsBH09Gy0tFgIwCCM=,VEdYLhJsBH49Gy0tFgIwCCM=,VEdYLhJsBH89Gy0tFgIwCCM=,VEdYLhJsBTA9Gy0tFgIwCCM=,VEdYLhJsBTE9Gy0tFgIwCCM=,VEdYLhJsBTI9Gy0tFgIwCCM=,VEdYLhJsBTM9Gy0tFgIwCCM=,VEdYLhJsBTQ9Gy0tFgIwCCM=,VEdYLhJsBTU9Gy0tFgIwCCM=,VEdYLhJsBTY9Gy0tFgIwCCM=,VEdYLhJsBTc9Gy0tFgIwCCM=,VEdYLhJsBTg9Gy0tFgIwCCM=,VEdYLhJsBTk9Gy0tFgIwCCM=,VEdYLhJsBUE9Gy0tFgIwCCM=,VEdYLhJsBUI9Gy0tFgIwCCM=,VEdYLhJsBUM9Gy0tFgIwCCM=,VEdYLhJsBUQ9Gy0tFgIwCCM=,VEdYLhJsBUU9Gy0tFgIwCCM=,VEdYLhJsBUY9Gy0tFgIwCCM=,VEdYLhJsBUc9Gy0tFgIwCCM=,VEdYLhJsBUg9Gy0tFgIwCCM=,VEdYLhJsBUk9Gy0tFgIwCCM=,VEdYLhJsBUo9Gy0tFgIwCCM=,VEdYLhJsBUs9Gy0tFgIwCCM=,VEdYLhJsBUw9Gy0tFgIwCCM=,VEdYLhJsBU09Gy0tFgIwCCM=,DEBUVCYoBTklVRkrKxQAPg==,VEdYLhJsBU89Gy0tFgIwCCM=,VEdYLhJsBVA9Gy0tFgIwCCM=,VEdYLhJsBVE9Gy0tFgIwCCM=,VEdYLhJsBVI9Gy0tFgIwCCM=,VEdYLhJsBVM9Gy0tFgIwCCM=,VEdYLhJsBVQ9Gy0tFgIwCCM=,VEdYLhJsBVU9Gy0tFgIwCCM=,VEdYLhJsBVY9Gy0tFgIwCCM=,VEdYLhJsBVc9Gy0tFgIwCCM=,VEdYLhJsBVg9Gy0tFgIwCCM=,VEdYLhJsBVk9Gy0tFgIwCCM=,VEdYLhJsBVo9Gy0tFgIwCCM=,VEdYLhJsBWA9Gy0tFgIwCCM=,VEdYLhJsBWE9Gy0tFgIwCCM=,VEdYLhJsBWI9Gy0tFgIwCCM=,VEdYLhJsBWM9Gy0tFgIwCCM=,VEdYLhJsBWQ9Gy0tFgIwCCM=,VEdYLhJsBWU9Gy0tFgIwCCM=,VEdYLhJsBWY9Gy0tFgIwCCM=,VEdYLhJsBWc9Gy0tFgIwCCM=,VEdYLhJsBWg9Gy0tFgIwCCM=,VEdYLhJsBWk9Gy0tFgIwCCM=,VEdYLhJsBWo9Gy0tFgIwCCM=,VEdYLhJsBWs9Gy0tFgIwCCM=,VEdYLhJsBWw9Gy0tFgIwCCM=,VEdYLhJsBW09Gy0tFgIwCCM=,VEdYLhJsBW49Gy0tFgIwCCM=,VEdYLhJsBW89Gy0tFgIwCCM=,VEdYLhJsBXA9Gy0tFgIwCCM=,VEdYLhJsBXE9Gy0tFgIwCCM=,VEdYLhJsBXI9Gy0tFgIwCCM=,VEdYLhJsBXM9Gy0tFgIwCCM=,VEdYLhJsBXQ9Gy0tFgIwCCM=,VEdYLhJsBXU9Gy0tFgIwCCM=,VEdYLhJsBXY9Gy0tFgIwCCM=,VEdYLhJsBXc9Gy0tFgIwCCM=,VEdYLhJsBXg9Gy0tFgIwCCM=,VEdYLhJsBXk9Gy0tFgIwCCM=,VEdYLhJsBXo9Gy0tFgIwCCM=,VEdYLhJsBXs9Gy0tFgIwCCM=,VEdYLhJsBXw9Gy0tFgIwCCM=,VEdYLhJsBX09Gy0tFgIwCCM=,VEdYLhJsBX49Gy0tFgIwCCM=,VEdYLhJsBX89Gy0tFgIwCCM=,VEdYLhJsBjA9Gy0tFgIwCCM=,VEdYLhJsBjE9Gy0tFgIwCCM=,VEdYLhJsBjI9Gy0tFgIwCCM=,VEdYLhJsBjM9Gy0tFgIwCCM=,VEdYLhJsBjQ9Gy0tFgIwCCM=,VEdYLhJsBjU9Gy0tFgIwCCM=,VEdYLhJsBjY9Gy0tFgIwCCM=,VEdYLhJsBjc9Gy0tFgIwCCM=,VEdYLhJsBjg9Gy0tFgIwCCM=,VEdYLhJsBjk9Gy0tFgIwCCM=,VEdYLhJsBkE9Gy0tFgIwCCM=,VEdYLhJsBkI9Gy0tFgIwCCM=,VEdYLhJsBkM9Gy0tFgIwCCM=,VEdYLhJsBkQ9Gy0tFgIwCCM=,VEdYLhJsBkU9Gy0tFgIwCCM=,VEdYLhJsBkY9Gy0tFgIwCCM=,VEdYLhJsBkc9Gy0tFgIwCCM=,VEdYLhJsBkg9Gy0tFgIwCCM=,VEdYLhJsBkk9Gy0tFgIwCCM=,VEdYLhJsBko9Gy0tFgIwCCM=,VEdYLhJsBks9Gy0tFgIwCCM=,VEdYLhJsBkw9Gy0tFgIwCCM=,VEdYLhJsBk09Gy0tFgIwCCM=,DEBUVCYoBjklVRkrKxQAPg==,VEdYLhJsBk89Gy0tFgIwCCM=,VEdYLhJsBlA9Gy0tFgIwCCM=,VEdYLhJsBlE9Gy0tFgIwCCM=,VEdYLhJsBlI9Gy0tFgIwCCM=,VEdYLhJsBlM9Gy0tFgIwCCM=,VEdYLhJsBlQ9Gy0tFgIwCCM=,VEdYLhJsBlU9Gy0tFgIwCCM=,VEdYLhJsBlY9Gy0tFgIwCCM=,VEdYLhJsBlc9Gy0tFgIwCCM=,VEdYLhJsBlg9Gy0tFgIwCCM=,VEdYLhJsBlk9Gy0tFgIwCCM=,VEdYLhJsBlo9Gy0tFgIwCCM=,VEdYLhJsBmA9Gy0tFgIwCCM=,VEdYLhJsBmE9Gy0tFgIwCCM=,VEdYLhJsBmI9Gy0tFgIwCCM=,VEdYLhJsBmM9Gy0tFgIwCCM=,VEdYLhJsBmQ9Gy0tFgIwCCM=,VEdYLhJsBmU9Gy0tFgIwCCM=,VEdYLhJsBmY9Gy0tFgIwCCM=,VEdYLhJsBmc9Gy0tFgIwCCM=,VEdYLhJsBmg9Gy0tFgIwCCM=,VEdYLhJsBmk9Gy0tFgIwCCM=,VEdYLhJsBmo9Gy0tFgIwCCM=,VEdYLhJsBms9Gy0tFgIwCCM=,VEdYLhJsBmw9Gy0tFgIwCCM=,VEdYLhJsBm09Gy0tFgIwCCM=,VEdYLhJsA3Y9Gy0tFgIwCCM=,VEdYLhJsA3U9Gy0tFgIwCCM=,VEdYLhJsBnA9Gy0tFgIwCCM=,VEdYLhJsBnU9Gy0tFgIwCCM=,VEdYLhJsBnc9Gy0tFgIwCCM=,VEdYLhJsBng9Gy0tFgIwCCM=,VEdYLhJsBnk9Gy0tFgIwCCM=,VEdYLhJsBno9Gy0tFgIwCCM=,VEdYLhJsBns9Gy0tFgIwCCM=,VEdYLhJsBnw9Gy0tFgIwCCM=,VEdYLhJsBn09Gy0tFgIwCCM=,VEdYLhJsBn49Gy0tFgIwCCM=,VEdYLhJsBn89Gy0tFgIwCCM=,VEdYLhJsBzA9Gy0tFgIwCCM=,VEdYLhJsBzE9Gy0tFgIwCCM=,VEdYLhJsBzI9Gy0tFgIwCCM=,VEdYLhJsBzM9Gy0tFgIwCCM=,VEdYLhJsBzQ9Gy0tFgIwCCM=,VEdYLhJsBzU9Gy0tFgIwCCM=,VEdYLhJsBzY9Gy0tFgIwCCM=,VEdYLhJsBzc9Gy0tFgIwCCM=,VEdYLhJsBzg9Gy0tFgIwCCM=,VEdYLhJsBzk9Gy0tFgIwCCM=,VEdYLhJsB0E9Gy0tFgIwCCM=,VEdYLhJsB0I9Gy0tFgIwCCM=,VEdYLhJsB0M9Gy0tFgIwCCM=,VEdYLhJsB0Q9Gy0tFgIwCCM=,VEdYLhJsB0U9Gy0tFgIwCCM=,VEdYLhJsB0Y9Gy0tFgIwCCM=,VEdYLhJsB0c9Gy0tFgIwCCM=,VEdYLhJsB0g9Gy0tFgIwCCM=,VEdYLhJsB0k9Gy0tFgIwCCM=,VEdYLhJsB0o9Gy0tFgIwCCM=,VEdYLhJsB0s9Gy0tFgIwCCM=,VEdYLhJsB0w9Gy0tFgIwCCM=,VEdYLhJsB009Gy0tFgIwCCM=,DEBUVCYoBzklVRkrKxQAPg==,VEdYLhJsB089Gy0tFgIwCCM=,VEdYLhJsB1A9Gy0tFgIwCCM=,VEdYLhJsB1E9Gy0tFgIwCCM=,VEdYLhJsB1I9Gy0tFgIwCCM=,VEdYLhJsB1M9Gy0tFgIwCCM=,VEdYLhJsB1Q9Gy0tFgIwCCM=,VEdYLhJsB1U9Gy0tFgIwCCM=,VEdYLhJsB1Y9Gy0tFgIwCCM=,VEdYLhJsB1c9Gy0tFgIwCCM=,VEdYLhJsB1g9Gy0tFgIwCCM=,VEdYLhJsB1k9Gy0tFgIwCCM=,VEdYLhJsB1o9Gy0tFgIwCCM=,VEdYLhJsB2A9Gy0tFgIwCCM=,VEdYLhJsB2E9Gy0tFgIwCCM=,VEdYLhJsB2I9Gy0tFgIwCCM=,VEdYLhJsB2M9Gy0tFgIwCCM=,VEdYLhJsB2Q9Gy0tFgIwCCM=,VEdYLhJsB2U9Gy0tFgIwCCM=,VEdYLhJsB2Y9Gy0tFgIwCCM=,VEdYLhJsB2c9Gy0tFgIwCCM=,VEdYLhJsB2g9Gy0tFgIwCCM=,VEdYLhJsB2k9Gy0tFgIwCCM=,VEdYLhJsB2o9Gy0tFgIwCCM=,VEdYLhJsB2s9Gy0tFgIwCCM=,VEdYLhJsB2w9Gy0tFgIwCCM=,VEdYLhJsB209Gy0tFgIwCCM=,VEdYLhJsB249Gy0tFgIwCCM=,VEdYLhJsB289Gy0tFgIwCCM=,VEdYLhJsB3A9Gy0tFgIwCCM=,VEdYLhJsB3E9Gy0tFgIwCCM=,VEdYLhJsB3I9Gy0tFgIwCCM=,VEdYLhJsB3M9Gy0tFgIwCCM=,VEdYLhJsB3Q9Gy0tFgIwCCM=,VEdYLhJsB3U9Gy0tFgIwCCM=,VEdYLhJsB3Y9Gy0tFgIwCCM=,VEdYLhJsB3c9Gy0tFgIwCCM=,VEdYLhJsB3g9Gy0tFgIwCCM=,VEdYLhJsB3k9Gy0tFgIwCCM=,VEdYLhJsB3o9Gy0tFgIwCCM=,VEdYLhJsB3s9Gy0tFgIwCCM=,VEdYLhJsB3w9Gy0tFgIwCCM=,VEdYLhJsB309Gy0tFgIwCCM=,VEdYLhJsB349Gy0tFgIwCCM=,VEdYLhJsB389Gy0tFgIwCCM=,VFBKNx5FUiA9Gy0tFgIwCCM=,VFBKNx5FUiI9Gy0tFgIwCCM=,VFBKNx5FUiQ9Gy0tFgIwCCM=,VFBKNx5FUiY9Gy0tFgIwCCM=,VFBKNx5FUio9Gy0tFgIwCCM=,VFBKNx5FUiw9Gy0tFgIwCCM=,VFBKNx5FUi49Gy0tFgIwCCM=,VFBKNx5FUjA9Gy0tFgIwCCM=,VFBKNx5FUjI9Gy0tFgIwCCM=,VFBKNx5FUjQ9Gy0tFgIwCCM=,VFBKNx5FUjY9Gy0tFgIwCCM=,VFBKNx5FUjg9Gy0tFgIwCCM=,VFBKNx5FUjo9Gy0tFgIwCCM=,VFBKNx5FUjw9Gy0tFgIwCCM=,VFBKNx5FUj49Gy0tFgIwCCM=,VFBKNx5FUkA9Gy0tFgIwCCM=,VFBKNx5FUkI9Gy0tFgIwCCM=,VFBKNx5FUkQ9Gy0tFgIwCCM=,VFBKNx5FUkY9Gy0tFgIwCCM=,VFBKNx5FUkg9Gy0tFgIwCCM=,VFBKNx5FUko9Gy0tFgIwCCM=,VFBKNx5FUkw9Gy0tFgIwCCM=,DFdGTSoBUjklVRkrKxQAPg==,VFBKNx5FUlA9Gy0tFgIwCCM=,VFBKNx5FUlI9Gy0tFgIwCCM=,VFBKNx5FUlQ9Gy0tFgIwCCM=,VFBKNx5FUlY9Gy0tFgIwCCM=,VFBKNx5FUlg9Gy0tFgIwCCM=,VFBKNx5FUlo9Gy0tFgIwCCM=,VFBKNx5FUlw9Gy0tFgIwCCM=,VFBKNx5FUl49Gy0tFgIwCCM=,VFBKNx5FUmA9Gy0tFgIwCCM=,VFBKNx5FUmI9Gy0tFgIwCCM=,VFBKNx5FUmQ9Gy0tFgIwCCM=,VFBKNx5FUmY9Gy0tFgIwCCM=,VFBKNx5FUmg9Gy0tFgIwCCM=,VFBKNx5FUmo9Gy0tFgIwCCM=,VFBKNx5FUmw9Gy0tFgIwCCM=,VFBKNx5FUm49Gy0tFgIwCCM=,VFBKNx5FUnA9Gy0tFgIwCCM=,VFBKNx5FUnI9Gy0tFgIwCCM=,VFBKNx5FUnQ9Gy0tFgIwCCM=,VFBKNx5FUnY9Gy0tFgIwCCM=,VFBKNx5FUng9Gy0tFgIwCCM=,VFBKNx5FUno9Gy0tFgIwCCM=,VFBKNx5FUnw9Gy0tFgIwCCM=,VFBKNx5FUn49Gy0tFgIwCCM=,VFBKNx5FUCA9Gy0tFgIwCCM=,VFBKNx5FUCI9Gy0tFgIwCCM=,VFBKNx5FUCQ9Gy0tFgIwCCM=,VFBKNx5FUCY9Gy0tFgIwCCM=,VFBKNx5FUCg9Gy0tFgIwCCM=,VFBKNx5FUCo9Gy0tFgIwCCM=,VFBKNx5FUCw9Gy0tFgIwCCM=,VFBKNx5FUC49Gy0tFgIwCCM=,VFBKNx5FUDA9Gy0tFgIwCCM=,VFBKNx5FUDI9Gy0tFgIwCCM=,VFBKNx5FUDQ9Gy0tFgIwCCM=,VFBKNx5FUDY9Gy0tFgIwCCM=,VFBKNx5FUDg9Gy0tFgIwCCM=,VFBKNx5FUDo9Gy0tFgIwCCM=,VFBKNx5FUDw9Gy0tFgIwCCM=,VFBKNx5FUD49Gy0tFgIwCCM=,VFBKNx5FUEA9Gy0tFgIwCCM=,VFBKNx5FUEI9Gy0tFgIwCCM=,VFBKNx5FUEQ9Gy0tFgIwCCM=,VFBKNx5FUEY9Gy0tFgIwCCM=,VFBKNx5FUEg9Gy0tFgIwCCM=,VFBKNx5FUEo9Gy0tFgIwCCM=,VFBKNx5FUEw9Gy0tFgIwCCM=,DFdGTSoBUDklVRkrKxQAPg==,VFBKNx5FUFA9Gy0tFgIwCCM=,VFBKNx5FUFI9Gy0tFgIwCCM=,VFBKNx5FUFQ9Gy0tFgIwCCM=,VFBKNx5FUFY9Gy0tFgIwCCM=,VFBKNx5FUFg9Gy0tFgIwCCM=,VFBKNx5FUFo9Gy0tFgIwCCM=,VFBKNx5FUFw9Gy0tFgIwCCM=,VFBKNx5FUF49Gy0tFgIwCCM=,VFBKNx5FUGA9Gy0tFgIwCCM=,VFBKNx5FUGI9Gy0tFgIwCCM=,VFBKNx5FUGQ9Gy0tFgIwCCM=,VFBKNx5FUGY9Gy0tFgIwCCM=,VFBKNx5FUGg9Gy0tFgIwCCM=,VFBKNx5FUGo9Gy0tFgIwCCM=,VFBKNx5FUGw9Gy0tFgIwCCM=,VFBKNx5FUG49Gy0tFgIwCCM=,VFBKNx5FUHA9Gy0tFgIwCCM=,VFBKNx5FUHI9Gy0tFgIwCCM=,VFBKNx5FUHQ9Gy0tFgIwCCM=,VFBKNx5FUHY9Gy0tFgIwCCM=,VFBKNx5FUHg9Gy0tFgIwCCM=,VFBKNx5FUHo9Gy0tFgIwCCM=,VFBKNx5FUHw9Gy0tFgIwCCM=,VFBKNx5FUH49Gy0tFgIwCCM=,VFBKNx5FUSA9Gy0tFgIwCCM=,VFBKNx5FUSI9Gy0tFgIwCCM=,VFBKNx5FUSQ9Gy0tFgIwCCM=,VFBKNx5FUSY9Gy0tFgIwCCM=,VFBKNx5FUSg9Gy0tFgIwCCM=,VFBKNx5FUSo9Gy0tFgIwCCM=,VFBKNx5FUSw9Gy0tFgIwCCM=,VFBKNx5FUS49Gy0tFgIwCCM=,VFBKNx5FUTA9Gy0tFgIwCCM=,VFBKNx5FUTI9Gy0tFgIwCCM=,VFBKNx5FUTQ9Gy0tFgIwCCM=,VFBKNx5FUTY9Gy0tFgIwCCM=,VFBKNx5FUTg9Gy0tFgIwCCM=,VFBKNx5FUTo9Gy0tFgIwCCM=,VFBKNx5FUTw9Gy0tFgIwCCM=,VFBKNx5FUT49Gy0tFgIwCCM=,VFBKNx5FUUA9Gy0tFgIwCCM=,VFBKNx5FUUI9Gy0tFgIwCCM=,VFBKNx5FUUQ9Gy0tFgIwCCM=,VFBKNx5FUUY9Gy0tFgIwCCM=,VFBKNx5FUUg9Gy0tFgIwCCM=,VFBKNx5FUUo9Gy0tFgIwCCM=,VFBKNx5FUUw9Gy0tFgIwCCM=,DFdGTSoBUTklVRkrKxQAPg==,VFBKNx5FUVA9Gy0tFgIwCCM=,VFBKNx5FUVI9Gy0tFgIwCCM=,VFBKNx5FUVQ9Gy0tFgIwCCM=,VFBKNx5FUVY9Gy0tFgIwCCM=,VFBKNx5FUVg9Gy0tFgIwCCM=,VFBKNx5FUVo9Gy0tFgIwCCM=,VFBKNx5FUVw9Gy0tFgIwCCM=,VFBKNx5FUV49Gy0tFgIwCCM=,VFBKNx5FUWA9Gy0tFgIwCCM=,VFBKNx5FUWI9Gy0tFgIwCCM=,VFBKNx5FUWQ9Gy0tFgIwCCM=,VFBKNx5FUWY9Gy0tFgIwCCM=,VFBKNx5FUWg9Gy0tFgIwCCM=,VFBKNx5FUWo9Gy0tFgIwCCM=,VFBKNx5FUWw9Gy0tFgIwCCM=,VFBKNx5FUW49Gy0tFgIwCCM=,VFBKNx5FUXA9Gy0tFgIwCCM=,VFBKNx5FUXI9Gy0tFgIwCCM=,VFBKNx5FUXQ9Gy0tFgIwCCM=,VFBKNx5FUXY9Gy0tFgIwCCM=,VFBKNx5FUXg9Gy0tFgIwCCM=,VFBKNx5FUXo9Gy0tFgIwCCM=,VFBKNx5FUXw9Gy0tFgIwCCM=,VFBKNx5FUX49Gy0tFgIwCCM=,VFBKNx5FUyA9Gy0tFgIwCCM=,VFBKNx5FUyI9Gy0tFgIwCCM=,VFBKNx5FUyQ9Gy0tFgIwCCM=,VFBKNx5FUyY9Gy0tFgIwCCM=,VFBKNx5FUyg9Gy0tFgIwCCM=,VFBKNx5FUyo9Gy0tFgIwCCM=,VFBKNx5FUyw9Gy0tFgIwCCM=,VFBKNx5FUy49Gy0tFgIwCCM=,VFBKNx5FUzA9Gy0tFgIwCCM=,VFBKNx5FUzI9Gy0tFgIwCCM=,VFBKNx5FUzQ9Gy0tFgIwCCM=,VFBKNx5FUzY9Gy0tFgIwCCM=,VFBKNx5FUzg9Gy0tFgIwCCM=,VFBKNx5FUzo9Gy0tFgIwCCM=,VFBKNx5FUzw9Gy0tFgIwCCM=,VFBKNx5FUz49Gy0tFgIwCCM=,VFBKNx5FU0A9Gy0tFgIwCCM=,VFBKNx5FU0I9Gy0tFgIwCCM=,VFBKNx5FU0Q9Gy0tFgIwCCM=,VFBKNx5FU0Y9Gy0tFgIwCCM=,VFBKNx5FU0g9Gy0tFgIwCCM=,VFBKNx5FU0o9Gy0tFgIwCCM=,VFBKNx5FU0w9Gy0tFgIwCCM=,DFdGTSoBUzklVRkrKxQAPg==,VFBKNx5FU1A9Gy0tFgIwCCM=,VFBKNx5FU1I9Gy0tFgIwCCM=,VFBKNx5FU1Q9Gy0tFgIwCCM=,VFBKNx5FU1Y9Gy0tFgIwCCM=,VFBKNx5FU1g9Gy0tFgIwCCM=,VFBKNx5FU1o9Gy0tFgIwCCM=,VFBKNx5FU1w9Gy0tFgIwCCM=,VFBKNx5FU149Gy0tFgIwCCM=,VFBKNx5FU2A9Gy0tFgIwCCM=,VFBKNx5FU2I9Gy0tFgIwCCM=,VFBKNx5FU2Q9Gy0tFgIwCCM=,VFBKNx5FU2Y9Gy0tFgIwCCM=,VFBKNx5FU2g9Gy0tFgIwCCM=,VFBKNx5FU2o9Gy0tFgIwCCM=,VFBKNx5FU2w9Gy0tFgIwCCM=,VFBKNx5FU249Gy0tFgIwCCM=,VFBKNx5FU3A9Gy0tFgIwCCM=,VFBKNx5FU3I9Gy0tFgIwCCM=,VFBKNx5FU3Q9Gy0tFgIwCCM=,VFBKNx5FU3Y9Gy0tFgIwCCM=,VFBKNx5FU3g9Gy0tFgIwCCM=,VFBKNx5FU3o9Gy0tFgIwCCM=,VFBKNx5FU3w9Gy0tFgIwCCM=,VFBKNx5FU349Gy0tFgIwCCM=,VFBKNx5FVCA9Gy0tFgIwCCM=,VFBKNx5FVCI9Gy0tFgIwCCM=,VFBKNx5FVCQ9Gy0tFgIwCCM=,VFBKNx5FVCY9Gy0tFgIwCCM=,VFBKNx5FVCg9Gy0tFgIwCCM=,VFBKNx5FVCo9Gy0tFgIwCCM=,VFBKNx5FVCw9Gy0tFgIwCCM=,VFBKNx5FVC49Gy0tFgIwCCM=,VFBKNx5FVDA9Gy0tFgIwCCM=,VFBKNx5FVDI9Gy0tFgIwCCM=,VFBKNx5FVDQ9Gy0tFgIwCCM=,VFBKNx5FVDY9Gy0tFgIwCCM=,VFBKNx5FVDg9Gy0tFgIwCCM=,VFBKNx5FVDo9Gy0tFgIwCCM=,VFBKNx5FVDw9Gy0tFgIwCCM=,VFBKNx5FVD49Gy0tFgIwCCM=,VFBKNx5FVEA9Gy0tFgIwCCM=,VFBKNx5FVEI9Gy0tFgIwCCM=,VFBKNx5FVEQ9Gy0tFgIwCCM=,VFBKNx5FVEY9Gy0tFgIwCCM=,VFBKNx5FVEg9Gy0tFgIwCCM=,VFBKNx5FVEo9Gy0tFgIwCCM=,VFBKNx5FVEw9Gy0tFgIwCCM=,DFdGTSoBVDklVRkrKxQAPg==,VFBKNx5FVFA9Gy0tFgIwCCM=,VFBKNx5FVFI9Gy0tFgIwCCM=,VFBKNx5FVFQ9Gy0tFgIwCCM=,VFBKNx5FVFY9Gy0tFgIwCCM=,VFBKNx5FVFg9Gy0tFgIwCCM=,VFBKNx5FVFo9Gy0tFgIwCCM=,VFBKNx5FVFw9Gy0tFgIwCCM=,VFBKNx5FVF49Gy0tFgIwCCM=,VFBKNx5FVGA9Gy0tFgIwCCM=,VFBKNx5FVGI9Gy0tFgIwCCM=,VFBKNx5FVGQ9Gy0tFgIwCCM=,VFBKNx5FVGY9Gy0tFgIwCCM=,VFBKNx5FVGg9Gy0tFgIwCCM=,VFBKNx5FVGo9Gy0tFgIwCCM=,VFBKNx5FVGw9Gy0tFgIwCCM=,VFBKNx5FVG49Gy0tFgIwCCM=,VFBKNx5FVHA9Gy0tFgIwCCM=,VFBKNx5FVHI9Gy0tFgIwCCM=,VFBKNx5FVHQ9Gy0tFgIwCCM=,VFBKNx5FVHY9Gy0tFgIwCCM=,VFBKNx5FVHg9Gy0tFgIwCCM=,VFBKNx5FVHo9Gy0tFgIwCCM=,VFBKNx5FVHw9Gy0tFgIwCCM=,VFBKNx5FVH49Gy0tFgIwCCM=,VFBKNx5FVSA9Gy0tFgIwCCM=,VFBKNx5FVSI9Gy0tFgIwCCM=,VFBKNx5FVSQ9Gy0tFgIwCCM=,VFBKNx5FVSY9Gy0tFgIwCCM=,VFBKNx5FVSg9Gy0tFgIwCCM=,VFBKNx5FVSo9Gy0tFgIwCCM=,VFBKNx5FVSw9Gy0tFgIwCCM=,VFBKNx5FVS49Gy0tFgIwCCM=,VFBKNx5FVTA9Gy0tFgIwCCM=,VFBKNx5FVTI9Gy0tFgIwCCM=,VFBKNx5FVTQ9Gy0tFgIwCCM=,VFBKNx5FVTY9Gy0tFgIwCCM=,VFBKNx5FVTg9Gy0tFgIwCCM=,VFBKNx5FVTo9Gy0tFgIwCCM=,VFBKNx5FVTw9Gy0tFgIwCCM=,VFBKNx5FVT49Gy0tFgIwCCM=,VFBKNx5FVUA9Gy0tFgIwCCM=,VFBKNx5FVUI9Gy0tFgIwCCM=,VFBKNx5FVUQ9Gy0tFgIwCCM=,VFBKNx5FVUY9Gy0tFgIwCCM=,VFBKNx5FVUg9Gy0tFgIwCCM=,VFBKNx5FVUo9Gy0tFgIwCCM=,VFBKNx5FVUw9Gy0tFgIwCCM=,DFdGTSoBVTklVRkrKxQAPg==,VFBKNx5FVVA9Gy0tFgIwCCM=,VFBKNx5FVVI9Gy0tFgIwCCM=,VFBKNx5FVVQ9Gy0tFgIwCCM=,VFBKNx5FVVY9Gy0tFgIwCCM=,VFBKNx5FVVg9Gy0tFgIwCCM=,VFBKNx5FVVo9Gy0tFgIwCCM=,VFBKNx5FVVw9Gy0tFgIwCCM=,VFBKNx5FVV49Gy0tFgIwCCM=,VFBKNx5FVWA9Gy0tFgIwCCM=,VFBKNx5FVWI9Gy0tFgIwCCM=,VFBKNx5FVWQ9Gy0tFgIwCCM=,VFBKNx5FVWY9Gy0tFgIwCCM=,VFBKNx5FVWg9Gy0tFgIwCCM=,VFBKNx5FVWo9Gy0tFgIwCCM=,VFBKNx5FVWw9Gy0tFgIwCCM=,VFBKNx5FVW49Gy0tFgIwCCM=,VFBKNx5FVXA9Gy0tFgIwCCM=,VFBKNx5FVXI9Gy0tFgIwCCM=,VFBKNx5FVXQ9Gy0tFgIwCCM=,VFBKNx5FVXY9Gy0tFgIwCCM=,VFBKNx5FVXg9Gy0tFgIwCCM=,VFBKNx5FVXo9Gy0tFgIwCCM=,VFBKNx5FVXw9Gy0tFgIwCCM=,VFBKNx5FVX49Gy0tFgIwCCM=,VFBKNx5FAiA9Gy0tFgIwCCM=,VFBKNx5FAiI9Gy0tFgIwCCM=,VFBKNx5FAiQ9Gy0tFgIwCCM=,VFBKNx5FAiY9Gy0tFgIwCCM=,VFBKNx5FAig9Gy0tFgIwCCM=,VFBKNx5FAio9Gy0tFgIwCCM=,VFBKNx5FAiw9Gy0tFgIwCCM=,VFBKNx5FAi49Gy0tFgIwCCM=,VFBKNx5FAjA9Gy0tFgIwCCM=,VFBKNx5FAjI9Gy0tFgIwCCM=,VFBKNx5FAjQ9Gy0tFgIwCCM=,VFBKNx5FAjY9Gy0tFgIwCCM=,VFBKNx5FAjg9Gy0tFgIwCCM=,VFBKNx5FAjo9Gy0tFgIwCCM=,VFBKNx5FAjw9Gy0tFgIwCCM=,VFBKNx5FAj49Gy0tFgIwCCM=,VFBKNx5FAkA9Gy0tFgIwCCM=,VFBKNx5FAkI9Gy0tFgIwCCM=,VFBKNx5FAkQ9Gy0tFgIwCCM=,VFBKNx5FAkY9Gy0tFgIwCCM=,VFBKNx5FAkg9Gy0tFgIwCCM=,VFBKNx5FAko9Gy0tFgIwCCM=,VFBKNx5FAkw9Gy0tFgIwCCM=,DFdGTSoBAjklVRkrKxQAPg==,VFBKNx5FAlA9Gy0tFgIwCCM=,VFBKNx5FAlI9Gy0tFgIwCCM=,VFBKNx5FAlQ9Gy0tFgIwCCM=,VFBKNx5FAlY9Gy0tFgIwCCM=,VFBKNx5FAlg9Gy0tFgIwCCM=,VFBKNx5FAlo9Gy0tFgIwCCM=,VFBKNx5FAlw9Gy0tFgIwCCM=,VFBKNx5FAl49Gy0tFgIwCCM=,VFBKNx5FAmA9Gy0tFgIwCCM=,VFBKNx5FAmI9Gy0tFgIwCCM=,VFBKNx5FAmQ9Gy0tFgIwCCM=,VFBKNx5FAmY9Gy0tFgIwCCM=,VFBKNx5FAmg9Gy0tFgIwCCM=,VFBKNx5FAmo9Gy0tFgIwCCM=,VFBKNx5FAmw9Gy0tFgIwCCM=,VFBKNx5FAm49Gy0tFgIwCCM=,VFBKNx5FAnA9Gy0tFgIwCCM=,VFBKNx5FAnI9Gy0tFgIwCCM=,VFBKNx5FAnQ9Gy0tFgIwCCM=,VFBKNx5FAnY9Gy0tFgIwCCM=,VFBKNx5FAng9Gy0tFgIwCCM=,VFBKNx5FAno9Gy0tFgIwCCM=,VFBKNx5FAnw9Gy0tFgIwCCM=,VFBKNx5FAn49Gy0tFgIwCCM=,VFBKNx5FAyA9Gy0tFgIwCCM=,VFBKNx5FAyI9Gy0tFgIwCCM=,VFBKNx5FAyQ9Gy0tFgIwCCM=,VFBKNx5FAyY9Gy0tFgIwCCM=,VFBKNx5FAyg9Gy0tFgIwCCM=,VFBKNx5FAyo9Gy0tFgIwCCM=,VFBKNx5FAyw9Gy0tFgIwCCM=,VFBKNx5FAy49Gy0tFgIwCCM=,VFBKNx5FAzA9Gy0tFgIwCCM=,VFBKNx5FAzI9Gy0tFgIwCCM=,VFBKNx5FAzQ9Gy0tFgIwCCM=,VFBKNx5FAzY9Gy0tFgIwCCM=,VFBKNx5FAzg9Gy0tFgIwCCM=,VFBKNx5FAzo9Gy0tFgIwCCM=,VFBKNx5FAzw9Gy0tFgIwCCM=,VFBKNx5FAz49Gy0tFgIwCCM=,VFBKNx5FA0A9Gy0tFgIwCCM=,VFBKNx5FA0I9Gy0tFgIwCCM=,VFBKNx5FA0Q9Gy0tFgIwCCM=,VFBKNx5FA0Y9Gy0tFgIwCCM=,VFBKNx5FA0g9Gy0tFgIwCCM=,VFBKNx5FA0o9Gy0tFgIwCCM=,VFBKNx5FA0w9Gy0tFgIwCCM=,DFdGTSoBAzklVRkrKxQAPg==,VFBKNx5FA1A9Gy0tFgIwCCM=,VFBKNx5FA1I9Gy0tFgIwCCM=,VFBKNx5FA1Q9Gy0tFgIwCCM=,VFBKNx5FA1Y9Gy0tFgIwCCM=,VFBKNx5FA1g9Gy0tFgIwCCM=,VFBKNx5FA1o9Gy0tFgIwCCM=,VFBKNx5FA1w9Gy0tFgIwCCM=,VFBKNx5FA149Gy0tFgIwCCM=,VFBKNx5FA2A9Gy0tFgIwCCM=,VFBKNx5FA2I9Gy0tFgIwCCM=,VFBKNx5FA2Q9Gy0tFgIwCCM=,VFBKNx5FA2Y9Gy0tFgIwCCM=,VFBKNx5FA2g9Gy0tFgIwCCM=,VFBKNx5FA2o9Gy0tFgIwCCM=,VFBKNx5FA2w9Gy0tFgIwCCM=,VFBKNx5FA249Gy0tFgIwCCM=,VFBKNx5FA3A9Gy0tFgIwCCM=,VFBKNx5FA3I9Gy0tFgIwCCM=,VFBKNx5FA3Q9Gy0tFgIwCCM=,VFBKNx5FA3Y9Gy0tFgIwCCM=,VFBKNx5FA3g9Gy0tFgIwCCM=,VFBKNx5FA3o9Gy0tFgIwCCM=,VFBKNx5FA3w9Gy0tFgIwCCM=,VFBKNx5FA349Gy0tFgIwCCM=,5/OIzWszIhVQVyFRHSc=,f/OIzWszIhVQVyFRHSc=,fFkud8EzIhVQVyFRHSc=,XVgvG1xEIVIURS8QBDIKLQVf,fVgvG1xEIVIURS8QBDIKLQVf,fXgPO3xkAXI0RS8QBDIKLQVf,z+9ShSbghbevRS8QBDIKLQVf,Z+9SH8bghbevRS8QBDIKLQVf,WSVUERAhLQs3AT8HRRg/DykOExRTNys=,LwQGIg45JEUXWAsUHQIcRTsqGn4LUFZdJhFUWw==,BiAOPwNFMEcPJggoGVQ8LxsDD1dbMyIVUFchUR0n,Bh0kBF4aUCg5DBoUajgiGBgFRVBcLX1SUSdTHykpGg==,IhU5CSIOUjBHDyYIKAFAPTMfHQQ4VFsgE1ZVI18=,MWcpZRwkCx4dUBYxFRkPbV1YLxtcRCFSFEUvEAQyCi0FXw==,PBs9ZwRaCCIBEjdHMS4RKxpHWEkoHl05JVUZKysUAD4=,JCFqADEbEgNeUH8xFl5WFEUfIicHCgkHKg5bGUILLgN9EFczJxESDVo=,GD0oIUc/JR0YD3RHWC4SY0EhWhM6Iy0XIwI7CV4YPw8pDhMUUzcr,KhRWAlQcDR8WHFAPKRUXAV1ZWC0DVkEqPRstLRYCMAgj,VgBUGiofMQNUPSYrHgtRXmYsKF9SKkMfPSB4BjQMLwdREV0=,KRsRMAg5HD8lWBpRKDkMGhQ/MSEXEA9UUlE=,BEdsLFYWIyEFAjMBQQNVFVELLQof,SjcoQ0YpRxEmIHgGNAwvB1ERXQ==,1eg1fgtQVl0mEVRb,1eg0fgtQVl0mEVRb,1eg3fgtQVl0mEVRb,1eg2fgtQVl0mEVRb,1eg5fgtQVl0mEVRb,1eg4fgtQVl0mEVRb,VgwuOhMVEB0qD1IpRhp6XX0QVzMnERINWg==,VgwuOhMVEB0qD1IpRhp6XH0QVzMnERINWg==,VEdYLhJsBnI9Gy0tFgIwCCM=,VEdYLhJsBm89Gy0tFgIwCCM=";


const UNLOCKED_STYLES_VALUE =
    "festival,xmas_ts,neon,glow,animatedUnderwaterViolet,flame,valentine,christmas,halloween,summer,default,pink,dragon,bubble,bevel,pumpkin,train,easter,sprinkle,tropic,rainy,diamond,garland,atom,st790,st780,st770,st760,st750,st740,st730,st720,st710,st700,st341,st281,st201,cooking,st200,Gold,BS,BASMALA";


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
const APP_DECOR_IDS = ["1400_Christmas_Decoration", "5years", "Apple_Garden", "AquariumAtlantic_ancient", "Arabic_Tent", "Atlantis_fence", "Basil_Cath", "Beach_volleyball", "BobsleighRace", "Book_Store", "Bungalow_hammock", "CafeTube", "Cafe_Vineyard", "Cafe_Waterfall", "Carousel_Octopus", "Cars_Exposition", "Castle_Trampoline", "Cave_Place", "ChineseBanner", "ChineseDog", "ChineseNYTree", "ChineseNY_pigStatue", "Chinese_fence", "ChocolateFactoryDecor", "ChristmasBall", "ChristmasBanner", "ChristmasCarousel", "ChristmasTrain_Bridge", "Christmas_Cafe", "Christmas_Chorus", "Christmas_Fair", "Christmas_GingerbreadMan", "Christmas_Ice_skating", "Christmas_Santa_House", "Christmas_Santas_Reinde", "Christmas_Snow_fortress", "Christmas_Snowman", "Christmas_Urban_tree", "Christmas_angel", "Christmas_fence", "Christmas_gifts", "Christmas_lantern", "Christmas_presentsock", "Christmas_scene", "Christmas_train", "Circus_Camping", "Color_Egg", "Connect_Station", "Cover_Gift", "CowArtist", "Cowboy_Tower", "Crab_Cook", "CraneFountain", "Cycle_Parking", "Decor_FlowerShop", "Decor_Ropepark", "Decor_TreeHouse", "Dino_Safe", "DiscoDecorationSP8", "DroneRace_plane", "Easter2017Decor", "EasterStump", "EasterVineyard", "Easter_bunnies", "Easter_fence", "Easter_fountain", "EgyptPapyrusBoat", "EgyptPharaohStatue", "EgyptPyramid", "ExpeditionDecoration", "ExpeditionDecoration10", "ExpeditionDecoration11", "ExpeditionDecoration12", "ExpeditionDecoration13", "ExpeditionDecoration14", "ExpeditionDecoration15", "ExpeditionDecoration16", "ExpeditionDecoration17", "ExpeditionDecoration18", "ExpeditionDecoration19", "ExpeditionDecoration2", "ExpeditionDecoration20", "ExpeditionDecoration21", "ExpeditionDecoration22", "ExpeditionDecoration25", "ExpeditionDecoration3", "ExpeditionDecoration34", "ExpeditionDecoration37", "ExpeditionDecoration38", "ExpeditionDecoration39", "ExpeditionDecoration4", "ExpeditionDecoration40", "ExpeditionDecoration41", "ExpeditionDecoration5", "ExpeditionDecoration6", "ExpeditionDecoration7", "ExpeditionDecoration8", "ExpeditionDecoration9", "Fairy_Fountain", "Fashion_Boutique", "FinalReward_gardenCinema", "Flower_Statue", "Flower_Store", "GhostGarden", "Giant_Snowman", "Ginger_House", "GingerbreadManHotChocolate", "Glamping_Camp", "Glamping_House", "GlassBridge", "Gold_Diggers", "Gothic_Tower", "Grape_Press", "Greenhouse_Predator", "Hall_Fame", "Halloween2017Decor", "Halloween_Organ", "Halloween_Park", "Happy_Aquarium", "Headless_Horseman", "HelixJump_TreasureIsland", "Helix_Pazzles", "Horn_Harvest", "Horse_Carousel", "HotDogSwing", "Hot_Fountain", "HouseEgyptian", "House_Garden", "IceExhibition_runner", "Installation_Insomnia", "InstrumentWorkshop", "JazzClub", "JurassicPark", "KidsRailway", "KingdomCentre", "LandscapesIcon", "LiraFountain", "LoveLock", "LoveTunnel", "Marsh_treasure", "Mechanic_Car", "MegaCake", "Merge2Decoration1", "Merge2Decoration10", "Merge2Decoration11", "Merge2Decoration12", "Merge2Decoration2", "Merge2Decoration3", "Merge2Decoration4", "Merge2Decoration5", "Merge2Decoration6", "Merge2Decoration7", "Merge2Decoration8", "Merge2Decoration9", "MiniTownship", "Mobile_Market", "MountainChalet_CozyHouse", "MountainChalet_HuskyHouse", "MusicCarousele", "Music_Scene", "NewCinema_gatsby", "New_Year", "NewyearGlobe", "Notre_Dame", "Olympic_Baseballtraining", "Olympic_Snowmachine", "Organic_Shop", "Palace_of_the_sky", "PaletteSculpture", "Paris_Street", "PencilHouse_art", "PigOscar", "PinSculpture", "PirateFort", "Plank_Decor", "Plank_Jeep", "Plank_Shop", "Plank_Werewolf", "Pumpkin_House", "Pumpkin_Metro", "RainbowArch", "RestoratorBuild2", "Rialto_Bridge", "SailingRaft_treasure", "SaleSquare", "Saloon_GrayMouse", "SantaSleigh", "Santa_Reception", "SculptureExhibition_art", "SeaFence_fence", "SheepElf_runner", "SheepSlide", "ShipTower", "Ship_Fight", "Ski_Shop", "SmallWaterfall", "Snowman", "SpaceRocket", "SpecialBeauty_AlbatrossOnBoat", "SpecialBeauty_Aquarium", "SpecialBeauty_AquaticJetpack", "SpecialBeauty_AstrologerTower", "SpecialBeauty_AvtoAttraction", "SpecialBeauty_Banner", "SpecialBeauty_BathyscaphDive", "SpecialBeauty_BeePilot", "SpecialBeauty_BirthdayBanner", "SpecialBeauty_BoatWithPirateFlag", "SpecialBeauty_BonfireCamp", "SpecialBeauty_CaptainStatueSeason", "SpecialBeauty_China_dragon", "SpecialBeauty_China_fish", "SpecialBeauty_China_house", "SpecialBeauty_China_lantern", "SpecialBeauty_China_lightTree", "SpecialBeauty_China_maneki", "SpecialBeauty_China_monkey", "SpecialBeauty_CityDay_arch_of_flowers", "SpecialBeauty_CityDay_boat_of_flowers", "SpecialBeauty_CityDay_flowerbed_car", "SpecialBeauty_CityDay_pavlin", "SpecialBeauty_CityDay_sheeps", "SpecialBeauty_CommonwealthStatue", "SpecialBeauty_Digging_Tyrannosaurus", "SpecialBeauty_Dovecote", "SpecialBeauty_EasterRabbit", "SpecialBeauty_EasterSymbol", "SpecialBeauty_EasterTopiary", "SpecialBeauty_Easter_ChocolateFoun", "SpecialBeauty_Easter_EasterBunny", "SpecialBeauty_Easter_EasterChicken", "SpecialBeauty_Easter_EasterTree", "SpecialBeauty_Easter_FabergeEgg", "SpecialBeauty_Easter_FabergeEgg_blue", "SpecialBeauty_Easter_RabbitHouse", "SpecialBeauty_Easter_SpringGirl", "SpecialBeauty_Excalibur", "SpecialBeauty_FrogStatue", "SpecialBeauty_FruitBridge", "SpecialBeauty_FruitKiosk", "SpecialBeauty_Ghostbuster", "SpecialBeauty_GiantWatermelon", "SpecialBeauty_HelicopterTrampoline", "SpecialBeauty_HorrorHorses", "SpecialBeauty_InflatableCastle", "SpecialBeauty_KidKite", "SpecialBeauty_KingsThrone", "SpecialBeauty_LanternGhost", "SpecialBeauty_MechanicalRodeo", "SpecialBeauty_MedievilCarrige", "SpecialBeauty_MedievilTaverna", "SpecialBeauty_OctopusChest", "SpecialBeauty_PirateTavern", "SpecialBeauty_PumpkinWheel", "SpecialBeauty_RomanticDinner", "SpecialBeauty_RuinsDive", "SpecialBeauty_RunwayAirplane", "SpecialBeauty_SeaCarousel", "SpecialBeauty_ShipGun", "SpecialBeauty_SpiderTree", "SpecialBeauty_StatueFisherman", "SpecialBeauty_StatueOfTheCook", "SpecialBeauty_StatueWorkTogether", "SpecialBeauty_Sun", "SpecialBeauty_SwingPlane", "SpecialBeauty_ThreeHouses", "SpecialBeauty_Totem", "SpecialBeauty_TreeBroccoli", "SpecialBeauty_TruckCamping", "SpecialBeauty_Valentine_flowercart", "SpecialBeauty_WaterMill", "SpecialBeauty_WaterTower", "SpecialBeauty_ancor", "SpecialBeauty_animal_tower", "SpecialBeauty_bioplan", "SpecialBeauty_birthday_ballon", "SpecialBeauty_chef_balloon", "SpecialBeauty_china_dragon2017", "SpecialBeauty_cockleshell", "SpecialBeauty_firerooster", "SpecialBeauty_fishermans_house", "SpecialBeauty_flooded_tower", "SpecialBeauty_flyButterfly", "SpecialBeauty_flyChicken", "SpecialBeauty_flyCow", "SpecialBeauty_flyDuck", "SpecialBeauty_flyElep", "SpecialBeauty_flyOctopus", "SpecialBeauty_flyParrot", "SpecialBeauty_flyPenguin", "SpecialBeauty_flyPig", "SpecialBeauty_flyPlane", "SpecialBeauty_flySheep", "SpecialBeauty_flyTurtle", "SpecialBeauty_flyWhale", "SpecialBeauty_fountain_restourante", "SpecialBeauty_galorobot", "SpecialBeauty_harvest_figure", "SpecialBeauty_ice_cream_cafe", "SpecialBeauty_jumping_fish", "SpecialBeauty_mermaid", "SpecialBeauty_mobile_coffee_truck", "SpecialBeauty_octopus", "SpecialBeauty_paukohod", "SpecialBeauty_perpetumlucerna", "SpecialBeauty_planeAmphibian", "SpecialBeauty_plungerDive", "SpecialBeauty_redBridge", "SpecialBeauty_seahorse", "SpecialBeauty_statue_pig", "SpecialBeauty_topiary_egg", "SpecialBeauty_walking_castle", "SpecialBeauty_wealth_bowl", "SpecialBeauty_whalefountain_fishing", "Summer_Cafe", "Surf_Decor", "Surf_Pool", "Surf_Rental", "Surf_Sale", "Surfingers_Trampoline", "Sweet_Tree", "Tiki_Bar", "TouristParking_treasure", "Tower_of_Pisa", "Town_Fair", "TrainConductor", "Tree_Market", "Tree_sakura", "Trio", "Trucks_Decotor", "Trucks_PirateBistro", "Valentine_Bunny", "Valentine_CupidsArrow", "Valentine_Flowerbed", "Valentine_Gazebo_lovers", "Valentine_Pond_with_swans", "Valentine_Statue_Lovers", "Valentine_Statue_of_cupid", "Valentine_Swing_lovers", "Valentine_Teddy_bear", "Valentine_Teddy_bear2", "Valentine_Topiary", "Valentine_cats", "Valentine_diamond_heart", "Valentine_fountain_eternallove", "Valentine_heartInHands", "Valentine_heart_pedestal", "Valentine_justMarried", "Valentine_key", "Valentine_lovearch", "Valentine_lovers_bench", "Valentine_lovers_cart", "Valentine_moon_from_heaven", "Valentine_peacock_inlove", "Valentine_pigeons_love", "Valentine_plush_cat", "Valentine_postsheep", "Valentine_serenade", "Valentine_statue_prince", "Valentine_topiary_hearts", "Wagon_Mountain", "Watchtower", "WaterBungalowSP9", "Wedding3D_Decor", "WitchPot", "WitchStatue_halloween", "airboat_plank", "airship_base", "ancient_bridge", "apple_tree", "aquapark_helix", "aquariumHouse_fishing", "aquarium_v1", "arabic_al_ain_palace", "arabic_horse_statue", "arabic_jin_lamp", "arabic_oasis", "arbor", "archaeology_atlantis", "archery_runner", "asphalt", "bagrunning_easter", "ballShooting_helix", "baloon_castle", "baloons", "bamboo_runner", "baobab", "bar_fin", "baseball", "basketball_1x2", "beach_dance_floor", "beach_fruit_mix", "beach_party_bar", "beach_yellow_submarine", "bears_family", "beauty_3_ballon", "beauty_5y_monument", "beauty_Coconut_bar", "beauty_DivingTower_olympiad", "beauty_Flower_gates", "beauty_FootballDog", "beauty_Goalkeeper", "beauty_Gong", "beauty_Luxury_gates", "beauty_MovieFountain", "beauty_OlympicFountain", "beauty_SketebordPlace", "beauty_SuperheroStand", "beauty_TrainingGround_olympiad", "beauty_acacia_giraffe", "beauty_acrobats_stilts", "beauty_ancient_drums", "beauty_ancient_town", "beauty_animals_pasta", "beauty_araguaney", "beauty_arch_balloon", "beauty_artist_quarter", "beauty_astronomer_tower", "beauty_atlantis_aquarium", "beauty_atlantis_boulevard", "beauty_atlantis_hotel", "beauty_atlantis_ruins", "beauty_atlantis_statue", "beauty_atlas_hand", "beauty_balloon_dancer", "beauty_baloon_flowers", "beauty_burdzh_halifa", "beauty_cancer_hermit", "beauty_candy_bridge", "beauty_candy_carousel", "beauty_candy_house", "beauty_candy_tree", "beauty_carousel", "beauty_cave_in_jungle", "beauty_chalk_elephant", "beauty_chalk_jiraffe", "beauty_chalk_lion", "beauty_chalk_zebra", "beauty_children_pirates", "beauty_china_town", "beauty_coloring_cubes", "beauty_confectioner_cow", "beauty_coral_garden", "beauty_cottage_horn", "beauty_delonix", "beauty_diamond", "beauty_dinosaur", "beauty_divers_boat", "beauty_dog_ballon", "beauty_dogs_arctic", "beauty_dolphins", "beauty_dragon_boat", "beauty_dragon_dance", "beauty_easter_lantern", "beauty_easter_stump", "beauty_elephants", "beauty_elf_house", "beauty_experiment_knowledgetower", "beauty_experiment_laboratory", "beauty_experiment_monument", "beauty_experiment_plasma", "beauty_experiment_projector", "beauty_finic_palm", "beauty_fireworkshop", "beauty_fish_ballon", "beauty_fish_market", "beauty_floral_sheeps", "beauty_flower_vase", "beauty_flowerhouse", "beauty_flyHouse", "beauty_flyMedusa", "beauty_flyingship", "beauty_friendBench_fday", "beauty_ghost_ship", "beauty_goldberg_machine", "beauty_gondola", "beauty_graffiti_competition", "beauty_greengrocery", "beauty_halloween_scary_crypt", "beauty_halloween_skeleton_orchestra", "beauty_houseMaldives", "beauty_iceDeer", "beauty_ice_castle", "beauty_iceberg", "beauty_iceberg_penguin", "beauty_icebreaker", "beauty_jirafe_dall", "beauty_juggler", "beauty_jungle_monk", "beauty_jungle_riverhouse", "beauty_jungle_ruins", "beauty_jungle_sanctuary", "beauty_jungle_totems", "beauty_lake_house", "beauty_large_sundial", "beauty_luxury_house", "beauty_mammoth", "beauty_party_pirates", "beauty_peacock_statue", "beauty_pine_tree", "beauty_pirate_ship_bow", "beauty_pizzeria_pasta", "beauty_plane_steam", "beauty_plane_vought_v173", "beauty_playground2", "beauty_plushSheep", "beauty_polarStation", "beauty_polar_bear", "beauty_poseidon", "beauty_prehistoric_house", "beauty_primitive_artist", "beauty_puddleJumper", "beauty_pyramid_knife", "beauty_rhino", "beauty_rhododendron", "beauty_runner_cablecar", "beauty_sailboat", "beauty_saloon", "beauty_santa_plank", "beauty_sea_researchers", "beauty_seahouse_decoration", "beauty_sequoia", "beauty_serf_pool", "beauty_shipUlysses_ancient", "beauty_ship_pool", "beauty_simulator_plane", "beauty_skatingPenguins", "beauty_snowfortress", "beauty_snowman_skater", "beauty_snowslide", "beauty_solar_system", "beauty_souvenir_shop", "beauty_space_cosmonaut_cow", "beauty_space_mars_rover", "beauty_space_shuttle", "beauty_stonehenge", "beauty_submarine", "beauty_sweet_hill", "beauty_swing_giraffe", "beauty_swing_palm", "beauty_tarzan_tree", "beauty_thai_temple", "beauty_throwing_knives", "beauty_titans", "beauty_torchbearer_olympiad", "beauty_treasure_chest", "beauty_tree_ballon", "beauty_triathlon_runner", "beauty_ufo", "beauty_venus_flytrap", "beauty_waterSlide", "beauty_water_monster", "beauty_watercraft", "beauty_winners_place_olympiad", "beauty_winter_cannon", "beauty_wisteria", "beauty_yeti", "berryTree_knife", "bigPicnic", "bigTractor_rescue", "big_ban", "birthdaynineDecoration", "blender_knife", "boat00_fin", "boat02_fin", "bookTree_jungle", "bridge00_fin", "bridge01_fin", "bronze_bull", "buek1", "buek2", "buek3", "buek4", "buek5", "buek6", "buek7", "buek8", "bullStatue_runner", "cactus", "cafe_rescue", "camping", "camping_wildwest", "candyCastle_helix", "candyTrain_surfingers", "candy_fence", "candy_gate", "candy_rainbow", "captainStatue_pirate", "caramelApple_surfingers", "carousel_elephants", "carousel_helix", "carousel_runner", "cartRace_blackfriday", "castle", "chamber_halloween", "champion_cup", "chess_arabic", "chickchik", "christmasComing", "christmasPlace_xmas2022", "christmasTree_xmas2022", "christmas_santa_helper", "christmas_snowball", "coconutArmchair_bungalow", "colorFountain_match3", "contactZoo_rescue", "cowboyStatue_wildwest", "craftsmanWorking_egypt", "crater", "crocodile", "curling_runner", "dalesIcon", "danceMachine_helix", "dancingFountains", "darkForestWithTrainSign", "deerRiding_plank", "dirigeablestatue", "discoForever_music", "discusThrower_ancient", "dragon_statue_SP_800", "dynamometer_rescue", "easterHammock", "easterRailroad", "easterRibbons", "easter_factory", "easter_pond", "easterhouse_tree", "easternBazar", "eifel_tower", "empire_state_v1", "expandBuyAvailable", "fair_rescue", "fairy_water", "falcon_hunting", "farmmusic", "figureSkating_xmas2022", "filmmaking_treasure", "flag", "flamingo", "floating_lanterns", "flowerUnderHood", "flower_fence", "flower_hedge", "flower_house", "flower_swing", "flowerbed1", "flowerbed2", "flowerbed_daffodils", "flowerbed_gerbera", "flowerbed_gladiolus", "flowerbed_irises", "flowerbed_poppies", "flowering_tree", "flyBee", "flyDragon", "flyLantern_santa", "flyPanda", "flyValentineBalloons", "flyValentineCupid", "flyingShip_treasure", "foodshow_burger", "football", "fountain1", "fountain2", "fountain4", "fountain_swan", "fountain_tree", "fountain_whale", "fountainbig", "freedom_v1", "fruitFootball_knife", "fruitPark_knife", "fruitSlicing_knife", "gallery_art", "gameboy_helix", "gardens_arabic", "ghostlyCarriage", "giantVegetables_rescue", "girrafe", "globalFlight_plane", "gnomes", "golden_gate", "gorilla", "granite_fence", "gravelroad", "green", "green10", "green12", "green14", "green16", "green18", "green2", "green20", "green5", "green5_2", "green8", "green9", "green_bird", "green_bunny", "green_dolphin", "green_elephant", "green_peacock", "green_tree1", "green_tree2", "green_tree3", "green_turtle", "greenbox_fin", "ground", "groundroad", "halloween_castle", "halloween_cat", "halloween_fountain", "halloween_gargoyle", "halloween_ghost_ship", "halloween_haunted_house", "halloween_museum", "halloween_pump", "halloween_sarcophagus", "halloween_scarecrow", "halloween_tree", "halloween_witch", "halloween_witch_hire", "hay", "heartTree_valentine", "hedge", "helmetOctopus_ancient", "hockeyField_runner", "hotSpring_match3", "iceArch_arctic", "iceDragon", "iceLake", "iceSculptures_plank", "ice_dino", "iglu", "installation_art", "island_knife", "jakaranda", "jellyBounce", "jetpack_plane", "juice_fountain", "katamaran", "kitchen_plank", "koala", "labyrinth_easter", "lakehouse_boattrip", "lakehouse_home", "landing_fence", "lastHour_plank", "lifeguard_hut", "lion", "lion_slides", "lookout_point", "loveTower", "loveWings", "love_bridge", "love_flowers", "lovegarden", "lowriders_rescue", "luxury_fence", "mammoth_match3", "maya_calendar", "mechDragon_medieval", "mechStrawman", "minotaur_ancient", "monkeys_plank", "monument1", "monument2", "monument3", "monument4", "monument5", "monument_tools", "movieMonument", "movieMuseum", "museum_atlantis", "musicQuarter_music", "ninja_knife", "noodle_shop", "oasis_egypt", "oilDerrick", "olympicVillage_runner", "organ_music", "palmHotel", "palma1", "palma2", "palma4", "palma_totem", "panda", "park1_1x1", "park1_1x2", "park2_1x1", "parking_common", "parking_green_side", "parking_green_yard", "penguin", "penguinIcehole_xmas2022", "petronas", "phone_box", "photoStand_valentine", "picnic", "pinball_helix", "pineapple_knife", "pirateShip_treasure", "pirateStatue_treasure", "pizzacutting_pasta", "planeAircraftReward", "plank1_fin", "plank3_fin", "playground", "plushUnicorn_valentine", "polarman_arctic", "pond", "pondSwans", "pond_mother_earth", "pond_with_carp", "pool", "pumpkinrace", "pyramide", "quay_fin", "quiosk_plank", "radar", "radiorace_rescue", "railway_station", "rainbowFair_helix", "ratGarden_jump", "redLiliesPond", "reef_hedge", "reserve1x2_v1", "reserve2x2_v1", "reserve3x3_v1", "retro_avto", "ringGame_surfingers", "roadsIcon", "robocafe_cakeshop", "rockCat_music", "rodeoHelic_runner", "roman_chariot", "rose_bush", "rugby_stadium", "sailHotel", "sailing_race", "sand", "sausage_restorator", "scarab_egypt", "scarecrow", "scriptorium_medieval", "sculptor_ancient", "seaStation_dive", "sea_gate", "seal", "seasonCinecamera_cinema", "seasonUfoStudio_cinema", "shack", "shark_slide", "shearedTree", "shellgame_helix", "ship", "shipAttraction_pirate", "shooting_rescue", "skin_city_sign_IronCitySign", "skin_city_sign_MillSign", "skin_city_sign_SP_790_sign", "skin_city_sign_TV_city_sign", "skin_city_sign_arabic_sign", "skin_city_sign_asian_sign", "skin_city_sign_birthday_10years", "skin_city_sign_birthday_sign", "skin_city_sign_cactus_sign", "skin_city_sign_christmas_sign", "skin_city_sign_cinema_sign", "skin_city_sign_cow_sign", "skin_city_sign_def_sign", "skin_city_sign_disco_city_sign", "skin_city_sign_dry_fountain_sign", "skin_city_sign_easter_sign", "skin_city_sign_expedition22_2200_sign", "skin_city_sign_expedition23_2200_sign", "skin_city_sign_expedition24_2300_sign", "skin_city_sign_expedition25_2300_sign", "skin_city_sign_expedition26_2400_sign", "skin_city_sign_expedition27_2400_sign", "skin_city_sign_expedition28_2500_sign", "skin_city_sign_expedition29_2500_sign", "skin_city_sign_expedition30_2600_sign", "skin_city_sign_expedition31_2600_sign", "skin_city_sign_expedition32_2700_sign", "skin_city_sign_expedition33_2700_sign", "skin_city_sign_expedition36_2900_sign", "skin_city_sign_farm_sign", "skin_city_sign_flowerbed_sign", "skin_city_sign_frank_halloween", "skin_city_sign_furniture_sign", "skin_city_sign_halloween_sign", "skin_city_sign_harvest_sign", "skin_city_sign_ilove_sign", "skin_city_sign_lamp_board_sign", "skin_city_sign_mechanic_sign", "skin_city_sign_music_sign", "skin_city_sign_mystical_events", "skin_city_sign_neon_sign", "skin_city_sign_palm_trees", "skin_city_sign_regatta_2100_sign", "skin_city_sign_regatta_2300_sign", "skin_city_sign_regatta_2400_sign", "skin_city_sign_regatta_3000_sign", "skin_city_sign_regatta_3100_sign", "skin_city_sign_rock_sign", "skin_city_sign_ruminant_machine", "skin_city_sign_smoothiebar_sign", "skin_city_sign_snowboard_sign", "skin_city_sign_stone_sign", "skin_city_sign_vegas_sign", "skin_city_sign_wild_west_sign", "skin_city_sign_winged_sign", "skin_city_sign_wooden_sign", "skisCow_olympiad", "slide_match3", "small_green_tree_04", "snow", "snowFight_plank", "snowboardSheep_olympiad", "snowboard_runner", "southernflowers", "spacegarden", "spaceneedle_v1", "sphinx_v1", "stairs_match3", "statue_artist", "statue_boat_gold", "statue_chemist", "statue_fireman", "statue_flyboy", "statue_footballer", "statue_general", "statue_geneticist", "statue_musican", "statue_neanderthal", "statue_policeman", "statue_thinker", "statue_tourist", "statue_writer", "stork_statue", "stream_hedge", "streetCinema_cakeshop", "sunflower", "swan", "sydney_opera", "tajmahal_v1", "teahouse", "tennis", "thanksgiving_CarrotTree", "thanksgiving_vegetableBasket", "thanksgiving_vegetableHouse", "thanksgiving_vegetablePlace", "theaterOdeon_ancient", "throneHall_medieval", "tiger", "topiary_castle", "topiary_competition", "toyMachine_helix", "track", "tractor_and_hay", "trainchicken", "travelingTruck_rescue", "tree_adenium", "tree_shaping", "tree_with_stairs", "trojanHorse_ancient", "trouveres_medieval", "turbosledge_santa", "ufoClue", "upsideDownHouse_bungalow", "vegetables", "vetryak", "village_jungle", "water", "water_flowers_1", "water_flowers_2", "waterfall_mountain_surfingers", "wateringCan_easter", "weeping_willow", "weightlifter_runner", "well", "white_fence", "whiterose_tree", "wildpark", "wildwest_cinema", "windmill", "winterYurt_xmas2022", "wishingWell", "workshopCrash", "yacht", "yacht_fin", "yellow_roses", "young_gardeners", "zebra", "zoo_caffe", "zoo_cinema", "zoo_cocktail_store", "zoo_contact", "zoo_decor", "zoo_eatery", "zoo_icecream_shop", "zoo_restaurant", "zoo_shop"];

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
    const selected = value && value.all ? new Set([...APP_SKINS_XML.matchAll(/\bavailable="([^"]*)"/gi)].flatMap(m => m[1].split(/[|,]/))).size ? new Set([...APP_SKINS_XML.matchAll(/\bavailable="([^"]*)"/gi)].flatMap(m => m[1].split(/[|,]/).map(x => x.trim()).filter(Boolean))) : new Set() : new Set(_selectedList(value, "selected"));
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
    const items = obj.all ? APP_DECOR_IDS : _selectedList(obj, "items");
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
