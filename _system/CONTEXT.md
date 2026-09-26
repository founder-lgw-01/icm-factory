# _system, the gates

Scripts that check what is about to ship. They are run, not read, and they are
the mechanical half of the anti-drift design. The judgment half is the human
check on every stage contract.

| Script | Run it | Blocks? |
|---|---|---|
| `validate.sh <slug>` | stage `04_validate`, on 1 build | yes, exit 1 |
| `ship.sh <slug>` | after `04_validate` is approved; re-gates, then zips the build into `_dist/` | yes, exit 1 and no zip |
| `package.sh` | to cut the factory itself for a buyer: sanitized copy, checked, zipped into `_dist/` | yes, exit 1 and no zip |
| `audit-builds.sh` | after any change to a block, the standard, or a voice law | yes, exit 1 |
| `voice-check.sh <path>` | called by `validate.sh`; also runnable alone | yes, exit 1 |
| `test-gate.sh` | after any change to `validate.sh` or `voice-check.sh` | yes, exit 1 on a probe that lands wrong |
| `sweep-em-dash.sh <path>` | stage `02_scaffold`, on markdown copied from a source | no, it reports every change |

## The rule these scripts encode

A failure is fixed in the factory and the build is re-run. It is never patched
inside `builds/`. A hand-edit to a build cannot survive the next rebuild, so a
build patched by hand is a build that will silently revert. There is no
ship-anyway flag, deliberately.

## What `validate.sh` checks

Each check is a labelled section of the script, and the header of `validate.sh`
is the list. Nothing else enumerates them, so the list cannot fall behind. A check
that cannot read its target reports failure: a guard that says clean on a file it
never opened is worse than no guard, because it is the one you believe.

## Adding a check

Add it to `validate.sh` as its own section, make it fail loudly with the
offending line, give it a probe in `test-gate.sh`, and add an entry to
`../change-log.md`. Then run `audit-builds.sh`: a new check usually finds that
shipped builds trail, and that report is the point of adding it.
