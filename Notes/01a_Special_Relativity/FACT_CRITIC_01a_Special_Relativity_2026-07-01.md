# fact-critic report — 01a_Special_Relativity.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib found), crossref-web ✗ (not invoked — PDFs available locally),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓,
> Mathematica cross-check ✓ (wolframscript -file lorentz_transforms.wl — ran to completion, all assertions True),
> overlay: none.
> Source PDFs checked: Carroll_SG.pdf (print pp. 1–42 verified), Congdon & Keeton 2018 (Ch. 3, pp. 45–59 verified).
> (A claim whose lens has no active adapter is capped at ⚠ SUSPECT — see flagged rows.)

---

## Verdicts

### Numbers / formulas

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | `(Δs)² = -(Δt)² + (Δx)² + (Δy)² + (Δz)²` (eq. spacetime_interval) | ✅ PASS | Python recompute + Mathematica Section 6 "Invariance of the Spacetime Interval" → intervals equal, True | none |
| N2 | Number | Minkowski metric `diag(-1,1,1,1)` (eq. minkowski_metric) | ✅ PASS | Mathematica lorentz_transforms.wl §1 prints `{{-1,0,0,0},...}`; Carroll print p.8 eq. 1.15 | none |
| N3 | Number | Lorentz condition `η = Λ^T η Λ` (eq. lorentz_condition) | ✅ PASS | Mathematica §2 "Verification: … Equals eta? True"; Carroll print p.12 eq. 1.28 | none |
| N4 | Number | Rotation matrix (cos θ, sin θ, −sin θ, cos θ) (eq. rotation) | ✅ PASS | Mathematica §3 "R^T.eta.R = eta? True"; Carroll print p.13 eq. 1.31 | none |
| N5 | Number | Boost matrix with rapidity (cosh φ, −sinh φ, …) (eq. boost_rapidity) | ✅ PASS | Mathematica §2 boost matrix + §2 lorentz check True; Carroll print p.14 eq. 1.32 | none |
| N6 | Number | `cosh²φ − sinh²φ = 1` | ✅ PASS | Python: `cosh(1.234)²−sinh(1.234)² = 1.0000000000` | none |
| N7 | Number | `v = tanh φ` (eq. rapidity_velocity) | ✅ PASS | Mathematica: v = x/t from boost → `Tanh[ϕ]`; Carroll print p.14 eq. 1.34 | none |
| N8 | Number | `γ = 1/√(1−v²) = cosh φ`, `γv = sinh φ` (eq. gamma_def) | ✅ PASS | Python: all v ∈ {0,0.5,0.6,0.8,0.9,0.99} match True; Mathematica lorentz_transforms.wl §5 | none |
| N9 | Number | `t' = γ(t−vx)`, `x' = γ(x−vt)` (eq. boost_velocity) | ✅ PASS | Mathematica §2 boostXvelocity[v] confirmed; Carroll print p.14 eq. 1.35 | none |
| N10 | Number | Time dilation: `Δt = γ Δt'` | ✅ PASS | Mathematica §5: "In frame S: Delta t = dtp/Sqrt[1−v^2]" = γ Δt′ | none |
| N11 | Number | Length contraction: `L = L₀/γ = L₀√(1−v²)` | ✅ PASS | Mathematica §5: "L = L0 / gamma = L0 * Sqrt[1−v^2]" | none |
| N12 | Number | Relativity of simultaneity: `Δt = v Δx` when `Δt' = 0` | ✅ PASS | Python: from t′=γ(t−vx), Δt′=0 ⟹ Δt=v Δx (no γ factor — correct) | none |
| N13 | Number | Four-velocity norm `η_μν U^μ U^ν = −1` | ✅ PASS | Python: −1.0000000000; Mathematica §7 "U^mu U_mu = −1" | none |
| N14 | Number | Energy-momentum `−E² + |p|² = −m²`, restoring c: `E²=(pc)²+(mc²)²` | ✅ PASS | Python: −E²+|p|²=−1.000000; −m²=−1.000000, match True | none |
| N15 | Number | Twin paradox: `Δτ_{AB′C} = √(1−v²) Δt` | ✅ PASS | Python: τ_total=6.0000, √(1−v²)·Δt=6.0000 at v=0.8; Carroll print p.10 eq. 1.19 | none |
| N16 | Number | Velocity addition `v = (v₁+v₂)/(1+v₁v₂)` | ✅ PASS | Mathematica §4: `Lambda(φ1).Lambda(φ2)=Lambda(φ1+φ2) True`; tanh(φ1+φ2)=(v1+v2)/(1+v1·v2) confirmed | none |
| N17 | Number | `ε̃_{0123} = +1` (Levi-Civita) | ✅ PASS | Carroll print p.24 eq. 1.68: "+1 if μνρσ even permutation of 0123" | none |
| N18 | Number | EM tensor F_μν matrix with E₁,E₂,E₃,B₁,B₂,B₃ | ✅ PASS | Carroll print p.24 eq. 1.69: matrix matches chapter entry-for-entry | none |
| N19 | Number | Contraction reduces rank: `S^{μρ}_{σ} = T^{μνρ}_{σν}` | ✅ PASS | Carroll print p.25 eq. 1.70 | none |
| N20 | Number | Raising/lowering `T^{αβμ}_{δ} = η^{μγ} T^{αβ}_{γδ}` | ✅ PASS | Carroll print p.25 eq. 1.72 | none |
| N21 | Number | Tensor transform (full Λ chain) (eq. tensor_transform) | ✅ PASS | Carroll print p.22 eq. 1.63 — matches chapter expression | none |
| N22 | Number | Symmetrization/antisymmetrization (1/n! sum/alt-sum) | ✅ PASS | Carroll print p.27 eqs. 1.79–1.80 | none |
| N23 | Number | Perfect fluid T^μν = (ρ+p)U^μU^ν + p η^μν | ✅ PASS | Carroll print p.35 eq. 1.114 (not cited in chapter, content verified) | none |
| N24 | Number | Conservation ∂_μ T^μν = 0 | ✅ PASS | Carroll print p.35 eq. 1.115 | none |

