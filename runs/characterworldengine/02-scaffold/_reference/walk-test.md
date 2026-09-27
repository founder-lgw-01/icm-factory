BLOCK: walk-test

## This folder's walk

Added to the walk above, for the world this folder holds:

- Is `world/environment.md` still a router? Can a shot select core,
  palette-lighting, and only its visible locations without reading the rest?
- Does every module, location, bible, and reference record carry `kind`,
  `scope`, `depends_on`, and `reference_roles`, with no location depending on
  a neighbor?
- Is each image's permission stated once, in `world/references/<image-stem>.md`,
  and linked from the bibles rather than copied?
- Does a spec list every world file it read, with a hash, under **Brief**?
  Does `02_render` refuse a spec whose files have changed since?
- Is every `status: approved` line the operator's, by file or by a named
  decision written down and read back? `approval.md` says what never counts.
- Do `CLAUDE.md` and `AGENTS.md` match byte for byte?

`tests/test_world_structure.py` checks the shape of `world/` from the folder
root: `python -B -m unittest discover -s tests -v`. A pass is structure, not
approval.
