#!/usr/bin/env bash
# style_lint.sh — count LLM-prose tells in .tex files (see Notes/STYLE.md).
# Usage: bash Notes/style_lint.sh FILE.tex [FILE.tex ...]     (one row per file + TOTAL)
#        bash Notes/style_lint.sh --all                        (every chapter + solutions file)
# Columns: dash = "---" occurrences; bold = \textbf in running text; lead = "\textbf{...}:"
# paragraph lead-ins; item = itemize/enumerate environments; words = tell phrases
# (Let's/Note that/Importantly/elegant/key insight/simply/...); bang = "!" outside math/macros;
# per_k = (dash+lead+words+bang) per 1000 words of detex'd prose.
# Comment lines are ignored. Pure count; interpretation is in STYLE.md.
set -u
here="$(cd "$(dirname "$0")" && pwd)"
PHRASES="Let's|Let us|let us|Note that|Notice that|It is worth|worth noting|Importantly|Crucially|crucial|Remarkably|remarkabl|elegant|beautiful|profound|deep connection|key insight|Key insight|takeaway|punchline|In other words|Put differently|That is to say|Physically,|Intuitively,|Geometrically,|[Ss]anity check|simply|essentially|basically|merely|This means that|This tells us|not just|Why this matters|What this means|bottom line|boils down|Think of|\\byou\\b|\\byour\\b|striking|powerful"
files=()
if [[ "${1:-}" == "--all" ]]; then
  for f in "$here"/[0-9]*/[0-9]*.tex; do files+=("$f"); done
else
  files=("$@")
fi
printf "%-34s %5s %5s %5s %5s %5s %5s %6s %6s\n" file dash bold lead item words bang nwords per_k
td=0; tb=0; tl=0; ti=0; tw=0; tg=0; tn=0
for f in "${files[@]}"; do
  body=$(grep -v '^[[:space:]]*%' "$f")
  d=$(printf '%s' "$body" | grep -o -- '---' | grep -c .)
  b=$(printf '%s' "$body" | grep -o '\\textbf{' | grep -c .)
  l=$(printf '%s' "$body" | grep -c '\\textbf{[^}]*}[:.]')
  i=$(printf '%s' "$body" | grep -c '\\begin{itemize}\|\\begin{enumerate}')
  w=$(printf '%s' "$body" | grep -o -E "$PHRASES" | grep -c .)
  g=$(printf '%s' "$body" | sed 's/\$[^$]*\$//g' | grep -o '[^\\]![^=]' | grep -c .)
  n=$(printf '%s' "$body" | detex 2>/dev/null | wc -w | tr -d ' ')
  [[ "$n" -eq 0 ]] && n=1
  k=$(python3 -c "print(round(($d+$l+$w+$g)/$n*1000,1))")
  printf "%-34s %5s %5s %5s %5s %5s %5s %6s %6s\n" "$(basename "$f" .tex)" "$d" "$b" "$l" "$i" "$w" "$g" "$n" "$k"
  td=$((td+d)); tb=$((tb+b)); tl=$((tl+l)); ti=$((ti+i)); tw=$((tw+w)); tg=$((tg+g)); tn=$((tn+n))
done
k=$(python3 -c "print(round(($td+$tl+$tw+$tg)/max($tn,1)*1000,1))")
printf "%-34s %5s %5s %5s %5s %5s %5s %6s %6s\n" TOTAL "$td" "$tb" "$tl" "$ti" "$tw" "$tg" "$tn" "$k"
