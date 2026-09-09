---
name: walk-test
goes-in: _reference/
every-build: when the build has 3+ stages
---
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
