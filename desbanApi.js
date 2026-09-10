/*
============================================================
desbanApi.js
============================================================

Node/Express implementation of the XML operations exposed by
DesbanEngine.

Mounted from server.js with:

app.use("/api", desbanApi);

Endpoints:

POST /api/desban          -> Etapa1
POST /api/desban/full     -> Etapa1 + Etapa2 + Etapa3 + Extras
POST /api/desban/etapa1
POST /api/desban/etapa2
POST /api/desban/etapa3

GET /api/desban/health

Accepted JSON:

{
    "myXml": "...",
    "friendXml": "..."
}

Aliases:

targetXml/sourceXml
xml/friend

Missing XML sections are optional.
They are skipped and NEVER converted into HTTP 500 errors.

XML is edited as text so existing formatting and attributes
are preserved.
*/

const express = require("express");
const router = express.Router();


// ============================================================
// Static data taken from DesbanEngine
// ============================================================

const PROGRESS_VARS = [
    "money",
    "moneyCash",
    "EarnedCoins",
    "residents",
    "wheatCounter",
    "plowFieldsAchiev",
    "defaultOrdersCount",
    "match3Life",
    "Match3Lives_infTime",
    "Achievement_IncreasedPopulation",
    "Achievement_PlowedFields",
    "Achievement_BuiltFactories",
    "Achievement_SpentCoins",
    "Achievement_EarneCoins",
    "spentCash",
    "earnedCash",
    "timeInGame"
];


const CLONE_BLOCKS_ETAPA2 = [
    "Zoo",
    "ZooInfo",
    "ZooQuests"
];


const CLONE_BLOCKS_ETAPA3 = [
    "Trains",
    "IslandsInfo",
    "Minigames",
    "DSCollapseQuests",
    "QuestsBook",
    "DSCollection",
    "MapOrders",
    "Helic",
    "SeasonTicket",
    "LevelInfo"
];


const OPTIONAL_PAIR_BLOCKS = [
    ["AirInfo", "AirOrders"]
];


const MY_VARS = [
    "MyBadge",
    "MyPicture",
    "MyTheme",
    "MyFrame",
    "MyStyle",
    "townName"
];


const MATCH3_VARS = [
    "m3Line",
    "m3Bomb",
    "m3RainbowBall",
    "m3Mallet",
    "m3HorizontalLine",
    "m3VerticalLine",
    "m3Reshuffle"
];


const COUPON_IDS = [
    "HireDealer",
    "LoadTrainAirport",
    "UpgradeFactory",
    "UpgradeTrain",
    "UpgradeIsland"
];


const BARN_ITEM_BLOCKLIST = new Set([
    "BronzeBullion",
    "SilverBullion",
    "GoldBullion",
    "PlatinumBullion"
]);


/*
============================================================
Achievement rewards
============================================================
*/

const ACHIEVEMENT_REWARDS = [
    "marketBoom",
    "miner",
    "earthCenter",
    "strategyReserv",
    "factoryUpgrader",
    "collector",
    "teamwork",
    "casinoGame",
    "sendShips",
    "islandGoods",
    "collectBacon",
    "collectHoney",
    "collectorIslands",
    "progressWave",
    "downFeather",
    "metropolis",
    "community_developer",
    "entrepreneur",
    "lead_Architect",
    "population_boom",
    "construction_manager",
    "endless_fields",
    "magnate",
    "wacky_farmer",
    "urbanist_club",
    "honorary_freeman",
    "senior_train_driver",
    "road_champ",
    "production_genius",
    "customer_service_pro",
    "model_chicken_coop",
    "milky_way",
    "mushroom",
    "wool_art",
    "seaweed",
    "donate",
    "regataChampion",
    "match3_achievement"
];


// ============================================================
// EXTRA variables requested from mGameInfoEditor
// Only the XML names are used.
// No editor functions or editor logic are copied.
// ============================================================

const EXTRA_VARS = [
    "townName",
    "Achievement_Teamwork",
    "FirstAttemptM3Levels",
    "FullCardCollections",
    "LivesSent",
    "m3_comp_lvls",
    "RegataTasksCompleted",
    "levelup",
    "NewChatEmoji",
    "UnlockedChatEmoji"
];


const EXTRA_DATAELEMS = [
    "UnlockedFrames",
    "UnlockedStyles",
    "UnlockedExpRanks",
    "OwnedCards"
];


// ============================================================
// General helpers
// ============================================================

function asString(value) {
    return typeof value === "string" ? value : "";
}


function firstNonEmpty(...values) {
    for (const value of values) {
        if (typeof value === "string" && value.length > 0) {
            return value;
        }
    }

    return "";
}


function escapeRegExp(value) {
    return String(value).replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}


function hasRoot(xml) {
    return (
        /<root\b[^>]*>/i.test(xml) &&
        /<\/root\s*>/i.test(xml)
    );
}


