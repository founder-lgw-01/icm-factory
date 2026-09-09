---
name: rymac-build-a-youtube-video
description: Builds a YouTube video end to end through the production line - gameplan, script, record spec, teleprompter reader, VO alignment, and render - plus the 2-version cut (a clean one for posting in other communities, a branded one for the channel). Enforces the hard-won rules - name the render engine before planning, running text slides wherever the owner talks without b-roll, never a visual before the line that explains it, and a 90-second approval render before building the full length. Use when the user asks to "make a video", "build a YT video", "explainer video", "write a record spec", "align the VO", "render the video", "make a teleprompter", or wants to reuse old b-roll. Make sure to use this skill whenever a video is being planned, shot, cut, or rendered.
argument-hint: [video topic or project folder]
---

> ⛔ **BEFORE THIS SKILL DOES ANYTHING, the production line gets read out loud.**
> Fire `rymac-follow-the-production-line` first. It posts the 9 stages, names the
> 5 skills, marks where this job starts, and waits for the owner's go. Firing 1
> skill out of 5 and jumping to a single stage is the failure shape that puts a
> 27 word slide in front of a microphone.
> The 5 that fire on any video: `rymac-build-a-youtube-video`,
> `rymac-write-a-slide-video-script`, `rymac-edit-and-render-a-video`,
> `rymac-write-in-the-owners-voice`, `rymac-make-a-reader-to-record-from`.
> None of them wait to be named.

# The YouTube video build

> **⛔ MANDATORY COMPANION: load `rymac-edit-and-render-a-video` the moment any
> timing, alignment, render, or assembly work starts (steps 8 through 11 below).**
> It carries the 7-phase edit procedure. It was added after 5 re-renders in 1
> night, every one traced to a skipped phase.

**The bar:** anyone who watches one of these videos should want to ask how it was
made. The cadence and the animation are why the videos work. They are not
decoration.

## RULE 00, the skin. The config answers it, or the owner does.

A skin is the video's visual identity. The ground color, the text color, the 1
accent, the font, the end card. It is declared once per brand in
`_config/my-line.md` and never asked about again.

- If the brand's skin is in the config, use it. **Asking again is a drift signal**,
  because a session that has lost track of the brand will also get the ending,
  the blog target and the reader look wrong 10 minutes later, in silence.
- If the config has no skin for this brand, ask ONCE, bring a recommendation with
  the question, and write the answer into the config and the gameplan lock block.

**The skin also decides the ending.** A video ends on the brand it belongs to. If
the owner runs 2 brands, the video mentions the other brand on the way past and
ends on its own. Both get written into the lock block together:

```
BRAND:
SKIN:
SURFACE:   channel | page | classroom
ENDS-ON:
SLUG:
```

`SURFACE:` is the fork the gate asks about. `channel` is a YouTube video: it
earns a subscriber, carries the standing close, and ends in the package and
the blog post. `page` is a VSL: it closes a sale or books a call, carries NO
standing close, and ends on the squeeze or sales page built around it.

## RULE 0, the render engine is named before anything is planned

Videos here are built in code and rendered to MP4. `rymac-build-video-in-code`
carries the engine knowledge. The first line of every spec names the engine.

This rule earned its place: a spec once detailed every shot, hold and cut point
and never said what would assemble them. A parallel one-off assembly got built,
took hours, and produced a rejected render. The engine gets named first so that
can never happen again.

## The 7 hard rules

0. **Every video runs HOOK, then STORY, then TEACH, then CLOSE.** The story comes
   BEFORE the teach and frames it, never after. If a gameplan parks the story in
   a later section, the script reorders it up front.
1. **Name the render engine in the spec on line 1.**
2. **Dead stretches get running text slides in the owner's cadence.** Wherever
   they talk with no b-roll, text carries them, one line at a time. Never a held
   frame. A held frame with a slow push reads as a broken player.
3. **Never put a visual on screen before the line that explains it.** A
   metaphor's first frame is the sentence that names it.
4. **Record screen clips with captions ON if the source has any.** Captions can
   be cropped off in post. They can never be added back.
5. **Show 90 seconds before building the full length.** Render the cold open,
   get approval on the treatment, then build the rest.
6. **Check the number, not the exit code.** Render bugs succeed wrongly more
   often than they fail. A wrong frame rate silently drops a minute. A wrong
   flag amputates the voiceover. Both report DONE. Always compare output
   duration against the VO, and sample frames at the moments that matter.

## The sequence

The rail: Script. Spec. Reader. VO. Render. Zip. Blog. After each approval gate
the next step is already decided. Announce it and do it. Never ask the owner what
comes next, never reorder.

