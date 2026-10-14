#!/bin/bash
# =============================================================================
# build.sh — Compile Learning to Lens LaTeX notes (three editions)
# =============================================================================
# Produces three PDFs in the Output/ directory:
#   1. Learning_to_Lens.pdf            — Student edition (no solutions)
#   2. Learning_to_Lens_Solutions.pdf  — Instructor edition (with solutions)
#   3. Learning_to_Lens_Annotated.pdf  — Annotated Study Edition
#                                        (solutions + annotation/derivation/bridge layer)
#
# After building, the script ASSERTS build integrity (and exits non-zero on
# failure):
#   - no LaTeX errors and no undefined references / citations in main.log
#   - no literal '??' in any PDF's text
#   - page counts: student >= MIN_STUDENT, instructor > student, annotated >= instructor
#   - the annotation sentinels (ANNOTATION / DERIVATION / BRIDGE box titles) are
#     ABSENT from the student and instructor PDFs; with ANNOT_REQUIRED=1 they must
#     be PRESENT in the annotated PDF
#   - writes Output/build_fingerprints.txt (page counts + text-md5 of pages 2..end,
#     page 1 excluded because of \today). Annotation-only commits must leave the
#     student and instructor fingerprints unchanged.
#
# All Mathematica file links point to the GitHub repository.
# To open files locally, use: ./open_notebook.sh <name>
#
# Usage: cd Notes && bash build.sh
#   env: MIN_STUDENT=240 ANNOT_REQUIRED=0   (defaults)
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

OUTDIR="../Output"
mkdir -p "$OUTDIR"
MIN_STUDENT=${MIN_STUDENT:-240}
ANNOT_REQUIRED=${ANNOT_REQUIRED:-0}

if ! command -v pdflatex &> /dev/null; then
    echo "Error: pdflatex not found. Install a TeX distribution (e.g., MacTeX)."
    exit 1
fi

# ---- helpers ----
pages () { pdfinfo "$1" 2>/dev/null | awk '/^Pages:/{print $2}'; }
check_log () {   # $1 = edition name; run right after the final pdflatex of that edition
    if grep -qE "LaTeX Warning: (Reference|Citation) .* undefined|There were undefined references|^! " main.log; then
        echo "ASSERT FAIL ($1): LaTeX errors or undefined references/citations in main.log:"
        grep -nE "LaTeX Warning: (Reference|Citation) .* undefined|There were undefined references|^! " main.log | head -20
        exit 1
    fi
}
sentinels () { pdftotext "$1" - 2>/dev/null | grep -cE "^(ANNOTATION|DERIVATION|BRIDGE)( |$)" || true; }
assert_sentinel () {   # $1 pdf, $2 = 0 | ge1
    local n; n=$(sentinels "$1")
    case "$2" in
        0)   [ "$n" -eq 0 ] || { echo "ASSERT FAIL: $(basename "$1") leaks $n annotation boxes"; exit 1; } ;;
        ge1) [ "$n" -ge 1 ] || { echo "ASSERT FAIL: $(basename "$1") has no annotation boxes"; exit 1; } ;;
    esac
}
build_edition () {   # $1 = label, $2 = pdflatex argument, $3 = output file
    echo "=== Building $1 ==="
    pdflatex -interaction=nonstopmode "$2" > /dev/null 2>&1 || true
    bibtex main > /dev/null 2>&1 || true
    pdflatex -interaction=nonstopmode "$2" > /dev/null 2>&1 || true
    pdflatex -interaction=nonstopmode "$2" > /dev/null 2>&1 || true
    check_log "$1"
    cp main.pdf "$OUTDIR/$3"
    echo "  -> $OUTDIR/$3"
}

# ---- the three editions ----
build_edition "Student Edition (no solutions)"      "main.tex"                                                 "Learning_to_Lens.pdf"
build_edition "Instructor Edition (with solutions)" "\def\showsolutions{}\input{main.tex}"                     "Learning_to_Lens_Solutions.pdf"
build_edition "Annotated Study Edition"             "\def\showsolutions{}\def\showannotated{}\input{main.tex}" "Learning_to_Lens_Annotated.pdf"

# ---- Cleanup ----
cp "$OUTDIR/Learning_to_Lens.pdf" main.pdf
rm -f "$OUTDIR/Learning_to_Lens_Web.pdf" "$OUTDIR/Learning_to_Lens_Solutions_Web.pdf" comment.cut 2>/dev/null

# ---- Assertions ----
S=$(pages "$OUTDIR/Learning_to_Lens.pdf")
I=$(pages "$OUTDIR/Learning_to_Lens_Solutions.pdf")
A=$(pages "$OUTDIR/Learning_to_Lens_Annotated.pdf")
[ "$S" -ge "$MIN_STUDENT" ] || { echo "ASSERT FAIL: student has $S pages (< $MIN_STUDENT)"; exit 1; }
[ "$I" -gt "$S" ]           || { echo "ASSERT FAIL: instructor ($I) not > student ($S)"; exit 1; }
[ "$A" -ge "$I" ]           || { echo "ASSERT FAIL: annotated ($A) not >= instructor ($I)"; exit 1; }
for f in Learning_to_Lens Learning_to_Lens_Solutions Learning_to_Lens_Annotated; do
    n=$(pdftotext "$OUTDIR/$f.pdf" - 2>/dev/null | grep -c '??' || true)
    [ "$n" -eq 0 ] || { echo "ASSERT FAIL: $f.pdf contains $n '??'"; exit 1; }
done
assert_sentinel "$OUTDIR/Learning_to_Lens.pdf" 0
assert_sentinel "$OUTDIR/Learning_to_Lens_Solutions.pdf" 0
if [ "$ANNOT_REQUIRED" = 1 ]; then assert_sentinel "$OUTDIR/Learning_to_Lens_Annotated.pdf" ge1; fi

# ---- Fingerprints + report ----
{
for f in Learning_to_Lens Learning_to_Lens_Solutions Learning_to_Lens_Annotated; do
    printf "%-32s %s pages  text-md5 %s  sentinels %s\n" "$f.pdf" "$(pages "$OUTDIR/$f.pdf")" \
        "$(pdftotext -f 2 "$OUTDIR/$f.pdf" - 2>/dev/null | md5 -q)" "$(sentinels "$OUTDIR/$f.pdf")"
done
} | tee "$OUTDIR/build_fingerprints.txt"

echo ""
echo "=== Build complete: all assertions passed ==="