function ensureXml(xml, label) {
    if (!xml || typeof xml !== "string") {
        throw new Error(`${label} XML غير موجود`);
    }

    if (!hasRoot(xml)) {
        throw new Error(`${label} XML لا يحتوي root صالح`);
    }
}


function logSkip(message) {
    console.log(`[Desban] SKIP: ${message}`);
}


// ============================================================
// Generic XML block helpers
// ============================================================

function findFirstBodyBlock(xml, tagName) {
    if (!xml) return null;

    const openRe = new RegExp(
        `<${escapeRegExp(tagName)}\\b[^>]*>`,
        "ig"
    );

    let om;

    while ((om = openRe.exec(xml)) !== null) {

        if (/\/\s*>$/.test(om[0])) {
            continue;
        }

        const closeRe = new RegExp(
            `</${escapeRegExp(tagName)}\\s*>`,
            "i"
        );

        const tail = xml.slice(
            om.index + om[0].length
        );

        const cm = closeRe.exec(tail);

        if (!cm) {
            continue;
        }

        const end =
            om.index +
            om[0].length +
            cm.index +
            cm[0].length;

        return {
            start: om.index,
            end,
            text: xml.slice(om.index, end)
        };
    }

    return null;
}


function findFirstSelfClosing(xml, tagName) {
    if (!xml) return null;

    const re = new RegExp(
        `<${escapeRegExp(tagName)}\\b[^>]*/\\s*>`,
        "i"
    );

    const m = re.exec(xml);

    return m
        ? {
            start: m.index,
            end: m.index + m[0].length,
            text: m[0]
        }
        : null;
}


function extractTagBlock(xml, tagName) {
    const body = findFirstBodyBlock(xml, tagName);

    if (body) {
        return body.text;
    }

    const self = findFirstSelfClosing(xml, tagName);

    return self ? self.text : null;
}


function replaceFirstTagBlock(target, tagName, replacement) {

    const body = findFirstBodyBlock(
        target,
        tagName
    );

    if (body) {
        return (
            target.slice(0, body.start) +
            replacement +
            target.slice(body.end)
        );
    }

    const self = findFirstSelfClosing(
        target,
        tagName
    );

    if (self) {
        return (
            target.slice(0, self.start) +
            replacement +
            target.slice(self.end)
        );
    }

    return null;
}


function insertBeforeClosing(target, tagName, block) {

    const close = new RegExp(
        `</${escapeRegExp(tagName)}\\s*>`,
        "i"
    );

    const match = close.exec(target);

    if (!match) {
        return null;
    }

    return (
        target.slice(0, match.index) +
        block +
        match[0] +
        target.slice(match.index + match[0].length)
    );
}


// ============================================================
// Stats / duplicate protection
// ============================================================

function markCopied(stats, key) {
    if (!stats || !stats.copied) {
        return false;
    }

    if (stats.copied.has(key)) {
        return true;
    }

    stats.copied.add(key);
    return false;
}


// ============================================================
// Generic cloneBlock
// ============================================================

function cloneBlock(
    src,
    target,
    tagName,
    stats,
    options = {}
) {

    const copyKey = `Block:${tagName}`;

    if (markCopied(stats, copyKey)) {
        return target;
    }

    const block = extractTagBlock(
        src,
        tagName
    );

    if (!block) {
        logSkip(
            `${tagName}: القسم غير موجود في XML المصدر`
        );

        stats.skipped.push(tagName);

        return target;
    }

    const replaced = replaceFirstTagBlock(
        target,
        tagName,
        block
    );

    if (replaced !== null) {

        stats.replaced.push(tagName);

        return replaced;
    }

    const globalClose = /<\/Global\s*>/i;

    if (globalClose.test(target)) {

        target = target.replace(
            globalClose,
            block + "</Global>"
        );

        stats.inserted.push(tagName);

        return target;
    }

    const rootClose = /<\/root\s*>/i;

    if (rootClose.test(target)) {

        target = target.replace(
            rootClose,
            block + "</root>"
        );

        stats.inserted.push(tagName);

        return target;
    }

    stats.skipped.push(tagName);

    logSkip(
        `${tagName}: لم يتم العثور على نقطة إدراج`
    );

    return target;
}


// ============================================================
// Var helpers
// ============================================================

function findVar(xml, name) {

    if (!xml) {
        return null;
    }

    const pattern = new RegExp(
        `<Var\\s+name="${escapeRegExp(name)}"[^>]*/\\s*>`,
        "i"
    );

    const m = pattern.exec(xml);

    return m ? m[0] : null;
}


function getVarValue(xml, name) {

    const tag = findVar(xml, name);

    if (!tag) {
        return null;
    }

    const m = /\bv="([^"]*)"/i.exec(tag);

    return m ? m[1] : null;
}


function getVarType(xml, name) {

    const tag = findVar(xml, name);

    if (!tag) {
        return null;
    }

    const m = /\bt="([^"]*)"/i.exec(tag);

    return m ? m[1] : null;
}


