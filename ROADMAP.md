# Roadmap

> Pending work only — finished items move to HISTORY.md.
> This is the durable record of what's outstanding. Read it instead of reconstructing
> the state of play from git history, old conversations, or a sweep of the code.
> Next thing to work on: the first item under the earliest horizon whose **Blocked-by**
> entries are no longer present in this file.

Format: 1
Next ID: R-008

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
- **Blocked-by:** —
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
  `Deliberate? No` and `containment: spread` honestly.
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
