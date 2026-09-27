# Character World Engine, the line

The flow in 1 line: a world is set up once → a shot brief → a spec that hashes
the world files it read → a render and a drift check → the image filed into
its set.

| Stage | Job | Input | Output | Human check |
|---|---|---|---|---|
| `00_setup` | interview, then write the world; again per character; revise by name | answers, `world/references/` | under `world/`: the router and modules, the style rules, 1 bible per character, 1 record per image | confirm every `inferred` line against an image; approve file by file |
| `01_spec` | brief to spec: brief, manifest, characters, scene, camera, at risk, prompt | `runs/<set>/<shot>/00-brief.md`, the world files it selects | `runs/<set>/<shot>/01-spec-N.md` | every risk guarded in the prompt; every file read is in the manifest |
| `02_render` | verify the manifest, send the prompt unchanged, save the image, check drift | the approved spec | `runs/<set>/<shot>/02-image-N.<ext>`, `runs/<set>/<shot>/02-render-N.md` | walk the drift checklist; write the verdict |
| `03_file` | file the accepted image into its set | the record with `verdict: accepted` | `runs/<set>/<shot>/03-sidecar.md`, 1 line in `runs/<set>/manifest.md` | read the sidecar's prompt against the record |

A `verdict: drifted` sends the shot back to `01_spec` for attempt N+1. Every
attempt keeps its files.

Factory (stable, every run): `_reference/`, `_templates/`, `tests/`, and `world/` once approved
Product (new each run): `runs/<set>/<shot>/`, numbered by the stage that wrote each file

## Status is whatever exists

A stage is complete when its output file carries `status: approved` in its
frontmatter. A person flips that line, not the agent, and not a script.

A stage refuses to run until the stage before it is approved. Status lives
nowhere else: there is no tracker, no board, no separate state file. To know
where a run stands, look at what is on disk.

Here the operator may also decide by naming the file in chat; the agent writes
it and reads it back. `_reference/approval.md` draws the line.

## Frontmatter

Every shot output begins with `set`, `shot`, `attempt`, `stage`, `status`
(`draft` | `approved`; the operator flips it), `generated`, `sources`. A world
file carries `world` instead of the first 3, and adds `kind`, `scope`,
`depends_on`, `reference_roles` as `_reference/bible-schema.md` defines. A
render record adds `verdict`.

## Every output is an edit surface

Each stage writes a plain file you can open, edit, and save. The next stage reads
whatever you left there, not what the stage before it meant to write.

This is where you steer. An output you never open is a stage running unsupervised,
and the human check on each contract is the place the design expects you to look.
Edit in place; do not start a parallel copy.

## Naming

Folders are `NN_kebab-case` where order matters. Renaming reorders the line,
and that is the point. Files are kebab-case. A `_prefix` means *about the
workspace, not of the work*, the way `_reference/` holds the rules and never the
output.

Slugs are lowercase, no spaces, no punctuation. Every output carries the slug of
the thing it belongs to.
