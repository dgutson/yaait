---
name: stest
description: >
  Run a system or integration test of the whole thing to build, traced clause by clause
  against SPEC.md's acceptance criteria, and produce a verdict that says explicitly what was
  NOT tested. The user observes the critical path themselves rather than being told it
  passed, because a final gate where the LLM grades its own homework leaves the human
  accountable for something they never witnessed. Any acceptance criterion that turns out to
  be untestable is treated as a spec defect and sent back to /yaait:spec.
disable-model-invocation: true
---

# yaait:stest — does it do what we said it would

## Why this command exists, and why it works differently

Unit tests answer "does this component behave as I intended". They cannot answer "did we
build the thing we specified", because they were written by the same reasoning that wrote the
code, from the same understanding, including the same misunderstanding. A misread requirement
produces a matching implementation and a matching test, all three agreeing, all three wrong.

So this gate traces against `SPEC.md` rather than against the code, and it has one rule that
none of the other commands have:

> **The user observes the critical path themselves.**

Not because automation is untrustworthy, but because of what accountability means. If the
final gate is a test suite you ran and a summary you wrote, then the user is accountable for
a result they never witnessed — and the whole methodology collapses at its last step into
exactly the arrangement it was built to prevent. Someone has to *see the thing work*.

For everything else — the long tail, the edge cases, the regression surface — automate
freely. It is the critical path specifically that a human has to lay eyes on.

## The rules that are the method

These hold for the whole of this command. The long form, with reasoning, is in
`METHODOLOGY.md` at the plugin root — read it if a rule seems wrong or a situation is not
covered here.

### The loop: educate, discuss, agree, implement, verify

Every decision runs those five steps — `educate` only where the user does not already have the
concept. This is per **decision**, not per artifact: a command that discloses only its finished
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
an undisclosed one, and nobody can stand behind at the end what they never saw being chosen. But the
opposite error kills the method outright: run the full loop on every identifier and the user
stops invoking the command, and then there is no record at all.

**Use a canonical name where one exists** — a pattern, a named refactoring, an idiom, an
algorithm — and teach it, because a name compresses a contract. Where there is none, describe
the mechanism and say it has no name. Never invent one: an invented name carries a catalogue
entry's authority and none of its contract.

**Agree is a write.** An agreement that exists only in the conversation has not happened.

**Verify has two halves.** *Conformance* — say what you built and how it differs from what was
agreed; differences are normal, silent ones are not. *Disclosure* — one ask, and only where the
loop ran at full weight, so a human rules on the call instead of inheriting it. The review below
is the artifact-scale form of this; do not run it per decision.

**The user has the last word, and verification is not terminal.** Seeing the thing built is
new information, so an objection after verify opens a new round. Repetition is not new
information — point at the record and carry on.

The rules that follow are this loop's hardest steps in detail: who to ask, how to discuss, how
to say what kind of answer you need, how to review it, how to deliver it without a wall of text,
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
manufacture disagreement to seem rigorous — objecting on schedule is the same failure as
agreeing on schedule, and it destroys itself, because the user learns to discount all of it
and that removes the one signal this method runs on. When their argument changes the outcome,
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

Nobody can tell a challenge from a confirmation from a question about a call you already made
unless you say which it is. When they cannot tell, they answer the one they guessed, you record
it as an answer to the one you asked, and the artifact then reads as settled on grounds nobody
examined.

So open every ask with its kind — `**Deciding — S-011.**`, and the same for the other three.
They differ in what a correct answer looks like:

- **Deciding** — the choice is open and you have no position. Whatever they say becomes the
  artifact, and "either one, you pick" is a complete answer.
- **Checking** — you believe something and want it confirmed or corrected. Silence means yes.
- **Challenging** — you think something is wrong; the failure mode, who it hurts and what it
  costs follow, and their argument can change the outcome.
- **Reviewing** — you already chose, the artifact already says so, and you are showing the work
  so it can be overruled. A correct answer is a judgment about the call. Asking to have it
  explained is free.

