# fact-critic report — Notes/10_Cluster_Lensing/10_Solutions.tex (Annotated Study Edition layer)

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation (+ Provenance summary)
> Scope: boxes added in commit 0214efd (`git diff c588432 0214efd`) in `10_Solutions.tex` and the
> appended check section of `Solutions/10_Cluster_Lensing/problems_10.wl`; plus author flags (2), (3), (4)
> about pre-existing visible text.
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web — not exercised (no
> `\cite` in the new layer), md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓,
> overlay: AGEL/Zotero (local PDF of SKW 2006, item NNNRZT8L) ✓, Reference_Texts PDFs ✓,
> derivation adapter: wolframscript via `Mathematica/run_wl.sh` ✓.
> Critic scripts (scratch, not in repo):
> `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_1013/critic_1013.wl`
> (SUMMARY: 44 PASS, 0 FAIL (of 44)), `critic_1013_b.wl`, `critic_1013_d.wl` (NFW image magnifications).
> Independent constants used there: CODATA G, c = 2.99792458e8, own NIntegrate distances.

Repo script: `bash Mathematica/run_wl.sh Solutions/10_Cluster_Lensing/problems_10.wl`
→ `SUMMARY: 50 PASS, 0 FAIL  (of 50 checks)` / `ALL CHECKS PASS` (counts only the annotated-edition
checks; the original part has no `check[]`). The original 10.2 ray-trace prints
`beta = 0: 4970 image pixels`, `beta = 0.5 * thetaE: 0 image pixels`, `beta = 0.95 * thetaE: 0 image pixels`.

