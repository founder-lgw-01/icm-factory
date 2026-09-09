# 02_scaffold, plan to every contract, written

1 job: write the built agent's files as a staged tree, not yet emitted.

## Inputs
- Working (this run): `../../runs/<slug>/01-plan.md` (requires `status: approved`)
- Working (this run): `../../runs/<slug>/00-intake.md`, for the operator's own words
- Reference (every run): `../../_templates/agent-skeleton/`,
  `../../_reference/emission-standard.md`, `../../_reference/voice.md`
- Reference (on demand): `../../_source-corpus/ICM-architect/references/core.md`
  for the contract format

Do NOT load: `../../_reference/blocks/` (03_emit owns them), `_source-corpus/`
(step 7 copies, never reads), any `../../builds/` folder, any other run in
`../../runs/`.

## Process
1. Refuse to run unless `01-plan.md` says `status: approved`.
2. Copy `../../_templates/agent-skeleton/` to `../../runs/<slug>/02-scaffold/`.
3. Write the root `CLAUDE.md`: identity, a routing table where every row points
   at 1 file inside the build, a `## Never`.
4. Write the root `CONTEXT.md`: the line as 1 table, the factory/product
   split, status convention, and naming rule.
5. Write 1 `CONTEXT.md` per stage from the plan's table, in the shape
   `emission-standard.md` requires.
6. Write the `_reference/` files the plan named. Leave `BLOCK: <name>` on its own
   line wherever a shared block belongs; `03_emit` fills it.
7. For every part the plan marks `additive` or `leave-alone`, copy its files
   verbatim, then run `../../_system/sweep-em-dash.sh` on the copied markdown.
8. Every path written must be relative and must resolve inside the build.
9. Write `manifest.md`: every file, every `BLOCK:` marker, every swept file,
   **Inherited** (each em dash left in code or a fenced block, `file:line`), and
   **Self-checks** (each check the source ships, to run on the files this stage
   wrote or repaired: `check: <command with {file}> :: <files>`, or `check: none`).

## Outputs
- `../../runs/<slug>/02-scaffold/`, the built agent's tree, complete except for blocks
- `../../runs/<slug>/02-scaffold/manifest.md`, frontmatter: `slug`, `stage: 02_scaffold`,
  `status: draft`, `generated`, `sources`; body: the sections step 9 names

## Human check
Read the scaffold's `CONTEXT.md` table against the plan's **Stages** table, row
by row. Open the scaffold's `CLAUDE.md` and follow 3 rows to the files they
name: each must exist and answer the row. Read 2 stage contracts and confirm
each names exact paths and 1 real human check. Decide every **Inherited** line:
a byte escape, or hold the build. Flip `status: approved`.
