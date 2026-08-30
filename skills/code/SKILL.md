---
name: code
description: >
  Build one increment of the thing to build — a single component or slice — with its tests,
  then review it and make the user defend it before it is accepted. Enforces yaait's hardest
  rule: if the increment touches existing code, the user must be able to say what that code
  does BEFORE it changes, which is what stops "I don't understand this, I'll just add a
  flag" from generating debt. Traces the increment back to SPEC.md and DESIGN.md and applies
  the reconcile rule in both directions when they disagree with reality. Reviews against
  code-level smells and the patterns measured to have grown under AI assistance —
  duplication, copy-paste, error masking, reimplementing what already exists. Use whenever
  the user runs /yaait:code, or says things like "let's implement this", "write the next
  piece", "build the board class", "add tests for this", "now code it". Also use it for
  changes to existing or legacy code under yaait, which is where the defend-before-you-modify
  rule does the most work.
---

# yaait:code — one increment, defended

## Scope: one increment per invocation

An increment is **one component, or one coherent slice of behaviour** — something whose
tests can pass on their own and whose defense fits in a few questions.

Not the whole TTB. That is deliberate, and the reason is not ceremony, it is the opposite:
a defense over an entire codebase becomes a wall of questions, gets skipped, and then the
gate protects nothing. Small increments keep each defense short enough to actually happen,
and keep errors from compounding for an hour before anyone looks.

If the user asks for everything at once, say what you are doing and why, propose the
increment order from `DESIGN.md`, and start with the first. If they insist on the whole
thing, do it — it is their call — but say once that the defense will be sampled rather than
thorough, so nobody is under the impression the gate ran at full strength.

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
    ├── DESIGN.md     optional: components, invariants, diagrams
    ├── TECH.md       optional: the stack, with verified versions and falsifiers
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

## Step 0 — Read upstream, and pick the increment

Read `.yaait/SPEC.md`, `.yaait/DESIGN.md` and `.yaait/TECH.md` if they exist, plus recent
`JOURNAL.md` entries — a previous increment may have created debt or a known contradiction
that this one inherits.

If there is no spec, say so and offer `yaait:spec`. You can proceed without one if the user
insists, but say what is being given up: without acceptance criteria there is nothing for
`yaait:stest` to trace against, so "done" will be a matter of opinion. If they proceed
anyway, append a `DECISION` saying so. A gate that was offered and declined and a gate that
nobody ever mentioned leave exactly the same silence in the record, and only one of the two
is worth knowing about later.

If there is a spec, **check its `Gates recommended` section against what is actually on
disk.** Where it recommends `yaait:design` and no `DESIGN.md` exists, or recommends
`yaait:tech` and no `TECH.md` exists, name the criterion that fired and ask whether to run
that gate before this increment. If the user proceeds without it, append a `DECISION`
carrying the recommendation, the criterion and the choice — this is the only point at which
a gate skipped silently in some earlier session becomes visible at all. A spec written
before this section existed does not have one: say that once and continue, rather than
reading its absence as nothing having been recommended.

Read `CODING_GUIDELINE.md` at the project root if it exists. It settles the questions the
review criteria deliberately leave open, and once settled they are constraints rather than
choices — you do not re-decide them per increment, and you do not quietly deviate. A
deliberate deviation is debt: box it and record it.

If guidelines came with the invocation, restate what you understood and treat them like any
other guideline — discussed, not merely obeyed. Where they contradict `CODING_GUIDELINE.md`,
the invocation wins for this increment and you say so out loud; if the same instruction
arrives a second time, offer to write it into the file.

State which increment you are doing and which requirement IDs it serves, in one line, before
you touch anything.

## Step 0a — Check this increment against TECH_DEBT.md

Skip this on a **Greenfield** TTB with no `TECH_DEBT.md` yet — there is no prior state to
check against. Otherwise read the file and ask one question: **did existing debt make this
increment cost more?**

It arrives in two shapes, and both end in the same place.

**A defect that traces to a debt item.** Often one will: debt does not cause bugs in the
abstract, it causes them one at a time, and this is one.

**Work that is materially harder because of a debt item.** Not "would this be nicer if the
code were better" — that is always true and therefore says nothing. Materially harder means
you have to special-case something, thread a change through places that should not know about
it, or work around a shape that is wrong.

