# 03_emit, scaffold plus blocks to a portable agent

1 job: resolve every `BLOCK:` marker from the single-home block library and
write the finished, self-contained agent folder into `builds/<slug>/`. No other
stage writes there.

## Inputs
- Working (this run): `../../runs/<slug>/02-scaffold/`
  (requires `manifest.md` `status: approved`)
- Reference (every run): `../../_reference/blocks/`, the single home for every
  shared block; `../../_reference/emission-standard.md`

Do NOT load: `../../runs/<slug>/00-intake.md`, `../../runs/<slug>/01-plan.md`
(the scaffold is the contract now), any other `../../runs/<other-slug>/`,
`_source-corpus/`, any other `builds/<other-slug>/` folder,
`builds/<slug>/runs/` (the agent's work: moved, never read).

## Process
1. Refuse to run unless `manifest.md` says `status: approved`.
2. If `builds/<slug>/` exists: move its `runs/` to `../../runs/<slug>/kept-runs/`,
   delete `../../runs/<slug>/04-gate-report.md`, then remove the build. Never
   emit over a build: hand-edits survive that way.
3. Copy the scaffold tree to `builds/<slug>/`.
4. For every `BLOCK: <name>` marker in the manifest, replace the marker line with
   the verbatim contents of `_reference/blocks/<name>.md`, minus that file's own
   frontmatter. Copy it; never retype or improve it. `README.md` is stage 2's:
   resolve its block and change nothing else.
5. Strip every factory artifact: scaffold `status:` lines, `BLOCK:` markers,
   `manifest.md`, `SKELETON.md`, any name for the factory.
6. Sweep every file for a path that leaves the build or a name for the factory:
   stop and report; `02_scaffold` is re-run.
7. Copy `builds/<slug>/CLAUDE.md` to `builds/<slug>/AGENTS.md`, byte for byte.
8. Move every unit in `kept-runs/` back into `builds/<slug>/runs/`, last, and
   remove `kept-runs/`.
9. From `02-scaffold/`, write `sha256sum` of every file into the emit log under
   `## Scaffold print`.

## Outputs
- `builds/<slug>/`, the complete, portable agent, carrying only the frontmatter
  its own contracts specify.
- `../../runs/<slug>/03-emit-log.md`, frontmatter: `slug`, `stage: 03_emit`,
  `status: draft`, `generated`, `sources`; body: every file written; 1 line per
  block resolved, `block: <name> -> <file inside the build>`; anything stripped;
  the count of runs kept; **Scaffold print**, last.

## Human check
Read `builds/<slug>/README.md` and `CLAUDE.md` as a recipient who has never seen
this factory. Nothing may assume context you have and they do not. Confirm every
block landed as text, not as a marker. Flip `status: approved`, then run
`04_validate`.
