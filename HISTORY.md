# History

> Completed roadmap items and finished passes of work, newest first.

## 2026-08-31

### The four-line cap said three lines six lines further down

**Released 0.20.1**, because an installed 0.20.0 copy carries a rule set that cannot be
satisfied — the same defect `f74eb81` was written to remove, surviving in the paragraph below
the one it edited.

`f74eb81` raised the delivery cap to *"Four lines per stop, hard"* and enumerated the four
things a stop is made of. Six lines below it, in the same `### Deliver it without a wall of
text` section, the closing clause of the one-clause-per-sentence bullet still read *"Three lines
is a budget, not a target"*. The bullet immediately above already states what that costs: a rule
set that cannot be satisfied makes the author pick which rule to break silently, and the cap is
the one that goes. Found by reading Step 6 before testing it — a run that overran would have
been uninterpretable, because nobody could say whether the model broke the cap or followed the
other sentence.

Fixed in all six gates in one commit; the shared rules block stays byte-identical.

**Also, the marketplace listing still described the method 0.20.0 replaced.** 0.20.0 rewrote
`plugin.json`'s description and left `.claude-plugin/marketplace.json` alone, so the blurb
anyone reads before installing said yaait *"puts the gate on the person, not the artifact"* and
that *"every artifact is defended or logged as undefended"* — the exact framing, and the exact
word, that release removed. It now mirrors `plugin.json`: every decision the machine made goes
in front of a human, and nothing passes until someone has ruled on it or the record says nobody
did. Two descriptions exist for the same plugin and only one of them was on anybody's checklist.

### The gate stops examining the user and starts showing them the decisions

**Released 0.20.0**, because an installed older copy behaves differently in every gate: it
labels asks `Defending`, runs the walk-through and the questions as two separate rounds, and
writes `DEBT` entries that record a named person's wrong answer.

**Third arrival of the same complaint, and the first structural fix.** *"i still feel
uncomfortable under test with the questions... it is not only a writing style but a
metholodology of yaait issue"* — given unprompted as the invocation of `yaait:tech` on the naval
TTB, and recorded verbatim in that project's `FEEDBACK.md`. 0.12.0 answered the same complaint
with a label on every ask; 0.18.0 answered it by handing the floor over first and preferring the
judgment form. Both were wording changes and both were followed by the complaint coming back.

**Why the tour did not fix it.** 0.18.0 added the walk-through *before* the defense rather than
*instead of* it. In the naval run the same four items were served twice: once as tour prose,
then again as a picker of four asks each opening with the word **Defending**, under the line
"answer the first one if you answer only one". The walk-through became the material to be
studied before the test. `METHODOLOGY.md` said so itself — *"the stops you toured in Step 5a are
the elements; this step is how the asks are phrased"* — which is a walk-through followed by a
test on the walk-through, written down as the design.

**Four causes, none of them writing style.**

- `Defending` was the one ask kind whose defining property was *the user can be wrong*. §3's own
  table said so. Four of them arriving together is a test paper.
- The outcomes graded the person. *Answered wrongly* wrote a `DEBT` entry into the project
  journal naming a human's wrong answer — a record about a person in a file about code.
- **Every worked example in all six gates was still in the recall form the doctrine tells you to
  avoid**: *"Which line stops the board being left half-updated?"*, *"What breaks if someone runs
  `pip install -U`?"*. 0.18.0 added the judgment reframe and rewrote no examples. `HISTORY.md`'s
  own 0.12.0 entry had already named this: *"a rule that loses to its own neighbouring example
  will keep losing."* It lost again, to the same mechanism, two releases later.
- §13 says the author is not the auditor, and the gate that wrote the artifact was auditing the
  human's understanding of it.

**What replaced it.** One step rather than two: the stops *are* the asks, and no element is
walked through and then asked about again. `Defending` became **`Reviewing`** — you already
chose, the artifact already says so, you are showing the work so it can be overruled — and no
ask kind now carries a cost to the user for being wrong. Each stop is four things: what this
part does, why this shape and not the obvious alternative, **what it costs if it is wrong**
stated outright, and the call put to the user. The last exit option stopped reading *record as
debt and move on* and now reads *keep what you wrote — your call*, because the old wording asked
the user to volunteer that they were the source of a debt they did not create.

**The unbluffability is unchanged, which is the part that had to survive.** §3's finding that
self-assessment does not work is kept intact. A stop still never closes with "any questions?"
Someone who does not have the model cannot choose between the options either, and will say so or
ask — so the same signal arrives by a route that costs nothing to admit, and the fact the recall
question withheld is handed over instead, which is the disclosure the round exists for.

**The record survives, re-based.** `DEBT` no longer means *a person did not understand this*. It
means *the gate decided this, put it to a human, and no human ruled on it* — which is more use
to whoever reads the journal in a year, because it says whose decision it was. `APPROVAL` now
carries the user's own reason rather than a mark. The *answered wrongly* outcome is deleted
outright: a reason that does not match the mechanism gets corrected in the moment, the way a
colleague would, and nothing is written about the person. **This supersedes part of R-009**,
which asked for that outcome to be added — R-009 now says not to reinstate it, and records that
its A1 and A3 findings were addressed here instead.

