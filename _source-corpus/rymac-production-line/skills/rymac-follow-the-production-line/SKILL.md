---
name: rymac-follow-the-production-line
description: Fires the moment any video work starts, and STOPS to read back the production line and the skills that will run before a single file is touched. Use when the user says "new video", "make a video", "going into production", "I'm recording", "I recorded", "here is the tape", "build the reader", "write the script", "align the VO", "render it", or names any stage (gameplan, script, spec, reader, VO, storyboard, 90s, render, package, blog). Also fires when a session is about to jump straight to one stage without the stages before it. Make sure to use this skill whenever a video is planned, written, recorded, cut, or rendered, named or not, because skipping a stage is the single most expensive defect in video production.
---

# Going into production: say the line out loud, then work

**The rule in 1 sentence: before any file is created, edited, or rendered, post the
stage list and the skills, mark where this job starts, and get the owner's go.**

⛔ **Nothing gets built during this skill. It is a checkpoint, not a stage.**
No script, no reader, no render, no folder. Read the state, post the plan, stop.

## Why this exists

This line has shipped more than 40 videos. The days it lost were never lost to a
missing skill. They were lost to a skipped stage.

The pattern that proved it: across every video that reached a recording, exactly 2
skipped the spec stage. Both were live screen-share builds. Both came back with
paragraph-length slides that had to be re-recorded. Every video that had a spec
came back clean.

**A live build is where stages get skipped**, because a long screen share looks like
it has nothing to spec. It has the most to spec: the slide sections that bookend it,
the look, the color rules, the capture handling, and how long a slide is allowed to
sit on screen.

## Step 1, read the state. Never guess it.

```
ls production/<video-folder>/                  which stages exist on disk RIGHT NOW
cat production/<video-folder>/01-GAMEPLAN.md   the lock block
```

The lock block answers brand, skin, surface, ending and slug. **It is DECLARED in
the gameplan, never guessed.** If the block is missing, stop and ask the owner
before building anything. Their answers live in `_config/my-line.md`.

## Step 2, the fork. Ask it before anything else.

If the gameplan does not already declare it, ask the owner 1 question:

**"Is this a YouTube video, a VSL, or both?"**

They are different outcomes and the answer decides the back half of the line:

| | YouTube video | VSL |
|---|---|---|
| The job | Content. Earn a subscriber, send them somewhere | Close. Buy something, book a call |
| `SURFACE:` | `channel` | `page` |
| The close | The owner's standing close, every time | NO standing close. The page under it carries the ask |
| Stages 8 and 9 | Community package, then the SEO blog post | The page the video sits on: a squeeze page for 1 decision, or a full sales page |

**The third answer is both.** One body, recorded once, 2 endings. The video
runs the channel rail (`SURFACE: channel`) and the lock block adds
`VSL-TAIL: yes`. The script marks where the endings split, the owner leaves 1
second of silence at the split when they record, and the render stage cuts 2
finished files: the channel version with the standing close, and the VSL
version that hands to the page. After the channel version ships, prompt 7b in
`PROMPTS.md` runs the page pass on the VSL version.

Write the answer into the lock block as `SURFACE:` (plus `VSL-TAIL: yes` on
both) and never ask again for this video. On the YouTube rail the page skills
can still be OFFERED in 1 line. Never pushed.

## Step 3, post this table, filled in for THIS job

The 9 stages, never reordered, never renumbered:

| # | Stage | File | Skill that runs it |
|---|---|---|---|
| 1 | Gameplan, opens with the locked keyword + hook from your research | `01-GAMEPLAN.md` | `rymac-build-a-youtube-video` |
| 2 | Script, numbered slides, the owner approves | `02-SCRIPT.md` | `rymac-build-a-youtube-video` + `rymac-write-a-slide-video-script` + `rymac-write-in-the-owners-voice` |
| 3 | **Spec**, the gate that keeps getting skipped | `03-SPEC.md` | `rymac-build-a-youtube-video` + `rymac-build-video-in-code` |
| 4 | VO reader, generated FROM the script. The owner records from it | `05-VO-READER.html` | `rymac-make-a-reader-to-record-from` |
| 5 | Storyboard from the ACTUAL recording | `05-STORYBOARD.md` + the gate page | `rymac-edit-and-render-a-video` |
| 6 | 90 second approval render | `out/` | `rymac-edit-and-render-a-video` |
| 7 | Full render + measured assembly | `out/*-final.mp4` | `rymac-edit-and-render-a-video` |
| 8 | **channel:** package + publish kit · **page:** the page build starts | zip + post, or the page | `rymac-package-a-video-for-your-community`, or `rymac-build-a-sales-page` / `rymac-paid-traffic-landing-page` |
| 9 | **channel:** the SEO blog post · **page:** the video embedded, the page live | the published post, or the live page | `rymac-write-an-seo-blog-post`, or the page skill finishing |

⚠️ While the owner records, nothing runs on their machine. No renders, no uploads,
no background jobs. A starved capture is a corrupted tape.

Then say, in 1 line each:

1. **Where this job starts** and which stages are already on disk
2. **Which stages are missing behind it**, by name, and that they get built first
3. **The lock block**, read off the gameplan, not remembered
4. **The skills firing**, by name, in order

## Step 4, stop and let the owner answer

One plain question, never a menu: *"Starting at stage N, building 3 and 4 first. Go?"*

If the answer is go, work the stages in order. If a stage behind you is missing,
**build it first. Do not note it and move on.** A missing stage is not a warning.
It is a stop.

## The 5 skills that fire on every video, and none of them wait to be named

1. `rymac-build-a-youtube-video`, the build itself
2. `rymac-write-a-slide-video-script`, owns the slide format and the under 6 seconds a slide law
3. `rymac-edit-and-render-a-video`, MANDATORY on any timing, alignment, render or assembly
4. `rymac-write-in-the-owners-voice`, before any word the owner publishes
5. `rymac-make-a-reader-to-record-from`, the reader itself

**Firing 1 of 5 is the failure shape.** Matching the owner's noun ("reader") to the
1 skill with that word in its name and stopping is how a stage gets skipped. The
other 4 say in their own descriptions that they fire unnamed.

## The 4 laws this checkpoint is protecting

1. **A slide holds under 6 seconds.** A person reads aloud at about 2.5 words a
   second, so 14 words is the ceiling. Complete spoken thoughts, never fragments,
   never an echo of the slide before it.
2. **A hold is 1 second.** The person recording counts a beat in their head. A
   fractional hold cannot be counted, and a long hold bleeds the attention the
   video was built to keep.
3. **Renders run in the cloud, never on the recording machine.** The measure is
   whether the owner's machine stays free, not the clock.
4. **The owner's voice is never cut.** A pause the edit needs is a pause they
   already performed.

## The gate that enforces it

`rymac-make-a-reader-to-record-from/check-reader.mjs` hard fails on a folder with no
`*-SPEC.md`, on any slide over 14 words, and on any hold that is not 1 second. Run
it. A FAIL is a stop, never a warning to mention while publishing anyway.

## Rules

1. **Post the plan before touching anything.** The plan IS the deliverable of this skill.
2. **Never invent a number.** Read stage state off disk, read the lock off the
   gameplan, read slide lengths off the file.
3. **Never skip a stage for speed.** The expensive days trace to skipped stages,
   not missing skills.
4. **Never ask the owner what comes next.** The rail is decided. Announce it and do it.
5. **A live build gets every stage**, and it needs the spec more than a slide video does.
