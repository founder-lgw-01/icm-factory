# Why I Killed The Multi-Agent Workflow

Everybody selling AI right now wants you building a team of agents. A
researcher agent, a copywriter agent, a developer agent, a manager agent to
boss the other 3 around.

I built that. Then I threw it away, and my output went up.

## What actually happened

I had a multi-agent workflow running and I ended up doing this: telling this
department of this agent about this other agent. Explaining agent 1's output
to agent 2. Re-explaining my business to agent 3 because it never saw what
agent 1 did.

I was not running a team. I was running meetings.

Every handoff between agents is a place where context falls on the floor. And
you pay for each handoff twice, once in tokens and once in your own time
re-explaining what the last one already knew.

## The swap

Now it is 1 agent, plus files and folders, plus skills.

The context does not live in an agent's head where it evaporates. It lives in
the folder, where it stays. The agent reads the folder, does the work, writes
back to the folder. Next session it reads the same folder and picks up where
it left off.

I do not brief it. It briefs itself.

## The part that actually saved me

What I got tired of was losing work. Retraining it. Re-teaching it the same
things I taught it last Tuesday.

That is not an AI problem. That is a storage problem. You were keeping
context somewhere that does not persist.

Files persist. Folders persist. Skills persist.

## What a skill is, plainly

A skill is a set of instructions you write once that the AI loads when it
needs them. Instead of pasting your headline rules into every chat, you write
them down once and the AI picks them up automatically whenever it writes a
headline.

That is the compression. Not a smarter model, the same model that stops
forgetting.

Mine are free at github.com/oathdriven/rymac-skills. Take them, change them,
make them sound like you.

## When more than 1 agent IS right

I am not against fanning out. On this build I ran 3 research agents at once
on purpose, because they were doing genuinely separate jobs in parallel and
I only needed the conclusions back.

That is the test. **Fan out when the work is genuinely parallel and you only
need the answers.** Stay with 1 agent when the work is sequential and the
context has to carry forward.

Most people fan out for work that is sequential. That is where the meetings
start.

## Run this prompt

```
I have been running a multi-agent setup for [WHAT YOU ARE DOING WITH IT] and
I want to collapse it into 1 agent plus a folder system.

My current setup:
[DESCRIBE YOUR AGENTS AND WHAT EACH ONE DOES. If you are using a tool that
builds these for you, describe the flow instead.]

The problems I actually have: [WHERE CONTEXT GETS LOST, WHAT YOU FIND
YOURSELF RE-EXPLAINING, WHAT BREAKS]

Do this:

1. Tell me which of my agents exist because the work is genuinely parallel,
   and which exist only because I split up sequential work. Be blunt.
2. For the sequential ones, design the single folder structure that replaces
   them. What files hold the context each agent was holding in its head?
3. Write the 1 context file that the single agent reads first.
4. Tell me which of my repeated instructions should become a skill, meaning
   something written once and loaded automatically instead of pasted every
   time.
5. Tell me what I lose in this trade. Do not pretend there is no downside.
```

Step 5 matters. If it tells you there is no downside, push back, because
there always is. Usually it is raw speed on genuinely parallel work. Decide
with that in front of you.

Always got your back,
RyMac
