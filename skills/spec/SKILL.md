---
name: spec
description: >
  Open a yaait discussion about the thing to build (the TTB) and turn it into a
  .yaait/SPEC.md whose every requirement is tagged as stated, selected, inferred or assumed —
  so requirements the LLM invented are visible instead of laundered into the record, including
  the ones the user merely picked from a menu the LLM wrote. Runs a challenge-and-defense loop
  rather than transcribing what the user said: pushes back on requirements that cannot be
  tested, forces non-goals and acceptance criteria, names the bets the spec rests on instead of
  asking anyone to predict the future, separates inherited constraints from real decisions, and
  finishes by recommending whether a design or tech phase is warranted against stated
  criteria. Use whenever the user runs /yaait:spec, starts a new project or feature under
  yaait, or says anything like "let's spec this out", "what should this do", "I want to
  build X", "write the requirements", "let's start a new TTB". Also suggest it when someone
  is about to have you write code for something whose requirements have only ever existed
  in a chat message — that is precisely the case where invented requirements ship
  undetected.
---

# yaait:spec — establish the thing to build

You are opening a **discussion**, not taking dictation. The user knows something about
what they want; you know the failure modes of half-specified work. Neither of you has the
whole thing at the start, and the specification is what you build together.

## Why this command exists

The best-documented failure of LLM-assisted development is that the model **invents
requirements** — fills a gap with something plausible, implements it, and the invention
becomes indistinguishable from a real requirement the moment it is written down. Nobody
notices, because inventions are chosen for plausibility.

You cannot stop yourself doing this; the gaps are genuinely ambiguous and something has to
go there. What you *can* do is make every gap-filling visible, which is why every
requirement in `SPEC.md` carries a provenance tag. The tag is the whole mechanism. An
`[assumed]` requirement is not a problem — an assumed requirement that has become
indistinguishable from a stated one is a problem.

The second reason: a spec is the only artifact that can make `yaait:stest` meaningful. A
system test with nothing to trace against is a demo.

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

## Step 0 — Read what already exists

Check for `.yaait/SPEC.md`, `.yaait/JOURNAL.md`, `CLAUDE.md`, and any README in the repo.

If `SPEC.md` **already exists**, you are amending, not replacing. Preserve existing
requirement IDs — they are referenced by `DESIGN.md`, by tests, and by journal entries, and
silently renumbering breaks all of it. Add new requirements with new IDs, and if an existing
requirement is now wrong, apply the reconcile rule: name it, say why, and change it
deliberately with a `DECISION` entry.

## Step 1 — Establish the TTB

**If a description of the TTB came with the invocation, that is your opening position, not
your answer.** Restate what you understood in one line so the user can correct it, then
interrogate it exactly as you would something typed into the conversation. A requirement is
not more established for having arrived as an argument, and every one of them still gets a
provenance tag in Step 2. If nothing came with the invocation, ask.

Then, before anything else, establish the two things people almost never volunteer:

- **Who uses it, and what happens if it is not there?** This is what lets you judge every
  later tradeoff. Without it you will optimize the wrong axis with great discipline.
- **How long is it expected to live?** A weekend tool and a five-year service have
  different correct answers to every subsequent question. Do not ask for a forecast —
  nobody has one, and "how long will this live" invites a number rather than an answer. Ask
  in the present tense instead: what happens to this when you stop working on it, and if it
  broke in a year, would you fix it or bin it? If the answer amounts to "a weekend", say
  plainly that yaait is probably the wrong tool and offer to just build it — see the "when
  not to use yaait" section of `COMPARISON.md`. Do not run a methodology on something that
  does not need one.

  **Ask this once more after the defense.** It is the answer that calibrates every
  subsequent tradeoff and it is elicited at the point of least information, before the user
  knows what they are calibrating. The defense is the first moment they engage with anything
  concrete, so it is where the real answer tends to arrive — and an answer that arrives then
  can still be acted on, whereas one that arrives in `code` cannot.

Then interrogate. Good questions at this stage are the ones whose answers change the
shape of the thing: what it must interoperate with, what it must persist, what happens
when it fails, who else touches the same data, what is explicitly somebody else's problem.

## Step 1a — Record which kind of TTB this is

A TTB is one of two things. **Do not ask — you already know from Step 0.**

