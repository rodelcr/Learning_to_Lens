# fact-critic report: Module 06 (Fermat / time delays), Annotated Study Edition layer

> Date: 2026-10-14 · Critic: independent pass, not the layer's author.
> Scope: boxes added in commit 0bed817 (`git diff c588432 0bed817 -- Notes/06*`) in
> `Notes/06_Fermat_Time_Delays/06_Fermat_Time_Delays.tex`, `06_Solutions.tex`, the appended
> A-checks of `Solutions/06_Fermat_Time_Delays/problems_06.wl`, plus the author's flags on
> pre-existing visible text (items 1–5 of the brief).
> Lenses: Citation, Number, Consistency, Prose, Derivation.
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (CrossRef + arXiv API,
> records saved under `scratchpad/critic_0607/web/` and `scratchpad/crossref/`), md-reflist ✗,
> values-file ✗, repo-grep ✓, doc-internal ✓, Reference_Texts PDFs ✓ (N&B 1997, Petters+2001,
> SEF 1992 via `pdftotext`), wolframscript ✓ (`bash Mathematica/run_wl.sh`), overlay: AGEL (Zotero not needed).
> A claim with no adapter is capped at ⚠ SUSPECT.

Scratch critic script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0607/critic_0607.wl`
(shared with Module 07). Output: `.../critic_0607/critic_out.txt`.
**SUMMARY critic_0607: 47 passed, 0 failed**.
Repo script: `Solutions/06_Fermat_Time_Delays/problems_06.wl`, run via `run_wl.sh`:
**`SUMMARY: 54 PASS, 0 FAIL  (of 54 checks)` / `ALL CHECKS PASS`**.

## Verdict counts (Module 06)

| class | ✅ PASS | ⚠ SUSPECT | ❌ FAIL |
|---|---|---|---|
| Layer: Citation (C) | 9 | 0 | 0 |
| Layer: Number (N) | 16 | 1 | 0 |
| Layer: Consistency (X) | 4 | 0 | 0 |
| Layer: Prose (P) | – | 4 | 0 |
| Derivation (D) | 6 | 0 | 0 |
| Visible-text flags (V1–V5) | – | – | 5 confirmed errors |

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | ψ = (D_ds/D_dD_s)(2/c²)∫Φ dz `\citep[eq.~48]{narayan_lectures_1997}` | ✅ PASS | N&B PDF eq. (48), Sect. 3.2 | none |
| C2 | Citation | "first image … farthest from the lens centre" `[Sect.~3.3.2]` | ✅ PASS | N&B Sect. 3.3.2 item 1 ("the first image to vary is the one that is farthest from the center") | none |
| C3 | Citation | Burke heuristic via Poincaré–Hopf `\citep{burke_1981}` | ✅ PASS | bib:burke_1981 / CrossRef DOI 10.1086/183466 (title, ApJ 244 L1 match); Petters p. 426 states "first shown (heuristically) by Burke via the Poincaré–Hopf index theorem" | none |
| C4 | Citation | Odd Number Image Theorem = Petters Thm 11.5 | ✅ PASS | Petters+2001 PDF p. 426, Thm 11.5(1) N = 2M₊−1 = 2M_sad+1 | none |
| C5 | Citation | n_min+n_max = n_sad − g + 1, Petters Thm 11.4 | ✅ PASS | Petters p. 424–425, Thm 11.4(1) "M₊ = M_sad − g + 1"; (2) N = 2M₊+g−1 | none |
| C6 | Citation | SIS zero-flux third image `[Sect.~3.1]` | ✅ PASS | N&B Sect. 3.1 text after eq. (46) | none |
| C7 | Citation | α̂ = 1.4″(σ/220)² `[eq.~44]` | ✅ PASS | N&B eq. (44) | none |
| C8 | Citation | MSD "goes back to" `\citet{falco_gorenstein_shapiro_1985}` | ✅ PASS | bib + CrossRef DOI 10.1086/184422 (ApJ 289 L1); N&B Sect. 5 attributes the transformation to FGS 1985 | none |
| C9 | Citation | "SEF Sec. 4.6" for the cosmological time-delay form | ✅ PASS | SEF 1992 PDF Sect. 4.6, eqs. (4.65)–(4.67) | none |
| N1 | Number | 4GM/c³ ≈ 1.97×10⁷ s ≈ 228 d | ✅ PASS | critic I1 (1.9705×10⁷ s, 228.07 d) | none |
| N2 | Number | Δt ≈ 2.59×10⁷ s "≈ 299 d" | ⚠ SUSPECT (rounding) | critic I1c: 2.5881×10⁷ s = 299.55 d | "≈ 300 d" (or "≈ 299.6 d"); also in 06_Solutions annotation |
| N3 | Number | R_S/c ≈ 114 d | ✅ PASS | critic I1 (114.04 d) | none |
| N4 | Number | ratio 1.6404, log 0.4949, Δτ(0.5) = 1.0103 | ✅ PASS | critic I1 (1.64039, 0.49493, 1.01032) | none |
| N5 | Number | ln 1.28078 = 0.2475; τ(x₊)=0.0573 | ✅ PASS | critic I2g, I2 table | none |
| N6 | Number | corrected 6.3(b) table (0.4025/0.6025/0.2001 … −0.7956/3.7956/4.5912) | ✅ PASS | critic I2b, I2c | none |
| N7 | Number | Δτ/y = 2.001, 2.021, 2.080, 2.296 | ✅ PASS | arithmetic on N6 | none |
| N8 | Number | 1″² = 2.35×10⁻¹¹ rad² | ✅ PASS | critic I5d | none |
| N9 | Number | (1+z_d)D_dD_s/D_ds ≈ 1870 Mpc; ≈ 52 d per arcsec² | ✅ PASS | critic I5c (1870.7 Mpc, 52.38 d) | none |
| N10 | Number | D_ds/(D_s−D_d) ≈ 1.44 | ✅ PASS | critic I5c (1.4386) | none |
| N11 | Number | χ_d 0.279, χ_s 0.771, χ_ds 0.493, factor 0.336 | ✅ PASS | critic I5 (0.27889, 0.77143, 0.49254, 0.33600) | none |
| N12 | Number | D_d 0.215, D_s 0.386, D_ds 0.246, D_s−D_d 0.171 (c/H₀) | ✅ PASS | critic I5b values / (c/H₀) | none |
| N13 | Number | H₀ = 73.3 | ✅ PASS | critic I5 (73.33) | none |
| N14 | Number | 1.3×1374 = 1786; "≈5%" moves H₀ 70→≈73 | ✅ PASS | 1870.7/1786 = 1.047 | none |
| N15 | Number | 4×10¹⁰ "times too small" (arcsec² vs rad²) | ✅ PASS | 206265² = 4.25×10¹⁰ | none |
| N16 | Number | Hessian eigenvalues (1.742, 0.258), (2.348, −0.348) at x± = 1.1612, −0.8612 | ✅ PASS | critic I4c (y = 0.3, as in Ex. 6.5) | none |
| N17 | Number | small-y Δτ = 2y + y³/12 + O(y⁵) | ✅ PASS | critic I2e (series 2y + y³/12 − y⁵/320) | none |
| X1 | Consistency | Δτ(0.5): chapter Example and Sol. 6.2 print 1.0101, layer says 1.0103 | ✅ PASS (layer); visible text flagged V2 | critic I1 | see V2 |
| X2 | Consistency | prefactor R_S/c (visible) vs 2R_S/c (layer) | ✅ PASS (layer); visible flagged V1 | critic I1a | see V1 |
| X3 | Consistency | Ch. refs `ch:odd_images` (20), `ch:msd_kinematics` (22), `ch:multiplane_dspl` (18) | ✅ PASS | Annotated PDF TOC: 18 Multi-Plane/DSPL, 20 Odd Images, 22 MSD/kinematic | none |
| X4 | Consistency | annotation's Shapiro statement vs visible remark (opposite claims) | ✅ PASS (layer correct) | N&B eq. (3) Δt = (2/c³)∫\|Φ\|dl; critic I3a–c | see V3 |
| P1 | Prose | "That shared prefactor is why the two terms can be added inside one bracket." | ⚠ SUSPECT (aphoristic closer) | read | "The common prefactor lets the two terms share one bracket." or delete |
| P2 | Prose | "This one line is why the third image of a cored lens is a *central* image." | ⚠ SUSPECT (pointer phrase) | read | "So the third image of a cored lens sits at the centre." |
| P3 | Prose | "The distance-free form is the point: a point-mass delay measures the mass directly…" | ⚠ SUSPECT (colon reveal) | read | "In this form the distances cancel, so a point-mass delay measures M independently of cosmology." |
| P4 | Prose | "…which is exactly where Chapter 20 starts"; "uses exactly this scaling" | ⚠ SUSPECT (pointer intensifier) | read | drop "exactly" |
| D1–D6 | Derivation | see below | ✅ PASS ×6 | critic_0607.wl | none |

Layer-claim notes (all ✅): tr A = 2(1−κ) so Type III needs κ > 1 (critic L1); Poincaré–Hopf winding numbers
+1 (large circle), +1 (minimum), −1 (saddle), +1 (origin) for the point mass at y = 0.5 (critic L2,
4000-point contour winding); MST τ_λ = λτ + f(β) (critic L8); g = 1 count N = 2(n_min+n_max) even
(Petters Thm 11.4(2) with g = 1).

## Applied (auto-fixes)

None. The brief forbids visible-text edits, and the only layer-number issue (N2, "299" vs 299.55)
is a rounding call, not a single-source typo.

## Flagged — your hand required

### Visible-text items (author's flags), adjudicated

**V1. 06 eq. `delta_t_schwarzschild`, Example `ex:point_mass_numerical`, Solution 6.2(d), and two .wl files: R_S/c should be 2R_S/c. CONFIRMED.**
θ_E² = (4GM/c²)D_ds/(D_dD_s) makes the prefactor 4GM/c³ = 2R_S/c (critic I1a, I1b symbolic). For
M = 10¹² M☉, z_d = 0.3, y = 0.5: Δt = 1.9705×10⁷ s × 1.3 × 1.01032 = 2.588×10⁷ s = **299.6 d**.
The printed 149/149.7 d is the R_S/c value, 149.8 d (critic I1c, I1d).
Exact fixes:
- `06_Fermat_Time_Delays.tex:856`: `= \frac{\RS}{\speedoflight}\, (1 + z_d)\, \Delta\tau \,,` →
  `= \frac{2\RS}{\speedoflight}\, (1 + z_d)\, \Delta\tau \,,`
- Example (lines ~897–902): `\Delta t = \frac{2.95 \times 10^{15}}{2.998 \times 10^8} \times 1.3 \times 1.0101 \approx 1.29 \times 10^{7}~\text{s} \approx 149~\text{days}` →
  `\Delta t = \frac{2 \times 2.95 \times 10^{15}}{2.998 \times 10^8} \times 1.3 \times 1.0103 \approx 2.59 \times 10^{7}~\text{s} \approx 300~\text{days}`.
  The "days to months" sentence after it should then read "days to a year or so".
- `06_Solutions.tex:119–123`: `\Delta t &= \frac{\RS}{\speedoflight}\,(1+z_d)\,\Delta\tau = \frac{2.953\times10^{15}}{2.998\times10^8}\times1.3\times1.0101 \\ &\approx 1.293\times10^7~\text{s} \approx 149.7~\text{days}` →
  `\Delta t &= \frac{2\RS}{\speedoflight}\,(1+z_d)\,\Delta\tau = \frac{2\times2.953\times10^{15}}{2.998\times10^8}\times1.3\times1.0103 \\ &\approx 2.588\times10^7~\text{s} \approx 299.6~\text{days}`.
- `Mathematica/06_Fermat_Time_Delays/time_delay_function.wl` lines 185 (header comment `Delta_t = (R_S / c) * ...`),
  208 (`deltaT = RS / cc * (1 + zd) * dtauVal;`), 209 (Print label), 223 (`dtPhys = RS / cc * (1 + zd) * dt / dayToSec;`):
  replace `RS / cc` with `2 RS / cc` (or `4 Gnewton Mlens / cc^3`) and `R_S/c` with `2 R_S/c` in labels.
- `Solutions/06_Fermat_Time_Delays/problems_06.wl` lines 149 (`deltaT = RS / cc * (1 + zd) * dtau;`), 155–156 (Print labels
  and `ScientificForm[RS/cc, 4]`): same change. Current run prints `149.777 days` (run06.txt line 65).
  Add a check that `deltaT == 4 Gnewton Mlens/cc^3 (1+zd) dtau`.
- When fixed, drop the "flagged for correction" sentences in the two annotations.

**V2. Solution 6.3(b) table and Δτ(0.5). CONFIRMED.** The chapter's form is
Δτ = y√(y²+4)/2 + ln[(√(y²+4)+y)/(√(y²+4)−y)] with τ(x) = ½(x−y)² − ln|x|, x± = (y ± √(y²+4))/2. The
formula equals τ(x₋) − τ(x₊) identically (critic I2a). Recomputed (critic I2, 4 d.p.):

| y | τ(x₊) | τ(x₋) | Δτ |
|---|---|---|---|
| 0.1 | 0.4025 | 0.6025 | 0.2001 |
| 0.5 | 0.0573 | 1.0677 | 1.0103 |
| 1.0 | −0.2902 | 1.7902 | 2.0805 |
| 2.0 | −0.7956 | 3.7956 | 4.5912 |

The printed rows for y = 0.1, 1, 2 (0.0100, 2.4277, 5.0065) are wrong. The y = 0.5 row is off by
2×10⁻⁴ from rounding ln 1.2808 to 0.2474 (true 0.24747 → 0.2475). Note the repo script body already prints
the correct table (run06.txt lines 84–87), so only the .tex needs fixing.
Exact fix: replace the four tabular rows in `06_Solutions.tex` (~lines 168–171) with
`0.1 & $0.4025$ & $0.6025$ & $0.2001$ \\`, `0.5 & $0.0573$ & $1.0677$ & $1.0103$ \\`,
`1.0 & $-0.2902$ & $1.7902$ & $2.0805$ \\`, `2.0 & $-0.7956$ & $3.7956$ & $4.5912$ \\`.
In Sol. 6.2(b–c) and the chapter Example: `0.2474` → `0.2475`, `0.0574` → `0.0573`, `1.0676` → `1.0677`,
`ln(1.6401)` → `ln(1.6404)`, `0.4947` → `0.4949`, `1.0101` → `1.0103`.

**V3. Remark after the Fermat-potential definition (`06_Fermat_Time_Delays.tex:225–235`): "ψ > 0 … so this term *reduces* the arrival time --- photons passing through a deeper potential arrive earlier due to the Shapiro effect". CONFIRMED wrong.**
The Shapiro delay is positive and grows with |Φ| (N&B eq. 3, Δt = (2/c³)∫|Φ| dl). With
t_grav = −(1/c)(D_dD_s/D_ds)ψ (critic I3c, from N&B eq. 48), deeper Φ means smaller ψ and a larger delay. For a
Plummer sphere the line-of-sight ∫Φ dz relative to b = 3a is −2.30, −2.08, −1.61, −0.69 at b = 0, 0.5, 1, 2
(critic I3a): more negative toward the centre, so more delay. For the SIS, dψ/dθ = θ_E > 0, so −ψ peaks at the centre (I3b).
The "ψ > 0" premise is also void: ψ is defined only up to a constant (N&B Sect. 3.4 notes all Table-2 potentials diverge).
The point-mass sentence ("ψ < 0 inside θ_E, so the Shapiro term increases the arrival time *in that region*") has the same
constant-dependence problem.
Proposed replacement for the second bullet:
> The second term $-\psiL(\vectheta)$ is the **gravitational (Shapiro) delay**. Because $\psiL$ is defined only up to an
> additive constant, its sign carries no physical meaning; its shape does. For any attractive axisymmetric lens
> $d\psiL/d\theta = \alpha > 0$, so $-\psiL$ is largest at the lens centre: photons passing through a deeper part of the
> potential are delayed *more*, as for the Shapiro delay of Module~\ref{ch:light_deflection}. For a point mass,
> $\psiL = \thetaE^2\ln|\vectheta|$ and $-\psiL\to+\infty$ at the origin, so the arrival-time surface has an infinite peak
> there instead of a smooth maximum.

**V4. Solution 6.3(a): "Since x₊ is a minimum and x₋ a saddle point, by definition τ(x₊) ≤ τ(x₋) for any source position." CONFIRMED (invalid argument, true conclusion).**
Being a local minimum does not order a stationary value against a saddle elsewhere. For the point mass the claim can be
proved without the formula: τ → +∞ both as |θ| → ∞ and as θ → 0 (critic I4a), so τ has a global minimum on the
punctured plane at a stationary point; the only stationary points are x₊ (minimum) and x₋ (saddle, critic I4b), so the
global minimum is at x₊, and τ(x₊) < τ(x₋) strictly.
Replacement sentence:
> Since $\tau\to+\infty$ both as $|\vectheta|\to\infty$ and as $\vectheta\to0$, $\tau$ has a global minimum, which must be a
> stationary point of minimum type. The only such point is $x_+$, so $\tau(x_+)<\tau(x_-)$ for any $y>0$. (Being a local
> minimum alone would not be enough: in general a minimum need not lie below a saddle elsewhere on the surface.)

**V5. Solution 6.4(b): χ_s ≈ 0.778, χ_ds ≈ 0.499, factor 0.334. CONFIRMED (minor).**
Flat ΛCDM, Ω_m = 0.3: χ_d = 0.2789, χ_s = 0.7714, χ_ds = 0.4925, χ_dχ_s/[(1+z_d)χ_ds] = 0.3360 (critic I5). H₀ = 73.3
(0.334 gives 72.9), so "≈ 73" stands.
Exact fix (`06_Solutions.tex`): `$\chi_s \approx 0.778$, $\chi_{ds} \approx 0.499$` → `$\chi_s \approx 0.771$, $\chi_{ds} \approx 0.493$`;
`\frac{0.279 \times 0.778}{1.3 \times 0.499} \approx \ldots \times 0.334` → `\frac{0.279 \times 0.771}{1.3 \times 0.493} \approx \ldots \times 0.336`;
in (c) `2.998\times10^8\times0.334` → `\times0.336` and `2.36\times10^{-18}` → `2.38\times10^{-18}` (2.998e8×0.336/4.24e25 = 2.376e−18; ×3.086e19 = 73.3).
The `problems_06.wl` Ex. 6.4 body already prints χ = 0.279/0.771/0.493 (run06.txt lines 112–114), so only the .tex is wrong.

### Layer items

- N2: "≈ 299 d" truncates 299.55 d. Use "≈ 300 d" in both annotations (chapter "Unit check" box and 06_Solutions "Factor of 2" box).

## Prose (LLM tells): flag-only

Added text: chapter ≈1930 words with 1 em-dash; solutions ≈830 words with 0. Antithesis count is low ("Stationary, not
minimal" is a content title, not ornament). The recurring tells are pointer phrases ("exactly where", "exactly this",
"This one line is why") and the phrase "classic/common/frequent error" used twice in the chapter (five more times in Module 07). The
"is the point:" colon reveal (P3) is the worst offender. Overall the layer reads clean and technical; P1–P4 are optional polish.

## Derivation checks

Script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0607/critic_0607.wl`
(written from scratch; does not load repo code). **SUMMARY critic_0607: 47 passed, 0 failed.**

