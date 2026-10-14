# fact-critic report — Notes/16_Odd_Images_Central/16_Odd_Images_Central.tex (+ 16_Solutions.tex, odd_images.wl, problems_16.wl)

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Provenance, Derivation
> Active adapters this run: bibtex ✓ (Notes/references.bib), crossref-web ✓ (api.crossref.org reachable; Semantic Scholar abstract for MWK01),
> md-reflist ✗ (n/a), values-file ✗ (none), repo-grep ✓, doc-internal ✓, Reference_Texts PDFs ✓ (pdftotext: SEF 1992, PLW 2001, C&K 2018),
> wolframscript ✓ (repo scripts + independent scratch script), overlay: AGEL local (Zotero not needed; all sources resolved via PDFs/CrossRef).
> Critic is independent of the author. No PASS below is from memory: each names a PDF page, a DOI, a `.wl` PASS line, or a `path:line`.

Repo scripts (run 2026-10-14 via `bash Mathematica/run_wl.sh`):

- `Mathematica/16_Odd_Images_Central/odd_images.wl` → `SUMMARY: 84 PASS, 0 FAIL  (of 84 checks)` / `ALL CHECKS PASS` (exit 0; figures regenerated during the run were restored with `git checkout`, so no binary churn)
- `Solutions/16_Odd_Images_Central/problems_16.wl` → `SUMMARY: 51 PASS, 0 FAIL  (of 51 checks)` / `ALL CHECKS PASS` (exit 0)

