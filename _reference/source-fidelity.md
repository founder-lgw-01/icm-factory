# Source fidelity, the intent gate

Applies to every door B build, and to any door A build whose source is a working
system. The rule it enforces:

**A factory that breaks working source material is a defective factory. The
source's proven behavior outranks this factory's conventions.**

This is not the same check as
`_source-corpus/ICM-architect/references/reference-integrity.md`. That one fires
when a file **moves** and asks what pointed at it. This one fires when a file is
**rebuilt somewhere else** and asks what its shape was load-bearing for. Nothing
moves, so the move-safety gate never triggers, and the product ships broken while
the source sits untouched and correct.

## Why this exists

Recorded from the run that found it, `video-pipeline`, 2026-09-07.

The source was a video production kit with 40+ shipped videos. The plan was to
rebuild it to factory standard: 9 numbered stage folders instead of the source's
5, because ICM invariant 3 says numbering encodes order.

The source ships `checks/check-stages.sh`, a guard that catches a skipped stage.
It walks each **video** folder and matches `^[0-9]{2}-(.+-)?NAME([-.]|$)` against
the files directly inside it. Moving those files down 1 level would have made
every pattern miss. The guard would have reported clean on every video, forever.

The precise scope matters, and the first analysis got it wrong in both
directions. What is frozen is the layout **inside** `production/<video>/`. The
workspace's own 5 documentation folders are named by zero scripts and were never
load-bearing at all.

That guard exists because a skipped spec once put a 27 word slide in front of a
microphone and 47 minutes were recorded off it. The rebuild would have disabled
the protection against the exact failure the source was built to prevent, while
appearing to improve the structure.

The source also states its own reasoning in a comment: *"Read the stage NAME,
never trust the digits. Numbering varies between videos."* It had deliberately
decoupled order from numbering, because a live screen share legitimately has no
voiceover stage. ICM invariant 3 and this source disagree, and **the source was
right for its job.**

Nothing in the factory would have caught this. It surfaced because the operator
asked what the change would cost.

## The gate

Before proposing any structural change to source material, answer all 4. In
writing, in `01-plan.md`. An unanswered question is a blocked plan.

**1. What in the source is load-bearing?**
List every script, gate, check, generator and config the source ships, and what
each one keys on: a filename pattern, a folder depth, a relative path, a
frontmatter field, a naming convention. These are the things a restructure
silently breaks. Read the scripts. Do not infer from filenames. Then read the
files that invoke them: a script's path assumptions are usually documented in the
skill that calls it, and a walk-up search for a config is invisible in a filename.

**2. What breaks if the proposed structure ships?**
For each item in 1, state whether the proposal breaks it, and how. "It still
works" needs the reason. A guard that fails **open**, reporting clean when it can
no longer see its target, is the worst case and must be named explicitly.

**3. What does the source do differently from this factory's conventions, and
was it right?**
Every deliberate divergence is evidence. A working system that contradicts an
invariant usually knows something about its own domain. Find the reason before
overruling it. Where the source is right, the factory yields.

**4. What does the build actually add?**
If the answer is "conformity to our conventions", stop. That is not a reason to
rebuild a working system. Name the capability the source lacks, or recommend
leaving it alone.

## The verdict is per-thing, not per-source

A source is not one decision. Run the 4 questions against each part
independently, because the answers differ.

The run that produced this file is the example. Its source had 3 structures
that looked like 1:

| Part | Load-bearing? | Verdict |
|---|---|---|
| `production/<video>/` file layout | yes, a gate script matches `NN-NAME` on files directly inside | frozen, cannot change |
| the 5 documentation folders | no script, but 2 files point at them: a skill names `04-EDIT/README.md`, the root `CLAUDE.md` routes to `01-RESEARCH/` | free to change if both referrers move in the same change |
| `_config/my-line.md`, above `production/`, under that name | yes, both reader scripts walk up 6 levels to find it and the byte gate fails closed without it (`--config=` is the only override) | frozen, cannot move or rename |

The first analysis collapsed the first 2 rows into a single "keep the source's
shape" recommendation. That was wrong, and it was the same error in reverse:
replacing 1 default with another instead of reading the evidence per part. The
second analysis missed the third row entirely, because it read the scripts and
not the skill that documents how they find their config.

**Freeze what is load-bearing. Everything else is decided by the work.**

## The verdicts

`01_form` records one of these per part, with the evidence from the 4 questions:

- **leave-alone.** The source works and the build adds nothing it lacks. Say so
  and stop. ICM's own guardrail: a workspace for a thing done twice is
  scaffolding, not architecture. A workspace that has run 40 times does not
  need re-founding.
- **additive.** Keep every folder, filename, script and path exactly as the
  source has them. Add only what is genuinely missing, usually the per-stage
  `CONTEXT.md` with its `Do NOT load:` line. Nothing moves, so nothing breaks.
  Correct for a load-bearing part. It is **not** a safe blanket default: applied
  to a part nothing depends on, it freezes an accident of history.
- **rebuild.** Restructure. Permitted only when question 2 comes back clean, or
  when every break is listed with its repair in the same plan. A rebuild that
  cannot enumerate what it breaks is not approved.

## 2 ways to get this wrong

**Conformity.** Restructuring because an invariant says so, breaking a guard the
source needed. This is the failure the gate was written for.

**Deference.** Preserving a shape because the source has it, when nothing depends
on it and the work wants a different one. A working system is evidence about the
parts that carry load. It is not evidence about the parts that were never tested,
and "it has always been this way" is not a finding.

Both substitute a default for reading the evidence.

## The rule under all of it

The factory's conventions exist to make a workspace legible to an agent. They
were never evidence about the domain, and neither was the source's filing habit.

Structure is an output of the analysis, not an input. Not 5 stages because the
source has 5 folders. Not 9 because there are 9 steps. However many places the
work genuinely stops, which is a thing you count, not a thing you assume.

Where the source is load-bearing, it wins and the divergence gets written down.