In either case, append a receipt to that item's **interest** section — the date, the work, and
the mechanism in one line:

```
- 2026-08-29 · fix F-014 (frame drops at 40+ moves) traced here: full-state write on the
  render path.
```

This is the most valuable thing this command does for the codebase's long-term health, and it
takes one line. An estimated cost is arguable; a list of dated receipts is not, and it is what
someone holding a budget can act on.

**A receipt records what happened, never what you intend to do.** Write the trace now — the
work, the date, the mechanism — because that is already true. Do not write the mitigation
until the increment actually closes and the code exists, and then write what shipped rather
than what was planned. Recording an intention as an accomplishment corrupts the one artifact
whose entire value is being evidence, and it does it in the most damaging possible way: the
item now looks partly addressed, so the next reader discounts it. If the increment ends
without the fix landing, the receipt still stands on its own — the trace was real.

**When the work was materially harder, also file a `ROADMAP.md` item for the repayment** —
noting the multiplier if you can ("roughly 2x estimate") — and then continue with the
increment.

Do **not** stop to pay it. That is deliberate: interrupting the increment to refactor is how
one feature becomes three days, and the finding is worth capturing while the interruption is
not. The receipt plus the roadmap item is the mechanism; stopping is not.

If the work reveals debt that was **not** recorded, add the item now — with `Deliberate? No`,
which is the honest answer for debt discovered rather than chosen.

If an item has now accumulated several receipts, say so and suggest `/yaait:debt` — recurrent
debt has usually stopped being a code-quality issue and become something else, and that
command is where the escalation gets decided.

## Step 1 — Defend the code you are about to modify

**This is the hardest rule in yaait and the one that actually attacks technical debt.**

If this increment touches code that already exists — yours from a previous increment, or
legacy nobody has read in years — then **before changing it**, ask the user to say what it
does. Not to approve the change. To describe the current behaviour.

Why this, and why first: the dominant debt-generating pattern in software is not bad code,
it is **modifying code you do not understand**. It always produces the same shape — an extra
flag, another branch, one more null check, a special case guarding the case you were afraid
of — because that is the only safe-looking change available to someone who cannot see the
whole. Every one of those is locally reasonable and collectively fatal. Lava Flow is made
entirely of them.

You are unusually good at producing that change, convincingly, at speed. So the gate goes
before the edit, not after.

**Start from the impact analysis** if `DESIGN.md` has one — for a Maintenance TTB it does, and
it already names what this change touches, what depends on it and what the behaviour there is
today. Ask about those boundaries rather than rediscovering them, and if the recorded
behaviour disagrees with the code, that is the reconcile rule firing, not a detail to patch
around. If there is no impact analysis and the increment reaches outside its own module, say
so — the design phase was skipped on a judgement that has now turned out to be wrong.

How to run it, keeping it cheap:

- Ask about the **specific** thing you are about to change, not the whole file. One question
  per unit you touch.
- Ask for behaviour, not structure: *"what does this function do when the cache is cold?"*,
  *"why does this retry three times and not once?"*, *"what is this early return protecting
  against?"*
- If the user does not know, **do not treat that as a failure** — most legacy code is
  undocumented and unread, which is the normal condition. Offer the same options as any
  defense: `I'll explain it` / `Explain <concept>` / `Show me where this bites` /
  `Record as debt and move on`. When they ask, read the code and explain it, then re-probe
  briefly.
- If it is declined, write the `DEBT` entry **and say plainly what the risk now is**: you are
  about to modify code neither of you can describe, so the failure mode is a silent
  behavioural change in something that has a caller you have not looked at.

One question per touched unit. This is a gate, not an archaeology project.

## Step 2 — Check that the increment still matches the design

Before writing, confirm the increment is buildable as designed. If it is not — the interface
does not work, the invariant cannot be maintained, the library does not behave as `TECH.md`
assumed — **apply the reconcile rule now**, before there is code arguing for itself.

Name the contradiction, say which side you think is wrong, fix that side, journal it. Both
directions are legitimate: sometimes the code must conform, sometimes `DESIGN.md` was wrong
and gets rewritten. What is never legitimate is building the thing that works and leaving
the design describing the thing that does not.

