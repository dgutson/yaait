# yaait vs. what came before

This document exists because "here is another methodology" is a claim that has to be
earned, and because the honest way to earn it is to say precisely what is being kept, what
is being dropped, and on what evidence. The [MANIFESTO](MANIFESTO.md) is the declaration.
This is the argument.

## The one-paragraph version

An unattended LLM is a technical-debt reactor. Code accepted without being understood
compounds: each unread change makes the surrounding code harder to read, so the next one is
likelier to go unread too. Stopping that is what yaait is for. Why no existing method stops
it is a matter of arithmetic. Waterfall optimized for a world where rework was ruinous;
Agile optimized for a world where design was speculative; both of those costs have now
collapsed, because design, code, and rework are all cheap. The only expensive input left is human
understanding — which cannot be generated, only built. So yaait is what you get when you
take waterfall's **gates**, drop
waterfall's **commitments**, keep Agile's **iteration**, drop Agile's **assumption that
whoever wrote the code understands it**, and make the binding constraint an explicit
gate: *can the human defend this?*

## Every methodology is arithmetic

| | Cost of design | Cost of rework | Therefore | Failure mode |
|---|---|---|---|---|
| **Waterfall** | high | catastrophic | buy design up front, commit to it | reality contradicts the plan and the plan wins |
| **Agile / Scrum** | high | low | skip design, let structure emerge | structure never emerges; refactoring is always next sprint |
| **yaait** | ~zero | low | gate everything, commit to nothing | ceremony fatigue — you stop invoking it |

Each row is a rational response to its own column. None of them was stupid. The point of
the table is that **the columns changed**, and a method whose arithmetic no longer holds
keeps running anyway, because methods are social objects and not just technical ones.

Note yaait's failure mode. It is stated because it is real, it is the one to watch for, and
a method that will not name its own is not being honest with you.

---

## What the failure costs

The manifesto states this progression in five lines. Here is the argument behind it.

**The honeymoon is the mechanism, not an exception to it.** The first weeks with a competent
generator are faster. That is what installs the habit: you are rewarded immediately for
accepting code you did not read, and a practice that pays on day one spreads without anyone
deciding to adopt it. Nothing that hurts from the start propagates this quickly.

**Deceleration is not experienced as debt.** Each change costs more than the last, and the cost
is not confined to a corner you can route around — you pay it on every change that touches the
same code, which is the only kind of change that ever happens, because the code that matters is
the code people keep touching. A credit card at least discloses its rate. This does not, so
nobody can work out whether the borrowing was a good trade, which makes unpriced debt harder to
manage than priced debt rather than easier.

**Defects reach customers through the same mechanism, not a second one.** Whoever accepted the
change could not know what it would break, so they did not know they had broken it. The
comprehension failure and the field defect are one event observed at two different times.

**Estimates then stop meaning anything.** First they double; then nobody can say when anything
will be done. That is the point management notices, and it is noticed as "the team got worse"
rather than as a debt balance.

**The terminal state is technical bankruptcy**: servicing costs more than the team can produce,
and the only remaining moves are rewrite or abandon. A rewrite of code nobody understood is a
guess.

**None of it is visible from inside** — see *The perception gap* under The evidence, below.

---

## vs. Waterfall

### First, the correction

Waterfall's canonical source argues *against* waterfall. Winston Royce's 1970 paper
"Managing the Development of Large Software Systems" draws the linear
requirements→design→code→test→deploy diagram and then says, of that very diagram, that the
approach is **"risky and invites failure."** The rest of the paper adds feedback loops,
argues for prototyping, and recommends doing the whole thing twice.

The industry read the first figure, skipped the rest, and built forty years of practice on
a straw man from a paper written to knock it down. So "back to waterfall" is a return to
something that was never actually recommended by the person credited with it.

### What waterfall got right, and why it stopped working

Waterfall's real content was **gates**: a point where an artifact is examined by humans
before anything downstream is built on it. Gates are good. Gates are how you find a
misunderstanding while it is still a paragraph instead of a subsystem.

What killed waterfall was not the gate. It was that **rework was ruinously expensive**,
and that fact turned every gate into an irreversible commitment. Once a spec was signed,
the cost of being wrong about it exceeded the cost of shipping the wrong thing — so
organizations shipped the wrong thing, and called the process discipline.

Rework is now cheap. That single change decouples the gate from the commitment.

### Where yaait lands

