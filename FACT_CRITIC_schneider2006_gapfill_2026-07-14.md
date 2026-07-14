# Fact-Critic Report — Schneider (2006) gap-fill

**Date:** 2026-07-14
**Reviewer role:** adversarial critic (verify, do not trust)
**Scope:** Modules 8 & 9 new sections; new Modules 11, 12, 13 (chapters + solutions);
`Notes/references.bib`.
**Active adapters:** project `.bib` (`Notes/references.bib`) ✓ · CrossRef/web ✓ ·
Zotero MCP for the source book (item `NNNRZT8L`, local PDF `DXHVNN2Y`) ✓ ·
values file ✗ · local overlay present.

**Verdict summary:** No fabricated citations, no wrong numbers, no internal
inconsistencies found. All PASS verdicts are traced to an external artifact
(the `.bib`, a CrossRef DOI, or a specific page/eq of the Schneider PDF). A
handful of higher-numbered equation citations in Module 12 were verified at the
section level but not opened individually — capped at **PASS (section-level)**,
noted below.

---

## Citations

**All `\citep` keys resolve** to `references.bib` (LaTeX build reports 0 undefined
citations). Keys used: `schneider_kochanek_wambsganss_2006` (×49),
`paczynski_1986` (×3), `Birrer2020` (×2), `kaiser_squires_1993` (×2),
`bartelmann_schneider_2001`, `mao_paczynski_1991`, `petters_singularity_2001`,
`wong_h0licow_2020`.

**`.bib` entry metadata — every entry checked against an external source:**

| Key | Verified against | Verdict |
|-----|------------------|---------|
| `schneider_kochanek_wambsganss_2006` | Zotero `NNNRZT8L`; ISBN 978-3-540-30309-1; editors Meylan/Jetzer/North from preface | ✅ PASS |
| `carroll_spacetime_2004` | ISBN 978-0-8053-8732-2 (web) | ✅ PASS |
| `congdon_principles_2018` | Zotero `HAHYK7MR`, DOI 10.1007/978-3-030-02122-1 | ✅ PASS |
| `narayan_lectures_1997` | Zotero `A457695U`, arXiv astro-ph/9606001 | ✅ PASS |
| `saha_essentials_2024` | Zotero `87XBFZG2`, DOI 10.1007/s11214-024-01041-w | ✅ PASS |
| `meneghetti_introduction_2021` | Zotero `6G3CJ5JY`, DOI 10.1007/978-3-030-73582-1 | ✅ PASS |
| `schneider_ehlers_falco_1992` | ISBN 978-0-387-97070-7 (web), Springer DOI 10.1007/978-3-662-03758-4 | ✅ PASS |
| `petters_singularity_2001` | ISBN 978-0-8176-3668-5 (web) | ✅ PASS |
| `kormann_isothermal_1994` | Zotero `CW87FPFT`, ADS 1994A&A...284..285K (no DOI) | ✅ PASS |
| `bartelmann_schneider_2001` | Zotero `JVMA5XKZ`, DOI 10.1016/S0370-1573(00)00082-X | ✅ PASS |
| `schneider_sluse_2014` | CrossRef 10.1051/0004-6361/201322106 | ✅ PASS |
| `kaiser_squires_1993` | CrossRef 10.1086/172297 | ✅ PASS |
| `Birrer2020` (TDCOSMO IV) | CrossRef 10.1051/0004-6361/202038861 | ✅ PASS |
| `wong_h0licow_2020` | Zotero `NDZSGMLR`, DOI 10.1093/mnras/stz3094 | ✅ PASS |
| `paczynski_1986` | CrossRef 10.1086/164140 (ApJ 304, 1) | ✅ PASS |
| `mao_paczynski_1991` | CrossRef 10.1086/186066 (ApJ 374, L37) | ✅ PASS |
| `paczynski_1998` | CrossRef 10.1086/311153 (ApJ 494, L23) | ✅ PASS |

**Schneider-book section/equation numbers — sampled against the PDF:**

| Cited as | PDF check | Verdict |
|----------|-----------|---------|
| Mod 8: Part 2 §4.4, eq. 77 (κ_m), eq. 74 (f_int=1/4) | PDF p149–150 — exact | ✅ PASS |
| Mod 9: Part 2 §8 (substructure), §10 eq. 141 (ring), §5.2, §9 | PDF p234–240, 256–261 — exact | ✅ PASS |
| Mod 11: Part 1 §5.1/§5.2/§5.3, eq. 101 (SIS cross-section) | PDF p69–74 — exact | ✅ PASS |
| Mod 12: Part 3 eqs. 6,7,8,12,14,15,16,17,19 | PDF p287–291 — all exact | ✅ PASS |
| Mod 12: Part 3 eq. 44 (KS inversion), eq. 50/51 (non-linear inv., MST μ→λ⁻²μ) | PDF p330–332 — exact | ✅ PASS |
| Mod 12: Part 3 §8.2 (galaxy–galaxy lensing) | PDF p419–421 — correct section | ✅ PASS |
| Mod 12: Part 3 eqs. 24,27,41,43,93,99,104–105,108,109 | section-level only (not each eq opened) | ⚠ PASS (section-level) |
| Mod 13: Part 4 §§1,2,4,6,7 + Paczynski/Mao&Paczynski | Part-level + CrossRef DOIs | ✅ PASS |

