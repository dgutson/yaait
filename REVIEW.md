# Review — MANIFESTO.md

> **Findings only, except where a finding is marked APPLIED.** Reviewed 2026-08-22 against
> commit `fb46241`. Line numbers refer to the files at that commit; the doctrine pass of
> 2026-08-21..23 has since moved them, so read the citations with
> `git show fb46241:<file>`. Applied so far: **A1**, **A2**, **A3**; **A8** resolved.

## How this was produced

Three independent audits with separate briefs — internal consistency of `MANIFESTO.md`;
delivery of its claims against `METHODOLOGY.md` and the six skills; rhetoric and
overclaiming — followed by verification of every load-bearing quotation against the files
and the git history. Suspicions that did not survive that check are listed in Part C rather
than dropped, because knowing which objections are unfounded is worth as much as the list
of real ones.

Severity is **HARD** (both propositions cannot hold), **SOFT** (reconcilable, but the
document never does it), or **SCOPE** (one claim is stated absolutely and another quietly
narrows it).

---

# Part A — Contradictions

## A1. The accountability clause's escape hatch is unreachable — HARD

> **APPLIED 2026-08-24.** A fourth defense outcome exists: *Answered wrongly* → `DEBT`,
> never `APPROVAL`. In `METHODOLOGY.md` §3 and the shared block in all six skills. The
> `DEBT` template gained a `What happened` field so a reader can tell a declined question
> from an attempted one. The unlinked-journal-entry gap this finding also names is NOT
> addressed and remains open.

The clause at `MANIFESTO.md:72-74` is the document's load-bearing sentence:

> The human whose name is on the commit must be able to defend it under questioning.
> Or the record must say they could not.

Three separate mechanisms disable the second half.

**Principle 6 disqualifies the event.** `MANIFESTO.md:56-57` — "A challenge you cannot
answer is not a review." The same observable event, a human who cannot answer, is
classified by Principle 4 as a recordable outcome and by Principle 6 as a disqualified
review. No test distinguishes them, so an implementer following Principle 6 literally never
terminates in the Principle 4 state.

**There is no outcome for a wrong answer.** `METHODOLOGY.md:208-221` defines exactly three:
Defended ("the answer is right, or right enough"), Taught, Declined. Answering wrongly
without declining falls through all three.

**`APPROVAL` absorbs the failure.** The shared block's template
(`skills/code/SKILL.md:164-167`, identical in all six skills) reads "**Answer:** what the
user said, and whether it held up" — conceding the answer may not hold up, while the entry
type remains `APPROVAL`. A failed defense is recordable only as an approval.

Downstream, `COMPARISON.md:247` offers "defended vs. undefended artifacts" as yaait's
replacement for velocity. With no fourth outcome those categories are neither exhaustive
nor disjoint.

One gap could not be closed: **nothing links a journal entry to a commit.** The clause is
about "the human whose name is on the commit", but no `SKILL.md` ever ties a `JOURNAL.md`
entry to one, so a reader holding the commit cannot find the record, and vice versa.

*Smallest fix:* a fourth outcome — *attempted and wrong* → `DEBT`, not `APPROVAL` — in
`METHODOLOGY.md` §3 and the shared block; and narrow Principle 6 to the machine's
obligation ("a challenge you were given no means to answer is not a review").

## A2. Principle 8 is false as written, and the method contradicts it universally — HARD

> **APPLIED 2026-08-24.** Principle 8 now reads "A decision that exists only in the
> conversation has not happened" — the shared block's own wording, promoted. The
> restatement in `METHODOLOGY.md` §2 that carried the unqualified version is gone.
> Two of the four arguments below were not accepted: the empty-domain reading is
> over-literal, and the collapse into Principle 4 is wrong — P4 governs comprehension,
> P8 governs decisions, and nothing in P4 reaches rejected alternatives.

> 8. **Nothing is decided in a conversation.** Including what you decided not to do.
> (`MANIFESTO.md:60`)

**Sentence 2 has an empty domain.** Under a strict reading of sentence 1 there is no "what
you decided not to do" for it to range over.

**The method decides in conversations, everywhere.** `METHODOLOGY.md:105-108` — "**One
round, then decide.** ... let the user choose. Then record the choice and who made it."
`skills/design/SKILL.md:456-457` — "Write the file before seeking approval. The defense in
Step 8 is where approval happens." Every `DECISION`, `APPROVAL` and `CHALLENGE` template
ends with **`Decided by:`** a person.

