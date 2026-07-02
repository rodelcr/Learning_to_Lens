# fact-critic report — Notes/05_Magnification_Convergence_Shear/05_Magnification_Convergence_Shear.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib found), crossref-web ✓ (reachable, used for N&B existence),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓,
> overlay: none.
> Companion notebook: lensing_potential.wl run via `wolframscript -file lensing_potential.wl` (completed, all figures exported, zero symbolic residuals).
> Reference PDFs available: Narayan & Bartelmann 1997, Congdon & Keeton 2018 (both read).
> (A claim whose lens has no active adapter is capped at ⚠ SUSPECT — see flagged rows.)

---

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | `psi_11 = thetaE²(θ₂²−θ₁²)/θ⁴ + thetaE²/θ²` (lines 619–620) | ❌ FAIL (auto-fixed) | Python sympy + wolframscript: psi_11 = tE²(th2²−th1²)/(th1²+th2²)²; error term = +tE²/(th1²+th2²) ≠ 0 | Remove `+ \frac{\thetaE^2}{\theta^2}` from psi_11 |
| N1b | Number | `psi_22 = thetaE²(θ₁²−θ₂²)/θ⁴ + thetaE²/θ²` (lines 621–622) | ❌ FAIL (auto-fixed) | Python sympy + wolframscript: psi_22 = tE²(th1²−th2²)/(th1²+th2²)² | Remove `+ \frac{\thetaE^2}{\theta^2}` from psi_22 |
| X1 | Consistency | psi_11 form in shear section (lines 619–620) vs convergence section (lines 661–662) | ❌ FAIL (auto-fixed via N1) | doc-internal: shear section had extra +tE²/θ² absent in convergence section; convergence section gives correct form tE²(θ²−2θ₁²)/θ⁴ = tE²(θ₂²−θ₁²)/θ⁴ | Fix is the N1 edit; both sections now agree |
| N2 | Number | λ₊=0: tangential (1−κ=\|γ\|); λ₋=0: radial (1−κ=−\|γ\|) (lines 497–502) | ❌ FAIL (auto-fixed) | wolframscript eigenvalues: {1−κ−\|γ\|, 1+\|γ\|−κ}; λ₊=1−κ+\|γ\|=0 → 1−κ=−\|γ\| (radial), λ₋=1−κ−\|γ\|=0 → 1−κ=\|γ\| (tangential); subscripts were swapped | Swap: λ₋=0 for tangential, λ₊=0 for radial (conditions 1−κ=±\|γ\| are correct) |
| N3 | Number | "For κ>1, the image...has negative parity (the mapping 'folds over')" (lines 521–525) | ❌ FAIL (flag-only) | Python: det(A)=(1−κ)²≥0 always for pure convergence; C&K eq. 4.46 confirms μ=(1−κ)⁻²>0; parity is always positive for pure γ=0 | Change to: "For κ>1 the image is still magnified with positive parity (det A=(1−κ)²>0 even for κ>1; both eigenvalues are negative so the 180° rotation preserves handedness)." Author must decide wording. |
| N4 | Number | γ₁=−(θ_E²/θ²)cos 2φ, γ₂=−(θ_E²/θ²)sin 2φ (lines 633–639) | ✅ PASS | wolframscript: gamma_1 = −tE²cos(2φ)/θ², gamma_2 = −tE²sin(2φ)/θ² (exact match) |  none |
| N5 | Number | \|γ\|=θ_E²/θ² (lines 644–646) | ✅ PASS | wolframscript: \|gamma\| = Sqrt[tE⁴]/(th1²+th2²) = tE²/θ² | none |
| N6 | Number | A=[[1−κ−γ₁,−γ₂],[−γ₂,1−κ+γ₁]] (lines 372–376) | ✅ PASS | wolframscript Section 4: Jacobian matrix verified with Amat[kappa,g1,g2] = {{1−g1−kappa,−g2},{−g2,1+g1−kappa}} | none |
| N7 | Number | det A=(1−κ)²−\|γ\|² (lines 441–444) | ✅ PASS | wolframscript: `det(A) = 1 − g1²−g2²−2κ+κ² = (1−κ)²−(g1²+g2²)` | none |
| N8 | Number | μ=1/[(1−κ)²−\|γ\|²] (line 449) | ✅ PASS | wolframscript: mu = 1/(1−thetaE⁴/theta⁴) for point mass with κ=0; general formula follows from det(A) | none |
| N9 | Number | μ±=(u²+2)/(2u√(u²+4))±1/2 (lines 694–698) | ✅ PASS | wolframscript: mu_+ − expected = 0 (symbolic); \|mu_−\| numerical at u=0.5,1,2,5 all ≈ 0 to floating-point precision | none |
| N10 | Number | κ_SIS=θ_E/(2θ), \|γ_SIS\|=θ_E/(2θ)=κ_SIS (lines 722–736) | ✅ PASS | repo-grep lensing_potential.wl Section 4 confirms 1/(2theta) form; Python: μ_SIS=1/((1−κ)²−κ²)=1/(1−2κ) ✓; N&B eq. 43 (Σ(ξ)=σ_v²/(2Gξ)) matches text | none |
| N11 | Number | SIS μ=θ/(θ−θ_E) (lines 744–748) | ✅ PASS | Python: 1/(1−θ_E/θ)=θ/(θ−θ_E) ✓ | none |
| N12 | Number | κ(θ_E)=1/2 for SIS (lines 725–727) | ✅ PASS | doc-internal: κ_SIS=θ_E/(2θ) → κ(θ_E)=θ_E/(2θ_E)=1/2 ✓ | none |
| N13 | Number | Pure shear: μ=1/(1−\|γ\|²), b/a=(1−\|γ\|)/(1+\|γ\|) (lines 537–544) | ✅ PASS | Python: det(A_shear)=1−g1² for g2=0; μ=1/(1−g1²) ✓; axis ratio from eigenvalues 1∓\|γ\| ✓ | none |
| N14 | Number | 2D Green's function ∇²ln\|r\|=2πδ²(r) (lines 154–157) | ✅ PASS | wolframscript Section 5c: nabla² ln\|r\|=0 for r≠0, flux=2π ✓ | none |
| N15 | Number | Spin-2: γ→e^{−2iφ}γ under rotation by φ (lines 296–300) | ✅ PASS | wolframscript Section 5b: (γ₁'+iγ₂')−e^{−2iφ}(γ₁+iγ₂)=0, kappa'−kappa=0 ✓ | none |
| N16 | Number | SIS θ_E=4πσ_v²D_ds/(c²D_s) (lines 724–725) | ✅ PASS | N&B eq. 45: θ_E=4π(σ_v/c)²D_ds/D_s ✓; notation matches | none |
| C1 | Citation | Epigraph "The convergence and shear are the two fundamental quantities..." attributed to "Narayan & Bartelmann (1997)" (lines 13–19) | ⚠ SUSPECT | N&B Sec. 3.2 p.20 has conceptually similar text ("Convergence acting alone causes an isotropic focusing...") but the epigraph is not a verbatim quotation. No exact matching sentence found in the PDF. Reference existence confirmed (arXiv astro-ph/9606001). Support for the verbatim attribution unconfirmed. | Soften attribution: consider rephrasing as "after Narayan & Bartelmann (1997)" or writing an original epigraph. |
| C2 | Citation | "(Narayan & Bartelmann eq.~15; Congdon & Keeton eq.~4.15)" for lensing potential definition (line 98) | ❌ FAIL | N&B PDF confirmed: eq. 15 = "separation = angle × distance"; lensing potential as κ-integral is eq. 51. C&K PDF confirmed: eq. 4.15 = κ≡Σ(D_l θ)/Σ_crit (convergence definition, not the potential); lensing potential is eq. 4.14. | Correct to: N&B eq.~51; Congdon \& Keeton eq.~4.14 |
| C3 | Citation | "(Narayan \& Bartelmann eq.~18; Congdon \& Keeton eq.~4.16)" for κ=(1/2)∇·α (lines 193–194) | ❌ FAIL | N&B PDF: eq. 18 = D=D_d D_ds/D_s (effective distance); κ=(1/2)tr(ψ_ij) is eq. 56; 2D Poisson ∇²ψ=2κ is eq. 50. C&K PDF: eq. 4.16 = ψ_PM explicit form (point-mass reduced potential); Poisson equation is eq. 4.22. | Correct to: N&B eq.~50 (or 56); Congdon \& Keeton eq.~4.22 |
| C4 | Citation | "(Narayan \& Bartelmann eq.~16; Congdon \& Keeton eq.~4.22)" for Jacobian matrix A=[[1−κ−γ₁,…]] (lines 369–370) | ❌ FAIL | N&B PDF: eq. 16 = deflection angle for uniform mass sheet; Jacobian in κ,γ form is eq. 58. C&K PDF: eq. 4.22 = ∇²ψ=2κ (Poisson equation); the inverse amplification tensor (Jacobian) is eq. 4.51. | Correct to: N&B eq.~58; Congdon \& Keeton eq.~4.51 |
| C5 | Citation | "(Congdon \& Keeton eq.~4.23)" for eigenvalues λ±=1−κ±\|γ\| (line 414) | ❌ FAIL | C&K PDF: eq. 4.23 = time delay formula ΔT_PM=T_*[(θ−β)²/2 − ψ_PM]; eigenvalue characteristic equation is eq. 4.54; eigenvalues λ±=(1−κ)±γ stated after eq. 4.54. | Correct to: Congdon \& Keeton eq.~4.54 |
| C6 | Citation | "(Congdon \& Keeton Sec.~4.3)" for SIS surface mass density Σ(ξ)=σ_v²/(2Gξ) (line 708) | ❌ FAIL | C&K TOC confirmed: Sec. 4.3 = "Time Delay and Parity" (p.100); SIS is in Sec. 2.3.2 (p.22). | Correct to: Congdon \& Keeton Sec.~2.3.2 (or cite N\&B Sec.~3.1 eq.~43) |
| X2 | Consistency | μ=1/[(1−κ)²−\|γ\|²] appears at lines 449, 743, 838, 1038 | ✅ PASS | internal: 4 occurrences agree | none |
| X3 | Consistency | κ_SIS=θ_E/(2θ) appears at lines 722, 732 | ✅ PASS | internal: 2 occurrences agree | none |

