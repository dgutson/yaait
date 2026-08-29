# R-022 — grading a DESIGN.md against `design`'s own rules

`./grade.sh <DESIGN.md> <label>` prints PASS/FAIL for five rules plus `mmdc`, **with the evidence
line for each verdict**, because the verdict alone is what went wrong twice.

## Why this is checked in

This check has been re-derived from scratch in three sessions and got the same rule wrong twice, in
opposite directions:

- a grep-based check reported **false PASS** on a run that failed the coined-term rule, because the
  `Owns:` paragraph happened to mention the state names while discussing something else;
- a per-line 110-character window reported **false FAIL** on `mnb-opus/DESIGN.md`, which does state
  the range — the sentence wrapped across two source lines.

Both errors reached `ROADMAP.md` as findings. The second had stood since commit `847b4da` and was
the stated reason 0.16.0 left that rule alone. Re-deriving the ruler is how a stable rule gets
recorded as broken.

## Reading the output

- **R4 is the fragile one.** It searches the whole document whitespace-collapsed, requiring the four
  state names within 110 characters *after* an occurrence of `phase`. Both historical errors were
  in this check. Change it only with the corpus below re-run.
- **R1 prints `n/a`** where a design uses no `namespace` at all — a vacuous pass is not a pass.
- **The state count** is read out of the rendered SVG, which is the only way the silent
  semicolon-truncation shows up: `mmdc` exits 0 on it.

## Corpus, and what it must produce

Any change to this script must keep these, which are the recorded measurements re-derived:

| artifact | expected |
|---|---|
| Sonnet run (`DESIGN-rerun.md`) | R3 FAIL, R4 FAIL, R5 FAIL ×1 |
| 0.13.0 baseline (`DESIGN-naval.md`) | R1 n/a, R2 FAIL, R3 FAIL, R4 FAIL |
| Opus @0.16.0-pre (`mnb-opus`) | R3 FAIL, **R4 PASS**, R5 FAIL ×6, 0 of 3 render |
| Opus @0.17.x (three runs) | all PASS, 3 of 3 render, six states |

## Not product

Nothing in `skills/` runs or references this. It is apparatus for deciding what to write in the
skills, and it has skipped every gate the product goes through.
