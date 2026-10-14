# fact-critic report: Module 07 (Axisymmetric models), Annotated Study Edition layer

> Date: 2026-10-14 · Critic: independent pass, not the layer's author.
> Scope: boxes added in commit 0bed817 (`git diff c588432 0bed817 -- Notes/07*`) in
> `Notes/07_Axisymmetric_Models/07_Axisymmetric_Models.tex`, `07_Solutions.tex`, the appended
> B-checks of `Solutions/07_Axisymmetric_Models/problems_07.wl`, plus the author's flags on
> pre-existing visible text (items 6–10 of the brief) and the Bartelmann (1996) prose citation.
> Lenses: Citation, Number, Consistency, Prose, Derivation.
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (CrossRef + arXiv API;
> records in `scratchpad/critic_0607/web/`, `scratchpad/crossref/`, `scratchpad/mao_dl/q.xml`), md-reflist ✗,
> values-file ✗, repo-grep ✓, doc-internal ✓, Reference_Texts PDFs ✓ (N&B 1997), Annotated PDF ✓
> (`Output/Learning_to_Lens_Annotated.pdf` TOC; Ch. 20 source `Notes/16_Odd_Images_Central/`),
> wolframscript ✓, overlay: AGEL. A claim with no adapter is capped at ⚠ SUSPECT.

