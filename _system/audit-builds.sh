#!/usr/bin/env bash
# audit-builds.sh - re-run the gate across every shipped build.
#
# Usage:  bash _system/audit-builds.sh
#
# Run this after changing a block, the emission standard, or a voice law. It
# answers the only question that matters after a factory change: which agents
# already out the door have fallen behind?
#
# Exit 0 = every build passes. Exit 1 = at least one trails.

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
fail=0
pass=0
blocked=""

builds=$(find "$ROOT/builds" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | sort)
[ -n "$builds" ] || { echo "audit: no builds yet"; exit 0; }

for b in $builds; do
  slug=$(basename "$b")
  if bash "$ROOT/_system/validate.sh" "$slug" > /tmp/audit.$$ 2>&1; then
    printf '%-28s PASS\n' "$slug"
    pass=$((pass + 1))
  else
    reasons=$(grep '^FAIL' /tmp/audit.$$ | sed 's/^FAIL  *//' | head -3 | tr '\n' ';' | sed 's/;$//')
    printf '%-28s FAIL  %s\n' "$slug" "$reasons"
    blocked="$blocked $slug"
    fail=1
  fi
  rm -f /tmp/audit.$$
done

echo
echo "$pass passing."
if [ "$fail" -eq 1 ]; then
  echo "Trailing:$blocked"
  echo "Re-run each through 02_scaffold onward. Do not patch inside builds/."
fi
exit $fail
