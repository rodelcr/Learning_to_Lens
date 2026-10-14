(* =========================================================================
   problems_21.wl
   Module 21: First-Order Estimators and Multi-Plane Coherence --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to every exercise of the chapter, verified
            symbolically (FullSimplify / Solve / Limit / Resolve) and, where
            a number is quoted, numerically.

   Sources: Standard least-squares algebra (no specific reference);
            power-law deflection and radial eigenvalue as in the chapters
            "Galaxy Lensing Applications" and "Axisymmetric Lens Models".

   Usage:   bash Mathematica/run_wl.sh \
                 Solutions/21_Perturbative_Estimators/problems_21.wl

   Exercises solved:
     ex:pe_two_images      --- two images: c = (a1-a2)/(b1-b2), zero residual
     ex:pe_intercept       --- intercept invariance under a_j -> a_j + const
     ex:pe_radial_leverage --- radial-image leverage, asymptote, exact closed
                               form, gamma'=5/3 boundary, rho->1 floor, numbers
     ex:pe_sign_change     --- sign-change condition c2/c1 = B^-k
     ex:pe_coherence_limit --- r_i -> (gamma'-1) c1 and its reach
     ex:pe_design          --- precision vs accuracy: S under sigma -> sigma/2
                               and under adding a coherent plane
     ex:pe_mass_sheet      --- the same machinery for an omitted mass sheet

   Outputs: PASS/FAIL per check and a SUMMARY line (harness.wl).
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Mathematica", "harness.wl"}]];
Print["=== Module 21: SOLUTIONS ===\n"];

asm = 0 < rho < 1 && 1 < g < 2;
cExact = (3 + rho^(1 - g))/((g - 1) (3 + rho^(4 - 2 g)));
cAsym = rho^(1 - g)/(3 (g - 1));
kExp = (3 - g)/(g - 1);
cOf[aL_, bL_] := Total[(aL - Mean[aL]) (bL - Mean[bL])]/Total[(bL - Mean[bL])^2];

(* ---------------- Exercise: two images ---------------- *)
Print["--- ex:pe_two_images ---"];
sol2 = First@Solve[{m a1 - eps b1 - dy == 0, m a2 - eps b2 - dy == 0}, {eps, dy}];
check["1a  r1 = r2 = 0 solves to eps = m (a1-a2)/(b1-b2)",
  FullSimplify[(eps /. sol2) - m (a1 - a2)/(b1 - b2)] === 0];
check["1b  back-substitution: dy = m a1 - eps b1",
  FullSimplify[(dy /. sol2) - (m a1 - (eps /. sol2) b1)] === 0];
check["1c  two-image regression formula equals the difference quotient",
  FullSimplify[cOf[{a1, a2}, {b1, b2}] - (a1 - a2)/(b1 - b2)] === 0];
(* three images: minimum of the residual is generically non-zero, e.g. canonical triple *)
aT = {1, -1, 1/rho}; bT = (g - 1) {1, -1, rho^(2 - g)};
solT = First@Solve[{D[Total[(aT - cc bT - dd)^2], cc] == 0, D[Total[(aT - cc bT - dd)^2], dd] == 0}, {cc, dd}];
resMin = Total[(aT - cc bT - dd)^2] /. solT;
check["1d  three images (canonical, rho = 1/10, g = 3/2): minimum residual > 0",
  N[resMin /. {rho -> 1/10, g -> 3/2}] > 10^-3];
check["1e  a = 1/theta is in span{b, 1} only if the radial image sits at rho = 1",
  FullSimplify[(resMin /. rho -> 1) == 0, 1 < g < 2]];

(* ---------------- Exercise: intercept ---------------- *)
Print["\n--- ex:pe_intercept ---"];
aV = Array[aa, 4]; bV = Array[bb, 4]; wV = Array[ww, 4];
cw[aL_] := Module[{ab = Total[wV aL]/Total[wV], bb0 = Total[wV bV]/Total[wV]},
   Total[wV (aL - ab) (bV - bb0)]/Total[wV (bV - bb0)^2]];
check["2a  c_w invariant under a_j -> a_j + kappa (n = 4, general weights)",
  Simplify[cw[aV + kap] - cw[aV]] === 0];
solI[aL_] := First@Solve[{D[Total[(m aL - eps bV - dy)^2], eps] == 0,
     D[Total[(m aL - eps bV - dy)^2], dy] == 0}, {eps, dy}];
check["2b  the intercept absorbs the shift: dy -> dy + m kappa, eps unchanged",
  Simplify[(dy /. solI[aV + kap]) - (dy /. solI[aV]) - m kap] === 0 &&
  Simplify[(eps /. solI[aV + kap]) - (eps /. solI[aV])] === 0];
cFix = Total[aT bT]/Total[bT^2];
check["2c  with dy fixed to 0 the canonical-triple answer changes (rho = 1/10, g = 3/2)",
  N[(cFix - cExact) /. {rho -> 1/10, g -> 3/2}] != 0];

(* ---------------- Exercise: radial leverage ---------------- *)
Print["\n--- ex:pe_radial_leverage ---"];
cov = Total[(aT - Mean[aT]) (bT - Mean[bT])];
var = Total[(bT - Mean[bT])^2];
check["3a  Cov(a,b) = 2(g-1)[1 + rho^(1-g)/3] exactly",
  FullSimplify[cov == 2 (g - 1) (1 + rho^(1 - g)/3), asm]];
check["3b  Var(b) = 2(g-1)^2[1 + rho^(4-2g)/3] exactly",
  FullSimplify[var == 2 (g - 1)^2 (1 + rho^(4 - 2 g)/3), asm]];
(* radial image's share of Cov: the term rho^(1-g) comes from s/rho with s = rho^(2-g) *)
check["3c  sum a_j b_j = (g-1)[2 + rho^(1-g)]: the radial image contributes rho^(1-g)",
  FullSimplify[Total[aT bT] == (g - 1) (2 + rho^(1 - g)), asm]];
check["3d  leading behaviour: Cov/[(2/3)(g-1)rho^(1-g)] -> 1 and Var -> 2(g-1)^2 as rho -> 0",
  (Limit[cov/((2/3) (g - 1) rho^(1 - g)), rho -> 0, Assumptions -> 1 < g < 2, Direction -> "FromAbove"] === 1) &&
  FullSimplify[Limit[var, rho -> 0, Assumptions -> 1 < g < 2, Direction -> "FromAbove"] == 2 (g - 1)^2, 1 < g < 2]];
check["3e  hence (with 3f) c ~ rho^(1-g)/(3(g-1)) as rho -> 0",
  FullSimplify[Limit[cExact/cAsym, rho -> 0, Assumptions -> 1 < g < 2, Direction -> "FromAbove"] == 1, 1 < g < 2]];
check["3f  exact: c = (3 + rho^(1-g))/((g-1)(3 + rho^(4-2g)))",
  FullSimplify[cov/var == cExact, asm]];
check["3g  c/c_asym = (1+3u)/(1+v/3), u = rho^(g-1) (pair, in Cov), v = rho^(4-2g) (radial, in Var)",
  FullSimplify[cExact/cAsym == (1 + 3 rho^(g - 1))/(1 + rho^(4 - 2 g)/3), asm]];
check["3h  exchange of dominance: g - 1 < 4 - 2g iff g < 5/3",
  Resolve[ForAll[g, 1 < g < 2, Equivalent[g - 1 < 4 - 2 g, g < 5/3]], Reals]];
check["3i  rho -> 1 returns the two-image floor 1/(g-1)",
  FullSimplify[(cExact /. rho -> 1) == 1/(g - 1), 1 < g < 2]];
cNext = (rho^(1 - g) + 3 - rho^(5 - 3 g)/3)/(3 (g - 1));
vals = N[{cAsym, cNext, cExact, cOf[aT, bT]} /. {rho -> 3/100, g -> 7/5}, 12];
Print["   rho = 0.03, g = 1.4: asymptote, one-term, exact, regression = ", vals];
check["3j  rho = 0.03, g = 1.4: 3.388 / 5.871 / 5.859 / 5.859",
  Max[Abs[vals - {3.388, 5.871, 5.859, 5.859}]] < 0.0005];
check["3k  asymptote is 42% low (true c is 1.73x it); one-term form high by 0.2%",
  Abs[1 - vals[[1]]/vals[[3]] - 0.42] < 0.005 && Abs[vals[[3]]/vals[[1]] - 1.73] < 0.005 &&
  Abs[vals[[2]]/vals[[3]] - 1 - 0.002] < 0.0005];

(* ---------------- Exercise: sign change ---------------- *)
Print["\n--- ex:pe_sign_change ---"];
bias = (g - 1) m1 (c1 - B^kExp c2);
check["4a  Delta B/B = 0 iff c2/c1 = B^-k",
  FullSimplify[(c2 /. First@Solve[bias == 0, c2]) == c1 B^(-kExp), B > 0 && 1 < g < 3]];
check["4b  threshold exceeds 1: B^-k = e^(kL) > 1 for B = e^-L in (0,1), k > 0",
  Simplify[Exp[kk L] > 1, kk > 0 && L > 0] &&
  Resolve[ForAll[g, 1 < g < 3, (3 - g)/(g - 1) > 0], Reals]];
check["4c  total-mass shortcut = both planes at the floor: m1 (1 - B^k)",
  FullSimplify[(bias /. {c1 -> 1/(g - 1), c2 -> 1/(g - 1)}) == m1 (1 - B^kExp)]];
check["4d  shortcut has fixed sign: m1 (1 - e^(-kL)) > 0",
  Simplify[m1 (1 - Exp[-kk L]) > 0, m1 > 0 && kk > 0 && L > 0]];
check["4e  d(bias)/d c2 = -(g-1) m1 B^k < 0: a deeper plane-2 radial image drives the bias negative",
  Simplify[D[bias, c2] == -(g - 1) m1 B^kExp]];

(* ---------------- Exercise: coherence limit ---------------- *)
Print["\n--- ex:pe_coherence_limit ---"];
rI = (g - 1) (c1 - Bi^kExp ci);
check["5a  r_i -> (g-1) c1 as B_i -> 0, independent of c_i",
  FullSimplify[Limit[rI, Bi -> 0, Assumptions -> 1 < g < 3, Direction -> "FromAbove"] == (g - 1) c1, 1 < g < 3]];
check["5b  m_i = m1 B_i^k -> 0 in the same limit",
  Limit[m1 Bi^kExp, Bi -> 0, Assumptions -> 1 < g < 3, Direction -> "FromAbove"] === 0];
(* reach: B_i = d1/d_i with d = D_ds/D_s < 1  =>  B_i > d1 *)
check["5c  B_i = d1/d_i > d1 because d_i < 1: the limit is approached, not reached",
  Simplify[d1/di > d1, 0 < d1 < di < 1]];
check["5d  equal c > 0: |r_i| strictly increases as B_i decreases",
  Simplify[D[(gg - 1) c0 (1 - BB^kk), BB] < 0, 1 < gg < 3 && c0 > 0 && 0 < BB < 1 && kk > 0]];

(* ---------------- Exercise: design ---------------- *)
Print["\n--- ex:pe_design ---"];
J = Array[jj, {3, 2}]; dl = Array[del, 3];
F[s_] := Transpose[J].(IdentityMatrix[3]/s^2).J;
biasP[s_] := Inverse[F[s]].Transpose[J].(IdentityMatrix[3]/s^2).dl;
check["6a  halving sigma: bias unchanged", Simplify[biasP[sig/2] - biasP[sig]] === {0, 0}];
check["6b  halving sigma: marginal errors halve, so S doubles",
  Simplify[Sqrt[Diagonal[Inverse[F[sig/2]]]]/Sqrt[Diagonal[Inverse[F[sig]]]], sig > 0] ===
   {1/2, 1/2} ||
  Simplify[Diagonal[Inverse[F[sig/2]]]/Diagonal[Inverse[F[sig]]]] === {1/4, 1/4}];
(* coherent toy: N equal-sensitivity ratios with common bias m r: S_N / S_1 = Sqrt[N] *)
check["6c  coherent toy: going from 3 to 4 planes raises S by Sqrt[4/3]",
  FullSimplify[(Sqrt[4] mm rr/sig)/(Sqrt[3] mm rr/sig) == Sqrt[4/3], sig > 0 && mm rr != 0]];
check["6d  ... a 15% gain, less than the 2x from halving sigma; both raise S",
  Abs[N[Sqrt[4/3]] - 1.155] < 0.001 && N[Sqrt[4/3]] < 2];

(* ---------------- Exercise: mass sheet ---------------- *)
Print["\n--- ex:pe_mass_sheet ---"];
(* omitted uniform sheet kappa: deflection kappa theta  => a_j = theta_j (thetaE = 1) *)
aS = {1, -1, rho};
cSheet = cOf[aS, bT];
cSheetForm = (3 + rho^(3 - g))/((g - 1) (3 + rho^(4 - 2 g)));
check["7a  sheet residual: true y = t - alpha_PL - kappa t  => a_j = theta_j",
  FullSimplify[D[(t - t^(2 - g) - kap t) - (t - t^(2 - g)), kap] == -t]];
check["7b  sheet, canonical triple: c = (3 + rho^(3-g))/((g-1)(3 + rho^(4-2g)))",
  FullSimplify[cSheet == cSheetForm, asm]];
check["7b2 sheet: sum a b = (g-1)[2 + rho^(3-g)], abar = rho/3, Cov = 2(g-1)[1 + rho^(3-g)/3]",
  FullSimplify[Total[aS bT] == (g - 1) (2 + rho^(3 - g)), asm] && Mean[aS] === rho/3 &&
  FullSimplify[Total[(aS - Mean[aS]) (bT - Mean[bT])] == 2 (g - 1) (1 + rho^(3 - g)/3), asm]];
check["7c  sheet: rho -> 0 gives the floor 1/(g-1): the radial image adds no leverage",
  FullSimplify[Limit[cSheet, rho -> 0, Assumptions -> 1 < g < 2, Direction -> "FromAbove"] == 1/(g - 1), 1 < g < 2]];
check["7d  sheet: two-image floor also 1/(g-1) = total-mass Einstein-radius shift",
  FullSimplify[cOf[{1, -1}, (g - 1) {1, -1}] == 1/(g - 1), 1 < g < 2]];
Clear[uu];
serS = Normal@Series[(1 + kap uu) - (1 + kap uu)^(2 - g) - kap (1 + kap uu), {kap, 0, 1}];
check["7e  sheet total Einstein radius: thetaE (1 + kappa/(g-1)) to first order",
  FullSimplify[(uu /. First@Solve[Coefficient[serS, kap] == 0, uu]) == 1/(g - 1)]];
Print["   sheet c(rho=0.05, g=1.6) = ", N[cSheet /. {rho -> 1/20, g -> 8/5}, 8], "  vs point mass ", N[cExact /. {rho -> 1/20, g -> 8/5}, 8]];
check["7f  numeric example rho = 0.05, g = 1.6: sheet c = 1.626 (floor 1.667), point mass c = 4.87",
  Abs[N[cSheet /. {rho -> 1/20, g -> 8/5}] - 1.626] < 0.0005 && Abs[N[cExact /. {rho -> 1/20, g -> 8/5}] - 4.87] < 0.005];

summary[];
