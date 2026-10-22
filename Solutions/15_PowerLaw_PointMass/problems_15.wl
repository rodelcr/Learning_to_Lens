(* =========================================================================
   problems_15.wl
   Module 15: Power-Law Lenses with a Central Point Mass --- SOLUTIONS
   =========================================================================
   Purpose: Deterministic attestation of every worked solution in
            Notes/15_PowerLaw_PointMass/15_Solutions.tex, plus every numeric
            claim made inside the chapter's annotation boxes (rule R5).

   Sources: Meneghetti (2021) Sect. 5.2; Keeton (2001) astro-ph/0102341;
            Chapter 11 (Module 07) circular formalism and point-mass
            magnifications. Ported from the 202607 study-note script
            exercises/sol_note2_axisym_pl_pointmass.wl (CSV export and the
            cross-file CSV check dropped; replaced by in-script checks);
            exercises B1-B3 (broken power law) are new.

   Usage:   bash Mathematica/run_wl.sh \
                 Solutions/15_PowerLaw_PointMass/problems_15.wl

   Exercises solved:
     ex:pl_kappa_inversion   --- power-law kappa by inversion; kbar(thE) = 1
     ex:pl_point_mass_mag    --- point-mass mu = th^4/(th^4 - tBH^4); |mu+|+|mu-| >= 1
     ex:pl_radial_radius     --- theta_r from lambda_r = 0; g -> 2; value at g = 1.6
     ex:pl_sis_pm_shift      --- SIS + point mass: first-order image shifts
     ex:pl_tangential_shift  --- tangential critical curve of PL + point mass
     ex:pl_annihilation_15   --- annihilation at g = 3/2 in closed form
     ex:bpl_outside          --- broken PL deflection outside the break, identity
     ex:bpl_point_mass_limit --- point-mass corner t1 -> 2
     ex:bpl_sis_limit        --- SIS limits; SIS + effective point mass outside tB
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Mathematica", "harness.wl"}]];
Print["=== Module 15: SOLUTIONS ===\n"];

alphaPL[th_, thE_, g_] := thE^(g - 1) th^(2 - g);
kappaPL[th_, thE_, g_] := (3 - g)/2 (thE/th)^(g - 1);
asm = thE > 0 && th > 0 && 1 < g < 3;

(* ---------------- Exercise 1 : kappa by inversion ---------------- *)
check["1a  th alpha_PL = thE^(g-1) th^(3-g); d/dth = (3-g) thE^(g-1) th^(2-g)",
  FullSimplify[D[th alphaPL[th, thE, g], th] == (3 - g) thE^(g - 1) th^(2 - g), Assumptions -> asm]];
check["1b  kappa = 1/(2 th) d/dth[th alpha] = (3-g)/2 (thE/th)^(g-1)",
  FullSimplify[1/(2 th) D[th alphaPL[th, thE, g], th] == kappaPL[th, thE, g], Assumptions -> asm]];
check["1c  alpha rebuilt from kappa by (2/th) Int_0^th kappa x dx (converges for g < 3)",
  FullSimplify[(2/th) Integrate[kappaPL[x, thE, g] x, {x, 0, th}, Assumptions -> asm] == alphaPL[th, thE, g],
    Assumptions -> asm]];
check["1d  kbar(th) = (thE/th)^(g-1) and kbar(thE) = 1 for every g",
  FullSimplify[alphaPL[th, thE, g]/th == (thE/th)^(g - 1), Assumptions -> asm] &&
  FullSimplify[alphaPL[thE, thE, g]/thE, Assumptions -> thE > 0] === 1];

(* ---------------- Exercise 2 : point-mass magnification ---------------- *)
betaPM[th_] := th - tBH^2/th;
check["2a  mu = (th/y)(dth/dy) = th^4/(th^4 - tBH^4)",
  FullSimplify[(th/betaPM[th])/D[betaPM[th], th] == th^4/(th^4 - tBH^4), Assumptions -> th > 0 && tBH > 0]];
check["2b  mu = 1/[(1 - tBH^2/th^2)(1 + tBH^2/th^2)]",
  FullSimplify[1/((1 - tBH^2/th^2) (1 + tBH^2/th^2)) == th^4/(th^4 - tBH^4)]];
thP = (y + Sqrt[y^2 + 4 tBH^2])/2; thM = (y - Sqrt[y^2 + 4 tBH^2])/2;
muOf[t_] := t^4/(t^4 - tBH^4);
check["2c  roots of th^2 - y th - tBH^2: product -tBH^2, sum y",
  FullSimplify[thP thM == -tBH^2] && FullSimplify[thP + thM == y]];
totU = FullSimplify[(muOf[thP] - muOf[thM]) /. y -> u tBH, Assumptions -> u > 0 && tBH > 0];
check["2d  |mu+| + |mu-| = (u^2+2)/(u sqrt(u^2+4)), u = y/tBH",
  FullSimplify[totU == (u^2 + 2)/(u Sqrt[u^2 + 4]), Assumptions -> u > 0]];
check["2e  (u^2+2)^2 - u^2(u^2+4) = 4 > 0, so total magnification > 1 for every u > 0",
  Expand[(u^2 + 2)^2 - u^2 (u^2 + 4)] === 4 &&
  Reduce[(u^2 + 2)/(u Sqrt[u^2 + 4]) <= 1 && u > 0, u, Reals] === False];
check["2f  signed sum mu+ + mu- = 1",
  FullSimplify[muOf[thP] + muOf[thM] == 1, Assumptions -> y > 0 && tBH > 0]];
check["2g  numeric u = 5/3: total magnification = 1.10112",
  Abs[N[((5/3)^2 + 2)/((5/3) Sqrt[(5/3)^2 + 4])] - 1.10112] < 1*^-5];

(* ---------------- Exercise 3 : radial critical radius ---------------- *)
lrPL[t_, g_] := 1 - (2 - g) t^(1 - g);   (* thE = 1 *)
check["3a  theta_r = (2-g)^(1/(g-1)) is an exact zero of lambda_r",
  FullSimplify[lrPL[(2 - g)^(1/(g - 1)), g], Assumptions -> 1 < g < 2] === 0];
check["3b  theta_r -> 0 as g -> 2-",
  Limit[(2 - g)^(1/(g - 1)), g -> 2, Direction -> "FromBelow"] === 0];
t16 = N[(2 - 16/10)^(1/(16/10 - 1)), 20];
Print["       theta_r(1.6)/thE = ", t16];
check["3c  theta_r(g=1.6)/thE = 0.4^(5/3) = 0.21715",
  Abs[t16 - 0.2171534093] < 1*^-9 && (16/10 - 1)^-1 === 5/3];
check["3d  sign change of lambda_r across theta_r at g = 1.6, and at g = 3/2 (th = 0.2 vs 0.3)",
  N[lrPL[0.99 t16, 1.6]] < 0 && N[lrPL[1.01 t16, 1.6]] > 0 &&
  N[lrPL[0.2, 1.5]] < 0 && N[lrPL[0.3, 1.5]] > 0];
check["3e  g > 2 makes the base 2 - g negative: (2-2.2)^(1/1.2) is not real",
  Im[N[(2 - 22/10)^(1/(22/10 - 1))]] != 0];

(* ---------------- Exercise 4 : SIS + point mass, first-order shifts ---------------- *)
thPlusS = ((y + thE) + Sqrt[(y + thE)^2 + 4 m thE^2])/2;
thMinusS = ((y - thE) - Sqrt[(y - thE)^2 + 4 m thE^2])/2;
serP = Normal[Series[thPlusS, {m, 0, 1}]]; serM = Normal[Series[thMinusS, {m, 0, 1}]];
check["4a  theta_+ = (y+thE) + m thE^2/(y+thE) + O(m^2)",
  FullSimplify[serP == (y + thE) + m thE^2/(y + thE), Assumptions -> y > 0 && thE > 0]];
check["4b  theta_- = (y-thE) + m thE^2/(y-thE) + O(m^2)  (0 < y < thE)",
  FullSimplify[serM == (y - thE) + m thE^2/(y - thE), Assumptions -> 0 < y < thE && thE > 0]];
check["4c  shifts delta theta_pm = tBH^2/theta_pm^(0): outward on both sides (sign of theta^(0))",
  FullSimplify[Sign[(serP - (y + thE))] == 1, Assumptions -> y > 0 && thE > 0 && m > 0] &&
  FullSimplify[Sign[(serM - (y - thE))] == -1, Assumptions -> 0 < y < thE && thE > 0 && m > 0]];
check["4d  m -> 0 recovers the SIS images y +/- thE",
  FullSimplify[(serP /. m -> 0) == y + thE, Assumptions -> y > 0 && thE > 0] &&
  FullSimplify[(serM /. m -> 0) == y - thE, Assumptions -> 0 < y < thE]];
thPn = N[thPlusS /. {y -> 3/10, thE -> 1, m -> (8/100)^2}, 20];
thMn = N[thMinusS /. {y -> 3/10, thE -> 1, m -> (8/100)^2}, 20];
Print["       thE=1, tBH=0.08, y=0.3: theta_+ = ", thPn, ", theta_- = ", thMn];
check["4e  numeric (thE=1, tBH=0.08, y=0.3): theta_+ = 1.304905 (lin. 1.304923), theta_- = -0.709026 (lin. -0.709143)",
  Abs[thPn - 1.304905] < 1*^-6 && Abs[thMn + 0.709026] < 1*^-6 &&
  Abs[N[1.3 + 0.0064/1.3] - 1.304923] < 1*^-6 && Abs[N[-0.7 - 0.0064/0.7] + 0.709143] < 1*^-6];
check["4f  the residuals are O(m^2): |exact - linear| < 2 m^2 thE (/min|theta0|^3 scale) for both images",
  Abs[thPn - (1.3 + 0.0064/1.3)] < 2*^-5 && Abs[thMn - (-0.7 - 0.0064/0.7)] < 2*^-4];

(* ---------------- Exercise 5 : tangential shift of PL + point mass ---------------- *)
ltU[u_, g_, m_] := 1 - u^(1 - g) - m u^-2;
check["5a  lambda_t(PL+PM) = 1 - u^(1-g) - m u^-2  from alpha = thE^(g-1) th^(2-g) + m thE^2/th",
  FullSimplify[(1 - (alphaPL[th, thE, g] + m thE^2/th)/th /. th -> u thE) == ltU[u, g, m],
    Assumptions -> u > 0 && thE > 0 && 1 < g < 2]];
check["5b  linearise at u = 1: lambda_t ~ (g-1) delta - m  ->  u_t = 1 + m/(g-1) + O(m^2)",
  FullSimplify[(D[ltU[u, g, 0], u] /. u -> 1) == g - 1, Assumptions -> 1 < g < 2] &&
  FullSimplify[(D[ltU[u, g, m], m] /. u -> 1) == -1]];
check["5c  SIS (g = 2): exact u_t = (1 + sqrt(1 + 4m))/2 = 1 + m - m^2 + ...",
  FullSimplify[ltU[(1 + Sqrt[1 + 4 m])/2, 2, m] == 0, Assumptions -> m > 0] &&
  Normal[Series[(1 + Sqrt[1 + 4 m])/2, {m, 0, 2}]] === 1 + m - m^2];
utNum = u /. FindRoot[ltU[u, 3/2, 1/100] == 0, {u, 1}, WorkingPrecision -> 30];
Print["       g=3/2, m=0.01: u_t = ", N[utNum, 8], " vs 1 + m/(g-1) = 1.02"];
check["5d  numeric g = 3/2, m = 0.01: u_t = 1.0195 (linear estimate 1.02)",
  Abs[utNum - 1.0195] < 1*^-4];

(* ---------------- Exercise 6 : annihilation at g = 3/2 ---------------- *)
lrU[u_, g_, m_] := 1 - (2 - g) u^(1 - g) + m u^-2;
check["6a  g=3/2, u = s^2: u^2 lambda_r = s^4 - s^3/2 + m",
  FullSimplify[(u^2 lrU[u, 3/2, m] /. u -> s^2) == s^4 - s^3/2 + m, Assumptions -> s > 0]];
check["6b  double root of s^4 - s^3/2 + m: 4 s^3 - (3/2) s^2 = 0 -> s = 3/8, u_c = 9/64",
  Solve[4 s^3 - 3/2 s^2 == 0 && s > 0, s] === {{s -> 3/8}} && (3/8)^2 === 9/64];
check["6c  m_crit = -(s^4 - s^3/2) at s = 3/8 = 27/4096 = 0.0065918",
  -((3/8)^4 - (3/8)^3/2) === 27/4096 && Abs[N[27/4096] - 0.0065918] < 1*^-7];
check["6d  merger caustic y(u_c) = u_c - sqrt(u_c) - m_crit/u_c = -9/32",
  (9/64 - 3/8 - (27/4096)/(9/64)) === -9/32];
check["6e  general closed form reproduces 6b-6c: u_c = [(2-g)(3-g)/2]^(1/(g-1)), m_crit = (2-g)(g-1)/2 u_c^(3-g)",
  ((((2 - g) (3 - g)/2)^(1/(g - 1))) /. g -> 3/2) === 9/64 &&
  (((2 - g) (g - 1)/2 (((2 - g) (3 - g)/2)^(1/(g - 1)))^(3 - g)) /. g -> 3/2) === 27/4096];
check["6f  root counts of s^4 - s^3/2 + m (s>0): 2 for m = 0.003, 0 for m = 0.01",
  CountRoots[s^4 - s^3/2 + 3/1000, {s, 0, Infinity}] == 2 && CountRoots[s^4 - s^3/2 + 1/100, {s, 0, Infinity}] == 0];

(* ---------------- Exercise B1 : broken PL outside the break ---------------- *)
alphaIn[th_, kB_, tB_, t1_] := 2 kB tB^2/((2 - t1) th) (th/tB)^(2 - t1);
alphaOut[th_, kB_, tB_, t1_, t2_] := 2 kB tB^2/th (1/(2 - t1) + ((th/tB)^(2 - t2) - 1)/(2 - t2));
check["B1a inner mass 2 pi Int_0^tB kB (tB/x)^t1 x dx = 2 pi kB tB^2/(2 - t1)",
  FullSimplify[2 Pi Integrate[kB (tB/x)^t1 x, {x, 0, tB}, Assumptions -> tB > 0 && t1 < 2] == 2 Pi kB tB^2/(2 - t1),
    Assumptions -> tB > 0 && t1 < 2]];
check["B1b annulus mass 2 pi Int_tB^th kB (tB/x)^t2 x dx = 2 pi kB tB^2 [(th/tB)^(2-t2) - 1]/(2-t2)",
  FullSimplify[2 Pi Integrate[kB (tB/x)^t2 x, {x, tB, th}, Assumptions -> 0 < tB < th] ==
    2 Pi kB tB^2 ((th/tB)^(2 - t2) - 1)/(2 - t2), Assumptions -> 0 < tB < th && t2 < 2]];
check["B1c alpha_out = m2D/(pi th) and continuity at tB",
  FullSimplify[alphaOut[th, kB, tB, t1, t2] == (2 Pi kB tB^2/(2 - t1) + 2 Pi kB tB^2 ((th/tB)^(2 - t2) - 1)/(2 - t2))/(Pi th)] &&
  FullSimplify[alphaOut[tB, kB, tB, t1, t2] == alphaIn[tB, kB, tB, t1], Assumptions -> tB > 0]];
check["B1d identity alpha_out = 2 kB tB^t2 th^(1-t2)/(2-t2) + theta_eff^2/th",
  FullSimplify[alphaOut[th, kB, tB, t1, t2] == 2 kB tB^t2 th^(1 - t2)/(2 - t2) +
    2 kB tB^2 (t1 - t2)/((2 - t1) (2 - t2))/th, Assumptions -> 0 < tB < th && t1 < 2 && t2 < 2]];
check["B1e 1/(2-t1) - 1/(2-t2) = (t1-t2)/((2-t1)(2-t2))",
  Together[1/(2 - t1) - 1/(2 - t2) - (t1 - t2)/((2 - t1) (2 - t2))] === 0];

(* ---------------- Exercise B2 : point-mass corner ---------------- *)
check["B2a inner branch with kB = (2-t1) thBH^2/(2 tB^2): alpha_in = thBH^2/th (th/tB)^(2-t1)",
  FullSimplify[alphaIn[th, (2 - t1) thBH^2/(2 tB^2), tB, t1] == thBH^2/th (th/tB)^(2 - t1),
    Assumptions -> th > 0 && tB > 0 && t1 < 2]];
check["B2b ... -> thBH^2/th as t1 -> 2 for every 0 < th <= tB",
  Limit[thBH^2/th (th/tB)^(2 - t1), t1 -> 2] === thBH^2/th];
check["B2c central convergence diverges as t1 -> 2 but kB -> 0: kB tB^2 fixed = thBH^2 (2-t1)/2 -> 0",
  Limit[(2 - t1) thBH^2/2, t1 -> 2] === 0];
check["B2d theta_eff^2 -> thBH^2 (t1-t2)/(2-t2) -> thBH^2 as t1 -> 2 (at fixed inner mass)",
  FullSimplify[(2 kB tB^2 (t1 - t2)/((2 - t1) (2 - t2)) /. kB -> (2 - t1) thBH^2/(2 tB^2)) ==
     thBH^2 (t1 - t2)/(2 - t2), Assumptions -> tB > 0] &&
  Limit[thBH^2 (t1 - t2)/(2 - t2), t1 -> 2] === thBH^2];
(* fix pass 2026-10-14 (critic X11): at FIXED tB the same kB also multiplies the outer branch,
   so it too tends to thBH^2/th: the whole lens collapses to the point mass (chapter check 4c). *)
check["B2e fixed tB, t1 -> 2 at fixed inner mass: OUTER branch alpha_out -> thBH^2/th too (galaxy vanishes)",
  FullSimplify[Limit[alphaOut[th, (2 - t1) thBH^2/(2 tB^2), tB, t1, t2], t1 -> 2,
      Assumptions -> 0 < tB < th && 0 < t2 < 2 && thBH > 0] == thBH^2/th,
    Assumptions -> 0 < tB < th && 0 < t2 < 2 && thBH > 0]];

(* ---------------- Exercise B3 : SIS limits ---------------- *)
check["B3a t1 = t2 = 1: alpha = 2 kB tB on both branches (SIS with thE = 2 kB tB)",
  FullSimplify[alphaOut[th, kB, tB, 1, 1] == 2 kB tB] && FullSimplify[alphaIn[th, kB, tB, 1] == 2 kB tB]];
check["B3b t2 = 1: outside tB the lens is SIS (thE_S = 2 kB tB) + point mass theta_eff^2 = 2 kB tB^2 (t1-1)/(2-t1)",
  FullSimplify[alphaOut[th, kB, tB, t1, 1] == 2 kB tB + (2 kB tB^2 (t1 - 1)/(2 - t1))/th, Assumptions -> th > 0 && tB > 0]];
(* numeric: tB = 0.1, kB = 5 (thE_S = 1), t1 = 3/2 -> theta_eff^2 = 0.1 ; y = 0.3 *)
kBv = 5; tBv = 1/10; t1v = 3/2; yv = 3/10;
te2 = 2 kBv tBv^2 (t1v - 1)/(2 - t1v);
thOuterCF = ((yv + 1) + Sqrt[(yv + 1)^2 + 4 te2])/2;
thOuterNum = th /. FindRoot[th - alphaOut[th, kBv, tBv, t1v, 1] == yv, {th, 1.3}, WorkingPrecision -> 30];
Print["       B3 numeric: theta_eff^2 = ", te2, ", outer image closed form ", N[thOuterCF, 10], " vs direct ", N[thOuterNum, 10]];
check["B3c numeric tB=0.1, kB=5, t1=3/2: theta_eff^2 = 1/10; outer image 1.3728 (closed form = direct solve)",
  te2 === 1/10 && Abs[thOuterCF - thOuterNum] < 1*^-20 && Abs[N[thOuterCF] - 1.3728] < 1*^-4 && thOuterCF > tBv];
check["B3d t1 < 1 (core) gives theta_eff^2 < 0: a negative effective point mass",
  FullSimplify[2 kB tB^2 (t1 - 1)/(2 - t1) < 0, Assumptions -> 0 < t1 < 1 && kB > 0 && tB > 0]];

(* ---------------- Annotation numerics (rule R5) ---------------- *)
check["AN1 kappa(thE) = (3-g)/2: 0.75 at g = 1.5, 0.5 at g = 2;  lambda_r(thE) = g - 1 = 0.5 at g = 1.5",
  (3 - 3/2)/2 === 3/4 && (3 - 2)/2 === 1/2 && (1 - (2 - 3/2)) === 1/2];
check["AN2 slope dictionary at g = 1.5: t = g-1 = 0.5; Keeton alpha_K = 3-g = 1.5; Meneghetti n = g = 1.5",
  (3/2 - 1) === 1/2 && (3 - 3/2) === 3/2];
check["AN3 g = 1.5: thE/theta_r = 4 and the point-mass weight is amplified by 4^(3/2) = 8 at theta_r",
  1/(2 - 3/2)^(1/(3/2 - 1)) === 4 && 4^(3/2) === 8];
yIn = Module[{us}, us = u /. FindRoot[lrU[u, 3/2, 1/1000] == 0, {u, 0.02}, WorkingPrecision -> 30];
   us - Sqrt[us] - (1/1000)/us];
Print["       g=3/2, m=0.001: inner radial caustic y_in = ", N[yIn, 6], "; LO = ", N[-(3/2) (2/1000)^(1/3), 6]];
check["AN4 g = 1.5, m = 0.001: |y_in| = 0.171 thE exact; leading order (3/2)(2m)^(1/3) = 0.189",
  Abs[yIn + 0.1714] < 1*^-4 && Abs[N[(3/2) (2/1000)^(1/3)] - 0.189] < 1*^-3];
mcMax = NMaximize[{(2 - g) (g - 1)/2 ((2 - g) (3 - g)/2)^((3 - g)/(g - 1)), 1.001 <= g <= 1.999}, g];
check["AN5 max over 1<g<2 of m_crit = 0.0066 (at g = 1.48)",
  Abs[mcMax[[1]] - 0.0066] < 1*^-4 && Abs[(g /. mcMax[[2]]) - 1.48] < 0.01];
check["AN6 inside the break: 10% difference reached at 0.9 tB (2 - t1 = 1) but 0.35 tB (2 - t1 = 0.1)",
  N[(1 - 0.1)^(1/1)] == 0.9 && Abs[N[(1 - 0.1)^(1/0.1)] - 0.35] < 0.005];
(* fix pass 2026-10-14 (critic N9): the exact root is -0.0154 thE; 0.016 is only the leading
   order tBH^2/(y - thE).  Tolerance tightened from 1e-3 (which passed both) to 5e-5. *)
check["AN7 SIS + point mass, y = 1.4, tBH = 0.08: theta_- = -0.0154 thE exact (leading order tBH^2/(y-thE) = 0.016)",
  Module[{s1 = -((1 - 14/10) + Sqrt[(1 - 14/10)^2 + 4 (8/100)^2])/2},
    s1 < 0 && Abs[N[s1 + 1 - (8/100)^2/s1 - 14/10]] < 1*^-12 && Abs[N[s1] + 0.0154] < 5*^-5 &&
    !(Abs[N[s1] + 0.0160] < 5*^-5) && (8/100)^2/(14/10 - 1) === 2/125]];

check["AN8 isothermal dictionary: g = 2 <-> s = g - 1 = 1 <-> Keeton alpha_K = 3 - g = 1",
  (2 - 1) === 1 && (3 - 2) === 1];
check["AN9 theta_r/thE -> 1/e as g -> 1+ (Meneghetti eq. 5.44) and -> 0 as g -> 2-",
  Limit[(2 - g)^(1/(g - 1)), g -> 1, Direction -> "FromAbove"] === 1/E &&
  Limit[(2 - g)^(1/(g - 1)), g -> 2, Direction -> "FromBelow"] === 0];

summary[];
