# fact-critic report — Notes/17_Central_Mass_Bias/ (Chapter 17 = PDF chapter 21)

> Date: 2026-10-14 · Critic: independent pass (did not author the chapter) · Lenses: Citation, Number, Consistency, Prose, Provenance, Derivation
> Scope: `17_Central_Mass_Bias.tex`, `17_Solutions.tex`, `Mathematica/17_Central_Mass_Bias/central_mass_bias.wl`,
> `Solutions/17_Central_Mass_Bias/problems_17.wl`, `Figures/17_Central_Mass_Bias/`. Source (read-only):
> `AGEL/202607_Theoretical_spiral_compound/theory/note3_smbh_bias.tex`, `theory/solutions/sol_note3_smbh_bias.tex`,
> `mathematica/01_DSPL_SMBH_bias/derivation.wl` (+ its `annihilation_boundary.csv`), project `CLAUDE.md` backbone block.
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (api.crossref.org reachable; Semantic Scholar
> abstracts fetched for support checks), md-reflist ✗ (n/a), values-file ✗ (none), repo-grep ✓, doc-internal ✓,
> wolframscript ✓ (repo scripts + critic's scratch script, run via `Mathematica/run_wl.sh`), overlay: AGEL (Zotero not needed —
> both cited works confirmed via CrossRef + abstract).
> A claim with no active adapter is capped at ⚠ SUSPECT.

**Verdict counts: 49 rows — ✅ PASS 41 · ⚠ SUSPECT 7 · ❌ FAIL 1. Auto-fixes applied: 0.**

Repo scripts (run 2026-10-14, this worktree; figure PDFs they re-export were restored with `git checkout` so the tree is unchanged):
- `central_mass_bias.wl` → `SUMMARY: 66 PASS, 0 FAIL  (of 66 checks)` / `ALL CHECKS PASS`
- `problems_17.wl` → `SUMMARY: 37 PASS, 0 FAIL  (of 37 checks)` / `ALL CHECKS PASS`