function upsertVar(
    xml,
    name,
    value,
    type = "i",
    stats = null
) {

    const newTag =
        `<Var name="${name}" v="${String(value).replace(/"/g, "&quot;")}" t="${type}"/>`;

    const pattern = new RegExp(
        `<Var\\s+name="${escapeRegExp(name)}"[^>]*/\\s*>`,
        "i"
    );

    if (pattern.test(xml)) {

        if (stats) {
            stats.updatedVars.push(name);
        }

        return xml.replace(
            pattern,
            () => newTag
        );
    }

    const globalClose = /<\/Global\s*>/i;

    if (globalClose.test(xml)) {

        if (stats) {
            stats.createdVars.push(name);
        }

        return xml.replace(
            globalClose,
            newTag + "</Global>"
        );
    }

    const rootClose = /<\/root\s*>/i;

    if (rootClose.test(xml)) {

        if (stats) {
            stats.createdVars.push(name);
        }

        return xml.replace(
            rootClose,
            newTag + "</root>"
        );
    }

    if (stats) {
        stats.skipped.push(`Var:${name}`);
    }

    return xml;
}


function copyVar(
    src,
    target,
    name,
    stats
) {

    const copyKey = `Var:${name}`;

    if (markCopied(stats, copyKey)) {
        return target;
    }

    const sourceTag = findVar(
        src,
        name
    );

    if (!sourceTag) {

        logSkip(
            `Var ${name}: غير موجود في XML المصدر`
        );

        stats.skipped.push(copyKey);

        return target;
    }

    const pattern = new RegExp(
        `<Var\\s+name="${escapeRegExp(name)}"[^>]*/\\s*>`,
        "i"
    );

    if (pattern.test(target)) {

        stats.updatedVars.push(name);

        return target.replace(
            pattern,
            () => sourceTag
        );
    }

    const globalClose = /<\/Global\s*>/i;

    if (globalClose.test(target)) {

        stats.createdVars.push(name);

        return target.replace(
            globalClose,
            sourceTag + "</Global>"
        );
    }

    const rootClose = /<\/root\s*>/i;

    if (rootClose.test(target)) {

        stats.createdVars.push(name);

        return target.replace(
            rootClose,
            sourceTag + "</root>"
        );
    }

    logSkip(
        `Var ${name}: لا توجد نقطة إدراج`
    );

    stats.skipped.push(copyKey);

    return target;
}


// ============================================================
// DataElem helpers
//
// Used for:
// UnlockedFrames
// UnlockedStyles
// UnlockedExpRanks
// OwnedCards
// ============================================================

function extractNamedDataElem(
    xml,
    name
) {

    if (!xml) {
        return null;
    }

    const openRe = new RegExp(
        `<DataElem\\s+name="${escapeRegExp(name)}"\\b[^>]*>`,
        "i"
    );

    const selfRe = new RegExp(
        `<DataElem\\s+name="${escapeRegExp(name)}"\\b[^>]*/\\s*>`,
        "i"
    );

    const self = selfRe.exec(xml);

    if (self) {
        return self[0];
    }

    const open = openRe.exec(xml);

    if (!open) {
        return null;
    }

    const closeRe = /<\/DataElem\s*>/gi;

    closeRe.lastIndex =
        open.index + open[0].length;

    const close = closeRe.exec(xml);

    if (!close) {
        return null;
    }

    return xml.slice(
        open.index,
        close.index + close[0].length
    );
}


function replaceNamedDataElem(
    target,
    name,
    replacement
) {

    const openRe = new RegExp(
        `<DataElem\\s+name="${escapeRegExp(name)}"\\b[^>]*>`,
        "i"
    );

    const selfRe = new RegExp(
        `<DataElem\\s+name="${escapeRegExp(name)}"\\b[^>]*/\\s*>`,
        "i"
    );

    const self = selfRe.exec(target);

    if (self) {

        return (
            target.slice(0, self.index) +
            replacement +
            target.slice(
                self.index + self[0].length
            )
        );
    }

    const open = openRe.exec(target);

    if (!open) {
        return null;
    }

    const closeRe = /<\/DataElem\s*>/gi;

    closeRe.lastIndex =
        open.index + open[0].length;

    const close = closeRe.exec(target);

    if (!close) {
        return null;
    }

    const end =
        close.index + close[0].length;

    return (
        target.slice(0, open.index) +
        replacement +
        target.slice(end)
    );
}


