# Fact-critic brief — Part V chapters and annotation layers (Phase 2)

You are an INDEPENDENT critic: you did not write this content and must not trust its author.
Load and follow the `fact-critic` skill (`~/.claude/skills/fact-critic/SKILL.md`, `references/lenses.md`,
`references/adapters.md`, `references/verdict-template.md`, `local/agel-sources.md` overlay). Use the
`gr-lensing-intuition` skill for physics context, but NEVER mark a claim PASS from memory or from a skill
file — every PASS names an external artifact: a `.bib` key + CrossRef-confirmed DOI, a page/equation in a
PDF under `Reference_Texts/` (read it with `pdftotext -f N -l M`), a `check[]` in a `.wl` that you RAN via
`bash Mathematica/run_wl.sh` (quote its PASS line), or an in-repo `path:line`. No adapter → cap at ⚠ SUSPECT.

Lenses: Citation (every \citep/\citet and every textual attribution "X showed"), Number (every
numerical value, exponent, limit, inequality), Consistency (any quantity stated more than once; equation
numbers/labels cross-referenced; the chapter vs its Solutions vs its .wl), Prose (LLM tells: triads,
"not X but Y" pivots, em-dash cascades, aphoristic closers, intensifiers), Derivation (NEW for this repo:
pick the five most load-bearing displayed equations in the chapter, re-derive each independently in a
scratch `.wl` under the scratchpad — not in the repo — and report PASS/FAIL with the script path).

Specific traps to test for in Part V (do not assume the author avoided them):
- multi-plane index conventions: β_ij = D_ij D_s /(D_j D_is) vs its transpose; D_ss = 0 (not D_s);
  reduced vs physical deflection mixed; the sum running to j−1 with the coefficient D_ij/D_j
- B = D_ls1 D_s2/(D_s1 D_ls2) < 1 and B = η^(γ'−1) (not η^(1/(γ'−1)); B = η at γ' = 2)
- power law: κ(θ_E) = (3−γ')/2; α ∝ θ^(2−γ'); θ_r = θ_E (2−γ')^(1/(γ'−1)) exists only for 1 < γ' < 2
- point mass: λ_r = 1 + θ_•²/θ² > 0 (no radial critical curve), 2 images always
- MST: κ_λ = λκ + 1 − λ, β_λ = λβ, Δt ∝ λ, det A ∝ λ²; H0^true = λ H0^naive (sign as in Chapter 13)
- Burke's theorem hypothesis: smooth bounded Σ; a point mass violates it
- multipoles: ∇²ψ_m = 2κ_m; zero enclosed mass for m ≥ 1; the k_m = a_m(3−γ') convention
- CPL: ζ(z) = (1+z)^{3(1+w0+wa)} exp(−3 wa z/(1+z)); ζ ≡ 1 for ΛCDM
- every "Chapter~\ref{ch:...}" points at the chapter whose content it describes (open the PDF TOC)
- project leakage: `grep -nEi 'tier|scripts/|results/|lenstronomy|autolens|J0946|AGEL|Carousel|this project'`
- citations: the bib entry's title/venue/year must match the claim; Schneider 2014 = A&A 568 L2 (cosmological
  parameters from multi-plane systems), Schneider 2019 = A&A 624 A54 (generalized multi-plane MST, arXiv 1409.0015);
  Burke 1981 = ApJ 244 L1 DOI 10.1086/183466.

Output: `Notes/<NN>_*/FACT_CRITIC_<NN>_<Name>_2026-10-14.md` in the repo you are given (verdict-template
format; active-adapters header REQUIRED; `## Verdicts` table with ids C*/N*/X*/P*/D*; `## Applied (auto-fixes)`
— apply ONLY the two auto-fixable classes (single-source number typo; number-vs-number consistency) and
only inside the chapter's own files; `## Flagged — your hand required`; `## Prose`; `## Derivation checks`
with the scratch script path and its SUMMARY line). Do not rewrite prose. Do not touch files outside the
chapter's directories except to create the report. If you ran a repo `.wl`, quote its SUMMARY. Commit the
report (and any auto-fix) on the branch of the worktree you were given. Your final message = the report's
verdict counts + the full Flagged section + the Derivation section.
