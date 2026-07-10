# NOTES — fact-critic audit of the *Learning to Lens* textbook (2026-07-01)

## TL;DR

Ran the `fact-critic` skill over **all 14 chapters** of the GR→strong-lensing
textbook (`Notes/*/*.tex`). Every numeric claim was recomputed independently in
Python and — for the chapters with symbolic/heavy math — cross-checked against
the chapter's **own companion Mathematica notebook** (`Mathematica/<ch>/*.wl`)
via `wolframscript`. Citations were checked against Zotero + CrossRef and against
the source-text PDFs in `Reference_Texts/`.

- **19 numeric/symbolic fixes applied** across 8 chapters (all independently verified).
- **42 equation-number/reference citation fixes applied** across 10 chapters in a
  follow-up pass — each RE-VERIFIED against the source PDF (page + quote) before
  editing; 23 items left flagged (no standalone numbered equation / physics-judgment /
  unconfirmable citation). Also repaired a broken `\eqref` in ch08.
- **Two systematic problems** found & largely fixed: (1) ~65 wrong source
  **equation-number citations** (42 fixed, 23 flagged); (2) **cosmological
  distance/parameter errors** clustered in the lensing chapters.
- **14 reports** written: `Notes/<ch>/FACT_CRITIC_<ch>_2026-07-01.md`.
- **Document recompiles clean** (210 pp, 2 passes); only pre-existing undefined
  citation is the lone stray `\citep{Birrer2020}` (repo has no `.bib`).
- **Two controller self-corrections** (ch07, ch08) — documented below; both traced to
  not consulting the chapter's own ground truth (its Mathematica notebook / astropy)
  before touching a convention- or cosmology-dependent number.

## Harden pass (2026-07-09) — toward error-free

A second, deeper pass after the initial audit:

- **All 14 companion Mathematica notebooks engine-executed** (Wolfram) — their own
  self-checks pass (R_μν=0, Riemann=0 on the 2-sphere, ∇ψ=α & ∇²ψ=2κ, Fermat→lens
  eq, deflection 1.75″, ISCO r=3, 43″/century, Σ_cr=2.309×10¹⁵, …). Executing them
  caught 2 notebook-vs-text disagreements where the notebook was right and confirmed
  our fix (ch03 D_A-max=1748; ch07 was outputting the stale 1.272″).
- **2 notebook (`.wl`) bugs fixed:** `axisymmetric_models.wl` stale distances
  (1700/1200 → 1652/1055, now outputs 1.15″); `lens_equation.wl` g/cm² unit
  (`*10`→`*0.1`, 59.17→0.59 g/cm²).
