# fact-critic report — Module 8 Annotated Study Edition layer

Targets: the boxes added in commit `50d755c` (`git diff c588432 50d755c`) in
`Notes/08_Elliptical_Models_Caustics/08_Elliptical_Models_Caustics.tex`,
`Notes/08_Elliptical_Models_Caustics/08_Solutions.tex`, and the appended
annotated-edition checks in `Solutions/08_Elliptical_Models_Caustics/problems_08.wl`;
also an adjudication of the author's flags on the pre-existing visible text.

> Date: 2026-10-14 · Lenses: Citation, Number, Consistency, Prose, Derivation
> Active adapters this run: bibtex ✓ (`Notes/references.bib`), crossref-web ✓ (api.crossref.org reachable),
> md-reflist ✗, values-file ✗, repo-grep ✓, doc-internal ✓, run-wl ✓ (`bash Mathematica/run_wl.sh`),
> overlay none used (no private sources needed).
> (A claim whose lens has no active adapter is capped at ⚠ SUSPECT.)
> Critic is independent of the author: every derivation PASS below names a `check[]` in the critic's own
> scratch script (`critic_0809.wl`, path in §Derivation checks), not the author's `problems_08.wl`;
> the author's script was also run and its SUMMARY is quoted.

## Verdicts

Totals: **✅ PASS 27 · ⚠ SUSPECT 5 · ❌ FAIL 6** (all 6 FAILs are in the pre-existing visible text; none are in the new layer).

