# Progress Log — Learning to Lens

Timestamped record of major milestones and work completed.

---

## 2026-07-14 — Schneider et al. (2006) gap-fill + real bibliography

Compared the tutorial against the newly-added Saas-Fee volume
*Gravitational Lensing: Strong, Weak and Micro* (Schneider, Kochanek &
Wambsganss 2006; Zotero `NNNRZT8L`) and added the material it covers that
the tutorial lacked, following all repo conventions (Mathematica-verified
derivations, epigraph + companion-`.wl` layout, problems/solutions,
source-referenced citations).

**Bibliography (new).** Replaced the inline-only citation style's missing
backend with a real `Notes/references.bib` (natbib, `plainnat`) and a
**References** chapter. Every entry is verified — Zotero export, CrossRef
DOI lookup, or publisher/ISBN record (see provenance comments in the
`.bib`). Activated the previously-commented bibliography block in
`main.tex`, added a bibtex pass to `build.sh`, added Schneider 2006 to both
source lists, and fixed the previously-broken `\citep{Birrer2020}` (now
TDCOSMO IV, verified).

**Content added (14 → 17 modules; new Part IV):**
- **Module 8** — new §"Angular Structure of Lenses: Multipole Expansion"
  (Kochanek §4.4): κ_m relation, internal/external quadrupole, SIE
  f_int=1/4. Verified in `multipole_expansion.wl` (7/7).
- **Module 9** — new §§ on substructure & flux-ratio anomalies (Kochanek
  §8), Einstein-ring reconstruction (§10), and external convergence + lens
  dust (§5.2, §9). Verified in `substructure_and_rings.wl` (6/6).
- **Module 11 (new)** — Lensing Statistics & Cross-Sections (Schneider
  Pt1 §5; Kochanek §6). `lensing_statistics.wl` (9/9) + solutions (8/8).
- **Module 12 (new)** — Weak Lensing & Cosmic Shear (Schneider Pt3):
  Kaiser–Squires, tangential shear, cosmic shear. `weak_lensing.wl` (10/10).
- **Module 13 (new)** — Gravitational Microlensing (Wambsganss Pt4):
  Paczynski light curve, optical depth, astrometric/quasar microlensing.
  `microlensing.wl` (16/16).

Weak & Micro modules 12/13 drafted by two parallel subagents against the
Module-07 template and the Schneider PDF, then independently
re-verified (every `.wl` re-run to PASS; every `\citep` key traced to a
verified `.bib` entry; new refs Paczynski 1986, Mao & Paczynski 1991, and
Paczynski 1998 CrossRef-verified before merge — the last for the astrometric
centroid-shift result, which the microlensing agent correctly re-attributed
from 1986 to 1998).

**Build:** student 210 → 249 pp, instructor 257 → 306 pp; 0 undefined
citations, 0 undefined references, 0 LaTeX errors. Master textbook
verification still 12/12.

---

## 2026-05-14 — Pre-expert-review audit pass

Triggered by spotting that Fig 8.1 (`lensing_geometry.pdf`) had its θ-arc on
the wrong side of the optical axis. Expanded into a full audit of all 14
modules — figures + prose + solutions — using 5 parallel agents (one per
module cluster).

**Outcome:** 17 trivial fixes applied directly, ~20 substantive findings
flagged for review. Full per-finding catalog with file:line locations in
`HANDOFF_audit_2026-05-14.md`. Master verification still passes 12/12.

Headline corrections (all clear-cut, no judgment calls):

- **Fig 8.1 / Module 4** — θ-arc range in `lens_equation.wl` was
  `{Pi/2-0.01, Pi/2+ArcTan[1.5/5]}` (drew left of optical axis). Now
  `{Pi/2-ArcTan[1.5/5], Pi/2}` (opens right toward the image).
- **Modules 3 ↔ 4 canonical example inconsistency**: same M=10¹²M☉,
  z_d=0.3, z_s=1 gave 2.4″ in Mod 3 (correct) and 1.1″ in Mod 4 (wrong,
  used inflated distances 900/1700/1200). Now uniformly 2.4″ everywhere
  with 919/1652/1055 Mpc.