**Evidence that deleting it lost nothing.** The naval run's own `FEEDBACK.md` records the gate
unable to tell whether *"processes don't share memory"* was a misread question or a misread
mechanism. The outcome that existed to catch exactly that case did not catch it, and the exam
framing is what made correcting him awkward.

**Two additions that put the gate on the hook.** Every walk-through now includes whatever the
gate is least sure of, said to be there for that reason, and closes by asking the user what they
want to look at. In the naval run all three of the gate's errors — a whole slot never surveyed,
a mechanism documented in a table and never written as a sentence, and one ask that belonged to
a different gate — were found by the user asking how something worked. None of the gate's own
chosen stops found any of them.

**A plain-language rule, and a sweep to go with it.** *"no methaphors like this please, it turns
the text hard to understand for me, non-native English speakers. Speak straight, explain
yourself."* The delivery rules now forbid metaphor, idiom and figure of speech, with the named
failure: a reader whose first language is not English spends their effort decoding the sentence
instead of judging the artifact, and the entry then records an unruled decision when what
happened is an unparseable question. It extends the existing rule about untaught words —
"isomorphic" — from single words to sentences. Because a rule that contradicts its neighbours
loses, every live use of "load-bearing", "on trial", "sycophancy with the sign flipped" and "the
reflex incantation" was removed from the shipped prose in the same pass; the only occurrences
left are inside the rule, quoting what not to write.

**`code` Step 1 was rebuilt rather than deleted.** *Defend the code you are about to modify* is
now *Understand the code you are about to modify*, and it is split by who holds the answer: the
gate reads the code and states what it does as a `Checking` ask, and asks the user only for what
the code cannot say — why it is this way, what broke once, who depends on it. The rule itself is
untouched, because it is the one place where the user genuinely holds something the gate does
not. Asking them to recite behaviour the gate could have read was the examination; asking about
intent and history is not.

**`MANIFESTO.md` was rewritten too, on the argument that leaving it would re-derive the exam.**
Principle 3 was *"Defending is not reciting. It is answering a question you were not prepared
for"* and is now about what gets examined being the decision rather than the person. The
accountability clause said the human must be able to defend the commit *"under questioning"*; it
now says they must be able to defend it to a colleague, a reviewer, or whoever is reading it
during an incident — a statement about the condition the human has to be in, not about a test a
machine administers. Principle 4 keeps its meaning and loses the word "undefended".

**Reached:** `METHODOLOGY.md` §1, §2, §3 (rewritten end to end), §7, §8 and §13; the shared
rules block in all six gates, byte-identical; the review step in all six gates, merged from two
into one; `code` Step 1; `MANIFESTO.md`; `COMPARISON.md`; `README.md`; `CLAUDE.md`;
`plugin.json`'s description, which claimed yaait "gates the person rather than the artifact";
and the three reference files that named the old machinery.

**Exercised headless on the naval `TECH.md`, and it found one defect.** A `claude -p` run of
Step 6 alone, against the existing artifact, produced a round with no `Defending`, the keyword
taught on first use, one message rather than two, every stop stating what it costs and ending in
a call, the least-certain stop present and labelled as such, and the close handing the asking
back. It broke one rule at every stop: the delivery cap still said **three lines** and listed
three of the four things a stop now carries. Raised to four, one line per thing. This is the
second time that bullet's own warning — a rule set that cannot be satisfied makes the author
break the cap silently — has described the cap itself.

**Not done, and worth saying.** Nobody has run a gate under these rules with a human in front of
it. A headless run has no picker and no person, so it measures the shape of the message and
nothing about how it lands. The only test that counts is whether the next `yaait:tech` or
`yaait:design` still reads as an exam, and that has to be asked rather than inferred. `~/CLAUDE.md` in the user's home
directory still carries the old shape — *"ask a concrete question about the part most likely to
be wrong"* — and was left alone because it is outside this repository.


## 2026-08-30

### `tech` moves in front of `design`, and stops recalling a shortlist before it verifies one

**Released 0.19.0**, because an installed 0.18.0 copy runs a different sequence: it will run
`design` with no `TECH.md` and produce a decomposition against a stack nobody named, and its
`spec` recommends the two gates in the wrong order.

**The order changed, and the argument came from `design`'s own text.** `design` Step 1d caps
its branch points at four and calls them the expensive-to-reverse ones — decomposition into
parts, the sync/async boundary, the persistence model, the concurrency model. The stack largely
settles all four: serverless answers persistence and concurrency before any component is drawn,
`asyncio` and goroutines make different questions out of "async boundary", Prefect and Airflow
decompose the same pipeline differently. So the old order had `design` settling those four
against an unnamed stack and then meeting the stack afterwards. `METHODOLOGY.md` §11 was the
second reason: it declares the method paradigm-neutral and its catalogues a dialect, and a
dialect cannot be translated into a paradigm that has not been chosen.

