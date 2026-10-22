# fact-critic report — Notes/01a_Special_Relativity/01a_Solutions.tex (Annotated Study Edition layer only)

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation
> Scope: the 2 `derivation` + 3 `annotation` + 1 `bridge` blocks added in commit 1e1a64c, and the
> "Annotated-edition checks (2026-10)" section of `Solutions/01a_Special_Relativity/problems_01a.wl`.
> Visible text was fact-critic'd 2026-07-01 (FACT_CRITIC_01a_Special_Relativity_2026-07-01.md) and is not re-reviewed.
> Active adapters this run: bibtex n/a (no \cite in scope), crossref-web n/a (no citations in scope),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓, Reference_Texts PDFs ✓ (pdftotext),
> wolframscript ✓ (via Mathematica/run_wl.sh), overlay: AGEL (not needed — no citations/observations).
> Critic: independent of the author; every PASS names a RUN check, a PDF page, or a path:line.

## Repo script run (quoted verbatim)

`bash Mathematica/run_wl.sh Solutions/01a_Special_Relativity/problems_01a.wl` → exit 0
`SUMMARY: 18 PASS, 0 FAIL  (of 18 checks)`

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | "(1,2) entry is cosh φ1(−sinh φ2) + (−sinh φ1)cosh φ2" | ✅ PASS | critic_01a.wl D1c; problems_01a.wl "product entries (row . column) as written" | none |
| N2 | Number | hyperbolic addition formulas; tanh(φ1+φ2) = (tanh φ1 + tanh φ2)/(1 + tanh φ1 tanh φ2) | ✅ PASS | critic_01a.wl D1, D1b (composition of velocity-parametrised boosts, independent of rapidity route) | none |
| N3 | Number | "v1 = 1 gives v = (1+v2)/(1+v2) = 1 for *any* v2" | ⚠ SUSPECT (minor) | critic_01a.wl D1d (limit holds for v2 ∈ (−1,1)); v2 = −1 gives 0/0 | "for any v2 > −1" or "for any \|v2\| < 1" |
| N4 | Number | "U_μ = γ(−1, v1, v2, v3)", "γ² = 1/(1−v²)", "−1 in (−,+,+,+); +1 in (+,−,−,−)" | ✅ PASS | critic_01a.wl D2; problems_01a.wl "with signature (+,-,-,-) the norm is +1" | none |
| N5 | Number | "Λ^{0'}_ν = (γ, −γv, 0, 0)", "p^{0'} = γE − γvE cosθ", γ(1−v) = √((1−v)/(1+v)), θ=π gives √((1+v)/(1−v)) > 1 | ✅ PASS | critic_01a.wl D3 (via invariant −p·u_obs, not the boost matrix), D3b | none |
| N6 | Number | "six time–space terms … −2ΣE_i²", "six space–space terms … 2(B1²+B2²+B3²)" | ✅ PASS | critic_01a.wl D4, D4c (numeric field, 6 nonzero spatial off-diagonals) | none |
| N7 | Number | "F_μνF^μν = Tr(F↓F↑ᵀ) = −Tr(F↓F↑)"; plain trace gives 2(\|E\|²−\|B\|²) | ✅ PASS | critic_01a.wl D4, D4b | none |
| N8 | Number | bridge: (v1+v2)/(1+v1v2) = v1+v2+O(v³) | ✅ PASS | critic_01a.wl D5 (2nd-order term zero, 3rd-order nonzero) | none |
| X1 | Consistency | boxes vs visible text: velocity addition, U·U = −1, Doppler factors, B²−E² invariant | ✅ PASS | internal: 01a_Solutions.tex visible lines 40–170 agree with every box value | none |
| X2 | Consistency | "Chapter~\ref{ch:linearized_gravity}" — field equations linear, deflections add | ✅ PASS | Notes/01e_Linearized_Gravity/01e_Linearized_Gravity.tex:10 (label), :40–41 ("deflection angles from multiple masses *superpose*") | none |
| X3 | Consistency | "Chapter~\ref{ch:multiplane_dspl} … multi-plane lens equation is a recursive sum" | ⚠ SUSPECT (pending) | Label resolves (14_Multiplane_DSPL.tex:10) but the chapter is a 13-line stub on this branch and on wt/ch14, so the content match cannot be checked. Physics confirmed: Congdon & Keeton 2018 PDF p. 123 (eqs. 4.99a–c, "Applying the lens equation recursively"; same-distance lenses reduce to the single-plane equation) | re-check once Ch. 14 lands |
| P1 | Prose | annotation title "Rapidities add; velocities do not" + closer "which is the invariance of c in its strongest form" | ⚠ SUSPECT (antithesis title + aphoristic closer) | internal read | closer → "…= 1 for any \|v2\| < 1: light moves at c in every inertial frame." |
| P2 | Prose | "a limit (φ→∞), not a boost" | ✅ (substantive contrast) | internal read | none |
| P3 | Prose | bridge "a recursive sum rather than a plain one" | ✅ (substantive contrast) | internal read | none |
| D1–D5 | Derivation | see below | ✅ PASS | critic_01a.wl | none |

