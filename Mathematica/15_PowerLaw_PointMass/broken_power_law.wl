(* =========================================================================
   broken_power_law.wl
   Module 15: Power-Law Lenses with a Central Point Mass --- broken power law
   =========================================================================
   Purpose: Verify the closed forms of the circular broken power law
            (piecewise convergence with inner slope t1, outer slope t2,
            break radius tB, convergence kB at the break; t = g - 1 are
            CONVERGENCE slopes):
              1. piecewise deflection = enclosed-mass integral
              2. continuity at the break, t1 = t2 reduction, SIS limits
              3. Einstein-radius normalisation kB(nu, t1, t2)
              4. point-mass corner t1 -> 2 at fixed inner mass (inner
                 branch, and the joint limit that leaves an outer power law
                 plus a point mass)
              5. outside-the-break identity bPL = PL + theta_eff^2/theta,
                 sign of theta_eff^2, theta_eff^2/thBH^2, lambda_r identity
              6. inside the break: alpha_bPL/alpha_PM = (th/tB)^(2-t1),
                 logarithmic deviation linear in (2 - t1)
            and exports the deflection-comparison figure.

   Sources: Meneghetti (2021) Sect. 5.2 (power law; Remark 5.3: n = 3 is
            the point mass); Keeton (2001) astro-ph/0102341 Sect. 3
            (power-law families). Ported from the 202607 study-note script
            04_broken_pl/verify.wl (checks 1-5, 7-11; the vv[]/"CHECK"
            style converted to check[]; CSV exports and project-specific
            numerical anchors dropped).

   Usage:   bash Mathematica/run_wl.sh \
                 Mathematica/15_PowerLaw_PointMass/broken_power_law.wl

   Outputs: PASS/FAIL per check + SUMMARY line;
            Figures/15_PowerLaw_PointMass/broken_pl_deflection.pdf
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "harness.wl"}]];
Print["=== Module 15: broken power law ===\n"];

figDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Figures",
    "15_PowerLaw_PointMass"}];
If[!DirectoryQ[figDir], CreateDirectory[figDir, CreateIntermediateDirectories -> True]];

kappaB[th_, kB_, tB_, t1_, t2_] := If[th <= tB, kB (tB/th)^t1, kB (tB/th)^t2];
alphaIn[th_, kB_, tB_, t1_] := 2 kB tB^2/((2 - t1) th) (th/tB)^(2 - t1);
alphaOut[th_, kB_, tB_, t1_, t2_] := 2 kB tB^2/th (1/(2 - t1) + ((th/tB)^(2 - t2) - 1)/(2 - t2));

(* --- 0. slope convention t = g - 1 --- *)
check["0a  rho ~ r^-g projects to kappa ~ theta^-(g-1): convergence slope t = g - 1 (g=3/2 -> t=1/2)",
  FullSimplify[-th D[Log[(3 - g)/2 (thE/th)^(g - 1)], th] == g - 1, Assumptions -> th > 0 && thE > 0 && 1 < g < 3] &&
  (3/2 - 1 === 1/2)];
check["0b  finite central enclosed mass needs t < 2 (g < 3): Int_0 x^(1-t) dx converges iff t < 2",
  Integrate[x^(1 - t), {x, 0, 1}, Assumptions -> t < 2] === 1/(2 - t)];

(* --- 1. deflection by direct integration --- *)
check["1a  inner branch (th <= tB) = (2/th) Int_0^th kappa x dx",
  FullSimplify[alphaIn[th, kB, tB, t1] == 2/th Integrate[kB (tB/x)^t1 x, {x, 0, th}, Assumptions -> 0 < th && t1 < 2],
    Assumptions -> 0 < th < tB && 0 < t1 < 2 && kB > 0]];
check["1b  outer branch (th > tB) = (2/th)[Int_0^tB + Int_tB^th]",
  FullSimplify[alphaOut[th, kB, tB, t1, t2] ==
    2/th (Integrate[kB (tB/x)^t1 x, {x, 0, tB}, Assumptions -> tB > 0 && t1 < 2] +
          Integrate[kB (tB/x)^t2 x, {x, tB, th}, Assumptions -> 0 < tB < th]),
    Assumptions -> 0 < tB < th && 0 < t1 < 2 && 0 < t2 < 2 && kB > 0]];
check["1c  kappa recovered from each branch by 1/(2 th) d/dth[th alpha]",
  FullSimplify[1/(2 th) D[th alphaIn[th, kB, tB, t1], th] == kB (tB/th)^t1, Assumptions -> th > 0 && tB > 0] &&
  FullSimplify[1/(2 th) D[th alphaOut[th, kB, tB, t1, t2], th] == kB (tB/th)^t2, Assumptions -> th > 0 && tB > 0]];