**Greenfield `design` now stops without a `TECH.md`**, the way it already stopped without a
`SPEC.md`. Maintenance is exempt — the stack is on disk. A user may proceed anyway, but must
name the stack being designed against and take a `DECISION` entry, because a design written
silently against an assumed stack is indistinguishable from one written with it known.

**The guard that had to ship with it.** Running `tech` first converts decisions into things
that *look* inherited, and §9 holds nobody accountable for constraints — so a broker picked off
a traffic number would arrive in `DESIGN.md` as an inevitability, laundering exactly the
speculative structure `design` Step 4 exists to catch. The rule is now explicit in three
places: a stack choice made before the design exists is a decision with a falsifier, and a
design firing one is the reconcile rule working. `DESIGN.md` gained `## Constraints on the
stack` (Format 3) and `TECH.md` gained `## Deferred to design` (Format 2) so that traffic has a
named place to land in both directions — it previously existed and ran through a component's
prose, where the next `tech` run would not find it.

**Verifying a shortlist cannot fix the shortlist.** The old Step 2 checked that the
dependencies the model was about to name were current. It could not surface the option that did
not exist at training time, and everything on the recalled list came back labelled `verified` —
so a stale list ended up better dressed than an honest guess. New **Step 2** surveys the slot
from live sources before any option reaches the user, for slots that shape the design or sit
near a one-way door; cheap reversible slots are verified and not surveyed, and the two claims
are labelled differently because they answer different questions. Slots the user already filled
are surveyed at the same threshold, and their pick stands unless the survey produces a failure
mode with a cost — "there is a newer thing" explicitly is not one. **The questions come after
the survey, not before**, because the survey is what names the axis that discriminates.

**Options are presented as an education (Step 2b).** Pros and cons in this TTB's units, a
recommendation stated as one with its reasoning, and a named offer to explain any of it before
choosing. The provenance mechanism is `spec`'s, reused rather than reinvented: a choice picked
off a menu this gate wrote is `[selected]`, recorded in a `Selected from` field — otherwise
`tech` launders its own inventions into the record as the user's decisions, which is the single
thing `spec` was built to stop, defeated by moving it one gate over.

**Proficiency became an input, not a preference (Step 1a).** Graded per ecosystem, taken at
face value, never tested. The reason it is not just another preference: `yaait:code` will not
pass an increment until the user can say what the code it touches does, so an ecosystem they
are a novice in degrades the method's load-bearing gate on every increment — and it degrades
silently, surfacing as a run of `DEBT` entries about individual functions rather than as a
stack decision anyone can point at. It prices a choice rather than vetoing one, and it lives in
its own `## Proficiency` section rather than under `## Constraints`, since §9 holds nobody
accountable for constraints and this is something the user said about themselves.

**One collision, caught in the same pass.** `spec` Step 10 may record `tech` as *not
warranted* when the stack is fully constrained — and a hard stop in `design` would then demand
a gate the upstream artifact had already declined on stated criteria, every run. `design`
Step 0 now checks `Gates recommended` before stopping and reads the stack from `SPEC.md`'s
`Constraints` section in that case. Where those constraints turn out not to fix the language,
runtime and deployment target, that is the reconcile rule firing on the spec, and `tech` is
offered on that basis rather than on a missing file.

