# Audit Handoff — Pre-Expert-Review Pass
**Date:** 2026-05-14
**Scope:** All 14 modules (Notes + Mathematica + Solutions + Figures)

---

## TL;DR

Triggered by your observation that Figure 8.1 (`lensing_geometry.pdf`) had the
θ-arc on the wrong side of the optical axis. Confirmed and fixed (see #1
below), then ran a full audit pass with five parallel agents covering Modules
1a–1e, 2–4, 5–6, 7–8, 9–10.

**Result:** **17 trivial fixes applied directly** (clear arithmetic / sign /
labeling errors), **~20 substantive findings flagged for your judgment** below.
Master verification (`verify_against_textbooks.wl`) still passes 12/12 after
all fixes.

The single most important fix was: **Modules 3 and 4 were giving two different
θ_E for the same canonical example** (M=10¹²M☉, z_d=0.3, z_s=1). Module 3 had
2.4″ (correct); Module 4 was using inflated distances and got 1.1″ (wrong).
Now all consistent at 2.4″.

---

## Section 1: Trivial fixes applied directly

These are things an expert reviewer would call obvious errors — applied without
further review:

### Figure 8.1 — the original report
- `Mathematica/04_Lens_Equation/lens_equation.wl:277-283` — θ-arc range
  changed from `{Pi/2 - 0.01, Pi/2 + ArcTan[1.5/5]}` (drew arc to the *left*
  of the optical axis, where there's no image) to
  `{Pi/2 - ArcTan[1.5/5], Pi/2}` (correct: arc opens to the right, toward
  the image at `(1.5, 5)`). `lensing_geometry.pdf` regenerated.

### Module 1c (Schwarzschild)
- `Notes/01c_Schwarzschild/01c_Schwarzschild.tex:139` — broken cross-reference
  `\ref{sec:geodesics}` → `\ref{sec:geodesic_equation}`.
- Across 01c .tex/.wl/Solutions: spelling "Kretschner" → **"Kretschmann"**
  (named after Erich Kretschmann; the misspelling appeared in labels, refs,
  comments, and a variable name).
- `01c_Schwarzschild.tex:594-600` — **isotropic Schwarzschild weak-field
  expansion** had a factor-of-2 error: `(1+R_S/(4ρ))^4 ≈ 1+R_S/(2ρ)` (wrong)
  → `1+R_S/ρ` (correct). The temporal factor `[(1-R_S/(4ρ))/(1+R_S/(4ρ))]² ≈
  1-R_S/ρ` was similarly fixed. This is the substantive fix needed to match
  the surrounding `2Φ/c²` identification.

### Module 1d (Geodesics & Orbits)
- `01d.tex:268-274` — Mercury perihelion-precession equation,
  second equality `=6πGM/(L²/(GM))` → `=6πG²M²/(c²L²)` (missing `1/c²` factor
  restored).
- `01d_Solutions.tex:191-195` — Exercise 1.5(a): `V_eff(12) = -1/24` was
  wrong; correct is `-1/27`. Also cleaned a "scratched-out" computation block.
- `01d_Solutions.tex:124-130` — Exercise 1.3: chained arithmetic gave
  `-2L²/81`; correct is `-L²/81` (stability conclusion unchanged).
- `problems_01d.wl:196` — matching print string fix.
- `problems_01d.wl:201` — Wolfram syntax error: `Print["…");` → `Print["…"];`
  (would have failed at runtime).

### Module 1e (Linearized Gravity)
- `01e_Linearized_Gravity.tex:717-719` and `01e_Solutions.tex:105-107` —
  awkward "$h_{00}=h_{ij}/\delta_{ij}$" rephrased to the clearer
  $h_{00} = h_{xx} = h_{yy} = h_{zz}$.

### Module 2 (Light Deflection)
- `Mathematica/02_Light_Deflection/deflection_angle.wl:280-296` — Fixed
  `deflection_geometry.pdf`: incoming ray was starting to deflect from
  outside the lens region; Bézier control points caused the deflected ray
  to loop upward at (1.5, 4.2). Replaced with monotonically descending
  control points + straight incoming ray. Figure regenerated.

### Module 3 (Cosmological Distances)
- `friedmann_equations.wl:316-317` — `Efunc` was missing the curvature
  term `(1-Ωm-ΩL)(1+z)²`. Without it, the "Open" curve in
  `DA_vs_z.pdf` was wrong. Now includes Ωk(1+z)². Figure regenerated.
- `friedmann_equations.wl:461` — comment claimed θ_E ~ 1″ for the canonical
  galaxy example; actual value is ~2.4″. Fixed.
- `03.tex:223` — cleaned half-finished Christoffel parenthetical that read
  like a scratch computation.
- `03.tex:847-852` — **D_ds remark numerical example**: the whole point of
  the remark is that D_ds ≠ D_s − D_d, but the numerical values were
  inconsistent. Fixed from `D_d=1260, D_s=1740, D_ds=1450, D_s−D_d=480`
  to `D_d≈1259, D_s≈1727, D_ds≈1097, D_s−D_d≈468` (computed in
  `friedmann_equations.wl`).
- `03.tex:833-841` — the "general non-flat D_ds" formula reduced to
  `1−k` (garbled) and the "(symmetric term)" was never expanded.
  Replaced with the correct Hogg (1999) eq.~19 form using
  $D_M(z), D_H, \Omega_k$.

### Module 4 (Lens Equation) — THE CANONICAL EXAMPLE FIX
This is the most-cited inconsistency in the audit:

- `04.tex:347-367` — galaxy σ_cr example. Distances 900/1700/1200 → 919/1652/1055
  Mpc (Module 3 authoritative). σ_cr: 0.35 g/cm² → **0.59 g/cm²**; 1700 →
  **2840 M_⊙/pc²**; 3.5 → **5.9 kg/m²**.
- `04.tex:495-520` — galaxy and cluster Einstein radius examples.
  - Galaxy (M=10¹²M_⊙): distances 900/1700/1200 → 919/1652/1055; θ_E:
    **1.1″ → 2.4″**.
  - Cluster: was claimed M=10¹⁵M_⊙ but the formula+distances gave 35″, not
    self-consistent. Re-stated as point-mass-equivalent M_E ~ 2×10¹⁴M_⊙
    *within the Einstein radius*, with distances 919/1727/1329 → θ_E ≈ 37″.
    Added a one-paragraph clarification that M_200 ~ 10¹⁵M_⊙ for the full
    cluster, but most of that sits outside R_E; the NFW treatment in
    Module 10 yields the same number self-consistently.
- `04_Solutions.tex:122-143` — Exercises 4.3(b),(c) updated to match
  (galaxy: 2.4″, R_E ≈ 10.6 kpc; cluster: 37″, R_E ≈ 165 kpc).
- `04_Solutions.tex:159-176` — Ex 4.4 σ_cr values updated:
  galaxy 3.5 → 5.9 kg/m²; cluster 3.0 → 4.9 kg/m²; convergence
  example 3 → 1.8.
- `04_Solutions.tex:185-203` — Ex 4.5 magnification table. The β=0.1 row
  said |μ_+|=5.13, |μ_-|=4.63 — doesn't satisfy the exact identity
  |μ_+|−|μ_-|=1. Corrected to 5.519/4.519 (and added an explicit reminder
  of the identity in the caption). Other rows tightened to three decimals
  to be unambiguous.
- `Mathematica/04_Lens_Equation/lens_equation.wl` and
  `Solutions/04_Lens_Equation/problems_04.wl` — `(b)` and `(c)` distance
  values updated to match Module 3 authoritative values. **All figures
  regenerated.**

### Module 5 (Magnification, Convergence, Shear)
- `05.tex:595` — stray "/1" in delta-function term: `\frac{π θ_E²}{1} δ²` →
  `π θ_E² δ²`.
- `lensing_potential.wl:414` — **shear field figure** was drawing radial
  shear sticks instead of tangential (a stray `+ Pi/2` in `gAngle`).
  Removed. `shear_field.pdf` regenerated and now correctly tangential.

### Module 6 (Fermat & Time Delays)
- `06.tex:322-332` — **Burke's theorem remark** had a real physics error:
  claimed point-mass lens produces "two bright images plus one highly
  demagnified image at the center". A point mass has only TWO images
  (Burke's theorem requires a smooth, bounded Σ; the δ-function Σ of a
  point mass violates the hypothesis). Rewrote to say so explicitly, and
  to point out that the third image appears only when the central
  singularity is softened (e.g., NIS in Module 7).
- `06.tex:376-378` — "formal maximum at θ=0" for point mass was misleading
  (the origin is a *singularity*, not a stationary point of τ). Rewrote.
- `06.tex:791-814` — **Exercise 6.4 numerical inputs gave unphysical
  H_0 ≈ 218 km/s/Mpc**. Changed Δt = 420 days → 100 days and
  τ_diff = 25 arcsec² → 2 arcsec², which now gives H_0 ≈ 73 km/s/Mpc
  (sits squarely on H0LiCOW / SH0ES, in tension with Planck).
- `06_Solutions.tex:132-189` — corresponding rewrite of the worked solution.
- `Solutions/06_Fermat_Time_Delays/problems_06.wl:220-235` — matching .wl
  update.

### Module 7 (Axisymmetric Models)
- `problems_07.wl:113` — Wolfram syntax error (mismatched bracket).
- Three captions in `07.tex` rewritten to match the figures they describe
  (`nis_critical_curves.pdf`, `nfw_profiles.pdf`, `model_comparison.pdf`).

### Module 8 (Elliptical Models & Caustics) — THE OTHER BIG ONE
- `08.tex:442-460` and `08.tex:539-545` — **SIE critical-curve orientation
  text was WRONG**: claimed the tangential critical curve and caustic are
  elongated *perpendicular* to the mass major axis. Direct calculation
  (and the figures themselves) shows they are elongated *along* the mass
  major axis. Rewrote both passages to state the correct orientation
  explicitly, with the crossing radii θ_E/√q and θ_E√q called out.
- `08_Solutions.tex:105-117` — same correction in Exercise 8.2.
- `08.tex:761-779` — **Stage 1 of the source walk** claimed a singular SIE
  produces only 1 image far outside the caustic. Correct count is 2
  (the singular profile suppresses the *central* image, not the
  secondary). Rewrote.
- `08.tex:919-944` — disambiguated $\mu_{\rm total}$ in the cusp scaling
  vs the cusp relation. The divergence is in the sum of UNSIGNED
  magnifications, $|\mu_A|+|\mu_B|+|\mu_C| \propto d_\perp^{-1}$; the
  cusp relation is on the SIGNED sum, $\mu_A+\mu_B+\mu_C \to 0$.
- `08.tex:1129-1135` — **"Cusp configuration" example** was placing the
  source at β=(0.15,0) for q=0.7, claiming "near a cusp". The actual cusp
  on the β_1-axis is at β_1 ≈ 0.265 θ_E, so 0.15 sits well *inside* the
  caustic (it's a quad, not a cusp triplet). Moved the example to
  β=(0.25,0).
- `critical_curves_caustics.wl:498-502` — matching `.wl` update; the
  "Cusp" panel in `image_configurations.pdf` now actually shows a cusp
  triplet. **Figure regenerated.**
- `08_Solutions.tex:826-836` — caption "red squares" → "red dots"
  (the figure uses red filled circles).

### Module 9 (Galaxy Lensing Applications) — THE H₀ SIGN FIX
- `09.tex:381-407` — **MST H_0 relation had its sign reversed** vs the
  standard Birrer+2020 / TDCOSMO convention.
  Was: $\Hubble^{\rm inferred} = \lambda\,\Hubble^{\rm true}$ (predicts
  inferred < true for λ<1).
  Correct (Birrer+2020):
  $\Hubble^{\rm true} = \lambda\,\Hubble^{\rm naive}$
  (equivalently $\Hubble^{\rm naive} = \Hubble^{\rm true}/\lambda$). An
  unmodeled positive mass sheet (λ<1) makes the *naive* analysis
  *overestimate* H_0, and including the sheet shifts the inferred H_0
  *downward* toward Planck. Rewrote the boxed equation, the preceding
  prose, and the remark.
- `09_Solutions.tex:160-170` — Exercise 9.3(c) rewritten to match.
- `Mathematica/09_Galaxy_Lensing_Applications/galaxy_lensing.wl:230-240`
  — corresponding print statements corrected.
- `galaxy_lensing.wl:626-688` — Figure 4 (`h0_time_delay.pdf`) labels
  updated. Left panel now plots $\Hubble^{\rm true} = \lambda \cdot 73.3$
  (still a positive slope; λ<1 gives lower H_0, toward Planck — which is
  the physics). Right panel time-delay curve for λ=0.95 also sits below
  the λ=1 curve (model-predicted Δt at fixed H_0). **Figure regenerated.**
- `problems_09.wl:285-302` — corresponding update.

### Module 10 (Cluster Lensing) — Ex 10.1 was internally wrong
- `cluster_lensing.wl:300` — NFW `α` ray-tracing had factor 4 → corrected
  to factor 2 (matches `alphaNFW` definition in Section 1 of the same
  file). `giant_arc_formation.pdf` β=0 panel now actually shows the
  Einstein ring (was empty before because the factor-4 bug placed it
  outside the plot range).
- `problems_10.wl:72-73, 158` — same factor-4 → factor-2 in
  `kbarNFW`, `alphaNFW`, and the Ex 10.2 ray-tracing.
- `nfw_cluster.nb:81, 92` — same factor fix in the Manipulate notebook.
- `10_Solutions.tex:15-64` — **Exercise 10.1 numerical answers were
  internally inconsistent and wrong**:
  - $\rho_{\rm crit}(z=0.3)$: 5.3e-27 → **1.25e-26** kg/m³ (the former
    is below $\rho_{\rm crit,0}$, which is physically impossible in a
    matter-dominated era).
  - Critical-curve equation: factor 4 → **factor 2** (matches main-text
    eq. and the now-fixed .wl).
  - $\theta_E$: 27″ → **7.4″** (consistent with
    `einstein_radius_vs_mass.pdf` which already showed ~8″ at this mass).
  - $M(\theta_E)$: 1.4e14 → **7.5e12** M_⊙.
  - $M(\theta_E)/M_{200}$: 0.28 → **0.015** (1.5%; the NFW $1/r$ inner
    profile means little mass is enclosed at $R_E$).
- `10_Solutions.tex:90` — "$\theta_E \approx 27''$" → "$\theta_E \approx 7.4''$"
  (the same cluster).
- `10_Solutions.tex:144-170` — Exercise 10.4 SIS Einstein radii. Old
  values were off by ~10% in arcsec and the intermediate rad values
  were off by factor ~3 (likely a c≈3×10⁵ vs c=2.998×10⁵ typo
  compounded). Replaced with the `problems_10.wl` outputs: 1.44″ /
  5.77″ / 33.2″ and M_E ≈ 2.9e11 / 4.6e12 / 1.5e14 M_⊙.

---

## Section 2: Substantive findings flagged for your review

These need physics judgment and are NOT auto-fixed. File:line locations
and recommendations below.

### HIGH-priority (an expert reviewer will probably notice)

**H1 — Module 5 Solution 5.4(c) muddled $\mu_-$ sign argument.**
`05_Solutions.tex:180-208`. The argument shows $(u^2+2)/(2u\sqrt{u^2+4}) > 1/2$
correctly, concludes "$\mu_- > 0$", then "rescues" with a flawed argument
about $\theta_- < 0$. The exercise statement at 558 doesn't tell the
student whether $\mu_\pm$ in the formula is *signed* or *unsigned*.
Recommended rewrite: state up front that $\mu_\pm = (u^2+2)/(2u\sqrt{u^2+4}) \pm 1/2$
is the *signed* magnification, show $|\theta_-| < \theta_E$ via
$|\theta_-| = (\sqrt{u^2+4}-u)/2 \cdot \theta_E < \theta_E$ for $u>0$,
hence $\theta_-^4 < \theta_E^4$ and the denominator of $\mu=\theta^4/(\theta^4-\theta_E^4)$
is negative.

**H2 — Module 8 SIS+shear caustic formula in problems_08.wl is wrong.**
`Solutions/08_Elliptical_Models_Caustics/problems_08.wl:166-185` and
`08_Solutions.tex:74-82`. The simplified mapping
```
causticSISShear1[phi_] := -gext * thc * Cos[phi]
causticSISShear2[phi_] :=  gext * thc * Sin[phi]
```
is missing the SIS contribution to the deflection. The correct mapping
involves $(\theta_{\rm crit} - \theta_E)$ terms. The solutions report
cusps at $|\beta_1| \approx 0.092$, $|\beta_2| \approx 0.112$; the
correct values (for $\theta_E=1$, $\gamma_{\rm ext}=0.1$) are
$|\beta_1| \approx 0.182$, $|\beta_2| \approx 0.222$ (and Exercise
8.1(d) caustic area follows). Recommend re-deriving and replacing.

**H3 — Module 8 `magnification_map_sie.pdf` orientation inconsistent with
`sie_critical_caustic.pdf`.**
Same q=0.7 SIE model: the map shows the bright ring elongated *vertically*
(along $\theta_2$), the explicit critical-curve plot shows it elongated
*horizontally* (along $\theta_1$). The latter is analytically correct.
Possible causes: DensityPlot axis flip, signed-vs-unsigned magnification,
or stale cached export. Suggest re-running
`critical_curves_caustics.wl` and inspecting; if the inconsistency
persists, audit the `DensityPlot` block (~line 380-410). Did not
investigate further to avoid touching the same `.wl` parallel agents
had open.

**H4 — Module 7 + 8 figures: `<>`-string-concat rendering artifacts.**
Many figures (`sis_images_magnification.pdf`, `nis_critical_curves.pdf`,
`nfw_f_function.pdf`, `nfw_profiles.pdf`, `nis_convergence_profiles.pdf`,
`model_comparison.pdf`, `fold_cusp_magnification.pdf`) display literal
`<>` glyphs in axis/legend labels. This is the documented pattern from
`feedback_mathematica_figures.md`: `Subscript[...]` boxes concatenated
with strings via `<>`. Fix throughout: use `Row[{Subscript["θ","E"], " / ", ...}]`
instead. Affects ~20 lines in
`Mathematica/07_Axisymmetric_Models/axisymmetric_models.wl` (lines 266,
269, 283, 286, 299, 303, 311, 338-345, 389, 420-421, 460-461, 497, 537,
574-575, 582) and `critical_curves_caustics.wl:456-481`. The fix is
mechanical but tedious; flagging rather than applying because the visual
side-effects of a global `Row[]` rewrite want a human eye.

### MED-priority (worth fixing but not embarrassing)

**M1 — Module 1d Kerr ergosphere inner bound wrong.**
`01d_Geodesics_Orbits.tex:361-363`. Text gives inner bound as $R_S/2$;
should be the outer horizon $r_+ = (R_S + \sqrt{R_S^2 - 4a^2})/2$.
$R_S/2 = M$ only at extremal spin. Recommend rewriting as
"outer horizon < r < static limit".

**M2 — Module 1e Solutions scratchpad block left in published .wl.**
`problems_01e.wl:174-194` contains a "Wait — this gives 8GM/(c²b), not
4GM/(c²b). The issue is …" stream-of-consciousness comment block.
Inside a Mathematica `(* ... *)` so the script runs, but unprofessional
in a published solutions file. Recommend stripping to keep only the
clean final explanation.

**M3 — Module 1e `deflection_comparison.pdf` photon-sphere label.**
The orange dashed vertical is labeled "Photon sphere" at b/R_S = 1.5
(the photon-sphere *radius*). In a plot vs *impact parameter*, the
relevant boundary is the capture impact parameter $b_{\rm crit} = (3\sqrt{3}/2) R_S
\approx 2.598\, R_S$. Either move and relabel, or remove. Also: the blue
("exact") curve has a visible gap around b/R_S = 12-20 — likely an
`NIntegrate` glitch.

**M4 — Module 3 Exercise 3.5(d) self-contradictory.**
`03_Solutions.tex:223-234`. First claims θ_E has a maximum at z_d ≈ 0.3-0.4;
two sentences later: "θ_E approaches zero as z_d → 0…" then "actually
diverges as z_d → 0". The figure `einstein_radius_vs_zd.pdf` correctly
shows θ_E monotonically decreasing, with $\theta_E \to \infty$ at z_d=0
(because $D_d \to 0$). The exercise was probably meant to ask about the
*lensing efficiency* $D_d D_{ds}/D_s$, which has an interior maximum.
Recommend rewording the exercise to ask about $R_E = D_d \theta_E$
(or the efficiency), and rewriting the answer cleanly.

**M5 — Module 5 `magnification_map.pdf` is 58 MB.**
Generated by `lensing_potential.wl:376-399` as a `DensityPlot` without
rasterization. Per `feedback_mathematica_figures.md`, rasterize
DensityPlots. The figure isn't included in the .tex but bloats the repo.

**M6 — Module 7 NIS 3D density not stated.**
`07.tex:938`. Table 7.1 references $\rho(r) \propto (r^2+r_c^2)^{-1}$
for NIS but the 3D profile is never derived in §7.5.1. Add one line.

**M7 — Module 7 SIS opposite-side image formula vector/signed.**
`07.tex:410-411`. Parenthetical about $\beta = -\theta - (-\theta_E)$ is
sign-convention-dependent and confusing. Recommend rewriting in
explicit signed-vector form.

**M8 — Module 9 left panel of `mass_sheet_degeneracy.pdf` no legend.**
Right panel has a μ-vs-λ legend; left panel (κ-profile family) does not.
Add `PlotLegends` in `galaxy_lensing.wl:502-524`.

**M9 — Module 10 cluster κ_s in main text inconsistent with .wl.**
`10.tex:160-176` quotes κ_s ≈ 0.52 for the M_200=10¹⁵, c=5 example, but
the .wl (now factor-2-fixed) gives 0.42. Probably a residual factor-2
or distance-mismatch. Cross-check against `cluster_lensing.wl` Section 2
output and reconcile.

**M10 — Module 6 Solution 6.4 "Middle" label.**
`06.tex:289`. Table 6.1 row II ("saddle") is described as arriving in
the "Middle" of arrival order; for a point mass (the running example
in the chapter) the saddle is the *last* image, not the middle.

### LOW-priority (style / polish)

**L1 — Module 1b `R^φ_θφθ` derivation chain.**
`01b.tex:631-635`. The "(-1)(-1)" symmetry chain is opaque. Write
$R_{\phi\theta\phi\theta} = -R_{\theta\phi\phi\theta} = +R_{\theta\phi\theta\phi}$
explicitly.

**L2 — Module 1c `R_S` vs `R_s` capitalization** inconsistent between
main and Solutions.

**L3 — Module 1c Einstein equation convention** (with/without $c^4$)
varies between 1a, 1b, 1c.

**L4 — Module 1d `effective_potential_photon.pdf`** y-range cuts off
photon-sphere peaks for L=3,4,5.

**L5 — Module 1e `refractive_index.pdf`** stray "Solar limb" label
floating mid-plot.

**L6 — Module 1e caption "indistinguishable for $b/R_S \gtrsim 5$"** —
figure actually shows separation out to ~30.

**L7 — Module 2 Shapiro `ln|θ|` sign ambiguity** — recommend
$\ln(\theta_{\rm ref}/|\theta|)$ with a footnote on the additive constant.

**L8 — Module 5 caption "to first order"** — clarify "to leading order
in $|\gamma|$".

**L9 — Module 6 Morse remark** could pedagogically note that at a fold,
a (min + saddle) or (max + saddle) pair merges.

**L10 — Module 9 figure includes λ=1.1 and 1.2** — physically $\lambda
\in (0,1]$. Add a one-line caveat.

**L11 — Module 10 cosmic-telescope quantitative claim** ($z\sim10$ →
$z\sim3-4$ via μ~1000) is on the aggressive side. Typical cluster
magnifications are 10-100; consider tightening to "μ~1000 regions".

**L12 — Module 10 Earendel μ ≳ 4000** — Welch+2022 published range is
1000-40000. Consider "μ ~ 1000-10000".

---

## Section 3: Verification status

- **Master verification** `Mathematica/verify_against_textbooks.wl`:
  **PASSES 12/12 after all fixes.**
- All affected per-module `.wl` scripts re-run and figures regenerated.
- Both PDFs (student + instructor) rebuilt via `Notes/build.sh`.

## Section 4: Files modified

(See `git status` and `git diff` for the canonical list.)

## Section 5: Next steps

1. **You read this doc, decide which substantive findings to apply.**
2. For each accepted finding, edit the relevant file directly (most are
   single-paragraph edits).
3. Re-run the relevant `.wl` scripts to regenerate any affected figures
   (in particular: H2 fix → regenerate `Mathematica/08...` figures; H3
   investigation; H4 → regenerate all of 07's figures + a couple of 08).
4. Re-run `Notes/build.sh` and re-check page counts.
5. Re-verify with `wolframscript -file Mathematica/verify_against_textbooks.wl`.
6. *Then* send to the expert reviewer.
