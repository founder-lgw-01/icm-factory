---
name: rymac-edit-and-render-a-video
description: The MANDATORY 7-phase editing procedure for every video on the line - storyboard built from the actual recording, paper audit against the laws, the owner's storyboard gate, mechanical word-level alignment, a 90-second approval render BEFORE any full render, measured assembly (per-segment A/V parity, 2-pass loudness), and a cut-point audit of the finished file. Use whenever any video work touches timing, rendering, or assembly - "align the VO", "render the video", "stitch it", "assemble the final", "re-render", "fix the video", "sync the slides", building visuals under a recording, or marrying screen and camera files. Make sure to use this skill EVERY single time video editing, aligning, rendering, or stitching begins, even when nobody names it - it fires alongside rymac-build-a-youtube-video and rymac-write-a-slide-video-script, and it exists because skipping it once cost 5 re-renders in a single night.
---

> ⛔ **BEFORE THIS SKILL DOES ANYTHING, the production line gets read out loud.**
> Fire `rymac-follow-the-production-line` first. It posts the 9 stages, names the
> 5 skills, marks where this job starts, and waits for the owner's go.
> The 5 that fire on any video: `rymac-build-a-youtube-video`,
> `rymac-write-a-slide-video-script`, `rymac-edit-and-render-a-video`,
> `rymac-write-in-the-owners-voice`, `rymac-make-a-reader-to-record-from`.
> None of them wait to be named.

# The 7-phase edit procedure

Edit like a world-class editor. Every check verifies the VIEWER's experience,
picture and sound together, in time, against the owner's actual voice. Never the
builder's intent. A still frame proves composition. Only a timestamped frame
checked against the words being spoken at that instant proves an edit.

## ⛔ LAW 0: RENDERS RUN IN THE CLOUD. THE OWNER'S MACHINE STAYS FREE.

The measure is not the clock. It is whether the owner can use their computer.

A 13 minute local encode is 13 minutes they cannot work. An upload runs in the
background and they keep working. **A slower job in the cloud beats a faster job
on their machine, every single time.** They are not buying speed. They are buying
their machine back.

| Job | Where |
|---|---|
| Any full or approval render | **cloud** |
| Assembling a screen share, cutting, speed ramps, overlays | **cloud** |
| Stitching, concat, loudness on a long file | **cloud** |
| A single still frame check | local, allowed, it is seconds |
| Probing, measuring, reading bytes | local, allowed, it is instant |

"The cloud cannot do this one" is almost always false and must be proven, not
asserted. A render engine plays video files, so a screen share with speed ramps
and overlays IS a composition. If you genuinely believe a job cannot go to the
cloud, say so and ask the owner before doing it locally. Never decide it quietly.

Setup for cloud rendering lives in `_reference/cloud-rendering.md`. The recommended home
is AWS, where a new account starts with $100 in free credits and a render
costs pennies against them. Two standing habits that
save real money and time: after every deploy, verify the assets actually landed
before spending a render, and capture the FULL render log to a file so an error
line can never be eaten by a filter.

## ⛔ LAW 0a: WHEN THE OWNER IS RECORDING, THEIR MACHINE IS THEIRS. NOTHING RUNS.

This law is the twin of Law 0, and it is worse. A background job while they
record CORRUPTS THE TAPE THEY ARE MAKING, and nobody finds out until the render
is built and they are watching it.

The proof: a 17 minute take was recorded while a session copied a large file and
pushed a multi-gigabyte upload off the same machine. The capture starved. It
produced 6 seconds of black at the head of the recording under the voice, and a
5 second drift between the screen file and the mic file, because the recorder
kept the screen clock running while it dropped frames. It looked like a failing
computer. It was the background jobs.

What to do, and it is not complicated:

1. **The moment the owner says they are recording, about to record, or going to
   shoot: STOP. Finish nothing, start nothing.** No uploads, no deploys, no file
   copies, no transcription, no renders. Say the machine is theirs and wait.
2. **Kill what is already running.** A backgrounded upload does not politely
   idle. Stop it, and say it is stopped.
3. **Anything that truly cannot wait gets their explicit say-so first**, and
   even then it is the smallest possible job. Never an upload or a big copy.
4. **When they say they are done, check the pair before building anything.**
   Probe both file durations and flag any gap over half a second, then run a
   black-frame detect on the head of the screen file. Those 2 checks take 20
   seconds and catch exactly the damage this law prevents.

