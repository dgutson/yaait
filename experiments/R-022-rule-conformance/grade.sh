#!/bin/bash
# Grades one DESIGN.md on the five rules R-022 tracks, plus mmdc.
# Prints rule, verdict, and the evidence line so nothing is taken on trust.
F="$1"; TAG="$2"; W=$(mktemp -d)
echo "===== $TAG : $F ====="

# R1 — a namespace must not share a class name (mmdc render catches it; also checked textually)
NS=$(grep -oP '^\s*namespace \K.+?(?= *\{)' "$F" | sed 's/ *$//' | sort -u)
CL=$(grep -oP '^\s*class \K\w+' "$F" | sort -u)
COLL=$(comm -12 <(echo "$NS"|sort -u) <(echo "$CL"|sort -u))
if   [ -z "$NS" ];   then echo "R1 namespace-vs-class      n/a    no namespace in any diagram"
elif [ -z "$COLL" ]; then echo "R1 namespace-vs-class      PASS   namespaces: $(echo $NS | tr '\n' ' ')"
else                      echo "R1 namespace-vs-class      FAIL   collides: $COLL"; fi

# R2 — one shape per kind of participant: players must not be drawn as a component box
BAD=$(grep -nP '^\s*participant \w+ as (Beto|Caro|Dani|Ana)\b' "$F")
[ -z "$BAD" ] && echo "R2 participant-shape       PASS   no player drawn as a bare participant" \
              || echo "R2 participant-shape       FAIL   $BAD"

# R3 — the spec's word survives, in public AND private members
LEAK=$(grep -n 'by_code\|find(code)\|(code)' "$F" | grep -v join_code)
USES=$(grep -c 'join_code' "$F")
[ -z "$LEAK" ] && echo "R3 spec-word join_code     PASS   $USES uses, no bare 'code' leak" \
               || echo "R3 spec-word join_code     FAIL   $USES uses, leaks: $LEAK"

# R4 — a coined term states its range NEAR the word, not somewhere in the file.
# Whitespace-collapsed over the whole document, because the statement wraps across lines:
# a per-line window reported a false FAIL on a design that did state the range.
R4=$(python3 - "$F" <<'PYEOF'
import re,sys
t=re.sub(r'\s+',' ',open(sys.argv[1]).read())
need=("WAITING","PLACEMENT","FIRING","ENDED")
for m in re.finditer(r'phase', t):
    w=t[m.end():m.end()+110]
    if all(n in w for n in need):
        print("PASS   "+t[max(0,m.start()-12):m.end()+95]); break
else:
    print("FAIL   no 'phase' has the full range within 110 chars after it")
PYEOF
)
echo "R4 coined-term-range       $R4"

# R5 — no semicolons inside mermaid blocks
SEMI=$(awk '/^```mermaid/{f=1} /^```$/{f=0} f && /;/ {print}' "$F")
[ -z "$SEMI" ] && echo "R5 no-semicolons           PASS" \
               || echo "R5 no-semicolons           FAIL   $(wc -l <<<"$SEMI") label(s)"

# mmdc — does every block render, and does the state diagram build only the states written?
( cd "$W" && mmdc -i "$F" -o d.svg > o.txt 2> e.txt )
EX=$?; NB=$(grep -c '✅' "$W/o.txt" 2>/dev/null); TOT=$(grep -c '^```mermaid' "$F")
echo "mmdc                       exit=$EX  rendered $NB of $TOT  stderr=$(wc -c < "$W/e.txt")B"
for f in "$W"/d-*.svg; do
  [ -f "$f" ] || continue
  n=$(grep -o 'id="my-svg-state-[^"]*"' "$f" 2>/dev/null | sort -u | wc -l)
  [ "$n" -gt 0 ] && echo "   state diagram built $n distinct states: $(grep -o 'id="my-svg-state-[^"]*"' "$f" | sed 's/.*state-//;s/-[0-9]*"$//' | sort -u | tr '\n' ' ')"
done
echo "Produced by:               $(grep -m1 '^Produced by:' "$F" || echo '(absent)')"
rm -rf "$W"; echo