| | Waterfall | yaait |
|---|---|---|
| Phases | sequential, signed off | sequential by default, re-enterable at any time |
| A gate means | "this is now fixed" | "a human has examined this" |
| Contradiction between doc and code | the doc wins; change requests, boards | the world wins; reconcile immediately, either direction |
| Design | produced once, up front | produced up front, regenerated whenever it is wrong |
| Cost of going back | project-threatening | an afternoon |
| Who is accountable | the sign-off | the person who can answer the question |

**yaait takes waterfall's gates without waterfall's commitment.** That is the whole of the
relationship.

---

## vs. Agile — and specifically vs. Scrum

### The manifesto mostly survives

The four values, checked one at a time against a world with competent code generators:

| Agile value | Status under yaait |
|---|---|
| Individuals and interactions over processes and tools | **Kept, intensified.** yaait is discussion-centric; the discussion *is* the method. |
| Customer collaboration over contract negotiation | **Untouched.** A model does not know what your customer wants. |
| Responding to change over following a plan | **Kept, strengthened.** Replanning is now nearly free, so responding to change can mean regenerating the plan rather than abandoning it. |
| Working software over comprehensive documentation | **Dissolved.** Not because documentation won — because the *tradeoff* disappeared. A spec is no longer a rotting cost centre; it is a cheap, machine-actionable input. There is no longer an "over" to choose. |

Three of four survive. That is not obsolescence. Anyone claiming LLMs killed the Agile
Manifesto has not checked it line by line.

### What actually broke is one sentence nobody wrote down

**Agile practice assumed that whoever wrote the code understood it.**

It was never a stated principle, which is precisely why it was never defended. It was load-
bearing anyway. Writing *was* the comprehension mechanism: you could not produce a line
without having thought it, so comprehension came free with authorship and no practice
needed to spend a minute on it.

Everything downstream inherited that free lunch:

- **Emergent design** — safe only if the people the design is emerging *through* understand what they are building.
- **"The code is the documentation"** — true only if reading it reconstructs the author's intent, which assumes the author had one.
- **Collective ownership by osmosis** — osmosis through people who wrote adjacent code.
- **YAGNI** — a judgment call requiring someone with the judgment to make it.
- **Definition of Done** — a checklist that has never, in any published template, contained "someone can explain this."

Sever authorship from comprehension and every one of those still runs, still passes its
ceremony, and no longer does the thing it was for.

### Scrum is the specific target

Scrum is where this hurts most, and it deserves to be named rather than hidden inside
"Agile."

- **There is no design gate anywhere in it.** Backlog → sprint planning → build → review →
  retrospective. Architecture is expected to emerge. There is no event, artifact or role
  whose job is "is this structure right before we build on it."
- **The unit of planning is the time box, not the artifact.** Two weeks, whatever fits.
  This is structurally hostile to "this one has to be right before anything else starts."
- **Not one Scrum metric has ever measured comprehension.** Velocity, story points,
  burndown, throughput, cycle time — every one measures production. The bottleneck moved
  to verification and the instrument panel did not move with it.
- **Technical debt is managed by intention.** The remedy on offer is "prioritize
  refactoring in the backlog," which is a request, not a mechanism, and it loses to feature
  work approximately always.
- **Retrospectives inspect the process, not the artifacts.** The only built-in feedback
  loop looks at how the team worked, never at whether the thing they built is any good.

That is a management framework — a good one, for making delivery cadence predictable. It
has never claimed to be an engineering discipline, and treating it as one is how a decade
of debt got booked as velocity.

This critique is not novel and not hostile to Agile's origins. **Dave Thomas, one of the
seventeen authors of the Agile Manifesto, proposed retiring the word "Agile" in 2014**,
writing that it "has been subverted to the point where it is effectively meaningless, and
what passes for an agile community seems to be largely an arena for consultants and
vendors to hawk services and products." yaait does not contradict the manifesto. It
contradicts what was done to it.

### What "technical debt" was supposed to mean

Ward Cunningham coined the term, and he meant something specific that the industry
subsequently lost: **deliberate borrowing, understood at the time, taken on to ship, with an
intention to repay.** The debt was the *decision*, and like any loan it could be a good one.

What the phrase degraded into is a label for code that is merely bad — unintentional, unpriced,
unrecorded, and therefore not a debt at all but a loss someone will discover later. A loss
cannot be managed, because nobody chose it and nobody knows what it costs.

