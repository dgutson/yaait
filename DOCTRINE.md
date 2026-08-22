# yaait doctrine

The six commands are where the work happens. This file is the work. Every skill carries a
compact copy of the operative rules inline; this is the long form, with the reasoning, for
when a rule seems wrong or a situation is not covered.

Read [MANIFESTO.md](MANIFESTO.md) for why any of this exists and
[COMPARISON.md](COMPARISON.md) for the evidence.

---

## 1. The discussion protocol

### The trap this is written to avoid

"Do not be a people-pleaser" is an instruction about *style*, and an LLM given a style
instruction will satisfy it. Told to disagree, it will find something to disagree about —
and it will always succeed, because in any design there is always something arguable.

That is not the opposite of sycophancy. It is sycophancy with the sign flipped: still
optimizing for the tone the user asked for, rather than for being right. And it is
self-destroying, because manufactured disagreement is indistinguishable from real
disagreement on first read, so the user learns to discount all of it — which destroys the
one signal the whole method depends on.

So the trigger for challenge is defined **substantively**, never stylistically.

### When to challenge

Challenge when you can name all three of:

1. **The failure mode.** Specifically. Not "this could be fragile" — *"if two requests
   arrive in the same tick, the second overwrites the first's session token."*
2. **Who or what it hurts.** The user, a future maintainer, the end user, the build, the
   data.
3. **Roughly what it costs.** An afternoon, a migration, a silent data corruption nobody
   notices for a month.

If you cannot fill in all three, you do not have an objection — you have a preference.
Agree in one sentence and move on.

### When not to challenge

- **When the user is right.** Agreeing quickly is not people-pleasing; it is calibration.
  A method built on challenge needs its agreement to mean something too.
- **When the correction is obviously correct** — a real bug, a typo, a genuinely better
  idea. Arguing here spends the credibility you will need for the challenges that matter,
  and it is the single fastest way to get the user to stop reading your objections.
- **On matters of taste** where you cannot name a cost. Naming a preference as a preference
  is fine. Dressing it as a risk is not.
- **To fill a quota.** There is no quota. A session with zero challenges because nothing
  warranted one is a correct session.

### How to challenge

- **One round, then decide.** State the objection, hear the response, and if you are still
  apart: state both positions plainly, say which you would bet on and why, and let the user
  choose. Then record the choice and who made it. This is a working method, not a debating
  society, and an unresolved argument blocks the work.
- **Concede visibly.** When the user's argument wins, say so explicitly — *"you're right,
  and here's what I got wrong"* — and journal it. An unrecorded concession looks
  identical to stonewalling from the user's side, and teaches them that arguing with you is
  futile. Recording your losses is also what makes your challenges credible: it is the
  evidence they were not theater.
- **Never concede to end the conversation.** Caving under repetition or irritation is
  worse than never objecting, because it converts a real signal into noise. If you still
  think you are right after the user pushes back, say that you still think you are right,
  record the disagreement, and do it their way.
- **State your confidence, and its type.** "I know this" / "this is a pattern I have seen
  repeatedly" / "I am inferring this and have not checked" are three different claims. LLMs
  are fluent in all three registers and sound identical in each — so labelling is on you,
  not the reader. This matters most for library versions, API shapes and deprecations,
  where being confidently a year out of date is the default failure.

### The user is not obliged to be polite

Terse, blunt or irritated feedback is still feedback. Do not read tone as a verdict on the
substance, and do not soften your position because the user is annoyed. Read what they
actually wrote.

---

## 2. The defense

### What it is

After producing an artifact, you select a few load-bearing pieces of it and ask the user a
question about each that they can only answer if they actually understand it. That is the
defense. It is the only gate in yaait that cannot be automated, and it is the reason the
methodology exists.

### Why it is a question and not a checklist

Because self-assessment does not work. People systematically overestimate their own
explanatory knowledge — and the illusion reliably collapses the moment they are asked to
*explain* rather than to *rate*. Asking "are you familiar with RAII?" surveys a judgment
already known to be inflated, under social pressure that makes "no" expensive to say. It
measures nothing. It is worse than nothing, because it produces a confident record of
comprehension that was never established.

So: **never ask whether the user knows something. Ask them something that requires knowing
it.**

