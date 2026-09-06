/* ========================================
   cityCache.js
======================================== */

const express = require("express");
const zlib = require("zlib");

const router = express.Router();


// ============================================================
// CONFIG
// ============================================================

const MAX_FILE_SIZE =
    50 * 1024 * 1024;

const MAX_TOTAL_SIZE =
    200 * 1024 * 1024;


// ============================================================
// SAVECRYPTO CONSTANTS
// مأخوذة من منطق decodeSaveCity في fetchCity.js
// ============================================================

const TABLE_SIZE =
    0x2D7;

const PROCESS_XOR =
    0x396A8;

const TOTAL_XOR =
    0xC5EED;

const TABLE_MULTIPLIER =
    0x5BD1E995;


// ============================================================
// LZ4 MAGIC
// ============================================================

const LZ4_MAGIC =
    Buffer.from([
        0x04,
        0x22,
        0x4D,
        0x18
    ]);


// ============================================================
// FETCH54 TABLE
// ============================================================

const FETCH54_TABLE =
    Buffer.from(
        "d192KFBTVDZLSDBPSkIwNHh4PlJDMyFrUngqfCsyNV5PU2guWCcmTj5gbTlLZklXb3xTMmpoYmMgZlRkN2FTWjZSQmdRYkwpZlcxMWI8J0dXJ00pTiNsbF5xWntdOmJhakBudjlZUXlgKDgnJkUyeSo8biZSak9lb2lPRTNbP0lMTys/ZFNAdXxddlZJSGdpdnR3I19ybG9nTD9yY2xKa0EyVjZkSF9hdiB1OWZ3JFZnaiVBdEJHK2RSRSg6bih0SSdiNDc/c3phSU5rbTh7PDdqTCN0O1NKO0knX3ZyVkNveiFvcGg0cC9kdW1UKDZ4ezNRfiZtbWEpJS9+QlJjbm9qeVRmVC55cW4mc2s5ajtheTNwZyssY2NKRz1URXUySy0qZCVJVSpZMk4pLn17VVBfTip4P1pdX2wsXXZ+J21ydkIpdUcuc3cyUCVRK3xOUUxgPklmeUx3ZF0sST9mK2lnOm84cyNMUk15KCQwWTJWelhCRVZ+UXVCZ1J+eVplb2gtY0NAcUA+Ni1WdlQyLFpTV2xVfnRoKyUwfFdfaVBsfU0wdW4/cHlkcXVsYHxaTGB1N3JtMUwwZXd6NGM5KmZuUlpGOjgoOyYlNltHbj4sTFhXOUY/UVE0MSg6NXN2ckdWI3snMyldMi82bG5bc1lkczpxVGRCaDhPeUI8I1EhVSVRJ1tkK3IlKU9CT3V5XSE9fWFnMEdQNlp+YCs5PnJGJmBfOF59Tn5YMDJEKUgjfWFPKTA4dHF4OixPJmZOcHtSJFc+KU1CZUxpfFJYOi56JzVCJWddMTNFZiB5JUs/e1JBcGdrey4xKSxBT1toVXlJLm98cUBwXiBNczFJNyBadWI6YSdPNFknXzA7WG1afnZLPW5KI3dZQ2Njbl5Dekp1NDxmNW9neV19I0s1RklsS25ud1RfXmRWQVpndl1EIFdJdEBzbCFpPSlxeG5XaA==",
        "base64"
    );


// ============================================================
// UTILS
// ============================================================

function u32le(
    buf,
    offset
) {

    if (
        offset + 4 >
        buf.length
    ) {

        throw new Error(
            "u32le خارج حدود البيانات"
        );
    }

    return (
        (
            buf[offset] |
            (buf[offset + 1] << 8) |
            (buf[offset + 2] << 16) |
            (buf[offset + 3] * 0x1000000)
        ) >>> 0
    );
}


function xor32(
    a,
    b
) {

    return (
        a ^ b
    ) >>> 0;
}


