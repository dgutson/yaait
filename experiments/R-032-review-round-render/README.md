# R-032 — grading a review round on what the user actually saw

`./grade.sh <picker-payloads.jsonl> <screen.txt> <label>` prints PASS/FAIL per rule with the
evidence line, for one run of Step 6's review round.

## Why there are two inputs

Because they answer different questions, and the difference is the entire point.

- **`picker-payloads.jsonl`** is what the gate *wrote* — captured by a `PreToolUse` hook on
  `AskUserQuestion`, untruncated, before any rendering.
- **`screen.txt`** is what the user *saw* — `tmux capture-pane -p -S -3000`.

A rule that fails in the payload is an **authoring** defect: the gate never wrote the thing.
A rule that passes in the payload and fails on screen is a **rendering** defect: the gate wrote
it and the terminal ate it. `R2b` is the check that separates them.

That distinction is why 0.18.0 took two releases. An ask shipped as
`I-12 — the client draws ships from offsets the server sent…` with the kind keyword in a picker
header that holds about a dozen characters. Nobody could say whether `Reviewing` had been written
and dropped, or never written, so the fix was aimed twice at the wrong half.

## Capturing the inputs

The hook goes in the **test directory's** `.claude/settings.local.json`, never in the box's
global settings — it must not fire for unrelated sessions:

```json
{"hooks":{"PreToolUse":[{"matcher":"AskUserQuestion",
  "hooks":[{"type":"command","command":"cat >> <testdir>/picker-payloads.jsonl"}]}]}}
```

Record the pane geometry with the findings. Rendering depends on width, so a wrapping result
means nothing without the width it was observed at.

## Reading the output

- **`P0 FAIL` is not a pass with no data.** It means `AskUserQuestion` never fired, and there are
  two very different causes: the hook did not attach, or the gate rendered its options as prose
  rather than as a picker. The second is a real finding — the whole picker doctrine in
  `METHODOLOGY.md` §3 would be defending a failure mode that does not occur, and the
  `Explain <concept>` affordance would be gone, which is the one whose point is that choosing it
  costs nothing while typing "I don't know what that means" is a confession in writing. Read the
  screen by hand before deciding which.
- **`R1 FAIL` together with `R2 FAIL` is the 0.18.0 signature** — the keyword left the question
  text and reappeared in the header.
- **`R6` counts lines between stop headings** and stops at the first TUI rule character. It is
  the check most likely to misread an unusual layout; confirm a FAIL against the screen before
  filing it. The cap has been four lines, not three, only since 0.20.1 — grading a pre-0.20.1
  capture with it measures a rule that document did not consistently state.
- **`n/a` is not a pass.** It means the input could not answer the question.

## Corpus, and what it must produce

Any change to this script must keep these. `<w>` is the pane width, and it is not optional.

| capture | expected |
|---|---|
| 0.20.1 `tech` Step 6, Opus 5 xhigh, 120x40, both picker calls | all PASS except **R4b FAIL 4/8** (`workers`, `X-002`) |
| synthetic compliant round | all PASS |
| synthetic round with the 0.18.0 signature and every forbidden wording | R1, R2, R3, R4b, R5, R6 all FAIL separately |
| empty payload file | `P0 FAIL`, and every payload-dependent rule `n/a` rather than PASS |

## Two ways this script was already wrong

Both were caught before anything was filed, and both are the failure R-022 exists to prevent —
happening again while writing R-022's sibling.

- **R4 demanded the fixed option set unconditionally.** The block makes `Give my view` /
  `Explain <concept>` / `Show me what it costs` / `Keep what you wrote` the fallback for a stop
  with **no fork**; where a fork exists, its branches *are* the options. The first version would
  have reported a false FAIL on a fully compliant run. It is now `R4a`, and fork-aware.
- **R6 counted captured lines, which counts wrapping.** A compliant four-line stop wrapped at
  120 columns was reported as eleven lines. The fix de-wraps — but only against a pane width
  **supplied as argument 4**. Inferring the width from the longest line is not a safe fallback:
  on prose that is not wrapped, the longest line is just the longest sentence, and joining on it
  merged independent lines and turned a genuine six-line stop into a PASS. With no width given,
  R6 now says so in its evidence line instead of pretending.

## What it deliberately does not grade

Judgment, which belongs in prose: whether the stops arrived spread out or as one block of four
labelled asks; whether the keyword was taught on first use; whether a question typed mid-round
reopened the discussion and then returned to the route; and whether the round reads as an exam.

That last one is not gradeable by anything here. A session driving its own picker is
self-answering, so this apparatus buys fidelity on the **instrument** only. Whether the round
still feels like a test is Daniel's judgment and nobody else's.

## Not product

Nothing in `skills/` runs or references this. It is apparatus for deciding what to write in the
skills, and it has skipped every gate the product goes through.
