/**
 * Processing pipeline.
 *
 * Order:
 * applyDesban -> Etapa1 -> Etapa2 -> Etapa3
 *
 * Each stage now returns detailed counters:
 *   found
 *   replaced
 *   added
 *   notFound
 *   total
 */

"use strict";

const X = require("./xml-core");
const C = require("./data-cloner");

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

const BLOCKS_E2 = [
  ["<Zoo", "</Zoo>", "Zoo"],
  ["<ZooInfo", "</ZooInfo>", "ZooInfo"],
  ["<ZooQuests", "</ZooQuests>", "ZooQuests"]
];

const BLOCKS_E3 = [
  ["<Trains", "</Trains>", "Trains"],
  ["<IslandsInfo", "</IslandsInfo>", "IslandsInfo"],
  ["<Minigames", "</Minigames>", "Minigames"],
  ["<QuestsBook", "</QuestsBook>", "QuestsBook"]
];


/* ============================================================
 * Helpers
 * ============================================================ */

function result(xml, log, ok = true, stage = null, stats = null) {
  return {
    xml,
    log,
    ok,
    stage,
    stats: stats || createStats()
  };
}

function createStats() {
  return {
    found: 0,
    replaced: 0,
    added: 0,
    notFound: 0,
    total: 0
  };
}

function addDetail(stats, details, name, status, message) {
  stats.total++;

  if (status === "replaced") {
    stats.found++;
    stats.replaced++;
  } else if (status === "added") {
    stats.found++;
    stats.added++;
  } else if (status === "notFound") {
    stats.notFound++;
  } else if (status === "found") {
    stats.found++;
  }

  details.push({
    name,
    status,
    message
  });
}


/*
 * Copy a variable while determining whether it was:
 *
 *   replaced
 *   added
 *   notFound
 */
function copyVarDetailed(target, source, name) {
  const sourceValue = X.findValue(source, name);

  if (sourceValue === null) {
    return {
      xml: target,
      status: "notFound",
      message: `${name}: source variable not found`
    };
  }

  const targetBefore = target;

  const [replacedXml, replaced] =
    X.replaceValue(target, name, sourceValue);

  if (replaced) {
    return {
      xml: replacedXml,
      status: "replaced",
      message: `${name}: found in source, replaced in target`
    };
  }

  const addedXml =
    X.insertVar(targetBefore, name, sourceValue);

  if (addedXml !== targetBefore) {
    return {
      xml: addedXml,
      status: "added",
      message: `${name}: found in source, added to target`
    };
  }

  return {
    xml: targetBefore,
    status: "found",
    message: `${name}: found in source`
  };
}


/*
 * Copy XML block while determining whether it was:
 *
 *   replaced
 *   added
 *   notFound
 */
function copyBlockDetailed(target, source, open, close, label) {
  const [block, sourceFound] =
    X.extractBlock(source, open, close, label);

  if (!sourceFound) {
    return {
      xml: target,
      status: "notFound",
      message: `${label}: source block not found`
    };
  }

  const [replacedXml, replaced] =
    X.replaceBlock(target, open, close, block);

  if (replaced) {
    return {
      xml: replacedXml,
      status: "replaced",
      message: `${label}: found in source, replaced in target`
    };
  }

  const rootClose = target.lastIndexOf("</");

  if (rootClose >= 0) {
    const addedXml =
      target.slice(0, rootClose) +
      block +
      target.slice(rootClose);

    return {
      xml: addedXml,
      status: "added",
      message: `${label}: found in source, added to target`
    };
  }

  return {
    xml: target + block,
    status: "added",
    message: `${label}: found in source, appended to target`
  };
}


/*
 * Copy Data element with detailed status.
 */
function copyDataElemDetailed(target, source, name) {
  const escRe = s =>
    String(s).replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

  const sourceRe = new RegExp(
    `<Data\\b[^>]*\\bname=["']${escRe(name)}["'][\\s\\S]*?<\\/Data>`,
    "i"
  );

  const sourceMatch = source.match(sourceRe);

  if (!sourceMatch) {
    return {
      xml: target,
      status: "notFound",
      message: `${name}: source Data element not found`
    };
  }

  const targetRe = new RegExp(
    `<Data\\b[^>]*\\bname=["']${escRe(name)}["'][\\s\\S]*?<\\/Data>`,
    "i"
  );

  if (targetRe.test(target)) {
    return {
      xml: target.replace(targetRe, sourceMatch[0]),
      status: "replaced",
      message: `${name}: found in source, Data replaced in target`
    };
  }

  return {
    xml: target + sourceMatch[0],
    status: "added",
    message: `${name}: found in source, Data added to target`
  };
}


/* ============================================================
 * Etapa 1
 * ============================================================ */