A roped machine costs an hour. A starved capture costs the take, and the owner
only finds out after 2 renders and an evening of being told it is finished.

## ⛔ LAW 0b: THE STORYBOARD GATE IS THE SAME PAGE EVERY TIME

Phase 3 delivers ONE fixed shape. Never redesign it per video, never improvise a
new layout:

1. **The open DECISIONS first**, numbered D1, D2, D3, each with a marked
   recommendation, so the owner can answer in 2 minutes without reading the rest.
2. **The pickup list**, if there are pickups: old line struck, new line under it,
   exact timestamps.
3. **The RUNTIME MAP.** One horizontal bar per section, length proportional to
   seconds, color-coded by treatment, with a key showing totals.
4. **What the owner did on the mic that beat the script**, quoted with timestamps.
5. **The paper audit**, pass or fail against the laws.
6. **What is next**, one line.

Styled in the brand's skin, delivered as a page the owner can read on a phone,
never a raw text file. The markdown storyboard stays in the video folder as the
build record.

## The laws that bind every frame

1. **The verbatim rail.** Wherever the owner talks without b-roll, the screen
   shows the words they are saying, sentence by sentence, in their cadence. A
   spec's beat table is emphasis ON TOP of this rail, never a replacement. 40
   spoken sentences never get 15 visuals.
2. **No orphaned words.** A slide that wraps with 1 word alone on a line is a
   defect. Enforce balanced text wrapping in code on every text node, and
   hand-break lines on the slams.
3. **Never a visual before the line that explains it.** And while b-roll is up,
   what the b-roll SHOWS must match what is being SAID at that instant.
4. **No black screen while the owner talks** unless the storyboard names the
   black and says why.
5. **The skin is DECLARED, never assumed.** Read the lock block in
   `01-GAMEPLAN.md`. If the block is missing, stop and ask. `SURFACE:` decides
   the close, not the skin. A page video above an email box carries no channel
   close. A channel video carries it in full.
6. Digits always, no em dashes, no developer talk on screen, the declared skin's
   font for slide text, and every hold scripted with its duration.
7. **No silent patches.** A mid-build discovery goes back to the storyboard and
   gets said out loud. Never hide a planning miss inside a render trick.
8. **⛔ THE OWNER'S VOICE IS NEVER CUT. Not once, not for a hold, not by a
   frame.** The take goes into the build in one piece. A hold the edit needs is
   a hold they ALREADY PERFORMED: prove it is on the tape and move the SLIDE
   into it. Never push new silence into their audio.
   - **A transcription word time is never a safe place to cut.** Word-level
     transcribers report onsets 50 to 430 milliseconds late and stretch the last
     word of a phrase to swallow the pause behind it. Cutting at the reported
     start lands INSIDE the next word and sounds like a stutter.
   - **Measure silence off the waveform, not off the transcript.** Silence
     detection at -42dB is the fact. Glue halves separated by a sub-60ms breath
     into the one pause the owner actually took, then park the slide boundary in
     the MIDDLE of it.
   - **If a scripted hold is NOT on the tape, flag it and stop.** Re-record the
     beat or shorten the hold. Never manufacture it.
   - **Audio that has to be ADDED is MIXED ON TOP inside a pause they left.**
     Delay and mix, never concat. A mix cannot chop a word. A splice can.
9. **The middle of the screen is NEVER blank.** The spoken line sits at eye
   level unless a visual owns the middle of the frame. A caption pinned to the
   bottom is only legal when a picture fills the center. Audit every scene type
   for its empty state. The empty state gets the centered line too.
10. **The color grammar on every slide: bad is RED, good is GREEN, and anything
    quoted is LINK BLUE.** Spoken quotes, call scripts, email scripts, the
    quoted span renders blue on every surface. Internal build markers never
    appear on a rendered frame.
11. **A number said out loud goes on the screen.** If the owner says a figure, a
    time, or a name while pointing at a screenshot, that exact thing gets ringed
    and labeled. A generic highlight over the right region is not an answer.
12. **⛔ THE 5 SECOND CEILING ON EVERY SPED-UP SPAN.** A speed ramp on a live
    tape lands at 5 viewer seconds or less. Pick the multiplier by doubling
    until it clears the ceiling, never by picking a number that looks
    reasonable. This is a retention law. A viewer watching a counter tick for 10
    seconds is a viewer deciding whether to leave. And nothing is ever deleted
    to hit the ceiling. Law 8 holds. The speed goes up instead.

