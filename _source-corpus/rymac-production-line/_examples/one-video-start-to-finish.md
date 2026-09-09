# One video, start to finish

This is a real walk down the line, with the file names you will actually see.
The brand in this example is a made-up media company. Yours goes where theirs
is. Read it once before your first video, then keep it as the reference.

The video: "Why Nobody Answers Your Follow-Up Emails". A 6 minute teaching
video for a channel that sells to small service businesses.

## Stage 0, before the line starts

The owner opens their research tool and finds the keyword. "follow up email templates",
strong volume, weak competition. The hook ties the keyword to a reason to
click: everyone sends follow-ups, almost nobody gets answers, and the fix is
backwards from what you think.

This owner runs vidIQ. It is the kit's pick if you have no tool yet:
https://vidiq.com/buildmarketclose. Any tool that shows search volume
does the job.

Keyword, hook and title get written at the top of the gameplan and LOCKED.
Nothing downstream re-researches them. You never make a video and then go
looking for traffic.

## Stage 1, the gameplan

File: `production/follow-up-emails/01-GAMEPLAN.md`

The lock block, machine-read, at the top:

    BRAND: Sharp Ladder Media
    SKIN: ladder-dark
    SURFACE: channel
    ENDS-ON: sharpladder.com
    SLUG: follow-up-emails

Under it: the locked keyword table, the audience, the ONE mechanic the video
teaches, and what is deliberately out of scope.

## Stage 2, the script

File: `production/follow-up-emails/02-SCRIPT.md`

Numbered slides, never prose:

    001. Nobody is ignoring you
    002. They forgot you exist
    003. And that is a different problem with a different fix

Every slide is a complete spoken thought. No slide over 14 words. No periods
on anything read aloud. A source audit at the bottom maps every slide range to
the file or page it came from. Every number in the file was counted by a
script, not estimated. The owner approves this file before anything else moves.

## Stage 3, the spec

File: `production/follow-up-emails/03-SPEC.md`

Line 1 names the render engine. Then the shot list, what is on screen at every
beat, the color grammar, the scrub line for anything that must never air, and
both cut points for the 2-version cut.

The spec is the stage that gets skipped on "simple" videos. The 2 videos that
ever skipped it both came back with paragraph-length slides and had to be
re-recorded. A live screen share needs the spec MORE, not less.

## Stage 4, the fold, the reader, then the recording

Files: `production/follow-up-emails/04-VO-FOLD.md`, then
`production/follow-up-emails/05-VO-READER.html`

The fold is the approved script converted to reader lines. `001.` becomes
`[001]`, nothing else changes. It sits next to the script so the generator can
read the skin off the gameplan beside it.

The reader is generated FROM the saved fold, never hand-written. Checked by
`check-reader.mjs` in the actual output bytes: skin colors, slide count, the
14 word ceiling, 1 second holds, no em dashes, no periods. It ships only on
PASS.

The owner opens the link full screen and records, clicking through slide by
slide. While they record, nothing else runs on their machine. Nothing.

## Stage 5, the storyboard

File: `production/follow-up-emails/05-STORYBOARD.md` plus the gate page.

Built from the ACTUAL recording. The audio gets transcribed word-level, then 1
table row per spoken sentence with its real timestamp. The gate page shows the
owner: open decisions first with recommendations, the runtime map, what they
did on the mic that beat the script, and the paper audit. Nothing builds past
this page until they approve it.

## Stage 6, the 90 second approval render

File: `production/follow-up-emails/out/approval-90s.mp4`

The first 90 seconds as a real playable file with sound, rendered in the
cloud. At every cut point, the frame and the words spoken at that instant were
checked against each other first. The owner watches it. Nothing full-length
renders before this file is approved.

## Stage 7, the full render

File: `production/follow-up-emails/out/follow-up-emails-final.mp4`
And: `out/follow-up-emails-clean.mp4`, the cut with no CTA for posting in
other communities.

Measured assembly. Every segment's audio gets padded to its exact frame
count. Loudness is normalized in 2 passes and re-measured on the output. Then
the cut-point audit runs on the finished bytes. Any frame showing words the
owner is not saying fails the video before they ever see it.

## Stage 8, the package

Folder: `community/packages/follow-up-emails/`

The drop post, paste-ready. 3 strategy files, each ending in a prompt the
reader can run on their own business. The term sheet. The member-builds file.
The zip. Plus the YouTube publish kit. The locked title and 2 alternates. The
description built on the owner's swipe, with real chapter timestamps. And 2
thumbnails rendered through the same system as the video.

## Stage 9, the blog post

File: written into the blog home named in `_config/my-line.md`.

The post leads with the clickable video thumbnail. It claims its own row in
the keyword map. 2 older posts get links INTO it. And it cites video moments
with timestamp links computed from the aligned slide data. The moment the owner
handed over the live link, this happened without being asked.

## What the folder looks like when it is done

    production/follow-up-emails/
      01-GAMEPLAN.md
      02-SCRIPT.md
      03-SPEC.md
      04-VO-FOLD.md
      05-VO-READER.html
      05-STORYBOARD.md
      VO.mp3
      vo-transcript.txt
      out/
        approval-90s.mp4
        follow-up-emails-final.mp4
        follow-up-emails-clean.mp4
        follow-up-emails-thumb-A.png
        follow-up-emails-thumb-B.png

Numbering can drift between videos. The stage NAMES are the truth, and
`checks/check-stages.sh` reads the names, never the digits.
