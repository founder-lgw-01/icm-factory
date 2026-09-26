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
| Model | Gemini 3 Pro Image |
| Prompt style | natural language; no parameter syntax, no weighting, no negative field |
| Aspect ratio | passed as a tool parameter where the tool takes 1; otherwise stated in words at the end of the prompt |
| Reference images | not passed to the tool; consistency comes from the prompt and the bibles |

## What the render record captures

`02_render` writes these under **Tool metadata**, in this order. A field the
tool does not return is written `not exposed`, never left blank, so a later
reader knows it was asked for.

1. `model`: the model name the tool reports
2. `request`: the prompt exactly as sent, byte for byte the spec's **Prompt**
3. `aspect_ratio`: as requested, and as returned if the tool reports it
4. `resolution`: width by height of the returned image
5. `seed`: if the tool exposes 1
6. `file`: the image filename and type
7. `generated`: the timestamp

## Changing host

Replace the table under **As shipped**. If the new tool takes parameters
(`--ar`, weights, a negative field), `spec-rules.md` still writes description;
add a line here saying which parameters `02_render` passes beside the prompt,
and keep the prompt itself free of them.
