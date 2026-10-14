# fact-critic report: 01d_Geodesics_Orbits, Annotated Study Edition layer

> Date: 2026-10-14 · Scope: annotation/derivation/bridge blocks added in commit `8b10a1e`
> (`git diff c588432 8b10a1e -- Notes/01d*`) in `01d_Geodesics_Orbits.tex` and `01d_Solutions.tex`,
> the "Annotated-edition checks (2026-10)" section of `Solutions/01d_Geodesics_Orbits/problems_01d.wl`,
> and adjudication of the author's flags on the VISIBLE text (no visible-text edits made).
> Lenses: Citation, Number, Consistency, Prose, Derivation.
> Active adapters this run: bibtex ✓ (`Notes/references.bib`; no `\cite` in scope), crossref-web ✓
> (api.crossref.org reachable; Wikipedia raw page and arXiv used as public corroboration), md-reflist ✗,
> values-file ✗, repo-grep ✓, doc-internal ✓, reference-PDF ✓ (`Reference_Texts/Congdon and Keeton 2018`
> via `pdftotext`; Carroll is an image scan, so no Carroll equation number is checked or PASSed),
> wolframscript ✓ (via `Mathematica/run_wl.sh`), overlay agel-sources (Zotero not needed).
> Critic is independent of the author: every PASS below names a run check, a PDF line, or a fetched record.

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | Kerr annotation: "the standard closed form r_ISCO = 3 + Z2 ∓ √((3−Z1)(3+Z1+2Z2)) …" (unattributed) | ⚠ SUSPECT (unattributed; formula correct) | Formula matches Wikipedia "Innermost stable circular orbit" (raw wikitext, ref to Bardeen, Press & Teukolsky 1972, ApJ 178, 347); CrossRef DOI 10.1086/151796 confirmed (title "Rotating Black Holes: Locally Nonrotating Frames, Energy Extraction, and Scalar Synchrotron Radiation", vol 178, p 347); critic D10a/D10b | Optional plain-text attribution "(Bardeen, Press & Teukolsky 1972)"; no bib key added |
| C2 | Citation | Units annotation / deflection box: eq. `photon_orbit` and b = cL/E use E = f c² dt/dλ | ✅ PASS | C&K 2018 eq. (3.76a) "ε = c²(1 − R_S/r) ṫ" and (3.78) ṙ² = ε²/c² − (1−R_S/r)(ℓ²/r² + c²) (pdftotext of `Reference_Texts/Congdon and Keeton…pdf`); critic F1b, F1c, F1e | none |
| C3 | Citation | "absorbing Carroll's constant ½ε into 𝓔" | ⚠ SUSPECT (Carroll scan unreadable) | echoes visible "Carroll eq. 5.66"; not checkable here | none (no new claim) |
| N1 | Number | b_crit = 3√3 GM/c² = (3√3/2) R_S ≈ 2.598 R_S | ✅ PASS | critic D2f, D2g; D2h numeric capture test (b = 5.10 M captured, 5.30 M escapes) | none |
| N2 | Number | ISCO efficiency 1 − 2√2/3 ≈ 0.057 (5.7%), V_eff(6) = −1/18 | ✅ PASS | critic D2a, D2b; repo A5b | none |
| N3 | Number | R_S/a ≈ 5.1×10⁻⁸ (Mercury); R_S/r = 1/3 at ISCO | ✅ PASS | critic D5d; repo A8i | none |
| N4 | Number | L = 4: r₊ = 12, r₋ = 4; V(4) = 0 ⇒ E² = 1 (marginally bound) | ✅ PASS | critic D2c | none |
| N5 | Number | r₋(L) → 3GM/c² as L → ∞; V''(r±) = ±GM(r₊−r₋)/r±⁴ | ✅ PASS | critic D2d, D2e | none |
| N6 | Number | Sun at limb b/R_S ≈ 2.36×10⁵ | ✅ PASS | critic D9c (235 625) | none |
| N7 | Number | 10⁹ M☉: R_S ≈ 2.95×10¹² m ≈ 9.6×10⁻⁵ pc; b/R_S ≈ 1.0×10⁷ at 1 kpc, ≈ 1.0×10⁶ at 100 pc | ✅ PASS | critic D9c (1.045×10⁷, 1.045×10⁶); repo A12c line | none |
| N8 | Number | 71% of the bend within |x| < b, 99.5% within 10b | ✅ PASS | critic D9d (1/√2 = 0.7071; 0.99504) | none |
| N9 | Number | Mercury box: GM☉/c² = 1477 m, 6πGM/c² = 2.784×10⁴ m, a(1−e²) = 5.545×10¹⁰ m, Δφ = 5.02×10⁻⁷, 0.10355″, 415.2 orbits, 43.0″ | ✅ PASS | critic D5a–D5d (Δφ = 5.0204×10⁻⁷ rad = 0.103553″/orbit; N = 415.198; 42.995″/century) | none |
| N10 | Number | Kerr ISCO 6 (a = 0), 1 (prograde) / 9 (retrograde) at a = 1; upper sign prograde | ✅ PASS | critic D10a; D10b independent R = R' = R'' = 0 at a = 0.5 gives 4.2330025 (pro) / 7.5545847 (retro) = closed form to < 1e−8 | none |
| N11 | Number | L = 4 near r₊ = 12: advance 2π(√2 − 1) ≈ 2.60 rad ≈ 149° per orbit | ✅ PASS | critic D3a (κ²/Ω² = 1 − 6/r_c), D3b (direct orbit integration, 𝓔 = V(12) + 5×10⁻⁴: advance 2.619 rad) | none |
| N12 | Number | Kerr horizons/ergosurface statements (r = R_S at equator for all a; touches horizon at poles) | ✅ PASS | doc-internal algebra re-done by critic (r² − R_S r + a²cos²θ = 0) | none |
| X1 | Consistency | Mercury Δφ: chapter eq. & annotation 5.02×10⁻⁷ vs Solutions Steps 1–2 "5.01×10⁻⁷" | ❌ FAIL (visible) | critic D5a: 5.0204×10⁻⁷ | Flag F2 |
| X2 | Consistency | Solutions "0.1034″/orbit" and "0.1034 × 415.2 = 43.0" | ❌ FAIL (visible) | critic D5b: 0.1036″; 0.1034×415.2 = 42.93 | Flag F2 |
| X3 | Consistency | E normalisation: eqs. conserved_E/normalization (c = 1) vs V_eff, 𝓔 (explicit c) vs photon_orbit, b = cL/E | ❌ FAIL (visible) | critic F1a–F1f; C&K (3.76a), (3.78), (3.87) | Flag F1 |
| X4 | Consistency | Solutions Ex 5(b) "advances by a small angle each orbit" vs annotation "2.60 rad … not a small angle" | ❌ FAIL (visible) | critic D3a, D3b | Flag F3 |
| X5 | Consistency | b_crit in chapter box = Solutions Ex 3 annotation = 01e Fig. `deflection_comparison` caption "(3√3/2) R_S" | ✅ PASS | internal: 3 occurrences agree | none |
| X6 | Consistency | every `\ref`/`\eqref` added in scope (Ch. refs to ch:linearized_gravity, ch:power_law_point_mass, ch:multiplane_dspl, ch:odd_images, ch:fermat_time_delays, ch:light_deflection; sec:soldner, fig:deflection_comparison, eq:fermat_principle …) | ✅ PASS | repo-grep: each label defined exactly once; chapter titles match the described content (Power-Law Lenses with a Central Point Mass; Multi-Plane … DSPL; Odd Images, Central Images …; Fermat's Principle and Time Delays) | none |
| X7 | Consistency | Annotation in Mercury section: "rounding the per-orbit value to 0.1034″ gives 42.9″" | ⚠ SUSPECT (wording) | 0.10355 rounds to 0.1036, not 0.1034 (D5b) | "the Solutions' 0.1034″ (a slip; four significant figures give 0.1036″) would give 42.9″" |
| P1 | Prose | "Killing vectors are a shortcut, not a necessity:" | ⚠ SUSPECT (antithesis) | read | "The conservation laws also follow directly from the t and φ components of the geodesic equation." |
| P2 | Prose | "it is coordinate-dependent bookkeeping of a coordinate-independent total." | ⚠ SUSPECT (chiasmus) | read | "The split depends on the coordinates; the total deflection does not." |
| P3 | Prose | Bridge closer: "The strong-field results of this chapter tell you what that model may safely ignore." | ⚠ SUSPECT (aphoristic closer) | read | delete, or "The photon sphere and ISCO therefore never enter the compound-lens model." |
| P4 | Prose | box title "What ``c → ∞'' really means" | ⚠ SUSPECT (intensifier, minor) | read | "What ``c → ∞'' means" |

Derivation rows D1–D5 are in the Derivation section below.

## Applied (auto-fixes)

None. Every number in the annotation layer passed; the discrepancies found are all in visible text
(out of bounds for edits) or are wording (prose, flag-only).

## Flagged: your hand required

Visible-text adjudications (author flags 1–3). Visible text NOT edited.

- **F1 (author flag 1): two normalisations of E. Author is RIGHT; the visible text is internally inconsistent.**
  Critic F1a–F1f (scratch .wl): with the normalisation g_μν u^μ u^ν = −εc²,
  - E ≡ f c dt/dλ gives exactly 𝓔 = ½(E² − εc²) with the printed V_eff (F1a PASS), but then
    dφ/dr = (L/r²)[E² − (L²/r²)f]^(-1/2) and b = L/E (F1d, F1e);
  - E ≡ f c² dt/dλ (Congdon & Keeton eq. 3.76a) reproduces the printed eq. `photon_orbit` with E²/c² and
    b = cL/E (F1c, F1e), and then 𝓔 = ½(E²/c² − εc²) (F1f PASS).
  - Eqs. `conserved_E` (E = f dt/dλ) and `normalization` (RHS −ε, no c² on the dt² term) are c = 1 forms,
    while eq. `effective_potential` and 𝓔 = ½(E² − εc²) carry explicit c.
  **Proposed visible fix (option A, recommended because it matches the cited C&K 3.76a/3.78/3.87):**
  eq. `conserved_E` → E = (1 − R_S/r) c² dt/dλ; eq. `normalization` → −(1 − R_S/r)c²(dt/dλ)² + … = −εc²;
  text after eq. `effective_potential` → 𝓔 = ½(E²/c² − εc²). Eq. `photon_orbit` and b = cL/E then stand
  unchanged. (Option B: keep E = f c dt/dλ and change eq. `photon_orbit` to E² and b = L/E.) Whichever is
  chosen, the units annotation and the first two derivation boxes (which currently adopt E = f c dt/dλ)
  must be rewritten to match.
- **F2 (author flag 2): Mercury arithmetic in 01d_Solutions Ex 4. Author is RIGHT.**
  Computed with the Solutions' own inputs (G = 6.674e−11, M☉ = 1.989e30, c = 2.998e8, a = 5.79e10, e = 0.2056,
  T = 87.97 d): Δφ = 5.0204×10⁻⁷ rad/orbit = 0.10355″/orbit; N = 36525/87.97 = 415.198; 42.995″/century.
  Visible Step 1 "5.01×10⁻⁷" should be **5.02×10⁻⁷** (it also disagrees with the chapter's eq., 5.02×10⁻⁷);
  Step 2 "0.1034″" should be **0.1036″** (with 5.01e−7 the conversion gives 0.10334″, so 0.1034 inherits the
  Step-1 slip); Step 4 "0.1034 × 415.2 = 43.0" is arithmetically **42.93**; with 0.1036 it is 43.01 → 43.0
  and the boxed 43.0 stands. Also reword the annotation sentence in X7.
- **F3 (author flag 3): Ex 5(b) "small angle". Author is RIGHT.**
  For L = 4GM/c and 𝓔 slightly above V_eff(r₊ = 12), the apsidal advance is 2π(1/√(1 − 6/r_c) − 1) =
  2π(√2 − 1) = **2.603 rad ≈ 149° per radial period** (critic D3a, analytic); a direct integration of the orbit
  equation with 𝓔 = V(12) + 5×10⁻⁴ gives **2.619 rad** (D3b). Proposed fix: "The perihelion advances by a large
  angle each orbit (≈ 2.6 rad ≈ 149° for near-circular orbits at r ≈ 12GM/c²), producing a strongly precessing
  rosette; only for r ≫ 6GM/c² does the advance become small, → 6πGM/(c²r) (the Mercury regime)."
  The annotation-layer derivation box already gives this; once the visible text is fixed the box's
  "The 'small angle' of the qualitative answer is a statement about the weak-field regime" sentence should be
  dropped.
- **C1:** Kerr ISCO closed form is correct (independently re-derived numerically) but unattributed; add a
  plain-text "(Bardeen, Press & Teukolsky 1972)" if desired (DOI 10.1086/151796 confirmed). No bib key added.
- **X7 / P1–P4:** wording only, see table.

## Prose (LLM tells): flag-only

Added text: chapter 2593 words, Solutions 705 words. Em-dashes (`---`): 0 and 0. Antithesis: 2 (P1, and
"r ≫ R_S, not c → ∞", which carries physics and should stay). Chiasmus: 1 (P2). Aphoristic closer: 1 (P3).
Intensifiers: "really" (P4), "exactly" ×1 (physically meaningful). The layer reads clean overall; the
derivation boxes are plain step-by-step algebra. Provenance: the whole layer is model-drafted (commit 8b10a1e
carries a Claude co-author line); per repo policy the author rewrites any sentence he wants as his own.

## Derivation checks

Scratch script (not in repo):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_01de/critic_01de.wl`
(log `critic_01de.log` alongside), run via `bash Mathematica/run_wl.sh`:

    SUMMARY: 50 PASS, 0 FAIL  (of 50 checks)

(the script covers both 01d and 01e; 01d-relevant groups are F1, D1–D5, D9c–d, D10)

| id | equation re-derived | result |
|----|---------------------|--------|
| D1 | Radial equation and V_eff from the normalisation, with c (box "From the normalisation condition…"); Γ^r_tt, Γ^r_rr, Γ^r_φφ, Γ^t_tr from the metric; r-geodesic RHS ≡ −V_eff' | PASS (F1a, D1a–D1c) |
| D2 | Circular orbits r±, V''(r±) sign, ISCO r = 6GM/c², L² = 12, efficiency 5.7%; photon sphere r = 3GM/c², barrier L²/54, b_crit = 3√3 GM/c² | PASS (D2a–D2h, incl. numeric capture test) |
| D3 | Ex 5(b) quantitative box: κ²/Ω² = 1 − 6/r_c; advance 2π(√2 − 1); weak-field limit 6π/r_c | PASS (D3a–D3c; numeric orbit 2.619 rad) |
| D4 | Perturbative precession x₁ (incl. resonant φ sin φ term) and photon u₁ = R_S(1 + cos²φ)/(2b²) ⇒ α̂ = 2R_S/b; exact deflection at b = 100 R_S | PASS (D4a–D4e) |
| D5 | Mercury numbers | PASS (D5a–D5d) |
| D10 | Kerr ISCO closed form vs independent equatorial Carter potential R = R' = R'' = 0 | PASS (D10a, D10b) |

Repo script run (worktree `wt/ann01de`):
`bash Mathematica/run_wl.sh Solutions/01d_Geodesics_Orbits/problems_01d.wl` →

    SUMMARY: 73 PASS, 0 FAIL  (of 73 checks)

Report path: `Notes/01d_Geodesics_Orbits/FACT_CRITIC_01d_annotated_2026-10-14.md`
