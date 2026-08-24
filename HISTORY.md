# History

> Completed roadmap items and finished passes of work, newest first.

## 2026-08-24

### `:feedback`, an instrument for the friction the artifacts never show

Added `/yaait:feedback` in the same release. It captures what went wrong in the gate that just
ran — friction, contradictions, questions the user had no way of answering, ground covered
twice, the moments they were annoyed — into an append-only `.yaait/FEEDBACK.md`, for a later
session to read forensically with the transcript beside it.

**Why it exists.** The findings above were recovered by luck. The `spec` pass produced no
record of its own friction; what survived was a transcript and a one-off report written on
request afterwards, and that report — written by the session under audit — missed both of the
user's actual complaints. It never mentioned that the questions were hard to parse, which was
the loudest one, and it filed the split-interaction problem under smaller frictions. Every gate
generates evidence of its own defects and discards it, so the only defects that get fixed are
the ones an artifact happens to expose.

**Four rules replace the shared block, which this command deliberately does not carry.** The
user's account is not contestable — by the routing rule added above, their experience is in the
class where only they hold the answer, so the ordinary challenge protocol would actively damage
the record. It asks first and writes their words before its own, because the party under audit
is exactly the wrong party to frame the report. It records events, never verdicts, and must not
write a "what went well" section unless the user says what went well — a self-authored list of
the method's strengths is what makes a reader discount the rest of the file. And it captures
without diagnosing: root-causing its own friction would hand the later reader conclusions
instead of raw material.

**The prompts are proxies, not an emotion survey.** "Was that useful?" measures politeness, so
every prompt asks about an event instead: where did you read something twice, where did you
answer a different question than the one asked, where were you asked for something you had no
way of knowing, where did the same ground get covered twice, where did you give a shorter
answer than you had, what did you want to say and not say. The last one and "where were you
annoyed, and at what" carry the most and get volunteered the least. That final distinction is
load-bearing — annoyance at the *method* is a yaait defect, annoyance at the *problem* is what
hard work feels like, and the command asks which rather than deciding for the user.

**Two structural consequences.** `skills/feedback/` carries no shared rules block, so the
byte-identity check in CLAUDE.md now spells out the six gates instead of globbing
`skills/*/SKILL.md` — a glob reports the instrument as divergence. And `FEEDBACK.md` is in the
artifact layout with an explicit carve-out: it is the one file there that is not an upstream
artifact, nothing traces to it, and the reconcile rule does not apply, because a gate finding
it disagree with `SPEC.md` has found two different subjects rather than a contradiction.

**It says it is provisional, and names what retires it:** the friction it captures stopping
changing between projects, so the file records the same three things forever; or defects
arriving faster than they can be fixed, at which point a growing log of unactioned friction is
just a second backlog. Either observation belongs in a `FEEDBACK.md` entry like any other.

### The first dogfood answers back: yaait now says who to ask, and what kind of answer it wants

`/yaait:spec` ran on a real project for the first time — a multi-player naval battle game, in a
separate directory on another machine. It completed: 14 requirements, 6 non-goals, both
follow-on gates recommended. It also produced two complaints that no structural check in this
repo could have found, and both turned out to be the same missing rule. **Released 0.9.0**; the
shared rules block changed, so every gate behaves differently.

