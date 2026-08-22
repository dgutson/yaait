# The yaait Manifesto

*Yet Another AI Thing.*

## The claim

**Generating code is no longer the bottleneck. Understanding what you just accepted is.**

Accept without understanding and you add slop on top of slop. It compounds: every change
nobody read makes the surrounding code harder to read, so the next change is likelier to go
unread too. Borrowing accelerates while servicing stops.

Nobody experiences that as technical debt. They experience it in this order:

- **The honeymoon.** The first weeks are faster, which is what installs the habit.
- **Deceleration.** Each change costs more than the last.
- **Defects at customers.** Whoever accepted the change could not know what it would break.
- **Estimates die.** First they double, then they stop meaning anything.
- **Bankruptcy.** Servicing costs more than the team can produce. Rewrite or abandon.

None of this is about code quality. What is at stake is the ability to keep changing the
product at a predictable cost.

## What we value

We value the things on the left. We refuse to let the things on the right stand in for them.

- **Defensible artifacts** over *delivered* artifacts
- **Demonstrated understanding** over *claimed* familiarity
- **Recorded disagreement** over *smooth* agreement
- **Cheap gates** over *committed* plans
- **Named assumptions** over *plausible* completeness

## What we hold

1. **Understanding is the deliverable.** Working software is the evidence.
2. **Defending is not reciting.** It is answering a question you were not prepared for.
3. **Undefended is allowed. Undefended and unrecorded is not.**
4. **Ignorance is a state, not a verdict.** Not knowing is one conversation from knowing.
   Pretending is not.
5. **The machine arms you as well as challenges you.** A challenge you cannot answer is not a
   review.
6. **The machine argues back only when it can name the failure mode, who it hurts and what it
   costs.**
7. **Nothing is decided in a conversation.** Including what you decided not to do.
8. **The document never outranks the world.** Nor does the code, silently.
9. **Simplicity is a declared number.** Every abstraction past it names the second concrete
   thing that needs it.
10. **Debt is allowed. Hidden debt is not, and smeared debt is not.** Contain it behind a
    boundary or it will never be repaid.
11. **The multiplier acts on judgment.** Applied to zero it returns zero.
12. **The machine does not replace the junior. It is how the junior becomes a senior.**
    Seniors are the only people who can judge whether the machine's output is any good.

## The accountability clause

The human whose name is on the commit must be able to defend it under questioning.

Or the record must say they could not.

Nothing else is accountability. Everything else is attribution.

## Where this does not apply

Throwaway scripts. Spikes. Notebooks. Code with a known deletion date. Anything you are
genuinely the last reader of.

A method that claims to apply everywhere is selling something.

Use it for code that will be maintained, extended, or blamed.

---

This document is the position. The method is in [METHODOLOGY.md](METHODOLOGY.md); the argument
and the evidence are in [COMPARISON.md](COMPARISON.md).

*yaait is discussion-centric. If you and the machine are not arguing, one of you is not
working.*
