#!/usr/bin/env bash
# ship.sh - zip a gated build for hand-over.
#
# Usage:  bash _system/ship.sh <slug>
#
# Exit 0 = zipped and verified. Exit 1 = refused, and no zip was written.
#
# This is the only path from builds/<slug>/ to a zip. It refuses unless the run's
# gate report is status: approved with verdict: pass in its frontmatter, and it
# runs validate.sh again first, because a block or a rule may have changed since
# the report was written. The zip lands in _dist/<slug>-<date>[-vN].zip, every
# entry rooted at <slug>/, so it unpacks to 1 folder. A second cut on the same
# day gets -v2, -v3, and never overwrites.
#
# After writing, the zip is read back and checked against the tree: every file
# in the build is in the zip byte for byte, and nothing else is. A zip that fails
# that is deleted. Empty folders are not carried by a zip; the gate's `empty`
# check is what keeps a build from relying on one.
#
# The agent's own work, everything under runs/ but its README.md, is left out.
# A hand-over carries the agent, never what it did for someone.
#
# Needs python 3 for the zip itself; neither zip nor 7z is assumed on the machine.

SLUG="${1:?usage: ship.sh <slug>}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD="$ROOT/builds/$SLUG"
REPORT="$ROOT/runs/$SLUG/04-gate-report.md"
DIST="$ROOT/_dist"

say() { printf '%-9s %s\n' "$1" "$2"; }

[ -d "$BUILD" ] || { say REFUSED "no build at builds/$SLUG"; exit 1; }
[ -f "$REPORT" ] || { say REFUSED "no gate report at runs/$SLUG/04-gate-report.md; run 04_validate"; exit 1; }

fm() { awk 'NR==1 && /^---[[:space:]]*$/ {f=1; next} f && /^---[[:space:]]*$/ {exit} f' "$REPORT"; }
fm | grep -qE '^status: approved[[:space:]]*$' || { say REFUSED "gate report is not status: approved in its frontmatter"; exit 1; }
fm | grep -qE '^verdict: pass[[:space:]]*$'    || { say REFUSED "gate report verdict is not pass"; exit 1; }

if ! bash "$ROOT/_system/validate.sh" "$SLUG" > /tmp/ship.$$ 2>&1; then
  say REFUSED "the gate blocks this build now; the report is stale"
  grep '^FAIL' /tmp/ship.$$; rm -f /tmp/ship.$$; exit 1
fi
rm -f /tmp/ship.$$
say pass "gate re-run, clean"

# Pick an interpreter that runs. On Windows, python3 may resolve to a Store
# alias that prints an install hint and exits nonzero, so each candidate is tried.
PY=""
for cand in python python3 py; do
  if command -v "$cand" > /dev/null 2>&1 && "$cand" -c 'import zipfile' > /dev/null 2>&1; then PY="$cand"; break; fi
done
[ -n "$PY" ] || { say REFUSED "no working python 3 found; the zip is written by python"; exit 1; }

mkdir -p "$DIST"
DATE=$(date +%Y-%m-%d)
OUT="$DIST/$SLUG-$DATE.zip"; n=1
while [ -e "$OUT" ]; do n=$((n + 1)); OUT="$DIST/$SLUG-$DATE-v$n.zip"; done

"$PY" - "$BUILD" "$OUT" "$SLUG" <<'EOF'
import os, sys, zipfile
build, out, slug = sys.argv[1:4]
files = {}
runs = os.path.join(build, "runs")
for root, dirs, names in os.walk(build):
    dirs.sort()
    if root == runs:
        dirs[:] = []                              # the agent's own units stay home
        names = [n for n in names if n == "README.md"]
    for name in sorted(names):
        path = os.path.join(root, name)
        files[slug + "/" + os.path.relpath(path, build).replace(os.sep, "/")] = path
with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
    for entry in sorted(files):
        z.write(files[entry], entry)
problems = []
with zipfile.ZipFile(out) as z:
    names = set(z.namelist())
    for entry in sorted(set(files) - names): problems.append("missing from zip: " + entry)
    for entry in sorted(names - set(files)): problems.append("not in build:    " + entry)
    for entry in sorted(set(files) & names):
        with open(files[entry], "rb") as fh:
            if z.read(entry) != fh.read(): problems.append("differs:         " + entry)
if problems:
    os.remove(out)
    print("\n".join(problems))
    sys.exit(1)
kept = sum(len(n) for r, d, n in os.walk(runs) if r != runs) if os.path.isdir(runs) else 0
print(f"{len(files)} files" + (f", {kept} run files left out" if kept else ""))
EOF
rc=$?
if [ "$rc" -ne 0 ]; then
  if [ -e "$OUT" ]; then rm -f "$OUT"; say REFUSED "python failed before the zip was verified; nothing shipped"
  else say REFUSED "zip did not match the build and was deleted"; fi
  exit 1
fi

say shipped "${OUT#$ROOT/}"
exit 0
