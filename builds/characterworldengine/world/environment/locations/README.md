# locations, 1 file per named location

`00_setup` writes `<location>.md` here from `_templates/location.md`, 1 file
per location the interview names, kebab-case. A shot brief names the visible
locations by these filenames. A location lists the modules it uses in
`depends_on` and links to reference roles; it never depends on another
location, and a neighbor named in its text loads nothing.
