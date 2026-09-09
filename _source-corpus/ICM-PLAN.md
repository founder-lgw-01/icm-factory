# BMC Marketing Engine — ICM Layout Plan

Planning document. Nothing built.

Constraint set by the owner: **nothing is shared.** Each tool is an independent,
portable folder. You can zip any one of them, hand it to someone, and it runs
with no parent, no sibling, and no missing file.

Reference for what good looks like: `c:\pelto`.

---

## 1. What Pelto actually does right

Read the whole workspace. The parts worth copying:

**The root `CLAUDE.md` routes and holds nothing.** 2.3 KB. It is a "where am I /
where do I go" table plus a `## Never` block. No content payload whatsoever.
Every row points at exactly one file.

**A one-screen `CONTEXT.md` shows the entire line as a table.** Stage, job,
input, output, human check — five columns, one row per stage. You can see the
whole system in ten seconds without opening a stage.

**Stage contracts are ~2 KB and rigidly structured.** Every one is:
`# NN_name — one-line job` → `## Inputs` (split into *Working (this run)* vs
*Reference (every run)* vs *Reference (on demand)*) → **`Do NOT load:`** →
`## Process` (numbered) → `## Outputs` (with exact frontmatter) → `## Human check`.

**The `Do NOT load:` line is the isolation mechanism.** This is the single best
idea in Pelto and it is what you are asking for. `01_extract` is explicitly
forbidden from loading `close.md` because "evidence is lens-free." The exclusion
is written *into the contract*, not left to the agent's judgment.

**Status is a `status:` line in frontmatter, flipped by a human.** A stage
refuses to run unless the upstream output says `status: approved`. The
filesystem is the state machine — no tracker, no database.

**`_prefix` means "about the workspace, not of the work."** `_shared`,
`_system`, `_templates`, `_archive`, `_holdout`. Instantly legible.

**Factory vs product is stated explicitly** in `CONTEXT.md`, one line each.

**Generated files are never hand-edited.** `status.ps1` regenerates
`clients/index.md`. The rule is in the root `## Never`.

### What does not translate

- Pelto's `_shared/` — you have ruled it out, and correctly, because Pelto is
  **one workspace for one firm**. Your tools are **many independent products
  that get distributed separately.** A shared layer would break portability the
  moment you hand someone a single tool.
- `clients/` record library — your unit is a tool, not an accumulating client.
- The `.ps1` render scripts — deck rendering is Pelto-specific.
- `_holdout/` — that is an eval concern, not a marketing one.

---

## 2. What is in `_engine` today

Eight unpacked tool packages, each 14–28 KB:

`3 Universal Laws`, `ai-receptionist-core-package`, `build-a-sales-funnel`,
`build-your-own-crm-package`, `Desk package`, `errand-boy-package`,
`icm-rebrand-package`, `Ugly Converts`.

Plus `bmc_zip/` (16 archives, containing **~10 more tools with no unpacked
folder** — `bmc-sales-00-the-hat` through `-05-objection-handlers`,
`deal-coroner`, `live-ai-sales-roleplay`, `sell-first-build-second`,
`icm-desk`, `claude-code-landing-page`), and `rymac-production-line` (an
already-built ICM in your house style).

**The real corpus is ~18 tools, not 8.**

### Every tool has identical anatomy

Verified across all eight:

```
<tool>/
  term-sheet.md      <- jargon -> plain language. Always present.
  member-builds.md   <- community trophy wall. Always present.
  <3 to 5 lesson files>
```

**All 33 lesson files end in exactly one "Run this prompt" block.** Zero
exceptions. The repeating unit is precise:

> a tool = a term sheet + a trophy wall + N lessons,
> where each lesson is *one idea + one runnable prompt.*

---

## 3. Portability: what "nothing shared" costs, honestly

Measured overlap across the eight tools: ICM appears in 6, "repo / Claude Code /
agent" in 5, voice conventions in all 8.

Under full portability that material gets **duplicated into every tool.** That
is the correct trade — you cannot hand someone a folder that reaches for a
parent — but it has one real consequence worth naming now:

**Duplication drifts.** ICM is *already* defined six different ways across six
term sheets today. With 18 tools it will be eighteen.

Two mitigations, neither of which breaks portability:

1. **A generator, not a shared runtime.** Keep one master copy of the common
   blocks (voice laws, ICM credit line, member-builds instructions) in
   `_engine/_authoring/`, and *stamp* them into each tool at build time. The
   built tool is fully self-contained; the authoring source is where you fix a
   typo once. `_authoring/` never ships inside a tool.
2. **A drift check.** One script that reports where the same block has diverged
   across built tools. Report only — never auto-edit a shipped tool.

This is the "instantiate by copying" invariant. Copies are fine; *unmanaged*
copies are not.

---

## 4. Proposed layout — one portable tool

Every tool is this, complete, standalone:

```
<tool-slug>/
  CLAUDE.md              <- routes only. ~40 lines. Points down, never out.
  CONTEXT.md             <- the line on one screen, as a table
  README.md              <- for the human who receives the zip

  _reference/            <- FACTORY. Stable across runs. This tool's own copy.
    CONTEXT.md           <- table: file | governs | loaded by
    voice.md             <- BMC voice laws (stamped copy)
    offer.md             <- buyer, awareness rung, promise, price
    term-sheet.md        <- from source, unchanged
    lessons/             <- the 3-5 lesson files, verbatim
    prompts.md           <- the "Run this prompt" blocks, extracted

  _templates/            <- instantiate by copying
    run/                 <- blank run folder

  01_position/
    CONTEXT.md
    output/
  02_hook/
    CONTEXT.md
    output/
  03_assets/
    CONTEXT.md
    output/
  04_package/
    CONTEXT.md
    output/

  runs/
    <YYYY-MM-DD-slug>/   <- PRODUCT. New every run.

  member-builds.md       <- this tool's record
  change-log.md
  _archive/
```

**Why this is portable:** no path in any contract starts with `../../`. Every
reference a stage names resolves inside the tool folder. Zip it, send it, it
runs.

**Isolation between tools is now structural, not conventional.** There is no
shared folder to accidentally read, because there is no shared folder. The root
`## Never` block still carries the Pelto-style guard:

```
## Never
- Load anything outside this folder. This tool is self-contained by design.
- Run a stage whose upstream output is not `status: approved`.
- Edit a generated file by hand.
- Change `_reference/` without an entry in `change-log.md`.
```

**Stage contracts copy Pelto's shape exactly** — including the `Do NOT load:`
line, which is where per-stage context discipline actually lives.

**Token budget:** `CLAUDE.md` (~40 lines) + one stage contract (~2 KB) + one
lesson (~4 KB) + `voice.md` ≈ **3–5k tokens per step.** Inside the healthy
2k–8k band. Loading all eight current tools at once is ~158 KB ≈ 40k tokens,
and that is before the ten zipped ones.

### And at `_engine/` level

```
_engine/
  tools/<tool-slug>/     <- the 18 portable tools
  _authoring/            <- master blocks + build script. NEVER ships.
  _source/               <- original .md packages, untouched
  bmc_zip/               <- archives
  rymac-production-line/ <- stays a separate sibling. It is a video pipeline.
  ICM-architect/         <- the method, reference copy
```

`_engine/` has no `CLAUDE.md` that tools depend on. It is a shelf, not a parent.

---

## 5. Optimizations surfaced

Ranked by payoff.

**1. Extract the zips before finalizing the template.** ~10 more tools. The
sales track (`00-the-hat` → `05-objection-handlers`) is numbered, which suggests
an ordered sequence. If those are one pipeline rather than five tools, the
template changes. Worth doing first.

**2. Extract the prompts.** Every lesson buries one runnable prompt in prose.
Pulling them into `_reference/prompts.md` — generated by script, never
hand-edited, per Pelto's rule — is the highest-leverage token win. It makes
prompts addressable without reading five lesson files.

**3. Normalize names to kebab slugs.** `Desk package` (spaces, mixed case),
`3 Universal Laws` (leading digit + spaces), `ai-receptionist-core-package/ai-receptionist-core`
(doubled folder from an unzip). Spaces cost friction in every script and path.
Pelto's rule: folders `NN_kebab-case`, files kebab-case, no spaces. Note
`3 Universal Laws` would collide with the `NN_` stage convention — rename it.

**4. Adopt Pelto's `status:` frontmatter verbatim.** `tool`, `stage`, `status`
(`draft` | `approved`), `generated`, `sources`. Gives you the filesystem-as-state-machine
for free, and a `status` script that reads it.

**5. Reuse `rymac-production-line/checks/voice-check.sh`.** It already exists
and already encodes the voice laws. Stamp it into each tool rather than writing
a second one.

**6. Decide numbered stages vs. flat — per tool.** `01_position → 04_package`
assumes marketing production is genuinely sequential. Pelto's guidance: numbering
encodes order, and renaming reorders the pipeline. If you actually jump straight
to a hook, numbering is fiction. Some tools may not need stages at all.

**7. Do not scaffold 18 identical pipelines reflexively.** The method's own
guardrail: a workspace for a thing done twice is scaffolding, not architecture.
Some tools may only ever need `_reference/` plus one output folder. Check per
tool.

**8. The ICM-about-ICM trap.** `Desk package`, `errand-boy-package`, and
`icm-rebrand-package` all *teach ICM.* An agent can conflate **the ICM it is
working inside** with **the ICM the tool is about.** One line in each of those
three tools' `CLAUDE.md` prevents it permanently.

---

## 6. Open decisions

1. **What does a run produce?** The stages above assume a run emits marketing
   collateral for that offer (hook, page, script, package). If a run instead
   delivers the lesson to a member, the stages change completely. **This gates
   everything else.**

2. **Extract the zips now?** Recommend yes — the corpus doubles.

3. **Are `bmc-sales-00..05` one ordered pipeline or five separate tools?**

4. **Rename to clean slugs?** Recommend yes. Folder names stop matching what you
   say out loud, but every script gets simpler.

5. **Generator + drift check for the duplicated blocks,** or accept manual
   duplication across 18 tools?

6. **Numbered stages or flat named folders,** and is it uniform across tools or
   per-tool?