### Citations

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "cf. Carroll eq. 1.1" for Newton's gravity `F = −GMm/r² r̂` | ✅ PASS | Carroll print p.1 eq. 1.1 = F = GMm/r² **e**(r); sign/convention difference absorbed by "cf." — no identity claimed; physics is equivalent | none |
| C2 | Citation | "Carroll eq. 1.5" for Einstein field equation | ✅ PASS | Carroll print p.2 eq. 1.5: R_μν − ½R g_μν = 8πG T_μν | none |
| C3 | Citation | "Carroll Fig. 1.5" for light cone figure | ✅ PASS | Carroll print p.9 Fig. 1.5 = light cone diagram with timelike/null/spacelike regions | none |
| C4 | Citation | "Carroll eq. 1.10" for spacetime interval | ✅ PASS | Carroll print p.7 eq. 1.10: (Δs)²=−(cΔt)²+(Δx)²+(Δy)²+(Δz)² (c=1 in chapter) | none |
| C5 | Citation | "Carroll eq. 1.12" for x^μ coordinates | ✅ PASS | Carroll print p.8 eq. 1.12: x^0=ct, x^1=x, x^2=y, x^3=z; consistent with chapter's c=1 | none |
| C6 | Citation | "Carroll eq. 1.15" for Minkowski metric | ✅ PASS | Carroll print p.8 eq. 1.15: diag(−1,1,1,1) | none |
| C7 | Citation | "Carroll eq. 1.17" for proper time definition | ✅ PASS | Carroll print p.9 eq. 1.17: (Δτ)²=−(Δs)²=−η_μν Δx^μ Δx^ν | none |
| C8 | Citation | "Carroll eq. 1.20" for line element `ds² = η_μν dx^μ dx^ν` | ✅ PASS | Carroll print p.11 eq. 1.20 | none |
| C9 | Citation | "Carroll Sec. 1.3, pp. 11–14" for hyperbolic boost discussion | ⚠ SUSPECT | Carroll print p.12 starts Sec. 1.3; print p.11 is still Sec. 1.2 (line element). Page range should be pp. 12–14 | Correct to "Carroll Sec. 1.3, pp.~12--14" |
| C10 | Citation | "Carroll eq. 1.25" for `x^{μ'} = Λ^{μ'}{}_ν x^ν` | ✅ PASS | Carroll print p.12 eq. 1.25 | none |
| C11 | Citation | "Carroll eq. 1.28" for `η = Λ^T η Λ` | ✅ PASS | Carroll print p.12 eq. 1.28 | none |
| C12 | Citation | "Carroll eq. 1.31" for rotation matrix | ✅ PASS | Carroll print p.13 eq. 1.31 | none |
| C13 | Citation | "Carroll eq. 1.32" for boost matrix (rapidity) | ✅ PASS | Carroll print p.14 eq. 1.32 | none |
| C14 | Citation | "Carroll eqs. 1.33–1.35" for rapidity→velocity | ✅ PASS | Carroll print p.14 eq. 1.33 (boost in t,x), 1.34 (v=tanh φ), 1.35 (t′=γ(t−vx)) | none |
| C15 | Citation | "Carroll Fig. 1.7" for Lorentz boost axes figure | ✅ PASS | Carroll print p.15 Fig. 1.7 = boosted t′, x′ axes tilting toward light cone | none |
| C16 | Citation | "Carroll Sec. 1.4" for classic relativistic effects (time dilation, length contraction, relativity of simultaneity) | ❌ FAIL | Carroll Sec. 1.4 (print pp. 15–17) = "Vectors" — defines tangent spaces, basis vectors, V^μ = dx^μ/dλ, vector transformation; contains no discussion of time dilation or length contraction. These consequences of the boost follow at the end of Carroll **Sec. 1.3** (print p. 14, after eq. 1.35) | Replace "Carroll Sec.~1.4" with "Carroll Sec.~1.3" in this parenthetical |
| C17 | Citation | "Carroll eqs. 1.18–1.19" for twin paradox | ✅ PASS | Carroll print p.10 eqs. 1.18–1.19: Δτ_{AB′}=½√(1−v²)Δt, Δτ_{AB′C}=√(1−v²)Δt | none |
| C18 | Citation | "Carroll eq. 1.39" for `V^{μ'} = Λ^{μ'}{}_ν V^ν` | ✅ PASS | Carroll print p.17 eq. 1.39 | none |
| C19 | Citation | "Carroll eq. 1.58" for `dτ = dt/γ` (four-velocity context) | ❌ FAIL | Carroll eq. 1.58 (print p.21, Sec. 1.6 Tensors) = tensor product definition T⊗S; completely unrelated to proper time. The dτ = dt/γ relation follows from Carroll eq. 1.17 (proper time); the four-velocity definition is Carroll eq. **1.99** (print p.31, Sec. 1.9) | Replace "Carroll eq.~1.58" with "Carroll eq.~1.17" (or "Carroll eq.~1.99") |
| C20 | Citation | "Carroll eq. 1.59" for `η_μν U^μ U^ν = −1` | ❌ FAIL | Carroll eq. 1.59 (print p.21, Sec. 1.6) = basis tensor products ê_{(μ1)}⊗…; unrelated. Correct equation is Carroll eq. **1.100** (print p.31): η_μν U^μ U^ν = −1 | Replace "Carroll eq.~1.59" with "Carroll eq.~1.100" |
| C21 | Citation | "Carroll eq. 1.60" for `p^μ = m U^μ` (four-momentum) | ❌ FAIL | Carroll eq. 1.60 (print p.21, Sec. 1.6) = tensor component expression T = T^{μ…}_{ν…} ê⊗θ̂; unrelated. Correct equation is Carroll eq. **1.101** (print p.31): p^μ = mU^μ | Replace "Carroll eq.~1.60" with "Carroll eq.~1.101" |
| C22 | Citation | "Carroll eq. 1.50" for dual vector transform `ω_{μ'} = Λ^ν{}_{μ'} ω_ν` | ✅ PASS | Carroll print p.20 eq. 1.50 | none |
| C23 | Citation | "Carroll eq. 1.54" for gradient `∂_μ φ` | ✅ PASS | Carroll print p.20 eq. 1.54 | none |
| C24 | Citation | "Carroll eq. 1.56" for tensor type `T: T*^k × T^l → R` | ✅ PASS | Carroll print p.21 eq. 1.56 | none |
| C25 | Citation | "Carroll eq. 1.63" for tensor transformation law (full Λ chain) | ✅ PASS | Carroll print p.22 eq. 1.63 — matches chapter's expression exactly | none |
| C26 | Citation | "Carroll eq. 1.68" for Levi-Civita symbol | ✅ PASS | Carroll print p.24 eq. 1.68: ε̃_{μνρσ} = +1/−1/0 for even/odd/non-permutations of 0123 | none |
| C27 | Citation | "Carroll eq. 1.69" for F_μν (two occurrences, header and exercise) | ✅ PASS | Carroll print p.24 eq. 1.69: F_μν matrix with E₁,E₂,E₃,B₁,B₂,B₃ — matches chapter exactly | none |
| C28 | Citation | "Carroll eq. 1.70" for contraction | ✅ PASS | Carroll print p.25 eq. 1.70 | none |
| C29 | Citation | "Carroll eq. 1.72" for index raising/lowering | ✅ PASS | Carroll print p.25 eq. 1.72 | none |
| C30 | Citation | "Carroll eqs. 1.79–1.80" for symmetrization/antisymmetrization | ✅ PASS | Carroll print p.27 eqs. 1.79–1.80 | none |
| C31 | Citation | "Congdon & Keeton Sec. 3.2.3" for classic relativistic effects | ❌ FAIL | C&K Sec. 3.2.3 (print p.55) = "**Principle of Stationary Interval**" — covers the twin paradox as motivation for geodesics and introduces the Equivalence Principle; does NOT derive time dilation and length contraction from the Lorentz boost matrix. Boost consequences (time dilation, length contraction) are in C&K **Sec. 3.1.2** "Lorentz Transformations" (print p.46, eqs. 3.3–3.5) | Replace "Congdon \& Keeton Sec.~3.2.3" with "Congdon \& Keeton Sec.~3.1.2" |
| C32 | Citation | "Congdon & Keeton eqs. 3.18–3.23" for four-momentum components | ✅ PASS | C&K print pp. 49–50: eq. 3.18 = P=(γmc, γmu), 3.19 = Taylor expansion, 3.20 = P=(E/c, p), 3.21 = |P|=mc, 3.22 = c²|P|²=E²−c²p², 3.23 = E=γmc² | none |

