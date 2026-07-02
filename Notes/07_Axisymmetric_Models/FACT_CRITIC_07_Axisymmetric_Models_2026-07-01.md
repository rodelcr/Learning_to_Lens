# fact-critic report — Notes/07_Axisymmetric_Models/07_Axisymmetric_Models.tex

> ⚠️ CONTROLLER RE-CORRECTION (2026-07-01, deeper fix): the first pass fixed the
> SIS θ_E worked-example arithmetic to `6.2×10⁻⁶ rad ≈ 1.3″` but LEFT the chapter's
> stated `D_ds/D_s ≈ 1200/1700 ≈ 0.706` — which is itself WRONG. astropy (flat
> ΛCDM H₀=70, Ω_m=0.3) gives D_ds=1054.7, D_s=1651.9 → **D_ds/D_s = 0.6385**, so
> **θ_E = 5.6×10⁻⁶ rad ≈ 1.15″** (independently confirmed by the ch09 audit, which
> got 0.638 / 1.15″ for the same z_d=0.3, z_s=1). The .tex is now corrected to
> `1055/1652 ≈ 0.638 → 5.6×10⁻⁶ rad ≈ 1.15″`. Lesson: this was a cosmology-
> parameter error the first pass missed by trusting the chapter's own distance
> ratio; caught by cross-checking distances against astropy after the Mathematica
> question prompted a re-audit of parameter-dependent numbers.

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib found), crossref-web ✓ (WebFetch via CrossRef API),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓,
> overlay: Zotero (mcp__zotero__zotero_search_items ✓), reference PDFs in
> /Users/rosador/Documents/Learning_to_Lens/Reference_Texts/ (opened directly ✓).
> (Claims whose lens has no active adapter are capped at ⚠ SUSPECT — see flagged rows.)

