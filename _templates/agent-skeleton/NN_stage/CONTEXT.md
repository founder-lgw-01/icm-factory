# NN_stage, {{the job, in 1 line}}

1 job: {{the single thing this stage does, stated so a boundary is obvious}}.

## Inputs
- Working (this run): `{{../runs/<unit>/PP-file.md}}` (requires `status: approved`)
- Reference (every run): `{{../_reference/file.md}}`
- Reference (on demand): `{{../_reference/file.md}}`, {{when}}

Do NOT load: {{what this stage must not see, and the reason in 3 words}}.

## Process
1. Refuse to run unless `{{upstream file}}` says `status: approved`.
2. {{numbered, short, imperative. Constraints live in _reference/, not here.}}
3. {{...}}

## Outputs
- `../runs/<unit>/NN-{{file}}.md`, frontmatter: `{{unit}}`, `stage: NN_stage`,
  `status: draft`, `generated`, `sources`

## Human check
{{1 check, stated as a verb a person performs on a named thing. Not "review".}}
Flip `status: approved`.