## The 7 phases, copy this checklist and tick it off

- [ ] **1. Storyboard from the ACTUAL recording.** Transcribe the real audio at
  word level first. Build 1 table, 1 row per spoken sentence: start timestamp
  from the transcript, the verbatim on-screen text with line breaks written out,
  or the named visual with what it shows at entry, sync, and exit. Every second
  of runtime has a row. The script and the spec are inputs. The recording is the
  source of truth.
- [ ] **2. Paper audit.** One pass over the storyboard against the laws above,
  in text, before any code. This is where wrong-visual-under-wrong-words dies
  for free.
- [ ] **3. The owner's storyboard gate.** The fixed page from Law 0b. Red ink
  lands here, not on a render. Do not build past this gate.
- [ ] **4. Mechanical alignment, verified as data.** Every row's timestamp comes
  from matching its words in the transcript, tolerant of riffs and mishears. A
  row that cannot match is FLAGGED and shown, never guessed. Print slide text
  next to spoken words for every row and read every line. Then run the pause
  proof from law 8: for every scripted hold, print what the script asked for
  next to what the owner actually read on the waveform. If the audio plan
  contains a single splice in their voice, the build stops.
- [ ] **5. The 90-second approval render.** Render the first or riskiest 90
  seconds as a real playable file WITH sound. Run the mechanical check first: at
  EVERY cut point, extract the frame and the words spoken at that exact moment.
  They must match. All cuts, not a sample. Then the owner watches it. **Nothing
  full-length renders before this file is approved.**
- [ ] **6. Full render and measured assembly.** Before concat, measure every
  segment's audio length against its video length and pad explicitly to the
  exact frame count. Unpadded concat slides the audio rail early. Loudness is a
  2-pass measured normalize per talking segment, then re-measure the OUTPUT:
  within half a unit of target, true peak at or below -1.0. Frame and
  audio-onset check at every seam.
- [ ] **7. Cut-point audit of the FINAL file, then the owner watches once.**
  Repeat the phase 5 check on the finished file at every cut. Any frame showing
  text the owner is not saying at that moment fails the video before they ever
  see it. Then the audio half, run on the BYTES of the deliverable: map its
  silence, map the raw tape, and prove that no scrap of sound under 600
  milliseconds sits alone between 2 pauses unless it is a breath on the raw
  tape, and that every quiet moment in the output is a quiet moment the owner
  performed. Report dead air over 2.5 seconds with its timestamp so a human
  decides. An audit you wrote is worth nothing until you rebuild the broken
  version and watch it FAIL on purpose first.

## ⛔ When the owner reports a defect on a FINISHED video: ship the fix, then talk

The 7 phases govern BUILDING a video. They do not govern fixing one the owner
already watched. There, the only deliverable is the corrected file.

1. **Read their entire list first, change everything, render ONCE.** A second
   render cycle has a real cost. A polish you spot halfway through goes in the
   SAME pass or it waits.
2. **Verify the exact thing they complained about, on the finished file. Then
   hand it over.**
3. **Root cause, regression checks, and process fixes come AFTER they have the
   file**, and only if they ask. Offer it in 1 line.
4. **Say the number out loud the moment a time estimate is about to blow.**

The failure this rule prevents: 5 defects reported, 70 seconds of actual render
time needed, 2 hours delivered, and a missed posting window, because the session
rebuilt tooling before the owner had a playable file.

## Recording-file gotchas, checked, not remembered

- Screen recorders often write 2 files: screen with a DEAD silent audio track,
  and camera with the real mic. Volume-check BOTH before trusting either. Align
  the pair at zero. The length difference is teardown at the tail.
- Grep the take's transcript for verbal edit markers ("cut that", "note", the
  AI's name) before declaring it zero-cut. Owners call out edits on the mic.
- Word-level transcribers pad a blank tail past the file end. Cap durations at
  the measured file length, never at the transcriber's last token.

## When it fires

This procedure governs the render and assembly half of
`rymac-build-a-youtube-video` and any slide video from
`rymac-write-a-slide-video-script`. Fire it the moment timing, rendering, or
assembly work starts. If a phase is about to be skipped for speed, that is the
moment it is needed most. The expensive nights trace to skipped phases, not
missing skills.