Scratch critic script (shared with Module 06):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0607/critic_0607.wl`
**SUMMARY critic_0607: 47 passed, 0 failed**.
Repo script `Solutions/07_Axisymmetric_Models/problems_07.wl` via `run_wl.sh`:
**`SUMMARY: 64 PASS, 0 FAIL  (of 64 checks)` / `ALL CHECKS PASS`**.

## Verdict counts (Module 07)

| class | ✅ PASS | ⚠ SUSPECT | ❌ FAIL |
|---|---|---|---|
| Layer: Citation (C) | 4 | 2 | 0 |
| Layer: Number (N) | 17 | 0 | 0 |
| Layer: Consistency (X) | 2 | 1 | 0 (X2 is visible text, counted under V6) |
| Layer: Prose (P) | – | 3 | 0 |
| Derivation (D) | 6 | 0 | 0 |
| Visible-text flags (V6–V10) | – | – | 5 confirmed errors |

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | v_c = √2σ `\citealt[eq.~42]{narayan_lectures_1997}` | ✅ PASS | N&B eq. (42) v²_rot = GM/r = 2σ²; critic L3 | none |
| C2 | Citation | α̂ = 1.40″(σ/220)² `[eq.~44]` | ✅ PASS | N&B eq. (44); critic L6 (1.396″) | none |
| C3 | Citation | SIS zero-flux third image `[Sect.~3.1]` | ✅ PASS | N&B Sect. 3.1 after eq. (46) | none |
| C4 | Citation | N&B Table 2 "softened isothermal sphere" softens ψ ∝ √(θ_c²+θ²) | ✅ PASS | N&B Table 2 row; κ formula critic I9i | none |
| C5 | Citation | κ̄ = ⟨κ⟩ + ⟨γ_t⟩ `\citep{bartelmann_1995}` | ⚠ SUSPECT (exists, support unconfirmed) | bib:bartelmann_1995; arXiv astro-ph/9412051 = "Cluster mass estimates from weak lensing", A&A 303, 643. Abstract is about finite-field reconstruction bounds and does not state the identity | Confirm in the full text, or cite a source that states the identity explicitly. Do not change without checking. |
| C6 | Citation | bridge: "A central point mass … can remove the image or split it" | ⚠ SUSPECT (wording) | Ch. 20 (`16_Odd_Images_Central.tex:695–731`): the BH removes the central maximum or adds a *second* faint saddle next to the puncture (4 images). Mao, Witt & Koopmans 2001 abstract (arXiv astro-ph/0007011; CrossRef 10.1046/j.1365-8711.2001.04143.x): BH "suppress[es] the central images" and "an additional image may be created" | "…and can remove the central image or add a second faint image next to it." "Split" implies one image becomes two, which neither source says. |
| N1 | Number | θ_t = 0.894, θ_r = 0.251, β_r = 0.427 (θ_c = 0.1θ_E) | ✅ PASS | critic I9a (0.89443, 0.25097, 0.42704) | none |
| N2 | Number | β = 0.2: images −0.660, −0.054, +1.114; one image at β = 0.6 | ✅ PASS | critic I9d (−0.6599, −0.0544, 1.1143; 0.6 → 1 root) | none |
| N3 | Number | types saddle, max, min; arrival min → saddle → central max | ✅ PASS | critic I9d types {(−,+),(−,−),(+,+)}; I9f τ = −0.681, −0.324, −0.236 | none |
| N4 | Number | θ_c criterion strict: θ_c = θ_E/2 gives λ_r > 0 for θ > 0, λ_r(0) = 0 | ✅ PASS | critic I9g, I9h | none |
| N5 | Number | D_d 919, D_s 1652, D_ds 1055 Mpc (H₀ 70, Ω_m 0.3) | ✅ PASS | critic I5b (918.8, 1652.0, 1054.7) | none |
| N6 | Number | 4π(250/3×10⁵)²×0.638 = 1.15″ | ✅ PASS | critic I6 (1.1509″) | none |
| N7 | Number | D_s − D_d ≈ 730 Mpc | ✅ PASS | critic I5b (733 Mpc with cosmology; 730 with 920/1650) | none |
| N8 | Number | 1.80″(σ/250)²; 10% → 21% | ✅ PASS | critic L6 (1.802″), L7 | none |
| N9 | Number | point-mass θ_E(10¹² M☉) ≈ 2.4″ | ✅ PASS | critic I7 (2.379″) | none |
| N10 | Number | SIS M(<θ_E) ≈ 2.3×10¹¹ M☉; ring "about twice as large" | ✅ PASS | critic I7b (2.34×10¹¹); √(10¹²/2.34×10¹¹) = 2.07 | none |
| N11 | Number | D_ds/D_s = 0.639 (7.3 annotation) | ✅ PASS | 1055/1650 = 0.6394 | none |
| N12 | Number | κ(θ_E) = 0.4975, κ(2θ_E) = 0.2497 | ✅ PASS | critic I9j | none |
| N13 | Number | NFW f small-x = ln(2/x) − 1; x²f → 1; f(1) = 1/3 | ✅ PASS | critic I8 (Series → −1 + Log[2/x]; I8c, I8d) | none |
| N14 | Number | point mass λ_r = 1 + θ_E²/θ² > 1 | ✅ PASS | repo B3 PASS line; follows from α = θ_E²/θ | none |
| N15 | Number | power law κ(θ_E) = (3−γ′)/2; \|γ\|/κ = (γ′−1)/(3−γ′) | ✅ PASS | critic L5; κ̄/κ = 2/(3−γ′) | none |
| N16 | Number | softened-ψ sphere κ(0) = θ_E/θ_c, criterion θ_c < θ_E | ✅ PASS | critic I9i evaluated at θ = 0 | none |
| N17 | Number | \|μ₊/μ₋\| = (θ_E+β)/(θ_E−β); asymmetry = β/θ_E | ✅ PASS | algebra with θ₊ = β+θ_E, \|θ₋\| = θ_E−β | none |
| X1 | Consistency | Ch. refs: `ch:power_law_point_mass` (19), `ch:odd_images` (20), `ch:msd_kinematics` (22), `ch:multiplane_dspl` (18) | ✅ PASS | Annotated PDF TOC | none |
| X2 | Consistency | Ex. 7.3 distances 920/1650/1055 vs chapter Example 919/1652/1055 vs Sol. 7.3 1200/1700 | ❌ in visible text (V6); layer ✅ | see V6 | see V6 |
| X3 | Consistency | Ch. 07 bridge "annulus bounded by two radial-type critical curves, or it vanishes" vs Ch. 20 | ✅ PASS | `16_Odd_Images_Central.tex` "Two radial critical circles" paragraph and supercritical-BH case | none |
| X4 | Consistency | "Bartelmann (1996)" in visible prose (`07_Axisymmetric_Models.tex:1113`) has no bib entry | ⚠ SUSPECT (no `\cite`) | arXiv astro-ph/9602053 journal_ref "Astron.Astrophys.313:697-702,1996", title "Arcs from a Universal Dark-Matter Halo Profile". CrossRef bibliographic search returns no record (A&A 1996 has no DOI) | Add a bib entry `bartelmann_1996` (A&A 313, 697; eprint astro-ph/9602053) and `\citet` it. That support for the f(x) formula needs the full text (the abstract is about NFW radial arcs). No bib edit here. |
| P1 | Prose | "classic error / common slip / classic error:" ×5 in chapter | ⚠ SUSPECT (formulaic repetition) | read | vary or drop the label on two or three of them |
| P2 | Prose | "Every statement in that chapter about critical curves is a statement about these two eigenvalues." | ⚠ SUSPECT (aphoristic closer, chiasmus) | read | "Chapter 19's critical-curve results all follow from these two eigenvalues." |
| P3 | Prose | "This is why lensing measures the mass inside θ_E so robustly." | ⚠ SUSPECT (model vocabulary "robustly") | read | "So lensing pins down the mass inside θ_E with little model dependence." |
| D1–D6 | Derivation | see below | ✅ PASS ×6 | critic_0607.wl | none |

## Applied (auto-fixes)

None (no visible-text edits per brief; no layer typo found).

## Flagged — your hand required

### Visible-text items (author's flags), adjudicated

**V6. Solution 7.3 uses D_ds/D_s = 1200/1700 (and `problems_07.wl` body 900/1700/1200) instead of the exercise's 920/1650/1055. CONFIRMED.**
θ_E = 4π(2.5×10⁵/3×10⁸)² × 1055/1650 = 5.58×10⁻⁶ rad = **1.15″** (critic I6; 1.152″ with c = 2.998×10⁵). This matches the chapter
Example (line 500) and the May-2026 canonical distances (critic I5b: 918.8/1652.0/1054.7 Mpc).
Exact fixes in `07_Solutions.tex` Ex. 7.3:
- (a): `\times \frac{1200}{1700} \approx 4\pi \times 6.944 \times 10^{-7} \times 0.706 \approx 6.16 \times 10^{-6}~\text{rad} \approx 1.27''` →
  `\times \frac{1055}{1650} \approx 4\pi \times 6.944 \times 10^{-7} \times 0.639 \approx 5.58 \times 10^{-6}~\text{rad} \approx 1.15''`
- (b)(i): `\thetaE \approx 1.27''` → `\thetaE \approx 1.15''`
- (b)(ii): `0.5'' + 1.27'' = 1.77''` → `0.5'' + 1.15'' = 1.65''`; `0.5'' - 1.27'' = -0.77''` → `0.5'' - 1.15'' = -0.65''`
- (b)(iii): `1 + \frac{1.27}{0.5} = 3.54` → `1 + \frac{1.15}{0.5} = 3.30`; `1 - \frac{1.27}{0.5} = -1.54` → `1 - \frac{1.15}{0.5} = -1.30`
- (b)(iv): `3.54 + 1.54 = 5.08` → `3.30 + 1.30 = 4.60`
- `Solutions/07_Axisymmetric_Models/problems_07.wl` lines 124 (comment), 130–132 (`DdVal = 900`, `DsVal = 1700`, `DdsVal = 1200`), 138 (Print label `(1200/1700)`): change to 920/1650/1055.
  (The B6 checks already use 920/1650/1055; the exercise body does not.)

**V7. Solution 7.3(d): point-mass θ_E ≈ 1.1″ "(from Module 4)", SIS "comparable but slightly larger". CONFIRMED wrong.**
√(4GM/c² · D_ds/(D_dD_s)) for 10¹² M☉ with 920/1650/1055 Mpc = **2.38″** (critic I7; repo B6d prints 2.379″). Module 4 itself now gives 2.4″
(`04_Lens_Equation.tex:733`, `04_Solutions.tex:179`). The comparison is reversed: the point mass has the larger ring.
Replacement for lines 213–217:
> \textbf{(d)} The point mass Einstein radius for $M = 10^{12}\,\Msun$ at $z_d = 0.3$, $z_s = 1$ is $\thetaE \approx 2.4''$ (from
> Module~4). The SIS Einstein radius depends on $\sigma_v$ rather than total mass. For $\sigma_v = 250$~km\,s$^{-1}$, $\thetaE \approx 1.15''$,
> about half as large: the SIS has only $\approx 2.3\times10^{11}\,\Msun$ inside its Einstein radius, and $M(<\thetaE)\propto\thetaE^2$.
(Keep the "more realistic model" sentence.)
Also fix `problems_07.wl` body line 175: it uses `DdsVal/(DdVal DsVal)` from the 900/1700/1200 set, giving 2.53″. It becomes 2.38″ once V6 is fixed.

**V8. Solution 7.5(a): "logarithmic divergence as x → 0 (with f(x) ∼ (1/x) ln(2/x))". CONFIRMED wrong.**
Series of f(x) = [1 − arccosh(1/x)/√(1−x²)]/(x²−1) at x → 0 is **ln(2/x) − 1** (critic I8: Mathematica `Series` returns `-1 + Log[2/x]`;
f/[(1/x)ln(2/x)] < 0.01 at x = 10⁻³). (1/x)ln(2/x) would be a much stronger divergence, and the projected mass would diverge.
Replacement: `(with $f(x) \sim (1/x)\ln(2/x)$)` → `(with $f(x) \simeq \ln(2/x) - 1$)`.
Minor, same sentence: x f(x) peaks at x ≈ 0.61 (critic python scan; peak value 0.350), so "near x ∼ 0.5" is loose. "near x ≈ 0.6" is better (optional).

**V9. Chapter 07 (`07_Axisymmetric_Models.tex:819–822`): "Sources inside this radial caustic (and inside the tangential caustic) produce three images; sources between the radial and tangential caustics produce one image." CONFIRMED wrong for the axisymmetric NIS.**
The tangential caustic is the single point β = 0, which lies *inside* the radial caustic (radius β_r = 0.427θ_E at θ_c = 0.1θ_E). "Inside the
tangential caustic" is empty, and "between the radial and tangential caustics" describes the region where there are three images, not one. Numerically
β = 0.2 and 0.4 → 3 images; β = 0.45 and 0.6 → 1 image (critic I9d).
Replacement:
> The radial critical curve of the NIS creates a \textbf{radial caustic} in the source plane: a circle of radius $\beta_r > 0$. Because the
> tangential caustic of an axisymmetric lens is the single point $\beta = 0$, the image count depends only on $|\beta|$: sources with
> $0 < |\beta| < \beta_r$ produce three images, sources with $|\beta| > \beta_r$ produce one, and a source at $\beta = 0$ produces an Einstein
> ring plus a central image.

**V10. Exercise 7.4(c) hint and Solution 7.4(c): "multiple images require κ(0) ≥ 1" ⇒ "θ_c ≤ θ_E/2". CONFIRMED.**
At θ_c = θ_E/2, λ_r = 1 − θ_c/[s(s+θ_c)] > 0 for all θ > 0 and λ_r(0) = 0 (critic I9g, I9h), so β(θ) is monotonic and every β ≠ 0 has one image.
The chapter body already uses the strict form ("we need κ(0) > 1, requiring θ_c < θ_E/2", line ~731), so the exercise also disagrees with its own chapter.
Exact fixes: in the exercise hint (`07_Axisymmetric_Models.tex`, `ex:nis_convergence`), `$\kappab(0) \geq 1$` → `$\kappab(0) > 1$`. In
`07_Solutions.tex` 7.4(c): `Multiple images require $\kappab(0) \geq 1$` → `$\kappab(0) > 1$`, `\frac{\thetaE}{2\theta_c} \geq 1` → `> 1`,
`\theta_c \leq \frac{\thetaE}{2}` → `\theta_c < \frac{\thetaE}{2}`. Then drop the last sentence of the layer's derivation box ("The '≥' in the hint should be read as…").

### Layer items needing a decision

- C5 (`bartelmann_1995` for κ̄ = ⟨κ⟩ + ⟨γ_t⟩): the abstract does not confirm it. Check the full text before release.
- C6 ("split it"): reword as above.
- X4: add a `bartelmann_1996` bib entry for the visible "Bartelmann (1996)" (A&A 313, 697–702, arXiv astro-ph/9602053, verified from the arXiv journal_ref; no DOI on CrossRef).
- After V6–V10 land, remove the four "has been flagged for correction" sentences in the 07 annotations (7.3 "Which distances?", 7.3(d) "Check of (d)", 7.5(a) "Small-x behaviour", 7.4(c) derivation).

## Prose (LLM tells): flag-only

Added text: chapter ≈2100 words with 0 em-dashes and 0 "rather than"/"not X" pivots outside titles; solutions ≈780 words, clean.
The main tell is the repeated "classic error"/"common slip" label (5× in the chapter); P2 and P3 are single instances. The layer otherwise reads as
plain technical prose.

## Derivation checks

Script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0607/critic_0607.wl`
**SUMMARY critic_0607: 47 passed, 0 failed.**

