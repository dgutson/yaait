# Roadmap

> Pending work only — finished items move to HISTORY.md.
> This is the durable record of what's outstanding. Read it instead of reconstructing
> the state of play from git history, old conversations, or a sweep of the code.
> Next thing to work on: the first item under the earliest horizon whose **Blocked-by**
> entries are no longer present in this file.

Format: 1
Next ID: R-033

---

## Now

### R-032 — `Explain <concept>` loses its slot to fork branches, and the doctrine never says which yields

- **Category:** Doctrine
- **What:** Step 6 says **"Offer to teach the underlying concepts, by name, at every stop"** and
  lists `Explain <concept>` as an option that is *"**not** a way out"*. It also says *"where the
  stop has a real fork, the branches of that fork **are** the options"*. A picker holds four
  options. When a stop has three branches, or two branches plus `Show me what it costs`, those
  two rules compete for the same slots and nothing in the shared block says which one gives way.
  Decide, and write the resolution into all six gates.
- **Why:** measured, not argued. In the first interactive run of the 0.20.1 review round
  (`experiments/R-032-review-round-render/`), **four of eight stops offered no `Explain` option
  at all** — `workers` and `X-002`, in both picker calls, reproducibly. The concepts were there
  to name: loopback versus LAN, worker processes not sharing memory, `WEB_CONCURRENCY`. The
  slots went to fork branches and to a measurement-routing option instead.
- **Why it matters more than a missing option:** the thing that gets dropped is the one the
  doctrine calls *half of what the walk-through is for*, and the one whose entire purpose is
  that choosing it costs nothing while typing *"I don't know what that means"* is a confession
  in writing. A user who cannot see `Explain loopback` and does not want to admit that has one
  remaining exit: accept what was written. That is the failure the 0.20.0 rewrite exists to
  prevent, arriving through the instrument rather than through the wording.
- **The argument to have before editing anything:** it may be right that a real fork outranks a
  teaching offer — a user who understands the fork does not need the concept named. But that has
  to be decided rather than left to whichever rule the model happens to satisfy first, because
  the observed behaviour is that `Explain` is always what goes. Note also that
  `Show me what it costs` appeared on fork stops although the block lists it under the forkless
  case, so the two option sets are already being mixed in practice.
- **Outcome:** either a stated precedence in the shared block (with the failure mode named), or
  a mechanism that keeps the teaching offer without spending a slot — naming the concepts in the
  stop's prose is already required, so the option may be redundant, and that is a legitimate
  answer if it is written down.
- **Blocked-by:** —
- **Enables:** —

### R-028 — The independent checker is never given `TECH.md`

- **Category:** Doctrine
- **What:** `design` Step 7a spawns the independent checker with `DESIGN.md`, `SPEC.md`,
  `TECH_DEBT.md` and `DESIGN_GUIDELINE.md`. Not `TECH.md`. Decide whether it belongs in that
  list, and if so add it in both `design` Step 7a and `references/independent-check.md`'s
  **What the checker receives**.
- **Why:** every artifact on that list is there to prevent a false positive — `TECH_DEBT.md`
  specifically so a boxed shortcut is not flagged on every run for as long as it exists. A
  structural element that exists *because* the stack requires it — an adapter around a chosen
  transport, a serialization boundary — has its justification in `TECH.md` and nowhere in
  `DESIGN.md`, so a checker denied it flags the same element every run. The gap predates the
  reorder, since `tech` could always run first; what changed is that `TECH.md` is now present
  on every greenfield design, so an occasional false finding became a systematic one.
- **The argument to have before editing anything:** the brief says *"Nothing else. No
  conversation, no summary of what the user asked for"* because each of those carries the
  author's reasoning, which is the thing under examination. `TECH.md` is a separate gate's
  artifact, like `SPEC.md` — but that is an argument to be made, not assumed. There is also an
  altitude question, the same one that applies to `smells.md`: a cross-artifact consistency
  check is not a property of a dependency graph.
- **Outcome:** either `TECH.md` is in the checker's inputs with the reasoning recorded, or a
  decision that it must not be, naming what the checker is supposed to do with a stack-required
  element instead.