- **Greenfield** — this is the first spec of the project. Nothing exists yet.
- **Maintenance** — the project exists; this spec adds to it or changes it.

State which one it is in a single line, record it at the top of `SPEC.md`, and move on. Let
the user correct you if you got it wrong. Asking someone to classify their own work is effort
with no return, and it is a strange first question to put to somebody who came to build
something.

The kind answers exactly one question — is there a prior state to account for — and three
things turn on it: whether to offer a code map (Step 1b), whether `yaait:design` produces an
impact analysis, and whether `yaait:code` has a `TECH_DEBT.md` to check against.

The axis is whether the *project* exists, not what code this change will touch. You cannot
know the second one yet; that is what the impact analysis is for. See `METHODOLOGY.md` §7.

**If the user describes something broken**, two extra questions belong here and nowhere else,
whatever the TTB kind: *what is the observed wrong behaviour* — not the suspected cause, since
those get confused constantly and a spec built on a suspected cause will faithfully fix the
wrong thing — and *what should happen instead*. When a defect is what prompted this, the
acceptance criterion is a test that fails today.

## Step 1b — For a Maintenance TTB, offer a code map

Skip this for a **Greenfield** TTB — there is nothing to map. Otherwise ask whether the user
wrote this code and whether they still hold it in mind. If either answer is no, offer to
generate a **code map** with a program-understanding tool before eliciting requirements —
`graphify`, `codebase-memory`, `serena`, `greptile`, `sourcegraph`, or whatever the project
already uses.

This is optional and the command proceeds without it. What matters is that the map can be
**regenerated on demand** and **carries its generation date**: an undated map misleads with
authority, and a drifted one is worse than none. Kept beside the project's standing-instruction
file, it is the durable form of shared team memory — `METHODOLOGY.md` §7.

Record in `SPEC.md` whether a map was used and the date it was generated.

Without this, a maintenance spec is written against a guess about what the code does today,
and every requirement inherits the guess — including the acceptance criteria, which is where
it gets expensive.

## Step 2 — Tag every requirement

This is the core of the command. Each requirement gets an ID and a provenance tag:

- `[stated]` — the user said it, in substance, in their own words. Not "the user would
  obviously want this", and not "the user agreed when I put it to them."
- `[selected]` — the user chose it from options **you** composed, in answer to an ask-first
  question below. Weaker than `[stated]`, stronger than `[inferred]`: the option set was your
  plausibility judgment and the pick adds one fact, that they saw it and did not object.
- `[inferred]` — you derived it from something they said. It follows, but they did not say
  it.
- `[assumed]` — you filled a gap. Nothing they said implies it; you needed *something*
  there and chose this.

Be honest about the difference between `[inferred]` and `[assumed]`, because the temptation
runs one way: labelling an assumption as an inference makes your spec look better and makes
the user's review worse. If you cannot point at the thing you inferred it *from*, it is
assumed.

**A tag records where the requirement came from, and it never changes.** Confirmation is a
separate `Confirmed:` field added beside it — never a rewrite of the tag. Promoting
`[assumed]` to `[stated]` because the user agreed destroys the only record that the
requirement was yours to begin with, which is the one thing this whole command exists to
keep. The tag answers "whose sentence was this originally"; the `Confirmed:` field answers
"did they later agree". Both are useful and neither substitutes for the other.

### Ask before filling, when the gap is expensive

Tagging is the safety net, not the first line of defense. Where the gap is expensive, **ask
before you fill it** rather than filling it and confirming later.

Ask first when either holds:

- **Being wrong is expensive to reverse** — a persisted format, a public interface, an
  externally visible behaviour, a security or privacy boundary, anything that will have
  callers.
- **Both answers are defensible and they diverge** — the choice sets a direction rather than
  a detail, so guessing costs a rework cycle even when the guess is reasonable.

Everything else: fill it, tag it `[assumed]`, and confirm in one batch. That triage is what
keeps this from becoming a forty-question interrogation, which is the version nobody finishes.
The number of ask-first questions scales with how many genuine forks the TTB has — a
greenfield game can legitimately have eight or nine, and a small change to an existing module
one or none. The check is "is this a detail?", never "have I hit three yet?"

**If you ask by offering options, the options are yours and the record must say so.** A
generated option set is not a neutral instrument: you chose the framing, the alternatives and
the ordering, and where the harness marks one option "(Recommended)" that is your opinion
embedded inside the measuring device. So:

- Tag the result `[selected]`, not `[stated]`, and record what was on the menu and which
  option you recommended. The alternatives are the part with forensic value: when the
  requirement turns out wrong, "they were never offered the right option" and "they wanted this
  and were wrong" call for completely different repairs, and without the menu you cannot tell
  the two apart.
- **Say that the menu is escapable**, every time, and mean it. The best answer is regularly one
  you did not think to offer, and a user who believes the list is exhaustive will pick the
  nearest fit instead of telling you.

Then **walk the user through every `[selected]`, `[inferred]` and `[assumed]` requirement**.
Each one gets confirmed, corrected, or dropped — and confirmation adds a `Confirmed:` field
while the tag stays exactly as it was. Do not batch these into a wall of forty items — group
them and lead with the ones where being wrong is expensive.

If the list of assumptions is long, say so, and say what that means: a long assumption list
is a measurement of how underspecified the request was, and it is useful information rather
than a failure.

## Step 3 — Force the non-goals

Ask what this explicitly does **not** do. Keep pushing until you get real ones, because
non-goals are the highest-value, lowest-cost part of a spec and nobody writes them
unprompted.

They earn their place twice. They stop you building things nobody asked for — the single
largest source of LLM-generated waste. And they are the only defense against the scope
question arriving later disguised as a bug report.

A good non-goal is specific and *tempting*: "no multiplayer", "no undo", "does not handle
timezones — everything is UTC", "no plugin system". A non-goal nobody would have built
anyway is not doing any work.

**Do not offer non-goals as a closed list to tick.** A checklist of four you composed returns
four ticks and no pushing, and then every non-goal in the spec is a scope decision of yours
wearing the user's clothes — which is precisely the failure this step names. Ask the open
question first, and only offer candidates once they have given you at least one of their own.
Whatever they do not author, you author, and **at least one gate-proposed non-goal is a
mandatory defense target in Step 8** — not an optional one. Scope decisions are the cheapest
thing in a spec to get wrong silently and the most expensive to discover in `code`.

## Step 4 — Acceptance criteria

Every requirement worth keeping needs a criterion that could **fail**. Write them as
observable outcomes, not as descriptions of behaviour:

| Weak | Strong |
|---|---|
| "The game is playable" | "A full game can be played to a win, a loss and a draw, and each is announced correctly" |
| "Handles invalid input" | "A move to an occupied square is rejected and the board is unchanged" |
| "Fast enough" | "A move is reflected on screen within 100 ms on the target machine" |
| "Saves progress" | "Killing the process mid-game and restarting resumes at the same position" |

`yaait:stest` traces against these clause by clause. A criterion nobody can test is a spec
defect, and it is far cheaper to notice that now than at the last gate.

If a requirement genuinely cannot be given a falsifiable criterion, keep it but mark it
`[untestable]` and say why. Sometimes that is honest — aesthetics, feel, "it should be
fun". Naming it as untestable is what stops it from being quietly reported as passing.

## Step 5 — Ask what this spec is betting on

Not "how do we know it works" — Step 4 covered that. What matters here are the assumptions
*underneath* the requirements rather than in them: that users will want this, that the load
will look like that, that the format will not change. Those are the assumptions that sink
projects, and they are invisible to requirement-level review because they are not requirements.

**Do not ask for a forecast.** "What would tell us in three months that this was wrong" is a
question about the future, and nobody has the future — asked straight, it earns a shrug, and
the shrug is the correct answer. Turn it around into the one direction where the user does
hold information: **you** name the bets, in the present tense and out of the requirements you
have just written, and ask which one they would be least surprised to lose. Picking the
shakiest of four stated bets is a judgment about today, and they can make it.

So: write three to five candidate bets, each one a thing this spec assumes is true and would
be damaged if it were not. Then ask.

**If they decline anyway**, that is fine and it is common. Keep your candidates, and label the
section in `SPEC.md` as yours rather than theirs — the header line says whose they are. What
must not happen is either of the two silent failures: leaving the section empty, which is
indistinguishable from never having asked, or writing your candidates in as though the user
had supplied them, which is the laundering this whole command exists to prevent.

Record the answers. They are what `DESIGN.md` should be built to survive.