**Five edits were reverted out of this change for failing one test: did the reorder make the
old text false?** Four of them did not, and one of those had also introduced an error. The
`smells.md` "Hallucinated API" tell was rewritten into a `TECH.md` cross-check — not required,
at the wrong altitude for a file whose smells are properties of a dependency graph, and wrong
for a Maintenance TTB, where the absence of `TECH.md` does not make an external name recalled.
`plugin.json`'s description had its gate list reordered, which is an enumeration rather than an
order claim, in a file 0.18.0 had deliberately left alone. `code` Step 0 and `spec` Step 10 each
gained a new authored rule beside their forced order flip. Two of the five turned out to be real
defects and were filed rather than folded in: **R-028** — the independent checker is never given
`TECH.md`, a gap that predates the reorder and that tech-first makes systematic — and **R-029** —
`spec`'s design criterion is a component count `tech` can change, which can leave `Gates
recommended` asserting something `code` Step 0 then reads as a skip.

**Not measured.** The reorder shipped argued, not measured; **R-027** was filed to run the
naval TTB under the new order against `DESIGN-naval.md` as the control, and to watch whether
the survey step becomes the wall of text that gets a gate abandoned.

## 2026-08-29

### The defense stops being an exam: the user reviews the artifact before it reviews them

**Released 0.18.0**, because every gate now behaves differently for an installed copy.

**What went wrong.** A live `design` run asked, through the picker, *"`I-12` — the client draws
ships from offsets the server sent. What goes wrong the first time a hardcoded client copy
differs from the server's?"* The user could not tell whether they were being tested, consulted,
or asked for feedback — which is verbatim the failure §3 predicts for an ask whose kind is not
declared. Two causes, and the second was the larger one.

**The keyword evaporated at the instrument.** The rule to open every ask with `Deciding` /
`Checking` / `Challenging` / `Defending` was stated in three places, including five worked
examples in `design` Step 8, and still did not ship. A picker header holds about a dozen
characters and cannot carry both the kind and the identifier; the run kept the identifier. No
document had ever said which field carries the label. It now says: the front of the question
text, never the header. And the four keywords are taught on first use, because they are terms of
art out of `METHODOLOGY.md` that no user has read — the author of this method used "challenge" to
mean the defense during the session that produced this change.

**The larger cause was the format.** *"It feels really awful to be put to the test by a
machine."* The question arrived cold, and all four options were about the user's deficiency
rather than about the artifact. So §3 is now **The review**, and it is two passes: the gate hands
the floor over first — questions, comments, objections — and only then tours the parts that
review did not reach. Each stop is what this part does, why this shape and not the obvious
alternative, and one ask in the **judgment** form (*"I think this is the fragile line here, do you
agree?"*) rather than the recall form. Both are unbluffable. Only one puts the user on trial
instead of the artifact.

**The epistemics are unchanged and deliberately so.** §3's finding that self-assessment does not
work is kept intact, and the defense still always runs. "No questions" cannot distinguish an
expert from someone who nodded along, and a tour that ends in "any questions?" is the rate-your-
own-understanding instrument §3 exists to replace. What the handover buys is selection input and
a record, never an exemption — and what the discussion merely *touched* does not count as
covered, or one superficial question immunises the riskiest thing in the artifact.

**Simulated on the naval design before a line was edited, and the simulation earned it.** The
reviewer found a hole in the structure diagrams — no box for the type crossing the network, both
projection methods missing from the class that owned them, the whole client read path undrawn —
that all three of the model's chosen stops had walked past. An author does not ask questions
about what they failed to draw. `design`'s tour step now names the diagrams as a candidate stop
for exactly that reason.

**And learning stops being the failure branch.** §3 listed `Explain <concept>` among the
"exits", one line under a heading that called the whole list "the way out", while §8 had always
said the opposite — `TAUGHT` is filed apart from `DEBT` precisely because asking to be taught is
the behaviour the method wants. §3 now names two real paths (answer, or be taught) and two exits
(show me, record as debt), the tour steps offer the concepts at every stop rather than as a
fallback, and the README says it outright. The contradiction had stood in two sections of the
same document, and the section that was wrong is the one users meet.

**Win and loss come out of the vocabulary.** A `CHALLENGE` entry records the disputed point, both
positions, and what was agreed and why; there is no outcome field and no winner. It also says
which kind of resolution it was — a finding, a clarification, or a changed position — because the
simulation produced four items filed as challenges of which exactly one was a disagreement, and
scoring them erased that. The anti-sycophancy instruction underneath was **kept and reworded, not
deleted**: the user's argument can change the outcome, and when it does, say what you had wrong.
Removing the scoreboard while losing that would have traded one defect for a worse one.

**Scope.** The handover-and-tour step is `spec` 7a, `design` 7c, `tech` 5a, `code` 5a — four
gates, not six. `stest` already makes the user watch the critical path themselves and `debt`
produces an argument rather than something they will maintain, and both already ask judgment
questions. So this is not a shared-block rule; the block carries only the keyword placement, the
judgment reframe, the new `Challenged` outcome and the vocabulary strike, identically in all six.

**What is not established.** Whether any of this reads better to the person answering. One user,
one session, no measurement — the same standing caveat every other claim about this method
carries. The negative control to run first is to say nothing at the handover: the tour must still
produce an ask you can be wrong about, or the reframe has cost the unknown-unknown detector.

**Also filed:** R-026, that a second TTB in one project silently overwrites the first one's
`SPEC.md`.

## 2026-08-28

### Runs are stable; models are not — and two roadmap items were built on a mis-measurement

**Three `design` runs at one commit** (`9f9c434`), `claude-opus-5`, same SPEC, same prompt, graded
mechanically. A fourth died on the box's session limit.

**Result 1 — no run-to-run variance.** All three identical on all five rules, 3 of 3 diagrams
rendering, six states built in each. Each also self-reported `Produced by: Claude Opus 5
(claude-opus-5)`, matching the transcript. **So n=1 is usable evidence** — the opposite of what
this experiment was launched to confirm.

**Result 2 — the flip that prompted the experiment was a measurement artifact, and so was the
finding underneath it.** Re-grading with a check that reads the document whitespace-collapsed
rather than line by line, `mnb-opus/DESIGN.md` line 194 reads *"**Owns:** the `phase`, a term this
design coins, ranging over `WAITING`, `PLACEMENT`, `FIRING` and `ENDED`"*. That is a pass. It was
recorded as a FAIL — in `ROADMAP.md`, in this file, and in commit `847b4da` — because the sentence
wrapped across two source lines. The same re-grade reproduces every other recorded result for that
file exactly, so it is one wrong cell rather than a new method.

**Corrected, both disputed rules are model-dependence results wearing mechanism clothing:**

| | Opus | everything else |
|---|---|---|
| coined term states its range | **4 of 4** | 0 of 2 |
| a `## Decisions` entry names a pattern | **4 of 4** | 0 of 1 |

