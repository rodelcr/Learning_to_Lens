# fact-critic report — Notes/01c_Schwarzschild/01c_Schwarzschild.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib found in tree), crossref-web ✓ (network reachable),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓,
> overlay: Mathematica notebooks (schwarzschild_metric.wl via wolframscript; gravitational_redshift.nb — plot-only, not run).
> Additional verification: Python 3 recompute; Carroll_SG.pdf (Reference_Texts); Congdon & Keeton 2018 (Reference_Texts).
> (Claims whose lens has no active adapter are capped at ⚠ SUSPECT — see flagged rows.)

---

## Verdicts

### Numbers

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | `R_S = 2GM/c²` (§ "Identify R_S") | ✅ PASS | wolframscript: Rs is the free parameter in the symbolic Schwarzschild metric; weak-field limit derivation is algebraically identical in .wl; python recompute consistent | none |
| N2 | Number | `K = 12R_S²/r⁶ = 48G²M²/(c⁴r⁶)` (§ "Event Horizon") | ✅ PASS | wolframscript schwarzschild_metric.wl Section 5 output: `K = (12*Rs^2)/r^6  Match? True`; python: 12Rs² = 12·(2GM/c²)² = 48G²M²/c⁴ — algebraically consistent | none |
| N3 | Number | `dτ = √(1 − R_S/r) dt` (§ "Gravitational Time Dilation") | ✅ PASS | C&K eq. 3.65 (C&K PDF p.60 confirmed): `ds² = c²dτ² = f(r)c²dt²` with f(r) = 1 − 2GM/(c²r) = 1 − Rs/r; python: algebraically consistent | none |
| N4 | Number | `z_grav ≈ GM/(rc²)` weak-field limit (§ "Gravitational Redshift") | ✅ PASS | C&K eq. 3.63 (C&K PDF p.59 confirmed): `t_∞ ≈ (1 + GM/(c²r)) t_r` → z = t_∞/t_r − 1 ≈ GM/(c²r); python: Taylor expansion of (1−Rs/r)^{−1/2} − 1 to first order gives Rs/(2r) = GM/(c²r) | none |
| N5 | Number | WEP `\|m_i − m_g\|/m_g < 10^{−13}` citing "MICROSCOPE satellite mission" (§ "Weak Equivalence Principle") | ❌ FAIL | CrossRef DOI 10.1088/1361-6382/ab4707 (Touboul et al. 2019): MICROSCOPE first results `~10^{−14}`; MICROSCOPE final result 2022 `~10^{−15}`. The 10^{−13} figure corresponds to pre-MICROSCOPE torsion balance results (Eöt-Wash ~10^{−13}). Citing MICROSCOPE while quoting 10^{−13} understates by ≥ 1 order of magnitude. | Change `10^{−13}` → `10^{−15}` if MICROSCOPE is the intended benchmark, or `10^{−13}` → `10^{−14}` citing MICROSCOPE 2017 first result. Flag-only (multiple named experiments cited together — target ambiguous; not auto-fixable). |
| N6 | Number | NS `r/R_S ≈ 2.4` (figure caption Fig. 2) | ✅ PASS | wolframscript .wl Sect. 7: Rs_NS = 4.135 km; python: 10 km / 4.135 km = 2.418 ≈ 2.4 | none |
| N7 | Number | NS `z ≈ 0.3` (figure caption Fig. 2) | ✅ PASS | wolframscript .wl Sect. 7: `z_grav = 0.306`; python: z = 0.3058 ≈ 0.3 | none |
| N8 | Number | Sun `z ∼ 10^{−6}` (figure caption Fig. 2) | ⚠ SUSPECT | wolframscript .wl Sect. 7: `z_Sun = 2.122×10^{−6}`; python: 2.122×10^{−6}. The value is ~2×10^{−6}, not 1×10^{−6}. "~10^{−6}" is an order-of-magnitude statement and technically correct within a factor of π, but understates by ×2.1. No adapter can determine author intent for precision. | Consider `z ∼ 2\times 10^{-6}` for accuracy. Flag-only. |
| N9 | Number | Earth `M = 6×10²⁴ kg`, `R_S = 8.9 mm` (§ Table) | ✅ PASS | python with M = 6×10²⁴ kg, G = 6.674×10^{−11}, c = 2.998×10⁸ (matching .wl constants): Rs = 8.91 mm → rounds to 8.9 mm | none |
| N10 | Number | Sun `M = 2×10³⁰ kg`, `R_S = 3.0 km` (§ Table) | ✅ PASS | python: Rs(2×10³⁰) = 2.97 km → rounds to 3.0 km | none |
| N11 | Number | NS `1.4 M_sun`, `R_S = 4.1 km` (§ Table) | ✅ PASS | wolframscript: 4.135 km → rounds to 4.1 km | none |
| N12 | Number | SgrA* `4×10⁶ M_sun`, `R_S = 1.2×10⁷ km` (§ Table) | ✅ PASS | wolframscript: 1.1815×10⁷ km → rounds to 1.2×10⁷ km | none |
| N13 | Number | Galaxy `10¹² M_sun`, `R_S = 3×10¹² km` (§ Table) | ✅ PASS | python: 2.954×10¹² km → rounds to 3×10¹² km | none |
| N14 | Number | Galaxy `R_S ∼ 0.1 pc` (§ "Schwarzschild Radii for Astrophysical Objects") | ✅ PASS | wolframscript: 0.0957 pc; python (using pc = 3.086×10¹⁶ m): 0.096 pc ≈ 0.1 pc | none |
| N15 | Number | Flamm's paraboloid `z(r) = 2√R_S √(r − R_S)` (§ "Flamm's Paraboloid") | ✅ PASS | python: embedding condition z′² = R_S/(r−R_S) → integrate → z = 2√R_S·√(r−R_S). Algebraically exact. | none |

