# Change log

Every change to `_reference/`, `_templates/`, or `_system/` gets an entry. A
block change also names the builds re-run, because a block edit that does not
reach the builds is drift with a paper trail.

Newest first.

---

## 2026-09-27, the 2 outside test reports, applied

Owner's call: apply every improvement the 2 outside test reports recommended,
here, without importing the testers' scripts. Both testers ran the 2026-09-07
package (11 gate checks; the 2026-09-25 package has 13). RyMac walked the
factory cold 7 times on a roofing follow-up agent and fixed their copy as they
went. A second builder built painfinder, an interview agent, and attacked it
over 6 rounds. 6 of RyMac's 7 run-1 faults were still live here; painfinder's
were faults of intake, not of the gate.

From RyMac's report:
- **A rebuild keeps the runs.** `03_emit` moves `builds/<slug>/runs/` to
  `runs/<slug>/kept-runs/` before removing the old build, deletes the stale
  gate report, and moves every unit back last. Before this, the contract said
  "remove it first" and a rebuilt agent lost every job it had run.
- **Every build ships `runs/README.md`.** The skeleton carries the note, the
  gate's `structure` check requires it, and so every route to `runs/` resolves
  before the first run. The skeleton's root `CONTEXT.md` and `CLAUDE.md` no
  longer name `NN_stage/CONTEXT.md`, a path no build can resolve.
- **The gate reads nothing under `runs/<unit>/`.** After use it holds an
  owner's or a customer's words. `validate.sh` prunes it from every scan,
  `voice-check.sh` prunes it in folder mode, and `ship.sh` leaves it out of the
  zip. `runs/README.md` is the factory's and is still read.
- **Scaffold print.** New gate section, `print`: the emit log carries a
  `sha256sum` line per scaffold file under `## Scaffold print`, and the gate
  recomputes it. A scaffold edited after emit, a file added or lost, or a log
  with no print, blocks. RyMac did this with a script; here it is 1 step in
  `03_emit` and 1 section in the gate. 14 sections now.
- **Stages 1 and 2 read the block index.** `_reference/blocks/README.md` is
  now a reference input to both; the bodies stay do-not-load. Before, `01_form`
  had to write **Blocks needed** without being allowed to see the list.
- **Stage 2 owns the README.** It writes `README.md` with the interview open;
  `03_emit` resolves its block and changes nothing else. Before, stage 3 wrote
  it while forbidden to read the interview, and stage 2 never mentioned it.
- **The voice check runs while the scaffold is written**, step 9 of
  `02_scaffold`, so a bad line is fixed before it costs a rebuild.
- **Naming.** The `naming` block and the factory's own `CONTEXT.md` said "no
  punctuation" beside slugs written with hyphens. Now: lowercase words joined
  with hyphens, nothing else.

From the painfinder report:
- **3 intake questions**, 8 to 10 in `intake-questions.md`: who is on the
  other end of a run (a person means a privacy rule in the plan), where the
  agent's truth comes from (a self-written record proves consistency, not
  fidelity, and goes under **Open questions**), and the owner's voice, offers
  and sign-off, taken down word for word. 2 new intake sections carry them,
  **Who it talks to** and **The owner's words**; the latter ships verbatim in a
  fenced block, where the digit law does not reach. The skeleton's `voice.md`
  has the slot. RyMac's report asked for the owner's words too.
- **The stage 2 human check reads paired rules side by side.** Painfinder
  shipped 2 rules on money that disagreed, and the agent found it, not the
  gate. The gate cannot read meaning; the human check now says where to look.

Not done, on purpose: a gate rule that a check a build ships must ship with
the cases it has to fail. Painfinder's quote checker leaked 27 of 28 fakes
before it was rebuilt, and fixtures would have shown that at round 4. It needs
a manifest form and a probe, and is its own entry when it comes.

Changed: `_reference/intake-questions.md`, `_reference/emission-standard.md`
(3 new sections: a rebuild keeps the runs, scaffold print, README ownership in
the file table), `_reference/blocks/naming.md`, `_reference/blocks/README.md`,
`_templates/agent-skeleton/` (`runs/README.md` new; `CONTEXT.md`, `CLAUDE.md`,
`SKELETON.md`, `_reference/voice.md`), every stage contract but `04_validate`,
each within 650 tokens, `_system/validate.sh` (`print` section; `structure`
requires `runs/README.md`; every scan pruned of `runs/<unit>/`),
`_system/voice-check.sh`, `_system/ship.sh`, `_system/test-gate.sh` (a `stamp`
helper and 9 new probes, 65 in all), root `CONTEXT.md`.

