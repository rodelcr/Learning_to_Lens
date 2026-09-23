# fact-critic report — Notes/13_Microlensing/ (chapter + solutions)

> Date: 2026-09-23 · Lenses: Citation, Number, Consistency, Prose
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓, browser
> (Chrome) ✓ for publisher pages (Science 1936 letter paywalled, so metadata only),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓, overlay: Zotero (source-book PDF
> `NNNRZT8L`/`DXHVNN2Y`, Part 4 by J. Wambsganss extracted via `pdftotext`) + Mathematica
> (`wolframscript`) + Python (sympy, astropy, numpy contouring).

Scope: `13_Microlensing.tex` (651 lines) and `13_Solutions.tex` (191 lines). First full
per-chapter pass.

**Engine checks:** `microlensing.wl` 17/17 PASS; `problems_13.wl` 20/20 PASS. The scripts
re-export figures as a side effect; those PDFs were reverted.

**Headline:** all cited Part 4 equation numbers are exact (eqs. 1, 3, 4, 8, 14, 22, 25) and
all section pointers are correct (§§1, 1.2, 1.4, 2.1, 3.5, 3.6, 4.1, 6, 7, 7.1, 7.3). Defects:
**binary-caustic transitions quoted in the wrong units** (inherited from the book), a
**misquoted Einstein epigraph**, a **wrong D_ds** in Solution 13.6(a), **mutually
inconsistent quasar timescales** (text vs solution vs r_E/v), plus several range and
attribution tweaks. 0 auto-fixes.

## Verdicts

### Citations

