#!/bin/bash
# Grades one review round on the rules Step 6 states mechanically.
# Two inputs, because they answer different questions:
#   $1  picker-payloads.jsonl  — what the gate WROTE (PreToolUse hook on AskUserQuestion)
#   $2  screen.txt             — what the user SAW (tmux capture-pane)
#   $3  label
# A rule that fails in the payload is an authoring defect. A rule that passes in the
# payload and fails on screen is a rendering defect. That distinction is the whole
# reason the hook exists: 0.18.0 took two releases because nobody could tell them apart.
#
# Judgment checks are deliberately NOT here — whether stops arrive batched, whether the
# keyword was taught on first use, whether a mid-round question reopened the discussion,
# and whether the round reads as an exam. Those go in prose.

PAY="$1"; SCR="$2"; TAG="$3"; W="${4:-0}"
[ -z "$PAY" ] && { echo "usage: $0 <payloads.jsonl> <screen.txt> <label> <pane_width>"; exit 2; }
echo "===== $TAG ====="
echo "payloads: $PAY    screen: $SCR"

if [ ! -s "$PAY" ]; then
  echo "P0 picker-used              FAIL   no payloads: AskUserQuestion never fired."
  echo "                                   Either the hook did not attach, or the gate"
  echo "                                   rendered its options as prose. Check the screen"
  echo "                                   by hand before concluding which."
  PAY=/dev/null
else
  echo "P0 picker-used              PASS   $(grep -c . "$PAY") AskUserQuestion call(s) captured"
fi

python3 - "$PAY" "$SCR" "$W" <<'PYEOF'
import json, sys, re, os

pay_path, scr_path = sys.argv[1], sys.argv[2]
pane_w = int(sys.argv[3]) if len(sys.argv) > 3 else 0
KINDS = ("Reviewing", "Deciding", "Checking", "Challenging")

qs = []
try:
    for line in open(pay_path):
        line = line.strip()
        if not line:
            continue
        try:
            obj = json.loads(line)
        except json.JSONDecodeError:
            continue
        ti = obj.get("tool_input") or obj.get("toolInput") or obj
        for q in (ti.get("questions") or []):
            qs.append(q)
except FileNotFoundError:
    pass

screen = open(scr_path, encoding="utf-8", errors="replace").read() if os.path.exists(scr_path) else ""

def emit(rule, verdict, ev):
    print(f"{rule:<27} {verdict:<6} {ev}")

# ---- R1  the kind keyword opens the question TEXT --------------------------------
# METHODOLOGY.md: "The keyword goes at the front of the question text, never in a
# picker's header." A header holds ~12 chars; forced to choose, a run keeps the
# identifier and the kind vanishes silently.
if not qs:
    emit("R1 keyword-opens-question", "n/a", "no payload to check")
else:
    bad = [q.get("question", "")[:60] for q in qs
           if not re.match(r"\s*(%s)\s*[—-]" % "|".join(KINDS), q.get("question", ""))]
    if bad:
        emit("R1 keyword-opens-question", "FAIL", f"{len(bad)}/{len(qs)} lack a leading kind: {bad}")
    else:
        emit("R1 keyword-opens-question", "PASS", f"all {len(qs)} open with a kind keyword")

# ---- R2  the keyword is NOT hiding in the header ---------------------------------
if not qs:
    emit("R2 keyword-not-in-header", "n/a", "no payload to check")
else:
    hdr = [q.get("header", "") for q in qs if any(k in q.get("header", "") for k in KINDS)]
    if hdr:
        emit("R2 keyword-not-in-header", "FAIL", f"kind found in header(s): {hdr}")
    else:
        emit("R2 keyword-not-in-header", "PASS",
             f"headers carry the anchor only: {[q.get('header','') for q in qs]}")

# ---- R2b  the keyword actually SURVIVED to the screen ----------------------------
if not qs:
    emit("R2b keyword-rendered", "n/a", "no payload to check")
elif not screen:
    emit("R2b keyword-rendered", "n/a", "no screen capture supplied")
else:
    lost = [k for k in KINDS
            if any(q.get("question", "").lstrip().startswith(k) for q in qs)
            and k not in screen]
    if lost:
        emit("R2b keyword-rendered", "FAIL",
             f"written but absent from the rendered screen: {lost} — RENDERING defect")
    else:
        emit("R2b keyword-rendered", "PASS", "every written keyword appears on screen")

# ---- R3  the forbidden option wording --------------------------------------------
# "Never word this as 'record as debt and move on': that asks the user to volunteer
# that they are the source of a debt they did not create."
labels = [o.get("label", "") for q in qs for o in (q.get("options") or [])]
hay = " || ".join(labels) + " || " + screen
m = re.findall(r"[Rr]ecord as debt[^|\n]*", hay)
if m:
    emit("R3 no-record-as-debt", "FAIL", f"forbidden wording present: {sorted(set(m))}")
