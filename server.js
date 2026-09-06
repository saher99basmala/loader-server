const express = require("express");
const fetch = require("node-fetch");
const session = require("express-session");

const app = express();

const view = require("./view");
const api = require("./api");

const {
    supabase
} = require("./supabase");

const mGameInfoDecoder =
    require("./mGameInfoDecoder");

const mGameInfoEditor =
    require("./mGameInfoEditor");

app.use(
    "/api",
    fetchCity
);


const PORT =
    process.env.PORT || 3000;

const SECRET =
    process.env.SERVER_SECRET ||
    "MY_SECRET_123";


// ============================================================
// Middleware
// ============================================================

app.use(
    express.urlencoded({
        extended: true
    })
);

app.use(
    express.json({
        limit: "10mb"
    })
);


app.use(
    session({
        secret:
            process.env.SESSION_SECRET ||
            "BS_ADMIN_SECRET",

        resave: false,

        saveUninitialized: false
    })
);


// ============================================================
// الواجهات
// ============================================================

app.use(
    "/",
    view
);

app.use(
    "/api",
    api
);


// ============================================================
// FetchCity Proxy
// ============================================================

app.use(
    "/api/fetch-city",
    fetchCity
);


// ============================================================
// Decode
// ============================================================

app.use(
    "/api/decode",

    express.raw({
        type:
            "application/octet-stream",

        limit:
            "50mb"
    })
);


app.post(
    "/api/decode",

    (req, res) => {

        try {

            const decoded =
                mGameInfoDecoder.decodeFile(
                    req.body
                );


            res.set(
                "Content-Type",
                "application/octet-stream"
            );


            return res.send(
                decoded
            );


        } catch (e) {

            console.error(
                "Decode error:",
                e
            );


            return res.status(400).send(
                "Decode error: " +
                e.message
            );
        }
    }
);


// ============================================================
// Edit
// ============================================================

app.use(
    "/api/edit",

    express.raw({
        type:
            "application/octet-stream",

        limit:
            "50mb"
    })
);


app.post(
    "/api/edit",

    (req, res) => {

        try {

            const editsText =
                req.query.edits;


            if (!editsText) {

                return res.status(400).send(
                    "Missing edits"
                );
            }


            let edits;

            try {

                edits =
                    JSON.parse(
                        editsText
                    );

            } catch (e) {

                return res.status(400).send(
                    "Invalid edits JSON"
                );
            }


            const decoded =
                mGameInfoDecoder.decodeFile(
                    req.body
                );


            const edited =
                mGameInfoEditor.applyEdits(
                    decoded,
                    edits
                );


            res.set(
                "Content-Type",
                "application/octet-stream"
            );


            return res.send(
                edited
            );


        } catch (e) {

            console.error(
                "Edit error:",
                e
            );


            return res.status(400).send(
                "Edit error: " +
                e.message
            );
        }
    }
);


// ============================================================
// Check Key
// ============================================================

app.get(
    "/api/check",

    async (req, res) => {

        try {

            const key =
                req.query.key;

            const deviceid =
                req.query.deviceid;


            if (!key || !deviceid) {

                return res.json({
                    status: "invalid"
                });
            }


            const {
                data: item,
                error
            } =
                await supabase
                    .from("keys")
                    .select("*")
                    .eq("key", key)
                    .single();


            if (error || !item) {

                return res.json({
                    status: "invalid"
                });
            }


            if (
                item.status ===
                "banned"
            ) {

                return res.json({
                    status: "banned"
                });
            }


            if (!item.deviceid) {

                const {
                    error: updateError
                } =
                    await supabase
                        .from("keys")
                        .update({
                            deviceid
                        })
                        .eq(
                            "key",
                            key
                        )
                        .is(
                            "deviceid",
                            null
                        );


                if (updateError) {

                    return res.json({
                        status: "invalid"
                    });
                }


            } else if (
                item.deviceid !==
                deviceid
            ) {

                return res.json({
                    status:
                        "another_device"
                });
            }


            const now =
                new Date();

            const expire =
                new Date(
                    item.expireat
                );


            if (
                expire <= now
            ) {

                await supabase
                    .from("keys")
                    .update({
                        status:
                            "expired"
                    })
                    .eq(
                        "key",
                        key
                    );


                return res.json({
                    status:
                        "expired"
                });
            }


            const diff =
                expire.getTime() -
                now.getTime();


            const days =
                Math.floor(
                    diff /
                    (
                        1000 *
                        60 *
                        60 *
                        24
                    )
                );


            const hours =
                Math.floor(
                    (
                        diff /
                        (
                            1000 *
                            60 *
                            60
                        )
                    ) % 24
                );


            const minutes =
                Math.floor(
                    (
                        diff /
                        (
                            1000 *
                            60
                        )
                    ) % 60
                );


            return res.json({

                status:
                    "active",

                name:
                    item.name,

                days,

                hours,

                minutes
            });


        } catch (e) {

            console.error(
                "Check error:",
                e
            );


            return res.status(500).json({
                status:
                    "error"
            });
        }
    }
);


// ============================================================
// Script
// ============================================================

app.get(
    "/script",

    async (req, res) => {

        if (
            req.query.key !==
            "12345"
        ) {

            return res.send(
                "DENIED"
            );
        }


        if (
            req.headers["x-secret"] !==
            SECRET
        ) {

            return res.send(
                "تم سحب معلومات جهازك بنجاح😉😎"
            );
        }


        try {

            const response =
                await fetch(
                    "https://pastebin.com/raw/uFVCAKm0"
                );


            const script =
                await response.text();


            if (
                !script ||
                script.length < 10
            ) {

                return res.send(
                    "ERROR"
                );
            }


            return res.send(
                script
            );


        } catch (e) {

            console.log(e);

            return res.send(
                "ERROR"
            );
        }
    }
);


// ============================================================
// Health
// ============================================================

app.get(
    "/health",

    (req, res) => {

        res.json({
            status: "ok"
        });
    }
);


// ============================================================
// تشغيل السيرفر
// ============================================================

app.listen(
    PORT,
    "0.0.0.0",

    () => {

        console.log(
            `Server running on port ${PORT}`
        );
    }
);
