---
slug: characterworldengine
stage: 01_form
status: approved
generated: 2026-09-25
sources: runs/characterworldengine/00-intake.md
form: pipeline
---

# 01-plan, characterworldengine

## Form and why

**Pipeline.** The repeating unit is a run: the same stages, a new shot each
time, a human at every boundary, and a deliverable (the image plus its sidecar)
leaves at the end. The 1-time world setup is the pipeline form's own
`setup/` move, the questionnaire that configures the factory once, so the
build stays 1 form. Rejected: record library, because a shot runs to
completion and is never reopened; the named sets are a filing convention on
the product, not records that accumulate.

The whole job does not fit in 1 saved prompt: it carries 3 human gates, a
stable bible layer that outlives any chat, and outputs that must be reproducible
from files.

## Source fidelity

Omitted. Door A, no source runs today. Nothing is load-bearing before the
build exists.

## Stages

Setup runs once per world, and once more per character added later. The shot
line runs once per shot. `<set>` is a name the operator gives a group of shots;
`<shot>` is the shot's slug. Attempts inside a shot are numbered `N`, starting
at 1, so a sent-back shot keeps every prompt and image it produced.

| Stage | Job | Inputs | Do not load | Output | Human check |
|---|---|---|---|---|---|
| `00_setup` | interview the operator, then write the bibles; in character mode write 1 new character bible only | Working: the operator's answers and reference images, in chat or in `00_setup/references/`. Reference: `_reference/setup-interview.md`, `_reference/bible-schema.md`, `_templates/character-bible.md`, `_templates/environment-bible.md`, `_templates/style-rules.md`; character mode also reads `world/environment.md` and every existing `world/characters/*.md` for relative scale | `runs/`, `_reference/spec-rules.md`, `_reference/drift-checklist.md` | `world/interview.md`, `world/environment.md`, `world/style.md`, `world/characters/<name>.md`; every trait marked `stated` or `inferred` | Open each bible beside the reference images. For every line marked `inferred`, confirm it against an image or rewrite it; strike anything an image contradicts. Flip `status: approved` on each file. |
| `01_spec` | turn a shot brief into a shot spec: the resolved brief, the decisions taken from the bibles for this shot, the invariants at risk, and the prompt; on a rerun, revise the last spec from the drift notes | Working: `runs/<set>/<shot>/00-brief.md` (operator-authored from `_templates/shot-brief.md`); on rerun also the latest `runs/<set>/<shot>/02-render-N.md` with `verdict: drifted`. Reference: `world/environment.md`, `world/style.md`, `world/characters/<name>.md` for each character the brief names, `_reference/spec-rules.md`, `_reference/drift-checklist.md` (its risk table) | `world/interview.md`, any other shot's folder, `_reference/setup-interview.md`, `_reference/bible-schema.md` | `runs/<set>/<shot>/01-spec-N.md`, sections in order: **Brief** (every field filled, with the questions asked and answered where the brief left a field empty) · **Characters in frame** (each character's invariants pulled from its bible, and its variables set for this shot: expression, pose, wardrobe state) · **Scene** (location, time of day, and the lighting, palette, and materials the environment bible gives for them) · **Camera** (framing, lens, angle, aspect ratio from the style rules) · **At risk** (the invariants this shot threatens and how the prompt guards each) · **Prompt** (the text as it will be sent, and nothing that is not above it) | Read the spec top to bottom against the brief and the named bibles. Every invariant under **At risk** is guarded in **Prompt** in words, and nothing in **Prompt** contradicts a section above it. Flip `status: approved`. |
| `02_render` | send the approved spec's prompt to the host's image tool, save the image, run the drift check per character | Working: the highest-numbered approved `runs/<set>/<shot>/01-spec-N.md`. Reference: `world/environment.md`, `world/characters/<name>.md` for each character named, `_reference/drift-checklist.md`, `_reference/host.md` | `world/interview.md`, `world/style.md`, `_reference/spec-rules.md`, `_reference/setup-interview.md`, any other shot's folder | `runs/<set>/<shot>/02-image-N.<ext>` and `runs/<set>/<shot>/02-render-N.md`: the prompt as sent, the tool's returned metadata (`not exposed` where the tool gives none), the drift findings per character and for the environment, each read against the spec's **At risk** section first, a `verdict` field the operator fills | Put the image beside the spec and each named character's bible and the environment bible, and walk the drift checklist line by line, **At risk** items first. Write `verdict: accepted` and flip `status: approved`, or write what drifted under **Drift notes** and `verdict: drifted`, which sends the shot back to `01_prompt`. |
| `03_file` | file the accepted image into its set | Working: the `runs/<set>/<shot>/02-render-N.md` with `verdict: accepted`, and `runs/<set>/manifest.md` if it exists. Reference: `_templates/sidecar.md`, `_templates/set-manifest.md` | `world/`, `_reference/spec-rules.md`, `_reference/drift-checklist.md`, any other shot's folder | `runs/<set>/<shot>/03-sidecar.md`: the prompt as sent, the tool metadata, the characters in frame, the accepted image's filename, the drift verdict; 1 line appended to `runs/<set>/manifest.md`, created from the template on the set's first shot | Open the manifest line, follow it to the sidecar, and read the sidecar's prompt against the accepted render record's prompt, word for word. Flip `status: approved`. |

