const TABLE_SIZE = 0x2D7;

function u32(v) {
    return v >>> 0;
}

function readU32(data, pos) {
    if (pos + 4 > data.length) {
        throw new Error("بيانات غير كافية لقراءة UInt32");
    }

    return (
        data[pos] |
        (data[pos + 1] << 8) |
        (data[pos + 2] << 16) |
        (data[pos + 3] << 24)
    ) >>> 0;
}

function u32Bytes(v) {
    v = u32(v);

    return Buffer.from([
        v & 0xff,
        (v >>> 8) & 0xff,
        (v >>> 16) & 0xff,
        (v >>> 24) & 0xff
    ]);
}

function mmh2(data, seed) {
    const m = 0x5bd1e995;

    let h = u32(seed ^ data.length);
    let i = 0;
    let length = data.length;

    while (length >= 4) {
        let k = readU32(data, i);

        k = Math.imul(k, m) >>> 0;
        k = (k ^ (k >>> 24)) >>> 0;
        k = Math.imul(k, m) >>> 0;

        h = Math.imul(h, m) >>> 0;
        h = (h ^ k) >>> 0;

        i += 4;
        length -= 4;
    }

    if (length === 3) {
        h = (h ^ (data[i + 2] << 16)) >>> 0;
    }

    if (length >= 2) {
        h = (h ^ (data[i + 1] << 8)) >>> 0;
    }

    if (length >= 1) {
        h = (h ^ data[i]) >>> 0;
        h = Math.imul(h, m) >>> 0;
    }

    h = (h ^ (h >>> 13)) >>> 0;
    h = Math.imul(h, m) >>> 0;
    h = (h ^ (h >>> 15)) >>> 0;

    return h >>> 0;
}

function getHashTable(length, seed) {
    const table = Buffer.alloc(TABLE_SIZE);

    let h = u32(seed);
    let i = 0;

    while (i < TABLE_SIZE) {
        const v = u32Bytes(h);

        h = mmh2(v, length);

        const hb = u32Bytes(h);

        for (let j = 0; j < 4 && i + j < TABLE_SIZE; j++) {
            table[i + j] = hb[j];
        }

        i += 4;
    }

    return table;
}

function xorDecode(data) {
    if (data.length < 8) {
        throw new Error("الملف صغير جدًا");
    }

    const hl =
        data[1] |
        (data[2] << 8) |
        (data[3] << 16);

    const hs =
        data[4] |
        (data[5] << 8) |
        (data[6] << 16) |
        (data[7] << 24);

    const srcSize = data.length;

    const table = getHashTable(
        hl,
        u32(4 + hs)
    );

    const sf = u32(
        (hl -
            u32(
                0xC5EED ^ srcSize
            )) ^
        0x396A8
    );

    const actual = Math.min(
        sf,
        srcSize - 8
    );

    const out = Buffer.alloc(actual);

    for (let i = 0; i < actual; i++) {
        out[i] = data[8 + i];
    }

    let j = 0;

    for (let i = 0; i < out.length; i++) {

        if (i > 0) {
            out[i] =
                (out[i] - out[i - 1]) & 0xff;
        }

        out[i] =
            (out[i] ^ table[j]) & 0xff;

        j++;

        if (j >= TABLE_SIZE) {
            j = 0;
        }
    }

    return out;
}

function isLz4(data) {
    return (
        data.length >= 4 &&
        data[0] === 0x04 &&
        data[1] === 0x22 &&
        data[2] === 0x4D &&
        data[3] === 0x18
    );
}

function lz4Decompress(data) {
    if (data.length < 9) {
        throw new Error("LZ4: البيانات صغيرة جدًا");
    }

    const size = readU32(data, 4);

    let src = 8;
    let output = Buffer.alloc(size);

    let outLen = 0;

    function readByte() {
        if (src >= data.length) {
            throw new Error(
                "LZ4: نهاية بيانات غير متوقعة"
            );
        }

        return data[src++];
    }

    while (
        src < data.length &&
        outLen < size
    ) {

        const token = readByte();

        let literalLen =
            token >>> 4;

        if (literalLen === 15) {
            let b;

            do {
                b = readByte();
                literalLen += b;
            } while (b === 255);
        }

        if (
            src + literalLen >
            data.length
        ) {
            throw new Error(
                "LZ4: Literal خارج النطاق"
            );
        }

        if (
            outLen + literalLen >
            size
        ) {
            throw new Error(
                "LZ4: حجم Literal غير صحيح"
            );
        }

        for (
            let i = 0;
            i < literalLen;
            i++
        ) {
            output[outLen++] =
                data[src++];
        }

        if (outLen >= size) {
            break;
        }

        if (src + 2 > data.length) {
            throw new Error(
                "LZ4: لا يوجد Offset"
            );
        }

        const offset =
            readByte() |
            (readByte() << 8);

        if (offset === 0) {
            throw new Error(
                "LZ4: Offset غير صالح"
            );
        }

        let matchLen =
            token & 0x0F;

        if (matchLen === 15) {
            let b;

            do {
                b = readByte();
                matchLen += b;
            } while (b === 255);
        }

        matchLen += 4;

        const start =
            outLen - offset;

        if (start < 0) {
            throw new Error(
                "LZ4: Offset خارج النطاق"
            );
        }

        for (
            let i = 0;
            i < matchLen;
            i++
        ) {
            if (outLen >= size) {
                throw new Error(
                    "LZ4: الحجم الناتج تجاوز المتوقع"
                );
            }

            output[outLen++] =
                output[
                    start +
                    (i % offset)
                ];
        }
    }

    if (outLen !== size) {
        throw new Error(
            "LZ4: الحجم الناتج غير صحيح\n" +
            "Expected: " +
            size +
            "\nActual: " +
            outLen
        );
    }

    return output;
}

function trimXml(data) {
    const marker = Buffer.from("</root>");

    const pos = data.lastIndexOf(marker);

    if (pos !== -1) {
        return data.subarray(
            0,
            pos + marker.length
        );
    }

    let end = data.length;

    while (
        end > 0 &&
        data[end - 1] === 0
    ) {
        end--;
    }

    return data.subarray(0, end);
}

function decodeFile(data) {

    if (!Buffer.isBuffer(data)) {
        data = Buffer.from(data);
    }

    if (data.length === 0) {
        throw new Error("ملف فارغ");
    }

    // XML أصلاً
    if (data[0] === 0x3C) {
        return data;
    }

    // يجب أن يبدأ بـ 0x79
    if (data[0] !== 0x79) {
        throw new Error(
            "نوع غير مدعوم\nMagic: 0x" +
            data[0].toString(16).padStart(2, "0")
        );
    }

    let payload = xorDecode(data);

    if (isLz4(payload)) {
        payload = lz4Decompress(payload);
    }

    return trimXml(payload);
}

module.exports = {
    decodeFile
};
