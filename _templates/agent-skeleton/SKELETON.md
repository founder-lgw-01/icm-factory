# Agent skeleton, how to use this template

`02_scaffold` copies this folder to `runs/<slug>/02-scaffold/` and fills it in.
This file does not ship: `03_emit` strips it.

## What is here

| File | Becomes |
|---|---|
| `CLAUDE.md` | the built agent's entry file, under 60 lines |
| `CONTEXT.md` | the built agent's line, 1 table |
| `README.md` | what a recipient reads first |
| `NN_stage/CONTEXT.md` | copy once per stage, rename `NN_stage` to the real name |
| `_reference/voice.md` | the agent's own voice rules, or delete if intake heard none |
| `runs/README.md` | the note that makes `runs/` exist before the first run; ships as is |

`AGENTS.md` is not here on purpose. `03_emit` makes it as a byte-for-byte copy
of the finished `CLAUDE.md`, for hosts that read `AGENTS.md` first.

The built agent writes every run's output into `runs/<unit>/`, numbered by the
stage that wrote it. Stage folders hold contracts only. The build ships `runs/`
with its note inside, so every route to it resolves before the first run, and a
rebuild keeps everything under it. Routing rows name a unit's folder with its
placeholder, `runs/<unit>/`.

No path in this skeleton may be a path that cannot exist in a build. `NN_stage` is
a folder here so the template resolves; in a build it has a real name, and a
route left reading `NN_stage` fails the gate.

## Filling it in

- `{{double braces}}` is a slot. Every one is replaced or its line is deleted.
  A `{{slot}}` surviving into a build is a scaffold defect and the gate catches it.
- `BLOCK: <name>` on its own line is left exactly as it is. `03_emit` replaces it
  with the block's text. Never write the block's words here.
- Delete what the build does not need. An empty `_templates/` folder is worse
  than no folder. 3 real stages beat 7 imagined ones.
- Every path written must be relative and must resolve inside the build.