Builds affected: both trail, on the `naming` block, the missing `runs/README.md`
and the missing scaffold print. Each needs `02_scaffold` re-run for the note,
then `03_emit`. Not re-run in this entry.

---

## 2026-09-27, video-pipeline re-run for the 2026-09-25 changes, and shipped

Owner's call: ship the video pipeline to a community member. `audit-builds.sh`
named the build trailing on the 2 entries below of 2026-09-25 that re-ran
`characterworldengine` only: `entry` (no `AGENTS.md`) and `blocks` (the
`never-stem` line about `AGENTS.md` missing from `CLAUDE.md`). The build in
`builds/` had not changed since its fourth emit on 2026-09-07; the factory had.

`03_emit` re-ran from the same approved scaffold. A dry emit into a scratch
folder was diffed against the old build first: 2 files differ, `CLAUDE.md` by
the block's 2 lines and `AGENTS.md` new, 125 files byte for byte. The gate
passed all 13 sections and `audit-builds.sh` reports 2 passing. The emit log
and gate report carry a fifth-run note each and keep their approval on the
same reasoning as the 2026-09-25 re-run.

Changed: nothing in `_reference/`, `_templates/` or `_system/`.

Builds re-run: `video-pipeline`, through `03_emit`. Shipped:
`_dist/video-pipeline-2026-09-27.zip`.

---

## 2026-09-25, the factory package is cut by a script

Owner's call: cut a new factory package, since the one in `_dist/` predated
the day's changes, and archive the old one. The first package was cut by hand
in 6 steps described in the 2026-09-07 entry. A second cut done by hand would
match the first only by luck, so the steps are now `_system/package.sh`.

What it does, in order: copies the root files, `stages/`, `_reference/`,
`_templates/`, `_system/` and `_source-corpus/ICM-architect/` (no `.git/`) to
a scratch folder; rewords the 14 provenance lines that name the owner's source
kit, a run slug, a local path or the owner, as literal replacements that each
must land or the cut is refused; replaces `change-log.md` with 1 release entry
whose counts (stages, blocks, gate sections, probes) are read from the copy;
runs `test-gate.sh`, `audit-builds.sh`, `voice-check.sh` and an em dash byte
count on the files the factory writes; greps the whole copy for the owner's
terms; zips it to `_dist/icm-factory-<date>[-vN].zip` rooted at
`icm-factory/`; reads the zip back file by file. Any failure deletes the zip.

3 things learned cutting it:
- The vendored method, `ICM-architect/`, carries 120 em dashes and spelled-out
  numbers, and the first package shipped it as written. The voice laws govern
  what the factory writes, so the copy's voice and em dash checks skip
  `_source-corpus/`, and the script header says why.
- The script that removes the owner's words must contain them, twice: the
  replacement table and the grep pattern. Both sit between marker comments,
  and the copy's own `package.sh` gets both regions emptied, with a note for a
  buyer to fill in their own. The owner grep would otherwise fail on itself.
- The `## Pelto` heading in `prior-art.md` survived the first cut; it is now
  reworded with the body.

Changed: `_system/package.sh` (new); `CLAUDE.md` routes the buyer package row
to it; `_system/CONTEXT.md` lists it. `_dist/icm-factory-2026-09-07-v2.zip`
moved to `_dist/_archive/`. New package: `_dist/icm-factory-2026-09-25.zip`,
51 files, 56 probes clean inside the copy.

Builds affected: none.

---

## 2026-09-25, every gated build ships as a zip in `_dist/`

Owner's call: builds are zipped for hand-over the same way the factory is,
every one of them. `_dist/` had held the factory package only, cut by hand
from a sanitized copy. A build needs no sanitizing, since the gate already
proves nothing in it names the factory, but it does need a path from "gate
report approved" to "a zip exists" that cannot be taken early or by hand.

New `_system/ship.sh <slug>`. It refuses unless
`runs/<slug>/04-gate-report.md` is `status: approved` with `verdict: pass` in
its frontmatter, re-runs `validate.sh` because a block or rule may have moved
since the report, and only then zips `builds/<slug>/` to
`_dist/<slug>-<date>[-vN].zip`, entries rooted at `<slug>/`. The zip is read
back and checked file by file against the tree; a mismatch deletes it. Python
writes the zip; neither `zip` nor `7z` is on the machine. The first run picked
`python3`, which on this Windows machine is a Store alias that prints an
install hint and exits nonzero, so the script now tries each candidate with an
import before trusting it, and says "python failed" rather than "zip did not
match" when that is what happened. The `-vN` suffix matches the factory
package's naming and never overwrites.

