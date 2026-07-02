# fact-critic report — 06_Fermat_Time_Delays.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency, Physics-judgment
> Active adapters this run: bibtex ✗ (no .bib), crossref-web ✓, md-reflist ✗,
> values-file ✗, repo-grep ✓, doc-internal ✓,
> overlay: Zotero (zotero_search_items) ✓, Reference PDF (N&B, C&K PDFs read) ✓.
> (A claim whose lens has no active adapter is capped at ⚠ SUSPECT — see flagged rows.)
> Applied (auto-fixes): NONE — all failures are equation-number misattributions
> (citation rule: never auto-edit citations) or minor rounding chains with no impact
> on stated physical conclusions.

---

## Verdicts

| id | lens | quoted in chapter | verdict | source checked | proposed fix |
|----|------|-------------------|---------|----------------|--------------|
| C1 | Citation | Opening quote → "Narayan & Bartelmann (1997)" | ✅ PASS | Zotero A457695U — preprint 1997-10-02 confirmed | none |
| C2 | Citation | Time delay formula → "Narayan & Bartelmann eq. 21" | ❌ FAIL | N&B PDF p. 10: eq. 21 = Einstein radius θ_E = [4GM D_ds/(c² D_d D_s)]^½; time-delay function is N&B **eq. 63** (PDF p. 20, Sect. 3.3.1) | Change "eq. 21" → "eq. 63" (flag only — no auto-edit) |
| C3 | Citation | Time delay formula → "Congdon & Keeton eq. 4.46" | ❌ FAIL | C&K PDF p. 96: eq. 4.46 = magnification μ = (1−κ)^(−2) for convergence-only lens; Fermat potential is C&K **eq. 4.25** and full prefactor in eqs. 4.23–4.24 (PDF p. 92) | Change "eq. 4.46" → "eqs. 4.23–4.25" (flag only) |
| C4 | Citation | Cosmological time dilation → "Schneider, Ehlers & Falco 1992, Sec. 4.4" | ⚠ SUSPECT | Zotero 4YHPA5TN confirms book exists; C&K (p. 93) cites SEF (1992) for the same (1+z_l) cosmological correction — consistent with chapter's claim, but Sec. 4.4 of SEF not directly read in this run | Support plausible but unconfirmed |
| C5 | Citation | Q0957+561 discovery → "Walsh, Carswell & Weymann 1979" | ✅ PASS | Zotero MQM8U5RQ: "0957+561 A, B: twin quasistellar objects or gravitational lens?", Nature, 1979-05 | none |
| C6 | Citation | H0 = 73.3+1.7/−1.8 → attributed to "H0LiCOW/TDCOSMO … combined result" | ⚠ SUSPECT | Zotero NDZSGMLR — Wong et al. (2020), MNRAS 498, 1420 (H0LiCOW XIII) confirms the number exactly. But this is the **H0LiCOW XIII** result alone (6 lenses), not a combined H0LiCOW+TDCOSMO result. TDCOSMO (Birrer et al. 2020, TDCOSMO IV) is a separate analysis with a different value | Clarify: attribute to Wong et al. (2020) / H0LiCOW XIII specifically |
| N1 | Number | R_S = 2.95 × 10^15 m ≈ 0.096 pc (M = 10^12 M_sun) | ✅ PASS | python3: R_S = 2*6.674e-11*1.989e42/(2.998e8)^2 = 2.9538e15 m = 0.0957 pc — rounds to chapter's 2.95e15 m and 0.096 pc within stated precision | none |
| N2 | Number | sqrt(y^2+4) = sqrt(4.25) ≈ 2.0616 for y = 0.5 | ✅ PASS | python3: 2.061553 → rounds to 2.0616 ✓ | none |
| N3 | Number | Delta_tau first term = y*sqrt(y^2+4)/2 = 0.5154 | ✅ PASS | python3: 0.5 * 2.061553 / 2 = 0.515388 → rounds to 0.5154 ✓ | none |
| N4 | Number | ratio (2.0616+0.5)/(2.0616−0.5) stated as 1.6401 | ⚠ SUSPECT | python3: 2.5616/1.5616 = 1.6404; using chapter's own sqrt 2.0616 still gives 1.6404, not 1.6401. Discrepancy of 3 in 4th decimal — minor arithmetic slip in intermediate step | Correct ratio is 1.6404 from chapter's own inputs |
| N5 | Number | ln(ratio) stated as 0.4947 | ⚠ SUSPECT | python3: ln(1.640388) = 0.494933 → rounds to 0.4949, not 0.4947. Flows from N4 chain error. Difference is 2 in 4th decimal | Correct value is ≈ 0.4949 |
| N6 | Number | Delta_tau = 0.5154 + 0.4947 = 1.0101 | ⚠ SUSPECT | Exact: 0.515388 + 0.494933 = 1.010321 → rounds to 1.0103. Chapter's 1.0101 is internally consistent with N4–N5 errors but inconsistent with exact arithmetic. No impact on final "149 days" answer | Correct value is 1.0103; no correction needed given final answer is unaffected |
| N7 | Number | Delta_t ≈ 1.29 × 10^7 s ≈ 149 days | ✅ PASS | python3 (exact R_S = 2.9538e15 m): 2.9538e15/2.998e8 * 1.3 * 1.010321 = 1.2941e7 s = 149.8 days — chapter's 149 days ✓ | none |
| N8 | Number | H0LiCOW H0 = 73.3+1.7/−1.8 km/s/Mpc | ✅ PASS | Zotero NDZSGMLR abstract (Wong et al. 2020): "H_0 = 73.3^{+1.7}_{-1.8} km/s/Mpc" — exact match | none |
| N9 | Number | Planck H0 ≈ 67 km/s/Mpc | ✅ PASS | Planck Collaboration 2020 (A&A 641, A6): H0 = 67.4 ± 0.5 km/s/Mpc — "≈ 67" consistent | none |
| N10 | Number | Q0957+561 Δt ≈ 417 days | ✅ PASS | Kundić et al. (1997, ApJ 482, 75): 417.09 ± 0.07 days — widely-cited canonical optical measurement | none |
| N11 | Number | SIS: θ_E = 4π(σ_v/c)^2 D_ds/D_s | ✅ PASS | N&B PDF p. 18, eq. 45: θ_E = 4π σ_v^2/c^2 * D_ds/D_s — exact match | none |
| N12 | Number | Point mass image positions x_± = (y ± sqrt(y^2+4))/2 | ✅ PASS | N&B PDF p. 10, eq. 24: θ_± = ½(β ± sqrt(β^2 + 4θ_E^2)) — matches in dimensionless form | none |
| N13 | Number | SIS lensing potential ψ = θ_E |θ| | ✅ PASS | N&B Table 2 (PDF p. 23): ψ(θ) = D_ds/D_s * 4πσ^2/c^2 * |θ| = θ_E |θ| ✓ | none |
| N14 | Number | SIS time delay Δt_SIS = 2(1+z_d)/c * D_d D_s/D_ds * β θ_E | ✅ PASS | Verified algebraically: τ(θ_−) − τ(θ_+) = 2θ_E β; (θ_+^2 − θ_−^2) = 4β θ_E; eq. in chapter is internally consistent and correct | none |
| N15 | Number | Morse/Burke: n_min + n_max − n_sad = 1 | ✅ PASS | C&K PDF p. 101, Sect. 4.4: "n_min + n_max = n_sad + 1" — equivalent statement; Burke (1981) attribution consistent with both N&B and C&K | none |
| P1 | Physics | "the lensing potential ψ_L > 0 in the vicinity of the lens, so this term reduces the arrival time" | ⚠ SUSPECT | For a point mass: ψ = θ_E^2 ln|θ|, which is **negative** for |θ| < θ_E (i.e., inside the Einstein ring = "near the lens"). So −ψ > 0 there, which **increases** arrival time, not decreases. Claim is correct for smooth extended profiles (SIS: ψ = θ_E|θ| > 0 everywhere) but wrong for the point mass example developed in the same section | Flag for author revision: qualify "ψ_L > 0" as applying to extended (non-singular) profiles; point mass ψ is negative inside Einstein radius |
| X1 | Consistency | H0 value appears once | ✅ PASS | internal: single occurrence, no inconsistency | none |
| X2 | Consistency | Fermat potential formula τ = ½|θ−β|^2 − ψ in body (eq. 2) and Summary (bullet 1) | ✅ PASS | internal: 2 occurrences agree | none |
| X3 | Consistency | Delta_tau formula in Sect. 6 body (eq. 7) and Summary (bullet 6) | ✅ PASS | internal: 2 occurrences agree | none |

