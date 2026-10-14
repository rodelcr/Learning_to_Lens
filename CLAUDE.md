# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Learning to Lens** is a 14-module educational tutorial suite teaching general relativity and strong gravitational lensing to advanced undergraduate / early graduate students. Each module pairs **LaTeX lecture notes** (`Notes/`) with **Wolfram Mathematica** scripts and notebooks (`Mathematica/`, `Solutions/`).

**Project lead:** Rodrigo Córdova Rosado (rodrigo.cordova_rosado@cfa.harvard.edu, Harvard CfA)

## Guiding principle: Mathematica is the source of mathematical truth

Every symbolic derivation, identity, and worked solution in this tutorial is verified **deterministically by Mathematica**, not generated probabilistically by an LLM. Claude is used for drafting LaTeX prose and Mathematica code structure; `wolframscript` running the `.wl` files is what makes a result trustworthy. See `VERIFICATION.md` for the full three-tier verification scheme (per-module → `ResourceFunction` cross-check → textbook cross-check, currently **28/28 tests passing**).

When adding or changing a derivation:
1. Update the relevant `Mathematica/XX_ModuleName/*.wl` so its symbolic check still passes under `wolframscript`.
2. Re-run the master verification (`Mathematica/verify_against_textbooks.wl`) if the change touches any of its 12 cross-checks.
3. Only then update the LaTeX prose in `Notes/XX_ModuleName/`.

## Repository Structure

```
Learning_to_Lens/
├── Notes/                     # LaTeX source (one subdir per module) + build.sh
│   ├── preamble.tex           # Shared physics macros — all modules use it
│   ├── main.tex               # Master document (\include per module)
│   └── XX_ModuleName/
├── Mathematica/               # One subdir per module
│   ├── verify_against_textbooks.wl   # Master verification (12 textbook checks)
│   ├── generate_figures_01abc.wl     # Batch figure export for early modules
│   └── XX_ModuleName/
│       ├── *.wl               # Symbolic derivations (run via wolframscript)
│       └── *.nb               # Plots, Manipulate[] widgets (Mathematica GUI)
├── Solutions/                 # Worked problems (one subdir per module)
│   └── XX_ModuleName/problems_XX.wl
├── Figures/XX_ModuleName/     # PDF figures exported from .wl/.nb, included by LaTeX
├── Output/                    # Built PDFs (Learning_to_Lens.pdf + _Solutions.pdf)
├── Reference_Texts/           # Copyrighted source PDFs — git-ignored, never commit
├── VERIFICATION.md            # Verification procedures and test results
├── DEPLOYMENT.md              # GitHub Pages publishing flow
├── PROGRESS_LOG.md            # Timestamped work log
└── repo_preferences.md        # Reusable cross-project conventions
```

## Module Curriculum (25 chapters in 5 parts; module ids 01a–13 + 14–21)

| # | Module | Key Topics |
|---|--------|------------|
| 1a | Special Relativity & Tensor Basics | Lorentz transforms, 4-vectors, Minkowski metric |
| 1b | Differential Geometry & Metric Tensor | Christoffel symbols, covariant derivative, curvature tensors |
| 1c | The Schwarzschild Solution | Vacuum solution, time dilation, redshift, interior, isotropic coords |
| 1d | Geodesics & Orbits | Effective potential, ISCO, photon sphere, perihelion precession, Kerr overview |
| 1e | Linearized Gravity & Weak-Field Metric | Metric perturbation, Newtonian limit, effective refractive index |
| 2 | Light Deflection | Soldner, GR deflection angle, Shapiro delay |
| 3 | Cosmological Distances | FRW metric, Friedmann equations, angular diameter distances |
| 4 | The Lens Equation | Thin screen, Einstein radius, point mass imaging, critical density |
| 5 | Magnification, Convergence & Shear | Lensing potential, Jacobian, κ, γ, distortion |
| 6 | Fermat's Principle & Time Delays | Arrival-time surface, Morse theory, H₀ cosmography |
| 7 | Axisymmetric Models | SIS, NIS, NFW profiles |
| 8 | Elliptical Models & Critical Curves | SIE, external shear, caustics, image topology |
| 9 | Galaxy Lensing Applications | Mass-sheet degeneracy, lensing + kinematics, time-delay cosmography |
| 10 | Cluster Lensing | NFW clusters, giant arcs, cosmic telescope, weak lensing intro |