`CLAUDE.md` went to 838t and 60 lines with the 2 additions and was trimmed to
fit: the new Never line folded into the existing ship line, the routing rows
shortened.

Changed: `CLAUDE.md` gains a routing row and a `## Never` line (zip a build by
any path but `ship.sh`); the `_dist/` row now names the factory package by its
pattern. `_system/CONTEXT.md` lists the script. `stages/04_validate/CONTEXT.md`
human check ends by naming the script. `emission-standard.md` says the zip is
cut by `ship.sh`.

Builds shipped: `characterworldengine`, first zip in `_dist/` for a build.

The factory package in `_dist/` is from 2026-09-07 and predates today's 3
changes (AGENTS.md, the `empty` check, `ship.sh`). Cutting a new one is a
separate decision and was not done.

---

## 2026-09-25, the gate blocks an empty folder

Found by the cold walk on `characterworldengine`, after the gate had passed
all 12 checks. The build carried `00_setup/references/`, an empty folder left
from the scaffold's first layout before the reference images moved to
`world/references/`. Nothing pointed at it and no check looked for it. A zip
drops an empty folder, so the build gated is not the build a recipient unpacks,
and the emission standard says stage folders hold contracts only.

Changed: `_system/validate.sh` gains section `empty`, after `residue`: any
empty folder in the build blocks. Header updated. `_system/test-gate.sh` gains
1 probe, 56 in all. The empty folder was removed from the approved scaffold;
it was never in `manifest.md`, which lists files, and nothing else in the
scaffold changed.

Builds re-run: `characterworldengine`, through `03_emit`, from the same
scaffold and the same approved emit log, whose file list is unchanged.

---

## 2026-09-25, every build ships `AGENTS.md`, a copy of `CLAUDE.md`

Owner's call, on the first build for a host that is not Claude Code:
`characterworldengine`, made for Hermes. The question was whether the factory
should know that Hermes, Codex, and ChatGPT-style agents read `AGENTS.md`, or
leave that to the operator. It should know: intake already records the host,
the text is identical in every build, and a hand-added file inside `builds/` is
deleted by the next re-emit with nothing to notice.

A 3-line pointer (`AGENTS.md` saying "read `CLAUDE.md`") was proposed first
and rejected on evidence. The owner checked Hermes's installed code,
`agent/prompt_builder.py`: project context is loaded first match wins,
`.hermes.md` → `AGENTS.md` → `CLAUDE.md`, as literal instruction text, and a
pointer inside it is not followed as context loading. So `AGENTS.md` carries
the full entry text, generated at emit, and `CLAUDE.md` stays the 1 home.

Changed:
- Block `never-stem` gains a line: never edit `AGENTS.md` by hand; change
  `CLAUDE.md` and copy it again.
- `emission-standard.md`: `AGENTS.md` in the required-files table, and a new
  section, **2 entry files, 1 home**, holding the finding and the rule that a
  build never ships `.hermes.md`.
- `stages/03_emit/CONTEXT.md` step 8: copy `CLAUDE.md` to `AGENTS.md`, last.
  The step pushed the contract to 696t; steps 2, 4, 6 and the Outputs line
  were trimmed to point rather than restate, and it measures 637t of 650.
- `_system/validate.sh`: new section `entry`, after `structure`: `AGENTS.md`
  exists and is `CLAUDE.md` byte for byte. Header updated.
- `_system/test-gate.sh`: the fixture ships `AGENTS.md`; 2 new probes,
  missing and hand-edited. 55 probes in all.
- `_templates/agent-skeleton/SKELETON.md` says why `AGENTS.md` is not in the
  skeleton.

Builds re-run: `characterworldengine`, through `03_emit`. The build had been
emitted and not yet gated or approved, so it was removed and emitted again from
the same approved scaffold. The scaffold did not change.

---

## 2026-09-07, the shipped package carries a v2 suffix

Owner's call. The buyer package is now
`_dist/icm-factory-2026-09-07-v2.zip`. The contents are byte for byte the ones
that shipped: the name changed, nothing else did, so no re-check was run.

The naming line in the entry below is widened to
`icm-factory-<date>[-vN].zip`, so a second package cut on a day that already
shipped one has a name that sorts after it and does not overwrite it.

Builds affected: none.

---

## 2026-09-07, digits gated, and a build must pass its own checks

