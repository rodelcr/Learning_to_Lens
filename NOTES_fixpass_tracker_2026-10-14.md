# Visible-text errors flagged by Phase-1 agents (adjudicate via critics, then fix with .wl check + Resolution)
## From ann01abc
- 01b Ex 1.4 solution: "dφ/dλ=0 ⇒ dV^μ/dλ=0, components constant" wrong; Γ^φ_θφ=cotθ ⇒ V^φ ∝ 1/sinθ (box has check). Path wording loose.
## From ann1013
- 13.1(b): μ± bracket form gives μ₋>0; signed μ₋ = −(A−1)/2.
- 10.1(d): "1/r inner slope ⇒ M(<r) ∝ r" wrong: 3D M ∝ r², projected ∝ R² ln(1/R).
- 10.5: γ_t≈κ̄ "within 10%" inconsistent for γ_t ∝ θ^−0.8 (κ̄ = 2.5γ_t ⇒ M(5′)≈1.1e15); "κ ≪ κ̄ at large radii" false (κ/κ̄=0.6).
- 10.2 script ray-trace finds 0 pixels at β=0.5,0.95 θ_E (pre-existing, admitted).
- 12.5(d) "ℓ ∼ 5/θ": peaks at η≈4.10 / 4.49 (unannotated).
## From ann0607
- 06 eq delta_t_schwarzschild, Example ex:point_mass_numerical, Sol 6.2(d): 4GM/c³ = 2R_S/c not R_S/c → 299 d not 149 d. Also time_delay_function.wl + problems_06.wl body repeat R_S/c.
- Sol 6.3(b) table wrong at y=0.1,1,2 (0.2001, 2.0805, 4.5912); Δτ(0.5)=1.0103.
- 06 Shapiro-sign remark "deeper potential arrives earlier" wrong (always a delay).
- Sol 6.3(a) "by definition τ(min) ≤ τ(saddle)" invalid argument.
- Sol 6.4(b): χ_s 0.771, χ_ds 0.493, factor 0.336 (text 0.778/0.499/0.334); H0 unaffected.
- Sol 7.3 uses 900/1700/1200 Mpc vs exercise 920/1650/1055 → θ_E 1.15″ not 1.27″. (May-2026 audit fixed Mod 3/4 to 919/1652/1055 — 7.3 was missed.)
- Sol 7.3(d) point-mass θ_E for 1e12 M☉ ≈ 2.4″ not 1.1″.
- Sol 7.5(a) small-x: f ≈ ln(2/x) − 1, not (1/x)ln(2/x).
- Ch 07 "inside the radial caustic (and inside the tangential caustic)" misleading for axisymmetric NIS.
- Sol 7.4(c) hint "≥" should be strict.
- Annotations in 06/07 say "flagged for correction" in 4 places — drop once fixed.
- Missing bib: Bartelmann 1996 A&A 313, 697 (UNVERIFIED).
## From ch15 (source-note errors, corrected in chapter — feed back to spiral project)
- note2: SIS+PM "seeds a faint central counter-image" (root on wrong branch) — wrong; exactly two images.
- note2b §3: t₁→2 limit at fixed θ_B collapses whole lens to point mass; correct = joint limit θ_B→0.
- "[check 5q]"-style labels visible in student edition → move to \annot{}.
## From ch20
- Brief's "fixed-Ω_m |Δw| is a lower bound" false in general (holds only for c ∈ [2c*,0]); source note .wl calls it over-claim.
## From ch21
- source note "B_i→0 = source plane infinitely far" wrong (B_i > d₁). Source-plane vs image-plane c differ a lot (10.47 vs 2.08) — critic to check.
- Brief pointed to module 11 for least-squares: it has none.
## From ch19
- notation clash \mBH (m) vs multipole order m → chapter uses f_•; synergy review.
- uncited: per-cent isophote departures; γ'≈1.4–1.5 typical with central images.
## From ann0405
- 04_Solutions Ex 4.3(a): 4GM/c² written 5.906e−10 instead of 5.906e3 m → θ_E 0.28 mas / R_E 14 AU wrong; correct 4.38e−9 rad = 0.90 mas, R_E = 4.5 AU.
- 04 Ex 4.3(c): statement M=1e15 vs solution 2e14 (37″ vs 83″).
- 04_Solutions Ex 4.5 table β=0.1″ row has the β=0.05″ values (+1.025/−0.975, Δθ 2.000); correct +1.0512/−0.9512, Δθ 2.0025.
- 05 Properties of μ item 3: "|μ|>1 iff (1−κ)²−γ²<1" incomplete → |det A| < 1.
- 05 pure convergence "κ>1 still magnified" fails for κ>2.
- 05 pure shear φ_γ = ½ arctan(γ₂/γ₁) wrong by 90° for γ₁<0 → atan2.
- 04 "κ<1 everywhere ⇒ no multiple images" only axisymmetric (C&K §2.5).
- 04 Σ_cr 2840 uses c=3e8 (2837); 2833 with 2.998e8 (negligible).
## From ch18
- Spiral Reference_papers: `Schneider2014_multiplane_MST.pdf` is actually arXiv:1409.0015 (= Schneider 2019 A&A 624 A54); `SchneiderSluse2013_SPT.pdf` is the 2014 SPT paper (A&A 564 A103). Feed back.
- Birrer2020 numbers + Schneider&Sluse 2013 attribution from arXiv abstracts only; ξ invariant unattributed; Jeans F(γ',ν,β_a) own derivation (checked k4–k10c).
- Optional bib: Bradač, Lombardi & Schneider 2004 A&A 424, 13 (UNVERIFIED).
## From ann01de
- 01d: two normalisations of E (𝓔 = ½(E²−εc²) needs E = f c dt/dλ; photon_orbit & b = cL/E need E = f c² dt/dλ); eqs conserved_E/normalization c=1 vs V_eff explicit c.
- 01d_Solutions Ex 4: 5.01e−7 rad / 0.1034″ → 5.020e−7 / 0.10355″; 0.1034×415.2=42.93 not 43.0 (chapter values 5.02e−7, 0.104″ correct).
- 01d_Solutions Ex 5(b): "small angle" — for L=4 advance ≈ 2.60 rad ≈ 149°/orbit.
- 01e_Solutions Ex 2(b): "(1+R_S/r)dr²+r²dΩ² vs (1+R_S/r)(dr²+r²dΩ²) differs at second order" — it's first order (R_S r dΩ²); needs isotropic radius.
- 01e eq lens_equation_preview: β = θ − (D_ds/D_s)α with α = (D_d/D_s)α̂ inconsistent with Ch 4 (α = (D_ds/D_s)α̂).
- 01e_Solutions roundings: 3.94″ → 3.95″; 9.58e−17 → 9.572e−17.
- 01e Cassini "|γ−1| < 2.3e−5" likely paraphrase of (2.1±2.3)e−5 (UNVERIFIED); "Will 1993/2014", "Weinberg 1972" plain-text cites without keys.
- 01e intro "|Φ|/c² ~ 1e−4 only near cluster cores r≲100 kpc" unchecked.
- Optional bib: Bardeen, Press & Teukolsky 1972 ApJ 178, 347 (Kerr ISCO) UNVERIFIED.
## From ann0203
- 03 eq R00 / lhs_00 mix x⁰=t vs ct conventions; boxed Friedmann I correct; friedmann_equations.wl only prints "Difference", never asserts.
- 02_Solutions Ex 2.2(b): n ≈ (1+2m/r)/(1−2m/r) ≈ 1+4GM/(c²r) — square root missing; correct 1+2GM/(c²r); "Newtonian n = 1+2GM/(c²r)" should be 1+GM/(c²r). problems_02.wl prints same error.
- 02_Solutions Ex 2.1(b): "φ± = π ∓ δ, sinδ = 1/e" inconsistent; should be φ∞ = ±(π/2+δ).
- 02 ex:shapiro_sun: formula without "+1" gives 220 μs not 240.
- 02 remark eq einstein_radius_deflection: "θ_E ~ 1″" for 1e12 M☉ z 0.3→1 vs Ex 3.5's 2.4″.
- 03_Solutions Ex 3.2(c): open-model age 11.30 Gyr (H0t0=0.809) not 11.0; ratio 1.19 not "23%".
- 03_Solutions Ex 3.3 table: EdS D_A,max = (8/27)c/H0 = 1269 Mpc not 1180; open (sinh) z_max=1.90, 1583 Mpc (table 1.44/1300 matches nothing); concordance 1748 Mpc at z=1.605 not 1770/1.61. problems_03.wl DAFunc ignores curvature for open models.
- 03 §Distance ratio: "𝒟 = Dds/(DdDs) maximized halfway" wrong — 𝒟 strictly decreasing in z_d; efficiency DdDds/Ds peaks at χd/χs≈0.42 (zs=1).
- Minor: Soldner 4.246e−6 rad = 0.876″ (text 4.24e−6/0.875″); 02 solution flat-path 2(R⊕+RM)/c vs √(R²−r0²); "Shapiro 1964 measurement 200±20 μs" — 1964 was prediction paper (UNVERIFIED).
## From critic 01abc (confirmed)
- 01b Ex 1.4 visible text WRONG (confirmed by R³-embedding transport); proposed replacement text in report. Next paragraph's rotation explanation loose (holonomy comes from the pole).
- 01c: R_S☉ 2953 → 2954 m (lines ~205, 221–222), 4.24 → 4.25e−6 (207, 279); tighten problems_01c.wl to Round[RSsun]==2954.
- 01a box N3: "v1=1 gives v=1 for any v2" → "for any |v2|<1"; 01b box N10 overstated factor-2 claim; 01c box N16 "stays finite as r→R_S"; prose P1/P2 in boxes.
## From ch16 (source-note errors corrected in chapter — feed back to spiral project)
- note4: "central BH makes odd count drop from three toward one" wrong — with one point mass the count is EVEN (2 or 4), SEF §5.4.1 / PLW Thm 11.4; n₊−n₋+g = 1.
- sol_note4: τ → −∞ at a point mass — it goes to +∞.
- note4 keybox: central maximum merging with the radial saddle at the boundary — actually merges with the BH-created saddle; at critical mass the two radial critical circles merge.
- note4 Ex 4: "point mass changes image count by an even number" — it is odd (N+g stays odd).
- New closed forms (θ•,crit, y_in ≈ 2θ•√(κ₀−1)) are the chapter's own, Mathematica-checked, not MWK01's.
- Winn, Rusin & Kochanek 2004 Nature (central image PMN J1632−0033) UNVERIFIED, not cited; Keeton 2003 not cited for μ_c ~1e−3.
## From ann0809
- 08 Step 4 display (~line 405): the two intermediate derivatives wrong individually (sum correct): ∂1α1 = θE√q θ2²/(θ²F), ∂2α2 = θE√q θ1²/(θ²F).
- 08 Stage 1 "far outside all caustics … two images" — SIE outside the cut gives ONE image.
- 08_Solutions Ex 8.4(b): positions (0.53,0.79), (−0.37,−0.52) don't match script (0.358,1.195), (−0.564,−0.547); cusps ≈0.1″ loose (0.159, 0.139).
- 08_Solutions Ex 8.1(b): "ellipse" vs chapter's "oval".
- 09 remark after eq mst_H0: "steeper than assumed reduces H0^true" backwards (λ<1 ⇒ true profile shallower).
- 09 "10% mass sheet shifts H0^naive downward by 10%" ambiguous.
- 09 ~lines 630–631: sentence fragment "…galaxy_lensing.wl. and the Einstein radius is:"; "normalization by matching to isothermal" is really κ̄(θE)=1.
- 09 "∇·(θ/2) = 1 = 1 − λ up to the overall factor" garbled.
- 09_Solutions Ex 9.2(d): |θ|² term cancels within each image, not between.
- D_Δt convention inconsistent: eq time_delay_recap vs Ex 9.3/script (1+z_d).
- 09_Solutions Ex 9.4(d): script assumes z=(0.3,1.0) not given; γ'≈2.0–2.1 not computed.
- Own derivations unattributed: η' = λη/[1−η(1−λ)], γ'_eff = γ'+f(3−γ'); "cut", naked-cusp 0.394 uncited.
## From ch14
- note1b "same-plane external shear cancels approximately" → exactly if reduced shear scales 1/B (checks 7b–7c).
- note1 ln 0.79 example inconsistent with any geometry.
- Bib UNVERIFIED: Kovner 1987 ApJ 316, 52; Gavazzi+2008 ApJ 677, 1046 (Jackpot).
## From ch17 (feed back to spiral project)
- sol_note3_smbh_bias.tex: "u_crit precludes a closed form" WRONG: θ* = [(2−γ')(3−γ')/2]^(1/(γ'−1)), m_crit = ½(2−γ')(γ'−1) θ*^(3−γ'); max m_crit = 0.0066 at γ'≈1.48 (checks D4, D5).
- fixed-slope estimate m₁(1−B^p): 0.3% near ring, ×1.75 off at 0.3θ_E; with free γ' + radial image net −4.26 m₁ (sign set by slope channel) — "in this configuration" only.
- S_w = −0.033 own calc (flat wCDM, Ωm=0.3, z=0.5/1/2).

# ===== CRITIC VERDICTS (fix pass input) =====
## ch19 critic (22 PASS / 2 FAIL / 9 SUSPECT; all numbers+derivations PASS)
- F1 soften uncited isophote per-cent claim (option a wording in report).
- F2 rewrite "γ'≈1.4–1.5 typical…" → "shallow slopes used as examples (γ'<2 needed for radial critical curve)".
- F3 drop/soften code-convention claims; keep the imperative.
- F4 (FAIL X5) §8.2 "cannot be absorbed by θE, γ' or any monopole" contradicts §6 partial-arc overlap → rewrite per report.
- F5 add one main-text sentence "linearised toy… illustrates radial ordering" (caveat currently only in annotation box).
- F6 (FAIL X7) dipole remark: "Away from γ'=2" → "For γ' < 2".
- F7 bridge to ch17 wording re-check now ch17 exists.
- F8 "Theorem again" wording; bridge sentence to Ch 12 §which_multipoles.
- P1–P6 prose rewrites (in report).
## critic 01abc (see earlier): 01b Ex 1.4 visible text FAIL → replacement text in report; 01c roundings 2953→2954, 4.24→4.25; box wording N3/N10/N16/P1/P2.
## ch14 critic (46 PASS / 4 SUSPECT / 3 FAIL [rounding, auto-fixed η 0.6453, lnη −0.4381]; derivations 5/5)
- F1 radial/central image "most direct handle on inner slope" uncited; conflicts with Ch 20's "constrains a combination" → add kinematics + arc thickness as equal anchors.
- F2 collett_2012 cite doesn't support per-triplet orientation clause → detach or confirm in full text (arXiv 1203.2758).
- F3 SEF footnote wording → "unpublished (private-communication) numerical two-point-mass test".
- F4 kormann_isothermal_1994 normalisation unchecked (no PDF) — low stakes; attach PDF later.
- F5 optional: η in Ex 7(b) means ratio of fitted parameters (critical-curve ratio 0.6775 vs B 0.6742 with shear).
- bib comment lines sit above the wrong entry? (critic says comment for stu1190 precedes collett_auger_2014 but follows collett_2012 — CHECK: that's actually correct placement; verify.)
- 6 prose items in report.
## ch20 critic (43 PASS / 11 SUSPECT / 2 FAIL [X2 auto-fixed label; X7 CPL cite]; derivations 6/6; external-probe bias claim CONFIRMED)
- C7/X7 add \citep{chevallier_polarski_2001,linder_2003} at CPL (lines ~120–121); update .wl header comment lines 7–8.
- C3 Schneider 2014 paraphrase: add "in which the nearer source also acts as a deflector".
- C8/N25 don't call 1/F_ww ≤ (F⁻¹)_ww "Cramér–Rao"; "error" → "variance" (lines ~488–492; Solutions ~78).
- X8 D_Δt definition (line ~560) add (1+z_d).
- X11 sign of δ_i requires per-plane responses r_i to share sign — add proviso or cite Ch 25.
- C2 optional orthogonality remark; N13 optional grid scan in F0c.
- P1–P5 prose.
## ch21 critic (33 PASS / 10 SUSPECT / 0 FAIL; algebra all PASS)
- F1 radial-image leverage story holds only for source-plane/unit-weight fits (image-plane: no divergence, non-monotonic, sign change reverses at ρ*=0.065) → label statements + add 2–3 sentences.
- F2 validity criterion too weak → add radial-image fractional shift m·a_C/(λ_C θ_C) ≈ 640 m.
- N5 "c = 10.47" → 10.46 (or say perturbed images). X3 "returns to total-mass value" → "for the canonical triple". fig:pe_corrfactor never \ref'd. .wl header "the figure" → two.
## ch16 critic (32 PASS / 13 SUSPECT / 0 FAIL; all 4 source-note corrections CONFIRMED)
- X5 "point mass is transparent" contradicts Ch 6 thm:odd_number definition → drop/qualify.
- X6 power-law cusp "continuous and bounded" — not bounded; add "|α|/θ → 0 at infinity" (SEF p.174) or truncation.
- X7 SIS tip "local maximum" only for |β|<θ_E. X8 "μ_c small" only for κ₀>2 (θ_c<θ_E/4). X9 ex:burke_verification is singular SIE → "non-singular version". N12 "innermost tenth" unsourced (radial curves at 0.25–0.30 θ_E).
- Harness: Print drops lines when interleaved → use WriteString["stdout",…] in harness.wl (SUMMARY tally authoritative).
## ch17 critic (41 PASS / 7 SUSPECT / 1 FAIL; closed-form boundary CONFIRMED; source note's "transcendental" claim wrong)
- F1 (FAIL) Sol 17.2(c) wrong reason for m_crit→0 as γ'→1 (uniform-sheet argument; replacement text in report).
- F2 fig:cb_bias_vs_m caption: points stop at 0.35/0.25 m₁,crit; "exceeds linear by >40%" false for γ'=1.8 (×1.24) → reword or add point.
- F3 "any central excess" → "any axisymmetric central excess". F4 Sol 17.7(b)–(c) point-mass equivalence misapplied (θ_b > θ*), mixed planes. F5 "lensing efficiency" wording vs Ch 7's 𝓔 = D_d D_ds/D_s. F7 header comment cites unchecked.
## ch18 critic (48 PASS / 9 SUSPECT / 0 FAIL; all author flags confirmed)
- ξ invariant is Kochanek 2020 MNRAS 493, 1725 (DOI 10.1093/mnras/staa344, arXiv 1911.05083) → add bib (CrossRef) + cite at ~512–515 and 757.
- Eq ms_F validity needs ν>1, γ'>1, ν+γ'−2−2β_a>0. η notation clash with Ch 13 bridge (η = distance ratio there; plane numbering reversed) → fix the Ch 13 bridge box (ann0809 scope).
- Ch 21 steepening claim "in this configuration" qualifier. eq:distance_ratio described as D_ds/D_s but defines 𝒟 = D_ds/(D_d D_s). "most common sign error" superlative.
## critic 04–05 (04: 32 PASS/4 SUSPECT/6 FAIL; 05: 31/4/5; flags 1–7 CONFIRMED, 8 partly)
- 04_Solutions Ex 4.3(a) ll.160–168: 4GM☉/c² = 5.906e3 m; θE = 4.38e−9 rad = 0.90 mas; RE = 6.8e11 m ≈ 4.5 AU.
- 04 Ex 4.3(c): change statement to "M_E ≈ 2e14 M☉ inside θE (total M200 ~ 1e15)".
- 04_Solutions Ex 4.5 table l.295 β=0.1 row → `0.1 & +1.051 & −0.951 & 2.002 & 5.519 & 4.519`.
- 04 l.498 and 05 l.285: add "axisymmetric" to the κ<1 bullet (C&K §2.5).
- 04_Solutions Ex 4.4(b) l.244 ≈2840 → ≈2830 (c=2.998e8); (c) l.250 2360 → ≈2350.
- 05 ll.617–619: |μ|>1 iff |det A|<1 i.e. −1 < (1−κ)²−|γ|² < 1; reword annotation "upper bound alone".
- 05 l.750: "for 1<κ<2 … still magnified (demagnified for κ>2, μ=1/4 at κ=3)".
- 05 l.789: φγ = ½ atan2(γ₂, γ₁).
- 05 layer FAIL L1: multipole bridge m=1 "pure shift of the lens centre" → "linear potential, constant deflection shifting only the unobservable source".
- Layer wording suspects (both reports); Module~\ref vs Chapter~\ref mixing; Dds(0.3,2) = 1328 not 1329.
## critic 06–07 (layer: 0 FAIL; visible items V1–V10 ALL CONFIRMED; replacement text in the two reports)
- V1 2R_S/c: 06 tex l.856, Example ex:point_mass_numerical (≈300 d), 06_Solutions ll.119–123, time_delay_function.wl ll.185/208/209/223, problems_06.wl ll.149/155–156.
- V2 Sol 6.3(b) table rows (0.2001 / 1.0103 / 2.0805 / 4.5912) + roundings in Sol 6.2(b–c) and Example.
- V3 Shapiro-sign bullet (06 ~225–235) → replacement bullet in report. V4 Sol 6.3(a) argument → global-minimum argument.
- V5 Sol 6.4(b) 0.771/0.493/0.336; (c) 2.38e−18. V6 Sol 7.3 distances 1055/1650 → 1.15″; (b) 1.65/−0.65/3.30/−1.30/4.60; problems_07.wl ll.124,130–138.
- V7 Sol 7.3(d) point-mass 2.4″ replacement paragraph. V8 Sol 7.5(a) f ≃ ln(2/x) − 1. V9 Ch 07 ll.819–822 caustic sentence replacement. V10 Ex 7.4(c) strict inequalities.
- Layer: "≈299 d" → "≈300 d"; bartelmann_1995 support unverified for κ̄ identity; "remove or split" → "remove or add a second faint image"; Bartelmann 1996 (no DOI; arXiv astro-ph/9602053) needs bib + cite; remove "flagged for correction" sentences after fixes.
## critic 02–03 (02: 23 PASS/8 FAIL/4 SUSPECT; 03: 26/6/6; all 9 visible flags CONFIRMED + 1 new; layer FAIL: 03 N4 "accelerating")
- 02 V1 Ex 2.2(b) ll.119–126: n = √[(1+2m/r)/(1−2m/r)] ≈ 1+2GM/(c²r); Newtonian 1+GM/(c²r); problems_02.wl ll.121–122.
- 02 V2 Ex 2.1(b) ll.52–53: φ± = ±(π/2+δ), swept π+2δ. V3 ex:shapiro_sun ll.752–761: 220 μs (240 with +1). V4 remark ll.879–880: θ_E ≈ 2.4″.
- 02 V6 "Shapiro 1964 measurement" (Sol:252, ch:1120, problems_02.wl:225) → Shapiro et al. 1968 PRL 20, 1265 (DOI 10.1103/PhysRevLett.20.1265); 1964 PRL 13, 789 = prediction. V8 NEW: "inferior conjunction" → "superior conjunction" (ch:760, Sol:254). V7 "200±20 μs" unverifiable; 2σ from 240 yet called "consistent".
- 03 V1 eq R00 (:312) R₀₀ = −3ä/a; lhs_00 (:440–458) = 3(ȧ²/a²+kc²/a²) − Λc²; same in Solutions :38, 84–87; reword two layer passages after fix.
- 03 V2 friedmann_equations.wl: R00expected = −3a''/a; make friedmann1 comparison a check[] + SUMMARY (currently prints nonzero Difference and "Verified" unconditionally).
- 03 V3 Ex 3.2(c): 11.3 Gyr, ~19% older. V4 Ex 3.3 table: concordance 1.605/1748; EdS 1.25/1269; open (sinh) 1.90/1583; problems_03.wl:52 DAFunc add sinh DMFunc + FindMaximum.
- 03 V5 :1278–1281 𝒟 monotonic; efficiency peaks χ_d ≈ 0.42χ_s (z_d=0.350 for z_s=1; 0.519 for z_s=2). V6 :1320 "physical R_E"; caption :1333 peak position.
- 03 layer N4 :932–933 → "because H(z) > H0 at z>0"; X2 → "age is a smaller fraction of t_H (0.81 vs 0.96)"; CPL box may cite CP01+Linder03.
## critic 01d–01e (01d: 15 PASS/4 FAIL/8 SUSPECT; 01e: 14/5/6; all 8 author flags CONFIRMED; layer numbers all PASS)
- 01d F1 E normalisation: conserved_E → E = (1−R_S/r)c² dt/dλ; normalization → −(1−R_S/r)c²ṫ²+… = −εc²; 𝓔 = ½(E²/c² − εc²); photon_orbit and b = cL/E then stand (C&K 3.76a). Rewrite units annotation + first two derivation boxes.
- 01d F2 Sol Ex 4: 5.01e−7 → 5.02e−7; 0.1034″ → 0.1036″; 42.93 vs boxed 43.0 stands with 0.1036; annotation "rounding" → slip.
- 01d F3 Sol Ex 5(b): "small angle" → ≈2.6 rad ≈ 149°/orbit near r≈12GM/c²; small only for r ≫ 6GM/c²; drop box sentence.
- 01e F4 Sol Ex 2(b): first-order difference R_S r dΩ²; use isotropic radius ρ (eq isotropic_r), final metric in ρ.
- 01e F5 eq lens_equation_preview → β = θ − α, α = (D_ds/D_s)α̂ (matches Ch 4 :275, C&K 4.26); rewrite preview annotation.
- 01e F6 Sol: 9.58e−17 → 9.57e−17; 3.94″ → 3.95″; delete the two "rounding" annotation sentences.
- 01e F7 Cassini → "γ_PPN − 1 = (2.1 ± 2.3)e−5 (Bertotti, Iess & Tortora 2003, Nature 425, 374, DOI 10.1038/nature01997; Will 2014)" — no bib key yet.
- 01e F8 cluster |Φ|/c² ok as order of magnitude; optional soften "only … r ≲ 100 kpc".
- Kerr ISCO: optional "(Bardeen, Press & Teukolsky 1972, DOI 10.1086/151796)". Prose tells listed in reports.
## critic 08–09 (08: 27 PASS/5 SUSPECT/6 FAIL; 09: 29/5/9; all 11 flags CONFIRMED + 5 new; layer 0 FAIL; exact fixes in reports)
- 08 Step 4 (~573–583): ∂1α1 = θE√q θ2²/(θ²F), ∂2α2 = θE√q θ1²/(θ²F); sum line; delete "Reading the Step-4 display" box; retire/invert problems_08 check [B6].
- 08 Stage 1 (l.1216): beyond the cut 1 image (|β1|>0.932, |β2|>1.049 θE at q=0.7); between cut and diamond 2; cored sentence → "third image once inside the radial caustic".
- 08_Solutions Ex 8.4(b): (0.36, 1.20)″ μ≈+3.67; (−0.56, −0.55)″ μ≈−3.82; (a) cusps |β1|=0.159, |β2|=0.139. Ex 8.1(b) SIS+shear: "oval, ≈1.5% from an ellipse" (SIE itself IS an exact ellipse — optional wording fix at ~645, Ex 8.2(b)).
- 08 NEW (~1311–1315): image count 1→3 at radial caustic, 3→5 at tangential (text says 3→5 at radial). Ex 8.4(d) argument model-dependent (SIS gives +2).
- 09 l.561 remark: "shallower than assumed" (steeper raises H0). ~l.1155 wording "H0^true = 0.9 H0^naive". ~832–845 fragment + κ̄(θE)=1 normalisation. l.439 parenthesis → sheet of convergence 1−λ. Sol 9.2(d) within-image cancellation.
- 09 D_Δt: eq time_delay_recap → (1+z_d)DdDs/Dds; Ex 9.3(a) d has units of velocity; (c) "scales the same way, by λ". Sol 9.4(d): state assumed z=(0.3,1.0), 255 km/s, ratio 0.90, don't claim γ'≈2.0–2.1. problems_09.wl Ex 9.5(d) "~0.1e11" → ~0.2.
- Layer: name planes in the η' bridge (η<1 needs plane 1 = far source), cite eq ms_free; add sentence that γ'_eff size (dγ'/df=1.4) ≠ Ch 21 fit (+15.6, radial image); shorten D_Δt boxes after fix.
## ch15 critic (36 PASS / 13 SUSPECT / 1 FAIL [visible tags — FIXED 8982cee]; derivations 6/6; both source-note errors CONFIRMED)
- DONE: editions.tex \annot → \unskip (stray space before punctuation); Ch 15 [Checks …] tags gated.
- TODO: Ch 14 ("(Check 1c.)", "(check 3e)") and Ch 21 ("[Verified: checks D1–D3c…]") still print check tags in the student edition — apply the Ch 15 policy (\annot{}).
- N9 l.759 "θ₋ ≃ −0.016 θ_E" → "−0.0154 θ_E (leading order 0.016)"; tighten AN7 tolerance.
- X11 Summary ll.1074–1076 repeats the source-note "t₁→2 at fixed inner mass" wording → joint limit; add caveat to the point-mass-limit exercise.
- C10 "SMBH in essentially every massive galaxy" uncited → Kormendy & Ho 2013 ARA&A 51, 511 (DOI 10.1146/annurev-astro-082708-101811, CrossRef-confirmed; not in bib) or soften.
- X6 port the general |y_in|<|y_out| argument + γ'=1.3/1.8 image counts into power_law_point_mass.wl.
## critic 10–13 (layer: 10: 25/1/1, 11: 12/0/0, 12: 13/0/1, 13: 14/1/0; visible flags 1–4 CONFIRMED, 5 not an error; replacement text in reports)
- 13.1(b) AND chapter 13_Microlensing.tex:140 eq micro_mu_pm: μ± = ±½[(u²+2)/(u√(u²+4)) ± 1] (SKW 2006 Part 4 eq. 3 has the leading ±); fix layer closing clause.
- 10_Solutions ll.154–156: M_3D ∝ r², M_2D ∝ R² ln(2r_s/R). 10.5(d): γ_t≈κ̄ fails at every radius (κ/κ̄=0.6, κ̄=2.5γ_t, M(5′)≈1.1e15); "within ~12%, partly fortuitous"; soften exercise premise 10_Cluster_Lensing.tex:1045–1047.
- 10.2: cause is grid EXTENT (images at 13.5″ and 18.1″ outside ±1.5θ_E box); physics wrong too (no counter-image at 0.5θ_E; β=θ_E not on the tangential caustic; L/W≈2 not 5–10). Replacements for 10_Solutions:170–175, 179–184; exercise :976 → β = 0.1θ_E; problems_10.wl:164 gridRange 3θ_E; note ll.188–191.
- 12.5(d) not an error; optional "ℓ ≈ 4–5/θ (filter peaks at η≈4.1)".
- Layer: 10 N9 κ_s 0.330 → 0.329 (10_Solutions:88; problems_10.wl:398–399 target 0.329 tol 0.0005) — critic's auto-fix was blocked by the permission classifier, apply in fix pass; 10 X1 signed θ/β wording; 12 N2 ⟨χ⟩ = 2g(1−⟨|χ_s|²⟩/2) (SKW p.277).
- Repo-check weaknesses: problems_12 "MST γ'=λγ" uses undefined `gam` (passes trivially); SIS 2θ_E check hard-codes κ=γ=1/4; problems_11 divergence clause; problems_10.wl:40 stale 1328.2 comment.

# ===== PART V FIX ITEMS from reconciliation (in addition to each chapter's critic Flagged section) =====
## Ch 14 (reconciler): A "if Ω_m is held fixed" at tex:603–609, 641–642, 948–949, Soln 93–95, 285 (+ R3 numbers: −1% → δw +0.29, +1% → −0.36; Ω_m free along dΩ_m = −½dw needs |δw| = 0.66); B rescope keybox tex:369–371 to α₂/α₁ = 1/B; C replace Summary tex:950–951 (differently oriented curves, cite collett_2012); D optional em-dash appositive tex:83–86; E mark C11, C13 ✅ in the verdict table. Critic flags F1, F3, F5 remain.
## Ch 16 (reconciler): S7-049 l.22–25 "For a single galaxy the missing odd image…" (minor). Critic items X5–X9, N12 remain.
## Ch 18 (reconciler): 1 uniform-core Jeans formula needs ν > 2+2β_a (l.708, 743–745, Sol 18.8 l.171–173, Ex 18.8 l.871–873; exact σ_r² = (4π/3)Gρ_c r²[ln(r_c/r)+1/3] at ν=2; add check k18b); 2 optional decoupling-radius table vs γ′. Critic items (Kochanek 2020 bib + cite; ms_F validity; η notation; Ch 21 qualifier; eq distance_ratio wording; superlative) remain.
## Ch 21 (reconciler): 1 Sol l.49–51 "can detect" only at fixed slope → qualify, point to §pe_free_slope; 2 keybox l.858–863 qualify "comparable c_i" or point to §pe_sign_change; 3 l.517–518 "one function" → "For the canonical triple,"; 4 l.88 "is the whole method" → plain. Critic F1 (source-plane vs image-plane scope), F2 (validity criterion ≈640 m), N5 (10.46), X3 remain.
## Ch 19 (reconciler): N1 keybox l.354–367 warn codes order (ε₁,ε₂) differently (autogalaxy: 90°/m − φ_m); Solutions l.219–224 give the reversed-order answer; N2 l.487–489 drop the pivot; N3 l.23–24 cite O'Riordan & Vegetti 2024 + Stacey+2024 (keys being added) or delete; N4 f•=0.01 at γ'=1.5 exceeds m_crit = 27/4096 — option (a): "radial critical curve of the base", point to ch:power_law_point_mass, reword keybox, add check 27/4096 < 0.01; N5 keybox closer l.756–759; N6/N7 optional. F1 updates: the per-cent claim is supported by O'Riordan & Vegetti 2024 and Stacey+2024 (spiral rows S7-059/064/065).
## Ch 15 (reconciler): N-1 "only logarithmically" (l.997, 1003–1004, Summary l.1074) → power law (θ/θ_B)^{2−t₁}; N-2 l.989–990 "As t₁→2⁻ at fixed inner mass…"; N-3 annotation l.1017–1028 add the K-fixed sentence (regime ii only inside regime i); N-4 l.807–809 circular/same-convention caveat; N-5 keep "necessary, not sufficient" once. Plus critic items N9, X11, C10 (now `kormendy_ho_2013` available), X6.
## Ch 17 (reconciler): N-R1 keybox "bias is differential" + Summary l.902–903 (forcing m₂=m₁ gives 1.87× larger bias, not zero); N-R2 l.805 "one way" + deforming an image counts (Nightingale+2023 NOT in bib — write around); N-R3 "tends to have the same sign", "mean bias"; N-R4 drop "order-of-magnitude estimate" label (l.45, 386, 415, 907; Sol l.152) + new check (0.084× at offsets 0.15/0.3); N-R5 l.748 "for an axisymmetric lens" (+ optional shear factor, needs check); N-R6 l.666/720 "black hole's own critical curve" reword. Plus critic F1 (Sol 17.2(c)), F2 caption, F3, F4, F5.
## Ch 20 (reconciler): F1 keybox L691–699 + title L666 one-parameter scope (counterexample Δw0 = −0.687 vs −0.303/−0.219); F2 L740–746 noisy masked case sentence, keybox "a set, or nearly so"; F3 L776–778 restate parametrisation claim (two-bin w shifts B by 30.5%); F4 optional X11 cite Ch 25. Plus critic C7/X7 (CPL cite), C3, C8/N25, X8, X11.
## Fix pass status (Chapters 1–17): ALL SEVEN GROUPS MERGED (01a–c c662633, 01d–e 2aea4b8, 02–03 acc0e85, 04–05 a44690a, 06–07 2f0046f, 08–09 eb365e0, 10–13 d7d557b). Note: the 10–13 CRITIC's β_r ≈ 0.517″ for Ex 10.2 was wrong; the fixer computed β_r = 1.01″ ≈ 0.146θ_E two ways and the Resolution section records it.