## Verdicts

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| N1 | Number | "ρ_crit,0 … 9.20e-27 kg m⁻³" | ✅ PASS | critic L2 (9.2039e-27) | none |
| N2 | Number | "E²(0.3) = 1.3591" | ✅ PASS | problems_10.wl check "10.1 E^2(0.3)…" PASS | none |
| N3 | Number | "r200 = 1.478 Mpc, r_s = 295.6 kpc", "M200 = 9.945e44 kg" | ✅ PASS | critic L2b (1.478); repo log r_s = 295.63 kpc | none |
| N4 | Number | "ρ_s … 1.09e-22 kg m⁻³", "m(5) = 0.9584" | ✅ PASS | repo log rhoS = 1.0875e-22; repo check m(5) PASS | none |
| N5 | Number | "θ_s = 3.218e-4 rad … 66.4″" | ✅ PASS | critic 66.371″; repo 66.369″ | none |
| N6 | Number | "Σ_cr = 4.91 kg m⁻² (= 2.35e15 M☉ Mpc⁻²)", D = 918.8/1726.6/1328.5 Mpc | ✅ PASS | critic L4 (2.3518e15); repo log 4.9125 kg m⁻², 1328.49 Mpc | none |
| N7 | Number | "κ_s = 2ρ_s r_s/Σ_cr = 0.404" | ✅ PASS | critic (0.40394) | none |
| N8 | Number | ρ_crit,0 pitfall: "E^{2/3}(0.3) = 1.108 (to 1.64 Mpc)", "θ_E 6.9″ → 4.3″, a 38% error" | ✅ PASS | critic L2/L2b: 1.1076, 1.637 Mpc, 4.309″, 1−4.309/6.903 = 0.376 | none |
| N9 | Number | "κ_s … drops from 0.404 to **0.330**" | ❌ FAIL (single-source rounding) | critic: 0.32922; repo log `kappa_s = 0.3291874…` → 0.329 at printed precision | `0.330` → `0.329` (10_Solutions.tex:88; also problems_10.wl:398–399 label/target). **Auto-fix attempted but blocked by the session permission classifier — not applied.** |
| N10 | Number | "x_t ≃ 2e^{−1/κ_s−1/2} = 2e^{−2.976} = 0.102 … within 2% of 0.104", "θ_E = 6.90″" | ✅ PASS | critic L1: 0.10203 vs 0.10403 (1.9%); 1/κ_s+½ = 2.9758 | none |
| N11 | Number | 10.1(c): "30.7 kpc = 9.49e20 m; πR² = 2.83e42 m²; 1.39e43 kg; 6.99e12 M☉; R_E/r200 = 0.021; 0.014" | ✅ PASS | problems_10.wl checks "10.1(c)…", "10.1(d)…" PASS (rerun today) | none |
| N12 | Number | 10.3(b,c): "log10 600 = 2.778, Δm = −6.95; μ ≥ 6.31; β ≤ 9.51″" | ✅ PASS | repo checks "10.3(b)…", "10.3(c)…" PASS | none |
| N13 | Number | 10.4: "6.954e-7; 8.739e-6; 0.7694; 6.72e-6 rad; 1.39″; factors 4 and 23.04" | ✅ PASS | repo checks "10.4 …" PASS; repo log θ_E(galaxy) = 1.3868″ | none |
| N14 | Number | 10.4(e): "D_dθ_E = 6.18e-3 Mpc; 1.20e-4 Mpc²; 2.82e11 M☉; ratio 531" | ✅ PASS | repo check "10.4(e) galaxy…" PASS | none |
| N15 | Number | 10.5(c): "Σ_cr(z_s=1) = 2.83e15; 1.336 Mpc; 5.61 Mpc²; 1.59e16; κ̄ = 0.0276; 4.39e14 M☉" | ✅ PASS | critic F3: Σ_cr = 2.834e15, M = 4.387e14 | none |
| N16 | Number | 10.5 annotation: "κ/κ̄ = 0.6 … κ̄ = 2.5γ_t … M(5′) ≈ 1.1e15 M☉" | ✅ PASS | critic F3 (1.097e15) | none |
| N17 | Number | bridge: "Σ_cr = 2.35e15 (z_s=2) vs 2.83e15 (z_s=1), ratio 1.21" (z_d = 0.3) | ✅ PASS | critic L4: ratio 1.2051 | none |
| D1 | Derivation | ρ_s = (200/3)ρ_crit c³/m(c) from equating two M200 expressions | ✅ PASS | repo symbolic check "10.1 4 pi rho_s r_s^3 m(c) = …" PASS; "NFW enclosed 3D mass" PASS | none |
| D2 | Derivation | "ln(x/2)+g(x) = (x²/2)[ln(2/x) − ½] + O(x⁴ ln x)"; arccosh(1/x) = ln(2/x) − x²/4 + … | ✅ PASS | critic L1b; repo checks PASS | none |
| D3 | Derivation | "M(θ_E) = 4π²σ⁴D_dD_ds/(Gc²D_s)" | ✅ PASS | critic L3 (independent symbolic) | none |
| D4 | Derivation | power law κ̄ = Aθ⁻ⁿ ⇒ κ = (1−n/2)κ̄, γ_t = (n/2)κ̄; κ̄ = 2∫γ_t dθ′/θ′ = (2/n)γ_t | ✅ PASS | critic F3 symbolic; repo checks PASS | none |
| D5 | Derivation | κ_s ∝ ρ_crit^{2/3}, r200 ∝ ρ_crit^{−1/3} | ✅ PASS | critic L2 numeric ratio = E^{−4/3} | none |
| X1 | Consistency | 10.3 derivation: "μ = (1 − θ_E/\|θ\|)⁻¹, which for an SIS equals \|θ\|/β (… tangential one is β/\|θ\|)" | ⚠ SUSPECT (sign) | critic L18: μ = θ/β with **signed** θ; for θ₋ = β − θ_E this is −\|θ₋\|/β, and the tangential eigenvalue is −β/\|θ₋\|. The next line (μ₋ = −(θ_E−β)/β) is correct, so the box contradicts itself. | "which for an SIS equals θ/β with θ signed (\|μ\| = \|θ\|/β); the radial eigenvalue is 1, the tangential one β/θ" |
| X2 | Consistency | annotation "μ₋ < 0 … μ₊ + μ₋ = 2, independent of β" | ✅ PASS | repo check "10.3 SIS signed mu+ + mu- = 2" PASS; critic L18 | none |
| X3 | Consistency | "Σ_cr here is for z_s = 1 … (not the z_s = 2 value of Ex 10.1)" | ✅ PASS | exercise text 10_Cluster_Lensing.tex:1052–1054 (z_s = 1, Σ_cr ≈ 2.8e15) | none |
| X4 | Consistency | κ_s convention note "κ = κ_s f(x) … references writing κ = 2κ_s f(x) define κ_s = ρ_s r_s/Σ_cr" | ✅ PASS | problems_10.wl:76–82 (kbarNFW = 2κ_s/x² …) + standard factor-2 algebra | none |
| X5 | Consistency | cross-refs `ch:axisymmetric_models`, `ch:weak_lensing`, `ch:multiplane_dspl`, `ex:*` | ✅ PASS | labels resolve: 07_Axisymmetric_Models.tex:10, 12_Weak_Lensing.tex:12, 14_Multiplane_DSPL.tex:18 ("The Multi-Plane Lens Equation and Double-Source-Plane Lenses") | none |
| VF2 | Number (visible) | 10.1(d): "the 1/r inner-density slope means M(<r) ∝ r at small r" | ❌ FAIL — author flag CONFIRMED | critic F2: M_3D(<r) = 2πρ_s r_s r² + O(r³); M_2D ∝ x²[ln(2/x) − ½] | see Flagged |
| VF3 | Consistency (visible) | 10.5(d): "γ_t ≈ κ̄ (valid at large radii where κ ≪ κ̄)" and "within ∼10%" | ❌ FAIL — author flag CONFIRMED (validity clause); "∼10%" is arithmetic-OK (12%) but misleading | critic F3 | see Flagged |
| VF4 | Number (visible) | 10.2 script 0 pixels; solution text "two arcs … counter-image", "β = θ_E (at the tangential caustic): giant arc", "(d) μ_t ∼ 5–10, L/W ∼ 5–10" | ❌ FAIL — 0 pixels REPRODUCED; cause is grid **extent**, not resolution; text physics also wrong | critic F4 + critic_1013_b/d | see Flagged |