Owner's call, after the first build passed the gate with 3 lines its own kit's
`check-plain.sh` rejected: 1 written by the scaffold (a spelled-out number in a
tree listing), 2 the source's own. The gate ran the factory's laws and never the build's, and law 3
was style, not code. Both are closed.

**Law 3, digits, is gated.** `_system/voice-check.sh` reads it on markdown
minus code spans and fenced code, headings included, with the source kit's
pronoun exemption (no one, one of, the one you need), tightened so the word
after "and" is still a number. `DIGITS=0` skips the law; `validate.sh` sets it on
the whole-build pass and then runs law 3 on the files the scaffold authors or
repairs (the root markdown, the contracts, `_reference/*.md`, the same list the
residue section uses). Files copied from a source keep their author's numbers.
The factory's own prose was swept once: 100-odd spelled-out numbers across the
root files, the 5 contracts, `_reference/`, `_templates/` and `_system/CONTEXT.md`
are digits now. The intake section named for a single run is **1 run, start to
finish** in the contracts and `intake-questions.md`; the approved
`runs/video-pipeline/00-intake.md` keeps the old heading, since nothing reads it
by name. Older entries in this log keep their words.

**New gate section, self-checks.** `manifest.md` lists each check the build
ships as `check: <command> :: <files>`, `{file}` standing for each listed file,
run from the build root; any nonzero exit blocks, a glob that matches nothing
blocks, and a manifest with no `check:` line blocks until it says `check: none`.
`02_scaffold` step 9 writes the section; `emission-standard.md` gains
**Self-checks**; `voice.md` states which files law 3 reads. The teaching gates
of the video kit now run on the 2 pages written for a customer and its voice
check on 16 authored or repaired pages, on every gate run.

`test-gate.sh`: 11 new probes, 53 in all. 2 of the first 3 runs landed a probe
wrong and the script was fixed each time: law 3 stripped code spans before
removing fences, so a fence line lost its backticks and its block leaked; and
the self-checks file list was globbed in the factory's own folder before it
reached the build, so `_reference/*.md` named the factory's files.

Blocks changed, and why: `never-stem` said "the whole workspace" and spelled out
its number, and "whole" is the kit's default banned word; `icm-credit` carried a
20+ word sentence and 2 words the kit's teaching gate calls jargon, and is now 5
short sentences; `walk-test` and `icm-about-icm` spelled out numbers.

Budgets after the sweep: `CLAUDE.md` 57 lines and 778t, `CONTEXT.md` 773t, the
5 contracts 616, 639, 639, 644 and 621t. `02_scaffold` went to 678t with the
new step and came back to 639t by pointing Outputs at step 9 instead of
restating its list.

Builds re-run: `video-pipeline`, through `03_emit`, 4 times before the gate
passed. Each block found a real defect: a heading in `PLAYBOOK.md`, the reading
grade on `README.md`, a fragment the scaffold wrote.

The buyer package in `_dist/` was rebuilt from these scripts, same file name,
and its 53 probes run clean inside the copy.

---

## 2026-09-07, `_dist/` holds the packaged factory

Owner's call. The factory is sold as a product, so a buyer's copy lives in
`_dist/icm-factory-<date>[-vN].zip` and `CLAUDE.md` routes to it.

A package is made from a copy, never from this folder in place. The copy keeps
the root files, `stages/`, `_reference/`, `_templates/`, `_system/` and
`_source-corpus/ICM-architect/` without its `.git/`. It drops `runs/`, `builds/`,
every other `_source-corpus/` folder, `_dist/` itself and this log, which is
replaced by 1 entry stating what ships. Provenance lines that named the owner's
own source kit, the slug of a run, a local path or the owner are reworded in the
copy only. The copy is checked before zipping: `test-gate.sh`, `audit-builds.sh`,
`voice-check.sh` on every factory file, an em dash byte count of 0, and a grep
for the owner's names and paths.

First package: `icm-factory-2026-09-07.zip`, 52 files.

Builds affected: none.

---

## 2026-09-07, walk-test block stops naming `runs/<unit>/`

Found by the cold walk on the first real build, `video-pipeline`, whose product
folder is `production/<video>/` because the source's guard keys on it. The block
`walk-test` told a cold agent to scan `runs/<unit>/`, a folder that build does not
have. The block had hardcoded the factory's own convention 4 entries below this
one; a shared block may not assume a build's layout.

Changed: `_reference/blocks/walk-test.md` lines 9-10 now say "the product folder
`CONTEXT.md` names". `stages/04_validate/CONTEXT.md` step 4 asks the same way.

