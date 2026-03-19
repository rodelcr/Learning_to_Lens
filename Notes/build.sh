#!/bin/bash
# =============================================================================
# build.sh — Compile Learning to Lens LaTeX notes
# =============================================================================
# Usage: cd Notes && bash build.sh
# Or:    bash Notes/build.sh (from repo root)
# =============================================================================

set -e

# Navigate to Notes directory (works whether called from Notes/ or repo root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Building Learning to Lens notes ==="
echo "Working directory: $(pwd)"

# Check for pdflatex
if ! command -v pdflatex &> /dev/null; then
    echo "Error: pdflatex not found. Install a TeX distribution (e.g., MacTeX)."
    exit 1
fi

# Run pdflatex twice (for TOC and cross-references)
echo "--- Pass 1/2 ---"
pdflatex -interaction=nonstopmode main.tex

echo "--- Pass 2/2 ---"
pdflatex -interaction=nonstopmode main.tex

# If bibtex is needed (uncomment when bibliography is added)
# bibtex main
# pdflatex -interaction=nonstopmode main.tex
# pdflatex -interaction=nonstopmode main.tex

echo "=== Build complete: main.pdf ==="
echo "Output: $SCRIPT_DIR/main.pdf"