function copyDataElem(
    src,
    target,
    name,
    stats
) {

    const copyKey = `DataElem:${name}`;

    if (markCopied(stats, copyKey)) {
        return target;
    }

    const sourceElem =
        extractNamedDataElem(
            src,
            name
        );

    if (!sourceElem) {

        logSkip(
            `DataElem ${name}: غير موجود في XML المصدر`
        );

        stats.skipped.push(copyKey);

        return target;
    }

    const replaced =
        replaceNamedDataElem(
            target,
            name,
            sourceElem
        );

    if (replaced !== null) {

        stats.replaced.push(
            `DataElem:${name}`
        );

        return replaced;
    }

    /*
    Prefer inserting into Global when it exists.
    Otherwise insert before root closing.
    */

    const globalClose =
        /<\/Global\s*>/i;

    if (globalClose.test(target)) {

        stats.inserted.push(
            `DataElem:${name}`
        );

        return target.replace(
            globalClose,
            sourceElem + "</Global>"
        );
    }

    const rootClose =
        /<\/root\s*>/i;

    if (rootClose.test(target)) {

        stats.inserted.push(
            `DataElem:${name}`
        );

        return target.replace(
            rootClose,
            sourceElem + "</root>"
        );
    }

    logSkip(
        `DataElem ${name}: لا توجد نقطة إدراج`
    );

    stats.skipped.push(copyKey);

    return target;
}


// ============================================================
// Avatar discovery
//
// Only XML names are discovered.
// No editor logic is used.
// ============================================================

function findAvatarVarNames(xml) {

    const result = [];

    if (!xml) {
        return result;
    }

    const global =
        extractTagBlock(
            xml,
            "Global"
        );

    if (!global) {
        return result;
    }

    const re =
        /<Var\s+name="((?:Unlocked_ava|MigrateUnlocked_ava)[^"]*)"\b[^>]*\/\s*>/gi;

    let m;

    while ((m = re.exec(global)) !== null) {

        if (!result.includes(m[1])) {
            result.push(m[1]);
        }
    }

    return result;
}


// ============================================================
// Requested extras
// ============================================================

function copyRequestedExtras(
    src,
    target,
    stats
) {

    /*
    --------------------------------------------------------
    1. Requested Vars
    --------------------------------------------------------
    */

    for (const name of EXTRA_VARS) {

        target = copyVar(
            src,
            target,
            name,
            stats
        );
    }


    /*
    --------------------------------------------------------
    2. Requested DataElem blocks
    --------------------------------------------------------
    */

    for (const name of EXTRA_DATAELEMS) {

        target = copyDataElem(
            src,
            target,
            name,
            stats
        );
    }


    /*
    --------------------------------------------------------
    3. Avatars
    --------------------------------------------------------

    Discover every avatar Var actually present in the
    donor XML.

    Examples:

    Unlocked_ava1
    Unlocked_ava2
    MigrateUnlocked_ava1
    MigrateUnlocked_ava2

    Nothing is invented.
    */

    const avatars =
        findAvatarVarNames(src);

    for (const name of avatars) {

        target = copyVar(
            src,
            target,
            name,
            stats
        );
    }


    return target;
}


// ============================================================
// Upgrade
// ============================================================

function cloneUpgradeBlock(
    src,
    target,
    stats
) {

    return cloneBlock(
        src,
        target,
        "Upgrade",
        stats
    );
}


// ============================================================
// Etapa 1
// ============================================================

function applyEtapa1(
    myXml,
    friendXml,
    stats
) {

    let result = myXml;


    /*
    Exact PROGRESS_VARS list.
    */

    for (const name of PROGRESS_VARS) {

        result = copyVar(
            friendXml,
            result,
            name,
            stats
        );
    }


    /*
    levelup + experience + sexpx
    */

    const levelup =
        getVarValue(
            friendXml,
            "levelup"
        );

    const experience =
        getVarValue(
            friendXml,
            "experience"
        );


    if (
        levelup !== null &&
        experience !== null
    ) {

        result = upsertVar(
            result,
            "levelup",
            levelup,
            getVarType(
                friendXml,
                "levelup"
            ) || "i",
            stats
        );


        result = upsertVar(
            result,
            "experience",
            experience,
            getVarType(
                friendXml,
                "experience"
            ) || "i",
            stats
        );


        const expNumber =
            Number.parseInt(
                experience,
                10
            );


        if (Number.isFinite(expNumber)) {

            const sexpx =
                (expNumber ^ 0x1e5d6a06) >>> 0;


            result = upsertVar(
                result,
                "sexpx",
                String(sexpx),
                "i",
                stats
            );

        } else {

            logSkip(
                "sexpx: experience ليست قيمة رقمية"
            );

            stats.skipped.push(
                "sexpx"
            );
        }

    } else {

        if (levelup === null) {

            logSkip(
                "levelup: غير موجود في المصدر"
            );

            stats.skipped.push(
                "levelup"
            );
        }

        if (experience === null) {

            logSkip(
                "experience: غير موجود في المصدر"
            );

            stats.skipped.push(
                "experience"
            );
        }
    }


    return result;
}


// ============================================================
// Etapa 2
// ============================================================

function extractUserId(xml) {

    const m =
        /<Object\b[^>]*\buser="([^"]+)"/i.exec(
            xml || ""
        );

    return m ? m[1] : "";
}


function positionAfterFirstClosing(
    xml,
    tagName
) {

    if (!xml) {
        return -1;
    }

    const close =
        new RegExp(
            `</${escapeRegExp(tagName)}\\s*>`,
            "i"
        );

    const m =
        close.exec(xml);

    return m
        ? m.index + m[0].length
        : -1;
}


