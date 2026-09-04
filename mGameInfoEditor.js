// ============================================
// mGameInfoEditor.js
// جميع تعديلات mGameInfo.xml هنا
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

    if (newElement === oldElement) {
        throw new Error(
            `لم يتم العثور على الخاصية v داخل ${varName}`
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

    const text = xml.toString("utf8");

    const pattern =
        /<Var\b(?=[^>]*\bname=["']levelup["'])[^>]*>/;

    const match = text.match(pattern);

    if (!match) {
        throw new Error(
            'لم يتم العثور على عنصر name="levelup"'
        );
    }

    const oldElement = match[0];

    const newElement =
        oldElement.replace(
            /(\bv=["'])[^"']*(["'])/,
            `$1${newLevel}$2`
        );

    if (newElement === oldElement) {
        throw new Error(
            'تم العثور على levelup ولكن لم يتم العثور على الخاصية v'
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
// قائمة التعديلات
// ============================================

const EDITORS = {

    // المستوى
    level: function(xml, value) {
        return changeLevel(xml, value);
    },


    // اسم المدينة
    townName: function(xml, value) {
        return changeVar(
            xml,
            "townName",
            value
        );
    },


    // ========================================
    // سنضيف هنا التعديلات القادمة
    // مثال:
    //
    // products: function(xml, value) {
    //     return changeVar(
    //         xml,
    //         "اسم_المتغير",
    //         value
    //     );
    // },
    // ========================================
};


// ============================================
// تنفيذ التعديلات المطلوبة
// ============================================

function applyEdits(xml, edits) {

    if (!Array.isArray(edits)) {
        throw new Error(
            "قائمة التعديلات غير صحيحة"
        );
    }

    let result = xml;

    for (const edit of edits) {

        if (!edit || !edit.type) {
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


module.exports = {
    changeVar,
    changeLevel,
    applyEdits
};