Builds re-run: `video-pipeline`, through `03_emit`. The scaffold holds only the
marker and did not change. `audit-builds.sh` flagged the build before the re-emit,
the first time the detection half has fired on a real build.

---

## 2026-09-07, gate hardened after review

`REVIEW.md`, a fresh session's read of `HANDOFF.md`, found that the gate could not
see a block change, had 7 blind spots, and left the approval chain to the honour
system. Every fix below is proven by the new `_system/test-gate.sh`: 42 probes,
29 defects planted one at a time that each block the gate, 13 legitimate
look-alikes that each pass.

`_system/validate.sh`, section by section. The script header is now the only list
of checks; the contracts, `README.md` and `_system/CONTEXT.md` point at it instead
of restating it, because 3 of them said 7 while the script ran 8.

- **structure** also requires `_reference/` and at least 1 `NN_` stage folder. A
  build with no stages made every per-stage check pass over nothing.
- **isolation** runs on every text file, not markdown only, so the handoff's
  `leak.sh` blocks. The escape check is depth-aware: a file d folders down may
  climb d levels and no further, so a root file may not say `../` while a depth-2
  skill README may say `../../README.md` (9 files in the video source do). The
  factory-name grep is `icm[-_ ]?factory`, case-insensitive. Windows absolute
  paths are caught in any file, except a path carrying a `<placeholder>`, which
  clears the source's 9 `C:\Users\<you>\...` install lines. The Unix check is
  markdown-link syntax only, because 2 JS regex literals in the source match the
  old `\(/` form.
- **budget** measures root `CONTEXT.md` (800) as well as `CLAUDE.md` (800 and 60
  lines) and contracts (650). The limits are variables at the top, with provenance.
- **routing** resolves paths in every `NN_*/CONTEXT.md`, not only the root files.
  In a contract only a token with a directory part is a route; bare names are
  prose. A contract's route is tried from its own folder, then from the build root.
- **residue** anchors the frontmatter check to the factory's own stage names, so a
  build's `stage: 01_gameplan` passes. The `{{` and `BLOCK:` checks run on the
  files the scaffold authors (root markdown, contracts, `_reference/*.md`), since
  the source's skills carry `{{SLOT}}` text in 18 files. `SKELETON.md` joins
  `manifest.md`, matched case-insensitively.
- **hygiene** catches a stray file at depth 1 and a stray folder at any depth,
  and says FACTORY fault, since no stage of the build is re-run for it.
- **chain**, new: `runs/<slug>/00-intake.md`, `01-plan.md`,
  `02-scaffold/manifest.md` and `03-emit-log.md` must exist and carry
  `status: approved` in their frontmatter. Closes handoff defects 3b and 3c.
- **blocks**, new: every `block: <name> -> <path>` line in the emit log is
  checked, the block's body verbatim in the named file, and every block marked
  `every-build: yes` (plus `walk-test` at 3 or more stages) must be in the log. A
  block edit now fails every shipped build that carries the old text, which is
  what `CONTEXT.md`, `_reference/blocks/README.md`, `emission-standard.md` and
  `audit-builds.sh` had promised with no code behind it.

`_system/voice-check.sh` reads every text file, skips binaries, and runs law 1 on
raw bytes, so headings, blockquotes, fenced code and scripts are no longer exempt.
Laws 2, 4 and 5 keep the prose view of markdown. Its header says which laws it
holds; it had claimed laws 1 to 3 and held 1, 2, 4 and 5.

Budgets: contracts 750 to 650, root `CONTEXT.md` 900 to 800, in `validate.sh` and
`emission-standard.md`. Trimmed to fit rather than raised: `01_form` step 4
restated the closing rule of `source-fidelity.md` and now points at it, and root
`CONTEXT.md` restated the drift rationale that also lives in `README.md`. Measured
after: `CLAUDE.md` 750t and 56 lines, `CONTEXT.md` 775t, the 5 contracts 620,
642, 641, 645 and 617t.

Builds affected: none, `builds/` is still empty.

---

## 2026-09-07, emitted agents write to `runs/<unit>/`

Owner's decision. The skeleton emitted `NN_stage/output/<unit>/`, the layout the
owner had removed from the factory itself for run bleed. The correction was about
the design, not the factory, so built agents now keep stage folders contract-only
and write outputs to `runs/<unit>/`, numbered by the stage that wrote them.

Changed: `_templates/agent-skeleton/CONTEXT.md` and `NN_stage/CONTEXT.md`; the
block `_reference/blocks/walk-test.md`, whose status question now reads
`runs/<unit>/`; `emission-standard.md`, which gains the convention and the rule
that routing rows name the product folder with its placeholder, because it exists
only once a run has happened; `04_validate` step 4, which asks about `runs/`.

