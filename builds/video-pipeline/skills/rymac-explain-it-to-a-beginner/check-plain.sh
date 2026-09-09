#!/usr/bin/env bash
# ============================================================================
#  CHECK-PLAIN. The teaching laws, turned into something that RUNS.
#
#  Why this exists: numbered steps read as certainty. A guess written in that
#  format gets followed like a fact. So the laws that decide whether a page
#  teaches or just orders somebody around have to be checkable, not claimed.
#
#  This covers ONLY the gaps that checks/voice-check.sh does not. Run both:
#      bash checks/voice-check.sh <file>
#      bash skills/rymac-explain-it-to-a-beginner/check-plain.sh <file>
#
#  Usage:
#      bash check-plain.sh kit/01-SETUP.md
#      bash check-plain.sh kit/        (a folder)
#
#  Exit 0 = clean. Exit 1 = a law is broken.
# ============================================================================

TARGET="${1:-}"
[ -z "$TARGET" ] && { echo "usage: check-plain.sh <file-or-folder>"; exit 0; }

if [ -d "$TARGET" ]; then
  FILES=$(find "$TARGET" -maxdepth 3 -type f \( -name "*.md" -o -name "*.txt" \) \
          -not -path "*/_build/*" 2>/dev/null)
else
  FILES="$TARGET"
fi
[ -z "$FILES" ] && { echo "check-plain: nothing to check in $TARGET"; exit 0; }

FAILS=0
say_fail () { echo "  X $1"; FAILS=$((FAILS+1)); }

for F in $FILES; do
  [ -f "$F" ] || continue
  echo ""
  echo "=== $F"

  # Blank out fenced code blocks IN PLACE so line numbers stay true. A file
  # path or a pasted prompt inside a fence is not prose and must not be graded
  # as prose, but dropping the lines entirely would shift every number after it.
  TXT="$(mktemp 2>/dev/null || echo "/tmp/checkplain.$$")"
  awk '/^```/{f=!f; print ""; next} f{print ""; next} {print}' "$F" > "$TXT"

  # --- LAW 1: no em dashes -------------------------------------------------
  HIT=$(grep -n -e $'\xe2\x80\x94' -e $'\xe2\x80\x93' "$TXT")
  [ -n "$HIT" ] && { say_fail "em dash present"; echo "$HIT" | head -5 | sed 's/^/      /'; }

  # --- LAW 2: numbers are digits -------------------------------------------
  # "one" is exempt when it is doing a pronoun's job (no one, the one I use,
  # one of them, someone). Everywhere else it is a number and it ships as 1.
  HIT=$(sed -E 's/\b(no|any|some|every)\s*one\b//gi;
                s/\bone (of|another)\b//gi;
                s/\b(the|that|this|which|each|every|another|first|second|right|wrong|good|bad|only|same|not|a|an) ?([a-z]+ )? ?one\b//gi' "$TXT" \
        | grep -n -i -E '\b(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve)\b')
  [ -n "$HIT" ] && { say_fail "number spelled out. Numbers are always digits"; echo "$HIT" | head -6 | sed 's/^/      /'; }

  # --- LAW 3: no run on sentences ------------------------------------------
  # 25 words is the line. Past that it carries 2 ideas and needs a return.
  HIT=$(awk '{
      line=$0
      gsub(/`[^`]*`/,"",line)
      n=split(line, s, /[.!?]/)
      for(i=1;i<=n;i++){
        c=split(s[i], w, /[ \t]+/)
        if(c>25) printf "%d: %s\n", NR, substr(s[i],1,90)
      }
    }' "$TXT")
  [ -n "$HIT" ] && { say_fail "run on sentence, over 25 words"; echo "$HIT" | head -5 | sed 's/^/      /'; }

  # --- LAW 4: a fancy word with no sandwich near it ------------------------
  # The fix is never deleting the word. It is "you may hear that called X,
  # it simply means Y". So the word is allowed, bare is not.
  JARGON='context window|context engineering|orchestration|agentic|multi.?agent|vector database|persistent memory|deterministic|frontmatter|repository'
  while IFS=: read -r LN REST; do
    [ -z "$LN" ] && continue
    WINDOW=$(sed -n "$((LN>2 ? LN-2 : 1)),$((LN+2))p" "$TXT")
    echo "$WINDOW" | grep -q -i -E 'you may hear|simply means|people call|what people call|fancy word' \
      || { say_fail "fancy word with no sandwich, line $LN"; echo "      $REST" | cut -c1-100; }
  done < <(grep -n -i -E "$JARGON" "$TXT")

  # --- LAW 5: the teaching unit, all 3 parts -------------------------------
  # Every step is: the next step is / this is why / this is what it does.
  # The check looks for the literal markers on purpose. A stray "why" further
  # down the paragraph is not the same thing as telling them why, and the
  # first version of this check passed a step that never explained anything.
  if grep -q -i -E '^#+ *step ' "$TXT"; then
    HIT=$(awk 'BEGIN{IGNORECASE=1}
      function flush(){ if(head!=""){ m=""; if(!w) m=m" WHY"; if(!d) m=m" WHAT-IT-DOES";
                        if(m!="") printf "%d: %s   missing:%s\n", hl, head, m } }
      /^#+ *step /{ flush(); head=$0; hl=NR; w=0; d=0; next }
      /^#+ /{ flush(); head=""; next }
      /this is why|why this matters|the reason (this|it|you)/{ if(head!="") w=1 }
      /this is what it does|what it does|what that does|what changes/{ if(head!="") d=1 }
      END{ flush() }' "$TXT")
    [ -n "$HIT" ] && { say_fail "step missing part of the teaching unit"; echo "$HIT" | sed 's/^/      /'; }
  fi

  # --- LAW 6: outright bans, no sandwich saves these -----------------------
  HIT=$(grep -n -i -E '[0-9]+ ?% (cheaper|savings|saved|less|reduction)|token (savings|reduction) of' "$TXT")
  [ -n "$HIT" ] && { say_fail "a saving percentage he never measured"; echo "$HIT" | head -3 | sed 's/^/      /'; }

  HIT=$(grep -n -i -E '\b(sold|selling|sell)\b' "$TXT" | grep -v -i 'sell first, build second')
  [ -n "$HIT" ] && { say_fail "the verb is CLOSED, never sold"; echo "$HIT" | head -3 | sed 's/^/      /'; }

  HIT=$(grep -n -i -E '\bcohort\b|naming the folders' "$TXT")
  [ -n "$HIT" ] && { say_fail "banned wording (cohort / naming the folders)"; echo "$HIT" | head -3 | sed 's/^/      /'; }

  rm -f "$TXT"
done

echo ""
if [ "$FAILS" -eq 0 ]; then
  echo "check-plain: CLEAN"
  exit 0
fi
echo "check-plain: $FAILS problem(s). A passing script is not a passing result, read it back too."
exit 1
