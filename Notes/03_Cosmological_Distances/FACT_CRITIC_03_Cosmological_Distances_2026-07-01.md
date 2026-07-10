# fact-critic report — Notes/03_Cosmological_Distances/03_Cosmological_Distances.tex

> UPDATE 2026-07-01 (controller): APPLIED four astropy-verified fixes (chapter's
> own cosmology is Ω_m=0.3, Ω_Λ=0.7, H₀=70, so astropy is the exact ground truth):
>  1. N3 ρ_cr,0 `9.5×10⁻²⁷` → `9.2×10⁻²⁷ kg m⁻³` (astropy 9.202; 9.5 was H₀≈71).
>  2. χ(z=5) table `7950` → `7775 Mpc` (astropy comoving; other table rows 420/1880/
>     3300/5200 are within rounding — only z=5 was wrong).
>  3. D_A max `1770` → `1748 Mpc` (astropy peak 1748 @ z=1.61).
>  4. Lensing-efficiency caption z_s=1 peak `z_d≈0.3` → `z_d≈0.35` (astropy 0.350;
>     the z_s=2 "≈0.5" is correct — astropy 0.517).
> STILL FLAGGED (not edited): T⁰⁰/T₀₀ index inconsistency (X1) — index-convention
> issue, author's call, not a single-value fix.

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib in repo), crossref-web ✓ (network reachable),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓,
> overlay: Zotero ✓ (mcp__zotero__zotero_search_items).
> Numbers recomputed via python3 + scipy + astropy (FlatLambdaCDM, H0=70, Om0=0.3).
> Carroll / Congdon & Keeton / Narayan & Bartelmann equation numbers cannot be verified
> (no text-accessible copy): those specific eq-number attributions are capped at ⚠ SUSPECT.

