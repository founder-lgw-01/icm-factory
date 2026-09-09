#!/usr/bin/env bash
# sweep-em-dash.sh - the mechanical em dash sweep for markdown copied from a source.
#
# Usage:  bash _system/sweep-em-dash.sh <file.md | folder>
#
# 02_scaffold runs this on every markdown file it copies under an additive or
# leave-alone verdict. Voice law 1 bans the em dash everywhere and the gate blocks
# on it, so copied prose is repaired here, mechanically and on the record: every
# changed line is printed as file:line, before and after, for the human check to
# sample, and 02_scaffold lists each swept file in manifest.md.
#
# Rules, in order, on prose only:
#   1. an em dash that opens a line is a bullet, and becomes "- "
#   2. an em dash that closes a line ends the sentence, and becomes "."
#   3. every other em dash joins two clauses, and becomes ", "
#
# Fenced code is never touched and code files are never swept: an em dash there
# may be a working literal. Those lines print under SKIPPED so the manifest can
# list them under Inherited and a person decides each one.
#
# Needs GNU awk. Exit 0 after a sweep. Exit 1 when pointed at a code file or at
# nothing readable: silence is never a pass.

TARGET="${1:?usage: sweep-em-dash.sh <file.md | folder>}"
EM=$(printf '\xe2\x80\x94')

# Raw material is read-only. The sweep runs on the copy in the scaffold, never on
# the source it was copied from.
ABS="$(cd "$(dirname "$TARGET")" 2>/dev/null && pwd)/$(basename "$TARGET")"
case "$ABS" in
  *"/_source-corpus/"*) echo "sweep: REFUSED, $TARGET is raw material under _source-corpus/. Sweep the copy in the scaffold."; exit 1 ;;
esac

if [ -d "$TARGET" ]; then
  mapfile -d '' FILES < <(find "$TARGET" -type f -name '*.md' -print0 2>/dev/null)
elif [ -f "$TARGET" ]; then
  case "$TARGET" in
    *.md) FILES=("$TARGET") ;;
    *) echo "sweep: REFUSED, $TARGET is not markdown. Code is never swept; list its em dashes under Inherited."; exit 1 ;;
  esac
else
  echo "sweep: FAILURE, nothing readable at $TARGET"; exit 1
fi
[ "${#FILES[@]}" -gt 0 ] || { echo "sweep: no markdown under $TARGET"; exit 0; }

files=0; dashes=0; skipped=0
for f in "${FILES[@]}"; do
  before=$(grep -o "$EM" "$f" 2>/dev/null | wc -l)
  [ "$before" -gt 0 ] || continue
  tmp="$f.sweep.$$"
  LC_ALL=C awk -v BINMODE=3 -v EM="$EM" -v F="$f" '
    BEGIN { inCode = 0 }
    {
      line = $0; cr = ""
      if (sub(/\r$/, "", line)) cr = "\r"
      if (line ~ /^[ \t]*```/) { inCode = !inCode; print line cr; next }
      if (index(line, EM) == 0) { print line cr; next }
      if (inCode) { print "SKIPPED " F ":" NR ": " line > "/dev/stderr"; print line cr; next }
      was = line
      if (match(line, "^[ \t]*" EM "[ \t]*")) {
        ind = line; sub(/[^ \t].*$/, "", ind)
        line = ind "- " substr(line, RLENGTH + 1)
      }
      sub("[ \t]*" EM "[ \t]*$", ".", line)
      gsub("[ \t]*" EM "[ \t]*", ", ", line)
      print F ":" NR ": " was  > "/dev/stderr"
      print F ":" NR ": " line > "/dev/stderr"
      print line cr
    }' "$f" > "$tmp" 2> "$tmp.report" || { echo "sweep: FAILURE on $f"; rm -f "$tmp" "$tmp.report"; exit 1; }
  mv "$tmp" "$f"
  cat "$tmp.report"
  s=$(grep -c '^SKIPPED ' "$tmp.report"); rm -f "$tmp.report"
  after=$(grep -o "$EM" "$f" | wc -l)
  files=$((files + 1)); dashes=$((dashes + before - after)); skipped=$((skipped + s))
done

echo
echo "sweep: $dashes em dash(es) replaced in $files file(s); $skipped line(s) left inside fenced code."
[ "$skipped" -gt 0 ] && echo "List every SKIPPED line under Inherited in manifest.md. A person decides each one."
exit 0
