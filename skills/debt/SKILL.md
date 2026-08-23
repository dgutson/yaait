---
name: debt
description: >
  Analyse TECH_DEBT.md across its accumulated evidence and answer what individual increments
  cannot: which debt is actually costing something, which items have gone quiet and should be
  closed as won't-fix, and which have recurred often enough to stop being a code-quality
  issue and become a product problem needing a ROADMAP item. Runs the sweep in a subagent so
  the whole file's history does not land in the conversation. Use whenever the user runs
  /yaait:debt, when /yaait:code has filed several receipts on one item, or at the end of a
  cycle from /yaait:stest. Use it especially for the questions a manager actually asks —
  "why does this keep failing at customer sites", "why is this area always slow to change",
  "why did that estimate double", "what would it cost to make this maintainable" — because
  the receipts in TECH_DEBT.md are the only evidence that answers them with dates rather than
  opinion. Also use it when someone asks whether a refactor is worth funding.
---

# yaait:debt — what the debt is actually costing

## Why this command exists, and what it refuses to be

Every other command in yaait works on one thing at a time: one spec, one design, one
increment. This one works on **accumulated evidence across time**, which is a different
activity and cannot be done inside an increment. Recurrence is only visible from above.

It also exists because of a criticism yaait makes of Scrum, which this method would otherwise
reproduce. Scrum's answer to technical debt is "prioritize refactoring in the backlog" — a
*request*, not a mechanism, and it loses to feature work approximately always. A
`TECH_DEBT.md` that nothing ever forces anyone to read is that same backlog with a new
filename. This command is the mechanism, and `yaait:code` and `yaait:stest` suggest it so it
does not depend on anybody remembering.

**It is a diagnostic command, not a bookkeeping one.** Its most valuable use is answering a
question somebody asked in a meeting, with dates instead of opinions.

## Run the sweep in a subagent

`TECH_DEBT.md` accumulates: items, receipts, dates, closed entries. Reading the whole history
into this conversation costs context that the rest of the session needs, and the conversation
wants the *verdict* and the evidence behind it, not the raw file.

So delegate the read-and-correlate work to a subagent: give it `TECH_DEBT.md`, `ROADMAP.md`,
`HISTORY.md` and the relevant `JOURNAL.md` range, and have it return the structured findings
below. Then do the judgment — escalation, closure, what to tell the user — in the main
conversation, where the user can argue with it.

Correlating with `git log` is worth it when the question is "why is this area always slow":
churn concentrated in one module, over months, is evidence a debt item is real even when
nobody filed a receipt for it.

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

The rules that follow are this loop's hardest steps in detail: how to discuss, how to verify,
how to deliver it without a wall of text, and what to do when reality disagrees with something
already written down. `METHODOLOGY.md` §2.

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
## Step 0 — Establish which question you are answering

This command has three quite different modes, and answering the wrong one wastes everybody's
time. Ask, or infer it from how you were invoked:

- **Triggered review** (from `yaait:code` or `yaait:stest`) — one or a few items just gained
  receipts. Scope the analysis to those, decide escalation, stop. Do not sweep the whole file.
- **Periodic sweep** (manual, no specific question) — the whole file. Classify every item,
  close the dead ones, escalate the recurrent ones.
- **A specific question** — "why does this keep failing at customers", "why is this so slow to
  change", "is this refactor worth funding". Work backwards from the question to the evidence,
  and answer *that*. Do not deliver a sweep to somebody who asked one thing.

If the question came from a manager rather than from the code, say so in the output shape:
they need the cost and the decision, not the mechanism.

## Step 1 — Classify every item in scope

Four outcomes. Every item in scope gets exactly one.

**Paying interest** — has receipts, recent ones, and the code is still being touched. This is
real debt doing real damage. It is a candidate for repayment now.

**Dormant** — no receipts, or none in a long time, and nobody is touching the code. **Debt on
code nobody touches accrues no interest.** Say so plainly rather than carrying it as
permanent guilt: a file full of items nobody will ever pay is a file nobody reads, and then
the real items are invisible too.

