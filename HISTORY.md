# History

> Completed roadmap items and finished passes of work, newest first.

## 2026-08-28

### The defense ask says what it is, and says it in language the reader can parse

**Released 0.12.0.** The second arrival of the same complaint. The `spec` pass produced it,
0.9.0 wrote a rule for it, and it recurred unchanged in `design` — a rule that loses to its own
neighbouring example will keep losing, so this time the examples were changed.

**Every worked defense question in the repo now carries its kind**, in all six gates: `design`,
`spec`, `code`, `tech`, `stest` and `debt`. They were unlabelled while sitting a few dozen lines
below the rule that says to open every ask with its kind as a literal label. Rewriting them also
meant obeying the rules they sit under, which several did not: "Which component would you change
to add a second storage backend? What if the answer is 'three of them'?" is two questions, which
the one-question rule already forbade.

**A readability rule that is checkable rather than a preference**, in `METHODOLOGY.md` §3 and in
the shared block. One clause per sentence, the question as a plain interrogative, and no term
the user has not been taught — *including inside the option descriptions*, which is where
"isomorphic" arrived, parenthetically and untaught, in the run that prompted this.

The diagnosis worth keeping is why a competent gate wrote an unparseable question. §3's only
delivery rule was "three lines per element, hard" plus "say the actionable thing and stop". That
optimises **density**, and density is not simplicity: compressing a quotation, a stake and a
question into three lines is exactly what produces subordinate clauses and rare verbs. The cap
is now stated as a budget rather than a target — an ask under it has spent nothing — and "split
the sentence, do not shorten it" is the operational form.

**The answer path is named first, and named.** In the observed run the picker offered three
exits — teach me, show me, record `DEBT` — and the only route to an actual answer was the
instrument's generic `Other`. A list of three exits above an unlabelled slot reads as four ways
to avoid the question, so a user who could have answered takes an exit, and the `DEBT` entry
then records comprehension debt that was never there. `Answer in my own words` now comes first;
a generic "I'll explain it" is dropped wherever named concept options exist, because it is the
same offer twice and the slot is what the answer path needs.

### The structure diagram takes the shape the code takes

A slice of the OO-vocabulary translation, not the whole of it. `mermaid.md`'s only unconditional
artifact requirement — "**Always:** a class diagram" — is now a **structure diagram**, and a
`flowchart`-over-modules template sits beside the class diagram as the form for modules and
functions, checked against mermaid 11.17.2. The dogfood design drew `class view_for` for
something its own prose calls "a function rather than a class because it holds no state": the
notation asserted what the design denied, because the class diagram was the only template that
existed.

The detector half of that item is untouched and is the more damaging half — `review.md` still
has no non-OO section at all, and it runs on every increment while the smell catalogue runs once
per design. `METHODOLOGY.md` §11 records what is left rather than implying the translation is
done.

### The design gate draws the map before it asks about the parts

**Released 0.11.0.** Four findings from the first `design` dogfood, applied together because
three of them hang off the first and splitting them leaves the skill internally inconsistent
between commits.

**Ordering.** `design` asked six steps' worth of structural questions before Step 5 drew
anything, so every one of them was answered on intuition. Two new steps: **1c draws the map** —
the parts, every component placed under one, and the class and sequence diagrams — and produces
without asking; **1d asks the branch points and only those**, capped at four kinds
(decomposition, the sync/async boundary, persistence, concurrency). Steps 2 through 4c are now
elaboration: produced as candidates and disclosed against the map, silence agreeing, becoming
questions only where the alternatives are real. Step 5 keeps the state diagram and reconciles
the two drawn at 1c. The guard was that this must **move** questions rather than add a stage,
and it does: six ask-producing steps became one, plus six that disclose.

Inserted as 1c and 1d rather than renumbering, so every live citation of `design` step numbers
survives. There is no 1b — the gap is deliberate, and cheaper than a renumber that resolves to
the wrong target somewhere nobody opens.

`METHODOLOGY.md` §2 gains the same split as a new subsection, and the shared rules block gains
a compacted form of it in all six gates, byte-identical. It is doctrine: every gate has both
kinds of decision, and a rule that lived only in `design` would be the divergence the invariant
exists to prevent.

**`DESIGN.md` is at `Format: 2`,** reordered so the document descends rather than climbs —
overview, parts, structure diagram, components nested under their parts, invariants, forbids,
flows. Detail before referent was the same defect in the artifact as in the conversation: the
dogfood design opened on the lowest-altitude element in the system and put the class diagram
sixth of fifteen.

Three sections are new. **`## Parts`** with components nested under them, so a reader answers
"what runs where" from the headings — the dogfood listed seven components flat and nothing said
which ran on the server. **`## Decisions`**, holding what was chosen, what was rejected and why:
the dogfood named seven patterns and every one was a rejection, so a reader learned what it was
not and never what it was, and its central choice — a phase tag with branching, which is a state
machine and not GoF State — was read as State with nothing in the artifact to correct it.
**`## Requirement coverage`**, the missing positive counterpart to `Requirements not addressed
here`; without it nothing catches a requirement silently dropped rather than deliberately
deferred. Plus the two slots whose absence made the dogfood invent `## Phases` and `## Protocol
shape`: a state diagram and a protocol section.

