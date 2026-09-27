# world, the 1 world this folder holds

Written by `00_setup` and by nothing else. Ships blank: the files below carry
their fields and no values until setup runs. After a file here says
`status: approved`, only a scoped `00_setup` revision reopens it, by name, and
each reopened file is approved again on its own.

| Path | Holds |
|---|---|
| `interview.md` | every question setup asked and every answer; a dated section per revision |
| `environment.md` | the router: which environment file a shot loads, and when |
| `environment/<module>.md` | the shared environment rules, 1 owner per fact |
| `environment/locations/<location>.md` | 1 location, and the modules it uses |
| `style.md` | the style rules |
| `characters/<name>.md` | 1 character bible per character |
| `references/<image-file>` | a reference image, at this path for the life of the world |
| `references/<image-stem>.md` | what that 1 image may lend, by role |

A shot selects from here; it does not import the folder. `_reference/bible-schema.md`
says which file owns which fact, and `_reference/spec-rules.md` says how a
spec selects and records what it read.

A second world is a second copy of the empty engine, not a second set of
files here.
