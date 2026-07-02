# fact-critic report — Notes/01d_Geodesics_Orbits/01d_Geodesics_Orbits.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run:
>   bibtex ✗ (no .bib found under Learning_to_Lens/),
>   crossref-web ✓ (not needed — both source PDFs present locally),
>   md-reflist ✗,
>   values-file ✗ (no fact-critic.values.* found),
>   repo-grep ✓,
>   doc-internal ✓,
>   overlay: none.
> Primary sources checked: Carroll_SG.pdf (pp. 205–217, PDF pages 205–217);
>   Congdon & Keeton (2018) PDF (pp. 62–67, TOC pp. 73–88 relative);
>   companion geodesic_equation.wl run via `wolframscript -file`; Python recompute.
> (A claim whose lens has no active adapter is capped at ⚠ SUSPECT.)

---

## Verdicts

### Numbers

| id | lens | quoted in tex | verdict | source checked | proposed fix |
|----|------|---------------|---------|----------------|--------------|
| N1 | Number | ISCO = 6GM/c² = 3R_S | ✅ PASS | wolframscript: r=6 (G=c=M=1 units); Python confirms 6GM/c² | none |
| N2 | Number | L_min = 2√3 GM/c | ✅ PASS | wolframscript: L_ISCO = 2√3 = 3.4641 | none |
| N3 | Number | Photon sphere = 3GM/c² = 3R_S/2 | ✅ PASS | wolframscript: r=3 (G=c=M=1); d²V/dr²<0 at r=3 confirms unstable | none |
| N4 | Number | Δφ_Mercury = 5.01×10⁻⁷ rad/orbit | ❌ FAIL (auto-fixed) | wolframscript: 5.020×10⁻⁷; Python (same constants): 5.020×10⁻⁷ | 5.02×10⁻⁷ |
| N5 | Number | 0.103''/orbit | ❌ FAIL (auto-fixed) | wolframscript: 0.10355; Python: 0.10355 → rounds to 0.104 | 0.104'' |
| N6 | Number | 43.0''/century | ✅ PASS | wolframscript: 42.995 → rounds to 43.0; Python: 43.0 | none |
| N7 | Number | ℓ_crit = 2√3 GM/c (used for C&K eq.3.84 inner bound) | ✅ PASS | C&K p. 64: "ℓ_crit ≡ 2√3 GM/c"; wolframscript agrees | none |
| N8 | Number | Kerr ISCO prograde (max spin) = GM/c² | ✅ PASS | Python: r_+(a=GM/c²) = GM/c²; standard GR result | none |
| N9 | Number | Kerr ISCO retrograde (max spin) = 9GM/c² | ✅ PASS | Standard GR result (Boyer-Lindquist analytic formula); consistent | none |

### Citations

