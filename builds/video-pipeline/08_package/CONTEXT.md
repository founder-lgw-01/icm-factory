# 08_package, the drop, the publish kit, or the page

1 job: on `SURFACE: channel`, turn the finished video into a community drop and
a YouTube publish kit. On `SURFACE: page`, build the squeeze or sales page the
video sits on. On both, the channel work first, then prompt 7b for the page.

## Inputs
- Working (this run): the finals in `../production/<video>/out/`, approved by the
  owner's word; `../production/<video>/01-GAMEPLAN.md`;
  `../production/<video>/05-STORYBOARD.md` for the chapter timestamps
- Reference (every run): `../_config/my-line.md`,
  `../skills/rymac-follow-the-production-line/SKILL.md`,
  `../skills/rymac-write-in-the-owners-voice/SKILL.md`, `../_reference/voice.md`
- Reference (by fork): channel, `../skills/rymac-package-a-video-for-your-community/SKILL.md`;
  page, `../skills/rymac-build-a-sales-page/SKILL.md` or
  `../skills/rymac-paid-traffic-landing-page/SKILL.md`, with the research file the
  owner names

Do NOT load: the render skills (rendering is over); any other video's package.

## Process
1. Fire the gate skill; refuse to run until the owner has said the final is approved.
2. Channel: build `../community/packages/<video>/`: the drop post, 2 to 5 strategy
   files that each end in a prompt a member can run, the term sheet, the
   member-builds file, the zip. Then the publish kit: the locked title and 2
   alternates, the description on the owner's swipe, chapter timestamps computed
   from the storyboard's real timestamps, the 2 thumbnails.
3. Page: the squeeze page (1 decision, the video, 1 button) or the sales page (the
   full close, the video in the hero), from the research file the owner names.
4. Every word passes `../checks/voice-check.sh` and the owner's banned list. No
   developer talk on a public surface.
5. Never invent a number. A count, a duration, a date is measured or marked UNMEASURED.

## Outputs
- `../community/packages/<video>/` with the publish kit beside it, or the page. No
  frontmatter on files members receive.

## Human check
Read the drop post and the description aloud: it is your voice, or it is rewritten.
Open the final and check every chapter timestamp against it. Then publish, and
hand over the live link: that is the approval, and stage 9 starts on it.
