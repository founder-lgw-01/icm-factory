# Emission standard, what every built agent must be

This is the contract the factory keeps with every agent it emits. `02_scaffold`
writes to it, `03_emit` fills it, `04_validate` enforces it. If a build does not
meet this, it does not ship.

## Portable, absolutely

A built agent runs with no parent and no sibling. Zip `builds/<slug>/`, hand it to
someone who has never heard of this factory, and it works.

That means, with no exceptions:

- No path escapes the build root. No `../..`, no absolute paths.
- No file contains the string `icm-factory`, or names this factory in any form.
- No file says "see the factory", "as configured upstream", or assumes the reader
  has anything but this folder.
- Everything the agent needs to run is inside it, including the rules it obeys.

## Required files

| File | Holds | Budget |
|---|---|---|
| `CLAUDE.md` | identity in 2 lines, "where am I", a routing table, `## Never` | < 800 tokens, < 60 lines |
| `CONTEXT.md` | the whole line as 1 table; factory/product split; status; naming | < 800 tokens |
| `README.md` | what this agent does, how to start a run, the ICM credit | no budget |
| `<NN_stage>/CONTEXT.md` | 1 per stage, the contract | < 650 tokens each |
| `_reference/` | the stable rules this agent obeys | - |
| `_templates/` | blank starters, if the agent instantiates anything | - |

## Every stage contract has, in this order

1. `# NN_name, one-line job`
2. `## Inputs`, split into *Working (this run)* / *Reference (every run)* /
   *Reference (on demand)*, as exact relative paths
3. **`Do NOT load:`** on its own line. This is the isolation mechanism and it is
   not optional. A stage with nothing to exclude has not been thought about.
4. `## Process`, numbered, short. Constraints live in `_reference/`, not restated here.
5. `## Outputs`, with the exact frontmatter the output carries
6. `## Human check`, exactly 1, stated as something a person *does*. Never
   "review", never "verify it's good".

## The conventions every build inherits

- **Numbering encodes order.** `NN_kebab-case` where sequence matters.
- **`_prefix` means about the workspace, not of the work.** `_reference/`,
  `_templates/`, `_system/`, `_archive/`.
- **Status is frontmatter a human flips.** `status: draft | approved`. A stage
  refuses to run until its upstream is approved. The filesystem is the state
  machine; there is no tracker.
- **Outputs land in `runs/<unit>/`**, numbered by the stage that wrote them.
  Stage folders hold contracts only, so a run leaves nothing behind in a stage
  and cannot reach another run. Routing rows name that folder with its
  placeholder, `runs/<unit>/`, because it exists only once a run has happened.
- **Every output is an edit surface.** A plain file a person opens, edits, saves.
  The next stage reads whatever the human left there.
- **Generated files are never hand-edited.** If a file is built by a script, the
  rule against editing it lives in that build's `## Never`.
- **1 home per fact.** A link beats a copy, inside a build as much as outside it.

## Blocks

Text that appears in more than 1 built agent is a block. Blocks live in
`_reference/blocks/`, 1 file each, and `03_emit` copies them in verbatim.

`02_scaffold` marks the spot with `BLOCK: <name>` on its own line and writes
nothing else there. A block is never hand-authored into a scaffold and never
edited inside a build. That is precisely the drift this factory exists to
prevent. To change a block: edit `_reference/blocks/<name>.md`, log it in
`change-log.md`, re-run the affected builds, and let `_system/audit-builds.sh`
tell you which ones those are.

`03_emit` records every block it resolves in `03-emit-log.md` as 1 line,
`block: <name> -> <file inside the build>`. The gate reads those lines and checks
each block's text against the library, so a block edit fails every shipped build
that still carries the old text. That is what makes the audit true.

## Inherited files

A build ships with 0 em dashes, including in files copied from a source. At
scaffold time `_system/sweep-em-dash.sh` sweeps every copied markdown file and
`manifest.md` lists each one. Code is never swept: every em dash left in a code
file or inside a fenced block is listed in the manifest under **Inherited**, and
the `02_scaffold` human check decides each line, a byte escape or a held build.
The gate carries no exemption list.

Copied files keep their author's numbers. Voice law 3, digits, is gated on the
files the scaffold authors or repairs: the root markdown, the contracts and
`_reference/`. The other laws reach every file.

## Self-checks

A build that ships its own checks must pass them. The factory cannot know a
source's rules, so it runs the source's own gates and blocks on what they find.
`manifest.md` lists each check the gate runs, 1 line per check:

`check: <command> :: <files>`

`{file}` in the command stands for each listed file in turn; the command runs
from the build root, and any nonzero exit blocks. The files are the ones the
scaffold authored or repaired, scoped the way the source scopes its own check: a
teaching gate runs on the pages written for a customer, a voice gate on every
authored page. A build whose source ships no checks says `check: none`. A
manifest that says neither has not decided, and blocks.

## The ICM-about-ICM guard

Some agents *teach* ICM. An agent can conflate the ICM it is running inside with
the ICM its lessons are about. Any build whose subject matter is ICM carries
`BLOCK: icm-about-icm` in its `CLAUDE.md`, which draws the line permanently.