## Common Commands

```bash
# Build all THREE PDFs (student + instructor + annotated study editions) into Output/
cd Notes && bash build.sh            # asserts: no '??', no undefined refs, page ordering, no annotation leakage
#   -> Output/Learning_to_Lens.pdf            (student)
#   -> Output/Learning_to_Lens_Solutions.pdf  (instructor, via \def\showsolutions{})
#   -> Output/Learning_to_Lens_Annotated.pdf  (annotated study edition, via \def\showsolutions{}\def\showannotated{})
#   -> Output/build_fingerprints.txt          (page counts + text-md5; student/instructor must not change on annotation-only commits)
# Run any Mathematica script through the 3-kernel semaphore (never >3 kernels at once):
bash Mathematica/run_wl.sh Mathematica/15_PowerLaw_PointMass/power_law_point_mass.wl

# Master verification — must pass 28/28 before any release (12 original + 16 Part V cross-checks)
wolframscript -file Mathematica/verify_against_textbooks.wl

# Run all per-module symbolic checks
for f in Mathematica/*/[a-z]*.wl; do
    echo "=== $f ===" && wolframscript -file "$f"
done

# Run all solution-set checks
for f in Solutions/*/problems_*.wl; do
    echo "=== $f ===" && wolframscript -file "$f"
done

# Run a single module's symbolic derivation
wolframscript -file Mathematica/01a_Special_Relativity/lorentz_transforms.wl

# Open a notebook or script by partial name (macOS helper, opens in Mathematica GUI)
./open_notebook.sh four_vectors       # opens any file matching *four_vectors*
./open_notebook.sh 01a                # opens all files in module 01a
./open_notebook.sh                    # list every .wl and .nb in the repo
```

For the GitHub Pages publish flow (`rodelcr.github.io/assets/pdf/`), see `DEPLOYMENT.md`.

### Wolfram MCP tools (added 2026-10-14)

Two MCP servers are registered at user scope (`~/.claude.json`, so they are available in every project):

| Server | What it is | Use it for |
|---|---|---|
| `Wolfram` | **Local** `Wolfram/AgentTools` server (stdio, Mathematica 15.0 kernel on this Mac). Tools: `WolframLanguageEvaluator`, `WolframLanguageContext` (doc search), `SymbolDefinition`, `CodeInspector`, `TestReport`, `ReadNotebook`, `WriteNotebook`. | Iterating on a derivation before it goes into a `.wl`: evaluate a snippet in ~0.1 s instead of a 5–20 s `wolframscript` start-up per try. Pass `session="ltl"` on every call so definitions persist; `SetDirectory` to the repo and `Get["Mathematica/harness.wl"]` once, then `check[]` as usual. A whole script can be run with `Get["Mathematica/NN/x.wl"]`. |
| `WolframCloud` | **Hosted** `https://agenttools.wolfram.com/mcp` (no auth; stateless Wolfram Cloud Linux kernel, no access to this filesystem). Tools: `WolframLanguageEvaluator`, `WolframContext`, `WolframAlpha`. | Wolfram\|Alpha lookups and documentation search without spending a local kernel. Not for repo scripts. |

