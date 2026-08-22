# Design smells, antipatterns and the principles they violate

A diagnostic chain, not four lists. Use it in one direction:

> **Observe a smell → name the antipattern → identify the violated principle → the
> principle is the fix.**

Each layer answers a different question, which is why collapsing them loses the value:
smells are what you can *see*, antipatterns are what it is *called*, principles are what to
*do*. A review that reports "this violates SRP" without a symptom is unfalsifiable; one
that reports a symptom without a principle is a complaint.

## Contents

1. [How to run a design review with this](#1-how-to-run-a-design-review-with-this)
2. [Layer 1 — the seven architectural smells](#2-layer-1--the-seven-architectural-smells)
3. [Layer 2 — the antipatterns](#3-layer-2--the-antipatterns)
4. [Layer 3 — the principles](#4-layer-3--the-principles)
5. [Mapping: smell → antipattern](#5-mapping-smell--antipattern)
6. [Mapping: antipattern → principle](#6-mapping-antipattern--principle)
7. [Most reliable tells](#7-most-reliable-tells)
8. [LLM-specific antipatterns](#8-llm-specific-antipatterns)
9. [Non-OO mappings](#9-non-oo-mappings)
10. [Coupling, in order of badness](#10-coupling-in-order-of-badness)
11. [Provenance](#11-provenance)

---

## 1. How to run a design review with this

Do not walk the whole taxonomy. That produces a wall of findings in which the two real ones
are invisible.

1. **Look for the smells first**, because they are the only layer you can actually observe.
   Ask each of the seven questions in §2 against the design. Most will be "no".
2. **For each smell you find, name the antipattern** using §5. The name is worth having:
   it turns "this feels tangled" into a thing with known consequences.
3. **Look up the violated principle** in §6. That is the fix, and it is a specific fix
   rather than "simplify it".
4. **Then run §8 against your own design**, separately. §2–§6 describe how human code
   decays. §8 describes how you fail, which is in the opposite direction, and no amount of
   classical review will catch it.
5. **Report what you removed, not just what you found.** A review that only adds is not a
   review.

Report at most the three or four findings that would actually change the design. Rank by
cost of being wrong, not by how nameable the smell is.

---

## 2. Layer 1 — the seven architectural smells

These are properties of the **dependency graph**, not of any single component. Each has an
observable test — use the test, not the vibe.

### Rigidity
**One change cascades into many.** A single new requirement forces edits across modules
that have no conceptual relationship to it.

*Test:* take the most likely next requirement from the spec. Count the components it forces
you to open. More than two, and none of them obviously the owner? Rigid.

### Fragility
**Changes break things in unrelated places.** Editing A produces failures in B, C and D,
and nobody predicted it from reading A.

*Test:* for each component, name what breaks if its behaviour changes slightly. If the
answer contains something a reader would not have guessed, it is fragile.

Rigidity and Fragility are distinct and frequently confused. Rigid means *hard to change*.
Fragile means *dangerous to change*. A design can be either without the other, and they have
different fixes.

### Immobility
**You cannot lift a part out and use it elsewhere**, because it drags too much with it.

*Test:* pick the most obviously reusable component. List what you would have to bring along
to use it in a different program. If the list includes the config system, the logger and a
database handle, it is immobile.

### Viscosity
**Doing it right is harder than doing it wrong.** The design makes the correct extension
point awkward and the hack convenient, so the hack wins — every time, forever.

*Test:* for the next likely requirement, is the shortcut easier than the right way? If yes,
the shortcut is what will be built, and no amount of discipline changes that. Viscosity is
the smell that generates all the others, which is why it is the one worth fixing first.

(Environmental viscosity — slow builds, slow tests — has the same effect and belongs in
`yaait:tech`.)

### Opacity
**A reader cannot tell what it does or why.** Not "it is complicated" — complicated things
can be clear. Opaque means the *intent* is unrecoverable from the artifact.

*Test:* can a competent stranger state each component's purpose from the design alone,
without asking? If reconstructing intent needs the conversation that produced it, it is
opaque — and the conversation will not be there.

Opacity is the smell that matters most under yaait, because it is the one that makes the
comprehension gate unpassable later.

### Needless complexity
**Structure serving no current requirement.** Anticipatory generality. The extension point
nothing extends.

*Test:* for every element, name the spec requirement it serves. Anything that cannot be
traced to one is on trial. This is the smell you are most likely to introduce yourself.

### Needless repetition
**The same idea expressed more than once**, so a change has to be made in several places
and one of them gets missed.

*Test:* would a change to this rule require edits in more than one location? Note that
repeated *code* with different reasons to change is fine; repeated *decisions* are not.
DRY is about knowledge, not about characters.

---

## 3. Layer 2 — the antipatterns

### Lava Flow
Dead or fossilized code nobody dares remove, because nobody knows what depends on it. It
accretes, and each layer makes the next removal scarier.

*Smells:* Opacity, Needless Complexity, Immobility.

### God Object
One component that knows and does everything — data, persistence, presentation, business
rules. Everything depends on it, so nothing can be tested or moved without it.

*Smells:* Rigidity, Fragility, Immobility, Opacity.

### Yo-Yo Problem
Understanding one behaviour requires jumping up and down a deep inheritance chain. The
logic exists, but nowhere in particular.

*Smells:* Opacity, Fragility.

### Poltergeist
A short-lived, stateless component whose only job is to call something else. A `Manager`, a
`Coordinator`, a `Handler` that forwards. It appears, delegates, and vanishes, adding a hop
and no behaviour.

*Smells:* Needless Complexity, Opacity.

### Shotgun Surgery
One conceptual change requires edits in many components. The inverse of God Object — a
responsibility smeared instead of concentrated.

*Smells:* Rigidity, Fragility, Viscosity.

### Spaghetti Code
Control flow and data flow tangled such that no path can be traced end to end. Everything
reaches everything.

*Smells:* Opacity, Fragility, Rigidity, Immobility.

### Lasagna Code
Excessive **impermeable** layers. Every change must be threaded mechanically through all of
them, so the layering costs on every change and pays on none.

*Smells:* Viscosity, Needless Complexity, Rigidity.

Layering itself is not an antipattern, and a checklist that flags all layering cries wolf
until it is ignored. The test is whether a typical change touches one layer or all of them.
A layer that *absorbs* change is architecture; a layer that *relays* change is lasagna.

### False Abstraction
An abstraction with one implementation. An interface, base class or indirection that hides
the concrete thing without ever varying it — so a reader must understand both the
abstraction and the single concrete case, and gets nothing for it.

*Smells:* Needless Complexity, Opacity, Viscosity.

This is the antipattern you will commit most often. See §8.

---

## 4. Layer 3 — the principles

These are the fixes. Each names the specific change to make.

### SOLID

- **SRP** — Single Responsibility. One reason to change per component. *Fixes:* God Object,
  Shotgun Surgery.
- **OCP** — Open/Closed. Extensible without modification: new behaviour arrives as new code,
  not as edits to old code. *Fixes:* Rigidity. *Caution:* the most-abused principle in this
  list — pursuing OCP speculatively is how False Abstraction gets built. Apply it where
  variation has actually been observed.
- **LSP** — Liskov Substitution. A subtype must be usable anywhere its supertype is, without
  the caller knowing. *Fixes:* Yo-Yo, Fragility from inheritance.
- **ISP** — Interface Segregation. Clients should not depend on methods they do not use.
  *Fixes:* Immobility, Fragility, coupling through fat interfaces.
- **DIP** — Dependency Inversion. Depend on abstractions, and let the concrete detail depend
  inward. *Fixes:* Immobility, Rigidity. *Caution:* same as OCP — DIP is the justification
  most often cited for an interface with one implementation.

### GRASP

- **Information Expert** — put behaviour where the data it needs already lives. *Fixes:*
  Feature-envy-shaped coupling, anemic components.
- **Creator** — the thing that aggregates or closely uses B should create B. *Fixes:*
  scattered construction, Poltergeist factories.
- **Controller** — one coordinator per system operation or use case, not per class. *Fixes:*
  Spaghetti at the entry points.
- **Low Coupling** — minimize what each thing needs to know. *Fixes:* nearly everything;
  this is the master principle of the list.
- **High Cohesion** — elements inside a component belong together. *Fixes:* God Object,
  Lava Flow.
- **Polymorphism** — vary behaviour by type instead of by branching on type. *Fixes:*
  conditional sprawl. *Caution:* only when variation exists; polymorphism over one case is
  False Abstraction.
- **Pure Fabrication** — invent a component with no real-world counterpart to keep cohesion
  high (a `Repository`, a `Scheduler`). *Fixes:* God Object, misplaced responsibility.
- **Indirection** — insert an intermediary to decouple two things. *Fixes:* coupling.
- **Protected Variations** — wrap the parts known to be unstable behind a stable interface.
  *Fixes:* Fragility at the edges.

**The contradiction you must resolve.** Pure Fabrication, Indirection, Polymorphism, OCP and
DIP all *prescribe* adding a layer. False Abstraction and Poltergeist *condemn* adding a
layer. Same act. Unresolved, the taxonomy justifies anything.

Resolve it empirically, every time:

1. How many concrete variants exist **today**?
2. What **named, dated event** would add another?

One variant and no named event → False Abstraction; use the concrete thing. Two or more →
justified. One plus a specific imminent second ("Postgres in March", "the customer SDK ships
Q3") → justified, and record the event, so a later reader can check whether it happened. If
it did not, the abstraction is now debt with a receipt.

"We might want to swap this out later" is not a named event. It is the sentence that builds
every plugin system nobody used.

**One exemption, and it is not a loophole.** A boundary drawn to *contain deliberate technical
debt* — the litter box — has exactly one implementation by construction, and this rule would
delete it. It survives because its justification is not a hypothetical second variant but a
**dated intention to replace the first**, recorded as an item in `TECH_DEBT.md`. That is a
named event in the sense above.

Two conditions keep it from becoming an excuse. The debt item must actually exist in
`TECH_DEBT.md` with its containment recorded — an unrecorded litter box is just False
Abstraction with a story. And the exemption **expires**: once the debt is paid, if the boundary
has one implementation and nothing behind it, this rule applies again and the boundary should
go.

---

## 5. Mapping: smell → antipattern

Read down the smell you observed to find candidates.

| Observed smell | Most likely antipatterns |
|---|---|
| Rigidity | Shotgun Surgery, God Object, Lasagna Code, Spaghetti Code |
| Fragility | God Object, Spaghetti Code, Shotgun Surgery, Yo-Yo Problem |
| Immobility | God Object, Spaghetti Code, Lava Flow |
| Viscosity | Lasagna Code, Shotgun Surgery, False Abstraction |
| Opacity | Spaghetti Code, Lava Flow, Yo-Yo Problem, God Object, Poltergeist, False Abstraction |
| Needless Complexity | False Abstraction, Poltergeist, Lasagna Code, Lava Flow |
| Needless Repetition | Shotgun Surgery, Lava Flow |

## 6. Mapping: antipattern → principle

Read across the antipattern you named to find the fix.

| Antipattern | Primary violations | Apply |
|---|---|---|
| Lava Flow | High Cohesion, SRP | delete it; if you cannot prove it is dead, that is the finding |
| God Object | SRP, High Cohesion, Information Expert | split by reason-to-change, not by noun |
| Yo-Yo Problem | LSP, Low Coupling | flatten; prefer composition over depth |
| Poltergeist | Creator, Low Coupling, Information Expert | delete the middleman; let the caller call |
| Shotgun Surgery | SRP, High Cohesion, Protected Variations | gather the responsibility into one owner |
| Spaghetti Code | Low Coupling, Controller, High Cohesion | give each operation one coordinator |
| Lasagna Code | Low Coupling, Indirection (over-applied) | collapse layers that only relay |
| False Abstraction | OCP/DIP (misapplied), Polymorphism (misapplied) | inline it; use the concrete type |

Note the last two rows: their fix is to **stop applying** a principle. The taxonomy is not
monotone — more principles applied is not better design.

## 7. Most reliable tells

Unweighted matrices treat every relation as equally informative, which they are not. These
are the observations that actually discriminate, in rough order of signal:

1. **An interface with exactly one implementation** → False Abstraction, near-certainly.
   The single most reliable finding in this document, and the most common in LLM designs.
2. **A component whose responsibility sentence needs "and" between unrelated things** →
   SRP violation, at the cheapest possible moment to fix it.
3. **A class whose name ends in `Manager`, `Handler`, `Coordinator`, `Helper` or `Util`, and
   which owns no data** → Poltergeist or God Object. Which one depends on size, and it is
   always one of them, because those names are what you call something whose responsibility
   you could not state.
4. **A typical change touching every layer** → Lasagna Code. Note this is a statement about
   *changes*, not about layer count; test it with a real requirement.
5. **Two components that must be edited together, always** → Shotgun Surgery, or they are
   one component pretending to be two.
6. **A dependency arrow pointing from stable to unstable** → DIP violation; the fix is to
   invert that specific arrow, not to add interfaces everywhere.
7. **Behaviour that requires reading three files to understand one decision** → Yo-Yo or
   Spaghetti; the discriminator is whether the three files are related by inheritance.
8. **Any element you cannot trace to a spec requirement** → Needless Complexity. Trace
   before you argue.

---

## 8. LLM-specific antipatterns

**Read this section against your own design before showing it to anyone.**

The classical taxonomy is from 1999–2004 and describes how human code decays: erosion under
schedule pressure, over years, in code many people touched. Lava Flow, Shotgun Surgery and
Spaghetti are what tired teams produce.

You do not fail that way. You fail in the opposite direction: **premature, confident
over-structure, produced in one pass, all of it plausible.** The classical smells will not
catch it, because a freshly generated over-engineered design is clean, consistent and
well-named. It smells great. That is the problem.

### False Abstraction
Already in §3, listed again because it is your number one. An `AbstractBase`, a
`StorageBackend`, an `IValidator` — with one implementation. *Tell:* count the
implementations. One means delete.

### Speculative Generality
The plugin system, the strategy pattern with one strategy, the config file with one option,
the `**kwargs` nothing passes, the event bus with one publisher and one subscriber. Built
for a future that was never specified.

*Tell:* an element whose justification is a sentence in the future tense.

### Gold plating
Features and structure nobody asked for: a caching layer for a program that runs once, a
retry policy for a local file read, a logging framework for a 200-line script.

*Tell:* trace every element to a spec requirement. Whatever does not trace is gold plating
until proven otherwise, and the burden of proof is on the element.

### Symmetry-driven design
Adding `delete` because there is a `create`. Adding `deserialize` because there is a
`serialize`. Adding `pause` because there is `resume`. Completing a set nobody asked to have
completed, because incompleteness reads as an oversight.

*Tell:* for each operation, name the spec requirement that needs it. Symmetric pairs where
only one half traces are the signature.

### Pattern-name-driven design
Reaching for a named pattern because it is *named* — Factory, Observer, Strategy, Visitor,
Repository — rather than because the problem has that shape. You are extremely fluent in
pattern vocabulary, which makes this worse for you than for a human: you can produce the
justification as fluently as the pattern.

*Tell:* the pattern name appears in the design before the problem it solves does. Also: any
design containing three or more named GoF patterns for a problem under a thousand lines.

### Phantom dependency
The design assumes a library, module, class or method that does not exist, was removed, or
was renamed — usually one that was current at training time. Not a classical antipattern,
because humans do not hallucinate APIs.

*Tell:* every external name in the design must be verified against current documentation,
not recalled. This mostly belongs to `yaait:tech`, but it leaks into design whenever a
component is shaped around an assumed API.

### Anachronistic idiom
Using the technique that was dominant when you were trained rather than the one that is
current: the superseded async pattern, the deprecated config format, the packaging approach
the ecosystem moved off, the class-based API where the library now recommends functions.

*Tell:* you are confident and did not check. State the confidence type — this is exactly
the case the confidence labelling in `METHODOLOGY.md` §2 exists for.

### Sedimentary interface
The failure mode of increment-by-increment work, which is how `yaait:code` operates, so
watch for it specifically. Each increment bolts one more parameter, one more optional flag,
one more special case onto an existing interface, because changing the interface is more
work than extending it. No single increment is unreasonable. After six, the signature is
unreadable and nobody chose it.

*Tell:* a function with more than about three optional parameters, or any parameter that
only matters when another parameter has a particular value. Fix by reconsidering the
interface, which means going back to `DESIGN.md`.

### Defensive redundancy
The same condition checked at four levels: the caller validates, the function validates, the
inner helper validates, and the type system already guaranteed it. Reads as thoroughness,
actually diffuses responsibility — now no layer owns the check, so all of them are afraid to
drop it.

*Tell:* the same guard clause on both sides of a call boundary. Decide which side owns the
invariant, state it in `DESIGN.md`, and delete the other.

### Error masking
Silently swallowing failures: `except: pass`, `catch {}`, `?? ''`, a default that hides a
missing key, a fallback that turns an outage into wrong data. Measured across 623 million
commits at **+47%** in the era of AI assistance, which makes this the least deniable item
here.

*Tell:* any handler that neither propagates, retries, nor records. Ask what the caller sees
when it fires — if the answer is "success", it is masking.

### Reaching for the sophisticated algorithm

A red-black tree where a sorted list of twenty items is faster. A trie where a dict is fine.
An LRU cache on something called four times. A B-tree index over a file that fits in memory.
Bloom filters, tries, skip lists, custom allocators — reached for because they are *known*,
not because the problem is big enough to need them.

This is the algorithmic sibling of pattern-name-driven design and it has the same cause: the
corpus is full of algorithm tutorials and nearly empty of "I just used a list." The impressive
answer is the fluent one, and it is also frequently slower, because at small N the constant
factors dominate and the asymptotically better structure loses.

*Tell:* **state N.** An algorithm choice with no stated N is not a decision, it is a
preference — and if you cannot say what N is, that is the finding. Ask, or measure it and
record the result in `EXPERIMENTS.md`. Asymptotic superiority at unknown N is not an argument.

### Config-driven everything
Extracting values into configuration that has exactly one setting, so that behaviour now
lives in two files instead of one and the reader must consult both.

*Tell:* a config key with one possible value and no named event that adds a second. Same
test as False Abstraction, applied to data.

---

## 9. Non-OO mappings

The vocabulary above presumes classes. Much real code is not shaped that way — Lua
extension scripts, C, data-oriented designs, functional cores. A checklist that assumes
objects misfires there and then gets ignored, which is worse than having no checklist,
because "we reviewed it" gets said either way.

The *smells* are paradigm-independent — they are properties of a dependency graph, and
every paradigm has one. Only the antipattern names need translating.

| OO concept | Functional / procedural / data-oriented equivalent |
|---|---|
| God Object | the 900-line module; the struct every function takes; the global config table |
| Poltergeist | a wrapper function that only calls another with the same arguments |
| Yo-Yo Problem | a chain of higher-order wrappers; deep decorator or middleware stacks |
| Shotgun Surgery | a data shape change forcing edits in every function that touches it |
| False Abstraction | a callback parameter with one call site; a dispatch table with one entry |
| Lasagna Code | a pipeline stage that only reshapes data for the next stage |
| SRP | one reason to change per module or function |
| OCP | new cases arrive as new functions or table entries, not as edits to a switch |
| LSP | all implementations of a callback signature honour the same contract |
| ISP | do not pass a whole record where two fields are used — see §10 |
| DIP | pass the effect in (a handle, a writer, a clock) instead of importing it |
| Information Expert | the transformation lives with the data shape it understands |
| High Cohesion | a module's functions operate on the same data |
| Protected Variations | isolate the format, the syscall, the vendor quirk behind one function |

Worked example, since Lua sensor collectors are a real case: a collector script that reads
config, runs three commands, parses each output differently, and formats a report has a God
Object smell even with no classes in sight — one reason to change would be enough, and it
has four. The fix is Information Expert: one parse function per output shape, each living
with the knowledge of that shape.

---

## 10. Coupling, in order of badness

Coupling is the single most useful axis in this document, because it is the only one that
is roughly measurable and it underlies most of the rest. Worst first:

1. **Content coupling** (also *code coupling*) — B reaches into A's internals: a private
   field, an undocumented function, a memory layout. Any change to A's implementation, even
   one that preserves its documented behaviour, can break B. *Fix:* go through the public
   interface. If the public interface does not expose what B needs, that is the finding —
   the interface is wrong, not the reach-around.
2. **Common coupling** — several components share global mutable state. Nobody owns it and
   every change is everyone's problem.
3. **Control coupling** — A passes B a flag that tells B *which behaviour to run*. B now has
   two responsibilities and A knows about both. *Fix:* two functions.
4. **Stamp coupling** (also *data-structure coupling*) — A passes B a whole record when B
   uses one field. Now B's signature implies it might use any of them, changes to unused
   fields ripple into B's tests, and B has access to data it has no business seeing —
   passing a full user record to the email service so it can read `email` also hands it the
   credit card. *Fix:* pass the field. This is ISP applied to data.
5. **Data coupling** — A passes B exactly the values B needs. This is the goal, not a smell.
6. **Message coupling** — B knows only that a message arrived. Loosest, and not free: it
   trades coupling for opacity, since control flow is no longer traceable by reading. Choose
   it for a reason, not for a score.

The useful review question is not "is this coupled?" — everything is. It is **"what is the
tightest coupling in this design, and is it between the two things most likely to change
independently?"**

---

## 11. Provenance

The classical taxonomy comes from:

- Robert C. Martin, *Agile Software Development, Principles, Patterns, and Practices* —
  SOLID and the seven design smells.
- *AntiPatterns: Refactoring Software, Architectures, and Projects in Crisis*
  (Brown, Malveau, McCormick, Mowbray) — the antipatterns.
- Martin Fowler, *Refactoring* — Speculative Generality, and the code-level smells used by
  `yaait:code` rather than here.
- Craig Larman, *Applying UML and Patterns* — GRASP.
- Gamma, Helm, Johnson & Vlissides, *Design Patterns* — the pattern vocabulary that §8
  warns about over-applying.

The layered structure and the two mapping matrices are adapted from
*ANTIPATTERNS - Eclypsium 2026* (in this repository's root).

**Two honest notes about that adaptation.** The deck's matrices are images, and its text
layer preserves the row and column labels but not which cells carry a mark. So the mappings
in §5 and §6 were **rebuilt from first principles for yaait** rather than transcribed, and
they may differ from the deck's in individual cells. Where they disagree, the deck is the
older authority and this file is the one that has to justify itself.

Sections §7 (most reliable tells), §8 (LLM-specific), §9 (non-OO mappings) and the ordering
in §10 are yaait's own and are not in the source deck.