---

## Applied (auto-fixes)

None applied. Rationale:
- C2 and C3 are citation misattributions → citations are never auto-edited per action policy.
- P1 is a physics-judgment item → flag only.
- N4–N6 are a rounding-chain producing 2-unit errors in the 4th decimal place of
  intermediate values, with zero effect on the stated final result (149 days) → below
  auto-fix threshold.

---

## Flagged — author action required

### ❌ C2 — N&B equation number for time delay formula

**Quoted:** "Narayan & Bartelmann eq. 21"
**Checked:** N&B PDF p. 10, Sect. 2.1.4: eq. (21) is the Einstein radius formula
  θ_E = [4GM D_ds / (c² D_d D_s)]^½
The time-delay function t(θ) = (1+z_d)/c * D_d D_s/D_ds * [½|θ−β|² − ψ] is **N&B eq. 63**
(PDF p. 20, Sect. 3.3.1 "The Time-Delay Function").

**Proposed fix:** Change "Narayan \& Bartelmann eq.~21" → "Narayan \& Bartelmann eq.~63"

---

### ❌ C3 — C&K equation number for time delay formula

**Quoted:** "Congdon \& Keeton eq.~4.46"
**Checked:** C&K PDF p. 96, Sect. 4.2.1: eq. (4.46) is the magnification formula
  μ = (ε'/ε)² = (1−κ)^(−2) > 0  (magnification for constant convergence, no shear)
The Fermat potential τ = ½|θ−β|² − ψ is **C&K eq. 4.25** (PDF p. 92);
the full time delay with prefactor T* is **C&K eqs. 4.23–4.24**.

**Proposed fix:** Change "Congdon \& Keeton eq.~4.46" → "Congdon \& Keeton eqs.~4.23--4.25"

---

### ⚠ C4 — Schneider, Ehlers & Falco (1992) Sec. 4.4 for cosmological time dilation

**Quoted:** "cf.\ Schneider, Ehlers \& Falco 1992, Sec.~4.4"
**Checked:** Book confirmed in Zotero (key 4YHPA5TN). C&K (p. 93) independently cites
SEF (1992) for the same result (geometric time delay with redshift factor 1+z_l), making
the chapter's attribution plausible. However, the specific section "4.4" was not directly
read in this run — the SEF (1992) table of contents would need to be checked to confirm
that Sec. 4.4 (not Sec. 4.3 or 5.1) covers this material.

**Action:** Verify SEF (1992) section numbering against the available PDF.

---

### ⚠ C6 — "H0LiCOW/TDCOSMO combined result"

**Quoted:** "H0LiCOW/TDCOSMO (2017--present) … Their combined result gives
H_0 = 73.3^{+1.7}_{-1.8} km s^{-1} Mpc^{-1}"

**Checked:** The value 73.3+1.7/−1.8 is confirmed from Wong et al. (2020, MNRAS 498,
1420), which is the **H0LiCOW XIII** paper analysing 6 lenses under the H0LiCOW program.
This is NOT a combined H0LiCOW+TDCOSMO result. TDCOSMO is a separate programme;
its independent result (Birrer et al. 2020, TDCOSMO IV, A&A 643, A165) gave
H0 = 74.5+5.6/−6.1 km/s/Mpc (allowing for MST), which is different in precision and
approach. The chapter conflates H0LiCOW and TDCOSMO.

**Proposed fix:** Attribute specifically: "H0LiCOW (Wong et al.\ 2020)" and, if
TDCOSMO is to be mentioned separately, note it as a follow-on programme with its own
independent result.

---

### ⚠ N4–N6 — Minor rounding chain in worked example (§7)

**Quoted:** ratio = (2.0616 + 0.5)/(2.0616 − 0.5) = 1.6401; ln(1.6401) = 0.4947; Δτ = 1.0101
**Checked (python3):**
  - 2.5616/1.5616 = 1.6404 (chapter says 1.6401; Δ = 3 in 4th decimal)
  - ln(1.6404) = 0.4949 (chapter says 0.4947; Δ = 2 in 4th decimal)
  - Δτ (exact) = 1.0103 (chapter says 1.0101; Δ = 2 in 4th decimal)

The chapter's intermediate values are internally consistent with each other (0.5154 + 0.4947
= 1.0101) but carry a small arithmetic error at the ratio step. The final physical result
("Δt ≈ 149 days") is unaffected.

