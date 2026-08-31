# R-032 — grading a review round on what the user actually saw

`./grade.sh <picker-payloads.jsonl> <transcript.jsonl> <label>` prints PASS/FAIL per rule with
the evidence line, for one run of Step 6's review round.

## Why there are two inputs

Because they answer different questions, and the difference is the entire point.

- **`picker-payloads.jsonl`** is what the gate **asked** — captured by a `PreToolUse` hook on
  `AskUserQuestion`, untruncated. It answers every question about options and keywords.
- **`transcript.jsonl`** is what the gate **wrote**, with its real newlines — found at
  `~/.claude/projects/<project>/<session>.jsonl`, and named in every hook payload's
  `transcript_path`. It answers every question about the prose.

Neither is a terminal capture, and that is deliberate. **Never grade a `tmux capture-pane`
dump.** It is hard-wrapped at the pane width, so counting its lines counts wrapping rather than
the four things a stop is made of. The first version of this script did exactly that, called a
compliant four-line stop an eleven-line one, and then grew a pane-width argument and a de-wrap
heuristic to undo damage it had caused itself. The transcript never needed any of it.

The 0.18.0 failure — an ask shipped as `I-12 — the client draws ships from offsets the server
sent…` with the kind keyword in a picker header holding about a dozen characters — is a property
of the **payload**, not of rendering: the keyword went into `header` instead of `question`.
`R1` together with `R2` catch it with no screen involved.

## Capturing the inputs

The hook goes in the **test directory's** `.claude/settings.local.json`, never in the box's
global settings — it must not fire for unrelated sessions:

```json
{"hooks":{"PreToolUse":[{"matcher":"AskUserQuestion",
  "hooks":[{"type":"command","command":"cat >> <testdir>/picker-payloads.jsonl"}]}]}}
```

Record the model and effort with the findings. The captures below are Opus 5 at xhigh.

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
- **`R6` counts lines between stop headings**, stopping at a `---` rule. The cap has been four
  lines, not three, only since 0.20.1 — grading a pre-0.20.1 capture with it measures a rule
  that document did not consistently state.
- **`R7` is turn-scoped, and the turn boundary is the subtle part.** A stop's `The call:` line
  is prose *and* is carried by a picker; that is the shape Step 6 asks for, not an orphan. But
  Claude Code emits the prose and the `AskUserQuestion` call as separate transcript entries, so
  per-entry scoping calls every stop an orphan — and a picker **answer** arrives as a
  `tool_result` rather than a user message, so treating only spoken messages as boundaries lets
  everything said afterwards inherit that picker and hides the one real defect. A turn ends when
  the user *acts*: speaks, or answers a picker.
- **`n/a` is not a pass.** It means the input could not answer the question.

## Corpus, and what it must produce

Any change to this script must keep these.

| capture | expected |
|---|---|
| 0.20.1 `tech` Step 6, Opus 5 xhigh, full run with Daniel answering | all PASS except **R4b FAIL 4/8** (`workers`, `X-002`) and **R7 FAIL 1** (the taught follow-up) |
| synthetic compliant round | all PASS |
| synthetic with a five-line stop | R6 FAIL, **R7 PASS** — the two must not move together |
| synthetic with a question after an answered picker | R7 FAIL, **R6 PASS** |
| synthetic with the 0.18.0 signature and every forbidden wording | R1, R2, R3, R4b, R5 all FAIL separately |
| empty payload file | `P0 FAIL`, and every payload-dependent rule `n/a` rather than PASS |

## Two ways this script was already wrong

Both were caught before anything was filed, and both are the failure R-022 exists to prevent —
happening again while writing R-022's sibling.

- **R4 demanded the fixed option set unconditionally.** The block makes `Give my view` /
  `Explain <concept>` / `Show me what it costs` / `Keep what you wrote` the fallback for a stop
  with **no fork**; where a fork exists, its branches *are* the options. The first version would
  have reported a false FAIL on a fully compliant run. It is now `R4a`, and fork-aware.
- **R6 graded the wrong input entirely.** It counted lines in a terminal capture, so a
  compliant four-line stop wrapped at 120 columns came out as eleven. The first fix was a
  pane-width argument and a de-wrap heuristic — which then inferred the width from the longest
  line and turned a genuine six-line stop into a PASS. All of it was scaffolding around a
  choice that was simply wrong: the transcript holds the same prose with real newlines. Both
  the argument and the heuristic are gone.

## What it deliberately does not grade

Judgment, which belongs in prose: whether the keyword was taught on first use; whether a
question typed mid-round reopened the discussion and then returned to the route; and whether the
round reads as an exam.

That last one is not gradeable by anything here. A session driving its own picker is
self-answering, so this apparatus buys fidelity on the **instrument** only. Whether the round
still feels like a test is Daniel's judgment and nobody else's.

## Not product

Nothing in `skills/` runs or references this. It is apparatus for deciding what to write in the
skills, and it has skipped every gate the product goes through.