| id | quoted | verdict | source checked | proposed fix |
|----|--------|---------|----------------|--------------|
| C1 | Epigraph: "Of course, there is no great chance of observing this phenomenon directly." — Einstein (1936) | ❌ FAIL (misquotation) | The book quotes Einstein twice, differently: §1.1 p.454 "of course, there is not much hope of observing this phenomenon directly"; footnote 7 p.477 "no hope of observing such a phenomenon directly". Neither says "no great chance". The original (Science 84, 506, DOI 10.1126/science.84.2188.506, confirmed in browser) is paywalled, so the exact original wording is **not verified**. | Use the §1.1 wording, attributed "A. Einstein (1936), as quoted by Wambsganss (2006)". Add `einstein_1936` to the `.bib` + Zotero. |
| C2 | eq. 1 (u = y − 1/y) | ✅ PASS | book p.455 eq. (1) (book uses y for source, x for image; chapter swaps to u, y, and the book's footnote 3 notes u is common) | none |
| C3 | eq. 3 (μ±) | ✅ PASS | p.455 eq. (3) | none |
| C4 | eq. 4 (A(u)) | ✅ PASS | p.455 eq. (4) | none |
| C5 | Sect. 1.2: A(1)=1.34, 87% from + image; t_E the only physical parameter, degenerate | ✅ PASS | p.456–457 | none |
| C6 | eq. 8 (u(t)) | ✅ PASS | p.457 eq. (8) | none |
| C7 | Sect. 1.4 / Paczyński 1986: τ integral; τ₀ ≈ 5×10⁻⁷ | ✅ PASS | p.460–461 eqs. (10), (11); `.bib` paczynski_1986 (ApJ 304, 1 = the book's "1986b") | none |
| C8 | eq. 14 (binary deflection) | ✅ PASS | p.461 eq. (14) | none |
| C9 | Sect. 3.5: τ_LMC = 1.2 (+0.4, −0.3) ×10⁻⁷ (MACHO) | ✅ PASS | p.479 (Alcock et al. 2000b; plus a 20% systematic) | optional: "(MACHO; plus ~20% systematic)" |
| C10 | "MACHOs in the mass range ∼10⁻⁷ to 1 M☉ contribute less than about 25%" | ⚠ SUSPECT (attribution/precision) | p.481–482: this is **EROS** (Afonso et al. 2003a), mass range **2×10⁻⁷–1 M☉** | "EROS limits objects of 2×10⁻⁷–1 M☉ to < 25% of the halo" |
| C11 | "decisively ruled out baryonic compact objects as the dominant dark matter" | ⚠ SUSPECT (overstated) | p.478: events are "far too small to explain ALL the dark matter", with estimates "from about 20% to zero". The limits hold only in the probed mass ranges (EROS 2×10⁻⁷–1; MACHO 0.3–30 M☉ cannot make up the entire halo). | "ruled out compact objects of ~10⁻⁷–30 M☉ as the dominant component of the halo" |
| C12 | Sect. 3.6: τ_bulge ≈ (0.9–3)×10⁻⁶ | ⚠ SUSPECT (range) | p.484–485: MACHO/OGLE ≈ 3–4×10⁻⁶; EROS (0.94±0.29)×10⁻⁶ | "(0.9–4)×10⁻⁶" |
| C13 | Sect. 2.1 + Petters 2001 for the caustic topology | ✅ PASS (section) / see N1 | p.462–464 (after Schneider & Weiss 1986) | Also cite Schneider & Weiss (1986), the original source (optional). |
| C14 | Mao & Paczyński 1991: ~10% of events show binary signatures | ✅ PASS | p.465 and p.486; `.bib` mao_paczynski_1991 | none |
| C15 | Sect. 4.1: lensing zone 0.6–1.6; ~1 AU "overlapping the habitable zone"; deviations few %, hours to a day | ✅ PASS | p.486–487 | none |
| C16 | "cool, low-mass planets at ∼1–10 AU" | ⚠ SUSPECT | the book gives "of order 1 AU" (p.487), not 1–10 AU | "at ∼1–few AU" |
| C17 | eq. 22 (δ_max = 8^{−1/2}θ_E at u=√2), Paczyński 1998 | ✅ PASS | p.516 eq. (22); `.bib` paczynski_1998 | none |
| C18 | eq. 25 (M = 0.123 M☉ θ_E²/π_ds) | ✅ PASS | p.517 eq. (25); `problems_13.wl` coefficient 0.1228 | none |
| C19 | Sect. 7 / 7.1: κ∼1; r_E ≈ 4×10¹⁶ cm; t_E ≈ 15 yr; t_cross ≈ 4 months | ✅ citation exact / ❌ see N3 | p.521–522 (the chapter matches the book) | see N3 |
| C20 | Sect. 7.3: Q2237 "vary independently by up to ∼1 mag"; continuum ~10¹⁴ cm | ⚠ SUSPECT (range) | p.527: Δm_A≈0.6, Δm_B≈0.4, **Δm_C≈1.3**, Δm_D≈0.6 mag; 10¹⁴ cm ✓ | "by up to ∼1.3 mag" |

### Numbers / physics

| id | quoted | verdict | source checked | proposed fix |
|----|--------|---------|----------------|--------------|
| **N1** | "d in units of θ_E of the total mass … near d≈1 these merge through an intermediate six-cusp caustic; at d = 8^{−1/2} ≈ 0.354 the caustic splits into a central four-cusp plus two triangular caustics" | ❌ FAIL (wrong units) | Python critical-curve count for q=1 (d = full separation, total-mass θ_E): **2 curves (wide) for d ≥ 2.05, 1 curve (intermediate) for 0.72 ≤ d ≤ 1.95, 3 curves (close) for d ≤ 0.69**, so the transitions are at **d = 2 and d = 2^{−1/2} ≈ 0.707**. The book's values 1.0 and 8^{−1/2} are from Schneider & Weiss (1986) Fig. 2, which measure the *half*-separation. The book mixes this with its own full-separation definition of d, and the chapter inherits the mix-up. | "wide (d > 2): two four-cusp caustics; 2^{−1/2} < d < 2: one six-cusp caustic; d < 2^{−1/2} ≈ 0.707: a central four-cusp plus two triangular caustics (equal masses; Schneider & Weiss's half-separation values are 1 and 8^{−1/2})". Also "asteroid-shaped" → "astroid-shaped" (four-cusp). Add a Mathematica test. |
| **N2** | Sol. 13.6(a): D_ds ≈ 1550 Mpc (with D_d ≈ 1250, D_s ≈ 1750) → r_E ≈ 6×10¹⁶ cm | ❌ FAIL | astropy, the book's concordance cosmology (Ω_m=0.3, Ω_Λ=0.7, H₀=70; Module 3): D_d=1259, D_s=1727, **D_ds=1097 Mpc** → **r_E = 5.2×10¹⁶ cm**. `problems_13.wl` hardcodes 1550 (its check passes only because the bound is loose, 1–9×10¹⁶). This is the same stale-distance failure mode as the 2026-07 ch07/ch10 fixes. | D_ds → 1100 Mpc, r_E → 5×10¹⁶ cm; compute the distances in the `.wl` rather than hardcoding them. |
| **N3** | Quasar timescales: text t_E ≈ 15 yr and t_cross ≈ 4 R₁₅ months (both from the book); Solution 13.6(c) t_cross ≈ 6 months and t_E ∼ 15 yr | ❌ FAIL (internal inconsistency) | r_E/v: 4×10¹⁶ cm / 600 km s⁻¹ = **21 yr** (5.2×10¹⁶ → **28 yr**); 10¹⁵ cm / 600 km s⁻¹ = **6.3 months** (`problems_13.wl` also gets 6.34). The book's two values agree with *each other* (their ratio is r_E/R) but not with r_E/v, so they imply an undefined effective velocity ~1.5× larger. The chapter and its solution disagree (4 vs 6 months). | State the directly computed values, t_E = r_E/v ≈ 28 (M/M☉)^{1/2} v₆₀₀⁻¹ yr and t_cross = R/v ≈ 6 R₁₅ v₆₀₀⁻¹ months, with a footnote that Wambsganss quotes 15 yr / 4 months for a differently defined effective velocity. Also r_E ≈ 5×10¹⁶ (concordance; the book's 4×10¹⁶ matches older EdS-type cosmologies: EdS H₀=70 gives 3.8×10¹⁶). |
| N4 | "t_cross = R_source/v_⊥ … to cross its own diameter" (text l.360; also book p.522) | ⚠ SUSPECT | R is a radius, so R/v is the time to cross its own radius | "…to cross its own radius" (or use 2R for the diameter) |
| N5 | Galactic example: θ_E≈0.55 mas, R_E≈2.2 AU, t_E≈19 d | ✅ PASS | `problems_13.wl`: 0.553 mas, 2.21 AU, 19.1 d | none |
| N6 | A(1)=3/√5≈1.34, Δm≈0.32, 87% from + image; dA/du; symmetry; A→1/u, →1 | ✅ PASS | `microlensing.wl`; book p.456 | none |
| N7 | δ(u) = u/(u²+2) θ_E | ✅ PASS | sympy: flux-weighted image centroid minus source = u/(u²+2) exactly | none |
| N8 | "the centroid traces an ellipse" | ✅ PASS | numpy: the track for u₀=0.3 and 1.0 satisfies a conic exactly (smallest singular value 10⁻¹⁶), discriminant < 0, so an ellipse | none |
| N9 | Sol. 13.4: u₀(A=5)=0.203; A(0.05)=20.02 (0.1%) | ✅ PASS | `problems_13.wl` | none |
| N10 | Sol. 13.3(d): LMC τ 4–5× below full-halo prediction | ✅ PASS | 5×10⁻⁷/1.2×10⁻⁷ = 4.2 | none |
| N11 | Sol. 13.2(c) "t_E ∝ √M D_d^{1/2}… doubling nothing but the mass scales t_E → √M: t_E(4M)/t_E(M)=2" | ⚠ SUSPECT (garbled) | the math is right (`.wl` 13.2(c)); the prose is muddled ("doubling … 4M") | "At fixed D_d, D_s, v_⊥, t_E ∝ √M, so quadrupling M doubles t_E." |
| N12 | l.86–88: "milliarcsecond — hence 'micro' relative to the arcsecond image splittings" | ⚠ SUSPECT (etymology unsourced) | not in the book; the book gives θ_E ~10⁻⁶″ for *quasar* microlensing (p.522) | drop the etymology: "(a milliarcsecond, far below the arcsecond splittings of galaxy lensing)" |

