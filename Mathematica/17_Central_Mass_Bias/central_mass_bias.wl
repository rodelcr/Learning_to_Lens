(* =========================================================================
   central_mass_bias.wl
   Module 17: How an Unmodelled Central Mass Biases a Compound Lens
   =========================================================================
   Purpose: Verify every identity, closed form and number in Chapter 17:
            (A) the compound-lens scaling backbone for a power law plus a
                central point mass (alpha_2 = alpha_1/B, theta_E2 =
                theta_E1 B^(-1/(g-1)), B = eta^(g-1), m_2 = m_1
                B^((3-g)/(g-1)), theta_r = theta_E (2-g)^(1/(g-1)));
            (B) the total-mass Einstein radius theta_E,tot and its small-m
                expansion; the fixed-slope back-of-envelope estimate;
            (C) the two-channel decomposition of dB/B;
            (D) the radial-image annihilation boundary in closed form
                (double root of y'), against two independent numerical
                routes;
            (E) the linear-response bias formula dp = J^-1 s m against a
                brute-force power-law-only "fit" (FindMinimum / FindRoot)
                to synthetic image positions generated WITH a point mass;
            (F) propagation of dB/B to dw for one illustrative flat-wCDM
                configuration (sign and size of S_w = dlnB/dw);
            (G) why any unmodelled AXISYMMETRIC central mass excess acts
                like a point mass outside its own radius (enclosed-mass
                argument), and why an off-centre excess does not.
            Fix pass 2026-10-14 (FACT_CRITIC_17 F2-F5, N-R1, N-R4-N-R6):
                E13 (m2 = m1 counterfactual), E9d-E9e (fixed-slope fit at
                unequal offsets), D9 (on-axis shear factor), D10 (inner
                critical curve needs the PL's lambda_r < 0), F5 (efficiency
                wording), G3 (off-centre lump), FIG1d-FIG1f (caption).
            Figures: bias in B vs m_1 for two slopes; annihilation boundary
            in the (gamma', m) plane.

   Sources: Axisymmetric lens equation and mean convergence:
              Narayan & Bartelmann (1997) Sect. 2.1.4 (circularly symmetric
              lens equation and Einstein radius; checked against the PDF
              2026-10-14 -- an earlier header said Sect. 2.1.2, which is the
              thin-screen approximation); Module 7 of these notes.
            Lens Jacobian eigenvalues: Congdon & Keeton eq. 4.54 (the
              characteristic equation of A^-1, roots (1-kappa) +- gamma;
              checked against the PDF 2026-10-14) (Module 5).
            Angular-diameter distances: Module 3 (flat FRW, eq. DA_flat,
              Dds_flat).
            Central black holes and the central image: Mao, Witt &
              Koopmans (2001), MNRAS 323, 301 (context only; the closed form
              below is derived here, not quoted).

   Usage:   bash Mathematica/run_wl.sh \
                 Mathematica/17_Central_Mass_Bias/central_mass_bias.wl

   Outputs: PASS/FAIL per check and a SUMMARY line;
            Figures/17_Central_Mass_Bias/bias_vs_m.pdf
            Figures/17_Central_Mass_Bias/annihilation_boundary.pdf
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "harness.wl"}]];
Print["=== Module 17: Central-mass bias in a compound lens ===\n"];

figDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Figures",
                       "17_Central_Mass_Bias"}];
If[!DirectoryQ[figDir], CreateDirectory[figDir, CreateIntermediateDirectories -> True]];

wp = 40;
Clear[g, B, th, tE, tE1, tE2, tB1, tB2, m, m1, m2, u, eta, x, t];

(* ---------------------------------------------------------------------
   (A) Scaling backbone
   Plane-i deflection of a power law of 3-D slope g plus a point mass:
     alpha_i(th) = tE_i^(g-1) th^(2-g) + tB_i^2/th            (th > 0)
   Both terms carry the same distance factor D_ds,i/D_s,i, so the plane-2
   deflection is the plane-1 deflection divided by B.
   --------------------------------------------------------------------- *)
Print["--- (A) scaling backbone ---"];
alphaPL[th_, tE_, g_] := tE^(g - 1) th^(2 - g);
alphaBH[th_, tB_] := tB^2/th;

(* plane-2 parameters expressed through plane 1 *)
tE2of[tE1_, B_, g_] := tE1 B^(-1/(g - 1));
tB2sq[tB1_, B_] := tB1^2/B;

check["A1  alpha_2(th) = alpha_1(th)/B  (PL + point mass, same D_ds/D_s factor)",
  FullSimplify[
    alphaPL[th, tE2of[tE1, B, g], g] + tB2sq[tB1, B]/th ==
    (alphaPL[th, tE1, g] + alphaBH[th, tB1])/B,
    Assumptions -> th > 0 && tE1 > 0 && 0 < B < 1 && 1 < g < 2]];

(* A2: PL ring condition th = alphaPL(th) gives th = tE; scaling of tE *)
check["A2a PL alone: alphaPL(tE) = tE (tE is the PL ring radius)",
  FullSimplify[alphaPL[tE, tE, g] == tE, Assumptions -> tE > 0]];
check["A2b tE2^(g-1) = tE1^(g-1)/B  =>  tE2 = tE1 B^(-1/(g-1))",
  FullSimplify[tE2of[tE1, B, g]^(g - 1) == tE1^(g - 1)/B,
    Assumptions -> tE1 > 0 && 0 < B < 1 && g > 1]];
check["A2c eta = tE1/tE2 = B^(1/(g-1))  <=>  B = eta^(g-1)",
  FullSimplify[(tE1/tE2of[tE1, B, g])^(g - 1) == B,
    Assumptions -> tE1 > 0 && 0 < B < 1 && g > 1]];
check["A2d eta < 1 whenever B < 1 and g > 1",
  Reduce[0 < B < 1 && 1 < g < 3 && B^(1/(g - 1)) >= 1, {B, g}, Reals] === False];

(* A3: mass fraction m = tB^2/tE^2 on each plane *)
m2of[m1_, B_, g_] := m1 B^((3 - g)/(g - 1));
check["A3a m_2 = (tB1^2/B)/tE2^2 = m_1 B^((3-g)/(g-1))",
  FullSimplify[(tB2sq[tB1, B]/tE2of[tE1, B, g]^2) == m2of[tB1^2/tE1^2, B, g],
    Assumptions -> tE1 > 0 && tB1 > 0 && 0 < B < 1 && 1 < g < 3]];
check["A3b m_2 < m_1 for 0<B<1, 1<g<3 (negation unsatisfiable)",
  Reduce[0 < B < 1 && 1 < g < 3 && B^((3 - g)/(g - 1)) >= 1, {B, g}, Reals] === False];
check["A3c m_2/m_1 = 0.7613 at g=1.9, B=0.8 and 0.5941 at g=1.6, B=0.8",
  Abs[N[m2of[1, 8/10, 19/10]] - 0.761298] < 1*^-6 && Abs[N[m2of[1, 8/10, 16/10]] - 0.594123] < 1*^-6];
Print["     m2/m1 (g=1.9,B=0.8) = ", N[m2of[1, 8/10, 19/10], 8],
      ";  (g=1.6,B=0.8) = ", N[m2of[1, 8/10, 16/10], 8]];

