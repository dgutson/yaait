# Roadmap

> Pending work only — finished items move to HISTORY.md.
> This is the durable record of what's outstanding. Read it instead of reconstructing
> the state of play from git history, old conversations, or a sweep of the code.
> Next thing to work on: the first item under the earliest horizon whose **Blocked-by**
> entries are no longer present in this file.

Format: 1
Next ID: R-019

---

## Now

### R-001 — Resolve yaait's position on Clean Code

- **Category:** Doctrine
- **What:** Hold a dedicated discussion on *Clean Code* and rewrite
  `skills/code/references/review.md` §5 into settled criteria. The five open questions are
  already written out in that file as the agenda: function size versus the structural smells;
  where the *why* lives if comments are held to be a failure; how many small classes is too
  many; which Clean Code prescriptions have any empirical support; and what `yaait:code` does
  in a codebase whose team already follows the book.
- **Why:** Several Clean Code prescriptions **contradict decisions yaait has already made**,
  so this cannot be settled in a paragraph. "Extract till you drop" and many-small-classes
  produce the Poltergeist, Middle Man and Lasagna shapes that
  `skills/design/references/smells.md` condemns. "Comments are a failure to express yourself
  in code" collides
  head-on with the comprehension gate: code can express *what* and *how*, never *why this
  and not the obvious alternative* — which is exactly what a defense asks for. Until this
  lands, `yaait:code`'s review criteria are marked provisional and the conflicts are
  unresolved in a file the user reads.
- **Outcome:** `review.md` §5 is replaced by settled criteria, the PROVISIONAL banner is
  removed, and any consequent change to `design/references/smells.md` or to `design`'s Step 4
  is made in the same pass.
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
- **Note:** as of 0.7.0 that record writes itself and needs no notes kept during the run —
  every `JOURNAL.md` entry names the gate that wrote it, and a gate recommended in `SPEC.md`'s
  `Gates recommended` section but never run produces a `DECISION` the next time `code` runs.
  What is still not captured is a gate abandoned **mid-flow**: it leaves a partial artifact and
  reads as having run, so watch for that case by hand and say so if it happens.
- **Progress:** `spec` has been run, on a multi-player naval battle game. It completed and
  produced the 0.9.0 revision — question routing and speech-act labelling, see HISTORY. Two
  things worth carrying into the remaining gates. The gate did **not** get abandoned; the
  friction was that the user could not tell what kind of answer each question wanted, which is
  a different failure from ceremony fatigue and would not have shown up in the invoked/skipped
  record this item was designed around. And the highest-value moment came from Step 5a
  (measurement settling an argument in one turn), which is worth watching for in `tech` Step 3a
  and `design`. Five gates remain: `design` and `tech` are both recommended in that project's
  spec and are the next to exercise.
- **Instrument:** `/yaait:feedback` was added in 0.9.0 to make the rest of this item cheaper —
  it captures friction per gate into `.yaait/FEEDBACK.md` so the record does not depend on
  anyone remembering to write a report afterwards. The `spec` pass had no such file; its
  evidence exists only as a transcript and a one-off report, which is why the phrasing
  complaint nearly went unrecorded. Run it after each gate from `design` onward.
- **Progress, `design`:** the gate ran on the same naval battle game and **completed**; it was
  not abandoned mid-flow. It produced five findings. That discharges this item's stated outcome
  of "at least one concrete revision to a SKILL.md driven by it": four of the five are applied —
  the map drawn before the parts are discussed, the parts hierarchy, the decisions section and
  the template gaps, all released as 0.11.0 — and the fifth, the unparseable defense ask, in
  0.12.0. Four gates remain: `tech`, `code`, `stest`, `debt`. **The `design` re-run has not happened**, and
  when it does it needs a copy of the project: the gate rewrites `.yaait/DESIGN.md` and appends
  to `JOURNAL.md`, which is the evidence those four fixes rest on.
- **Open question to record:** was `/yaait:feedback` run after the `design` gate? The friction
  arrived as chat and a screenshot, not as a file. Note also that four of the five complaints
  are about the **artifact** rather than about the gate's conduct, and `feedback` is shaped to
  capture the latter. If that is why it went uncaptured, the instrument needs widening.
- **The version under test is not observable from the tool, and this cost real time.**
  `installed_plugins.json` reported 0.3.0 while the run was demonstrably at or after 0.9.0 — a
  local-directory marketplace resolves live from the clone, and that record only updates on an
  explicit `install`. The version had to be recovered from the artifacts themselves. Every
  future dogfood run must therefore record the **commit sha of the clone at run time**, in
  `FEEDBACK.md` or the journal; without it a finding cannot be attributed to a version. It also
  means every run silently uses HEAD, including unreleased commits.
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

