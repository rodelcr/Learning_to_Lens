# fact-critic report — Notes/13_Microlensing/13_Solutions.tex (Annotated Study Edition layer)

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation (+ Provenance summary)
> Scope: boxes added in commit 0214efd in `13_Solutions.tex` + appended checks of
> `Solutions/13_Microlensing/problems_13.wl`; plus author flag (1) on visible 13.1(b).
> Active adapters this run: bibtex ✓, crossref-web — not exercised (no `\cite` in the layer),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓, overlay AGEL/Zotero: SKW 2006 PDF
> (NNNRZT8L; Part 4 read with `pdftotext -layout -f 467 -l 468`) ✓, derivation adapter wolframscript ✓.
> Critic script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_1013/critic_1013.wl`
> → `SUMMARY: 44 PASS, 0 FAIL (of 44)`.

Repo script: `bash Mathematica/run_wl.sh Solutions/13_Microlensing/problems_13.wl` →
`SUMMARY: 34 PASS, 0 FAIL  (of 34 checks)` / `ALL CHECKS PASS`.

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| D1 | Derivation | Vieta route: "μ_± = ±y_±²/(u√(u²+4))", "y₊²+y₋² = u²+2", "μ₊+μ₋ = 1", "μ₊ = (A+1)/2 > 0, μ₋ = −(A−1)/2 < 0" | ✅ PASS | critic F1 (independent, from μ = 1/(1−y⁻⁴)); repo checks "13.1(b) …" PASS | none |
| X1 | Consistency | derivation closing clause: "the bracket formula above is \|μ_±\| = ½(A ± 1)" | ⚠ SUSPECT | true as a statement about absolute values, but it silently reinterprets the visible formula, which the visible text calls signed ("so μ₊ > 0, μ₋ < 0"). This becomes stale once VF1 is fixed | after the VF1 fix: "the bracket formula above, with its leading ±, is the signed form" |
| N1 | Number | 13.1(d): "3/√5 = 1.3416; log₁₀ = 0.1277; 0.319 mag" | ✅ PASS | critic L9b; repo check PASS | none |
| N2 | Number | 13.2(a): "4GM/c² = 1772 m; 2.469e20 m; θ_E² = 7.18e-18; θ_E = 2.68e-9 rad = 0.553 mas; R_E = 3.31e11 m = 2.21 AU; t_E = 1.65e6 s = 19.1 d" | ✅ PASS | critic L8b (0.553 mas, 2.21 AU, 19.1 d); repo checks PASS | none |
| N3 | Number | "κ ≡ 4GM☉/(c²AU) = 8.14 mas M☉⁻¹", "1/κ = 0.123", "1 AU/1 kpc = 1 mas", "π_ds = 0.125 mas", "√(8.14×0.3×0.125) = 0.553" | ✅ PASS | critic L8: κ = 8.1459 mas/M☉; 1/κ = 0.1228; consistent with 13_Microlensing.tex:433, 651 and 13_Solutions.tex:252–253 (0.123) | none |
| D2 | Derivation | parallax form: "D_ds = D_s − D_d ⇒ D_ds/(D_dD_s) = 1/D_d − 1/D_s" | ✅ PASS | repo checks "13.2 Euclidean…", "13.2 thetaE^2 = …" PASS | none |
| X2 | Consistency | annotation "Three Einstein radii … differ by D_s/D_d: a factor of 2 for this Bulge event" | ✅ PASS | exercise distances D_d = 4, D_s = 8 kpc; repo check "13.2 Ds/Dd = 2" PASS | none |
| D3 | Derivation | annotation: "Γ = n_ang 2θ_E μ_rel = (2/π)τ/t_E"; "τ independent of M"; "Γ ∝ M^{−1/2}" | ✅ PASS | critic L12/L12b (independent) | none |
| D4 | Derivation | 13.4(a): "u₀² = 2(A/√(A²−1) − 1); A = 5: 5/√24 = 1.0206, u₀² = 0.0412, u₀ = 0.203" | ✅ PASS | critic L9b (FindRoot u₀ = 0.203); repo check PASS | none |
| D5 | Derivation | 13.4(b): "A(u) = 1/u + 3u/8 + O(u³)", "A(0.05) = 20.0187, 0.094%" | ✅ PASS | critic L9, L9b | none |
| N4 | Number | 13.6: "D_d = 1259, D_s = 1727, D_ds = 1097 Mpc, whereas D_s − D_d = 468 Mpc" | ✅ PASS | critic L10 (own NIntegrate): 1259.08 / 1726.62 / 1097.08 / 467.54 | none |
| N5 | Number | 13.6: "r_E = D_sθ_E = √(4GMD_sD_ds/(c²D_d)) … 5.24e16 cm … lens-plane 3.82e16 cm" | ✅ PASS | critic L11: 5.237e16 / 3.819e16 cm | none |
| N6 | Number | 13.6(c): "10¹³ m/(6e5 m s⁻¹) = 1.67e7 s = 6.3 months" | ✅ PASS | repo check "13.6(c)…" PASS | none |
| X3 | Consistency | bridge: "isolated point mass always gives exactly two images … theorem assumes a smooth mass distribution … caustic a single degenerate point at u = 0" → `ch:odd_images` "central point mass (SMBH) … third, central image" | ✅ PASS | 16_Odd_Images_Central.tex:13 title "Odd Images, Central Images, and Their Suppression"; lines 30, 43, 47 (central black hole; Burke hypothesis violated by point mass) | none |
| X4 | Consistency | cross-refs `ex:micro_astrometric`, `ex:micro_quasar`, `ex:magnification_high_z`, `ch:lensing_statistics`, `eq:point_ymu` | ✅ PASS | labels resolve (13_Microlensing.tex:640, 658; 10_Cluster_Lensing.tex:987; 11_Lensing_Statistics.tex:10, 84) | none |
| VF1 | Number (visible) | 13.1(b): "μ_± = ½[(u²+2)/(u√(u²+4)) ± 1], so μ₊ > 0, μ₋ < 0 … A = μ₊ − μ₋" | ❌ FAIL — author flag CONFIRMED | critic F1: as printed, μ₋ = (A−1)/2 = +0.171 at u = 1; printed μ₊ − μ₋ = 1 ≠ A. Primary source SKW 2006 Pt 4 eq. (3), book p. 455 (PDF p. 467): μ_± = **±**¼[y/√(y²+4) + √(y²+4)/y ± 2] = ±½[A ± 1] | see Flagged |

Counts (layer, 15 items): ✅ 14 · ⚠ 1 · ❌ 0. Visible flag: VF1 ❌ (confirmed).

## Applied (auto-fixes)

None. VF1 is visible text, which is out of scope for edits on this branch.

## Flagged — your hand required

**VF1. Author flag (1), 13.1(b): CONFIRMED, the visible text is wrong. The same error is in the chapter
body.**
- As printed, μ₋ = ½(A − 1) > 0 for every u > 0 (critic F1: +0.1708 at u = 1).
- That contradicts "μ₋ < 0".
- It also makes "A = μ₊ − μ₋" evaluate to 1.
- The signed values are μ₊ = (A+1)/2 and μ₋ = −(A−1)/2 (critic F1, symbolic).
- The cited source, SKW 2006 Part 4 eq. (3), p. 455, carries the leading ±. The book dropped it when
  transcribing.

Exact replacement at **both** places:
- `Notes/13_Microlensing/13_Solutions.tex:27`
- `Notes/13_Microlensing/13_Microlensing.tex:140`, the `eq:micro_mu_pm` equation, which is outside the layer.
  It says "so that μ₊ > 0, μ₋ < 0, and the images obey the sum rule μ₊ + μ₋ = 1", but as printed
  μ₊ + μ₋ = A. It cites `\citep[eq.~3]{schneider_kochanek_wambsganss_2006}`.

```latex
\mu_\pm = \pm\frac{1}{2}\left[\frac{u^2+2}{u\sqrt{u^2+4}} \pm 1\right] \,,
```

With this fix, every following statement holds: μ₊ > 0, μ₋ < 0, μ₊ + μ₋ = 1 and
A = |μ₊| + |μ₋| = μ₊ − μ₋.
Then update the layer's closing clause (X1) from "the bracket formula above is |μ_±| = ½(A ± 1)" to "this
is the bracket formula above, with its leading sign giving the parity".

## Prose (LLM tells): flag-only

800 added words; em-dashes 0; antithesis 0; intensifiers 0. `\emph` appears 6 times, 4 of them in the
"Three Einstein radii" annotation (angular / lens-plane / source-plane / same):
- P1 ⚠ emphasis inflation. Keep at most one `\emph` there.
- P2 ⚠ "lighter MACHOs give more but shorter events" is fine physically. Its "Survey limits therefore
  depend on mass through the rate … even though τ does not" is a mild summary echo; optional to delete.

Otherwise the layer reads clean.

## Provenance (machine-drafted text): flag-only

Commit 0214efd is Claude-co-authored, so all 800 added words are machine-introduced (100% of the layer).
Advisory: the author should rewrite the layer in their own words.

## Derivation checks

Script `critic_1013.wl` → `SUMMARY: 44 PASS, 0 FAIL (of 44)`. Module-13 rows:
- F1 signed μ_±; printed μ₋ > 0; printed μ₊ − μ₋ = 1; ±½[A ± 1] reproduces both: PASS (5 checks; the
  visible text is wrong).
- L8/L8b κ = 8.146 mas/M☉, 1/κ = 0.123; Bulge θ_E = 0.553 mas, R_E = 2.21 AU, t_E = 19.1 d: PASS.
- L9/L9b A = 1/u + 3u/8; A(0.05) = 20.0187; u₀(A=5) = 0.203; 0.319 mag: PASS.
- L10 D_s − D_d = 467.5 Mpc vs D_ds = 1097.1 Mpc: PASS.
- L11 5.237e16 vs 3.819e16 cm: PASS.
- L12/L12b Γ = (2/π)τ/t_E, Γ ∝ M^{−1/2}, τ ∝ M⁰: PASS.

## Resolution — fixes applied 2026-10-14

| id | Fix | Backing |
|----|-----|---------|
| VF1 | Leading ± restored in `eq:micro_mu_pm` (13_Microlensing.tex:140) and in 13.1(b) (13_Solutions.tex:27): μ± = ±½[(u²+2)/(u√(u²+4)) ± 1]. A sentence after the chapter equation records that the sign is in the cited SKW 2006 Pt 4 eq. 3 and that an earlier version dropped it. "μ₊ > 0, μ₋ < 0, μ₊ + μ₋ = 1" and "A = μ₊ − μ₋" now hold as printed. | problems_13.wl "13.1(b) printed mu_pm = … equals signed mu_pm", "13.1(b) old form … is NOT mu- (it is \|mu-\|)", "13.1(b) printed form: mu+ + mu- = 1 and mu+ - mu- = A"; SKW 2006 Pt 4 eq. (3), p. 455 |
| X1 | Derivation closing clause → "this is the bracket formula above, with its leading sign giving the parity." | same checks |

Not changed: P1/P2 prose (flag-only). 04_Solutions.tex:285 writes the bracket as \|μ±\|, which is already correct.

**Verification after edits.** `bash Mathematica/run_wl.sh Solutions/13_Microlensing/problems_13.wl`:
before `SUMMARY: 34 PASS, 0 FAIL  (of 34 checks)`, after `SUMMARY: 37 PASS, 0 FAIL  (of 37 checks)`.
Build: see the module 10 resolution section (one build for 10–13).

**Left open.** None.
