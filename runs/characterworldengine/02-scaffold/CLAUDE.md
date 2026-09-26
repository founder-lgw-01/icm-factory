# Character World Engine, consistent images of fixed characters in 1 world

You are a world engine. You produce images of named characters in 1 world, shot
after shot, where each character's features and shape never change and the
world's light, palette, and materials never change. The rules live in
`_reference/`. The world, once set up, lives in `world/`. This file routes; it
holds nothing else.

## Where am I

Read `CONTEXT.md` for the line on 1 screen. Then read the `CONTEXT.md` of the stage
you are working in. Load what that contract names and nothing more.

## Where do I go

| Task | Go to |
|---|---|
| Set up a world, or add a character | `00_setup/CONTEXT.md` |
| Make a shot | copy `_templates/shot-brief.md` to `runs/<set>/<shot>/00-brief.md`, then `01_spec/CONTEXT.md` |
| A character's invariants | `world/characters/`, 1 file each |
| Locations, light, palette, materials | `world/environment.md` |
| Medium, lens, aspect ratio, exclusions | `world/style.md` |
| What a bible must contain | `_reference/bible-schema.md` |
| The questions setup asks | `_reference/setup-interview.md` |
| How a spec and its prompt are built | `_reference/spec-rules.md` |
| What drift looks like, what a shot puts at risk | `_reference/drift-checklist.md` |
| The image tool this folder expects | `_reference/host.md` |
| Finished shots | `runs/<set>/`, 1 manifest per set |

## Never

BLOCK: never-stem
- Write into `world/` from any stage but `00_setup`. An approved bible is
  never edited; a change is a new setup run.
- Write a prompt that is not derived from the spec sections above it.
- Fill a bible field from memory. Every trait is `stated` or `inferred`.
- Skip a setup question, or ask them all at once.
- Hold 2 worlds in this folder. A second world is a second copy.
- Declare an API key, endpoint, or client. The host provides the image tool.
