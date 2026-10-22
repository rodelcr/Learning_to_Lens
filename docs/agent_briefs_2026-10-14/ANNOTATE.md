# Annotation-layer brief (read COMMON.md first)

## Goal
Add the **Annotated Study Edition** layer to existing modules of Learning to Lens WITHOUT
changing a single visible token of the student or instructor editions. The annotated edition
is for a reader who wants to *learn* the material deeply enough to do compound-lens (DSPL +
central point mass) research afterwards: it supplies the steps the chapter and its solutions
skip, the intuition, the sign/unit traps, and forward links to Part V where the result is used.

## Two depth levels (your task says which modules get which)
- **DEEP** (modules 01d–09): in `<NN>_<Name>.tex` AND `<NN>_Solutions.tex`:
  * `derivation` boxes after every "it can be shown", "one finds", "after some algebra", or any
    equation whose derivation from the previous one takes more than two lines — write the
    missing lines out, every one, with the rule used named in words.
  * `annotation` boxes: physical meaning, why this definition, units/dimensions check, sign
    convention (reduced vs physical deflection, D_ds ≠ D_s − D_d, λ_r vs λ_t, parity), the
    classic student error, how to sanity-check the result numerically.
  * `bridge` boxes (2–5 per module): "Where this is used in Part V" — name the chapter by
    `Chapter~\ref{ch:...}` (labels in COMMON.md §5) and say in one or two sentences what the
    compound-lens problem needs from this result (e.g. Ch. 7 → the DSPL ratio B is a ratio of
    four angular-diameter distances; Ch. 9 → the radial critical curve λ_r = 0 is where a
    central point mass acts; Ch. 10 → Burke's theorem needs smooth Σ, a point mass punctures it;
    Ch. 11 NIS core → radial images; Ch. 12 SIE → the Einstein-radius ratio is independent of
    ellipticity; Ch. 13 MST → survives a second source plane).
  * In `_Solutions.tex`: `derivation` boxes expanding every skipped step; `annotation` boxes on
    alternative routes and checks.
- **LIGHT** (modules 01a–01c, 10–13): `_Solutions.tex` only — `derivation` boxes expanding
  skipped steps; optionally one `bridge` per module.

## Hard rules
1. **Zero visible change outside annotated blocks.** You may only ADD `annotation`/`derivation`/
   `bridge` blocks, `\annot{...}` inline (text mode), and the two display mechanisms
   (R4 in `Notes/editions.tex`). Do not fix prose, typos, or equations you find wrong: list them
   under "Flags for the fact-critic" instead (the orchestrator decides).
   Verify: after `cd Notes && bash build.sh`, the `Learning_to_Lens.pdf` and
   `Learning_to_Lens_Solutions.pdf` lines of `Output/build_fingerprints.txt` must be IDENTICAL
   to `Output/build_fingerprints_phase0.txt`. If they differ, you changed visible content — find
   it (`git diff`) and undo it.
2. **Every numeric claim inside an annotation gets a `check[]`** appended to the module's
   `Solutions/<NN>_*/problems_<NN>.wl` (open the file; add a clearly delimited section
   `(* ===== Annotated-edition checks (2026-10) ===== *)` at the end, `Get` the harness at the
   top of that section if the script does not already define `check`, and call `summary[]`
   only if the script has no other exit; run it with `bash Mathematica/run_wl.sh`). Every
   identity you write in a `derivation` box that is not already verified in the module's
   `.wl` gets a check too. Quote SUMMARY lines.
3. `\label`s inside annotated blocks only if `\ref`'d from annotated blocks (R3); never `\cite`
   a key not in `references.bib`.
4. Placement: boxes between paragraphs only, never inside math/lists/tables/figures; `\end`
   un-indented on its own line.
5. Touch only `Notes/<NN>_*/` and `Solutions/<NN>_*/problems_<NN>.wl` of your modules.

## Acceptance
- `ANNOT_REQUIRED=1 bash build.sh` (from `Notes/`) → "all assertions passed".
- Student + instructor fingerprint lines identical to `Output/build_fingerprints_phase0.txt`.
- `grep -nE '^\s+\\end\{(annotation|derivation|bridge)\}' Notes/<NN>_*/*.tex` empty.
- `.wl` SUMMARY lines quoted; label uniqueness clean; `git status --porcelain` only your files;
  commit on your branch (`git checkout -- Output/` first).
