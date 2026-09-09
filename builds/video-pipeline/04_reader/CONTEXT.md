# 04_reader, the fold, the reader, then the recording

1 job: fold the approved script into reader lines, generate the reader from the
saved fold, prove its bytes, and hand the owner a link only on a PASS. Then they
record, and nothing else runs.

## Inputs
- Working (this run): `../production/<video>/02-SCRIPT.md` and
  `../production/<video>/03-SPEC.md` (both `status: approved`)
- Reference (every run): `../_config/my-line.md`,
  `../skills/rymac-follow-the-production-line/SKILL.md`,
  `../skills/rymac-make-a-reader-to-record-from/SKILL.md`, with `make-reader.mjs`
  and `check-reader.mjs` beside it

Do NOT load: anything under `../production/<video>/out/`; the edit skill (the
storyboard waits for the tape); any other video.

## Process
1. Fire the gate skill; refuse to run unless both inputs say `status: approved`.
   `check-reader.mjs` refuses on its own when no `*-SPEC.md` sits in the folder.
2. Re-read `02-SCRIPT.md` from disk, never from memory (stove 5). Write
   `04-VO-FOLD.md`: `# title`, a `> ENGINE:` note, then `[001]` for `001.` and
   nothing else changed. No frontmatter: the generator reads this file line by line.
3. Run `make-reader.mjs` on the fold. It walks up to `../_config/my-line.md` for
   the skin; a fallback palette is a stop, not a warning.
4. Run `check-reader.mjs` on the fold and the reader. Give the owner the link only
   on PASS. A FAIL is fixed in the fold or the config, then re-run.
5. The owner records full screen, clicking slide by slide, 1 second holds. While
   they record, nothing runs on their machine. Stop every job and say so.
6. The tape lands as `../production/<video>/VO.mp3`.

## Outputs
- `../production/<video>/04-VO-FOLD.md`, `05-VO-READER.html`, `VO.mp3`. No
  frontmatter on any of them: the scripts parse the first 2, the third is audio.

## Human check
Open the reader only on a PASS from `check-reader.mjs`: the first slide wears your
colors and your font. Record with nothing else running. Confirm `VO.mp3` sits in
the video folder. The tape is the approval; there is no line to flip.
