# Prior art

Independent arrivals at the same structure. Recorded because ICM's own guidance
says a pattern appearing 3 independent times is structure, while 1 team
doing it is a coincidence. This file holds the sightings, not the method.

## PraxisLibrary

`github.com/jordansshaw-pixel/PraxisLibrary_Bas`. Same owner as this factory.
CC BY-NC 4.0, which this workspace is inside, being a free community resource.

A 217-page site built with Claude Code. Its README documents a session-continuity
system reached from a different direction than ICM:

| PraxisLibrary | This factory | Same idea |
|---|---|---|
| `CLAUDE.md` at root, auto-loaded, "rules summary and file references", updated rarely | root `CLAUDE.md`, routes and holds nothing | L0 routing file, stable, no payload |
| "Critical Rules (Always Follow)" | `## Never` block | a short list of absolutes at the entry point |
| `.claude/HANDOFF.md`, current state, updated every session | `status:` frontmatter a person flips | state lives in a file, not in the model |
| `.claude/plans/*.md`, phase detail | stage `CONTEXT.md` contracts | detail pushed down out of the entry file |

The convergent finding: a small stable entry file plus a separate mutable state
file beats 1 large prompt. Reached twice, independently, on different work.

**What differs, and it is the interesting part.** PraxisLibrary tracks state as a
progress table a human maintains by hand (`1.1 Remove header badges | Done`).
This factory derives state from what exists on disk. The hand-maintained table is
the thing ICM's library rules warn about: a generated index that is hand-curated
always drifts. Same problem, and the folder-as-state-machine answer is the more
durable of the 2.

**Not usable as input.** The site's 10,643 glossary terms and 149 technique pages
are prompt-engineering pedagogy: how to write a better prompt in a chat window.
This factory's premise is that structure replaces prompting. Importing that
corpus into `_reference/` would be the context-stuffing ICM exists to prevent.

**Usable as a build.** 149 technique pages with identical anatomy is the same
repeating-unit shape as the `_source-corpus/` tool packages. It is a door B
ingest candidate once the factory is proven, not a source of factory rules.

The `.claude/` folder itself is not in the repo. Its `.gitignore` ignores
everything by default and allowlists only site files, so the workflow is
described in the README but the files stay local.

## Pelto

`c:\pelto`. The house style, and the closest thing to a working reference
implementation. Stage contracts 399 to 516 tokens, entry file 575. Its
`Do NOT load:` line is the isolation mechanism this factory copied wholesale.
Measured, not assumed: those numbers set the budget the gate enforces.
