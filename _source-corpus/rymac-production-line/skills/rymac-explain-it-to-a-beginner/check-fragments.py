# -*- coding: utf-8 -*-
"""
THE FRAGMENT SWEEP.

The rule, in the owner's words:

    "fragments and short sentences are a copy sales effect.
     DO YOU TEACH KIDS IN FRAGMENTS?"

    "You are not allowed to write fragments in the teaching skill."

He is right, and it is the whole difference between the 2 jobs.

A fragment is a SALES device. It stops the eye. It creates a beat. It belongs in
a letter, a hook, a VSL, and it is why his sales copy hits.

A fragment is not a TEACHING device. A person who is confused has to work out
what the fragment belongs to before they can learn anything from it. That is
work you handed them instead of doing yourself.

So the rule for anything that teaches:

    I write complete sentences. Every one of them.

HIS fragments stay. He writes them on purpose, he knows what they cost, and an
approval covers his line. This checker points at every fragment. The judgement
is: did he write it, or did I? If I wrote it, it gets rewritten.

    python check-fragments.py <file-or-folder>
"""
import io, os, re, sys

# A complete sentence needs a verb. This lexicon covers the plain English these
# files are written in, imperatives included, because most of it is instruction.
VERBS = set("""
is are was were be been being am arent isnt wasnt werent
has have had having hasnt havent
do does did doing done dont doesnt didnt
can could will would shall should may might must cant cannot wont couldnt
get gets got getting gotten
go goes going went gone
put puts putting
make makes making made
take takes taking took taken
open opens opening opened
read reads reading
write writes writing wrote written
keep keeps keeping kept
move moves moving moved
need needs needing needed
want wants wanting wanted
know knows knowing knew known
see sees seeing saw seen
look looks looking looked
run runs running ran
work works working worked
live lives living lived
say says saying said
tell tells telling told
ask asks asking asked
give gives giving gave given
come comes coming came
start starts starting started
stop stops stopping stopped
fill fills filling filled
hand hands handing handed
pick picks picking picked
delete deletes deleting deleted
cancel cancels cancelling cancelled
answer answers answering answered
watch watches watching watched
join joins joining joined
click clicks clicking clicked
type types typing typed
copy copies copying copied
paste pastes pasting pasted
send sends sending sent
save saves saving saved
find finds finding found
lose loses losing lost
leave leaves leaving left
point points pointing pointed
sit sits sitting sat
fall falls falling fell fallen
hold holds holding held
carry carries carrying carried
show shows showing showed shown
turn turns turning turned
add adds adding added
change changes changing changed
build builds building built
use uses using used
pay pays paying paid
cost costs costing
mean means meaning meant
matter matters mattering mattered
happen happens happening happened
belong belongs belonging belonged
depend depends depending depended
explain explains explaining explained
understand understands understanding understood
remember remembers remembering remembered
forget forgets forgetting forgot forgotten
try tries trying tried
let lets letting
help helps helping helped
stay stays staying stayed
walk walks walking walked
drag drags dragging dragged
rename renames renaming renamed
break breaks breaking broke broken
fix fixes fixing fixed
close closes closing closed
decide decides deciding decided
reopen reopens reopening reopened
update updates updating updated
grab grabs grabbing grabbed
trust trusts trusting trusted
prove proves proving proved
teach teaches teaching taught
learn learns learning learned
charge charges charging charged
promise promises promising promised
deliver delivers delivering delivered
ship ships shipping shipped
list lists listing listed
name names naming named
sort sorts sorting sorted
guess guesses guessing guessed
wait waits waiting waited
reach reaches reaching reached
count counts counting counted
check checks checking checked
run runs
sound sounds sounding sounded
feel feels feeling felt
think thinks thinking thought
call calls calling called
mail mails mailing mailed
own owns owning owned
hire hires hiring hired
quit quits quitting
report reports reporting reported
follow follows following followed
finish finishes finishing finished
repeat repeats repeating repeated
record records recording recorded
upload uploads uploading uploaded
download downloads downloading downloaded
install installs installing installed
set sets setting
chain chains chaining chained
apply applies applying applied
rewrite rewrites rewrote rewritten
score scores scoring scored
cut cuts cutting
belong belongs
survive survives surviving survived
hear hears hearing heard
mention mentions mentioning mentioned
press presses pressing pressed
skip skips skipped
hand hands
create creates creating created
allow allows allowing allowed
enter enters entering entered
exist exists existing existed
include includes including included
contain contains containing contained
remove removes removing removed
replace replaces replacing replaced
choose chooses choosing chose chosen
compare compares comparing compared
describe describes describing described
happen happens
speak speaks speaking spoke spoken
talk talks talking talked
mind minds
bring brings bringing brought
buy buys buying bought
catch catches catching caught
draw draws drawing drew drawn
drive drives driving drove driven
eat eats eating ate eaten
fight fights fighting fought
grow grows growing grew grown
hit hits hitting
hurt hurts hurting
lay lays laying laid
lend lends lending lent
lie lies lying lay
light lights lighting lit
meet meets meeting met
ride rides riding rode ridden
ring rings ringing rang rung
rise rises rising rose risen
seek seeks seeking sought
sell sells
shake shakes shaking shook shaken
shine shines shining shone
shoot shoots shooting shot
shut shuts shutting
sing sings singing sang sung
sink sinks sinking sank sunk
sleep sleeps sleeping slept
slide slides sliding slid
speed speeds speeding sped
spend spends spending spent
stand stands standing stood
steal steals stealing stole stolen
stick sticks sticking stuck
strike strikes striking struck
swear swears swearing swore sworn
sweep sweeps sweeping swept
swim swims swimming swam swum
swing swings swinging swung
teach teaches
tear tears tearing tore torn
throw throws throwing threw thrown
wake wakes waking woke woken
wear wears wearing wore worn
win wins winning won
wind winds winding wound
serve serves serving served
solve solves solving solved
train trains training trained
treat treats treating treated
value values valuing valued
view views viewing viewed
vote votes voting voted
warn warns warning warned
wish wishes wishing wished
worry worries worrying worried
handle handles handling handled
manage manages managing managed
notice notices noticing noticed
offer offers offering offered
order orders ordering ordered
plan plans planning planned
play plays playing played
prefer prefers preferring preferred
prepare prepares preparing prepared
present presents presenting presented
produce produces producing produced
protect protects protecting protected
provide provides providing provided
raise raises raising raised
realize realizes realizing realized
receive receives receiving received
reduce reduces reducing reduced
refer refers referring referred
reflect reflects reflecting reflected
refuse refuses refusing refused
regard regards regarding regarded
relate relates relating related
release releases releasing released
rely relies relying relied
represent represents representing represented
require requires requiring required
respond responds responding responded
rest rests resting rested
result results resulting resulted
return returns returning returned
reveal reveals revealing revealed
review reviews reviewing reviewed
risk risks risking risked
roll rolls rolling rolled
rule rules ruling ruled
scan scans scanning scanned
search searches searching searched
seem seems seeming seemed
separate separates separating separated
settle settles settling settled
shape shapes shaping shaped
share shares sharing shared
shift shifts shifting shifted
sound sounds
split splits splitting
spot spots spotting spotted
spread spreads spreading
store stores storing stored
suggest suggests suggesting suggested
supply supplies supplying supplied
support supports supporting supported
suppose supposes supposing supposed
switch switches switching switched
target targets targeting targeted
test tests testing tested
touch touches touching touched
track tracks tracking tracked
transfer transfers transferring transferred
travel travels travelling travelled
trigger triggers triggering triggered
dump dumps dumping dumped
quote quotes quoting quoted
aim aims aiming aimed
sold
sweep sweeps
fire fires firing fired
strip strips stripping stripped
lock locks locking locked
ban bans banning banned
model models modeling modeled
phrase phrases phrasing phrased
select selects selecting selected
lead leads leading led
drop drops dropping dropped
hunt hunts hunting hunted
spell spells spelling spelled
cover covers covering covered
mark marks marking marked
land lands landing landed
mail mails mailing mailed
skip skips skipping skipped
sign signs signing signed
""".split())