---

### Citations

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "most general line element … (Carroll eq. 5.5)" for `ds² = −e^{2α}dt² + e^{2β}dr² + r²dΩ²` (§ "Most General Spherically Symmetric Metric") | ❌ FAIL | Carroll p.194 (PDF pp. 206): eq. 5.5 is `ds² = −e^{2α(r)}dt² + e^{2β(r)}dr² + e^{2γ(r)}r²dΩ²` — a **3-function** metric. The 2-function form written in the tex (γ absorbed into radial coordinate) is Carroll eq. **5.11** (p.195, PDF p.207). Carroll explicitly states "5.11 is precisely as general as 5.5" but they are different equations. | Change citation to `Carroll eq.~5.11` (or add `5.11` alongside). Flag-only. |
| C2 | Citation | "Carroll eq. 5.12" for Christoffel symbols (§ "Deriving the Schwarzschild Metric", Step 1) | ✅ PASS | Carroll p.195 (PDF p.207): eq. 5.12 is the nonvanishing Christoffel symbols for the 2-function Schwarzschild ansatz. All components match the tex. | none |
| C3 | Citation | "Carroll eq. 5.14" for Ricci tensor components | ✅ PASS | Carroll p.195 (PDF p.207): eq. 5.14 gives R_{tt}, R_{rr}, R_{θθ}, R_{φφ}. Forms match the tex identically. | none |
| C4 | Citation | "Carroll eq. 5.17" for `α = −β + const` | ✅ PASS | Carroll p.196 (PDF p.208): eq. 5.17 is `α = −β`. | none |
| C5 | Citation | "Carroll eq. 5.18" for `e^{2α}(1 + 2rα′) = 1` | ✅ PASS | Carroll p.196 (PDF p.208): eq. 5.18 is `e^{2α}(2r∂_r α + 1) = 1`. Matches tex. | none |
| C6 | Citation | "Carroll eq. 5.23" for `R_S = 2GM/c²` | ✅ PASS | Carroll p.196 (PDF p.208): eq. 5.23 is `R_S = 2GM` in geometrized (c=1) units. Tex correctly restores c² for SI. | none |
| C7 | Citation | "Carroll Sec. 5.2" for Birkhoff's theorem | ✅ PASS | Carroll p.197 (PDF p.209): Section 5.2 heading is "Birkhoff's Theorem". | none |
| C8 | Citation | "Carroll Sec. 5.3" for singularities / event horizon | ✅ PASS | Carroll p.204 (PDF p.216): Section 5.3 heading is "Singularities". | none |
| C9 | Citation | "Congdon & Keeton eq. 3.64" for general spherical metric | ✅ PASS | C&K PDF p.60: eq. 3.64 is `ds² = f(r)c²dt² − g(r)dr² − r²(dθ² + sin²θ dφ²)`. Matches the tex's form (with opposite signature convention). | none |
| C10 | Citation | "Congdon & Keeton eq. 3.65" for gravitational time dilation `dτ = √(1 − R_S/r) dt` | ✅ PASS | C&K PDF p.60: eq. 3.65 is `ds² = c²dτ² = f(r)c²dt²` → dτ/dt = √f(r) = √(1 − R_S/r). | none |
| C11 | Citation | "Congdon & Keeton eq. 3.63" for weak-field `z_grav ≈ GM/(rc²)` | ✅ PASS | C&K PDF p.59: eq. 3.63 is `t_∞ ≈ (1 + GM/(c²r)) t_r` → z = t_∞/t_r − 1 ≈ GM/(c²r). Consistent. | none |
| C12 | Citation | "Congdon & Keeton eq. 3.71" for weak-field metric | ✅ PASS | C&K PDF p.61: eq. 3.71 is `ds² ≈ (1 + 2Φ/c²)c²dt² − (1 − 2Φ/c²)[dρ² + ρ²dΩ²]`. Matches tex with opposite signature convention. | none |
| C13 | Citation | "Carroll eq. 5.58" for the tortoise coordinate `r_*` (§ "Eddington–Finkelstein Coordinates") | ❌ FAIL | Carroll p.207 (PDF p.219): eq. 5.58 is `R^μ = (∂_φ)^μ = (0,0,0,1)` — the angular momentum Killing vector. The tortoise coordinate `r* = r + 2GM ln(r/(2GM) − 1)` is Carroll eq. **5.108** (p.220, PDF p.232). Formula in the tex is correct; only the equation number is wrong. | Change `Carroll eq.~5.58` → `Carroll eq.~5.108`. Flag-only. |
| C14 | Citation | "Carroll eq. 5.60" for the ingoing Eddington–Finkelstein metric (§ "Eddington–Finkelstein Coordinates") | ❌ FAIL | Carroll p.207 (PDF p.219): eq. 5.60 is `R_μ = (0, 0, 0, r²sin²θ)` — the covariant angular momentum Killing covector. The ingoing EF metric `ds² = −(1−2GM/r)dv² + (dv dr + dr dv) + r²dΩ²` is Carroll eq. **5.111** (p.221, PDF p.233). Formula in the tex is correct (restores c); only the equation number is wrong. | Change `Carroll eq.~5.60` → `Carroll eq.~5.111`. Flag-only. |
| C15 | Citation | "Pound–Rebka experiment, 1959" (§ "Gravitational Redshift" remark) | ✅ PASS | CrossRef DOI 10.1103/physrevlett.3.439: R. V. Pound & G. A. Rebka, "Gravitational Red-Shift in Nuclear Resonance," Phys. Rev. Lett. **3**, 439 (1959). Year correct. | none |

