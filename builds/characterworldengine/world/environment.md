---
world:
kind: environment-index
stage: 00_setup
status: draft
generated:
scope: the router, which environment file a shot loads and when
depends_on:
  - world/environment/core.md
  - world/environment/palette-lighting.md
reference_roles: []
sources:
---

# <world>, environment router

This file routes; the facts live in the files it names. A spec loads core and
palette-lighting always, another module when the shot shows its domain, and a
location only when the brief names it as visible. A location's link to a
neighbor loads nothing. `_reference/bible-schema.md` says which file owns
which fact.

## Modules

| Module | Load when |
|---|---|
| `environment/core.md` | always: world identity, never appears, precedence |
| `environment/palette-lighting.md` | always: palette, lighting rules, weather |
| `environment/architecture.md` | built forms are in frame |
| `environment/materials.md` | surfaces need naming |
| `environment/terrain-vegetation.md` | terrain or plants are in frame |
| `environment/topology.md` | a route, a level change, a crossing, or water is in frame |

## Locations

1 file per location under `environment/locations/`, written by `00_setup` from
`_templates/location.md`. A shot picks by what is visible, not by proximity.

| Location | File |
|---|---|
| | `environment/locations/<location>.md` |
