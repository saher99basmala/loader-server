const TABLE_SIZE = 0x2D7;

// ============================================
// U32
// ============================================

function u32(n) {
    return n >>> 0;
}

// ============================================
// قراءة U32 من Buffer
// ============================================

function readU32(buf, offset) {
    return (
        (buf[offset]) |
        (buf[offset + 1] << 8) |
        (buf[offset + 2] << 16) |
        (buf[offset + 3] << 24)
    ) >>> 0;
}

// ============================================
// U32 -> Bytes
// ============================================

function u32Bytes(v) {
    return Buffer.from([
        v & 0xff,
        (v >>> 8) & 0xff,
        (v >>> 16) & 0xff,
        (v >>> 24) & 0xff
    ]);
}

// ============================================
// MurmurHash2
// ============================================

function mmh2(data, seed = 0) {

    const m = 0x5bd1e995;
    const r = 24;

    let h = u32(seed ^ data.length);
    let i = 0;

    while (data.length - i >= 4) {

        let k =
            (data[i]) |
            (data[i + 1] << 8) |
            (data[i + 2] << 16) |
            (data[i + 3] << 24);

        k = Math.imul(k, m);
        k ^= k >>> r;
        k = Math.imul(k, m);

        h = Math.imul(h, m);
        h ^= k;

        i += 4;
    }

    switch (data.length - i) {

        case 3:
            h ^= data[i + 2] << 16;

        case 2:
            h ^= data[i + 1] << 8;

        case 1:
            h ^= data[i];
            h = Math.imul(h, m);
    }

    h ^= h >>> 13;
    h = Math.imul(h, m);
    h ^= h >>> 15;

    return u32(h);
}

// ============================================
// Hash Table
// ============================================

function getHashTable(key) {

    const table = Buffer.alloc(TABLE_SIZE);

    let seed = 0;

    if (typeof key === "string") {
        key = Buffer.from(key, "utf8");
    }

    if (!Buffer.isBuffer(key)) {
        throw new Error("Invalid key");
    }

    for (let i = 0; i < TABLE_SIZE; i += 4) {

        seed = mmh2(key, seed);

        const bytes = u32Bytes(seed);

        bytes.copy(
            table,
            i,
            0,
            Math.min(4, TABLE_SIZE - i)
        );
    }

    return table;
}

// ============================================
// XOR Decode
// ============================================

function xorDecode(data, table) {

    const output = Buffer.alloc(data.length);

    for (let i = 0; i < data.length; i++) {

        output[i] =
            data[i] ^
            table[i % table.length];
    }

    return output;
}

// ============================================
// LZ4 Check
// ============================================

function isLz4(data) {

    if (!data || data.length < 4) {
        return false;
    }

    return (
        data[0] === 0x04 &&
        data[1] === 0x22 &&
        data[2] === 0x4d &&
        data[3] === 0x18
    );
}

// ============================================
// LZ4 Decompress
// ============================================

function lz4Decompress(data) {

    // محاولة استخدام lz4 إذا كانت مثبتة
    let lz4;

    try {
        lz4 = require("lz4");
    } catch (e) {
        throw new Error(
            "مكتبة lz4 غير مثبتة في السيرفر"
        );
    }

    // قراءة الحجم الأصلي إذا كان موجودًا
    let maxSize = data.length * 20;

    if (data.length >= 8) {

        const possibleSize =
            readU32(data, 4);

        if (
            possibleSize > 0 &&
            possibleSize < 100 * 1024 * 1024
        ) {
            maxSize = possibleSize;
        }
    }

    const output = Buffer.alloc(maxSize);

    let decoded;

    try {

        decoded =
            lz4.decodeBlock(
                data,
                output
            );

    } catch (e) {

        throw new Error(
            "فشل فك ضغط LZ4: " +
            e.message
        );
    }

    if (typeof decoded === "number") {

        return output.subarray(
            0,
            decoded
        );
    }

    if (Buffer.isBuffer(decoded)) {
        return decoded;
    }

    throw new Error(
        "نتيجة LZ4 غير صالحة"
    );
}

// ============================================
// Trim XML
// ============================================

function trimXml(data) {

    if (!Buffer.isBuffer(data)) {
        data = Buffer.from(data);
    }

    const text =
        data.toString("utf8");

    const start =
        text.indexOf("<");

    if (start === -1) {
        return data;
    }

    const xml =
        text.substring(start);

    return Buffer.from(
        xml.trim(),
        "utf8"
    );
}

// ============================================
// Decode File
// ============================================

function decodeFile(input) {

    if (!Buffer.isBuffer(input)) {
        input = Buffer.from(input);
    }

    if (input.length === 0) {
        throw new Error("الملف فارغ");
    }

    /*
     * المفتاح المستخدم في خوارزمية
     * mGameInfo.xml
     */

    const key =
        Buffer.from(
            "mGameInfo.xml",
            "utf8"
        );

    const table =
        getHashTable(key);

    let decoded =
        xorDecode(
            input,
            table
        );

    // ========================================
    // LZ4
    // ========================================

    if (isLz4(decoded)) {

        decoded =
            lz4Decompress(decoded);
    }

    // ========================================
    // تنظيف XML
    // ========================================

    decoded =
        trimXml(decoded);

    return decoded;
}

// ============================================
// تغيير مستوى اللاعب
// ============================================

function changeLevel(xml, newLevel) {

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
     * نبحث عن عنصر Var الذي اسمه levelup
     *
     * مثال:
     *
     * <Var name="levelup" v="1089" t="i"/>
     *
     * ويصبح:
     *
     * <Var name="levelup" v="99999" t="i"/>
     */

    const pattern =
        /(<Var\b[^>]*\bname=["']levelup["'][^>]*\bv=["'])\d+(["'][^>]*>)/;

    if (!pattern.test(text)) {

        throw new Error(
            'لم يتم العثور على عنصر name="levelup"'
        );
    }

    const updated =
        text.replace(
            pattern,
            `$1${newLevel}$2`
        );

    return Buffer.from(
        updated,
        "utf8"
    );
}

// ============================================
// Exports
// ============================================

module.exports = {
    decodeFile,
    changeLevel
};
