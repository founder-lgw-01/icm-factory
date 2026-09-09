#!/usr/bin/env python
# ============================================================================
#  check-sourced.py  ·  Law 5 and Law 6, turned into something that RUNS.
#
#  WHY THIS EXISTS (2026-08-17)
#  The owner read a SETUP file out loud 5 times. Every other gate said CLEAN on all
#  5 reads. grade.py scored it 1.9, check-fragments said CLEAN, voice-check
#  said CLEAN, check-plain said CLEAN. He still found 8 made up numbers, a
#  fabricated receipt about his own CLAUDE.md, a label that admitted the page
#  had failed, and 3 pronouns pointing at nothing.
#
#  A page can be short, plain, and grade 1.9 and still be garbage, because it
#  says nothing true. No gate was looking for TRUE. This one does.
#
#  It cannot know what is sourced, so it does not try. It surfaces every claim
#  that NEEDS a source and makes somebody say where it came from out loud. A
#  hit is not automatically a failure. An unanswered hit is.
#
#  Usage:  python check-sourced.py <file>
#  Exit 0 = nothing to answer for. Exit 1 = claims that need a source.
# ============================================================================
import re
import sys
import os

# --- 1. INVENTED SPECIFICS --------------------------------------------------
# Every one of these shipped inside the free kit and he found them by reading.
# A duration, a frequency, or a claim about "people" is a measurement. If you
# did not measure it, and it is not in one of his files, it is decoration.
SPECIFICS = [
    (r"\bby (Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)\b",
     "a day of the week used as a deadline"),
    (r"\bin (about )?\d+ (second|minute|hour|day|week|month|year)s?\b",
     "a duration"),
    (r"\btakes (about )?(a|an|\d+) (second|minute|hour|day|week|month)s?\b",
     "how long something takes"),
    (r"\b(once|twice) (a|per) (day|week|month|quarter|year)\b",
     "a frequency"),
    (r"\bevery \d+ (second|minute|hour|day|week|month)s?\b",
     "a frequency"),
    (r"\b\d+ ?% ", "a percentage"),
    (r"\b(almost always|most of the time|nine times out of ten|usually|normally|typically)\b",
     "a frequency claim with nothing behind it"),
    (r"\b(most|many|some) (people|agencies|owners|businesses)\b",
     "a claim about what other people do"),
    (r"\bpeople (rush|skip|forget|struggle|always|never)\b",
     "a claim about what people do"),
    (r"\bthe (first|last) \d+ (second|minute|hour|day)s?\b",
     "a duration"),
]

# --- 2. A RECEIPT ABOUT THE OWNER ------------------------------------------------
# The worst one that shipped: "Mine was 146 lines. I got it down to 119."
# His CLAUDE.md was never either number. That is invented biography under his
# own sign off. Any number attached to HIS files or history gets checked
# against the actual file, or it does not ship.
RECEIPTS = [
    (r"\b(mine|my|I)\b[^.!?]{0,60}\b\d+ lines\b", "a line count of his own file"),
    (r"\bI (cut|got) it (down )?to \d+", "a before and after about his own work"),
    (r"\bI (have|had|made|closed|earned|charged) [^.!?]{0,20}\$?\d",
     "a number about his own history"),
]

# --- 3. A LABEL ON YOUR OWN WRITING -----------------------------------------
# "is there any other kind of English?" Announcing that a section is plain
# confesses the rest of the page is not.
LABELS = [
    (r"in plain English", '"in plain English"'),
    (r"\bsimply put\b", '"simply put"'),
    (r"\bin other words\b", '"in other words"'),
    (r"to put it simply", '"to put it simply"'),
    (r"\blong story short\b", '"long story short"'),
]

# --- 4. PRONOUNS AND ABSTRACTIONS POINTING AT NOTHING -----------------------
# "what cost nothing?"  "where is nowhere?"  "make it true again"
DEAD = [
    (r"\bit costs nothing\b", 'what costs nothing? name the thing'),
    (r"\bto nowhere\b", 'where is nowhere? say what actually happened'),
    (r"\bmake it true\b", 'a reader cannot picture a "true" file'),
    (r"\bthat(?:'s| is) the (magic|trick|secret|whole point)\b", 'name it instead'),
    (r"\bit(?:'s| is) that simple\b", 'then it does not need saying'),
]

# --- 5. THE 2 WORDS HE PULLED BY HAND ---------------------------------------
FILLER = [
    (r"\bsimply\b", '"simply" is out everywhere, sandwich included'),
    (r"\bjust\b", '"just" only survives when it means "merely"'),
]


def prose_lines(path):
    """Skip headings, fenced blocks, and indented code so a pasted prompt or a
    code sample is never reported as a claim."""
    out, fenced = [], False
    for i, raw in enumerate(open(path, encoding="utf-8"), 1):
        line = raw.rstrip("\n")
        if line.strip().startswith("```"):
            fenced = not fenced
            continue
        if fenced or line.startswith("    ") or line.lstrip().startswith("#"):
            continue
        out.append((i, line))
    return out


# --- PAGES THE OWNER WROTE THEMSELVES ------------------------------------------------
# Law 4 and "the line you never cross": his pages are never edited, so this gate
# must never hand a session a reason to edit one. It still PRINTS what it finds,
# because he may want to change his own line, but it never fails the run, and it
# says out loud whose line it is.
#
# Add a filename here the moment he rewrites a page himself.
HIS_PAGES = {"00-START-HERE.md"}


def scan(path):
    groups = [
        ("NEEDS A SOURCE", SPECIFICS, "Law 5. Say where it came from or cut it."),
        ("A RECEIPT ABOUT THE OWNER", RECEIPTS, "Law 5. Open the file and count, or ask them."),
        ("A LABEL ON THE WRITING", LABELS, "Law 5. Write the plain version, say nothing about it."),
        ("POINTS AT NOTHING", DEAD, "Law 6. Name the thing a reader can picture."),
        ("FILLER HE PULLED BY HAND", FILLER, "Words that never ship."),
    ]
    total = 0
    his = os.path.basename(path) in HIS_PAGES
    print("\n=== %s%s" % (path, "   [HIS PAGE, never edit]" if his else ""))
    for title, rules, note in groups:
        hits = []
        for n, line in prose_lines(path):
            for pat, why in rules:
                if re.search(pat, line, re.I):
                    hits.append((n, why, line.strip()))
        if hits:
            total += len(hits)
            print("\n  %s  (%d)   %s" % (title, len(hits), note))
            for n, why, text in hits:
                print("    X line %-4d %s" % (n, why))
                print("             %s" % (text[:96] + ("..." if len(text) > 96 else "")))
    if total == 0:
        print("   ok nothing in here claims something you cannot back up")
    elif his:
        print("\n  ^ HE WROTE THIS PAGE. Every line above is his and it stays.")
        print("    Ask him in chat if you think one is wrong. Never edit it.")
        return 0
    return total


def main():
    if len(sys.argv) < 2:
        print("usage: python check-sourced.py <file>")
        return 2
    bad = 0
    for p in sys.argv[1:]:
        if not os.path.isfile(p):
            print("no such file:", p)
            return 2
        bad += scan(p)
    print()
    if bad:
        print("sourced gate: %d claim(s) to answer for." % bad)
        print("A hit is not automatically wrong. An UNANSWERED hit is.")
        print("For each one, say where it came from, or delete it. Do not soften it.")
        print("If HE typed the line, it stays. Ask him in chat, never edit it.")
        return 1
    print("sourced gate: CLEAN")
    return 0


if __name__ == "__main__":
    sys.exit(main())
