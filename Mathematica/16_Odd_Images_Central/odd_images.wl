(* =========================================================================
   odd_images.wl
   Module 16: Odd Images, Central Images, and Their Suppression
   =========================================================================
   Purpose: Symbolic and numerical verification of every result in
            Notes/16_Odd_Images_Central/16_Odd_Images_Central.tex:
              A  grad tau = 0 is the lens equation; Hess tau = A; a maximum
                 of tau needs kappa > 1 + |gamma|
              B  NIS potential, lens equation as a cubic; NIS + point mass
                 lens equation as a quartic
              C  Morse counting for the NIS on a grid of sources: N in {1,3},
                 types {min} or {min, saddle, max}, sum sgn det A = 1,
                 central image arrives last
              D  central-image magnification of the NIS vs core radius
              E  point mass: lambda_r = 1 + thBH^2/theta^2 > 0, exactly two
                 images, index +1 of the puncture
              F  SIS: index of the conical tip jumps at beta = thetaE
              G  power-law cusp: central-image magnification scaling
              H  NIS + central point mass: even counts, closed-form critical
                 mass, central image removed above it (sign change of
                 min lambda_r), small-mass inner caustic
              I  Burke count n_+ - n_- = 1 for a smooth (cored elliptical) lens
            and exports the chapter figures.

   Sources: Schneider, Ehlers & Falco (1992) Sect. 5.4.1 (Theorem 1, index
              theorem, point-mass remark)
            Petters, Levine & Wambsganss (2001) Sect. 7.4, Thms 11.4-11.5
            Congdon & Keeton (2018) Sect. 6.2.2 (central images)
            Learning to Lens Module 6 (Fermat / Morse), Module 7 (NIS)

   Usage:   bash Mathematica/run_wl.sh Mathematica/16_Odd_Images_Central/odd_images.wl

   Outputs: PASS/FAIL per check, SUMMARY line, exit status;
            Figures/16_Odd_Images_Central/{arrival_time_nis_bh.pdf,
              central_mag_vs_core.pdf, central_image_phase.pdf}
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "harness.wl"}]];
Print["=== Module 16: Odd images, central images, suppression ===\n"];

figDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Figures",
                       "16_Odd_Images_Central"}];
If[!DirectoryQ[figDir], CreateDirectory[figDir, CreateIntermediateDirectories -> True]];

(* ---------------------------------------------------------------- *)
(* helpers: 1-D axisymmetric image finder and classifier             *)
(* signed theta on the line through lens and source; source y > 0   *)
(* ---------------------------------------------------------------- *)
type[lt_, lr_] := Which[lt > 0 && lr > 0, "min", lt < 0 && lr < 0, "max", True, "saddle"];
sgn[lt_, lr_] := Sign[lt lr];