| id | lens | quoted | verdict | source checked | proposed fix |
|----|------|--------|---------|----------------|--------------|
| C0 | Citation | (layer adds no `\cite` and no textual "X showed" attributions) | ✅ PASS (nil) | `git diff c588432 50d755c -- Notes/08*` grep `\cite` = 0 | none |
| N1 | Number | "θ_crit(0)=θE/(1+g) … 0.909″ and 1.111″" | ✅ PASS | critic `D4a/b`; repo `problems_08.wl` A11 | none |
| N2 | Number | "semi-axes 0.182″ and 0.222″ … area 0.0476 arcsec²" | ✅ PASS | critic `D4d` | none |
| N3 | Number | "For q = 0.7: ε = 0.3 but e = 0.176" | ✅ PASS | repo B22; arithmetic | none |
| N4 | Number | "Putting one where the other is meant is a factor-of-two error" | ⚠ SUSPECT | ε/e = 0.3/0.176 = 1.70 at q = 0.7 (→2 only as q→1) | "nearly a factor of two (1.7 at q = 0.7)" |
| N5 | Number | "q = 0.7 cusps 0.263 θE and −0.213 θE; q = 0.8: 0.159 θE and −0.139 θE" | ✅ PASS | critic `D6a`, `D6b` | none |
| N6 | Number | "cut crosses the axes at |β1| = 0.932 θE and |β2| = 1.049 θE" | ✅ PASS | critic `D5a` (0.93186, 1.04923) | none |
| N7 | Number | "For q < 0.394 the β1 cusps poke outside it" | ✅ PASS | critic `D5d` (q_nc = 0.394235) | none |
| N8 | Number | "for q = 0.3 … source halfway between the cut and the cusp tip … gives 3 images" | ✅ PASS | critic `D5e` (independent grid of FindRoot seeds) | none |
| N9 | Number | "coefficient of ψ(cosφ, sinφ) is −0.059 θE" (cos 2φ, q = 0.7) | ✅ PASS | critic `D7c` (−0.05859) | none |
| N10 | Number | "θA = 1.432″, θB = −0.432″ … μA = +6.05, μB = −0.566 … θE/√q = 1.195 θE" | ✅ PASS | critic `D6g` | none |
| N11 | Number | Ex 8.4 "(0.358, 1.195)″ and (−0.564, −0.547)″ … μ = +3.67, −3.82 … sum −0.15" | ✅ PASS | critic `D6c`, `D6e` | none |
| N12 | Number | "F = 1.229, 2κ = 0.728 … F = 0.709, 2κ = 1.262" | ✅ PASS | repo B29; recomputed from critic `D6c` positions | none |
| N13 | Number | "maximum of |β2| over the whole caustic is 0.139″ (at the cusp)" | ✅ PASS | critic `D6f` (4000-point caustic) | none |
| N14 | Number | "quad region is only about 1.5% of πθE²"; "factor 1/0.433 = 2.3" | ✅ PASS | 0.0476/π = 0.0152; `problems_08.wl` run log "Ratio SIE/SIS+shear: 0.4334" | none |
| N15 | Number | "γ1 = −m/D² < 0 … φγ = 90°" (distant point mass on +θ1) | ✅ PASS | repo A12; hand Hessian of m ln|θ−D ê1| at origin | none |
| X1 | Consistency | Step-4 box "Reading the Step-4 display" vs visible Step 4 | ✅ PASS (box) / ❌ FAIL (visible) | critic `D1a–D1e` | see Flagged F1 |
| X2 | Consistency | box "How far is far?" vs visible Stage 1 "two images" | ✅ PASS (box) / ❌ FAIL (visible) | critic `D5b` | F2 |
| X3 | Consistency | box "What the script actually returns" vs visible Ex 8.4(b) | ✅ PASS (box) / ❌ FAIL (visible) | critic `D6c`, `D6d` | F3 |
| X4 | Consistency | box "A sharper inside/outside test" (0.159/0.139) vs visible Ex 8.4(a) "cusps at approximately β ≈ 0.1″" | ❌ FAIL (visible) | critic `D6a` | F3 |
| X5 | Consistency | SIE-ellipse box vs visible Ex 8.1(b) "ellipse" (SIS+shear) and chapter "smooth oval curves" (SIE) | ❌ FAIL (visible Ex 8.1(b) only; box correct) | critic `D3a`, `D3c` | F4 |
| X6 | Consistency | visible: "As the source crosses the radial caustic inward, two additional images appear … bringing the total from 3 to 5" vs the table right below (1 → 3 → 5) | ❌ FAIL (visible; NEW, not author-flagged) | doc-internal table, ch. 8 ~l.1311–1326; critic `D5c` counts | F5 |
| X7 | Consistency | visible Ex 8.4(d) "sum of the two observable images is close to zero, consistent with the central image having small positive |μ|" | ⚠ SUSPECT (visible) | critic `D6e` (−0.15 vs |μ| ≈ 3.7); layer box itself says the argument needs a model | F6 |
| X8 | Consistency | every `\ref`/`\eqref` in the layer resolves to exactly one `\label` | ✅ PASS | repo-grep over `Notes/*/*.tex` (0 missing, 0 duplicate) | none |
| X9 | Consistency | bridge targets: `ch:multiplane_dspl` (Ch 18), `ch:multipoles` (Ch 23), `ch:odd_images` (Ch 20) match the content described | ✅ PASS | `Notes/main.toc` l.483, 485, 488 | none |
| X10 | Consistency | cusp/fold test box "Both models put their cusps on the symmetry axes" | ✅ PASS | critic `D4` (sinφcosφ = 0); repo B16 | none |
| X11 | Consistency | project-leakage grep (`tier|scripts/|results/|lenstronomy|AGEL|…`) on the added lines | ✅ PASS (nil) | repo-grep on diff | none |
| D1 | Derivation | Step-3 box: ∂1α1 = θE√q θ2²/(θ²F), ∂2α2 = θE√q θ1²/(θ²F), ∂2α1 = ∂1α2 | ✅ PASS | critic `D1a, D1b, D1f` | none |
| D2 | Derivation | "Every isothermal lens has det A = 1 − 2κ", |γ| = κ, for any ψ = θG(φ) | ✅ PASS | critic `D2a–D2c` (generic G), `D1g` (SIE) | none |
| D3 | Derivation | SIE critical curve is the exact ellipse q²θ1² + θ2² = qθE², area πθE², mean κ = 1 inside, all q | ✅ PASS | critic `D3a`, `D3b` (q = 0.5, 0.7, 0.8; NIntegrate = π) | none |
| D4 | Derivation | SIS+shear caustic β = (−2gθE cos³φ/(1+g), +2gθE sin³φ/(1−g)); astroid area 3πab/8 | ✅ PASS | critic `D4a–D4c` | none |
| D5 | Derivation | cut ⇒ one image outside it, two between cut and diamond, four inside | ✅ PASS | critic `D5b`, `D5c` | none |
| D6 | Derivation | cusp normal form ⇒ μA + μB + μC = 0; fold ⇒ μ+ + μ− = 0 | ✅ PASS | critic `D7d` (3 roots, Σμ = 7×10⁻¹⁵); repo C1 | none |
| D7 | Derivation | isothermal dipole is massless (a pure source shift); κm = a(1−m²)cos m(φ−φm)/(2θ) | ✅ PASS | critic `D7a`, `D7b` | none |
| D8 | Derivation | SIS two-image signed sum = 2 vs −0.15 for the SIE double | ✅ PASS | critic `D7e`, `D6e` | none |
| P1 | Prose | "The odd image is the most direct probe of the innermost mass profile." (bridge, Ch 20) | ⚠ SUSPECT (unsupported superlative closer) | read | "The central image probes the innermost mass profile." |
| P2 | Prose | "treat the mapping as a heuristic, not an identity" (08_Solutions) | ⚠ SUSPECT (antithesis) | read | "treat the mapping as a rough heuristic." |
| P3 | Prose | "That is the precise sense of ``SIS-equivalent'' Einstein radius." | ⚠ SUSPECT (pointer phrase, mild) | read | "This is what ``SIS-equivalent'' means here." |