**Under the charitable reading it collapses into Principle 4.** "Nothing counts as decided
until it is written down" is true of the method, but adds nothing `MANIFESTO.md:53` does not
already say.

**It is not actionable.** There is no behaviour a reader could adopt to obey the principle
as worded while running six gates whose every outcome is chosen in conversation.

Worth crediting: the *second* sentence is delivered thoroughly — non-goals
(`skills/spec/SKILL.md:277-289`), `Rejected:` in every `DECISION` entry, "Deliberately not
abstracted" (`skills/design/SKILL.md:439`), "Requirements not addressed here" (`:447`),
"Rejected alternatives" (`skills/tech/SKILL.md:341`). The half that usually goes missing is
the half that shipped.

*Smallest fix:* one word — "Nothing is decided in a conversation **until it is written
down**", or "Nothing is decided *only* in a conversation."

## A3. Principle 4 is violated by construction — HARD

> **APPLIED 2026-08-24**, but not as written. Every defense now closes by naming the
> *categories* it did not probe — not an enumeration of what was unexamined, which would
> be the whole increment and would recreate the tedium the 3-5 limit exists to prevent.
> `stest` Step 5, cited here as the model, in fact names classes rather than instances,
> so this follows it more closely than the literal reading would.

> 4. **Undefended is allowed. Undefended and unrecorded is not.** (`MANIFESTO.md:53`)

The defense selects **3-5** elements and "the limit is hard" (shared block,
`skills/code/SKILL.md:65`). Only the *Declined* path writes a `DEBT` entry. Everything not
selected is therefore undefended **and** unrecorded — for a whole increment, the
overwhelming majority of the surface. That is precisely the state Principle 4 forbids.

The method knows the fix and applies it one gate over: `skills/stest/SKILL.md:280-283` makes
"Say what was not tested" a mandatory section — "the honest part of the report and the
reason anyone should trust the rest of it." The defense has no counterpart.

*Smallest fix:* one line in the shared block's defense close — journal what was *not*
examined, mirroring `stest` Step 5.

## A4. The closing line contradicts Principle 7 and the methodology's explicit rule — HARD

> *yaait is discussion-centric. If you and the machine are not arguing, one of you is not
> working.* (`MANIFESTO.md:96-97`)

Against **Principle 7** (`:58-59`), which licenses the machine to argue "only when it can
name the failure mode, who it hurts and what it costs": a fully compliant machine is
indicted by the closing line.

Against **`METHODOLOGY.md:100-101`**: "**To fill a quota.** There is no quota. A session
with zero challenges because nothing warranted one is a correct session." The manifesto's
parting line states the policy the discussion protocol was written to forbid, and the same
protocol calls manufactured disagreement "sycophancy with the sign flipped".

It is also unfalsifiable in use: a quiet session is proof of failure, so no amount of
correct agreement can count as the method working.

*Smallest fix:* a closer compatible with "zero challenges can be a correct session".

## A5. The junior cannot board the ladder, and the Taught path is self-graded — HARD

> 13. **The machine does not replace the junior. It is how the junior becomes a senior.**
> Seniors are the only people who can judge whether the machine's output is any good.
> (`MANIFESTO.md:67-68`)

**Against Principle 12** (`:66`), "Applied to zero it returns zero": if zero is a fixed
point, the machine cannot be the engine that moves a person off it. The charitable reading
requires "zero" to mean *abdication* rather than *inexperience*; the word "junior" invites
the wrong one, and the document never draws the distinction.

**Against `stest`'s founding argument.** `skills/stest/SKILL.md:31-34` builds an entire
human-observation rule on the premise that an LLM grading its own output is invalid — "the
whole methodology collapses at its last step into exactly the arrangement it was built to
prevent." In the Taught loop (shared block, `skills/code/SKILL.md:91-93`) the machine picks
the concept, supplies the explanation, writes the re-probe and judges the answer, with no
external check. For a senior this is fine; they can judge the explanation, which is
Principle 13's second sentence. For the **junior** — the only person the Taught path exists
for, and the one Principle 13 stipulates cannot judge machine output — it is the invalid
arrangement exactly. `MANIFESTO.md:39-40` says so directly: "A generator checked by another
generator inherits the misunderstanding."