else:
    emit("R3 no-record-as-debt", "PASS", "absent from options and screen")

# ---- R4a  option shape: fork branches, or the fixed set -------------------------
# "Where the stop has a real fork, the branches of that fork ARE the options. Where it
# does not:" then the fixed four. An earlier version of this script demanded the fixed
# set unconditionally and would have reported a false FAIL on a compliant run.
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
    if shortfall:
        emit("R4a option-shape", "FAIL", f"forkless stop(s) missing fixed options: {shortfall}")
    else:
        emit("R4a option-shape", "PASS",
             f"{' '.join(detail)} — where a fork exists its branches are the options")

    # ---- R4b  "Offer to teach the underlying concepts, by name, at every stop." ----
    none_ = [q.get("header", "?") for q in qs
             if not any(o.get("label", "").lower().startswith("explain")
                        for o in (q.get("options") or []))]
    if none_:
        emit("R4b explain-every-stop", "FAIL",
             f"{len(none_)}/{len(qs)} stops offer no 'Explain <concept>': {none_}")
    else:
        emit("R4b explain-every-stop", "PASS", f"all {len(qs)} stops name a concept: {explains}")

# ---- R5  no generic "I'll explain it" beside named concepts ----------------------
# "Drop a generic 'I'll explain it' wherever named concept options exist."
if not qs:
    emit("R5 no-generic-explain", "n/a", "no payload to check")
else:
    generic = [l for l in labels
               if re.fullmatch(r"\s*(I'?ll explain( it)?|Explain( it| this)?)\s*", l, re.I)]
    if generic and explains:
        emit("R5 no-generic-explain", "FAIL", f"generic beside named concepts: {generic}")
    else:
        emit("R5 no-generic-explain", "PASS", "no generic explain option")

# ---- R6  four lines per stop, hard ----------------------------------------------
# 0.20.1 made the cap self-consistent; before that the same section said three.
if not screen:
    emit("R6 four-line-cap", "n/a", "no screen capture supplied")
else:
    # De-wrap first. A tmux capture is hard-wrapped at the pane width, so counting
    # captured lines counts wrapping, not the four things a stop is made of. R-022's
    # recorded history is a per-line window reporting a false FAIL for exactly this
    # reason, and the first version of this check repeated it: it called a compliant
    # four-line stop an eleven-line one.
    # The pane width must be SUPPLIED, never inferred from the longest line: on prose
    # that is not actually wrapped, max-line-length is just the longest sentence, and
    # joining on it silently merges independent lines. That inference turned a genuine
    # six-line stop into a PASS while this script was being written.
    if pane_w > 0:
        raw = screen.splitlines()
        unwrapped = []
        for l in raw:
            if (unwrapped and l.strip() and unwrapped[-1].strip()
                    and len(unwrapped[-1].rstrip()) >= pane_w - 3):
                unwrapped[-1] = unwrapped[-1].rstrip() + " " + l.strip()
            else:
                unwrapped.append(l)
        screen = "\n".join(unwrapped)

    stops = re.split(r"(?m)^(?=\s*(?:[-*]\s*)?\*{0,2}(?:%s)\b)" % "|".join(KINDS), screen)
    stops = [s for s in stops if re.match(r"\s*(?:[-*]\s*)?\*{0,2}(?:%s)\b" % "|".join(KINDS), s)]
    if not stops:
        emit("R6 four-line-cap", "n/a", "no stop-shaped blocks found in the capture")
    else:
        over = []
        for s in stops:
            body = [ln for ln in s.strip().splitlines() if ln.strip()]
            # stop at the next UI chrome / separator the TUI draws
            cut = next((i for i, ln in enumerate(body) if re.match(r"^\s*[─━=]{10,}", ln)), len(body))
            n = len(body[:cut])
            if n > 4:
                over.append((body[0].strip()[:48], n))
        warn = "" if pane_w > 0 else \
            "  [NO PANE WIDTH GIVEN — these are raw captured lines, so wrapped prose " \
            "over-counts; re-run with the width as argument 4 before filing this]"
        if over:
            emit("R6 four-line-cap", "FAIL",
                 f"{len(over)}/{len(stops)} stops over four lines: {over}{warn}")
        else:
            emit("R6 four-line-cap", "PASS", f"all {len(stops)} stops within four lines")

print()
print("Judgment, not gradeable here — read the transcript:")
print("  - did the stops arrive spread out, or as one block of four labelled asks?")
print("  - was the keyword taught on first use?")
print("  - did a question typed mid-round reopen the discussion, then return to the route?")
print("  - does the round read as an exam? That one is Daniel's and nobody else's.")
PYEOF