Independent scratch script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_16/critic16.wl`
→ `SUMMARY: 33 PASS, 0 FAIL  (of 33 checks)`

**Verdict counts: 32 ✅ PASS · 13 ⚠ SUSPECT (7 content, 6 prose) · 0 ❌ FAIL · 0 auto-fixes applied.**

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "the index argument of \citet[Sect. 5.4.1]{schneider_ehlers_falco_1992}" | ✅ PASS | SEF pp.172–174 (index theorem, eq. 5.48, Fig. 5.4–5.5); bib DOI 10.1007/978-3-662-03758-4 CrossRef-confirmed | none |
| C2 | Citation | "\citealt{petters_singularity_2001}, Sect. 7.4 and Chs. 10–11" | ✅ PASS | PLW TOC: §7.4 "Morse Theory", Ch.10 "Morse Inequalities", Ch.11 "Counting Lensed Images: Single-Plane Case" | none |
| C3 | Citation | "Burke's odd-number theorem \citep{burke_1981}, in the form of Theorem 1 of SEF" | ✅ PASS | CrossRef DOI 10.1086/183466 (Burke, ApJ 244 L1, 1981); SEF p.172 Thm 1 cites [BU81.1] | none |
| C4 | Citation | "global minimum … always exists and is an image … a source far enough … single image" | ✅ PASS | SEF p.172 Thm 1 (a) n_I ≥ 1, (d) n = n_I = 1 for large \|y\| | none |
| C5 | Citation | "each point mass turns what would have been a local maximum of τ into a logarithmic spike…" | ✅ PASS | SEF p.175 "Each point mass just turns such a local maximum into a logarithmic spike. Hence, the number of positive-parity images plus the number of point masses is greater by one than the number of negative-parity images." | none |
| C6 | Citation | "N = 2n_+ + g − 1, is Theorem 11.4 … g saddle images, each approaching one of the point masses" | ✅ PASS | PLW pp.424–425 Thm 11.4(2) `N = 2M+ + g − 1 = 2Msad − g + 1`, (3)(ii) saddles approach distinct singularities (needs local stability, bounded Crit) | none |
| C7 | Citation | "C&K Sect. 6.2.2 summarise … magnifications around 10⁻³, with values as large as 0.1" | ✅ PASS (note) | C&K p.157: "magnifications as large as 0.1 are possible, typical values are closer to 0.001"; C&K attribute the estimate to **Keeton (2003)** | optional: name Keeton (2003) as the primary source (not in references.bib — add only after verifying) |
| C8 | Citation | "central image … detected in only one galaxy-scale lens, the radio quasar lens PMN J1632−0033" | ✅ PASS | C&K p.158 ("observed only in the lensed quasar PMN J1632−0033", Winn+2004 radio; SDSS J1004+4112 fifth image is a cluster) | none |
| C9 | Citation | "picture of \citet{mao_witt_koopmans_2001} as summarised in Sect. 6.2.2 … above a threshold … second central image may form" | ✅ PASS | CrossRef DOI 10.1046/j.1365-8711.2001.04143.x; MWK abstract (Semantic Scholar): critical BH mass suppresses central images for all sources; "zone of influence"; "an additional image may be created by the black hole". C&K p.157 credits the second image to Rusin+2005 for general models — the chapter's attribution to MWK is nonetheless supported by MWK's own abstract | none |
| C10 | Citation | "C&K make the same point: … degenerate between black-hole mass and inner density profile" | ✅ PASS | C&K p.157 "a given magnification is degenerate to some extent with respect to black hole mass and inner density profile" | none |
| C11 | Citation | "a measured upper limit on the central image's flux is a lower limit on how cuspy the centre is" | ✅ PASS | C&K p.157 ("upper limit on its brightness … lower limit on the central slope") | none |
| N1 | Number | "θ_r = 0.297 θ_E, y_r = 0.235 θ_E (θ_c=0.2); 0.251, 0.427 (θ_c=0.1)" | ✅ PASS | critic16.wl `N theta_r=0.297…` (0.297235, 0.235198; 0.250967, 0.427036); odd_images.wl C.1, C.9b | none |
| N2 | Number | "grid of 149 source positions 0.01 ≤ y ≤ 1.5" | ✅ PASS | odd_images.wl:139–140 (150 points, one within 1e-3 of y_r excluded) | none |
| N3 | Number | "μ_c = 1/2401 … 8.5 mag; θ_c = 0.1 → 1/16, 3.0 mag" | ✅ PASS | critic16.wl `N mu_c(tc=0.01)=1/2401 -> 8.45 mag…` | none |
| N4 | Number | Fig. caption "within 6% of the closed form for θ_c ≤ 0.05 θ_E" | ✅ PASS | critic16.wl `N FIG2 caption` (ratios 1.041–1.057 for θ_c = 0.002–0.05; 1.061 at 0.06, so the cut is tight but correct); odd_images.wl FIG2 | none |
| N5 | Number | "μ_c = 0.037 (γ'=1.5), 3.1×10⁻³ (1.6), 7.5×10⁻⁵ (1.7), below 10⁻⁷ (1.8)" | ✅ PASS | critic16.wl (0.0369611, 0.00312198, 7.49265e−5, 5.00701e−8) | none |
| N6 | Number | "γ'=1.2: a source at 0.1 θ_E is already outside the radial caustic" | ✅ PASS | critic16.wl: y_caus = (γ'−1)(2−γ')^{(2−γ')/(γ'−1)} = 0.082 < 0.1 | none |
| N7 | Number | "μ_c ≃ 2y² = 0.02 vs exact 0.037 … agree to better than 1% at y=10⁻⁴" | ✅ PASS | critic16.wl `N annotation…`; problems_16.wl AN1–AN2 | none |
| N8 | Number | "θ²_•,crit = 0.0223 θ_E² (0.149); 0.0190 (0.138); Ex: 0.01769 (0.133) at θ_c=0.05" | ✅ PASS | critic16.wl `N u_crit …` (0.022279468, 0.018958110) | none |
| N9 | Number | "θ_• = 0.082 θ_E already removes it for every source within 0.3 θ_E" | ✅ PASS | critic16.wl: θ_• = 0.08175, y_in = 0.318 | none |
| N10 | Number | Solutions: Ex16.2 μ = 2.19, 2.35, −1.51, −1.21, max μ=0.136 at \|θ\|=0.029; Ex16.6 m_BH=0.0246, α(θ_E)=0.905; Ex16.7 18.3 mag, 5.007e−8 | ✅ PASS | critic16.wl (independent NSolve: −1.5061, −1.20558, 0.136125, 2.18618, 2.34678; \|θ_max\| = 0.0289); problems_16.wl 2h, 6c, 7c | none |
| N11 | Number | Solutions 16.4(c): "y=0.1: 3 vs 2; y=0.2: 3 vs 4" | ✅ PASS | critic16.wl `X Solutions 4(c) counts` | none |
| N12 | Number | "depends on the innermost tenth or so of the deflector's Einstein radius" (l.28; also "~0.1 θ_E" l.884) | ⚠ SUSPECT | no source; loosely consistent with the chapter's own θ_r ≈ 0.25–0.30 θ_E and central-image radii ≲ 0.1 θ_E | soften to "the innermost few tenths of θ_E (inside the radial critical curve)" or cite |
| X1 | Consistency | μ_c = (1−κ₀)⁻² = 4θ_c²/(θ_E−2θ_c)² (eq., keybox, Summary, Sol. 16.3) | ✅ PASS | internal: 4 occurrences agree | none |
| X2 | Consistency | θ²_•,crit closed form (eq. oi_ucrit, Summary, Ex16.6, odd_images.wl H.4) | ✅ PASS | internal: 4 occurrences agree | none |
| X3 | Consistency | y_in ≃ 2θ_•√(κ₀−1) (eq., derivation, Summary) | ✅ PASS | internal: 3 occurrences agree | none |
| X4 | Consistency | every `Chapter~\ref` target | ✅ PASS | label map → PDF TOC (`pdftotext -l 14 Output/Learning_to_Lens_Annotated.pdf`): fermat_time_delays→Ch.10 "Fermat's Principle and Time Delays" (has thm:odd_number, tab:morse_types, sec:fermat_principle); axisymmetric_models→Ch.11 (sec:nis); elliptical_models→Ch.12 (sec:image_topology, ex:burke_verification); lens_equation→Ch.8 (eq:image_positions); power_law_point_mass→Ch.19; central_mass_bias→Ch.21 (sec:cb_annihilation present); msd_kinematics→Ch.22. All descriptions match. (Annotated PDF still shows Part V as "[Chapter in preparation.]" stubs — rendered numbers could not be read from the chapter body itself.) | none |
| X5 | Consistency | Annotation l.345–347: "Students often say 'the point mass is not transparent'. It is: light does not hit it." | ⚠ SUSPECT | Ch.6 thm:odd_number (06_Fermat_Time_Delays.tex:439–441) *defines* transparent as "a smooth, bounded Σ". By the book's own definition a point mass is NOT transparent; SEF p.172 also says the hypotheses "exclude stars and black holes" | e.g. "Students often say 'light hits the point mass'. It does not; what fails is (S1)/(S2)…", or say explicitly that 'transparent' in Ch.6 means smooth bounded Σ |
| X6 | Consistency | l.369–376 "(S1) holds, the index argument goes through"; Summary l.902–906 "If the deflection is continuous and bounded … a power-law cusp with 1<γ'<2 … still obeys the theorem" | ⚠ SUSPECT | eq. oi_powerlaw: α ∝ θ^{2−γ'} is **unbounded** as θ→∞ for 1<γ'<2, so (S2) fails for the untruncated power law. The conclusion is still right because \|α\|/θ → 0 (winding at infinity +1); SEF p.174 "Additional remarks": theorem holds for gradient maps asymptotic to the identity | add "and \|α\|/θ → 0 at infinity (SEF p.174)" or note the power law is assumed truncated at large radius |
| X7 | Consistency | l.360–361 SIS: "The surface τ has a conical tip, a local maximum with no tangent plane" (unconditional) | ⚠ SUSPECT | τ−τ(0) ≈ −β·θ − θ_E\|θ\|: along −β̂ this is (\|β\|−θ_E)\|θ\| > 0 for \|β\|>θ_E, so the tip is a local maximum only for \|β\|<θ_E — exactly the index-1 case the same paragraph derives | "a conical tip with no tangent plane (a local maximum when \|β\|<θ_E)" |
| X8 | Consistency | Annotation l.529–531 "(iii) In between, μ_c is small because \|λ\| = κ₀−1 is large" | ⚠ SUSPECT | eq. oi_muc: μ_c < 1 only for κ₀ > 2 (θ_c < θ_E/4); e.g. θ_c = 0.3 θ_E gives μ_c = 2.25 | "(iii) For κ₀ ≫ 1 (θ_c ≪ θ_E/4) μ_c is small because…" |
| X9 | Consistency | Bridge l.278–280 "The quad-plus-one configuration of Exercise~\ref{ex:burke_verification} has n_+=3, n_-=2" | ⚠ SUSPECT (minor) | that exercise (08_Elliptical_Models_Caustics.tex:1853) is for the singular SIE, which by this chapter's own SIS/tip analysis has no central image (4 images + tip); its solution (08_Solutions.tex:386–396) gets 3−2 only for "a non-singular version" | "…of Exercise X, in its non-singular (cored) version, has…" |
| X10 | Consistency | Fig. captions (arrival_time: 4 images at 0.3 u_crit, 2 at 1.2 u_crit; phase diagram) vs .wl | ✅ PASS | odd_images.wl H.11, H.13, FIG3; critic16.wl S3a | none |
| X11 | Consistency | odd_images.wl stdout log | ⚠ SUSPECT (infrastructure, not chapter text) | two runs: SUMMARY reports 84/84 PASS but only 81 and 80 `PASS:` lines were printed — H.6b, H.7, H.8 (and H.6 in run 2) are missing from stdout. Tally = number of `check[]` calls (84) with 0 FAIL, so they did pass, and critic16.wl re-verifies H.7/H.8 numbers independently. Looks like dropped `Print` output from wolframscript (lines vary between runs); same pattern may affect other scripts | harness: switch `Print` to `WriteString["stdout", …]` (critic16.wl did, with no loss) |
| D1 | Derivation | NIS lens equation → cubic (eq. oi_nis_cubic) | ✅ PASS | critic16.wl `D1 … = t * cubic`, `D1b` | none |
| D2 | Derivation | μ_c = (1−κ₀)⁻² = 4θ_c²/(θ_E−2θ_c)² = 4θ_c²/θ_E²[1+4θ_c/θ_E+…] | ✅ PASS | critic16.wl `D2`, `D2b`, `D2c` | none |
| D3 | Derivation | cusp μ_c ≈ (2−γ')⁻¹ y^{2(γ'−1)/(2−γ')} | ✅ PASS | critic16.wl `D3`, `D3b`, `D3c` (exact/leading → 1 at y=10⁻⁶ for γ'=1.3, 1.5, 1.7) | none |
| D4 | Derivation | θ²λ_r = h(s)+θ_•²; θ²_•,crit = θ_c(θ_E+θ_c) − 3(θ_Eθ_c²/2)^{2/3} | ✅ PASS | critic16.wl `D4` (FullSimplify), `D4b`: closed form equals the simultaneous y′=y″=0 FindRoot solution to <1e−15 for θ_c = 0.1, 0.2, 0.3; `D4c` cubic in s | none |
| D5 | Derivation | y_in ≈ 2θ_•√(κ₀−1) | ✅ PASS | critic16.wl `D5` (ratio 0.99961, 0.999996, 1.00000 at θ_•² = 1e−4, 1e−6, 1e−8) | none |
| P1–P6 | Prose | see Prose section | ⚠ SUSPECT | read | flag-only |

## Applied (auto-fixes)

None. No single-source number typo and no number-vs-number mismatch was found in the chapter, its Solutions, or its scripts.

## Flagged — your hand required

1. **X5 (point mass "is transparent").** 16_Odd_Images_Central.tex:345–347 contradicts the book's own definition in Ch.6 thm:odd_number (06_Fermat_Time_Delays.tex:439–441: transparent = smooth, bounded Σ) and SEF p.172 ("these assumptions again exclude stars and black holes"). The physics in the rest of the annotation is right. Proposed: "Students often say 'light hits the point mass'. It does not. What fails is (S1)/(S2) at one point…", or define which sense of "transparent" is meant.
2. **X6 (power-law cusp and boundedness).** l.369–376 and Summary l.902–906 present the γ'<2 power law as satisfying the theorem's "continuous and bounded" hypotheses. The untruncated power law has α ∝ θ^{2−γ'} → ∞. The conclusion still holds because \|α\|/θ → 0, which is SEF's p.174 generalisation (gradient maps asymptotic to the identity). Proposed: add "with \|α\|/θ → 0 at large θ" to the keybox or to the cusp paragraph.
3. **X7 (SIS tip as a "local maximum").** l.360–361. The tip is a local maximum only for \|β\| < θ_E. Proposed: "…has a conical tip with no tangent plane (a local maximum when \|β\|<θ_E)…".
4. **X8 ("in between, μ_c is small").** l.529–531. μ_c < 1 needs θ_c < θ_E/4. Proposed: qualify with κ₀ > 2.
5. **X9 (quad-plus-one of the SIE exercise).** l.278–280. Proposed: "…in its non-singular version…".
6. **N12 ("innermost tenth or so of θ_E").** l.28 and l.884. Unsourced and loose; the radial critical curve sits at 0.25–0.30 θ_E for the chapter's own examples. Soften, or cite.
7. **C7 (optional attribution).** The 10⁻³ / 0.1 magnification figures are, per C&K p.157, from Keeton (2003). The chapter's "C&K summarise" wording is honest. If you want the primary source, add Keeton 2003 after verifying it via CrossRef/Zotero. It is not in references.bib now, and I have not added it.
8. **X11 (harness stdout drop).** This is not a chapter error. odd_images.wl prints fewer `PASS:` lines than its SUMMARY counts, and which lines go missing changes from run to run. Worth fixing in `Mathematica/harness.wl`, because reports quote PASS lines verbatim. This is outside the chapter's files, so I did not touch it.

## Prose (LLM tells) — flag-only

Em-dashes: about 15 in about 6,000 words of prose, below the 1-per-150-words signal. Triads are mostly real lists (core / cusp / BH). The text reads mostly clean. Worst offenders:

- **P1** l.27 "The question is not academic." Stock opener. Proposed: delete the sentence and start with "Whether a central image exists…".
- **P2** l.352–354 "Burke's conclusion is not violated, it is \emph{relocated}: the odd image has become the singularity itself." Antithesis plus aphorism. Proposed: "Counting the puncture as an index-+1 point restores the odd total."
- **P3** l.532 "Curvature of τ is inverse brightness." Aphoristic closer that repeats the previous sentence. Proposed: delete.
- **P4** l.376 "What the counting rule really needs is continuity of the deflection, not finiteness of the density." This antithesis carries content, but it is incomplete (see X6). Proposed: "The counting rule needs a continuous deflection with \|α\|/θ → 0 at infinity. A finite central density is not required."
- **P5** l.536 "Three effects conspire." Proposed: "Three effects hide it."
- **P6** l.523 "Three limits make the formula memorable." Proposed: "Three limits are worth checking."

## Provenance (machine-drafted text) — flag-only

Baseline: none author-written. The chapter was created in commit 4e5521c ("Chapter 16 (PDF ch. 20)…", Co-Authored-By Claude Opus 5.5). It is adapted from `AGEL/202607_Theoretical_spiral_compound/theory/note4_odd_images.tex`, which is itself model-drafted. Every section therefore counts as 100% machine-introduced (⚠, flag-only). The author should rewrite in their own words before any external release. No sentence-level table is given because nothing in the chapter is author-original yet.

## Derivation checks

Script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_16/critic16.wl` (written by the critic from scratch, without loading the chapter's helpers; run via `bash Mathematica/run_wl.sh`)
`SUMMARY: 33 PASS, 0 FAIL  (of 33 checks)`

| # | equation | result |
|---|----------|--------|
| D1 | NIS lens eq. → cubic θ³ − 2yθ² + (y² + 2θ_Eθ_c − θ_E²)θ − 2yθ_Eθ_c = 0 | PASS: (θ² − yθ + θ_c)² − s² ≡ θ·cubic; counts 3 / 1 at y = 0.1 / 0.5 |
| D2 | μ_c = (1−κ₀)⁻² = 4θ_c²/(θ_E−2θ_c)² = 4θ_c²/θ_E²[1 + 4θ_c/θ_E + O(θ_c²)] | PASS: λ_t(0) = λ_r(0) = 1−κ₀ by Limit; series 4θ_c² + 16θ_c³ |
| D3 | μ_c ≈ (2−γ')⁻¹ y^{2(γ'−1)/(2−γ')} | PASS: λ_tλ_r/((2−γ')x^{2(1−γ')}) → 1; exact/leading → 1 at y = 10⁻⁶ |
| D4 | θ²λ_r = h(s) + θ_•²; θ²_•,crit = θ_c(θ_E+θ_c) − 3(θ_Eθ_c²/2)^{2/3} | PASS: symbolic identity; closed form = numerical y′ = y″ = 0 root (0.022279468, 0.018958110, 0.010455301) |
| D5 | y_in ≈ 2θ_•√(κ₀−1) | PASS: ratio → 1.00000 as θ_• → 0 (θ_c = 0.1) |

Source-note adjudication (same script):

- **S1** One central point mass gives N ∈ {2, 4}, while the NIS alone gives {1, 3}. Adding the BH changes N by an odd number for every one of 1,575 grid sources (θ_c ∈ {0.1, 0.2, 0.3}, θ_•²/θ²_•,crit ∈ {0.01 … 2}, y ∈ [0.01, 1.49]). n₊ − n₋ + g = 1 holds everywhere. PASS.
- **S2** τ = ½(θ−y)² − θ_•² ln\|θ\| → +∞ as θ → 0. PASS (Limit). This agrees with SEF p.175 ("logarithmic spike" replacing a maximum) and PLW p.425 proof of Thm 11.4 (T_y → ∞ at an infinite singularity).
- **S3a** Below θ_•,crit there are two radial critical radii (0.066, 0.279 at 0.3 u_c; 0.172, 0.195 at 0.99 u_c). There are none at 1.01 u_c. PASS.
- **S3b** At fixed source, scanning u to u_crit (22 sources, θ_c = 0.1 and 0.2): every 4→2 drop leaves the outer saddle (θ < −r₂) alive, so the maximum annihilates with the BH saddle at −r₁. Every 2→4 rise creates a maximum and outer saddle at −r₂. PASS.
- **S3c** The outer radial caustic y_out grows monotonically with u (θ_c = 0.2: 0.235 → 0.255 → 0.276 → 0.300 at u/u_c = 0, 0.3, 0.6, 0.9). So no source loses its maximum to the original radial saddle. This supports the keybox claim "for any fixed source … merging with the black-hole saddle". PASS.

### Source-note errors (for feedback to the spiral project)

Note: `theory/note4_odd_images.tex`, `theory/solutions/sol_note4_odd_images.tex`.

- (1) "the odd image count drops from three toward one" (note4 l.108). **CONFIRMED error.** With one central point mass the count is even (2 or 4): n₊ − n₋ + g = 1 (SEF p.175; PLW Thm 11.4, N = 2M₊ + g − 1; critic16.wl S1/S1c).
- (2) "τ → −∞ as θ → 0" (sol l.170, l.176). **CONFIRMED error.** It is +∞ (SEF p.175 spike replacing a maximum; PLW p.425; critic16.wl S2).
- (3) "the central maximum and the radial saddle … merge and annihilate" at the annihilation boundary (note4 keybox l.110–113; sol l.205–209). **CONFIRMED error.** At θ_•,crit the two radial critical circles merge (S3a). At fixed source the maximum merges with the BH-created saddle, never with the original radial saddle (S3b, S3c).
- (4) "adding a point mass changes the image count by an even number" (note4 Ex.4 l.132; sol l.163, l.187). **CONFIRMED error.** The change is odd (S1b; parity of N + g is invariant). The source solution's own Euler-characteristic algebra (N = 2n_sad, even) already contradicts its "even change" conclusion.

## Reconciliation with the spiral project's record (2026-10-14)

Independent reconciler, per `docs/agent_briefs_2026-10-14/RECONCILE.md`. Spiral sources read:
digest `docs/spiral_reconciliation_2026-10-14/note3_4_6.md` (note4 rows; full verdict text recovered from the
packet critic's workflow journal `~/.claude/projects/-Users-rosador-Documents-AGEL-202607-Theoretical-spiral-compound/da19cc6d-…/subagents/workflows/wf_a10ff0a2-7f9/journal.jsonl`,
claims S7-039…S7-058 = `theory/note4_odd_images.tex`), `note8_solutions.md` (**contains no sol_note4 row**: the 10-14 packet
critic extracted claims from `SOLUTIONS.tex` and `sol_note10` only, so `sol_note4_odd_images.tex` was never checked by it),
`auto_fixable_and_coverage_gaps.md`, `theory/FACT_CRITIC_study_notes_2026-07-11.md`,
`theory/solutions/FACT_CRITIC_SOLUTIONS_2026-07-24.md`, `TESTS_AND_DIAGNOSTICS.md` rows A4/A5 (+§2 entries),
`HANDOFF_arc_2026-09-21.md` §5–6, `NOTES_mcrit_label_defect_2026-08-03.md`, `mathematica/exercises/sol_note4_odd_images.wl`.

Re-verification script (scratch, not in repo):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/reconcile_16/reconcile16.wl`,
run as `bash Mathematica/run_wl.sh <that path>` → `SUMMARY: 22 PASS, 0 FAIL  (of 22 checks)`.
It checks: V1 τ → +∞ at a point mass from both sides (symbolic `Limit`); V2 on 900 off-caustic sources
(θ_c ∈ {0.1, 0.2, 0.3}, u/u_crit ∈ {0.01 … 1.5}) N_noBH ∈ {1,3}, N_BH ∈ {2,4}, and N_BH − N_noBH is odd every time
(pairs seen: (1,2), (1,4), (3,2), (3,4)); V3a at u_crit, y′ = y″ = 0 share a far-side root (the TESTS A4 condition, i.e. the two
radial critical circles merge); V3b–c y_out(u) and y_in(u) both strictly increase on (0, u_crit) (θ_c = 0.2: y_out 0.236 → 0.308);
V3d for six fixed sources at θ_c = 0.2 the 4 → 2 drop happens at the inner root −r₁ (maximum + black-hole saddle), never at −r₂
(maximum + radial saddle); V4a det A = (1−κ)² − γ² (the closure S7-051 asks for); V4b the SIS gives one image for β > θ_E.

| spiral id | claim (spiral source) | status in chapter | action |
|---|---|---|---|
| S7-039 ⚠ | note4 abstract opens with a rhetorical question (l.10) | already fixed in the port: the chapter has no abstract; opener l.16–25 is declarative | none |
| S7-046 ⚠ | Burke's hypothesis given as "κ falls off faster than θ⁻¹"; Burke's own is bounded bending, and his "transparent" explicitly *excludes black holes* (l.60–62) | already fixed: keybox l.259–269 states (S1) continuous, (S2) bounded deflection. Burke's own wording ("transparent … excludes solid objects and black holes", per S7-046's full-text read) **reinforces critic item X5**: annotation l.345–347 ("It is [transparent]") contradicts Burke as well as SEF p.172 and Ch.6 | no new fix; X5 already flagged. When fixing X5, Burke's own exclusion of black holes is the cleanest source |
| S7-049 ⚠ | "the observed even counts are always missing one faint image" (l.77–78). The index theorem fixes only the parity of the hidden count | **partly inherited**, mild: l.22–25 "The missing odd image is the \emph{central image}". True for a single-centred galaxy, not in general | New fix 1 below |
| S7-050 ⚠ | SIS "one observes an even number of images" unconditionally (l.80–83) | already fixed: l.357–366 and Table `tab:oi_centres` (two images inside the cut, one outside); Ex.~`ex:oi_sis_tip` | none |
| S7-051 ❌ | μ_central ∼ 1/[(1−κ₀)² − …], an unfinished formula (l.90–92) | already fixed: eq. `oi_muc` l.487–493 is the closed form, with "the shear vanishes at the centre of an axisymmetric lens" (l.485). The general (1−κ)² − γ² follows from eq. `oi_eigen` (l.102–104; V4a) | none |
| S7-052 ⚠ | "only a handful [of central images] known" (l.94–96) | already fixed: l.541–547 says one galaxy-scale detection (PMN J1632−0033), per C&K p.158 (critic C8) | none |
| S7-058 ⚠ | Exercise 4 has no Wolfram attestation, yet it is covered by the blanket "every … answer is attested" claim (l.117) | already fixed: Ex.~`ex:oi_puncture` is attested by `problems_16.wl` checks 4a–4c (16_Solutions.tex:145) | none |
| S7-054 (no verdict: coverage gap) | the point-mass suppression "is the same statement as the annihilation of the radial critical curve" (l.105–107) | already fixed and made precise: keybox l.807–818 and annotation l.833–844 separate the fixed-source merger from the disappearance of the caustic pair (V3d) | none |
| S7-055 (no verdict: coverage gap) | "the odd image count drops from three toward one" (l.108) | already fixed: l.342, l.656, l.910 give an even count (4 or 2) with one point mass (V2b) | feedback item 1 |
| S7-056 (no verdict: coverage gap) | keybox: below the boundary min, saddle, max; above it min + saddle "plus a faint image pinned at the black hole" (l.111–113) | already fixed: keybox l.811–814 gives four images or two below the boundary and exactly two above it (V2b) | feedback item 2 |
| sol_note4 l.170, 176 (never extracted) | τ → −∞ at the point mass | already fixed: Table l.311 and l.320 give τ → +∞ (V1; critic S2) | feedback item 3 |
| note4 Ex.4 l.131–132; sol_note4 l.163, 186–190 (never extracted) | adding a point mass changes the image count by an even number | already fixed: Ex.~`ex:oi_puncture` is titled "change the parity" and part (b) says N+g stays odd (V2c; critic S1) | feedback item 4 |
| sol_note4 l.205–209 (never extracted) | annihilation boundary = the central maximum and the radial saddle merging in a fold | already fixed: annotation l.833–844 and keybox l.816–818 (V3a, V3d; critic S3b–c) | feedback item 2 |
| FACT_CRITIC 07-11 | Burke 1981 = ApJ 244 L1 (not 289); MWK01 DOI 10.1046/j.1365-8711.2001.04143.x; note4 otherwise passed | consistent: bib keys `burke_1981`, `mao_witt_koopmans_2001` (critic C3, C9 PASS). That pass flagged none of the four note4 errors | none |
| FACT_CRITIC_SOLUTIONS 07-24 C4 | sol_note4 "Burke's theorem" PASS; per-fragment tally "note4 10/10" | n.a. to the chapter. That pass did not catch sol_note4's τ sign or its "even change". Its tally disagrees with the 23 checks in `sol_note4_odd_images.wl` (same commit c3a9b1c; S7-058 re-ran 23/23) | feedback item 5 |
| TESTS A4 | annihilation boundary = double root {y′ = 0, y″ = 0} of the lens map (derivation.wl, agrees with m_crit_numeric to 1.7e−6) | consistent: bridge l.820–825 uses the same condition; V3a reproduces it for the NIS. A4's condition is a merger of two *critical circles*, which contradicts note4's keybox reading (max + radial saddle) | none for the chapter; supports feedback item 2 |
| TESTS A5 | MWK01 mechanism: a central point mass destroys the radial critical curve; numeric existence boundary | consistent: §`oi_pointmass` and the phase diagram; MWK01 attribution checked by critic C9 | none |
| HANDOFF 09-21 §5 | retractions of this arc | n.a.: none touches note4 or its results | none |
| HANDOFF 09-21 §6 | method lessons | n.a. | none |
| NOTES_mcrit_label_defect | after the macro radial curve is destroyed, a residual point-mass critical curve at r ≈ 0.010″ survives (elliptical EPL+BH, LensCalc) | no conflict: the chapter's "above θ_•,crit … the radial caustic no longer exists" is for the axisymmetric NIS+BH, where λ_r has no root above u_crit (critic S3a). The defect note concerns elliptical Tier-3 mocks and the m/m_crit label (Ch.17 territory) | none |

### New fixes for the fix pass (not already in the Flagged section)

1. **S7-049, l.22–25.** "The missing odd image is the \emph{central image}" overstates what the index theorem gives. The theorem fixes only the parity of the number of unseen images. A deflector with several mass concentrations can have n_max > 1. Proposed: "For a single galaxy the missing odd image is the \emph{central image}, …". This is optional and minor, since the rest of the chapter only uses axisymmetric or single-core lenses.

(No other spiral-record item adds a fix. S7-046 strengthens existing item X5 but does not create a new one.)

### Feedback to the spiral project (errors the spiral record does not yet know)

The 2026-07-11 study-notes critic passed note4 as a whole. The 2026-07-24 solutions critic passed sol_note4 (it checked only the Burke name, C4). The 2026-10-14 packet critic extracted the relevant note4 claims (S7-054, S7-055, S7-056) but returned no verdict on them, because they fell in the 160-claim coverage gap. It never extracted sol_note4 at all. TESTS, the HANDOFFs and the defect notes do not mention note4. **So none of the four source-note errors confirmed by this chapter's critic is known to the spiral record.** All four are confirmed again by `reconcile16.wl` (22/22).

1. **`theory/note4_odd_images.tex:108`.** "the odd image count drops from three toward one" is wrong. With one central point mass the count is even: N = 2n₋ + 1 − g with g = 1 (SEF p.175; PLW Thm 11.4). An NIS+BH gives 4 or 2 images, never 3 or 1. The chapter says this at l.342, l.656 and l.910. Proof: V2a–c, 900 sources. Spiral packet id S7-055 (unverified).
2. **`theory/note4_odd_images.tex:110–113` (keybox) and `theory/solutions/sol_note4_odd_images.tex:205–209`.** These make two errors.
   - (a) The annihilation boundary is not "the central maximum and the radial saddle merging". At u_crit the BH's inner radial critical circle and the lens's radial critical circle merge, which is a double root y′ = y″ = 0. That is the project's own TESTS A4 condition. At fixed source the maximum always merges with the **black-hole** saddle, at −r₁. It never merges with the radial saddle, because y_out(u) rises monotonically.
   - (b) "Above it … only the tangential min+saddle remain, plus a faint image pinned at the black hole" counts three images. The correct count is exactly two, a minimum and a saddle.
   
   The chapter's version is keybox l.807–818 plus annotation l.833–844. Proof: V3a–d and V2b. Spiral id S7-056 (unverified).
3. **`theory/solutions/sol_note4_odd_images.tex:170` and `:176`.** "τ → −∞ as θ → 0" should be **+∞**. With ψ = θ_•² ln θ, −ψ → +∞: SEF p.175 calls it a "logarithmic spike" that replaces a maximum, and PLW p.425 agrees. The sign matters because a +∞ spike is exactly why the puncture acts as a hidden maximum with index +1, the reading l.193–196 of the same solution relies on. The chapter has +∞ at l.311 and l.320. Proof: V1a–b (`Limit`).
4. **`theory/note4_odd_images.tex:131–132` (Exercise 4) and `sol_note4_odd_images.tex:163`, `:186–190`.** "Adding a point mass changes the image count by an even number" is wrong: the change is **odd**, since N + g is invariant mod 2. The solution contradicts itself. Its own algebra goes from N = 1 + 2n_sad to N = 2n_sad, and l.188–189 calls that "a shift of exactly one image" in the same sentence that concludes "even". The chapter's Ex. `ex:oi_puncture` asks for the parity change, attested by problems_16.wl 4b–4c (θ_c = 0.2, u = 0.3 u_crit: 3 → 2 at y = 0.1 and 3 → 4 at y = 0.2). Proof: V2c, where every source shows an odd change, including (1,4) pairs that change by +3.
5. **Record inconsistency (minor), `theory/solutions/FACT_CRITIC_SOLUTIONS_2026-07-24.md` l.58.** "note4 10/10" does not match `mathematica/exercises/sol_note4_odd_images.wl`, which has 23 `report[]` checks in the same commit c3a9b1c. Both `sol_note4_odd_images.tex:14` and the 10-14 re-run (S7-058) give 23/23.

Spiral rows that the record already knows (S7-046, S7-049, S7-050, S7-051, S7-052, S7-058) are not repeated here. The chapter has already fixed all of them except the mild S7-049 overstatement (New fix 1).