Counts (layer only, N1–N17, D1–D5, X1–X5 = 27): ✅ 25 · ⚠ 1 · ❌ 1. Visible flags: 3 ❌ (all confirmed).

## Applied (auto-fixes)

None. N9 (`0.330` → `0.329`) qualifies as an auto-fix (one canonical source, unambiguous object) but
the edit to `10_Solutions.tex:88` and `problems_10.wl:398–399` was blocked by the session's permission
classifier; it is listed under Flagged instead.

## Flagged — your hand required

**N9 (layer, auto-fixable, not applied).** `10_Solutions.tex:88`: "drops from $0.404$ to $0.330$" →
"drops from $0.404$ to $0.329$". The critic got 0.32922 and the repo log has 0.3291875, which rounds to 0.329.
Also change `problems_10.wl:398` label "0.404 -> 0.330" to "0.404 -> 0.329" and line 399
`near[p0["kappaS"], 0.330, 0.001]` to `near[p0["kappaS"], 0.329, 0.0005]`. The current tolerance of 0.001 is
what let 0.330 pass.

**X1 (layer).** 10.3 derivation, first sentence. The box says μ "equals |θ|/β" and the tangential
eigenvalue is "β/|θ|". The signed values are θ/β and β/θ. As written it contradicts the box's own next
line, μ₋ = −(θ_E−β)/β. Replacement: "…the magnification is $\mu = (1-\thetaE/|\theta|)^{-1}$, which for an
SIS equals $\theta/\beta$ with $\theta$ signed (the radial eigenvalue is 1; the tangential one is
$\beta/\theta$)."

