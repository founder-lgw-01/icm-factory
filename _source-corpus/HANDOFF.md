# Handoff — ICM Factory / Agents-as-Folders

Written 2026-09-07. Read this first in the new session.

**Why this file exists:** the folder `c:\aaf-video pipeline` was originally
scoped for one thing — the 9-stage video production pipeline. Over one planning
session the conversation drifted into designing a general-purpose ICM converter.
The idea is good and is captured below, but it does not belong in a folder named
for the video pipeline. The owner is closing out, renaming the folder to
**ICM-Factory**, and restarting clean.

**Nothing was built.** Planning only. Two documents exist: this file and
`ICM-PLAN.md` (superseded in parts — see §6).

---

## 1. Where the owner landed

Three decisions were confirmed before the stop:

- **Nothing is shared between tools.** Each built agent is an independent,
  portable folder. Zip it, hand it over, it runs with no parent and no sibling.
- **`c:\pelto` is the reference for what good looks like.** Not everything
  translates, but its conventions are the house style.
- **The real product is a converter, not 18 hand-built folders.** This was the
  last and most important turn. See §4.

The commercial frame: the owner's new offering is **agentsasfolders** — take an
idea, run it through an ICM folder builder, produce a runnable agent.

---

## 2. What is actually on disk

```
c:\aaf-video pipeline\_engine\
  3 Universal Laws/              8 unpacked BMC tool packages,
  ai-receptionist-core-package/  14-28 KB each
  build-a-sales-funnel/
  build-your-own-crm-package/
  Desk package/
  errand-boy-package/
  icm-rebrand-package/
  Ugly Converts/

  bmc_zip/                 16 archives. Contains ~10 MORE tools with no
                           unpacked folder.
  rymac-production-line/   an already-built ICM. House style. Has a
                           reusable checks/voice-check.sh
  ICM-architect/           the ICM method, cloned from
                           github.com/RinDig/icm-architect
  ICM-PLAN.md              prior planning doc, partly superseded
  HANDOFF.md               this file
```

**The corpus is ~18 tools, not 8.** Unextracted in `bmc_zip/`:
`bmc-sales-00-the-hat`, `-02-earn-the-commitment`, `-03-present-test-close`,
`-04-lead-machine`, `-05-objection-handlers`, `deal-coroner`,
`live-ai-sales-roleplay`, `sell-first-build-second`, `icm-desk`,
`claude-code-landing-page`, `3-laws-every-business-breaks`.

Note: the `bmc-sales-00..05` set is numbered, which suggests an ordered
sequence rather than five independent tools. Unresolved.

---

## 3. Verified findings about the BMC tools

Measured, not assumed:

**Identical anatomy across all 8 unpacked tools:**
```
<tool>/
  term-sheet.md      jargon -> plain language. Always present.
  member-builds.md   community trophy wall. Always present.
  <3 to 5 lesson files>
```

**All 33 lesson files end in exactly one "Run this prompt" block.** Zero
exceptions. The repeating unit is:
> a tool = a term sheet + a trophy wall + N lessons,
> where each lesson is *one idea + one runnable prompt.*

**Concept overlap across tools** (this is why "nothing shared" has a cost):
ICM appears in 6 of 8, "repo / Claude Code / agent" in 5 of 8, voice
conventions in all 8. ICM is *already* defined six different ways in six term
sheets. Duplication drifts — and it has already started.

**Naming problems to fix:** `Desk package` (spaces, mixed case),
`3 Universal Laws` (leading digit + spaces — collides with ICM's `NN_` stage
convention), `ai-receptionist-core-package/ai-receptionist-core` (doubled
folder from an unzip).

---

## 4. The converter idea — the owner's, and the one to build

The owner's turn, in their words: *"should we build an ICM converter staged
operator folder? ... each output goes to a unique production folder for each
Agent as a Folder ... I take your idea and run it through my ICM folder builder
and produce a runnable agent."*

**This inverts the earlier plan and is better.** Instead of 18 hand-built tool
folders, there is **one ICM — the converter — whose product is a runnable
Agent-as-a-Folder.** The 18 BMC tools stop being the architecture and become
*input*. They are the converter's first 18 runs and its proof.

Why it is the right shape:

1. **Drift dissolves.** The earlier plan needed an `_authoring/` folder, a stamp
   script, and a drift-report script to keep 18 duplicated copies honest. In the
   converter model, the converter's `_reference/` *is* the single home. A fix
   propagates by re-running a build. Nothing hand-maintained, nothing to drift.
2. **"Nothing shared" becomes free.** The emitted agent is 100% self-contained
   with zero parent references, *and* the common blocks are authored in exactly
   one place. Both, not either.