**In none of the four can the user be wrong. What can be wrong is the artifact.** Until 0.20.0
the fourth kind was called `Defending`, and a wrong answer to it was written into the journal as
a fact about a named person. That is gone. What carries a cost now is the record: a call nobody
rules on becomes a `DEBT` entry against the call.

`Deciding` and `Reviewing` are close, and the difference is worth keeping. `Deciding` means you
have no stake in the answer. `Reviewing` means you already chose and are showing your work. A
user who cannot tell them apart does not know whether they are being consulted or being shown
something.

**The keyword goes at the front of the question text, never in a picker's header.** A header
holds roughly a dozen characters and cannot carry both the kind and the identifier; forced to
choose, a run keeps the identifier and the kind vanishes silently. That has happened — an ask
shipped as `I-12 — the client draws ships from offsets the server sent…` and the user could not
tell whether they were being tested, consulted or asked for their opinion.

**Teach the keyword the first time you use it.** These four are terms out of `METHODOLOGY.md`,
which the user has not read, so a bare label is a word only one of you knows. One clause covers
it: asking you to explain anything is free, and nothing here is a test.

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
  of asks rather than splitting them from their escape hatch across two turns. Four stops the
  user can navigate are worth more than five they cannot.

### The review: show the call, say what it costs, ask them to rule

**Hand the floor over first.** Say the artifact is written and invite questions, comments and
objections. This is a real round, not a formality, and it ends when the user says it ends. What
arrives here is not a confession of ignorance and is never recorded as one: a comment is a
`CHALLENGE`, a question you answer is `TAUGHT`.

**Then walk them through what their review did not reach.** Announce the route and what it skips
before you start, so they can redirect it. Pick **3–5** elements. The limit is hard, because what
kills this methodology is not bad advice, it is tedium, and a skipped gate protects nothing.
Choose by:

1. **Expensive to reverse** — a schema, a public interface, a persisted format, a
   concurrency decision, anything that will have callers.
2. **A judgment call the upstream artifact did not dictate** — where you chose rather than
   followed. The user has no idea they are inheriting these.
3. **Plausible enough that a non-expert would agree without looking.** The important one. Do
   not pick the part that looks alarming; pick the part that *looks fine*. Visibly messy code
   already gets attention — the defect that ships is the one that reads naturally.

Add one more: **whatever you are least sure of**, and say that is why it is there. It is the stop
most likely to return something.

**This is one step, not two.** The stops are the asks. Never walk the user through an element and
then ask a question about that same element in a second round: that turns the walk-through into
material to be studied before a test, and it is the failure this section exists to prevent.

Each stop is four things and no more:

1. **What this part does**, in the user's vocabulary.
2. **Why this shape and not the obvious alternative.**
3. **What it costs if it is wrong** — stated by you, concretely.
4. **One call, put to them.**

**Never ask the user for a fact you already have.** You wrote the artifact; you know which line
stops the balance going negative. Asking for it back is an examination, and it examines the wrong
party — `METHODOLOGY.md` §13 says the author is not the auditor. State the fact, then ask for the
judgment only they can give:

- Not *"which line stops `balance` going negative?"* but *"one line in `apply` stops `balance`
  going negative. Given who calls this, is one line where you want that check?"*
- Not *"what happens if two processes write at once?"* but *"SQLite serialises writers, so the
  second process gets `SQLITE_BUSY` and its write is lost. Are we ever running two?"*

Both are equally hard to answer without the model: someone who does not have it cannot choose
between the options, and will say so or ask. The difference is which of you is being assessed.

Then offer the options, generated from the artifact. Where the stop has a real fork, the branches
of that fork **are** the options. Where it does not:

- `Give my view` — first, always.
- `Explain <concept>` — one per concept you actually used and named. This is **not** a way out:
  §8 files `TAUGHT` deliberately apart from `DEBT`, because asking to be taught is the behaviour
  this method wants and recording it as a deficiency is how you stop people asking.