### R-007 — `:learn`, a command for the concepts this project keeps demanding

- **Category:** Doctrine
- **What:** A seventh command that reads `JOURNAL.md`'s `TAUGHT` and `DEBT` entries across the
  whole project and answers what no single increment can: which concepts have recurred, and
  which of them this project requires the user to actually know rather than have re-explained.
  Runs the sweep in a subagent, as `:debt` does, so the full history does not land in the
  conversation.
- **Why:** the teaching loop sits inside the development flow deliberately — learning at the
  point of need, which is the only kind most people get time for. Its blind spot is that a
  junior can be taught the same concept fifteen times across fifteen increments and nobody
  notices there is no progression, which turns the educational principle from an investment
  into a treadmill. The complementary need is the opposite of on-the-go: a calm later moment
  to learn something properly, with the subject chosen by what the project actually demands
  rather than by a curriculum. A concurrency-heavy project needs its maintainer to know
  concurrency, and the journal is the only place that fact is visible.
- **Outcome:** `/yaait:learn` exists and reports, for a given scope: concepts taught more than
  once, concepts left undefended more than once, and the recurrence that has crossed from
  "explain it again" into "this project requires this skill". Escalation mirrors `:debt`'s — a
  recurrent item stops being an incident and becomes a standing finding.
- **Notes:** the `TAUGHT` entry type this reads was added on 2026-08-24; journals written
  before that carry no teaching record, so the command must state its window rather than
  report silence as absence. Making this the seventh command touches the "six commands"
  identity claim in `README.md`, `.claude-plugin/plugin.json` and `marketplace.json`, and
  needs a version bump.
- **Blocked-by:** —
- **Enables:** —

### R-008 — Two guideline commands: `:design-guideline` and `:coding-guideline`

- **Category:** Commands
- **What:** two commands that write the standing-decision files `METHODOLOGY.md` §12 already
  specifies: `DESIGN_GUIDELINE.md` (standing structural decisions) and `CODING_GUIDELINE.md`
  (house style, settling the questions the review criteria deliberately leave open). Both do
  the same two things in the same order — **program understanding first, user survey second**.
  Each reads the existing code, the project's standing-instruction file and any style document
  already in the repo, and only then asks; §12 makes the ordering a rule because a survey that
  opens with questions asks the user to invent answers the codebase has already given. Both
  ask rather than decide, and leave an explanation space where the user does not know.
  `CODING_GUIDELINE.md` settles the rows of the Clean Code/APOSD evidence file where both
  stances survive both filters — contemporary practice *and* generated code — plus the
  baseline items that need deciding once (duplication and DRY; information leakage, e.g. a
  helper used by exactly one caller belonging inside it).
- **Why:** both authors in the Clean Code debate are assertive where the honest answer is "it
  depends", and neither accounts for a senior's judgement or for project context. yaait should
  not resolve that by replacing two doctrines with a third: the person accountable for the
  codebase is the person who should pick, and yaait already has the machinery for asking and
  teaching. This is also what makes `yaait:code` usable in a codebase whose team already
  follows a house style — R-001's Q5. `METHODOLOGY.md` §12 already carries the precedence,
  promotion and reconcile rules, and `design`/`code` Step 0 already read both files where they
  exist; what is missing is anything that writes one.
- **Guard — the vagueness must not simply relocate:** only rows where **both** stances survive
  the generated-code filter defer to the guideline. Rows where one side clearly loses — One
  Thing as a review test, method ordering as a defense, interface comments, deep versus
  shallow — stay settled in the review criteria. Without that line the guideline becomes a dump
  for everything the criteria declined to answer, which asks the user to decide at the moment
  they are least equipped. §12 states this; the commands must not undercut it.
- **Guard — do not build a fourth code reader.** These two, R-006's survey command and §7's
  code map all read the same codebase for overlapping reasons. Settle the shared input before
  writing the second one.
- **Outcome:** both commands exist, both files have a documented format, and the methodology
  rule requiring a settled guideline before the first increment lands **in this same pass** —
  §12 deliberately omits it so that no doctrine rule points at a command that does not exist.
  Note this makes yaait **eight** commands, so the same pass updates `plugin.json`,
  `marketplace.json`, `CLAUDE.md`, `METHODOLOGY.md` §1's title and table, and `README.md`.
- **Blocked-by:** —
- **Enables:** R-001

### R-011 — Translate the reference material out of OO-only vocabulary

