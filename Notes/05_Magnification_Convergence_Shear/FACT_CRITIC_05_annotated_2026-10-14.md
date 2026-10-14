# fact-critic report: Notes/05_Magnification_Convergence_Shear (Annotated Study Edition layer)

> Date: 2026-10-14. Lenses: Citation, Number, Consistency, Prose, Derivation.
> Scope: boxes added in commit 4f9b47d (`git diff c588432 4f9b47d -- Notes/05*`) in
> `05_Magnification_Convergence_Shear.tex` and `05_Solutions.tex`, the appended check section of
> `Solutions/05_Magnification_Convergence_Shear/problems_05.wl`, and the author flags 4–7 about the
> visible text. The rest of the visible text was fact-critic'd in July 2026 and was not re-reviewed.
> Active adapters this run: bibtex n/a (no `\cite` in the layer), crossref-web off (no DOIs in scope),
> md-reflist off, values-file off, **reference-PDF ON** (`pdftotext -layout` of `Reference_Texts/` N&B
> 1997, Congdon & Keeton 2018, SEF 1992), **wolframscript ON** (`bash Mathematica/run_wl.sh`), repo-grep
> ON, doc-internal ON, overlay: none used. A claim with no active adapter is capped at ⚠ SUSPECT.

Scratch derivation script (shared with the module 04 report):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0405/critic_0405.wl`

Verdict counts: **✅ PASS 31 · ⚠ SUSPECT 4 · ❌ FAIL 5**.
- 4 FAILs are the pre-existing **visible** text (author flags 4, 5, 6, 7; all confirmed).
- 1 FAIL is in the new layer: the multipole bridge's "m = 1 … pure shift of the lens centre".

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | ∇²ψ = 2κ "also follows from the 3-D Poisson equation integrated along the line of sight (N&B eq. 50)" | ✅ PASS | N&B eq. (50) | none |
| C2 | Citation | "|μ| = d²θ/d²β = 1/|det A| (N&B eq. 54)" | ✅ PASS | N&B eq. (54): δθ²/δβ² = det M = 1/det A | none |
| C3 | Citation | "N&B eq. 58 is identical to eq. (jacobian_matrix)" | ✅ PASS | N&B eq. (58) vs `05_…tex` lines 476–483: same matrix and signs | none |
| C4 | Citation | "C&K: their A⁻¹ (eq. 4.51) is our A, their A ('amplification tensor', eq. 4.53) is our M; γ+, γ× (eq. 4.52)" | ✅ PASS | C&K eqs. (4.51)–(4.53) and §4.2.2 text | none |
| C5 | Citation | "λ± = 1 − κ ± |γ| (C&K eq. 4.54)" | ✅ PASS | C&K eq. (4.54) and the sentence after it | none |
| C6 | Citation | pure-shear μ "is C&K eq. 4.50 … demagnified once |γ| > √2 (C&K Sec. 4.2.1)" | ✅ PASS | C&K eq. (4.50), §4.2.1 ("demagnification (|μ|<1) occurs when |γ+| > √2"; μ<0 for |γ+|>1) | none |
| C7 | Citation | "α = κ̄θ (C&K eq. 2.73)"; "dα/dθ = 2κ − κ̄ (C&K eq. 2.76)"; "factors of C&K eq. 2.23" | ✅ PASS | C&K eqs. (2.73), (2.76), (2.23) | none |
| C8 | Citation | SIS "all the magnification is tangential (cf. C&K, caption of Fig. 2.3)" | ✅ PASS | C&K Fig. 2.3 caption: "the singular isothermal sphere … only produces tangential magnification" | none |
| C9 | Citation | radial critical curve maps to a circle, tangential to a point "(C&K Sec. 2.2.3)" | ✅ PASS | C&K §2.2.3: "Axisymmetric lenses produce caustics that are points (μt⁻¹=0) or circles (μr⁻¹=0)" | none |
| C10 | Citation | two-plane Jacobian not symmetric, "decomposed into a rotation times a symmetric matrix (SEF Sec. 9.1)" | ✅ PASS | SEF §9.1.2 eqs. (9.11)–(9.13) | none |
| N1 | Number | multipole κ = (f + f″)/(2θ); f = cos mφ ⇒ κ = (1 − m²) cos mφ/(2θ) | ✅ PASS | critic D7 (m = 0…5, symbolic) | none |
| N2 | Number | m = 2 on isothermal: isodensity ≈3× as elongated as isopotential, same axis | ✅ PASS | critic D7: (1−q_κ)/(1−q_ψ) = 3.00 (ε→0), both major axes at φ = 90° for ε > 0 | none |
| N3 | Number | "(γ1, γ2) = (−0.1, 0.1) has its stretch axis at 67.5°, not −22.5°" | ✅ PASS | critic D10 (eigenvector of the smaller eigenvalue of A) | none |
| N4 | Number | spin-2 law γ′ = e^{−2iφ}γ under H′ = RᵀHR | ✅ PASS | critic D10 | none |
| N5 | Number | two-plane A = I − H1 − H2(I − bH1) | ✅ PASS | critic D8 (finite differences on a point mass + curl-free softened elliptical deflector; |A12 − A21| = 0.186); SEF eqs. (9.11)–(9.12) with b = β12; Ch 18 eq. `mp_jacobian` (`14_Multiplane_DSPL.tex` line 275), identical | none |
| N6 | Number | "Magnified means |det A| < 1 … det A = −1.5 … |μ| = 0.67" | ✅ PASS | critic D11 | none |
| N7 | Number | type III requires κ > 1 + |γ|; N_min + N_max − N_saddle = 1 | ✅ PASS | eigenvalue algebra (critic D11); `06_Fermat_Time_Delays.tex` line 431 | none |
| N8 | Number | axisymmetric λt = 1 − α/θ, λr = 1 − dα/dθ; γ = −(κ̄ − κ)e^{2iφ} | ✅ PASS | critic D6 (finite-difference Jacobian of a non-singular radial profile) | none |
| N9 | Number | power law λr = 1 − (2−γ′)(θ/θE)^{1−γ′}; θr = θE(2−γ′)^{1/(γ′−1)} = 0.25 θE at γ′ = 1.5 | ✅ PASS | critic D9 | none |
| N10 | Number | point mass adds +θ•²/θ² to λr; γ′ = 1.5: θ• = 0.05 θE gives 2 crossings, 0.2 θE gives none | ✅ PASS | critic D9: root counts {1, 2, 0} for θ• = {0, 0.05, 0.2} | none |
| N11 | Number | "μ = 1/(1−κ)² … 1 at κ = 2 … μ = 1/4 at κ = 3" | ✅ PASS | critic D11 | none |
| N12 | Number | pure shear "μ = 1.10 (|γ|=0.3), −2.27 (1.2), |μ| = 0.80 (1.5), demagnified once |γ| > √2" | ✅ PASS | critic D11; C&K §4.2.1 | none |
| N13 | Number | b/a = (1−g)/(1+g), (a−b)/(a+b) = g; Ex 5.5 g = 0.286, b/a = 5/9 = 0.556, μ = 2.22 | ✅ PASS | critic D11; problems_05.wl PASS "Ex 5.5(e) …" | none |
| N14 | Number | MST: A → λA, μ → μ/λ², β → λβ, g invariant | ✅ PASS | critic D13 (generic ψ) | none |
| N15 | Number | smoothed log: Laplacian 2ε²/(r²+ε²)², height 2/ε², plane integral 2π | ✅ PASS | critic D12 | none |
| N16 | Number | M/(Σcr Dd²) = πθE² | ✅ PASS | critic D14 | none |
| N17 | Number | |γ|/κ = (γ′−1)/(3−γ′) for a power law | ✅ PASS | critic D9 | none |
| N18 | Number | point mass |γ(θ+)||γ(θ−)| = 1 | ✅ PASS | critic D14 | none |
| N19 | Number | eigenvector (cos φγ, sin φγ) ↔ λ−; image stretched along φγ iff 1 − κ > 0 | ✅ PASS | critic D10 (numerical eigensystem); \|λ−\| < \|λ+\| ⇔ (1−κ)\|γ\| > 0 | none |
| N20 | Number | SIS κ = \|γ\| = θE/(2θ), λr = 1, κ(θE) = ½ | ✅ PASS | critic D9; problems_05.wl PASS "SIS from psi = tE theta …" | none |
| L1 | Number | bridge: "The m = 1 term carries no mass at all: it is a pure shift of the lens centre." | ❌ FAIL (physics wording) | critic D7: θ cos φ = θ₁ is a *linear* potential, i.e. a constant deflection, i.e. a shift of the **source** position (unobservable, per this chapter's own box "What in ψ is physical?"). Shifting an isothermal lens centre by δ adds −θE δ cos φ (∝ θ⁰), not ∝ θ cos φ. | "The m = 1 term carries no mass at all: θ cos φ = θ₁ is a linear potential, a constant deflection that only shifts the unobservable source position." |
| L2 | Number | MST bridge: "Only the unobservable source size and the absolute magnification change." | ⚠ SUSPECT (incomplete "only") | time delays scale as Δt → λΔt under the MST. This is the observable behind the H0 degeneracy (Chapter `galaxy_lensing`). | "…change, together with the time delays (∝ λ) and the physical mass normalization." |
| L3 | Number | Solutions: "the lens mapping has exactly three local observables" | ⚠ SUSPECT | the chapter's own MST bridge and reduced-shear box say shapes measure only g (2 numbers); κ is not locally observable | "three local degrees of freedom" |
| L4 | Number | Solutions: "without κ it would only distort shapes" | ⚠ SUSPECT (minor) | pure shear also changes area at O(γ²): μ = 1/(1−γ²) (chapter eq. `mu_pure_shear`) | "…without κ it would mainly distort shapes (area changes only at second order in γ)" |
| X1 | Consistency | **visible** "Properties of the Magnification" item 3: "|μ| > 1 … condition is (1−κ)² − |γ|² < 1" | ❌ FAIL (author flag 4, CONFIRMED) | critic D11: det A = −1.5 satisfies it but \|μ\| = 0.67 | see F1 |
| X2 | Consistency | **visible** pure convergence: "For κ > 1, the image is still magnified" | ❌ FAIL (author flag 5, CONFIRMED) | critic D11: μ(κ=3) = 1/4 | see F2 |
| X3 | Consistency | **visible** pure shear: "φγ = ½ arctan(γ2/γ1)" | ❌ FAIL (author flag 6, CONFIRMED) | critic D10: 90° error when γ1 < 0 (−22.5° vs true 67.5°) | see F3 |
| X4 | Consistency | **visible** line 285 "κ < 1 everywhere … a single mass concentration cannot produce multiple images" | ❌ FAIL (same as author flag 7 in 04) | C&K §2.5: holds only for axisymmetric lenses | see F4 |
| X5 | Consistency | every `\ref`/`\eqref` in the layer (ch:multipoles, ch:multiplane_dspl, ch:odd_images, ch:power_law_point_mass, ch:central_mass_bias, ch:msd_kinematics, ch:galaxy_lensing, ch:weak_lensing, ch:axisymmetric_models, ch:elliptical_models, sec:morse_theory, eq:gamma_circular, fig:convergence_shear_effects) | ✅ PASS | `.aux` labels resolve. Content matches: sec:morse_theory = §10.4 Morse theory; eq:gamma_circular = \|γ\| = κ̄ − κ (Ch 11); fig 9.1 caption μ ≈ 1.10 at \|γ\| = 0.3 | none |
| X6 | Consistency | "Module~\ref" vs "Chapter~\ref" mixed | ⚠ SUSPECT (cosmetic) | renders book chapter numbers either way | pick one word |

## Applied (auto-fixes)

None. Per the brief, the visible text is not edited in this pass. L1 is a physics wording issue, so it
is flag-only.

## Flagged: your hand required

- **F1 (author flag 4, CONFIRMED): `05_Magnification_Convergence_Shear.tex` lines 617–619.**
  "(1−κ)² − |γ|² < 1" is necessary but not sufficient. An image with det A = −1.5 satisfies it yet has
  |μ| = 0.67 (critic D11). Fix: "The condition is |det A| < 1, i.e. −1 < (1 − κ)² − |γ|² < 1." The
  annotation "Two refinements" already states this, so after the fix that annotation's sentence "The
  upper bound alone (item 3) is not enough" should be reworded or dropped.
- **F2 (author flag 5, CONFIRMED): line 750.** "For κ > 1, the image is still magnified" fails for
  κ > 2: μ = 1/(1−κ)² equals 1 at κ = 2 and 1/4 at κ = 3. Fix: "For 1 < κ < 2 the image is still
  magnified (for κ > 2 it is demagnified, e.g. μ = 1/4 at κ = 3) and *retains positive parity* …".
  The parity sentence is correct and can stay.
- **F3 (author flag 6, CONFIRMED): line 789.** "φγ = ½ arctan(γ2/γ1)" gives the wrong axis by 90°
  whenever γ1 < 0. Example: (γ1, γ2) = (−0.1, 0.1) gives −22.5° from this formula, but the stretch
  axis, computed from the eigenvector of the smaller eigenvalue of A, is 67.5° (critic D10). Fix:
  "φγ = ½ atan2(γ2, γ1), the two-argument arctangent (equivalently, γ1 = |γ| cos 2φγ, γ2 = |γ| sin 2φγ)."
  This is consistent with N&B eq. (57).
- **F4 (author flag 7, CONFIRMED here too): line 285.** Add "for an axisymmetric lens". C&K §2.5:
  supercriticality is necessary and sufficient for multiple imaging only in the axisymmetric case; in
  general it is sufficient but not necessary.
- **L1 (new layer): multipole bridge, "pure shift of the lens centre".** Wrong mechanism; use the
  proposed text in the table. Nothing else in that bridge changes: the (1−m²) factor, the ×3 and the
  "same axis" claims all pass (D7).
- **L2–L4:** wording; proposed text in the table.

## Prose (LLM tells): flag-only

The layer is 3623 words with **0 em-dashes** and no hollow intensifiers. The "not X" contrasts are
technical (spin-2 vs vector; tensors vs magnitudes; parity vs shape). Mild tells:
- "exactly" used as a pointer about 5 times ("is exactly what makes", "has exactly three local observables").
- One aphoristic line: "That independence is the whole argument."

Suggested rewrite: "Since the flux does not depend on ε, it must all come from the origin." Otherwise
the layer reads clean. (Provenance lens not run: the layer is machine-drafted by construction, commit
4f9b47d.)

## Derivation checks

Five or more load-bearing results were re-derived independently in the scratch script:

| D | result re-derived | verdict |
|---|-------------------|---------|
| D6 | axisymmetric Jacobian: eigenvalues 1 − α/θ (tangential) and 1 − α′ (radial, radial eigenvector); γ = −(κ̄−κ)e^{2iφ}; C&K 2.76 | ✅ PASS (finite differences, non-singular profile) |
| D7 | multipole κm = (1−m²)cos mφ/(2θ); m = 1 is a linear potential; m = 2 contour ratio 3 | ✅ PASS |
| D8 | two-plane Jacobian A = I − H1 − H2(I − β12 H1), non-symmetric, symmetric at β12 = 0 | ✅ PASS (finite differences) |
| D9 | power law + point mass λr crossings (1/2/0), θr = 0.25 θE, \|γ\|/κ = (γ′−1)/(3−γ′) | ✅ PASS |
| D10 | spin-2 law; atan2 orientation (67.5° vs −22.5°) | ✅ PASS |
| D11–D13 | magnification bookkeeping (\|det A\| < 1, κ = 3, pure-shear values, Ex 5.5), nascent δ, MST | ✅ PASS |

Scratch script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0405/critic_0405.wl`
→ `SUMMARY: 45 PASS, 0 FAIL  (of 45 checks)`. The first run gave 40/4. All four failures were
critic-script bugs (details in the 04 report).

Repo script: `bash Mathematica/run_wl.sh Solutions/05_Magnification_Convergence_Shear/problems_05.wl`
→ `SUMMARY: 50 PASS, 0 FAIL  (of 50 checks)`.
