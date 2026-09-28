# Blocks, the single home

Every text block that appears in more than 1 built agent lives here, once.

`02_scaffold` writes `BLOCK: <name>` on its own line where a block belongs.
`03_emit` replaces that line with this file's body, verbatim, minus frontmatter.

`01_form` and `02_scaffold` read this index, and only this index, to name the
blocks a build needs. The bodies are `03_emit`'s: a stage that read them would
be tempted to retype them, which is the drift this folder exists to prevent.

**To change a block:** edit the file here, add an entry to `../../change-log.md`,
run `_system/audit-builds.sh` to see which shipped builds now trail, and re-run
those builds. Never edit a block inside `builds/`. That is the drift this whole
factory exists to prevent, and it starts with 1 reasonable-looking edit.

| Block | Goes in | Every build? |
|---|---|---|
| `icm-credit` | `README.md` | yes |
| `status-convention` | root `CONTEXT.md` | yes |
| `never-stem` | `CLAUDE.md`, under `## Never` | yes |
| `naming` | root `CONTEXT.md` | yes |
| `edit-surface` | root `CONTEXT.md` or `_reference/how-to-run.md` | yes |
| `walk-test` | `_reference/` | when the build has 3+ stages |
| `icm-about-icm` | `CLAUDE.md` | only when the subject matter is ICM |

A block is added when the same text is wanted in a second build, not before.
2 builds is the threshold; 1 is a coincidence.
