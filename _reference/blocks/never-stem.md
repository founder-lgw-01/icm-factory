---
name: never-stem
goes-in: CLAUDE.md, under "## Never"
every-build: yes
---
- Run a stage whose upstream output is not `status: approved`.
- Load anything a stage's `Do NOT load:` line names. The exclusion is the
  contract, not a suggestion.
- Load the full workspace to answer 1 question. Read the contract, its named
  references, and its inputs. Nothing more.
- Edit a generated file by hand. Run the thing that generates it.
- Invent a number, a date, or a quote. Count it, cite it, or mark it unknown.
- Edit `AGENTS.md` by hand. It is a copy of `CLAUDE.md` for hosts that read
  `AGENTS.md` first; change `CLAUDE.md`, then copy it over `AGENTS.md` again.