- **Category:** Doctrine
- **What:** `METHODOLOGY.md` §11 now declares the method paradigm-neutral, says the catalogues
  speak OO as a dialect, and states that the translation **has not been done**. Do it. The
  specific hard cases, all verified: `mermaid.md:12` is the only unconditional artifact
  requirement in the repo ("**Always:** a class diagram") and there is no non-OO structural
  template anywhere — `flowchart` over modules or translation units is the obvious missing one;
  `smells.md` §9 already holds non-OO mappings but sits ninth of eleven, after all the
  OO-worded material, and omits Polymorphism, Creator, Controller, Pure Fabrication and every
  §7 tell; `review.md` has **no** non-OO section at all despite running on every increment
  while `smells.md` runs once per design; the `Manager`-with-no-data tell (`smells.md:293`,
  ranked third-most-reliable) is undecidable in C, where a stateless `.c` file is normal and
  healthy; and pattern-name-driven design is detected by counting "three or more named GoF
  patterns", which cannot fire in C even though the failure it guards against exists there as
  a vtable of one and a registration macro nobody registers with. Error masking's C shape — an
  ignored return code — is absent from the most-measured check in the method.
- **Why:** yaait should work on the Linux kernel. Right now a C project hits a mandatory class
  diagram in Step 5 and a review that reports clean because half its detectors are structurally
  incapable of firing. That second one is the real damage: a detector that cannot fire is not a
  pass, but it reports as one, which is worse than having no detector at all.
- **Outcome:** every rule in the reference files either restates in the project's own units or
  says explicitly that it does not apply. No detector reports a result it cannot compute.
- **A concrete instance from the first `design` dogfood, and it is now fixed:** the generated
  `DESIGN.md` modelled a pure function as `class view_for` inside a `classDiagram`, because the
  class diagram was the only structural template that existed. The notation asserted something
  the design explicitly denies — the file says "a function rather than a class because it holds
  no state".
- **Progress, 0.12.0 — the diagram half is done.** `mermaid.md:12`'s unconditional "**Always:**
  a class diagram" is now "a **structure diagram**", whose form follows the units the code
  actually has, and a `flowchart`-over-modules template is documented beside the class diagram
  and checked against mermaid 11.17.2. `design` Step 1c and Step 5 say the same, and
  `METHODOLOGY.md` §11 records what is left. **What remains is the whole detector half**, which
  is the more damaging one: `smells.md` §9's missing mappings — Polymorphism, Creator,
  Controller, Pure Fabrication and every §7 tell; `review.md` having no non-OO section at all
  despite running on every increment; the `Manager`-with-no-data tell being undecidable in C;
  pattern-name-driven design detected by counting GoF names, which cannot fire in C; and error
  masking's C shape, an ignored return code, missing from the most-measured check in the method.
- **Blocked-by:** —
- **Enables:** —

### R-009 — Apply REVIEW.md's findings to MANIFESTO.md

- **Category:** Doctrine
- **What:** `REVIEW.md` records 11 findings against `MANIFESTO.md` — five HARD, where both
  propositions cannot hold — plus a ranked table of places the document oversells. **A1, A2 and
  A3 are applied, A8 is resolved, and A11 is half applied** — read `REVIEW.md`'s header and its
  per-finding markers before starting, rather than reworking what is already done. A11's
  remaining halves are the `MANIFESTO.md:72` versus `:84-89` contradiction and the fact that
  `code` never asks whether yaait applies at all. Work Part A first, then Part B; Part C lists
  the suspicions that did not survive checking and needs no action.
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

### R-012 — The independent check on a diff, and what "needless verbosity" is

- **Category:** Doctrine
- **What:** run the arrangement `design` Step 7a now uses — a subagent that has not seen the
  conversation, findings shown unfiltered, caller rebuts but cannot suppress — against a
  `yaait:code` increment's diff, and write the one criterion that does not exist yet. The
  observable form of verbosity is **constructive**: the checker produces the same behaviour in
  materially less code, and *that rewrite is the finding*. An objection it cannot express as a
  shorter version passing the increment's tests is taste, and is not reported.
- **Why:** the design-level check catches structure invented before code exists. It cannot
  catch the forty-line function where twelve lines do the work, because a design has no code.
  That is the failure users actually meet: the long function that gets acknowledged as too
  long and rewritten far shorter the moment somebody comments on it — meaning the shorter
  version was reachable all along and nothing in the method was going to ask for it.
- **Guard — this check will fire every time if built naively.** An LLM can always produce a
  shorter version of any code. The tests-must-pass condition and a named category for what was
  removed (dead branch, restated condition, wrapper with one caller) are what separate a
  finding from golf. Without them the user learns to discount it, which costs more than the
  verbosity did.
- **Guard — it must not settle how far to extract.** `METHODOLOGY.md` §12 reserves that for
  `CODING_GUIDELINE.md`, and this criterion sits one inch from it.
