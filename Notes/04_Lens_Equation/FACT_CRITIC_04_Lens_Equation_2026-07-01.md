# fact-critic report — Notes/04_Lens_Equation/04_Lens_Equation.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib found), crossref-web ✗ (not used — Zotero
> available; Reference_Texts PDFs used directly), md-reflist ✗, values-file ✗,
> repo-grep ✓ (companion .wl), doc-internal ✓, overlay none.
> Zotero ✓ (for existence checks). Source PDFs checked:
>   Reference_Texts/Narayan and Bartelmann - 1997 - Lectures on Gravitational Lensing.pdf (pp. 1-12)
>   Reference_Texts/Congdon and Keeton - 2018 - Principles of Gravitational Lensing.pdf (pp. 87-105)
> Notebook verified via: `wolframscript -file lens_equation.wl`; Python 3 independent recompute.
> (Claims whose lens has no active adapter are capped at ⚠ SUSPECT — see flagged rows.)

---

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | `100 kpc / 1 Gpc = 10^{-4}` (eq:thin_screen_ratio) | ✅ PASS | Python: `100e-3/1e3 = 1.00e-4` | none |
| N2a | Number | `θ_E ≈ 0.9 mas` stellar microlensing (final result, eq:thetaE_microlensing) | ✅ PASS | wolframscript lens_equation.wl §2(a): 0.9025 mas; Python: 0.902 mas | none |
| N2b | Number | Formula displays `1/(5 × 3.086×10^{19})` in denominator — internal claim that this equals 0.9 mas | ❌ FAIL (auto-fixed) | Python: formula `1/(5 kpc)` gives 1.28 mas ≠ 0.9 mas; correct factor is D_ds/(D_d×D_s) = 5/(5×10) kpc = 1/(10 kpc) = `1/(10×3.086×10^{19} m)`; wolframscript uses 10 kpc and gives 0.902 mas | `5` → `10` in denominator |
| N3 | Number | `θ_E ≈ 2.4''` galaxy lensing (M=10^12 M☉, D_d=919, D_s=1652, D_ds=1055 Mpc) | ✅ PASS | wolframscript §2(b): 2.379''; Python: 2.379'' | none |
| N4 | Number | `θ_E ≈ 37''` cluster lensing (M=2×10^14 M☉, D_d=919, D_s=1727, D_ds=1329 Mpc) | ✅ PASS | wolframscript §2(c): 36.93''; Python: 36.93'' | none |
| N5 | Number | `Σ_cr ≈ 0.59 g cm^{-2}` (galaxy lens) | ✅ PASS | Python: 0.5917 g/cm² (correct; companion .wl conversion bug noted below) | none |
| N6 | Number | `Σ_cr ≈ 2840 M☉ pc^{-2}` (galaxy lens) | ✅ PASS | Python: 2833 M☉/pc²; wolframscript: 2833 M☉/pc² (tex rounds up by 7; within 0.3%) | none |
| N7 | Number | `Σ_cr ≈ 5.9 kg m^{-2}` (galaxy lens) | ✅ PASS | Python: 5.917 kg/m²; wolframscript: 5.917 kg/m² | none |
| N8 | Number | Summary bullet: `~1 mas` stellar microlensing | ✅ PASS | Python: 0.902 mas; rounds to ~1 mas (acceptable order-of-magnitude summary) | none |
| N9 | Number | Summary bullet: `~1''` galaxy lensing | ⚠ SUSPECT | Worked example (N3, same chapter) gives 2.4'' for M=10^12 M☉; summary may assume M~10^11 M☉ or D~1 Gpc (consistent with N&B eq.22 scaling θ_E = 0.9''×(M/10^11 M☉)^{1/2}×(D/Gpc)^{-1/2}) but no canonical mass is stated; see X1 | Suggest adding mass qualifier or changing to `~1–2''` |
| N10 | Number | Summary bullet: `~30''` cluster lensing | ⚠ SUSPECT | Worked example (N4) gives 37'' for M=2×10^14 M☉ at z_s=2; summary is ~20% low | Suggest `~30–40''` or `~40''` |
| X1 | Consistency | Summary `~1''` vs worked example `2.4''` (both galaxy lensing in same chapter) | ❌ FAIL | doc-internal: two Number occurrences, different mass assumed; Number-lens-verified value is 2.4'' (N3); summary uses different (unlabelled) mass | Flag only — author must decide (qualify mass in summary bullet, or change to `~2''`); not auto-fixed (intentional parameter difference possible) |
| X2 | Consistency | Summary `~30''` vs worked example `37''` (cluster lensing) | ⚠ SUSPECT | doc-internal: off by ~20%; not flagrantly wrong but lower than the worked example | Suggest `~40''` or `~30–40''` to bracket the example |
| C1 | Citation | Epigraph: `"The lens equation is the fundamental relation... --- Narayan & Bartelmann (1997)"` | ⚠ SUSPECT | N&B (1997) paper: confirmed exists (Zotero key A457695U; arXiv:astro-ph/9606001); Reference_Texts PDF pp. 1-12 checked — exact quoted sentence not found in those pages; may be paraphrase presented as direct quote | Verify verbatim in N&B or reframe as paraphrase |
| C2 | Citation | `Congdon & Keeton eq. 4.1; Narayan & Bartelmann eq. 5` for ξ = D_d θ, η = D_s β | ❌ FAIL | C&K PDF p.87 eq.4.1 = deflection vector as gradient α̂(ξ) = ∇_ξψ̂(ξ) — NOT position relations; N&B PDF p.7 eq.5 = Newtonian potential Φ(b,z) = -GM/(b²+z²)^{1/2} — NOT position relations | Flag only — remove these eq-numbers; position relations are implicit (separation = angle × distance); N&B discusses near eqs.13-15 (text only); C&K implies via eq.4.12 |
| C3 | Citation | `Narayan & Bartelmann eq. 6; Congdon & Keeton eq. 4.2` for η = (D_s/D_d)ξ − D_ds α̂(ξ) | ❌ FAIL | N&B PDF p.7 eq.6 = ∇⊥Φ(b,z) = GMb̂/(b²+z²)^{3/2} (gradient of potential) — NOT displacement; C&K PDF p.88 eq.4.2 = ψ̂(ξ) = (2/c²)∫Φdz (projected potential) — NOT displacement | Flag only — correct source is derivation between N&B eqs.13-14 (unnumbered) |
| C4 | Citation | `Congdon & Keeton eq. 4.5` for deflection integral α̂(ξ) = (4G/c²)∫(ξ-ξ')Σ(ξ')/|ξ-ξ'|² d²ξ' | ❌ FAIL | C&K PDF p.88 eq.4.5 = ψ̂_PM(R) ≈ −(2GM/c²)[ln(2D_l/R) + ln(2D_ls/R)] (point mass projected potential approximation) — NOT deflection integral; C&K deflection integral = eq.4.9 (p.89) | Flag only — correct attribution: C&K eq.4.9 (and N&B eq.10 for N&B) |
| C5 | Citation | `Congdon & Keeton eq. 4.10; Narayan & Bartelmann eq. 13` for Σ_cr formula | ❌ FAIL | C&K PDF p.89 eq.4.10 = ∇_ξln(\|ξ-ξ'\|) = (ξ-ξ')/\|ξ-ξ'\|² (gradient identity) — NOT Σ_cr; N&B PDF p.9 eq.13 = α = (D_ds/D_s)α̂ (reduced deflection angle definition) — NOT Σ_cr; Correct: N&B eq.17 (p.9) and C&K eq.2.68 (Ch.2) | Flag only — correct attribution: N&B eq.17; C&K eq.2.68 |
| C6 | Citation | `Narayan & Bartelmann eq. 19` for μ = (θ/β)(dθ/dβ) (circular magnification) | ❌ FAIL | N&B PDF p.9 eq.19 = circular lens equation β(θ) = θ − (D_ds/D_d D_s)(4GM(θ)/c²θ) — NOT magnification; Correct: N&B eq.26 (p.11) | Flag only — correct attribution: N&B eq.26 |
| C7 | Citation | `Narayan & Bartelmann eq. 20` for μ± = (u²+2)/(2u√(u²+4)) ± ½ | ❌ FAIL | N&B PDF p.9 eq.20 = θ_E = [4GM(θ_E)/c² × D_ds/(D_d D_s)]^{1/2} (Einstein radius for circular lens) — NOT magnification; Correct: N&B eq.27 (p.11) | Flag only — correct attribution: N&B eq.27 |

