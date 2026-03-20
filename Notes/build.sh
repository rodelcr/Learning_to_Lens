#!/bin/bash
# =============================================================================
# build.sh — Compile Learning to Lens LaTeX notes (two versions)
# =============================================================================
# Produces two PDFs in the Output/ directory:
#   1. Learning_to_Lens.pdf           — Student edition (no solutions)
#   2. Learning_to_Lens_Solutions.pdf  — Instructor edition (with solutions)
#
# All Mathematica file links point to the GitHub repository.
# To open files locally, use: ./open_notebook.sh <name>
#
# Usage: cd Notes && bash build.sh
# Or:    bash Notes/build.sh (from repo root)
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

OUTDIR="../Output"
mkdir -p "$OUTDIR"

if ! command -v pdflatex &> /dev/null; then
    echo "Error: pdflatex not found. Install a TeX distribution (e.g., MacTeX)."
    exit 1
fi

# ---- Version 1: Student Edition (no solutions) ----
echo "=== Building Student Edition (no solutions) ==="
pdflatex -interaction=nonstopmode main.tex > /dev/null 2>&1
pdflatex -interaction=nonstopmode main.tex > /dev/null 2>&1
cp main.pdf "$OUTDIR/Learning_to_Lens.pdf"
echo "  -> $OUTDIR/Learning_to_Lens.pdf"

# ---- Version 2: Instructor Edition (with solutions) ----
echo "=== Building Instructor Edition (with solutions) ==="
pdflatex -interaction=nonstopmode "\def\showsolutions{}\input{main.tex}" > /dev/null 2>&1
pdflatex -interaction=nonstopmode "\def\showsolutions{}\input{main.tex}" > /dev/null 2>&1
cp main.pdf "$OUTDIR/Learning_to_Lens_Solutions.pdf"
echo "  -> $OUTDIR/Learning_to_Lens_Solutions.pdf"

# ---- Cleanup ----
cp "$OUTDIR/Learning_to_Lens.pdf" main.pdf
rm -f "$OUTDIR/Learning_to_Lens_Web.pdf" "$OUTDIR/Learning_to_Lens_Solutions_Web.pdf" 2>/dev/null

# ---- Report ----
STUDENT_PAGES=$(pdfinfo "$OUTDIR/Learning_to_Lens.pdf" 2>/dev/null | grep Pages | awk '{print $2}' || echo "?")
INSTRUCTOR_PAGES=$(pdfinfo "$OUTDIR/Learning_to_Lens_Solutions.pdf" 2>/dev/null | grep Pages | awk '{print $2}' || echo "?")

echo ""
echo "=== Build complete ==="
echo "  Student edition:    $OUTDIR/Learning_to_Lens.pdf ($STUDENT_PAGES pages)"
echo "  Instructor edition: $OUTDIR/Learning_to_Lens_Solutions.pdf ($INSTRUCTOR_PAGES pages)"
