#!/usr/bin/env bash
# check-stages.sh - finds a GAP in the production sequence, never a missing
# later stage. A video sitting at stage 2 is not behind, it is at stage 2. But
# a folder that holds a STORYBOARD and no SCRIPT skipped a stage, and skipping
# a stage is the single most expensive defect on this line.
#
# Usage:  bash checks/check-stages.sh [production-root]   (default: production)
#
# READ ONLY. Exit is always 0. This script informs, it never blocks.

ROOT="${1:-production}"

# The rail, in order. Each row is NAME|filename-pattern.
# VO is deliberately not on the list: a live one-take screen share has no
# voiceover fold, and a warning that never goes away is not a warning.
# SCRIPT accepts a BOARD in its slot: a run sheet sitting at the script's
# position IS the script stage for a live build.
STAGES="GAMEPLAN|GAMEPLAN
SCRIPT|(SCRIPT|BOARD)
SPEC|SPEC
STORYBOARD|STORYBOARD"

[ -d "$ROOT" ] || { echo "check-stages: no $ROOT/ folder here, nothing to check"; exit 0; }

shipped=0
jumped=0

for dir in "$ROOT"/*/; do
  [ -d "$dir" ] || continue

  # Shipped work is not nagged. A stage cannot be un-jumped after the fact.
  if ls "$dir"out/*.mp4 >/dev/null 2>&1; then
    shipped=$((shipped+1)); continue
  fi

  # Walk the rail top down. Remember the deepest stage present, then flag any
  # earlier stage that is missing behind it.
  present=""
  missing=""
  while IFS="|" read -r name pat; do
    [ -n "$name" ] || continue
    # Whole-segment match: NN-...-NAME. Without this, 09-DESCRIPTION.md counts
    # as a SCRIPT (DE-SCRIPT-ION) and the exact video that skipped its script
    # reads clean.
    if ls "$dir" 2>/dev/null | grep -qiE "^[0-9]{2}-(.+-)?${pat}([-.]|$)"; then
      if [ -n "$missing" ]; then
        echo "⛔ $dir has $name but is missing:$missing  <- build the missing stage first"
        jumped=$((jumped+1))
        missing=""
      fi
      present="$name"
    else
      missing="$missing $name"
    fi
  done <<EOF
$STAGES
EOF
done

echo "check-stages: $shipped shipped folder(s) skipped, $jumped gap(s) found."
echo "The rail is GAMEPLAN, SCRIPT, SPEC, VO, STORYBOARD, 90s, RENDER, PACKAGE, BLOG."
echo "Read the stage NAME, never trust the digits. Numbering varies between videos."
exit 0
