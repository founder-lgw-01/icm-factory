# Term Sheet

Every term from the video, in plain language. No question in this community
is too basic. This file exists so you never have to ask "wait, what is a
sub-account?"

## The build

**Claude Code** · A program that runs in a terminal and does the work when you
type English at it. The thing doing the building in the video.

**Terminal** · The black text window programmers use. Looks scary, is just a
place where you type.

**ICM** · Interpretable Context Methodology. The folder system in this video.
Folders and plain English files that hold the context so the AI reads it
instead of you re-explaining it. Jake Van Cleef's method, credited in the
video.

**CLAUDE.md** · The first file the AI reads in a project. Holds the map and
the rules that must never be broken. Yours can be 10 lines.

**Markdown / .md** · A plain text file with light formatting. Opens in
Notepad. Nothing to install.

**Scaffold** · Creating the empty folder structure before there is anything in
it. Framing the house before the walls go up.

**Skill** · Instructions you write once that the AI loads automatically when
it needs them, instead of you pasting the same rules into every chat.

**Repo / repository** · The folder holding your project, tracked so you can
see every change and roll back. GitHub stores them.

**git push** · Sending your latest work up to GitHub. What makes deploy happen
in the video.

**Deploy** · Putting your site on the internet so other people can load it.

**Vercel** · The service that hosts the page. Free tier is real. The hosting
bill in the video was $3.43 for 3 weeks.

**Cloudflare** · Where the domain name lives and where DNS records get added.

**DNS record** · The instruction that tells the internet where your domain
points. Change it, wait a few seconds, the internet catches up.

**A record / CNAME / MX / TXT** · Types of DNS record. A and CNAME point a
domain at a server. MX handles mail. TXT holds text used to prove you own a
domain.

**DKIM / SPF** · TXT records that prove your emails are really from you.
Without them your email lands in spam.

**Serverless function** · A small piece of code that runs only when someone
calls it. The 1 bit of real code on the page in this video, and it exists
only because a browser cannot talk to the CRM directly.

**CORS** · The browser rule that stops a page on 1 domain talking to another
domain. The reason that function has to exist.

**Honeypot** · A hidden form field humans never see and bots fill in. Fills
in, you throw the submission away.

## The page

**Squeeze page** · A page with 1 job: trade something free for an email
address. No nav, no menu, no second option.

**Above the fold** · What you see before scrolling. On a phone that is not
much, which is why it matters.

**Eyebrow** · The small line above the headline. Usually who the page is for.

**Hero** · Eyebrow, headline, support line and the button. The top of the page.

**CTA** · Call to action. The button, and what it says.

**Risk reversal** · The small line under the button that kills the reason
they would not click. "Free. 1 field. No call, no pitch."

**Attention ratio** · Number of things to click versus number of goals. On a
squeeze page it should be 1 to 1.

**Message match** · The page says what the ad or video that sent them there
promised, in the same words.

## The selling

**Sophistication stage** · How burned out a market is, 1 to 5. Stage 1 has
never heard the claim. Stage 5 has heard everything and believes none of it.
Changes what your headline is allowed to do.

**Awareness level** · How much the reader already knows when they land.
Someone arriving from a 90 minute video knows a lot. Do not re-explain.

**Verbatim mining** · Collecting the exact words customers use, unedited.
Paraphrasing launders out the thing you went looking for.

**Lead magnet** · The free thing you trade for an email.

**Relationship sequence** · The emails that go out after someone opts in. Not
a sales sequence. The point is that they keep opening.

**Deliverability** · Whether your email reaches the inbox or spam.

**Reactivation** · Waking up subscribers who went quiet. Cheapest is a new
asset landing in their inbox months later.

## The backend

**CRM** · Where your contacts, deals and automations live.

**Sub-account / seat** · One isolated workspace inside a CRM, per brand or
client. This build got seat number 1008.

**Workflow** · The automation. A trigger, then steps. Ours is form submitted,
then 22 emails over 57 days.

**Sending domain** · The domain your automated email sends from. Usually a
subdomain like mail.yoursite.com, kept separate so email problems never
damage your main domain's reputation.

**Resend** · The service that actually sends the email.

**PII** · Personally identifiable information. Other people's names, emails,
data. If it lands on screen while recording, it gets masked before upload.
That happened in this video and got fixed.
