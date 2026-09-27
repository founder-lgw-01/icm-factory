---
slug: characterworldengine
stage: 03_emit
status: approved
generated: 2026-09-26
sources: runs/characterworldengine/02-scaffold/, _reference/blocks/, _reference/emission-standard.md
---

# 03-emit-log, characterworldengine

Emitted 3 times on 2026-09-25. The first emit had no `AGENTS.md`. The operator
confirmed from Hermes's own code that it loads `AGENTS.md` as literal text,
first match wins over `CLAUDE.md`, and follows no pointer. The factory changed
(see `change-log.md`, 2026-09-25), the first build was removed before it was
gated or approved, and the second emit came from the same approved scaffold.
The third emit followed the cold walk in `04_validate`, which found an empty
`00_setup/references/` folder the scaffold had left behind; the folder was
removed from the scaffold, the gate gained a check for it, and the build was
emitted again. The file list was the same for all 3.

Emitted a 4th time later the same day, after the scaffold's revision for the
concept field (see the manifest's **Revision, 2026-09-25**). The shipped build
was removed first. The file list was unchanged; 4 files differed in content:
`_templates/shot-brief.md`, `_reference/spec-rules.md`,
`_reference/drift-checklist.md`, `02_render/CONTEXT.md`.

Emitted a 5th time on 2026-09-26, after the scaffold's revision that brings
back the structures the field copy grew (see the manifest's **Revision,
2026-09-26** and `02-drift-review.md`). The 4th emit, never gated, was removed
first. The file list below is the new one: 36 files, 12 of them new (the 6
environment modules, the locations README, 2 templates, `_reference/approval.md`,
`_reference/risk-table.md`, the test), 21 changed in content, 3 unchanged
(`03_file/CONTEXT.md`, `_templates/sidecar.md`, `_templates/set-manifest.md`).
The emit was done twice on 2026-09-26: the first cold walk measured the
`01_spec` load over the walk test's range, the risk table was split out of
the checklist in the scaffold, and the build was removed and emitted again.

The scaffold was copied to `builds/characterworldengine/` and every block
marker was replaced by a script that reads the block file, drops its
frontmatter, and writes the body verbatim. No block text was retyped. Last,
`CLAUDE.md` was copied to `AGENTS.md` byte for byte.

## Files written

- `CLAUDE.md`
- `AGENTS.md`, a byte-for-byte copy of `CLAUDE.md`
- `CONTEXT.md`
- `README.md`
- `00_setup/CONTEXT.md`
- `01_spec/CONTEXT.md`
- `02_render/CONTEXT.md`
- `03_file/CONTEXT.md`
- `_reference/approval.md`
- `_reference/bible-schema.md`
- `_reference/setup-interview.md`
- `_reference/spec-rules.md`
- `_reference/drift-checklist.md`
- `_reference/risk-table.md`
- `_reference/host.md`
- `_reference/walk-test.md`
- `_templates/character-bible.md`
- `_templates/location.md`
- `_templates/reference-permissions.md`
- `_templates/shot-brief.md`
- `_templates/sidecar.md`
- `_templates/set-manifest.md`
- `tests/test_world_structure.py`
- `world/README.md`
- `world/interview.md`
- `world/environment.md`
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

## Blocks resolved

block: never-stem -> CLAUDE.md
block: status-convention -> CONTEXT.md
block: edit-surface -> CONTEXT.md
block: naming -> CONTEXT.md
block: walk-test -> _reference/walk-test.md
block: icm-credit -> README.md

`AGENTS.md` carries the `never-stem` text too, as a copy of `CLAUDE.md`. It is
not logged as a second block home: the gate's `entry` check holds it to
`CLAUDE.md`, and `CLAUDE.md` is held to the block. `_reference/walk-test.md`
carries the block first and this folder's own walk questions after it; the
block's text is untouched.

## Stripped

- `manifest.md`, the scaffold's record; it does not ship.

Nothing else was stripped: the scaffold carried no factory frontmatter, no
skeleton file, and no name for the factory.

## Sweep

After resolution, the build was scanned for a leftover `BLOCK:` marker, an
unfilled `{{slot}}`, a name for the factory in any spelling, and factory stage
frontmatter. All 4 scans returned nothing.