## Applied (auto-fixes)

None. The layer contains no number that disagrees with a single canonical source, and the
brief forbids edits to the visible text. All visible-text findings are in Flagged.

## Flagged — your hand required

Each author flag is adjudicated independently from the critic's own script.

**F1 (author flag 1) — Step 4 display, ch. 8 ~l.573–583. CONFIRMED: visible text is wrong.**
Re-derived from the Kormann SIE deflection (eq. `sie_alpha`):
∂1α1 = θE√q θ2²/(θ²F) and ∂2α2 = θE√q θ1²/(θ²F), with θ² = θ1² + θ2² (critic `D1a`, `D1b`).
The displayed θE√q θ2²/F³ and θE√q q²θ1²/F³ are not the individual derivatives (`D1c`, `D1d`;
e.g. at q = 0.7, θ = (0.4, −0.9): true ∂1α1 = 0.738, displayed form = 0.847). The display drops
the outer factor d arctan x/dx = F²/θ². Both pairs sum to θE√q/F = 2κ (`D1e`), so eq.
`sie_poisson_check` stands. Exact replacement for the display body:
```
\partial_1\alpha_1
&= \frac{\thetaE\sqrt{q}}{\sqrt{1-q^2}}\;
   \frac{\partial}{\partial\theta_1}\!
        \arctan\!\!\left(\frac{\theta_1\sqrt{1-q^2}}{F}\right)
 = \frac{\thetaE\sqrt{q}}{\sqrt{1-q^2}}
   \cdot \frac{F^2}{\theta^2}\cdot\frac{\sqrt{1-q^2}\,\theta_2^2}{F^{3}} \\
&= \frac{\thetaE\sqrt{q}\,\theta_2^2}{\theta^2 F},
\\[2pt]
\partial_2\alpha_2
&= \frac{\thetaE\sqrt{q}\,\theta_1^2}{\theta^2 F},
```
and the sum line: `\nabla^2\psiL = \frac{\thetaE\sqrt{q}\,(\theta_1^2+\theta_2^2)}{\theta^2F} = \frac{\thetaE\sqrt{q}}{F} = 2\kappab(\vectheta)`.
Also add "with $\theta^2 = \theta_1^2+\theta_2^2$" after "and simplifying". If this is applied, the
annotation "Reading the Step-4 display" becomes obsolete and should be deleted, and repo check
`[B6] FLAG:` should be retired.

**F2 (author flag 2) — Stage 1, ch. 8 l.1216–1233. CONFIRMED: visible text is wrong for a source "far outside".**
For the singular SIE (q = 0.7) a source beyond the cut has exactly one image: β = (1.2, 0), (0, 1.3),
(0.8, 0.8) each give 1 image (critic `D5b`). Sources between the diamond and the cut give 2 and
sources inside the diamond give 4 (`D5c`). The cut crosses the axes at 0.932 θE and 1.049 θE (`D5a`).
The sentence "In a non-singular model an additional third image would appear…" is also wrong for a
*far* source: a cored lens gives 1 image outside its radial caustic (the table at l.1319).
Replacement for the paragraph head and first two sentences:
> \paragraph{Stage 1: Source outside the tangential caustic.}
> If the source is beyond the cut (for $q = 0.7$, $|\beta_1| > 0.932\,\thetaE$ on the $\beta_1$ axis, $|\beta_2| > 1.049\,\thetaE$ on the $\beta_2$ axis) the SIE forms a \textbf{single} Type~I image. Once the source is inside the cut but still outside the diamond, there are \textbf{two images} (one Type~I …).

