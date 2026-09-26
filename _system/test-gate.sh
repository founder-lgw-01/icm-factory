#!/usr/bin/env bash
# test-gate.sh - proves the gate. Plants each defect alone in a clean fixture and
# checks that validate.sh blocks; plants each legitimate look-alike and checks
# that it passes.
#
# Usage:  bash _system/test-gate.sh          (KEEP=1 leaves the fixture behind)
#
# Exit 0 = every probe landed as expected. Exit 1 = the gate has a blind spot or
# a false positive. Run it after any change to validate.sh or voice-check.sh, and
# give every new check a probe here.
#
# The fixture is a throwaway mirror under $TMPDIR: a copy of _system/ and
# _reference/, a clean stages/, builds/fixture/ with every every-build block
# resolved, and runs/fixture/ with 4 approved run files, a manifest saying
# check: none, and an emit log. Nothing under this factory is touched.

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EM=$(printf '\xe2\x80\x94')
M="${TMPDIR:-/tmp}/icm-gate-test.$$"
B="$M/builds/fixture"; R="$M/runs/fixture"
wrong=0; n=0

body() { awk 'NR==1 && /^---/ {fm=1; next} fm && /^---/ {fm=0; next} !fm' "$ROOT/_reference/blocks/$1.md"; }

fresh() {
  rm -rf "$M"
  mkdir -p "$M/_system" "$M/stages/00_x" "$B/01_step" "$B/_reference" "$R/02-scaffold"
  cp "$ROOT/_system/validate.sh" "$ROOT/_system/voice-check.sh" "$M/_system/"
  cp -r "$ROOT/_reference" "$M/_reference"
  : > "$M/stages/00_x/CONTEXT.md"
  for f in 00-intake.md 01-plan.md 02-scaffold/manifest.md 03-emit-log.md; do
    printf -- '---\nslug: fixture\nstatus: approved\n---\n' > "$R/$f"
  done
  printf 'block: icm-credit -> README.md\nblock: status-convention -> CONTEXT.md\nblock: never-stem -> CLAUDE.md\nblock: naming -> CONTEXT.md\nblock: edit-surface -> CONTEXT.md\n' >> "$R/03-emit-log.md"
  printf 'check: none\n' >> "$R/02-scaffold/manifest.md"
  {
    printf '# Fixture agent\n\nRoutes only.\n\n| Task | Go to |\n|---|---|\n| Start a run | `CONTEXT.md` |\n| The step | `01_step/CONTEXT.md` |\n| Rules | `_reference/` |\n\n## Never\n\n'
    body never-stem; echo "- Edit a generated file."
  } > "$B/CLAUDE.md"
  cp "$B/CLAUDE.md" "$B/AGENTS.md"
  {
    printf '# Fixture, the line\n\n| Stage | Job | Input | Output | Human check |\n|---|---|---|---|---|\n| `01_step` | do the thing | the brief | `runs/<unit>/01-out.md` | read the output against the brief |\n\n'
    body status-convention; echo; body edit-surface; echo; body naming
  } > "$B/CONTEXT.md"
  { printf '# Fixture\n\nWhat this does. How to start.\n\n'; body icm-credit; } > "$B/README.md"
  cat > "$B/01_step/CONTEXT.md" <<'EOF'
# 01_step, do the thing

## Inputs
- Working (this run): `../runs/<unit>/00-brief.md`
- Reference (every run): `../_reference/rules.md`

Do NOT load: anything else.

## Process
1. Do the thing.

## Outputs
- `../runs/<unit>/01-out.md`

## Human check
Read `01-out.md` against the brief, line by line. Flip `status: approved`.
EOF
  printf '# Rules\n\nBe brief.\n' > "$B/_reference/rules.md"
}

expect() {  # $1 PASS|FAIL, $2 label: gates the current fixture and scores the outcome
  n=$((n + 1))
  if bash "$M/_system/validate.sh" fixture > "$M/out.txt" 2>&1; then got=PASS; else got=FAIL; fi
  if [ "$got" = "$1" ]; then
    printf 'ok    %-5s %s\n' "$1" "$2"
  else
    printf 'WRONG %-5s %s (gate said %s)\n' "$1" "$2" "$got"
    grep -E '^FAIL' "$M/out.txt" | head -3 | sed 's/^/        /'
    wrong=$((wrong + 1))
  fi
}

fresh; expect PASS "clean fixture"