function extractBlockAfter(
    xml,
    tagName,
    fromPos
) {

    if (
        !xml ||
        fromPos < 0
    ) {
        return null;
    }

    const tail =
        xml.slice(fromPos);

    const open =
        new RegExp(
            `<${escapeRegExp(tagName)}\\b[^>]*>`,
            "i"
        );

    const om =
        open.exec(tail);

    if (!om) {
        return null;
    }

    const close =
        new RegExp(
            `</${escapeRegExp(tagName)}\\s*>`,
            "i"
        );

    const cm =
        close.exec(
            tail.slice(
                om.index +
                om[0].length
            )
        );

    if (!cm) {
        return null;
    }

    const start =
        fromPos + om.index;

    const end =
        fromPos +
        om.index +
        om[0].length +
        cm.index +
        cm[0].length;

    return {
        start,
        end,
        text: xml.slice(start, end)
    };
}


function cloneTownAndBuildings(
    src,
    target,
    stats
) {

    const srcAfterZoo =
        positionAfterFirstClosing(
            src,
            "Zoo"
        );

    const tgtAfterZoo =
        positionAfterFirstClosing(
            target,
            "Zoo"
        );


    if (
        srcAfterZoo < 0 ||
        tgtAfterZoo < 0
    ) {

        logSkip(
            "TownGround+Buildings: Zoo غير موجود"
        );

        stats.skipped.push(
            "TownGround+Buildings"
        );

        return target;
    }


    const srcTg =
        extractBlockAfter(
            src,
            "TownGround",
            srcAfterZoo
        );


    if (!srcTg) {

        logSkip(
            "TownGround+Buildings: المصدر لا يحتوي TownGround بعد Zoo"
        );

        stats.skipped.push(
            "TownGround+Buildings"
        );

        return target;
    }


    const srcBld =
        extractBlockAfter(
            src,
            "Buildings",
            srcTg.start
        );


    if (!srcBld) {

        logSkip(
            "TownGround+Buildings: المصدر لا يحتوي Buildings"
        );

        stats.skipped.push(
            "TownGround+Buildings"
        );

        return target;
    }


    const bldInsideTownGround =
        srcBld.start >= srcTg.start &&
        srcBld.end <= srcTg.end;


    let srcTown =
        srcTg.text;

    let srcBuildings =
        srcBld.text;


    const srcUser =
        extractUserId(src);

    const tgtUser =
        extractUserId(target);


    if (
        srcUser &&
        tgtUser &&
        srcUser !== tgtUser
    ) {

        const userRe =
            new RegExp(
                `user="${escapeRegExp(srcUser)}"`,
                "g"
            );

        srcTown =
            srcTown.replace(
                userRe,
                `user="${tgtUser}"`
            );

        srcBuildings =
            srcBuildings.replace(
                userRe,
                `user="${tgtUser}"`
            );
    }


    const tgtTg =
        extractBlockAfter(
            target,
            "TownGround",
            tgtAfterZoo
        );


    if (!tgtTg) {

        logSkip(
            "TownGround+Buildings: الهدف لا يحتوي TownGround بعد Zoo"
        );

        stats.skipped.push(
            "TownGround+Buildings"
        );

        return target;
    }


    if (bldInsideTownGround) {

        const before =
            target.slice(
                0,
                tgtTg.start
            );

        const after =
            target.slice(
                tgtTg.end
            );

        stats.replaced.push(
            "TownGround"
        );

        stats.replaced.push(
            "Buildings"
        );

        return (
            before +
            srcTown +
            after
        );
    }


    const tgtBld =
        extractBlockAfter(
            target,
            "Buildings",
            tgtTg.end
        );


    if (!tgtBld) {

        const before =
            target.slice(
                0,
                tgtTg.start
            );

        const after =
            target.slice(
                tgtTg.end
            );

        stats.inserted.push(
            "Buildings"
        );

        stats.replaced.push(
            "TownGround"
        );

        return (
            before +
            srcTown +
            "\n" +
            srcBuildings +
            after
        );
    }


    let out =
        target;


    out =
        out.slice(
            0,
            tgtBld.start
        ) +
        srcBuildings +
        out.slice(
            tgtBld.end
        );


    out =
        out.slice(
            0,
            tgtTg.start
        ) +
        srcTown +
        out.slice(
            tgtTg.end
        );


    stats.replaced.push(
        "TownGround"
    );

    stats.replaced.push(
        "Buildings"
    );


    return out;
}


function cloneGlobalVarsECoupons(
    src,
    target,
    stats
) {

    for (const name of MATCH3_VARS) {

        target = copyVar(
            src,
            target,
            name,
            stats
        );
    }


    /*
    Coupon variables can have different names
    between save versions.
    */

    for (const id of COUPON_IDS) {

        const candidates = [
            `coupon_${id}`,
            `Coupon_${id}`,
            `coupon${id}`,
            id
        ];


        let found = false;


        for (const name of candidates) {

            if (findVar(src, name)) {

                target =
                    copyVar(
                        src,
                        target,
                        name,
                        stats
                    );

                found = true;

                break;
            }
        }


        if (!found) {

            logSkip(
                `Coupon ${id}: غير موجود`
            );
        }
    }


    return target;
}