- **Every prior fix independently re-verified** (my ch07 θ_E re-correction confirmed
  by astropy; ch08's 6 SIE numbers re-confirmed; the ch07 triple-check caught a
  *second* stale-distance occurrence in an exercise I'd missed).
- **Flagged physics fixed with explanatory prose:** κ>1 parity (05), Shapiro sign +
  H0LiCOW attribution (06), Kerr ergosphere r₊ (01d), Sun-redshift 2× + WEP
  precision + EF-coordinate units (01c), T⁰⁰/T₀₀ index (03), SIE image-count 2→4 &
  oval-not-ellipse (08), H0/MSD label swap (09), cluster mass 2e14→1.3e14 & giant-arc
  priority (10), θ_E 1.4→1.15 (09), galaxy potential & b/R_S (01e), factor-2 θ_E
  ranges (04), Keeton & Petters year (02).
- **7 more citations verified (ADS/CrossRef/arXiv) and added to Zotero:** Kormann+94
  (ADS, no DOI), Bartelmann 96, Saha & Williams 04 (year confirmed), Kundić 97,
  Will 14, Planck 18, Treu & Koopmans 04. Library now holds 15 `learning_to_lens` refs.
- **Recompiles clean (212 pp).** ch01b re-confirmed genuinely error-free.

Remaining honest caveat: notebook *execution* now done; the residual open items are
subjective (epigraph verbatim-quote attributions; a handful of eq-numbers with no
standalone numbered equation; a few observation-class survey statistics).

## Method (adapters used)

- **Numbers:** Python recompute (+ `astropy` for cosmological distances); `wolframscript`
  against the chapter's companion `.wl` for symbolic/convention-dependent quantities.
  The companion notebook is the chapter's *own source of truth* — decisive for
  convention-dependent results (e.g. the SIE Kormann deflection).
- **Citations:** Zotero overlay (`zotero_search_items`) → CrossRef (`api.crossref.org`)
  for existence/year/venue; **equation-number attributions checked page-by-page against
  the source PDFs** in `Reference_Texts/` (Carroll, Congdon & Keeton 2018, Narayan &
  Bartelmann 1997, Petters 2001, Schneider 1992, Saha 2024, Meneghetti 2021).
- **Policy:** numbers that are unambiguously wrong (fail both the notebook and an
  independent recompute) are auto-fixed; citations, equation-numbers, and
  convention/notebook-deferred values are **flagged, never auto-edited**.

## Edits applied (19 fixes / 8 chapters — all verified)

| Ch | Fix | Verified by |
|----|-----|-------------|
| 01d | perihelion `5.01→5.02×10⁻⁷`; `0.103→0.104″/orbit` | wolframscript |
| 01e | deflection prefactor `2/c²→1/c²` (temporal/Newtonian half) | wolframscript + PPN |
| 02 | Jupiter deflection `17→16 mas`; Newtonian solar `0.87→0.875″` | Python |
| 03 | ρ_cr `9.5→9.2×10⁻²⁷`; χ(z=5) `7950→7775`; D_A max `1770→1748`; lensing peak `0.3→0.35` | astropy (chapter's own Ω_m0.3/Ω_Λ0.7/H₀70) |
| 04 | microlensing formula denominator `5→10` (1.28→0.9 mas) | wolframscript + Python |
| 05 | removed spurious ψ₁₁/ψ₂₂ terms; un-swapped λ₊/λ₋ critical-curve labels | wolframscript + sympy |
| 07 | SIS θ_E `1.3→1.15″` + D_ds/D_s `0.706→0.638` (root cause: wrong distances) | astropy |
| 08 | 6 SIE values: image A/B `1.35/−0.65→1.43/−0.43`, μ `2.5/−0.9→6.1/−0.6`, caustic area `0.04→0.066`, cusp `0.265→0.263` | Mathematica (`sie_deflection.wl` convention) |

No edits: **01a, 01b, 01c, 06, 09, 10** (findings were citations / physics-judgment /
notebook-deferred). **01b was perfectly clean** (0 errors; all 21 eq-numbers correct).

## Systematic problem #1 — wrong equation-number citations (~47, flag-only)

Nearly every chapter that cites Carroll / Congdon & Keeton / Narayan & Bartelmann has
**wrong equation or section numbers** — the cited number points to a different equation
than the one in the text. Counts: 01a 5, 01c 3, 01d 4, 01e 10, 04 8, 05 6, 06 2, 07 5,
08 3, 09 1; **01b 0** (the only clean chapter — proof it can be done right). These read
as written-from-memory. This is the single highest-value cleanup and warrants a
dedicated, PDF-verified pass (not bulk auto-editing). Per-item corrections are in each
chapter's report.

## Systematic problem #2 — cosmological distance / parameter errors (lensing chapters)

- **ch07:** stated `D_ds/D_s ≈ 1200/1700 ≈ 0.706` for z_d=0.3,z_s=1 is wrong; astropy
  gives **0.638** (distances ~1055/1652) → θ_E **1.15″** not 1.3″. (Fixed.)
- **ch10:** stated distances 900/1750/1400 are ~2–5% off astropy (919/1727/1328), and
  `M(θ_E=30″) ≈ 2×10¹⁴` doesn't compute — correct **~1.3×10¹⁴** (same cylinder formula
  the notebook uses). Left flagged (round "≈" value, defers to the notebook).
- **ch03:** χ(z=5), D_A-max, lensing-peak all slightly off (fixed).
- **ch04, ch09:** factor-of-~2 θ_E inconsistencies (flagged).

Recommend regenerating **every worked-example distance from astropy** with the book's
stated cosmology.

## Isolated physics / consistency catches (flagged)

- ch05: "κ>1 → negative parity" is wrong (det A=(1−κ)²>0 for pure convergence).
- ch06: Shapiro-delay sign argument holds for an SIS but not the point mass introduced;
  H0LiCOW/TDCOSMO conflated (73.3 is H0LiCOW alone, Wong 2020).
- ch03: T⁰⁰ vs T₀₀ index inconsistency.
- ch01c: Sun redshift z~10⁻⁶ understates true 2.12×10⁻⁶ (~2×); WEP precision quoted
  10⁻¹³ while citing MICROSCOPE (10⁻¹⁴/10⁻¹⁵); a c=1 dimensional slip.
- ch10: giant-arc discovery priority (Soucail 1987 alone vs Lynds & Petrosian 1986 + Soucail).

## Process lessons (the important part)

1. **Verify convention-dependent numbers against the source's OWN ground truth before
   flagging or fixing.** Twice I got this wrong from independent recompute alone:
   - **ch08 (retracted a correct fix):** I reverted the agent's SIE image positions after
     my hand-check used `arcsinh` for the Kormann α₁; the chapter (correctly) uses
     `ArcTan`. Running the chapter's own `sie_deflection.wl` in wolframscript confirmed
     the agent (1.43/−0.43, μ 6.05/−0.57, area 0.066, cusp 0.263) — re-applied.
   - **ch07 (applied a wrong fix):** first pass fixed the θ_E *arithmetic* to 1.3″ but
     trusted the chapter's wrong D_ds/D_s=0.706; astropy → 0.638 → 1.15″. Re-corrected.
   Both were caught only because the "did you check with Mathematica?" question forced a
   re-audit of parameter-dependent numbers. The second agent batch (01a–01e, 04, 05) had
   the Mathematica cross-check built in and produced **no such misfires**.
2. **`wolframscript` is available** (`/usr/local/bin/wolframscript`); a "license error"
   line at kernel *exit* is benign as long as the computed values print above it.
3. **The companion `.wl` files are trustworthy but not infallible** — ch04's notebook has
   a factor-of-100 unit bug in its g/cm² printout while the .tex is correct; the agent
   correctly kept the .tex. Don't "fix" the text to match a buggy notebook.
4. Convention-free unique formulas (α=4GM/c²b, ρ_cr=3H²/8πG, NFW r₂₀₀) need no notebook
   check — Python = Mathematica for those.

## Zotero additions (done earlier this session)

7 references were added to Zotero (verified DOI→CrossRef / arXiv), tagged `learning_to_lens`:
Tran 2022 (AGEL, AJ 164,148), Keeton & Petters 2005, Treu 2010, Kneib & Natarajan 2011,
Bartelmann & Schneider 2001, Kilbinger 2015, Bartelmann et al. 1998.

## Outstanding / recommended next steps

1. ~~Equation-number cleanup pass~~ **DONE** (2026-07-01): 42 applied / 23 flagged,
   PDF-verified. Remaining 23 flagged items need author judgment (per-chapter reports,
   "Equation-number cleanup" sections).
2. ~~Recompile~~ **DONE**: builds clean, 210 pp.
3. **Cosmology audit** — regenerate all worked-example distances from astropy; resolve the
   ch04/ch09 factor-of-2 θ_E items and the ch10 mass (~2e14 → ~1.3e14). (ch03/07 done.)
4. Review the flagged physics/consistency items (κ>1 parity, Shapiro sign, T⁰⁰/T₀₀ index,
   Kerr ergosphere r₊, image-count-sequence framing, etc.).
5. Add the lone `\citep{Birrer2020}` to a `.bib` (or convert to prose) — the doc's only
   undefined citation.
6. Verify Kormann, Schneider & Bartelmann (1994) via NASA ADS and add to Zotero (the one
   recurring citation the adapters couldn't confirm).

## Artifacts

- Per-chapter reports: `Notes/<ch>/FACT_CRITIC_<ch>_2026-07-01.md` (14 files).
- Edited chapters: 01d, 01e, 02, 03, 04, 05, 07, 08 (`git diff` in the repo).
- The `fact-critic` skill itself: `~/.claude/skills/fact-critic/` (portable edition,
  repo `~/Documents/fact-critic/`).