The skeleton's how-to `MANIFEST.md` is now `SKELETON.md`. The old name collided
with the `manifest.md` that `02_scaffold` writes (1 file on Windows, 2 on Linux,
the case-fold trap the method's own `reference-integrity.md` names), and its
line 3 still pointed at the output path from before the runs move.

Block `naming` reworded. Its examples `_templates/`, `_system/` and `_archive/`
were backticked directory routes, so every build without all 3 failed routing. It
now names `_reference/` alone, which every build has.

Builds affected: none.

---

## 2026-09-07, inherited files: em dash sweep at scaffold

Owner's decision. The video source carries 425 em dashes, 401 in markdown and 24
in code, and an `additive` verdict copies its files verbatim. With law 1 read on
every file, the first build would block on all of them.

New `_system/sweep-em-dash.sh`: mechanical, markdown only, run by `02_scaffold` on
copied files. A leading em dash becomes a bullet, a trailing one a period, every
other one a comma. Fenced code is never touched and code files are refused,
because an em dash there may be a working literal (the source's own
`checks/voice-check.sh:40` greps for one). Every changed line is printed before
and after. It also refuses any path under `_source-corpus/`: raw material is
read-only, and the guard was added after a test command in this session ran the
sweep on a real source file instead of its scratch copy. That file,
`skills/rymac-write-a-headline/SKILL.md`, was restored byte for byte from
`bmc_zip/rymac-production-line-940b4a5d19 (1).zip`, the only backup, and no other
source file was touched.

`02_scaffold` step 7 copies `additive` and `leave-alone` parts and runs the sweep;
step 9 lists every swept file in `manifest.md` and, under **Inherited**, every em
dash left in code as `file:line`. Its human check decides each: a byte escape, or
hold the build. `emission-standard.md` gains **Inherited files**: a build ships
with 0 em dashes and the gate carries no exemption list. `voice.md` states which
laws the script gates (1, 2, 4, 5) and which are style (3, 6). Law 3 enforcement,
and the 40 spelled-out numbers in factory prose, wait until after the first build.

Builds affected: none.

---

## 2026-09-07, prose brought back to the scripts

The review's D3: facts stored in more than 1 place had drifted. 3 files said the
gate runs 7 checks while the script ran 8; the skeleton's how-to named the output
path from before the runs move; `00_intake` still called its output `intake.md`.
Fixed at the single home for each.

Also from the review: `01_form` may now read any source file that names a path the
plan would change, not scripts and configs only, because the skill that documents
how the reader scripts find `_config/my-line.md` was neither. `source-fidelity.md`
records that third load-bearing structure in its example table and tells question
1 to read the files that invoke the scripts. `02_scaffold`'s human check reads the
scaffold's `CONTEXT.md` table against the plan's **Stages** table, row by row, the
one place both files are loaded, so a build is checked against what was asked. 4
comma splices left by the em dash sweep were rewritten. `CLAUDE.md` routes to
`test-gate.sh`.

`runs/video-pipeline/00-intake.md` was corrected and left at `status: draft`: the
stage 3 stop is `inferred`, `_config/my-line.md` is a third frozen part, the 5
folders have 2 referrers, 37 rule files not 40, the research skills are shared,
and a new open question 8 lists the source's internal disagreements.

Builds affected: none.

---

## 2026-09-07, fidelity verdicts made per-part

Owner's challenge: am I holding to a rule of 5 stage folders? If 9 are needed, or
3, that should be the structure. Conformity is not the goal.

Correct, and the gate written hours earlier had the same flaw in reverse. It
stopped conformity from overriding evidence, then recommended `additive` for the
whole video source, which inherits an existing shape just as blindly.

Re-read the scripts. The source has two structures that looked like one:

- `production/<video>/` file layout is **load-bearing**. `check-stages.sh`
  matches `NN-NAME` on files directly inside the video folder. Frozen.
- The 5 documentation folders are **named by zero scripts**. They hold one README
  each. Free to change.

The first analysis collapsed these into one recommendation and got the scope
wrong in both directions.

**Changes:** verdicts are now recorded per part, not per source. New section "Two
ways to get this wrong" names both failures: conformity (restructuring because an
invariant says so) and deference (preserving a shape nothing depends on). The
closing rule now reads: structure is an output of the analysis, not an input. Not
5 because the source has 5. Not 9 because there are 9 steps. However many places
the work genuinely stops, which is counted, not assumed.

