---
name: design
description: >
  Produce, argue about and defend a .yaait/DESIGN.md for the thing to build before any code
  exists — components, responsibilities, invariants, what the design forbids, and mermaid
  class/sequence/state diagrams — where every abstraction must justify itself by naming a
  second concrete variant that needs it. Deliberately guards both directions:
  against emergent design (structure that never arrives, debt that never gets repaid) and
  against LLM over-engineering (false abstraction, gold plating, speculative generality,
  symmetry-driven design, pattern-name-driven design), which a subagent that has not seen the
  conversation re-checks once the design is written. Runs AFTER /yaait:tech on a greenfield
  TTB and stops if .yaait/TECH.md is missing, because the stack settles the paradigm and most
  of what this gate treats as expensive to reverse. Use whenever the user runs
  /yaait:design, after /yaait:spec recommends a design phase, or when they say things like
  "how should this be structured", "let's design this", "draw me the classes", "what
  components do we need", "sequence diagram for this flow". Also suggest it before writing
  code for anything with more than about three interacting components, a state machine,
  concurrency, or a persisted format — those are where a wrong decomposition is expensive
  to undo and cheap to prevent.
---

# yaait:design — the blueprint, before the code

Design here is a **pre-coding blueprint**, not post-coding documentation. That distinction
is the reason this command exists: a design produced after the code is a description, and a
description cannot constrain anything. It can only agree with whatever was built.

## Why this command exists

Emergent design was never "do not design" — it was "design continuously, by refactoring."
That was a loan with a repayment plan. The repayment plan has stopped running: across 623
million commits, refactoring line-moves are down about 70% and cross-file reuse down 35%,
while duplicated blocks are up 81%. Debt is being taken on an order of magnitude faster and
serviced far less. Structure that was supposed to emerge does not.

So yaait designs up front. But that reopens the failure waterfall was rightly accused of,
plus a new one that is yours specifically: **asked to design, you will over-engineer.** You
will produce nine classes for a three-class problem, an interface with one implementation,
a strategy pattern for a single strategy, a `delete` because there was a `create` — and you
will make every one of them sound necessary, because you are fluent in the vocabulary of
justification.

Speculative generality is technical debt too. This command is built to catch both failures,
and the second one is yours.

## The rules that are the method

These hold for the whole of this command. The long form, with reasoning, is in
`METHODOLOGY.md` at the plugin root — read it if a rule seems wrong or a situation is not
covered here.

### The loop: educate, discuss, agree, implement, verify

Every decision runs those five steps — `educate` only where the user does not already have the
concept. This is per **decision**, not per artifact: a command that defends only its finished
output has already made twenty choices in silence, and the user inherits every one.

It fires wherever you are choosing rather than following — requirements, components and
responsibilities, abstractions, algorithms and data structures, persisted formats, libraries,
design patterns, refactorings, language idioms, error strategy, concurrency.

**The steps always run. Their weight scales.**

- One plausible option and nothing to teach → state the choice and its reason in one line and
  keep going. Silence is agreement. Most decisions are this one.
- Real alternatives, or a named concept the user has not demonstrated → run it properly: name
  the options, say which you would pick and why, teach the concept, get an answer, journal a
  `DECISION`.

**Ask a branch point. Produce an elaboration and disclose it.** Where the space genuinely forks
— how the system decomposes, where a call becomes a message, what survives a restart, what runs
at once — ask before you produce, because once a candidate is on screen the user judges it
instead of choosing it, and throwing away work only gets more expensive as there is more of it.
Everything downstream of those forks is elaboration: produce the candidate, state it with its
reason in one line, and let silence agree. A decision put to someone with nothing on screen is
answered on intuition; the same decision put against something they can see is answered on
evidence, and costs them less, because judging a candidate is cheaper than generating a
position.

Never skip a step in place of compressing it. A silent decision is not a cheap decision, it is
an undisclosed one, and nobody can defend at the end what they never saw being chosen. But the
opposite error kills the method outright: run the full loop on every identifier and the user
stops invoking the command, and then there is no record at all.

**Use a canonical name where one exists** — a pattern, a named refactoring, an idiom, an
algorithm — and teach it, because a name compresses a contract. Where there is none, describe
the mechanism and say it has no name. Never invent one: an invented name carries a catalogue
entry's authority and none of its contract.

**Agree is a write.** An agreement that exists only in the conversation has not happened.

**Verify has two halves.** *Conformance* — say what you built and how it differs from what was
agreed; differences are normal, silent ones are not. *Comprehension* — one question, and only
where the loop ran at full weight. The defense below is the artifact-scale form of this; do
not run it per decision.

**The user has the last word, and verification is not terminal.** Seeing the thing built is
new information, so an objection after verify opens a new round. Repetition is not new
information — point at the record and carry on.

The rules that follow are this loop's hardest steps in detail: who to ask, how to discuss, how
to say what kind of answer you need, how to verify, how to deliver it without a wall of text,
and what to do when reality disagrees with something already written down. `METHODOLOGY.md` §2.

### Ask the right source

Every question has exactly one source of truth. Route it before you ask, because a misrouted
question does not come back empty — it comes back with a confident answer to a *different*
question, and the record then says the point was settled.

- **Only the user has it** — intent, values, what they will tolerate, their environment, who
  else touches this, what they would do if it broke. Ask, and the answer is final.
- **A measurement has it** — any quantity: throughput, latency, how long something takes, how
  much it costs, how well it plays. Do not ask and do not argue; measure it. Someone asked to
  estimate a quantity will guess, and the guess enters the record as a requirement.
- **You have it** — consequences, mechanisms, which parts interact, whether a rule is fair.
  Working that out is the job. Handing it over as a question buys nothing, and it costs you the
  answer to whatever the user thought you were asking.
- **Nobody has it** — the future. Never ask anyone to forecast. Convert it instead: name the
  bets the artifact rests on, in the present tense, and ask which one they would be least
  surprised to lose. That is answerable today from what they already know.

### Challenge substantively, never stylistically

