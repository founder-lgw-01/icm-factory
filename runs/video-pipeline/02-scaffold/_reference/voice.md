# Voice, how anything the owner publishes reads

The owner's answers shape this: the banned words and the close words on the 2
machine-read lines of `../_config/my-line.md` are theirs. `../checks/voice-check.sh`
enforces laws 1 to 4 on the bytes about to ship. A failing law is a stop.

## The laws

1. **No em dashes.** Anywhere. Use a period, a comma, or a colon.
2. **Numbers as digits.** 1 video, 14 words, 9 stages.
3. **No developer talk on a public surface.** No word a salesperson would not
   say on a live call. The list lives in `../checks/voice-check.sh`. A "you may
   hear that called" sandwich is the only way a term gets in.
4. **The owner's banned words never ship, and the close words end every channel
   script.** Both lists live in the config, `BANNED-WORDS:` and `CLOSE-WORDS:`.
5. **A slide is 1 complete spoken thought, 14 words or fewer, with no period.**
   You read at about 2.5 words a second and a slide holds under 6 seconds.
6. **Never invent a number.** Count it, measure it, or mark it UNMEASURED.

## Shape

The owner's cadence is carried by `../skills/rymac-write-in-the-owners-voice/SKILL.md`,
which runs before any word they publish. Quotes and testimonials are exempt from
these laws: editing a customer's words to satisfy a style rule is falsifying a
testimonial.

## Never

- Ship a file the voice check has not passed.
- Edit a quote to satisfy a law.