function add32(
    a,
    b
) {

    return (
        a + b
    ) >>> 0;
}


function sub32(
    a,
    b
) {

    return (
        a - b
    ) >>> 0;
}


function bufferMagic(
    buf
) {

    if (
        !buf ||
        buf.length < 4
    ) {

        return "";
    }

    return Array
        .from(
            buf.subarray(
                0,
                4
            )
        )
        .map(
            x =>
                x
                    .toString(16)
                    .padStart(
                        2,
                        "0"
                    )
        )
        .join(" ");
}


function isLz4Magic(
    buf
) {

    return (
        buf &&
        buf.length >= 4 &&
        buf[0] === 0x04 &&
        buf[1] === 0x22 &&
        buf[2] === 0x4D &&
        buf[3] === 0x18
    );
}


function isGzip(
    buf
) {

    return (
        buf &&
        buf.length >= 2 &&
        buf[0] === 0x1F &&
        buf[1] === 0x8B
    );
}


function looksLikeXml(
    buf
) {

    if (
        !buf ||
        buf.length === 0
    ) {

        return false;
    }

    const text =
        buf
            .subarray(
                0,
                Math.min(
                    buf.length,
                    512
                )
            )
            .toString(
                "utf8"
            )
            .trimStart();

    return (
        text.startsWith("<") ||
        text.startsWith("<?xml")
    );
}


// ============================================================
// 0x79
// ============================================================

function build79Table(
    seed
) {

    const table =
        Buffer.alloc(
            TABLE_SIZE
        );

    let state =
        seed >>> 0;

    for (
        let i = 0;
        i < TABLE_SIZE;
        i++
    ) {

        state =
            Math.imul(
                state,
                TABLE_MULTIPLIER
            ) >>> 0;

        table[i] =
            (
                state >>> 24
            ) & 0xFF;
    }

    return table;
}


function xorDecode79(
    raw
) {

    if (
        !Buffer.isBuffer(raw)
    ) {

        raw =
            Buffer.from(raw);
    }

    if (
        raw.length < 8
    ) {

        throw new Error(
            `بيانات 0x79 قصيرة: ${raw.length}`
        );
    }

    const headerValue =
        u32le(
            raw,
            1
        );

    const total =
        raw.length >>> 0;

    const derived =
        xor32(
            TOTAL_XOR,
            total
        );

    let processLenU32 =
        sub32(
            headerValue,
            derived
        );

    processLenU32 =
        xor32(
            processLenU32,
            PROCESS_XOR
        );

    const maxProcessLen =
        Math.max(
            0,
            total - 8
        );

    const processLen =
        Math.min(
            maxProcessLen,
            processLenU32 >>> 0
        );

    const rawSeed =
        u32le(
            raw,
            4
        );

    const seed =
        add32(
            rawSeed,
            4
        );

    const table =
        build79Table(
            seed
        );

    const out =
        Buffer.from(
            raw.subarray(
                8,
                8 + processLen
            )
        );

    if (
        out.length === 0
    ) {

        return out;
    }

    out[0] =
        (
            out[0] ^
            table[0]
        ) & 0xFF;

    for (
        let i = 1;
        i < out.length;
        i++
    ) {

        const current =
            out[i];

        const previousDecoded =
            out[i - 1];

        const delta =
            (
                current -
                previousDecoded
            ) & 0xFF;

        out[i] =
            (
                delta ^
                table[
                    i % TABLE_SIZE
                ]
            ) & 0xFF;
    }

    return out;
}


// ============================================================
// 0x54
// ============================================================

