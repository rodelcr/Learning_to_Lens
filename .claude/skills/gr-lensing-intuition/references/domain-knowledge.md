# GR & Gravitational Lensing Domain Knowledge

## Core Physical Intuition

### The Metric Is Everything
- In GR, the metric g_μν encodes all gravitational physics. Given a metric, compute: how particles move (geodesics), how light bends (null geodesics), how clocks run (time dilation), and how space curves (Riemann tensor).
- The chain: Metric → Christoffel symbols → Geodesic equation + Curvature tensors.
- For lensing, the weak-field metric ds² = -(1+2Φ/c²)c²dt² + (1-2Φ/c²)dℓ² is almost always sufficient.

### Why GR Gives Twice the Newtonian Deflection
- A photon is sensitive to BOTH temporal (g_tt) and spatial (g_ij) curvature equally.
- A slow massive particle is only sensitive to g_tt (the Newtonian potential).
- Both perturbations are equal in magnitude (h_00 = h_ij = -2Φ/c²), so light gets twice the deflection.
- The deflection angle α̂ = 4GM/(c²b) — THE fundamental equation of lensing.

### The Thin Lens Approximation
- For all galaxy and cluster lensing, the physical size of the lens along the line of sight (~100 kpc) is tiny compared to the cosmological distances (~Gpc). All deflection happens in a single "lens plane."
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
- Default mass model in lenstronomy and PyAutoLens
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
- Main systematic in time-delay cosmography (H₀ measurement)

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

## Angular Structure: Multipole Expansion (strong lensing)
- Any lens potential = circular monopole + angular multipoles:
  ψ(θ,φ) = ψ₀(θ) + Σ_m ψ_m(θ) cos[m(φ−φ_m)].
- Isothermal-scaling multipole ψ_m = a_m θ cos[m(φ−φ_m)] ⇒ κ_m = a_m(1−m²)/(2θ) cos[…] (in the ∇²ψ=2κ convention). m=0 → SIS; m=2 → elliptical quadrupole.
- External shear is the **massless external quadrupole**: ψ = ½γθ²cos[2(φ−φ_γ)], κ=0.
- Each harmonic has internal (mass-sourced, decaying) and external (tidal, growing) parts. For an SIE the internal/external quadrupole ratio is (m−1)/(m+1)=1/3, so f_int=1/4 — most of an SIE's quadrupole comes from mass *outside* the Einstein radius (the halo). This is why external shear is an adequate stand-in for the environment.
- Amplitudes fall as ψ_m ∝ ε^{m/2}; quadrupole matters for any ellipticity, m=4 only for q≲0.75. Source: Kochanek in Schneider+2006, Part 2 §4.4.

## Substructure and Flux-Ratio Anomalies
- ΛCDM predicts far more subhaloes than observed satellites; a few % of projected mass near images is dark substructure.
- Smooth models fit image *positions* but not *flux ratios* → "flux-ratio anomalies" (e.g. cusp relation Σ signed μ of 3 cusp images ≈ 0 is violated).
- **Derivative-order argument:** with M∝σ_v⁴, R∝σ_v²: time delays (∝ψ∝σ_v⁴) unaffected by low-mass substructure; deflections (∝σ_v²) only by massive; **magnifications (κ,γ∝σ_v⁰) by all mass scales** — so flux ratios uniquely probe the low-mass end (CDM vs WDM). Substructure also preferentially demagnifies saddle points.
- Dalal & Kochanek: f_sat ≈ 0.02 (90% CI 0.006–0.07), consistent with CDM. Modern: gravitational imaging (astrometric detection of dark subhaloes in arcs).

## Extended Sources / Einstein-Ring Reconstruction
- **Lensing conserves surface brightness**: f_I(θ)=f_S(β(θ)); magnification is only the apparent brightening from larger solid angle.
- An Einstein ring is a *pattern* — the peak-surface-brightness locus along radial spokes, not discrete images. For an isothermal ψ=b θ F(φ): critical curve r_crit/b=F+F″; ring r_E/b=F(φ)+β₀·ê_θ. The ring's angular shape reads off the potential's multipoles.
- Rings break the *angular* degeneracies unconstrained by point images but pin the *radial* profile only weakly (∝|Δβ|⁴).
- Source reconstruction: every image pixel maps to a source pixel; a correct model gives them equal surface brightness. Regularized (semilinear) inversion onto a pixel/adaptive grid → PyAutoLens / SLaM. Source: Kochanek §10.

## External Convergence
- Line-of-sight / group / cluster mass adds a near-uniform sheet κ_ext across the images → invisible to positions & flux ratios (it is the physical MST with λ=1−κ_ext), but rescales H₀: H₀_true = (1−κ_ext) H₀_naive. Estimated (few %) from field weighting + LOS simulations; an irreducible step in TDCOSMO. Differential dust extinction in the lens ISM corrupts *optical* flux ratios → substructure work uses *radio*.