R-021's observation was accurate about its own artifact — `DESIGN-rerun.md` really does have eight
entries and no pattern name — but its title said *ever*, and a counter-example was already on disk
when it was filed: `mnb-opus` carries *"### `phase` as a tagged field on `Match`, not the State
pattern"*. Neither rule needed the machinery being planned for it. R-020 would have specified a
`GLOSSARY.md` to repair a rule that has never failed on Opus; R-021 would have widened Step 1d's
disclosure scope to recover an entry that four runs produce unprompted.

**The lesson is about the ruler, not the rule.** Two independent mechanical checks of the same rule
were both wrong, in opposite directions — an earlier grep gave a false PASS, a per-line window gave
a false FAIL. Both reached `ROADMAP.md` as findings and one shaped a release. The measurement is
apparatus and is being re-derived every session; **R-025** files where it should live, against this
repo's "prose all the way down" rule and yaait's own `experiments/` convention, which cannot both
hold here.

R-022 is answered for `design` and no longer urgent. What remains of it is the model comparison at
n>1 — every Sonnet figure is still n=1, headless, self-answering the defense.

### Run `design` on the strongest model you have, and record which one ran — 0.17.2

**The user's call**, on an argument that does not need the measurement to be conclusive: `code`
traces every increment back to `DESIGN.md`, so a wrong decomposition costs a reconcile per
increment that inherits it. A design defect is the most expensive kind yaait can emit, so it is
where compute is worth spending. `README.md` now says so under Install.

Two qualifications kept in the text rather than smoothed over. **Effort level is unmeasured** — no
run has varied it, and the Sonnet run that obeyed none of the five rules was already at high
effort, so raising it is a recommendation and is labelled one. And **the other gates are not
exempt, they are unmeasured**; `design` is simply where anyone has looked.

**`DESIGN.md` gains `Produced by:`** — the model and, if visible, the effort level. A record, not
a gate: advice in a README does nothing for the population that gets a degraded design, and a
design that turns out wrong is read months later by someone who otherwise cannot tell whether the
method failed or the model did. `Format: 2` stands, on the precedent already set here — the field
is additive and nothing validates it.

**R-022 is narrowed to what is left.** Its product half is answered, so it now owns one question:
*do repeated runs of the same commit, model, project and prompt agree with each other?* Every
doctrine change in this repo is justified by a measurement, almost always n=1, and prose tuned
against a metric with an unknown noise floor is prose fitted to noise — 0.14.0 being the worked
example. The item also now states its own evidence honestly: of the 5-of-5 run, the namespace and
semicolon passes are plausibly the new `mmdc` check, the spec's-word pass was directly targeted by
0.16.0, and the participant rule already passed before it. **Only the coined-term rule is
unexplained**, so the case for variance rests on one rule flipping on one run.

And the answer if runs do disagree is recorded there too, because it is the structural one:
**move what can be mechanised out of prose.** The namespace rule went FAIL/FAIL/PASS across three
runs and is now caught by `mmdc` every time, at zero variance. Step 7b is the existence proof.

### 0.16.0's three edits verified at last, and the gate installed software nobody asked for — 0.17.1

One `design` run on a copy of the naval SPEC, `/home/dfg/src/mnb-verify`, plugin at 0.17.0.
**Model confirmed from the transcript, not the flag: 64 of 64 `"model":"claude-opus-5"`.**

**0.16.0's three claims, unverified since it shipped, all hold.**

| claim | result |
|---|---|
| the namespace remedy is imperative | `namespace Client side`, `namespace Server side` |
| renaming the component is forbidden | 0 × `Hub`, 0 × `ClientApp`; `class Server` and `class Client` intact |
| the spec's word reaches private fields | `-by_join_code` on a private field, `find(join_code)` beside it |

**The rule scoreboard, against the three runs already measured.** Best previous result was 2 pass,
1 partial, 2 fail.

| rule | 0.13.0 | Sonnet 5 | Opus 5 @0.16.0-pre | **Opus 5 @0.17.0** |
|---|---|---|---|---|
| namespace must not share a class name | FAIL | FAIL | PASS | **PASS** |
| one shape per kind of participant | FAIL | FAIL | PASS | **PASS** |
| keep the spec's word | FAIL | FAIL | PARTIAL | **PASS** |
| coined term states its range | FAIL | FAIL | FAIL | **PASS** |
| no semicolons in diagram labels | PASS | FAIL ×1 | FAIL ×6 | **PASS** |
| blocks that render | 2 of 3 | 1 of 3 | 2 of 3 | **3 of 3** |