function decode54Layer(
    raw
) {

    if (
        !Buffer.isBuffer(raw)
    ) {

        raw =
            Buffer.from(raw);
    }

    if (
        raw.length < 4
    ) {

        throw new Error(
            `بيانات 0x54 قصيرة: ${raw.length}`
        );
    }

    if (
        raw[0] !== 0x54
    ) {

        throw new Error(
            `بيانات 0x54 غير صحيحة. Magic=${bufferMagic(raw)}`
        );
    }

    let processLen =
        (
            (
                (raw[1] & 0xFF) ^
                FETCH54_TABLE[0]
            ) |
            (
                (raw[2] & 0xFF) << 8
            )
        ) >>> 0;

    processLen =
        Math.min(
            processLen,
            raw.length - 3
        );

    const out =
        Buffer.from(
            raw.subarray(3)
        );

    if (
        out.length === 0
    ) {

        return out;
    }

    out[0] =
        (
            out[0] -
            0x54
        ) & 0xFF;

    const count =
        Math.min(
            processLen,
            out.length
        );

    for (
        let i = 0;
        i < count;
        i++
    ) {

        if (
            i > 0
        ) {

            out[i] =
                (
                    out[i] -
                    out[i - 1]
                ) & 0xFF;
        }

        out[i] =
            (
                out[i] ^
                FETCH54_TABLE[
                    i %
                    FETCH54_TABLE.length
                ]
            ) & 0xFF;
    }

    return out;
}


// ============================================================
// TRANSPORT
// ============================================================

function decodeTransport(
    raw
) {

    if (
        !Buffer.isBuffer(raw)
    ) {

        raw =
            Buffer.from(raw);
    }

    if (
        raw.length === 0
    ) {

        return raw;
    }

    const type =
        raw[0];

    console.log(
        `[CityCache] SaveCrypto type=0x${type
            .toString(16)
            .padStart(2, "0")}`
    );

    switch (type) {

        case 0x79:

            return xorDecode79(
                raw
            );

        case 0x54:

            return decode54Layer(
                raw
            );

        case 0x1F:

            return raw;

        default:

            throw new Error(
                `نوع SaveCrypto غير مدعوم: 0x${type
                    .toString(16)
                    .padStart(2, "0")}`
            );
    }
}


// ============================================================
// LZ4
// ============================================================

function lz4DecompressBlock(
    src,
    expectedSize
) {

    let srcPos = 0;
    let dstPos = 0;

    const output =
        Buffer.alloc(
            expectedSize
        );

    while (
        srcPos < src.length &&
        dstPos < expectedSize
    ) {

        const token =
            src[srcPos++];

        let literalLength =
            token >>> 4;

        if (
            literalLength === 15
        ) {

            let value;

            do {

                if (
                    srcPos >=
                    src.length
                ) {

                    throw new Error(
                        "LZ4: literal length خارج البيانات"
                    );
                }

                value =
                    src[srcPos++];

                literalLength +=
                    value;

            } while (
                value === 255
            );
        }

        if (
            srcPos +
            literalLength >
            src.length
        ) {

            throw new Error(
                "LZ4: literals خارج البيانات"
            );
        }

        if (
            dstPos +
            literalLength >
            expectedSize
        ) {

            throw new Error(
                "LZ4: output overflow"
            );
        }

        src.copy(
            output,
            dstPos,
            srcPos,
            srcPos +
                literalLength
        );

        srcPos +=
            literalLength;

        dstPos +=
            literalLength;

        if (
            srcPos >=
            src.length
        ) {

            break;
        }

        if (
            srcPos + 2 >
            src.length
        ) {

            throw new Error(
                "LZ4: offset ناقص"
            );
        }

        const offset =
            src[srcPos] |
            (
                src[srcPos + 1] << 8
            );

        srcPos += 2;

        if (
            offset === 0
        ) {

            throw new Error(
                "LZ4: offset = 0"
            );
        }

        if (
            offset > dstPos
        ) {

            throw new Error(
                `LZ4: offset أكبر من output: ${offset} > ${dstPos}`
            );
        }

        let matchLength =
            token & 0x0F;

        if (
            matchLength === 15
        ) {

            let value;

            do {

                if (
                    srcPos >=
                    src.length
                ) {

                    throw new Error(
                        "LZ4: match length خارج البيانات"
                    );
                }

                value =
                    src[srcPos++];

                matchLength +=
                    value;

            } while (
                value === 255
            );
        }

        matchLength += 4;

        if (
            dstPos +
            matchLength >
            expectedSize
        ) {

            throw new Error(
                "LZ4: match خارج الحجم"
            );
        }

        for (
            let i = 0;
            i < matchLength;
            i++
        ) {

            output[
                dstPos + i
            ] =
                output[
                    dstPos -
                    offset +
                    i
                ];
        }

        dstPos +=
            matchLength;
    }

    if (
        dstPos !==
        expectedSize
    ) {

        throw new Error(
            `LZ4: الحجم الناتج غير مطابق. expected=${expectedSize}, actual=${dstPos}`
        );
    }

    return output;
}