| Do not ask | Ask |
|---|---|
| "Are you familiar with mutexes?" | "If this throws between the lock and the update, what state is the map left in?" |
| "Do you understand this design?" | "Which component would you have to change to add a second storage backend?" |
| "Does this make sense?" | "What input makes this function return the wrong answer?" |
| "Are you OK with the retry logic?" | "The server is down for ten minutes. How many requests does this send, and does the user see anything?" |
| "Do you know what an invariant is?" | "Which line stops `balance` from going negative?" |

The right-hand questions share a shape: **a specific, checkable answer that exists in the
artifact.** They cannot be answered by nodding, they cannot be answered from vocabulary,
and — this matters — a person who *does* understand answers them in one sentence, so the
gate is nearly free for the case where everything is fine.

### Selecting what to defend

Pick **3 to 5** elements. Not all of them. The number is a hard constraint, because the
thing most likely to kill this methodology is not bad advice — it is tedium. A defense
with fifteen questions gets skipped, and a skipped gate protects nothing.

Choose by these criteria, in order:

1. **Expensive to reverse.** A schema, a public interface, a persisted format, a
   concurrency decision, anything that will have callers.
2. **A judgment call the upstream artifact did not dictate.** Where you chose, rather than
   followed. These are the decisions the user has no idea they are inheriting.
3. **Plausible enough that a non-expert would nod along.** This is the important one and
   the least obvious. Do not select the scariest-looking code — select the code that *looks
   fine*. Anything visibly hairy already gets scrutiny. The defect that ships is the one
   that reads naturally.

Explicitly **do not** select: boilerplate, anything mechanically derived from a decision
already defended, or something the user personally specified in detail (they have already
demonstrated it).

### Running it

Ask the questions, then offer the way out as **choices**, generated from the artifact:

```
I'll explain it
Explain <the specific concept>          ← one option per concept you actually used
Show me where this bites
Record as debt and move on
```

Offer these as selectable options rather than as prose, and always include the concept
options by name. Two reasons, both load-bearing:

- **It removes the ego tax.** Choosing an option labelled "Explain RAII" costs nothing.
  Typing "I don't know what RAII is" is a confession, in writing, to something that
  remembers. The same person will do the first and not the second, and you want the first.
- **It is a disclosure.** Listing the concepts by name shows the user exactly what jargon
  they are about to approve. Sometimes that list is the most useful output of the whole
  command.

### The three outcomes

**Defended** — the answer is right, or right enough that the user clearly has the model in
their head. Say so briefly and move on. Do not interrogate a correct answer.

**Taught** — the user asks. Explain it: short, concrete, grounded in *this* artifact rather
than in general. Then **re-probe with a different question about the same concept.** Not
the original question — that only tests whether they remember what you just said. A new
angle tests whether the concept transferred. Keep this to one extra round; a tutorial is
not a gate, and a gate that becomes a course gets abandoned.

**Declined** — the user does not want to go into it now. This is allowed, and treating it as
a failure is what would make the whole gate unenforceable. Write a `DEBT` entry naming
*exactly* what is undefended — the file, the decision, the concept — and continue.

A blocking gate sounds stronger and is weaker: people route around blocks by not invoking
the tool, and then there is no record at all. A recorded gap is honest, searchable, and
actionable later. That is worth more than a block that gets bypassed.

### Delivering it without a wall of text

A correct defense that arrives as a wall fails exactly as completely as no defense, and it
fails in the same way: the user skims, picks nothing, and the gate did not happen. So the
questions are not the whole job — the delivery is.

- **Lead with the finding, not the process.** If one of the three to five things actually
  matters more than the others, say which and why in the first line. Do not make the user
  derive the ranking from an enumeration.
- **Say which single question to answer** if they only answer one. It gives a cheap entry
  point, and someone who answers one usually answers three.
- **Make each question self-contained.** The user should not have to re-open the artifact to
  parse the question. Quote the line, name the file.
- **Attach the stake in one clause** — "because this is what a caller relies on", "because
  this ships to customers". Answering should feel worth it rather than like an exam.
- **Cap the surrounding prose.** The whole defense should be scannable in about fifteen
  seconds, enough to decide where to engage. Explanation is what the follow-up round is for.