Replace "In a non-singular model an additional third image would appear at the maximum of $\tau$
near the lens center" with "In a non-singular model a third, Type~III image appears near the lens
center once the source is inside the radial caustic". Then trim the "How far is far?" box to its
last sentence, or delete it.

**F3 (author flag 3) — 08_Solutions Ex 8.4(a)/(b). CONFIRMED: visible numbers are wrong.**
(b) The two images are at (0.358, 1.195)″ and (−0.564, −0.547)″ (critic `D6c`, an independent
FindRoot grid that matches the repo script to 4 dp). The printed (0.53, 0.79)″ and (−0.37, −0.52)″
are not solutions: the lens-equation residuals are 0.297″ and 0.154″ (`D6d`). Replace with
`Image A: $\vectheta_A \approx (0.36, 1.20)''$, $\mu_A \approx +3.67$` and
`Image B: $\vectheta_B \approx (-0.56, -0.55)''$, $\mu_B \approx -3.82$`, and delete the hedge
"(Exact values depend on the numerical solver…)". The annotation "What the script actually returns"
then reduces to its sanity-check sentence.
(a) "cusps at approximately $\beta \approx 0.1''$" is wrong. For q = 0.8 the cusps are at
|β1| = 0.159″ and |β2| = 0.139″ (`D6a`). Replacement: "The tangential caustic of this SIE has
cusps at $|\beta_1| \approx 0.159''$ and $|\beta_2| \approx 0.139''$. The source has
$\beta_2 = 0.2'' > 0.139''$, the largest $|\beta_2|$ anywhere on the caustic, so it lies outside
the tangential caustic but well inside the cut: a \textbf{double}." The `|β| ≈ 0.224″` comparison
can then go.

**F4 (author flag 4) — "ellipse" vs "oval". Resolved: the two statements are about different lenses, so there is no contradiction. One visible wording should still change.**
- The SIE tangential critical curve *is* an exact ellipse, q²θ1² + θ2² = qθE², with area πθE² and
  mean κ = 1 inside for every q (critic `D3a`, `D3b`). The box is correct.
- Ex 8.1 is the **SIS + external shear**, whose critical curve θ_crit(φ) = θE(1 − g cos 2φ)/(1 − g²)
  is *not* an ellipse: at g = 0.1 it deviates from the ellipse with the same semi-axes by up to
  1.52% (`D3c`). This matches the chapter's own visible "deviation from a true ellipse reaches
  ~1.5% at γ_ext = 0.1" (ch. 8 ~l.219). So 08_Solutions Ex 8.1(b) "The critical curve is an
  ellipse elongated along $\theta_2$" is ❌ wrong. Replace it with "The critical curve is an
  oval, close to an ellipse for small $\gamma_{\mathrm{ext}}$ (deviation $\approx 1.5\%$ here),
  elongated along $\theta_2$."
- Optional (⚠): ch. 8 l.645 "the SIE critical curves are smooth oval curves whose shape depends on
  $q$" and the bullet "a smooth oval close to the Einstein radius" are true but undersell the result.
  Suggest "the SIE tangential critical curve is an ellipse, $q^2\theta_1^2+\theta_2^2 = q\thetaE^2$,
  with the same axis ratio as the mass". Also, Ex 8.2(b) in 08_Solutions says "The critical curve is
  an oval": same optional fix.

**F5 (NEW, not author-flagged) — radial-caustic sentence, ch. 8 ~l.1311–1315. FAIL.**
"As the source crosses the radial caustic inward, two additional images appear … bringing the total
from 3 to 5" contradicts the table directly below it (outside radial: 1; between: 3; inside
tangential: 5). Crossing the radial caustic inward takes 1 → 3. Crossing the tangential caustic
takes 3 → 5. Replacement: "As the source crosses the radial caustic inward, two additional images
appear (a Type~II near the radial critical curve and the Type~III central image), bringing the total
from 1 to 3; crossing the tangential caustic then adds two more, giving 5." (Cosmetic: the
`tabular{ccccc}` declares 5 columns but uses 3.)

