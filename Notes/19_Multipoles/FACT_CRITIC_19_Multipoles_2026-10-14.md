# fact-critic report — Notes/19_Multipoles (Chapter 19 = PDF chapter 23, "Azimuthal Multipoles and the Central-Mass Confusion")

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (api.crossref.org reachable; C&K DOI confirmed),
> md-reflist ✗ (n/a), values-file ✗ (none), repo-grep ✓, doc-internal ✓, reference-PDF ✓ (`Reference_Texts/`, via `pdftotext`),
> wolframscript ✓ (`bash Mathematica/run_wl.sh`), overlay: AGEL `local/agel-sources.md` (Zotero read-only search used once).
> (A claim whose lens has no active adapter is capped at ⚠ SUSPECT.)
> Scope: `19_Multipoles.tex`, `19_Solutions.tex`, `Mathematica/19_Multipoles/multipoles_power_law.wl`,
> `Solutions/19_Multipoles/problems_19.wl`, `Figures/19_Multipoles/*.pdf`; port source
> `AGEL/202607_Theoretical_spiral_compound/theory/note6_multipoles.tex` (read-only).
> Build check: annotated edition built in a scratch copy of this worktree — 0 undefined refs/citations, 0 LaTeX errors;
> chapter 23 runs pp. 509–526.

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "A uniform deflection merely translates the source plane and is unobservable \citep[§4.1.3]{congdon_principles_2018}" | ✅ PASS | bib:congdon_principles_2018 / CrossRef DOI 10.1007/978-3-030-02122-1 confirmed (title, Congdon, Keeton); C&K PDF §4.1.3 p. 93: linear terms "produce a constant deflection, which amounts to a translation β → β + α⁰ of the origin of the source plane" | none |
| C2 | Citation | "The isophotes of real early-type galaxies depart from perfect ellipses at the per-cent level: the classic case is the m=4 … and odd modes (m=1, m=3) also occur" (l. 19–23) | ⚠ SUSPECT (uncited) | no bib key; none of the 8 Reference_Texts PDFs discusses boxy/discy isophote amplitudes (grep `boxy|disky|discy|isophot`) | see Flagged F1 |
| C3 | Citation | "the shallow slopes γ'=1.4–1.5 typical of lenses with visible central images" (annotation, l. 179–181) | ⚠ SUSPECT (uncited) | no bib key; port source says only "our regime" (project-specific) | see Flagged F2 |
| C4 | Citation | "as is now usual in the lens-modelling literature, a_m is the fractional convergence amplitude" (l. 83–85); "A common parameterisation stores a multipole as two Cartesian-like components" (l. 337); keybox "lens-modelling codes implement multipoles with differing amplitude conventions … some define the multipole relative to elliptical rather than circular contours" (l. 355–360) | ⚠ SUSPECT (uncited) | no bib key; the port source based these on code docstrings it read (autogalaxy, lenstronomy), which the textbook cannot cite | see Flagged F3 |
| C5 | Citation | "the kind of quantity photometrists report for isophotes" (l. 378–379) | ⚠ SUSPECT (uncited, minor) | no bib key | soften or leave (generic); see F3 |
| C6 | Citation (internal) | "in line with the remark in §\ref{sec:which_multipoles} that the dipole is nearly degenerate with the source position" | ✅ PASS | `Notes/08_Elliptical_Models_Caustics/08_Elliptical_Models_Caustics.tex:582–583` | none |
| N1 | Number | k_m/a_m = 3−γ' = "1.6–1.5" at γ'=1.4–1.5; "k_m = 1.6 a_m but ε_m = 2.5 a_m" | ✅ PASS | critic D7b; repo C4 | none |
| N2 | Number | peak 0.67% (m=3), 0.44% (m=4) at γ'=1.5, a_m=0.01; "6.7 and 4.4 mas for θE=1″" | ✅ PASS | critic D3b (brute-force NMaxValue over φ: 0.0066667, 0.0043636); repo C8; problems 1i, 1j, 1m | none |
| N3 | Number | m=3 vs m=4 factor "1.565 at γ'=1.4 and 1.528 at γ'=1.5" | ✅ PASS | critic D3c; problems 1k | none |
| N4 | Number | "33% low at γ'=1.5 and 37.5% low at γ'=1.4" | ✅ PASS | critic D7b; problems 6c/6d | none (the port source's "~60% error" was a loose statement of the factor 1.6; the chapter's 37.5% is the correct shortfall) |
| N5 | Number | ε_m = 2.5% (γ'=1.4), 2.0% (γ'=1.5) for a_m=0.01; Solutions table (0.075, 0.060, 0.030) | ✅ PASS | critic D7 (numerical Fourier projection, no series); problems 2c–2e | none |
| N6 | Number | arc overlap 2/π ≃ 0.64 (m=4, Δ=π/8), 0.41 (60° arc) | ✅ PASS | critic D8 (numerical least squares); problems 3g/3h; repo F3 | none |
| N7 | Number | crit-curve coefficient "exactly 1 for every m" at γ'=2; 3.16 for m=4, γ'=1.5; "±3.2% of θE"; Solutions 10/3 for m=3 | ✅ PASS | critic D6a/D6b (root-finding the Cartesian det A, Richardson-extrapolated: 3.163636363640 vs 3.1636363636); repo G7/G8; problems 4d | none |
| N8 | Number | point mass on fixed base δθc/θE = f•/(γ'−1) (0.02 θE at f•=0.01, γ'=1.5); rescaled base → no shift | ✅ PASS | critic D6d/D6e; repo G9/G10; problems 4f | none |
| N9 | Number | θ_r = 0.25 θE at γ'=1.5 | ✅ PASS | critic D9a (root of 1−α₀'); repo H1/H2 | none |
| N10 | Number | table: 0.0246, 3.75×10⁻⁴, 65.7; 0.00218, 0.00478, 0.456; ratios 11.3, 0.078 | ✅ PASS | critic D9b; repo H14–H16; problems 5f/5g | none |
| N11 | Number | "multipole dominates for 0.58 ≲ θ/θE ≲ 2.1" | ✅ PASS | critic D9c: crossings 0.58323, 2.08928; repo H17 prints the same | none |
| N12 | Number | m=1 denominators −1.25 (γ'=1.5), −0.21 (γ'=1.9); Solutions −1.56 (γ'=1.4) | ✅ PASS | critic D3d; repo I4; problems 7c | none |
| N13 | Number | Solutions 7c: dipole peak 0.018 (γ'=1.5), 0.0576 (γ'=1.9) | ✅ PASS | critic D3d (brute-force max over φ) ; problems 7d | none |
| N14 | Number | Solutions 6a: (ε₁,ε₂) = (−0.0075, 0.01299) | ✅ PASS | problems 6a/6b (ran) | none |
| X1 | Consistency | §mu_isothermal_limit: inserting A = −k_m θE/(m²−1) into Chapter 12's `eq:kappa_multipole` gives κ_m(γ'=2); A_m = −θE a_m/(m²−1) | ✅ PASS | `08_Elliptical_Models_Caustics.tex:518–525` (κ_m = a_m(1−m²)/(2θ) cos); critic D5a (Cartesian Laplacian of Aθ cos mΔφ, m=0..5) + D5b; repo B6/B7 | none |
| X2 | Consistency | notation clash: f• for the point-mass fraction because m is the multipole order; \mBH renders as m | ✅ PASS | `\mBH` occurs once in the chapter (l. 70, the explanation itself); every equation uses f• (eq:mu_fbullet, mu_res_pm, mu_res_refit, crit-curve text); Solutions use f•/θ•; definition θ•²/θE² matches Module 15's (PDF Chapter 19) `\mBH ≡ θ•²/θE²` (`Learning_to_Lens_wt/ch15/Notes/15_PowerLaw_PointMass/15_PowerLaw_PointMass.tex:463`) | none (see P-note: the rendered sentence "Elsewhere in Part V the symbol m denotes…" is correct but reads oddly; optional: "the symbol m (macro \mBH)…" is not needed) |
| X3 | Consistency | every `Chapter~\ref{ch:…}` points at the right content | ✅ PASS | scratch-built `main.toc`: ch:magnification=9, ch:axisymmetric_models=11, ch:elliptical_models=12, ch:galaxy_lensing=13 (power law, eq:kappa_power_law = Eq. 13.x), ch:power_law_point_mass=19, ch:central_mass_bias=21; labels located at `05_…:135,149,417`, `07_…:129`, `08_…:484–591`, `09_…:574,626` | none |
| X4 | Consistency | bridge: Chapter 21 (ch:central_mass_bias) is where "the issue is whether a change of the inner profile can mimic a point mass" | ⚠ SUSPECT | ch17 is still a stub in every worktree; its planned sources (note3 + note3b: bEPL vs EPL+PM) are consistent with the description, but the content cannot be checked yet | re-check after ch17 lands; if the broken-power-law mimicry stays in Chapter 19 (ch15 intro, `15_PowerLaw_PointMass.tex` l. 36–40), point there instead |
| X5 | Consistency | §8.2 "The multipole cannot be absorbed by θE, γ' or any other monopole parameter: on every circle it averages to zero" vs §6 "Over a partial arc … Â₀ = A sin mΔ/(mΔ)" | ❌ FAIL (internal tension, prose) | internal: l. 693–695 vs l. 487–511 | see Flagged F4 |
| X6 | Consistency | the "illustrations, not predictions" caveat for the inner/outer table exists ONLY in an `annotation` box (l. 762–773) | ⚠ SUSPECT | `Notes/editions.tex` header: annotation boxes are skipped in student + instructor editions | see Flagged F5 (author flag 1) |
| X7 | Consistency | Remark "Away from γ'=2 the m=1 mode is finite, but its potential has the opposite sign to the m≥2 modes" | ❌ FAIL (internal) | the chapter's own annotation (l. 260): for m=1 the prefactor is negative iff γ'>2, i.e. opposite sign to m≥2 only for γ'<2 | see Flagged F6 |
| X8 | Consistency | "Zero mean … so the area inside the critical curve is unchanged at first order — Theorem again" | ⚠ SUSPECT (loose attribution) | the area result follows from ∮cos mΔφ dφ = 0 applied to δ(φ) (problems 4e), the same integral as in the theorem, not from the enclosed-mass theorem itself | optional: "— the same ∮cos mΔφ dφ = 0 that proves Theorem…" |
| X9 | Consistency | Chapter 12 §which_multipoles says the m=4 pole matters "only for q ≲ 0.75"; this chapter treats a per-cent intrinsic m=4 as important | ⚠ SUSPECT (unbridged) | `08_…:567–588` | optional one-sentence bridge: Chapter 12's estimate is the m=4 content *of an ellipse*; here a_m is an intrinsic departure *from* the ellipse |
| X10 | Consistency | port fidelity vs note6: ψ_m, α_r, α_φ, a_m=k_m/(3−γ'), k_m=a_m(3−γ'), a_m=(γ'−1)ε_m, orthogonality, m=1 resonance | ✅ PASS | note6 eqs (psim), (alphar), (alphaphi), (am), (amiso), keybox §sectors, remark §resonance compared line by line; only changes: |…| added to the ratio denominator (correct generalisation) and 37.5% replacing "~60%" (correction). §§6–8 (arc overlap, critical-curve shift, residual toy) are new in the chapter, not ported — checked separately (D6, D8, D9) | none |
| X11 | Consistency | project leakage | ✅ PASS | `grep -nEi 'tier|scripts/|results/|lenstronomy|autolens|autogalaxy|J0946|AGEL|Carousel|this project|G2b|case.B|DSPL|Nautilus|eplmp|seed'` → hits only on check ids `G1`/`G10` and `fig1` in the .wl (generic); no ΔlogZ, Occam −3, θ• bounds, grid cells or code names ported. The evidence-ratio annotation (l. 517–528) is a generic rewrite of the R1/G2b lesson with no numbers | none |
| X12 | Consistency | chapter ↔ Solutions ↔ .wl agreement; figure captions vs script | ✅ PASS | all numbers above agree in all three places; `residual_inner_outer.pdf` labels (pdftotext): dotted "ring matched", solid "ring + slope matched", dashed "m = 4 multipole, a4 = 0.01 (peak over φ)", θr/θE lines, axes θ/θE 0.1–3, |δα|/θE 1e-4–0.2 — match caption; `kappa4_map.pdf` (rasterised; viewed) shows κ4 for a4=0.05, γ'=1.5 with red=positive, dashed unit circle, and right panel κ contours + red first-order curve bulging at φ=0 — matches caption and script l. 272–293 | none |
| D1–D9 | Derivation | see "Derivation checks" | ✅ PASS (25/25) | scratch script below | none |
| P1–P6 | Prose | see Prose section | ⚠ SUSPECT (flag-only) | read | see Prose |

## Applied (auto-fixes)

None. No single-source number typo and no number-vs-number mismatch was found; every number in the chapter, its Solutions and both scripts agrees with the independent re-derivation.

## Flagged — your hand required

- **F1 (C2, author flag 2a) — "isophotes … depart from perfect ellipses at the per-cent level" is uncited.** The bib has no isophote reference and no book in `Reference_Texts/` covers boxy/discy amplitudes. Two options without adding a key: (a) soften to "The isophotes of many early-type galaxies are measurably boxy or discy (an m=4 Fourier mode), and odd modes (m=1 lopsidedness, m=3) also occur; the amplitudes are small, typically a few per cent or less." and drop the specific "per-cent level" claim if the author cannot cite it; (b) ask the orchestrator for a key. Candidate (UNVERIFIED for this book's bib, found in the Zotero library, item 3CK5KJTX): Stacey, Powell, Vegetti, McKean, Fassnacht, Wen & O'Riordan 2024, "Complex angular structure of three elliptical galaxies from high-resolution ALMA observations of strong gravitational lenses" (the port source gives A&A 688, A110; DOI not confirmed in this run) — this supports per-cent multipoles in lens *mass*, not isophotes, so it would also require rewording the sentence to be about mass. A classic isophote reference (e.g. Bender et al. 1989) is not in Zotero or the bib; do not add it from memory.
- **F2 (C3, author flag 2b) — "γ' ≈ 1.4–1.5 typical of lenses with visible central images" is uncited and project-derived** (note6 says "our regime"). The defensible statement is the analytic one the book already proves: a power law has a radial critical curve (and hence radial/central images) only for γ' < 2 (eq:mu_theta_r). Proposed rewrite of l. 179–181: "at the shallow slopes γ' = 1.4–1.5 used as examples in this chapter (shallow enough, γ' < 2, for a radial critical curve and central images to exist; Chapter 19) it is 1.6–1.5." Same change needed where l. 365–366 / 400–401 implicitly rely on "typical".
- **F3 (C4/C5) — code-convention statements are uncited.** "as is now usual in the lens-modelling literature", "A common parameterisation", and the keybox's three-way list of conventions come from code docstrings in the port source. Proposed: drop "as is now usual in the lens-modelling literature" (say "Here $a_m$ is the fractional convergence amplitude"), and in the keybox replace the three-way claim with "Different lens-modelling codes normalise multipoles differently (some use $k_m$, some $a_m$, some perturb elliptical rather than circular contours)." only if the author is satisfied from personal knowledge; otherwise keep just the imperative "Always derive the fractional density amplitude from the code's own definition". The keybox's advice is sound either way.
- **F4 (X5) — §8.2 contradicts §6.** §8.2 says the multipole "cannot be absorbed by θE, γ' or any other monopole parameter" because it averages to zero on every circle; §6 shows a monopole template does absorb A sin(mΔ)/(mΔ) of it over a partial arc, which is the point of the chapter. Proposed: "In κ, the multipole cannot be absorbed by θE, γ' or any other monopole parameter, because it averages to zero on every circle (Theorem…); a fit sees only the arcs, so the absorption is limited to the partial-arc overlap of Eq. (mu_arc_overlap) and disappears once the multipole is modelled."
- **F5 (X6, author flag 1) — the toy caveat is invisible in two of three editions.** The main text does present the table as "A worked comparison" with θE and slope matched, and the parenthetical at l. 725–727 hedges the far-outside rise, but the explicit statement that the toy "holds the source fixed and linearises in f• and a_m … the specific numbers in the table are illustrations, not predictions for any particular lens" sits in an `annotation` box (l. 762–773). Under `editions.tex` it is skipped in the student and instructor PDFs. The numbers do reproduce (D9b/D9c; repo H14–H17), and the linearisation is adequate (critic D9d: an exact non-linear ring+slope refit gives 0.02481 vs 0.02460 at θ_r and 3.49×10⁻⁴ vs 3.75×10⁻⁴ at 1.2 θE, so the table's 11.3/0.078 become ≈11.4/0.073). Proposed: move one sentence into the main text just before the table, e.g. "This is a linearised toy (source fixed, first order in f• and a_m); the numbers illustrate the radial ordering, not any particular lens." Keep the longer box for the annotated edition.
- **F6 (X7) — dipole remark sign statement is only true for γ' < 2.** Proposed: "For γ' < 2 the m=1 mode is finite but its potential has the opposite sign to the m ≥ 2 modes, and its response is large: …". (Both quoted γ' values, 1.5 and 1.9, are < 2, so the numbers are unaffected.)
- **F7 (X4) — forward bridge to Chapter 21 unverifiable** until ch17 is written; re-check that Chapter 21 actually discusses inner-profile mimicry of a point mass, otherwise retarget to Chapter 19 (broken power law).
- **F8 (minor, X8/X9)** — optional wording fixes listed in the table (area-unchanged attribution; one-sentence bridge to Chapter 12's "m=4 only for q ≲ 0.75").
- **Harness note (not a chapter defect):** in the final critic run, the PASS lines for D3b and D3c were tallied in SUMMARY (25 PASS) but not echoed to stdout; in an earlier run D3c (and D8/D9a/D9b) echoed and D3b did not. D3b's four values were re-printed in a standalone run (`critic_19/t.wl`: 0.0074534, 0.0047619, 0.0066667, 0.0043636). Lines appear to be dropped intermittently by wolframscript when Print and messages interleave; the SUMMARY tally is reliable.

## Prose (LLM tells) — flag-only

Counts: `19_Multipoles.tex` 15 em-dashes in ~4860 words (≈1 per 320 words, below the ~1/150 signal); `19_Solutions.tex` 1 in ~1250. Few triads; the lists that exist are real lists. Overall the chapter reads mostly clean. Instances that are ornament rather than content:

- P1 (l. 18–19) "That is a choice of convenience, not a fact about galaxies." Antithesis. Plain: "That is a modelling convenience."
- P2 (l. 182) "conflating them is a real, not academic, error." Plain: "explains what goes wrong when they are conflated."
- P3 (l. 29–31) "the one structural fact that organises everything else". Pointer/intensifier. Plain: "and then prove the result the rest of the chapter uses:".
- P4 (l. 468–469, keybox closer) "No amount of boxiness can change the mass inside the Einstein ring, and no central mass can change the shape of the isodensity contours." Chiastic closer. It carries content, so keep the claim, e.g. "A multipole leaves the mass inside the Einstein ring unchanged, and a central point mass leaves the contour shapes unchanged."
- P5 (l. 780–782, bridge closer) "In both cases the answer has the same shape: in a mis-specified model, yes; in a correctly specified one, the residuals tell you which." Aphoristic closer. Plain: "In both cases a mis-specified model can be fooled, and the residuals of a correctly specified one separate the two."
- P6 (l. 255–257) "the multipole formula and the monopole formula are the same solution of the same equation." Summary echo of the previous clause; it can be deleted.
- Kept on purpose (contrast carries physics): "a specification error, not a physical degeneracy" (l. 510–511), "illustrations, not predictions" (l. 772), "order-of-magnitude translator, not a calibration" (l. 407), the §6 title.

## Provenance — not run

Not part of this brief's lens set. The baseline for a later run would be `note6_multipoles.tex` (itself model-assisted); §§6–8 and all annotation/derivation/bridge boxes are new text with no author baseline.

## Derivation checks

Scratch script (not in repo): `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_19/critic_derivations_19.wl`. It avoids the chapter's polar formulae: it works in Cartesian (x, y), solves the radial ODE with DSolve instead of assuming the ansatz, and checks the perturbative results against brute-force numerics.

SUMMARY line: `SUMMARY: 25 PASS, 0 FAIL  (of 25 checks)`

| id | equation | method | result |
|----|----------|--------|--------|
| D1 | ψ_m (eq:mu_psim) | DSolve of R'' + R'/θ − m²R/θ² = k θE^{γ'−1} θ^{1−γ'}; the particular solution equals the chapter's radial part; homogeneous θ^{±m} identified | PASS |
| D2 | ∇²ψ_m = 2κ_m | Cartesian Laplacian at 6 random points × 7 (m, γ') cases incl. m=1 off resonance, m=5, γ'=2.4 | PASS |
| D3 | α_{m,θ}, α_{m,φ} (eq:mu_alphar/phi), peak ratio (eq:mu_alpharatio) | Cartesian gradient projected on (r̂, φ̂), signs included; peak by NMaxValue over φ; m=1 peaks | PASS |
| D4 | zero-enclosed-mass theorem (thm:mu_zero_mass) | numerical φ-integral on 40 rings × midpoint radial sum, m=1..5, γ'∈{1.3, 2, 2.7}, R∈{0.4, 1.7}: |δM| < 10⁻⁹ M₀; Gauss flux of the Cartesian gradient = 0; radial integral finite iff γ'<3 (the proof's hypothesis is stated correctly) | PASS — proof sound |
| D5 | consistency with Ch. 12 eq:kappa_multipole at γ'=2; eq:mu_iso_dictionary | Cartesian Laplacian of Aθ cos mΔφ, m=0..5; substitution A = −kθE/(m²−1) | PASS |
| D6 | critical-curve shift (eq:mu_crit_shift) | FindRoot on the Cartesian det A of ψ₀+ψ_m at a=10⁻⁴, 2×10⁻⁴, Richardson-extrapolated: m=4, γ'=1.5 → 3.163636363640 (formula 3.1636363636); m=3 → 10/3; γ'=2 → 1 for m=3,4; cos mΔφ law at φ=0.13 and for m=2, γ'=1.7; isothermal det A ≡ 1−2κ exactly (critical curve = κ=½ contour); point mass f/(γ'−1) and no shift with (1−f) base | PASS — author flag 3 confirmed |
| D7 | a_m = (γ'−1)ε_m (eq:mu_am_eps); k_m=a_m(3−γ') shortfalls | numerical Fourier coefficient of (1+ε cos 4φ)^{γ'−1} | PASS |
| D8 | arc overlap (eq:mu_arc_overlap) | numerical least-squares constant fitted to cos 4φ on |φ|<Δ | PASS |
| D9 | residual toy (eq:mu_res_pm, mu_res_refit, mu_theta_r) | table numbers and crossings recomputed; exact non-linear refit within 1% at θ_r and 7% at 1.2 θE; a least-squares slope over an arc band 0.8–1.3 θE gives δγ' = −0.0142 vs the prescribed −0.015 | PASS — author flag 1 numbers reproduce |

Repo scripts (run via `bash Mathematica/run_wl.sh` in this worktree):
- `Mathematica/19_Multipoles/multipoles_power_law.wl` → `SUMMARY: 67 PASS, 0 FAIL  (of 67 checks)` (prints `crossings: 0.5832297753672733  2.089278784844832`). Running it rewrites both figure PDFs; those regenerations are left unstaged.
- `Solutions/19_Multipoles/problems_19.wl` → `SUMMARY: 53 PASS, 0 FAIL  (of 53 checks)`.