- **Severity while it stands:** Step 7a's rebuttal mechanism absorbs it — the author holds what
  the checker was denied — so the cost is noise on every design run, not a wrong design.
- **Blocked-by:** —
- **Enables:** —

### R-027 — Run the naval TTB under the new gate order, and grade the out-of-order design

- **Category:** Validation
- **What:** `tech` now runs before `design`, and `design` stops without a `TECH.md`. Exercise
  that on the naval battle game, in a **fresh session and a separate directory**: run
  `/yaait:tech` with an assertive stated stack, then `/yaait:design`, and compare the result
  against `DESIGN-naval.md` — which was produced under the old order and is therefore the
  control, not a clean artifact. Specifically: do the four Step 1d branch points come out
  differently once the stack is known, and does `TECH.md` end up with a non-empty
  `## Deferred to design`?
- **Why:** the reorder shipped **argued, not measured**. The case is strong — `design`'s own
  Step 1d names four expensive-to-reverse decisions the stack largely settles — but the only
  evidence is a reading of the skills, and this repo has already had a rule re-derived wrong
  twice from a reading. The naval game is the one TTB with a `DESIGN.md` written before its own
  tech gate, so it is the only before/after that exists.
- **Outcome:** either a recorded difference the reorder caused, or a finding that it changed
  nothing — which is evidence against it and should be treated as such rather than explained
  away.
- **Watch for:** the failure mode this order introduces — a stack choice arriving in
  `DESIGN.md` as an apparent inevitability rather than a decision with a falsifier. A design
  that never questions anything in `TECH.md` is showing the symptom, not succeeding.
- **Also watch:** whether Step 2's survey turns into the wall of text that gets a gate
  abandoned. It is the most expensive step added, and ceremony fatigue is the stated failure
  mode of the whole method.
- **Blocked-by:** —
- **Enables:** R-002

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
- **Order note (2026-08-30):** `design` ran on the naval game *before* `tech`, which is no
  longer the order the method specifies. `DESIGN-naval.md` is therefore a control for R-027
  rather than a clean dogfood artifact — its four branch points were settled against a stack
  nobody had named, and the design emits two constraints back onto `tech` (the shared placement
  rule at line 26, serialization and transport at line 331) that under the new order would have
  had a named place to land. Read it as evidence, not as an example.
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
- **The version under test is not observable from the obvious place, and now the mechanism is
  confirmed rather than inferred.** `installed_plugins.json` is stale bookkeeping and so is the
  version-numbered copy under `~/.claude/plugins/cache/`: on the dogfood machine both said 0.7.0
  at commit `374c2b8`, complete with a matching snapshot on disk. Neither is what ran.
  `known_marketplaces.json` records the marketplace `source` as `directory` with
  `installLocation` pointing at the **clone**, and a probe run confirmed the CLI reads the
  working tree — it reported a step heading that exists only on the branch checked out there. So:
  read `known_marketplaces.json`, not `installed_plugins.json`; every run silently uses whatever
  the clone's HEAD is, including unreleased and uncommitted work; and the **commit sha of the
  clone at run time** is the only thing worth recording, in `FEEDBACK.md` or the journal. The
  first `design` dogfood therefore ran at `5353329`, which the earlier artifact forensics had
  guessed correctly as "at or after 0.9.0".