Checked here independently, not taken from the run's own summary: `mmdc` exit 0, empty stderr,
three charts, and the state diagram built **six states — exactly the six written**, where the
previous Opus design built 21 for a design with six.

**The coined-term result is the one that changes a plan.** 0.16.0 deliberately did *not* touch
that rule, on the argument that three failures meant the mechanism was wrong and R-020 should
rethink where the definition belongs. It passed on the fourth run with no rule change. So 3 of 4,
not 3 of 3, and R-020 now says re-measure before specifying a `GLOSSARY.md` to repair a rule that
may work. Caveat recorded there too: n=1, and not a clean experiment.

**The finding that cost 0.17.1.** The box had no `mmdc`, which was the point — the run was
supposed to exercise the absent-tool path. It did not. The gate created `/tmp/mnb-mmdc`, ran
`npm i @mermaid-js/mermaid-cli`, used `./node_modules/.bin/mmdc`, and reported the check as
passing. Nobody agreed to put those packages on that disk, and the documented branch went untested
while appearing tested. The user's position on the dependency is explicit — a missing tool means
the design ships unchecked and that is the owner's risk — and installing it for them is not that
choice being honoured. Step 7b and `mermaid.md` now forbid self-installing, `npx` included, and
name the observed case. **That prohibition is prose aimed at a model that already improvised
around this exact step, so it is unverified: filed as R-024**, with the note that a real test needs
a machine where `npx` cannot reach `mermaid-cli` either.

### The design gate now runs mermaid over its own diagrams — R-019 closed, 0.17.0

`design` gained **Step 7b**: run `@mermaid-js/mermaid-cli` over `DESIGN.md`, read the exit code.
Optional — absent, the step names the install, records in `DESIGN.md` that the diagrams were not
machine-checked, and closes. It never blocks.

**Measured before anything was written**, `mmdc` 11.16.0:

| in the file | mmdc |
|---|---|
| any hard parse error | exit 1, message and line |
| `namespace Server` holding `class Server` | exit 1, `would create a cycle` |
| `;` in a **state transition** label | **exit 0, stderr empty** |
| one-word colour-name `box` title | **exit 0, stderr empty** |
| well-formed file | exit 0, one tick per block |

**The finding that shaped the doctrine.** `mnb-opus/DESIGN.md` carried both kinds of `;` at once —
one in a sequence message, five in state transitions. `mmdc` exits 1 and names the sequence one.
Changing that single `;` to a comma makes it exit 0 with empty stderr and three green ticks, while
the state diagram it just approved still holds **21 states for a design with six**. So the obvious
workflow — fix what it reported, re-run, see green, ship — produces exactly the corrupted diagram
the check was added to prevent. Both files now say an error naming one `;` is not a census of them.

**Rejected.** `merman-cli`, on the user's ground that a from-scratch reimplementation can disagree
with the renderer that actually matters. `mermaider` and the MCP validators wrap parse;
`mermaid-lint`'s eight semantic rules have no orphan-node rule; all pass the acceptance case.

**Four `mmdc` behaviours are recorded** because each otherwise costs a round: one error per run and
not necessarily the first; a failing run writes no output at all; ticks come back in render order,
not document order; and **stdout has to be redirected too** — `mmdc` reads its colour setting from
stdout and applies it to stderr, which neither `NO_COLOR=1` nor `--quiet` overrides. That last one
had two people running "the same" command get different files and briefly disagree about what the
tool detects; it cost most of the session and it is why it is written down.

**The "no toolchain" argument was kept and its subject made explicit.** It is about the *reader*,
who still installs nothing to see a design on GitHub. The *author* installing a checker is a
different cost. Conflating them is how a diagram check was once declined on that file's own
argument.

**What did not happen, and it is the second half of the job.** 0.16.0's three edits are **still
unverified**. The run was launched and died immediately — `You've hit your session limit` on the
test box — producing nothing. Filed as **R-024** with the staged copy and the re-launch recipe, so
it is not lost with R-019. **0.17.0 therefore ships carrying 0.16.0's unverified edits**, exactly
as 0.16.0 did, and for a different reason.

Also filed **R-023**: one place that installs what yaait can use. Step 7b carries an install line
in its prose; the second gate that wants a tool will carry its own and the two will drift.

### A diagram constraint renamed the design's components, which is the failure it was meant to prevent

**Released 0.16.0, and the three changes in it are UNVERIFIED** — no run confirms them. Verification
is deliberately deferred to the tooling session R-019 describes, because that tool is the verifier
and re-running the gate twice to check the same edits would pay for the same evidence twice.

