#!/bin/bash
# =============================================================================
# open_notebook.sh — Quickly open a Mathematica file from this project
# =============================================================================
# Usage:
#   ./open_notebook.sh four_vectors        # opens the .nb matching this name
#   ./open_notebook.sh lorentz_transforms  # opens the .wl matching this name
#   ./open_notebook.sh 01a                 # opens all files in Module 01a
#   ./open_notebook.sh                     # lists all available files
# =============================================================================

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$1" ]; then
    echo "Available Mathematica files:"
    echo ""
    echo "=== Scripts (.wl) ==="
    find "$REPO_DIR/Mathematica" -name "*.wl" | sort | while read f; do
        echo "  $(basename "$f" .wl)"
    done
    echo ""
    echo "=== Notebooks (.nb) ==="
    find "$REPO_DIR/Mathematica" -name "*.nb" | sort | while read f; do
        echo "  $(basename "$f" .nb)"
    done
    echo ""
    echo "Usage: ./open_notebook.sh <name>"
    exit 0
fi

# Find matching files
MATCHES=$(find "$REPO_DIR/Mathematica" "$REPO_DIR/Solutions" -name "*$1*" -type f 2>/dev/null)

if [ -z "$MATCHES" ]; then
    echo "No files matching '$1' found."
    exit 1
fi

COUNT=$(echo "$MATCHES" | wc -l | tr -d ' ')
echo "Opening $COUNT file(s) matching '$1':"
echo "$MATCHES" | while read f; do
    echo "  $(basename "$f")"
    open "$f"
done
