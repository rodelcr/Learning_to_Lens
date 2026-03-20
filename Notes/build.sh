#!/bin/bash
# =============================================================================
# build.sh — Compile Learning to Lens LaTeX notes
# =============================================================================
# Produces PDFs in the Output/ directory:
#   1. Learning_to_Lens.pdf           — Student, local file:// links
#   2. Learning_to_Lens_Solutions.pdf  — Instructor, local file:// links
#   3. Learning_to_Lens_Web.pdf            — Student, GitHub links (for website)
#   4. Learning_to_Lens_Solutions_Web.pdf  — Instructor, GitHub links
#
# Local links open .nb/.wl files directly in Mathematica on this machine.
# GitHub links work from the website or anywhere else.
#
# To change the local repo path, edit \localrepo in preamble.tex.
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

# ---- Local links (file:// — opens files on this machine) ----
echo "=== Building Student Edition (local links) ==="
pdflatex -interaction=nonstopmode main.tex > /dev/null 2>&1
pdflatex -interaction=nonstopmode main.tex > /dev/null 2>&1
cp main.pdf "$OUTDIR/Learning_to_Lens.pdf"
echo "  -> $OUTDIR/Learning_to_Lens.pdf"

echo "=== Building Instructor Edition (local links) ==="
pdflatex -interaction=nonstopmode "\def\showsolutions{}\input{main.tex}" > /dev/null 2>&1
pdflatex -interaction=nonstopmode "\def\showsolutions{}\input{main.tex}" > /dev/null 2>&1
cp main.pdf "$OUTDIR/Learning_to_Lens_Solutions.pdf"
echo "  -> $OUTDIR/Learning_to_Lens_Solutions.pdf"

# ---- GitHub links (for website / sharing) ----
echo "=== Building Student Edition (GitHub links) ==="
pdflatex -interaction=nonstopmode "\def\githublinks{}\input{main.tex}" > /dev/null 2>&1
pdflatex -interaction=nonstopmode "\def\githublinks{}\input{main.tex}" > /dev/null 2>&1
cp main.pdf "$OUTDIR/Learning_to_Lens_Web.pdf"
echo "  -> $OUTDIR/Learning_to_Lens_Web.pdf"

echo "=== Building Instructor Edition (GitHub links) ==="
pdflatex -interaction=nonstopmode "\def\showsolutions{}\def\githublinks{}\input{main.tex}" > /dev/null 2>&1
pdflatex -interaction=nonstopmode "\def\showsolutions{}\def\githublinks{}\input{main.tex}" > /dev/null 2>&1
cp main.pdf "$OUTDIR/Learning_to_Lens_Solutions_Web.pdf"
echo "  -> $OUTDIR/Learning_to_Lens_Solutions_Web.pdf"

# ---- Keep main.pdf as the local student version ----
cp "$OUTDIR/Learning_to_Lens.pdf" main.pdf

# ---- Report ----
STUDENT_PAGES=$(pdfinfo "$OUTDIR/Learning_to_Lens.pdf" 2>/dev/null | grep Pages | awk '{print $2}' || echo "?")
INSTRUCTOR_PAGES=$(pdfinfo "$OUTDIR/Learning_to_Lens_Solutions.pdf" 2>/dev/null | grep Pages | awk '{print $2}' || echo "?")

echo ""
echo "=== Build complete ==="
echo "  Student (local):      $OUTDIR/Learning_to_Lens.pdf ($STUDENT_PAGES pages)"
echo "  Instructor (local):   $OUTDIR/Learning_to_Lens_Solutions.pdf ($INSTRUCTOR_PAGES pages)"
echo "  Student (web):        $OUTDIR/Learning_to_Lens_Web.pdf"
echo "  Instructor (web):     $OUTDIR/Learning_to_Lens_Solutions_Web.pdf"
echo ""
echo "  Local: click links to open .nb/.wl files in Mathematica"
echo "  Web:   links go to GitHub (for rodelcr.github.io)"
