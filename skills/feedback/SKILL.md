---
name: feedback
description: >
  Capture what went wrong in the gate that just ran — friction, contradictions,
  misunderstandings, questions that could not be answered, ground covered twice, and the
  moments the user was annoyed — into an append-only .yaait/FEEDBACK.md that a later session
  reads forensically. Asks the user first and records their words verbatim before offering any
  account of its own, because the gate that just ran is the party under audit and its own
  summary is the least trustworthy thing in the file. Captures; it does not diagnose. Use
  whenever the user runs /yaait:feedback, or says anything like "that was confusing", "I could
  not tell what you were asking", "that was frustrating", "let me give you feedback on that",
  "write down what went wrong there". Also offer it unprompted when a gate has just finished
  and something visibly went wrong in it — the user answered a question that was not asked, a
  question came back unanswered, the same ground was covered twice, or they said they could not
  follow what was being asked. Do not offer it routinely after every gate; a report nobody
  wanted is the ceremony this instrument exists to detect.
---

# yaait:feedback — capture the friction while it is still true

This is an instrument, not a gate. It builds nothing, decides nothing and defends nothing. Its
only job is to get an accurate record of what went wrong in the gate that just ran, into a
file, before anybody forgets — including you.

## Why this command exists

yaait is unmeasured, and the one thing that could measure it is the experience of using it.
That experience is almost entirely lost: it lives in a conversation that ends, and what
survives is the artifact, which is the part that went *right*. `JOURNAL.md` records decisions,
approvals and comprehension debt — all of it about the thing being built. Nothing records that
the user read a question three times and still could not tell whether they were being
challenged or asked to confirm.

**The failure this prevents is a methodology that improves only where it already works.** Every
gate produces evidence of its own defects and discards it, so the same friction recurs across
projects, and the only defects that ever get fixed are the ones an artifact happens to expose.

There is a specific reason this is a separate command rather than a step inside each gate. A
gate that asked for feedback on itself, at the end of itself, would get the answer people give
when they want to leave: *fine, thanks*. This command exists to be invoked when there is
something to say.

## The rules that make this file worth reading

This command deliberately does **not** carry yaait's shared rules block. No loop, no review
round, no challenge protocol. Four rules replace it, and they exist because the ordinary ones would
actively damage the record here.

**The user's account is not contestable.** Their experience of the gate is theirs, and by the
routing rule in `METHODOLOGY.md` §2 it is in the class where only they hold the answer: what
confused them, what annoyed them, what they could not tell. There is nothing to check it
against. Do not argue with it, do not qualify it, do not explain what you meant. If you think a
complaint rests on a misreading, that goes in your own section as a disagreement — never as an
edit to theirs.

**Ask before you write, and write their words before you write yours.** You go second, always.
The gate that just ran is the party under audit; its framing is exactly what would contaminate
the report, and the anchoring is not hypothetical — a user shown the gate's analysis first will
answer inside it. `METHODOLOGY.md` §13 is the same principle applied to design review.

**Record events, never verdicts.** "The review step fired and settled a disagreement in one
turn" is an event and belongs in the file. "The measure-don't-argue rule works well" is a
verdict on the method, delivered by the party that just executed it, and it is worth nothing.
In particular:
**do not write a section about what went well unless the user says what went well.** A
self-authored list of the method's strengths is the least trustworthy content this file can
carry, and its presence is what makes a reader discount the rest.

**Capture, do not diagnose.** You are not fixing anything here, and you are not ranking
findings by importance. Resist it: the diagnosis needs a reader who was not in the
conversation, and it happens later, in a fresh session, against this file plus the transcript.
Root-causing your own friction now costs the later reader the raw material and gives them your
conclusions instead.

## Where it goes

`.yaait/FEEDBACK.md`, in the user's project, beside the other yaait artifacts. **Append-only**,
like `JOURNAL.md` — one entry per invocation, newest last, under a `## YYYY-MM-DD — <gate>`
heading. Never edit or delete a previous entry. If a later run contradicts an earlier one, that
is a finding: append it and say so.

If the file does not exist, create it with the header shown in Step 5. If it does, append.

## Step 0 — Establish which gate you are reporting on

Name it in one line and let the user correct you: **which gate just ran**, and whether it
finished, was abandoned part-way, or is still open.

Do not ask them to classify it — you know. Get the abandoned case right, though, because it is
the one the record cannot otherwise see: a gate stopped half-way leaves a partial artifact and
reads afterwards as having run. If that is what happened, say which step it stopped at.

If more than one gate has run since the last entry, write one entry per gate rather than
merging them. Friction attributed to the wrong gate is worse than friction attributed to none.

## Step 1 — Ask the user, and go first with nothing

Open with a single short question — what went wrong in that gate — and then offer the prompts
below as a menu they can pick from.

**Say plainly that the list is not exhaustive and that the most useful answer is usually one
that is not on it.** These prompts are options you composed, so the caution in `spec` Step 2
applies to this menu too: a user who believes the list is complete will pick the nearest fit
instead of telling you the real thing.

Offer these, and let them answer the ones that happened:

- **Where did you have to read something twice** to work out what was being asked?
- **Where did you answer, and then find you had answered a different question** than the one
  asked?
- **Where were you asked for something you had no way of knowing** — a forecast, a quantity, an
  analysis?
- **Where did the same ground get covered twice**, or a decision get re-litigated after it was
  settled?
- **Where did you give a shorter answer than you had**, because a full one felt like too much
  work?
- **Where did you feel you were being asked to justify yourself** rather than to decide
  something?
- **What did you want to say and not say?**
- **Where were you annoyed, and at what** — the gate, the method, or the problem itself?

The last two carry the most and get volunteered the least, so ask them explicitly rather than
hoping they arrive.

That final distinction is the one worth insisting on. Annoyance at **the method** is a yaait
defect and the whole reason this file exists. Annoyance at **the problem** is what building
something difficult feels like, and recording it as a methodology defect would send later
readers chasing a fix for the wrong thing. Ask which it was; do not decide it for them.

**Never ask whether the gate was good, useful, or helpful.** Those questions measure
politeness. Every prompt above asks about an event instead, which is the same reason a review
stop asks the user to rule on something rather than to rate themselves — `METHODOLOGY.md` §3.

If they decline a prompt, or answer none of them, that is recorded as declined. It is not left
blank: a blank looks identical to never having asked.

## Step 2 — Record it verbatim

Quote them. Do not paraphrase, do not tidy the grammar, do not translate an idiom into the
phrase you think they meant.

This matters more than it sounds. The exact wording of a complaint is the evidence — "I don't
have an adivination ball" locates a defect that "the user found the falsification question
difficult" does not, because the second one has already smuggled in a theory of what went
wrong. A paraphrase is an analysis, and analysis is Step 4's job and a later session's job.

**Blunt, terse or angry wording stays as written.** `METHODOLOGY.md` §2 already says the user
is not obliged to be polite; softening it here would delete the signal that a moment was worse
than the others.

## Step 3 — Add what only you can know

The user could not see any of this, and a later reader cannot reconstruct it. Keep it to what
actually happened:

- **Steps run, skipped, or abandoned part-way**, and where you stopped.
- **Rules you could not follow** — an instruction the harness forbade, two rules that could not
  both be satisfied, a step that assumed a tool you did not have. Say which rule and what you
  did instead.
- **Where you guessed rather than asked**, and why you judged the gap cheap.
- **Where you invented something** — a tag, a field, a section, a heading — that the artifact's
  format did not define.
- **Where you lost track**: a question you re-asked, a constraint you had been told and then
  contradicted, something you wrote and immediately rewrote.
- **Effort that produced nothing**: rounds of questions that changed no requirement, an
  artifact written more than once, a measurement nobody used.

Label this section as yours. It is written by the party under audit and a reader needs to weigh
it accordingly.

## Step 4 — Name the disagreements, and leave them open

Where your account and the user's do not match, say so in one line each, and **stop there.**

Do not resolve them. A disagreement between the two accounts of the same event is the most
valuable thing in this file — it is usually where the defect is, because it means the gate and
the user experienced different conversations. Resolving it now, in favour of whoever is
writing, destroys exactly that.

## Step 5 — Write FEEDBACK.md

Append the entry. Create the file with this header if it is not there:

```markdown
# FEEDBACK — friction log

> Append-only. What went wrong while using yaait on this project, gate by gate, for later
> forensic analysis. The user's account is recorded verbatim and is not contestable; the
> gate's own account is written by the party under audit and labelled as such. This file
> captures; it does not diagnose.

Format: 1
```

Then one entry per gate:

```markdown
## YYYY-MM-DD — <gate>

**Ran:** completed | abandoned at Step N | still open.
**Produced:** the artifacts written or changed.

### What the user said

- <verbatim quote> — <which prompt it answered, or "unprompted">
- **Declined:** <the prompts they passed over, as categories>

### What the gate did that the user could not see

- <event>

### Where the two accounts disagree

- <the user's version> / <the gate's version> — unresolved.

### Not captured

- <what this entry does not cover>
```

## Step 6 — Close

Say the file was written, and say what is **not** in it — one line, categories rather than an
enumeration: prompts the user declined, parts of the gate nobody looked at, friction you
suspect happened and cannot evidence. Without that line the entry reads as a complete account
of the gate, and it is a sample.

Then stop. Do not propose fixes, do not open a ROADMAP item, do not start improving anything.
The point of this file is that somebody reads it later, cold, with the transcript beside it.
Acting on it now is the same error as a design being audited by its author.

## What this command is for, and when it should stop existing

This exists to serve the first real dogfood of yaait, where the method is being exercised
deliberately in order to find its defects. It is honest about being provisional: the six gates
are the method, and this is instrumentation strapped to the outside of it.

It should be retired, or folded into something else, when either becomes true: the friction it
captures has stopped changing between projects, so the file is recording the same three things
forever; or the defects it finds start arriving faster than they can be fixed, at which point
the bottleneck is elsewhere and a growing log of unactioned friction is just a second backlog.
Say so if either looks like it is happening — that observation belongs in a `FEEDBACK.md` entry
like any other.