*Smallest fix:* record a Taught outcome as `DEBT`-adjacent rather than `APPROVAL`, on the
grounds that comprehension established by the same party that tested it is not established.

## A6. Principle 6 defeats Principle 3 — SOFT

Principle 3 (`:52`) makes lack of preparation constitutive of a real defense: "answering a
question you were not prepared for." Principle 6 (`:56`) and line 78 make preparation the
machine's central service. The naive implementation of "arms you" — hand over the answer,
then ask the question — is what Principle 3 classifies as reciting. The distinction the
method rests on, arming with *material* versus arming with the *answer*, is never drawn.

## A7. Principle 9 loses its symmetry, and the staleness hatch condemns itself — SCOPE

Principle 9 (`:61`) compresses `METHODOLOGY.md` §4 asymmetrically: the document "never
outranks" the world (absolute), while the code does not outrank it "silently" (qualified).
Read literally, the document can never win — which contradicts §4's "sometimes the design
was wrong and must be rewritten to match what you learned."

Worse in delivery. `METHODOLOGY.md:281-284` states that "a drifted design document is worse
than no design document, because it misleads with authority", then routes the known-stale
note to `JOURNAL.md` — while `DESIGN.md` keeps the banner `skills/design/SKILL.md:386`
writes: "**Kept true:** if the code contradicts this, one of them changes deliberately." A
later reader of `DESIGN.md` sees maximum authority and no warning, produced by the escape
hatch of the rule that names the failure.

*Smallest fix:* require the known-stale `DECISION` to write a dated staleness line into the
affected document's own header, replacing "Kept true".

## A8. Principle 10 has no delivery mechanism, and lacks the carve-out Principle 11 requires — SOFT

> **RESOLVED 2026-08-24**, by removing the mechanism rather than delivering it. The size
> budget is deleted from `design`, from the `DESIGN.md` template, from the shared block and
> from Principle 10 — so there is no number left to re-count, and the finding's first half is
> moot rather than fixed. The second half is fixed as the audit proposed: Principle 10 now
> reads "...or the dated event that will produce one", which is the clause `design` Step 4b
> already used to admit the litter box. See the commits of 2026-08-24.

"Simplicity is a declared number" (`:62-63`) appears in one skill only. `code` never
re-counts the budget; `stest` and `debt` never check it. "Actual" is filled in by the same
author in the same turn, against the design rather than against the shipped code — which is
what `skills/design/SKILL.md:217-218` itself condemns: "A budget declared afterwards is a
description of what you happened to produce." And `DESIGN.md` is optional;
`skills/spec/SKILL.md:468-471` actively recommends against it for a single-module TTB, so
for every design-less TTB the principle has no mechanism at all.

Separately, Principle 10 **forbids what Principle 11 mandates**. The litter box is an
abstraction past the number that names no second concrete variant.
`METHODOLOGY.md:311-319` spots this collision and resolves it against `smells.md` §4 — and
never notices the identical collision with the manifesto principle that `smells.md` §4
implements.

*Smallest fix:* append to Principle 10 — "...or the dated intention to replace it."

## A9. "Debt" names two different things, and Principle 11 permits what Principle 2 prevents — SOFT

`MANIFESTO.md:14` defines *the debt* ostensively as the comprehension failure: code nobody
read, that nobody can now change safely. Principle 2 (`:49`) says understanding prevents it.
Principle 11 (`:64`) says debt is allowed if contained — but you cannot contain "nobody read
this" behind a boundary. The deliberate-shortcut sense is never distinguished from the
comprehension sense, which also leaves Principle 11's remedy incoherent against the only
definition the document has given.

*Smallest fix:* mark the sense shift — "*Deliberate* debt is allowed."

## A10. Two universal negatives the project's own documents contradict — SOFT

**"Nothing in current practice damps that reaction"** (`:16-17`) against "the same
accountability the author carries into peer review" (`:76-78`), and against
`METHODOLOGY.md:42-45`: "Peer review, CI, QA and release are unchanged by it and are not
replaced by it." Either the "nothing" is false, or the document owes an account of why the
identical requirement works here and not there. The defensible claim is available and
stronger: current practice requires the servicing but does not equip anyone to do it.

