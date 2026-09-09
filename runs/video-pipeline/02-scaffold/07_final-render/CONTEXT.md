# 07_final-render, measured assembly and both cuts

1 job: render the full video, loudness normalized on the output, every segment
padded to its exact frame count, then audit the cut points on the finished bytes.
The channel cut, the clean cut, and the VSL cut when the lock block says so.

## Inputs
- Working (this run): `../production/<video>/out/approval-90s.mp4`, approved by
  the owner's word; `../production/<video>/05-STORYBOARD.md`,
  `../production/<video>/03-SPEC.md`, `../production/<video>/01-GAMEPLAN.md`
- Reference (every run): `../_config/my-line.md`,
  `../skills/rymac-follow-the-production-line/SKILL.md`,
  `../skills/rymac-edit-and-render-a-video/SKILL.md`,
  `../skills/rymac-build-video-in-code/SKILL.md` and
  `../skills/rymac-build-video-in-code/rules/`

Do NOT load: the package and blog skills; any other video.

## Process
1. Fire the gate skill; refuse to run until the owner has said the 90 seconds is
   approved in this session. Do not infer it from the file existing.
2. Measured assembly: every segment's audio padded to its exact frame count.
   Loudness normalized in 2 passes and re-measured on the output.
3. Cut the versions the lock block asks for: `<video>-final.mp4` with the standing
   close and the end card; `<video>-clean.mp4` with every channel-only stretch
   lifted out at the silences the owner left; on `VSL-TAIL: yes`, the VSL version
   that hands to the page.
4. Render 2 thumbnails through the same system as the video, so the text is crisp.
5. Run the cut-point audit on the finished bytes. Any frame showing words the
   owner is not saying fails the video before they see it. Compare output
   duration against the audio.

## Outputs
- `../production/<video>/out/`: `<video>-final.mp4`, `<video>-clean.mp4`,
  `<video>-thumb-A.png`, `<video>-thumb-B.png`, and the VSL cut when asked. No
  frontmatter: video and images. The owner's word approves the final.

## Human check
Watch the final after the cut-point audit passes, at full length, then the clean
cut's ending. Say "the final is approved". Stage 8 begins on those words and not
before.