function decodeLz4Container(
    raw
) {

    if (
        !isLz4Magic(raw)
    ) {

        throw new Error(
            `LZ4 magic غير صحيح: ${bufferMagic(raw)}`
        );
    }

    if (
        raw.length < 8
    ) {

        throw new Error(
            "LZ4 container قصير"
        );
    }

    const expectedSize =
        u32le(
            raw,
            4
        );

    const compressed =
        raw.subarray(
            8
        );

    console.log(
        `[CityCache] LZ4 expected=${expectedSize}, compressed=${compressed.length}`
    );

    return lz4DecompressBlock(
        compressed,
        expectedSize
    );
}


// ============================================================
// XML
// ============================================================

function trimXml(
    buf
) {

    if (
        !Buffer.isBuffer(buf)
    ) {

        buf =
            Buffer.from(buf);
    }

    const text =
        buf.toString(
            "utf8"
        );

    const rootEnd =
        text.lastIndexOf(
            "</root>"
        );

    if (
        rootEnd !== -1
    ) {

        return Buffer.from(
            text.slice(
                0,
                rootEnd +
                "</root>".length
            ),
            "utf8"
        );
    }

    let end =
        buf.length;

    while (
        end > 0
    ) {

        const c =
            buf[end - 1];

        if (
            c === 0x00 ||
            c === 0x09 ||
            c === 0x0A ||
            c === 0x0D ||
            c === 0x20
        ) {

            end--;

        } else {

            break;
        }
    }

    return buf.subarray(
        0,
        end
    );
}


// ============================================================
// COMPLETE .CITY DECODER
// ============================================================

function decodeSaveCity(
    cityBytes
) {

    let data =
        Buffer.from(
            cityBytes
        );

    console.log(
        `[CityCache] cityBytes=${data.length} magic=${bufferMagic(data)}`
    );

    let rounds = 0;

    while (
        data.length > 0 &&
        rounds < 8
    ) {

        rounds++;

        // ----------------------------------------------------
        // XML
        // ----------------------------------------------------

        if (
            looksLikeXml(data)
        ) {

            console.log(
                `[CityCache] XML detected after ${rounds - 1} layer(s)`
            );

            return trimXml(
                data
            );
        }


        // ----------------------------------------------------
        // LZ4
        // ----------------------------------------------------

        if (
            isLz4Magic(data)
        ) {

            console.log(
                "[CityCache] LZ4 detected"
            );

            data =
                decodeLz4Container(
                    data
                );

            continue;
        }


        // ----------------------------------------------------
        // GZIP
        // ----------------------------------------------------

        if (
            isGzip(data)
        ) {

            console.log(
                "[CityCache] GZIP detected"
            );

            data =
                zlib.gunzipSync(
                    data
                );

            continue;
        }


        // ----------------------------------------------------
        // SAVECRYPTO
        // ----------------------------------------------------

        const type =
            data[0];

        if (
            type === 0x79 ||
            type === 0x54 ||
            type === 0x1F
        ) {

            const before =
                data;

            data =
                decodeTransport(
                    data
                );

            console.log(
                `[CityCache] layer ${rounds}: ${bufferMagic(before)} -> ${bufferMagic(data)}`
            );

            continue;
        }


        throw new Error(
            `طبقة غير معروفة. Magic=${bufferMagic(data)}`
        );
    }


    if (
        looksLikeXml(data)
    ) {

        return trimXml(
            data
        );
    }


    throw new Error(
        `تعذر الوصول إلى XML. Magic=${bufferMagic(data)}`
    );
}


