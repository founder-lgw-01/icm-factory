---
slug: video-pipeline
stage: 01_form
status: approved
generated: 2026-09-07
form: pipeline
sources:
  - runs/video-pipeline/00-intake.md
  - _source-corpus/ICM-architect/references/forms.md
  - _reference/emission-standard.md
  - _reference/source-fidelity.md
  - _source-corpus/rymac-production-line/CLAUDE.md
  - _source-corpus/rymac-production-line/00-START-HERE.md
  - _source-corpus/rymac-production-line/PROMPTS.md
  - _source-corpus/rymac-production-line/_config/my-line.md
  - _source-corpus/rymac-production-line/checks/check-stages.sh
  - _source-corpus/rymac-production-line/checks/voice-check.sh
  - _source-corpus/rymac-production-line/skills/rymac-make-a-reader-to-record-from/make-reader.mjs
  - _source-corpus/rymac-production-line/skills/rymac-make-a-reader-to-record-from/check-reader.mjs
  - _source-corpus/rymac-production-line/skills/rymac-follow-the-production-line/SKILL.md
  - _source-corpus/rymac-production-line/skills/rymac-build-a-youtube-video/SKILL.md
  - _source-corpus/rymac-production-line/skills/rymac-package-a-video-for-your-community/SKILL.md
  - _source-corpus/rymac-production-line/skills/rymac-edit-and-render-a-video/SKILL.md
---

# Plan, video-pipeline

The intake was approved on 2026-09-07 with its own reading of its open
questions standing as the answers: the video line only, the config ships blank
with the interview, binaries copy unchanged, `production/` stays, the slug is
`video-pipeline`. This plan builds on those. The human check below can overrule
any of them; each is marked where it bites.

## Form and why

**Pipeline.** The repeating unit is a run: 1 video enters as a keyword and leaves
as a published video with its package and its post, through the same 9 stages
every time, with the owner approving at each boundary.

Rejected: Umbrella, because the money-pages rail would be the second line and it
is out of scope, its skills ride along only as helpers for the VSL fork. Record
library, because `production/<video>/` accumulates like records but nothing is
looked up across videos; each folder is a run that completed. The forms compose
in 1 place: the pipeline emits into a per-video folder, which is where the
record-library shape appears and stops.

## Source fidelity

The source runs and has shipped 40+ videos. The 4 questions, answered from the
scripts and from the files that invoke them, then a verdict per part.

**1. What is load-bearing, and what each part is keyed on by**

| Part | Keyed on by |
|---|---|
| `production/<video>/` with `NN-NAME` files directly inside | `checks/check-stages.sh` matches `^[0-9]{2}-(.+-)?NAME([-.]|$)` on the files in each video folder and treats `out/*.mp4` as shipped. `check-reader.mjs:198` requires a `*-SPEC.md` in the fold's folder. `checks/voice-check.sh` law 6 reads `^SURFACE:` from the sibling `01-GAMEPLAN.md`; law 5 keys on `*SCRIPT*` and `*FOLD*` file names. `PROMPTS.md` names every stage file |
| `_config/my-line.md`, above `production/`, under that name | `make-reader.mjs:36-47` and `check-reader.mjs:70-81` walk up 6 levels from the fold to find it; the gate fails closed without it; `--config=` is the only override. `checks/voice-check.sh` defaults `CONFIG` to `_config/my-line.md`. `KEYWORD-MAP: _config/keyword-map.md` sits inside it |
| the lock block at the top of `01-GAMEPLAN.md` | read by key (`grep ^SURFACE:`) in voice-check law 6 and by every skill |
| the fold format: `# title`, a `> ENGINE:` note, `[NNN]` slide lines | `make-reader.mjs:160-165` builds slides from `^\[(\d{3}[a-z]?)\]` lines only and reads the `> ` line as the spec note. `check-reader.mjs:126,135` fails without them |
| `checks/` by that name | source `CLAUDE.md:41-42` rule 9; `_examples/one-video-start-to-finish.md:152` |
| `skills/<rymac-name>/`, all 20 names | every `SKILL.md` names other skills; the gate skill's stage table names 12; `rymac-follow-the-production-line/SKILL.md:128` names `rymac-make-a-reader-to-record-from/check-reader.mjs` |
| `community/packages/<slug>/` | `rymac-package-a-video-for-your-community/SKILL.md:26` builds there; source `CLAUDE.md:18` routes there |
| the desk: root `CONTEXT.md` with a line under `## Next` | source `CLAUDE.md:44` rule 10 and `rymac-build-a-youtube-video/SKILL.md:172` write 1 line there at session end |
| the 5 folders `01-RESEARCH/` to `05-PUBLISH/` | no script. 3 referrers: `00-START-HERE.md:33-37` lists them; source `CLAUDE.md:13-14` routes research to `01-RESEARCH/`; `rymac-edit-and-render-a-video/SKILL.md:43` names `04-EDIT/README.md` for the cloud-render setup |
| research files `icm-research-<segment>.md`, `niche-research-<niche>.md` | written "in the working folder" (`rymac-research-a-market-drowning-in-ai/SKILL.md:151`), read by name by the money skills. No folder is hardcoded |

