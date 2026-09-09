# -*- coding: utf-8 -*-
"""
THE READING GRADE GATE.

The house pages land at grade 1 to 3 in Hemingway Editor. That is the standard for
every file a buyer opens, and it is a number, not an opinion.

This is a local stand-in for Hemingway so a session can check a file without
leaving the machine. It reports the same 4 things Hemingway shows:

    grade            the reading grade of the whole page
    hard sentences   14 words or more
    very hard        20 words or more
    adverbs          -ly words. Hemingway's budget is 1 per 80 words
    passive voice    Hemingway's budget is 1 per 5 sentences
    complex phrases  a fancy phrase with a plain swap available

It is a stand-in, not the real thing. Hemingway is the scoreboard. Run this
first so the only thing left to fix is judgement.

    python grade.py <file-or-folder>

Exit 0 = grade 5 or under and every budget met. Exit 1 = read it again.
"""
import io, os, re, sys

# ── TESTIMONIALS AND QUOTES ARE EXEMPT FROM EVERY LAW BELOW ──────────────────
# Standing rule: testimonials are never banned words. This
# The owner has ruled on this repeatedly. It stays exempt.
# These laws police what THE OWNER says. Editing a customer's words to satisfy
# style rules is falsifying a testimonial. If a law reports a quote, the LAW is
# wrong. Every scan runs on the output of this function, never on the raw text.
_QUOTED = [
    re.compile(r"<blockquote.*?</blockquote>", re.S | re.I),
    re.compile(r"<figcaption.*?</figcaption>", re.S | re.I),
    re.compile(r"<cite.*?</cite>", re.S | re.I),
    re.compile(r'<figure[^>]*class="[^"]*(?:tcx-pola|quote)[^"]*".*?</figure>', re.S | re.I),
    re.compile(r'\salt="[^"]*"', re.I),
    re.compile(r"^\s*>.*$", re.M),
    re.compile(r"[“][^”]{0,400}[”]"),
]


def strip_quoted(text):
    """Blank anything somebody else said. Length is preserved so line numbers hold."""
    for pat in _QUOTED:
        text = pat.sub(lambda m: re.sub(r"\S", " ", m.group(0)), text)
    return text

TARGET_GRADE = 5.0   # his own pages land at 1 to 3. 5 is the fail line.

SWAPS = {
    "utilize": "use", "utilise": "use", "in order to": "to", "a number of": "some",
    "sufficient": "enough", "additional": "more", "currently": "now",
    "however": "but", "therefore": "so", "approximately": "about",
    "numerous": "many", "prior to": "before", "subsequently": "later",
    "furthermore": "also", "in the event that": "if", "at this point in time": "now",
    "due to the fact that": "because", "in spite of the fact that": "although",
    "for the purpose of": "to", "with regard to": "about", "in addition": "also",
    "commence": "start", "terminate": "end", "endeavor": "try", "endeavour": "try",
    "facilitate": "help", "implement": "do", "leverage": "use", "optimize": "improve",
    "regarding": "about", "obtain": "get", "require": "need", "provide": "give",
    "attempt": "try", "demonstrate": "show", "component": "part", "individual": "person",
    "initiate": "start", "modify": "change", "necessitate": "need",
}

# MODIFIERS he deletes on sight (his words, 2026-08-17): "I removed all the
# genuinely, simply, all the unnecessary modifiers." A modifier that does not
# change a fact is filler. "completely" is NOT here: he kept "starts every
# conversation completely empty", and his page beats any list of mine.
FILLER = ["genuinely", "honestly", "quietly", "simply", "really", "very",
          "basically", "essentially", "literally", "certainly", "definitely",
          "absolutely", "totally", "extremely", "incredibly", "truly",
          "a bit like", "sort of", "kind of", "somewhat", "rather"]