| id | equation | result | checks |
|----|----------|--------|--------|
| D1 | d(θκ̄)/dθ = 2κ − κ̄ ⇒ \|γ\| = κ̄ − κ, λ_r = 1 − 2κ + κ̄ | ✅ PASS | L4 |
| D2 | NIS dα/dθ = θ_Eθ_c/[s(s+θ_c)]; λ_r = 0 ⇔ s² + θ_c s − θ_Eθ_c = 0; θ_t = √(θ_E(θ_E−2θ_c)) | ✅ PASS | I9b, I9c, I9a (λ_t(θ_t) = −2×10⁻¹⁶, λ_r(θ_r) = 4×10⁻¹⁶) |
| D3 | NIS ψ = θ_E[s − θ_c ln(θ_c+s)] has ψ′ = α | ✅ PASS | I9e |
| D4 | NFW K(x) branches arccosh(1/x)/√(1−x²), arccos(1/x)/√(x²−1) vs direct quadrature of ∫dτ/(1+x cosh τ) | ✅ PASS | L9 |
| D5 | NFW f asymptotes: ln(2/x) − 1, x²f → 1, f(1) = 1/3 | ✅ PASS | I8a–d |
| D6 | v_c = √2σ from ρ = σ²/(2πGr²); power-law κ̄ normalisation | ✅ PASS | L3, L5 |

