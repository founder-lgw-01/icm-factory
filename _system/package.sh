#!/usr/bin/env bash
# package.sh - cut the factory itself as a buyer's zip in _dist/.
#
# Usage:  bash _system/package.sh
#
# Exit 0 = zipped and verified. Exit 1 = refused, and no zip was written.
#
# The package is made from a copy, never from this folder in place. The copy
# keeps the root files, stages/, _reference/, _templates/, _system/ and
# _source-corpus/ICM-architect/ without its .git/. It drops runs/, builds/,
# every other _source-corpus/ folder, _dist/ and this log, which is replaced by
# 1 entry stating what ships.
#
# Provenance lines that name the owner's own source kit, the slug of a run, a
# local path or the owner are reworded in the copy only, by the literal
# replacements below. Every replacement must land; a line that has moved since
# the last cut refuses the package rather than shipping it unsanitized.
#
# The copy is then checked: test-gate.sh, audit-builds.sh, voice-check.sh on
# every file the factory writes, an em dash byte count of 0 in those files, and
# a grep for the owner's names and paths over the whole copy. The vendored
# method, _source-corpus/ICM-architect/, is its authors' text under their MIT
# licence and ships as they wrote it; the voice laws govern what the factory
# writes, not what it reads. Then the copy is zipped to
# _dist/icm-factory-<date>[-vN].zip, entries rooted at icm-factory/, and the
# zip is read back against the copy file by file.

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$ROOT/_dist"
WORK="${TMPDIR:-/tmp}/icm-package.$$"
COPY="$WORK/icm-factory"
EM=$(printf '\xe2\x80\x94')

say() { printf '%-9s %s\n' "$1" "$2"; }
refuse() { say REFUSED "$1"; rm -rf "$WORK"; exit 1; }

PY=""
for cand in python python3 py; do
  if command -v "$cand" > /dev/null 2>&1 && "$cand" -c 'import zipfile' > /dev/null 2>&1; then PY="$cand"; break; fi
done
[ -n "$PY" ] || refuse "no working python 3 found"

# ---------- copy ----------
mkdir -p "$COPY/_source-corpus"
cp "$ROOT/CLAUDE.md" "$ROOT/CONTEXT.md" "$ROOT/README.md" "$ROOT/LICENSE" "$COPY/"
cp -r "$ROOT/stages" "$ROOT/_reference" "$ROOT/_templates" "$ROOT/_system" "$COPY/"
cp -r "$ROOT/_source-corpus/ICM-architect" "$COPY/_source-corpus/"
rm -rf "$COPY/_source-corpus/ICM-architect/.git"
find "$COPY" -name '*.tmp' -o -name '*.sweep.*' | xargs -r rm -f
say pass "copied to a scratch folder"

# owner terms begin
# Words that must not survive in the copy: the owner's names, source kits, run
# slugs, local paths. Case-insensitive extended regex. Emptied in the copy.
OWNER_TERMS='rymac|video-pipeline|characterworldengine|pelto|aaf-video|bmc_zip|users[\\/]allis|allis|coco@|tacomadevs|founder-lgw'
# owner terms end

