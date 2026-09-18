/*
desbanApi.js

Node/Express implementation of the XML operations exposed by
DesbanEngine.

Mounted from server.js with:
app.use("/api", desbanApi);

Endpoints:

POST /api/desban          -> applyDesban / Full pipeline
POST /api/desban/full     -> Etapa1 + Etapa2 + Etapa3

POST /api/desban/repair   -> Etapa1
POST /api/desban/etapa1
POST /api/desban/etapa2
POST /api/desban/etapa3

GET /api/desban/health

Accepted JSON:

{
    "myXml": "...",
    "friendXml": "..."
}

Aliases are also accepted:

targetXml/sourceXml
xml/friend

IMPORTANT:

Missing XML sections are treated as optional.
They are skipped and NEVER converted into HTTP 500 errors.

The implementation intentionally edits XML as text rather than
serializing/rebuilding the whole document, so the existing XML
formatting and large embedded attributes are preserved.
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


// ============================================================
// Requested XML parts
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
    "UnlockedChatEmoji",

    // Requested additions
    "experience",
    "gameId",

    "unlockAllCards",
    "achievementTeamwork",
    "firstAttemptM3Levels",
    "fullCardCollections",
    "livesSent",
    "m3CompLvls",
    "regataTasksCompleted",
    "unlockAllAvatars"
];

const EXTRA_DATAELEMS = [
    "UnlockedFrames",
    "UnlockedStyles",
    "UnlockedExpRanks",
    "UnlockedBadges",
    "OwnedCards"
];


// Requested complete XML blocks.
// Skins intentionally removed.
const EXTRA_BLOCKS = [
    "AVATAR_IDS",
    "MIGRATE_AVATAR_IDS"
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


// ============================================================
// Achievement rewards
// ============================================================

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
    return String(value).replace(
        /[.*+?^${}()|[\]\\]/g,
        "\\$&"
    );
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
// XML block helpers
// ============================================================

function extractTagBlock(xml, tagName) {
    if (!xml) {
        return null;
    }

    const name = escapeRegExp(tagName);

    const normal = new RegExp(
        `<${name}\\b[^>]*>[\\s\\S]*?<\\/${name}\\s*>`,
        "i"
    );

    const selfClosing = new RegExp(
        `<${name}\\b[^>]*/\\s*>`,
        "i"
    );

    const m1 = normal.exec(xml);

    if (m1) {
        return m1[0];
    }

    const m2 = selfClosing.exec(xml);

    if (m2) {
        return m2[0];
    }

    return null;
}


function replaceFirstTagBlock(target, tagName, replacement) {
    const name = escapeRegExp(tagName);

    const normal = new RegExp(
        `<${name}\\b[^>]*>[\\s\\S]*?<\\/${name}\\s*>`,
        "i"
    );

    if (normal.test(target)) {
        return target.replace(
            normal,
            () => replacement
        );
    }

    const selfClosing = new RegExp(
        `<${name}\\b[^>]*/\\s*>`,
        "i"
    );

    if (selfClosing.test(target)) {
        return target.replace(
            selfClosing,
            () => replacement
        );
    }

    return null;
}


function insertBeforeClosing(target, tagName, block) {
    const close = new RegExp(
        `<\\/${escapeRegExp(tagName)}\\s*>`,
        "i"
    );

    const match = close.exec(target);

    if (!match) {
        return null;
    }

    return target.replace(
        close,
        () => block + match[0]
    );
}


/*
Mirrors the generic cloneBlock behavior from DesbanEngine:

replace the first target block;
if it does not exist, insert it before </Global>,
otherwise before </root>.
*/
function cloneBlock(src, target, tagName, stats) {
    if (
        stats &&
        stats.copied &&
        stats.copied.includes(`Block:${tagName}`)
    ) {
        return target;
    }

    const block = extractTagBlock(src, tagName);

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

        if (stats.copied) {
            stats.copied.push(`Block:${tagName}`);
        }

        return replaced;
    }

    const globalClose = /<\/Global\s*>/i;

    if (globalClose.test(target)) {
        target = target.replace(
            globalClose,
            () => block + "</Global>"
        );

        stats.inserted.push(tagName);

        if (stats.copied) {
            stats.copied.push(`Block:${tagName}`);
        }

        return target;
    }

    const rootClose = /<\/root\s*>/i;

    if (rootClose.test(target)) {
        target = target.replace(
            rootClose,
            () => block + "</root>"
        );

        stats.inserted.push(tagName);

        if (stats.copied) {
            stats.copied.push(`Block:${tagName}`);
        }

        return target;
    }

    stats.skipped.push(tagName);

    logSkip(
        `${tagName}: لم يتم العثور على نقطة إدراج`
    );

    return target;
}


// ============================================================
// Complete Town Map
// TownGround + Buildings
// ============================================================

function extractTownMap(xml) {
    if (!xml) {
        return null;
    }

    /*
     * The complete map section is copied from:
     *
     * <TownGround ...>
     *
     * through:
     *
     * </Buildings>
     *
     * This keeps TownGround and Buildings together as one unit.
     */
    const re =
        /<TownGround\b[^>]*>[\s\S]*?<\/Buildings\s*>/i;

    const match = re.exec(xml);

    return match ? match[0] : null;
}


function replaceTownMap(
    sourceXml,
    targetXml,
    stats
) {
    if (
        stats &&
        stats.copied &&
        stats.copied.includes("Block:TownMap")
    ) {
        return targetXml;
    }

    const sourceMap =
        extractTownMap(sourceXml);

    if (!sourceMap) {
        logSkip(
            "TownMap: TownGround + Buildings غير موجودين في XML المصدر"
        );

        stats.skipped.push(
            "TownMap"
        );

        return targetXml;
    }

    const targetMapRe =
        /<TownGround\b[^>]*>[\s\S]*?<\/Buildings\s*>/i;

    if (targetMapRe.test(targetXml)) {
        targetXml =
            targetXml.replace(
                targetMapRe,
                () => sourceMap
            );

        stats.replaced.push(
            "TownMap"
        );

        stats.copied.push(
            "Block:TownMap"
        );

        /*
         * Prevent the old individual cloning logic from
         * copying TownGround or Buildings a second time.
         */
        stats.copied.push(
            "Block:TownGround"
        );

        stats.copied.push(
            "Block:Buildings"
        );

        return targetXml;
    }

    /*
     * If the target has no map section, insert the complete
     * map before </root>.
     */
    const rootClose =
        /<\/root\s*>/i;

    if (rootClose.test(targetXml)) {
        targetXml =
            targetXml.replace(
                rootClose,
                () => sourceMap + "</root>"
            );

        stats.inserted.push(
            "TownMap"
        );

        stats.copied.push(
            "Block:TownMap"
        );

        stats.copied.push(
            "Block:TownGround"
        );

        stats.copied.push(
            "Block:Buildings"
        );

        return targetXml;
    }

    logSkip(
        "TownMap: لا توجد نقطة إدراج في XML الهدف"
    );

    stats.skipped.push(
        "TownMap"
    );

    return targetXml;
}


// ============================================================
// Complete Var helpers
// ============================================================

function findVar(xml, name) {
    if (!xml) {
        return null;
    }

    const safeName =
        escapeRegExp(name);

    const pattern =
        new RegExp(
            `<Var\\b[^>]*\\bname\\s*=\\s*["']${safeName}["'][^>]*(?:\\/\\s*>|>[^<]*<\\/Var\\s*>)`,
            "i"
        );

    const m =
        pattern.exec(xml);

    return m ? m[0] : null;
}


