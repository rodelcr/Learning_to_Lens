# fact-critic report — Notes/11_Lensing_Statistics/ (chapter + solutions)

> Date: 2026-09-22 · Lenses: Citation, Number, Consistency, Prose
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (CrossRef +
> arXiv reachable; ADS web UI returned 405 → unavailable), md-reflist ✗, values-file ✗,
> repo-grep ✓, doc-internal ✓, overlay: Zotero (source-book PDF `NNNRZT8L`/`DXHVNN2Y`,
> read page-by-page via `pdftotext`) + Mathematica (`wolframscript`) + Python recompute.
> (A claim whose lens has no active adapter is capped at ⚠ SUSPECT — see flagged rows.)

Scope: `11_Lensing_Statistics.tex` (283 lines) and `11_Solutions.tex` (86 lines).
First full per-chapter pass; the 2026-07-14 gap-fill report only sampled this module.

**Engine checks run this pass:**
- `Mathematica/11_Lensing_Statistics/lensing_statistics.wl` → **9/9 PASS**
- `Solutions/11_Lensing_Statistics/problems_11.wl` → **8/8 PASS**
- (The `.wl` re-exports `Figures/11_Lensing_Statistics/point_mass_cross_section.pdf` as a
  side effect; the regenerated file was reverted to the committed copy — no content change intended.)

**Headline:** 0 auto-fixes, 1 physics defect (eq. 101 Heaviside factor, inherited
verbatim from the source book), 1 misquoted epigraph, 2 uncited/inline-cited claims,
1 circular cross-reference. All numbers and all Schneider citations check out.

## Verdicts

### Citations

| id | quoted | verdict | source checked | proposed fix |
|----|--------|---------|----------------|--------------|
| C1 | "\citep[Part~1, \S5.1]" — cross-section definition (l.67) | ✅ PASS | Schneider 2006 PDF p.55–56, §5.1 "Cross-Sections" / "General Definition" | none |
| C2 | "\citep[Part~1, eq.~101]" — SIS σ(Δθ,r,μ) (l.130) | ✅ PASS (citation) — but see N6 | PDF p.57 eq. (101), reproduced exactly | none for the citation |
| C3 | "\citep[Part~1, \S5.2]" — optical depth (l.162) | ✅ PASS | PDF p.57–58 eqs. (103)–(107) | none |
| C4 | "\citep[Part~1, \S5.3]" — magnification bias (l.195) | ✅ PASS | PDF p.58–61 eqs. (108)–(111) | none |
| C5 | "(Turner, Ostriker \& Gott 1984)" — SIS τ ∝ n(σ_v/c)⁴ × volume factor (l.175) | ✅ exists / ⚠ support via secondary only | CrossRef DOI 10.1086/162379 (ApJ 284, 1). Not in `references.bib`. Support: Kochanek, Part 2 §6 p.182 credits TOG84 with "the basic statistics of normal galaxy lenses", p.190 "cross section … scales roughly as σ∗⁴". TOG84 full text not opened. | Add `turner_ostriker_gott_1984` to the `.bib` (DOI above) and convert to `\citep{}` — it is the only plain-text author–year citation in the chapter. |
| C6 | "$\sim 10^5$ lenses expected from \textit{Euclid} and LSST" (l.178) | ⚠ SUSPECT (uncited) — claim itself correct | arXiv:1507.02657 abstract (Collett 2015, ApJ 811, 20; DOI 10.1088/0004-637x/811/1/20): LSST 120 000, Euclid 170 000 | Add `\citep{collett_2015}` (new `.bib` entry). |
| C7 | Epigraph attributed to Schneider, Kochanek & Wambsganss (2006), Part 1 (l.12–19) | ❌ FAIL (misquotation) | PDF p.54–55, §5 opening. The italic text is a **paraphrase set as a verbatim quote**: "their density profiles --- and a comparison with a well-defined sample of observed lenses can constrain the lens population and the geometry of the Universe" is not in the source. | Either quote verbatim: *"One is frequently interested in the probability that a specific gravitational lensing event occurs. […] The results of such an investigation depend on the assumed distribution of lens masses and their individual density profiles. A comparison of these results with a statistically well defined sample of observed lens cases can in principle allow one to constrain the lens contents and/or the geometry of the Universe."* — or drop the quote formatting. Note the source's hedge "in principle" is lost in the paraphrase. |
| C8 | "Lens counts an early probe of $\OmegaL$" (l.176–177) | ✅ PASS | Kochanek Part 2 §6 p.182: lens statistics' cosmological era incl. "explorations of the effects of general cosmologies (Fukugita et al. 1990…)", and "has largely ceased to be interesting" for cosmology — consistent with "once made" | none |