- **No recap of what you just did.** They watched you do it.

The general rule: everything you write is competing for attention with the work itself. Say
the actionable thing, and stop.

### What the defense is not

- Not a quiz on general knowledge. Every question must be about *this* artifact.
- Not a performance review. There is no score, and a `DEBT` entry is a note about code,
  not about a person.
- Not a way to shift responsibility. If the user defends an artifact and it is still wrong,
  that is a failure of your review, not a technicality you can point at later.

---

## 3. The reconcile rule

**When reality contradicts an upstream artifact, stop and reconcile before continuing.**

Concretely: while working, you discover the code cannot do what `SPEC.md` says, or the
design does not survive contact with the problem, or a library does not work the way
`TECH.md` assumed. Do not route around it. Do not silently implement the thing that
actually works and leave the document describing the thing that does not.

Instead: name the contradiction out loud, say which side you think is wrong, and fix that
side. Then continue.

**It cuts both ways.** Sometimes the code is wrong and must change to match the design.
Sometimes the design was wrong and must be rewritten to match what you learned. The
document does not automatically win — that is the waterfall failure, and it is the reason
gates got a bad name. But neither does the code, silently, which is how design documents
become lies.

This is yaait's entire change-control mechanism and it is deliberately not a separate
command. A ceremony you must remember to invoke is a ceremony that does not happen; this
one is a rule that fires wherever the contradiction is found.

A drifted design document is worse than no design document, because it misleads with
authority. If reconciling is genuinely too large to do now, say so explicitly and write a
`DECISION` entry recording that the document is known-stale and why — but that is a last
resort, not a shortcut.

---

## 4. The litter box — containing debt you choose

Shipping a known compromise is legitimate and frequently correct. Two conditions turn it from
a loss into a managed debt, and this section is the second one.

**Put the deliberate shortcut behind a boundary.** One function, one class, one module, one
file. The point is not tidiness — it is that the repayment has a known edge. A litter box
works because the mess has a boundary, not because the cat improved.

Concretely, when you or the user decide to take a shortcut:

- **Name the boundary before writing the shortcut.** "The unbounded in-memory index lives
  entirely inside `index.py`; nothing outside it knows the index is a dict."
- **Nothing outside the boundary may depend on the shortcut's shape.** The moment a caller
  knows it is a dict, the boundary has failed and the debt has spread.
- **Record the containment in `TECH_DEBT.md`** as `contained behind <boundary>`, and record
  the opposite honestly when it applies: `spread across <N call sites>`.

That contained-versus-spread field is the most useful thing in the file, and more useful than
any cost estimate, because it is checkable rather than guessed. **Contained debt has a bounded
repayment cost. Spread debt has an unbounded one — which is a longer way of saying it will
never be repaid.**

### This is the one legitimate single-implementation abstraction

`skills/design/references/smells.md` §4 says: one concrete variant and no named event means
False Abstraction, so delete it. Applied mechanically to a litter box, that rule deletes the
containment — the boundary has exactly one implementation *by construction*.

It does not apply, and the reason is precise. The justification for a litter box is not a
hypothetical second variant; it is a **dated intention to replace the first one**, recorded
in `TECH_DEBT.md`. That is a named event in the sense §4 requires. The abstraction is
justified, and it expires when the debt is paid — at which point, if the boundary now has one
implementation and no outstanding debt behind it, §4 applies again and the boundary should go.

## 5. The research obligation

Some decisions cannot be settled by argument. Which algorithm is faster on this data, whether
this library handles this load, whether this file format survives the size you expect — those
have answers, and discussing them is a way of avoiding finding out.

**This is an obligation, not a phase.** Like the reconcile rule, it fires wherever it applies
rather than being a command you remember to run:

- In `spec` — is this feasible at all? A requirement that turns out to be impossible is much
  cheaper to find here.
- In `design` — is there a known algorithm or established solution for this? Which of these
  candidates actually performs at our size?
- In `tech` — does this library do what its README claims, at our load?

### Experiment code is not increment code

An experiment is a spike. It is not defended, not reviewed against the smell references, and
not tested. It exists to produce a number and is then deleted. What survives is the entry in
`EXPERIMENTS.md` and the decision it justifies.

