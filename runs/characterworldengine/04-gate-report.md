---
slug: characterworldengine
stage: 04_validate
status: approved
generated: 2026-09-26
sources: builds/characterworldengine/, _system/validate.sh, _reference/emission-standard.md
verdict: pass
---

# 04-gate-report, characterworldengine

This report is for the 5th emit, 2026-09-26, the scaffold revision that
brings back the structures the field copy grew. The report for the 3rd emit,
which shipped as `_dist/characterworldengine-2026-09-25.zip`, was approved
with `verdict: pass` and is replaced by this file.

## The gate

`_system/validate.sh characterworldengine`, run on the 5th emit twice. The
first run, before the operator had read the emit log, passed 12 of 13 and
failed `chain` on `03-emit-log.md` at `status: draft`. The operator approved
the emit log and the second run passed 13 of 13, exit 0.

| Check | Result |
|---|---|
| structure | pass, required files present |
| entry | pass, `AGENTS.md` is `CLAUDE.md` byte for byte |
| isolation | pass, no path leaves the build |
| budget | pass, entry, root `CONTEXT.md` and contracts within range |
| routing | pass, every named path resolves |
| contracts | pass, all complete |
| residue | pass, nothing from the factory left behind |
| empty | pass, no empty folder |
| hygiene | pass, `stages/` holds contracts only |
| chain | pass, every stage output approved |
| blocks | pass, every block matches its single home |
| voice | pass, clean |
| self-checks | pass, the build passes the 12 tests it ships |

Budgets after blocks: `CLAUDE.md` 799 tokens, 57 lines; `CONTEXT.md` 796;
contracts 650, 648, 650, 416. The 3 revised contracts sit at the limit.

## What the walk found before the gate could

The gate passed the same 12 checks on the first emit of this revision, and
the cold walk then measured the `01_spec` load at 8,737 tokens: entry, root
`CONTEXT.md`, the contract, and its every-run inputs, with blank world files.
The walk test allows 2,000 to 8,000. The cause was the contract loading all
of `_reference/drift-checklist.md`, 2,365 tokens, for 1 table inside it. The
fix was structural, in the scaffold: the risk table is now
`_reference/risk-table.md`, `01_spec` loads that file and not the checklist,
`02_render` loads the checklist and not the table, and `CLAUDE.md` routes to
each. The build was removed and emitted again. The load is 7,014 tokens.

## The cold walk

Walked as an agent with no memory, reading only what the build contains.

**Where am I, where do I go, in the entry file plus at most 2 more reads?**
Pass. `CLAUDE.md` says what the folder is in 2 lines and routes 14 tasks to
named files. `CONTEXT.md` gives the 4 stages, the send-back rule, the
factory/product split, and 2 lines after the status block that send a reader
to `_reference/approval.md` for what a decision in chat must look like. The
third read is the contract of the stage at hand. Measured loads, entry plus
root `CONTEXT.md` plus the contract plus its every-run inputs, on the blank
world:

| Stage | Tokens |
|---|---|
| `00_setup`, with the 3 templates it stamps | 7,416 |
| `01_spec` | 7,014 |
| `02_render` | 5,269 |
| `03_file` | 2,157 |

All inside 2,000 to 8,000. A filled world adds core, palette-lighting, style,
and 1 bible per named character to the `01_spec` load; the modules a shot
does not show add nothing, which is the point of the split.

**Pick any stage: does its contract name exact input paths, the job, the
output, and the human check?** Pass, on `01_spec/CONTEXT.md`, the contract
this revision changed most. Inputs are exact relative paths in 4 groups:
working, rerun, every run, on demand. The on-demand group is where the
selection lives: the other modules, the visible locations, the selected
`### <role-id>` sections. `Do NOT load` names 6 things and says that a
location's link to a neighbor is not a selection. The job is 1 sentence. The
output names 1 file and its frontmatter. The human check reads the spec
against the brief and the files its manifest names, and ends in the flip.

**Can you state the build's status purely by scanning what exists in the
product folder `CONTEXT.md` names?** Pass. `runs/<set>/<shot>/` holds files
numbered by stage, each with `status` in its frontmatter, and the render
record carries `verdict`. The highest-numbered file says where the shot is.
World status is now per file: the router, 6 modules, each location, the style
rules, each bible, each reference record, all shipping `draft` and blank, and
`_reference/approval.md` says an approved router approves none of them. A
spec's **World-input manifest** says which world files, at which bytes, it
was written against, so a later reader can tell an approved spec from a spec
whose inputs moved under it. No tracker exists.

**Is any routing file carrying content payload? Is any fact stored twice?**
Pass, with the same designed exception as before and 1 seam to name.
`CLAUDE.md` holds a routing table and a Never list. `CONTEXT.md` holds the
line table, the 3 convention blocks, and 2 pointer lines. `world/environment.md`
holds 2 tables and no trait line, and the shipped test fails it if a
`[stated` or `[inferred]` mark ever appears there. The risk table lives once
in `risk-table.md`; the checklist and `spec-rules.md` point at it. Which file
owns which fact lives once, in `bible-schema.md`; the router's **Load when**
column names the same rule in 6 short cells, which is routing, not payload.
The exception: `AGENTS.md` is `CLAUDE.md` twice, by design, held equal by the
gate. The seam: the loading rule (core and palette-lighting always, the rest
by selection) is stated in `spec-rules.md` and, in 1 line each, in the
router, `CLAUDE.md`'s Never list, and `bible-schema.md`'s table. Each of the
3 short forms points at or sits beside the long one. 1 home for the rule, 3
signposts.

## Verdict

`pass`. The build ships when the human check below is done and this file
reads `status: approved`; then `_system/ship.sh characterworldengine`
re-gates and cuts the zip.

## For the human check

Do the cold walk yourself on 1 stage. `00_setup/CONTEXT.md` is the one this
report did not walk in full: open it, follow its 3 template paths and its 3
reference paths to the files they name, and read step 4 against
`_reference/bible-schema.md`'s table of homes to confirm every file it says
to fill exists blank in `world/`.