`additive` is explicitly no longer a safe blanket default. Applied to a part
nothing depends on, it freezes an accident of history.

`01_form` step 4 now says to count the stops and never inherit a count from the
source's filing habit or round it to a familiar number.

On the video build itself: all 9 stages have a distinct output and a distinct
human gate, so by ICM's own test that is 9 boundaries. The source's 5 folders
hide 3 approval gates behind `02-SCRIPT/` and 3 more behind `04-EDIT/`.

---

## 2026-09-07, source fidelity gate added

Owner's call, mid-run on `video-pipeline`. A factory that breaks working source
material is a defective factory, so the review that caught it must be part of the
line rather than a lucky question.

**What happened.** The plan was to rebuild a video kit with 40+ shipped videos
into 9 numbered stage folders, because ICM invariant 3 says numbering encodes
order. The kit ships `checks/check-stages.sh`, a guard that catches a skipped
stage by matching `^[0-9]{2}-(.+-)?NAME([-.]|$)` against files sitting directly
inside each video folder. Moving those files down a level would have made every
pattern miss, and the guard would have reported clean on every video, forever.

That guard exists because a skipped spec once put a 27 word slide in front of a
microphone and 47 minutes were recorded off it. The rebuild would have disabled
the protection against the exact failure the source was built to prevent.

The source also states its own reasoning: "Read the stage NAME, never trust the
digits. Numbering varies between videos." It had deliberately decoupled order
from numbering, and it was right, because a live screen share has no voiceover
stage and a rigid 9-slot structure would demand an empty folder for it.

Nothing in the factory would have caught this. It surfaced only because the
operator asked what the change would cost.

**The fix.** New `_reference/source-fidelity.md`: 4 questions and 3 verdicts
(`leave-alone`, `additive`, `rebuild`). It fires whenever the source already
runs. Distinct from the method's own
`ICM-architect/references/reference-integrity.md`, which fires when a file
**moves** and asks what pointed at it. This one fires when a file is **rebuilt
elsewhere** and asks what its shape was load-bearing for. Nothing moves, so the
move-safety gate never triggers, and the product ships broken while the source
sits untouched and correct.

`01_form` now runs the gate as step 3, before the stage plan, because it decides
whether there is a plan. Its `Do NOT load:` was loosened: the stage that decides
the structure had been forbidden from reading the source it would break. It may
now read this build's own source, for scripts and configs only.

`01-plan.md` gains a **Source fidelity** section. The human check reads it first:
if the plan breaks something the source relies on, the plan is wrong, not the
source.

Contract budget raised 650t to 750t, recorded in `validate.sh` with the reason: a
stage that reads a source folder plus 3 reference files has a longer Inputs block
for a real reason. Root `CONTEXT.md` allowance raised to 900t in the emission
standard to match what the factory's own file needs.

New `## Never` entry: restructuring a source that already runs without the
verdict. `CLAUDE.md` trimmed back to 738t of 800 after the additions.

---

## 2026-09-07, runs moved out of stages

Owner's correction: nothing from a run should remain in a stage. The factory must
be clean after each run, and the next stage must run without bleed.

The original design had each stage own an `output/<slug>/` folder. That
accumulates: after 19 builds, every stage carries 19 folders of leftovers, and a
stage can see every run that ever happened. Wrong on both counts.

**Now:** `stages/` holds contracts only and is never written to. Every file a run
produces lands in `runs/<slug>/`, numbered by the stage that wrote it:
`00-intake.md`, `01-plan.md`, `02-scaffold/`, `03-emit-log.md`,
`04-gate-report.md`. A stage reads its input from the same run folder it writes
to, so a run cannot reach another run.

Cross-run isolation is now explicit in all 5 `Do NOT load:` lines: "any other run
in `../../runs/`". Two new `## Never` entries in `CLAUDE.md` forbid writing into
`stages/` and reading another run's folder.

Runs are kept after a build ships. They are a few markdown files and they are the
only record of what was asked, what was decided, and what the gate said.

New gate check, **hygiene**: fails if anything other than a `CONTEXT.md` appears
under `stages/`. It is about the factory rather than the build, and it runs on
every gate because the cost is one `find` and the failure mode is silent
accumulation. Verified in both directions: passes clean, blocks when a stray file
is planted.

Contracts stayed inside budget through the rewrite, 619 to 646t of 650. Root
`CONTEXT.md` was trimmed after the edit pushed it to 955t.

---

## 2026-09-07, PraxisLibrary evaluated, one note kept

