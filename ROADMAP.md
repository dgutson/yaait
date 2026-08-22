# Roadmap

> Pending work only — finished items move to HISTORY.md.
> This is the durable record of what's outstanding. Read it instead of reconstructing
> the state of play from git history, old conversations, or a sweep of the code.
> Next thing to work on: the first item under the earliest horizon whose **Blocked-by**
> entries are no longer present in this file.

Format: 1
Next ID: R-011

---

## Now

### R-001 — Resolve yaait's position on Clean Code

- **Category:** Doctrine
- **What:** Hold a dedicated discussion on *Clean Code* and rewrite
  `skills/code/references/review.md` §5 into settled criteria. The five open questions are
  already written out in that file as the agenda: function size versus the declared size
  budget; where the *why* lives if comments are held to be a failure; how many small classes
  is too many; which Clean Code prescriptions have any empirical support; and what
  `yaait:code` does in a codebase whose team already follows the book.
- **Why:** Several Clean Code prescriptions **contradict decisions yaait has already made**,
  so this cannot be settled in a paragraph. "Extract till you drop" and many-small-classes
  produce the Poltergeist, Middle Man and Lasagna shapes that
  `skills/design/references/smells.md` condemns, and collide with the size budget
  `yaait:design` declares. "Comments are a failure to express yourself in code" collides
  head-on with the comprehension gate: code can express *what* and *how*, never *why this
  and not the obvious alternative* — which is exactly what a defense asks for. Until this
  lands, `yaait:code`'s review criteria are marked provisional and the conflicts are
  unresolved in a file the user reads.
- **Outcome:** `review.md` §5 is replaced by settled criteria, the PROVISIONAL banner is
  removed, and any consequent change to `design/references/smells.md` or to `design`'s
  budget rule is made in the same pass.
- **Blocked-by:** R-008
- **Enables:** R-002

### R-002 — Dogfood yaait on a real TTB and record where it was skipped

- **Category:** Validation
- **What:** Build something real — a game is the intended first subject — in a **fresh
  session and a separate directory**, using only the installed plugin. Record, per command,
  whether it was invoked, and where the methodology was abandoned mid-flow.
- **Why:** yaait's stated failure mode is ceremony fatigue: not bad advice, but the user
  quietly stopping. That signal is invisible unless it is recorded deliberately, and it
  cannot be gathered in the session that wrote the skills, where the author unconsciously
  fills gaps the skills left. Note going in that a game exercises `spec` and `design` well
  and `stest` weakly, since game acceptance criteria are fuzzy.
- **Outcome:** A written record of which gates were used and which were skipped, and at
  least one concrete revision to a SKILL.md driven by it.
- **Blocked-by:** —
- **Enables:** R-003, R-004

### R-005 — A mechanism that re-checks whether a decision's falsifier has fired

- **Category:** Doctrine
- **What:** Nothing in yaait ever revisits a settled decision. `EXPERIMENTS.md` entries carry
  "what would overturn this" and an exit path; `TECH.md` entries carry a falsifier and an exit
  cost. No command ever goes back and asks whether any of those conditions have now become
  true. Design the mechanism — most likely a rule in `yaait:stest` or `yaait:debt` rather than
  a seventh command — and specify what it reads and what it files.
- **Why:** A decision recorded with an expiry condition that nobody checks is worse than one
  recorded without, because it creates a false impression of being managed. "We chose lib A
  because it is good enough now" is correct until the input scale changes, and the moment it
  stops being correct is exactly the moment nobody is looking. This is the same failure the
  reconcile rule fixes for documents, applied to decisions.
- **Outcome:** Expired decisions surface on their own, in a named command, and produce either
  a revision or a recorded "still valid".
- **Blocked-by:** —
- **Enables:** —

### R-006 — A legacy-code survey command to seed TECH_DEBT.md

- **Category:** Commands
- **What:** A command that reads an existing codebase and populates `TECH_DEBT.md` with the
  structural debt it finds — the brownfield on-ramp. Needs a name: `:forensics` collides
  conceptually with the existing `sherlock` skill, which is forensic device investigation, so
  consider `:survey` or `:audit`. Must decide how it scopes (whole repo is too much for one
  pass), how it avoids producing 200 unactionable items, and how it marks findings as
  `Deliberate? No` and `containment: spread` honestly. Likely shares an input with the code
  map recommended in `METHODOLOGY.md` §7 — check before building a second code reader.
- **Why:** `TECH_DEBT.md` currently only fills up as someone happens to touch code, so
  adopting yaait on an existing codebase starts from an empty debt file that implies there is
  no debt. That is the opposite of true and it is the most misleading possible starting state.
  Most software that matters is legacy, so this is the difference between yaait being
  adoptable and being a greenfield curiosity.
- **Outcome:** A new skill that can be pointed at an existing codebase and produce a
  prioritised, evidence-carrying `TECH_DEBT.md` rather than a list of complaints.
- **Blocked-by:** —
- **Enables:** —

### R-007 — Surface repeated teaching of the same concept

- **Category:** Doctrine
- **What:** The defense records which concepts triggered teaching. Nothing notices when the
  *same* concept triggers it repeatedly across increments. Decide where that check lives and
  what it does when it fires.
- **Why:** The teaching loop is deliberately inside the development flow, which is efficient —
  learning at the point of need — but it has a blind spot: a junior can be taught the same
  concept fifteen times across fifteen increments and nobody notices there is no progression.
  That converts the educational principle from an investment into a treadmill, and it is
  invisible without an explicit check even though the data is already in `JOURNAL.md`.
- **Outcome:** Repeated teaching of one concept is surfaced as a signal, with a suggestion
  that it be learned properly outside the flow.
