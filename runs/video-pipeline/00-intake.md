---
slug: video-pipeline
stage: 00_intake
status: approved
generated: 2026-09-07
door: ingest
sources:
  - _source-corpus/rymac-production-line/00-START-HERE.md
  - _source-corpus/rymac-production-line/PLAYBOOK.md
  - _source-corpus/rymac-production-line/CLAUDE.md
  - _source-corpus/rymac-production-line/CONTEXT.md
  - _source-corpus/rymac-production-line/PROMPTS.md
  - _source-corpus/rymac-production-line/_config/my-line.md
  - _source-corpus/rymac-production-line/_examples/one-video-start-to-finish.md
  - _source-corpus/rymac-production-line/01-RESEARCH/README.md
  - _source-corpus/rymac-production-line/02-SCRIPT/README.md
  - _source-corpus/rymac-production-line/03-RECORD/README.md
  - _source-corpus/rymac-production-line/04-EDIT/README.md
  - _source-corpus/rymac-production-line/05-PUBLISH/README.md
  - _source-corpus/rymac-production-line/checks/check-stages.sh
  - _source-corpus/rymac-production-line/checks/voice-check.sh
inventory: 116 files, 41 directories
---

# Intake, video-pipeline

Door B. Source is `_source-corpus/rymac-production-line/`, a working kit that
has shipped 40+ videos. Every answer below is marked `stated` (the material says
it) or `inferred` (I concluded it). Correct the inferred ones.

**This source already runs.** `01_form` must run the intent gate in
`_reference/source-fidelity.md` and record a verdict before planning any stages.

## Repeating unit

**One video.** `stated`

One run of the built agent takes one video from keyword to published, and
produces one folder: `production/<video-name>/`.

The material is explicit that a video is a self-contained folder with its own
`out/`. `CLAUDE.md` hard rule 6: "1 video = 1 self-contained folder under
`production/<video-name>/` with its own `out/`."

**A fork inside the unit, not a second unit.** `stated` A video is a YouTube
video, a VSL, or both. Asked once at stage 1, written into the gameplan lock
block as `SURFACE`, never asked again. "Both" means one body recorded once with
2 endings. This changes stages 8 and 9, not the unit.

**Not the unit:** the money-pages rail (prompt 8: research, profit calculator,
sales page, headline, letter, exit pop, call funnel, emails). It runs off a
research file, not off a video, and it has its own sequence. `inferred` that
this is out of scope for this build. See Open questions.

## One run, start to finish

In the material's own words, 9 stages plus a stage 0. `stated` throughout.

**Stage 0, before the line starts.** The owner opens their research tool and
finds the keyword. The hook ties the keyword to a reason to click. "Keyword,
hook and title get written at the top of the gameplan and LOCKED. Nothing
downstream re-researches them. You never make a video and then go looking for
traffic."

**Stage 1, the gameplan.** `01-GAMEPLAN.md`. Opens with the machine-read lock
block: `BRAND`, `SKIN`, `SURFACE`, `ENDS-ON`, `SLUG`. Under it the locked
keyword table, the audience, the ONE mechanic the video teaches, and what is
deliberately out of scope.

**Stage 2, the script.** `02-SCRIPT.md`. Numbered slides, never prose. One
complete spoken thought per slide, 14 words or fewer, "because you read at about
2.5 words a second and a slide holds under 6 seconds". Every number in the file
is counted by a script.

**Stage 3, the spec.** `03-SPEC.md`. Names the render engine on line 1, then
every shot, every color rule, and what must never appear on screen. "The stage
everyone skips, and the most expensive skip on the line. The 2 videos that ever
skipped it both had to be re-recorded."

**Stage 4, the fold, the reader, then the recording.** `04-VO-FOLD.md` converts
the script to reader lines (`001.` becomes `[001]`, nothing else changes).
`05-VO-READER.html` is generated from the fold: a full-screen slideshow, one
slide at a time, clicked through while recording. "It is a crude mock of the
finished video, never a document with notes." A byte gate checks the actual
output before the owner ever sees it.

**Stage 5, the storyboard.** Built from the ACTUAL recorded audio, not the
script. 1 row per spoken sentence. Approved on one page before anything renders.

**Stage 6, the 90 second render.** The first 90 seconds as a real playable file,
rendered in the cloud. "Nothing full-length renders before you approve this file."

**Stage 7, the full render.** Measured assembly, loudness checked on the output,
and a cut-point audit of the finished file.

