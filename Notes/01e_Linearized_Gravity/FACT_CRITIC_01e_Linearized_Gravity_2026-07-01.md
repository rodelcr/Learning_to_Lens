# fact-critic report — 01e_Linearized_Gravity.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib file present), crossref-web ✓ (network
> reachable; Will 2014 DOI confirmed via arXiv; Cassini value unconfirmed from body text),
> md-reflist ✗, values-file ✗, repo-grep ✓ (Wolfram .wl file as canonical source),
> doc-internal ✓, overlay: none.
> Note: companion Mathematica file weak_field_metric.wl treated as canonical source
> (repo-grep adapter); wolframscript narrative = ground truth for numbers, even
> where the wl comment has inconsistent arithmetic.

---

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | `Carroll eq.~4.11` for `\|Φ\|/c² = GM/rc²` at solar limb (line 61) | ❌ FAIL | Carroll_SG.pdf Ch.4 (prev session): eq 4.11 = Christoffel symbol `Γ^μ_{00} = -½η^μλ∂_λh_00` | Remove/replace; formula follows from 4.11–4.19 combination; no single eq maps directly |
| C2 | Citation | `Carroll Sec.~4.1` for Newtonian limit conditions (line 143) | ⚠ SUSPECT | Section header not directly read from PDF; content plausible (equations 4.11–4.19 are in the Newtonian limit context) | Verify section title; likely correct but unconfirmed |
| C3 | Citation | `Carroll eq.~7.1` for `g_μν = η_μν + h_μν` (line 93) | ✅ PASS | Carroll_SG.pdf Ch.7 (prev session): eq 7.1 = metric perturbation decomposition | none |
| C4 | Citation | `Carroll eq.~7.2` for inverse metric `g^μν = η^μν − h^μν` (line 106) | ✅ PASS | Carroll_SG.pdf Ch.7 (prev session): eq 7.2 confirmed | none |
| C5 | Citation | `Carroll eq.~7.4` for linearized Christoffel symbols (line 113) | ✅ PASS | Carroll_SG.pdf Ch.7 (prev session): eq 7.4 confirmed | none |
| C6 | Citation | `Carroll eq.~3.44` for geodesic equation (line 153) | ✅ PASS | Carroll_SG.pdf p.106: eq 3.44 = `d²x^μ/dλ² + Γ^μ_{ρσ} dx^ρ/dλ dx^σ/dλ = 0`, labeled "the geodesic equation" | none |
| C7 | Citation | `Carroll eq.~4.12` for `h_00 = -2Φ/c²` identification (line 205) | ❌ FAIL | Carroll_SG.pdf Ch.4 (prev session): eq 4.12 = `g_μν = η_μν + h_μν` decomposition; the h_00 identification is Carroll eq 4.19 (in c=1 units) | Replace `4.12` → `4.19` (note: Carroll uses c=1; the 1/c² factor is a unit-restoration) |
| C8 | Citation | `C&K eq.~3.68` for linearized metric `g_μν = η_μν + h_μν` (line 93) | ❌ FAIL | C&K PDF p.60 (book §3.3.2): eq 3.68 = full Schwarzschild metric `ds²=(1−2GM/c²r)c²dt²−…`; not the linearized perturbation | Remove C&K 3.68 from this citation; the tex cites C&K 3.71 elsewhere for the correct weak-field form |
| C9a | Citation | `C&K eq.~3.71` for weak-field isotropic metric (line 250) | ✅ PASS | C&K PDF p.61 (book §3.3.2): eq 3.71 = `ds²≈(1+2Φ/c²)c²dt²−(1−2Φ/c²)[dρ²+ρ²dΩ²]` for `\|Φ\|/c²≪1` | none |
| C9b | Citation | `Carroll eq.~7.8` for weak-field isotropic metric (line 250) | ❌ FAIL | Carroll_SG.pdf Ch.7 (prev session): eq 7.8 = linearized Einstein tensor `G_μν^(1)`; correct eq for weak-field metric = Carroll 7.59 | Replace `7.8` → `7.59` |
| C10 | Citation | `C&K eq.~3.77` for temporal-only deflection integral (line 347) | ❌ FAIL | C&K PDF p.62 (book §3.3.3): eq 3.77 = massive-particle geodesic constraint `c²=(1−R_S/r)c²ṫ²−(1−R_S/r)⁻¹ṙ²−r²φ̇²`; no C&K equation is the temporal deflection integral formula | Remove/replace; the temporal deflection argument is narrative in C&K §3.4.1 (not a standalone equation) |
| C11a | Citation | `C&K eq.~3.78` for PPN deflection formula (line 361) | ❌ FAIL | C&K PDF p.62: eq 3.78 = energy conservation for massive particles `ṙ²=(ε²/c²)−(1−R_S/r)(ℓ²/r²+c²)`; C&K do not state a PPN formula | Remove C&K 3.78; C&K 3.96 gives the total `α̂=4GM/(c²ξ)` but not the PPN split |
| C11b | Citation | `Will 1993` for PPN formula (line 361) | ⚠ SUSPECT | CrossRef search returned no results; Will 1993 ("Theory and Experiment in Gravitational Physics," Cambridge) is a standard reference for PPN formalism but not confirmed via adapter | Existence plausible; cannot PASS; verify from Zotero or hand-check book |
| C12a | Citation | `Carroll eq.~7.47` for Fermat principle / time delay (line 520) | ❌ FAIL | Carroll_SG.pdf Ch.7 (prev session): eq 7.47 = vector decomposition `w^i = w^i_⊥ + w^i_∥`; refractive index is Carroll eq 7.85 (`n = 1 − 2Φ`) | Replace `7.47` → `7.85` |
| C12b | Citation | `C&K eq.~6.1` for Fermat principle / time delay (line 521) | ❌ FAIL | C&K PDF p.146 (book §6.1.1): eq 6.1 = shear lens potential `ψ_γ(x,y) = −γ/2(x²−y²)`; Fermat potential is C&K eq 4.25 | Replace `6.1` → `4.25` |
| C13 | Citation | `C&K eq.~4.5` for continuous-mass deflection integral (line 574) | ❌ FAIL | C&K PDF p.88 (book §4.1.1): eq 4.5 = approximate point-mass projected potential `ψ̂_PM ≈ −(2GM/c²)[ln(2D_l/R)+ln(2D_ls/R)]`; continuous-distribution deflection is C&K eq 4.9 | Replace `4.5` → `4.9` |
| C14 | Citation | `C&K eq.~4.1` for lens equation `β = θ − (D_ls/D_s)α̂(θ)` (line 622) | ❌ FAIL | C&K PDF p.87 (book §4.1.1): eq 4.1 = deflection as gradient `α̂(ξ)=(2/c²)∫∇_ξΦdz ≡ ∇_ξψ̂(ξ)`; lens equation is C&K eq 4.26 | Replace `4.1` → `4.26` |
| C15 | Citation | `Will 2014, Living Reviews in Relativity` for `\|γ_PPN−1\| < 2.3×10⁻⁵` (line 380) | ⚠ SUSPECT | arXiv:1403.7377 confirmed (LRR 17, 4, 2014); Cassini constraint value not confirmed from body text (Springer redirect blocked full-text fetch) | Paper exists; value is from Bertotti, Iess & Tortora 2003 (Nature 425, 374) — confirm that Will 2014 §4.4 quotes this value |
| N1 | Number | `\|Φ\|/c² ≈ 2.1×10⁻⁶` at solar surface (line 66) | ✅ PASS | Wolfram wl §4 `nMinus1[Rsolar]=2GM/(c²R_⊙)` narrative; python recompute: 2.1e-6 | none |
| N2 | Number | `\|Φ\|/c² ~ 10⁻⁵ to 10⁻⁴` for galaxy `M~10¹² M_⊙, r~10 kpc` (line 70) | ⚠ SUSPECT | python: `GM/(c²r)=6.674e-11×1.989e42/(8.988e16×3.086e20)=4.8×10⁻⁶`; below stated lower bound; not in Wolfram wl | Range should be `~5×10⁻⁶` at stated parameters; range 10⁻⁵–10⁻⁴ corresponds to r~0.5–5 kpc |
| N3 | Number | `α̂ ≈ 1.75″` (solar limb deflection, exercise line 472) | ✅ PASS | Wolfram wl §3: `alphaHatSunArcsec = 4GM_⊙/(c²R_⊙)×(180×3600/π)` → 1.75″; confirmed | none |
| N4 | Number | `R_S ≈ 3 km` for the Sun (line 424) | ✅ PASS | python: `2GM_⊙/c² = 2×6.674e-11×1.989e30/(2.998e8)² = 2954 m ≈ 3 km` | none |
| N5 | Number | `b/R_S ~ 2×10⁵` for solar limb (fig caption line 424) | ⚠ SUSPECT | python: `R_⊙/R_S = 6.96e8/2954 = 2.356×10⁵`; not in Wolfram wl; stated "~2×10⁵" is 18% low | Consider `~2.4×10⁵`; within ~ notation but worth correcting |
| N6 | Number | `α_time = (2/c²)∫∇⊥\|Φ\|dl` — prefactor for temporal contribution (line 349) | ❌ FAIL (auto-fixed) | Wolfram wl §3 narrative: "alpha_time = 2GM/(c²b)" requires prefactor `1/c²`; PPN γ=0 case: `(1+0)/c²×(2GM/b)=2GM/(c²b)`; Carroll 7.78 (prev session) | `\frac{2}{c^2}` → `\frac{1}{c^2}` |
| X1 | Consistency | `(2/c²)∫` in eq `deflection_integral_half` vs "each contributes 2GM/(c²b)" in §"Factor of Two" (lines 349, 437–443) | ❌ FAIL (auto-fixed via N6) | internal: "Factor of Two" section correctly states α_time = 2GM/(c²b); formula gives 4GM/(c²b) | Resolved by N6 fix |