# ---------- reword ----------
"$PY" - "$COPY" <<'EOF'
import sys, os
copy = sys.argv[1]
# replacements begin
R = {
 "README.md": [
  ("This is not hypothetical. In the source material sitting in `_source-corpus/`,\n1 concept (\"ICM\") is defined 6 different ways",
   "This is not hypothetical. In the material this factory was first built from, 1\nconcept (\"ICM\") was defined 6 different ways"),
  ("runs/video-pipeline/", "runs/<slug>/"),
  ("| `_source-corpus/` | Raw material: the ICM method, and old tool packages to convert. |",
   "| `_source-corpus/` | Raw material. Ships with the ICM method in `ICM-architect/`. A folder you drop here to convert is door B. |"),
 ],
 "_reference/prior-art.md": [
  ("`github.com/jordansshaw-pixel/PraxisLibrary_Bas`. Same owner as this factory.\nCC BY-NC 4.0, which this workspace is inside, being a free community resource.",
   "`github.com/jordansshaw-pixel/PraxisLibrary_Bas`, CC BY-NC 4.0. Nothing from\nit is copied into this factory. This note records a pattern, not content."),
  ("repeating-unit shape as the `_source-corpus/` tool packages. It is a door B\ningest candidate once the factory is proven, not a source of factory rules.",
   "repeating-unit shape as any tool package dropped into `_source-corpus/`. It is a\ndoor B ingest candidate, not a source of factory rules."),
  ("`c:\\pelto`. The house style, and the closest thing to a working reference\nimplementation. Stage contracts",
   "An earlier ICM workspace, not shipped with this factory. The closest thing to a\nworking reference implementation. Stage contracts"),
  ("## Pelto", "## An earlier ICM workspace"),
 ],
 "_reference/source-fidelity.md": [
  ("Recorded from the run that found it, `video-pipeline`, 2026-09-07.",
   "Recorded from the first build this factory ran, a video production kit, on\n2026-09-07."),
 ],
 "_reference/voice.md": [
  ("Laws 1 and 2 are adapted from\n`_source-corpus/rymac-production-line/checks/voice-check.sh`, which enforces the\nsame rules",
   "Laws 1 and 2 are adapted from the voice checker of the video production kit that\nwas this factory's first source, which enforces the same rules"),
 ],
 "_system/voice-check.sh": [
  ("# Laws 1 and 2 are adapted from _source-corpus/rymac-production-line/checks/voice-check.sh.\n# That script's law 3",
   "# Laws 1 and 2 are adapted from the voice checker of the video production kit\n# that was this factory's first source. That script's law 3"),
 ],
 "_system/validate.sh": [
  ("pelto runs its contracts 399 to 516 and\n# its root CONTEXT.md at 763.",
   "an earlier ICM workspace ran its\n# contracts at 399 to 516 and its root CONTEXT.md at 763."),
  ("# walk on characterworldengine, 2026-09-25.", "# walk on a real build, 2026-09-25."),
 ],
 "_system/test-gate.sh": [
  ("../pelto/voice.md", "../elsewhere/voice.md"),
  ("c:/pelto/x.md", "c:/elsewhere/x.md"),
 ],
}
# replacements end
missing = []
for rel, pairs in R.items():
    p = os.path.join(copy, rel)
    with open(p, encoding="utf-8", newline="") as fh: text = fh.read()
    for old, new in pairs:
        if old not in text: missing.append(f"{rel}: {old.splitlines()[0][:60]}"); continue
        text = text.replace(old, new)
    with open(p, "w", encoding="utf-8", newline="") as fh: fh.write(text)
if missing:
    print("\n".join("not found: " + m for m in missing)); sys.exit(1)
# The copy's own package.sh must not carry the words it exists to remove. Its
# replacement table is emptied; a buyer fills it with their own provenance lines.
me = os.path.join(copy, "_system", "package.sh")
with open(me, encoding="utf-8", newline="") as fh: src = fh.read()
a = src.index("# replacements begin\n"); b = src.index("# replacements end\n")
src = src[:a] + "# replacements begin\n# Add (old, new) pairs per file here for provenance lines of your own.\nR = {}\n" + src[b:]
a = src.index("# owner terms begin\n"); b = src.index("# owner terms end\n")
src = src[:a] + "# owner terms begin\n# Words that must not survive in the copy, as a case-insensitive extended regex.\nOWNER_TERMS=''\n" + src[b:]
with open(me, "w", encoding="utf-8", newline="") as fh: fh.write(src)
print(f"{sum(len(v) for v in R.values())} replacements landed; the copy's package.sh table is emptied")
EOF
[ $? -eq 0 ] || refuse "a provenance line has moved since the last cut; update the replacements in package.sh"

# ---------- the log that ships ----------
DATE=$(date +%Y-%m-%d)
sections=$(grep -cE '^# {3}[a-z-]+ {2,}' "$COPY/_system/validate.sh")
probes=$(grep -cE '^fresh; .*expect (PASS|FAIL)' "$COPY/_system/test-gate.sh")
blocks=$(ls "$COPY/_reference/blocks/"*.md | grep -vc README.md)
stages=$(ls -d "$COPY/stages/"*/ | wc -l)
cat > "$COPY/change-log.md" <<EOF
# Change log