(* A4: radial critical radius of the pure power law *)
lamR[th_, tE_, g_] := 1 - D[alphaPL[x, tE, g], x] /. x -> th;
lamT[th_, tE_, g_] := 1 - alphaPL[th, tE, g]/th;
thetaR[tE_, g_] := tE (2 - g)^(1/(g - 1));
check["A4a lambda_r(theta_r) = 0 with theta_r = tE (2-g)^(1/(g-1))",
  FullSimplify[lamR[thetaR[tE, g], tE, g] == 0, Assumptions -> tE > 0 && 1 < g < 2]];
check["A4b lambda_t(tE) = 0 (tangential critical circle at tE)",
  FullSimplify[lamT[tE, tE, g] == 0, Assumptions -> tE > 0]];
check["A4c theta_r/tE = 0.0774 at g=1.9 and 0.2172 at g=1.6",
  Abs[N[thetaR[1, 19/10]] - 0.077426] < 1*^-5 && Abs[N[thetaR[1, 16/10]] - 0.217153] < 1*^-5];
check["A4d point-mass scale sqrt(m) = 0.1 tE at m=0.01: same order as theta_r(1.9)",
  Abs[Sqrt[1/100] - 1/10] == 0 && 0.5 < (1/10)/N[thetaR[1, 19/10]] < 2];
Print["     theta_r/tE: g=1.9 -> ", N[thetaR[1, 19/10], 6], ",  g=1.6 -> ", N[thetaR[1, 16/10], 6]];

(* A5: the PL deflection comes from kappa = (3-g)/2 (tE/th)^(g-1) via the mean convergence *)
kapPL[th_, tE_, g_] := (3 - g)/2 (tE/th)^(g - 1);
check["A5a alpha = kbar * th with kbar = (2/th^2) Int_0^th kappa th' dth'  reproduces alphaPL",
  FullSimplify[(2/th^2) Integrate[kapPL[x, tE, g] x, {x, 0, th},
       Assumptions -> th > 0 && tE > 0 && 1 < g < 3] th == alphaPL[th, tE, g],
    Assumptions -> th > 0 && tE > 0 && 1 < g < 3]];
check["A5b lambda_r = 1 - d alpha/d th = 1 - (2-g)(tE/th)^(g-1) and lambda_r lambda_t = det A",
  FullSimplify[lamR[th, tE, g] == 1 - (2 - g) (tE/th)^(g - 1) &&
    lamR[th, tE, g] lamT[th, tE, g] ==
      (1 - kapPL[th, tE, g])^2 - (alphaPL[th, tE, g]/th - kapPL[th, tE, g])^2,
    Assumptions -> th > 0 && tE > 0 && 1 < g < 3]];

(* ---------------------------------------------------------------------
   (B) The total-mass Einstein radius
   --------------------------------------------------------------------- *)
Print["\n--- (B) total-mass Einstein radius ---"];
(* in units tE = 1: th^(g-1) = 1 + m th^(g-3)  <=>  th = alphaPL + alphaBH *)
thTot[g_, m_?NumericQ] := th /. FindRoot[th == alphaPL[th, 1, g] + m/th, {th, 1},
                                          WorkingPrecision -> wp];
check["B1  mean convergence inside theta_tot equals 1  <=>  th = alpha_PL + alpha_BH",
  (* alpha = kbar th, so th = alpha  <=>  kbar = 1 *)
  FullSimplify[((alphaPL[th, tE, g] + tB^2/th)/th == 1) ==
               (th == alphaPL[th, tE, g] + tB^2/th), Assumptions -> th > 0] ||
  Module[{gg = 19/10, mm = 1/100, tt},
    tt = thTot[gg, mm]; Abs[(alphaPL[tt, 1, gg] + mm/tt)/tt - 1] < 10^-30]];
check["B2  SIS (g=2): theta_tot = (tE + Sqrt[tE^2 + 4 tB^2])/2 solves th = tE + tB^2/th",
  FullSimplify[Module[{tt = (tE + Sqrt[tE^2 + 4 tB^2])/2},
     tt == alphaPL[tt, tE, 2] + tB^2/tt], Assumptions -> tE > 0 && tB > 0]];
(* series: th = 1 + eps, eps = c1 m + O(m^2); insert into th^(g-1) = 1 + m th^(g-3) *)
Module[{c1, c2, ser, sol},
  ser = Series[(1 + c1 mm + c2 mm^2)^(g - 1) - 1 - mm (1 + c1 mm + c2 mm^2)^(g - 3), {mm, 0, 2}];
  sol = Solve[{SeriesCoefficient[ser, 1] == 0, SeriesCoefficient[ser, 2] == 0}, {c1, c2}];
  check["B3a theta_tot/tE = 1 + m/(g-1) + O(m^2)",
    FullSimplify[(c1 /. First[sol]) == 1/(g - 1)]];
  Print["     second-order coefficient c2 = ", FullSimplify[c2 /. First[sol]]];
];
Module[{gg = 19/10, mm = 1/100, tt},
  tt = thTot[gg, mm];
  check["B3b g=1.9, m=0.01: theta_tot/tE = 1.010984 (exact root) vs 1 + m/(g-1) = 1.011111",
    Abs[tt - 1.0109844] < 1*^-7 && Abs[N[1 + mm/(gg - 1)] - 1.011111] < 1*^-6];
  Print["     theta_tot/tE (g=1.9, m=0.01) = ", N[tt, 8], "   first order: ", N[1 + mm/(gg - 1), 8]];
];
(* B4: fixed-slope back-of-envelope *)
etaShift[m1_, B_, g_] := (m1 - m2of[m1, B, g])/(g - 1);
check["B4a eta_tot/eta_PL - 1 = (m1 - m2)/(g-1) + O(m^2)  (ratio of the two B3a expansions)",
  FullSimplify[Normal[Series[(1 + mm1/(g - 1))/(1 + mm2/(g - 1)), {mm1, 0, 1}, {mm2, 0, 1}]]
     - 1 - (mm1 - mm2)/(g - 1) - (-(mm1 mm2)/(g - 1)^2)] == 0];
check["B4b back-of-envelope  = m1 (1 - B^((3-g)/(g-1)))/(g-1)",
  FullSimplify[etaShift[m1, B, g] == m1 (1 - B^((3 - g)/(g - 1)))/(g - 1)]];
Module[{gg = 19/10, BB = 8/10, mm = 1/100, exact, boe},
  exact = thTot[gg, mm]/thTot[gg, N[m2of[mm, BB, gg], wp]] - 1;
  boe = N[etaShift[mm, BB, gg]];
  check["B4c g=1.9, B=0.8, m1=0.01: BoE deta/eta = 2.652e-3; exact eta_tot/eta_PL-1 = 2.578e-3 (within 5%)",
    Abs[boe - 0.00265225] < 1*^-8 && Abs[exact - 0.00257776] < 1*^-8 && Abs[exact/boe - 1] < 0.05];
  check["B4d fixed-slope dB/B = (g-1) deta/eta = m1(1-B^p) = 2.387e-3 at the same values",
    Abs[(gg - 1) boe - 0.00238702] < 1*^-8];
  Print["     BoE deta/eta = ", boe, ";  exact (total-mass radii) = ", N[exact, 6],
        ";  (g-1) x BoE = ", N[(gg - 1) boe, 6]];
];

