/*
 * desbanApi.js
 * ------------------------------------------------------------
 * Node/Express implementation of the XML operations exposed by
 * DesbanEngine.
 *
 * Mounted from server.js with:
 *     app.use("/api", desbanApi);
 *
 * Endpoints:
 *   POST /api/desban          -> applyDesban / Etapa1
 *   POST /api/desban/full     -> Etapa1 + Etapa2 + Etapa3
 *   POST /api/desban/etapa1
 *   POST /api/desban/etapa2
 *   POST /api/desban/etapa3
 *   GET  /api/desban/health
 *
 * Accepted JSON:
 *   { "myXml": "...", "friendXml": "..." }
 *
 * Aliases are also accepted:
 *   targetXml/sourceXml, xml/friend
 *
 * IMPORTANT:
 * Missing XML sections are treated as optional. They are skipped
 * and NEVER converted into HTTP 500 errors.
 *
 * The implementation intentionally edits XML as text rather than
 * serializing/rebuilding the whole document, so the existing XML
 * formatting and large embedded attributes are preserved.
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
 * These are the achievement reward IDs visible in the
 * DesbanEngine static ACHIEVEMENT_REWARDS list.
 *
 * The engine also discovers additional IDs dynamically from
 * existing AchReward_<id> variables, so an ID not listed here
 * is still handled.
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
// General helpers
// ============================================================

function asString(value) {
    return typeof value === "string" ? value : "";
}

function firstNonEmpty(...values) {
    for (const value of values) {
        if (typeof value === "string" && value.length > 0) return value;
    }
    return "";
}

function escapeRegExp(value) {
    return String(value).replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function hasRoot(xml) {
    return /<root\b[^>]*>/i.test(xml) && /<\/root\s*>/i.test(xml);
}

function ensureXml(xml, label) {
    if (!xml || typeof xml !== "string") {
        throw new Error(`${label} XML غير موجود`);
    }

    // DesbanEngine works on XML text. Do a light structural check
    // without parsing/reformatting the entire save.
    if (!hasRoot(xml)) {
        throw new Error(`${label} XML لا يحتوي root صالح`);
    }
}

function logSkip(message) {
    console.log(`[Desban] SKIP: ${message}`);
}

function findFirstBodyBlock(xml, tagName) {
    if (!xml) return null;
    const openRe = new RegExp(`<${escapeRegExp(tagName)}\\b[^>]*>`, "ig");
    let om;
    while ((om = openRe.exec(xml)) !== null) {
        if (/\/\s*>$/.test(om[0])) continue; // self-closing is not a body block
        const closeRe = new RegExp(`</${escapeRegExp(tagName)}\\s*>`, "i");
        const tail = xml.slice(om.index + om[0].length);
        const cm = closeRe.exec(tail);
        if (!cm) continue;
        const end = om.index + om[0].length + cm.index + cm[0].length;
        return { start: om.index, end, text: xml.slice(om.index, end) };
    }
    return null;
}

function findFirstSelfClosing(xml, tagName) {
    if (!xml) return null;
    const re = new RegExp(`<${escapeRegExp(tagName)}\\b[^>]*/\\s*>`, "i");
    const m = re.exec(xml);
    return m ? { start: m.index, end: m.index + m[0].length, text: m[0] } : null;
}

function extractTagBlock(xml, tagName) {
    const body = findFirstBodyBlock(xml, tagName);
    if (body) return body.text;
    const self = findFirstSelfClosing(xml, tagName);
    return self ? self.text : null;
}

function replaceFirstTagBlock(target, tagName, replacement) {
    const body = findFirstBodyBlock(target, tagName);
    if (body) {
        return target.slice(0, body.start) + replacement + target.slice(body.end);
    }

    const self = findFirstSelfClosing(target, tagName);
    if (self) {
        return target.slice(0, self.start) + replacement + target.slice(self.end);
    }

    return null;
}

function insertBeforeClosing(target, tagName, block) {
    const close = new RegExp(`</${escapeRegExp(tagName)}\\s*>`, "i");
    if (!close.test(target)) return null;

    return target.replace(close, () => block + close.exec(target)[0]);
}

/*
 * Mirrors the generic cloneBlock behavior from DesbanEngine:
 * replace the first target block; if it does not exist, insert it
 * before </Global>, otherwise before </root>.
 */
function cloneBlock(src, target, tagName, stats, options = {}) {
    const block = extractTagBlock(src, tagName);

    if (!block) {
        logSkip(`${tagName}: القسم غير موجود في XML المصدر`);
        stats.skipped.push(tagName);
        return target;
    }

    const replaced = replaceFirstTagBlock(target, tagName, block);

    if (replaced !== null) {
        stats.replaced.push(tagName);
        return replaced;
    }

    const globalClose = /<\/Global\s*>/i;
    if (globalClose.test(target)) {
        target = target.replace(globalClose, () => block + "</Global>");
        stats.inserted.push(tagName);
        return target;
    }

    const rootClose = /<\/root\s*>/i;
    if (rootClose.test(target)) {
        target = target.replace(rootClose, () => block + "</root>");
        stats.inserted.push(tagName);
        return target;
    }

    stats.skipped.push(tagName);
    logSkip(`${tagName}: لم يتم العثور على نقطة إدراج`);
    return target;
}

function findVar(xml, name) {
    if (!xml) return null;

    const pattern = new RegExp(
        `<Var\\s+name="${escapeRegExp(name)}"[^>]*/\\s*>`,
        "i"
    );

    const m = pattern.exec(xml);
    return m ? m[0] : null;
}

function getVarValue(xml, name) {
    const tag = findVar(xml, name);
    if (!tag) return null;

    const m = /\bv="([^"]*)"/i.exec(tag);
    return m ? m[1] : null;
}

function getVarType(xml, name) {
    const tag = findVar(xml, name);
    if (!tag) return null;

    const m = /\bt="([^"]*)"/i.exec(tag);
    return m ? m[1] : null;
}

function upsertVar(xml, name, value, type = "i", stats = null) {
    const safeName = escapeRegExp(name);
    const newTag =
        `<Var name="${name}" v="${String(value).replace(/"/g, "&quot;")}" t="${type}"/>`;

    const pattern = new RegExp(
        `<Var\\s+name="${safeName}"[^>]*/\\s*>`,
        "i"
    );

    if (pattern.test(xml)) {
        if (stats) stats.updatedVars.push(name);
        return xml.replace(pattern, () => newTag);
    }

    const globalClose = /<\/Global\s*>/i;
    if (globalClose.test(xml)) {
        if (stats) stats.createdVars.push(name);
        return xml.replace(globalClose, () => newTag + "</Global>");
    }

    const rootClose = /<\/root\s*>/i;
    if (rootClose.test(xml)) {
        if (stats) stats.createdVars.push(name);
        return xml.replace(rootClose, () => newTag + "</root>");
    }

    if (stats) stats.skipped.push(`Var:${name}`);
    return xml;
}

