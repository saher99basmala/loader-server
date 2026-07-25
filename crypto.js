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

// ==============================
// seed من المحتوى
// ==============================
function seedFromContent(data) {
    let s = 1 >>> 0;
    let cum = 0 >>> 0;

    for (let i = 0; i < data.length; i++) {
        let b = data[i] & 0xff;

        s = u32(s + b);
        cum = u32(cum + s);
    }

    let seed = u32(((cum << 16) ^ (s & 0xffff)));

    // إضافة عشوائية مثل التطبيق
    let rand = (Math.floor(Math.random() * 0xffff) + 1) << 16;

    return u32(seed | rand);
}

// ==============================
// XOR ENCODE
// ==============================
function xorEncode(data, seedOverride = null) {

    let size = data.length >>> 0;

    let hl = u32((0x396a8 ^ size) + ((size + 8) ^ 0xc5eed));

    let hs = seedOverride !== null
        ? u32(seedOverride)
        : seedFromContent(data);

    // header (8 bytes)
    let header = new Uint8Array(8);

    header[0] = 0x79;

    header[1] = (hl) & 0xff;
    header[2] = (hl >> 8) & 0xff;
    header[3] = (hl >> 16) & 0xff;

    header[4] = (hs) & 0xff;
    header[5] = (hs >> 8) & 0xff;
    header[6] = (hs >> 16) & 0xff;
    header[7] = (hs >> 24) & 0xff;

    let payload = new Uint8Array(data);

    let table = getHashTable(hl, u32(4 + hs));

    let prev = 0;
    let j = 0;

    for (let i = 0; i < payload.length; i++) {

        let curr = payload[i] & 0xff;

        // XOR
        payload[i] = curr ^ table[j];

        // إضافة prev
        payload[i] = (payload[i] + prev) & 0xff;

        prev = curr;

        j = (j + 1) % 0x2d7;
    }

    // دمج header + payload
    let result = new Uint8Array(header.length + payload.length);

    result.set(header, 0);
    result.set(payload, header.length);

    return result;
}
module.exports = {
    xorEncode
};
