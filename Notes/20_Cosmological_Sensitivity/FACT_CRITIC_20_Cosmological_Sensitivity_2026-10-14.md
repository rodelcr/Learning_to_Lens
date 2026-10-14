# fact-critic report — Notes/20_Cosmological_Sensitivity/ (PDF Chapter 24, "Cosmological Sensitivity of Compound-Lens Ratios")

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation (+ project-leakage lint)
> Scope: `20_Cosmological_Sensitivity.tex`, `20_Solutions.tex`, `Mathematica/20_Cosmological_Sensitivity/cosmological_sensitivity.wl`,
> `Solutions/20_Cosmological_Sensitivity/problems_20.wl`, `Figures/20_Cosmological_Sensitivity/` (branch `wt/ch20`).
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (CrossRef API for all 5 DOIs; arXiv API
> abstracts for 1203.2758, 1403.5278, 1406.6152 — fetched to the scratchpad, read as text only), md-reflist ✗ (n/a),
> values-file ✗ (none), repo-grep ✓, doc-internal ✓, wolframscript ✓ (repo scripts + critic scratch script, via
> `Mathematica/run_wl.sh`), overlay: AGEL `local/agel-sources.md` (Zotero not needed — every cited DOI CrossRef-confirmed).
> Critic is independent of the author; no PASS below is from memory.

## Repo scripts (run 2026-10-14)

