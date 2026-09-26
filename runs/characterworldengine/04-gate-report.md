---
slug: characterworldengine
stage: 04_validate
status: approved
generated: 2026-09-25
sources: builds/characterworldengine/, _system/validate.sh, _reference/emission-standard.md
verdict: pass
---

# 04-gate-report, characterworldengine

## The gate

`_system/validate.sh characterworldengine`, run on the third emit. 13 checks,
13 pass, exit 0.

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
| self-checks | pass, the build ships no checks (`check: none`) |

Budgets after blocks: `CLAUDE.md` ~568 tokens, 45 lines; `CONTEXT.md` ~711;
contracts 601, 483, 498, 416.

## What the walk found before the gate could

The gate passed 12 of 12 on the second emit, and the cold walk then found an
empty `00_setup/references/` folder, left from the scaffold's first layout
before the reference images moved to `world/references/`. A zip drops an empty
folder, so the build gated was not the build a recipient would unpack, and a
stage folder holds its contract only. The fix was made in the factory, not the
build: the folder was removed from the scaffold, the gate gained the `empty`
check with a probe in `test-gate.sh` (56 probes, all landing), and the build
was emitted a third time. `change-log.md` has the entry.

## The cold walk

Walked as an agent with no memory, reading only what the build contains.

**Where am I, where do I go, in the entry file plus at most 2 more reads?**
Pass. `CLAUDE.md` says what the folder is in 3 lines and routes 11 tasks to
named files. `CONTEXT.md` gives the 4 stages, the send-back rule, and the
factory/product split. The third read is the contract of the stage at hand.
Entry plus `CONTEXT.md` plus `02_render/CONTEXT.md` plus its 3 reference
inputs measures ~3,600 tokens; the same walk into `01_spec` with 1 blank bible
measures ~4,600. Both inside the 2,000 to 8,000 range.

**Pick any stage: does its contract name exact input paths, the job, the
output, and the human check?** Pass, on `02_render/CONTEXT.md`. Inputs are
exact relative paths with the approval requirement stated. The job is 1
sentence. The output names 2 files and the frontmatter each carries, including
the `verdict` field. The human check is a sequence of actions (put the image
beside the bibles, walk the checklist, write the verdict) ending in the flip or
the send-back. `Do NOT load` names 5 things and gives the reason for the 2
that a reader would otherwise reach for.

**Can you state the build's status purely by scanning what exists in the
product folder `CONTEXT.md` names?** Pass. `runs/<set>/<shot>/` holds files
numbered by stage, each with `status` in its frontmatter, and the render record
carries `verdict`. The highest-numbered file says where the shot is; its
`verdict: drifted` says it went back. World status is the `status` line of
each file in `world/`, which ship `draft` and blank. No tracker exists.

**Is any routing file carrying content payload? Is any fact stored twice?**
Pass, with 1 designed exception. `CLAUDE.md` holds a routing table and a Never
list and nothing else. `CONTEXT.md` holds the line table and the 3 convention
blocks, which are the conventions themselves, not payload. The risk table lives
once in `_reference/drift-checklist.md`; `spec-rules.md` points at it. The
bible fields live once in `_reference/bible-schema.md`; the blank bibles carry
the field names and point at the schema for meaning. The exception: `AGENTS.md`
is `CLAUDE.md` twice, by design for hosts that read `AGENTS.md` as literal
text, and the gate's `entry` check holds the 2 equal.

## Verdict

`pass`. The build ships when the human check below is done and this file reads
`status: approved`.

## For the human check

Do the cold walk yourself on 1 stage. `03_file/CONTEXT.md` is the shortest and
the one this report did not walk: open it, follow its 2 template paths to the
files they name, and read its human check as something you would do on a
Monday.
