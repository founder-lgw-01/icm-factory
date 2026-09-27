# characters, 1 bible per character

`00_setup` writes `<name>.md` here from `_templates/character-bible.md`, 1 file
per character, kebab-case. A shot brief names characters by these filenames.
To add a character, run `00_setup` in character mode; it writes the new bible,
1 reference record per new image, and a section in `world/interview.md`, and
touches nothing else. The bible's **Reference map** links to roles under
`world/references/`; it never repeats a permission table.