function getVarValue(xml, name) {
    const tag =
        findVar(xml, name);

    if (!tag) {
        return null;
    }

    const m =
        /\bv\s*=\s*["']([^"']*)["']/i.exec(tag);

    return m ? m[1] : null;
}


function getVarType(xml, name) {
    const tag =
        findVar(xml, name);

    if (!tag) {
        return null;
    }

    const m =
        /\bt\s*=\s*["']([^"']*)["']/i.exec(tag);

    return m ? m[1] : null;
}


function upsertVar(
    xml,
    name,
    value,
    type = "i",
    stats = null
) {
    const safeName =
        escapeRegExp(name);

    const safeValue =
        String(value)
            .replace(/&/g, "&amp;")
            .replace(/"/g, "&quot;");

    const newTag =
        `<Var name="${name}" v="${safeValue}" t="${type}"/>`;

    const pattern =
        new RegExp(
            `<Var\\b[^>]*\\bname\\s*=\\s*["']${safeName}["'][^>]*(?:\\/\\s*>|>[^<]*<\\/Var\\s*>)`,
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

    const globalClose =
        /<\/Global\s*>/i;

    if (globalClose.test(xml)) {
        if (stats) {
            stats.createdVars.push(name);
        }

        return xml.replace(
            globalClose,
            () => newTag + "</Global>"
        );
    }

    const rootClose =
        /<\/root\s*>/i;

    if (rootClose.test(xml)) {
        if (stats) {
            stats.createdVars.push(name);
        }

        return xml.replace(
            rootClose,
            () => newTag + "</root>"
        );
    }

    if (stats) {
        stats.skipped.push(
            `Var:${name}`
        );
    }

    return xml;
}


/*
 * Copies the COMPLETE <Var .../> tag from source.
 *
 * This is important for:
 *
 * gameId
 * townName
 * experience
 * levelup
 *
 * All source attributes are preserved.
 */
function copyVar(
    src,
    target,
    name,
    stats
) {
    if (
        stats &&
        stats.copied &&
        stats.copied.includes(`Var:${name}`)
    ) {
        return target;
    }

    const sourceTag =
        findVar(src, name);

    if (!sourceTag) {
        logSkip(
            `Var ${name}: غير موجود في XML المصدر`
        );

        stats.skipped.push(
            `Var:${name}`
        );

        return target;
    }

    const safeName =
        escapeRegExp(name);

    const pattern =
        new RegExp(
            `<Var\\b[^>]*\\bname\\s*=\\s*["']${safeName}["'][^>]*(?:\\/\\s*>|>[^<]*<\\/Var\\s*>)`,
            "i"
        );

    if (pattern.test(target)) {
        stats.updatedVars.push(name);

        if (stats.copied) {
            stats.copied.push(
                `Var:${name}`
            );
        }

        return target.replace(
            pattern,
            () => sourceTag
        );
    }

    const globalClose =
        /<\/Global\s*>/i;

    if (globalClose.test(target)) {
        stats.createdVars.push(name);

        if (stats.copied) {
            stats.copied.push(
                `Var:${name}`
            );
        }

        return target.replace(
            globalClose,
            () => sourceTag + "</Global>"
        );
    }

    const rootClose =
        /<\/root\s*>/i;

    if (rootClose.test(target)) {
        stats.createdVars.push(name);

        if (stats.copied) {
            stats.copied.push(
                `Var:${name}`
            );
        }

        return target.replace(
            rootClose,
            () => sourceTag + "</root>"
        );
    }

    logSkip(
        `Var ${name}: لا توجد نقطة إدراج`
    );

    stats.skipped.push(
        `Var:${name}`
    );

    return target;
}


// ============================================================
// DataElem helpers
// ============================================================

function extractNamedDataElem(
    xml,
    name
) {
    if (!xml) {
        return null;
    }

    const wanted =
        String(name);

    const openRe =
        /<DataElem\b[^>]*>/gi;

    let m;

    while (
        (m = openRe.exec(xml)) !== null
    ) {
        const openTag =
            m[0];

        const nameMatch =
            /\bname\s*=\s*["']([^"']*)["']/i.exec(
                openTag
            );

        if (
            !nameMatch ||
            nameMatch[1] !== wanted
        ) {
            continue;
        }

        if (/\/\s*>$/.test(openTag)) {
            return openTag;
        }

        const tokenRe =
            /<DataElem\b[^>]*>|<\/DataElem\s*>/gi;

        tokenRe.lastIndex =
            m.index;

        let depth = 0;
        let token;

        while (
            (token = tokenRe.exec(xml)) !== null
        ) {
            if (
                /^<DataElem\b/i.test(
                    token[0]
                )
            ) {
                if (
                    !/\/\s*>$/.test(
                        token[0]
                    )
                ) {
                    depth++;
                }
            } else {
                depth--;

                if (depth === 0) {
                    return xml.slice(
                        m.index,
                        tokenRe.lastIndex
                    );
                }
            }
        }

        return null;
    }

    return null;
}


function replaceNamedDataElem(
    target,
    name,
    replacement
) {
    const wanted =
        String(name);

    const openRe =
        /<DataElem\b[^>]*>/gi;

    let m;

    while (
        (m = openRe.exec(target)) !== null
    ) {
        const openTag =
            m[0];

        const nameMatch =
            /\bname\s*=\s*["']([^"']*)["']/i.exec(
                openTag
            );

        if (
            !nameMatch ||
            nameMatch[1] !== wanted
        ) {
            continue;
        }

        if (/\/\s*>$/.test(openTag)) {
            return (
                target.slice(
                    0,
                    m.index
                ) +
                replacement +
                target.slice(
                    openRe.lastIndex
                )
            );
        }

        const tokenRe =
            /<DataElem\b[^>]*>|<\/DataElem\s*>/gi;

        tokenRe.lastIndex =
            m.index;

        let depth = 0;
        let token;

        while (
            (token = tokenRe.exec(target)) !== null
        ) {
            if (
                /^<DataElem\b/i.test(
                    token[0]
                )
            ) {
                if (
                    !/\/\s*>$/.test(
                        token[0]
                    )
                ) {
                    depth++;
                }
            } else {
                depth--;

                if (depth === 0) {
                    return (
                        target.slice(
                            0,
                            m.index
                        ) +
                        replacement +
                        target.slice(
                            tokenRe.lastIndex
                        )
                    );
                }
            }
        }

        return null;
    }

    return null;
}


function copyDataElem(
    src,
    target,
    name,
    stats
) {
    if (
        stats &&
        stats.copied &&
        stats.copied.includes(
            `DataElem:${name}`
        )
    ) {
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

        stats.skipped.push(
            `DataElem:${name}`
        );

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

        if (stats.copied) {
            stats.copied.push(
                `DataElem:${name}`
            );
        }

        return replaced;
    }

    const globalClose =
        /<\/Global\s*>/i;

    if (globalClose.test(target)) {
        stats.inserted.push(
            `DataElem:${name}`
        );

        if (stats.copied) {
            stats.copied.push(
                `DataElem:${name}`
            );
        }

        return target.replace(
            globalClose,
            () =>
                sourceElem +
                "</Global>"
        );
    }

    const rootClose =
        /<\/root\s*>/i;

    if (rootClose.test(target)) {
        stats.inserted.push(
            `DataElem:${name}`
        );

        if (stats.copied) {
            stats.copied.push(
                `DataElem:${name}`
            );
        }

        return target.replace(
            rootClose,
            () =>
                sourceElem +
                "</root>"
        );
    }

    logSkip(
        `DataElem ${name}: لا توجد نقطة إدراج`
    );

    stats.skipped.push(
        `DataElem:${name}`
    );

    return target;
}


// ============================================================
// Requested flexible copier
// ============================================================

/*
Copies a requested item according to the representation
actually found in the donor XML.

Priority:

1. Var
2. DataElem
3. Complete XML block
*/
function copyRequestedPart(
    src,
    target,
    name,
    stats
) {
    if (
        stats &&
        stats.copied &&
        (
            stats.copied.includes(
                `Var:${name}`
            ) ||
            stats.copied.includes(
                `DataElem:${name}`
            ) ||
            stats.copied.includes(
                `Block:${name}`
            )
        )
    ) {
        return target;
    }

    if (findVar(src, name)) {
        return copyVar(
            src,
            target,
            name,
            stats
        );
    }

    if (
        extractNamedDataElem(
            src,
            name
        )
    ) {
        return copyDataElem(
            src,
            target,
            name,
            stats
        );
    }

    if (
        extractTagBlock(
            src,
            name
        )
    ) {
        return cloneBlock(
            src,
            target,
            name,
            stats
        );
    }

    logSkip(
        `${name}: غير موجود في XML المصدر`
    );

    stats.skipped.push(
        `Requested:${name}`
    );

    return target;
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
     * Requested Vars.
     */
    for (const name of EXTRA_VARS) {
        target = copyRequestedPart(
            src,
            target,
            name,
            stats
        );
    }


    /*
     * Requested DataElems.
     */
    for (const name of EXTRA_DATAELEMS) {
        target = copyRequestedPart(
            src,
            target,
            name,
            stats
        );
    }


    /*
     * Requested complete blocks:
     *
     * AVATAR_IDS
     * MIGRATE_AVATAR_IDS
     *
     * Skins intentionally excluded.
     */
    for (const name of EXTRA_BLOCKS) {
        target = copyRequestedPart(
            src,
            target,
            name,
            stats
        );
    }


    /*
     * Copy all avatar Vars that actually exist in
     * the donor XML.
     */
    const sourceGlobal =
        extractTagBlock(
            src,
            "Global"
        );

    if (sourceGlobal) {
        const avatarRe =
            /<Var\s+name="((?:Unlocked_ava|MigrateUnlocked_ava)[^"]*)"\b[^>]*\/\s*>/gi;

        let m;

        while (
            (m = avatarRe.exec(
                sourceGlobal
            )) !== null
        ) {
            target = copyVar(
                src,
                target,
                m[1],
                stats
            );
        }
    } else {
        logSkip(
            "Avatars: Global غير موجود في XML المصدر"
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
    let result =
        myXml;


    /*
     * Exact PROGRESS_VARS list.
     */
    for (
        const name
        of PROGRESS_VARS
    ) {
        result = copyVar(
            friendXml,
            result,
            name,
            stats
        );
    }


    /*
     * Copy complete levelup and experience Vars.
     */
    result = copyVar(
        friendXml,
        result,
        "levelup",
        stats
    );

    result = copyVar(
        friendXml,
        result,
        "experience",
        stats
    );


    /*
     * sexpx is calculated from experience,
     * preserving the existing DesbanEngine behavior.
     */
    const experience =
        getVarValue(
            friendXml,
            "experience"
        );

    if (experience !== null) {
        const expNumber =
            Number.parseInt(
                experience,
                10
            );

        if (
            Number.isFinite(
                expNumber
            )
        ) {
            const sexpx =
                (
                    expNumber ^
                    0x1e5d6a06
                ) >>> 0;

            result =
                upsertVar(
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
    }


    return result;
}


// ============================================================
// Etapa 2
// ============================================================

function cloneTownAndBuildings(
    src,
    target,
    stats
) {
    /*
     * IMPORTANT:
     *
     * TownGround + Buildings are treated as ONE complete
     * map section.
     *
     * This prevents copying TownGround and Buildings
     * separately and creating duplicate map data.
     */
    target =
        replaceTownMap(
            src,
            target,
            stats
        );

    return target;
}


function cloneGlobalVarsECoupons(
    src,
    target,
    stats
) {
    for (
        const name
        of MATCH3_VARS
    ) {
        target = copyVar(
            src,
            target,
            name,
            stats
        );
    }


    /*
     * Coupon variables.
     */
    for (
        const id
        of COUPON_IDS
    ) {
        const candidates = [
            `coupon_${id}`,
            `Coupon_${id}`,
            `coupon${id}`,
            id
        ];

        let found = false;

        for (
            const name
            of candidates
        ) {
            if (
                findVar(
                    src,
                    name
                )
            ) {
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


    /*
     * Complete TownGround + Buildings map.
     */
    result =
        cloneTownAndBuildings(
            friendXml,
            result,
            stats
        );


    /*
     * Existing Etapa2 Global variables/coupons.
     */
    result =
        cloneGlobalVarsECoupons(
            friendXml,
            result,
            stats
        );


    /*
     * Existing Etapa2 blocks.
     */
    for (
        const tag
        of CLONE_BLOCKS_ETAPA2
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
        const name
        of MY_VARS
    ) {
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
                `<Var\\b[^>]*\\bname\\s*=\\s*["']${escapeRegExp(name)}["'][^>]*(?:\\/\\s*>|>[^<]*<\\/Var\\s*>)`,
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

            /*
             * Mark it as already copied so the requested
             * extras do not duplicate it later.
             */
            stats.copied.push(
                `Var:${name}`
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

            stats.copied.push(
                `Var:${name}`
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
        (m = varRegex.exec(
            sourceGlobal
        )) !== null
    ) {
        const name =
            m[1];


        if (
            BARN_ITEM_BLOCKLIST.has(
                name
            )
        ) {
            continue;
        }


        const looksLikeBarn =
            /^(barn|item|storage|stash|warehouse)/i.test(
                name
            ) ||
            /(^|_)(count|counter|amount|quantity)$/i.test(
                name
            );


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
    for (
        const name
        of MATCH3_VARS
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
            (m = re.exec(
                sourceGlobal
            )) !== null
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
        const name
        of allNames
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
        (m = re.exec(
            sourceGlobal
        )) !== null
    ) {
        const name =
            m[1];


        if (
            /(quantidade|quantity|amount|count|counter)/i.test(
                name
            ) &&
            /(m3|match3|coupon|boost|booster|advantage|item)/i.test(
                name
            )
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
        const [a, b]
        of OPTIONAL_PAIR_BLOCKS
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


// ============================================================
// Achievement processing
// ============================================================

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
        const id
        of all
    ) {
        const name =
            `AchReward_${id}`;


        const tag =
            `<Var name="${name}" v="4" t="i"/>`;


        const pattern =
            new RegExp(
                `<Var\\b[^>]*\\bname\\s*=\\s*["']${escapeRegExp(name)}["'][^>]*(?:\\/\\s*>|>[^<]*<\\/Var\\s*>)`,
                "i"
            );


        if (pattern.test(out)) {
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


            if (globalClose.test(out)) {
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


    result =
        cloneArtInfo(
            friendXml,
            result,
            stats
        );


    /*
     * Trains intentionally removed.
     *
     * The remaining Etapa3 blocks are copied normally.
     */
    for (
        const tag
        of CLONE_BLOCKS_ETAPA3
    ) {
        result =
            cloneBlock(
                friendXml,
                result,
                tag,
                stats
            );
    }


    result =
        cloneUpgradeBlock(
            friendXml,
            result,
            stats
        );


    result =
        cloneMatch3AdvantagesBoosters(
            friendXml,
            result,
            stats
        );


    result =
        cloneAlterarQuantidadeVars(
            friendXml,
            result,
            stats
        );


    result =
        cloneAirInfoAndOrders(
            friendXml,
            result,
            stats
        );


    result =
        cloneDailyBonus(
            friendXml,
            result,
            stats
        );


    result =
        cloneBarnItems(
            friendXml,
            result,
            stats
        );


    result =
        cloneGlobalBlock(
            friendXml,
            result,
            stats
        );


    result =
        processUnlockAchievements(
            result,
            stats
        );


    result =
        cloneGlobalVarsECoupons(
            friendXml,
            result,
            stats
        );


    /*
     * ALL requested additional parts are handled here once.
     *
     * This includes:
     *
     * NewChatEmoji
     * UnlockedChatEmoji
     * experience
     * levelup
     * gameId
     * townName
     * unlockAllCards
     * achievementTeamwork
     * firstAttemptM3Levels
     * fullCardCollections
     * livesSent
     * m3CompLvls
     * regataTasksCompleted
     * unlockAllAvatars
     * UnlockedStyles
     * UnlockedFrames
     * UnlockedExpRanks
     * UnlockedBadges
     * AVATAR_IDS
     * MIGRATE_AVATAR_IDS
     *
     * Skins intentionally excluded.
     */
    result =
        copyRequestedExtras(
            friendXml,
            result,
            stats
        );


    return result;
}


// ============================================================
// Pipeline
// ============================================================

function createStats() {
    return {
        updatedVars: [],
        createdVars: [],
        replaced: [],
        inserted: [],
        skipped: [],
        errors: [],
        copied: []
    };
}


function dedupeStats(stats) {
    for (
        const key
        of Object.keys(stats)
    ) {
        if (
            Array.isArray(
                stats[key]
            )
        ) {
            stats[key] = [
                ...new Set(
                    stats[key]
                )
            ];
        }
    }


    return stats;
}


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
            .send(
                result.xml
            );
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


async function handleStage(
    stage,
    req,
    res
) {
    try {
        const {
            myXml,
            friendXml
        } =
            getXmlPair(req);


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
         * Missing optional XML sections never
         * reach here.
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
// /api/desban
// ============================================================

router.post(
    "/desban",
    (req, res) => {
        handleStage(
            "full",
            req,
            res
        );
    }
);


// ============================================================
// /api/desban/repair
// ============================================================

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


// ============================================================
// /api/desban/etapa1
// ============================================================

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


// ============================================================
// /api/desban/etapa2
// ============================================================

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


// ============================================================
// /api/desban/etapa3
// ============================================================

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
// /api/desban/full
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
