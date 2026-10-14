(* =========================================================================
   problems_14.wl
   Module 14: The Multi-Plane Lens Equation and Double-Source-Plane Lenses
              - SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to every exercise of Chapter 14 (PDF ch. 18),
            verified symbolically and numerically. Distances are computed
            in-script (flat wCDM comoving-distance NIntegrate); nothing is
            taken from an external code.

   Sources: Schneider, Ehlers & Falco (1992) Sec. 9.1.1
            Congdon & Keeton (2018) Sec. 4.8 and Sec. 3.5
            Kormann, Schneider & Bartelmann (1994) - SIE
            Ported from the solution scripts of the analytic study notes on
            the multi-plane equation and DSPL inference (re-attested here;
            project-specific numbers replaced by the illustrative geometry
            z_l = 0.5, z_s1 = 1.0, z_s2 = 2.0).

   Usage:   bash Mathematica/run_wl.sh Solutions/14_Multiplane_DSPL/problems_14.wl

   Also: checks 0a-0b attest numbers quoted in annotation boxes (rule R5).

   Exercises solved:
     ex:mp_hubble_free     - c/H0 and (1+z) cancel in B            (checks 1a-1e)
     ex:mp_isothermal      - gamma' = 2  =>  B = eta                (checks 2a-2c)
     ex:mp_slope_lever     - d ln B/d gamma' = ln eta; numbers      (checks 3a-3f)
     ex:mp_naive_distance  - D_ds != D_s - D_d; naive B             (checks 4a-4f)
     ex:mp_limits          - limits, monotonicity, z_s2 -> infinity (checks 5a-5d)
     ex:mp_coupling        - size of the lens-lens coupling term    (checks 6a-6d)
     ex:mpi_shape_shear    - shape factor and same-plane shear cancel (checks 7a-7d)
     ex:mpi_two_channel    - two-channel error formula and signs    (checks 8a-8d)
     ex:mpi_degeneracy     - single-lens (Om, w) degeneracy slope   (checks 9a-9d)
     ex:mpi_error_budget   - covariance propagation to sigma_B      (checks 10a-10g)

   Outputs: PASS/FAIL per check, SUMMARY line.
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                  "Mathematica", "harness.wl"}]];

Print["=== Module 14: SOLUTIONS ===\n"];

(* ---- flat wCDM distances (Mpc), H0 explicit ---- *)
cKms = 299792.458;
Eofz[z_, Om_, w_] := Sqrt[Om (1 + z)^3 + (1 - Om) (1 + z)^(3 (1 + w))];
chiF[z_?NumericQ, Om_?NumericQ, w_?NumericQ, H0_?NumericQ] := chiF[z, Om, w, H0] =
  (cKms/H0) NIntegrate[1/Eofz[zp, Rationalize[Om, 0], Rationalize[w, 0]],
     {zp, 0, Rationalize[z, 0]}, PrecisionGoal -> 13, AccuracyGoal -> 15,
     WorkingPrecision -> 25];
DAF[z1_, z2_, Om_, w_, H0_] := (chiF[z2, Om, w, H0] - chiF[z1, Om, w, H0])/(1 + z2);
BF[zl_, zs1_, zs2_, Om_, w_] :=
  (DAF[zl, zs1, Om, w, 70] DAF[0, zs2, Om, w, 70])/
  (DAF[0, zs1, Om, w, 70] DAF[zl, zs2, Om, w, 70]);
zL = 0.5; zS1 = 1.0; zS2 = 2.0;
B0 = BF[zL, zS1, zS2, 0.3, -1];
Print["Illustrative geometry (0.5, 1.0, 2.0), flat LCDM Om = 0.3: B = ", B0];
(* numbers quoted inside annotation boxes of the chapter (edition rule R5) *)
check["0a  (annotation) illustrative B(0.5, 1.0, 2.0) = 0.6742",
  Abs[B0 - 0.67416] < 5*^-6];
pctGrid = Table[100 (BF[zL, zS1, zz, 0.3, -0.7]/BF[zL, zS1, zz, 0.3, -1] - 1),
   {zz, 1.1, 4.0, 0.1}];
Print["    100 Delta B/B (w=-0.7 vs -1), z_s2 = 1.1..4.0: min ", Min[pctGrid], ", max ", Max[pctGrid]];
check["0b  (annotation, Fig.) w = -0.7 vs -1: Delta B/B negative and |Delta B/B| < 2% for 1.1 <= z_s2 <= 4, growing with z_s2",
  Max[pctGrid] < 0 && Min[pctGrid] > -2 && And @@ Thread[Differences[pctGrid] < 0]];