---

## Applied (auto-fixes)

- **N1/N1b**: Removed spurious `+ \frac{\thetaE^2}{\theta^2}` from both `psi_11` and `psi_22` in the shear subsection (lines 619–622). Source: Python sympy `diff(tE²/2*log(th1²+th2²),th1,2)` = `tE²(th2²−th1²)/(th1²+th2²)²` with zero residual vs the wolframscript `psi_11 = −tE²(th1²−th2²)/(th1²+th2²)²`. The LaTeX shear section previously read:
  ```
  psi_11 = thetaE²(θ₂²−θ₁²)/θ⁴ + thetaE²/θ²
  psi_22 = thetaE²(θ₁²−θ₂²)/θ⁴ + thetaE²/θ²
  ```
  now reads:
  ```
  psi_11 = thetaE²(θ₂²−θ₁²)/θ⁴
  psi_22 = thetaE²(θ₁²−θ₂²)/θ⁴
  ```
  Note: the erroneous extra terms *cancelled* in the γ₁ computation (hence γ₁, γ₂ results were still correct), but they would confuse any student tracing the calculation step by step, and they contradict the correct form given in the convergence subsection (lines 661–665).
  [file: Notes/05_Magnification_Convergence_Shear/05_Magnification_Convergence_Shear.tex, ~lines 619–622]