**Stage 8, the package.** Community drop post, 2 to 5 files that each end in a
runnable prompt, a term sheet, a member-builds file, and the zip. Plus the
publish kit: locked title, 2 alternates, description in the owner's voice, real
chapter timestamps computed off the render, 2 thumbnails.

**Stage 9, the blog post.** Every live video gets a post behind it on the
owner's own site, claiming its own keyword row, embedding the video, linking
back into older posts.

**On the VSL fork:** stages 8 and 9 become the page the video sits on instead.
`stated`

## Stops

7 of these 8 are stated in the material as a place work halts. The spec stop is
inferred, and says so.

| After | The person does | Source |
|---|---|---|
| Stage 1 gameplan | Approves the locked keyword, hook, title | "get LOCKED", prompt 3 opens "The gameplan is approved" |
| Stage 2 script | Approves the script. "You approve it before anything else moves" | `02-SCRIPT/README.md` |
| Stage 3 spec | Approves the spec before the reader is built. `inferred`: prompt 4 builds the spec and the reader in one prompt with no stop between them, and the only approval language in the source is the error text at `check-reader.mjs:202` | `check-reader.mjs` |
| Stage 4 reader | Reads the byte gate result. "Give me the reader link only on a PASS" | `PROMPTS.md` prompt 4 |
| Stage 5 storyboard | Approves the gate page. "Do not render anything until I approve it" | prompt 5 |
| Stage 6 90s render | Watches it. "Nothing full-length renders before you approve this file" | `PLAYBOOK.md` stage 6 |
| Stage 7 full render | Approves the final after the cut-point audit | prompt 7 opens "The final is approved" |
| Stage 8 package | Hands over the live link, which triggers stage 9 | prompt 7 |

**A hard stop that is not an approval:** while the owner records, nothing else
runs on their machine. `stated`, and it is hard rule 3 in `CLAUDE.md`. This is a
stop on the *machine*, not on the work, and it came from a real failure (stove 2:
a starved 17 minute take with 6 seconds of black under the voice).

## Stable vs new

**Stable, every run (the built agent's stable layer; for this build it stays at
`_config/`, see open question 4):**

- **The owner's answers.** `_config/my-line.md`: brand, front door, niche, buyer,
  channel, site, blog home, community, research tool, skin (4 exact values),
  3 close beats, first recurring video. "This file is the 1 place your answers
  live. Every skill in this kit reads it instead of asking you again." `stated`
- **The skin, as law.** 4 values: ground, text, accent, font. "Whatever lands in
  the 4 value lines below is THE LAW: the reader generator paints with these
  exact values, and the byte gate proves them in every output." `stated`
- **The voice laws.** No em dashes. Numbers as digits. No developer talk on
  public surfaces. Plus 2 machine-read lines, `BANNED-WORDS` and `CLOSE-WORDS`,
  that the voice check reads. `stated`
- **The 9 stage names.** "Read stage names off the files on disk, never trust the
  number prefixes." Numbering drifts between videos; names are the truth. `stated`
- **The 6 hot stoves.** Each trap and its lesson, wired into the stages as rules.
  `stated`
- **The keyword map.** `_config/keyword-map.md`, so blog posts do not compete
  with each other. `inferred` from the `KEYWORD-MAP` config line and stage 9's
  "claiming its own keyword row".

**New, every run (stage outputs):** everything under `production/<video-name>/`.
The gameplan, script, spec, fold, reader, storyboard, the audio, the transcript,
and `out/` holding the 90s approval render, the final, the clean version, and 2
thumbnails.

## What ships

**Two artifacts leave, and which one depends on the fork.** `stated`

On the channel fork, the video goes live on YouTube, and behind it:

- the community package: drop post, 2 to 5 prompt files, term sheet,
  member-builds file, zip
- the publish kit: title, 2 alternates, description, chapter timestamps,
  2 thumbnails
- the blog post on the owner's own site

On the VSL fork, the page the video sits on: a squeeze page (1 decision, the
video, 1 button) or a sales page (the full close, video in the hero).

The finished folder, stated verbatim in the example:

```
production/follow-up-emails/
  01-GAMEPLAN.md  02-SCRIPT.md  03-SPEC.md  04-VO-FOLD.md
  05-VO-READER.html  05-STORYBOARD.md  VO.mp3  vo-transcript.txt
  out/  approval-90s.mp4, <slug>-final.mp4, <slug>-clean.mp4,
        <slug>-thumb-A.png, <slug>-thumb-B.png
```

## Who else touches it

**Nobody, in the run.** `inferred`. The material is written throughout to a
single owner ("you"), and the only named second party is the community that
receives the package. There is no handoff to an editor, a designer, or a writer.
The whole economic argument in `PLAYBOOK.md` Part 1 is that the line replaces
those 5 roles.

