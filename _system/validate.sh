#!/usr/bin/env bash
# validate.sh - the gate. A build that fails this does not ship.
#
# Usage:  bash _system/validate.sh <slug>
#
# Exit 0 = pass. Exit 1 = blocked. There is no ship-anyway flag by design: a
# failure is fixed in the factory and the build is re-run, never patched inside
# builds/. A check that cannot read its target FAILS; silence is never a pass.
#
# The checks, one labelled section each. This header is the list, and nothing
# else in the factory enumerates them.
#   structure   the required files and folders exist
#   entry       AGENTS.md exists and is CLAUDE.md byte for byte, for hosts that read AGENTS.md
#   isolation   no path climbs out of the build, no name for the factory, no absolute path
#   budget      the entry file, root CONTEXT.md and every contract fit their token limits
#   routing     every path a routing file or a contract names resolves inside the build
#   contracts   every stage contract carries its sections and exactly 1 human check
#   residue     nothing from the factory or the skeleton is left in the build
#   empty       no empty folder; a zip drops it, so the build unpacked is not the build gated
#   hygiene     the factory's own stages/ holds contracts only (a factory fault, not the build's)
#   chain       the run behind the build is status: approved at every stage
#   blocks      every block the emit log names matches its single home, verbatim
#   voice       the writing laws hold (voice-check.sh); digits on authored files only
#   self-checks the build passes the checks it ships (check: lines in the manifest)
#
# Skipped on purpose: Unix absolute paths outside markdown links, because shebangs
# and /tmp are legitimate in scripts. A path carrying a <placeholder> is not a
# literal path and is never resolved. Probes for every check live in test-gate.sh.

SLUG="${1:?usage: validate.sh <slug>}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD="$ROOT/builds/$SLUG"
RUN="$ROOT/runs/$SLUG"
LIB="$ROOT/_reference/blocks"
fail=0

# Token limits, ~4 chars per token. Measured, not guessed: the method puts L0 at
# 300 to 800 and L1 and L2 at 200 to 500; pelto runs its contracts 399 to 516 and
# its root CONTEXT.md at 763. Contracts went 500 to 650 to 750 on 2026-09-07 and
# came back to 650 the same day, once the rules they restated were replaced with
# pointers. A file over its limit is restating constraints that belong in
# _reference/: split it or push the detail down, not this number.
CLAUDE_LIMIT=800; CLAUDE_LINES=60; CONTEXT_LIMIT=800; CONTRACT_LIMIT=650

say()    { printf '%-11s %s\n' "$1" "$2"; }
bad()    { say "FAIL" "$1"; fail=1; }
good()   { say "pass" "$1"; }
tokens() { echo $(( $(wc -c < "$1") / 4 )); }

[ -d "$BUILD" ] || { echo "validate: FAILURE, no build at builds/$SLUG"; exit 1; }
echo "gate: builds/$SLUG"
echo

# every text file in the build, one per line; grep -I decides what is binary
TEXT=$(find "$BUILD" -type f -print0 2>/dev/null | while IFS= read -r -d '' f; do LC_ALL=C grep -Iq . "$f" 2>/dev/null && printf '%s\n' "$f"; done)
stages=$(find "$BUILD" -maxdepth 1 -type d -name '[0-9][0-9]_*' 2>/dev/null | sort)

# ---------- structure ----------
for req in CLAUDE.md CONTEXT.md README.md; do
  [ -f "$BUILD/$req" ] || bad "structure: missing $req"
done
[ -d "$BUILD/_reference" ] || bad "structure: missing _reference/"
for s in $stages; do
  [ -f "$s/CONTEXT.md" ] || bad "structure: $(basename "$s") has no CONTEXT.md"
done
[ -n "$stages" ] || bad "structure: no NN_ stage folder; a build without a line gives the gate nothing to check"
[ "$fail" -eq 0 ] && good "structure: required files present"

# ---------- entry ----------
# Hosts differ on the entry file. Claude Code reads CLAUDE.md. Hermes and Codex
# read AGENTS.md first and load it as literal text; a pointer inside it is not
# followed. So 03_emit copies CLAUDE.md to AGENTS.md and the build ships both,
# with CLAUDE.md the 1 home. A hand edit to either shows up here as a difference.
en=0
if [ ! -f "$BUILD/AGENTS.md" ]; then
  bad "entry: missing AGENTS.md, the copy of CLAUDE.md that AGENTS.md hosts read"; en=1
