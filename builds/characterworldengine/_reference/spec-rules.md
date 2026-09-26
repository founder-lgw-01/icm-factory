# Spec rules, how a shot spec and its prompt are built

A spec is the judgment call surfaced as a file before the expensive step.
Every decision the render acts on is readable and editable in the spec. The
prompt is its last section and is derived from the sections above it. A prompt
written first, with a spec fitted around it, is a defect.

## Sections, in order

**1. Brief.** Every field of `00-brief.md`, filled. Where the operator left a
field empty, the question asked and the answer given, in the operator's words.
A field the operator answers "you choose" is filled here and marked `chosen`,
so the operator sees the choice before the render.

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

**3. Scene.** The location, copied from the environment bible: what is there,
what is underfoot, where the light comes from. The time of day and the
lighting-rules row for it. The palette as it applies here. Weather, if the
brief names it, and its effect from the bible.

**4. Camera.** Framing, lens, camera height, distance, depth of field, aspect
ratio. From the brief where it says; from the style rules' defaults where it
does not, each marked `default`.

**5. At risk.** The invariants this shot threatens, from the risk table in
`drift-checklist.md`, plus any the agent sees in this brief. For each: the
invariant, why this shot threatens it, and the words in the prompt that guard
it. An invariant at risk with no guard in the prompt is a defect.

**6. Prompt.** The text as it will be sent. Nothing in it that is not in
sections 1 to 5.

## Deriving the prompt, for Gemini 3 Pro Image

The tool reads natural language. It has no parameter syntax, no prompt
weighting, no negative-prompt field. Write description.

Order of the paragraph: medium and look first (the consistency anchor from
the style rules, word for word) → the characters, each named once with their
signature features and the face and build lines the shot shows → what each is
doing and their expression → where they are, what surrounds them, what is
underfoot → the light, its color and direction, the time of day → the camera:
framing, lens, height, depth of field → the exclusions, as description.

Rules:
- Invariants are stated as fact, not asked for. "Her jaw is square, her nose
  is straight with a small bump" reads better than "keep her face consistent".
- Each guarded invariant from **At risk** appears in words. A profile shot
  says what the profile looks like.
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
