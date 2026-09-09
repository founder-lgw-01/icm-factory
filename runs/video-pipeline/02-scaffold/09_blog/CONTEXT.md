# 09_blog, the post behind every live video

1 job: write the post on the owner's own site that claims the video's keyword
row, embeds the video, and links back into older posts, without being asked.

## Inputs
- Working (this run): the live link the owner handed over;
  `../production/<video>/01-GAMEPLAN.md` (the locked keyword);
  `../production/<video>/05-STORYBOARD.md` (timestamps for cited moments)
- Reference (every run): `../_config/my-line.md` (`SITE`, `BLOG-HOME`),
  `../_config/keyword-map.md`, `../skills/rymac-follow-the-production-line/SKILL.md`,
  `../skills/rymac-write-an-seo-blog-post/SKILL.md`,
  `../skills/rymac-write-in-the-owners-voice/SKILL.md`, `../_reference/voice.md`

Do NOT load: the render and package skills; any other video.

## Process
1. Fire the gate skill; refuse to run until the owner has handed over the live link.
2. Read `../_config/keyword-map.md`: the video's keyword claims 1 row and competes
   with no older post. Add the row.
3. Write the post at `BLOG-HOME`: the clickable thumbnail first, the embedded
   video, the locked keyword, video moments cited with timestamp links computed
   from the storyboard, and 2 older posts edited to link into it.
4. Run `../checks/voice-check.sh` on the post.
5. Session end: write 1 line under `## Next` in `../CONTEXT.md`: done, decided, next.

## Outputs
- The post at the blog home named in the config; 1 new row in
  `../_config/keyword-map.md`; 1 line under `## Next` in `../CONTEXT.md`

## Human check
Open the post on your site: the video plays, the keyword row is claimed once in
`../_config/keyword-map.md`, and 2 older posts link in. Read the first 3
paragraphs aloud. Then this video is done, and the next one starts at `01_gameplan/`.