Rules that still hold:
- **The committed `.wl` run under `wolframscript` is the source of truth.** MCP evaluations are scratch work; every result that reaches the prose must be a `check[]` in a `.wl` that passes via `bash Mathematica/run_wl.sh`, and the SUMMARY line quoted from that run.
- **The local server's kernel counts as one of the three allowed kernels.** While the `Wolfram` MCP is connected, run at most two `run_wl.sh` jobs alongside it (the semaphore does not know about it).
- `harness.wl` detects the MCP kernel (`MCP_SERVER_NAME` env var): output goes through `Print` (the evaluator does not capture `WriteString["stdout"]`) and `summary[]` returns `<|"pass","fail"|>` instead of `Exit[]`, which would kill the server's persistent kernel. `resetChecks[]` zeroes the tally between scripts. Under `wolframscript` nothing changed.
- Reinstall / repair with `InstallMCPServer["ClaudeCode","WolframLanguage"]` from `Wolfram`AgentTools``; verify with `claude mcp get Wolfram`.

## Key Conventions

### File types
- **`.wl`** — Symbolic derivations and tensor computations. Run headlessly via `wolframscript`. **Every `.wl` must have a header block** (purpose, inputs, outputs, source reference).
- **`.nb`** — Plots, `Manipulate[]` widgets, interactive explorations. Open in the Mathematica GUI; **do not** try to evaluate headlessly. Notebooks must be self-contained (no reliance on globals from other notebooks).
- **`.tex`** — Lecture notes. All modules include the shared `Notes/preamble.tex`. Cross-link to Mathematica artefacts as `\href{../Mathematica/XX_ModuleName/file.nb}{description}`. Custom physics macros live in the preamble — read it before introducing new notation.

### Tensor algebra: built-ins, not xAct
The verified computation pipeline uses Mathematica built-ins plus custom functions `computeChristoffel` / `computeRiemann` / `computeRicci` / `computeRicciScalar`, cross-validated against `ResourceFunction["ChristoffelSymbol"]` and `ResourceFunction["RicciScalar"]`. **xAct is installed but is NOT the primary tool** — its xCoba component-extraction API was not integrated into the verification pipeline. Stick to the existing functions unless you also extend the verification scheme.

### Source-reference discipline
Every derivation cites the textbook equation it follows (e.g., "Carroll eq. 5.42", "Congdon & Keeton eq. 3.95", "Narayan & Bartelmann eq. 7"). Reference texts are listed in `README.md`; the source PDFs themselves live in the git-ignored `Reference_Texts/`. **Do not fabricate citations** — if the closest precedent is partial, say so honestly.

### Three-edition build
`build.sh` produces the student PDF (no solutions), the instructor PDF (with solutions) and the **Annotated Study Edition** (solutions + an annotation layer) by passing `\def\showsolutions{}` / `\def\showannotated{}` at compile time. The switches live in `Notes/main.tex` (`\ifsolutions`, `\ifannotated`; annotated implies solutions); the per-module `NN_Solutions.tex` files are `\input` only when `\ifsolutions` is true. The annotation layer is three environments defined in `Notes/editions.tex` — `annotation`, `derivation`, `bridge` — which are `comment`-package exclusions in the other two editions, so the student and instructor PDFs are content-identical with or without annotations in the sources (`build.sh` asserts this via text-md5 fingerprints and the uppercase box-title sentinels). **Read the author rules R1–R5 in `editions.tex` before writing an annotation**; in particular a `\\` inside a skipped `\ifannotated` branch within `align` breaks the build. `keybox` and `aside` (GR reminder) in `preamble.tex` are always visible. After any edit, rebuild and check `Output/build_fingerprints.txt`.

## Important Reminders

- **Copyright:** `Reference_Texts/` contains copyrighted textbooks and is git-ignored. Never commit anything from it.
- **Update the test catalog with the work:** changes that touch a verified result should also update `VERIFICATION.md` (the test row + the "Last verified" date) and `PROGRESS_LOG.md`.
- **PDFs don't rebuild themselves:** editing a `.tex` or `.wl` does not update `Output/*.pdf`. Always re-run `cd Notes && bash build.sh` and confirm the page count before claiming a build is done.
