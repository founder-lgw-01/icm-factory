# 03_file, file the accepted image into its set

1 job: write the sidecar for 1 accepted shot and add its line to the set
manifest.

## Inputs
- Working (this run): the `../runs/<set>/<shot>/02-render-N.md` that says
  `verdict: accepted` (requires `status: approved`), and the
  `../runs/<set>/<shot>/01-spec-N.md` it was rendered from
- Working (when it exists): `../runs/<set>/manifest.md`
- Reference (every run): `../_templates/sidecar.md`,
  `../_templates/set-manifest.md`

Do NOT load: `../world/`, filing does not judge; `../_reference/spec-rules.md`
and `../_reference/drift-checklist.md`, judgment is finished; any other shot
under `../runs/<set>/`, only the manifest is shared.

## Process
1. Refuse to run unless the render record says `status: approved` and
   `verdict: accepted`.
2. Copy `sidecar.md` to `../runs/<set>/<shot>/03-sidecar.md`. Fill it from the
   render record: the prompt as sent, every metadata field, the characters in
   frame, the accepted image filename, the verdict, the spec filename.
3. If `../runs/<set>/manifest.md` does not exist, copy `set-manifest.md` there.
4. Append 1 line to the manifest: shot, characters in frame, attempt accepted,
   image filename, sidecar path, date.
5. Do not copy the image. The sidecar names it: 1 home per file.

## Outputs
- `../runs/<set>/<shot>/03-sidecar.md`, frontmatter: `set`, `shot`, `attempt`,
  `stage: 03_file`, `status: draft`, `generated`, `sources`
- 1 line in `../runs/<set>/manifest.md`

## Human check
Open the new manifest line, follow it to the sidecar, and read the sidecar's
prompt against the render record's **Prompt as sent**, word for word. Flip
`status: approved`.
