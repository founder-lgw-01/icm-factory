---
slug: video-pipeline
stage: 03_emit
status: approved
generated: 2026-09-07
sources:
  - runs/video-pipeline/02-scaffold/manifest.md
  - _reference/blocks/
  - _reference/emission-standard.md
---

# Emit log, video-pipeline

Fourth emit, after the factory gated voice law 3 (digits) and began running a
build's own checks (change-log, 2026-09-07, "digits gated, and a build must pass
its own checks"). 4 blocks changed for it (`never-stem`, `icm-credit`,
`walk-test`, `icm-about-icm`) and the scaffold took repairs 6 to 8 in the
manifest. The scaffold at `runs/video-pipeline/02-scaffold/` was copied to
`builds/video-pipeline/` and every block marker replaced with the verbatim body
of its file in `_reference/blocks/`, minus that file's frontmatter. 15 files
differ from the third emit: the 9 contracts, `CLAUDE.md`, `README.md`,
`PLAYBOOK.md`, `PROMPTS.md`, `_reference/voice.md`, `_reference/walk-test.md`.

Earlier emits: the third changed 3 lines of `00-START-HERE.md` (repair 5); the
second changed only `_reference/walk-test.md`.

The `status: approved` on this file was given on the second emit. Every change
since is a repair the manifest lists or a block change the change-log records.

## Blocks resolved

block: never-stem -> CLAUDE.md
block: icm-about-icm -> CLAUDE.md
block: status-convention -> CONTEXT.md
block: edit-surface -> CONTEXT.md
block: naming -> CONTEXT.md
block: icm-credit -> README.md
block: walk-test -> _reference/walk-test.md

## Stripped

- `manifest.md`, the scaffold's manifest
- `SKELETON.md`, the skeleton's how-to
- 7 `BLOCK:` marker lines, replaced by the text above

No `status:` frontmatter of the factory's own was present in the scaffold; the
build's files carry none until a run writes them.

## Files written, 126