(* --- 2. continuity, reductions --- *)
check["2a  continuity at the break: both branches give 2 kB tB/(2 - t1)",
  FullSimplify[alphaIn[tB, kB, tB, t1] == alphaOut[tB, kB, tB, t1, t2] == 2 kB tB/(2 - t1),
    Assumptions -> tB > 0 && kB > 0 && t1 < 2 && t2 < 2]];
check["2b  d alpha/d th is continuous at tB (kappa is continuous), so lambda_r has no jump",
  FullSimplify[(D[alphaIn[th, kB, tB, t1], th] - D[alphaOut[th, kB, tB, t1, t2], th]) /. th -> tB,
    Assumptions -> tB > 0 && t1 < 2 && t2 < 2] === 0];
check["2c  t1 = t2 = t: outer branch -> pure power law 2 kB tB^t th^(1-t)/(2-t)",
  FullSimplify[alphaOut[th, kB, tB, t, t] == 2 kB tB^t th^(1 - t)/(2 - t),
    Assumptions -> 0 < tB < th && 0 < t < 2 && kB > 0]];
check["2d  pure-PL normalisation: 2 kB tB^t/(2-t) = thE^t reproduces alpha = thE^(g-1) th^(2-g), t = g-1",
  FullSimplify[(2 kB tB^t th^(1 - t)/(2 - t) /. kB -> (2 - t) thE^t/(2 tB^t)) == thE^(g - 1) th^(2 - g) /. t -> g - 1,
    Assumptions -> th > 0 && thE > 0 && tB > 0 && 1 < g < 3]];
check["2e  SIS limit t1 = t2 = 1: alpha = 2 kB tB (constant) inside and outside",
  FullSimplify[alphaOut[th, kB, tB, 1, 1] == 2 kB tB, Assumptions -> 0 < tB < th] &&
  FullSimplify[alphaIn[th, kB, tB, 1] == 2 kB tB, Assumptions -> 0 < th < tB]];
check["2f  SIS outside (t2 = 1): alpha = 2 kB tB + 2 kB tB^2 (t1-1)/(2-t1) / th  (SIS + point mass)",
  FullSimplify[alphaOut[th, kB, tB, t1, 1] == 2 kB tB + 2 kB tB^2 (t1 - 1)/((2 - t1) th),
    Assumptions -> 0 < tB < th && t1 < 2]];

(* --- 3. normalisation by the Einstein condition --- *)
kBsol = kB /. First@Solve[alphaOut[thE, kB, nu thE, t1, t2] == thE, kB];
kBclaim = (2 - t1)/(2 nu^2 (1 + (2 - t1)/(2 - t2) (nu^(t2 - 2) - 1)));
check["3a  Einstein condition alpha(thE) = thE  ->  kB = (2-t1)/(2 nu^2 [1 + Dt (nu^(t2-2) - 1)])",
  FullSimplify[kBsol == kBclaim, Assumptions -> 0 < nu < 1 && thE > 0 && 0 < t1 < 2 && 0 < t2 < 2]];
check["3b  t1 = t2 = t: kB = (2-t)/2 nu^-t, i.e. kappa(thE) = kB nu^t = (2-t)/2 = (3-g)/2",
  FullSimplify[(kBclaim /. {t1 -> t, t2 -> t}) == (2 - t)/2 nu^-t, Assumptions -> 0 < nu < 1 && 0 < t < 2] &&
  FullSimplify[((2 - t)/2 nu^-t) nu^t == (3 - g)/2 /. t -> g - 1, Assumptions -> nu > 0]];
(* numeric: thE = 1, t1 = 1, t2 = 1/2, tB = 1/20 *)
kBn = kBclaim /. {nu -> 1/20, t1 -> 1, t2 -> 1/2};
check["3c  numeric: thE=1, t1=1, t2=1/2, tB=0.05 -> alpha(1) = 1",
  Simplify[alphaOut[1, kBn, 1/20, 1, 1/2]] === 1];

(* --- 4. point-mass corner --- *)
check["4a  inner branch: t1 -> 2 at fixed inner mass pi thBH^2 [kB = (2-t1) thBH^2/(2 tB^2)] -> thBH^2/th",
  FullSimplify[Limit[alphaIn[th, (2 - t1) thBH^2/(2 tB^2), tB, t1], t1 -> 2, Assumptions -> 0 < th < tB && thBH > 0] ==
    thBH^2/th, Assumptions -> 0 < th < tB && thBH > 0]];
