# Spec rules, how a shot spec and its prompt are built

A spec is the judgment call surfaced as a file before the expensive step.
Every decision the render acts on is readable and editable in the spec. The
prompt is its last section and is derived from the sections above it. A prompt
written first, with a spec fitted around it, is a defect.

## Select inputs before composing

`world/environment.md` is a router. Read it to select, not to learn the world.

Always load `world/environment/core.md`, `world/environment/palette-lighting.md`,
`world/style.md`, and the bible of each character the brief names. Load
another module only when the shot shows its domain: architecture when built
forms are in frame, materials when surfaces need naming, terrain-vegetation
when land or plants are in frame, topology when a route, a level change, or
water is in frame. Load a location only when the brief names it as visible;
a location's link to a neighbor is adjacency, not a selection. Follow each
selected location's `depends_on` list. Its `reference_roles` are candidates:
select the roles this shot needs, read only those `### <role-id>` sections in
`world/references/<image-stem>.md`, and give each 1 visual job. The image
itself is never loaded; the host sends text.

Every selected file must say `status: approved`. A draft the shot does not
select blocks nothing. A rule in a local file that contradicts core, style, or
a bible stops the stage: the contradiction goes to `00_setup`, never to a
guess in the spec. A brief cannot authorize a local exception to a global rule.

## Sections, in order

**1. Brief.** Every field of `00-brief.md`, filled. Where the operator left a
field empty, the question asked and the answer given, in the operator's words.
A field the operator answers "you choose" is filled here and marked `chosen`,
so the operator sees the choice before the render. A choice among modules,
locations, or roles inside approved canon is `chosen` without a question.

The brief's **Concept** field gets its own line here, **Concept**, in 2 parts:
the idea as the brief states it, and the carrier, the 1 element in frame that
makes it visible (a prop from a bible, a location, an action, a label). If the
carrier is a label, the exact words are quoted here and nowhere else. A concept
with no carrier stops the stage and asks the operator; a carrier that is not in
a bible and not in the brief is invented, and is not used.

Brief ends with the **World-input manifest**, 1 row per file the spec loaded:

| Path | Selected roles | SHA-256 |
|---|---|---|
| `world/environment/core.md` | n/a | the 64-hex digest of the file's exact bytes |

Every loaded file is a row: the router, core, palette-lighting, style, each
character, each module and location selected, each reference record whose role
was selected, with every selected role id in its row. Hash the file as
approved, with a tool, frontmatter included; never an excerpt, never a
normalized copy, never a digest from memory. The manifest is what `02_render`
verifies before it sends anything: a missing file, a draft, or a changed hash
stops the render, and the fix is a new spec, never a refreshed hash.

**2. Characters in frame.** For each character the brief names, in the order
they matter to the shot:
- the invariants, copied from the bible as written, not paraphrased. The
  silhouette, the signature features, the face lines the shot will show, the
  build.
- the variables, set for this shot: expression, pose, wardrobe state, props.
  Each inside the range the bible allows. A value outside the range stops the
  stage and asks the operator.
- with 2 or more characters: relative height and build against each other,
  copied from the bibles, and where each stands in frame.
- the roles selected for this character, by path and role id, each with its 1
  job. No 2 roles control the same trait.

**3. Scene.** The selected locations and modules, named by path, and only
their facts that apply to this frame: what is visibly there, what is
underfoot, where the light comes from, the time of day and its lighting-rules
row, the palette as it applies here, weather if the brief names it. Copy the
applicable fact and its source; never paste a module or location whole. Then:

- **Style facts**: the look, word for word; the medium and finish; the
  applicable composition rules; the exclusions. Frozen here so `02_render`
  audits style without reopening `style.md`.
- **Reference plan**: at most 1 primary environment reference, by path and
  role, for architecture and composition. Each supporting role by path, with
  the 1 trait it lends. `none` when no role is needed; a role is never chosen
  because it exists. The plan agrees with the manifest.
- **Dominant architectural family**, when built forms are in frame; otherwise
  `not applicable`. A secondary motif only where the approved world allows the
  pair, as 1 localized accent that never repeats across the frame or controls
  a landmark. Nothing is averaged into a hybrid.
