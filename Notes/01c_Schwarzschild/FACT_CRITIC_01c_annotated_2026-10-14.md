# fact-critic report — Notes/01c_Schwarzschild/01c_Solutions.tex (Annotated Study Edition layer + author flag 2)

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation
> Scope: the 6 `derivation` + 5 `annotation` + 1 `bridge` blocks added in commit 1e1a64c, and the
> "Annotated-edition checks (2026-10)" section of `Solutions/01c_Schwarzschild/problems_01c.wl`. Visible text was
> fact-critic'd 2026-07-01 and is not re-reviewed. Visible numbers appear below only where a box repeats them.
> Active adapters this run: bibtex n/a (no \cite in scope), crossref-web n/a, md-reflist ✗, values-file ✗,
> repo-grep ✓, doc-internal ✓, Reference_Texts PDFs ✓ (pdftotext: Saha+2024, Petters+2001, Congdon & Keeton 2018),
> wolframscript ✓ (Mathematica/run_wl.sh; built-in `Quantity` unit data), overlay: AGEL (not needed).

## Repo script run (quoted verbatim)

`bash Mathematica/run_wl.sh Solutions/01c_Schwarzschild/problems_01c.wl` → exit 0
`SUMMARY: 41 PASS, 0 FAIL  (of 41 checks)`

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | α' = f'/(2f) = R_S/(2r(r−R_S)); Γ^r_tt = ½ f f' = R_S(r−R_S)/(2r³); Γ^r_rr = −α'; Γ^r_θθ = −(r−R_S); Γ^θ_rθ = 1/r | ✅ PASS | critic_01c.wl D1 (Christoffels from the geodesic Lagrangian) | none |
| N2 | Number | Newtonian limit Γ^r_tt → R_S/(2r²) = M/r²; Γ invariant under g → −g | ✅ PASS | critic_01c.wl D1b; problems_01c.wl "Christoffels unchanged under g -> -g" | none |
| N3 | Number | B = α''+2α'²+(2/r)α' = (f''+2f'/r)/(2f) = 0; R_tt = R_rr = R_θθ = 0 (R_θθ = −rf' − f + 1) | ✅ PASS | critic_01c.wl D2 (full 4×4 Ricci from an independent Riemann code = 0), D2b | none |
| N4 | Number | orthonormal R_t̂r̂t̂r̂ = −R_S/r³, R_t̂θ̂t̂θ̂ = R_t̂φ̂t̂φ̂ = R_S/(2r³), R_θ̂φ̂θ̂φ̂ = R_S/r³, R_r̂θ̂r̂θ̂ = R_r̂φ̂r̂φ̂ = −R_S/(2r³) | ✅ PASS | critic_01c.wl D3 (explicit tetrad contraction, not the √\|g…\| shortcut), D3b (sign convention) | none |
| N5 | Number | K = 4·3 R_S²/r⁶ = 12R_S²/r⁶; K(R_S) = 12/R_S⁴ = 3/(4M⁴) | ✅ PASS | critic_01c.wl D4 (full contraction) | none |
| N6 | Number | R_S^⊙ = 2(6.674e−11)(1.989e30)/(2.998e8)² m **= 2953 m**; "R_S = 2.953 km (M/M_⊙)" | ⚠ SUSPECT (rounding) | critic_01c.wl prints 2953.845 m with the module's own constants, so 2954 m at the printed precision. The box agrees with visible line 205 ("≈ 2953 m"), which predates this layer | see Flagged |
| N7 | Number | R_S(10¹²M_⊙) = 2.95e15 m = 0.096 pc; ÷ 5e4 pc = 1.9e−6 | ✅ PASS | critic_01c.wl F2g (0.09573 pc; 1.915e−6) | none |
| N8 | Number | **1 pc = 3.0857 × 10¹⁶ m** (author flag 2) | ✅ PASS | (i) Saha et al. 2024, Reference_Texts PDF p. 37 (App. B): au = 1.495978707 × 10¹¹ m, and pc is defined as the distance at which 1 au subtends 1″, so pc = 648000/π au = 3.0856776 × 10¹⁶ m (critic_01c.wl F2a). (ii) Mathematica `UnitConvert[Quantity[1,"Parsecs"],"Meters"]` = 3.0856775815 × 10¹⁶ m (F2c). (iii) Coarse corroboration: Petters+2001 PDF p. 21 "~3.09 × 10¹⁶ m". The au value is the IAU 2012 Resolution B2 definition; the pc-from-au definition is IAU 2015 Resolution B2. Both are named here as the primary standards, but the evidence actually read is (i)–(ii) | none |
| N9 | Number | **1 AU = 1.496 × 10¹¹ m** (author flag 2) | ✅ PASS | Saha+2024 PDF p. 37 (1.495978707e11 m); Mathematica Quantity "AstronomicalUnit" = 1.495978707e11 m (F2b, F2d) | none |
| N10 | Number | bridge: **R_S(10⁹M_⊙) ≈ 2.95 × 10¹² m** ≈ 20 AU ≈ 10⁻⁴ pc; ~10⁷ below a kpc (author flag 2) | ✅ PASS | critic_01c.wl F2e: 2.9538e12 m with the module constants (G = 6.674e−11, c = 2.998e8, M_⊙ = 1.989e30, the same as verify_against_textbooks.wl:24) and 2.9532e12 m with Mathematica's built-in G, c, M_⊙ Quantities; F2f: 19.75 AU, 9.57e−5 pc, 1 kpc/R_S = 1.04e7 | none |
| N11 | Number | Sun x = 4.24e−6 | ⚠ SUSPECT (rounding) | With the stated constants and R_⊙ = 6.957e8 m: 2953.85/6.957e8 = 4.246e−6, which is 4.25e−6 at 3 s.f. The 4.24 follows from the truncated 2953. The box agrees with visible line 207 | see Flagged |
| N12 | Number | z = x/2 + 3x²/8 + O(x³); z_⊙ = 2.12e−6; 0.306/2.12e−6 ≈ 1.44e5 | ✅ PASS | critic_01c.wl D5; z_⊙ = 2.123e−6 from either x; ratio 1.443e5 | none |
| N13 | Number | NS x = 0.414: 0.207 / 0.271 / 0.306 | ✅ PASS | critic_01c.wl D5b (0.2070, 0.2713, 0.3063) | none |
| N14 | Number | "weak-field expansion … accurate to roughly one part in 10⁶" for x ~ 10⁻⁶ | ✅ PASS | relative correction 3x/4 = 1.4e−6 for x = 1.9e−6 (problems_01c.wl check + N7) | none |
| N15 | Number | Flamm: ∫√(R_S/u)du = 2√(R_S u); z² = 4R_S(r−R_S); dz/dr → ∞ at R_S | ✅ PASS | critic_01c.wl D6; problems_01c.wl 3 checks | none |
| X1 | Consistency | eq refs christoffel_schwarzschild, alpha_beta, e2alpha, Rtt–Rphph, eddington_finkelstein; "β = −α" | ✅ PASS | 01c_Schwarzschild.tex:202–211, :233–237 (constant set to zero by rescaling t), :248, :217–226, :484–489; the box formulas match the chapter forms term by term | none |
| X2 | Consistency | \ref{ex:kretschmann}, ex:schwarzschild_radii | ✅ PASS | 01c_Schwarzschild.tex:734, :741 | none |
| X3 | Consistency | bridge "Chapter~\ref{ch:power_law_point_mass} (a supermassive black hole at the centre of a lens galaxy)" | ⚠ SUSPECT (pending) | Label resolves (15_PowerLaw_PointMass.tex:10), but it is a 12-line stub on this branch. The in-progress, uncommitted draft at Learning_to_Lens_wt/ch15/Notes/15_PowerLaw_PointMass/15_PowerLaw_PointMass.tex:26 does describe "the supermassive black hole that sits at the centre of" the lens | re-check when Ch. 15 is committed |
| X4 | Consistency | bridge "weak-field point-mass deflection of Chapter~\ref{ch:light_deflection}" | ✅ PASS | 02_Light_Deflection.tex:10 (Ch. "Light Deflection in Curved Spacetime") | none |
| X5 | Consistency | "a point mass has zero convergence everywhere except at its position, yet it still produces shear and deflection" | ✅ PASS | Notes/05_Magnification_Convergence_Shear/05_Solutions.tex:155–159 | none |
| N16 | Number | annotation: "at r = R_S … every orthonormal Riemann component above stays finite (\|R_âb̂âb̂\| ≤ R_S/r³)" | ⚠ SUSPECT (physics wording) | The bound holds (critic_01c.wl D3/D4b). However, the static frame e_t̂ = f^{−1/2}∂_t used to define these components does not exist at r = R_S (no static observers on the horizon), so "at r = R_S" in that frame is a limit statement | "…stays finite as r → R_S (\|R_âb̂âb̂\| ≤ R_S/r³)". Optionally add that a freely falling frame measures the same values. That addition is not checked in this pass; verify before adding |
| P1 | Prose | "the trouble at r = R_S lives in the coordinate, not the geometry." (Flamm annotation closer) | ⚠ SUSPECT (antithesis + aphoristic closer) | internal read | "…as in Exercise kretschmann, the divergence at r = R_S comes from the coordinate r, and the curvature there is finite." |
| P2 | Prose | "the surface itself is perfectly smooth there" | ⚠ SUSPECT (intensifier) | internal read | drop "perfectly" |
| D1–D6 | Derivation | see below | ✅ PASS | critic_01c.wl | none |

