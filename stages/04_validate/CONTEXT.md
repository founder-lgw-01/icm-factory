# 04_validate, gate the build

1 job: run the mechanical checks, then walk the build cold. A build that fails
either does not ship.

The gate blocks. There is no ship-anyway flag. A failure is fixed in the factory
and the build is re-run, never patched inside `builds/<slug>/`.

## Inputs
- Working (this run): `../../builds/<slug>/`
  (requires `../../runs/<slug>/03-emit-log.md` `status: approved`)
- Reference (every run): `../../_reference/emission-standard.md`,
  `../../_reference/voice.md`
- Reference (on demand): `../../_source-corpus/ICM-architect/SKILL.md` for the
  walk test, when a judgment call is contested

Do NOT load: this run's own `00-intake.md` and `01-plan.md` (the build must stand
on its own; reading the brief tells you what it was *meant* to say and defeats the
cold walk), `../../_reference/blocks/`, any other run in `../../runs/`, any other
build.

## Process
1. Refuse to run unless `03-emit-log.md` says `status: approved`.
2. Run `../../_system/validate.sh <slug>`. Any failure blocks. Every check is a
   labelled section of the script and the script header is the list; what each
   enforces is stated there and in `emission-standard.md`.
3. If any check fails: write the report, name the stage that must be re-run, and
   stop. Do not emit, do not patch, do not proceed.
4. If all pass, walk it cold as an agent with no memory:
   - Open the root. Can you answer *where am I* and *where do I go* in the entry
     file plus at most 2 more reads?
   - Pick any stage. Does its contract name exact input paths, the job, the
     output, and the human check?
   - Can you state the build's status purely by scanning what exists in the
     product folder its `CONTEXT.md` names?
   - Is any routing file carrying content payload? Is any fact stored twice?
5. Record the walk verdict per question, not as a summary.

## Outputs
- `../../runs/<slug>/04-gate-report.md`, frontmatter: `slug`, `stage: 04_validate`,
  `status: draft`, `generated`, `sources`, `verdict` (`pass` | `blocked`).
  Body: each check with pass/fail and the failing line; the cold walk, 1 verdict
  per question; if blocked, the stage to re-run and what to change.

## Human check
If blocked, read the failing lines and confirm the named fix is a factory fix, not
a build patch. If passing, do the cold walk yourself on 1 stage you did not
write: you are checking the walk, not the script. Then flip `status: approved`.
The build ships when this line reads approved and not before.