- `Show me what it costs`.
- `Keep what you wrote — your call` — the decision stays yours, and that is what the entry
  records. Never word this as *record as debt and move on*: that asks the user to volunteer that
  they are the source of a debt they did not create.

Drop a generic `I'll explain it` wherever named concept options exist; it is the same offer twice
and the slots are scarce.

**Name the answer path even when the instrument has a free-text slot**, because that slot is not
a visible answer. Where free text arrives through a generic `Other`, a list of exits above an
unlabelled `Other` reads as ways to avoid the question, and the user takes an exit they did not
need.

Options rather than prose for two reasons that both matter: choosing "Explain RAII" costs nothing
while typing "I don't know what RAII is" is a confession in writing, and naming the concepts
discloses exactly what jargon the user is about to approve.

Four outcomes, plus one thing that is deliberately not an outcome:

- **Ruled on** → `DECISION` where the artifact changes, `APPROVAL` where they kept what you
  wrote — recording *their* reason, not a mark. Say it is recorded and move on. Do not follow a
  decision with another question about it.
- **Their reasoning does not match the mechanism** → say so at once, concretely, against this
  artifact — *"that holds inside one process; these are separate processes, so the state is not
  shared"* — and let them decide again on the corrected picture. Where what they said should
  change the artifact, switch to a `Challenging` ask. **Nothing here is scored and there is no
  entry for it.** There used to be: an outcome called *answered wrongly* that wrote a `DEBT`
  entry naming a person's wrong answer. It put a fact about a person in a file about code, and
  it did not work — in the run that removed it, the gate could not tell a misread question from
  a misread mechanism. Correcting someone in the moment is what a colleague does, and it is
  harder to do once you have told them you are grading them.
- **Taught** → explain short and concrete, grounded in *this* artifact, then put a **different**
  question about the same concept back to them. Re-asking the original only tests whether they
  remember your answer. One extra round — a gate that becomes a course gets abandoned. Then a
  `TAUGHT` entry: it is the only record that a concept had to be supplied, and the same concept
  recurring across increments is the signal that it needs learning properly rather than
  explaining again.
- **Challenged** → the user comments, objects or proposes something else. Argue it honestly,
  concede what holds, and write a `CHALLENGE` entry recording the disputed point, both positions
  and **what was agreed and why** — plus a `DECISION` where the artifact changes. No outcome
  field, no winner. Say which kind of resolution it was: a **finding** (something was missing), a
  **clarification** (you meant different things), or a **changed position**. A comment that turns
  out to be a product question rather than a question about this artifact goes back to `spec`;
  filing it as `DEBT` records it against the wrong thing.
- **Not ruled on** → `DEBT` entry against **the decision**: what you chose, that no human ruled
  on it, and what it costs if it is wrong. It is not an entry about the user and it does not say
  they failed to understand anything. Declining is allowed. A blocking gate is weaker than it
  sounds: people route around blocks by not invoking the command, and then there is no record at
  all.

**Then say what you did not cover** — one line, in the round and in the entry: the categories you
passed over, not an enumeration. "Did not cover the error paths, the retry policy, or the
generated migration." Three to five stops is a small fraction of any increment, so without this
line everything unselected is unreviewed *and* unrecorded, which is the one state Manifesto
principle 4 forbids. `stest` Step 5 does the same for tests and calls it the reason anyone should
trust the rest of the report.

**Close by handing the asking back.** Ask what they want to look at. The handover at the start
catches what they noticed on first reading; this catches what the walk-through itself made them
think of, and it is where new material arrives — a requirement nobody mentioned, a constraint
that reframes the artifact. That is not an interruption; it is the gate working. Budget for it,
and re-run the steps it invalidates rather than filing the new material as an afterthought.

### Deliver it without a wall of text

A correct review that arrives as a wall fails as completely as no review, and in the same
way: the user skims, engages with nothing, and the gate did not happen. The delivery is part
of the mechanism.

- **Lead with the finding, not the process.** If one of the three-to-five matters more, say
  which and why in the first line rather than making the user derive the ranking.
- **Say which single question to answer** if they only answer one. Someone who answers one
  usually answers three.
