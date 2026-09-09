# Term Sheet

Every term of art from the video, in plain language. No jargon used to explain
jargon.

## The metaphor, and what each piece really is

| What I called it | What it actually is |
|---|---|
| the desk | the context window |
| the stuff on the desk | context |
| the card taped to the desk | a file called `CLAUDE.md` |
| a drawer | a folder |
| the folder it pulls out | a file called `CONTEXT.md` inside that folder |
| numbered drawers | folders named `01_`, `02_`, `03_` for stages that happen in order |
| looking at it before it goes back | the human review gate |

## The terms

**Context window.** How much the AI can hold in front of it at one time. It is
finite. When it fills up, things fall off, and it does not tell you.

**Context.** Everything the AI can see right now: your question, the files it
read, the conversation so far, its instructions.

**Falling off the desk.** When something drops out of the context window. The
answer keeps coming, confidently, just without that piece. This is why the
same prompt gives a worse answer on a different day.

**CLAUDE.md.** A plain text file at the top of a folder that gets read first,
every time. It says what the folder is for, where things live, and what not to
touch. A map, not the work.

**CONTEXT.md.** The same idea one level down. Lives inside a specific folder
and says how to work on that one thing.

**Markdown ( .md ).** A text file with light formatting. A `#` makes a
heading, a `-` makes a bullet. That is most of it. You can open one in
Notepad. It is not code.

**Interpretable Context Methodology (ICM).** The name for all of this. Folders
and markdown files arranged so a single AI can navigate them, instead of a
framework coordinating a team of AI agents. "Interpretable" means a human can
open any file and read it. Nothing is hidden inside software.

**Multi agent framework.** A setup where several AI agents each do a job and
hand off to each other. The 6 desks. Powerful in a demo, and it means every
agent has to be told everything from scratch because none of them can see the
others' desks.

**Orchestration.** Deciding which thing runs when. In ICM the folder structure
does this, which is why you do not need a framework to do it.

**Token.** The unit AI reads and bills in, roughly 3/4 of a word.
Fewer tokens loaded means cheaper and more room on the desk.

**Token reduction.** Loading only what is needed instead of everything. You
will see percentages quoted for this. I did not measure it myself so I am not
repeating a number.

**Context engineering.** Deciding what goes on the desk and what does not.
That is genuinely all it means.

**Review gate.** The point where you open the file and check it before the
work moves to the next stage. The thing that keeps you in control.

**Agent.** An AI that can take actions on its own, like reading and writing
files, not just replying to you.

**Repo / repository.** A project folder whose change history is tracked. If
you are not writing software you can read this as "the project folder."

## Who made this

The methodology is **Jake Van Clief and David McDermott's**. They named it,
they built it, and the thinking is theirs. I translated it for myself because
I could not use it until I could picture it.