---

### Consistency

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| X1 | Consistency | Earth mass: table uses `6 × 10^{24}` kg; exercise \ref{ex:schwarzschild_radii} uses `5.97 × 10^{24}` kg | ⚠ SUSPECT | internal: 2 occurrences differ. Both give R_S ≈ 8.9 mm (python: 8.91 vs 8.87 mm), so the table value is consistent to printed precision. Likely intentional (round vs. precise). | Use consistent mass across table and exercise, or note in text that the table rounds. Flag-only. |
| X2 | Consistency | Eddington–Finkelstein section defines `v = t + r_*` where `r_* = r + R_S ln\|r/R_S − 1\|` (length units in SI), but the EF metric uses `v` as a time coordinate (`c²dv²` term) | ⚠ SUSPECT | doc-internal: in SI units, `r_*` has dimension of length and `t` has dimension of time, so `v = t + r_*` is dimensionally inconsistent. In c = 1 units (as used throughout schwarzschild_metric.wl), both have the same dimension. The companion .wl file does not cover EF coordinates, so the notebook cannot arbitrate. The EF metric form `ds² = −(1−R_S/r)c²dv² + 2c\,dv\,dr + r²dΩ²` is itself correct when v is in time units (verified by substituting `v = t + r_*/c`). | Either declare c = 1 for this subsection, or rewrite the tortoise coordinate definition as `r_* = r/c + (R_S/c)\ln\|r/R_S − 1\|` (time units) so that `v = t + r_*` is dimensionally consistent. Flag-only. |

---

## Applied (auto-fixes)

None. All ❌ FAIL items are citations (policy: citations never auto-edited) or experimental numbers with ambiguous multi-source targets (policy: ambiguous target → flag-only). No Number claim differs from both the Mathematica notebook and python recompute by a traceable single value for an unambiguously identified object.

---

## Flagged — your hand required

### ❌ C1 — Wrong Carroll equation number for the general spherical metric

**Location:** `\section{The Most General Spherically Symmetric Metric}` — `(Carroll eq.~5.5; cf.\ Congdon \& Keeton eq.~3.64)`

**Evidence:** Carroll "Spacetime and Geometry" p.194, eq. 5.5 (Reference_Texts/Carroll_SG.pdf p.206):
```
ds² = −e^{2α(r)} dt² + e^{2β(r)} dr² + e^{2γ(r)} r² dΩ²
```
Three free functions. The tex writes the two-function form `ds² = −e^{2α}dt² + e^{2β}dr² + r²dΩ²`, which appears in Carroll as eq. **5.11** (p.195) after absorbing γ into the radial coordinate. Carroll notes on p.195: "5.11 is precisely as general as 5.5." The forms are physically equivalent but are numerically different equations.

