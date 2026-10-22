(* =========================================================================
   response_coefficient.wl
   Module 21: First-Order Estimators and Multi-Plane Coherence
   =========================================================================
   Purpose: Verifies every derivation, closed form and number on the pages
            of Chapter "First-Order Estimators and Multi-Plane Coherence":
              S0  power-law + point-mass lens; double-source-plane scalings
              S1  first-order expansion of the image positions in m
              S2  first-order residuals; weighted least-squares normal
                  equations; the response coefficient c = Cov_w/Var_w
              S3  the canonical triple: exact closed form of c, its
                  asymptote, correction factor, gamma'=5/3 boundary,
                  monotonicity, two-image floor  (checks 1-10, kept from
                  the original verification script)
              S4  brute-force FindMinimum fits vs the linear estimator
                  (with and without the radial image; source- and
                  image-plane chi^2; O(m) scaling of the error)
              S5  freeing the slope: where the radial image's leverage goes
              S6  double-source-plane bias, the total-mass shortcut, and the
                  sign change
              S7  multi-plane coherence (N planes, symbolic) and the
                  significance-vs-amplitude scaling
              S3b image-plane weights on the canonical triple (fix pass
                  2026-10-14, critic F1): no divergence, non-monotonic,
                  reversed sign change
              S4b validity of the expansion for a deep radial image
                  (fix pass 2026-10-14, critic F2)
            and exports the two figures of this chapter: c(gamma') for the
            canonical configurations, and the correction factor c/c_asym.

   Sources: Least-squares algebra is standard (no specific reference).
            Power-law deflection: Chapter "Galaxy Lensing Applications"
            (eq:kappa_power_law); axisymmetric formalism and radial
            eigenvalue: Chapter "Axisymmetric Lens Models"
            (eq:eigenvalues_circular); point-mass deflection: eq:pm_alpha.

   Usage:   bash Mathematica/run_wl.sh \
                 Mathematica/21_Perturbative_Estimators/response_coefficient.wl

   Outputs: PASS/FAIL per check and a SUMMARY line (harness.wl);
            Figures/21_Perturbative_Estimators/response_coefficient.pdf
            Figures/21_Perturbative_Estimators/correction_factor.pdf
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "harness.wl"}]];
Print["=== Module 21: response coefficient and first-order estimators ===\n"];

asm = 0 < rho < 1 && 1 < gam < 2;

(* power-law deflection (reduced, 1-D signed), and point mass *)
aPL[t_, tE_, g_] := tE^(g - 1) Abs[t]^(2 - g) Sign[t];
aPLpos[t_, tE_, g_] := tE^(g - 1) t^(2 - g);           (* t > 0 branch *)
aPLneg[t_, tE_, g_] := -tE^(g - 1) (-t)^(2 - g);       (* t < 0 branch *)

(* =========================================================================
   S0. The lens and the double-source-plane scalings
   ========================================================================= *)
Print["--- S0: power law + point mass ---"];

check["pl1  alpha_PL(thetaE) = thetaE for every slope (Einstein radius is slope-free)",
  FullSimplify[aPLpos[tE, tE, g] == tE, tE > 0]];

check["pl2  b = d alpha_PL / d ln thetaE = (gamma'-1) alpha_PL",
  FullSimplify[(D[aPLpos[t, Exp[l], g], l] /. l -> Log[tE]) == (g - 1) aPLpos[t, tE, g],
    t > 0 && tE > 0]];

check["pl3  d alpha_PL / d gamma' = alpha_PL Log[thetaE/theta], zero at theta = thetaE",
  FullSimplify[D[aPLpos[t, tE, g], g] == aPLpos[t, tE, g] Log[tE/t], t > 0 && tE > 0] &&
  FullSimplify[(D[aPLpos[t, tE, g], g] /. t -> tE) == 0, tE > 0]];

(* point mass of Einstein radius thetaBH: alpha = thetaBH^2/theta = m thetaE^2/theta *)
check["pl4  point-mass deflection thetaBH^2/theta = m thetaE^2/theta with m = thetaBH^2/thetaE^2",
  FullSimplify[(m tE^2/t /. m -> tBH^2/tE^2) == tBH^2/t]];

(* mean convergence inside thetaE is 1 for any axisymmetric lens: alpha(thetaE)=thetaE.
   So M(<thetaE) ~ thetaE^2 and m = M_BH / M_PL(<thetaE) = thetaBH^2 / thetaE^2. *)
check["pl5  power-law mean convergence inside thetaE equals 1",
  FullSimplify[aPLpos[tE, tE, g]/tE == 1, tE > 0]];

(* DSPL: plane i has distance factor d_i = D_ds,i/D_s,i.  The power-law
   normalisation thetaE_i^(g-1) and the point-mass thetaBH_i^2 are both
   proportional to d_i.  B = d1/d2 < 1. *)
tEi[d_] := (K d)^(1/(g - 1));
tBHi2[d_] := Q d;
mi[d_] := tBHi2[d]/tEi[d]^2;
kExp = (3 - g)/(g - 1);
check["dspl1  m2/m1 = B^k with B = d1/d2 and k = (3-gamma')/(gamma'-1)",
  Simplify[PowerExpand[Log[mi[d2]/mi[d1]] - kExp Log[d1/d2]]] === 0];
check["dspl2  B = eta^(gamma'-1) with eta = thetaE1/thetaE2",
  FullSimplify[(tEi[d1]/tEi[d2])^(g - 1) == d1/d2, K > 0 && d1 > 0 && d2 > 0 && 1 < g < 3]];
check["dspl2b k > 0 on 1 < gamma' < 3 (deeper plane sees a smaller central-mass fraction)",
  Resolve[ForAll[g, 1 < g < 3, (3 - g)/(g - 1) > 0], Reals]];

(* total-mass Einstein radius, first order in m *)
Clear[uu];
serT = Normal@Series[tE (1 + mm uu) - aPLpos[tE (1 + mm uu), tE, g] - mm tE^2/(tE (1 + mm uu)),
   {mm, 0, 1}];
uSol = uu /. First@Solve[Coefficient[serT, mm] == 0, uu];
check["tot1  thetaE,tot = thetaE (1 + m/(gamma'-1)) + O(m^2)",
  FullSimplify[uSol == 1/(g - 1), tE > 0 && 1 < g < 2]];

(* =========================================================================
   S1. First-order image positions
   ========================================================================= *)
