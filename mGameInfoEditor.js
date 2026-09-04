// ============================================
// mGameInfoEditor.js
// محرر XML بعد فك التشفير
// ============================================


// ============================================
// تعديل المستوى
// مثال:
// <Var name="levelup" v="1089" t="i"/>
// يصبح:
// <Var name="levelup" v="99999" t="i"/>
// ============================================

function changeLevel(xml, newLevel) {

    newLevel = Number(newLevel);

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
        /v\s*=\s*(["'])[^"']*\1/,
        `v="${newLevel}"`
    );
    if (
        newElement === oldElement
    ) {
        throw new Error(
            "تم العثور على levelup " +
            "ولكن لم يتم العثور على الخاصية v"
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
// تعديل أي Var
//
// تستخدمها للتعديلات النصية.
//
// مثال:
// name="townName"
// v="سنة اولى BSB"
//
// إذا كانت القيمة الجديدة:
// "مدينتي الجديدة"
//
// تصبح:
// name="townName"
// v="مدينتي الجديدة"
// ============================================

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

    // حماية اسم العنصر عند استخدامه داخل RegExp
    const escapedName =
        varName.replace(
            /[.*+?^${}()|[\]\\]/g,
            "\\$&"
        );

    // البحث عن Var الذي يحمل الاسم المطلوب
    const pattern =
        new RegExp(
            `<Var\\b(?=[^>]*\\bname=["']${escapedName}["'])[^>]*>`
        );

    const match =
        text.match(pattern);

    if (!match) {
        throw new Error(
            `لم يتم العثور على العنصر name="${varName}"`
        );
    }

    const oldElement =
        match[0];

    // تغيير قيمة v فقط
    const newElement =
        oldElement.replace(
            /(\bv=["'])[^"']*(["'])/,
            `$1${String(newValue)
                .replace(/"/g, "&quot;")}$2`
        );

    if (
        newElement === oldElement
    ) {
        throw new Error(
            `تم العثور على ${varName} ` +
            `ولكن لم يتم العثور على الخاصية v`
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
// التصدير
// ============================================

module.exports = {
    changeLevel,
    changeVar
};