- **Module 9 MST H₀ sign reversed** vs Birrer+2020 standard. Was
  $H_0^{\rm inferred} = \lambda H_0^{\rm true}$; correct is
  $H_0^{\rm true} = \lambda H_0^{\rm naive}$, so unmodeled positive
  sheet (λ<1) makes the *naive* analysis *overestimate* H₀. Fixed in
  `09.tex`, `09_Solutions.tex`, `galaxy_lensing.wl` (incl. figure
  labels), `problems_09.wl`.
- **Module 10 Ex 10.1 was internally wrong throughout**: ρ_crit value
  below ρ_crit,0 (impossible), kbar equation had factor 4 not 2, θ_E
  ≈ 27″ instead of 7.4″, M(θ_E) ≈ 1.4e14 instead of 7.5e12. Recomputed
  from corrected `problems_10.wl`.
- **Module 8 SIE orientation text WRONG**: claimed critical curve /
  caustic perpendicular to mass major axis; both math and figures show
  *along*. Fixed in three places.
- **Module 6 Burke's theorem claim about point mass WRONG**: theorem
  needs smooth Σ, doesn't apply to a δ-function point mass. Rewrote to
  say so explicitly.
- **Module 6 Exercise 6.4 numerics gave unphysical H₀ ≈ 220 km/s/Mpc**.
  Changed Δt = 420 d → 100 d, τ_diff = 25 → 2 arcsec². Now H₀ ≈ 73
  consistent with H0LiCOW.
- **Modules 1c, 1d** — Kretschmann spelling, isotropic weak-field
  factor-of-2, perihelion-precession 1/c², ISCO V_eff numerics.
- **Module 5** — shear field figure was drawing radial sticks instead
  of tangential (a stray `+ Pi/2`).
- **Module 8** — "cusp configuration" example moved from β=(0.15,0) to
  β=(0.25,0) so the figure actually shows a cusp triplet (cusp on
  β_1-axis for q=0.7 is at 0.265, so 0.15 was inside the caustic = a
  quad).

All affected figures regenerated; both PDFs rebuilt. Substantive findings
needing physics judgment (Module 5 Sol 5.4(c) signed-magnification
argument; Module 8 SIS+shear caustic formula in solutions; Module 8
`magnification_map_sie.pdf` orientation; widespread `<>` rendering
artifacts; Kerr ergosphere inner bound; Module 3 Ex 3.5(d)
self-contradiction; etc.) catalogued in HANDOFF for Rodrigo's review.

---

## 2026-03-19 — Project Initialization

- Created repository structure: `Notes/`, `Mathematica/`, `Solutions/`, `Figures/` with subdirectories for all 13 modules (1a–1d, 2–10)
- Created `.gitignore` (excludes copyrighted `Reference_Texts/`, LaTeX artifacts, Mathematica temp files)
- Created `CLAUDE.md` project context file
- Created `repo_preferences.md` — reusable template for future repo conventions
- Created shared LaTeX infrastructure: `preamble.tex` (physics macros, notation), `main.tex` (master document), `build.sh`
- Initialized git repository and pushed to GitHub (public)

### Reference materials available:
- Carroll — GR foundations
- Congdon & Keeton 2018 — Primary lensing textbook (with end-of-chapter problems)
- Narayan & Bartelmann 1997 — Classic lensing lectures
- Saha et al. 2024 — Modern strong lensing review
- Meneghetti 2021 — Lensing with Python examples (adapting to Mathematica)
- Schneider et al. 1992 — Classic monograph
- Petters et al. 2001 — Singularity theory approach

---

## 2026-03-19 — Module 1a: Special Relativity & Tensor Basics

- **LaTeX notes** (`Notes/01a_Special_Relativity/01a_Special_Relativity.tex`): 9 sections covering spacetime interval, Minkowski metric, index notation, Lorentz transforms, four-vectors, dual vectors, tensors, stress-energy tensor. 5 exercises.
- **`lorentz_transforms.wl`**: Symbolic verification of Lorentz boost/rotation properties. All 7 checks pass (metric preservation, rapidity addition, velocity addition, time dilation, interval invariance, four-velocity norm).
- **`four_vectors.nb`**: Interactive notebook — spacetime diagrams, light cones, Lorentz boost axis tilting, Lorentz factor plot, twin paradox, index manipulation.
- **LaTeX compiled**: `main.pdf` builds cleanly (28 pages). Fixed `\order` conflict with `physics` package and `\headheight` warning.
- Added `README.md` with full setup instructions and `environment.yml` for conda.

