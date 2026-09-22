# fact-critic report — Notes/12_Weak_Lensing/ (chapter + solutions)

> Date: 2026-09-22 · Lenses: Citation, Number, Consistency, Prose
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (CrossRef +
> arXiv reachable; ADS returns 405/human-verification → unavailable; Semantic Scholar 429),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓, overlay: Zotero (source-book PDF
> `NNNRZT8L`/`DXHVNN2Y`, Part 3 extracted page-by-page via `pdftotext`, book pp. 269–451) +
> Mathematica (`wolframscript`) + Python recompute.
> (A claim whose lens has no active adapter is capped at ⚠ SUSPECT — see flagged rows.)

Scope: `12_Weak_Lensing.tex` (849 lines) and `12_Solutions.tex` (241 lines).
First full per-chapter pass. It **closes the ⚠ item left open by the 2026-07-14 gap-fill report**:
every Part 3 equation number the chapter cites has now been opened individually.

**Engine checks run this pass:**
- `Mathematica/12_Weak_Lensing/weak_lensing.wl` → **10/10 PASS**
- `Solutions/12_Weak_Lensing/problems_12.wl` → **14/14 PASS**
- Independent checks: Python NFW γ_t profile; Mathematica scratch script (Exercise 12.5(c)
  power-law integrals, eq. 113 identity, NFW central limit).
- (Both `.wl` re-export figures as a side effect; the regenerated PDFs were reverted.)

**Headline:** all **22 equation-number citations are exact** (eqs. 6, 7, 8, 12, 14, 15, 16, 17,
19, 24, 27, 41, 43, 44, 50, 51, 93, 99, 104, 105, 108, 109). The epigraph is verbatim.
Defects found: **1 physics error** (NFW "peak" in Solution 12.2(d), plus a misleading figure
caption and exercise wording), **1 defective exercise** (12.5(c)), **1 misattribution**
("result of Schneider (2006)" is Bartelmann 1995 per the source), 5 plain-text citations
not in the `.bib`, and 2 imprecise physics phrasings. 0 auto-fixes.

## Verdicts

### Citations — equation numbers (all checked in the Part 3 PDF text)

| id | cited as | verdict | source checked |
|----|----------|---------|----------------|
| C1 | eq. 6 (Q_ij) | ✅ PASS | book p.274 eq. (6) |
| C2 | eq. 7 (χ, ε) | ✅ PASS | p.274 eq. (7) |
| C3 | eq. 8 (\|χ\|, \|ε\| vs r) | ✅ PASS | p.274 eq. (8) (the transform eq:wl_chi_eps_transform = book eq. 9; not cited, correct) |
| C4 | eq. 12 (ε^(s), \|g\|≤1) | ✅ PASS | p.275 eq. (12) |
| C5 | eq. 14 (E[ε]=g) | ✅ PASS | p.276 eq. (14) |
| C6 | eq. 15 (σ_ε/√N) | ✅ PASS | p.276 (text before eq. 15 gives σ_ε/√N; eq. 15 is the refined form) |
| C7 | eq. 16 (γ≈g≈⟨ε⟩≈⟨χ⟩/2) | ✅ PASS | p.277 eq. (16) |
| C8 | eq. 17 (γ_t, γ_×) + sign convention | ✅ PASS | p.277–278 eq. (17) and the sign explanation |
| C9 | eq. 19 (S/N ∝ θ_E√n/σ_ε; galaxies σ_v≲200 km/s undetectable) | ✅ PASS | p.278–279 eq. (19) and the text after it |
| C10 | eq. 24 (⟨γ_t⟩ = κ̄ − ⟨κ⟩) | ✅ PASS | p.280 eq. (24) |
| C11 | eq. 27 (n/n₀ ≈ 1+2(α−1)κ) | ✅ PASS | p.280 eq. (27). Note: α here is the count slope n₀∝S^−α, which the chapter never defines; α is also this book's symbol for deflection. |
| C12 | eq. 41 (kernel D) | ✅ PASS | p.316 eq. (41) |
| C13 | eq. 43 (D̂) | ✅ PASS | p.316 eq. (43) |
| C14 | eq. 44 (KS inversion) | ✅ PASS | p.316 eq. (44) |
| C15 | eq. 50 (non-linear KS) | ✅ PASS | p.318–319 eq. (50) |
| C16 | eq. 51 (MST) + μ→λ⁻²μ | ✅ PASS | p.319 eq. (51) and the text after it |
| C17 | eq. 93 (effective κ) | ✅ PASS | p.358 eq. (93); g(w) = book eq. (94) matches |
| C18 | eq. 99 (P_κ, Limber) | ✅ PASS | p.360 eq. (99) |
| C19 | eqs. 104–105 (ξ±, J₀/J₄) | ✅ PASS | p.362 eqs. (104), (105) |
| C20 | eq. 108 (M_ap) | ✅ PASS | p.363 eq. (108) |
| C21 | eq. 109 for "ℓ ∼ 5/θ" (l.608–609) | ⚠ SUSPECT (misplaced) | eq. (109) gives the filter 576J₄²/η⁴ but not the ℓ∼5/θ statement. That statement is on **p.365** (§6.3): "at ℓ ∼ 5/θ". Cite "Part 3, eq. 109 and p. 365" or "Sect. 6.3". |