Critic's independent script (shares no code with the repo scripts):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_17/critic17_derivations.wl`
→ `SUMMARY: 44 PASS, 0 FAIL  (of 44 checks)` (log: `critic.log` in the same directory).

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "can be used to constrain the dark-energy equation of state \citep{collett_2012}" (l.24) | ✅ PASS | bib:collett_2012 / CrossRef DOI 10.1111/j.1365-2966.2012.21424.x (title, 5 authors, MNRAS 424(4) 2864–2875 match); abstract: ratio of Einstein radii "independent of the Hubble parameter", constrains w | none |
| C2 | Citation | "The influence of central black holes on the central images of galaxy lenses was studied by \citet{mao_witt_koopmans_2001}" (l.776) | ✅ PASS | bib:mao_witt_koopmans_2001 / CrossRef DOI 10.1046/j.1365-8711.2001.04143.x (MNRAS 323(2) 301–307); abstract: BH above a critical mass suppresses central images for all sources | none |
| C3 | Citation | header comments "Narayan & Bartelmann Sect. 2.1.2", "Congdon & Keeton eq. 4.54" (l.5–6, comment only) | ⚠ SUSPECT | not checked against `Reference_Texts/` (comment, not rendered; eq. 4.54 attribution is inherited from Ch.5 `eq:eigenvalues`) | none needed for the PDF; verify if the comment is ever promoted to text |
| N1 | Number | B = η^(γ'−1); θ_E2 = θ_E1 B^(−1/(γ'−1)); η<1 for B<1 (eq. cb_B_eta) | ✅ PASS | critic D3b (from α_i = (D_ds/D_s)_i α̂); repo A2b–A2d | none |
| N2 | Number | θ_E,tot/θ_E = 1 + m/(γ'−1) + (γ'−4)m²/(2(γ'−1)²) (eq. cb_thetatot_series) | ✅ PASS | critic D2a (series solved to O(m³); c3 = (2γ'²−19γ'+42)/(6(γ'−1)³) for reference); repo B3a | none |
| N3 | Number | exact 1.010984 vs first-order 1.011111 (γ'=1.9, m=0.01) | ✅ PASS | critic D2b; repo B3b | none |
| N4 | Number | m₂ = m₁ B^((3−γ')/(γ'−1)) < m₁; 0.594 (γ'=1.6), 0.761 (γ'=1.9) at B=0.8 | ✅ PASS | critic D3a (first principles), D3c; repo A3a–A3c | none |
| N5 | Number | θ_r = θ_E(2−γ')^(1/(γ'−1)); 0.077 θ_E (1.9), 0.217 θ_E (1.6) | ✅ PASS | critic D3d; repo A4a–A4c | none |
| N6 | Number | fixed-slope BoE δη/η ≈ 2.65e-3, δB/B ≈ 2.39e-3; exact total-radius 2.58e-3 ("accurate to 3%") | ✅ PASS | critic D3e, D3f (2.5778e-3; BoE/exact = 1.029); repo B4c–B4d | none |
| N7 | Number | fixed-slope fit vs BoE: 0.3% at 0.02 θ_E, ×1.75 at 0.3 θ_E | ✅ PASS | critic D4i (own FindRoot fit to tangential pairs, γ'=1.6, m₁=1e-3): ratios 0.99723 (b=0.02), 1.0359 (0.1), 1.1908 (0.2), 1.7463 (0.3) — monotone; repo E9a–E9b | none |
| N8 | Number | linear coefficient −4.26 = ratio +1.53 + slope −5.79; dγ'/dm₁ = +15.6 | ✅ PASS | critic D4a (own synthetic images + own fit, forward FD at m₁=1e-9): −4.25887, +1.53433, −5.79319, 15.57703; repo E11 | none |
| N9 | Number | Table cb_worked: exact −0.043/−0.130/−0.449/−1.59 %; linear −0.043/−0.128/−0.426/−1.28 %; δγ' 0.0016/0.0048/0.0166/0.0600 | ✅ PASS | critic D4b–D4d (FindRoot and FindMinimum routes identical; χ² ≤ 7e-63) | none |
| N10 | Number | "agree to 0.5%" at 1e-4; residual ∝ m₁² ("×9"); FD vs J⁻¹s "better than 1 part in 10⁵" | ✅ PASS | critic D4f (0.49%); diff ratio 2.098e-6→1.935e-5 = ×9.2 (critic table); repo E4 (15.57704 vs 15.57703) | none |
| N11 | Number | b₂ = 0.2 θ_E2 → coefficient −17.8 | ✅ PASS | critic D4g (−17.7711); repo E8 | none |
| N12 | Number | BoE +0.041% at m₁=1e-3, "order of magnitude smaller" than −0.449% | ✅ PASS | critic D4h; ratio 11 | none |
| N13 | Number | Fig. bias_vs_m: b₂ = 0.293/0.481 θ_E2, coefficients −4.66/−1.77 | ✅ PASS | critic D4j (0.29316, 0.48149; −4.6615, −1.7677) | none |
| N14 | Number | Fig. bias_vs_m caption: points run "to the largest mass at which this source still has a radial image. Near that limit the exact bias exceeds the linear one by more than 40%" | ⚠ SUSPECT | critic D4j–D4l: true radial-image limits are 0.379 m₁,crit (γ'=1.6) and 0.293 m₁,crit (γ'=1.8); plotted points stop at the grid values 0.35 and 0.25. At the plotted last points exact/linear = 1.50 (γ'=1.6) and **1.24 (γ'=1.8)**; at the true limits 1.88 and 1.51. Repo FIG1c tests γ'=1.6 only | see Flagged F2 |
| N15 | Number | closed form θ* = [(2−γ')(3−γ')/2]^(1/(γ'−1)), m_crit = ½(2−γ')(γ'−1)θ*^(3−γ') (eqs. cb_thetastar, cb_mcrit) | ✅ PASS | critic D1a–D1b (own elimination, FullSimplify), D1d (y'' has a single positive zero ⇒ double root = global min of λ_r), D1e (independent FindMinimum-of-λ_r + bisection on u, rel. diff < 1e-10), D1l (source `annihilation_boundary.csv` m2_crit, max rel. diff 2.2e-15); repo D3a–D5 | none |
| N16 | Number | Table cb_mcrit (θ*, m_crit, m₁,crit at B=0.8 for γ'=1.4…1.9) | ✅ PASS | critic D1f–D1h | none |
| N17 | Number | γ'=3/2: θ* = 9/64, m_crit = 27/4096 | ✅ PASS | critic D1i (exact rationals); also Ch.15 l.603 | none |
| N18 | Number | max m_crit = 0.0066 at γ' ≈ 1.48; → 0 at both ends | ✅ PASS | critic D1j (0.0065996 at γ'=1.48463), D1k | none |
| N19 | Number | θ* = θ_r[(3−γ')/2]^(1/(γ'−1)) < θ_r | ✅ PASS | algebra on N5×N15 (identity is a factorisation); repo D3c | none |
| N20 | Number | illustrative lens (γ'=1.9, m₁=0.01, B=0.8) "has no radial image"; m₁,crit = 0.0017 | ✅ PASS | critic D1m: m₂ = 0.00761 > m_crit(1.9) = 0.00130; min λ_r on far plane = +0.765 > 0 (near plane also > 0) | none |
| N21 | Number | B = 0.674, S_w = −0.033, δw = +0.15 for −0.5%; "|0.3 S_w| ≈ 1%" | ✅ PASS | critic D5a–D5b (own NIntegrate; B also from explicit D_A's, agree to 1e-12): B = 0.674156, S_w = −0.0330114, δw = 0.1515 | none |
| N22 | Number | ex.17.5(c): δη/η 3.38e-3 / 2.03e-3 (1.6), 1.33e-3 / 1.19e-3 (1.9); δw = −0.036 | ✅ PASS | critic D5c; arithmetic m₁=0.005 × (1−B^p)/(γ'−1); repo 5e | none |
| N23 | Number | ex.17.7: m_eff = (3−γ')θ_b^(3−γ')[1/(3−γ_in) − 1/(3−γ')] = 0.0177 | ✅ PASS | critic D6c (symbolic Integrate), D6d (0.017652) | none |
| N24 | Number | ex.17.1: +0.300%, −0.707%, net −0.407%, ratio 2.357, η = e^(−0.1) = 0.905 | ✅ PASS | repo problems_17 1a–1f (run); arithmetic | none |
| N25 | Number | ex.17.4: N = 16; ex.17.6(c): 1.009902 | ✅ PASS | repo 4c; critic D2c | none |
| N26 | Number | m₁,crit(1.6, B=0.8) = 0.01036, ratio 0.48 (ex.17.5b); θ_• = 0.071 θ_E | ✅ PASS | repo 2b/5b; critic D1h | none |
| X1 | Consistency | m_crit, 27/4096, 0.0066 in Ch.17 vs Ch.15 (`15_PowerLaw_PointMass.tex` l.603, l.626) | ✅ PASS | internal: values agree | optional: cite Ch.15's eq:pl_mcrit where Ch.17 re-derives it |
| X2 | Consistency | −4.26 / +1.53 / −5.79 / 15.6 in Table caption, enumerate, ex.17.5(d) | ✅ PASS | internal: 3 occurrences agree | none |
| X3 | Consistency | S_w = −0.033 (chapter) vs −0.0330 (solutions); δw = +0.15 / +0.151 | ✅ PASS | internal (printed precision) | none |
| X4 | Consistency | m₁,crit(1.9) = 0.0017 (table, bullets, ex.17.5b, ex.17.7b) | ✅ PASS | internal: 4 occurrences agree | none |
| X5 | Consistency | every quoted `[Verified: checks …]` / `[Attested: checks …]` id exists in the run logs | ✅ PASS | repo_main.log (A1…G2, FIG1–FIG2), repo_sol.log (1a…7d) | none |
| X6 | Consistency | all 12 `Chapter~\ref{ch:…}` targets | ✅ PASS | label→file grep + PDF TOC (`pdftotext -layout`): axisymmetric_models→ch.11, cosmological_distances→7, light_deflection→6, lens_equation→8, magnification→9, galaxy_lensing→13, multiplane_dspl→18, power_law_point_mass→19, odd_images→20, msd_kinematics→22, cosmological_sensitivity→24, perturbative_estimators→25; each target's content matches the claim (spot-greps) | none |
| X7 | Consistency | external eq./sec./ex. refs (lens_eq_1d, alpha_point, alpha_mean_kappa, eigenvalues, mu_eigenvalues, DA_flat, Dds_flat, mst_kappa, sec:msd, ex:power_law_profile) | ✅ PASS | each label resolved and content read (e.g. eq:eigenvalues λ± = 1−κ±|γ|, so λ_r = λ₊ for κ̄>κ) | none |
| X8 | Consistency | "Each factor D_ds/D_s … is the lensing efficiency of §sec:lensing_efficiency" (l.131, l.160) | ⚠ SUSPECT | `03_Cosmological_Distances.tex:1316` defines the lensing efficiency as 𝓔 = D_d D_ds/D_s, not D_ds/D_s (they are proportional only at fixed z_d, which holds here) | see F5 |
| X9 | Consistency | chapter appears in the built PDF | ⚠ SUSPECT | `Output/Learning_to_Lens_Annotated.pdf` (Oct 14 08:55) p.309 = "Chapter 21 … [Chapter in preparation.]" stub; the same for the student PDF (p.254) | rebuild after merge (see F6) |
| P1 | Prose | "The ratio is biased by the asymmetry between the planes, not by the black hole as such." (l.311; echoed sol. l.223–225) | ⚠ SUSPECT (antithesis) | read | the contrast is physical; keep once, cut the echo in 17.7(c) |
| P2 | Prose | "The method carries over unchanged; the coefficients do not." (l.640) / "it cannot be averaged away." (l.882) / "On the far plane the black hole falls behind." (l.339) | ⚠ SUSPECT (aphoristic closers) | read | end on the fact before each, e.g. drop the last sentence of l.339 |
| P3 | Prose | "the effect cuts both ways" + remark title "Two edges of the same effect" (l.775–778) | ✅ PASS (borderline) | read | optional: "has two consequences" |
| D1 | Derivation | annihilation boundary closed form (eqs. cb_double_root–cb_m1crit) | ✅ PASS | critic D1a–D1m | none |
| D2 | Derivation | θ_E,tot expansion (eq. cb_thetatot_series) | ✅ PASS | critic D2a–D2c | none |
| D3 | Derivation | plane scaling m₂ = m₁B^((3−γ')/(γ'−1)) (eq. cb_m2_m1) and B = η^(γ'−1) | ✅ PASS | critic D3a–D3f | none |
| D4 | Derivation | linear response vs exact fit (eq. cb_linear_response, Table cb_worked, fixed-slope accuracy) | ✅ PASS | critic D4a–D4j | none |
| D5 | Derivation | δw = (δB/B)/S_w with flat-wCDM B (eq. cb_dw) | ✅ PASS | critic D5a–D5c | none |
| D6 | Derivation | "any central excess acts like a point mass outside its radius" (eq. cb_meff) | ✅ PASS for axisymmetric Σ / ⚠ wording | critic D6a: direct 2-D integral of a uniform ring gives exterior deflection = M/(πθ) and interior 0 to 1e-24 (2-D shell theorem, exact for axisymmetric Σ); D6b: an off-centre lump differs from a central point mass by 11% at θ=1 | see F3 |
| D7 | Derivation | Solutions 17.2(c) reason for m_crit → 0 as γ'→1 | ❌ FAIL | critic D7a: lim θ_r/θ_E = e⁻¹ = 0.368 and lim θ*/θ_E = e^(−3/2) = 0.223 as γ'→1 — the radial curve does **not** move to very small radii; D7b: min λ_r on [θ_r/10, θ_r] is ≈ −0.02 at γ'=1.01 vs < −1 at γ'=1.5 (only marginally negative) | see F1 |
| D8 | Derivation | ex.17.7(b)/(c): m_eff = 0.0177 "more than ten times m₁,crit … large enough to remove the radial image" | ⚠ SUSPECT | critic D6e: conclusion is true (λ_r > 0 everywhere for the cusp lens), but θ_r(1.9) = 0.077 and θ* = 0.040 lie *inside* θ_b = 0.1, where the point-mass equivalence does not apply; the radial curve vanishes because γ_in = 2.1 > 2 inside θ_b | see F4 |

(Remaining sentences checked and passing without separate rows: m = M_•/M_PL(<θ_E) via eq. alpha_point (l.190–194); ∂y_i/∂m₁ = −1/θ and −1/(Bθ) (l.514–515); y'(θ_k) = λ_r (l.521); "exactly determined" five-parameter count (l.537–541); radial image closer to centre for smaller b₂ (monotone y on (−θ_r,0)); m₁,crit decreasing in γ' over 1.4–1.9 (table) supporting "favours shallower inner slopes"; SIS+point mass λ_r = 1+θ_•²/θ² > 0 (17.6b); 17.3 limits B→1 and γ'→3.)

## Applied (auto-fixes)

None. No single-source number typo and no number-vs-number inconsistency was found in the chapter's files.

## Flagged — your hand required

- **F1 (❌ D7) — `17_Solutions.tex` l.84–85, Exercise 17.2(c).** "…and as γ'→1 because the radial critical curve moves to very small radii, where even a tiny point mass dominates." This is wrong: θ_r → e⁻¹θ_E ≈ 0.37θ_E and θ* → e^(−3/2)θ_E ≈ 0.22θ_E as γ'→1 (critic D7a). The real reason (stated correctly in Ch.15's annotation, `15_PowerLaw_PointMass.tex` l.615–622): as γ'→1 the power law tends to a uniform sheet with κ→1, so λ_r inside θ_r is only marginally negative (min ≈ −0.02 on [θ_r/10, θ_r] at γ'=1.01, D7b) and a small push removes it. Proposed fix: replace the clause with "and as γ'→1 because the profile approaches a uniform sheet, λ_r is then only marginally negative inside θ_r, and a small positive term lifts it above zero." (Physics prose, so not auto-applied.)
- **F2 (⚠ N14) — Fig. `fig:cb_bias_vs_m` caption (l.624–627).** (a) "to the largest mass at which this source still has a radial image": the plotted points stop at the grid values 0.35 m₁,crit (γ'=1.6) and 0.25 m₁,crit (γ'=1.8); the true limits are 0.379 and 0.293 m₁,crit (critic D4l). (b) "Near that limit the exact bias exceeds the linear one by more than 40%" holds for the γ'=1.6 points (×1.50 at the last point) but not for γ'=1.8 as plotted (×1.24). Repo check FIG1c tests γ'=1.6 only. Proposed wording: "The points run from 2% of m₁,crit to just below the mass at which this source loses its radial image (0.38 and 0.29 m₁,crit). At the last γ'=1.6 point the exact bias exceeds the linear one by 50%." Or add a γ'=1.8 point nearer 0.29 m₁,crit, then re-export the figure.
- **F3 (⚠ D6) — l.811–812.** "Seen from outside its own radius, any central excess looks exactly like a point mass." This is exact only for an **axisymmetric** excess (2-D enclosed-mass theorem, critic D6a). A non-axisymmetric excess also adds multipoles (D6b). The chapter is axisymmetric throughout, so the physics is fine; the word "any" overreaches. Proposed: "any axisymmetric central excess". On the author's question 7: yes, for axisymmetric Σ the 2-D statement is exactly true, since α(θ) = (2/θ)∫₀^θ κθ′dθ′ depends only on the enclosed mass, so mass outside θ contributes nothing and mass inside acts like a point mass.
- **F4 (⚠ D8) — `17_Solutions.tex` l.216–223, Exercise 17.7(b)–(c).** Comparing m_eff = 0.0177 with m₁,crit = 0.0017 implicitly applies the exterior point-mass equivalence where the radial curve lives. But θ_r(1.9) = 0.077 and θ* = 0.040 both lie inside θ_b = 0.1. The conclusion holds (the cusp lens has λ_r > 0 everywhere, D6e), but the reason is that γ_in = 2.1 > 2 inside θ_b has no radial curve. Also, m_eff is in units of "θ_E = 1" on an unspecified plane, while m₁,crit is a near-plane fraction. Proposed: either choose θ_b < θ* (e.g. θ_b = 0.02) so the comparison is valid, or reword (c) so the radial-image loss is attributed to the γ_in > 2 inner slope.
- **F5 (⚠ X8) — l.131 and l.160.** "the lensing efficiency D_ds/D_s (§sec:lensing_efficiency)". That section defines 𝓔 = D_d D_ds/D_s. Proposed: "the distance factor D_ds/D_s, which at fixed z_d is proportional to the lensing efficiency of §…".
- **F6 (⚠ X9) — build state.** In this worktree, both Output PDFs carry only the Part V stub ("[Chapter in preparation.]") for PDF ch.21, so the chapter text has never been rendered here. The chapter-number checks above used TOC titles plus label→file mapping. Rebuild (`cd Notes && bash build.sh`) after merging and confirm the page count. The commit `0df457a` text says "Chapter 17 (PDF ch. 21)", which matches the TOC.
- **F7 (⚠ C3) — header comment citations** (N&B Sect. 2.1.2, C&K eq. 4.54) were not checked against `Reference_Texts/`. They are comment-only and inherited from Ch.5/7. Low priority.
- **Project-leakage lint: clean.** `grep -Ei 'tier|scripts/|results/|lenstronomy|autolens|J0946|AGEL|Carousel|this project|go/no-go|median|0.87|0.24%|15/15|Nightingale|grid|Note [0-9]|theta_e_defs|bh_detectable|0.86|0.82|-0.0157|spiral'` over all four chapter files returns only `gGrid`/`grid[tE_]`, numerical sampling-grid variable names in `central_mass_bias.wl` (l.219–271), which are not leakage. The source's B = 0.82 fiducial, median 0.86%, S_w = −0.0157, Nightingale+2023, the go/no-go language and the tier names are all absent.

## Prose (LLM tells) — flag-only

- Chapter: 0 em-dashes in prose (the 2 `---` are list separators in the companion-files block). 0 hollow intensifiers. 0 "rather than". Sentence-length CV = 0.64 over 130 sentences, which is bursty, not uniform. Rule-of-three: "A nuclear star cluster, a steepened stellar cusp and a black hole" (l.825) is a real list, so it is not flagged. Worst offenders: three aphoristic paragraph closers (P2), one physical antithesis repeated in the Solutions (P1), the colon reveal "The question is:" (l.33), and "What makes the black hole dangerous is a free slope constrained by a radial image." (l.609–610, a closer that does restate the finding). Solutions: "A compound lens with well-separated Einstein radii is exactly the case where the slope channel matters most." (l.48–49, pointer phrase; proposed: "The slope channel therefore matters most when the Einstein radii are well separated.")
- Overall the chapter reads clean and technical. The tells are light and sit at paragraph ends.

## Provenance (machine-drafted text) — flag-only

Baseline: the source note (`note3_smbh_bias.tex`), itself produced in model sessions per that project's CLAUDE.md, so there is no author-written baseline. Chapter commit `0df457a` is co-authored by Claude Opus 5.5. Every sentence of `17_Central_Mass_Bias.tex` and `17_Solutions.tex` therefore classifies as machine-introduced (100% of words), which is ❌ by the lens's 10% rule. The action is the author's call: rewrite in your own words before release where it matters (abstract-level prose: intro l.17–35, keyboxes, Summary). No sentence-level table is given because the share is uniform.

## Derivation checks

Script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_17/critic17_derivations.wl`
Run: `bash Mathematica/run_wl.sh <script>` → **`SUMMARY: 44 PASS, 0 FAIL  (of 44 checks)`** (PASS lines testing claims that turn out false, D7a and D6e, are recorded as FAIL/SUSPECT verdicts above).

| # | equation | independent route | result |
|---|----------|-------------------|--------|
| D1 | θ* and m_crit closed form (author flag 1) | Own `Solve` of y''=0 for u; substitution gives y' = 1 − (2−γ')(3−γ')/2 · θ^(1−γ'); FullSimplify that both y' and y'' vanish; proof that t³y'' is monotone, so y' has one stationary point (the double root is the global min); numeric route = FindMinimum of λ_r over log θ plus 70-step bisection on u; compared with the source `annihilation_boundary.csv` (FindRoot at WP 20) | PASS. Closed form = bisection (rel. < 1e-10) = source CSV (2.2e-15). Table values, 9/64 and 27/4096, and the max 0.0065996 at γ' = 1.48463 all reproduce. |
| D2 | θ_E,tot series (flag 2) | Ansatz 1 + c₁m + c₂m² + c₃m³ solved order by order | PASS. c₁ = 1/(γ'−1), c₂ = (γ'−4)/(2(γ'−1)²). Exact root 1.0109844. |
| D3 | m₂ = m₁B^((3−γ')/(γ'−1)) (flag 3) | From α_i = f_i × (source-independent physical deflection), with B = f₁/f₂ | PASS. |
| D4 | worked free-slope example (flag 4) | Own bracketed-bisection image finder (outer, counter, radial images located via the two zeros of λ_r), own 3-equation PL fit (FindRoot) plus the chapter's χ² via FindMinimum, forward FD at m₁ = 1e-9 | PASS. Slope −5.793 m₁, ratio +1.534 m₁, net −4.259 m₁; b₂ = 0.2 gives −17.771. Fixed-slope fit/BoE: 0.997 at 0.02 and 1.746 at 0.3. Caption issue F2 found here. |
| D5 | S_w (flag 6) | Own NIntegrate of χ(z), centred FD in w; B cross-checked from explicit D_A's | PASS. B = 0.674156, S_w = −0.0330114. |
| D6 | central excess = point mass (flag 7) | Direct 2-D Green's-function integral over a ring; symbolic m_eff | PASS for axisymmetric Σ (exact). Off-centre counter-example shows the wording caveat (F3). |
| D7 | Sol. 17.2(c) γ'→1 limit | Symbolic limits of θ_r and θ* | FAIL of the Solutions' explanation (F1). |

Author flag 5 (illustrative lens has no radial image): confirmed, critic D1m (min λ_r = +0.765 on the far plane, and also > 0 on the near plane).

## Source-note errors — CONFIRMED / NOT confirmed

**CONFIRMED (source is wrong; the chapter fixes it correctly):**
1. `sol_note3_smbh_bias.tex` l.80–88 (Ex. 2): "distinct fractional powers of u … preclude a closed form; it is solved numerically". This is false. On y''=0 both u-terms of y' scale as u^((1−γ')/(3−γ')) (critic D1c), so y'(θ*) = 0 is linear in that power and gives the closed form of eqs. cb_thetastar/cb_mcrit. The exponent the source quotes, "u^(−(1−γ')/(3−γ')−1)", is itself wrong.
2. `note3_smbh_bias.tex` l.133–134: "gives one transcendental equation for u_crit". Same error: the equation is algebraic and solvable in closed form. The source's *numbers* are right (CSV agrees with the closed form to 2e-15).

**NOT confirmed as errors (source agrees with the chapter, or the difference is legitimate):**
- Source m₁,crit at B = 0.82 (0.014, 0.0098, 0.0017) equals closed-form m_crit × 0.82^((γ'−3)/(γ'−1)) (CSV column m1_crit: 0.014084, 0.009777, 0.0016556). The chapter's B = 0.8 values differ only through B.
- Source S_w = −0.0157 (1/S_w ≈ −64) and the chapter's −0.033 use different redshift configurations. The chapter's value is verified for its stated (0.5, 1, 2).
- The source attribution of the central-image suppression mechanism to Mao, Witt & Koopmans (2001) is supported by the abstract.
- The two-channel signs and slope dominance in the source (δB/B ≈ −1.1% at m ≈ 3e-3, γ' ≈ 1.6) are consistent in kind with the chapter's −1.59% at m₁ = 3e-3. The configurations differ, so this is not a like-for-like check.

## Reconciliation with the spiral project's record (2026-10-14)

> Reviewer: independent reconciliation pass (RECONCILE.md). Read: digests `note3_4_6.md` (note3 rows), `note3b.md`
> (context only; stripped content), `note8_solutions.md` (it contains **no** `sol_note3` rows, only sol_note10/note8 rows),
> `note1_1b_2.md` rows that cite note3 (S6-023, S6-024); spiral `TESTS_AND_DIAGNOSTICS.md` rows A2, A4, A5, A9, B6, C11b, D2, H0, H3
> and their §2 entries; `NOTES_mcrit_label_defect_2026-08-03.md`; spiral `CLAUDE.md` "θ_E convention", "Backbone identities" and
> the (iv) A3 block; `HANDOFF_arc_2026-09-21.md` §5–6; current `theory/note3_smbh_bias.tex`, `theory/solutions/sol_note3_smbh_bias.tex`,
> `mathematica/01_DSPL_SMBH_bias/{derivation.wl,annihilation_boundary.csv}`, `scripts/tier1_axisym.py`.
>
> Re-verification script (scratch, shares no code with the repo scripts):
> `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/recon_17/recon17.wl`
> run as `bash Mathematica/run_wl.sh <script>` → **`SUMMARY: 20 PASS, 0 FAIL  (of 20 checks)`** (log `recon17.log`, same directory).

### Does the spiral record already have the closed form of the annihilation boundary?

**No.** `grep -i 'closed form|transcend|u_crit|m_crit'` over `theory/*.tex`, `theory/solutions/*.tex`, `TESTS_AND_DIAGNOSTICS.md`,
`NOTES_*.md`, `HANDOFF_*.md` finds only the *θ\** half in closed form. `note3_smbh_bias.tex:133` still says "one transcendental
equation for u_crit". `sol_note3_smbh_bias.tex:80–88` still says "distinct fractional powers of u … preclude a closed form; it is
solved numerically". `derivation.wl:22–23` solves it with `FindRoot`. TESTS §2 A4 (l.213–214) reads "closed θ_*^(3−γ)=… and
m_crit(γ)", but only θ\* is in closed form there. m_crit comes from FindRoot. The spiral **numbers** are right: the chapter's
closed form reproduces the CSV `m2_crit` to 2.2e−15 and `theta_star` to 7e−16 (R1a, R1c), and `y'(θ*(u_crit)) = 0` holds
exactly at seven rational slopes (R1f). Both u-terms carry the single power u^((1−γ′)/(3−γ′)) (R1d). The exponent the source
solution quotes, u^(−(1−γ′)/(3−γ′)−1), is itself wrong (R1e). Nowhere does the record give γ′ = 3/2 ⇒ m_crit = 27/4096; that
value appears only in Learning to Lens (Ch. 15 l.576, Ch. 17).

Side finding (R1b): the CSV column `m1_crit` uses B = **0.8200776**, one value for all rows (`derivation.wl:14`, `Bfid`), while
the print header and note3's keybox say "B = 0.82". The difference is 3.8e−4 relative in m1_crit, which is harmless at the
quoted precision (0.014/0.0098/0.0017). The chapter uses B = 0.8 throughout, so it is unaffected.

### Table

| spiral id | claim (spiral record) | status in chapter | action |
|---|---|---|---|
| S7-014 (FAIL) | note3:75–77 "It is this asymmetry, not the black hole per se, that biases the ratio: if both planes were perturbed identically the ratio would be untouched." Spiral critic: false for the fitted bias (c₁ ≠ c₂) | **inherited.** Keybox l.305–312 ("If the black hole were the same fractional perturbation on both planes (m₂=m₁), the ratio would not change. The ratio is biased by the asymmetry between the planes, not by the black hole as such."), Summary l.902–903 ("This asymmetry is why the bias does not cancel"). The keybox is literally true only for the **total-mass radii** (R2d: ratio unchanged to <1e−30). For the fit it is false. In the chapter's own worked example (γ′=1.6, B=0.8, offsets 0.15/0.3) the counterfactual m₂=m₁ gives δB/B = −0.0798% at m₁=1e−4, **1.87× the physical −0.0428%**, not zero (R2a, R2b). A fixed-slope fit gives δη/η = −1.18e−4 vs +4.1e−6 physical (R2c) | New fix N-R1 |
| S7-015 (FAIL, prose) | note3 eq.(pert) δp = J⁻¹s m with p = (θ_E1, θ_E2, γ′). J is 5×3, so J⁻¹ does not exist | **already fixed in the port.** l.466–468 put the two source positions in **p**, so J is 5×5. The "Counting constraints" paragraph (l.537–541) states the exact determination, and the repo checks E3/E4 confirm J⁻¹s against a finite-difference fit to 1e−5 | none in chapter; see feedback FB-3 (the spiral critic's own proposed fix is incomplete) |
| S7-017 (FAIL) | note3:105 "a source-plane χ² … is exactly what a real modeller does" (contradicted by note1b: the imaging bias is ~20× smaller) | **already fixed.** The sentence is gone. The annotation l.633–641 says the exactly determined position-only fit is "an extreme case" and that extended arcs change the coefficients | none |
| S7-024 (FAIL, citation) | "Detected regime: … bright extra images … forced to add a central mass" cites Nightingale+23, whose detection has **no** central image | **inherited (mechanism), citation n.a.** The citations are stripped, but l.802–806 keep the mechanism and add "This is how a central black hole can be detected through lensing", which makes extra images *the* route. A black hole can also be detected by deforming an existing image (Nightingale et al. 2023, MNRAS 521, 3298, arXiv:2303.15514, per spiral `Reference_papers/README.md` l.60 and `VERIFIED_ANCHORS` l.153; not in `references.bib`) | New fix N-R2 |
| S7-023 (FAIL) | note3: the boundary "maximises sensitivity precisely near the boundary, where the bias is largest". In the sweep the net \|δB/B\| does not peak there | **already fixed (reworded).** Remark l.775–783 claims only that the bias grows *faster than linearly* toward the boundary for a fixed geometry. That is a nonlinearity statement and is verified for γ′=1.6 (N14). The γ′=1.8 caption number is already flagged F2 | covered by F2 |
| S7-028 (SUSPECT) | "coherent … every deflector hosts a black hole of the same sign, so it does not average down". In the spiral sweep δB/B is 86.4% negative and 13.6% positive | **inherited (softened).** Keybox l.874–883: "observed in similar configurations, it has the same sign … cannot be averaged away". Summary l.919: "coherent across a sample and does not average down". The chapter itself shows that sign and size depend on geometry (−4.26 → −17.8, l.598–603; "in principle its sign", l.638) | New fix N-R3 |
| S7-002 (FAIL) | "~1% dark-energy signal in B" is the retracted legacy instantaneous-w value (D2); correct CPL value is 0.24% | **n.a. (already patched at source; never ported).** The current note3 l.182 reads 0.24%. The chapter's only "1%" is "changing w by 0.3 changes B by about 1%" (l.265–266) for constant w, where the CPL issue does not arise. Re-verified: δB/B = −1.04% (w=−0.7) and +0.87% (w=−1.3) at (0.5,1,2) (R3a) | none |
| S7-008 (FAIL) | note3:61 direct term "+0.6%" should be +0.5% | **n.a.** Already corrected at source (current l.61 reads +0.5%). The chapter does not carry the cache-cell paragraph; it has its own verified worked example | none |
| S7-011 (SUSPECT, cadence) | the "+0.9% / +0.045 / −1.6% / −1.1%" paragraph and its bold closer | **n.a.** Not ported | none |
| S7-038 (SUSPECT) | sol_note3 Ex: σ₁ = 2% is a bare premise | **n.a. (premise only).** Ex. 17.4(b) uses σ₁=2%, b=0.5% explicitly as givens | none |
| S6-024 (FAIL, note1) | note1 calls note3's exercise input δγ′=0.03 a "numerical finding" | **n.a.** Ex. 17.1(b) states δγ′=+0.03 as a given, not as a measurement | none |
| S6-023 (SUSPECT) | η = 0.79 is not the project fiducial (0.8022) | **n.a.** Ex. 17.1 premise; the chapter's fiducials are B=0.8 and its own η | none |
| S7-074, -089, -141, -077, -051, -112, -116, -125, -130, -108, -049, -050, -154, -046, -039, -070, -072, -073, -121, -122, -156, -157, -158, -067, -106, -052, -066, -096, -058 | note4/note6/note1 rows of the same digest | **n.a.** (Chapters 16, 19) | none |
| S7-034 (SUSPECT, prose) | "X, not Y" saturation in a keybox closer (file not identifiable; the digest and the packet report both truncate the row) | the chapter's equivalent closer is P1 (l.311), which **falls with N-R1** | covered by N-R1 / P1 |
| TESTS A2 | backbone: θ_E2 = θ_E1 B^(−1/(γ′−1)); m₂ = m₁B^((3−γ′)/(γ′−1)) | **consistent** (eqs. cb_B_eta, cb_m2_m1; critic N1, N4) | none |
| TESTS A4 | Mathematica boundary vs Python "agree to 1.7e−6" | **consistent, and sharper.** The chapter's closed form matches the Mathematica CSV to 2.2e−15 (R1a), so the 1.7e−6 is the Python bisection's tolerance. The chapter is the first place the m_crit closed form appears | feedback FB-1 |
| TESTS A5 / MWK01 | radial-image existence vs central-image suppression (Mao, Witt & Koopmans 2001) | **consistent** (C2 PASS) | none |
| TESTS A9 | A3 response coefficient c in closed form, c = [3+ρ^(1−γ′)]/[(γ′−1)(3+ρ^(4−2γ′))]. Retraction: "the asymptote ρ^(1−γ′)/(3(γ′−1)) was an over-concession" | **n.a.** The chapter has no c, no ρ-asymptote and no A3 estimator. Its coefficient (−4.26, +1.53, −5.79) is the exact 5×5 J⁻¹s of one geometry and makes no asymptotic claim | none |
| CLAUDE.md (iv) | the backbone fixed-slope BoE "is NOT a predictor of the fitted bias, ~4× low and sign-agnostic" | **consistent in substance.** Keybox l.414–431 and item 4 of l.604–610 say the same. The chapter's own numbers reproduce "~4× low": free-slope ratio channel +1.53 vs BoE +0.406 (3.8×). **But** the label "order-of-magnitude estimate" (l.45, l.386, l.415, l.907; Sol. l.152) overstates it. At the worked example's offsets (0.15, 0.3), even a **fixed-slope** fit gives 0.084× the BoE (R2g), while equal offsets reproduce the chapter's 0.997 / 1.75 (R2e, R2f) | New fix N-R4 |
| CLAUDE.md θ_E convention | η_true from total enclosed mass; headline Δβ/β = η_fit^(γ′_fit−1)/β_true − 1; PL-only θ_E diagnostic only | **consistent.** Keybox l.200–222 (eq. cb_dBB_def) is the same definition | none |
| NOTES_mcrit_label_defect | Tier-3 `m/m_crit` label used the autolens `einstein_radius` parameter (÷F(q,γ′)) and the final-plane-referenced θ_E. True m was 3.6× the label | **n.a. / chapter uses the corrected definition.** Eq. cb_m_def defines m_i against plane i's own physical power-law normalisation, which is exactly `tier1_axisym.py:216` (θ_BH1 = √m·θ_E1, θ_E1 the PL component). An axisymmetric single-normalisation model cannot make the F(q,γ′) or final-plane conflation. m_crit is quoted on the radial-image plane, and m₁,crit is converted with the backbone exponent | feedback FB-2 (defect note's own wording) |
| NOTES_mcrit correction stamp + TESTS B6 | a radial critical curve persists (sub-pixel) in elliptical "dead" cells. Ellipticity and shear **loosen** the topological boundary (m_max/m_crit up to 1.75) | **inherited as a scope gap.** l.748–749 say "On the radial-image plane, no slope tolerates a central mass above 0.66%" with no "axisymmetric" qualifier. The chapter is axisymmetric (l.79), but the bullet reads as universal. Re-verified: external shear γ_e on the radial-image plane raises m_crit by exactly (1−γ_e)^(−(3−γ′)/(γ′−1)) (on-axis double root; closed form = bisection to 1e−15, R4a, R4b) | New fix N-R5 |
| TESTS C11b | outside the break, a bEPL = PL(t₂) + θ_eff²/θ exactly, with θ_eff² = 2κ_Bθ_B²(t₁−t₂)/((2−t₁)(2−t₂)) | **consistent.** Eq. cb_meff / Ex. 17.7(a) m_eff is identically C11b's θ_eff² (R6, symbolic) | none |
| TESTS D2, H0 | CPL vs instantaneous-w retraction; B, S_w recomputed at the project triplet (B = 0.8200776, S_w = −0.0157) | **n.a.** The chapter uses constant w at its own (0.5,1,2) triplet (B=0.674, S_w=−0.033, critic N21). It never quotes the project's −0.0157 | none |
| TESTS H3 | multi-plane coherence: per-plane biases stack | **n.a.** The chapter's coherence keybox concerns N lenses, not N planes (see N-R3) | none |
| HANDOFF 09-21 §5 | retractions (WP4b θ_E reading; γ = 1.288; Note 2b eq. numbers; Wolfram counts; rail census; Horseshoe; Ω_m ±0.3%; t₁_crit; T1_rank_deficient) | **n.a.** None touches note3's results or the chapter | none |
| HANDOFF 09-21 §6 | "two quantities that coincide in one limit get two names" | **consistent.** The chapter keeps θ_E (PL normalisation) and θ_E,tot (ring) separately named (§cb_theta_e) | none |
| critic F1 / CONFIRMED source errors 1–2 | sol_note3 l.80–88 and note3 l.133 "transcendental / no closed form" | **already fixed in the port**, and **not known to the spiral record** (see above) | feedback FB-1 |

### New fixes for the fix pass (not already in the Flagged section above)

- **N-R1 (from S7-014): keybox "The bias is differential", l.305–312, and Summary l.902–903.**
  - Problem: the claim that m₂=m₁ would leave the ratio unbiased is true only for the total-mass radii, not for the fitted ratio. In the worked example, m₂=m₁ gives a **larger** bias (×1.87, R2b). Two things drive the planes apart: the leverage of each plane's image configuration, and the free-slope channel through the far-plane radial image.
  - Proposed: keep the first three sentences, then replace the last two with: "For the total-mass radii, equal fractional perturbations ($\mBH_2=\mBH_1$) would leave $\etamea$ unchanged. A fit does not return the total-mass radii, though: the two planes have different image configurations (only the far plane has a radial image here), so they respond differently even to the same fractional perturbation (\S\ref{sec:cb_worked})."
  - Summary bullet: "This asymmetry is one reason the bias does not cancel in the ratio; the other is that the two planes' images respond differently to the fit."
  - P1 then goes away with it. The Solutions 17.7(c) echo ("not the black hole as such", Sol. l.225) concerns rigidity, not the plane asymmetry, and can stay.
- **N-R2 (from S7-024): Detected regime, l.802–806.**
  - Problem: "This is how a central black hole can be detected through lensing" presents extra images as the only route.
  - Proposed: "This is one way a central black hole can be detected through lensing. A black hole that measurably deforms an existing image can also force a central mass into the model without any extra image."
  - Bib request (UNVERIFIED in this repo): Nightingale, J. W., et al. 2023, MNRAS 521, 3298, "Abell 1201: detection of an ultramassive black hole in a strong gravitational lens", arXiv:2303.15514. Details are from the spiral `Reference_papers/README.md` l.60 and `lit_review/VERIFIED_ANCHORS_2026-07-16.md` l.153. Confirm the DOI via CrossRef before adding the key.
- **N-R3 (from S7-028): keybox "A coherent systematic", l.874–883, and Summary l.919.**
  - Problem: "it has the same sign" is unconditional, yet the chapter shows sign and size depend on geometry.
  - Proposed: "…it tends to have the same sign, because every black hole adds positive central mass, although the size, and in some geometries the sign, of the slope response varies (\S\ref{sec:cb_worked}). Averaging over $N$ lenses reduces the statistical error as $N^{-1/2}$ but leaves the *mean* bias unchanged…"
  - Summary: "Its mean is coherent across a sample and does not average down."
- **N-R4 (from spiral CLAUDE.md (iv), re-verified R2e–R2g): the label "order-of-magnitude estimate" at l.45, l.386 (subsection title), l.415, l.907 and Solutions l.152.**
  - Problem: the chapter's own item 4 shows the estimate has the opposite sign and is 11× smaller than the free-slope fit. Even with the slope fixed, the estimate is 12× too large at the worked example's offsets (0.15, 0.3): the per-plane responses nearly cancel (R2g, ratio 0.084). Keybox item 2 quotes only equal offsets (0.02/0.02 → 0.997; 0.3/0.3 → 1.75, both reproduced).
  - Proposed: retitle to "A fixed-slope, on-ring estimate". In the keybox, replace "gives an *order of magnitude*" with "gives the ratio channel for images on the rings". Add to item 2: "and when the two sources sit at different fractional offsets the per-plane shifts can nearly cancel (for offsets 0.15 and 0.3 in the worked-example lens, a fixed-slope fit returns 0.08 of eq.~\eqref{eq:cb_boe})". This needs a new repo check (fixed-slope fit at (0.15, 0.3)) before it goes on the page.
- **N-R5 (from the B6 row + defect-note correction stamp, re-verified R4): l.748–749 "no slope tolerates a central mass above 0.66%".**
  - Proposed: "For an axisymmetric lens, no slope …". Optionally add one sentence: "External shear or ellipticity raises the boundary. A shear $\gamma_{\rm e}$ on the radial-image plane multiplies $\mBH_{\rm crit}$ by $(1-\gamma_{\rm e})^{-(3-\gp)/(\gp-1)}$." This needs a repo check before it goes on the page; R4 is the template.
- **N-R6 (low priority, physics wording; R5): l.666 "an inner critical curve belonging to the black hole" and l.720 "meets the black hole's own critical curve coming outward".**
  - Problem: a point mass alone has no radial critical curve (λ_r = 1+θ_•²/θ² > 0; the chapter's own Ex. 17.6(b) and Ch. 15). The inner zero of y′ is the inner edge of the λ_r<0 annulus, which exists only because the power law supplies the negative λ_r.
  - Proposed: "an inner radial critical curve that the black hole creates out of the power law's λ_r<0 region" and "until it meets the inner critical curve coming outward".

### Feedback to the spiral project (errors the spiral record does not yet know about)

- **FB-1: the annihilation boundary has a closed form; the "transcendental" claims are wrong (twice), and TESTS A4 overstates what derivation.wl does.**
  - Wrong text: `theory/note3_smbh_bias.tex:133` ("one transcendental equation for u_crit") and `theory/solutions/sol_note3_smbh_bias.tex:80–88` ("distinct fractional powers of u … preclude a closed form; it is solved numerically").
  - The exponent at sol l.86, u^(−(1−γ′)/(3−γ′)−1), is also wrong.
  - Why: substituting θ\* from y″=0 makes both u-terms of y′ scale as u^((1−γ′)/(3−γ′)), so y′(θ\*)=0 is linear in that power. This gives θ\* = [(2−γ′)(3−γ′)/2]^(1/(γ′−1)) and m_crit = ½(2−γ′)(γ′−1)θ\*^(3−γ′), with m_crit(3/2) = 27/4096 and a maximum of 0.0065996 at γ′ = 1.48463.
  - Proof: R1d–R1f (symbolic). The closed form reproduces `annihilation_boundary.csv` m2_crit to 2.2e−15 and theta_star to 7e−16 (R1a, R1c).
  - TESTS §2 A4 (l.213–214) says derivation.wl yields "closed θ_* … and m_crit(γ)", but `derivation.wl:22–23` gets m_crit by `FindRoot`.
  - In Learning to Lens this is Ch. 17 eqs. cb_thetastar / cb_mcrit and Ch. 15 l.576.
- **FB-2: `NOTES_mcrit_label_defect_2026-08-03.md` l.83 misstates the reference definition.** It says `tier1_axisym.m_crit_numeric` "defines m against the physical plane-1 **total-mass** Einstein radius". The code (`scripts/tier1_axisym.py:216`, `alpha_pl` l.45–48) sets θ_BH1 = √m·θ_E1 with θ_E1 the **power-law component** normalisation, not θ_E,tot (which is larger by m/(γ′−1), a 1–2% effect in m at m ~ 0.01). This does not change the 3.6× defect, but the "corrected definition" the note points to is the PL-component one, which is also what CLAUDE.md's backbone "m ≡ θ_BH²/θ_E²" and the chapter's eq. cb_m_def use.
- **FB-3: the packet critic's S7-015 fix is itself incomplete.** It calls J "5×3, J⁻¹ does not exist" and prescribes the pseudo-inverse. With the two (unobserved) source positions included as parameters, as A3's free intercept and the Tier-1 source-plane χ² both do implicitly, the system is 5×5 and exactly determined in the 452/474 sweep cells with five images. J⁻¹ is then correct, and the pseudo-inverse is needed only for the 22 cells with six or seven images. The right repair of note3 eq.(pert) is p = (θ_E1, θ_E2, γ′, y₁, y₂), which is what the chapter does (l.466–468, verified by repo checks E3/E4 to 1e−5).
- **FB-4: S7-014 is confirmed by an independent route, and the effect is larger than "~65% of the bias standing".** In the axisymmetric exact-fit geometry (γ′=1.6, B=0.8, y₁=0.15θ_E1, y₂=0.3θ_E2), forcing m₂=m₁ **increases** the free-slope bias to 1.87× the physical value (R2b). note3:75–77 should be corrected as S7-014 proposes.
- **FB-5: TESTS B6, q=1 column, has a closed form.** The column (1.682 / 1.354 / 1.215 at sh=0.10, γ′=1.4/1.6/1.8) is reproduced to all printed digits by the on-axis double-root closed form m_max/m_crit = (1 − γ_e)^(−(3−γ′)/(γ′−1)), with γ_e = sh/B = 0.10/0.8200776 the shear on the radial-image plane (R4c). This both confirms B6's "loosening" sign analytically and shows that B6's `sh` is referenced to plane 1, not to the radial-image plane. Worth stating in the B6 entry, since that plane-referencing convention is the same error class as the m/m_crit label defect.
- **FB-6 (minor): `derivation.wl` prints "m1_crit(B=0.82)" but uses `Bfid = 0.8200776`.** The 3.8e−4 relative difference is harmless at the quoted precision, but the header should say 0.82008, matching H0's B = 0.8200775769.
