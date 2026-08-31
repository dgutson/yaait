---
name: tech
description: >
  Decide the technology stack for the thing to build — language, runtime, build,
  test framework, key libraries, deployment target — into a .yaait/TECH.md where every
  dependency carries a version that was actually verified against current documentation
  rather than recalled, plus a falsifier ("what would make this the wrong choice") and an
  exit cost. Built specifically against training-data staleness: the deprecated library, the
  superseded idiom, the API that was renamed, the package that was dominant at training
  time and is now unmaintained. Surveys what actually occupies each slot today, from live
  sources, BEFORE offering any option — verifying a shortlist you recalled cannot surface
  the option the shortlist never had. Presents every option with pros, cons, a recommendation
  and the reasoning behind it, and offers to teach any of it before you choose. Separates
  inherited constraints from real decisions, since you are only accountable for the latter,
  and takes your own stated stack and proficiency ("expert in C++, proficient in Python,
  newbie in Rust") as assertive input to be priced rather than tested. Use whenever the user
  runs /yaait:tech, or says things like "what should we build this in", "which framework",
  "pick a test library", "what database", "is this dependency still maintained", "should we
  use X or Y", "build it in C++ with Qt and ZeroMQ". Runs BEFORE yaait:design on a greenfield
  TTB, because the stack settles the paradigm and the four branch points design would
  otherwise decide against a stack nobody has named.
---

# yaait:tech — the stack, verified rather than recalled

## Why this command exists

Two reasons, and the first one is about you.

**You are out of date and you do not feel out of date.** Your sense of which library is
standard, which API shape is current, and which idiom is idiomatic was formed from a corpus
with a cutoff. Ecosystems move; your confidence does not decay with them. The failure is not
that you *guess* — it is that a stale recollection and a current fact are produced in
exactly the same confident register, so the user has no way to tell them apart. This command
exists to make you check instead of remember, and to say which you did.

**And the staleness is in the shortlist, not only in the versions on it.** Checking that the
three libraries you thought of are current cannot tell you about the fourth, which is the one
that did not exist when your corpus was cut. That check comes back clean, and every line of it
now carries a `verified` label — so a list assembled from memory ends up better dressed than
an honest guess. Step 2 goes and looks at the slot before any option reaches the user, for
this reason and only this reason.

**Second: the stack is usually a constraint, not a decision.** "It's a browser game" already
fixed a great deal. Treating a constraint as though it were chosen inflates the record with
things nobody decided and buries the two or three real choices inside a wall of
inevitabilities.

## When to run this

**Before `yaait:design`, on any greenfield TTB.** `design` stops and sends you here when
`TECH.md` is missing, because the four decisions it treats as its expensive-to-reverse ones
— decomposition into parts, the sync/async boundary, the persistence model, the concurrency
model — are largely settled by the stack. `METHODOLOGY.md` §1.

For a **Maintenance** TTB the order does not apply: the stack is already on disk. Run this
only when a specific layer is genuinely in play — a dependency being replaced, a runtime
being upgraded — and read the existing stack rather than re-deciding it.

If the stack is fully constrained and the constraints are sound, say so and skip this
command — but say it **out loud**, and let `SPEC.md`'s `Gates recommended` section carry the
skip. Running it anyway produces a document that looks like a decision record and is actually
a rubber stamp, which is worse than no document. Skipping it *silently* is worse still:
`design` cannot tell a stack that was examined and found closed from one nobody looked at,
and it will assume the second.

**What you settle here that the design has not seen yet is a decision, not a constraint.**
Running ahead of the design is what makes this command useful and is also its one new failure
mode: a broker picked off a traffic number arrives in `DESIGN.md` looking inherited, and §9
holds nobody accountable for constraints. Every choice carries a falsifier (Step 3) for
exactly this reason, and a design that fires one is the reconcile rule working, not a defect
in either gate. §4.

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
- **Three lines per stop, hard** — where it is, what it costs if wrong, the call. A stop that
  will not fit is too big for one call: split it or choose another. This is the cap that binds,
  and it replaces a stopwatch nobody could check.
- **One clause per sentence, and the question is a plain interrogative.** "Which of those two
  lines breaks, and what does the design instruct you to do then?" is two questions joined by
  `and`, which the one-question rule above already forbade. It happens anyway because the cap
  rewards compression, and compression is what produces subordinate clauses and rare verbs.
  **Density is not simplicity.** Three lines is a budget, not a target: split the sentence
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

## Step 0 — Read upstream

Read `.yaait/SPEC.md`, especially the **Constraints** section and the expected lifetime — a
weekend tool and a five-year service have different correct answers to every question below.

**If `.yaait/DESIGN.md` exists, this is a second pass**, and that changes what the run is for.
It is one of three things and you should say which: the design fired a falsifier on a choice
made here; the design settled something this file left under `## Deferred to design`; or the
TTB is Maintenance and the stack was always on disk. Read the design's `## Constraints on the
stack` section first — that is the design telling you what it now requires, and it is the
reason you were re-entered rather than a remark in passing. Where the design contradicts a
decision recorded here, that is the reconcile rule (§4): name the contradiction and say which
side is wrong before you change either.

## Step 1 — Separate constraints from decisions, again

`yaait:spec` asked once. Ask again with specifics, because people remember constraints when
they see the slot the constraint fills.

For each layer — language, runtime, build, test framework, key libraries, deployment target,
data store — establish whether it is:

- **Constrained**, and by what: the customer's environment, an existing codebase, team
  skills, a compliance requirement, a hard deadline. Record the source. Nobody is accountable
  for choosing it.
- **Open**, and therefore a decision that has to be made and put to the user here.

If a constraint is doing real damage, say so **once**, with the specific cost — "Python for a
16 ms frame budget means you will fight the GC, and here is roughly what that costs" — and
then respect it. Relitigating a constraint the user cannot change is not rigour, it is noise.

## Step 1a — Proficiency is an input, not a preference

Ask, per candidate ecosystem, where the user actually is: **expert**, **proficient**,
**novice**. Take the answer at face value — it is a fact about them, not a claim to be
challenged, and Step 1's rule against relitigating applies with more force here, not less.
Where they stated it up front and assertively ("expert in C++, proficient in Python, newbie
in Rust"), it is already answered; do not ask again.

**Why this is not a preference to be weighed against the others.** `yaait:code` will not pass
an increment until the user can say what the code it touches does. Choose an ecosystem they
are a novice in and that gate does not merely get harder — it degrades on every increment,
and it degrades *silently*, because the damage surfaces as a run of `DEBT` entries about
individual functions rather than as a stack decision anyone can point at. A stack the user
cannot read turns yaait into the unattended-LLM case the whole method exists to prevent. No
falsifier will ever fire on that, so it is priced here or it is not priced at all.

**It prices a choice; it does not veto one.** "Novice in Rust" does not forbid Rust. Say what
the review burden actually looks like — which idioms they would be approving without holding,
roughly how much of each review they would be taking on trust — and what would make it worth
paying: a hard requirement only that ecosystem meets, or a deliberate decision to learn it,
which is a legitimate goal and gets recorded as one rather than smuggled in as a technical
argument. Chosen anyway, it is a decision with a falsifier like any other, and `yaait:code`
will be doing more teaching per increment from here on. Say so now, so it is not a surprise
in three weeks.

This lands in `TECH.md` under `## Proficiency`, as its own section and **not** folded into
`## Constraints`. §9 holds nobody accountable for constraints, and this is something the user
said about themselves; the reader who needs it most is whoever is trying to interpret that run
of `DEBT` entries six months from now.

## Step 2 — Survey the slot before you offer anything

Step 2a verifies the things you were about to name. Necessary, and not sufficient: it checks
that a shortlist is current, and **a shortlist recalled from training data cannot be made
current by verifying it.** So before any option reaches the user, go and look at what occupies
the slot *now*.

**Which slots.** The ones that shape the design or sit close to a one-way door: language and
paradigm, runtime, concurrency model, deployment target, data store, transport or message
broker, UI toolkit. Cheap and reversible slots — test framework, formatter, logger, CLI parser
— are verified at Step 2a and not surveyed; surveying them is how this step turns into the
ceremony that gets the command skipped. **Say which you did to each.** `surveyed` and
`verified` are different claims and the user cannot tell them apart unless you separate them.

**Slots the user has already filled are surveyed too**, at the same threshold. `/yaait:tech
using C++ and Boost with Qt for the UI, I want ZeroMQ` names four things: transport and UI
toolkit get surveyed, Boost and the build system get verified. A stated stack is a set of
decisions arriving pre-made — §1, what an invocation may carry — so it is not exempt from the
loop, and it also does not need re-deciding. **Their pick stands unless the survey hands you a
failure mode with a cost.** "There is a newer thing" is not a failure mode. "Its own author
wrote the successor and the original takes security fixes only" is.

**From live sources.** The registry, the project's release page, its own current
documentation. Where the tools are unavailable or there is no network, **say the survey did
not happen** and mark the slot as unsurveyed. Recall presented as a survey is the exact defect
this command was built against, now wearing the label of the fix.

**Run it in a subagent where the harness allows one**, the same way Step 3a does. What comes
back is the comparison, not the pages.

### Then ask what discriminates

The survey is what makes a question worth asking: it names the axis that actually separates
the candidates. Ask about that axis and leave the rest alone — peak throughput and message
size if that is what split the transports, in-process or cross-host, the latency budget, the
expected lifetime, who deploys this and onto what.

Ask about **this** TTB in its own units. A generic infrastructure questionnaire is the worst
version of this step: a question whose answer moves nothing in the comparison is ceremony, and
it is expensive here because it arrives before the user has seen anything useful. Where
`SPEC.md` already answers one, read it there and say you did.

## Step 2a — Verify every version, do not recall it

This is the operational heart of the command.

For every dependency you are about to name:

1. **Check the current version and status** against the registry or the official docs — PyPI,
   npm, crates.io, Maven Central, the project's own release page. Use the tools you have; a
   web fetch or a `pip index`/`npm view` costs seconds.
2. **Check that it is still maintained.** Last release date, open-issue trend, whether the
   README now points somewhere else. A package that was the obvious choice three years ago
   may be archived with a successor named in its README.
3. **Check that the API you are assuming still exists.** This is the failure that costs the
   most, because it does not surface until code is written: the method was renamed, the
   argument became keyword-only, the sync API was replaced by an async one, the class-based
   interface is now functions.
4. **Note the deprecations** that affect the way you were about to use it.

Then **label what you did**, per the confidence rule in `METHODOLOGY.md` §2, using exactly these words
so the user can scan for the weak ones:

- `verified` — I checked the current documentation or registry in this session.
- `recalled` — I am going from memory and have not checked.
- `inferred` — I am reasoning from a related fact.

**Any dependency still marked `recalled` when you write `TECH.md` is a defect in this
command.** If a check is genuinely impossible — no network, a private registry — say so
explicitly next to the entry rather than letting `recalled` pass silently as fact.

Those three answer *is this choice current*. `surveyed` from Step 2 answers a different
question — *was anything else considered* — and the two do not substitute for each other. A
`verified` entry that was never surveyed is a current answer to a question nobody asked
properly, and that is the more common of the two failures.

## Step 2b — Present the options as an education, not a menu

For every slot the user left empty, and every slot where the survey brought back a real
competitor to what they named, give them three things together:

- **The options, with pros and cons in the units of this TTB** — not in general. "Faster" is
  not a con anyone can act on. "Roughly 3× the throughput at your message size, and you give
  up the C++ binding the client needs" is.
- **A recommendation, stated as one, with the reasoning behind it.** A comparison table with
  no recommendation is this command declining to do its job and handing back a homework
  assignment. You have just done the survey; you are the one holding the material.
- **An explicit offer to explain any of it before they choose.** Not "let me know if you have
  questions" — name the ones worth explaining: "if `io_uring` versus a thread pool is not a
  distinction you want to take on trust, say so and I will lay it out before you pick."
  Being taught is a path through this gate, not an exit from it; when it happens it gets a
  `TAUGHT` entry, and then you ask again.

**The failure mode this prevents.** A user picking from a menu of terms they do not hold looks
exactly like a user deciding — both produce a choice with their name on it. Six months later
nobody can tell the two apart, and the person maintaining it is the one who picked.

**A choice picked from your menu is `[selected]`, not `[stated]`.** `yaait:spec` already
carries this mechanism and this command reuses it rather than inventing a second one: record
what was on the menu and which one you recommended, in the `Selected from` field of the
decision. Without it, this gate launders its own inventions into the record as the user's
decisions — the one thing `spec` exists to stop, defeated by moving it a gate over.

## Step 3 — For every choice: a falsifier and an exit cost

A stack decision without a falsifier is a preference wearing a suit. For each decision,
state:

- **Falsifier** — what would make this the wrong choice. It must be a fact that could
  actually be discovered: "if we need to ship a single binary", "if the asset pipeline grows
  past a few hundred megabytes", "if we need sub-millisecond input latency". Something you
  could learn next month and be wrong about.
- **Exit cost** — how expensive it is to back out later. An afternoon, a week, or "this is a
  one-way door". This matters more than the choice: a wrong reversible decision is a
  footnote, a wrong one-way door is the project.
- **Exit path** — *where and how* you would actually change it. Distinct from the cost, and
  more useful: a cost tells the reader how bad it would be, a path tells the person who has to
  do it in a year where to start. "Serialization is behind `store.dump()`/`store.load()`;
  swapping formats means those two functions and their tests." Write it for them, not for you.
  If you cannot name an exit path, the real exit cost is higher than you just wrote.

Spend your argument budget in proportion to exit cost. The test framework is nearly free to
change and rarely worth a debate. The data model, the concurrency model and the deployment
target are close to one-way doors and deserve real scrutiny.

## Step 3a — Measure instead of arguing, where it is measurable

Some stack questions have answers: does this library handle our load, is this serialization
format fast enough at our size, does this runtime hold the frame budget. Discussing those is a
way of avoiding finding out.

Run the experiment **in a subagent where the harness allows one** — throwaway integrations and
benchmark output do not belong in this conversation, only the verdict and the numbers behind
it; otherwise run it inline and say that is what you did. Record it in `EXPERIMENTS.md` with
the question stated *before* the run.

Stack experiments almost always measure something that already exists — a library, a runtime, a
format — so the apparatus is scaffolding: run it outside the repository and discard it, and say
`discarded` in the entry's `Apparatus:` field. The exception is a capacity or cost model, which
is kept in `experiments/` at the project root. Nothing goes in `.yaait/` either way.
`METHODOLOGY.md` §6.

Label the result `measured` or `predicted`, and mean it. You will predict a benchmark result
rather than run it, and the prediction will read exactly like a measurement: same register,
same confidence. An experiment exists to replace a guess with a fact, so the one thing that
must never be ambiguous is which of the two the reader has.

Where an experiment settles a choice, cite its ID in the decisions table rather than restating
the reasoning.

## Step 4 — Argue where it matters

Apply the discussion protocol. If the user's pick has a failure mode you can name, name it —
with the cost. If you merely prefer something else, say it is a preference and move on.

Where you genuinely do not know — relative performance at their scale, ergonomics of a
library you have not seen used in anger — say so, and suggest the cheapest experiment that
would settle it. "I do not know, and here is a twenty-minute way to find out" is worth more
than a confident ranking.

Two failure modes to watch in yourself:

- **Recommending the popular thing** because popularity is what the corpus measured. Popular
  is a real signal for hiring and support, and not a signal about fitness.
- **Recommending the heavy thing.** You will suggest a framework where a library suffices and
  a library where twenty lines suffice, because frameworks are what the corpus contains
  tutorials for. Ask what the dependency is buying, in the units of *this* TTB.

## Step 5 — Write TECH.md

```markdown
# TECH — <TTB name>

> Stack decisions. Versions marked `verified` were checked against current documentation in
> the session that wrote this line; `recalled` means nobody checked. `surveyed` means the
> live alternatives to this choice were looked at, not just this choice confirmed.

Format: 2
Spec: .yaait/SPEC.md
Verified on: <YYYY-MM-DD>

## Proficiency

| Ecosystem | Level | What it costs here |
|---|---|---|
| C++ | expert | — |
| Rust | novice | every increment's review; accepted deliberately, see JOURNAL <date> |

## Constraints (inherited, not chosen)

| Layer | Value | Imposed by |
|---|---|---|
| Platform | Linux x86-64 | customer environment |

## Decisions

| Layer | Choice | Version | Status | Selected from | Falsifier | Exit cost |
|---|---|---|---|---|---|---|
| Language | Python | 3.12 | verified | user stated | if we need a single binary | high |
| Transport | <choice> | <ver> | surveyed | <what was on the menu, and which you recommended> | <what would make this wrong> | medium |
| Tests | pytest | 8.x | verified | — | — | low |

## Deferred to design

- **<layer>** — left open because <the design fact that has to exist first>. `yaait:design`
  settles it and records it under its `## Constraints on the stack`.

## Exit paths

- **<layer>** — <where the change would be made, and what else it touches>

## Settled by measurement

- **X-001** — <question> → <verdict>. See EXPERIMENTS.md.

## Rejected alternatives

- **<option>** — rejected because <reason>. Reconsider if <the falsifier fires>.

## Deprecations and traps

- <the API shape that changed, the idiom that is no longer current, the flag that is now a
  no-op — anything a reader would otherwise get wrong from older examples>

## Unverified

- <anything still `recalled`, and why it could not be checked>
```

The **Unverified** section is the honest part. If it is empty, say so; if it is not, it is
the first thing the user should read.

**`## Deferred to design` is the other one.** This gate runs before the design, so some slots
genuinely cannot be settled yet — whether a broker is needed at all, what gets serialized,
where the process boundary falls. Naming them is what keeps the order honest: an empty
section says every slot was decided, and a reader cannot otherwise tell a slot that was
deliberately left open from one that was overlooked. Deciding one of these early, to avoid an
empty-looking document, is the failure this whole ordering was written to prevent.

**`Format: 2`.** A `Format: 1` `TECH.md` has no `## Proficiency`, no `## Deferred to design`
and no `Selected from` column — so in one of those, a choice the user made and a choice they
picked off a menu this gate wrote are indistinguishable, and nothing records what was left for
the design. Do not read those absences as "the user stated all of it" or "nothing was
deferred". Say you are raising the file to `Format: 2` rather than silently restructuring it.

## Step 6 — The review: hand it over, then walk it

**Hand the floor over before you ask anything.** Say the artifact is written and invite
questions, comments and objections. This is a real round, not a formality: a long exchange with
someone who has depth, a short one with someone who has not, and either is legitimate. It ends
when the user says it ends.

What arrives here is not a confession of ignorance and is never recorded as one. A comment is a
`CHALLENGE` — the disputed point, both positions, what was agreed and why, no winner — plus a
`DECISION` where the artifact changes. A question you answer is `TAUGHT`.

**Then walk them through what the discussion did not reach.** Announce the route and what it
skips before you start, so the user can redirect it. Productive stops here: the choice with the
highest exit cost, a version whose falsifier would be expensive to check late, anything the
design constrained that the stack only just satisfies, and whichever slot you are least sure you
filled correctly.

Three to five stops, and this is one step rather than two: the stop **is** the ask. Each is four
things and no more:

1. **What this part does**, in the user's vocabulary.
2. **Why this shape and not the obvious alternative.**
3. **What it costs if it is wrong** — stated by you. Never held back as the answer to a riddle.
4. **One call, put to them.**

For tech, always include **one pick the user made and one you made** — the asymmetry is the
point. Users engage with their own choices readily and inherit yours without noticing.

**Offer to teach the underlying concepts, by name, at every stop.** This is not the fallback for
a user who cannot answer — it is half of what the walk-through is for, and the list of names is
the disclosure `METHODOLOGY.md` §3 calls sometimes the most useful output of the whole command.
It shows the user exactly which jargon they are about to approve. When they take it, explain it
against this artifact rather than in general, then put a different question about the same
concept back to them, and journal `TAUGHT`.

**A question mid-route reopens the discussion**, then returns to the route. Discussion is not a
phase that closes; it is available throughout, and a walk-through that cannot be interrupted is
a lecture.

**What the discussion *established* is covered. What it merely *touched* is not** — otherwise
one superficial question protects the riskiest thing in the artifact. Coverage decides between
candidates of equal weight; it never removes from the pool an element the artifact depends
on. Walk that one from an angle the discussion did not reach.

Good tech-level stops. **Each opens with its kind and its anchor**, states what it costs if the
call is wrong, and ends on the call itself:

- **Reviewing — SQLite.** You picked it over a server database. SQLite serialises writers, so a
  second process that writes gets `SQLITE_BUSY` and loses that write. `TECH.md` says one
  process. Do you want that as a check at startup, or left as a line in the document?
- **Reviewing — the async choice.** I chose it; nothing upstream asked for it. It buys
  concurrent I/O on one thread, and it costs you every library in the stack having to be async
  too. Keep it, or go back to threads?
- **Reviewing — the 2.5.x pin.** Pinned rather than floating. Floating means the 3.0 rename
  arrives in the next person's fresh checkout with no warning. Pinning means somebody has to
  watch for security releases. Which of those two do you want to own?
- **Reviewing — the data store exit cost.** `TECH.md` records it as high, because the query
  syntax sits in twelve call sites rather than behind one module. I can put it behind a module
  now, for about a day, or leave the number standing as a warning. Which?
- **Reviewing — the one-function dependency.** We take the whole library for one call. If it is
  abandoned we copy in about forty lines. Keep the dependency, or copy the forty lines now?

Note what none of them do: ask the user for a fact this document already states, use a word the
user has not been given, or join two questions with "and". All three are cheap to write and all
three cost you the answer.

Close by naming the categories you did not cover, then ask what they want to look at.

Then journal a `DECISION` per real choice with its rejected alternatives, plus `APPROVAL`,
`DEBT` and `CHALLENGE` as they arise.

## Step 7 — Close

Say what is next: `yaait:design` if it has not run and the criteria fire, otherwise
`yaait:code`. Then stop.

If the verification in Step 2a invalidated something upstream — the design assumed an API
that does not exist, the spec assumed a capability the platform lacks — apply the reconcile
rule now. This is the most common place for it to fire, and finding it here rather than in
`yaait:code` is this command earning its keep.
