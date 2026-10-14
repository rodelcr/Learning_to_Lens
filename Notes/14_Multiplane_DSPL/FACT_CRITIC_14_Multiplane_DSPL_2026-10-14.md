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
| C11 | "several lenses with different redshift triplets, each contributing a differently oriented band \citep{collett_2012}" | ⚠ SUSPECT (support) | Abstract discusses the Ω_M–w degeneracy being orthogonal to CMB/BAO. It does not say that different triplets give differently oriented bands. Full text not read. | see Flagged F2 |
| C12 | "cosmological constraints from an observed galaxy-scale DSPL were derived by \citet{collett_auger_2014}" | ✅ PASS | CrossRef 10.1093/mnras/stu1190 (MNRAS 443, 969): "Cosmological constraints from the double source plane lens SDSSJ0946+1006" | none |
| C13 | SIE normalisation "following \citet{kormann_isothermal_1994}" | ⚠ SUSPECT (existence only) | bib + Zotero CW87FPFT (A&A 284, 285; ADS-verified, no DOI). No PDF attached, so the normalisation itself was not checked against KSB94. In-repo eq. `sie_kappa` (08_Elliptical…tex:429-433) matches the chapter. | see Flagged F4 |
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