(* ---------------------------------------------------------------------
   (C) Two channels
   --------------------------------------------------------------------- *)
Print["\n--- (C) two-channel decomposition ---"];
check["C1  dlnB = (g-1) d ln(eta) + ln(eta) dg  (total differential of ln B = (g-1) ln eta)",
  FullSimplify[D[Log[eta^(g - 1)], eta] eta == (g - 1) && D[Log[eta^(g - 1)], g] == Log[eta],
    Assumptions -> eta > 0]];
check["C2  ln(eta) < 0 for 0 < eta < 1: a steeper fitted slope (dg>0) lowers B",
  Reduce[0 < eta < 1 && Log[eta] >= 0, eta, Reals] === False];

(* ---------------------------------------------------------------------
   (D) Annihilation boundary of the radial critical curve
   plane units (tE of the plane = 1), u = m of that plane:
     y(th) = th - th^(2-g) - u/th
   --------------------------------------------------------------------- *)
Print["\n--- (D) annihilation boundary ---"];
yS[th_, g_, u_] := th - th^(2 - g) - u/th;
yp[th_, g_, u_] := 1 - (2 - g) th^(1 - g) + u/th^2;
ypp[th_, g_, u_] := (2 - g) (g - 1) th^(-g) - 2 u/th^3;
check["D1  y' and y'' from y = th - th^(2-g) - u/th  (y' = lambda_r of PL + point mass)",
  FullSimplify[D[yS[th, g, u], th] == yp[th, g, u] && D[yS[th, g, u], {th, 2}] == ypp[th, g, u],
    Assumptions -> th > 0] &&
  FullSimplify[1 - D[alphaPL[th, 1, g] + u/th, th] == yp[th, g, u], Assumptions -> th > 0]];
check["D2  th^3 y'' = (2-g)(g-1) th^(3-g) - 2u  =>  th*^(3-g) = 2u/((2-g)(g-1))",
  FullSimplify[th^3 ypp[th, g, u] == (2 - g) (g - 1) th^(3 - g) - 2 u, Assumptions -> th > 0]];
(* closed form of the double root *)
thStar[g_] := ((2 - g) (3 - g)/2)^(1/(g - 1));
m2crit[g_] := (2 - g) (g - 1)/2 thStar[g]^(3 - g);
m1crit[g_, B_] := m2crit[g] B^((g - 3)/(g - 1));
check["D3a closed form: y'(th*) = 0 and y''(th*) = 0 at th* = [(2-g)(3-g)/2]^(1/(g-1)), u = m2crit(g)",
  FullSimplify[{yp[thStar[g], g, m2crit[g]], ypp[thStar[g], g, m2crit[g]]} == {0, 0},
    Assumptions -> 1 < g < 2]];
check["D3b m_crit = ((2-g)(g-1)/2) [(2-g)(3-g)/2]^((3-g)/(g-1))",
  FullSimplify[m2crit[g] == ((2 - g) (g - 1)/2) ((2 - g) (3 - g)/2)^((3 - g)/(g - 1)),
    Assumptions -> 1 < g < 2]];
check["D3c th* = theta_r ((3-g)/2)^(1/(g-1)) < theta_r (boundary sits inside the PL radial curve)",
  FullSimplify[thStar[g] == thetaR[1, g] ((3 - g)/2)^(1/(g - 1)), Assumptions -> 1 < g < 2] &&
  Reduce[1 < g < 2 && ((3 - g)/2)^(1/(g - 1)) >= 1, g, Reals] === False];
(* route 2: the source note's route -- FindRoot of y'(th*(u)) = 0 with th*(u) from y''=0 *)
thStarU[g_, u_] := (2 u/((2 - g) (g - 1)))^(1/(3 - g));
uRoute2[g_] := u /. FindRoot[yp[thStarU[g, u], g, u] == 0, {u, m2crit[N[g]]/2, 2 m2crit[N[g]]},
                     WorkingPrecision -> wp, Method -> "Brent"];
