# The Folders ARE The Automation

Most people open an AI tool and start typing. That is backwards, and it is
why their results feel like a slot machine. Same prompt on Tuesday, different
answer on Thursday.

Here is the fix, and it costs nothing.

## You are not writing code. You are writing a job description.

Before I build anything, I make a folder and I put 1 plain English file in it
that says what the project is, who it is for, and what it has to do.

That is the whole ceremony. `mkdir` and a markdown file.

Then the prompt comes out of the file instead of out of my head. Every prompt
after that has the same context, because the folder holds the context. I am
not re-explaining my business every session. I am not hoping it remembers.

## Why this beats a better prompt

A prompt lives for 1 message. A file lives forever.

When I say "build the page," the AI reads the folder first. It already knows
what the thing is, who it is for, and what it must not do. I am not stuffing
that into a prompt box every time and praying.

That is the difference between a folder system and a prompt pack. Prompt packs
go stale the moment your project changes. A job description does not, because
you update the file and every prompt after it inherits the change.

## The structure I used on camera

I built buildmarketclose.com live. The folders were:

```
buildmarketclose/
├── CLAUDE.md          the map, and the hard rules
├── CONTEXT.md         the router, match a task to its one home
├── _config/           what this IS, who it is for, what it must do
├── 01_build/          the page itself
├── 02_market/         how people find it
└── 03_close/          how that turns into money
```

Look at the numbered folders. Build, market, close. **The folder names spell
the domain.** That was not decoration. When I tell the AI "put that in market,"
it knows exactly where that goes and why, and so do I 3 weeks later.

## CLAUDE.md is the first thing it reads

There is 1 file the AI always opens first. Mine holds the map and the rules
that must never be broken. On this project 1 of those rules was "nothing is
ever for sale on this domain."

That rule is in a file, not in my memory. So it holds even on a session where
I forget, or when somebody else picks the project up.

**Write the rules down where the AI reads them, not where you hope to
remember them.**

## The 1 habit worth more than the rest

Keep your copy in its own file, apart from the code.

Headline, button text, email copy. All in markdown, not buried in the page.
Then changing a headline takes 10 seconds instead of hunting through a file
you do not understand.

I said that out loud while building and then followed it, which is why the
headline on that page got rewritten 6 times in an hour without breaking
anything.

## Run this prompt

```
I want to build [WHAT YOU ARE BUILDING] and I want to set it up as a folder
system before I write anything.

Here is my situation:
- What the thing is: [1 OR 2 SENTENCES, PLAIN ENGLISH]
- Who it is for: [1 PERSON, NOT A DEMOGRAPHIC. What does a bad Tuesday
  look like for them?]
- What it must do: [THE 3 JOBS IT HAS TO DO]
- What it must NOT do: [THE THINGS YOU ARE DELIBERATELY LEAVING OUT]

Do this in order:

1. Make the folder structure. Name the numbered folders after the actual
   stages of MY work, not generic names. Tell me why each folder exists as
   you create it.
2. Write _config/what-this-is.md from my answers above, in plain English,
   the way I would explain it to a friend.
3. Write CLAUDE.md with the map and any hard rules that must never be
   broken on this project. Ask me what those rules are if you are not sure.
4. Then STOP. Do not build anything yet. Read what you wrote back to me and
   tell me what is vague or contradicts itself.

Rule for everything after this: keep all copy in its own markdown file,
never buried in code.
```

If step 4 comes back and the description is mush, the file is mush. Fix the
file, run it again. That is 10 minutes that saves you an afternoon building
the wrong thing.

Always got your back,
RyMac