function applyEtapa2(
    myXml,
    friendXml,
    stats
) {

    let result =
        myXml;


    result =
        cloneTownAndBuildings(
            friendXml,
            result,
            stats
        );


    result =
        cloneGlobalVarsECoupons(
            friendXml,
            result,
            stats
        );


    for (
        const tag of CLONE_BLOCKS_ETAPA2
    ) {

        result =
            cloneBlock(
                friendXml,
                result,
                tag,
                stats
            );
    }


    return result;
}


// ============================================================
// Etapa 3 helpers
// ============================================================

function cloneGlobalBlock(
    src,
    target,
    stats
) {

    const sourceGlobal =
        extractTagBlock(
            src,
            "Global"
        );

    const targetGlobal =
        extractTagBlock(
            target,
            "Global"
        );


    if (
        !sourceGlobal ||
        !targetGlobal
    ) {

        logSkip(
            "Global: القسم غير موجود"
        );

        stats.skipped.push(
            "Global"
        );

        return target;
    }


    let newGlobal =
        targetGlobal;


    for (
        const name of MY_VARS
    ) {

        /*
        Avoid duplicate copying because these Vars
        may already have been copied by Etapa1/Etapa2.
        */

        const sourceVar =
            findVar(
                sourceGlobal,
                name
            );


        if (!sourceVar) {

            logSkip(
                `Global Var ${name}: غير موجود في المصدر`
            );

            stats.skipped.push(
                `Global:${name}`
            );

            continue;
        }


        const p =
            new RegExp(
                `<Var\\s+name="${escapeRegExp(name)}"[^>]*/\\s*>`,
                "i"
            );


        if (p.test(newGlobal)) {

            newGlobal =
                newGlobal.replace(
                    p,
                    () => sourceVar
                );

            stats.updatedVars.push(
                `Global:${name}`
            );

        } else {

            newGlobal =
                newGlobal.replace(
                    /<\/Global\s*>/i,
                    () =>
                        sourceVar +
                        "</Global>"
                );

            stats.createdVars.push(
                `Global:${name}`
            );
        }
    }


    const globalPattern =
        /<Global\b[^>]*>[\s\S]*?<\/Global\s*>/i;


    return target.replace(
        globalPattern,
        () => newGlobal
    );
}


function cloneBarnItems(
    src,
    target,
    stats
) {

    const sourceGlobal =
        extractTagBlock(
            src,
            "Global"
        );


    if (!sourceGlobal) {

        logSkip(
            "BarnItems: Global غير موجود في المصدر"
        );

        stats.skipped.push(
            "BarnItems"
        );

        return target;
    }


    const varRegex =
        /<Var\s+name="([^"]+)"\b[^>]*\/\s*>/gi;

    let m;


    while (
        (m = varRegex.exec(sourceGlobal)) !== null
    ) {

        const name =
            m[1];


        if (
            BARN_ITEM_BLOCKLIST.has(name)
        ) {
            continue;
        }


        const looksLikeBarn =
            /^(barn|item|storage|stash|warehouse)/i.test(name) ||
            /(^|_)(count|counter|amount|quantity)$/i.test(name);


        if (!looksLikeBarn) {
            continue;
        }


        target =
            copyVar(
                src,
                target,
                name,
                stats
            );
    }


    return target;
}


function cloneMatch3AdvantagesBoosters(
    src,
    target,
    stats
) {

    /*
    Explicit Match3 variables.
    */

    for (
        const name of MATCH3_VARS
    ) {

        target =
            copyVar(
                src,
                target,
                name,
                stats
            );
    }


    const allNames =
        new Set();


    const sourceGlobal =
        extractTagBlock(
            src,
            "Global"
        );


    if (sourceGlobal) {

        const re =
            /<Var\s+name="([^"]+)"\b[^>]*\/\s*>/gi;

        let m;


        while (
            (m = re.exec(sourceGlobal)) !== null
        ) {

            if (
                /^(Match3|m3)/i.test(
                    m[1]
                )
            ) {

                allNames.add(
                    m[1]
                );
            }
        }
    }


    for (
        const name of allNames
    ) {

        target =
            copyVar(
                src,
                target,
                name,
                stats
            );
    }


    return target;
}


function cloneAlterarQuantidadeVars(
    src,
    target,
    stats
) {

    const sourceGlobal =
        extractTagBlock(
            src,
            "Global"
        );


    if (!sourceGlobal) {

        logSkip(
            "AlterarQuantidadeVars: Global غير موجود"
        );

        return target;
    }


    const re =
        /<Var\s+name="([^"]+)"\b[^>]*\/\s*>/gi;

    let m;


    while (
        (m = re.exec(sourceGlobal)) !== null
    ) {

        const name =
            m[1];


        if (
            /(quantidade|quantity|amount|count|counter)/i.test(name) &&
            /(m3|match3|coupon|boost|booster|advantage|item)/i.test(name)
        ) {

            target =
                copyVar(
                    src,
                    target,
                    name,
                    stats
                );
        }
    }


    return target;
}


