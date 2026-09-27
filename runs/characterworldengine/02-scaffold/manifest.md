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
- `_reference/risk-table.md`, read by `01_spec`; the checklist is read after
  the render
- `_reference/approval.md`
- `_reference/host.md`
- `_reference/walk-test.md` (block, then this folder's own walk questions)

Templates, stamped per unit:
- `_templates/character-bible.md` (per character)
- `_templates/location.md` (per location)
- `_templates/reference-permissions.md` (per reference image)
- `_templates/shot-brief.md` (per shot, by the operator)
- `_templates/sidecar.md` (per accepted shot)
- `_templates/set-manifest.md` (per set)

World, blank until setup runs:
- `world/README.md`
- `world/interview.md`
- `world/environment.md`, the router
- `world/environment/core.md`
- `world/environment/palette-lighting.md`
- `world/environment/architecture.md`
- `world/environment/materials.md`
- `world/environment/terrain-vegetation.md`
- `world/environment/topology.md`
- `world/environment/locations/README.md`
- `world/style.md`
- `world/characters/README.md`
- `world/references/README.md`

Checks the build ships:
- `tests/test_world_structure.py`

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

None. No em dash in the 1 code file or in any fenced block.

## Self-checks

check: python -B -m unittest discover -s tests :: tests/test_world_structure.py

The build ships 1 check, standard library only, run from the build root. It
reads the shape of `world/`: every home exists, every routing record carries
its fields, every `depends_on` and `reference_roles` link resolves, no location
depends on a location, permission tables live only under `world/references/`,
and `AGENTS.md` matches `CLAUDE.md`. A blank world passes; an approved file
with an empty field or an unmarked trait line fails. `-B` keeps `__pycache__`
out of the build. A pass is structure, never approval.

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
   Since the 2026-09-26 revision it keys on `world/environment/core.md`, the
   file every shot loads; the router is a routing file.

## Budgets, measured on a trial emit, blocks resolved

| File | Tokens, approx | Limit |
|---|---|---|
| `CLAUDE.md` | 799, 57 lines | 800, 60 lines |
| `CONTEXT.md` | 796 | 800 |
| `00_setup/CONTEXT.md` | 650 | 650 |
| `01_spec/CONTEXT.md` | 648 | 650 |
| `02_render/CONTEXT.md` | 650 | 650 |
| `03_file/CONTEXT.md` | 416 | 650 |

The 3 revised contracts sit at the limit because each first draft restated
what its reference file already says and was cut back to pointers, as the
gate's header prescribes. Before the revision: 573, 726, 601, 483, 498, 416.

## Revision, 2026-09-25, the concept field

Operator's call after the first ship: shots demonstrate ideas (features of
the host agent, 1 theme per set), and the brief needed a place for the idea
that the spec and the render check would carry. 4 files changed:

- `_templates/shot-brief.md`: new field, **Concept this shot demonstrates**,
  the idea and the thing in frame a viewer can point at.
- `_reference/spec-rules.md`: the spec's **Brief** section gets a **Concept**
  line, idea plus carrier; a label's words are quoted there and nowhere else;
  no carrier stops the stage, an invented carrier is not used.
- `_reference/drift-checklist.md`: item 15, **Concept**, checked after the
  environment; a fail is a `drifted` verdict and the shot goes back.
- `02_render/CONTEXT.md` step 4 walks the concept line last.

The empty `00_setup/references/` folder found by the first cold walk was
removed from this scaffold in the same day; the gate now blocks an empty
folder.

## Revision, 2026-09-26, the structures the field copy grew

Operator's call: the copy of this build running at the Hermes host had been
adapted through 1 day of real shots and a structural migration, and the
structures that improved it come back into the factory's build. The review
that decided what came back and what stayed is
`runs/characterworldengine/02-drift-review.md`. What changed in this scaffold:

- **The environment is modular.** `world/environment.md` is a router. The
  facts live in 6 modules under `world/environment/`, core and
  palette-lighting loaded by every shot and the other 4 by selection, and in
  1 file per location under `world/environment/locations/`, stamped from the
  new `_templates/location.md`. Every world file carries `kind`, `scope`,
  `depends_on`, `reference_roles`. `bible-schema.md` gains the table of which
  file owns which fact, the field lists per module, and the approval gates.
- **Each reference image has a permission record**, `world/references/<image-stem>.md`,
  stamped from the new `_templates/reference-permissions.md`: 1 `### <role-id>`
  per use with evidence class, **Use only for**, **Do not transfer**. Bibles,
  modules, and locations link to roles and copy no table. `spec-rules.md`
  says a shot selects roles and reads only their sections.
- **A spec carries a world-input manifest**: every world file it read, its
  selected roles, and the SHA-256 of the file's bytes, under **Brief**.
  `02_render` verifies every row before it sends anything and refuses a
  changed hash; the fix is a new spec. `host.md` gains the manifest check and
  the measured ratio in the record's metadata.
- **The spec's Scene freezes style facts, a reference plan, a dominant
  architectural family, a focal hierarchy, and a topology statement.** Guards
  are concise positive facts. The drift checklist gains 4 environment items
  (reference coherence, architectural family, focal hierarchy and density,
  spatial topology), the rule that a finding names its evidence in the pixels,
  the measured aspect ratio, 4 risk-table rows, and the verdict's semantics.
  The **Concept** item stays and is now item 19.
- **Approval is defined once**, in the new `_reference/approval.md`: by file
  or by a named decision in chat that the agent writes and reads back; `ok`,
  `saved`, a passing test, and a finished run are never approval; a parent's
  approval covers none of its children; reopening is not approval. The
  `status-convention` block is unchanged; root `CONTEXT.md` points at the file
  in 2 lines after it. `CLAUDE.md` gains 4 `## Never` lines.
- **`00_setup` has 3 modes**: world, character, revision. Revision reopens
  only the files the operator names, asks only what the change leaves
  unresolved, and appends to `world/interview.md` under **Revisions**.
  `setup-interview.md` expands questions 6, 7, 10, 15, 20, and 32.
- **`host.md` names GPT Image 2.5 Sunburst**, the model the field copy moved
  to, and records that the tool's ratio parameter is an orientation label.
- **The build ships a self-check**, `tests/test_world_structure.py`, generalized
  from the field copy's test so a blank world passes; the manifest's `check:`
  line runs it at the gate.
- **`_reference/walk-test.md`** keeps the block verbatim and adds a section of
  this folder's own walk questions below it.
- **The risk table is its own file**, `_reference/risk-table.md`. The cold
  walk on the first emit of this revision measured entry plus `01_spec` plus
  its every-run inputs at 8,737 tokens, over the walk test's 8,000, because
  the contract loaded the whole checklist for 1 table. `01_spec` now loads the
  table; `02_render` loads the checklist; neither loads the other's file.

Not carried, and why, in the drift review: the field copy's rewrites of 3
shared blocks, its 1-time migration mode and Git-tag references, its world
content, and its contracts as written, which run 1,011 to 1,581 tokens
against a 650 limit.

## Checks run on this scaffold

- Trial emit to a scratch folder, then the gate's own arithmetic and scans on
  the result: budgets in range, every route resolves, isolation clean, no
  residue, no empty folder, all 6 blocks verbatim, voice clean on the whole
  tree and on every authored file with digits enforced, the shipped test
  passes 12 of 12, `AGENTS.md` matches `CLAUDE.md`.
- `_system/voice-check.sh` on the whole tree: clean.
- Residue scan for `{{` slots: none.