**The diagrams are part of the document.** When you rewrite `DESIGN.md`, update its mermaid
class, sequence and state diagrams to match. A diagram that no longer describes the code is a
contradiction, not a cosmetic lag, and it is the one most likely to be skipped: editing a
sentence is cheap and redrawing a diagram is work. It is also the most damaging kind of drift,
because a diagram is the most authoritative-looking artifact in `.yaait/` and the first thing
a new reader trusts. If a transition disappeared from the state machine, delete it from the
state diagram in the same edit. A redrawn label obeys the same constraint as a written one —
keep punctuation out of it; the rule and its failure modes are in
`skills/design/references/mermaid.md`.

Watch specifically for **sedimentary interface** here, because increment-by-increment work
is what produces it: if this increment's natural move is to add one more optional parameter
or one more special case to an existing signature, stop. No single addition is unreasonable;
after six the signature is unreadable and nobody chose it. That is a design change, so make
it in `DESIGN.md` deliberately.

## Step 3 — Write the code

Follow `DESIGN.md`: its components, its invariants, and its **prohibitions** — the "design
forbids" section is not advisory. Follow `TECH.md`'s versions and noted deprecations. Match
the surrounding code's conventions over your own preferences; a file with two styles is worse
than a file with a style you would not have picked.

**The decisions you make here run the loop too.** Writing code is not a decision-free
activity: which idiom, which error strategy, which data structure the design left open, which
test framework if this is the first increment and `TECH.md` does not say. Each of those runs
the five steps at the weight it deserves — one line for the obvious ones, a real round where
there are real alternatives or a concept the user has not demonstrated.

Keep it distinct from Step 6. The loop here is per decision, as you make it. Step 6 is the
artifact-scale defense over the finished increment, and it samples. Anything decided silently
now is not covered by either.

Two things to write down as you go, because they are the input to Step 6:

- Every place you made a judgment call the design did not dictate.
- Every place you were tempted to abstract and did not, or did.

**Name the refactoring you are applying.** If `DESIGN.md` named refactorings for this
increment, apply them one at a time and say which one each step is — Extract Function, Move
Method, Inline Function, and the rest. Where you are deliberately not using a named
refactoring, say that too.

The point is not vocabulary. A named refactoring carries a behaviour-preservation contract, so
naming it is a claim the tests can check; an ad-hoc rewrite mixes structural and behavioural
change in one diff and afterwards nobody can say which of the two broke the test. Do not
combine a refactoring with a behaviour change in the same step.

### If this increment takes on debt, box it

Sometimes the right call inside an increment is the simple thing now. That is legitimate, on
two conditions.

**Contain it before you write it.** One function, one class, one module — so nothing outside
depends on the shortcut's shape and repayment has a known edge. A litter box works because the
mess has a boundary, not because the cat improved. Then record it in `TECH_DEBT.md` with
`contained behind <boundary>`, or honestly as `spread across <N call sites>` when that is what
happened.

This is the one place where an abstraction with a single implementation is correct: its
justification is a dated intention to replace it, not a hypothetical second variant.

### Build only what the increment requires

No gold plating. Every element you add should trace to a requirement in `SPEC.md` or a
component in `DESIGN.md`. The extra parameter for flexibility nobody asked for, the second
code path for a case that does not exist, the config option with one value, the `delete`
because there is a `create` — all of it is cost with no requirement behind it, and all of it
is much easier to add now than to remove later.

If you think something is missing from the design, say so and let it be a design change. Do
not fix it silently in the code; that is how the design becomes a lie.

## Step 4 — Tests

Choose the framework from `TECH.md`, or pick one and record the decision if this is the first
increment.

- **At least one test per acceptance criterion** the increment claims to satisfy. Name the
  requirement ID in the test name or a comment, so `yaait:stest` can trace it.
- **Every test must be able to fail.** A test that cannot fail is decoration, and it is worse
  than no test because it reports safety. Sanity check: mentally break the code and confirm
  the test notices. If it would still pass, it is asserting something the code does not
  control.
- **Test the invariants from `DESIGN.md`**, not only the happy path. Those are the properties
  the whole design rests on, and they are what a future change will violate.
- **State what is not tested**, explicitly, at the end. Untested surface named is useful;
  untested surface unnamed is a false sense of coverage.
