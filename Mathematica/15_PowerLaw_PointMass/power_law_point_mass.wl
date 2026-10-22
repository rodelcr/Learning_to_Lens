(* =========================================================================
   power_law_point_mass.wl
   Module 15: Power-Law Lenses with a Central Point Mass
   =========================================================================
   Purpose: Symbolically derive and verify every closed form of the chapter
            for the axisymmetric power law (rho ~ r^-g, g = gamma'), the
            central point mass, and their sum:
              1. circular toolbox: alpha = kbar theta, kappa by inversion,
                 d alpha/d theta = 2 kappa - kbar, lambda_r = 1 + kbar - 2 kappa
              2. power law: alpha, kappa from enclosed mass, Einstein
                 condition, SIS limit, kappa(thE) = (3-g)/2, shear,
                 cross-checks against Meneghetti (2021) eqs. 5.38-5.44 and
                 Keeton (2001) eqs. (26), (29)
              3. eigenvalues and critical radii theta_t, theta_r, existence
                 range 1<g<2, radial caustic
              4. point mass: kappa=0, lambda_r = 1 + tBH^2/th^2 > 0
              5. PL + point mass: lambda_r shift, stationary point u_star,
                 critical mass fraction m_crit(g) (closed form), two radial
                 critical curves for m < m_crit and none for m > m_crit,
                 tangential-curve shift, image counts (g = 3/2; and the
                 generic |y_in| < |y_out| ordering + 2/4/2 counts at g = 1.3, 1.8)
              6. SIS + point mass: closed-form images vs numerical root solve,
                 exactly two images for every source position
            and exports the chapter figures.

   Sources: Meneghetti (2021) Sect. 5.1-5.2, eqs. 5.38-5.44, Remark 5.3
            Keeton (2001) astro-ph/0102341, eqs. (23)-(24), (26), (29)
            Narayan & Bartelmann (1997) Sect. 3.1
            Ported from the 202607 study-note verification script
            (02_axisym_pl_pointmass/verify.wl), CSV exports dropped.

   Usage:   bash Mathematica/run_wl.sh \
                 Mathematica/15_PowerLaw_PointMass/power_law_point_mass.wl

   Outputs: PASS/FAIL per check + SUMMARY line;
            Figures/15_PowerLaw_PointMass/lambda_r_annihilation.pdf
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "harness.wl"}]];
Print["=== Module 15: power law + central point mass ===\n"];

figDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Figures",
    "15_PowerLaw_PointMass"}];
If[!DirectoryQ[figDir], CreateDirectory[figDir, CreateIntermediateDirectories -> True]];

(* ============================================================ *)
(* 0. Circular toolbox for an ARBITRARY profile                  *)
(* ============================================================ *)
Clear[k];
kbarG[th_] := 2/th^2 Integrate[k[x] x, {x, 0, th}];
alphaG[th_] := kbarG[th] th;
check["0a  kappa = 1/(2 th) d/dth[th alpha]  (inversion, any profile)",
  FullSimplify[1/(2 th) D[th alphaG[th], th] == k[th], Assumptions -> th > 0]];
check["0b  d alpha/d th = 2 kappa - kbar  (any profile)",
  FullSimplify[D[alphaG[th], th] == 2 k[th] - kbarG[th], Assumptions -> th > 0]];
check["0c  lambda_r = 1 - d alpha/d th = 1 + kbar - 2 kappa;  lambda_t = 1 - kbar",
  FullSimplify[(1 - D[alphaG[th], th]) == 1 + kbarG[th] - 2 k[th], Assumptions -> th > 0] &&
  FullSimplify[(1 - alphaG[th]/th) == 1 - kbarG[th], Assumptions -> th > 0]];
(* superposition: deflections add, so (1 - lambda) adds *)
Clear[a1, a2];
check["0d  superposition: lambda_r - 1 and lambda_t - 1 are additive in alpha",
  Simplify[(1 - D[a1[th] + a2[th], th]) - 1 == ((1 - D[a1[th], th]) - 1) + ((1 - D[a2[th], th]) - 1)] &&
  Simplify[(1 - (a1[th] + a2[th])/th) - 1 == ((1 - a1[th]/th) - 1) + ((1 - a2[th]/th) - 1)]];

(* ============================================================ *)
(* 1. Power law: deflection from the enclosed mass                *)
(* ============================================================ *)
kappaPL[th_, thE_, g_] := (3 - g)/2 (thE/th)^(g - 1);
alphaPL[th_, thE_, g_] := thE^(g - 1) th^(2 - g);
asm = thE > 0 && th > 0 && 1 < g < 2;
asm3 = thE > 0 && th > 0 && 1 < g < 3;

alphaFromKappa = FullSimplify[
   (2/th) Integrate[kappaPL[x, thE, g] x, {x, 0, th}, Assumptions -> asm3], Assumptions -> asm3];
check["1a  alpha_PL = (2/th) Int_0^th kappa th' dth' = thE^(g-1) th^(2-g)  (1<g<3)",
  FullSimplify[alphaFromKappa == alphaPL[th, thE, g], Assumptions -> asm3]];
check["1b  kappa_PL = 1/(2 th) d/dth[th alpha_PL] = (3-g)/2 (thE/th)^(g-1)",
  FullSimplify[1/(2 th) D[th alphaPL[th, thE, g], th] == kappaPL[th, thE, g], Assumptions -> asm3]];