(* =========================================================================
   Exercise mp_hubble_free
   ========================================================================= *)
Print["\n--- Exercise: B is Hubble-free ---"];
Clear[kk, chil, chi1, chi2, zs1, zs2, t1, t2];
Ds1 = kk chi1/(1 + zs1); Ds2 = kk chi2/(1 + zs2);
Dls1 = kk (chi1 - chil)/(1 + zs1); Dls2 = kk (chi2 - chil)/(1 + zs2);
Bsym = (Dls1 Ds2)/(Ds1 Dls2);
Bchi = ((chi1 - chil) chi2)/(chi1 (chi2 - chil));
check["1a  B reduces to (chi_s1 - chi_l) chi_s2/(chi_s1 (chi_s2 - chi_l))",
  FullSimplify[Bsym - Bchi] === 0];
check["1b  dB/d(c/H0) = 0",
  FullSimplify[D[Bsym, kk]] === 0];
Bt = ((kk (chi1 - chil)/t1) (kk chi2/t2))/((kk chi1/t1) (kk (chi2 - chil)/t2));
check["1c  B independent of t1 = 1+z_s1 and t2 = 1+z_s2 (each appears once up, once down)",
  FullSimplify[{D[Bt, t1], D[Bt, t2]}] === {0, 0}];
check["1d  reduced B depends only on {chi_l, chi_s1, chi_s2}",
  Complement[Union[Variables[Numerator[Together[Bchi]]], Variables[Denominator[Together[Bchi]]]],
    {chil, chi1, chi2}] === {}];
check["1e  numerically, B(0.5,1,2) identical for H0 = 50, 70, 100 (to 1e-12)",
  Module[{bs = Table[(DAF[zL, zS1, 0.3, -1, h] DAF[0, zS2, 0.3, -1, h])/
       (DAF[0, zS1, 0.3, -1, h] DAF[zL, zS2, 0.3, -1, h]), {h, {50, 70, 100}}]},
   Max[Abs[bs - B0]] < 1*^-12]];

(* =========================================================================
   Exercise mp_isothermal
   ========================================================================= *)
Print["\n--- Exercise: isothermal B = eta ---"];
Clear[eta, g, tE1, Bv, sig, cc];
check["2a  B = eta^(g-1) at g = 2 gives B = eta",
  FullSimplify[(eta^(g - 1) /. g -> 2) - eta] === 0];
(* SIS: alpha_i = thetaE_i constant; alpha_2 = alpha_1/B -> thetaE2 = thetaE1/B *)
check["2b  SIS: constant alpha_i = thetaE_i and alpha_2 = alpha_1/B give eta = B",
  FullSimplify[tE1/(tE1/Bv) - Bv] === 0];
check["2c  SIS thetaE_i = 4 Pi sigma^2/c^2 D_ls_i/D_s_i: ratio = B, sigma cancels",
  FullSimplify[(4 Pi sig^2/cc^2 Dls1/Ds1)/(4 Pi sig^2/cc^2 Dls2/Ds2) - Bsym] === 0];

(* =========================================================================
   Exercise mp_slope_lever
   ========================================================================= *)
Print["\n--- Exercise: slope lever arm ---"];
check["3a  d/dg eta^(g-1) = ln(eta) eta^(g-1)",
  FullSimplify[D[eta^(g - 1), g] - Log[eta] eta^(g - 1)] === 0];
check["3b  d ln B/d g at fixed eta = ln eta, independent of g",
  FullSimplify[D[(g - 1) Log[eta], g] - Log[eta]] === 0 &&
  FullSimplify[D[(g - 1) Log[eta], {g, 2}]] === 0];
gEx = 1.9;
etaEx = B0^(1/(gEx - 1));
lnEta = Log[etaEx];
Print["    eta = B^(1/(g'-1)) = ", etaEx, ",  ln eta = ", lnEta];
check["3c  at B = 0.6742, g' = 1.9: eta = 0.6453, ln eta = -0.4381",
  Abs[etaEx - 0.6453] < 1*^-4 && Abs[lnEta - (-0.4381)] < 1*^-4];
dg1 = 0.01/Abs[lnEta];
Print["    delta g' for a 1% error in B = ", dg1];
check["3d  delta g' producing a 1% error in B = 0.0228",
  Abs[dg1 - 0.0228] < 1*^-4];
dBdg03 = Abs[lnEta] 0.03;
Print["    |dB/B| for delta g' = 0.03: ", dBdg03];
check["3e  delta g' = 0.03 alone gives |delta B/B| = 1.31%",
  Abs[100 dBdg03 - 1.315] < 1*^-3];
