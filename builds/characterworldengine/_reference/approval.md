# Approval, what counts and what never does

Every file in this folder moves from `status: draft` to `status: approved` by
the operator's decision and nothing else. This file says what that decision
looks like, because the agent runs inside a chat host where the operator often
does not open files, and an agent that has just finished a job is the worst
judge of whether the job is approved.

## 2 ways to approve

1. **By file.** The operator opens the output, edits it, and writes
   `status: approved` in its frontmatter. A render record also gets its
   `verdict`.
2. **By a named decision in chat.** The operator names the file and says
   approve or reject: "approve `runs/city/gate/01-spec-2.md`", "reject render
   2, the jaw is rounded". The agent writes exactly that into the named file,
   quotes the operator's words in the file (a render record puts them under
   **Drift notes**), then reads the file back and reports the line it now
   carries. The decision has no effect until it is on disk.

A decision names files. "Approve the 3 location files" names 3 files.
"Approve the world" names none, and the agent asks which.

## What is never approval

- `ok`, `saved`, `looks good`, `go ahead`, or silence.
- An instruction to do work: "restructure the environment", "run all the
  locations". That authorizes the run; the outputs it produces are
  `status: draft` like any other.
- A passing structural test, a clean gate, a finished render, a completed
  migration.
- Approval of a parent. An approved `world/environment.md` approves none of
  the files it routes to; each module, location, bible, and reference record
  is approved on its own.
- An earlier approval of the same facts in a different file. A fact that moved
  is a draft where it landed.

## Reopening

An approved world file is edited only through a `00_setup` revision. The
operator names the files and the change; the agent sets those files to
`status: draft`, makes the change, and leaves every other file as it was.
Reopening is authorization to edit, not approval of the result.

## Rejection

A rejected output stays `status: draft`. A rejected render record carries
`verdict: drifted` and the operator's reason under **Drift notes**, in the
bible's words where possible, so `01_spec` can guard it on the next attempt.
