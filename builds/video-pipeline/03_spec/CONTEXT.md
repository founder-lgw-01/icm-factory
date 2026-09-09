# 03_spec, the stage everyone skips

1 job: write `03-SPEC.md`, the render engine on line 1, then every shot, every
color rule, the scrub line, and both cut points. The 2 videos that ever skipped it
were both re-recorded.

## Inputs
- Working (this run): `../production/<video>/02-SCRIPT.md` (requires `status: approved`),
  `../production/<video>/01-GAMEPLAN.md`
- Reference (every run): `../_config/my-line.md`,
  `../skills/rymac-follow-the-production-line/SKILL.md`,
  `../skills/rymac-build-a-youtube-video/SKILL.md` (RULE 0 and the 7 hard rules)
- Reference (on demand): `../skills/rymac-build-video-in-code/SKILL.md` and
  `../skills/rymac-build-video-in-code/rules/`, for the engine's own rules on the
  shots the spec names

Do NOT load: the fold or the reader of any video (they follow the spec); the edit
skill; any other `../production/<other>/`.

## Process
1. Fire the gate skill; refuse to run unless `02-SCRIPT.md` says `status: approved`.
2. Line 1 after the frontmatter names the render engine.
3. Walk the script slide by slide: what is on screen at every beat, running text
   in the owner's cadence wherever they talk with no b-roll, never a visual before
   the line that explains it, captions on for any screen clip.
4. Write the color grammar from the skin in the config, the scrub line (what must
   never appear on screen: keys, customer emails, unstaged tabs, other people's
   paid content), and both cut points for the 2-version cut.
5. A live screen share gets the fullest spec, not the thinnest. It is where the
   27 word slide came from.

## Outputs
- `../production/<video>/03-SPEC.md`, frontmatter: `video`, `stage: 03_spec`,
  `status: draft`, `generated`, `sources`; line 1 of the body names the engine

## Human check
Read line 1 for the engine. Then take every slide range in the script and find its
shot in the spec; a range with no shot is a gap. Confirm the scrub line names what
never airs. Flip `status: approved`.
