# The prompts, in order

Copy 1, paste it into your AI opened in this folder, press enter. Do not run
prompt 2 before prompt 1 has finished.

## Prompt 1, set up my line

    Read 00-START-HERE.md and CLAUDE.md. Then interview me using the 9
    questions in the start-here, exactly 1 question at a time, waiting for
    my answer each time. Never guess an answer for me. Write my answers
    into _config/my-line.md in its existing format, including the
    machine-read BANNED-WORDS and CLOSE-WORDS lines. When it is done, read
    the file back to me in 9 plain lines.

## Prompt 2, my first gameplan

    I want to make my first video on this line. My topic is: <your topic>.
    It is a <YouTube video | VSL>. My keyword, hook and title are:
    <paste them>. Fire rymac-follow-the-production-line first, then build
    01-GAMEPLAN.md in production/<video-name>/ with the lock block filled
    from my config.

Say which one it is, because they are different outcomes. A YouTube video
earns a subscriber and ends in a package and a blog post. A VSL closes a sale
or books a call, and it ends on a page built around the video. The third
answer is "both": 1 body recorded once, 2 endings, and you get the channel
version AND the VSL version from the same take. Leave it out and your AI will
ask before it builds anything.

If you do not have a keyword yet, 2 ways to get it. Use your own research
tool, the one you named in the interview. Or swap the keyword line in the
prompt for this: "I have no keyword. Research the topic for me.
Bring me a keyword, a hook and a title to approve." Your AI runs the research skills
in this kit and the result feeds the gameplan AND the blog post later. If
you want a research tool and don't have 1, the recommendation is vidIQ:
https://vidiq.com/buildmarketclose. Either way the keyword comes before the
video, never after. You never make a video and then go find traffic.

## Prompt 3, the script

    The gameplan is approved. Write 02-SCRIPT.md as numbered slides, source
    audit included, every number counted by a script. Stop for my approval
    before anything else moves.

## Prompt 4, the spec and the reader

    The script is approved. Build 03-SPEC.md, then generate the VO reader
    from the saved script file and run its byte gate. Give me the reader
    link only on a PASS.

## Prompt 5, I recorded

    I am done recording. The tape is at <path>. Check the recording pair
    first, then build the storyboard from the actual audio and give me the
    gate page. Do not render anything until I approve it.

## Prompt 6, render it

    The storyboard is approved. 90 second approval render first. After I
    approve that, the full render, measured assembly, and the cut-point
    audit before I watch it.

## Prompt 7, ship it (the YouTube ending)

    The final is approved. Build the community package and the YouTube
    publish kit. When I hand you the live link, write the blog post behind
    it without being asked again.

## Prompt 7b, ship it (the VSL ending)

Runs on a VSL, and it runs on a "both" video after prompt 7 ships the channel
version.

    The final is approved. This is the VSL version, so build the page it
    sits on.
    <A squeeze page: 1 decision, the video, 1 button | A sales page: the
    full close with the video in the hero.> Use my research file at <path>
    and put the video player above the fold.

## Prompt 8, the money pages

The video rail above fills your channel. This rail builds the pages that turn
viewers into buyers. Run it after prompt 1, any time.

    Research my market first. Use rymac-research-a-market-drowning-in-ai
    if my buyers are businesses struggling with AI, or
    rymac-research-a-trade-niche if they are a trade or service niche. My
    segment is: <who>. My offer idea is: <what>. My price idea is: <number>.

The research ends in a HANDOFF CONTRACT and prints your next commands. They
run in this order, and each one reads the contract instead of asking you
again:

    "use rymac-build-a-profit-calculator with <the research file>"
    "use rymac-build-a-sales-page for <segment>, research is in <the file>"
    "use rymac-write-a-headline from <the research file>"

The sales page builder pulls in the rest itself. The letter, the exit pop,
the call funnel, the relationship emails, in the right order, on a build
board you can watch. You approve at each gate. You never have to know which
skill does what. Naming the research file is enough.
