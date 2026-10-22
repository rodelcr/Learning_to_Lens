# Spiral packet critic — auto-fixable list and coverage gaps

## Auto-fixable — 26 (NOT applied; the main session applies these with the diff visible)

| id | file | quoted | fix | source |
|---|---|---|---|---|
| S2-035 | `theory/note9_cosmology_impact.tex` |  | None. | `results/propagation/cosmology_impact.json → regimes.flexible.median = 0.0008925837854329988, .best = 9.1821945` |
| S2-038 | `theory/note9_cosmology_impact.tex` |  | Replace "Between one and two orders of magnitude" with "Between two and three orders of magnitude" (126×–408×  | `results/propagation/cosmology_impact.json → regimes.masked.tier1_span_min = 0.11295069384395362, .tier1_span_m` |
| S2-046 | `theory/note9_cosmology_impact.tex` |  | Change "flat to $\le 9.2\times10^{-32}$" to "flat to $\le 9.9\times10^{-32}$" in note9 l.280-281, and fix the  | `results/propagation/b5_radial_ablation.json → tier1.cells[*].ablated_max_cost = [9.2445e-32, 6.1630e-32, 8.320` |
| S2-031b | `theory/note9_cosmology_impact.tex` |  | In theory/note9_cosmology_impact.tex:281 change "$\le 9.2\times10^{-32}$" to "$\le 9.9\times10^{-32}$" (the ma | `theory/note9_cosmology_impact.tex:280-281 vs results/propagation/b5_radial_ablation.json tier1.cells[*].ablate` |
| S4-025 | `theory/note3b_case_ab_synthesis.tex` |  | Replace '$\sim1.9\%$ (Tier-2 median)' with '$\sim2.0\%$ (Tier-2 median)' in the regimes table, theory/note3b_c | `results/propagation/cosmology_impact.json key `regimes.rigid_position_only.median` = 0.019983444242611476 (= 1` |
| S3-37 | `theory/note5_msd_kinematics.tex` |  | Replace '$10^{-6}$--$10^{-4}$' with '$9\\times10^{-7}$--$6\\times10^{-4}$' (or '$10^{-6}$--$10^{-3}$') in theo | `results/propagation/g4_kinematic_prior.json key 'noise_free_diagnostic': ln_mass_residual = 8.990247697e-07 (p` |
| S1-027 | `theory/note2b_broken_pl.tex` |  | Replace with the canonical emitter's values: '$t_1 \simeq 0.4$--$1.1$ ($\gp_{\rm in} \simeq 1.4$--$2.1$), $\th | `/Users/rosador/Documents/AGEL/202607_Theoretical_spiral_compound/scripts/make_bepl_geometry_figure.py --ranges` |
| S1-032 | `theory/note2b_broken_pl.tex` |  | Change '$\Delta\log Z\in[-2.39,+1.20]$' to '$\Delta\log Z\in[-2.39,+1.66]$' at note2b_broken_pl.tex:154 AND at | `scripts/tier3_ladder_analysis.py:307 (`dlogz_eplbh_bepl = eplbh.log_evidence - bepl.log_evidence`, prefer_tewi` |
| S5-029 | `theory/note8 + solutions/SOLUTIONS` |  | Replace 'the factor ~10-15 blue advantage' with 'a factor 4-15 blue advantage across z_l = 0.3-0.7 (~7x at the | `scripts/sed_contrast.py live run 2026-10-14 SUB column: F606W 15.9/25.0/46.2 and F184 3.9/3.6/3.1 for z_l = 0.` |
| S4-008 | `theory/note3b_case_ab_synthesis.tex` |  | Change to '$\Delta\log Z(\text{EPL}{+}\text{PM}-\text{bEPL})\in[-2.39,+1.66]$'. Better: have the note's number | `scripts/tier3_ladder_analysis.load_cells() (prefer_tewide=True, per its docstring at :25 and _read_model at :8` |
| S5-006 | `theory/note8 + solutions/SOLUTIONS` |  | Change "|μ_r| ≃ 0.69" to "|μ_r| ≃ 0.70". To make the example reproducible end to end, also write the radius as | `Recomputed from the note's own formulas with scripts/theta_e_defs.radial_critical_radius_pl(1.36, 1.6) = 0.295` |
| S5-047 | `theory/note8 + solutions/SOLUTIONS` |  | Recompute at the Horseshoe's own redshifts and state them: 'the Cosmic Horseshoe's two sources are close in re | `Recomputed with scripts/cosmology_impact.py (fiducial_spec: H0=70, Om0=0.3, w0=-1, wa=0). Geometry(z_d=0.45, z` |
| S5-089 | `theory/note8 + solutions/SOLUTIONS` |  | Change ':450-451' to '($\Cband=-0.8$ to $-2.0$ at F606W vs $-3.3$ to $-3.8$ at Roman F158/F184)', and correct  | `theory/note8_observational_realism.tex:139-143 (the note's own table) reproduced live by `conda run -n lens py` |
| S8-031 | `theory/note11 + methods1-3` |  | Replace $\Omega_m=0.309\pm0.027\,({\rm stat})\pm0.004\,({\rm model})$ with $\Omega_m=0.309^{+0.027}_{-0.033}\, | `Reference_papers/Cosmology_with_J0946.pdf §6 Discussion (pdftotext line 708): "we conclude that Ω_m = 0.309+0.` |
| S7-116 | `theory/note3, note4, note6` |  | At theory/note6_multipoles.tex:424 replace 'inner $\chi^2/N\approx1$' with 'inner $\chi^2/N = 0.95$--$2.01$' s | `results/propagation/r1_g2_evidence_robustness.json → inner.chi2_per_n over the 12 fits ∈ [0.95252, 2.01389]; o` |
| S5-141 | `theory/note8 + solutions/SOLUTIONS` |  | Change 'Note~10 \S8' to 'Note~10 \S7' at theory/solutions/sol_note10_analytic_backbone.tex:245. (While in that | `theory/note10_analytic_backbone.tex §-list (\section at lines 41/60/97/261/285/315/340/387) and the compiled t` |
| S5-074 | `theory/note8 + solutions/SOLUTIONS` |  | none — PASS | `results/propagation/radial_detectability.json, "thresholds" array — F606W: gamma 1.4/1.6/1.8/1.9 → theta_E_min` |
| S5-075 | `theory/note8 + solutions/SOLUTIONS` |  | Change "gamma' \\lesssim 1.38" to "gamma' \\lesssim 1.35" at note8:389. Propagate the same correction to lit_r | `results/propagation/radial_detectability.json "thresholds" + a live inversion of scripts/radial_detectability.` |
| S8-052 | `theory/note11 + methods1-3` |  | In theory/note11_dspl_literature_scaffold.tex line 165, change $w=-1.52^{+0.49}_{-0.33}$ to $w=-1.52^{+0.33}_{ | `Reference_papers/Bowden2025_AGEL0353_DSPL.pdf, abstract l.56-57 and Table 2 l.594-596 ('AGEL0353 0.192 +0.305 ` |
| S6-106 | `theory/note1, note1b, note2` |  | none — PASS | `mathematica/exercises/sol_note2_axisym_pl_pointmass.csv row Ex3_thetaR_over_thetaE_g1.6 = 0.2171534093275925; ` |
| S6-107 | `theory/note1, note1b, note2` |  | theory/note2_axisym_pl_pointmass.tex:179 — change 'the tangential images shift by $\pm\thetaBH^2/(\theta_\pm^{ | `mathematica/exercises/sol_note2_axisym_pl_pointmass.wl Ex4c ('delta theta_pm = +tBH^2 / theta_pm^(0) (linear i` |
| S7-008 | `theory/note3, note4, note6` |  | theory/note3_smbh_bias.tex:61 — change '$(\gp-1)\,\delta\etamea/\etamea\simeq+0.6\%$' to '$(\gp-1)\,\delta\eta | `results/tier1_bias/sweep_freeg_N4.npz, cell gamma=1.6 / m_bh=0.0029064 / B=0.8 / src_offset=0.85: delta_eta_ov` |
| S1-011 | `theory/note2b_broken_pl.tex` |  | Update TESTS_AND_DIAGNOSTICS.md row C11b from '15/15' to the file's own printed '22/22'. | `mathematica/04_broken_pl/verify.wl (wolframscript run: 'TOTAL: 22/22 verdicts PASS'); tests/test_note2b_broken` |
| S1-109 | `theory/note2b_broken_pl.tex` |  | Fix note2b:122-123 to 'theta_B ~ 0.04-0.08", t1 ~ 0.39-1.09 (gamma_in ~ 1.39-2.09)' to match make_bepl_geometr | `results/propagation/smbh_regime_map.json case_a_measured: n = 45, theta_B = [0.03359, 0.09393]; fitted_bepls (` |
| S2-129 | `theory/note9_cosmology_impact.tex` |  | Update the CLAUDE.md H5 bullet from 'OFF the wCDM manifold' to 'reachable only with w_a free (guard: wa-free-o | `scripts/cosmology_impact.reachable_excursion(): w0wa_wide hi = +6.136% > the H5 upper corner +4.034% > wcdm_wa` |
| S2-046 | `theory/note9_cosmology_impact.tex` |  | Replace 9.2e-32 with 9.9e-32 (or quote the exact 9.860761315262648e-32) in theory/note9_cosmology_impact.tex:2 | `results/propagation/b5_radial_ablation.json tier1.cells[*].ablated_max_cost: the maximum over the 9 cells is 9` |



## Coverage gaps — what this pass could NOT check

- **160 of 1252 extracted claims never reached a verifier.** The verify phase batched 14
  claims per agent; batches that errored or returned short drop their claims silently. Those ids are
  absent from this report — it is not a clean bill for them.
- **No `.bib` exists in this repo**, so every citation had to resolve through Zotero or a live DOI.
  A citation that is real but absent from the library can only reach ⚠ SUSPECT, never ✅ PASS.
- **`Reference_papers/*.pdf` is gitignored**, so citation checks against full text depend on what is
  on this machine. The Ballard/Enzi/Collett 2026 J0946 draft there is PRIVATE and was not cited.
- **Prose/Provenance verdicts are advisory.** There is no author baseline commit to diff against,
  so 'machine-drafted' is inferred from cadence, not from authorship data.
- The synthesis agent failed, so there is **no model-written narrative** over these rows; the
  grouping and framing here are mechanical.
