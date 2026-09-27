# 02_render, verify, send the prompt, save the image, check drift

1 job: turn 1 approved spec into 1 image and 1 render record holding the drift
findings.

## Inputs
- Working (this run): the highest-numbered `../runs/<set>/<shot>/01-spec-N.md`
- Working (verification only): each file in the spec's **World-input
  manifest**, for its `status` and its SHA-256 only
- Reference (every run): `../_reference/drift-checklist.md`,
  `../_reference/host.md`, `../_reference/approval.md`; for step 4,
  `../world/characters/<name>.md` per named character and the modules,
  locations, and roles the manifest names

Do NOT load: `../world/interview.md`; `../world/style.md` as prose and
`../_reference/spec-rules.md`, both are frozen in the spec;
`../_reference/setup-interview.md`; any other shot under
`../runs/<set>/`; any world file the manifest does not name.

## Process
1. Refuse to run unless the spec says `status: approved` and every row of its
   **World-input manifest** exists, says `status: approved`, and hashes to the
   row's SHA-256. A miss stops the run and names the row.
2. Send the spec's **Prompt** section, byte for byte, to the image tool
   `host.md` names. Save the result as `../runs/<set>/<shot>/02-image-N.<ext>`,
   N matching the spec.
3. Write the render record: the prompt as sent, the manifest check, then every
   metadata field `host.md` lists, `not exposed` where the tool returns none.
   Measure the image's width and height.
4. Walk `drift-checklist.md` against the image: the spec's **At risk** items
   first, then every invariant of each named character, then the environment
   items, then the spec's **Concept** line. Write 1 finding per line: `holds`,
   `drifted: <what moved>; expected: <the bible's words>`, or
   `cannot see: <why>`, each naming what in the image shows it.
5. Leave `verdict:` empty. The operator writes it, or names it in chat for the
   agent to write and read back; `approval.md` says how.

## Outputs
- `../runs/<set>/<shot>/02-image-N.<ext>`
- `../runs/<set>/<shot>/02-render-N.md`, frontmatter: `set`, `shot`, `attempt`,
  `stage: 02_render`, `status: draft`, `verdict` (empty | `accepted` |
  `drifted`), `generated`, `sources`; body: **Prompt as sent**,
  **Tool metadata**, **Findings**, **Drift notes**

## Human check
Put the image beside the spec and the bibles, locations, and modules its
manifest names, and walk the drift checklist line by line, **At risk** items
first. Write `verdict: accepted` and flip `status: approved`, or write what
drifted under **Drift notes**, write `verdict: drifted`, and start `01_spec`
again.
