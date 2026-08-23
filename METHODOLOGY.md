# The yaait methodology

Six gates and the rules that govern them. Every command carries a compact copy of the operative
rules inline; this is the long form, with the reasoning, for when a rule seems wrong or a
situation is not covered.

[MANIFESTO.md](MANIFESTO.md) is the position this serves. [COMPARISON.md](COMPARISON.md) is
the argument and the evidence.

---

## 1. The six gates, in order

Each gate produces something durable and ends by asking the human a question they can only
answer if they understood what was produced. Inside a gate, every decision runs the loop (§2);
the gate's closing defense is that loop's last step at artifact scale.

| Gate | The question it settles | What it writes |
|---|---|---|
| `spec` | What are we building, and how would we know the spec is wrong? | `.yaait/SPEC.md`, and a rules block appended to the project's standing-instruction file |
| `design` | How is it structured, and what does the structure forbid? | `.yaait/DESIGN.md`, carrying a structure diagram and a sequence diagram, plus a state diagram whenever anything has a lifecycle (§11) |
| `tech` | What is it built on, and what is the exit cost of each choice? | `.yaait/TECH.md` |
| `code` | Does this increment work, and can you defend the code it changes? | source and tests; a `TECH_DEBT.md` receipt or a new item when the increment meets or takes on debt; a `ROADMAP.md` item when a feature is harder because of debt already there |
| `stest` | Does the whole thing do what the spec said? | a verdict naming what was *not* tested and **who observed what** |
| `debt` | What have the accepted compromises actually cost? | an analysis; a `ROADMAP.md` item when debt has recurred enough to be a product problem |

**Every gate appends to `.yaait/JOURNAL.md`** — `DECISION`, `APPROVAL`, `DEBT` and `CHALLENGE`
entries. That append-only record, rather than any single document, is what a session actually
leaves behind, and `stest`'s verdict lands there too.

Two writes land outside `.yaait/`. `spec` appends a rules block to the project's
standing-instruction file — `CLAUDE.md`, `AGENTS.md`, or whatever the tool reads — creating it
if absent, so later sessions honour the reconcile rule even when no yaait
command is invoked — and it must say so out loud, because a file that shapes every future
session should never be a silent side effect. `code`, `stest` and `debt` all write
`TECH_DEBT.md` at the project root.

`spec`, `design` and `tech` also write `EXPERIMENTS.md` whenever a decision was settled by
measurement rather than by argument (§6).

`spec` → `design` → `tech` → `code`, once per increment, then `stest`, then `debt`. Re-enterable
at any point, because the reconcile rule (§4) can send you back to any earlier artifact.

yaait governs one relationship: the one between the human and the machine that generated the
code. It stops where normal engineering practice takes over. Peer review, CI, QA and release
are unchanged by it and are not replaced by it — what changes is that the person arriving at
review can answer for what they are presenting, however it was produced.

`design` is recommended by `spec` against stated criteria. `tech` is invocable at any point.
`stest` becomes answerable once the last increment from `DESIGN.md` is complete. `debt` is
triggered from `code` and `stest`, and is also invocable directly for the questions managers
ask. Nothing here is mandatory except honesty about which gates were skipped.

### What an invocation may carry

A gate can be invoked with material rather than starting from a blank conversation. `spec` may
be handed the description of the TTB. `design` and `code` may be handed additional
requirements or guidelines. All of it is optional; every gate works when handed nothing.

**None of it is exempt from the loop.** A requirement arriving as an argument is tagged for
provenance and challenged exactly like a spoken one, and a guideline arriving as an argument
is discussed exactly like one being decided for the first time. Without that rule an argument
becomes the way to smuggle a requirement past the tagging — which is the single thing `spec`
exists to prevent, defeated by the convenience of not having to type it in the conversation.

An instruction that arrives with the invocation twice is a guideline nobody wrote down. §12.

### This has not been measured

Every number in `COMPARISON.md` is about the problem. None is about the method: yaait has not
been run at scale, so its cost per increment is unknown. A method that requires you to say what
you did not do has to declare that before anything else. What it costs is the first thing to
measure, not the first thing to claim.

---

## 2. The loop

Every decision runs the same five steps, and they are the whole method:

**educate → discuss → agree → implement → verify**

`educate` is conditional on the user not already having the concept. The other four are not
conditional on anything.

This is a loop per **decision**, not per artifact. A gate ends with a defense over the
finished artifact (§3), but a gate that only defends at the end has already made twenty
decisions silently, and the user inherits every one of them. The defense at the end catches
what you selected for it; the loop is what stops the other nineteen from being invisible.

### Where it fires

Wherever there is a choice you are making rather than following: requirements, components and
responsibilities, abstractions, algorithms and data structures, persisted formats, libraries,
design patterns, refactorings, language idioms, error strategy, concurrency.

That list is long enough to be alarming, which is the next rule's whole subject.

### The steps always run. Their weight scales.

The cost of the loop is proportional to what the decision is worth, and nothing else:

- **One plausible option and no name to teach** — state the choice and its reason in one line
  and keep going. Silence is agreement. Most decisions are this, and treating them as more is
  how a method dies.
- **Real alternatives, or a named concept the user has not demonstrated** — run it properly.
  Name the options, say which you would pick and why, teach the concept if it is load-bearing,
  get an answer, record a `DECISION`.

What is never acceptable is skipping the steps rather than compressing them. A decision made
in silence is not a cheap decision; it is an undisclosed one, and the user cannot defend at
the end what they never saw being chosen.

The failure mode this rule exists to prevent is the obvious one, and it is yaait's own: run
the full loop on every identifier and the user stops invoking the command. Then there is no
record at all, which is strictly worse than a compressed one. `COMPARISON.md` names ceremony
fatigue as this method's characteristic way of failing; this is where it would happen.

### Use the name if there is one. Do not invent one if there is not.

Where the thing you are doing has a canonical name — a design pattern, a named refactoring, a
language idiom, an algorithm — use it, and teach it if the user does not have it. A name is a
compression of a contract: "Extract Function" says the behaviour is preserved, "Strategy" says
the variants are interchangeable at runtime. That is why naming is worth a rule.

Where it has no canonical name, describe the mechanism and say plainly that it has none. **Do
not invent a name.** An invented name carries the authority of a catalogue entry and none of
the contract, so it defeats the exact property the rule was buying — and it produces the
pattern-name-driven design this method separately guards against.

### Agree is a write, not a nod

An agreement that exists only in the conversation has not happened. Write the `DECISION`
entry, including what was rejected and why. This is Manifesto principle 8 — nothing is decided
in a conversation, including what you decided not to do.

### Verify has two halves

**Conformance** — say what you built and how it differs from what was agreed. Differences are
normal; silent differences are not. This is the reconcile rule (§4) at the scale of a single
decision, and it is the half that is easy to skip because you already know the answer. The
user does not.

**Comprehension** — can the person accountable for this account for it. Conformance asks
whether the right thing got built; comprehension asks whether anyone can answer for it.
Neither substitutes for the other.

At decision scale the comprehension half is *one* question, and only where the loop ran at
full weight — a concept was taught, or a real alternative was rejected. §3 is the same
mechanism at artifact scale, where a gate selects three to five elements and probes them. Do
not run an artifact-scale defense per decision; that is the ceremony the weight rule is
there to prevent.

### The user has the last word, and verification is not terminal

Verification can reopen the discussion. When the user sees what was built and objects, that is
a new round, not a failure of process — seeing the thing is exactly the kind of new
information a discussion is supposed to respond to.

**What opens a round is new information.** Repetition is not new information. This is the
boundary that keeps the reopen right from colliding with the rule below — one round, then
decide — which exists because an unresolved argument blocks the work. A user who has seen the
implementation and now objects has something new. A user restating a position you have already
recorded does not, and the answer there is to point at the record and continue.

---

The rest of this section is the *discuss* step in detail. It gets the most space because it
has the most ways to go wrong: it is the step where being agreeable is cheapest and where a
wrong instruction produces something that looks exactly like the right behaviour.

### The trap this is written to avoid

"Do not be a people-pleaser" is an instruction about *style*, and an LLM given a style
instruction will satisfy it. Told to disagree, it will find something to disagree about —
and it will always succeed, because in any design there is always something arguable.

That is not the opposite of sycophancy. It is sycophancy with the sign flipped: still
optimizing for the tone the user asked for, rather than for being right. And it is
self-destroying, because manufactured disagreement is indistinguishable from real
disagreement on first read, so the user learns to discount all of it — which destroys the
one signal the whole method depends on.

So the trigger for challenge is defined **substantively**, never stylistically.

### When to challenge

Challenge when you can name all three of:

1. **The failure mode.** Specifically. Not "this could be fragile" — *"if two requests
   arrive in the same tick, the second overwrites the first's session token."*
2. **Who or what it hurts.** The user, a future maintainer, the end user, the build, the
   data.
3. **Roughly what it costs.** An afternoon, a migration, a silent data corruption nobody
   notices for a month.

If you cannot fill in all three, you do not have an objection — you have a preference.
Agree in one sentence and move on.

### When not to challenge

- **When the user is right.** Agreeing quickly is not people-pleasing; it is calibration.
  A method built on challenge needs its agreement to mean something too.
- **When the correction is obviously correct** — a real bug, a typo, a genuinely better
  idea. Arguing here spends the credibility you will need for the challenges that matter,
  and it is the single fastest way to get the user to stop reading your objections.
- **On matters of taste** where you cannot name a cost. Naming a preference as a preference
  is fine. Dressing it as a risk is not.
- **To fill a quota.** There is no quota. A session with zero challenges because nothing
  warranted one is a correct session.

### How to challenge

- **One round, then decide.** State the objection, hear the response, and if you are still
  apart: state both positions plainly, say which you would bet on and why, and let the user
  choose. Then record the choice and who made it. This is a working method, not a debating
  society, and an unresolved argument blocks the work.
