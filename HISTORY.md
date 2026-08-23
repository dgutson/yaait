# History

> Completed roadmap items and finished passes of work, newest first.

## 2026-08-23

### Doctrine pass: maintenance framing, the loop, two TTB kinds, tool-agnosticism

Twenty-one commits on `methodology-maintenance-and-refactorings`, run 2026-08-21..23.
**No ROADMAP item was closed** — this pass changed what the method says rather than
working an item, which is why it is recorded here by date instead of by ID.

- **`COMPARISON.md` — the practitioner changed knowledge areas.** Construction
  (SWEBOK v4 KA 4) is what got delegated to the machine; what is left for the human is
  maintenance (KA 7), whose dominant cost has always been comprehension. Every quotation
  verified against the IEEE PDF rather than a third party's paraphrase of it.
- **Two kinds of TTB, not three.** `fix` / `feature` / `greenfield` became **Greenfield**
  / **Maintenance**, on the only axis a spec can answer honestly: does the project already
  exist. Determined by looking, not by asking. Four behaviours turned on "does the code
  exist"; none turned on fix-vs-feature.
- **`METHODOLOGY.md` §2 — the loop got a name.** `educate → discuss → agree → implement →
  verify`, per decision rather than per artifact. It was being re-spelled per step in
  `design` and `code` and named nowhere. All five steps always run; **weight scales**.
- **§11, §12 and §1 additions.** Declare the budget's units from the project's own
  vocabulary before counting them; standing decisions live in `DESIGN_GUIDELINE.md` and
  `CODING_GUIDELINE.md`; and what an invocation may carry is not exempt from the loop.
- **The doctrine is tool-agnostic.** It cites its catalogues by concept with one locator
  table at the end, so repackaging cannot invalidate it. Skills may stay Claude-specific.
- **Skills.** The loop entered the shared rules block in all six identically (now 198
  lines) and was threaded at step level through `design`, `code` and `spec`.
  Defend-before-you-modify deliberately still triggers on "code that already exists",
  never on the TTB kind — phrasing it as "on a Maintenance TTB" would switch the gate off
  for increment 2 of a Greenfield project, the case the framing exists to catch.
- **Released 0.4.0.**

Closed out on 2026-08-23, after an audit of the whole tree: three `§N` references that
resolved to the wrong section, a `DESIGN.md` template still gating on the removed TTB
kinds, three `CLAUDE.md` claims the pass had invalidated, and a README artifact tree
missing the two guideline files. The lesson is in `CLAUDE.md`'s reference invariant — a
renumber can leave a reference resolving to the *wrong* section, and a dangling-reference
check reports clean.

Still open, and not attempted: **R-002** (dogfooding needs a fresh session in a separate
directory), **R-009** (`REVIEW.md`'s eleven findings against `MANIFESTO.md`, none applied)
and **R-001** (`skills/code/references/review.md` §5 remains PROVISIONAL).