### Consistency

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| X1 | Consistency | Carroll eq. 1.69 cited in body (§ Tensors, Levi-Civita subsection) and again in exercise ex:em_tensor | ✅ PASS | internal: 2 occurrences agree | none |
| X2 | Consistency | Figure caption "v = 0.6c" vs. text's general discussion at arbitrary v | ✅ PASS | Caption only mentions v=0.6c as an example value for the figure; text is general. No contradiction | none |

---

## Applied (auto-fixes)

**None.** All errors identified are citation/equation-number mis-attributions. Per the action policy, citations are never auto-edited. All physics formulas and numeric values passed verification — no numerical corrections needed.

---

## Flagged — your hand required

### C9 ⚠ SUSPECT — Carroll page range off by one
**Location:** `\section{Boosts}`, text: "(Carroll Sec.~1.3, pp.~11--14)"  
**Issue:** Carroll Sec. 1.3 "Lorentz Transformations" begins on **print p. 12**, not p. 11. Print p. 11 is the last page of Sec. 1.2 (line element, eqs. 1.20–1.22).  
**Proposed fix:** Change `pp.~11--14` → `pp.~12--14`.

---

### C16 ❌ FAIL — Wrong Carroll section for physical consequences of boosts
**Location:** `\subsection{Physical Consequences}`, text: "(Carroll Sec.~1.4; Congdon \& Keeton Sec.~3.2.3)"  
**Issue:** Carroll Sec. 1.4 (print pp. 15–17) is **"Vectors"** — introduces tangent spaces, basis vectors, and the vector transformation law V^{μ′}=Λ^{μ′}_{ν}V^ν. It contains no discussion of time dilation, length contraction, or relativity of simultaneity.  
These consequences are stated by Carroll at the end of **Sec. 1.3** (print p. 14), immediately after eq. 1.35: *"Applying these formulae leads to time dilation, length contraction, and so forth."*  
**Proposed fix:** Replace `Carroll Sec.~1.4` with `Carroll Sec.~1.3`.