elif [ -f "$BUILD/CLAUDE.md" ] && ! cmp -s "$BUILD/CLAUDE.md" "$BUILD/AGENTS.md"; then
  bad "entry: AGENTS.md differs from CLAUDE.md; re-emit, never hand-edit either"; en=1
fi
[ "$en" -eq 0 ] && good "entry: AGENTS.md is CLAUDE.md byte for byte"

# ---------- isolation ----------
iso=0
# a. a file d folders below the root may climb d levels and no further. Depth-aware,
#    so skills/x/README.md may say ../../README.md and a root file may not say ../
while IFS= read -r f; do
  [ -n "$f" ] || continue
  rel="${f#$BUILD/}"
  depth=$(printf '%s' "$rel" | tr -cd '/' | wc -c)
  hits=$(grep -nE "(\.\.[\\/]){$((depth + 1))}" "$f" 2>/dev/null | head -3)
  [ -n "$hits" ] && { bad "isolation: $rel climbs out of the build"; echo "$hits"; iso=1; }
done <<< "$TEXT"
# b. the factory's name, in any spelling: icm-factory, ICM Factory, icm_factory, ICMFactory
hits=$(grep -rnIiE 'icm[-_ ]?factory' "$BUILD" 2>/dev/null | head -5)
[ -n "$hits" ] && { bad "isolation: names the factory"; echo "$hits"; iso=1; }
# c. Windows absolute paths in any text file; a path carrying a <placeholder> is not literal
hits=$(grep -rnIE '(^|[^A-Za-z0-9])[A-Za-z]:[\\/]' "$BUILD" 2>/dev/null | grep -vE '[A-Za-z]:[\\/][^[:space:]]*<' | head -5)
[ -n "$hits" ] && { bad "isolation: absolute path"; echo "$hits"; iso=1; }
# d. a Unix absolute path as a markdown link target; ](//host) is protocol-relative and not a path
hits=$(grep -rnE '\]\(/[^/)]' "$BUILD" --include='*.md' 2>/dev/null | head -5)
[ -n "$hits" ] && { bad "isolation: markdown link to an absolute path"; echo "$hits"; iso=1; }
[ "$iso" -eq 0 ] && good "isolation: no path leaves the build"

# ---------- budget ----------
bud=0
if [ -f "$BUILD/CLAUDE.md" ]; then
  t=$(tokens "$BUILD/CLAUDE.md"); l=$(wc -l < "$BUILD/CLAUDE.md")
  [ "$t" -gt "$CLAUDE_LIMIT" ] && { bad "budget: CLAUDE.md ~${t}t, limit $CLAUDE_LIMIT"; bud=1; }
  [ "$l" -gt "$CLAUDE_LINES" ] && { bad "budget: CLAUDE.md ${l} lines, limit $CLAUDE_LINES"; bud=1; }
fi
if [ -f "$BUILD/CONTEXT.md" ]; then
  t=$(tokens "$BUILD/CONTEXT.md")
  [ "$t" -gt "$CONTEXT_LIMIT" ] && { bad "budget: CONTEXT.md ~${t}t, limit $CONTEXT_LIMIT"; bud=1; }
fi
for s in $stages; do
  [ -f "$s/CONTEXT.md" ] || continue
  t=$(tokens "$s/CONTEXT.md")
  [ "$t" -gt "$CONTRACT_LIMIT" ] && { bad "budget: $(basename "$s")/CONTEXT.md ~${t}t, limit $CONTRACT_LIMIT"; bud=1; }
done
[ "$bud" -eq 0 ] && good "budget: entry, root CONTEXT.md and contracts within range"

