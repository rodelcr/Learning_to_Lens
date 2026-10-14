# fact-critic report — Module 03 (Cosmological Distances), Annotated Study Edition layer

> Date: 2026-10-14 · Critic: independent pass (did not author the layer) · Branch `wt/ann0203`
> Scope: boxes added in `ee6e2b6` (`git diff c588432 ee6e2b6 -- Notes/03*`) in
> `03_Cosmological_Distances.tex`, `03_Solutions.tex`, plus the appended check section of
> `Solutions/03_Cosmological_Distances/problems_03.wl`. Also adjudicates the author's flags
> on pre-existing visible text (brief items 1, 6, 7, 8).
> Lenses: Citation, Number, Consistency, Prose, Derivation.
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (CrossRef JSON
> fetched to scratchpad `critic_0203/crossref/` and grep-parsed), md-reflist ✗,
> values-file ✗, repo-grep ✓, doc-internal ✓, wolframscript ✓ (`bash Mathematica/run_wl.sh`),
> overlay: agel-sources (not needed; no new cites).
> Distances: flat ΛCDM with H0 = 70 and Ω_m = 0.3 unless stated. Open model uses sinh.

Scripts run:
- `Solutions/03_Cosmological_Distances/problems_03.wl` → `SUMMARY: 76 PASS, 0 FAIL  (of 76 checks)`
- `Mathematica/03_Cosmological_Distances/friedmann_equations.wl` has no SUMMARY line and no
  asserts. It prints `Difference = (-3*(-1 + c^2)*Derivative[2][a][t])/(c^2*a[t])` for
  R_00 (see V1).
- Critic scratch `.../scratchpad/critic_0203/critic_0203.wl` → `SUMMARY: 42 PASS, 0 FAIL  (of 42 checks)`

## Verdicts