**Proposed fix:** Change `Carroll eq.~5.5` → `Carroll eq.~5.11`. (Or retain 5.5 and add a footnote explaining the γ absorption step, as Carroll does.)

---

### ❌ C13 — Wrong Carroll equation number for the tortoise coordinate

**Location:** `\section{Inside the Event Horizon}`, Eddington–Finkelstein subsection — `where $r_*$ is the \textbf{tortoise coordinate} (Carroll eq.~5.58)`

**Evidence:**
- Carroll eq. 5.58 (p.207, PDF p.219): `R^μ = (∂_φ)^μ = (0, 0, 0, 1)` — angular momentum Killing vector. Completely unrelated.
- Carroll eq. **5.108** (p.220, PDF p.232): `r* = r + 2GM ln(r/(2GM) − 1)` — the tortoise coordinate. This is the correct equation. The formula in the tex is equivalent (with R_S = 2GM/c² and c explicit).

**Proposed fix:** Change `Carroll eq.~5.58` → `Carroll eq.~5.108`.

---

### ❌ C14 — Wrong Carroll equation number for the Eddington–Finkelstein metric

**Location:** `\section{Inside the Event Horizon}`, Eddington–Finkelstein subsection — `the Schwarzschild line element becomes (Carroll eq.~5.60)`

**Evidence:**
- Carroll eq. 5.60 (p.207, PDF p.219): `R_μ = (0, 0, 0, r²sin²θ)` — covariant angular momentum Killing covector. Completely unrelated.
- Carroll eq. **5.111** (p.221, PDF p.233): `ds² = −(1−2GM/r)dv² + (dv dr + dr dv) + r²dΩ²` — the ingoing EF metric (c=1 form). The tex's form `ds² = −(1−R_S/r)c²dv² + 2c\,dv\,dr + r²dΩ²` is the correct SI restoration of this.

**Proposed fix:** Change `Carroll eq.~5.60` → `Carroll eq.~5.111`.

---

### ❌ N5 — WEP precision understates MICROSCOPE by ≥ 1 order of magnitude

**Location:** `\subsection{The Weak Equivalence Principle}` — `have verified eq.~\eqref{eq:wep} to better than one part in $10^{13}$`

**Evidence:**
- CrossRef DOI 10.1088/1361-6382/ab4707 (Touboul et al. 2019, CQG): MICROSCOPE first results constrain WEP violation to `~10^{−14}`.
- MICROSCOPE final result (Phys. Rev. Lett. 2022): `η = (−1.5 ± 2.3) × 10^{−15}`, i.e., ~10^{-15}.
- The figure `10^{−13}` corresponds to pre-MICROSCOPE torsion balance experiments (Eöt-Wash group, ~2008).
- The tex explicitly names "the MICROSCOPE satellite mission" in the same sentence as the bound. Claiming MICROSCOPE verified it to 10^{−13} is incorrect by 1–2 orders of magnitude.

**Proposed fix (two options):**
1. Update bound to `10^{-15}` (MICROSCOPE final) and cite Touboul et al. 2022.
2. Split the sentence: state Eötvös/Dicke/Braginsky achieved `~10^{−12}`, Eöt-Wash `~10^{−13}`, and MICROSCOPE `~10^{−15}`.

Flag-only — multiple experiments named; not auto-fixable.

---

### ⚠ N8 — Solar gravitational redshift stated as z ~ 10^{-6} (actual: 2.1×10^{-6})

**Location:** figure caption for `gravitational_redshift.pdf` — "For the Sun, $z \sim 10^{-6}$."

**Evidence:** wolframscript schwarzschild_metric.wl Sect. 7: `z_Sun = 2.122×10^{-6}`; python: 2.122×10^{-6} (using R_Sun = 6.96×10⁸ m, M_Sun = 1.989×10³⁰ kg). The value is ~2×10^{-6}, not ~1×10^{-6}. The tilde notation has some latitude but the factor-of-2 gap is noteworthy since this is a pedagogical figure caption.

**Proposed fix:** Change `z \sim 10^{-6}` → `z \sim 2 \times 10^{-6}`.

---

### ⚠ X1 — Earth mass inconsistency between table and exercise

**Location:** Table (§ "Schwarzschild Radius for Astrophysical Objects") uses `M = 6 × 10^{24}` kg; Exercise \ref{ex:schwarzschild_radii} specifies `M = 5.97 × 10^{24}` kg.