- **Progress, reading the `design` output rather than running the gate.** A second pass over the
  produced `DESIGN.md` found four more problems, and the source matters: none of them came from
  the gate misbehaving in the conversation, so none would have been caught by `feedback`, which is
  shaped for conduct. **Two are fixed** in 0.14.0 — a structure diagram that parses and does not
  render, and players drawn two different ways in one sequence diagram. **Two are filed**, as R-021
  and the far half of R-020. This strengthens the open question above: the complaints this dogfood
  generates are overwhelmingly about the **artifact**, and the instrument built to catch them
  watches the wrong surface.
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
- **Now tractable, and more urgent (2026-08-30):** `tech` runs before `design`, so `TECH.md`
  names the language and paradigm *before* any catalogue is applied. The translation §11 asks
  for stopped being hypothetical — the gate can read the target dialect off an upstream artifact
  instead of inferring it. That also raises the cost of not doing it: the reorder was justified
  partly on §11, so leaving the catalogues OO-only means it bought less than it claimed.
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
- **Progress, 0.13.0 — the mixed case, found by testing 0.12.0 rather than by reading it.** The
  0.12.0 slice below only covered designs where *nothing* is a class. Re-running `design` on the
  naval project still emitted `class view_for`, because that design is mixed — five classes plus
  one module and one free function — so a `classDiagram` was the correct choice and the notation
  still had no way to say "not a class". Fixed with stereotype annotations, `<<module>>` and
  `<<function>>`, verified inside a `namespace` against mermaid 11.17.2. The lesson worth keeping
  is that the first fix addressed the paradigm of the *project* when the defect was a property of
  the *unit*.
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
- **Outcome:** every Part A finding is either applied or answered in writing, and the cheapest
  and highest-value change the audit names is done: restore the one-line "not measured"
  declaration lost in commit `e35654f`.
- **Superseded in part by 0.20.0.** This item also asked for a fourth defense outcome,
  *attempted and wrong* → `DEBT` rather than `APPROVAL`. 0.20.0 deleted that whole outcome
  instead, because writing a person's wrong answer into the project journal is a record about
  a person in a file about code, and because the mechanism did not detect what it claimed to.
  Do not reinstate it. A1 and A3, which that change was serving, were addressed by the same
  release: the accountability clause now states the condition the human must be in rather than
  a test a machine runs, and Principle 4 is worded against the record rather than against the
  reader. What remains open here is the rest of Part A and all of Part B.
- **Blocked-by:** —
- **Enables:** —

### R-020 — Vocabulary continuity: a design uses the words the spec used

- **Category:** Doctrine
- **What, and the near half is done — this item is now the far half only:** whether yaait grows a
  `GLOSSARY.md`, which gate writes it, which gates read it, and whether it is a file in `.yaait/`
  or a section of `SPEC.md`. The staging was the point: what the naming rule does *not* fix is
  exactly what a glossary would have to carry, and that was not knowable before the rule existed.
- **Why, and the evidence splits cleanly in two.** Reading the naval `DESIGN.md`, the user could
  not tell what `code` meant in `MatchRegistry.find(code)` and `-by_code` — he worked it out after
  several passes — and still cannot say what `Match.-phase` is. These are **different failures**
  with different fixes, which is the whole reason for staging:
  - `join code` **is defined in `SPEC.md` S-002**, with an acceptance criterion. The design
    dropped the qualifier. A glossary would have held the term and the design would still have
    written `find(code)`, so the glossary does not fix this one; the naming rule does.
  - `phase` is the opposite: a term of art the **design coined**, first used in the structure
    diagram and not defined until the state diagram some 240 lines later. Nothing upstream could
    have carried it, so the naming rule only half fixes this one; a glossary or a
    define-at-first-use rule is what closes it.
- **The cost of the far half, so it is not discovered halfway in:** a seventh artifact touches the
  `## Where things go` block — which is inside the byte-identical shared rules block in **all six**
  gates — plus `METHODOLOGY.md` §8 and Step 0 of every gate. And that block's own rule is that each
  file is created by whichever gate first has content for it, because a file created before it has
  content is worse than absent: a later gate cannot tell "nothing to record" from "nobody looked".
  A `GLOSSARY.md` mandated at `spec` time is a candidate for precisely that failure. This is an
  argument to answer, not a reason to skip the far half.
- **Progress, 0.15.0 — the near half landed.** `design` Step 2 now carries both rules: a term
  `SPEC.md` defines keeps the spec's name (`find(join_code)`, never `find(code)`), and a term the
  design coins is defined by the component that owns it, on the `Owns:` line, which moves `phase`'s
  range from the state diagram to the section immediately after the map. The `DESIGN.md` template's
  `Owns:` placeholder says so inline rather than leaving it to Step 2's prose — R-013's own
  hypothesis is that a template inline at the point of writing gets followed and a format recalled
  from elsewhere gets invented, so this applies that finding rather than re-testing it.
  `mermaid.md`'s conventions carry the short form, because the diagram is where the abbreviation
  actually happened. **What is still open is only the glossary question.**
