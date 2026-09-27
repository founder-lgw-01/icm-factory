# Drift checklist, what drift looks like and what each shot puts at risk

Drift is an invariant that moved. `01_spec` reads `risk-table.md` to write
**At risk**. `02_render` verifies the spec's inputs, renders, then walks the
whole list against the image and writes 1 finding per line. The operator walks
it again at the human check and writes the verdict. The approved spec, the
bibles and world files its manifest names, and the roles it selected are the
reference; this file says how to read an image against them. Nothing in it
authorizes loading a module, location, or role the spec did not select.

## Before the render

Every row of the spec's **World-input manifest** is checked: the file exists,
says `status: approved`, and its SHA-256 equals the row. A missing file, a
draft, or a changed hash stops the render and names the row. `style.md` is
checked the same way and not read as prose; its facts are frozen in the spec.
The **Prompt** is sent unchanged.

## The findings

Each line of the check gets 1 of 3 findings:

- `holds`: the image shows the invariant as the bible states it.
- `drifted: <what moved>; expected: <the bible's words>`: the image shows
  something else. "jaw is rounded; expected: jaw square."
- `cannot see: <why>`: the shot hides it (back view, hands out of frame,
  hood up, too small to judge). Not a pass and not a fail. If a `cannot see`
  sits on an **At risk** line, the operator decides whether the shot is
  acceptable without seeing it.

A finding of `mostly` or `close enough` is not a finding.

Judge the pixels and the file, not the prompt's intention. A feature too small
to verify is `cannot see` even when the prompt asked for it. Every `holds` that
is not a plain yes, and every `drifted`, names what in the image shows it:
counts, positions, repeated forms, boundaries, connections, occlusions. "Too
busy", "coherent", "plausible" do not stand alone. 2 claims that can be judged
apart get 2 findings, so 1 match cannot hide 1 drift.

## What is checked, per character

Walk the character's bible top to bottom:

1. **Silhouette**: height band, build, posture, hair and clothing outline.
   Fails as: a different body type, a changed hairline outline, a slimmer or
   heavier frame.
2. **Face**: every line under Face. Fails as: eye color or spacing, nose
   shape, jaw line, skin tone shifting warmer or cooler, a mark missing or
   moved.
3. **Hair**: color, length, texture, cut. Fails as: a shade lighter, longer
   than the bible, straight where it should curl, a part on the other side.
4. **Build**: proportions, limb length, hands, shoulders. Fails as: longer
   legs, narrower shoulders, small hands.
5. **Signature features**: each present. Fails as: absent, or swapped for
   something similar.
6. **Wardrobe**: the state the spec names, garment by garment, color and
   material. Fails as: a garment missing, a color shifted, extra ornament the
   bible does not list.
7. **Variables in range**: expression, pose, props inside the range the bible
   allows. Fails as: an expression the bible calls out of character.
8. **Relative scale** (2 or more characters): height and build against each
   other as the bibles state. Fails as: equal height where the bible says a
   head shorter.

## What is checked, for the environment

9. **Location**: what is visibly there and what is underfoot match the
   selected location's facts and the Scene's composition, not every object in
   the location's vocabulary.
10. **Reference coherence**: the Reference plan's primary reference and
    dominant family control the scene; a supporting role lends only its **Use
    only for** trait. Fails as: an unselected reference reads through, 2
    rooflines or ornament systems averaged, a **Do not transfer** detail in
    frame.
11. **Architectural family**: the major masses, repeated facade rhythms,
    rooflines, and landmarks belong to the dominant family; a permitted
    secondary motif stays localized. Fails as: a secondary family repeating
    across the skyline, controlling a landmark, or reading as coequal.
12. **Focal hierarchy and density**: the subject reads first, the destination
    or secondary anchor second, the background stays subordinate. Fails as: a
    catalogue of equal-weight landmarks, detail in every depth band, repeated
    motifs at equal scale, silhouettes merged by tangency, architecture that
    competes with the action.
13. **Spatial topology**: routes, levels, and crossings connect at compatible
    elevations. Every visible river, canal, stream, or open channel has a
    traceable course to a source or ingress and to an outlet or egress, or
    continues off-frame or behind a named occluder. A bridge crosses a real
    connected route. Fails as: water ending against paving or a wall, an
    impossible fork, a bridge over nothing. A fountain or pool is a closed
    basin and is exempt from through-flow; its edges stay continuous.
14. **Palette**: dominant and accent colors present; no forbidden color.
15. **Materials**: surfaces read as the bible describes.
16. **Light**: direction, color, shadow behavior match the lighting-rules row
    for the time of day.
17. **Never appears**: nothing from core's list is in frame.
18. **Style**: medium, look, and framing match the style facts frozen in the
    spec. The aspect ratio is computed from the file's measured width and
    height and equals the approved spec's ratio; the requested ratio is not
    evidence. Exclusions hold: no lettering, watermark, border, or whatever
    the rules name.

## What is checked, for the concept

19. **Concept**: the carrier the spec's **Concept** line names is in frame and
    reads as the idea. Fails as: the prop or label missing, the label misspelt,
    the action ambiguous, a second element competing for the idea. This is not
    drift in the character or the world, but a fail here is a `drifted` verdict
    all the same: the shot goes back to `01_spec` with the note saying what did
    not read.

## Risk table

The table of shot types to the invariants each puts at risk, with the guard
for each, is `risk-table.md`. `01_spec` reads that file and not this one; it
is not repeated here.

## The verdict

The operator decides exactly 1 of these, by file or by a named decision in
chat that the agent writes into the record and reads back; `approval.md` says
what never counts as a decision:

- `verdict: accepted`: every **At risk** line holds or the operator accepts its
  `cannot see`; no `drifted` on a character; environment drift, if any, is
  named and accepted in **Drift notes**.
- `verdict: drifted`: at least 1 line the operator will not accept. **Drift
  notes** says which, in the bible's words, so `01_spec` can guard it.

An accepted record becomes `status: approved` by that decision alone; a
rejected record stays `status: draft`. The agent leaves `verdict` empty until
the decision exists and never turns its own findings into approval.

An accepted environment exception is written in **Drift notes** and applies to
that image only; it changes no bible and no reference record. A **Do not
transfer** detail in frame, an unselected family dominating the frame, or
broken visible water topology takes `verdict: drifted` or an operator
exception that names that exact defect.
