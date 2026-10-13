/*
 * TownForge API Router
 * ملف جديد مستقل للتركيب داخل server.js الحالي.
 * لا يعدل أي ملف قديم ولا يتصل بخوادم اللعبة الخارجية.
 * المتطلبات: express, multer
 */
const express = require('express');
const multer = require('multer');

const router = express.Router();
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 25 * 1024 * 1024 },
});

function ensureXml(xml) {
  if (typeof xml !== 'string' || !xml.includes('<root') || !xml.includes('TownGround')) {
    const error = new Error('invalid Township XML');
    error.status = 422;
    throw error;
  }
}

function inspectSave(xml, fileName = 'mGameInfo.xml') {
  ensureXml(xml);
  const sections = [...new Set([...xml.matchAll(/<([A-Za-z][A-Za-z0-9_]*)\b/g)].map((m) => m[1]))]
    .filter((name) => name !== 'root')
    .slice(0, 200);
  return {
    fileName,
    bytes: Buffer.byteLength(xml),
    dataElements: (xml.match(/<DataElem\b/g) || []).length,
    sections,
    markers: {
      cards: /OwnedCards|CardCollections/i.test(xml),
      achievements: /Achievement_/i.test(xml),
      regatta: /Regata|Regatta/i.test(xml),
      season: /SeasonTicket|SeasonPass/i.test(xml),
      match3: /Match3|match3_/i.test(xml),
      trains: /<Trains\b/i.test(xml),
      airport: /AirInfo|AirOrders/i.test(xml),
    },
  };
}

function xmlEscape(value) {
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/"/g, '&quot;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}

function replaceFirstField(xml, names, value) {
  for (const name of names) {
    const pattern = new RegExp(
      `(<(?:DataElem|Var)\\b[^>]*\\bname=["']${name}["'][^>]*\\b(?:value|v)=["'])[^"']*(["'])`,
      'i',
    );
    if (pattern.test(xml)) return xml.replace(pattern, `$1${xmlEscape(value)}$2`);
  }
  return xml;
}

function applyEdits(xml, changes = {}) {
  ensureXml(xml);
  let output = xml;
  if (changes.coins != null) {
    output = replaceFirstField(output, ['coins', 'Coins', 'coin'], Math.max(0, Math.floor(Number(changes.coins))));
  }
  if (changes.cash != null) {
    output = replaceFirstField(output, ['cash', 'Cash', 'T-Cash', 'tcash', 'CashPurchase'], Math.max(0, Math.floor(Number(changes.cash))));
  }
  if (changes.level != null) {
    output = replaceFirstField(output, ['level', 'Level', 'cityLevel', 'TownLevel'], Math.max(1, Math.floor(Number(changes.level))));
  }
  if (changes.farmName != null && String(changes.farmName).trim()) {
    output = replaceFirstField(output, ['farmName', 'townName', 'cityName'], String(changes.farmName).trim());
  }
  return output;
}

function sendXml(res, xml, fileName = 'mGameInfo.townforge.xml') {
  res.set('Content-Type', 'application/xml; charset=utf-8');
  res.set('Content-Disposition', `attachment; filename="${fileName.replace(/[^a-zA-Z0-9._-]/g, '_')}"`);
  return res.send(xml);
}

// Optional protection: set TOWNFORGE_API_KEY in the host environment.
function protect(req, res, next) {
  const expected = process.env.TOWNFORGE_API_KEY;
  if (expected && req.get('x-api-key') !== expected) {
    return res.status(401).json({ ok: false, error: 'unauthorized' });
  }
  return next();
}

router.use(protect);

// POST /api/townforge/inspect — multipart field: file
router.post('/inspect', upload.single('file'), (req, res) => {
  try {
    if (!req.file) return res.status(400).json({ ok: false, error: 'file is required' });
    const xml = req.file.buffer.toString('utf8');
    return res.json({ ok: true, save: inspectSave(xml, req.file.originalname) });
  } catch (error) {
    return res.status(error.status || 400).json({ ok: false, error: error.message });
  }
});

// POST /api/townforge/edit — multipart fields: file, changes (JSON)
router.post('/edit', upload.single('file'), (req, res) => {
  try {
    if (!req.file) return res.status(400).json({ ok: false, error: 'file is required' });
    const changes = JSON.parse(req.body.changes || '{}');
    const original = req.file.buffer.toString('utf8');
    const edited = applyEdits(original, changes);
    res.set('X-TownForge-Backup', 'original-preserved');
    return sendXml(res, edited);
  } catch (error) {
    return res.status(error.status || 400).json({ ok: false, error: error.message });
  }
});

// POST /api/townforge/lua — JSON: { operation, xmlBase64, changes, fileName }
router.post('/lua', (req, res) => {
  try {
    const { operation, xmlBase64, changes, fileName } = req.body || {};
    if (!operation || !xmlBase64) {
      return res.status(400).json({ ok: false, error: 'operation and xmlBase64 are required' });
    }
    const xml = Buffer.from(xmlBase64, 'base64').toString('utf8');
    if (operation === 'inspect') {
      return res.json({ ok: true, save: inspectSave(xml, fileName) });
    }
    if (operation === 'edit') {
      const edited = applyEdits(xml, changes || {});
      return res.json({
        ok: true,
        backup: true,
        changed: edited !== xml,
        fileName: 'mGameInfo.townforge.xml',
        xmlBase64: Buffer.from(edited, 'utf8').toString('base64'),
      });
    }
    return res.status(400).json({ ok: false, error: 'unsupported operation', supported: ['inspect', 'edit'] });
  } catch (error) {
    return res.status(error.status || 400).json({ ok: false, error: error.message });
  }
});

module.exports = router;
