# Learning to Lens

**An Introduction to General Relativity and Strong Gravitational Lensing — with Mathematica**

A 14-module tutorial suite (199 student pages / 245 instructor pages, ~100 exercises, ~75 figures) designed for advanced undergraduate and early graduate students learning gravitational lensing theory and modeling. Each module pairs **LaTeX lecture notes** with **Wolfram Mathematica** notebooks and scripts for symbolic derivations, numerical computations, and interactive visualizations.

---

## Prerequisites

### Knowledge
- Multivariable calculus and linear algebra
- Introductory physics (classical mechanics, electromagnetism)
- Familiarity with special relativity is helpful but not required (Module 1a covers it)

### Software

| Software | Version | Purpose | Required? |
|----------|---------|---------|-----------|
| **Wolfram Mathematica** | 13.0+ | Primary computational tool | **Yes** |
| **LaTeX distribution** | TeX Live 2023+ or MacTeX | Compile lecture notes | Yes (to build PDFs) |
| **Git** | 2.0+ | Version control | Yes |
| **Conda** (Miniconda/Anaconda) | any | Manage LaTeX environment | Optional |

### Installing Mathematica

1. Obtain a license from [Wolfram](https://www.wolfram.com/mathematica/) (free for many universities)
2. Install Mathematica and verify `wolframscript` works from the terminal:
   ```bash
   wolframscript -code "Print[\"Mathematica is ready! Version: \", $VersionNumber]"
   ```

### Installing LaTeX

**macOS (recommended):**
```bash
# Option A: Full MacTeX distribution (~4 GB)
brew install --cask mactex

# Option B: Minimal TeX Live via conda (see environment.yml)
conda env create -f environment.yml
conda activate learning_to_lens
```

**Linux:**
```bash
sudo apt-get install texlive-full  # Ubuntu/Debian
# or
sudo dnf install texlive-scheme-full  # Fedora
```

### Installing the xAct Tensor Algebra Package (used in later modules)

[xAct](http://www.xact.es/) is a free Mathematica suite for tensor algebra in GR. Modules 1a–3 use Mathematica built-ins; later modules use xAct for heavier computations.

```bash
# Download from http://www.xact.es/download.html
# Unpack into your Mathematica Applications directory:
#   macOS: ~/Library/Mathematica/Applications/
#   Linux: ~/.Mathematica/Applications/
```

Or install from within Mathematica:
```mathematica
(* Run in a Mathematica notebook *)
Import["https://raw.githubusercontent.com/xAct-contrib/xAct/master/xAct/xTras/xTrasInstaller.m"]
```

---

## Getting Started

```bash
# Clone the repository
git clone https://github.com/rodelcr/Learning_to_Lens.git
cd Learning_to_Lens

# (Optional) Create conda environment for LaTeX tools
conda env create -f environment.yml
conda activate learning_to_lens

# Build the LaTeX notes (produces two PDFs in Output/)
#   Output/Learning_to_Lens.pdf           — student edition (199 pp)
#   Output/Learning_to_Lens_Solutions.pdf  — instructor edition with solutions (245 pp)
cd Notes && bash build.sh

# Open a Mathematica notebook (macOS)
open Mathematica/01a_Special_Relativity/four_vectors.nb

# Run a Mathematica script from the terminal
wolframscript -file Mathematica/01a_Special_Relativity/lorentz_transforms.wl
```

---

## Module Curriculum

### Part I: General Relativity Foundations

| Module | Title | Key Topics |
|--------|-------|------------|
| **1a** | Special Relativity & Tensor Basics | Lorentz transforms, 4-vectors, Minkowski metric |
| **1b** | Differential Geometry & Metric Tensor | Christoffel symbols, covariant derivative, curvature tensors, computation cookbook |
| **1c** | The Schwarzschild Solution | Equivalence principle, Schwarzschild metric, time dilation, redshift, interior, isotropic coords |
| **1d** | Geodesics & Orbits | Effective potential, ISCO, photon sphere, perihelion precession, Kerr overview |
| **1e** | Linearized Gravity & Weak-Field Metric | Metric perturbation, Newtonian limit, effective refractive index, superposition |

### Part II: Gravitational Lensing Theory

| Module | Title | Key Topics |
|--------|-------|------------|
| **2** | Light Deflection | Soldner's calculation, GR deflection angle, Shapiro delay |
| **3** | Cosmological Distances | FRW metric (full derivation), Friedmann equations, angular diameter distances |
| **4** | The Lens Equation | Thin screen, Einstein radius, point mass imaging, critical density |
| **5** | Magnification, Convergence & Shear | Lensing potential, Jacobian, convergence, shear, distortion |
| **6** | Fermat's Principle & Time Delays | Arrival-time surface, Morse theory, H₀ cosmography |

### Part III: Lens Models and Applications

| Module | Title | Key Topics |
|--------|-------|------------|
| **7** | Axisymmetric Models | SIS, NIS, NFW profiles |
| **8** | Elliptical Models & Critical Curves | SIE, external shear, caustics, image topology |
| **9** | Galaxy Lensing Applications | Mass-sheet degeneracy, lensing + kinematics, time-delay cosmography |
| **10** | Cluster Lensing | NFW clusters, giant arcs, cosmic telescope, weak lensing intro |

---

## Repository Structure

```
Learning_to_Lens/
├── Notes/                     # LaTeX lecture notes (one subdir per module)
│   ├── preamble.tex           # Shared preamble with physics macros
│   ├── main.tex               # Master document
│   ├── build.sh               # Build script (pdflatex)
│   └── XX_ModuleName/         # Module .tex source
├── Mathematica/               # Mathematica files (one subdir per module)
│   └── XX_ModuleName/
│       ├── *.wl               # Scripts (symbolic derivations, run via wolframscript)
│       └── *.nb               # Notebooks (plots, interactive Manipulate[] widgets)
├── Solutions/                 # Worked problem solutions (.nb notebooks)
│   └── XX_ModuleName/
├── Figures/                   # Exported figures (PDF, for LaTeX inclusion)
│   └── XX_ModuleName/
├── environment.yml            # Conda environment specification
├── CLAUDE.md                  # Project context for Claude Code
├── PROGRESS_LOG.md            # Timestamped work log
└── repo_preferences.md        # Default repo conventions
```

### File Types

- **`.wl` (Wolfram Language scripts):** Symbolic derivations and tensor computations. Run headlessly: `wolframscript -file script.wl`
- **`.nb` (Mathematica notebooks):** Interactive content with plots and `Manipulate[]` widgets. Open in the Mathematica GUI.
- **`.tex` (LaTeX):** Lecture notes with derivations and cross-links to Mathematica files.

---

## Reference Texts

These notes draw from the following texts (not included in the repository due to copyright):

- **Carroll, S.** — *Spacetime and Geometry: An Introduction to General Relativity*
- **Congdon, A.B. & Keeton, C.R.** (2018) — *Principles of Gravitational Lensing*
- **Narayan, R. & Bartelmann, M.** (1997) — *Lectures on Gravitational Lensing* ([arXiv:astro-ph/9606001](https://arxiv.org/abs/astro-ph/9606001))
- **Saha, P. et al.** (2024) — *Essentials of Strong Gravitational Lensing* ([doi:10.1007/s11214-024-01041-w](https://doi.org/10.1007/s11214-024-01041-w))
- **Meneghetti, M.** (2021) — *Introduction to Gravitational Lensing*
- **Schneider, P., Ehlers, J. & Falco, E.E.** (1992) — *Gravitational Lenses*
- **Petters, A.O., Levine, H. & Wambsganss, J.** (2001) — *Singularity Theory and Gravitational Lensing*

---

## Author

**Rodrigo Córdova Rosado**
Harvard-Smithsonian Center for Astrophysics
[rodrigo.cordova_rosado@cfa.harvard.edu](mailto:rodrigo.cordova_rosado@cfa.harvard.edu)

Built with assistance from [Claude Code](https://claude.ai/claude-code).

---

## License

The tutorial content (notes, code, and figures) in this repository is licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). You are free to share and adapt this material with attribution.