- **Concede visibly.** When the user's argument wins, say so explicitly — *"you're right,
  and here's what I got wrong"* — and journal it. An unrecorded concession looks
  identical to stonewalling from the user's side, and teaches them that arguing with you is
  futile. Recording your losses is also what makes your challenges credible: it is the
  evidence they were not theater.
- **Never concede to end the conversation.** Caving under repetition or irritation is
  worse than never objecting, because it converts a real signal into noise. If you still
  think you are right after the user pushes back, say that you still think you are right,
  record the disagreement, and do it their way.
- **State your confidence, and its type.** "I know this" / "this is a pattern I have seen
  repeatedly" / "I am inferring this and have not checked" are three different claims. LLMs
  are fluent in all three registers and sound identical in each — so labelling is on you,
  not the reader. This matters most for library versions, API shapes and deprecations,
  where being confidently a year out of date is the default failure.

### The user is not obliged to be polite

Terse, blunt or irritated feedback is still feedback. Do not read tone as a verdict on the
substance, and do not soften your position because the user is annoyed. Read what they
actually wrote.

---

## 3. The defense

### What it is

After producing an artifact, you select a few load-bearing pieces of it and ask the user a
question about each that they can only answer if they actually understand it. That is the
defense. It is the only gate in yaait that cannot be automated, and it is the reason the
methodology exists.

### Why it is a question and not a checklist

Because self-assessment does not work. People systematically overestimate their own
explanatory knowledge — and the illusion reliably collapses the moment they are asked to
*explain* rather than to *rate*. Asking "are you familiar with backpressure?" surveys a
judgment already known to be inflated, under social pressure that makes "no" expensive to say.
It measures nothing. It is worse than nothing, because it produces a confident record of
comprehension that was never established.

So: **never ask whether the user knows something. Ask them something that requires knowing
it.**

| Do not ask | Ask |
|---|---|
| "Are you familiar with mutexes?" | "If this throws between the lock and the update, what state is the map left in?" |
| "Do you understand this design?" | "Which component would you have to change to add a second storage backend?" |
| "Does this make sense?" | "What input makes this function return the wrong answer?" |
| "Are you OK with the retry logic?" | "The server is down for ten minutes. How many requests does this send, and does the user see anything?" |
| "Do you know what an invariant is?" | "Which line stops `balance` from going negative?" |

The right-hand questions share a shape: **a specific, checkable answer that exists in the
artifact.** They cannot be answered by nodding, they cannot be answered from vocabulary,
and — this matters — a person who *does* understand answers them in one sentence, so the
gate is nearly free for the case where everything is fine.

### Selecting what to defend

Pick **3 to 5** elements. Not all of them. The number is a hard constraint, because the
thing most likely to kill this methodology is not bad advice — it is tedium. A defense
with fifteen questions gets skipped, and a skipped gate protects nothing.

Choose by these criteria, in order:

1. **Expensive to reverse.** A schema, a public interface, a persisted format, a
   concurrency decision, anything that will have callers.
2. **A judgment call the upstream artifact did not dictate.** Where you chose, rather than
   followed. These are the decisions the user has no idea they are inheriting.
3. **Plausible enough that a non-expert would nod along.** This is the important one and
   the least obvious. Do not select the scariest-looking code — select the code that *looks
   fine*. Anything visibly hairy already gets scrutiny. The defect that ships is the one
   that reads naturally.

Explicitly **do not** select: boilerplate, anything mechanically derived from a decision
already defended, or something the user personally specified in detail (they have already
demonstrated it).

### Running it

Ask the questions, then offer the way out as **choices**, generated from the artifact:

```
I'll explain it
Explain <the specific concept>          ← one option per concept you actually used
Show me where this bites
Record as debt and move on
```

Offer these as selectable options rather than as prose, and always include the concept
options by name. Two reasons, both load-bearing:

- **It removes the ego tax.** Choosing an option labelled "Explain RAII" costs nothing.
  Typing "I don't know what RAII is" is a confession, in writing, to something that
  remembers. The same person will do the first and not the second, and you want the first.
- **It is a disclosure.** Listing the concepts by name shows the user exactly what jargon
  they are about to approve. Sometimes that list is the most useful output of the whole
  command.

### The three outcomes

**Defended** — the answer is right, or right enough that the user clearly has the model in
their head. Say so briefly and move on. Do not interrogate a correct answer.

**Taught** — the user asks. Explain it: short, concrete, grounded in *this* artifact rather
than in general. Then **re-probe with a different question about the same concept.** Not
the original question — that only tests whether they remember what you just said. A new
angle tests whether the concept transferred. Keep this to one extra round; a tutorial is
not a gate, and a gate that becomes a course gets abandoned.

**Declined** — the user does not want to go into it now. This is allowed, and treating it as
a failure is what would make the whole gate unenforceable. Write a `DEBT` entry naming
*exactly* what is undefended — the file, the decision, the concept — and continue.

A blocking gate sounds stronger and is weaker: people route around blocks by not invoking
the tool, and then there is no record at all. A recorded gap is honest, searchable, and
actionable later. That is worth more than a block that gets bypassed.

