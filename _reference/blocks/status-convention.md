---
name: status-convention
goes-in: root CONTEXT.md
every-build: yes
---
## Status is whatever exists

A stage is complete when its output file carries `status: approved` in its
frontmatter. A person flips that line, not the agent, and not a script.

A stage refuses to run until the stage before it is approved. Status lives
nowhere else: there is no tracker, no board, no separate state file. To know
where a run stands, look at what is on disk.