# ---------- routing ----------
# A route is a backticked relative path. In the root files any backticked file or
# folder is a route. In a stage contract only a token with a directory part is a
# route; a bare name like `00-intake.md` there is prose. A contract's route is
# tried from the contract's folder, then from the build root, because a Do NOT
# load line in house style names root folders bare. <placeholders> and {{slots}}
# are never resolved, and a path that climbs out of the build is isolation's
# finding, not routing's.
rt=0
PATHRE='`(\.\./)*(\./)?[A-Za-z_][A-Za-z0-9_./<>{}-]*(\.(md|sh|ps1|mjs|js|py|html|txt|json|tsx)|/)`'
routes() {  # $1 file, $2 root|contract, $3 depth of the file below the root: prints every route that does not resolve
  local f="$1" mode="$2" depth="$3" dir p q up
  dir=$(dirname "$f")
  grep -oE "$PATHRE" "$f" 2>/dev/null | tr -d '`' | sort -u | while IFS= read -r p; do
    case "$p" in *'<'*|*'{{'*) continue;; esac
    if [ "$mode" = contract ]; then case "$p" in */*) ;; *) continue;; esac; fi
    up=0; q="$p"; while [ "${q#../}" != "$q" ]; do q="${q#../}"; up=$((up + 1)); done
    [ "$up" -gt "$depth" ] && continue
    [ -e "$dir/$p" ] || [ -e "$BUILD/$p" ] || printf '%s\n' "$p"
  done
}
for f in "$BUILD/CLAUDE.md" "$BUILD/CONTEXT.md"; do
  [ -f "$f" ] || continue
  while IFS= read -r p; do
    [ -n "$p" ] && { bad "routing: $(basename "$f") points at missing $p"; rt=1; }
  done < <(routes "$f" root 0)
done
for s in $stages; do
  [ -f "$s/CONTEXT.md" ] || continue
  while IFS= read -r p; do
    [ -n "$p" ] && { bad "routing: $(basename "$s")/CONTEXT.md points at missing $p"; rt=1; }
  done < <(routes "$s/CONTEXT.md" contract 1)
done
[ "$rt" -eq 0 ] && good "routing: every named path resolves"

# ---------- contracts ----------
ct=0
for s in $stages; do
  c="$s/CONTEXT.md"
  [ -f "$c" ] || continue
  n=$(basename "$s")
  grep -q '^## Inputs'      "$c" || { bad "contracts: $n missing ## Inputs"; ct=1; }
  grep -q '^Do NOT load:'   "$c" || { bad "contracts: $n missing 'Do NOT load:' line"; ct=1; }
  grep -q '^## Process'     "$c" || { bad "contracts: $n missing ## Process"; ct=1; }
  grep -q '^## Outputs'     "$c" || { bad "contracts: $n missing ## Outputs"; ct=1; }
  h=$(grep -c '^## Human check' "$c")
  [ "$h" -eq 1 ] || { bad "contracts: $n has $h Human check sections, need exactly 1"; ct=1; }
done
[ "$ct" -eq 0 ] && good "contracts: all complete"

# ---------- residue ----------
# Skeleton slots and block markers can only survive in files the scaffold authored:
# the root markdown, the stage contracts, and _reference/*.md. Copied source files
# (skills, assets) may legitimately carry {{slots}} of their own.
rs=0
AUTHORED=$( { ls "$BUILD"/*.md 2>/dev/null; for s in $stages; do ls "$s"/CONTEXT.md 2>/dev/null; done; ls "$BUILD"/_reference/*.md 2>/dev/null; } )
while IFS= read -r f; do
  [ -f "$f" ] || continue
  h=$(grep -n '^BLOCK:' "$f" | head -3); [ -n "$h" ] && { bad "residue: unresolved BLOCK marker in ${f#$BUILD/}"; echo "$h"; rs=1; }
  h=$(grep -n '{{' "$f" | head -3);      [ -n "$h" ] && { bad "residue: unfilled {{slot}} in ${f#$BUILD/}"; echo "$h"; rs=1; }
done <<< "$AUTHORED"
hits=$(grep -rnE '^stage: 0[0-4]_(intake|form|scaffold|emit|validate)' "$BUILD" --include='*.md' 2>/dev/null | head -5)
[ -n "$hits" ] && { bad "residue: factory stage frontmatter left in build"; echo "$hits"; rs=1; }
stray=$(find "$BUILD" -maxdepth 1 \( -iname 'manifest.md' -o -iname 'skeleton.md' \) 2>/dev/null)
[ -n "$stray" ] && { bad "residue: scaffold file shipped in the build"; echo "$stray"; rs=1; }
[ "$rs" -eq 0 ] && good "residue: nothing from the factory left behind"

# ---------- empty ----------
# An empty folder is always a scaffold leftover, and a zip drops it, so a build
# that passes with one is not the build a recipient unpacks. Found by the cold
# walk on characterworldengine, 2026-09-25.
ef=0
hits=$(find "$BUILD" -mindepth 1 -type d -empty 2>/dev/null | head -5)
[ -n "$hits" ] && { bad "empty: folder with nothing in it; remove it from the scaffold and re-emit"; echo "$hits"; ef=1; }
[ "$ef" -eq 0 ] && good "empty: no empty folder"

# ---------- factory hygiene ----------
# Not about this build: stages/ holds contracts only, and no run may leave
# anything behind in it. Checked on every gate run because the cost is one find
# and the failure mode is silent accumulation.
fh=0
stray=$( { find "$ROOT/stages" -mindepth 1 -type f -not -name 'CONTEXT.md'; find "$ROOT/stages" -mindepth 2 -type d; } 2>/dev/null | head -5)
[ -n "$stray" ] && { bad "hygiene: FACTORY fault, not this build: stages/ holds something other than contracts"; echo "$stray"; fh=1; }
[ "$fh" -eq 0 ] && good "hygiene: stages/ holds contracts only"

# ---------- chain ----------
# The run behind this build must be on record and approved at every stage. The
# approval stays a human act; this only refuses to pass a build whose chain is not.
# Frontmatter only: an emit log that quotes a stripped status: line in its body
# does not count as approved.
ch=0
approved() {
  awk 'NR==1 && /^---[[:space:]]*$/ {fm=1; next} fm && /^---[[:space:]]*$/ {exit} fm' "$1" | grep -qE '^status: approved[[:space:]]*$'
}
for f in 00-intake.md 01-plan.md 02-scaffold/manifest.md 03-emit-log.md; do
  if [ ! -f "$RUN/$f" ]; then bad "chain: runs/$SLUG/$f is missing"; ch=1
  elif ! approved "$RUN/$f"; then bad "chain: runs/$SLUG/$f is not status: approved in its frontmatter"; ch=1
  fi
done
[ "$ch" -eq 0 ] && good "chain: every stage output approved"

# ---------- blocks ----------
# Every block the emit log names must still match _reference/blocks/<name>.md, so
# a block edit fails every shipped build that carries the old text. Every block
# marked every-build: yes must be in the log; walk-test when the build has 3+ stages.
bk=0
LOG="$RUN/03-emit-log.md"
body_of() { awk 'NR==1 && /^---[[:space:]]*$/ {fm=1; next} fm && /^---[[:space:]]*$/ {fm=0; next} !fm' "$1"; }
flat()    { tr '\n\r' '  ' | tr -s ' ' | sed -E 's/^ //; s/ $//'; }
if [ ! -d "$LIB" ]; then
  bad "blocks: _reference/blocks/ is missing from the factory"; bk=1
elif [ -f "$LOG" ]; then
  # one line per block: `block: <name> -> <path>`; the path may be backticked or carry builds/<slug>/
  logged=$(sed -nE 's/^block: ([A-Za-z0-9_-]+) -> `?([^`[:space:]]+)`?[[:space:]]*$/\1 \2/p' "$LOG" | tr -d '\r')
  while read -r name file; do
    [ -n "$name" ] || continue
    file="${file#builds/$SLUG/}"
    [ -f "$LIB/$name.md" ] || { bad "blocks: $name is in the emit log and not in _reference/blocks/"; bk=1; continue; }
    [ -f "$BUILD/$file" ]  || { bad "blocks: $name should sit in $file, which is missing"; bk=1; continue; }
    body=$(body_of "$LIB/$name.md" | flat)
    [ -n "$body" ] || { bad "blocks: $name has an empty body in _reference/blocks/"; bk=1; continue; }
    target=$(flat < "$BUILD/$file")
    case "$target" in
      *"$body"*) ;;
      *) bad "blocks: $name in $file differs from _reference/blocks/$name.md, re-run the build"; bk=1 ;;
    esac
  done <<< "$logged"
  nst=$(printf '%s\n' "$stages" | grep -c .)
  for b in "$LIB"/*.md; do
    n=$(basename "$b" .md); [ "$n" = README ] && continue
    ev=$(grep -m1 '^every-build:' "$b" | sed -E 's/^every-build:[[:space:]]*//' | tr -d '\r')
    need=0
    [ "$ev" = yes ] && need=1
    [ "$n" = walk-test ] && [ "$nst" -ge 3 ] && need=1
    if [ "$need" -eq 1 ] && ! printf '%s\n' "$logged" | grep -q "^$n "; then
      bad "blocks: $n belongs in every build and is not in the emit log"; bk=1
    fi
  done
