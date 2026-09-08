const express = require("express");

const router = express.Router();

const DesbanEngine =
    require("./DesbanEngine");


// ============================================================
// DESBAN
// ============================================================

router.post(
    "/desban",

    async (req, res) => {

        try {

            const {
                myXml,
                friendXml
            } = req.body;


            if (!myXml || !friendXml) {

                return res.status(400).json({

                    status: "error",

                    message:
                        "myXml و friendXml مطلوبان"

                });
            }


            const engine =
                new DesbanEngine();


            const result =
                engine.applyDesban(
                    myXml,
                    friendXml
                );


            return res.json({

                status: "success",

                xml:
                    result.xml,

                logs:
                    result.logs || []

            });


        } catch (e) {

            console.error(
                "[Desban] Error:",
                e
            );


            return res.status(500).json({

                status: "error",

                message:
                    e.message

            });
        }
    }
);


module.exports = router;
