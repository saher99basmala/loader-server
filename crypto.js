// ==============================
// أدوات أساسية
// ==============================

function u32(v) {
    return v >>> 0;
}

function u8(v) {
    return v & 0xFF;
}

// ==============================
// mmh2 (نفس الموجود)
// ==============================
function mmh2(data, seed) {
    let m = 0x5bd1e995;
    let h = u32(seed ^ data.length);

    let i = 0;

    while (data.length - i >= 4) {
        let k =
            (data[i] & 0xff) |
            ((data[i + 1] & 0xff) << 8) |
            ((data[i + 2] & 0xff) << 16) |
            ((data[i + 3] & 0xff) << 24);

        k = u32(k * m);
        k ^= k >>> 24;
        k = u32(k * m);

        h = u32(h * m);
        h ^= k;

        i += 4;
    }

    switch (data.length - i) {
        case 3:
            h ^= (data[i + 2] & 0xff) << 16;
        case 2:
            h ^= (data[i + 1] & 0xff) << 8;
        case 1:
            h ^= (data[i] & 0xff);
            h = u32(h * m);
    }

    h ^= h >>> 13;
    h = u32(h * m);
    h ^= h >>> 15;

    return u32(h);
}

// ==============================
// Hash Table
// ==============================
function getHashTable(length, seed) {
    let table = new Uint8Array(0x2d7);

    let h = u32(seed);

    for (let i = 0; i < table.length; i += 4) {
        let v = [
            h & 0xff,
            (h >> 8) & 0xff,
            (h >> 16) & 0xff,
            (h >> 24) & 0xff
        ];

        h = mmh2(v, length);

        let hb = [
            h & 0xff,
            (h >> 8) & 0xff,
            (h >> 16) & 0xff,
            (h >> 24) & 0xff
        ];

        for (let j = 0; j < 4; j++) {
            if (i + j < table.length) {
                table[i + j] = hb[j];
            }
        }
    }

    return table;
}
