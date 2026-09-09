---
name: rymac-make-a-reader-to-record-from
description: Turns a video/voiceover script into a full-screen SLIDE READER page - one slide at a time on a dark stage, advanced with click/arrow, the way the owner records every voiceover. Use whenever a script is written or revised and the owner needs to record it, or when they say "put it in slide format", "slide reader", "teleprompter", "make my script into slides", or "I record from a slideshow". Make sure to use this skill whenever a script is being handed to the owner to read or record - they read a slideshow, never a scrolling document.
---

> ⛔ **BEFORE THIS SKILL DOES ANYTHING, the production line gets read out loud.**
> Fire `rymac-follow-the-production-line` first. It posts the 9 stages, names the
> 5 skills, marks where this job starts, and waits for the owner's go.
> The 5 that fire on any video: `rymac-build-a-youtube-video`,
> `rymac-write-a-slide-video-script`, `rymac-edit-and-render-a-video`,
> `rymac-write-in-the-owners-voice`, `rymac-make-a-reader-to-record-from`.
> None of them wait to be named.

# The slide reader

The owner records every voiceover by reading a **slideshow**. One slide fills
the screen, they say it, they advance (click, space, arrow) to the next. They do
NOT read a scrolling list of slides. Handing them a scrolling document is the #1
mistake this skill exists to prevent.

**⛔ THE READER NEVER GUESSES THE SKIN. It reads YOUR config.**

Your colors and your font live in `_config/my-line.md`, written once by the
interview in `00-START-HERE.md`:

```
SKIN-NAME:   my-brand
SKIN-GROUND: #101318
SKIN-TEXT:   #f4f2ec
SKIN-ACCENT: #2b7fff
SKIN-FONT:   Archivo
```

The generator finds that file on its own by walking up from the script's
folder, or takes an explicit `--config=` path. Every reader comes out in those
exact values, and the gate script proves them in the finished file's bytes. A
config with no skin lines produces a loud placeholder that the gate refuses,
so the wrong look can never reach the owner in silence.

**This sits next to the other hard delivery rules: no em dashes, numbers always
digits. Same tier. A script is not delivered until it is a slide reader.**

## Input

A script in fold format: markdown with `[NNN] on-screen text` lines, `## Section`
headers (they become chapter jumps), indented `[PAUSE]` (becomes a HOLD screen)
and `[VISUAL: ...]` cues. A `> ENGINE: ...` line under the title becomes the SPEC
note at the top of the reader. That note is mandatory. The owner always knows
which system renders what they are reading.

**The color law:** green for good, red for bad. A date is not good or bad, it is
just a date, so neutral numbers stay in the base text color. The generator
auto-greens dollar amounts ONLY. Every other color is an authoring call via
inline markers: `{g:...}` green, `{r:...}` red, `{c:...}` accent for the brand's
action words. The words on screen stay verbatim. Markers carry color only. Use
restraint. The point is breaking the monotony with meaning, not a christmas tree.

## Process

0. **⛔ RE-READ THE SCRIPT FILE FROM DISK. FIRST. EVERY TIME. NO EXCEPTIONS.**

   Owners edit the script file directly and save it. They do not paste their
   edits into chat. The file on disk is the only truth, and the version in your
   context is stale the moment they touch it.

   Read the ENTIRE file. Not a grep, not a section. Never build a fold, a
   reader, a spec, or a render off a script you have in context. Read it again
   even if you wrote it 2 minutes ago.

   This rule exists because a reader once shipped missing a beat the owner had
   added to the saved file. It cost 20 minutes of a same-day upload window.
   **This applies to every stage downstream of a script, not just this skill.**

1. **Confirm the input is fold format** (`[NNN]` slide lines). A `02-SCRIPT.md`
   in `001.` numbered form gets converted first: save it as `04-VO-FOLD.md`
   beside the script, `001.` becomes `[001]`, nothing else changes.
2. **Generate the reader.** Deterministic, never hand-write the HTML:
   ```
   node "${CLAUDE_SKILL_DIR}/make-reader.mjs" <script.md> <out.html>
   ```
   It parses the slides, auto-colors quoted speech and dollar amounts, builds
   the chapter rail from the `##` headers, and writes a self-contained HTML
   reader. Inline CSS and JS, no external assets.
3. **Run the conformance gate. MANDATORY. No reader publishes without a PASS:**
   ```
   node "${CLAUDE_SKILL_DIR}/check-reader.mjs" <script.md> <out.html>
   ```
   It proves the skin in the actual output bytes, the SPEC note, every image
   cue embedded, the slide text laws (em dashes, periods, digits, the 14 word
   ceiling, the 1 second holds), and the slide count. It exists because 4 small
   drifts once reached the owner's eyes in a single night. A FAIL means fix and
   regenerate. Never publish over a FAIL, never skip the gate.
4. **Publish it as a page and hand over the link.** That link is the thing the
   owner records from. To update an existing reader, republish to the same
   place so the link never changes.

## What the owner gets

Full-screen dark stage, centered text, font auto-sized to word count. Click,
space, or right arrow advances. Left goes back. Number keys jump to a chapter.
`[PAUSE]` shows a blinking `HOLD 1s` marker. Images render on the slide itself.
The top bar shows chapter, visual cue, and slide NNN of total. A progress bar
tracks position. It matches the final render's look, so the owner rehearses
exactly what ships.

## What this actually is. Get it wrong and it costs 2 to 5 rebuilds.

**A crude mock of the FINISHED VIDEO, not a script with notes.** The owner
performs the slideshow to record. They are not reading a document, they are
presenting, so the reader must show them what the VIEWER will see. Notes kill
cadence and beats.

- **Every image in the final render appears on the slide.** A `[VISUAL: ...]`
  cue naming an image file auto-inlines that image. Never describe an image in
  words when you can show it.
- **Pauses carry their duration, and a hold is 1 second.** The owner counts the
  beat in their head. A fraction cannot be counted, and a marker with no number
  is useless.
- **No director notes on the slide.** Slide text and what is on screen. Nothing
  else.

## Rules

1. **Slideshow, never a scroll.** One slide at a time, advanced by the reader.
   If the output is a scrolling page of slide cards, it is wrong.
2. **Never hand-write the HTML.** Run the generator so every reader is
   identical and correct.
3. Numbers are digits, no em dashes. The script must already pass those gates
   before it becomes a reader.
4. **No periods on slide text.** Strip terminal punctuation from every slide the
   owner reads. Punctuation mid-read wrecks tonality, and tonality is a sales
   instrument. Slide breaks and HOLD markers carry the pacing. If the owner adds
   a period in their own pass, keep it. This is a recording aid, not grammar
   class.
5. **Check the generator output for image-not-found warnings before
   publishing.** A missing asset means the owner records that slide blind.