yaait takes Cunningham's version literally, and that is the whole design of `TECH_DEBT.md`.
For a compromise to count as debt rather than a loss it needs three things: it was
**chosen**, it is **written down**, and it is **contained** behind a boundary so the
repayment has a known edge. Anything failing those tests is not debt being managed; it is
damage awaiting discovery.

Damage awaiting discovery has a terminal state, and the loan metaphor names that too:
**technical bankruptcy** — servicing the accumulated debt costs more than the team can
produce, so the only remaining moves are rewrite or abandon. A rewrite of code nobody
understood is a guess, which is what makes the terminal state worse than it sounds.

This matters more under AI assistance than it did in 1992, for a reason that is arithmetic
rather than moral: the rate at which unintentional compromise can be produced has gone up by
an order of magnitude, and the rate at which it is repaid has fallen. See the table below.

### Emergent design was a loan, and the repayment stopped

This is the strongest empirical claim in this document, so here is the whole argument.

Emergent design was never "do not design." It was **design continuously, through
refactoring** — take on structural debt deliberately, then pay it down as you learn. The
loan was fine. The loan had a repayment plan.

The repayment plan has stopped running. Across 623 million commits, GitClear's 2026
analysis finds, comparing recent years against a 2022 baseline:

| Signal | Direction | What it measures |
|---|---|---|
| Refactoring line-moves | **−70%** | debt being paid down |
| Cross-file function calls | **−35%** | reuse — the payoff of good structure |
| Long-term legacy maintenance | **−74%** | going back to old code at all |
| Code block duplication | **+81%** | debt being taken on |
| Within-commit copy/paste | **+41%** | debt taken on inside a single change |
| Error-masking constructs | **+47%** | failures made invisible |
| Two-week code churn | **+15%** | code rewritten almost immediately |

2024 was the first year on record in which **within-commit copy/paste exceeded moved
code** — the industry now duplicates more than it refactors, in the same commit.

Borrowing accelerated. Servicing collapsed by seventy percent. Emergent design did not
merely fail to deliver structure; its *only* debt-service mechanism has largely stopped
running, while the borrowing mechanism got an order of magnitude faster.

There is no version of emergent design that survives that table.

That table is also the evidence for the [MANIFESTO](MANIFESTO.md)'s central claim. A
generator that borrows an order of magnitude faster than it repays is not a productivity
tool with a quality problem; it is a debt reactor, and its terminal state is a codebase
whose servicing cost exceeds what the team can produce.

### Where yaait lands

| | Scrum | yaait |
|---|---|---|
| Unit of planning | the sprint (time) | the artifact (spec, design, increment) |
| Design | emerges | precedes, explicitly, with a declared size budget |
| Debt control | "prioritize refactoring" | a gate that will not pass an undefended abstraction |
| Metrics | velocity, burndown | defended vs. undefended artifacts; recorded comprehension debt |
| Done means | acceptance criteria met | acceptance criteria met **and** someone can defend it, or the record says they cannot |
| Review inspects | the process | the artifacts |
| Feedback on structure | the retrospective, eventually | the reconcile rule, immediately |

---

## vs. spec-driven development

This is yaait's nearest neighbour and the comparison that matters most, because the
artifacts look almost identical.

Spec-driven development — GitHub Spec Kit, AWS Kiro, BMAD and the rest — makes a written
spec, not the chat history, the source of truth, and runs a loop of roughly
**specify → plan → tasks → implement**, each stage a file the next stage reads. It is a
genuine advance over prompting, and yaait agrees with essentially all of its mechanics.

The difference is what the spec is *for*.

| | Spec-driven development | yaait |
|---|---|---|
| The spec is authoritative for | **the machine** — it is the generator's input | **the human** — it is what you will be examined on |
| Optimizes | agent throughput; reducing rework from misunderstanding | human defensibility; reducing shipped code nobody understands |
| Human role | author and approver of the spec | author, approver, **and defendant** |
| Approval means | "proceed" | "I can answer questions about this" — or an explicit logged exception |
| Disagreement | not modelled | a first-class artifact, including who conceded |
| Success looks like | the implementation matches the spec | the implementation matches the spec **and** a named person can explain why it is built this way |
| What it prevents | the agent building the wrong thing | you shipping the right thing for reasons you cannot reconstruct |

The two are **complementary, not competing.** Spec Kit will give you better spec mechanics
than yaait's `spec` command does, and yaait is happy to run on top of it: point
`yaait:code` at a Spec Kit spec and the defense, the reconcile rule and the journal all
work unchanged.