---

## Applied (auto-fixes)

- **N6 / X1**: `\frac{2}{c^2}` → `\frac{1}{c^2}` in eq `deflection_integral_half`
  [`01e_Linearized_Gravity.tex`, line 349]
  — Source: Wolfram wl §3 narrative (α_time = 2GM/(c²b)); PPN γ=0 case; internal consistency with "Factor of Two" section.
  — Note: `weak_field_metric.wl` line 146 has the SAME arithmetic error in the comment
  `"alpha_time = (2/c^2) * GM * (2/b) = 4GM/(c^2 b) * (1/2) = 2GM/(c^2 b)"` — the
  `*(1/2)` step is unjustified; however the stated result `2GM/(c^2 b)` is correct and
  is the canonical value. The wl comment should also be corrected but is out of scope here.

---

## Flagged — your hand required

### Citation failures (10 equations misattributed)

**C1** — `Carroll eq.~4.11` (line 61): Carroll 4.11 = linearized Christoffel Γ^μ_{00};
not a formula for |Φ|/c². No single Carroll equation states this formula. Either remove
the citation or reference the paragraph in §4.1 where the Newtonian potential is defined.

**C7** — `Carroll eq.~4.12` (line 205): Carroll 4.12 = g=η+h decomposition. The h_00
identification is Carroll eq **4.19** (which in c=1 units gives h_00 = -2Φ; the
1/c² factor restores SI).

