"""Structural checks on world/. Read-only; a pass approves nothing.

Run from the folder root:  python -B -m unittest discover -s tests -v
Standard library only. runs/ is never read.

A blank world passes: a draft file may leave its fields empty. An approved
file may not. What is checked is shape, routing, and links, never a creative
fact and never whether a file deserves its status.
"""

from pathlib import Path
import re
import unittest

ROOT = Path(__file__).resolve().parents[1]
WORLD = ROOT / "world"
ENV = WORLD / "environment"
LOCATIONS = ENV / "locations"
REFERENCES = WORLD / "references"
CHARACTERS = WORLD / "characters"

BASE_FIELDS = ("world", "stage", "status", "generated", "sources")
ROUTING_FIELDS = ("kind", "scope", "depends_on", "reference_roles")
MODULES = ("core.md", "palette-lighting.md", "architecture.md", "materials.md",
           "terrain-vegetation.md", "topology.md")
ROLE = re.compile(r"^world/references/[A-Za-z0-9._-]+\.md#[a-z0-9-]+$")
LOCATION_LABELS = ("What is there", "Dominant architectural family", "Where detail clusters",
                   "Where the frame stays quiet or open",
                   "Entrances, exits, and links to other locations",
                   "Where the light comes from", "What the palette does here", "Underfoot")
STYLE_SECTIONS = ("Medium", "Look", "Camera defaults", "Aspect ratio", "Framing conventions",
                  "Composition load", "Reference-use rules", "Reference map", "Exclusions", "Open")
CHARACTER_SECTIONS = ("Identity", "Silhouette", "Face", "Hair", "Build", "Signature features",
                      "Wardrobe", "Variables", "Reference map", "Open")


def read(path):
    return path.read_text(encoding="utf-8")


def metadata(text):
    """The frontmatter as a dict: a scalar is a string (None when empty), a list is a list."""
    if not text.startswith("---\n"):
        raise ValueError("missing frontmatter")
    fields = {}
    key = None
    for line in text.split("---\n", 2)[1].splitlines():
        if line.startswith("  - "):
            if key is None:
                raise ValueError(f"list item without a key: {line}")
            if fields[key] is None:
                fields[key] = []
            if not isinstance(fields[key], list):
                raise ValueError(f"list item under a scalar: {line}")
            fields[key].append(line[4:].strip())
        elif line.strip():
            key, value = line.split(":", 1)
            key = key.strip()
            value = value.strip()
            fields[key] = [] if value == "[]" else (value or None)
    return fields


def as_list(value):
    return value if isinstance(value, list) else []


def approved(fields):
    return fields.get("status") == "approved"


def named(folder):
    return sorted(p for p in folder.glob("*.md") if p.name != "README.md")


def records():
    """Every world file that carries routing fields, with the kind its home requires."""
    found = {WORLD / "environment.md": "environment-index", WORLD / "style.md": "style-bible"}
    for path in ENV.rglob("*.md"):
        if path.name != "README.md":
            found[path] = "environment-location" if LOCATIONS in path.parents else "environment-module"
    for path in named(REFERENCES):
        found[path] = "reference-permissions"
    for path in named(CHARACTERS):
        found[path] = "character-bible"
    return found


def closure(start):
    """Follow depends_on only. Raises on a missing file, a path outside world/, or a cycle."""
    seen, active = set(), []

    def visit(rel):
        path = (ROOT / rel).resolve()
        if not path.is_relative_to(WORLD.resolve()) or path.suffix != ".md" or not path.is_file():
            raise ValueError(f"depends_on names no world file: {rel}")
        if rel != path.relative_to(ROOT.resolve()).as_posix():
            raise ValueError(f"depends_on must be a path from the folder root: {rel}")
        if rel in active:
            raise ValueError(f"depends_on cycle at {rel}")
        if rel in seen:
            return
        active.append(rel)
        for dep in as_list(metadata(read(path)).get("depends_on")):
            visit(dep)
        active.pop()
        seen.add(rel)

    visit(start)
    return seen