(* NIS (+ optional point mass u = thBH^2), thetaE = tE *)
alNIS[t_, tE_, tc_] := tE (Sqrt[t^2 + tc^2] - tc)/t;
alTot[t_, tE_, tc_, u_] := alNIS[t, tE, tc] + u/t;
(* exact image finder: tE*s = t^2 - y t - u + tE tc, squared -> quartic *)
imagesNISBH[tE_, tc_, u_, y_] := Module[{t, sols},
  sols = t /. NSolve[(t^2 - y t - u + tE tc)^2 - tE^2 (t^2 + tc^2) == 0, t, Reals,
                     WorkingPrecision -> 40];
  sols = Select[sols, # != 0 && (#^2 - y # - u + tE tc) > 0 &];
  sols = Select[sols, Abs[# - alTot[#, tE, tc, u] - y] < 10^-20 &];
  Sort[N[sols, 20]]];
lamT[t_, tE_, tc_, u_] := 1 - alTot[t, tE, tc, u]/t;
lamR[t_, tE_, tc_, u_] := 1 - (D[alTot[x, tE, tc, u], x] /. x -> t);
classifyNISBH[tE_, tc_, u_, y_] := Module[{ims = imagesNISBH[tE, tc, u, y]},
  {#, type[lamT[#, tE, tc, u], lamR[#, tE, tc, u]],
      sgn[lamT[#, tE, tc, u], lamR[#, tE, tc, u]],
      1/(lamT[#, tE, tc, u] lamR[#, tE, tc, u])} & /@ ims];

(* winding number of a planar vector field F[{x,y}] around a circle *)
winding[F_, c_, r_, n_: 4000] := Module[{ang, d},
  ang = Table[Arg[Complex @@ F[c + r {Cos[p], Sin[p]}]], {p, 0., 2 Pi, 2 Pi/n}];
  d = Differences[ang]; d = Mod[d + Pi, 2 Pi] - Pi;
  Round[Total[d]/(2 Pi)]];

(* ================================================================= *)
Print["--- A. Fermat's principle: gradient and Hessian ---"];
(* ================================================================= *)
tau = (1/2) ((t1 - b1)^2 + (t2 - b2)^2) - f[t1, t2];
gradTau = {D[tau, t1], D[tau, t2]};
check["A.1 grad tau = (theta - beta) - grad psi  [generic psi]",
  FullSimplify[gradTau == {t1 - b1, t2 - b2} - {D[f[t1, t2], t1], D[f[t1, t2], t2]}]];
check["A.2 Solve[grad tau == 0, beta] gives beta = theta - grad psi (lens equation)",
  FullSimplify[({b1, b2} /. First@Solve[gradTau == {0, 0}, {b1, b2}]) ==
    {t1, t2} - {D[f[t1, t2], t1], D[f[t1, t2], t2]}]];
hessTau = D[tau, {{t1, t2}, 2}];
check["A.3 Hess tau = I - Hess psi = A (Jacobian of beta(theta))",
  FullSimplify[hessTau == D[{t1, t2} - {D[f[t1, t2], t1], D[f[t1, t2], t2]}, {{t1, t2}}]]];
check["A.4 tr Hess tau = 2 - Laplacian psi = 2(1 - kappa)",
  FullSimplify[Tr[hessTau] == 2 - (D[f[t1, t2], {t1, 2}] + D[f[t1, t2], {t2, 2}])]];
Amat = {{1 - k - g1, -g2}, {-g2, 1 - k + g1}};
check["A.5 eigenvalues of A are 1 - kappa -/+ |gamma|",
  Sort[Eigenvalues[Amat]] === Sort[{1 - k - Sqrt[g1^2 + g2^2], 1 - k + Sqrt[g1^2 + g2^2]}]];
check["A.6 both eigenvalues < 0 (maximum)  <=>  kappa > 1 + |gamma|",
  Resolve[ForAll[{k, g}, g >= 0, ((1 - k - g < 0 && 1 - k + g < 0) \[Equivalent] (k > 1 + g))], Reals]];
check["A.8 minimum <=> kappa < 1 - |gamma|; saddle <=> |1 - kappa| < |gamma|",
  Resolve[ForAll[{k, g}, g >= 0, ((1 - k - g > 0 && 1 - k + g > 0) \[Equivalent] (k < 1 - g)) &&
    (((1 - k - g) (1 - k + g) < 0) \[Equivalent] (Abs[1 - k] < g))], Reals]];
check["A.7 det A = (1-kappa)^2 - |gamma|^2; a maximum has det A > 0 and tr A < 0",
  Simplify[Det[Amat] == (1 - k)^2 - g1^2 - g2^2]];

(* ================================================================= *)
Print["\n--- B. NIS potential and polynomial form of the lens equation ---"];
(* ================================================================= *)
assm = tE > 0 && tc > 0 && t > 0;
psiNIS[t_] := tE (Sqrt[t^2 + tc^2] - tc Log[tc + Sqrt[t^2 + tc^2]]);
check["B.1 d psi_NIS/d theta = alpha_NIS = tE (s - tc)/theta",
  FullSimplify[D[psiNIS[t], t] == tE (Sqrt[t^2 + tc^2] - tc)/t, assm]];
check["B.2 kappa = (1/2) Lap psi = tE/(2 Sqrt[theta^2 + tc^2])",
  FullSimplify[(1/2) (1/t) D[t D[psiNIS[t], t], t] == tE/(2 Sqrt[t^2 + tc^2]), assm]];
check["B.3 alpha_NIS from 2/theta Int kappa theta' dtheta'",
  FullSimplify[(2/t) Integrate[x tE/(2 Sqrt[x^2 + tc^2]), {x, 0, t}, Assumptions -> assm] ==
    tE (Sqrt[t^2 + tc^2] - tc)/t, assm]];
(* lens equation y = t - alpha_NIS - u/t ; multiply by t *)
polyQ = Expand[(t^2 - y t - u + tE tc)^2 - tE^2 (t^2 + tc^2)];
check["B.4 NIS+point-mass lens equation squares to a quartic in theta",
  Exponent[polyQ, t] == 4];
check["B.5 for u = 0 the quartic = theta * cubic (theta = 0 spurious): NIS has <= 3 images",
  Module[{p0 = polyQ /. u -> 0}, (p0 /. t -> 0) === 0 && Exponent[Cancel[p0/t], t] == 3]];
check["B.6 the cubic is theta^3 - 2y theta^2 + (y^2 + 2 tE tc - tE^2) theta - 2 y tE tc",
  Simplify[Cancel[(polyQ /. u -> 0)/t] ==
    t^3 - 2 y t^2 + (y^2 + 2 tE tc - tE^2) t - 2 y tE tc]];

(* ================================================================= *)
Print["\n--- C. Morse counting for the NIS on a source grid ---"];
(* ================================================================= *)
tE0 = 1; tc0 = 1/5;
thetaR = t /. FindRoot[lamR[t, tE0, tc0, 0] == 0, {t, 0.3}, WorkingPrecision -> 30];
yR = -(thetaR - alTot[thetaR, tE0, tc0, 0]);
Print["  NIS tc = 0.2: radial critical radius ", N[thetaR, 6], ", radial caustic y_r = ", N[yR, 6]];
check["C.1 NIS (tc = 0.2 tE) radial critical curve at theta_r = 0.2972, caustic y_r = 0.2352",
  Abs[thetaR - 0.29723] < 10^-4 && Abs[yR - 0.23520] < 10^-4];
radialNIS[tEv_, tcv_] := Module[{sr = (-tcv + Sqrt[tcv^2 + 4 tEv tcv])/2, tr},
  tr = Sqrt[sr^2 - tcv^2]; {tr, Abs[tr - alNIS[tr, tEv, tcv]]}];
check["C.9 closed-form radial critical curve s_r = (-tc + Sqrt[tc^2 + 4 tE tc])/2 matches FindRoot (tc = 0.2)",
  Abs[radialNIS[1, 1/5][[1]] - thetaR] < 10^-12 && Abs[radialNIS[1, 1/5][[2]] - yR] < 10^-12];
check["C.9b tc = 0.1: theta_r = 0.2510, y_r = 0.4270; and s_r solves s^2 + tc s - tE tc = 0",
  Abs[N[radialNIS[1, 1/10][[1]]] - 0.25097] < 10^-4 && Abs[N[radialNIS[1, 1/10][[2]]] - 0.42704] < 10^-4 &&
  Simplify[((-tc + Sqrt[tc^2 + 4 tE tc])/2)^2 + tc (-tc + Sqrt[tc^2 + 4 tE tc])/2 - tE tc] == 0];
grid = Table[yy, {yy, 1/100, 3/2, 1/100}];
gridOK = Select[grid, Abs[# - yR] > 10^-3 &];
resC = classifyNISBH[tE0, tc0, 0, #] & /@ gridOK;
counts = Length /@ resC;
check["C.2 NIS image counts on 149 grid sources are all in {1, 3}",
  Union[counts] === {1, 3}];
check["C.3 N = 3 exactly when y < y_r (inside radial caustic), N = 1 outside",
  And @@ MapThread[If[#1 < yR, #2 == 3, #2 == 1] &, {gridOK, counts}]];
check["C.4 every 3-image config is {min, saddle, max}; every 1-image config is {min}",
  And @@ (Sort[#[[All, 2]]] === If[Length[#] == 3, {"max", "min", "saddle"}, {"min"}] & /@ resC)];
check["C.5 sum of sgn det A over images = +1 for every grid source (Burke/index)",
  And @@ (Total[#[[All, 3]]] == 1 & /@ resC)];
check["C.6 the maximum lies on the far side, inside the radial critical curve",
  And @@ (Function[r, With[{mx = Select[r, #[[2]] == "max" &]},
    mx === {} || (-thetaR < mx[[1, 1]] < 0)]] /@ resC)];
tauNIS[t_, y_] := (1/2) (t - y)^2 - (psiNIS[Abs[t]] /. {tE -> tE0, tc -> tc0});
check["C.7 arrival order for y = 0.1: tau(min) < tau(saddle) < tau(max)",
  Module[{r = classifyNISBH[tE0, tc0, 0, 1/10], tv},
    tv = Association[#[[2]] -> tauNIS[#[[1]], 1/10] & /@ r];
    tv["min"] < tv["saddle"] < tv["max"]]];
check["C.8 the saddle and maximum merge at y -> y_r (separation -> 0)",
  Module[{r = classifyNISBH[tE0, tc0, 0, yR - 10^-6]},
    Abs[Select[r, #[[2]] == "max" &][[1, 1]] - Select[r, #[[2]] == "saddle" &][[1, 1]]] < 0.01]];

(* ================================================================= *)
Print["\n--- D. Central-image magnification vs core radius ---"];
(* ================================================================= *)
k0 = Limit[tE/(2 Sqrt[t^2 + tc^2]), t -> 0];
lt0 = Limit[1 - alNIS[t, tE, tc]/t, t -> 0, Assumptions -> tc > 0 && tE > 0];
lr0 = Limit[1 - D[alNIS[t, tE, tc], t], t -> 0, Assumptions -> tc > 0 && tE > 0];
check["D.1 kappa_0 = tE/(2 tc)", FullSimplify[k0 == tE/(2 tc), tc > 0]];
check["D.2 lambda_t(0) = lambda_r(0) = 1 - kappa_0",
  FullSimplify[lt0 == 1 - tE/(2 tc) && lr0 == 1 - tE/(2 tc), tc > 0 && tE > 0]];
muC0 = 1/(lt0 lr0);
check["D.3 mu_c(y=0) = 1/(1 - kappa_0)^2 = 4 tc^2/(tE - 2 tc)^2",
  FullSimplify[muC0 == 4 tc^2/(tE - 2 tc)^2, tc > 0 && tE > 0]];
check["D.4 mu_c = 4 tc^2/tE^2 + 16 tc^3/tE^3 + O(tc^4)",
  Simplify[Normal[Series[muC0, {tc, 0, 3}]] == 4 tc^2/tE^2 + 16 tc^3/tE^3]];
check["D.5 mu_c -> 0 as tc -> 0 (SIS limit)", Limit[muC0, tc -> 0] === 0];
check["D.6 numbers (tE = 1): mu_c = 1/16 at tc = 0.1, 1/576 at tc = 0.02, 1/2401 at tc = 0.01",
  (muC0 /. {tE -> 1, tc -> 1/10}) == 1/16 && (muC0 /. {tE -> 1, tc -> 1/50}) == 1/576 &&
  (muC0 /. {tE -> 1, tc -> 1/100}) == 1/2401];
check["D.7 magnitude offsets: -2.5 log10 mu_c = 3.01 mag (tc = 0.1), 8.46 mag (tc = 0.01)",
  Abs[-2.5 Log10[1/16.] - 3.01] < 0.005 && Abs[-2.5 Log10[1/2401.] - 8.45] < 0.01];
(* off-axis: position and magnification of the central image for small y *)
check["D.8 small y: central image at theta ~ -y/(kappa_0 - 1) (tc=0.1: kappa_0=5, y=0.01 -> -0.0025)",
  Module[{r = classifyNISBH[1, 1/10, 0, 1/100]},
    Abs[Select[r, #[[2]] == "max" &][[1, 1]] - (-1/100/4)] < 2 10^-6]];
check["D.9 small y: mu of central image -> mu_c(0) = 1/16 (relative diff < 1e-3 at y = 0.01)",
  Module[{r = classifyNISBH[1, 1/10, 0, 1/100], m},
    m = Select[r, #[[2]] == "max" &][[1, 4]]; Abs[m/(1/16) - 1] < 10^-3]];
check["D.10 tc -> tE/2: kappa_0 -> 1, mu_c(0) diverges (radial critical curve shrinks to centre)",
  Limit[muC0 /. tE -> 1, tc -> 1/2, Direction -> "FromBelow"] === Infinity];
(* numerical central magnification at y = 0.05 for the figure, and check vs closed form *)
muCnum[tcv_, yv_] := Module[{r = classifyNISBH[1, tcv, 0, yv], mx},
  mx = Select[r, #[[2]] == "max" &]; If[mx === {}, Missing[], mx[[1, 4]]]];
check["D.11 numeric mu_c(y=0.05) within 3% of closed form for tc in {0.02,0.05,0.1}",
  And @@ (Abs[muCnum[#, 1/20]/(4 #^2/(1 - 2 #)^2) - 1] < 0.03 & /@ {1/50, 1/20, 1/10})];

(* ================================================================= *)
Print["\n--- E. Point mass: no central image ---"];
(* ================================================================= *)
alPM[t_] := ub/t;   (* ub = thBH^2 *)
check["E.1 point mass: lambda_r = 1 + thBH^2/theta^2 > 0 for all theta != 0",
  Simplify[1 - D[alPM[t], t] == 1 + ub/t^2] && Simplify[1 + ub/t^2 > 0, ub > 0 && t != 0 && Element[t, Reals]]];
check["E.2 point mass: lambda_t = 1 - thBH^2/theta^2 changes sign only at |theta| = thBH",
  Simplify[1 - alPM[t]/t == 1 - ub/t^2] && (Reduce[1 - ub/t^2 == 0 && ub > 0, t, Reals] ===
    (ub > 0 && (t == -Sqrt[ub] || t == Sqrt[ub])))];
pmImgs = Solve[t^2 - y t - ub == 0, t];
check["E.3 point mass: theta^2 - y theta - thBH^2 = 0 has exactly two real roots for every y",
  Length[pmImgs] == 2 && Simplify[Discriminant[t^2 - y t - ub, t] == y^2 + 4 ub]];
check["E.4 point mass grid (y in 0.01..3): one min (theta > thBH) and one saddle (theta < 0); sum sgn = 0",
  And @@ Table[Module[{tp = (yy + Sqrt[yy^2 + 4])/2, tm = (yy - Sqrt[yy^2 + 4])/2},
     type[1 - 1/tp^2, 1 + 1/tp^2] == "min" && type[1 - 1/tm^2, 1 + 1/tm^2] == "saddle" &&
     sgn[1 - 1/tp^2, 1 + 1/tp^2] + sgn[1 - 1/tm^2, 1 + 1/tm^2] == 0], {yy, 0.01, 3, 0.01}]];
gradTauPM[yv_][p_] := p - {yv, 0} - p/(p . p);
check["E.5 index of grad tau around the point-mass puncture = +1 (y = 0.3, 1.5)",
  winding[gradTauPM[0.3], {0, 0}, 0.02] == 1 && winding[gradTauPM[1.5], {0, 0}, 0.02] == 1];
check["E.6 index around a large circle = +1 (field asymptotically radial)",
  winding[gradTauPM[0.3], {0, 0}, 50] == 1];
check["E.7 tau -> +infinity at the puncture: -psi = -thBH^2 log theta",
  Limit[(1/2) t^2 - Log[t], t -> 0, Direction -> "FromAbove"] === Infinity];

(* ================================================================= *)
Print["\n--- F. SIS: the conical tip ---"];
(* ================================================================= *)
gradTauSIS[yv_][p_] := p - {yv, 0} - p/Sqrt[p . p];
check["F.1 SIS: index of grad tau around origin = +1 for y < tE (y = 0.5)",
  winding[gradTauSIS[0.5], {0, 0}, 10^-3] == 1];
check["F.2 SIS: index around origin = 0 for y > tE (y = 1.5)",
  winding[gradTauSIS[1.5], {0, 0}, 10^-3] == 0];
check["F.3 SIS image signs: y=0.5 -> {+1,-1} (sum 0); y=1.5 -> {+1} (sum 1); sum + tip index = 1",
  Module[{s05, s15},
    s05 = {Sign[1 - 1/1.5], Sign[1 - 1/0.5]};    (* images at 1.5 and -0.5: mu = 1/(1 - 1/|theta|) *)
    s15 = {Sign[1 - 1/2.5]};
    Total[s05] + 1 == 1 && Total[s15] + 0 == 1]];
check["F.4 SIS: tau near origin ~ -tE |theta| (cone, not differentiable at 0)",
  Limit[D[-Sqrt[x^2], x], x -> 0, Direction -> "FromAbove"] == -1 &&
  Limit[D[-Sqrt[x^2], x], x -> 0, Direction -> "FromBelow"] == 1];

(* ================================================================= *)
Print["\n--- G. Steep cusps: power-law central image ---"];
(* ================================================================= *)
(* kappa = (3-g)/2 theta^(1-g), alpha = sgn(theta) |theta|^(2-g), tE = 1, 1 < g < 2 *)
check["G.1 power law: (1/theta) d(theta alpha)/dtheta / 2 = (3-g)/2 theta^(1-g)",
  FullSimplify[(1/(2 t)) D[t t^(2 - gg), t] == (3 - gg)/2 t^(1 - gg), t > 0]];
check["G.2 counter side theta = -x: lambda_t lambda_r -> (2-g) x^(2(1-g)) as x -> 0 (1<g<2)",
  Simplify[Limit[((1 - x^(1 - gg)) (1 - (2 - gg) x^(1 - gg)))/((2 - gg) x^(2 (1 - gg))), x -> 0,
    Assumptions -> 1 < gg < 2, Direction -> "FromAbove"], 1 < gg < 2] == 1];
muPLexact[gg_?NumericQ, yv_?NumericQ] := Module[{xs, xc},
  xs = x /. NSolve[-x + x^(2 - gg) == yv && x > 0, x, Reals];
  xc = Min[xs];   (* innermost root = central image *)
  1/((1 - xc^(1 - gg)) (1 - (2 - gg) xc^(1 - gg)))];
muPLlead[gg_, yv_] := yv^(2 (gg - 1)/(2 - gg))/(2 - gg);
check["G.3 g' = 1.5: two counter-side roots for y = 0.1 (3 images total, odd)",
  Length[x /. NSolve[-x + x^(1/2) == 1/10 && x > 0, x, Reals]] == 2];
check["G.4 g' = 1.5, y = 0.1: exact mu_c = 0.0370; leading 2 y^2 = 0.02",
  Abs[muPLexact[1.5, 0.1] - 0.03696] < 10^-5 && muPLlead[1.5, 0.1] == 0.02];
check["G.5 leading-order law becomes exact as y -> 0 (ratio within 1% at y = 1e-4, g' = 1.5)",
  Abs[muPLexact[1.5, 10.^-4]/muPLlead[1.5, 10.^-4] - 1] < 0.01];
check["G.6 g' = 1.2, y = 0.1: no central image (source outside the radial caustic)",
  NSolve[-x + x^(0.8) == 0.1 && x > 0, x, Reals] === {}];
check["G.6b steepening suppresses: mu_c(y=0.1) decreases monotonically for g' = 1.3..1.9; 0.037 (1.5), 3.1e-3 (1.6), 7.5e-5 (1.7)",
  Abs[muPLexact[1.6, 0.1] - 0.003122] < 10^-6 && Abs[muPLexact[1.7, 0.1] - 0.0000749] < 10^-7 &&
  Module[{v = muPLexact[#, 0.1] & /@ Range[1.3, 1.9, 0.1]}, And @@ Thread[Differences[v] < 0]]];
check["G.7 g' = 1.8, y = 0.1: mu_c below 1e-7 (leading 5e-8)",
  muPLexact[1.8, 0.1] < 10^-7 && Abs[muPLlead[1.8, 0.1] - 5. 10^-8] < 10^-12];
check["G.8 exponent 2(g-1)/(2-g) -> infinity as g -> 2 (isothermal limit)",
  Limit[2 (gg - 1)/(2 - gg), gg -> 2, Direction -> "FromBelow"] === Infinity];

(* ================================================================= *)
Print["\n--- H. NIS + central point mass ---"];
(* ================================================================= *)
(* f(theta) = theta^2 lambda_r = theta^2 dy/dtheta *)
fH = Simplify[t^2 (1 - D[alNIS[t, tE, tc] + u/t, t]), assm];
check["H.1 theta^2 lambda_r = (s - tc)(s + tc - tE tc/s) + u,  s = Sqrt[theta^2 + tc^2]",
  FullSimplify[fH == (Sqrt[t^2 + tc^2] - tc) (Sqrt[t^2 + tc^2] + tc - tE tc/Sqrt[t^2 + tc^2]) + u, assm]];
hs = (s - tc) (s + tc - tE tc/s);
sStar = (tE tc^2/2)^(1/3);
check["H.2 dh/ds = 0 at s* = (tE tc^2/2)^(1/3)", FullSimplify[(D[hs, s] /. s -> sStar) == 0, tE > 0 && tc > 0]];
check["H.3 s* > tc  <=>  tc < tE/2 (minimum lies at theta > 0 iff the core is supercritical)",
  Reduce[sStar > tc && tE > 0 && tc > 0, tc, Reals] === Reduce[tc < tE/2 && tE > 0 && tc > 0, tc, Reals]];
uCrit = tc (tE + tc) - 3 (tE tc^2/2)^(2/3);
check["H.4 u_crit = -h(s*) = tc(tE + tc) - 3 (tE tc^2/2)^(2/3)",
  FullSimplify[-(hs /. s -> sStar) == uCrit, tE > 0 && tc > 0]];
check["H.5 u_crit -> 0 as tc -> tE/2", Simplify[uCrit /. tc -> tE/2, tE > 0] == 0];
check["H.6 u_crit = tE tc - 3 2^(-2/3) tE^(2/3) tc^(4/3) + tc^2 (small-core expansion is exact)",
  FullSimplify[uCrit == tE tc - 3 2^(-2/3) tE^(2/3) tc^(4/3) + tc^2, tE > 0 && tc > 0]];
check["H.6b u_crit/(tE tc) -> 1 as tc -> 0", Limit[uCrit/(tE tc), tc -> 0, Assumptions -> tE > 0] == 1];
uc01 = uCrit /. {tE -> 1, tc -> 1/10}; uc02 = uCrit /. {tE -> 1, tc -> 1/5};
check["H.7 tE=1: u_crit(0.1) = 0.02228 (thBH = 0.149), u_crit(0.2) = 0.01896 (thBH = 0.138)",
  Abs[N[uc01] - 0.022279] < 10^-5 && Abs[N[Sqrt[uc01]] - 0.1493] < 10^-3 &&
  Abs[N[uc02] - 0.018958] < 10^-5 && Abs[N[Sqrt[uc02]] - 0.1377] < 10^-3];
minLamR[tcv_, uv_] := Module[{tt}, First@NMinimize[{(1 - D[alNIS[tt, 1, tcv] + uv/tt, tt]), 0.001 < tt < 2}, tt]];
check["H.8 sign change: min_theta lambda_r < 0 at 0.95 u_crit, > 0 at 1.05 u_crit (tc = 0.1, 0.2)",
  minLamR[0.1, 0.95 N[uc01]] < 0 && minLamR[0.1, 1.05 N[uc01]] > 0 &&
  minLamR[0.2, 0.95 N[uc02]] < 0 && minLamR[0.2, 1.05 N[uc02]] > 0];
check["H.9 closed-form u_crit equals numerical -min f(theta) (tc = 0.1, 0.2, 0.3)",
  And @@ (Function[tcv, Abs[-First@NMinimize[{(fH /. {tE -> 1, tc -> tcv, u -> 0}), 0.001 < t < 3}, t] -
     N[uCrit /. {tE -> 1, tc -> tcv}]] < 10^-8] /@ {0.1, 0.2, 0.3})];
(* image counts on a (u, y) grid *)
ygrid = Range[1/50, 3/2, 1/50];
countsAt[tcv_, uv_] := (Length[classifyNISBH[1, tcv, uv, #]] & /@ ygrid);
signsAt[tcv_, uv_] := (Total[classifyNISBH[1, tcv, uv, #][[All, 3]]] & /@ ygrid);
check["H.10 tc=0.2, u = 0.3 u_crit: counts in {2,4}; sum sgn det A = 0 everywhere (n_+ - n_- = 1 - g, g = 1)",
  SubsetQ[{2, 4}, Union[countsAt[1/5, 3/10 uc02]]] && Union[signsAt[1/5, 3/10 uc02]] === {0}];
check["H.11 tc=0.2, u = 1.2 u_crit: exactly 2 images {min, saddle} for every source; no maximum",
  And @@ (Sort[classifyNISBH[1, 1/5, 6/5 uc02, #][[All, 2]]] === {"min", "saddle"} & /@ ygrid)];
check["H.12 tc=0.1, u = 1.05 u_crit: 2 images for every source on the grid",
  Union[countsAt[1/10, 105/100 uc01]] === {2}];
check["H.13 tc=0.2, u = 0.3 u_crit, y = 0.2: 4 images {min, saddle, max, saddle}",
  Sort[classifyNISBH[1, 1/5, 3/10 uc02, 1/5][[All, 2]]] === {"max", "min", "saddle", "saddle"}];
(* the inner caustic: y_in(u) = local min of y on the far side *)
yIn[tcv_, uv_] := Module[{r1}, r1 = tt /. FindRoot[(1 - D[alNIS[tt, 1, tcv] + uv/tt, tt]) == 0,
   {tt, Sqrt[uv/(1/(2 tcv) - 1)]}, WorkingPrecision -> 30];
   -r1 - alTot[-r1, 1, tcv, uv]];
check["H.14 small u: y_in -> 2 Sqrt[u (kappa_0 - 1)] (tc = 0.1, u = 1e-6: ratio within 1e-3)",
  Abs[yIn[1/10, 10^-6]/(2 Sqrt[10^-6 (5 - 1)]) - 1] < 10^-3];
check["H.15 central image absent for y < y_in, present just above (tc = 0.1, u = 1e-3)",
  Module[{yi = yIn[1/10, 1/1000]},
    FreeQ[classifyNISBH[1, 1/10, 1/1000, yi - 1/1000][[All, 2]], "max"] &&
    MemberQ[classifyNISBH[1, 1/10, 1/1000, yi + 1/1000][[All, 2]], "max"]]];
check["H.16 tc=0.1: u = 0.3 u_crit (thBH = 0.082) already removes the central image for y <= 0.30",
  And @@ (FreeQ[classifyNISBH[1, 1/10, 3/10 uc01, #][[All, 2]], "max"] & /@ Range[1/50, 3/10, 1/50])];
check["H.17 index around BH puncture inside NIS = +1 (tc = 0.2, u = 0.3 u_crit, y = 0.2)",
  winding[Function[p, p - {0.2, 0} - (alNIS[Norm[p], 1, 0.2] + N[3/10 uc02]/Norm[p]) p/Norm[p]], {0, 0}, 10^-3] == 1];

(* ================================================================= *)
Print["\n--- I. Burke count for a smooth non-axisymmetric lens ---"];
(* ================================================================= *)
(* softened elliptical potential psi = b Sqrt[s^2 + (1-e) x^2 + (1+e) y^2] *)
psiE[x_, y_] := Sqrt[(1/4)^2 + (7/10) x^2 + (13/10) y^2];
imgs2D[bx_, by_] := Module[{sol},
  sol = {x, y} /. NSolve[{x - D[psiE[x, y], x] == bx, y - D[psiE[x, y], y] == by}, {x, y}, Reals];
  {#, Module[{A = IdentityMatrix[2] - (D[psiE[u1, u2], {{u1, u2}, 2}] /. {u1 -> #[[1]], u2 -> #[[2]]}), ev},
     ev = Eigenvalues[A]; {type[ev[[1]], ev[[2]]], Sign[Det[A]]}]} & /@ sol];
srcs = {{0.05, 0.03}, {0.0, 0.12}, {0.2, 0.0}, {0.5, 0.4}, {1.5, 0.2}};
res2D = imgs2D @@@ srcs;
Print["  cored elliptical image counts: ", Length /@ res2D];
check["I.1 cored elliptical: every image count is odd", And @@ (OddQ[Length[#]] & /@ res2D)];
check["I.2 cored elliptical: n_+ - n_- = 1 for every source", And @@ (Total[#[[All, 2, 2]]] == 1 & /@ res2D)];
check["I.3 source (0.05, 0.03) gives 5 images: 2 min + 2 saddle + 1 max",
  Sort[Tally[res2D[[1, All, 2, 1]]]] === {{"max", 1}, {"min", 2}, {"saddle", 2}}];
check["I.4 distant source (1.5, 0.2) gives 1 image (a minimum)",
  res2D[[5, All, 2, 1]] === {"min"}];

(* ================================================================= *)
Print["\n--- Figures ---"];
(* ================================================================= *)
psiTot[{x_, y_}, tcv_, uv_] := Module[{r = Sqrt[x^2 + y^2]},
  (Sqrt[r^2 + tcv^2] - tcv Log[tcv + Sqrt[r^2 + tcv^2]]) + uv Log[r]];
tauFun[{x_, y_}, tcv_, uv_, yv_] := (1/2) ((x - yv)^2 + y^2) - psiTot[{x, y}, tcv, uv];
col[tp_] := Switch[tp, "min", Blue, "saddle", Red, "max", Darker[Green]];
mkPanel[uv_, ttl_, {{x0_, x1_}, {y0_, y1_}}, dlev_, ps_] := Module[{r = classifyNISBH[1, 1/5, uv, 1/5], lev},
  lev = Union[Join[N[tauFun[{#[[1]], 0}, 1/5, uv, 1/5]] & /@ r, Range[-0.6, 1.2, dlev]]];
  Show[
    ContourPlot[tauFun[{x, y}, 0.2, N[uv], 0.2], {x, x0, x1}, {y, y0, y1},
      Contours -> lev, ContourShading -> None, PlotPoints -> 90, MaxRecursion -> 2,
      ContourStyle -> Directive[GrayLevel[0.35], Thickness[0.0025]],
      FrameLabel -> {Subscript["\[Theta]", 1], Subscript["\[Theta]", 2]},
      PlotLabel -> ttl, AspectRatio -> 1],
    Graphics[{PointSize[ps], {col[#[[2]]], Point[{#[[1]], 0}]} & /@ r,
      If[uv > 0, {Black, PointSize[ps/2], Point[{0, 0}]}, {}],
      Black, Text[Style["\[Times]", 14, Bold], {0.2, 0}]}]]];
ttl1 = Row[{"NIS, ", Subscript["\[Theta]", "c"], " = 0.2"}];
ttl2 = Row[{"+ point mass, ", Superscript[Subscript["\[Theta]", "\[Bullet]"], 2], " = 0.3 ", Subscript["u", "crit"]}];
ttl3 = Row[{"+ point mass, ", Superscript[Subscript["\[Theta]", "\[Bullet]"], 2], " = 1.2 ", Subscript["u", "crit"]}];
big = {{-1.0, 1.4}, {-1.2, 1.2}}; zoom = {{-0.65, 0.15}, {-0.4, 0.4}};
fig1 = GraphicsGrid[{
   {mkPanel[0, ttl1, big, 0.04, 0.03], mkPanel[3/10 uc02, ttl2, big, 0.04, 0.03], mkPanel[6/5 uc02, ttl3, big, 0.04, 0.03]},
   {mkPanel[0, "zoom", zoom, 0.004, 0.03], mkPanel[3/10 uc02, "zoom", zoom, 0.004, 0.03], mkPanel[6/5 uc02, "zoom", zoom, 0.004, 0.03]}},
  ImageSize -> 1100, Spacings -> {10, 10}];
Export[FileNameJoin[{figDir, "arrival_time_nis_bh.pdf"}], fig1,
  "AllowRasterization" -> True, ImageResolution -> 150];
Print["  Exported arrival_time_nis_bh.pdf"];

tcs = Rationalize[Round[10^Range[-2.4, Log10[0.3], 0.1], 0.0001], 0];
numPts = Select[{N[#], muCnum[#, 1/10]} & /@ tcs, NumericQ[#[[2]]] &];
Print["  ratios mu_c(y=0.1)/closed form: ", {#[[1]], #[[2]]/(4 #[[1]]^2/(1 - 2 #[[1]])^2)} & /@ numPts];
check["FIG2 numerical mu_c(y = 0.1) points lie within 6% of the y = 0 closed form for tc <= 0.05 (ratio -> 1.042 as tc -> 0)",
  Length[numPts] >= 10 && And @@ (Abs[#[[2]]/(4 #[[1]]^2/(1 - 2 #[[1]])^2) - 1] < 0.06 & /@ Select[numPts, #[[1]] <= 0.05 &])];
fig2 = Show[
  LogLogPlot[{4 tcv^2/(1 - 2 tcv)^2, 4 tcv^2}, {tcv, 0.003, 0.45},
    PlotStyle -> {Directive[Black, Thick], Directive[Gray, Dashed]},
    Frame -> True, FrameLabel -> {Row[{Subscript["\[Theta]", "c"], " / ", Subscript["\[Theta]", "E"]}],
      Subscript["\[Mu]", "c"]},
    PlotLegends -> Placed[LineLegend[{Directive[Black, Thick], Directive[Gray, Dashed]},
      {Row[{"exact, \[Beta] = 0"}],
       Row[{"4", Superscript[Subscript["\[Theta]", "c"], 2], " / ", Superscript[Subscript["\[Theta]", "E"], 2]}]}], {0.3, 0.8}],
    ImageSize -> 520, PlotRange -> {10^-5, 20}],
  ListLogLogPlot[numPts, PlotStyle -> Directive[Red, PointSize[0.014]],
    PlotLegends -> Placed[PointLegend[{Red}, {Row[{"numerical, \[Beta] = 0.1 ", Subscript["\[Theta]", "E"]}]}], {0.3, 0.62}]]];
Export[FileNameJoin[{figDir, "central_mag_vs_core.pdf"}], fig2];
Print["  Exported central_mag_vs_core.pdf"];

(* phase diagram: critical radii from the cubic s^3 - (tc^2 + tE tc - u) s + tE tc^2 = 0, s > tc *)
check["H.18 critical radii: theta^2 lambda_r = 0  <=>  s^3 - (tc^2 + tE tc - u) s + tE tc^2 = 0",
  FullSimplify[s ((s - tc) (s + tc - tE tc/s) + u) == s^3 - (tc^2 + tE tc - u) s + tE tc^2]];
critR[tcv_, uv_] := Module[{ss},
  ss = Select[ss /. NSolve[ss^3 - (tcv^2 + tcv - uv) ss + tcv^2 == 0, ss, Reals], # > tcv &];
  Sort[Sqrt[#^2 - tcv^2] & /@ ss]];
causticsAt[tcv_, uv_] := Module[{rr = critR[tcv, uv]},
  If[Length[rr] == 2, Sort[(-# - alTot[-#, 1, tcv, uv]) & /@ rr], {}]];
check["H.19 tc = 0.1, u = 1e-3: two critical radii; far-side caustic values y_in < y_out both > 0",
  Module[{c = causticsAt[1/10, 1/1000]}, Length[c] == 2 && 0 < c[[1]] < c[[2]]]];
check["H.20 y_in from the cubic agrees with the FindRoot value (tc = 0.1, u = 1e-3)",
  Abs[causticsAt[1/10, 1/1000][[1]] - yIn[1/10, 1/1000]] < 10^-10];
phase[tcv_, ucv_] := Module[{dat},
  dat = Table[With[{c = causticsAt[tcv, uu]}, If[Length[c] == 2, {Sqrt[uu], c}, Nothing]],
    {uu, Join[ucv 10^Range[-6., -1, 0.25], Range[0.1 ucv, 0.9999 ucv, ucv/400]]}];
  {{#[[1]], #[[2, 1]]} & /@ dat, {#[[1]], #[[2, 2]]} & /@ dat}];
ph1 = phase[1/10, N[uc01]]; ph2 = phase[1/5, N[uc02]];
fig3 = ListLinePlot[{ph1[[1]], ph1[[2]], ph2[[1]], ph2[[2]]},
  PlotStyle -> {Directive[Blue, Thick], Directive[Blue, Thick, Dashed],
    Directive[Red, Thick], Directive[Red, Thick, Dashed]},
  Frame -> True, FrameLabel -> {Row[{Subscript["\[Theta]", "\[Bullet]"], " / ", Subscript["\[Theta]", "E"]}],
    Row[{"\[Beta] / ", Subscript["\[Theta]", "E"]}]},
  PlotLegends -> Placed[{Row[{"inner caustic, ", Subscript["\[Theta]", "c"], " = 0.1"}],
    Row[{"radial caustic, ", Subscript["\[Theta]", "c"], " = 0.1"}],
    Row[{"inner caustic, ", Subscript["\[Theta]", "c"], " = 0.2"}],
    Row[{"radial caustic, ", Subscript["\[Theta]", "c"], " = 0.2"}]}, {0.78, 0.2}],
  ImageSize -> 560, PlotRange -> {{0, 0.16}, {0, 0.7}}];
Export[FileNameJoin[{figDir, "central_image_phase.pdf"}], fig3];
Print["  Exported central_image_phase.pdf"];
check["FIG3 inner and radial caustics meet as thBH -> sqrt(u_crit) (gap < 0.01 at 0.9999 u_crit)",
  Abs[ph1[[2, -1, 2]] - ph1[[1, -1, 2]]] < 0.01 && Abs[ph2[[2, -1, 2]] - ph2[[1, -1, 2]]] < 0.01];
check["FIG3 radial caustic -> NIS value as thBH -> 0 (0.4270 for tc = 0.1, 0.2352 for tc = 0.2)",
  Abs[ph1[[2, 1, 2]] - 0.42704] < 10^-3 && Abs[ph2[[2, 1, 2]] - 0.23520] < 10^-3];
check["FIG figures exist", And @@ (FileExistsQ[FileNameJoin[{figDir, #}]] & /@
  {"arrival_time_nis_bh.pdf", "central_mag_vs_core.pdf", "central_image_phase.pdf"})];

summary[];
