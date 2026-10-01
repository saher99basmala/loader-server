/*
 * desbanApi.js
 *
 * Server-side implementation of the Copy Design pipeline found in
 * Dyluc TOOLS 1.0.
 *
 * Mount:
 *   app.use("/api", require("./desbanApi"));
 *
 * Main endpoint:
 *   POST /api/desban/design
 *
 * JSON:
 * {
 *   "targetXml": "...",
 *   "sourceXml": "..."
 * }
 *
 * aliases:
 *   myXml / friendXml
 *   xml / friend
 *
 * The APK evidence shows CopyDesainActivity using:
 *   prepareCopyDesainTarget
 *   processDesain
 *   processAllDecor
 *   processSkins
 *   replaceTownGroundBuildings
 *   upsertBuildingsStash
 *   Upgrade-specific processing
 *
 * This implementation keeps XML as text so large attributes are not
 * reformatted by an XML serializer.
 */

const express = require("express");
const router = express.Router();

const MAX_XML = 50 * 1024 * 1024;

// ------------------------------------------------------------
// Generic helpers
// ------------------------------------------------------------

function s(v) {
  return typeof v === "string" ? v : "";
}

function first(...v) {
  for (const x of v) if (typeof x === "string" && x.length) return x;
  return "";
}

function escRe(v) {
  return String(v).replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function validXml(x) {
  return (
    typeof x === "string" &&
    x.length > 0 &&
    x.length <= MAX_XML &&
    /<root\b[^>]*>/i.test(x) &&
    /<\/root\s*>/i.test(x)
  );
}

function stat() {
  return {
    replaced: [],
    inserted: [],
    created: [],
    skipped: [],
    warnings: []
  };
}

function unique(a) {
  return [...new Set(a)];
}

// ------------------------------------------------------------
// Exact block extraction style used by the APK
// ------------------------------------------------------------

function block(xml, tag) {
  const n = escRe(tag);

  const full = new RegExp(
    `<${n}\\b[^>]*>[\\s\\S]*?<\\/${n}\\s*>`,
    "i"
  );

  const self = new RegExp(
    `<${n}\\b[^>]*/\\s*>`,
    "i"
  );

  const a = full.exec(xml);
  if (a) return a[0];

  const b = self.exec(xml);
  return b ? b[0] : null;
}

function replaceBlock(xml, tag, value) {
  const n = escRe(tag);

  const full = new RegExp(
    `<${n}\\b[^>]*>[\\s\\S]*?<\\/${n}\\s*>`,
    "i"
  );

  if (full.test(xml)) return xml.replace(full, () => value);

  const self = new RegExp(
    `<${n}\\b[^>]*/\\s*>`,
    "i"
  );

  if (self.test(xml)) return xml.replace(self, () => value);

  return null;
}

function insertBeforeRoot(xml, value) {
  const r = /<\/root\s*>/i;
  if (!r.test(xml)) return null;
  return xml.replace(r, () => value + "</root>");
}

function copyBlock(src, dst, tag, st) {
  const b = block(src, tag);

  if (!b) {
    st.skipped.push(tag);
    return dst;
  }

  const r = replaceBlock(dst, tag, b);
  if (r !== null) {
    st.replaced.push(tag);
    return r;
  }

  const ins = insertBeforeRoot(dst, b);
  if (ins !== null) {
    st.inserted.push(tag);
    return ins;
  }

  st.skipped.push(tag);
  return dst;
}

// ------------------------------------------------------------
// TownGround + Buildings
// The APK explicitly treats these as one complete section.
// ------------------------------------------------------------

function townMap(xml) {
  const r = /<TownGround\b[^>]*>[\s\S]*?<\/Buildings\s*>/i;
  const m = r.exec(xml);
  return m ? m[0] : null;
}

function replaceTownMap(src, dst, st) {
  const b = townMap(src);

  if (!b) {
    st.skipped.push("TownGround+Buildings");
    return dst;
  }

  const target = /<TownGround\b[^>]*>[\s\S]*?<\/Buildings\s*>/i;

  if (target.test(dst)) {
    st.replaced.push("TownGround+Buildings");
    return dst.replace(target, () => b);
  }

  const r = insertBeforeRoot(dst, b);
  if (r !== null) {
    st.inserted.push("TownGround+Buildings");
    return r;
  }

  st.skipped.push("TownGround+Buildings");
  return dst;
}

// ------------------------------------------------------------
// BuildingsStash
// ------------------------------------------------------------

function copyBuildingsStash(src, dst, st) {
  const b = block(src, "BuildingsStash");
  if (!b) {
    st.skipped.push("BuildingsStash");
    return dst;
  }

  return copyBlock(src, dst, "BuildingsStash", st);
}

// ------------------------------------------------------------
// Global Var helpers
// ------------------------------------------------------------

function findVar(xml, name) {
  const n = escRe(name);
  const r = new RegExp(
    `<Var\\b[^>]*\\bname\\s*=\\s*["']${n}["'][^>]*(?:\\/\\s*>|>[\\s\\S]*?<\\/Var\\s*>)`,
    "i"
  );
  const m = r.exec(xml);
  return m ? m[0] : null;
}

function copyVar(src, dst, name, st) {
  const v = findVar(src, name);
  if (!v) {
    st.skipped.push("Var:" + name);
    return dst;
  }

  const n = escRe(name);
  const r = new RegExp(
    `<Var\\b[^>]*\\bname\\s*=\\s*["']${n}["'][^>]*(?:\\/\\s*>|>[\\s\\S]*?<\\/Var\\s*>)`,
    "i"
  );

  if (r.test(dst)) {
    st.replaced.push("Var:" + name);
    return dst.replace(r, () => v);
  }

  const g = /<\/Global\s*>/i;
  if (g.test(dst)) {
    st.inserted.push("Var:" + name);
    return dst.replace(g, () => v + "</Global>");
  }

  return dst;
}

// ------------------------------------------------------------
// Upgrade
//
// The APK has dedicated Upgrade processing:
// - recognizes <Upgrade version='4'>
// - removes an old placeholder near the end
// - replaces/inserts the full source Upgrade block
// ------------------------------------------------------------

function copyUpgrade(src, dst, st) {
  const full =
    /<Upgrade\b[^>]*>[\s\S]*?<\/Upgrade\s*>/i.exec(src);

  if (full) {
    const value = full[0];

    const targetFull =
      /<Upgrade\b[^>]*>[\s\S]*?<\/Upgrade\s*>/i;

    if (targetFull.test(dst)) {
      st.replaced.push("Upgrade");
      return dst.replace(targetFull, () => value);
    }

    // APK also handles a self-closing placeholder.
    const self =
      /<Upgrade\b[^>]*\/\s*>/i;

    if (self.test(dst)) {
      st.replaced.push("Upgrade");
      return dst.replace(self, () => value);
    }

    const inserted = insertBeforeRoot(dst, value);
    if (inserted !== null) {
      st.inserted.push("Upgrade");
      return inserted;
    }
  }

  const selfSrc = /<Upgrade\b[^>]*\/\s*>/i.exec(src);
  if (selfSrc) {
    // Do not replace a full target Upgrade with a self-closing source.
    st.warnings.push("Source Upgrade is self-closing; full replacement skipped");
    return dst;
  }

  st.skipped.push("Upgrade");
  return dst;
}

// ------------------------------------------------------------
// Minigame
//
// The APK contains dedicated Minigame processing and constructs a
// replacement block. Here we copy complete Minigame blocks by id
// when they exist in both files, without touching unrelated XML.
// ------------------------------------------------------------

function copyMinigames(src, dst, st) {
  const re = /<Minigame\b[^>]*\bid\s*=\s*["']([^"']+)["'][^>]*>[\s\S]*?<\/Minigame\s*>/gi;
  let m;

  while ((m = re.exec(src))) {
    const id = m[1];
    const wanted = escRe(id);

    const targetRe = new RegExp(
      `<Minigame\\b[^>]*\\bid\\s*=\\s*["']${wanted}["'][^>]*>[\\s\\S]*?<\\/Minigame\\s*>`,
      "i"
    );

    if (targetRe.test(dst)) {
      dst = dst.replace(targetRe, () => m[0]);
      st.replaced.push("Minigame:" + id);
    } else {
      const ins = insertBeforeRoot(dst, m[0]);
      if (ins !== null) {
        dst = ins;
        st.inserted.push("Minigame:" + id);
      }
    }
  }

  return dst;
}

// ------------------------------------------------------------
// Optional blocks seen in the APK's processing pipeline.
// These are deliberately independent, matching the application's
// skip-if-absent behavior.
// ------------------------------------------------------------

const OPTIONAL_BLOCKS = [
  "Zoo",
  "ZooInfo",
  "ZooQuests",
  "IslandsInfo",
  "SeasonTicket",
  "Regata",
  "ArtInfo",
  "AirInfo",
  "AirOrders",
  "DailyBonus"
];

function copyOptionalBlocks(src, dst, st) {
  for (const tag of OPTIONAL_BLOCKS) {
    dst = copyBlock(src, dst, tag, st);
  }
  return dst;
}

// ------------------------------------------------------------
// Skins
//
// The APK has a separate processSkins step. The block is copied
// only when a real source Skins block exists. A self-closing target
// placeholder can therefore be replaced by the complete source block.
// ------------------------------------------------------------

function copySkins(src, dst, st) {
  const b = block(src, "Skins");
  if (!b) {
    st.skipped.push("Skins");
    return dst;
  }

  return copyBlock(src, dst, "Skins", st);
}

// ------------------------------------------------------------
// All Decor
//
// Decor is represented by the map's Object records. The complete
// TownGround + Buildings section is the authoritative design payload.
// BuildingsStash is handled separately because the APK has an
// upsertBuildingsStash routine.
// ------------------------------------------------------------

function copyAllDecor(src, dst, st) {
  dst = replaceTownMap(src, dst, st);
  dst = copyBuildingsStash(src, dst, st);
  return dst;
}

// ------------------------------------------------------------
// Cleanup rules observed in the APK
// ------------------------------------------------------------

function cleanupDesignArtifacts(xml) {
  // These are temporary application artifacts, not Township state.
  xml = xml.replace(
    /<CCSecret\b[^>]*\/\s*>/gi,
    ""
  );

  return xml;
}

// ------------------------------------------------------------
// Main design pipeline
// ------------------------------------------------------------

function applyDesign(targetXml, sourceXml, options, st) {
  let out = targetXml;

  /*
   * prepareCopyDesainTarget / processDesain:
   * the map is the core design payload.
   */
  out = copyAllDecor(sourceXml, out, st);

  /*
   * The APK has dedicated Upgrade handling.
   */
  out = copyUpgrade(sourceXml, out, st);

  /*
   * Separate processing stages observed in the APK.
   */
  out = copyOptionalBlocks(sourceXml, out, st);
  out = copyMinigames(sourceXml, out, st);

  /*
   * Skins are controlled separately by the application.
   * Default here is OFF so this endpoint performs design only.
   * Send {"copySkins":true} if the client explicitly wants them.
   */
  if (options.copySkins === true) {
    out = copySkins(sourceXml, out, st);
  } else {
    st.warnings.push("Skins not copied: copySkins=false");
  }

  /*
   * Do not copy Global/progress/economy variables here.
   * That belongs to the other Desban pipeline, not the core
   * Copy Design operation.
   */
  out = cleanupDesignArtifacts(out);

  return out;
}

// ------------------------------------------------------------
// Request parsing
// ------------------------------------------------------------

function getPair(req) {
  const b = req.body || {};

  return {
    targetXml: first(
      b.targetXml,
      b.myXml,
      b.target,
      b.xml
    ),
    sourceXml: first(
      b.sourceXml,
      b.friendXml,
      b.source,
      b.friend
    )
  };
}

function send(req, res, xml, st) {
  const raw =
    String(req.query.raw || "") === "1" ||
    String(req.query.format || "").toLowerCase() === "xml";

  st.replaced = unique(st.replaced);
  st.inserted = unique(st.inserted);
  st.created = unique(st.created);
  st.skipped = unique(st.skipped);
  st.warnings = unique(st.warnings);

  if (raw) {
    res.set("Content-Type", "application/xml; charset=utf-8");
    return res.status(200).send(xml);
  }

  return res.status(200).json({
    ok: true,
    status: "success",
    operation: "copy_design",
    xml,
    stats: st
  });
}

// ------------------------------------------------------------
// Routes
// ------------------------------------------------------------

router.get("/desban/health", (req, res) => {
  res.json({
    ok: true,
    service: "Dyluc Copy Design compatible API",
    operation: "copy_design"
  });
});

router.post("/desban/design", (req, res) => {
  try {
    const { targetXml, sourceXml } = getPair(req);

    if (!validXml(targetXml)) {
      return res.status(400).json({
        ok: false,
        status: "invalid_target_xml",
        error: "targetXml لا يحتوي root صالح أو حجمه غير صالح"
      });
    }

    if (!validXml(sourceXml)) {
      return res.status(400).json({
        ok: false,
        status: "invalid_source_xml",
        error: "sourceXml لا يحتوي root صالح أو حجمه غير صالح"
      });
    }

    const st = stat();

    const copySkins =
      req.body &&
      (
        req.body.copySkins === true ||
        req.body.copySkins === 1 ||
        req.body.copySkins === "1"
      );

    const xml = applyDesign(
      targetXml,
      sourceXml,
      { copySkins },
      st
    );

    return send(req, res, xml, st);
  } catch (e) {
    console.error("[CopyDesign] ERROR:", e);

    return res.status(500).json({
      ok: false,
      status: "server_error",
      error: e.message
    });
  }
});

/*
 * Compatibility aliases.
 */
router.post("/desban/copy-design", (req, res, next) => {
  req.url = "/desban/design";
  router.handle(req, res, next);
});

router.post("/desban/copydesign", (req, res, next) => {
  req.url = "/desban/design";
  router.handle(req, res, next);
});

// Expose the same Copy Design engine to xmlTransferApi.js.
// Existing /api/desban/design route remains available.
router.processCopyDesign = function(targetXml, sourceXml, options) {
  const st = stat();
  const opts = options || {};
  const xml = applyDesign(targetXml, sourceXml, opts, st);
  return { xml, stats: st };
};

module.exports = router;