---

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "Walsh, Carswell & Weymann 1979" (first lens, Q0957+561) | ✅ PASS | Zotero key MQM8U5RQ; CrossRef DOI 10.1038/279381a0 confirmed (Nature 279, 381, 1979) | none |
| C2a | Number/Citation | Q0957+561 z_d = 0.36 | ✅ PASS | Zotero abstract confirms discovery paper; accepted z_lens = 0.356 → 0.36 ✓ | none |
| C2b | Number/Citation | Q0957+561 z_s = 1.41 | ⚠ SUSPECT | Walsh+1979 abstract (Zotero MQM8U5RQ) gives z_source = 1.405; modern refined value ~1.413. "1.41" is closer to 1.413 than to 1.405 but differs from the paper cited (1.405 rounds to 1.40). Cannot confirm 1.41 from the 1979 paper itself. | Consider citing a modern redshift paper or using z_s = 1.405 (original) or 1.413 (refined) |
| C3 | Citation | "Hogg (1999) form (eq. 19)" for D_ds between two redshifts | ✅ PASS | arXiv astro-ph/9905116 PDF retrieved; eq. 19 IS the D_{A12} formula for angular diameter distance between two objects | none |
| C3-note | Physics | Hogg (1999) eq. 19 stated as valid for "general (non-flat) universe" | ⚠ SUSPECT | Hogg (1999) explicitly notes the formula is "not correct for Ω_k < 0" (see text after eq. 19). Chapter does not relay this restriction. | Add caveat: eq. 3.38 is valid for Ω_k ≥ 0; for Ω_k < 0 a different form is needed. |
| C4 | Citation | "Planck 2018" giving Ω_m ≈ 0.31, Ω_Λ ≈ 0.69, Ω_r ≈ 9×10⁻⁵, \|Ω_k\| < 0.01 | ✅ PASS | Zotero key 37S3ADU9 ("Planck 2018 results. VI. Cosmological parameters"); Ω_m = 0.315, Ω_Λ = 0.685, Ω_r h² ≈ 4.18×10⁻⁵ → Ω_r ≈ 9×10⁻⁵ for H₀≈67 | none — values consistent with Planck 2018 TT,TE,EE+lowE+lensing best fit |
| C5 | Citation | Carroll eq. 8.2, 8.5, 8.6, 8.8, Sec. 8.1, 8.4; Congdon & Keeton eq. 3.113, 3.123, 4.9 | ⚠ SUSPECT | No .bib; no text-accessible copy; equation numbers cannot be independently verified. Web confirms Carroll "Spacetime and Geometry" exists and covers FRW cosmology. | Flag for manual cross-check against physical texts |
| N1 | Number | t_H = 1/H₀ ≈ 14 Gyr | ✅ PASS | Computed: 1/(70 km/s/Mpc) = 13.97 Gyr | none |
| N2 | Number | d_H = c/H₀ ≈ 4.28 Gpc ≈ 1.32×10²⁶ m | ✅ PASS | Computed: 4.2827 Gpc, 1.3215×10²⁶ m | none |
| N3 | Number | ρ_cr,0 ≈ 9.5×10⁻²⁷ kg m⁻³ (for H₀ = 70 km/s/Mpc) | ❌ FAIL | Computed: 3H₀²/(8πG) = 9.204×10⁻²⁷ kg m⁻³ (python3 + astropy confirm); 9.5×10⁻²⁷ corresponds to H₀ ≈ 71.1 km/s/Mpc, not 70 | Change to ≈ 9.2×10⁻²⁷ kg m⁻³ |
| N4a | Number | χ(z=0.1) = 420 Mpc | ✅ PASS | Computed 418 Mpc; difference 2 Mpc (0.5%), within rounding | none |
| N4b | Number | χ(z=0.5) = 1880 Mpc | ✅ PASS | Computed 1889 Mpc; difference 9 Mpc (<1%), consistent with rounding | none |
| N4c | Number | χ(z=1.0) = 3300 Mpc | ✅ PASS | Computed 3304 Mpc | none |
| N4d | Number | χ(z=2.0) = 5200 Mpc | ⚠ SUSPECT | Computed 5180 Mpc; difference 20 Mpc (0.4%). Slightly above rounding but no single other canonical source. | Consider rounding to 5180 |
| N4e | Number | χ(z=5.0) = 7950 Mpc | ❌ FAIL | Computed 7775 Mpc (astropy FlatLambdaCDM H0=70, Om0=0.3); discrepancy 175 Mpc (2.2%). Persists when Ω_r = 9×10⁻⁵ is added (7773 Mpc). No cosmology variant recovers 7950. | Change to ≈ 7775 Mpc |
| N5 | Number | D_A peaks at "approximately 1770 Mpc" at z ≈ 1.6 | ⚠ SUSPECT | Computed D_A max = 1747.6 Mpc at z = 1.605 (astropy); turnover redshift z ≈ 1.6 is correct, but 1770 Mpc overstates the peak by ~22 Mpc (1.3%). Likely a rounding/cosmology-choice artifact rather than a typo. | Change to ≈ 1748 Mpc (or "approximately 1750 Mpc") |
| N6 | Number | D_d=1259, D_s=1727, D_ds=1097, D_s−D_d=468 Mpc (z_d=0.5, z_s=2.0) | ✅ PASS | Computed: 1259.1, 1726.6, 1097.1, 467.5 Mpc respectively | none |
| N7 | Number | θ_E ≈ 2.4″ (M=10¹² M_sun, z_d=0.3, z_s=1.0) | ✅ PASS | Computed 2.379″ using concordance cosmology distances | none |
| N8 | Number | t₀ ≈ 13.5 Gyr (concordance cosmology, H₀=70) | ✅ PASS | Computed 13.47 Gyr | none |
| N9 | Number | z_s=1 lensing efficiency E=D_d D_ds/D_s peaks "at z_d ≈ 0.3" | ❌ FAIL | Computed peak at z_d = 0.350; fine scan confirms 0.35 > 0.30 (values: z_d=0.30→587 Mpc, z_d=0.35→595 Mpc). The peak is at 0.35, not 0.30. | Change to z_d ≈ 0.35 in figure caption |
| N10 | Number | z_s=2 lensing efficiency peaks "at z_d ≈ 0.5" | ✅ PASS | Computed peak at z_d = 0.519 ≈ 0.5 | none |
| X1 | Consistency | T^{00} = ρc² AND T_{00} = ρc⁴ stated in same paragraph, with g_{00} = −c² | ❌ FAIL | doc-internal: T_{00} = g_{0α}g_{0β}T^{αβ} = (g_{00})² T^{00} = (−c²)² × ρc² = ρc⁶ ≠ ρc⁴. The two stated values are inconsistent by a factor of c². The Friedmann derivation implicitly uses T_{00} = ρc⁴ (which requires T^{00} = ρ, not ρc²). | Fix T^{00}: if ρ is mass-energy density, then T^{00} = ρ (energy density/c² × c² = energy density? — resolve: T^{00} = ρ or T^{00} = ρc² requires clarifying whether ρ here is mass or energy density); T_{00} = ρc⁴ is the quantity actually used and is correct for the Friedmann result. |
| X2 | Consistency | Concordance H₀ = 70 attributed to/alongside "Planck 2018" values | ⚠ SUSPECT | Planck 2018 (Zotero 37S3ADU9) gives H₀ = 67.4 ± 0.5 km/s/Mpc, not 70. The chapter correctly does NOT attribute H₀=70 to Planck; it attributes only Ω_m, Ω_Λ, Ω_r, Ω_k to Planck 2018 and uses H₀=70 as a "concordance" working value. This is standard textbook practice. But a reader might conflate them. | Add footnote clarifying H₀ = 70 is a pre-Planck round value; Planck 2018 gives 67.4. |

