# The independent check

> Read by `yaait:design` Step 7a, which spawns a subagent with this file as its brief.
> **This is a protocol, not a catalogue.** The catalogue is the architectural smell
> reference alongside this file, and its LLM-specific section in particular. Do not restate
> it here and do not invent categories beside it — a second catalogue drifts from the first,
> and then a rule changed in one silently disagrees with the other.

## Why a second reader

Step 6 has the author check its own design against the smell catalogue. That check is worth
running and it is not sufficient: the author knows why every element is there, so it grades
the intention rather than the artifact. A design that was over-structured for a bad reason
still reads as justified to the party that held the reason.

This is the argument `yaait:stest` makes for human observation, one level down — a generator
checked by the same generator inherits the misunderstanding.

The checker is a subagent, spawned **for independence, not for context economy**. Every other
subagent in this method exists to keep throwaway output out of the conversation; this one
exists because the author cannot be the auditor. If the conversation reaches it, the
mechanism is gone and the run is worse than useless: it is Step 6 again, at twice the cost,
wearing a second opinion's clothes.

## What the checker receives

- `.yaait/DESIGN.md` — the written file, not a description of it.
- `.yaait/SPEC.md` — for requirement IDs and their `stated` / `selected` / `inferred` /
  `assumed` tags. A spec at `Format: 1` has no `selected` tag, so in one of those every
  menu-authored requirement is filed under `stated`.
- `TECH_DEBT.md` at the project root, if it exists — a boxed shortcut has one implementation
  by construction and would otherwise be flagged on every run for as long as it exists.
- `DESIGN_GUIDELINE.md` at the project root, if it exists — a standing project decision is
  settled, and re-raising it every run is how a check gets ignored.
- This file, and the smell catalogue it points at.

**Nothing else.** No conversation, no summary of what the user asked for, no note about which
alternatives were rejected and why. Each of those carries the author's reasoning, which is
the thing under examination.

## The question

For every structural element in `DESIGN.md` — component, interface, layer, abstract type,
indirection, configuration point — ask one question:

**How many concrete variants exist today, and what names the second one?**

The answers and what they mean are the abstraction rule the design already ran at Step 4: two
or more variants is justified indirection; one variant plus a specific named dated event is
justified and the event is recorded; one variant and no event is false abstraction. A dated
intention to replace, recorded in `TECH_DEBT.md`, is a named event.

## What a finding must carry

Four fields. A finding missing any of them is not reported.

- **Element** — the name as it appears in `DESIGN.md`.
- **Variants today** — the count, and what they are.
- **Named event** — the dated event that would produce a second variant, or `none found`.
- **Requirement** — the ID from `SPEC.md` this element serves and its provenance tag, or
  `serves none`. An element serving only an `assumed` requirement is two inventions stacked,
  and that is worth saying explicitly. A `selected` requirement is a weaker version of the
  same thing: the user ratified it, but the sentence was the spec gate's, so structure built
  on one and on nothing else is worth naming too.

The fields are the mechanism. They make a finding answerable in one sentence — *"there are
two, here they are"* — instead of arguable indefinitely, and they make an unfounded objection
impossible to phrase.

## What is not a finding

- **Anything about code.** There is none yet. Function length, naming, error handling and
  duplication belong to the code review criteria, which run on a diff.
- **Anything `DESIGN_GUIDELINE.md` settles.** A standing project decision is not an open
  question. Say it was checked and settled; do not re-raise it.
- **Anything you cannot fill the four fields for.** If the objection does not survive being
  written down as counts and IDs, it was taste.
- **Naming, ordering, and file layout.** Not structure.
- **"This could be simpler."** Without a named element and a count, that sentence fits every
  design ever written and therefore distinguishes nothing.

## Clean is an expected outcome

A design whose every element traces to a requirement and has either a second variant or a
named event **is clean**, and reporting nothing is the correct result. Say so in one line and
stop.

A checker that always finds something is not a strict checker, it is a broken one: the user
learns to discount it, and then the one run that mattered is discounted too. That failure is
silent and permanent, and it costs more than the over-structure would have.

## Report

Rank by cost — an element other elements depend on outranks a leaf. Report at most five, and
say how many were considered:

```
Considered 14 elements. 2 findings.

1. EventSink (interface)
   Variants today: 1 — LoggingSink.
   Named event: none found.
   Requirement: R-07 [assumed].
   Why it costs: three components depend on it; every one of them is threaded through an
   indirection that resolves to a single implementation.

2. ...
```

Then close by naming what was **not** examined, as categories rather than instances — the
same rule every review in this method closes with. A checker that reports only what it
looked at implies it looked at everything.

## What the calling session does with this

**Show every finding verbatim.** Not a summary, not a count, not the ones that survived
review. The author does not get to filter its own audit; that is the arrangement this whole
step exists to break.

**Rebut, never suppress.** The calling session holds what the checker was denied — the
conversation, the rejected alternatives, the constraint the user stated out loud. So it can
answer a finding: *"the checker flags `EventSink` as single-implementation; `SPEC.md` R-07 is
tagged assumed, but the user named the second sink in conversation and it is not in the
spec."* Put the rebuttal next to the finding. Both are shown; the user decides.

**A rebuttal that lands is a spec defect, not a win.** In that example the design is fine and
`SPEC.md` is wrong — the second variant exists and the spec does not record it. Apply the
reconcile rule and fix the spec.

**Where the checker and the session disagree, run the loop.** That disagreement means the
artifact does not say what the conversation assumed it said, which is the most useful thing
this step produces and the reason it is not a lint pass.

**Record an overruled finding.** If the user hears a finding and keeps the element, write a
`DECISION` entry naming the element, the objection and the reason it was kept. A rejected
objection that leaves no trace is a decision that exists only in the conversation.