- **N2**: Swapped eigenvalue subscripts in the critical-curve bullet items. Source: wolframscript eigenvalues `{1−κ−|γ|, 1+|γ|−κ}` and Python confirmation λ₊=1−κ+|γ|, λ₋=1−κ−|γ|; λ₊=0 gives 1−κ=−|γ| (radial), λ₋=0 gives 1−κ=|γ| (tangential). Consistent with N&B Sec. 3.3.2 "critical lines" discussion. The LaTeX previously said:
  ```
  λ₊=0: tangential (1−κ=|γ|)
  λ₋=0: radial (1−κ=−|γ|)
  ```
  now reads:
  ```
  λ₋=0: tangential (1−κ=|γ|)
  λ₊=0: radial (1−κ=−|γ|)
  ```
  The physical conditions (1−κ=±|γ|) and the names (tangential/radial) were already correct; only the eigenvalue subscripts were swapped.
  [file: Notes/05_Magnification_Convergence_Shear/05_Magnification_Convergence_Shear.tex, ~lines 497–502]

---

## Flagged — your hand required

### N3: Wrong parity claim for pure convergence, κ>1 (lines 521–525)

**Verdict:** ❌ FAIL — flag-only (qualitative claim, not a pure number typo)

**Quoted text:** "For $\kappab > 1$, the image is still magnified but has *negative* parity (the mapping 'folds over')."

