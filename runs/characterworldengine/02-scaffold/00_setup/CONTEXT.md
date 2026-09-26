# 00_setup, interview the operator, then write the bibles

1 job: turn reference images and the operator's answers into the bibles every
shot reads. Runs once per world. Runs again, in character mode, for each
character added later, and then writes 1 new character bible only.

## Inputs
- Working (this run): the operator's answers, given in chat; the images in
  `../world/references/`; the blank `../world/environment.md`,
  `../world/style.md`, `../world/interview.md`
- Working (character mode): `../world/environment.md`, `../world/style.md`,
  every file in `../world/characters/`, for relative scale and shared wardrobe
- Reference (every run): `../_reference/setup-interview.md`,
  `../_reference/bible-schema.md`, `../_templates/character-bible.md`

Do NOT load: any shot under `../runs/<set>/`, shots are downstream;
`../_reference/spec-rules.md` and `../_reference/drift-checklist.md`, they read
bibles and never write them.

## Process
1. World mode: refuse to run if `../world/environment.md` says
   `status: approved`; this folder holds 1 world. Character mode: refuse
   unless it does.
2. Ask every question in `setup-interview.md`, in its order, a few at a time.
   World mode asks all of them; character mode asks the character section only.
   Write nothing until the last question is answered.
3. Fill `../world/interview.md` with every question and its answer. Character
   mode appends a section for the new character.
4. Fill `../world/environment.md` and `../world/style.md` in place. For each
   character, copy `character-bible.md` to `../world/characters/<name>.md` and
   fill it. Every field comes from an image or an answer, marked `stated` or
   `inferred` as `bible-schema.md` defines. Leave no field blank: write
   `unknown` and list it under **Open**.
5. Character mode: state the new character's height and build against each
   existing character, by name.

## Outputs
- `../world/interview.md`, `../world/environment.md`, `../world/style.md`,
  `../world/characters/<name>.md`, frontmatter: `world`, `stage: 00_setup`,
  `status: draft`, `generated`, `sources` (each image and answer used)

## Human check
Open each bible beside the images in `../world/references/`. For every line
marked `inferred`, confirm it against an image or rewrite it; strike any line an
image contradicts; answer or strike every line under **Open**. Flip
`status: approved` on each file.
