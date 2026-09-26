---
slug: characterworldengine
stage: 02_scaffold
status: approved
generated: 2026-09-25
sources: runs/characterworldengine/01-plan.md, runs/characterworldengine/00-intake.md, _templates/agent-skeleton/, _reference/emission-standard.md, _reference/voice.md, _source-corpus/ICM-architect/references/core.md
---

# 02-scaffold manifest, characterworldengine

This file does not ship. `03_emit` reads it, copies the tree beside it into
`builds/characterworldengine/`, and resolves every block marker listed here.

## Files

Root:
- `CLAUDE.md`
- `CONTEXT.md`
- `README.md`

Stages, 1 contract each:
- `00_setup/CONTEXT.md`
- `01_spec/CONTEXT.md`
- `02_render/CONTEXT.md`
- `03_file/CONTEXT.md`

Reference, the stable rules:
- `_reference/bible-schema.md`
- `_reference/setup-interview.md`
- `_reference/spec-rules.md`
- `_reference/drift-checklist.md`
- `_reference/host.md`
- `_reference/walk-test.md` (block only)

Templates, stamped per unit:
- `_templates/character-bible.md` (per character)
- `_templates/shot-brief.md` (per shot, by the operator)
- `_templates/sidecar.md` (per accepted shot)
- `_templates/set-manifest.md` (per set)

World, blank until setup runs:
- `world/README.md`
- `world/interview.md`
- `world/environment.md`
- `world/style.md`
- `world/characters/README.md`
- `world/references/README.md`

## Blocks

- `never-stem` in `CLAUDE.md`, under `## Never`
- `status-convention` in `CONTEXT.md`
- `edit-surface` in `CONTEXT.md`
- `naming` in `CONTEXT.md`
- `walk-test` in `_reference/walk-test.md` (4 stages)
- `icm-credit` in `README.md`

Not used: `icm-about-icm`. The subject is images, not ICM.

## Swept

None. Door A build; no file was copied from a source.

## Inherited

None. No code files, no fenced blocks carrying an em dash.

## Self-checks

check: none

The build ships no scripts of its own. The factory's voice and gate checks
cover every authored file.

## Deviations from the plan

Each is a scaffold-time correction, recorded here so the plan's reader is not
surprised. The plan is not edited after approval.

1. **Reference images live in `world/references/`, not `00_setup/references/`.**
   A stage folder holds its contract only, so a run leaves nothing in it. The
   images are evidence the bibles cite for the life of the world, which makes
   them world material.
2. **`world/environment.md` and `world/style.md` ship blank in place** instead
   of as `_templates/environment-bible.md` and `_templates/style-rules.md`.
   They exist once per world, so a template that is copied once is a file that
   ships blank. This also lets every route to them resolve in the empty engine,
   which the gate requires. `_templates/character-bible.md` stays a template
   because it is stamped once per character.
3. **`world/interview.md` ships blank** for the same reason: 3 contracts name
   it, and the gate resolves every named path.
4. **No `_reference/voice.md`.** Intake heard no rule about how the built
   agent's output sounds; its output is an image and a prompt, and the prompt's
   rules live in `_reference/spec-rules.md`. The skeleton says delete rather
   than invent.
5. **Setup's refuse rule keys on `status: approved`** in `world/environment.md`
   rather than on the file's existence, since the file now always exists.

## Budgets, measured at scaffold time

Before blocks are inserted. Block bodies measured by byte count only, not read.

| File | Chars | Tokens, approx | After blocks |
|---|---|---|---|
| `CLAUDE.md` | 1860 | 465 | + never-stem, 432 chars: ~573, 47 lines |
| `CONTEXT.md` | 1771 | 442 | + 3 blocks, 1132 chars: ~726 |
| `01_spec/CONTEXT.md` | 1934 | 483 | no block |
| `02_render/CONTEXT.md` | 1992 | 498 | no block |
| `03_file/CONTEXT.md` | 1666 | 416 | no block |
| `00_setup/CONTEXT.md` | 2404 | 601 | no block |

Limits: entry 800 tokens and 60 lines; root line 800; contracts 650.

## Checks run on this scaffold

- `_system/voice-check.sh` on the whole tree: clean.
- Routing simulation with the gate's path rule on the root files and every
  contract: nothing missing.
- Residue scan for `{{` slots: none.