class WorldStructure(unittest.TestCase):

    def test_metadata_reads_scalars_and_lists(self):
        self.assertIsNone(metadata("---\nworld:\n---\n")["world"])
        self.assertEqual(metadata("---\ndepends_on: []\n---\n")["depends_on"], [])
        self.assertEqual(
            metadata("---\ndepends_on:\n  - world/environment/core.md\n---\n")["depends_on"],
            ["world/environment/core.md"])

    def test_every_home_exists(self):
        for name in MODULES:
            self.assertTrue((ENV / name).is_file(), name)
        for path in (WORLD / "environment.md", WORLD / "style.md", WORLD / "interview.md",
                     LOCATIONS / "README.md", REFERENCES / "README.md", CHARACTERS / "README.md"):
            self.assertTrue(path.is_file(), path.relative_to(ROOT).as_posix())

    def test_router_lists_every_module_and_location_and_holds_no_facts(self):
        router = read(WORLD / "environment.md")
        self.assertEqual(metadata(router).get("kind"), "environment-index")
        for path in sorted(ENV.rglob("*.md")):
            if path.name != "README.md":
                self.assertIn(path.relative_to(WORLD).as_posix(), router, path.name)
        self.assertNotRegex(router, r"\[(stated|inferred)", "a trait line in the router")

    def test_records_carry_their_fields(self):
        for path, kind in sorted(records().items()):
            with self.subTest(path=path.relative_to(ROOT).as_posix()):
                fields = metadata(read(path))
                for key in BASE_FIELDS + ROUTING_FIELDS:
                    self.assertIn(key, fields, key)
                self.assertEqual(fields["kind"], kind)
                self.assertEqual(fields["stage"], "00_setup")
                self.assertIn(fields["status"], ("draft", "approved"))
                for key in ("depends_on", "reference_roles"):
                    self.assertIsInstance(fields[key], list, key)
                if kind == "reference-permissions":
                    self.assertIn("image", fields)
                if approved(fields):
                    for key in ("world", "generated", "scope"):
                        self.assertTrue(fields.get(key), f"approved with empty {key}")
                    self.assertTrue(as_list(fields["sources"]), "approved with no sources")

    def test_dependencies_resolve_and_never_name_a_location(self):
        for path in sorted(records()):
            rel = path.relative_to(ROOT).as_posix()
            with self.subTest(path=rel):
                self.assertIn(rel, closure(rel))
                for dep in as_list(metadata(read(path)).get("depends_on")):
                    self.assertNotIn("/locations/", dep, "a location is selected, never depended on")

    def test_reference_roles_point_at_a_role_that_exists(self):
        for path in sorted(records()):
            with self.subTest(path=path.relative_to(ROOT).as_posix()):
                for role in as_list(metadata(read(path)).get("reference_roles")):
                    self.assertRegex(role, ROLE)
                    rel, role_id = role.split("#", 1)
                    target = ROOT / rel
                    self.assertTrue(target.is_file(), rel)
                    self.assertIn(f"### {role_id}\n", read(target), role)

    def test_reference_records_name_an_image_and_limit_each_role(self):
        images = set()
        for path in named(REFERENCES):
            text = read(path)
            fields = metadata(text)
            with self.subTest(path=path.name):
                image = fields.get("image")
                self.assertTrue(image, "image field")
                self.assertTrue(image.startswith("world/references/"), image)
                self.assertTrue((ROOT / image).is_file(), image)
                self.assertNotIn(image, images, "2 records for 1 image")
                images.add(image)
                blocks = re.split(r"^### ([a-z0-9-]+)\n", text, flags=re.M)
                ids = blocks[1::2]
                self.assertTrue(ids, "no ### role")
                self.assertEqual(len(ids), len(set(ids)), "duplicate role id")
                for body in blocks[2::2]:
                    for field in ("Evidence class", "Use only for", "Do not transfer"):
                        self.assertIn(f"| {field} |", body, field)
                    if approved(fields):
                        self.assertRegex(body, r"\| Evidence class \| (direct|inspiration|conflict-only) \|")
                        self.assertNotRegex(body, r"\| (Use only for|Do not transfer) \|\s*\|", "empty cell")

    def test_permission_tables_live_only_in_reference_records(self):
        for path in sorted(records()):
            if REFERENCES in path.parents:
                continue
            with self.subTest(path=path.relative_to(ROOT).as_posix()):
                self.assertNotIn("| Evidence class |", read(path), "a permission table outside references/")

    def test_locations_carry_every_field(self):
        for path in named(LOCATIONS):
            text = read(path)
            with self.subTest(path=path.name):
                for label in LOCATION_LABELS:
                    self.assertEqual(text.count(f"- {label}:"), 1, label)

    def test_bibles_carry_their_sections_in_order(self):
        files = [(WORLD / "style.md", STYLE_SECTIONS)]
        files += [(p, CHARACTER_SECTIONS) for p in named(CHARACTERS)]
        for path, required in files:
            with self.subTest(path=path.relative_to(ROOT).as_posix()):
                headings = re.findall(r"^## (.+)$", read(path), flags=re.M)
                self.assertEqual([h for h in headings if h in required], list(required))

    def test_approved_trait_lines_are_marked(self):
        for path in sorted(records()):
            text = read(path)
            fields = metadata(text)
            if not approved(fields) or fields["kind"] in ("environment-index", "reference-permissions"):
                continue
            with self.subTest(path=path.relative_to(ROOT).as_posix()):
                for line in text.split("---\n", 2)[2].splitlines():
                    if re.match(r"^- [^:]+: \S", line):
                        self.assertRegex(line, r"\[(stated: [^\]]+|inferred)\]\s*$", line)

    def test_entry_files_match(self):
        self.assertEqual((ROOT / "CLAUDE.md").read_bytes(), (ROOT / "AGENTS.md").read_bytes())


if __name__ == "__main__":
    unittest.main()