What spec-driven development does not have is a mechanism that fails when the human does
not understand what was produced. Its gates check the *artifact*. yaait's gates check the
*person*. The debt is why yaait exists; that gate is the only mechanism anyone has found
that stops it.

---

## The evidence

Four findings do most of the work in this document.

**1. The perception gap is real and inverted.** METR's randomized controlled trial put 16
experienced open-source developers through 246 real tasks on mature repositories averaging
over a million lines. With AI tools they were **19% slower**. Afterwards they estimated
they had been **20% faster**. They expected 24% before starting, and revised *down* only
to 20% after living through the slowdown.

The sample is small and its authors cautioned against generalizing from it, so treat the
magnitude as indicative rather than settled. The number is not the point. The *direction of the
error* is the point: the practitioners
closest to the work, with the most experience, could not perceive a 19% regression from the
inside. Self-assessment of AI-assisted productivity is not merely noisy — it has the wrong
sign. Every methodology that relies on developers noticing when things are going badly
inherits that defect.

**2. The maintainability signals all point the same way.** GitClear's 623-million-commit
table above. Duplication up, reuse down, refactoring down, error-masking up. These are not
opinions about code style; they are counts.

**3. Self-reported understanding is the wrong instrument, and there is a right one.**
Rozenblit and Keil's work on the *illusion of explanatory depth* (2002) established that
people systematically overestimate the depth of their own explanatory knowledge — and,
crucially, that **the illusion collapses when they are asked to explain.** Self-rated
understanding drops measurably after the attempt.

This is the finding yaait is built on, and it has a direct, unavoidable design consequence:
**"are you familiar with X?" measures nothing.** It surveys a self-assessment already known
to be inflated, and it does so under social pressure that makes "no" costly to say. The
only reliable probe is a request for explanation. That is why yaait's central mechanism is
a question you cannot answer by nodding — and why failing it triggers teaching rather than
blame, since the failure is the *normal* result, not a character flaw.

**4. The bottleneck has moved, and it is measurable.** Work on the
"productivity–reliability paradox" reports telemetry of **98% more pull requests but 91%
longer review times, with flat delivery metrics** — and names the code review bottleneck as
the mechanism amplifying it. Production roughly doubled. Verification got slower. Delivery
did not move.

That is the whole thesis in one line of telemetry. When production doubles and delivery
stays flat, the constraint is downstream of production, and pouring more generation into
the top of the funnel cannot help.

---

## When not to use yaait

A methodology that claims to apply everywhere is selling something. Do not use yaait for:

- **Throwaway scripts.** One-shot data munging, a shell pipeline you will run once. There
  is nothing to maintain and nobody to defend it to.
- **Spikes and exploration.** The point of a spike is to learn cheaply by building
  something wrong on purpose. Gating that is a category error. Spike first, then bring the
  *question you answered* to `yaait:spec`.
- **Notebooks and analysis.** Different discipline entirely; the artifact is the finding,
  not the code.
- **Code with a known deletion date.** A demo for next Thursday. Understanding it has no
  future value.
- **Anything where you are genuinely the only reader, forever.** yaait's gates are about
  defensibility to someone else, including your own future self — but if that reader
  provably does not exist, the gates cost without paying.

Use it for code that will be maintained, extended, or blamed. Which, in practice, is most
of the code that matters, and reliably includes several things you were sure were
throwaway.

---

## Sources

- Winston Royce, *Managing the Development of Large Software Systems* (1970) — and David
  Wheeler's account of its misreading: <https://dwheeler.com/essays/waterfall.html>
- Dave Thomas, *Agile is Dead (Long Live Agility)* (2014):
  <https://pragdave.me/thoughts/active/2014-03-04-time-to-kill-agile.html>
- METR, developer productivity RCT: <https://metr.org/blog/2026-02-24-uplift-update/>
- GitClear, *The Maintainability Gap: 2026 AI Code Quality Research*:
  <https://www.gitclear.com/the_ai_code_quality_maintainability_gap>
- Rozenblit & Keil, *The misunderstood limits of folk science: an illusion of explanatory
  depth* (2002): <https://en.wikipedia.org/wiki/Illusion_of_explanatory_depth>
- *The Productivity-Reliability Paradox: Specification-Driven Governance for AI-Augmented
  Software Development*: <https://arxiv.org/abs/2605.01160>
- GitHub Spec Kit: <https://github.com/github/spec-kit>