Print["\n--- S1: first-order image positions ---"];
(* lens equation at fixed source y: F(t,m) = t - alpha_PL(t) - m/t - y = 0 (thetaE = 1) *)
lamR[t_, g_] := 1 - D[aPL[tt, 1, g], tt] /. tt -> t;
Fpos = t - aPLpos[t, 1, g] - m/t - y;
Fneg = t - aPLneg[t, 1, g] - m/t - y;
dtdmPos = -(D[Fpos, m]/D[Fpos, t]) /. m -> 0;
dtdmNeg = -(D[Fneg, m]/D[Fneg, t]) /. m -> 0;
check["img1  dtheta/dm = a/lambda_r, a = 1/theta, lambda_r = 1 - alpha_PL'  (theta > 0)",
  FullSimplify[dtdmPos == (1/t)/(1 - D[aPLpos[t, 1, g], t]), t > 0 && 1 < g < 2]];
check["img2  same on the counter-image side (theta < 0)",
  FullSimplify[dtdmNeg == (1/t)/(1 - D[aPLneg[t, 1, g], t]), t < 0 && 1 < g < 2]];
check["img3  lambda_r(thetaE) = gamma'-1",
  FullSimplify[(1 - D[aPLpos[t, 1, g], t]) /. t -> 1] == g - 1];
thetaR = (2 - g)^(1/(g - 1));
check["img4  radial critical radius theta_r = (2-gamma')^(1/(gamma'-1)) thetaE: lambda_r = 0",
  FullSimplify[(1 - D[aPLpos[t, 1, g], t]) /. t -> thetaR, 1 < g < 2] == 0];
check["img5  lambda_r = 1 - (theta/theta_r)^(1-g): < 0 inside theta_r, > 0 outside",
  (Simplify[PowerExpand[(1 - D[aPLpos[t, 1, g], t]) - (1 - (t/thetaR)^(1 - g))]] === 0) &&
  (* x = theta/theta_r = e^-L:  x^(1-g) = e^(L(g-1)) > 1 for L > 0 (inside), < 1 for L < 0 *)
  Simplify[Exp[L (g - 1)] > 1, L > 0 && 1 < g < 2] && Simplify[Exp[-M (g - 1)] < 1, M > 0 && 1 < g < 2]];   (* outside: L = -M < 0 *)