Decisions are also disclosed **live**, as they are made, rather than surfacing only as
`DECISION` entries in `JOURNAL.md` at Step 8 where no reader of `DESIGN.md` finds them. The
disclosure is labelled **`Checking`, not `Deciding`** — the roadmap item specified `Deciding`,
and that contradicts the taxonomy already in the shared block, where `Deciding` promises the
user that whatever they say becomes the artifact. A disclosure promises no such thing: you
already chose and they may object, and its silence means yes, which is `Checking`. The
constraint that makes more disclosure compatible with fewer questions is that a disclosure must
be **answerable by silence** — one that is not is an ask, and the budget on asks applies.

`smells.md`'s pattern-count tell is scoped to patterns a design **adopts**. Counting names would
have made a `## Decisions` section trip the gate for recording its own rejections, which teaches
the author to stop recording them. The half that carries the weight — the pattern name arriving
before the problem it solves — is untouched.

**Grouping conventions in `mermaid.md`, checked rather than assumed.** `namespace` for class
diagrams, `box ... end` for sequence diagrams, `_` as the separator because `:` is already on
the list of characters that swallow a label. Two claims were tested against mermaid 11.17.2 and
one of them was wrong on the first pass. A relation written inside a `namespace` block is a
**parse error**, not a missing arrow — verified both ways. The assertion that grouping needs
mermaid v10 was not verified and is gone; what replaced it is that grouping is newer than the
rest of the file's syntax, so the render check is a real step there. And a one-word `box` title
that is a colour name is eaten as the colour and parses clean, so nothing tells you — mermaid's
own documented workaround is `box transparent Gold`.


### Mermaid label punctuation

A design run emitted `Node on X: does A; then B`; `;` is a statement separator and the block
failed to render. `mermaid.md` blamed *unquoted* labels, but quoting rescues neither `;` nor
`:` there — checked against mermaid 11, along with `#`, which truncates a sequence note
silently. Now one Conventions rule: keep punctuation out of labels, rephrase rather than
escape. `code` redraws diagrams on the reconcile path and never loads that file, so it gets a
pointer to it — the repo's first cross-skill reference.

## 2026-08-24

### Experiment apparatus gets a home, and `.yaait/` stops accepting code

**Released 0.10.0.** The `spec` dogfood wrote its board-density simulation to `.yaait/sim.py`,
beside `SPEC.md` and `JOURNAL.md`, and announced it as "rerunnable". Two separate defects, one
of them doctrinal.

**`.yaait/` is prose only, and nothing said so.** That directory holds the method's record —
files the other gates read and parse — and the layout diagram merely listed them without ever
stating the constraint. A script in there is a category error whatever its lifetime, because
the next gate to list the directory reads it as an artifact. Now stated in the shared block, in
`METHODOLOGY.md` §6, and in the `## yaait` block that `spec` Step 9 installs into the project's
own `CLAUDE.md` — which is the copy that governs sessions never loading this plugin, and
therefore the ones most likely to import from a stray script.

**§6 said "deleted" and meant it, but §6 was written about benchmarks.** All three of its
examples measure something that already exists: an algorithm on data, a library at load, a
format at a size. For those the code under test is the record, the apparatus is scaffolding,
and keeping it is worse than useless — re-running later means running against the
*then-current* code, so old apparatus is stale by construction and its numbers do not compare
with the new ones. But a simulation of a game nobody has built has no code under test. The
apparatus *is* the experiment, its numbers are only comparable with each other, and rebuilding
it from the prose entry produces a **different model** whose output cannot be compared with
what is already recorded. The method had no slot for that, so the session improvised, kept the
file, and never stated the decision.

So the rule now turns on what the experiment measured, which is a fact, rather than on whether
anyone expects to re-run it — that is a forecast, and the rule added in 0.9.0 says not to ask
for those. Measures something that exists: discard the apparatus, run it outside the repository
rather than writing it into the working tree and deleting it after. Models something that does
not exist yet: keep it, in `experiments/` at the project root beside `EXPERIMENTS.md`, with the
experiment's ID in the filename so the link survives somebody rewording the description. Either
way `EXPERIMENTS.md` gains an `Apparatus:` field recording which — `discarded` with a reason,
or the path and the command that re-runs it — so the decision is stated instead of inferred
from whether a file happens to be lying around. That makes it `Format: 2`.

**The form is the project's choice, and the method names properties instead of a tool**, on the
precedent of how §7 handles the code map. A kept apparatus re-runs with one recorded command,
has its parameters as named inputs at the top rather than magic numbers three functions deep,
records its numbers in `EXPERIMENTS.md` rather than only in its own output, carries the date
and environment it ran in, and is imported by nothing in the product. A plain script is the
default — no dependency, any language, and it diffs, which is the entire point of versioning
it. A `.ipynb` notebook is a poor fit for a reason specific to this method: it permits
out-of-order execution, so possessing the notebook does not establish which state produced the
number, and a trustworthy provenance for a number is what `EXPERIMENTS.md` exists for. marimo
is offered as an option where the project is already Python and wants something interactive,
since it is a plain `.py` that diffs and its dataflow execution removes the stale-state problem
— an option, never a requirement, per §11.

**The boundary is enforced rather than wished for.** "Nothing imports from `experiments/`" is
decoration unless something checks it, so it is now a named finding in `code`'s review criteria
— always a finding, never a judgment call, because that directory skipped every gate by design
and an import silently promotes it to production code. It is also in the installed `CLAUDE.md`
block for the same reason as above. This is §5's containment rule applied to a directory
instead of a module.

**Not fixed:** the existing `.yaait/sim.py` in the naval-battle project is not moved by any of
this — the plugin cannot reach into a project on another machine. That is a manual step, and it
is the first thing to do there before `design` runs.

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