- **Focal hierarchy**: the subject or action first, at most 1 destination or
  secondary anchor second, everything else subordinate. Where detail clusters;
  where the frame stays quiet. The world's vocabulary is a menu: name only the
  anchors this frame needs.
- **Topology statement**: how visible routes and levels connect. Every
  visible river, canal, stream, or channel enters from a source or the frame
  edge and leaves to an outlet, a basin, or the frame edge; every bridge
  crosses a real connected route; a fountain or pool is named as a closed
  basin. A waterway whose route cannot be stated is left out.

**4. Camera.** Framing, lens, camera height, distance, depth of field, aspect
ratio. From the brief where it says; from the style rules' defaults where it
does not, each marked `default`. Compare the ratio with the ones `host.md`
says the tool produces exactly. If the tool cannot, stop and ask the operator
for a supported ratio or an explicit crop after render; never substitute a
near shape in silence.

**5. At risk.** The invariants this shot threatens, from `risk-table.md`,
plus any the agent sees in this brief. For each: the
invariant, why this shot threatens it, and the words in the prompt that guard
it. An invariant at risk with no guard in the prompt is a defect. Reference
coherence, focal hierarchy, and topology are environment invariants and belong
here whenever their row applies, not only character anatomy.

Guards are concise positive facts: what the face looks like, which family
controls the masses, where the quiet space is, how the route connects. A guard
is never a catalogue of everything excluded. Compression drops no safeguard on
identity, anatomy, or a permission boundary.

**6. Prompt.** The text as it will be sent. Nothing in it that is not in
sections 1 to 5.

## Deriving the prompt

The tool `host.md` names reads natural language. It has no parameter syntax,
no prompt weighting, no negative-prompt field. Write description.

Order of the paragraph: medium and look first (the consistency anchor from
the style rules, word for word) → the characters, each named once with their
signature features and the face and build lines the shot shows → what each is
doing and their expression → where they are → the focal hierarchy, subject
then destination → the dominant family and its 1 accent, if any → the
subordinate surroundings and the quiet areas → the connected route or water,
if any → what is underfoot → the light, its color and direction, the time of
day → the camera: framing, lens, height, depth of field → the exclusions, as
description.

Rules:
- Invariants are stated as fact, not asked for. "Her jaw is square, her nose
  is straight with a small bump" reads better than "keep her face consistent".
- Each guarded invariant from **At risk** appears in words. A profile shot
  says what the profile looks like. 1 concise positive fact per guard.
- The **Reference plan** becomes visual traits. No filename, and no request to
  blend references. The dominant family controls massing, roofline, supports,
  and ornament.
- A bible list is a menu, not a checklist. Name the anchors the Scene selected
  and keep the background subordinate; never enumerate every allowed building,
  plant, or motif.
- Visible water is 1 continuous course with its ingress and egress, and each
  bridge says what it crosses.
- 2 or more characters: name each at its first mention, give each its 2 or 3
  signature features at that mention, state their relative height in words
  ("a head shorter than"), and say where each stands.
- Exclusions are written as what the image holds or does not hold, in a
  sentence: "the image contains no lettering, no watermark, no border."
- No text inside the image unless the brief asks for it and says the words.
- Aspect ratio is passed the way `host.md` says; if the tool takes it only in
  the prompt, say it in words at the end.
- 1 paragraph for a simple shot, up to 3 for a crowded one. Past that, the
  brief is asking for 2 shots.
- Nothing in the prompt names the bible, the spec, the folder, or the
  operator. The tool sees only the image described.

## Reruns

A rerun reads the drift notes first. For each drifted invariant it adds a line
under **At risk** naming the drift and the change made to the prompt to guard
it. The new prompt is derived again from the top; it is not the old prompt
with a phrase appended. Attempt numbers count up and every attempt's spec
stays on disk.

The rerun rebuilds the selection, the manifest, the Reference plan, the focal
hierarchy, and the topology statement before it rewrites the prompt. A spec
written before the manifest existed is a record, not a render input: a new
render gets a new spec. A drift note that states a permanent rule the world
does not yet contain is routed to `00_setup`; it is never hidden as an
invariant inside 1 shot.
