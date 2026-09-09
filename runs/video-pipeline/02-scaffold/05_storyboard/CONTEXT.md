# 05_storyboard, built from the tape, never the script

1 job: transcribe the actual recording word-level and build `05-STORYBOARD.md`,
1 row per spoken sentence with its real timestamp, then the gate page the owner
approves before anything renders.

## Inputs
- Working (this run): `../production/<video>/VO.mp3`,
  `../production/<video>/04-VO-FOLD.md`, `../production/<video>/03-SPEC.md`
- Reference (every run): `../_config/my-line.md`,
  `../skills/rymac-follow-the-production-line/SKILL.md`,
  `../skills/rymac-edit-and-render-a-video/SKILL.md` (the 7 phases and the 12 laws)

Do NOT load: `02-SCRIPT.md` as a source of timing (the tape is the truth, and what
the owner said on the mic beats what was written); any other video; the package
and blog skills.

## Process
1. Fire the gate skill; refuse to run unless `VO.mp3` exists in the video folder.
2. Check the recording pair first: duration, a silent head, drift between screen
   and mic. A starved capture is a corrupted tape (stove 2); report it before
   building anything on it.
3. Transcribe word-level to `vo-transcript.txt`.
4. Write `05-STORYBOARD.md`: 1 row per spoken sentence with its timestamp, the
   shot from the spec, and the cut point. The voice is never cut; a pause the edit
   needs is a pause the owner already performed.
5. Write the gate page at the top of the file: open decisions first, each with a
   recommendation, then the runtime map, what the owner did on the mic that beat
   the script, and the paper audit.

## Outputs
- `../production/<video>/vo-transcript.txt`
- `../production/<video>/05-STORYBOARD.md`, frontmatter: `video`,
  `stage: 05_storyboard`, `status: draft`, `generated`, `sources`; then the gate
  page, then the rows

## Human check
Read the gate page: answer every open decision, then read the runtime map against
`vo-transcript.txt` at 3 timestamps of your choosing. Flip `status: approved`.
