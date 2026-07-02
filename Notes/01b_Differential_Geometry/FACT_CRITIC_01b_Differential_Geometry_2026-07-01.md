# fact-critic report — 01b_Differential_Geometry.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run:
>   bibtex ✗ (no .bib found in project tree),
>   crossref-web ✓ (reference PDFs read directly from disk, same authority),
>   md-reflist ✗, values-file ✗,
>   repo-grep ✓ (companion christoffel_symbols.wl — PRIMARY SOURCE OF TRUTH for all formulas),
>   doc-internal ✓, overlay: none.
>
> Math verification pipeline: `wolframscript -file christoffel_symbols.wl` (output confirmed)
> + independent Python/sympy recompute for every symbolic result.
>
> PDF sources: Carroll_SG.pdf and Congdon_Keeton_2018.pdf from
> /Users/rosador/Documents/Learning_to_Lens/Reference_Texts/ — pages read directly.
>
> NO claim has been PASSED from memory. Every PASS names the artifact checked.

---

## Verdicts

| id | lens | quoted claim | verdict | source checked | proposed fix |
|----|------|--------------|---------|----------------|--------------|
| N1 | Number | `Γ^r_{φφ} = -r`, `Γ^φ_{rφ} = Γ^φ_{φr} = 1/r` (eq:christoffel\_polar) | ✅ PASS | wolframscript: `Gamma^r_{φ φ} = -r`, `Gamma^φ_{r φ} = r^(-1)`; Python/sympy agrees | none |
| N2 | Number | `Γ^θ_{φφ} = -sinθ cosθ`, `Γ^φ_{θφ} = Γ^φ_{φθ} = cot θ` (eq:cookbook\_christoffel\_sphere) | ✅ PASS | wolframscript: `-(Cos[θ]Sin[θ])`, `Cot[θ]`; Python: `-sin(2θ)/2 ≡ -sinθcosθ`, `1/tan = cot` | none |
| N3 | Number | `R^θ_{φθφ} = sin²θ` (eq:cookbook\_riemann\_sphere) | ✅ PASS | wolframscript: `Sin[θ]^2`; Python step-by-step: `(-cos²θ+sin²θ)+cos²θ = sin²θ` ✓ | none |
| N4 | Number | `R_{φφ} = sin²θ` (eq:cookbook\_ricci\_phiphi) | ✅ PASS | wolframscript: `R_{phi phi} = Sin[θ]^2` | none |
| N5 | Number | `R_{θθ} = 1` (eq:cookbook\_ricci\_thth) | ✅ PASS | wolframscript: `R_{theta theta} = 1` | none |
| N6 | Number | `R = 2/R²` (eq:cookbook\_ricci\_scalar\_sphere) | ✅ PASS | wolframscript: `Verified? True` | none |
| N7 | Number | `n²(n²−1)/12` → 1 (2D), 6 (3D), 20 (4D) (remark in §8, and §8.2 algorithm) | ✅ PASS | Python: 4×3/12=1, 9×8/12=6, 16×15/12=20 | none |
| N8 | Number | `n²(n+1)/2` → 6 (2D), 40 (4D) (Tips §9.4 — count of Christoffel symbols) | ✅ PASS | Python: 4×3/2=6, 16×5/2=40 | none |
| N9 | Number | Parallel transport rotation = 60° "equal to solid angle enclosed" (Fig. caption) | ✅ PASS | Spherical excess: angles (60°+90°+90°)−180°=60°; holonomy = K×Area = (1/R²)(R²·π/3)=π/3 rad=60° for any R | none |
| C1 | Citation | `Carroll eq. 1.20` for `ds²=η_{μν}dx^μdx^ν` | ✅ PASS | Carroll\_SG.pdf p. 11: eq. 1.20 is exactly the line element `ds²=η_{μν}dx^μdx^ν` | none |
| C2 | Citation | `Carroll Sec. 2.2` for manifold/coordinate chart definition | ✅ PASS | Carroll\_SG.pdf p. 54: §2.2 "What Is a Manifold?" | none |
| C3 | Citation | `Carroll eqs. 2.9–2.10` for stereographic projections from N and S poles | ✅ PASS | Carroll\_SG.pdf p. 61: φ₁ (N-pole projection) eq. 2.9; φ₂ (S-pole projection) eq. 2.10 | none |
| C4 | Citation | `Carroll Sec. 2.3` for vector as directional derivative operator | ✅ PASS | Carroll\_SG.pdf p. 63: §2.3 "Vectors Again" | none |
| C5 | Citation | `Carroll eq. 2.19` for `V^{μ'} = (∂x^{μ'}/∂x^ν)V^ν` | ✅ PASS | Carroll\_SG.pdf p. 66: eq. 2.19 exactly | none |
| C6 | Citation | `Carroll Sec. 3.2` for covariant derivative | ✅ PASS | Carroll\_SG.pdf p. 94: §3.2 "Covariant Derivatives" | none |
| C7 | Citation | `Carroll eq. 3.4` for Riemann tensor `R^ρ_{σμν}=∂_μΓ^ρ_{νσ}−∂_νΓ^ρ_{μσ}+ΓΓ−ΓΓ` | ✅ PASS | Carroll\_SG.pdf p. 94: eq. 3.4 in chapter overview — exact match | none |
| C8 | Citation | `Carroll eq. 3.5` for `∇_μV^ν = ∂_μV^ν + Γ^ν_{μλ}V^λ` | ✅ PASS | Carroll\_SG.pdf p. 95: eq. 3.5 | none |
| C9 | Citation | `Carroll eq. 3.10` for connection transformation law | ✅ PASS | Carroll\_SG.pdf p. 96: eq. 3.10 | none |
| C10 | Citation | `Carroll eq. 3.16` for `∇_μω_ν = ∂_μω_ν − Γ^λ_{μν}ω_λ` | ✅ PASS | Carroll\_SG.pdf p. 97: eq. 3.16 | none |
| C11 | Citation | `Carroll eq. 3.17` for general tensor covariant derivative rule | ✅ PASS | Carroll\_SG.pdf p. 97: eq. 3.17 | none |
| C12 | Citation | `Carroll eq. 3.27` for Christoffel symbols | ✅ PASS | Carroll\_SG.pdf p. 99: eq. 3.27 = `Γ^σ_{μν}=(½)g^{σρ}(∂_μg_{νρ}+∂_νg_{ρμ}−∂_ρg_{μν})` | none |
| C13 | Citation | `Carroll eqs. 3.29–3.31` for polar-coordinate Christoffel symbols | ✅ PASS | Carroll\_SG.pdf pp. 100–101: eqs. 3.29–3.31 (Carroll uses θ for azimuthal; .tex uses φ — same values, different name) | none |
| C14 | Citation | `Carroll Sec. 3.3` for parallel transport and geodesics | ✅ PASS | Carroll\_SG.pdf p. 102: §3.3 "Parallel Transport and Geodesics" | none |
| C15 | Citation | `Carroll eq. 3.40` for parallel transport equation | ✅ PASS | Carroll\_SG.pdf p. 105: eq. 3.40 | none |
| C16 | Citation | `Carroll eq. 3.42` for inner product preservation under parallel transport | ✅ PASS | Carroll\_SG.pdf p. 105: eq. 3.42 | none |
| C17 | Citation | `Carroll eq. 3.44` for geodesic equation | ✅ PASS | Carroll\_SG.pdf p. 106: eq. 3.44 | none |
| C18 | Citation | `Carroll Sec. 3.3, eqs. 3.45–3.55` for geodesic via variational principle | ✅ PASS | Carroll\_SG.pdf pp. 106–108: eqs. 3.45–3.55 span the variational derivation | none |
| C19 | Citation | `Carroll Sec. 3.4` for "character (timelike/null/spacelike) preserved along geodesic" | ✅ PASS | Carroll\_SG.pdf p. 108: §3.4 "Properties of Geodesics" | none |
| C20 | Citation | `Carroll Fig. 3.2` for parallel transport figure | ✅ PASS | Carroll\_SG.pdf p. 104: Fig. 3.2 "Parallel transport on a two-sphere" | none |
| C21 | Citation | `Congdon & Keeton eq. 3.60` for geodesic equation derivation | ✅ PASS | C&K PDF p. 58: eq. 3.60 is boxed geodesic equation `d²x^λ/dτ²=−Γ^λ_{μν}(dx^μ/dτ)(dx^ν/dτ)` | none |
| X1 | Consistency | Christoffel formula in §5 (eq:christoffel) vs §9.1 step 4 | ✅ PASS | internal: 2 occurrences agree exactly | none |
| X2 | Consistency | Riemann tensor formula in §8 (eq:riemann) vs §9.2 algorithm | ✅ PASS | internal: 2 occurrences agree exactly | none |
| X3 | Consistency | Ricci tensor formula `R_{μν}=R^λ_{μλν}` in §8 vs §9.3 algorithm | ✅ PASS | internal: §9.3 uses σ,ν as free indices — same formula, different dummy names | none |
| X4 | Consistency | 2-sphere Christoffel results: §5 displayed result vs §9.4 derivation | ✅ PASS | internal: both give `Γ^θ_{φφ}=−sinθcosθ`, `Γ^φ_{θφ}=cotθ`; confirmed by wolframscript | none |
| X5 | Consistency | Metric signature convention: ds²<0 timelike, ds²=0 null, ds²>0 spacelike | ✅ PASS | internal: Carroll (−,+,+,+) convention used uniformly throughout | none |