function copyVar(src, target, name, stats) {
    const sourceTag = findVar(src, name);

    if (!sourceTag) {
        logSkip(`Var ${name}: غير موجود في XML المصدر`);
        stats.skipped.push(`Var:${name}`);
        return target;
    }

    const pattern = new RegExp(
        `<Var\\s+name="${escapeRegExp(name)}"[^>]*/\\s*>`,
        "i"
    );

    if (pattern.test(target)) {
        stats.updatedVars.push(name);
        return target.replace(pattern, () => sourceTag);
    }

    const globalClose = /<\/Global\s*>/i;
    if (globalClose.test(target)) {
        stats.createdVars.push(name);
        return target.replace(globalClose, () => sourceTag + "</Global>");
    }

    const rootClose = /<\/root\s*>/i;
    if (rootClose.test(target)) {
        stats.createdVars.push(name);
        return target.replace(rootClose, () => sourceTag + "</root>");
    }

    logSkip(`Var ${name}: لا توجد نقطة إدراج`);
    stats.skipped.push(`Var:${name}`);
    return target;
}

function cloneUpgradeBlock(src, target, stats) {
    return cloneBlock(src, target, "Upgrade", stats);
}

// ============================================================
// Etapa 1
// ============================================================

function applyEtapa1(myXml, friendXml, stats) {
    let result = myXml;

    // Exact PROGRESS_VARS list from DesbanEngine.
    for (const name of PROGRESS_VARS) {
        result = copyVar(friendXml, result, name, stats);
    }

    // levelup + experience + sexpx.
    const levelup = getVarValue(friendXml, "levelup");
    const experience = getVarValue(friendXml, "experience");

    if (levelup !== null && experience !== null) {
        result = upsertVar(
            result,
            "levelup",
            levelup,
            getVarType(friendXml, "levelup") || "i",
            stats
        );

        result = upsertVar(
            result,
            "experience",
            experience,
            getVarType(friendXml, "experience") || "i",
            stats
        );

        const expNumber = Number.parseInt(experience, 10);

        if (Number.isFinite(expNumber)) {
            const sexpx = (expNumber ^ 0x1e5d6a06) >>> 0;

            result = upsertVar(
                result,
                "sexpx",
                String(sexpx),
                "i",
                stats
            );
        } else {
            logSkip("sexpx: experience ليست قيمة رقمية");
            stats.skipped.push("sexpx");
        }
    } else {
        if (levelup === null) logSkip("levelup: غير موجود في المصدر");
        if (experience === null) logSkip("experience: غير موجود في المصدر");
    }

    return result;
}