---

## Applied (auto-fixes)

- **N2b**: `\frac{1}{5 \times 3.086 \times 10^{19}}` → `\frac{1}{10 \times 3.086 \times 10^{19}}` in `eq:thetaE_microlensing` (stellar microlensing formula, line 489).  
  Rationale: D_ds/(D_d × D_s) = 5 kpc/(5 kpc × 10 kpc) = 1/(10 kpc); formula as written yields 1.28 mas (not 0.9 mas). Both Python and wolframscript §2(a) confirm 10 kpc gives the correct 0.902 mas.  
  [Notes/04_Lens_Equation/04_Lens_Equation.tex:489]

---

## Flagged — your hand required

### Companion .wl unit conversion bug (does not affect tex correctness, but breaks the "computed and verified in lens_equation.wl" claim for g/cm²)

The companion file `Mathematica/04_Lens_Equation/lens_equation.wl` line 153 contains:
```mathematica
Print["           = ", NumberForm[sCrGal * 10, {3, 2}], " g/cm^2"];
```
The factor `* 10` is wrong. The correct conversion is 1 kg/m² = 0.1 g/cm², so the factor should be `* 0.1`. As written, the script outputs **59.17 g/cm²** when the correct value is **0.5917 g/cm²** (factor-of-100 error). The tex states 0.59 g/cm² correctly. The .wl's g/cm² output is unreliable for Σ_cr verification.