**F6 (⚠, visible) — Ex 8.4(d).** The two-image signed sum is −0.15 (critic `D6e`), while the
individual |μ| ≈ 3.7. The text's argument ("slightly negative because the missing central image
would contribute a small positive magnification") does not follow: the SIS has a two-image sum of
exactly +2 with the same missing image (`D7e`). Suggest replacing the last sentence with "In this
example $\mu_A + \mu_B = 3.67 - 3.82 = -0.15$; for comparison the SIS gives $+2$ for every double,
so the two-image sum is model-dependent and not by itself evidence about the central image." (This
is what the layer's own box already says; once the visible text is fixed, the box can go.)

**N4 (⚠)** "factor-of-two error": ε/e = 1.70 at q = 0.7. Suggest "nearly a factor of two (1.7 at q = 0.7)".

**Repo script note.** `problems_08.wl` check `[B6]` is labelled `PASS: … FLAG: …`. It passes because
it asserts the visible display is wrong. Once F1 is applied, invert or remove it so the SUMMARY does
not report a stale "FLAG".

## Prose (LLM tells) — flag-only

Added text: chapter ≈2950 words, Solutions ≈1100 words. Em-dashes (`---`): **0** in both. Antitheses: 1 in the
chapter ("as a regrouping of the *sum*, not as the individual derivatives", which carries real meaning, so it
is fine) and 1 in Solutions (P2). "exactly" occurs 8 + 6 times, nearly all mathematical ("exactly 1 for every
q", "exactly degenerate"), so it is not rhetoric. Rule-of-three: the "Three traps" and "Three ellipticity
variables" lists are real enumerations. Worst offenders are P1 (unsupported superlative closing the Ch 20
bridge) and P3. "Classic error:" is used as a recurring label (1×), which is fine. Overall the layer reads
clean.

## Derivation checks

