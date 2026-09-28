# ICM Factory

**You give it an idea, or a folder of notes you already have. It gives you back a
runnable agent: 1 self-contained folder that does the job.**

That folder is the product. Zip it, hand it to someone who has never heard of
this factory, and it works on their machine with nothing else installed. No
parent folder, no shared library, no setup.

This README is for someone opening this folder for the first time. If you already
know the system, start at `CLAUDE.md` instead.

---

## What problem this solves

The obvious way to build 18 agent folders is to build 18 agent folders. That
fails, and it fails in a specific way.

Every agent needs some of the same text: how status works, what a human is meant
to check, the credit line, the rules it obeys. Copy that text into 18 folders and
you now maintain 18 copies. Fix a wording problem in 1 and the other 17 are
wrong. Nobody notices, because nobody rereads 18 folders.

This is not hypothetical. In the source material sitting in `_source-corpus/`,
1 concept ("ICM") is defined 6 different ways across 6 different documents,
because each was written by hand at a different time.

The factory fixes this by building the agents instead of writing them. The shared
text lives in exactly 1 file. Every build copies it in fresh. Change the one
file, rebuild, and every agent is correct again.

---

## What comes out

A build is a complete workspace with this shape:

```
your-agent/
  CLAUDE.md      what this agent is, and where to go for any task
  CONTEXT.md     the whole workflow as 1 table
  README.md      what a recipient reads first
  01_something/  a step. contains CONTEXT.md, its contract
  02_next/       the next step
  _reference/    the rules that never change between runs
  runs/          1 folder per unit of work, new every run
```

The idea underneath: **the folder structure does the work a framework would do in
code.** Numbered folders carry the sequence. Each folder's `CONTEXT.md` says what
that step reads, does, and writes. State is just files on disk, so you can see
where a run stands by looking at it. 1 agent walks the folders in order.

This is a published method called ICM (credited at the bottom of this file), not
something invented here.

---

## How a build happens

5 stages. Every one ends with you reading something and approving it before the
next stage runs.

| Stage | What happens | You check |
|---|---|---|
| `00_intake` | You get interviewed, or an existing folder gets read | The repeating unit, the stopping points, and what ships |
| `01_form` | Your workflow becomes a numbered stage plan | Every stage boundary is a real place work stops |
| `02_scaffold` | Every file of the new agent gets written | Contracts name exact paths, not vague ones |
| `03_emit` | Shared text is copied in, the folder is assembled | It reads correctly to someone with no context |
| `04_validate` | The gate's checks run, then a cold read | The checks pass, and the folder makes sense cold |

Nothing moves forward on its own. Each stage writes a plain markdown file, you
open it, edit anything wrong, and change 1 line from `status: draft` to
`status: approved`. The next stage refuses to run until you do.

That refusal is the design, not friction. An agent that runs 5 steps unsupervised
produces 5 steps of compounding mistakes.

Everything a run produces lands in 1 folder, `runs/<slug>/`:

```
runs/video-pipeline/
  00-intake.md       what you were asked, or what the folder said
  01-plan.md         the form and the stage plan
  02-scaffold/       every file of the new agent, before assembly
  03-emit-log.md     what was written and which blocks were used
  04-gate-report.md  every check, and the cold read
```

The `stages/` folder holds contracts only and is never written to. So a run
cannot leave anything behind, and it cannot reach another run's files. The
factory is clean between runs because nothing in it belongs to a single run.

Run folders are kept after a build ships. They are a few markdown files, and they
are the only record of why a build looks the way it does.

---

## Where to start

**If you have an idea and want an agent for it:** say so. You will be asked which
door, and this is door A. Then you get interviewed: about 7 questions, a few at a
time, about what you actually do. The questions are in
`_reference/intake-questions.md` if you want to see them first.

**If you have a folder of notes, docs, or an old project:** name the folder. That
is door B. It gets inventoried and read, and the same 7 questions get answered
from what is in the material. Anything concluded rather than found is marked
`inferred`, and you correct those before it proceeds.

Both doors produce the same file, and nothing downstream can tell which one you
used.

The 5 questions that decide the shape of your agent:

1. What is the repeating unit of work? (1 run produces 1 of these)
2. Walk through 1 run, start to finish.
3. Where do you stop and check something before continuing?
4. What stays the same every run, and what is new every run?
5. What does done look like? What artifact leaves?

Question 3 is the one people skip and shouldn't. Your stopping points become the
approval gates, and an agent with no gates is not an agent, it is a script.

---

## What is in this folder

| Path | What it is |
|---|---|
| `CLAUDE.md` | The entry file. Routes to everything, holds nothing. |
| `CONTEXT.md` | The 5 stages as 1 table. The whole system in 10 seconds. |
| `stages/` | The 5 stages. Each has a `CONTEXT.md` that is its contract. |
| `_reference/` | The rules the factory obeys. `_reference/blocks/` is the single home for shared text. |
| `_templates/` | The blank skeleton every build starts from. |
| `_system/` | The gate scripts. |
| `_source-corpus/` | Raw material: the ICM method, and old tool packages to convert. |
| `runs/` | 1 folder per run. Working files and the audit trail. |
| `builds/` | Finished agents. **This is the product.** |
| `change-log.md` | What changed in the factory and why. |

An underscore prefix means "about the workspace, not of the work". Those folders
sort to the top and you can mostly ignore them while running a build.

---

## The 2 rules that keep it honest

**1. Shared text has 1 home.**

Anything appearing in more than 1 built agent lives in exactly 1 file under
`_reference/blocks/`. During scaffolding, a marker is written where the text
goes. During emission, the real text is copied in.

So the built agent is fully self-contained, *and* the text is authored in 1
place. Both, not either. To change it: edit the one file, then rebuild. Never
edit text inside a finished build, because the next rebuild silently reverts it.

**2. The gate blocks.**

`_system/validate.sh` returns a failure if any check trips. The checks are the
labelled sections of the script, and its header is the list. Read them there
rather than here, so this page cannot fall behind the script.

There is no ship-anyway flag. A failure gets fixed in the factory and the build
gets re-run. Patching the build by hand would work once and then vanish.

`_system/audit-builds.sh` runs all of that across every finished build, so when
you change a block or a rule you find out immediately which already-delivered
agents no longer match.

---

## Running the checks yourself

```
bash _system/validate.sh <slug>    # gate 1 build
bash _system/audit-builds.sh       # re-check every build
bash _system/voice-check.sh <path> # writing rules only
```

Exit code 0 means pass, 1 means blocked. A file the script cannot read counts as
a failure, never a pass: a check that reports clean on a file it never opened is
worse than no check, because it is the one you believe.

---

## 1 writing rule worth knowing up front

No em dashes. Anywhere: files, contracts, commit messages, replies. Use a period,
a comma, a colon, or parentheses. It is enforced mechanically and it will block a
build.

The rest of the writing rules are in `_reference/voice.md`. The one that matters
most for quality: a human check must be a verb someone performs on a named thing.
"Read the findings against the transcript, line by line" is a check. "Review the
output" is not, and the gate rejects it.

---

## Credit

The method is **Interpretable Context Methodology (ICM)**, created by Jake Van
Clief and David McDermott. arXiv:2603.16021, MIT-licensed.
https://arxiv.org/abs/2603.16021

The method itself is vendored in `_source-corpus/ICM-architect/`. This factory is
an application of it, not a replacement for it.

## License

MIT, in `LICENSE`. The vendored method keeps its own MIT license inside
`_source-corpus/ICM-architect/`, in the authors' names.