check["1c  Einstein condition alpha(thE) = thE, i.e. kbar(thE) = 1, for every g",
  FullSimplify[alphaPL[thE, thE, g] == thE, Assumptions -> thE > 0]];
check["1d  SIS limit g = 2: alpha = thE (constant), kappa = thE/(2 th)",
  FullSimplify[alphaPL[th, thE, 2] == thE] && FullSimplify[kappaPL[th, thE, 2] == thE/(2 th), Assumptions -> th > 0]];
(* enclosed mass diverges at the origin for g >= 3: the integral of th'^(2-g) needs g < 3 *)
check["1e  enclosed-mass integral Int_0 x^(2-g) dx converges iff g < 3",
  (Integrate[x^(2 - g), {x, 0, 1}, Assumptions -> g < 3] == 1/(3 - g)) &&
  !NumericQ[Quiet@Check[Integrate[x^(2 - 3), {x, 0, 1}], $Failed]]];
check["1f  kappa(thE) = (3-g)/2  (= 1/2 for SIS, < 1 for g > 1)",
  FullSimplify[kappaPL[thE, thE, g] == (3 - g)/2, Assumptions -> thE > 0] &&
  Reduce[(3 - g)/2 >= 1 && g > 1, g] === False];
check["1g  kappa = (3-g)/2 * kbar everywhere (local = fixed fraction of mean)",
  FullSimplify[kappaPL[th, thE, g] == (3 - g)/2 alphaPL[th, thE, g]/th, Assumptions -> asm3]];
check["1h  shear |gamma| = kbar - kappa = (g-1)/2 kbar",
  FullSimplify[alphaPL[th, thE, g]/th - kappaPL[th, thE, g] == (g - 1)/2 alphaPL[th, thE, g]/th,
    Assumptions -> asm3]];

(* --- Cross-check vs Meneghetti (2021) Sect. 5.2: m(x) = x^(3-n), x = th/thE, n = g --- *)
mM[x_, n_] := x^(3 - n);                                     (* eq. 5.38 *)
check["1i  Meneghetti eq. 5.39: kappa = m'(x)/(2x) = (3-n)/2 x^(1-n)  == ours with n = g",
  FullSimplify[D[mM[x, n], x]/(2 x) == (3 - n)/2 x^(1 - n), Assumptions -> x > 0] &&
  FullSimplify[(kappaPL[x thE, thE, n]) == (3 - n)/2 x^(1 - n), Assumptions -> x > 0 && thE > 0]];
check["1j  Meneghetti eq. 5.40: alpha = m/x = x^(2-n)  == alpha_PL/thE with n = g",
  FullSimplify[alphaPL[x thE, thE, n]/thE == mM[x, n]/x, Assumptions -> x > 0 && thE > 0]];
check["1k  Meneghetti Remark 5.3: n = 3 gives m = const -> point mass alpha = 1/x",
  mM[x, 3] === 1 && Simplify[mM[x, 3]/x] === 1/x];

(* --- Cross-check vs Keeton (2001) eq. (26) and (29) with s = 0:
       kappa = (1/2) b^(2-aK) xi^(aK-2),  phi_r = b^(2-aK) r^(aK-1)/aK ;  aK = 3 - g --- *)
kapK[r_, b_, aK_, s_] := (1/2) b^(2 - aK)/(s^2 + r^2)^(1 - aK/2);
phirK[r_, b_, aK_, s_] := b^(2 - aK)/(aK r) ((s^2 + r^2)^(aK/2) - s^aK);
check["1l  Keeton eq. (29) is the enclosed-mass deflection of eq. (26) (any core s)",
  FullSimplify[(2/r) Integrate[kapK[x, b, aK, s] x, {x, 0, r}, Assumptions -> r > 0 && s > 0 && aK > 0] ==
    phirK[r, b, aK, s], Assumptions -> r > 0 && s > 0 && b > 0 && aK > 0]];
bOfThE = ((3 - g) thE^(g - 1))^(1/(g - 1));
check["1m  Keeton s=0, aK = 3-g, b^(g-1) = (3-g) thE^(g-1): kappa and alpha equal ours",
  FullSimplify[kapK[th, bOfThE, 3 - g, 0] == kappaPL[th, thE, g], Assumptions -> asm] &&
  FullSimplify[(b^(g - 1) th^(2 - g)/(3 - g) /. b^(g - 1) -> (3 - g) thE^(g - 1)) == alphaPL[th, thE, g],
    Assumptions -> asm] &&
  FullSimplify[PowerExpand[phirK[th, b, 3 - g, 0]] == b^(g - 1) th^(2 - g)/(3 - g), Assumptions -> asm && b > 0]];
check["1n  Keeton b equals thE only for the isothermal case g = 2",
  Reduce[(3 - g) == 1 && 1 < g < 3, g] === (g == 2)];

(* ============================================================ *)
(* 2. Eigenvalues                                                *)
(* ============================================================ *)
ltPL = FullSimplify[1 - alphaPL[th, thE, g]/th, Assumptions -> asm];
lrPL = FullSimplify[1 - D[alphaPL[th, thE, g], th], Assumptions -> asm];
check["2a  lambda_t = 1 - (thE/th)^(g-1)",
  FullSimplify[ltPL == 1 - (thE/th)^(g - 1), Assumptions -> asm]];
check["2b  lambda_r = 1 - (2-g)(thE/th)^(g-1)",
  FullSimplify[lrPL == 1 - (2 - g) (thE/th)^(g - 1), Assumptions -> asm]];
check["2c  lambda_r from the toolbox 1 + kbar - 2 kappa agrees",
  FullSimplify[1 + alphaPL[th, thE, g]/th - 2 kappaPL[th, thE, g] == 1 - (2 - g) (thE/th)^(g - 1),
    Assumptions -> asm3]];
check["2d  lambda_r(thE) = g - 1 = 2 [1 - kappa(thE)]",
  FullSimplify[(lrPL /. th -> thE) == g - 1, Assumptions -> asm] &&
  FullSimplify[g - 1 == 2 (1 - kappaPL[thE, thE, g]), Assumptions -> thE > 0]];

(* ============================================================ *)
(* 3. Critical curves of the power law                            *)
(* ============================================================ *)
tanSol = Solve[1 - (thE/th)^(g - 1) == 0, th];
check["3a  tangential lambda_t = 0  ->  theta_t = thE  [DERIVED]",
  AnyTrue[tanSol, FullSimplify[(th /. #) == thE, Assumptions -> asm] &] &&
  FullSimplify[(1 - (thE/th)^(g - 1)) /. th -> thE, Assumptions -> asm] === 0];
thetaR = thE (2 - g)^(1/(g - 1));
radSol = Solve[1 - (2 - g) (thE/th)^(g - 1) == 0, th];
check["3b  radial lambda_r = 0  ->  theta_r = thE (2-g)^(1/(g-1))  [DERIVED]",
  AnyTrue[radSol, FullSimplify[(th /. #) == thetaR, Assumptions -> asm] &]];
check["3c  theta_r is an exact zero of lambda_r",
  FullSimplify[(1 - (2 - g) (thE/th)^(g - 1)) /. th -> thetaR, Assumptions -> asm] === 0];
check["3d  0 < theta_r < thE for 1<g<2",
  Reduce[!(0 < (2 - g)^(1/(g - 1)) < 1) && 1 < g < 2, g, Reals] === False];
check["3e  theta_r -> 0 as g -> 2 (SIS: no radial critical curve)",
  Limit[(2 - g)^(1/(g - 1)), g -> 2, Direction -> "FromBelow"] === 0];
check["3f  g >= 2: lambda_r = 1 + (g-2)(thE/th)^(g-1) >= 1 > 0  (no radial curve)",
  Reduce[1 - (2 - g) w <= 0 && g >= 2 && w > 0, {g, w}, Reals] === False];
check["3g  spot values theta_r/thE: 1/4 (g=3/2), 0.2171534 (g=1.6), 0.0427 (g=1.95)",
  ((2 - 3/2)^(1/(3/2 - 1)) === 1/4) &&
  Abs[N[(2 - 16/10)^(1/(16/10 - 1)), 20] - 0.2171534093] < 1*^-9 &&
  Abs[N[(2 - 195/100)^(1/(195/100 - 1))] - 0.0427] < 5*^-5];
Print["       theta_r/thE(1.95) = ", N[(2 - 195/100)^(1/(195/100 - 1)), 8]];
(* Meneghetti eq. 5.43-5.44: x_r = (1 - 1/n')^n' with n' = 1/(n-1) -> 1/e as n -> 1 *)
check["3h  Meneghetti eq. 5.44: theta_r/thE -> 1/e as g -> 1+",
  Limit[(2 - g)^(1/(g - 1)), g -> 1, Direction -> "FromAbove"] === 1/E];
check["3i  theta_r/thE decreases monotonically in g on (1,2)",
  Reduce[D[(2 - g)^(1/(g - 1)), g] >= 0 && 1 < g < 2, g, Reals] === False ||
  AllTrue[Table[N[D[(2 - gg)^(1/(gg - 1)), gg] /. gg -> gv], {gv, 1.01, 1.99, 0.01}], # < 0 &]];
(* radial caustic:  y_r = theta_r - alpha(theta_r) = - thE (g-1)(2-g)^((2-g)/(g-1)) *)
yr = thetaR - alphaPL[thetaR, thE, g];
check["3j  radial caustic y_r = -theta_r (g-1)/(2-g) = -thE (g-1)(2-g)^((2-g)/(g-1))",
  FullSimplify[yr == -thetaR (g - 1)/(2 - g), Assumptions -> asm] &&
  AllTrue[{11/10, 13/10, 3/2, 17/10, 19/10}, Function[gv,
    Abs[N[(yr /. {g -> gv, thE -> 1}) + (gv - 1) (2 - gv)^((2 - gv)/(gv - 1)), 30]] < 1*^-25]]];
check["3k  |y_r| -> thE as g -> 2-  (Meneghetti: y_r -> 1 for n -> 2);  |y_r|(3/2) = thE/4",
  Limit[(g - 1) (2 - g)^((2 - g)/(g - 1)), g -> 2, Direction -> "FromBelow"] === 1 &&
  ((3/2 - 1) (2 - 3/2)^((2 - 3/2)/(3/2 - 1))) === 1/4];
(* y(theta) on th>0: y(0+) = 0, min at theta_r, y(thE) = 0 *)
check["3l  1<g<2: y(th)=th-alpha_PL -> 0 as th -> 0+, and y(thE) = 0",
  Limit[th - alphaPL[th, 1, 3/2], th -> 0, Direction -> "FromAbove"] === 0 &&
  (th - alphaPL[th, thE, g] /. th -> thE) === 0];

(* ============================================================ *)
(* 4. The point mass                                             *)
(* ============================================================ *)
alphaBH[th_, tBH_] := tBH^2/th;
check["4a  kappa_BH = 1/(2 th) d/dth[th alpha_BH] = 0 for th > 0",
  FullSimplify[1/(2 th) D[th alphaBH[th, tBH], th], Assumptions -> th > 0] === 0];
check["4b  lambda_t(BH) = 1 - tBH^2/th^2  (ring at th = tBH)",
  FullSimplify[(1 - alphaBH[th, tBH]/th) == 1 - tBH^2/th^2, Assumptions -> th > 0]];
check["4c  lambda_r(BH) = 1 + tBH^2/th^2",
  FullSimplify[(1 - D[alphaBH[th, tBH], th]) == 1 + tBH^2/th^2, Assumptions -> th > 0]];
check["4d  point mass has NO radial critical curve (lambda_r > 0 for all th != 0)",
  Reduce[(1 + tBH^2/th^2) <= 0 && th != 0 && tBH > 0, {th}, Reals] === False];
(* Keeton eq. (23)-(24): phi = R_E^2 ln r -> alpha = R_E^2 / r *)
check["4e  Keeton eq. (23): phi = tBH^2 ln th gives alpha = d phi/d th = tBH^2/th",
  D[tBH^2 Log[th], th] === tBH^2/th];

check["4f  thBH^2 = 4 G M Dds/(c^2 Dd Ds) = M/(pi Sigma_cr Dd^2); m = thBH^2/thE^2 = M/M_PL(<thE)",
  Module[{Scr = cc^2 Ds/(4 Pi GG Dd Dds)},
    FullSimplify[4 GG M Dds/(cc^2 Dd Ds) == M/(Pi Scr Dd^2)] &&
    FullSimplify[(M/(Pi Scr Dd^2))/thE^2 == M/(Pi Scr Dd^2 thE^2 (alphaPL[thE, thE, g]/thE)), Assumptions -> thE > 0]]];

(* ============================================================ *)
(* 5. Power law + point mass                                     *)
(* ============================================================ *)
lrPLBH = FullSimplify[1 - D[alphaPL[th, thE, g] + alphaBH[th, tBH], th], Assumptions -> asm];
check["5a  PL+BH: lambda_r = lambda_r(PL) + tBH^2/th^2",
  FullSimplify[lrPLBH == (1 - (2 - g) (thE/th)^(g - 1)) + tBH^2/th^2, Assumptions -> asm]];
(* dimensionless: u = th/thE, m = tBH^2/thE^2 *)
lrU[u_, g_, m_] := 1 - (2 - g) u^(1 - g) + m u^(-2);
ltU[u_, g_, m_] := 1 - u^(1 - g) - m u^(-2);
check["5b  dimensionless form lambda_r(u) = 1 - (2-g) u^(1-g) + m u^-2",
  FullSimplify[(lrPLBH /. {th -> u thE, tBH -> Sqrt[m] thE}) == lrU[u, g, m],
    Assumptions -> u > 0 && thE > 0 && m > 0 && 1 < g < 2]];
(* relative weight of the point-mass term vs the PL term in (lambda_r - 1) *)
ratioW[u_, g_, m_] := (m u^-2)/((2 - g) u^(1 - g));
check["5c  weight ratio = m u^-(3-g)/(2-g); amplification at theta_r over thE = (thE/theta_r)^(3-g)",
  FullSimplify[ratioW[u, g, m] == m u^(g - 3)/(2 - g), Assumptions -> u > 0 && 1 < g < 2] &&
  FullSimplify[ratioW[(2 - g)^(1/(g - 1)), g, m]/ratioW[1, g, m] == ((2 - g)^(1/(g - 1)))^(g - 3),
    Assumptions -> 1 < g < 2 && m > 0]];
check["5d  at g = 3/2 the amplification is 8 (= 4^(3/2))",
  (ratioW[1/4, 3/2, m]/ratioW[1, 3/2, m]) === 8];
check["5e  lambda_r -> +Infinity as u -> 0+ for m > 0 (point-mass term wins at the centre)",
  Limit[lrU[u, 3/2, 1/100], u -> 0, Direction -> "FromAbove"] === Infinity &&
  Limit[lrU[u, 3/2, 0], u -> 0, Direction -> "FromAbove"] === -Infinity];
(* stationary point *)
statCond = FullSimplify[u^3 D[lrU[u, g, m], u], Assumptions -> u > 0];
uStar = (2 m/((2 - g) (g - 1)))^(1/(3 - g));
check["5f  u^3 d lambda_r/du = (2-g)(g-1) u^(3-g) - 2m;  root u_star = [2m/((2-g)(g-1))]^(1/(3-g))",
  FullSimplify[statCond == (2 - g) (g - 1) u^(3 - g) - 2 m, Assumptions -> u > 0] &&
  Simplify[PowerExpand[statCond /. u -> uStar]] === 0];
check["5g  u^3 lambda_r' is increasing in u (single stationary point = global minimum)",
  FullSimplify[D[(2 - g) (g - 1) u^(3 - g) - 2 m, u] > 0, Assumptions -> u > 0 && 1 < g < 2]];
(* value at the stationary point: lambda_r(u_star) = 1 - (2-g)(3-g)/2 u_star^(1-g) *)
check["5h  lambda_r(u_star) = 1 - (2-g)(3-g)/2 * u_star^(1-g)",
  FullSimplify[PowerExpand[(lrU[u, g, m] /. m -> (2 - g) (g - 1) u^(3 - g)/2) ==
     1 - (2 - g) (3 - g)/2 u^(1 - g)], Assumptions -> u > 0 && 1 < g < 2]];
uC = ((2 - g) (3 - g)/2)^(1/(g - 1));
mCrit = (2 - g) (g - 1)/2 ((2 - g) (3 - g)/2)^((3 - g)/(g - 1));
check["5i  annihilation: u_c = [(2-g)(3-g)/2]^(1/(g-1)), m_crit = (2-g)(g-1)/2 u_c^(3-g)",
  FullSimplify[PowerExpand[1 - (2 - g) (3 - g)/2 uC^(1 - g)] == 0, Assumptions -> 1 < g < 2] &&
  FullSimplify[PowerExpand[mCrit - (2 - g) (g - 1)/2 uC^(3 - g)] == 0, Assumptions -> 1 < g < 2]];
check["5j  at m = m_crit, u_star = u_c and lambda_r(u_c) = 0 (numerical, g = 1.3,1.5,1.7,1.9)",
  AllTrue[{13/10, 3/2, 17/10, 19/10}, Function[gv,
    Module[{mc = mCrit /. g -> gv, uc = uC /. g -> gv},
      Abs[N[(uStar /. {g -> gv, m -> mc}) - uc, 30]] < 1*^-20 &&
      Abs[N[lrU[uc, gv, mc], 30]] < 1*^-20]]]];
check["5k  m_crit(3/2) = 27/4096 = 0.0065918, u_c(3/2) = 9/64",
  Simplify[mCrit /. g -> 3/2] === 27/4096 && Simplify[uC /. g -> 3/2] === 9/64];
check["5l  m_crit -> 0 as g -> 2- and as g -> 1+;  u_c -> 0 (g->2), e^(-3/2) (g->1)",
  Limit[mCrit, g -> 2, Direction -> "FromBelow"] === 0 &&
  Limit[mCrit, g -> 1, Direction -> "FromAbove"] === 0 &&
  Limit[uC, g -> 2, Direction -> "FromBelow"] === 0 &&
  Limit[uC, g -> 1, Direction -> "FromAbove"] === E^(-3/2)];
mcMax = NMaximize[{mCrit, 1.001 <= g <= 1.999}, g];
Print["       max m_crit over 1<g<2 = ", mcMax];
check["5m  max over g of m_crit(g) = 0.00660 at g = 1.485 (numerical): m > 0.0066 kills ANY power law's radial curve",
  Abs[mcMax[[1]] - 0.00660] < 5*^-6 && Abs[(g /. mcMax[[2]]) - 1.485] < 0.002];
(* two radial critical curves for m < m_crit, none for m > m_crit (g = 3/2): count roots of
   lambda_r(u) = 0 -> with u = s^2: s^4 - s^3/2 ... use u^2 lambda_r = u^2 - (1/2) u^(3/2) + m *)
nRad[mv_] := CountRoots[s^4 - (1/2) s^3 + mv, {s, 0, Infinity}];   (* u = s^2, u^2 lambda_r *)
check["5n  g=3/2: lambda_r has 2 zeros for m = 0.003, 1 double zero at m_crit, 0 for m = 0.01",
  nRad[3/1000] == 2 && nRad[1/100] == 0 && nRad[27/4096] == 2 &&
  Length[DeleteDuplicates[s /. NSolve[s^4 - (1/2) s^3 + 27/4096 == 0 && s > 0, s, Reals, WorkingPrecision -> 30],
    Abs[#1 - #2] < 1*^-6 &]] == 1];
(* tangential curve shifts outward: u_t = 1 + m/(g-1) + O(m^2) *)
check["5o  tangential curve: d u_t/dm at m=0 equals 1/(g-1)  (implicit differentiation)",
  FullSimplify[(-D[ltU[u, g, m], m]/D[ltU[u, g, m], u]) /. {u -> 1, m -> 0}, Assumptions -> 1 < g < 2] ===
    1/(g - 1)];
check["5p  numeric: g=3/2, m=0.001 -> u_t = 1.0020 (1 + m/(g-1) = 1.002)",
  Abs[(u /. FindRoot[ltU[u, 3/2, 1/1000] == 0, {u, 1}]) - 1.002] < 2*^-5];
(* image counts, g = 3/2, thE = 1, theta = +/- s^2:
   th>0 branch: s^4 - s^3 - y s^2 - m = 0 ;  th<0 branch: s^4 - s^3 + y s^2 - m = 0 *)
nImg[mv_, yv_] := CountRoots[s^4 - s^3 - yv s^2 - mv, {s, 0, Infinity}] +
                  CountRoots[s^4 - s^3 + yv s^2 - mv, {s, 0, Infinity}];
nImgPL[yv_] := CountRoots[s^2 - s - yv, {s, 0, Infinity}] +
               CountRoots[s^2 - s + yv, {s, 0, Infinity}];   (* m = 0, divided by s^2 *)
Print["       image counts g=3/2: PL y=0.05 -> ", nImgPL[1/20], "; m=0.003 y=0.01 -> ",
  nImg[3/1000, 1/100], "; m=0.003 y=0.2 -> ", nImg[3/1000, 1/5], "; m=0.01 y=0.01 -> ",
  nImg[1/100, 1/100]];
check["5q  pure PL (g=3/2): 3 images inside the radial caustic (y=0.05 < 1/4), 1 outside (y=0.3)",
  nImgPL[1/20] == 3 && nImgPL[3/10] == 1];
(* radial caustics of the two radial critical curves, g = 3/2 *)
radCaus[mv_] := Module[{rts = Sort[s /. NSolve[s^4 - (1/2) s^3 + mv == 0 && s > 0, s, Reals,
       WorkingPrecision -> 30]]},
    {#, # - Sqrt[#] - mv/#} & /@ (rts^2)];   (* u = s^2 ; returns {u, y(u)} per radial curve *)
Print["       g=3/2 radial curves {u, y}: m=0.001 ", N[radCaus[1/1000], 6], "; m=0.003 ", N[radCaus[3/1000], 6]];
check["5r  g=3/2, m=0.003: inner/outer radial caustics at |y| = 0.2336 / 0.2627 (inner smaller)",
  Module[{rc = radCaus[3/1000]}, Abs[rc[[1, 2]] + 0.23358] < 1*^-4 && Abs[rc[[2, 2]] + 0.26268] < 1*^-4]];
check["5s  g=3/2 image counts: m=0.003 -> 2 (y=0.01, zone of influence), 4 (y=0.25), 2 (y=0.3); m=0.01 -> 2",
  nImg[3/1000, 1/100] == 2 && nImg[3/1000, 1/4] == 4 && nImg[3/1000, 3/10] == 2 && nImg[1/100, 1/100] == 2 &&
  nImg[1/1000, 1/5] == 4 && nImg[1/1000, 1/10] == 2];
check["5t  at m = m_crit the two radial caustics merge at y = y(u_c) = -9/32 (g=3/2)",
  Simplify[(u - Sqrt[u] - m/u) /. {u -> 9/64, m -> 27/4096}] === -9/32 &&
  Module[{rc = radCaus[27/4096 - 1/10^8]}, Abs[rc[[1, 2]] - rc[[2, 2]]] < 1*^-4 && Abs[rc[[1, 2]] + 9/32] < 1*^-4]];
(* zone of influence: leading order for m -> 0: u_in ~ (m/(2-g))^(1/(3-g)),
   y_in ~ -(3-g) (m/(2-g))^((2-g)/(3-g)) thE *)
yInLO[gv_, mv_] := -(3 - gv) (mv/(2 - gv))^((2 - gv)/(3 - gv));
yInExact[gv_, mv_] := Module[{u0 = (mv/(2 - gv))^(1/(3 - gv)), us},
   us = u /. FindRoot[lrU[u, gv, mv] == 0, {u, u0}, WorkingPrecision -> 40];
   us - us^(2 - gv) - mv/us];
Print["       y_in exact vs LO (g=3/2): m=1e-3 ", N[{yInExact[3/2, 10^-3], yInLO[3/2, 10^-3]}, 6],
  "; m=1e-6 ", N[{yInExact[3/2, 10^-6], yInLO[3/2, 10^-6]}, 6]];
check["5u  zone of influence |y_in| = (3-g)[m/(2-g)]^((2-g)/(3-g)) thE to leading order (ratio -> 1 as m -> 0)",
  AllTrue[{13/10, 3/2, 17/10}, Function[gv, Abs[yInExact[gv, 10^-12]/yInLO[gv, 10^-12] - 1] < 0.02]] &&
  AllTrue[{13/10, 3/2, 17/10}, Function[gv, Abs[yInExact[gv, 10^-12]/yInLO[gv, 10^-12] - 1] <
      Abs[yInExact[gv, 10^-6]/yInLO[gv, 10^-6] - 1]]]];
check["5v  leading-order inner-curve condition: (2-g) u^(1-g) = m u^-2  <=>  u = (m/(2-g))^(1/(3-g))",
  FullSimplify[PowerExpand[((2 - g) u^(1 - g) - m u^-2) /. u -> (m/(2 - g))^(1/(3 - g))] == 0,
    Assumptions -> 1 < g < 2 && m > 0]];
check["5w  PL+BH supercritical: exactly 2 images for every y in a grid (m = 0.01, 0.05)",
  AllTrue[Flatten@Table[nImg[mv, yv], {mv, {1/100, 1/20}}, {yv, Range[1/100, 3, 1/20]}], # == 2 &]];
(* --- 5x-5z (fix pass 2026-10-14, critic X6): the caustic ordering |y_in| < |y_out|
   and the 2/4/2 image counts hold for ANY slope 1<g<2, not just g = 3/2.
   Argument: y(u) = u - u^(2-g) - m/u = u lambda_t, so sign(y) = sign(lambda_t);
   lambda_r - lambda_t = (g-1) u^(1-g) + 2 m u^-2 > 0, so at every radial critical
   radius (lambda_r = 0) lambda_t < 0 and y < 0.  dy/du = lambda_r: y rises from -Inf,
   peaks at u_in (y_in), falls to a minimum at u_out (y_out), so y_out < y_in < 0. *)
yU[u_, g_, m_] := u - u^(2 - g) - m/u;
check["5x  y = u lambda_t, dy/du = lambda_r, lambda_r - lambda_t = (g-1) u^(1-g) + 2m u^-2 > 0 (any 1<g<2, m>0)",
  FullSimplify[yU[u, g, m] == u ltU[u, g, m], Assumptions -> u > 0] &&
  FullSimplify[D[yU[u, g, m], u] == lrU[u, g, m], Assumptions -> u > 0] &&
  FullSimplify[lrU[u, g, m] - ltU[u, g, m] == (g - 1) u^(1 - g) + 2 m u^-2, Assumptions -> u > 0] &&
  Reduce[(g - 1) u^(1 - g) + 2 m u^-2 <= 0 && 1 < g < 2 && m > 0 && u > 0, {u}, Reals] === False];
radRootsG[gv_, mv_] := Module[{us = (2 mv/((2 - gv) (gv - 1)))^(1/(3 - gv)), f, ui, uo},
   f[uu_?NumericQ] := lrU[uu, gv, mv];
   ui = uu /. FindRoot[f[uu], {uu, us/10^6, us}, Method -> "Brent", WorkingPrecision -> 40];
   uo = uu /. FindRoot[f[uu], {uu, us, 1}, Method -> "Brent", WorkingPrecision -> 40];
   {ui, uo}];
causOK[gv_, mv_] := Module[{r = radRootsG[gv, mv], yi, yo},
   yi = yU[r[[1]], gv, mv]; yo = yU[r[[2]], gv, mv];
   r[[1]] < r[[2]] < 1 && ltU[r[[1]], gv, mv] < 0 && ltU[r[[2]], gv, mv] < 0 &&
   yo < yi < 0 && Abs[lrU[r[[1]], gv, SetPrecision[mv, 40]]] < 10^-20];
check["5y  |y_in| < |y_out| with both radial curves inside theta_t: g = 1.1..1.9, m/m_crit = 0.1, 0.5, 0.9",
  AllTrue[Flatten[Table[causOK[gv, fr (mCrit /. g -> gv)], {gv, {11/10, 13/10, 3/2, 17/10, 19/10}},
      {fr, {1/10, 1/2, 9/10}}]], TrueQ]];
(* image counts for rational g = 2 - p/q: theta = +/- u^q turns both branches into polynomials
   th>0: u^(2q) - u^(p+q) - y u^q - m = 0 ;  th<0: u^(2q) - u^(p+q) + y u^q - m = 0 *)
nImgG[gv_, mv_, yv_] := Module[{p = Numerator[2 - gv], q = Denominator[2 - gv]},
   CountRoots[u^(2 q) - u^(p + q) - yv u^q - mv, {u, 0, Infinity}] +
   CountRoots[u^(2 q) - u^(p + q) + yv u^q - mv, {u, 0, Infinity}]];
countsG[gv_] := Module[{mv = Rationalize[N[(mCrit /. g -> gv)/2, 30], 10^-25], r, yi, yo},
   r = radRootsG[gv, mv]; yi = Abs[yU[r[[1]], gv, mv]]; yo = Abs[yU[r[[2]], gv, mv]];
   {nImgG[gv, mv, Rationalize[yi/2, 10^-20]], nImgG[gv, mv, Rationalize[(yi + yo)/2, 10^-20]],
    nImgG[gv, mv, Rationalize[yo + 1/10, 10^-20]],
    Union[Table[nImgG[gv, Rationalize[N[2 (mCrit /. g -> gv), 30], 10^-25], yv], {yv, Range[1/100, 3, 1/10]}]]}];
Print["       image counts at m = m_crit/2 {inside y_in, annulus, outside y_out, (m = 2 m_crit grid)}: g=1.3 ",
  countsG[13/10], "; g=1.8 ", countsG[9/5]];
check["5z  g = 1.3 and 1.8, m = m_crit/2: 2 / 4 / 2 images (inside |y_in|, annulus, outside |y_out|); m = 2 m_crit: 2 everywhere",
  countsG[13/10] === {2, 4, 2, {2}} && countsG[9/5] === {2, 4, 2, {2}}];

(* ============================================================ *)
(* 6. SIS + point mass: closed form                              *)
(* ============================================================ *)
aS = y > 0 && thE > 0 && tBH > 0;
thetaPlus = (y + thE + Sqrt[(y + thE)^2 + 4 tBH^2])/2;
thetaMinus = -((thE - y) + Sqrt[(thE - y)^2 + 4 tBH^2])/2;
check["6a  theta>0 branch: theta^2 - (y+thE) theta - tBH^2 = 0 has root theta_+  [DERIVED]",
  AnyTrue[Solve[y == th - thE - tBH^2/th, th], FullSimplify[(th /. #) == thetaPlus, Assumptions -> aS] &]];
check["6b  theta_+ > 0 satisfies the theta>0 lens equation exactly",
  FullSimplify[(thetaPlus - thE - tBH^2/thetaPlus) == y, Assumptions -> aS] &&
  FullSimplify[thetaPlus > 0, Assumptions -> aS]];
check["6c  theta_- < 0 satisfies the theta<0 lens equation y = theta + thE - tBH^2/theta, ALL y > 0",
  FullSimplify[(thetaMinus + thE - tBH^2/thetaMinus) == y, Assumptions -> aS] &&
  FullSimplify[thetaMinus < 0, Assumptions -> aS]];
check["6d  tBH -> 0: theta_+ -> y + thE ; theta_- -> y - thE (y < thE)",
  FullSimplify[(thetaPlus /. tBH -> 0) == y + thE, Assumptions -> y > 0 && thE > 0] &&
  FullSimplify[(thetaMinus /. tBH -> 0) == y - thE, Assumptions -> 0 < y < thE]];
(* product of roots of each quadratic is -tBH^2 < 0  => exactly one admissible root per branch *)
check["6e  each branch quadratic has root product -tBH^2 < 0 -> exactly ONE image per branch",
  Expand[((th - thetaPlus) (th - (y + thE - Sqrt[(y + thE)^2 + 4 tBH^2])/2))] ===
    Expand[th^2 - (y + thE) th - tBH^2] &&
  Expand[((s - (-thetaMinus)) (s - ((thE - y) - Sqrt[(thE - y)^2 + 4 tBH^2])/2))] ===
    Expand[s^2 + (y - thE) s - tBH^2]];
check["6f  SIS+BH has no radial critical curve: lambda_r = 1 + tBH^2/th^2 > 0",
  FullSimplify[1 - D[thE + alphaBH[th, tBH], th] == 1 + tBH^2/th^2, Assumptions -> th > 0]];
check["6g  y > thE: the theta<0 image survives near the centre, |theta_-| ~ tBH^2/(y - thE)",
  Limit[(-thetaMinus) (y - thE)/tBH^2 /. tBH -> eps, eps -> 0,
    Assumptions -> y > thE && thE > 0] === 1];
(* numerical root solve vs closed form (thE = 1, tBH = 0.08, y = 0.3, and y = 1.4) *)
lensEq[t_?NumericQ, thEv_, tBHv_] := t - thEv Sign[t] - tBHv^2/t;
numRoots[yv_] := Module[{f = Function[t, lensEq[t, 1, 8/100] - yv], grid, br},
   grid = Join[Subdivide[-3, -1/10^6, 3000], Subdivide[1/10^6, 3, 3000]];
   br = Select[Partition[grid, 2, 1], Sign[f[#[[1]]]] != Sign[f[#[[2]]]] && #[[1]] #[[2]] > 0 &];
   Sort[t /. FindRoot[f[t], {t, #[[1]], #[[2]]}, WorkingPrecision -> 30] & /@ (SetPrecision[#, 30] & /@ br)]];
cf[yv_] := Sort[N[{thetaPlus, thetaMinus} /. {y -> yv, thE -> 1, tBH -> 8/100}, 30]];
Print["       numeric roots y=0.3: ", N[numRoots[3/10], 10], "  closed form: ", N[cf[3/10], 10]];
check["6h  numerical root solve (grid + FindRoot) = closed form, y = 0.3 and y = 1.4, |diff| < 1e-9",
  Length[numRoots[3/10]] == 2 && Length[numRoots[14/10]] == 2 &&
  Max[Abs[numRoots[3/10] - cf[3/10]]] < 1*^-9 && Max[Abs[numRoots[14/10] - cf[14/10]]] < 1*^-9];

(* ============================================================ *)
(* 7. Figure: lambda_r(theta) with and without a point mass      *)
(* ============================================================ *)
gF = 3/2; mcF = mCrit /. g -> gF;
cols = {Black, RGBColor[0.2, 0.4, 0.8], RGBColor[0.85, 0.5, 0.1], RGBColor[0.8, 0.1, 0.1]};
mList = {0, mcF/2, mcF, 2 mcF};
pA = LogLinearPlot[Evaluate[Table[lrU[u, gF, mv], {mv, mList}]], {u, 0.01, 2},
   PlotRange -> {-1.2, 1.5}, PlotStyle -> Table[{cols[[i]], Thick}, {i, 4}],
   Frame -> True, FrameLabel -> {Row[{"\[Theta] / ", Subscript["\[Theta]", "E"]}], Subscript["\[Lambda]", "r"]},
   GridLines -> {None, {0}}, PlotLegends -> Placed[LineLegend[
      {"m = 0", Row[{"m = ", Subscript["m", "crit"], "/2"}], Row[{"m = ", Subscript["m", "crit"]}],
       Row[{"m = 2", Subscript["m", "crit"]}]}], {Right, Bottom}],
   PlotLabel -> Row[{"(a) ", Superscript["\[Gamma]", "\[Prime]"], " = 1.5"}], ImageSize -> 360,
   Epilog -> {Dashed, Gray, Line[{{Log[1/4], -1.2}, {Log[1/4], 1.5}}]}];
pB = Plot[mCrit, {g, 1.001, 1.999}, Frame -> True, PlotStyle -> {Thick, Black},
   FrameLabel -> {Superscript["\[Gamma]", "\[Prime]"], Subscript["m", "crit"]},
   PlotLabel -> "(b) annihilation threshold", ImageSize -> 330, PlotRange -> {0, 0.009},
   Filling -> Axis, FillingStyle -> Directive[Opacity[0.12], Gray]];
fig1 = GraphicsRow[{pA, pB}, ImageSize -> 760, Spacings -> 20];
Export[FileNameJoin[{figDir, "lambda_r_annihilation.pdf"}], fig1];
check["7a  figure lambda_r_annihilation.pdf exported",
  FileExistsQ[FileNameJoin[{figDir, "lambda_r_annihilation.pdf"}]]];

summary[];
