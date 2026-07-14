# Verification and Validation — Learning to Lens

This document describes the verification procedures used to ensure that all
mathematical content in the Learning to Lens tutorial is correct.

## Guiding Principle

**All mathematical derivations and symbolic results in this tutorial have been
verified deterministically using Wolfram Mathematica's computer algebra system
— not generated probabilistically by an LLM.**

Although Claude (Anthropic) co-wrote the LaTeX prose and Mathematica code, every
equation, identity, and worked solution was checked by running companion `.wl`
scripts via `wolframscript`, which performs exact symbolic computation. The AI
assistant was used for drafting and structuring; Mathematica is the source of
mathematical truth.

---

## Three Levels of Verification

### Level 1: Symbolic Derivation (per-module `.wl` scripts)

Each module has a dedicated Wolfram Language script that symbolically derives
and verifies the key results for that module:

| Module | Script | Key Verifications |
|--------|--------|-------------------|
| 1a | `lorentz_transforms.wl` | Metric preservation under boosts/rotations, rapidity addition, four-velocity norm = -1 |
| 1b | `christoffel_symbols.wl` | Christoffel symbols for 2-sphere and polar coords, Riemann tensor (flat space = 0, sphere = 2/R²), geodesic verification |
| 1c | `schwarzschild_metric.wl` | All 10 Ricci components = 0 (vacuum solution), Kretschner scalar = 12Rs²/r⁶ |
| 1d | `geodesic_equation.wl` | ISCO at r=6GM/c², photon sphere at r=3GM/c², Mercury precession = 43.0"/century |
| 1e | `weak_field_metric.wl` | Newtonian limit, Schwarzschild weak-field expansion, deflection integral = 2/b |
| 2 | `deflection_angle.wl` | Deflection integral ∫(1-u³)/(1-u²)^{3/2}du = 2, solar deflection = 1.75", Shapiro delay |
| 3 | `friedmann_equations.wl` | FRW Christoffel symbols, Friedmann equations from Ricci tensor, D_A turnover at z~1.6 |
| 4 | `lens_equation.wl` | Point mass image positions, magnification μ_total > 1 always, Σ_cr numerical values |
| 5 | `lensing_potential.wl` | ∇²ψ = 2κ, point mass κ/γ/μ, consistency with Module 4 |
| 6 | `time_delay_function.wl` | ∇τ = 0 recovers lens equation (Fermat's principle), time delay formulas |
| 7 | `axisymmetric_models.wl` | SIS constant deflection, κ = γ for SIS, NIS → SIS limit, NFW profiles |
| 8 | `critical_curves_caustics.wl` | SIE critical curves, image solver to machine precision, Burke's theorem |
| 9 | `galaxy_lensing.wl` | Mass-sheet degeneracy preserves image positions, H₀ from time delays |
| 8 | `multipole_expansion.wl` | Angular-structure multipoles: κ_m = a_m(1−m²)/(2θ)cos[m(φ−φ_m)], monopole→SIS, external shear κ=0, SIE internal-quadrupole fraction 1/4 (7/7) |
| 9 | `substructure_and_rings.wl` | Isothermal ring κ=(b/2r)(F+F″), fold-caustic flux relation μ₊=−μ₋, surface-brightness conservation μ=1/detA (6/6) |
| 10 | `cluster_lensing.wl` | NFW cluster-scale lensing, Einstein radius vs mass scaling |
| 11 | `lensing_statistics.wl` | Point-mass cross-section σ(μ)=πθ_E²y²(μ) with σ∝μ⁻² (⇒ p(μ)∝μ⁻³), SIS μ=2/y & r=(1+y)/(1−y), β=1 magnification-bias null (9/9) |
| 12 | `weak_lensing.wl` | Kaiser–Squires inversion recovers κ, tangential shear γ_t=θ_E/(2θ) [SIS], reduced-shear invariance under the mass-sheet transform (10/10) |
| 13 | `microlensing.wl` | Point-lens A(u)=(u²+2)/(u√(u²+4)) from summed image magnifications, limits A→1/u, 1; Paczynski light-curve symmetry; astrometric centroid shift peaks at u=√2 (16/16) |

To run all per-module verifications:
```bash
for f in Mathematica/*/[a-z]*.wl; do
    echo "=== $f ==="
    wolframscript -file "$f"
    echo ""
done
```

### Level 2: Cross-Validation Against Standard Tools

Our custom GR computation functions (`computeChristoffel`, `computeRiemann`,
`computeRicci`, `computeRicciScalar`) have been cross-validated against
Mathematica's built-in `ResourceFunction` tools:

| Function | ResourceFunction | Result |
|----------|-----------------|--------|
| `computeChristoffel` | `ResourceFunction["ChristoffelSymbol"]` | **Exact match** (2-sphere and Schwarzschild) |
| `computeRicciScalar` | `ResourceFunction["RicciScalar"]` | **Matches** for 2-sphere (R = 2/R²) |
| `computeRiemann` | `ResourceFunction["RiemannTensor"]` | Cannot compare directly (RF returns opaque object, not array) |
| `computeRicci` | `ResourceFunction["RicciTensor"]` | Cannot compare directly (RF returns opaque object, not array) |

For the Riemann and Ricci tensors where direct comparison is not possible
(due to the ResourceFunction API returning non-array objects), we verify
correctness indirectly:
- The Ricci tensor contracts correctly to the Ricci scalar (which matches the ResourceFunction)
- The Schwarzschild Ricci tensor is identically zero (vacuum solution)
- All downstream results (ISCO, photon sphere, precession, deflection) match textbook values

### Level 3: Cross-Validation Against Textbook Equations

The master verification script `Mathematica/verify_against_textbooks.wl` checks
all key results against published equations in:

- **Carroll, S.** — *Spacetime and Geometry* (2004): eqs. 5.1, 5.3, 5.12, 5.50, 5.66, 5.70, 5.74, 5.92–5.98
- **Congdon, A.B. & Keeton, C.R.** — *Principles of Gravitational Lensing* (2018): eqs. 3.61, 3.71, 3.80, 3.87–3.96, 4.9, 4.10
- **Narayan, R. & Bartelmann, M.** — *Lectures on Gravitational Lensing* (1997)

To run the master verification:
```bash
wolframscript -file Mathematica/verify_against_textbooks.wl
```

**Current result: 12/12 tests pass.**

| Test | Textbook Reference | Expected | Verified |
|------|-------------------|----------|----------|
| Christoffel (2-sphere) = ResourceFunction | Carroll eq. 3.27 | Match | ✓ |
| Christoffel (Schwarzschild) = ResourceFunction | Carroll eq. 5.12 | Match | ✓ |
| Γ^t_{tr} = Rs/(2r(r-Rs)) | Carroll eq. 5.12 | Exact | ✓ |
| Γ^r_{tt} = Rs(r-Rs)/(2r³) | Carroll eq. 5.12 | Exact | ✓ |
| R_μν = 0 for Schwarzschild | Carroll eq. 5.3 | All zero | ✓ |
| R = 2/R² for 2-sphere | Standard result | Exact | ✓ |
| RicciScalar ResourceFunction agrees | — | Match | ✓ |
| Mercury precession = 43.0"/century | Carroll eq. 5.98 | 43.0 | ✓ |
| Solar deflection = 1.75" | C&K eq. 3.96 | 1.75 | ✓ |
| ∫₀¹(1-u³)/(1-u²)^{3/2} du = 2 | C&K eq. 3.95 | 2 (exact) | ✓ |
| D_A turnover at z ~ 1.6 | Carroll Sec. 8.4 | z = 1.6 | ✓ |
| D_ds ≠ D_s - D_d | C&K Sec. 3.5 | Confirmed | ✓ |

---

## Tools Used

| Tool | Version | Purpose |
|------|---------|---------|
| Wolfram Mathematica | 14.0+ | Primary symbolic computation engine |
| `wolframscript` | (bundled) | Headless script execution for all `.wl` files |
| `ResourceFunction["ChristoffelSymbol"]` | Wolfram Function Repository | Cross-validation of Christoffel symbols |
| `ResourceFunction["RicciScalar"]` | Wolfram Function Repository | Cross-validation of Ricci scalar |
| xAct (xTensor + xCoba) | 1.2.0 | Installed for professional tensor algebra (available but not primary tool) |
| pdflatex (TeX Live 2025) | 2025 | LaTeX compilation |

---

## Reproducibility

All verification can be reproduced by anyone with Mathematica installed:

```bash
# Clone the repository
git clone https://github.com/rodelcr/Learning_to_Lens.git
cd Learning_to_Lens

# Run the master verification (requires wolframscript)
wolframscript -file Mathematica/verify_against_textbooks.wl

# Run all per-module verifications
for f in Mathematica/*/[a-z]*.wl; do
    echo "=== $f ==="
    wolframscript -file "$f"
done

# Run all solution verifications
for f in Solutions/*/problems_*.wl; do
    echo "=== $f ==="
    wolframscript -file "$f"
done
```

---

## What This Does NOT Verify

- **Prose accuracy**: The expository text was co-written with Claude and reviewed
  by the author, but has not been independently reviewed by a third party.
- **Pedagogical completeness**: The tutorial covers the standard material but may
  not include every subtlety or edge case.
- **Notebook interactivity**: The `.nb` notebooks with `Manipulate[]` widgets
  require the Mathematica GUI to evaluate and have not been tested headlessly.
- **xAct integration**: xAct is installed but not used as a primary computation
  tool. The xCoba component extraction API is complex and was not integrated
  into the verification pipeline.

---

*Last verified: 2026-07-14*
*Verification script: `Mathematica/verify_against_textbooks.wl`*
*Master cross-checks: 12/12 passing. Per-module extension scripts added
2026-07-14 (Schneider, Kochanek & Wambsganss 2006 gap-fill): Module 8
multipole (7/7), Module 9 substructure/rings (6/6), Module 11 statistics
(9/9 + 8/8 solutions), Module 12 weak lensing (10/10 + solutions),
Module 13 microlensing (16/16 + solutions). A BibTeX bibliography
(`Notes/references.bib`, natbib) now backs all citations.*