(* numeric: images of PL vs PL+PM, gamma' = 8/5, y = 1/5 *)
gN = 8/5; yN = 1/5; wp = 50;
plImgs = {
   t /. FindRoot[yN == t - aPLpos[t, 1, gN], {t, 3/2}, WorkingPrecision -> wp],
   t /. FindRoot[yN == t - aPLneg[t, 1, gN], {t, -7/10}, WorkingPrecision -> wp],
   t /. FindRoot[yN == t - aPLneg[t, 1, gN], {t, -1/50}, WorkingPrecision -> wp]};
Print["   PL images (gamma'=8/5, y=1/5): ", N[plImgs, 8]];
check["img6  three images: A > thetaE, -thetaE < B < -theta_r, -theta_r < C < 0",
  plImgs[[1]] > 1 && -1 < plImgs[[2]] < -N[thetaR /. g -> gN, wp] &&
  -N[thetaR /. g -> gN, wp] < plImgs[[3]] < 0];
imgsM[mv_] := {
   t /. FindRoot[yN == t - aPLpos[t, 1, gN] - mv/t, {t, plImgs[[1]]}, WorkingPrecision -> wp],
   t /. FindRoot[yN == t - aPLneg[t, 1, gN] - mv/t, {t, plImgs[[2]]}, WorkingPrecision -> wp],
   t /. FindRoot[yN == t - aPLneg[t, 1, gN] - mv/t, {t, plImgs[[3]]}, WorkingPrecision -> wp]};
mSmall = 10^-7;
shiftNum = (imgsM[mSmall] - plImgs)/mSmall;
lamFun[t_] := 1 - (2 - gN) Abs[t]^(1 - gN);   (* d/dt [sgn(t)|t|^(2-g)] = (2-g)|t|^(1-g) *)
lamN = lamFun /@ plImgs;
shiftLin = (1/plImgs)/lamN;
Print["   numeric shift/m: ", N[shiftNum, 8], "   a/lambda_r: ", N[shiftLin, 8]];
check["img7  numeric image shifts agree with m a/lambda_r (rel. 1e-4, m = 1e-7)",
  Max[Abs[shiftNum/shiftLin - 1]] < 10^-4];
check["img8  numbers quoted on the page: shifts/m = 1.15, -3.34, 15.2; lambda_r = 0.66, 0.47, -2.78",
  Max[Abs[shiftLin - {1.15, -3.34, 15.2}]] < 0.05 &&
  Max[Abs[lamN - {0.66, 0.47, -2.78}]] < 0.005];

(* =========================================================================
   S2. Residuals, normal equations, response coefficient
   ========================================================================= *)
Print["\n--- S2: residuals and weighted least squares ---"];
(* true source: y = t - alpha_PL(t;1) - m/t.  Model with thetaE = e^eps, source y + dy:
   residual r = t - alpha_PL(t;e^eps) - (y + dy).  Expand to first order. *)
resid = t - aPLpos[t, Exp[eps], g] - (yT + dy) /. yT -> t - aPLpos[t, 1, g] - m/t;
resid1 = Normal@Series[resid /. {eps -> s eps, dy -> s dy, m -> s m}, {s, 0, 1}] /. s -> 1;
check["res1  r_j = m a_j - eps b_j - dy to first order, a = thetaE^2/theta, b = (gamma'-1) alpha_PL",
  FullSimplify[resid1 == m/t - eps (g - 1) aPLpos[t, 1, g] - dy, t > 0]];

nI = 3;
aV = Array[aa, nI]; bV = Array[bb, nI]; wV = Array[ww, nI];
rV = m aV - eps bV - dy;
objW = Total[wV rV^2];
solW = First@Solve[{D[objW, eps] == 0, D[objW, dy] == 0}, {eps, dy}];
abarW = Total[wV aV]/Total[wV]; bbarW = Total[wV bV]/Total[wV];
cW = Total[wV (aV - abarW) (bV - bbarW)]/Total[wV (bV - bbarW)^2];
check["ls1  weighted normal equations: eps = m Cov_w(a,b)/Var_w(b)  (n=3, general weights)",
  Simplify[(eps /. solW) - m cW] === 0];
check["ls1b weighted intercept: dy = m (abar_w - c bbar_w)",
  Simplify[(dy /. solW) - m (abarW - cW bbarW)] === 0];
(* matrix form (X^T W X)^-1 X^T W (m a) *)
Xm = Transpose[{bV, ConstantArray[1, nI]}];
pMat = Inverse[Transpose[Xm].DiagonalMatrix[wV].Xm].Transpose[Xm].DiagonalMatrix[wV].(m aV);
check["ls2  matrix form Delta p = m (X^T W X)^-1 X^T W a reproduces (eps, dy)",
  Simplify[pMat - {eps, dy} /. solW] === {0, 0}];

cU = cW /. ww[_] -> 1;
solU = First@Solve[{D[objW /. ww[_] -> 1, eps] == 0, D[objW /. ww[_] -> 1, dy] == 0}, {eps, dy}];
check["ls3  unweighted (n=3): eps = m Cov(a,b)/Var(b)",
  FullSimplify[(eps /. solU) - m cU] === 0];

Clear[a1, a2, b1, b2];
sol2 = First@Solve[{m a1 - eps b1 - dy == 0, m a2 - eps b2 - dy == 0}, {eps, dy}];
check["ls4  two images: eps = m (a1-a2)/(b1-b2) exactly, zero residual",
  FullSimplify[(eps /. sol2) - m (a1 - a2)/(b1 - b2)] === 0];

cWshift = cW /. aa[j_] :> aa[j] + kap;
check["ls5  intercept invariance: a_j -> a_j + const leaves c_w unchanged",
  Simplify[cWshift - cW] === 0];

(* fixing dy = 0 changes the answer: on the canonical triple *)
aC = {1, -1, 1/rho}; bC = (gam - 1) {1, -1, rho^(2 - gam)};
cFix = Total[aC bC]/Total[bC^2];
check["ls6  fixing dy = 0 gives a different c on the canonical triple (example rho=1/10, gamma'=3/2)",
  (cFix /. {rho -> 1/10, gam -> 3/2}) != ((3 + rho^(1 - gam))/((gam - 1) (3 + rho^(4 - 2 gam))) /.
     {rho -> 1/10, gam -> 3/2})];

(* scale-free: theta -> lam theta, thetaE -> lam thetaE leaves c unchanged *)
aS = {1, -1, 1/rho} lam; bS = (gam - 1) lam {1, -1, rho^(2 - gam)};
cS = Total[(aS - Mean[aS]) (bS - Mean[bS])]/Total[(bS - Mean[bS])^2];
check["ls7  c is scale-free (a and b both homogeneous of degree 1 in thetaE)",
  FullSimplify[cS == (3 + rho^(1 - gam))/((gam - 1) (3 + rho^(4 - 2 gam))), asm && lam > 0]];

(* =========================================================================
   S3. Canonical triple: closed form (original checks 1-10)
   ========================================================================= *)
Print["\n--- S3: canonical triple, exact closed form ---"];
avec = {1, -1, 1/rho};
bvec = (gam - 1) {1, -1, rho^(2 - gam)};

obj = Total[(avec - cc bvec - dd)^2];
sol = First@Solve[{D[obj, cc] == 0, D[obj, dd] == 0}, {cc, dd}];
cLS = FullSimplify[cc /. sol, Assumptions -> asm];
cExact = (3 + rho^(1 - gam))/((gam - 1) (3 + rho^(4 - 2 gam)));
check["1   free-intercept LS on {+1,-1,rho} = (3+rho^(1-g))/((g-1)(3+rho^(4-2g)))",
  FullSimplify[cLS == cExact, Assumptions -> asm]];

covAB = Total[(avec - Mean[avec]) (bvec - Mean[bvec])];
varB = Total[(bvec - Mean[bvec])^2];
check["1b  Cov(a,b) = 2(g-1)[1 + rho^(1-g)/3]",
  FullSimplify[covAB == 2 (gam - 1) (1 + rho^(1 - gam)/3), asm]];
check["1c  Var(b) = 2(g-1)^2 [1 + rho^(4-2g)/3]",
  FullSimplify[varB == 2 (gam - 1)^2 (1 + rho^(4 - 2 gam)/3), asm]];
check["1d  means: abar = 1/(3 rho), bbar = (g-1) rho^(2-g)/3 (tangential pair cancels)",
  FullSimplify[Mean[avec] == 1/(3 rho)] && FullSimplify[Mean[bvec] == (gam - 1) rho^(2 - gam)/3]];

cAsym = rho^(1 - gam)/(3 (gam - 1));
lim = Limit[cExact/cAsym, rho -> 0, Assumptions -> 1 < gam < 2, Direction -> "FromAbove"];
check["2   rho -> 0 limit of c / [rho^(1-g)/(3(g-1))] = 1",
  FullSimplify[lim == 1, Assumptions -> 1 < gam < 2]];

Rexact = (1 + 3 rho^(gam - 1))/(1 + rho^(4 - 2 gam)/3);
check["3   c/c_asym = (1+3u)/(1+v/3), u = rho^(g-1), v = rho^(4-2g)",
  FullSimplify[cExact/cAsym == Rexact, Assumptions -> asm]];

check["4   both correction exponents > 0 on 1 < g < 2",
  Reduce[ForAll[gam, 1 < gam < 2, gam - 1 > 0 && 4 - 2 gam > 0]]];

Ruv = (1 + 3 u)/(1 + v/3);
ser = Normal@Series[Ruv, {u, 0, 1}, {v, 0, 1}];
check["5   joint series -> 1 + 3u - v/3 - u v",
  FullSimplify[ser == 1 + 3 u - v/3 - u v]];
cNext = (rho^(1 - gam)/(3 (gam - 1))) (1 + 3 rho^(gam - 1) - rho^(4 - 2 gam)/3);
check["5b  one-term form = [rho^(1-g) + 3 - rho^(5-3g)/3]/(3(g-1))",
  FullSimplify[cNext == (rho^(1 - gam) + 3 - rho^(5 - 3 gam)/3)/(3 (gam - 1)), Assumptions -> asm]];

check["6   u leads (g-1 < 4-2g) iff g < 5/3",
  Resolve[ForAll[gam, 1 < gam < 2, Equivalent[gam - 1 < 4 - 2 gam, gam < 5/3]], Reals]];
(* R > 1 <=> 9 rho^(g-1) > rho^(4-2g) <=> rho^(5-3g) < 9; with L = -Log rho > 0, s = 5-3g *)
check["6a  R > 1 <=> rho^(5-3g) < 9 (algebraic equivalence)",
  FullSimplify[Equivalent[Rexact > 1, 9 rho^(gam - 1) > rho^(4 - 2 gam)], asm] ||
  Resolve[ForAll[{x, z}, x > 0 && z > 0, Equivalent[(1 + 3 x)/(1 + z/3) > 1, 9 x > z]], Reals]];
check["6b  g < 5/3 => c > c_asym for all rho in (0,1)  (via L = -log rho, s = 5-3g)",
  Resolve[ForAll[{ll, ss}, ll > 0 && 0 < ss < 2, -ss ll < Log[9]], Reals]];
rhoX[g_] := 9^(1/(5 - 3 g));
check["6c  crossing rho_x = 9^(1/(5-3g)) solves c = c_asym",
  FullSimplify[(Rexact /. rho -> rhoX[gam]) == 1, 5/3 < gam < 2]];
check["6d  rho_x(1.8) = 9^(-5/2) = 1/243 = 4.1e-3; rho_x(1.9) = 4.3e-2; rho_x(1.6) > 1",
  rhoX[9/5] == 1/243 && Abs[N[1/243] - 0.0041] < 0.00005 &&
  Abs[N[rhoX[19/10]] - 0.043] < 0.0005 && N[rhoX[8/5]] > 1];
check["6e  g = 1.8, rho = 1e-3: c/c_asym = 0.991 < 1 (below the asymptote)",
  Abs[N[Rexact /. {gam -> 9/5, rho -> 10^-3}] - 0.991] < 0.0005];

avecN = {1, -1, -1/rho}; bvecN = (gam - 1) {1, -1, -rho^(2 - gam)};
objN = Total[(avecN - cc bvecN - dd)^2];
cLSN = FullSimplify[cc /. First@Solve[{D[objN, cc] == 0, D[objN, dd] == 0}, {cc, dd}], Assumptions -> asm];
check["7   c even in the radial image's side",
  FullSimplify[cLSN == cExact, Assumptions -> asm]];

avec2 = {1, -1}; bvec2 = (gam - 1) {1, -1};
obj2 = Total[(avec2 - cc bvec2 - dd)^2];
cLS2 = FullSimplify[cc /. First@Solve[{D[obj2, cc] == 0, D[obj2, dd] == 0}, {cc, dd}], Assumptions -> 1 < gam < 2];
check["8   two-image floor (radial image masked) c = 1/(g-1)",
  FullSimplify[cLS2 == 1/(gam - 1), Assumptions -> 1 < gam < 2]];
check["9   rho -> 1 returns the floor",
  FullSimplify[(cExact /. rho -> 1) == 1/(gam - 1), Assumptions -> 1 < gam < 2]];
check["9b  floor = total-mass Einstein-radius shift 1/(g-1)  (same as tot1)",
  FullSimplify[cLS2 == uSol /. g -> gam]];

num = FullSimplify[Numerator[Together[D[cExact, rho]]], Assumptions -> asm];
den = FullSimplify[Denominator[Together[D[cExact, rho]]], Assumptions -> asm];
Print["   dc/drho numerator: ", num, "   denominator: ", den];
c10form = FullSimplify[D[cExact, rho] ==
    (-3 (gam - 1) rho^(3 gam) + (gam - 3) rho^(4 + gam) + 6 (gam - 2) rho^(3 + 2 gam))/
     ((gam - 1) (rho^4 + 3 rho^(2 gam))^2), Assumptions -> asm];
c10coef = Resolve[ForAll[gam, 1 < gam < 2, -3 (gam - 1) < 0 && (gam - 3) < 0 && 6 (gam - 2) < 0], Reals];
c10sum = Resolve[ForAll[{x1, x2, x3, gam}, x1 > 0 && x2 > 0 && x3 > 0 && 1 < gam < 2,
    -3 (gam - 1) x1 + (gam - 3) x2 + 6 (gam - 2) x3 < 0], Reals];
c10den = Resolve[ForAll[{x4, gam}, x4 > 0 && 1 < gam < 2, (gam - 1) x4 > 0], Reals];
check["10a dc/drho = [-3(g-1)rho^(3g) + (g-3)rho^(4+g) + 6(g-2)rho^(3+2g)] / [(g-1)(rho^4+3rho^(2g))^2]", c10form];
check["10b all three numerator coefficients < 0", c10coef];
check["10c numerator < 0 for positive powers of rho", c10sum];
check["10  c strictly decreasing in rho (denominator > 0)", c10form && c10coef && c10sum && c10den];

(* illustrative numbers quoted on the page *)
check["11  rho = 0.03, g = 1.4: asymptote 3.388, one-term 5.871, exact 5.859",
  Abs[N[cAsym /. {rho -> 3/100, gam -> 7/5}] - 3.388] < 0.0005 &&
  Abs[N[cNext /. {rho -> 3/100, gam -> 7/5}] - 5.871] < 0.0005 &&
  Abs[N[cExact /. {rho -> 3/100, gam -> 7/5}] - 5.859] < 0.0005];

(* =========================================================================
   S4. Brute-force FindMinimum fits vs the linear estimator
   ========================================================================= *)
Print["\n--- S4: brute-force fits ---"];
(* data: images of PL(thetaE=1, g=8/5) + PM(m) for y = 1/5 *)
cReg[aL_, bL_, wL_] := Module[{ab = Total[wL aL]/Total[wL], bb0 = Total[wL bL]/Total[wL]},
   Total[wL (aL - ab) (bL - bb0)]/Total[wL (bL - bb0)^2]];
aOf[ts_] := 1/ts;
bOf[ts_] := (gN - 1) (aPL[#, 1, gN] & /@ ts);

srcFit[ts_, mv_] := Module[{f, sol0},
   f[tE_, yf_] := Total[(ts - (aPL[#, tE, gN] & /@ ts) - yf)^2];
   sol0 = Last@FindMinimum[f[tE, yf], {{tE, 1}, {yf, yN}}, WorkingPrecision -> wp,
      PrecisionGoal -> 25, AccuracyGoal -> 40];
   Log[tE /. sol0]/mv];

mBF = 10^-6;
obs = imgsM[mBF];
cBF3 = cReg[aOf[obs], bOf[obs], {1, 1, 1}];
cBF2 = cReg[aOf[obs[[1 ;; 2]]], bOf[obs[[1 ;; 2]]], {1, 1}];
bf3 = srcFit[obs, mBF];
bf2 = srcFit[obs[[1 ;; 2]], mBF];
Print["   with radial image:    c(linear) = ", N[cBF3, 10], "   eps/m (FindMinimum) = ", N[bf3, 10]];
Print["   radial image masked:  c(linear) = ", N[cBF2, 10], "   eps/m (FindMinimum) = ", N[bf2, 10]];
check["bf1  3 images (with radial): FindMinimum eps/m = linear c to 1e-4", Abs[bf3/cBF3 - 1] < 10^-4];
check["bf2  2 images (radial masked): FindMinimum eps/m = linear c to 1e-4", Abs[bf2/cBF2 - 1] < 10^-4];
check["bf3  radial image raises c (c3 > c2 > 0) in this configuration", cBF3 > cBF2 > 0];
(* the canonical closed form with rho = |theta_C| is NOT the value for this asymmetric pair *)
cCanon = cExact /. {rho -> Abs[obs[[3]]], gam -> gN};
Print["   canonical closed form at rho = |theta_C| = ", N[Abs[obs[[3]]], 6], ": ", N[cCanon, 8],
  "   ratio c3/c_canon = ", N[cBF3/cCanon, 6]];
check["bf4  asymmetric pair: general c differs from the canonical closed form (ratio > 1.1)",
  cBF3/cCanon > 11/10];

(* Fix pass 2026-10-14 (critic N5): the page quotes c on the listed m = 0
   power-law images, c0 = 10.4612 -> 10.46.  The former value 10.47 was the
   regression on the m = 1e-6 perturbed images (cBF3 = 10.4656), which is
   what the brute-force comparison bf1 uses. *)
c0 = cReg[aOf[plImgs], bOf[plImgs], {1, 1, 1}];
c0two = cReg[aOf[plImgs[[1 ;; 2]]], bOf[plImgs[[1 ;; 2]]], {1, 1}];
cCanon0 = cExact /. {rho -> Abs[plImgs[[3]]], gam -> gN};
Print["   c on the m = 0 images: ", N[c0, 8], "   on the m = 1e-6 images: ", N[cBF3, 8]];
check["bf4b numbers quoted on the page (m = 0 images): +1.316, -0.633, -0.0237; theta_r = 0.217; c = 10.46 (3 img), 2.00 (2 img), canonical 6.81 (ratio 1.54), floor 1.67",
  Max[Abs[N[plImgs] - {1.316, -0.633, -0.0237}]/{0.001, 0.001, 0.0001}] < 0.5 &&
  Abs[c0 - 10.46] < 0.005 && Abs[c0two - 2.00] < 0.005 && Abs[cCanon0 - 6.81] < 0.005 &&
  Abs[c0/cCanon0 - 1.54] < 0.01 && Abs[N[1/(gN - 1)] - 1.67] < 0.005 &&
  Abs[N[thetaR /. g -> gN] - 0.217] < 0.0005];
check["bf4c 10.47 (10.466) is the perturbed-image (m = 1e-6) value, 10.46 the m = 0 value; relative difference 4e-4",
  Round[c0, 1/100] == 1046/100 && Round[cBF3, 1/100] == 1047/100 &&
  Round[cBF3, 1/1000] == 10466/1000 && Abs[cBF3/c0 - 1 - 4 10^-4] < 0.5 10^-4];
(* error is O(m): eps/m - c scales linearly in m *)
mA = 10^-5; mB = 2 10^-5;
eA = srcFit[imgsM[mA], mA] - cReg[aOf[plImgs], bOf[plImgs], {1, 1, 1}];
eB = srcFit[imgsM[mB], mB] - cReg[aOf[plImgs], bOf[plImgs], {1, 1, 1}];
Print["   (eps/m - c0) at m = 1e-5, 2e-5: ", N[{eA, eB}, 6], "  ratio ", N[eB/eA, 6]];
check["bf5  departure from the linear estimate is O(m): doubles (within 1%) for m -> 2m",
  Abs[eB/eA - 2] < 0.02];

(* image-plane chi^2: residual dtheta_j = -r_j/lambda_j  =>  weights w_j = 1/lambda_j^2 *)
lamObs = lamFun /@ obs;
cImgLin = cReg[aOf[obs], bOf[obs], 1/lamObs^2];
modelImg[tE_?NumericQ, yf_?NumericQ, t0_?NumericQ] :=
  t /. FindRoot[yf == t - aPL[t, tE, gN], {t, t0}, WorkingPrecision -> wp];
chiImg[tE_?NumericQ, yf_?NumericQ] := Total[(Table[modelImg[tE, yf, obs[[j]]], {j, 3}] - obs)^2];
solImg = Last@FindMinimum[chiImg[tE, yf], {{tE, 1, 1 + 10^-6}, {yf, yN, yN + 10^-6}},
    WorkingPrecision -> wp, PrecisionGoal -> 20, AccuracyGoal -> 30];
bfImg = Log[tE /. solImg]/mBF;
Print["   image-plane chi^2: c_w(linear, w=1/lambda^2) = ", N[cImgLin, 10],
  "   eps/m (FindMinimum) = ", N[bfImg, 10]];
check["bf6  image-plane fit: FindMinimum eps/m = weighted c with w = 1/lambda_r^2 (1e-3)",
  Abs[bfImg/cImgLin - 1] < 10^-3];
check["bf6b image-plane value quoted on the page: c_w = 2.08; radial-image lambda_r = -2.78",
  Abs[cImgLin - 2.08] < 0.005 && Abs[lamObs[[3]] + 2.78] < 0.005];
check["bf7  source- and image-plane fits give different c (weights matter)",
  Abs[cImgLin/cBF3 - 1] > 10^-2];

(* =========================================================================
   S3b. Image-plane weights on the canonical triple  (fix pass 2026-10-14,
        critic F1).  Equal astrometric errors: w = 1/lambda_r^2, i.e.
        1/(g-1)^2 on the pair at +-1 and 1/lambda_r(rho)^2 on the radial
        image.  The rho -> 0 divergence, the monotonic decrease and the
        sign change at rho* = 0.212 are SOURCE-PLANE (unit-weight) results.
   ========================================================================= *)
Print["\n--- S3b: image-plane weights, canonical triple ---"];
lamC[r_, g_] := 1 - (2 - g) r^(1 - g);
cImgC[r_, g_] := cReg[{1, -1, 1/r}, (g - 1) {1, -1, r^(2 - g)},
   {1/(g - 1)^2, 1/(g - 1)^2, 1/lamC[r, g]^2}];
cSrcC[r_, g_] := (3 + r^(1 - g))/((g - 1) (3 + r^(4 - 2 g)));
(* with u = rho^(g-1) (-> 0 as rho -> 0), rho^(1-g) = 1/u *)
check["ip1  radial-image weight 1/lambda_r^2 = u^2/(u - (2-g))^2 with u = rho^(g-1): -> 0 like rho^(2(g-1))/(2-g)^2",
  (PowerExpand[rho^(1 - gam) - 1/rho^(gam - 1)] === 0) &&
  Simplify[1/(1 - (2 - gam)/u)^2 == u^2/(u - (2 - gam))^2] &&
  (Simplify[Limit[1/(u - (2 - gam))^2, u -> 0] - 1/(2 - gam)^2] === 0)];
(* exact limit: substitute rho = x^5 so that every power is an integer power of x *)
check["ip2  image-plane c -> floor 1/(g-1) as rho -> 0 (g = 7/5, 8/5, 9/5; no divergence)",
  And @@ Table[Limit[Together[cImgC[x^5, gg]], x -> 0, Direction -> "FromAbove"] == 1/(gg - 1),
    {gg, {7/5, 8/5, 9/5}}]];
rhoTab = {1/1000, 1/100, 1/20, 1/10, 15/100, 2/10};
cImgTab = N[cImgC[#, 8/5] & /@ rhoTab, 20];
cSrcTab = N[cSrcC[#, 8/5] & /@ rhoTab, 20];
Print["   rho = ", N[rhoTab], "\n   c_img = ", N[cImgTab, 5], "\n   c_src = ", N[cSrcTab, 5]];
check["ip3  numbers quoted on the page (g = 1.6): c_img = 1.70, 1.83, 2.48, 3.72, 4.76, 4.70; c_src = 36.7, 10.4, 4.87, 3.68, 3.17, 2.86",
  Max[Abs[cImgTab - {1.70, 1.83, 2.48, 3.72, 4.76, 4.70}]] < 0.005 &&
  Max[Abs[cSrcTab - {36.7, 10.4, 4.87, 3.68, 3.17, 2.86}]/{0.1, 0.1, 0.01, 0.01, 0.01, 0.01}] < 0.5];
check["ip4  image-plane c is NOT monotonic in rho (rises from rho = 0.001 to 0.15, falls to 0.2), unlike the source-plane c",
  cImgTab[[1]] < cImgTab[[4]] < cImgTab[[5]] && cImgTab[[5]] > cImgTab[[6]] &&
  OrderedQ[Reverse[cSrcTab]]];
(* sign change, gamma' = 1.6, B = 0.8, plane 1 at the floor: bracket = c1 - B^k c2
   (same example as sc3 in S6) *)
gS = 8/5; BS = 4/5; kS = (3 - gS)/(gS - 1);
brImg[r_] := 1/(gS - 1) - BS^kS cImgC[r, gS];
rhoStarImg = r /. FindRoot[brImg[r] == 0, {r, 1/20, 1/50, 1/10}, WorkingPrecision -> 30];
thetaRS = N[(2 - gS)^(1/(gS - 1)), 30];
Print["   image-plane sign-change radius rho* = ", N[rhoStarImg, 6], "  (source plane 0.212); theta_r = ", N[thetaRS, 6]];
check["ip5  image-plane sign change at rho* = 0.0650 (source plane 0.212): bias > 0 deeper, < 0 for rho* < rho2 < theta_r",
  Abs[rhoStarImg - 0.0650] < 0.00005 && brImg[rhoStarImg/2] > 0 && brImg[rhoStarImg/10] > 0 &&
  (And @@ Table[brImg[r] < 0, {r, Subdivide[rhoStarImg + 10^-3, thetaRS - 10^-4, 40]}])];
check["ip6  so a deep plane-2 radial image does NOT always flip the sign in an image-plane fit: bracket > 0 as rho2 -> 0",
  Limit[Together[1/(8/5 - 1) - (4/5)^((3 - 8/5)/(8/5 - 1)) cImgC[x^5, 8/5]], x -> 0, Direction -> "FromAbove"] > 0];

(* =========================================================================
   S4b. Validity: the radial image's fractional shift  (fix pass
        2026-10-14, critic F2).  The small parameter is
        m a_C/(lambda_C theta_C), not m c.
   ========================================================================= *)
Print["\n--- S4b: validity for a deep radial image ---"];
fracC = shiftLin[[3]]/plImgs[[3]];       (* a_C/(lambda_C theta_C) per unit m *)
Print["   radial-image fractional shift per unit m: ", N[fracC, 6], "   vs c0 = ", N[c0, 6]];
check["val1 radial-image fractional shift m a_C/(lambda_C theta_C) = 640 m (vs m c = 10.5 m)",
  Abs[Abs[fracC] - 640] < 5 && Abs[fracC]/c0 > 50];
dep[mv_] := Module[{ts = imgsM[mv]},
   {ts[[3]], srcFit[ts, mv]/c0 - 1}];
dep5 = dep[10^-5]; dep4 = dep[10^-4];
Print["   m = 1e-5: theta_C = ", N[dep5[[1]], 6], "  eps/(m c0) - 1 = ", N[dep5[[2]], 5]];
Print["   m = 1e-4: theta_C = ", N[dep4[[1]], 6], "  eps/(m c0) - 1 = ", N[dep4[[2]], 5]];
check["val2 brute-force eps/m departs from c by 0.4% at m = 1e-5 and 4.5% at m = 1e-4 (radial image tracked)",
  Abs[dep5[[1]] + 0.0235] < 0.0002 && Abs[dep4[[1]] + 0.0221] < 0.0002 &&
  Abs[dep5[[2]] - 0.004] < 0.0005 && Abs[dep4[[2]] - 0.045] < 0.0005];
(* image count on the counter-image side inside theta_r: f = t - alpha_PL(t) - m/t - y
   is positive at both ends of (-theta_r, 0); roots exist iff its minimum is < 0.
   Parametrise t = -Exp[s]. *)
fMin[mv_] := First@NMinimize[{-Exp[s] - aPLneg[-Exp[s], 1, gN] + mv Exp[-s] - yN,
     -16 < s < Log[N[thetaR /. g -> gN]]}, s, WorkingPrecision -> 30];
fm4 = fMin[10^-4]; fm3 = fMin[10^-3];
Print["   min f on (-theta_r, 0): m = 1e-4 -> ", N[fm4, 5], ";  m = 1e-3 -> ", N[fm3, 5]];
check["val3 radial image (and the central point-mass image) present at m = 1e-4, annihilated by m = 1e-3",
  fm4 < 0 && fm3 > 0];

(* =========================================================================
   S5. Freeing the slope
   ========================================================================= *)
Print["\n--- S5: free slope ---"];
dOf[t_] := aPL[t, 1, gam] Log[1/Abs[t]];   (* d alpha / d gamma' at thetaE = 1 *)
Xfs = {{gam - 1, 0, 1}, {-(gam - 1), 0, 1}, {(gam - 1) rho^(2 - gam), rho^(2 - gam) Log[1/rho], 1}};
solFS = LinearSolve[Xfs, m {1, -1, 1/rho}];
check["fs1  d alpha/d gamma' column: 0 at +-thetaE, rho^(2-g) Log(1/rho) at rho",
  FullSimplify[{dOf[1], dOf[-1], dOf[rho]} == {0, 0, rho^(2 - gam) Log[1/rho]}, asm]];
check["fs2  free slope, canonical triple: eps = m/(g-1) (the floor), dy = 0",
  FullSimplify[solFS[[1]] == m/(gam - 1) && solFS[[3]] == 0, asm]];
check["fs3  free slope: dgamma' = m (rho^(g-3) - 1)/Log(1/rho)",
  FullSimplify[solFS[[2]] == m (rho^(gam - 3) - 1)/Log[1/rho], asm]];
check["fs4  dgamma'/m > 0: an unmodelled central mass steepens the fitted slope",
  (* rho = e^-L, L > 0:  (rho^(g-3) - 1)/Log(1/rho) = (e^(L(3-g)) - 1)/L *)
  Simplify[(Exp[L (3 - gam)] - 1)/L > 0, L > 0 && 1 < gam < 2]];
X2fs = Xfs[[1 ;; 2]];
check["fs5  without the radial image the free-slope normal matrix is singular (rank 2 < 3)",
  MatrixRank[Transpose[X2fs].X2fs] == 2 && FullSimplify[Det[Transpose[X2fs].X2fs]] === 0];
check["fs6  three images, three parameters: exact solve, zero residual",
  FullSimplify[Xfs.solFS - m {1, -1, 1/rho}, asm] === {0, 0, 0}];
(* brute force: physical configuration, free slope *)
srcFitFS[ts_, mv_] := Module[{f, sol0},
   f[tE_, g_, yf_] := Total[(ts - (aPL[#, tE, g] & /@ ts) - yf)^2];
   sol0 = Last@FindMinimum[f[tE, g, yf], {{tE, 1}, {g, gN}, {yf, yN}}, WorkingPrecision -> wp,
      PrecisionGoal -> 25, AccuracyGoal -> 40];
   {Log[tE /. sol0], (g /. sol0) - gN}/mv];
obsFS = imgsM[10^-9];
XphysFS = Transpose[{bOf[obsFS], (aPL[#, 1, gN] Log[1/Abs[#]]) & /@ obsFS, {1, 1, 1}}];
linFS = LinearSolve[XphysFS, aOf[obsFS]];
bfFS = srcFitFS[obsFS, 10^-9];
Print["   physical triple, free slope: linear (eps, dgamma')/m = ", N[linFS[[1 ;; 2]], 8],
  "   FindMinimum: ", N[bfFS, 8]];
check["fs7  brute-force free-slope fit = linear solve (eps and dgamma', 1e-4; m = 1e-9)",
  Max[Abs[bfFS/linFS[[1 ;; 2]] - 1]] < 10^-4];
check["fs8  physical triple: fitted slope steepens (dgamma' > 0)", linFS[[2]] > 0];
check["fs9  numbers quoted on the page: eps/m = -3.51, dgamma'/m = 86.4", 
  Abs[linFS[[1]] + 3.51] < 0.005 && Abs[linFS[[2]] - 86.4] < 0.05];
check["fs10 (critic X3) the total-mass value 1/(g-1) is a canonical-triple result: the asymmetric example gives -3.51, not 1.67",
  Abs[linFS[[1]] - 1/(gN - 1)] > 1];

(* =========================================================================
   S6. Double-source-plane bias and the sign change
   ========================================================================= *)
Print["\n--- S6: DSPL bias, sign change ---"];
dlnB = Series[Log[(tE1 (1 + ee e1)/(tE2 (1 + ee e2)))^(g - 1)] - Log[(tE1/tE2)^(g - 1)], {ee, 0, 1}];
check["dspl3  dln B = (g-1)(eps1 - eps2) to first order",
  FullSimplify[Coefficient[Normal[dlnB], ee] - (g - 1) (e1 - e2), tE1 > 0 && tE2 > 0] === 0];
biasB = (g - 1) (m1 c1 - (m1 B^kExp) c2);
check["dspl4  Delta B/B = (g-1) m1 [c1 - B^k c2]",
  FullSimplify[biasB - (g - 1) m1 (c1 - B^kExp c2)] === 0];
check["dspl5  both planes at the floor c = 1/(g-1): Delta B/B = m1 (1 - B^k) (total-mass shortcut)",
  FullSimplify[(biasB /. {c1 -> 1/(g - 1), c2 -> 1/(g - 1)}) == m1 (1 - B^kExp), 1 < g < 3]];
check["dspl6  shortcut is positive for 0 < B < 1, k > 0, m1 > 0",
  (* B = e^-L, L > 0:  B^k = e^(-k L) < 1 *)
  Simplify[m1 (1 - Exp[-kk L]) > 0, m1 > 0 && L > 0 && kk > 0]];
check["sc1  bias vanishes iff c2/c1 = B^-k (unique root of the bracket in c2)",
  (Solve[c1 - B^kk c2 == 0, c2] === {{c2 -> c1 B^-kk}}) || 
  FullSimplify[(c2 /. First@Solve[c1 - B^kk c2 == 0, c2]) == c1 B^-kk, B > 0]];
check["sc2  threshold B^-k > 1 for 0 < B < 1, k > 0",
  Simplify[Exp[kk L] > 1, L > 0 && kk > 0]];
(* example: plane 1 masked/tangential-only (c1 = floor), plane 2 canonical triple at rho2;
   gamma' = 8/5, B = 4/5 *)
gS = 8/5; BS = 4/5; kS = (3 - gS)/(gS - 1);
cS2[r_] := (3 + r^(1 - gS))/((gS - 1) (3 + r^(4 - 2 gS)));
rhoStar = r /. FindRoot[cS2[r] (gS - 1) == BS^-kS, {r, 1/5}, WorkingPrecision -> 30];
Print["   sign-change radius rho* (g=1.6, B=0.8, plane 1 at floor): ", N[rhoStar, 6]];
check["sc3  example g=1.6, B=0.8: rho* = 0.212 (bias < 0 for rho2 < rho*, > 0 above)",
  Abs[rhoStar - 0.212] < 0.0005 &&
  ((1/(gS - 1) - BS^kS cS2[rhoStar/2]) < 0) && ((1/(gS - 1) - BS^kS cS2[(1 + rhoStar)/2]) > 0)];
check["sc4  a root rho* in (0,1) always exists: c(1)(g-1) = 1 < B^-k, c ~ c_asym -> infinity as rho -> 0 (check 2)",
  FullSimplify[(cExact /. rho -> 1) (gam - 1) == 1, 1 < gam < 2] &&
  (Limit[cAsym, rho -> 0, Assumptions -> 1 < gam < 2, Direction -> "FromAbove"] === Infinity)];

(* =========================================================================
   S7. Multi-plane coherence and significance
   ========================================================================= *)
Print["\n--- S7: coherence ---"];
Nplanes = 5;
rVec = Table[(g - 1) (c[1] - B[i]^kExp c[i]), {i, 2, Nplanes}];
limVec = Table[Limit[rVec[[i - 1]], B[i] -> 0, Assumptions -> 1 < g < 3, Direction -> "FromAbove"], {i, 2, Nplanes}];
check["coh1  every r_i -> (g-1) c1 as B_i -> 0 (common limit, N = 5 planes)",
  Simplify[limVec - ConstantArray[(g - 1) c[1], Nplanes - 1]] === ConstantArray[0, Nplanes - 1]];
check["coh2  every r_i contains the same c1: d r_i / d c1 = g - 1 for all i",
  Union[Simplify[D[rVec, c[1]]]] === {g - 1}];
check["coh3  equal c > 0: r(B) = (g-1)c(1-B^k) strictly decreases with B (k>0)",
  Simplify[D[(gg - 1) cc0 (1 - BB^kk), BB] < 0, 1 < gg < 3 && cc0 > 0 && 0 < BB < 1 && kk > 0]];
check["coh4  equal c > 0: 0 < r_i < (g-1)c for 0 < B_i < 1 (common sign, bounded)",
  Simplify[0 < (gg - 1) cc0 (1 - Exp[-kk L]) < (gg - 1) cc0, 1 < gg < 3 && cc0 > 0 && L > 0 && kk > 0]];

(* significance: N measurements x_i = p + m r + noise(sigma); estimator = mean *)
Clear[sig, rr, mmm];
biasCoh[n_] := Mean[ConstantArray[mmm rr, n]];
sigEst[n_] := sig/Sqrt[n];
check["sig1  coherent: S_N = |bias|/sigma_est = Sqrt[N] S_1",
  And @@ Table[FullSimplify[(biasCoh[n]/sigEst[n]) == Sqrt[n] (mmm rr/sig), sig > 0], {n, 1, 6}]];
rmsInc[n_] := Sqrt[Mean[(Mean[#] mmm rr)^2 & /@ Tuples[{-1, 1}, n]]];
check["sig2  random signs (exhaustive over 2^N patterns): rms bias = m r/Sqrt[N], S_N = S_1",
  And @@ Table[FullSimplify[rmsInc[n]/sigEst[n] == Abs[mmm rr]/sig, sig > 0 && Element[{mmm, rr}, Reals]], {n, 1, 6}]];
Jg = Array[jj, {3, 2}]; dv = Array[del, 3];
pBias = Inverse[Transpose[Jg].(IdentityMatrix[3]/sig^2).Jg].Transpose[Jg].(IdentityMatrix[3]/sig^2).dv;
check["sig3  generic linear model, C = sigma^2 I: bias F^-1 J^T C^-1 delta independent of sigma",
  Simplify[D[pBias, sig]] === {0, 0}];
covP = Inverse[Transpose[Jg].(IdentityMatrix[3]/sig^2).Jg];
check["sig4  ... while the covariance F^-1 scales as sigma^2",
  Simplify[covP/sig^2 - Inverse[Transpose[Jg].Jg]] === {{0, 0}, {0, 0}}];

(* =========================================================================
   Figures
   ========================================================================= *)
Print["\n--- Figures ---"];
figDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Figures", "21_Perturbative_Estimators"}];
If[! DirectoryQ[figDir], CreateDirectory[figDir]];
cF[r_, g_] := (3 + r^(1 - g))/((g - 1) (3 + r^(4 - 2 g)));
fig1 = Plot[{1/(g - 1), cF[0.2, g], cF[0.05, g], cF[0.01, g]}, {g, 1.2, 1.95},
   PlotRange -> {0, 30}, Frame -> True,
   FrameLabel -> {Row[{Style["\[Gamma]", Italic], "'"}], Style["c", Italic]},
   PlotStyle -> {Directive[Black, Dashed, Thick], Directive[Blue, Thick],
     Directive[Darker@Green, Thick], Directive[Red, Thick]},
   PlotLegends -> Placed[LineLegend[{"tangential pair only (floor)",
       Row[{"with radial image, ", Style["\[Rho]", Italic], " = 0.2"}],
       Row[{"with radial image, ", Style["\[Rho]", Italic], " = 0.05"}],
       Row[{"with radial image, ", Style["\[Rho]", Italic], " = 0.01"}]}], {0.62, 0.75}],
   ImageSize -> 460, BaseStyle -> {FontFamily -> "Times", FontSize -> 13}];
Export[FileNameJoin[{figDir, "response_coefficient.pdf"}], fig1];
fig2 = LogLinearPlot[Evaluate[Table[(1 + 3 r^(g - 1))/(1 + r^(4 - 2 g)/3), {g, {1.4, 1.6, 1.8, 1.9}}]],
   {r, 10^-4, 1}, PlotRange -> {0.8, 3.2}, Frame -> True,
   FrameLabel -> {Style["\[Rho]", Italic], Row[{Style["c", Italic], " / ", Subscript[Style["c", Italic], "asym"]}]},
   GridLines -> {None, {1}},
   PlotStyle -> {Directive[Blue, Thick], Directive[Darker@Green, Thick], Directive[Orange, Thick], Directive[Red, Thick]},
   PlotLegends -> Placed[LineLegend[Table[Row[{Style["\[Gamma]", Italic], "' = ", g}], {g, {1.4, 1.6, 1.8, 1.9}}]], {0.2, 0.7}],
   ImageSize -> 460, BaseStyle -> {FontFamily -> "Times", FontSize -> 13}];
Export[FileNameJoin[{figDir, "correction_factor.pdf"}], fig2];
check["fig  both figures exported",
  FileExistsQ[FileNameJoin[{figDir, "response_coefficient.pdf"}]] &&
  FileExistsQ[FileNameJoin[{figDir, "correction_factor.pdf"}]]];

summary[];
