# ICM Factory, the line

The flow in 1 line: an idea or a folder comes in → normalized to 1 intake →
a form and a stage plan → a scaffold with every contract written → emitted as a
portable agent folder → gated, then read by a human before it ships.

| Stage | Job | Input | Output | Human check |
|---|---|---|---|---|
| `00_intake` | idea or folder → 1 normalized brief | an interview, or 1 `_source-corpus/<tool>/` | `runs/<slug>/00-intake.md` | the repeating unit, the stages, and what ships are all stated and correct |
| `01_form` | brief → form + stage plan, without breaking the source | 00's output, approved | `runs/<slug>/01-plan.md` | the fidelity verdict, then every stage boundary is a real stop |
| `02_scaffold` | plan → every contract, written | 01's output, approved | `runs/<slug>/02-scaffold/` | each contract names exact paths and 1 human check |
| `03_emit` | scaffold + blocks → portable agent | 02's output, approved; `_reference/blocks/` | `builds/<slug>/` | the folder is complete and contains no path pointing out of itself |
| `04_validate` | gate the build | `builds/<slug>/` | `runs/<slug>/04-gate-report.md` | every check passes, then walk it cold |

Each stage's contract is `stages/<stage>/CONTEXT.md`: what it reads, what it
must not load, what it does, what it writes, what a person checks.

## The product is the build

`builds/<slug>/` is a complete ICM workspace that runs with no parent and no
sibling, and nothing in it may point at this factory. The contract it must meet
is `_reference/emission-standard.md`.

Factory (stable, every run): `stages/`, `_reference/`, `_templates/`, `_system/`, `_source-corpus/`
Product (new each run): `runs/<slug>/` while in flight; `builds/<slug>/` once emitted

## How drift is prevented

Shared text lives once in `_reference/blocks/` and `03_emit` copies it in. The
gate, `_system/validate.sh`, blocks and has no ship-anyway flag. After any change
to a block or a rule, `_system/audit-builds.sh` re-gates every shipped build and
names the ones that trail. The reasons live in `README.md`.

## 1 run, 1 folder

Everything a run produces lands in `runs/<slug>/`, numbered by the stage that
wrote it. `stages/` holds contracts only and is never written to, so a run leaves
nothing behind and cannot reach another run. Runs are kept after a build ships:
they are the record of what was asked, what was decided, and what the gate said.

## Status is whatever exists

A stage is complete when its file in `runs/<slug>/` carries `status: approved`. A
stage refuses to run until the one before it is approved. Status lives nowhere
else; there is no tracker.

## Frontmatter

Every stage output begins with `slug`, `stage`, `status` (`draft` | `approved`,
the operator flips it), `generated`, `sources`.

## Naming

Folders `NN_kebab-case` where order matters; `_prefix` means *about the workspace,
not of the work*. Files kebab-case. Build slugs lowercase words joined with
hyphens, nothing else. The slug is the folder name in `builds/` and appears in
every output. `<slug>` in any path is the build being run.
