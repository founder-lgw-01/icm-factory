# The hard rules, and the stoves behind them

The 10 rules the line runs by. Each exists because skipping it broke something
real; the stove that taught it is named. Rules 3, 5 and 1 are also in the entry
file's `## Never`, because they are the costliest to break.

## The rules

1. **The 9 stages run in order and none gets skipped.** Gameplan, Script, Spec,
   VO, Storyboard, 90s, Render, Package, Blog. Read stage names off the files on
   disk, never trust the number prefixes.
2. **Re-read the owner's file from disk before building anything off it.** They
   edit files directly and save. The copy in your context is stale the moment
   they touch it.
3. **While the owner records, nothing runs on their machine.** Stop every job and
   say so.
4. **Renders run in the cloud.** The owner's machine stays free.
5. **The owner's voice is never cut.** Not by a frame.
6. **1 video = 1 self-contained folder** under `../production/<video>/` with its
   own `out/`.
7. **No em dashes. Numbers as digits. No developer talk on public surfaces.** The
   owner's own banned words live in the config.
8. **Never invent a number.** Count it, measure it, or mark it UNMEASURED.
9. **Checks run before delivery**: `../checks/check-stages.sh` for gaps,
   `../checks/voice-check.sh` for the voice laws, the reader's own
   `check-reader.mjs` for the bytes. A failing check is a stop, not a note.
10. **Session end: write 1 line under `## Next` in `../CONTEXT.md`.** Done,
    decided, next. The next session starts there instead of blind.

## The 6 stoves

**1. The skipped spec.** A live screen share looked too simple to spec. The reader
came back with a 27 word slide and it reached the microphone; 47 minutes were
recorded off it. Lesson: the simple video needs the spec more. The gap checker
refuses to walk past a missing stage.

**2. The starved recording.** A 17 minute take was recorded while background jobs
copied files and pushed an upload on the same machine. 6 seconds of black under
the voice, a 5 second drift between screen and mic, found after 2 renders.
Lesson: while you record, nothing runs.

**3. The spliced voice.** An edit inserted holds on top of pauses the take already
had, and 4 cuts landed inside words, in the hook. Lesson: the voice is never cut.
A pause the edit needs is a pause already performed. Prove it on the waveform.

**4. The frozen laptop.** A local render roped all 8GB of memory; 2 renders back
to back burned 90 minutes of a same-day upload window. Lesson: renders leave the
machine. Your free machine is the measure, not the clock.

**5. The stale script.** A reader got built from the script in the AI's memory
instead of the saved file, and shipped missing a beat the owner had added.
Lesson: the file on disk is the only truth, even 2 minutes after writing it.

**6. The invented number.** A page passed every automated check and still held 8
made-up figures. Lesson: a number is counted, measured, or it does not ship.