---

## 2026-03-19 — Module 1b: Differential Geometry & the Metric Tensor

- **LaTeX notes** (`Notes/01b_Differential_Geometry/01b_Differential_Geometry.tex`): 8 sections covering manifolds, general metric tensor, vectors on manifolds, covariant derivative, Christoffel symbols, parallel transport, geodesic equation, curvature tensors (Riemann, Ricci, Ricci scalar). 5 exercises.
- **`christoffel_symbols.wl`**: Reusable functions for computing Christoffel symbols, Riemann/Ricci tensors, and Ricci scalar from any input metric. Verified on polar coordinates (flat → R=0) and 2-sphere (R = 2/R²). Great circle geodesic verification.
- **`curved_surfaces.nb`**: Interactive geodesics on the 2-sphere (NDSolve + 3D visualization), Christoffel symbol calculator.
- **Solutions**: `problems_01b.wl` (all 5 exercises verified), `01b_Solutions.tex` (LaTeX solutions).
- **PDF**: Student 34 pages, Instructor 38 pages.

---

## 2026-03-19 — Module 1c: The Schwarzschild Solution

- **LaTeX notes** (`Notes/01c_Schwarzschild/01c_Schwarzschild.tex`): 9 sections covering most general spherically symmetric metric, step-by-step derivation of Schwarzschild from R_μν=0, Birkhoff's theorem, gravitational time dilation, gravitational redshift, event horizon vs. true singularity, Kretschner scalar, weak-field limit, Schwarzschild radius table, Flamm's paraboloid embedding. 5 exercises.
- **`schwarzschild_metric.wl`**: Full symbolic verification — all 10 Ricci components = 0, Kretschner scalar = 12Rs²/r⁶ (exact match), numerical Schwarzschild radii and gravitational redshift calculations.
- **`gravitational_redshift.nb`**: Interactive plots of redshift, time dilation, Flamm's paraboloid, Rs calculator.
- **Solutions**: `problems_01c.wl` (all 5 exercises verified), `01c_Solutions.tex`.
- **PDF**: Student 39 pages, Instructor 46 pages.
- **Confirmed**: `wolframscript` can export publication-quality PDF figures for embedding in LaTeX. Will add figure generation to future modules.

### Planning: GR Expansion
- **Module 1e (new)**: Linearized Gravity and the Weak-Field Metric — the critical bridge between exact Schwarzschild and the lensing formalism. Covers g = η + h, Newtonian limit, weak-field deflection angle.
- **Kerr**: Brief 3-5 page overview section within Module 1d (state metric, key features, note why not needed for galaxy-scale lensing).
- **FRW**: Keep in Module 3 but expand with full derivation from Einstein equations + perfect fluid stress-energy tensor.
- **Gravitational waves**: Skip entirely (mention in 1e, then move on).

---

## 2026-03-19 — Module 1b/1c Expansions

- **Module 1b**: Added "Computation Cookbook" section — step-by-step algorithmic guide for computing Christoffel symbols, Riemann tensor, Ricci tensor/scalar from any metric. Includes diagonal metric shortcut formulas and a complete worked example (every step) for the 2-sphere. Tips and tricks section.
- **Module 1c**: Added "Inside the Event Horizon" section — the coordinate swap (t↔r signature flip), physical meaning (singularity is a moment in time, not a place in space), tilting light cones, Eddington-Finkelstein coordinates, and relevance note for lensing.

---

## 2026-03-19 — Module 1d: Geodesics & Orbits in Schwarzschild Spacetime