## Weak Lensing & Cosmic Shear
- Regime κ,γ ≪ 1. Galaxy shapes: complex ellipticity χ, ε; |χ|=(1−r²)/(1+r²), |ε|=(1−r)/(1+r) for axis ratio r. Averaging over random intrinsic orientations, ⟨ε⟩ = reduced shear g (unbiased but noisy: σ_ε/√N). In the weak limit γ≈g≈⟨ε⟩≈⟨χ⟩/2.
- **Tangential/cross shear**: γ_t=−Re(γe^{−2iφ}), γ_×=−Im(…). For axisymmetric lenses ⟨γ_t⟩(θ)=κ̄(<θ)−κ(θ); SIS γ_t=θ_E/(2θ); point mass γ_t=θ_E²/θ². γ_t ∝ ΔΣ in galaxy–galaxy lensing.
- **Kaiser–Squires inversion**: κ(θ)−κ₀ = (1/π)∫Re[D*(θ−θ′)γ(θ′)]d²θ′, kernel D(θ)=−(θ₁²−θ₂²+2iθ₁θ₂)/|θ|⁴ (D̂D̂*=π²). Discrete estimator has divergent noise → smoothing needed. κ₀ is the mass-sheet mode; broken by magnification (μ→λ⁻²μ) or source-redshift spread.
- **Aperture mass** M_ap = ∫U(θ)κ d²θ with a compensated filter ∫U=0 → immune to the mass-sheet constant.
- **Cosmic shear**: convergence power spectrum P_κ(ℓ) from LSS; two-point ξ±(θ); probes σ₈, Ω_m. Source: Schneider in Schneider+2006, Part 3.

## Microlensing
- Images unresolved (~mas) → observable is the time-variable total magnification. Point lens: A(u)=(u²+2)/(u√(u²+4)), u=β/θ_E; A→1/u (u→0), A→1 (u→∞); A(1)=3/√5≈1.34. Image magnifications μ_±=(A±1)/2, μ_++μ_−=1.
- **Paczynski light curve**: u(t)=√(u₀²+((t−t₀)/t_E)²), symmetric about t₀; A_max=A(u₀); Einstein timescale t_E=θ_E/μ_rel (days–months for Galactic events).
- **Optical depth** τ = sky fraction covered by Einstein disks; toward LMC (MACHO/EROS dark-matter test, ≲25% halo) and the bulge (~10⁻⁶).
- Binary/planetary microlensing: caustics; a planet perturbs the light curve when an image crosses near it (lensing zone ~0.6–1.6 θ_E). Astrometric microlensing: light-centroid shift, peaks at u=√2 with max 8^{−1/2}θ_E (Paczyński 1998; measures the lens mass). Quasar microlensing: stars in the lens galaxy micro-caustic-network a multiply-imaged QSO → constrains source size. Source: Wambsganss in Schneider+2006, Part 4; Paczyński 1986; Mao & Paczyński 1991.

## Lensing Statistics
- **Cross-section** σ_Q = source-plane solid angle giving imaging property Q. Point mass: σ(μ)=πθ_E²·2(μ/√(μ²−1)−1) ⇒ σ∝μ⁻² at high μ (hence p(μ)∝μ⁻³). SIS multiple-imaging: σ=πθ_E² (∝σ_v⁴).
- **Optical depth** τ(Q)=∫dw f_K²(w)∫dχ n_com(w,χ)σ(Q); for SIS galaxies τ∝n_com(σ_v/c)⁴ × cosmological volume factor (sensitive to Ω_Λ).
- **Magnification bias**: N(>S)=(1/⟨μ⟩)∫p(μ)N₀(>S/μ)dμ; for power-law counts N₀∝S^{−β} the slope is preserved, counts unchanged at β=1, strongly boosted as β→2 (∵ p(μ)∝μ⁻³). Explains extreme apparent luminosities (F10214 μ~50, cB58 μ~30) and lensed high-z galaxies behind clusters. Source: Schneider+2006 Part 1 §5; Kochanek Part 2 §6.

## Software Packages
- **lenstronomy**: Python, parametric + pixelated modeling (Birrer et al.)
- **PyAutoLens**: Python, automated modeling with MCMC/nested sampling (Nightingale et al.)
- **glafic**: C, fast parametric modeling (Oguri 2010)
- **GRALE**: Free-form mass reconstruction (Liesenborgs et al.)

## AGEL Project Conventions
- AGEL (Astro-Gravitational Einstein Lenses) uses SIE+shear models in lenstronomy
- Key parameters: θ_E, e1, e2 (ellipticity), γ1, γ2 (external shear), center_x, center_y
- Source modeled as Sersic profile; PSF convolution for HST/JWST data
- MCMC fitting via FittingSequence with model_parameters.py pattern
- Velocity dispersion measurements (ppxf) break the mass-sheet degeneracy