---

## Applied (auto-fixes)

None. Per skill rules: citations are never auto-edited; number fixes are flag-only when the object name is well-identified but multiple correction candidates (different cosmology runs) could in principle produce different values. All fixes require author judgement.

---

## Flagged — your hand required

**❌ FAIL items requiring correction:**

- **N3** — ρ_cr,0 = 9.5×10⁻²⁷ kg m⁻³ is wrong for H₀ = 70. Recomputed value is **9.2×10⁻²⁷ kg m⁻³** (astropy: 9.204×10⁻²⁷). The quoted value implies H₀ ≈ 71.1 km/s/Mpc. Fix: `\approx 9.2 \times 10^{-27}~\text{kg\,m}^{-3}`.

- **N4e** — χ(z=5.0) = 7950 Mpc is wrong. Recomputed: **7775 Mpc** (concordance, no radiation) or 7773 Mpc (with Ω_r = 9×10⁻⁵). The 175 Mpc (2.2%) discrepancy is not rounding. Fix: change table entry to 7775 (or 7780 if rounding to nearest 10 Mpc).

- **N9** — Figure caption states "For z_s=1, lensing is most efficient at z_d ≈ 0.3". Recomputed: peak at **z_d ≈ 0.35** (fine scan: z_d=0.30 gives E=587 Mpc, z_d=0.35 gives E=595 Mpc, z_d=0.40 gives E=588 Mpc; maximum clearly at 0.35). Fix: change to "z_d ≈ 0.35".

- **X1** — T^{μν} paragraph states both T^{00} = ρc² and T_{00} = ρc⁴ (line ~337). With g_{00} = −c², these are related by T_{00} = (g_{00})² T^{00} = c⁴ × T^{00}, so T^{00} and T_{00} must differ by exactly c⁴. But ρc⁴ / ρc² = c² ≠ c⁴. One of the two is wrong:
  - If ρ is mass density (energy density = ρc²), the rest-frame energy density T^{00} = ρc², and T_{00} = ρc⁶.
  - OR T^{00} = ρ (mass density), and T_{00} = ρc⁴ (which is what the Friedmann derivation requires — see derivation in sec. 6.1 where RHS = (8πG/c⁴)ρc⁴ = 8πGρ).
  Recommend: change T^{00} = ρc² → T^{00} = ρ, and add a note clarifying that ρ here is the mass-energy density (energy density / c²), so T^{00} = (energy density / c²) and T_{00} = ρc⁴.

**⚠ SUSPECT items for author review:**

- **C2b** — z_s = 1.41 for Q0957+561: the Walsh et al. (1979) abstract in Zotero gives z = 1.405; other references cite 1.413. The chapter value 1.41 is intermediate. Recommend verifying against the specific modern reference and citing it (e.g., Falco et al. 1997, AJ 113, 1754 give z_s = 1.413).