- **Measured 2026-08-28, and half the near half does not work.** Three runs of the gate on the
  naval project, checked mechanically. The *spec's-word* rule half fired on Opus — `find(join_code)`
  landed, `-by_code` leaked on the same class — and did not fire at all on Sonnet. The
  *coined-term-states-its-range* rule was recorded as failing in all three, Opus included.

  **That record was wrong, and the error is now located.** Re-graded 2026-08-28 with a check that
  reads the document whitespace-collapsed instead of line by line, `mnb-opus/DESIGN.md` line 194
  says: *"**Owns:** the `phase`, a term this design coins, ranging over `WAITING`, `PLACEMENT`,
  `FIRING` and `ENDED`"*. That is a pass. The statement wrapped across two source lines, and a
  per-line window could not see it. The corrected record is **Opus 4 of 4, everything else 0 of 2**
  — the rule has never failed on Opus. The same re-grade reproduces every *other* recorded result
  for that same file exactly (namespace PASS, participant PASS, five `join_code` uses with a
  `-by_code` leak, six semicolons, 0 of 3 rendering), so it is one wrong cell, not a new method.
  **This rule is not broken and never was**; 0.16.0's decision to leave it alone was right for the
  wrong reason.

  **A fourth run on 2026-08-28 passed both, and that changes what this item is about.** 0.16.0's
  spec's-word tightening is now verified: the design wrote `-by_join_code` on a **private** field
  with `find(join_code)` beside it. The coined-term rule passed as well — `Owns: the phase, one of
  WAITING, PLACEMENT, FIRING, ENDED` — and **nothing in 0.16.0 touched that rule**, which had been
  left alone precisely on the argument that three failures meant the mechanism was wrong. So it is
  3 of 4, not 3 of 3, and one clean pass with no rule change looks like variance rather than a
  mechanism that cannot work. **Re-measure before rethinking where the definition belongs** — a
  `GLOSSARY.md` specified to repair a rule that already works is the wrong artifact built for the
  wrong reason. Caveat on the fourth run: n=1, and it is not a clean experiment, since the same
  run also carried 0.17.0's diagram check.
- **Outcome:** either `GLOSSARY.md` is specified and added everywhere it has to be, or this file
  records why not.
- **Blocked-by:** —
- **Enables:** —

## Next

### R-030 — `tech` Step 0 misses the second-pass case the reorder itself creates

- **Category:** Doctrine
- **What:** `tech` Step 0 says that a `DESIGN.md` on disk means this is a second pass, and
  names three causes: the design fired a falsifier, the design settled a `## Deferred to
  design` slot, or the TTB is Maintenance. There is a fourth — a greenfield design written
  under the pre-0.19.0 order, where no `TECH.md` ever existed to fire a falsifier on or defer
  anything to. Add it, and say what the gate does there.
- **Why:** it is the exact state of every project that used yaait before 0.19.0 and now runs
  `tech` for the first time. The gate will assert one of three things, all false, and the run
  starts on a mis-description of what it is doing. Found by simulating `tech` on a real design
  in the session that shipped the reorder.
- **Outcome:** Step 0 names the case and says what to do — most likely: read the design as the
  stack requirement it is, since a design written without a `TECH.md` has its constraints on
  the stack loose in its component prose rather than in a section.
- **Blocked-by:** —
- **Enables:** —

### R-031 — the proficiency scale cannot express a scoped gap

- **Category:** Doctrine
- **What:** `tech` Step 1a grades each ecosystem **expert / proficient / novice**. Real answers
  are not one-dimensional: "expert in C++, contributed to WG21, disconnected from C++23 onward"
  and "proficient in Python, strong on the type system, no asyncio" both collapse to a single
  word that loses the only part that matters. Let the `Level` cell carry a scope, and say so in
  the prose.
