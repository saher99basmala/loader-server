function changeLevel(xml, newLevel) {

    newLevel = Number(newLevel);

    if (!Number.isInteger(newLevel) || newLevel < 0) {
        throw new Error("المستوى يجب أن يكون رقمًا صحيحًا");
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

module.exports = {
    changeLevel
};
