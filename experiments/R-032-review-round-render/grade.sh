#!/bin/bash
# Grades one review round on the rules Step 6 states mechanically.
#
#   $1  picker-payloads.jsonl   what the gate ASKED  (PreToolUse hook on AskUserQuestion)
#   $2  transcript.jsonl        what the gate WROTE  (~/.claude/projects/<proj>/<session>.jsonl)
#   $3  label
#
# Judgment checks are deliberately NOT here — whether the keyword was taught on first
# use, whether a mid-round question reopened the discussion, and whether the round reads
# as an exam. Those go in prose.

PAY="$1"; TR="$2"; TAG="$3"
[ -z "$TR" ] && { echo "usage: $0 <picker-payloads.jsonl> <transcript.jsonl> <label>"; exit 2; }
echo "===== $TAG ====="

if [ ! -s "$PAY" ]; then
  echo "P0 picker-used              FAIL   no payloads: AskUserQuestion never fired."
  echo "                                   Either the hook did not attach, or the round"
  echo "                                   put its options in prose. Read the transcript"
  echo "                                   before concluding which."
  PAY=/dev/null
else
  echo "P0 picker-used              PASS   $(grep -c . "$PAY") AskUserQuestion call(s)"
fi

python3 - "$PAY" "$TR" <<'PYEOF'
import json, sys, re

pay_path, tr_path = sys.argv[1], sys.argv[2]
KINDS = ("Reviewing", "Deciding", "Checking", "Challenging")
KRE = "|".join(KINDS)

qs = []
for line in open(pay_path):
    line = line.strip()
    if not line:
        continue
    try:
        ti = json.loads(line).get("tool_input", {})
    except json.JSONDecodeError:
        continue
    qs.extend(ti.get("questions") or [])

# Assistant prose, with its real newlines. This is the input for anything that counts
# lines: a terminal capture is hard-wrapped at the pane width, so counting captured
# lines counts wrapping. An earlier version of this script graded the capture, called a
# compliant four-line stop eleven lines, and grew a pane-width argument to undo the
# damage. The transcript never needed one.
prose = []
for line in open(tr_path):
    try:
        o = json.loads(line)
    except json.JSONDecodeError:
        continue
    if o.get("type") == "assistant":
        for c in o.get("message", {}).get("content", []):
            if c.get("type") == "text" and len(c.get("text", "").strip()) > 200:
                prose.append(c["text"])
all_prose = "\n\n".join(prose)

def emit(rule, verdict, ev):
    print(f"{rule:<27} {verdict:<6} {ev}")

# ---- R1  the kind keyword opens the question TEXT --------------------------------
# "The keyword goes at the front of the question text, never in a picker's header."
if not qs:
    emit("R1 keyword-opens-question", "n/a", "no payload to check")
else:
    bad = [q.get("question", "")[:60] for q in qs
           if not re.match(r"\s*(%s)\s*[—-]" % KRE, q.get("question", ""))]
    emit("R1 keyword-opens-question", "FAIL" if bad else "PASS",
         f"{len(bad)}/{len(qs)} lack a leading kind: {bad}" if bad
         else f"all {len(qs)} open with a kind keyword")

# ---- R2  the keyword is NOT hiding in the header ---------------------------------
# R1 FAIL together with R2 FAIL is the 0.18.0 signature.
if not qs:
    emit("R2 keyword-not-in-header", "n/a", "no payload to check")
else:
    hdr = [q.get("header", "") for q in qs if any(k in q.get("header", "") for k in KINDS)]
    emit("R2 keyword-not-in-header", "FAIL" if hdr else "PASS",
         f"kind found in header(s): {hdr}" if hdr
         else f"headers carry the anchor only: {[q.get('header','') for q in qs]}")

# ---- R3  the forbidden option wording --------------------------------------------
# "Never word this as 'record as debt and move on'."
labels = [o.get("label", "") for q in qs for o in (q.get("options") or [])]
m = re.findall(r"[Rr]ecord as debt[^|\n]*", " || ".join(labels) + " || " + all_prose)
emit("R3 no-record-as-debt", "FAIL" if m else "PASS",
     f"forbidden wording present: {sorted(set(m))}" if m else "absent from options and prose")

# ---- R4a  option shape: fork branches, or the fixed set -------------------------
# "Where the stop has a real fork, the branches of that fork ARE the options. Where it
# does not:" then the fixed four. An earlier version demanded the fixed set
# unconditionally and would have reported a false FAIL on a compliant run.
FIXED = ("give my view", "show me what it costs", "keep what you wrote")
explains = [l for l in labels if l.lower().startswith("explain")]

if not qs:
    emit("R4a option-shape", "n/a", "no payload to check")
    emit("R4b explain-every-stop", "n/a", "no payload to check")
