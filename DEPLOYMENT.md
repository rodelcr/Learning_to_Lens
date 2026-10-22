# Deployment Notes — Learning to Lens

Steps for updating and publishing the tutorial PDFs.

## Building the PDFs

```bash
cd Notes && bash build.sh
```

This produces three files in `Output/`:
- `Learning_to_Lens.pdf` — Student edition (no solutions)
- `Learning_to_Lens_Solutions.pdf` — Instructor edition (with solutions)
- `Learning_to_Lens_Annotated.pdf` — Annotated Study Edition (solutions + annotation layer)

The build script runs `pdflatex` twice for each edition (for cross-references).
The solutions toggle works via `\def\showsolutions{}` passed at compile time; the Annotated Study Edition adds `\def\showannotated{}` (see `Notes/editions.tex`). `build.sh` now produces three PDFs — `Learning_to_Lens.pdf`, `Learning_to_Lens_Solutions.pdf`, `Learning_to_Lens_Annotated.pdf` — and exits non-zero if any integrity assertion fails.

## Publishing to GitHub Pages (rodelcr.github.io)

The PDFs are hosted at:
- https://rodelcr.github.io/assets/pdf/Learning_to_Lens.pdf
- https://rodelcr.github.io/assets/pdf/Learning_to_Lens_Solutions.pdf
- https://rodelcr.github.io/assets/pdf/Learning_to_Lens_Annotated.pdf

To update after rebuilding:

```bash
# 1. Use the existing clone (pull first)
cd ~/rodelcr.github.io && git pull --ff-only

# 2. Copy the updated PDFs (all three editions)
cp /Users/rosador/Documents/Learning_to_Lens/Output/Learning_to_Lens.pdf assets/pdf/
cp /Users/rosador/Documents/Learning_to_Lens/Output/Learning_to_Lens_Solutions.pdf assets/pdf/
cp /Users/rosador/Documents/Learning_to_Lens/Output/Learning_to_Lens_Annotated.pdf assets/pdf/

# 3. Commit and push
git add assets/pdf/Learning_to_Lens*.pdf
git commit -m "Update Learning to Lens PDFs"
git push

# 4. Verify page counts match Output/build_fingerprints.txt
for f in assets/pdf/Learning_to_Lens*.pdf; do pdfinfo "$f" | grep Pages; done
```

GitHub Pages will rebuild automatically after the push (usually takes 1-2 minutes).

## Publishing to the Learning_to_Lens repo

The PDFs are also tracked in the `Output/` directory of the main repo:

```bash
cd /Users/rosador/Documents/Learning_to_Lens
git add Output/Learning_to_Lens.pdf Output/Learning_to_Lens_Solutions.pdf Output/Learning_to_Lens_Annotated.pdf
git commit -m "Update compiled PDFs"
git push
```

## Checklist for Updates

When making content changes:

1. Edit the `.tex` files in `Notes/`
2. If adding new Mathematica figures: run the `.wl` script via `wolframscript`
3. Build: `cd Notes && bash build.sh`
4. Verify: check `Output/` PDFs for correct page counts and rendering
5. Commit to Learning_to_Lens repo
6. Copy PDFs to rodelcr.github.io `assets/pdf/` and push
7. Update `PROGRESS_LOG.md` with what changed