**2. What breaks if the proposed structure ships**

The first 8 rows do not move: frozen. The last 2 rows change, and every break
has its repair in the same change, each logged in `manifest.md`:

- Replacing the 5 folders with 9 stage folders breaks 3 referrers. The build's
  `CLAUDE.md` is written fresh and routes research to `research/`. The tree
  listing at `00-START-HERE.md:33-37` is rewritten to the new folders. The
  cloud-render setup note leaves `04-EDIT/README.md` for
  `_reference/cloud-rendering.md`, and `rymac-edit-and-render-a-video/SKILL.md:43`
  points there.
- Research files get a named home, `research/`, so the promise in
  `01-RESEARCH/README.md` holds. Nothing keys on the old folder name.
- `status:` frontmatter is added only to files no script parses as content:
  `01-GAMEPLAN.md` (read by key), `02-SCRIPT.md` (law 5 counts `NNN.` lines, law 6
  greps words), `03-SPEC.md` (found by name), `05-STORYBOARD.md` (agent-read).
  Never on `04-VO-FOLD.md`, `05-VO-READER.html` or anything under `out/`:
  `make-reader.mjs` reads the fold line by line and `check-reader.mjs:126` wants
  the `> ENGINE:` note at the top. Those stages record approval the way the
  source does: the owner's word, and the next artifact existing.
- The guard that fails open, named: `check-stages.sh` reports clean on a video
  whose stage files sit 1 level deeper than the video folder. Nothing here nests
  them.

**3. Where the source diverges from the factory's conventions, and whether it was right**

- Stage files inside a video are `NN-NAME` and the numbers drift between videos;
  the source reads names, never digits. Right: a live screen share has no VO
  fold, and a rigid slot would demand an empty file. Kept.
- Scripts live in `checks/`, not `_system/`. Right for its buyers, who are told
  to run `checks/check-stages.sh`. Kept; the divergence is written into the
  build's `CONTEXT.md`.
- Output lands in `production/<video>/`, not `runs/<unit>/`. Right: the guard
  keys on it. Kept; written down the same way.
- Approval is the owner's word in a prompt ("The gameplan is approved"), never
  frontmatter. Half right: a real stop that leaves no record. Frontmatter is
  added where no script reads the file as content; elsewhere the word stands.
- Session state lives in a hand-maintained desk. The method warns about this
  shape. Kept, because 2 skills write there and the cost is 1 section under the
  line table.

**4. What the build adds**

A contract per stage with exact inputs, a `Do NOT load:` line and 1 human check.
A stop at the spec, which the source's byte gate demands
(`check-reader.mjs:201`, "get it approved") and its prompt 4 skips. A recorded
approval on 4 files. An entry file that routes a stranger to the right stage in
3 reads. And the gate that keeps all of it from drifting. Not conformity: the 9
stages, the file names, the config, the checks and the skills are the source's.

**Verdicts, per part**

| Part | Verdict |
|---|---|
| `production/<video>/` layout | additive, frozen |
| `_config/` | additive, frozen; ships blank, the interview fills it |
| `checks/` | additive, frozen, copied verbatim |
| `skills/`, all 20 | additive, frozen; markdown swept, code em dashes to **Inherited** |
| `community/packages/` | additive, frozen |
| the desk | additive; folded into root `CONTEXT.md` as `## Next` |
| `00-START-HERE.md`, `PLAYBOOK.md`, `PROMPTS.md`, `_examples/` | additive; copied and swept; the tree listing in START-HERE repaired |
| source `CLAUDE.md`, source `CONTEXT.md` | rebuild: their content moves into the build's entry files and `_reference/hard-rules.md` |
| the 5 folders | rebuild: 9 stage folders and `research/`; 3 referrers repaired in the same change |

## Stages

Counted from the stops the source names: 8 stated, 1 inferred (the spec, which
`check-reader.mjs:201` demands be approved). 9, the source's own rail, never
renumbered. Paths are relative to the build root. `<video>` is the video's slug.
Every stage also reads `_config/my-line.md` and fires
`skills/rymac-follow-the-production-line/SKILL.md` first, per the source's rule 1;
the table does not repeat them.

