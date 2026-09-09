---
slug: video-pipeline
stage: 02_scaffold
status: approved
generated: 2026-09-07
sources:
  - runs/video-pipeline/01-plan.md
  - runs/video-pipeline/00-intake.md
  - _templates/agent-skeleton/
  - _reference/emission-standard.md
  - _reference/voice.md
---

# Manifest, video-pipeline scaffold

The built agent's tree, complete except for blocks. `03_emit` copies it to
`builds/video-pipeline/`, resolves every `BLOCK:` line, and strips this file and
`SKELETON.md`.

## Files written by the scaffold

| File | Holds |
|---|---|
| `CLAUDE.md` | identity, the routing table, `## Never` with 2 block markers |
| `CONTEXT.md` | the 9-stage line as 1 table, the factory/product split, 3 block markers, the 2 divergences written down, the desk under `## Next` |
| `README.md` | 3 paragraphs for a recipient and the credit marker; points at `00-START-HERE.md` |
| `01_gameplan/CONTEXT.md` to `09_blog/CONTEXT.md` | 9 stage contracts, each with Inputs, `Do NOT load:`, Process, Outputs, 1 human check |
| `_reference/hard-rules.md` | the source's 10 hard rules and 6 stoves, from its `CLAUDE.md` and `PLAYBOOK.md` part 6 |
| `_reference/voice.md` | the owner's voice laws, pointing at `checks/voice-check.sh` and the config's 2 machine-read lines |
| `_reference/cloud-rendering.md` | the AWS and Remotion setup note, from the source's `04-EDIT/README.md` and `PLAYBOOK.md` part 5 |
| `_reference/walk-test.md` | 1 block marker |
| `research/README.md` | the research folder's contract, from the source's `01-RESEARCH/README.md` |
| `SKELETON.md` | the skeleton's how-to, present in the scaffold, stripped at emit |

## Copied verbatim from the source, per the plan's `additive` verdicts

| Part | Files |
|---|---|
| `skills/` | 100, all 20 skills |
| `checks/` | 2 |
| `_config/` | 3, `my-line.md` blank |
| `_examples/` | 1 |
| `00-START-HERE.md`, `PLAYBOOK.md`, `PROMPTS.md` | 3 |

Not carried: the source's `CLAUDE.md` and `CONTEXT.md` (rebuilt as the entry files
above), and the 5 folders `01-RESEARCH/` to `05-PUBLISH/` (their 5 READMEs went
into `research/README.md`, `_reference/cloud-rendering.md`, and the contracts for
stages 2 to 9).

## Repairs made in copies, each logged here

1. `00-START-HERE.md:30-37`: the tree listing now names `research/`, the 9 stage
   folders, `_reference/` and `production/` instead of the 5 old folders, and
   describes `CONTEXT.md` as the line and the desk.
2. `skills/rymac-edit-and-render-a-video/SKILL.md:43`: `04-EDIT/README.md` became
   `_reference/cloud-rendering.md`.
3. `skills/rymac-explain-it-to-a-beginner/check-plain.sh:9-10`:
   `production/voice-check.sh` became `checks/voice-check.sh`, the path that exists.
4. `PROMPTS.md:8,13`: "the 8 questions" and "8 plain lines" became 9, matching the
   9 questions `00-START-HERE.md` lists.
5. `00-START-HERE.md:30,55,72`, found by running the kit's own
   `check-plain.sh` on the emitted build from outside the factory. Line 30, "on
   one screen", was written by repair 1 and breaks the kit's digits rule: now
   "on 1 screen". Lines 55 and 72 are the source's own text and fail its own
   gate: "what you sell" became "what you offer" (the kit bans the verb), and
   "if you have one" became "if you have 1". The fragment at line 10 is the
   owner's own and stays; the checker itself says so.
6. `_reference/voice.md:11-13`: the developer-talk law listed the banned words
   in its own text, and the kit's `checks/voice-check.sh` flags them wherever
   they appear. The law now points at the script for the list.
