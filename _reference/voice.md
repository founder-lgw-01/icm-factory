# Voice, how anything the factory writes reads

This governs what the factory writes: contracts, routing files, blocks, and every
file inside an emitted build. It does not govern a built agent's *subject matter*
voice. That is the built agent's own `_reference/voice.md`, written at scaffold
time from what intake heard.

## The laws

1. **No em dashes.** Anywhere, no exceptions. Not in contracts, not in blocks,
   not in a README, not in a build. Use a period, a comma, or a colon. An em
   dash is a tell, and a rule carrying an exemption is a rule people learn to
   route around. `_system/voice-check.sh` enforces this on every text file it is
   pointed at, code included.
2. **No empty summary sentences.** "That's the whole system." "That's it."
   The fix is always deletion, never rewording.
3. **Numbers as digits.** 3 stages, never spelled out. Headings count; code
   spans do not. The word for 1 doing a pronoun's job (no one, one of, the one
   you need) is not a number.
4. **No hedging in a contract.** A contract says *do this*. "Consider", "you may
   want to", "it might be good to" are all defects: either it is the process or
   it is not.
5. **A human check is a verb a person performs.** "Read the findings against the
   transcript, timestamp by timestamp" passes. "Review the output" fails.
6. **Name the file.** Not "the upstream output" but `../../runs/<slug>/00-intake.md`.

Gated by `_system/voice-check.sh`: laws 1 to 5. Law 3 is read on the files the
scaffold authors or repairs, never on files copied from a source, whose numbers
belong to their author. Law 6 is style, read by a person and not by the script.

## Shape

- A contract is about 2 KB. Longer means constraints are being restated that
  belong in a reference file.
- Routing files hold no content payload. If a routing row starts explaining, the
  explanation belongs in the file the row points at.
- Prefer the concrete noun over the category: "the term sheet", not "the
  documentation artifact".
- Write the reason once, where the rule lives. Do not repeat a justification in
  3 files: that is drift with good intentions.

## Provenance

Laws 1 and 2 are adapted from
`_source-corpus/rymac-production-line/checks/voice-check.sh`, which enforces the
same rules for a video line, and law 3 from that kit's hard rule 7, with its pronoun exemption taken from
its `check-plain.sh`. The script's
law 3 (developer talk) and laws 5 and 6 (numbered slides, a standing close) are
video-specific and were not carried over.