**What measurement established, before the edits.** Three runs of `design` on the naval project,
checked mechanically rather than by eye, one plugin commit throughout. The `mermaid.md` rules
added in 0.14.0 **worked on Opus** — the structure diagram renders and the sequence diagram draws
one shape per kind of participant — and **failed completely on Sonnet 5 at high effort**, which
is now R-022. So "prose rules do not move this gate" was wrong, and the honest split is narrower:
rules about *what to draw* landed, rules about *how to phrase text* did not.

**The bug this release fixes is one 0.14.0 introduced.** The namespace rule stated a constraint —
a namespace must not share a class name — and then prescribed a remedy that cannot be followed:
"name the namespace for the part, not for the component", when the part **is** called `server`.
Opus obeyed the constraint, discarded the unfollowable remedy, and cleared the collision the other
way: it renamed the components, `Server` to `Hub` and `Client` to `ClientApp`. `SPEC.md` says
*server* nine times, including S-008. So a diagram constraint silently dropped a spec term and
substituted a coinage the design never explains — the same failure as abbreviating `join code` to
`code`, reached from the opposite direction, and harder to catch because the new name looks
deliberate. The remedy is now imperative (rename the namespace, append ` side`, leave every class
alone), the component rename is named as forbidden with the observed case attached, and Step 2
carries the reciprocal: a notation constraint never renames anything the design is about.

**The spec's-word rule now covers private fields.** The same Opus run wrote `find(join_code)`
correctly and kept `-by_code` on the same class in the same diagram. A private name is read by
exactly the people who have to change the code, so it is the last place the spec's word should be
dropped.

**What was deliberately not touched.** The coined-term rule has now failed in all three runs
including Opus — `Match` still owns "the phase" with no range beside it. Three failures on one
mechanism is a reason to rethink where that definition belongs, not to reword the same line a
second time. And the label-punctuation rule is left alone because prose cannot carry it: it failed
on both models and **got worse on the better one**, since a stronger model writes richer labels and
every `;` is locally correct English. Its cost is now measured — an Opus state diagram that parses
clean and renders clean, which mermaid builds as 21 states of which 15 are garbage, with five
transition labels losing everything after the semicolon. That measurement is R-019's acceptance
test, and it disqualifies every candidate tool that only wraps parse or render.

### A design that renames the spec's terms hands the reader an undefined word

**Released 0.15.0.** The near half of R-020; the item survives as the `GLOSSARY.md` question
alone. The staging was load-bearing rather than tidy-minded, because the two complaints that
produced this item have **different causes and different fixes**, and a glossary only answers one
of them.

**`find(code)`.** The naval `DESIGN.md` gave `MatchRegistry` a `-by_code` field and a
`find(code)` operation, and the user needed several passes to work out that `code` meant the code
you type to join a match. `SPEC.md` S-002 defines it — as a *join code*, with an acceptance
criterion. So nothing upstream was missing: the design shortened a term that had already been
defined, and shortening is what made it undefined, since a reader cannot look up a word that is
not the word the definition uses. A `GLOSSARY.md` would have held "join code" and the design would
still have written `find(code)`. The rule is therefore that a term `SPEC.md` defines keeps the
spec's name, and it is checkable rather than aesthetic: for every name in the design, either the
spec uses that exact word, or the design says what it means.

**`phase`.** The opposite case, and the user still could not say what it was. `phase` is not in
the spec; the design coined it, along with the four values it ranges over. It appears as
`Match -phase` in the structure diagram and is not pinned down until the state diagram some 240
lines later — the reader meets it first as a bare word and second as a definition. The fix is to
make the owning component state the range on its `Owns:` line, which moves the definition into the
section immediately after the map instead of adding noise to the diagram, and keeps `mermaid.md`'s
"show only what the design decides" intact.

**The template says it, not only the prose.** The `Owns:` placeholder now reads "a term coined
here states what it ranges over". That is R-013's own hypothesis being *applied* rather than
retested: a template inline at the point of writing gets followed, and a format that has to be
recalled from elsewhere gets invented.

**What this deliberately does not do.** It changes nothing in `spec`. Whether the definitions
should live in an artifact of their own is the question R-020 still holds, and it is not cheap —
a seventh artifact reaches the `## Where things go` block, which is byte-identical across all six
gates, plus `METHODOLOGY.md` §8 and every gate's Step 0. Now that the naming rule exists, that
discussion can be about what is actually left over rather than about the whole problem.

### A diagram that parses is not a diagram that renders

**Released 0.14.0.** Two conventions added to `mermaid.md`, both found by the user reading the
`design` gate's output rather than by anything in the gate noticing.

**The structure diagram did not render, and nothing said so.** The naval re-run nested components
under parts and emitted `namespace Server { class Server ... }` and
`namespace Client { class Client ... }`. That **parses clean** — `mermaid.parse` accepts it — and
fails at render, because a namespace becomes a cluster and a class becomes a node in the same
graph: `Setting Server as parent of Server would create a cycle`, and the block comes out as text.
The user hit it and fixed it by renaming the namespaces to `NServer` and `NClient`. Checked
against mermaid 11.17.2, along with the two facts the rule needs: a bare space in a namespace name
is legal, so `namespace Server side` is the readable fix, and quoting it — `namespace "Server
side"` — is a parse error, which is where the instinct leads. So the rule is to **name the
namespace for the part, not for the component**, and it is stated with where it bites: a part is
usually named after the component that defines it, so this is the common shape rather than a
curiosity, and it only appeared once `DESIGN.md` started nesting components under parts in 0.11.0.

