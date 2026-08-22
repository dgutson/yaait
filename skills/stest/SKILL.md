---
name: stest
description: >
  Run a system or integration test of the whole thing to build, traced clause by clause
  against SPEC.md's acceptance criteria, and produce a verdict that says explicitly what was
  NOT tested. The user observes the critical path themselves rather than being told it
  passed, because a final gate where the LLM grades its own homework leaves the human
  accountable for something they never witnessed. Any acceptance criterion that turns out to
  be untestable is treated as a spec defect and sent back to /yaait:spec. Use whenever the
  user runs /yaait:stest, or says things like "does the whole thing work", "let's test it end
  to end", "system test", "integration test", "are we done", "did we build what we said".
  Also suggest it once the last increment from DESIGN.md is complete — that is the moment the
  question "does this actually satisfy the spec" becomes answerable and nobody thinks to ask
  it.
---

# yaait:stest — does it do what we said it would

## Why this command exists, and why it works differently

Unit tests answer "does this component behave as I intended". They cannot answer "did we
build the thing we specified", because they were written by the same reasoning that wrote the
code, from the same understanding, including the same misunderstanding. A misread requirement
produces a matching implementation and a matching test, all three agreeing, all three wrong.

So this gate traces against `SPEC.md` rather than against the code, and it has one rule that
none of the other commands have:

> **The user observes the critical path themselves.**

Not because automation is untrustworthy, but because of what accountability means. If the
final gate is a test suite you ran and a summary you wrote, then the user is accountable for
a result they never witnessed — and the whole methodology collapses at its last step into
exactly the arrangement it was built to prevent. Someone has to *see the thing work*.

For everything else — the long tail, the edge cases, the regression surface — automate
freely. It is the critical path specifically that a human has to lay eyes on.

## The rules that are the method

These hold for the whole of this command. The long form, with reasoning, is in
`METHODOLOGY.md` at the plugin root — read it if a rule seems wrong or a situation is not
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
## Step 0 — Read the spec, not the code

Read `.yaait/SPEC.md`, and pull out every acceptance criterion with its requirement ID.
Read `JOURNAL.md` for `DEBT` entries — undefended code is where a defect is most likely to be
hiding, so it deserves extra attention here.

Read `DESIGN.md` for the invariants. An invariant that holds in unit tests and breaks under a
real end-to-end run is the classic integration defect and the thing this command is best
placed to find.

Deliberately read the spec **before** the implementation, and build the test list from it. If
you read the code first, you will test what it does. The point of this gate is to test what
it was supposed to do.

## Step 1 — Build the trace table

One row per acceptance criterion. Every criterion from `SPEC.md` appears — including the ones
you expect to fail, and the ones nobody implemented.

| Req | Criterion | How it is tested | Who observes | Result |
|---|---|---|---|---|
| S-001 | A full game can be played to win, loss and draw | manual, scripted below | user | |
| S-003 | A move to an occupied square is rejected, board unchanged | automated | automated | |
| S-004 | Killing the process mid-game resumes at the same position | manual | user | |
| S-006 | "It should feel responsive" | `[untestable]` | — | — |

Mark each criterion as **user-observed** or **automated**:

- **User-observed** — the primary flows, anything the user experiences directly, anything
  where "it worked" is a judgment rather than an assertion. Keep this list short enough that
  the user will actually do it: five to ten steps, not fifty.
- **Automated** — edge cases, error paths, the regression surface, anything tedious or
  repetitive.

If a criterion has **no test possible**, do not quietly drop it. See Step 4.

## Step 2 — Run the automated part, and report the actual output

Run it. Then report what happened, not what was supposed to happen.

If something fails: **say so plainly, with the output.** Do not describe the intent of the
failing test, do not summarize the failure as "a minor issue", and do not fix it silently and
report a pass. A failing system test is this command working correctly — it is the single most
valuable output it can produce, and burying it is the one thing that would make the whole
gate worthless.

If a test errors rather than fails, say which, because they mean different things: a failure
is information about the code, an error is often information about the test.

## Step 3 — Hand the critical path to the user

Write a script the user can follow without you. It must be concrete enough to execute and
specific enough that they know what "wrong" looks like:

```markdown
## Please run this yourself

1. Start it: `python -m game`
2. You should see: an empty 3×3 board, "X to move".
3. Click the centre square. → An X appears there, prompt changes to "O to move".
4. Click the same square again. → **Nothing happens.** The board does not change and no
   error appears. (This is S-003.)
5. Play on until X wins. → The banner reads "X wins" and further clicks do nothing.
6. Start a new game, play two moves, then kill the process (Ctrl-C).
7. Restart it. → The board shows your two moves and it is O's turn. (This is S-004.)

Tell me what you actually saw at each step, especially anywhere it differed.
```

