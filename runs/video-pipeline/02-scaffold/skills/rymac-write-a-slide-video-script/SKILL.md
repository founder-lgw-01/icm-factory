---
name: rymac-write-a-slide-video-script
description: Write video scripts in the slide-per-sentence format - one sentence per slide, on-screen text verbatim with the VO, under 6 seconds a slide, scripted holds on the lines that matter - plus "invisible VSL" organic variants for YouTube. Use when the user asks to "write a VSL", "video sales letter", "slide video", "homepage video script", "YouTube VSL", or wants a script, sales letter, or transcript converted into slides. Make sure to use this skill whenever a slide-based video is being written, rewritten, compressed, or storyboarded.
argument-hint: [brand + video, e.g. "the charter VSL, 4 min"]
---

> ⛔ **BEFORE THIS SKILL DOES ANYTHING on a production video, fire
> `rymac-follow-the-production-line` first.** It posts the 9 stages, names the 5
> skills, marks where this job starts, and waits for the owner's go.

# Slide-per-sentence video scripts

Write scripts as slides, not prose. One thought per slide, the VO reads exactly
what is on screen, the cut is the punctuation, and silence is the highlighter.
The script is about 80% of the video's conversion. Treat every slide as a unit of
attention you either earn or lose.

Read these supporting files on demand:
- `${CLAUDE_SKILL_DIR}/references/vsl-beat-structures.md`. The narrative
  playbook: proven beat sequences, the retention-timed 8-beat template, 10 hook
  patterns, mechanism and enemy theory, application-funnel CTA beats, proof
  without testimonials, 12 failure modes.
- `${CLAUDE_SKILL_DIR}/references/slide-pacing.md`. The mechanics with numbers:
  reading speed, words per slide, duration math, chunking rules, the hold
  playbook, retention pacing.

## RULE 00, the skin

The brand's skin and ending come from `_config/my-line.md` and the gameplan lock
block. Never ask again once they are declared, and never guess when they are not.
The skin decides the ending. A video ends on the brand it belongs to.

## Load first, the owner's voice

Read `_config/my-voice/` and the brand section of `_config/my-line.md` before
writing a word. The voice file at write time is the source of truth. Never write
a script before reading it. `rymac-write-in-the-owners-voice` runs with this
skill and wins on cadence.

## Which script this is

The gate's fork already decided it, and the lock block carries it. `SURFACE:
page` means a sales VSL: it closes a buy or a booking, and its last beat hands
off to the page under it. `SURFACE: channel` means content: it earns the
subscriber and carries the owner's standing close, and if it runs the
persuasion spine it is the invisible VSL further down this file.

## The format, non-negotiable

```
ONE SLIDE   = one complete thought, 5 to 15 words (hard cap 20, split at the clause break past 15)
ON-SCREEN   = verbatim what the VO says, or an exact fragment. Never paraphrase. Mismatch breaks the trance
DURATION    = words / 2.5 + hold seconds. Floor 1s, cap 6s. Only scripted holds run longer, never past 8s
THE CUT     = the punctuation. Every slide is a COMPLETE thought that stands alone when spoken.
              A long sentence becomes 2 complete sentences, NEVER a "..." fragment plus a slide
              starting lowercase or on and/who/where/so picking up mid-sentence. That chop is
              the #1 cadence killer and it has cost a full rebuild.
              "..." is a rare deliberate cliffhanger, 1 or 2 per script. ":" sets up a quote
