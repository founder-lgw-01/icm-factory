// The conformance gate: proves a generated reader matches the house standard
// BEFORE it reaches the owner. Born after a night where the font, the
// palette, the images, and the spec note each drifted and RYAN had to catch
// them. "I'm supposed to get the same thing every time and I am not."
// This is the definition of done, in code. A reader ships only on PASS.
//
//   node check-reader.mjs <fold.md> <reader.html>
//
// Exit 0 = PASS. Exit 1 = FAIL (the failures print). Warnings don't block but
// always print, so judgment calls stay visible.

import { readFileSync, readdirSync, existsSync } from "node:fs";
import path from "node:path";

const argv = process.argv.slice(2);
const configFlag = (argv.find((a) => a.startsWith("--config=")) || "").split("=")[1];
const [foldPath, htmlPath] = argv.filter((a) => !a.startsWith("--"));
if (!foldPath || !htmlPath) {
  console.error("Usage: node check-reader.mjs <fold.md> <reader.html> [--config=path/to/my-line.md]");
  process.exit(1);
}
// ⛔ A READER THAT ALREADY SHIPPED IS NOT GATED. (a standing law)
//
// Line 5 of this file states the gate's job: "A reader ships only on PASS."
// That is a check on the way OUT. Once the finished render sits in out/, the
// reader already shipped, the video is on the channel, and failing it now costs
// him attention and changes nothing. The house laws also tightened after some of
// these were made, so old readers fail rules that did not exist when they were
// built. That is the laws moving, not the work being wrong.
//
// This is a DECLARED exemption and it says so out loud, so it can never become
// the kind of silent blind spot audits keep finding.
// Pass --force to check a shipped reader anyway, which is what you want if you
// are regenerating one.
const forceGate = argv.includes("--force");
{
  const dir = path.dirname(path.resolve(foldPath));
  let shipped = false;
  try {
    shipped = readdirSync(path.join(dir, "out")).some((f) => f.endsWith(".mp4"));
  } catch { /* no out/ folder means nothing shipped */ }
  if (shipped && !forceGate) {
    console.log(
      `VERDICT: NOT GATED. ${path.basename(dir)} already shipped (a finished render is in out/). ` +
        `The gate checks a reader on the way out, and this one is out. Re-check it with --force.`
    );
    process.exit(0);
  }
}

const fold = readFileSync(foldPath, "utf8");
const html = readFileSync(htmlPath, "utf8");

const fails = [];
const warns = [];

// The font test below is a bare word (Sora, Archivo, Georgia), and an embedded
// image is megabytes of base64 that will eventually contain any short word by
// chance. It did: a correct reader once failed on a font name found inside a
// PNG payload. So face tests run against the markup with image payloads
// removed. Font payloads stay, so an embedded font still proves itself.
const htmlNoImg = html.replace(/data:image\/[a-z+]+;base64,[A-Za-z0-9+/=]+/gi, "data:image/REMOVED");

// ---- 0. THE PALETTE IS DECLARED IN THE CONFIG, NEVER GUESSED ---------------
// The owner's answers in _config/my-line.md are the only source of truth for
// the skin. The gate loads the same config the generator painted from, by the
// same walk-up search, and proves the reader against the DECLARED values. An
// empty config is a failure, not a warning: there is no safe default brand,
// and a placeholder palette must never reach the owner's screen in silence.
const findConfig = () => {
  if (configFlag) return path.resolve(configFlag);
  let dir = path.dirname(path.resolve(foldPath));
  for (let i = 0; i < 6; i++) {
    const p = path.join(dir, "_config", "my-line.md");
    if (existsSync(p)) return p;
    const up = path.dirname(dir);
    if (up === dir) break;
    dir = up;
  }
  return null;
};
const cfgPath = findConfig();
const cfgTxt = cfgPath ? readFileSync(cfgPath, "utf8") : "";
const cfgVal = (key) => {
  const m = cfgTxt.match(new RegExp("^" + key + ":\\s*(.+)$", "im"));
  return m ? m[1].trim() : "";
};
const PALETTE = {
  name:   cfgVal("SKIN-NAME") || "my-brand",
  ground: cfgVal("SKIN-GROUND"),
  text:   cfgVal("SKIN-TEXT"),
  accent: cfgVal("SKIN-ACCENT"),
  font:   cfgVal("SKIN-FONT"),
};
for (const k of ["ground", "text", "accent"])
  if (/^[0-9a-f]{3}([0-9a-f]{3})?$/i.test(PALETTE[k])) PALETTE[k] = "#" + PALETTE[k];
