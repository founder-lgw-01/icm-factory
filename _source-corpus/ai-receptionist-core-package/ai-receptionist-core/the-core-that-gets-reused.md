# The Core That Gets Reused

Everybody thinks an AI receptionist is a prompt.

It isn't. A prompt is one good answer. A business needs the same good answer on
call 400, at 2am, when the person on the other end is angry.

I've got 2 of these running right now. One answers for a chiropractor. One
answers for my software company. They sound like completely different people
because they are doing completely different jobs.

They run on the identical 6 numbered folders.

## What "the core" actually means

The core is the part I don't rebuild.

When I took on the chiropractor, I didn't start from nothing. I copied a folder.
Then I changed the text files inside it that describe who she is and what she's
answering the phone for.

That's the difference between having built one AI receptionist and having a
business that builds them.

## The 2 I walked through on camera

Dr Chen's front desk answers for a chiropractic practice. People calling her are
in pain right now. Her job is to hear that, react to it, and get them on the
calendar fast.

Ally answers for Allodra. People calling her are shopping for software. Her job
is to run them through an application and screen out the ones who aren't a fit.

Warm and sympathetic on one line. Direct and a little irreverent on the other.

Same voice engine. Same phone setup. Same 6 folders, in the same order.

## Why the order matters more than the contents

The folders are numbered, and they're numbered because the build has an order.

You write who she is before you give her a phone number. You set up the calendar
before you set up the phone. You call her and grade her before you let anybody
else call her.

Do it out of order and you end up with a voice that sounds great and books
nothing, or a booking system nobody can reach.

The numbers aren't decoration. They're the order you do the work in.

## The part people miss

You may hear this called an agent architecture. It means the folders your AI
reads before it opens its mouth.

There's no software here. No platform. Nothing to log into.

This is the desk. Everything else is drawers.

When I want a receptionist for a roofer tomorrow, I copy the folder and I point
it at a roofing company. The 6 folders don't move. Only what's written inside 3
of them changes.

## What this is worth to an agency

If you run an agency, you already know the version of this that hurts.

You built something good for client 1. Client 2 shows up wanting the same thing.
And you rebuild it, because the first one lives half in a chat window, half in
somebody's head, and half in a tool you're still paying for.

The reason you rebuild is that there was never a core. There was one delivery
that happened to work.

A core is the thing you copy.

---

## Run this prompt

Paste this into Claude, or whatever you use, along with a description of the
last thing you built for a client.

```
I built something for a client and I want to know whether I have a reusable core
or a one-off delivery.

Here is what I built:
[describe it: what it does, who it was for, where the instructions live right now]

Here is what a second client would want:
[describe the next client and how their version would differ]

Do this for me:

1. List every piece of what I built. For each one, say whether it is TRUE FOR
   EVERY CLIENT or TRUE FOR THIS CLIENT ONLY.
2. Tell me how many of the CLIENT ONLY pieces there are. That number is how many
   files I would have to change to serve client 2.
3. Tell me where each piece currently lives. Flag anything that lives only in a
   chat window, only in a tool I rent, or only in my head. Those are the pieces
   that will not survive being copied.
4. Give me a numbered folder structure where the EVERY CLIENT pieces sit in
   folders I never touch again, and the CLIENT ONLY pieces sit in text files I
   swap.
5. Tell me the order those folders have to be built in, and why that order and
   not another one.

Be blunt about it. If I do not have a core and I just have one delivery, say so
in the first line.
```

---

Watch it happen: https://www.youtube.com/watch?v=_gV242QeLCw

Want the folder system itself, free: https://filesnfolders.com/?utm_source=skool&utm_medium=post&utm_campaign=ai-receptionist-core

The folder methodology is Jake Van Clief's: https://www.skool.com/cliefnotes/about?ref=9c88227ce23c4b55abc702ac5d299077