## Step 5a — Measure any quantity the requirements rest on

**Any load-bearing quantity that neither of you can estimate is a question with an answer, and
discussing it is a way of avoiding finding out.** Feasibility is the obvious case — the
throughput, the latency, whether a platform can do this at all — but it is not the common one.
The quantity that most often decides a spec is a tuning number: how long a match runs, how big
a page gets, what a month of this costs, where the boredom lives. Those are as measurable as
feasibility and far more likely to be argued about instead.

Run the cheapest experiment that settles it — **in a subagent where the harness allows one**,
so the throwaway output stays out of this conversation; otherwise run it inline and say that is
what you did. Record it in `EXPERIMENTS.md` labelled `measured`.

**Then decide what becomes of the apparatus, and say so.** If it measured something that
already exists, it is scaffolding: run it outside the repository and discard it. If it *models*
something that does not exist yet — a simulation, a cost model — the apparatus is the
experiment, rebuilding it later would produce a different model, and it is kept in
`experiments/` at the project root with the experiment's ID in the filename. Either way the
`Apparatus:` field in `EXPERIMENTS.md` records which, and **nothing goes in `.yaait/`** — that
directory holds prose the other gates parse, never code. `METHODOLOGY.md` §6.

Two reasons this is a step and not an aside. An impossible requirement is far cheaper to
discover here than in `yaait:code`. And a measured number settles a disagreement in one turn
that argument would not settle at all: the user is entitled to their intuition about a quantity
and so are you, and neither of you is entitled to be right about it without checking.

Do not accept a requirement whose feasibility neither of you can vouch for; either measure it
or tag it `[assumed]` and say plainly that the whole spec rests on an unverified capability.

## Step 6 — Separate constraints from decisions

A **constraint** is inherited: the platform, the language the team already uses, a deadline,
an existing database, a customer's environment. A **decision** is chosen here.

Ask explicitly what the stack is already constrained to, and by what. Two reasons:

- The user is accountable for decisions, not for constraints. Mixing them inflates the
  record with things nobody chose and buries the handful of real choices.
- It tells you whether `yaait:tech` has any work to do. If the stack is fully constrained,
  running `tech` would be rubber-stamping a fait accompli, and you should say so.

If a constraint is doing real damage, say so once, with the cost. Then respect it.

## Step 7 — Write SPEC.md

Write it now. Do not wait for approval of the item list — the defense in Step 8 is where
that happens, and the file being on disk first is deliberate: if the session dies or the
user walks away, a wrong requirement in a file is a two-line edit, whereas a file that was
never written loses the entire conversation.

```markdown
# SPEC — <TTB name>

> The thing to build. Requirement provenance is tagged: [stated] the user said it in their
> own words, [selected] they chose it from options this spec offered, [inferred] derived from
> what they said, [assumed] a gap this spec filled. Tags record origin and never change.

Format: 2
Kind: greenfield | maintenance
Code map: none | <tool>, generated YYYY-MM-DD

## What this is

<Two or three sentences. Who uses it, what happens if it does not exist, expected lifetime.>

## Requirements

### S-001 — <short title>  `[stated]`
- **Requirement:** <what must be true>
- **Acceptance:** <an observable outcome that could fail>

### S-002 — <short title>  `[assumed]`
- **Requirement:** <what must be true>
- **Acceptance:** <an observable outcome that could fail>
- **Assumption:** <what gap this filled, and what happens if the guess is wrong>

### S-003 — <short title>  `[selected]`
- **Requirement:** <what must be true>
- **Acceptance:** <an observable outcome that could fail>
- **Selected from:** <the options offered, and which one you recommended>
- **Confirmed:** <date, if the user later confirmed it — added, never replacing the tag>

## Non-goals

- <specific and tempting>

## Constraints (inherited, not chosen)

- <constraint> — imposed by <source>

## What this spec is betting on

<Say whose these are: the user's, or candidates this spec wrote and the user did not rank.>

- <a present-tense assumption this spec rests on, and what it damages if it is false>

## Open questions

- <anything genuinely unresolved — not padding>

## Gates recommended

- `yaait:tech` — <recommended | not warranted>, because <which criterion fired>
- `yaait:design` — <recommended | not warranted>, because <which criterion fired>
```