---

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | `≈ 1.9 × 10⁻⁵ rad` (SIS θ_E, σ=250 km/s, D_ds/D_s=0.706) | ❌ FAIL (auto-fixed) | python3 recompute: 4π(250e3/3e8)²×0.706 = 6.16×10⁻⁶ rad | `6.2 × 10⁻⁶ rad` |
| N2 | Number | `≈ 1.4''` (same example) | ❌ FAIL (auto-fixed) | python3: 6.16×10⁻⁶ × 206265 = 1.271'' | `1.3''` |
| X1 | Consistency | `1.9×10⁻⁵ rad` vs `1.4''` (same equation, eq:sis_thetaE_numerical) | ❌ FAIL (resolved by N1+N2 fix) | 1.9×10⁻⁵ × 206265 = 3.92'' ≠ 1.4'' — internally contradictory | both corrected above |
| N3 | Number | D_ds/D_s = 1200/1700 ≈ 0.706 | ✅ PASS | python3: 1200/1700 = 0.70588, rounds to 0.706 | none |
| N4 | Number | v_c = √2 σ_v (SIS flat rotation curve) | ✅ PASS | python3 derivation: M(r) = 2σ_v²r/G → v_c² = GM/r = 2σ_v² → v_c = √2 σ_v | none |
| N5 | Number | NFW f(1) = 1/3 | ✅ PASS | python3 numerical: f(0.9999)=0.33337, f(1.0001)=0.33329; L'Hôpital gives -K'(1)/2 = 1/3 | none |
| N6 | Number | NFW antiderivative d/dx[ln(x/2)+K(x)] = x f(x) | ✅ PASS | python3 finite-diff at x=0.3,0.5,0.8,1.5,2.0,4.0: all agree to 8 s.f. | none |
| N7 | Number | arccosh(1/x) = ln(2/x) + O(x²) as x→0 | ✅ PASS | python3: at x=0.01 diff < 3×10⁻⁵; at x=0.001 diff < 10⁻⁷ | none |
| N8 | Number | NFW concentration c~3–5 (clusters), c~10–20 (galaxies) | ⚠ SUSPECT | No reference cited in text; values broadly consistent with literature but unverified without a specific citation | flag for citation |
| N9 | Number | Point mass μ± = (u²+2)/(2u√(u²+4)) ± 1/2 | ✅ PASS | N&B PDF p. 11 eq. (27): identical formula confirmed; python3 large-u limit ✓ | none |
| N10 | Number | NFW ρ_s = (200/3) ρ_crit c³/[ln(1+c)-c/(1+c)] | ✅ PASS | Derived from M_200 = (4π/3)r₂₀₀³×200ρ_crit = 4π ρ_s r_s³[ln(1+c)-c/(1+c)]; algebra confirms | none |
| N11 | Number | NIS strong-lensing condition κ(0)>1 ⟺ θ_c < θ_E/2 | ✅ PASS | κ(0) = θ_E/(2θ_c) > 1 ⟺ θ_c < θ_E/2; also confirmed via C&K Fig. 2.7 (a<0.5 for triple images) | none |
| C1 | Citation | "Narayan & Bartelmann eq. 24" for 1D lens equation β=θ-α(θ) | ❌ FAIL | N&B PDF p. 10 eq. (24) = point-mass image positions θ± = (β ± √(β²+4θ_E²))/2; 1D lens equation is N&B eq. (14)/(19) | correct to N&B eq. (19) or (14) |
| C2 | Citation | "Narayan & Bartelmann eq. 25" for shear |γ|=κ̄-κ | ❌ FAIL | N&B PDF p. 11 eq. (25) = "magnification = image area / source area"; shear formula not near eq. 25 | remove/correct eq. number |
| C3 | Citation | "Congdon & Keeton eq. 2.40" for SIS density ρ=σ²/(2πGr²) | ❌ FAIL | C&K PDF p. 24 eq. (2.40) = Poisson-form ODE −4πGρ/σ²=(1/r²)d/dr(r²d ln ρ/dr); SIS density is C&K eq. (2.42) | correct to C&K eq. (2.42) |
| C4 | Citation | "Congdon & Keeton eq. 4.12" for α(θ)=M(θ)/(π Σ_cr D_d² θ) | ❌ FAIL | C&K PDF p. 89 eq. (4.12) = definition of reduced deflection vector α(θ) ≡ (D_ls/D_s)α̂(D_l θ); enclosed-mass formula is in C&K Sec. 2.2.1 | remove or correct eq. number |
| C5 | Citation | "Congdon & Keeton Sec. 6.1" for NIS surface mass density | ❌ FAIL | C&K TOC: Sec. 6.1 = "Singular Isothermal Lens Models" (SIS); NIS is in C&K Sec. 2.3.3 and Sec. 6.2 "Lenses with a Core of Finite Density" | correct to C&K Sec. 2.3.3 or 6.2 |
| C6 | Citation | "Congdon & Keeton Sec. 6.1" for SIS constant deflection discussion | ✅ PASS | C&K TOC: Sec. 6.1 = "Singular Isothermal Lens Models" — appropriate for SIS constant deflection | none |
| C7 | Citation | "Navarro, Frenk & White 1996, 1997" for NFW profile | ✅ PASS | Zotero: 1996 key 5BK3DGJF "The Structure of Cold Dark Matter Halos"; 1997 key JZPLLEVU "A Universal Density Profile from Hierarchical Clustering" | none |
| C8 | Citation | "Wright & Brainerd (2000)" for NFW Σ formula | ✅ PASS | CrossRef DOI 10.1086/308744 confirmed: Wright & Brainerd 2000 ApJ 534 34, "Gravitational Lensing by NFW Halos" | none |
| C9 | Citation | "Bartelmann (1996)" for NFW Σ formula | ⚠ SUSPECT | CrossRef search confirms existence: A&A 313, 697 (1996), "Arcs from a universal dark matter halo profile" — but no direct DOI confirmed in this run; reference not in Zotero | add to Zotero; verify DOI |
| C10 | Citation | "Narayan & Bartelmann (1997)" (opening quote and Sec. 3.4 attribution) | ✅ PASS | Zotero key A457695U, preprint dated 1997-10-02; N&B Sec. 3.4 "Circularly Symmetric Lens Models" confirmed in PDF p. 22 | none |
| C11 | Citation | "Narayan & Bartelmann Sec. 3.1" (SIS section header) | ✅ PASS | N&B PDF TOC p. 2: Sec. 3.1 "Lensing by a Singular Isothermal Sphere" p. 18 — SIS density and deflection eq. (41)–(45) confirmed | none |
| C12 | Citation | "Congdon & Keeton" (book existence) | ✅ PASS | Zotero key HAHYK7MR, 2018, Springer; PDF confirmed | none |

---

## Applied (auto-fixes)

- **N1**: `1.9 \times 10^{-5}~\text{rad}` → `6.2 \times 10^{-6}~\text{rad}`
  Source: python3 recompute 4π(250e3/3e8)²×(1200/1700) = 6.160×10⁻⁶ rad.
  File: eq:sis_thetaE_numerical, line 344.

- **N2 / X1**: `1.4''` → `1.3''`
  Source: 6.160×10⁻⁶ rad × 206265 arcsec/rad = 1.271'' → rounds to 1.3''.
  This also resolves the internal contradiction X1 (old pair 1.9×10⁻⁵ rad = 3.92'' was inconsistent with 1.4'').
  File: eq:sis_thetaE_numerical, line 345.

---

## Flagged — your hand required

### Citation errors (equation-number mis-attributions): 5 fails, none auto-edited

**C1 — N&B eq. 24 (1D lens equation)**
Text: `(Narayan \& Bartelmann eq.~24)` in sec:circular_formalism for β=θ−α(θ).
Finding: N&B eq. (24) is the point-mass image positions θ± = ½(β ± √(β²+4θ_E²)).
The 1D lens equation is N&B eq. (14) in vector form, or the circularly-symmetric form appears as eq. (19) (β(θ) = θ − (D_ds/D_d D_s)(4GM/c²θ)) or derived from eq. (14) for circular symmetry. There is no single "N&B eq. 24" for the bare 1D lens equation.
Proposed fix: change to `eq.~(19)` or `eq.~(14)` or remove the equation-number pointer and write "N\&B Sec.~3.4".

