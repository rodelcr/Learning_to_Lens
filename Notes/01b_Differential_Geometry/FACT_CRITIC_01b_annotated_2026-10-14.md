# fact-critic report — Notes/01b_Differential_Geometry/01b_Solutions.tex (Annotated Study Edition layer + author flag 1)

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation
> Scope: the 4 `derivation` + 3 `annotation` blocks added in commit 1e1a64c, and the "Annotated-edition
> checks (2026-10)" section of `Solutions/01b_Differential_Geometry/problems_01b.wl`. Visible text was
> fact-critic'd 2026-07-01 and is not re-reviewed, except for the visible Exercise 1.4 claim that the author flagged (X1).
> Active adapters this run: bibtex n/a (no \cite in scope), crossref-web n/a, md-reflist ✗, values-file ✗,
> repo-grep ✓, doc-internal ✓, Reference_Texts PDFs ✓, wolframscript ✓ (Mathematica/run_wl.sh),
> overlay: AGEL (not needed).

## Repo script run (quoted verbatim)

`bash Mathematica/run_wl.sh Solutions/01b_Differential_Geometry/problems_01b.wl` → exit 0
`SUMMARY: 32 PASS, 0 FAIL  (of 32 checks)`

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | .wl comment "eq:christoffel and eq:riemann (Carroll eqs. 3.27, 3.4)" | ✅ PASS | matches the chapter's own attributions, 01b_Differential_Geometry.tex:188 and :311; both confirmed in FACT_CRITIC_01b_Differential_Geometry_2026-07-01.md:40 (Carroll_SG.pdf p. 94, eq. 3.4) and its C-row for 3.27 | none |
| N1 | Number | "one nonzero metric derivative ∂_θ g_φφ = 2R² sinθ cosθ"; "six independent components" | ✅ PASS | problems_01b.wl "only nonzero metric derivative…"; 2 upper × 3 symmetric lower pairs = 6 | none |
| N2 | Number | per-component Christoffel list (Γ^θ_θθ = Γ^θ_θφ = Γ^φ_θθ = Γ^φ_φφ = 0, Γ^θ_φφ = −sinθcosθ, Γ^φ_θφ = cotθ), including the bracket forms written for the diagonal metric | ✅ PASS | critic_01b.wl D1 (Christoffels re-derived from the geodesic Lagrangian, not the Γ formula); bracket index placement re-checked by hand against eq:christoffel (01b_Differential_Geometry.tex:189–195) | none |
| N3 | Number | "R cancels from every Christoffel symbol" (constant rescaling) | ✅ PASS | critic_01b.wl D1 (FreeQ R) | none |
| N4 | Number | polar Γ^r_φφ = −r, Γ^φ_rφ = 1/r; n²(n²−1)/12 = 1; R^r_φrφ = −1 − 0 + 0 − (−r)(1/r) = 0 | ✅ PASS | critic_01b.wl D3, D3b; term ordering matches eq:riemann (01b_Differential_Geometry.tex:312–318) | none |
| N5 | Number | straight line: r²φ̇ = ad − bc; d(r²φ̇)/dλ = r(rφ̈ + 2ṙφ̇); r r̈ = r²φ̇² | ✅ PASS | problems_01b.wl (6 checks, all PASS in the run above); geodesic forms confirmed by critic_01b.wl D3 | none |
| N6 | Number | R^θ_φθφ = −cos² + sin² + cos² = sin²θ; R^φ_θφθ = csc² − cot² = 1; R_φφ = sin²θ | ✅ PASS | critic_01b.wl D2 | none |
| N7 | Number | "Ricci scalar 2/R²", "Gaussian curvature is half the Ricci scalar, 1/R²" | ✅ PASS | critic_01b.wl D2b (Gaussian K computed independently as R_θφθφ/det g) | none |
| N8 | Number | meridian transport: dV^θ/dθ = 0; dV^φ/dθ + cotθ V^φ = 0 ⇒ V^φ = C/sinθ; R sinθ V^φ constant | ✅ PASS | critic_01b.wl F1a–F1d (parallel transport integrated in the R³ embedding, no Christoffels): V^θ = 0.2 constant; V^φ = 0.700, 0.832, 1.460, 7.012 at θ = π/2, 1.0, 0.5, 0.1; sinθ·V^φ = 0.700 throughout | none |
| N9 | Number | enclosed area ∫₀^α dφ ∫₀^{π/2} sinθ dθ = α | ✅ PASS | critic_01b.wl F2b; holonomy of the pole→equator→equator→pole loop = α (F2, α = 0.9 rad) | none |
| X1 | Consistency | **VISIBLE** Ex 1.4 text (01b_Solutions.tex:166–168): "dφ/dλ = 0, so the parallel transport equation reduces to dV^μ/dλ = 0 --- the vector components are constant along the path" vs the new derivation box | ❌ FAIL (visible text wrong; box right) | critic_01b.wl F1b: coordinate V^φ changes by a factor 10 between θ = π/2 and θ = 0.1. The term Γ^φ_θφ (dθ/dλ) V^φ = cotθ θ̇ V^φ ≠ 0 survives because dθ/dλ ≠ 0 on a meridian. Only V^θ and V^φ̂ = R sinθ V^φ are constant | see Flagged (do not auto-edit visible text) |
| X2 | Consistency | "contraction on the first (upper) and third indices; contracting a different pair can flip the sign" | ✅ PASS | chapter 01b_Differential_Geometry.tex:327–329; problems_01b.wl "contracting 1st & 4th indices gives -R_{mu nu}" | none |
| X3 | Consistency | Ex refs \ref{ex:geodesic_sphere}, ex:christoffel_polar, ex:christoffel_sphere | ✅ PASS | 01b_Differential_Geometry.tex:837, :802, :795 | none |
| X4 | Consistency | "same factor appears in φ̈ + (2/r)ṙφ̇ of Exercise christoffel_polar" | ✅ PASS | internal: the 1.2(c) box gives Γ^φ_rφ + Γ^φ_φr = 2/r; critic_01b.wl D3 | none |
| N10 | Number | annotation 1.5: "Forgetting the factor of 2 is harmless for the equator (θ̇ = 0) but gives wrong orbits for **any** tilted great circle" | ⚠ SUSPECT (overstated) | critic_01b.wl D5: a tilted circle (i = 1.0) fails without the 2 ✓, but D5b: a meridian (i = π/2, φ̇ = 0) satisfies both versions, so the factor is harmless there too | "…harmless for the equator and the meridians (θ̇ = 0 or φ̇ = 0) but gives wrong orbits for every other great circle." |
| D1–D5 | Derivation | see below | ✅ PASS | critic_01b.wl | none |