else
  bad "blocks: runs/$SLUG/03-emit-log.md is missing, block parity cannot be checked"; bk=1
fi
[ "$bk" -eq 0 ] && good "blocks: every block matches its single home"

# ---------- voice ----------
# Laws 1, 2, 4 and 5 on every file. Law 3 (digits) on AUTHORED only, the files
# the scaffold authors or repairs: files copied from a source keep their
# author's numbers, so the whole-build pass runs with DIGITS=0.
vc=0
if ! DIGITS=0 bash "$ROOT/_system/voice-check.sh" "$BUILD" > /tmp/vc.$$ 2>&1; then
  bad "voice: laws broken"; cat /tmp/vc.$$; vc=1
fi
while IFS= read -r f; do
  [ -f "$f" ] || continue
  if ! bash "$ROOT/_system/voice-check.sh" "$f" > /tmp/vc.$$ 2>&1; then
    bad "voice: laws broken in ${f#$BUILD/}"; grep -v '^voice-check' /tmp/vc.$$; vc=1
  fi
done <<< "$AUTHORED"
rm -f /tmp/vc.$$
[ "$vc" -eq 0 ] && good "voice: clean"

# ---------- self-checks ----------
# A build that ships its own checks must pass them. The manifest lists each one
# as `check: <command> :: <files>`, {file} standing for each listed file, the
# command run from the build root; any nonzero exit blocks. `check: none` says
# the build ships no checks. A manifest with neither has not decided, and blocks.
sc=0
MAN="$RUN/02-scaffold/manifest.md"
if [ ! -f "$MAN" ]; then
  bad "self-checks: runs/$SLUG/02-scaffold/manifest.md is missing"; sc=1