**Proposed fix in .wl** (not auto-applied — out of tex scope):
```mathematica
Print["           = ", NumberForm[sCrGal * 0.1, {3, 2}], " g/cm^2"];
```

---

### C1 — Epigraph attribution

The quote "The lens equation is the fundamental relation in gravitational lensing theory. It is simple to write down, but its consequences — multiple images, Einstein rings, magnification, and time delays — are extraordinarily rich." is attributed to Narayan & Bartelmann (1997). The paper exists (Zotero: A457695U). Pages 1–12 of the Reference_Texts PDF were checked; this exact phrasing is not present in those pages. If this is a paraphrase or composite, reframe it accordingly (e.g., "after Narayan & Bartelmann 1997" or convert to a prose reference).

---

### C2 — Position relations equation numbers

`Congdon & Keeton eq. 4.1; Narayan & Bartelmann eq. 5` cited for ξ = D_d θ, η = D_s β.  
- C&K eq. 4.1 (PDF p. 87) is the deflection-as-gradient equation α̂(ξ) = ∇_ξψ̂(ξ).  
- N&B eq. 5 (PDF p. 7) is the Newtonian potential Φ(b,z) = −GM/(b²+z²)^{1/2}.  
Neither contains the position relations. These relations are used without a stand-alone numbered equation in both texts (N&B implies them in discussion near eq. 13-15 via "separation = angle × distance"; C&K via eq. 4.12). **Recommend removing the equation-number citations for this line**, or citing "N&B §2.1.3; C&K §4.1."

---

### C3 — Physical displacement equation numbers

`Narayan & Bartelmann eq. 6; Congdon & Keeton eq. 4.2` cited for η = (D_s/D_d)ξ − D_ds α̂(ξ).  
- N&B eq. 6 (PDF p. 7) = ∇⊥Φ(b,z) = GM b̂/(b²+z²)^{3/2}.  
- C&K eq. 4.2 (PDF p. 88) = projected potential ψ̂(ξ) = (2/c²)∫Φ(ξ,z)dz.  
The displacement relation is derived from geometry in N&B just before eq. 14 (text: "θD_s = βD_s − α̂D_ds"). No numbered equation in either text for this specific expression. **Recommend removing these citations** or citing "N&B eq. 14 derivation; C&K eq. 4.26 derivation."

---

### C4 — Deflection integral equation number

`Congdon & Keeton eq. 4.5` cited for the 2D deflection integral.  
- C&K eq. 4.5 (PDF p. 88) = approximation for point-mass projected potential ψ̂_PM(R).  
- The 2D deflection integral appears at **C&K eq. 4.9** (PDF p. 89).  
- In N&B, the equivalent is **eq. 10** (PDF p. 8).  
**Correct attribution: C&K eq. 4.9 (and/or N&B eq. 10).**