# SLOP. His words, 2026-08-17: "I removed the dumbass 'this is the whole thing'
# that makes no sense and sounds like AI slop", then: "I never want to see
# 'that's it. That's the whole thing' ever again."
#
# The tell is a wrap up line that claims completeness and names nothing. The
# fix is never to delete the ending, it is to NAME the thing. He rewrote
# "That is the whole thing" as "That is the system."
#
# These are regexes so the 2 he named can be anchored to the start of a
# sentence. His own approved line "That is all that is it." must stay legal,
# and it does, because the ban is on the sentence that IS those 3 words.
#
# 2026-08-17, THE WORD "whole" IS BANNED OUTRIGHT. His words: "take the word
# whole and ban it from your vocabulary. I do not want to see that stupid word
# ever again." The set phrases below were not enough. "your whole business",
# "your whole situation" and "the whole habit" all cleared this list and
# shipped inside the free kit, and he found all 3 himself.
#
# The fix is never a synonym. Delete it. It is his business, his situation,
# the habit. The word was carrying nothing.
SLOP = [
    (r"\bwhole\b",              "the word \"whole\" (BANNED, delete it)"),

    # ⛔ THE EMPTY SUMMARY SENTENCE, banned outright 2026-08-17. His words, and
    # he was furious by the time he said them:
    #
    #   "I hate the stupid saying something to say nothing, 'thats the whole
    #    thing' that's the thing 'thats the system' 'that it. the whole thing'
    #    the owner calls it the emptiest line there is.
    #
    # It is the sentence that closes a section by naming the thing the section
    # just described. It carries no information. The paragraph above it already
    # did the work, and this is the writer patting it on the head. It is the
    # single most recognisable tell of AI writing, and it had survived 4 rounds
    # of cuts on the simple sheet because each instance looked harmless alone.
    #
    # ⛔ THE FIX IS DELETE. There is no rewrite and there is no synonym. Swapping
    # "that's the whole thing" for "that's the setup" is the same sentence in a
    # different hat, which is exactly what happened and why this is a pattern
    # and not a word list.
    (r"\bthat(?:'s| is| was)\s+(?:all\s+|just\s+|basically\s+|really\s+|"
     r"literally\s+|simply\s+)?(?:it|the\s+(?:whole\s+|entire\s+|full\s+)?"
     r"(?:thing|point|system|setup|kit|deal|trick|idea|secret|magic|lot|job|"
     r"method|process|answer|difference|move|play|shape))\b",
     "the empty summary sentence (\"that's the ___\"). DELETE it, never reword it"),
    (r"that'?s all there is to it",  "\"that's all there is to it\""),
    (r"and that'?s that",            "\"and that's that\""),
    (r"in a nutshell",               "\"in a nutshell\""),

    (r"(?:^|[.!?]\s+|\n)\s*that(?:'s| is) the whole thing",    "\"That's the whole thing.\""),
    (r"the whole thing",        "the whole thing"),
    (r"the whole job",          "the whole job"),
    (r"the whole trick",        "the whole trick"),
    (r"the whole point",        "the whole point"),
    (r"the whole step",         "the whole step"),
    (r"the whole difference",   "the whole difference"),
    (r"the entire job",         "the entire job"),
    (r"the entire habit",       "the entire habit"),
    (r"the entire thing",       "the entire thing"),
    (r"the entire migration",   "the entire migration"),
    (r"at the end of the day",  "at the end of the day"),
    (r"the beauty of",          "the beauty of"),
    (r"it is important to note","it is important to note"),
    (r"needless to say",        "needless to say"),
    (r"in today's world",       "in today's world"),
    (r"dive in",                "dive in"),
    (r"unlock the",             "unlock the"),
    (r"seamless",               "seamless"),
    (r"robust",                 "robust"),
    (r"game changer",           "game changer"),
    (r"supercharge",            "supercharge"),
    (r"empower",                "empower"),
    (r"delve",                  "delve"),
    (r"is just a\b",            "is just a"),
    (r"are just a\b",           "are just a"),
    (r"just folders",           "just folders"),
]

BE = r"(?:is|are|was|were|be|been being|being|been)"
PASSIVE = re.compile(r"\b" + BE + r"\s+(?:\w+ly\s+)?(\w+(?:ed|en))\b", re.I)
# Words that end in -ed or -en but are not doing passive work.
NOT_PASSIVE = {"need", "seed", "feed", "speed", "wed", "shed", "bed", "red",
               "open", "even", "often", "children", "women", "men", "garden",
               "hidden", "golden", "wooden", "sudden", "used"}


def prose(text):
    """Strip everything a reader does not read as a sentence."""
    out = []
    fenced = False
    lines = text.split("\n")
    # Drop YAML frontmatter. It is trigger text for the machine, not prose.
    if lines and lines[0].strip() == "---":
        end = next((i for i in range(1, len(lines)) if lines[i].strip() == "---"), 0)
        lines = lines[end + 1:]
    for line in lines:
        if line.strip().startswith("```"):
            fenced = not fenced
            continue
        if fenced:
            continue
        if line.startswith("    ") or line.startswith("\t"):
            continue                      # a file listing or a pasted prompt
        if line.strip().startswith("---"):
            continue                      # frontmatter fence
        if line.lstrip().startswith(">"):
            continue                      # a quote of his words, or a broken example
        if line.strip().startswith("|"):
            continue                      # table
        s = re.sub(r"`[^`]*`", "", line)  # inline code
        s = re.sub(r"https?://\S+", "", s)
        s = re.sub(r"[#>*_\[\]()]", " ", s)
        out.append(s)
    return "\n".join(out)


def sentences(text):
    parts = re.split(r"(?<=[.!?])\s+|\n{2,}", text)
    return [p.strip() for p in parts if len(p.strip().split()) >= 3]


def syllables(word):
    w = re.sub(r"[^a-z]", "", word.lower())
    if not w:
        return 0
    groups = re.findall(r"[aeiouy]+", w)
    n = len(groups)
    if w.endswith("e") and not w.endswith(("le", "ee")) and n > 1:
        n -= 1
    return max(1, n)


