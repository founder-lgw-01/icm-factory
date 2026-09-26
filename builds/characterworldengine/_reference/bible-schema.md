# Bible schema, what a bible must contain

A bible is the 1 home for everything that must not change. `00_setup` writes
it from reference images and answers. Every shot reads it. Nothing else edits
it. The blank `world/environment.md` and `world/style.md`, and
`_templates/character-bible.md`, carry these fields in this order; this file
says what each field means and how it is filled.

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
9. **Reference map**: each image in `world/references/` that shows this
   character, and which fields it evidences.
10. **Open**: every `unknown` and every trait the images contradict each
    other on. The operator settles each line.

## Environment bible fields

1. **World**: name, era or technology level, 1 line of what kind of place.
2. **Palette**: dominant colors, accent colors, colors that never appear.
   Stated as color words a prompt can use, not hex codes.
3. **Materials**: what surfaces are made of, how they wear, how they catch
   light.
4. **Built and natural forms**: architecture, landscape, plants, vehicles,
   the shapes that recur.
5. **Locations**: 1 block per named location. What is there, where the light
   comes from, what the palette does here, what a character would stand on.
6. **Lighting rules**: a table of time of day to key light, color of light,
   shadow behavior, sky. Weather allowed and its effect.
7. **Never appears**: objects, styles, technologies, creatures the world does
   not contain.
8. **Reference map**: each image that shows the world, and what it evidences.
9. **Open**.

## Style rules fields

1. **Medium**: painted, photographic, rendered, drawn; the finish.
2. **Look**: the 5 or 6 words that describe every image in the set. Repeated
   in every prompt as the consistency anchor.
3. **Camera defaults**: lens, height, distance, depth of field, when a shot
   does not say.
4. **Aspect ratio**: 1 default, and the others allowed.
5. **Framing conventions**: headroom, where characters sit in frame, how much
   environment shows.
6. **Exclusions**: what no image contains, written as description for the
   prompt (`the image holds no lettering, no watermark, no frame border`).
7. **Open**.