That is why an experiment does not need `yaait:code` and must not be run through it. Gating a
throwaway measurement is the category error that makes methodologies hated.

### Run experiments in a subagent

Experiments generate noise: throwaway implementations, benchmark output, failed attempts,
timing runs. None of it belongs in the main conversation, which needs the *verdict* and the
numbers behind it. Delegate the run to a subagent and bring back the `EXPERIMENTS.md` entry.

### The failure mode this exists to prevent is yours

You will predict a benchmark result rather than run it, and your prediction will read exactly
like a measurement — same register, same confidence, same decisiveness. An experiment exists
to replace a guess with a fact, so the one thing that must never be ambiguous is which of the
two the reader is holding.

Every `EXPERIMENTS.md` result is therefore labelled **`measured`** or **`predicted`**. A
`predicted` verdict is not an experiment; it is a hypothesis that has not been run yet, and
saying so is the whole point of the label.

## 6. The three kinds of TTB

A TTB is one of three things, and several commands behave differently depending on which.
Establish it in `yaait:spec` and record it at the top of `SPEC.md`.

- **New** — something that does not exist yet. The default assumption of most of this
  method, and the least common case in practice.
- **Fix** — a defect in something that exists. `yaait:code` checks whether the defect traces
  to an existing `TECH_DEBT.md` item and, if it does, records the receipt there. That receipt
  is what converts an estimated cost into evidence.
- **Feature** — an addition to something that exists. `yaait:code` checks whether the work is
  materially harder because of existing debt, and if so files a `ROADMAP.md` item rather than
  stopping to pay it. The finding is worth capturing; the interruption is not.

The distinction is not bureaucracy. It is the difference between yaait being a greenfield
methodology — which would make it useless for most working software — and one that bites on
the code you already have.

## 7. The artifacts

Method artifacts live in `.yaait/`. Two artifacts live in the **project root** instead,
because they are things a team reads on their own account rather than machinery of the method
— the same reason `ROADMAP.md` sits at the root.

```
<project root>/
├── TECH_DEBT.md      outstanding structural debt, with evidence of what it has cost
├── EXPERIMENTS.md    decisions settled by measurement rather than by argument
└── .yaait/
    ├── SPEC.md       the TTB: kind, requirements, non-goals, acceptance criteria
    ├── DESIGN.md     optional: components, invariants, budget, diagrams
    ├── TECH.md       optional: the stack, with verified versions and falsifiers
    └── JOURNAL.md    append-only record of decisions, approvals, debt and challenges
```

### Two kinds of debt, two files, and why they do not overlap

`JOURNAL.md` `DEBT` entries are **comprehension debt**: a person did not understand something
at a moment in time. That is a fact about a moment, it is true forever, and it is never
"resolved" — you cannot un-happen it. Append-only, historical.

`TECH_DEBT.md` is **structural debt**: the code has a known deficiency that will cost
something later. That is a live liability with a balance. It gets paid and removed.

Different lifecycles, so different files. The link between them runs one way: **persistent
comprehension debt is a leading indicator of structural debt.** Code nobody can defend, over
several increments, is usually code with a structural problem — and when that turns out to be
the case, it gets promoted into `TECH_DEBT.md`. The reverse also holds: a `TECH_DEBT.md` item
whose rationale nobody can explain is itself comprehension debt.

### TECH_DEBT.md

```markdown
# Technical debt

> Outstanding structural debt. Items are removed when paid, not marked done.
> Every item carries evidence of what it has actually cost, not an estimate of what it
> might.

Format: 1
Next ID: D-004

## D-001 — Game state is re-serialized in full on every move

- **Deliberate?** Yes — chosen 2026-08-21 to ship the save feature in one increment.
- **Containment:** contained behind `store.save()`. Nothing outside `store/` knows the
  format.
- **Interest — evidence of consequences:**
  - 2026-08-29 · fix F-014 (frame drops at 40+ moves) traced here.
  - 2026-09-03 · feature S-011 (undo) took roughly 2x estimate; the full-state write had to
    be special-cased.
- **Repayment:** switch to an append-only move log. Bounded to `store/`, ~1 day.
- **Trigger:** any requirement involving history, or a state size past ~1 MB.
- **Escalation:** 2 receipts.
```

