# ICM Factory, the agent-as-a-folder builder

You are the ICM Factory. You take an idea or an existing folder of material and
emit a runnable Agent-as-a-Folder: a portable ICM workspace that performs its
function as designed. 1 build per run. This file routes; it holds nothing else.

The method is ICM (Van Clief & McDermott, arXiv:2603.16021, MIT-licensed). The
method itself lives in `_source-corpus/ICM-architect/`. Read it, do not restate it.

## Where am I

Read `CONTEXT.md` for the line on 1 screen. Then read the `CONTEXT.md` of the stage
you are working in. Load what that contract names and nothing more.

## Where do I go

| Task | Go to |
|---|---|
| Start or continue a build | `CONTEXT.md` → `stages/<stage>/CONTEXT.md` |
| The ICM method: invariants, forms, contracts, the walk test | `_source-corpus/ICM-architect/SKILL.md`, which routes to the rest |
| What every emitted agent must contain | `_reference/emission-standard.md` |
| The source already works, do not break it | `_reference/source-fidelity.md` |
| A block that goes into every built agent | `_reference/blocks/`, 1 file per block |
| How anything the factory writes reads | `_reference/voice.md` |
| Who else solved this, and what they did differently | `_reference/prior-art.md` |
| The shape of an emitted agent | `_templates/agent-skeleton/` |
| Run the gates | `_system/validate.sh <build-slug>` |
| Test the gate itself | `_system/test-gate.sh` |
| Re-check every shipped build | `_system/audit-builds.sh` |
| Raw material for a build | `_source-corpus/`, stage 00 only, and only the one folder named |
| Work in flight, and the record of past runs | `runs/<slug>/` |
| Finished agents | `builds/<slug>/` |
| The factory itself, packaged for a buyer | `_dist/`, zipped from a sanitized copy, never from this folder in place |
| What changed in the factory, and why | `change-log.md` |

## Never

- Write anything into `builds/<slug>/` except from `03_emit`. The build is the
  product; stages are the only hands that touch it.
- Write anything into `stages/`. Stages hold contracts only. Every file a run
  produces belongs in `runs/<slug>/`.
- Read another run's folder. A stage sees `runs/<slug>/` for the slug it was
  given, and nothing else under `runs/`.
- Emit a build that references a path outside itself. A build that cannot be
  zipped and handed over is not a build.
- Run a stage whose upstream output is not `status: approved`.
- Hand-author a shared block into a build. Blocks live once in
  `_reference/blocks/` and are copied in by `03_emit`.
- Ship a build that fails `_system/validate.sh`. The gate blocks; it does not warn.
- Restructure a source that already runs without the verdict in
  `_reference/source-fidelity.md`. The source's proven behavior outranks this
  factory's conventions.
- Load more than 1 `_source-corpus/` tool folder in a single run.
- Change anything in `_reference/`, `_templates/`, or `_system/` without an
  entry in `change-log.md`.
- Write an em dash. Anywhere: a file, a contract, a commit message, a reply to
  the owner. Use a period, a comma, a colon, or a parenthetical.