function etapa1(myXml, friendXml) {
  let out = myXml;

  const log = [
    "i: etapa1:start"
  ];

  const stats = createStats();
  const details = [];

  /*
   * Progress variables
   */
  for (const name of PROGRESS_VARS) {
    const r = copyVarDetailed(out, friendXml, name);

    out = r.xml;

    addDetail(
      stats,
      details,
      name,
      r.status,
      r.message
    );

    log.push(
      `${r.status}: ${r.message}`
    );
  }


  /*
   * levelup / experience / sexpx
   */
  const level = X.findValue(friendXml, "levelup");
  const xp = X.findValue(friendXml, "experience");

  if (level !== null && xp !== null) {

    const n = Number.parseInt(xp, 10);

    const safeXp =
      Number.isFinite(n)
        ? n
        : 0;

    const sexpx =
      safeXp ^ 0x1e5d6a06;

    const values = [
      ["levelup", level],
      ["experience", String(safeXp)],
      ["sexpx", String(sexpx)]
    ];

    for (const [name, value] of values) {

      const before = out;

      const [
        replacedXml,
        replaced
      ] = X.replaceValue(
        out,
        name,
        value
      );

      if (replaced) {

        out = replacedXml;

        addDetail(
          stats,
          details,
          name,
          "replaced",
          `${name}: found in source, replaced in target`
        );

        log.push(
          `replaced: ${name}=${value}`
        );

      } else {

        const addedXml =
          X.insertVar(
            before,
            name,
            value
          );

        if (addedXml !== before) {

          out = addedXml;

          addDetail(
            stats,
            details,
            name,
            "added",
            `${name}: found in source, added to target`
          );

          log.push(
            `added: ${name}=${value}`
          );

        } else {

          out = before;

          addDetail(
            stats,
            details,
            name,
            "found",
            `${name}: found in source`
          );

          log.push(
            `found: ${name}=${value}`
          );
        }
      }
    }

  } else {

    if (level === null) {

      addDetail(
        stats,
        details,
        "levelup",
        "notFound",
        "levelup: source variable not found"
      );

      log.push(
        "notFound: levelup"
      );
    }

    if (xp === null) {

      addDetail(
        stats,
        details,
        "experience",
        "notFound",
        "experience: source variable not found"
      );

      log.push(
        "notFound: experience"
      );
    }
  }


  /*
   * Data elements
   */
  for (const name of [
    "Common_prevQuestId",
    "lastContiniouslyCompletedQuest"
  ]) {

    const r =
      copyDataElemDetailed(
        out,
        friendXml,
        name
      );

    out = r.xml;

    addDetail(
      stats,
      details,
      name,
      r.status,
      r.message
    );

    log.push(
      `${r.status}: ${r.message}`
    );
  }


  /*
   * Blocks
   */
  for (const name of [
    "HarvestForTime",
    "SeasonTicketCenter"
  ]) {

    const r =
      copyBlockDetailed(
        out,
        friendXml,
        `<${name}`,
        `</${name}>`,
        name
      );

    out = r.xml;

    addDetail(
      stats,
      details,
      name,
      r.status,
      r.message
    );

    log.push(
      `${r.status}: ${r.message}`
    );
  }


  log.push(
    `i: etapa1:summary found=${stats.found} replaced=${stats.replaced} added=${stats.added} notFound=${stats.notFound} total=${stats.total}`
  );

  log.push(
    "s: etapa1:done"
  );

  return result(
    out,
    log,
    true,
    1,
    {
      ...stats,
      details
    }
  );
}


/* ============================================================
 * Etapa 2
 * ============================================================ */

function cloneTownAndBuildingsDetailed(
  friendXml,
  myXml,
  stats,
  details,
  log
) {

  let out = myXml;

  const candidates = [
    ["<Town", "</Town>", "Town"],
    ["<Buildings", "</Buildings>", "Buildings"],
    ["<City", "</City>", "City"]
  ];

  for (const [open, close, label] of candidates) {

    const r =
      copyBlockDetailed(
        out,
        friendXml,
        open,
        close,
        label
      );

    out = r.xml;

    addDetail(
      stats,
      details,
      label,
      r.status,
      r.message
    );

    log.push(
      `${r.status}: ${r.message}`
    );
  }

  return out;
}


function cloneGlobalVarsDetailed(
  friendXml,
  myXml,
  stats,
  details,
  log
) {

  let out = myXml;

  const globals = [
    "gameId",
    "levelup",
    "experience",
    "sexpx",
    "money",
    "moneyCash",
    "EarnedCoins",
    "residents",
    "spentCash",
    "earnedCash",
    "timeInGame"
  ];

  for (const name of globals) {

    const r =
      copyVarDetailed(
        out,
        friendXml,
        name
      );

    out = r.xml;

    addDetail(
      stats,
      details,
      name,
      r.status,
      r.message
    );

    log.push(
      `${r.status}: ${r.message}`
    );
  }

  return out;
}