### Citations — sections, attributions, `.bib`

| id | quoted | verdict | source checked | proposed fix |
|----|--------|---------|----------------|--------------|
| C22 | Epigraph "One cannot 'see' the effect …" — P. Schneider, *Weak Gravitational Lensing* (2006) | ✅ PASS (verbatim) | Part 3 §1, p.271 | none |
| **C23** | "A beautiful result of Schneider (2006) is that a nearly identical relation holds …" (l.275) | ❌ FAIL (misattribution) | p.280: the book credits the general-lens result to **Bartelmann (1995)**; Schneider (2006) is a review re-deriving it. The chapter also cites "(Bartelmann 1995)" at l.293, so it contradicts itself. | "A remarkable result (Bartelmann 1995) is that …", keeping the eq. 24 pointer to the book. |
| C24 | "(Bartelmann 1995)" plain text (l.293) | ⚠ SUSPECT (not in `.bib`; unverifiable here) | Book reference list: "Bartelmann, M. 1995, A&A 303, 643". No DOI (pre-2000 A&A). Not on arXiv under that search. ADS gated (405). Not in Zotero. **Title not confirmed**, so I did not write a `.bib` entry. | Option A: author confirms the ADS record (bibcode `1995A&A...303..643B`), then add the `.bib` entry and Zotero item. Option B: phrase as "(Bartelmann 1995; see \citealp[Part~3, p.~280]{schneider_kochanek_wambsganss_2006})" with no new entry. |
| C25 | "(Gunn 1967; Blandford et al. 1991; …)" plain text (l.526) | ✅ exists / not in `.bib` | CrossRef 10.1086/149378 (Gunn, ApJ 150, 737, 1967); 10.1093/mnras/251.4.600 (Blandford, Saust, Brainerd & Villumsen, MNRAS 251, 600, 1991). Book p.355 credits the LSS-lensing idea to both. | Add `gunn_1967`, `blandford_1991` to the `.bib` + Zotero; `\citep`. |
| C26 | "Brainerd et al. 1996" plain text ×2 (l.638, 658) | ✅ exists / not in `.bib` | CrossRef 10.1086/177537 (ApJ 466, 623). Book pp.407, 409 "first detection" | Add `brainerd_1996` to the `.bib` + Zotero; `\citep`. |
| C27 | `\citep{kaiser_squires_1993}`, `\citealp{bartelmann_schneider_2001}`, `\citep{schneider_kochanek_wambsganss_2006}` | ✅ PASS | `.bib` entries (CrossRef/Zotero-verified in the 2026-07-14 pass) | none |
| C28 | PSF "circularizes small images" as the central challenge (Part 3, Sect. 3; BS01) | ✅ PASS | book Part 3 p.273 ("blur – and thus circularize"), §3 | none |
| C29 | Correlation functions usable across gaps/masks | ✅ PASS | book p.365 | none |
| C30 | ξ×/B-modes flag systematics (l.600–601; Sol. 12.5(b) "PSF residuals, intrinsic alignments") | ✅ PASS | book §6.5 p.371: deviations signal "noise, remaining systematics, or other effects", incl. non-lensing shear | none |

### Numbers / physics