Repo script `problems_07.wl`: `SUMMARY: 64 PASS, 0 FAIL  (of 64 checks)`.

## Resolution — fixes applied 2026-10-14

Branch `wt/ann0607`. New checks are the `F*` block at the end of `Solutions/07_Axisymmetric_Models/problems_07.wl`;
each fails on the pre-fix printed value.

| id | Fix | Backing |
|----|-----|---------|
| V6 | Sol 7.3(a) → `1055/1650 … ×0.639 ≈ 5.58e−6 rad ≈ 1.15″` + note on the old 1200/1700 → 1.27″; (b) 1.15″, θ± = 1.65″/−0.65″, μ± = 3.30/−1.30, sum 4.60. `problems_07.wl` body distances → 920/1650/1055, header comment and Print label updated (prints 1.152″). "Which distances?" box: dropped the flagged sentence. | F6, F6b; B6a–c |
| V7 | Sol 7.3(d) → critic's replacement (point mass 2.4″; SIS 1.15″ about half; 2.3e11 M☉ inside θ_E) + note that the earlier comparison was reversed. Script body now prints 2.379″ and the "comparable" line is replaced. "Check of (d)" box: dropped "not 1.1″" and the flagged sentence. | F7; B6d, B15d |
| V8 | Sol 7.5(a) `f(x) \simeq \ln(2/x) − 1`, peak of x f(x) "near x ≈ 0.6" (critic's optional item; peak at 0.613); visible note on the old (1/x)ln(2/x). "Small-x" box: flagged sentence replaced by why (1/x)ln(2/x) cannot be right. | F8 (Series; f/[(1/x)ln(2/x)] < 0.01 at 10⁻³; argmax x f = 0.61); B11i |
| V9 | Ch 07 caustic sentence (ll.819–822) → critic's replacement + footnote recording the old "between the caustics → one image" error. | F9 (β = 0.2, 0.4 → 3; 0.45, 0.6 → 1; tangential caustic at β = 0); B10l–m |
| V10 | Exercise hint `\kappab(0) > 1`; Sol 7.4(c) `> 1`, `θ_c < θ_E/2` + visible sentence that it is strict (old ≥); derivation box's last sentence on "≥ in the hint" replaced. | F10 (θ_c = θ_E/2: λ_r > 0 for θ > 0, λ_r(0) = 0, one image at β = 0.01, 0.1); B10i |
| C5 | `\citep{bartelmann_1995}` no longer presented as the source of κ̄ = ⟨κ⟩ + ⟨γ_t⟩: the identity is attributed to the box's own derivation (azimuthal averages), and the paper is cited for what its abstract states ("how well weak-lensing data recover cluster masses"). | arXiv astro-ph/9412051 abstract |
| C6 | Bridge: "remove the image or split it" → "remove the central image or add a second faint image next to it". | Ch 20 `16_Odd_Images_Central.tex` ll.695–731 |
| P1–P3 | "A classic error is to" / "A common slip is to" → "Do not"; "so robustly" → "with little model dependence"; P2 chiasmus rewritten. Two "Classic error:" labels (ll.470, 744) left. | prose |

### Verification after edits
- `bash Mathematica/run_wl.sh Solutions/07_Axisymmetric_Models/problems_07.wl`: before `SUMMARY: 64 PASS, 0 FAIL  (of 64 checks)`; after **`SUMMARY: 70 PASS, 0 FAIL  (of 70 checks)`** / `ALL CHECKS PASS`.
- `ANNOT_REQUIRED=1 bash build.sh`: all assertions passed; Student 360 pp, Solutions 444 pp, Annotated 569 pp.

### Left open
- X4: visible "Bartelmann (1996)" (and "Wright & Brainerd (2000)") at `07_Axisymmetric_Models.tex:1113` still has no `\cite`; no bib key added per instructions. Needs `bartelmann_1996` (A&A 313, 697–702; arXiv astro-ph/9602053; no DOI) from the orchestrator.
- C5: full-text support for κ̄ = ⟨κ⟩ + ⟨γ_t⟩ in Bartelmann 1995 still unverified (citation now no longer claims it).

### Session-3 closeout (2026-10-14, orchestrator)
- X4 closed: `bartelmann_1996` (arXiv journal-ref A&A 313, 697–702; no publisher DOI; Zotero HEDT5W9M, already tagged) and `wright_brainerd_2000` (CrossRef 10.1086/308744; Zotero Q4N8INM2, tagged `learning_to_lens`) added to `references.bib` and cited at `07_Axisymmetric_Models.tex:1122`.