(* route 3: lambda_r stationary point -- bisect on u until min_{th>0} y' = 0 *)
minYp[g_, u_] := Module[{s}, s = FindMinimum[{yp[t, g, u], t > 0}, {t, thStar[g]},
                          WorkingPrecision -> wp]; First[s]];
uRoute3[g_] := Module[{lo = 0, hi = 1/10, mid},
  Do[mid = (lo + hi)/2; If[minYp[g, mid] < 0, lo = mid, hi = mid], {60}]; N[(lo + hi)/2, 20]];
gGrid = {14/10, 15/10, 16/10, 17/10, 18/10, 19/10};
r2 = Table[Abs[uRoute2[gg] - m2crit[gg]], {gg, gGrid}];
r3 = Table[Abs[uRoute3[gg] - m2crit[gg]]/m2crit[gg], {gg, gGrid}];
check["D4  closed form = FindRoot route (y''=0 then y'=0) to < 1e-30 on g in {1.4,...,1.9}",
  Max[r2] < 10^-30];
check["D5  closed form = bisection on min_th lambda_r = 0 (60 halvings) to < 1e-12 relative",
  Max[r3] < 10^-12];
Print["     max |closed - route2| = ", N[Max[r2], 3], ";  max rel |closed - bisection| = ", N[Max[r3], 3]];
tab = Table[{N[gg, 3], N[thStar[gg], 6], N[m2crit[gg], 6], N[m1crit[gg, 8/10], 6]}, {gg, gGrid}];
Print["     g     th*        m2crit      m1crit(B=0.8)"];
Do[Print["     ", r], {r, tab}];
check["D6a m_crit(1.6) = 0.0061548 (own plane); m1_crit(1.6, B=0.8) = 0.010360",
  Abs[N[m2crit[16/10]] - 0.00615484] < 1*^-8 && Abs[N[m1crit[16/10, 8/10]] - 0.0103595] < 1*^-7];
check["D6b m_crit(1.9) = 0.0012991; m1_crit(1.9, B=0.8) = 0.0017065 (< 0.01)",
  Abs[N[m2crit[19/10]] - 0.00129914] < 1*^-8 && Abs[N[m1crit[19/10, 8/10]] - 0.00170648] < 1*^-8 &&
  N[m1crit[19/10, 8/10]] < 1/100];
check["D6c table: m_crit = 0.006370, 0.006592, 0.005043, 0.003326 at g = 1.4, 1.5, 1.7, 1.8; m1_crit(B=0.8) = 0.015552, 0.012875, 0.007632, 0.004648",
  Max[Abs[N[m2crit /@ {14/10, 15/10, 17/10, 18/10}] - {0.0063701, 0.0065918, 0.0050429, 0.0033255}]] < 1*^-7 &&
  Max[Abs[N[m1crit[#, 8/10] & /@ {14/10, 15/10, 17/10, 18/10}] - {0.015552, 0.0128746, 0.0076323, 0.0046476}]] < 1*^-6];
check["D6e table: th* = 0.160, 0.141, 0.120, 0.097, 0.071, 0.040 at g = 1.4 ... 1.9",
  Max[Abs[N[thStar /@ gGrid] - {0.15963, 0.14063, 0.11984, 0.09678, 0.07063, 0.03985}]] < 1*^-5];
check["D6d SIS-adjacent exact value: at g = 3/2, th* = 9/64 and m_crit = 27/4096",
  thStar[3/2] == 9/64 && m2crit[3/2] == 27/4096];
check["D7a limits: m_crit -> 0 as g -> 2^- and as g -> 1^+",
  Limit[m2crit[g], g -> 2, Direction -> "FromBelow"] == 0 &&
  Abs[N[m2crit[1 + 10^-3]]] < 10^-3 && Abs[N[m2crit[2 - 10^-3]]] < 10^-3];
gmax = g /. FindMaximum[{m2crit[g], 105/100 < g < 195/100}, {g, 13/10}, WorkingPrecision -> 30][[2]];
check["D7b m_crit(g) has a single interior maximum near g = 1.48, value 0.00660 (never above 0.0066)",
  Abs[gmax - 1.4846] < 0.001 && Abs[N[m2crit[gmax]] - 0.0065996] < 1*^-6];
Print["     max of m_crit: g = ", N[gmax, 5], ", m_crit = ", N[m2crit[gmax], 5]];
(* below the boundary y' has two positive roots (radial critical curve + inner BH curve); above, none *)
nRoots[g_, u_] := Module[{v = Sign[yp[#, g, u] & /@ Range[10^-4, 2, 10^-4]]},
   Count[Differences[v], d_ /; d != 0]];
check["D8  g=1.6: two sign changes of y' at u = 0.5 m_crit, none at u = 1.5 m_crit",
  nRoots[1.6, 0.5 N[m2crit[16/10]]] == 2 && nRoots[1.6, 1.5 N[m2crit[16/10]]] == 0];
(* Fix pass 2026-10-14 (N-R5): the boundary is for an AXISYMMETRIC lens. Along the axis of an
   external shear ge on the radial-image plane, lambda_r = 1 - ge - alpha'(th); rescaling
   th = (1-ge)^(-1/(g-1)) X maps it onto the axisymmetric problem with u -> u (1-ge)^((3-g)/(g-1)),
   so m_crit is multiplied by (1-ge)^(-(3-g)/(g-1)) > 1. *)
ypS[th_, g_, u_, ge_] := 1 - ge - (2 - g) th^(1 - g) + u/th^2;
check["D9a on-axis shear: y' and dy'/dth vanish at th = (1-ge)^(-1/(g-1)) th*, u = m_crit (1-ge)^(-(3-g)/(g-1))",
  And @@ Flatten[Table[
    FullSimplify[{ypS[th, gg, m2crit[gg] (1 - ge)^(-(3 - gg)/(gg - 1)), ge],
                  D[ypS[th, gg, m2crit[gg] (1 - ge)^(-(3 - gg)/(gg - 1)), ge], th]} /.
                 th -> (1 - ge)^(-1/(gg - 1)) thStar[gg], Assumptions -> 0 < ge < 1] == {0, 0},
    {gg, {7/5, 3/2, 8/5, 9/5}}]]];
Module[{bis, r},
  bis[gg_, ge_] := Module[{lo = 0, hi = 1/10, mid},
    Do[mid = (lo + hi)/2;
       If[First[FindMinimum[{ypS[t, gg, mid, ge], t > 0}, {t, (1 - ge)^(-1/(gg - 1)) thStar[gg]},
            WorkingPrecision -> wp]] < 0, lo = mid, hi = mid], {60}]; (lo + hi)/2];
  r = Table[N[bis[gg, 1/10]/m2crit[gg], 12], {gg, {14/10, 16/10, 18/10}}];
  Print["     on-axis shear 0.1: m_crit ratio (bisection) = ", r, "  closed form = ",
        N[Table[(9/10)^(-(3 - gg)/(gg - 1)), {gg, {14/10, 16/10, 18/10}}], 6]];
  check["D9b bisection on min lambda_r (shear 0.1, on axis) = (0.9)^(-(3-g)/(g-1)) = 1.524, 1.279, 1.171 at g = 1.4, 1.6, 1.8",
    Max[Abs[r - N[Table[(9/10)^(-(3 - gg)/(gg - 1)), {gg, {14/10, 16/10, 18/10}}]]]] < 1*^-9 &&
    Max[Abs[r - {1.52416, 1.27870, 1.17121}]] < 1*^-5]];
(* Fix pass 2026-10-14 (N-R6): a point mass alone has no radial critical curve; the inner zero of
   y' is the inner edge of the PL's lambda_r < 0 region, not a curve "of the black hole". *)
check["D10 point mass alone: lambda_r = 1 + u/th^2 > 0; at both zeros of y' (g=1.6, u=0.5 m_crit) the PL's own lambda_r < 0",
  Reduce[u > 0 && th > 0 && 1 - D[u/x, x] <= 0 /. x -> th, {u, th}, Reals] === False &&
  Module[{uu = N[m2crit[16/10]/2, wp], zs},
    zs = Select[x /. NSolve[yp[x, 16/10, uu] == 0 && 0 < x < 1, x, Reals, WorkingPrecision -> wp], Positive];
    Print["     zeros of y' at g=1.6, u=0.5 m_crit: ", N[zs, 6]];
    Length[zs] == 2 && AllTrue[zs, 1 - (2 - 16/10) #^(1 - 16/10) < 0 &]]];

(* ---------------------------------------------------------------------
   (E) Brute-force power-law-only fit vs the linear-response formula
   Units: plane-1 PL normalisation tE1 = 1. Truth: slope g0, ratio B0,
   point mass m1 on plane 1 (u1 = m1, u2 = m1/B0). Sources b1 (plane 1, in
   tE1 units) and b2 = f2 * tE2 (plane 2). Observables: the tangential pair
   on plane 1 (main + counter-image) and main + counter + RADIAL image on
   plane 2 (5 positions). The central point-mass image is assumed undetected.
   Fit parameters p = (t1, t2, g) [+ the two source positions].
   --------------------------------------------------------------------- *)
Print["\n--- (E) brute-force fit vs linear response ---"];
ySgn[th_, t_, g_, u_] := th - Sign[th] t^(g - 1) Abs[th]^(2 - g) - u/th;
grid[tE_] := tE 10^Range[-11, Log10[3], 1/300];
bracketRoots[f_, xs_] := Table[If[f[xs[[i]]] f[xs[[i + 1]]] < 0,
    x /. FindRoot[f[x] == 0, {x, xs[[i]], xs[[i + 1]]}, WorkingPrecision -> wp, Method -> "Brent"],
    Nothing], {i, Length[xs] - 1}];
images[t_, g_, u_, b_] := Sort[Join[-bracketRoots[(ySgn[-#, t, g, u] - b) &, grid[t]],
                                      bracketRoots[(ySgn[#, t, g, u] - b) &, grid[t]]]];
(* optional u2in: plane-2 point-mass term tB2^2 (tE1 units); default = physical m1/B0.
   u2in = m1 t2^2 is the counterfactual m2 = m1 of check E13. *)
synth[g0_, B0_, m1_, b1_, f2_, u2in_: Automatic] := Module[{t2 = N[B0^(-1/(g0 - 1)), wp], i1, i2},
  i1 = images[1, g0, N[m1, wp], N[b1, wp]];
  i2 = images[t2, g0, N[If[u2in === Automatic, m1/B0, u2in], wp], N[f2 t2, wp]];
  If[(m1 > 0 && Length[i2] != 4) || (m1 == 0 && Length[i2] != 3), Return[$Failed]];
  {{Max[i1], Min[i1]}, {Max[i2], Min[i2], i2[[2]]}}];      (* {A1,B1}, {A2,B2,R2} *)
(* source-plane constraints of a PL-only model: all images of a plane map to one source *)
cons[o_, t1_, t2_, g_] := Module[{yp1 = ySgn[#, t1, g, 0] &, yp2 = ySgn[#, t2, g, 0] &},
  {yp1[o[[1, 1]]] - yp1[o[[1, 2]]], yp2[o[[2, 1]]] - yp2[o[[2, 2]]], yp2[o[[2, 1]]] - yp2[o[[2, 3]]]}];
bruteFit[g0_, B0_, m1_, b1_, f2_, u2in_: Automatic] := Module[{o, t2 = N[B0^(-1/(g0 - 1)), wp], chi2, sol, t1v, t2v, gv},
  o = synth[g0, B0, m1, b1, f2, u2in]; If[o === $Failed, Return[$Failed]];
  chi2[a_?NumericQ, b_?NumericQ, c_?NumericQ] := Total[cons[o, a, b, c]^2];
  sol = FindMinimum[chi2[a, b, c], {{a, 1}, {b, t2}, {c, N[g0, wp]}}, WorkingPrecision -> wp,
                    AccuracyGoal -> 30, PrecisionGoal -> 20, MaxIterations -> 500];
  {t1v, t2v, gv} = {a, b, c} /. sol[[2]];
  <|"t1" -> t1v, "t2" -> t2v, "g" -> gv, "chi2" -> sol[[1]], "o" -> o,
    "dBB" -> (t1v/t2v)^(gv - 1)/B0 - 1|>];
(* image-plane linear response:  o(p, m) ; s = do/dm at m=0 ; J = do/dp ; dp = J^-1 s m.
   p = (t1, t2, g, b1, b2). For an image th on plane i: y_i(th) = b_i, so
   dth/dq = (db_i/dq - dy_i/dq)/y_i'(th). *)
linResp[g0_, B0_, b1_, f2_] := Module[{t2 = N[B0^(-1/(g0 - 1)), wp], o0, imgs, J, s, dth, dp},
  o0 = synth[g0, B0, 0, b1, f2];
  imgs = {{o0[[1, 1]], 1}, {o0[[1, 2]], 1}, {o0[[2, 1]], 2}, {o0[[2, 2]], 2}, {o0[[2, 3]], 2}};
  dth[th_, pl_] := Module[{yy, tt = If[pl == 1, 1, t2], dydth, row, sm},
    yy[T1_, T2_, G_, U_] := ySgn[th, If[pl == 1, T1, T2], G, U];
    dydth = D[ySgn[z, tt, gg, 0], z] /. {z -> th, gg -> N[g0, wp]};
    row = -{D[yy[T1, T2, G, 0], T1], D[yy[T1, T2, G, 0], T2], D[yy[T1, T2, G, 0], G]} /.
            {T1 -> 1, T2 -> t2, G -> N[g0, wp]};
    row = Join[row, If[pl == 1, {1, 0}, {0, 1}]];                       (* d b_i / d (b1,b2) *)
    (* point mass: u1 = m, u2 = m/B0; dy/dm = -1/th (plane 1), -1/(B0 th) (plane 2) *)
    sm = (1/(If[pl == 1, 1, B0] th));
    {row/dydth, sm/dydth}];
  {J, s} = Transpose[dth @@@ imgs];
  dp = LinearSolve[J, s];                                              (* dp/dm *)
  <|"dpdm" -> dp, "t2" -> t2,
    "dBBdm" -> (g0 - 1) (dp[[1]] - dp[[2]]/t2) + Log[1/t2] dp[[3]],
    "etaChdm" -> (g0 - 1) (dp[[1]] - dp[[2]]/t2), "slopeChdm" -> Log[1/t2] dp[[3]]|>];

{g0, B0, b1, f2} = {16/10, 8/10, 15/100, 3/10};
lr = linResp[g0, B0, b1, f2];
Print["     linear response (g=1.6, B=0.8, b1=0.15 tE1, b2=0.3 tE2):"];
Print["       d(dB/B)/dm1 = ", N[lr["dBBdm"], 6], "  eta channel ", N[lr["etaChdm"], 6],
      "  slope channel ", N[lr["slopeChdm"], 6], "  dg/dm1 = ", N[lr["dpdm"][[3]], 6]];
oTruth = synth[g0, B0, 10^-3, b1, f2];
check["E1  synthetic images (with point mass) map back to their sources to < 1e-30",
  Module[{t2 = N[B0^(-1/(g0 - 1)), wp]},
    Max[Abs[{ySgn[#, 1, g0, 10^-3] - b1 & /@ oTruth[[1]],
             ySgn[#, t2, g0, 10^-3/B0] - f2 t2 & /@ oTruth[[2]]}]] < 10^-30]];
fits = Association[Table[mm -> bruteFit[g0, B0, mm, b1, f2], {mm, {10^-4, 3 10^-4, 10^-3, 3 10^-3}}]];
Do[Print["       m1=", N[mm], "  brute dB/B=", N[fits[mm]["dBB"], 6], "  linear=",
         N[lr["dBBdm"] mm, 6], "  dg=", N[fits[mm]["g"] - g0, 5], "  chi2=", N[fits[mm]["chi2"], 3]],
   {mm, Keys[fits]}];
check["E10 table values: brute dB/B = -0.0428%, -0.1297%, -0.449%, -1.589%; dg = 0.00157, 0.00476, 0.0166, 0.0600 at m1 = 1e-4, 3e-4, 1e-3, 3e-3",
  Max[Abs[100 (fits[#]["dBB"] & /@ Keys[fits]) - {-0.042798, -0.129701, -0.449473, -1.588633}]] < 1*^-5 &&
  Max[Abs[(fits[#]["g"] - g0 & /@ Keys[fits]) - {0.0015666, 0.0047554, 0.0165809, 0.0600055}]] < 1*^-6];
check["E11 linear coefficients: d(dB/B)/dm1 = -4.259 = eta channel +1.534 + slope channel -5.793; dg/dm1 = +15.58",
  Abs[lr["dBBdm"] + 4.25887] < 1*^-4 && Abs[lr["etaChdm"] - 1.53433] < 1*^-4 &&
  Abs[lr["slopeChdm"] + 5.79319] < 1*^-4 && Abs[lr["dpdm"][[3]] - 15.5770] < 1*^-3];
check["E2  PL-only model fits the 5 biased positions PERFECTLY (chi2 < 1e-35, i.e. zero): bias is hidden",
  AllTrue[Values[fits], #["chi2"] < 10^-35 &]];
check["E3a linear response matches brute force to < 1% at m1 = 1e-4",
  Abs[fits[10^-4]["dBB"]/(lr["dBBdm"] 10^-4) - 1] < 0.01];
check["E3a' ... the actual agreement at m1 = 1e-4 is 0.5% (between 0.4% and 0.6%)",
  0.004 < Abs[fits[10^-4]["dBB"]/(lr["dBBdm"] 10^-4) - 1] < 0.006];
check["E12 near plane, b1 = 0.15: 4 images at m1 = 1e-4 (radial image at |th| < 0.01, |mu| < 0.05); only the tangential pair for m1 >= 3e-4",
  Module[{i1 = images[1, g0, N[10^-4, wp], N[b1, wp]], rad, mu},
    rad = i1[[2]];
    (* axisymmetric: lambda_r = y'(th), lambda_t = 1 - alpha/th = y(th)/th *)
    mu = 1/(yp[Abs[rad], g0, N[10^-4, wp]] (ySgn[rad, 1, g0, N[10^-4, wp]]/rad));
    Print["       near-plane images at m1=1e-4: ", N[i1, 5], "  radial-image |mu| = ", N[Abs[mu], 3]];
    Length[i1] == 4 && Abs[rad] < 0.01 && Abs[mu] < 0.05] &&
  AllTrue[{3 10^-4, 10^-3, 3 10^-3}, Length[images[1, g0, N[#, wp], N[b1, wp]]] == 2 &]];
check["E3b ... to < 10% at m1 = 1e-3 (still first-order regime)",
  Abs[fits[10^-3]["dBB"]/(lr["dBBdm"] 10^-3) - 1] < 0.10];
check["E3c residual (brute - linear) scales as m1^2: ratio over a factor 3 in m1 is in [6,12]",
  Module[{e1 = fits[10^-4]["dBB"] - lr["dBBdm"] 10^-4, e3 = fits[3 10^-4]["dBB"] - lr["dBBdm"] 3 10^-4},
    6 < e3/e1 < 12]];
check["E4  image-plane J^-1 s equals the brute-force derivative (finite difference at m1=1e-8)",
  Module[{f = bruteFit[g0, B0, 10^-8, b1, f2]},
    Print["       FD: dg/dm = ", N[(f["g"] - g0)/10^-8, 8], " vs J^-1 s: ", N[lr["dpdm"][[3]], 8]];
    Abs[((f["g"] - g0)/10^-8)/lr["dpdm"][[3]] - 1] < 10^-5 &&
    Abs[(f["dBB"]/10^-8)/lr["dBBdm"] - 1] < 10^-5]];
check["E5  signs (this configuration): dg>0 (steeper), eta channel >0, slope channel <0, net dB/B <0",
  lr["dpdm"][[3]] > 0 && lr["etaChdm"] > 0 && lr["slopeChdm"] < 0 && lr["dBBdm"] < 0 &&
  AllTrue[Values[fits], #["dBB"] < 0 &]];
check["E6  slope channel dominates: |slope| / |eta| channel > 3 here",
  Abs[lr["slopeChdm"]/lr["etaChdm"]] > 3];
check["E7  eta + slope channels = linear dB/B (decomposition closes)",
  Abs[lr["etaChdm"] + lr["slopeChdm"] - lr["dBBdm"]] < 10^-30];
(* configuration dependence: same lens, plane-2 source at 0.2 tE2 instead of 0.3 tE2 *)
lrB = linResp[g0, B0, b1, 2/10];
check["E8  same lens, b2 = 0.2 tE2: |d(dB/B)/dm1| changes by > x3 (bias depends on image geometry)",
  Abs[lrB["dBBdm"]/lr["dBBdm"]] > 3];
Print["       d(dB/B)/dm1 at b2 = 0.2 tE2: ", N[lrB["dBBdm"], 6], "  (vs ", N[lr["dBBdm"], 6], " at 0.3)"];
(* fixed-slope fit: tangential pairs only, g held at truth -> direct channel only; compare BoE *)
fixedFit[g0_, B0_, m1_, b1_, f2_] := Module[{t2 = N[B0^(-1/(g0 - 1)), wp], o, i1, i2, sol},
  (* tangential pairs only (main + counter-image on each plane); no radial image needed *)
  i1 = images[1, g0, N[m1, wp], N[b1, wp]]; i2 = images[t2, g0, N[m1/B0, wp], N[f2 t2, wp]];
  o = {{Max[i1], Min[i1]}, {Max[i2], Min[i2], Max[i2]}};
  sol = FindRoot[Most[cons[o, a, b, N[g0, wp]]] == {0, 0}, {{a, 1}, {b, t2}}, WorkingPrecision -> wp];
  ((a/b)^(g0 - 1) /. sol)/B0 - 1];
boeB = N[(g0 - 1) etaShift[10^-3, B0, g0]];
check["E9c BoE fixed-slope dB/B at g=1.6, B=0.8, m1=1e-3 is +0.0406%, an order of magnitude below |exact| = 0.449%",
  Abs[100 boeB - 0.0405877] < 1*^-6 && 10 < Abs[fits[10^-3]["dBB"]]/boeB < 12];
ffs = Table[{bb, fixedFit[g0, B0, 10^-3, bb, bb]}, {bb, {2/100, 5/100, 1/10, 2/10, 3/10}}];
Do[Print["       fixed-slope fit, b1 = b2/tE2 = ", N[r[[1]]], ": dB/B = ", N[r[[2]], 6],
         "  (ratio to BoE ", N[r[[2]]/boeB, 4], ")"], {r, ffs}];
Print["       BoE m1(1-B^p) at m1 = 1e-3: ", N[boeB, 6]];
check["E9a fixed-slope fit, images near the ring (b = 0.02): dB/B > 0, within 10% of BoE m1(1-B^p)",
  ffs[[1, 2]] > 0 && Abs[ffs[[1, 2]]/boeB - 1] < 0.10];
check["E9b ... and the agreement degrades monotonically as the sources move off-axis",
  Module[{rr = ffs[[All, 2]]/boeB}, And @@ Thread[Differences[Abs[rr - 1]] > 0]]];
(* Fix pass 2026-10-14 (N-R4): the keybox quotes 0.3% at equal offsets 0.02 and x1.75 at 0.3;
   at the worked example's UNEQUAL offsets (b1, b2) = (0.15, 0.3) even a fixed-slope fit returns
   only 0.084 of the estimate: the per-plane shifts nearly cancel. *)
check["E9d equal offsets: fixed-slope fit / estimate = 0.997 at 0.02 (0.3%) and 1.75 at 0.3",
  Abs[ffs[[1, 2]]/boeB - 0.9974] < 0.0005 && Abs[ffs[[5, 2]]/boeB - 1.7467] < 0.001];
ffUneq = fixedFit[g0, B0, 10^-3, b1, f2];
Print["       fixed-slope fit at (b1, b2/tE2) = (0.15, 0.3): dB/B = ", N[ffUneq, 6], "  ratio to estimate ", N[ffUneq/boeB, 4]];
check["E9e unequal offsets (0.15, 0.3): fixed-slope fit / estimate = 0.084 (not an order-of-magnitude match)",
  Abs[ffUneq/boeB - 0.0844] < 0.0005 && ffUneq/boeB < 0.1];
(* Fix pass 2026-10-14 (N-R1): counterfactual m2 = m1 (u2 = m1 t2^2). The total-mass radii ratio is
   unchanged, but the fitted ratio is NOT: the free-slope bias is 1.87x the physical one. *)
Module[{t2 = N[B0^(-1/(g0 - 1)), wp], fEq, rTot},
  fEq = bruteFit[g0, B0, 10^-4, b1, f2, 10^-4 t2^2];
  rTot = (thTot[g0, 10^-4]/(t2 thTot[g0, 10^-4]))/(1/t2) - 1;
  Print["       counterfactual m2 = m1 = 1e-4: dB/B = ", N[fEq["dBB"], 6], " (physical ", N[fits[10^-4]["dBB"], 6],
        "), ratio ", N[fEq["dBB"]/fits[10^-4]["dBB"], 5], ", chi2 = ", N[fEq["chi2"], 3]];
  check["E13 m2 = m1: total-mass-radius ratio unchanged, but fitted dB/B = -0.0798% = 1.87 x physical (not zero)",
    Abs[rTot] < 10^-30 && fEq["chi2"] < 10^-35 && Abs[100 fEq["dBB"] + 0.079819] < 1*^-5 &&
    Abs[fEq["dBB"]/fits[10^-4]["dBB"] - 1.865] < 0.001]];

(* ---------------------------------------------------------------------
   (F) Propagation to w (illustrative flat wCDM, Om = 0.3; H0 cancels in B)
   --------------------------------------------------------------------- *)
Print["\n--- (F) propagation to w ---"];
chi[z_?NumericQ, w_?NumericQ, Om_] := NIntegrate[1/Sqrt[Om (1 + zz)^3 + (1 - Om) (1 + zz)^(3 (1 + w))],
                                         {zz, 0, z}, WorkingPrecision -> 30];
Bw[zd_, z1_, z2_, w_, Om_] := (1 - chi[zd, w, Om]/chi[z1, w, Om])/(1 - chi[zd, w, Om]/chi[z2, w, Om]);
check["F1  flat universe: B = D_ds1 D_s2/(D_s1 D_ds2) = (1 - chi_d/chi_1)/(1 - chi_d/chi_2)",
  FullSimplify[((c1 - cd)/(1 + z1)) (c2/(1 + z2))/((c1/(1 + z1)) ((c2 - cd)/(1 + z2))) ==
     (1 - cd/c1)/(1 - cd/c2), Assumptions -> c2 > c1 > cd > 0]];
Sw = (Log[Bw[1/2, 1, 2, -1 + 10^-4, 3/10]] - Log[Bw[1/2, 1, 2, -1 - 10^-4, 3/10]])/(2 10^-4);
BLCDM = Bw[1/2, 1, 2, -1, 3/10];
check["F2  (zd,z1,z2) = (0.5,1,2), Om=0.3, w=-1: B = 0.6742, S_w = dlnB/dw = -0.0330 (< 0)",
  Abs[BLCDM - 0.674156] < 1*^-5 && Abs[Sw - (-0.03301)] < 2*^-4 && Sw < 0];
check["F3  dw = (dB/B)/S_w: a -0.5% bias in B gives dw = +0.15 (dB/B < 0 -> dw > 0 here)",
  Abs[(-0.005)/Sw - 0.1515] < 0.002 && (-0.005)/Sw > 0];
check["F4  a change of w by 0.3 changes B by about 1% here (|0.3 S_w| = 0.0099)",
  Abs[Abs[3/10 Sw] - 0.0099] < 2*^-4];
(* Fix pass 2026-10-14 (F5): Module 3 defines the lensing efficiency E = D_d D_ds/D_s; D_ds/D_s is
   proportional to it only at fixed z_d, where the ratio of efficiencies is still B. *)
check["F5  at common D_d: E_1/E_2 = (D_d Dds1/Ds1)/(D_d Dds2/Ds2) = B; E itself is not Dds/Ds",
  FullSimplify[(dd ds1/s1)/(dd ds2/s2) == (ds1/s1)/(ds2/s2)] &&
  FullSimplify[(dd ds1/s1) == ds1/s1, Assumptions -> dd > 0 && ds1 > 0 && s1 > 0] =!= True];
Print["     B = ", N[BLCDM, 6], ",  S_w = ", N[Sw, 5], ",  1/S_w = ", N[1/Sw, 4]];

(* ---------------------------------------------------------------------
   (G) Any unmodelled central excess acts like a point mass outside it
   broken power law: inner slope gi inside tb, outer PL (slope g, norm tE) outside.
   --------------------------------------------------------------------- *)
Print["\n--- (G) central excess = point mass outside its radius ---"];
Module[{kin, kout, Min, alphaOut, dM},
  kout[x_] := kapPL[x, tE, g];
  kin[x_] := kapPL[tb, tE, g] (tb/x)^(gi - 1);   (* continuous at tb, steeper/shallower inside *)
  Min = Integrate[kin[x] x, {x, 0, tb}, Assumptions -> tb > 0 && 1 < gi < 3 && 1 < g < 3 && tE > 0];
  alphaOut = (2/th) (Min + Integrate[kout[x] x, {x, tb, th}, Assumptions -> th > tb > 0 && 1 < g < 3 && tE > 0]);
  dM = 2 (Min - Integrate[kout[x] x, {x, 0, tb}, Assumptions -> tb > 0 && 1 < g < 3 && tE > 0]);
  check["G1  for th > tb: alpha = alpha_PL(th) + tb_eff^2/th with tb_eff^2 = 2 Int_0^tb (k_in - k_PL) x dx",
    FullSimplify[alphaOut == alphaPL[th, tE, g] + dM/th,
      Assumptions -> th > tb > 0 && 1 < gi < 3 && 1 < g < 3 && tE > 0]];
  check["G2  tb_eff^2 > 0 iff the inner slope is steeper (gi > g)",
    Module[{v = dM /. {tE -> 1, tb -> 1/10, g -> 19/10}},
      N[v /. gi -> 21/10] > 0 && N[v /. gi -> 17/10] < 0]];
];
(* Fix pass 2026-10-14 (F3): the equivalence needs axisymmetry. A unit point mass displaced by 0.1
   from the centre deflects a ray at (1, 0) by 1/0.9, i.e. 11% more than a central one. *)
check["G3  off-centre point mass (offset 0.1) at th = 1: |alpha| = 1/0.9 = 1.111 vs 1 for a central one",
  Module[{a = Norm[{1, 0} - {1/10, 0}]^-1}, a == 10/9 && Abs[N[a - 1] - 0.111] < 0.001]];

(* ---------------------------------------------------------------------
   Figures
   --------------------------------------------------------------------- *)
Print["\n--- figures ---"];
yrPL[gg_] := Module[{tr = thetaR[1, gg]}, tr^(2 - gg) - tr];   (* PL radial caustic, plane units *)
fig1data = Table[
  Module[{ff2 = Rationalize[N[9/10 yrPL[gg]], 10^-6], lrg, pts, mc = m1crit[gg, B0]},
    lrg = linResp[gg, B0, b1, ff2];
    pts = Select[Table[Module[{f = bruteFit[gg, B0, fr mc, b1, ff2]},
        If[f === $Failed, Nothing, {fr mc, f["dBB"]}]], {fr, {1/50, 1/20, 1/10, 3/20, 1/5, 1/4, 3/10, 7/20, 2/5}}],
        ListQ];
    {gg, lrg["dBBdm"], pts, mc, ff2}], {gg, {16/10, 18/10}}];
Do[Print["     g=", N[d[[1]]], " slope=", N[d[[2]], 5], " npts=", Length[d[[3]]], " m1crit=", N[d[[4]], 5], " b2/tE2=", N[d[[5]], 5], " pts=", N[d[[3]], 4]],
   {d, fig1data}];
check["FIG1 brute-force points exist for both slopes (>= 4 each) and all have dB/B < 0",
  AllTrue[fig1data, Length[#[[3]]] >= 4 && AllTrue[#[[3]], Function[p, p[[2]] < 0]] &]];
check["FIG1b linear slopes d(dB/B)/dm1 = -4.66 (g=1.6, b2=0.293 tE2) and -1.77 (g=1.8, b2=0.481 tE2)",
  Abs[fig1data[[1, 2]] + 4.6616] < 1*^-3 && Abs[fig1data[[2, 2]] + 1.7677] < 1*^-3 &&
  Abs[N[fig1data[[1, 5]]] - 0.29316] < 1*^-4 && Abs[N[fig1data[[2, 5]]] - 0.48149] < 1*^-4];
check["FIG1c near annihilation the exact bias exceeds the linear one (g=1.6, m1 = 0.35 m1crit: |exact| > 1.4 |linear|)",
  Module[{pt = Last[fig1data[[1, 3]]]}, Abs[pt[[2]]] > 1.4 Abs[fig1data[[1, 2]] pt[[1]]]]];
(* Fix pass 2026-10-14 (F2): what the caption may say. Last plotted points are the grid values
   0.35 (g=1.6) and 0.25 (g=1.8) m1crit; the radial image of this source is lost at 0.379 and
   0.293 m1crit; exact/linear at the last points is 1.50 (g=1.6) and only 1.24 (g=1.8). *)
lastRatio[k_] := Module[{pt = Last[fig1data[[k, 3]]]}, pt[[2]]/(fig1data[[k, 2]] pt[[1]])];
radLimit[k_] := Module[{gg = fig1data[[k, 1]], ff2 = fig1data[[k, 5]], mc = fig1data[[k, 4]], t2, has, lo, hi, mid},
  t2 = N[B0^(-1/(gg - 1)), wp];
  has[fr_] := Length[images[t2, gg, N[fr mc/B0, wp], N[ff2 t2, wp]]] == 4;
  {lo, hi} = {Last[fig1data[[k, 3]]][[1]]/mc, 1/2};
  If[!has[lo] || has[hi], Return[$Failed]];
  Do[mid = (lo + hi)/2; If[has[mid], lo = mid, hi = mid], {24}]; N[(lo + hi)/2]];
Print["     last-point m1/m1crit: ", N[Last[#[[3]]][[1]]/#[[4]] & /@ fig1data, 4],
      "  exact/linear: ", N[lastRatio /@ {1, 2}, 4], "  radial-image limits: ", radLimit /@ {1, 2}];
check["FIG1d last plotted points are at 0.35 m1crit (g=1.6) and 0.25 m1crit (g=1.8)",
  Abs[N[Last[fig1data[[1, 3]]][[1]]/fig1data[[1, 4]]] - 0.35] < 1*^-6 &&
  Abs[N[Last[fig1data[[2, 3]]][[1]]/fig1data[[2, 4]]] - 0.25] < 1*^-6];
check["FIG1e exact/linear at the last point = 1.50 (g=1.6) but 1.24 (g=1.8; i.e. NOT > 1.4)",
  Abs[lastRatio[1] - 1.50] < 0.01 && Abs[lastRatio[2] - 1.24] < 0.01 && lastRatio[2] < 1.4];
check["FIG1f this source loses its radial image at m1 = 0.379 m1crit (g=1.6) and 0.293 m1crit (g=1.8)",
  Module[{r = radLimit /@ {1, 2}}, Abs[r[[1]] - 0.379] < 0.001 && Abs[r[[2]] - 0.293] < 0.001]];
cols = {RGBColor[0.8, 0.1, 0.1], RGBColor[0.1, 0.3, 0.8]};
p1 = Show[
  Plot[Evaluate[Table[100 fig1data[[k, 2]] mm, {k, 2}]], {mm, 0, 0.0045},
    PlotStyle -> {{cols[[1]], Dashed}, {cols[[2]], Dashed}}],
  ListPlot[Table[{#[[1]], 100 #[[2]]} & /@ fig1data[[k, 3]], {k, 2}],
    PlotStyle -> {{cols[[1]], PointSize[0.015]}, {cols[[2]], PointSize[0.015]}}],
  PlotRange -> All, Frame -> True, Axes -> False,
  FrameLabel -> {Row[{Subscript["m", "1"]}], Row[{"\[Delta]\[ScriptCapitalB]/\[ScriptCapitalB]  (%)"}]},
  PlotLabel -> "Power-law-only fit to 5 image positions, B = 0.8",
  Epilog -> {Text[Style["\[Gamma]' = 1.6", 12, cols[[1]]], {0.0031, 100 fig1data[[1, 2]] 0.0031}, {-1.3, 0}],
             Text[Style["\[Gamma]' = 1.8", 12, cols[[2]]], {0.0038, 100 fig1data[[2, 2]] 0.0038}, {0, -1.5}]},
  BaseStyle -> {FontFamily -> "Times", FontSize -> 12}, ImageSize -> 520];
Export[FileNameJoin[{figDir, "bias_vs_m.pdf"}], p1];
p2 = LogPlot[{m2crit[gg], m1crit[gg, 8/10]}, {gg, 1.02, 1.98},
  PlotStyle -> {{Black, Thick}, {Darker[Green], Thick, Dashed}},
  Filling -> {2 -> Top}, FillingStyle -> Opacity[0.08, Gray],
  Frame -> True, Axes -> False, PlotRange -> {10^-5, 0.1},
  FrameLabel -> {Row[{"\[Gamma]'"}], Row[{"central mass fraction  m"}]},
  PlotLegends -> Placed[{Row[{Subscript["m", "crit"], "  (fraction on the radial-image plane)"}],
                         Row[{Subscript["m", "1,crit"], "  (near-plane fraction, B = 0.8)"}]}, {0.4, 0.2}],
  Epilog -> {Text[Style["radial critical curve and radial image destroyed", 11], {1.62, Log[0.045]}],
             Red, PointSize[0.018], Point[{1.9, Log[0.01]}],
             Text[Style[Row[{"\[Gamma]' = 1.9, ", Subscript["m", "1"], " = 0.01"}], 10, Red], {1.78, Log[0.016]}]},
  BaseStyle -> {FontFamily -> "Times", FontSize -> 12}, ImageSize -> 480];
Export[FileNameJoin[{figDir, "annihilation_boundary.pdf"}], p2];
check["FIG2 both figure files exported",
  FileExistsQ[FileNameJoin[{figDir, "bias_vs_m.pdf"}]] && FileExistsQ[FileNameJoin[{figDir, "annihilation_boundary.pdf"}]]];

summary[];