Each step states **the expected observation**, not just the action. "Click the square" is not
a test; "click the square, an X appears there and the prompt changes" is.

Then **wait for what they report, and record that** — not your expectation of it. If they
skip steps, say which rows of the trace table are therefore unverified rather than marking
them passed. An unobserved row is unverified, and writing anything else in that cell is the
one falsification this command must not commit.

## Step 4 — Untestable criteria are spec defects

If an acceptance criterion cannot be tested, that is a **defect in the spec**, not a gap in
this command. It means `yaait:spec` accepted something unfalsifiable and nobody noticed until
now.

Say so, and offer to go back to `yaait:spec` to rewrite the criterion into something
observable. Journal it as a `DECISION`.

The exception is a criterion already marked `[untestable]` in the spec — aesthetics, feel,
"it should be fun". Those were flagged deliberately. Report them as untested rather than
passed, every time. A subjective criterion silently counted as satisfied is how a system test
comes to certify something nobody checked.

## Step 5 — Say what was not tested

**Mandatory section. It is the honest part of the report and the reason anyone should trust
the rest of it.**

Cover at least:

- Acceptance criteria with no test, and why.
- Code paths never exercised — error handling, timeouts, retries, resource exhaustion, the
  second and third branches of a condition.
- Everything only tested on one input, one platform, one screen size, one locale, one clock.
- Concurrency, ordering and timing, unless it was tested deliberately. It almost never is.
- Anything carrying a `DEBT` entry, since neither of you can currently reason about whether
  it is right.
- Scale. If it was tested with three records, say three records.

Write it as facts, not as apology. "Only tested on Linux with Python 3.12; never run with
more than one concurrent client; the save-corruption path is unexercised" is a useful
sentence. "Testing was not exhaustive" is not.

## Step 6 — Run the defense

3–5 elements, and the productive targets here are different from the other commands, because
what is being defended is the *verdict* rather than the artifact:

- **A criterion the user marked as passing.** "You saw the board resume after the restart —
  what would you have seen if only the move log had been saved and not the turn?"
- **An untested path that matters.** "Nothing here exercised a corrupt save file. What do you
  think happens, and are you content to ship not knowing?"
- **A `DEBT` entry that survived into the shipped system.** Name it, say what it means now
  that the thing is running.
- **The gap between what the tests prove and what the spec claims.** This is the most useful
  question in the command: *"the suite passes. Which requirement do you think is least
  actually guaranteed by it?"*

Journal `APPROVAL`, `DEBT` and `CHALLENGE` as usual.

## Step 7 — The verdict

State one of three things, plainly:

- **Satisfies the spec** — every criterion traced, tested and observed. Say what is untested
  anyway.
- **Satisfies the spec with known gaps** — the usual honest outcome. List the gaps.
- **Does not satisfy the spec** — name which criteria failed and what it would take.

Do not average these into "mostly working". A verdict that cannot fail is worth as much as a
test that cannot fail.

Append the verdict to `JOURNAL.md`, including **who observed what** — that record is the
whole point:

```markdown
### STEST — <TTB name>, <date>
- **Verdict:** satisfies the spec with known gaps.
- **Automated:** 34 tests, 34 passed. Covers S-002, S-003, S-005, S-007.
- **User-observed:** Daniel ran the 7-step critical path; S-001 and S-004 confirmed by him.
- **Not tested:** S-006 (marked untestable in spec); corrupt-save path; anything concurrent;
  only Linux / Python 3.12; largest run was 3 saved games.
- **Outstanding debt:** the retry backoff in net/client.py remains undefended.
```

Then suggest `/yaait:debt` if any of these hold, since end of cycle is the natural moment for
it and nobody thinks to ask:

- any `TECH_DEBT.md` item gained a receipt during this cycle;
- an item has accumulated several receipts, which usually means it has stopped being a
  code-quality issue;
- a failure in this run traced to a known debt item;
- `TECH_DEBT.md` has items nobody has looked at in a long time, which are candidates for
  `won't fix` rather than perpetual guilt.

Then stop. If the verdict is anything other than clean, say which command comes next —
`yaait:code` for a fix, `yaait:spec` for a bad criterion, `yaait:design` if the failure is
structural rather than local.