- **Why:** `## Proficiency` exists so that whoever reads a run of `DEBT` entries six months
  later can interpret them. A row saying "C++: expert" beside a journal full of ranges and
  coroutine entries misleads that reader in the exact way the section was added to prevent.
- **Severity:** low. The template's `Level` cell is free text, so a run will usually write the
  scoped form anyway — this is prose catching up with what the artifact already permits.
- **Blocked-by:** —
- **Enables:** —

### R-029 — `spec`'s design criterion is a component count that `tech` can change

- **Category:** Doctrine
- **What:** `spec` Step 10 recommends `design` against criteria, the first being "more than
  about three components that interact". `tech` now runs between `spec` and `design`, and the
  stack can move that count — a serverless target or a chosen orchestrator can turn a
  three-component TTB into a one-module one, or the reverse. Decide what Step 10 does about it:
  recommend `design` conditionally pending the tech answer, defer the design recommendation to
  the close of `tech`, or leave the criterion alone because the count is stable enough in
  practice.
- **Why:** `spec` now recommends both gates before either has run, and one of them changes the
  input to the other's criterion. A design recommendation the next gate invalidates leaves
  `SPEC.md`'s `Gates recommended` section asserting something untrue — and `code` Step 0 reads
  that section to decide whether a gate was skipped, so a stale recommendation there produces a
  false skip report in a place built specifically to be trustworthy.
- **Outcome:** Step 10's handling of the interaction is decided and written, or a recorded
  decision that no change is needed, with the reason.
- **Blocked-by:** —
- **Enables:** —

### R-026 — A second TTB overwrites the first one's artifacts

- **Category:** Method
- **What:** Give each TTB its own `SPEC.md`, `DESIGN.md` and `TECH.md` in a subdirectory of
  `.yaait/` named from the spec, and teach every gate's Step 0 which one to read. Leave
  `JOURNAL.md`, `TECH_DEBT.md` and `EXPERIMENTS.md` where they are, at project scope.
- **Why:** `METHODOLOGY.md` §8 draws one flat `.yaait/` holding exactly one of each artifact,
  and `HISTORY.md` already records that **every change after the first is a Maintenance TTB**.
  So the second `/yaait:spec` in a project silently overwrites the greenfield spec — the one
  document recording which requirements were stated and which the model invented. Nothing warns
  anyone, and the loss is invisible until someone goes looking for a requirement that used to
  be there. This is not the brownfield on-ramp (R-006): that command *analyses* an existing
  codebase, this is about a project that has already run yaait once and is running it again.
- **The split is the part to get right, and getting it wrong is worse than the bug.** Per-TTB:
  `SPEC.md`, `DESIGN.md`, `TECH.md`. Project-wide and never fragmented: `JOURNAL.md`,
  `TECH_DEBT.md`, `EXPERIMENTS.md`. The journal is append-only and is the record the whole
  method runs on; splitting it per session destroys the cross-TTB reading §8 says `TAUGHT` and
  `DEBT` exist to support — which concepts a project keeps demanding is a question you can only
  answer by reading across TTBs.
- **Open, and to be settled by the work rather than assumed now:** what the greenfield
  artifacts become once TTB #2 exists — moved into a subdirectory of their own, or left in
  place as the root the others inherit from — and how `Step 0 — Read the upstream artifacts`
  picks which `SPEC.md` it is reading. Name the subdirectory from the spec, not from a session
  id: a directory listing should say what the work was.
- **Outcome:** running `/yaait:spec` twice in one project leaves both specs readable, and every
  gate reads the right one without being told.
- **Blocked-by:** —
- **Enables:** —


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

### R-024 — The absent-tool path in `design` Step 7b has never run

- **Category:** Validation
- **What:** run `design` on a machine with no `mmdc` and confirm the step does what it now says —
  names the install, records in `DESIGN.md` that the diagrams were not machine-checked, closes
  without stalling, and **installs nothing**.
- **Why, and this is observed rather than feared.** The 2026-08-28 run was meant to exercise
  exactly this: the box had no `mmdc`. The gate did not take the path. It created `/tmp/mnb-mmdc`,
  ran `npm i @mermaid-js/mermaid-cli`, used `./node_modules/.bin/mmdc` and reported the check as
  passing. Nobody had agreed to put those packages on that disk, and the branch the doctrine
  documents went untested while looking like it had been tested.
