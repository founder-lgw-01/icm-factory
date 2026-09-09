# Grade Her Like An Employee

Nobody hires a receptionist, sits them at the desk, and walks away.

You listen to a few calls. You tell them the 2 things they got wrong. They fix
them and you stop listening.

That's the entire training process for an AI receptionist, and almost nobody
does it. They build it, it answers once, and they ship it.

## What I actually do

I call her.

Then I take the transcript of that call, and I have my AI grade it against a
sheet of what a great call looks like for that business.

Not "did it sound good." A list of specific things she was supposed to do, each
one marked done or not done.

## The sheet for Chen's front desk

These were the checks:

Open warm, like a practice would.

React with sympathy before asking anything. Somebody in pain calls and the first
thing they hear should not be a question.

Never use the same opener twice.

Restate the pain back to them so they know they were heard.

Ask about the pain, and when it started.

Get a commitment. Do they want to see a doctor now, or wait for the pain to go
away.

Offer real appointment times.

Close.

## What she scored

9 of 11 on the first call.

She skipped the part where she asks when the pain started. And when she offered
appointment times, she offered 5 or 6 of them when she was supposed to offer 3.

That was the entire list of what was wrong with her.

So I told the system to fix those 2 things, it wrote them into the text file,
and I called her again.

Start to finish, that build was 30 minutes of my time.

## Why 2 findings beats a perfect first attempt

You cannot write a perfect receptionist on paper.

You can write a decent one in a few minutes, call it, and find out the 2 exact
places it falls down with a real human on the line.

Guessing at 11 checks in advance takes longer and gets you fewer of them right.

The call is the spec. Everything before the call is a draft.

## The part that makes this a business and not a favour

The grade sheet is a file. It sits in the folders with everything else.

Which means when the roofer shows up, I'm not inventing a way to test the
roofer's receptionist. I'm copying a grading process and changing what a great
call looks like for a roofer.

Same 6 folders. The test travels with them.

An agency that can prove the thing works before the client ever hears it is
selling something different from an agency that hands over a build and hopes.

## What it costs to run

Roughly 8 cents a minute for mine.

I say 6 to 10 in the video because it moves a little with how complex she is.
Ally costs slightly more than Chen's front desk because she does more.

Worth knowing before you quote anybody, and worth checking yourself rather than
taking my number for it.

---

## Run this prompt

Do this after you've made one real call to whatever you built.

```
I built an AI that talks to my customers, and I want to grade it the way I would
grade a new employee instead of guessing whether it sounded good.

The business is:
[what it does, who calls, what a call is supposed to end in]

Here is the transcript of a real call I just made to it:
[paste the transcript]

Do this for me:

1. Before you read the transcript, write the list of things a GREAT call for
   this business does, in order, from hello to booked. One line each. This is
   the grade sheet.
2. Now go through my transcript and mark every item on that sheet done or not
   done. Quote the line where it happened, or say plainly that it never happened.
3. Give me the score as a number out of the total.
4. List ONLY the failures, ranked by how much money each one costs me.
5. For the top 2 failures, write the exact sentence I should add to the
   instruction file to fix it. Not advice about it. The sentence.
6. Tell me what to say on the retest call to prove those 2 are fixed.

Do not soften the grade. A generous score costs me real bookings.
```

---

Watch it happen: https://www.youtube.com/watch?v=_gV242QeLCw

Want the folder system itself, free: https://filesnfolders.com/?utm_source=skool&utm_medium=post&utm_campaign=ai-receptionist-core

The folder methodology is Jake Van Clief's: https://www.skool.com/cliefnotes/about?ref=9c88227ce23c4b55abc702ac5d299077
