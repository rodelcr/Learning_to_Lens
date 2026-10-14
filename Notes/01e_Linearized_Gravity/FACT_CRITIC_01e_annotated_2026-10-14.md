# fact-critic report: 01e_Linearized_Gravity, Annotated Study Edition layer

> Date: 2026-10-14 · Scope: annotation/derivation/bridge blocks added in commit `8b10a1e`
> (`git diff c588432 8b10a1e -- Notes/01e*`) in `01e_Linearized_Gravity.tex` and `01e_Solutions.tex`,
> the "Annotated-edition checks (2026-10)" section of `Solutions/01e_Linearized_Gravity/problems_01e.wl`,
> and adjudication of the author's flags on the VISIBLE text (no visible-text edits made).
> Lenses: Citation, Number, Consistency, Prose, Derivation.
> Active adapters this run: bibtex ✓ (`Notes/references.bib`; no `\cite` in scope), crossref-web ✓
> (api.crossref.org reachable; nature.com abstract page and arXiv PDF fetched to the scratchpad, read with
> grep/pdftotext only), md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓, reference-PDF ✓
> (`Reference_Texts/Congdon and Keeton 2018` via `pdftotext`; Carroll is an image scan, so no Carroll
> equation number is checked or PASSed), wolframscript ✓ (via `Mathematica/run_wl.sh`), overlay agel-sources
> (Zotero not needed).

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation (visible) | "Cassini … constrain |γ_PPN − 1| < 2.3×10⁻⁵ … (Will 2014, Living Reviews in Relativity)" | ⚠ SUSPECT (paraphrase looser than primary result) | Bertotti, Iess & Tortora 2003, Nature 425, 374–376, CrossRef DOI 10.1038/nature01997 confirmed; abstract (nature.com/articles/nature01997): "Our result, γ = 1 + (2.1 ± 2.3) × 10⁻⁵"; Will 2014 (arXiv 1403.7377, title confirmed) §3.4 quotes the same "(2.1 ± 2.3) × 10⁻⁵" and Table 4 lists "γ − 1, time delay, 2.3 × 10⁻⁵, Cassini tracking" | Flag F7 |
| C2 | Citation (visible) | eq. `lens_equation_preview` attributed to "Congdon & Keeton eq. 4.26" | ❌ FAIL (visible eq. does not match its source) | C&K (4.26): "β = θ − ∇ψ(θ) ≡ θ − α(θ)" (pdftotext, `Reference_Texts/Congdon and Keeton…pdf`) | Flag F5 |
| C3 | Citation | annotation: Fermat potential τ = ½|θ − β|² − ψ ("eq. fermat_potential", Ch. 6) | ✅ PASS | C&K (4.25) "τ(θ|β) ≡ … = ½|θ − β|² − ψ(θ)"; repo label `eq:fermat_potential` in `06_Fermat_Time_Delays.tex` | none |
| N1 | Number | |Φ|/c² = 2.12×10⁻⁶ (Sun limb), 4.8×10⁻⁶ (10¹² M☉ at 10 kpc), 4.8×10⁻⁵ (10¹⁵ M☉ at 1 Mpc) | ✅ PASS | critic D9a (2.1220e−6, 4.786e−6, 4.786e−5) | none |
| N2 | Number | α̂ = 4|Φ(b)|/c²: Sun 8.49×10⁻⁶ rad = 1.75″; galaxy ≈ 4″ | ✅ PASS | critic D9a, D9f; repo run log | none |
| N3 | Number | caption check: (15π/32) R_S/b ≈ 1.473 R_S/b → 14.7%, 4.9%, 1.47%; exact shortfall at 100 R_S = 1.478% | ✅ PASS | critic D4d (exact integral: 1.4777%), D4e | none |
| N4 | Number | 71% within |x| < b; 99.5% within 10b; fraction X/√(X² + b²) | ✅ PASS | critic D9d | none |
| N5 | Number | Γ^i_jk term ~ v²/c² ≈ 10⁻⁸ for Earth's orbital speed | ✅ PASS | (29.8 km/s / 2.998e8 m/s)² = 9.9×10⁻⁹, critic hand computation in log context | none |
| N6 | Number | n − 1 = R_S/r: R_S ≈ 2.95 km, 4.24×10⁻⁶ at the limb; Mathematica 9.572×10⁻¹⁷ at 1 kpc | ✅ PASS | critic D9c, D9e; repo B12b | none |
| N7 | Number | galaxy α̂: Mathematica 1.914×10⁻⁵ rad = 3.949″; scaling 1.75″ × 10¹² × R☉/b = 3.95″ | ✅ PASS | critic D9f; repo B12c | none |
| N8 | Number | pair ratio b²/(b² + d²/4) = 0.9975 at b = 10d | ✅ PASS | critic D9g; repo B13c | none |
| N9 | Number (visible) | intro: "|Φ|/c² ~ 10⁻⁴ … only near cluster cores at r ≲ 100 kpc" | ✅ PASS (order of magnitude) | critic D9b: NFW, M₂₀₀ = 10¹⁵ M☉, H₀ = 70, r₂₀₀ = 2.06 Mpc: |Φ(100 kpc)|/c² = 1.05×10⁻⁴ (c = 4), 1.12×10⁻⁴ (c = 6); |Φ(0)|/c² = 1.15–1.28×10⁻⁴; |Φ(1 Mpc)|/c² = 6.0–6.4×10⁻⁵ | Optional: "only" is slightly too strong; NFW |Φ|/c² ≈ 10⁻⁴ holds out to r ~ r_s (several hundred kpc). Flag F8 |
| N10 | Number | "Nonlinear corrections … suppressed by |Φ|/c² ~ 10⁻⁵" | ✅ PASS (order of magnitude) | N1 values (galaxy 4.8×10⁻⁶ to cluster 4.8×10⁻⁵) | none |
| X1 | Consistency | Ex 2(b) visible "only matters at second order" vs chapter/Solutions annotations "first order" | ❌ FAIL (visible) | critic D7a–D7d | Flag F4 |
| X2 | Consistency | lens-equation preview vs Chapter `ch:lens_equation` eq. `reduced_deflection` (α ≡ (D_ds/D_s) α̂) | ❌ FAIL (visible) | `04_Lens_Equation.tex:275`; critic D8a, D8b | Flag F5 |
| X3 | Consistency | Ex 3(c) visible "9.58×10⁻¹⁷" vs Mathematica 9.572×10⁻¹⁷ | ❌ FAIL (visible) | critic D9e; repo B12b | Flag F6 |
| X4 | Consistency | galaxy-lens visible "3.94″" vs 3.949″ | ❌ FAIL (visible) | critic D9f; repo B12c | Flag F6 |
| X5 | Consistency | annotation wording: "so the last digit printed above is a rounding" (Ex 3) and "its last printed digit (3.94″) is a rounding" (galaxy) | ⚠ SUSPECT (wording) | 9.572 rounds to 9.57 and 3.949 to 3.95; the printed digits are slips, not roundings | Flag F6 |
| X6 | Consistency | lens-preview annotation tells the reader to "read the α there as α̂" but does not say that the stated definition "α = (D_d/D_s) α̂" is wrong | ⚠ SUSPECT | 04_Lens_Equation.tex:275; C&K (4.26) | Flag F5 (rewrite the annotation once the visible fix lands) |
| X7 | Consistency | every `\ref`/`\eqref` added in scope (ch:lens_equation, ch:cosmological_distances, ch:fermat_time_delays, ch:odd_images, ch:multiplane_dspl, ch:power_law_point_mass, eq:isotropic_r, eq:schwarzschild_isotropic, eq:deflection_second_order, eq:fermat_potential, sec:superposition …) | ✅ PASS | repo-grep: each label defined exactly once; chapter titles match described content | none |
| P1 | Prose | "Arcsecond image splittings are therefore the natural scale of galaxy lensing, not a coincidence." | ⚠ SUSPECT (antithesis + closer) | read | "Arcsecond image splittings are therefore the natural scale of galaxy lensing." |
| P2 | Prose | bridge title "linear in each plane, nonlinear across planes" | ⚠ SUSPECT (antithesis; carries real meaning) | read | keep, or "superposition within a plane, recursion across planes" |
| P3 | Prose | "$d\tau \approx dt$ is not really needed" (title) | ⚠ SUSPECT (intensifier, minor) | read | "$d\tau \approx dt$ is not needed" |

