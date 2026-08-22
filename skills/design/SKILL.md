---
name: design
description: >
  Produce, argue about and defend a .yaait/DESIGN.md for the thing to build before any code
  exists — components, responsibilities, invariants, what the design forbids, and mermaid
  class/sequence/state diagrams — with a declared size budget that every abstraction beyond
  it must justify by naming a second concrete variant. Deliberately guards both directions:
  against emergent design (structure that never arrives, debt that never gets repaid) and
  against LLM over-engineering (false abstraction, gold plating, speculative generality,
  symmetry-driven design, pattern-name-driven design). Use whenever the user runs
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

### Challenge substantively, never stylistically

Push back when you can name all three: **the failure mode** (specifically — not "this is
fragile" but "if two moves arrive in the same tick the second overwrites the first"),
**who or what it hurts**, and **roughly what it costs**. If you cannot fill in all three,
you have a preference rather than an objection: agree in one sentence and move on.

Agreeing quickly when the user is right is not people-pleasing, it is calibration. Never
manufacture disagreement to seem rigorous — contrarianism on command is sycophancy with
the sign flipped, and it is self-destroying, because the user learns to discount all of it
and that destroys the one signal this method runs on. When their argument wins, say so
explicitly and journal it; an unrecorded concession is indistinguishable from stonewalling.
But never cave just because they repeated themselves — record the disagreement and do it
their way.

One round, then decide. Still apart? State both positions, say which you would bet on and
why, let the user choose, journal who chose.

Label your confidence: "I know this", "a pattern I have seen repeatedly", and "I am
inferring and have not checked" are three different claims, and you sound identical in all
three. This matters most for versions, API shapes and deprecations.

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

Then offer the way out as **selectable options**, generated from the artifact:
`I'll explain it` / `Explain <concept>` — one per concept you actually used, named / `Show
me where this bites` / `Record as debt and move on`. Options rather than prose for two
reasons that both matter: choosing "Explain RAII" costs nothing while typing "I don't know
what RAII is" is a confession in writing, and naming the concepts discloses exactly what
jargon the user is about to approve.

Three outcomes:

- **Defended** → `APPROVAL` entry. Say so briefly; do not interrogate a correct answer.
- **Taught** → explain short and concrete, grounded in *this* artifact, then re-probe with
  a **different** question on the same concept. Re-asking the original only tests whether
  they remember your answer. One extra round — a gate that becomes a course gets abandoned.
- **Declined** → `DEBT` entry naming exactly what is undefended, then continue. Declining
  is allowed. A blocking gate is weaker than it sounds: people route around blocks by not
  invoking the command, and then there is no record at all.

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
- **Cap the surrounding prose.** The whole defense should be scannable in about fifteen
  seconds — enough to decide where to engage. Explanation is what the next round is for.
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
## Where things go

In the **user's project**, never in this plugin. Two files sit at the project root because a
team reads them on their own account, rather than being machinery of the method:

```
<project root>/
├── TECH_DEBT.md      outstanding structural debt, with evidence of what it has cost
├── EXPERIMENTS.md    decisions settled by measurement rather than argument
└── .yaait/
    ├── SPEC.md       the TTB: kind, requirements, non-goals, acceptance criteria
    ├── DESIGN.md     optional: components, invariants, size budget, diagrams
    ├── TECH.md       optional: the stack, with verified versions and falsifiers
    └── JOURNAL.md    append-only: decisions, approvals, comprehension debt, challenges
```

**Two kinds of debt, and they do not overlap.** A `JOURNAL.md` `DEBT` entry is *comprehension*
debt — a person did not understand something at a moment; true forever, never resolved.
`TECH_DEBT.md` holds *structural* debt — the code has a deficiency; a live balance that gets
paid and removed. Persistent comprehension debt is a leading indicator of structural debt,
and gets promoted when it turns out to be one. Full formats for both root files are in
`METHODOLOGY.md` §8.

`JOURNAL.md` is append-only. Never edit or delete an entry — if something turns out to be
wrong, append a new entry saying so. Its whole value is being a record, and a record that
gets tidied is a story. Entries go under a `## YYYY-MM-DD` heading:

```markdown
### DECISION — <short title>
- **Context:** what prompted the choice.
- **Chosen:** what was picked.
- **Rejected:** what was not, and why not.
- **Decided by:** who.

### APPROVAL — <artifact element>
- **Question asked:** the defense question.
- **Answer:** what the user said, and whether it held up.
- **Approved by:** who.

### DEBT — undefended: <what, and where>
- **Undefended:** the specific decision that was not defended.
- **Concept not established:** the term or technique behind it.
- **Consequence if wrong:** what actually breaks.
- **Accepted by:** who, and whether deliberately.

### CHALLENGE — <the disputed point>
- **My position:** and the failure mode it rested on.
- **Their position:**
- **Outcome:** who conceded, and what they had got wrong.
- **Decided by:** who.
```

`DEBT` and `CHALLENGE` are the entries that make the file worth keeping. Anyone can log
decisions; logging what was not understood, and logging the arguments you lost, is what
makes the record honest enough to be useful in six months.
## Step 0 — Read the upstream artifacts

Read `.yaait/SPEC.md` — you cannot design against requirements you have not read, and the
provenance tags matter here: an `[assumed]` requirement is a weak foundation for an
expensive structural decision, and if you find yourself designing around one, say so.

Read `.yaait/TECH.md` if it exists. Read `.yaait/DESIGN.md` if it exists — you are amending,
not replacing, and the reconcile rule applies.

If there is no `SPEC.md`, say so and offer to run `yaait:spec` first. Designing against a
verbal description is how invented requirements get baked into structure, where they are
much more expensive to remove.

## Step 1 — Declare the budget, before designing

State the size of the design **before** you produce it:

```
Budget: 4 modules, 6 types, 1 interface, 0 abstract base classes.
```

Then design within it. Every element beyond the budget must be justified out loud by
naming the **second concrete variant** that needs it — see Step 4.

Declaring the number first is the mechanism, and the ordering is the mechanism. A budget
declared afterwards is a description of what you happened to produce. "Keep it simple" is
advice nobody has ever been held to; a number you committed to before you started is
something the user can hold you to.

Set the budget from the spec, not from what feels professional. Count the requirements,
count the genuinely distinct responsibilities, and be suspicious of any number larger than
that count.

## Step 2 — Components and responsibilities

For each component: what it is responsible for, in one sentence, and what it owns. If the
sentence needs an "and" that joins two unrelated things, that is a Single Responsibility
violation showing up at design time, which is the cheapest place it will ever be visible.

State the **dependency direction** for every relationship. Most architectural smells are
properties of the dependency graph rather than of any single component, and they are only
visible once the arrows exist.

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
experiment **in a subagent**, so the throwaway implementations and benchmark output stay out
of this conversation, and record it in `EXPERIMENTS.md` with the question stated before the
run and the result labelled `measured`.

Experiment code is a spike: not defended, not smell-reviewed, not tested, deleted afterwards.
What survives is the `EXPERIMENTS.md` entry and the decision it justifies.

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

## Step 5 — Diagrams

Use **mermaid**, not PlantUML: it renders natively in GitHub, in Claude Code artifacts and
in most editors with no jar, no server and no toolchain. See `references/mermaid.md` for
the templates and the yaait conventions.

Produce, by default:

- a **class diagram** — the structure, with dependency directions;
- a **sequence diagram** for the one flow that matters most, usually the one the spec's
  primary requirement describes.

Produce additionally, whenever the condition holds:

- a **state diagram** (`stateDiagram-v2`) whenever anything has modes, phases or a
  lifecycle. Do this even when it feels obvious. Most bugs live in state transitions,
  especially the ones nobody drew, and the diagram is where a missing transition becomes
  visible rather than becoming a defect.

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

## Step 7 — Write DESIGN.md

````markdown
# DESIGN — <TTB name>

> Pre-coding blueprint. Kept true: if the code contradicts this, one of them changes
> deliberately and the change is journalled.

Format: 1
Spec: .yaait/SPEC.md

## Budget

Declared: <N modules, N types, N interfaces>. Actual: <N/N/N>.
<If actual exceeds declared, the justification for each excess element.>

## Components

### <Name>
- **Responsible for:** <one sentence, no unrelated "and">
- **Owns:** <the data or resource it is authoritative for>
- **Depends on:** <components, direction outward>

## Invariants

- <something that must always be true, checkable against code>

## The design forbids

- <a move that is out of bounds, and why>

## Structure

```mermaid
classDiagram
...
```

## <Primary flow name>

```mermaid
sequenceDiagram
...
```

## Abstractions and their justification

| Abstraction | Concrete variants today | Named event adding another | Verdict |
|---|---|---|---|
| <name> | 2 | — | justified |
| <name> | 1 | Postgres, March 2026 | justified, expires |

## Algorithms and data structures

| Decision | Choice | Complexity at our N | N is | Settled by |
|---|---|---|---|---|
| <the choice> | <what> | O(1) lookup | ~400 | X-001 (measured) |

## Deliberately not abstracted

- <the thing you were tempted to generalize and did not, and why>

## Deliberate debt taken on here

- <the compromise> — contained behind `<boundary>`; recorded as D-00N in TECH_DEBT.md

## Requirements not addressed here

- <spec requirements this design does not cover, and where they are handled instead>
````

The **"deliberately not abstracted"** section is not decoration. It is the record that the
simple choice was made on purpose rather than overlooked, and it is what stops a later
session from "fixing" it by adding the abstraction you rejected.

Write the file before seeking approval. The defense in Step 8 is where approval happens,
and a wrong design on disk is editable while a lost conversation is not.

## Step 8 — Run the defense

Select 3–5 elements. For a design, **one of them must be an abstraction or component you
added that the spec did not ask for.** That is not a suggestion. Over-engineering hides
exactly there, and it is exactly where a user will nod along, because a well-named
abstraction reads as competence.

Other productive targets: the component boundary that would be most expensive to move; an
invariant, asked about from the code's side; a dependency direction you chose; the state
transition you drew that nobody mentioned.

Good design-level defense questions:

- "Which component would you change to add a second storage backend? What if the answer is
  'three of them'?"
- "The renderer never mutates game state — which part of this structure actually stops it?"
- "I added a `MoveValidator` separate from `Board`. What breaks if I merge them?"
- "This sequence assumes the save completes before the next move is accepted. What happens
  if it does not?"
- "Which invariant does the state diagram's `paused → ended` transition threaten?"

Then journal: `APPROVAL`, `DEBT`, `CHALLENGE`, and a `DECISION` entry for each structural
choice with a rejected alternative.

## Step 9 — Close

Say whether `yaait:tech` is still needed, then stop. Do not start writing code; that is
`yaait:code`, one increment at a time.

If the design revealed that the spec is wrong — which happens, and is the design phase
doing its job — apply the reconcile rule: name it, fix `SPEC.md`, journal the change. A
design that quietly satisfies a requirement the spec does not actually state has moved the
invention problem one artifact downstream.
