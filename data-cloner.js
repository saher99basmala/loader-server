/**
 * Standalone block/data cloning layer.
 */
"use strict";
const X = require("./xml-core");

function cloneBlock(friendXml, myXml, open, close, label) {
  return X.copyBlock(myXml, friendXml, open, close, label);
}

function cloneXmlBlockPair(friendXml, myXml, spec) {
  return cloneBlock(friendXml, myXml, spec.open, spec.close, spec.label);
}

function cloneDecoration(friendXml, myXml, options = {}) {
  // Mirrors the CloneEngine public operation while keeping XML text intact.
  const open = options.open || "<Decorations";
  const close = options.close || "</Decorations>";
  return cloneBlock(friendXml, myXml, open, close, "Decorations");
}

function closeInitialTutorial(xml) {
  // Equivalent purpose to fecharQuestsTutorialInicial: remove completed/initial
  // tutorial quest entries when a complete block is available. We do not invent
  // entries; only normalize obvious closed tutorial containers.
  return xml.replace(/<TutorialQuest\b([^>]*)\/>/gi, "");
}

module.exports = { cloneBlock, cloneXmlBlockPair, cloneDecoration, closeInitialTutorial };
