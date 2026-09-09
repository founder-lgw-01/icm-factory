# Agent skeleton, how to use this template

`02_scaffold` copies this folder to `runs/<slug>/02-scaffold/` and fills it in.
This file does not ship: `03_emit` strips it.

## What is here

| File | Becomes |
|---|---|
| `CLAUDE.md` | the built agent's entry file, under 60 lines |
| `CONTEXT.md` | the built agent's line, one table |
| `README.md` | what a recipient reads first |
| `NN_stage/CONTEXT.md` | copy once per stage, rename `NN_stage` to the real name |
| `_reference/voice.md` | the agent's own voice rules, or delete if intake heard none |

The built agent writes every run's output into `runs/<unit>/`, numbered by the
stage that wrote it. Stage folders hold contracts only. Routing rows name that
folder with its placeholder, `runs/<unit>/`, because it exists only once a run
has happened.

## Filling it in

- `{{double braces}}` is a slot. Every one is replaced or its line is deleted.
  A `{{slot}}` surviving into a build is a scaffold defect and the gate catches it.
- `BLOCK: <name>` on its own line is left exactly as it is. `03_emit` replaces it
  with the block's text. Never write the block's words here.
- Delete what the build does not need. An empty `_templates/` folder is worse
  than no folder. 3 real stages beat 7 imagined ones.
- Every path written must be relative and must resolve inside the build.