---

### C19 ❌ FAIL — Carroll eq. 1.58 ≠ proper-time / dτ relation
**Location:** `\paragraph{Four-velocity:}`, text: "use $d\tau = dt/\gamma$ (from time dilation, eq.~\eqref{eq:proper_time}; see also Carroll eq.~1.58)"  
**Issue:** Carroll eq. 1.58 (print p. 21, Sec. 1.6 Tensors) = **tensor product** T ⊗ S. The dτ = dt/γ relation follows from Carroll eq. 1.17 (proper time definition) for a clock moving at velocity v; the four-velocity itself is defined in Carroll eq. **1.99** (print p. 31, Sec. 1.9).  
**Proposed fix:** Replace `Carroll eq.~1.58` with `Carroll eq.~1.17` (for the dτ = dt/γ relation) or omit the Carroll cross-reference here since eq:proper_time already provides the local pointer.

---

### C20 ❌ FAIL — Carroll eq. 1.59 ≠ four-velocity norm
**Location:** `\paragraph{Four-velocity:}`, text: "$\eta_{\mu\nu} U^\mu U^\nu = -1$ (in units with $c = 1$; Carroll eq.~1.59)"  
**Issue:** Carroll eq. 1.59 (print p. 21, Sec. 1.6) = **basis tensor products** ê_{(μ₁)}⊗…⊗ê_{(μk)}⊗θ̂^{(ν₁)}⊗…; completely unrelated. The four-velocity normalization is Carroll eq. **1.100** (print p. 31, Sec. 1.9): η_μν U^μ U^ν = −1.  
**Proposed fix:** Replace `Carroll eq.~1.59` with `Carroll eq.~1.100`.

