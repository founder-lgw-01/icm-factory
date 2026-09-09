// Turns a fold-format script (markdown with [NNN] slide lines) into the
// full-screen slide reader the owner records every voiceover from: one slide at a
// time, centered on a dark stage, advance with click / space / arrow, HOLD on
// [PAUSE], chapter rail from ## headers, progress bar + counter.
//
// Self-contained (no project deps) so it runs from any skill invocation.
//
// Usage: node make-reader.mjs <script.md> [out.html] [--config=path/to/my-line.md]
//   default out = <scriptdir>/<basename>-reader.html
//
// THE SKIN IS NOT GUESSED, AND IT IS NOT MINE. The business shapes the line,
// so the palette comes from the OWNER'S answers in _config/my-line.md:
//
//     SKIN-GROUND: #101318
//     SKIN-TEXT:   #f4f2ec
//     SKIN-ACCENT: #2b7fff
//     SKIN-FONT:   Archivo
//
// The generator walks up from the script's folder to find _config/my-line.md,
// or takes an explicit --config= path. If the config declares nothing, a
// neutral placeholder palette keeps the generator from crashing, it says so
// out loud, and check-reader.mjs refuses to pass the result. Fill the config.
import fs from "node:fs";
import path from "node:path";

const argv = process.argv.slice(2);
const configFlag = (argv.find((a) => a.startsWith("--config=")) || "").split("=")[1];
const [inPath, outArg] = argv.filter((a) => !a.startsWith("--"));
if (!inPath) { console.error("Usage: node make-reader.mjs <script.md> [out.html] [--config=path/to/my-line.md]"); process.exit(1); }
const raw = fs.readFileSync(path.resolve(inPath), "utf8");

// ---- the palette comes from the OWNER'S CONFIG -----------------------------
// The business shapes the line. The generator paints with the exact values the
// owner wrote into _config/my-line.md during the interview. It never carries a
// brand of its own.
const findConfig = () => {
  if (configFlag) return path.resolve(configFlag);
  let dir = path.dirname(path.resolve(inPath));
  for (let i = 0; i < 6; i++) {
    const p = path.join(dir, "_config", "my-line.md");
    if (fs.existsSync(p)) return p;
    const up = path.dirname(dir);
    if (up === dir) break;
    dir = up;
  }
  return null;
};
const cfgPath = findConfig();
const cfgTxt = cfgPath ? fs.readFileSync(cfgPath, "utf8") : "";
const cfgVal = (key) => {
  const m = cfgTxt.match(new RegExp("^" + key + ":\\s*(.+)$", "im"));
  return m ? m[1].trim() : "";
};
const PALETTE = {
  name:   cfgVal("SKIN-NAME") || "my-brand",
  ground: cfgVal("SKIN-GROUND"),
  text:   cfgVal("SKIN-TEXT"),
  accent: cfgVal("SKIN-ACCENT"),
  font:   cfgVal("SKIN-FONT") || "Archivo",
};
// A hex answer sometimes arrives without its # sign. Repair, never reject.
for (const k of ["ground", "text", "accent"])
  if (/^[0-9a-f]{3}([0-9a-f]{3})?$/i.test(PALETTE[k])) PALETTE[k] = "#" + PALETTE[k];
const FALLBACK = !/^#/.test(PALETTE.ground) || !/^#/.test(PALETTE.text) || !/^#/.test(PALETTE.accent);
if (FALLBACK) {
  PALETTE.name = "fallback";
  PALETTE.ground = "#111318";
  PALETTE.text = "#ecebe7";
  PALETTE.accent = "#4a90d9";
  console.error(
    "\n  ⚠ FALLBACK PALETTE. The config " +
    (cfgPath ? "at " + cfgPath + " declares no usable SKIN-GROUND / SKIN-TEXT / SKIN-ACCENT."
             : "was not found (no _config/my-line.md above the script, no --config= flag).") +
    "\n  The reader below is a placeholder and check-reader.mjs will refuse it on purpose." +
    "\n  Run the interview in 00-START-HERE.md, or fill the skin lines by hand.\n"
  );
}
const SKIN = PALETTE.name;
const out = outArg
  ? path.resolve(outArg)
  : path.join(path.dirname(path.resolve(inPath)), path.basename(inPath).replace(/\.md$/i, "") + "-reader.html");