check["4b  inner enclosed mass m2D(tB) = 2 pi kB tB^2/(2-t1) = pi thBH^2 by that choice of kB",
  FullSimplify[(2 Pi kB tB^2/(2 - t1) /. kB -> (2 - t1) thBH^2/(2 tB^2)) == Pi thBH^2]];
(* with tB FIXED the outer branch also dies (kB -> 0): the whole lens collapses to a point mass *)
check["4c  fixed tB: t1 -> 2 at fixed inner mass collapses the WHOLE lens to the point mass (outer PL -> 0)",
  FullSimplify[Limit[alphaOut[th, (2 - t1) thBH^2/(2 tB^2), tB, t1, t2], t1 -> 2,
      Assumptions -> 0 < tB < th && 0 < t2 < 2 && thBH > 0] == thBH^2/th,
    Assumptions -> 0 < tB < th && 0 < t2 < 2 && thBH > 0]];
(* joint limit: hold the outer power law (K = kB tB^t2) AND the inner mass fixed -> tB -> 0 *)
tBjoint = ((2 - t1) thBH^2/(2 K))^(1/(2 - t2));
check["4d  joint limit: fixed K = kB tB^t2 and inner mass forces tB = [(2-t1) thBH^2/(2K)]^(1/(2-t2)) -> 0",
  FullSimplify[PowerExpand[((2 - t1) thBH^2/(2 tB^2)) tB^t2 /. tB -> tBjoint] == K,
    Assumptions -> 0 < t2 < 2 && t1 < 2 && K > 0 && thBH > 0] &&
  Limit[tBjoint, t1 -> 2, Direction -> "FromBelow", Assumptions -> 0 < t2 < 2 && K > 0 && thBH > 0] === 0];
alphaJoint = alphaOut[th, K tB^-t2, tB, t1, t2] /. tB -> tBjoint;
check["4e  joint limit t1 -> 2: alpha -> 2K th^(1-t2)/(2-t2) + thBH^2/th  (outer PL + point mass)",
  FullSimplify[Limit[PowerExpand[alphaJoint], t1 -> 2, Direction -> "FromBelow",
      Assumptions -> th > 0 && 0 < t2 < 2 && K > 0 && thBH > 0] ==
    2 K th^(1 - t2)/(2 - t2) + thBH^2/th, Assumptions -> th > 0 && 0 < t2 < 2 && K > 0 && thBH > 0]];
check["4f  Meneghetti Remark 5.3 in this language: t -> 2 (g -> 3) is the point mass, m(x) = const",
  Simplify[(x^(3 - g) /. g -> 3)] === 1];
(* fix pass 2026-10-14 (reconciler N-3): how small the break must be along the joint limit.
   Outer power law of Einstein radius thE = 1: 2K/(2-t2) = thE^t2 -> K = (2-t2)/2;
   point mass m = thBH^2/thE^2 = 0.01. *)
tBnum[epsv_, t2v_, mv_] := N[tBjoint /. {t1 -> 2 - epsv, t2 -> t2v, K -> (2 - t2v)/2, thBH -> Sqrt[mv]}, 20];
Print["       joint-limit break radius tB/thE (m = 0.01, t2 = 0.5): 2-t1 = 0.1 -> ", tBnum[1/10, 1/2, 1/100],
  "; 2-t1 = 1 -> ", tBnum[1, 1/2, 1/100]];
check["4g  joint limit, m = 0.01, t2 = 0.5, K = (2-t2)/2 (outer thE = 1): tB = 0.0076 thE at 2-t1 = 0.1, 0.035 thE at 2-t1 = 1",
  Abs[tBnum[1/10, 1/2, 1/100] - 0.0076] < 5*^-5 && Abs[tBnum[1, 1/2, 1/100] - 0.0354] < 5*^-4];

(* --- 5. outside-the-break identity --- *)
alphaPLsame[th_, kB_, tB_, t2_] := 2 kB tB^t2 th^(1 - t2)/(2 - t2);
thEff2 = 2 kB tB^2 (t1 - t2)/((2 - t1) (2 - t2));
check["5a  th > tB: alpha_bPL = alpha_PL(same t2, same kB tB^t2) + theta_eff^2/th  (exact identity)",
  FullSimplify[alphaOut[th, kB, tB, t1, t2] == alphaPLsame[th, kB, tB, t2] + thEff2/th,
    Assumptions -> 0 < tB < th && 0 < t1 < 2 && 0 < t2 < 2 && kB > 0]];
