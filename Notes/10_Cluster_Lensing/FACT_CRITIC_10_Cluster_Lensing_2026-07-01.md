# fact-critic report — Notes/10_Cluster_Lensing/10_Cluster_Lensing.tex

> Date: 2026-07-01 · Lenses: Citation, Number, Consistency
> Active adapters this run: bibtex ✗ (no .bib), crossref-web ✓ (on),
> values-file ✗, repo-grep ✓, doc-internal ✓ (arithmetic recomputed),
> overlay ✓ (Zotero reachable). Source texts in ../../Reference_Texts/.
> DEMO pass, 1 of 14 chapters (the heavy convergence/cluster chapter). Proposed
> fixes NOT applied (review only).

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | NFW example M200=1e15, c=5, z_d0.3 → r200≈1.86 Mpc, r_s≈372 kpc, θ_s≈85″, θ_t≈16″ | ✅ PASS | recomputed EXACTLY (r200=1.862, r_s=372 kpc, θ_s=85.4″); ΛCDM h0.7 Ωm0.3 | none |
| N2 | Number | M(θ≤θ_E)=π(D_d θ_E)² Σ_cr; for θ_E=30″ → **M ≈ 2×10¹⁴ M⊙** | ⚠ SUSPECT | recomputed from the chapter's OWN inputs: D_dθ_E=131 kpc (✓ matches), Σ_cr(z_d0.3,z_s2)=2.31×10¹⁵ M⊙/Mpc² → **M = 1.24×10¹⁴** (≈1.6× below the stated value) | verify vs cluster_lensing.wl; likely `≈ 1.3×10¹⁴` (or state the Σ_cr/config that gives 2×10¹⁴) |
| N3 | Number | Earendel z=6.2, μ≳4000 → Δm≈−9 mag | ✅ PASS | Δm=−2.5log₁₀(4000)=−9.01 (recomputed) | none |
| N4 | Number | cluster budget 85% DM / 13% gas / 2% stars; c 3–8 (cl) vs 10–20 (gal); θ_E 10–50″ | ✅ PASS | standard cluster values (doc-internal + established) | none |
| N5 | Number | survey specs: Euclid 2023, 15,000 deg², ~1.5e9 gal; LSST 18,000 deg², first light 2025; Roman ~2027 | ✅ PASS | current facility parameters | none |
| C1 | Citation | AGEL project "Tran et al. (2022)" | ✅ PASS | **CrossRef confirmed:** Tran, K.-V. H. et al. 2022, *AJ* 164(4), 148, "The AGEL Survey…CNNs." NOTE: not in your Zotero — consider adding | none (add to Zotero) |
| C2 | Citation | Welch et al. (2022) Earendel; Kelly et al. (2015) SN Refsdal MACSJ1149 | ✅ PASS | matches published record (Welch 2022 *Nature* Earendel z6.2; Kelly 2015 *Science* Refsdal) | none |
| X1 | Consistency+Citation | Giant-arc discovery: **§1 "first giant arc discovered by Soucail et al. (1987)"** vs **§Giant Arcs "first discovered by Lynds & Petrosian (1986) and Soucail et al. (1987)"** | ❌ FAIL | internal: the two sections disagree on priority; historically Lynds & Petrosian (1986) announced first / simultaneously | reconcile §1 to credit both (Lynds & Petrosian 1986 + Soucail 1987), matching §Giant Arcs |
| C3 | Citation | Bartelmann et al. (1998), arc-statistics excess ~10× vs ΛCDM | ⚠ SUSPECT | Zotero: not found; CrossRef bibliographic search did NOT confirm this run (query noise). Very likely real (Bartelmann, Huss, Colberg, Jenkins & Pearce 1998, A&A 330, 1) but **not machine-verified** | confirm the ref + that "~10×" is what they state; add to Zotero |
| C4 | Citation | review refs: Kneib & Natarajan (2011); Treu (2010); Bartelmann & Schneider (2001); Kilbinger (2015) | ⚠ SUSPECT (existence high-confidence, unverified) | not in Zotero; not machine-verified this run | web/Zotero-confirm the four review years/venues |
| N6 | Number | cluster redshifts: A370 0.375, A1689 0.183, A2744 0.308, AS1063 0.348, MACS0416 0.396, MACS0717 0.545, MACS1149 0.543; A1689 θ_E~47″ | ✅ PASS (high-confidence) | match standard catalog/HFF values | (optional) NED-confirm for page-proof rigor |

## Flagged — your hand required (nothing auto-applied)

- **N2 (mass within θ_E, ⚠ — the load-bearing number):** the stated `≈ 2×10¹⁴ M⊙`
  does not reproduce from the chapter's own D_d θ_E (131 kpc) and Σ_cr for
  z_d=0.3/z_s=2; independent arithmetic gives **1.24×10¹⁴ M⊙**. Either the value
  should be ~1.3×10¹⁴, or a different Σ_cr/redshift config is intended. Check
  `cluster_lensing.wl` — students will recompute this.
- **X1 (giant-arc priority, ❌):** the Introduction credits Soucail et al. 1987
  alone as the first giant-arc discovery; the Giant Arcs section (correctly)
  credits Lynds & Petrosian 1986 as well. Fix the Introduction to match.
- **C3 / C4 (unverified citations, ⚠):** Bartelmann 1998 and the four review
  articles could not be machine-confirmed this run — almost certainly real, but
  flagged rather than vouched. Adding them (and Tran 2022) to your Zotero would
  let the overlay confirm them automatically next time.

## Summary

11 claim-groups: 5 ✅ PASS (NFW example EXACT, Earendel arithmetic, budgets,
survey specs, Tran 2022 CrossRef-confirmed, redshifts), 1 ❌ FAIL (giant-arc
priority inconsistency), 5 ⚠ SUSPECT (mass ≈2e14 doesn't reproduce → ~1.2e14;
Bartelmann 1998 + 4 reviews unverified this run). Highlight: the worked NFW
numbers are exactly right, but the one "quick estimate" headline mass is ~1.6×
high. Every ✅/❌ names a concrete source (recomputed arithmetic or CrossRef DOI) —
none from memory; unverifiable citations were flagged, not passed.
