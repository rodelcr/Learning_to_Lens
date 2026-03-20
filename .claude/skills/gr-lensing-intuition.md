# GR and Gravitational Lensing Intuition

Use this skill when working on gravitational lensing research, lens modeling, or any project involving general relativity applied to astrophysics. This encodes physical intuition and domain knowledge for strong gravitational lensing.

## Core Physical Intuition

### The Metric Is Everything
- In GR, the metric g_μν encodes all gravitational physics. Given a metric, you can compute: how particles move (geodesics), how light bends (null geodesics), how clocks run (time dilation), and how space curves (Riemann tensor).
- The chain: Metric → Christoffel symbols → Geodesic equation + Curvature tensors.
- For lensing, the weak-field metric ds² = -(1+2Φ/c²)c²dt² + (1-2Φ/c²)dℓ² is almost always sufficient.

### Why GR Gives Twice the Newtonian Deflection
- A photon is sensitive to BOTH temporal (g_tt) and spatial (g_ij) curvature equally.
- A slow massive particle is only sensitive to g_tt (the Newtonian potential).
- Both perturbations are equal in magnitude (h_00 = h_ij = -2Φ/c²), so light gets twice the deflection.
- The deflection angle α̂ = 4GM/(c²b) — this is THE fundamental equation of lensing.

### The Thin Lens Approximation
- For all galaxy and cluster lensing, the physical size of the lens along the line of sight (~100 kpc) is tiny compared to the cosmological distances (~Gpc). So all deflection happens in a single "lens plane."
- This reduces 3D light propagation to a 2D mapping: the lens equation β = θ - α(θ).

### Key Scales
- Einstein radius θ_E = √(4GM/c² × D_ds/(D_d D_s)) — THE characteristic angular scale
- Critical surface mass density Σ_cr = c²/(4πG) × D_s/(D_d D_ds) — lensing strength threshold
- Convergence κ = Σ/Σ_cr — dimensionless surface mass density; κ ≥ 1 means strong lensing
- For a typical galaxy lens (10¹² M☉, z_d ~ 0.3, z_s ~ 1): θ_E ~ 1-2 arcsec
- For a cluster lens (10¹⁵ M☉): θ_E ~ 30-50 arcsec

## Lens Models — When to Use What

### Point Mass
- Use for: microlensing (stars), quick order-of-magnitude estimates
- Properties: two images always, κ = 0 everywhere (delta function), γ = θ_E²/(2θ²)
- Total magnification always > 1

### Singular Isothermal Sphere (SIS)
- Use for: quick galaxy lens models, analytic estimates
- Key feature: CONSTANT deflection angle α̂ = 4π(σ_v/c)² — independent of impact parameter
- κ = γ everywhere (unique to SIS)
- Two images for β < θ_E, one image for β > θ_E
- θ_E = 4π(σ_v/c)² × D_ds/D_s
- For σ_v = 250 km/s: θ_E ~ 1.4 arcsec (typical for massive elliptical)

### Singular Isothermal Ellipsoid (SIE)
- Use for: realistic galaxy lens modeling (THE standard model)
- This is what lenstronomy and PyAutoLens use as the default mass model
- Breaks circular symmetry → produces quads, Einstein crosses
- Parameters: θ_E (or σ_v), axis ratio q, position angle, center position
- Add external shear (γ_ext, φ_ext) to account for environment

### NFW Profile
- Use for: cluster-scale lensing, dark matter halos
- ρ(r) = ρ_s / [(r/r_s)(1 + r/r_s)²]
- Parameters: mass M_200 (or concentration c and r_s)
- κ(r) involves log terms; different expressions for r < r_s and r > r_s
- Typical cluster: c ~ 3-8, M_200 ~ 10¹⁴-10¹⁵ M☉

