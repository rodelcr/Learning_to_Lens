(* =========================================================================
   problems_17.wl
   Module 17: How an Unmodelled Central Mass Biases a Compound Lens
   Worked solutions to the Problems section
   =========================================================================
   Purpose: Deterministic attestation of every symbolic and numeric answer
            in Notes/17_Central_Mass_Bias/17_Solutions.tex.

   Exercises solved:
     ex:cb_two_channels    two-channel bias at eta=0.79, deta/eta=+0.5%,
                           dg=+0.03, g=1.6; dependence on eta
     ex:cb_annihilation    closed-form annihilation boundary; g=1.6 values;
                           near-plane conversion; maximum over g
     ex:cb_differential    m2 = m1 B^((3-g)/(g-1)); ratio bias vanishes iff
                           m2 = m1
     ex:cb_coherent        coherent systematic vs N^(-1/2) statistics;
                           propagation to w
     ex:cb_real_system     fixed-slope estimate for a given M_BH and
                           M(<theta_E); radial-image survival at g=1.6, 1.9
     ex:cb_sis_point_mass  SIS + point mass: theta_tot closed form, series,
                           absence of a radial critical curve
     ex:cb_central_excess  a steeper inner cusp acts as a point mass outside
                           the break radius (theta_b = 0.02 < theta*, far-plane
                           units, compared with m_crit(1.9))
   Fix pass 2026-10-14 (FACT_CRITIC_17 F1, F4): checks 2h-2i (gamma' -> 1 limit
   of the annihilation boundary: uniform sheet, not a shrinking radial curve);
   7b-7c and 7e-7f rewritten (theta_b = 0.02 instead of 0.1; same-plane
   comparison with m_crit).

   Sources: Chapter 17 of these notes (all identities derived there and
            verified in Mathematica/17_Central_Mass_Bias/central_mass_bias.wl);
            flat-FRW distances as in Solutions/03_Cosmological_Distances.

   Usage:   bash Mathematica/run_wl.sh Solutions/17_Central_Mass_Bias/problems_17.wl

   Outputs: PASS/FAIL per check and a SUMMARY line.
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Mathematica", "harness.wl"}]];
Print["=== Problems 17: central-mass bias ===\n"];
Clear[eta, g, B, u, th, m1, m2, q, tE, tB, x, nn, s];

m2of[m1_, B_, g_] := m1 B^((3 - g)/(g - 1));
thStar[g_] := ((2 - g) (3 - g)/2)^(1/(g - 1));
mcrit[g_] := (2 - g) (g - 1)/2 thStar[g]^(3 - g);
m1crit[g_, B_] := mcrit[g] B^((g - 3)/(g - 1));
boeEta[m1_, B_, g_] := (m1 - m2of[m1, B, g])/(g - 1);     (* fixed-slope deta/eta *)

(* ---------------- Exercise: two channels ---------------- *)
Print["--- ex:cb_two_channels ---"];
check["1a  dlnB = (g-1) deta/eta + ln(eta) dg",
  FullSimplify[D[Log[eta^(g - 1)], eta] eta == (g - 1) && D[Log[eta^(g - 1)], g] == Log[eta],
    Assumptions -> eta > 0]];
{etaN, gN, de, dg} = {79/100, 16/10, 5/1000, 3/100};
dir = N[(gN - 1) de, 20]; slo = N[Log[etaN] dg, 20];
check["1b  direct channel = +0.00300", Abs[dir - 0.003] < 10^-15];
check["1c  slope-drag channel = ln(0.79) x 0.03 = -0.0070717", Abs[slo + 0.00707167] < 10^-8];
check["1d  net = -0.0040717; |slope|/|direct| = 2.357",
  Abs[dir + slo + 0.00407167] < 10^-8 && Abs[Abs[slo/dir] - 2.35722] < 10^-5];
check["1e  slope channel -> 0 as eta -> 1; direct channel independent of eta",
  Limit[Log[eta] dg, eta -> 1] == 0 && D[(g - 1) de, eta] === 0];
check["1f  slope channel equals direct channel in magnitude at eta = exp(-(g-1) de/dg) = 0.9048",
  Abs[N[Exp[-(gN - 1) de/dg]] - 0.904837] < 10^-6];
Print["     direct ", dir, "  slope ", slo, "  net ", dir + slo];

(* ---------------- Exercise: annihilation boundary ---------------- *)
Print["--- ex:cb_annihilation ---"];
yp[th_, g_, u_] := 1 - (2 - g) th^(1 - g) + u/th^2;
ypp[th_, g_, u_] := (2 - g) (g - 1) th^(-g) - 2 u/th^3;
check["2a  y''=0  <=>  u = (2-g)(g-1) th^(3-g)/2",
  FullSimplify[(ypp[th, g, u] /. u -> (2 - g) (g - 1) th^(3 - g)/2) == 0, Assumptions -> th > 0]];
check["2b  substituting into y'=0 gives 1 - (2-g)(3-g)/2 th^(1-g) = 0",
  FullSimplify[(yp[th, g, u] /. u -> (2 - g) (g - 1) th^(3 - g)/2) == 1 - (2 - g) (3 - g)/2 th^(1 - g),
    Assumptions -> th > 0]];
check["2c  hence th*^(g-1) = (2-g)(3-g)/2 and both conditions hold at (th*, mcrit)",
  FullSimplify[{yp[thStar[g], g, mcrit[g]], ypp[thStar[g], g, mcrit[g]]} == {0, 0},
    Assumptions -> 1 < g < 2]];
check["2d  g = 1.6: th* = 0.119839, mcrit = 0.0061548",
  Abs[N[thStar[16/10]] - 0.1198386] < 10^-7 && Abs[N[mcrit[16/10]] - 0.00615484] < 10^-8];
check["2e  near-plane value for B = 0.8: m1crit = mcrit B^((g-3)/(g-1)) = 0.010360",
  Abs[N[m1crit[16/10, 8/10]] - 0.0103595] < 10^-7];
check["2f  numerical double root (FindRoot on y'=y''=0) reproduces the closed form at g=1.6",
  Module[{sol = FindRoot[{yp[t, 16/10, v] == 0, ypp[t, 16/10, v] == 0}, {{t, 1/10}, {v, 1/200}},
            WorkingPrecision -> 30]},
    Abs[(v /. sol) - mcrit[16/10]] < 10^-25 && Abs[(t /. sol) - thStar[16/10]] < 10^-25]];
gm = g /. Last[FindMaximum[{mcrit[g], 11/10 < g < 19/10}, {g, 3/2}, WorkingPrecision -> 30]];
check["2g  max_g mcrit = 0.0065996 at g = 1.4846: no slope 1<g<2 tolerates m > 0.0066 on its own plane",
  Abs[gm - 1.48463] < 10^-4 && Abs[N[mcrit[gm]] - 0.00659955] < 10^-7];
(* Fix pass 2026-10-14 (F1): why m_crit -> 0 as g -> 1. NOT because the radial curve moves to small
   radii (theta_r -> e^-1, theta* -> e^-3/2 as g -> 1), but because the PL tends to a uniform kappa = 1
   sheet: lambda_r is only marginally negative over the decade inside theta_r. lambda_r is monotone in
   th, and at th = theta_r/10 it equals 1 - 10^(g-1). *)
check["2h  g -> 1+: theta_r/tE -> e^-1 = 0.368 and th*/tE -> e^-3/2 = 0.223 (radial curve does NOT shrink to 0)",
  Limit[(2 - g)^(1/(g - 1)), g -> 1, Direction -> "FromAbove"] == E^-1 &&
  Limit[thStar[g], g -> 1, Direction -> "FromAbove"] == E^(-3/2) &&
  Limit[(3 - g)/2 x^(1 - g), g -> 1] == 1];
check["2i  PL lambda_r(theta_r/10) = 1 - 10^(g-1): -0.023 at g = 1.01 vs -2.16 at g = 1.5",
  FullSimplify[(1 - (2 - g) x^(1 - g)) /. x -> (2 - g)^(1/(g - 1))/10, Assumptions -> 1 < g < 2] == 1 - 10^(g - 1) &&
  Abs[N[1 - 10^(1/100)] + 0.02329] < 1*^-5 && Abs[N[1 - 10^(1/2)] + 2.16228] < 1*^-5];
Print["     th*(1.6) = ", N[thStar[16/10], 8], "  mcrit(1.6) = ", N[mcrit[16/10], 8],
      "  m1crit(1.6,0.8) = ", N[m1crit[16/10, 8/10], 8], "  max at g = ", N[gm, 6]];

(* ---------------- Exercise: differential importance ---------------- *)
Print["--- ex:cb_differential ---"];
check["3a  (1/B) B^(2/(g-1)) = B^((3-g)/(g-1))",
  FullSimplify[(1/B) B^(2/(g - 1)) == B^((3 - g)/(g - 1)), Assumptions -> B > 0 && g > 1]];
check["3b  1 - m2/m1 = 1 - B^((3-g)/(g-1)) > 0 for 0<B<1, 1<g<3",
  Reduce[0 < B < 1 && 1 < g < 3 && 1 - B^((3 - g)/(g - 1)) <= 0, {B, g}, Reals] === False];
check["3c  the factor vanishes as B -> 1 and as the exponent -> 0 (g -> 3)",
  Limit[1 - B^((3 - g)/(g - 1)), B -> 1] == 0 &&
  FullSimplify[Limit[1 - B^q, q -> 0], Assumptions -> 0 < B < 1] == 0];
check["3d  fixed-slope ratio shift (m1-m2)/(g-1) is zero iff m2 = m1",
  FullSimplify[(m1 - m2)/(g - 1) /. m2 -> m1] == 0];
check["3e  g = 1.6, B = 0.8: m2/m1 = 0.5941, factor 1 - B^(7/3) = 0.4059",
  Abs[N[(8/10)^(7/3)] - 0.594123] < 10^-6 && Abs[N[1 - (8/10)^(7/3)] - 0.405877] < 10^-6];

(* ---------------- Exercise: coherent systematic ---------------- *)
Print["--- ex:cb_coherent ---"];
check["4a  mean of N identical biases b is b (N-independent)",
  Simplify[Sum[s, {i, 1, nn}]/nn] == s];
check["4b  sigma1/Sqrt[N] = b  <=>  N = (sigma1/b)^2",
  FullSimplify[(Solve[s1/Sqrt[nn] == b, nn] // First // Values // First) == (s1/b)^2,
    Assumptions -> s1 > 0 && b > 0]];
check["4c  sigma1 = 2%, b = 0.5%: N_cross = 16", (2/100/(5/1000))^2 == 16];
chi[z_?NumericQ, w_?NumericQ] := NIntegrate[1/Sqrt[3/10 (1 + zz)^3 + 7/10 (1 + zz)^(3 (1 + w))],
                                    {zz, 0, z}, WorkingPrecision -> 30];
Bw[w_] := (1 - chi[1/2, w]/chi[1, w])/(1 - chi[1/2, w]/chi[2, w]);
Sw = (Log[Bw[-1 + 10^-4]] - Log[Bw[-1 - 10^-4]])/(2 10^-4);
check["4d  (zd,z1,z2)=(0.5,1,2), flat, Om=0.3: S_w = -0.0330; b = -0.5% -> dw = +0.151",
  Abs[Sw + 0.03301] < 2*^-4 && Abs[-0.005/Sw - 0.1515] < 0.002];
Print["     S_w = ", N[Sw, 5], "  dw(-0.5%) = ", N[-0.005/Sw, 4]];

(* ---------------- Exercise: a real system (order of magnitude) ---------------- *)
Print["--- ex:cb_real_system ---"];
mr = 10^9/(2 10^11);
check["5a  M_BH = 1e9, M(<theta_E1) = 2e11 Msun -> m1 = 0.005", mr == 1/200];
check["5b  g = 1.6, B = 0.8: m1crit = 0.01036 > m1 (radial image survives; m1/m1crit = 0.483)",
  N[m1crit[16/10, 8/10]] > N[mr] && Abs[N[mr/m1crit[16/10, 8/10]] - 0.48265] < 10^-4];
check["5c  g = 1.9, B = 0.8: m1crit = 0.001706 < m1 (radial image destroyed)",
  N[m1crit[19/10, 8/10]] < N[mr]];
check["5d  BoE fixed-slope: g=1.6 deta/eta = 3.382e-3, dB/B = 2.029e-3; g=1.9 deta/eta = 1.326e-3, dB/B = 1.194e-3",
  Abs[N[boeEta[mr, 8/10, 16/10]] - 0.00338231] < 10^-8 && Abs[N[6/10 boeEta[mr, 8/10, 16/10]] - 0.00202938] < 10^-8 &&
  Abs[N[boeEta[mr, 8/10, 19/10]] - 0.00132612] < 10^-8 && Abs[N[9/10 boeEta[mr, 8/10, 19/10]] - 0.00119351] < 10^-8];
check["5e  dw from the g=1.9 fixed-slope estimate with S_w = -0.0330: dw = -0.036",
  Abs[N[9/10 boeEta[mr, 8/10, 19/10]]/Sw + 0.0362] < 0.001];
check["5f  g = 1.9: theta_r = 0.0774 tE but theta_BH = sqrt(m1) tE = 0.0707 tE (same scale)",
  Abs[N[(1/10)^(10/9)] - 0.0774264] < 10^-6 && Abs[N[Sqrt[mr]] - 0.0707107] < 10^-6];

(* ---------------- Exercise: SIS + point mass ---------------- *)
Print["--- ex:cb_sis_point_mass ---"];
tt = (tE + Sqrt[tE^2 + 4 tB^2])/2;
check["6a  theta_tot = (tE + Sqrt[tE^2 + 4 tB^2])/2 solves th = tE + tB^2/th",
  FullSimplify[tt == tE + tB^2/tt, Assumptions -> tE > 0 && tB > 0]];
check["6b  theta_tot/tE = 1 + m - m^2 + O(m^3)  (m = tB^2/tE^2)",
  Normal[Series[(1 + Sqrt[1 + 4 m])/2, {m, 0, 2}]] == 1 + m - m^2];
check["6c  agrees with the general series 1 + m/(g-1) + (g-4)/(2(g-1)^2) m^2 at g = 2",
  (1/(g - 1) /. g -> 2) == 1 && ((g - 4)/(2 (g - 1)^2) /. g -> 2) == -1];
check["6d  SIS + point mass: lambda_r = 1 + tB^2/th^2 > 0 -> no radial critical curve, ever",
  FullSimplify[1 - D[tE + tB^2/th, th] == 1 + tB^2/th^2] &&
  Reduce[th > 0 && tB > 0 && 1 + tB^2/th^2 <= 0, {th, tB}, Reals] === False];
check["6e  m = 0.01: theta_tot/tE = 1.0099020 (exact) vs 1 + m - m^2 = 1.0099",
  Abs[N[(1 + Sqrt[1 + 4/100])/2] - 1.00990195] < 10^-8];

(* ---------------- Exercise: central excess ---------------- *)
Print["--- ex:cb_central_excess ---"];
kap[x_, g_] := (3 - g)/2 x^(1 - g);                       (* tE = 1 *)
meff[gi_, g_, tb_] := 2 Integrate[kap[tb, g] (tb/x)^(gi - 1) x - kap[x, g] x, {x, 0, tb},
                                  Assumptions -> tb > 0 && 1 < gi < 3 && 1 < g < 3];
check["7a  m_eff = 2 Int_0^tb (k_in - k_PL) x dx = (3-g) tb^(3-g) [1/(3-gi) - 1/(3-g)]",
  FullSimplify[meff[gi, g, tb] == (3 - g) tb^(3 - g) (1/(3 - gi) - 1/(3 - g)),
    Assumptions -> tb > 0 && 1 < gi < 3 && 1 < g < 3]];
(* Fix pass 2026-10-14 (F4): the exercise now uses tb = 0.02 (< th*(1.9) = 0.040 < theta_r = 0.077),
   in units of the far (radial-image) plane's tE, and compares with m_crit(1.9) on that plane.
   The old tb = 0.1 enclosed theta_r and th*, so the point-mass comparison did not apply there. *)
check["7b  g = 1.9, gi = 2.1, tb = 0.02 tE: m_eff = 0.003006 (positive: steeper cusp = extra mass)",
  Abs[N[meff[21/10, 19/10, 2/100]] - 0.00300553] < 10^-8];
check["7c  tb = 0.02 < th*(1.9) = 0.0398 < theta_r(1.9) = 0.0774, and m_eff = 2.31 m_crit(1.9) = 2.31 x 0.001299",
  2/100 < N[thStar[19/10]] < N[(1/10)^(10/9)] &&
  Abs[N[meff[21/10, 19/10, 2/100]/mcrit[19/10]] - 2.3135] < 10^-3];
check["7e  the broken profile (tb = 0.02) has lambda_r > 0 at every radius: no radial critical curve",
  Module[{me = meff[21/10, 19/10, 2/100], kb = kap[2/100, 19/10], outMin, inSign},
    (* outside tb: y' of PL + point mass m_eff; inside: alpha ~ th^(2-gi) with gi > 2, so alpha' < 0 *)
    outMin = NMinValue[{yp[x, 19/10, me], 2/100 <= x <= 3}, x, WorkingPrecision -> 30];
    inSign = FullSimplify[D[2/x kb (2/100)^(21/10 - 1) x^(3 - 21/10)/(3 - 21/10), x] < 0, Assumptions -> x > 0];
    Print["     tb = 0.02: min lambda_r outside tb = ", N[outMin, 5]];
    outMin > 0 && inSign]];
check["7f  old choice tb = 0.1 enclosed theta_r(1.9) and th*(1.9) (point-mass comparison invalid there)",
  N[(1/10)^(10/9)] < 1/10 && N[thStar[19/10]] < 1/10];
check["7d  for th > tb the deflection is alpha_PL + m_eff/th exactly",
  Module[{tb = 1/10, gi = 21/10, gg = 19/10, a},
    a[t_] := (2/t) (Integrate[kap[tb, gg] (tb/x)^(gi - 1) x, {x, 0, tb}] + Integrate[kap[x, gg] x, {x, tb, t}]);
    Simplify[a[t] - (t^(2 - gg) + meff[gi, gg, tb]/t), Assumptions -> t > tb] == 0]];
Print["     m_eff(1.9, 2.1, 0.02) = ", N[meff[21/10, 19/10, 2/100], 6], "  m_crit(1.9) = ", N[mcrit[19/10], 6]];

summary[];