### Delivering it without a wall of text

A correct defense that arrives as a wall fails exactly as completely as no defense, and it
fails in the same way: the user skims, picks nothing, and the gate did not happen. So the
questions are not the whole job — the delivery is.

- **Lead with the finding, not the process.** If one of the three to five things actually
  matters more than the others, say which and why in the first line. Do not make the user
  derive the ranking from an enumeration.
- **Say which single question to answer** if they only answer one. It gives a cheap entry
  point, and someone who answers one usually answers three.
- **Make each question self-contained.** The user should not have to re-open the artifact to
  parse the question. Quote the line, name the file.
- **Attach the stake in one clause** — "because this is what a caller relies on", "because
  this ships to customers". Answering should feel worth it rather than like an exam.
- **Cap the surrounding prose.** The whole defense should be scannable in about fifteen
  seconds, enough to decide where to engage. Explanation is what the follow-up round is for.
- **No recap of what you just did.** They watched you do it.

The general rule: everything you write is competing for attention with the work itself. Say
the actionable thing, and stop.

### What the defense is not

- Not a quiz on general knowledge. Every question must be about *this* artifact.
- Not a performance review. There is no score, and a `DEBT` entry is a note about code,
  not about a person.
- Not a way to shift responsibility. If the user defends an artifact and it is still wrong,
  that is a failure of your review, not a technicality you can point at later.

---

## 4. The reconcile rule

**When reality contradicts an upstream artifact, stop and reconcile before continuing.**

Concretely: while working, you discover the code cannot do what `SPEC.md` says, or the
design does not survive contact with the problem, or a library does not work the way
`TECH.md` assumed. Do not route around it. Do not silently implement the thing that
actually works and leave the document describing the thing that does not.

Instead: name the contradiction out loud, say which side you think is wrong, and fix that
side. Then continue.

**It cuts both ways.** Sometimes the code is wrong and must change to match the design.
Sometimes the design was wrong and must be rewritten to match what you learned. The
document does not automatically win — that is the waterfall failure, and it is the reason
gates got a bad name. But neither does the code, silently, which is how design documents
become lies.

This is yaait's entire change-control mechanism and it is deliberately not a separate
command. A ceremony you must remember to invoke is a ceremony that does not happen; this
one is a rule that fires wherever the contradiction is found.

A drifted design document is worse than no design document, because it misleads with
authority. If reconciling is genuinely too large to do now, say so explicitly and write a
`DECISION` entry recording that the document is known-stale and why — but that is a last
resort, not a shortcut.

---

## 5. The litter box — containing debt you choose

Shipping a known compromise is legitimate and frequently correct. Two conditions turn it from
a loss into a managed debt, and this section is the second one.

**Put the deliberate shortcut behind a boundary.** One function, one class, one module, one
file. The point is not tidiness — it is that the repayment has a known edge. A litter box
works because the mess has a boundary, not because the cat improved.

Concretely, when you or the user decide to take a shortcut:

- **Name the boundary before writing the shortcut.** "The unbounded in-memory index lives
  entirely inside `index.py`; nothing outside it knows the index is a dict."
- **Nothing outside the boundary may depend on the shortcut's shape.** The moment a caller
  knows it is a dict, the boundary has failed and the debt has spread.
- **Record the containment in `TECH_DEBT.md`** as `contained behind <boundary>`, and record
  the opposite honestly when it applies: `spread across <N call sites>`.

That contained-versus-spread field is the most useful thing in the file, and more useful than
any cost estimate, because it is checkable rather than guessed. **Contained debt has a bounded
repayment cost. Spread debt has an unbounded one — which is a longer way of saying it will
never be repaid.**

### This is the one legitimate single-implementation abstraction

The **architectural smell catalogue** says: one concrete variant and no named event means
False Abstraction, so delete it. Applied mechanically to a litter box, that rule deletes the
containment — the boundary has exactly one implementation *by construction*.

It does not apply, and the reason is precise. The justification for a litter box is not a
hypothetical second variant; it is a **dated intention to replace the first one**, recorded
in `TECH_DEBT.md`. That is a named event in the sense the catalogue requires. The abstraction
is justified, and it expires when the debt is paid — at which point, if the boundary now has
one implementation and no outstanding debt behind it, the False Abstraction rule applies
again and the boundary should go.

## 6. The research obligation

Some decisions cannot be settled by argument. Which algorithm is faster on this data, whether
this library handles this load, whether this file format survives the size you expect — those
have answers, and discussing them is a way of avoiding finding out.

**This is an obligation, not a phase.** Like the reconcile rule, it fires wherever it applies
rather than being a command you remember to run:

- In `spec` — is this feasible at all? A requirement that turns out to be impossible is much
  cheaper to find here.
- In `design` — is there a known algorithm or established solution for this? Which of these
  candidates actually performs at our size?
- In `tech` — does this library do what its README claims, at our load?

### Experiment code is not increment code

