---
name: rymac-package-a-video-for-your-community
description: Turns a finished YouTube video, lesson, or live session into a downloadable community package (drop post + strategy files each ending in a copy-paste prompt + term sheet + member-builds file + zip) AND a YouTube publish kit (the locked keyword + 3 title options + a description with real chapter timestamps + 2 rendered thumbnails). Use when the user asks to "package a video", "make the drop post", "build the session package", needs a "YouTube title", "video description", or "thumbnail", or after any video ships. Make sure to use this skill whenever a video, lesson, or session is being packaged for a community or prepped for YouTube.
argument-hint: [which video/session, and the source script or transcript path]
---

# The session package

Every piece of content becomes a package members hand to their own AI. The bet:
recordings are worth more given away and structured for an AI than hidden. The
video is the lecture. The package is the library card.

The owner's community platform, links and tag set live in `_config/my-line.md`.
Read them first.

## Inputs

1. The source of truth: the video's script or the session transcript. The
   transcript is a data event that feeds the build.
2. The marks: what the owner says mattered. If they have not marked topics,
   propose the topic list FROM the chapter structure and get their yes before
   writing. Their marks are the spec, not the transcript's word count.

## The package, one folder, then one zip

Build in `community/packages/<slug>/`:

1. **DROP-POST.md.** The community post. One-paragraph story recap of the
   session, imperfections included, they humanize. Then THE FILES, one block
   per file: what it is plus what the prompt at the end does. Then HOW TO USE
   THESE: pick the file that matches what you are working on, paste it into
   your AI with your own context, run the prompt. Then WHAT'S NEXT, the next
   video tease. Then the zip line. Name which file to start with.
   **PASTE-READY is mandatory.** Most community editors are plain text, so the
   post body has NO hard line-wraps (every paragraph is ONE long line), no
   markdown syntax that renders literally, section headers in Unicode bold,
   simple bullets, and divider lines. One HTML comment at the top may carry
   paste instructions. Everything below it must be paste-and-done.
2. **Strategy files, 2 to 5.** One per marked topic, NOT one per chapter.
   Each: the teaching in the owner's plain words, grounded in the real numbers
   and examples from the video, ending with **"Run this prompt"**: a fenced
   copy-paste prompt that applies the lesson to the reader's own business.
   The prompt is the product. The essay is packaging.
3. **term-sheet.md.** Every term of art used in the video, one line each,
   plain language. Cheap to make, huge for beginners.
4. **member-builds.md.** The room record. One block per member who built or
   said something worth keeping, names kept because it lives inside the
   community. Ships mostly empty with instructions and gets updated as members
   post. This file is the belonging engine. People share more when they see
   themselves in the record.
5. **The zip.** Package the folder (strategy files + term sheet +
   member-builds + assets; DROP-POST.md stays out, it IS the post). Forward
   slashes in every entry, then read the zip back before calling it done.

## The YouTube publish kit, every video, without being asked

If the packaged thing is a video, it also ships to YouTube, so produce this
alongside the package by default. Deliver it as a copy-paste page. Four parts:

1. **The keyword and title are the OWNER'S, already locked.** Read the video's
   `01-GAMEPLAN.md` FIRST. The locked keyword, hook and title live at the top
   and are the law. The traffic plan precedes the video. Use them VERBATIM.
   NEVER re-research or override a locked title. That exact mistake once
   shipped a wrong kit. Only if the gameplan truly has no locked keyword:
   research one, propose long-tail over red ocean, and FLAG it as unlocked
   for the owner's call.
2. **The locked title first, plus 2 alternates**, marked as alternates only,
   keyword front-loaded, under 70 characters where possible. Alternates exist
   for tests, never as pressure to change the locked title.
3. **A description built EXACTLY on the owner's swipe.** The first time
   through, help them write `_config/my-yt-description-swipe.md` from a
   description they already published and liked. After that the swipe is the
   law. The rules that hold either way: the keyword in the FIRST sentence and
   again near the last, the owner's own links first, affiliate links ALWAYS
   the last links above the tags, short single-thought lines with a blank
   line between thoughts, and CHAPTERS with REAL computed timestamps.
   Pull chapter times from the render data, never guess: cumulative-sum the
   slide durations at each section start, format m:ss, first chapter 0:00.
   Tags come from the owner's standing set in the config, never in the title.
4. **2 thumbnails, 1280 x 720, rendered through the SAME pipeline as the
   video** so the text is crisp. AI image generation mangles type. Never use
   it here. Build 2 components off the owner's thumbnail pattern, render
   stills, give one a keyword eyebrow plus curiosity headline and the other
   the pain hook in the owner's own words. Embed small previews so they can
   pick, and print the full-size paths to upload.

Shorts cut from the video get the same treatment per short, plus a note on
which shorts point to the long-form and which point to the community.

## The video-boost blog post, every live video link, without being asked

The moment the owner hands over the live YouTube link:

1. **Write the video ID into the content ledger** and swap the live link into
   the package's DROP-POST.md.
2. **Run `rymac-write-an-seo-blog-post`** to produce a video-boost post on the
   brand's own blog, following ALL of that skill's rules. The proven shape:
   - Leads with a **clickable YouTube thumbnail image linked to the watch
     URL**, because many blog pipelines strip embed frames. Never an embed
     tag.
   - Claims its own row in the keyword map, marked as a video-boost post, and
     must not cannibalize an existing post's keyword.
   - Cuts at least 1 receipt image from the video's own verified b-roll,
     checked for personal information at full size before it ships.
   - 2 to 4 internal links plus at least 2 external authority links, plus 1
     retro-link added FROM the most related older post TO the new one.
3. **Timestamp deep-links** (`?t=<seconds>`) where the post cites specific
   video moments, computed from the aligned slide data, never guessed.

## Rules

0. ⛔ **RUN `rymac-write-in-the-owners-voice` FIRST, before writing a word of
   any post, description, or package file.** Calibrate on the owner's own
   swipe. This rule was born the day AI-cadence prose shipped inside paid
   course materials and a customer noticed before the owner did.
0b. ⛔ **1 video = 1 complete package. ALWAYS.** Its own drop post, its own
   strategy files, its own term sheet, its own member-builds, its own zip, and
   a chapter map with timestamps COMPUTED off the rendered file. A shared
   package across 2 videos shortchanges an expensive course.
1. The owner's voice throughout. Direct, no hype, no em dashes, numbers always
   digits, no developer talk in anything public.
2. Every strategy file must end in a runnable prompt. A file without a prompt
   is a blog post, not a package file.
3. Give the store away. Prompts must work WITHOUT buying anything. Product
   links appear where they genuinely fit, never as the payload.
4. Free links stay free. The owner's free tools and community, with the
   video's exact links.
5. Names are kept in member-builds, community-internal. If the package ever
   ships outside the community, strip them.
6. Update member-builds when the owner mentions member reactions. It is a
   living file. Re-zip after meaningful updates.

## Checklist

- [ ] Read the script or transcript, confirm the marked topics with the owner
- [ ] DROP-POST.md in the drop shape, owner's voice, paste-ready
- [ ] 2 to 5 strategy files, each ending in a fenced prompt
- [ ] term-sheet.md and member-builds.md
- [ ] The zip built with forward slashes and read back
- [ ] YouTube kit: locked keyword + 3 titles + description off the swipe with
      REAL chapter timestamps + 2 rendered thumbnails
- [ ] When the live link lands: ledger entry, drop-post swap, and the
      video-boost blog post, automatically
- [ ] Em-dash gate: zero across every file
- [ ] Numbers gate: every figure is a digit