Stops counted: the bibles (after `00_setup`), the spec (after `01_spec`),
the drift check (after `02_render`). Filing is mechanical and carries the
lightest check. The brief has no stage of its own: the operator writes it, and
the operator does not stop to check their own brief before the spec is
built. The spec is the judgment call surfaced as a file before the expensive
step: every decision the render will act on is readable and editable there,
and the prompt is derived from the sections above it, never written first. Generation and drift check share a stage: nothing stops between the
image arriving and the check running.

`00_setup` writes into `world/`, not `runs/`. That is the 1 place this build
diverges from the outputs convention, on purpose: setup runs once, its output
is reference for every shot, and a shot stage must never write there. The
build's `## Never` says so.

## The built agent's factory

Stable, every run:

- `_reference/bible-schema.md`: the fields a character bible carries
  (invariants that never change; variables allowed to move; relative scale to
  other characters), the fields an environment bible carries, the fields the
  style rules carry, and how a trait is marked `stated` or `inferred`.
- `_reference/setup-interview.md`: every clarifying question, in order. World
  questions first, then per-character questions. All are asked before a bible
  is written. Character mode asks the character questions only.
- `_reference/spec-rules.md`: how a spec is built, section by section; what
  the brief contributes, what each bible contributes, what the style rules
  contribute; how the prompt is derived from the sections above it for
  Gemini 3 Pro Image; exclusions worded as description, never as parameters;
  how 2 or more characters are placed in 1 prompt.
- `_reference/drift-checklist.md`: the invariants and what each looks like
  when it fails; the risk table (shot type to invariants at risk); how the
  check runs per character; the verdict format.
- `_reference/host.md`: the capability the build needs, an image generation
  tool available to the running agent; the tool as shipped (Hermes
  `image.generator`, Gemini 3 Pro Image); what the render record captures and
  the `not exposed` rule. No key, endpoint, or client.
- `_templates/`: `character-bible.md`, `environment-bible.md`, `style-rules.md`,
  `shot-brief.md`, `sidecar.md`, `set-manifest.md`.
- `world/`: filled by `00_setup` once, then read-only. `README.md` states the
  rule. `characters/` holds 1 file per character.

New, every run: `runs/<set>/<shot>/00-brief.md`, `01-spec-N.md`,
`02-image-N.<ext>`, `02-render-N.md`, `03-sidecar.md`; `runs/<set>/manifest.md`.

The sidecar written by `03_file` carries the prompt and the tool metadata, and
names the accepted spec, so a shot can be reproduced from the sidecar alone and
explained from the spec.

Routing: `CLAUDE.md` routes to the bibles and the style rules by name, to the
setup stage for a new world or a new character, and to `_templates/shot-brief.md`
to start a shot.

## Blocks needed

`status-convention`, `edit-surface`, `naming`, `never-stem`, `walk-test`
(4 stages), `icm-credit`. Not `icm-about-icm`: the subject is images, not ICM.
`02_scaffold` confirms the every-build list against `_reference/blocks/README.md`.

## Rejected

- **Umbrella.** 1 line, not several. A second world is a second copy of the
  engine, decided at intake, not a sibling pipeline in 1 root.
- **Knowledge bundle.** The bibles are knowledge, but the product is the image.
  The bibles are the built agent's factory, not its product.
- **A `worlds/` folder inside 1 engine.** Every brief would name a world and
  every check would be told which bibles to read; "the bibles never change after
  approval" stops being true because the folder is always in setup for something.
- **A separate `00_brief` stage.** No stop between the operator writing the
  brief and the spec being built.
- **A prompt-only middle stage.** A prompt with no spec above it hides the
  decisions the render acts on. The spec is the edit surface; the prompt is its
  last section.
- **A separate drift-check stage after generation.** No stop between the image
  arriving and the check running.
- **Declaring the image API inside the build.** The host provides the tool. The
  build names the capability and stays portable.