else
  lines=$(grep -E '^check: ' "$MAN" | tr -d '\r')
  if [ -z "$lines" ]; then
    bad "self-checks: the manifest has no check: line; write 'check: none' if the build ships no checks"; sc=1
  elif [ "$lines" != "check: none" ]; then
    while IFS= read -r line; do
      [ -n "$line" ] || continue
      [ "$line" = "check: none" ] && { bad "self-checks: 'check: none' sits beside a check; pick one"; sc=1; continue; }
      spec="${line#check: }"
      cmd="${spec%% :: *}"; files="${spec#* :: }"
      [ "$cmd" != "$spec" ] || { bad "self-checks: no ' :: ' between command and files in '$line'"; sc=1; continue; }
      set -f; globs=($files); set +f   # split on spaces without globbing here: the globs expand inside the build
      for g in "${globs[@]}"; do
        matched=0
        for f in $(cd "$BUILD" && ls -d $g 2>/dev/null); do
          matched=1
          run="${cmd//\{file\}/$f}"
          if ! (cd "$BUILD" && eval "$run") > /tmp/sc.$$ 2>&1; then
            bad "self-checks: '$run' failed"; head -6 /tmp/sc.$$; sc=1
          fi
        done
        [ "$matched" -eq 1 ] || { bad "self-checks: '$g' matches nothing in the build"; sc=1; }
      done
    done <<< "$lines"
    rm -f /tmp/sc.$$
  fi
fi
[ "$sc" -eq 0 ] && good "self-checks: the build passes the checks it ships"

echo
if [ "$fail" -eq 0 ]; then
  echo "GATE PASS - builds/$SLUG may ship once a human completes the cold walk."
else
  echo "GATE BLOCKED - fix in the factory and re-run the build. Do not patch builds/$SLUG."
fi
exit $fail