- **Make each question self-contained** — quote the line, name the file. They should not have
  to re-open the artifact to parse the question.
- **Attach the stake in one clause**: "because a caller relies on this". Answering should
  feel worth it.
- **Four lines per stop, hard** — what it does, why this shape, what it costs if wrong, the
  call. One per thing the stop is made of. A stop that will not fit is too big for one call:
  split it or choose another. This is the cap that binds, and it replaces a stopwatch nobody
  could check. It was three lines until 0.20.0, listing three of the four things a stop
  carries, and a live run broke it at every stop — a cap that cannot be met makes the author
  choose which rule to break silently, and the cap is the one that goes.
- **One clause per sentence, and the question is a plain interrogative.** "Which of those two
  lines breaks, and what does the design instruct you to do then?" is two questions joined by
  `and`, which the one-question rule above already forbade. It happens anyway because the cap
  rewards compression, and compression is what produces subordinate clauses and rare verbs.
  **Density is not simplicity.** Four lines is a budget, not a target: split the sentence
  rather than shortening it.
- **Write literally. No metaphor, no idiom, no figure of speech.** Not "the reflex
  incantation", "load-bearing", "on trial", "the sign flipped". Say the mechanism instead: "the
  command people type out of habit", "this is the part that would break", "which of you is being
  assessed". A reader whose first language is not English spends their effort working out what
  the sentence means instead of judging the artifact, and the entry then records that a decision
  went unruled when what happened is that the question could not be parsed. Same rule as the next
  one, one scale up: that covers words they have not been taught, this covers sentences that mean
  something other than what they say.
- **No term the user has not been taught, and that includes inside the options.** A word like
  "isomorphic" arriving in a parenthesis turns a review stop into a vocabulary test, and the user
  then cannot parse a question whose subject they understand perfectly well. Teach the name in
  the same breath where it is needed; delete it where it is not.
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
    ├── JOURNAL.md    append-only: decisions, approvals, unruled calls, teaching,
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

**Two kinds of debt, and they do not overlap.** A `JOURNAL.md` `DEBT` entry records a *call
nobody ruled on* — you decided it, you put it to the user, and no human took a position; true
forever, never resolved. `TECH_DEBT.md` holds *structural* debt — the code has a deficiency; a
live balance that gets paid and removed. A run of unruled calls in one area is a leading
indicator of structural debt, and gets promoted when it turns out to be one. Full formats for
both root files are in `METHODOLOGY.md` §8.

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
- **The call:** what you chose, and that you chose it rather than following an upstream
  artifact.
- **Cost if wrong:** what actually breaks.
- **Ruled:** what the user decided, and their reason in their words.

### DEBT — no ruling: <what, and where>
- **Gate:** the command writing this entry.
- **The call:** the specific decision, and that it was yours.
- **Concept it rests on:** the term or technique behind it, where one had to be named.
- **What happened:** put to the user, who kept it without a view; or declined; or declined
  *with reasons* — and then state them, because a decline on sound project-specific grounds
  reads as a gap in six months unless the grounds are in the entry.
- **Cost if wrong:** what actually breaks.
- **No human has ruled on this.** Say who it was put to, so a later reader knows it was yours.

### TAUGHT — <concept>, at <artifact element>
- **Gate:** the command writing this entry.
- **Concept:** the name, as it would be looked up later.
- **Prompted by:** the stop that surfaced it.
- **Second angle:** the different question asked afterwards, and what the user said.

### CHALLENGE — <the disputed point>
- **Gate:** the command writing this entry.
- **My position:** and the failure mode it rested on.
- **Their position:**
- **Outcome:** who conceded and what they had got wrong — or, where neither did, that the
  argument was defeated and what the disputed thing rests on now instead.