Counts: 18 ✅ PASS (incl. D-block), 6 ⚠ SUSPECT, 0 ❌ FAIL.

## Applied (auto-fixes)

None. N6 and N11 are single-source rounding slips, but the same values sit in visible text (lines 205, 207), which was reviewed in July and is out of scope here. Fixing only the box would create a box-vs-visible inconsistency. They are flagged for the author to change in both places together.

## Flagged — your hand required

- **Author flag 2 — ADJUDICATED: all three values are correct.** 1 pc = 3.0857e16 m (Saha+2024 PDF p. 37 au value × 648000/π = 3.08568e16. Mathematica Quantity gives 3.0856776e16). 1 AU = 1.496e11 m (1.495978707e11 m, same two sources). R_S(10⁹ M_⊙) = 2.954e12 m with the module constants (verify_against_textbooks.wl:24 uses the same G, c, M_⊙) and 2.953e12 m with Mathematica's built-in constants, so "≈ 2.95e12 m" holds. The derived values are 19.7 AU (≈ 20 ✓), 9.6e−5 pc (≈ 10⁻⁴ ✓) and 1 kpc/R_S = 1.04e7 (≈ 10⁷ ✓). Named primary standards: IAU 2012 Resolution B2 (au) and IAU 2015 Resolution B2 (pc). These were not opened in this pass; the evidence actually read is Saha+2024 App. B and Mathematica's unit tables.
- **N6 + N11 (rounding, box and visible text together):** with the module's own constants R_S^⊙ = 2953.85 m, which is 2954 m (2.954 km), and R_S^⊙/R_⊙ = 4.246e−6, which is 4.25e−6. Propose 2953 → 2954 and 2.953 → 2.954 in the Ex 1.3 derivation box (01c_Solutions.tex:221–222), 2953 → 2954 at visible line 205, and 4.24 → 4.25 at visible line 207 and in the Ex 1.4 box (line 279). Downstream values do not change at their printed precision: z_⊙ = 2.12e−6, ratio 1.44e5, 2.95e15 m and 0.096 pc all stand. problems_01c.wl "RS(Msun) = 2953 m (to 1 m)" passes only because its tolerance is \|Δ\| < 1 m. Tighten it to `Round[RSsun] == 2954` if adopted.
- **X3** (pending): the Ch. 15 cross-reference content is supported only by the uncommitted ch15 draft (line 26).
- **N16**: horizon-limit wording in the Kretschmann annotation.
- **P1, P2**: see Prose.

