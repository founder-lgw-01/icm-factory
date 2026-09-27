# Bible schema, what a bible must contain and which file owns which fact

The world is the 1 home for everything that must not change. `00_setup` writes
it from reference images and answers; every shot reads the part it selects;
nothing else edits it. This file says what each field means, how it is filled,
and which file it lives in. The blank files under `world/` and the templates in
`_templates/` carry the fields in this order.

## Marking every trait

Every trait line ends with a mark and a source:

- `[stated: <source>]`: read straight from a reference image (`ref-03.png`) or
  an operator answer (`interview q7`). The source is named.
- `[inferred]`: the agent's own reading, not confirmed. The operator's check
  turns each of these into `stated` or strikes it.

A line with no mark is a defect. A trait written from memory, from a similar
character, or from what "usually" goes with the rest is not a trait.

## Invariant vs variable

**Invariant**: never changes between shots. If an image moves it, the shot
drifted. Written as a fact a person can check against an image.

**Variable**: allowed to change, inside a stated range. Expression, pose,
wardrobe state, held props. Each variable names its range, and what it may
never become.

The test for which list a trait belongs on: if 2 images differed only in this,
would they still read as the same character? Yes: variable. No: invariant.

## Which file owns which fact

Each fact has 1 home. A shot loads the homes it needs and no others.

| Home under `world/` | Holds | A spec loads it |
|---|---|---|
| `environment.md` | the router: a module table and a location table, no facts | always, to select from |
| `environment/core.md` | world identity, what never appears, precedence of rules over references | always |
| `environment/palette-lighting.md` | palette, lighting rules, weather | always |
| `environment/architecture.md` | the architectural families, their vocabulary, which may coexist | when built forms are in frame |
| `environment/materials.md` | what surfaces are made of, how they wear and catch light | when those surfaces are in frame |
| `environment/terrain-vegetation.md` | landscape, plants, natural forms | when terrain or plants are in frame |
| `environment/topology.md` | how locations connect: routes, levels, crossings, waterways | when a route, a level change, or water is in frame |
| `environment/locations/<location>.md` | 1 location: what is there, its dominant family, where detail clusters, its light, its ground, what it connects to | when the brief names it as visible |
| `style.md` | medium, look, camera defaults, aspect ratio, framing, composition load, exclusions | always |
| `characters/<name>.md` | 1 character's invariants and variables | when the brief names the character |
| `references/<image-stem>.md` | what 1 image may lend, by role | the selected role's section only |

A location that links to a neighbor does not load the neighbor. A module that
names a reference role does not load the image. Loading is by selection, and
the spec's **World-input manifest** lists what was selected, with a hash.

## Modular frontmatter

Every world file carries `world`, `stage: 00_setup`, `status`, `generated`,
`sources`. The router, the modules, the locations, the bibles, and the
reference records also carry:

| Field | Meaning |
|---|---|
| `kind` | `environment-index`, `environment-module`, `environment-location`, `reference-permissions`, `character-bible`, or `style-bible` |
| `scope` | what this file owns, in a line |
| `depends_on` | the world files this file's facts assume, as paths from the folder root; a location lists the modules it uses; never another location |
| `reference_roles` | the roles this file may draw on, as `world/references/<image-stem>.md#<role-id>`; candidates for a spec to select, never loads |

A reference record adds `image`, the image's path from the folder root.

## Character bible fields

1. **Identity**: name, role in the world, apparent age, 1 line of who they are.
2. **Silhouette**: what identifies them at distance with no face visible.
   Height band, build, posture, the hair and clothing outline. Invariant.
3. **Face**: shape, skin tone, eyes (color, shape, spacing), brows, nose,
   mouth, jaw, ears, marks (scars, moles, freckles). Invariant. Each on its own
   line, each marked.
4. **Hair**: color, length, texture, cut, how it falls, facial hair. Invariant
   unless the operator names a state under Variables.
5. **Build**: height relative to each other character by name, shoulders,
   limb length, weight, hands. Invariant.
6. **Signature features**: the 2 or 3 things a viewer would name first. Always
   present. Invariant.
7. **Wardrobe**: the default outfit, garment by garment, with color and
   material. Then named wardrobe states (`travel`, `formal`, `wet`), each a
   full list of what changes. Anything never worn.
8. **Variables**: expression range and what is out of character; pose range;
   props they may hold; wardrobe states allowed.
9. **Reference map**: a link to each role in `world/references/` that shows
   this character, with a note on when the role is useful. Identity, pose,
   wardrobe, and anatomy are separate roles. The permission text stays in the
   record; a note here never widens it.
10. **Open**: every `unknown` and every trait the images contradict each
    other on. The operator settles each line.