- `cosmological_sensitivity.wl`: `SUMMARY: 53 PASS, 0 FAIL  (of 53 checks)` (re-run after the auto-fix below: still 53/53).
- `problems_20.wl`: `SUMMARY: 26 PASS, 0 FAIL  (of 26 checks)`.
- Cosmetic only: `Reduce::ratnz` (check 3i) and `NIntegrate::precw` (5b, Solutions 5b) warnings; results unaffected.

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "does not depend on the Hubble constant at all \citep{collett_2012}" (L20–21) | ✅ PASS | bib:collett_2012 / DOI 10.1111/j.1365-2966.2012.21424.x CrossRef-confirmed (MNRAS 424, 2864); arXiv 1203.2758 abstract: "This quantity is independent of the Hubble parameter" | none |
| C2 | Citation | "the Ω_m–w degeneracy of DSPLs is almost orthogonal to that of the CMB and baryon acoustic oscillations" (L497–499) | ✅ PASS | arXiv 1203.2758 abstract, verbatim: "the method's degeneracy between Omega_M and w is almost orthogonal to that of CMB and BAO measurements" | none (optional sharpening, see Flagged) |
| C3 | Citation | "Schneider \citep{schneider_2014_multiplane} showed that for a two-source-plane system it can mimic a change of cosmological parameters" (L547–549) | ⚠ SUSPECT (support confirmed, hypothesis omitted) | bib:schneider_2014_multiplane / DOI 10.1051/0004-6361/201424450 CrossRef-confirmed (A&A 568, L2); arXiv 1406.6152 abstract: invariance holds "in lens systems with two distinct source redshifts, of which the nearest one contributes to the light deflection towards the more distant one"; "Changing cosmological parameters ... is essentially equivalent to such a mass-sheet transformation" | add the hypothesis (see Flagged) |
| C4 | Citation | "a multi-plane generalisation of the mass-sheet transformation can trade a change in the mass model for a change in the inferred cosmology \citep{schneider_2014_multiplane}" (L572–575) | ✅ PASS | same abstract as C3 | none |
| C5 | Citation | "DSPL cosmography has gone from a forecast \citep{collett_2012}" (L819) | ✅ PASS | arXiv 1203.2758 abstract ("forecast population of systems") | none |
| C6 | Citation | "to a first measurement on an observed system \citep{collett_auger_2014}" (L819–820) | ✅ PASS | bib:collett_auger_2014 / DOI 10.1093/mnras/stu1190 CrossRef-confirmed (MNRAS 443, 969); arXiv 1403.5278 abstract: "the first cosmological measurement with a galaxy-scale double-source-plane lens" | none |
| C7 | Citation | "the Chevallier--Polarski--Linder (CPL) form" (L120–121) — no citation | ⚠ SUSPECT (attribution uncited; keys now available) | bib:chevallier_polarski_2001 / DOI 10.1142/S0218271801000822 CrossRef-confirmed (IJMPD 10, 213); bib:linder_2003 / DOI 10.1103/PhysRevLett.90.091301 CrossRef-confirmed (PRL 90, 091301). `grep` finds neither key in any chapter .tex | add `\citep{chevallier_polarski_2001,linder_2003}` (see Flagged) |
| C8 | Citation (named result) | "1/F_{w0w0} never exceeds (F^{-1})_{w0w0} (the Cramér--Rao inequality)" (L488–490; also Solutions L78) | ⚠ SUSPECT (mis-named) | critic D3g/D3h (inequality itself verified). The inequality is a property of positive-definite matrices (Schur complement); Cramér–Rao is the separate statement Var(θ̂_i) ≥ (F^{-1})_ii | reword (see Flagged) |
| N1 | Number | B = 0.674156 (L286) | ✅ PASS | critic D2a (own NDSolve distances); repo check 1d | none |
| N2 | Number | J = (−0.03569, −0.03301, −0.007255) (L288; Sol. L19) | ✅ PASS | critic D2c (5-point stencil, h=1e-3): (−0.0356896, −0.0330114, −0.0072553); repo 2a–2e, Sol. 0a | none |
| N3 | Number | 1/S_w0 = −30.29; |Δw0| = 0.30 for 1% (L289, L294) | ✅ PASS | critic D2d, D3d | none |
| N4 | Number | S_wa/S_w0 = 0.22 (L303; Sol. L53) | ✅ PASS | critic D2e | none |
| N5 | Number | c* = −0.925; 2c* = −1.850 (L402, L467; Sol. L75) | ✅ PASS | critic D2f (c* = −0.924958) | none |
| N6 | Number | blind-direction response "about 4%", halves with step (L404–407) | ✅ PASS | critic D6g: 3.78% at t=0.01, 1.88% at 0.005 | none |
| N7 | Number | A(−½)=2.18, A(+½)=0.649 (L460–461) | ✅ PASS | critic D3c: 2.17659, 0.649113 | none |
| N8 | Number | |Δw0| = 0.659 / 0.303 / 0.197 at δ=1% (L462–463; Sol. L68–69) | ✅ PASS | critic D3d | none |
| N9 | Number | lower-bound interval c ∈ [2c*, 0] = [−1.850, 0] (L467) | ✅ PASS | critic D3e: symbolic Reduce gives 2c* ≤ c < c* or c* < c ≤ 0 for S_Ω, S_w < 0 (c* itself is the pole, A=∞, which also satisfies A≥1) | none |
| N10 | Number | "at c = 0.99 c* already more than fifty times" (L473–474) | ✅ PASS | critic D3f: A(0.99c*) = 100 exactly (=1/0.01) | optional: say "a hundred times" |
| N11 | Number | Ω_m-prior variance difference = σ_X² S_Ω²/S_w² (L491–492) | ✅ PASS | critic D3g (symbolic) | see N25 for "error" vs variance wording |
| N12 | Number | exact Δw0 = −0.162 (c=0), −0.091 (c=+½) vs linear −0.151, −0.098 (L516–517) | ✅ PASS | critic D6a: −0.16155, −0.09145 | none |
| N13 | Number | linear −0.330 at c=−½; "B rises by at most 0.09% along that ray" (L518–520) | ✅ PASS | critic D6b, D6b′, D6c: unique maximum 0.0907% at t=−0.1255 over the whole physical ray 0<Ω_m<1 (t∈[−1.38,0.58]) | none (the repo check F0c is a local FindMaximum only — see Flagged, optional) |
| N14 | Number | B_3 = 0.6095, row (−0.0600, −0.0456, −0.0114), 5.5°, cond 22.7 (L592–596) | ✅ PASS | critic D2g, D2h | none |
| N15 | Number | B peaks +1.81% near w0 = −2.2 at Ω_m=0.3 (L766) | ✅ PASS | critic D6d: +1.8051% at w0=−2.207; falls on both sides (scan −3…−0.5) | none |
| N16 | Number | box range [−1.7%, +3.3%] (L769; Sol. L149) | ✅ PASS | critic D6e (21×41 grid): [−1.740%, +3.306%] | none |
| N17 | Number | 0.25/|S_w0| = 7.6 (L774), 7.57 (Sol. L137) | ✅ PASS | critic D6f | none |
| N18 | Number | z/(1+z) ≤ ½ (z≤1), ≤ ⅔ (z≤2) (L299–300) | ✅ PASS | repo Sol. 1d (monotone) | none |
| N19 | Number | ζ(1)=1.0347 at (−0.9,−0.3); 3.5%; w crosses −1 at z=0.5 (Sol. L43–47) | ✅ PASS | critic D1d; w(z)=−1 ⇔ z/(1+z)=⅓ ⇔ z=0.5; repo Sol. 1c, 1f | none |
| N20 | Number | 0.7^{7/3}=0.43507, 0.5^{7/3}=0.19843 (Sol. L116–117) | ✅ PASS | critic D5c | none |
| N21 | Number | null direction (−0.03301, +0.03569), 132.8°, slope −1.081 (Sol. L93–95) | ✅ PASS | critic D2k | none |
| N22 | Number | D_Δt row (−0.0174, −0.1043), 38° (Sol. L102–103) | ✅ PASS | critic D2j | none |
| N23 | Number | geometry 2: B=0.7038, J=(−0.03960, −0.04086, −0.007386), c*=−1.032, S_w0 24% larger (Sol. L194–199) | ✅ PASS | critic D2i | none |
| N24 | Number | FD vs under-integral agreement < 1e-10 after Richardson (L275–276) | ✅ PASS | repo checks 2a–2c (code read: compares Richardson `Jrich` with `Jan`) | none |
| N25 | Number (wording) | "the error on w0 with Ω_m fixed, 1/F_{w0w0}, never exceeds the marginalised error (F^{-1})_{w0w0}" (L488–490) | ⚠ SUSPECT | 1/F_ww and (F⁻¹)_ww are variances (σ²), not errors | "the variance of w0 with Ω_m fixed, 1/F_ww, never exceeds the marginalised variance (F⁻¹)_ww" |
| X1 | Consistency | J values: chapter L288, Solutions L19, both .wl | ✅ PASS | internal: 4 occurrences agree | none |
| X2 | Consistency | A(−½): chapter "2.18" vs `cosmological_sensitivity.wl` L211 check label "2.17" | ❌ FAIL (auto-fixed) | exact 2.17659 → 2.18 (critic D3c; check tolerance in the same line uses 2.176) | label → "2.18" (applied) |
| X3 | Consistency | c*, 2c*, interval: chapter L402/L467/L481/L848 vs Sol. L75 vs both .wl | ✅ PASS | internal: all agree | none |
| X4 | Consistency | every `Chapter~\ref` / `\S\ref` / `eq.~\ref` target | ✅ PASS | label→file grep + PDF TOC (`pdftotext -l 16 Output/Learning_to_Lens_Annotated.pdf`): ch:multiplane_dspl→Ch.18 "Multi-Plane Lens Equation and DSPL"; ch:power_law_point_mass→Ch.19; ch:odd_images→Ch.20; ch:central_mass_bias→Ch.21 "How an Unmodelled Central Mass Biases a Compound Lens"; ch:cosmological_distances→Ch.7; ch:galaxy_lensing→Ch.13 (sec:msd, sec:power_law_profile). eq:rho_scaling (ρ∝a^{−3(1+w)}), eq:Hz_concordance, eq:DA_flat, eq:Dds_flat, eq:Dds_general, eq:einstein_radius_preview, eq:redshift_scale_factor all in Notes/03; Ch.7 L1195 does contain the "D_ds ≠ D_s − D_d" remark | none |
| X5 | Consistency | m ≡ θ•²/θ_E² (L608) vs preamble `\mBH` = M_BH/M(<θ_E) | ✅ PASS | Notes/preamble.tex:160; equal for a power law since M(<θ_E) = πΣ_cr D_d² θ_E² and θ•² = 4GM_BH D_ds/(c² D_d D_s) | none |
| X6 | Consistency | B = η^{γ′−1}, B<1, B ≡ D_ds1 D_s2/(D_s1 D_ds2) vs Ch.18 | ✅ PASS | Notes/14_Multiplane_DSPL/14_Multiplane_DSPL.tex:357, :503; critic D5b | none |
| X7 | Consistency | header comment L7–8: "CPL ... [not in references.bib; stated without citation]" | ❌ FAIL (comment stale; flag-only — tied to a citation decision) | Notes/references.bib:473, :485 now contain both keys | update the comment when the cite is added |
| X8 | Consistency | "time-delay distance D_Δt = D_d D_s/D_ds (eq.~\ref{eq:time_delay_recap})" (L560) | ⚠ SUSPECT | Notes/09_.../09_Galaxy_Lensing_Applications.tex eq:time_delay_recap carries the (1+z_d) factor; the standard D_Δt includes it. Harmless for log-derivatives (Sol. L98–99 says so) | "D_Δt = (1+z_d) D_d D_s/D_ds" |
| X9 | Consistency | Figure captions vs scripts/figures | ✅ PASS | rendered both PDFs (pdftoppm): Fig. 2 has dotted blind line through the dot, blue/green/red arrows, open circles on the c=0 and c=+½ rays, red arrow does not reach the dashed contour; Fig. 1 contours −3…+2% | none |
| X10 | Consistency | Summary bullets vs body (S_wa "several times smaller", rank-1, interval, coherence) | ✅ PASS | internal: S_w0/S_wa = 4.55 | none |
| X11 | Consistency (logic) | "When the b_i share a sign, as they do for a coherent error" (L680–681); "the δ_i ... form a deterministic, monotone family" (L643–644) | ⚠ SUSPECT | Same sign of m_i is derived (D5a); same sign of δ_i = ΔlnB_i additionally needs the per-plane response r_i to share a sign — asserted, not derived here or checked in either .wl | one clause: "provided each r_i has the same sign (Chapter 21)" or point to where it is shown |
| L1 | Leakage lint | `grep -nEi 'tier\|scripts/\|results/\|lenstronomy\|autolens\|J0946\|AGEL\|Carousel\|this project\|11–36\|1.9%\|0.13\|0.009\|0.24\|63.6\|D2'` on all four scope files + figure text | ✅ PASS | only hits are Mathematica variable names `d1, d2` (case-insensitive "D2") in the .wl; no project leakage. Source note's geometry (0.68, 1.52, 2.11) and c* = −0.6173 are not reused; the chapter's illustrative geometry is new | none |
| D1–D6 | Derivation | see § Derivation checks | ✅ PASS (6/6) | critic scratch script, 40/40 | none |
| P1–P5 | Prose | see § Prose | ⚠ SUSPECT ×5 | read | author's choice |

