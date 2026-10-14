# fact-critic report — Notes/15_PowerLaw_PointMass/15_PowerLaw_PointMass.tex (+ 15_Solutions.tex, .wl)

> Date: 2026-10-14 · Book position: PDF Chapter 19 "Power-Law Lenses with a Central Point Mass"
> Lenses: Citation, Number, Consistency, Prose, Derivation (Provenance summarized)
> Active adapters this run: bibtex ✓ (Notes/references.bib), crossref-web ✓ (api.crossref.org,
> export.arxiv.org reachable; Keeton arXiv PDF fetched with `curl -o`), md-reflist ✗ (n/a),
> values-file ✗ (none), repo-grep ✓, doc-internal ✓, reference-PDF ✓ (Reference_Texts/ Meneghetti 2021,
> Narayan & Bartelmann), wolframscript ✓ (via Mathematica/run_wl.sh), overlay: AGEL (source notes read-only;
> Zotero not needed — all three cited works confirmed by CrossRef/arXiv + full text).
> Independent critic; did not write the chapter.
>
> Repo scripts run (this session, worktree wt/ch15):
> - `power_law_point_mass.wl` → `SUMMARY: 72 PASS, 0 FAIL  (of 72 checks)`
> - `broken_power_law.wl` → `SUMMARY: 36 PASS, 0 FAIL  (of 36 checks)`
> - `problems_15.wl` → `SUMMARY: 54 PASS, 0 FAIL  (of 54 checks)`
>
> Scratch re-derivations: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_15/critic15_derivations.wl`
> → `SUMMARY: 36 PASS, 0 FAIL  (of 36 checks)` (log: `critic15_derivations.log`, same dir).

## Verdict counts

| lens | ✅ PASS | ⚠ SUSPECT | ❌ FAIL |
|---|---|---|---|
| Citation (C) | 9 | 1 | 0 |
| Number (N) | 13 | 1 | 0 |
| Consistency (X) | 8 | 3 | 1 |
| Prose (P) | — | 8 | 0 |
| Derivation (D) | 6 | 0 | 0 |
| **total** | **36** | **13** | **1** |

## Verdicts

| id | lens | quoted (tex line) | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "Meneghetti (§5.2, eqs. 5.38–5.40) … m(x)=x^{3−n}, κ=m′/(2x)=(3−n)/2 x^{1−n}, α=x^{2−n}" (281–286) | ✅ PASS | bib:meneghetti_introduction_2021 / CrossRef DOI 10.1007/978-3-030-73582-1 ("Introduction to Gravitational Lensing") / Reference_Texts PDF book pp. 186–187, eqs. 5.38–5.40 verbatim; check 1i–1j | none |
| C2 | Citation | "θ_r/θ_E → e^{-1}, which is eq. 5.44" (379–380) | ✅ PASS | Meneghetti PDF eq. 5.44 (x_r → 1/e); check 3h, AN9 | none |
| C3 | Citation | "|y_r|→θ_E as γ′→2 (compare statement after eq. 5.44)" (394–396) | ✅ PASS | Meneghetti PDF p.188: "for n → 2, y_r → 1"; check 3k | none |
| C4 | Citation | "Remark 5.3 … n=3 … *is* the point mass" (891–894) | ✅ PASS | Meneghetti PDF Remark 5.3: "The case n = 3 corresponds to the point-mass lens … α(x)=m/x"; check 1k, 4f | none |
| C5 | Citation | "image diagram of Meneghetti (§5.2.1)" (204) | ✅ PASS | Meneghetti PDF §5.2.1 "Multiple Images … the so-called image diagram" | none |
| C6 | Citation | "Keeton (eqs. 26 and 29, softened power law) … b^{γ′−1}=(3−γ′)θ_E^{γ′−1}; b=θ_E only for isothermal" (287–293) | ✅ PASS | bib:keeton_2001_catalog / arXiv astro-ph/0102341 title confirmed; fetched PDF p.7 eqs. (26) κ=½b^{2−α}/(s²+ξ²)^{1−α/2}, (29) φ_r=(b^{2−α}/αr)[(s²+r²)^{α/2}−s^α], "M_cyl ∝ r^α asymptotically"; s=0, α=3−γ′ reproduces our κ, α; checks 1l–1n | none |
| C7 | Citation | "potential ψ=θ•² ln θ of Keeton eqs. 23–24" (453–454) | ✅ PASS | Keeton PDF eq. (23) φ=R_E² ln r, eq. (24) R_E; check 4e | none |
| C8 | Citation | "Mao, Witt & Koopmans (2001) found the same behaviour for a cored isothermal ellipsoid with a central black hole: … critical mass … all source positions … zone of influence … additional image" (667–672) | ✅ PASS | bib:mao_witt_koopmans_2001 / CrossRef DOI 10.1046/j.1365-8711.2001.04143.x (MNRAS 323, 301–307, title matches) / arXiv astro-ph/0007011 abstract supports all three clauses verbatim | none |
| C9 | Citation | header comment "Narayan & Bartelmann Sect. 3.1" (7) | ✅ PASS (comment only, not rendered) | Reference_Texts N&B TOC: §3.1 = "Lensing by a Singular Isothermal Sphere" (relevant to §19.4); general circular formalism is §3.4 | optional: "Sects. 3.1, 3.4" |
| C10 | Citation | "the supermassive black hole that sits at the centre of essentially every massive galaxy" (26–27) | ⚠ SUSPECT (external claim, no citation) | none in chapter; CrossRef confirms a standard review exists: Kormendy & Ho 2013, ARA&A 51, 511–653, DOI 10.1146/annurev-astro-082708-101811 (not in references.bib) | add that citation (after author check) or soften to "most massive galaxies" |
| N1 | Number | θ_r/θ_E = 0.0427 (γ′=1.95), 0.217 (1.6), 0.25 (1.5), →1/e (361) | ✅ PASS | check 3g, 3h; problems 3c (0.21715) | none |
| N2 | Number | y_r = −θ_E/4 at γ′=1.5 (392) | ✅ PASS | check 3k | none |
| N3 | Number | weight amplification 4^{3/2}=8 (517) | ✅ PASS | check 5d, AN3 | none |
| N4 | Number | m_crit(3/2)=27/4096≈0.0066, u_c=9/64; max 0.0066 at γ′≈1.48 (579–581, 1065) | ✅ PASS | checks 5k–5m, AN5, problems 6a–6e; scratch D3a–D3c (bisection on min λ_r agrees to <1e-4 at γ′=1.3,1.5,1.8; NMaximize max = 0.0065996 at γ′ = 1.48463) | none |
| N5 | Number | inner/outer caustics 0.234/0.263 θ_E (γ′=1.5, m=0.003) (634–635) | ✅ PASS | check 5r (0.2336/0.2627) | none |
| N6 | Number | merged caustic |y|=9θ_E/32 (652) | ✅ PASS | check 5t; problems 6d | none |
| N7 | Number | zone radius 0.17 θ_E exact, 0.19 leading order, m=10⁻³ (665–667) | ✅ PASS | AN4 (0.1714 / 0.1890); scratch D6a | none |
| N8 | Number | closed form vs numerical root solve <10⁻⁹, θ_E=1, θ•=0.08, y=0.3 or 1.4 (733–735) | ✅ PASS | check 6h | none |
| N9 | Number | "θ₋ ≃ −0.016 θ_E for y=1.4 θ_E, θ•=0.08 θ_E" (759–760, annotation) | ⚠ SUSPECT | exact root (closed form eq. pl_sis_pm_minus) = −0.015407; −0.0160 is the leading-order θ•²/(y−θ_E), 3.7% high; AN7 passes only because its tolerance is 10⁻³; scratch D4d | "θ₋ = −0.0154 θ_E (leading order θ•²/(y−θ_E) = 0.016)"; tighten AN7 tolerance |
| N10 | Number | 10% difference at 0.9 θ_B (2−t₁=1), 0.35 θ_B (2−t₁=0.1) (1014–1016) | ✅ PASS | check 6f (0.349); scratch D8k | none |
| N11 | Number | κ(θ_E)=(3−γ′)/2 = 0.75 at 1.5, ½ SIS; λ_r(θ_E)=γ′−1 = 0.5 (317–333, 1050) | ✅ PASS | checks 1f, 2d, AN1; scratch D2b | none |
| N12 | Number | "m~10⁻³ … per-mille" tangential shift (697–701) | ✅ PASS | check 5o–5p (u_t=1.0020); scratch D7a (γ′=1.3) | none |
| N13 | Number | Solutions: 1.1011, 0.2172, 1.304905/−0.709026 vs 1.304923/−0.709143, u_t=1.0195, θ₊=1.3728 | ✅ PASS | problems 2g, 3c, 4e, 5d, B3c | none |
| N14 | Number | project-leakage number "m 0.3–3%" (source note 2 l.118) | ✅ PASS (gone) | grep of chapter tex/Solutions/.wl: no hit for `0.3.?--.?3`, `3\%` | none |
| X1 | Consistency | m_crit closed form here (eq. pl_mcrit, u_c) vs PDF Ch. 21 (17_Central_Mass_Bias.tex:691–698, θ★ and m_crit = ½(2−γ′)(γ′−1)θ★^{3−γ′}) | ✅ PASS | identical symbolically (scratch D3d, `Simplify[...] === 0`); u_c ≡ θ★; Ch. 21 Table (0.00659 at 1.5) and "0.0066 at γ′≈1.48" agree with N4 | none |
| X2 | Consistency | every `Chapter~\ref` | ✅ PASS | annotated PDF TOC (main repo Output, 09:07): axisymmetric_models→11, galaxy_lensing→13, magnification→9, odd_images→20, central_mass_bias→21, perturbative_estimators→25; each target's content matches the sentence (NIS θ_c<θ_E/2 at 07:731; sec:power_law_profile + eq:kappa_power_law in 09; eq:pm_magnification 07:318; sec:pe_image_shift in 21_Perturbative) | none |
| X3 | Consistency | chapter ↔ Solutions ↔ three .wl | ✅ PASS | 72/36/54 PASS; all printed solution numbers trace to a check id | none |
| X4 | Consistency | γ′ vs s=t=γ′−1 vs α_K=3−γ′ table (299–306), t=γ′−1 (798), "t<1 for radial images" (803) | ✅ PASS | AN2, AN8; bpl check 0a; no slope used in the wrong convention found anywhere in the chapter | none |
| X5 | Consistency | project leakage (tier, scripts/, results/, lenstronomy, autolens/autogalaxy, J0946, AGEL, AGEL0854, Horseshoe, Carousel, Nautilus, "this project", C5/C11) | ✅ PASS | grep over chapter .tex, Solutions .tex, both .wl, problems_15.wl: zero hits | none |
| X6 | Consistency | image counts 2/4/2 "stated generically", tested only at γ′=3/2 (639–646) | ✅ PASS (independent) | scratch D5a/b at γ′=1.3 and 1.8 (m=m_crit/2): counts {2,4,2}; analytic: λ_r−λ_t=2|γ|≥0 ⇒ every radial critical radius lies inside θ_t where y<0, and y rises→max(y_in)→falls→min(y_out) ⇒ |y_in|<|y_out| for any slope | add a repo check at γ′≠3/2 (e.g. copy D5) |
| X7 | Consistency | "Above threshold … exactly two images for every source" (647–649) | ✅ PASS | check 5w (γ′=3/2); scratch D5c at γ′=1.3, 1.8 (m=2m_crit) | none |
| X8 | Consistency | Annotated-only tags (`\annot{}`, annotation/derivation/bridge boxes) | ✅ PASS for all `\annot{}` and in-box tags | editions.tex:63/68; annotated PDF shows "[check 5q]" etc. | — |
| X9 | Consistency | **visible check tags in the student/instructor editions**: "[Checks 1i--1n.]" (293) and "[Checks 3j--3k.]" (397) — both in body text, not in a box, not wrapped in `\annot` | ❌ FAIL | main-repo Output/Learning_to_Lens.pdf (09:06): pdftotext shows "equals θE only for the isothermal case. [Checks 1i–1n.]" and "Meneghetti [23]). [Checks 3j–3k.]" | `\annot{checks 1i--1n}` and `\annot{checks 3j--3k}` |
| X10 | Consistency | stray space before punctuation where `\annot{}` is empty: student PDF reads "has one .", "κ̄(θE) = 1 .", "there .", "any power law .", "critical curve ." (16 ` \annot{` sites) | ⚠ SUSPECT (typography) | main-repo student PDF text, ch. 19 | in editions.tex non-annotated branch: `\newcommand{\annot}[1]{\unskip}` (outside chapter dir — author's call) |
| X11 | Consistency | Summary bullet "the point mass is its t₁→2 corner at fixed inner mass" (1074–1076) and Exercise ex:bpl_point_mass_limit/solution (no mention of the outer-branch collapse) vs §19.5.3 joint limit (896–912) | ⚠ SUSPECT | internal; §19.5.3 + check 4c show that fixed inner mass at fixed θ_B collapses the whole lens | bullet: "…its t₁→2, θ_B→0 corner (inner mass and outer power law both held fixed)"; add one line to the solution: "at fixed θ_B the outer branch also goes to zero (check 4c)" |
| X12 | Consistency | worktree `Output/*.pdf` (08:46): 262/317/317 pp, Annotated text-md5 = Solutions text-md5, 0 sentinels | ⚠ SUSPECT (stale artifact, informational) | Output/build_fingerprints.txt in wt/ch15 vs main repo (360/444/569 pp, 511 sentinels) | don't commit worktree PDFs; rebuild from the merged branch |
| D1–D6 | Derivation | see "Derivation checks" | ✅ PASS ×6 | scratch .wl | — |
| P1–P8 | Prose | see "Prose" | ⚠ ×8 | read | see below |

## Applied (auto-fixes)

None. N9 is the only number off its canonical value, and the `≃` makes it ambiguous whether the
leading-order estimate was intended, so it stays flag-only. Nothing else qualified.

## Flagged — your hand required

1. **X9 ❌ — two check tags still print in the student and instructor editions.** Lines 293 (`[Checks 1i--1n.]`,
   end of the "Cross-check against the literature" paragraph) and 397 (`[Checks 3j--3k.]`, after the
   radial-caustic equation) are in body text, outside any annotation box and not wrapped in `\annot{}`.
   Confirmed in the current merged `Output/Learning_to_Lens.pdf` (main repo, 09:06), so
   commit 7ad4427 ("last multi-line [checks] tag gated") missed them. Fix: `\annot{checks 1i--1n}`,
   `\annot{checks 3j--3k}`; then rebuild and re-grep the student PDF for `Checks`.
   (Out of scope, same build: Chapter 18 has many visible "(Check 2a.)"-style tags and Chapter 21 has
   "[Verified: checks D1–D3c …]" in the student text. Those may be intentional for those chapters, but they don't match the Ch. 19 policy.)
2. **X10 ⚠ — the empty `\annot{}` leaves a space before punctuation** in the student and instructor editions
   ("has one .", "there ."). The fix belongs in `Notes/editions.tex` (non-annotated branch:
   `\newcommand{\annot}[1]{\unskip}`), which is outside this chapter's directory, so I did not apply it. It affects every chapter that uses `\annot`.
3. **N9 ⚠ — "θ₋ ≃ −0.016 θ_E" (annotation, l.759).** The exact root is −0.0154 θ_E. 0.016 is the
   leading-order θ•²/(y−θ_E). Suggest "θ₋ = −0.0154 θ_E (leading order 0.016)". Also tighten AN7's
   tolerance in problems_15.wl, which is currently 10⁻³ and passes either value.
4. **X11 ⚠ — the Summary repeats the source-note framing that §19.5.3 corrects.** "The point mass is its
   t₁→2 corner at fixed inner mass" is exactly the limit that collapses the whole lens (check 4c). Reword it as
   the joint limit (θ_B→0 with K=κ_Bθ_B^{t₂} fixed). The Exercise "The point-mass limit" and its solution
   cover only the inner branch, so add the one-line caveat there as well.
5. **C10 ⚠ — "SMBH at the centre of essentially every massive galaxy" has no citation.** A standard review
   exists and its metadata is CrossRef-confirmed: Kormendy & Ho 2013, ARA&A 51, 511, DOI
   10.1146/annurev-astro-082708-101811. It is not in references.bib. Add it, or soften the claim.
6. **X6 (recommendation, not an error).** The repo verifies the 2/4/2 counts and the supercritical
   2-image count only at γ′=3/2 (checks 5s, 5w). The claim holds generically: scratch D5 at γ′=1.3 and 1.8, plus the
   analytic argument in X6. Port D5 into power_law_point_mass.wl so the generic statement has a repo check.
7. **X12 (informational).** The wt/ch15 `Output/` PDFs are pre-merge and stale (the annotated PDF equals the
   instructor text). Use the main-repo build for any visual verification.

## Source-note errors — adjudication

- **(1) note2 §3 "the point mass … seeds a faint counter-image near the centre" (also sol_note2 l.203, and
  verify.wl check 5e "BH seeds a central image"): CONFIRMED as an error. The chapter's correction is right.**
  The negative root of the θ>0 quadratic, θ_cen = ½[(y+θ_E)−√…], does not satisfy the full signed
  lens equation y = θ − θ_E sgnθ − θ•²/θ (scratch D4b: residual >10⁻³ at y = 0.1–2.5). Root counts are
  exactly 2 for every y on a 300-point grid in (0,3] (D4a), and a brute-force sign-change count of the full
  signed map also gives 2 at y = 0.05, 0.3, 0.99, 1.01, 1.4, 2.5 (D4f). One nuance: for y > θ_E a far-side image
  near the centre does exist. It is the θ<0-branch root, |θ₋| → θ•²/(y−θ_E) (D4e: 0.2% at y=3), and it is
  the second of two images, not a third. The chapter's keybox states this correctly. The source note's
  "splits each image … and seeds" implies a third image, which is wrong.
- **(2) note2b §3 "t₁→2 at fixed inner mass" with θ_B fixed: CONFIRMED as an error.** With
  κ_B = (2−t₁)θ•²/(2θ_B²) and θ_B fixed, the outer branch tends to θ•²/θ for every θ>θ_B (scratch D8f,
  symbolic `Limit`). The whole lens becomes a bare point mass, so "EPL+PM is the boundary point" does
  not follow. The source's own verify.wl has a code comment ("NB: … the whole lens collapses to the
  PM"), but the note text never says it. The chapter's joint limit, θ_B = [(2−t₁)θ•²/(2K)]^{1/(2−t₂)} → 0 with
  K fixed, gives 2Kθ^{1−t₂}/(2−t₂) + θ•²/θ (D8g numerically: 0.39848170500 vs target 0.39848170500 at
  2−t₁ = 10⁻¹², and D8h confirms the inner mass stays π θ•²).

## Prose (LLM tells) — flag-only

Em-dashes: 3 in the body (all in the "Companion Mathematica files" list, structural) plus 1 in a comment.
None are rhetorical. "exactly" appears 21×: most are mathematical ("exactly two images",
"exactly the point-mass deflection"), but a few are emphatic. Antithesis: 3 (two of them carry
physics: "an identity, not an approximation"; "necessary, not sufficient"). Sentence-length CV 0.58 over
286 sentences, which is not uniform. Most of the prose reads clean. The tells cluster at paragraph ends:

- P1 (l.177) "This one line is what makes the rest of the chapter work." Aphoristic closer. Delete it, or
  write "Every critical-curve result below uses it."
- P2 (l.297–298, annotation) "the most common error in power-law work". Unsupported superlative. Use "a
  frequent source of error".
- P3 (l.528–530, keybox) "Radial images form exactly in the region a central mass controls. A black hole
  that barely moves the Einstein ring can therefore decide whether a radial image exists at all." Two
  closers in a row. Replace with a fact: "For m ≈ 10⁻³ the Einstein ring moves by 0.2%, yet m above
  0.0066 removes the radial critical curve of any power law."
- P4 (l.585) "The numbers are worth absorbing." Throat-clearing. Delete.
- P5 (l.655–656) "…sources inside it lose their radial image. It is large." Merge it into the number:
  "…lose their radial image; for m=10⁻³ it extends to 0.17 θ_E."
- P6 (l.410–411, bridge) '"Cuspy" therefore does not mean "no radial image"; "at least as steep as
  isothermal" does.' Chiastic closer. Use "A radial critical curve is absent only for γ′ ≥ 2."
- P7 (l.164, bridge) "Nothing new is being introduced; we are only specializing a result you already
  have." Delete it; the preceding sentence already says this.
- P8 (l.236–237, 528, 890) emphatic "exactly". Keep the mathematical uses and drop the rhetorical ones.

## Provenance (machine-drafted text) — flag-only

Baseline: none author-written for this chapter. Every commit touching the .tex carries model attribution
(1329863 Claude Opus 5.5; af51078/85e8b82/7ad4427 Claude Fable 5.1), and the prose is ported from source
notes that were also model-drafted. Treat 100% of the chapter as machine-introduced. Per the lens, the author
should rewrite in their own words before external release, starting with the P1–P8 sites. No per-sentence
table is given because there is no human baseline to diff against.

## Derivation checks

Script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_15/critic15_derivations.wl`
(run via `bash Mathematica/run_wl.sh`). SUMMARY line: **`SUMMARY: 36 PASS, 0 FAIL  (of 36 checks)`**.
(The first run had 2 FAILs, both bugs in the scratch script itself: an NSolve lower bound of 10⁻⁶ excluded u_in at γ′=1.8, m=10⁻⁸,
and a test was written to the chapter's rounded −0.016. Both were fixed, and the −0.016 issue is reported as N9.)

| id | equation | independent route | result |
|---|---|---|---|
| D1 | eq. pl_dalpha, dα/dθ = 2κ − κ̄ (and the inversion eq. pl_kappa_inversion) | symbolic with an *unspecified* function κ(x) | ✅ D1a, D1b |
| D2 | eq. pl_mcrit, m_crit(γ′) and u_c | bisection on min_u λ_r(u) over a 12 600-point log grid at γ′ = 1.3, 1.5, 1.8 (0.0055393, 0.0065918, 0.0033255; agree with the closed form to <10⁻⁴ rel.); exact 27/4096 and 9/64; NMaximize max 0.0065996 at γ′=1.48463; symbolic identity with Ch. 21's θ★ form | ✅ D3a–D3d |
| D3 | eqs. pl_sis_pm_lens_eq/plus/minus + keybox "always exactly two images" | branch-wise NSolve, keeping roots on their own branch; residual of the discarded root; brute-force sign-change count of the full signed map | ✅ D4a–D4f |
| D4 | image counts 2/4/2 and the supercritical count 2 (§19.3.3) | sign-change root count of the signed map on both branches at γ′=1.3 and 1.8 (m = m_crit/2 and 2 m_crit) | ✅ D5a–D5c (both slopes) |
| D5 | eqs. bpl_alpha_in/out, bpl_norm, bpl_identity, bpl_joint_limit, bpl_eff_ratio | direct piecewise integration of κ; continuity; SIS limit; identity; fixed-θ_B limit (source-note error) vs the joint limit; inner-mass bookkeeping; normalization α(θ_E)=1 | ✅ D8a–D8k |
| D6 | eq. pl_zone (zone of influence) | exact inner radial root vs leading order: γ′=1.5, m=10⁻³ gives 0.1714 vs 0.1890; ratio at m=10⁻⁸ is 0.975 (γ′=1.3), 0.998 (1.5), 1.000 (1.8), consistent with the stated O(u_in^{γ′−1}) slow convergence near γ′=1 | ✅ D6a–D6c |

Also re-derived: power-law α = θ_E^{γ′−1}θ^{2−γ′} from κ, κ(θ_E) = (3−γ′)/2, θ_r zero of λ_r (D2a–c); the
tangential shift u_t − 1 ≈ m/(γ′−1) at γ′=1.3 (D7a).