Derivation rows D6–D9 are in the Derivation section below.

## Applied (auto-fixes)

None. All numbers inside the annotation layer pass; every discrepancy found sits in visible text (out of
bounds) or is wording (prose, flag-only).

## Flagged: your hand required

Visible-text adjudications (author flags 4–8). Visible text NOT edited.

- **F4 (author flag 4): 01e_Solutions Ex 2(b). Author is RIGHT; the visible claim is wrong.**
  (1 + R_S/r)(dr² + r²dΩ²) − [(1 + R_S/r)dr² + r²dΩ²] = R_S r dΩ² exactly (critic D7a), i.e. relative order
  R_S/r against r²dΩ²: **first** order, the order being kept. Relabelling the Schwarzschild r as the Cartesian
  radius does not give a conformally flat spatial metric (D7d). With the isotropic radius r = ρ(1 + R_S/4ρ)²,
  both the radial and angular factors become 1 + R_S/ρ + O(R_S²) (D7b), and exactly (1 + R_S/4ρ)⁴ (D7c).
  **Proposed visible fix:** replace "noting that the distinction … only matters at second order in R_S/r" by
  "change to the isotropic radius ρ, r = ρ(1 + R_S/4ρ)² ≈ ρ + R_S/2 (eq. isotropic_r); to first order
  (1 + R_S/r)dr² + r²dΩ² = (1 + R_S/ρ)(dρ² + ρ²dΩ²), and dρ² + ρ²dΩ² = dx² + dy² + dz² with ρ = |x|", and write
  the resulting metric with ρ (or say r denotes the isotropic radius). The annotation and derivation boxes
  already contain this argument; after the fix the "Careful: the shortcut in (b) is not first-order exact"
  annotation should be shortened.