check["5b  enclosed-mass difference is the constant 2 pi kB tB^2 (t1-t2)/((2-t1)(2-t2))",
  FullSimplify[Pi th (alphaOut[th, kB, tB, t1, t2] - alphaPLsame[th, kB, tB, t2]) ==
    2 Pi kB tB^2 (t1 - t2)/((2 - t1) (2 - t2)), Assumptions -> 0 < tB < th && t1 < 2 && t2 < 2]];
check["5c  sign(theta_eff^2) = sign(t1 - t2): steeper cusp = positive mass, core = mass deficit",
  FullSimplify[Sign[thEff2] == Sign[t1 - t2], Assumptions -> 0 < t1 < 2 && 0 < t2 < 2 && kB > 0 && tB > 0]];
thBH2 = 2 kB tB^2/(2 - t1);
check["5d  theta_eff^2 / thBH^2 = (t1 - t2)/(2 - t2), thBH^2 = total inner mass / pi",
  FullSimplify[thEff2/thBH2 == (t1 - t2)/(2 - t2), Assumptions -> 0 < t1 < 2 && 0 < t2 < 2 && kB > 0 && tB > 0]];
check["5e  theta_eff^2/thBH^2 -> 1 only as t1 -> 2 (and = 0 at t1 = t2)",
  Limit[(t1 - t2)/(2 - t2), t1 -> 2] === 1 && ((t1 - t2)/(2 - t2) /. t1 -> t2) === 0];
check["5f  th > tB: lambda_r(bPL) = lambda_r(PL) + theta_eff^2/th^2 (same algebra as PL + point mass)",
  FullSimplify[(1 - D[alphaOut[th, kB, tB, t1, t2], th]) ==
    (1 - D[alphaPLsame[th, kB, tB, t2], th]) + thEff2/th^2, Assumptions -> 0 < tB < th && t1 < 2 && t2 < 2]];
check["5g  same for lambda_t: lambda_t(bPL) = lambda_t(PL) - theta_eff^2/th^2",
  FullSimplify[(1 - alphaOut[th, kB, tB, t1, t2]/th) ==
    (1 - alphaPLsame[th, kB, tB, t2]/th) - thEff2/th^2, Assumptions -> 0 < tB < th && t1 < 2 && t2 < 2]];

(* --- 6. inside the break --- *)
innerRatio = FullSimplify[alphaIn[th, kB, tB, t1]/(thBH2/th), Assumptions -> 0 < th < tB && 0 < t1 < 2 && kB > 0];
check["6a  th <= tB: alpha_bPL / alpha_PM(same inner mass) = (th/tB)^(2-t1)",
  FullSimplify[innerRatio == (th/tB)^(2 - t1), Assumptions -> 0 < th < tB && 0 < t1 < 2 && kB > 0]];
check["6b  t1 -> 2: the ratio is 1 at every radius (bPL inner branch IS the point mass)",
  Limit[(th/tB)^(2 - t1), t1 -> 2] === 1];
check["6c  ratio at th = tB/2 is 2^(t1-2), equal to 1 only at t1 = 2",
  FullSimplify[((tB/2)/tB)^(2 - t1) == 2^(t1 - 2), Assumptions -> tB > 0] &&
  Reduce[2^(t1 - 2) == 1 && 0 < t1 <= 2, t1] === (t1 == 2)];
dev = 1 - (th/tB)^eps;
ser = Normal@Series[dev, {eps, 0, 2}];
check["6d  1 - (th/tB)^eps = eps ln(tB/th) + O(eps^2), eps = 2 - t1  (logarithmic, linear in eps)",
  FullSimplify[Coefficient[ser, eps, 1] == Log[tB/th], Assumptions -> 0 < th < tB] &&
  (Coefficient[ser, eps, 0] === 0)];
(* how far inside tB must one look to see a fractional difference delta?  th/tB = (1-delta)^(1/eps) *)
check["6e  fractional difference delta is reached at th/tB = (1 - delta)^(1/(2 - t1))",
  FullSimplify[(1 - ((1 - delta)^(1/eps))^eps) == delta, Assumptions -> 0 < delta < 1 && eps > 0]];
check["6f  numeric: eps = 1, delta = 0.1 -> th = 0.9 tB; eps = 0.1, delta = 0.1 -> th = 0.349 tB",
  (1 - 1/10)^(1/1) === 9/10 && Abs[N[(9/10)^(10)] - 0.3487] < 1*^-4];
(* fix pass 2026-10-14 (reconciler N-1): the deviation is the POWER LAW 1 - (th/tB)^eps;
   it is logarithmic in radius only while eps ln(tB/th) << 1.  At eps = 1 it is linear in th,
   and the log form exceeds 1 (impossible for a fractional deficit) by th = tB/10. *)