Every change to \`_reference/\`, \`_templates/\`, or \`_system/\` gets an entry. A
block change also names the builds re-run, because a block edit that does not
reach the builds is drift with a paper trail.

Newest first.

---

## $DATE, packaged for release

This is the factory as it ships. The development record before this date was
the builder's working log and is not part of the package. Everything below is
what you hold.

- $stages stages, \`00_intake\` to \`04_validate\`, each a contract in \`stages/\`.
- $blocks blocks in \`_reference/blocks/\`, the single home for text that appears in
  more than 1 built agent.
- The gate, \`_system/validate.sh\`, runs $sections labelled sections. The script header
  is the list. \`entry\` holds \`AGENTS.md\` to \`CLAUDE.md\` byte for byte, for
  hosts that read \`AGENTS.md\` first; \`self-checks\` runs the checks a build
  ships on the files the factory wrote or repaired.
- \`_system/test-gate.sh\` proves the gate with $probes probes, planted defects that
  each block and legitimate look-alikes that each pass.
- \`_system/ship.sh <slug>\` zips a gated build into \`_dist/\`, re-running the gate
  first. \`_system/package.sh\` cut this package the same way.
- Budgets, as variables at the top of \`validate.sh\`: \`CLAUDE.md\` 800 tokens and
  60 lines, root \`CONTEXT.md\` 800 tokens, each stage contract 650 tokens.
- Voice laws 1 to 5 are gated by \`_system/voice-check.sh\`. Law 3, digits, reads
  the files the factory writes; files copied from a source keep their author's
  numbers.
- \`_source-corpus/\` holds the ICM method (\`ICM-architect/\`, MIT-licensed). It is
  otherwise empty. A folder you want converted goes here, 1 per run.
- \`runs/\`, \`builds/\` and \`_dist/\` are empty. The first run fills them.

Builds: none.
EOF
say pass "change-log.md replaced by the release entry"

# ---------- check the copy ----------
if ! bash "$COPY/_system/test-gate.sh" > "$WORK/tg.txt" 2>&1; then tail -3 "$WORK/tg.txt"; refuse "test-gate.sh fails inside the copy"; fi
say pass "$(tail -1 "$WORK/tg.txt")"
if ! bash "$COPY/_system/audit-builds.sh" > "$WORK/ab.txt" 2>&1; then cat "$WORK/ab.txt"; refuse "audit-builds.sh fails inside the copy"; fi
say pass "audit-builds.sh: $(head -1 "$WORK/ab.txt")"
for part in CLAUDE.md CONTEXT.md README.md change-log.md stages _reference _templates _system; do
  if ! bash "$COPY/_system/voice-check.sh" "$COPY/$part" > "$WORK/vc.txt" 2>&1; then cat "$WORK/vc.txt"; refuse "voice laws broken in the copy, $part"; fi
done
say pass "voice-check.sh: clean on every file the factory writes"
n=$(grep -rao --exclude-dir=_source-corpus "$EM" "$COPY" | wc -l)
[ "$n" -eq 0 ] || refuse "$n em dash byte(s) in files the factory writes"
say pass "em dash bytes in files the factory writes: 0"
if [ -n "$OWNER_TERMS" ]; then
  hits=$(grep -rnIiE "$OWNER_TERMS" "$COPY" | head -5)
  [ -z "$hits" ] || { echo "$hits"; refuse "the copy still names the owner, a run, or a local path"; }
  say pass "no owner, run, or local path named"
else
  say note "OWNER_TERMS is empty; nothing was checked for the owner's names. Fill it in above."
fi

# ---------- zip ----------
mkdir -p "$DIST"
OUT="$DIST/icm-factory-$DATE.zip"; v=1
while [ -e "$OUT" ]; do v=$((v + 1)); OUT="$DIST/icm-factory-$DATE-v$v.zip"; done
"$PY" - "$COPY" "$OUT" <<'EOF'
import os, sys, zipfile
copy, out = sys.argv[1:3]
files = {}
for root, dirs, names in os.walk(copy):
    dirs.sort()
    for name in sorted(names):
        path = os.path.join(root, name)
        files["icm-factory/" + os.path.relpath(path, copy).replace(os.sep, "/")] = path
with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
    for entry in sorted(files): z.write(files[entry], entry)
problems = []
with zipfile.ZipFile(out) as z:
    names = set(z.namelist())
    problems += ["missing: " + e for e in sorted(set(files) - names)]
    problems += ["extra:   " + e for e in sorted(names - set(files))]
    for entry in sorted(set(files) & names):
        with open(files[entry], "rb") as fh:
            if z.read(entry) != fh.read(): problems.append("differs: " + entry)
if problems:
    os.remove(out); print("\n".join(problems)); sys.exit(1)
print(f"{len(files)} files")
EOF
[ $? -eq 0 ] || refuse "zip did not match the copy and was deleted"

rm -rf "$WORK"
say shipped "${OUT#$ROOT/}"
exit 0