- **Decided by:** who.
```

`DEBT` and `CHALLENGE` are the entries that make the file worth keeping. Anyone can log
decisions; logging which of them no human ever ruled on, and logging the arguments you lost,
is what makes the record honest enough to be useful in six months.

## Step 0 — Read the spec, not the code

Read `.yaait/SPEC.md`, and pull out every acceptance criterion with its requirement ID.
Read `JOURNAL.md` for `DEBT` entries — a decision nobody ruled on is where a defect is most
likely to be hiding, so it deserves extra attention here.

Read `DESIGN.md` for the invariants. An invariant that holds in unit tests and breaks under a
real end-to-end run is the classic integration defect and the thing this command is best
placed to find.

Deliberately read the spec **before** the implementation, and build the test list from it. If
you read the code first, you will test what it does. The point of this gate is to test what
it was supposed to do.

## Step 1 — Build the trace table

One row per acceptance criterion. Every criterion from `SPEC.md` appears — including the ones
you expect to fail, and the ones nobody implemented.

| Req | Criterion | How it is tested | Who observes | Result |
|---|---|---|---|---|
| S-001 | A full game can be played to win, loss and draw | manual, scripted below | user | |
| S-003 | A move to an occupied square is rejected, board unchanged | automated | automated | |
| S-004 | Killing the process mid-game resumes at the same position | manual | user | |
| S-006 | "It should feel responsive" | `[untestable]` | — | — |

Mark each criterion as **user-observed** or **automated**:

- **User-observed** — the primary flows, anything the user experiences directly, anything
  where "it worked" is a judgment rather than an assertion. Keep this list short enough that
  the user will actually do it: five to ten steps, not fifty.
- **Automated** — edge cases, error paths, the regression surface, anything tedious or
  repetitive.

If a criterion has **no test possible**, do not quietly drop it. See Step 4.

## Step 2 — Run the automated part, and report the actual output

Run it. Then report what happened, not what was supposed to happen.

If something fails: **say so plainly, with the output.** Do not describe the intent of the
failing test, do not summarize the failure as "a minor issue", and do not fix it silently and
report a pass. A failing system test is this command working correctly — it is the single most
valuable output it can produce, and burying it is the one thing that would make the whole
gate worthless.

If a test errors rather than fails, say which, because they mean different things: a failure
is information about the code, an error is often information about the test.

## Step 3 — Hand the critical path to the user

Write a script the user can follow without you. It must be concrete enough to execute and
specific enough that they know what "wrong" looks like:

```markdown
## Please run this yourself

1. Start it: `python -m game`
2. You should see: an empty 3×3 board, "X to move".
3. Click the centre square. → An X appears there, prompt changes to "O to move".
4. Click the same square again. → **Nothing happens.** The board does not change and no
   error appears. (This is S-003.)
5. Play on until X wins. → The banner reads "X wins" and further clicks do nothing.
6. Start a new game, play two moves, then kill the process (Ctrl-C).
7. Restart it. → The board shows your two moves and it is O's turn. (This is S-004.)

