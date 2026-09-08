'use strict';

function escRe(value) {
  return String(value).replace(/[.*+?^${}()|[\\]\\]/g, '\\$&');
}

function escXml(value) {
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/"/g, '&quot;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}

function findValue(xml, name) {
  if (typeof xml !== 'string') return null;
  const re = new RegExp(
    `<Var\\s+name="${escRe(name)}"[^>]*?\\bv="([^"]*)"[^>]*/?>`,
    'i'
  );
  const m = xml.match(re);
  return m ? m[1] : null;
}

function replaceValue(xml, name, value) {
  const re = new RegExp(
    `(<Var\\s+name="${escRe(name)}"[^>]*?\\bv=")[^"]*(")`,
    'i'
  );
  const out = xml.replace(re, `$1${escXml(value)}$2`);
  return [out, out !== xml];
}

function insertVar(xml, name, value, type = 'i') {
  const tag = `<Var name="${escXml(name)}" v="${escXml(value)}" t="${escXml(type)}"/>`;
  const globalOpen = /<Global\b[^>]*>/i.exec(xml);
  if (globalOpen) {
    const end = xml.indexOf('</Global>', globalOpen.index + globalOpen[0].length);
    if (end >= 0) return xml.slice(0, end) + tag + xml.slice(end);
  }
  const rootEnd = xml.search(/<\/root\s*>/i);
  if (rootEnd >= 0) return xml.slice(0, rootEnd) + tag + xml.slice(rootEnd);
  return xml + tag;
}

function findVarTag(xml, name) {
  const re = new RegExp(`<Var\\s+name="${escRe(name)}"[^>]*/>`, 'i');
  const m = xml.match(re);
  return m ? m[0] : null;
}

function copyVar(source, target, name) {
  const donor = findVarTag(source, name);
  if (!donor) return target;
  const re = new RegExp(`<Var\\s+name="${escRe(name)}"[^>]*/>`, 'i');
  if (re.test(target)) return target.replace(re, donor);
  return insertVar(target, name, findValue(source, name) ?? '');
}

function findDataElemTag(xml, name) {
  const re = new RegExp(`<DataElem\\s+name="${escRe(name)}"[^>]*/>`, 'i');
  const m = xml.match(re);
  return m ? m[0] : null;
}

function copyDataElem(source, target, name) {
  const donor = findDataElemTag(source, name);
  if (!donor) return target;
  const re = new RegExp(`<DataElem\\s+name="${escRe(name)}"[^>]*/>`, 'i');
  if (re.test(target)) return target.replace(re, donor);
  const rootEnd = target.search(/<\/root\s*>/i);
  return rootEnd >= 0 ? target.slice(0, rootEnd) + donor + target.slice(rootEnd) : target + donor;
}

function extractBlock(xml, openTag, closeTag, startIndex = 0) {
  const start = xml.indexOf(openTag, startIndex);
  if (start < 0) return null;
  const end = xml.indexOf(closeTag, start + openTag.length);
  if (end < 0) return null;
  return { block: xml.slice(start, end + closeTag.length), start, end: end + closeTag.length };
}

function replaceBlock(target, openTag, closeTag, donor) {
  const d = extractBlock(donor, openTag, closeTag);
  if (!d) return { xml: target, ok: false };
  const t = extractBlock(target, openTag, closeTag);
  if (t) return { xml: target.slice(0, t.start) + d.block + target.slice(t.end), ok: true };
  const rootEnd = target.search(/<\/root\s*>/i);
  if (rootEnd >= 0) return { xml: target.slice(0, rootEnd) + d.block + target.slice(rootEnd), ok: true };
  return { xml: target + d.block, ok: true };
}

module.exports = {
  escRe,
  escXml,
  findValue,
  replaceValue,
  insertVar,
  copyVar,
  copyDataElem,
  extractBlock,
  replaceBlock,
  findVarTag,
  findDataElemTag
};