- **C3-note** — Hogg (1999) eq. 19 is stated to be valid only for Ω_k ≥ 0 (see text after eq. 19 in the paper). The chapter applies it to "general (non-flat) universe" without restriction. Add a caveat.

- **C5** — Carroll / Congdon & Keeton / Narayan & Bartelmann equation-number attributions (eq. 8.2, 8.5, 8.6, 8.8, 3.113, 3.123, 4.9, etc.) cannot be verified without text access. Recommend author spot-check each equation number.

- **N5** — D_A max stated as "approximately 1770 Mpc": computed 1747.6 Mpc at z=1.605. The z-value of ~1.6 is correct. The peak DA amplitude is off by ~22 Mpc (~1.3%). If the figure was generated by the companion Mathematica notebook with the same inputs, regenerate and re-read the peak value numerically.

- **X2** — Clarify that H₀ = 70 km/s/Mpc is a round "concordance" value and is NOT from Planck 2018 (which gives 67.4 ± 0.5). Consider a footnote distinguishing the textbook working value from the Planck best fit.

---

## Summary

**Active adapters:** crossref-web ✓, Zotero overlay ✓, doc-internal ✓, python3/astropy recomputation ✓; bibtex ✗; Carroll/Congdon & Keeton textbooks not text-accessible (those equation-number attributions remain SUSPECT).

**Verdict counts (23 claims checked):** ✅ PASS 12 · ⚠ SUSPECT 6 · ❌ FAIL 4 (N3, N4e, N9, X1)

**Real catches:**
1. **(N3) ρ_cr,0 wrong by ~3%**: 9.5×10⁻²⁷ should be 9.2×10⁻²⁷ kg m⁻³ for H₀=70 (astropy confirmed).
2. **(N4e) χ(z=5) off by 175 Mpc (2.2%)**: 7950→7775 Mpc; all cosmology variants give ~7775.
3. **(N9) Lensing efficiency peak for z_s=1 misquoted**: "z_d≈0.3" should be "z_d≈0.35" (computed maximum unambiguously at 0.35).
4. **(X1) T^{00} vs T_{00} internal inconsistency**: T^{00}=ρc² and T_{00}=ρc⁴ cannot coexist with g_{00}=−c² (imply ratio c² not c⁴); correct derivation needs T^{00}=ρ and T_{00}=ρc⁴.

**Notable SUSPECTs:** D_A max overstated by ~22 Mpc (1.3%); Q0957+561 z_s=1.41 vs 1.405 in Walsh+1979; Hogg (1999) Ω_k≥0 restriction not noted; H₀=70 vs Planck-2018 67.4 not distinguished.

**All final cosmological formulas and most numerical worked examples are correct** (Dds example, θ_E, t₀, Hubble timescale/distance). The errors cluster in: a unit/convention mistake in the critical density, a high-z table entry, a figure caption lensing peak redshift, and an internal inconsistency in the perfect-fluid stress-energy tensor components.

---

## Harden pass (2026-07-09)

### NUMBERS re-verified (astropy; Mathematica license inactive — .wl values cross-checked via Python)

| claim | .tex value | astropy result | status |
|-------|-----------|----------------|--------|
| ρ_cr,0 | 9.2×10⁻²⁷ kg m⁻³ | 9.204×10⁻²⁷ | ✅ confirmed |
| χ(z=0.1) | 420 Mpc | 418.5 Mpc | ✅ within rounding |
| χ(z=0.5) | 1880 Mpc | 1888.6 Mpc | ✅ within rounding |
| χ(z=1.0) | 3300 Mpc | 3303.8 Mpc | ✅ confirmed |
| χ(z=2.0) | 5200 Mpc | 5179.9 Mpc | ⚠ 20 Mpc off (unchanged; ⚠ from prior pass) |
| χ(z=5.0) | 7775 Mpc | 7775.4 Mpc | ✅ confirmed |
| D_A max | 1748 Mpc at z≈1.6 | 1747.6 Mpc at z=1.606 | ✅ confirmed |
| Lensing peak z_s=1 | z_d≈0.35 | z_d=0.3504 | ✅ confirmed |
| Lensing peak z_s=2 | z_d≈0.5 | z_d=0.519 | ✅ confirmed |
| t_H | ≈14 Gyr | 13.97 Gyr | ✅ confirmed |
| d_H | 4.28 Gpc | 4.283 Gpc | ✅ confirmed |
| D_d(0.5), D_s(2.0), D_ds | 1259, 1727, 1097 Mpc | 1259.1, 1726.6, 1097.1 | ✅ confirmed |
| t₀ | ≈13.5 Gyr | 13.47 Gyr | ✅ confirmed |
| θ_E (M=10¹² M⊙, z_d=0.3, z_s=1) | ≈2.4″ | 2.379″ | ✅ confirmed |

