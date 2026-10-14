# Common brief — Learning to Lens, Annotated Study Edition + Part V (2026-10-14)

You are one of several Opus agents working in parallel on the LaTeX/Mathematica textbook
**Learning to Lens** (repo root given in your task; it is a git WORKTREE on your own branch).
Read the repo `CLAUDE.md` first. Use the `gr-lensing-intuition` skill (global copy at
`~/.claude/skills/gr-lensing-intuition/`, which has the compound-lens/DSPL section) for physics.

## Non-negotiables
1. **Mathematica is the source of mathematical truth.** Every derivation, identity, closed form
   or number that appears on the page must be verified by a `check[...]` in a `.wl` script run
   via `bash Mathematica/run_wl.sh <script>` (NEVER call `wolframscript` directly — the wrapper
   enforces a machine-wide 3-kernel cap; run your scripts one at a time). Scripts `Get[]` the
   shared harness `Mathematica/harness.wl` (see its header for the exact `Get` path from
   `Mathematica/NN_*/` and from `Solutions/NN_*/`) and end with `summary[]`. Quote the
   `SUMMARY:` line verbatim in your report; never transcribe a count.
2. **No fabricated citations.** Use only `\citep{key}` / `\citet{key}` with keys that exist in
   `Notes/references.bib` (grep it). If you need a key that is not there, DO NOT add it: list
   the paper (authors, year, journal, DOI if you know it, marked UNVERIFIED) in your report and
   write the sentence so it reads correctly without the citation, or cite a book already in the
   bib (SEF 1992 = `schneider_ehlers_falco_1992`, Congdon & Keeton = `congdon_principles_2018`,
   Meneghetti = `meneghetti_introduction_2021`, Petters = `petters_singularity_2001`, Narayan &
   Bartelmann = `narayan_lectures_1997`, Saha+ = `saha_essentials_2024`, Carroll =
   `carroll_spacetime_2004`). Reference PDFs are in `Reference_Texts/` (git-ignored); cite
   equation/section numbers only after checking the PDF (`pdftotext -f N -l M file.pdf -`).
3. **Files you may touch:** only the directories named in your task (`Notes/<NN>_*/`,
   `Mathematica/<NN>_*/`, `Solutions/<NN>_*/`, `Figures/<NN>_*/`). NEVER edit
   `Notes/preamble.tex`, `Notes/main.tex`, `Notes/editions.tex`, `Notes/build.sh`,
   `Notes/references.bib`, `VERIFICATION.md`, `CLAUDE.md`, `PROGRESS_LOG.md`,
   `Mathematica/verify_against_textbooks.wl`, `Mathematica/harness.wl`. Needed macro / bib key /
   master check → put it in your report under "Requests for the orchestrator".
4. **Never commit `Output/*.pdf`** or `Notes/main.*` artefacts. Commit only your own directories
   (`git add Notes/<NN>_* Mathematica/<NN>_* Solutions/<NN>_* Figures/<NN>_*`). After each
   `build.sh` run, `git checkout -- Output/` before committing.
5. **Labels** are namespaced with your prefix (`\label{eq:<pfx>_...}`, `sec:<pfx>_...`,
   `ex:<pfx>_...`, `fig:<pfx>_...`). Check global uniqueness:
   `cat Notes/*/*.tex | grep -o '\\label{[^}]*}' | sort | uniq -d` must print nothing.
   Cross-chapter references INTO Part V use only the chapter labels that already exist in the
   stubs (`ch:multiplane_dspl`, `ch:power_law_point_mass`, `ch:odd_images`, `ch:central_mass_bias`,
   `ch:msd_kinematics`, `ch:multipoles`, `ch:cosmological_sensitivity`,
   `ch:perturbative_estimators`) — never another Part V chapter's equation/section labels
   (they do not exist yet in your worktree and would give `??`). References into Chapters 1–17
   may use any existing label (grep `Notes/*/*.tex`).
6. **Edition rules** (`Notes/editions.tex` header, R1–R5): `annotation`, `derivation`, `bridge`
   boxes are visible ONLY in the Annotated Study Edition; `\begin{...}`/`\end{...}` each alone
   on its own line, `\end` with no leading whitespace; never inside align/equation/tabular/
   itemize; annotated-only prose between align rows = `\ifannotated\intertext{...}\fi`
   immediately after `\\`; annotated-only extra rows = duplicate the whole display inside
   `\ifannotated ... \else ... \fi` with identical labels and `\notag` on extra rows.
   `keybox` and `aside` (GR reminder) are ALWAYS visible (all editions).
7. **Build and verify before reporting.** `cd Notes && bash build.sh` must end with
   "all assertions passed" (it checks: no `??`, no undefined refs/cites, page ordering, no
   annotation leakage). Record the three page counts and `Output/build_fingerprints.txt`.
8. **Figures** (optional, 1–3 per chapter): exported by your `.wl` to `Figures/<NN>_*/`;
   `Superscript[]`/`Subscript[]`/`Row[]` for labels (never unicode escapes);
   `"AllowRasterization"->True, ImageResolution->150` for density plots; create the directory
   before `Export`. Include with `\includegraphics[width=...]{../Figures/<NN>_*/name.pdf}` —
   check how existing chapters do it (`grep includegraphics Notes/07_*/*.tex`).
9. **Header blocks**: every `.wl` starts with the repo's header block (see
   `Mathematica/07_Axisymmetric_Models/axisymmetric_models.wl` lines 1–19; Purpose / Sources /
   Usage / Outputs; Solutions scripts also list "Exercises solved:").
10. **Honesty.** If a derivation does not check out in Mathematica, say so and fix the prose,
    not the test. If a source note's claim cannot be verified, drop it or mark it in the report.
    Do not pad. Do not invent precedent ("as shown by X") you have not checked.

## Report format (your final message; it is the ONLY thing the orchestrator sees)
- What you wrote (files, sections, exercise count, figure count)
- Verbatim `SUMMARY:` lines of every `.wl` you ran, with the command used
- `build.sh` tail (page counts) + the fingerprint lines
- Lint results: label uniqueness, project-content lint (chapter agents), R1–R5 grep, cite keys
- "Requests for the orchestrator": missing bib keys (UNVERIFIED details), macros, master checks
- "Flags for the fact-critic": anything you were unsure about (numbers, attributions, conventions)
- The commit hash on your branch
