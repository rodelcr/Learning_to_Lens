# fact-critic report — Module 02 (Light Deflection), Annotated Study Edition layer

> Date: 2026-10-14 · Critic: independent pass (did not author the layer) · Branch `wt/ann0203`
> Scope: boxes added in `ee6e2b6` (`git diff c588432 ee6e2b6 -- Notes/02*`) in
> `02_Light_Deflection.tex`, `02_Solutions.tex`, plus the appended check section of
> `Solutions/02_Light_Deflection/problems_02.wl`; and adjudication of the author's flags
> on pre-existing visible text (items 2, 3, 4, 5, 9 of the brief).
> Lenses: Citation, Number, Consistency, Prose, Derivation.
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (CrossRef
> JSON fetched to scratchpad `critic_0203/crossref/`, parsed with grep only),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓, wolframscript ✓
> (`bash Mathematica/run_wl.sh`), overlay: agel-sources (Zotero not needed; no new cites).
> Claims with no active adapter are capped at ⚠ SUSPECT.

Repo scripts run:
- `Solutions/02_Light_Deflection/problems_02.wl` → `SUMMARY: 44 PASS, 0 FAIL  (of 44 checks)`
- Critic scratch `.../scratchpad/critic_0203/critic_0203.wl` → `SUMMARY: 42 PASS, 0 FAIL  (of 42 checks)`

## Verdicts