---

### C21 ❌ FAIL — Carroll eq. 1.60 ≠ four-momentum definition
**Location:** `\paragraph{Four-momentum:}`, text: "$p^\mu = m\, U^\mu$, where $m$ is the rest mass (Carroll eq.~1.60)"  
**Issue:** Carroll eq. 1.60 (print p. 21, Sec. 1.6) = **tensor component expression** T = T^{μ₁…μk}_{ν₁…νl} ê_{(μ₁)}⊗…⊗θ̂^{(νl)}; unrelated. The four-momentum definition is Carroll eq. **1.101** (print p. 31, Sec. 1.9): p^μ = mU^μ.  
**Proposed fix:** Replace `Carroll eq.~1.60` with `Carroll eq.~1.101`.

---

### C31 ❌ FAIL — Congdon & Keeton Sec. 3.2.3 misidentified for boost consequences
**Location:** `\subsection{Physical Consequences}`, text: "(Carroll Sec.~1.4; Congdon \& Keeton Sec.~3.2.3)"  
**Issue:** C&K Sec. 3.2.3 (print p. 55) = **"Principle of Stationary Interval"** — this section motivates the geodesic equation via the twin paradox and equivalence principle. The classical relativistic effects derived from the Lorentz boost matrix (time dilation Δt = γΔt′, length contraction L = L₀/γ, relativity of simultaneity) are in C&K **Sec. 3.1.2** "Lorentz Transformations" (print p. 46), where eqs. 3.3–3.5 give the boost transformation and γ is defined.  
(Note: C&K Sec. 3.2.3 does contain the twin paradox Δτ = Δt√(1−u²), eq. 3.50 — but this appears as motivation for geodesics, not as a derivation of boost consequences.)  
**Proposed fix:** Replace `Congdon \& Keeton Sec.~3.2.3` with `Congdon \& Keeton Sec.~3.1.2`.

