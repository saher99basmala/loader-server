"use strict";

const express = require("express");

const fetchCity =
    require("./fetchCity");

const cleaner =
    require("./fetchCityCleaner");

const router =
    express.Router();


// ============================================================
// Independent FetchCity - POST
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
// TEMP GET TEST
// ============================================================

router.get(
    "/test-fetch-city",
    async (req, res) => {

        try {

            const cityId =
                String(
                    req.query.city_id ||
                    ""
                ).trim();

            const cityVer =
                Number(
                    req.query.city_ver || 0
                );

            if (!cityId) {

                return res.status(400).json({
                    ok: false,
                    error: "ضع city_id في الرابط"
                });
            }


            console.log(
                "[TestFetchCity] request:",
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
                "[TestFetchCity] cleaned size:",
                cleaned.length
            );


            // ------------------------------------------------
            // إرسال XML
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
                "[TestFetchCity] ERROR:",
                error
            );

            return res.status(500).json({

                ok: false,

                error:
                    error.message ||
                    "Test FetchCity failed"

            });
        }
    }
);


// ============================================================
// EXPORT
// ============================================================

module.exports = router;