**One shape per kind of participant.** The same run drew `actor Ana` beside
`participant Others as Beto, Caro, Dani` — a stick figure next to a box, for four people who are
all players. `actor` and `participant` differ visually, so a reader takes the difference as a
difference in kind, and here there was none. An aggregated lifeline keeps the shape of what it
aggregates: `actor Others as Beto, Caro, Dani` parses and renders.

**What this does not fix, and it is the more interesting half.** Three of the failures now
documented in that file — the colour-named `box` title, this collision, and the stranded state
transition from `1c61b90` — raise **no parse error at all**. `mermaid.md`'s "Checking that it
renders" section still opened on parse failures, so it now says plainly that "it parsed" is not
the check. Whether the gate should mechanically verify its own diagrams is filed as **R-019**,
with the crux recorded so it is not re-derived: a validator built on `mermaid.parse` would have
passed the exact diagram the user could not render, and `mermaid.md`'s own "no jar, no server, no
toolchain" argument is a constraint that answer has to satisfy rather than ignore.

**Two further findings from the same read were filed rather than fixed.** **R-020** — the design
wrote `find(code)` for a term `SPEC.md` S-002 defines as a *join* code, and coined `phase` in the
structure diagram without defining it until 240 lines later. Those are two different failures: a
glossary would have held the first term and the design would still have abbreviated it, which is
why the naming rule is staged ahead of the `GLOSSARY.md` question. **R-021** — `## Decisions`
produced eight entries and named no pattern, though `Match`'s `-phase` field with dispatch is an
FSM chosen over the State pattern. Filed as an investigation, not a fix: the section is written
retrospectively from what Step 1 disclosed, and Step 1d caps disclosure at four branch points that
do not include pattern choices, so the cause may not be in the section at all.

### The first fix for `class view_for` was aimed at the wrong thing

**Released 0.13.0.** Found by running the re-fixed `design` gate on the naval battle project
rather than by re-reading the change. 0.12.0 made the structure diagram's form follow the
project's paradigm — `classDiagram` for OO, `flowchart` for not-OO. The re-run still emitted
`class view_for`, and correctly so under that rule: the design has five classes plus one module
and one free function, so `classDiagram` was right and nothing in the notation could say "this
box is not a class".

The defect was a property of the **unit**, not of the project. Fixed with stereotype
annotations — `<<module>>`, `<<function>>` — verified to parse inside a `namespace` against
mermaid 11.17.2, and `mermaid.md` now says plainly that reaching for the whole-diagram
`flowchart` because two of seven units are not classes throws away notation that was working.

**What the re-run confirmed, on a copy of the project so the original evidence survived.** The
document came out `Format: 2`, ordered overview → parts → structure → components, with the
components nested under `Shared` / `Server` / `Client` and `geometry` under `Shared` as a
first-class part. The class diagram used `namespace` with every relation outside the blocks, and
all three diagrams parse. `## Decisions` came out with eight entries, `## Requirement coverage`
with a row per requirement, and the state diagram and the protocol section filled their template
slots instead of being invented — the `## Phases` heading is now the `## <Lifecycle name>` slot
being used, not a section with nowhere else to go. Step 0's new instruction fired: a `DECISION`
entry records the raise from `Format: 1` to `Format: 2`.

**What the run could not test, and this is worth stating rather than implying coverage.** The
run was headless, so there was no picker and no options list: R-014's ask phrasing and the
"answer in my own words" ordering are untested and need a human at the keyboard. One labelled
disclosure appeared in the artifact — `**Checking — decomposition.**`, with "Silence leaves it
as stated" — but disclosures belong to the conversation, so their frequency is not measurable
this way either. The gate filed a `DEBT` entry saying all four Step 8 answers were supplied by
the model standing in for the user, which is the honest record of a self-answered defense.

**And the version question is settled, mechanically.** On that machine
`installed_plugins.json` reports 0.7.0 at commit `374c2b8`, and there is a matching 0.7.0
snapshot under `~/.claude/plugins/cache/`. Neither is what runs. `known_marketplaces.json`
records the marketplace `source` as `directory` with `installLocation` pointing at the clone, and
a probe run confirmed the CLI reads the working tree: it reported `## Step 1c — Draw the map`,
which exists only on the branch checked out there. So a `directory` marketplace resolves live
from the clone, the recorded version and the cache copy are both stale bookkeeping, and the
commit sha of the clone at run time is the only thing worth recording. The first dogfood
therefore ran at `5353329`, not at the 0.7.0 the tooling claims.

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