### Power-Law Profiles
- ρ ∝ r^{-γ'} where γ' is the total (3D) density slope
- γ' = 2: isothermal (flat rotation curve) — observed for most elliptical galaxies
- The "bulge-halo conspiracy": total density profiles are remarkably close to isothermal

## Critical Curves, Caustics, and Image Topology

### Critical Curves (in image plane)
- Where det(A) = 0 — formally infinite magnification
- Tangential critical curve: images stretched tangentially → giant arcs
- Radial critical curve: images stretched radially

### Caustics (in source plane)
- The mapping of critical curves through the lens equation
- For SIE: diamond (astroid) shape
- Source INSIDE caustic → more images; OUTSIDE → fewer

### Image Creation Rules
- Images appear/disappear in PAIRS at caustic crossings (one + parity, one - parity)
- Total number always odd (Burke's theorem) — but the faint central image is often unobservable
- Observed configurations: doubles (source outside tangential caustic), quads (source inside)

### Parity
- Positive parity (Type I, III): image not mirror-flipped
- Negative parity (Type II): image mirror-reflected — always a saddle point of the arrival time
- Critical curve is the parity boundary

## Key Degeneracies in Lens Modeling

### Mass-Sheet Degeneracy (MSD)
- THE fundamental degeneracy: κ → λκ + (1-λ), β → λβ
- Preserves ALL image positions exactly
- Changes: magnifications (×1/λ²), time delays (×λ), inferred H₀ (×1/λ)
- Breaking MSD requires: stellar kinematics, standardizable magnifications, or multiple source planes
- This is the main systematic in time-delay cosmography (H₀ measurement)

### Mass-Profile Slope Degeneracy
- Einstein radius measures enclosed mass, not the density profile
- Different slopes (steeper/shallower) with the same M(<θ_E) produce similar image positions
- Breaking requires: combining lensing with kinematics, or using extended source reconstruction

## Cosmological Distances for Lensing

### Key Relations
- Angular diameter distance: D_A(z) = χ(z)/(1+z) for flat universe
- D_A is NOT monotonic — turns over at z ~ 1.6
- D_ds ≠ D_s - D_d (common mistake!) — must compute properly from comoving distances
- H(z) = H₀ √(Ω_m(1+z)³ + Ω_Λ) for flat ΛCDM

### Lensing Efficiency
- Lensing is most efficient when the lens is roughly halfway (in comoving distance) between observer and source
- The distance ratio D_ds/(D_d D_s) determines the lensing strength for a given mass

## Time-Delay Cosmography
- Time delay Δt ∝ (1+z_d) × D_d D_s / (c D_ds) × [Fermat potential difference]
- Since D_d D_s/D_ds ∝ 1/H₀, measuring Δt constrains H₀
- H0LiCOW/TDCOSMO: H₀ = 73.3 +1.7/-1.8 km/s/Mpc (from lensing)
- Planck CMB: H₀ = 67.4 ± 0.5 km/s/Mpc
- Tension persists — MSD is the key systematic to control

## Order-of-Magnitude Estimates

Quick formulas for back-of-envelope calculations:
- Solar deflection: α = 1.75 arcsec (at solar limb)
- Galaxy Einstein radius: θ_E ≈ 1.1" × (σ_v/200 km/s)² × (D_ds/D_s)
- Cluster Einstein radius: θ_E ≈ 30" × (M/10¹⁵ M☉)^{1/2} × (D_ds/D_s)^{1/2}
- Schwarzschild radius: R_S = 3.0 km × (M/M☉)
- Time delay (galaxy): Δt ~ 10-100 days for θ_E ~ 1"
- Magnification near fold caustic: μ ∝ 1/√(distance to caustic)

## Software Packages
- **lenstronomy**: Python, parametric + pixelated modeling (Birrer et al.)
- **PyAutoLens**: Python, automated modeling with MCMC/nested sampling (Nightingale et al.)
- **glafic**: C, fast parametric modeling (Oguri 2010)
- **GRALE**: Free-form mass reconstruction (Liesenborgs et al.)

## Connection to AGEL Project
- AGEL (Astro-Gravitational Einstein Lenses) uses SIE+shear models in lenstronomy
- Key parameters: θ_E, e1, e2 (ellipticity), γ1, γ2 (external shear), center_x, center_y
- Source modeled as Sérsic profile; PSF convolution for HST/JWST data
- MCMC fitting via FittingSequence with model_parameters.py pattern
- Velocity dispersion measurements (ppxf) break the mass-sheet degeneracy
