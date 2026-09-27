# The walk test

Check this workspace by walking it cold, as an agent with no memory of building it.

- Open the root. Can you answer *where am I* and *where do I go for this task*
  from the entry file plus at most 2 more reads?
- Pick any stage. Does its contract name exact input paths, the job, the output,
  and 1 human check?
- Can you state where a run stands purely by scanning what exists in the
  product folder `CONTEXT.md` names?
- Is any routing file carrying content payload? Move the payload to a shelf and
  leave a pointer.
- Is any fact stored in 2 places? Pick 1 home; link from the other.
- Entry file plus 1 contract plus its inputs should land around 2,000 to 8,000
  tokens.

If a step fails, fix the structure. Not by explaining more, but by moving or
splitting files until the walk works.

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
