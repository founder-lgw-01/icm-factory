# Intake questions

The structure is already in how the person describes the work. Surface theirs;
do not impose one. Ask a few at a time, never all at once.

Door B (ingest) asks the same questions, but answers them from the material and
marks each answer `stated` or `inferred`.

## The 5 that decide the build

1. **What is the repeating unit of work?** An episode, a client, a report, a
   lesson, a person? 1 run of the built agent produces 1 of these.
   *If they name 3 things, the build is 3 builds or 1 is the real unit
   and 2 are stages. Settle it here.*

2. **Walk me through 1 run, start to finish.** In their words, not tidied.
   *Their pauses are stage boundaries. Where they say "and then I have to wait for"
   or "then I send it to". That is a stage edge.*

3. **Where do you stop and check something before continuing?**
   *Each of these is a human gate on the stage before it. If they say "I don't
   really stop", ask what they'd catch if they did. A build with no gates is not
   an ICM, it is a script.*

4. **What stays the same every run, and what is new every run?**
   *Same = the built agent's `_reference/` (voice, rules, schema, brand).
   New = its stage outputs. This is the factory/product split, asked in plain words.*

5. **What does done look like? What artifact leaves?**
   *If they cannot name a file that leaves the workspace, the work is not finished
   being designed. Push until a file is named.*

## The 2 that decide whether to build at all

6. **How often does this actually run?** Twice is not a pipeline. The ladder runs
   chat → saved prompt or skill → folders and 1 agent. Only climb when the rung
   below is genuinely automated and repeating.

7. **Who else touches this, and what do they need to find without asking you?**
   *This decides how much routing the build needs. If the answer is "nobody", the
   `CLAUDE.md` can be thin.*

## Follow-ups worth asking when the answer is thin

- What goes wrong most often, and at which step?
- What do you have to look up every time?
- What would you hand a new person, and what would you still have to explain?
- Is there a thing you always check that you've never written down?
- What did the last run produce? Can I see it?

## The intake.md sections, defined

`00_intake` writes these, in this order, 1 section each. Both doors produce the
identical shape; nothing downstream can tell which door was used.

| Section | Holds |
|---|---|
| **Repeating unit** | the one thing a run of the built agent produces |
| **1 run, start to finish** | the walkthrough, in the operator's words, untidied |
| **Stops** | every place a person checks something before continuing |
| **Stable vs new** | same every run (voice, rules, schema) vs new every run |
| **What ships** | the artifact that leaves the built agent |
| **Who else touches it** | and what they need to find without asking |
| **Open questions** | what the interview or the material did not settle |

Their pauses become stage boundaries. Their "I always check X before Y" becomes a
human gate. Their "it always has to sound like Z" becomes the built agent's own
`_reference/voice.md`.

## Door B: reading a folder instead of a person

Inventory before touching anything: every file, what it is, what refers to it.
Then answer the 7 questions from evidence.

- The repeating unit is usually visible as the thing the folder has many of.
- Stage boundaries show up as the order files were meant to be read in.
- What stays the same shows up as text repeated across siblings. Note every
  repetition; it is a candidate block.
- Mark every answer `stated` or `inferred`. The human check corrects the inferred
  ones; a silent inference is the failure mode of ingest.