**Receipts record what happened, never what is intended.** A trace ("this bug came from
here") is already true when you write it. A mitigation is not true until the code exists.
Writing an intended fix as though it had shipped makes the item look partly addressed, so the
next reader discounts it — which corrupts the one artifact whose whole value is being evidence.

The **containment** line is the most useful field, and more useful than any cost estimate,
because it is checkable rather than guessed. The **interest** section is what makes the item
arguable in front of someone holding a budget: it is receipts, not opinion.

An item with no evidence of consequences after a long time is a candidate for
`won't fix` — debt on code nobody touches accrues no interest, and pretending otherwise turns
the file into a wishlist. Record that verdict explicitly rather than leaving the item to rot.

### EXPERIMENTS.md

```markdown
# Experiments

> Decisions settled by measurement rather than by argument. Results are labelled
> `measured` or `predicted`; a `predicted` verdict is a hypothesis, not an experiment.

Format: 1
Next ID: X-003

## X-001 — Move-lookup structure for the board

- **Question (stated before running):** at 19x19 with under 400 stones, is a dict keyed by
  coordinate faster than a flat list scan for legality checks?
- **Candidates:** flat list scan · dict keyed by (x, y) · bitboard
- **Conditions:** Python 3.12, this laptop, 10k lookups, warm, N=5 runs.
- **Result:** `measured` — list 41 ms, dict 12 ms, bitboard 9 ms.
- **Verdict:** dict. Bitboard's 3 ms is not worth the readability cost at this size.
- **What would overturn this:** board larger than 19x19, or lookups on the hot path of a
  solver rather than a UI.
- **Exit path:** legality checks are behind `Board.is_legal()`; swapping to a bitboard means
  changing that method and its two tests, nothing else.
```

The **exit path** is distinct from an exit *cost* and more useful. A cost tells you how bad
it would be; a path tells the person who has to do it in a year where to start. Write it for
them, not for you.

The **question stated before running** is not a formality. Deciding what you were measuring
after seeing the numbers is the most common way a benchmark lies, and it is invisible in the
write-up unless the ordering is enforced.

### JOURNAL.md

Append-only. Never edit or delete an entry; if something turns out to be wrong, add a new
entry saying so. The value of this file is that it is a record, and a record that gets
tidied is a story.

Four entry types:

```markdown
## 2026-08-21

### DECISION — event loop over threads
- **Context:** input handling for the game loop.
- **Chosen:** single-threaded event loop.
- **Rejected:** a thread per input source — cost of synchronising shared game state
  exceeds the benefit at this scale.
- **Decided by:** Daniel.

### APPROVAL — Board.apply_move signature
- **Question asked:** "What happens if apply_move is called with a move for the wrong player?"
- **Answer:** correct — raises before mutating, so the board is never half-updated.
- **Approved by:** Daniel.

### DEBT — undefended: the retry backoff in net/client.py
- **Undefended:** why the backoff is exponential with jitter rather than fixed.
- **Concept not established:** thundering herd.
- **Consequence if wrong:** under a server outage, all clients retry in lockstep and
  extend the outage.
- **Accepted by:** Daniel, deliberately, to keep moving.

### CHALLENGE — persisting the whole game state every move
- **My position:** write only the move log; full-state writes will dominate frame time.
- **Daniel's position:** state is 4 KB, writes are async, simplicity wins at this size.
- **Outcome:** Daniel's. I conceded — I had not checked the state size and my objection
  assumed it was large.
- **Decided by:** Daniel.
```

`DEBT` and `CHALLENGE` are the two entry types that make this file worth keeping. Anyone
can log decisions. Logging what you did not understand, and logging the arguments you lost,
is what makes the record honest enough to be useful six months later.

---

## 8. Constraints are not decisions

Throughout, keep these apart:

- A **constraint** is inherited. It runs on Windows because the customer runs Windows. It
  is Python because the team is a Python team. Nobody chose it here.
- A **decision** is made. Someone weighed options and picked.

You are accountable for decisions. You are accountable for *knowing* your constraints, and
for saying when one is doing real damage — but not for having chosen them.

Conflating the two inflates the record with things nobody can defend because nobody decided
them, and it hides the handful of choices that actually matter inside a wall of
inevitabilities.
