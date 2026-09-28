#!/usr/bin/env bash
# voice-check.sh - the factory's voice laws, run against the bytes about to ship.
#
# Usage:  bash _system/voice-check.sh <file-or-folder>
#
# Exit 0 = clean. Exit 1 = a law is broken. A file this script cannot read is a
# FAILURE, never a pass: a guard that reports clean on a file it never opened is
# worse than no guard, because it is the one you believe.
#
# Law 1 reads the raw bytes of every text file: code, headings and fences
# included; binaries are skipped. Laws 2, 4 and 5 read the prose view of markdown
# files only. Law 3 (digits) reads markdown minus code spans and fences; DIGITS=0
# skips it, which the gate sets for files copied from a source, whose numbers
# belong to their author. Law 6 in _reference/voice.md is style, read by a person.
#
# Laws 1 and 2 are adapted from _source-corpus/rymac-production-line/checks/voice-check.sh.
# That script's law 3 (developer talk) and laws 5 and 6 (numbered slides, a
# standing close) are video-specific and deliberately not carried over.

TARGET="${1:?usage: voice-check.sh <file-or-folder>}"
TARGET="${TARGET%/}"
fail=0
EM=$(printf '\xe2\x80\x94')

# A runs/ folder directly under the target is the product's own record: after
# use it holds an owner's or a customer's words, which no law here governs. Its
# note, runs/README.md, is the factory's and is read like any other file.
if [ -d "$TARGET" ]; then
  FILES=$(find "$TARGET" -type d -path "$TARGET/runs/*" -prune -o -type f -print 2>/dev/null)
else
  FILES="$TARGET"
fi
[ -n "$FILES" ] || { echo "voice-check: FAILURE, nothing readable at $TARGET"; exit 1; }

# prose view: blank out headings, blockquotes, table rules, code fences
prose() {
  LC_ALL=C sed -E 's/^#+ .*$//; s/^> .*$//; s/^\|[-| ]+\|$//' "$1" | awk '
    /^```/ { inCode = !inCode; next }
    !inCode { print }
  '
}

while IFS= read -r f; do
  [ -n "$f" ] || continue
  [ -r "$f" ] || { echo "voice-check: FAILURE, cannot read $f"; fail=1; continue; }
  # binary (a NUL in the first block), or empty: no text to read. LC_ALL=C so a
  # stray non-UTF-8 byte cannot make grep call a text file binary and skip it.
  LC_ALL=C grep -Iq . "$f" 2>/dev/null || continue

  # LAW 1: no em dashes. Anywhere: every text file, every line, no prose view.
  # The owner's call: an em dash is a tell, and a rule with an exemption is a
  # rule people learn to route around. Prose takes a period, a comma, or a colon;
  # code takes a byte escape.
  hits=$(LC_ALL=C grep -n "$EM" "$f" | head -5)
  if [ -n "$hits" ]; then echo "BROKEN $f: em dash"; echo "$hits"; fail=1; fi

  case "$f" in *.md) ;; *) continue;; esac

  # LAW 2: the empty summary sentence. The fix is DELETE.
  hits=$(prose "$f" | grep -inE "that('s| is| was) (it|all|the (entire |basic |whole )?(thing|point|idea|system|setup|process))[.!]?[[:space:]]*$" | head -5)
  if [ -n "$hits" ]; then echo "BROKEN $f: empty summary sentence, the fix is DELETE"; echo "$hits"; fail=1; fi

  # LAW 3: numbers as digits. Headings count; code spans and fenced code do not,
  # so a path like `one-video.md` is not a number. "one" doing a pronoun's job is
  # exempt (no one, one of, the one you need): the exemption is the source kit's,
  # from its check-plain.sh, tightened so "and one" is still a number.
  if [ "${DIGITS:-1}" != 0 ]; then
    hits=$(LC_ALL=C awk '/^```/ { inCode = !inCode; next } !inCode { print }' "$f" | sed -E 's/`[^`]*`//g' \
      | sed -E 's/\b(no|any|some|every)[[:space:]]*one\b//gi; s/\bone (of|another)\b//gi; s/\b(the|that|this|which|each|every|another|first|second|right|wrong|good|bad|only|same|not|a|an)( [a-z]+)? one\b//gi' \
      | grep -inE '\b(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)\b' | head -5)
    if [ -n "$hits" ]; then echo "BROKEN $f: number spelled out, write the digit"; echo "$hits"; fail=1; fi
  fi

  case "$(basename "$f")" in
    CONTEXT.md)
      # LAW 4: no hedging inside a stage contract. A contract states the process.
      hits=$(prose "$f" | grep -inE "\b(consider|you may want to|it might be|perhaps|if you like|as appropriate|feel free)\b" | head -5)
      if [ -n "$hits" ]; then echo "BROKEN $f: hedging in a contract, say do or do not"; echo "$hits"; fail=1; fi

      # LAW 5: a human check is a verb a person performs on a named thing. Vague
      # when the whole check is a bare verb aimed at a pronoun or a generic noun.
      hc=$(awk '/^## Human check/{flag=1; next} /^## /{flag=0} flag' "$f" | grep -v '^[[:space:]]*$')
      if [ -n "$hc" ] && echo "$hc" | grep -qiE "^[[:space:]]*(review|verify|check|look (at|over)|read|confirm|make sure)[[:space:]]+(the[[:space:]]+)?(output|outputs|it|this|that|result|results|file|files|work|draft)[[:space:]]*[.!]?[[:space:]]*$"; then
        echo "BROKEN $f: human check is vague, name what a person reads it against"
        echo "$hc" | head -2
        fail=1
      fi
      ;;
  esac
done <<< "$FILES"

if [ "$fail" -eq 0 ]; then echo "voice-check: clean"; fi
exit $fail