Tell me what you actually saw at each step, especially anywhere it differed.
```

Each step states **the expected observation**, not just the action. "Click the square" is not
a test; "click the square, an X appears there and the prompt changes" is.

Then **wait for what they report, and record that** — not your expectation of it. If they
skip steps, say which rows of the trace table are therefore unverified rather than marking
them passed. An unobserved row is unverified, and writing anything else in that cell is the
one falsification this command must not commit.

## Step 4 — Untestable criteria are spec defects

If an acceptance criterion cannot be tested, that is a **defect in the spec**, not a gap in
this command. It means `yaait:spec` accepted something unfalsifiable and nobody noticed until
now.

Say so, and offer to go back to `yaait:spec` to rewrite the criterion into something
observable. Journal it as a `DECISION`.

The exception is a criterion already marked `[untestable]` in the spec — aesthetics, feel,
"it should be fun". Those were flagged deliberately. Report them as untested rather than
passed, every time. A subjective criterion silently counted as satisfied is how a system test
comes to certify something nobody checked.

## Step 5 — Say what was not tested

**Mandatory section. It is the honest part of the report and the reason anyone should trust
the rest of it.**

Cover at least:

- Acceptance criteria with no test, and why.
- Code paths never exercised — error handling, timeouts, retries, resource exhaustion, the
  second and third branches of a condition.
- Everything only tested on one input, one platform, one screen size, one locale, one clock.
- Concurrency, ordering and timing, unless it was tested deliberately. It almost never is.
- Anything carrying a `DEBT` entry, since neither of you can currently reason about whether
  it is right.
- Scale. If it was tested with three records, say three records.

Write it as facts, not as apology. "Only tested on Linux with Python 3.12; never run with
more than one concurrent client; the save-corruption path is unexercised" is a useful
sentence. "Testing was not exhaustive" is not.

## Step 6 — The review: hand it over, then walk it

**Hand the floor over before you ask anything.** The report is written; invite questions,
comments and objections on it. A comment is a `CHALLENGE`, a question you answer is `TAUGHT`.

Then three to five stops. The productive targets here are different from the other commands,
because what is under review is the **verdict** rather than an artifact. Each stop states what
the verdict costs if it is wrong and ends on a call. **Each opens with its kind and its anchor:**

- **A criterion the user marked as passing.** `**Reviewing — AC-3.** You saw the board come
  back after the restart. That same screen appears if the move log saved and the turn counter
  did not, and the next move would then be played by the wrong player. Do you want a test that
  separates those two, or is watching it enough?`
- **An untested path that matters.** `**Reviewing — the corrupt save path.** Nothing here
  exercised it. As written, a truncated file raises inside the load and the process exits with
  a stack trace. Is that acceptable for now, or does it need a message and a clean exit?`
- **A `DEBT` entry that survived into the shipped system.** Name it, say what it now costs with
  the thing running, and ask whether it stays open or gets a `TECH_DEBT.md` item.
- **The gap between what the tests prove and what the spec claims.** The most useful stop in the
  command: `**Reviewing — the suite as a whole.** It passes, and the requirement it guarantees
  least is S-009: nothing here runs two clients at once, so every ordering claim is untested.
  Do you want that tested before this ships, or recorded as a known gap?`

Note what none of them do: ask the user for a fact the report already states, or join two
questions with "and".

Close by naming the categories you did not cover — Step 5 has already written most of that list
— then ask what they want to look at.

Journal `APPROVAL` for each call the user ruled on, `DEBT` for each one nobody ruled on, and
`CHALLENGE` as usual.

## Step 7 — The verdict

State one of three things, plainly:

- **Satisfies the spec** — every criterion traced, tested and observed. Say what is untested
  anyway.
- **Satisfies the spec with known gaps** — the usual honest outcome. List the gaps.
- **Does not satisfy the spec** — name which criteria failed and what it would take.

Do not average these into "mostly working". A verdict that cannot fail is worth as much as a
test that cannot fail.

Append the verdict to `JOURNAL.md`, including **who observed what** — that record is the
whole point:

```markdown
### STEST — <TTB name>, <date>
- **Verdict:** satisfies the spec with known gaps.
- **Automated:** 34 tests, 34 passed. Covers S-002, S-003, S-005, S-007.
- **User-observed:** Daniel ran the 7-step critical path; S-001 and S-004 confirmed by him.
- **Not tested:** S-006 (marked untestable in spec); corrupt-save path; anything concurrent;
  only Linux / Python 3.12; largest run was 3 saved games.
- **Outstanding debt:** the retry backoff in net/client.py is still nobody's call.
```

Then suggest `/yaait:debt` if any of these hold, since end of cycle is the natural moment for
it and nobody thinks to ask:

- any `TECH_DEBT.md` item gained a receipt during this cycle;
- an item has accumulated several receipts, which usually means it has stopped being a
  code-quality issue;
- a failure in this run traced to a known debt item;
- `TECH_DEBT.md` has items nobody has looked at in a long time, which are candidates for
  `won't fix` rather than perpetual guilt.

Then stop. If the verdict is anything other than clean, say which command comes next —
`yaait:code` for a fix, `yaait:spec` for a bad criterion, `yaait:design` if the failure is
structural rather than local.
