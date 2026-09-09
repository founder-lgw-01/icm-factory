# {{AGENT NAME}}, the line

The flow in 1 line: {{input}} → {{step}} → {{step}} → {{what ships}}.

| Stage | Job | Input | Output | Human check |
|---|---|---|---|---|
| `NN_stage` | {{1 line}} | {{exact path}} | {{exact path}} | {{what a person does}} |

Each stage's contract is `NN_stage/CONTEXT.md`: what it reads, what it must not
load, what it does, what it writes, what a person checks.

Factory (stable, every run): `_reference/`, `_templates/`
Product (new each run): `runs/{{unit}}/`, numbered by the stage that wrote each file

BLOCK: status-convention

## Frontmatter

Every stage output begins with `{{unit}}`, `stage`, `status` (`draft` |
`approved`; you flip it), `generated`, `sources`.

BLOCK: edit-surface

BLOCK: naming