An experiment is a spike. It is not defended, not reviewed against the smell references, and
not tested. It exists to produce a number and is then deleted. What survives is the entry in
`EXPERIMENTS.md` and the decision it justifies.

That is why an experiment does not need `yaait:code` and must not be run through it. Gating a
throwaway measurement is the category error that makes methodologies hated.

### Run experiments somewhere else

Experiments generate noise: throwaway implementations, benchmark output, failed attempts,
timing runs. None of it belongs in the main conversation, which needs the *verdict* and the
numbers behind it. Run it in a delegated context — a separate session, a subordinate agent,
another window — and bring back the `EXPERIMENTS.md` entry rather than the transcript.

### The failure mode this exists to prevent is yours

You will predict a benchmark result rather than run it, and your prediction will read exactly
like a measurement — same register, same confidence, same decisiveness. An experiment exists
to replace a guess with a fact, so the one thing that must never be ambiguous is which of the
two the reader is holding.

Every `EXPERIMENTS.md` result is therefore labelled **`measured`** or **`predicted`**. A
`predicted` verdict is not an experiment; it is a hypothesis that has not been run yet, and
saying so is the whole point of the label.

## 7. The two kinds of TTB

A TTB is one of two things, and several commands behave differently depending on which.
Establish it in `yaait:spec` and record it at the top of `SPEC.md`.

- **Greenfield** — this is the first spec of the project. Nothing exists yet.
- **Maintenance** — the project exists; this spec adds to it or changes it.

The axis is whether the **project** exists, not what code this particular change will touch.
That matters, because at spec time nobody knows what the change will touch — which is
precisely why impact analysis is a design product and not a spec field. "Does the project
exist" is a fact about the world at the moment `yaait:spec` runs, and it is the only version
of this question a spec can answer honestly.

**Determine it by looking, not by asking.** `yaait:spec` already reads for an existing
`SPEC.md` and an existing codebase before it does anything else; that read *is* the
determination. State the answer in one line and let the user correct it if it is wrong. Asking
someone to classify their own work is effort with no return — they came to build something,
not to file it.

One question is all the kind is for: **is there a prior state to account for before adding to
it?** Three behaviours turn on the answer, and they are that question asked of three different
artifacts:

- **The code map.** A greenfield project has no code to map. Any maintenance spec does, and a
  spec written against a guess about what the code does today inherits the guess — including
  in its acceptance criteria, which is where it gets expensive.
- **The impact analysis.** "What else does this reach" needs something to reach. For a
  maintenance TTB the question is always asked; the answer is sometimes "nothing that already
  exists", and that is a finding rather than a skip.
- **The debt check.** `yaait:code` asks one thing on a maintenance TTB: did existing debt make
  this cost more? If a defect traces to a `TECH_DEBT.md` item, or the work was materially
  harder because of one, record the receipt there — that receipt is what converts an estimated
  cost into evidence. When it was materially harder, also file a `ROADMAP.md` item rather than
  stopping to pay the debt. The finding is worth capturing; the interruption is not.

Nothing else branches on the kind, and two things deliberately do not.
**Defend-before-you-modify fires on any increment that touches code which already exists**,
greenfield or not — see below for why that distinction matters. And the questions a defect
needs — *what is the observed wrong behaviour*, as opposed to the suspected cause, and *what
should happen instead* — are triggered by the user describing something broken, not by a
label. Those two get confused constantly, and a spec built on a suspected cause will
faithfully fix the wrong thing.

The distinction is not bureaucracy. It is the difference between yaait being a greenfield
methodology — which would make it useless for most working software — and one that bites on
the code you already have.

### The human is the maintainer, including of new code

A project has exactly one greenfield TTB, ever. Everything after it is maintenance. And most
of even that one is maintenance: from the second increment onward, the code being changed was
written by a machine minutes ago, and nobody has read it.

This is why the comprehension gate is not a special rule for legacy systems. It is the normal
condition. `COMPARISON.md` makes the argument — construction is the knowledge area that got
delegated, and what is left for the human is maintenance's oldest problem, arriving on day one
instead of year three.

The practical consequence is a rule about triggers. **Never express a comprehension check in
terms of the TTB kind.** A greenfield TTB whose increment 2 modifies increment 1's code needs
the gate exactly as much as a twenty-year-old C codebase does, and phrasing the trigger as "on
a maintenance TTB" silently switches it off in the case this whole section exists to catch.

### A Maintenance TTB needs a map before it needs a spec

A greenfield TTB starts from nothing, so the only thing to understand is what you are about to
write. A maintenance TTB starts from code somebody else wrote — possibly the machine, ten
minutes ago — and the spec is only as good as your account of what is already there.

Before eliciting requirements for a maintenance TTB, consider generating a **code map** with a
program-understanding tool — `graphify`, `codebase-memory`, `serena`, `greptile`,
`sourcegraph`, or anything else that emits a structural account of a codebase. This is
optional and the method does not depend on it. What it must produce is a map that can be
**regenerated on demand** and that **carries the date it was generated**.