Counts: 11 ✅ PASS (incl. D-block), 3 ⚠ SUSPECT, 0 ❌ FAIL.

## Applied (auto-fixes)

None.

## Flagged — your hand required

- **N3** (minor): "for *any* $v_2$" should exclude $v_2 = -1$ (0/0). Proposed: "for any $|v_2| < 1$".
- **X3** (pending): the bridge describes Chapter 14's multi-plane equation as a recursive sum. Physically correct (C&K 2018 p. 123, eqs. 4.99a–c), but the chapter is still a stub, so the cross-reference content cannot be checked yet. Re-check when Ch. 14 lands.
- **P1**: aphoristic closer, see Prose.

## Prose (LLM tells) — flag-only

New layer ≈ 590 words. Em-dashes: 0. Triads: 0. Antithesis: 3 hits, 2 of them substantive. One aphoristic closer (P1). The project-leakage grep (`tier|scripts/|results/|lenstronomy|autolens|J0946|AGEL|Carousel|this project`) is clean. Overall the layer reads clean.

## Derivation checks

Scratch script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_01abc/critic_01a.wl` (independent of problems_01a.wl. It uses velocity-parametrised boost matrices, the invariant −p·u for Doppler, and a numeric random E/B field).
`SUMMARY: 11 PASS, 0 FAIL  (of 11 checks)`

| id | equation | result |
|----|----------|--------|
| D1 | boost composition ⇒ velocity addition; (1,2) entry; v1→1 limit | PASS |
| D2 | U^μU_μ = −1 | PASS |
| D3 | E' = γE(1 − v cosθ); θ = 0, π special cases | PASS |
| D4 | F_μνF^μν = 2(B²−E²); trace-sign trap | PASS |
| D5 | bridge: velocity addition is linear to O(v³) | PASS |

## Resolution — fixes applied 2026-10-14

| id | Fix | Backing |
|----|-----|---------|
| N3 | Annotation "Rapidities add; velocities do not": "for \emph{any} $v_2$" → "for any $\|v_2\| < 1$" | problems_01a.wl "1a fix N3: v1 = 1 gives v = 1 for every \|v2\| < 1" and "1a fix N3: ... but v1 = 1, v2 = -1 is 0/0 (old 'for any v2' fails)" |
| P1 | Aphoristic closer "which is the invariance of $c$ in its strongest form" → ": light moves at $c$ in every inertial frame." (critic's wording) | prose only |

### Verification after edits
`bash Mathematica/run_wl.sh Solutions/01a_Special_Relativity/problems_01a.wl`: before `SUMMARY: 18 PASS, 0 FAIL  (of 18 checks)`, after `SUMMARY: 20 PASS, 0 FAIL  (of 20 checks)`.
Build fingerprints: `Learning_to_Lens.pdf 360 pages text-md5 e49fc6843f3f6c7c8ca53b9156a4552f sentinels 0` · `Learning_to_Lens_Solutions.pdf 444 pages text-md5 10cabda46607d9d87bfc5f1dce86e946 sentinels 0` · `Learning_to_Lens_Annotated.pdf 568 pages text-md5 b66a874ec79fcc96ea7f723a8be5808b sentinels 511`; `ANNOT_REQUIRED=1 bash build.sh` ended "all assertions passed".

### Left open
- X3 (pending): Ch. 14 bridge content, re-check when Ch. 14 lands.

### Session-3 closeout (2026-10-14, orchestrator)
- X3 closed: Chapter 18 is no longer a stub; `14_Multiplane_DSPL.tex:34,190` states the multi-plane lens equation is recursive, matching the bridge.