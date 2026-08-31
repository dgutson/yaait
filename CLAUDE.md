# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

yaait is a Claude Code **plugin** and **what ships is prose all the way down** — no source code,
no build, no test suite and no lint. Every file that ships is either doctrine (root `*.md`) or an
instruction set that an LLM executes at runtime (`skills/*/SKILL.md`). Editing here means
editing text that becomes another session's behaviour, so the review standard is "would a
model follow this and get the intended result", not "does it compile".

**`experiments/` is the one exception, and it is deliberately not product.** It holds apparatus for
measuring whether a gate obeyed its own rules, named by the roadmap item it came from, and it has
skipped every gate the product goes through. **Nothing in `skills/` may reference or run it** — an
import from it is a review finding, not a judgment call. It exists because the same measurement was
re-derived in three separate sessions and got the same rule wrong twice, in opposite directions,
and both errors reached `ROADMAP.md` as findings; one of them stood for two releases. This repo has
no `EXPERIMENTS.md` — `HISTORY.md` carries what a spike established.

The plugin exposes six method gates — `spec`, `tech`, `design`, `code`, `stest`, `debt` —
invoked as `/yaait:<name>`. There is also one **instrument**, `feedback`, which is not a gate:
it builds nothing and captures friction into `.yaait/FEEDBACK.md` for later forensic analysis.
It is provisional, serves the first dogfood, and deliberately does not carry the shared rules
block — see below.

## Commands

Nothing in the product builds or runs. The verification loop is installing the plugin from a local
clone and exercising a skill in a **separate directory**:

```bash
claude plugin marketplace add /home/daniel/src/yaait
claude plugin install yaait@yaait-marketplace
```

**Those two lines are a one-time step, and after them the clone *is* the runtime.** The
marketplace is a `directory` source, so the plugin root resolves to the working tree and every
session reads it live. Consequences, each of which has already cost a session time:

- **`git pull` is the entire update procedure.** `claude plugin update` changes no behaviour.
- **`claude plugin list` reports the version from `installed_plugins.json`**, which is refreshed
  only by an explicit update and is therefore stale one commit after any release. It said
  `0.3.0` while the clone ran `0.20.0`.
- **`claude plugin details <plugin>` reads the live clone and is the command that tells the
  truth** — version *and* skill inventory. Run it before trusting any test result, on the box
  the test ran on. It is how you establish which bytes actually executed.
- **Never read `~/.claude/plugins/cache/` to find out what a gate says.** Nothing loads it. It
  holds whatever the last explicit install copied, which for this repo was rules from four
  releases back, and a grep there answers the wrong question convincingly.
- **`claude plugin update` copies the whole working tree, `.gitignore` and all.** It picked up
  the 15 MB `.pptx` and a `HANDOFF.md` containing a plaintext password. If you run it to make
  `list` honest, delete the cache directory afterwards; deleting it breaks nothing, because
  nothing reads it.

Check the shared rules block is still byte-identical across the six gates (see below) — all
six hashes must match. The list is spelled out rather than globbed, because `skills/feedback/`
carries no shared block by design and a glob reports it as divergence:

```bash
for f in skills/{spec,tech,design,code,stest,debt}/SKILL.md; do
  printf '%s  %s\n' "$(sed -n '/^## The rules that are the method/,/^## Step 0/p' "$f" \
    | sed '$d' | md5sum | cut -c1-32)" "$f"
done
```

To grade a `DESIGN.md` a run produced, against `design`'s own rules, use the apparatus rather than
writing the check again — that is what got the same rule wrong twice:

```bash
experiments/R-022-rule-conformance/grade.sh path/to/DESIGN.md "label"
```

Releasing is a one-line version bump in `.claude-plugin/plugin.json` with a commit message
explaining what an already-installed older copy would get wrong (see commit `0fee357`).

## Architecture

**Three doctrine layers at the root, each with a distinct job.** Do not blur them:

- `MANIFESTO.md` — the position. Claims and principles, no procedure.
- `METHODOLOGY.md` — the long-form rules, numbered `§1`–`§12`. This is the single source of
  truth; every skill carries a compacted copy of the parts it needs and cites this file for
  the reasoning.
- `COMPARISON.md` — the argument and the evidence, including every number yaait quotes.

**Six skills, one shape.** Each `skills/<name>/SKILL.md` is: frontmatter description →
why this command exists → the shared rules block → numbered `Step N` sections ending in a
review and a close. Deep reference material that would bloat the context lives in
`skills/<name>/references/` and is read on demand: `code/references/review.md` (code-level
review), `design/references/smells.md` (architectural smells), `design/references/mermaid.md`,
`design/references/independent-check.md` (the brief for the subagent `design` Step 7a spawns,
which must not be given the design conversation), and `code/references/aposd-vs-clean-code.md`
— which is *input* to R-001, not criteria, and must never be cited as settled.
`review.md` and `smells.md` are deliberately at different altitudes and must not overlap —
smells are properties of a dependency graph, review criteria are properties of a diff.