**Recurrent → escalate.** Enough receipts, over enough time, that this has stopped being a
code-quality issue. See Step 2.

**Won't fix** — dormant and *structurally* unlikely to matter: a module being retired, a
platform being dropped, a customer being migrated off. Close it, with the reason. Closing an
item is a decision and gets a `JOURNAL.md` `DECISION` entry, not a silent deletion.

Be willing to reach "dormant" and "won't fix" often. A debt file that only grows is a file
that will be abandoned, and the discipline that keeps it credible is closing things.

## Step 2 — Escalate recurrent debt to a product problem

This is the judgment the command exists to make.

When one item has accumulated several receipts across several increments, it has usually
stopped being "the code here is awkward" and become something a non-engineer would recognise:

- **the product cannot do a class of thing** — every feature touching this area is quoted at
  2x, so features in that area quietly stop being proposed;
- **the product fails in the field for one reason, repeatedly** — the receipts are customer
  incidents, not internal annoyances;
- **estimates in one area are systematically unreliable**, which is a planning problem before
  it is an engineering one.

When that is what the evidence shows, **file a `ROADMAP.md` item at product level** — phrased
in terms of the capability gained or the failure class eliminated, not in terms of the
refactor. "Save format supports history" is a roadmap item somebody can prioritise;
"refactor the store" is one that never gets funded, and the difference is not cosmetic — it is
whether the person deciding can see what they are buying.

Keep the `TECH_DEBT.md` item open, and cross-reference the roadmap ID. The debt is still
there; what changed is who is now deciding about it.

**Threshold.** There is no universal number. Two receipts on a hot path matters more than six
on something cold. Judge by whether the pattern would persuade somebody who does not care
about code — and say which receipts you are relying on, so they can disagree with the
evidence rather than with your conclusion.

## Step 3 — Report

Lead with the answer, not the method. If somebody asked "why does this keep failing", the
first line is why, and the analysis follows for whoever wants it.

```markdown
## Debt review — <scope>, <date>

**Answer:** <one or two sentences. The actual finding.>

### Paying interest
- **D-001** — 3 receipts since 2026-08. Two customer incidents, one 2x estimate.
  Contained behind `store.save()`; repayment ~1 day. **Recommend paying next cycle.**

### Escalated
- **D-004** → filed R-011 "Save format supports history". 5 receipts across 4 months; every
  feature touching history has been quoted at 2x. This is a product constraint now.

### Dormant
- **D-002** — no receipts in 5 months, module untouched. Carrying, not acting.

### Closed as won't fix
- **D-003** — the Windows XP code path is being dropped in Q4. Closed, journalled.

### Not covered by any item
- <debt you found while looking that nobody had filed, now added>
```

State the **containment** status of anything you recommend paying. A contained item has a
bounded repayment cost and can be scheduled honestly; a spread one cannot, and saying "one
day" about spread debt is how refactors overrun.

## Step 4 — The defense

Lighter here than in the other commands, because the artifact is an argument rather than code
— but the argument is what someone may spend money on, so it has to hold.

Two or three questions, aimed at the conclusions rather than at the file:

- "I escalated D-004 on five receipts. Which of those five would you drop, and does the case
  survive without it?"
- "I called D-002 dormant. What would have to happen for that to be wrong?"
- "Repayment on D-001 is one day *because* it is contained behind `store.save()`. What outside
  `store/` currently knows the save format?"
- "This says the product cannot support history. Is that actually true, or is it just
  expensive?"

That last question matters most and is the one you are most likely to have got wrong:
**escalating debt that is merely inconvenient into a product problem is a way of getting a
refactor funded by overstating it**, and doing that once costs the credibility of every future
escalation. If the honest answer is "expensive, not impossible", say expensive.

Journal `DECISION` for each closure and each escalation, and `CHALLENGE` for anything argued
about.

Then stop. Do not start repaying debt — that is a TTB, and it goes through `yaait:spec` like
anything else.