**C2 — N&B eq. 25 (shear formula)**
Text: `(Narayan \& Bartelmann eq.~25)` in sec:circular_formalism for |γ|=κ̄−κ.
Finding: N&B eq. (25) is "magnification = image area / source area". The shear formula |γ|=κ̄−κ for circular symmetry is derived from the general formalism (related to N&B eqs. (55)–(60) in Sec. 3.2) but is not directly labelled as eq. (25).
Proposed fix: remove the eq. number or locate the correct equation. The formula is correct; only the attribution is wrong.

**C3 — C&K eq. 2.40 (SIS density)**
Text: `(Congdon \& Keeton eq.~2.40)` in sec:sis for ρ(r) = σ²/(2πGr²).
Finding: C&K eq. (2.40) is the Poisson-equation form −4πGρ/σ² = (1/r²)d/dr(r² d ln ρ/dr). The SIS density profile ρ = σ²/(2πGr²) is C&K eq. (2.42).
Proposed fix: change `eq.~2.40` → `eq.~2.42`.

**C4 — C&K eq. 4.12 (enclosed-mass deflection)**
Text: `(Congdon \& Keeton eq.~4.12)` in eq:alpha_enclosed_mass for α(θ)=M(θ)/(π Σ_cr D_d² θ).
Finding: C&K eq. (4.12) is α(θ) ≡ (D_ls/D_s) α̂(D_l θ) — the definition of the reduced deflection vector. The enclosed-mass deflection formula appears in C&K Sec. 2.2.1 (eq. (2.11)/(2.12) context), not Chapter 4.
Proposed fix: remove `eq.~4.12`; substitute the correct C&K eq. number from Sec. 2.2.1, or cite as "C\&K Sec.~2.2.1".

**C5 — C&K Sec. 6.1 (NIS surface mass density)**
Text: `(Congdon \& Keeton Sec.~6.1)` in sec:nis for NIS surface mass density Σ(θ).
Finding: C&K Sec. 6.1 is "Singular Isothermal Lens Models" (SIS). The NIS is introduced as eq. (2.53)–(2.57) in C&K Sec. 2.3.3 "Nonsingular Isothermal Sphere", and revisited in C&K Sec. 6.2 "Lenses with a Core of Finite Density."
Proposed fix: change `Sec.~6.1` → `Sec.~2.3.3` (where NIS is first defined) or `Sec.~6.2` (galaxy-lensing context).

### Number flags (no auto-fix)

**N8 — NFW concentration ranges**
Text: "Typical values are c∼3–5 for massive clusters (M₂₀₀∼10¹⁵ M_☉) and c∼10–20 for galaxy-mass haloes (M₂₀₀∼10¹² M_☉)."
No reference cited. These ranges are broadly consistent with the literature (e.g., Bullock et al. 2001, Duffy et al. 2008, Diemer & Kravtsov 2015) but the specific numbers are cosmology- and redshift-dependent. The stated range c~10–20 for galaxy halos is at the high end (many simulations give c~5–15 at z~0 for 10¹² M_☉).
Verdict: ⚠ SUSPECT — add a citation (e.g., Bullock et al. 2001 ApJ 555 240 or NFW 1997) or soften the claim.

**C9 — Bartelmann (1996)**
Text: "Bartelmann (1996) and Wright \& Brainerd (2000)" for the NFW surface density.
Bartelmann 1996 exists (A&A 313, 697: "Arcs from a universal dark matter halo profile") but is not in the Zotero library and no DOI was confirmed in this run.
Verdict: ⚠ SUSPECT on support — add to Zotero and confirm DOI. The formula attribution to this paper is physically plausible (it is the standard reference for NFW lensing Σ(x)), but the equation-level support was not verified from full text.

---

## Notes on formulas verified correct

All core physics formulas in the chapter were independently verified:

- SIS Σ(ξ) = σ²/(2Gξ): correct (line-of-sight integral of ρ∝r⁻²).
- SIS M₂D(ξ) = πσ²ξ/G: correct (1D integral of Σ).
- SIS α̂ = 4πσ²/c²: correct (M/ξ cancellation).
- SIS θ_E = 4π(σ/c)² D_ds/D_s: correct.
- SIS κ(θ) = θ_E/(2θ): correct.
- SIS κ̄(θ) = θ_E/θ: correct (mean-κ integral).
- SIS |γ| = κ̄ − κ = θ_E/(2θ) = κ: correct.
- SIS magnification μ± = 1 ± θ_E/β: correct.
- SIS total magnification = 2θ_E/β: correct.
- Radial eigenvalue λ_r = 1 − 2κ + κ̄: correct (verified by differentiation of α=κ̄θ).
- NIS κ(θ) = θ_E/(2√(θ²+θ_c²)): correct.
- NIS deflection α(θ) = θ_E(√(θ²+θ_c²)−θ_c)/θ: correct (antiderivative verified).
- NFW f(1) = 1/3: correct (numerical + L'Hôpital).
- NFW antiderivative identity d/dx[ln(x/2)+K(x)] = xf(x): confirmed numerically.
- NFW ρ_s formula: correct (from M₂₀₀ = (4π/3)r₂₀₀³·200ρ_crit).
- Point mass magnification: matches N&B eq. (27) exactly.
