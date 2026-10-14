# fact-critic report: Notes/14_Multiplane_DSPL/ (PDF chapter 18)

> Date: 2026-10-14 · Critic: independent pass (did not author the chapter)
> Scope: `14_Multiplane_DSPL.tex`, `14_Solutions.tex`, `Mathematica/14_Multiplane_DSPL/multiplane_dspl.wl`,
> `Solutions/14_Multiplane_DSPL/problems_14.wl`, `Figures/14_Multiplane_DSPL/B_vs_zs2.pdf`;
> source notes (read-only) `AGEL/202607_Theoretical_spiral_compound/theory/note1_multiplane_dspl.tex`, `note1b_dspl_inference.tex`.
> Lenses: Citation, Number, Consistency, Prose, Derivation. (Provenance not run: not requested by the brief.)
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (api.crossref.org reachable; Semantic Scholar
> abstract for Collett+2012), md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓, Reference_Texts PDFs ✓
> (SEF 1992, Congdon & Keeton 2018, via `pdftotext`), wolframscript ✓ (`bash Mathematica/run_wl.sh`),
> overlay: AGEL (Zotero ✓ metadata; Kormann+1994 has no attachment, so fulltext ✗).
> A claim whose lens has no active adapter is capped at ⚠ SUSPECT.

**Counts (verdict rows): 53. ✅ 46 PASS · ⚠ 4 SUSPECT (C4, C11, C13, D-rad) · ❌ 3 FAIL (N14, N15, X3; all one rounding slip, auto-fixed). Derivations: 5/5 PASS (D1-D5). Prose items (6) are listed separately and not counted.**

Repo scripts (run 2026-10-14):
- `multiplane_dspl.wl`: `SUMMARY: 56 PASS, 0 FAIL  (of 56 checks)`. Re-exporting the figure changed only the PDF bytes; I reverted it, so the committed figure is unchanged.
- `problems_14.wl`: `SUMMARY: 49 PASS, 0 FAIL  (of 49 checks)` before and after the auto-fix to check 3c.

## Verdicts

### Citation

| id | quoted | verdict | source checked | proposed fix |
|----|--------|---------|----------------|--------------|
| C1 | `\citep[\S9.1.1, eqs.~9.2--9.3]{schneider_ehlers_falco_1992}`: θ_j = θ_1 − Σ_{i<j} (D_ij/D_j) α̂_i(D_i θ_i) | ✅ PASS | SEF PDF printed p. 283, eqs. (9.2)-(9.3); bib DOI 10.1007/978-3-662-03758-4 CrossRef-confirmed | none |
| C2 | "SEF (§9) attribute the multiple lens-plane formalism in part to \citet{blandford_narayan_1986}" | ✅ PASS | SEF p. 281 "multiple lens-plane theory ([BL86.1], [KO87.5])"; SEF bibliography [BL86.1] = ApJ 310, 568; bib DOI 10.1086/164709 CrossRef-confirmed | none |
| C3 | SEF quote "one should keep in mind that this hypothesis remains formally untested" | ✅ PASS | SEF p. 282, verbatim | none |
| C4 | "citing in a footnote a numerical two-point-mass study in which the approximation held very well for all rays not strongly demagnified" | ⚠ SUSPECT (characterisation) | SEF p. 282 footnote 1: the result is attributed to "P. Haines, private communication", not to a published study | see Flagged F3 |
| C5 | "images can be rotated as well as sheared, as SEF point out at the start of their Chapter 9" | ✅ PASS | SEF p. 282: "Jacobian matrix is no longer symmetric … net rotation of the images" | none |
| C6 | SEF derivation "works directly with angular-diameter distances and does not assume flatness" | ✅ PASS | SEF p. 283 (eq. 9.1 "read off from the geometry" with D_ij; eq. 9.8 uses the general X(z) of SEF §4.6) | none |
| C7 | `\citep[\S4.8, eqs.~4.99a--c]{congdon_principles_2018}`, β_ij = D_ij D_s/(D_j D_is) | ✅ PASS | C&K PDF pp. 112-113, eqs. (4.94)-(4.99c); bib DOI 10.1007/978-3-030-02122-1 CrossRef-confirmed | none |
| C8 | "\citet[\S4.8]{congdon_principles_2018} make the same remark" (merging planes: D_12→0, β_12→0) | ✅ PASS | C&K p. 113: "if the planes are at the same distance, then D12 = 0 so β12 = 0 and θ2 = θ1" | none |
| C9 | "DSPLs to constrain the dark-energy equation of state was developed by \citet{collett_2012}" | ✅ PASS | CrossRef 10.1111/j.1365-2966.2012.21424.x (MNRAS 424, 2864) title; Semantic Scholar abstract (arXiv 1203.2758) | none |
| C10 | "why populations of DSPLs are needed \citep{collett_2012}" | ✅ PASS | S2 abstract: "constraints comparable to current data sets … possible with a handful of double-source plane systems" | none |
| C11 | "several lenses with different redshift triplets, each contributing a differently oriented band \citep{collett_2012}" | ✅ PASS (closed 2026-10-14 by reconciler: Collett+2012 §4 p. 5) — was ⚠ SUSPECT (support) | Abstract discusses the Ω_M–w degeneracy being orthogonal to CMB/BAO. It does not say that different triplets give differently oriented bands. Full text not read. | see Flagged F2 |
| C12 | "cosmological constraints from an observed galaxy-scale DSPL were derived by \citet{collett_auger_2014}" | ✅ PASS | CrossRef 10.1093/mnras/stu1190 (MNRAS 443, 969): "Cosmological constraints from the double source plane lens SDSSJ0946+1006" | none |
| C13 | SIE normalisation "following \citet{kormann_isothermal_1994}" | ✅ PASS (closed 2026-10-14 by reconciler: KSB94 eqs. 15, 21a–d, p. 287) — was ⚠ SUSPECT (existence only) | bib + Zotero CW87FPFT (A&A 284, 285; ADS-verified, no DOI). No PDF attached, so the normalisation itself was not checked against KSB94. In-repo eq. `sie_kappa` (08_Elliptical…tex:429-433) matches the chapter. | see Flagged F4 |
| C14 | "posed in the title of \citet{schneider_2014_multiplane}" | ✅ PASS | CrossRef 10.1051/0004-6361/201424450 = A&A 568, L2, "Can one determine cosmological parameters from multi-plane strong lens systems?" | none |

