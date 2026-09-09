---
name: edit-surface
goes-in: root CONTEXT.md or _reference/how-to-run.md
every-build: yes
---
## Every output is an edit surface

Each stage writes a plain file you can open, edit, and save. The next stage reads
whatever you left there, not what the stage before it meant to write.

This is where you steer. An output you never open is a stage running unsupervised,
and the human check on each contract is the place the design expects you to look.
Edit in place; do not start a parallel copy.