- **What changed since:** 0.17.0 forbids self-installing, in Step 7b and in `mermaid.md`, naming
  the observed case. **That prohibition is itself unverified** — it is prose aimed at a model that
  already improvised around the same step once.
- **How to run it so it is a real test:** a machine or container with `node` present and no
  `mermaid-cli` anywhere on it, because `npx` alone is enough for the gate to route around the
  absence. **The 192.168.68.71 box is no longer that machine** — `mmdc` 11.16.0 was installed
  there permanently on 2026-08-28 at `/home/dfg/.local/bin/mmdc`.
- **Outcome:** the absent-tool path is confirmed, or Step 7b needs something stronger than a
  prohibition.
- **Blocked-by:** —
- **Enables:** —

### R-023 — One place that installs what yaait can use

- **Category:** Tooling
- **What:** a script and/or a skill that knows which external tools yaait's gates can use, reports
  which are present, and installs the missing ones. `mmdc` is the first; it will not be the last.
- **Why:** `design` Step 7b now carries an install line in its prose. The second gate that wants a
  tool will carry its own, the two will drift, and a user with none of them installed has no single
  place to look. An optional dependency explained inline is re-explained everywhere and maintained
  nowhere.
- **The question it must answer rather than skip:** whether this is a seventh skill, a script the
  skills call, or a documented one-liner in the README. yaait is prose all the way down today, and
  shipping an executable is a change to what the plugin *is* — decide it deliberately, in writing,
  not by adding a file.
- **Outcome:** a user runs one thing and the gates stop carrying install instructions; or this file
  records why a one-liner in the README was enough.
- **Blocked-by:** —
- **Enables:** —

### R-021 — Why no `## Decisions` entry ever names a pattern

- **Category:** Validation
- **What:** establish the cause before choosing a fix. `DESIGN.md`'s `## Decisions` section asks
  for three kinds of entry — patterns **adopted**, patterns **resembled and deliberately not
  used**, and plain structural choices carrying no pattern name. The naval re-run produced eight
  entries, all of the third kind, and none of the first two.
- **The evidence, and it is a real decision that went unrecorded:** `Match` holds a `-phase` field
  and an `apply(seat, command)` that dispatches on it, with a four-state lifecycle drawn as a
  `stateDiagram-v2`. That is a finite state machine chosen over the State pattern — a genuine fork
  with a genuine alternative — and nothing in the artifact says it was chosen. The eight entries
  that did appear are the shared placement rule, the shot allowance, reversible placement, no rule
  for a stalled turn, the drop-during-placement behaviour, snapshots over events, the two board
  projections, and `fits` taking no size argument.
- **The leading hypothesis, testable and cheap to discard:** Step 7 says the section is written
  **retrospectively, from the decisions actually disclosed during the gate**, and the disclosure
  machinery belongs to Step 1, whose scope Step 1d caps at four branch points — decomposition,
  the sync/async boundary, persistence, concurrency. A pattern choice is none of those, so it is
  never disclosed, so there is nothing for a retrospective section to recover. If that holds, the
  fix is in the **disclosure scope**, and changing the Decisions section would do nothing.
- **The guard any fix has to respect:** `references/smells.md` names pattern-name-driven design as
  an LLM failure mode, and Step 7 already warns that an empty Decisions section creates pressure
  to invent entries. A general "walk the design for patterns" prompt is the shape most likely to
  manufacture them. A trigger anchored to something already on the page — a drawn state diagram
  means an FSM-versus-State choice was taken — cannot fire where there is nothing to record. Do
  not pick between these before the cause is known.