### Numbers / equations

| id | quoted | verdict | source checked | proposed fix |
|----|--------|---------|----------------|--------------|
| N1 | $y^2(\mu_p)=2(\mu_p/\sqrt{\mu_p^2-1}-1)$ (eq:point_ymu) | ✅ PASS | PDF eq. (97); `lensing_statistics.wl` ✓; `problems_11.wl` 11.1(a) ✓ | none |
| N2 | $\sigma(\mu_p)=\pi\thetaE^2 y^2$; $y^2\to\mu_p^{-2}$ ⇒ σ∝μ⁻², p∝μ⁻³ | ✅ PASS | PDF eq. (98); `.wl` limit check ✓; problems 11.1(b) ✓ | none |
| N3 | $\sigma(r)=\pi\thetaE^2(r^{1/2}+r^{-1/2}-2)$ (eq:point_cross_r) | ✅ PASS | PDF eq. (99); `.wl` checks y=r^{1/4}−r^{−1/4} and σ(r) ✓ | none |
| N4 | SIS: two images for β<θ_E, separation 2θ_E; μ=2/y; r=(1+y)/(1−y); σ=πθ_E² | ✅ PASS | PDF p.56–57, eq. (100); `.wl` ✓; problems 11.2 ✓ | none |
| N5 | σ ∝ θ_E² ∝ σ_v⁴ (l.139–141) | ✅ PASS | Module 7 `eq:sis_einstein_radius`, Module 9 l.209 (θ_E=4πσ_v²/c² …); Kochanek p.190 | none |
| **N6** | eq:sis_cross_full: $\sigma=\pi\thetaE^2[\min(\tfrac{r-1}{r+1},\tfrac2\mu)]^2 H(2\thetaE-\Delta\theta)\,\mathbf{H(\mu-2)}$ | ❌ FAIL (physics) — **flag-only** (faithful copy of the cited source eq. 101) | Python Monte Carlo (4×10⁵ sources uniform in the source plane): μ>1.5, r<3 → MC σ/πθ_E² = **0.249**; eq. 101 gives **0** because H(1.5−2)=0; dropping H(μ−2) gives 0.250. For μ>2 thresholds all three agree (0.249/0.250; 0.0397/0.040). Every SIS double has μ_tot=2/y ≥ 2, so a threshold μ<2 is automatically satisfied — it should not zero the cross-section. | Drop the $H(\mu-2)$ factor (for finite r, (r−1)/(r+1)<1 already caps y below 1), and add a one-line footnote: "Schneider et al. (2006) eq. 101 carries an additional $H(\mu-2)$, which would incorrectly give σ=0 for thresholds μ<2." Add the MC/symbolic check to `lensing_statistics.wl` (currently not covered). |
| N7 | Optical depth, proper form (eq:optical_depth) and comoving form (eq:optical_depth_comoving) | ✅ PASS | PDF eqs. (106), (107). Algebra re-derived: D_ang=f_K/(1+z), dr_prop=dw/(1+z), n=(1+z)³n_com ⇒ integrand f_K² n_com dw ✓ | none (not covered by the `.wl`; optional) |
| N8 | "volume factor — larger in a universe with a cosmological constant" | ✅ PASS | Python: flat SIS optical-depth integral ∫f_K²(D_ds/D_s)² dw at z_s=2, fixed n_com: (Ω_m,Ω_Λ)=(0.3,0.7) / (1,0) = **2.9×** | none |
| N9 | Mag-bias eq:mag_bias, normalizations, power-law eq:mag_bias_powerlaw | ✅ PASS | PDF eqs. (109)–(111); `.wl` constant-μ check ✓; problems 11.3 ✓ | none |
| N10 | β=1 counts unchanged; β>1 boosted, β<1 depleted; divergence as β→2 for p∝μ⁻³ | ✅ PASS | PDF p.60–61 (explicit); ⟨μ^β⟩ with μ⁻³ tail diverges at β=2 (elementary) | none |
| N11 | F10214+4724 μ∼50; cB58 μ∼30; APM 08279+5255 highly magnified | ✅ PASS | PDF p.59 (Broadhurst & Lehár 1995; Seitz et al. 1998; Ibata et al. 1999) | none |
| N12 | Solutions: μ_± = 1 ± 1/y, trailing image a saddle (negative parity) | ✅ PASS | `problems_11.wl` ✓; Module 7 SIS magnification | none |
| N13 | Solutions: "equal flux per logarithmic interval" for β=1 | ✅ PASS | N(>S)∝S⁻¹ ⇒ S·dN/dlnS = const (elementary) | none |