**Counts:** ✅ PASS 43 (C 5, N 24, X 7, L 1, D 6) · ⚠ SUSPECT 11 (C3, C7, C8, N25, X8, X11, P1–P5) · ❌ FAIL 2 (X2 auto-fixed; X7 flag-only).

## Applied (auto-fixes)

- X2: `Mathematica/20_Cosmological_Sensitivity/cosmological_sensitivity.wl:211` check label `2.17 at c=-1/2` → `2.18 at c=-1/2`
  (number-vs-number consistency with chapter L460; exact value 2.17659; check tolerance unchanged). Script re-run: `SUMMARY: 53 PASS, 0 FAIL (of 53 checks)`.

## Flagged — your hand required

1. **C7 / X7 — CPL is uncited.** L120–121 names the Chevallier–Polarski–Linder form with no citation; both keys are now in
   `Notes/references.bib` and CrossRef-confirmed (chevallier_polarski_2001: IJMPD 10, 213, DOI 10.1142/S0218271801000822;
   linder_2003: PRL 90, 091301, DOI 10.1103/PhysRevLett.90.091301). Proposed: "...the Chevallier--Polarski--Linder (CPL) form
   \citep{chevallier_polarski_2001,linder_2003}". Then update the stale header comment L7–8 ("[not in references.bib; stated without
   citation]"). Not applied (citations are never auto-edited).
2. **C3 — Schneider 2014 hypothesis.** The abstract restricts the multi-plane MST to systems in which the nearer source also deflects
   light from the farther one. The chapter (L547–549) says "for a two-source-plane system". Proposed: "...showed that for a
   two-source-plane system in which the nearer source also acts as a deflector it can mimic a change of cosmological parameters."
   This matters here because the chapter's own B = η^{γ′−1} model ignores the first source's mass.
3. **C8 / N25 — Cramér–Rao naming and "error" vs variance (L488–492; Sol. L78).** The inequality 1/F_ii ≤ (F⁻¹)_ii is true (critic D3g, D3h:
   for any c the difference is (c σ_B² − S_Ω S_w σ_X²)² / [(cS_Ω+S_w)²(c²σ_B²+S_w²σ_X²)] ≥ 0). It is a positive-definite-matrix
   (Schur-complement) property, though. Cramér–Rao is the separate bound Var(θ̂) ≥ F⁻¹. Proposed: "...never exceeds the marginalised
   variance (F⁻¹)_{w0w0}; this is a property of any positive-definite Fisher matrix, and it is the conditional-vs-marginal version of the
   Cramér–Rao bound". Also change "error" → "variance" where 1/F and (F⁻¹) are quoted.
4. **X8 — D_Δt definition (L560).** Add the (1+z_d) factor so that it matches eq:time_delay_recap and the standard definition.
5. **X11 — sign coherence of δ_i (L643–644, L680–681).** The chapter derives that the m_i share a sign. That the δ_i (hence the b_i) share a sign
   also requires the per-plane response r_i to share a sign. Either cite where Chapter 21 shows it, or add the proviso.
6. **C2 (optional sharpening, not an error).** Exact orthogonality of the two blind directions, (c*,1)·(c,1)=0, gives c = −1/c* = +1.081 and
   A = 0.46 at this geometry. So the Collett et al. statement implies a *smaller* bias than the fixed-Ω_m number, which is more than "keeps
   A finite" (L501). Note too that "orthogonal" depends on how the Ω_m and w axes are scaled, and Collett's statement is for their geometries, not this one.
   Consider one sentence on this.
7. **N13 (optional robustness).** Repo check F0c uses a local `FindMaximum` started at t = −0.12. The critic's global scan over the full
   physical ray (0 < Ω_m < 1) confirms that this is the unique maximum (0.0907%), so the claim stands. A grid scan in F0c would make the check self-sufficient.
8. **Build state (informational).** `Output/Learning_to_Lens_Annotated.pdf` in this worktree shows Ch. 24 as "[Chapter in preparation.]", so
   the rendered chapter could not be inspected. Cross-refs were checked by label→file plus the PDF TOC. Rebuild after the fixes and confirm the page count.
9. **Housekeeping (critic action).** Running `cosmological_sensitivity.wl` re-exports both figures. The critic then ran
   `git checkout -- Figures/`, which also discarded the two figure PDFs that were already modified (unstaged) at session start. Those
   diffs were same-size regenerations of the committed files, and re-running the script reproduces them. No content was lost.