**Evidence:** internal, 2 occurrences. Python: Rs(6e24) = 8.91 mm; Rs(5.97e24) = 8.87 mm. Both round to 8.9 mm at 1 decimal place, so the table answer is unaffected. Likely intentional (rough table vs. precise exercise). Recommend standardizing the table mass to `5.97 × 10^{24}` kg (IAU/NIST) or adding a note that the table rounds to 1 sig fig.

---

### ⚠ X2 — Dimensional inconsistency in tortoise / EF coordinate definition

**Location:** `\subsection{Eddington--Finkelstein Coordinates}` — definition `v = t + r_*` with `r_* = r + R_S \ln|r/R_S - 1|`

**Evidence:** doc-internal. In SI units used throughout this chapter, `r_*` has dimension of **length** and `t` has dimension of **time**. The sum `v = t + r_*` is then dimensionally ill-formed. The physically correct SI convention is `v = t + r_*/c`, giving `v` in time units, consistent with the EF metric as written (`c²dv²` term). In c = 1 units (used in the companion schwarzschild_metric.wl), `v = t + r_*` is valid because length and time have the same dimension. The EF metric formula itself is dimensionally correct.

**Proposed fix (two options):**
1. Add a sentence: "We work in geometrized units c = 1 for this section, so r* has units of time."
2. Rewrite the tortoise coordinate as `r_* \equiv r/c + (R_S/c)\ln|r/R_S - 1|` (time units) and keep `v = t + r_*`.

---

## Appendix: Verification log

### wolframscript run (schwarzschild_metric.wl)
- Metric: `ds² = −(1−Rs/r)dt² + (1−Rs/r)^{−1}dr² + r²dΩ²` (c=1 units throughout .wl)
- Christoffel symbols: 9 independent nonvanishing components computed symbolically
- Ricci tensor: all 10 independent components verified = 0 (`All Ricci components vanish? True`)
- Kretschmann scalar: `K = 12Rs²/r⁶`, match confirmed (`Match? True`)
- At r = Rs: `K = 12/Rs⁴` (finite — confirms coordinate singularity only)
- Rs (Earth 5.97e24 kg): 8.866 mm
- Rs (Sun 1.99e30 kg): 2.954 km
- Rs (NS 1.4 Msun): 4.135 km
- Rs (SgrA* 4e6 Msun): 1.1815×10⁷ km
- NS redshift: z = 0.306, r/Rs = 2.418

### Python recompute (constants matching .wl: G=6.674e-11, c=2.998e8, Msun=1.989e30)
- All table values confirmed to within rounding precision
- Galaxy Rs = 0.096 pc (tex: ~0.1 pc) ✓
- Sun z = 2.122×10^{-6} (tex: ~10^{-6}) — factor 2 understatement

### CrossRef checks
- Pound & Rebka 1959: DOI 10.1103/physrevlett.3.439, PRL 3, 439 (1959) — CONFIRMED
- MICROSCOPE (Touboul et al. 2019): DOI 10.1088/1361-6382/ab4707 — precision ~10^{-14}
- MICROSCOPE final (2022): ~10^{-15} (beyond CrossRef results available; consistent with training knowledge)

### Carroll PDF equation confirmations
- 5.5 (p.194): 3-function metric with γ — NOT the tex's form
- 5.11 (p.195): 2-function metric WITHOUT γ — matches the tex's form
- 5.12 (p.195): Christoffel symbols ✓
- 5.14 (p.195): Ricci tensor ✓
- 5.17 (p.196): α = −β ✓
- 5.18 (p.196): R_{θθ} = 0 equation ✓
- 5.23 (p.196): Rs = 2GM (c=1) ✓
- 5.50 (p.205): Kretschmann = 48G²M²/r⁶ (c=1) ✓
- 5.58 (p.207): R^μ = (∂_φ)^μ — Killing vector, NOT tortoise coordinate
- 5.60 (p.207): R_μ = (0,0,0,r²sin²θ) — NOT the EF metric
- 5.108 (p.220): tortoise coordinate r* = r + 2GM ln(r/2GM − 1) ← correct eq. for C13
- 5.111 (p.221): EF metric ds² = −(1−2GM/r)dv² + 2dv dr + r²dΩ² ← correct eq. for C14

### C&K PDF equation confirmations
- 3.63 (p.59): gravitational time dilation → z ≈ GM/(c²r) ✓
- 3.64 (p.60): general spherical metric ✓
- 3.65 (p.60): proper time relation ✓
- 3.71 (p.61): weak-field isotropic metric ✓