def check(path):
    raw = strip_quoted(io.open(path, encoding="utf-8", errors="replace").read()).replace("\r\n", "\n")
    text = prose(raw)
    sents = sentences(text)
    if not sents:
        print("   nothing to grade")
        return 0

    words = [w for s in sents for w in re.findall(r"[A-Za-z']+", s)]
    nw, ns = len(words), len(sents)
    chars = sum(len(w) for w in words)
    syls = sum(syllables(w) for w in words)

    ari = 4.71 * (chars / nw) + 0.5 * (nw / ns) - 21.43
    fk = 0.39 * (nw / ns) + 11.8 * (syls / nw) - 15.59
    grade = max(1.0, round((ari + fk) / 2, 1))

    # Hemingway grades each SENTENCE, not its word count. A 28 word sentence
    # made of short plain words is easy to read, and he writes plenty of them.
    # So a sentence is scored on its own, the way Hemingway does it.
    def slevel(s):
        w = re.findall(r"[A-Za-z']+", s)
        if not w:
            return 0
        return 4.71 * (sum(len(x) for x in w) / len(w)) + 0.5 * len(w) - 21.43

    # A short sentence is never hard to read, however long its words are.
    # Hemingway does not highlight them and neither does this. Without the
    # floor, "The orchestration platform." scored worse than a 28 word line.
    long_enough = [s for s in sents if len(s.split()) >= 8]
    hard = [s for s in long_enough if 10 <= slevel(s) < 14]
    vhard = [s for s in long_enough if slevel(s) >= 14]

    adverbs = [w for w in re.findall(r"[A-Za-z']+", re.sub(r"(?:it )?simply means", "means", text, flags=re.I))
               if w.lower().endswith("ly") and len(w) > 4
               and w.lower() not in ("only", "early", "family", "reply", "apply", "supply")]
    adv_budget = max(1, nw // 80)

    passive = []
    for s in sents:
        for m in PASSIVE.finditer(s):
            if m.group(1).lower() not in NOT_PASSIVE:
                passive.append(m.group(0))
    pas_budget = max(1, ns // 5)

    # THE SANDWICH IS EXEMPT. "You may hear that called X. It simply means Y"
    # is his approved line, so the word simply inside it is not filler.
    low = re.sub(r"(?:it )?simply means", "means", text.lower())
    complex_hits = sorted({k for k in SWAPS if re.search(r"\b" + re.escape(k) + r"\b", low)})
    filler_hits = sorted({f for f in FILLER if re.search(r"\b" + re.escape(f) + r"\b", low)})
    slop_hits = sorted({lab for pat, lab in SLOP if re.search(pat, low)})

    print("   grade %s   %d sentences, %d words" % (grade, ns, nw))
    fails = 0

    def line(ok, label, detail):
        print("   %s %-16s %s" % ("ok" if ok else " X", label, detail))
        return 0 if ok else 1

    fails += line(grade <= TARGET_GRADE, "reading grade",
                  "%s (his pages land at 1 to 3, fail line is %s)" % (grade, TARGET_GRADE))
    fails += line(not vhard, "very hard", "%d sentence(s) of 20+ words" % len(vhard))
    fails += line(len(hard) <= max(1, ns // 8), "hard",
                  "%d sentence(s) of 14 to 19 words" % len(hard))
    fails += line(len(adverbs) <= adv_budget, "adverbs",
                  "%d used, budget %d %s" % (len(adverbs), adv_budget,
                                             sorted(set(adverbs))[:6] if adverbs else ""))
    fails += line(len(passive) <= pas_budget, "passive voice",
                  "%d used, budget %d %s" % (len(passive), pas_budget, passive[:4]))
    fails += line(not complex_hits, "complex phrases",
                  ", ".join("%s -> %s" % (k, SWAPS[k]) for k in complex_hits[:6]) or "none")
    fails += line(not filler_hits, "modifiers", ", ".join(filler_hits[:8]) or "none")
    fails += line(not slop_hits, "AI slop", ", ".join(slop_hits[:6]) or "none")

    for s in vhard[:4]:
        print("      20+ words: " + s[:96].replace("\n", " "))
    return fails


def main():
    target = sys.argv[1] if len(sys.argv) > 1 else ""
    if not target:
        print("usage: python grade.py <file-or-folder>")
        return 0
    files = []
    if os.path.isdir(target):
        for root, _, names in os.walk(target):
            if "_build" in root:
                continue
            for n in sorted(names):
                if n.endswith((".md", ".txt")):
                    files.append(os.path.join(root, n))
    else:
        files = [target]

    total = 0
    for f in files:
        print("\n=== " + f.replace("\\", "/"))
        total += check(f)
    print("\ngrade gate: " + ("CLEAN" if total == 0 else "%d problem(s)" % total))
    return 1 if total else 0


if __name__ == "__main__":
    sys.exit(main())