### Consistency

| id | item | verdict | source checked | proposed fix |
|----|------|---------|----------------|--------------|
| X1 | Point-mass μ_p(y) formula, 3 occurrences (l.75, l.252, sol l.19) | ✅ PASS | internal: 3 occurrences agree; matches Module 4 | none |
| X2 | y²(μ) formula, 4 occurrences (eq, summary, ex 11.1, sol) | ✅ PASS | internal: 4 agree | none |
| X3 | "the universal fold-caustic behaviour of \S\ref{sec:magnification_bias}" (l.209–210) — written **inside** `sec:magnification_bias` | ❌ FAIL (circular cross-ref) | internal: the self-reference points at the section it sits in; p∝μ⁻³ is actually introduced at l.88–91 (§cross_point) and derived for folds in Module 8 `eq:fold_magnification` | Replace with "(\S\ref{sec:cross_point}; the fold magnification law, Eq.~\eqref{eq:fold_magnification})". The source attributes the result to Blandford & Narayan (1986) — optional citation. |
| X4 | θ_E ∝ σ_v² cross-referenced to Module~\ref{ch:galaxy_lensing} (l.139) | ✅ PASS (minor) | Module 9 l.209 has it; primary derivation is Module 7 `eq:sis_einstein_radius` | Optionally point to `eq:sis_einstein_radius`. |
| X5 | Solutions link `\solnlink{11_Lensing_Statistics/problems\_11.wl}` (sol l.12) uses `\_` in the URL arg | ℹ not a Module-11 issue | repo-grep: same pattern in 01a–04 solutions | Out of scope; repo-wide check of the rendered href if desired. |

## Applied (auto-fixes)

None. No number typo with a single canonical source was found; every numeric/symbolic
claim passed. N6 contradicts its own cited source, so it is flag-only by policy.

## Flagged — your hand required

1. **N6 — eq. 101 H(μ−2) (substantive).** Confirmed wrong by Monte Carlo for μ<2
   thresholds; the chapter copies the book faithfully. Recommend dropping the factor with a
   footnote noting the discrepancy with the source, plus a new check in `lensing_statistics.wl`.
2. **C7 — epigraph** is a paraphrase in quote formatting. Use the verbatim text (above) or
   de-italicize and mark "adapted from".
3. **C5 — Turner, Ostriker & Gott (1984)**: real (DOI 10.1086/162379), but plain-text and
   absent from the `.bib`. Add entry + `\citep`.
4. **C6 — "∼10⁵ lenses from Euclid and LSST"**: correct per Collett (2015) but uncited. Add
   `collett_2015` (DOI 10.1088/0004-637x/811/1/20).
5. **X3 — circular section reference** at l.209–210.

## Prose (LLM tells) — flag-only

- **Em-dashes:** chapter 13 in ~1 380 words (≈1/106, above the ~1/150 signal); solutions 6 in
  ~450. Most are legitimate list/parenthetical dashes (companion-file bullet, the source list
  at l.215–216). Worth trimming:
  - l.175–177: "It is that volume factor --- larger in a universe with a cosmological constant
    --- that once made lens counts an early probe of $\OmegaL$" — cleft + em-dash pivot.
    Plain: "Because this volume factor is larger when $\OmegaL>0$, lens counts were an early
    probe of the cosmological constant."
  - l.141: "--- the origin of the strong sensitivity of lens statistics to the most massive
    galaxies" — aphoristic closer. Plain: "so lens statistics are dominated by the most
    massive galaxies."
  - l.16 (epigraph): the em-dash is an inserted pivot inside a "quotation" (see C7).
