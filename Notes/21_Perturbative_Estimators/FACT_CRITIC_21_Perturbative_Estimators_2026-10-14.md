# fact-critic report: Notes/21_Perturbative_Estimators/ (Chapter 21, PDF chapter 25)

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Provenance, Derivation
> Active adapters this run: bibtex ✓ (`Notes/*.bib`), crossref-web ✓ (api.crossref.org + Semantic Scholar reachable),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓, wolframscript ✓ (`bash Mathematica/run_wl.sh`),
> overlay: agel-sources (Zotero not needed: one citation, CrossRef-confirmed).
> Scope: `21_Perturbative_Estimators.tex`, `21_Solutions.tex`, `Mathematica/21_Perturbative_Estimators/response_coefficient.wl`,
> `Solutions/21_Perturbative_Estimators/problems_21.wl`, `Figures/21_Perturbative_Estimators/`.
> Source (read-only): `AGEL/202607_Theoretical_spiral_compound/theory/note10_analytic_backbone.tex` (+ solutions, `verify.wl`).
> Critic scratch: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_21/`.

**Verdict counts: 43 rows. ✅ 33 PASS · ⚠ 10 SUSPECT · ❌ 0 FAIL. No auto-fixes applied.**

## Repo scripts (run 2026-10-14, this worktree)

- `response_coefficient.wl`: `SUMMARY: 85 PASS, 0 FAIL  (of 85 checks)`. The script re-exports both figures every time it runs, which marks them modified in git. I reverted them with `git checkout` because only the export timestamps had changed.
- `problems_21.wl`: `SUMMARY: 39 PASS, 0 FAIL  (of 39 checks)`.

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "the cosmological observable of a double-source-plane lens \citep{collett_2012}" | ✅ PASS | bib:collett_2012 / CrossRef DOI 10.1111/j.1365-2966.2012.21424.x (MNRAS 424, 2864, 2012; title + authors match). The Semantic Scholar abstract says the method measures "the ratio of Einstein radii", a ratio of distance ratios | none |
| C2 | Citation (textual) | "a general fact from Chapter~\ref{ch:magnification}: … δθ = A⁻¹δα" | ✅ PASS | `Notes/05_…/05_Magnification_Convergence_Shear.tex:494-503`: M = A⁻¹ maps source-plane displacements to image-plane displacements. An extra δα at fixed β is the same thing as δβ = δα | none |
| N1 | Number | θ_r = 0.217 θ_E | ✅ PASS | critic D1d; rc `bf4b` | none |
| N2 | Number | θ_A,B,C = +1.316, −0.633, −0.0237 | ✅ PASS | critic D1c (1.31615, −0.63266, −0.023657) | none |
| N3 | Number | λ_r = 0.66, 0.47, −2.78 | ✅ PASS | critic D1c (0.6608, 0.4736, −2.7817) | none |
| N4 | Number | shifts per unit m: 1.15, −3.34, 15.2; "exact solve … better than 10⁻⁴" | ✅ PASS | critic D1b (numeric/linear agree to <10⁻⁵); rc `img7`,`img8` | none |
| N5 | Number | "c = 10.47" (source plane, running example, §Beyond the canonical triple) | ⚠ SUSPECT | critic D2a: Eq. (pe_c) evaluated on the m = 0 power-law images that the running example lists gives **c = 10.4612 → 10.46**. 10.4656 → 10.47 is the value on images perturbed by m = 10⁻⁶ (rc `bf4b` uses `obs = imgsM[10^-6]`; rc's own `c0` in `bf5` is 10.4612). | Change to 10.46, or say "evaluated on the observed (m = 10⁻⁶) images". Flag-only: two definitions give two candidate values |
| N6 | Number | canonical 6.81 at ρ = 0.0237; "raises c by about half" | ✅ PASS | critic D2d; rc log ratio 1.537 | none |
| N7 | Number | masked c = 2.00 vs floor 1.67 | ✅ PASS | critic D2c; rc `bf4b` | none |
| N8 | Number | image-plane c = 2.08; \|λ_r(θ_C)\| = 2.78 | ✅ PASS | critic D2b (my own image-plane brute-force FindMinimum 2.08120 vs weighted regression 2.08118); rc `bf6`,`bf6b` | none |
| N9 | Number | brute force = linear c "to better than 10⁻⁴, both with and without the radial image" | ✅ PASS | rc `bf1`,`bf2`. Caveat: true only with c evaluated on the observed images. On the unperturbed images the gap is 4.1×10⁻⁴ at m = 10⁻⁶ (critic log) | see F2 |
| N10 | Number | ρ_× = 1/243 ≈ 4.1×10⁻³ (γ′=1.8), 4.3×10⁻² (γ′=1.9) | ✅ PASS | critic D4c | none |
| N11 | Number | correction-factor curves "reach 3 at ρ = 1" | ✅ PASS | critic D4e (R(1,γ′) ≡ 3) | none |
| N12 | Number | free slope running example ε/m = −3.51, δγ′/m = 86.4 | ✅ PASS | critic D5d (−3.50925, 86.3865); rc `fs7`,`fs9` | none |
| N13 | Number | ρ* = 0.212 (γ′=1.6, B=0.8, plane 1 at floor) | ✅ PASS (source-plane) | critic D4f; rc `sc3` | see F1 for the image-plane value |
| N14 | Number | O(m²) check: departure "doubles (to within 1%)" | ✅ PASS (marginal) | rc log ratio 2.0198 (0.99%) | none |
| N15 | Number | Sol. (e): 3.388 / 5.871 / 5.859; 42% low; 1.73×; 0.2% | ✅ PASS | critic D4g; p21 `3j`,`3k` | none |
| N16 | Number | Sol. sheet: c_sheet = 1.626, floor 1.667, point-mass c = 4.87 | ✅ PASS | critic D4h; p21 `7f` | none |
| N17 | Number | Sol. design: √(4/3) ≈ 1.15 | ✅ PASS | p21 `6c`,`6d` | none |
| N18 | Number | "checked symbolically for N = 5 planes"; "check~10" | ✅ PASS | rc `coh1`–`coh4`; rc `10a`–`10` | none |
| X1 | Consistency | every `Chapter~\ref{…}` (9 distinct) | ✅ PASS | PDF TOC (`pdftotext -l 14 Output/Learning_to_Lens_Annotated.pdf`): axisymmetric = 11, magnification = 9, galaxy_lensing = 13, cosmological_distances = 7, multiplane_dspl = 18, power_law_point_mass = 19, odd_images = 20, central_mass_bias = 21 ("How an Unmodelled Central Mass Biases…"), cosmological_sensitivity = 24 (Fisher matrix at `20_…tex:343`). Each target's content matches the sentence that cites it | none |
| X2 | Consistency | external eq refs (kappa_power_law, pm_alpha, mass_einstein, alpha_radial, lens_eq_1d, alpha_mean_kappa, jacobian_def, eigenvalues_circular) | ✅ PASS | labels found at `09_…:840,162`, `07_…:97,105,170,242,304`, `05_…:446`; content matches. The α_PL derived from κ_PL is checked in critic D0 | none |
| X3 | Consistency | Summary: "With the slope free … the Einstein radius returns to its total-mass value" | ⚠ SUSPECT | holds only for the canonical triple (Eq. pe_free_slope). The chapter's own asymmetric running example gives ε/m = −3.51, not 1/(γ′−1) = 1.67 (critic D5d) | add "for the canonical triple" to the summary bullet and to the §Free-slope sentence at l.668-670 |
| X4 | Consistency | closed form / Cov / Var / corr. factor / one-term form: chapter ↔ Solutions ↔ both .wl ↔ source note10 | ✅ PASS | internal: all occurrences agree; critic D4a/b | none |
| X5 | Consistency | `fig:pe_corrfactor` | ⚠ SUSPECT (minor) | the label is never `\ref`'d; the text cites only the equation | add "(Fig.~\ref{fig:pe_corrfactor})" in §How good is the asymptote |
| X6 | Consistency | Annotated PDF chapter 25 | ⚠ SUSPECT (build) | `Output/Learning_to_Lens_Annotated.pdf` in this worktree still prints "[Chapter in preparation.]" for chapters 24 and 25. Cross-refs were checked against labels + TOC, not the rendered chapter | rebuild after the merge; check that ch. 25 has no `??` |
| X7 | Consistency | project-leakage lint (tier, scripts/, results/, lenstronomy, autolens, J0946, AGEL, Carousel, this project, A3, A8, A9, H3, 1.582, 67-cell) | ✅ PASS | grep over all four scope files: no hits. The only matches were "1.667"/"1.67" and "cells" in no context | none |
| X8 | Consistency | rc header "exports the figure of c(γ′)" vs two figures exported | ⚠ SUSPECT (trivial) | `response_coefficient.wl:24` vs `:34-35` | "exports the two figures" |
| D1 | Derivation | Eq. pe_general δp = m(XᵀWX)⁻¹XᵀWg; Eq. pe_image_shift δθ = m a/λ_r | ✅ PASS | critic D1a (generic n=4, symbolic), D1b (numeric, 3 images) | none |
| D2 | Derivation | Eq. pe_chi2: image-plane = source-plane with w = 1/(σ²λ_r²) | ✅ PASS | critic D2b (independent image-plane brute force) | none (but see F1) |
| D3 | Derivation | Eq. pe_floor = Eq. pe_total_mass (floor = total-mass θ_E shift) | ✅ PASS | critic D3a (exact numerical total-lens θ_E, m = 10⁻⁸), D3b | none |
| D4 | Derivation | Eq. pe_cclosed, pe_corrfactor, ρ_×, monotonicity, ρ* | ✅ PASS | critic D4a–D4f | none |
| D5 | Derivation | Eq. pe_free_slope; singular matrix without radial image; Eq. pe_mscaling; Eq. pe_bias/pe_shortcut; B_i > d₁ | ✅ PASS | critic D5a–D5h (incl. flat ΛCDM: d(z=1) = 0.530, d(∞) = 0.890, so B_i > 0.596 > d₁) | none |
| D6 | Derivation | S_N = √N S₁ (coherent); S_N = S₁ (random signs); bias independent of σ | ✅ PASS | critic D6a (Monte Carlo), D6b (exact enumeration N ≤ 8); rc `sig1`–`sig4` | none |
| F1 | Number/Derivation | ρ→0 divergence of c, "the deeper the radial image, the larger the leverage", "a plane-2 radial image close enough to the centre always flips the sign", Fig. response_coefficient, validity item 1 | ⚠ SUSPECT (scope) | critic D2e/D2f: these are **source-plane (unit-weight)** results and are not labelled as such. See Flagged | label as source-plane; add one image-plane sentence |
| F2 | Number | Validity item 1: the expansion needs "\|ε\| = m\|c\| ≪ 1" | ⚠ SUSPECT | critic `critic21_validity.wl` (see Flagged) | add the radial-image criterion |
| P1 | Prose | aphoristic closers (l.447, 592-593, 676-677, 786, 860-861) | ⚠ SUSPECT | read | see Prose |
| P2 | Prose | hollow intensifiers "crucially" (l.180), "genuinely" (l.897) | ⚠ SUSPECT | read | delete the words |
| P3 | Prose | "is not a numerical glitch; it is this crossing" (l.569-570); "does not replace … it explains it" (l.904) | ✅ PASS (kept) | read: each contrast carries content | none |
| P4 | Prose | em-dash density | ✅ PASS (borderline) | 29 `---` / ~5160 words ≈ 1 per 178 words (just under the ~1/150 signal); Solutions 8 | optional thinning in §Intro |
| V1 | Provenance | whole chapter + Solutions | ⚠ SUSPECT | `git log`: d64e8ea is Claude-co-authored; the chapter is a model adaptation of note10 | see Provenance |
| V2 | Provenance | source carry-over phrases ("load-bearing datum", "is not a technicality", "the whole story" → "the whole method") | ✅ PASS (noted) | note10 l.135, l.69 | author's call |
| S1 | Source fidelity | chapter vs note10: k, closed form, ρ_×, 5/3 boundary, floor, coherence facts, "B_i → 0" | ✅ PASS | note10 ll.84-268, 345-362. The chapter's added correction "B_i > d₁" is right (critic D5g) | none |

## Applied (auto-fixes)

None. The only number discrepancy (N5, 10.47 vs 10.46) has two candidate values depending on which images are used, so it is flag-only.

## Flagged — your hand required

- **F1 (most important). The "radial-image leverage" story holds only for the source-plane χ², and the chapter never says so where it matters.** The chapter does warn that weights matter: §"The weights matter" and the "Common error: quoting c without the likelihood" annotation. It quotes c = 10.47 (source plane) against 2.08 (image plane) for the running example, and I reproduced both with an independent brute-force fit. Everything after that is still stated without a qualifier, though, as if it held for any estimator: the closed form Eq. (pe_cclosed), its ρ→0 divergence Eq. (pe_asym), "the deeper the radial image, the larger the leverage", Fig. `response_coefficient.pdf`, the sign-change statement in §pe_sign_change, validity item 1, and the Summary bullets. Eq. (pe_cclosed) does say "With unit weights", but only once. Applying the chapter's own Eq. (pe_chi2) to the canonical triple (equal σ, so w = 1/λ_r², with λ = γ′−1 at ±1 and λ_r(ρ) at the radial image) gives very different behaviour (critic D2e/D2f, `critic21_imgplane.log`). At γ′ = 1.6:
  - **No divergence:** c_img → 1/(γ′−1) = 5/3 as ρ → 0. The radial-image weight goes as ρ^{2(γ′−1)}, and the radial image's share of the covariance goes as ρ^{γ′−1} → 0.
  - **Not monotonic:** c_img = 1.70 / 1.83 / 1.97 / 2.48 / 3.72 / 4.76 / 4.70 at ρ = 0.001 / 0.01 / 0.02 / 0.05 / 0.1 / 0.15 / 0.2. In the source plane the same points give 36.7 / 10.4 / 7.37 / 4.87 / 3.68 / 3.17 / 2.86.
  - **The sign change runs the other way:** with B = 0.8 and plane 1 at the floor, the image-plane bias is negative for 0.065 < ρ₂ < θ_r and positive deeper. The source-plane result is negative for ρ₂ < 0.212.

  So "a plane-2 radial image close enough to the centre always flips the sign" is false for an image-plane fit. Answer to flag (2): the chapter presents the source-plane c as *the* c everywhere except the one "weights matter" paragraph. The reader is warned that the value depends on the weights, but not that the qualitative ρ-dependence reverses.

  Proposed fix: add "source-plane" or "unit-weight" to the Eq. (pe_cclosed) lead-in, the Fig. 1 caption, the §Limits ρ→0 bullet, the §pe_sign_change example and the Summary. Add 2–3 sentences, in your own words, saying that under image-plane weights the deep radial image is down-weighted as 1/λ_r² and its leverage vanishes as ρ→0.

  Caveat on my check: the image-plane canonical triple is my own idealisation, built from the chapter's definitions. The physical running example (N8) confirms the direction of the effect: 10.46 → 2.08.

- **F2. The validity criterion "|ε| = m|c| ≪ 1" (§pe_validity item 1) is much too weak in the running example.** I ran a brute-force source-plane fit against c₀ = 10.461 (`critic21_validity.log`):
  - ε/m departs from c₀ by 0.4% at m = 10⁻⁵, 4.5% at m = 10⁻⁴ and 18% at m = 3×10⁻⁴, even though m c is only 0.003 there.
  - By m = 10⁻³ the radial image has already merged with the central point-mass image and vanished. Only two images remain.

  The relevant small parameter is the radial image's fractional shift, m a_C/(λ_C θ_C) ≈ 15.2 m / 0.0237 ≈ 640 m, not m c. Items 2–3 cover critical curves and topology changes only qualitatively, so the reader is not told that "small m" means m ≪ 10⁻³ for this example. Proposed fix: add the fractional-shift criterion |m a_j/(λ_j θ_j)| ≪ 1 for the radial image, with the running-example numbers.

- **N5.** "c = 10.47" is the value on images perturbed by m = 10⁻⁶. The first-order coefficient on the listed m = 0 images is 10.46. Either change it to 10.46 or say which images were used. The same choice gives 6.81 and the ratio 1.54 unchanged.

- **X3.** The Summary bullet and l.668-670 ("the Einstein radius falls back to the total-mass value") generalise the canonical-triple result. The chapter's own asymmetric example gives ε/m = −3.51. Qualify both with "for the canonical triple".

- **X5 / X6 / X8 (minor).** `fig:pe_corrfactor` is never referenced. The Annotated PDF in this worktree still shows ch. 25 as "[Chapter in preparation.]", so it needs a rebuild after the merge. The rc header says "the figure" where it exports two.

- **Author's flags, adjudicated:**
  1. Recipe and image shift: re-derived ✅ (D1a, D1b).
  2. Weights: w = 1/(σ²λ_r²) re-derived ✅. The values 10.47 (strictly 10.46, see N5) and 2.08 were reproduced by independent brute force ✅. The chapter's "the" c is the source-plane one, and the warning about this is incomplete (F1).
  3. Floor 1/(γ′−1) = total-mass θ_E shift ✅ (D3a: exact numerical total-lens θ_E).
  4. Closed form exact ✅; ρ_× = 9^{1/(5−3γ′)} and the γ′ = 5/3 boundary ✅. Fig. `correction_factor.pdf` is consistent with this (R(1) = 3; γ′ = 1.8 dips to 0.991 at ρ = 10⁻³). On that y-range (0.8–3.2) the dip below 1 is barely visible, which is cosmetic.
  5. δγ′ = m(ρ^{γ′−3}−1)/ln(1/ρ) > 0 ✅. The rank-2 normal matrix without the radial image ✅ (D5a–D5c). Caveat: with an asymmetric pair, any two images still under-determine three parameters, so the "pivot" explanation applies to the canonical triple only. The singularity itself is generic.
  6. m₂ = m₁B^k with k = (3−γ′)/(γ′−1) ✅ (D5e, random K, Q, d, γ′). B = η^{γ′−1} ✅ (D5f). ρ* = 0.212 ✅ for the source plane only (F1).
  7. "B_i → 0 is not reached because B_i > d₁" ✅. The definition is B_i = d₁/d_i with d_i = D_ds,i/D_s,i < 1. A tighter bound is B_i > d₁/d(∞): about 0.60 for z_d = 0.4, z₁ = 1 in flat ΛCDM with Ω_m = 0.3 (D5g).
  8. S_N = √N S₁ for coherent errors, and no growth for random signs ✅ (D6a/b).

## Prose (LLM tells): flag-only

- Em-dashes: chapter 29 per ~5160 words (borderline, under the signal level); Solutions 8. The intro paragraph (l.30-44) has 4 dash pivots and a five-item list, so that is where to thin first.
- Aphoristic closers worth rewriting plainly:
  - l.447 "The radial image is the load-bearing datum." (carried over from note10)
  - l.592-593 "The lesson generalises: a leading-order asymptote … is only as good as the slowest-decaying term it drops."
  - l.676-677 "The radial image is the slope's lever arm, and an unmodelled central mass pulls on exactly that lever."
  - l.786 "the sign of the cosmological bias is set by image geometry". Given F1 it is also too broad: the sign is set by geometry *and* by the choice of χ².
- Intensifiers: "crucially" (l.180), "genuinely" (l.897). Delete both.
- "exactly" appears 9 times. Most uses are mathematically meaningful, but l.435 ("in exactly the way that matters") and l.677 are ornament.
- Antitheses at l.569 and l.904 carry content; keep them.
- Overall the chapter reads clean apart from the closers above.

## Provenance (machine-drafted text): flag-only

Baseline: none authored by Rodrigo. The chapter (commit d64e8ea, Claude-co-authored) is a model adaptation of note10, which is itself model-drafted. Every sentence in the chapter and its Solutions is therefore classed as machine-introduced (100%; ⚠ per the lens rule). The sentence-length CV was not computed because there is no author baseline to compare against. Action: the author rewrites the prose in their own words, prioritising the keyboxes and annotations.

## Derivation checks

Scratch scripts, run via `bash Mathematica/run_wl.sh` in the critic scratchpad `.../scratchpad/critic_21/`:

- `critic21.wl`: `SUMMARY: 29 PASS, 1 FAIL  (of 30 checks)`. The one FAIL is D2a, and it is not a chapter error in the physics. It is the N5 finding: brute force matches the regression on the *observed* images to 3×10⁻⁶. The first-order c on the m = 0 images, however, is 10.4612, which rounds to 10.46 rather than the 10.47 printed. All other checks pass: D1a–d, D2b–f, D3a–b, D4a–h, D5a–h, D6a–b.
- `critic21_kappa.wl`: `SUMMARY: 2 PASS, 0 FAIL  (of 2 checks)`. α_PL is derived from Eq. kappa_power_law, and λ_r(θ_E) = γ′−1.
- `critic21_imgplane.wl`: image-plane canonical c(ρ) table, plus the reversed sign change at ρ* = 0.0650 (source plane: 0.2120).
- `critic21_validity.wl`: breakdown of the linear estimate against m (0.4% / 4.5% / 18% at m = 10⁻⁵ / 10⁻⁴ / 3×10⁻⁴; radial image annihilated by m = 10⁻³).

The five most load-bearing displayed equations were re-derived independently:

| # | Equation | Verdict |
|---|----------|---------|
| 1 | pe_general + pe_image_shift | ✅ PASS |
| 2 | pe_chi2 (weights) | ✅ PASS |
| 3 | pe_floor = pe_total_mass | ✅ PASS |
| 4 | pe_cclosed / pe_corrfactor / ρ_× | ✅ PASS |
| 5 | pe_free_slope, pe_mscaling, pe_bias | ✅ PASS |

The equations themselves are right. The problems are about scope (F1, F2, X3), not algebra.

## Reconciliation with the spiral project's record (2026-10-14)

Reviewer: independent reconcile pass (RECONCILE.md). Read: the note10 digest (7 FAIL, 20 SUSPECT), the
sol_note10 rows of `note8_solutions.md` (S5-127, S5-141 FAIL; S5-147–151 SUSPECT), spiral
`TESTS_AND_DIAGNOSTICS.md` rows A2, A3 (both rows: m→0 closure and the first-order estimator), A8, A9, H3, B2/B4 §2,
`HANDOFF_arc_2026-09-21.md` §5–6, `NOTES_R3_bepl_theta_e_rail_2026-07-26.md` (not relevant: it concerns the
autogalaxy θ_E convention, which the chapter does not use), and the source code that defines c
(`scripts/analytic_estimators.py:response_coefficient`, `scripts/tier1_axisym.py:fit_pl_only`,
`mathematica/exercises/sol_note10_analytic_backbone.wl` A8a–d).
Chapter text was not edited.

Re-verification script (scratch): `.../scratchpad/recon_21/recon21.wl`, run as
`bash Mathematica/run_wl.sh recon21.wl` → `SUMMARY: 11 PASS, 0 FAIL  (of 11 checks)`.
R1–R3: the spiral's `response_coefficient()` (an unweighted `lstsq` of a on {b, 1}) equals the chapter's
unit-weight, source-plane c to within 1e-12. On the m = 0 running-example images it gives 10.4612. The image-plane value is 2.0812.
R4–R5: for the canonical triple, the image-plane c tends to 1/(γ′−1) as ρ → 0, while the source-plane c diverges.
R6–R8: flat ΛCDM with Ω_m = 0.3, z_d = 0.4, z₁ = 1 reproduces the spiral A8d geometry B = (0.8054, 0.7283, 0.6898).
The lower bound is B_min = d₁/d(∞) = 0.5957, so B_min^k = 0.299 at γ′ = 1.6.
R9: when the c_i are unequal, the r_i can have opposite signs (r₂ = −2.76, r₃ = +0.52).
R10–R11: in a free-slope fit to a single three-image plane the system is square and non-singular (det = 0.561), so the
residual is exactly zero. The fit returns ε/m = −3.509 and δγ′/m = 86.39.

### The two points to settle

**(a) Does the spiral record define c as the source-plane estimator, and does it say so?**
It defines c that way **by construction but never by name**. Tier 1 (`fit_pl_only`) minimises unweighted
lens-equation residuals `ys − ys.mean()`, and its docstring calls this a "source-plane chi^2". The `sigma_pos`
magnification rescaling is explicitly skipped. `response_coefficient()` is the matching unweighted regression,
and R1 confirms it equals the chapter's w_j = 1 c. So the A3 agreement (median 1.017) compares one source-plane
quantity with another, and that comparison is valid.
The record never states the scope, though. Note10 (l.20, l.57, in bold), the A3 TESTS row and the module docstring
all describe the fit as "a least squares over **image positions**". That is the opposite of what is computed:
r_j is a source-plane residual. No line in note10, A3, A9 or H3 says that c, its ρ → 0 divergence, "the radial
image is the load-bearing datum", or the sign-change mechanism depend on the weights.
A9's "SCOPE IS LOAD-BEARING" warning covers the configuration (symmetric versus asymmetric triple), not the
likelihood. Neither the packet critic nor any earlier critic raises weighting.
The chapter is ahead of its source here. It names Σ r_j² as a source-plane fit (l.311), derives the image-plane
weights (Eq. pe_chi2), and gives 10.46 versus 2.08. Its remaining gap is F1 in this report: the qualitative ρ-trend
reverses under image-plane weights, and the chapter does not say so.
One consequence on the spiral side is not recorded. The Tier-2 likelihood (B2/B4 §2) uses C = σ² A Aᵀ, which is
image-plane-equivalent to first order. The A3 leverage story therefore does not carry over to Tier 2 without
reweighting. See feedback item 1.

**(b) Is "B_i → 0 is never reached (B_i > d₁)" consistent with H3's "r_i → (γ′−1)c₁ as B_i → 0"?**
Yes, as mathematics: H3 and A8a state a limit, and the chapter says the limit is not attained. Both are true.
The inconsistency sits in the spiral's **interpretation** of that limit:
- `sol_note10:219` says "B_i → 0 is the limit of a source plane infinitely far behind the deflector". That is false.
  A source at infinite redshift gives B = d₁/d(∞) = 0.596 (R7), not 0. B_i → 0 needs d₁ → 0, i.e. plane 1 at the deflector.
- Note10 l.331 says "Adding well-separated planes drives the response toward a constant". In H3's own geometry,
  B_i^k = 0.60, 0.48 and 0.42. With equal c, the responses therefore reach only 40%, 52% and 58% of the limit. Even
  z_s → ∞ caps them at 70% (γ′ = 1.6, R8).
The chapter's annotation ("approached, not reached") and its Solutions "Reach" paragraph are the correct reading.
The spiral record does not know this (grep finds no correction).
There is also a separate problem with H3's wording "all r_i share a sign" (TESTS H3 row, CLAUDE.md:633): it drops
the equal-c qualifier that note10 l.335 keeps. With unequal c_i the signs can differ (R9). That is the same
mechanism as the chapter's §pe_sign_change, which the chapter scopes correctly ("For equal c_i").

### Table

| spiral id | claim | status in chapter | action |
|---|---|---|---|
| S0-073 (FAIL) | naive back-of-envelope agrees in sign 49% (chance), ~4× low; keybox cadence | already fixed in port: no 49%/4× numbers. The shortcut Eq. pe_shortcut is framed correctly (fixed sign, cannot track the sign change, l.759–767, l.784–786) | none |
| S0-101 (FAIL) | "bias grows as source 2 approaches the radial caustic" is inverted | already fixed in port: the chapter makes no source-offset-direction claim. Validity item 2 (image shift diverges as λ_r → 0) is a different and correct statement | none |
| S0-064 (FAIL) | "closed form end to end" overstates (S_w is numerical) | n.a.: the cosmology leg (S_w, Δw) was stripped. The chapter claims a closed form only for c on the canonical triple | none |
| S0-021 (FAIL) | "c ~ 6–10 over the realistic grid" | n.a.: grid numbers stripped | none |
| S0-007 (FAIL) | abstract antithesis density | n.a.: abstract rewritten. The intro (l.20–44) has none of the four antitheses | none |
| S0-055 (FAIL) | "error shrinks with γ′ *only* because steeper cells sit at smaller ρ" | already fixed in port: the annotation "Reading the correction factor" (l.584–594) gives the intrinsic γ′ cause (3u decays like ρ^{γ′−1}) | none |
| S0-008 (FAIL) | "the whole story" (hollow intensifier, also inexact) | inherited as "Eq. pe_general is the whole method" (l.88). Critic V2 noted it as carry-over | reword in the fix pass ("is the method"), see new fix 4 |
| S0-090 / S0-091 / S0-096 | robustness grid 27 vs 12 gated; 1.75–2.28×, 1.60–1.65× | n.a.: numbers stripped. The chapter states only the generic √N / σ-cancellation algebra (critic D6a/b) | none |
| S0-030 | 3e-14 max error is a sampled worst case | n.a. | none |
| S0-066 | 67 cells ≠ 5×4×4 = 80 | n.a. | none |
| S0-009 | maxim opener "a result you cannot X…" | already fixed (absent) | none |
| S0-011 | bolded "least squares over image positions" | already fixed, and corrected: the chapter calls Σ r_j² a source-plane fit (l.311). See (a) | none |
| S0-015 | keybox title "is not a technicality" | inherited (l.389). Critic V2 noted | author's call |
| S0-022 | "load-bearing datum" | inherited (l.447). Critic P1/V2 noted. Under F1 it is also true only for the source-plane fit | covered by F1 |
| S0-024 | undated retraction fragment | n.a. | none |
| S0-043 | 0.9911 "sat unremarked"; a second sub-unity entry 0.9936 | n.a. (project table stripped). The keybox l.569 keeps the generic "not a numerical glitch" | none |
| S0-045 / S5-127 (FAIL) | "curve and its masked floor are one function"; floor back-reference to Ex. 1 does not resolve; 'masked' collides with the project's masked regime | partly inherited: l.517–518 "Masked and unmasked cases are one function evaluated at the two ends of ρ". The back-reference is fixed (Sol. (d) evaluates ρ = 1 directly). The term collision is n.a. (no masked regime in the book). The sentence is still loose: for the asymmetric running example the masked c is 2.00, not the ρ → 1 value 1.67 | new fix 3 |
| S0-057 | 6.6% belongs to ρ ∈ [0.01, 0.2] only | n.a. | none |
| S0-068 | scatter concentrated where c₁ − B^k c₂ cancels | n.a. | none |
| S0-074 | "different question" prose | already fixed: l.761–767 is plain | none |
| S0-088 / S5-149 | "one physical cause → cannot average down" stated as a maxim; broader than attested | inherited in scoped form (keybox l.858–863: "here there is one physical cause"). The chapter backs it with the toy S_N = √N S₁ and Eq. pe_ri. Strictly, "same direction" needs equal c (see (b)) | new fix 2 |
| S0-098 | second-person "Then do not stop there" | already fixed (removed) | none |
| S0-077 | A8a–c attestation not one-to-one | already fixed in port: rc `coh1`–`coh4` test general k, N = 5. The spiral A8c tests `(1−bb^2)>0` (k hard-wired to 2) and A8b fixes γ′ = 3/2 | feedback 4 |
| S0-075 / S0-093 | CLAUDE.md pointer; unverifiable retraction quote | n.a. | none |
| S5-141 (FAIL) | "Note 10 §8" should be §7 (also §6 → §5) | n.a.: no note-section pointers in the chapter | none |
| S5-147 | "Neither. That is the point." | already fixed: "Neither move improves accuracy; both improve precision." (Sol l.187) | none |
| S5-148 | "more precisely wrong" | inherited (Sol l.199) | author's call (prose) |
| S5-150 | "constraining power but no protection" antithesis | inherited (Sol l.205–207). The content is correct | author's call (prose) |
| S5-151 | sol_note10:40–42 "a plane with only a tangential pair cannot detect one, and a plane with a radial image can" (cadence only, "physics verified") | inherited (Sol l.49–51, same claim). It is true only at fixed slope: the chapter's own §pe_free_slope shows that with γ′ free one three-image plane is an exact 3×3 solve with zero residual (R10), so "can detect" fails | new fix 1; feedback 3 |
| TESTS A2 | m₂ = m₁ B^k, θ_E2/θ_E1 = B^{−1/(γ′−1)} | consistent (Eq. pe_mscaling; critic D5e/D5f) | none |
| TESTS A3 (m→0 closure) | PL-only fit recovers truth at m = 0 | n.a. (numerical-pipeline test) | none |
| TESTS A3 (estimator) | Δ𝓑/𝓑 = (γ′−1)m₁[c₁ − B^k c₂]; "least squares over image positions"; median 1.017 at m = 1e-4 | equation consistent (Eq. pe_bias). The "image positions" wording is not carried. The chapter correctly says source-plane. 1.017 n.a. | feedback 1, 5 |
| TESTS A8 | μ-floor sweep | n.a. ("A8" in note10/H3 means the coherence estimator, handled under H3) | none |
| TESTS A9 | closed form c; ρ→1 floor; γ′ = 5/3 boundary; ρ_× = 9^{1/(5−3γ′)}; **scope = canonical symmetric triple**; real cells c₂/c_closed median 1.582; response_coefficient() remains the definition | consistent and the scope already carries over: l.452 ("For the canonical triple"), §pe_beyond_canonical (asymmetric pair raises c by ×1.54 in the running example, the same direction and size as the spiral's median 1.582), validity "fourth limitation" (l.893–895). One residual generalisation: critic X3 (free-slope summary) | X3 already flagged |
| TESTS H3 | r_i share c₁; share a sign; r_i → (γ′−1)c₁ as B_i → 0; responses tend to a constant | consistent as a limit. The chapter adds the correct "approached, not reached" and scopes "same direction" to equal c (l.811–815). The H3 row drops the equal-c qualifier on the sign | feedback 2 |
| HANDOFF §5 | "15/15" belongs to `05_response_coefficient/verify.wl` | n.a. (the chapter quotes only its own SUMMARY counts) | none |
| HANDOFF §6 | "two quantities that coincide in one limit get two names" | applies to c: source-plane and image-plane c are different estimators sharing one symbol. The chapter's "Common error" annotation is the right remedy | covered by F1 |
| NOTES_R3 | bEPL θ_E rail | n.a. | none |

### New fixes for the fix pass (not already in the Flagged section above)

1. **Sol. l.49–51 ("a plane with a radial image can [detect a central mass]") is true only at fixed slope.**
   With γ′ free, a single three-image plane gives three equations in (ε, δγ′, δy). The system is
   non-singular (det = 0.561 for the running example), so the residual is exactly zero, as the chapter itself says
   for the canonical triple at l.671–673. Fix: "…a plane with a radial image can, **if the slope is held fixed**;
   with the slope free a single three-image plane fits exactly (§\ref{sec:pe_free_slope}), and detection needs a
   fourth datum or a second plane sharing the slope." Proof: `recon21.wl` R10.
2. **Keybox l.858–863 / l.805 "all ratios are biased in the same direction" (and the Summary's coherence bullet, if it
   restates this).** Item 3 at l.811 is correctly scoped to equal c_i. The keybox's "one physical cause" sentence
   reads as unconditional. With unequal c_i (one plane with a deep radial image, another without) the r_i can have
   opposite signs (R9: −2.76 versus +0.52, γ′ = 1.6). This is the chapter's own sign-change mechanism. Fix: add
   "when the planes' response coefficients are comparable" or point to §\ref{sec:pe_sign_change}.
3. **l.517–518 "Masked and unmasked cases are one function evaluated at the two ends of ρ"** holds for the canonical
   triple only. In the running example the masked c is 2.00, not the ρ → 1 value 1.67 (l.605). Fix: prefix "For the
   canonical triple,". Optionally cut the sentence, as the spiral S5-127 fix recommends.
4. **l.88 "is the whole method"** is the port of note10's "the whole story" (S0-008, a FAIL in the spiral record).
   Replace it with a plain statement, e.g. "Equation~\eqref{eq:pe_general} is the estimator."

### Feedback to the spiral project (errors the spiral record does not yet know about)

1. **c is a source-plane (unit-weight) estimator, but the record calls it an image-position least squares and never
   states the weight dependence.**
   - Where: `theory/note10_analytic_backbone.tex` l.20 and l.57 (bold: "the fit is a least squares over image
     positions"), TESTS row A3 (estimator), `scripts/analytic_estimators.py` docstring l.21.
   - What is actually computed: unweighted lens-equation residuals (`tier1_axisym.fit_pl_only`, residual
     `ys − ys.mean()`, σ_pos rescaling skipped), i.e. a source-plane χ².
   - Why it matters: an image-plane fit has weights 1/(σ²λ_r²), and these change the physics, not just the number.
     For the canonical triple at γ′ = 1.6, the image-plane c tends to 1/(γ′−1) as ρ → 0 instead of diverging. It is
     non-monotonic (1.70 / 1.83 / 1.97 / 2.48 / 3.72 / 4.76 / 4.70 at ρ = 0.001 to 0.2). The plane-2 sign change also
     reverses: in the image plane the bias is negative for 0.065 < ρ₂ < θ_r, against ρ₂ < 0.212 in the source plane
     (chapter critic F1, `critic21_imgplane.wl`). In the chapter's running example the source-plane c is 10.46 and the
     image-plane c is 2.08 (`recon21.wl` R2–R3).
   - Consequence for the project: the Tier-2 likelihood (B2/B4: C = σ² A Aᵀ) is image-plane-equivalent to first
     order. So note10's leverage, monotonicity and sign-change statements apply to Tier 1 but not automatically to
     Tier 2 or real modelling.
   - Possibly relevant, but **untested**: B2/B4's "plonly dB/B agrees with Tier-1 within ×2" was attributed to the
     source-placement convention. Weighting is a candidate the record has not considered.
   - Fix: say "source-plane (unit-weight) least squares" in note10 §1/§2, A3 and A9, and add the weighted form.
2. **The interpretation of the H3/A8 limit B_i → 0 is wrong.**
   - `theory/solutions/sol_note10_analytic_backbone.tex:219` says B_i → 0 is "a source plane infinitely far behind
     the deflector". It is not: B_i = d₁/d_i > d₁, and at z_s → ∞ the ratio is B = d₁/d(∞) = 0.596 (flat ΛCDM,
     Ω_m = 0.3, z_d = 0.4, z₁ = 1). B_i → 0 would need d₁ → 0.
   - Note10 l.331 ("adding well-separated planes drives the response toward a constant") overstates how close the
     limit gets. In H3's own geometry, B_i^k = 0.60 / 0.48 / 0.42, so the equal-c responses sit at only 40 / 52 / 58%
     of (γ′−1)c₁. The ceiling is 70% even for z_s → ∞ at γ′ = 1.6.
   - The H3 conclusion (significance grows) is unaffected because it is computed at the real B_i. Only the prose
     limit is misdescribed.
   - Also: TESTS H3 and CLAUDE.md:633 say "all r_i share a sign" without the equal-c qualifier that note10 l.335
     keeps. With unequal c_i the signs can differ (R9).
3. **sol_note10:40–42 "a plane with a radial image can [detect a central mass]" is true only at fixed γ′.**
   The packet critic (S5-151) judged it "physics verified" and flagged only the cadence. With the slope free, one
   three-image plane is a non-singular 3×3 solve with zero residual. This is note10's own free-slope result, Eq. pe_free_slope
   in the chapter, and R10 confirms it on an asymmetric triple.
4. **A8c is close to vacuous.** In `mathematica/exercises/sol_note10_analytic_backbone.wl:121-123` the check reads
   `Reduce[ForAll[bb, 0<bb<1, (1 - bb^2) > 0]]`: k is hard-wired to 2 and γ′ never enters. A8b is evaluated at
   γ′ = 3/2 only. The general statement, (γ′−1)c(1 − B^k) ∈ (0, (γ′−1)c) for all k > 0, is what the chapter's rc
   `coh3`/`coh4` test. The packet critic's S0-077 notes that the mapping is not one-to-one, but not this.
5. **(Tentative, not verified here.) The A3 gate amplitude m = 1e-4 may not be in the linear regime for deep radial images.**
   The chapter critic (F2, `critic21_validity.wl`) finds that ε/m departs from c by 4.5% at m = 1e-4 and by 18% at
   3e-4 for a radial image at ρ = 0.024. That is because the relevant small parameter is m a_C/(λ_C θ_C) ≈ 640 m,
   not m c. Part of A3's 16–84% spread (0.75–1.16) may be non-linearity. Suggested check: re-run `verify_a3` at
   m = 1e-5.