// ============================================================
// XML HELPERS
// ============================================================

function getAttribute(
    tag,
    name
) {

    const regex =
        new RegExp(
            "\\b" +
            name +
            "\\s*=\\s*[\"']([^\"']*)[\"']",
            "i"
        );

    const match =
        tag.match(
            regex
        );

    return match
        ? match[1]
        : "";
}


function findVar(
    xml,
    name
) {

    const regex =
        /<Var\b[^>]*\/?>/gi;

    let match;

    while (
        (match =
            regex.exec(xml)) !== null
    ) {

        const tag =
            match[0];

        const varName =
            getAttribute(
                tag,
                "name"
            );

        if (
            varName.toLowerCase() ===
            name.toLowerCase()
        ) {

            return getAttribute(
                tag,
                "v"
            );
        }
    }

    return "";
}


// ============================================================
// CITY INFO
// ============================================================

function extractCityInfo(
    xml,
    filename
) {

    const fileId =
        filename.replace(
            /\.city$/i,
            ""
        );


    // --------------------------------------------------------
    // ID
    // --------------------------------------------------------

    let cityId =
        findVar(
            xml,
            "cityId"
        );

    if (
        !cityId
    ) {

        cityId =
            findVar(
                xml,
                "cityID"
            );
    }

    if (
        !cityId
    ) {

        cityId =
            fileId;
    }


    // --------------------------------------------------------
    // NAME
    // --------------------------------------------------------

    let name =
        findVar(
            xml,
            "cityName"
        );

    if (
        !name
    ) {

        name =
            findVar(
                xml,
                "CityName"
            );
    }

    if (
        !name
    ) {

        name =
            findVar(
                xml,
                "name"
            );
    }


    // --------------------------------------------------------
    // LEVEL
    // --------------------------------------------------------

    let level =
        findVar(
            xml,
            "level"
        );

    if (
        !level
    ) {

        level =
            findVar(
                xml,
                "Level"
            );
    }


    return {

        file:
            filename,

        cityId:
            cityId,

        name:
            name,

        level:
            level
    };
}


// ============================================================
// EDIT CITY XML
// نفس التعديلات المطلوبة
// ============================================================

