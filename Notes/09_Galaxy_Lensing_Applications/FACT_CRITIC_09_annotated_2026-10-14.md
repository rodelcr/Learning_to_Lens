# fact-critic report — Module 9 Annotated Study Edition layer

Targets: the boxes added in commit `50d755c` (`git diff c588432 50d755c`) in
`Notes/09_Galaxy_Lensing_Applications/09_Galaxy_Lensing_Applications.tex`,
`Notes/09_Galaxy_Lensing_Applications/09_Solutions.tex`, and the appended
annotated-edition checks in `Solutions/09_Galaxy_Lensing_Applications/problems_09.wl`;
also an adjudication of the author's flags on the pre-existing visible text.

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (api.crossref.org +
> Semantic Scholar abstract reachable), md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓,
> run-wl ✓ (`bash Mathematica/run_wl.sh`), overlay none used.
> (A claim whose lens has no active adapter is capped at ⚠ SUSPECT.)
> Critic is independent of the author: every derivation PASS names a `check[]` in the critic's own
> scratch script `critic_0809.wl` (sections E1–E5), not the author's `problems_09.wl`.

## Verdicts

Totals: **✅ PASS 29 · ⚠ SUSPECT 5 · ❌ FAIL 9** (all 9 FAILs, X11–X19, are in pre-existing visible text; the new
layer has 0 FAILs and 3 SUSPECT consistency items, X3, X9 and X10, plus 2 prose items).

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C1 | Citation | "\citet{schneider_sluse_2013} discuss how this degeneracy interacts with the assumption of a power-law profile in H0 inferences" | ✅ PASS | bib:schneider_sluse_2013 / CrossRef DOI 10.1051/0004-6361/201321882 (title "Mass-sheet degeneracy, power-law models and external convergence…", A&A 559, 2013); abstract (Semantic Scholar) supports | none |
| C2 | Citation | "\citet{schneider_sluse_2014} call it an approximate invariance" (SPT) | ✅ PASS | bib:schneider_sluse_2014 / CrossRef DOI 10.1051/0004-6361/201322106, title "Source-position transformation: an approximate invariance…" | none |
| N1 | Number | "Dds/Ds(0.3,1.0) = 0.638, θE = 1.15″, Dd = 919 Mpc, RE = 5.1 kpc, ME = 2.3×10¹¹ M⊙" | ✅ PASS | critic `E5b` (own flat-ΛCDM integrator) | none |
| N2 | Number | "λ = 67.4/73.3 = 0.920, i.e. κs ≈ 0.08" (also in the κ_ext box) | ✅ PASS | critic `E1e` | none |
| N3 | Number | "SIS at θE, λ = 0.9: local slope −0.82 instead of −1" | ✅ PASS | critic `E4g` (−0.818) | none |
| N4 | Number | "f = 0.05, γ' = 2 gives 2.05" | ✅ PASS | critic `E4c` | none |
| N5 | Number | "(1+zd)DdDs/Dds = 4463 Mpc … 1.504×10⁻¹¹ rad² … 80.0 days"; "79.98 d … 69.98" | ✅ PASS | critic `E5a` (4462.7 Mpc, 79.97 d) | none |
| N6 | Number | "naive value overestimates the truth by 1/λ − 1 = 11%" | ✅ PASS | arithmetic 1/0.9 − 1 = 0.111 | none |
| N7 | Number | Ex 9.1 box: "RE = 6.68 kpc … 3.98×10¹¹ M⊙", Σcr 2.83×10⁹ | ✅ PASS | `problems_09.wl` run log (Σcr = 2.834e9, M_E = 3.975e11; E5) | none |
| N8 | Number | "Ds/Dds = 1.566 … σv = 285 km/s … √206265 ≈ 454" | ✅ PASS | `problems_09.wl` log (285.4; E7, E9) | none |
| N9 | Number | Ex 9.3(c) box "0.95 × 69.98 = 66.48; 0.95 × 73 = 69.35" | ✅ PASS | `problems_09.wl` log (66.48); arithmetic | none |
| N10 | Number | Ex 9.4(d) box "σSIS = 255 km/s, ratio 0.90, squared 0.81" (z = 0.3, 1.0 assumed) | ✅ PASS | critic `E5c` (255.3) | none |
| N11 | Number | Ex 9.5 box "5.03 kpc … 0.712 kpc" | ✅ PASS | `problems_09.wl` log (R_E 0.005030, 0.000712 Mpc) | none |
| N12 | Number | "Each 0.01 in κ_ext is a 1% shift" | ✅ PASS | eq. `kappa_ext_H0` (linear) | none |
| X1 | Consistency | layer's H0 sign (H0^true = λH0^naive) vs eq. `mst_H0`, Ex 9.3(c), §TDCOSMO, eq. `kappa_ext_H0` | ✅ PASS | doc-internal (5 occurrences agree); critic `E1a` | none |
| X2 | Consistency | DSPL bridge η' = λη/[1−η(1−λ)] vs Chapter 22 eq. `ms_free` B' = 1/(1−λ2+λ2/B) | ✅ PASS (consistent: mutual inverses) | critic `E3c` (η'(B'(B,λ),λ) ≡ B), `E3d` | see X9 for wording |
| X3 | Consistency | local-MST bridge γ'_eff = γ' + f(3−γ') vs Chapter 21 | ⚠ SUSPECT (sign agrees, size does not) | critic `E4b`; Ch 21 `17_Central_Mass_Bias.tex` table `tab:cb_worked` (dγ'/dm = +15.6 at γ' = 1.6) | F12 |
| X4 | Consistency | "M_E = πθE²Dd²Σcr holds for the SIE without any q correction" (Ch 8 box ↔ Ch 9 box ↔ Ex 9.1) | ✅ PASS | critic `D3b` (∫κ = π for q = 0.5, 0.7, 0.8) | none |
| X5 | Consistency | every `\ref`/`\eqref` in the layer resolves to exactly one `\label` | ✅ PASS | repo-grep (0 missing, 0 duplicate) | none |
| X6 | Consistency | bridge targets `ch:msd_kinematics` (Ch 22), `ch:power_law_point_mass` (Ch 19), `ch:central_mass_bias` (Ch 21), `ch:cosmological_sensitivity` (Ch 24) | ✅ PASS | `Notes/main.toc` l.484, 486, 487, 489 | none |
| X7 | Consistency | Ex 9.4(d) box "The exercise gives no redshifts; the script assumes zd = 0.3, zs = 1.0; it does not invert g(γ')" | ✅ PASS | ch. 9 l.1570–1574 (no z given); `problems_09.wl` l.369 `zd = 0.3, zs = 1.0`; run log prints only the ratio | F11 |
| X8 | Consistency | project-leakage grep on the added lines | ✅ PASS (nil) | repo-grep | none |
| X9 | Consistency | DSPL bridge: "η1 = 1 and η2 = η < 1 … ignoring the mass of the first source"; "the distance ratio is changed from η to η'" | ⚠ SUSPECT (layer) | critic `E3c/d` | F13 |
| X10 | Consistency | layer uses the folded D_Δt (Δt = D_Δt Δτ/c, MST box l.528, Solutions l.231, 263) but the chapter's eq. `time_delay_recap` defines the unfolded D_Δt | ⚠ SUSPECT (layer inherits F10) | doc-internal | resolve with F10 |
| X11 | Consistency | visible remark after eq. `mst_H0`: "a profile that is steeper than assumed) reduces H0^true below H0^naive" | ❌ FAIL (visible) | critic `E2b` | F5 |
| X12 | Consistency | visible "shifts $\Hubble^{\mathrm{naive}}$ downward by 10\%" | ❌ FAIL (visible, wording) | eq. `mst_H0`; critic `E1a` | F6 |
| X13 | Consistency | visible "normalization by matching to the isothermal case" + fragment "…wl.\nand the Einstein radius is:" | ❌ FAIL (visible) | critic `E4e`, `E4f` | F7 |
| X14 | Consistency | visible "$\nabla\cdot(\vectheta/2) = 1 = 1 - \lambda$ up to the overall factor" | ❌ FAIL (visible) | critic `E1c`, `E1d` | F8 |
| X15 | Consistency | visible Ex 9.2(d) "uniform $|\vectheta|^2$ term cancels between the two images" | ❌ FAIL (visible) | critic `E1a`, `E1b` | F9 |
| X16 | Consistency | visible D_Δt named DdDs/Dds (eq. `time_delay_recap`) vs (1+zd)DdDs/Dds (Ex 9.3 hint) | ❌ FAIL (visible, naming; numbers unaffected) | doc-internal; critic `E5a` | F10 |
| X17 | Consistency | visible Ex 9.3(a) "$d$ is a dimensionless function" (d = H0·DdDs/Dds) | ❌ FAIL (visible; NEW) | dimensional analysis; layer box | F10a |
| X18 | Consistency | visible Ex 9.3(c) "the inferred $\Hubble$ scales the opposite way" then H0^true = λH0^naive | ❌ FAIL (visible; NEW) | critic `E1a` | F10b |
| X19 | Consistency | visible Ex 9.4(d) "numerical evaluation … gives γ' ≈ 2.0–2.1" | ❌ FAIL (visible) | `problems_09.wl` l.369 + run log (no γ' computed; z assumed) | F11 |
| D1 | Derivation | τ_λ = λτ + ½λ(λ−1)|β|²; Δt_λ = λΔt; H0^true = λH0^naive | ✅ PASS | critic `E1a`, `E1b`; repo M5, H2 | none |
| D2 | Derivation | uniform sheet κs deflects by κsθ (∇·(κsθ) = 2κs) | ✅ PASS | critic `E1c` | none |
| D3 | Derivation | DSPL: θ − η(λα + (1−λ)θ) = c(θ − η'α); η' − η = η(1−η)(λ−1)/c | ✅ PASS | critic `E3a`, `E3b` | none |
| D4 | Derivation | γ'_eff = γ' + f(3−γ') (exact, matching α and α' at θE) | ✅ PASS | critic `E4a`, `E4b` | none |
| D5 | Derivation | isotropic Jeans σr² = GM(r)/[r(γ'+δ−2)] | ✅ PASS | critic `E4d` | none |
| D6 | Derivation | κ̄(θE) = 1 ⇒ A = (3−γ')/2; projection Beta integral | ✅ PASS | critic `E4e`; repo P1, P10 | none |
| D7 | Derivation | M_E = πσv²RE/G = SIS projected mass within RE | ✅ PASS | critic `E5d`; repo E2 | none |
| D8 | Derivation | SPT Jacobian B·A; the numerical B, A example is asymmetric | ✅ PASS | hand product [[0.45, 0.205],[0.21, −0.275]]; repo S2 | none |
| P1 | Prose | "The source position is not observed, so moving it costs nothing.  This is the whole degeneracy." | ⚠ SUSPECT (aphoristic closer) | read | drop the last sentence |
| P2 | Prose | "Two radii, two constraints, so slope and normalization separate." | ⚠ SUSPECT (verbless aphorism) | read | "Because the two constraints apply at different radii, they separate the slope from the normalization." |

## Applied (auto-fixes)

None. The layer has no number that disagrees with its canonical source, and the brief forbids
visible-text edits.

## Flagged — your hand required

**F5 (author flag 5) — Remark after eq. `mst_H0`, ch. 9 l.558–563. CONFIRMED: wrong sign.**
"…or a profile that is steeper than assumed) reduces H0^true below H0^naive". The critic held
two image positions fixed (θA = 1.3, θB = −0.7) and solved for the power law that reproduces them.
The Fermat-potential difference *increases* with γ': Δτ = 0.479, 0.540, 0.600, 0.660, 0.719 for
γ' = 1.8, 1.9, 2.0, 2.1, 2.2, and Δτ ≈ (γ'−1)Δτ_SIS to within 3% (critic `E2a–c`). At fixed observed
Δt, H0 ∝ Δτ. So a true profile *steeper* than assumed means H0^true > H0^naive. It is a
*shallower* profile (more convergence at the images, the λ < 1 direction; layer box "Steeper or
shallower?", critic `E4g`) that lowers H0. Exact replacement:
"(a true mass sheet, or unmodeled line-of-sight structure, or a profile that is \emph{shallower}
than assumed near the images)".

**F6 (author flag 6) — "shifts $\Hubble^{\mathrm{naive}}$ downward by 10\%", ch. 9 ~l.1155. CONFIRMED (wording).**
H0^naive is what the fit returns; it does not shift. The correction moves the inference:
H0^true = 0.9 H0^naive. Replacement: "A 10\% mass sheet ($\lambda = 0.9$, i.e., adding
$\kappab_s = 0.1$ to the convergence) gives $\Hubble^{\mathrm{true}} = 0.9\,\Hubble^{\mathrm{naive}}$:
the inferred value moves 10\% downward (equivalently, the naive value is 11\% too high)." The
annotation "What 'shifts downward by 10%' means" then becomes unnecessary.

**F7 (author flag 7) — ch. 9 l.832–845 (orig. l.620–631). CONFIRMED (two defects).**
(i) Fragment: "…verified in \texttt{galaxy\_lensing.wl}.\nand the Einstein radius is:" starts a
sentence with lowercase "and" after a full stop. Replace with "…verified in
\texttt{galaxy\_lensing.wl}.  The Einstein radius is". (ii) Normalization: matching to the
isothermal case at γ' = 2 fixes only one value. A = 1/2 and A = (3−γ')/2 both match at γ' = 2 but
differ elsewhere (critic `E4f`). The condition that actually gives (3−γ')/2 is κ̄(θE) = 1 (critic
`E4e`). Replacement: "A short computation that fixes the overall normalization by requiring the mean
convergence inside $\thetaE$ to be unity, $\bar\kappab(\thetaE) = 1$ (which for $\gamma' = 2$
returns the SIS), gives". Note that 09_Solutions Ex 9.4(a) already uses the correct definition.

**F8 (author flag 8) — parenthesis "∇·(θ/2) = 1 = 1 − λ up to the overall factor", ch. 9 l.438–440. CONFIRMED: garbled.**
∇·(θ/2) = 1 is the divergence of the deflection of a κ = ½ sheet (critic `E1d`). The "= 1 − λ" does
not follow. The correct fact is that a sheet of convergence κs deflects by κsθ because
∇·(κsθ) = 2κs (`E1c`). Replacement: "(the $(1-\lambda)\vectheta$ piece is the deflection of a
uniform sheet of convergence $1-\lambda$, since $\nabla\cdot[(1-\lambda)\vectheta] = 2(1-\lambda)$)".
The layer box "Reading the parenthesis…" can then be cut to its corollary sentence.

**F9 (author flag 9) — 09_Solutions Ex 9.2(d), l.149–155. CONFIRMED.**
In φ_λ(θ, λβ) − λφ(θ, β) the θ-dependence vanishes identically, so the |θ|² terms cancel *within*
each image's Fermat potential (critic `E1b`). What cancels *between* the images is the leftover
½λ(λ−1)|β|², which depends only on the common source (`E1a`). Replacement for the last sentence:
"The $|\vectheta|^2$ terms cancel within each image's Fermat potential, leaving
$\phi_\lambda = \lambda\phi + \tfrac12\lambda(\lambda-1)|\vecbeta|^2$; the last term depends only on
the common source position and cancels between the two images, leaving a factor of $\lambda$
multiplying the original Fermat-potential difference."

**F10 (author flag 10) — D_Δt convention. CONFIRMED as a naming inconsistency, not a numerical error.**
Eq. `time_delay_recap` (l.1043–1050) writes Δt = (1+zd)/c · DdDs/Dds · Δτ and names DdDs/Dds
"$D_{\Delta t}$". Ex 9.3's own hint (l.1534) names (1+zd)DdDs/Dds "$D_{\Delta t}$", and so do the
script printout (`D_Delta_t = (1+z_d)*D_d*D_s/D_ds`) and the layer's boxes (X10). No number is
affected, because (1+zd) appears exactly once in every formula (critic `E5a`: 4463 Mpc → 79.97 d →
H0 = 69.98). Recommended single fix in the visible chapter: "…and the combination
$(1+z_d)\Dd\Ds/\Dds$ is called the \textbf{time-delay distance} $D_{\Delta t}$, so that
$\Delta t_{AB} = D_{\Delta t}\,\Delta\tau_{AB}/\speedoflight$." Then shorten the layer's "Two
conventions for $D_{\Delta t}$" box to its unit check, and the 09_Solutions "Convention check" box to
one line. Two related visible slips in Ex 9.3, both NEW:
- **F10a** Ex 9.3(a): "$d$ is a dimensionless function". d = H0·DdDs/Dds has units of velocity (it
  equals c·f_d f_s/f_ds, as the layer box says). Replace with "where $d$ (units of velocity, e.g.
  km\,s$^{-1}$) depends only on the redshifts and the density parameters".
- **F10b** Ex 9.3(c): "at \emph{fixed observed} $\Delta t$ the inferred $\Hubble$ scales the opposite
  way:" followed by H0^true = λH0^naive. That relation is the *same* direction as the model delay
  (both ∝ λ). Replace "scales the opposite way" with "scales the same way, by $\lambda$".

**F11 (author flag 11) — 09_Solutions Ex 9.4(d), l.345–350. CONFIRMED.**
The exercise (ch. 9 l.1570–1574) gives no redshifts. `problems_09.wl` l.369 assumes zd = 0.3,
zs = 1.0 and prints only σ_SIS = 255 km/s and the ratio 0.90 (run log "Ratio = 0.90 … Since
predicted ~ observed, gamma' ~ 2.0"). No γ' is computed, so "numerical evaluation … gives
γ' ≈ 2.0–2.1" is unsupported. Replacement: "Assuming $z_d = 0.3$, $z_s = 1.0$ (not given in the
exercise), the isothermal prediction for $\thetaE = 1.2''$ is $\sigma_{\mathrm{SIS}} \approx
255$~km/s, so $\sigma_{\mathrm{obs}}/\sigma_{\mathrm{SIS}} \approx 0.90$. Inverting for $\gamma'$
requires an aperture, a light profile and an anisotropy, which are not specified; a ratio this close
to unity is consistent with a near-isothermal $\gamma' \approx 2$ (bulge--halo conspiracy)." Better
still, add the redshifts to the exercise statement.

**F12 (⚠, layer; X3) — local-MST bridge vs Chapter 21.** γ'_eff = γ' + f(3−γ') is exact for matching
α and dα/dθ at θE (critic `E4b`), and its *sign* (an unmodelled central mass looks steeper) agrees
with Chapter 21's worked fit (δγ' > 0). Its *size* does not carry over: at γ' = 1.6 the ring-local
estimate gives dγ'/df = 3 − γ' = 1.4, while Chapter 21's exact DSPL fit gives dγ'/dm = +15.6,
because there the slope is set mainly by the radial image. Suggest appending to the bridge:
"This ring-local estimate fixes the sign; when a radial image is fitted, the slope bias is several
times larger (Chapter~\ref{ch:central_mass_bias}, Table~\ref{tab:cb_worked})."

**F13 (⚠, layer; X9) — DSPL bridge wording.** The algebra is correct (critic `E3a,b`) and consistent
with Chapter 22 eq. `ms_free` once the roles are named. Map Ch 9's MST'd reference plane to Ch 22's
far plane (λ ↔ λ2, η ↔ B). Then Ch 9's η' is the *true* ratio implied by a model with ratio η, and
Ch 22's B' is the *model* ratio implied by a true B. These are inverse maps: η'(B'(B, λ), λ) ≡ B
(`E3c`). With B = 0.7 and λ = 0.9, B' = 0.722 while η'(0.7) = 0.677 (`E3d`), so a reader comparing
the two formulas directly will think they disagree. Two wording issues: (a) "η < 1" requires plane 1
to be the *far* source, but "ignoring the mass of the first source" reads as if plane 1 were the
near one; (b) "provided the distance ratio is changed from η to η'" does not say which is the model
value. Suggest: "Take plane 1 to be the far source (η1 = 1) and plane 2 the near one, η2 = η < 1,
ignoring the near source's own mass. … A model with ratio η and the MST'd deflector reproduces both
image sets of a true lens with the original deflector and ratio η'. Equivalently, given the true
ratio B, the model ratio is B' = 1/(1−λ+λ/B), Chapter 22 eq.~\eqref{eq:ms_free}."