Counts: 14 ✅ PASS (incl. D-block), 1 ⚠ SUSPECT, 1 ❌ FAIL (visible text, flag-only).

## Applied (auto-fixes)

None. X1 is in the visible text, which this pass must not edit. N10 is prose-level wording, so it is flag-only.

## Flagged — your hand required

- **X1 / author flag 1 — ADJUDICATED: the VISIBLE text is wrong. The author's flag is correct.**
  Evidence: `critic_01b.wl` integrates parallel transport along φ = 0.3 in the R³ embedding (dV/ds = −(V·ṅ) n), which uses no Christoffel symbols. Starting from (V^θ, V^φ) = (0.2, 0.7) at the equator, V^θ stays 0.2 to 1e−9. V^φ grows to 0.832, 1.460 and 7.012 at θ = 1.0, 0.5 and 0.1, and sinθ·V^φ = 0.700 at all four points (checks F1a–F1d PASS). The visible sentence drops the Γ^μ_θσ θ̇ V^σ term. On a meridian dθ/dλ ≠ 0, so that term survives.
  Proposed replacement for 01b_Solutions.tex:166–168 (author to adopt or reword):
  > Along a meridian ($\phi = \text{const}$, parametrised by $\theta$), $d\phi/d\lambda = 0$ but $d\theta/d\lambda \neq 0$, so the parallel transport equation gives $dV^\theta/d\theta = 0$ and $dV^\phi/d\theta + \cot\theta\,V^\phi = 0$. Thus $V^\theta$ and the orthonormal component $V^{\hat\phi} = R\sin\theta\,V^\phi$ are constant: the vector keeps a fixed angle to the meridian, while the coordinate component $V^\phi \propto 1/\sin\theta$ grows only because $\partial_\phi$ shrinks toward the pole.
  Secondary (optional) note on the next visible paragraph: the rotation by α comes from the pole. At θ = π/2 every Christoffel term in the equator leg vanishes (Γ^θ_φφ = Γ^φ_φθ = 0 there), so the components are also constant along the equator. The orthonormal frames of the meridians φ = 0 and φ = α differ by α at the pole. The visible sentence ("the coordinate basis φ̂ at φ = α is rotated by angle α relative to φ̂ at φ = 0") gestures at this, but loosely. The holonomy value α is correct (critic_01b.wl F2).
  The July 2026 critic of this module (FACT_CRITIC_01b_Differential_Geometry_2026-07-01.md) passed only the citation for this exercise (C15) and did not test the claim.
- **N10**: overstated "any tilted great circle". Proposed wording is in the table.

## Prose (LLM tells) — flag-only

New layer ≈ 940 words. Em-dashes: 0. Triads: 0. Antithesis / aphoristic closers: 0. "only" is used 6 times, always as a mathematical qualifier. The project-leakage grep is clean. The layer reads clean. Nil return.

## Derivation checks

Scratch script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_01abc/critic_01b.wl`. Christoffels come from the Euler–Lagrange equations of L = ½ g ẋẋ (independent of the Γ formula). Parallel transport and holonomy are computed in the R³ embedding (no Christoffels).
`SUMMARY: 13 PASS, 0 FAIL  (of 13 checks)`

| id | equation | result |
|----|----------|--------|
| D1 | 2-sphere Christoffels, R-independent | PASS |
| D2 | R^θ_φθφ = sin²θ, R^φ_θφθ = 1, Ricci scalar 2/R², Gaussian curvature 1/R² | PASS |
| D3 | polar Christoffels, flat Riemann, n²(n²−1)/12 = 1 | PASS |
| D4 (= F1a–d, F2) | meridian transport: V^θ const, V^φ = C/sinθ; loop holonomy = α = enclosed area | PASS (visible text X1 contradicted) |
| D5 | factor 2 in the φ-geodesic equation: needed for tilted circles, harmless for meridians | PASS (N10 wording) |