SKIP_PREFIX = ("|", ">", "```", "---", "http", "===")


def is_data_line(line):
    """A path, a heading, a table row, a code block, an indented sample."""
    s = line.rstrip()
    if not s.strip():
        return True
    if s.startswith("    ") or s.startswith("\t"):
        return True
    if s.lstrip().startswith(SKIP_PREFIX):
        return True
    if re.match(r"^\s*#{1,6}\s", s):          # markdown heading
        return True
    if re.match(r"^[A-Z0-9 ,'\-]+$", s.strip()) and len(s.strip()) < 60:
        return True                            # ALL CAPS label
    if re.match(r"^[a-z0-9_\-]+/\s*$", s.strip()):
        return True                            # folder label
    if "/" in s and " " not in s.strip():
        return True                            # a bare path
    return False


def sentences_of(path):
    """Yield (line_no, sentence) for every prose sentence in the file."""
    lines = io.open(path, encoding="utf-8").read().replace("\r\n", "\n").split("\n")
    para, at = [], 0
    out = []
    fenced = False

    def flush():
        if not para:
            return
        text = " ".join(para)
        text = re.sub(r"`[^`]*`", "X", text)
        text = re.sub(r"\*\*|__|\*", "", text)
        text = re.sub(r"https?://\S+", "X", text)
        text = re.sub(r"^\s*[-*]\s+|^\s*\d+[.)]\s+", "", text)
        for s in re.split(r"(?<=[.!?])\s+", text):
            s = s.strip()
            if s:
                out.append((at, s))

    for i, line in enumerate(lines):
        if line.lstrip().startswith("```"):     # a template block is not prose
            fenced = not fenced
            flush(); para, at = [], 0
            continue
        if fenced:
            continue
        if is_data_line(line):
            flush()
            para, at = [], 0
            continue
        if not para:
            at = i + 1
        para.append(line.strip())
    flush()
    return out


