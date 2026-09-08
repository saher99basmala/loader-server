'use strict';

const X = require('./XmlProcessor');

function cloneBlock(target, donor, openTag, closeTag, label) {
  const r = X.replaceBlock(target, openTag, closeTag, donor);
  return {
    xml: r.xml,
    ok: r.ok,
    log: r.ok ? `${label}: ok` : `${label}: donor block not found`
  };
}

/*
 * Node-side equivalent of the public CloneEngine entry point used by
 * DesbanEngine. The Android implementation performs several specialized
 * decoration/data operations; these XML block operations are kept isolated
 * here so the server can be expanded without changing the API layer.
 */
function cloneDecoration(donor, target, options = {}) {
  let xml = target;
  const logs = [];

  // The original call is made with the donor XML first and the current XML second.
  for (const name of ['TownGround', 'Buildings', 'Decorations']) {
    const r = cloneBlock(xml, donor, `<${name}`, `</${name}>`, name);
    xml = r.xml;
    if (r.ok) logs.push(r.log);
  }

  return { xml, ok: logs.length > 0, log: logs };
}

function fecharQuestsTutorialInicial(xml) {
  return [xml, []];
}

module.exports = {
  cloneBlock,
  cloneDecoration,
  fecharQuestsTutorialInicial
};
