# fact-critic report — Notes/09_Galaxy_Lensing_Applications/09_Galaxy_Lensing_Applications.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib in repo), crossref-web ✓,
> zotero ✓, repo-grep ✓, doc-internal ✓, values-file ✗, overlay: none.
> (Claims whose lens has no active adapter are capped at ⚠ SUSPECT — see flagged rows.)
> Rate-limiting on CrossRef hit for ~3 queries; those fall through to SUSPECT where Zotero did not cover.

---

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "adapted from Treu (2010)" | ✅ PASS | Zotero KLFUS75F — "Strong Lensing by Galaxies", Treu 2010 | none |
| C2 | Citation | "PixeLens (Saha & Williams 2004)" | ⚠ SUSPECT | CrossRef searches returned only 2006 Saha & Williams paper; 2004 paper not found in Zotero or CrossRef | verify year; PixeLens may be 2003 or 2006 publication |
| C3 | Citation | "GLASS (Coles et al. 2014)" | ✅ PASS | CrossRef DOI 10.1093/mnras/stu1781 — "Gravitational lens recovery with glass", Coles, Read & Saha, MNRAS 445, 2181 (2014) | none |
| C4 | Citation | "Congdon & Keeton eq. 6.35" (for M(≤θ_E) = π θ_E² D_d² Σ_cr) | ❌ FAIL | repo-grep: C&K PDF, p.169 — eq. (6.35) is the NIS+shear amplitude Γ = √[(κ−α_NIS/R)²−2γ(κ−α_NIS/R)cos(2φ)+γ²]; the Einstein-mass formula appears in C&K as **eq. (7.9)** in Chapter 7, not Chapter 6 | Change "Congdon & Keeton eq. 6.35" → "Congdon & Keeton eq. 7.9" |
| C5 | Citation | "Birrer et al. (2020)" / "Birrer2020" (TDCOSMO result) | ✅ PASS | CrossRef DOI 10.1051/0004-6361/202038861 — "TDCOSMO IV. Hierarchical time-delay cosmography", Birrer et al. 2020, A&A | none |
| C6 | Citation | "Wong et al. (2020)" (H0LiCOW H0) | ✅ PASS | Zotero NDZSGMLR — "H0LiCOW XIII. A 2.4 per cent measurement of H0", Wong et al. 10/2020; corroborated by Semantic Scholar for DOI 10.1093/mnras/stz3094 | none |
| C7 | Citation | "Planck Collaboration 2020" (H0 = 67.4 ± 0.5) | ⚠ SUSPECT | CrossRef rate-limited; Zotero no hit. Value consistent with the well-known Planck 2018 baseline (A&A 641, A6, 2020) but not independently confirmed this run | none — plausible; suggest adding DOI 10.1051/0004-6361/201833910 |
| C8 | Citation | "Riess et al. 2022" (SH0ES H0) | ✅ PASS | Zotero SJFK9QP6 — "A Comprehensive Measurement of the Local Value of the Hubble Constant … SH0ES Team", Riess et al. 07/2022 | none |
| C9 | Citation | "Walsh, Carswell & Weymann in 1979" (first lens) | ✅ PASS | Zotero MQM8U5RQ — "0957+561 A,B: twin quasistellar objects or gravitational lens?", Walsh, Carswell & Weymann, 1979-05 | none |
| C10 | Citation | "SLACS survey (Auger et al. 2010)" (bulge-halo conspiracy) | ✅ PASS | CrossRef DOI 10.1088/0004-637x/724/1/511 — "THE SLOAN LENS ACS SURVEY. X. STELLAR, DYNAMICAL, AND TOTAL MASS CORRELATIONS", Auger et al. 2010 | none |
| C11 | Citation | "Treu & Koopmans (2004)" (σ_v² ∝ M·R_ap^{-1}·g(γ') formula) | ⚠ SUSPECT | arXiv found Treu & Koopmans (2004, astro-ph/0401373) about early-type galaxy mass profiles. Paper with Jeans-equation σ_v formula for power-law profiles is plausible but specific formula attribution not confirmed from abstract | verify — may also cite Koopmans et al. (2006, ApJ 649, 599) |
| C12 | Citation | "Schneider & Sluse (2014)" (SPT) | ✅ PASS | CrossRef DOI 10.1051/0004-6361/201322106 — "Source-position transformation: an approximate invariance in strong gravitational lensing", Schneider & Sluse, A&A 564, A103 (2014) | none |
| N1 | Number | θ_E = 4π(σ_v/c)² D_ds/D_s (SIE formula, eq. thetaE_sie) | ✅ PASS | doc-internal + standard SIS/SIE formula (Narayan & Bartelmann §3.4, reproduced in Meneghetti 2021) | none |
| N2 | Number | "θ_E ≈ 1.4''" for σ_v=250 km/s, z_d=0.3, z_s=1.0 (eq. thetaE_numerical) | ❌ FAIL | Python recompute: 4π(250/3e5)²×(D_ds/D_s)×206265 = **1.151 arcsec** for flat ΛCDM H0=70, Ω_m=0.3. The 1.4'' value reproduces only at z_s≈2.0 (D_ds/D_s=0.769 → θ_E=1.387''). Likely the numerical calculation used z_s≈2 while the text says z_s=1.0 | Change "≈1.4''" → "≈1.2''" (round of 1.15'') |
| N3 | Number | "M_E ~ 2–4 × 10^11 M_sun" (σ_v=250, z_d=0.3, z_s=1.0, θ_E=1.15'') | ✅ PASS | Python recompute: M_E = 2.34 × 10^11 M_sun — within the stated 2–4 × 10^11 range | none |
| N4 | Number | "H0 = 73.3 +1.7/−1.8 km/s/Mpc" (H0LiCOW) | ✅ PASS | Semantic Scholar / Zotero: Wong et al. 2020 abstract explicitly states H0 = 73.3 +1.7/−1.8 km/s/Mpc | none |
| N5 | Number | "3.1σ tension" (H0LiCOW vs Planck) | ✅ PASS | Python recompute: (73.3−67.4)/√(1.8²+0.5²) = 3.16σ; Wong et al. (2020) self-report "3.1σ" in abstract — consistent (minor rounding difference) | none |
| N6 | Number | "H0^Planck = 67.4 ± 0.5 km/s/Mpc" | ⚠ SUSPECT | CrossRef rate-limited. Value matches the Planck 2018 TT,TE,EE+lowE+lensing result but not confirmed this run | none — plausible |
| N7 | Number | "H0^SH0ES = 73.0 ± 1.0 km/s/Mpc" (Riess et al. 2022) | ✅ PASS | Zotero confirms Riess et al. 2022 paper; title states "1 km/s/Mpc^-1 uncertainty"; known result H0 = 73.04 ± 1.04, consistent with 73.0 ± 1.0 (rounded) | none |
| N8 | Number | "H0 = 74.5 +5.6/−6.1 km/s/Mpc" (TDCOSMO, Birrer et al. 2020) | ✅ PASS | CrossRef DOI abstract: TDCOSMO IV reports H0 = 74.5 +5.6/−6.1 km/s/Mpc for TDCOSMO-7-lens sample | none |
| N9 | Number | "γ' ≈ 2.0 ± 0.2" (SLACS, Auger et al. 2010) | ⚠ SUSPECT | Auger et al. 2010 paper confirmed (C10), but specific γ' = 2.0 ± 0.2 value not verified from abstract. Similar result also in Koopmans et al. (2009, ApJ 703, L51) | none — verify from Auger 2010 Table / abstract |
| N10 | Number | "Δt = 417 ± 3 days" (Q0957+561) | ⚠ SUSPECT | Consistent with Kundić et al. (1997, ApJ 482, 75) canonical optical value, but no citation given in text; Kundić et al. 1997 not independently confirmed this run via CrossRef | add citation: Kundić et al. (1997, ApJ 482, 75) |
| N11 | Number | "Q0957+561 M_E ~ 1.9 × 10^11 M_sun" (Table 1) | ✅ PASS | Python recompute (H0=70, Ω_m=0.3, z_d=0.36, z_s=1.41, θ_E=1.0''): M_E = 1.92 × 10^11 M_sun | none |
| N12 | Number | "Q2237+0305 M_E ~ 0.2 × 10^11 M_sun" (Table 1) | ✅ PASS | Python recompute (z_d=0.04, z_s=1.69, θ_E=0.9''): M_E = 0.17 × 10^11 M_sun — consistent at 1 sig fig with "~0.2" | none (mild: actual ~0.17; consider quoting ~0.17) |
| N13 | Number | "B1608+656 M_E ~ 3.9 × 10^11 M_sun" (Table 1) | ✅ PASS | Python recompute (z_d=0.63, z_s=1.39, θ_E=1.0''): M_E = 3.87 × 10^11 M_sun | none |
| N14 | Number | "physical Einstein radius ~0.7 kpc" (Q2237+0305) | ✅ PASS | Python recompute: D_d(z=0.04) × 0.9''/206265 = 0.71 kpc | none |
| X1 | Consistency | H0 formula labeling: §3.3 eq. mst_H0 vs §5.3 in-text formula | ❌ FAIL | doc-internal: §3.3 (eq. mst_H0) defines H^{true} = λ H^{naive} where H^{true} = cosmological truth (lower, ~67 km/s/Mpc) and H^{naive} = uncorrected H0LiCOW measurement (~73.3). §5.3 then cites "From eq. mst_H0: H^{inferred} = λ H^{true}" — but this formula appears to use H^{true} to mean the uncorrected H0LiCOW value (~73.3) and H^{inferred} for the corrected value (~67). The labels are **swapped** between sections. The surrounding prose in both sections correctly conveys that adding a mass sheet lowers the inferred H0, but the algebraic labels are contradictory | In §5.3 replace "H^{inferred} = λ H^{true}" with "H^{true} = λ H^{naive}" (consistent with §3.3 notation), and add a clarifying sentence: "A 10% mass sheet (λ=0.9) would shift the naive measurement down by 10%." |
| X2 | Consistency | z_s for Q0957+561: Walsh et al. 1979 abstract vs text | ✅ PASS | Zotero abstract: "redshift 1.405"; chapter says z_s = 1.41 — internally consistent (1.405 rounds to 1.41) | none |

---

## Applied (auto-fixes)

None. No auto-fixes were applied. All issues are flag-only per skill rules: the two Number FAILs (N2, C4) involve a citation and a quoted approximation, not a single unambiguous canonical source vs. manuscript; X1 is a notation issue requiring author judgment.

---

## Flagged — your hand required

### ❌ C4 — Wrong Congdon & Keeton equation number
**Quoted:** "Congdon & Keeton eq. 6.35"  
**Checked:** C&K PDF (Reference_Texts), PDF p. 169: eq. (6.35) = NIS+shear amplitude formula Γ = √[…], nothing to do with the Einstein mass. The enclosed-mass formula M = c²θ_E² D_d D_s / (4G D_ds) appears in **C&K as eq. (7.9)** in Chapter 7 ("Strong and Weak Lensing by Galaxy Clusters"), not chapter 6.  
**Proposed fix:** Change "Congdon & Keeton eq. 6.35" → "Congdon & Keeton eq. 7.9" (or cite the standard derivation from the lens equation definition of θ_E, e.g., Narayan & Bartelmann §3.3).

---

### ❌ N2 — θ_E numerical example off by ~22%
**Quoted:** "θ_E ≈ 4π(250/3×10^5)² × D_ds/D_s ≈ 1.4''" for σ_v = 250 km/s, z_d = 0.3, z_s = 1.0.  
**Checked:** Python (astropy FlatLambdaCDM H0=70, Ω_m=0.3):  
- D_ds/D_s = 0.638 for z_d=0.3, z_s=1.0  
- θ_E = 1.151 arcsec  
- The 1.4'' result only reproduces for z_s ≈ 2.0 (D_ds/D_s = 0.769)  
**Proposed fix:** Change "≈ 1.4''" → "≈ 1.2''" (or more precisely "≈ 1.15''").  
Also consider adding a note that D_ds/D_s ≈ 0.64 for these specific redshifts, so the estimate is not the generic "D_ds/D_s ≈ 1" limiting case.

---

### ❌ X1 — Inconsistent H0 labeling between §3.3 and §5.3
**Quoted in §3.3 (eq. mst_H0):**  
H^{true} = λ H^{naive} ⟺ H^{naive} = H^{true}/λ  
(H^{true} = cosmological truth, lower; H^{naive} = naive/H0LiCOW, higher)

**Quoted in §5.3:**  
"From eq. (mst_H0): H^{inferred} = λ H^{true}"  
Here the surrounding text identifies H^{true} with the H0LiCOW value (~73.3) and H^{inferred} with the corrected/Planck-like value (~67) — the opposite convention.

**Source:** doc-internal cross-check of §3.3 (eq. mst_H0) vs §5.3.  
**Proposed fix:** Replace the §5.3 formula with "H^{true} = λ H^{naive}" (notation consistent with §3.3), and rephrase: "With λ = 0.9 (10% unmodeled mass sheet), H^{true} is 10% below H^{naive}: a naive H0 = 73.3 implies a true H0 ≈ 66 km/s/Mpc." This eliminates the label swap and connects to the H0LiCOW context directly.

---

### ⚠ C2 — Saha & Williams (2004) for PixeLens unconfirmed
**Quoted:** "PixeLens (Saha & Williams 2004)"  
**Checked:** CrossRef and Zotero searches for "Saha Williams 2004 PixeLens" returned no exact match. Found a 2006 Saha & Williams paper (DOI 10.1086/508798) but not a 2004 one. Possible that the PixeLens introduction predates this under a different title (AJ or PASP, ~2003–2004).  
**Proposed action:** Verify year and title. If the tool was introduced in a different paper, correct the citation.

---

### ⚠ N10 — Q0957+561 time delay (417 ± 3 days) lacks citation
**Quoted:** "Δt = 417 ± 3 days (measured from optical and radio monitoring over many years)"  
**Checked:** No citation given in text. 417 ± 3 days is consistent with Kundić et al. (1997, ApJ 482, 75) — the canonical optical measurement. The description "optical and radio monitoring" is potentially misleading: Kundić et al. measured optically (417 ± 3 days); radio monitoring by Haarsma et al. (1999) gave a somewhat different value (424 ± 12 days).  
**Proposed action:** Add citation: "Kundić et al. (1997, ApJ 482, 75)"; specify "optical monitoring" rather than "optical and radio monitoring."

---

### ⚠ C7, N6 — Planck Collaboration (2020) H0 = 67.4 ± 0.5 unconfirmed
**Quoted:** "Planck Collaboration 2020: H0 = 67.4 ± 0.5 km/s/Mpc"  
**Checked:** CrossRef rate-limited; Zotero had no hit. The value is the well-known Planck 2018 TT,TE,EE+lowE+lensing result (A&A 641, A6, 2020; DOI 10.1051/0004-6361/201833910). Cannot formally PASS without adapter confirmation.  
**Proposed action:** None required on content — value and year are almost certainly correct. Add explicit citation "\citep{PlanckCollaboration2020}" with DOI as above.

---

## Python computation log (key checks)

```
FlatLambdaCDM H0=70, Om0=0.3
--- N2: θ_E for σ_v=250, z_d=0.3 ---
z_s=1.0 (stated):  D_ds/D_s=0.638, θ_E=1.151 arcsec  [chapter says ≈1.4'' → ❌]
z_s=2.0 (alt):     D_ds/D_s=0.769, θ_E=1.387 arcsec  [matches 1.4'' → likely source of error]
--- Table masses (eq. mass_from_thetaE) ---
Q0957+561  (zd=0.36, zs=1.41, θ_E=1.0''):  M_E = 1.92e11 Msun  [table ~1.9 → ✓]
Q2237+0305 (zd=0.04, zs=1.69, θ_E=0.9''):  M_E = 0.17e11 Msun  [table ~0.2 → ✓ at 1 sig fig]
B1608+656  (zd=0.63, zs=1.39, θ_E=1.0''):  M_E = 3.87e11 Msun  [table ~3.9 → ✓]
--- N14: Q2237+0305 physical R_E ---
D_d(z=0.04) × 0.9''/206265 = 0.71 kpc  [text ~0.7 kpc → ✓]
--- Tension H0LiCOW vs Planck ---
(73.3−67.4)/√(1.8²+0.5²) = 3.16σ  [text says 3.1σ → ✓ consistent]
```