---

### C5 — Critical surface mass density equation numbers

`Congdon & Keeton eq. 4.10; Narayan & Bartelmann eq. 13` cited for Σ_cr = c²/(4πG) × D_s/(D_d D_ds).  
- C&K eq. 4.10 (PDF p. 89) = gradient identity ∇_ξ ln(|ξ−ξ'|) = (ξ−ξ')/|ξ−ξ'|².  
- N&B eq. 13 (PDF p. 8) = reduced deflection angle α = (D_ds/D_s)α̂.  
Neither contains Σ_cr. Correct sources:  
  - **N&B eq. 17** (PDF p. 9): Σ_cr = c²/(4πG) × D_s/(D_d D_ds) = 0.35 g cm⁻² (D/1 Gpc)⁻¹.  
  - **C&K eq. 2.68** (Ch. 2; referenced via C&K eq. 4.15 "Σ_crit defined by Eq. 2.68").  
**Correct attribution: N&B eq. 17; C&K eq. 2.68.**

---

### C6 — Circular magnification equation number

`Narayan & Bartelmann eq. 19` cited for μ = (θ/β)(dθ/dβ).  
- N&B eq. 19 (PDF p. 9) = β(θ) = θ − (D_ds/D_d D_s)(4GM(θ)/c²θ), the circularly-symmetric lens equation.  
- The magnification formula μ = (θ/β)(dθ/dβ) is **N&B eq. 26** (PDF p. 11).  
**Correct attribution: N&B eq. 26.**

---

### C7 — Point-mass magnification equation number

`Narayan & Bartelmann eq. 20` cited for μ± = (u²+2)/(2u√(u²+4)) ± ½.  
- N&B eq. 20 (PDF p. 9) = θ_E = [4GM(θ_E)/c² × D_ds/(D_d D_s)]^{1/2} (Einstein radius for general circular lens).  
- The μ± formula is **N&B eq. 27** (PDF p. 11).  
**Correct attribution: N&B eq. 27.**

---

### X1 — Summary bullet vs. worked example (galaxy θ_E)

Summary §8 states `~1''` for galaxy lensing; worked Example 4.3(b) gives `~2.4''` for M = 10^12 M☉. The summary appears to use a ~10^11 M☉ reference galaxy (consistent with N&B eq. 22 scaling: θ_E ≈ 0.9'' at M = 10^11 M☉, D = 1 Gpc), while the worked example uses 10^12 M☉. As written, a reader consulting both the summary and the example will find a factor-of-2.4 discrepancy with no explanation.  
**Proposed fix:** add qualifier e.g. `$\sim 1''$–$3''$ depending on lens mass` or qualify the summary mass (`$M \sim 10^{11}\,\Msun$, $\sim 1''$; for $M \sim 10^{12}\,\Msun$, $\sim 2$–$3''$`).

---

### X2 — Summary bullet vs. worked example (cluster θ_E)

Summary §8 states `~30''`; worked Example 4.3(c) gives `~37''` for the stated cluster parameters (M = 2×10^14 M☉). The 30'' figure is ~20% below the computed example. Minor, but should match to within rounding.  
**Proposed fix:** `~30''` → `~40''` or `~30''–40''`.

---

## Summary statistics

| verdict | count |
|---------|-------|
| ✅ PASS | 8 (N1, N2a, N3, N4, N5, N6, N7, N8) |
| ❌ FAIL (auto-fixed) | 1 (N2b) |
| ❌ FAIL (flag only) | 6 (X1, C2, C3, C4, C5, C6, C7) — 7 citation rows |
| ⚠ SUSPECT | 3 (N9, N10, C1) + .wl companion bug |

**Core equations all correct** (β = θ − α, Einstein radius, image positions θ±, magnification μ±, Σ_cr formula). The physics is sound. The issues are: one wrong distance factor in a displayed formula (auto-fixed), systematic misattribution of N&B and C&K equation numbers throughout (5 of 5 N&B eq-numbers wrong, 3 of 3 C&K eq-numbers wrong), and a factor-of-100 unit conversion bug in the companion .wl.