### Annotation layer (new boxes)

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| D1 | Derivation | four Christoffel symbols; "13, no fourteenth" | ✅ PASS | B1a–b (ran) | none |
| D2 | Derivation | "R_tt = −3ä/a for x⁰ = t; −3ä/(c²a) is the x⁰ = ct component" | ✅ PASS | B2a–b (ran); critic F1a (independent Γ→Ricci) | none |
| D3 | Derivation | (0,0) equation with consistent factors → Friedmann I | ✅ PASS | B2f–g (ran); critic F1c–d, and F1h (fully x⁰ = ct gives the same result) | none |
| D4 | Derivation | Friedmann II, fluid equation, R_11 term by term, part (d) simplification | ✅ PASS | B3a–b, B4, B4b, B21a–e, B22 (ran) | none |
| D5 | Derivation | CPL ζ(z) = (1+z)^{3(1+w0+wa)} exp(−3 wa z/(1+z)), ζ ≡ 1 for (−1,0) | ✅ PASS | B5b–e (ran); critic L1, L1b (symbolic integral of 3∫(1+w(a'))/a' da') | none (see Flagged C1 on citation) |
| D6 | Derivation | D_ds − (D_s − D_d) = D_d (z_s − z_d)/(1+z_s), flat, exact | ✅ PASS | B13c (ran); critic L2 (symbolic, arbitrary χ_d, χ_s); proof below | none |
| D7 | Derivation | EdS turnover s = 2/3 → z = 5/4, D_A = (8/27)c/H0 = 1269 Mpc | ✅ PASS | B12c–e (ran); critic L3, F7b (numerical max 1268.96 at z = 1.2500) | none |
| D8 | Derivation | sinh subtraction formula ⇒ eq:Dds_general; closed case | ✅ PASS | B10a–c (ran) | none |
| D9 | Derivation | B = (χ1−χl)χ2/[χ1(χ2−χl)], H0-free | ✅ PASS | B15a, B15c (ran) | none |
| N1 | Number | d_H 4283 Mpc = 1.32e26 m; t_H 13.97 Gyr; 977.8/h; ρ_cr 9.2e-27; H0 = 2.268e-18 s⁻¹ | ✅ PASS | B8a–c, B20a (ran) | none |
| N2 | Number | χ = 418, 1889, 3304, 5180, 7776 Mpc | ✅ PASS | B11 (ran) | none |
| N3 | Number | "cz/H0 = 428 Mpc at z = 0.1, already 2% high" | ✅ PASS | B20b; critic L9a (428.27 vs 418.45) | none |
| N4 | Derivation | "…2% high **because the expansion has been accelerating**" (line 932–933) | ❌ FAIL (physics) | critic L9b: EdS (decelerating) χ(0.1) = 398.6 Mpc, further below cz/H0. Pure Λ (q0 = −1) gives χ = cz/H0 exactly. χ < cz/H0 for any q0 > −1, and acceleration *shrinks* the gap | "…already 2% high, because H(z) > H0 at z > 0 (χ ≈ (c/H0)[z − (1+q0)z²/2]); in a decelerating EdS universe the gap would be 7%." |
| N5 | Number | concordance z_max = 1.605, D_A,max = 1748 Mpc | ✅ PASS | B12a; critic F7a (1.6054, 1747.6) | none |
| N6 | Number | open (sinh) z_max = 1.90, 1583 Mpc; χ/(1+z) gives 1.47, 1445 | ✅ PASS | B12f; critic F7c–d | none |
| N7 | Number | D_A(0.5,2.0) = 1097 / 1072 / 1047 Mpc; "about 2%" (2.3%) | ✅ PASS | B14a–b, B20d; critic L9c | none |
| N8 | Number | gap 1259×1.5/3 = 630 Mpc; reversed D_A = 2194 Mpc | ✅ PASS | B13b, B13d; critic L2b | none |
| N9 | Number | B = 0.743; d lnB/dw0 = −0.032; 0.3% for Δw0 = 0.1 | ✅ PASS | B15b, B15d (ran: 0.74283, −0.03165); critic L5 (0.742828, −0.031647; B(−0.9)/B(−1) − 1 = −0.32%) | none |
| N10 | Number | efficiency peak z_d = 0.35 (z_s = 1), χ_d/χ_s = 0.42; z_d = 0.52 (z_s = 2) | ✅ PASS | B16a, B16c; critic F8b (0.3504, 0.4167), F8c (0.5187) | none |
| N11 | Number | 𝒟 strictly decreasing in z_d (z_s = 1) | ✅ PASS | B16d; critic F8a | none |
| N12 | Number | c²/4πG = 1.07e26 kg/m; 1.663e12 M☉ kpc⁻² per Mpc⁻¹; Q0957 Σ_cr 2.4e9 | ✅ PASS | B17a–b (ran) | none |
| N13 | Number | θ_E = 2.85″ (M/10¹²)^{1/2}(𝒟/Gpc⁻¹)^{1/2}; Q0957 0.64 → 2.3″; Ex 3.5 0.695 → 2.38″; R_S = 0.096 pc | ✅ PASS | B19d–f, B24a (ran); critic F5 | none |
| N14 | Number | open H0 t0 = 0.809, 11.30 Gyr, ratio 1.19; flat closed form 0.964 = 13.47 Gyr | ✅ PASS | B18a–b, B23b (ran); critic F6a–c | none |
| N15 | Number | Q0957: 1038×1.05/2.41 = 452 ≈ 1155 − 702 | ✅ PASS | B23a (ran) | none |
| N16 | Number | Ω_r(1+z)/Ω_m ≈ 10⁻³ at z = 3 "for the values above" | ✅ PASS | B20c (1.2e-3); Ω_r ≈ 9e-5 at chapter line 676 | none |
| X1 | Consistency | layer "Bookkeeping check": combining eq:R00 (x⁰ = ct) with g_tt, T_tt (x⁰ = t) "picks up a stray 1/c²" | ⚠ SUSPECT (imprecise) | critic F1g: straight mixing leaves an uncancelled ä term, 3(c²−1)ä/(c²a). The uniform stray 1/c² in visible eq:lhs_00 needs a *second* slip: −½R g_00 evaluated as (3/c²)(…) instead of 3(…) | "…leaves an uncancelled ä term; visible eq:lhs_00 also evaluates −½R g_00 as (3/c²)(…), which hides it." Or drop the sentence once V1 is fixed |
| X2 | Consistency | open-model annotation: "without Λ … the Hubble time overstates the age by less" | ⚠ SUSPECT (wrong comparison) | critic F6a–c: H0 t0 = 0.809 (open) vs 0.964 (concordance), so t_H overstates the open age by *more* (24% vs 4%). The statement is true only against EdS (0.667) | "without Λ the expansion has always decelerated, so the age is a smaller fraction of the Hubble time (0.81 t_H vs 0.96 t_H)." |
| X3 | Consistency | annotation says the Ex 3.2(c) script block includes Ω_k(1+z)² | ✅ PASS | `problems_03.wl:47` Efunc has (1−Om−OL)(1+z)² | none |
| X4 | Consistency | "matching the caption of Fig. DA_vs_z" (1748 Mpc, z ≈ 1.6) | ✅ PASS | `03_Cosmological_Distances.tex:1044` | none |
| X5 | Consistency | `\ref{ch:cosmological_sensitivity}`, `ch:multiplane_dspl` | ✅ PASS | aux: ch. 24 "Cosmological Sensitivity of Compound-Lens Ratios"; ch. 18 "The Multi-Plane Lens Equation and Double-Source-Plane Lenses" | none |
| X6 | Consistency | problems_03 visible printout "R_E peaks at z_d = 0.36" vs layer "0.35" | ⚠ SUSPECT (grid artefact, script output only) | `problems_03.wl:264` grid step 0.02 (0.34/0.36 bracket the true 0.3504); not in any .tex | optional: refine the grid or print FindMaximum |
| P1 | Prose | "It is not a small correction." | ⚠ SUSPECT (negation closer) | read | drop it; "more than the 'answer' 468 Mpc itself" already makes the point |
| P2 | Prose | "comfortably below 1" | ⚠ SUSPECT (mild intensifier) | read | "below 1" |

**Proof of D6.** In a flat universe D_d = χ_d/(1+z_d), D_s = χ_s/(1+z_s) and
D_ds = (χ_s − χ_d)/(1+z_s). Then
D_ds − D_s + D_d = −χ_d/(1+z_s) + χ_d/(1+z_d) = χ_d[(1+z_s) − (1+z_d)]/[(1+z_d)(1+z_s)]
= D_d (z_s − z_d)/(1+z_s). This is > 0 for z_s > z_d and holds for any expansion history
(critic L2, symbolic in χ_d, χ_s).

### Author's flags on VISIBLE text (adjudicated)

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| V1 | Derivation | eq:R00 `R_00 = −3ä/(c²a)` (line 312), "Substituting R_00 = −3ä/(c²a), g_00 = −c² … T_00 = ρc⁴" and eq:lhs_00 (440–458); 03_Solutions.tex:38 and 84–87 | ❌ FAIL (author correct) | critic F1a–h: with the chapter's own g_00 = −c², T_00 = c⁴ρ (x⁰ = t), R_00 = −3ä/a and LHS = 3(ȧ²/a² + kc²/a²) − Λc². Printed eq:lhs_00 = (3/c²)(…) − Λc² ≠ that (F1e). Setting the printed LHS = 8πGρ gives H² = c²(8πGρ + Λc²)/3 − kc²/a², which is **not** the boxed eq. (F1f) | see Flagged |
| V2 | Consistency | friedmann_equations.wl "verifies" R_00 and Friedmann I | ❌ FAIL (author correct) | ran it: line 193 prints `Difference = (-3*(-1 + c^2)*a'')/(c^2 a)` (nonzero); `friedmann1LHS/RHS` (lines 251–252) are defined and never compared; line 253 just prints "Verified". Its own LHS print (`-(c^2 Λ) + 3(c^2 k + a'^2)/a^2`) contradicts visible eq:lhs_00 | see Flagged |
| V3 | Number | 03_Solutions:199–200 "t0 ≈ 11.0 Gyr … ∼23% older" | ❌ FAIL (author correct) | critic F6a–b: H0 t0 = 0.8088, t0 = 11.30 Gyr; 13.47/11.30 = 1.192. problems_03.wl itself prints 11.30 | "t0 ≈ 11.3 Gyr … ∼19% older" |
| V4 | Number | 03_Solutions Ex 3.3(a) table: 1.61/1770; 1.25/1180; 1.44/1300 | ❌ FAIL (author correct) | critic F7a–d; B12a,e,f | see Flagged |
| V5 | Derivation | §Distance ratio (1278–1281): "The distance ratio is maximized … when the lens is roughly halfway" | ❌ FAIL (author correct) | critic F8a (𝒟 strictly decreasing on z_d ∈ [0.02, 0.98], z_s = 1); F8b (efficiency peaks at χ_d/χ_s = 0.417, z_d = 0.350) | see Flagged |
| V6 | Derivation | efficiency text (1320): "proportional to the square of the Einstein radius (at fixed mass)"; Fig. caption (1333) "roughly 'halfway' (in comoving distance)" | ⚠ SUSPECT | F8b: ℰ ∝ R_E² (physical), not θ_E² (the next sentence of the text says so); peak at 0.42 χ_s, not 0.5 | "square of the physical Einstein radius R_E = D_d θ_E"; caption "somewhat closer to the observer than the comoving midpoint (χ_d ≈ 0.42 χ_s for z_s = 1)" |

## Applied (auto-fixes)

None. The brief forbids visible-text edits, and every number in the new layer passed.

## Flagged — your hand required

- **V1. R_00 / eq:lhs_00 coordinate mix (03_Cosmological_Distances.tex:312, ~437–458;
  03_Solutions.tex:38, 84–87). FAIL. The boxed Friedmann I is correct but does not follow
  from eq:lhs_00 as printed.** The chapter fixes x⁰ = t (g_00 = −c², U⁰ = 1,
  T_00 = c⁴ρ). In that coordinate R_00 = −3ä/a (critic F1a; B2a). −3ä/(c²a) is the
  x⁰ = ct component. Printed eq:lhs_00 then evaluates −½R g_00 as (3/c²)(ä/a + ȧ²/a² + kc²/a²),
  but with g_00 = −c² it is 3(…). The two slips cancel ä but leave a 1/c² on the geometric
  terms and not on Λc². Equating to 8πGρ gives H² = c²(8πGρ + Λc²)/3 − kc²/a² (F1f), not
  the boxed result. **Minimal fix (keep x⁰ = t):**
  eq:R00 → `R_{00} = -\frac{3\ddot a}{a}`;
  "Substituting R_00 = −3ä/a, g_00 = −c², …";
  eq:lhs_00 line 1 → `-\frac{3\ddot a}{a} + 3\left(\frac{\ddot a}{a} + \frac{\dot a^2}{a^2} + \frac{k c^2}{a^2}\right) - \Lambda c^2`,
  line 2 → `3\left(\frac{\dot a^2}{a^2} + \frac{k c^2}{a^2}\right) - \Lambda c^2`.
  Dividing by 3 then gives eq:friedmann_1 directly (F1d). Make the same two edits in
  03_Solutions.tex:38 (R_00) and :84–87 (first line of (c)). R_ij, R_11–R_33 and R are
  unaffected: spatial components and the scalar do not depend on the x⁰ convention
  (F1b; B2c–e). Carroll eq. 8.45 is in c = 1 units, so the "(Carroll eq. 8.45)" attribution
  survives. Optionally add "(x⁰ = t)" next to it. After the fix, the layer box after
  eq:ricci_scalar_frw ("the form −3ä/(c²a) of eq.~(R00) is the component with respect to
  x⁰ = ct") and the "Bookkeeping check" paragraph (X1) must be reworded, because they
  describe the current visible form.
- **V2. `Mathematica/03_Cosmological_Distances/friedmann_equations.wl` never asserts.
  FAIL. Confirmed.** Line 190 sets `R00expected = -3 a''[t]/(c^2 a[t])`, and line 193
  prints the nonzero `Difference = (-3*(-1 + c^2)*Derivative[2][a][t])/(c^2*a[t])`
  (output captured in scratchpad `run_friedmann.log`). Lines 251–254 define
  `friedmann1LHS`/`friedmann1RHS` and print "Verified" without comparing them. The script
  computes the correct LHS (line 241 prints `-(c^2 Λ) + 3(c^2 k + a'^2)/a^2`), which
  contradicts the visible eq:lhs_00. **Fix:** `R00expected = -3 a''[t]/a[t]`; turn both
  "Difference" prints and the Friedmann I step into `check[]` asserts with a SUMMARY line.
  `Solve` on `lhs00 == 8 Pi G rho` for ȧ² should reproduce `friedmann1RHS`. As it stands
  the script is not evidence for the visible equations. VERIFICATION.md should not count
  it as a passing check until it asserts.
- **V3. Ex 3.2(c) (03_Solutions.tex:199–200). FAIL.** The open model (Ω_m = 0.3, Ω_Λ = 0,
  Ω_k = 0.7) has H0 t0 = 0.8088, so t0 = 11.30 Gyr (critic F6a; problems_03.wl prints
  11.2979). Concordance/open = 13.47/11.30 = 1.19 (F6b). **Fix:** "t0 ≈ 11.3 Gyr. The
  concordance cosmology gives a universe that is ∼19% older". "23%" corresponds to the
  wrong 11.0 Gyr.
- **V4. Ex 3.3(a) turnover table (03_Solutions.tex:222–224). FAIL.** Computed (critic F7,
  FindMaximum on D_A):
  | Cosmology | z_max | D_A,max (Mpc) | visible |
  |---|---|---|---|
  | Concordance (0.3, 0.7) | 1.605 | 1748 | 1.61 / 1770 |
  | EdS (1, 0) | 1.25 (exact 5/4) | 1269 (= (8/27)c/H0) | 1.25 / 1180 |
  | Open (0.3, 0), D_M with sinh | 1.90 | 1583 | 1.44 / 1300 |
  | (Open, wrong χ/(1+z), curvature dropped) | 1.47 | 1445 | — |

  **Fix:** replace the three rows with 1.61 (or 1.605)/1748, 1.25/1269, 1.90/1583.
  Part (c) "z_max ≈ 1.61" is fine at two decimals (1.6054). Neither visible open-row value
  matches either computation. **Script:** `problems_03.wl:52`
  `DAFunc[z_, Om_, OL_] := chiFunc[...]/(1+z)` ignores curvature in D_M. The curvature
  term sits in `Efunc` (line 47) but not in the transverse distance. Lines 158–171 also
  use a 0.1 grid, so they print "EdS z_max=1.3", "Open z_max=1.5, 1445". **Fix:** add
  `DMFunc` with `(dH/Sqrt[Ok]) Sinh[Sqrt[Ok] chi/dH]` for Ok > 0, use it in `DAFunc`, and
  use FindMaximum instead of the grid. The layer box already documents the sinh value, and
  B12f asserts it.
- **V5. §Distance ratio (03_Cosmological_Distances.tex:1278–1281). FAIL.** At fixed z_s,
  𝒟 = D_ds/(D_d D_s) diverges as z_d → 0 and falls monotonically to 0 at z_d = z_s
  (critic F8a; B16d). It is not maximised anywhere in between. The quantity that peaks is
  the efficiency ℰ = D_d D_ds/D_s: for z_s = 1 the peak is at z_d = 0.350, χ_d/χ_s = 0.417
  (F8b); for z_s = 2 at z_d = 0.519 (F8c). **Fix:** "𝒟 decreases monotonically with z_d at
  fixed z_s (θ_E is largest for the nearest lenses). The physical Einstein radius, through
  the efficiency D_d D_ds/D_s of the next section, peaks at intermediate z_d, a little
  short of the comoving midpoint (χ_d ≈ 0.42 χ_s for z_s = 1)." Then the layer's "Careful
  with 'maximised'" paragraph can shrink to one line.
- **V6. Efficiency wording and caption (lines 1320, 1333). SUSPECT, minor.** See the table
  for proposed text.
- **C1. CPL annotation citation (layer, 03_Cosmological_Distances.tex, "When w is not
  constant: the CPL form").** The box names "Chevallier–Polarski–Linder (CPL)" with no
  citation. The bib now has `chevallier_polarski_2001` (CrossRef 10.1142/S0218271801000822:
  "Accelerating Universes with Scaling Dark Matter", Chevallier & Polarski, IJMPD 10,
  213–223, 2001) and `linder_2003` (CrossRef 10.1103/PhysRevLett.90.091301: "Exploring the
  Expansion History of the Universe", Linder, PRL 90, 091301, 2003). Both bib entries match
  CrossRef on title, authors, venue and year. **Suggestion (not applied):** add
  `\citep{chevallier_polarski_2001, linder_2003}` after "(CPL) form". Support for the exact
  parametrisation w0 + wa(1−a) was not checked against full text (no full text in
  Reference_Texts), so treat it as existence-confirmed.
- **N4 and X2 (layer physics wording).** See the table: the "accelerating" explanation for
  χ < cz/H0 is backwards, and "overstates the age by less" compares against the wrong
  model.

## Prose (LLM tells) — flag-only

New-layer words added: 03_Cosmological_Distances.tex 2825, 03_Solutions.tex 1036.
Em-dashes: 0 and 0. Antithesis hits: 2 ("probe of dark energy rather than of H0", which is
physical and should stay; "It is not a small correction", P1) and 0. No ornamental triads.
The layer reads as plain worked algebra. Only P1 and P2 are worth touching.

## Derivation checks

Scratch script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0203/critic_0203.wl`
(log `critic_0203.log`). `SUMMARY: 42 PASS, 0 FAIL  (of 42 checks)`. Module-03 rows:

| check | content | result |
|---|---|---|
| F1a–b | independent Γ → Ricci for g = diag(−c², a²/(1−kr²), a²r², a²r²sin²θ): R_tt = −3ä/a; R = (6/c²)(…) | PASS |
| F1c–d | consistent LHS = 3(ȧ²/a² + kc²/a²) − Λc² ⇒ boxed Friedmann I | PASS |
| F1e–f | printed eq:lhs_00 ≠ consistent LHS; it yields H² = c²(8πGρ + Λc²)/3 − kc²/a² | PASS (confirms visible error) |
| F1g | mixing R_00(x⁰ = ct) with g_00 = −c² leaves +3(c²−1)ä/(c²a) | PASS |
| F1h | fully x⁰ = ct (g_00 = −1, T_00 = c²ρ) gives the same boxed equation | PASS |
| F6a–c | open H0 t0 = 0.8088 (11.30 Gyr); ratio 1.192; flat closed form 0.96410 = numeric | PASS |
| F7a–d | turnovers 1.605/1748; 1.25/1269; open sinh 1.90/1583; open χ/(1+z) 1.47/1445 | PASS |
| F8a–c | 𝒟 strictly decreasing; efficiency peak 0.350 (χ ratio 0.417), 0.519 for z_s = 2 | PASS |
| L1–L1b | CPL closed form from the integral; ζ ≡ 1 for ΛCDM | PASS |
| L2–L2b | flat identity D_ds − (D_s − D_d) = D_d(z_s−z_d)/(1+z_s) symbolic; 630 Mpc | PASS |
| L3 | EdS s = 2/3, z = 5/4, (8/27)d_H = 1269 Mpc | PASS |
| L5 | B(0.3, 0.8, 2.0) = 0.742828; d lnB/dw0 = −0.03165 | PASS |
| L9a–c | χ(0.1): ΛCDM 418.45, EdS 398.62, pure Λ 428.27 = cz/H0; D_A(0.5,2) = 1097/1072/1047 | PASS |

Repo: `problems_03.wl` → `SUMMARY: 76 PASS, 0 FAIL  (of 76 checks)`. Its pre-existing
(non-check) printout still shows the curvature-free open turnover and the coarse grid
(V4). `friedmann_equations.wl` has no assertions (V2).

## Resolution — fixes applied 2026-10-14

| id | Fix | Backing |
|----|-----|---------|
| V1 | eq:R00 → R₀₀ = −3ä/a; intro now says "Carroll eq. 8.45, restoring c with x⁰ = t" + footnote recording the old −3ä/(c²a) (the x⁰ = ct component) and the mixed bookkeeping; "Substituting R₀₀ = −3ä/a"; eq:lhs_00 → −3ä/a + 3(ä/a + ȧ²/a² + kc²/a²) − Λc² = 3(ȧ²/a² + kc²/a²) − Λc². 03_Solutions (b) R₀₀ = −3ä/a (x⁰ = t); (c) first line 3(…) − Λc². Layer box "R₀₀ and R by hand" and the R₁₁ box reworded; "Bookkeeping check" (X1) now says mixing leaves an uncancelled ä term. | `friedmann_equations.wl` F2a (R₀₀ = −3ä/a), F2b (fails on −3ä/(c²a)), F3a (LHS), F3b (old printed LHS ≠ LHS), F3c, F3d (Solve → eq:friedmann_1); problems_03 B2a–b, B2f–g |
| V2 | `friedmann_equations.wl`: harness loaded, R00expected = −3a''/a, every "Difference"/"Verified" print → check[] (F1a–c Christoffels, F2a–e Ricci/R, F3a–e Friedmann I and II), ends with summary[]. Figure dir made relative to the script (it was hard-coded to the main checkout, so a worktree run wrote into the main repo's Figures/). Figures regenerated byte-only and reverted. | `SUMMARY: 13 PASS, 0 FAIL  (of 13 checks)` |
| V3 | Ex 3.2(c): t₀ ≈ 11.3 Gyr, concordance ∼19% older | B26 (fails on 11.0 / 23%); B18b, B23b |
| V4 | Ex 3.3(a) table: 1.605/1748; 1.25/1269; open (D_M with sinh) 1.90/1583. `problems_03.wl`: new `DMFunc` (sinh/sin by sign of Ω_k), `DAFunc` = D_M/(1+z); exercise block uses FindMaximum instead of the 0.1 grid; layer box sentence about DAFunc updated. | B25a–c (fail on 1770, 1180, 1.44/1300), B25d (flat unchanged); B12a, e, f |
| V5 | §Distance ratio: 𝒟 decreases monotonically with z_d; the efficiency peaks short of the comoving midpoint (χ_d ≈ 0.42 χ_s, z_s = 1), with footnote recording the old "maximized halfway" sentence. Layer "Careful with 'maximised'" shrunk to one line. Same claim fixed in the chapter Summary bullet and 03_Solutions Ex 3.5(d) ("roughly midway" → "a little short of the comoving midpoint"). | B27a (z_d = 0.350, χ_d/χ_s = 0.417 ≠ 0.5); B16a–d |
| V6 | "square of the physical Einstein radius R_E = D_d θ_E"; Fig. lensing_efficiency caption: "somewhat closer to the observer than the comoving midpoint (χ_d ≈ 0.42 χ_s for z_s = 1)" | B27a |
| N4 | "2% high, because H(z) > H₀ at z > 0 (χ ≈ (c/H₀)[z − (1+q₀)z²/2]); in a decelerating EdS universe the gap would be 7%" | B28a (second-order form within 0.1%), B28b (gaps 2%/7%/0) |
| X2 | "the age is a smaller fraction of the Hubble time (0.81 t_H versus 0.96 t_H)" | B29 |
| C1 | CPL box: `\citep{chevallier_polarski_2001,linder_2003}` | bib keys (CrossRef-matched by critic) |
| X6 | problems_03 R_E-peak printout via bounded FindMaximum (prints 0.350, not the grid 0.36) | printout |
| P1, P2 | "It is not a small correction." dropped; "comfortably below 1" → "below 1" | prose |

**Verification after edits.** Before: `problems_03.wl` → `SUMMARY: 76 PASS, 0 FAIL  (of 76 checks)`;
`friedmann_equations.wl` had no SUMMARY. After (`bash Mathematica/run_wl.sh …`):
`problems_03.wl` → `SUMMARY: 85 PASS, 0 FAIL  (of 85 checks)`;
`friedmann_equations.wl` → `SUMMARY: 13 PASS, 0 FAIL  (of 13 checks)`.
`ANNOT_REQUIRED=1 bash build.sh` → "all assertions passed"; Student 360 pp, Instructor 444 pp,
Annotated 569 pp.

**Left open.**
- CPL parametrisation w₀ + w_a(1−a) not checked against the full text of either paper
  (existence-confirmed only, per the critic).
- `DdsFunc` in problems_03.wl remains the flat formula (commented as such); it is only called
  with flat models.
- VERIFICATION.md should now count `friedmann_equations.wl` as an asserting script (orchestrator).