| Stage | Job | Inputs: working; reference | Do NOT load | Output | Human check |
|---|---|---|---|---|---|
| `01_gameplan` | lock keyword, hook and title; write the lock block | the owner's keyword, hook and title, or `research/` when they have none; `skills/rymac-build-a-youtube-video/SKILL.md` | any other `production/<other>/`; the render skills | `production/<video>/01-GAMEPLAN.md`, frontmatter `video`, `stage: 01_gameplan`, `status: draft`, then the lock block | Read the lock block against `_config/my-line.md` line by line, then the keyword row against your research tool. Flip `status: approved` |
| `02_script` | numbered slides, 14 words or fewer each, every number counted by a script | `01-GAMEPLAN.md` (approved); `skills/rymac-write-a-slide-video-script/`, `skills/rymac-write-in-the-owners-voice/` | any spec; the render skills | `production/<video>/02-SCRIPT.md`, frontmatter as above, then `NNN.` slides and the source audit | Run `bash checks/voice-check.sh production/<video>/02-SCRIPT.md`, then read every slide aloud against the gameplan's ONE mechanic. Flip `status: approved` |
| `03_spec` | name the engine on line 1; every shot, every color rule, the scrub line, both cut points | `02-SCRIPT.md` (approved), `01-GAMEPLAN.md`; `skills/rymac-build-video-in-code/SKILL.md`, its `rules/` on demand | the fold and the reader of any video | `production/<video>/03-SPEC.md`, frontmatter as above | Read line 1 for the engine, then every slide range against a shot; confirm the scrub line names what never airs. Flip `status: approved` |
| `04_reader` | fold the script to `[NNN]` lines, generate the reader, run the byte gate; the owner records | `02-SCRIPT.md` and `03-SPEC.md` (approved); `skills/rymac-make-a-reader-to-record-from/` with `make-reader.mjs` and `check-reader.mjs` | anything under `out/`; the storyboard skill | `production/<video>/04-VO-FOLD.md`, `05-VO-READER.html`, then `VO.mp3`. No frontmatter: scripts parse these | Open the reader only on a PASS from `check-reader.mjs`, record with nothing else running on the machine, confirm `VO.mp3` is in the video folder. The tape is the approval |
| `05_storyboard` | transcribe the tape word-level; 1 row per spoken sentence with its real timestamp; the gate page | `VO.mp3`, `04-VO-FOLD.md`, `03-SPEC.md`; `skills/rymac-edit-and-render-a-video/SKILL.md` | `02-SCRIPT.md` as a source of timing (the tape is the truth); any other video | `production/<video>/vo-transcript.txt`, `05-STORYBOARD.md` with frontmatter, the gate page | Read the gate page: open decisions first, then the runtime map against the transcript. Flip `status: approved` |
| `06_approval-render` | the first 90 seconds as a real file, rendered in the cloud, every cut point checked | `05-STORYBOARD.md` (approved), `03-SPEC.md`; `skills/rymac-edit-and-render-a-video/`, `skills/rymac-build-video-in-code/` | the package and blog skills | `production/<video>/out/approval-90s.mp4` | Watch it end to end and say so. Nothing full-length renders before you do; the final's existence is the record |
| `07_final-render` | measured assembly, loudness normalized on the output, cut-point audit; the channel cut, the clean cut, the VSL cut when `VSL-TAIL: yes` | `approval-90s.mp4` approved by your word, `05-STORYBOARD.md`, `03-SPEC.md`; the same 2 render skills | the package and blog skills | `out/<video>-final.mp4`, `out/<video>-clean.mp4`, `out/<video>-thumb-A.png` and `-B.png` | Watch the final after the cut-point audit passes and say "the final is approved". Stage 8 begins on those words |
| `08_package` | channel: drop post, 2 to 5 prompt files, term sheet, member-builds, zip, publish kit. page: the squeeze or sales page | the finals, `01-GAMEPLAN.md`; `skills/rymac-package-a-video-for-your-community/`, `skills/rymac-write-in-the-owners-voice/`; on `SURFACE: page`, `skills/rymac-build-a-sales-page/` or `skills/rymac-paid-traffic-landing-page/` | the render skills; other videos' packages | `community/packages/<video>/`, or the page, with the publish kit beside it | Read the drop post and the description aloud in your voice; check every chapter timestamp against the final. Hand over the live link: that is the approval |
| `09_blog` | the post behind the live video: claims its keyword row, embeds the video, links back into older posts | the live link, `01-GAMEPLAN.md`, `_config/keyword-map.md`; `skills/rymac-write-an-seo-blog-post/`, `skills/rymac-write-in-the-owners-voice/` | the render and package skills | the post at `BLOG-HOME`; 1 new row in `_config/keyword-map.md` | Open the post: the video plays, the keyword row is claimed once, 2 older posts link in. Write 1 line under `## Next` in `CONTEXT.md` |