**What's wrong:** For pure convergence (γ=0), A=(1−κ)I and det(A)=(1−κ)²≥0 always. Parity = sign(det A) = positive for all κ≠1. Both Python (`det((1−kappa)*I) = (1−kappa)²`) and C&K eq. 4.46 (μ=(1−κ)⁻²>0) confirm this. When κ>1 both eigenvalues are negative, but their product is positive — the net effect is a 180° rotation, which preserves handedness.

**Proposed fix:** Change the sentence to something like:
> "For $\kappab > 1$, the image is still magnified and has the **same** parity ($\det\Amat = (1-\kappab)^2 > 0$ even for $\kappab > 1$; both eigenvalues are negative, so the $180^\circ$ rotation preserves handedness)."

The "folds over" description is misleading here; negative parity requires one eigenvalue to flip sign while the other doesn't (which requires shear or a saddle point), not a uniform negative scaling.

---

### C1: Epigraph quote attribution to Narayan & Bartelmann (1997) (lines 13–19)

**Verdict:** ⚠ SUSPECT

**Issue:** The epigraph ("The convergence and shear are the two fundamental quantities that describe the local properties of a gravitational lens. The convergence causes isotropic focusing; the shear causes anisotropic distortion. Together they determine the magnification and shape distortion of lensed images.") is attributed as a direct quotation to Narayan & Bartelmann (1997). The N&B PDF (Sec. 3.2, p. 19–20) contains conceptually equivalent text but **not this verbatim passage**. The closest N&B text is: "Convergence acting alone causes an isotropic focusing of light rays... Shear introduces anisotropy (or astigmatism)..." — paraphrase, not the quoted wording.

**Reference existence:** Confirmed. arXiv:astro-ph/9606001, "Lectures on Gravitational Lensing," Narayan & Bartelmann (1997).

**Proposed fix:** If this is a paraphrase, change attribution to "after Narayan \& Bartelmann (1997)" or write an original epigraph. If it is from a specific edition/talk, identify the exact source.

---

### C2: N&B eq. 15, C&K eq. 4.15 for lensing potential (line 98)

**Verdict:** ❌ FAIL (both equation numbers wrong)