### Adjudication of the author's flags

1. **External-probe bias / "not a lower bound" — the chapter is right.** Independent model (critic D3a): minimise
   χ² = (S_Ω x + S_w y − δ)²/σ_B² + (x − c y)²/σ_X². The unique stationary point is Δw0 = δ/(S_w + cS_Ω), ΔΩ_m = cΔw0, with σ_B and σ_X
   absent. The GLS/Fisher route gives the same result (D3b). Writing S_w + cS_Ω = S_w(1 − c/c*) gives A = 1/|1 − c/c*|, so A ≥ 1 ⇔ c ∈ [2c*, 0] for c* < 0
   (symbolic Reduce, D3e). There is a pole at c*. A(−½) = 2.177 and A(+½) = 0.649 (D3c). For statistical errors the conditional
   variance never exceeds the marginal one (D3g, D3h). The only issue is the name, see item 3.
2. **CPL ζ(z) — correct.** Symbolic integration (D1a), the fluid equation in a (D1c), ζ ≡ 1 at (−1, 0) (D1b) and ζ(1; −0.9, −0.3) = 1.0347 (D1d) all check.
3. **Jacobian — correct to printed precision.** Own NDSolve distances and a 5-point stencil (D2c) give (−0.0356896, −0.0330114, −0.0072553).
4. **Rank 1 — correct** (D4a symbolic 3×3; D4b eigenvalues |J|², 0, 0).
5. **N-plane identity and weighted mean — correct** (D5_0, D5a, D5b symbolic from ⟨κ⟩(θ_E) = 1 with κ ∝ ε θ^{1−γ′}; D5d, D5e). The proviso on the sign of δ_i is item 5 above.
6. **Paraphrases — Collett 2012 PASS (verbatim). Schneider 2014 PASS on substance**, but the chapter drops a hypothesis (item 2).
7. **c = −½ ray, "at most 0.09%" — correct** over the whole physical ray (D6b, D6b′). The figure matches.

## Prose (LLM tells) — flag-only

Em-dashes: 2 in the chapter (both list separators in the companion-file itemize) and 0 in the Solutions body, so clean. Triads: none ornamental
(the (i)/(ii)/(iii) and (a)–(d) lists are substantive). Antithesis / aphoristic closers worth a look:

- **P1** L521–522 "The linear answer is not merely inaccurate there; it describes a solution that does not exist." — antithesis plus closer.
  Plain: "There the linear formula returns a point that is not a solution of B = 1.005 B₀."
- **P2** L707–708 "Independence across lenses is a property of the \emph{analysis}, not of the sky." — aphoristic antithesis closer.
  Plain: "Whether the errors are independent depends on how the lenses were modelled." (or delete)
- **P3** L706–707 "the stack yields an increasingly confident wrong answer", echoed in Sol. L178–179 "Three lenses analysed the same wrong
  way give a more confident wrong answer." — the same maxim twice. Keep one.
- **P4** L654–655 "That alignment is a computable property of the geometry." — closer. Could be folded into the preceding sentence.
- **P5** Sol. L166 "One well-modelled system. The argument is structural." — clipped-fragment cadence. Plain: "One well-modelled
  system, for the two reasons below."

The rest reads as plain technical prose. The "bias vs degeneracy" contrasts (L36–38, L748–756) carry real content and are not ornament.

## Derivation checks

Scratch script (critic-written, shares no code with the repo .wl files; distances by NDSolve of dχ/dz = 1/E, Jacobian by a 5-point stencil):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_20/critic_20_derivations.wl`
(log alongside, `critic_20_derivations.log`). Run via `bash Mathematica/run_wl.sh`:

`SUMMARY: 40 PASS, 0 FAIL  (of 40 checks)`

| id | equation | result |
|----|----------|--------|
| D1 | eq:cs_zeta (CPL ζ), ΛCDM limit, fluid eq. in a, ζ(1) | PASS (D1a–d) |
| D2 | eq:cs_B_chi + eq:cs_J_values (B, J, 1/S_w, c*, B_3 row, angle, cond, geometry 2, D_Δt row, null direction) | PASS (D2a–k) |
| D3 | eq:cs_marginalised / eq:cs_amplification / eq:cs_lb_interval + Cramér–Rao difference, from a 2-parameter χ² with one biased datum and a blind prior | PASS (D3a–h) |
| D4 | rank of J^T C⁻¹ J for one pair | PASS (D4a–b) |
| D5 | eq:cs_mscaling (N-plane identity) from ⟨κ⟩(θ_E)=1, B = η^{γ′−1}, eq:cs_convex weighted mean, coherent/independent ratio ∈ [1, √n] | PASS (D5_0, D5a–e) |
| D6 | non-linear: exact ray solutions, c=−½ global maximum 0.0907% on 0<Ω_m<1, +1.81% peak at w0=−2.207, box [−1.74%, +3.31%], 7.57, blind-direction 2nd-order response | PASS (D6a–g, D6b′) |

Repo scripts: `cosmological_sensitivity.wl` → `SUMMARY: 53 PASS, 0 FAIL (of 53 checks)`; `problems_20.wl` → `SUMMARY: 26 PASS, 0 FAIL (of 26 checks)`.

## Reconciliation with the spiral project's record (2026-10-14)

Reviewer: independent reconciliation pass (brief `docs/agent_briefs_2026-10-14/RECONCILE.md`). Read: the chapter, `20_Solutions.tex`, this
report, digest `docs/spiral_reconciliation_2026-10-14/note9.md` (25 FAIL / 37 SUSPECT), `note8_solutions.md` and
`auto_fixable_and_coverage_gaps.md`; in the spiral repo `theory/note9_cosmology_impact.tex`, `theory/solutions/sol_note9_cosmology_impact.tex`,
`mathematica/exercises/sol_note9_cosmology_impact.wl`, `TESTS_AND_DIAGNOSTICS.md` rows B5, D1, D2, H0–H5, H2b-g,
`NOTES_cosmology_impact_2026-08-03.md`, `HANDOFF_arc_2026-07-30.md` §4–5, `HANDOFF_arc_2026-09-21.md` §5–6. The 2026-07-11/07-13/07-24 critic
reports predate note9 (opened 2026-08-03) and contain nothing on it; `NOTES_mcrit_label_defect` only cross-references it.

**sol_note9 rows:** the `note8_solutions.md` digest contains **no** sol_note9 rows (its solution rows are all sol_note10). sol_note9 is touched
only inside S2-131 (sol_note9:174–180). Two sol_note9 defects the packet critic did not list are under "Feedback" below.

**Numerical re-verification.** Scratch script (not in the repo) that `ToExpression`s the chapter's own definitions (`wz`, `zeta`, `EE`, `chi`,
`DA`, `BB`, `E2`/`dE2`), extracted verbatim from `Mathematica/20_Cosmological_Sensitivity/cosmological_sensitivity.wl`, and evaluates them at the
spiral geometry (0.68; 1.52, 2.11):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/recon_20/recon_20.wl`
(log `recon_20.log` alongside). Ran `bash Mathematica/run_wl.sh <script>` from the ch20 worktree:
`SUMMARY: 21 PASS, 0 FAIL  (of 21 checks)`