function cloneArtInfo(
    src,
    target,
    stats
) {

    return cloneBlock(
        src,
        target,
        "ArtInfo",
        stats
    );
}


function cloneAirInfoAndOrders(
    src,
    target,
    stats
) {

    for (
        const [a, b] of OPTIONAL_PAIR_BLOCKS
    ) {

        target =
            cloneBlock(
                src,
                target,
                a,
                stats
            );

        target =
            cloneBlock(
                src,
                target,
                b,
                stats
            );
    }


    return target;
}


function cloneDailyBonus(
    src,
    target,
    stats
) {

    return cloneBlock(
        src,
        target,
        "DailyBonus",
        stats
    );
}


function processUnlockAchievements(
    xml,
    stats
) {

    const present =
        new Set();


    const rewardRe =
        /AchReward_([A-Za-z0-9_]+)/g;

    let m;


    while (
        (m = rewardRe.exec(xml)) !== null
    ) {

        present.add(
            m[1]
        );
    }


    const all =
        new Set([
            ...ACHIEVEMENT_REWARDS,
            ...present
        ]);


    let out =
        xml;


    for (
        const id of all
    ) {

        const name =
            `AchReward_${id}`;


        const tag =
            `<Var name="${name}" v="4" t="i"/>`;


        const pattern =
            new RegExp(
                `<Var\\s+name="${escapeRegExp(name)}"[^>]*/\\s*>`,
                "i"
            );


        if (
            pattern.test(out)
        ) {

            out =
                out.replace(
                    pattern,
                    () => tag
                );

            stats.updatedVars.push(
                name
            );

        } else {

            const globalClose =
                /<\/Global\s*>/i;


            if (
                globalClose.test(out)
            ) {

                out =
                    out.replace(
                        globalClose,
                        () =>
                            tag +
                            "</Global>"
                    );

                stats.createdVars.push(
                    name
                );

            } else {

                logSkip(
                    `${name}: لا توجد Global`
                );

                stats.skipped.push(
                    name
                );
            }
        }
    }


    return out;
}


// ============================================================
// Etapa 3
// ============================================================

function applyEtapa3(
    myXml,
    friendXml,
    stats
) {

    let result =
        myXml;


    /*
    --------------------------------------------------------
    ArtInfo
    --------------------------------------------------------
    */

    result =
        cloneArtInfo(
            friendXml,
            result,
            stats
        );


    /*
    --------------------------------------------------------
    Main Etapa3 blocks
    --------------------------------------------------------
    */

    for (
        const tag of CLONE_BLOCKS_ETAPA3
    ) {

        result =
            cloneBlock(
                friendXml,
                result,
                tag,
                stats
            );
    }


    /*
    --------------------------------------------------------
    Upgrade
    --------------------------------------------------------
    */

    result =
        cloneUpgradeBlock(
            friendXml,
            result,
            stats
        );


    /*
    --------------------------------------------------------
    Match3
    --------------------------------------------------------
    */

    result =
        cloneMatch3AdvantagesBoosters(
            friendXml,
            result,
            stats
        );


    /*
    --------------------------------------------------------
    Quantity variables
    --------------------------------------------------------
    */

    result =
        cloneAlterarQuantidadeVars(
            friendXml,
            result,
            stats
        );


    /*
    --------------------------------------------------------
    Air
    --------------------------------------------------------
    */

    result =
        cloneAirInfoAndOrders(
            friendXml,
            result,
            stats
        );


    /*
    --------------------------------------------------------
    DailyBonus
    --------------------------------------------------------
    */

    result =
        cloneDailyBonus(
            friendXml,
            result,
            stats
        );


    /*
    --------------------------------------------------------
    Barn
    --------------------------------------------------------
    */

    result =
        cloneBarnItems(
            friendXml,
            result,
            stats
        );


    /*
    --------------------------------------------------------
    Global
    --------------------------------------------------------
    */

    result =
        cloneGlobalBlock(
            friendXml,
            result,
            stats
        );


    /*
    --------------------------------------------------------
    Achievement rewards
    --------------------------------------------------------
    */

    result =
        processUnlockAchievements(
            result,
            stats
        );


    /*
    --------------------------------------------------------
    Match3 / coupons again
    --------------------------------------------------------

    copyVar has duplicate protection, therefore variables
    already copied earlier are not duplicated.
    */

    result =
        cloneGlobalVarsECoupons(
            friendXml,
            result,
            stats
        );


    return result;
}


// ============================================================
// Pipeline stats
// ============================================================

function createStats() {

    return {

        updatedVars: [],
        createdVars: [],

        replaced: [],
        inserted: [],

        skipped: [],
        errors: [],

        /*
        Internal Set used to prevent duplicate copies.
        It is removed before JSON response.
        */

        copied: new Set()
    };
}