**Artifacts are written into the user's project, never into this plugin.** `.yaait/SPEC.md`,
`TECH.md`, `DESIGN.md`, `JOURNAL.md`, `FEEDBACK.md`, plus `TECH_DEBT.md`, `EXPERIMENTS.md`, an
`experiments/` directory for kept apparatus, and the optional `DESIGN_GUIDELINE.md` /
`CODING_GUIDELINE.md` at the project root. Never create those here; dogfooding happens in a
fresh session and a separate directory (ROADMAP R-002).

## Invariants that are easy to break

- **The shared rules block is byte-identical in all six gate `SKILL.md` files** — everything
  from `## The rules that are the method` through the end of `## Where things go` (~435 lines,
  covering the loop, question routing, the discussion protocol, how to mark what kind of ask
  something is, the review round, the reconcile rule and the artifact layout). A rule changed in one
  gate must be changed in all six, identically, in one commit. Skills are loaded one at a time,
  so divergence is invisible at runtime and shows up as the method quietly behaving differently
  depending on which gate you entered through. **`skills/feedback/` is excluded on purpose**
  and carries none of it: the block's challenge protocol and review round would damage that
  command's record, since a user's account of their own friction is not a claim to be
  contested. Do not "fix" its missing block.
- **`tech` runs before `design`, and that order is restated in a dozen places.**
  `METHODOLOGY.md` §1 (the gate table, the arrow chain, the `EXPERIMENTS.md` writer list and
  the rule paragraph) and its §8 artifact tree; `README.md`'s commands table and artifact tree;
  the `tech` and `design` frontmatter descriptions; `tech`'s "When to run this"; `design`
  Step 0 and Step 1d; `spec` Step 10, its `Gates recommended` template, and the rules block
  `spec` writes into the user's own project; `code` Step 0; and the artifact tree inside the
  shared block. Changing the order in one of them fails nowhere — it produces a method that
  runs a different sequence depending on which document the session happened to read. The rule
  itself: greenfield `design` stops without a `TECH.md`; Maintenance is exempt because the
  stack is on disk. The
  guard that goes with it: a stack choice made before the design exists is a **decision with a
  falsifier**, never an inherited constraint, or tech-first becomes a way to launder structure
  past §9.
- **Cross-file references are by section number.** Skills cite `METHODOLOGY.md` §2, §3, §7,
  §8 and §10; `ROADMAP.md` cites `review.md` §5. Renumbering a section silently invalidates
  references in files you did not open — and worse, a reference can survive the renumber and
  resolve to the *wrong* section, which no dangling-reference check finds. Read what each `§N`
  lands on; do not just check it is in range. `METHODOLOGY.md` itself cites the reference
  files **by concept**, never by path, with one locator table at its end — it is meant to
  survive repackaging, so do not reintroduce `skills/...` paths into its body.
- **Renaming a root document breaks every installed copy**, because skills reference these
  paths at runtime. `DOCTRINE.md` → `METHODOLOGY.md` is the whole reason 0.3.0 exists. A
  rename needs a version bump and a note about what the old copy now points at.
- **Frontmatter descriptions are the only trigger mechanism.** They are what decides whether a
  skill is ever consulted; treat them as functional, not as blurb. They are hand-written and
  unmeasured (R-004).
- **`skills/code/references/review.md` is PROVISIONAL**, pending the Clean Code discussion
  tracked as R-001. Its §5 is an open agenda, not a gap to be tidied — do not settle those
  questions in passing, and keep the banner until R-001 lands.

## Writing conventions

- **Every rule states the failure mode it prevents.** A rule without a named consequence gets
  skipped by the model reading it, exactly as it would by a person.
- **The method itself is unmeasured, and the documents say so.** Numbers in `COMPARISON.md`
  are about the *problem*, never about yaait's effectiveness. Do not add efficacy claims, and
  keep the qualifiers others have deliberately added (`git log` on `MANIFESTO.md` is largely a
  record of removing overclaiming).
- Applies to the doctrine as much as to skills: no self-authorizing prose, no irony, no
  motivational register. Say the actionable thing and stop.
- Commit subjects state the change's *point*, not the file touched
  ("MANIFESTO: drop the values block; qualify the reactor claim").

## Roadmap

This repo is governed by ROADMAP.md (pending work) and HISTORY.md (completed work).

- **Start here for context.** ROADMAP.md is the durable record of work that is established
  but unfinished. Read it rather than reconstructing the state of play from git history,
  old conversations, or a sweep of the code.
- Items are grouped **Now / Next / Later**. To choose what to work on, take the first item
  under the earliest horizon whose **Blocked-by** entries are no longer present in the file.
- When you finish an item: delete it from ROADMAP.md, add a line under today's date at the
  top of HISTORY.md recording the outcome **actually** achieved, and drop its ID from the
  **Blocked-by** list of every item it was blocking.
- When **Now** empties, promote the readiest items from **Next**, so the file keeps
  answering "what should I be doing" rather than going quiet.
- ROADMAP.md holds pending work only. Never mark an item done in place — removal is what
  "done" means here.
