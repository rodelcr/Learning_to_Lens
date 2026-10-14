#!/bin/bash
# =============================================================================
# run_wl.sh — run `wolframscript -file <script>` through a 3-slot semaphore
# =============================================================================
# Never run more than 3 Mathematica kernels at once on this machine: a fourth
# tends to hang (see feedback memory / VERIFICATION.md). Every agent and sweep
# must launch wolframscript through this wrapper so the cap holds machine-wide.
#
# Usage:  bash Mathematica/run_wl.sh path/to/script.wl [more wolframscript args]
# Exit status = wolframscript's exit status. Slots: /tmp/ltl_wls_slot{1,2,3}
# (mkdir is atomic; a slot whose owner PID is dead is reclaimed).
# =============================================================================
set -u
SLOTS=3
slot=""
while [ -z "$slot" ]; do
  for i in $(seq 1 $SLOTS); do
    d="/tmp/ltl_wls_slot$i"
    if mkdir "$d" 2>/dev/null; then echo $$ > "$d/pid"; slot="$d"; break; fi
    # reclaim a stale slot
    if [ -f "$d/pid" ] && ! kill -0 "$(cat "$d/pid" 2>/dev/null)" 2>/dev/null; then
      rm -rf "$d"
    fi
  done
  [ -z "$slot" ] && sleep 5
done
trap 'rm -rf "$slot"' EXIT INT TERM
wolframscript -file "$@"
