"use strict";

const express = require("express");

const fetchCity =
    require("./fetchCity");

const cleaner =
    require("./fetchCityCleaner");

const router =
    express.Router();


// ============================================================
// Independent FetchCity
// ============================================================

router.post(
    "/independent-fetch-city",
    async (req, res) => {

        try {

            const cityId =
                String(
                    req.body.city_id ||
                    ""
                ).trim();

            const cityVer =
                Number(
                    req.body.city_ver || 0
                );

            if (!cityId) {

                return res.status(400).json({
                    ok: false,
                    error: "city_id مطلوب"
                });
            }


            console.log(
                "[IndependentFetchCity] request:",
                cityId
            );


            // ------------------------------------------------
            // Fetch من خادم اللعبة
            // ------------------------------------------------

            const json =
                await fetchCity.requestFetchCity(
                    cityId,
                    cityVer
                );


            if (
                !json ||
                !json.result ||
                !json.result.data
            ) {

                throw new Error(
                    "FetchCity result.data غير موجود"
                );
            }


            // ------------------------------------------------
            // فك بيانات FetchCity
            // ------------------------------------------------

            const xml =
                await fetchCity.decodeSaveCity(
                    json.result.data
                );


            if (!xml) {

                throw new Error(
                    "لم يتم الحصول على XML"
                );
            }


            // ------------------------------------------------
            // تنظيف XML
            // ------------------------------------------------

            const cleaned =
                cleaner.cleanFetchCityXml(
                    xml
                );


            console.log(
                "[IndependentFetchCity] cleaned size:",
                cleaned.length
            );


            // ------------------------------------------------
            // إرسال XML للمستخدم
            // ------------------------------------------------

            res.set(
                "Content-Type",
                "application/xml; charset=utf-8"
            );

            return res.send(
                cleaned
            );

        } catch (error) {

            console.error(
                "[IndependentFetchCity] ERROR:",
                error
            );

            return res.status(500).json({

                ok: false,

                error:
                    error.message ||
                    "Independent FetchCity failed"

            });
        }
    }
);


// ============================================================
// EXPORT
// ============================================================

module.exports = router;