- **Outcome:** `yaait:code` runs an independent check on the increment, and `review.md` carries
  a verbosity criterion stated as a falsifiable property rather than a preference.
- **Blocked-by:** R-001
- **Enables:** —

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
- **Note:** unblocked ahead of R-002 finishing. R-002 gated this on having real usage, and the
  `spec` pass supplied it without the other five gates: the protocol produced one challenge
  that was measured and won, and one **defeated on its premises** — the objection asserted
  who the harm fell on, and the user's values were the opposite. 0.9.0 added the rule that "who
  it hurts" is not the gate's to assert, which makes this test more urgent rather than less,
  because that rule is now the thing under test.
- **Blocked-by:** —
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

### R-013 — Why artifact formats drift, and what to do about it

- **Category:** Doctrine
- **What:** Every yaait artifact that carries a `Format:` line is in scope: `SPEC.md`,
  `DESIGN.md`, `TECH.md`, `TECH_DEBT.md`, `EXPERIMENTS.md`, `FEEDBACK.md`, and `JOURNAL.md`'s
  entry types. Establish why written artifacts diverge from their specified format, test the
  cheap fix below, and only then decide whether anything needs checking mechanically.
- **Why:** the first dogfood produced **two different failures**, in one session, with
  `METHODOLOGY.md` available throughout.
  - **Drift** — `SPEC.md` followed its format and then extended it: an invented `[defended]`
    tag, an `[OPEN]` status, four new bullet keys and a second `Acceptance` line.
    Recognisably a spec, quietly non-conforming.
  - **Non-adoption** — `EXPERIMENTS.md` never used the format at all. No `Format:` line, no
    experiment ID, none of §8's fields; free prose under a date heading. Nothing could cite
    the entry, because it had nothing to cite.
  These need different fixes, and a validator addresses only the first.
- **The hypothesis, and it is testable:** an artifact whose template is **inline in the skill
  that writes it** comes out recognisable; an artifact whose template lives **only in
  `METHODOLOGY.md` §8** gets invented. `SPEC.md`, `DESIGN.md`, `TECH.md`, `JOURNAL.md` and
  `FEEDBACK.md` all have inline templates and all came out usable. Exactly two artifacts do not
  — `TECH_DEBT.md` and `EXPERIMENTS.md` — and `EXPERIMENTS.md` is the one that came out
  formatless. `spec` Step 5a says only "record it in `EXPERIMENTS.md` labelled `measured`" and
  never shows the shape.
- **The prediction that would falsify it:** `TECH_DEBT.md` is the remaining untested case. If
  the hypothesis holds, the first `yaait:code` receipt filed against it will also come out
  formatless. If it comes out conforming, the hypothesis is wrong and the cause is elsewhere.
  Watch for it rather than fixing it pre-emptively; it is a free experiment that runs itself.
- **Outcome:** either the cheap fix lands and is shown to work — inline the two missing
  templates at the point of writing, so no step asks the model to recall a format it was never
  shown — or the prediction fails and this becomes a real investigation. A mechanical check is
  the last resort, not the first, and only for drift.
- **Note:** having the gate validate its own output is not the answer — that is the model
  grading its own homework, the pattern `METHODOLOGY.md` §13 rejects. The same argument says
  a grammar written into the SKILL.md is just more prose to follow, so if the answer does turn
  out to be a check, it probably is not prose.
- **New evidence, and it must not be miscounted.** The first `design` dogfood produced a
  `DESIGN.md` carrying two sections the template does not define: `## Phases` and
  `## Protocol shape`. This is **not** evidence for the drift hypothesis. `DESIGN.md` has an
  inline template and followed it; the template has no slot for a state diagram that
  `mermaid.md` separately mandates, so the author had nowhere else to put it. That is an
  internal contradiction in the plugin, not an author inventing format, and 0.11.0 fixed it by
  giving the template a state-diagram slot and a protocol slot.
  The `TECH_DEBT.md` prediction above remains the untested case.
- **Blocked-by:** —
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
- **Constraint:** paradigm-neutral from the start, per `METHODOLOGY.md` §11. Two of the five
  names currently listed in `yaait:design` Step 4c — Move Method, Replace Conditional with
  Polymorphism — have no C form, and while R-010 is unwritten those five *are* the vocabulary.
  A catalogue that names only OO refactorings makes §7's rule unfollowable in a C project,
  which pushes it toward exactly the invented names the rule exists to prevent.
- **Outcome:** a reference file both `design` and `code` can read on demand. Must **not**
  settle how far to extract — that belongs to R-008's guideline.
- **Blocked-by:** —
- **Enables:** —
