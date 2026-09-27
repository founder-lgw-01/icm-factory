# Host, the image tool this folder expects

This folder needs 1 capability from the agent running it: an image generation
tool the agent can call with a text prompt and get an image file back. Nothing
here declares an API key, an endpoint, or a client. The host provides the
tool; this file names it. To move the folder to a different host, change this
file and nothing else.

## As shipped

| | |
|---|---|
| Host | Hermes agent |
| Tool | `image.generator` |
| Model | GPT Image 2.5 Sunburst (`openai/gpt-image-2.5-sunburst`) |
| Prompt style | natural language; no parameter syntax, no weighting, no negative field |
| Aspect ratio | the tool takes an orientation label (`landscape`, `portrait`, `square`), not an exact ratio; the spec states the ratio in words at the end of the prompt, and the record reports the ratio measured from the file |
| Reference images | not passed to the tool; consistency comes from the prompt and the bibles |

The label is not a guarantee. A run on 2026-09-26 requested `landscape` and
got 1672 by 941, which is not 16:9. `01_spec` stops on a ratio the tool cannot
produce exactly and asks the operator for a supported ratio or an explicit
crop; `02_render` never relabels a near shape as the requested one.

## What the render record captures

`02_render` writes these under **Tool metadata**, in this order. A field the
tool does not return is written `not exposed`, never left blank, so a later
reader knows it was asked for.

1. `model`: the model name the tool reports
2. `request`: the prompt exactly as sent, byte for byte the spec's **Prompt**,
   with its SHA-256 and byte count
3. `manifest`: the result of the pre-render check of the spec's
   **World-input manifest**: `verified`, and the spec path, or the row that
   failed
4. `aspect_ratio`: as requested, as returned if the tool reports it, and as
   measured from the file's width and height
5. `resolution`: width by height of the returned image, measured
6. `seed`: if the tool exposes 1
7. `file`: the image filename and type
8. `generated`: the timestamp

## Changing host

Replace the table under **As shipped**. If the new tool takes parameters
(`--ar`, weights, a negative field), `spec-rules.md` still writes description;
add a line here saying which parameters `02_render` passes beside the prompt,
and keep the prompt itself free of them. If the new tool takes reference
images, the spec's manifest also lists each image sent, by path and hash, and
its record's selected role.