### Annotation layer (new boxes)

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | "Sun has R_S ≈ 2.95 km; 10^12 M☉ has R_S ≈ 2.95×10^15 m" | ✅ PASS | problems_02.wl A12a, A12c (ran) | none |
| N2 | Number | "b = 10 kpc: m/b ≈ 4.8×10^-6" | ✅ PASS | A12d (ran) | none |
| N3 | Number | "r0 = b − m − (3/2)m²/b" | ✅ PASS | A3 (ran); critic L6 (ansatz solve) | none |
| N4 | Number | "2∫(3/2)(1−u³)²/(1−u²)^{5/2} = 15π/4 − 4"; "α̂ = 4m/b + (15π/4)(m/b)²" | ✅ PASS | A9a–c (ran); critic L8a: exact integral at ε=1e-4 gives ε² coeff 7.7827 vs 15π/4−4 = 7.7810; L8b symbolic re-expansion | none |
| N5 | Number | "1% at b/R_S ≈ 147; 15π/16 ≈ 2.9; exact 1.0% (140–150 crossing: 1.05%, 0.98%), 15.3% at b/R_S=10 vs 14.7%" | ✅ PASS | A10a–c (ran: 147.26; 1.054%, 0.984%; 15.30% / 14.73%); critic L4 | none |
| N6 | Number | "b_crit = 3√3 m, at r0 = 3m" | ✅ PASS | A11a–b (ran); critic L7 | none |
| N7 | Number | "4GM☉/c³ = 19.7 μs; ln = 11.18; 220 μs without +1; 240 μs with" | ✅ PASS | A14c–f (ran: 219.99/220.28, 239.99); critic F4 (220.30 / 240.00) | none |
| N8 | Number | "α̂☉ = 8.49×10^-6 rad = 1.75″; Soldner 4.25×10^-6 rad = 0.876″" | ✅ PASS | A12b, A16d (ran); critic F3d (4.2461e-6 rad = 0.87582″) | none |
| N9 | Number | "θ_E ≈ 2.4″ for 10^12 M☉, z_d=0.3, z_s=1" | ✅ PASS | problems_03.wl B19d (2.379″, ran); critic F5 (2.3792″) | none |
| N10 | Number | "non-logarithmic term is a 9% effect" | ✅ PASS | arithmetic on A14 output: 19.7/220.3 = 8.9% | none |
| N11 | Number | "(1+z_d) factor … biases H0 by tens of per cent" | ✅ PASS | internal: eq:time_delay_function (06_Fermat_Time_Delays.tex) carries (1+z_d); typical z_d 0.2–0.7 | none |
| D1 | Derivation | orbit eq. from Killing constants (Step 1–2) | ✅ PASS | A1 (ran) | none |
| D2 | Derivation | b = cL/E from asymptotic matching | ✅ PASS | A2 (ran) | none |
| D3 | Derivation | u = r0/r substitution → eq:delta_phi_u2 | ✅ PASS | A4, A5 (ran) | none |
| D4 | Derivation | bare integral = 2 by u = sin ϑ | ✅ PASS | A7a–d (ran) | none |
| D5 | Derivation | Born integral 2GM/b → 4GM/(c²b) | ✅ PASS | A8 (ran); critic F2d | none |
| D6 | Derivation | n = √[(1+2m/r)/(1−2m/r)] = 1 + 2m/r; ray-optics gives 4m/b, g_tt-only 2m/b | ✅ PASS | A15a–c (ran); critic F2a, F2c, F2d | none |
| D7 | Derivation | Soldner via Binet + energy; φ∞ = ±(π/2+δ); swept π+2δ | ✅ PASS | A16a–c (ran); critic F3a, F3c | none |
| D8 | Derivation | c dt/dr expansion and three integrals (Shapiro) | ✅ PASS | A13a–d, A14a–b (ran) | none |
| D9 | Derivation | β=0 ring → eq:einstein_radius_deflection; Fermat Shapiro coefficient; α1/α2 = B | ✅ PASS | A17, A18, A19 (ran) | none |
| X1 | Consistency | `\ref{ch:power_law_point_mass}`, `ch:multiplane_dspl` | ✅ PASS | `15_PowerLaw_PointMass.aux`: ch. 19 "Power-Law Lenses with a Central Point Mass"; `14_Multiplane_DSPL.aux`: ch. 18 "The Multi-Plane Lens Equation and Double-Source-Plane Lenses" | none |
| X2 | Consistency | refs eq:deflection_integral, eq:refractive_index (01e), eq:reduced_deflection, eq:deflection_integral_continuous (04), eq:time_delay_function (06), fig:exact_vs_approx, ex:einstein_radius_numerical | ✅ PASS | repo-grep: every label exists in the module whose content the box describes | none |
| X3 | Consistency | "Module 1d works in units with c = 1" | ✅ PASS | `Notes/01d_Geodesics_Orbits/01d_Solutions.tex:54,102` | none |
| X4 | Consistency | layer box after Ex 2.1(b) gives φ∞ = ±(π/2+δ); visible text says φ± = π ∓ δ | ❌ FAIL (visible text) | critic F3b: cos(π−δ) ≈ −1 ≠ −1/e | see Flagged V2 |
| X5 | Consistency | layer gives n = 1 + 2m/r; visible Ex 2.2(b) gives 1 + 4GM/(c²r) | ❌ FAIL (visible text) | critic F2a/F2b | see Flagged V1 |
| X6 | Consistency | layer θ_E ≈ 2.4″ vs visible remark "θ_E ∼ 1″" | ❌ FAIL (visible text) | critic F5 | see Flagged V4 |
| X7 | Consistency | layer "240 μs needs the +1" vs ex:shapiro_sun (a) formula without +1 and (b) "≈ 240 μs" | ❌ FAIL (visible text) | critic F4 | see Flagged V3 |
| P1 | Prose | "utterly negligible … not an approximation anyone needs to worry about there" | ⚠ SUSPECT (intensifier + aphoristic closer) | read | "is negligible for galaxy and cluster lensing." |
| P2 | Prose | "the Shapiro term knows nothing about cosmology, while the geometric term carries all of it" | ⚠ SUSPECT (balanced antithesis; content is correct) | read | "the Shapiro term is independent of the distances; all the cosmology sits in the geometric term." |