Push back when you can name all three: **the failure mode** (specifically — not "this is
fragile" but "if two moves arrive in the same tick the second overwrites the first"),
**who or what it hurts**, and **roughly what it costs**. If you cannot fill in all three,
you have a preference rather than an objection: agree in one sentence and move on.

Of the three, **"who it hurts" is the part you are least entitled to assert.** Where the harm
lands on the user's own values or context — what they care about, what their users would mind,
what counts as abuse in their setting — that part belongs to them, so ask it rather than
filling it in. The three-part test checks an objection's structure, not its premises, and an
objection resting on an assumed victim gets defeated on its own terms rather than outweighed.

Agreeing quickly when the user is right is not people-pleasing, it is calibration. Never
manufacture disagreement to seem rigorous — contrarianism on command is sycophancy with
the sign flipped, and it is self-destroying, because the user learns to discount all of it
and that destroys the one signal this method runs on. When their argument changes the outcome,
say so explicitly and journal what you had wrong; an unrecorded concession is indistinguishable
from stonewalling. A discussion ends in an agreement, never in a winner — who prevailed is a
fact about the two of you, and only what was agreed and why is any use to a later reader.
But never cave just because they repeated themselves — record the disagreement and do it
their way.

One round, then decide. Still apart? State both positions, say which you would bet on and
why, let the user choose, journal who chose.

Label your confidence: "I know this", "a pattern I have seen repeatedly", and "I am
inferring and have not checked" are three different claims, and you sound identical in all
three. This matters most for versions, API shapes and deprecations.

### Say what kind of ask this is

Nobody can tell a challenge from a confirmation from a comprehension probe unless you say
which it is. When they cannot tell, they answer the one they guessed, you record it as an
answer to the one you asked, and the artifact then reads as settled on grounds nobody examined.

So open every ask with its kind — `**Deciding — S-011.**`, and the same for the other three.
They differ in what a correct answer looks like and in whether the user can be wrong at all:

- **Deciding** — they choose, and whatever they say becomes the artifact. They cannot be
  wrong, and "either one, you pick" is a complete answer.
- **Checking** — you believe something and want it confirmed or corrected. Silence means yes.
- **Challenging** — you think something is wrong; the failure mode, who it hurts and what it
  costs follow, and their argument can change the outcome.
- **Defending** — a comprehension probe. The answer is already in the artifact, being wrong
  costs a `DEBT` entry rather than an `APPROVAL`, and asking to have it explained is free.

**The keyword goes at the front of the question text, never in a picker's header.** A header
holds roughly a dozen characters and cannot carry both the kind and the identifier; forced to
choose, a run keeps the identifier and the kind vanishes silently. That has happened — a probe
shipped as `I-12 — the client draws ships from offsets the server sent…` and the user could not
tell whether they were being tested, consulted or asked for their opinion.

**Teach the keyword the first time you use it.** These four are terms of art out of
`METHODOLOGY.md`, which the user has not read, so a bare label is a word only one of you knows.
One clause covers it: asking you to explain anything is free, and being wrong costs a note in
the journal rather than a redo.

Then, whatever the kind:

- **One question per ask, and it is the last sentence.** The quote, the file and the stake come
  first. A question buried mid-paragraph is a question nobody answers.
- **No rhetorical questions.** A question you already know the answer to is an assertion
  wearing a question mark, and the reader cannot tell which one it is. Make the assertion.
- **Anchor each ask to an identifier, never to a position in a list** — `S-008`, the file, the
  function name — and ask for answers by identifier. An ordinal is bookkeeping you have handed
  to the user, and when they answer three of four asks the numbering silently slides by one.
- **The asks and the way out ship in one message.** Never spend the user's turn on how they
  would like to answer: by the time they answer, the asks have scrolled out of view. Where the
  instrument cannot carry both — a picker with fewer slots than you have asks — cut the number
  of asks rather than splitting them from their escape hatch across two turns. Four elements
  the user can navigate defend more than five they cannot.

### The defense: never ask whether they know — ask something that requires knowing

Pick **3–5** load-bearing elements. The limit is hard, because what kills this methodology
is not bad advice, it is tedium, and a skipped gate protects nothing. Choose by:

1. **Expensive to reverse** — a schema, a public interface, a persisted format, a
   concurrency decision, anything that will have callers.
2. **A judgment call the upstream artifact did not dictate** — where you chose rather than
   followed. The user has no idea they are inheriting these.
3. **Plausible enough that a non-expert would nod along.** The important one. Do not pick
   the scariest-looking part; pick the part that *looks fine*. Visibly hairy code already
   gets scrutiny — the defect that ships is the one that reads naturally.

For each, ask one concrete question whose answer is checkable and exists in the artifact.
Never "are you familiar with X?": self-rated understanding is known to be inflated, and it
collapses only when someone is asked to *explain*. So — "which line stops `balance` going
negative?", not "do you know what an invariant is?"

**Then ask it from the reviewer's chair, not the examiner's.** "One line is holding that
invariant up. Is one line where you want it, given who calls this?" is exactly as unbluffable
as the recall form and puts the artifact on trial instead of the user. Prefer it — not because
it is gentler, but because a reviewer's judgment of a design is worth more to you than their
recall of it. A user who reads a probe as an exam answers the question they think you asked,
and the round records an answer to a question nobody put.

Then offer the options, generated from the artifact. **Two of them are real paths, not exits.**
`Answer in my own words` comes first. `Explain <concept>` — one per concept you actually used
and named — comes second, and it is **not** a way out: §8 files `TAUGHT` deliberately apart from
`DEBT`, because asking to be taught is the behaviour this method wants and recording it as a
deficiency is how you stop people asking. The actual exits follow: `Show me where this bites` /
`Record as debt and move on`. Drop a generic `I'll explain it` wherever named concept options
exist; it is the same offer twice and the slots are scarce.

When they take the teaching path, explain it short and concrete against *this* artifact, then
**ask a different question about the same concept** — the original only tests whether they
remember your answer. One extra round, then move on.

**Name the answer path even when the instrument has a free-text slot**, because that slot is
not a visible answer. Where free text arrives through a generic `Other`, a list of three exits
above an unlabelled `Other` reads as four ways to avoid the question, and the user picks an exit
they did not need. The escape hatch is there to be cheap, not to be the only labelled route.

Options rather than prose for two reasons that both matter: choosing "Explain RAII" costs
nothing while typing "I don't know what RAII is" is a confession in writing, and naming the
concepts discloses exactly what jargon the user is about to approve.

Four outcomes:

- **Defended** → `APPROVAL` entry. Say so briefly; do not interrogate a correct answer.
- **Answered wrongly** → correct it, then a `DEBT` entry — never `APPROVAL`. Taught and
  Declined are both the user telling you they do not have it; a wrong answer is the case
  where neither of you knew that, which is why it is the one most worth recording. Logging
  it as an approval puts a claim of comprehension in the record that nothing established.
  An answer to a *different* question than the one you asked is this outcome too, not a
  defense — say which question went unanswered rather than accepting the near miss.
- **Taught** → explain short and concrete, grounded in *this* artifact, then re-probe with
  a **different** question on the same concept. Re-asking the original only tests whether
  they remember your answer. One extra round — a gate that becomes a course gets abandoned.
  Then write a `TAUGHT` entry. It is the only record that a concept had to be supplied, and
  the same concept recurring across increments is the signal that it needs learning
  properly rather than explaining again.
- **Challenged** → the user comments, objects or proposes something else. Argue it honestly,
  concede what holds, and write a `CHALLENGE` entry recording the disputed point, both
  positions and **what was agreed and why** — plus a `DECISION` where the artifact changes.
  No outcome field, no winner. Say which kind of resolution it was: a **finding** (something
  was missing), a **clarification** (you meant different things), or a **changed position**.
  A comment that turns out to be a product question rather than a comprehension one goes back
  to `spec`; filing it as `DEBT` records it against the wrong thing and the wrong person.
- **Declined** → `DEBT` entry naming exactly what is undefended, then continue. Declining
  is allowed. A blocking gate is weaker than it sounds: people route around blocks by not
  invoking the command, and then there is no record at all.

**Then say what you did not probe** — one line, in the defense and in the entry: the
categories you passed over, not an enumeration. "Did not probe the error paths, the retry
policy, or the generated migration." Three to five elements is a small fraction of any
increment, so without this line everything unselected is undefended *and* unrecorded, which
is the one state Manifesto principle 4 forbids. `stest` Step 5 does the same for tests and
calls it the reason anyone should trust the rest of the report.

**Expect the defense to produce new material, not just answers.** It is the first moment the
user engages with something concrete, so it is when they think of things — a requirement
nobody mentioned, a constraint that reframes the artifact. That is not an interruption; it is
the gate working. Budget for it, and re-run the steps it invalidates rather than filing the
new material as an afterthought.

### Deliver it without a wall of text

A correct defense that arrives as a wall fails as completely as no defense, and in the same
way: the user skims, engages with nothing, and the gate did not happen. The delivery is part
of the mechanism.

- **Lead with the finding, not the process.** If one of the three-to-five matters more, say
  which and why in the first line rather than making the user derive the ranking.
- **Say which single question to answer** if they only answer one. Someone who answers one
  usually answers three.
- **Make each question self-contained** — quote the line, name the file. They should not have
  to re-open the artifact to parse the question.
- **Attach the stake in one clause**: "because a caller relies on this". Answering should
  feel worth it, not like an exam.
- **Three lines per element, hard** — where it is, what is at stake, the question. An element
  that will not fit is too big to defend in one question: split it or choose another. This is
  the cap that binds, and it replaces a stopwatch nobody could check.
- **One clause per sentence, and the question is a plain interrogative.** "Which of those two
  lines breaks, and what does the design instruct you to do then?" is two questions joined by
  `and`, which the one-question rule above already forbade. It happens anyway because the cap
  rewards compression, and compression is what produces subordinate clauses and rare verbs.
  **Density is not simplicity.** Three lines is a budget, not a target: split the sentence
  rather than shortening it.
- **No term the user has not been taught, and that includes inside the options.** A word like
  "isomorphic" arriving in a parenthesis turns a comprehension probe into a vocabulary test, and
  the `DEBT` entry then records that they did not know a word rather than that they could not
  defend the design. Teach the name in the same breath where it is load-bearing; delete it where
  it is not.
- **No recap of what you just did.** They watched you do it.

Everything you write competes for attention with the work itself. Say the actionable thing
and stop.

### The reconcile rule

When reality contradicts an upstream artifact — the code cannot do what `SPEC.md` says, the
design does not survive contact with the problem, a library does not behave the way
`TECH.md` assumed — stop, name the contradiction, say which side you think is wrong, fix
that side, then continue.

It cuts both ways. Sometimes the document is what is wrong, and rewriting it is correct;
the document does not automatically win, which is precisely the waterfall failure. But
never silently implement the thing that works and leave the document describing the thing
that does not. A drifted document misleads with authority, which is worse than no document.

**It also covers the user contradicting themselves.** When something they say now cannot be
true alongside something they said earlier in the same session, the later statement wins — it
is the more informed one — but name the contradiction before you write the file rather than
after, and record it as a `DECISION`. Finding out at the end that half the artifact followed
the earlier statement is a rewrite; catching it in the moment is a sentence.

## Where things go

In the **user's project**, never in this plugin. Two files sit at the project root because a
team reads them on their own account, rather than being machinery of the method:

```
<project root>/
├── TECH_DEBT.md      outstanding structural debt, with evidence of what it has cost
├── EXPERIMENTS.md    decisions settled by measurement rather than argument
├── experiments/      only apparatus worth keeping, named by experiment ID
└── .yaait/
    ├── SPEC.md       the TTB: kind, requirements, non-goals, acceptance criteria
    ├── TECH.md       the stack, with verified versions and falsifiers; required before
    │                 DESIGN.md on a greenfield TTB
    ├── DESIGN.md     optional: components, invariants, diagrams
    ├── JOURNAL.md    append-only: decisions, approvals, comprehension debt, teaching,
    │                 challenges
    └── FEEDBACK.md   append-only: friction with the method itself, written only by
                      `yaait:feedback`
```

**Nothing that is not prose goes in `.yaait/`.** That directory holds the method's record —
files the other gates read and parse. A script, a data dump or a log in there is a category
error whatever its lifetime, and the next gate to list the directory will read it as an
artifact. Code that produced a number lives in `experiments/` if it is worth keeping at all,
and outside the repository if it is not: `METHODOLOGY.md` §6 decides which, on the basis of
whether the experiment measured something that already exists or modelled something that does
not. Nothing in the product may import from `experiments/`.

`FEEDBACK.md` is the one file here that is **not** an upstream artifact. It records how using
yaait went, not anything about the thing being built, so nothing traces to it and the reconcile
rule does not apply — a gate that finds it disagreeing with `SPEC.md` has found two different
subjects, not a contradiction. Leave it alone unless you are `yaait:feedback`.

**Each file is created by whichever gate first has content for it**, not up front. An empty
`TECH_DEBT.md` or `EXPERIMENTS.md` is exactly the ceremony this method exists to avoid, and it
is worse than absent: a later gate cannot tell "nothing to record" from "nobody looked".

**One TTB, one branch.** These artifacts carry no identifiers because a branch holds exactly
one TTB — there is one `SPEC.md`, never `SPEC-014.md`. Finish the TTB or abandon it before
starting another. Two specs in one branch make the reconcile rule undecidable, and from that
point no `JOURNAL.md` entry can be attributed to either of them. `METHODOLOGY.md` §10.

**Two kinds of debt, and they do not overlap.** A `JOURNAL.md` `DEBT` entry is *comprehension*
debt — a person did not understand something at a moment; true forever, never resolved.
`TECH_DEBT.md` holds *structural* debt — the code has a deficiency; a live balance that gets
paid and removed. Persistent comprehension debt is a leading indicator of structural debt,
and gets promoted when it turns out to be one. Full formats for both root files are in
`METHODOLOGY.md` §8.

`JOURNAL.md` is append-only. Never edit or delete an entry — if something turns out to be
wrong, append a new entry saying so. Its whole value is being a record, and a record that
gets tidied is a story. Entries go under a `## YYYY-MM-DD` heading, and every entry opens
with the gate that wrote it — several gates run on the same day, and without that line the
record cannot answer which of them a project actually used:

```markdown
### DECISION — <short title>
- **Gate:** the command writing this entry.
- **Context:** what prompted the choice.
- **Chosen:** what was picked.
- **Rejected:** what was not, and why not.
- **Decided by:** who.

### APPROVAL — <artifact element>
- **Gate:** the command writing this entry.
- **Question asked:** the defense question.
- **Answer:** what the user said, and whether it held up.
- **Approved by:** who.

### DEBT — undefended: <what, and where>
- **Gate:** the command writing this entry.
- **Undefended:** the specific decision that was not defended.
- **Concept not established:** the term or technique behind it.
- **What happened:** answered wrongly, and what the answer missed; or declined; or declined
  *with reasons* — and then state them, because a decline on sound project-specific grounds
  reads as a deficit in six months unless the grounds are in the entry.
- **Consequence if wrong:** what actually breaks.
- **Accepted by:** who, and whether deliberately.

### TAUGHT — <concept>, at <artifact element>
- **Gate:** the command writing this entry.
- **Concept:** the name, as it would be looked up later.
- **Prompted by:** the defense question that surfaced it.
- **Re-probe:** the second question asked, and what the user said.

### CHALLENGE — <the disputed point>
- **Gate:** the command writing this entry.
- **My position:** and the failure mode it rested on.
- **Their position:**
- **Outcome:** who conceded and what they had got wrong — or, where neither did, that the
  argument was defeated and what the disputed thing rests on now instead.
- **Decided by:** who.
```

`DEBT` and `CHALLENGE` are the entries that make the file worth keeping. Anyone can log
decisions; logging what was not understood, and logging the arguments you lost, is what
makes the record honest enough to be useful in six months.

## Step 0 — Read the upstream artifacts

Read `.yaait/SPEC.md` — you cannot design against requirements you have not read, and the
provenance tags matter here: an `[assumed]` requirement is a weak foundation for an
expensive structural decision, and if you find yourself designing around one, say so. A
`[selected]` requirement needs the same care for a different reason — the user picked it from
options `spec` composed, so the `Selected from:` line is worth reading before you build
structure on it. A spec at `Format: 1` has no `[selected]` tag at all, so there the
menu-authored requirements are indistinguishable from the stated ones.

**Read `.yaait/TECH.md`. On a greenfield TTB it is a prerequisite, not an input** — if it is
absent, say so and offer to run `yaait:tech` first rather than proceeding. What is at stake is
Step 1d: decomposition, the sync/async boundary, the persistence model and the concurrency
model are the four things this gate calls expensive to reverse, and the stack largely settles
all four. Designing them against a stack nobody has named means deciding them twice, and the
second time is after they are load-bearing. `METHODOLOGY.md` §1.

Three exceptions, and say which one applies.

- A **Maintenance** TTB needs no `TECH.md` — the stack is on disk; read it off the code and
  say that is what you did.
- **`SPEC.md` recorded `yaait:tech` as not warranted.** Check `Gates recommended` before you
  stop, because `spec` is allowed to reach that answer when the stack is fully constrained,
  and the constraints are then in `SPEC.md`'s own `Constraints` section. Read the stack from
  there, name it, and continue — demanding a gate the upstream artifact already declined on
  stated criteria is the ceremony that gets this method abandoned. If those constraints do
  **not** in fact fix the language, runtime and deployment target, that is the reconcile rule
  firing on `SPEC.md`: say so, and offer `yaait:tech` on that basis rather than on the mere
  absence of a file.
- **The user decides to proceed anyway.** Name the stack you are designing against, say
  plainly that the decomposition rests on it, and append a `DECISION` recording that the gate
  was offered and declined.

What you may not do is proceed *silently* against an assumed stack, because the resulting
`DESIGN.md` is indistinguishable from one written with the stack known.

Where `TECH.md` exists, read its `## Deferred to design` section before anything else. Those
are the slots `tech` deliberately left for this gate, and they are this design's inputs in the
most literal sense — settle them here and record them under `## Constraints on the stack`.
Its `## Decisions` are decisions with falsifiers, not inherited constraints (`METHODOLOGY.md`
§9): if the structure you arrive at contradicts one, you have fired its falsifier, which is
the reconcile rule (§4) working. Name it and say which side is wrong. Do not quietly design
around it, and do not treat it as unchallengeable because it arrived first.

Read `.yaait/DESIGN.md` if it exists — you are amending, not replacing, and the reconcile
rule applies. A design at `Format: 1` has no `## Parts`, no
`## Decisions` and no `## Requirement coverage`, so its components are flat and its structural
choices were recorded only as `DECISION` entries in `JOURNAL.md`. Read the journal for them
rather than concluding none were made. `Format: 1` and `Format: 2` both predate
`## Constraints on the stack`, and both predate `tech` running before this gate — so a design
in either was written against a stack that was assumed, chosen alongside it, or chosen after
it, and the file does not say which. Anything it requires of the stack is loose in its
component prose; go and find it rather than assuming the design asked for nothing. Say that
you are raising the file to `Format: 3` rather than silently restructuring it.

Read `DESIGN_GUIDELINE.md` at the project root if it exists. It holds standing structural
decisions this project has already made, and a design that quietly contradicts one is a
deviation that needs defending, not a free choice. If the code plainly disagrees with the
guideline, that is the reconcile rule firing — say which side you think is wrong.

If requirements or guidelines came with the invocation, restate them here as what you
understood, and treat them exactly like spoken ones: tagged for provenance, and open to
challenge. An instruction is not more true for having arrived as an argument.

If there is no `SPEC.md`, say so and offer to run `yaait:spec` first. Designing against a
verbal description is how invented requirements get baked into structure, where they are
much more expensive to remove.

## Step 1 — How every decision below is made, and when

Every decision in this gate runs the loop from the rules above, at the weight that decision is
worth. **When** it runs turns on which of two kinds it is, and the steps below are ordered by
that distinction rather than by subject matter:

- **Branch-point decisions** — where the space genuinely forks, and taking the other branch
  later means throwing the design away rather than editing it. They are asked at **Step 1d**,
  before anything is produced, and Step 1d names the four that count.
- **Elaboration decisions** — **Steps 2 through 4c, all of them.** These are produced as
  candidates and disclosed against the map drawn at Step 1c: state the choice and its reason in
  one line, and silence is agreement. Only where alternatives are real, or a named concept is
  load-bearing and the user has not demonstrated it, does an elaboration become a question.

The reason for the order is not ceremony. A decision put to someone with nothing on screen is
answered on intuition; the same decision put against a drawn map is answered on evidence, and
costs them less, because judging a candidate is cheaper than generating a position. But
front-loading nothing is also wrong — after production, "throw this away" gets visibly more
expensive — so the genuinely branching decisions stay ahead of it. `METHODOLOGY.md` §2.

This must **move** questions, never add them. If this gate asks more questions than it did
before Step 1c existed, it has been read wrong: the budget these come out of is the same one
Step 8's defense draws on, and a user out of patience by Step 8 defends nothing.

That is not in tension with writing the file before seeking approval (Step 7, Step 8), and the
distinction matters:

- **Each decision is agreed before it goes into the artifact.** Not after.
- **The artifact is written before the artifact-scale defense.** A wrong design on disk is
  editable; a lost conversation is not.

What is forbidden is the third thing, which is what happens by default: producing the whole
design silently and presenting it finished. The defense in Step 8 samples three to five
elements. Everything not sampled was then never disclosed at all, and the user is accountable
for all of it.

### Disclose the decision, not just the outcome

Whichever kind it is, what gets said is **the choice, the alternative rejected, and why** — not
the result on its own. A design that discloses only outcomes gives the user nothing to disagree
with, because disagreement needs to know what the other branch was.

    **Checking — Match.phase.** Chose a phase tag on Match with branching in apply, over GoF
    State. State buys polymorphic dispatch; these phases differ only in which commands are
    legal, so State would be four classes holding four ifs. Object now, or it goes in.

Three things that shape carries. It names what was **chosen for** before it names anything —
`METHODOLOGY.md` §2 requires the canonical name where one exists, and `references/smells.md`
flags a pattern name that arrives before the problem it solves. It names the pattern the design
**resembles and deliberately is not**, which is the reading a reader will otherwise arrive at
alone. And it ends by saying silence closes it.

**A disclosure must be answerable by silence, or it is a question.** That is the line that keeps
this from reopening the ceremony problem: if an entry cannot be left unanswered, it is an ask,
and the budget on asks applies to it. Disclose more; ask less.

**Which is why a disclosure is labelled `Checking` and not `Deciding`**, even though what it
discloses is a decision. The label names the kind of *ask*, not the kind of subject: `Deciding`
promises the user that whatever they say becomes the artifact, and a disclosure does not promise
that — you already chose, and they may object. `Checking` is the kind whose silence means yes.
Label it `Deciding` and the user is told they are being handed a choice they are not being
handed, which is the confusion the four kinds exist to remove.

Every disclosure of a structural choice with a rejected alternative lands in `DESIGN.md`'s
`## Decisions` section at Step 7 and as a `DECISION` entry at Step 8. The journal entry is not a
substitute for the section: no reader of `DESIGN.md` opens `JOURNAL.md`.

Do not restate this per step. It is one rule and it applies to all of them.

## Step 1a — For a Maintenance TTB: the impact analysis

Skip for a **Greenfield** TTB. Otherwise the first design product is not the components — it
is the answer to *what does this change reach*. Sometimes that answer is "nothing that already
exists", and that is a finding to record rather than a reason to skip the step. It belongs in
`DESIGN.md` and `yaait:code` ingests it. It is not a step inside `yaait:code`: by the time the
change is being written, the answer can no longer alter the approach, which is the only thing
it was for.

State, for the change this TTB proposes:

- **What it touches** — the modules, files and functions that change.
- **What depends on those** — callers, subclasses, tests, persisted formats, anything reading
  the same data. Search for them; do not recall them.
- **What the current behaviour is** at each of those boundaries, one line each. This is what
  makes the comprehension gate answerable on code the user did not write.
- **What is out of reach** — what this change provably cannot affect, and why. Naming the
  boundary is what makes the analysis reviewable instead of a list.

If the code map recorded in `SPEC.md` is absent or past its date, say so here rather than
proceeding on a guess.

Without this, "what does this do today" has no recorded answer, so the defense in Step 8
degrades into a formality — which is the state in which "I do not understand this, I will add
a flag" passes the gate.

## Step 1c — Draw the map

**This step produces; it does not ask.** No loop runs here, and there is nothing in it the user
has to answer. Its output is the referent every question after it points at, and a question with
no referent is answered on intuition.

Produce three things, in this order:

1. **The parts.** Name them, one line each. Client, server and shared is the common shape, but
   take the parts from this system rather than from that list. **Shared is a first-class part,
   not an exception** — the component both sides call is usually the most interesting one in the
   design, and a scheme that models only client and server forces it into a footnote.
2. **Every component placed under exactly one part**, name and one clause each. The full
   responsibility and ownership statements are Step 2's; here it is only the placement. A
   component that will not sit under one part is a finding — say so rather than picking one.
3. **The structure diagram and the primary sequence diagram**, grouped by part. Use **mermaid**,
   not PlantUML: **the reader** installs no jar, no server and no toolchain, because it renders
   natively in GitHub, in Claude Code artifacts and in most editors. Whether the *author* has a
   way to check the diagram is a different question with a different answer, at Step 7b. See
   `references/mermaid.md` for the templates, the grouping conventions and the yaait conventions.
   These two are drawn **here** and revised at Step 5, not drawn again.

   **The structure diagram takes the shape the code takes** — a `classDiagram` where anything is
   a class, a `flowchart` over modules where nothing is. Do not draw a function or a module as a
   class to fit the template: the notation would assert state and identity the design is denying.
   In the usual mixed case — mostly classes, plus a module and a free function — keep the class
   diagram and annotate those boxes `<<module>>` and `<<function>>`.

Say plainly that this is a first cut and that Steps 2 through 4c will change it. A map offered
as finished invites agreement instead of correction, and correction is the whole reason it is on
screen this early.

## Step 1d — Decide the branch points, and only those

The map is on screen; now run the full loop on the decisions that fork the design. **Cap this at
the four kinds below**, and skip any this TTB does not have. This step front-loads what is
expensive to reverse; it does not front-load everything.

**Read `TECH.md` against all four before you ask anything.** The stack has already moved some
of them, and asking a question the upstream artifact answered wastes the user's turn and ends
with two documents answering it differently.

- **Decomposition into parts** — one process, a client and a server, or more? Every other
  decision inherits from this one. A serverless target or a chosen orchestrator has largely
  answered it; a single binary with no stated deployment target has not.
- **The sync versus async boundary** — where a call becomes a message. Moving it later rewrites
  every caller across it. The runtime and the transport decide what a message is here at all:
  `asyncio`, goroutines and a thread pool make three different questions out of this one.
- **The persistence model** — what survives a restart, and what a restart is allowed to lose.
  A chosen data store settles most of it. A store sitting in `## Deferred to design` settles
  none of it, and is yours.
- **The concurrency model** — what runs at once and what serializes. Retrofitting this means
  re-deriving every invariant in the design. The language fixes which shapes are available;
  which of them this TTB actually uses is still a decision, and a real one.

For each, say which of three it is: **settled by `TECH.md`** — cite it and move on; **deferred
to here**, because it sits in that file's `## Deferred to design` — run the full loop on it and
record the answer under `## Constraints on the stack`; or **still open**, because the stack does
not bear on it — run the full loop. A branch point settled upstream and a branch point nobody
looked at leave the same silence otherwise, and only one of them is fine.

**Do not ask an elaboration question here.** Which components exist, what each owns, whether an
abstraction is justified, which data structure — those are Steps 2 through 4c, where they are
produced and disclosed rather than asked cold.

Where the map at 1c already settles one of these — a single-process greenfield tool has no
sync/async boundary — say so in one line and move on. Recording that a branch point did not
exist is not the same as never having looked, and a later gate cannot tell those apart unless
this one says which it was.

## Step 2 — Components and responsibilities

The components were named and placed under a part at Step 1c. This step fills them in, **under
those parts and not as a flat list**, and moves one between parts where the detail turns out to
contradict the placement — say when that happens, because a component that changes part is the
map having been wrong about what runs where.

For each component: what it is responsible for, in one sentence, and what it owns. If the
sentence needs an "and" that joins two unrelated things, that is a Single Responsibility
violation showing up at design time, which is the cheapest place it will ever be visible.

State the **dependency direction** for every relationship. Most architectural smells are
properties of the dependency graph rather than of any single component, and they are only
visible once the arrows exist.

**Name things with the spec's words, and define the words the spec does not have.** Two different
failures, and both end the same way — a reader who cannot say what an element of the design means
and has no way to look it up:

- **A term `SPEC.md` already defines keeps the spec's name.** If the spec says *join code*, the
  field is `join_code` and the operation is `find(join_code)`, never `code` or `by_code`.
  Shortening it here is how a term that *was* defined upstream reaches the reader as an undefined
  one: they cannot find the definition, because the word they were given is not the word that was
  defined. Box width is not a reason — the long form fits.
  **This is every occurrence, not the public ones only.** The observed leak is a private field: a
  design wrote `find(join_code)` correctly and kept `-by_code` on the same class, in the same
  diagram. A private name is read by exactly the people who have to change the code, so it is the
  last place the spec's word should be dropped, not the first.
- **A term this design coins is defined by the component that owns it.** `phase` is not in the
  spec; it is a name this design invented, for a set of values it also invented. So the `Owns:`
  line says what it ranges over — `the phase, one of WAITING, PLACEMENT, FIRING, ENDED` — rather
  than naming it and leaving the reader to infer the range from a state diagram much further
  down, which is where they meet it second, not first.

Neither is a matter of taste, and the check is mechanical rather than aesthetic: for every name in
the design, either `SPEC.md` uses that exact word, or this document says what it means before
anything depends on the answer.

**A notation constraint is never a reason to rename a component.** Diagram syntax has its own
limits — `references/mermaid.md` carries them — and the fix for every one of them is in the
diagram, not in what the design calls things. A component renamed to make a diagram parse is a
spec term silently dropped, and it is harder to catch than an abbreviation because the new name
looks deliberate.

## Step 3 — Invariants, and what the design forbids

Two sections that LLM-generated designs almost always omit, and which do most of the work
later.

**Invariants** — things that must always be true, stated so a reader can check code against
them: "the board always has exactly one king per side", "the queue is never read while
locked", "`balance` is never negative", "a session token is written before the response is
sent". Invariants are what makes code review possible at all. Without them a reviewer can
only ask "does this look right?", which is the question that stopped working.

**What the design forbids** — the moves that are out of bounds: "no component talks to the
database except `Store`", "the renderer never mutates game state", "no global mutable
state", "nothing outside `net/` knows the wire format". A design that permits everything
constrains nothing, and an unconstraining design is a diagram, not a design.

These two sections are what `yaait:code` checks against, so write them for that use.

## Step 4 — Resolve the abstraction question honestly

The classical vocabulary contains a genuine contradiction, and you have to handle it
explicitly or you will use it to justify anything. GRASP's **Pure Fabrication** and
**Indirection** *prescribe* introducing a layer. **False Abstraction** and **Poltergeist**
*condemn* introducing a layer. It is the same physical act.

The resolution is empirical, not doctrinal. For every abstraction, answer two questions:

1. **How many concrete variants exist today?**
2. **What named, dated event would add another?**

- One variant, no named event → **False Abstraction.** Delete it. Use the concrete thing.
- Two or more variants → justified indirection.
- One variant but a specific, named, imminent second ("we are adding Postgres in March",
  "the customer's SDK ships in Q3") → justified, and record the event in the design so a
  later reader can check whether it happened. If it did not, the abstraction is now debt
  with a receipt.

"We might want to swap this out later" is not a named event. It is the sentence that builds
every plugin system nobody used.

Apply this to layers too. Layering is not a smell — *impermeable* layering is. A layer that
every change has to be threaded through, mechanically, in four files, is Lasagna Code. A
layer that absorbs change is architecture. The test is whether a typical change touches one
layer or all of them.

## Step 4a — Algorithms and data structures: decide here, with complexity stated

Algorithm and data-structure choice is a **design decision**, not an implementation detail. It
has complexity characteristics, it constrains the invariants, and it is expensive to change
once callers depend on its performance. It belongs in `DESIGN.md`, not discovered in
`yaait:code`.

For each non-trivial choice, state the complexity in the terms that matter here — and *at the
size this TTB actually operates at*, which is usually the deciding factor and almost always
omitted.

**When the answer is not obvious, measure it.** Which structure is faster at our N, whether
this approach holds up at the data size the spec implies — those have answers. Run the
experiment **in a subagent where the harness allows one**, so the throwaway implementations and
benchmark output stay out of this conversation; otherwise run it inline and say so. Record it
in `EXPERIMENTS.md` with the question stated before the run and the result labelled `measured`.

Experiment code is a spike: not defended, not smell-reviewed, not tested. What survives is the
`EXPERIMENTS.md` entry and the decision it justifies. An algorithm comparison measures code
that exists, so its apparatus is scaffolding — run it outside the repository and discard it,
recording `discarded` in the entry. A *model* of something not yet built is kept instead, in
`experiments/` at the project root. Never in `.yaait/`, which holds prose the gates parse.
`METHODOLOGY.md` §6.

### The failure mode here is yours

You will reach for the sophisticated algorithm. A red-black tree where a sorted list of twenty
items is faster; a trie where a dict is fine; an LRU cache on something called four times. The
corpus is full of algorithm tutorials and nearly empty of "I just used a list", so the
impressive answer is the fluent one.

The check is arithmetic, not taste: **state N.** At N=20 the constant factors dominate and the
asymptotically better structure frequently loses. If you cannot say what N is, you are not
ready to choose, and the honest move is to ask.

Also state the **format shape** here if anything is persisted — what fields, what invariants,
what is required versus optional. That is design. Which *serialization technology* carries it
(JSON, msgpack, sqlite) is a `yaait:tech` decision.

## Step 4b — If you are taking on debt deliberately, box it

Sometimes the right design decision is a known compromise: the simple thing now, the correct
thing later. That is legitimate, and two conditions make it a managed debt rather than a loss.

**Name the boundary before you write the shortcut.** One function, one class, one module. The
point is not tidiness — it is that repayment has a known edge. A litter box works because the
mess has a boundary, not because the cat improved.

- Nothing outside the boundary may depend on the shortcut's shape. The moment a caller knows
  the index is a dict, the boundary has failed and the debt has spread.
- Record it in `TECH_DEBT.md` with `contained behind <boundary>`, and record the honest
  opposite when it applies: `spread across <N call sites>`.
- Contained debt has a bounded repayment cost. Spread debt has an unbounded one, which is a
  longer way of saying it will never be repaid.

**This is the one legitimate single-implementation abstraction**, and Step 4's rule would
otherwise delete it. A litter box boundary has exactly one implementation by construction. It
survives because its justification is not a hypothetical second variant but a **dated
intention to replace the first**, recorded in `TECH_DEBT.md` — which is a named event in the
sense Step 4 requires. When the debt is paid, the exemption expires: if the boundary then has
one implementation and nothing behind it, Step 4 applies again and it should go.

## Step 4c — Refactorings: name them here

When the TTB changes the shape of code that already exists, name the refactorings that get
from the current shape to the target shape — Extract Function, Move Method, Replace
Conditional with Polymorphism, Introduce Parameter Object, Inline Function, and the rest of
the catalogue. `yaait:code` applies them one at a time and says which one it is applying.

Tell the user what each named refactoring does, and teach it where they do not know it, on the
same terms as any other design decision. That is the point of naming one rather than
describing a diff.

This is not a requirement to follow the catalogue by the book. Prefer a named refactoring
where one fits, name it, and say plainly when you are deliberately not using one. A balanced
application is the point; coverage of the vocabulary is not.

The reason it is worth stating: a named refactoring carries a behaviour-preservation contract
and an ad-hoc rewrite carries none. An unnamed rewrite mixes structural and behavioural change
in one diff, and afterwards nobody can say which of the two broke the test — or that behaviour
changed at all.

How far to extract is not settled here, and must not be. That is the open agenda in
`skills/code/references/review.md` §5.

## Step 5 — The state diagram, and reconciling the two from Step 1c

The structure diagram and the primary sequence diagram were drawn at **Step 1c**. They are not
drawn again here. Two things happen instead.

**Produce a state diagram** (`stateDiagram-v2`) whenever anything has modes, phases or a
lifecycle. Do this even when it feels obvious. Most bugs live in state transitions, especially
the ones nobody drew, and the diagram is where a missing transition becomes visible rather than
becoming a defect. It is drawn here rather than at 1c because it depends on decisions Steps 2
through 4c only just settled. `references/mermaid.md` carries the two checks worth running on
it; the undrawn-transition check in particular is not something to do by eye.

**Then reconcile the 1c diagrams with what the steps since changed.** Components were renamed,
merged, deleted and moved between parts; the map has to move with them, in this step, before the
file is written. If diagram and prose disagree a reader believes the diagram, so a stale map is
worse than none. Say what changed since 1c — it is the cheapest record of what the elaboration
steps actually did.

Do not draw a diagram per component. Three diagrams a reader studies beat nine a reader
scrolls past.

## Step 6 — Run the smell check

Read `references/smells.md` and walk the design through the diagnostic chain: observe the
smell, name the antipattern, identify the violated principle, and that principle is the fix.

The reference has three parts you will use differently:

- **The classical taxonomy** (Martin's architectural smells, the antipatterns, SOLID,
  GRASP) — for the erosion failures.
- **The LLM-specific section** — for *your* failures. The classical taxonomy is aimed at
  code that decayed under schedule pressure over years. You do not fail that way. You fail
  toward premature, confident over-structure. Check this section against your own design
  before showing it to anyone; it is the part written about you.
- **The non-OO mappings** — if this design is Lua, C, or functional, the OO vocabulary
  needs translating or it will misfire and get ignored.

Report what you found in your own design, including what you removed. "I had a
`StorageBackend` interface with one implementation and deleted it" is worth more to the user
than a clean report.

This check is yours and it is not the last word. Step 7a runs the same question past a reader
that has not seen this conversation, precisely because you know why every element is here and
will grade the intention. Do not pre-empt it by softening what you report now.

## Step 7 — Write DESIGN.md

The order is the point. The document opens on the map and descends into the parts, because a
reader who meets `geometry` before they know there is a client and a server has to hold it in
mind unplaced. Detail before referent is the same defect in the artifact that front-loaded
questions are in the conversation.

**`Produced by:` is a record, not a gate.** Name the model you are, and its effort level if you
can see it; write `unknown` rather than guessing, since a wrong provenance line is worse than an
absent one. How well this gate obeys its own rules varies with the model running it — measured,
`README.md` — and a design that turns out wrong is read months later by someone who cannot
otherwise tell whether the method failed or the model did.

````markdown
# DESIGN — <TTB name>

> Pre-coding blueprint. Kept true: if the code contradicts this, one of them changes
> deliberately and the change is journalled.

Format: 3
Spec: .yaait/SPEC.md
Produced by: <the model that ran this gate, and its effort level if you know it>

## Overview

<what this system is and what it does, in one short paragraph a reader can hold>

## Parts

- **<part>** — <one line: what runs here, and where>
- **shared** — <the components both sides call, if any; a first-class part, not an exception>

## Structure

```mermaid
classDiagram
    namespace Server {
...
    }
```
<!-- or a flowchart over modules, where the units are not classes -->

## Components

### <Part>

#### <Name>
- **Responsible for:** <one sentence, no unrelated "and">
- **Owns:** <the data or resource it is authoritative for; a term coined here
  states what it ranges over>
- **Depends on:** <components, direction outward>

## Invariants

- **I-1 — <name>.** <something that must always be true, checkable against code>

## The design forbids

- <a move that is out of bounds, and why>

## <Primary flow name>

```mermaid
sequenceDiagram
...
```

## <Lifecycle name>          <!-- whenever anything has modes, phases or a lifecycle -->

```mermaid
stateDiagram-v2
...
```

<the transitions you did not draw, and what each does — see references/mermaid.md>

## Protocol and interfaces    <!-- whenever parts talk to each other -->

The message and call *shapes*. Which serialization technology carries them is `yaait:tech`'s.

- **<direction>** — <the messages or calls, and what each carries>
- **<what is deliberately absent from the interface, and why>**

## Decisions

### <what was decided>
- **Chose:** <the option taken>
- **Over:** <the alternative rejected, by its canonical name where it has one>
- **Why:** <what the chosen one buys here, stated as the problem before the name>

## Requirement coverage

| Requirement | Addressed by | How |
|---|---|---|
| S-007 | `Match`, `Board` | <one line> |

## Abstractions and their justification

| Abstraction | Concrete variants today | Named event adding another | Verdict |
|---|---|---|---|
| <name> | 2 | — | justified |
| <name> | 1 | Postgres, March 2026 | justified, expires |

## Algorithms and data structures

| Decision | Choice | Complexity at our N | N is | Settled by |
|---|---|---|---|---|
| <the choice> | <what> | O(1) lookup | ~400 | X-001 (measured) |

## Impact analysis  <!-- Maintenance TTB only -->

| Touched | Depends on it | Behaviour today | Out of reach |
|---|---|---|---|
| <file:function> | <callers, tests, formats> | <one line> | <what this cannot affect> |

## Refactorings applied

| Refactoring | Applied to | Why this one |
|---|---|---|
| Extract Function | <file:function> | <what it buys> |

## Constraints on the stack

- **Settled here** — <the slot TECH.md deferred>: <the decision, and what forced it>.
- **Required of the stack** — <what the stack must now be able to do, and which design
  element breaks if it cannot>.
- **Falsifier fired** — <the TECH.md decision this design contradicts, and which side is
  wrong>. Re-enter `yaait:tech`.

## Deliberately not abstracted

- <the thing you were tempted to generalize and did not, and why>

## Deliberate debt taken on here

- <the compromise> — contained behind `<boundary>`; recorded as D-00N in TECH_DEBT.md

## Requirements not addressed here

- <spec requirements this design does not cover, and where they are handled instead>
````

Five sections carry weight out of proportion to their length, and each fails in a specific way
if written carelessly.

**`## Parts` and the nesting under them** answer "what runs where" from the headings alone. A
flat list of components does not, however good each entry is, and the class diagram has to group
the same way or the two surfaces disagree — `references/mermaid.md` carries the `namespace` and
`box` conventions and the separator to use.

**`## Decisions`** holds the choices, where the rest of the document holds the outcomes. Three
kinds belong here and have nowhere else to go: patterns **adopted**, patterns **resembled and
deliberately not used**, and plain structural choices carrying no pattern name at all. Every
entry states the problem before it names anything. It is written **retrospectively, from the
decisions actually disclosed during the gate** — never as a menu to fill, because an empty
section creates pressure to invent entries, which is the pattern-name-driven design
`references/smells.md` forbids. When there were none: `None. Recorded so a later gate can tell
nothing-to-record from nobody-looked.`

**`## Requirement coverage`** is what makes the design checkable against `SPEC.md` rather than
merely consistent with it. `Requirements not addressed here` is its negative counterpart and
neither works alone: without the map, nothing catches a requirement that was silently dropped
instead of deliberately deferred.

**`## Constraints on the stack`** is the return channel to the gate that ran before this one.
`tech` decided the stack without having seen a design, so some of what it recorded is a bet
and some slots it deliberately left open — and this design is the first thing able to settle
either. Without this section that traffic goes into a component's prose, where the next
`yaait:tech` run will not find it. An empty section is a real answer: it says the design needed
nothing of the stack that the stack did not already offer.

**`## Deliberately not abstracted`** is not decoration. It is the record that the simple choice
was made on purpose rather than overlooked, and it is what stops a later session from "fixing"
it by adding the abstraction you rejected.

Sections whose condition does not hold are dropped, not left empty — a `Protocol and interfaces`
heading over nothing tells a reader the design is unfinished. The exception is the two that
carry a `None. Recorded so...` line, where the absence is itself the finding.

Write the file before seeking approval. The defense in Step 8 is where approval happens,
and a wrong design on disk is editable while a lost conversation is not.

## Step 7a — Run the independent check

Read `references/independent-check.md` and spawn a subagent with it as the brief. It receives
`DESIGN.md`, `SPEC.md`, `TECH_DEBT.md` and `DESIGN_GUIDELINE.md` where they exist, and **not
this conversation** — that is the entire mechanism, so do not summarise the discussion into
the brief as background.

It runs here, after the file exists, because a blind reader needs an artifact to read. Step 6
asked you to check your own design; this asks someone who does not know why you built it.

Then, and the reference file states these as rules because each one is a way the step
quietly stops working:

- **Show every finding verbatim.** You do not filter your own audit.
- **Rebut where you can, and put the rebuttal next to the finding.** You hold what the
  checker was denied: the conversation, the alternatives that were rejected, the constraint
  the user said out loud.
- **A rebuttal that lands is usually a spec defect.** If the second variant exists but only
  in the conversation, `SPEC.md` is what is wrong — apply the reconcile rule.
- **Disagreement is a discussion, not a verdict**, and it is the most useful thing this step
  produces: it means the artifact does not say what you assumed it said.
- **An overruled finding gets a `DECISION` entry** naming the element, the objection and why
  it was kept.

Findings that survive feed Step 8 — an element the checker flagged and the user kept is a
strong candidate for the abstraction that step requires you to probe.

## Step 7b — Check the diagrams against mermaid

`DESIGN.md` exists now, so the mermaid in it can be checked by mermaid instead of by eye.
Malformed mermaid reaches the reader as a code block full of text, which reads as an error in the
design rather than in the syntax — and the author never sees it, because the author reads the
source.

**The check is one command**, writing into a scratch directory and never into the project:

```bash
mmdc -i .yaait/DESIGN.md -o <scratch>/design.svg > <scratch>/mmdc.out 2> <scratch>/mmdc.err
```

**Exit 0 with empty stderr is the pass.** Anything else: read `mmdc.err`, fix the diagram in
`DESIGN.md`, run it again. Three things about how `mmdc` behaves, each of which otherwise costs a
round:

- **It reports one error per run, and not necessarily the first broken block.** Given two broken
  diagrams it named the second. Do not read "one error" as "one problem" — keep going until it
  exits 0.
- **A failing run writes no output at all**, not even for the blocks that were fine. There is no
  partial result to inspect.
- **The chart numbers in stdout do not follow document order**; the blocks are rendered
  concurrently. Find a reported error by its message and line number, not by counting `✅` lines.
- **Redirect stdout as well, not just stderr.** `mmdc` takes its colour setting from **stdout**
  and then applies it to stderr, so with stdout left on a terminal the error text arrives wrapped
  in ANSI escape codes. Neither `NO_COLOR=1` nor `--quiet` turns that off — only redirecting
  stdout does, which is what the command above is doing. If you are handed a stderr file that has
  them anyway, strip with `sed 's/\x1b\[[0-9;]*m//g'` rather than reading around them.

**If `mmdc` is not installed**, say so in one line, name the install — `npm i -g
@mermaid-js/mermaid-cli` — and close the step. It is optional and the gate does not stall on it.
Record in `DESIGN.md` that the diagrams were not machine-checked, because a later reader otherwise
cannot tell an unchecked diagram from a checked one.

**Do not install it yourself, and do not route around its absence** — no `npm i` into a temp
directory, no `npx`, no fetching it to run once. A machine without the tool is a machine whose
owner did not install it, and an unchecked diagram is the risk they chose; putting packages on
someone's disk to close your own step is not that choice being honoured. This is observed
behaviour, not a hypothesis: given this step and no `mmdc`, a gate created `/tmp/mnb-mmdc`, ran
`npm i @mermaid-js/mermaid-cli` and used the local binary — the check passed and nobody had agreed
to the install.

**What the command does not see.** A clean run is not a clean bill of health. Two known failures
pass it silently:

- A `;` in a **state transition** label truncates the label and scatters the remainder as new
  states. `mmdc` exits 0 and draws them. A measured case built **21 states where the design had
  six**, fifteen of them one-word garbage.
- A one-word colour-name `box` title — `box Gold` — is read as a background colour, and the title
  disappears. `mmdc` exits 0.

Both are covered by the label and naming rules in `references/mermaid.md`. The tool catches the
loud failures; those rules are why the silent ones do not ship.

**The specific trap, which has been walked into:** the measured design held both kinds of `;` at
once — one in a sequence message, five in state transitions. `mmdc` exited 1 and named the
sequence one. Fixing that single `;` made it exit 0 with empty stderr, while the state diagram it
had just passed still built twenty-one states for a design with six. **An error naming one `;` is
not a list of the semicolons in the file.** Fix all of them, then run it again.

## Step 7c — Hand it over, then tour it

**Hand the floor over before you probe anything.** Say the artifact is written and invite
questions, comments and objections. This is a real round, not a formality: a ping-pong with
someone who has depth, a short one with someone who has not, and either is legitimate. It ends
when the user says it ends.

What arrives here is not a confession of ignorance and is never recorded as one. A comment is a
`CHALLENGE` — the disputed point, both positions, what was agreed and why, no winner — plus a
`DECISION` where the artifact changes. A question you answer is `TAUGHT`.

**Then tour what the discussion did not cover.** Announce the route and what it skips before
you start, so the user can redirect it. Productive stops here: a component boundary, a
dependency direction you chose, an invariant from the code's side, an abstraction the spec did
not ask for — **and the diagrams themselves.** A diagram that omits something looks exactly
like one that is complete, which makes it the part you are least able to audit and the reviewer
most able to. One real run lost an entire read path that way while three prose stops walked
past it.

Three to five stops. Each is three things and no more:

1. **What this part does**, in the user's vocabulary.
2. **Why this shape and not the obvious alternative.**
3. **One ask, in the judgment form** — *"I think this is the fragile line here. Do you agree,
   and what would you do?"* — never a recall question, and never one you have already answered
   in the discussion.

**Offer to teach the underlying concepts, by name, at every stop.** This is not the fallback for
a user who cannot answer — it is half of what the tour is for, and the list of names is the
disclosure `METHODOLOGY.md` §3 calls sometimes the most useful output of the whole command. It
shows the user exactly which jargon they are about to approve. When they take it, explain it
against this artifact rather than in general, then ask a different question about the same
concept, and journal `TAUGHT`.

**A question mid-tour reopens the discussion**, then returns to the route. Discussion is not a
phase that closes; it is available throughout, and a tour that cannot be interrupted is a
lecture.

**What the discussion *established* is covered. What it merely *touched* is not** — otherwise
one superficial question immunises the riskiest thing in the artifact. Coverage decides between
candidates of equal weight; it never removes a load-bearing one from the pool. Tour that one
from an angle the discussion did not reach.

Close the tour by naming the categories you skipped, not an enumeration of them.

## Step 8 — Run the defense

The stops you toured in Step 7c are the elements; this step is how the asks are phrased,
what the options offer and what gets journalled. Do not select a second time.

Select 3–5 elements. For a design, **one of them must be an abstraction or component you
added that the spec did not ask for.** That is not a suggestion. Over-engineering hides
exactly there, and it is exactly where a user will nod along, because a well-named
abstraction reads as competence.

Other productive targets: the component boundary that would be most expensive to move; an
invariant, asked about from the code's side; a dependency direction you chose; the state
transition you drew that nobody mentioned.

Good design-level defense questions. **Each one opens with its kind and its anchor**, states
the stake, and ends on a single plain question — the label is not decoration here, it is what
tells the user this is the one kind of ask they can be wrong about:

- **Defending — `Store`.** Every component that writes goes through it today. Which components
  would you change to add a second storage backend?
- **Defending — the renderer prohibition.** The design forbids the renderer from mutating game
  state. Which part of this structure stops it?
- **Defending — `MoveValidator`.** I added it separately from `Board`; the spec did not ask for
  it. What breaks if the two are merged?
- **Defending — the save ordering.** This sequence assumes the save finishes before the next
  move is accepted. What happens if it does not?
- **Defending — `paused` to `ended`.** Nobody asked for that transition; I drew it. Which
  invariant does it threaten?

Note what none of them do: use a word the user has not been given, or join two questions with
"and". Both are cheap to write and both cost the answer.

Then journal: `APPROVAL`, `DEBT`, `CHALLENGE`, and a `DECISION` entry for each structural
choice with a rejected alternative.

## Step 9 — Close

Say whether `yaait:tech` is still needed, then stop. Do not start writing code; that is
`yaait:code`, one increment at a time.

If the design revealed that the spec is wrong — which happens, and is the design phase
doing its job — apply the reconcile rule: name it, fix `SPEC.md`, journal the change. A
design that quietly satisfies a requirement the spec does not actually state has moved the
invention problem one artifact downstream.

**The user has the last word.** If they look at what was produced and object, that is a new
round rather than a failed gate — seeing the design is exactly the new information a
discussion is meant to respond to. Reopen, fix, and journal it. What does not reopen the
discussion is a position already recorded being repeated.
