# The Production Line, the line

| Stage | Job | Input | Output, in `production/<video>/` | Human check |
|---|---|---|---|---|
| `01_gameplan` | lock keyword, hook, title | your keyword, or `research/` | `<video>/01-GAMEPLAN.md` | lock block against the config |
| `02_script` | numbered slides, 14 words max | the gameplan | `<video>/02-SCRIPT.md` | voice check, read aloud |
| `03_spec` | engine on line 1, every shot | the script | `<video>/03-SPEC.md` | engine named, scrub line present |
| `04_reader` | fold, reader, byte gate, record | script and spec | `<video>/04-VO-FOLD.md`, the reader, `VO.mp3` | reader only on PASS; the tape |
| `05_storyboard` | 1 row per spoken sentence | the tape | `<video>/05-STORYBOARD.md` | the gate page |
| `06_approval-render` | first 90 seconds, in the cloud | the storyboard | `<video>/out/approval-90s.mp4` | watch it, say so |
| `07_final-render` | measured assembly, both cuts | the 90 seconds, approved | `<video>/out/`, final, clean, thumbs | watch the final, say so |
| `08_package` | drop post and publish kit, or the page | the finals | `community/packages/<video>/` | read it aloud; hand over the link |
| `09_blog` | the post behind the video | the live link | the post at BLOG-HOME | video plays, keyword row claimed |

Factory (stable, every run): `_config/`, `_reference/`, `checks/`, `skills/`, `PLAYBOOK.md`, `PROMPTS.md`
Product (new each run): `production/<video>/`, `community/packages/<video>/`, the post on the owner's site
Shared and growing: `research/`

BLOCK: status-convention

The fold, the reader and the renders carry no frontmatter: scripts parse them.
The owner's word approves those stages, and the next artifact is the record.

BLOCK: edit-surface

BLOCK: naming

Inside `production/<video>/` the files are `NN-NAME` and the numbers drift between
videos. Read the stage name, never the digits, as `checks/check-stages.sh` does.

## Next

Your AI writes 1 line here at the end of every session: done, decided, next.

- Freshly unpacked. Run prompt 1 in `PROMPTS.md`.
