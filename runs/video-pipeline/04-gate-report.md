---
slug: video-pipeline
stage: 04_validate
status: approved
generated: 2026-09-07
verdict: pass
sources:
  - builds/video-pipeline/
  - runs/video-pipeline/03-emit-log.md
  - _reference/emission-standard.md
  - _reference/voice.md
---

# Gate report, video-pipeline

Fourth run. The first run passed every check and was blocked on cold walk
question 3: the build's `_reference/walk-test.md` named `runs/<unit>/`, a folder
this build does not have. The block `walk-test` was fixed in the factory,
`audit-builds.sh` flagged the build as trailing, and `03_emit` re-ran. See the
change-log entry of 2026-09-07, "walk-test block stops naming `runs/<unit>/`".

The second run passed every check. Then the build was copied outside the
factory and the kit's own `check-plain.sh` was run on its start page: 3 lines
failed, 1 written by the scaffold ("on one screen") and 2 inherited from the
source. This gate never ran the kit's own checks, so it could not see them.
Fixed at the scaffold (manifest repair 5), re-emitted, and the kit's check now
reports clean on that page.

The fourth run closed that gap. The gate now runs the checks the build ships
(section `self-checks`, from the manifest's `check:` lines) and reads voice law
3, digits, on the files the scaffold authored or repaired. Before the fourth
emit those 2 additions blocked the build 3 times: a heading in `PLAYBOOK.md`,
the kit's reading grade on `README.md` (the credit block carried a 20+ word
sentence and 2 words the kit calls jargon), and the kit's fragment check on a
line the scaffold wrote. Each was fixed at its home, 4 blocks and 3 scaffold
repairs, and the build re-emitted.

## The checks

`bash _system/validate.sh video-pipeline`, exit 0. All 11 sections pass:
structure, isolation, budget, routing, contracts, residue, hygiene, chain,
blocks, voice, self-checks. No failing line. `bash _system/audit-builds.sh`:
1 passing. The self-checks ran the kit's `checks/voice-check.sh` on 16 authored
or repaired pages and its 4 teaching gates on the 2 pages written for a customer.

## The cold walk, as an agent with no memory

1. **Where am I, where do I go, in the entry file plus at most 2 more reads?**
   Yes. `CLAUDE.md` says what this is and routes every task; `CONTEXT.md` shows
   the 9 stages as 1 table; any `NN_*/CONTEXT.md` is the third read.
2. **Pick a stage: exact input paths, the job, the output, the human check?**
   Yes. `05_storyboard/CONTEXT.md` names `../production/<video>/VO.mp3`, the fold
   and the spec as inputs, the skill it runs under, what it must not load, its 2
   output files with their frontmatter, and a check a person performs at 3
   timestamps of their choosing.
3. **State the build's status purely by scanning what exists?** Yes.
   `CONTEXT.md` names `production/<video>/` as the product folder 3 times,
   `checks/check-stages.sh` reads it, and `_reference/walk-test.md` now sends a
   cold agent to the product folder `CONTEXT.md` names. The 4 stage files that
   carry `status:` frontmatter and the renders that exist say where a video stands.
4. **Any routing file carrying payload, any fact stored twice?** `CLAUDE.md`
   routes and holds its `## Never` only. `CONTEXT.md` carries the status, naming
   and edit-surface conventions by design. Stored twice, declared: hard rules 1,
   3 and 5 sit in `## Never` and in `_reference/hard-rules.md`, which says so;
   the 9 stage names sit in the table, in rule 1, and in the gate skill, which is
   the source's own repetition and stays.

## Verdict: pass

The build ships when a person has done the cold walk on 1 stage they did not
write and flipped this line to `status: approved`.