**Mathematica notebook (.wl) verification:** wolframscript license inactive on this machine (produces license error at launch rather than at exit). Numbers verified entirely via astropy (FlatLambdaCDM H0=70, Om0=0.3). The .wl script is structurally correct (Section 3 comment explicitly uses `T_{00} = rho*c^4`, consistent with the fix applied below).

### APPLIED-FIX re-verification (prior controller pass, 2026-07-01)

All four controller-applied fixes confirmed present and numerically correct in the .tex:
1. **N3** ρ_cr,0 `9.5→9.2×10⁻²⁷ kg m⁻³` — line 499: `9.2 \times 10^{-27}` ✅
2. **N4e** χ(z=5) `7950→7775 Mpc` — line 683: `7775` ✅
3. **N5** D_A max `1770→1748 Mpc` — line 755: `1748~Mpc` ✅
4. **N9** Lensing peak `z_d≈0.3→z_d≈0.35` — line 915: `z_d \approx 0.35` ✅

### PROSE FIX applied this pass

**X1 — T^{00} / T_{00} index inconsistency (❌ FAIL → ✅ FIXED)**

*Diagnosis:* With g_{00} = −c² and the prior text's U^μ = (c, 0, 0, 0), the formula gives T^{00} = ρc². Index-lowering via T_{00} = (g_{00})²T^{00} then yields ρc⁶, not the ρc⁴ stated — a factor-of-c² internal contradiction. The Friedmann (0,0) derivation (eq:rhs_00) requires (8πG/c⁴)·T_{00} = 8πGρ, which fixes T_{00} = ρc⁴; the Mathematica notebook Section 3 header also states `T_{00} = rho*c^4`. This requires T^{00} = ρ (not ρc²), which follows from U^0 = 1: the standard normalisation g_{μν}U^μU^ν = −c² with g_{00} = −c² gives (U^0)² = 1.

*Old (lines 329–338):*
```
U^\mu = (\speedoflight, 0, 0, 0) … T^{00} = \rho\speedoflight^2 …
With indices lowered: T_{00} = \rho\speedoflight^4 …
```

*New:*
```
U^\mu = (1, 0, 0, 0) [with g_{00}=-c², normalisation g_{μν}U^μU^ν=-c² gives U^0=1]
T^{00} = \rho …
T_{00} = (g_{00})^2 T^{00} = c^4\rho
```

T_{00} = ρc⁴ (already correct) retained unchanged. The lowering relation is now made explicit — (g_{00})²T^{00} = c⁴ρ — so the reader can verify it.

### STILL-OPEN

- **N4d** χ(z=2.0) = 5200 vs astropy 5180 Mpc (⚠ 20 Mpc, 0.4%) — author judgment; within rounding of "5200" but borderline.
- **C2b** Q0957+561 z_s = 1.41: Walsh+1979 gives 1.405; modern value 1.413. "1.41" is intermediate — author should cite a modern redshift measurement.
- **C3-note** Hogg (1999) eq. 19 valid only for Ω_k ≥ 0 — caveat not added.
- **C5** Carroll/Congdon & Keeton equation-number attributions — manual spot-check against physical texts still recommended.
- **X2** H₀ = 70 vs Planck 2018 (67.4) — footnote clarifying this is a pre-Planck round working value not yet added.