### Consistency

| id | item | verdict | evidence |
|----|------|---------|----------|
| X1 | t_cross: text "≈4 months" vs Sol. 13.6(c) "≈6 months" | ❌ FAIL | see N3 |
| X2 | r_E: text 4×10¹⁶ vs Sol. 13.6(a) 6×10¹⁶ (called "consistent") | ❌ FAIL | see N2, N3 |
| X3 | τ_LMC, τ₀, A(1), δ_max, lensing zone across text/summary/exercises | ✅ PASS | internal agreement |

## Applied (auto-fixes)

None (policy: citations and book-inherited values are flag-only; N2/N3 have more than one
candidate source).

## Prose (LLM tells) — flag-only

Em-dashes: chapter ~24 in ~3 900 words (≈1/160, borderline). Intensifiers: "spectacularly
wrong" (l.22), "utterly unresolvable" (l.23), "The consequence is decisive" (l.92),
"Paczyński's motivation was profound" (l.294), "Remarkably" (l.285), "dramatic" (l.354),
"By a fortunate coincidence" (l.375; the book just says "coincidence"), "uniquely sensitive"
(l.380), "landmark null result … decisively" (l.311–312), "The great power" (l.471).
Plain rewrites: "wrong for ours"; "unresolvable"; "As a result"; "Paczyński's motivation was
…"; drop "Remarkably"; "The observational signature is a sharp spike"; "By coincidence";
"especially sensitive"; "an important null result"; "The value of quasar microlensing".

---

## Resolution — fixes applied 2026-09-23 (continuing the approval for Modules 11–12)