**C8** — `C&K eq.~3.68` (line 93): C&K 3.68 = full Schwarzschild metric. The
linearized expansion `g = η + h` does not have a standalone C&K equation number; the
weak-field isotropic limit appears at C&K 3.71. Either remove C&K 3.68 or rephrase
to "C&K §3.3.2" (the section containing the expansion leading to 3.71).

**C9b** — `Carroll eq.~7.8` (line 250): Carroll 7.8 = linearized Einstein tensor G_μν^(1).
Correct reference for the weak-field isotropic metric = **Carroll eq. 7.59**.

**C10** — `C&K eq.~3.77` (line 347): C&K 3.77 = massive-particle geodesic constraint.
The temporal-only deflection argument is narrative in C&K §3.4.1 (no standalone
equation for the time-piece integrand). Replace with a reference to C&K §3.4.1 or
remove.

**C11a** — `C&K eq.~3.78` (line 361): C&K 3.78 = energy conservation for massive
particles. C&K never state a PPN formula — they derive the full GR result directly
(eq 3.96: α̂ = 4GM/(c²ξ)). Remove C&K 3.78; cite Will 2014 alone for the PPN
formula (pending C11b resolution).

**C11b** — `Will 1993` (line 361): Book plausible but CrossRef adapter found no entry.
Check Zotero or library catalog. If confirmed, the PPN formula is in Will 1993 Chapter 7
(post-Newtonian limit and bending of light).

**C12a** — `Carroll eq.~7.47` (line 520): Carroll 7.47 = vector decomposition
w^i = w^i_⊥ + w^i_∥. The refractive-index / Fermat principle claim maps to
**Carroll eq. 7.85** (n = 1 − 2Φ, c=1 units).

**C12b** — `C&K eq.~6.1` (line 521): C&K 6.1 = shear lens potential
ψ_γ = -γ/2(x²-y²), Chapter 6 "Strong Lensing by Galaxies." The Fermat potential
(time delay functional) is **C&K eq. 4.25**: τ(θ|β) = ½|θ−β|² − ψ(θ).