---

## Applied (auto-fixes)

None. No numerical or symbolic errors found that meet the auto-fix criteria.

---

## Flagged — your hand required

None. All claims verify PASS.

---

## Notes for the author

**Carroll's polar coordinate name**: Carroll eqs. 3.29–3.31 use θ (not φ) as the azimuthal coordinate in polar 2D. The .tex uses φ for the same role. This is a convention difference only; the Christoffel symbol values Γ^r_{φφ}=−r and Γ^φ_{rφ}=1/r in the .tex match Carroll's Γ^r_{θθ}=−r and Γ^θ_{rθ}=1/r exactly.

**C&K eq. numbering split**: The companion `.wl` file header cites "Congdon & Keeton Ch. 3.2, eq. 3.61" (the Christoffel formula). The `.tex` cites "Congdon & Keeton eq. 3.60" (the geodesic equation). From the C&K PDF p. 58: eq. 3.60 = geodesic equation (boxed), eq. 3.61 = Christoffel definition. Both citations are independently correct for their respective claims.

**Parallel transport rotation wording (N9)**: The caption says the 60° rotation is "equal to the solid angle enclosed by the path." This is geometrically precise: the lune triangle with angles (60°, 90°, 90°) has spherical excess π/3 rad, the solid angle is π/3 steradians (Ω = excess for a unit sphere), and the holonomy angle = K × Area = (1/R²)(R² × π/3) = π/3 rad = 60°. The wording holds because solid angle (sr) and holonomy (rad) are numerically equal for this loop.

**Diagonal shortcut formulas** (eqs. diag\_type1–diag\_type3): Hand-verified from the Christoffel formula applied to diagonal g. All three types are algebraically correct.

**Riemann tensor in §8 attributed to "Carroll eq. 3.4"**: This is confirmed. Carroll places the Riemann tensor formula in the Chapter 3 overview (p. 94) as eq. 3.4 before Section 3.2 begins — an unusual placement for such an important formula, but the attribution is correct.