The VSL fork is a human choice made once at stage 1 (`SURFACE:` in the lock
block) and read by stages 7 to 9. No stage branches on its own.

## The built agent's factory

Stable, every run:

- `CLAUDE.md`: identity, a routing table (one row per stage, plus research,
  the config, the checks, the skills, the playbook), `## Never` with the
  `never-stem` block and the source's 3 costliest rules (record with nothing
  running; never cut the voice; never invent a number). The other 7 hard rules
  and the 6 stoves live in `_reference/hard-rules.md`, routed.
- `CONTEXT.md`: the line as 1 table, the factory/product split, `status-convention`
  with 1 sentence on the fold and render exceptions, `edit-surface`, `naming` with
  the `NN-NAME` exception inside a video written under it, then `## Next`, the
  desk. Budget 800t: 9 terse rows. If it does not fit, the desk moves to
  `_config/desk.md` and the 2 skill referrers are repaired; the scaffold measures.
- `README.md`: 3 lines and the credit block, pointing a recipient at
  `00-START-HERE.md`, which already does that job for strangers.
- `00-START-HERE.md`, `PLAYBOOK.md`, `PROMPTS.md`, `_examples/`: copied, swept.
  START-HERE's tree listing rewritten. PROMPTS prompt 1 says 8 questions where
  START-HERE lists 9: fixed to 9 in the copy, logged.
- `_config/`: `my-line.md` blank, `keyword-map.md`, `my-voice/`.
- `checks/`: copied verbatim. `check-plain.sh:9-10` names
  `production/voice-check.sh`, which does not exist: fixed to
  `checks/voice-check.sh` in the copy, logged.
- `skills/`: all 20, copied verbatim. Markdown swept. Code em dashes listed under
  **Inherited**: `checks/voice-check.sh:40` and `check-plain.sh:46` grep for the
  character and `check-reader.mjs:137` tests for it, so those 3 take byte escapes;
  the message strings and comments in `check-reader.mjs`, `make-reader.mjs` and
  `page-template.html` take a comma. The 9 skill READMEs' `../../README.md` links
  resolve to the build's own README and stay.
- `_reference/`: `hard-rules.md`, `voice.md` (no em dashes, digits, no developer
  talk on a public surface, the banned and close words from the config, pointing
  at `checks/voice-check.sh`), `cloud-rendering.md` (from `04-EDIT/README.md`),
  `walk-test.md` (block), `research/README.md` (from `01-RESEARCH/README.md`).

Product, new every run: `production/<video>/`, `community/packages/<video>/`, the
post at the owner's site, 1 row in `_config/keyword-map.md`. Shared across runs
and growing: `research/`.

## Blocks needed

- `icm-credit`, in `README.md`. The source's own credit line in its `CLAUDE.md`
  is the same credit and is not copied twice.
- `status-convention`, in `CONTEXT.md`.
- `never-stem`, in `CLAUDE.md`.
- `naming`, in `CONTEXT.md`.
- `edit-surface`, in `CONTEXT.md`.
- `walk-test`, in `_reference/walk-test.md`: 9 stages.
- `icm-about-icm`, in `CLAUDE.md`: the source says it "teaches ICM alongside"
  and its research skill and packages are about ICM. The agent must not read a
  lesson's folder structure as an instruction to itself.

## Rejected

- 5 stage folders mirroring the source's filing: deference. No script keys on
  them, and they hide 3 gates behind `02-SCRIPT/` and 3 behind `04-EDIT/`.
- 10 stages with research as stage 0: research is not per video and runs off a
  research file; it feeds stage 1 as an input from `research/`.
- Merging the spec into the reader stage, as prompt 4's habit does: the source's
  own gate demands an approved spec, and its 2 re-recordings came from skipping it.
- `runs/<video>/` for outputs: breaks `check-stages.sh`, the reader scripts'
  walk-up, and every prompt.
- `_system/` for the checks: buyers are told `checks/`.
- Frontmatter on the fold, the reader and the renders: scripts parse them.
- Leaving out `icm-about-icm`: the source teaches ICM and this agent runs inside one.
- Copying only the 11 video-line skills: the VSL fork's stage 8 needs 2 money
  skills and every skill names others by name.