else:
    shortfall, detail = [], []
    for q in qs:
        ls = [o.get("label", "") for o in (q.get("options") or [])]
        low = [l.lower() for l in ls]
        branch = [l for l in ls if not l.lower().startswith("explain")
                  and not any(f in l.lower() for f in FIXED)]
        kind = "fork" if len(branch) >= 2 else "forkless"
        detail.append(f"{q.get('header','?')}={kind}/{len(ls)}")
        if kind == "forkless":
            miss = [f for f in FIXED if not any(f in l for l in low)]
            if miss:
                shortfall.append((q.get("header", "?"), miss))
    emit("R4a option-shape", "FAIL" if shortfall else "PASS",
         f"forkless stop(s) missing fixed options: {shortfall}" if shortfall
         else f"{' '.join(detail)} — where a fork exists its branches are the options")

    # "Offer to teach the underlying concepts, by name, at every stop."
    none_ = [q.get("header", "?") for q in qs
             if not any(o.get("label", "").lower().startswith("explain")
                        for o in (q.get("options") or []))]
    emit("R4b explain-every-stop", "FAIL" if none_ else "PASS",
         f"{len(none_)}/{len(qs)} stops offer no 'Explain <concept>': {none_}" if none_
         else f"all {len(qs)} stops name a concept: {explains}")

# ---- R5  no generic "I'll explain it" beside named concepts ----------------------
generic = [l for l in labels
           if re.fullmatch(r"\s*(I'?ll explain( it)?|Explain( it| this)?)\s*", l, re.I)]
emit("R5 no-generic-explain", "FAIL" if (generic and explains) else "PASS",
     f"generic beside named concepts: {generic}" if (generic and explains)
     else "no generic explain option")

# ---- R6  four lines per stop, hard ----------------------------------------------
# One line per thing a stop is made of: what it does, why this shape, what it costs if
# wrong, the call. Four since 0.20.1.
if not all_prose:
    emit("R6 four-line-cap", "n/a", "no assistant prose in the transcript")
else:
    pat = r"(?m)^(?=\s*(?:[-*]\s*)?\*{0,2}(?:%s)\b)" % KRE
    stops = [s for s in re.split(pat, all_prose)
             if re.match(r"\s*(?:[-*]\s*)?\*{0,2}(?:%s)\b" % KRE, s)]
    if not stops:
        emit("R6 four-line-cap", "n/a", "no stop-shaped blocks in the prose")
    else:
        over = []
        for s in stops:
            body = [ln for ln in s.strip().splitlines() if ln.strip()]
            cut = next((i for i, ln in enumerate(body) if ln.strip() in ("---", "***")), len(body))
            if len(body[:cut]) > 4:
                over.append((body[0].strip()[:46], len(body[:cut])))
        emit("R6 four-line-cap", "FAIL" if over else "PASS",
             f"{len(over)}/{len(stops)} stops over four lines: {over}" if over
             else f"all {len(stops)} stops within four lines")

# ---- R7  an ask delivered without options ----------------------------------------
# Options exist so that choosing "Explain X" costs nothing while typing "I don't know
# what X is" is a confession in writing. A question put in prose with no options
# withdraws that protection, and it does so hardest on the user who has just asked to be
# taught — which is where this was first observed.
#
# Turn-scoped on purpose. A stop's "The call:" line is prose AND is carried by a picker
# in the same turn; that is the shape Step 6 asks for, not an orphan. What counts is a
# turn that asks something and calls AskUserQuestion nowhere in it.
# Grouped by real user boundaries, not by transcript entry. Claude Code emits the prose
# and the AskUserQuestion call as consecutive assistant entries with no user message
# between them; per-entry scoping calls every stop's "The call:" line an orphan, which
# is the opposite of the truth.
groups, cur, ask_ids = [], {"ask": False, "text": []}, set()
for line in open(tr_path):
    try:
        o = json.loads(line)
    except json.JSONDecodeError:
        continue
    t = o.get("type")
    if t == "user":
        content = o.get("message", {}).get("content", [])
        blocks = content if isinstance(content, list) else []
        results = [b for b in blocks if isinstance(b, dict) and b.get("type") == "tool_result"]
        # A group ends when the USER acts — by speaking, or by answering a picker.
        # Answering arrives as a tool_result, not as a message; treating it as a
        # non-event lets everything the gate says afterwards inherit that picker and
        # hides exactly the defect this rule exists to catch.
        answered_picker = any(r.get("tool_use_id") in ask_ids for r in results)
        if not results or answered_picker:
            groups.append(cur); cur = {"ask": False, "text": []}
    elif t == "assistant":
        for c in o.get("message", {}).get("content", []):
            if c.get("type") == "tool_use" and c.get("name") == "AskUserQuestion":
                cur["ask"] = True
                ask_ids.add(c.get("id"))
            elif c.get("type") == "text" and c.get("text", "").strip():
                cur["text"].append(c["text"])
groups.append(cur)

orphan = []
for g in groups:
    if g["ask"]:
        continue
    for ln in "\n".join(g["text"]).splitlines():
        ln = ln.strip()
        if (ln.endswith("?") and not ln.startswith(">")
                and "want to look at" not in ln          # the close is not an ask
                and "like to clarify" not in ln):        # nor is reopening the floor
            orphan.append(ln[:88])
emit("R7 asks-carry-options", "FAIL" if orphan else "PASS",
     f"{len(orphan)} ask(s) in a turn with no picker: {orphan}" if orphan
     else f"{len(qs)} ask(s), every asking turn called AskUserQuestion")

print()
print("Judgment, not gradeable here — read the transcript:")
print("  - was the keyword taught on first use?")
print("  - did a question typed mid-round reopen the discussion, then return to the route?")
print("  - does the round read as an exam? That one is Daniel's and nobody else's.")
PYEOF
