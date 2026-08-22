# The yaait Manifesto

*Yet Another AI Thing.*

> **Generating code is no longer the bottleneck. Understanding what you just accepted is.**
>
> **Accept without understanding and you add slop on top of slop, until the codebase carries
> a debt load no team can repay.**

Slop compounds. Every change nobody read makes the surrounding code harder to read, so the
next change is likelier to go unread too. Borrowing accelerates by an order of magnitude while
servicing collapses: across hundreds of millions of commits, duplication is up, refactoring is
down, error-masking is up, and the industry now duplicates more code than it refactors inside
the same commit. [COMPARISON.md](COMPARISON.md) has the numbers and the sources.

## The schedule

Nobody experiences this as "technical debt." They experience it in this order:

- **The honeymoon.** The first weeks are faster. You are rewarded immediately for accepting
  code you did not read, so the habit sets before the cost appears, and a practice that pays
  on day one spreads without anyone deciding to adopt it.
- **Deceleration.** Each change takes longer than the last. The debt is not in a corner you
  can route around; you carry it on every change you make. A credit card tells you its rate.
  This does not, so nobody can work out whether the borrowing was a good trade.
- **Defects reaching customers.** The same failure, landing outside the building: whoever
  accepted the change could not know what it would break, so they did not know they had.
- **Estimates stop meaning anything.** First they double. Then nobody can say when anything
  will be done — the point management notices, usually as "the team got worse."
- **Technical bankruptcy.** Servicing costs more than the team can produce. Nothing is left
  but rewrite or abandon, and a rewrite of code nobody understood is a guess.

None of this is visible from inside. Experienced developers on large codebases, measured at
**19% slower** with these tools, estimated afterwards that they had been 20% faster.
Self-assessment of AI-assisted productivity does not merely have error bars — it has the wrong
sign, which is why the schedule above runs to completion without anyone raising an alarm.

These are business costs, and the need underneath them is **the ability to keep changing the
product at a predictable cost.** Elegance is not a goal here. The goal is that **the tenth
change costs roughly what the first one did.**

## Why now

Every methodology is arithmetic. Waterfall answered a world where design was cheap and rework
was ruinous: buy design up front, commit to it. Agile answered the inversion — rework cheap,
design speculative: stop buying design, let structure emerge. Both were rational responses to
their own cost structures.

Both of those costs have now collapsed. A specification takes minutes. An architecture can be
regenerated on demand. **Only understanding is still expensive**, and it is the one input that
cannot be generated.

What broke is a sentence nobody wrote down: **writing code used to be how you came to
understand it.** Authorship implied comprehension by construction — you could not type a line
without having thought it. Emergent design, "the code is the documentation" and collective
ownership by osmosis all leaned on that without stating it, so nobody defended it. The link is
now severed. Code exists in production that no human ever understood — not when it was
written, not since — and every one of those practices still runs and still passes its
ceremony.

## The mechanism

If the cause is code accepted without comprehension, the only thing that stops it is a gate
that fails when comprehension is absent.

Not a gate on the artifact. The artifact looks fine — that is the problem. Wrong work used to
look wrong: incomplete, uncompiled, visibly a draft. Wrong work now arrives finished,
formatted, commented, tested against its own misunderstanding, and indistinguishable from
right work by inspection. Looking at it is no longer enough.

So the gate is on the person: not "do you understand this?" but a question with a checkable
answer that exists in the artifact.

There are six, one for each artifact that can be wrong: **spec** — what to build; **design** —
how it is structured; **tech** — what it is built on; **code** — each increment, including the
code you are about to modify; **stest** — whether it does what the spec said; **debt** — what
the accepted compromises have cost so far. Each produces a file, and each ends by asking the
human something they can only answer if they understood what was produced.

## Values

We value the things on the left. We refuse to let the things on the right stand in for them.

