---
name: tech
description: >
  Decide and defend the technology stack for the thing to build — language, runtime, build,
  test framework, key libraries, deployment target — into a .yaait/TECH.md where every
  dependency carries a version that was actually verified against current documentation
  rather than recalled, plus a falsifier ("what would make this the wrong choice") and an
  exit cost. Built specifically against training-data staleness: the deprecated library, the
  superseded idiom, the API that was renamed, the package that was dominant at training
  time and is now unmaintained. Separates inherited constraints from real decisions, since
  you are only accountable for the latter. Use whenever the user runs /yaait:tech, or says
  things like "what should we build this in", "which framework", "pick a test library",
  "what database", "is this dependency still maintained", "should we use X or Y". Invocable
  at any point — before or after design — because a stack is usually a constraint on the
  spec rather than a consequence of the design.
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

**Second: the stack is usually a constraint, not a decision.** "It's a browser game" already
fixed a great deal. Treating a constraint as though it were chosen inflates the record with
things nobody decided and buries the two or three real choices inside a wall of
inevitabilities.

## When to run this

Whenever the stack is genuinely open, or when a constraint the user could not justify is
doing damage. **Position in the sequence is not fixed** — run it before `yaait:design` when
the platform shapes the structure (it usually does), after when the design is genuinely
technology-agnostic.

If the stack is fully constrained and the constraints are sound, say so and skip this
command. Running it anyway produces a document that looks like a decision record and is
actually a rubber stamp, which is worse than no document.

## The rules that are the method

These hold for the whole of this command. The long form, with reasoning, is in
`DOCTRINE.md` at the plugin root — read it if a rule seems wrong or a situation is not
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
`DOCTRINE.md` §7.

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
## Step 0 — Read upstream

Read `.yaait/SPEC.md`, especially the **Constraints** section and the expected lifetime — a
weekend tool and a five-year service have different correct answers to every question below.
Read `.yaait/DESIGN.md` if it exists.

## Step 1 — Separate constraints from decisions, again

`yaait:spec` asked once. Ask again with specifics, because people remember constraints when
they see the slot the constraint fills.

For each layer — language, runtime, build, test framework, key libraries, deployment target,
data store — establish whether it is:

- **Constrained**, and by what: the customer's environment, an existing codebase, team
  skills, a compliance requirement, a hard deadline. Record the source. Nobody is accountable
  for choosing it.
- **Open**, and therefore a decision that has to be made and defended here.

If a constraint is doing real damage, say so **once**, with the specific cost — "Python for a
16 ms frame budget means you will fight the GC, and here is roughly what that costs" — and
then respect it. Relitigating a constraint the user cannot change is not rigour, it is noise.

## Step 2 — Verify every version, do not recall it

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

Then **label what you did**, per the doctrine's confidence rule, using exactly these words
so the user can scan for the weak ones:

- `verified` — I checked the current documentation or registry in this session.
- `recalled` — I am going from memory and have not checked.
- `inferred` — I am reasoning from a related fact.

**Any dependency still marked `recalled` when you write `TECH.md` is a defect in this
command.** If a check is genuinely impossible — no network, a private registry — say so
explicitly next to the entry rather than letting `recalled` pass silently as fact.

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

Run the experiment **in a subagent** — throwaway integrations and benchmark output do not
belong in this conversation, only the verdict and the numbers behind it — and record it in
`EXPERIMENTS.md` with the question stated *before* the run.

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
> the session that wrote this line; `recalled` means nobody checked.

Format: 1
Spec: .yaait/SPEC.md
Verified on: <YYYY-MM-DD>

## Constraints (inherited, not chosen)

| Layer | Value | Imposed by |
|---|---|---|
| Platform | Linux x86-64 | customer environment |

## Decisions

| Layer | Choice | Version | Status | Falsifier | Exit cost |
|---|---|---|---|---|---|
| Language | Python | 3.12 | verified | if we need a single binary | high |
| Tests | pytest | 8.x | verified | — | low |
| Rendering | pygame-ce | 2.5.x | verified | if we need mobile | medium |

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

## Step 6 — Run the defense

3–5 elements. For tech, always include **one pick the user made and one you made** — the
asymmetry is the point. Users defend their own choices readily and inherit yours without
noticing.

Good tech-level defense questions:

- "You picked SQLite. What happens the first time two processes write at once?"
- "I chose async here. What is the actual concurrency, and what is it for?"
- "This says pinned to 2.5.x. What breaks if someone runs `pip install -U`?"
- "The exit cost on the data store is 'high'. What specifically makes it high?"
- "We are depending on this library for one function. What does it cost us if it is
  abandoned next year?"

Then journal a `DECISION` per real choice with its rejected alternatives, plus `APPROVAL`,
`DEBT` and `CHALLENGE` as they arise.

## Step 7 — Close

Say what is next: `yaait:design` if it has not run and the criteria fire, otherwise
`yaait:code`. Then stop.

If the verification in Step 2 invalidated something upstream — the design assumed an API
that does not exist, the spec assumed a capability the platform lacks — apply the reconcile
rule now. This is the most common place for it to fire, and finding it here rather than in
`yaait:code` is this command earning its keep.