**The keys and the tags above are the whole vocabulary.** Requirement fields are
`Requirement`, `Acceptance`, `Assumption`, `Selected from` and `Confirmed`; tags are
`[stated]`, `[selected]`, `[inferred]`, `[assumed]` and `[untestable]`; the section headings
are the ones shown. Inventing another — a `[defended]` tag, an `[OPEN]` status, a second
`Acceptance` line — is a format change, and a format change means bumping `Format:` and saying
in `JOURNAL.md` what an older reader now gets wrong. Do not do it in passing.

That rule exists because `design`, `code` and `stest` all read this file, and `stest` traces
acceptance criteria clause by clause. A reader that parses a changed format *successfully but
wrongly* fails in the worst way there is: silently. `Format: 2` added the `[selected]` tag, the
`Selected from` and `Confirmed` fields, and renamed the falsifier section; it dropped
`Next ID`, which was bookkeeping that could drift out of step with the requirements it counted
— read the requirement headings instead. A `Format: 1` spec has no `[selected]` tag, so every
menu-authored requirement in it is indistinguishable from one the user stated.

## Step 7a — Hand it over, then tour it

**Hand the floor over before you probe anything.** Say the artifact is written and invite
questions, comments and objections. This is a real round, not a formality: a ping-pong with
someone who has depth, a short one with someone who has not, and either is legitimate. It ends
when the user says it ends.

What arrives here is not a confession of ignorance and is never recorded as one. A comment is a
`CHALLENGE` — the disputed point, both positions, what was agreed and why, no winner — plus a
`DECISION` where the artifact changes. A question you answer is `TAUGHT`.

**Then tour what the discussion did not cover.** Announce the route and what it skips before
you start, so the user can redirect it. Productive stops here: a requirement tagged
`[inferred]` or `[assumed]`, because those are the ones the user never said and is least likely
to have noticed; a non-goal that closes off something they may still want; an acceptance
criterion that would be awkward to actually test.

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

The stops you toured in Step 7a are the elements; this step is how the asks are phrased,
what the options offer and what gets journalled. Do not select a second time.

Select 3–5 elements by the criteria above. For a spec, the productive targets are usually:

- The `[assumed]` requirement that is most expensive to be wrong about.
- An acceptance criterion whose wording hides an ambiguity you resolved silently.
- A non-goal you proposed rather than the user — those are your scope decisions, wearing
  the user's clothes. **At least one of these is mandatory**, not optional, whenever any
  non-goal in the spec is yours. Step 3 names this failure and nothing else stops it: a
  checklist of non-goals gets ticked, listed under "not probed", and left undefended.
- The requirement whose interaction with another requirement is not obvious.

Good spec-level defense questions. **Each one opens with its kind and its anchor**, states the
stake, and ends on a single plain question — the label is what tells the user this is the one
kind of ask they can be wrong about:

- **Defending — S-003.** It says moves are validated server-side. What is the client then
  allowed to assume?
- **Defending — S-002 and S-005.** Both write the save file. Which one wins if they disagree?
- **Defending — the UTC decision.** You approved "everything is UTC". What does a user in
  Buenos Aires see at midnight?
- **Defending — the latency criterion.** It says "within 100 ms". Measured between which two
  events?

Note what none of them do: use a word the user has not been given, or join two questions with
"and". Both are cheap to write and both cost the answer.

Then journal: `APPROVAL` for what was defended, `DEBT` for what was not, `CHALLENGE` for
anything you argued about.

## Step 9 — Install the standing rule

The spec only stays true if later sessions know it exists. It lives in the project's
`CLAUDE.md`, so it loads in every future session — including sessions that never invoke this
plugin.

**Read that file first and look for a `## yaait` heading.** A Maintenance TTB runs this gate
in a project that already has the block, and an append that does not check installs the
standing rules a second time. Duplicated instructions are not inert: a rule stated twice
reads as a rule stated emphatically, and nothing tells the reader which copy is current.

- **Absent** — append the block below, creating `CLAUDE.md` if there is none.
- **Present, and it matches** — say it is already installed and move on.
- **Present, but it differs** — say what differs and offer to replace it. Never append a
  second copy.