function editCityXml(
    xml
) {

    if (
        !Buffer.isBuffer(xml)
    ) {

        xml =
            Buffer.from(xml);
    }

    let text =
        xml.toString(
            "utf8"
        );


    text =
        text.replace(
            /<Var\b[^>]*\/?>/gi,
            function(tag) {

                // ------------------------------------------------
                // cityId -> فارغ
                // ------------------------------------------------

                if (
                    /\bname\s*=\s*["']cityId["']/i
                        .test(tag)
                ) {

                    const valueRegex =
                        /(\bv\s*=\s*["'])[^"']*(["'])/i;

                    if (
                        valueRegex.test(tag)
                    ) {

                        return tag.replace(
                            valueRegex,
                            "$1$2"
                        );
                    }

                    return tag.replace(
                        /\/?>$/,
                        ' v=""/>'
                    );
                }


                // ------------------------------------------------
                // Device -> ASUS_Z01QD
                // ------------------------------------------------

                if (
                    /\bname\s*=\s*["']Device["']/i
                        .test(tag)
                ) {

                    const valueRegex =
                        /(\bv\s*=\s*["'])[^"']*(["'])/i;

                    if (
                        valueRegex.test(tag)
                    ) {

                        return tag.replace(
                            valueRegex,
                            "$1ASUS_Z01QD$2"
                        );
                    }

                    return tag.replace(
                        /\/?>$/,
                        ' v="ASUS_Z01QD"/>'
                    );
                }


                return tag;
            }
        );


    return Buffer.from(
        text,
        "utf8"
    );
}


// ============================================================
// MULTIPART PARSER
// ============================================================

function parseMultipart(
    body,
    contentType
) {

    const match =
        contentType.match(
            /boundary=(?:"([^"]+)"|([^;]+))/i
        );

    if (!match) {

        throw new Error(
            "Multipart boundary غير موجود"
        );
    }

    const boundary =
        match[1] ||
        match[2];

    const boundaryBuffer =
        Buffer.from(
            "--" +
            boundary
        );

    const files = [];

    let position = 0;

    while (true) {

        const start =
            body.indexOf(
                boundaryBuffer,
                position
            );

        if (
            start === -1
        ) {

            break;
        }

        let partStart =
            start +
            boundaryBuffer.length;


        // نهاية multipart
        if (
            body[partStart] === 0x2D &&
            body[partStart + 1] === 0x2D
        ) {

            break;
        }


        // CRLF
        if (
            body[partStart] === 0x0D &&
            body[partStart + 1] === 0x0A
        ) {

            partStart += 2;
        }


        const headerEnd =
            body.indexOf(
                Buffer.from(
                    "\r\n\r\n"
                ),
                partStart
            );

        if (
            headerEnd === -1
        ) {

            break;
        }


        const headers =
            body
                .subarray(
                    partStart,
                    headerEnd
                )
                .toString(
                    "utf8"
                );


        const dataStart =
            headerEnd + 4;


        const nextBoundary =
            body.indexOf(
                boundaryBuffer,
                dataStart
            );

        if (
            nextBoundary === -1
        ) {

            break;
        }


        let dataEnd =
            nextBoundary;


        if (
            dataEnd >= 2 &&
            body[dataEnd - 2] === 0x0D &&
            body[dataEnd - 1] === 0x0A
        ) {

            dataEnd -= 2;
        }


        const disposition =
            headers.match(
                /Content-Disposition:[^\r\n]*/i
            );


        if (
            disposition
        ) {

            const filenameMatch =
                disposition[0].match(
                    /filename="([^"]+)"/i
                );

            if (
                filenameMatch
            ) {

                const filename =
                    filenameMatch[1];

                const fileData =
                    Buffer.from(
                        body.subarray(
                            dataStart,
                            dataEnd
                        )
                    );

                files.push({
                    filename,
                    data:
                        fileData
                });
            }
        }


        position =
            nextBoundary;
    }


    return files;
}


// ============================================================
// API: POST /api/city-cache
// ============================================================
//
// يستقبل عدة ملفات .city
// ويفكها كلها
// ويرجع معلومات المدن
//
// ============================================================

