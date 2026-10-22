# fact-critic report — Notes/18_MSD_Kinematics/ (Chapter 18, PDF chapter 22)

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation (per Part V critic brief)
> Scope: `Notes/18_MSD_Kinematics/18_MSD_Kinematics.tex`, `18_Solutions.tex`,
> `Mathematica/18_MSD_Kinematics/msd_multiplane.wl`, `Solutions/18_MSD_Kinematics/problems_18.wl`,
> `Figures/18_MSD_Kinematics/msd_powerlaw_kappa.pdf`.
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (on, reachable: 12 DOIs resolved
> via api.crossref.org; arXiv export API for 1406.6152, 1409.0015, 2007.02941, 1306.0901, 1306.4675, 1911.05083;
> full-text PDFs of 1406.6152, 1409.0015, 2007.02941 read with pdftotext), md-reflist ✗ (n/a), values-file ✗
> (none), repo-grep ✓, doc-internal ✓, Reference_Texts PDFs ✓ (Congdon & Keeton, Meneghetti, Saha et al. 2024),
> Mathematica ✓ (`bash Mathematica/run_wl.sh`), overlay: AGEL `local/agel-sources.md` loaded (Zotero not needed:
> every citation resolved via CrossRef + arXiv full text).
> (A claim whose lens has no active adapter is capped at ⚠ SUSPECT.)
> Provenance lens: not run (not in the Part V brief's lens list). For the record, the chapter is model-drafted
> (commit 87a084a, Co-Authored-By Claude); every sentence is machine-introduced relative to an author baseline.

**Repo scripts (run 2026-10-14):**
- `Mathematica/18_MSD_Kinematics/msd_multiplane.wl` → `SUMMARY: 69 PASS, 0 FAIL  (of 69 checks)`
  (one benign `Solve::ifun` message; the run re-exported the figure PDF byte-differently, which was reverted with
  `git checkout`, so the committed figure is untouched).
- `Solutions/18_MSD_Kinematics/problems_18.wl` → `SUMMARY: 40 PASS, 0 FAIL  (of 40 checks)`.
- Every check id the chapter and solutions cite (s1–s14, t1–t4g, l1–l10, k1–k19, 1a–8c, 5g) exists in the run output.

**Verdict counts:** 57 rows — ✅ PASS 48 · ⚠ SUSPECT 9 · ❌ FAIL 0. Applied auto-fixes: 0.

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | MST `\citealp{falco_gorenstein_shapiro_1985}` | ✅ PASS | bib:falco_gorenstein_shapiro_1985 / CrossRef DOI 10.1086/184422 (ApJ 289 L1); Schneider 2014 §1 credits Falco+85 with the MST | none |
| C2 | Citation | "Congdon & Keeton's Eq. (4.88)" | ✅ PASS | Reference_Texts C&K §4.7.2 p.110, Eqs. 4.88a–b (β→(1−κ0)β, ψ→(1−κ0)ψ+κ0θ²/2); DOI 10.1007/978-3-030-02122-1 | none |
| C3 | Citation | "Meneghetti's Eqs. (5.146)–(5.150)" | ✅ PASS | Reference_Texts Meneghetti §5.9 p.228: 5.146 ψ transform, 5.147 κ, 5.148 γ, 5.149–5.150 eigenvalues ×λ | none |
| C4 | Citation | "Eq. (51) of Saha et al., also called the steepness degeneracy" | ✅ PASS | Reference_Texts Saha+24 §3.7 p.24, Eq. 51 and "Another name is the steepness degeneracy"; DOI 10.1007/s11214-024-01041-w | none |
| C5 | Citation | "multiple source planes break the MSD (§msd item 3; Saha §3.7)" (known distances) | ✅ PASS | Saha+24 §3.7 p.24: MST "prevented from being applied globally if sources at different redshifts are present (because Σcr is not the same)"; Ch.13 `09_…tex:635-638` item 3 | none |
| C6 | Citation | `\citet{schneider_sluse_2013}` "formal precision of time-delay H0 rests on assuming … exact power law" | ✅ PASS | bib + CrossRef DOI 10.1051/0004-6361/201321882; arXiv 1306.0901 abstract: "the formal precision relies on the assumption that the mass profile is a perfect power law" | none |
| C7 | Citation | internal sheet: "field counts cannot touch it" (in SS13 context) | ✅ PASS | arXiv 1306.0901 abstract: "characterization of the environment of the lens does not break that degeneracy" | none |
| C8 | Citation | SPT `\citealp{schneider_sluse_2014}`; MST = exact linear member | ✅ PASS | CrossRef DOI 10.1051/0004-6361/201322106; arXiv 1306.4675 abstract ("of which the MST is a special case"); C&K §4.7.3 p.111 (only f(β)=aβ keeps an exact mass distribution) | none |
| C9 | Citation | DSPL cosmography `\citealp{collett_2012,collett_auger_2014}` | ✅ PASS | CrossRef 10.1111/j.1365-2966.2012.21424.x (MNRAS 424, 2864) and 10.1093/mnras/stu1190 (MNRAS 443, 969); titles match | none |
| C10 | Citation | `\citet{schneider_2014_multiplane}` showed MST survives two lens planes; his β = our 𝓑 | ✅ PASS | CrossRef 10.1051/0004-6361/201424450 = A&A 568 L2 (matches brief); arXiv 1406.6152v2 §2.1 Eq. 3: β_ij = D_ij D_N/(D_j D_iN), β≡β12 = D_{d,s1}D_{s2}/(D_{s1}D_{d,s2}) = Eq. ms_brat | none |
| C11 | Citation | "Schneider 2014, Eqs. 6–11" for Eq. ms_schneider | ✅ PASS | 1406.6152 Eq. 6 α1′=λα1+(1−λ)θ/β; Eq. 11 ν3=1, K2=(λ−1)/(λβ), α2′(θ2′)=α2(θ2′/λ)+K2θ2′ | none |
| C12 | Citation | "Schneider's Eq. 13" (λ⁻¹κ(θ/λ)) | ✅ PASS | 1406.6152 Eq. 13 α(θ/λ\|κ)=α(θ\|λ⁻¹κ(θ/λ)) | none |
| C13 | Citation | all delays on both planes scale by λ; ratios cannot break the MST | ✅ PASS | 1406.6152 abstract and §2.4 (Eq. 17 discussion) | none |
| C14 | Citation | "his Eqs. 18–20" for a change of cosmology | ✅ PASS | 1406.6152 §3 Eqs. 18–20 (ν2=β′λ/β, K1=1/β′−λ/β, ν3=(β/β′)(1−β′)/(1−β)) | none |
| C15 | Citation | local MST: "main effect is to change the local slope near θE" `\citep{schneider_2014_multiplane}` | ✅ PASS | 1406.6152 §2.3: "Its main effect is the change of the local slope of the mass profile near the Einstein radius … flatter (steeper) for λ<1 (λ>1)" | none |
| C16 | Citation | `\citep{schneider_2019_generalized}` arbitrary planes: scaling alternates λ ↔ 1, all delays ×λ | ✅ PASS | bib eprint 1409.0015 / CrossRef 10.1051/0004-6361/201424881 = A&A 624 A54 (matches brief); arXiv full text §4.3: "scaling factor in every second plane is just unity, whereas it is λ in the other half"; abstract: delays in all planes scale by same factor | none |
| C17 | Citation | SS13 "power-law assumption … sets λ=1 by fiat" | ✅ PASS | 1306.0901 abstract (formal precision from perfect power law); 1406.6152 §1 "the degeneracy due to the MST is broken by assumptions … e.g., that it follows a power law. … Schneider & Sluse (2013)" | none (paraphrase is fair) |
| C18 | Citation | ξ ≡ θE α″(θE)/[1−κ(θE)], MST-invariant, ξ=2(γ′−2) for a power law — **stated without attribution** | ⚠ SUSPECT (missing attribution) | arXiv 1911.05083 abstract (Kochanek 2020, MNRAS 493, 1725, DOI 10.1093/mnras/staa344, CrossRef-confirmed): "the dimensionless quantity ξ=R_E α″(R_E)/(1−κ_E) … for a power law ξ=2(n−2)". Not in Saha §3.7 (read in full) nor in the SS13 abstract. Not in `references.bib`. | Attribute to Kochanek (2020); add bib entry (verify via Zotero/CrossRef first). Author's flag (4) adjudicated: it is a known, published invariant, not the author's own. |
| C19 | Citation | `\citet{Birrer2020}` H0 = 74.5 +5.6/−6.1 (TDCOSMO-only, "seven time-delay lenses") | ✅ PASS | bib:Birrer2020 / CrossRef 10.1051/0004-6361/202038861 (A&A 643 A165); arXiv 2007.02941 abstract: "TDCOSMO sample of 7 lenses … H0=74.5+5.6−6.1" | none |
| C20 | Citation | +33 SLACS, 9 with resolved kinematics for anisotropy, same parent population, H0 = 67.4 +4.1/−3.2 | ✅ PASS | arXiv 2007.02941 abstract verbatim on all four facts | none |
| C21 | Citation | "power law scaled by λ_int plus a large core is the parameterisation used in the TDCOSMO hierarchical analysis" | ✅ PASS | 2007.02941 full text §2.6 "Approximate internal mass-sheet transform": cored κ_c as approximate MST; "An approximate internal MST of a power law with λint" | none |
| N1 | Number | images θA=1.1692θE, θB=−0.8364θE (γ′=2.2, β=0.2θE) | ✅ PASS | critic D6d (FindRoot); repo s5 | none |
| N2 | Number | λ=1.2 profile crosses κ=0 "near 2θE" | ✅ PASS | critic D6f: 2.074 θE | none |
| N3 | Number | η falls by 3.2% (γ′=2, 𝓑=0.7, λ2=0.9) | ✅ PASS | critic D2b: 1−0.9/0.93 = 3.23% | none |
| N4 | Number | 𝓑′=70/97=0.7216, λ1=90/97=0.9278; 𝓑 overestimated 3.09% | ✅ PASS | critic D1h (exact rationals); repo t3f, 3d | none |
| N5 | Number | γ″−1 = 0.914602, γ″=1.9146 (Sol. 18.3c) | ✅ PASS | independent: ln(70/97)/ln 0.7 = 0.9146023 | none |
| N6 | Number | K1=+0.0714, K2=−0.0752 (λ=0.95, 𝓑=0.7) | ✅ PASS | (0.05/0.7, −0.05/0.665); repo 4c–4d; critic D3c (K1/K2=−λ) | none |
| N7 | Number | Δτ≃(γ′−1)(θA²−θB²)/2 to <10⁻⁴ at β=0.005θE, γ′∈{1.6,2,2.4}; Δτ≃2βθE | ✅ PASS | critic D6 (3 slopes) | none |
| N8 | Number | anisotropy: +12.5% / −8.3% (γ′=ν=2, β_a=±0.2); 22/21, 28/29 (ν=2.5) | ✅ PASS | critic D5g (exact rationals from Eq. ms_F) | none |
| N9 | Number | half-width 10.4% vs 8% statistical (Sol. 18.5) | ✅ PASS | (1.125−0.9167)/2 = 0.104; 2×10/250 = 0.08 | none |
| N10 | Number | 1% in λ needs 0.5% in σ = 1.25 km/s at 250 | ✅ PASS | dlnλ = 2 dlnσ (critic D5 linearity); arithmetic | none |
| N11 | Number | decoupling radius e^{1/2}R_E ≈ 1.65 R_E (1.649); ∂lnF/∂γ′=1/2 | ✅ PASS | critic D5f (symbolic derivative of Eq. ms_F at (2,2,0)); D5 brute-force validates Eq. ms_F itself | none |
| N12 | Number | Sol. 18.7: ln 0.5 − 0.5 = −1.193; δγ′=+0.1 → −11.9% | ✅ PASS | arithmetic; repo 7c | none (linearised; exact e^{−0.119}−1 = −11.3%, fine as a first-order statement) |
| N13 | Number | σv ≈ 250 km/s from θE=1.15″, Dds/Ds=0.638 (Ch.11 worked example) | ✅ PASS | critic D6e: 250.001 km/s; `07_Axisymmetric_Models.tex:495-512` has the same example | none |
| N14 | Number | H0 naive high by 11.1% at λ=0.9 | ✅ PASS | 1/0.9 | none |
| N15 | Number | ξ = −0.2 for the γ′=1.9 power law (Sol. 18.6) | ✅ PASS | critic D4c: ξ=2(γ′−2) | none |
| N16 | Number | Eq. ms_F validity "ν<3 and 3<ν+γ′<5" | ⚠ SUSPECT (incomplete) | critic D5 derivation: the projected tracer Σ* needs ν>1 (the Γ((ν−1)/2) factor), the mass projection needs γ′>1, and σ_r²>0 needs ν+γ′−2−2β_a>0 | Add "ν>1, γ′>1, ν+γ′−2>2β_a" to the stated validity range. |
| X1 | Consistency | "Chapter~\ref{…}" targets (9 chapter refs) | ✅ PASS | `pdftotext -l 14 Output/Learning_to_Lens_Annotated.pdf`: galaxy_lensing=Ch13, weak_lensing=Ch16, central_mass_bias=Ch21, magnification=Ch9, fermat_time_delays=Ch10, axisymmetric_models=Ch11, multiplane_dspl=Ch18, cosmological_distances=Ch7, odd_images=Ch20; contents match each use | none |
| X2 | Consistency | all external \eqref/\S labels (22) resolve; content matches (mst_H0 sign, kappa_power_law, sis_einstein_radius, sigma_cr_recap, mass_einstein, wl_mst, wl_g_invariant, alpha_mean_kappa, eigenvalues) | ✅ PASS | grep of labels in `Notes/*/*.tex` | none |
| X3 | Consistency | H0^true = λ H0^naive, positive sheet → naive too high | ✅ PASS | `09_Galaxy_Lensing_Applications.tex:497-505` (eq:mst_H0) identical | none |
| X4 | Consistency | free-ratio relations vs Ch.13 bridge (`09_…tex:644-666`) | ✅ PASS (algebra) | Ch.13 η′=λη/[1−η(1−λ)] is the inverse map of Eq. ms_free (truth/model roles swapped); substituting B=η′, B′=η, λ2=λ reproduces it | see X5 for notation |
| X5 | Consistency | Ch.13 bridge uses **η for the distance ratio** and numbers the far plane 1; Ch.18 and the preamble use η (`\etamea`) for the Einstein-radius ratio θE1/θE2, 𝓑 for the distance ratio, plane 1 = near | ⚠ SUSPECT (notation clash across chapters) | `preamble.tex:157,161`; `09_…tex:646-660` | Rewrite the Ch.13 bridge in 𝓑 / near=1 notation (file outside Ch.18 scope; not edited). |
| X6 | Consistency | "Chapter 21 shows that a power-law fit … steepens γ′", λ_eff>1 (l.546-549); "absorbs by steepening γ′" (l.740) | ⚠ SUSPECT (over-generalised) | `17_Central_Mass_Bias.tex:594`: "*Signs, in this configuration.* The fitted slope steepens"; l.597-600 shows the coefficient changes with geometry | Qualify: "in the configurations studied there"; drop the unconditional ">1" or say "when the fit steepens". |
| X7 | Consistency | Bridge l.283-285: "𝓑 is the ratio of the two distance ratios Dds/Ds of … Eq. distance_ratio" | ⚠ SUSPECT (label/content mismatch) | `03_Cosmological_Distances.tex`: eq:distance_ratio defines 𝒟 ≡ Dds/(Dd Ds), not Dds/Ds (the ratio of two 𝒟's still equals 𝓑 because Dd cancels) | Say "the ratio of the two 𝒟 = Dds/(Dd Ds)" or drop the equation pointer. |
| X8 | Consistency | Chapter ↔ Solutions ↔ .wl: every quoted value (70/97, 90/97, 30/31, 9/8, 11/12, 1.193, 1.649, K1, K2, γ″) | ✅ PASS | internal: all occurrences agree; repo SUMMARY lines above | none |
| X9 | Consistency | check-id citations in text exist in the scripts | ✅ PASS | run outputs list every cited id | none |
| X10 | Consistency | project-leakage lint `tier|scripts/|results/|lenstronomy|autolens|J0946|AGEL|Carousel|this project` (+ "note 5", "spiral") | ✅ PASS | grep over all 4 in-scope files: 0 hits | none |
| X11 | Consistency | brief traps: 𝓑=D_ls1D_s2/(D_s1D_ls2)<1; 𝓑=η^{γ′−1}; κ(θE)=(3−γ′)/2; α∝θ^{2−γ′}; MST rules (κ_λ, β_λ, Δt∝λ, det A∝λ²); H0 sign | ✅ PASS | Eq. ms_brat/ms_eta/ms_powerlaw/keybox all match; 1406.6152 Eq. 3 | none |
| D1 | Derivation | Eq. ms_free (𝓑′, λ1, (1−λ1)/(1−λ2)=𝓑′) + η invariance | ✅ PASS | critic D1a–D1h | none |
| D2 | Derivation | Eq. ms_thetaE1_shift (known distances, θE1 moves) | ✅ PASS | critic D2a–D2b | none |
| D3 | Derivation | Eq. ms_schneider (ν3=1, θ2′=λθ2, θ3′=θ3, K1/K2=−λ) | ✅ PASS | critic D3a–D3d | none |
| D4 | Derivation | Eqs. ms_local_pl/mst/local + l.3 mismatch λ(1−λ)(γ′−1)² + ξ | ✅ PASS | critic D4a–D4e | none |
| D5 | Derivation | Eqs. ms_sigap × ms_F (Jeans, projection, aperture, normalisation) | ✅ PASS | critic D5 (brute-force at 4 points) + D5e–D5g | none |
| P1 | Prose | l.158 "it is the most common sign error in this subject" | ⚠ SUSPECT (unsourced superlative) | no adapter | "a common sign error" or drop the clause |
| P2 | Prose | aphoristic closers: l.394-395 "A second source plane gives you a second ruler, but both rulers are read through the same unknown lens."; l.505-506 "*a change of slope is an MST*"; l.533 "the source position absorbs the slope"; l.720-721 "The error bars are the lesson: once the MST is freed, kinematics carries the measurement."; l.758 "Two independent combinations are what it takes to pin both." | ⚠ SUSPECT (aphoristic closer / colon reveal) | read | author rewrites, e.g. l.720: "Freeing λ_int widens the H0 interval to about ±6 km s⁻¹ Mpc⁻¹; the kinematics alone sets that width." |
| P3 | Prose | triad framing repeated: l.68 "Three facts carry the whole argument", l.353 "Three features … carry the physics", l.454 "Three consequences follow" | ⚠ SUSPECT (rule-of-three cadence) | read | vary or delete the lead-in sentences; the enumerations themselves are content |
| P4 | Prose | l.36 "an MST in disguise"; l.164 "It is worth seeing"; l.230 "suppresses exactly this freedom"; l.700-701 "has to be computed, not assumed"; Sol. l.161-162 "not at R_E: the proxy misplaces the slope-free aperture" | ⚠ SUSPECT (model vocabulary / pointer phrase / antithesis) | read | author rewrites in own words |

## Applied (auto-fixes)

None. No number typo traceable to a single canonical source and no number-vs-number mismatch was found
inside the chapter's files.

## Flagged — your hand required

1. **C18 — ξ needs an attribution (author's flag 4).** The MST-invariant ξ ≡ θE α″(θE)/[1−κ(θE)] with ξ = 2(γ′−2)
   for a power law is **Kochanek (2020), MNRAS 493, 1725, "Overconstrained gravitational lens models and the Hubble
   constant", DOI 10.1093/mnras/staa344, arXiv 1911.05083**. The arXiv abstract gives both the definition
   ("x = R_E a″(R_E)/(1−k_E)") and the power-law value ("x = 2(n−2)"), and CrossRef confirms the DOI. It is not in
   Saha §3.7 (read in full) or the Schneider & Sluse 2013 abstract, and it is not in `references.bib`. Proposed:
   add a bib entry (via Zotero + CrossRef) and cite it at l.512-515 and in the l.757 bridge. The math itself is
   verified (critic D4c–D4e; repo l6–l7).
2. **N16 — the validity range of Eq. ms_F is incomplete (l.623-624).** It also needs ν>1, γ′>1, and
   ν+γ′−2−2β_a>0. As written, the range admits e.g. ν=0.8, γ′=2.5, where the tracer's projection diverges.
3. **X5 — η means two different things in two chapters.** The Ch.13 bridge to this chapter
   (`Notes/09_Galaxy_Lensing_Applications/09_Galaxy_Lensing_Applications.tex:644-666`) uses η for the *distance
   ratio* and calls the far plane "1". Ch.18 and `preamble.tex` use η (`\etamea`) for θE1/θE2, 𝓑 for the
   distance ratio, and plane 1 = near. The algebra agrees (X4: the Ch.13 map is the inverse of Eq. ms_free), but a
   reader going from Ch.13 to Ch.18 meets η = 𝓑 first and η = θE1/θE2 second. Proposed: restate the Ch.13 bridge
   in 𝓑 notation. That file is outside this chapter's scope, so I did not edit it.
4. **X6 — "Chapter 21 shows … steepens γ′" is over-general (l.546-549, l.740).** Ch.21 shows steepening "in this
   configuration" (`17_Central_Mass_Bias.tex:594`) and says the coefficient changes with image geometry.
   Proposed: "in the configurations of Chapter 21 the fit steepens γ′, an effective MST with λ_eff =
   (γ′_fit−1)/(γ′_true−1) (> 1 when the fit steepens)".
5. **X7 — Eq.~\ref{eq:distance_ratio} is cited as "Dds/Ds" (l.283-285).** It actually defines 𝒟 ≡ Dds/(Dd Ds).
   The conclusion survives because Dd cancels in the ratio. Fix the wording or the pointer.
6. **P1 — l.158 "the most common sign error in this subject"** is an unsourced superlative. Soften it to "a
   common sign error" or delete the clause.
7. **Prose P2–P4.** Five aphoristic closers, three "Three X …" lead-ins, and a few pointer or antithesis phrases.
   All are flag-only (see Prose below). The author should rewrite them in their own words.

**Author's flags, adjudicated:**
- (1) Free-distance-ratio MST: **re-derived, correct.** 𝓑′ = 1/(1−λ2+λ2/𝓑), λ1 = λ2/(𝓑(1−λ2)+λ2), and
  (1−λ1)/(1−λ2) = 𝓑′ (critic D1a–c). η is invariant (D1e–f numerically: both model Einstein radii unchanged to
  10⁻⁸ for γ′=2.3, 𝓑=0.7, λ2=0.85). The result is also reproduced independently as the α2=0 limit of
  Schneider 2014 Eq. 18 (D1d: ν2 = λ1).
- (2) Known distances: θE1 moves (Eq. ms_thetaE1_shift verified at γ′=2.2, D2a). This is consistent with Saha §3.7
  (Σcr differs per plane, so the global MST is prevented) and with Ch.13 item 3 plus its bridge. The X5 notation
  clash remains.
- (3) Schneider two-lens-plane MST: ν3 = 1, K2 = (λ−1)/(λ𝓑), and alternating sheet signs **match A&A 568 L2
  Eqs. 6–11 and the §2.3 text verbatim** (full text read). Also verified numerically with two explicit
  non-trivial lenses at 20 random points (D3a–b). Schneider 2019 confirms the λ/1 alternation for N planes.
- (4) The local MST γ′_eff−1 = λ(γ′−1) and the second-order mismatch λ(1−λ)(γ′−1)² are correct (D4a–b). ξ is
  Kochanek 2020's invariant, not the author's own (see item 1).
- (5) σ′² = λσ² holds for the SIS (repo k1). **The Jeans F(γ′,ν,β_a) closed form is confirmed by brute-force
  numerical Jeans + projection + aperture integration at four points**: (2,2,0), (2.2,2.5,0), (1.9,2.3,0.2) and
  (2.1,2,−0.3), with R_ap ∈ {0.5,0.7,1.3}R_E, all agreeing to <1×10⁻⁴ relative. The worst case, (2.2,2.5,0) at
  7×10⁻⁵, carries an NIntegrate convergence warning near R→0. ∂lnF/∂γ′ = 1/2 exactly at (2,2,0), so R_ap =
  e^{1/2}R_E holds (D5f).
- (6) Birrer 2020 numbers: **all confirmed from the arXiv 2007.02941 abstract** (74.5 +5.6/−6.1 from 7 lenses;
  33 SLACS; 9 with resolved kinematics; same parent population; 67.4 +4.1/−3.2). The λ_int + core
  parameterisation is confirmed from full-text §2.6.
- (7) Schneider & Sluse 2013: **confirmed** from the 1306.0901 abstract ("the formal precision relies on the
  assumption that the mass profile is a perfect power law").

## Prose (LLM tells) — flag-only

- `18_MSD_Kinematics.tex`: 4,844 words, 6 spaced em-dashes (≈1 per 800 words, below the 1/150 signal), 222
  sentences, sentence-length CV 0.52 (bursty; not a uniform-cadence signal). Antithesis hits: 2 (l.222 is
  content, l.700-701 is ornament).
- Worst offenders are the paragraph-closing maxims: l.394-395, l.505-506, l.533, l.720-721, l.758. One plain
  rewrite, for l.720-721: "Freeing λ_int widens the H0 interval to about ±6 km s⁻¹ Mpc⁻¹, and that width is set
  by the kinematics." Repeated "Three …" lead-ins appear at l.68, l.353, l.454.
- `18_Solutions.tex`: 964 words, 0 em-dashes. One antithesis at l.161-162. Otherwise it reads clean.
- No paragraph carries three or more tells, so there is no ❌.

## Derivation checks

Scratch script (outside the repo):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_18/critic18_derivations.wl`
(output: `critic18_derivations.out` in the same directory). It is self-contained and loads neither the repo
harness nor the chapter's scripts. Run via `bash Mathematica/run_wl.sh`.

**`SUMMARY: 32 PASS, 0 FAIL  (of 32 checks)`**

| id | equation(s) | method | result |
|----|-------------|--------|--------|
| D1 | Eq. ms_free + η invariance | Solve the two coefficient conditions; separately take Schneider 2014 Eq. 18 with α2=0; numeric FindRoot of both model Einstein radii (γ′=2.3) and of a near-plane image | PASS (D1a–h) |
| D2 | Eq. ms_thetaE1_shift | FindRoot of κ̄1′=1 at γ′=2.2, compared with the closed form; 3.2% example | PASS (D2a–b) |
| D3 | Eqs. ms_twoplane/ms_schneider | explicit cored-isothermal lenses in both planes (offset centres), 20 random θ: θ2′=λθ2, θ3′=θ3 to 10⁻¹²; general-ansatz Solve gives ν3=1 uniquely; K1/K2=−λ | PASS (D3a–d) |
| D4 | Eqs. ms_local_pl/mst, ms_local, ξ | symbolic Taylor coefficients; second-order mismatch; ξ for PL and its MST; ξ(γ_eff) | PASS (D4a–e) |
| D5 | Eqs. ms_sigap × ms_F | brute-force numerics: M2D normalised to M_E, Jeans integrated from ∞ with r^{2β} integrating factor, numerical LOS projection with the (1−β_aR²/r²) kernel, numerical aperture average; compared with λ(R_ap/R_E)^{2−γ′}F at 4 (γ′,ν,β_a,R_ap) points; F(2,2,0)=1/π, F(2,ν,0)=2/(νπ); ∂lnF/∂γ′=1/2; anisotropy rationals | PASS (D5×4, D5e–g) |
| D6 | Eq. ms_td_slope, PL roots, units check, κ=0 crossing | FindRoot images, Fermat-potential differences, arithmetic | PASS (D6×3, D6d–f) |

Repo scripts: `msd_multiplane.wl` → `SUMMARY: 69 PASS, 0 FAIL (of 69 checks)`; `problems_18.wl` →
`SUMMARY: 40 PASS, 0 FAIL (of 40 checks)`.

## Reconciliation with the spiral project's record (2026-10-14)

Source notes: `theory/note5_msd_kinematics.tex` and `theory/solutions/sol_note5_msd_kinematics.tex` in
`~/Documents/AGEL/202607_Theoretical_spiral_compound`. Record read: digest `docs/spiral_reconciliation_2026-10-14/note5.md`
(12 FAIL, 15 SUSPECT). `note8_solutions.md` has no `sol_note5` rows; the one packet-critic row that touches `sol_note5`
is S3-75. Also read: `theory/FACT_CRITIC_study_notes_2026-07-11.md` (N5-C5, N5-S1, PASS list),
`theory/solutions/FACT_CRITIC_SOLUTIONS_2026-07-24.md` (C1, C2, the H0-sign FAIL), `TESTS_AND_DIAGNOSTICS.md` rows A7, G4 and HS10,
`HANDOFF_arc_2026-09-21.md` §5–6, `lit_review/MSD_LITERATURE_REVIEW.md`, `lit_review/VERIFIED_ANCHORS_2026-07-16.md` §2,
`Reference_papers/README.md`, and the spiral memory notes `msd-and-kinematics-anchor.md` and `reference-papers-and-note11.md`.
The chapter is a heavy rewrite of note5. It drops all project content (G4/Tier-1 numbers, J0946/Ballard, the
Horseshoe/Melo-Carneiro section, HS10, the AGEL anchors, the LOS budget line, Teodori 2026, Shajib 2023), and it adds
derivations that the note does not contain: the exact two-source-plane MST, the Schneider two-lens-plane MST, the local MST
with ξ, and the full Jeans solution.
Note: the spiral working tree has uncommitted edits to note5 made today (S3-37, S3-42 and S3-72 applied as dated
footnotes). These do not change any row below.

Scratch re-verification (outside the repo):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/rec18/rec18_checks.wl`
run as `bash Mathematica/run_wl.sh <that path>`, giving **`SUMMARY: 8 PASS, 0 FAIL  (of 8 checks)`** (output in `rec18_checks.out`, same dir).
CrossRef records were fetched to the same directory (`cr1–cr5.json`):
10.1051/0004-6361/201424450 = Schneider 2014, A&A **568, L2**; 10.1051/0004-6361/201424881 = Schneider **2019**, A&A 624, A54;
10.1051/0004-6361/201321882 = Schneider & Sluse 2013, A&A 559, A37; 10.1051/0004-6361/201322106 = Schneider & Sluse 2014,
A&A 564, A103; 10.1093/mnras/staa344 = Kochanek 2020, MNRAS 493, 1725.

| spiral id | claim (note5 / sol_note5) | status in chapter | action |
|---|---|---|---|
| S3-01 (FAIL) | "Plain-text citations follow the verified MSD_LITERATURE_REVIEW.md"; Melo-Carneiro and Ballard are missing from it | n.a. The sentence is not ported. All cites in the chapter are `\cite` keys in `references.bib`, CrossRef-checked (C1–C21) | none |
| S3-10 (FAIL) | "each source plane can carry its *own* mass-sheet parameter" (Schneider 2014); this is really Teodori 2026, since Schneider has one λ that alternates λ/1 | **already fixed in the port.** The two-lens-plane MST (l.416-468) has a single λ, ν₃ = 1 and the λ↔1 alternation, cited to `schneider_2014_multiplane` (L2, Eqs. 6–11) and `schneider_2019_generalized`. The annotation at l.470-476 (a candle on the far plane cannot see the MST; one on the near plane can, μ×λ⁻²) matches Schneider's "planes with j odd cannot break it". The λ₁ ≠ λ₂ of Eq. ms_free (l.355-362) is the chapter's own derivation for a single deflector with free 𝓑, explained as one physical sheet. It is not attributed to Schneider. Teodori is not cited | none (scratch R7 re-checks det A₂′ = λ² det A₂) |
| S3-41, S3-42 (FAIL) | Melo-Carneiro §4.2.2 should be §4.2.1.1 | n.a. (Horseshoe content not ported). The spiral fix is already in its working tree | none |
| S3-20, S3-21 (FAIL) | 67.4 attributed to "Birrer 2020; Shajib 2023"; no units | **already fixed in the port.** l.714-719 gives both values to `Birrer2020` only, with units, asymmetric errors, 33 SLACS, 9 resolved, and the shared-parent-population assumption (C19, C20). Shajib 2023 is not cited | none |
| S3-72, S3-08 (FAIL / SUSP) | LOS "~1% on η" (Johnson+2025's η is our 𝓑⁻¹) | n.a. (no LOS budget line in the chapter, no Johnson cite) | none |
| S3-06 (FAIL) | SPT "Schneider & Sluse 2013, 2014"; SS13 (A&A 559 A37) is the MSD/power-law paper | **already fixed in the port.** SPT → `schneider_sluse_2014` (564 A103) at l.233-234. The internal-sheet/power-law statement → `schneider_sluse_2013` (559 A37) at l.228, l.554. Bib DOIs match CrossRef | none |
| S3-13 (FAIL) | "the crack the unmodelled SMBH exploits" metaphor (:74, :139) | already fixed. `grep crack` gives 0 hits in all four files | none |
| S3-75, S3-70 (FAIL) | "~1% target precision on 𝓑" / "percent-level cosmological signal" is the retracted legacy band (correct CPL: 0.24% median); sol_note5 Ex3 multiples 8.8×/16.8× | **n.a. / not inherited.** Ex. 18.5 (l.841-848) and Sol. 18.5 (l.124-137) use a generic 250±10 km/s lens and "1% in λ" as a plain arithmetic target. Neither ties it to a 𝓑 signal or to the AGEL anchors. The chapter quotes no dark-energy signal band anywhere | none. Do not add a "~1% signal" sentence in the fix pass |
| S3-25 (FAIL) | Ballard+2026 (private draft) cited for σ = 249.1 ± 2.1 km/s | n.a. (`grep -i ballard\|J0946` gives 0 hits; X10 lint) | none |
| S3-36, S3-37, S3-29, S3-34, S3-38, S3-44 (SUSP) | G4 numbers: pinning 0.825→0.818, residual 10⁻⁶–10⁻⁴ (→ 9e-7–5.6e-4), ~82%, aperture scan +0.65/+0.61/+0.23/−0.27 | n.a. (G4 not ported) | see Feedback 3 for the physics behind the aperture rule |
| S3-35 (SUSP) | σ "pins a combination of (θ_E, γ′) … exactly why it complements the radial image" | reworked. The chapter version (bridge l.751-758) is derived. Eq. ms_aperture sets the (λ, γ′) direction a dispersion fixes, and the second-order invariant ξ is MST-invariant. The closer "Two independent combinations…" is already flagged as prose (P2) | none beyond P2 |
| S3-14 (SUSP) | schematic "σ_los²(R) ∝ GM(<r)/r" mixes projected and 3-D quantities | **already fixed in the port.** Exact σ_r² (Eq. ms_sigr), LOS projection, aperture average and lensing normalisation (Eqs. ms_sigap/ms_F; derivation box l.629-648; critic D5 brute-force) | but see New fix 1 (core Jeans validity) |
| S3-45, S3-46, S3-56, S3-61, S3-65, S3-66 (SUSP) | Horseshoe "5σ that the lensing could not deliver alone", HS10 independence, aphoristic closers | n.a. (stripped) | none |
| July N5-C5 | "Johnson, Fleury & Millon 2025" → Johnson, Collett, Li & Fleury 2025 | n.a. (not cited) | none |
| July N5-S1 | 74.5 → 67.4 is driven by adding SLACS kinematics, not by freeing λ_int alone | already fixed (l.714-719 states both steps) | none |
| July PASS list | "Schneider 2014 (A&A 568 A106)" marked PASS | chapter cites the correct record (568 L2, DOI …201424450) | Feedback 1 |
| July open item | "Schneider & Sluse 2013, 2014 … defensible bundle", left as is | superseded by S3-06 and fixed in the chapter | none |
| SOLUTIONS-07-24 FAIL (resolved `40a8108`) | H0 sign: forward H0 → λH0; 1/λ is the naive-observer reading | consistent. Keybox l.128-130 H0^true = λH0^naive; the annotation at l.150-158 gives the data-side reading; Sol. 18.2(b); X3 vs Ch.13 eq:mst_H0 | none |
| SOLUTIONS-07-24 C1, C2 | FGS 1985 authors; Birrer 74.5/67.4 | consistent (C1, C19, C20) | none |
| sol_note5 Ex3 (σ_e 267.3±11.8 vs 267±12) | anchor rounding | n.a. (anchors not ported) | none |
| TESTS A7 | SPT/mass-sheet direction quarantined in position-only fits | n.a. (project pipeline). Conceptually consistent with §ms_what_sheet | none |
| TESTS G4 | "slope information sits in (3−γ′)ln(R_ap/θ_E), vanishes at R_ap = θ_E" (projected-mass proxy, no JAM) | **chapter and spiral disagree on substance (not a chapter error).** l.691-701 and Sol. 18.7 show the proxy's zero at R_E moves under Jeans to R_E·exp(∂lnF/∂γ′) = 1.649 R_E at (2,2,0). Scratch R1–R3 extend this to the spiral grid: 0.91/1.09/1.32/1.47/1.65 R_E for γ′ = 1.4/1.6/1.8/1.9/2.0 (ν = 2, β_a = 0), and 3.6–6.4 R_E at ν = 2.5 | Feedback 3. Optional chapter enrichment: New fix 2 |
| HANDOFF §5 | Horseshoe "drops below → consistency check with the kinematic channel" retracted twice | n.a. (no Horseshoe content) | none |
| HANDOFF §5, other bullets | WP4b evidence sentence, γ = 1.288, Note 2b Eq. numbers, Wolfram counts, rail census, Ω_m ±0.3%, t₁_crit, T1M flags | n.a. to note5 / Ch.18 | none |
| HANDOFF §6 | "a retraction must reach the code"; "two quantities that coincide in one limit get two names" | applied in spirit. The chapter keeps η (θ_E1/θ_E2) and 𝓑 (distance ratio) apart throughout. The cross-chapter η clash with Ch.13 is already flagged as X5 | none |
| memory `msd-and-kinematics-anchor.md` | "Schneider 2014 … each plane carries its own sheet" | not inherited (see S3-10) | Feedback 2 |
| lit review / memory | ξ ≡ θ_E α″(θ_E)/[1−κ(θ_E)] invariant | **not in the spiral record.** ξ appears nowhere in note5, sol_note5 or the theory tree. Kochanek 2020 is in `MSD_LITERATURE_REVIEW.md:133` (arXiv 1911.05083, DOI 10.1093/mnras/staa344, CrossRef-confirmed above), but only as the "H0 ∝ (1−κ_E)" critique, with no mention of ξ. So ξ was introduced in the port, and its missing attribution is the chapter's own gap | already Flagged item 1 (C18). The spiral lit-review row confirms the paper is in the project's reading list, so adding the bib entry needs no new discovery |
| `Reference_papers/README.md:41-42` | `Schneider2014_multiplane_MST.pdf` labelled "Schneider 2014, A&A 568, A106 (1409.0015)"; `SchneiderSluse2013_SPT.pdf` labelled "2013, A&A 564, A103" | chapter unaffected. Its citations come from CrossRef and arXiv 1406.6152, not these PDFs. pdftotext p.1 confirms the first file is arXiv:1409.0015v1 (= Schneider 2019, A&A 624 A54). The project has **no local copy of 1406.6152** (the real 2014 L2) | Feedback 1 |
| X6 (this report) vs note5:137, sol_note5 Ex4 | "a power-law fit absorbs [a central mass] by steepening γ′", stated unconditionally | inherited from the note. The over-general wording at l.546-549 and l.740 comes from note5:137 / sol_note5:171-172. Ch.17:594 ("Signs, in this configuration") is the port's own qualifier. The spiral record does not test whether the sign holds in every geometry | already Flagged item 4. Not reported as a spiral error (unproven either way) |

### New fixes for the fix pass (not already in Flagged)

1. **Uniform-core Jeans solution holds only for ν > 2 + 2β_a** (l.708, l.743-745; Sol. 18.8 l.171-173; Ex. 18.8 l.871-873).
   The chapter's σ_r² = (4π/3)Gρ_c r²/(ν−2−2β_a) is a particular solution of the Jeans ODE. Repo check k18 verifies the ODE
   only, not the boundary condition at large r. With the physical boundary condition (ρ_*σ_r² → 0 at ∞, uniform sphere of
   radius r_c), the formula is the small-r limit only when ν > 2+2β_a (scratch R5, ν = 2.5).
   - At the chapter's own isothermal tracer (ν = 2, β_a = 0) the formula divides by zero. The exact result is
     σ_r² = (4π/3)Gρ_c r²[ln(r_c/r) + 1/3] (R4).
   - For ν < 2 the formula is negative, while the exact σ_r² ∝ r_c^{2−ν} r^ν > 0 (R6, ν = 1.8).

   The qualitative claims survive: the core's σ_r² still falls inward, and its share still vanishes as r_c → ∞, now with a
   ln r_c / r_c rate at ν = 2.
   Fix:
   - Add "(for ν > 2 + 2β_a; at ν = 2 a logarithm appears)" at l.708.
   - Write "∝ r² (or r² ln(r_c/r) at ν = 2)" at l.744.
   - In Ex. 18.8 and Sol. 18.8, either state ν > 2 + 2β_a or say "∝ r² up to a logarithm".
   - Strengthen k18 (or add k18b) to check the boundary-condition solution at ν = 2 and ν = 2.5.

2. *(Optional, enrichment.)* At l.697-701, quote the γ′ dependence of the decoupling radius at ν = 2, β_a = 0:
   R_ap/R_E = 0.91, 1.09, 1.32, 1.47, 1.65 for γ′ = 1.4, 1.6, 1.8, 1.9, 2.0, and 3.6–6.4 for ν = 2.5 (scratch R3a). This makes
   "model dependent" concrete, and it shows the zero can also fall *inside* R_E for shallow mass profiles. The current text
   only says it moves outward for steeper tracers. That is not wrong, but it is one-sided. Would need a repo check if adopted.

### Feedback to the spiral project (errors its record does not yet know, or only partly knows)

1. **Schneider 2014 is A&A 568, L2, not "A&A 568, A106", and it is not arXiv:1409.0015.**
   - Wrong in four places: `lit_review/MSD_LITERATURE_REVIEW.md:85` and `:149` ("Schneider | A&A 568, A106 | arXiv:1409.0015 · DOI
     10.1051/0004-6361/201424881"), `Reference_papers/README.md:41`, and the PASS list of `theory/FACT_CRITIC_study_notes_2026-07-11.md`
     ("Schneider 2014 (A&A 568 A106)").
   - The packet critic's own S3-06 text repeats "A&A 568, A106".
   - CrossRef: DOI 10.1051/0004-6361/201424881 = Schneider **2019**, A&A **624, A54** ("Generalized multi-plane gravitational lensing…").
     Schneider 2014 = A&A **568, L2**, DOI 10.1051/0004-6361/201424450, "Can one determine cosmological parameters from multi-plane
     strong lens systems?" (arXiv 1406.6152 per this report's C10).
   - The local `Schneider2014_multiplane_MST.pdf` is arXiv:1409.0015v1 (pdftotext p.1). The 2014 L2 paper is not in `Reference_papers/`.
   - Partly known: S3-10 notes that the PDF is 1409.0015 and was published in 2019. But no record entry corrects the "568 A106" label
     or the two lit-review rows that merge two papers into one.
   - Same file: `MSD_LITERATURE_REVIEW.md:54,61` still carry "Schneider & Sluse 2013/2014" for the SPT (cf. S3-06), and
     `Reference_papers/README.md:42` pairs 2013 with 564 A103 (S3-06 already lists this one).

2. **The S3-10 misattribution also lives in memory.** The memory note
   `~/.claude/projects/-Users-rosador-Documents-AGEL-202607-Theoretical-spiral-compound/memory/msd-and-kinematics-anchor.md`, item 1,
   reads "Schneider 2014 multi-plane MST; Teodori 2026 … — each plane carries its own sheet". S3-10's fix targets only note5:67-69.
   The memory line, and `MSD_LITERATURE_REVIEW.md:149` ("a per-plane mass sheet propagates…"), will re-seed the error.
   - What Schneider (2014 L2 Eqs. 6–11; 2019 §4.3) has: one λ, alternating λ/1 between planes.
   - Per-plane independent sheets reabsorbed into the distances: Teodori 2026.
   - Ch.18 l.416-468 has the correct version, and scratch R7 re-checks the near-plane λ² scaling.

3. **G4's "slope information vanishes at R_ap = θ_E" is a property of the projected-mass proxy, not of dynamics.**
   Sources: TESTS row G4, "a falsifiable prediction of the model … −0.27 at R_ap = θ_E"; note5:116-121.
   - In the proxy, ∂ln M_2D/∂γ′ at fixed θ_E is ln(θ_E/R), which is zero at θ_E (scratch R2).
   - For the luminosity-weighted, aperture-averaged Jeans dispersion of a power-law mass with a power-law tracer, the slope-free
     aperture sits at R_E·exp(∂lnF/∂γ′) (Ch.18 Eqs. ms_sigap/ms_F/ms_aperture; repo checks k15–k17; scratch R1, R3a/b).
   - At ν = 2, β_a = 0 that is 0.91, 1.09, 1.32, 1.47, 1.65 R_E for γ′ = 1.4, 1.6, 1.8, 1.9, 2.0. At ν = 2.5 it is 3.6–6.4 R_E. Nowhere
     on the grid is it exactly θ_E.
   - So the measured backfire location (−0.27 at θ_E) is a proxy artefact. Under real dynamics the counter-productive aperture moves,
     mostly outward. The design rule's direction ("measure well inside θ_E") survives for most of the grid, though only marginally at
     γ′ = 1.4, ν = 2.
   - The G4 row discloses "projected-mass proxy, NO JAM" but presents the zero location as a prediction. It should be caveated as
     proxy-specific. The flagged S3-34/S3-35 cover scope, not this.

4. *(Info, not an error.)* The MST invariant ξ = θ_E α″(θ_E)/[1−κ(θ_E)], equal to 2(γ′−2) for a power law, is Kochanek (2020,
   MNRAS 493, 1725; arXiv 1911.05083). The spiral lit review already lists that paper (:133) but summarises it only as H0 ∝ (1−κ_E).
   If ξ is ever used in the theory notes, attribute it there.

## Resolution — fixes applied 2026-10-14

| id | Fix | Backing |
|----|-----|---------|
| C18 (Flagged 1) | ξ attributed: "An MST-invariant way to say this, due to `\citet{kochanek_2020}`" in the derivation box (§ms_local), and "second-order invariant ξ of `\citet{kochanek_2020}`" in the closing bridge. `.wl` Sources header and the l6 comment name Kochanek 2020 | bib key `kochanek_2020` (merged from annotated-edition); repo checks l6–l7 (unchanged, PASS) |
| N16 (Flagged 2) | Eq. ms_F validity range now "1<ν<3, γ′>1, 3<ν+γ′<5 and ν+γ′−2−2β_a>0" with the reason (projections of ρ_* and ρ, aperture integral, Jeans integral at large r / σ_r²>0) | new check **k10d**: convergence condition Re q>1 read off `Integrate`; 0 of the grid points inside the new range violate a convergence condition; the old range admits (2.5, 0.8, 0) which fails; (2, 1.5, 0.9) gives F<0 and is now excluded |
| X5 (Flagged 3) | After Eq. ms_eta: one sentence fixing the convention (plane 1 = nearer source, so 𝓑<1 and η<1; η is always θE1/θE2 and 𝓑 the distance ratio; papers with the opposite numbering quote 𝓑⁻¹). The Ch.13 bridge is being fixed by another agent | convention sentence only; s11 unchanged |
| X6 (Flagged 4) | Bridge "slope drag": "in the configurations it studies … (the size of the drag depends on the image geometry, and its sign is established only for those configurations)"; λ_eff "> 1 when the fit steepens". §ms_core_bh and Sol. 18.8: "in the configurations of Chapter 21" | Ch.17 tex l.594 ("Signs, in this configuration") and l.598 (coefficient −4.26 → −17.8) |
| X7 (Flagged 5) | Bridge "Distances and critical densities": 𝓑 is the ratio of the two lensing distance ratios 𝒟 ≡ D_ds/(D_d D_s) of Eq. distance_ratio; the common D_d cancels, giving 𝓑 = (D_ds1/D_s1)/(D_ds2/D_s2) | Eq. ms_brat (same expression); Ch.03 eq:distance_ratio |
| P1 (Flagged 6) | "it is the most common sign error in this subject" → "the direction is easy to get backwards" | prose |
| P2 (Flagged 7, partial) | l.720-721 closer replaced with the critic's plain rewrite ("Freeing λ_int widens the H0 interval to about ±6 km s⁻¹ Mpc⁻¹, and that width is set by the kinematics."). Other aphoristic closers and "Three …" lead-ins left for the author | Birrer 2020 74.5 +5.6/−6.1 (C19) |
| Rec. new fix 1 | Uniform-core Jeans: chapter now says the r² law σ_r² ≃ (4π/3)Gρ_c r²/(ν−2−2β_a) is the r≪r_c limit of the solution with ρ_*σ_r²→0 at infinity *for ν>2+2β_a*; at ν=2, β_a=0 the exact result σ_r² = (4π/3)Gρ_c r²[ln(r_c/r)+1/3] is stated; the core fraction gets a ln(r_c/R_ap) at ν=2 and still vanishes. §ms_core_bh "∝ r² (times ln(r_c/r) at ν=2)". Ex. 18.8 restricted to ν>2+2β_a (r² up to a log at ν=2). Sol. 18.8 now gives the full boundary-condition solution (particular + homogeneous r_c^{2−ν+2β_a} r^{ν−2β_a} term), its three regimes, and notes the point-mass solution is exact for ν+1−2β_a>0 | new checks **k18b** (general BC solution = particular + homogeneous term and solves Jeans; ν=2.5 ratio→1 as r→0; ν=2 log form exactly; old formula's denominator vanishes at ν=2; at ν=1.8 old formula <0, exact >0); **k19** extended (ν=2 log solution's share →0 as r_c→∞); problems **8d** (closed form + ν=2 log), **8e** (ν=2.5 limit; ν=1.8 sign; coefficient (50/7)πGρ_c r_c^{1/5} of r^{9/5}) |
| Rec. new fix 2 | Decoupling radius quoted: 0.91, 1.09, 1.32, 1.47, 1.65 R_E for γ′ = 1.4, 1.6, 1.8, 1.9, 2.0 (ν=2, isotropic), i.e. inside R_E for shallow profiles; 3.6–6.4 R_E at ν=2.5 over the same γ′ range. The previous one-sided "for steeper tracers … larger still" sentence was replaced | new check **k17b** (exp(∂lnF/∂γ′) from the closed form; ν=2.5 values 5.11, 3.61, 4.01, 4.81, 6.45 — not monotonic in γ′, so the text quotes a range) |

**Verification after edits.**
- Before: `msd_multiplane.wl` → `SUMMARY: 69 PASS, 0 FAIL  (of 69 checks)`; `problems_18.wl` → `SUMMARY: 40 PASS, 0 FAIL  (of 40 checks)`.
- After: `bash Mathematica/run_wl.sh Mathematica/18_MSD_Kinematics/msd_multiplane.wl` → `SUMMARY: 72 PASS, 0 FAIL  (of 72 checks)`;
  `bash Mathematica/run_wl.sh Solutions/18_MSD_Kinematics/problems_18.wl` → `SUMMARY: 42 PASS, 0 FAIL  (of 42 checks)`.
- `cd Notes && ANNOT_REQUIRED=1 bash build.sh` → "all assertions passed"; Student 360 pp, Instructor 444 pp, Annotated 567 pp
  (fingerprints: student text-md5 47dbd49af62d56b6c0bacc25fa754305, instructor e9e53fae893e81bb76f1b505ff11b539,
  annotated 2f5e49ff3bc9d6ba899867fefcd06e14, sentinels 0/0/508). The figure PDF re-exported by the script was reverted (content unchanged).

**Left open.**
- X5 on the Chapter 13 side (bridge at `09_Galaxy_Lensing_Applications.tex:644-666` uses η for the distance ratio and plane 1 = far): assigned to another agent.
- P2–P4 remaining prose tells (closers at l.394-395, l.505-506, l.533, l.758; "Three …" lead-ins at l.68, l.353, l.454; Solutions antithesis l.161-162): flag-only, for the author.

### Session-3 closeout (2026-10-14, orchestrator)
- X5 closed by the 08–09 fix pass: the Chapter 13 bridge (`09_Galaxy_Lensing_Applications.tex:644-666`) now uses 𝓑 for the distance ratio, η for θE1/θE2, and plane 1 = near.