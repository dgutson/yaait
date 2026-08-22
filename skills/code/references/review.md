# Code review criteria

> **STATUS: PROVISIONAL — pending the Clean Code discussion.**
>
> What is here is usable and grounded, but it is deliberately incomplete: yaait has not yet
> taken a position on Clean Code, and that position determines several rules in this file.
> The open questions are stated in §5 so the discussion has an agenda. Everything in §1–§4
> is expected to survive it.
>
> Tracked as **R-001** in this repository's `ROADMAP.md`.

This is the **code-level** counterpart to `skills/design/references/smells.md`. The two are
deliberately at different altitudes and should not overlap: architectural smells are
properties of a dependency graph and belong to `yaait:design`; what follows are properties of
a function, a file or a diff.

Same diagnostic chain: **observe → name → identify the cause → the cause is the fix.**

## Contents

1. [How to run this](#1-how-to-run-this)
2. [The measured patterns](#2-the-measured-patterns)
3. [Code-level smells](#3-code-level-smells)
4. [Test review](#4-test-review)
5. [Open: the Clean Code questions](#5-open-the-clean-code-questions)

---

## 1. How to run this

Run it against **your own diff**, before showing the increment to the user. Not against the
whole file, and not against the whole repository — the diff is what this invocation is
accountable for.

Order matters, because it puts the highest-yield checks first:

1. **§2, the measured patterns.** Five checks, mechanical, and they catch the failures that
   have been *counted* rather than merely asserted. Always run all five.
2. **§3, the code-level smells.** Scan; most will not apply.
3. **§4, the tests.** Especially "can this test fail".

Report what you found and what you changed. Report finding nothing if you found nothing —
that is a legitimate outcome and saying it plainly is better than manufacturing a finding to
look thorough. What is not legitimate is claiming a review happened without saying what was
looked for.

Cap the report at the three or four findings that would change the code. A wall of nits is
where the two real problems go to hide.

---

## 2. The measured patterns

These five have a different epistemic status from everything else in this file: they were
*measured*, across 623 million commits, as rising sharply in the era of AI-assisted
development. They are not style opinions. They are the specific ways generated code degrades
maintainability, quantified.

Run all five, every increment.

### 2.1 Duplicated blocks (+81%)

**Check:** does this diff contain a block that already exists elsewhere in the repo, or twice
within itself?

Search before you conclude. You will not remember what is in the codebase, and this is the
check most easily satisfied by a grep for a distinctive line.

The discriminator is *reason to change*: two similar blocks that would change for different
reasons are fine and should stay separate. Two blocks encoding the **same decision** are one
block, and leaving them apart means someone eventually updates one.

### 2.2 Within-commit copy/paste (+41%)

**Check:** did you paste-and-edit within this increment?

2024 was the first year on record in which within-commit copy/paste exceeded *moved* code —
the industry now duplicates more than it refactors, inside a single change. This is the most
avoidable item in this file, because the evidence is right there in your own diff: three
blocks with the same shape and different literals.

### 2.3 Error masking (+47%)

**Check:** does any handler here neither propagate, retry, nor record?

The shapes: `except: pass`, `catch {}`, `?? ''`, `.get(k, default)` where a missing key means
a bug, `if err != nil { }`, a fallback that turns an outage into wrong data, a broad
`except Exception` around a block where only one thing was expected to fail.

The test: **what does the caller see when this fires?** If the answer is "success", it is
masking, and it converts a loud failure into a quiet wrong answer — which is strictly worse,
because a crash gets fixed and a wrong answer gets stored.

Legitimate swallows exist — a best-effort cache warm, a cleanup path in a destructor. They
are legitimate *when the comment says why*, which makes this the clearest case in the file
where a comment is load-bearing rather than noise.

### 2.4 Reimplementing what exists (reuse down 35%)

**Check:** does this diff contain a function that the codebase, the standard library, or an
already-present dependency provides?

Cross-file function calls — the observable signature of reuse — fell about 35%. The mechanism
is straightforward: generating a helper is faster than finding one, and it produces working
code, so nothing pushes back. Look before you write, especially for parsing, path handling,
retry, date arithmetic and string normalization, which are where this happens most.

### 2.5 Immediate churn (+15%)

**Check:** is this code you already rewrote once during this increment?

Two-week churn — code rewritten almost immediately after being written — is up. High churn
inside a single increment usually means the design was wrong rather than the code, and the
correct response is the reconcile rule, not a third attempt. If you are on the third rewrite
of the same function, stop and say so.

---

## 3. Code-level smells

Fowler's list, plus the two that matter most under yaait. Scan; most will not apply to a
small increment.

- **Long Method** — does more than one thing. *Tell:* you cannot name it without "and", or
  it needs a comment to announce sections. *Fix:* extract the sections you were about to
  label. (Note: how far to take this is exactly what §5 is unresolved about.)
- **Large Class / Module** — too many responsibilities. Same test as SRP, one altitude down.
- **Long Parameter List** — *Tell:* more than about three, or any parameter that only matters
  when another has a particular value. That second form is the real signal: it means two
  functions are wearing one signature.
- **Feature Envy** — a function more interested in another object's data than its own.
  *Tell:* repeated `other.x`, `other.y`, `other.z`. *Fix:* move the behaviour to the data.
- **Data Clumps** — the same group of values travelling together everywhere. *Fix:* they are
  a type; name it.
- **Primitive Obsession** — a string that is really an ID, a float that is really money, an
  int that is really an enum. *Tell:* validation of the same shape in several places.
- **Message Chains** — `a.b().c().d()`. Couples the caller to the whole path.
- **Middle Man** — a class or function that only delegates. The code-level Poltergeist.
- **Divergent Change** — one module changed for unrelated reasons. The inverse of Shotgun
  Surgery, and an SRP violation visible in the git log.
- **Comments as deodorant** — a comment explaining *what* confusing code does. The comment is
  a symptom; the code is the disease. Note carefully: this is about comments explaining
  **what**. Comments explaining **why** are a different thing entirely and yaait wants more
  of them — see §5.
- **Dead code** — unreachable, unused, or commented out. Delete it. Version control is the
  archive; commented-out code is how Lava Flow starts.
- **Defensive redundancy** — the same condition validated at three levels. Reads as
  thoroughness; actually diffuses ownership, so no layer will dare drop the check. Decide
  which layer owns the invariant, state it in `DESIGN.md`, delete the rest.

---

## 4. Test review

- **Can this test fail?** The only question that matters. Mentally break the code and check
  the test notices. If it would still pass, it asserts something the code does not control —
  a test of the mock, of the framework, or of nothing.
- **Does it test behaviour or implementation?** A test that breaks when you rename a private
  method is a maintenance tax with no safety payoff.
- **Is the assertion specific?** `assert result` passes for `True`, `1`, `"error"` and a
  non-empty list of failures.
- **Does each acceptance criterion have a test naming its requirement ID?** This is what
  makes `yaait:stest` a trace rather than a demo.
- **Are the invariants from `DESIGN.md` tested?** They are the properties the design rests
  on, and the ones a future change will break.
- **Twelve tests of one case are one test.** Coverage of *cases* is the goal; parametrize and
  spend the effort on a case that is not covered.
- **What is not tested?** Say it. Every increment. Named untested surface is useful; unnamed
  untested surface is a false sense of coverage.

---

## 5. Open: the Clean Code questions

**This section is the brief for R-001, not guidance.** Until it is resolved, apply §1–§4 and
say explicitly when a judgment falls into one of the gaps below rather than inventing a
resolution.

yaait has not taken a position on *Clean Code*, and it cannot borrow one, because several of
that book's prescriptions **conflict with decisions yaait has already made.** These are not
matters of taste; they are contradictions that would make the review criteria incoherent.

**Q1 — Function size versus the size budget.** "Extract till you drop" and "functions should
be four lines long" produce many small functions, each named, each delegating. That is the
same shape as Poltergeist, Middle Man and Lasagna Code, all of which
`design/references/smells.md` condemns — and it collides directly with the numeric budget
`yaait:design` declares. Both positions cannot hold. Which wins, and where is the boundary?

**Q2 — Comments.** Clean Code holds that a comment is a failure to express yourself in code.
yaait holds that the human must be able to defend this code in six months. Code can express
*what* and *how*; it cannot express *why this and not the obvious alternative*, which is
precisely what a defense asks for. The `JOURNAL.md` captures some of it, but a journal entry
is not in the reader's field of view when they are about to change the line. Where does the
*why* live?

**Q3 — Many small classes.** Clean Code prefers many small classes with single
responsibilities. Past some point that is Lasagna Code and it raises the cost of
understanding any single behaviour — the Yo-Yo problem. Where is the point?

**Q4 — Which prescriptions have empirical support at all?** Several Clean Code rules are
widely followed and, as far as anyone has shown, unmeasured. yaait's other criteria in §2
are counted. A methodology that leans on measurement in one section and on a 2008 style
guide in the next should say which it is doing.

**Q5 — What does yaait do about `yaait:code` being invoked on a codebase whose team already
follows Clean Code?** The review must be useful without relitigating the house style, and
the reconcile rule does not obviously apply to conventions.

Until R-001 lands, resolve conflicts in favour of §2 — the measured patterns — and say when
you are in a gap.
