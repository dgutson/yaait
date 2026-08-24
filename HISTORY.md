# History

> Completed roadmap items and finished passes of work, newest first.

## 2026-08-24

### Prep for the first project: no duplicate standing rules, and a run that records itself

Both changes alter what an installed copy does, so **released 0.7.0**.

**The spec gate no longer breaks the project's `CLAUDE.md`.** Step 9 appended the `## yaait`
block with no idempotency guard, so a second `/yaait:spec` — the normal case, since every
change after the first is a Maintenance TTB — installed the standing rules twice. It now reads
the file first and branches on whether a `## yaait` heading is present, offering to replace a
block that differs rather than appending beside it. The block also gained the spike carve-out
`METHODOLOGY.md` §5 has always carried; without it, the file governing every future session in
that project — including sessions that never load this plugin — instructed them to gate
throwaway measurements, which is the category error §5 names by name. This discharges the
second half of REVIEW A11.

**The method now records which gates ran, and which were recommended and skipped.** The first
dogfood exists to find where the method gets quietly abandoned, and nothing could produce that
record: `JOURNAL.md` entries carried a date and a type but not their origin, and a declined
gate was detected in two places and written down in neither. Two mechanisms, neither of which
asks anyone to keep notes:

- **Every `JOURNAL.md` entry opens with a `Gate:` line.** Several gates run on one day, so the
  file recorded what was decided but not which part of the method was in use when it was. Five
  templates in the shared block of all six skills, mirrored in `METHODOLOGY.md` §8, whose
  worked example now shows two different gates under one date.
- **A gate recommended and never run becomes visible.** `SPEC.md` gained a `Gates recommended`
  section, written by `spec` Step 10 *even when the answer is "not warranted"* — a spec with no
  `DESIGN.md` beside it is otherwise indistinguishable from one whose design phase was
  recommended and skipped. `code` Step 0 checks that section against what is on disk and
  appends a `DECISION` when the user proceeds anyway, and does the same on its no-spec path.
  No new entry type: a declined gate already fits `DECISION`'s Context/Chosen/Rejected shape.

`Format: 1` stands — nothing validates the field, the new section is additive, and no `SPEC.md`
exists anywhere yet to be misread.

**What this deliberately does not cover.** A gate abandoned *mid-flow* leaves a partial
artifact and still reads as having run. The record answers "which gates ran" and "which were
skipped outright", not "where did the user stop halfway". The OO-only vocabulary of the
reference material was checked and deferred: it costs nothing on the OO project this will
first be run against, and becomes blocking the day yaait is pointed at C.

This repo's own `CLAUDE.md` also stopped claiming four reference files where there are five.

### The author stops auditing itself: `design` gets an independent check

`design` Step 7a spawns a subagent with `references/independent-check.md` as its brief. It
receives `DESIGN.md`, `SPEC.md`, `TECH_DEBT.md` and `DESIGN_GUIDELINE.md` where they exist,
and **not the conversation** — that omission is the whole mechanism.

- **Why it is not Step 6 twice.** Step 6 has the author check its own design and stays, as a
  supplement. It grades the intention, because the intention is the one thing the author
  cannot forget. This is `stest`'s own argument about self-grading, applied a level down.
- **Runs after Step 7**, once `DESIGN.md` exists, because a blind reader needs an artifact
  rather than a description of one.
- **Findings are shown unfiltered; the caller rebuts but cannot suppress.** The caller holds
  what the checker was denied, so a rebuttal is useful — and a rebuttal that lands is usually
  a spec defect, since the justification existed only in the conversation.
- **Disagreement is a discussion, not a verdict.** An overruled finding becomes a `DECISION`.
- **The failure guarded against is the detector that always fires.** Four mandatory fields per
  finding, "clean" declared an expected outcome, a cap of five, and `TECH_DEBT.md` and
  `DESIGN_GUIDELINE.md` in the inputs so a boxed shortcut and a standing project decision are
  not re-raised on every run.
- **`METHODOLOGY.md` §13** states the rule, since a skill implementing doctrine the source of
  truth never states inverts this repo's architecture. Appending §13 renumbers nothing.
- **Released 0.6.0.**

The diff-level half — needless verbosity, in the constructive form where the checker's own
shorter rewrite is the evidence — is deferred as **R-012**, blocked by R-001, because it needs
new criteria in a file that is still PROVISIONAL.

### The size budget is removed

`design` Step 1 made the model declare "4 modules, 6 types, 1 interface, 0 abstract base
classes" before designing; the number had reached fifteen sites including a manifesto
principle, a `METHODOLOGY.md` section, the `DESIGN.md` template and the shared block in all
six skills. It is gone.

- **The number was never the mechanism.** Step 4 judges each abstraction against its second
  concrete variant; Step 6 judges the whole design against `smells.md` §8, twelve
  LLM-specific antipatterns written about exactly this failure. Neither needs a count, and
  neither needs units — which is what had forced §11 into existence.
- **Read literally, the budget was an amnesty**, not a cap: only elements *beyond* the number
  had to name a second variant, exempting the first N from the test that works. Read
  charitably it was redundant. The ambiguity was itself a defect.
- **The pre-registration argument does not hold.** The same agent declared the number,
  designed against it and reported the result, in one turn, from the same spec. Registration
  works when a third party holds it and an independent instrument measures the outcome.
- **REVIEW A8 is resolved**, the first half by removal, the second — Principle 10 forbidding
  the litter box Principle 11 mandates — by the audit's own proposed clause: "or the dated
  event that will produce one", which is what `design` Step 4b already used.
- **R-001's Q1 lost a horn** and **R-011 lost an example**; both items stay open.
- **Released 0.5.0.** An installed 0.4.0 still asks for a budget and writes a `## Budget`
  section into `DESIGN.md` that nothing else in the method reads.

Nothing re-counts what no longer exists, so the planned A8a fix was dropped rather than
built. `METHODOLOGY.md` §11 keeps its number and its second half; `MANIFESTO.md`'s principles
were not renumbered, because a citation can survive a renumber while resolving to the wrong
principle.

### R-009 part A: the defense gets four outcomes and a teaching record

Three commits, `0f8bd4f`..`699749a`, applying `REVIEW.md` findings A1, A2 and A3.

- **Principle 8** said the opposite of what the method does. It now carries the shared block's
  own wording — a decision that exists *only* in the conversation has not happened — and the
  restatement in `METHODOLOGY.md` §2 was deleted rather than synced.
- **A1 — a fourth defense outcome.** *Answered wrongly* → `DEBT`, never `APPROVAL`. The `DEBT`
  template gained a `What happened` field.
- **A3 — every defense closes by naming what it did not probe**, as categories rather than
  instances. Recorded in `REVIEW.md` as "applied, but not as written".
- **`TAUGHT`**, a fifth journal entry type, deliberately recording the exchange and no verdict
  — so A5, whether machine-graded comprehension counts, stays a live question. The format
  landed before the command that reads it because `JOURNAL.md` is append-only.
- **R-007 became `:learn`** and lost a premise that was false: the teaching data it was said
  to read did not exist, because the Taught path wrote nothing.

Still open from R-009: A4, A5, A6, A7, A9, A10, A11, B1, B2, B3.

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