check["6g  eps = 1: exact deviation 1 - th/tB (linear in th); log form ln(tB/th) = 2.30 > 1 at th = tB/10 vs exact 0.9",
  Simplify[(1 - (th/tB)^eps) /. eps -> 1] === 1 - th/tB &&
  N[1 Log[10]] > 1 && (1 - (1/10)^1) === 9/10 && N[Log[10]] - 9/10 > 1];
check["6h  eps ln(tB/th) << 1: log form within 4% of exact (eps = 0.1, th = tB/2), but 2x off at eps = 1, th = tB/10",
  Abs[N[(1/10) Log[2]/(1 - (1/2)^(1/10))] - 1] < 0.04 && N[Log[10]/(1 - 1/10)] > 2];
(* reconciler N-2: t1 = 2 itself is not a member: the inner mass diverges logarithmically *)
check["6i  t1 = 2 exactly: inner mass 2 pi Int_e^tB kB (tB/x)^2 x dx = 2 pi kB tB^2 ln(tB/e) -> Infinity as e -> 0",
  FullSimplify[2 Pi Integrate[kB (tB/x)^2 x, {x, e, tB}, Assumptions -> 0 < e < tB] == 2 Pi kB tB^2 Log[tB/e],
    Assumptions -> 0 < e < tB] &&
  Limit[2 Pi kB tB^2 Log[tB/e], e -> 0, Direction -> "FromAbove", Assumptions -> kB > 0 && tB > 0] === Infinity];

(* --- 7. figure: alpha(theta) broken PL vs pure PL --- *)
thEv = 1; t2v = 1/2; tBv = 1/10;
alphaPure[th_] := thEv^(t2v) th^(1 - t2v);                  (* g = 3/2 power law, Einstein radius 1 *)
mkB[t1v_] := kBclaim /. {nu -> tBv/thEv, t1 -> t1v, t2 -> t2v};
alphaBPL[th_, t1v_] := If[th <= tBv, alphaIn[th, mkB[t1v], tBv, t1v], alphaOut[th, mkB[t1v], tBv, t1v, t2v]];
alphaPLpm[th_, t1v_] := alphaPLsame[th, mkB[t1v], tBv, t2v] + (thEff2 /. {kB -> mkB[t1v], tB -> tBv, t1 -> t1v, t2 -> t2v})/th;
check["7a  figure models obey the Einstein condition alpha(thE) = thE (t1 = 1.5, 0)",
  Abs[N[alphaBPL[1, 3/2]] - 1] < 1*^-12 && Abs[N[alphaBPL[1, 0]] - 1] < 1*^-12];
check["7b  figure: outside tB the bPL curve coincides with PL + theta_eff^2/th (t1 = 1.5, th = 0.3)",
  Abs[N[alphaBPL[3/10, 3/2] - alphaPLpm[3/10, 3/2]]] < 1*^-12];
cB = {Black, RGBColor[0.8, 0.1, 0.1], RGBColor[0.2, 0.4, 0.8]};
fig2 = LogLogPlot[{alphaPure[th], alphaBPL[th, 3/2], alphaBPL[th, 0], alphaPLpm[th, 3/2], alphaPLpm[th, 0]},
   {th, 0.005, 3}, PlotRange -> {0.02, 3},
   PlotStyle -> {{Black, Thick}, {cB[[2]], Thick}, {cB[[3]], Thick}, {cB[[2]], Dashed}, {cB[[3]], Dashed}},
   Frame -> True, FrameLabel -> {Row[{"\[Theta] / ", Subscript["\[Theta]", "E"]}], Row[{"\[Alpha](\[Theta]) / ", Subscript["\[Theta]", "E"]}]},
   PlotLegends -> Placed[LineLegend[{
       Row[{"pure power law, ", Subscript["t", "1"], " = ", Subscript["t", "2"], " = 0.5"}],
       Row[{"broken, ", Subscript["t", "1"], " = 1.5 (cusp)"}],
       Row[{"broken, ", Subscript["t", "1"], " = 0 (core)"}],
       Row[{"PL + ", Superscript[Subscript["\[Theta]", "eff"], "2"], "/\[Theta]  (cusp)"}],
       Row[{"PL + ", Superscript[Subscript["\[Theta]", "eff"], "2"], "/\[Theta]  (core)"}]}], {Right, Bottom}],
   GridLines -> {{tBv, 1}, None}, GridLinesStyle -> Directive[Gray, Dotted], ImageSize -> 480];
Export[FileNameJoin[{figDir, "broken_pl_deflection.pdf"}], fig2];
check["7c  figure broken_pl_deflection.pdf exported", FileExistsQ[FileNameJoin[{figDir, "broken_pl_deflection.pdf"}]]];

summary[];
