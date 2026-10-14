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
