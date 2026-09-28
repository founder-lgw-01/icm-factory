# 02_scaffold, plan to every contract, written

1 job: write the built agent as a staged tree, not yet emitted.

## Inputs
- Working (this run): `../../runs/<slug>/01-plan.md` (requires `status: approved`)
- Working (this run): `../../runs/<slug>/00-intake.md`, the operator's own words
- Reference (every run): `../../_templates/agent-skeleton/`,
  `../../_reference/emission-standard.md`, `../../_reference/voice.md`,
  `../../_reference/blocks/README.md`, the block index
- Reference (on demand): `../../_source-corpus/ICM-architect/references/core.md`
  for the contract format

Do NOT load: the block bodies in `../../_reference/blocks/`, `_source-corpus/`
(step 8 copies, never reads), `../../builds/`, any other run in `../../runs/`.

## Process
1. Refuse to run unless `01-plan.md` says `status: approved`.
2. Copy `../../_templates/agent-skeleton/` to `../../runs/<slug>/02-scaffold/`.
3. Write the root `CLAUDE.md`: identity, a routing table (every row 1 file
   inside the build), a `## Never`.
4. Write the root `CONTEXT.md`: the line as 1 table, factory/product split,
   status, naming.
5. Write `README.md`: what the agent does and for whom, in the operator's
   words, and how to start it. `03_emit` keeps it as is.
6. Write 1 `CONTEXT.md` per stage from the plan's table, in the shape
   `emission-standard.md` requires. Paths relative, inside the build.
7. Write the `_reference/` files the plan named, **The owner's words** verbatim
   in a fenced block. Leave `BLOCK: <name>` on its own line where a block belongs.
8. Copy every part the plan marks `additive` or `leave-alone` verbatim, then
   run `../../_system/sweep-em-dash.sh` on the copied markdown.
9. Run `../../_system/voice-check.sh` on every file written here; fix what it names.
10. Write `manifest.md`: every file, every `BLOCK:` marker, every swept file,
    **Inherited** (each em dash left in code or a fence, `file:line`), and
    **Self-checks** (`check: <command> :: <files>`, or `check: none`).

## Outputs
- `../../runs/<slug>/02-scaffold/`, the tree, complete except for blocks
- `../../runs/<slug>/02-scaffold/manifest.md`, frontmatter: `slug`, `stage: 02_scaffold`,
  `status: draft`, `generated`, `sources`; body: the sections step 10 names

## Human check
Read the scaffold's `CONTEXT.md` table against the plan's **Stages** table, row
by row. Follow 3 rows of `CLAUDE.md` to the files they name. Where 2 contracts
rule on 1 thing (money, stopping, approval), read both rules side by side; if
they disagree, hold the build. Decide every **Inherited** line: a byte escape,
or hold. Flip `status: approved`.