| id | lens | quoted in tex | verdict | source checked | proposed fix |
|----|------|---------------|---------|----------------|--------------|
| C1 | Citation | Carroll Sec.~5.4 (Killing vectors) | ✅ PASS | Carroll PDF p. 205: Sec. 5.4 = "Geodesics of Schwarzschild", discusses Killing vectors | none |
| C2 | Citation | Carroll eq.~5.54 (K_μ dx^μ/dλ = const) | ✅ PASS | Carroll PDF p. 206: eq. 5.54 exactly matches | none |
| C3 | Citation | Carroll eqs.~5.61–5.62 (E and L) | ✅ PASS | Carroll PDF p. 207: 5.61 = E, 5.62 = L = r²dφ/dλ | none |
| C4 | Citation | Carroll eq.~5.56 (θ = π/2) | ✅ PASS | Carroll PDF p. 207: eq. 5.56 is θ = π/2 | none |
| C5 | Citation | Carroll eq.~5.63 (normalization condition) | ✅ PASS | Carroll PDF p. 208: eq. 5.63 matches tex exactly | none |
| C6 | Citation | Carroll eq.~5.64 for "½(dr/dλ)² + V_eff = E" | ❌ FAIL | Carroll PDF p. 208: eq. 5.64 = intermediate form "−E² + (dr/dλ)² + (1−2GM/r)(L²/r² + ε) = 0"; eq. 5.65 is the ½(dr/dλ)² + V = E form | Change citation to Carroll eq.~5.65 (flag only) |
| C7 | Citation | Carroll eq.~5.66 for V_eff = −εGM/r + L²/2r² − GML²/c²r³ | ⚠ SUSPECT | Carroll PDF p. 209: eq. 5.66 = V(r) = ½ε − εGM/r + L²/2r² − GML²/r³ (includes +½ε constant that tex drops into the energy E = ½(E²−εc²)). Formula is convention-equivalent but does not literally match. | Add note: "tex absorbs ½ε into E; Carroll eq. 5.66 contains an additive +½ε" (flag only) |
| C8 | Citation | Carroll eq.~5.68 (circular orbit condition) | ✅ PASS | Carroll PDF p. 210: εGMr_c² − L²r_c + 3GML²γ = 0; with ε=γ=1 matches tex | none |
| C9 | Citation | Carroll eq.~5.71 (circular radii r_±) | ✅ PASS | Carroll PDF p. 212: r_c = (L² ± √(L⁴−12G²M²L²))/(2GM) = tex's form | none |
| C10 | Citation | Carroll eq.~5.73 (L_min = √12 GM) | ✅ PASS | Carroll PDF p. 212: L = √12 GM = 2√3 GM | none |
| C11 | Citation | Carroll eq.~5.74 (ISCO = 6GM) | ✅ PASS | Carroll PDF p. 212: r_c = 6GM | none |
| C12 | Citation | Carroll eq.~5.70 (photon sphere r_c = 3GM) | ✅ PASS | Carroll PDF p. 211: "For ε=0, γ=1, r_c = 3GM" (eq. 5.70) | none |
| C13 | Citation | Carroll Sec.~5.5 (perihelion precession) | ✅ PASS | Carroll PDF: Sec. 5.5 = "Experimental Tests", covers perihelion | none |
| C14 | Citation | Carroll eq.~5.79 (orbit equation d²x/dφ² + x = 1 + 3G²M²x²/L²c²) | ✅ PASS | Carroll PDF p. 214: eq. 5.79 = d²x/dφ² − 1 + x = 3G²M²x²/L² (G=c=1); equivalent to tex with explicit c | none |
| C15 | Citation | Carroll eq.~5.92 (Δφ = 2πα = 6πG²M²/L²) | ✅ PASS | Carroll PDF p. 215: eq. 5.92 = Δφ = 2πα = 6πG²M²/L² | none |
| C16 | Citation | Carroll eq.~5.96 (Mercury orbital parameters) | ✅ PASS | Carroll PDF p. 216: eq. 5.96 gives a=5.79×10¹² cm, e=0.2056 | none |
| C17 | Citation | Carroll Figs.~5.4 and 5.5 (effective potential figures) | ✅ PASS | Carroll PDF pp. 210–211: Figs. 5.4 and 5.5 are exactly these effective potential figures | none |
| C18 | Citation | Carroll Fig.~5.6 (precessing orbit) | ✅ PASS | Carroll PDF p. 213: Fig. 5.6 = "Orbits in general relativity describe precessing ellipses" | none |
| C19 | Citation | Congdon & Keeton eq.~3.80 (V_eff massive) | ✅ PASS | C&K PDF p. 63: Φ_eff(r) = −GM/r + ℓ²/(2r²) − GMℓ²/(c²r³); matches tex for ε=1 | none |
| C20 | Citation | Congdon & Keeton eq.~3.84 (ISCO = 6GM/c²) | ✅ PASS | C&K PDF p. 64: r_+ = ℓ²_crit/(2GM) = 6GM/c² | none |
| C21 | Citation | "Congdon & Keeton eq.~3.84 with ℓ_crit" for photon sphere r = 3GM/c² | ❌ FAIL | C&K PDF p. 64: eq. 3.84 gives the ISCO (6GM/c²), NOT the photon sphere. The photon sphere r = 3GM/c² is stated in the prose after eq. 3.86 ("there is only one such radius: r = 3GM/c²") with no separate equation number | Remove C&K eq.~3.84 from photon sphere citation; cite prose following C&K eq.~3.86 (flag only) |
| C22 | Citation | Congdon & Keeton eq.~3.86 (photon V_eff) | ✅ PASS | C&K PDF p. 64: Φ_eff(r) = ℓ²/(2r²) − GMℓ²/(c²r³) exactly | none |
| C23 | Citation | Congdon & Keeton eq.~3.87 (photon orbit dφ/dr) | ✅ PASS | C&K PDF p. 65: dφ/dr = ±ℓ r⁻² [ε²/c² − ℓ²/r²(1−R_S/r)]^(−1/2); matches tex | none |
| C24 | Citation | "Congdon & Keeton eq.~3.95" for perihelion precession Δφ = 6πGM/(c²a(1−e²)) | ❌ FAIL | C&K PDF p. 67: eq. 3.95 = Δφ = π + 4m/r₀ + O(m/r₀)², which is the LIGHT DEFLECTION expansion, not the perihelion precession formula. C&K Chapter 3 does not derive perihelion precession. | Remove C&K eq.~3.95 from perihelion precession citation entirely (flag only) |
| C25 | Citation | Congdon & Keeton eq.~3.96 (deflection α̂ = 4GM/c²b) | ✅ PASS | C&K PDF p. 67: α̂ = 4GM/(c²ξ), with ξ = impact parameter (tex uses b); formula identical | none |

