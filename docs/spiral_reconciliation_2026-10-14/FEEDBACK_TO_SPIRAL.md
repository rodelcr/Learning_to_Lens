# Feedback to `202607_Theoretical_spiral_compound` from the Learning to Lens Part V port (2026-10-14)

Each item was found while porting the theory notes into textbook chapters, confirmed by an independent
critic with a scratch Mathematica script, and then checked against the spiral project's own record
(packet critic `theory/FACT_CRITIC_STUDY_PACKET_2026-10-14.md`, earlier critics, TESTS rows, HANDOFF §5).
"Not in the record" means none of those documents states it. Full reconciliation tables are in each
chapter's `Notes/<NN>_*/FACT_CRITIC_*_2026-10-14.md` (section "Reconciliation with the spiral project's record").

## Citations / files
1. **"Schneider 2014, A&A 568, A106, arXiv:1409.0015, DOI …201424881" conflates two papers.** arXiv 1409.0015 /
   DOI 10.1051/0004-6361/201424881 is Schneider **2019, A&A 624, A54** (generalized multi-plane lensing, MST).
   Schneider **2014** is A&A **568, L2**, DOI 10.1051/0004-6361/201424450 (arXiv 1406.6152; no local PDF).
   Sites: `Reference_papers/README.md:41`, `lit_review/MSD_LITERATURE_REVIEW.md:85,:149`, the PASS list of
   `theory/FACT_CRITIC_study_notes_2026-07-11.md`, memory `msd-and-kinematics-anchor.md` item 1, and the packet
   critic's own S3-06 text. The packet critic (S8-001) found the A106 error but not all sites.
   `Reference_papers/Schneider2014_multiplane_MST.pdf` is the 2019 paper; `SchneiderSluse2013_SPT.pdf` is the
   2014 SPT paper (A&A 564, A103); `MSD_LITERATURE_REVIEW.md:54,:61` still cite the SPT as "2013/2014".
2. **Per-plane independent mass sheets are Teodori 2026, not Schneider 2014** (which has one λ alternating λ/1
   between planes, ν₃ = 1). The S3-10 fix covers note5:67–69 only; the memory note and `MSD_LITERATURE_REVIEW.md:149`
   will re-seed it.
3. Burke 1981 ApJ 244 L1 is DOI 10.1086/183466 (10.1086/183472 is Storey et al.); `FACT_CRITIC_SOLUTIONS_2026-07-24.md:58`
   "note4 10/10" is wrong (23 checks).

## note1 / note1b (→ Chapter 18 of the book)
4. `note1_multiplane_dspl.tex:84–86` (eq:multiplane) and `note1b:196–198` write the physical deflection at an
   angle, α̂_i(θ_i); SEF eq. 9.3 evaluates it at the physical position α̂_i(D_i θ_i). Notation only, but note1b
   mixes reduced and physical deflections in one line.
5. TESTS H0 / `beta_sensitivity.py`: S_w = −0.0157139331 and S_Ωm = −0.0254559324 are finite-step differences
   (steps 0.05 in w, 0.02 in Ω_m) quoted to 10 digits; the derivatives at (0.68, 1.52, 2.11) are −0.015725 and
   −0.025472 (0.07%). H0's "<1e−9 agreement" compares two codes using the same step.
6. note1b:178–179, 381 ("a population constrains a point"): Collett+2012 §4 p. 5 supports "differently oriented
   constraints per redshift triplet" (slope −1.620 at the project triplet; PDF already in Reference_papers/).
7. S6-039 provenance: Zotero CW87FPFT (KSB94) has no attachment; the quoted equations (pp. 287–288, 21b, 26–27)
   are nevertheless correct, and note1b's κ matches KSB94 eq. 21b (closes the 07-13 open item).

## note4 (→ Chapter 20) — none of these is in the record (S7-054/55/56 never got a verdict; sol_note4 never extracted)
8. `note4_odd_images.tex:108` "odd image count drops from three toward one": with one point mass the count is
   EVEN (N = 2n₋ + 1 − g); NIS+BH gives 4 or 2, never 3 or 1 (900-source scan).
9. note4 keybox l.110–113 and sol_note4:205–209: at u_crit the two radial critical circles merge (the project's
   own A4 condition y′ = y″ = 0); for a fixed source the central maximum merges with the BH saddle, never with
   the radial saddle; "min + saddle + faint image pinned at the BH" is three images — the count is exactly two.