**The method said what to ask and never said who to ask.** Four questions in that session had
the wrong addressee. Step 5 asked the user what they would observe in three months — nobody has
the future, and "I don't have an adivination ball" is the correct answer to it. Step 1 asked
expected lifetime at the point of least information; the real answer ("an occasional quick game
with my 3 kids") arrived three rounds later at the defense and reframed the whole spec. A
defense question asked the user to work out whether rotation-only ship placement is *fair*,
which is analysis the gate should have done itself. And a challenge asserted who the harm fell
on — a child opening devtools to see hidden fleets — when that was a claim about the user's
values, and those values were the opposite: the answer was that a kid doing exactly that would
be a pleasing outcome, because they would have learned something. The objection was defeated on
its own terms rather than outweighed.

So both `METHODOLOGY.md` §2 and the shared block gained **Ask the right source**: every
question has exactly one source of truth — the user (intent, values, tolerance, environment), a
measurement (any quantity), you (consequences, mechanism, analysis), or nobody (the future,
which is never asked for and is instead converted into present-tense bets the user can rank).
The failure mode it names is the one that actually happened: **a misrouted question does not
come back empty.** It comes back with a confident answer to a different question, and the
record then says the point was settled. `spec` Step 5 is rewritten around that — the gate names
the bets, the user picks the shakiest — and Step 5a widens from feasibility to any load-bearing
quantity, because the measurement that transformed this spec was tuning (how long a match runs)
and had no slot in the method at all.

**The user could not tell a challenge from a confirmation from a comprehension probe.** The
defense had four items and they were four different kinds of request with nothing marking
which: one comprehension probe phrased as a rhetorical question, two decision requests (one
with no question mark in it at all), and one analysis request. Two things broke, both
observable in the transcript. His answers came back numbered 1–3 against a list of 4 — the item
flagged as most important got nothing, and the user said so unprompted. And the analysis got an
answer to a different question, which the gate accepted; that requirement now reads as settled
on grounds nobody asked about, which is an `APPROVAL` in the record where nothing was
established.

Hence **Say what kind of ask this is**: every ask opens with a literal keyword — `Deciding`,
`Checking`, `Challenging`, `Defending` — because the four differ in what a correct answer looks
like and in whether the user can be wrong at all. Only `Defending` carries a cost for being
wrong, and only `Defending` has an escape hatch, so a probe misread as a challenge gets
answered with a counter-proposal by someone who never sees that the hatch was there. Three
structural rules came with it: one question per ask and it is the last sentence, no rhetorical
questions (a question whose answer you already know is an assertion wearing a question mark),
and asks are anchored to an identifier rather than a list position, because `S-008` cannot
slide by one and "3." can. Plus: asks and their escape hatch ship in one message, and that
outranks the element count — sending questions in prose while the way out went into a separate
tool call is what caused the misalignment.

**Why keywords rather than better advice about clarity.** In that session the structural rules
held — 3–5 elements, a tag on every requirement, the `Gate:` line, criteria-based gate
recommendations. Every prose principle about *delivery* drifted, and two of them could not both
be obeyed: "scannable in about fifteen seconds" against 3–5 elements each carrying a quotation,
a file, a stake and a question, plus a ranking line and a not-probed line. A rule set that
cannot be satisfied is worse than a loose one, because the author silently picks which rule to
break — here it kept the elements and blew the cap, producing exactly the wall of text the rule
existed to prevent. That cap is now **three lines per element**, which is checkable while
writing, and the stopwatch is gone.

**`SPEC.md` is at `Format: 2`, and provenance tags no longer get rewritten.** Fifteen of about
twenty-one decisions in that spec were the user selecting from option sets the gate composed,
one of them marked "(Recommended)" by the harness's own convention — and all fifteen were
tagged `[stated]`, which that file defines as "the user said it". Two changes. Tags now record
origin and **never change**: confirmation adds a `Confirmed:` field instead of promoting
`[assumed]` to `[stated]`, which is what Step 2 previously instructed and which erased the only
record that a requirement had been the gate's invention. And requirements chosen from a
generated menu in answer to an ask-first question are tagged `[selected]`, carrying a `Selected
from:` line with the options offered and which was recommended. Scoped to ask-first questions
deliberately: `SPEC.md` is read by `design`, `code` and `stest`, so every line is a recurring
cost downstream, and the forensic value is entirely in the direction-setting decisions. The
distinction earns its keep at one moment — when a requirement turns out wrong, "they were never
offered the right option" and "they wanted this and were wrong" call for completely different
repairs. That is not hypothetical here: the best rule in that spec, shots per turn = players −
1, came from the user leaving the menu entirely, and none of the four options contained it.

`Format: 2` also drops `Next ID` (bookkeeping that drifted out of step with the requirements it
counted, and derivable by reading the headings), renames the falsifier section to what the spec
is betting on, and closes the vocabulary: the key list and tag list in Step 7 are now the whole
set, and inventing another is a format change. One session invented a `[defended]` tag, an
`[OPEN]` status, four new bullet keys and a second `Acceptance` line.

**Smaller things the run exposed.** Step 3 named the failure that all non-goals end up
gate-authored and had no mechanism against it — all five in that spec were the gate's and none
was defended, so one gate-proposed non-goal is now a mandatory defense target and non-goals are
no longer offered as a closed checklist. The reconcile rule gained the intra-session case: the
user contradicted their own invocation twenty minutes later and no rule covered it (later
statement wins, named before the file is written, recorded as a `DECISION`). The defense is now
said to be a second elicitation, because two of four items came back carrying new requirements
and the spec was rewritten twice after being written. `CHALLENGE`'s outcome field gained its
third shape — *argument defeated, the disputed thing survives on different grounds* — which is
what actually happened and which neither concession could express. `DEBT` now distinguishes
*declined* from *declined with reasons*. Step 5a's "in a subagent" is conditional on the
harness allowing one, because it was forbidden mid-session and the absolute wording forced a
silent deviation. And `TECH_DEBT.md` / `EXPERIMENTS.md` are created by whichever gate first has
content for them, rather than standing empty.

**Two judgment calls worth flagging.** R-002 stays open: one gate of six has been exercised,
the project is not built, and the item's purpose — finding where the method gets abandoned
mid-flow — is barely tested. It carries a progress note instead, including the observation that
the gate did *not* get abandoned, and that the friction was of a kind the invoked/skipped
record it was designed around would never have caught. But R-003 (negative-control the
discussion protocol) is **unblocked ahead of R-002 finishing**, because the thing it was
waiting for was real usage of the protocol and one gate supplied that: one challenge measured
and won, one defeated on its premises. The new "who it hurts is not yours to assert" rule is
now the thing under test, which makes R-003 more urgent, not less.

**What this does not fix.** Nothing validates a written `SPEC.md` against its own format — the
closed vocabulary addresses drift by instruction and cannot detect it. That is R-013, with the
constraint recorded that the gate checking its own output is the pattern §13 rejects. And the
speech-act keywords have been reasoned about but not observed: they were written from one
transcript, and whether a labelled ask actually reads better to the person answering it is
unmeasured, like everything else about this method.

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