### Consistency

| id | lens | claim | verdict | source checked |
|----|------|-------|---------|----------------|
| X1 | Consistency | ISCO quoted as 3R_S in text (eq. ISCO) and in table | ✅ PASS | internal: 2 occurrences agree |
| X2 | Consistency | Photon sphere quoted as 3R_S/2 in text and in table | ✅ PASS | internal: 2 occurrences agree |
| X3 | Consistency | Mercury 43 arcsec/century in eq. and in summary (§7) | ✅ PASS | internal: 2 occurrences agree |
| X4 | Consistency | L_ISCO = 2√3 GM/c: appears in §3, in figure caption, in §5 table context | ✅ PASS | internal: 3 occurrences agree |
| X5 | Consistency | V_eff form in §2 vs summary §7: tex line 394 gives V_eff = −εGM/r + L²/(2r²) − GML²/(c²r³) | ✅ PASS | internal: 2 occurrences agree |

---

## Applied (auto-fixes)

- **N4**: `5.01 \times 10^{-7}` → `5.02 \times 10^{-7}` (Mercury Δφ/orbit in rad).
  Source: wolframscript geodesic_equation.wl prints 5.020394×10⁻⁷; Python recompute (same constants G=6.674×10⁻¹¹, c=2.998×10⁸, M=1.989×10³⁰, a=5.79×10¹⁰, e=0.2056) gives 5.020×10⁻⁷.
  [Notes/01d_Geodesics_Orbits/01d_Geodesics_Orbits.tex, eq. mercury_precession, line 279]

- **N5**: `0.103''` → `0.104''` (Mercury Δφ/orbit in arcsec).
  Source: 5.020×10⁻⁷ rad × (180×3600/π) = 0.10355''; rounded to 3 significant figures = 0.104.
  Wolframscript prints 0.10355; Python recompute agrees.
  [Notes/01d_Geodesics_Orbits/01d_Geodesics_Orbits.tex, eq. mercury_precession, line 280]

*Note on Carroll's values:* Carroll eq. 5.97 (p. 216) states "5.01×10⁻⁷ radians/orbit = 0.103''/orbit." Carroll's own constants in eq. 5.96 (GM/c² = 1.48×10⁵ cm, c = 3.00×10¹⁰ cm/s) give 5.03×10⁻⁷ when recalculated, not 5.01. The tex reproduced Carroll's eq. 5.97 values, but both the companion notebook and independent recompute place the correct 3-sig-fig value at 5.02 (notebook constants) or 5.03 (Carroll constants). The closest unambiguous value matching BOTH sources is **5.02×10⁻⁷** and **0.104''/orbit**.

---

## Flagged — your hand required

### C6 — Carroll eq. number off by one (citation mismatch)

**Tex:** `we obtain a radial equation (Carroll eq.~5.64): ½(dr/dλ)² + V_eff(r) = E`

**Carroll PDF (p. 208):**
- eq. 5.64 = the intermediate form: −E² + (dr/dλ)² + (1−2GM/r)(L²/r² + ε) = 0
- eq. 5.65 = the clean form: ½(dr/dλ)² + V(r) = E  ← this is what the tex describes

**Proposed fix:** Change `Carroll eq.~5.64` to `Carroll eq.~5.65` in the preamble to eq. (radial_equation).

---