### Number (all at (z_l, z_s1, z_s2) = (0.5, 1.0, 2.0), flat ΛCDM, Ω_m = 0.3, unless stated)

| id | quoted | verdict | source checked | proposed fix |
|----|--------|---------|----------------|--------------|
| N1 | B = 0.6742 (eq. mp_Bnum; ×6 occurrences) | ✅ PASS | critic D2a: 0.674156; repo 2h | none |
| N2 | naive D_s−D_l ratio 0.878 (text) / 0.8782 (Soln), "30%" / "+30.3%" | ✅ PASS | critic D2c: 0.878211, +30.27%; repo 2l, Soln 4e | none |
| N3 | D_d = 1259.08, D_s = 1726.62, D_ds = 1097.08, D_s−D_d = 467.54 Mpc (H0 = 70); error 629.54 Mpc | ✅ PASS | critic D2d; repo Soln 4c-4d | none |
| N4 | χ(∞) = 3.305 c/H0 | ✅ PASS | critic D2f: 3.30508 (no radiation term, as in the chapter's E(z)) | none |
| N5 | floor B(0.5, 1, ∞) = 0.4943 | ✅ PASS | critic D2g: 0.494306 | none |
| N6 | B(0.5,1,4) = 0.5815 → 0.5714 at w = −0.7; −1.75% | ✅ PASS | critic D2h: 0.581521 → 0.571363, −1.747% | none |
| N7 | "w signal under 2%"; sign does not change | ✅ PASS | critic D2i: frac. diff ∈ [−1.99%, −0.15%] on z_s2 ∈ [1.1, 6], monotone; repo 5k, Soln 0b | none |
| N8 | D_s1s2/D_s2 = 0.3622, D_ls2/D_s2 = 0.6354, factor 0.570; 9.1% (σ1/σL = 0.4), 20.5% (0.6) | ✅ PASS | critic D2j: 0.362178, 0.635391, 0.570009 | none |
| N9 | σ1 = 100 km/s at z = 1 → θ_E = 0.10″ for z_s2 = 2 | ✅ PASS | critic D2k: 0.1045″ | none |
| N10 | S_w = −0.0330 | ✅ PASS | critic D5a: −0.0330114 (FD), D5c integral method agrees to <1e-7 | none |
| N11 | S_Ωm = −0.0357 | ✅ PASS | critic D5b: −0.0356896 | none |
| N12 | degeneracy slope −1.08 (Soln: −1.081 in script) | ✅ PASS | critic D5d: −1.08113 | none |
| N13 | "1% in B ↔ \|δw\| = 0.30" (summary "≈0.3") | ✅ PASS | critic D5e: 0.01/\|S_w\| = 0.3029 | none |
| N14 | η = B^{1/0.9} = **0.6452** (text l.539; Soln l.87) | ❌ FAIL (auto-fixed) | critic D3d: 0.645259 → **0.6453** at 4 dp. Also 0.6742^{1/0.9} = 0.64530. Repo script prints 0.6452585…; check 3c passed only because its tolerance is 1e-4. | 0.6453 |
| N15 | ln η = **−0.4382** (Soln ll.88, 91) | ❌ FAIL (auto-fixed) | critic: −0.438104 → **−0.4381**; repo log prints −0.43810413 | −0.4381 |
| N16 | ln η = −0.438 (text), δγ′ = 0.023 / 0.0228 for 1% | ✅ PASS | critic: 0.022826 | none |
| N17 | δγ′ = +0.03 → δB/B = −1.31%, δw = +0.40 | ✅ PASS | critic: −1.314%, +0.398 | none |
| N18 | naive error ≈ "shift of order 8 in w" | ✅ PASS | critic: ln(0.8782/0.6742)/S_w = −8.01 | none |
| N19 | Error budget: 0.00833, −0.01643, −2.190e-4, 1.10%, 1.84%, 40%, 3.9×, σ_w = 0.33 | ✅ PASS | critic D5g: 0.008333, −0.016425, −2.1900e-4, 1.0965%, 1.8418%, 40.5%, 3.885, 0.332 | none |
| N20 | "a 0.01 step in Ω_m along … changes ln B more than 40 times less than across" | ✅ PASS | critic D5 (equal-length steps): ratio 50.1; repo Soln 9d "~45x" | none |
| N21 | "B identical for H0 = 50, 70, 100 to 1e-12" | ✅ PASS | critic D2e (<1e-25); repo 2g | none |
| N22 | two-point-mass trace agreement < 1e-12 arcsec; S FD vs integral < 1e-7; SIE crit-curve ratio to 1e-10 | ✅ PASS | repo 1d, 5b-5c, 4d (logs quoted above); critic D1a (8e-22 rad), D5c, D4b (exact to working precision) | none |
| N23 | κ(θ) = (3−γ′)/2 (θE/θ)^{γ′−1}; α = θE^{γ′−1} θ^{2−γ′}; ∂E²/∂w, ∂E²/∂Ω_m expressions and signs | ✅ PASS | critic D3a (symbolic); repo 3a, 5j; in-repo 09_Galaxy…tex:838-840 | none |
| N24 | SIE critical curve crosses axes at θE/√q, θE√q | ✅ PASS | critic D4c | none |

### Consistency

| id | item | verdict | source checked |
|----|------|---------|----------------|
| X1 | B = 0.6742 in text ×5, Soln ×4, both scripts | ✅ PASS | internal: all agree |
| X2 | S_w, S_Ωm, −1.08, 0.30 across §, Summary, Soln 3/9/10 | ✅ PASS | internal: all agree |
| X3 | η = 0.6452 (text) vs check 3c label vs printed 0.64526 | ❌→✅ after auto-fix (N14/N15); `problems_14.wl` check 3c updated to 0.6453 / −0.4381 and re-run: PASS | repo log |
| X4 | Every `(Check …)` / `[Attested: checks …]` id cited in text/Soln exists in the corresponding log (1a-1j, 2a-2l incl. 2a′, 2a″, 3a-3g, 4a-4f, 5a-5k, 6a-6f; Soln 1a-10g) | ✅ PASS | repo logs |
| X5 | All 14 distinct `Chapter~\ref{ch:…}` targets resolve to the right chapter: lens_equation = 8, cosmological_distances = 7, axisymmetric = 11, elliptical = 12, galaxy_lensing = 13, linearized_gravity = 5, light_deflection = 6, magnification = 9, msd_kinematics = 22, central_mass_bias = 21, cosmological_sensitivity = 24, odd_images = 20, power_law_point_mass = 19 | ✅ PASS | `pdftotext -l 14 Output/Learning_to_Lens_Annotated.pdf` TOC; the topic of each matches its sentence |
| X6 | All 17 cross-chapter `\eqref`/`\S\ref` labels (sec:Dds, eq:Dds_flat/general, sec:jacobian, sec:power_law_profile, eq:kappa_power_law, sec:time_delay_cosmography, sec:msd, eq:alpha_mean_kappa, eq:sis_alpha_reduced, eq:sigma_cr, sec:sie, sec:critical_curves, eq:sie_alpha, eq:sis_einstein_radius, eq:reduced_deflection, eq:lens_equation) live in the chapter the sentence names | ✅ PASS | repo-grep `label{…}` |
| X7 | eq. mpi_siekappa = in-repo eq. sie_kappa | ✅ PASS | 08_Elliptical_Models_Caustics.tex:429-433 |
| X8 | Bridge: "in §time_delay_cosmography the inferred H0 depended on the assumed profile" | ✅ PASS | 09_Galaxy_Lensing_Applications.tex:1167-1172 (relaxing the power-law assumption broadens H0); H0^true = λ H0^naive at §TDC |
| X9 | Bridge: "slope … lensing alone constrains poorly and stellar kinematics helps pin down" | ✅ PASS | 09_Galaxy_Lensing_Applications.tex:913-935 ("Breaking the Degeneracy") |
| X10 | Port fidelity vs source notes: multi-plane eq., B, B = η^{γ′−1}, two-channel formula, coupling eq., circularity trap all carried over with the same algebra. Two changes, both corrections: (i) the deflection argument is now α̂_i(D_i θ_i), where the note had the ambiguous α̂_i(θ_i), matching SEF 9.3; (ii) coupling α̂_s1(D_s1 β_1). The notes' project-geometry numbers (B = 0.82008, S_w = −0.016/−0.0157, D_s1s2/D_s2 = 0.175, "δw ≃ 0.6") were all replaced by recomputed generic-geometry values, so none leaked. | ✅ PASS | diff by reading note1:75-100,170-222; note1b:185-205,229-300,384-395 |
| X11 | Project leakage grep (`tier|scripts/|results/|lenstronomy|autolens|J0946|AGEL|Carousel|this project|Jackpot|SMBH|test B|Note N`) over all four chapter files | ✅ PASS | 0 hits. (Collett & Auger 2014's bib *title* contains SDSSJ0946+1006. That is a public citation and does not appear in the chapter text.) |

### Physics claims adjudicated (author's flags)

| id | claim | verdict | source checked |
|----|-------|---------|----------------|
| D-J | A = I − Ψ1 − Ψ2(I − β12Ψ1); antisym. part ½β12[Ψ2Ψ1 − (Ψ2Ψ1)^T] | ✅ PASS | critic D1d-D1e (symbolic); repo 1i-1j |
| D-SIE | SIE ratio identity η = B, any q, any convention | ✅ PASS | critic D4a-D4b (div α = 2κ_KSB94-form; critical-curve radius ratio = B exactly for q = 0.4/0.7/0.95, 4 directions); repo 4a-4f |
| D-sh | Author's rewrite: "same-plane external shear cancels exactly if reduced shear scales by 1/B". The source note said "approximately cancels". | ✅ PASS (with caveat F5) | critic D4d: the whole field scales by 1/B, so the *parameter* ratio θE¹/θE² = B exactly. Repo 7b-7c. Caveat: the *critical-curve* size ratio is then 0.6775, not B = 0.6742. |
| D-rad | "most directly a radial or central image" anchors the inner slope (text §degeneracy; Soln 10) | ⚠ SUSPECT | No external source. Consistent in spirit with in-repo Ch. 20 (16_Odd_Images…tex:880-888), which itself stresses the slope/central-mass degeneracy. See F1. |

## Applied (auto-fixes)

- N14: `0.6452` → `0.6453`. Files: `Notes/14_Multiplane_DSPL/14_Multiplane_DSPL.tex:539` and `14_Solutions.tex:87`. Source: B^{1/0.9} = 0.645259 (repo `problems_14.wl` log and critic D3d).
- N15: `-0.4382` → `-0.4381`. File: `14_Solutions.tex:88,91`. Source: ln η = −0.438104 (same).
- X3: `Solutions/14_Multiplane_DSPL/problems_14.wl:116-117`, check 3c label and target values `0.6452/-0.4382` → `0.6453/-0.4381`. Re-run result: `SUMMARY: 49 PASS, 0 FAIL`. Downstream values are unchanged (0.0228, 1.31%, +0.40).
- Output PDFs were NOT rebuilt by this critic pass. `Output/*.pdf` still show 0.6452 / −0.4382 until `cd Notes && bash build.sh` runs.

## Flagged (your hand required)

- **F1 (D-rad, ⚠).** §"The B–γ′ Degeneracy" (tex:870-876) and Soln Ex. 10 (Soln:282-284) present a radial/central image as the most direct slope constraint. There is no citation, and the book's own Ch. 20 (16_Odd_Images…tex:862-888) says the central image constrains only a *combination* of inner slope and central mass. The DSPL text does mention that the same region is where a compact mass acts, so it is not contradictory. But the Soln line "pinning the slope — in practice, detecting and modelling a radial or central image" is stronger than anything the book supports. Proposed fix: add "or stellar kinematics (Chapter 13) / the radial thickness of extended arcs" as co-equal anchors, or cite a paper you have checked. Do not cite from memory.
- **F2 (C11, ⚠).** "Breaking the degeneracy needs several lenses with different redshift triplets, each contributing a differently oriented band \citep{collett_2012}" (tex:826-828). The abstract supports "a handful of systems" and orthogonality to CMB/BAO. It does not support the per-triplet orientation claim. Either confirm it in the Collett+2012 full text (arXiv 1203.2758, open access) or detach the citation from the orientation clause. The orientation claim itself is checkable in-repo: compute −S_Ωm/S_w at two triplets.
- **F3 (C4, ⚠).** tex:305-307 calls SEF's footnote "a numerical two-point-mass study". SEF attributes it to "P. Haines, private communication". Proposed: "…citing in a footnote an unpublished (private-communication) numerical two-point-mass test in which…".
- **F4 (C13, ⚠).** `kormann_isothermal_1994`: existence confirmed (Zotero CW87FPFT, ADS bibcode). The κ normalisation attributed to KSB94 was not checked against the paper because there is no PDF in Zotero. This is inherited from Ch. 12 and is low-stakes, since the chapter's own result is convention-independent. Attach the PDF and confirm KSB94's κ = √f/(2√(x1² + f²x2²)) form, including the axis orientation.
- **F5 (D-sh, caveat).** Ex. 7(b) / Soln:198-204 and the annotation at tex:830-838 are correct for the fitted θE *parameters*. With a same-plane shear scaled by 1/B, though, the Einstein radius read from the *critical curve* (or its area) no longer scales by exactly 1/B (critic D4d: 0.6775 vs 0.6742 for q = 0.7, γ = (0.08, 0.03)). The keybox's "any Einstein-radius convention" is stated for SIS/SIE without shear, so nothing is wrong. Consider one clause: "η here is the ratio of fitted θE parameters; critical-curve-based radii are not shear-invariant."
- **Out of scope (not edited).** In `Notes/references.bib`, the `% CrossRef … verified` comment lines sit one entry *above* the entry they describe. For example, the comment "CrossRef 10.1093/mnras/stu1190" precedes `collett_auger_2014` but follows `collett_2012`, and the Schneider-2019 comment precedes `kormann`/`schneider_2014`. This is cosmetic, but it could mislead a later critic.

## Prose (LLM tells): flag only

Main chapter: 5716 words, 20 em-dash pairs (about 1 per 286 words; several are list separators), so below the 1/150 threshold. Solutions: 1 em-dash. The chapter reads mostly clean. Instances worth a look:

| id | where | text | tell | proposed plain rewrite |
|----|-------|------|------|------------------------|
| P1 | tex:892 | "A tempting shortcut is fatal." | dramatic opener | "One shortcut invalidates the inference." |
| P2 | tex:640-646 | "That combination --- a small cosmological signal and a large parameter response --- is why …, why …, and why …" | em-dash pivot + triad | Split into two sentences: state the weak-constraint consequence, then the systematics consequence. |
| P3 | tex:950-951 (Summary) | "One lens constrains a curve in (Ωm,w); a population constrains a point." | aphoristic/chiastic closer | Keep as is (it carries content), or "A single lens fixes only a curve in (Ωm,w); several lenses with different redshifts are needed to fix a point." |
| P4 | tex:751-752 | "A single Einstein radius is convention-dependent; the ratio is not." | antithesis | Acceptable (physically meaningful); optional merge into the preceding sentence. |
| P5 | tex:743-744 | "reduces to 'the SIE has one length scale, and the efficiency multiplies it'" | aphoristic closer | Optional; fine for a bridge box. |
| P6 | tex:459 | "a first-order term, not a small perturbation" | antithesis | Meaningful contrast; keep. |

## Derivation checks

Scratch script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_14/critic14_derivations.wl`
(written independently: no repo harness, no repo functions). Log: `critic.log` in the same directory.
**`SUMMARY: 38 passed, 0 failed`.** A first run showed 1 FAIL on D4b at 3.7e-5. The cause was my own finite-difference Jacobian. Rerunning with an analytic Jacobian at WorkingPrecision 30 gave deviation 0.

| id | derivation | result |
|----|-----------|--------|
| D1 | Multi-plane recursion (SEF 9.3 form, coefficient D_ij/D_j, sum to j−1) vs explicit comoving ray trace through 3 planes with arbitrary nonlinear physical deflections. Distances come from in-script D_A(z_i,z_j). | ✅ PASS: max deviation 8.5e-22 rad. The **transposed** coefficient D_ij/D_i fails (discriminating test). The C&K β_ij = D_ij D_s/(D_j D_is) form also matches. Two-plane Jacobian and its antisymmetric part confirmed symbolically for general symmetric Ψ1, Ψ2. |
| D2 | B from in-script comoving integrals; χ-form identity; naive-subtraction value; D's; χ(∞); floor; B(0.5,1,4) at w = −1, −0.7; coupling factors; H0 independence | ✅ PASS: B = 0.674156, naive 0.878211, χ∞ = 3.30508, floor 0.494306, 0.581521 → 0.571363, factor 0.570009 |
| D3 | B = η^{γ′−1}: symbolic α(θ) from κ; numerical root of α₂(θ) = θ with κ₂ = κ₁/B at γ′ = 1.6, 1.9, 2.0, 2.3 | ✅ PASS: (θE¹/θE²)^{γ′−1} = B to <1e-15. The inverse exponent η^{1/(γ′−1)} fails, as it should, except at γ′ = 2. η(1.9) = 0.645259, which exposed N14/N15. |
| D4 | SIE ratio identity (KSB94-form κ, Keeton-form α): div α = 2κ; tangential critical-curve radius ratio along 4 directions, q ∈ {0.4, 0.7, 0.95}; axis crossings; SIE + same-plane shear | ✅ PASS: ratio = B exactly. With shear scaled 1/B the parameter ratio is B, but the critical-curve ratio is 0.6775 (feeds F5). |
| D5 | S_w, S_Ωm by central FD and by differentiating under the integral; degeneracy slope; 1% → δw; along/across ratio; Ex. 10 error budget | ✅ PASS: S_w = −0.033011, S_Ωm = −0.035690 (methods agree to <1e-7), slope −1.0811, 0.01/\|S_w\| = 0.3029, across/along = 50 |

## Reconciliation with the spiral project's record (2026-10-14)

> Reviewer: independent reconciliation pass (RECONCILE.md). Read: digest `docs/spiral_reconciliation_2026-10-14/note1_1b_2.md`
> (note1/note1b rows only; note2 rows go to Ch. 15), `note8_solutions.md` (no sol_note1/sol_note1b rows in it),
> `auto_fixable_and_coverage_gaps.md` (no note1/1b rows); full SUSPECT text recovered from the packet critic's journal
> (`wf_a10ff0a2-7f9/journal.jsonl`); spiral `theory/FACT_CRITIC_study_notes_2026-07-11.md`,
> `theory/FACT_CRITIC_note1b_dspl_inference_2026-07-13.md`, `theory/solutions/FACT_CRITIC_SOLUTIONS_2026-07-24.md`,
> `TESTS_AND_DIAGNOSTICS.md` rows A2/B1/C2/H0/D2, `HANDOFF_arc_2026-09-21.md` §5–6, `lit_review/VERIFIED_ANCHORS_2026-07-16.md`,
> `Reference_papers/README.md` + S8-001. New external sources read: Collett+2012 PDF (`Reference_papers/Collett2012_DSPL_forecast.pdf`,
> §4, p. 5); KSB94 ADS scan (`articles.adsabs.harvard.edu/pdf/1994A&A...284..285K`, pp. 287–288, eqs. 21a–d, 26–27).
>
> Scratch script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/reconcile_14/reconcile14.wl`
> (run with `bash Mathematica/run_wl.sh <path>`): **`SUMMARY: 8 PASS, 1 FAIL  (of 9 checks)`**. The FAIL is R1b, my own hypothesis
> about the spiral's finite-difference step, and it was wrong in detail: S_w matches a step-0.05 central difference to 3e-5 (rel.),
> S_Ωm matches a step-0.02 central difference. Companion `fdstep.wl` (same directory, print-only) tabulates both.
> Chapter verdicts are unaffected.

### Table

| spiral id | claim (source note) | status in chapter | action |
|---|---|---|---|
| S6-003 (⚠) | "all the bending happens in a region (~100 kpc)" (note1:47) | already fixed in port: tex:308-309 "galaxies are tens of kpc across" | none |
| S6-007 (⚠) | (0.3,0.6,3.3) called "cosmology-optimal" (note1:136) | n.a.: project triplets stripped; chapter uses generic (0.5,1,2) | none |
| S6-012 (⚠) | "S_w ≃ −0.016, so 1/S_w ≃ −64" broken chain (note1) | already fixed: chapter quotes S_w = −0.0330 and 0.01/0.0330 = 0.30 (self-consistent; critic N10, N13) | none |
| S6-013 / S6-056 (⚠) | 1% in B → δw ≃ 0.6 stated unconditionally; it is the fixed-Ω_m projection (note1, note1b:276) | **inherited** (same class, chapter numbers): tex:603-609 (eq. mp_propagate), tex:641-642, Summary tex:948-949, Soln:93-95 (Ex. 3c, δw = +0.40), Soln:285 (Ex. 10, "σ_w = 0.33 from this single lens") | **NEW FIX A** (below). Reconcile R3/R3b: fixed-Ω_m linear \|δw\| = 0.303; exact fixed-Ω_m roots −1% → w = −0.712, +1% → w = −1.359 (both reachable at this geometry, so the spiral's off-manifold concern does not apply here); along dΩ_m = −0.5 dw the same 1% needs \|δw\| = 0.659 (2.2×); along the level curve it is unbounded |
| S6-018 (⚠) | DESI-DR2-like (w0,wa) = (−0.42,−1.75), no citation (note1:215) | n.a.: stripped; chapter has no w0wa model | none |
| S6-023 (⚠) | η = 0.79 is not the project fiducial (note1 Ex. 3) | already fixed: chapter computes η = B^{1/0.9} = 0.6453 from its own B (after critic N14 fix) | none |
| S6-024 (❌) | "δγ′ ≈ 0.03 found numerically in Note 3" (true value 0.045) (note1:248) | already fixed: Ex. 3(c) tex:1003-1005 states δγ′ = +0.03 as a hypothetical ("Suppose…"), no attribution | none |
| S6-026 (❌, prose) | escalated paragraph, garbled "this project asks whether" closer (note1:20-29) | partly inherited: tex:80-86 keeps \emph{same deflector twice} and the em-dash appositive; the garbled closer and two other ornaments are gone. Two ornaments, below the escalation line | optional (see S6-027) |
| S6-027 (❌, prose) | "--- a dimensionless number that depends on…" appositive (note1:25-28) | **inherited** verbatim, tex:83-86 | NEW FIX D (prose, optional) |
| S6-028 (⚠) | keybox "All the deflector physics cancels in B" overstates: inference needs γ′ (note1:129-130) | **inherited**, keybox tex:369-371 (also "--- hence the cosmology ---" pivot) | **NEW FIX B** |
| S6-029 (⚠, prose) | "…is the distance ratio, full stop" (note1:165) | already fixed: tex:527-529 drops "full stop" | none |
| S6-030 (⚠, prose) | "exactly why" leverage sentence (note1:205-207) | inherited in altered form, tex:642-646; already flagged as P2 | none new (P2) |
| S6-031 (❌) | "genuinely nonlinear … coupling vanishes and everything is analytic" (note1:94-100) | already fixed: tex:266-269 and 339-342 ("For the moment treat source 1 as massless; its mass is restored in §mp_coupling") | none |
| S6-032 (⚠, prose) | "\textbf{Crucial trap}" (note1:70) | already fixed: bridge tex:151-165 states the trap without the label | none |
| S6-033 (❌) | "Every symbol used later in the project appears here" (note1:15) | already fixed: no such sentence | none |
| S6-038 / S6-039 (⚠/❌) | KSB94 "√q and elliptic-integral factors" (note1b:79); KSB94 SIE deflection is arcsin/arsinh | already fixed: tex:722-724 defines f(q) only as "whatever q-dependent factor a convention introduces". **Resolves chapter flag F4 / C13**: KSB94 eq. (21b) κ = √f/(2√(x1²+f²x2²)) with x = ξ/ξ0, ξ0 = 4π(v/c)² D_d D_ds/D_s (eq. 15). The chapter's eq. mpi_siekappa is this exactly, with the axes swapped (x1,x2)→(θ2,θ1), so the major axis lies along θ1 (reconcile R4, symbolic PASS) | close F4: C13 ⚠ → ✅ (KSB94 p. 287 eqs. 15, 21a–d). Optional: say "axes rotated by 90° relative to KSB94" |
| S6-047 / S6-048 (❌/⚠) | Jackpot θ_E,1 ≈ 0.2–0.3″, 20–30% coupling, definitional/units conflation (note1b:202-205) | already fixed: eq. mp_couplingsize is derived from σ1/σL, not from a dimensionless ratio presented as arcsec; 0.10″ for σ1 = 100 km/s sits inside the published 0.116–0.163″ range only loosely (0.1045″) and is not labelled as the Jackpot | none |
| S6-052 (⚠) | "the modelled middle mass partly absorbs the shift" (coin-flip evidence) (note1b:222) | n.a.: stripped | none |
| S6-060, -066, -068, -069, -075, -087, -089 | Tier-3 C10 fit numbers, R5 label defect, autolens API, "closes the B–γ′ degeneracy" (note1b §C10) | n.a.: all C10/project content stripped (critic X11 leakage grep 0 hits) | none |
| S6-062 (❌) | "Mpc-vs-kpc rounding" (real cause: radiation T_CMB/N_eff) (note1b:326-327) | n.a.: no code comparison in the chapter. The chapter's E(z) has no radiation term and says so implicitly (critic N4). | none |
| S6-081 (❌) | sol_note1b Ex. 1 claimed "attested" but has no Wolfram check | already fixed: chapter Ex. 7(a) is attested by `problems_14.wl` check 7a ("any shape factor f(q,phi) common to both planes cancels"); every Soln `[Attested]` tag resolves (critic X4) | none |
| S6-082 / S6-083 (❌, prose) | "not a spectator … the whole reason this project exists" (note1b:120-124) | already fixed: tex:530-534 states the lever arm plainly | none |
| S6-084 (⚠) | "hundreds of sigma … no analysis omits it" (note1b:212-217) | n.a.: stripped; annotation tex:461-472 makes no survey claim | none |
| S6-085 (⚠, prose) | "a first-order component, not a perturbation" antithesis (note1b:199-205) | inherited, tex:458-459. Already P6 ("keep") | none new. Its evidence is now on the page (9.1% / 20.5%) |
| S6-086 (⚠, prose) | "A tempting shortcut is fatal." (note1b:283) | **inherited** verbatim, tex:892. Already P1 | none new (P1) |
| S6-088 (❌) | "one lens gives a band; a population gives a point". False: a population gives a finite contour, and the reason it helps (orientation varies with triplet) is never stated (note1b:381) | **inherited** in the Summary, tex:950-951. The body (tex:815-828) states the mechanism correctly. The report's P3 had rated this "keep"; the spiral's FAIL is correct | **NEW FIX C** (upgrade P3 from prose to substance) |
| S6-090 (❌) | "B = 0-notation aside" garble (note1b:201) | already fixed: tex:434-439 uses α_1 consistently and "Setting the near source's mass to zero recovers eq. mp_plane2" | none |
| note1b 07-13 C1 | Collett & Auger 2014 used a free-slope power law, not an SIE | already fixed: tex:87-89 says only "cosmological constraints … were derived by" | none |
| S8-001 / Ref_papers README:41 | "Schneider 2014 (A&A 568, A106)" conflation; arXiv:1409.0015 = A&A 624, A54 (2019) | already fixed: chapter cites `schneider_2014_multiplane` = A&A 568, L2 (DOI 10.1051/0004-6361/201424450), only for the question posed in its title (tex:588-592), which is that paper's actual title. The bib comment (references.bib:389-391) records the distinction. The spiral already knows the L2 paper exists (note11:201; packet critic line 70) | none |
| 07-11 PASS "Schneider 2014 (A&A 568 A106)" | earlier spiral critic PASSed the wrong string | n.a. for chapter; spiral already retracted it via S8-001 | none |
| TESTS A2 | θ_E2 = θ_E1 β^{−1/(γ′−1)} (and m₂ scaling) | consistent: eq. mp_etaB (tex:501-503); the m₂ scaling is not in this chapter | none |
| TESTS B1 | α₂ = α₁/B (lenstronomy, 1e−16) | consistent: eq. mp_Bdef, check 2a | none |
| TESTS C2 | elliptical θ_E scale f(q,γ) is code-specific; don't cross-wire | consistent: annotation tex:747-754 ("fit both planes with one code and one convention") | none |
| TESTS H0 | B = 0.8200775769, S_w = −0.0157139331, S_Ωm = −0.0254559324 (Wolfram vs astropy < 1e−9) | n.a. (different geometry). Re-verified with the chapter's method: B reproduced to 1e−9 (R1 PASS). The derivative limit is S_w = −0.015725, S_Ωm = −0.025472. The quoted values are finite-step central differences (S_w ≈ step 0.05, S_Ωm ≈ step 0.02), 0.07% off the derivative | feedback item 2 |
| TESTS D2 | instantaneous-w vs CPL dark-energy density | n.a.: the chapter uses constant w only and writes the correct general ζ(z) = exp[3∫(1+w)/(1+z′)dz′] (tex:145-148, check 5a). No CPL formula appears | none |
| HANDOFF 09-21 §5–6 | retractions (θ_B/θ_BH, γ = 1.288, Ω_m ±0.3%, Horseshoe, …) | n.a.: none touch note1/note1b content that survived the port | none |

**Chapter critic's flags re-checked against the spiral record:**
- **F2 / C11** (Collett+2012 "differently oriented band"): **resolved, PASS.** Collett+2012 §4 (p. 5 of `Reference_papers/Collett2012_DSPL_forecast.pdf`) says: "the exact nature of the degeneracy between the two parameters varies with z_l, z_s1, and z_s2 … the precision could scale better or worse than √n depending on the widths and orientations of the constraints from each system." A numerical check agrees (reconcile R2b): dw/dΩ_m|_B = −1.081 at (0.5,1,2), −1.620 at (0.68,1.52,2.11), −0.873 at (0.3,0.6,3.3).
- **F4 / C13** (KSB94 normalisation): **resolved** (see S6-038/039 row).
- **F1, F3, F5**: the spiral record has nothing on these (SEF's private-communication footnote and the shear critical-curve caveat are chapter-specific; for F1, the spiral's S6-066 notes that its own C10 corner cell had no radial image, which does not bear on the chapter's general statement). They stay as flagged.
- **N14/N15** (0.6452/−0.4382 rounding): chapter-only. The spiral's numbers are at different η and the issue does not arise there.
- **X10 "two port corrections"** (α̂_i(D_iθ_i) vs the note's α̂_i(θ_i); coupling evaluated at D_s1β_1): **the spiral record does not know about these.** Packet critic, 07-11 and 07-13 reports are silent. See feedback item 1.

### New fixes for the fix pass (not already in the Flagged section)

- **A (S6-013 class, substantive).** Every δw quoted from δB/B is a projection at fixed Ω_m, and the chapter never says so. In its own §"Why one lens gives a curve", a single lens leaves δw unbounded along the level curve. Proposed edits:
  (i) tex:603-609, after eq. mp_propagate: "…evaluated at a reference cosmology, each with the other parameter held fixed."
  (ii) tex:641-642: "A 1% error in B masquerades as |δw| = 0.30 at this geometry if Ω_m is held fixed (check 5g)."
  (iii) Summary tex:948-949: same qualifier.
  (iv) Soln:93-95 (Ex. 3c) and Soln:285 (Ex. 10): "at fixed Ω_m". At Soln:285 replace "from this single lens" with "from this single lens, at fixed Ω_m (with Ω_m free, one lens leaves w unconstrained along the degeneracy of Exercise 9)".
  Optionally add one sentence with the numbers from reconcile R3: the exact fixed-Ω_m roots are asymmetric (−1% → δw = +0.29, +1% → δw = −0.36), and letting Ω_m move with dΩ_m = −½dw doubles the shift (0.66).
- **B (S6-028).** Keybox tex:369-371: "All the deflector physics cancels in B; only the geometry --- hence the cosmology --- survives" is true of the deflection ratio α_2/α_1 but not of the inference, which (§mp_eta) needs γ′. Proposed: "The deflector's mass distribution cancels in the ratio α_2/α_1 = 1/B, which is pure geometry; turning a measured Einstein-radius ratio into B still requires the deflector's slope (§\ref{sec:mp_eta})."
- **C (S6-088, upgrades P3 from prose to substance).** Summary tex:950-951 "a population constrains a point" is false as written. Proposed: "One lens constrains a curve in (Ω_m, w). Lenses at different redshift triplets give differently oriented curves (\citep{collett_2012}), so a sample shrinks the allowed region." Collett+2012 §4 supports this (F2 resolution above).
- **D (S6-027, prose, optional).** tex:83-86: fold the em-dash appositive into the clause: "…cancels the deflector mass, leaving a dimensionless ratio of distances that depends on the shape of the expansion history, (Ω_m, w), but, as we will show, not on the Hubble constant."
- **E (housekeeping).** Close F2 and F4 in the verdict table (C11 ⚠ → ✅ via Collett+2012 §4 p. 5; C13 ⚠ → ✅ via KSB94 eqs. 15, 21a–d, p. 287). Optionally attach the KSB94 ADS scan to Zotero CW87FPFT (it currently has no child items). The spiral's S6-039 says it read the scan "via Zotero CW87FPFT", but no attachment exists there now.

### Feedback to the spiral project (errors the spiral record does not yet know about)

1. **note1_multiplane_dspl.tex:84-86 (eq:multiplane) and note1b_dspl_inference.tex:196-198 (eq:coupling): argument of the physical deflection.** Both write the physical deflection α̂_i at an angular argument: α̂_i(θ_i), and α̂_1(β_1) in note1b. SEF eq. 9.3 evaluates it at the physical impact position ξ_i = D_i θ_i. The chapter writes α̂_i(D_i θ_i) and α̂_s1(D_s1 β_1) (tex:185, 430). Its comoving ray trace through three planes with arbitrary nonlinear physical deflections reproduces that form to 8.5e-22 rad (chapter critic D1; `multiplane_dspl.wl` checks 1a–1d). The notes' form is only correct if α̂_i is read as a function of angle with D_i absorbed. This is a notation ambiguity rather than an error in any number. It matters most in note1b, whose eq:coupling mixes a reduced main-lens deflection with a physical source-1 deflection in one line.
2. **TESTS H0 / `beta_sensitivity.py` S_w, S_Ωm are finite-step central differences, quoted to 10 digits.** At (0.68,1.52,2.11) in flat ΛCDM, Ω_m = 0.3, my quadrature reproduces B = 0.8200775769 (to 1e−9). The derivative limit, however, is S_w = −0.015725 and S_Ωm = −0.025472. The record's −0.0157139331 matches a central difference with step 0.05 in w (to 3e−5 relative); its −0.0254559324 matches step 0.02 in Ω_m (`fdstep.wl`). So the "<1e−9" agreement in H0 compares two implementations of the same finite step, not the derivative. The physics is unaffected (0.07%; 1/S_w = −63.59 vs −63.64), but the 10-digit precision is spurious, and the same digits feed `cosmology_impact.json:jacobian`. Suggest quoting S_w = −0.01572 (derivative) or labelling the step.
3. **S6-088's fix is supported by Collett+2012.** For the note1b:178-179/381 rewrite, cite Collett+2012 §4, p. 5 ("…varies with z_l, z_s1, and z_s2 … widths and orientations of the constraints from each system"). It is in the project's own `Reference_papers/Collett2012_DSPL_forecast.pdf`. Degeneracy slopes for the record: −1.620 at the project triplet, −0.873 at (0.3,0.6,3.3).
4. **S6-039 provenance.** The packet critic says it read KSB94 "via Zotero CW87FPFT → scanned PDF p. 288", but CW87FPFT has no attachment today. The page and equations it quotes are correct (ADS scan pp. 287–288, eqs. 21b, 26–27), so the verdict stands; only the stated path is wrong. Also, note1b's κ = (√q/2) b/√(θ1² + q²θ2²) is KSB94 21b with b ≡ ξ0-scaled length in the same orientation as KSB94, so the July "PLAUSIBLE, confirm against KSB94 §2" open item (07-13 report) can be closed.

## Resolution — fixes applied 2026-10-14

Fix pass on branch `wt/ch14` (after merging `annotated-edition`). Line numbers refer to the pre-fix file.

| id | Fix | Backing |
|----|-----|---------|
| F1 (D-rad) | §mpi_degeneracy (tex:870-876) rewritten: stellar kinematics (Ch. 13), radial thickness of extended arcs (radial eigenvalue γ′−1 at θE, radial magnification 1/(γ′−1)) and a radial/central image are three equal anchors; the Ch. 20 "combination of inner slope and central mass" caveat is now explicit. Soln Ex. 10 "in practice, detecting … radial or central image" replaced by the same three anchors; Ex. 10 statement "a detected radial image" → "a better constraint on the slope". | `multiplane_dspl.wl` check 3h (symbolic); Ch. 20 annotation 16_Odd_Images…tex:880-888 |
| F2 / C11 | Cite kept; verdict closed ✅. Body sentence (tex:826-828) gains `\annot{check 5n: slope −0.87 at (0.3,0.6,3.3)}`. | Collett+2012 §4 p. 5 (reconciler); `multiplane_dspl.wl` check 5n |
| F3 / C4 | Annotation tex:305-307: "a numerical two-point-mass study" → "an unpublished (private-communication) numerical two-point-mass test". | SEF p. 282 footnote 1 |
| F4 / C13 | Verdict closed ✅. Optional clause applied (visible): "following KSB94, whose eq. (21b) is this form with the axes rotated by 90°". | KSB94 eqs. 15, 21b (reconciler, ADS scan p. 287); `multiplane_dspl.wl` check 4g (rotated form equal, unrotated form differs) |
| F5 | Ex. 7(b) statement: "(Here η is the ratio of the fitted θE parameters; with shear present, radii read off the critical curves do not scale by exactly 1/B.)"; Soln 7(b) gives the reason (SIE term degree 0, shear term degree 1). | `multiplane_dspl.wl` check 4h (q = 0.7, γ = (0.08, 0.03): area-equivalent critical-curve ratio 0.6714 vs B = 0.6742; this pass's own trace, not the critic's 0.6775, which presumably used a different radius definition — no number is quoted on the page) |
| A (i) | After eq. mp_S / mp_propagate: "each with the other parameter held fixed" (×2). | definitional |
| A (ii) | tex:641-646: "If Ω_m is held fixed, a 1% error … |δw| = 0.30"; new sentences: exact fixed-Ω_m roots −1% → δw = +0.29, +1% → δw = −0.36; along dΩ_m = −½dw, |δw| = 0.66; along the degeneracy curve unbounded. | checks 5g (0.303), 5l (+0.288 / −0.359; fails on a symmetric ±0.30), 5m (0.659) |
| A (iii) | Summary tex:947-949: "with Ω_m held fixed". | check 5g |
| A (iv) | Soln Ex. 3(c): "gives, at fixed Ω_m, δw = +0.40"; Soln Ex. 10: "…= 0.33 from this single lens, at fixed Ω_m. With Ω_m free, one lens leaves w unconstrained along the degeneracy of Exercise ~\ref{ex:mpi_degeneracy}." | `problems_14.wl` 3f (computed at fixed Ω_m), 9a–9d |
| B (S6-028) | Keybox tex:369-371 → "The deflector's mass distribution cancels in the ratio α₂/α₁ = 1/B, which is pure geometry. Turning a measured ratio of Einstein radii into B still requires the deflector's slope (§mp_eta)." | check 2a; §mp_eta (checks 3c–3g) |
| C (S6-088) | Summary tex:950-951 → "One lens constrains a curve in (Ω_m, w). Lenses at different redshift triplets give differently oriented curves \citep{collett_2012}, so a sample shrinks the allowed region." | Collett+2012 §4 p. 5; check 5n |
| D (S6-027) | tex:83-86 em-dash appositive folded into the clause ("…cancels the deflector mass, leaving a dimensionless ratio of distances that depends on …"). | prose |
| P1 | "A tempting shortcut is fatal." → "One shortcut invalidates the inference." | prose |
| P2 | Em-dash pivot + triad (tex:642-646) split: "A single DSPL therefore gives only a weak w constraint, and populations of DSPLs are needed. For the same reason, percent-level systematics in B matter." (merged with fix A). | prose |
| P3 | Superseded by fix C. | — |
| E | C11 and C13 verdict rows updated above. | — |

### Verification after edits

- `bash Mathematica/run_wl.sh Mathematica/14_Multiplane_DSPL/multiplane_dspl.wl`: before `SUMMARY: 56 PASS, 0 FAIL  (of 56 checks)`; after `SUMMARY: 62 PASS, 0 FAIL  (of 62 checks)` (new: 3h, 4g, 4h, 5l, 5m, 5n).
- `bash Mathematica/run_wl.sh Solutions/14_Multiplane_DSPL/problems_14.wl`: `SUMMARY: 49 PASS, 0 FAIL  (of 49 checks)` (unchanged; no Solutions number changed).
- `cd Notes && ANNOT_REQUIRED=1 bash build.sh`: "all assertions passed". Student 360 pp (text-md5 cdfaf3529f0f047faf86e06086d199ad), Solutions 444 pp (bc8d3f15e4e54cf6036282ac3e3629ca), Annotated 567 pp (fe79b8b7c8ac8b30eab5f9bff6c53f21, sentinels 508). Label-uniqueness lint empty. New sentences confirmed in `pdftotext` of the student PDF; `[check …]` tags appear only in the Annotated edition.

### Left open

- P4, P5, P6: kept (rated acceptable by the critic).
- Visible check tag "(`multiplane_dspl.wl` check 5a.)" (tex:149) still prints in the student edition (verified by `pdftotext`); the Ch. 15 `\annot{}` policy (tracker TODO under the ch15 critic) was not in this pass's confirmed list, so it is left for the orchestrator.
- `references.bib` comment-placement remark (out of scope; bib not editable by chapter agents).
- Attaching the KSB94 scan to Zotero CW87FPFT (optional, orchestrator).
