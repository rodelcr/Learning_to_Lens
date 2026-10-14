# fact-critic report: Notes/04_Lens_Equation (Annotated Study Edition layer)

> Date: 2026-10-14. Lenses: Citation, Number, Consistency, Prose, Derivation.
> Scope: boxes added in commit 4f9b47d (`git diff c588432 4f9b47d -- Notes/04*`) in
> `04_Lens_Equation.tex` and `04_Solutions.tex`, the appended check section of
> `Solutions/04_Lens_Equation/problems_04.wl`, and the eight author flags about the visible text.
> The rest of the visible text was fact-critic'd in July 2026 and was not re-reviewed.
> Active adapters this run: bibtex n/a (the layer has no `\cite`), crossref-web off (no DOIs in scope),
> md-reflist off, values-file off, **reference-PDF ON** (`pdftotext -layout` of
> `Reference_Texts/` N&B 1997, Congdon & Keeton 2018, SEF 1992), **wolframscript ON**
> (`bash Mathematica/run_wl.sh`), repo-grep ON, doc-internal ON, overlay: none used.
> A claim with no active adapter is capped at ⚠ SUSPECT.

Scratch derivation script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0405/critic_0405.wl`
(shared with the module 05 report). It uses its own constants (CODATA G, exact c, IAU M☉, pc) and
its own distance integrator (NDSolve), so it is independent of `problems_04.wl`.

Verdict counts (rows below): **✅ PASS 32 · ⚠ SUSPECT 4 · ❌ FAIL 6**. All six FAILs are in the
pre-existing **visible** text (author flags 1, 2, 3, 7, plus two Σcr rounding slips in Ex. 4.4).
The new annotation layer has **0 FAIL**.

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "separation = angle × distance (Narayan & Bartelmann eq. 15)" | ✅ PASS | N&B PDF eq. (15), and the next paragraph says "in general Dds ≠ Ds − Dd" | none |
| C2 | Citation | "Ds tan β = Ds tan θ − Dds tan α̂ (Congdon & Keeton eq. 2.15)" (chapter + Solutions) | ✅ PASS | C&K PDF eq. (2.15), verbatim with Dls ≡ Dds | none |
| C3 | Citation | uniform Σcr sheet is a perfect lens "(Narayan & Bartelmann Sec. 2.1.3)" | ✅ PASS | N&B §2.1.3, text after eq. (18): "α(θ)=θ, and so β=0 … focuses perfectly" | none |
| C4 | Citation | mean κ inside θE is 1 "(N&B Sec. 2.1.4; C&K eq. 2.71)" | ✅ PASS | N&B §2.1.4 ("mean surface mass density inside the Einstein radius is just Σcr"); C&K eq. (2.71) κ̄(θE)=1 | none |
| C5 | Citation | "axisymmetric: κ>1 somewhere necessary and sufficient; general: sufficient, not necessary (C&K Sec. 2.5)" (chapter + Solutions) | ✅ PASS | C&K §2.5, opening paragraph, verbatim in substance | none |
| C6 | Citation | "Narayan & Bartelmann Sec. 2.1.3 note exceptions" | ✅ PASS | N&B end of §2.1.3: "multiple imaging occurs only if the lens is supercritical, but there are exceptions (Subramanian & Cowling 1986)" | none |
| C7 | Citation | pocket formula "Σcr = 0.35 g cm⁻² (D/1 Gpc)⁻¹ (N&B eq. 17)", "D = DdDds/Ds (their eq. 18)" | ✅ PASS | N&B eqs. (17), (18) | none |
| C8 | Citation | "weight D_jk/D_k … (Schneider, Ehlers & Falco Sec. 9.1)" | ✅ PASS | SEF eq. (9.3): x_j = x_1 − Σ_{i<j} (D_ij/D_j) α̂_i | none |
| C9 | Citation | μ⁻¹ = (β/θ)(dβ/dθ) = (1−α/θ)(1−dα/dθ) "(Congdon & Keeton eq. 2.23)" | ✅ PASS | C&K eq. (2.23) | none |
| C10 | Citation | "|μ+|=1.171, |μ−|=0.171, total 1.342 (N&B eq. 29)" (chapter + Solutions) | ✅ PASS | N&B eq. (29): µ = 1.17 + 0.17 = 1.34 | none |
| N1 | Number | "Ds − Dd = 1652 − 919 = 733 Mpc, while Dds = 1055 Mpc" | ✅ PASS | critic D1 (918.77, 1651.91, 1054.72 Mpc) | none |
| N2 | Number | "(1+zs)Dds = (1+zs)Ds − (1+zd)Dd" (flat) | ✅ PASS | problems_04.wl PASS "flat-universe identity …"; critic D1 uses the comoving definition directly | none |
| N3 | Number | "underestimate Dds/Ds … by about 30%" | ✅ PASS | critic D1: 733/1055 = 0.695 | none |
| N4 | Number | "Dds/Ds = 0.64 for zs=1 and 0.77 for zs=2" | ✅ PASS | critic D1 | none |
| N5 | Number | "B = (Dds1/Ds1)/(Dds2/Ds2) … zd=0.3, zs1=1, zs2=2 … B = 0.83" | ✅ PASS | critic D1: B = 0.8298, < 1; matches the preamble definition `\Brat` = D_ls1 D_s2/(D_s1 D_ls2) | none |
| N6 | Number | "Σcr(zs=2)/Σcr(zs=1) = 0.83 … convergence 1/0.83 ≈ 1.2 times larger" | ✅ PASS | critic D1: identical to B (Dd cancels) | none |
| N7 | Number | "tan x/x … below 2×10⁻⁸ even for a 37″ cluster Einstein radius"; Solutions "≲10⁻⁴ rad … less than 10⁻⁸" | ✅ PASS | critic D14: 1.07e−8 and 3.3e−9 | none |
| N8 | Number | "|z| ≲ 100 kpc … ~10⁻⁴ of Dd" | ✅ PASS | critic D1: 0.1/919 = 1.1e−4 | none |
| N9 | Number | "1 M☉ pc⁻² = 2.09×10⁻³ kg m⁻² … 1 g cm⁻² ≈ 4.79×10³ M☉ pc⁻²" | ✅ PASS | critic D4 | none |
| N10 | Number | "D = 587 Mpc, giving 0.59 g cm⁻²" | ✅ PASS | critic D4: coefficient 0.347 g cm⁻² Gpc; 0.347/0.587 = 0.59 | none |
| N11 | Number | "5.92 kg m⁻² = 2.83×10³ … c = 3×10⁸ gives 2.84×10³ … 0.1% difference" | ✅ PASS | critic D4: 2833.5 vs 2837.3 (0.13%) | none |
| N12 | Number | "4GM☉/c² = 5.91×10³ m (twice the Sun's Schwarzschild radius)" | ✅ PASS | critic D2: 5906.7 m | none |
| N13 | Number | microlensing "θE² = 1.91×10⁻¹⁷, θE = 4.38×10⁻⁹ rad = 0.90 mas; RE = 6.8×10¹¹ m ≈ 4.5 AU = 2.2×10⁻⁵ pc" | ✅ PASS | critic D2: 4.375e−9 rad, 0.902 mas, 4.51 AU | none |
| N14 | Number | scaling "0.90 mas … Dd Ds/Dds = 1439 Mpc … 2.4″" | ✅ PASS | critic D2; same coefficient as N&B eq. (22) | none |
| N15 | Number | Ex 4.3(b) "6.95×10⁻⁴ Mpc⁻¹ = 2.25×10⁻²⁶ m⁻¹, θE² = 1.33×10⁻¹⁰, 1.15×10⁻⁵ rad = 2.4″, 10.6 kpc" | ✅ PASS | critic D2; problems_04.wl PASS "Ex 4.3(b) …" | none |
| N16 | Number | Ex 4.3(c) "2×10¹⁴: 1.79×10⁻⁴ rad = 37″, RE = 165 kpc; 10¹⁵: √5×37″ ≈ 83″, 0.37 Mpc" | ✅ PASS | critic D2: 36.93″ and 82.58″ | none |
| N17 | Number | Ex 4.4 box "1.07×10²⁶ kg m⁻¹ … 5.52×10⁻²⁶ m⁻¹ … 5.92 … 2.83×10³ … 0.83 … 2.35×10³ … 4.9 kg m⁻²" | ✅ PASS | critic D4: Σcr(zs=2) = 2351 M☉ pc⁻² | none |
| N18 | Number | "κ0 = 5000/2350 ≈ 2.1" | ✅ PASS | arithmetic 2.13 | none |
| N19 | Number | Ex 4.5 β=0.5 row "2.0616 … +1.2808, −0.7808 … 1.0914 … 1.591, 0.591" | ✅ PASS | critic D3 | none |
| N20 | Number | "3/√5 = 1.342, split as 1.171 + 0.171" | ✅ PASS | critic D14 | none |
| X1 | Consistency | **visible** Ex 4.3(a): "√(5.906×10⁻¹⁰ × 1/3.086×10²⁰) = √(1.914×10⁻³⁰) ≈ 1.38×10⁻¹⁵ rad ≈ 0.28 mas … RE ≈ 2.1×10⁻¹⁰ Mpc ≈ 6.6×10⁻⁵ pc ≈ 14 AU" | ❌ FAIL (author flag 1, confirmed) | critic D2; chapter eq. `thetaE_microlensing` (0.9 mas); the layer's own box N13 | see Flagged F1 |
| X2 | Consistency | **visible** Ex 4.3(c) statement "M = 10¹⁵ M☉" vs solution "M_E ∼ 2×10¹⁴" (37″) | ❌ FAIL (author flag 2, confirmed) | critic D2: 10¹⁵ gives 82.6″; chapter example (c) uses M_E = 2×10¹⁴ | see F2 |
| X3 | Consistency | **visible** Ex 4.5 table, β = 0.1″ row "+1.025, −0.975, 2.000" | ❌ FAIL (author flag 3, confirmed) | critic D3: +1.0512, −0.9512, 2.0025; the printed pair is the β = 0.05″ row. |μ±| = 5.519/4.519 is correct for β = 0.1 | see F3 |
| X4 | Consistency | **visible** bullet "If κ<1 everywhere … cannot produce multiple images of a generic source" | ❌ FAIL (author flag 7, confirmed) | C&K §2.5 (true only for axisymmetric lenses); N&B §2.1.3 "exceptions" | see F4 |
| X5 | Consistency | **visible** chapter display "≈ 2840 M☉ pc⁻²" with c = 3×10⁸ | ✅ PASS (author flag 8: not an error) | critic D4: 2837 → "≈2840" is correct for the displayed inputs; annotation N11 reconciles it with 2833 | none for the chapter; see F5 for the Solutions |
| X6 | Consistency | **visible** Ex 4.4(b) solution: displayed with c = 2.998×10⁸, then "≈ 2840 M☉ pc⁻²" | ❌ FAIL | critic D4: 2.998e8 gives 2833 → "≈2830"; annotation box in the same file says 2.83×10³ | see F5 |
| X7 | Consistency | **visible** Ex 4.4(c) "≈ 2360 M☉ pc⁻²" vs annotation "2.35×10³" | ❌ FAIL | critic D4: 2351 (2354 with c = 3e8) | see F5 |
| X8 | Consistency | Dds(0.3, 2) printed as 1329 Mpc throughout | ⚠ SUSPECT (rounding) | critic D1: 1328.49 Mpc by both NDSolve and NIntegrate (H0 = 70, Ωm = 0.3) | optional: 1328; no downstream number changes at printed precision |
| X9 | Consistency | every `\ref{ch:…}`/`\ref{sec:…}`/`\eqref` in the layer | ✅ PASS | `Notes/*/*.aux` labels: ch:galaxy_lensing → Ch 13, ch:multiplane_dspl → Ch 18, ch:cosmological_sensitivity → Ch 24, ch:power_law_point_mass → Ch 19, ch:odd_images → Ch 20, sec:surface_mass_density → §8.5, eq:thetaE_microlensing → (8.23); content matches | none |
| X10 | Consistency | layer mixes "Module~\ref{…}" and "Chapter~\ref{…}" for the same kind of target | ⚠ SUSPECT (cosmetic) | rendered numbers are book chapter numbers (main.toc), so "Module 13" is printed for Chapter 13 | pick one word, e.g. "Chapter~\ref" |
| F-a | Number | bridge "Σcr is the only place in single-plane lensing where the source redshift appears" | ⚠ SUSPECT | the time-delay distance D_Δt = (1+zd)DdDs/Dds also depends on zs, but only through the same Ds/Dds | "the source redshift enters only through Dds/Ds (in Σcr, and in D_Δt for time delays)" |
| F-b | Number | "Fainter, more distant sources are more strongly lensed" | ⚠ SUSPECT (wording) | physics is "more distant" (larger Dds/Ds). "Fainter" is an implied correlation, not a lensing statement | drop "Fainter," |

## Applied (auto-fixes)

None. Per the brief, the visible text is not edited in this pass, and the annotation layer has
no number that failed against a single canonical source.

## Flagged: your hand required

All of these are in the **pre-existing visible text**. Each was checked with a scratch computation
(critic D-rows) and a reference PDF where one applies.

- **F1 (author flag 1, CONFIRMED): Ex 4.3(a), `04_Solutions.tex` lines 160–168.** The value
  4GM☉/c² is written as `5.906 × 10^{-10}`. The correct value is 5.906×10³ m (critic D2: 5906.7 m).
  Everything downstream is wrong as a result. Replace with:
  `\sqrt{5.906\times10^{3}\times\frac{1}{3.086\times10^{20}}} = \sqrt{1.914\times10^{-17}} \approx 4.38\times10^{-9}~\text{rad} \approx 0.90~\text{mas}`;
  and `R_E = 5\times3.086\times10^{19}\times4.38\times10^{-9} \approx 6.8\times10^{11}~\text{m} \approx 2.2\times10^{-11}~\text{Mpc} \approx 2.2\times10^{-5}~\text{pc} \approx 4.5~\text{AU}`.
  Computed values: θE = 4.375×10⁻⁹ rad = 0.902 mas; RE = 6.75×10¹¹ m = 4.51 AU. These match chapter
  eq. (8.23) `thetaE_microlensing` (0.9 mas) and the layer's derivation box.
- **F2 (author flag 2, CONFIRMED): Ex 4.3(c).** The statement (`04_Lens_Equation.tex` line 1142) gives
  M = 10¹⁵ M☉. The solution uses M_E ∼ 2×10¹⁴ M☉ and gets 37″. Inserting 10¹⁵ gives 82.6″ ≈ 83″ and
  RE = 0.37 Mpc (critic D2). Recommended fix: make the statement match the chapter's own example (c):
  "**Cluster lensing:** mass M_E ≈ 2×10¹⁴ M☉ inside the Einstein radius (total M₂₀₀ ∼ 10¹⁵ M☉), zd = 0.3, zs = 2."
  The alternative is to keep 10¹⁵ and change the solution to 83″ / 0.37 Mpc, with the existing
  annotation explaining why that overestimates.
- **F3 (author flag 3, CONFIRMED): Ex 4.5(a) table, `04_Solutions.tex` line 295.** The β = 0.1″ row
  prints the β = 0.05″ positions. Correct row (3 d.p., matching the table):
  `0.1 & $+1.051$ & $-0.951$ & 2.002 & 5.519 & 4.519 \\`. Computed: θ± = +1.05125, −0.95125;
  Δθ = 2.00250 (exactly √4.01). The |μ±| columns were already correct.
  This annotation layer's own "three checks on every row" (θ₊ + θ₋ = β) would have caught it, since
  1.025 − 0.975 = 0.05 ≠ 0.1.
- **F4 (author flag 7, CONFIRMED): `04_Lens_Equation.tex` line 498 bullet.** The same unqualified
  statement appears at `05_Magnification_Convergence_Shear.tex` line 285. C&K §2.5: "supercriticality
  is a necessary and sufficient condition for an *axisymmetric* lens to produce multiple images. This
  condition remains sufficient in the non-axisymmetric case, but it is not necessary." N&B §2.1.3 says
  the same ("there are exceptions"). Proposed fix: "If κ < 1 everywhere, an **axisymmetric** lens is
  subcritical: … it cannot produce multiple images. (For non-axisymmetric lenses, shear can produce
  multiple images even with κ < 1 everywhere.)" The annotation already says this, but the bullet itself
  should be correct.
- **F5 (author flag 8, PARTLY CONFIRMED): Σcr rounding.** The chapter display (eq. `sigma_cr_numerical`,
  c = 3×10⁸ → 2837 → "≈ 2840") is **correct** for its stated inputs, so no change is needed there. The
  real inconsistency is in **Ex. 4.4 in `04_Solutions.tex`**:
  - (b), line 244: displayed with c = 2.998×10⁸ but quotes "≈ 2840". The correct value is 2833, so
    write "≈ 2830 M☉ pc⁻²", or round c to 3×10⁸ in that display.
  - (c), line 250: "≈ 2360". The correct value is 2351 (2354 with c = 3×10⁸), so write "≈ 2350". The
    annotation box already says 2.35×10³.
  - (d) "5000/2840 ≈ 1.8" stays 1.8 either way.
  The simplest single fix is to switch the chapter display to c = 2.998×10⁸ and "≈ 2830". The
  annotation's "Precision note" would then be unnecessary.
- **X8 (minor): Dds(zd=0.3, zs=2).** This evaluates to 1328.49 Mpc with this cosmology, so 1328 rather
  than 1329. No printed downstream number changes. Leave as is unless the Module 03 script is re-run.
- **F-a, F-b, X10:** wording, listed in the table with proposed text.

## Prose (LLM tells): flag-only

The layer is 3415 words with **0 em-dashes**. There are no triads used as ornament and no hollow
intensifiers. Every "X, not Y" contrast carries technical content (for example, "the *mean* κ inside a
circle, not its value at one point"). The one mild tell is the pointer word **"exactly"**, used as
emphasis about 6 times: "This is exactly the efficiency factor", "dominates exactly where", "uses
exactly this mechanism". Suggested: drop it where it is not a mathematical "exactly", for example
"This is the efficiency factor Dds/Ds of this section with (d,s) → (j,k)." Otherwise the layer reads
clean. (Provenance lens not run: the whole layer is machine-drafted by construction, see commit 4f9b47d.)

## Derivation checks

Five load-bearing displayed results were re-derived independently in the scratch script:

| D | result re-derived | verdict |
|---|-------------------|---------|
| D1 | angular-diameter distances, Dds ≠ Ds − Dd (733 vs 1055), Dds/Ds, B = 0.8298 = Σcr ratio | ✅ PASS (NDSolve, cross-checked with NIntegrate) |
| D2 | θE for micro/galaxy/cluster cases, RE, 0.90 mas scaling; reproduces the visible 1.38e−15 error | ✅ PASS |
| D4 | Σcr = 5.92 kg m⁻² = 0.59 g cm⁻² = 2833 (2837 at c = 3e8); N&B eq. 17 coefficient 0.347 | ✅ PASS |
| D5 | 2-D shell theorem: ∮(x − r cos φ)/(x² + r² − 2xr cos φ) dφ = 2π/x (r<x), 0 (r>x), numerical | ✅ PASS |
| D3/D6/D14 | point-mass roots and Vieta; Ex 4.5 table; μ = (θ/β)(dθ/dβ) = 1/(λt λr) by finite-difference Jacobian of a radial map | ✅ PASS |

Scratch script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0405/critic_0405.wl`
→ `SUMMARY: 45 PASS, 0 FAIL  (of 45 checks)`. The first run gave 40/4. All four failures were
critic-script bugs, fixed before the final run: a rounding tolerance that tripped on Dds = 1328.5, a
contour ε that was too large for a first-order ratio, FindRoot precedence, and a non-curl-free test
deflection.

Repo script: `bash Mathematica/run_wl.sh Solutions/04_Lens_Equation/problems_04.wl`
→ `SUMMARY: 54 PASS, 0 FAIL  (of 54 checks)`.

## Resolution — fixes applied 2026-10-14

Branch `wt/ann0405`. New checks live in the "Fix-pass checks (2026-10-14)" section at the end of
`Solutions/04_Lens_Equation/problems_04.wl`. Each one compares the value printed in the text, held
as a literal, with the computed value. A mutation run that restored the old printed literals
(5.906e-10 / 1.38e-15 / 0.28 mas / 14 AU; M = 1e15 statement; 1.025/−0.975/2.000; 2840; 2360; 1329)
failed 9 of the new checks (59 PASS / 9 FAIL).

| id | Fix | Backing |
|----|-----|---------|
| F1 / X1 | Ex 4.3(a) (`04_Solutions.tex`): 4GM☉/c² = 5.906×10³ m; √(1.914×10⁻¹⁷) ≈ 4.38×10⁻⁹ rad ≈ 0.90 mas; R_E ≈ 6.8×10¹¹ m ≈ 2.2×10⁻¹¹ Mpc ≈ 2.2×10⁻⁵ pc ≈ 4.5 AU. A sentence after the result says the earlier printing had 5.906×10⁻¹⁰ m and that the result now agrees with eq. `thetaE_microlensing`. | `F1 Ex 4.3(a) printed 4GM/c^2 …`, `F1 … thetaE = 4.38e-9 rad = 0.90 mas`, `F1 … R_E = 6.8e11 m …` |
| F2 / X2 | Ex 4.3(c) statement (`04_Lens_Equation.tex`): "mass M_E ≈ 2×10¹⁴ M☉ inside the Einstein radius (total M₂₀₀ ∼ 10¹⁵ M☉)". The Solutions derivation box was reworded to match: the statement now gives the mass inside θ_E, and the total M₂₀₀ would give 83″. | `F2 Ex 4.3(c): statement mass M_E = 2e14 …` (37″, 165 kpc); `F2 … M200 = 1e15 would NOT give 37"` |
| F3 / X3 | Ex 4.5 table, β = 0.1″ row → `+1.051 & −0.951 & 2.002 & 5.519 & 4.519` | `F3 Ex 4.5 printed row beta = 0.1 …` (this check also tests θ₊ + θ₋ = β) |
| F4 / X4 | κ < 1 bullet → "an **axisymmetric** lens is subcritical … cannot produce multiple images. (For a non-axisymmetric lens, shear can produce multiple images even with κ < 1 everywhere; Congdon & Keeton Sec. 2.5.)" | C&K §2.5 (critic C5); counter-example to the old wording: `F4 kappa <= 0.8 everywhere …` + `F4 with external shear 0.4 … 3 images; axisymmetric (no shear): 1` |
| F5 / X6 | Ex 4.4(b): "≈ 2830 M☉ pc⁻² (2840 if c is rounded to 3×10⁸, as in eq. `sigma_cr_numerical`)" | `F5 Ex 4.4(b) printed Sigma_cr = 2830 …` |
| F5 / X7 | Ex 4.4(c): 2360 → 2350 M☉ pc⁻² | `F5 Ex 4.4(c) printed Sigma_cr(z_s = 2) = 2350 …` |
| F5 (d) | Ex 4.4(d): 5000/2840 → 5000/2830 (≈ 1.8, unchanged), for consistency with (b) | `F5 Ex 4.4(d) printed kappa_0 = 5000/2830 = 1.8 …` |
| X8 | D_ds(0.3, 2): 1329 → 1328 Mpc everywhere in Ch. 4 text and Solutions (chapter l.745, Ex 4.3(c) statement, Solutions Ex 4.3(c)/4.4(c)), and in `problems_04.wl` (worked solution + checks). No printed downstream number changes. Other chapters already print 1328. | `X8 D_ds(0.3, 2) = 1328 Mpc …` (computed 1328.49); `X8 the 1329 -> 1328 change moves no printed number …`; the distances check now requires `Round[...] == {919, 1652, 1055, 1727, 1328}` |
| F-a | Bridge "Where the source redshift enters": "In single-plane lensing the source redshift enters only through D_ds/D_s: in Σcr and, for time delays, in the time-delay distance (1+z_d)D_dD_s/D_ds (Chapter~\ref{ch:fermat_time_delays})." | `F-a Sigma_cr and the time-delay distance … depend on (Ds, Dds) only through Ds/Dds` |
| F-b | Ex 4.4(d) annotation: dropped "Fainter," | wording |
| X10 | Every `Module~\ref{…}` in `04_Lens_Equation.tex` / `04_Solutions.tex` → `Chapter~\ref{…}` (visible and layer; the ref prints the book chapter number) | build, no `??` |
| Prose | "This is exactly the efficiency factor" → "This is the efficiency factor" | wording |

### Verification after edits

- `bash Mathematica/run_wl.sh Solutions/04_Lens_Equation/problems_04.wl`. Before:
  `SUMMARY: 54 PASS, 0 FAIL  (of 54 checks)`. After: `SUMMARY: 68 PASS, 0 FAIL  (of 68 checks)`.
- `cd Notes && ANNOT_REQUIRED=1 bash build.sh` ended with "Build complete: all assertions passed".
  Student 360 pp, Instructor 444 pp, Annotated 569 pp (fingerprints are in the module 05 Resolution section and the fix report).

### Left open

- Hard-coded "Module~3 / Module~5 / Module~10 …" in the visible text: these are module numbers, not `\ref`s. They were left alone because they are outside X10's scope.
- `Mathematica/04_Lens_Equation/lens_equation.wl` l.129 still uses `DdsClus = 1329`. That directory is not in this fixer's file list, so this goes to the orchestrator.
- The "exactly" pointer words beyond the one the critic quoted were left as is (flag-only).

### Session-3 closeout (2026-10-14, orchestrator)
- `lens_equation.wl:129` already reads `DdsClus = 1328` (changed in session 2). Closed.