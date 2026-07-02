# fact-critic report — Notes/02_Light_Deflection/02_Light_Deflection.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib in repo), crossref-web ✓ (on),
> md-reflist ✗ (chapter cites in prose, no per-chapter list), values-file ✗,
> repo-grep ✓, doc-internal ✓ (arithmetic recomputed), overlay ✓ (Zotero reachable).
> Reference source texts present in `../../Reference_Texts/` (Congdon & Keeton 2018,
> Carroll, Narayan & Bartelmann 1997) — used for existence, not page-level yet.
> NOTE: 1 of 14 chapters. UPDATE 2026-07-01: the two safe number fixes (N5, X1)
> were APPLIED to the .tex (see Applied section); citation/attribution items remain
> flagged for the author.

## Applied (auto-fixes, 2026-07-01)

- **X1** — l.473: Newtonian solar deflection `$0.87''$` → `$0.875''$` (now
  consistent with the Problems section, l.666; = exact half of 1.75″).
- **N5** — l.483: Jupiter grazing deflection `0.017'' = 17~mas` → `0.016'' = 16~mas`
  (recomputed 16.3 mas from the chapter's own M_J, R_J).

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | G = 6.674e-11, M⊙=1.989e30, c=2.998e8, R⊙=6.957e8 | ✅ PASS | CODATA/IAU nominal constants; recomputed | none |
| N2 | Number | solar deflection α⊙ = 8.49e-6 rad = 1.75″ | ✅ PASS | recomputed 1.7515″ (doc-internal arithmetic) | none |
| N3 | Number | galaxy 1e12 M⊙ @ 10 kpc → α ≈ 3.9″ | ✅ PASS | recomputed 3.944″ | none |
| N4 | Number | 2nd-order coeff 15π/4; b_crit = 3√3 R_S/2; err ~15% @10R_S, 1% @~150R_S | ✅ PASS | recomputed (0.147, 147) + standard Schwarzschild result | none |
| N5 | Number | Jupiter grazing α_J ≈ 0.017″ = 17 mas | ❌ FAIL | recomputed from the chapter's OWN constants (M_J=1.898e27, R_J=7.149e7) → 0.0163″ = 16.3 mas | 0.016″ = 16 mas |
| X1 | Consistency | Newtonian solar deflection: "0.87″" (§Deflection by Sun, l.473) vs "0.875″" (Problems, l.667) | ❌ FAIL | internal: 2 occurrences disagree; correct half of 1.75″ = 0.8758″ | standardize on 0.875″ |
| C1 | Citation | second-order deflection "(see, e.g., Keeton & Petters 2006)" | ⚠ SUSPECT | Zotero: not in library; CrossRef: the 15π/4 series is Part I = **2005** (PRD 72,104006); Part II (post-PN) = 2006 (PRD 73,044024) | cite 2005 for the formula, or specify Part II 2006 if intended |
| C2 | Citation | Soldner (1801); Eddington (1919); Shapiro (1964); Einstein 1915 / 1919 quote | ✅ PASS | historical record: Soldner 1801 Newtonian deflection, Eddington 1919 eclipse, Shapiro 1964 PRL delay, Einstein 1919 *Times* quote — all correct | none |
| C3 | Citation | ~15× "Congdon & Keeton eq. 3.87–3.110" | ⚠ SUSPECT (existence ✅, page-precision unconfirmed) | Zotero HAHYK7MR + PDF in Reference_Texts confirm the BOOK; exact eq numbers NOT verified against the PDF this pass | verify eq numbers vs the PDF (offer below) |
| X2 | Consistency | Shapiro delay "≈ 240 μs" (ex, l.444) vs "200 ± 20 μs" (Shapiro 1964, l.721) | ⚠ SUSPECT | likely different setups (grazing-Sun→Mercury vs Haystack 1964); not necessarily a contradiction | author confirm the two scenarios differ, else reconcile |

## Flagged — your hand required (nothing auto-applied)

- **N5 (Jupiter, ❌):** the chapter states `α_J ≈ 0.017″ = 17 mas` as a computed
  equality, but plugging its own quoted M_J, R_J gives **16.3 mas**. Either the
  value should read `0.016″ ≈ 16 mas`, or the inputs differ from what's printed.
  (Textbook numbers students will recompute — worth fixing.)
- **X1 (0.87″ vs 0.875″, ❌):** same quantity printed two ways; 0.875″ is the exact
  half of 1.75″. Standardize.
- **C1 (Keeton & Petters year, ⚠):** the 15π/4 second-order deflection is Part I
  (2005). If you meant the post-post-Newtonian treatment, that's Part II (2006) —
  either is defensible, but pin the one you cite. Not in Zotero — consider adding.
- **C3 (Congdon & Keeton eq. numbers, ⚠):** the source book is verified real and is
  the correct reference; the ~15 specific equation-number citations (3.87–3.110)
  were NOT checked against the actual PDF pages this pass. I can verify them with
  `zotero_read_pdf_pages` on Reference_Texts if you want page-level confidence.

## Summary

10 claim-groups checked: 4 ✅ PASS (constants, solar/galaxy deflection, Schwarzschild
higher-order), 2 ❌ FAIL (Jupiter 17→16 mas; 0.87″/0.875″ inconsistency), 3 ⚠ SUSPECT
(Keeton & Petters year; Congdon & Keeton eq-precision unverified; Shapiro 240 vs 200 μs).
Nothing auto-applied. Every ✅/❌ names a concrete source (recomputed arithmetic,
CODATA/IAU constants, CrossRef DOI, or Zotero item) — none from memory.
