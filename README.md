# yaait

**Yet Another AI Thing** — a software development methodology for building things with an
LLM without generating debt nobody can pay.

Six commands, one problem:

> Code accepted without being understood is the fastest debt generator ever built, and it
> compounds. The bill arrives as the tenth change costing ten times the first.

And one mechanism: a gate that fails when you cannot say what the code you just accepted
does — or a record saying you could not.

- **[MANIFESTO.md](MANIFESTO.md)** — what yaait claims, in one page.
- **[COMPARISON.md](COMPARISON.md)** — how it differs from Waterfall, Agile, Scrum and
  spec-driven development, and the evidence for the claims.
- **[METHODOLOGY.md](METHODOLOGY.md)** — the six gates, and the rules that govern them.

## The short version

**The problem:** code is accepted faster than anyone can understand it, and every unread
change makes the next one harder to read. Measured across hundreds of millions of commits,
borrowing has accelerated an order of magnitude while servicing has collapsed — the numbers
and sources are in [COMPARISON.md](COMPARISON.md).

**Why no existing method catches it:** design used to be expensive, so Waterfall bought it
up front and committed to it. Then
rework got cheap, so Agile stopped buying design and let structure emerge. Now design, code
*and* rework are all cheap — and **only understanding is still expensive.** yaait is built
around the one scarce input.

The specific thing that broke: writing code used to be how you came to understand it.
Authorship implied comprehension, by construction, and every Agile practice quietly depended
on it — emergent design, "the code is the documentation", collective ownership by osmosis.
That link is severed. yaait restores comprehension by other means, because writing no longer
does it.

## The commands

| Command | What it does |
|---|---|
| `/yaait:spec` | Discuss the thing to build (the **TTB**). Every requirement tagged `[stated]`, `[inferred]` or `[assumed]`, so invented requirements are visible. Forces non-goals, falsifiable acceptance criteria, and "how would we know this is wrong". |
| `/yaait:design` | The blueprint, before the code. Components, invariants, what the design **forbids**, mermaid diagrams — under a **declared size budget** that every extra abstraction must justify by naming a second concrete variant. Optional; `spec` recommends it against stated criteria. |
| `/yaait:tech` | The stack, with every version **verified** against current docs rather than recalled, plus a falsifier and an exit cost per choice. Optional, and invocable at any point. |
| `/yaait:code` | One increment at a time, with tests. Enforces the hardest rule: **defend the code you are about to modify, before you modify it.** |
| `/yaait:stest` | System test traced clause by clause against the spec. **You observe the critical path yourself**, and the report must say what was *not* tested. |
| `/yaait:debt` | Reads the accumulated receipts in `TECH_DEBT.md` and answers what an increment cannot: which debt is actually costing money, which is dormant and should be closed, and which has recurred often enough to have become a *product* problem needing a roadmap item. Triggered from `:code` and `:stest`, and invocable directly for the questions managers ask. |

Nothing is mandatory except honesty about which gates you skipped.

## What it feels like

Three things will be unfamiliar.

**It argues with you.** Not always — only when it can name the failure mode, who it hurts and
what it costs. If it cannot fill in all three, it agrees in one sentence and moves on. When
you win the argument, it says so and writes it down, including what it had got wrong.

**It asks you questions you cannot bluff.** Never "are you familiar with RAII?" — people
systematically overrate their own understanding, and the illusion only collapses when they
try to *explain*. So instead: "where is the lock released if that throws?" A specific
question with a checkable answer that exists in the artifact.

**When you cannot answer, that is fine.** You get buttons: *I'll explain it* / *Explain
&lt;concept&gt;* / *Show me where this bites* / *Record as debt and move on*. Clicking
"Explain RAII" costs nothing; typing "I don't know what RAII is" is a confession, and the
button exists precisely to remove that tax. Declining is allowed too — it logs a `DEBT` entry
naming exactly what is undefended. A gate that blocks gets routed around, and then there is
no record at all.

## What it produces

In your project, not in this plugin:

```
<project root>/
├── TECH_DEBT.md      outstanding structural debt, with dated evidence of what it has cost
├── EXPERIMENTS.md    decisions settled by measurement, labelled `measured` or `predicted`
└── .yaait/
    ├── SPEC.md       the TTB: kind (new/fix/feature), requirements with provenance,
    │                 non-goals, acceptance criteria
    ├── DESIGN.md     optional: components, invariants, budget, diagrams
    ├── TECH.md       optional: the stack, verified versions, falsifiers, exit paths
    └── JOURNAL.md    append-only: DECISION, APPROVAL, DEBT, CHALLENGE
```

Two files sit at the root because a team reads them on their own account. `TECH_DEBT.md` holds
*structural* debt — a live balance, paid and removed — and every item carries **evidence of
what it has actually cost**, dated, rather than an estimate of what it might. An estimate is
arguable; a list of receipts is not. Every item also records whether it is **contained** behind
a boundary or **spread** across N call sites, which predicts whether it will ever be repaid
better than any cost estimate does.

`DEBT` and `CHALLENGE` are the entries that make the journal worth keeping. Anyone can log
decisions. Logging what you did not understand — and the arguments the LLM lost — is what
makes the record honest enough to be useful in six months.

`/yaait:spec` also installs a short doctrine block in your project's `CLAUDE.md`, so later
sessions honour the reconcile rule and know not to let `SPEC.md` rot even when no yaait
command is invoked.

## Install

```bash
claude plugin marketplace add dgutson/yaait
claude plugin install yaait@yaait-marketplace
```

Or from a local clone:

```bash
claude plugin marketplace add /path/to/yaait
claude plugin install yaait@yaait-marketplace
```

## Technical debt is first-class

Ward Cunningham meant something specific by "technical debt": deliberate borrowing, understood
at the time, taken on to ship, with intent to repay. What the phrase degraded into is a label
for code that is merely bad — unpriced, unrecorded, and therefore not a debt at all but a loss
someone will discover later.

yaait takes the original literally. For a compromise to count as debt rather than damage it
must be **chosen**, **written down**, and **contained**:

> Put the deliberate shortcut behind a boundary — one function, one class, one module — so it
> does not leak into everything that touches it and so paying it off later is bounded to that
> one implementation. A litter box works because the mess has an edge, not because the cat
> improved. Debt smeared across forty call sites has no edge, so its repayment cost is
> unbounded, which is a longer way of saying it will never be repaid.

None of this is a craft argument. The cost never presents as "bad code." It presents as
deceleration, then as defects reaching customers because nobody knew what the change would
break, then as estimates that mean nothing — and at the end as technical bankruptcy, where
servicing costs more than the team can produce and the only moves left are rewrite or
abandon. Elegance is not the goal anywhere in this method. The goal is that **the tenth
change costs roughly what the first one did.**

## When not to use it

Throwaway scripts, spikes, notebooks, code with a known deletion date. A methodology that
claims to apply everywhere is selling something — see the last section of
[COMPARISON.md](COMPARISON.md).

Use it for code that will be maintained, extended, or blamed.

## Status

Early. `skills/code/references/review.md` is explicitly **provisional** pending a discussion
of Clean Code — see `ROADMAP.md`.

## License

MIT