| id | quoted | verdict | source checked | proposed fix |
|----|--------|---------|----------------|--------------|
| N1 | σ_ε ≈ 0.3 | ✅ PASS | eq. (19) normalization σ_ε/0.3 | none |
| N2 | "n ∼ 10–40 galaxies per arcmin²" (l.105) | ⚠ SUSPECT | book: ~20 arcmin⁻² in ~2 h and ~30 in ~3 h on a 4-m telescope (pp.276, 281); 17 and 30 in survey examples. The range is looser than the source. | "n ∼ 20–30 arcmin⁻² from a few hours on a 4-m telescope" |
| N3 | SIS κ=θ_E/2θ, κ̄=θ_E/θ, γ_t=θ_E/2θ; point mass γ_t=θ_E²/θ² | ✅ PASS | `weak_lensing.wl` (4),(5); problems 12.2(a,b) | none |
| N4 | MST: g invariant, μ→λ⁻²μ | ✅ PASS | `.wl` (6),(7); book p.319 | none |
| N5 | KS: D̂D̂*=π², inversion, P_γ=P_κ | ✅ PASS | `.wl` (1)–(3); problems 12.3 | none |
| N6 | χ/ε relations, weak limit \|χ\|≈2\|ε\| | ✅ PASS | `.wl` (8a,b),(9); problems 12.4 | none |
| N7 | Cosmic-shear amplitude ∼σ₈Ω_m^0.5, like cluster abundance | ✅ PASS | book p.367 ("∼σ₈Ω_m^0.5, very similar to the cluster abundance") | none |
| N8 | κ ∝ Ω_m because lensing responds to Δρ | ✅ PASS | book p.358 | none |
| N9 | Brainerd: σ* ≈ 160 km/s for L*; truncated isothermal ρ∝r⁻²→r⁻⁴, σ=σ*(L/L*)^{β/2}, s=s*(L/L*)^η, M∝σ²s; "millions" of lenses | ✅ PASS | book pp.407–409 (σ* ≈ 160 +50/−60 km/s) | none |
| N10 | Sol. 12.5(a) ξ₊ from ξ₋ integral relation | ✅ PASS | book eq. (113) p.364; Mathematica scratch check: holds exactly for P_κ=A/ℓ | none |
| N11 | Sol. 12.5(d): W_ap ∝ J₄²/η⁴, W_TH = 4J₁²/η² | ✅ PASS | book eqs. (106), (109) | none |
| **N12** | Sol. 12.2(d): NFW γ_t "rises, peaks near the scale radius x∼1, and then declines" | ❌ FAIL (physics) | Python (1.3×10³ log-spaced points, x∈[10⁻³,10²], Module-7 f, g, κ̄; κ̄ consistency checked by quadrature): **γ_t is strictly monotonically decreasing**. It tends to a finite **κ_s/2** as x→0 (Mathematica limit: exactly 1/2). Local log-slope is −0.05 at x=0.1, −0.57 at x=1, −1.40 at x=10. The rendered `tangential_shear_profiles.pdf` shows no peak. | Replace with: "γ_t is finite at the centre (→κ_s/2, because the logarithmic κ and κ̄ divergences cancel), stays nearly flat inside θ_s, and steepens toward θ⁻² (with a log) outside. The *bend* near θ_s distinguishes NFW from the single power law of the SIS." |
| N13 | Fig. 12.x caption "the NFW tangential shear turns over near the scale radius" (l.507–508) and Exercise 12.2(d) "explain … why it turns over near θ_s" | ⚠ SUSPECT (misleading) | same evidence as N12. "Turns over" reads as a maximum; what actually happens is a change of logarithmic slope. | Caption: "…flattens to a finite central value inside θ_s and steepens outside it, unlike the single power law of the SIS." Exercise: "…explain why its logarithmic slope changes near θ_s". Add a Mathematica test (γ_t(0)=κ_s/2, monotone). |
| **N14** | Exercise 12.5(c): "For P_κ = Aℓ⁻², use ∫J₀(ℓθ)dℓ = 1/θ to compute ξ₊" | ❌ FAIL (defective exercise) | Mathematica: with P_κ=Aℓ⁻² the ξ₊ integral **diverges** (the identity doesn't apply: the integrand is J₀/ℓ). The solution concedes this ("Full marks for identifying the ℓ→0 convergence issue"). With **P_κ = Aℓ⁻¹**, ξ₊ = ξ₋ = A/(2πθ) exactly, and eq. 113 is satisfied (Mathematica: residual 0). | Change the exercise to P_κ = Aℓ⁻¹ (answer ξ₊ = A/(2πθ)); optionally add "(d′) show ξ₋ = ξ₊ for this spectrum, consistent with eq. 113". Update the solution and `problems_12.wl`. |

### Consistency / physics phrasing

| id | item | verdict | evidence | proposed fix |
|----|------|---------|----------|--------------|
| X1 | l.348–350: "adding a uniform sheet of convergence (1−λ) leaves the shear rescaled, γ→λγ" | ⚠ SUSPECT (imprecise) | book p.319: the *rescaling* κ→λκ gives γ→λγ; the *sheet* adds no shear. As written, the sheet seems to cause the rescaling. | "Scaling κ by λ scales the shear by λ, and the added uniform sheet contributes no shear, so γ→λγ and therefore …" |
| X2 | Sol. 12.3(c): "the additive constant κ₀ is the (1−λ) of the transform" | ⚠ SUSPECT (imprecise) | book p.319: in the linear KS inversion κ₀ is a pure additive sheet (γ unchanged). Only in the reduced-shear (non-linear) inversion does κ₀ map onto the λ-family, and then "κ₀ no longer corresponds to adding a uniform mass sheet". | "In the linear (γ≈g) inversion κ₀ is a uniform sheet, which produces no shear. When reduced shear is used (eq. 50), the freedom becomes the λ-transform of Exercise 12.1." |
| X3 | l.389: "the discovery that launched quantitative weak lensing" (KS93) | ⚠ SUSPECT | KS93 is a reconstruction *method*, not a discovery. The book (p.316) calls it "the original Kaiser and Squires method". | "the method that made weak lensing quantitative: …" |
| X4 | l.378 α in n/n₀≈1+2(α−1)κ is undefined | ⚠ SUSPECT | book p.280 defines n₀(>S)∝S^−α | add "for counts n₀(>S)∝S^{−α}" |
| X5 | Internal: MST, KS kernel, γ_t relations quoted in text, summary, exercises, solutions | ✅ PASS | internal: all occurrences agree | none |

## Applied (auto-fixes)

None. No number typo traces to a single canonical source. Every defect above is a citation,
physics, or wording issue, so it is flag-only.

## Flagged — your hand required

1. **N12/N13 — NFW γ_t has no peak** (solution wrong; caption and exercise misleading). Fix the
   wording and add a Mathematica test (central limit κ_s/2, monotone on a grid).
2. **N14 — Exercise 12.5(c)** asks for an integral that diverges. Switch to P_κ = Aℓ⁻¹
   (ξ₊ = A/2πθ) and update the solution and `.wl`.
3. **C23 — misattribution** of the general ⟨γ_t⟩=κ̄−⟨κ⟩ result to Schneider (2006); the book
   credits Bartelmann (1995).
4. **C24–C26 — five plain-text citations** (Bartelmann 1995; Gunn 1967; Blandford+1991;
   Brainerd+1996 ×2). Four are CrossRef-verified and ready for `.bib` + Zotero. Bartelmann
   1995's title could not be verified (ADS gated), so it needs your call (option A or B above).
5. **C21, N2, X1–X4** — minor: misplaced "ℓ∼5/θ" citation, loose n range, two imprecise MST
   phrasings, "discovery" wording, undefined α.

## Prose (LLM tells) — flag-only

- **Em-dashes:** chapter 30 in ~4 200 words (≈1/140, just over the ~1/150 signal); solutions 15
  in ~1 240 (≈1/83). Many are legitimate parentheticals in bullets.
- **Hollow intensifiers / emphasis inflation (chapter):** "spectacularly distorted" (l.27),
  "A beautiful result" (l.275, also misattributed), "The immediate and powerful implication"
  (l.293), "This has a profound consequence" (l.338), "nothing but" (l.412), "premier probe"
  (l.578), "particularly clean" (l.606), "the workhorse" (l.309). The source's own "remarkable
  result" (l.196, echoing book p.276) is acceptable. Plain rewrites: "strongly distorted";
  "Bartelmann (1995) showed that …"; "It follows that …"; "This has an important
  consequence"; "is the shear produced by a point mass"; "a leading probe"; drop "particularly".
- **Italic aphorisms:** l.205–206 (*"Each galaxy ellipticity is an unbiased — though very noisy
  — estimate …"*) and l.294–296 read as set-piece maxims in italics. They are accurate; consider
  plain roman type.
- **Solutions:** "a powerful null test" (sol. l.215) → "a null test".

---

## Resolution — fixes applied 2026-09-22 (author-approved)

| id | Fix | Backing |
|----|-----|---------|
| N12 | Sol. 12.2(d) rewritten: γ_t decreases monotonically, tends to a finite κ_s/2 at the centre, and approaches (2κ_s/x²)[ln(x/2) − ½] at large x. Log-slope ≈ −0.05 / −0.5 / −1.4 at x = 0.1 / 1 / 10. It bends; it has no maximum. | `problems_12.wl` **3 new tests**: central limit = 1/2 exactly; large-x series; strictly decreasing on a 201-pt log grid x∈[10⁻³,10²]. Mathematica slopes −0.046, −0.539, −1.40. (The report's earlier −0.57 at x=1 came from a coarse Python gradient; Mathematica's central difference gives −0.54.) |
| N13 | Figure caption and Exercise 12.2(d) now describe a change of slope, not a "turnover" | same tests |
| N14 | Exercise 12.5(c) now uses P_κ = Aℓ⁻¹ (ξ₊ = ξ₋ = A/2πθ) and asks why ℓ⁻² fails. Solution rewritten. | `problems_12.wl` **4 new tests** (replacing the old identity-only check): ξ₊, ξ₋ closed forms; the eq.-113 relation holds; ℓ⁻² integral does not converge |
| C23/C24 | "A beautiful result of Schneider (2006)" → `\citet{bartelmann_1995} showed …`; stray "(Bartelmann 1995)" removed | ADS abstract page read in browser (bibcode 1995A&A...303..643B; title "Cluster mass estimates from weak lensing"). Full text arXiv:astro-ph/9412051 **eq. (2.44)** is the general-lens result κ̄ = ⟨κ⟩+⟨γ_t⟩. **Zotero SPQPNC3P**; new `.bib` entry |
| C25 | Gunn 1967, Blandford+1991 → `\citep{gunn_1967, blandford_1991}` | CrossRef DOIs; **Zotero JR8E7SX2, WV43DQE2**; new `.bib` entries |
| C26 | Brainerd+1996 ×2 → `\citet`/`\citep{brainerd_1996}` | CrossRef 10.1086/177537; **Zotero DER2EF9E**; new `.bib` entry |
| C21 | ℓ∼5/θ now cited "eq. 109 and Sect. 6.3" | book p.365 |
| N2 | n range → "20–30 arcmin⁻² in a few hours on a 4-m telescope" | book pp.276, 281 |
| N7 | σ₈Ω_m^0.5 sentence now cites Part 3 Sect. 6.4 | book p.367 |
| X1 | MST text: the λ-scaling rescales γ; the sheet adds no shear | book p.319 |
| X2 | Sol. 12.3(c): linear vs reduced-shear (eq. 50) meaning of κ₀ | book p.319 |
| X3 | "discovery" → "method that made weak lensing quantitative" | book p.316 |
| X4 | Count slope α defined (and distinguished from deflection α) | book p.280 |
| Prose | "spectacularly", "beautiful", "immediate and powerful", "profound", "workhorse", "nothing but", "premier", "particularly", "powerful null test" removed or made plain | — |

Not changed (optional, author's call): the two italic set-piece sentences (l.205–206, and the
tangential-shear implication, now plain roman after the C23 rewrite).

**Verification after edits:**
- `weak_lensing.wl` 10/10; `problems_12.wl` **21/21** (was 14/14).
- `bash build.sh` → student **249 pp**, instructor **305 pp** (+1 each from the longer
  solutions and caption text); 0 LaTeX errors; new refs render ([1] Bartelmann, [10] Gunn,
  Blandford+91, Brainerd+96). Remaining "??" in the PDF are the 5 known Module 6 refs.
- `.bib` page fields contain only CrossRef/ADS-confirmed values (Blandford+91 600–627 per CrossRef).
- `VERIFICATION.md` Module-12 row and date updated.
