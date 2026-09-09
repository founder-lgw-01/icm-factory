# 00_intake, idea or folder to 1 normalized brief

1 job: get whatever the operator has (a spoken idea, or a folder of existing
files) into a single `00-intake.md` that the rest of the line reads. 2 entry
doors, 1 exit.

## Inputs
- Working (this run), **door A (idea)**: the operator, interviewed live. No file input.
- Working (this run), **door B (ingest)**: exactly 1 folder, named by the operator,
  usually `../../_source-corpus/<tool>/`
- Reference (every run): `../../_reference/intake-questions.md`, `../../_reference/voice.md`
- Reference (on demand, door B only): `../../_source-corpus/ICM-architect/references/reference-integrity.md`

Do NOT load: more than 1 `_source-corpus/` folder, `../../_reference/blocks/`
(that is emission material, not intake material), `../../_templates/`, any
`../../builds/` folder, any other run in `../../runs/`.

## Process
1. Ask the operator which door. If they named a folder, it is door B.
2. **Door A (idea).** Work through `intake-questions.md`. Ask a few at a time,
   never all at once. Surface the structure already in how they describe the work;
   do not impose your own.
3. **Door B (ingest).** Inventory the folder before touching anything. Read the
   material, answer the same questions from evidence, and mark every answer
   `stated` or `inferred`. Never silently fill a gap.
4. Name the build. Lowercase, no spaces, no punctuation. This slug is permanent,
   it is the folder name in `builds/` and appears in every downstream output.
5. Write `00-intake.md`. Both doors produce the identical shape; nothing downstream
   can tell which door was used.

## Outputs
- `../../runs/<slug>/00-intake.md`, frontmatter: `slug`, `stage: 00_intake`,
  `status: draft`, `generated`, `sources` (door B: every file read; door A: `interview`),
  `door` (`idea` | `ingest`).

  Body, in this order, 1 section each: **Repeating unit** · **1 run, start to
  finish** (in the operator's words) · **Stops** · **Stable vs new** ·
  **What ships** · **Who else touches it** · **Open questions**. The sections are
  defined in `intake-questions.md`.

## Human check
Read **Repeating unit**, **Stops**, and **What ships**: those 3 decide the
whole build. Confirm the repeating unit is 1 thing and not 3, and that every
stop is a real place you stop rather than a place you imagine stopping. On door B,
check every `inferred` line against the source material. Answer or strike each
open question. Flip `status: approved`.