SIGN_OFF = re.compile(r"always got your back|your-name-here|your-site\.com", re.I)  # EDIT: your own sign-off words, so the gate skips them


def is_fragment(s):
    words = re.findall(r"[A-Za-z']+", s.lower())
    if len(words) < 3:                 # "Semper Fi," and the like
        return False
    if SIGN_OFF.search(s):             # the sign off block is not prose
        return False
    if "<" in s and ">" in s:          # a template placeholder, not prose
        return False
    if s.startswith("Example:") or s.startswith("X "):
        return False                   # a worked example or a stripped path
    if re.match(r"^-?\s*X?\s*[A-Z][A-Za-z ]{0,40}\.$", s) and len(words) <= 6:
        return False                   # a bolded label leading a list item
    if s.rstrip().endswith(":"):       # a lead in to a list or a code block
        return False
    if s.rstrip().endswith("?"):       # a question is a sentence
        return False
    # A contraction carries its verb in the tail. "You'll", "you're", "we've",
    # "I'd", "I'm" and "isn't" are all complete verbs, but stripping the
    # apostrophe turns them into "youll" and "isnt", which no lexicon holds.
    #
    # The owner writes in contractions ("I don't want you to
    # guess", "you don't skip start-here.md") and this checker was flagging
    # those sentences as fragments. That trained sessions to rewrite his
    # contractions into "do not" to make a gate go green, which is sanding his
    # voice off to satisfy a tool. The tool was wrong, not the sentence.
    #
    # "'s" is left out on purpose. It is a possessive as often as it is a verb
    # ("the client's folder"), so counting it would wave real fragments through.
    for w in words:
        low = w.lower()
        if low.endswith("n't") or low.endswith("n’t"):
            return False
        if "'" in low or "’" in low:
            if re.split(r"['’]", low)[-1] in {"ll", "re", "ve", "d", "m"}:
                return False
    return not any(w.replace("'", "") in VERBS for w in words)


def check(path, quiet=False):
    hits = [(ln, s) for ln, s in sentences_of(path) if is_fragment(s)]
    for ln, s in hits:
        print("    X line %-4d %s" % (ln, s[:92]))
    print("   %s %s" % ("ok" if not hits else " X",
                        "every sentence is a sentence" if not hits
                        else "%d fragment(s)" % len(hits)))
    return len(hits)


def main():
    target = sys.argv[1] if len(sys.argv) > 1 else ""
    if not target:
        print("usage: python check-fragments.py <file-or-folder>")
        return 0
    files = []
    if os.path.isdir(target):
        for root, _, names in os.walk(target):
            if "_build" in root:
                continue
            for nm in sorted(names):
                if nm.endswith((".md", ".txt")):
                    files.append(os.path.join(root, nm))
    else:
        files = [target]
    total = 0
    for f in files:
        print("\n=== " + f.replace("\\", "/"))
        total += check(f)
    print("\nfragment sweep: " + ("CLEAN" if total == 0 else "%d fragment(s)" % total))
    print("His fragments stay. Mine get rewritten as sentences.")
    return 1 if total else 0


if __name__ == "__main__":
    sys.exit(main())