- **F5 (author flag 5): eq. `lens_equation_preview`. Chapter `ch:lens_equation` is right; the preview is wrong twice.**
  Small-angle geometry gives D_s β = D_s θ − D_ds α̂, so β = θ − (D_ds/D_s) α̂ ≡ θ − α with α = (D_ds/D_s) α̂
  (critic D8a; `04_Lens_Equation.tex:275`; the cited C&K eq. 4.26 is β = θ − α(θ)). The preview as printed,
  β = θ − (D_ds/D_s) α with α = (D_d/D_s) α̂, reduces to β = θ − (D_ds D_d/D_s²) α̂, which is wrong unless
  D_d = D_s (D8b). **Proposed visible fix:** "β = θ − α(θ), where α = (D_ds/D_s) α̂ is the reduced deflection
  angle" (or equivalently β = θ − (D_ds/D_s) α̂(θ)). Then rewrite the annotation "Reading eq. lens_equation_preview"
  to drop "read the α there as α̂" (X6).
- **F6 (author flag 6): roundings in 01e_Solutions. Author is RIGHT.**
  Ex 3(c): 2GM☉/(c² × 3.086×10¹⁹ m) = **9.572×10⁻¹⁷** → visible "9.58×10⁻¹⁷" should be **9.57×10⁻¹⁷**.
  Galaxy lens: 4G(10¹² M☉)/(c² × 3.086×10²⁰ m) = 1.9144×10⁻⁵ rad = **3.9486″** → visible boxed "3.94″" should be
  **3.95″** (critic D9e, D9f; repo B12b, B12c). In the annotation layer, the two sentences "(…so the last digit
  printed above is a rounding)" and "so its last printed digit (3.94″) is a rounding" misdescribe slips as
  roundings; once the visible numbers are fixed, delete these sentences (or, if the visible text stays, say
  "the printed 9.58 should read 9.57" / "the printed 3.94″ should read 3.95″").
