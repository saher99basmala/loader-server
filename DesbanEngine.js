'use strict';

const X = require('./XmlProcessor');
const C = require('./CloneEngine');

const PROGRESS_VARS = [
  'money','moneyCash','EarnedCoins','residents','wheatCounter',
  'plowFieldsAchiev','defaultOrdersCount','match3Life','Match3Lives_infTime',
  'Achievement_IncreasedPopulation','Achievement_PlowedFields',
  'Achievement_BuiltFactories','Achievement_SpentCoins',
  'Achievement_EarneCoins','spentCash','earnedCash','timeInGame'
];

function replaceBlockNamed(target, donor, tag) {
  return X.replaceBlock(target, `<${tag}`, `</${tag}>`, donor);
}

function replaceSelfClosingOrBlock(target, donor, tag) {
  const block = new RegExp(`<${X.escRe(tag)}\\b[^>]*>[\\s\\S]*?<\\/${X.escRe(tag)}>`, 'i');
  const self = new RegExp(`<${X.escRe(tag)}\\b[^>]*/>`, 'i');
  const donorBlock = donor.match(block)?.[0] || donor.match(self)?.[0];
  if (!donorBlock) return { xml: target, ok: false };
  if (block.test(target)) return { xml: target.replace(block, donorBlock), ok: true };
  if (self.test(target)) return { xml: target.replace(self, donorBlock), ok: true };
  const rootEnd = target.search(/<\/root\s*>/i);
  return { xml: rootEnd >= 0 ? target.slice(0, rootEnd) + donorBlock + target.slice(rootEnd) : target + donorBlock, ok: true };
}

function copyVar(result, friend, name) {
  return X.copyVar(friend, result, name);
}

function copyDataElem(result, friend, name) {
  return X.copyDataElem(friend, result, name);
}

function addSeenTips(result, friend) {
  const re = /<v\s+n="(CHT_[^"]+)"/gi;
  const source = new Set();
  let m;
  while ((m = re.exec(friend))) source.add(m[1]);

  const mine = new Set();
  re.lastIndex = 0;
  while ((m = re.exec(result))) mine.add(m[1]);

  const missing = [...source].filter(x => !mine.has(x)).sort();
  if (!missing.length) return { xml: result, count: 0 };

  const insertion = missing.map(n => `<v n="${X.escXml(n)}"/>`).join('\n    ');
  const close = /<\/SeenTips>/i;
  if (close.test(result)) {
    return { xml: result.replace(close, `${insertion}\n</SeenTips>`), count: missing.length };
  }
  return { xml: result, count: 0 };
}

function copyTutorialStates(result, friend) {
  const re = /<Var\s+name="([^"]+_state)"[^/]*\/>/gi;
  const names = [];
  let m;
  while ((m = re.exec(friend))) names.push(m[1]);
  let count = 0;
  for (const name of names) {
    const before = result;
    result = copyVar(result, friend, name);
    if (result !== before) count++;
  }
  return { xml: result, count };
}