**"Nothing here argues against them"** (`:33`) against the argument that immediately
follows (`:36-40`) and against the headline claim at `:7`. The qualifier doing the work in
the premise — a loop reasoning "only from the code" — is absent from the conclusion, "It
cannot."

## A11. Scope is stated absolutely in one place and narrowed in another — SCOPE

`MANIFESTO.md:72` states the accountability requirement unconditionally, and `:76`
reinforces it against one specific defeater while naming no others. `:84-89` then exempts
spikes, notebooks and throwaway scripts — which are still commits with a name on them, and
still blameable in the git sense, so the inclusion test at `:89` ("maintained, extended, or
blamed") and the exemption test at `:84` overlap on the same artifacts. A reader with a
committed spike gets opposite instructions and no rule for which governs.

The same gap ships. The block `spec` installs into the project's `CLAUDE.md`
(`skills/spec/SKILL.md:424-449`) is per-*project*, permanent and unconditional, and carries
**no carve-out** — although `METHODOLOGY.md:338-345` writes one for experiment code and
names the stakes: "Gating a throwaway measurement is the category error that makes
methodologies hated." Only `spec` ever asks the applicability question
(`skills/spec/SKILL.md:208-212`); `skills/code/SKILL.md:191-193` will run with no `SPEC.md`
at all, so a user can enter the gates having never been asked whether yaait applies.

---

# Part B — Where the document sells

## B1. The manifesto is the only document that never admits the method is unmeasured

Verified in the history. `git show e9fea75` added to `MANIFESTO.md`:

> **Not measured.** Every number here is about the problem. None is about the method,
> because yaait has not yet been run at scale.

`git show e35654f`, the manifesto/methodology split, removed that paragraph and, in the same
hunk, put in its slot:

> A method that claims to apply everywhere is selling something.

The disclaimer survives as `METHODOLOGY.md` §"This has not been measured", so this was a
document split rather than a deletion. The effect stands regardless: the one-page document
that `README.md:14` advertises as "what yaait claims, in one page" — the version that gets
linked and quoted alone — is the version without the declaration, and the sentence now
occupying that slot performs candour rather than stating it. The same commit also dropped
the METR passage ("measured at **19% slower** ... estimated afterwards that they had been
20% faster"), so the manifesto also lost the warning that none of this is visible from
inside.

This is the highest-value single change available: without it, the document's own
accountability clause does not apply to the document.

## B2. The rest, ranked

| Where | What it does | Rating |
|---|---|---|
| **P2** (`:49`) "Understanding is how the debt is prevented" | States the method's efficacy in the indicative, the definite article doing the work of a proof. Its support — "Code nobody understood cannot be changed safely" — is false as stated: interfaces exist precisely so that people safely change code whose internals they do not understand. | QUALIFY |
| **`:29`** "whether you are the judgment the machine multiplies or the output it replaces" | False dichotomy, fear and flattery in one clause — and it offers a choice that `:42` says has already been made ("that race is over"). | CUT |
| **P12** (`:66`) "Applied to zero it returns zero" | Unfalsifiable in the field: anyone the method fails to help can be reclassified post hoc as a zero. It immunises the method against every reported failure. | QUALIFY or CUT |
| **`:80`** "Nothing else is accountability. Everything else is attribution." | A stipulated definition in the grammar of an empirical finding. It redefines sign-off, pairing, ownership and review out of the category without naming or arguing against any of them. | CUT, or restate as yaait's own choice |
| **`:87`** "A method that claims to apply everywhere is selling something." | Pre-emptive inoculation: converts a scope limit into a credibility claim and makes anyone who disagrees the seller. Aggravated by `COMPARISON.md:352-353`, which widens the scope back out to "most of the code that matters, and reliably includes several things you were sure were throwaway." | CUT |
| **`:19-25`** the five-stage bill | A predicted causal chain in the present indicative, framed as observation ("in this order"). None of `COMPARISON.md`'s four findings measures a honeymoon, an estimate collapse or a bankruptcy — and `e9fea75`'s own commit message records the author catching exactly this ("METR was cited as evidence a honeymoon ended, when it measured developers slower immediately"), fixing the citation and leaving the honeymoon standing. | QUALIFY |
| **`:7`, `:14-15`** "technical-debt reactor" | The one metaphor properly handed off to its evidence. But GitClear supplies aggregate levels and trends, whereas "reactor" imports a within-codebase feedback loop with a runaway terminal state — and that loop is exactly the sentence at `:14-15`, which is asserted rather than sourced. Commit `55b9a72` began this qualification; this is the piece it did not finish. | QUALIFY |
| **P13** (`:67-68`) | Three unevidenced claims about labour markets, pedagogy and assessment competence, one of them absolute. Its rhetorical function is reassurance in both directions. `COMPARISON.md`'s headline study is also a counterexample: METR's subjects were *experienced* developers who could not perceive a 19% regression from the inside. | QUALIFY, or cut the third sentence |
| **8 of 13 principles** | Stated as ontology ("X is not Y") rather than as the method's own choices. "Simplicity is a declared number" is a contestable design decision wearing a fact's grammar; "or it will never be repaid" is an unhedged universal, where `README.md:129-131` makes the defensible version — that its repayment cost is *unbounded*. | QUALIFY |

## B3. The evidence document oversells in the row a sceptic tests first

`COMPARISON.md:246` claims "a gate that will not pass an undefended abstraction". The gate
always passes an undefended abstraction provided a `DEBT` entry is written, and
`METHODOLOGY.md:219-225` argues at length that a blocking gate would make the method
*worse*: "people route around blocks by not invoking the tool, and then there is no record
at all." Here the positioning overstates what the skills correctly deliver.

*Smallest fix:* "a gate that will not pass an *unrecorded* undefended abstraction".

---

# Part C — What survives, and what dissolved

## Keep unchanged

- **`:10`** — "Generating code is no longer the bottleneck. Understanding what you just
  accepted is." The best-evidenced sentence in the document; `COMPARISON.md`'s fourth
  finding is a direct hit, and the citation is worth carrying into the manifesto.
- **Principle 4** (`:53`) — a rule stated as a rule, falsifiable in use, with no efficacy
  claim attached. It is the model the other twelve principles should follow.
- **The accountability clause** (`:72-78`), up to but excluding `:80`. It states a
  requirement, explicitly disclaims replacing peer review, and claims no outcome.
- **The exemption list** (`:84-86`) — concrete, and it does honestly the work that `:87`'s
  aphorism rides on.

## Suspicions that dissolved under scrutiny

- **Principle 8 against Principle 5** ("Not knowing is one conversation from knowing").
  No contradiction: Principle 5 is about epistemic state, Principle 8 about decision status.
  A conversation can move a person from not-knowing to knowing without settling anything.
- **"Nothing ever reads the accountability record back."** Too strong.
  `skills/stest/SKILL.md:192-193` reads `JOURNAL.md` for `DEBT` entries, `:292-293` makes
  them mandatory in the not-tested section, `:309-310` makes one a defense target and
  `:339` carries it into the verdict; `skills/code/SKILL.md:187-189` reads recent entries.
  Two narrower gaps do survive: nothing aggregates those entries, and
  `METHODOLOGY.md:408-412`'s promotion of persistent comprehension debt into `TECH_DEBT.md`
  is written in the passive voice with **no command owning it** — `debt` Step 1 classifies
  only `TECH_DEBT.md` items and its report template has no slot for the result.
- **"The 3-5 defense floor is a quota, contradicting §2's 'There is no quota'."** No: the
  no-quota rule is about *challenges*, the 3-5 is about *defense questions*. Different
  mechanisms.
- **"The reconcile rule lets the code win silently."** No: the escape hatch requires an
  explicit `DECISION` entry, so "nor does the code, silently" holds. The real defect is
  where the warning lands — see A7.
- **Shared-block divergence across the six skills.** Checked; all six hash identically.
  Not a finding.

## Already tracked

`ROADMAP.md` R-005 (decision falsifiers are never re-checked) and R-007 (repeated teaching
of one concept goes unnoticed) sit adjacent to A7 and A5 respectively, but neither describes
the contradictions recorded here.

---

# The two cheapest high-value changes

1. **Restore a one-line unmeasured declaration to `MANIFESTO.md`** (B1). One sentence, and
   the git history shows it was already written once and lost in a refactor.
2. **Add a fourth defense outcome** — *attempted and wrong* → `DEBT`, not `APPROVAL` (A1).
   It makes the accountability clause's second half reachable and makes
   `COMPARISON.md:247`'s metric well-formed.
