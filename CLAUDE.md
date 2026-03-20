# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Learning to Lens** is an educational tutorial suite teaching strong gravitational lensing theory and modeling to advanced undergraduate / early graduate students. The primary computational tool is **Wolfram Mathematica**, with companion **LaTeX** notes providing derivations and exposition.

**Project lead:** Rodrigo Córdova Rosado (rodrigo.cordova_rosado@cfa.harvard.edu, Harvard CfA)

## Repository Structure

```
Learning_to_Lens/
├── Notes/                     # LaTeX source files (one subdir per module)
│   ├── preamble.tex           # Shared preamble with physics macros
│   ├── main.tex               # Master document (\include for each module)
│   └── XX_ModuleName/         # Module LaTeX source
├── Mathematica/               # Mathematica files (one subdir per module)
│   └── XX_ModuleName/
│       ├── *.wl               # Wolfram Language scripts (symbolic derivations)
│       └── *.nb               # Notebooks (plots, interactive content)
├── Solutions/                 # Worked problem solutions (Mathematica notebooks)
│   └── XX_ModuleName/
├── Figures/                   # Exported figures (PDF) for LaTeX inclusion
│   └── XX_ModuleName/
├── Reference_Texts/           # Source PDFs — COPYRIGHTED, git-ignored
├── PROGRESS_LOG.md            # Timestamped work log
└── repo_preferences.md        # Reusable default repo conventions
```

## Module Curriculum

| # | Module | Key Topics |
|---|--------|------------|
| 1a | Special Relativity & Tensor Basics | Lorentz transforms, 4-vectors, Minkowski metric |
| 1b | Differential Geometry & Metric Tensor | Christoffel symbols, covariant derivative, curvature tensors, computation cookbook |
| 1c | The Schwarzschild Solution | Equivalence principle, Schwarzschild metric, time dilation, redshift, interior, isotropic coords |
| 1d | Geodesics & Orbits | Effective potential, ISCO, photon sphere, perihelion precession, Kerr overview |
| 1e | Linearized Gravity & Weak-Field Metric | Metric perturbation, Newtonian limit, effective refractive index, superposition |
| 2 | Light Deflection | Soldner's calculation, GR deflection angle, Shapiro delay |
| 3 | Cosmological Distances | FRW metric (full derivation), Friedmann equations, angular diameter distances |
| 4 | The Lens Equation | Thin screen, Einstein radius, point mass imaging, critical density |
| 5 | Magnification, Convergence & Shear | Lensing potential, Jacobian, convergence, shear, distortion |
| 6 | Fermat's Principle & Time Delays | Arrival-time surface, Morse theory, H₀ cosmography |
| 7 | Axisymmetric Models | SIS, NIS, NFW profiles |
| 8 | Elliptical Models & Critical Curves | SIE, external shear, caustics, image topology |
| 9 | Galaxy Lensing Applications | Mass-sheet degeneracy, lensing + kinematics, time-delay cosmography |
| 10 | Cluster Lensing | NFW clusters, giant arcs, cosmic telescope, weak lensing intro |

## Key Conventions

### File types
- **`.wl` (Wolfram Language scripts):** Symbolic derivations, tensor computations, integrals. Can run headlessly via `wolframscript -file script.wl`.
- **`.nb` (Mathematica notebooks):** Plots, `Manipulate[]` widgets, interactive explorations. Open in Mathematica GUI.
- **`.tex` (LaTeX):** Lecture notes with derivations, prose, cross-links to Mathematica files.

### Mathematica conventions
- All code must be **thoroughly commented** with `(* ... *)` blocks explaining the physics
- Use built-in Mathematica functions for Modules 1–3; introduce **xAct** (xTensor, xCoba) for heavier tensor algebra in later modules
- Export publication-quality figures to `Figures/XX_ModuleName/` as PDF
- Notebooks should be self-contained: define all variables, don't rely on global state from other notebooks

### LaTeX conventions
- All modules use the shared `preamble.tex` for consistent notation
- Cross-link to Mathematica files using `\href{../Mathematica/XX_ModuleName/file.nb}{description}`
- Custom macros defined in preamble (see `Notes/preamble.tex` for full list)

### Code commenting
- Every `.wl` script: header block with purpose, inputs, outputs, source reference
- Every `.nb` notebook: markdown cells explaining what each section does and why
- Reference textbook equation numbers where applicable (e.g., "cf. Narayan & Bartelmann eq. 14")

## Common Commands

```bash
# Build LaTeX notes
cd Notes && bash build.sh

# Run a Mathematica script
wolframscript -file Mathematica/01a_Special_Relativity/lorentz_transforms.wl

# Open a notebook (macOS)
open Mathematica/01a_Special_Relativity/four_vectors.nb
```

## Important Reminders

- **Copyright:** `Reference_Texts/` contains copyrighted textbooks and must NEVER be committed to git.
- **Source references:** Always cite which textbook/equation a derivation follows (e.g., "Following Carroll eq. 5.42" or "cf. Narayan & Bartelmann 1997, eq. 7").
- **Progress log:** Update `PROGRESS_LOG.md` after completing significant work (new module, major revision, etc.).