---

## Mathematica cross-check summary

`wolframscript -file lorentz_transforms.wl` ran to completion (exit: normal; license line at exit: benign).

Sections verified and all returned the expected symbolic results:
1. **§1 Minkowski metric** — inverse equals forward; η·η⁻¹ = identity: `True`
2. **§2 Boost (rapidity)** — Λ^T·η·Λ = η: `True`; velocity form also: `True`
3. **§3 Rotation (x-y)** — R^T·η·R = η: `True`
4. **§4 Boost composition** — Λ(φ₁)·Λ(φ₂) = Λ(φ₁+φ₂): `True`; velocity addition = (v₁+v₂)/(1+v₁v₂): confirmed
5. **§5 Time dilation** — inverse boost on (Δt′,0,0,0) → Δt = Δt′/√(1−v²): confirmed
6. **§6 Interval invariance** — ds² in S = ds² in S′: `True`
7. **§7 Four-velocity norm** — U^μ U_μ = **−1**: confirmed symbolically for arbitrary (vx,vy,vz) with vx²+vy²+vz² < 1

All chapter formulas involving these quantities agree with the notebook output.

---

## Equation-number cleanup (2026-07-01)

All six flagged citations were independently re-verified against the Carroll and C&K source PDFs before editing. Only `01a_Special_Relativity.tex` was modified.

### APPLIED

| id | old | new | PDF evidence |
|----|-----|-----|--------------|
| C9 | `pp.~11--14` | `pp.~12--14` | Carroll PDF page 25 = print p. 12: "**1.3 LORENTZ TRANSFORMATIONS**" heading. Print p. 11 (PDF p. 24) = end of Sec. 1.2, eqs. 1.20–1.22 (line element). |
| C16 | `Carroll Sec.~1.4` | `Carroll Sec.~1.3` | Carroll PDF page 28 = print p. 15: "**1.4 VECTORS**" heading (tangent spaces, basis vectors). Carroll PDF page 27 = print p. 14: after eq. 1.35 reads "Applying these formulae leads to time dilation, length contraction, and so forth" — confirmed still in Sec. 1.3. |
| C31 | `Congdon \& Keeton Sec.~3.2.3` | `Congdon \& Keeton Sec.~3.1.2` | C&K TOC (PDF pp. 9–10): Sec. 3.1.2 = "Lorentz Transformations" (p. 46); Sec. 3.2.3 = "Principle of Stationary Interval" (p. 55). C&K PDF p. 57 = print p. 46: "**3.1.2 Lorentz Transformations**" with eqs. 3.3–3.5 (Lorentz boost, γ). C&K PDF p. 67 = print p. 55: "**3.2.3 Principle of Stationary Interval**" with Twin Paradox (eq. 3.50) and Equivalence Principle — no boost-consequence derivations. |
| C19 | `Carroll eq.~1.58` | `Carroll eq.~1.17` | Carroll PDF p. 34 = print p. 21: eq. 1.58 = tensor product T⊗S (completely unrelated to proper time). Carroll PDF p. 22 = print p. 9: eq. 1.17 = (Δτ)² = −(Δs)² = −η_μν Δx^μ Δx^ν (proper time definition). |
| C20 | `Carroll eq.~1.59` | `Carroll eq.~1.100` | Carroll PDF p. 34 = print p. 21: eq. 1.59 = basis tensors ê_{(μ₁)} ⊗ ··· ⊗ θ̂^{(ν₁)} ⊗ ···. Carroll PDF p. 44 = print p. 31: eq. 1.100 = η_μν U^μ U^ν = −1. |
| C21 | `Carroll eq.~1.60` | `Carroll eq.~1.101` | Carroll PDF p. 34 = print p. 21: eq. 1.60 = T = T^{μ₁…}_{ν₁…} ê ⊗ ··· ⊗ θ̂ ···. Carroll PDF p. 44 = print p. 31: eq. 1.101 = p^μ = mU^μ (boxed). |

### STILL-FLAGGED

None. All six flagged items were confirmed and corrected.
