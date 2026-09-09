# The Production Line, the map

You are working inside a content production line. This file is the map. The
owner's answers in `_config/my-line.md` are the truth. If 2 files disagree, the
config wins.

## Route by intent

| The task | Go to | Skill that fires |
|---|---|---|
| Set up the owner's line (first run) | `00-START-HERE.md`, the interview | ask 1 question at a time, write `_config/my-line.md` |
| Any video work, named or not | fire the gate FIRST | `rymac-follow-the-production-line` |
| Research a market drowning in AI | `01-RESEARCH/` | `rymac-research-a-market-drowning-in-ai` |
| Research a trade or service niche | `01-RESEARCH/` | `rymac-research-a-trade-niche` |
| Gameplan, script, spec | `production/<video>/` | `rymac-build-a-youtube-video` + `rymac-write-a-slide-video-script` |
| The reader the owner records from | `production/<video>/` | `rymac-make-a-reader-to-record-from` |
| Any timing, alignment, render, assembly | `production/<video>/` | `rymac-edit-and-render-a-video` |
| Package a finished video | `community/packages/<slug>/` | `rymac-package-a-video-for-your-community` |
| The blog post behind a video | the blog home in the config | `rymac-write-an-seo-blog-post` |
| Anything the owner will publish or paste | before the first word | `rymac-write-in-the-owners-voice` |
| Explain the system to a buyer or beginner | the file or reply | `rymac-explain-it-to-a-beginner` |
| A headline, a sales letter, a sales page | the funnel work | `rymac-write-a-headline`, `rymac-write-a-sales-letter`, `rymac-build-a-sales-page` |

## The hard rules

1. **The 9 stages run in order and none gets skipped.** Gameplan, Script, Spec,
   VO, Storyboard, 90s, Render, Package, Blog. Read stage names off the files
   on disk, never trust the number prefixes.
2. **Re-read the owner's file from disk before building anything off it.**
   They edit files directly and save. The copy in your context is stale the
   moment they touch it.
3. **While the owner records, nothing runs on their machine.** Stop every job
   and say so.
4. **Renders run in the cloud.** The owner's machine stays free.
5. **The owner's voice is never cut.** Not by a frame.
6. **1 video = 1 self-contained folder** under `production/<video-name>/` with
   its own `out/`.
7. **No em dashes. Numbers as digits. No developer talk on public surfaces.**
   The owner's own banned words live in the config.
8. **Never invent a number.** Count it, measure it, or mark it UNMEASURED.
9. **Checks run before delivery**: `checks/check-stages.sh` for gaps,
   `checks/voice-check.sh` for the voice laws, the reader's own
   `check-reader.mjs` for the bytes. A failing check is a stop, not a note.
10. **Session end: write 1 line under Next in `CONTEXT.md`.** Done, decided,
    next. The next session starts there instead of blind.

## Credit

The folder-system methodology this kit teaches alongside is Interpretable
Context Methodology (ICM), created by Jake Van Clief and David McDermott:
https://arxiv.org/abs/2603.16021