3. **The ICM rules become executable instead of aspirational.** Walk test, token
   budget, `Do NOT load:` lines, factory/product split — as converter stages
   these are gates with human review. A build that fails does not ship.
4. **It makes the offering real.** `agentsasfolders` cannot credibly be
   "I hand-craft each one." The converter *is* the product story.

### Converter decisions already made

Answered by the owner before the stop:

| Question | Decision |
|---|---|
| Stage 00 input | **Both — two entry doors.** Accepts either a raw idea (interview / questionnaire) or an existing folder of .md files (ingest). Both normalize into the same `intake.md` the next stage reads. |
| What ships | **A runnable ICM agent folder.** Complete and portable: `CLAUDE.md`, `CONTEXT.md`, stage contracts, `_reference/`, templates. Ready to zip. Not the marketing package — just the agent. |
| Validation gate | **Both — script then human read.** Scripts in `_system/` catch mechanical failures (files exist, no `../..` paths, token counts). A validate stage catches judgment failures (is the routing actually legible?). Owner approves. Matches Pelto's diff-then-check pattern. |
| Location | **UNRESOLVED — this is what triggered the stop.** Folder is being renamed to `ICM-Factory`. Decide fresh. |

---

## 5. Pelto conventions to copy (`c:\pelto`)

Read it directly in the new session — it is the reference. The parts that matter:

- **Root `CLAUDE.md` routes and holds nothing.** 2.3 KB. A "where am I / where
  do I go" table plus a `## Never` block. Every row points at exactly one file.
- **`CONTEXT.md` shows the whole line as one table:** stage | job | input |
  output | human check. Entire system legible in ten seconds.
- **Stage contracts are ~2 KB, rigidly structured:**
  `# NN_name — one-line job` → `## Inputs` (split *Working (this run)* /
  *Reference (every run)* / *Reference (on demand)*) → **`Do NOT load:`** →
  `## Process` (numbered) → `## Outputs` (exact frontmatter) → `## Human check`.
- **The `Do NOT load:` line is the isolation mechanism.** Best idea in Pelto.
  Pelto's `01_extract` is forbidden from loading `close.md` because "evidence is
  lens-free." The exclusion is written into the contract, not left to judgment.
- **Status is frontmatter a human flips:** `status: draft | approved`. A stage
  refuses to run unless upstream is approved. The filesystem is the state
  machine — no tracker.
- **`_prefix` means "about the workspace, not of the work":** `_shared`,
  `_system`, `_templates`, `_archive`, `_holdout`.
- **Factory vs product stated explicitly** in `CONTEXT.md`, one line each.
- **Generated files are never hand-edited** — a script regenerates them. The
  rule lives in the root `## Never`.
- **Naming:** folders `NN_kebab-case` where order matters; files kebab-case;
  slugs lowercase, no spaces, no punctuation.

**What does NOT translate:** Pelto's `_shared/` (it is one workspace for one
firm; your agents ship separately, so a shared layer breaks portability),
`clients/` record library, the `.ps1` deck renderers, `_holdout/`.

---

## 6. What in ICM-PLAN.md is superseded

`ICM-PLAN.md` is still worth reading for §1 (Pelto analysis), §2 (what is on
disk), and §3 (the anatomy findings). **Superseded:** its §4 proposed 18
hand-built tool folders plus an `_authoring/` + stamp-script + drift-check
apparatus. The converter replaces all of that. Do not build `_authoring/`.

---

## 7. Open items for the new session

1. **The 9-stage video pipeline is the owner's actual first build** — it was the
   original purpose of this folder and has not been designed yet. Confirm
   whether it is built *by* the converter as its first run, or by hand first and
   the converter second. This is the main sequencing question.
2. **Where the converter lives** now that the folder is `ICM-Factory`.
3. **What a converter run produces for the BMC tools specifically** — the
   earlier gating question ("marketing collateral for the offer" vs "deliver the
   lesson to a member") was never answered and still matters when the tools
   become converter input.
4. **Extract `bmc_zip/`** before finalizing any template — the corpus doubles.
5. **Are `bmc-sales-00..05` one ordered pipeline or five separate tools?**
6. **Normalize folder names to kebab slugs.**
7. **Reuse `rymac-production-line/checks/voice-check.sh`** rather than writing a
   second voice checker.
8. **The ICM-about-ICM trap:** `Desk package`, `errand-boy-package`, and
   `icm-rebrand-package` all *teach* ICM. An agent can conflate the ICM it is
   working inside with the ICM the tool is about. One line in each of those
   three agents' `CLAUDE.md` prevents it permanently.

---

## 8. Credit

The methodology is **Interpretable Context Methodology (ICM)**, created by Jake
Van Clief and David McDermott. arXiv:2603.16021, MIT-licensed.