router.post(
    "/city-cache",

    express.raw({
        type:
            "multipart/form-data",

        limit:
            "200mb"
    }),

    (req, res) => {

        try {

            if (
                !Buffer.isBuffer(
                    req.body
                )
            ) {

                return res
                    .status(400)
                    .json({

                        ok:
                            false,

                        error:
                            "لم يتم إرسال الملفات"
                    });
            }


            const files =
                parseMultipart(
                    req.body,

                    req.headers[
                        "content-type"
                    ] || ""
                );


            if (
                files.length === 0
            ) {

                return res
                    .status(400)
                    .json({

                        ok:
                            false,

                        error:
                            "لم يتم العثور على ملفات"
                    });
            }


            let totalSize = 0;

            const cities = [];

            const errors = [];


            for (
                const file of files
            ) {

                if (
                    !/\.city$/i.test(
                        file.filename
                    )
                ) {

                    continue;
                }


                if (
                    file.data.length >
                    MAX_FILE_SIZE
                ) {

                    errors.push({

                        file:
                            file.filename,

                        error:
                            "حجم الملف أكبر من الحد المسموح"
                    });

                    continue;
                }


                totalSize +=
                    file.data.length;


                if (
                    totalSize >
                    MAX_TOTAL_SIZE
                ) {

                    errors.push({

                        file:
                            file.filename,

                        error:
                            "تم تجاوز الحجم الإجمالي المسموح"
                    });

                    break;
                }


                try {

                    console.log(
                        `[CityCache] decoding ${file.filename} size=${file.data.length} magic=${bufferMagic(file.data)}`
                    );


                    const xml =
                        decodeSaveCity(
                            file.data
                        );


                    const xmlText =
                        xml.toString(
                            "utf8"
                        );


                    const info =
                        extractCityInfo(
                            xmlText,
                            file.filename
                        );


                    cities.push(
                        info
                    );


                    console.log(
                        `[CityCache] OK ${file.filename} | id=${info.cityId} | name=${info.name} | level=${info.level}`
                    );

                } catch (e) {

                    console.error(
                        `[CityCache] FAILED ${file.filename}:`,
                        e.message
                    );


                    errors.push({

                        file:
                            file.filename,

                        error:
                            e.message
                    });
                }
            }


            return res
                .status(200)
                .json({

                    ok:
                        true,

                    count:
                        cities.length,

                    cities:
                        cities,

                    errors:
                        errors
                });


        } catch (e) {

            console.error(
                "[CityCache] city-cache error:",
                e &&
                e.stack
                    ? e.stack
                    : e
            );


            return res
                .status(500)
                .json({

                    ok:
                        false,

                    error:
                        String(
                            e.message ||
                            e
                        )
                });
        }
    }
);


// ============================================================
// API: POST /api/city-select
// ============================================================
//
// يرسل ملف .city واحد
// السيرفر يفكه
// يعدل XML
// ويرجع mGameInfo.xml
//
// ============================================================

router.post(
    "/city-select",

    express.raw({
        type:
            "application/octet-stream",

        limit:
            "50mb"
    }),

    (req, res) => {

        try {

            if (
                !Buffer.isBuffer(
                    req.body
                ) ||
                req.body.length === 0
            ) {

                return res
                    .status(400)
                    .send(
                        "ملف .city فارغ"
                    );
            }


            const filename =
                String(
                    req.headers[
                        "x-city-file"
                    ] ||
                    "selected.city"
                );


            if (
                !/\.city$/i.test(
                    filename
                )
            ) {

                return res
                    .status(400)
                    .send(
                        "الملف يجب أن يكون .city"
                    );
            }


            console.log(
                `[CityCache] selected=${filename} size=${req.body.length} magic=${bufferMagic(req.body)}`
            );


            const xml =
                decodeSaveCity(
                    req.body
                );


            console.log(
                `[CityCache] decoded XML size=${xml.length}`
            );


            const modified =
                editCityXml(
                    xml
                );


            console.log(
                `[CityCache] modified XML size=${modified.length}`
            );


            res.status(200);


            res.set(
                "Content-Type",
                "application/xml; charset=utf-8"
            );


            res.set(
                "Content-Disposition",
                'attachment; filename="mGameInfo.xml"'
            );


            res.set(
                "Cache-Control",
                "no-store"
            );


            return res.send(
                modified
            );


        } catch (e) {

            console.error(
                "[CityCache] city-select error:",
                e &&
                e.stack
                    ? e.stack
                    : e
            );


            return res
                .status(500)
                .send(
                    String(
                        e.message ||
                        e
                    )
                );
        }
    }
);


// ============================================================
// TEST / INFO
// ============================================================

router.get(
    "/city-cache",

    (req, res) => {

        return res.json({

            ok:
                true,

            service:
                "City Cache",

            endpoints: {

                list:
                    "POST /api/city-cache",

                select:
                    "POST /api/city-select"
            }
        });
    }
);


// ============================================================
// EXPORT
// ============================================================

console.log(
    "[CityCache] module loaded"
);

module.exports =
    router;
