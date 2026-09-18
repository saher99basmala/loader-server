/**
 * Processing pipeline.
 *
 * Order is preserved from the supplied DesbanEngine:
 * applyDesban -> Etapa1 -> Etapa2 -> Etapa3.
 */
"use strict";

const X = require("./xml-core");
const C = require("./data-cloner");

const PROGRESS_VARS = [
  "money","moneyCash","EarnedCoins","residents","wheatCounter",
  "plowFieldsAchiev","defaultOrdersCount","match3Life",
  "Match3Lives_infTime","Achievement_IncreasedPopulation",
  "Achievement_PlowedFields","Achievement_BuiltFactories",
  "Achievement_SpentCoins","Achievement_EarneCoins",
  "spentCash","earnedCash","timeInGame"
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

function result(xml, log, ok = true, stage = null) {
  return { xml, log, ok, stage };
}

function etapa1(myXml, friendXml) {
  let out = myXml;
  const log = ["i: etapa1:start"];
  let copied = 0;

  for (const name of PROGRESS_VARS) {
    const before = out;
    const r = X.copyVar(out, friendXml, name);
    out = r[0];
    if (out !== before) copied++;
    log.push((r[1] ? "s:" : "w:") + r[2]);
  }
  log.push(`s: progress variables processed: ${copied}`);

  const level = X.findValue(friendXml, "levelup");
  const xp = X.findValue(friendXml, "experience");
  if (level !== null && xp !== null) {
    const n = Number.parseInt(xp, 10);
    const safeXp = Number.isFinite(n) ? n : 0;
    const sexpx = safeXp ^ 0x1e5d6a06;
    for (const [name, value] of [
      ["levelup", level],
      ["experience", String(safeXp)],
      ["sexpx", String(sexpx)]
    ]) {
      const [next, changed] = X.replaceValue(out, name, value);
      out = changed ? next : X.insertVar(out, name, value);
      log.push((changed ? "s:" : "i:") + `${name}=${value}`);
    }
  }

  // Data elements explicitly handled by Etapa1.
  for (const name of ["Common_prevQuestId", "lastContiniouslyCompletedQuest"]) {
    const r = X.copyDataElem(out, friendXml, name);
    out = r[0];
    log.push((r[1] ? "s:" : "w:") + r[2]);
  }

  for (const name of ["HarvestForTime", "SeasonTicketCenter"]) {
    const r = X.copyBlock(out, friendXml, `<${name}`, `</${name}>`, name);
    out = r[0];
    log.push((r[1] ? "s:" : "w:") + r[2]);
  }

  log.push("s: etapa1:done");
  return result(out, log, true, 1);
}

function cloneTownAndBuildings(friendXml, myXml) {
  // The original method delegates town/building cloning to XML block operations.
  // Keep the operation text-safe and avoid fabricating blocks not present in source.
  const candidates = [
    ["<Town", "</Town>", "Town"],
    ["<Buildings", "</Buildings>", "Buildings"],
    ["<City", "</City>", "City"]
  ];
  let out = myXml, okAny = false, messages = [];
  for (const [o,c,l] of candidates) {
    const r = X.copyBlock(out, friendXml, o, c, l);
    out = r[0]; okAny ||= r[1]; messages.push(r[2]);
  }
  return [out, okAny, messages.join("; ")];
}

function cloneGlobalVarsECoupons(friendXml, myXml) {
  let out = myXml, okAny = false, messages = [];
  const globals = [
    "gameId","levelup","experience","sexpx","money","moneyCash",
    "EarnedCoins","residents","spentCash","earnedCash","timeInGame"
  ];
  for (const n of globals) {
    const r = X.copyVar(out, friendXml, n);
    out = r[0]; okAny ||= r[1]; messages.push(r[2]);
  }
  return [out, okAny, messages.join("; ")];
}

function etapa2(myXml, friendXml) {
  let out = myXml;
  const log = ["i: etapa2:start"];

  let r = cloneTownAndBuildings(friendXml, out);
  out = r[0]; log.push((r[1] ? "s:" : "w:") + r[2]);

  r = cloneGlobalVarsECoupons(friendXml, out);
  out = r[0]; log.push((r[1] ? "s:" : "w:") + r[2]);

  for (const [o,c,l] of BLOCKS_E2) {
    r = X.copyBlock(out, friendXml, o, c, l);
    out = r[0];
    log.push((r[1] ? "s:" : "w:") + r[2]);
  }

  log.push("s: etapa2:done");
  return result(out, log, true, 2);
}

function cloneArtInfo(friendXml, myXml) {
  return X.copyBlock(myXml, friendXml, "<ArtInfo", "</ArtInfo>", "ArtInfo");
}

function etapa3(myXml, friendXml) {
  let out = myXml;
  const log = ["i: etapa3:start"];

  let r = cloneArtInfo(friendXml, out);
  out = r[0]; log.push((r[1] ? "s:" : "w:") + r[2]);

  for (const [o,c,l] of BLOCKS_E3) {
    r = X.copyBlock(out, friendXml, o, c, l);
    out = r[0];
    log.push((r[1] ? "s:" : "w:") + r[2]);
  }

  log.push("s: etapa3:done");
  return result(out, log, true, 3);
}

function applyDesban(myXml, friendXml) {
  if (typeof myXml !== "string" || typeof friendXml !== "string") {
    throw new TypeError("myXml and friendXml must be strings");
  }

  // Exact public pipeline order from DesbanEngine.
  const a = etapa1(myXml, friendXml);
  const b = etapa2(a.xml, friendXml);
  const c = etapa3(b.xml, friendXml);

  return {
    xml: c.xml,
    log: [...a.log, ...b.log, ...c.log],
    ok: a.ok && b.ok && c.ok,
    stages: { etapa1: a, etapa2: b, etapa3: c }
  };
}

module.exports = {
  PROGRESS_VARS,
  etapa1, etapa2, etapa3, applyDesban
};