**VF2. Author flag (2), 10.1(d): CONFIRMED, the visible text is wrong.** For ρ ∝ r⁻¹,
M_3D(<r) = 2πρ_s r_s r² + O(r³), which is ∝ r² (critic F2, symbolic). The projected mass is
M_2D(<R) ∝ x²[ln(2/x) − ½] (critic F2, which matches the layer's own κ̄ ≃ κ_s[ln(2/x) − ½]). Neither
quantity is ∝ r. The physical conclusion (a small enclosed fraction) still holds and is in fact stronger.
Exact replacement for `10_Solutions.tex:154–156`:
"Despite the NFW profile being centrally concentrated, the shallow $1/r$ inner density cusp gives
$M_{\rm 3D}(<r) \propto r^2$ (and a projected mass $M_{\rm 2D}(<R) \propto R^2\ln(2r_s/R)$) at small radii,
so only a small fraction of the virial mass is enclosed at $R_E$."

**VF3. Author flag (3), 10.5(d): CONFIRMED for the validity clause.** For γ_t = 0.1(θ/1′)^{−0.8}, an
exact power law, κ = (1 − n/2)κ̄ = 0.6κ̄ at every radius, so κ ≪ κ̄ holds nowhere. Then
κ̄ = (2/n)γ_t = 2.5γ_t, and the self-consistent M(5′) = 1.10e15 M☉ (critic F3: 1.097e15).
The "within ∼10%" arithmetic is fine: 4.39e14/5e14 = 0.877, so 12% low. But the agreement comes from the
inconsistent approximation, and the self-consistent mass is 2.2 × 5e14.
- Replace "(i)~the approximation $\gamma_t \approx \bar{\kappa}$ (valid at large radii where
  $\kappab \ll \bar{\kappa}$);" with
  "(i)~the approximation $\gamma_t \approx \bar{\kappa}$, which for this power law fails at every radius:
  $\gamma_t \propto \theta^{-0.8}$ implies $\kappab/\bar\kappa = 1 - 0.8/2 = 0.6$, so $\bar\kappa = 2.5\,\gamma_t$
  and the self-consistent mass is $M(5') \approx 1.1\ee{15}\,\Msun$;".
- Replace "(within $\sim 10\%$)" with "(within $\sim 12\%$, though the agreement is partly fortuitous;
  see (i))".
- The exercise statement has the same false premise ("assuming that $\kappab \ll \bar\kappa$ at large radii",
  `10_Cluster_Lensing.tex:1045–1047`). That line is outside this layer's scope. Either soften it to "adopt the
  crude approximation $\gamma_t \approx \bar\kappa$", or change the profile so that the assumption holds.

**VF4. Author flag (4), 10.2 ray-trace: the 0 pixels are REPRODUCED, but the cause is different from the
script's own note.** The critic re-implemented the trace independently (box ±1.5θ_E, step 0.15″, source
radius 0.5″) and got counts {4970, 0, 0}, identical to the repo. The cause is the grid's **extent**, not its
resolution:
- For this NFW (κ_s = 0.404, θ_s = 66.4″, θ_E = 6.90″) the radial caustic is at β_r = 0.517″ = 0.075θ_E,
  with θ_r = 0.485″.
- β = 0.5θ_E and β = 0.95θ_E both lie far outside the radial caustic, so each source has **one** image:
  - β = 0.5θ_E gives θ = 13.48″ (1.95θ_E);
  - β = 0.95θ_E gives θ = 18.08″ (2.62θ_E).
- Both images lie outside the ±1.5θ_E = ±10.35″ box.
- A 6″ × 6″ window centred on each image, at the **same** 0.15″ step, catches 221 and 137 pixels. So
  resolution is not the problem (critic F4, all PASS).

The visible solution text is also wrong on the physics:
- "For β = 0.5θ_E: two arcs form, one bright … and one fainter (the counter-image)" is wrong. There is no
  counter-image.
