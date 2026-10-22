---
name: gr-lensing-intuition
description: >
  Physical intuition and domain knowledge for general relativity and strong
  gravitational lensing. This skill should be used when working on gravitational
  lensing research, lens modeling, writing or reviewing GR derivations, building
  lensing tutorial content, or any task involving deflection angles, lens
  equations, convergence/shear, critical curves, caustics, time delays, or
  cosmological distance calculations. Activates for terms like 'Einstein radius',
  'lens equation', 'SIE model', 'NFW profile', 'mass-sheet degeneracy',
  'time-delay cosmography', 'deflection angle', 'convergence', 'shear',
  'critical curve', 'caustic', 'Fermat potential', 'weak lensing',
  'cosmic shear', 'Kaiser-Squires', 'aperture mass', 'galaxy-galaxy lensing',
  'microlensing', 'Paczynski light curve', 'Einstein timescale',
  'lensing statistics', 'cross-section', 'optical depth', 'magnification bias',
  'flux-ratio anomaly', 'substructure', 'multipole expansion',
  'Einstein-ring reconstruction', 'external convergence', 'double source plane',
  'DSPL', 'compound lens', 'multi-plane', 'radial image', 'central image', or
  references to lenstronomy, PyAutoLens, herculens, or the AGEL project.
---

# GR & Gravitational Lensing Intuition

## Purpose

Provide physical intuition, domain knowledge, and order-of-magnitude reasoning
for general relativity applied to strong gravitational lensing. Covers the full
chain from metric theory through lens modeling to cosmographic applications.

## When to Use

- Writing or reviewing GR derivations (metrics, geodesics, curvature)
- Building or editing Learning to Lens tutorial modules
- Choosing lens models for research (point mass, SIS, SIE, NFW, power-law)
- Interpreting critical curves, caustics, and image topology
- Estimating lensing observables (Einstein radii, time delays, magnifications)
- Working on AGEL lens modeling or time-delay cosmography
- Debugging lenstronomy / PyAutoLens model setups
- Weak lensing / cosmic shear (shear estimators, Kaiser–Squires, aperture mass,
  galaxy–galaxy lensing) and lensing statistics (cross-sections, optical depth,
  magnification bias)
- Microlensing (point-lens light curves, Einstein timescale, optical depth to
  the bulge/LMC, astrometric and quasar microlensing)
- Substructure / flux-ratio anomalies, multipole angular structure, and
  Einstein-ring / extended-source reconstruction

Note: the *Learning to Lens* tutorial is now **25 chapters in five parts**
(module dirs 01a–13 + 14–21; three editions: student / instructor / annotated
study). Part IV (Modules 11–13: Lensing Statistics, Weak Lensing & Cosmic Shear,
Microlensing) was added 2026-07-14 from Schneider, Kochanek & Wambsganss (2006);
Part V (Modules 14–21 = PDF Chapters 18–25: multi-plane/DSPL, power law + point
mass, odd/central images, central-mass bias, multi-plane MSD, multipoles,
cosmological sensitivity, perturbative estimators) was ported 2026-10-14 from the
AGEL `202607_Theoretical_spiral_compound` study notes and merged to `main` 2026-10-21.
Citations are backed by `Notes/references.bib` (natbib) — **never fabricate a
citation**; verify metadata via Zotero/CrossRef/ISBN.

## Core Principles

### The Metric Encodes Everything
In GR, the metric g_μν determines all gravitational physics. For lensing, the
weak-field metric ds² = -(1+2Φ/c²)c²dt² + (1-2Φ/c²)dℓ² is almost always
sufficient. Light sees both temporal and spatial curvature equally, giving twice
the Newtonian deflection: α̂ = 4GM/(c²b).

### The Lens Equation
The thin-lens approximation reduces 3D propagation to a 2D mapping:
β = θ - α(θ). The Einstein radius θ_E sets the characteristic angular scale;
convergence κ = Σ/Σ_cr determines lensing strength.

