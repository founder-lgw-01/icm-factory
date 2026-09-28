# 01_form, brief to form and stage plan

1 job: choose the ICM form, turn the brief's walkthrough into a numbered stage
plan with named gates, and break nothing the source already does.

## Inputs
- Working (this run): `../../runs/<slug>/00-intake.md` (requires `status: approved`)
- Reference (every run): `../../_source-corpus/ICM-architect/references/forms.md`,
  `../../_reference/emission-standard.md`, `../../_reference/source-fidelity.md`,
  `../../_reference/blocks/README.md`, the block index
- Reference (when the source already runs): the source folder `00-intake.md`
  names: its scripts, configs, and any file naming a path the plan would change
- Reference (on demand): `../../_source-corpus/ICM-architect/SKILL.md` if a
  structural call is contested; `../../_source-corpus/ICM-architect/references/system-map.md`
  for the System map form

Do NOT load: any `_source-corpus/` folder but this build's own source, the
block bodies in `../../_reference/blocks/`, `../../_templates/`,
`../../builds/`, any other run in `../../runs/`.

## Process
1. Refuse to run unless `00-intake.md` says `status: approved`.
2. Choose the form from `forms.md`: 1 sentence on why, 1 on what you rejected.
3. **Run the intent gate in `source-fidelity.md`** whenever the source already
   runs: answer its 4 questions and record a verdict per part, `leave-alone`,
   `additive` or `rebuild`.
4. Turn **1 run** into numbered stages: count the places work genuinely stops,
   by the closing rule of `source-fidelity.md`. Freeze only what step 3 found
   load-bearing.
5. For each stage, name its job, inputs (working vs reference), do-not-load,
   output file, and human check.
6. Split **Stable vs new** into the built agent's factory and product; name
   each reference file it needs. **Who it talks to** naming a person means 1 of
   them is the privacy rule. Name the blocks from the index.
7. If the whole job fits in 1 saved prompt, say so and stop.

## Outputs
- `../../runs/<slug>/01-plan.md`, frontmatter: `slug`, `stage: 01_form`, `status: draft`,
  `generated`, `sources`, `form`.

  Body: **Form and why** · **Source fidelity** (4 answers, a verdict per part;
  omitted with no source) · **Stages** (NN_name | job |
  inputs | do-not-load | output | human check) · **The built agent's factory** ·
  **Blocks needed** · **Rejected**.

## Human check
Read **Source fidelity** first: if the plan breaks something the source relies
on, the plan is wrong, not the source. Then read the stage table as if running
it Monday. If 2 rows never stop between them, merge them. Flip `status: approved`.