- **The observation is accurate for its own artifact and wrong as a general claim, and a
  counter-example was already on disk when this was filed.** `DESIGN-rerun.md` — the Sonnet run
  this item was written from — does have exactly those eight entries and zero pattern names. But
  `mnb-opus/DESIGN.md`, the Opus run measured in the same session, carries
  *"### `phase` as a tagged field on `Match`, not the State pattern"* with *"**Over:** GoF State,
  with a class per phase"*. So the title's **"ever"** was never true, and the hypothesis — that
  Step 1d's disclosure scope makes a pattern choice unrecoverable — is refuted by an artifact that
  existed before the item did. Counting every run: **Opus 4 of 4 produce a pattern entry, Sonnet
  0 of 1.** This is the same shape as R-020's coined-term rule: a model-dependence result written
  down as a mechanism defect.
- **The 2026-08-28 runs produced the entry unprompted, three times.** The `## Decisions` section contains *"The phase is a field on Match, with branching
  in apply — **Over:** the GoF State pattern, one class per phase"*, with the reasoning that State
  buys polymorphic dispatch these four phases do not need. That is a kind-2 entry, naming the exact
  pattern this item says is never named, on the exact decision it cites as the one that went
  unrecorded. `## Deliberately not abstracted` carries a second — *"No rule, validator or strategy
  object"*. **Nothing changed in the disclosure scope**, so "a pattern choice is never disclosed at
  Step 1d, therefore there is nothing to recover retrospectively" is contradicted: it was recovered
  anyway. What is left of this item is a different and smaller question — why three runs produced
  none and the fourth produced two — and that question is R-022's, not this one's. **Do not design
  a disclosure-scope change against the old premise.**
- **Outcome:** the cause is named in writing, and either a change lands or this file records why
  the gap is acceptable.
- **Blocked-by:** R-022 — it is now the same question.
- **Enables:** —

### R-022 — Conformance tracks the model, and the runs themselves are stable

- **Category:** Validation
- **ANSWERED 2026-08-28 for `design`, on the five rules below. Two results, and the second was
  not the one this item expected.**
  1. **There is no run-to-run variance to speak of.** Three runs at one commit (`9f9c434`),
     `claude-opus-5`, same SPEC, same prompt: **identical on all five rules, 3 of 3 diagrams,
     six states built in each.** A fourth run died on the box's session limit. So **n=1 is usable
     evidence** for these rules at this model — which is the opposite of what the flipping
     coined-term result suggested, and it holds because that flip was a measurement artifact.
  2. **The variation that does exist is between models, not between runs.** Re-grading every
     artifact with the corrected check: the coined-term rule is **Opus 4 of 4, others 0 of 2**;
     a pattern-naming `## Decisions` entry is **Opus 4 of 4, Sonnet 0 of 1**. Both had been
     written into the roadmap as broken mechanisms needing new machinery.
- **What this cost, and it is the lesson worth keeping:** two roadmap items — R-020's
  `GLOSSARY.md` and R-021's disclosure-scope change — were built on failures that a correct
  measurement does not show. **Two independent mechanical checks of the same rule were both wrong,
  in opposite directions**: an earlier grep gave a false PASS, and a per-line window gave a false
  FAIL because the sentence wrapped. The fragile thing was never the rule; it was the ruler.
- **Therefore: a rule's measurement is apparatus and has to be kept and re-runnable**, not
  re-derived per session. Where it is cheap, move the check off prose entirely — Step 7b is the
  existence proof: the namespace rule went FAIL/FAIL/PASS across three runs and is now caught by
  `mmdc` every time at zero variance. See R-025.
- **What is left of this item:** the model comparison at n>1. Everything so far is n=1 per model
  for Sonnet, all headless, all self-answering the defense, so it may still be measuring the
  harness. It is no longer urgent: the product answer shipped in 0.17.2 and nothing in the
  evidence points the other way.
- **The product half shipped in 0.17.2.** `README.md` recommends the strongest available model and the highest effort for `design`,
  on the cost-of-defect argument — `code` traces every increment back to `DESIGN.md`, so a wrong
  decomposition costs a reconcile per increment — and `DESIGN.md` carries a `Produced by:` line so
  a design that turns out wrong can be attributed. Effort is flagged there as unmeasured.