(* S_w at the illustrative geometry, central difference *)
hw = 1/10000;
SwNum = (Log[BF[zL, zS1, zS2, 0.3, -1 + hw]] - Log[BF[zL, zS1, zS2, 0.3, -1 - hw]])/(2 hw);
dwEx = (-dBdg03)/SwNum;
Print["    S_w = ", SwNum, " ; delta w = ", dwEx];
check["3f  with S_w = -0.0330 this masquerades as delta w = +0.40 (dB/B < 0 for delta g' > 0)",
  Abs[SwNum - (-0.03301)] < 5*^-6 && Abs[dwEx - 0.398] < 1*^-3];

(* =========================================================================
   Exercise mp_naive_distance
   ========================================================================= *)
Print["\n--- Exercise: D_ds != D_s - D_d ---"];
Clear[cd, cs, zd, zs];
check["4a  symbolic: (D_s - D_d) - D_ds = chi_d [1/(1+z_s) - 1/(1+z_d)]",
  FullSimplify[(cs/(1 + zs) - cd/(1 + zd)) - (cs - cd)/(1 + zs) -
     cd (1/(1 + zs) - 1/(1 + zd))] === 0];
check["4b  mismatch is nonzero for every chi_d > 0, z_s > z_d > 0 (no solution of mismatch = 0)",
  Reduce[cd (1/(1 + zs) - 1/(1 + zd)) == 0 && zs > zd > 0 && cd > 0, {cd, zd, zs}, Reals] === False];
Dd = DAF[0, 0.5, 0.3, -1, 70]; Ds = DAF[0, 2, 0.3, -1, 70]; Dds = DAF[0.5, 2, 0.3, -1, 70];
Print["    D_d = ", Dd, ", D_s = ", Ds, ", D_ds = ", Dds, ", D_s - D_d = ", Ds - Dd];
check["4c  (z_d, z_s) = (0.5, 2): D_d = 1259.08, D_s = 1726.62, D_ds = 1097.08 Mpc",
  Abs[Dd - 1259.08] < 0.01 && Abs[Ds - 1726.62] < 0.01 && Abs[Dds - 1097.08] < 0.01];
check["4d  naive D_s - D_d = 467.54 Mpc; error = +629.54 Mpc",
  Abs[(Ds - Dd) - 467.54] < 0.01 && Abs[Dds - (Ds - Dd) - 629.54] < 0.01];
Dnaive[z1_, z2_] := DAF[0, z2, 0.3, -1, 70] - DAF[0, z1, 0.3, -1, 70];
Bnaive = (Dnaive[zL, zS1] DAF[0, zS2, 0.3, -1, 70])/(DAF[0, zS1, 0.3, -1, 70] Dnaive[zL, zS2]);
Print["    naive 'B' = ", Bnaive, " vs B = ", B0];
check["4e  naive-subtraction 'B' at (0.5,1,2) = 0.8782 vs true 0.6742 (+30.3%)",
  Abs[Bnaive - 0.8782] < 5*^-5 && Abs[100 (Bnaive/B0 - 1) - 30.3] < 0.1];
dwNaive = Log[Bnaive/B0]/SwNum;
Print["    naive error as delta w (linear, illustrative only): ", dwNaive];
check["4f  the naive error is ~8 (in units of w) -- far outside the linear regime",
  Abs[dwNaive] > 7];

(* =========================================================================
   Exercise mp_limits
   ========================================================================= *)
Print["\n--- Exercise: limits of B ---"];
check["5a  B -> 0 as chi_s1 -> chi_l; B -> 1 as chi_s2 -> chi_s1",
  Simplify[Bchi /. chi1 -> chil] === 0 && Simplify[Bchi /. chi2 -> chi1] === 1];
check["5b  dB/dchi_s2 = -B chi_l/(chi_s2 (chi_s2 - chi_l)) < 0",
  FullSimplify[D[Bchi, chi2] + Bchi chil/(chi2 (chi2 - chil))] === 0 &&
  Simplify[-Bchi chil/(chi2 (chi2 - chil)) < 0, 0 < chil < chi1 < chi2]];
chiInf = NIntegrate[1/Eofz[zp, 3/10, -1], {zp, 0, Infinity}, WorkingPrecision -> 25,
   PrecisionGoal -> 12];
{cl, c1} = {chiF[zL, 0.3, -1, 70], chiF[zS1, 0.3, -1, 70]}/(cKms/70);
Binf = ((c1 - cl) chiInf)/(c1 (chiInf - cl));
Print["    chi(infinity) = ", chiInf, " c/H0;  B(z_s2 -> infinity) = ", Binf];
check["5c  flat LCDM Om = 0.3: chi(z -> infinity) = 3.305 c/H0 (finite)",
  Abs[chiInf - 3.305] < 1*^-3];