EMPHASIS    = 1 or 2 highlighted words per slide, max. A word alone on a slide shouts loudest
SILENCE     = the highlighter. Script every hold explicitly, [HOLD 1s] / [BEAT]. Editors won't invent pauses
```

Why text-only works: when the sentence is the only visual, reading plus hearing
the same words beats hearing alone, and the format forces linear consumption.
Nobody skims to the price.

Budget math before writing: 140 to 160 spoken words a minute means a 4 minute
video is 560 to 640 words and 45 to 60 slides. Write to the budget, not past it.

## The narrative spine (default, 2 to 6 minute application VSL)

Timings scale to target runtime. Retention stakes per beat in the references.

| Beat | ~% of runtime | Job | Rule |
|---|---|---|---|
| 1. Hook | 0 to 10% | Pattern interrupt + callout, open the master loop | Payoff promised by 0:15. Never open with a name or greeting |
| 2. Problem | 10 to 25% | Name the pain in the viewer's words | Problem-first beats claim-first on cold traffic |
| 3. Agitate | 25 to 40% | Stack the cost | 90 seconds max, ever. Past that it reads as manipulation |
| 4. Credibility | mid-problem | Scar tissue: listen to me because I got burned too | Drop it inside the problem, not up front |
| 5. Mechanism reveal | 40 to 55% | Name the hidden enemy, then name YOUR system | Both get proper nouns. The enemy is a tool, practice, or incumbent. Never the viewer |
| 6. Solution + offer | 55 to 75% | What they get, stacked | Full value stack BEFORE any price |
| 7. Proof | 65 to 80% | Receipts, math, demonstration, founder story | Specificity is the proof. "11 estimates last Tuesday" beats "tons of leads" |
| 8. Price anchor + price | 75 to 85% | Anchor high, then land the real number | HOLD on the number, alone on its slide |
| 9. CTA | 85 to 100% | Qualification frame + risk reversal + real scarcity | Soft CTA seeded mid-video, hard CTA at close |

## Application-funnel CTA rules

These videos sell a call, not a checkout. The CTA beat must:

1. **Frame it as qualification.** Apply to see if you qualify. The call is a
   diagnosis, not a pitch.
2. **Take it away.** This is not for everyone. Say who it is for AND who it is
   not for.
3. **Pre-frame the next step literally.** Click the button below this video,
   answer a few questions, pick a time.
4. **Use only real scarcity.** Cohort caps, builds per month, founding counts.
   No countdown timers. Fake urgency destroys the qualification frame.
5. **Kill risk in plain words.** Not a pushy call, no contracts, if it is not a
   fit you will hear that on the call.

## Line-level rules

- **The standing close.** The owner's channel videos end the same 3 beats every
  time: their sign-off line, their promise line, their name on the end card. It
  is defined once in `_config/my-line.md` and baked into every script's close.
  Never make the owner ask for their own close.
- **No developer talk.** Zero coder language in any script a normal audience
  will see. No state machine, array, stack, commit, merge, branch, pipeline,
  schema. The moat is making complex things simple.
- **No periods on slide text.** Anything read on mic ships with no terminal
  punctuation. Slide breaks and HOLD markers carry the pacing. Periods the
  owner adds in their own pass stay.
- Reading grade 5 to 7. Short sentences. Vary rhythm, a 3 word punch after 2
  longer lines.
- Start lines with And, But, So, Because, Now, Look. Speech glue, momentum.
- One master open loop from hook to close. Resolve minor loops within 3 slides.
- Concrete pictures over abstractions. Not "get more leads". "Wake up to a
  booked calendar."
- Lists fire as slide runs. One item per slide, 2 to 3 seconds each.
- Read the script aloud, start to finish, before delivering. If a line makes
  you cringe spoken, rewrite it.

## Invisible VSL, the YouTube organic variant

A content video that carries the VSL's persuasion spine disguised as teaching.
Same slide format, different wrapper:

- **Hook is content-native, not ad-native.** Promise a lesson or a reveal,
  never an offer.
- **Teach what and why, never how.** The full how is the reason the sales page
  and the call exist.
- **The lesson IS beats 2 through 5** of the spine, played straight as
  education. The viewer should feel smarter, not sold.
- **One soft CTA, at the end.** Sending them to a tool or lead magnet converts
  better than sending them to a pitch.
- **Congruence rule.** Every invisible VSL is a slice of the brand's one
  message. Title, thumbnail, and first slide must agree. A bait gap kills
  retention and trust.
- Runtime 3 to 8 minutes. Hook rules and pacing identical to the sales VSL.

## 🔴 THE PROCESS THAT WORKED. Run it in this order.

This order exists because the first attempt at a page VSL got deleted for
inventing a scene the buyer was supposedly living. The rebuild that the owner
approved did these things differently. It is not a style. It is the order of
operations, and every step exists because skipping it cost a rewrite.

### 1. The owner's surfaces get read first, and the copy comes OUT of them

**Do not write a VSL. Compress one that already exists.** Before a single slide
is drafted, open, in this order: the page the video will sit on, the product it
describes as the buyer receives it, the email that delivers it, and the brand's
voice files. By step 4 the script is 80% written in the owner's words. The job
left is taking syllables out.

### 2. Every script carries a SOURCE AUDIT

A table at the bottom mapping every slide range to the file it came off, with
the owner's own lines marked and locked against smoothing.

- **It makes invention impossible.** A line with no source cannot get a row.
- **It survives the owner's edits.** When something changes 2 weeks later, the
  audit says which file to fix so the video and the page never disagree.
- End it with the line that closes the failure: "Nothing in this script
  describes a scene the buyer is living."

### 3. Every number in the file is COUNTED, never estimated

Never hand-total a duration column. Run a script over the table and read out:
total runtime, slide count, word count, words per minute, the longest slide,
and the exact second any mid-video element opens. Bake scripted holds INTO the
duration cell so the column sums to the real runtime. Re-run the count after
EVERY change, including the owner's. A 3 line addition moves the offer mark.

### 4. If a slide names a number, the file keeps that promise

An opener that says "give me 6 minutes" against a table that measures 6:41 is a
broken promise in the first 15 seconds. The slide is the promise and the
runtime is the receipt. Either the slide changes to the measured number or the
script gets cut. Never leave them disagreeing.

### 5. The owner's edit pass is absorbed MECHANICALLY, never editorially

They edit the file and save it. Re-read it off disk, then:

| What they did | What you do |
|---|---|
| Typed a line with no row around it | Give it a real row where they put it, renumber everything after |
| Replaced a short line with a longer one | Re-time it. Their new line on the old duration is a wrong number |
| Left a note in the margin | Move it into the NOTES cell, their words kept |
| Misspelled something on a slide | ⛔ Leave it. Flag it in chat in 1 line and hold their bytes. They hold the pen |
| Broke the table's spacing | Normalize the cell walls only. Their characters are never touched |

Then list their lines in the spec by number, under a heading saying they do not
get touched.

### 6. Nothing downstream is allowed to drift from the script

After the spec and the reader source are built, byte-compare them against the
script with a script, not by eye. Every slide number present, every line
identical. Print PASS or print what drifted. This catches the renumber that
only got applied to 2 of the 3 files, the exact failure that becomes a wrong
slide on camera.

### 7. Every asset the spec names is verified on disk, with its real size

Before the spec says a picture or clip is used, open it and read its real
dimensions and duration, then write those numbers into the spec. This catches
b-roll that is 1280x720 against a 1920x1080 frame, and clips whose first 20
seconds are unusable.

### 8. The script says what is NOT in it, and why

A short list at the bottom of everything considered and cut, with the reason.
It stops the same suggestion coming back next session.

### 9. The voice check runs on the folder before the owner sees any of it

Run the kit's voice check on the video folder. It reads the `SURFACE:` line out
of the gameplan and skips the standing close on a page or classroom video. One
trap: it will flag your own sweep table for containing the words it polices.
Write the sweep so it names the law without quoting the word.

## The gate, every script must pass

1. **0:15 test.** By second 15 the viewer knows the pain, the promise, and why
   to keep watching. No intros.
2. **Named mechanism.** A hidden enemy that absolves the viewer, and a
   proper-noun system that attacks it.
3. **Congruent CTA.** Qualification frame, real scarcity only, next step stated
   literally.
4. **Pacing math validates.** 140 to 160 wpm, no slide over 6 seconds except
   scripted holds, 12 to 15 slides a minute.
5. **Honesty and read-aloud.** Every claim deliverable today, and the script
   survives being spoken start to finish.
6. **Source audit complete.** Every slide range traces to a file on disk or to
   the owner's own pen. No line invents a scene the buyer is living.
7. **Counted, not estimated.** Every number came out of a script run over the
   table, re-run after the owner's last edit.

## Output format

```markdown
# [Brand] VSL, [working title]
**Spec:** [sales VSL | invisible VSL] · target [X:XX] · [N] words ([N] wpm) · [N] slides · CTA: [the ask]
**Hook options considered:** (5 or more, winner marked)

| # | ON-SCREEN TEXT (verbatim) | VO | DUR | NOTES |
|---|---------------------------|----|-----|-------|
| 001 | ... | (same, or exact fragment) | 3.0s | highlight "the enemy's name" · [BEAT] after |

**Measured:** runtime, slides, words, wpm, longest slide, the second any mid-video element opens. Counted by script
**Beat map:** slide ranges per beat, with real timecodes
**The gate:** the 7 checks, each with how it was proven
**Source audit:** every slide range mapped to its file, the owner's lines marked
**Voice sweep:** each law, named without quoting the banned word
**What is NOT in the script, on purpose:** what was cut and why
```

Duration sums must equal the target runtime. NOTES carries highlights, holds,
and production flags only. Visual specs live in the spec doc, not the script.

Read `$ARGUMENTS` for the brand, video, and target length. If no brand is named
and the config lists more than 1, ask which brand. The voice changes everything.