if (!cfgPath) {
  fails.push(
    "NO CONFIG FOUND. No _config/my-line.md above the fold and no --config= flag. " +
      "The palette is declared by the owner, never guessed. Run the interview in 00-START-HERE.md."
  );
} else {
  for (const [k, key] of [["ground", "SKIN-GROUND"], ["text", "SKIN-TEXT"], ["accent", "SKIN-ACCENT"]])
    if (!/^#[0-9a-f]{3}([0-9a-f]{3})?$/i.test(PALETTE[k]))
      fails.push(`NO PALETTE DECLARED: ${key} in ${cfgPath} is missing or not a hex color. Fill the skin lines.`);
  if (!PALETTE.font)
    fails.push(`NO FONT DECLARED: SKIN-FONT in ${cfgPath} is empty. Name the face your slides use.`);
}
const SKIN = PALETTE.name;

// ---- 1. the reader's bytes, checked against what was DECLARED --------------
// The generator stamps <!--FALLBACK-PALETTE--> when it painted a placeholder
// instead of the owner's colors. That reader never ships, silently or loudly.
if (html.includes("<!--FALLBACK-PALETTE-->"))
  fails.push("FALLBACK PALETTE in the reader. It was generated without usable config values. Fill the config and regenerate.");
if (fails.length === 0) {
  for (const [k, why] of [["ground", "declared ground color"], ["text", "declared text color"], ["accent", "declared accent color"]])
    if (!html.toLowerCase().includes(PALETTE[k].toLowerCase()))
      fails.push(`missing ${why} (${PALETTE[k]}) in the reader bytes. The reader is not wearing the declared skin.`);
  if (!new RegExp(PALETTE.font.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"), "i").test(htmlNoImg))
    fails.push(`declared font (${PALETTE.font}) not found in the reader markup.`);
}

// ---- 2. the spec note (the owner always knows the render engine) ----------------
if (!/id="note"/.test(html) || !/ENGINE/i.test(html))
  fails.push('no SPEC note at the top (fold file needs a "> ENGINE: ..." line under the title)');

// ---- 3. images: every image cue in the fold made it onto a slide ----------
const imgCues = (fold.match(/\[VISUAL:\s*[^\]]*\.(?:png|jpe?g|gif|webp|svg)\s*\]/gi) || []).length;
const embedded = (html.match(/data:image\//g) || []).length;
if (embedded < imgCues)
  fails.push(`image cues in fold: ${imgCues}, images embedded in reader: ${embedded} — a slide will be blind`);

// ---- 4. slide-text laws (on the fold source) -------------------------------
const slideLines = fold.split(/\r?\n/).filter((l) => /^\[\d{3}[a-z]?\]/.test(l));
if (!slideLines.length) fails.push("no [NNN] slide lines found in the fold file");
const emDash = slideLines.filter((l) => l.includes("—"));
if (emDash.length) fails.push(`em dashes on ${emDash.length} slide(s): ${emDash[0].slice(0, 60)}...`);
const periods = slideLines.filter((l) => {
  const text = l.replace(/^\[\d{3}[a-z]?\]\s*/, "").replace(/\[[^\]]*\]/g, "").trim();
  return /[.]$/.test(text) && !/\.\.\.$/.test(text);
});
if (periods.length)
  warns.push(`${periods.length} slide(s) end in a period — fine ONLY if the owner added them himself: ${periods.map((l) => l.slice(1, 4)).join(", ")}`);
const spelled = slideLines.filter((l) =>
  /\b(two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|twenty|thirty|forty|fifty|hundred|thousand|million)\b/i.test(l.replace(/\[[^\]]*\]/g, "")),
);
if (spelled.length)
  warns.push(`possible spelled-out numbers (digits law) on slide(s): ${spelled.map((l) => l.slice(1, 4)).join(", ")} — read them`);

// ---- 5. slide count sanity --------------------------------------------------
const htmlCount = (html.match(/"id":"\d{3}[a-z]?"/g) || []).length;
if (htmlCount !== slideLines.length)
  fails.push(`fold has ${slideLines.length} slides but reader carries ${htmlCount}`);

// ---- 6. THE HOLD LAW (a standing law) -------------------------
// A fraction cannot be counted in your head. A hold is a beat the owner counts
// while performing, so there is exactly 1 legal value: 1 second. Read it out of
// the BYTES the reader ships, never out of the fold, because the fold is the
// place the wrong number gets written. A long hold also bleeds the engagement
// the video exists to hold, which is the half that cost him a recording pass.
const holds = [...new Set((html.match(/"pauseSec":([\d.]+)/g) || []).map((m) => parseFloat(m.split(":")[1])))];
const badHolds = holds.filter((h) => h !== 0 && h !== 1);
if (badHolds.length)
  fails.push(`HOLD LAW: reader carries hold(s) of ${badHolds.join("s, ")}s — the only legal hold is 1s, regenerate with the current generator`);

// ---- 7. THE SLIDE LENGTH LAW (a standing law) -
// Paragraphs do not belong on slides. A slide is governed by TIME
// ON SCREEN and it holds under ~6 seconds. He reads at roughly 150 words a
// minute, which is 2.5 words a second, so 6 seconds is 15 words and the ceiling
// is 14. A scan of 16 shipped folds proved the real working ceiling is
// 15 to 19 words on 2 or 3 slides out of 100+. A 25 word slide has never once
// appeared in his work, and one reached his microphone because THIS GATE had no
// opinion about slide length. It does now.
const WORD_MAX = 14;
const wordsOf = (l) =>
  l.replace(/^\[\d{3}[a-z]?\]/, "")
   .replace(/\{[grc]:|\}/g, "")
   .replace(/\[[^\]]*\]/g, "")
   .trim().split(/\s+/).filter(Boolean).length;
const longSlides = slideLines
  .map((l) => [l.slice(1, 4), wordsOf(l), l])
  .filter(([, w]) => w > WORD_MAX);
if (longSlides.length)
  fails.push(
    `PARAGRAPH SLIDES: ${longSlides.length} slide(s) over ${WORD_MAX} words (a slide holds under 6s at 2.5 words/sec) — ` +
      longSlides.slice(0, 5).map(([id, w]) => `${id} is ${w}w ~${(w / 2.5).toFixed(1)}s`).join(", ") +
      (longSlides.length > 5 ? `, +${longSlides.length - 5} more` : "") +
      " — split them into complete short thoughts, never fragments"
  );

// ---- 8. THE SPEC GATE (the 9 stages, Gameplan > Script > SPEC > VO) ---------
// Stage 3 is the spec and it is not optional: "I never got my spec, you skipped
// that is how a build goes wrong. A reader IS stage 4, so
// a reader built in a folder with no spec means stage 3 was walked past. Nothing
// enforced that until now, which is how it got skipped silently.
const videoDir = path.dirname(path.resolve(foldPath));
const hasSpec = readdirSync(videoDir).some((n) => /SPEC\.md$/i.test(n));
if (!hasSpec)
  fails.push(
    `NO SPEC IN THE FOLDER: ${path.basename(videoDir)} has no *-SPEC.md — the reader is stage 4 and the spec is stage 3. ` +
      "Build the spec and get it approved before he reads from this."
  );

// ---- verdict ----------------------------------------------------------------
for (const w of warns) console.log(`⚠ WARN: ${w}`);
if (fails.length) {
  for (const f of fails) console.error(`✗ FAIL: ${f}`);
  console.error(`\nVERDICT: FAIL (${fails.length}). Do not publish this reader`);
  process.exit(1);
}
console.log(`VERDICT: PASS. ${slideLines.length} slides, ${embedded} images, "${SKIN}" skin verified against ${cfgPath}, spec note present${warns.length ? `, ${warns.length} warning(s) above` : ""}`);