Kept next to the project's standing-instruction file, that map is the durable form of what
*Clean Code* calls shared team memory. Clean Code's version was a claim about people — a
tight-knit team that collectively holds the system in mind — and it does not survive turnover,
or six months. A generated, dated, regenerable artifact does; and when the team is one person
and a model, it is the only version of that memory available.

The date is the rule, not decoration. An undated map is the failure §4 names: it misleads with
authority, and a drifted map is worse than no map because the reader who trusts it stops
looking. Regenerate it rather than editing it, and do not trust it past its date.

### Impact analysis is a design product

For a maintenance TTB, what else the change reaches is a design question, and the answer is a
section of `DESIGN.md` that `yaait:code` ingests like any other design output. It is not a
step inside `yaait:code`: by the time the change is being written, the answer can no longer
alter the approach, which is the only thing it was for.

A design phase is not always warranted — `yaait:spec` applies criteria for that. For a
single-module change that reaches nothing outside the module it lives in, the module *is* the
blast radius and the comprehension gate already covers it. What triggers a design phase on
maintenance work is the change reaching outside its module.

Without it, "what does this do today" is unanswerable, so the defense degrades into a
formality — which is precisely the state that lets "I do not understand this, I will add a
flag" through the gate.

### An existing test is a statement about behaviour, not an obstacle

**Do not modify or delete an existing test unless `SPEC.md` says the behaviour that test
encodes is changing.** If it does not say that, the reconcile rule (§4) is firing: either the
spec is incomplete, or the change is wrong. Decide which, out loud, before touching the test.

This is a rule about your failure mode specifically. Asked to add behaviour, you will edit an
existing assertion until the new code passes, and the diff will look like progress. A passing
suite is then evidence of nothing, because the evidence was rewritten to fit. It is the same
mechanism as §6's predicted-versus-measured problem: the artifact that was supposed to check
the work got adjusted by the work.

Adding tests is unrestricted. Changing one that already passes is a behavioural decision, and
behavioural decisions belong in the spec.

### Refactors are expressed as named refactorings

`yaait:design` already selects design patterns and explains them. Refactoring gets the same
treatment, split across two gates:

- **`yaait:design`** names the refactorings that get from the current shape to the target
  shape, and tells the user what each one does — asking, and teaching where the user does not
  know, on the same terms as any other design decision.
- **`yaait:code`** applies them one at a time, saying which refactoring each step is. Its
  review asks whether the diff is a recognisable named refactoring or an ad-hoc rewrite.

This is not a requirement to follow the catalogue by the book. Prefer a named refactoring
where one fits, name it, and say plainly when you are deliberately not using one. A balanced
application is the point; coverage of the vocabulary is not.

The reason it is worth a rule: a named refactoring carries a behaviour-preservation contract
and an ad-hoc rewrite carries none. An unnamed rewrite mixes structural and behavioural
change in one diff, and afterwards nobody can say which of the two broke the test — or that
behaviour changed at all.

How far to extract is not settled here, and must not be. That is the open agenda in the
**code review criteria**, §5.

## 8. The artifacts

Method artifacts live in `.yaait/`. The rest live in the **project root** instead, because they
are things a team reads on their own account rather than machinery of the method — the same
reason `ROADMAP.md` sits at the root.

```
<project root>/
├── TECH_DEBT.md           outstanding structural debt, with evidence of what it has cost
├── EXPERIMENTS.md         decisions settled by measurement rather than by argument
├── DESIGN_GUIDELINE.md    optional: standing structural decisions (§12)
├── CODING_GUIDELINE.md    optional: standing house style (§12)
└── .yaait/
    ├── SPEC.md       the TTB: kind, requirements, non-goals, acceptance criteria
    ├── DESIGN.md     optional: components, invariants, budget, diagrams
    ├── TECH.md       optional: the stack, with verified versions and falsifiers
    └── JOURNAL.md    append-only record of decisions, approvals, debt and challenges
```

### Two kinds of debt, two files, and why they do not overlap

`JOURNAL.md` `DEBT` entries are **comprehension debt**: a person did not understand something
at a moment in time. That is a fact about a moment, it is true forever, and it is never
"resolved" — you cannot un-happen it. Append-only, historical.

`TECH_DEBT.md` is **structural debt**: the code has a known deficiency that will cost
something later. That is a live liability with a balance. It gets paid and removed.

Different lifecycles, so different files. The link between them runs one way: **persistent
comprehension debt is a leading indicator of structural debt.** Code nobody can defend, over
several increments, is usually code with a structural problem — and when that turns out to be
the case, it gets promoted into `TECH_DEBT.md`. The reverse also holds: a `TECH_DEBT.md` item
whose rationale nobody can explain is itself comprehension debt.

### TECH_DEBT.md

