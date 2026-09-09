# 02_script, numbered slides the owner approves

1 job: turn the approved gameplan into `02-SCRIPT.md`: numbered slides, 1
complete spoken thought each, 14 words or fewer, every number counted by a script.

## Inputs
- Working (this run): `../production/<video>/01-GAMEPLAN.md` (requires `status: approved`)
- Reference (every run): `../_config/my-line.md`,
  `../skills/rymac-follow-the-production-line/SKILL.md`,
  `../skills/rymac-write-a-slide-video-script/SKILL.md`,
  `../skills/rymac-write-in-the-owners-voice/SKILL.md`, `../_reference/voice.md`
- Reference (on demand): `../skills/rymac-build-a-youtube-video/SKILL.md`, the 7 hard rules

Do NOT load: any `03-SPEC.md` (the spec follows the script, never leads it); the
render skills; any other `../production/<other>/`.

## Process
1. Fire the gate skill; refuse to run unless `01-GAMEPLAN.md` says `status: approved`.
2. Re-read the gameplan from disk. HOOK, then STORY, then TEACH, then CLOSE. The
   story frames the teach and comes before it.
3. Write the slides as `NNN.` lines: 1 complete spoken thought, 14 words or fewer,
   no period on anything read aloud, no em dash, numbers as digits. On
   `SURFACE: channel`, end on the 3 close beats from the config. Mark every
   channel-only stretch, and the split when `VSL-TAIL: yes`.
4. Close with the source audit: every slide range mapped to the file or page it
   came from. Count every number in the file with a script, never by eye.
5. Run `bash ../checks/voice-check.sh ../production/<video>/02-SCRIPT.md`. A
   failing law is a stop, not a note.

## Outputs
- `../production/<video>/02-SCRIPT.md`, frontmatter: `video`, `stage: 02_script`,
  `status: draft`, `generated`, `sources`; then the slides and the source audit

## Human check
Run the voice check yourself, then read every slide aloud against the gameplan's
1 mechanic: each is a thought you would say on a live call, or it is rewritten.
Flip `status: approved`.