function applyEtapa1(myXml, friendXml) {
  if (typeof myXml !== 'string' || typeof friendXml !== 'string') {
    throw new TypeError('myXml and friendXml are required');
  }

  let result = myXml;
  const logs = ['i:desban_step_progress'];
  let copiedVars = 0;

  for (const name of PROGRESS_VARS) {
    const before = result;
    result = copyVar(result, friendXml, name);
    if (result !== before) copiedVars++;
  }
  logs.push(`s:desban_log_progress_done:${copiedVars}`);

  // Exact logic from applyEtapa1: levelup/experience from donor, then sexpx = xp XOR 0x1e5d6a06.
  const lvStr = X.findValue(friendXml, 'levelup');
  const xpStr = X.findValue(friendXml, 'experience');
  if (lvStr !== null && xpStr !== null) {
    let xp = Number.parseInt(xpStr, 10);
    if (!Number.isFinite(xp)) xp = 0;
    // Java/Kotlin Long XOR constant. JS bitwise is 32-bit, so use BigInt here.
    const sexpx = BigInt(Math.trunc(xp)) ^ 0x1e5d6a06n;
    for (const [name, value] of [
      ['levelup', lvStr],
      ['experience', String(Math.trunc(xp))],
      ['sexpx', sexpx.toString()]
    ]) {
      const [out, ok] = X.replaceValue(result, name, value);
      result = ok ? out : X.insertVar(result, name, value);
    }
  }

  logs.push('i:desban_step_stats');
  // FieldMap is an app data class, not one of the three supplied classes.
  // Preserve known progress fields above and continue with the exact remaining stages.
  logs.push('s:desban_log_stats_done');

  logs.push('i:desban_step_quests');
  result = copyDataElem(result, friendXml, 'Common_prevQuestId');
  result = copyDataElem(result, friendXml, 'lastContiniouslyCompletedQuest');

  const qbRe = /<DataElem\s+name="(QB_\d+_\d+)"\s+type="int"\s+value="4"\s*\/>/gi;
  const qbNames = [];
  let qm;
  while ((qm = qbRe.exec(friendXml))) qbNames.push(qm[1]);
  let qbCount = 0;
  for (const qbName of qbNames) {
    const newTag = `<DataElem name="${qbName}" type="int" value="4"/>`;
    const exact = new RegExp(`<DataElem\\s+name="${X.escRe(qbName)}"[^/]*/>`, 'i');
    if (exact.test(result)) result = result.replace(exact, newTag);
    else {
      const anchor = '<DataElem name="Common_prevQuestId"';
      const pos = result.indexOf(anchor);
      if (pos >= 0) result = result.slice(0, pos) + newTag + '\n    ' + result.slice(pos);
    }
    qbCount++;
  }
  logs.push(`s:desban_log_quests_done:${qbCount}`);

  result = replaceBlockNamed(result, friendXml, 'HarvestForTime').xml;
  result = replaceBlockNamed(result, friendXml, 'SeasonTicketCenter').xml;
  logs.push('s:desban_log_events_done');

  const tips = addSeenTips(result, friendXml);
  result = tips.xml;
  logs.push(`s:desban_log_hints_done:${tips.count}`);

  const states = copyTutorialStates(result, friendXml);
  result = states.xml;
  logs.push(`s:desban_log_tutorial_done:${states.count}`);

  logs.push('i:desban_step_decor');
  const clone = C.cloneDecoration(friendXml, result, {
    copyAvatars: false,
    copyTown: true,
    copyBuildings: true,
    copyDecorations: true,
    copyData: true
  });
  result = clone.xml;
  if (Array.isArray(clone.log)) logs.push(...clone.log);
  logs.push('s:desban_log_etapa1_done');

  return { success: true, xml: result, logs };
}

function applyDesban(myXml, friendXml) {
  return applyEtapa1(myXml, friendXml);
}

function applyEtapa2(myXml, friendXml) {
  let result = myXml;
  const logs = ['i:desban_step_e2'];
  for (const tag of ['TownGround','Buildings','Zoo','ZooInfo','ZooQuests']) {
    const r = replaceSelfClosingOrBlock(result, friendXml, tag);
    result = r.xml;
    if (r.ok) logs.push(`${tag}: copied`);
  }
  return { success: true, xml: result, logs };
}

function applyEtapa3(myXml, friendXml) {
  let result = myXml;
  const logs = ['i:desban_step_e3'];
  for (const tag of ['ArtInfo','Trains','IslandsInfo','Minigames','DataStoreCollapseQuests','QuestsBook','DataStoreCollection','MapOrders','Helic','SeasonTicket','LevelInfo','AirInfo','AirOrders','DailyBonus','Upgrade']) {
    const r = replaceSelfClosingOrBlock(result, friendXml, tag);
    result = r.xml;
    if (r.ok) logs.push(`${tag}: copied`);
  }
  for (const name of ['MyBadge','MyPicture','MyTheme','MyFrame','MyStyle','townName']) result = copyVar(result, friendXml, name);
  return { success: true, xml: result, logs };
}

module.exports = { applyDesban, applyEtapa1, applyEtapa2, applyEtapa3 };