10. sol_note4:170, :176: τ → **+∞** at a point mass, not −∞ (SEF p.175; PLW p.425).
11. note4 Ex. 4 l.131–132 and sol_note4:163, 186–190: a point mass changes the image count by an ODD number
    (N + g keeps its parity); the solution's own algebra (N = 1 + 2n_sad → 2n_sad) contradicts its "even".

## note5 (→ Chapter 22)
12. TESTS G4 "slope information vanishes at R_ap = θ_E" is an artefact of the projected-mass proxy (derivative
    ln(θ_E/R)); the aperture-averaged Jeans dispersion puts the zero at R_E·exp(∂lnF/∂γ′) = 0.91–1.65 R_E for
    γ′ = 1.4–2.0 (ν = 2), 3.6–6.4 R_E at ν = 2.5 — never exactly at θ_E. The −0.27 "backfire" location moves.
13. The ξ invariant (ξ = θ_E α″/(1−κ_E), = 2(γ′−2) for a power law) is Kochanek 2020, MNRAS 493, 1725
    (DOI 10.1093/mnras/staa344); the reading list has the paper but not this result.

## note10 (→ Chapter 25)
14. c is a **source-plane, unit-weight** estimator (`tier1_axisym.fit_pl_only` docstring says so) but note10
    l.20/57, TESTS A3 and `analytic_estimators.py` call it "least squares over image positions". Under image-plane
    weights 1/(σ²λ_r²) the canonical-triple c tends to 1/(γ′−1) as ρ → 0 instead of diverging, is non-monotonic,
    and the plane-2 sign change reverses (0.065 < ρ₂ < θ_r vs ρ₂ < 0.212). Tier-2's C = σ²AAᵀ is an image-plane fit
    at first order, so note10's leverage story does not carry over to Tier 2 automatically (possible contributor to
    the "within ×2" Tier-1/Tier-2 agreement — untested).
15. sol_note10:219 "B_i → 0 = a source infinitely far behind": z_s → ∞ gives B = d₁/d(∞) = 0.596 (flat ΛCDM,
    z_d = 0.4, z₁ = 1). In H3's geometry B_i^k = 0.60/0.48/0.42, so responses reach 40–58% of the limit (≤70%).
    The H3 row and CLAUDE.md:633 drop note10's equal-c condition on "all r_i share a sign" (with unequal c_i,
    r₂ = −2.76 vs r₃ = +0.52).
16. sol_note10:40–42 "a plane with a radial image can detect [a central mass]" holds only at fixed γ′; with γ′
    free one three-image plane is an exact 3×3 solve (zero residual). Packet critic S5-151 marked it verified.
17. A8c tests `(1 − bb²) > 0` with k fixed at 2 and no γ′ (near-vacuous); A8b uses γ′ = 3/2 only. Tentative: A3's
    gate at m = 1e−4 may sit outside the linear regime for deep radial images (4.5% non-linearity at ρ = 0.024;
    the relevant small parameter is ≈640 m, not m·c) — re-run `verify_a3` at m = 1e−5.

## note6 (→ Chapter 23)
18. The S7-074 angle-map correction (autogalaxy orders the components as `arctan2(comps[0], comps[1])/m`, so the
    same numbers put the mode at 90°/m − φ_m; verified with autogalaxy 2026.4.13.6: m = 4 at 30° comes back at
    −7.5°) has not reached `theory/solutions/sol_note6_multipoles.tex:14` or
    `lit_review/CODE_CAPABILITY_SURVEY_multipoles_potential_2026-07-21.md:28`.
19. note6 eq. (alpharatio) l.177–183 needs |m² − (3−γ′)²| in the denominator (or m > 3−γ′); for m = 1 at γ′ < 2 the
    printed ratio and its maximum are negative.
20. "Omitted central mass misfits the radial image" (note6 summary keybox ~l.584) is wrong whenever f• exceeds the
    annihilation threshold (27/4096 at γ′ = 1.5; ≤ 0.0066 for any slope): there is then no radial critical curve.
    S7-130 / mcrit-defect item 3 fix one cell (l.512) but not the keybox. Suggested: "misfits the inner image
    region (the radial image where one exists)".
21. Record only: S7-093's "60%" and the chapter's "37.5%" are the same shortfall against different bases.