- **F7 (author flag 7): Cassini. Visible text is a loose paraphrase.**
  Primary result (Bertotti, Iess & Tortora 2003, Nature 425, 374; DOI 10.1038/nature01997, abstract fetched from
  nature.com): **γ = 1 + (2.1 ± 2.3) × 10⁻⁵**. Will 2014 (the source the text cites; arXiv 1403.7377 fetched)
  quotes the same (2.1 ± 2.3) × 10⁻⁵ in the text and lists "2.3 × 10⁻⁵" as the γ − 1 "limit" in its Table 4, so
  the visible number is traceable to Will's table, but "|γ − 1| < 2.3 × 10⁻⁵" is not what the measurement
  says (the central value is 2.1 × 10⁻⁵; the 1σ range reaches 4.4 × 10⁻⁵). **Proposed visible fix:**
  "the Cassini Shapiro-delay measurement gives γ_PPN − 1 = (2.1 ± 2.3) × 10⁻⁵ (Bertotti, Iess & Tortora 2003;
  Will 2014)". No bib key added (none exists for either; adding one is the author's call).
- **F8 (author flag 8): "|Φ|/c² ~ 10⁻⁴ only near cluster cores at r ≲ 100 kpc". Order of magnitude PASSES.**
  A point mass of 10¹⁵ M☉ at 100 kpc would give 4.8 × 10⁻⁴, but only ~2–3 × 10¹³ M☉ is enclosed there for an
  NFW cluster. For NFW, M₂₀₀ = 10¹⁵ M☉, c₂₀₀ = 4–6, H₀ = 70 (assumed, typical values; no specific paper):
  |Φ(0)|/c² = 1.1–1.3 × 10⁻⁴, |Φ(100 kpc)|/c² = 1.05–1.12 × 10⁻⁴, |Φ(1 Mpc)|/c² = 6.0–6.4 × 10⁻⁵. So ~10⁻⁴ near
  the core is right, and the 1 Mpc "~5 × 10⁻⁵" is right to within a factor 1.3. Optional softening: "values of
  ~10⁻⁴ are reached only in the inner few hundred kpc of a massive cluster" (the NFW potential is flat inside r_s).
- **X6:** see F5.

## Prose (LLM tells): flag-only

Added text: chapter 2424 words, Solutions 839 words. Em-dashes (`---`): 0 and 0. Antithesis: 3 (P1, P2,
"Coordinate speed, not measured speed": that one is physics and should stay). Intensifiers: "really" ×1 (P3);
"exactly" ×6, all used in the mathematical sense (exact cancellation, exact superposition), acceptable.
No triads or aphoristic closers beyond P1. The layer reads clean. Provenance: the whole layer is
model-drafted (commit 8b10a1e carries a Claude co-author line); author rewrites at his discretion.

## Derivation checks