## Prose (LLM tells) — flag-only

New layer ≈ 1250 words. Em-dashes: 0. Triads: 0 (the "Three traps" annotation is a genuine list of three named items). Antithesis: 1 ornamental (P1). Aphoristic closer: 1 (P1). Intensifier: 1 (P2, "perfectly"). The \emph{is} in "\emph{is} decisive" is functional emphasis. Project-leakage grep: clean. Otherwise the layer reads clean.

## Derivation checks

Scratch script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_01abc/critic_01c.wl`. Christoffels come from the geodesic Lagrangian. Riemann uses fresh code with non-shadowing indices, and orthonormal components use an explicit tetrad. The constants come from two independent sources (the module's SI values and Mathematica `Quantity`).
`SUMMARY: 19 PASS, 0 FAIL  (of 19 checks)`

| id | equation | result |
|----|----------|--------|
| D1 | Schwarzschild Christoffels + Newtonian limit | PASS |
| D2 | R_μν = 0 (full 4×4) and B = (f''+2f'/r)/(2f) | PASS |
| D3 | six orthonormal Riemann pair components and sign convention | PASS |
| D4 | K = 12R_S²/r⁶, K(R_S) = 3/(4M⁴) | PASS |
| D5 | redshift series; NS 0.207 / 0.271 / 0.306 | PASS |
| D6 | Flamm integral z = 2√(R_S(r−R_S)) | PASS |
| F2a–g | pc, AU, R_S scalings (flag 2) | PASS |
| N-rounding | R_S^⊙ rounds to 2954 m | PASS (confirms N6) |