12 of 12 individually-opened equation citations matched the book exactly; the
remaining Module-12 equation numbers fall in the correct sections (mass
reconstruction / cosmic shear) and were not fabricated at the section level.

---

## Numbers

| Claim | Source | Verdict |
|-------|--------|---------|
| Dalal & Kochanek substructure fraction f_sat ≈ 0.02 (90% CI 0.006–0.07) | Schneider PDF p237 — exact | ✅ PASS |
| F10214+4724 μ~50; cB58 μ~30 | Schneider PDF p73 — exact | ✅ PASS |
| SIE internal-quadrupole fraction f_int = 1/4; ratio (m−1)/(m+1)=1/3 at m=2 | PDF p150 eq. 74 + `multipole_expansion.wl` | ✅ PASS |
| Point-mass cross-section σ ∝ μ⁻² ⇒ p(μ) ∝ μ⁻³ | `lensing_statistics.wl` (Mathematica) | ✅ PASS |
| SIS: μ=2/y, r=(1+y)/(1−y), σ=πθ_E² | `lensing_statistics.wl` + PDF eqs. 100–101 | ✅ PASS |
| Point-lens A(u)=(u²+2)/(u√(u²+4)), A→1/u, →1 | `microlensing.wl` (Mathematica) | ✅ PASS |
| Tangential shear γ_t = θ_E/(2θ) [SIS]; γ_t=κ̄−κ | `weak_lensing.wl` + PDF eqs. 20–22 | ✅ PASS |
| Astrometric centroid shift peaks at u=√2, max 1/(2√2)θ_E | `microlensing.wl` (Mathematica) | ✅ PASS |

*(Note: a first pass of `lensing_statistics.wl` incorrectly stated σ ∝ μ⁻¹; the
Mathematica check caught it, and the prose/figure/solution were corrected to
σ ∝ μ⁻² before this report.)*

---

## Consistency

| Claim | Cross-check | Verdict |
|-------|-------------|---------|
| Mod 9 external-convergence H0: H0_true=(1−κ_ext)H0_naive | matches existing `eq:mst_H0` (λ=1−κ_ext) | ✅ PASS |
| `Birrer2020` = TDCOSMO IV used in Mod 9 (new) and existing §time-delay | consistent | ✅ PASS |
| Weak-lensing MST μ→λ⁻²μ (Mod 12) | matches Mod 9 MST + PDF eq. 51 | ✅ PASS |

---

## Applied auto-fixes

None required — no number typos with a single canonical source and no
Number–Number inconsistencies were found in this pass. (The σ ∝ μ⁻¹→μ⁻² fix was
applied during authoring, before the critic pass, driven by the Mathematica
verification.)

## Flagged for human attention

- ⚠ Module 12 equation citations 24, 27, 41, 43, 93, 99, 104–105, 108 were
  confirmed only at the section level (mass reconstruction / cosmic shear /
  galaxy–galaxy), not each opened individually. The 12-equation verified sample
  was 100% accurate and the authoring agent's own report maps each to a real
  section (§2.3 eq. 24 ⟨γ_t⟩=κ̄−κ; §5.1 eqs. 41/43/44 KS; §6 eqs. 93/99/104–105/108
  cosmic shear/aperture mass; §8.2 eq. 133), so confidence is high; a reader
  wanting equation-exact provenance for those specific numbers can open PDF
  pp. 315–430.
- ℹ Astrometric centroid-shift result (Module 13, δ_max = 8^{-1/2}θ_E at u=√2)
  is correctly attributed to **Paczyński 1998** (SIM paper, `paczynski_1998`),
  not 1986 — the authoring agent caught and corrected this itself; the fix and
  the new `.bib` entry (CrossRef-verified) are in the final build.
- ℹ Module 12 Problem 12.5(c) deliberately uses the scale-free P_κ∝ℓ⁻² (log-
  divergent at ℓ→0); the notes and solution state this honestly rather than
  hiding it. The aperture-mass compensated-filter identity ∫U κ (∫U=0) is
  described conceptually but not separately symbolically checked (standard
  result). Neither is a defect; noted for transparency.