**But the kit ships to strangers.** `stated`. `00-START-HERE.md` is written for
someone who does not know what a markdown heading is, and the interview exists
because "right now every file in this kit runs on placeholder answers". So the
built agent needs real routing and a real cold-start path, not a thin `CLAUDE.md`.

## Open questions

1. **Scope: is the money-pages rail in or out?** Prompt 8 runs a second sequence
   (research, profit calculator, sales page, headline, sales letter, exit pop,
   call funnel, relationship emails) that keys off a research file rather than a
   video. 9 of the 20 skills serve it. It is a different repeating unit. My read
   is that this build is the video line only, and the money rail is a separate
   build later. The 2 research skills are shared either way: stage 0 and prompt
   2's "I have no keyword" path run them, so they stay. **Confirm or overrule.**

2. **The 20 skills: port, reference, or rebuild?** The kit's process lives mostly
   in `skills/`, not in the 5 stage folders. `rymac-build-video-in-code` alone
   carries 37 rule files and 3 `.tsx` assets, and 3 skills ship working code the
   pipeline depends on (`make-reader.mjs`, `check-reader.mjs`, a `.woff2` font).
   **Now answered by `01_form`, not by the operator.** The source-fidelity gate
   decides this on evidence. Preliminary reading: converting a 14 KB skill into a
   750 token contract deletes the procedure rather than compressing it, which
   points at `additive`.

3. **Whose line is it?** `_config/my-line.md` is a blank template. Every value
   (brand, skin, close beats) is unfilled, and the kit's answer is an interview
   at first run. Does the built agent ship blank with the interview, or filled in
   with your actual answers? **Blank is the portable choice and matches the
   source. Confirm.**

4. **How many stage folders?** 3 separate structures, and the first 2 answers
   collapsed them. Corrected reading, from the scripts and the skills that call
   them:

   - **Inside `production/<video>/`: frozen.** `checks/check-stages.sh` matches
     `NN-NAME` on files sitting directly in the video folder. Nesting them one
     level deeper makes the gap checker report clean on every video. This layout
     cannot change.
   - **The workspace's own folders: free, with 2 referrers.** `01-RESEARCH/`
     through `05-PUBLISH/` are named by zero scripts and hold one README each.
     2 files point at them: `skills/rymac-edit-and-render-a-video/SKILL.md:43`
     names `04-EDIT/README.md`, and the source `CLAUDE.md` routes 2 tasks to
     `01-RESEARCH/`, which also receives the research files the skills read.
     Free to rename if both referrers move in the same change. The count is
     decided by the work, not inherited.
   - **`_config/my-line.md`, above `production/`, under that name: frozen.**
     `make-reader.mjs` and `check-reader.mjs` walk up 6 levels from the fold to
     find `_config/my-line.md`. The byte gate fails closed without it, and
     `--config=` is the only override. `_config/keyword-map.md` is named inside
     the config. The owner's answers cannot move to `_reference/`.

   On the work: all 9 stages have a distinct output and a distinct human gate, so
   by ICM's own test that is 9 stage boundaries. The source's 5 folders group them
   for filing convenience, which hides 3 approval gates behind `02-SCRIPT/` and 3
   more behind `04-EDIT/`. `01_form` decides and records the count with evidence.

5. **Binary and code assets.** The source carries `.mjs`, `.py`, `.sh`, `.tsx`,
   and a `.woff2` font. The factory has only ever emitted markdown. These need to
   ride along or the reader generator and the byte gates do not work.
   `inferred` that they copy across unchanged. **Confirm.**

6. **Where does `production/` live?** The source keeps videos in
   `production/<video-name>/` inside the kit. Under the factory's own convention
   that would be `runs/<video>/`. **Keeping `production/` matches the source and
   the owner's habit. Confirm which.**

7. **The name.** Slug is `video-pipeline`. The source calls itself "the
   production line". **Confirm the slug, it is permanent.**

8. **Source-internal disagreements an `additive` verdict inherits.**
   `00-START-HERE.md` lists 9 interview questions; `PROMPTS.md` prompt 1 says 8,
   twice. `skills/rymac-explain-it-to-a-beginner/check-plain.sh:9-10` points at
   `production/voice-check.sh`, which lives at `checks/voice-check.sh`. 9 skill
   READMEs link `../../README.md`, which in a build resolves to the build's own
   README by accident. **Decide: carry them, or fix each in the copy with the fix
   logged in the manifest.**