| id | Fix | Backing |
|----|-----|---------|
| N1 | Binary caustics: transitions now d = 2 and d = 2^{−1/2} (equal masses, full separation, total-mass θ_E), plus a footnote explaining the book's half-separation values 1 and 8^{−1/2}. "asteroid" → "astroid". | `microlensing.wl` **3 new tests**. Exact derivation: \|f(iy)\| = \|a²−y²\|/(a²+y²)². The wide transition is \|f(0)\|=1 ⇒ a=1. The close transition is max_y\|f\| = 1/(8a²) = 1 ⇒ a = 8^{−1/2}, attained at y=√3 a. With d = 2a this gives d = 2 and 2^{−1/2}, and it independently confirms the Python critical-curve count. |
| C1 | Epigraph now the book's §1.1 wording, attributed "as quoted by J. Wambsganss in Schneider et al. (2006), Part 4". `\citep{einstein_1936}` added in the opening sentence. | book p.454. **Zotero TBJBX6QT** (already present; tagged `learning_to_lens`). Science metadata read in browser. The original wording remains unverified (paywall), which the `.bib` comment records. |
| N2 | Sol. 13.6(a): D_ds 1550 → 1100 Mpc (with a note that D_ds ≠ D_s − D_d); r_E 6 → 5×10¹⁶ cm | `problems_13.wl` now **computes** D_d, D_s, D_ds (concordance, NIntegrate) instead of hardcoding them: 1259/1727/1097 Mpc, matching astropy's 1097.08. The r_E check is tightened to 4.9–5.5×10¹⁶. |
| N3/X1/X2 | Quasar scales: r_E ≈ 5×10¹⁶ cm (formula shown), t_E = r_E/v ≈ 28 yr, t_cross ≈ 6 R₁₅ months; v defined as the source-plane transverse velocity. Footnote records the book's 4×10¹⁶ cm / 15 yr / 4 months and why they differ. The solution now matches the text. | `problems_13.wl` new checks: t_E = 27.7 yr, t_cross = 6.34 months. astropy: EdS H₀=70 gives r_E = 3.8×10¹⁶ (the book's value). |
| N4 | "cross its own diameter" → "move by its own radius" (R_source is a radius) | — |
| C10/C11 | LMC paragraph: EROS 2×10⁻⁷–1 M☉ < 25%; MACHO 0.3–30 M☉; "rules out compact objects of ~10⁻⁷–30 M☉ as the dominant component". The summary bullet and Sol. 13.3(d) are aligned with it. | book pp.478–482 |
| C9 | MACHO τ now carries "~20% systematic" | book p.479 |
| C12 | bulge τ range → (0.9–4)×10⁻⁶ (EROS to MACHO/OGLE) | book pp.484–485 |
| C13 | Caustic topology now cites `schneider_weiss_1986` (original) + Petters 2001 + book §2.1 | new `.bib` entry; ADS abstract read in browser; **Zotero 5CZJQR7X** |
| C16 | planets "∼1–10 AU" → "∼1–few AU" | book p.487 |
| C20 | Q2237 "up to ∼1 mag" → "∼1.3 mag" | book p.527 |
| N11 | Sol. 13.2(c) prose un-garbled | — |
| N12 | Unsourced "micro" etymology removed | — |
| Prose | "spectacularly", "utterly", "decisive", "Remarkably", "profound", "dramatic", "fortunate", "uniquely", "landmark … decisively", "great power" removed or made plain | — |

**Verification after edits:** `microlensing.wl` **20/20** (was 17/17); `problems_13.wl` **22/22**
(was 20/20). Build: student 249 pp, instructor 305 pp (unchanged); 0 LaTeX errors; new refs
render ([10] Einstein 1936, [21] Schneider & Weiss 1986). The 5 remaining "??" are the known
Module 6 refs.

### Addendum 2026-09-23 — C1 resolved against the primary source

A public scan of the original *Science* 84, 506 (4 Dec 1936) was retrieved from the Wayback
Machine (snapshot 20201109042521 of the INFN-hosted copy linked from Semantic Scholar and
Wikipedia; the live server is down). It reads verbatim: **"Of course, there is no hope of
observing this phenomenon directly."** The epigraph now quotes that sentence, cited to Science
84, 506. The interim "not much hope" wording taken from the book's §1.1 was also wrong: the
book quotes Einstein two ways, and only its footnote 7 (p.477) matches the original. The same
wording is quoted in Cervantes-Cota, Galindo-Uribarri & Smoot (2019, arXiv:1912.07674). A local
copy of the scan is in the git-ignored `Reference_Texts/`. **C1: ✅ PASS (primary source).**