function dedupeStats(stats) {

    for (
        const key of Object.keys(stats)
    ) {

        if (
            Array.isArray(stats[key])
        ) {

            stats[key] =
                [...new Set(
                    stats[key]
                )];
        }
    }


    /*
    copied is internal and should not be
    returned as a Set in JSON.
    */

    delete stats.copied;


    return stats;
}


// ============================================================
// Pipeline
// ============================================================

function runStage(
    stage,
    myXml,
    friendXml
) {

    ensureXml(
        myXml,
        "الهدف"
    );

    ensureXml(
        friendXml,
        "المصدر"
    );


    const stats =
        createStats();


    let result =
        myXml;


    if (stage === 1) {

        result =
            applyEtapa1(
                result,
                friendXml,
                stats
            );

    } else if (stage === 2) {

        result =
            applyEtapa2(
                result,
                friendXml,
                stats
            );

    } else if (stage === 3) {

        result =
            applyEtapa3(
                result,
                friendXml,
                stats
            );

    } else if (stage === "full") {

        /*
        ====================================================
        FULL PIPELINE
        ====================================================

        IMPORTANT:

        Here we use the COMPLETE existing Etapa3.

        We do NOT replace it with a reduced version.
        */


        result =
            applyEtapa1(
                result,
                friendXml,
                stats
            );


        result =
            applyEtapa2(
                result,
                friendXml,
                stats
            );


        result =
            applyEtapa3(
                result,
                friendXml,
                stats
            );


        /*
        ====================================================
        Requested additions
        ====================================================

        These are XML names only from mGameInfoEditor.

        No editor functionality is executed.
        */


        result =
            copyRequestedExtras(
                friendXml,
                result,
                stats
            );

    } else {

        throw new Error(
            "مرحلة غير معروفة"
        );
    }


    dedupeStats(
        stats
    );


    return {
        xml: result,
        stats
    };
}


// ============================================================
// Request extraction
// ============================================================

function getXmlPair(req) {

    const body =
        req.body || {};


    const myXml =
        firstNonEmpty(
            body.myXml,
            body.targetXml,
            body.xml
        );


    const friendXml =
        firstNonEmpty(
            body.friendXml,
            body.sourceXml,
            body.friend
        );


    return {
        myXml,
        friendXml
    };
}


// ============================================================
// Response
// ============================================================

function sendResult(
    req,
    res,
    result
) {

    const raw =
        String(
            req.query.raw || ""
        ) === "1" ||
        String(
            req.query.format || ""
        ).toLowerCase() === "xml";


    if (raw) {

        res.set(
            "Content-Type",
            "application/xml; charset=utf-8"
        );

        return res
            .status(200)
            .send(result.xml);
    }


    return res
        .status(200)
        .json({
            ok: true,
            status: "success",
            xml: result.xml,
            stats: result.stats
        });
}


// ============================================================
// Routes
// ============================================================

router.get(
    "/desban/health",
    (req, res) => {

        res.json({
            ok: true,
            service:
                "DesbanEngine-compatible API"
        });
    }
);


// ============================================================
// Stage handler
// ============================================================

async function handleStage(
    stage,
    req,
    res
) {

    try {

        const {
            myXml,
            friendXml
        } = getXmlPair(req);


        if (
            !myXml ||
            !friendXml
        ) {

            return res
                .status(400)
                .json({
                    ok: false,
                    status:
                        "invalid_request",
                    error:
                        "يجب إرسال myXml و friendXml"
                });
        }


        const result =
            runStage(
                stage,
                myXml,
                friendXml
            );


        return sendResult(
            req,
            res,
            result
        );

    } catch (error) {

        console.error(
            "[Desban] Error:",
            error
        );


        /*
        Missing optional sections never reach here.
        Only invalid XML / invalid request should do so.
        */

        return res
            .status(400)
            .json({
                ok: false,
                status:
                    "invalid_xml",
                error:
                    error.message
            });
    }
}


// ============================================================
// Existing routes
// ============================================================

router.post(
    "/desban",
    (req, res) => {
        handleStage(
            1,
            req,
            res
        );
    }
);


router.post(
    "/desban/repair",
    (req, res) => {
        handleStage(
            1,
            req,
            res
        );
    }
);


router.post(
    "/desban/etapa1",
    (req, res) => {
        handleStage(
            1,
            req,
            res
        );
    }
);


router.post(
    "/desban/etapa2",
    (req, res) => {
        handleStage(
            2,
            req,
            res
        );
    }
);


router.post(
    "/desban/etapa3",
    (req, res) => {
        handleStage(
            3,
            req,
            res
        );
    }
);


// ============================================================
// FULL
// ============================================================

router.post(
    "/desban/full",
    (req, res) => {

        handleStage(
            "full",
            req,
            res
        );
    }
);


// ============================================================
// Export
// ============================================================

module.exports = router;
