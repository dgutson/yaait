# The yaait Manifesto

**Yet Another AI Thing.** Yes — another one. Here is the claim that is not in the others:

> **Generating code is no longer the bottleneck. Understanding what you just accepted is.**

Code accepted without being understood is the fastest debt generator ever built, and it
compounds. Every change nobody read makes the surrounding code harder to read, so the next
change is likelier to go unread too. That is a feedback loop, not a backlog.

The counts are in. Across 623 million commits: duplication **+81%**, error-masking **+47%**,
refactoring **−70%**. Borrowing accelerated an order of magnitude while servicing collapsed
by seventy percent — the industry now duplicates more code than it refactors *inside the same
commit*. The trade press calls the output slop. The accounting term is unpayable debt.

## What the bill looks like

Nobody experiences this as "technical debt." They experience it in this order:

- **Deceleration.** Each change takes longer than the last. The debt is not in a corner you
  can route around — you carry the bag of rocks on every change you make.
- **Defects reaching customers.** The same problem, landing outside the building: whoever
  accepted the change could not know what it would break, so they did not know they had.
- **Estimates stop meaning anything.** First they double. Then nobody can say when anything
  will be done — the point management notices, usually as "the team got worse."
- **Technical bankruptcy.** Servicing costs more than the team can produce. Nothing is left
  but rewrite or abandon, and a rewrite of code nobody understood is a guess.

This is not a complaint about code quality. It is a line item in what the company earns and
spends. Elegance is not a goal here. The goal is that **the tenth change costs roughly what
the first one did.**

## Why now

Every methodology is arithmetic. Waterfall answered a world where design was cheap and rework
was ruinous: buy design up front, commit to it. Agile answered the inversion — rework cheap,
design speculative: stop buying design, let structure emerge. Neither was ideology.

Both denominators have now collapsed. Design is cheap. Code is cheap. Rework is cheap.
**Only understanding is still expensive**, and it is the one input that cannot be generated.

What broke is a sentence nobody wrote down: **writing code used to be how you came to
understand it.** Authorship implied comprehension by construction — you could not type a line
without having thought it. Emergent design, "the code is the documentation" and collective
ownership by osmosis all leaned on that, and none of them said so. The link is severed; those
practices still run, still pass their ceremonies, and no longer do the thing they were for.

## The mechanism

If the cause is code accepted without comprehension, the only thing that stops it is a gate
that fails when comprehension is absent.

Not a gate on the artifact. The artifact looks fine — that is the entire problem. Wrong work
used to *look* wrong: incomplete, uncompiled, visibly a draft. Wrong work now arrives
finished, formatted, commented, and tested against its own misunderstanding.

So the gate is on the person: a question about this code that you can only answer if you
understand it. That is why yaait is six gates and not a linter.

## Values

We value the things on the right. We refuse to let them stand in for the things on the left.

- **Defensible artifacts** over *delivered* artifacts
- **Demonstrated understanding** over *claimed* familiarity
- **Recorded disagreement** over *smooth* agreement
- **Cheap gates** over *committed* plans
- **Named assumptions** over *plausible* completeness

## Principles

**1. Nothing ships that nobody understands.** Working software is the *evidence*, not the
deliverable. Software that works for reasons nobody can state was not delivered — it was
borrowed.

**2. Undefended is allowed. Undefended and unrecorded is not.** Ship what you do not
understand when the deadline is real — in writing, naming exactly what is undefended.

**3. Ignorance is a state, not a verdict.** So the machine must arm you, not only challenge
you. A challenge you cannot answer is not a review; it is an oracle.

**4. The machine argues back only when it can name the failure mode, who it hurts and what it
costs.** Otherwise it agrees in one sentence. Contrarianism on command is sycophancy with the
sign flipped.

**5. Nothing is decided in a conversation.** What was decided, rejected, approved without
being understood, and *not done* goes on disk, or it did not happen.

**6. Simplicity is a declared number, not an aspiration.** Every abstraction past it is
justified by a second concrete thing that needs it — or by a dated debt it contains, and
nothing else.

**7. The multiplier acts on judgment.** Applied to zero it returns zero, at volume. An
organization that stops making seniors is eating its seed corn.

## The accountability clause

The human whose name is on the commit must be able to defend it under questioning.

Or the record must say they could not.

Nothing else is accountability. Everything else is attribution.

## What yaait is not

**Not free.** It costs this week and pays back by the tenth change. No tenth change, no
reason to pay.

**Not for everything.** Throwaway scripts, spikes, notebooks, code with a deletion date — use
none of it. A method that claims to apply everywhere is selling something.

**Not a way to avoid learning.** Its central mechanism is a question you cannot bluff.

---

*yaait is discussion-centric. If you and the machine are not arguing, one of you is not
working.*