- **N&B eq. 15** = "separation = angle × distance" (geometric relation used to derive the lens equation). Confirmed in N&B PDF p. 9.
- **N&B eq. 51** = ψ(θ) = (1/π)∫κ(θ')ln|θ−θ'|d²θ' (the actual lensing potential). Confirmed p. 19.
- **C&K eq. 4.15** = κ(θ) ≡ Σ(D_l θ)/Σ_crit (convergence definition). Confirmed C&K p. 90.
- **C&K eq. 4.14** = ψ(θ) = (1/π)∫κ(θ')ln|θ−θ'|d²θ' (lensing potential). Confirmed C&K p. 90.

**Proposed fix:** `(Narayan \& Bartelmann eq.~51; Congdon \& Keeton eq.~4.14)`

---

### C3: N&B eq. 18, C&K eq. 4.16 for κ = (1/2)∇·α (lines 193–194)

**Verdict:** ❌ FAIL (both equation numbers wrong)

- **N&B eq. 18** = D = D_d D_ds/D_s (effective distance definition). Confirmed N&B PDF p. 9.
- **N&B eq. 50** = ∇²_θ ψ = 2Σ/Σ_cr = 2κ (2D Poisson). **N&B eq. 56** = κ = (1/2)(ψ₁₁+ψ₂₂) = (1/2)tr ψ_ij. Confirmed N&B PDF p. 19.
- **C&K eq. 4.16** = ψ_PM(θ) = (2GM D_ls/c² D_l D_s)[2ln|θ|−ln(4D_ls/D_l)] (point-mass potential, explicit). Confirmed C&K p. 90.
- **C&K eq. 4.22** = ∇²ψ(θ) = 2κ(θ) (Poisson equation). Confirmed C&K p. 91.

**Proposed fix:** `(Narayan \& Bartelmann eq.~56; Congdon \& Keeton eq.~4.22)`

---

### C4: N&B eq. 16, C&K eq. 4.22 for Jacobian matrix (lines 369–370)

**Verdict:** ❌ FAIL (both equation numbers wrong)

- **N&B eq. 16** = α(θ) = (D_ds/D_s)·(4G/c²)(Σπξ²/ξ)·θ (deflection for uniform-density lens). Confirmed N&B PDF p. 9.
- **N&B eq. 58** = A = [[1−κ−γ₁, −γ₂],[−γ₂, 1−κ+γ₁]] (Jacobian in κ, γ form). Confirmed N&B PDF p. 20.
- **C&K eq. 4.22** = ∇²ψ(θ) = 2κ(θ). Confirmed C&K p. 91.
- **C&K eq. 4.51** = A⁻¹(θ) = [[1−ψ_xx, −ψ_xy],[−ψ_xy, 1−ψ_yy]] (inverse amplification tensor ≡ Jacobian in C&K convention). Confirmed C&K p. 98. [Note: C&K defines A as the magnification tensor; their A⁻¹ = the LaTeX's A.]

**Proposed fix:** `(Narayan \& Bartelmann eq.~58; Congdon \& Keeton eq.~4.51)`

---

### C5: C&K eq. 4.23 for eigenvalues λ± = 1−κ±|γ| (line 414)

**Verdict:** ❌ FAIL

- **C&K eq. 4.23** = time delay formula: ΔT_PM = (1+z_l)/c · D_l D_s/D_ls · [½(θ−β)² − (4GM D_ls/c² D_l D_s)ln|θ|]. Confirmed C&K p. 92.
- **C&K eq. 4.54** = characteristic equation 0 = det(A⁻¹−λI) → eigenvalues λ± = (1−κ)±γ. Confirmed C&K p. 99.

**Proposed fix:** `(Congdon \& Keeton eq.~4.54)`

---

### C6: C&K Sec. 4.3 for SIS surface mass density (line 708)

**Verdict:** ❌ FAIL

- **C&K Sec. 4.3** = "Time Delay and Parity" (book p. 100). Confirmed in TOC.
- The SIS model is in **C&K Sec. 2.3.2** ("Singular Isothermal Sphere," book p. 22).
- For N&B: SIS Σ(ξ) = σ_v²/(2Gξ) is in N&B **Sec. 3.1 eq. 43**. Confirmed N&B PDF p. 18.

**Proposed fix:** `(Narayan \& Bartelmann Sec.~3.1 eq.~43; Congdon \& Keeton Sec.~2.3.2)`

---

## Summary of equation-number pattern

All five cited N&B and C&K equation numbers in this chapter are wrong — by factors of 3–4× in N&B (e.g., citing eq. 15 for eq. 51, eq. 16 for eq. 58) and by ≥1 in C&K (citing 4.15 for 4.14, 4.16 for 4.22, 4.22 for 4.51, 4.23 for 4.54, Sec. 4.3 for Sec. 2.3.2). These appear to have been written from memory rather than checked against the source PDFs. All five require manual correction (citations are never auto-edited per skill policy).

---

## Equation-number cleanup (2026-07-01)

Independent re-verification performed against PDFs via `pdftotext` + line reads before any edit.

### APPLIED (5 / 5 confirmed)

| id | change | PDF confirmation |
|----|--------|-----------------|
| C2-NB | N&B eq.~15 → eq.~51 (line 98) | nb97.txt line 1325: ψ(θ)=(1/π)∫κ ln\|θ−θ'\|d²θ'; eq. 15 (line 455) confirmed = "separation=angle×distance" |
| C2-CK | C&K eq.~4.15 → eq.~4.14 (line 98) | ck18.txt line 6566: eq. 4.14 = lensing potential integral; line 6575: eq. 4.15 = κ=Σ/Σ_crit |
| C3-NB | N&B eq.~18 → eq.~56 (lines 193–194) | nb97.txt line 503: eq. 18 = D=D_d D_ds/D_s; line 1406: eq. 56 = κ=(1/2)(ψ₁₁+ψ₂₂) |
| C3-CK | C&K eq.~4.16 → eq.~4.22 (lines 193–194) | ck18.txt line 6612: eq. 4.16 = ψ_PM explicit; line 6684: eq. 4.22 = ∇²ψ=2κ |
| C4-NB | N&B eq.~16 → eq.~58 (lines 369–370) | nb97.txt line 474: eq. 16 = deflection for uniform-density lens; line 1445: eq. 58 = A=[[1−κ−γ,−γ],[…]] |
| C4-CK | C&K eq.~4.22 → eq.~4.51 (lines 369–370) | ck18.txt line 7200: eq. 4.51 = A⁻¹=[[1−ψ_xx,−ψ_xy],[…]] (inverse amplification tensor = Jacobian) |
| C5 | C&K eq.~4.23 → eq.~4.54 (line 414) | ck18.txt line 6734: eq. 4.23 = time delay ΔT_PM; line 7264: eq. 4.54 = characteristic equation → λ±=(1−κ)±γ |
| C6 | C&K Sec.~4.3 → Sec.~2.3.2 (line 706) | ck18.txt line 291 (TOC): Sec. 4.3="Time Delay and Parity"; line 205 (TOC) + line 1832: Sec. 2.3.2="Singular Isothermal Sphere", Σ(R)=σ²/(2GR) eq. 2.44 |

Note on C6: the proposed fix in the report also suggested adding N&B Sec. 3.1 eq. 43. The existing .tex cited only C&K, so only the C&K reference was corrected (Sec. 4.3 → Sec. 2.3.2). The N&B addition is optional and left to the author.

### STILL-FLAGGED (require author judgment)

| id | issue |
|----|-------|
| N3 | "κ>1 → negative parity" claim (lines 521–525): mathematically wrong for pure convergence (det A=(1−κ)²>0 always), but the corrected prose is a judgment call for the author. |
| C1 | Epigraph attribution as verbatim quote of N&B (1997): no exact match found in PDF; "after N&B" or an original epigraph is recommended. |

File edited: `05_Magnification_Convergence_Shear.tex` only.