- **Blocked-by:** —
- **Enables:** —

### R-008 — A `/yaait:guideline` command and CODING_GUIDELINE.md

- **Category:** Commands
- **What:** A command that surveys the existing code and whatever `CLAUDE.md` already says,
  then surveys the **user**, and writes `CODING_GUIDELINE.md`. It settles house style: the
  rows of `skills/code/references/aposd-vs-clean-code.md` where both stances survive both
  filters — contemporary practice *and* generated code — plus baseline items that need
  deciding once (duplication and DRY; information leakage, e.g. a helper used by exactly one
  class belonging inside it). Like `yaait:code`, it asks rather than decides, and leaves an
  explanation space when the user does not know. The methodology rule requiring a settled
  guideline before the first `yaait:code` lands **in this same pass**, so no doctrine rule
  points at a command that does not exist.
- **Why:** both authors in the Clean Code debate are assertive where the honest answer is "it
  depends", and neither accounts for a senior's judgement or for project context. yaait
  should not resolve that by replacing two doctrines with a third: the person accountable for
  the codebase is the person who should pick, and yaait already has the machinery for asking
  and teaching. This is also what makes `yaait:code` usable in a codebase whose team already
  follows a house style — R-001's Q5.
- **Guard:** only rows where **both** stances survive the generated-code filter defer to the
  guideline. Rows where one side clearly loses — One Thing as a review test, method ordering
  as a defense, interface comments, deep versus shallow — stay settled in `review.md`.
  Without that line the guideline becomes a dump for everything `review.md` declined to
  answer, which relocates the vagueness instead of removing it and asks the user to decide at
  the moment they are least equipped.
- **Outcome:** the command exists, `CODING_GUIDELINE.md` has a documented format, and the
  methodology requires one before the first increment. Note this makes yaait **seven**
  commands, so the same pass updates `plugin.json`, `marketplace.json`, `CLAUDE.md`,
  `METHODOLOGY.md` §1's title and `README.md`.
- **Blocked-by:** —
- **Enables:** R-001

### R-009 — Apply REVIEW.md's findings to MANIFESTO.md

- **Category:** Doctrine
- **What:** `REVIEW.md` records 11 findings against `MANIFESTO.md` — five HARD, where both
  propositions cannot hold — plus a ranked table of places the document oversells. None of it
  has been applied. Work Part A first, then Part B; Part C lists the suspicions that did not
  survive checking and needs no action.
- **Why:** the manifesto is the document `README.md` advertises as "what yaait claims, in one
  page", so it is the version that gets linked and quoted alone. Its own audit found that the
  accountability clause's escape hatch is unreachable (A1), that Principle 8 is false as
  written (A2) and that Principle 4 is violated by construction (A3). A front door that
  contradicts itself is worse than a plain one.
- **Outcome:** every Part A finding is either applied or answered in writing, and the two
  changes the audit names as cheapest-and-highest-value are done: restore the one-line "not
  measured" declaration lost in commit `e35654f`, and add a fourth defense outcome —
  *attempted and wrong* → `DEBT`, not `APPROVAL`. Consequent edits reach `METHODOLOGY.md`
  §3, the shared rules block in all six skills, and `COMPARISON.md`'s "defended vs.
  undefended" line.
- **Blocked-by:** —
- **Enables:** —

## Next

### R-003 — Negative-control the discussion protocol

- **Category:** Validation
- **What:** Test that the skills agree quickly when the user is right. Propose several
  obviously-correct things and confirm the response is one sentence of agreement, not a
  manufactured challenge. Then propose genuinely bad things and confirm the challenge names
  failure mode, victim and cost.
- **Why:** Contrarianism on command is sycophancy with the sign flipped, and it is
  self-destroying — a user who learns to discount the objections has lost the one signal the
  whole method runs on. If this test fails, the discussion protocol is theater and every
  command inherits it. It is the highest-value test in the repo and it is not covered by any
  structural check.
- **Outcome:** A recorded pass, or a revision to the shared rules block in all six skills.
- **Blocked-by:** R-002
- **Enables:** —

### R-004 — Optimize the five skill descriptions for triggering

- **Category:** Packaging
- **What:** Run the skill-creator description optimizer, or `claude plugin eval`, over the
  five frontmatter descriptions with a realistic should-trigger / should-not-trigger set.
  Pay particular attention to `spec` versus `design` and to `code` versus plain coding
  requests.
- **Why:** The descriptions are the only mechanism that decides whether a skill is consulted,
  they were hand-written rather than measured, and Claude undertriggers skills by default.
  A methodology nobody invokes is not a methodology.
- **Outcome:** Descriptions replaced by measured ones, with the before/after scores recorded.
- **Blocked-by:** R-002
- **Enables:** —

### R-010 — A refactoring-patterns reference file

- **Category:** Doctrine
- **What:** The catalogue behind `METHODOLOGY.md` §7's rule that refactors are expressed as
  named refactorings, and behind `yaait:design` Step 4c. Same shape and altitude as
  `design/references/smells.md`: each entry names the refactoring, what shape it applies to,
  and — the part that carries the weight — the **behaviour-preservation contract** it
  guarantees, so that naming one is a claim the tests can check.
- **Why:** the rule ships without it, because the catalogue is common knowledge and the rule
  is actionable on its own. But "prefer a named refactoring" with no pinned vocabulary drifts
  into invented names, and an invented name carries no contract, which is exactly the
  property the rule exists to buy.
- **Outcome:** a reference file both `design` and `code` can read on demand. Must **not**
  settle how far to extract — that belongs to R-008's guideline.
- **Blocked-by:** —
- **Enables:** —