- **Intensifiers:** "Remarkably" (l.204) — mirrors the source's own "first remarkable
  result", acceptable; "particularly clean" (l.164, echoes source "particularly convenient");
  "Two limits are illuminating" (l.195–196) — mild; "Two cases follow" is plainer.
- **Triads:** the l.62–63 property list and l.160–161 parameter list are genuine
  enumerations, not ornament. The three-bullet roadmap (l.29–38) is structural.
- Overall: reads clean apart from the two sentences above.

---

## Resolution — fixes applied 2026-09-22 (author-approved)

All flagged items were applied after the author approved them. Each fix is backed by
Mathematica, the `.bib`, and Zotero:

| id | Fix | Backing |
|----|-----|---------|
| N6 | Dropped `H(μ−2)` from eq:sis_cross_full; added footnote recording that the printed Schneider eq. 101 has it and why it is wrong | `lensing_statistics.wl` **Test 6** (new): direct source-plane integral of the SIS cross-section on a 35-point (μ, r) grid including μ<2 matches `[min((r−1)/(r+1), 2/μ)]²` exactly; σ(μ=3/2, r=3) = 1/4 ≠ 0 |
| C7 | Epigraph replaced with the verbatim source text (with `[…]` elision), attributed to P. Schneider, Part 1 §5 | Schneider 2006 PDF p.54–55 |
| C5 | `(Turner, Ostriker & Gott 1984)` → `\citep{turner_ostriker_gott_1984}` | new `.bib` entry; CrossRef 10.1086/162379; **Zotero 96CEGXDF** (added, tagged `learning_to_lens`) |
| C6 | "∼10⁵ lenses" now cited `\citep{collett_2015}`, reworded to "galaxy-scale lenses discoverable in Euclid and LSST imaging" | new `.bib` entry; CrossRef 10.1088/0004-637X/811/1/20; arXiv 1507.02657 abstract; **Zotero J42J5TWE** (existing, tagged `learning_to_lens`) |
| C8/N8 | Λ-volume-factor sentence rewritten plainly, now with the ~3× figure and `\citep[Part~2, §6]{schneider…}` | `lensing_statistics.wl` **Test 8** (new): ratio 2.93 (Mathematica NIntegrate), matching the Python recompute |
| N7 | (no text change) proper→comoving optical-depth identity now machine-checked | `lensing_statistics.wl` **Test 7** (new) |
| X3 | Circular `\S\ref{sec:magnification_bias}` → `\citep{blandford_narayan_1986}` + `Eq.~\eqref{eq:fold_magnification}` + `\S\ref{sec:cross_point}` | new `.bib` entry; CrossRef 10.1086/164709; **Zotero ZPACZCSH** (added); source attribution per Schneider 2006 Part 1 p.60 |
| X4 | θ_E ∝ σ_v² cross-ref now points to Module 7 `eq:sis_einstein_radius` | internal |
| Prose | l.141 closer and l.175 cleft rewritten plainly; "Two limits are illuminating" → "Two cases follow" | — |

`.bib` page fields hold only the CrossRef-confirmed start page. End pages were left out
because they were not verified.

**Engine / build verification after edits:**
- `lensing_statistics.wl` → **13/13 PASS** (was 9/9); `problems_11.wl` 8/8 unchanged.
- `bash build.sh` → student **248 pp**, instructor **304 pp** (unchanged); 0 LaTeX errors;
  new refs [3] Blandford & Narayan, [5] Collett, [19] Turner et al. render in References.
- `VERIFICATION.md` Module-11 row + "Last verified" date updated.
- Master `verify_against_textbooks.wl` not re-run: none of its 12 cross-checks touches Module 11.

**Out-of-scope finding (not fixed):** Module 6 (`06_Fermat_Time_Delays.tex` l.112, 219, 235,
255, 357) references `ch:magnification_convergence_shear`, but the Module 5 label is
`ch:magnification`. These render as "Module ??" in both PDFs. This predates the current pass.
