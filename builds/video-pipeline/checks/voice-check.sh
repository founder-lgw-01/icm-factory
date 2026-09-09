#!/usr/bin/env bash
# voice-check.sh - the voice laws, run against the bytes that are about to ship.
#
# Usage:  bash checks/voice-check.sh <file-or-video-folder>
#
# Exit 0 = clean. Exit 1 = a law is broken. A file this script cannot read is a
# FAILURE, never a pass: a guard that reports clean on a file it never opened
# is worse than no guard, because it is the one you believe.
#
# Your own banned words and your standing close live in _config/my-line.md.
# This script reads them from there so the laws are yours, not anybody else's.
#
# Quotes and testimonials are exempt. These laws police what YOU say. Editing a
# customer's words to satisfy your style rules is falsifying a testimonial.

TARGET="${1:?usage: voice-check.sh <file-or-folder>}"
CONFIG="${CONFIG:-_config/my-line.md}"
fail=0

# Collect files
if [ -d "$TARGET" ]; then
  FILES=$(find "$TARGET" -maxdepth 1 -type f \( -name "*.md" -o -name "*.txt" \) 2>/dev/null)
else
  FILES="$TARGET"
fi
[ -n "$FILES" ] || { echo "voice-check: FAILURE, nothing readable at $TARGET"; exit 1; }

# prose view: blank headings, blockquotes, table rules, code fences
prose() {
  LC_ALL=C sed -E 's/^#+ .*$//; s/^> .*$//; s/^\|[-| ]+\|$//' "$1" | awk '
    /^```/ { inCode = !inCode; next }
    !inCode { print }
  '
}

for f in $FILES; do
  [ -r "$f" ] || { echo "voice-check: FAILURE, cannot read $f"; fail=1; continue; }

  # LAW 1: no em dashes, anywhere in prose
  hits=$(prose "$f" | grep -n $'\xe2\x80\x94' | head -5)
  if [ -n "$hits" ]; then echo "⛔ $f: em dash"; echo "$hits"; fail=1; fi

  # LAW 2: the empty summary sentence ("that's the ... thing/point/system")
  hits=$(prose "$f" | grep -inE "that('s| is| was) (it|all|the (entire |basic )?(thing|point|idea|system|setup|process))[.!]?$" | head -5)
  if [ -n "$hits" ]; then echo "⛔ $f: empty summary sentence, the fix is DELETE"; echo "$hits"; fail=1; fi

  # LAW 3: developer talk on a public surface (the sandwich is exempt)
  hits=$(prose "$f" | grep -inE "state machine|schema|stack trace|API endpoint|git commit|merge conflict" | grep -viE "may hear (that|it) called" | head -5)
  if [ -n "$hits" ]; then echo "⛔ $f: developer talk without a sandwich"; echo "$hits"; fail=1; fi

  # LAW 4: owner's own banned words, read from config (BANNED-WORDS: a, b, c)
  if [ -f "$CONFIG" ]; then
    banned=$(grep -i "^BANNED-WORDS:" "$CONFIG" | head -1 | cut -d: -f2- | tr ',' '|' | tr -d ' ')
    if [ -n "$banned" ]; then
      hits=$(prose "$f" | grep -inE "\b($banned)\b" | head -5)
      if [ -n "$hits" ]; then echo "⛔ $f: a word on your own banned list"; echo "$hits"; fail=1; fi
    fi
  fi

  # LAW 5: a script file is numbered slides, not prose.
  # Keys on the file name only, so a folder named 02-SCRIPT does not drag its
  # README into the law.
  base=$(basename "$f")
  case "$base" in
    README*|readme*) : ;;
    *SCRIPT*)
      n=$(grep -cE "^\| ?[0-9]{3} |^[0-9]{3}\." "$f")
      if [ "$n" -lt 10 ]; then
        echo "⛔ $f: a script is numbered slides (3 digits, 1 complete spoken thought, no period). Found $n slide lines, need 10+"
        fail=1
      fi
      ;;
  esac

  # LAW 6: the standing close, on channel scripts only.
  # Reads SURFACE: from the sibling gameplan. classroom and page skip the close.
  # No gameplan, or no SURFACE line, means enforce. Silence is never a pass.
  case "$base" in
    README*|readme*) : ;;
    *SCRIPT*|*FOLD*)
      dir=$(dirname "$f")
      surface=$(grep -ih "^SURFACE:" "$dir"/01-GAMEPLAN.md 2>/dev/null | head -1 | awk '{print tolower($2)}')
      if [ "$surface" != "classroom" ] && [ "$surface" != "page" ]; then
        close=$(grep -i "^CLOSE-WORDS:" "$CONFIG" 2>/dev/null | head -1 | cut -d: -f2-)
        if [ -n "$close" ]; then
          IFS=',' ; miss=""
          for w in $close; do
            w=$(echo "$w" | sed 's/^ *//; s/ *$//')
            grep -qi "$w" "$f" || miss="$miss [$w]"
          done
          unset IFS
          if [ -n "$miss" ]; then echo "⛔ $f: the standing close is missing:$miss"; fail=1; fi
        fi
      fi
      ;;
  esac
done

if [ "$fail" -eq 0 ]; then echo "voice-check: clean"; fi
exit $fail