- **The question this item now owns, and it is about developing yaait rather than using it:**
  **do repeated runs of the same commit, same model, same project and same prompt agree with each
  other?** Every doctrine change here is justified by a measurement, almost always n=1. If two
  identical runs disagree, then n=1 is not evidence and rules are being written against noise.
- **Why it cannot be skipped:** prose tuned against a metric whose noise floor is unknown is prose
  fitted to noise, and 0.14.0 is the worked example — a rule written to fix an observed failure,
  which caused a worse one. **Two items were nearly built on n=1 failures that run 4 did not
  reproduce**: R-020 would have specified a `GLOSSARY.md` to repair a working rule, R-021 would
  have widened Step 1d's disclosure scope to recover an entry that already appears.
- **The evidence is thinner than the 5-of-5 headline**, and the item should not pretend otherwise.
  Of those five passes, the namespace and semicolon rules are plausibly the new `mmdc` check
  rather than the prose, the spec's-word rule was directly targeted by 0.16.0, and the participant
  rule already passed before it. **Only the coined-term rule is unexplained** — nothing targeted
  it and no tool can see it. So the case for variance rests on **one rule flipping on one run**.
- **The experiment:** three runs of `design` at one commit (0.17.1 or later), `claude-opus-5`,
  `/home/dfg/src/multi-naval-battle`'s SPEC, `/home/dfg/design-prompt.txt`, graded mechanically on
  the same five rules plus `mmdc`. Confirm the model from the transcript, not the flag. If they
  agree, n=1 is usable and R-020 and R-021 get re-read as genuinely fixed. If they disagree, no
  rule may be filed as failing on n=1 again — **and the better response is to move what can be
  mechanised out of prose entirely**, the way Step 7b did: the namespace rule went FAIL/FAIL/PASS
  across three runs and is now simply caught by `mmdc` every time, at zero variance.
- **Only if runs agree** does the model comparison become worth its cost — Sonnet versus Opus,
  n=2 each — and by then it is a curiosity, since the recommendation has already shipped.
- **What this item no longer needs to decide:** what to tell users. That is done.
- **The measurement, 2026-08-28.** One plugin commit (`b4fa995`), one project, one prompt, one
  variable changed — the model. Five rules checked mechanically:
  - `claude-sonnet-5` at `effortLevel: high` — **0 of 5**. One diagram rendered of three.
  - `claude-opus-5` — **2 of 5 pass, 1 partial, 2 fail**. Two diagrams rendered of three.
  The two that passed on Opus and failed on Sonnet are both rules about **what to draw**. The three
  that failed on Opus are rules about **how to phrase text** — term choice and punctuation. That
  split is the finding worth testing again rather than assuming.
- **A fourth run, `claude-opus-5` at 0.17.0, scored 5 of 5 and 3 of 3 diagrams** — including the
  two rules 0.16.0 deliberately did **not** touch. Doctrine changed between the runs, so this is
  not a clean comparison; what it does establish is that this item has stopped being background.
  **Two roadmap items were filed on failures that one current-doctrine Opus run did not reproduce**
  — R-020's coined-term rule and R-021's missing pattern entry — and both now carry a note saying
  so. Until this is settled, rules get written against evidence of unknown provenance, and items
  get filed and unfiled on n=1.
- **The experiment that would settle it**, and it is cheap now that grading is mechanical: one
  plugin commit (0.17.1), one project, `/home/dfg/design-prompt.txt`, **n=2 per model** so
  run-to-run variance is separable from model, graded with `mmdc` plus the five rule checks.
  Confirm the model from the transcript, not the flag.
- **Why:** the plugin ships to whoever installs it and says nothing about which model it needs. A
  user on Sonnet gets a gate that emits a structure diagram which does not render and a design
  whose names have quietly drifted from the spec — and nothing in the run tells them the method
  was degraded rather than satisfied. That is the same shape as R-011's undecidable detector: a
  rule that cannot land is not a pass, but it reports as one.
- **The counter-argument to answer, not skip:** n=1 per model, both headless, both self-answering
  the defense. Headless runs have no picker and no human, so this may measure the harness as much
  as the model. Re-measure before acting on it.
- **Blocked-by:** —
- **Enables:** —