// ============================================================
// Etapa 2
// ============================================================

function extractUserId(xml) {
    const m = /<Object\b[^>]*\buser="([^"]+)"/i.exec(xml || "");
    return m ? m[1] : "";
}

function positionAfterFirstClosing(xml, tagName) {
    if (!xml) return -1;
    const close = new RegExp(`</${escapeRegExp(tagName)}\\s*>`, "i");
    const m = close.exec(xml);
    return m ? m.index + m[0].length : -1;
}

function extractBlockAfter(xml, tagName, fromPos) {
    if (!xml || fromPos < 0) return null;

    // CloneEngine searches from fromPos, then takes the first matching
    // opening tag and the first matching closing tag after it.
    const tail = xml.slice(fromPos);
    const open = new RegExp(`<${escapeRegExp(tagName)}\\b[^>]*>`, "i");
    const om = open.exec(tail);
    if (!om) return null;

    const close = new RegExp(`</${escapeRegExp(tagName)}\\s*>`, "i");
    const cm = close.exec(tail.slice(om.index + om[0].length));
    if (!cm) return null;

    const start = fromPos + om.index;
    const end = fromPos + om.index + om[0].length + cm.index + cm[0].length;
    return { start, end, text: xml.slice(start, end) };
}

function cloneTownAndBuildings(src, target, stats) {
    // This mirrors the city branch of CloneEngine.cloneDecoration
    // used by DesbanEngine with all CloneOptions set to false.
    const srcAfterZoo = positionAfterFirstClosing(src, "Zoo");
    const tgtAfterZoo = positionAfterFirstClosing(target, "Zoo");

    if (srcAfterZoo < 0 || tgtAfterZoo < 0) {
        logSkip("TownGround+Buildings: Zoo غير موجود");
        stats.skipped.push("TownGround+Buildings");
        return target;
    }

    const srcTg = extractBlockAfter(src, "TownGround", srcAfterZoo);
    if (!srcTg) {
        logSkip("TownGround+Buildings: المصدر لا يحتوي TownGround بعد Zoo");
        stats.skipped.push("TownGround+Buildings");
        return target;
    }

    const srcBld = extractBlockAfter(src, "Buildings", srcTg.start);
    if (!srcBld) {
        logSkip("TownGround+Buildings: المصدر لا يحتوي Buildings");
        stats.skipped.push("TownGround+Buildings");
        return target;
    }

    const bldInsideTownGround =
        srcBld.start >= srcTg.start && srcBld.end <= srcTg.end;

    let srcTown = srcTg.text;
    let srcBuildings = srcBld.text;

    const srcUser = extractUserId(src);
    const tgtUser = extractUserId(target);

    if (srcUser && tgtUser && srcUser !== tgtUser) {
        const userRe = new RegExp(`user="${escapeRegExp(srcUser)}"`, "g");
        srcTown = srcTown.replace(userRe, `user="${tgtUser}"`);
        srcBuildings = srcBuildings.replace(userRe, `user="${tgtUser}"`);
    }

    const tgtTg = extractBlockAfter(target, "TownGround", tgtAfterZoo);
    if (!tgtTg) {
        logSkip("TownGround+Buildings: الهدف لا يحتوي TownGround بعد Zoo");
        stats.skipped.push("TownGround+Buildings");
        return target;
    }

    if (bldInsideTownGround) {
        const before = target.slice(0, tgtTg.start);
        const after = target.slice(tgtTg.end);
        stats.replaced.push("TownGround");
        stats.replaced.push("Buildings");
        return before + srcTown + after;
    }

    const tgtBld = extractBlockAfter(target, "Buildings", tgtTg.end);

    if (!tgtBld) {
        const before = target.slice(0, tgtTg.start);
        const after = target.slice(tgtTg.end);
        stats.inserted.push("Buildings");
        stats.replaced.push("TownGround");
        return before + srcTown + "\n" + srcBuildings + after;
    }

    let out = target;

    // Replace from the right-hand side first so indexes remain valid.
    out = out.slice(0, tgtBld.start) + srcBuildings + out.slice(tgtBld.end);
    out = out.slice(0, tgtTg.start) + srcTown + out.slice(tgtTg.end);

    stats.replaced.push("TownGround");
    stats.replaced.push("Buildings");
    return out;
}