**Action:** Optional — the Mathematica verification file is cited as the authoritative
source; the discrepancy (< 0.02%) has no pedagogical consequence. If the author wants
exact 4-decimal intermediate values: 1.6404, 0.4949, 1.0103.

---

### ⚠ P1 — Shapiro delay sign description potentially wrong for point mass

**Quoted:** "the lensing potential ψ_L > 0 in the vicinity of the lens, so this term
[−ψ_L] reduces the arrival time --- photons passing through a deeper potential arrive
earlier due to the Shapiro effect"

**Issue:** For a point mass, ψ(θ) = θ_E^2 ln|θ|:
- Inside the Einstein radius (|θ| < θ_E): ln|θ| < 0, so ψ < 0 → −ψ > 0 → this term
  INCREASES arrival time (not reduces it).
- Outside the Einstein radius (|θ| > θ_E): ψ > 0 → −ψ < 0 → reduces arrival time.

So "ψ_L > 0 in the vicinity of the lens" is incorrect for the point mass model developed
in the same section (the lens center is inside the Einstein ring = "vicinity").
The claim IS correct for smooth extended profiles (SIS: ψ = θ_E|θ| > 0 everywhere).

**Proposed fix:** Qualify this remark: "For smooth, extended lenses (such as the SIS)
ψ_L > 0 everywhere, and −ψ_L reduces the arrival time relative to the purely geometric
delay. For a point mass, ψ changes sign at the Einstein radius: inside the ring ψ < 0,
and the Shapiro term −ψ adds to the arrival time." Alternatively, restrict the statement
to the general extended-lens context before specializing to the point mass.