### Image Topology
Images appear/disappear in pairs at caustic crossings. Total count is always odd
(Burke's theorem), but the faint central image is usually unobservable. Source
inside caustic → more images; outside → fewer.

### Key Degeneracy
The mass-sheet degeneracy (MSD) preserves all image positions but changes
magnifications (×1/λ²), time delays (×λ), and inferred H₀ (×1/λ). Breaking it
requires stellar kinematics, multiple source planes, or standardizable
magnifications. The MSD generalizes across N planes (Schneider 2014, A&A 568 L2;
Schneider 2019, A&A 624 A54; Teodori 2026) — a second source plane does NOT
remove it; it only changes which combination of sheets is degenerate.

### Compound-Lens Cosmography
DSPLs measure the H₀-free ratio 𝓑 = (D_ls1·D_s2)/(D_s1·D_ls2) = η^(γ′−1).
Empirical state of the art (2026): lensing-only DSPL cosmology is
mass-model-fragile; a stellar-kinematics likelihood is the stabiliser; per-plane
slope errors are coherent (they stack, not average down); line of sight enters
𝓑 at the ~1% level. See the "Compound-Lens (DSPL) Cosmography" section of
`references/domain-knowledge.md` for the benchmark systems (J0946, Carousel,
AGEL DSPLs) and the notation/identity traps.

The generic derivations behind this section are now textbook chapters: Learning to Lens Part V (PDF chapters 18–25, module dirs 14–21), each with a Wolfram-attested script.

## Workflow

1. **Identify the physical regime** — weak-field vs. strong-field, galaxy-scale
   vs. cluster-scale, point source vs. extended source.
2. **Load domain knowledge** — read `references/domain-knowledge.md` for
   detailed formulas, lens model selection guide, critical curve / caustic
   rules, degeneracies, cosmological distance relations, order-of-magnitude
   estimates, and software package conventions.
3. **Select the appropriate lens model** — point mass for microlensing, SIS for
   quick analytic estimates, SIE+shear for realistic galaxy modeling, NFW for
   clusters. See the model selection guide in `references/domain-knowledge.md`.
4. **Apply order-of-magnitude checks** — use the quick formulas to verify that
   results are physically reasonable before detailed computation.
5. **Watch for common pitfalls**:
   - D_ds ≠ D_s - D_d (must compute from comoving distances)
   - D_A is not monotonic (turns over at z ~ 1.6)
   - Einstein radius constrains enclosed mass, not the density profile
   - MSD is the dominant systematic in time-delay cosmography
   - **Burke's count needs a smooth Σ.** With a point mass (SMBH) the arrival
     surface has τ→+∞ at the hole, the image count becomes *even*, and the
     central image is swallowed (4→2 at the annihilation boundary; Ch. 20–21).
   - **Schneider 2014 ≠ Schneider 2019.** A&A 568 L2 (2014) is the "can one
     determine cosmological parameters from multi-plane lenses?" letter; the
     generalized multi-plane MST paper is A&A 624 A54 (2019; arXiv 1409.0015).
   - **Convention mismatch:** Kochanek's Part 2 (Schneider+2006) normalizes the
     multipole convergence differently from this tutorial's ∇²ψ = 2κ. Re-derive
     in-convention with Mathematica rather than copying his eq. verbatim — the
     factor bit the Module 8 multipole κ_m derivation.
   - The point-mass magnification **cross-section scales as σ ∝ μ⁻²** (not μ⁻¹),
     which is what yields the universal p(μ) ∝ μ⁻³ high-magnification tail.
   - Weak lensing measures the **reduced** shear g = γ/(1−κ), not γ — the weak-
     lensing mass-sheet degeneracy (κ→λκ+(1−λ), γ→λγ) leaves g invariant.

## Reference

- `references/domain-knowledge.md` — full domain knowledge: lens models,
  formulas, critical curves, degeneracies, cosmological distances,
  order-of-magnitude estimates, software packages, AGEL conventions