- **LaTeX notes** (`Notes/01d_Geodesics_Orbits/01d_Geodesics_Orbits.tex`): 9 sections covering Killing vectors and conservation laws, effective potential derivation, circular orbits and ISCO (r = 3Rs), photon sphere (r = 3Rs/2), Newtonian vs GR comparison, perihelion precession (43"/century for Mercury), null geodesics preview, and Kerr metric overview (stated, not derived; key features including frame dragging, ergosphere, spin-dependent ISCO). 5 exercises.
- **`geodesic_equation.wl`**: Symbolic ISCO (r=6, L=2√3 in G=c=M=1 units), photon sphere (r=3, unstable), Mercury precession (43.0"/century — exact match). 4 figures exported.
- **Figures**: effective_potential_massive.pdf, effective_potential_photon.pdf, newtonian_vs_gr.pdf, precessing_orbit.pdf — all embedded in LaTeX.
- **Figures for Modules 1a-1c**: 8 publication-quality figures added and embedded (light cones, Lorentz boost, γ factor, parallel transport, geodesics on sphere, time dilation, gravitational redshift, Flamm's paraboloid).

---

## 2026-03-19 — Module 1e: Linearized Gravity & Weak-Field Metric

- **LaTeX notes**: 10 sections covering weak-field expansion (g = η + h), Newtonian limit (recovers Newton's law from geodesic equation), the full weak-field metric with equal time and space perturbations, null geodesics and deflection via Born approximation, PPN formalism (γ_PPN = 1 in GR), effective refractive index (n = 1 + 2|Φ|/c²), superposition principle, and preview of the lens equation. 5 exercises.
- **`weak_field_metric.wl`**: Verified Newtonian limit, Schwarzschild weak-field expansion, deflection integral (∫b dl/(l²+b²)^{3/2} = 2/b), solar deflection = 1.75 arcsec. 4 figures exported.
- **Solutions**: problems_01e.wl + 01e_Solutions.tex — all verified.

## 2026-03-19 — Module 2: Light Deflection in Curved Spacetime

- **LaTeX notes**: 8 sections covering Soldner's Newtonian calculation (α = 2GM/c²b), full GR derivation from null geodesic orbit equation (Congdon & Keeton eqs. 3.87-3.96), Shapiro time delay, deflection by the Sun (1.75"), Jupiter (16 mas), and galaxies (~4"), exact vs. weak-field comparison. 5 exercises.
- **`deflection_angle.wl`**: Confirmed deflection integral symbolically, numerical values match textbooks, Shapiro delay = 240 μs. 3 figures exported.
- **Synergy review**: Module 1e derives deflection via Born approximation (weak-field integral), Module 2 derives via exact null geodesic orbit equation. Both arrive at α = 4GM/(c²b). Cross-references added between modules.
- **PDF**: Student 79 pages, Instructor 97 pages.

---

## 2026-03-19 — Modules 3 & 4 (built in parallel)

### Module 3: Cosmological Distances
- **LaTeX notes**: Full FRW metric derivation from Einstein equations (as requested), including RW metric, Christoffel symbols, perfect fluid stress-energy, both Friedmann equations, fluid conservation, density parameters. Distance measures: comoving, angular diameter (with turnover!), luminosity. Distance ratio D_ds/(D_d D_s) for lensing. 5 exercises.
- **`friedmann_equations.wl`**: Symbolic FRW Christoffel symbols, Friedmann equation verification, cosmological distance computation. 4 figures (D_A vs z, distances vs z, Einstein radius vs z_d, lensing efficiency).
- **`cosmological_distances.nb`**: Interactive sliders for Ω_m, Ω_Λ, H₀.

### Module 4: The Gravitational Lens Equation
- **LaTeX notes**: Thin-screen approximation, lensing geometry, lens equation β = θ - α(θ), surface mass density, critical surface mass density Σ_cr, Einstein radius θ_E, point mass lens (two images, Einstein ring), magnification preview. 5 exercises.
- **`lens_equation.wl`**: Point mass lens equation solved, θ_E computed for stellar/galaxy/cluster scales, Σ_cr numerical values. 7 figures (geometry, image positions, Einstein ring, magnification).
- **`einstein_ring.nb`**: Interactive image position visualization.
- **PDF**: Student 108 pages, Instructor 133 pages.

---

## 2026-03-19 — Modules 5 & 6 (built in parallel) — Part II Complete!

### Module 5: Magnification, Convergence, and Shear
- **LaTeX notes**: Lensing potential ψ (2D Poisson equation ∇²ψ = 2κ), convergence κ (isotropic focusing), shear γ₁,γ₂ (anisotropic distortion), Jacobian matrix A, magnification μ = 1/det(A), convergence vs shear effects on image shape, point mass example, SIS preview, critical curves/caustics preview. 5 exercises.
- **`lensing_potential.wl`**: Symbolic derivation of ψ, κ, γ for point mass. 5 figures (convergence/shear effects, magnification map, shear field, κ/γ profiles, point mass magnification).
- **`convergence_shear_demo.nb`**: Interactive distortion visualization.

### Module 6: Fermat's Principle and Time Delays
- **LaTeX notes**: Time delay function, Fermat potential τ(θ,β) = ½|θ-β|² - ψ(θ), Fermat's principle (∇τ = 0 gives lens equation), Morse theory image classification (Type I/II/III = min/saddle/max), Burke's odd-number theorem, observable time delays, H₀ from time-delay cosmography (H0LiCOW/TDCOSMO), point mass and SIS examples. 5 exercises.
- **`time_delay_function.wl`**: Fermat potential verified, time delay formula confirmed. 6 figures (arrival-time surface, contours, time delay vs β, H₀ constraint).
- **`arrival_time_surface.nb`**: Interactive 3D arrival-time surface with source position slider.
- **PDF**: Student 133 pages, Instructor 165 pages.
- **Part II (Gravitational Lensing Theory) is now COMPLETE.**

---

## 2026-03-19 — Modules 7 & 8 (built in parallel)

### Module 7: Axisymmetric Lens Models
- **LaTeX notes** (948 lines): General circular formalism, point mass recap, SIS (constant deflection angle!), NIS (core radius effects), NFW (dark matter halo profile). Model comparison table and figures. 5 exercises.
- **`axisymmetric_models.wl`**: SIS/NIS/NFW κ, γ, α derived and verified. 6 figures.
- **`sis_nis_nfw.nb`**: Interactive model explorer with σ_v, core radius, concentration sliders.

### Module 8: Non-Axisymmetric Models and Critical Curves
- **LaTeX notes** (1194 lines — largest module): SIS+shear, SIE (Kormann et al. 1994), critical curves, caustics, and the comprehensive **Image Topology** section covering:
  - Critical curves as parity boundaries (det(A) sign change)
  - Caustic crossings: image creation/destruction in ±2 pairs
  - Full "walk a source across caustics" walkthrough (1→3→5→3→1 images)
  - Fold catastrophe (μ ∝ 1/√d, arc formation)
  - Cusp catastrophe (three-image merger, cusp relation)
  - Image configuration taxonomy (doubles, quads, Einstein crosses, naked cusps)
  - Why giant arcs form along tangential critical curves
- **`critical_curves_caustics.wl`**: SIS+shear and SIE critical curves/caustics computed, image solver verified to machine precision. 7 figures.
- **`image_configurations.nb`**: Interactive source placement → image visualization, caustic crossing animation.
- **PDF**: Student 166 pages, Instructor 205 pages.

---

## 2026-03-19 — Modules 9 & 10 (built in parallel) — TUTORIAL SUITE COMPLETE!

### Module 9: Strong Lensing by Galaxies — Applications
- **LaTeX notes**: Lens modeling overview (parametric vs free-form), Einstein radius as mass estimator, mass-sheet degeneracy (THE fundamental degeneracy), source position transformation, lensing + stellar kinematics (breaking MSD, power-law profiles, bulge-halo conspiracy), time-delay cosmography (H0LiCOW/TDCOSMO, H₀ tension), real lens systems (Q0957+561, Einstein Cross, B1608+656). 5 exercises.
- **`galaxy_lensing.wl`**: Mass from θ_E, MSD demonstration, power-law profiles, H₀ from time delays. 5 figures.
- **`mass_sheet_demo.nb`**: Interactive MSD visualizer, power-law explorer, H₀ estimator.

### Module 10: Strong Lensing by Galaxy Clusters
- **LaTeX notes**: NFW at cluster scale, giant arcs (formation, ray-tracing, Abell 370), multiple image systems, cluster mass estimation (strong + weak lensing + X-ray), cosmic telescope (magnification bias, HFF, JWST, Earendel), weak lensing introduction (reduced shear, tangential shear profiles), state of the field and future directions (Euclid, Rubin, Roman, SKA). "Where to Go From Here" with software packages and review articles. 5 exercises.
- **`cluster_lensing.wl`**: NFW cluster lensing, Einstein radius vs mass, giant arc ray-tracing. 3 figures.
- **`nfw_cluster.nb`**: Interactive cluster explorer with M₂₀₀, concentration, redshift sliders.

### FINAL TOTALS
- **Student edition: 199 pages**
- **Instructor edition: 245 pages**
- **100 exercises** with Mathematica-verified solutions
- **~75 publication-quality figures**
- **14 modules** spanning GR foundations through cluster lensing
- **All derivations verified deterministically via Wolfram Mathematica**

---

## 2026-04-23 — Tier 1: Careful Step-by-Step Derivations (Chapters 8–13)

Expanded the lensing half of the tutorial with fully step-by-step
derivations, each accompanied by symbolic Mathematica verification.

### Module 7 (Axisymmetric Models)
- **Full derivation of the NFW surface mass density** (Sec. 7.4).
  Line-of-sight projection → change of variable w = √(x² + u²) →
  integration-by-parts identity → evaluation of K(x) via the
  substitution w = x cosh τ → branch split into arccosh (x < 1) and
  arctan (x > 1). Continuity at x = 1 verified.
- **Full derivation of the NFW convergence and deflection** (Secs. 7.5–7.6)
  from the axisymmetric relation α(θ) = θ κ̄(θ), including explicit
  evaluation of h(x) = ∫₀ˣ f(x′)x′ dx′ = ln(x/2) + g(x).

### Module 8 (Elliptical Models)
- **Full derivation of the SIE deflection formulas** (Kormann, Schneider
  & Bartelmann 1994), using scale-invariance (Euler's theorem) to
  obtain ψ = θ₁α₁ + θ₂α₂ and direct verification of grad ψ = α and
  ∇²ψ = 2κ.

### Bugs fixed along the way (verification-driven)
- **Factor-of-2 inconsistency in the NFW α and κ̄ equations** (Module 7
  eq:nfw_alpha, eq:nfw_gamma; Module 10 eq:cl_nfw_alpha,
  eq:cl_tangential_crit, eq:cl_radial_crit). With κ_s = 2ρ_s r_s/Σ_cr
  (the convention used for κ in the text and in the Mathematica files),
  the correct coefficient is 2, not 4. Fixed in the LaTeX and in
  `axisymmetric_models.wl` and `cluster_lensing.wl`. Einstein radius
  for the cluster example recomputed: θ_E ≈ 16″ for (M_200=10¹⁵M☉,
  c=5, z_d=0.3, z_s=2), not 35–40″. (Observed clusters show 30–50″
  because of ellipticity, substructure, and mergers on top of the
  spherical NFW.)
- **SIE Σ formula typo in Module 8**: denominator had √(ξ₁² + q²ξ₂²)
  instead of √(q²ξ₁² + ξ₂²). The α formulas were already correct
  (matching Kormann et al.); fixing Σ restores internal consistency.

### New/modified computational artifacts
- **NEW** `Mathematica/07_Axisymmetric_Models/nfw_projection.wl` —
  8-step symbolic + numerical verification of the NFW projection,
  K(x) evaluation, antiderivative identity, and the factor-2 check
  for κ̄.
- **NEW** `Mathematica/08_Elliptical_Models_Caustics/sie_deflection.wl` —
  4-check verification of the SIE formulas: grad ψ = α, ∇²ψ = 2κ,
  SIS limit q → 1, and a finite-difference cross-check of κ from α.
- **UPDATED** `Mathematica/07_Axisymmetric_Models/axisymmetric_models.wl`
  and `Mathematica/10_Cluster_Lensing/cluster_lensing.wl` (factor-2 fix).

### Page counts after Tier 1
- **Student edition: 208 pages** (+9)
- **Instructor edition: 254 pages** (+9)
- All 12 master-verification tests still pass; both PDFs build clean.

---

## 2026-04-23 — Tier 2: Medium-priority derivations (Modules 5, 9)

### Module 5 (Magnification, Convergence, Shear)
- **Full proof of the 2D Green's function identity**
  ∇² ln r = 2π δ⁽²⁾(r), via the divergence theorem: ∇² ln r = 0 for
  r > 0, and the flux ∮ ∇(ln r)·n̂ dℓ around a disk evaluates to 2π.
  This is the missing step in the derivation of the 2D Poisson
  equation ∇²ψ = 2κ.
- **Hessian decomposition for the shear.** Derived γ₁ = (∂²ψ/∂θ₁²
  − ∂²ψ/∂θ₂²)/2 and γ₂ = ∂²ψ/∂θ₁∂θ₂ as the traceless symmetric
  part of the Hessian; the trace part is 2κ. Under passive rotation
  of the θ-axes by φ, the complex shear γ = γ₁ + iγ₂ satisfies
  γ → e^(−2iφ) γ (spin-2 transformation).

### Module 9 (Galaxy Lensing Applications)
- **Full derivation of Aλ = λA under the MST**, via componentwise
  action on the Jacobian using αλ = λα + (1−λ)θ. The (1−λ)δᵢⱼ term
  in the derivative of the second piece cancels the δᵢⱼ from λ⋅δᵢⱼ,
  leaving exactly λA. Hence det Aλ = λ²det A and μλ = μ/λ².
- **Power-law profile projection.** Line-of-sight integral of
  ρ ∝ r^(−γ') reduced to a Beta function:
  ∫₀^∞ (1+u²)^(−γ'/2) du = (√π/2) Γ((γ'−1)/2)/Γ(γ'/2),
  giving Σ(ξ) ∝ ξ^(1−γ') and therefore κ(θ) ∝ θ^(1−γ').

### Mathematica verification extensions
- **`lensing_potential.wl`** — added Section 5b (spin-2 rotation
  check of the complex shear, passive rotation convention) and
  Section 5c (Green's function flux integral + direct ∇² ln r = 0
  check for r > 0).
- **`galaxy_lensing.wl`** — added Section 4b (componentwise MST
  Jacobian verification: every Aᵢⱼ(λ) − λAᵢⱼ = 0 symbolically) and
  Section 4c (power-law projection integral compared to the closed
  Beta-function form at γ' = 3/2, 7/4, 2, 9/4, 5/2; all diffs = 0).

### Page counts after Tier 2
- **Student edition: 208 pages** (no change — inserts fit on existing pages)
- **Instructor edition: 254 pages** (no change)
- All Mathematica scripts pass.

---

## 2026-04-23 — Tier 3: Polish derivations (Modules 4, 7, 8)

### Module 4 (Lens Equation)
- **Σ_cr derivation.** Short physical argument: a uniform disk of
  constant Σ has α(θ) = θ precisely when Σ = Σ_cr = c² D_s /
  (4π G D_d D_ds), derived from α̂ = 4G M_{2D}/(c² ξ) with
  M_{2D} = π ξ² Σ.

### Module 7 (Axisymmetric Models)
- **SIS enclosed-mass integral made explicit.** Showed
  ∫₀^ξ Σ(ξ′)ξ′ dξ′ = πσ_v²ξ/G in one step from Σ(ξ) =
  σ_v²/(2Gξ), and backed up Σ with its one-line projection from
  the 3D isothermal ρ.
- **NIS deflection integral.** Derived α(θ) = θ_E[√(θ² + θ_c²) −
  θ_c]/θ directly from (2/θ) ∫₀^θ κ(θ′)θ′ dθ′ using the
  antiderivative d/dθ′√(θ′² + θ_c²) = θ′/√(θ′² + θ_c²).

### Module 8 (Elliptical Models)
- **SIS + external-shear critical curve from det A = 0.** Derivation
  in polar coordinates gives det A = (1 − γ²) − u(1 − γ cos 2φ) with
  u = θ_E/|θ|, hence θ_crit(φ) = θ_E(1 − γ cos 2φ)/(1 − γ²).

### Bug fixed along the way
- The LaTeX boxed formula for θ_crit(φ) had an erroneous
  "−2 γ cos 2φ" in the denominator (the Mathematica script
  `critical_curves_caustics.wl` was already correct). Mathematica
  substitution of the book formula into det A returned
  2γ cos 2φ ≠ 0, confirming the typo. Fixed.

### Page counts after Tier 3
- **Student edition: 208 pages**
- **Instructor edition: 254 pages**
- All 12 master-verification tests still pass.
