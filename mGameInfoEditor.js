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
        /(<Var\b[^>]*\bname=["']levelup["'][^>]*\bv=["'])\d+(["'][^>]*>)/;

    if (!pattern.test(text)) {
        throw new Error(
            'لم يتم العثور على عنصر name="levelup"'
        );
    }

    const updated = text.replace(
        pattern,
        `$1${newLevel}$2`
    );

    return Buffer.from(updated, "utf8");
}

module.exports = {
    changeLevel
};