- **Defensible artifacts** over *delivered* artifacts
- **Demonstrated understanding** over *claimed* familiarity
- **Recorded disagreement** over *smooth* agreement
- **Cheap gates** over *committed* plans
- **Named assumptions** over *plausible* completeness

## Principles

**1. Understanding is the deliverable; working software is only the evidence.** Software that
works for reasons nobody can state was not delivered — it was borrowed.

**2. Defending is not reciting.** It means answering a question you were not prepared for,
about a decision you did not personally make. Silence is the only unacceptable answer.

**3. Undefended is allowed. Undefended and unrecorded is not.** Ship what you do not
understand when the deadline is real — in writing, naming exactly what is undefended. A
method that pretends every approval was informed is lying. But the log is not an archive:
code that goes undefended across several increments is promoted to structural debt carrying a
named repayment cost, because a record nobody reads is cheaper than the work it stands in for,
and anything cheaper than the work replaces it.

**4. Ignorance is a state, not a verdict.** The engineer who does not know is one conversation
from the engineer who does. The engineer who *pretends* to know is unreachable. So asking is
free here, and admitting you do not know a term is never remembered against you.

**5. The machine's job is to arm you, not only to challenge you.** It teaches the concept it
just used, on demand, without being asked twice and without making you feel small for needing
it. A challenge you cannot answer is not a review; it is an oracle.

**6. The machine argues back only when it can name the failure mode, who it hurts and what it
costs.** Otherwise it agrees in one sentence and moves on. An assistant that agrees with you
is an expensive way to be wrong in private — and contrarianism on command is sycophancy with
the sign flipped.

**7. Nothing is decided in a conversation.** Conversations evaporate. What was decided, what
was rejected, what was approved without being understood, and what was *not done* all go on
disk, or they did not happen. An honest boundary around the work is part of the work.

**8. The document never outranks the world.** Rework is cheap now, so an artifact contradicted
by reality gets fixed rather than defended. Nor does the code silently win, which is how
design documents become lies.

**9. Simplicity is a declared number, not an aspiration.** "Keep it simple" is advice nobody
has ever been held to. Every abstraction past the number is justified by naming a second
concrete thing that needs it — because an LLM will hand you nine classes for a three-class
problem and make every one of them sound necessary.

**10. Debt is allowed. Hidden debt is not, and smeared debt is not.** Put the deliberate
shortcut behind a boundary — one function, one class, one module — so repayment has a known
edge. A litter box works because the mess has an edge, not because the cat improved. Debt
smeared across forty call sites has no edge, so its repayment cost is unbounded and it will
never be repaid. This is the one abstraction that needs no second variant: its justification
is a dated intention to replace the first.

**11. The multiplier acts on judgment.** A knowledgeable engineer with an LLM beats one
without. An unknowledgeable engineer with an LLM beats nobody — expensively, and at volume.

**12. The machine does not replace the junior. It is how the junior becomes a senior.** An
organization that stops hiring juniors because a model produces their output stops producing
seniors, and seniors are the only people who can judge whether the model's output is any good.
That is eating the seed corn on a five-year clock, which makes teaching the highest-return use
of the tool.

## The accountability clause

The human whose name is on the commit must be able to defend it under questioning.

Or the record must say they could not.

Nothing else is accountability. Everything else is attribution.

## What yaait is not

**Not free.** It costs you this week and pays back by the tenth change. It will make some
things slower on purpose, and the parts it slows down are the parts where being fast was never
the point. If there will be no tenth change, do not pay.

**Not measured.** Every number here is about the problem. None is about the method, because
yaait has not yet been run at scale. A method whose seventh principle is *say what you did not
do* has to declare that first, and what it costs per increment is the first thing to measure
rather than the first thing to claim.

**Not for everything.** Throwaway scripts, spikes, notebooks, code with a known deletion date
— use none of this. A method that claims to apply everywhere is selling something.

**Not a way to avoid learning.** Its central mechanism is a question you cannot bluff.

---

*yaait is discussion-centric. If you and the machine are not arguing, one of you is not
working.*