- "β = θ_E (at the tangential caustic)" is wrong. For an axisymmetric lens the tangential critical curve
  θ_E maps to the **point** β = 0 (critic F4 check). The same error is in the exercise statement,
  `10_Cluster_Lensing.tex:976`.
- (d) "μ_t ∼ 5–10, L/W ∼ 5–10" is wrong. At β = θ_E the single image has μ_t = 2.69, μ_r = 1.38 and
  L/W ≈ μ_t/μ_r = 1.95 (critic_1013_d). L/W = 5 needs β = 0.85″ (0.12θ_E), and L/W = 10 needs
  β = 0.33″ (0.05θ_E).

Exact replacements:
- `10_Solutions.tex:170–175`: "For $\beta = 0.5\,\thetaE$ the source lies well outside the radial caustic
  ($\beta_r \approx 0.52'' \approx 0.075\,\thetaE$ for this cluster), so the circular NFW lens forms a
  \emph{single}, tangentially stretched image at $\theta \approx 13.5''$ ($\approx 2\thetaE$), with no
  counter-image. For $\beta = \thetaE$ the image is at $\theta \approx 18.5''$ ($\approx 2.7\thetaE$). For a
  circular lens the tangential caustic is the single point $\beta = 0$, so giant arcs need
  $\beta \lesssim 0.1\,\thetaE$."
- `10_Solutions.tex:179–184` (d): "For $\beta = \thetaE$ the image has $\mu_t = \theta/\beta \approx 2.7$ and
  $\mu_r \approx 1.4$, so $L/W \approx \mu_t/\mu_r \approx 2$: not a giant arc. $L/W \approx 5$–$10$ requires
  $\beta \approx 0.05$–$0.12\,\thetaE$, i.e.\ a source near the (point) tangential caustic."
- Exercise `10_Cluster_Lensing.tex:976`: "(iii)~$\beta = \thetaE$ (on the tangential caustic)" → either
  "(iii)~$\beta = 0.1\,\thetaE$ (close to the tangential caustic, which for a circular lens is the point
  $\beta = 0$)" or keep β = θ_E and drop the caustic claim.
- `problems_10.wl:164`: `gridRange = N[1.5 * thetaE1]` → `N[3 * thetaE1]` (covers 18.6″). Its note at lines
  188–191 ("sub-pixel at coarse grid resolution") should say the images fall outside the ±1.5θ_E box.

## Prose (LLM tells): flag-only

1054 added words; em-dashes 0; antithesis hits 1 ("not $\gammaL$", a physics contrast, not ornament);
hollow intensifiers 0; `\emph` 4, all on contrastive physics words (acceptable). The layer reads mostly clean.
- P1 ⚠ aphoristic closer: "…$\thetaE$ falls from $6.9''$ to $4.3''$, a 38\% error from one wrong
  density." Plain rewrite: "…falls from $6.9''$ to $4.3''$ (38\% low)."
- P2 ⚠ "a common slip and it is not small": mild rhetorical framing. Option: "Using
  $\rho_{\mathrm{crit},0}$ instead changes the result substantially."

## Provenance (machine-drafted text): flag-only

Baseline is c588432. Commit 0214efd carries "Co-Authored-By: Claude", so all 1054 added words
(100% of the layer) are machine-introduced. Action: the author rereads the boxes and rewrites them in their
own words before release (tutorial prose, not a proposal, so this is advisory).

## Repo-check quality notes (non-blocking)

- `problems_10.wl:40` comment says astropy D_ds = 1328.2 Mpc; the computed and printed value is 1328.49 Mpc.
  This is a stale comment only.
- The N9 tolerance (±0.001) is looser than the printed precision, so it accepted 0.330.

## Derivation checks

