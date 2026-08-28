# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

yaait is a Claude Code **plugin** and it is prose all the way down — there is no source
code, no build, no test suite and no lint. Every file is either doctrine (root `*.md`) or an
instruction set that an LLM executes at runtime (`skills/*/SKILL.md`). Editing here means
editing text that becomes another session's behaviour, so the review standard is "would a
model follow this and get the intended result", not "does it compile".

The plugin exposes six method gates — `spec`, `design`, `tech`, `code`, `stest`, `debt` —
invoked as `/yaait:<name>`. There is also one **instrument**, `feedback`, which is not a gate:
it builds nothing and captures friction into `.yaait/FEEDBACK.md` for later forensic analysis.
It is provisional, serves the first dogfood, and deliberately does not carry the shared rules
block — see below.

## Commands

There is nothing to build or run. The only real verification loop is installing the plugin
from a local clone and exercising a skill in a **separate directory**:

```bash
claude plugin marketplace add /home/daniel/src/yaait
claude plugin install yaait@yaait-marketplace
```

Check the shared rules block is still byte-identical across the six gates (see below) — all
six hashes must match. The list is spelled out rather than globbed, because `skills/feedback/`
carries no shared block by design and a glob reports it as divergence:

```bash
for f in skills/{spec,design,tech,code,stest,debt}/SKILL.md; do
  printf '%s  %s\n' "$(sed -n '/^## The rules that are the method/,/^## Step 0/p' "$f" \
    | sed '$d' | md5sum | cut -c1-32)" "$f"
done
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
defense and a close. Deep reference material that would bloat the context lives in
`skills/<name>/references/` and is read on demand: `code/references/review.md` (code-level
review), `design/references/smells.md` (architectural smells), `design/references/mermaid.md`,
`design/references/independent-check.md` (the brief for the subagent `design` Step 7a spawns,
which must not be given the design conversation), and `code/references/aposd-vs-clean-code.md`
— which is *input* to R-001, not criteria, and must never be cited as settled.
`review.md` and `smells.md` are deliberately at different altitudes and must not overlap —
smells are properties of a dependency graph, review criteria are properties of a diff.

**Artifacts are written into the user's project, never into this plugin.** `.yaait/SPEC.md`,
`DESIGN.md`, `TECH.md`, `JOURNAL.md`, `FEEDBACK.md`, plus `TECH_DEBT.md`, `EXPERIMENTS.md`, an
`experiments/` directory for kept apparatus, and the optional `DESIGN_GUIDELINE.md` /
`CODING_GUIDELINE.md` at the project root. Never create those here; dogfooding happens in a
fresh session and a separate directory (ROADMAP R-002).

## Invariants that are easy to break

- **The shared rules block is byte-identical in all six gate `SKILL.md` files** — everything
  from `## The rules that are the method` through the end of `## Where things go` (~330 lines,
  covering the loop, question routing, the discussion protocol, how to mark what kind of ask
  something is, the defense, the reconcile rule and the artifact layout). A rule changed in one
  gate must be changed in all six, identically, in one commit. Skills are loaded one at a time,
  so divergence is invisible at runtime and shows up as the method quietly behaving differently
  depending on which gate you entered through. **`skills/feedback/` is excluded on purpose**
  and carries none of it: the block's challenge protocol and defense would damage that
  command's record, since a user's account of their own friction is not a claim to be
  contested. Do not "fix" its missing block.
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