# ---- must FAIL: one defect at a time ----
fresh; printf 'cd c:/icm-factory/_reference\nsource ../../outside.sh\n' > "$B/leak.sh";       expect FAIL "shell file with an absolute path and ../../"
fresh; printf '{"p": "../../outside.json"}\n' > "$B/leak.json";                              expect FAIL "json file with ../../"
fresh; printf '\nSee `../pelto/voice.md`.\n' >> "$B/README.md";                               expect FAIL "single ../ from the build root"
fresh; printf '\nBuilt by the ICM Factory.\n' >> "$B/README.md";                              expect FAIL "factory named as ICM Factory"
fresh; sed -i 's|`../_reference/rules.md`|`../_reference/rules.md`, `../_reference/missing.md`|' "$B/01_step/CONTEXT.md"; expect FAIL "stage contract routes to a missing file"
fresh; printf '\n## Notes %s extra\n' "$EM" >> "$B/_reference/rules.md";                       expect FAIL "em dash in a heading"
fresh; printf '\n```\nfoo %s bar\n```\n' "$EM" >> "$B/_reference/rules.md";                   expect FAIL "em dash in a fenced block"
fresh; printf '\nA line %s with a dash.\n' "$EM" >> "$B/_reference/rules.md";                  expect FAIL "em dash in body prose"
fresh; echo stray > "$M/stages/stray.md";                                                     expect FAIL "stray file at the top of stages/"
fresh; mkdir -p "$M/stages/00_x/output";                                                      expect FAIL "stray folder inside a stage"
fresh; printf '\nSee `../../outside.md`.\n' >> "$B/_reference/rules.md";                      expect FAIL "../../ in body markdown"
fresh; printf '\nSee c:/pelto/x.md\n' >> "$B/_reference/rules.md";                            expect FAIL "windows absolute path in markdown"
fresh; printf '\nSee [x](/home/x/y.md)\n' >> "$B/_reference/rules.md";                        expect FAIL "markdown link to an absolute unix path"
fresh; printf 'BLOCK: icm-credit\n' >> "$B/README.md";                                        expect FAIL "unresolved BLOCK marker"
fresh; printf '{{slot}}\n' >> "$B/README.md";                                                 expect FAIL "unfilled slot in the root README"
fresh; printf -- '---\nstage: 01_form\n---\n' > "$B/_reference/x.md";                          expect FAIL "factory stage frontmatter"
fresh; touch "$B/SKELETON.md";                                                                expect FAIL "skeleton how-to shipped"
fresh; touch "$B/manifest.md";                                                                expect FAIL "manifest shipped"
fresh; sed -i 's/MIT-licensed/MIT licensed/' "$B/README.md";                                  expect FAIL "edited block body"
fresh; sed -i '/^block: naming/d' "$R/03-emit-log.md";                                        expect FAIL "every-build block missing from the emit log"
fresh; sed -i 's/status: approved/status: draft/' "$R/01-plan.md";                            expect FAIL "unapproved run file"
fresh; rm -f "$R/03-emit-log.md";                                                             expect FAIL "emit log missing"
fresh; rm -rf "$B/_reference";                                                                expect FAIL "missing _reference/"
fresh; yes 'x' | head -3300 | tr -d '\n' | fold -w 80 >> "$B/CONTEXT.md";                     expect FAIL "root CONTEXT.md over budget"
fresh; sed -i '/^## Human check/d' "$B/01_step/CONTEXT.md";                                   expect FAIL "contract without a human check"
fresh; rm -rf "$B/01_step"; sed -i '/01_step/d' "$B/CLAUDE.md";                               expect FAIL "build with no stage folder"
fresh; printf '\nBuilt by ICMFactory.\n' >> "$B/README.md";                                   expect FAIL "factory named without a separator"
fresh; printf '\nSee [x](/_reference/rules.md)\n' >> "$B/_reference/rules.md";                expect FAIL "markdown link to an absolute path starting with _"
fresh; printf -- '---\nslug: fixture\nstatus: draft\n---\nstatus: approved\n' > "$R/01-plan.md"; expect FAIL "approval quoted in the body, frontmatter says draft"
fresh; printf '\nRead the two files.\n' >> "$B/_reference/rules.md";                              expect FAIL "spelled-out number in authored prose"
fresh; printf '\n## Two notes\n' >> "$B/_reference/rules.md";                                     expect FAIL "spelled-out number in a heading"
fresh; sed -i '/^check: none/d' "$R/02-scaffold/manifest.md";                                   expect FAIL "manifest with no check: line"
fresh; sed -i 's|^check: none|check: false {file} :: README.md|' "$R/02-scaffold/manifest.md";  expect FAIL "self-check that exits nonzero"
fresh; sed -i 's|^check: none|check: test -f {file} :: nothing-*.md|' "$R/02-scaffold/manifest.md"; expect FAIL "self-check whose files match nothing"
fresh; printf 'check: test -f {file} :: README.md\n' >> "$R/02-scaffold/manifest.md";           expect FAIL "check: none beside a real check"
fresh; rm -f "$B/AGENTS.md";                                                                   expect FAIL "AGENTS.md missing"
fresh; printf '\n- A line added by hand.\n' >> "$B/AGENTS.md";                                 expect FAIL "AGENTS.md hand-edited away from CLAUDE.md"
fresh; mkdir -p "$B/01_step/references";                                                       expect FAIL "empty folder inside the build"