**C13** — `C&K eq.~4.5` (line 574): C&K 4.5 = approximate point-mass projected
potential for finite source/observer distances. The continuous-distribution deflection
vector is **C&K eq. 4.9**:
α̂(ξ) = (4G/c²) ∫ Σ(ξ')(ξ−ξ')/|ξ−ξ'|² d²ξ'.

**C14** — `C&K eq.~4.1` (line 622): C&K 4.1 = deflection as gradient of scalar
potential α̂(ξ) = ∇_ξψ̂(ξ). The lens equation β = θ − α(θ) is **C&K eq. 4.26**
(derived from Fermat's principle / stationary Fermat potential).

### Suspect numbers

**N2** — Galaxy potential range (line 70): stated "10⁻⁵ to 10⁻⁴" for M~10¹² M_⊙,
r~10 kpc. Python gives GM/(c²r) = 4.8×10⁻⁶ ≈ 5×10⁻⁶, which falls below the stated
lower bound. The range 10⁻⁵–10⁻⁴ corresponds to r ≈ 0.5–5 kpc for that mass. Either
correct the range to "~5×10⁻⁶" for the stated parameters, or change r to "~1–5 kpc"
to match the stated range.

**N5** — b/R_S for solar limb (figure caption, ~line 424): stated "~2×10⁵"; python
gives 2.356×10⁵ (18% above stated value). Within the ~ convention but worth updating
to "~2.4×10⁵" for accuracy. No Wolfram wl canonical value for this specific quantity.

### Suspect citations (unverifiable via available adapters)

**C2** — `Carroll Sec.~4.1` for Newtonian limit conditions: section header not directly
confirmed from PDF read. Equations 4.11–4.19 are in the Newtonian limit context;
section number plausibly correct but unconfirmed.

**C11b** — `Will 1993` for PPN formalism: CrossRef returned null. Confirm via Zotero.

**C15** — `Will 2014` |γ_PPN − 1| < 2.3×10⁻⁵: paper exists (arXiv:1403.7377,
LRR 17, 4); Cassini value not confirmed from body text. The underlying measurement
is Bertotti, Iess & Tortora 2003 (Nature 425, 374); Will 2014 §4.4 is where this
value is reviewed. Verify the exact inequality sign and digits against Will 2014 body text.

### Wolfram companion file note

`weak_field_metric.wl` line 146 contains internally inconsistent arithmetic:
`"(2/c^2) * GM * (2/b) = 4GM/(c^2 b) * (1/2) = 2GM/(c^2 b)"`.
The step `× (1/2)` has no algebraic justification. The Wolfram writer appears to have
the same factor-of-2 confusion as in the tex formula, but correctly states the result
as 2GM/(c²b). The wl comment should be corrected to
`"(1/c^2) * GM * (2/b) = 2GM/(c^2 b)"` — but this is out of scope for the tex review.

---

## Correction summary table

| equation / location | error type | fix |
|---|---|---|
| `deflection_integral_half` (line 349) | prefactor 2/c² → gives total not half | AUTO-FIXED: 1/c² |
| `Carroll eq.~4.11` (line 61) | equation number wrong | flag: formula has no single Carroll eq; cite §4.1 prose |
| `Carroll eq.~4.12` (line 205) | equation number wrong | flag: correct = Carroll 4.19 |
| `C&K eq.~3.68` (line 93) | equation number wrong | flag: 3.68=Schwarzschild; remove or cite §3.3.2 |
| `Carroll eq.~7.8` (line 250) | equation number wrong | flag: 7.8=Einstein tensor; correct = Carroll 7.59 |
| `C&K eq.~3.77` (line 347) | equation number wrong | flag: 3.77=massive geodesic; no C&K eq for time-piece integral |
| `C&K eq.~3.78` (line 361) | equation number wrong | flag: 3.78=energy conservation; remove; use C&K §3.4.1 |
| `Carroll eq.~7.47` (line 520) | equation number wrong | flag: 7.47=vector decomp; correct = Carroll 7.85 |
| `C&K eq.~6.1` (line 521) | equation number wrong (wrong chapter) | flag: 6.1=shear potential; correct = C&K 4.25 |
| `C&K eq.~4.5` (line 574) | equation number wrong | flag: 4.5=PM potential approx; correct = C&K 4.9 |
| `C&K eq.~4.1` (line 622) | equation number wrong | flag: 4.1=deflection gradient; lens eq = C&K 4.26 |
| galaxy `\|Φ\|/c² ~ 10⁻⁵–10⁻⁴` (line 70) | value mismatch for stated M,r | flag: python gives ~5×10⁻⁶; adjust range or adjust parameters |
| `b/R_S ~ 2×10⁵` (fig caption, ~line 424) | value low by 18% | flag: actual ~2.4×10⁵ |

---

## Equation-number cleanup (2026-07-01)

Each citation independently re-verified against the source PDF before editing. Only `01e_Linearized_Gravity.tex` was modified.

| citation (old) | status | new citation | PDF evidence |
|---|---|---|---|
| `Carroll eq.~4.12` (line 205) | **APPLIED** | `Carroll eq.~4.19` | Carroll p. 153: eq. 4.12 = `g_{μν} = η_{μν} + h_{μν}` (metric decomposition). Carroll p. 154: eq. 4.19 = `h_{00} = −2Φ` (c=1; the h₀₀ identification). |
| `C&K eq.~3.68` (line 93) | **APPLIED** | `C&K Sec.~3.3.2` | C&K p. 60: eq. 3.68 = full Schwarzschild interval in standard coords. No C&K equation states the linearised perturbation g=η+h; the weak-field limit is derived in §3.3.2 leading to eq. 3.71. |
| `Carroll eq.~7.8` (line 250) | **APPLIED** | `Carroll eq.~7.59` | Carroll p. 275: eq. 7.8 = linearised Einstein tensor G_{μν}^{(1)}. Carroll p. 287: eq. 7.59 = `ds²=−(1+2Φ)dt²+(1−2Φ)(dx²+dy²+dz²)` (weak-field isotropic metric). |
| `C&K eq.~3.77` (line 347) | **APPLIED** | `C&K Sec.~3.4.1` | C&K p. 62: eq. 3.77 = `c²=(1−R_S/r)c²ṫ²−(1−R_S/r)⁻¹ṙ²−r²φ̇²` (massive-particle geodesic constraint). No C&K equation gives the temporal-piece deflection integral; argument is narrative in §3.4.1. |
| `C&K eq.~3.78` (line 361) | **APPLIED** (removed) | `(Will 1993)` only | C&K p. 62: eq. 3.78 = `ṙ²=ε²/c²−(1−R_S/r)(ℓ²/r²+c²)` (energy conservation for massive particles). C&K never state a PPN split; cite Will 1993 alone for the PPN formula. |
| `Carroll eq.~7.47` (line 520) | **APPLIED** | `Carroll eq.~7.85` | Carroll p. 285: eq. 7.47 = `w^i = w^i_⊥ + w^i_∥` (vector field decomposition). Carroll p. 293: eq. 7.85 = `n = 1 − 2Φ` (effective refractive index). |
| `C&K eq.~6.1` (line 521) | **APPLIED** | `C&K eq.~4.25` | C&K p. 146: eq. 6.1 = `ψ_γ(x,y)=−(γ/2)(x²−y²)` (external-shear lens potential, Ch. 6). C&K p. 92: eq. 4.25 = `τ(θ\|β)=½\|θ−β\|²−ψ(θ)` (Fermat potential). |
| `C&K eq.~4.5` (line 574) | **APPLIED** | `C&K eq.~4.9` | C&K p. 88: eq. 4.5 = approximate point-mass projected potential `ψ̂_{PM}≈−(2GM/c²)[ln(2D_l/R)+ln(2D_{ls}/R)]`. C&K p. 89: eq. 4.9 = `α̂(ξ)=(4G/c²)∫Σ(ξ')(ξ−ξ')/\|ξ−ξ'\|² d²ξ'` (continuous-distribution deflection). |
| `C&K eq.~4.1` (line 622) | **APPLIED** | `C&K eq.~4.26` | C&K p. 87: eq. 4.1 = `α̂(ξ)=(2/c²)∫∇_ξΦ(ξ,z)dz ≡ ∇_ξψ̂(ξ)` (deflection as gradient of scalar potential). C&K p. 92: eq. 4.26 = `β=θ−∇ψ(θ)≡θ−α(θ)` (lens equation). |
| `Carroll eq.~4.11` (line 61) | **STILL-FLAGGED** | — | Carroll p. 153: eq. 4.11 = `Γ^μ_{00}=−½g^{μλ}∂_λg_{00}` (Christoffel symbol). No single Carroll equation states `\|Φ\|/c²=GM/rc²`; the identification follows from context in §4.1 prose. Citation left unchanged pending author decision on whether to cite §4.1 prose or remove. |