- `00-START-HERE.md`
- `01_gameplan/CONTEXT.md`
- `02_script/CONTEXT.md`
- `03_spec/CONTEXT.md`
- `04_reader/CONTEXT.md`
- `05_storyboard/CONTEXT.md`
- `06_approval-render/CONTEXT.md`
- `07_final-render/CONTEXT.md`
- `08_package/CONTEXT.md`
- `09_blog/CONTEXT.md`
- `CLAUDE.md`
- `CONTEXT.md`
- `PLAYBOOK.md`
- `PROMPTS.md`
- `README.md`
- `_config/keyword-map.md`
- `_config/my-line.md`
- `_config/my-voice/README.txt`
- `_examples/one-video-start-to-finish.md`
- `_reference/cloud-rendering.md`
- `_reference/hard-rules.md`
- `_reference/voice.md`
- `_reference/walk-test.md`
- `checks/check-stages.sh`
- `checks/voice-check.sh`
- `research/README.md`
- `skills/rymac-build-a-profit-calculator/README.md`
- `skills/rymac-build-a-profit-calculator/SKILL.md`
- `skills/rymac-build-a-sales-page/README.md`
- `skills/rymac-build-a-sales-page/SKILL.md`
- `skills/rymac-build-a-sales-page/references/case-studies.md`
- `skills/rymac-build-a-sales-page/references/conversion-principles.md`
- `skills/rymac-build-a-sales-page/references/section-playbook.md`
- `skills/rymac-build-a-youtube-video/SKILL.md`
- `skills/rymac-build-video-in-code/SKILL.md`
- `skills/rymac-build-video-in-code/rules/3d.md`
- `skills/rymac-build-video-in-code/rules/assets/charts-bar-chart.tsx`
- `skills/rymac-build-video-in-code/rules/assets/text-animations-typewriter.tsx`
- `skills/rymac-build-video-in-code/rules/assets/text-animations-word-highlight.tsx`
- `skills/rymac-build-video-in-code/rules/audio-visualization.md`
- `skills/rymac-build-video-in-code/rules/audio.md`
- `skills/rymac-build-video-in-code/rules/calculate-metadata.md`
- `skills/rymac-build-video-in-code/rules/compositions.md`
- `skills/rymac-build-video-in-code/rules/display-captions.md`
- `skills/rymac-build-video-in-code/rules/effects.md`
- `skills/rymac-build-video-in-code/rules/ffmpeg.md`
- `skills/rymac-build-video-in-code/rules/get-audio-duration.md`
- `skills/rymac-build-video-in-code/rules/get-video-dimensions.md`
- `skills/rymac-build-video-in-code/rules/get-video-duration.md`
- `skills/rymac-build-video-in-code/rules/gifs.md`
- `skills/rymac-build-video-in-code/rules/google-fonts.md`
- `skills/rymac-build-video-in-code/rules/html-in-canvas.md`
- `skills/rymac-build-video-in-code/rules/images.md`
- `skills/rymac-build-video-in-code/rules/import-srt-captions.md`
- `skills/rymac-build-video-in-code/rules/light-leaks.md`
- `skills/rymac-build-video-in-code/rules/local-fonts.md`
- `skills/rymac-build-video-in-code/rules/lottie.md`
- `skills/rymac-build-video-in-code/rules/maplibre.md`
- `skills/rymac-build-video-in-code/rules/measuring-dom-nodes.md`
- `skills/rymac-build-video-in-code/rules/measuring-text.md`
- `skills/rymac-build-video-in-code/rules/parameters.md`
- `skills/rymac-build-video-in-code/rules/sequencing.md`
- `skills/rymac-build-video-in-code/rules/sfx.md`
- `skills/rymac-build-video-in-code/rules/silence-detection.md`
- `skills/rymac-build-video-in-code/rules/subtitles.md`
- `skills/rymac-build-video-in-code/rules/tailwind.md`
- `skills/rymac-build-video-in-code/rules/text-animations.md`
- `skills/rymac-build-video-in-code/rules/timing.md`
- `skills/rymac-build-video-in-code/rules/transcribe-captions.md`
- `skills/rymac-build-video-in-code/rules/transitions.md`
- `skills/rymac-build-video-in-code/rules/transparent-videos.md`
- `skills/rymac-build-video-in-code/rules/trimming.md`
- `skills/rymac-build-video-in-code/rules/video-layout.md`
- `skills/rymac-build-video-in-code/rules/videos.md`
- `skills/rymac-build-video-in-code/rules/voiceover.md`
- `skills/rymac-call-funnel/README.md`
- `skills/rymac-call-funnel/SKILL.md`
- `skills/rymac-edit-and-render-a-video/SKILL.md`
- `skills/rymac-exit-pop/README.md`
- `skills/rymac-exit-pop/SKILL.md`
- `skills/rymac-explain-it-to-a-beginner/SKILL.md`
- `skills/rymac-explain-it-to-a-beginner/check-fragments.py`
- `skills/rymac-explain-it-to-a-beginner/check-plain.sh`
- `skills/rymac-explain-it-to-a-beginner/check-sourced.py`
- `skills/rymac-explain-it-to-a-beginner/grade.py`
- `skills/rymac-explain-it-to-a-beginner/metaphors.md`
- `skills/rymac-explain-it-to-a-beginner/shapes.md`
- `skills/rymac-explain-it-to-a-beginner/translations.md`
- `skills/rymac-follow-the-production-line/SKILL.md`
- `skills/rymac-make-a-reader-to-record-from/SKILL.md`
- `skills/rymac-make-a-reader-to-record-from/check-reader.mjs`
- `skills/rymac-make-a-reader-to-record-from/fonts/sora-latin.woff2`
- `skills/rymac-make-a-reader-to-record-from/make-reader.mjs`
- `skills/rymac-package-a-video-for-your-community/SKILL.md`
- `skills/rymac-paid-traffic-landing-page/README.md`
- `skills/rymac-paid-traffic-landing-page/SKILL.md`
- `skills/rymac-paid-traffic-landing-page/assets/page-template.html`
- `skills/rymac-paid-traffic-landing-page/references/headlines.md`
- `skills/rymac-paid-traffic-landing-page/references/niche-research.md`
- `skills/rymac-paid-traffic-landing-page/references/page-structure.md`
- `skills/rymac-relationship-sequence/README.md`
- `skills/rymac-relationship-sequence/SKILL.md`
- `skills/rymac-research-a-market-drowning-in-ai/SKILL.md`
- `skills/rymac-research-a-market-drowning-in-ai/references/delivery-economics.md`
- `skills/rymac-research-a-market-drowning-in-ai/references/icm-market-map.md`
- `skills/rymac-research-a-market-drowning-in-ai/references/the-4-signs.md`
- `skills/rymac-research-a-trade-niche/README.md`
- `skills/rymac-research-a-trade-niche/SKILL.md`
- `skills/rymac-research-a-trade-niche/references/delivery-costs.md`
- `skills/rymac-research-a-trade-niche/references/the-3-laws.md`
- `skills/rymac-write-a-headline/README.md`
- `skills/rymac-write-a-headline/SKILL.md`
- `skills/rymac-write-a-headline/evals.md`
- `skills/rymac-write-a-headline/references/headline-formulas.md`
- `skills/rymac-write-a-headline/references/hero-and-cta.md`
- `skills/rymac-write-a-headline/references/swipe-file.md`
- `skills/rymac-write-a-sales-letter/README.md`
- `skills/rymac-write-a-sales-letter/SKILL.md`
- `skills/rymac-write-a-sales-letter/references/letter-anatomy.md`
- `skills/rymac-write-a-sales-letter/references/pas-framework.md`
- `skills/rymac-write-a-sales-letter/references/voice-dna.md`
- `skills/rymac-write-a-slide-video-script/SKILL.md`
- `skills/rymac-write-a-slide-video-script/references/slide-pacing.md`
- `skills/rymac-write-a-slide-video-script/references/vsl-beat-structures.md`
- `skills/rymac-write-an-seo-blog-post/SKILL.md`
- `skills/rymac-write-in-the-owners-voice/SKILL.md`