### C7 — Carroll eq.~5.66 V_eff convention discrepancy (SUSPECT)

**Tex:** V_eff = −εGM/r + L²/(2r²) − GML²/(c²r³), attributed to Carroll eq.~5.66.

**Carroll eq. 5.66 (p. 209):** V(r) = ½ε − εGM/r + L²/(2r²) − GML²/r³

The tex drops the +½ε constant by absorbing it into the effective energy E = ½(E²−εc²), whereas Carroll sets E = ½E². These are physically equivalent (same dynamics), but the tex's formula does NOT literally match Carroll eq. 5.66 as printed. This could confuse a reader who looks up Carroll.

**Proposed fix:** Either (a) keep the formula as-is and add a parenthetical noting the convention, e.g., "(Carroll eq.~5.66, with additive constant ½ε absorbed into E)," or (b) cite C&K eq.~3.80 only, which matches the tex's form exactly.

---

### C21 — Photon sphere falsely attributed to C&K eq.~3.84

**Tex (§4, line 195):** `(Carroll eq.~5.70; Congdon \& Keeton eq.~3.84 with $\ell_{\mathrm{crit}}$)` for r_photon = 3GM/c²

**C&K eq. 3.84 (p. 64):** r_+ = ℓ²_crit/(2GM) = 6GM/c² — this is the **ISCO**, not the photon sphere.

The photon sphere radius r = 3GM/c² is stated in the prose of C&K Sec. 3.3.3 (after eq. 3.86): "In fact, there is only one such radius: r = 3GM/c²." There is no numbered equation for it in C&K.

**Proposed fix:** Remove `Congdon \& Keeton eq.~3.84 with $\ell_{\mathrm{crit}}$` from the photon sphere citation. Cite only `Carroll eq.~5.70` (which is correct), and optionally add a cross-reference to C&K Sec. 3.3.3 (prose following eq. 3.86).

---

### C24 — Perihelion precession falsely attributed to C&K eq.~3.95

**Tex (§5, line 267):** `(Carroll eq.~5.92; Congdon \& Keeton eq.~3.95)` for Δφ = 6πGM/(c²a(1−e²))

**C&K eq. 3.95 (p. 67):** Δφ = π + 4m/r₀ + O(m/r₀)² — this is the **light deflection** angle expansion (where m = GM/c²), not the perihelion precession formula. Chapter 3 of C&K covers light bending; perihelion precession does not appear in C&K Chapter 3.

**Proposed fix:** Remove `Congdon \& Keeton eq.~3.95` from this citation. Cite Carroll eq.~5.92 only, which is correct.

---

### Kerr ergosphere inner boundary (formula error, flag only)

**Tex (§7, Kerr overview):** "The region $R_S/2 < r < (R_S + \sqrt{R_S^2 - 4a^2\cos^2\theta})/2$ where even stationary observers must rotate"

**Correct inner boundary:** The ergosphere region is bounded on the inside by the **outer event horizon** r_+ = (R_S + √(R_S² − 4a²))/2. R_S/2 = GM/c² equals r_+ ONLY at maximum spin (a = GM/c²). For any a < GM/c²: r_+ > R_S/2 (e.g., at a = 0 [Schwarzschild], r_+ = R_S, which is twice R_S/2).

Python verification: at a/M = 0.5, r_+ = 1.866 GM/c² vs R_S/2 = 1.0 GM/c² — a factor of ~2 discrepancy at half-maximum spin.

**Proposed fix:** Replace `R_S/2 < r <` with `r_+ < r <` where `r_+ = (R_S + \sqrt{R_S^2 - 4a^2})/2` is the outer event horizon. The revised sentence would read: "The region $r_+ < r < (R_S + \sqrt{R_S^2 - 4a^2\cos^2\theta})/2$, where $r_+ = (R_S + \sqrt{R_S^2 - 4a^2})/2$ is the outer event horizon, ..."

---

## Summary table

| Category | PASS | FAIL (fixed) | FAIL (flagged) | SUSPECT |
|----------|------|-------------|----------------|---------|
| Number | 7 | 2 (N4, N5) | 0 | 0 |
| Citation | 17 | 3 (C6, C21, C24) | 3 | 1 (C7) |
| Consistency | 5 | 0 | 0 | 0 |
| Formula (Kerr ergosphere) | — | — | 1 | — |