Evaluated `github.com/jordansshaw-pixel/PraxisLibrary_Bas` as possible source
material. 375 MB, 551 files, 217 HTML pages, 10,643 glossary terms, 149 technique
pages.

**Not imported.** The corpus is prompt-engineering pedagogy: how to write a better
prompt in a chat window. This factory's premise is that structure replaces
prompting, so importing it into `_reference/` would be the context-stuffing ICM
exists to prevent. Searched for ICM or folder-agent material specifically: zero
hits.

**Kept:** `_reference/prior-art.md`. PraxisLibrary's README documents a
session-continuity system (root `CLAUDE.md` auto-loaded and stable, a separate
`HANDOFF.md` for state, a "Critical Rules" block) that is this factory's L0
routing file, `## Never`, and status convention reached independently. Two
arrivals at the same shape is worth recording. The note also captures where the
two differ: PraxisLibrary tracks state as a hand-maintained progress table, this
factory derives it from what exists on disk. The hand-maintained index is the
thing that drifts.

The `.claude/` folder holding the actual workflow files is not in that repo, its
`.gitignore` allowlists site files only. So the pattern is described, not copyable.

License question raised and resolved: the repo is CC BY-NC 4.0, and this factory
is a free Skool community resource, so NonCommercial is satisfied. Fit, not
license, is why the corpus stayed out.

Recorded as a future door B ingest candidate. 149 pages of identical anatomy is
the same repeating-unit shape as the `_source-corpus/` tool packages.

Routing row added to `CLAUDE.md`. Entry file now 687t of the 800t budget.

---

## 2026-09-07, em dash ban made absolute

Owner's call, reversing a scoping decision made earlier the same session.

Voice law 1 had been scoped to reader-facing prose only (`README.md`,
`_reference/`, `docs/`), exempting stage contracts on the reasoning that they are
machine-facing and the house reference uses em dashes there. The owner rejected
the exemption: an em dash is a tell, and a rule carrying an exemption is a rule
people learn to route around.

`_system/voice-check.sh` law 1 now fires on every markdown file it is pointed at,
with no `case` on the path. Verified blocking in both places the exemption used
to cover: a `README.md` and a stage `CONTEXT.md`.

Swept 83 em dashes out of 21 factory files. The sweep was not a blind character
swap: a mechanical pass replaced the common forms, then every comma splice it
produced was rewritten by hand into a period, a colon, or a parenthetical. Input
lines that read `path, requires status: approved` became
`path (requires status: approved)`, because the comma form scanned as two list
items.

Also corrected: `_reference/voice.md` law 1 text, and the skeleton at
`_templates/agent-skeleton/`, so no future build inherits an em dash from the
template.

Builds affected: none, `builds/` is still empty.

Follow-up the same session: the owner extended the ban to cover replies to them,
not only files. Added to the root `CLAUDE.md` `## Never` block so the rule travels
with the folder instead of living only in one session's memory.

---

## 2026-09-07, factory built

The workspace `c:\aaf-video pipeline` was renamed `c:\icm-factory` and
restarted. `_engine/` became `_source-corpus/`: raw material, read only by
`00_intake`, one folder per run.

Built the 5-stage line: `00_intake` (two doors, one exit) → `01_form` →
`02_scaffold` → `03_emit` → `04_validate`.

Decisions locked this session:

- **Factory at root, `builds/` beside it.** A build is a complete portable ICM
  workspace. Nothing in a build may name this factory.
- **The video pipeline is run 1**, built by the factory rather than by hand. If
  the factory cannot build the job the owner knows best, it is not ready for the
  ones they do not.
- **The gate blocks.** `_system/validate.sh` returns 1 and nothing ships. There
  is no ship-anyway flag. A failure is fixed in the factory and the build is
  re-run, never patched inside `builds/`.

Anti-drift mechanism, stated once: shared text lives in `_reference/blocks/`,
one file per block. `02_scaffold` writes `BLOCK: <name>` markers; `03_emit`
copies the text in. A build is self-contained *and* the text is authored in
exactly one place. `_system/audit-builds.sh` re-runs the gate over every shipped
build so a block change surfaces which agents now trail.

7 blocks: `icm-credit`, `status-convention`, `never-stem`, `naming`,
`edit-surface`, `walk-test`, `icm-about-icm`. The last is the guard for agents
whose subject matter is ICM (handoff §7 item 8).

Voice laws 1 to 3 adapted from
`_source-corpus/rymac-production-line/checks/voice-check.sh` rather than written
fresh (handoff §7 item 7). Its laws 5 and 6 are video-specific and were not
carried over.

Builds: none yet.
