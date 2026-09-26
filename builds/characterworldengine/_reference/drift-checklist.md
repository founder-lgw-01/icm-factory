# Drift checklist, what drift looks like and what each shot puts at risk

Drift is an invariant that moved. `01_spec` reads the risk table to write
**At risk**. `02_render` walks the whole list against the image and writes 1
finding per line. The operator walks it again at the human check and writes the
verdict. The bible is the reference; this file says how to read an image
against it.

## The findings

Each line of the check gets 1 of 3 findings:

- `holds`: the image shows the invariant as the bible states it.
- `drifted: <what moved>`: the image shows something else. Say what, in the
  bible's own words: "jaw is rounded; bible says square."
- `cannot see: <why>`: the shot hides it (back view, hands out of frame,
  hood up). Not a pass and not a fail. If a `cannot see` sits on an **At risk**
  line, the operator decides whether the shot is acceptable without seeing it.

A finding of `mostly` or `close enough` is not a finding.

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

9. **Location**: what is there, what is underfoot, matches the bible's block.
10. **Palette**: dominant and accent colors present; no forbidden color.
11. **Materials**: surfaces read as the bible describes.
12. **Light**: direction, color, shadow behavior match the lighting-rules row
    for the time of day.
13. **Never appears**: nothing from the bible's list is in frame.
14. **Style**: medium, look, framing, aspect ratio match the style rules.
    Exclusions hold: no lettering, watermark, border, or whatever the rules
    name.

## Risk table, shot type to invariants at risk

`01_spec` reads the brief and lists every row that applies.

| The shot has | At risk | Guard in the prompt |
|---|---|---|
| a profile or 3/4 view | jaw, nose, brow, ear, hairline | state the profile lines from the bible in words |
| a back view | silhouette, hair fall, wardrobe back | describe the back of the hair and garments |
| a full body, wide | proportions, height, hands, relative scale | state build and height in words; name what is underfoot for scale |
| a close-up | eyes, skin tone, marks, hair texture | state each mark and its position |
| fast action or an unusual pose | proportions, limb length, wardrobe state | describe the pose joint by joint and say the outfit stays as listed |
| low light or night | skin tone, hair color, palette | name the light color and say what it does to skin and hair |
| weather or water | hair, wardrobe state, materials | name the wet or wind state the bible allows |
| 2 or more characters | relative scale, signature features swapping between them | name each at first mention with its features; state heights against each other |
| a wardrobe state other than default | every garment in that state | list the state's garments from the bible |
| an expression at the edge of range | face, and out-of-character read | name the expression and what it is not |
| a new location, first time shot | palette, materials, light | copy the location block into the scene section |

## The verdict

The operator writes exactly 1 of:

- `verdict: accepted`: every **At risk** line holds or the operator accepts its
  `cannot see`; no `drifted` on a character; environment drift, if any, is
  named and accepted in **Drift notes**.
- `verdict: drifted`: at least 1 line the operator will not accept. **Drift
  notes** says which, in the bible's words, so `01_spec` can guard it.
