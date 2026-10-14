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
