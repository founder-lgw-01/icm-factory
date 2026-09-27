# Character World Engine

This folder produces images of fixed characters in 1 fixed world, 1 shot at a
time, for an operator who wants a set of images that hold together: the same
face, the same build, the same light and palette, across any pose, action, or
scene. A run costs 3 short reads from you: the world files once, then each
shot's spec before it is rendered and its image before it is filed.

The folder ships empty. Setting it up fills it with 1 world. To make a second
world, copy the empty folder again.

## Start a run

1. Open `CLAUDE.md`. It routes; it holds nothing.
2. Read `CONTEXT.md` for the whole line on 1 screen.
3. First time only: put your reference images in `world/references/`, then go
   to `00_setup/` and read its `CONTEXT.md`. It interviews you before it writes
   anything. Read the files it writes, correct them, and approve each 1 on
   its own: the modules, the locations, the style rules, each character, and
   1 permission record per image.
4. For a shot: copy `_templates/shot-brief.md` to `runs/<set>/<shot>/00-brief.md`
   and fill it in. `<set>` is a name you give a group of shots; `<shot>` is
   this shot's name.
5. Go to `01_spec/`, then `02_render/`, then `03_file/`. Each stage's
   `CONTEXT.md` says what it reads, what it writes, and what you check.
6. Read each output. Edit it. Flip `status: draft` to `status: approved`, or
   name the file in chat and say approve or reject; the agent writes it and
   reads it back. `ok` is not approval. The next stage refuses to run until
   the file says so, and the render also refuses a spec whose world files
   changed after it was approved.

To add a character later, go to `00_setup/` again in character mode. The world
stays as it is. To change an approved world file, name it and the change:
`00_setup` reopens that file, and only that file, as a draft.

## How the world is filed

`world/environment.md` is a router. The facts live in `world/environment/`:
core and palette-lighting, which every shot loads, and architecture,
materials, terrain-vegetation, and topology, which a shot loads only when it
shows them. Each location has its own file under `world/environment/locations/`
and is loaded only when a brief names it as visible. Each reference image has
a record beside it, `world/references/<image-stem>.md`, saying what it may
lend and what it may not, by role; bibles link to roles and never copy them.

A spec records every world file it read, with a hash, under its **Brief**.
The render checks that list before it sends anything, so an edit to the world
cannot change the meaning of a spec you already approved.

## Structural check

From the folder root: `python -B -m unittest discover -s tests -v`. It checks
that the world files carry their fields, that every dependency and role link
resolves, and that permissions live in 1 place. It approves nothing.

## What you need

This folder, and an agent that can read it and has an image generation tool.
As shipped it expects Hermes with `image.generator` backed by GPT Image 2.5
Sunburst. `_reference/host.md` names the tool and is the only file to change
for a different host. No API key, endpoint, or client is declared here.

BLOCK: icm-credit
