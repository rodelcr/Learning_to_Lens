# Part V chapter brief (read COMMON.md first)

## Goal
Port one or two analytic study notes from the AGEL project
`/Users/rosador/Documents/AGEL/202607_Theoretical_spiral_compound/theory/` (read-only!) into a
self-contained **textbook chapter** of Learning to Lens, Part V "Compound Lenses, Degeneracies,
and Cosmography". The reader has finished Chapters 1–17 (Parts I–IV) and wants to be able to
*do* double-source-plane (DSPL) and central-point-mass lensing work. The chapter must be
**pure textbook**: generic derivations, no project-specific results, numbers, test ids, file
paths, tier names, grid cells, or unpublished measurements. The note's physics stays; the
project's bookkeeping goes.

## Source → chapter conversion recipe
1. Copy the note(s) into `Notes/<NN>_<Name>/<NN>_<Name>.tex` (replace the stub; KEEP the
   stub's `\chapter{...}` title and `\label{ch:...}` exactly — other agents reference it).
   Strip `\documentclass ... \maketitle`, `\begin/\end{document}`, `\title/\author/\date`,
   `\geometry`. Turn the `abstract` into the house opener: look at
   `Notes/07_Axisymmetric_Models/07_Axisymmetric_Models.tex` lines 1–60 for the pattern
   (header comment block, `\chapter`, optional verified epigraph — DO NOT add an epigraph unless
   you can verify it verbatim from a primary source in `Reference_Texts/`; omit otherwise —
   intro paragraph, "Companion Mathematica files" list with `\mathlink{}`/`\solnlink{}`).
2. **Label namespacing FIRST** (before any editing), with your prefix `<pfx>`:
   `sed -E -i '' 's/\\label\{(eq|sec|fig|tab|thm|ex):/\\label{\1:<pfx>_/g; s/\\(eqref|ref|autoref|pageref)\{(eq|sec|fig|tab|thm|ex):/\\\1{\2:<pfx>_/g'`
   (the b-note gets its own prefix, see your task). Then grep for duplicates.
3. Exercises: the note's `\section*{Exercises}` becomes `\section{Problems}\label{sec:<pfx>_problems}`;
   every `\begin{exercise}` gets `\label{ex:<pfx>_<slug>}`; notes 9/10 list exercises as an
   `enumerate` — convert each item to an `exercise` environment. Solutions go in
   `Notes/<NN>_*/<NN>_Solutions.tex` following `Notes/07_Axisymmetric_Models/07_Solutions.tex`
   exactly: `\section{Solutions to Exercises}\label{sec:<pfx>_solutions}`, pointer sentence to
   `\solnlink{<NN>_<Name>/problems\_<NN>.wl}{problems\_<NN>.wl}`, then one
   `\subsection*{Exercise~\ref{ex:<pfx>_<slug>}: Title}` per exercise. Port the solutions from
   `theory/solutions/sol_<note>.tex`; their attestation sentences become
   `\emph{[Attested: \solnlink{...}{problems\_<NN>.wl}, checks 1a--1d.]}` with check ids that
   really exist in your script (`grep -o 'check\["[^"]*' Solutions/<NN>_*/problems_<NN>.wl`).
   Attestations that leaned on `beta_sensitivity.py`/astropy/`scripts/` must be re-attested
   in Mathematica (compute D_A in-script as `Solutions/03_Cosmological_Distances/problems_03.wl`
   does) or the sentence dropped.
4. Mathematica: port the note's verification script(s) from
   `.../202607_Theoretical_spiral_compound/mathematica/` (your task names them) to
   `Mathematica/<NN>_*/<name>.wl`: `Get` the harness; `report[...]` keeps working (alias of
   `check`); replace `vv[]`/`Print["CHECK ..."]` styles with `check["id ...", cond]`; drop CSV
   `Export`s; keep check ids; end with `summary[]`. Port `mathematica/exercises/sol_<note>.wl`
   to `Solutions/<NN>_*/problems_<NN>.wl` the same way. Every equation you add or change on
   the page gets a new check. Add checks for anything in the prose that the source scripts did
   not cover (e.g. limiting cases, dimensional consistency, the SIS limit).
5. Citations: the notes cite in plain text "(Blandford \& Narayan 1986)". Convert to
   `\citep{...}` using ONLY keys in `Notes/references.bib` (Part V keys added 2026-10-14:
   `collett_2012`, `collett_auger_2014`, `schneider_2014_multiplane` [A&A 568, L2],
   `schneider_2019_generalized` [A&A 624, A54, arXiv:1409.0015 — the "generalized multi-plane
   lensing / MST" paper; NOTE the project notes mislabel it "Schneider 2014 A&A 568 A106"],
   `schneider_sluse_2013`, `falco_gorenstein_shapiro_1985`, `burke_1981`,
   `mao_witt_koopmans_2001`, `keeton_2001_catalog`; plus existing `blandford_narayan_1986`,
   `schneider_ehlers_falco_1992`, `kormann_isothermal_1994`, `schneider_sluse_2014` [SPT, A&A
   564 A103], `collett_2015`, `Birrer2020`, `wong_h0licow_2020`, books above). Anything else:
   report as UNVERIFIED and write around it.
6. Cross-references: "Learning to Lens Ch. 5–6" → `Chapters~\ref{ch:...}`; find the actual
   chapter labels with `grep -h '\\label{ch:' Notes/*/*.tex`. "Note 3" → the Part V chapter
   label from COMMON.md §5. Never `\ref` another Part V chapter's equations.
7. **Strip project content** — delete the sections your task lists, then lint:
   `grep -nEi 'tier[ -]?[0-9]|scripts/|results/|lenstronomy|autolens|herculens|J0946|AGEL|Carousel|Horseshoe|log ?Z|\bC1[01]\b|\bG[1-4]b?\b|\bR[1-5]\b|\bA[1-9]\b|\bH[0-5]\b|\bE[1-3]\b|fiducial|0\.68|1\.52|2\.11|beta_sensitivity|astropy|202607|this project|our project|the project' Notes/<NN>_*/*.tex`
   must return nothing (if a hit is a legitimate generic use, say so in the report). Published
   real-system numbers (e.g. the J0946 β⁻¹) may stay ONLY with a verified citation; prefer
   generic illustrative values. Remove `\author{202607...}`-style lines.
8. Macros: the project preamble's `\Brat \gp \thetaBH \mBH \etamea \ysrc \Dls \deriv \pderiv`,
   `keybox`, `aside` are now in `Notes/preamble.tex`; `\dd` comes from the physics package
   (write `\dd\theta`, never `\dd(`). `remark` is numbered here (fine). `\clash` is not ported —
   rewrite that one sentence.
9. **Pedagogy — this is the point.** Expand every compressed step of the note on the page:
   a reader with Chapters 1–17 must be able to follow each line. Use `derivation` boxes
   (annotated edition) for the long algebra and keep the main text's logical spine lean;
   use `annotation` boxes for intuition/sign conventions/unit checks/common errors; use at
   least two `bridge` boxes pointing BACK to the Part II/III chapter the result rests on
   (e.g. Ch.~7 distances, Ch.~9 Jacobian/eigenvalues, Ch.~10 Fermat/Morse, Ch.~11 NIS,
   Ch.~12 SIE, Ch.~13 MST). `keybox` for the chapter's 2–4 headline results. End with a
   "Summary" section (bullets) before "Problems", like Chapter 7.
10. Length target: 10–18 pages per chapter in the annotated edition. Do not pad.

## Acceptance (all must hold before you report)
- `bash Mathematica/run_wl.sh Mathematica/<NN>_*/<name>.wl` and
  `bash Mathematica/run_wl.sh Solutions/<NN>_*/problems_<NN>.wl` both end `ALL CHECKS PASS`
  (quote SUMMARY lines).
- `cd Notes && bash build.sh` → "all assertions passed"; also
  `ANNOT_REQUIRED=1 bash build.sh` passes (your chapter has annotation boxes).
- Label uniqueness, project-content lint, R1–R5 lint, cite-key check all clean.
- `git status --porcelain` shows only your directories; commit on your branch; `git checkout -- Output/` first.
