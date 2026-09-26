# 01_spec, brief to shot spec

1 job: turn 1 shot brief into 1 spec the render acts on: brief, characters in
frame, scene, camera, at risk, prompt. On a rerun, revise the last spec from
the drift notes.

## Inputs
- Working (this run): `../runs/<set>/<shot>/00-brief.md`, written by the
  operator from `../_templates/shot-brief.md`
- Working (rerun): the highest-numbered `../runs/<set>/<shot>/02-render-N.md`,
  which says `verdict: drifted`
- Reference (every run): `../world/environment.md`, `../world/style.md`,
  `../world/characters/<name>.md` for each character the brief names,
  `../_reference/spec-rules.md`, `../_reference/drift-checklist.md` for its
  risk table

Do NOT load: `../world/interview.md`, the bible is the truth and the interview
is raw; any other shot under `../runs/<set>/`, shots do not inherit;
`../_reference/setup-interview.md` and `../_reference/bible-schema.md`, setup
material.

## Process
1. Refuse to run unless every bible the brief names says `status: approved`.
   Refuse if the brief names a character with no file in `../world/characters/`.
2. Read the brief. For every empty field, ask the operator now and record the
   answer under **Brief**. Do not guess.
3. Write the sections in the order `spec-rules.md` gives: Brief, Characters in
   frame, Scene, Camera, At risk, Prompt. Derive each section from the ones
   above it and nothing else.
4. Rerun: open the drift notes first. Name each drifted invariant under **At
   risk** with the change made to guard it. Number the new spec N+1.

## Outputs
- `../runs/<set>/<shot>/01-spec-N.md`, frontmatter: `set`, `shot`, `attempt`,
  `stage: 01_spec`, `status: draft`, `generated`, `sources`

## Human check
Read the spec top to bottom against the brief and the named bibles. Every
invariant under **At risk** is guarded in **Prompt** in words, and nothing in
**Prompt** contradicts a section above it. Edit in place. Flip
`status: approved`.