7. `README.md:3-6,18-20`: 2 sentences of 20+ words split, so the kit's
   `grade.py` reads the page under its fail line of 5.0.
8. Digits, found by the factory's law 3 once it was gated: "One job:" at the top
   of all 9 contracts and "ONE mechanic" in `02_script/CONTEXT.md:36` (this
   scaffold's own text); `CLAUDE.md:10` "on one screen" (this scaffold's text);
   `PLAYBOOK.md:69,74,88,99,138` and `PROMPTS.md:3,30,35` (the source's text,
   failing its own rule). Each is now a digit, or "it" where "one" was a
   pronoun.

## Self-checks

The checks this build ships, run by the gate from the build root on the files
this scaffold wrote or repaired. `{file}` is each listed file in turn. The kit's
voice check covers every authored page and the 3 repaired root pages. The 4
teaching gates cover the 2 pages written for a customer, as the teaching skill
scopes them. `check-fragments.py` skips `00-START-HERE.md`: its 1 fragment is
the owner's own, which the skill's law 1 keeps.

check: bash checks/voice-check.sh {file} :: CLAUDE.md CONTEXT.md README.md 00-START-HERE.md PLAYBOOK.md PROMPTS.md 0*_*/CONTEXT.md _reference/*.md research/README.md
check: bash skills/rymac-explain-it-to-a-beginner/check-plain.sh {file} :: 00-START-HERE.md README.md
check: python skills/rymac-explain-it-to-a-beginner/grade.py {file} :: 00-START-HERE.md README.md
check: python skills/rymac-explain-it-to-a-beginner/check-sourced.py {file} :: 00-START-HERE.md README.md
check: python skills/rymac-explain-it-to-a-beginner/check-fragments.py {file} :: README.md

## Block markers left for emission

| Marker | In |
|---|---|
| `BLOCK: never-stem` | `CLAUDE.md`, under `## Never` |
| `BLOCK: icm-about-icm` | `CLAUDE.md`, last line |
| `BLOCK: status-convention` | `CONTEXT.md` |
| `BLOCK: edit-surface` | `CONTEXT.md` |
| `BLOCK: naming` | `CONTEXT.md` |
| `BLOCK: icm-credit` | `README.md`, last line |
| `BLOCK: walk-test` | `_reference/walk-test.md`, the whole file |

## Swept

`_system/sweep-em-dash.sh` replaced 397 em dashes in 31 copied markdown files.
Occurrences before and after, per file:

| Before | After | File |
|---|---|---|
| 53 | 0 | `skills/rymac-write-a-slide-video-script/references/vsl-beat-structures.md` |
| 35 | 0 | `skills/rymac-paid-traffic-landing-page/references/page-structure.md` |
| 35 | 0 | `skills/rymac-write-a-headline/references/headline-formulas.md` |
| 29 | 0 | `skills/rymac-paid-traffic-landing-page/references/niche-research.md` |
| 29 | 0 | `skills/rymac-write-a-headline/references/swipe-file.md` |
| 26 | 2 | `skills/rymac-write-a-headline/SKILL.md` (2 in fenced code, below) |
| 23 | 0 | `skills/rymac-paid-traffic-landing-page/SKILL.md` |
| 16 | 0 | `skills/rymac-paid-traffic-landing-page/references/headlines.md` |
| 15 | 0 | `skills/rymac-write-a-sales-letter/references/letter-anatomy.md` |
| 15 | 0 | `skills/rymac-write-a-sales-letter/references/voice-dna.md` |
| 15 | 0 | `skills/rymac-write-a-slide-video-script/references/slide-pacing.md` |
| 14 | 0 | `skills/rymac-write-a-headline/references/hero-and-cta.md` |
| 14 | 0 | `skills/rymac-write-a-sales-letter/references/pas-framework.md` |
| 10 | 0 | `skills/rymac-paid-traffic-landing-page/README.md` |
| 10 | 2 | `skills/rymac-write-a-sales-letter/SKILL.md` (2 in fenced code, below) |
| 9 | 0 | `skills/rymac-build-a-sales-page/README.md` |
| 9 | 0 | `skills/rymac-write-a-headline/README.md` |
| 9 | 0 | `skills/rymac-write-a-sales-letter/README.md` |
| 6 | 0 | `skills/rymac-build-video-in-code/rules/timing.md` |
| 6 | 0 | `skills/rymac-build-video-in-code/rules/transitions.md` |
| 4 | 0 | `skills/rymac-research-a-trade-niche/references/the-3-laws.md` |
| 3 | 0 | `skills/rymac-build-video-in-code/rules/light-leaks.md` |
| 3 | 0 | `skills/rymac-build-video-in-code/rules/silence-detection.md` |
| 3 | 0 | `skills/rymac-write-a-headline/evals.md` |
| 2 | 0 | `skills/rymac-build-a-profit-calculator/README.md` |
| 2 | 0 | `skills/rymac-exit-pop/README.md` |
| 2 | 0 | `skills/rymac-relationship-sequence/README.md` |
| 1 | 0 | `skills/rymac-build-video-in-code/SKILL.md` |
| 1 | 0 | `skills/rymac-call-funnel/README.md` |
| 1 | 0 | `skills/rymac-research-a-trade-niche/README.md` |
| 1 | 0 | `skills/rymac-research-a-trade-niche/references/delivery-costs.md` |

## Inherited

28 em dashes were inherited in code and in fenced code. The owner decided on
2026-09-07 ("apply the edits") and every line was changed exactly as recommended
below, in the scaffold copies only. 0 em dashes remain in the scaffold; the 4
scripts touched still parse (`bash -n`, `node --check`).

**Working literals, 3. A byte escape keeps them working; a comma breaks the check.**

| Line | Recommendation |
|---|---|
| `checks/voice-check.sh:40` | the quoted em dash in the grep pattern becomes `$'\xe2\x80\x94'` |
| `skills/rymac-explain-it-to-a-beginner/check-plain.sh:46` | the 2 quoted dashes (em, en) become `$'\xe2\x80\x94'` and `$'\xe2\x80\x93'` |
| `skills/rymac-make-a-reader-to-record-from/check-reader.mjs:137` | the quoted em dash inside `.includes()` becomes the U+2014 escape: backslash, u, 2014, in double quotes |

**Message strings and comments, 21. A comma or a colon; nothing depends on the character.**

- `skills/rymac-make-a-reader-to-record-from/check-reader.mjs` lines 132, 144,
  149, 165, 186, 189, 201 (7, all inside message strings)
- `skills/rymac-make-a-reader-to-record-from/make-reader.mjs` lines 256, 259 (2, comments)
- `skills/rymac-paid-traffic-landing-page/assets/page-template.html` lines 10,
  16, 40, 46, 65, 73, 88, 97, 104, 111, 143, 160 (12, CSS and HTML comments)

**Fenced code in markdown, 4. These are templates the skills emit into pages and
letters; a comma applies the owner's own law to what ships.**

- `skills/rymac-write-a-headline/SKILL.md:32` (a template line)
- `skills/rymac-write-a-headline/SKILL.md:99` (a template line)
- `skills/rymac-write-a-sales-letter/SKILL.md:79` (a template heading)
- `skills/rymac-write-a-sales-letter/SKILL.md:88` (a template line)

## Carried as found

The 9 skill READMEs link `../../README.md`, which resolves to this build's own
`README.md`. Harmless, and left alone.

## Dry run

A scratch copy of this scaffold with the 7 blocks resolved, as `03_emit` will
resolve them, was put through `_system/validate.sh`. Before the Inherited edits,
9 of 10 sections passed and voice failed on the 28 lines and nothing else. After
them, all 10 pass. Resolved sizes:
`CLAUDE.md` 626 tokens and 53 lines of 800 and 60; `CONTEXT.md` 778 tokens of
800; the 9 contracts 434 to 564 tokens of 650. Root `CONTEXT.md` lost its flow
line to fit; the desk under `## Next` stayed.
