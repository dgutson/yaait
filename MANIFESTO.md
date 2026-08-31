# The yaait Manifesto

*Yet Another AI Thing.*

## The claim

An unattended LLM is a technical-debt reactor. The argument for that is in
[COMPARISON.md](COMPARISON.md); this document is about what to do instead.

**Generating code is no longer the bottleneck. Understanding what you just accepted is.**

You are not constructing software any more. You are maintaining it, from the first commit.
Construction is the part that got cheap. What is left is the maintainer's job — reading code
you did not write in order to change it without breaking it — and the dominant cost of that
job has always been comprehension. That is not a new problem; the field has catalogued it for
decades. What is new is that it starts on day one, on code that is minutes old.

Accept without understanding and you add slop on top of slop. Nobody can say what a change to
that code will break, so it breaks in front of customers; nobody can restructure it safely, so
it resists every change after this one. That is the debt. And it compounds: each unread change
makes the surrounding code harder to read, so the next one is likelier to go unread too.
Nothing in current practice damps that reaction — borrowing accelerates while servicing
stops.

The bill arrives in this order:

- **The honeymoon.** The first weeks are faster, which is what installs the habit.
- **Deceleration.** Each change costs more than the last.
- **Defects at customers.** Whoever accepted the change could not know what it would break.
- **Estimates die.** First they double, then they stop meaning anything.
- **Bankruptcy.** Servicing costs more than the team can produce. Rewrite or abandon.

None of this is about code quality. For the business, what is at stake is the price of every
change you have not made yet and the defects that reach customers while you make them. For
you, it is whether you are the judgment the machine multiplies or the output it replaces.

## Why a human at all

Automated development loops are here to stay, and nothing here argues against them. The
question is whether such a loop can close on itself.

It cannot, because the objective is not in the codebase. What the customer needs, what
"correct" means for this business, which trade-off is acceptable this quarter — none of that
is recoverable from the code, so a loop reasoning only from the code can be entirely
consistent and entirely wrong. A generator checked by another generator inherits the
misunderstanding, because both are missing the same thing.

The human is not there to type; that race is over. They are there to hold the objective, and
to be the person who accepted the cost.

## Principles

1. **The reason is business, not craft.** Elegance is not a goal here. Debt matters because
   the system costs more to change every month and fails more often in front of the customer.
2. **Understanding is how the debt is prevented.** Code nobody understood cannot be changed
   safely, so every future change pays for the comprehension nobody did. Working software
   nobody can account for is not delivery, it is borrowing.
3. **What gets examined is the decision, not the person.** A machine that wrote the work is
   in no position to test whether you understood it. It is in every position to show you what
   it chose, say what that choice costs if it is wrong, and ask you to rule.
4. **A decision nobody checked is allowed. One nobody checked and nobody wrote down is not.**
5. **Ignorance is a state, not a verdict.** Not knowing is one conversation from knowing.
   Pretending is not.
6. **The machine arms you as well as challenges you.** A challenge you cannot answer is not a
   review.
7. **The machine argues back only when it can name the failure mode, who it hurts and what it
   costs.**
8. **A decision that exists only in the conversation has not happened.** Including what
   you decided not to do.
9. **The document never outranks the world.** Nor does the code, silently.
10. **Every abstraction names the second concrete thing that needs it, or the dated event
    that will produce one.** One variant and neither is a guess, not a design.
11. **Debt is allowed. Hidden debt is not, and smeared debt is not.** Contain it behind a
    boundary or it will never be repaid.
12. **The multiplier acts on judgment.** Applied to zero it returns zero.
13. **The machine does not replace the junior. It is how the junior becomes a senior.**
    Seniors are the only people who can judge whether the machine's output is any good.

## The accountability clause

The human whose name is on the commit must be able to defend it — to a colleague, to a
reviewer, to whoever is reading it at three in the morning during an incident.

Or the record must say nobody ever ruled on it.

That is a statement about the condition the human has to be in, not about a test a machine
administers. yaait's job is to put them in that condition: show every decision, say what it
costs if it is wrong, teach the concepts it rests on, and record who ruled on it. How the code
was generated changes nothing. It is the same accountability the author carries into peer
review — yaait does not replace that review, it makes the person arriving at it able to
answer.

Nothing else is accountability. Everything else is attribution.

## Where this does not apply

Throwaway scripts. Spikes. Notebooks. Code with a known deletion date. Anything you are
genuinely the last reader of.

A method that claims to apply everywhere is selling something.

Use it for code that will be maintained, extended, or blamed.

Paradigm is not one of the limits. Nothing here is specific to object-oriented code.

---

This document is the position. The method is in [METHODOLOGY.md](METHODOLOGY.md); the argument
and the evidence are in [COMPARISON.md](COMPARISON.md).

*yaait is discussion-centric. If you and the machine are not arguing, one of you is not
working.*
