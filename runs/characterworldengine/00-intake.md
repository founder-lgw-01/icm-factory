---
slug: characterworldengine
stage: 00_intake
status: approved
generated: 2026-09-25
sources: interview
door: idea
---

# 00-intake, characterworldengine

The product is a framework folder, not an image. The built agent is an ICM
workspace that produces images of named characters in 1 world, across any
action, pose, camera, or scene, where each character's face, build,
proportions, and signature features never change and the world's palette,
materials, architecture, and lighting logic never change.

The operator chose the world-engine shape: the built folder holds the rules
for making a world, sets 1 world up once, then produces shots against it.

## 1 folder, 1 world

The emitted engine ships with no filled bibles. That empty folder is the
template. Setting it up fills the bibles and turns the copy into 1 world.
A second world is a second copy of the empty engine, set up with its own
references. Worlds share the rules and never share bibles. A change to the
rules is made in the empty engine and reaches new worlds; an existing world
keeps the rules it was built with unless the operator copies the change in.
The engine does not hold 2 worlds in 1 folder.

## Host

The built folder will be moved into a Hermes agent workspace. Hermes carries an
image generation tool (`image.generator`, backed by Gemini 3 Pro Image) and the
running agent calls it directly. No API key, endpoint, or client is declared
inside the build. The build names the capability it needs ("an image
generation tool available to the running agent") and nothing more, so it stays
portable to any host that has one.

Consequences for the build:
- Prompts are written for Gemini 3 Pro Image: natural-language description,
  no parameter syntax, no prompt weighting, no negative-prompt field. Exclusions
  are stated in words inside the prompt.
- The sidecar records whatever the tool returns (a seed when the tool exposes
  it, the model name, the request as sent). A field the tool does not expose is written
  `not exposed`, never left blank.

## Repeating unit

1 shot. 1 run of the built agent produces 1 accepted image and the record of
how it was made. A set is many runs against the same bibles.

World setup is not a repeating unit. It is a 1-time stage that runs before the
first shot and whose output becomes stable reference for every shot after it.
The factory hears 2 units here; the operator settled it: the shot repeats, the
world does not. Adding a character later is a rerun of the setup stage for
that character only, and it does not reopen the world.

## 1 run, start to finish

In the operator's words, joined from 3 messages:

> I want an ICM folder structure that builds it. The framework for building
> images using references, rules, everything designed so that a world can be
> created with different actions and poses of the character, but the
> character's features and shape remains the same. [...] There could be more
> than 1, so allow for future characters if needed. Also make it so that
> starting asks all the clarifying questions before building.

Setup, once per world, and once per character added later. The stage opens
with an interview: it asks every clarifying question it has before it writes
anything. Nothing is inferred silently. It takes reference images (posted in
chat, or placed in the stage's `references/` folder) and the operator's
answers. It writes 1 character bible per character: face, body shape,
proportions, hair, outfit, props, the invariants that must never change, and
the things allowed to vary (expression, pose). It writes the environment bible:
locations, palette, materials, era, lighting rules. It writes the style rules:
medium, lens, aspect ratio, exclusions stated in words. The operator reads and
approves each bible. After approval no later stage may edit them.

1 shot. The operator writes a shot brief: which characters appear, action,
pose, expression, camera, location, time of day. If the brief leaves a field
empty the agent asks before assembling; it does not guess. The agent assembles
the full generation prompt from the brief plus every named character's bible
plus the environment bible plus the style rules, and lists which invariants the
shot puts at risk (a profile view risks the jawline, a running pose risks
proportions, 2 characters in frame risks relative height). The operator reads
the prompt. The agent generates the image through the host's image tool. The
agent runs a drift check against the bibles, per character, and names what
moved. If it drifts, the operator writes what drifted, the agent revises the
prompt, and generates again. When it passes, the image is filed with its
prompt, the tool's returned metadata, and the drift result, and the set
manifest is updated.

## Stops

1. The bibles, once per character and once for the world, before any shot.
   The operator reads every invariant against the reference images and strikes
   or corrects each trait the agent marked inferred.
2. The assembled prompt, before a generation is spent. The operator reads the
   prompt and the risk list.
3. The drift check, before an image joins the set. The operator compares the
   image to each named character's bible and to the environment bible,
   invariant by invariant, and accepts or sends it back.

## Stable vs new

Stable, every run, in the built agent's own `_reference/`:
- bible schema: the fields a character bible carries, the fields an
  environment bible carries
- the setup interview: the full list of clarifying questions, asked in order,
  all before the first bible is written
- rules for writing a bible from reference images and answers, including how
  an inferred trait is marked for the operator to confirm
- prompt assembly rules for Gemini 3 Pro Image: order, what each bible
  contributes, what the brief contributes, how exclusions are worded
- drift checklist: the invariants, what each looks like when it fails, and how
  the check runs per character when 2 or more are in frame
- style rules: medium, lens, aspect ratio, exclusions
- after setup: the filled environment bible and 1 filled bible per character,
  in a `characters/` folder

New, every run, in the built agent's stage outputs:
- the shot brief, naming its set
- the assembled prompt and its risk list
- the image
- the drift notes and verdict, per character
- the entry in that set's manifest, and the set's manifest itself the first
  time the set is named

## What ships

1 image file plus a sidecar `.md` holding the exact prompt as sent, the tool's
returned metadata, the characters in frame, and the drift verdict, filed into
the manifest of a named set. A set is a group the operator names (a scene, a
chapter, a campaign); each set has its own manifest and every shot brief names
the set it belongs to. The world folder itself is zippable and reusable on its
own: hand it over and a second person can produce a shot that matches the set.

## Who else touches it

The operator only. The built `CLAUDE.md` still routes to the bibles and the
style rules by name, so the operator finds them without reading the tree.

## Open questions

1. Reference images for the first world. The operator will post them in chat.
   They are input to the built agent's setup stage, not to this factory run: the
   factory emits the engine, then the operator starts the engine and posts the
   images to it. Nothing here blocks on them.