// ---- parse the fold script -------------------------------------------------
const WPS = 150 / 60;
const lines = raw.split(/\r?\n/);
const visualRe = /\[VISUAL:\s*([^\]]*)\]/;
const imgRe = /\[IMG:\s*([^\]]*)\]/;
// [RIFF: ...] is a DIRECTOR NOTE. It marks a stretch where the owner improvises over
// whatever visual is up. It must NEVER reach a slide: notes on the slide break
// his cadence, which is the whole reason this reader exists.
const riffRe = /\[RIFF:\s*[^\]]*\]/g;
const scriptDir = path.dirname(path.resolve(inPath));
const MIME = { ".png": "image/png", ".jpg": "image/jpeg", ".jpeg": "image/jpeg", ".gif": "image/gif", ".webp": "image/webp", ".svg": "image/svg+xml" };
// the owner records off a CRUDE MOCK of the finished slide, so any image that will
// be on screen has to be on his slide too. Search the obvious places rather
// than making the script author write absolute paths.
const SEARCH = [
  scriptDir,
  path.join(scriptDir, "assets"),
  path.join(process.env.USERPROFILE || process.env.HOME || "", "Downloads"),
  path.join(process.env.USERPROFILE || process.env.HOME || "", "Desktop"),
];
const resolveImg = (p) => {
  if (path.isAbsolute(p) && fs.existsSync(p)) return p;
  for (const d of SEARCH) {
    const c = path.join(d, p);
    if (fs.existsSync(c)) return c;
  }
  return null;
};
const toDataUri = (p) => {
  const abs = resolveImg(p);
  if (!abs) { console.warn(`  ! image not found, slide will show the cue only: ${p}`); return ""; }
  const ext = path.extname(abs).toLowerCase();
  const b64 = fs.readFileSync(abs).toString("base64");
  return `data:${MIME[ext] || "image/png"};base64,${b64}`;
};
// A [VISUAL: ...] cue naming an image file IS an image slide. Pull the filename
// out so the author never has to write the same asset twice.
const IMG_EXT = /([A-Za-z0-9._-]+\.(?:png|jpe?g|gif|webp|svg))/i;
// A cue can name an image file directly (a receipt screenshot), OR it can name
// a RENDERED COMPONENT (a value stack, a roadmap, a calculator). the owner still has
// to SEE the component while he records, because he riffs over it, so fall back
// to a slug lookup: [VISUAL: value stack oncall] finds value-stack-oncall.png.
// Drop a still of any component next to the script and it shows up in the
// reader with no cue changes and nothing to keep in sync.
const slugOf = (v) =>
  String(v || "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
const imgFromVisual = (v) => {
  const m = v && v.match(IMG_EXT);
  if (m) return m[1];
  const slug = slugOf(v);
  if (!slug) return "";
  for (const ext of [".png", ".jpg", ".jpeg", ".webp"]) {
    if (resolveImg(slug + ext)) return slug + ext;
  }
  return "";
};
// ---- THE HOLD LAW (a standing law) ---------------------------
// A fraction cannot be counted in your head. A hold is a BEAT the owner counts
// while performing. A fraction of a second is not countable and a long hold
// bleeds the engagement the video was built to hold. So there is exactly 1
// legal hold value in a reader: 1 second. Anything an author writes gets
// clamped here, in the generator, so no reader can ever ship a 2.5s hold again.
const HOLD_MAX = 1;
const clampHold = () => HOLD_MAX;
let title = "";
let specNote = ""; // the top-of-reader engine note (the owner's law: every reader
// says which Remotion system renders it, matching the spec). First "> " line.
const slides = [];
const CHAPTERS = [];
let cur = null;
let pendingChapter = null;

const push = () => { if (cur) slides.push(cur); cur = null; };
for (const line of lines) {
  if (line.startsWith("# ") && !title) { title = line.slice(2).trim(); continue; }
  const h = line.match(/^##\s+(.+)$/);
  if (h) { push(); pendingChapter = h[1].trim(); continue; }
  if (line.startsWith(">")) { if (!specNote) specNote = line.replace(/^>\s*/, "").trim(); continue; }
  if (line.startsWith("#")) continue;
  const m = line.match(/^\[(\d{3}[a-z]?)\]\s*(.*)$/);
  if (m) {
    push();
    cur = { id: m[1], text: m[2].replace(riffRe, "").trim(), visual: "", pause: false, pauseSec: 0, img: "" };
    // A [PAUSE] written INLINE used to survive into the slide text and print on
    // screen, which is the exact leak this reader exists to prevent: a director
    // note on the slide breaks his cadence. It is stripped here whether the
    // author put it on its own line or on this one.
    const pmInline = cur.text.match(/\[PAUSE(?:\s+([\d.]+)\s*s?)?\]/i);
    if (pmInline) {
      cur.pause = true;
      cur.pauseSec = clampHold();
      cur.text = cur.text.replace(/\[PAUSE(?:\s+[\d.]+\s*s?)?\]/i, "").trim();
    }
    const im = cur.text.match(imgRe);
    if (im) { cur.img = im[1].trim(); cur.text = cur.text.replace(imgRe, "").trim(); }
    const v = cur.text.match(visualRe);
    if (v) { cur.visual = v[1].trim(); cur.text = cur.text.replace(visualRe, "").trim(); }
    if (!cur.img && cur.visual) cur.img = imgFromVisual(cur.visual);
    if (pendingChapter) { CHAPTERS.push([m[1], pendingChapter]); pendingChapter = null; }
    continue;
  }
  if (cur && line.trim()) {
    const t = line.trim();
    // [PAUSE] or [PAUSE 3s] / [PAUSE 3]. Duration shows on screen in seconds so
    // the owner can count the hold in his head while recording.
    const pm = t.match(/\[PAUSE(?:\s+([\d.]+)\s*s?)?\]/i);
    if (pm) { cur.pause = true; cur.pauseSec = clampHold(); continue; }
    const im = t.match(imgRe);
    if (im) { cur.img = im[1].trim(); const rest = t.replace(imgRe, "").trim(); if (rest) cur.text = (cur.text + " " + rest).trim(); continue; }
    const v = t.match(visualRe);
    if (v) {
      cur.visual = v[1].trim();
      if (!cur.img) cur.img = imgFromVisual(cur.visual);
      const rest = t.replace(visualRe, "").trim(); if (rest) cur.text = (cur.text + " " + rest).trim(); continue;
    }
    const stripped = t.replace(riffRe, "").trim();
    if (!stripped) continue;
    cur.text = (cur.text + " " + stripped).trim();
  }
}
push();

// ---- classify + color runs (auto: quotes -> blue, numbers -> green) --------
const enrich = (s) => {
  // marker pass FIRST: {g:...} {r:...} {c:...} become fixed-color runs
  const markerRe = /\{([grc]):([^{}]*)\}/g;
  const colorMap = { g: "green", r: "red", c: "coral" };
  const seed = [];
  let last = 0, mk;
  while ((mk = markerRe.exec(s.text))) {
    if (mk.index > last) seed.push({ text: s.text.slice(last, mk.index), color: null });
    seed.push({ text: mk[2], color: colorMap[mk[1]] });
    last = mk.index + mk[0].length;
  }
  if (last < s.text.length) seed.push({ text: s.text.slice(last), color: null });
  const plainText = seed.length ? seed.map((r) => r.text).join("") : s.text;
  const words = plainText.split(/\s+/).filter(Boolean).length;
  const stripped = plainText.replace(/[^a-zA-Z0-9%$]/g, "");
  const num = words <= 2 && /^\$?[\d]/.test(stripped) && stripped.replace(/[\d%$.,kKmMx]/gi, "").length === 0;
  const punch = words <= 9;
  // Size is picked by WORD COUNT below, which breaks on 1 long word:
  // "CONGRATULATIONS!" is 1 word, took the biggest size, and ran off both edges
  // of the frame. Carry the longest word so the size can be capped to fit.
  const maxw = Math.max(1, ...plainText.split(/\s+/).filter(Boolean).map((w) => w.length));
  let runs;
  if (num && !seed.length) {
    runs = [{ text: s.text, color: "green" }];
  } else if (seed.length) {
    runs = seed;
  } else {
    runs = [{ text: s.text, color: null }];
    let guard = 0, found = true;
    while (found && guard++ < 20) {
      found = false;
      for (let k = 0; k < runs.length; k++) {
        if (runs[k].color !== null) continue;
        const q = runs[k].text.match(/"[^"]+"/);
        if (q) {
          const idx = runs[k].text.indexOf(q[0]);
          const out2 = [];
          if (idx > 0) out2.push({ text: runs[k].text.slice(0, idx), color: null });
          out2.push({ text: q[0], color: "blue" });
          const rest = runs[k].text.slice(idx + q[0].length);
          if (rest) out2.push({ text: rest, color: null });
          runs.splice(k, 1, ...out2); found = true; break;
        }
      }
    }
  }
  // Inline color, the owner's law: green = GOOD, red = BAD, coral = the brand action
  // words. Neutral numbers (dates, counts) stay cream — "2012 isn't good or
  // bad. It's just a date." Auto-color is $-amounts ONLY (the LiveSpar
  // precedent: $ runs go money green). Everything else is an authoring call via
  // markers in the fold text: {g:...} {r:...} {c:...} — color only, the words
  // stay verbatim. A {r:} beats the $ pass (their bad prices stay red).
  const dollarTok = /(\$[\d][\d,.]*)/g;
  runs = runs.flatMap((r) => {
    if (r.color === "green" || r.color === "red" || r.color === "coral") return [r];
    const parts = r.text.split(dollarTok).filter((p) => p !== "");
    if (parts.length <= 1) return [r];
    return parts.map((p) => (/^\$[\d][\d,.]*$/.test(p) ? { text: p, color: "green" } : { text: p, color: r.color }));
  });
  return { id: s.id, runs, pause: s.pause, pauseSec: s.pauseSec || 0, punch, num, words, maxw, vis: s.visual, img: s.img ? toDataUri(s.img) : "" };
};
const S = slides.map(enrich);

// ---- emit the reader HTML --------------------------------------------------
// The skin is built from the OWNER'S declared values, nothing else. Ground,
// text and the 1 accent come straight from the config. The raised panel, the
// border and the dim text are mixed from ground and text so they always agree
// with the palette. The good/bad/quote colors (green, red, blue) are content
// grammar, not brand, and they flip between a bright set and a deep set based
// on whether the ground is dark or light, so they stay readable on both.
//
// The font: Sora ships embedded in this skill's fonts/ dir, so an owner who
// answers "Sora" gets it with no network. Any other answer is used as a system
// or installed face with safe fallbacks behind it.
const FONT_PATH = path.join(import.meta.dirname, "fonts", "sora-latin.woff2");
const wantsSora = /^sora$/i.test(PALETTE.font);
const fontFace = wantsSora && fs.existsSync(FONT_PATH)
  ? `@font-face{font-family:"Sora";src:url(data:font/woff2;base64,${fs.readFileSync(FONT_PATH).toString("base64")}) format("woff2");font-weight:100 900;font-display:block;}`
  : "";
const fontStack = `"${PALETTE.font.replace(/"/g, "")}","Segoe UI",system-ui,sans-serif`;

// Is the ground dark or light? Standard relative-luminance math on the hex.
const hexLum = (hex) => {
  let h = hex.replace("#", "");
  if (h.length === 3) h = h.split("").map((c) => c + c).join("");
  const [r, g, b] = [0, 2, 4].map((i) => parseInt(h.slice(i, i + 2), 16) / 255);
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
};
const darkGround = hexLum(PALETTE.ground) < 0.5;
const SEMANTIC = darkGround
  ? { green: "#4ade80", red: "#FF5C57", blue: "#58A6FF" }
  : { green: "#1a7f37", red: "#b42318", blue: "#1a56db" };

const skinVars = `:root{--bg:${PALETTE.ground};
    --raised:color-mix(in srgb,${PALETTE.text} 6%,${PALETTE.ground});
    --border:color-mix(in srgb,${PALETTE.text} 15%,${PALETTE.ground});
    --text:${PALETTE.text};--dim:color-mix(in srgb,${PALETTE.text} 50%,${PALETTE.ground});
    --coral:${PALETTE.accent};--amber:var(--coral);
    --green:${SEMANTIC.green};--red:${SEMANTIC.red};--blue:${SEMANTIC.blue};
    --mono:${fontStack};--display:var(--mono);--weight:700;}`;
const fallbackMark = FALLBACK ? "\n<!--FALLBACK-PALETTE-->" : "";
const esc = (t) => t.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
const safeTitle = esc(title || "Slide Reader");
const html = `<title>${safeTitle} - Slide Reader</title>
<style>
  ${fontFace}
  /* Content semantics (the owner's law): GOOD numbers green, bad red, quotes blue.
     Every brand color above this line came from _config/my-line.md.
     Skin in this file: ${SKIN}. */
  ${skinVars}
  html,body{height:100%;}
  body{margin:0;background:var(--bg);color:var(--text);font-family:var(--mono);overflow:hidden;user-select:none;}
  #stage{position:fixed;inset:0;display:flex;align-items:center;justify-content:center;padding:7vh 7vw 15vh;cursor:pointer;}
  #slide{max-width:30ch;text-align:center;line-height:1.35;font-family:var(--display);font-weight:var(--weight);text-wrap:balance;letter-spacing:-.01em;}
  #slide.punch{line-height:1.2;letter-spacing:.01em;}
  #slide .c-green{color:var(--green);} #slide .c-amber{color:var(--amber);}
  #slide .c-red{color:var(--red);} #slide .c-blue{color:var(--blue);}
  #slide .c-coral{color:var(--coral);}
  @media (prefers-reduced-motion:no-preference){#slide.cut{animation:cut 140ms ease-out;}
    @keyframes cut{from{opacity:0;transform:translateY(6px);}to{opacity:1;transform:none;}}}
  #hold{position:fixed;left:50%;bottom:17vh;transform:translateX(-50%);color:var(--amber);
    font-size:13px;letter-spacing:.35em;display:none;align-items:center;gap:10px;}
  #hold .cursor{width:10px;height:20px;background:var(--amber);animation:blink .9s steps(1) infinite;}
  @keyframes blink{50%{opacity:0;}}
  #rail{position:fixed;left:0;right:0;bottom:0;background:var(--raised);border-top:1px solid var(--border);
    padding:10px 16px 12px;display:flex;flex-wrap:wrap;gap:6px 14px;align-items:center;justify-content:center;cursor:default;}
  #rail button{background:none;border:none;color:var(--dim);font-family:var(--mono);font-size:11px;
    letter-spacing:.06em;cursor:pointer;padding:4px 2px;}
  #rail button.here{color:var(--coral);}
  #rail button:focus-visible{outline:1px solid var(--coral);outline-offset:2px;}
  #meta{position:fixed;top:0;left:0;right:0;padding:12px 18px;display:flex;justify-content:space-between;
    font-size:12px;color:var(--dim);letter-spacing:.12em;cursor:default;}
  #bar{position:fixed;top:0;left:0;height:2px;background:var(--coral);width:0;}
  #hint{font-size:11px;color:var(--dim);letter-spacing:.06em;width:100%;text-align:center;margin-top:2px;}
  #note{position:fixed;top:34px;left:0;right:0;text-align:center;font-size:11.5px;
    color:var(--dim);letter-spacing:.08em;padding:0 18px;cursor:default;}
  #note b{color:var(--coral);font-weight:700;}
</style>
<div id="bar"></div>
<div id="meta"><span id="chapter"></span><span id="vis" style="color:var(--amber)"></span><span id="count"></span></div>
${specNote ? `<div id="note"><b>SPEC</b> · ${esc(specNote)}</div>` : ""}
<div id="stage"><div id="slide"></div></div>
<div id="hold"><span id="holdtxt">HOLD</span><span class="cursor"></span></div>
<nav id="rail"></nav>
<script>
  const SLIDES=${JSON.stringify(S)};
  const CHAPTERS=${JSON.stringify(CHAPTERS)};
  let i=Math.min(parseInt(location.hash.slice(1))-1||0,SLIDES.length-1); if(i<0)i=0;
  const el={slide:document.getElementById("slide"),count:document.getElementById("count"),
    chapter:document.getElementById("chapter"),hold:document.getElementById("hold"),
    bar:document.getElementById("bar"),rail:document.getElementById("rail")};
  const chapterStart=(id)=>SLIDES.findIndex((s)=>s.id===id);
  CHAPTERS.forEach(([id,t],n)=>{const b=document.createElement("button");
    b.textContent=(n+1)+" · "+t;
    b.addEventListener("click",(e)=>{e.stopPropagation();i=chapterStart(id);show();});
    el.rail.appendChild(b);});
  const hint=document.createElement("div");hint.id="hint";
  hint.textContent="click / space / → next · ← back · number keys jump to chapter";
  el.rail.appendChild(hint);
  function sizeFor(s){const w=s.words;
    let base;
    if(s.num||w<=3)base="clamp(3rem,10vw,7.5rem)";
    else if(w<=6)base="clamp(2.4rem,7.5vw,5.6rem)";
    else if(w<=10)base="clamp(1.9rem,5.6vw,4.2rem)";
    else if(w<=14)base="clamp(1.6rem,4.6vw,3.4rem)";
    else base="clamp(1.35rem,3.8vw,2.8rem)";
    return base;}
  // A single long word cannot wrap, so a 1 word slide took the biggest size and
  // ran off both edges. Guessing the font metric was close and still wrong, so
  // this MEASURES it: set the size, then shrink until it fits. Font independent.
  function fitSlide(){
    const el2=el.slide, stage=el2.parentElement;
    const room=stage.clientWidth-parseFloat(getComputedStyle(stage).paddingLeft)*2;
    let px=parseFloat(getComputedStyle(el2).fontSize);
    let guard=60;
    while(guard-- > 0 && (el2.scrollWidth>room+1 || el2.scrollHeight>stage.clientHeight*0.72)){
      px*=0.94; if(px<12)break; el2.style.fontSize=px+"px";
    }
  }
  function show(){const s=SLIDES[i];
    el.slide.classList.remove("cut");void el.slide.offsetWidth;el.slide.classList.add("cut");
    el.slide.classList.toggle("punch",s.punch||s.num);
    if(s.img){
      el.slide.style.maxWidth="none";el.slide.style.fontSize="clamp(1rem,2.2vw,1.5rem)";
      el.slide.innerHTML="";
      const im=document.createElement("img");im.src=s.img;
      im.style.maxWidth="94vw";im.style.maxHeight="66vh";im.style.objectFit="contain";
      im.style.display="block";im.style.margin="0 auto 20px";
      el.slide.appendChild(im);
      const cap=s.runs.map((r)=>r.text).join(" ").trim();
      if(cap){const c=document.createElement("div");c.textContent=cap;c.style.color="var(--dim)";el.slide.appendChild(c);}
    }else{
      el.slide.style.maxWidth="30ch";el.slide.style.fontSize=sizeFor(s);
      el.slide.replaceChildren(...s.runs.map((r)=>{const span=document.createElement("span");
        span.textContent=r.text;if(r.color)span.className="c-"+r.color;return span;}));
    }
    el.count.textContent=s.id+" / "+String(SLIDES.length).padStart(3,"0");
    document.getElementById("vis").textContent=s.vis?"◨ "+s.vis.toUpperCase():"";
    if(!s.img)fitSlide();
    el.hold.style.display=s.pause?"flex":"none";
    if(s.pause)document.getElementById("holdtxt").textContent="HOLD "+(s.pauseSec||1)+"s";
    el.bar.style.width=((i+1)/SLIDES.length)*100+"%";
    let ch=0;CHAPTERS.forEach(([id],n)=>{if(i>=chapterStart(id))ch=n;});
    if(CHAPTERS.length)el.chapter.textContent=(ch+1)+" · "+CHAPTERS[ch][1].toUpperCase();
    [...el.rail.querySelectorAll("button")].forEach((b,n)=>b.classList.toggle("here",n===ch));
    location.hash=i+1;}
  const next=()=>{if(i<SLIDES.length-1){i++;show();}};
  const prev=()=>{if(i>0){i--;show();}};
  document.getElementById("stage").addEventListener("click",next);
  addEventListener("keydown",(e)=>{
    if(e.key===" "||e.key==="ArrowRight"||e.key==="ArrowDown"){e.preventDefault();next();}
    else if(e.key==="ArrowLeft"||e.key==="ArrowUp"){e.preventDefault();prev();}
    else if(e.key==="Home"){i=0;show();}
    else if(e.key==="End"){i=SLIDES.length-1;show();}
    else if(/^[1-9]$/.test(e.key)&&CHAPTERS[+e.key-1]){i=chapterStart(CHAPTERS[+e.key-1][0]);show();}});
  show();
</script>`;

fs.writeFileSync(out, html + fallbackMark);
console.log(`slide reader: ${S.length} slides, ${CHAPTERS.length} chapters, skin "${SKIN}" from ${cfgPath || "FALLBACK"} -> ${out}`);
