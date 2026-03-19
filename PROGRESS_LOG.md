# Progress Log — Learning to Lens

Timestamped record of major milestones and work completed.

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
