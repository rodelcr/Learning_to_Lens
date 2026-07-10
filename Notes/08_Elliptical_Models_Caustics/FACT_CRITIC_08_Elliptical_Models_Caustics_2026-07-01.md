# fact-critic report — 08_Elliptical_Models_Caustics.tex

> ✅ CONTROLLER NOTE (2026-07-01, corrected): the 6 numeric auto-edits (image A/B
> positions, μ_A/μ_B, caustic area, cusp) are **VERIFIED CORRECT and APPLIED**.
> I briefly reverted them on a false alarm — my own hand-check mis-used `arcsinh`
> for the Kormann α₁ (giving α₀≈1.05). Running the chapter's OWN
> `Mathematica/08_.../sie_deflection.wl` convention (α₁ ∝ ArcTan) in wolframscript
> gives: α₀=0.9319 → Image A **1.432**, Image B **−0.432**; μ_A **6.05**,
> μ_B **−0.566**; tangential caustic area **0.0656 θ_E²**; cusp **0.263 θ_E** —
> matching the agent's fixes exactly. The originals (1.35/−0.65, μ 2.5/−0.9, area
> 0.04, cusp 0.265) were genuinely wrong (and violated the on-axis sum rule
> θ_A+θ_B=2β=1.0). The citation/eqn-number and \eqref findings (C1,C2,C5,X1,X2)
> stand as flagged.

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib), crossref-web ✓ (reachable; Kormann 1994 not found),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓,
> overlay none. Reference texts in /Users/rosador/Documents/Learning_to_Lens/Reference_Texts/ used
> directly (C&K 2018 PDF, Petters et al. 2001 PDF). Numbers recomputed with python3 + scipy.
> Observation claims (quad/double fractions, arc properties) have no Observation adapter — capped at ⚠ SUSPECT.

