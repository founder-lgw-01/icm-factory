# 01_spec, brief to shot spec

1 job: turn 1 shot brief into 1 spec the render acts on: brief with its
world-input manifest, characters in frame, scene, camera, at risk, prompt. On
a rerun, revise the last spec from the drift notes.

## Inputs
- Working (this run): `../runs/<set>/<shot>/00-brief.md`, from
  `../_templates/shot-brief.md`
- Working (rerun): the highest-numbered `../runs/<set>/<shot>/02-render-N.md`,
  with `verdict: drifted`
- Reference (every run): `../world/environment.md`,
  `../world/environment/core.md`, `../world/environment/palette-lighting.md`,
  `../world/style.md`, `../world/characters/<name>.md` for each character the
  brief names, `../_reference/spec-rules.md`, `../_reference/risk-table.md`,
  `../_reference/host.md`
- Reference (on demand): the other modules in `../world/environment/`, the
  visible locations the brief names, and the `### <role-id>` sections the spec
  selects in `../world/references/<image-stem>.md`

Do NOT load: `../world/interview.md`; any other shot under `../runs/<set>/`;
`../_reference/setup-interview.md`, `../_reference/bible-schema.md`,
`../_reference/drift-checklist.md`; any module, location, role, or image the
shot did not select. A location's link to a neighbor is not a selection.

## Process
1. Refuse to run unless every world file the shot selects says
   `status: approved`. Refuse if a named character or location has no file.
2. Read the brief. For every empty field, ask the operator now and record the
   answer under **Brief**. Do not guess. Select modules, locations, and roles
   as `spec-rules.md` says; a local rule that contradicts a global one stops
   the stage for `00_setup`.
3. Write the sections in the order `spec-rules.md` gives: Brief, ending in the
   **World-input manifest**, Characters in frame, Scene, Camera, At risk,
   Prompt. Derive each section from the ones above it and nothing else.
4. Rerun: open the drift notes first. Name each drifted invariant under **At
   risk** with the change made to guard it. Rebuild the selection and the
   manifest. Number the new spec N+1. A note stating a new permanent rule goes
   to `00_setup`.

## Outputs
- `../runs/<set>/<shot>/01-spec-N.md`, frontmatter: `set`, `shot`, `attempt`,
  `stage: 01_spec`, `status: draft`, `generated`, `sources`

## Human check
Read the spec top to bottom against the brief and the files its manifest
names. Every invariant under **At risk** is guarded in **Prompt** in words,
nothing in **Prompt** contradicts a section above it, and every file read is
in the manifest. Edit in place. Flip `status: approved`.
