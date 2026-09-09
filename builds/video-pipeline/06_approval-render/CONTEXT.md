# 06_approval-render, the first 90 seconds

1 job: render the first 90 seconds as a real playable file with sound, in the
cloud, every cut point checked frame against words, and stop until the owner has
watched it.

## Inputs
- Working (this run): `../production/<video>/05-STORYBOARD.md` (requires
  `status: approved`), `../production/<video>/03-SPEC.md`,
  `../production/<video>/VO.mp3`
- Reference (every run): `../_config/my-line.md`,
  `../skills/rymac-follow-the-production-line/SKILL.md`,
  `../skills/rymac-edit-and-render-a-video/SKILL.md`,
  `../skills/rymac-build-video-in-code/SKILL.md` and
  `../skills/rymac-build-video-in-code/rules/`, `../_reference/cloud-rendering.md`

Do NOT load: the package and blog skills; any other video's
`../production/<other>/out/`.

## Process
1. Fire the gate skill; refuse to run unless `05-STORYBOARD.md` says `status: approved`.
2. Compose the cold open from the storyboard rows and the spec's shots. The skin
   comes from the config; grep the output for its declared colors and font.
3. At every cut point in the first 90 seconds, check the frame against the words
   spoken at that instant.
4. Render in the cloud. The owner's machine stays free. Never render locally.
5. Check the number, not the exit code: compare the output duration against the
   audio and sample frames at the cut points. Render bugs succeed wrongly more
   often than they fail.

## Outputs
- `../production/<video>/out/approval-90s.mp4`. No frontmatter: it is video. The
  owner's word approves it, and the final render's existence is the record.

## Human check
Watch the 90 seconds end to end with sound. Every frame shows words you are saying
at that instant, in your colors. Say "the 90 seconds is approved" in the session.
Nothing full-length renders before you do.