check["5d  B(0.5, 1.0, z_s2 -> infinity) = 0.4943 -- a finite floor",
  Abs[Binf - 0.4943] < 1*^-4 && Binf < B0];

(* =========================================================================
   Exercise mp_coupling
   ========================================================================= *)
Print["\n--- Exercise: lens-lens coupling magnitude ---"];
Clear[s1, sL];
D12 = kk (chi2 - chi1)/(1 + zs2);
ratioSym = (4 Pi s1^2/cc^2 D12/Ds2)/(4 Pi sL^2/cc^2 Dls2/Ds2);
check["6a  coupling/main = (sigma_1/sigma_L)^2 (chi_s2 - chi_s1)/(chi_s2 - chi_l)",
  FullSimplify[ratioSym - (s1/sL)^2 (chi2 - chi1)/(chi2 - chil)] === 0];
check["6b  coupling vanishes as chi_s1 -> chi_s2 and -> (sigma_1/sigma_L)^2 as chi_s1 -> chi_l",
  Simplify[ratioSym /. chi1 -> chi2] === 0 && Simplify[(ratioSym /. chi1 -> chil) - (s1/sL)^2] === 0];
{c0, c1n, c2n} = chiF[#, 0.3, -1, 70] & /@ {zL, zS1, zS2};
geo = (c2n - c1n)/(c2n - c0);
Print["    (chi_s2-chi_s1)/(chi_s2-chi_l) = ", geo];
check["6c  geometric factor at (0.5,1,2) = 0.570",
  Abs[geo - 0.5700] < 1*^-4];
check["6d  sigma_1/sigma_L = 0.4 -> 9.1%;  sigma_1/sigma_L = 0.6 -> 20.5%",
  Abs[100 0.16 geo - 9.12] < 0.01 && Abs[100 0.36 geo - 20.52] < 0.01];

(* =========================================================================
   Exercise mpi_shape_shear
   ========================================================================= *)
Print["\n--- Exercise: shape factor and same-plane shear ---"];
Clear[f, q, ph, th1, th2, ga1, ga2, tE];
tEi[i_] := 4 Pi sig^2/cc^2 f[q, ph] {Dls1/Ds1, Dls2/Ds2}[[i]];
check["7a  any shape factor f(q, phi) common to both planes cancels: eta = B",
  FullSimplify[tEi[1]/tEi[2] - Bsym] === 0];
(* SIE + shear sourced at z_l: reduced fields on plane i scale with D_ls_i/D_s_i.
   alpha^(i) = e_i * [ahat_SIE(theta) + G theta] ;  e_i = D_ls_i/D_s_i *)
Clear[aS1, aS2];
GammaM = {{ga1, ga2}, {ga2, -ga1}};
alphaPlane[e_] := e ({aS1, aS2} + GammaM.{th1, th2});
check["7b  SIE + shear at z_l: alpha^(2) = alpha^(1)/B for every theta (exact)",
  FullSimplify[alphaPlane[Dls2/Ds2] - alphaPlane[Dls1/Ds1]/Bsym] === {0, 0}];
check["7c  hence reduced shear also scales: gamma^(2) = gamma^(1)/B (not common to both planes)",
  FullSimplify[(Dls2/Ds2 ga1)/(Dls1/Ds1 ga1) - 1/Bsym] === 0];
(* a perturber between the source planes acts on plane 2 only *)
Clear[chip];
effP[chis_] := Piecewise[{{(chis - chip)/chis, chis > chip}}, 0];
check["7d  perturber at chi_s1 < chi_p < chi_s2: efficiency 0 on plane 1, > 0 on plane 2",
  Simplify[{effP[chi1], effP[chi2] > 0}, 0 < chil < chi1 < chip < chi2] === {0, True}];

(* =========================================================================
   Exercise mpi_two_channel
   ========================================================================= *)
Print["\n--- Exercise: two-channel formula ---"];
Clear[dEta, dG];
lnB = (g - 1) Log[eta];
check["8a  d ln B/d eta = (g-1)/eta",
  FullSimplify[D[lnB, eta] - (g - 1)/eta] === 0];
check["8b  d ln B/d g = ln eta",
  FullSimplify[D[lnB, g] - Log[eta]] === 0];
check["8c  dB/B = (g-1) d eta/eta + ln(eta) d g (total differential)",
  FullSimplify[(D[lnB, eta] dEta + D[lnB, g] dG) - ((g - 1) dEta/eta + Log[eta] dG)] === 0];
check["8d  sign: ln eta < 0 for 0 < eta < 1 while g - 1 > 0 for g > 1 (opposite channels)",
  Resolve[ForAll[eta, 0 < eta < 1, Log[eta] < 0], Reals] &&
  Resolve[ForAll[g, g > 1, g - 1 > 0], Reals]];

(* =========================================================================
   Exercise mpi_degeneracy
   ========================================================================= *)
Print["\n--- Exercise: single-lens degeneracy ---"];
Clear[Bfun, Om, w];
check["9a  level set B(Om, w) = const has slope dw/dOm = -(dB/dOm)/(dB/dw) = -S_Om/S_w",
  FullSimplify[(-D[Bfun[Om, w], Om]/D[Bfun[Om, w], w]) -
     (-(D[Bfun[Om, w], Om]/Bfun[Om, w])/(D[Bfun[Om, w], w]/Bfun[Om, w]))] === 0];
hO = 1/10000;
SOmNum = (Log[BF[zL, zS1, zS2, 0.3 + hO, -1]] - Log[BF[zL, zS1, zS2, 0.3 - hO, -1]])/(2 hO);
deg = -SOmNum/SwNum;
Print["    S_Om = ", SOmNum, ", S_w = ", SwNum, ", -S_Om/S_w = ", deg];
check["9b  S_Om = -0.0357, S_w = -0.0330 at (0.5, 1, 2)",
  Abs[SOmNum - (-0.03569)] < 5*^-6 && Abs[SwNum - (-0.03301)] < 5*^-6];
check["9c  degeneracy slope dw/dOm|_B = -1.081",
  Abs[deg - (-1.081)] < 5*^-4];
(* direct check: move along the predicted direction and confirm B is unchanged to 2nd order *)
step = 0.01;
dBalong = Log[BF[zL, zS1, zS2, 0.3 + step, -1 + deg step]/B0];
dBacross = Log[BF[zL, zS1, zS2, 0.3 + step, -1 - step/deg]/B0];
Print["    d ln B along degeneracy: ", dBalong, " ; across: ", dBacross];
check["9d  a 0.01 step in Om along the predicted direction changes ln B ~45x less than the same step across it",
  Abs[dBalong] < 2*^-5 && Abs[dBacross] > 6*^-4 && Abs[dBacross/dBalong] > 40];

(* =========================================================================
   Exercise mpi_error_budget
   ========================================================================= *)
Print["\n--- Exercise: error budget with covariance ---"];
etaV = 0.72; sigEta = 0.01; gV = 1.60; sigG = 0.05; rho = 0.8;
ratioChan = (gV - 1) sigEta/etaV;
slopeChan = Log[etaV] sigG;
cross = 2 rho ratioChan slopeChan;
sigB = Sqrt[ratioChan^2 + slopeChan^2 + cross];
sigBunc = Sqrt[ratioChan^2 + slopeChan^2];
Print["    ratio ", ratioChan, " slope ", slopeChan, " cross ", cross, " sigB ", sigB,
      " (uncorrelated ", sigBunc, ")"];
check["10a ratio channel (g'-1) sigma_eta/eta = 0.00833",
  Abs[ratioChan - 0.0083333] < 1*^-7];
check["10b slope channel ln(eta) sigma_g = -0.01643",
  Abs[slopeChan - (-0.0164252)] < 1*^-7];
check["10c cross term 2 rho c_eta c_g ... = -2.190e-4 (negative)",
  cross < 0 && Abs[cross - (-2.1900*^-4)] < 1*^-8];
check["10d sigma_B/B = 1.10%",
  Abs[sigB - 0.010965] < 1*^-6];
check["10e slope channel dominates: variance ratio 3.89",
  Abs[slopeChan^2/ratioChan^2 - 3.885] < 1*^-3];
check["10f uncorrelated case would give 1.84%; rho = +0.8 lowers it by 40%",
  Abs[sigBunc - 0.018418] < 1*^-6 && Abs[100 (1 - sigB/sigBunc) - 40.5] < 0.1];
sigW = sigB/Abs[SwNum];
Print["    sigma_w with |S_w| = 0.0330: ", sigW];
check["10g with |S_w| = 0.0330 (geometry of the chapter) sigma_w = 0.33",
  Abs[sigW - 0.332] < 1*^-3];

summary[];