Script: `/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_1013/critic_1013.wl`
→ `SUMMARY: 44 PASS, 0 FAIL (of 44)` (shared across modules 10–13). Module-10 rows:
- F2 M_3D ∝ r², M_2D ∝ x²[ln(2/x) − ½]: PASS (the visible text is wrong).
- F3 power-law κ/κ̄ = 0.6, κ̄ = 2.5γ_t, M(5′) = 4.39e14 approx vs 1.10e15 self-consistent: PASS.
- F4 0-pixel reproduction; extent-not-resolution; single image; tangential caustic at β = 0: PASS (6 checks).
- L1/L1b x_t = 0.10403 numeric vs 0.10203 leading-order; small-x series: PASS.
- L2/L2b ρ_crit,0 = 9.204e-27, κ_s 0.404 → 0.3292, θ_E 6.903″ → 4.309″, r200 1.478 → 1.637 Mpc: PASS
  (note: 0.3292 rounds to 0.329, hence N9).
- L3 M(θ_E) = 4π²σ⁴D_dD_ds/(Gc²D_s): PASS.
- L4 Σ_cr(0.3,1)/Σ_cr(0.3,2) = 1.2051: PASS.
- L18 SIS signed μ = θ/β: PASS (hence X1).
- Supplementary: `critic_1013_d.wl` gives L/W versus β (L/W = 5 at 0.12θ_E, 10 at 0.05θ_E);
  `critic_1013_b.wl` gives μ_t, μ_r at β = 0.5, 0.95, 1.0θ_E.

## Resolution — fixes applied 2026-10-14

| id | Fix | Backing |
|----|-----|---------|
| N9 | 10_Solutions.tex:88 κ_s "0.330" → "0.329". problems_10.wl label/target 0.329, tolerance 0.0005 (was 0.001). | problems_10.wl "10.1 pitfall: kappa_s scales as rho_crit^(2/3): 0.404 -> 0.329", "10.1 pitfall (fix 2026-10-14): printed 0.329, not 0.330, at 3 decimals" (κ_s = 0.32919) |
| X1 | 10.3 derivation: "equals θ/β with θ signed, so \|μ\| = \|θ\|/β (the radial eigenvalue is 1; the tangential one is β/θ)". | existing "10.3 SIS mu(theta_pm) = theta_pm/beta (signed)" |
| VF2 | 10.1(d): "the shallow 1/r inner density cusp gives M_3D(<r) ∝ r² (and a projected mass M_2D(<R) ∝ R² ln(2r_s/R)) at small radii". A sentence records that the earlier "M ∝ r" is the isothermal scaling. | problems_10.wl "10.1(d) NFW M_3D(<r) = 2 pi rho_s r_s r^2 + O(r^3) …" (also checks no O(r) term), "10.1(d) NFW M_2D(<R) ~ x^2 [ln(2/x) - 1/2] …" (also checks M_2D/x → 0) |
| VF3 | 10.5(d): "(within ∼12%, though the agreement is partly fortuitous; see (i))". Item (i) now says γ_t ≈ κ̄ fails at every radius for this power law: κ/κ̄ = 0.6, κ̄ = 2.5γ_t, M(5′) ≈ 1.1e15 M☉. Exercise premise (10_Cluster_Lensing.tex, ex:weak_lensing_mass (a)) softened to "adopting the crude approximation γ_t ≈ κ̄ (part (d) asks how good it is)". | problems_10.wl "10.5(d) M(5')/5e14 = 0.877: within ~12% (not ~10%)", "10.5(d) self-consistent M(5') = 2.5 x 4.39e14 ~ 2.2 x 5e14", plus the existing power-law checks |
| VF4 | (1) problems_10.wl ray trace: box ±1.5θ_E → ±3θ_E; sources at β = 0, 0.5θ_E, 0.1θ_E (exercise cases) plus θ_E for comparison; pixel counts split by side of the lens. Pixel counts: {4968, 220, 2173, 127}; β = 0.5θ_E and θ_E have 0 pixels on the far side. The stale "sub-pixel resolution" note is replaced: the images were outside the box. (2) Exercise (iii) β = θ_E "on the tangential caustic" → "β = 0.1θ_E (close to the tangential caustic, which for a circular lens is the point β = 0)". (3) 10_Solutions (a–c): Einstein ring; β = 0.5θ_E gives a single image at 13.5″ (≈2θ_E) and no counter-image; β = 0.1θ_E is inside the radial caustic and gives a giant arc at 8.5″ (1.23θ_E), a counter-image at ≈4.8″ and a faint radial image at ≈0.8″; β = θ_E gives one image at 18.5″. The text also states that the box must reach ≈3θ_E. (4) (d): at β = 0.1θ_E, μ_t ≈ 12, μ_r ≈ 2.1, L/W ≈ 6 (point source; the 0.5″ source smears this); L/W ≈ 5–10 needs β ≈ 0.05–0.12θ_E; β = θ_E gives μ_t ≈ 2.7, μ_r ≈ 1.4, L/W ≈ 2. | problems_10.wl "10.2 …" checks: radial caustic, tangential critical curve → point β = 0, single images at 13.5″/18.1″/18.5″, no counter-image for β > β_r, three images at 0.1θ_E, L/W values, dα/dθ = 2κ − κ̄ against a finite difference, ray-trace pixel counts > 0, no far-side pixels |
| repo-check | problems_10.wl:40/47 stale "1328.2" comment → 1328.5 (the value computed and printed). | existing "10.1 D_d, D_s, D_ds = 918.8, 1726.6, 1328.5 Mpc" |

