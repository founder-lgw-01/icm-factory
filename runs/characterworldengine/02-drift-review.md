---
slug: characterworldengine
stage: 02_scaffold
status: draft
generated: 2026-09-26
sources: builds/characterworldengine/ (4th emit), the field copy at the Hermes host, runs/characterworldengine/02-scaffold/manifest.md
---

# 02-drift-review, characterworldengine

What the copy running at the Hermes host did to the build in 1 day, which of
it comes back into the factory's build, and which of it stays there. The
scaffold revision it produced is recorded in `02-scaffold/manifest.md` under
**Revision, 2026-09-26**.

## What was compared

The shipped build, as emitted the 4th time on 2026-09-25 with the concept
field, against the field copy's 24 engine files: the root files, the 4
contracts, `_reference/`, `_templates/`, and the blank world files. The field
copy's `runs/` (11 sets, 30-odd shots, 5 models compared) and its world
content (1 character, 9 locations, 18 images) are the evidence of what the
structures were for, not the subject of the review.

21 of 24 files differ. Unchanged: `03_file/CONTEXT.md`, `_templates/sidecar.md`,
`_templates/set-manifest.md`. Filing never needed to change.

## What the field found

The record in the field copy's `world/interview.md` names the failure that
drove the changes: shots came back as an overly busy city with pagoda
architecture, because 1 reference image meant for mountain shapes leaked its
whole content, and because the environment bible was a single file every shot
imported in full. The operator's correction: make the references congruent and
narrowly scoped, and tighten the schema, the checklist, and the spec rules.
2 more findings followed in the day's runs: the tool's aspect-ratio parameter
is a label and the file must be measured, and an agent will read `ok` or a
finished migration as approval unless told in writing what approval is.

## Carried into the factory's build

| Structure | Why it improved the engine | Where it landed |
|---|---|---|
| Environment split into a router, 6 modules, and 1 file per location, with `kind`, `scope`, `depends_on`, `reference_roles` | a shot loads what it shows instead of the world; a fact has 1 home | blank files under `world/environment/`, `_templates/location.md`, `bible-schema.md` |
| 1 permission record per reference image, roles with evidence class, **Use only for**, **Do not transfer**; bibles link, never copy | the pagoda leak: an image lends 1 named trait, not itself | `_templates/reference-permissions.md`, `bible-schema.md`, `world/references/README.md` |
| World-input manifest in the spec: path, roles, SHA-256; render verifies before sending | an edit to the world cannot change an approved spec's meaning in silence | `spec-rules.md`, `01_spec`, `02_render`, `host.md` |
| Scene freezes style facts, a reference plan, a dominant family, a focal hierarchy, a topology statement | the render audits against frozen facts and does not reopen style; water connects; 1 family controls the masses | `spec-rules.md` |
| 4 environment checklist items, evidence in every finding, measured ratio, 4 risk rows, verdict semantics | `too busy` is not a finding; a near-16:9 file is not 16:9 | `drift-checklist.md` |
| Approval defined once: by file or by a named chat decision written and read back; what never counts | the host is chat; the operator rarely opens files; `ok` is not a decision | `_reference/approval.md`, 4 `## Never` lines, 2 lines after the status block |
| `00_setup` revision mode: reopen named files, ask only what the change needs, append to the interview | a change to 1 module no longer costs a new world | `00_setup/CONTEXT.md`, `setup-interview.md`, `world/interview.md` |
| Interview questions 6, 7, 10, 15, 20, 32 expanded | families, focal hierarchy, routes and water, and per-image roles are asked for, not inferred | `setup-interview.md` |
| Model row: GPT Image 2.5 Sunburst; the ratio parameter is a label | the field copy moved; the 1672 by 941 result is on record | `host.md` |
| A structural self-check | the shape of `world/` is checked by a script, and the gate runs it | `tests/test_world_structure.py`, the manifest's `check:` line |

## Left in the field copy, and why

- **Rewrites of 3 shared blocks.** The field copy edited the text of
  `status-convention`, `edit-surface`, and `walk-test` in place. Blocks live
  once in the factory and the gate fails a build whose copy differs. The
  substance of the status rewrite is in `approval.md`; the walk additions sit
  in a section after the block. Also dropped: a `## Never` line that repeats
  the block's own line about `AGENTS.md`.
- **Structural-maintenance mode.** A 1-time migration of an existing world
  into the modular layout, with its Git tag, its "35 migrated records", and
  its compatibility note for a duplicate palette image. The factory's build is
  born modular; a blank engine has nothing to migrate.
- **The contracts as written.** The field copy's `00_setup`, `01_spec`, and
  `02_render` run 1,581, 1,040, and 1,011 tokens against a 650 limit, and its
  root files 890 and 1,192 against 800, because each restates what its
  reference file already says. The rules came back; the restating did not.
  The factory's versions point.
- **World content.** The interview answers, the character, the locations, the
  images and their records. That is the field copy's world, not the engine.
- **A `.gitignore` and `__pycache__`.** The shipped check runs with `-B`.

## Factory-forward, which the field copy lacks

The field copy was taken from the 3rd emit. The 4th emit, later on 2026-09-25,
added the **Concept** field to the brief, the spec, the checklist, and
`02_render`. None of the field copy's briefs carry it. The new zip carries
both the concept field and the field's structures, so the field copy is
behind the build on that 1 point and ahead of it on nothing once this
revision ships.

## Test generalized

The field copy's `tests/test_world_structure.py` asserts its own world: a
character must exist, a named palette image must not be selected, 3 named
style roles must map to 3 named domains. The shipped version keeps the
structural checks and drops the world-specific ones, and lets a draft file
leave fields empty so the blank engine passes. 12 tests.

## What this changes for the field copy

Nothing, by itself. The field copy keeps running as it is. When the operator
wants it on the new engine, the path is the new zip from `_dist/` and a
`00_setup` revision that moves the world content across; the field copy's
own record says which of its files are approved.
