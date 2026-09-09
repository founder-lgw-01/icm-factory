# Cloud rendering, set up once, before the first video

Renders never run on the recording machine. The measure is not render speed. It
is whether your machine stays yours: hard rule 4, and stove 4 in
`hard-rules.md`.

- The engine is Remotion. The video is built in code, so every video comes out
  consistent. `../skills/rymac-build-video-in-code/SKILL.md` carries the how.
- The pick is AWS. A new account starts with $100 in free credits, and a render
  costs pennies against them: a batch of 8 videos rendered for about 45 cents.
  Any render service works; the kit walks you through AWS.
- Set it up before your first video, not during it.
- The 90 second approval render (`../06_approval-render/`) and the full render
  (`../07_final-render/`) both run there, driven by
  `../skills/rymac-edit-and-render-a-video/SKILL.md`.
- While the owner records, nothing renders and nothing uploads on their machine.