# ---- must PASS: legitimate look-alikes ----
fresh; mkdir -p "$B/skills/x"; printf 'const a = s.replace(/data:image/, "x");\n' > "$B/skills/x/tool.mjs";   expect PASS "JS regex literal in a code file"
fresh; mkdir -p "$B/skills/x"; printf 'See [root](../../README.md)\n' > "$B/skills/x/README.md";                expect PASS "../../ from depth 2 stays inside"
fresh; printf '\nSee https://example.com/docs\n' >> "$B/README.md";                                            expect PASS "https URL"
fresh; printf -- '---\nstage: 01_gameplan\nstatus: draft\n---\n# T\n' > "$B/_reference/template.md";            expect PASS "a build's own stage frontmatter"
fresh; mkdir -p "$B/skills/x"; printf '<b>{{ACCENT}}</b>\n' > "$B/skills/x/page.html";                          expect PASS "{{slot}} inside an html asset"
fresh; printf '\nInstall to `C:\\Users\\<you>\\.claude\\skills\\x\\`\n' >> "$B/README.md";                      expect PASS "install path with a <placeholder>"
fresh; printf 'PK\003\004\000\000c:/icm-factory ../../ %s \000\000' "$EM" > "$B/font.woff2";                    expect PASS "binary file whose bytes would otherwise match"
fresh; printf '\nSee `00-brief.md` and `manifest.md` in prose.\n' >> "$B/01_step/CONTEXT.md";                   expect PASS "bare file names in a contract are prose"
fresh; printf '\nAlso skip `_reference/rules.md`.\n' >> "$B/01_step/CONTEXT.md";                                expect PASS "root-relative path in a contract resolves from the root"
fresh; sed -i 's|^block: icm-credit -> README.md|block: icm-credit -> `README.md`|' "$R/03-emit-log.md";         expect PASS "emit log path in backticks"
fresh; sed -i 's|^block: icm-credit -> README.md|block: icm-credit -> builds/fixture/README.md|' "$R/03-emit-log.md"; expect PASS "emit log path with the builds/<slug>/ prefix"
fresh; printf '\nSee [cdn](//cdn.example.com/x.js)\n' >> "$B/README.md";                                        expect PASS "protocol-relative link is not a path"
fresh; printf '\nSee `one-video.md` and `two.sh`.\n' >> "$B/_reference/rules.md";                                expect PASS "spelled-out number inside a code span"
fresh; printf '\n```\nthree = 3\n```\n' >> "$B/_reference/rules.md";                                             expect PASS "spelled-out number inside a fenced block"
fresh; printf '\nPick the one you need, and no one else.\n' >> "$B/_reference/rules.md";                         expect PASS "one doing a pronoun's job"
fresh; mkdir -p "$B/skills/x"; printf 'Take two.\n' > "$B/skills/x/README.md";                                   expect PASS "spelled-out number in a copied skill file"
fresh; sed -i 's|^check: none|check: test -f {file} :: README.md 01_step/CONTEXT.md|' "$R/02-scaffold/manifest.md"; expect PASS "self-checks that pass"

echo
if [ "$wrong" -eq 0 ]; then
  echo "test-gate: $n probes, every one landed as expected."
else
  echo "test-gate: $wrong of $n probes landed WRONG. The gate has a blind spot or a false positive."
fi
[ "${KEEP:-0}" = 1 ] || rm -rf "$M"
[ "$wrong" -eq 0 ]