| # | Step | Output |
|---|---|---|
| 0 | **The keyword plan, BEFORE anything.** The owner brings the SEO keyword plus the hook that ties the keyword into a reason to click, from the research tool named on the RESEARCH-TOOL line of `_config/my-line.md`. If they have no keyword, OFFER to research the topic for them: run the research skills, bring back a keyword, a hook and a title for approval, and feed the same keyword into the blog stage's map. It goes at the TOP of the gameplan and is LOCKED. No later step may override or re-research it. Never make a video and then go find traffic. No tool yet? The recommendation is vidIQ: https://vidiq.com/buildmarketclose | keyword + hook + title, locked in `01-GAMEPLAN.md` |
| 1 | **Gameplan.** Concept, audience, the ONE mechanic, the lock block | `01-GAMEPLAN.md` |
| 2 | **Script.** The owner approves before anything else moves | `02-SCRIPT.md` |
| 3 | **Reusable assets.** Search the b-roll index before scheduling a single new shot | `03-REUSABLE-ASSETS.md` |
| 4 | **Record spec.** Shot list, in-points, the scrub line, both cut points | `04-SPEC.md` |
| 5 | **Teleprompter reader.** Generated FROM the script so it cannot drift | `05-VO-READER.html` |
| 6 | **Shoot.** Silent screen clips first, then ONE voiceover | `screen/` |
| 7 | **Review every clip frame by frame** before the voiceover is recorded | |
| 8 | **Align.** Word-level transcription of the recorded VO | `vo-words.json` |
| 9 | **Fold.** Script to slides plus visual cues | `<slug>-fold.md` |
| 10 | **Compose and render 90 seconds** for approval | the approval clip |
| 11 | **Render both cuts** | `out/<slug>-final.mp4` + `-clean.mp4` |

## Shoot the screen BEFORE the voice. Always.

This order earned its keep twice in one day. Two script numbers were wrong and
only the footage revealed it. A line count said 146 where the script said 145. A
receipt on screen said one date where the script said another. Both would have
shipped wrong and been unfixable after the voiceover was recorded.

**Whatever is on screen wins.** If a clip contradicts the script, change the
script before the owner reads it.

## Reuse before you shoot

Keep an index of every b-roll clip you own: the file, what it shows, the usable
window, and any range that must never be published. Search it before scheduling
a new shot. Two things the index saves you from, both real:

- A clip's first 20 seconds are often a tool booting up with nothing visible.
  Write down the usable window and use it.
- Some clips have windows that must never air: an exposed username in a tooltip,
  real customer emails in a browser tab. Record those as never ranges and honor
  them.

## The 2-version cut

Almost every video ships twice. A **clean** cut for posting into someone else's
community, and a **channel** cut with the CTA, any affiliate disclosure, and the
end card.

Write the body so it ends on a real close, then make everything promotional a
severable tail. Mark each channel-only stretch in the script and have the owner
leave 1 full second of silence either side when they record it, so it lifts out
of the audio without a seam.

**When the lock block says `VSL-TAIL: yes`, there is a third cut.** Same body,
recorded once, and a second ending that closes instead of signing off: no
standing close, no subscribe ask, it hands straight to the page the video will
sit on. The owner records both endings in the same session with 1 second of
silence at the split, and the render stage cuts the channel version and the
VSL version from the 1 take.

## Voice and asset rules that hold every time

- No em dashes. Numbers as digits. No orphaned words.
- **No periods in anything the owner reads on mic.** Slide text and teleprompter
  lines ship with no terminal punctuation. Seeing it mid-read wrecks tonality,
  and tonality is a sales instrument. Slide boundaries and HOLD markers carry
  the pacing.
- **No developer talk on public videos.** No state machine, array, commit,
  merge, pipeline, schema, or any metaphor a salesperson would not say on a live
  call. The audience is normal people. Making complex things simple is the moat.
- **The skin is verified in the output bytes**, never assumed. Before a render
  or reader reaches the owner's screen, grep the output for the brand's declared
  colors and font, and for any banned leftover from an older look.
- Finished renders land in the video's OWN folder: `production/<video-name>/out/`.
  1 video = 1 self-contained folder. Never reuse an existing filename.
- Screen clips and raw footage stay out of version control. Docs and stills are
  tracked.
- Carry the **scrub line** into every spec: what is safe to show of other
  people's paid communities and tools, and what never is. Keys, customer emails,
  browser tabs you did not stage, and other people's paid content stay off
  screen.

## Log it

Session end: 1 entry in the project's `CONTEXT.md` under Next. Done, decided,
next. The line survives the session so the next one does not start blind.
