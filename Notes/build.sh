#!/bin/bash
# =============================================================================
# build.sh — Compile Learning to Lens LaTeX notes (four versions)
# =============================================================================
# Produces PDFs in the Output/ directory:
#   1. Learning_to_Lens.pdf                — Student, local links (open files)
#   2. Learning_to_Lens_Solutions.pdf      — Instructor, local links
#   3. Learning_to_Lens_Web.pdf            — Student, GitHub links (for website)
#   4. Learning_to_Lens_Solutions_Web.pdf  — Instructor, GitHub links
#
# Usage: cd Notes && bash build.sh
# Or:    bash Notes/build.sh (from repo root)
# =============================================================================

set -e

# Navigate to Notes directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

OUTDIR="../Output"
mkdir -p "$OUTDIR"

# Check for pdflatex
if ! command -v pdflatex &> /dev/null; then
    echo "Error: pdflatex not found. Install a TeX distribution (e.g., MacTeX)."
    exit 1
fi

# ---- Version 1: Student Edition, local links (default) ----
echo "=== Building Student Edition (local links) ==="
pdflatex -interaction=nonstopmode main.tex > /dev/null 2>&1
pdflatex -interaction=nonstopmode main.tex > /dev/null 2>&1
cp main.pdf "$OUTDIR/Learning_to_Lens.pdf"
echo "  -> $OUTDIR/Learning_to_Lens.pdf"

# ---- Version 2: Instructor Edition, local links ----
echo "=== Building Instructor Edition (local links) ==="
pdflatex -interaction=nonstopmode "\def\showsolutions{}\input{main.tex}" > /dev/null 2>&1
pdflatex -interaction=nonstopmode "\def\showsolutions{}\input{main.tex}" > /dev/null 2>&1
cp main.pdf "$OUTDIR/Learning_to_Lens_Solutions.pdf"
echo "  -> $OUTDIR/Learning_to_Lens_Solutions.pdf"

# ---- Version 3: Student Edition, GitHub links (for website) ----
echo "=== Building Student Edition (GitHub links, for web) ==="
pdflatex -interaction=nonstopmode "\def\githublinks{}\input{main.tex}" > /dev/null 2>&1
pdflatex -interaction=nonstopmode "\def\githublinks{}\input{main.tex}" > /dev/null 2>&1
cp main.pdf "$OUTDIR/Learning_to_Lens_Web.pdf"
echo "  -> $OUTDIR/Learning_to_Lens_Web.pdf"

# ---- Version 4: Instructor Edition, GitHub links (for website) ----
echo "=== Building Instructor Edition (GitHub links, for web) ==="
pdflatex -interaction=nonstopmode "\def\showsolutions{}\def\githublinks{}\input{main.tex}" > /dev/null 2>&1
pdflatex -interaction=nonstopmode "\def\showsolutions{}\def\githublinks{}\input{main.tex}" > /dev/null 2>&1
cp main.pdf "$OUTDIR/Learning_to_Lens_Solutions_Web.pdf"
echo "  -> $OUTDIR/Learning_to_Lens_Solutions_Web.pdf"

# ---- Cleanup: keep main.pdf as the local student version ----
cp "$OUTDIR/Learning_to_Lens.pdf" main.pdf

# ---- Report ----
STUDENT_PAGES=$(pdfinfo "$OUTDIR/Learning_to_Lens.pdf" 2>/dev/null | grep Pages | awk '{print $2}' || echo "?")
INSTRUCTOR_PAGES=$(pdfinfo "$OUTDIR/Learning_to_Lens_Solutions.pdf" 2>/dev/null | grep Pages | awk '{print $2}' || echo "?")

echo ""
echo "=== Build complete ==="
echo "  Student edition (local):      $OUTDIR/Learning_to_Lens.pdf ($STUDENT_PAGES pages)"
echo "  Instructor edition (local):   $OUTDIR/Learning_to_Lens_Solutions.pdf ($INSTRUCTOR_PAGES pages)"
echo "  Student edition (web):        $OUTDIR/Learning_to_Lens_Web.pdf"
echo "  Instructor edition (web):     $OUTDIR/Learning_to_Lens_Solutions_Web.pdf"
echo ""
echo "  Local versions:  links open files on your machine (run: protocol)"
echo "  Web versions:    links go to GitHub (for rodelcr.github.io)"
