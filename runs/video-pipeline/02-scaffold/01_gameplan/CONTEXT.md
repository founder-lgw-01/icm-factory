# 01_gameplan, lock the keyword and write the gameplan

1 job: lock keyword, hook and title at the top of `01-GAMEPLAN.md`, then write
the lock block every later stage reads.

## Inputs
- Working (this run): the owner's keyword, hook and title from the tool named on
  the `RESEARCH-TOOL:` line of the config; or, when they have none, the research
  files in `../research/`
- Reference (every run): `../_config/my-line.md`,
  `../skills/rymac-follow-the-production-line/SKILL.md`,
  `../skills/rymac-build-a-youtube-video/SKILL.md` (RULE 00, RULE 0, steps 0 and 1)
- Reference (on demand): `../skills/rymac-research-a-market-drowning-in-ai/SKILL.md`
  or `../skills/rymac-research-a-trade-niche/SKILL.md`, only when there is no keyword

Do NOT load: any other `../production/<other>/` (1 video is 1 folder); the render
skills `../skills/rymac-edit-and-render-a-video/` and
`../skills/rymac-build-video-in-code/` (render knowledge, not planning).

## Process
1. Fire the gate skill: post the 9 stages, mark where this job starts, get the go.
2. Refuse to run while `SKIN-GROUND:` in the config is empty. The interview has
   not run; send the owner to prompt 1.
3. Ask the fork once if the owner has not said: YouTube video, VSL, or both.
4. Re-read `../_config/my-line.md` from disk. The brand, the skin, the ending and
   the blog home come from it, never from memory.
5. Create `../production/<video>/`. Write `01-GAMEPLAN.md`: frontmatter, then the
   lock block (`BRAND`, `SKIN`, `SURFACE`, `ENDS-ON`, `SLUG`, and `VSL-TAIL: yes`
   on both), then the locked keyword table, the audience, the ONE mechanic the
   video teaches, and what is out of scope.
6. Nothing downstream re-researches the keyword. Say so in the file.

## Outputs
- `../production/<video>/01-GAMEPLAN.md`, frontmatter: `video`, `stage: 01_gameplan`,
  `status: draft`, `generated`, `sources`; the lock block on the lines after it

## Human check
Read the lock block against `../_config/my-line.md`, line by line, then the
keyword row against your research tool. Confirm the ONE mechanic is 1 thing and
not 3. Flip `status: approved`.
