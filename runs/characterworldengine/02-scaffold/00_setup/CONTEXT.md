# 00_setup, interview the operator, then write the world

1 job: turn reference images and the operator's answers into the world files
every shot reads. 3 modes: world, once; character, per added character;
revision, a scoped change to named files.

## Inputs
- Working (world mode): the operator's answers; the images in
  `../world/references/`; the blank files under `../world/`
- Working (character mode): `../world/environment/core.md`,
  `../world/style.md`, every file in `../world/characters/`
- Working (revision): the files the operator names, and no other
- Reference (every run): `../_reference/setup-interview.md`,
  `../_reference/bible-schema.md`, `../_reference/approval.md`,
  `../_templates/character-bible.md`, `location.md`, `reference-permissions.md`

Do NOT load: any shot under `../runs/<set>/`; `../_reference/spec-rules.md`
and `../_reference/drift-checklist.md`; in revision mode, any world file not
named.

## Process
1. World mode: refuse if `../world/environment/core.md` says `status: approved`.
   Character mode: refuse unless it does. Revision: refuse without an
   instruction naming the files and the change; set those files to
   `status: draft` and no other.
2. Ask the questions `setup-interview.md` gives for the mode, in order, a few
   at a time. Write nothing until the last answer is in.
3. Append every question and answer to `../world/interview.md`; a revision
   also appends the instruction, word for word.
4. Fill `../world/environment.md`, `../world/environment/`, and
   `../world/style.md` in place. Stamp `location.md` into
   `../world/environment/locations/`, `character-bible.md` into
   `../world/characters/`, `reference-permissions.md` into
   `../world/references/`, 1 per location, character, image.
   `bible-schema.md` says which file owns which fact; write each once.
5. Every field comes from an image or an answer, marked `stated` or
   `inferred`. Leave no field blank: write `unknown` and list it under **Open**.
   Character mode: state height and build against each existing character.

## Outputs
- Step 4's files, frontmatter: `world`, `stage: 00_setup`, `status: draft`,
  `generated`, `sources`, `kind`, `scope`, `depends_on`, `reference_roles`; a
  reference record adds `image`.

## Human check
Open each file beside the images in `../world/references/`. For every line
marked `inferred`, confirm it against an image or rewrite it; strike any line
an image contradicts; answer or strike every line under **Open**; read each
record's **Do not transfer** cell against its image. Flip `status: approved`
on each file, 1 at a time.
