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

## Reconciliation with the spiral project's record (2026-10-14)

> Independent reconciliation pass (RECONCILE brief). Spiral sources read: digests
> `docs/spiral_reconciliation_2026-10-14/note1_1b_2.md` (note2 rows), `note2b.md`, `note8_solutions.md`
> (it has **no** sol_note2 rows; the sol_note2 findings live inside S6-105/107/114), the full verdict
> text for S1-055/058/060/063, S6-098/102/112/114 recovered from the packet critic's workflow journal
> (`wf_a10ff0a2-7f9/journal.jsonl`), spiral `TESTS_AND_DIAGNOSTICS.md` rows + §2 entries A1, A4, A5, C11,
> C11b, `HANDOFF_arc_2026-09-21.md` §5–6, `NOTES_mcrit_label_defect_2026-08-03.md`,
> `theory/FACT_CRITIC_study_notes_2026-07-11.md`, `theory/solutions/FACT_CRITIC_SOLUTIONS_2026-07-24.md`,
> `mathematica/02_axisym_pl_pointmass/verify.wl` (checks 5a–5f), `mathematica/04_broken_pl/verify.wl`
> (checks 1–11). **Note:** the spiral working tree carries an *uncommitted* fix pass dated 2026-10-14
> (note2 12:38, note2b 12:40) that already repairs S6-094, S6-107 (in note2 only), S1-027, S1-032, S1-074;
> "spiral WT" below refers to that state.
>
> Scratch re-verification: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/reconcile_15/reconcile15.wl`
> run as `bash Mathematica/run_wl.sh <path>` → **`SUMMARY: 18 PASS, 0 FAIL  (of 18 checks)`**
> (log `reconcile15.log`, same dir). Chapter line numbers below are those of the current
> `15_PowerLaw_PointMass.tex` on wt/ch15 (after merging annotated-edition).

### Table

| spiral id | claim (source) | status in chapter | action |
|---|---|---|---|
| S6-094 ❌ | note2 remark: AGEL0854 γ_in≈0.6 as evidence for shallow total slopes (DM-only slope; retracted HANDOFF 07-30 §5) | n.a. — stripped; no AGEL0854/Shajib/γ_in anywhere in chapter, Solutions or .wl (grep). The chapter's version of the remark is the slope-only logic of the bridge at l.397–410 | none (spiral WT now carries a retraction box) |
| S6-098 ⚠ | note2: m "typically 0.3–3% for real systems" (unsourced) | n.a. — removed in port (critic N14); chapter says only "for a black hole in a galaxy, m≪1" (l.474) | none |
| S6-102 ⚠ | note2 abstract: "exactly the objects coded in tier1_axisym.py" | n.a. — project code reference stripped | none |
| S6-105 ❌ | note2 Ex.2 / sol_note2: μ=\|θ⁴/(θ⁴−θ•⁴)\| called "total magnification" | already fixed in port: Problem ex:pl_point_mass_mag (l.1094–1103) calls it the magnification "at image position θ" and gives the total as (u²+2)/(u√(u²+4)); Solutions l.73 uses "total" for that sum only | none |
| S6-107 ❌ | note2 Ex.4 / sol_note2 l.164–165: shift "±θ•²/θ±⁽⁰⁾" (sign wrong on minus branch) | already fixed in port: l.760–763 and Problem ex:pl_sis_pm_shift (l.1114–1123) state +θ•²/θ±⁽⁰⁾ on both branches; Solutions l.100–123 (θ₋ = −0.709026 exact vs −0.709143 linear) | none. Spiral WT fixed note2:179 but **not** the restated exercise in sol_note2 l.164–165 (feedback F4) |
| S6-110 ⚠ | note2: "radial images that are the star of this project" | n.a. — phrase gone | none |
| S6-111 ⚠ | note2: "Two facts that matter enormously later" | already fixed in port: "Two facts matter for the rest of the chapter" (l.451–452) | none |
| S6-112 ❌ | note2 item 2: PM "creates a faint central image — the one an unaware observer does not model" | already fixed in port: item 2 (l.457–458) keeps only "dominates the innermost region"; the faint near-PM image appears where it is true, in the PL+PM image counts (l.639–642, checks 5s) | none |
| S6-113 ⚠ | note2 abstract "This is the toolbox note." | n.a. | none |
| S6-114 ❌ | note2 §SIS+PM: "splits each image slightly and seeds a faint counter-image near the centre" | already fixed in port: keybox l.734–744 ("always exactly two images") + annotation l.746–758 explaining the spurious root; check 6e; critic D4a–f; this pass R2a–b (θ_cen = −0.004905 back-substitutes to y = 2.300, not 0.3; 2 images at y = 0.01…2.5) | none for chapter; the same error survives in sol_note2 l.202–204 and in spiral verify.wl check 5e's label — not named by S6-114 (feedback F1) |
| S1-007 ⚠ | note2b abstract "cost a day of wall-clock" | n.a. | none |
| S1-008 ⚠ | note2b abstract (i) "PM is the t₁→2 corner at fixed enclosed mass" (prose flag; substance PASSed) | substance already fixed in port body (§bpl_pm_limit l.892–908, joint limit); **inherited in the Summary** (l.1070–1071) and the exercise/solution — already in Flagged item 4 (X11) | see X11 |
| S1-009 ⚠ | note2b abstract "models part company at θ_B only logarithmically — necessary, not sufficient" | **partly inherited**: l.1003–1004 "part company only logarithmically", Summary l.1074 | new fix N-1 |
| S1-017 ⚠ | note2b: bPL(t₁=t₂=0.5) ≡ PL(1.5) "exactly" — true only for circular / same θ_E convention (3.7% at q=0.85, the R3 F(q,γ′) factor) | **mildly inherited**: annotation l.807–809 tells the reader a broken-power-law *code* "must reproduce the single power law … exactly" | new fix N-4 (one clause) |
| S1-019 ⚠ | note2b cross-ref "(Note 2, § radial critical curves)" names no heading | n.a. — chapter cross-refs are \S\ref labels | none |
| S1-027 ❌ / S1-028 ⚠ / S1-030 ⚠ | note2b nested-ladder keybox: sweep ranges t₁ 0.5–1.1, θ_B 0.04–0.07″, "never point-like", "the corner" ambiguity | n.a. — sweep numbers stripped; "corner" in the chapter means only the t₁→2 corner (l.870) | none (spiral WT fixed S1-027) |
| S1-032 ❌ / S1-033 ❌ / S1-036 ❌ | note2b §identity: 15/15, 42/42, ΔlogZ ranges; R3 provenance dates | n.a. — stripped | none |
| S1-048 ❌ | note2b remark: θ_BH used for two objects (injected PM, bEPL inner mass) | already fixed in port: chapter *defines* θ•² as the inner mass (l.876, 949) and keeps θ_eff separate with eq. bpl_eff_ratio (check 5d–5e); no fitted/injected values | none |
| S1-050 ❌ / S1-051 ⚠ | note2b remark on the corrected-corner θ_eff (±4–5%) | n.a. — stripped | none |
| S1-055 ⚠ | note2b §tworegimes: "t₁ = 2 … the bEPL **is** the point mass exactly" (at t₁=2 the inner mass diverges; only the one-sided limit at fixed mass is meaningful) | **inherited (minor)**: l.989–990 "For t₁=2 the ratio is 1 at every radius" (l.873 correctly says t₁=2 cannot be reached) | new fix N-2 |
| S1-056 ⚠ / S1-058 ❌ | note2b: deviation "logarithmic"; "observable separation scales as the PRODUCT (2−t₁)ln(θ_B/θ_min)" outside its validity (2−t₁ ~ 1) | **partly inherited**: the chapter keeps the O((2−t₁)²) remainder (eq. bpl_log_dev) and gives the exact law (eq. bpl_delta_radius, numbers 0.9/0.35 θ_B correct, R4c), but l.997 "only logarithmic in radius", l.1004 "only logarithmically" and Summary l.1074 generalise the small-(2−t₁)ln limit. R4a–b: at 2−t₁ = 1 the exact deviation is 1−θ/θ_B (linear in θ) and the log form exceeds 1 at θ_B/10 | new fix N-1 |
| S1-060 ❌ | note2b keybox "Two regimes…": degeneracy-limited branch, "no telescope fixes this" (prose escalation) | **inherited** in annotation l.1017–1028 ("two unrelated reasons … sharper imaging fixes this … no telescope fixes this"), and the substance needs a caveat the spiral record lacks: holding the galaxy (K = κ_Bθ_B^{t₂}) and the BH mass fixed, t₁→2 forces θ_B→0 (eq. bpl_joint_limit), so the degeneracy branch is reached only *inside* the resolution branch; at fixed θ_B it removes the galaxy (R3a) or makes the inner mass diverge (R3b). R3c: θ_B = 0.0076 θ_E at m = 0.01, 2−t₁ = 0.1, t₂ = 0.5 | new fix N-3 |
| S1-063 ❌ | note2b: "necessary, not sufficient" repeated 4× | **inherited** (3×: subsection title l.977, l.1002–1003, Summary l.1075) | new fix N-5 (prose) |
| S1-065, S1-066, S1-069, S1-072, S1-074, S1-076, S1-084, S1-090, S1-091, S1-096, S1-098, S1-099, S1-102, S1-103, S1-107 | note2b §5 remarks (66 fits, WP4b margin) and §6 HS10 / Cosmic Horseshoe | n.a. — stripped (grep: no Horseshoe/HS10/G6/WP4b/15-15 in chapter) | none |
| TESTS A1 ✅ | SIS+BH closed form vs numerical root solve | consistent: chapter <10⁻⁹ at y = 0.3, 1.4 (check 6h). (Spiral-internal: row says "tol 1e-10", §2 entry says "<1e−9" — F6) | none |
| TESTS A4 ✅ | m1_crit(γ′) = 0.0141, 0.0120, 0.0098, 0.0073, 0.0045, 0.0017 (γ′ = 1.4…1.9) | consistent: these are the chapter's single-plane eq. pl_mcrit mapped to plane 1 by m₁ = m₂ 𝓑^{−(3−γ′)/(γ′−1)} at 𝓑 = 0.82008; all six reproduce to 2 s.f. (R1, e.g. 0.011952 at 1.5 = (27/4096)/0.82008³) | none; worth one sentence in Ch. 21, not here |
| TESTS A5 ✅ | MWK01 mechanism; numeric m_max(γ′) at 𝓑=0.8, src=0.85 | consistent in mechanism (chapter cites Mao, Witt & Koopmans 2001, l.664–669); the m_max numbers depend on a source offset and a μ floor and are n.a. The §2 entry still ends "(cf. AGEL0854 γ_in≈0.6)" (TESTS l.196) — the S6-094 retraction has not reached it (spiral WT's own retraction box says so) | none for chapter; F5 |
| TESTS C11 ✅ | (i) "PM is the t₁→2 corner of the bEPL family at fixed inner mass"; (ii) outside-break identity | (ii) consistent (eq. bpl_identity, checks 5a–5b, 5f–5g). (i) is the framing the chapter's §bpl_pm_limit corrects; the row and the note still state it uncaveated | chapter: X11 (Flagged 4); spiral: F2 |
| TESTS C11b ✅ | signed θ_eff² identity; inner ratio (θ/θ_B)^{2−t₁}; D = (2−t₁)ln(θ_B/θ)+O((2−t₁)²); "observable separation is a PRODUCT"; two regimes; θ_eff²/θ•² = (t₁−t₂)/(2−t₂) | identity, sign, inner ratio, expansion and θ_eff/θ• ratio all consistent (eqs. bpl_identity, bpl_inner_ratio, bpl_log_dev, bpl_eff_ratio; checks 5c, 6a–6d). The "PRODUCT" sentence is S1-058's error and the two-regime framing is S1-060's; see those rows | N-1, N-3; F3 |
| Fixed-θ_B collapse (task question) | does the spiral record already say that t₁→2 at fixed inner mass with θ_B fixed collapses the whole lens? | **Only in a code comment**: `04_broken_pl/verify.wl:54–56` ("NB: with kB tied to thBH the OUTER branch also scales with (2−t₁) → the whole lens collapses to the PM"), which then tests only the inner branch (CHECK 4) and asserts the note uses "a separate outer PL" — the note does not say this, and a separate outer PL is not a member of the bEPL family. Note2b §3 (l.107–113: "for every θ>0, m_2D(θ)→πθ•²" — which *is* the collapse, unrecognised), the keybox l.119 ("EPL+PM is the boundary point"), TESTS C11 (i), and the packet critic (S1-025 PASS noting κ_B∝(2−t₁)→0; S1-029 PASS on "boundary point"; S1-055 addresses only t₁=2 divergence) all miss it. The chapter's critic was right to call it a source-note error | chapter: X11; spiral: F2 |
| NOTES_mcrit_label_defect | Tier-3 m/m_crit label miscalibrated (θ_E parameter vs physical, ×3.6 in m); correction: above the macro threshold LensCalc finds a radial curve at r≈0.010″, "the point mass's own critical curve" | label defect n.a. (chapter defines m against the physical Einstein radius of the power law alone, l.461–474). The "point mass's own radial critical curve" contradicts the chapter (l.454–456, λ_r = 1+θ•²/θ² > 0; above m_crit λ_r>0 everywhere, check 5w). R5b: circular γ′=1.4 + PM at the R5 true m = 0.0556 + external shear 0.1 has no critical curve anywhere in r ≤ 0.5 θ_E (larger eigenvalue ≥ 0.33); at r = 0.019 θ_E (=0.010″/0.525″) the PM shear is 154 vs κ_PL 3.9 | none for chapter; F7 (⚠ suspected artefact, not re-run in autolens) |
| HANDOFF 09-21 §5 | WP4b evidence sentence; AGEL0206 γ; "Note 2b Eq. 32–33"; verify.wl "15/15"→22/22; Horseshoe items; T1M flags | n.a. — none of these numbers/labels is in the chapter; the chapter's own scripts report 72/72, 36/36, 54/54 | none |
| HANDOFF 09-21 §6 | "two quantities that coincide in one limit get two names" | honoured: θ_eff vs θ• are named separately and their ratio is eq. bpl_eff_ratio; θ_E "of the power law alone" vs θ_t of the composite (l.471–473) | none |
| 07-11 critic N12 / PASS list | AGEL0854 labelled in-prep; "SIS+BH quadratics … correct" | the 07-11 pass PASSed the quadratics and did not catch the counter-image sentence (S6-114 found it 3 months later) | n.a. |

### New fixes for the fix pass (not already in Flagged above)

- **N-1 (S1-009/S1-056/S1-058, inherited wording).** l.997 "linear in the slope deficit 2−t₁ and only logarithmic in radius", l.1003–1004 "inside the break the models part company only logarithmically", Summary l.1074 "the two separate only logarithmically". The exact deviation is the power law 1−(θ/θ_B)^{2−t₁}; it is logarithmic in radius only while (2−t₁)ln(θ_B/θ) ≪ 1. At 2−t₁ = 1 it is 1−θ/θ_B, linear in θ, and the log form exceeds 1 at θ_B/10 (R4a–b). Suggested: l.997 "…to first order linear in 2−t₁ and logarithmic in radius (valid while (2−t₁)ln(θ_B/θ) ≪ 1)"; l.1004 "inside the break the models part company slowly, as (θ/θ_B)^{2−t₁}"; Summary "separate only as (θ/θ_B)^{2−t₁}, slowly when the cusp is steep". The numbers 0.9 θ_B / 0.35 θ_B (eq. bpl_delta_radius) are exact and stay.
- **N-2 (S1-055, inherited).** l.989–990 "For t₁=2 the ratio is 1 at every radius" → "As t₁→2⁻ at fixed inner mass the ratio tends to 1 at every radius (t₁ = 2 itself has divergent inner mass, \S\ref{sec:bpl_pm_limit})". Same wording in the annotation l.1022 if kept.
- **N-3 (S1-060 + the collapse, substantive).** Annotation l.1017–1028 calls resolution and degeneracy "two unrelated reasons". With the galaxy's outer normalisation K and the black-hole mass held fixed, eq. bpl_joint_limit gives θ_B = [(2−t₁)θ•²/(2K)]^{1/(2−t₂)} → 0, so (ii) is approached only together with an unresolvable break (R3c: θ_B = 0.0076 θ_E for m = 0.01, 2−t₁ = 0.1, t₂ = 0.5; 0.035 θ_E even at 2−t₁ = 1). At fixed θ_B the limit removes the galaxy (R3a, check 4c) or, at fixed K, sends the inner mass to infinity (R3b). Suggested addition after "(ii) Degeneracy: …": "For a fixed galaxy and black-hole mass this limit also drives θ_B→0 (eq. bpl_joint_limit), so in practice (ii) is reached only inside (i)." Also drop "unrelated". The rest of the annotation stands.
- **N-4 (S1-017, minor).** Annotation l.807–809 "with t₁ = t₂ = t the broken power law must reproduce the single power law of slope γ′ = t+1 exactly": add "(for a circular model, or with both codes on the same Einstein-radius convention)". Elliptical codes that parametrise θ_E differently disagree by a q-dependent factor even when t₁ = t₂.
- **N-5 (S1-063, prose).** "necessary, not sufficient" appears 3× (subsection title l.977, l.1002–1003, Summary l.1075). Keep the title; rephrase the other two in plain terms.
- **N-6 (optional, A4 cross-link).** The spiral A4 table is the chapter's m_crit(γ′) divided by 𝓑^{(3−γ′)/(γ′−1)} (R1). If Ch. 21 (central mass bias, multi-plane) quotes plane-1 thresholds, it should cite eq. pl_mcrit with that factor rather than retype numbers. Outside this chapter; orchestrator note only.

### Feedback to the spiral project (errors its record does not yet carry)

- **F1 — the "central counter-image" survives outside note2.** S6-114 (FAIL) names only `theory/note2_axisym_pl_pointmass.tex` (now l.169 in the WT, still unfixed). The same claim is in `theory/solutions/sol_note2_axisym_pl_pointmass.tex:202–204` ("…while seeding a faint central counter-image, since θ₊θ_cen = −θ•²") and in `mathematica/02_axisym_pl_pointmass/verify.wl` check **5e**, label "theta_+ * theta_central = −tBH^2 < 0 (BH seeds a central image)", with the comment at l.151–153 ("the point mass ALWAYS seeds a faint central counter-image"). The identity 5e tests is true; the label is false: θ_cen = ½[(y+θ_E)−√((y+θ_E)²+4θ•²)] is a root of the θ>0 quadratic lying at θ<0 and back-substitutes to y = 2.300 at θ_E=1, θ•=0.08, y=0.3 (reconcile15 R2a); SIS+PM has exactly 2 images for all y (R2b; Ch. 15 check 6e, critic D4a–f). The comment's own second clause (λ_r>0, no radial curve) contradicts the first. Fix: relabel 5e "product of roots of the θ>0 quadratic = −θ•² ⇒ exactly one root on that branch", and delete the counter-image clause in sol_note2 l.203. The 07-11 critic had PASSed "SIS+BH quadratics".
- **F2 — t₁→2 at fixed inner mass and fixed θ_B collapses the whole lens; the record says "EPL+PM is the boundary point".** `theory/note2b_broken_pl.tex` §pmlimit l.106–113 holds m_2D(θ_B)=πθ•² fixed at fixed θ_B and correctly finds m_2D(θ)→πθ•² "for every θ>0", which means the outer galaxy has gone too (κ_B∝(2−t₁)→0 multiplies the outer branch). The keybox l.119 then concludes "EPL+PM is the boundary point t₁→2 of bEPL at fixed inner mass", and TESTS C11 (i) repeats it. Only `04_broken_pl/verify.wl:54–56` notes the collapse, and it covers it with an appeal to "a separate outer PL" that the note never introduces and that is not a bEPL. The correct statement (Ch. 15 eq. bpl_joint_limit, checks 4c–4e; reconcile15 R3a, R3d; critic D8f–h): hold K = κ_Bθ_B^{t₂} and πθ•² fixed, so θ_B = [(2−t₁)θ•²/(2K)]^{1/(2−t₂)} → 0, and then α → 2Kθ^{1−t₂}/(2−t₂) + θ•²/θ at every fixed θ. EPL+PM is a boundary point of the bEPL family only along that joint path (t₁→2 *and* θ_B→0). Edit the keybox, the abstract item (i) (l.18–19), TESTS C11 (i), and turn the verify.wl comment into a check of the joint limit.
- **F3 — the degeneracy-limited regime needs the same caveat.** note2b keybox "Two regimes" (l.229–237, WT numbering) and TESTS C11b (b) present "degeneracy-limited (t₁→2)" as independent of resolution. For a lens with a fixed galaxy and BH mass, approaching t₁→2 drives θ_B→0 (R3c table: θ_B/θ_E = 0.0159/0.0034 at m = 0.003, 2−t₁ = 1/0.1; 0.111/0.024 at the R5 true m = 0.0556), so (b) is reached only inside (a); at fixed resolved θ_B the limit either removes the galaxy or needs an inner mass ∝ 1/(2−t₁) (R3b). The project's conclusion (the 66 fits have 2−t₁ ≥ 0.763, so case A is regime (a)) is unaffected and in fact strengthened. Only the framing "two unrelated reasons" / "no telescope fixes this" needs the caveat.
- **F4 — S6-107 fix incomplete.** Spiral WT fixed the "±" in note2:179, but the restated exercise in `theory/solutions/sol_note2_axisym_pl_pointmass.tex:164–165` still reads "shift by ±θ•²/θ±⁽⁰⁾" (S6-107's fix asked for both).
- **F5 — AGEL0854 slope still live in TESTS.** `TESTS_AND_DIAGNOSTICS.md:196` (A5 §2 entry) ends "(cf. AGEL0854 γ_in≈0.6)", the DM-only slope retracted in HANDOFF 07-30 §5 and now in note2's WT retraction box (which itself says the claim is still live in TESTS and HANDOFF_arc_2026-07-12). Recorded here so it is not lost: grep `0854` by error class.
- **F6 — note2 §"Reading the source-plane mapping" image count (never extracted by the packet critic).** `theory/note2_axisym_pl_pointmass.tex:183` (WT numbering): "Outside the radial caustic only the tangential pair survives." For a power law with 1<γ′<2 and 0<y₀ outside the radial caustic there is **one** image (the outer one): the θ<0 branch y(θ) = −[s−α(s)] has maximum |y_r| at s = θ_r, so no far-side root exists for y₀>|y_r|. Ch. 15 states it correctly (l.426–427, check 5q: three images at y₀ = 0.05 θ_E, one at 0.3 θ_E for γ′=1.5). The packet critic's coverage has no claim on note2 l.150–157 (only S6-103 at l.160), so this was never checked. Minor spiral-internal: TESTS A1 row says "tol 1e-10", its §2 entry "<1e−9".
- **F7 — ⚠ suspected artefact in the mcrit-defect correction (not re-run in autolens).** `NOTES_mcrit_label_defect_2026-08-03.md` (correction box) reports, above the macro threshold, "a radial critical curve DOES still exist … at r≈0.010″. It is the point mass's own critical curve." A point mass has no radial critical curve (λ_r = 1+θ•²/θ² > 0), and its own tangential curve (θ_BH ≈ 0.12″) is absorbed into the composite's tangential curve near θ_E. At r = 0.010″ ≈ 0.019 θ_E,1 in the γ′=1.40, mr0.75 cell the PM shear is m/r² ≈ 154 against κ_PL ≈ 3.9, so neither eigenvalue can vanish. A circular PL + PM + 0.1 external shear at the R5 true m has no critical curve anywhere in r ≤ 0.5 θ_E (R5b). I did not test the q=0.85 ellipse or the multi-plane tracer. The note's conclusion (no observable radial image in those cells) is unaffected, but the "point mass's own critical curve" reading is probably a 5-pixel marching-squares artefact at the singular PointMass centre (0.002″ pixels) and should be checked, e.g. by masking r < 3 px or evaluating det A analytically along a ray.

## Resolution — fixes applied 2026-10-14

Fix pass on wt/ch15 (after `git merge annotated-edition`). X9/X10 had already been fixed (8982cee) and were not touched again.

| id | Fix | Backing |
|---|---|---|
| N9 | Annotation "A tempting misreading": θ₋ = −0.0154 θ_E for y = 1.4 θ_E, θ• = 0.08 θ_E, with the leading order θ•²/(y−θ_E) = 0.016 θ_E given separately | problems_15.wl AN7 (tolerance 10⁻³ → 5×10⁻⁵; now also asserts that −0.0160 FAILS that tolerance and that the leading order is exactly 2/125) |
| X11 | Summary bullet rewritten as the joint corner t₁→2, θ_B→0 (inner mass and outer power law both fixed), and states that at fixed θ_B the limit leaves a bare point mass. Exercise ex:bpl_point_mass_limit gets the question "If θ_B is held fixed, what happens to the outer branch?" The solution answers it (outer branch → θ•²/θ, galaxy vanishes; joint limit needed) | broken_power_law.wl 4c (existing), 4d–4e; problems_15.wl new B2e |
| C10 | "the supermassive black hole that sits at the centre of essentially every massive galaxy" → "the supermassive black holes found at the centres of massive galaxies \citep{kormendy_ho_2013}". I made the claim weaker because the arXiv abstract (1304.7762), which is what I read, supports "SMBHs found in galaxies" but does not state the "essentially every" occupation claim. | bib key kormendy_ho_2013 |
| X6 | Ported to power_law_point_mass.wl: 5x (y = uλ_t, dy/du = λ_r, λ_r−λ_t = (γ′−1)u^{1−γ′}+2mu^{−2} > 0, proved symbolically for any 1<γ′<2, m>0); 5y (numeric grid γ′ = 1.1…1.9 × m/m_crit = 0.1, 0.5, 0.9: both radial roots inside θ_t, y_out < y_in < 0); 5z (exact CountRoots at γ′ = 1.3 and 1.8, m = m_crit/2: 2/4/2; m = 2m_crit: 2 for every y on a grid). Visible text: one clause added after |y_in|<|y_out| giving the argument ("for every slope 1<γ′<2: at either radial curve λ_t<λ_r=0 …") plus \annot tags | power_law_point_mass.wl 5x, 5y, 5z |
| N-1 | l.997: "to first order linear in 2−t₁ and logarithmic in radius" plus a validity sentence ((2−t₁)ln(θ_B/θ) ≪ 1; at 2−t₁ = 1 the deviation is 1−θ/θ_B; the log form exceeds 1 inside θ_B/e and gives 2.3 against 0.9 at θ_B/10). l.1003–1004 "only logarithmically" → "only as the power (θ/θ_B)^{2−t₁}, slowly when the cusp is steep". Summary changed the same way | broken_power_law.wl 6g, 6h |
| N-2 | "For t₁=2 the ratio is 1 at every radius" → "As t₁→2⁻ at fixed inner mass the ratio tends to 1 … (t₁=2 itself has a divergent inner mass, §bpl_pm_limit)". The annotation's (ii) now reads "tends to 1" | broken_power_law.wl 6b (existing), new 6i (inner mass at t₁=2 = 2πκ_Bθ_B² ln(θ_B/ε) → ∞) |
| N-3 | Annotation "Two different reasons…": "unrelated" dropped, "no telescope fixes this" dropped. Added: the two regimes are not independent. For a fixed galaxy and BH mass, t₁→2 drives θ_B→0 (eq. bpl_joint_limit), so (ii) is reached only inside (i). Example given: θ_B = 0.0076 θ_E at m = 0.01, 2−t₁ = 0.1, t₂ = 0.5. At fixed θ_B the limit removes the galaxy (4c) or sends the inner mass to infinity | broken_power_law.wl new 4g (0.00763 θ_E at 2−t₁ = 0.1; 0.0354 θ_E at 2−t₁ = 1; K = (2−t₂)/2 for an outer power law of Einstein radius θ_E) |
| N-4 | Slope-trap annotation: "exactly, for a circular model or with both codes on the same Einstein-radius convention; elliptical codes that define θ_E differently disagree by a factor that depends on the axis ratio" | prose caveat only (no new number); the circular identity is still checks 2c–2d |
| N-5 | "necessary, not sufficient" is kept only in the subsection title. The body (l.1002–1003) and Summary now use plain wording | — |
| P1 | "This one line is what makes the rest of the chapter work." → "Every critical-curve result below uses it." | — |
| P2 | "the most common error" → "a frequent source of error" | — |
| P3 | Keybox closers replaced with facts: "For γ′=1.5 and m=10⁻³ the Einstein ring moves by 0.2 per cent, yet any m>0.0066 removes the radial critical curve of every power law (eq. pl_mcrit below)" | power_law_point_mass.wl 5p, 5m (existing) |
| P4 | "The numbers are worth absorbing." deleted | — |
| P5 | "It is large." deleted | — |
| P6 | Chiastic closer → "A power law therefore lacks a radial critical curve only for γ′ ≥ 2." | checks 3e–3f (existing) |
| P7 | "Nothing new is being introduced; …" deleted from the bridge | — |
| P8 | Rhetorical "exactly" dropped at l.236 ("is exactly what makes it so") and l.886 ("becomes \emph{exactly} the point-mass deflection"). The mathematical uses are kept | — |

**Verification after edits.** All scripts were run with `bash Mathematica/run_wl.sh <script>`.
- Before: `power_law_point_mass.wl` → `SUMMARY: 72 PASS, 0 FAIL  (of 72 checks)`; `broken_power_law.wl` → `SUMMARY: 36 PASS, 0 FAIL  (of 36 checks)`; `problems_15.wl` → `SUMMARY: 54 PASS, 0 FAIL  (of 54 checks)`.
- After: `power_law_point_mass.wl` → `SUMMARY: 75 PASS, 0 FAIL  (of 75 checks)`; `broken_power_law.wl` → `SUMMARY: 40 PASS, 0 FAIL  (of 40 checks)`; `problems_15.wl` → `SUMMARY: 55 PASS, 0 FAIL  (of 55 checks)`.

The `ANNOT_REQUIRED=1 bash build.sh` build ended "all assertions passed". Page counts: Student 360, Instructor 444, Annotated 568. `pdftotext Output/Learning_to_Lens.pdf - | grep -c '\[check'` = 0. Figures were not changed: the regenerated PDFs were reverted.

**Left open.**
- X12 (stale wt Output PDFs): informational only, and the rebuild supersedes it.
- N-6 (A4 cross-link to Ch. 21): outside this chapter, so it is noted for the orchestrator.
- The spiral-project feedback F1–F7 is outside this repo.
- Provenance (whole chapter machine-drafted): the author still needs to rewrite it before external release.

### Session-3 closeout (2026-10-14, orchestrator)
- N-6: Chapter 21 derives its own `eq:cb_mcrit` (`17_Central_Mass_Bias.tex:715`) and its table values from it; it does not retype the spiral A4 thresholds, so no cross-link is needed. Closed.