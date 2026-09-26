# 03_emit, scaffold plus blocks to a portable agent

1 job: resolve every `BLOCK:` marker from the single-home block library and
write the finished, self-contained agent folder into `builds/<slug>/`.

This is the only stage permitted to write into `builds/`.

## Inputs
- Working (this run): `../../runs/<slug>/02-scaffold/`
  (requires `manifest.md` `status: approved`)
- Reference (every run): `../../_reference/blocks/`, the single home for every
  shared block; `../../_reference/emission-standard.md`

Do NOT load: `../../runs/<slug>/00-intake.md`, `../../runs/<slug>/01-plan.md`
(the scaffold is the contract now), any other `../../runs/<other-slug>/`,
`_source-corpus/`, any other `builds/<other-slug>/` folder.

## Process
1. Refuse to run unless `manifest.md` says `status: approved`.
2. Refuse to run if `builds/<slug>/` exists and is non-empty; emitting over a
   build is how a hand-edit survives. Remove it first, deliberately.
3. Copy the scaffold tree to `builds/<slug>/`.
4. For every `BLOCK: <name>` marker in the manifest, replace the marker line with
   the verbatim contents of `_reference/blocks/<name>.md`, minus that file's own
   frontmatter. Copy it; never retype or improve it. A block changes in
   `_reference/blocks/` only, and every build is re-run.
5. Strip every factory artifact from the build: no `status:` lines left from the
   scaffold's own frontmatter, no `BLOCK:` markers, no `manifest.md` or
   `SKELETON.md`, no reference to the factory in any file.
6. Sweep every file for a path that leaves the build or a name for the factory:
   stop and report. It is a scaffold defect; `02_scaffold` is re-run.
7. Write `builds/<slug>/README.md` from the skeleton: what this agent does, how to
   start a run, and the ICM credit block. This is what a recipient reads first.
8. Copy `builds/<slug>/CLAUDE.md` to `builds/<slug>/AGENTS.md`, byte for byte,
   last. `emission-standard.md` says why.

## Outputs
- `builds/<slug>/`, the complete, portable agent, carrying only the frontmatter
  its own contracts specify.
- `../../runs/<slug>/03-emit-log.md`, frontmatter: `slug`, `stage: 03_emit`,
  `status: draft`, `generated`, `sources`; body: every file written; 1 line per
  block resolved, `block: <name> -> <file inside the build>`; anything stripped.

## Human check
Read `builds/<slug>/README.md` and `CLAUDE.md` as a recipient who has never seen
this factory. Nothing may assume context you have and they do not. Confirm every
block landed as text, not as a marker. Flip `status: approved`, then run
`04_validate`.