- **Do not modify or delete an existing test** unless `SPEC.md` says the behaviour it encodes
  is changing. If the spec does not say that, the reconcile rule is firing: either the spec is
  incomplete or this change is wrong, and you decide which out loud before touching the test.
  Adding tests is unrestricted; changing a passing one is a behavioural decision.

That last one is about your failure mode specifically. Asked to add behaviour you will edit an
existing assertion until the new code passes, and the diff will look like progress — but a
suite rewritten to fit the change is evidence of nothing. `METHODOLOGY.md` §7.

Resist generating many near-identical tests. Coverage of *cases* is what matters, and twelve
tests of one case with different numbers is duplication with a green tick.

## Step 5 — Review what you just wrote

Read `references/review.md` and run it against your own diff before showing it to the user.

Report what you found and what you changed. Finding nothing is a possible and legitimate
outcome; claiming to have reviewed without saying what you looked for is not.

## Step 5a — Hand it over, then tour it

**Hand the floor over before you probe anything.** Say the artifact is written and invite
questions, comments and objections. This is a real round, not a formality: a ping-pong with
someone who has depth, a short one with someone who has not, and either is legitimate. It ends
when the user says it ends.

What arrives here is not a confession of ignorance and is never recorded as one. A comment is a
`CHALLENGE` — the disputed point, both positions, what was agreed and why, no winner — plus a
`DECISION` where the artifact changes. A question you answer is `TAUGHT`.

**Then tour what the discussion did not cover.** Announce the route and what it skips before
you start, so the user can redirect it. Productive stops here: what this increment changed in
existing code and why this shape, the error paths, and the test you did not write. Tour the
diff, not the file.

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

## Step 6 — Run the defense

The stops you toured in Step 5a are the elements; this step is how the asks are phrased,
what the options offer and what gets journalled. Do not select a second time.

3–5 snippets from this increment. Select by the criteria in `METHODOLOGY.md` §3, and remember the third
one is the important one: pick the code that **looks fine**. Anything visibly hairy already
attracts scrutiny.

The most productive targets in code, in rough order:

1. A judgment call the design did not dictate — where you chose.
2. The line that enforces an invariant, asked about from the invariant's side.
3. An error path, which is the code least likely to have been read and most likely to be
   wrong.
4. Anything concurrent, ordered, or timing-dependent.
5. The abstraction you added that the design did not ask for.

Good code-level defense questions. **Each one opens with its kind and its anchor**, states the
stake, and ends on a single plain question — the label is what tells the user this is the one
kind of ask they can be wrong about:

- **Defending — `apply`.** It writes four fields. Which line stops the board being left
  half-updated if it throws?
- **Defending — the return path.** What input makes this function return a wrong answer instead
  of raising?
- **Defending — the shared handler.** It is called from the render loop and from the network
  handler. What happens if both arrive in the same tick?
- **Defending — the renderer prohibition.** `DESIGN.md` says the renderer never mutates state.
  What in this code prevents it?
- **Defending — the save failure path.** The write can fail here. What does the player see?
- **Defending — the retry count.** It is three, not one and not ten. What failure is that
  number shaped around?

Note what none of them do: use a word the user has not been given, or join two questions with
"and". Both are cheap to write and both cost the answer.

Then journal: `APPROVAL` for what was defended, `DEBT` for what was not, `CHALLENGE` for
anything argued about, `DECISION` for judgment calls with rejected alternatives.

## Step 7 — Close the increment

Report, briefly:

- what was built, and which requirement IDs it serves;
- test results — **actual output**, and if something fails, say so plainly with the failure
  rather than describing the intent;
- what is not tested;
- any `DEBT` recorded, and what it means in practice;
- any `TECH_DEBT.md` receipt appended, or debt item added, and any `ROADMAP.md` item filed —
  and if a receipt from Step 0a predicted a mitigation, update it now to say what actually
  shipped, or remove the prediction if nothing did;
- the next increment from `DESIGN.md`.

**The user has the last word.** An objection after they have seen the increment is a new
round, not a failed gate — reading the code is new information. Reopen it, fix what needs
fixing, and journal it. A position already recorded being restated is not new information.

Then stop. One increment per invocation is the whole point; do not roll straight into the
next one unless asked.

When every increment is done, suggest `yaait:stest`. Say plainly if some acceptance criteria
are not yet covered by any increment — that is the most useful thing you can say at this
point, and it is invisible unless someone checks the spec against the code.