**Correction to this report (VF4): the radial caustic.** The critic's β_r ≈ 0.517″ ≈ 0.075θ_E (θ_r ≈ 0.485″)
does not reproduce. In the fix pass, β_r was computed two independent ways: max_θ[α(θ) − θ], and the root of
1 − 2κ + κ̄ = 0 (also checked against a finite-difference α′). Both give **β_r = 1.01″ ≈ 0.146θ_E,
θ_r = 2.52″**. This does not change the critic's conclusion for β = 0.5θ_E and θ_E: those sources are far
outside the radial caustic, so each has a single image. It does change case (iii) of the corrected exercise:
β = 0.1θ_E = 0.69″ lies **inside** the radial caustic, so the lens forms three images. That case therefore
shows the arc, the counter-image and the radial image the exercise asks for in (c). The critic's suggested
wording ("β_r ≈ 0.52″ ≈ 0.075θ_E") was not used. The image positions and the L/W values do agree with the
critic: 13.48″, 18.07″, 18.55″; L/W = 1.95 at θ_E, 5.1 at 0.12θ_E and 9.7 at 0.05θ_E.

**Verification after edits.** `bash Mathematica/run_wl.sh Solutions/10_Cluster_Lensing/problems_10.wl`:
before `SUMMARY: 50 PASS, 0 FAIL  (of 50 checks)`, after `SUMMARY: 67 PASS, 0 FAIL  (of 67 checks)`.
One build covers modules 10–13: `cd Notes && ANNOT_REQUIRED=1 bash build.sh` ended "=== Build complete: all
assertions passed ===". Page counts: student 360, instructor 444, annotated 569. Fingerprints:
`Learning_to_Lens.pdf 360 pages text-md5 c100be1eb30c52f133c57fb3f9e1bdea sentinels 0`;
`Learning_to_Lens_Solutions.pdf 444 pages text-md5 7b9c5859868d31998851952d33ad8494 sentinels 0`;
`Learning_to_Lens_Annotated.pdf 569 pages text-md5 720cdbe0b8e77045bf4ff426115826b1 sentinels 511`.

**Left open.**
- Exercise 10.2 (ii) still says "β = 0.5θ_E (halfway to the critical curve)". This mixes source-plane and
  image-plane language, but the critic did not flag it, so it is unchanged.
- P1/P2 prose (flag-only) was not applied.