Critic scratch script (independent of the author's code):
`/private/tmp/claude-504/-Users-rosador-Documents-Learning-to-Lens/6bf8589b-f5b2-4d91-8bc1-cdd6f6bc49b6/scratchpad/critic_0809/critic_0809.wl`
(log: `…/critic_0809/critic_0809.log`). Run via `bash Mathematica/run_wl.sh`.
`SUMMARY: 59 PASS, 0 FAIL  (of 59 checks)`. Module 8 sections are D1–D7; Module 9 sections are E1–E5.

| D-id | equation re-derived | result |
|------|--------------------|--------|
| D1 | SIE Hessian from eq. `sie_alpha` (symbolic, all quadrants) | PASS (`D1a–g`); visible Step-4 individual terms FAIL as derivatives (`D1c,d`), sum PASS (`D1e`) |
| D2 | ψ = θG(φ) ⇒ det A = 1 − ∇²ψ = 1 − 2κ, |γ| = κ (generic G) | PASS (`D2a–c`) |
| D3 | SIE critical ellipse, area πθE², ∫κ = πθE² (q = 0.5, 0.7, 0.8); SIS+shear curve not an ellipse (1.52%) | PASS (`D3a–c`) |
| D4 | SIS+shear caustic cos³/sin³ closed form; astroid area 3πab/8; 0.0476 | PASS (`D4a–d`) |
| D5 | cut 0.932/1.049; image counts 1/2/4; naked-cusp q = 0.3942; 3 images at q = 0.3 | PASS (`D5a–e`) |
| D6 | cusps (q = 0.7, 0.8); Ex 8.4 images, μ, Σμ = −0.15; caustic max |β2| = 0.139; double 1.432/−0.432 | PASS (`D6a–g`) |
| D7 | multipole Laplacian, massless dipole; cusp normal form Σμ = 0; SIS Σμ = 2; SIE cos2φ coefficient −0.0586 | PASS (`D7a–e`) |

Author's repo script, run for this report:
`bash Mathematica/run_wl.sh Solutions/08_Elliptical_Models_Caustics/problems_08.wl` →
`SUMMARY: 54 PASS, 0 FAIL  (of 54 checks)` / `ALL CHECKS PASS` (note the `[B6] … FLAG` caveat above).

## Resolution — fixes applied 2026-10-14

Branch `wt/ann0809`. Checks are in `Solutions/08_Elliptical_Models_Caustics/problems_08.wl`
(section "Fix pass 2026-10-14"); each fails on the value printed before the fix.

| id | Fix | Backing |
|----|-----|---------|
| F1 | Step-4 display now prints ∂1α1 = θE√q θ2²/(θ²F), ∂2α2 = θE√q θ1²/(θ²F) (outer factor F²/θ² kept), sum line θE√q(θ1²+θ2²)/(θ²F) = θE√q/F; "with θ² = θ1²+θ2²" added. Annotation "Reading the Step-4 display" deleted; next box's "From the previous box" → "From the Step-3 box (and Step 4)". | `[B6]` inverted: now asserts the correct derivatives and sum, and rejects the old F³ forms (no more "FLAG") |
| F2 | Stage 1 retitled "Source outside the tangential caustic"; visible definition of the cut added; beyond the cut (0.932/1.049 θE at q = 0.7) → 1 image, inside cut but outside diamond → 2. Cored sentence → "a third, Type III image appears near the lens center once the source is inside the radial caustic". "How far is far?" box trimmed to its cored-model sentence. | `[F2]` (counts {1,1,1,2,4} for β = (1.2,0),(0,1.3),(0.8,0.8),(0.5,0),(0.05,0.03)); `[B19]` |
| F3 | Ex 8.4(a): cusps |β1| ≈ 0.159″, |β2| ≈ 0.139″, β2 = 0.2″ > 0.139″ → double; |β| ≈ 0.224″ comparison removed. (b): (0.36, 1.20)″ μ ≈ +3.67, (−0.56, −0.55)″ μ ≈ −3.82; solver hedge deleted. (c) quotes the values. Boxes "A sharper inside/outside test" and "What the script actually returns" reduced to their residual content. | `[F3a]`, `[F3b]` (fresh solve; old positions have residuals 0.297, 0.154); `[B24]`, `[B29]` |
| F4 | Ex 8.1(b): "an oval, close to an ellipse for small γext (deviation ≈ 1.5% here)". Optional wording applied: ch. 8 l.~645 "the SIE tangential critical curve is an ellipse, q²θ1²+θ2² = qθE², with the same axis ratio q as the mass"; bullet "an ellipse close to the Einstein radius"; Ex 8.2(b) "the ellipse q²θ1²+θ2² = qθE²". | `[F4a]` (SIS+shear deviation 1.52%), `[F4b]` (2κ = 1 ⇔ exact ellipse); `[B13]` |
| F5 | Radial-caustic sentence: crossing it inward 1 → 3 (Type II + Type III), tangential crossing then 3 → 5. `tabular{ccccc}` → `{ccc}`. | `[F5]` (cored isothermal elliptical potential, e = 0.1, s = 0.1: counts {1,3,5}, one Type III in the 3-image region) |
| F6 | Ex 8.4(d) restated: μA+μB = −0.15 vs |μ| ≈ 3.7; SIS gives +2 for every double with the same missing image, so the two-image sum is model-dependent. Box "The signed sum is not a universal number" deleted (now redundant). Script printout "Sum > 0? False VERIFIED" replaced. | `[B24]`, `[B26]` |
| N4 | "nearly a factor-of-two error (1.7 at q = 0.7)". | `[N4]` |
| P1 | Ch 20 bridge closer → "The odd image probes the innermost mass profile." | prose |
| P2 | 08_Solutions "treat the mapping as a rough heuristic." | prose |
| P3 | "That is the precise sense of…" → "That is what ``SIS-equivalent'' Einstein radius means here." | prose |
| (notation) | Ch 12 DSPL bridge aligned with the Part V preamble (same clash as the Ch 13 bridge flagged by the Ch 18 critic): plane 1 = near, plane 2 = far, κ1 = 𝓑κ2, θE(1) = 𝓑 θE(2), measured η = θE1/θE2 = 𝓑 for the SIE. | `[D3]` relabelled |

**Verification after edits.** Before: `SUMMARY: 54 PASS, 0 FAIL  (of 54 checks)` (with the `[B6] FLAG`).
After: `bash Mathematica/run_wl.sh Solutions/08_Elliptical_Models_Caustics/problems_08.wl` →
`SUMMARY: 61 PASS, 0 FAIL  (of 61 checks)`. Build `ANNOT_REQUIRED=1 bash build.sh`: student 360 pp,
instructor 444 pp, annotated 568 pp, "all assertions passed".

**Left open.** None of the confirmed items. Not touched (not flagged): 08_Solutions Ex 8.4 text no longer
makes the "Σμ > 0 for a non-singular lens" claim (it was removed with the old (d) wording); if the
statement is wanted back it needs its own check.