**Script note (repo `.wl`, outside the layer).** `problems_09.wl` Ex 9.5(d) prints "Smallest enclosed
mass: Q2237+0305 (~0.1 x 10^11 Msun)" while its own table gives 0.168×10¹¹ (visible table: ~0.2).
Change "~0.1" to "~0.2".

## Prose (LLM tells) — flag-only

Added text: chapter ≈2340 words, Solutions ≈840 words. Em-dashes: **0**. Antitheses: "it does not go as
1/λ" and "not as a computed value" both carry real content, so they are fine. "exactly" appears 8 + 3 times,
all mathematical. "Classic error:" appears twice as a label, which is fine. The worst offenders are P1 and P2,
each an aphoristic closing sentence. The layer otherwise reads as plain technical prose.

## Derivation checks

Critic scratch script (shared with the Module 8 report; Module 9 sections are E1–E5):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0809/critic_0809.wl`
→ `SUMMARY: 59 PASS, 0 FAIL  (of 59 checks)`.

| E-id | equation re-derived | result |
|------|--------------------|--------|
| E1 | MST Fermat potential τ_λ = λτ + ½λ(λ−1)|β|² (θ-dependence cancels within one image); ∇·(κsθ) = 2κs; ∇·(θ/2) = 1; λ = 0.920 | PASS (`E1a–e`) |
| E2 | Power law at fixed image positions: Δτ(γ') increasing, ≈ (γ'−1)Δτ_SIS ⇒ steeper ⇒ higher inferred H0 | PASS (`E2a–c`); visible remark sign FAIL (F5) |
| E3 | DSPL bridge identity and η'−η; inverse relation to Ch 22 B' | PASS (`E3a–d`) |
| E4 | γ'_eff = γ' + f(3−γ') exact; Jeans σr²; κ̄(θE) = 1 ⇒ (3−γ')/2; "isothermal matching" insufficient; local slope −0.818 | PASS (`E4a–g`) |
| E5 | Ex 9.3 D_Δt 4463 Mpc / 79.97 d; chapter SIE example 0.638 / 1.15″ / 5.1 kpc / 2.34×10¹¹; σ_SIS(1.2″) = 255; SIS M_E = πσ²RE/G | PASS (`E5a–d`) |

Author's repo script, run for this report:
`bash Mathematica/run_wl.sh Solutions/09_Galaxy_Lensing_Applications/problems_09.wl` →
`SUMMARY: 42 PASS, 0 FAIL  (of 42 checks)` / `ALL CHECKS PASS`.