function cloneGlobalVarsECoupons(src, target, stats) {
    for (const name of MATCH3_VARS) {
        target = copyVar(src, target, name, stats);
    }

    /*
     * Coupon variables are represented differently between save
     * versions. We therefore copy matching Vars when they exist,
     * and skip them silently otherwise.
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
                target = copyVar(src, target, name, stats);
                found = true;
                break;
            }
        }

        if (!found) {
            logSkip(`Coupon ${id}: غير موجود`);
        }
    }

    return target;
}

function applyEtapa2(myXml, friendXml, stats) {
    let result = myXml;

    result = cloneTownAndBuildings(friendXml, result, stats);
    result = cloneGlobalVarsECoupons(friendXml, result, stats);

    for (const tag of CLONE_BLOCKS_ETAPA2) {
        result = cloneBlock(friendXml, result, tag, stats);
    }

    return result;
}

// ============================================================
// Etapa 3 helpers
// ============================================================

function cloneGlobalBlock(src, target, stats) {
    const sourceGlobal = extractTagBlock(src, "Global");
    const targetGlobal = extractTagBlock(target, "Global");

    if (!sourceGlobal || !targetGlobal) {
        logSkip("Global: القسم غير موجود");
        stats.skipped.push("Global");
        return target;
    }

    let newGlobal = targetGlobal;

    for (const name of MY_VARS) {
        const sourceVar = findVar(sourceGlobal, name);

        if (!sourceVar) {
            logSkip(`Global Var ${name}: غير موجود في المصدر`);
            stats.skipped.push(`Global:${name}`);
            continue;
        }

        const p = new RegExp(
            `<Var\\s+name="${escapeRegExp(name)}"[^>]*/\\s*>`,
            "i"
        );

        if (p.test(newGlobal)) {
            newGlobal = newGlobal.replace(p, () => sourceVar);
            stats.updatedVars.push(`Global:${name}`);
        } else {
            newGlobal = newGlobal.replace(
                /<\/Global\s*>/i,
                () => sourceVar + "</Global>"
            );
            stats.createdVars.push(`Global:${name}`);
        }
    }

    const globalPattern = /<Global\b[^>]*>[\s\S]*?<\/Global\s*>/i;
    return target.replace(globalPattern, () => newGlobal);
}

function cloneBarnItems(src, target, stats) {
    /*
     * BARN_ITEMS_LIST in the supplied class is a large static
     * list. Instead of hard-coding an incomplete list, discover
     * actual item Vars from the donor Global and copy the item
     * namespace while honoring the exact four-item blocklist.
     *
     * This is intentionally conservative: only simple <Var .../>
     * entries are touched.
     */
    const sourceGlobal = extractTagBlock(src, "Global");

    if (!sourceGlobal) {
        logSkip("BarnItems: Global غير موجود في المصدر");
        stats.skipped.push("BarnItems");
        return target;
    }

    const varRegex = /<Var\s+name="([^"]+)"\b[^>]*\/\s*>/gi;
    let m;

    while ((m = varRegex.exec(sourceGlobal)) !== null) {
        const name = m[1];

        if (BARN_ITEM_BLOCKLIST.has(name)) continue;

        /*
         * Common barn/inventory naming patterns. This avoids
         * replacing unrelated Global state.
         */
        const looksLikeBarn =
            /^(barn|item|storage|stash|warehouse)/i.test(name) ||
            /(^|_)(count|counter|amount|quantity)$/i.test(name);

        if (!looksLikeBarn) continue;

        target = copyVar(src, target, name, stats);
    }

    return target;
}

function cloneMatch3AdvantagesBoosters(src, target, stats) {
    /*
     * The class locates SeasonTicket and related Match-3 state.
     * Copy explicit Match-3 variables first.
     */
    for (const name of MATCH3_VARS) {
        target = copyVar(src, target, name, stats);
    }

    // Copy known Match3 boost variables when they exist in donor.
    const allNames = new Set();

    const sourceGlobal = extractTagBlock(src, "Global");
    if (sourceGlobal) {
        const re = /<Var\s+name="([^"]+)"\b[^>]*\/\s*>/gi;
        let m;

        while ((m = re.exec(sourceGlobal)) !== null) {
            if (/^(Match3|m3)/i.test(m[1])) {
                allNames.add(m[1]);
            }
        }
    }

    for (const name of allNames) {
        target = copyVar(src, target, name, stats);
    }

    return target;
}

function cloneAlterarQuantidadeVars(src, target, stats) {
    /*
     * The original helper operates on Global variables/windows.
     * We preserve the behavior safely by copying quantity-related
     * Vars that actually exist in the donor.
     */
    const sourceGlobal = extractTagBlock(src, "Global");

    if (!sourceGlobal) {
        logSkip("AlterarQuantidadeVars: Global غير موجود");
        return target;
    }

    const re = /<Var\s+name="([^"]+)"\b[^>]*\/\s*>/gi;
    let m;

    while ((m = re.exec(sourceGlobal)) !== null) {
        const name = m[1];

        if (
            /(quantidade|quantity|amount|count|counter)/i.test(name) &&
            /(m3|match3|coupon|boost|booster|advantage|item)/i.test(name)
        ) {
            target = copyVar(src, target, name, stats);
        }
    }

    return target;
}

function cloneArtInfo(src, target, stats) {
    // ArtInfo is optional in some saves.
    return cloneBlock(src, target, "ArtInfo", stats);
}

function cloneAirInfoAndOrders(src, target, stats) {
    for (const [a, b] of OPTIONAL_PAIR_BLOCKS) {
        target = cloneBlock(src, target, a, stats);
        target = cloneBlock(src, target, b, stats);
    }
    return target;
}

function cloneDailyBonus(src, target, stats) {
    return cloneBlock(src, target, "DailyBonus", stats);
}

function processUnlockAchievements(xml, stats) {
    const present = new Set();
    const rewardRe = /AchReward_([A-Za-z0-9_]+)/g;

    let m;
    while ((m = rewardRe.exec(xml)) !== null) {
        present.add(m[1]);
    }

    const all = new Set([
        ...ACHIEVEMENT_REWARDS,
        ...present
    ]);

    let out = xml;

    /*
     * Exact behavior from DesbanEngine:
     * every known/discovered AchReward_<id> must exist with v="4".
     */
    for (const id of all) {
        const name = `AchReward_${id}`;
        const tag =
            `<Var name="${name}" v="4" t="i"/>`;

        const pattern = new RegExp(
            `<Var\\s+name="${escapeRegExp(name)}"[^>]*/\\s*>`,
            "i"
        );

        if (pattern.test(out)) {
            out = out.replace(pattern, () => tag);
            stats.updatedVars.push(name);
        } else {
            const globalClose = /<\/Global\s*>/i;

            if (globalClose.test(out)) {
                out = out.replace(
                    globalClose,
                    () => tag + "</Global>"
                );
                stats.createdVars.push(name);
            } else {
                logSkip(`${name}: لا توجد Global`);
                stats.skipped.push(name);
            }
        }
    }

    /*
     * ACHIEVEMENT_COUNTER_MAP is version-dependent. Do not invent
     * thresholds that are not present in the supplied artifact.
     * Existing counters are therefore left intact.
     */
    return out;
}

function applyEtapa3(myXml, friendXml, stats) {
    let result = myXml;

    result = cloneArtInfo(friendXml, result, stats);

    for (const tag of CLONE_BLOCKS_ETAPA3) {
        result = cloneBlock(friendXml, result, tag, stats);
    }

    result = cloneUpgradeBlock(friendXml, result, stats);
    result = cloneMatch3AdvantagesBoosters(friendXml, result, stats);
    result = cloneAlterarQuantidadeVars(friendXml, result, stats);
    result = cloneAirInfoAndOrders(friendXml, result, stats);
    result = cloneDailyBonus(friendXml, result, stats);
    result = cloneBarnItems(friendXml, result, stats);
    result = cloneGlobalBlock(friendXml, result, stats);
    result = processUnlockAchievements(result, stats);
    result = cloneGlobalVarsECoupons(friendXml, result, stats);

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
        errors: []
    };
}

function dedupeStats(stats) {
    for (const key of Object.keys(stats)) {
        if (Array.isArray(stats[key])) {
            stats[key] = [...new Set(stats[key])];
        }
    }
    return stats;
}

function runStage(stage, myXml, friendXml) {
    ensureXml(myXml, "الهدف");
    ensureXml(friendXml, "المصدر");

    const stats = createStats();

    let result = myXml;

    if (stage === 1) {
        result = applyEtapa1(result, friendXml, stats);
    } else if (stage === 2) {
        result = applyEtapa2(result, friendXml, stats);
    } else if (stage === 3) {
        result = applyEtapa3(result, friendXml, stats);
    } else if (stage === "full") {
        // Safe full pipeline: only operations that are either directly
        // visible in DesbanEngine or implemented from its exact helper
        // structure are enabled here. The previous broad/generic merges
        // are deliberately NOT used.
        result = applyEtapa1(result, friendXml, stats);
        result = applyEtapa2(result, friendXml, stats);

        // Stage 3: clone only the explicit blocks named by DesbanEngine.
        result = cloneArtInfo(friendXml, result, stats);
        for (const tag of CLONE_BLOCKS_ETAPA3) {
            result = cloneBlock(friendXml, result, tag, stats);
        }
        result = cloneUpgradeBlock(friendXml, result, stats);
        result = cloneAirInfoAndOrders(friendXml, result, stats);
        result = cloneDailyBonus(friendXml, result, stats);
        result = cloneGlobalBlock(friendXml, result, stats);

        // Do NOT run the old heuristic implementations of BarnItems,
        // Match3, quantity variables, or achievement counters here.
        // Those heuristics could copy unrelated donor state.
    } else {
        throw new Error("مرحلة غير معروفة");
    }

    dedupeStats(stats);

    return {
        xml: result,
        stats
    };
}

// ============================================================
// Request extraction
// ============================================================

function getXmlPair(req) {
    const body = req.body || {};

    const myXml = firstNonEmpty(
        body.myXml,
        body.targetXml,
        body.xml
    );

    const friendXml = firstNonEmpty(
        body.friendXml,
        body.sourceXml,
        body.friend
    );

    return { myXml, friendXml };
}

function sendResult(req, res, result) {
    const raw =
        String(req.query.raw || "") === "1" ||
        String(req.query.format || "").toLowerCase() === "xml";

    if (raw) {
        res.set("Content-Type", "application/xml; charset=utf-8");
        return res.status(200).send(result.xml);
    }

    return res.status(200).json({
        ok: true,
        status: "success",
        xml: result.xml,
        stats: result.stats
    });
}

// ============================================================
// Routes
// ============================================================

router.get("/desban/health", (req, res) => {
    res.json({
        ok: true,
        service: "DesbanEngine-compatible API"
    });
});

async function handleStage(stage, req, res) {
    try {
        const { myXml, friendXml } = getXmlPair(req);

        if (!myXml || !friendXml) {
            return res.status(400).json({
                ok: false,
                status: "invalid_request",
                error: "يجب إرسال myXml و friendXml"
            });
        }

        const result = runStage(stage, myXml, friendXml);
        return sendResult(req, res, result);

    } catch (error) {
        console.error("[Desban] Error:", error);

        /*
         * A missing optional XML section must NEVER reach here.
         * Only malformed/missing root or invalid request is an error.
         */
        return res.status(400).json({
            ok: false,
            status: "invalid_xml",
            error: error.message
        });
    }
}

/*
 * applyDesban() in the supplied DesbanEngine calls Etapa1.
 */
router.post("/desban", (req, res) => {
    handleStage(1, req, res);
});

router.post("/desban/repair", (req, res) => {
    handleStage(1, req, res);
});

router.post("/desban/etapa1", (req, res) => {
    handleStage(1, req, res);
});

router.post("/desban/etapa2", (req, res) => {
    handleStage(2, req, res);
});

router.post("/desban/etapa3", (req, res) => {
    handleStage(3, req, res);
});

/*
 * Full pipeline is intentionally separate because the supplied
 * Kotlin applyDesban() itself invokes only Etapa1.
 */
router.post("/desban/full", (req, res) => {
    handleStage("full", req, res);
});

module.exports = router;