## Environment fields, by module

`core.md`:
1. **World**: name, era or technology level, 1 line of what kind of place.
2. **Never appears**: objects, styles, technologies, creatures the world does
   not contain.
3. **Precedence**: bible invariants outrank every reference image; a location
   or module never weakens a rule stated in core.

`palette-lighting.md`:
4. **Palette**: dominant colors, accent colors, colors that never appear.
   Color words a prompt can use, not hex codes.
5. **Lighting rules**: a table of time of day to key light, color of light,
   shadow behavior, sky. Weather allowed and its effect.

`architecture.md`:
6. **Architectural families**: each named on its own, with massing, roofline,
   supports, ornament. Which is primary; where a secondary may appear; which
   combinations never occur. A menu of allowed forms, not a checklist for a
   frame.

`materials.md`:
7. **Materials**: what surfaces are made of, how they wear, how they catch
   light.

`terrain-vegetation.md`:
8. **Landscape and plants**: terrain, plants, the natural shapes that recur.

`topology.md`:
9. **Spatial topology**: how locations relate by position, elevation, route,
   and barrier. Every street, stair, bridge, and aqueduct names both ends or
   an off-frame continuation. Water names its source or ingress, its course,
   its banks, its crossings, its outlet. A fountain or pool is a closed basin
   and is named as such. No dead ends.

`locations/<location>.md`:
10. **A location**: what is there; the dominant architectural family and any
    permitted secondary motif; where detail clusters and where the frame stays
    quiet; entrances, exits, and links to other locations; where the light
    comes from; what the palette does here; what is underfoot. It uses the
    shared vocabulary and repeats none of it.

Every module ends with **Open**, holding its own unknowns. The router holds
none.

## Style rules fields

1. **Medium**: painted, photographic, rendered, drawn; the finish.
2. **Look**: the 5 or 6 words that describe every image in the set. Repeated
   in every prompt as the consistency anchor.
3. **Camera defaults**: lens, height, distance, depth of field, when a shot
   does not say.
4. **Aspect ratio**: 1 default, and the others allowed.
5. **Framing conventions**: headroom, where characters sit in frame, how much
   environment shows.
6. **Composition load**: what reads first and second; where detail may
   cluster; where the frame stays open; how detail falls away with depth. An
   allowed element is permission, not an instruction to fill the frame.
7. **Reference-use rules**: references never merge; a shot names at most 1
   primary environment reference; what never transfers from any source (text,
   borders, the capture medium, modern context).
8. **Reference map**: a link to each role used for medium, finish,
   composition, palette, or camera. No permission text here.
9. **Exclusions**: what no image contains, written as description for the
   prompt (`the image holds no lettering, no watermark, no frame border`).
10. **Open**.

## Reference records

A reference image is evidence, not a template. Its record,
`world/references/<image-stem>.md`, is the 1 home of what it may lend, and
its `image` field names the file. Each use is a role, `### <role-id>`, with
this table:

| Field | Value |
|---|---|
| Evidence class | `direct`: the trait is visibly established. `inspiration`: guides form, not proof of exact appearance. `conflict-only`: a rejected alternative; defines only what to avoid |
| Use only for | the smallest set of visible traits this role may control; exhaustive |
| Do not transfer | every prominent trait in the image that must not leak into a shot |

- 1 domain per role: identity and anatomy, architecture, spatial composition,
  material, palette and light, medium. An image that serves 2 domains has 2
  roles.
- **Use only for** is exhaustive. **Do not transfer** wins over prominence in
  the image and over any tempting likeness elsewhere in it.
- A selected role licenses nothing from the record's other roles.
- References never merge by default. Incompatible rooflines, ornament, eras,
  costumes, faces, or media are never averaged.
- A row that only says what an image shows, with nothing it may not lend, is
  a defect.
- Bibles, modules, and locations link to roles in their **Reference map** and
  in `reference_roles`; none of them copies the table.

## Approval gates

A world file stays `status: draft` while any of these holds:

- a trait line has no mark, says `unknown`, says `[inferred]`, or sits under
  **Open**;
- a role lacks an evidence class, a narrow **Use only for**, or a **Do not
  transfer**; a role link or an `image` path is broken; a permission is stated
  in 2 places;
- 2 architectural families can meet in a location with no stated dominant
  family and compatibility rule;
- a location has no focal hierarchy, or leaves a visible route or waterway
  unresolved.

Before approving, the operator describes 1 new view inside a named location
and 1 transition between 2 named locations, adding no fact. If the world
cannot decide the reference roles, dominant family, composition, materials,
topology, light, and exclusions for both, the gap goes under **Open**.
`approval.md` says whose decision approval is and what never counts.
