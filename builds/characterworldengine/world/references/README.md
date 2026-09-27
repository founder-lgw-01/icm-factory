# references, the images the bibles cite, and what each may lend

Put reference images here before running `00_setup`: photos, sketches, earlier
generations, turnarounds. Name them by what they show, `mara-face-front.png`.
They stay at these paths for the life of the world; nothing sends them to the
image tool.

`00_setup` writes 1 record per image, `<image-stem>.md`, from
`_templates/reference-permissions.md`. Its `image` field names the file. Each
`### <role-id>` in it says what the image may lend to a shot in 1 domain, and
what must not transfer however prominent it is in the picture. That table
lives here and nowhere else: bibles, modules, and locations link to a role as
`world/references/<image-stem>.md#<role-id>`.

A spec selects roles, at most 1 primary environment reference per shot, and
reads only the selected role's section. A role that is not selected lends
nothing; a `conflict-only` role says only what to avoid. Every
`[stated: <image>]` mark in a bible still points at 1 of these images, so a
later reader can check any trait against its source.