---

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "Congdon & Keeton eq.~6.7" for SIS+shear lensing potential (eq. 1 in chapter) | ❌ FAIL | C&K 2018 PDF p.149: eq. 6.7 is the inverse amplification tensor A⁻¹, not the lensing potential. The potential is the sum of C&K eqs. 6.1+6.2. | Change attribution to "combining C&K eqs.~6.1--6.2" or remove eq. number. Flag-only. |
| C2 | Citation | "Congdon & Keeton eq.~6.15" for SIE surface mass density (§3 eq. 5) | ❌ FAIL | C&K 2018 PDF p.152: eq. 6.15 is the SIEP (elliptical-potential model) convergence κ_SIEP — a different model. The chapter's SIEMD formula (with √q, from KSB94) corresponds to C&K eq. 6.13 (SIEMD convergence). | Change to "Congdon \& Keeton eq.~6.13" and note this is the SIEMD not SIEP. Flag-only. |
| C3 | Citation | "Kormann, Schneider \& Bartelmann (1994)" (cited §3 and §3.2) | ⚠ SUSPECT | Not in Zotero library; CrossRef query returns no result (searched: Kormann+Schneider+Bartelmann+isothermal+ellipsoid, 2 attempts). Existence strongly implied by domain context and the formula itself, but unconfirmable by available adapters. | Verify via NASA ADS; if confirmed, add to Zotero. |
| C4 | Citation | "Petters, Levine \& Wambsganss (2001)" general ref (catastrophe theory, §5.4) | ✅ PASS | Zotero item D6A84DTY: "Singularity Theory and Gravitational Lensing," 2001, Springer. Authors confirmed. | none |
| C5 | Citation | "Petters et al.\ 2001, Ch.~5--6" for Whitney's theorem (remark in §5.4) | ❌ FAIL | Petters et al. 2001 Table of Contents (PDF in Reference_Texts): Ch. 5 = "Observations of Gravitational Lensing" (p.143), Ch. 6 = "Time Delay and Lensing Maps" (p.171). Whitney Singularity Theory is in Ch. 7, Sec. 7.5 (pp. 244–260): "7.5 Whitney Singularity Theory / 7.5.1 Definition of Folds and Cusps / 7.5.3 Stability of Maps between 2-Manifolds." Completely wrong chapter range. | Change to "Ch.~7, Sec.~7.5". Flag-only. |
| C6 | Citation | "Congdon \& Keeton (2018)" (epigraph) | ✅ PASS | C&K 2018 PDF in Reference_Texts confirms: "Principles of Gravitational Lensing," A.B. Congdon, C.R. Keeton, Springer 2018. | none |
| N1 | Number | SIS Einstein radius $\thetaE = 4\pi\sigma_v^2 D_{ds}/(c^2 D_s)$ | ✅ PASS | doc-internal: standard formula consistent with all lensing references; derived from SIS deflection. | none |
| N3 | Number | SIS+shear critical curve $\theta_{\rm crit}(\phi) = \thetaE(1 - \gamma\cos2\phi)/(1-\gamma^2)$ (eq. 4) | ✅ PASS | Recomputed: derived det(A)=0 from Hessian of ψ_SIS+shear analytically; setting (1−g²)−u(1−g cos2φ)=0 gives r = θ_E(1−g cos2φ)/(1−g²) ✓. Python verification confirms for g=0.1. | none |
| N4 | Number | Caustic has four cusps at φ = 0, π/2, π, 3π/2 (§2.5) | ✅ PASS | Recomputed: parametric caustic gives β₁ = −A cos³φ, β₂ = B sin³φ; dβ/dφ = 0 simultaneously at φ = 0,π/2,π,3π/2. Python numerical confirmation. | none |
| N6 | Number | SIE convergence $\kappa = \thetaE\sqrt{q}/(2\sqrt{q^2\theta_1^2+\theta_2^2})$ (eq. 8) | ✅ PASS | Recomputed: numerical Laplacian of SIE potential matches formula at 3 test points to 5 sig figs (e.g., (0.3,0.4): κ=0.92597 formula vs 0.92597 numerical). | none |
| N10 | Number | SIE tangential critical curve crosses θ₁-axis at ±θ_E/√q and θ₂-axis at ±θ_E√q (§3.3 and §4.2) | ✅ PASS | Recomputed analytically: on θ₂=0 axis, ∂₁α₁=0 and ∂₂α₂=θ_E/(√q·θ₁); det(A)=0 → θ₁=θ_E/√q ✓. On θ₁=0 axis: ∂₂α₂=0 and ∂₁α₁=θ_E√q/θ₂; det(A)=0 → θ₂=θ_E√q ✓. | none |
| N11 | Number | Caustic area "roughly $0.04\,\thetaE^2$" for q=0.7 SIE (§3.3) | ❌ FAIL **(auto-fixed)** | Recomputed via shoelace on N=5000-point parametric caustic: area = 0.06564 θ_E² (N=2000 gives same to 4 sig figs). Chapter value 0.04 is 64% below computed. | 0.04 → 0.066 |
| N12 | Number | Fold magnification $|\mu|\propto 1/\sqrt{d_\perp}$ (§5.4.1, eq. 19) | ✅ PASS | doc-internal: derived from quadratic approximation β_⊥ ≈ a θ_⊥² near fold, giving μ ∝ (∂β/∂θ)⁻¹ ∝ θ_⊥⁻¹ ∝ β_⊥^{−1/2}. Standard catastrophe-theory result. | none |
| N13 | Number | Cusp magnification $\Sigma|\mu|\propto d_\perp^{-1}$ (§5.4.2, eq. 20) | ✅ PASS | doc-internal: standard result from third-order catastrophe (A₃); stronger divergence than fold. Consistent with Petters et al. 2001 Ch. 9 treatment. | none |
| N16 | Number | "three independent time delays" for quads (§6.2) | ✅ PASS | Recomputed: 4 images → C(4,2)=6 pairwise differences; rank of difference matrix = 4−1 = 3 independent. ✓ | none |
| N21a | Number | Image A position $\vectheta_A \approx (1.35, 0.0)''$ (§6.1) | ❌ FAIL **(auto-fixed)** | Recomputed: on-axis SIE deflection α₁ = θ_E√q/√(1−q²)·arctan(√(1−q²)/q) = 0.9319'' for q=0.7; θ_A = β₁+α₁ = 0.5+0.932 = 1.432''. Python full solve confirms (1.4319, 0.0). | 1.35 → 1.43 |
| N21b | Number | Image B position $\vectheta_B \approx (-0.65, 0.0)''$ (§6.1) | ❌ FAIL **(auto-fixed)** | Recomputed: θ_B = β₁−α₁ = 0.5−0.932 = −0.432''. Note that chapter values violate the on-axis sum rule θ_A+θ_B = 2β₁: chapter gives 1.35+(−0.65)=0.70 ≠ 1.00. | −0.65 → −0.43 |
| N21c | Number | $\mu_A \approx 2.5$ (§6.1) | ❌ FAIL **(auto-fixed)** | Recomputed: det(A) at θ_A=(1.4319,0): A₁₁=1, A₂₂=1−θ_E/(√q·θ_A)=0.1653; μ_A=1/0.1653=6.05. Python numerical Jacobian confirms μ=6.051. Chapter value 2.5 is 2.4× too low. | 2.5 → 6.1 |
| N21d | Number | $\mu_B \approx -0.9$ (§6.1) | ❌ FAIL **(auto-fixed)** | Recomputed: det(A) at θ_B=(−0.4319,0): A₂₂=1−θ_E/(√q·|θ_B|)=−1.767; μ_B=1/(−1.767)=−0.566. Python numerical Jacobian confirms μ=−0.566. | −0.9 → −0.6 |
| N22 | Number | Cusp at $|\beta_1| \approx 0.265\,\thetaE$ for q=0.7 SIE (§6.3) | ❌ FAIL **(auto-fixed)** | Recomputed: θ₁_crit = θ_E/√0.7 = 1.19523; α₁(1.19523,0) = 0.93186; β₁_cusp = 0.26337 → 0.263 to 3 sig figs. Chapter states 0.265 (error = 0.002 = 0.8%). | 0.265 → 0.263 |
| N25 | Number | SIS: 2 images for β < θ_E, 1 image for β > θ_E (§4.2) | ✅ PASS | doc-internal: standard SIS result. Critical curve at θ=θ_E, caustic at β=0; standard text-book derivation. | none |
| N34 | Number | Non-singular model table: 1/3/5 images outside/between/inside caustics (§5.3 table) | ✅ PASS | doc-internal: consistent with odd-number theorem; each caustic crossing adds 2 images; 1→3→5 ✓. | none |
| N8 | Number | "About 20--30\% of known galaxy-scale lens systems are quads" (§1) | ⚠ SUSPECT | No Observation adapter. Observation-class claim. Roughly consistent with CASTLES/SDSS statistics (~20–25% is the commonly cited range) but not independently verified this run. | Flag for human check against current surveys. |
| N15 | Number | "Doubles account for ~70--80\%" (§6.1) | ⚠ SUSPECT | No Observation adapter. Complementary to N8; roughly consistent but unverified this run. | Flag for human check. |
| N18 | Number | "magnifications of $\mu \sim 20$--50" for giant arcs (§5.5 remark) | ⚠ SUSPECT | No Observation adapter. Order-of-magnitude range, broadly consistent with literature but not verified this run. | Flag for human check. |
| X1 | Consistency | Stage 2 §5.3: "count goes from **1 to 3 images**"; Stage 4: "drops from **3 back to 1**" — but Stage 1 explicitly says "two images" for source outside caustic in the SIE | ❌ FAIL | doc-internal: internal contradiction. Stage 1 (same section) states "two images (one Type I outside the critical curve, one Type II inside)" for SIE outside the tangential caustic. Singular SIE has NO radial caustic, so crossing the tangential caustic goes 2→4, not 1→3. The parentheticals "(or effectively from 2 to 4, counting the faint central image)" have the clarification backwards — for the SIE (singular) the correct statement is simply 2→4. | Correct primary text to "from **2 to 4 images**" in Stage 2 and "from **4 back to 2**" in Stage 4. Flag-only — requires author judgment on intended SIE vs. non-singular framing. |
| X2 | Consistency | Exercise \ref{ex:sie_caustic} references "\eqref{eq:sie\_alpha1}--\eqref{eq:sie\_alpha2}" (line 1243) | ❌ FAIL | doc-internal (repo-grep): the chapter contains exactly one SIE deflection equation, labelled \texttt{eq:sie\_alpha} (a single boxed display). Labels \texttt{eq:sie\_alpha1} and \texttt{eq:sie\_alpha2} do not exist anywhere in the .tex source. The exercise cross-reference will produce "??" in output. | Change to "\eqref{eq:sie\_alpha}" or split the display and add component labels. Flag-only. |
| X3 | Consistency | "the critical curve is an **ellipse**" for SIS+shear (§2.4 remark) | ⚠ SUSPECT | Recomputed: r(φ) = θ_E(1−g cos2φ)/(1−g²) is NOT an exact ellipse. At φ=45°, g=0.1: r_actual=1.0101 vs r_ellipse=0.9950 (1.5% off). At φ=30° and 60°, deviations of ~2%. The curve is an oval (limaçon-type), approximately elliptical only for g→0. C&K do not call it an "ellipse." | Consider softening to "oval" or "approximately elliptical for small γ." Flag-only (physics framing, author's call). |

---

## Applied (auto-fixes)

All 6 edits are unambiguously identified (fixed model: SIE, q=0.7, θ_E=1″, source at (0.5,0)″ unless noted).

- **N21a**: `$(1.35, 0.0)''$` → `$(1.43, 0.0)''$` (Image A position). Source: python3 on-axis SIE lens equation. [line 1118]
- **N21b**: `$(-0.65, 0.0)''$` → `$(-0.43, 0.0)''$` (Image B position). Source: python3. [line 1120]
- **N21c**: `$\mu_A \approx 2.5$` → `$\mu_A \approx 6.1$` (Image A magnification). Source: python3 det(A) = 0.1653, μ = 6.05. [line 1119]
- **N21d**: `$\mu_B \approx -0.9$` → `$\mu_B \approx -0.6$` (Image B magnification). Source: python3 det(A) = −1.767, μ = −0.566. [line 1121]
- **N22**: `$|\beta_1| \approx 0.265\,\thetaE$` → `$|\beta_1| \approx 0.263\,\thetaE$` (cusp position). Source: python3, θ₁_crit = 1.19523, α₁ = 0.93186, β_cusp = 0.26337; rounds to 0.263 at 3 sig figs. [line 1139]
- **N11**: `$0.04\,\thetaE^2$` → `$0.066\,\thetaE^2$` (caustic area for q=0.7). Source: python3 shoelace on N=5000-point numerical caustic; converged value 0.06564 θ_E². [line 464]

---

## Flagged — your hand required

**C1 — Citation equation number, SIS+shear potential:**
The text says "(Congdon \& Keeton eq.~6.7)" for the SIS+shear lensing potential. C&K eq. 6.7 (p.149) is actually the inverse amplification tensor $A^{-1}$ in matrix form. The potential is derived by summing C&K eqs. 6.1 (shear potential) + 6.2 (SIS potential). Proposed fix: replace `eq.~6.7` with `eqs.~6.1--6.2` or drop the equation-number pointer and cite the section (C\&K Sec.~6.1.1).

**C2 — Citation equation number + model mismatch, SIE surface density:**
The text says "(Kormann, Schneider \& Bartelmann 1994; Congdon \& Keeton eq.~6.15)" for the SIE surface mass density. C&K eq. 6.15 (p.152) is $\kappa_{\rm SIEP}(R,\phi) = q^2 b / [2R(q^2\cos^2\phi+\sin^2\phi)^{3/2}]$ — the convergence for the SIEP (singular isothermal elliptical *potential*) model, which is a different model from the SIEMD (singular isothermal elliptical *mass distribution*) whose formula appears in the chapter. The chapter's formula (with $\sqrt{q}$ normalization and arctan/arctanh deflection angles) is the SIEMD from KSB94. The SIEMD convergence in C&K is eq. 6.13. Proposed fix: change `eq.~6.15` to `eq.~6.13`, and note explicitly that the chapter is presenting the SIEMD (not the SIEP).

**C3 — Citation unconfirmable, Kormann et al. (1994):**
Not in Zotero; two CrossRef searches returned no match. The paper almost certainly exists (Kormann, Schneider & Bartelmann 1994, A&A, 284, 285-299 is the standard reference for this result) but could not be confirmed by any available adapter. Proposed action: verify via NASA ADS, then add to Zotero library.

**C5 — Citation chapter numbers wrong, Whitney's theorem in Petters et al.:**
The remark attributes Whitney's theorem (fold and cusp as only stable singularities of 2D smooth maps) to "Petters et al.\ 2001, Ch.~5--6." The Table of Contents of Petters et al. (2001) shows: Ch. 5 = "Observations of Gravitational Lensing," Ch. 6 = "Time Delay and Lensing Maps" — neither is about singularity theory. The relevant material is Ch. 7, Sec. 7.5 "Whitney Singularity Theory" (pp. 244–260), specifically 7.5.1 "Definition of Folds and Cusps" and 7.5.3 "Stability of Maps between 2-Manifolds." Proposed fix: `Ch.~5--6` → `Ch.~7, Sec.~7.5`.

**X1 — Internal inconsistency, source walk image count (Stages 2 and 4):**
Stage 1 of §5.3 correctly states the SIE produces "two images" outside the tangential caustic. Stage 2 then says "The total count goes from **1 to 3 images** (or effectively from 2 to 4, counting the faint central image)." This is backwards for the SIE: there is no faint central image in a singular model, and the count outside → inside the tangential caustic is 2→4 (not 1→3). The parenthetical clarification actually gives the correct count. Same error in Stage 4: "drops from **3 back to 1** (or 4 to 2)." Proposed fix for Stage 2: primary text "from **2 to 4 images**"; Stage 4 primary text "from **4 back to 2**." (If the author intends a non-singular model throughout this worked example, the text needs explicit clarification that a non-singular model is being used, which contradicts the SIE premise stated at the start of §5.3.)

**X2 — Internal inconsistency, exercise cross-reference labels:**
Exercise \ref{ex:sie_caustic} (line ~1243) reads "Write down the deflection angle components $\alpha_1$ and $\alpha_2$ from eqs.~\eqref{eq:sie\_alpha1}--\eqref{eq:sie\_alpha2}." The SIE deflection angle in the chapter is a single boxed equation labelled `\label{eq:sie_alpha}`. Labels `eq:sie_alpha1` and `eq:sie_alpha2` do not exist in the .tex source; these will render as "(??)--(??)". Proposed fix: change to `\eqref{eq:sie\_alpha}`, or split the display into two labelled parts.

**X3 — Approximate claim, "ellipse" for SIS+shear critical curve:**
The remark in §2.4 states "the critical curve is an **ellipse**: elongated along the θ₂-axis." The curve $r(\phi) = \theta_E(1-\gamma\cos2\phi)/(1-\gamma^2)$ is a limaçon-type polar curve, NOT an exact ellipse (1.5–3% deviation at intermediate angles for γ=0.1). C&K (2018) do not call it an ellipse. The claim is approximately true for γ≪1 but incorrect for finite γ. Proposed softening: "the critical curve deforms into an **oval**: elongated along the θ₂-axis (approximately elliptical for small γ)."

---

## Notes on unverified observation claims

N8 (quad fraction 20–30%), N15 (double fraction 70–80%), N18 (arc magnifications μ∼20–50), N19 (arc L/W >10:1), N20 (cluster critical curve radius ~10–30 arcsec): all capped at ⚠ SUSPECT with no Observation adapter. All are broadly consistent with the literature as known from domain context but have not been independently verified this run.

---

## Equation-number cleanup (2026-07-01)

Re-verified each flagged citation against source PDFs (pdftotext + grep) before editing. All four independently confirmed and applied. Only `08_Elliptical_Models_Caustics.tex` was edited.

### APPLIED

- **C1** `eq.~6.7` → `eqs.~6.1--6.2` (SIS+shear lensing potential, line ~114).
  PDF confirmation: C&K eq. 6.7 (p.148) = A⁻¹ matrix in polar form (confirmed by grep: "b sin φ cos φ / R ... (6.7)"). The combined potential is explicitly stated in C&K as "the sum ψ = ψ_SIS + ψ_γ", i.e., eq. 6.2 (SIS: `b√(x²+y²)`) + eq. 6.1 (shear: `-γ/2(x²-y²)`).

- **C2** `eq.~6.15` → `eq.~6.13` (SIE surface mass density / convergence, line ~282).
  PDF confirmation: C&K eq. 6.13 (p.151) = `κ_SIEMD = b/(2R√(q²cos²φ+sin²φ))` — the SIEMD convergence. C&K eq. 6.15 (p.152) = `κ_SIEP = q²b/(2R(q²cos²φ+sin²φ)^{3/2})` — the SIEP convergence (different model). Chapter presents SIEMD deflection angles (arctan/arctanh) consistent with KSB94; eq. 6.13 is the correct reference.

- **C5** `Ch.~5--6` → `Ch.~7, Sec.~7.5` (Whitney's theorem, Petters et al. 2001, line ~965).
  PDF confirmation: Petters 2001 ToC confirms Ch. 5 = "Observations of Gravitational Lensing" (p.~143); Whitney Singularity Theory = Sec. 7.5 (grep: "7.5.1 Definition of Folds and Cusps", "7.5.3 Stability of Maps between 2-Manifolds", line ~362 in extracted text).

- **X2** `eqs.~\eqref{eq:sie_alpha1}--\eqref{eq:sie_alpha2}` → `eq.~\eqref{eq:sie_alpha}` (exercise cross-reference, line ~1243).
  Repo-grep confirmation: labels `eq:sie_alpha1` and `eq:sie_alpha2` are absent from the .tex; `eq:sie_alpha` (single boxed display for both α₁ and α₂ components) exists at line 331. Also changed "eqs." to "eq." to match singular label.

### STILL-FLAGGED (author judgment required) — carried over

- **C3**: Kormann, Schneider & Bartelmann (1994) not confirmable by available adapters; verify via NASA ADS.

---

## Harden pass (2026-07-09)

Adapter state: wolframscript not activated (Wolfram license error on exit);
all numerical verification done in Python 3 / scipy.  pdftotext available
and used for PDF checks.  Source PDFs confirmed: C&K 2018, Petters 2001.

---

### NUMBERS re-verified

All 6 SIE values (thetaE=1, q=0.7, source β=(0.5,0)) recomputed with
Python (scipy.optimize.fsolve + finite-difference Jacobian).
Kormann convention: α₁ ∝ ArcTan, α₂ ∝ ArcTanh, confirmed by reading
`sie_deflection.wl` (lines 44–45).

| value | chapter | computed | status |
|-------|---------|----------|--------|
| Image A position | (1.43, 0.0)″ | (1.4319, 0.0)″ | PASS |
| Image B position | (−0.43, 0.0)″ | (−0.4319, 0.0)″ | PASS |
| μ_A | 6.1 | 6.051 | PASS |
| μ_B | −0.6 | −0.566 | PASS |
| caustic area (q=0.7) | 0.066 θ_E² | 0.06564 θ_E² | PASS |
| cusp (β₁-axis) | 0.263 θ_E | 0.26337 θ_E | PASS |

Internal consistency check: θ_A + θ_B = 1.4319 + (−0.4319) = 1.0000 = 2β₁. ✓

wolframscript fallback: `sie_deflection.wl` was read and the convention
(ArcTan for α₁, ArcTanh for α₂) confirmed as identical to the Python
implementation.  Numerical Check 4 in the .wl (finite-difference kappa
vs. closed-form kappa) gives the same verification path as the Python
code.  No discrepancy expected.

---

### APPLIED-FIX re-verification (citation/eqref)

Re-confirmed in current .tex by grep (2026-07-09):

| fix | tex evidence | PDF evidence | status |
|-----|-------------|--------------|--------|
| C1: `eqs.~6.1--6.2` | line 114 ✓ | pdftotext of C&K: `(6.1)` at pdftotext line 10585 (shear potential), `(6.2)` at line 10606 (SIS potential); `(6.7)` at line 10761 is a different equation (later in the SIS+shear Jacobian section) | PASS |
| C2: `eq.~6.13` | line 282 ✓ | pdftotext of C&K: `(6.13)` at line 10923, in "6.1.2 Elliptical Lenses" section — correct for SIEMD convergence | PASS |
| C5: `Ch.~7, Sec.~7.5` | line 965 ✓ | pdftotext of Petters: ToC line 361 "Whitney Singularity Theory", line 362 "7.5.1 Definition of Folds and Cusps", line 364 "7.5.3 Stability of Maps between 2-Manifolds" | PASS |
| X2: `eq.~\eqref{eq:sie_alpha}` | line 1243 ✓ | internal: label `eq:sie_alpha` exists at line 331; labels `eq:sie_alpha1/2` absent | PASS |

---

### PROSE FIXES applied

#### X1 — Image count sequence in §5.3 (source walk, Stages 2 and 4)

**Stage 2, old:** "The total count goes from **1 to 3 images** (or effectively from 2 to 4, counting the faint central image):"

**Stage 2, new:** "The total count goes from **2 to 4 images**:"

**Stage 4, old:** "The count drops from **3 back to 1** (or 4 to 2 counting the central image)."

**Stage 4, new:** "The count drops from **4 back to 2**."

**Justification:** The SIE is singular at the origin and has no radial critical curve.
Stage 1 of the same section explicitly states two images for a source outside the
tangential caustic (one Type I, one Type II), which is the correct SIE count.
Crossing the tangential caustic adds one Type I / Type II pair, giving 2→4.
The parenthetical in the original text had the correction inverted (it labeled 2→4 as
"counting the faint central image," but for the singular SIE there IS no central image
to count — the 2→4 count IS the correct total, with no additional image anywhere).
The non-singular model caveat is already addressed in the table that follows Stage 4
(1→3→5 sequence for models with a radial caustic), so no additional prose is needed.

#### X3 — SIS+shear critical curve shape (§2.4, figure caption, Summary)

**Python verification:** r(φ) = θ_E(1 − γ cos2φ)/(1−γ²) with γ=0.1.
Best-fit ellipse with same semi-axes a = θ_E/(1+γ) = 0.9091, b = θ_E/(1−γ) = 1.1111.
Maximum fractional deviation from the best-fit ellipse: **1.52%** at φ=45°.
The curve is a sinusoidal polar oval (r = A + B cos2φ), NOT a true ellipse.
Deviations are small but real; C&K (2018) do not use the word "ellipse" for this curve.
For γ=0.2 the deviation reaches 6.3%; calling it "ellipse" without qualification would
mislead students who take the approximation literally.

Three locations edited in the .tex (§2.4 remark text, §2.5 figure caption, §7 Summary):

**§2.4 main text, old:** "the critical curve is an **ellipse**: elongated along the θ₂-axis (perpendicular to the shear direction) and compressed along θ₁."

**§2.4 main text, new:** "the critical curve is an **oval**: elongated along the θ₂-axis (perpendicular to the shear direction) and compressed along θ₁ (approximately elliptical for small γ_ext; the deviation from a true ellipse reaches ~1.5% at γ_ext = 0.1)."

**Figure caption, old:** "The critical curve is an ellipse;"

**Figure caption, new:** "The critical curve is an oval (approximately elliptical for small shear);"

**Summary, old:** "deforms the critical curve into an **ellipse** and opens the point caustic"

**Summary, new:** "deforms the critical curve into an **oval** and opens the point caustic"

Note: line 35 ("Critical curves deform from circles into ellipses and ovals") is a
general qualitative bullet in the intro and was not changed; "ovals" is already present
there and softens the claim sufficiently.

---

### STILL-OPEN

- **C3**: Kormann, Schneider & Bartelmann (1994, A&A 284, 285) — not confirmable by
  available adapters (CrossRef, Zotero both failed). Very likely real (standard reference
  for SIE closed-form deflection; formula in the chapter is consistent with that paper).
  Verify via NASA ADS and add to Zotero.
- **N8, N15, N18, N19, N20**: Observation-class claims (quad fraction 20–30%,
  double fraction 70–80%, arc magnifications μ∼20–50, L/W >10:1, cluster critical
  curve radius ~10–30″) — no Observation adapter; remain SUSPECT from the 2026-07-01
  pass.  Human verification against current surveys recommended.
