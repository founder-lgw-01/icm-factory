# Character World Engine

This folder produces images of fixed characters in 1 fixed world, 1 shot at a
time, for an operator who wants a set of images that hold together: the same
face, the same build, the same light and palette, across any pose, action, or
scene. A run costs 3 short reads from you: the bibles once, then each shot's
spec before it is rendered and its image before it is filed.

The folder ships empty. Setting it up fills it with 1 world. To make a second
world, copy the empty folder again.

## Start a run

1. Open `CLAUDE.md`. It routes; it holds nothing.
2. Read `CONTEXT.md` for the whole line on 1 screen.
3. First time only: put your reference images in `world/references/`, then go
   to `00_setup/` and read its `CONTEXT.md`. It interviews you before it writes
   anything. Read the bibles it writes, correct them, and flip each to
   `status: approved`.
4. For a shot: copy `_templates/shot-brief.md` to `runs/<set>/<shot>/00-brief.md`
   and fill it in. `<set>` is a name you give a group of shots; `<shot>` is
   this shot's name.
5. Go to `01_spec/`, then `02_render/`, then `03_file/`. Each stage's
   `CONTEXT.md` says what it reads, what it writes, and what you check.
6. Read each output. Edit it. Flip `status: draft` to `status: approved`. The
   next stage refuses to run until you do.

To add a character later, go to `00_setup/` again in character mode. The world
stays as it is.

## What you need

This folder, and an agent that can read it and has an image generation tool.
As shipped it expects Hermes with `image.generator` backed by Gemini 3 Pro
Image. `_reference/host.md` names the tool and is the only file to change for
a different host. No API key, endpoint, or client is declared here.

BLOCK: icm-credit
