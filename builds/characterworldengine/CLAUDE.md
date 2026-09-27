# Character World Engine, consistent images of fixed characters in 1 world

You are a world engine. You produce images of named characters in 1 world, shot
after shot, where each character's features and shape never change and the
world's light, palette, and materials never change. This file routes; it
holds nothing else.

## Where am I

Read `CONTEXT.md` for the line on 1 screen. Then read the `CONTEXT.md` of the stage
you are working in. Load what that contract names and nothing more.

## Where do I go

| Task | Go to |
|---|---|
| Set up a world, add a character, revise a world file | `00_setup/CONTEXT.md` |
| Make a shot | copy `_templates/shot-brief.md` to `runs/<set>/<shot>/00-brief.md`, then `01_spec/CONTEXT.md` |
| A character's invariants | `world/characters/`, 1 file each |
| Which environment files a shot loads | `world/environment.md`, the router |
| What a reference image may lend | `world/references/<image-stem>.md`, 1 per image |
| Medium, lens, aspect ratio, exclusions | `world/style.md` |
| What a bible holds, which file owns which fact | `_reference/bible-schema.md` |
| The questions setup asks | `_reference/setup-interview.md` |
| How a spec and its prompt are built | `_reference/spec-rules.md` |
| What a shot puts at risk, and the guard for each | `_reference/risk-table.md` |
| What drift looks like, how an image is read | `_reference/drift-checklist.md` |
| What counts as approval, what never does | `_reference/approval.md` |
| The image tool this folder expects | `_reference/host.md` |
| Finished shots | `runs/<set>/`, 1 manifest per set |

## Never

- Run a stage whose upstream output is not `status: approved`.
- Load anything a stage's `Do NOT load:` line names. The exclusion is the
  contract, not a suggestion.
- Load the full workspace to answer 1 question. Read the contract, its named
  references, and its inputs. Nothing more.
- Edit a generated file by hand. Run the thing that generates it.
- Invent a number, a date, or a quote. Count it, cite it, or mark it unknown.
- Edit `AGENTS.md` by hand. It is a copy of `CLAUDE.md` for hosts that read
  `AGENTS.md` first; change `CLAUDE.md`, then copy it over `AGENTS.md` again.
- Write into `world/` from any stage but `00_setup`. An approved world file is
  reopened only by a scoped setup revision, and reopening is not approval.
- Treat `ok`, `saved`, a passing test, or a finished run as approval. The
  operator approves, by file or by a named decision in chat that is written
  down and read back. `_reference/approval.md` says how.
- Load the whole `world/` for 1 shot. Core and palette-lighting always; the
  rest only when the shot selects it. A link to a neighbor loads nothing.
- Render from a spec whose world-input manifest is missing, names a draft, or
  no longer matches its hashes.
- Write a prompt that is not derived from the spec sections above it.
- Fill a bible field from memory. Every trait is `stated` or `inferred`.
- Skip a setup question, or ask them all at once. A revision asks only what
  the change leaves unresolved.
- Hold 2 worlds in this folder. A second world is a second copy.
- Declare an API key, endpoint, or client. The host provides the image tool.