| id | equation | result | checks |
|----|----------|--------|--------|
| D1 | eq. `delta_tau_point_mass` (closed-form Δτ) equals τ(x₋) − τ(x₊); dΔτ/dy = √(y²+4); log = 2 arcsinh(y/2) | ✅ PASS | I2a, I2d, I2f |
| D2 | eq. `delta_t_schwarzschild` prefactor: distances cancel to 4GM/c³ = 2R_S/c (visible R_S/c is wrong, V1) | ✅ PASS for 4GM/c³; visible 2nd equality FAILS | I1a, I1b |
| D3 | Geometric term ΔL = D_dD_s/(2D_ds)\|θ−β\|² (Euclidean, D_s = D_d + D_ds) and t_grav = −(1/c)(D_dD_s/D_ds)ψ | ✅ PASS | coefficients reduced by hand (θ²: D_d(D_d+D_ds)/2D_ds; β²: D_s(D_s−D_ds)/2D_ds; θβ: −D_dD_s/D_ds); I3c |
| D4 | Hessian of τ = A; tr A = 2(1−κ); point-mass on-axis Hessian diag(1+1/x², 1−1/x²) | ✅ PASS | L1, I4b, I4c |
| D5 | Poincaré–Hopf indices for point mass, y = 0.5: {+1, +1, −1, +1} | ✅ PASS | L2 |
| D6 | MST: τ_λ − λτ independent of θ | ✅ PASS | L8 |

Repo script `problems_06.wl`: `SUMMARY: 54 PASS, 0 FAIL  (of 54 checks)`.