Scratch script (not in repo):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_01de/critic_01de.wl`
(log `critic_01de.log` alongside), run via `bash Mathematica/run_wl.sh`:

    SUMMARY: 50 PASS, 0 FAIL  (of 50 checks)

(shared with the 01d report; 01e-relevant groups are D4d–e, D6–D9)

| id | equation re-derived | result |
|----|---------------------|--------|
| D6 | Full first-order Christoffel list of the static weak field (Γ⁰₀ᵢ = Γⁱ₀₀ = ∂ᵢΦ/c², Γⁱ₀ⱼ = 0, Γⁱⱼₖ = (δⱼₖ∂ᵢΦ − δᵢⱼ∂ₖΦ − δᵢₖ∂ⱼΦ)/c²), computed from the exact metric g₀₀ = −(1 + 2Φ), gᵢⱼ = (1 − 2γΦ)δᵢⱼ and expanded | PASS (D6a, D6b) |
| D6' | Linear Einstein tensor: G₀₀ = 2∇²Φ/c², G₀ᵢ = 0, all Gᵢⱼ = 0 at γ = 1; off-diagonal Gᵢⱼ = (γ − 1)∂ᵢ∂ⱼΦ/c² | PASS (D6c, D6d, D6e) |
| D7 | Transverse photon equation d²y/dx² = −(1 + γ)∂_yΦ/c² ("two equal halves" box) | PASS (D6f) |
| D8 | Ex 2(b): difference R_S r dΩ² (first order); isotropic radius to first order and exactly | PASS (D7a–D7d) |
| D9 | Lens equation from geometry; preview form shown inconsistent | PASS (D8a, D8b) |
| — | Exact Schwarzschild deflection at b = 100 R_S vs 4GM/(c²b): shortfall 1.4777% | PASS (D4d) |
| — | NFW cluster potential magnitudes | PASS (D9b) |

Repo script run (worktree `wt/ann01de`):
`bash Mathematica/run_wl.sh Solutions/01e_Linearized_Gravity/problems_01e.wl` →

    SUMMARY: 65 PASS, 0 FAIL  (of 65 checks)

Report path: `Notes/01e_Linearized_Gravity/FACT_CRITIC_01e_annotated_2026-10-14.md`

## Resolution — fixes applied 2026-10-14

Branch `wt/ann01de`.

| id | Fix | Backing |
|----|-----|---------|
| F4 / X1 | 01e_Solutions Ex 2(b): "only matters at second order" replaced by the first-order difference R_S r dΩ² and the isotropic radius r = ρ(1 + R_S/4ρ)² ≈ ρ + R_S/2 (eq. `isotropic_r`); final metric written in ρ, Φ = −GM/ρ (= −GM/r up to O(R_S²/ρ²)); part (c) h's in ρ; footnote recording the old claim. "Careful" annotation shortened; derivation box retitled. | `problems_01e.wl` F4a (first-order coefficient ≠ 0), F4b, F4c; B6a–B6e |
| F5 / C2 / X2 / X6 | eq. `lens_equation_preview` → β = θ − α(θ), α = (D_ds/D_s) α̂; footnote naming the old form and its D_d D_ds/D_s² factor (C&K eq. 4.26; Ch. 4 eqs. `reduced_deflection`, `lens_equation`). Preview annotation rewritten (no "read α as α̂"). | F5a (geometry), F5b (old form fails unless D_d = D_s); C&K (4.26) |
| F6 / X3 / X4 / X5 | Ex 3(c) 9.58e−17 → 9.57e−17; galaxy lens 3.94″ → 3.95″; both "rounding" annotation sentences deleted; annotation title shortened. | F6a, F6b (old values fail); B12b, B12c |
| F7 / C1 | Cassini: "γ_PPN − 1 = (2.1 ± 2.3) × 10⁻⁵" with "(Bertotti, Iess & Tortora 2003, *Nature*)" in plain text, Will 2014 kept; footnote explaining the old "|γ − 1| < 2.3e−5" (Will 2014 Table 4). No bib key. | F7 (1σ range); DOI 10.1038/nature01997 (critic, CrossRef) |
| F8 / N9 | "only near cluster cores at r ≲ 100 kpc" → "only in the inner few hundred kpc of a massive cluster". | F8: NFW M₂₀₀ = 10¹⁵ M☉, c = 4, 6, H₀ = 70 (assumed typical values): |Φ|/c² = 0.90–1.12 × 10⁻⁴ for r ≤ 300 kpc, 6.0–6.4 × 10⁻⁵ at 1 Mpc |
| P1, P3 | P1 "not a coincidence" dropped; P3 "really" dropped. P2 kept (carries meaning). | — |

**Verification after edits.** `bash Mathematica/run_wl.sh Solutions/01e_Linearized_Gravity/problems_01e.wl`:
before `SUMMARY: 65 PASS, 0 FAIL  (of 65 checks)`; after `SUMMARY: 74 PASS, 0 FAIL  (of 74 checks)`.
`cd Notes && ANNOT_REQUIRED=1 bash build.sh` → "all assertions passed"; student 360 pp, instructor 444 pp,
annotated 569 pp.

**Left open.**
- Bib keys for Bertotti, Iess & Tortora 2003 and Will 2014 (both cited in plain text): orchestrator request.
- Exercise statement (chapter) still says "with Φ = −GM/r to first order in R_S/r"; correct to first order, left as is.
