# fact-critic report — Notes/12_Weak_Lensing/12_Solutions.tex (Annotated Study Edition layer)

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation (+ Provenance summary)
> Scope: boxes added in commit 0214efd in `12_Solutions.tex` + appended checks of
> `Solutions/12_Weak_Lensing/problems_12.wl`; plus author flag (5) on visible 12.5(d).
> Active adapters this run: bibtex ✓ (`schneider_kochanek_wambsganss_2006`), crossref-web — not
> exercised (no `\cite` in the layer; SKW 2006 has no DOI in the bib), md-reflist ✗, values-file ✗,
> repo-grep ✓, doc-internal ✓, overlay AGEL/Zotero: local PDF of SKW 2006 (item NNNRZT8L,
> `~/Zotero/storage/DXHVNN2Y/…`, read with `pdftotext -f N -l N`) ✓, derivation adapter wolframscript ✓.
> Critic scripts: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_1013/critic_1013.wl`
> → `SUMMARY: 44 PASS, 0 FAIL (of 44)`; `critic_1013_c.wl` (⟨χ⟩ to O(g)).

Repo script: `bash Mathematica/run_wl.sh Solutions/12_Weak_Lensing/problems_12.wl` →
`SUMMARY: 18 PASS, 0 FAIL  (of 18 annotated-edition checks)` (all 40 printed PASS lines; no FAIL).

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| D1 | Derivation | "n(>S) = μ^{α−1}n₀(>S) … μ ≃ 1 + 2κ … n/n₀ ≃ 1 + 2(α−1)κ"; α = 1 null | ✅ PASS | critic L5 (series in ε, and α = 1 ⇒ 1) | none |
| N1 | Number | annotation: "SIS at θ = 2θ_E, κ = γ = 1/4 but g = 1/3 … a 33% error" | ✅ PASS | critic L6 (κ = γ = θ_E/2θ = 1/4; g = 1/3; (1/3)/(1/4) − 1 = 1/3) | none |
| X1 | Consistency | annotation "γ′ = λγ … only g is invariant" | ✅ PASS | visible 12.1(a,d) text in same file + MST algebra; repo check is tautological (see notes) | none |
| X2 | Consistency | bridge: "α′ = λα + (1−λ)θ sends β → λβ and leaves every image position and flux ratio unchanged" | ✅ PASS | repo check "12 bridge: MST … maps beta -> lambda beta" PASS; flux ratios: all μ scale by λ⁻² (det A ∝ λ²) | none |
| X3 | Consistency | bridge → `ch:msd_kinematics` "follows this degeneracy into multi-plane lenses and shows how stellar kinematics … fix λ" | ✅ PASS | 18_MSD_Kinematics.tex:13 chapter title "The Mass-Sheet Degeneracy in Multi-Plane Lenses and Kinematic Breaking" | none |
| D2 | Derivation | "M/(πD_d²Σ_cr) = (4GM/c²)D_ds/(D_dD_s) = θ_E²" | ✅ PASS | repo check "12.2(b)…" PASS (symbolic; trivial algebra re-done by critic by hand) | none |
| D3 | Derivation | NFW small-x: f → ln(2/x) − 1, κ̄/κ_s → ln(2/x) − ½, γ_t/κ_s → ½ | ✅ PASS | critic L1b (same series); repo checks "12.2(d) small x …" PASS | none |
| D4 | Derivation | NFW large-x: "g = π/(2x) − 1/x² + O(x⁻³)", "f = 1/x² + O(x⁻³)", "γ_t/κ_s ≃ (2/x²)[ln(x/2) − ½], the form quoted" | ✅ PASS | critic L17 (independent series); visible 12_Solutions.tex:155 has the same form | none |
| D5 | Derivation | "1 − \|χ\|² = 4r²/(1+r²)²" | ✅ PASS | repo check "12.4(b)…" PASS; critic L7b | none |
| D6 | Derivation | "\|χ\| = δ + δ²/2 + O(δ³) and 2\|ε\| = δ + δ²/2 + O(δ³). They agree through second order" | ✅ PASS | critic L7: \|χ\| − 2\|ε\| = −δ³/4 + O(δ⁴) | none |
| C1 | Citation (implicit) | annotation: "⟨ε⟩ = g holds exactly (for \|g\| ≤ 1) whenever the intrinsic orientations are random, eq. wl_expectation_eps" | ✅ PASS | SKW 2006 Pt 3 eq. (14), book p. 276 (PDF p. 289), via Zotero NNNRZT8L; in-repo eq. at 12_Weak_Lensing.tex:198–204 | none |
| N2 | Number | annotation: "⟨χ⟩ ≈ 2g holds only in the weak limit, and **beyond it** the mean of χ depends on the distribution of intrinsic ellipticities" | ❌ FAIL (scope of claim) | critic_1013_c: to first order in g, ⟨χ⟩ = 2g(1 − \|χ_s\|²/2) for \|χ_s\| = e with random phase (control ⟨ε⟩ = g exact). The dependence on the intrinsic distribution is already present at O(g). SKW 2006 Pt 3 p. 277 (PDF 290): "the expectation value of χ … depends explicitly on the intrinsic ellipticity distribution" | see Flagged |
| D7 | Derivation | 12.5(c): "∫₀^∞ J_ν(x)dx = 1 for ν > −1 (ν = 0, 4)"; "∫_θ^∞ dϑ/ϑ² = 1/θ, ∫ dϑ/ϑ⁴ = 1/(3θ³)" ⇒ bracket = 0 | ✅ PASS | critic L16; repo checks "12.5(c)…" PASS | none |
| X4 | Consistency | cross-refs `ex:bias_null`, `ch:lens_equation`, `ch:msd_kinematics`, `eq:wl_expectation_eps` | ✅ PASS | labels resolve (11_Lensing_Statistics.tex:292, 04_Lens_Equation.tex:10, 18_MSD_Kinematics.tex:14, 12_Weak_Lensing.tex:204) | none |
| VF5 | Number (visible) | 12.5(d): "samples P_κ near a single multipole ℓ ∼ 5/θ" | ✅ PASS — author flag NOT an error | SKW 2006 Pt 3 Sect. 6.3, book p. 365 (PDF p. 378): "…at ℓ ∼ 5/θ, provided P_κ has no sharp features"; W_ap = 576J₄²(η)/η⁴ is eq. (109), book p. 363 (PDF 376). Critic F5: argmax J₄²/η⁴ = 4.105; argmax ηJ₄²/η⁴ = 4.490; argmax η²J₄²/η⁴ = 4.811; mean η under ηW dη = 4.84 | optional sharpening (see Flagged) |

Counts (layer, 14 items): ✅ 13 · ⚠ 0 · ❌ 1. Visible flag: VF5 not an error.

## Applied (auto-fixes)

None.

## Flagged — your hand required

**N2 (layer) — ⟨χ⟩ annotation.** "…holds only in the weak limit, and beyond it the mean of χ depends on
the distribution of intrinsic ellipticities." This implies that in the weak limit ⟨χ⟩ is independent of the
intrinsic distribution. Averaging the SKW eq. (12) χ-transformation over a random source phase at fixed
|χ_s| = e gives ⟨χ⟩ = 2g(1 − e²/2) + O(g²) (the shear responsivity; critic_1013_c, with the control
⟨ε⟩ = g reproduced). Replacement:
"$\langle\chi\rangle \approx 2g$ holds only in the weak limit and for nearly round sources: to first order
$\langle\chi\rangle = 2g\,(1 - \langle|\chi^{(s)}|^2\rangle/2)$, so the mean of $\chi$ depends on the
distribution of intrinsic ellipticities (\citealp{schneider_kochanek_wambsganss_2006}, Part~3, p.~277)."
The visible 12.4(c) "⟨χ⟩/2 ≈ ⟨ε⟩ ≈ γ in the weak limit" matches SKW's own "γ ≈ g ≈ ⟨ε⟩ ≈ ⟨χ⟩/2" (p. 277)
and is fine as an approximation.

**VF5. Author flag (5), 12.5(d) "ℓ ∼ 5/θ": NOT wrong.**
- The text is about the filter W_ap ∝ J₄²(η)/η⁴ itself, which peaks at η = ℓθ = **4.10**.
- The dℓ-integrand ℓW(ℓθ) (flat P_κ) peaks at **4.49**.
- For reference, η²W peaks at 4.81, and the ηW-weighted mean of η is 4.84.
- "∼5/θ" is SKW 2006's own wording (Pt 3 p. 365), which the chapter cites at 12_Weak_Lensing.tex:612–614.
  It is an order-of-magnitude statement, and with "∼" it is defensible.

Optional sharpening for both occurrences (12_Weak_Lensing.tex:612 and 12_Solutions.tex:364):
"$\ell \approx 4$–$5/\theta$ (the filter $J_4^2(\eta)/\eta^4$ peaks at $\eta = \ell\theta \approx 4.1$)".

**Repo-check quality notes (non-blocking).**
- problems_12 "12.1 MST: gamma' = lambda gamma differs from gamma" tests `Simplify[lam gam - gam] =!= 0`
  with `gam` undefined, so it passes trivially.
- "12.1 SIS at theta = 2 thetaE" hard-codes κ = γ = 1/(2·2) rather than deriving them.
- Both statements are independently verified here (critic L6, X1), but the repo checks do not test them.

## Prose (LLM tells): flag-only

686 added words; em-dashes 0; one "rather than to g" (it carries physics); `\emph` 3.
- P1 ⚠ near-chiasmus: "Only $g$ is invariant, and only $g$ is measured." Rewrite: "Only the reduced shear
  $g$ is both invariant and measurable."
- P2 ⚠ emphasis inflation: "\emph{does} change", "\emph{second} order". Optional: drop the `\emph`.
- P3 ⚠ "so the factor 2 is better than the leading-order argument suggests" is a mild aphoristic closer.
  Plain: "so $|\chi| = 2|\epsilon|$ holds to $O(\delta^2)$."

## Provenance (machine-drafted text): flag-only

Commit 0214efd is Claude-co-authored, so all 686 added words are machine-introduced (100% of the layer).
Advisory: the author should rewrite the layer in their own words.

## Derivation checks

Script `critic_1013.wl` → `SUMMARY: 44 PASS, 0 FAIL (of 44)`. Module-12 rows:
- L5 n/n₀ = 1 + 2(α−1)κ and the α = 1 null: PASS.
- L6 SIS g = 1/3 at 2θ_E: PASS.
- L7/L7b |χ| − 2|ε| = −δ³/4 + …: PASS.
- L16 ∫J₀ = ∫J₄ = 1: PASS.
- L17 NFW large-x γ_t: PASS.
- F5 filter peaks 4.10 / 4.49: PASS.

Supplementary `critic_1013_c.wl`: ⟨χ⟩ = −(−2 + e²)g = 2g(1 − e²/2) ("equals 2g(1 - e^2/2): True"); control
⟨ε⟩ = g.