```markdown
## yaait

This project is developed under yaait. Its artifacts live in `.yaait/`:
`SPEC.md` (the thing to build), `TECH.md` (the stack), `DESIGN.md` (optional), and an
append-only `JOURNAL.md` of decisions, approvals, comprehension debt, teaching and challenges.
`tech` runs before `design`, because the stack settles most of what a design cannot cheaply
reverse.

- **Read `.yaait/SPEC.md` before writing code here.** It records which requirements the
  user actually stated and which were inferred or assumed.
- **Reconcile rule:** if reality contradicts `SPEC.md`, `DESIGN.md` or `TECH.md` — the code
  cannot do what the document says, or a library does not behave as assumed — stop, name
  the contradiction, say which side is wrong, and fix that side before continuing. It cuts
  both ways; sometimes the document is what is wrong. Never silently implement the working
  thing and leave the document describing the broken one.
- **Discussion, not compliance.** Push back when you can name the failure mode, who it
  hurts and what it costs. Otherwise agree in one sentence. Do not manufacture disagreement,
  and when the user's argument changes the outcome, say what you had wrong and record it. A
  discussion ends in an agreement, not in a winner.
- **The user must be able to defend what ships.** Before a non-trivial change is finished,
  hand it over first — invite questions, comments and objections — then walk them through the
  parts that review did not reach. At each stop ask for their judgment on the part most likely
  to be wrong: never "are you familiar with X", and never a fact they are meant to recall, but
  something like "I think this is the fragile line here — do you agree?". If they cannot answer
  and do not want to go into it, record a `DEBT` entry in `JOURNAL.md` naming exactly what is
  undefended, and continue.
- **A spike is not an increment.** Code written to produce a number — a benchmark, a
  feasibility probe, a throwaway implementation — is not defended, not reviewed and not
  tested. What survives is the entry in `EXPERIMENTS.md` and the decision it justifies.
  Gating a throwaway measurement is the category error that makes methodologies hated.
- **`.yaait/` is prose only, and `experiments/` is off limits to the product.** Scripts,
  data dumps and logs never go in `.yaait/`; the gates parse what is in there. Apparatus
  worth keeping lives in `experiments/` at the project root, named by its experiment ID —
  and **nothing in the product may import from it**, because it skipped every gate on
  purpose. An import from `experiments/` is a review finding, not a judgment call.
- Append to `JOURNAL.md`; never edit or delete an entry.
```

Say explicitly that you edited `CLAUDE.md`. A file that shapes every future session should
never be a silent side effect.

## Step 10 — Recommend what comes next, against criteria

Close by saying whether `yaait:tech` and `yaait:design` are warranted, **in that order** —
that is the order they run in (`METHODOLOGY.md` §1), and the tech answer can change the design
answer. Use criteria, not vibes, and say which criterion fired:

**Recommend `yaait:tech` when** the stack is not already constrained, or when it is
constrained by something the user could not justify when asked in Step 6.

**Recommend `yaait:design` when any of these hold:**
- more than about three components that interact;
- a state machine, or anything where "what state is it in" is a real question;
- concurrency, async, or shared mutable state;
- a persisted format or a wire protocol — anything with a compatibility future;
- more than one plausible decomposition, where picking wrong is expensive to undo;
- the TTB is **Maintenance** and the change reaches outside the module it lives in
  — the impact analysis is the design work, and it belongs in `DESIGN.md`.

**Recommend against `yaait:design`** for a single-module TTB with no persistence and an
obvious decomposition. Say so plainly. Recommending a design phase for a 200-line script is
exactly the ceremony that gets this methodology abandoned, and the honest recommendation is
worth more than the thorough one.

State the recommendation, give the reason in one line, and **write it into `SPEC.md`'s
`Gates recommended` section** — both the recommendation and the criterion that fired, for
each of the two gates. Say it out loud and stop; do not start the next phase unless asked.

The section is written even when the answer is "not warranted", because that is the case a
later reader most needs: a spec with no `DESIGN.md` beside it is otherwise indistinguishable
from a spec whose design phase was recommended and skipped. Recording the recommendation is
what lets `yaait:code` tell those apart without anyone keeping notes.

If the user says here that they are proceeding without a gate you recommended, append a
`DECISION` naming the criterion that fired and the fact that it was declined. A
recommendation made against criteria and then dropped leaves no trace otherwise, and the
record then shows a project that was never advised rather than one that was advised and
chose differently — which is the more flattering of the two and the less true.