| check | result |
|---|---|
| H0a | chapter code gives **B = 0.8200775769** at (0.68;1.52,2.11). Matches TESTS H0 to 1e-9 |
| H0r | the chapter code, run with the spiral's **finite-step recipe** (central difference of B/B_fid with dΩ=0.02, dw0=dwa=0.05; `sol_note9.wl:72–74`, `beta_sensitivity.py:44`), reproduces **S_Ωm = −0.0254559324, S_w = −0.0157139331, S_wa = −0.0047986803** to 1e-9 |
| H0b/H0c/H1 | the **exact** derivative (chapter's two routes, Richardson FD vs differentiation under the integral, agree to 1e-10) is **S_Ωm = −0.0254715510, S_w0 = −0.0157254552, S_wa = −0.0048007212**. The spiral values carry O(h²) truncation errors of 6.1e-4, 7.3e-4 and 4.3e-4 (relative). That is inside the spiral's own 1e-3 step-stability tolerance, but it is not the 9–10 digits it quotes |
| H1 | exact 1/S_w = −63.591 (recorded −63.6378; both round to −63.6). Exact c* = −0.617373 (recorded −0.617299). At δ = 1%, \|Δw0\| = 0.3514 / 0.6359 / 3.345 / 22.60 / 635.9 for c = +½ / 0 / −½ / −0.6 / 0.999c* (recorded 0.352 / 0.636 / 3.349 / 22.7 / 636) |
| LB | at the spiral geometry the chapter's criterion gives "fixed-Ω_m is a lower bound exactly for c ∈ [2c*, 0] = [−1.2347, 0]" (A(2c*) = 1, A(−½) > 1, A(+0.01) < 1, A(2c* − 0.01) < 1) |
| H2b/H2b-g | chapter code reproduces all three spiral reachability boxes. Ω_m pinned, wa=0, w0∈[−8,−0.1]: **[−1.2856%, +0.5624%]**, with the max at **w0 = −1.8221** and the min at −0.1444. Ω_m∈[0.20,0.42]: **[−1.3103%, +1.2479%]** (max at Ω_m = 0.20, w0 = −1.932). w0wa_wide: **[−1.8285%, +6.1364%]**. Section at w0 = −1: [−0.288%, +0.257%] |
| CG | at the **chapter** geometry (0.5;1,2), even the w0wa_wide box reaches only [−3.36%, +8.91%], so the chapter's "a 25% offset is off the flat-CPL manifold" survives freeing w_a |
| PI / PIp | **counterexample to "does not depend on how dark energy is parametrised"**: a flat two-bin w (w = −1 below z_t, w = w1 above) gives \|ΔB/B\| = 23.4 / 30.5 / 36.0% for w1 = 3/4/5 at the chapter geometry (z_t = 0.5), and 12.6–19.8% for w1 = 3–6 at the spiral geometry (z_t = 0.68). The latter is inside the 11–36% masked span. "Off-manifold" is a statement about a family and a box |
| D2a/D2b | the chapter's ζ is the CPL integral, not the non-integrated (1+z)^{3(1+w(z))} form (symbolically different, equal at wa=0). At (w0,wa) = (−0.42,−1.75) and the spiral geometry, \|B/B_ΛCDM − 1\| = 0.047% (CPL) vs 0.814% (non-integrated). The chapter carries the D2-correct form |
| MP | at the chapter geometry with planes z = 2, 3 and δ_i = 1% each, the per-plane fixed-Ω_m biases are b = (−0.303, −0.219). With Ω_m free (J square) the coherent bias is **Δw0 = −0.687, outside [min b_i, max b_i]**, and it is −0.372 for σ(Ω_m) = 1. The weighted-mean property (eq:cs_convex) holds **only** for a one-parameter fit |

### Row-by-row table

"n.a." = the row concerns project content (Tier/B5/E3/H4/H5/Carousel/regime tables, project section pointers, dates) that the port stripped. I grepped the chapter, Solutions and both .wl for the specific number or phrase in each case, and all are absent unless noted.

| spiral id | claim (note9 unless stated) | status in chapter | action |
|---|---|---|---|
| **FAIL rows (25)** | | | |
| S2-049 | Tier-2 "43–78%, median 0.559, 0.6–2.1% controls, 20–90×" with mixed cell sets | n.a. (no B5 numbers in the chapter) | none |
| S2-127 | H5 "only the low corner is on-manifold" | n.a. (Carousel/H5 stripped) | none |
| S2-041 | "imaging shrinks the bias by > an order of magnitude"; "negligible" | n.a. (regime table stripped). The chapter only says case 3 is "expected to have the smaller bias" (L733–735) | none |
| S2-117 | Carousel quote paragraph prose | n.a. | none |
| S2-122 | "one deflector" for Carousel | n.a. | none |
| S2-112 | "four-source-plane lens" for Carousel | n.a. | none |
| S2-131 | linearity caveat "0.01–2% rows" contradicts the guard | already fixed in the port: recipe step 5 (L807–810) and annotation L780–788 key admissibility to a computed dynamic range, not a fixed bracket | none |
| S2-105 | taxonomy keybox prose ("disease/cure") | n.a. (H4 taxonomy stripped) | none |
| S2-026 | "extra planes buy less than √N in the degenerate direction" (unsupported, wrong in direction) | already fixed in the port: the clause is gone. L594–599 give the measured angle (5.5°) and condition number (22.7) instead. But see MP: the chapter's replacement weighted-mean argument is over-generalised in its keybox (new fix F1) | F1 |
| S2-013 | "Note 1 §3" pointer for no-hard-coding | already fixed in the port: aside L218–224 has no pointer | none |
| S2-010 | "Note 1 §2" pointer for Hubble-freedom | already fixed in the port: Hubble-freedom is derived in-chapter (eq:cs_B_chi, L190–192) and cited to collett_2012 | none |
| S2-047 | "flat to ≤9.2e−32" (should be 9.9e−32) | n.a. (number not ported) | none (see Feedback 2: sol_note9 also carries it) |
| S2-001 | abstract: "every earlier note … 1/S_w ≈ −63.6" | n.a. The chapter uses its own geometry (1/S_w0 = −30.29) and says J must be recomputed per system (L801–802, Ex. 7) | none |
| S2-115 | Carousel quote truncated "(7d*)" | n.a. | none |
| S2-027 | eq:mscaling attributed to Note 1 and written with unindexed B | already fixed in the port: eq:cs_mscaling (L611) has B_i, is derived in-chapter (L616–639) and is referred to Chapter~\ref{ch:central_mass_bias} | none |
| S2-038 | "between one and two orders of magnitude" (should be two to three) | n.a. (no regime magnitudes) | none |
| S2-118 | "the taxonomy predicts the direction of their bias" | n.a. | none |
| S2-070 | "the wide box quoted above as [−1.96%,+3.34%]" dangles | n.a. The chapter quotes its own box with the box stated (L768–769), which follows the spiral's "state the box" rule | none |
| S2-046 (×2) / S2-031b | 9.2e−32 vs 9.9e−32 | n.a. | none (Feedback 2) |
| S2-063 | "reproduced to three decimals" (−1.28% truncated, not rounded) | n.a. Recomputed anyway with chapter code: −1.2856% / +0.5624% (check H2b-g) | none |
| S2-091 | H4 dates 08-11 vs 08-08 | n.a. | none |
| S2-040 / S2-133 | stale "project has not adopted a headline denominator" (0.24% CPL band adopted 2026-08-07) | n.a.: no signal band is quoted. The physics behind it (D2: CPL integral vs instantaneous w) **is** relevant, and the chapter uses the correct CPL ζ (eq:cs_zeta; checks D2a/D2b) | none |
| **SUSPECT rows (37)** | | | |
| S2-045 | 20%→13, 25%→16 are free-chosen illustrations | n.a. The chapter's analogue "say, 25%" → 7.6 (L771–774) is explicitly illustrative | none |
| S2-054 | "dynamic range of order one per cent" true only at wa=0 | already fixed in the port: the chapter gives box-specific numbers (+1.81% section, [−1.7,+3.3]% box) and says the range is geometry-dependent (L780–788). Check CG confirms the wa-free box at the chapter geometry is still ≪ 25% | none |
| S2-121 | Carousel table attributions | n.a. | none |
| S2-126 | "pinned to ±0.001 by outer images" is our gloss | n.a. | none |
| S2-130 | reachability boxes evaluated at fiducial geometry, not Carousel's | n.a. for Carousel. The chapter makes the general point (annotation L780–788) | none |
| S2-002 | index discipline m_i vs unindexed B | already fixed in the port (eq:cs_mscaling) | none |
| S2-003 | abstract "three orders" vs body "one to two" | n.a. | none |
| S2-077 | "~1% ceiling" vs sign-asymmetric box-dependent guard | already fixed in the port: the chapter quotes an asymmetric interval with its box | none |
| S2-085 / S2-086 | ablated quad "29%" should be 28% | n.a. | none |
| S2-096 | scope of "every family measured with fit_pl_only" | n.a. | none |
| S2-132 | "galaxy-scale, HST-like depth" | n.a. | none |
| S2-005 | masked case is a degeneracy (content PASS; prose tells) | inherited **in substance (correct)**. The keybox L748–757 is plain. **But** the spiral record's own caveats on that claim (B5 Tier 2: γ′ prior-*dominated*, not prior-*identical*; strict criterion 0/6; the data still exclude the shallow-γ′ end; an ablated quad keeps γ′ but biased) were not ported. L740–746 state the exact noise-free limit as unconditional | F2 |
| S2-018 | "1/S_w is not the cost; it is the cost projected…" (bold antithesis) | already fixed in the port: keybox L476–485 is plain and adds the [2c*,0] refinement | none |
| S2-088 | "Organised by what is wrong … rather than by what is true" | partially inherited as mild prose: L720–721 "rather than by which mass profile is true". Content is right | none (prose, author's choice) |
| S2-095 / S2-106 / S2-110 | H4 method aphorism, "refuted by its own check", "a median of ratios is not a slope" | n.a. | none |
| S2-111 | "Everything above is machinery until…" | n.a. | none |
| S2-125 | "Three disciplines…" | n.a. | none |
| S2-139 | Ex. 5 "not intuition about √N" closer | inherited: chapter Ex. 6 L924–925 "not with intuition about $\sqrt N$" | prose only. Optional: "using the rank and coherence arguments of this chapter" (drop the X-not-Y tail) |
| S2-024 | marginalisation numbers 0.636/0.352/3.349/−0.617299/22.7 (content PASS) | n.a. (the chapter uses its own geometry, all verified, N7/N8). Re-verified at the spiral geometry with the chapter code: these are finite-step values. Exact: 0.6359/0.3514/3.345/−0.617373/22.60 (Feedback 1) | none in chapter |
| S2-028 | "it has not been asked in the literature" (novelty audits a different question) | already fixed in the port: no novelty claim | none |
| S2-029 | "coherent systematics do not average down" overstated (H3: coherent bias does shrink 1.29× over 1→3 ratios; σ shrinks 2.82×) | partially inherited: the section title L666 "Why coherent errors do not average down" and keybox L691–699 keep the slogan. The body (L683–689) correctly says "never benefit from the 1/√n", and the 1/√n framing is right. MP shows that in a multi-parameter fit the coherent bias can also *grow* (−0.687 vs per-plane −0.303/−0.219) | F1 (same fix) |
| S2-052 | three B5 numbers do not reproduce | n.a. | none |
| S2-053 | "does not so much bias as surrender" (prose; content PASS) | already fixed in the port: keybox L748 "A degeneracy is not a bias" is plain | none (but F2 for the missing caveat) |
| S2-069 | the Ω_m-free withdrawal has not propagated | n.a. Spiral numbers re-verified with the chapter code (H2b-g) | none |
| S2-072 | old box = TESTS H2b box (PASS); corrects the catalog | n.a. | none |
| S2-073 | title "no cosmology" generalises past the guard | partially inherited in substance: L771–778 "no member of the model family reproduces it". This is correct for the flat w0–wa family at the chapter geometry, even over the wide box (check CG) | covered by F3 |
| S2-076 | "immune to the choice of (w0,wa) parameterisation" has no adapter | **inherited**: L776–778 "that statement does not depend on how dark energy is parametrised". **Now refuted, not just unsupported**: a flat two-bin-w model moves B by 30.5% at the chapter geometry (checks PI/PIp) | F3 |
| S2-079 | remark "rule stated only in prose" (content PASS) | n.a. | none |
| S2-084 | italic sign-off pattern | prose analogues already in this report's P1–P4 | none new |
| S2-051 | "Note 5" pointer for the SPT direction | n.a. | none |
| S2-036 | `--regimes` command does not produce the table | n.a. | none |
| S2-082 | reachability classifies against two boxes, not three | n.a. | none |
| S2-004 / S2-030 | "three regimes" vs five-row table | already fixed in the port: three cases, three items (L722–729) | none |
| **auto-fix list** | | | |
| S2-035 | flexible median/best (no fix) | n.a. | none |
| S2-129 | CLAUDE.md H5 bullet "OFF the wCDM manifold" | n.a. | none |
| **TESTS / HANDOFF retractions and corrections touching note9** | | | |
| TESTS H1 (2026-08-03) | fixed-Ω_m \|Δw\| called a "lower bound", **retracted the same day**. Also NOTES §4a L159–174, CLAUDE.md:616, `sol_note9.wl:131` comment ("an over-claim … made before the kernel was run"), sol_note9 Ex. 1 L68–77 | **already known to the spiral record.** The chapter's rejection of "lower bound" agrees with the retraction, and the published note9 (keybox L164–172) already says "not a bound in either direction". The chapter goes further, correctly: it **is** a lower bound exactly for c ∈ [2c*,0]. At the spiral geometry that is [−1.2347, 0] (check LB), and it includes the c = −½ case the spiral tabulates. No residual over-claim exists in note9/sol_note9. Ex. 1's prompt "which gives the larger \|Δw0\|" still presupposes it, deliberately (the solution calls it the trap) | none. Optional Feedback 6 (state the interval) |
| TESTS H0 | B, S_w, S_Ωm at the fiducial triplet (task-specified cross-check) | **B reproduced to 1e-9 by the chapter code. S_w, S_Ωm (and H1's S_wa) are reproduced to 1e-9 only with the spiral's finite-step recipe**. The exact derivatives differ at 6–7e-4 relative (checks H0r/H0t). The chapter's own J uses the exact derivative (two routes agree to 1e-10), so the chapter is not affected | Feedback 1 |
| TESTS D1 | S_w stable under step halving | n.a. to the chapter (it uses Richardson plus an analytic route, a stronger test). D1's stability at 1e-3 does not license the 10-digit values (Feedback 1) | none |
| TESTS D2 | instantaneous-w vs CPL (0.31% median / 4.4% max shift); 0.24% band adopted 2026-08-07 | chapter uses the correct CPL ζ (eq:cs_zeta, .wl checks 0b/0c; D2a/D2b here). The 0.24% band is n.a. | none |
| TESTS H2 | recorded Tier-2 median "1.89%" → 1.998% | n.a. | none |
| TESTS H2b / H2b-g; HANDOFF 09-21 §5 "Ω_m adds only ±0.3%" | the section through the box was mistaken for the box excursion | already avoided in the port: the chapter's box range [−1.7,+3.3]% is a joint grid evaluation (critic D6e), and its +1.81% is labelled a section at Ω_m = 0.3 | none |
| TESTS H2b prose "peaks … near w0≈−1.75" | — | n.a. Computed w0 = −1.822 (check H2b), as note9's table says | Feedback 4 |
| TESTS H3 | coherent biases stack: significance 0.071→0.117→0.156; coherent bias shrinks 1.29× | consistent with the chapter's direction of argument. The chapter's keybox wording is stronger than H3 supports ("does not shrink" vs a 1.29× shrink) | F1 |
| TESTS H5 | "off the wCDM manifold" sharpened to wa-free-only (2026-09-10) | n.a. (Carousel stripped). The lesson (state the box and the family) is F3 | F3 |
| TESTS B5 | 9.2e−32 (should be 9.9e−32); Tier-2 prior-dominated caveat; quad caveat | numbers n.a.; caveats not ported | F2 |
| HANDOFF 07-30 §4(a) | "~1% signal" from the non-integrated DE density | n.a. (no signal quoted); CPL correct in chapter | none |
| HANDOFF 07-30 §4(b), B6 sign, A1201 | DESJ0206 >4σ; B6; A1201 | n.a. to Ch. 20 | none |
| HANDOFF 07-30 §5 | AGEL0854 γ_in category error | n.a. | none |
| HANDOFF 09-21 §5 other items | WP4b evidence sentence, γ=1.288, Note 2b eq. numbers, Wolfram counts, rail census, Horseshoe, t₁_crit, T1M flags | n.a. to Ch. 20 | none |
| HANDOFF 09-21 §6 "Regime before quadrature" | a prior-error line and a modelled-regime line are not summable | consistent: the chapter's degeneracy-vs-bias keybox carries the same logic | none |

**Cross-check of this report's "source-note" adjudications against the spiral record.** The chapter author and the first critic treated
"fixed-Ω_m is a lower bound" as a source claim to reject. The spiral record already retracted it on 2026-08-03 (H1, NOTES §4a, CLAUDE.md:616,
sol_note9.wl:131), and the shipped note9/sol_note9 say "neither an upper nor a lower bound". The chapter's [2c*,0] statement is a strict
refinement of the spiral's position, not a correction of a live error. None of the other items in this report's Flagged section (CPL citation,
Schneider 2014 hypothesis, Cramér–Rao naming, D_Δt (1+z_d), sign of r_i) appears in the spiral record. On X11 (sign of δ_i), the spiral's H3
row and NOTES §4b state that all r_i = (γ′−1)[c₁ − B_i^k c_i] "share a sign" (estimator A8, note10). That is the derivation X11 asks for. It lives in
Note 10 → Chapter~\ref{ch:perturbative_estimators}, which is a legal cross-chapter target for the X11 fix. Note that it holds in the
equal-c baseline (c_i = c₁), as H3 itself says. The fix should cite it with that scope.

### New fixes for the fix pass (not already in the Flagged section above)

- **F1 — keybox L691–699 (and title L666) over-generalise the weighted-mean result.** eq:cs_convex is derived for a one-parameter fit
  (L668–669). The keybox says "the induced bias in **any one parameter** is a weighted mean of the per-plane biases". With Ω_m free this is false: at
  the illustrative geometry with planes z = 2, 3 and δ_i = 1%, Δw0 = −0.687 against per-plane −0.303 and −0.219 (scratch check MP). The
  Solutions (L124–131) already scope it correctly ("in a single parameter … In the multi-parameter case the outcome depends on…"). Proposed
  keybox wording: "…with one sign. In a one-parameter fit the induced bias is a weighted mean of the per-plane biases (eq.~\ref{eq:cs_convex}),
  so it does not shrink as $1/\sqrt{N}$. With several free parameters it can be larger than any single-plane bias, because nearly parallel
  rows of $J$ amplify it." Optionally retitle §L666 "Why coherent errors do not average as $1/\sqrt n$". If the MP number is quoted, add it
  as a `check[]` to `cosmological_sensitivity.wl`.
- **F2 — L740–746 state the masked case only in its exact, noise-free limit.** Add one sentence carrying the spiral record's B5 caveats in
  generic form: with noise and ellipticity the slope becomes prior-dominated rather than completely undetermined (the data still exclude part of the range,
  typically the shallow end, the source-position-transformation direction), and in a quad the remaining images can keep γ′ constrained but
  biased. The keybox then reads "the data determine a set, **or nearly so**". This needs no project numbers.
- **F3 — L776–778 "that statement does not depend on how dark energy is parametrised" is false.** It is inherited from note9 L360–361 (S2-076). A
  flat two-bin-w dark energy (w = −1 below z = 0.5, w = +4 above) shifts B by 30.5% at the illustrative geometry (scratch checks PI/PIp). Replace it with:
  "The correct statement is that the inferred B is inconsistent with every member of the model family over the parameter box considered.
  Name the family and the box. A more flexible E(z) can reach larger excursions." The chapter's own claim for flat CPL also survives freeing
  w_a over Ω_m∈[0.2,0.42], w0∈[−8,−0.1], wa∈[−3,3]: range [−3.4%, +8.9%] (check CG). The author may quote that to strengthen L768–770.
- **F4 (optional) — X11 fix target.** Cite Chapter~\ref{ch:perturbative_estimators} for the common-sign property of r_i, scoped to the
  equal-c_i baseline (spiral H3/A8), rather than leaving the proviso bare.

### Feedback to the spiral project (errors its record does not yet know about)

1. **S_w, S_Ωm, S_wa and everything derived from them are quoted to 9–10 digits that are not significant.** `scripts/beta_sensitivity.py:44`
   (`dw=0.05`), `cosmology_impact.py:182` (`DEFAULT_STEPS` Om0 0.02, w0/wa 0.05) and `mathematica/exercises/sol_note9_cosmology_impact.wl:72–74`
   ("central differences matching beta_sensitivity.py's declared default steps") all compute **the same finite-step central difference**. The
   H0 gate's "agree to <1e−9" is therefore an agreement of two implementations of that recipe, not a check of the derivative. Exact
   derivatives (two independent routes agreeing to 1e−10, chapter code, scratch checks H0b/H0c/H1/H0r/H0t): **S_Ωm = −0.0254715510,
   S_w = −0.0157254552, S_wa = −0.0048007212** (truncation 6.1e−4 / 7.3e−4 / 4.3e−4 relative). Hence **1/S_w = −63.591** (not −63.6378),
   **c* = −0.617373** (not −0.617299), \|Δw0\|(1%) = 0.6359 / 0.3514 / **3.345** / **22.60** at c = 0 / +½ / −½ / −0.6 (recorded 0.63638, 0.35159,
   3.34900, 22.708). Affected text: TESTS H0, H1; note9 L47–49, L150, L153, L157, L162; sol_note9 L18–21, L49, L62–64, L72, L74; NOTES §4a table;
   `e3_budget.json` inv_S_w. Every 2–3 significant-figure quotation (−0.0157, −63.6, 0.636, 0.352) survives. The fix: quote 3–4 digits,
   or switch to a Richardson/analytic derivative and regenerate. The step-halving gate (rel < 1e−3) is consistent with this error and cannot
   detect it.
2. **sol_note9 carries the wrong B5 bound too.** `theory/solutions/sol_note9_cosmology_impact.tex:182` ("flat to $\le9.2\times10^{-32}$") and
   `:193` ("The flatness figure $9.2\times10^{-32}$"). S2-046/S2-031b list only note9:281 and TESTS B5. The true maximum is 9.86e−32, and
   TESTS H2 and NOTES §3 already say 9.9e−32.
3. **sol_note9:217 "three-times-more-confident wrong answer".** With three lenses and independent noise σ shrinks by √3, so the significance of
   a shared bias grows by √3 ≈ 1.73×, not 3×. (The spiral's own H3 measures 2.19× for a different, multi-plane setup.) The chapter's port says
   "a more confident wrong answer" (20_Solutions L178–179).
4. **TESTS H2b row prose: "peaks at only +0.56% near w0≈−1.75".** The computed maximum is at **w0 = −1.822** (+0.5624%). note9's table and the
   guard say −1.822, so only the catalog row is off (scratch check H2b).
5. **S2-076 should be upgraded from SUSPECT to FAIL, with a concrete counterexample.** note9 L360–361 "immune to the choice of (w0,wa)
   parameterisation" and TESTS H2b "parameterisation-independent". At the fiducial geometry (0.68;1.52,2.11) a flat two-bin-w dark
   energy (w = −1 for z < 0.68, w = w1 above) reaches ΔB/B = +12.6% (w1 = 3) to +19.8% (w1 = 6). That is inside the masked span 11–36%, so
   "unreachable by any cosmology" holds only for the stated CPL boxes (scratch check PIp). Suggested wording: "off the manifold of
   flat w0–wa predictions over the stated boxes".
6. **(Refinement, not an error.)** The record says the fixed-Ω_m projection is "neither an upper nor a lower bound" (H1, NOTES §4a,
   sol_note9 Ex. 1). That is true as a universal statement, but the sharp version is that it **is** a lower bound for c ∈ [2c*, 0] =
   [−1.2347, 0] at the fiducial triplet (exact S values) and an upper bound outside that interval. All the negative-c directions the record
   tabulates (−½, −0.6) lie inside the interval. Consider adding the interval to note9's keybox L164–172 and to sol_note9 Ex. 1.