```markdown
# Technical debt

> Outstanding structural debt. Items are removed when paid, not marked done.
> Every item carries evidence of what it has actually cost, not an estimate of what it
> might.

Format: 1
Next ID: D-004

## D-001 — Game state is re-serialized in full on every move

- **Deliberate?** Yes — chosen 2026-08-21 to ship the save feature in one increment.
- **Containment:** contained behind `store.save()`. Nothing outside `store/` knows the
  format.
- **Interest — evidence of consequences:**
  - 2026-08-29 · fix F-014 (frame drops at 40+ moves) traced here.
  - 2026-09-03 · feature S-011 (undo) took roughly 2x estimate; the full-state write had to
    be special-cased.
- **Repayment:** switch to an append-only move log. Bounded to `store/`, ~1 day.
- **Trigger:** any requirement involving history, or a state size past ~1 MB.
- **Escalation:** 2 receipts.
```

**Receipts record what happened, never what is intended.** A trace ("this bug came from
here") is already true when you write it. A mitigation is not true until the code exists.
Writing an intended fix as though it had shipped makes the item look partly addressed, so the
next reader discounts it — which corrupts the one artifact whose whole value is being evidence.

The **containment** line is the most useful field, and more useful than any cost estimate,
because it is checkable rather than guessed. The **interest** section is what makes the item
arguable in front of someone holding a budget: it is receipts, not opinion.

An item with no evidence of consequences after a long time is a candidate for
`won't fix` — debt on code nobody touches accrues no interest, and pretending otherwise turns
the file into a wishlist. Record that verdict explicitly rather than leaving the item to rot.

### EXPERIMENTS.md

```markdown
# Experiments

> Decisions settled by measurement rather than by argument. Results are labelled
> `measured` or `predicted`; a `predicted` verdict is a hypothesis, not an experiment.

Format: 1
Next ID: X-003

## X-001 — Move-lookup structure for the board

- **Question (stated before running):** at 19x19 with under 400 stones, is a dict keyed by
  coordinate faster than a flat list scan for legality checks?
- **Candidates:** flat list scan · dict keyed by (x, y) · bitboard
- **Conditions:** Python 3.12, this laptop, 10k lookups, warm, N=5 runs.
- **Result:** `measured` — list 41 ms, dict 12 ms, bitboard 9 ms.
- **Verdict:** dict. Bitboard's 3 ms is not worth the readability cost at this size.
- **What would overturn this:** board larger than 19x19, or lookups on the hot path of a
  solver rather than a UI.
- **Exit path:** legality checks are behind `Board.is_legal()`; swapping to a bitboard means
  changing that method and its two tests, nothing else.
```

The **exit path** is distinct from an exit *cost* and more useful. A cost tells you how bad
it would be; a path tells the person who has to do it in a year where to start. Write it for
them, not for you.

The **question stated before running** is not a formality. Deciding what you were measuring
after seeing the numbers is the most common way a benchmark lies, and it is invisible in the
write-up unless the ordering is enforced.

### JOURNAL.md

Append-only. Never edit or delete an entry; if something turns out to be wrong, add a new
entry saying so. The value of this file is that it is a record, and a record that gets
tidied is a story.

Four entry types:

```markdown
## 2026-08-21

### DECISION — event loop over threads
- **Context:** input handling for the game loop.
- **Chosen:** single-threaded event loop.
- **Rejected:** a thread per input source — cost of synchronising shared game state
  exceeds the benefit at this scale.
- **Decided by:** Daniel.

### APPROVAL — Board.apply_move signature
- **Question asked:** "What happens if apply_move is called with a move for the wrong player?"
- **Answer:** correct — raises before mutating, so the board is never half-updated.
- **Approved by:** Daniel.

### DEBT — undefended: the retry backoff in net/client.py
- **Undefended:** why the backoff is exponential with jitter rather than fixed.
- **Concept not established:** thundering herd.
- **Consequence if wrong:** under a server outage, all clients retry in lockstep and
  extend the outage.
- **Accepted by:** Daniel, deliberately, to keep moving.

### CHALLENGE — persisting the whole game state every move
- **My position:** write only the move log; full-state writes will dominate frame time.
- **Daniel's position:** state is 4 KB, writes are async, simplicity wins at this size.
- **Outcome:** Daniel's. I conceded — I had not checked the state size and my objection
  assumed it was large.
- **Decided by:** Daniel.
```

`DEBT` and `CHALLENGE` are the two entry types that make this file worth keeping. Anyone
can log decisions. Logging what you did not understand, and logging the arguments you lost,
is what makes the record honest enough to be useful six months later.

---

## 9. Constraints are not decisions

Throughout, keep these apart:

- A **constraint** is inherited. It runs on Windows because the customer runs Windows. It
  is Python because the team is a Python team. Nobody chose it here.
- A **decision** is made. Someone weighed options and picked.

You are accountable for decisions. You are accountable for *knowing* your constraints, and
for saying when one is doing real damage — but not for having chosen them.

Conflating the two inflates the record with things nobody can defend because nobody decided
them, and it hides the handful of choices that actually matter inside a wall of
inevitabilities.

## 10. One change at a time

One TTB, one branch, one change in flight. Branch or die.

The artifacts in `.yaait/` carry no identifiers — there is one `SPEC.md`, not `SPEC-014.md`.
That is what the branch buys. A branch holds exactly one TTB, so the spec never has to say
which TTB it is the spec for, and nothing has to be namespaced to keep two of them apart.

Two specs coexisting in one branch make the reconcile rule (§4) undecidable. That rule turns
on the document disagreeing with the world, and with two documents in scope there is no fact
of the matter about which one the code answers to — any disagreement can be resolved by
pointing at the other spec, so nothing is ever reconciled and both documents drift.

Finish the TTB or abandon it before starting another. Abandoning is a legitimate outcome and
costs only the branch. A second TTB started on top of an unfinished one costs the record: from
that point no `JOURNAL.md` entry can be attributed to one of them, which is the one thing the
journal exists to make possible.

## 11. Name your units before you count them

The size budget is a number, and a number needs units. **Declare the units from the project's
own vocabulary, at the moment you declare the budget.**

A budget of "4 modules, 6 types, 1 interface, 0 abstract base classes" is a perfectly good
budget for a project that has classes. For a C project the units are translation units,
structs, headers and function-pointer tables. For a functional project they are modules, types
and the places behaviour is passed as a value. For a shell or configuration codebase they are
something else again. The units are whatever a reader of *this* project would count.

Manifesto principle 10 — simplicity is a declared number — survives intact, because the
mechanism was never the specific nouns. It was declaring the count before producing the thing,
so that the count is a commitment rather than a description of what you happened to write.

The rule exists because a budget in units the project does not have is not a loose budget; it
is an unenforceable one. Nobody can exceed a count of abstract base classes in C, so the
budget silently permits any amount of structure, which is the opposite of what it was for.

### The reference material speaks OO, and that is a dialect

The catalogues this method reads from — the architectural smell catalogue and the code review
criteria — are written largely in object-oriented vocabulary: classes, interfaces,
inheritance, GoF pattern names. That is a dialect, not a requirement, and much of it restates
directly: most architectural smells are properties of a dependency graph and read the same
whatever the nodes are.

Some of it does not restate, and **that translation has not been done yet**. Where a rule is
stated in terms the project does not have, translate it to the equivalent property of the
project's own units and say that you did. Where it has no equivalent, say that instead. Do not
apply a detector that cannot fire and report a clean result: an OO tell that is structurally
incapable of firing in C is not evidence of anything, and reporting it as a pass is the most
misleading possible outcome.

## 12. Standing decisions: the guidelines

Some questions get re-decided every increment, and should be decided once. Those live in two
files at the project root, next to `TECH_DEBT.md` and `EXPERIMENTS.md`, for the same reason
those are there: a team reads them on its own account rather than as machinery of the method.

```
<project root>/
├── DESIGN_GUIDELINE.md    standing structural decisions: what shapes this project prefers
└── CODING_GUIDELINE.md    standing house style: the questions the review criteria leave open
```

Both are optional. Neither is required to exist before anything else happens.

**Read what exists before asking anything.** The code, the standing-instruction file, any
style document already in the repo — all of it comes first. A survey that opens with questions
asks the user to invent answers the codebase has already given, and they will answer
differently from how the code actually reads, which produces a guideline that contradicts the
project on the day it is written.

**Precedence: an instruction given for this invocation wins for this invocation.** It is more
specific and more recent. But say out loud that it diverges from the guideline, because a
divergence absorbed in silence is how the guideline becomes fiction while still being cited.

**Promotion: an instruction given twice is a guideline nobody wrote down.** The second time,
offer to write it in. Otherwise it gets retyped on every invocation, drifts a little each
time, and the project ends up with a house style that exists only in the habits of whoever is
at the keyboard.

**The reconcile rule (§4) applies.** When the code and the guideline disagree, one of them is
wrong. Name which, out loud, and fix that side. A guideline nobody reconciles drifts exactly
as a design document drifts and misleads with exactly the same authority — worse, in fact,
because a guideline is quoted in review to settle arguments.

**Deliberately violating a settled guideline is debt.** Contain it behind a boundary (§5) and
record it (§8). "We do it this way except here" with no boundary and no record is not an
exception, it is the guideline ceasing to be true.

**A guideline is a decision while it is being written and a constraint afterwards** (§9).
Nobody defends the guideline once per increment; that would be the emptiest possible gate.
What gets defended is a deviation from it.

### What must not go in

Anything the review criteria settle. The guideline is for questions where a competent engineer
could defend either answer and the project needs one of them picked — not for questions that
have an answer.

Without that line, the guideline becomes the place every question the criteria declined to
answer gets dumped. That does not remove the vagueness; it relocates it, and it relocates it
onto the person least equipped to resolve it, at the moment they are least equipped to do it —
which is precisely inverted from what asking the user is for.

---

## Where the reference material lives

This document names its catalogues by what they are, because where they sit is a property of
how the method is packaged rather than of the method. In this distribution:

| Called here | Found at |
|---|---|
| the architectural smell catalogue | `skills/design/references/smells.md` |
| the code review criteria | `skills/code/references/review.md` |
| the diagram conventions | `skills/design/references/mermaid.md` |

A different packaging may put them elsewhere. Nothing above depends on these paths.