function etapa2(myXml, friendXml) {

  let out = myXml;

  const log = [
    "i: etapa2:start"
  ];

  const stats = createStats();
  const details = [];


  /*
   * Town / Buildings / City
   */
  out =
    cloneTownAndBuildingsDetailed(
      friendXml,
      out,
      stats,
      details,
      log
    );


  /*
   * Global variables
   */
  out =
    cloneGlobalVarsDetailed(
      friendXml,
      out,
      stats,
      details,
      log
    );


  /*
   * Zoo blocks
   */
  for (const [open, close, label] of BLOCKS_E2) {

    const r =
      copyBlockDetailed(
        out,
        friendXml,
        open,
        close,
        label
      );

    out = r.xml;

    addDetail(
      stats,
      details,
      label,
      r.status,
      r.message
    );

    log.push(
      `${r.status}: ${r.message}`
    );
  }


  log.push(
    `i: etapa2:summary found=${stats.found} replaced=${stats.replaced} added=${stats.added} notFound=${stats.notFound} total=${stats.total}`
  );

  log.push(
    "s: etapa2:done"
  );


  return result(
    out,
    log,
    true,
    2,
    {
      ...stats,
      details
    }
  );
}


/* ============================================================
 * Etapa 3
 * ============================================================ */

function cloneArtInfoDetailed(
  friendXml,
  myXml,
  stats,
  details,
  log
) {

  const r =
    copyBlockDetailed(
      myXml,
      friendXml,
      "<ArtInfo",
      "</ArtInfo>",
      "ArtInfo"
    );

  addDetail(
    stats,
    details,
    "ArtInfo",
    r.status,
    r.message
  );

  log.push(
    `${r.status}: ${r.message}`
  );

  return r.xml;
}


function etapa3(myXml, friendXml) {

  let out = myXml;

  const log = [
    "i: etapa3:start"
  ];

  const stats = createStats();
  const details = [];


  /*
   * ArtInfo
   */
  out =
    cloneArtInfoDetailed(
      friendXml,
      out,
      stats,
      details,
      log
    );


  /*
   * Remaining Etapa3 blocks
   */
  for (const [open, close, label] of BLOCKS_E3) {

    const r =
      copyBlockDetailed(
        out,
        friendXml,
        open,
        close,
        label
      );

    out = r.xml;

    addDetail(
      stats,
      details,
      label,
      r.status,
      r.message
    );

    log.push(
      `${r.status}: ${r.message}`
    );
  }


  log.push(
    `i: etapa3:summary found=${stats.found} replaced=${stats.replaced} added=${stats.added} notFound=${stats.notFound} total=${stats.total}`
  );

  log.push(
    "s: etapa3:done"
  );


  return result(
    out,
    log,
    true,
    3,
    {
      ...stats,
      details
    }
  );
}


/* ============================================================
 * Full pipeline
 * ============================================================ */

function applyDesban(myXml, friendXml) {

  if (
    typeof myXml !== "string" ||
    typeof friendXml !== "string"
  ) {
    throw new TypeError(
      "myXml and friendXml must be strings"
    );
  }


  /*
   * Etapa 1
   */
  const a =
    etapa1(
      myXml,
      friendXml
    );


  /*
   * Etapa 2
   */
  const b =
    etapa2(
      a.xml,
      friendXml
    );


  /*
   * Etapa 3
   */
  const c =
    etapa3(
      b.xml,
      friendXml
    );


  /*
   * Combined statistics
   */
  const totalStats =
    createStats();

  for (const stage of [a, b, c]) {

    totalStats.found +=
      stage.stats.found;

    totalStats.replaced +=
      stage.stats.replaced;

    totalStats.added +=
      stage.stats.added;

    totalStats.notFound +=
      stage.stats.notFound;

    totalStats.total +=
      stage.stats.total;
  }


  /*
   * Full log
   */
  const log = [
    ...a.log,
    ...b.log,
    ...c.log,

    `i: FULL SUMMARY found=${totalStats.found} replaced=${totalStats.replaced} added=${totalStats.added} notFound=${totalStats.notFound} total=${totalStats.total}`
  ];


  return {
    xml: c.xml,

    log,

    ok:
      a.ok &&
      b.ok &&
      c.ok,

    stages: {
      etapa1: a,
      etapa2: b,
      etapa3: c
    },

    stats: {
      found: totalStats.found,
      replaced: totalStats.replaced,
      added: totalStats.added,
      notFound: totalStats.notFound,
      total: totalStats.total
    }
  };
}


/* ============================================================
 * Exports
 * ============================================================ */

module.exports = {
  PROGRESS_VARS,
  etapa1,
  etapa2,
  etapa3,
  applyDesban
};