### Author's flags on VISIBLE text (adjudicated)

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| V1 | Number/Derivation | 02_Solutions Ex 2.2(b): "n(r) ≈ (1+2GM/c²r)/(1−2GM/c²r) ≈ 1 + 4GM/(c²r)"; "Newtonian … n = 1 + 2GM/(c²r)" | ❌ FAIL (author correct) | critic F2a/F2b/F2c; problems_02.wl A15a; 01e eq:refractive_index (n = 1 + 2|Φ|/c²) | see Flagged |
| V2 | Derivation | 02_Solutions Ex 2.1(b): "φ± = π ∓ δ, sin δ = 1/e" | ❌ FAIL (author correct) | critic F3a–c; A16c | see Flagged |
| V3 | Number | ex:shapiro_sun: (a) ΔT ≈ (4GM☉/c³) ln(4R⊕R/r0²); (b) "≈ 240 μs" | ❌ FAIL (author correct) | critic F4: 220.3 μs without +1 | see Flagged |
| V4 | Number | remark after eq:einstein_radius_deflection: "θ_E ∼ 1″" for 10^12 M☉, z 0.3 → 1 | ❌ FAIL (author correct; factor 2.4) | critic F5: 2.379″; 04_Solutions.tex:179,207 and 03_Solutions.tex:352 already say 2.4″ | see Flagged |
| V5 | Number | 02_Solutions Ex 2.1(c) and chapter §Deflection by the Sun "0.875″" | ⚠ SUSPECT (rounding) | critic F3d: 0.8758″ | see Flagged |
| V6 | Citation | 02_Solutions:252 "Shapiro's 1964 measurement gave 200 ± 20 μs"; 02_Light_Deflection.tex:1120 "Shapiro's 1964 measurement using the Haystack radar" | ❌ FAIL (mis-attribution; author correct) | CrossRef 10.1103/PhysRevLett.13.789: "Fourth Test of General Relativity", Shapiro (sole author), PRL 13, 789–791, 1964-12-28. CrossRef 10.1103/PhysRevLett.20.1265: "Fourth Test of General Relativity: Preliminary Results", Shapiro, Pettengill, Ash, Stone, Smith, Ingalls, Brockelman, PRL 20, 1265–1269, 1968-05-27 | see Flagged |
| V7 | Number | "200 ± 20 μs", "Haystack radar" | ⚠ SUSPECT | no adapter: CrossRef records carry no abstract; no full text in Reference_Texts | see Flagged |
| V8 | Derivation (NEW, not in author's list) | ex:shapiro_sun(b) "Mercury at inferior conjunction"; 02_Solutions:254 "Mercury is not exactly at inferior conjunction" | ❌ FAIL | internal: the leg decomposition in the solution (A14b) puts Earth and Mercury on opposite sides of the closest-approach point; at inferior conjunction Mercury is between Earth and Sun, so no ray grazes the Sun | "superior conjunction" in both places |
| C1 | Citation | 02_Light_Deflection.tex:616 "predicted by Irwin Shapiro in 1964" | ✅ PASS | CrossRef 10.1103/PhysRevLett.13.789 (title/author/year match) | none |

## Applied (auto-fixes)

None. The brief forbids visible-text edits, and every number in the new layer passed.

## Flagged — your hand required

- **V1. Ex 2.2(b) refractive index (02_Solutions.tex:119–126). FAIL.** The displayed
  `n ≈ (1+2m/r)/(1−2m/r) ≈ 1 + 4GM/(c²r)` drops the square root. From ds² = 0,
  |dx/dt| = c√[(1−2m/r)/(1+2m/r)], so n = √[(1+2m/r)/(1−2m/r)] = 1 + 2GM/(c²r) + O(m²)
  (critic F2a; problems_02 A15a). This matches 01e eq:refractive_index, n = 1 + 2|Φ|/c².
  The no-root form expands to 1 + 4m/r (critic F2b), which is the visible error. The
  g_tt-only ("Newtonian") index is n = (1−2m/r)^{-1/2} = 1 + GM/(c²r) (critic F2c), not
  1 + 2GM/(c²r). Ray optics then gives 4m/b for n−1 = 2m/r and 2m/b for n−1 = m/r (critic F2d),
  so the factor-of-2 conclusion survives once both indices are halved. **Fix:**
  `n(r) = \sqrt{\frac{1+2GM/(c^2 r)}{1-2GM/(c^2 r)}} \approx 1 + \frac{2GM}{c^2 r}` and
  "The Newtonian calculation effectively uses n = 1 + GM/(c²r)". Same fix in
  `Solutions/02_Light_Deflection/problems_02.wl:121–122`, which prints
  `n(r) = sqrt(g_rr/(-g_tt)) ~ 1 + 4*GM/(c^2*r)` and `n ~ 1 + 2*GM/(c^2*r)` (the sqrt
  expression on line 121 is right; only its expansion is wrong). Add a `check[]` there
  (A15a already covers the symbolic identity).
- **V2. Ex 2.1(b) asymptotic angles (02_Solutions.tex:52–53). FAIL.** With
  r = p/(1+e cos φ) and periapse at φ = 0, r → ∞ at cos φ = −1/e, i.e.
  φ∞ = ±arccos(−1/e) = ±(π/2 + δ), sin δ = 1/e (critic F3a, F3c). π ∓ δ does not satisfy
  cos φ = −1/e (cos(π−δ) = −cos δ ≈ −1; critic F3b). **Fix:** "The two asymptotic angles
  are φ± = ±(π/2 + δ) where sin δ = 1/e. The swept angle is π + 2δ, so the deflection
  angle is α̂ = 2δ = 2 arcsin(1/e)." The final α̂ = 2δ was already right.
- **V3. ex:shapiro_sun (02_Light_Deflection.tex:752–761). FAIL.** The part (a) formula
  gives 19.706 μs × 11.179 = 220 μs (critic F4: 220.30). Only the "+1" form of
  ex:shapiro_radar gives 240 μs (240.00). **Fix (pick one):** (i) change (b) to "You should
  find ΔT ≈ 220 μs (240 μs once the non-logarithmic +1 of Exercise ~\ref{ex:shapiro_radar}
  is kept)"; or (ii) put `\left[\ln(\cdot) + 1\right]` in (a). Option (i) keeps the two
  exercises distinct. The layer annotation at line 766 already explains the gap and can
  stay with either fix.
- **V4. Remark after eq:einstein_radius_deflection (02_Light_Deflection.tex:879–880). FAIL.**
  For 10^12 M☉, z_d = 0.3, z_s = 1 (flat ΛCDM, H0 = 70, Ω_m = 0.3), D_d = 918.8,
  D_s = 1651.9, D_ds = 1054.7 Mpc, so θ_E = 2.379″ (critic F5). 03_Solutions Ex 3.5 (2.4″)
  and 04_Solutions.tex:179,207 (2.4″) agree. "∼1″" is low by 2.4×. **Fix:** "this gives
  θ_E ≈ 2.4″ (Exercise~\ref{ex:einstein_radius_numerical})". Once fixed, cut the last
  clause of the layer derivation box at line 899 ("``∼1″'' above is an order-of-magnitude
  statement"). Line 869 ("of order ∼1″, depending on the distance configuration") is
  generic and can stay, or become "a few arcseconds".
- **V5. 0.875″ (02_Solutions Ex 2.1(c); chapter §Deflection by the Sun "Newtonian value 0.875″").
  SUSPECT (rounding only).** 2GM☉/(c²R☉) = 4.2461×10⁻⁶ rad = 0.8758″ (critic F3d;
  problems_02 prints 0.87577). To three decimals that is 0.876″, and 0.875″ is half of the
  rounded 1.75″. The layer annotation says this correctly. **Fix (optional):** write
  "0.876″" or "≈ 0.88″" in the visible solution. Leaving it alone is defensible.
- **V6. "Shapiro's 1964 measurement" (02_Solutions.tex:252; 02_Light_Deflection.tex:1120;
  problems_02.wl:225). FAIL, mis-attribution.** CrossRef confirms Shapiro 1964,
  PRL 13, 789, "Fourth Test of General Relativity" (sole author), which is the prediction
  paper. The first measurement is Shapiro, Pettengill, Ash, Stone, Smith, Ingalls &
  Brockelman 1968, PRL 20, 1265, "Fourth Test of General Relativity: Preliminary Results"
  (DOI 10.1103/PhysRevLett.20.1265). **Fix:** "The first radar measurement (Shapiro et al.
  1968, Phys. Rev. Lett. 20, 1265) …". No bib keys were added, per the brief. If you want
  a `\citet`, both DOIs above are CrossRef-confirmed. The chapter's own line 616
  ("predicted by Irwin Shapiro in 1964 and first measured …") is correct.
- **V7. "200 ± 20 μs" and "Haystack radar". SUSPECT, unverifiable here.** CrossRef carries
  no abstract, and the 1968 paper is not in Reference_Texts or Zotero, so neither the
  number nor the instrument could be checked. If you keep a number, take it from the 1968
  paper itself. Also, 240 μs vs 200 ± 20 μs is a 2σ difference, and the solution calls it
  "consistent", which a reader may question.
- **V8 (new). "Mercury at inferior conjunction" (02_Light_Deflection.tex:760;
  02_Solutions.tex:254). FAIL.** The derivation splits the path into Earth → r0 and
  r0 → Mercury with the closest-approach point between them (A14b,
  ΔT = 2[δT(R⊕) + δT(R_Merc)]). That requires Mercury behind the Sun, i.e. superior
  conjunction. At inferior conjunction Mercury sits between Earth and Sun and the ray
  never reaches r0 = R☉. **Fix:** "superior conjunction" in both places.
- **Layer, informational.** The box "The refractive index, keeping the square root" sits
  right after the wrong visible formula of V1 and states the right one without saying the
  visible line is wrong. Once V1 is fixed, nothing more is needed.

## Prose (LLM tells) — flag-only

New-layer words added: 02_Light_Deflection.tex 2638, 02_Solutions.tex 839. Em-dashes:
0 and 0. Antithesis hits: 1 and 1. Triads: none that are ornamental. The layer mostly
reads as plain worked steps. Worst offenders are P1 ("utterly negligible … anyone needs to
worry about") and P2 (balanced antithesis about the Shapiro term), with rewrites in the
table. "Two lessons. (i) … (ii) …" in the Born-integral box is a list carrying content,
not a tell.

## Derivation checks

Scratch script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0203/critic_0203.wl`
(log: `critic_0203.log`). `SUMMARY: 42 PASS, 0 FAIL  (of 42 checks)`. Module-02 rows:

| check | content | result |
|---|---|---|
| F2a–d | n = √[(1+2m/r)/(1−2m/r)] → 1+2m/r; no-root form → 1+4m/r; g_tt-only → 1+m/r; ray optics 4m/b, 2m/b | PASS |
| F3a–d | asymptote ±(π/2+δ); π−δ fails cos φ = −1/e; sweep π+2δ; Soldner 4.2461e-6 rad = 0.8758″ | PASS |
| F4 | Shapiro: 19.707 μs × 11.179 = 220.3 μs; with +1: 240.0 μs | PASS |
| F5 | θ_E(10^12 M☉; 0.3, 1) = 2.379″ (D_d 918.8, D_s 1651.9, D_ds 1054.7 Mpc) | PASS |
| L4 | (15π/32)/0.01 = 147 | PASS |
| L6 | r0 = b − m − (3/2)m²/b from r0³ = b²(r0−2m) | PASS |
| L7 | min of b² = r0³/(r0−2m) at r0 = 3m, b_crit = 3√3 m | PASS |
| L8a | ε² coefficient from the *exact* integral (ε = 10⁻⁴, 30-digit) = 7.7827 vs 15π/4−4 = 7.7810 (difference is the O(ε³) term) | PASS |
| L8b | 4ε + (15π/4−4)ε² with ε = q/(1−q−3q²/2) → 4q + (15π/4)q² | PASS |

Repo: `problems_02.wl` → `SUMMARY: 44 PASS, 0 FAIL  (of 44 checks)`. Note that its
pre-existing (non-check) printout still shows the V1 error (lines 121–122) and the V6
attribution (line 225). The check suite passing does not cover those printed lines.

## Resolution — fixes applied 2026-10-14

| id | Fix | Backing |
|----|-----|---------|
| V1 | 02_Solutions Ex 2.2(b): n = √[(1+2m/r)/(1−2m/r)] ≈ 1 + 2GM/(c²r), cross-ref to 01e eq:refractive_index, one-sentence note that the earlier version dropped the root; Newtonian (g_tt-only) index → 1 + GM/(c²r). problems_02.wl printout (ll.121–122) corrected. | `problems_02.wl` A20a (coefficient 2/r, fails on 4/r), A20b, A20c (g_tt-only 1/r, fails on 2/r); A15a–c |
| V2 | 02_Solutions Ex 2.1(b): φ± = ±(π/2 + δ), swept angle π + 2δ | A21a (new asymptote satisfies cos φ = −1/e), A21b (old π − δ fails), A21c; A16c |
| V3 | ex:shapiro_sun(b): "ΔT ≈ 220 μs (240 μs once the +1 of Exercise ex:shapiro_radar is kept)"; annotation retitled "220 versus 240 μs" | A22 (leading log = 220, ≠ 240); A14c–f |
| V4 | Remark after eq:einstein_radius_deflection: θ_E ≈ 2.4″ (Exercise ex:einstein_radius_numerical) + footnote recording the old "∼1″" and the distances; line before the remark "of order ∼1″" → "a few arcseconds"; layer box: order-of-magnitude clause dropped | A25 (2.379″ from flat ΛCDM distances, fails on ∼1″); problems_03 B19d |
| V5 | 0.875″ → 0.876″ in chapter §Deflection by the Sun, the Soldner exercise, and 02_Solutions Ex 2.1(c) (4.24 → 4.25×10⁻⁶ rad); "Rounding" annotation reworded ("often-quoted 0.875″") | A16d |
| V6 | ch:1120 exercise and 02_Solutions:252: "first radar measurement (Shapiro et al. 1968, Phys. Rev. Lett. 20, 1265); Shapiro's 1964 paper was the prediction". Plain prose, no \cite (no bib key). problems_02.wl:225 printout corrected. | CrossRef 10.1103/PhysRevLett.20.1265 and 10.1103/PhysRevLett.13.789 (critic) |
| V7 | "consistent" → "Our idealized point-mass value lies 2σ above it (check A23), so the agreement is marginal rather than clean"; chapter exercise now asks for the difference in σ. Added (i) r₀ > R☉ lowers the log. "Haystack radar" dropped from the chapter exercise (unverified). | A23 ((240−200)/20 = 2) |
| V8 | "inferior" → "superior conjunction" (ch:760 with a parenthetical "Mercury behind the Sun", Sol:254, problems_02.wl printout); annotation box after ex:shapiro_sun explains why | A24a (superior: Earth–Mercury line crosses the solar disc), A24b (inferior: closest approach ≈ 83 R☉) |
| P1 | "utterly negligible … anyone needs to worry about there" → "is negligible for galaxy and cluster lensing." | prose |
| P2 | "knows nothing about cosmology …" → "is independent of the distances; all the cosmology sits in the geometric term." | prose |

**Verification after edits.** Before: `problems_02.wl` → `SUMMARY: 44 PASS, 0 FAIL  (of 44 checks)`.
After (`bash Mathematica/run_wl.sh Solutions/02_Light_Deflection/problems_02.wl`):
`SUMMARY: 55 PASS, 0 FAIL  (of 55 checks)`. `cd Notes && ANNOT_REQUIRED=1 bash build.sh` →
"all assertions passed"; Student 360 pp, Instructor 444 pp, Annotated 569 pp.

**Left open.**
- V7 number/instrument: "200 ± 20 μs" is kept (attributed to the 1968 paper) but remains
  unverified against the paper's full text; "Haystack radar" was removed rather than verified.
  Check against Shapiro et al. 1968 when a copy is available.
- The DOIs for Shapiro 1964 / Shapiro et al. 1968 are not in `references.bib`; the text cites
  them in plain prose (see orchestrator requests).

### Session-3 closeout (2026-10-14, orchestrator)
- `shapiro_1964`, `shapiro_1968` are now cited by key in the exercise (`02_Light_Deflection.tex:1127`) and Solution (c). The "200 ± 20 μs" figure remains unverified against the 1968 full text (APS paywalled; abstract withheld from Semantic Scholar); left attributed.