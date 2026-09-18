/**
 * XML/text primitives used by the standalone pipeline.
 * The original application works heavily with textual XML fragments, so these
 * functions intentionally preserve formatting instead of round-tripping through
 * a DOM serializer.
 */
"use strict";

function escRe(s) { return String(s).replace(/[.*+?^${}()|[\]\\]/g, "\\$&"); }

function findValue(xml, name) {
  const n = escRe(name);
  const patterns = [
    new RegExp(`<Var\\b[^>]*\\bname=["']${n}["'][^>]*\\bv=["']([^"']*)["'][^>]*/?>`, "i"),
    new RegExp(`<Var\\b[^>]*\\bv=["']([^"']*)["'][^>]*\\bname=["']${n}["'][^>]*/?>`, "i"),
    new RegExp(`<${n}\\b[^>]*\\bv=["']([^"']*)["'][^>]*/?>`, "i")
  ];
  for (const re of patterns) {
    const m = xml.match(re);
    if (m) return m[1];
  }
  return null;
}

function replaceValue(xml, name, value) {
  const n = escRe(name);
  let changed = false;
  const val = String(value);
  const patterns = [
    new RegExp(`(<Var\\b[^>]*\\bname=["']${n}["'][^>]*\\bv=["'])[^"']*(["'][^>]*/?>)`, "i"),
    new RegExp(`(<Var\\b[^>]*\\bv=["'])[^"']*(["'][^>]*\\bname=["']${n}["'][^>]*/?>)`, "i"),
    new RegExp(`(<${n}\\b[^>]*\\bv=["'])[^"']*(["'][^>]*/?>)`, "i")
  ];
  for (const re of patterns) {
    if (re.test(xml)) {
      xml = xml.replace(re, (_, a, b) => { changed = true; return a + val + b; });
      break;
    }
  }
  return [xml, changed];
}

function insertVar(xml, name, value, type = "i") {
  if (findValue(xml, name) !== null) return xml;
  const node = `<Var name="${name}" v="${String(value)}" t="${type}"/>`;
  const pos = xml.search(/<\/(?:Global|Progress|Stats|Data|Town|City|Game)[^>]*>\s*$/i);
  if (pos >= 0) return xml.slice(0, pos) + node + xml.slice(pos);
  return xml + node;
}

function upsertVar(xml, name, value, type = "i") {
  const [out, changed] = replaceValue(xml, name, value);
  return changed ? out : insertVar(xml, name, value, type);
}

function extractBlock(xml, open, close, label = open.replace(/[<>]/g, "")) {
  const start = xml.indexOf(open);
  if (start < 0) return [null, false, `${label}: source block not found`];
  const end = xml.indexOf(close, start);
  if (end < 0) return [null, false, `${label}: closing tag not found`];
  const e = end + close.length;
  return [xml.slice(start, e), true, `${label}: extracted`];
}

function replaceBlock(xml, open, close, block) {
  const start = xml.indexOf(open);
  if (start < 0) return [xml, false];
  const end = xml.indexOf(close, start);
  if (end < 0) return [xml, false];
  const e = end + close.length;
  return [xml.slice(0, start) + block + xml.slice(e), true];
}

function copyBlock(target, source, open, close, label = open.replace(/[<>]/g, "")) {
  const [block, ok] = extractBlock(source, open, close, label);
  if (!ok) return [target, false, `${label}: source not found`];
  const [out, replaced] = replaceBlock(target, open, close, block);
  if (replaced) return [out, true, `${label}: replaced`];

  const rootClose = target.lastIndexOf("</");
  if (rootClose >= 0) return [target.slice(0, rootClose) + block + target.slice(rootClose), true, `${label}: inserted`];
  return [target + block, true, `${label}: appended`];
}

function copyVar(target, source, name) {
  const v = findValue(source, name);
  if (v === null) return [target, false, `${name}: source variable not found`];
  return [upsertVar(target, name, v), true, `${name}: copied`];
}

function copyDataElem(target, source, name) {
  const re = new RegExp(`<Data\\b[^>]*\\bname=["']${escRe(name)}["'][\\s\\S]*?<\\/Data>`, "i");
  const m = source.match(re);
  if (!m) return [target, false, `${name}: source Data element not found`];
  const tr = new RegExp(`<Data\\b[^>]*\\bname=["']${escRe(name)}["'][\\s\\S]*?<\\/Data>`, "i");
  if (tr.test(target)) return [target.replace(tr, m[0]), true, `${name}: Data replaced`];
  return [target + m[0], true, `${name}: Data appended`];
}

module.exports = {
  findValue, replaceValue, insertVar, upsertVar,
  extractBlock, replaceBlock, copyBlock, copyVar, copyDataElem
};
