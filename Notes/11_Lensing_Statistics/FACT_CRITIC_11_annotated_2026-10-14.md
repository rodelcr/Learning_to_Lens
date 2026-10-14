# fact-critic report — Notes/11_Lensing_Statistics/11_Solutions.tex (Annotated Study Edition layer)

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation (+ Provenance summary)
> Scope: boxes added in commit 0214efd in `11_Solutions.tex` + appended checks of
> `Solutions/11_Lensing_Statistics/problems_11.wl`. No author flags concern this module.
> Active adapters this run: bibtex ✓, crossref-web — not exercised (no `\cite` in the layer),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓, overlay AGEL/Zotero (SKW 2006 PDF) ✓,
> derivation adapter wolframscript ✓.
> Critic script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_1013/critic_1013.wl`
> → `SUMMARY: 44 PASS, 0 FAIL (of 44)`.

Repo script: `bash Mathematica/run_wl.sh Solutions/11_Lensing_Statistics/problems_11.wl` →
`=== 8/8 Module 11 solution checks passed ===`, `ALL MODULE-11 SOLUTION CHECKS PASS`,
`SUMMARY: 20 PASS, 0 FAIL  (of 20 checks, incl. annotated-edition)`.

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| D1 | Derivation | "b² − 4ac = 16(μ²−1)² + 16(μ²−1) = 16μ²(μ²−1)", "u = −2 ± 2μ/√(μ²−1)", lower root < −2 rejected | ✅ PASS | problems_11.wl checks "11.1(a) discriminant…", "(-b + Sqrt[disc])/(2a)…", "other root…" PASS | none |
| D2 | Derivation | "y²(μ) = μ⁻² + ¾μ⁻⁴ + O(μ⁻⁶)", "−d(y²)/dμ → 2μ⁻³" | ✅ PASS | critic L13 (independent series); repo checks PASS | none |
| N1 | Number | "y²(μ) = 1 at μ = 3/√5 = 1.342 … A = 1.34" | ✅ PASS | critic L13; 13_Microlensing.tex:169 "A(1) = 3/√5 ≈ 1.34" | none |
| N2 | Number | "r = 10 gives y < 9/11 and σ = 0.669 πθ_E²" | ✅ PASS | critic L14 (81/121 = 0.6694) | none |
| D3 | Derivation | "y = (r−1)/(r+1)"; "signed magnifications sum to μ₊+μ₋ = 2, not 2/y" | ✅ PASS | repo checks "11.2 solving…", "11.2 signed…" PASS; critic L18 (SIS signed μ) | none |
| D4 | Derivation | "∫^∞ μ^{β−3}dμ … equals 1/(2−β) from μ = 1 and diverges as β → 2" | ✅ PASS | critic L15 | none |
| X1 | Consistency | "This is why the main text says the bias 'grows sharply as β → 2'" | ✅ PASS | 11_Lensing_Statistics.tex:227–228 "the bias integral grows sharply as $\beta \to 2$" | none |
| X2 | Consistency | constant-μ factor "μ₀^{β−1}" | ✅ PASS | follows from visible eq. ⟨μ^β⟩/⟨μ⟩ (11_Solutions.tex, Ex 11.3 display) with p = δ(μ−μ₀) | none |
| X3 | Consistency | annotation "Module 12 calls the same slope α … null at slope 1 reappears there" | ✅ PASS | 12_Solutions.tex derivation 12.1(c) n/n₀ = 1 + 2(α−1)κ; critic L5 (α = 1 null) | none |
| X4 | Consistency | annotation: optical depth = sum of areas over lenses per unit sky (Eq. optical_depth) | ✅ PASS | 11_Lensing_Statistics.tex:160–169 | none |
| X5 | Consistency | bridge: "τ ∝ n_com(σ_v/c)⁴ × (volume factor)"; "for an isothermal main lens σ_v cancels in that ratio" | ✅ PASS | repo check "11 bridge: SIS Einstein-radius ratio … independent of sigma_v" PASS; SIS cross-section πθ_E² ∝ σ⁴ (same script's θ_E law) | none |
| X6 | Consistency | cross-refs `ch:microlensing`, `ch:weak_lensing`, `ch:cosmological_sensitivity`, `eq:optical_depth`, `ex:magnification_high_z` | ✅ PASS | labels resolve; ch. 20 = "Cosmological Sensitivity of Compound-Lens Ratios" (20_Cosmological_Sensitivity.tex:13–14), which discusses a ratio constraining a *direction* in (Ω_m,w0,wa) (lines 30, 42) | none |

Counts: ✅ 12 · ⚠ 0 · ❌ 0.

## Applied (auto-fixes)

None.

## Flagged — your hand required

Nothing in the layer needs a fix.

Repo-check quality note (non-blocking): the second clause of the problems_11 check "11.3 … diverges as
beta->2" (`!FreeQ[Quiet@Check[Integrate[mm^(2 - 3), …], $Failed], …]`) is convoluted. Its first clause
is the real test, and the critic re-derived it independently (L15).

## Prose (LLM tells): flag-only

568 added words; em-dashes 0; one "not 2/y" contrast (it carries physics); `\emph` 3, all on contrastive
terms. The text reads clean.
- P1 ⚠ "It is not a probability." A short declarative after an emphasised definition; fine, optional to merge.

## Provenance (machine-drafted text): flag-only

Commit 0214efd is Claude-co-authored, so all 568 added words are machine-introduced (100% of the layer).
Advisory: the author should reread the boxes and rewrite them in their own words.

## Derivation checks

Script `critic_1013.wl` (path above) → `SUMMARY: 44 PASS, 0 FAIL (of 44)`. Module-11 rows:
- L13 μ_p(1) = 3/√5; y²(μ) = μ⁻² + ¾μ⁻⁴: PASS.
- L14 ((r−1)/(r+1))² = 0.669 at r = 10: PASS.
- L15 ∫₁^∞ μ^{β−3}dμ = 1/(2−β): PASS.
- L18 SIS signed magnifications sum to 2: PASS.
