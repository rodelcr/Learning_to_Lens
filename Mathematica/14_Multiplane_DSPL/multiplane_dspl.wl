(* =========================================================================
   multiplane_dspl.wl
   Module 14: The Multi-Plane Lens Equation and Double-Source-Plane Lenses
   =========================================================================
   Purpose: Verify every derivation and number of Chapter 14 (PDF ch. 18):
            (1) the recursive multi-plane lens equation equals explicit
                sequential ray tracing (piecewise-straight comoving rays in a
                flat universe), for generic deflections and for two
                point-mass planes; it collapses to the single-plane lens
                equation when the first plane's mass -> 0; the Congdon &
                Keeton beta_ij form is the same equation; the two-plane
                Jacobian is not symmetric (lens-lens coupling).
            (2) one deflector / two source planes: alpha_2 = alpha_1 / B
                pointwise; B is Hubble-free; the (1+z) factors cancel;
                D_ds != D_s - D_d; 0 < B < 1, limits, monotonicity in z_s2.
            (3) power law: alpha = thetaE^(g-1) theta^(2-g); B = eta^(g-1)
                <=> thetaE2 = thetaE1 B^(-1/(g-1)); g = 2 gives B = eta.
            (4) SIE (Kormann, Schneider & Bartelmann 1994 normalisation as
                in Chapter 12): ratio of Einstein radii = B for any q, in
                any Einstein-radius convention.
            (5) d ln B / d w and d ln B / d Omega_m at the illustrative
                geometry (z_l, z_s1, z_s2) = (0.5, 1.0, 2.0), flat wCDM,
                by two independent methods; signs; degeneracy slope.
            (6) lens-lens coupling: the massive-first-source DSPL equation
                is the N = 2 recursive equation; size of the coupling term.
            Fix pass 2026-10-14 (fact-critic F1/F2/F4/F5, reconciler A/C):
                3h radial eigenvalue g'-1 at thetaE; 4g KSB94 eq. 21b
                orientation; 4h shear breaks critical-curve scaling; 5l-5m
                fixed-Om vs Om-free delta w; 5n triplet-dependent orientation.
            Figure: B(z_s2) for two w values, and the fractional difference.

   Sources: Schneider, Ehlers & Falco (1992) Sec. 9.1.1, eqs. (9.1)-(9.3)
            Congdon & Keeton (2018) Sec. 4.8, eqs. (4.94)-(4.99)
            Kormann, Schneider & Bartelmann (1994) - SIE deflection
            Blandford & Narayan (1986) - multi-plane formalism
            Ported from the analytic study note "multi-plane lens equation &
            DSPL distance ratio" and its lens-lens coupling estimate
            (no check[] verdicts in the original; wrapped here).

   Usage:   bash Mathematica/run_wl.sh Mathematica/14_Multiplane_DSPL/multiplane_dspl.wl

   Outputs: PASS/FAIL per check, SUMMARY line;
            Figures/14_Multiplane_DSPL/B_vs_zs2.pdf
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "harness.wl"}]];

Print["=== Module 14: Multi-plane lens equation & DSPL distance ratio ===\n"];

figDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Figures",
                       "14_Multiplane_DSPL"}];
If[!DirectoryQ[figDir], CreateDirectory[figDir, CreateIntermediateDirectories -> True]];

(* ---- Cosmology: flat wCDM, distances in Mpc, c/H0 explicit ---- *)
cKms = 299792.458;
Eofz[z_, Om_, w_] := Sqrt[Om (1 + z)^3 + (1 - Om) (1 + z)^(3 (1 + w))];
chiF[z_?NumericQ, Om_?NumericQ, w_?NumericQ, H0_?NumericQ] := chiF[z, Om, w, H0] =
  (cKms/H0) NIntegrate[1/Eofz[zp, Rationalize[Om, 0], Rationalize[w, 0]],
     {zp, 0, Rationalize[z, 0]},
     PrecisionGoal -> 13, AccuracyGoal -> 15, WorkingPrecision -> 25];
DAF[z1_, z2_, Om_, w_, H0_] := (chiF[z2, Om, w, H0] - chiF[z1, Om, w, H0])/(1 + z2);
BF[zl_, zs1_, zs2_, Om_, w_, H0_] :=
  (DAF[zl, zs1, Om, w, H0] DAF[0, zs2, Om, w, H0])/
  (DAF[0, zs1, Om, w, H0] DAF[zl, zs2, Om, w, H0]);
(* machine-precision version for the figure only *)
chiM[z_?NumericQ, Om_?NumericQ, w_?NumericQ] := chiM[z, Om, w] =
  NIntegrate[1/Eofz[zp, Om, w], {zp, 0, z}];
BM[zl_, zs1_, zs2_, Om_, w_] := Module[{l = chiM[zl, Om, w], a = chiM[zs1, Om, w],
   b = chiM[zs2, Om, w]}, ((a - l) b)/(a (b - l))];

(* =========================================================================
   Section 1: the recursive multi-plane lens equation
   ========================================================================= *)
Print["--- Section 1: multi-plane lens equation ---"];

(* Flat universe: a ray leaves the observer at angle th; between planes it is
   a straight line in comoving transverse coordinate x(chi). At plane i it is
   deflected by the PHYSICAL angle ah_i (angles are the same in comoving and
   proper coordinates). Comoving positions on each plane: *)
Clear[th, a1, a2, a3, c1, c2, c3, cs, z1, z2, z3, zs];
x1 = th c1;
x2 = th c2 - a1 (c2 - c1);
x3 = th c3 - a1 (c3 - c1) - a2 (c3 - c2);
xs = th cs - a1 (cs - c1) - a2 (cs - c2) - a3 (cs - c3);
(* angular-diameter distances, flat:  D_i = c_i/(1+z_i), D_ij = (c_j-c_i)/(1+z_j) *)
Dm[i_, j_] := ({c1, c2, c3, cs}[[j]] - If[i == 0, 0, {c1, c2, c3, cs}[[i]]])/
              (1 + {z1, z2, z3, zs}[[j]]);
(* recursive equation (SEF eq. 9.3; C&K eq. 4.99): theta_j = theta_1 - Sum_i D_ij/D_j ah_i *)
thRec[j_] := th - Sum[Dm[i, j]/Dm[0, j] {a1, a2, a3}[[i]], {i, 1, j - 1}];
check["1a  recursive eq. == sequential comoving ray trace on planes 2, 3 and source (N = 3, generic deflections)",
  FullSimplify[{thRec[2] - x2/c2, thRec[3] - x3/c3, thRec[4] - xs/cs}] === {0, 0, 0}];
(* physical impact parameter: xi_i = D_i theta_i = a(z_i) x_i *)
check["1b  physical impact parameter xi_j = D_j theta_j equals x_j/(1+z_j)",
  FullSimplify[{Dm[0, 2] thRec[2] - x2/(1 + z2), Dm[0, 4] thRec[4] - xs/(1 + zs)}] === {0, 0}];

(* the same equation written with C&K's beta_ij = D_ij D_s/(D_j D_is) and reduced
   deflections alpha_i = (D_is/D_s) ah_i  (C&K eqs. 4.97-4.99) *)
betaCK[i_, j_] := Dm[i, j] Dm[0, 4]/(Dm[0, j] Dm[i, 4]);
redA[i_] := Dm[i, 4]/Dm[0, 4] {a1, a2, a3}[[i]];
check["1c  Congdon & Keeton form theta_j = theta_1 - Sum beta_ij alpha_i  ==  SEF form",
  FullSimplify[{th - betaCK[1, 2] redA[1] - thRec[2],
                th - betaCK[1, 3] redA[1] - betaCK[2, 3] redA[2] - thRec[3],
                th - redA[1] - redA[2] - redA[3] - thRec[4]}] === {0, 0, 0}];

(* Two point-mass planes, 2-D vectors, numerical: explicit physical-coordinate
   sequential tracing vs. recursive angular form. Units: Mpc, Msun. *)
GMc2 = 4.7853*^-20;  (* G Msun / c^2 in Mpc *)
ahatPM[M_, xi_List, xc_List] := 4 GMc2 M (xi - xc)/Norm[xi - xc]^2;
zA = 0.3; zB = 0.6; zS = 1.5; OmF = 0.3; wF = -1; H0F = 70;
{cA, cB, cS} = chiF[#, OmF, wF, H0F] & /@ {zA, zB, zS};
DA0[z_, c_] := c/(1 + z);
DAij[ci_, cj_, zj_] := (cj - ci)/(1 + zj);
MA = 3.0*^11; MB = 1.0*^11;
offA = {0.4, -0.2}/206265.; offB = {-0.3, 0.5}/206265.;    (* angular offsets of the masses, rad *)
(* explicit sequential trace in comoving transverse coordinates *)
traceExplicit[thv_List, mA_] := Module[{xA, xB, xs, dirA, dirB},
  xA = thv cA;                                                 (* reach plane A *)
  dirA = thv - ahatPM[mA, xA/(1 + zA), offA DA0[zA, cA]];      (* deflect *)
  xB = xA + dirA (cB - cA);                                    (* propagate *)
  dirB = dirA - ahatPM[MB, xB/(1 + zB), offB DA0[zB, cB]];
  xs = xB + dirB (cS - cB);
  {xB/cB, xs/cS}];
(* recursive angular equation with angular-diameter distances *)
traceRecursive[thv_List, mA_] := Module[{thB, thS, aA, aB},
  aA = ahatPM[mA, DA0[zA, cA] thv, offA DA0[zA, cA]];
  thB = thv - DAij[cA, cB, zB]/DA0[zB, cB] aA;
  aB = ahatPM[MB, DA0[zB, cB] thB, offB DA0[zB, cB]];
  thS = thv - DAij[cA, cS, zS]/DA0[zS, cS] aA - DAij[cB, cS, zS]/DA0[zS, cS] aB;
  {thB, thS}];
testThetas = {{1.1, 0.3}, {-0.7, 0.9}, {0.2, -1.4}, {2.0, 2.0}}/206265.;
dev = Max[Table[Max[Abs[Flatten[traceExplicit[t, MA] - traceRecursive[t, MA]]]],
            {t, testThetas}]]*206265.;
Print["    max |explicit - recursive| over test rays = ", dev, " arcsec"];
check["1d  two point-mass planes: explicit sequential trace == recursive equation (< 1e-12 arcsec)",
  dev < 1*^-12];
(* collapse: plane-A mass -> 0 gives the single-plane lens equation for plane B *)
devCollapse = Max[Table[Module[{thS, single},
     thS = traceRecursive[t, 0.][[2]];
     single = t - DAij[cB, cS, zS]/DA0[zS, cS] ahatPM[MB, DA0[zB, cB] t, offB DA0[zB, cB]];
     Max[Abs[thS - single]]], {t, testThetas}]]*206265.;
check["1e  M_A -> 0: recursive equation collapses to single-plane beta = theta - (D_ds/D_s) ahat(D_d theta)",
  devCollapse < 1*^-12];
(* symbolic collapse with generic deflection functions *)
Clear[fA, fB];
check["1f  symbolic collapse: setting ahat_1 = 0 in the N = 2 equation leaves the single-plane equation",
  FullSimplify[(th - Dm[1, 4]/Dm[0, 4] a1 - Dm[2, 4]/Dm[0, 4] a2 /. a1 -> 0) ==
                th - Dm[2, 4]/Dm[0, 4] a2]];

(* Jacobian of the two-plane map: not symmetric when both planes have mass *)
jac[mA_] := Module[{f, h = 1.*^-4/206265., t0 = {0.9, 0.4}/206265.},
  f[t_] := traceRecursive[t, mA][[2]];
  Transpose[{(f[t0 + {h, 0}] - f[t0 - {h, 0}])/(2 h),
             (f[t0 + {0, h}] - f[t0 - {0, h}])/(2 h)}]];
jFull = jac[MA]; jSingle = jac[0.];
Print["    Jacobian (two planes):   ", jFull];
Print["    Jacobian (M_A = 0):      ", jSingle];
check["1g  lens-lens coupling: two-plane Jacobian is NOT symmetric (|A12 - A21| > 1e-4)",
  Abs[jFull[[1, 2]] - jFull[[2, 1]]] > 1*^-4];
check["1h  single plane (M_A = 0): Jacobian symmetric to finite-difference accuracy",
  Abs[jSingle[[1, 2]] - jSingle[[2, 1]]] < 1*^-6];
(* chain rule: A = I - Psi_1 - Psi_2 (I - beta_12 Psi_1), Psi_i = d alpha_i/d theta_i,
   alpha_i = (D_is/D_s) ahat_i  (reduced to the final source) *)
Module[{h = 1.*^-4/206265., t0 = {0.9, 0.4}/206265., redA, redB, Psi1, Psi2, th2, b12, Aformula},
  redA[t_] := DAij[cA, cS, zS]/DA0[zS, cS] ahatPM[MA, DA0[zA, cA] t, offA DA0[zA, cA]];
  redB[t_] := DAij[cB, cS, zS]/DA0[zS, cS] ahatPM[MB, DA0[zB, cB] t, offB DA0[zB, cB]];
  b12 = DAij[cA, cB, zB] DA0[zS, cS]/(DA0[zB, cB] DAij[cA, cS, zS]);
  th2 = t0 - b12 redA[t0];
  Psi1 = Transpose[{(redA[t0 + {h, 0}] - redA[t0 - {h, 0}])/(2 h),
                    (redA[t0 + {0, h}] - redA[t0 - {0, h}])/(2 h)}];
  Psi2 = Transpose[{(redB[th2 + {h, 0}] - redB[th2 - {h, 0}])/(2 h),
                    (redB[th2 + {0, h}] - redB[th2 - {0, h}])/(2 h)}];
  Aformula = IdentityMatrix[2] - Psi1 - Psi2.(IdentityMatrix[2] - b12 Psi1);
  check["1i  chain-rule Jacobian I - Psi1 - Psi2 (I - beta12 Psi1) matches finite-difference Jacobian",
    Max[Abs[Flatten[Aformula - jFull]]] < 1*^-5 &&
    Abs[Psi1[[1, 2]] - Psi1[[2, 1]]] < 1*^-6 && Abs[Psi2[[1, 2]] - Psi2[[2, 1]]] < 1*^-6]];
check["1j  symbolic: for symmetric Psi1, Psi2 the antisymmetric part of A is beta12 [Psi2.Psi1 - (Psi2.Psi1)^T]/2",
  Module[{P1 = {{p11, p12}, {p12, p22}}, P2 = {{r11, r12}, {r12, r22}}, A, b},
    A = IdentityMatrix[2] - P1 - P2.(IdentityMatrix[2] - b P1);
    Simplify[(A - Transpose[A])/2 - b (P2.P1 - Transpose[P2.P1])/2] === {{0, 0}, {0, 0}}]];

(* =========================================================================
   Section 2: one deflector, two source planes -- the distance ratio B
   ========================================================================= *)
Print["\n--- Section 2: the distance ratio B ---"];
Clear[kk, chil, chi1, chi2, zl, zs1, zs2, ah];
DsA1 = kk chi1/(1 + zs1); DsA2 = kk chi2/(1 + zs2);
DlA1 = kk (chi1 - chil)/(1 + zs1); DlA2 = kk (chi2 - chil)/(1 + zs2);
alpha1 = DlA1/DsA1 ah; alpha2 = DlA2/DsA2 ah;
Bsym = (DlA1 DsA2)/(DsA1 DlA2);
Bchi = ((chi1 - chil) chi2)/(chi1 (chi2 - chil));
check["2a  alpha_2 / alpha_1 = 1/B pointwise (same physical deflection, any profile)",
  FullSimplify[alpha2/alpha1 - 1/Bsym] === 0];
check["2a' B is the Congdon & Keeton beta_ij with (i, j, s) -> (l, s1, s2)",
  Module[{bCK = (DlA1 DsA2)/(DsA1 DlA2)}, FullSimplify[bCK - Bsym] === 0] &&
  FullSimplify[(Dm[1, 2] Dm[0, 4]/(Dm[0, 2] Dm[1, 4])) -
     ((c2 - c1) cs)/(c2 (cs - c1))] === 0];
check["2a'' contrast: time-delay distance (1+z_l) D_l D_s/D_ls is proportional to c/H0 (B is not)",
  Module[{Dl = kk chil/(1 + zl), Ddt},
    Ddt = (1 + zl) Dl DsA1/DlA1;
    FullSimplify[D[Ddt, kk] - Ddt/kk] === 0 && FullSimplify[Ddt /. kk -> 0] === 0]];
check["2b  B = (D_ls1 D_s2)/(D_s1 D_ls2) reduces to comoving-only form (c/H0 and (1+z) cancel)",
  FullSimplify[Bsym - Bchi] === 0];
check["2c  dB/d(c/H0) = 0 and dB/dz_s1 = dB/dz_s2 = 0 at fixed comoving distances",
  FullSimplify[{D[Bsym, kk], D[Bsym, zs1], D[Bsym, zs2]}] === {0, 0, 0}];
check["2d  0 < B < 1 whenever 0 < chi_l < chi_s1 < chi_s2",
  Resolve[ForAll[{chil, chi1, chi2}, 0 < chil < chi1 < chi2, 0 < Bchi < 1], Reals]];
check["2e  dB/dchi_s2 = -B chi_l/(chi_s2 (chi_s2-chi_l)) < 0 and dB/dchi_s1 = B chi_l/(chi_s1 (chi_s1-chi_l)) > 0",
  FullSimplify[{D[Bchi, chi2] + Bchi chil/(chi2 (chi2 - chil)),
                D[Bchi, chi1] - Bchi chil/(chi1 (chi1 - chil))}] === {0, 0} &&
  Simplify[{-Bchi chil/(chi2 (chi2 - chil)) < 0, Bchi chil/(chi1 (chi1 - chil)) > 0},
     0 < chil < chi1 < chi2] === {True, True}];
check["2f  limits: B -> 0 as z_s1 -> z_l;  B -> 1 as z_s2 -> z_s1",
  Simplify[Bchi /. chi1 -> chil] === 0 && Simplify[Bchi /. chi2 -> chi1] === 1];

(* numbers at the illustrative geometry *)
zL = 0.5; zS1 = 1.0; zS2 = 2.0;
Bh = Table[BF[zL, zS1, zS2, 0.3, -1, h], {h, {50, 70, 100}}];
Print["    B(0.5,1,2; Om=0.3, w=-1) for H0 = 50,70,100: ", NumberForm[Bh, 12]];
check["2g  B is independent of H0 (H0 = 50, 70, 100 agree to 1e-12)",
  Max[Abs[Bh - Bh[[2]]]] < 1*^-12];
B0 = Bh[[2]];
check["2h  illustrative B(0.5, 1.0, 2.0) = 0.6742 (flat LCDM, Om = 0.3)",
  Abs[B0 - 0.67416] < 5*^-6];
{chL, ch1, ch2} = chiF[#, 0.3, -1, 70] & /@ {zL, zS1, zS2};
Print["    chi(0.5), chi(1), chi(2) [Mpc, H0=70] = ", {chL, ch1, ch2}];
check["2i  numerical B equals comoving form (chi_s1-chi_l)chi_s2/(chi_s1(chi_s2-chi_l))",
  Abs[B0 - ((ch1 - chL) ch2)/(ch1 (ch2 - chL))] < 1*^-12];
(* D_ds != D_s - D_d *)
Dd5 = DAF[0, 0.5, 0.3, -1, 70]; Ds2 = DAF[0, 2, 0.3, -1, 70]; Dds52 = DAF[0.5, 2, 0.3, -1, 70];
Print["    D_d(0.5) = ", Dd5, "  D_s(2) = ", Ds2, "  D_ds = ", Dds52, "  D_s - D_d = ", Ds2 - Dd5];
check["2j  D_ds(0.5,2) ~ 1097 Mpc while D_s - D_d ~ 468 Mpc (naive subtraction wrong)",
  Abs[Dds52 - 1097.08] < 0.05 && Abs[(Ds2 - Dd5) - 467.54] < 0.05];
check["2k  mismatch D_ds - (D_s - D_d) = chi_d [1/(1+z_d) - 1/(1+z_s)] exactly",
  Abs[(Dds52 - (Ds2 - Dd5)) - chL (1/1.5 - 1/3)] < 1*^-8];
(* what a naive-subtraction B would give *)
Dnaive[z1_, z2_] := DAF[0, z2, 0.3, -1, 70] - DAF[0, z1, 0.3, -1, 70];
Bnaive = (Dnaive[zL, zS1] DAF[0, zS2, 0.3, -1, 70])/(DAF[0, zS1, 0.3, -1, 70] Dnaive[zL, zS2]);
Print["    naive-subtraction 'B' = ", Bnaive, "  vs true B = ", B0];
check["2l  naive-subtraction 'B' = 0.878 instead of 0.674 (30% too large)",
  Abs[Bnaive - 0.8782] < 5*^-5 && Abs[100 (Bnaive/B0 - 1) - 30.3] < 0.1];

(* =========================================================================
   Section 3: power-law deflector -- B = eta^(g-1)
   ========================================================================= *)
Print["\n--- Section 3: power law, B = eta^(gamma'-1) ---"];
Clear[g, tE, t, tp, eta, Bv, tE1, tE2];
kapPL[t_, tE_, g_] := (3 - g)/2 (tE/t)^(g - 1);              (* Chapter 13 eq. kappa_power_law *)
alphaPL = FullSimplify[2/t Integrate[kapPL[tp, tE, g] tp, {tp, 0, t},
            Assumptions -> 1 < g < 3 && t > 0 && tE > 0],
            Assumptions -> 1 < g < 3 && t > 0 && tE > 0];
check["3a  alpha(theta) = 2/theta Int kappa theta' dtheta' = thetaE^(g-1) theta^(2-g)",
  FullSimplify[alphaPL - tE^(g - 1) t^(2 - g), Assumptions -> 1 < g < 3 && t > 0 && tE > 0] === 0];
check["3b  alpha(thetaE) = thetaE (Einstein radius definition holds)",
  FullSimplify[(alphaPL /. t -> tE) - tE, Assumptions -> 1 < g < 3 && tE > 0] === 0];
(* plane 2: kappa_2 = kappa_1/B (Sigma_cr scaling) -> alpha_2 = alpha_1/B ;
   matching tE2^(g-1) = tE1^(g-1)/B *)
(* alpha_2(theta) - alpha_1(theta)/B vanishes for all theta iff tE2 = tE1 B^(-1/(g-1)) *)
diffPL = tE2^(g - 1) t^(2 - g) - tE1^(g - 1) t^(2 - g)/Bv;
check["3c  alpha_2 = alpha_1/B for all theta  <=  thetaE2 = thetaE1 B^(-1/(g-1))",
  FullSimplify[diffPL /. tE2 -> tE1 Bv^(-1/(g - 1)),
     Assumptions -> 1 < g < 3 && tE1 > 0 && 0 < Bv < 1 && t > 0] === 0];
check["3c' uniqueness: thetaE2^(g-1) = thetaE1^(g-1)/B has the single positive root above (g = 1.5, 1.8, 2.3)",
  And @@ Table[Module[{sols = x /. NSolve[x^(gg - 1) == 1.3^(gg - 1)/0.67 && x > 0, x, Reals]},
     Length[sols] == 1 && Abs[sols[[1]] - 1.3 0.67^(-1/(gg - 1))] < 1*^-10], {gg, {1.5, 1.8, 2.3}}]];
check["3d  with eta = thetaE1/thetaE2:  eta^(g-1) == B  (equivalent statement)",
  FullSimplify[(tE1/(tE1 Bv^(-1/(g - 1))))^(g - 1) - Bv,
     Assumptions -> 1 < g < 3 && tE1 > 0 && 0 < Bv < 1] === 0];
check["3e  isothermal g = 2: B = eta",
  FullSimplify[(eta^(g - 1) /. g -> 2) - eta] === 0];
(* numerical: solve alpha_i(theta) = theta for the two planes *)
Module[{gg = 1.8, te1 = 1.0, te2, Bt = B0, root1, root2},
  te2 = te1 Bt^(-1/(gg - 1));
  root1 = x /. FindRoot[(1/1) te1^(gg - 1) x^(2 - gg) - x, {x, 0.7}];
  root2 = x /. FindRoot[(1/Bt) te1^(gg - 1) x^(2 - gg) - x, {x, 1.5}];
  Print["    g'=1.8: theta_E1 = ", root1, ", theta_E2 = ", root2, ", eta^(g'-1) = ",
        (root1/root2)^(gg - 1)];
  check["3f  numeric: root of alpha_2 = alpha_1/B at theta reproduces eta^(g'-1) = B (g' = 1.8)",
    Abs[(root1/root2)^(gg - 1) - Bt] < 1*^-10 && Abs[root2 - te2] < 1*^-10]];
check["3g  d ln B/d g' at fixed eta = ln eta (independent of g')",
  FullSimplify[D[(g - 1) Log[eta], g] - Log[eta]] === 0];
(* [fix pass 2026-10-14, critic F1] arc thickness as a slope anchor: for an
   axisymmetric lens the radial eigenvalue of the Jacobian is 1 - d alpha/d theta;
   at thetaE it equals g' - 1 for a power law, so the radial magnification
   1/(g'-1) of an arc at the Einstein radius depends on the slope alone
   (= 1 for the SIS). *)
radEig = FullSimplify[(1 - D[alphaPL, t]) /. t -> tE, Assumptions -> 1 < g < 3 && tE > 0];
check["3h  power law: radial eigenvalue 1 - d alpha/d theta at thetaE = g' - 1 (radial magnification 1/(g'-1); SIS -> 1)",
  FullSimplify[radEig - (g - 1)] === 0 && (radEig /. g -> 2) === 1];

(* =========================================================================
   Section 4: SIE -- the ratio of Einstein radii is B for any ellipticity
   ========================================================================= *)
Print["\n--- Section 4: SIE ratio identity ---"];
(* Chapter 12 eq. sie_alpha (Kormann, Schneider & Bartelmann 1994):
   thetaE = 4 Pi sigma^2/c^2 D_ls/D_s  (SIS-equivalent) *)
Clear[q, t1, t2, tEs];
aSIE[{t1_, t2_}, tEs_, q_] := Module[{F = Sqrt[q^2 t1^2 + t2^2], s = Sqrt[1 - q^2]},
   tEs Sqrt[q]/s {ArcTan[t1 s/F], ArcTanh[t2 s/F]}];
kSIE[{t1_, t2_}, tEs_, q_] := tEs Sqrt[q]/(2 Sqrt[q^2 t1^2 + t2^2]);
(* sanity: divergence of alpha = 2 kappa *)
divA = D[aSIE[{t1, t2}, tEs, q][[1]], t1] + D[aSIE[{t1, t2}, tEs, q][[2]], t2];
check["4a  SIE deflection satisfies div alpha = 2 kappa (Ch. 12 normalisation)",
  FullSimplify[divA - 2 kSIE[{t1, t2}, tEs, q],
     Assumptions -> 0 < q < 1 && t1 > 0 && t2 > 0 && tEs > 0] === 0];
check["4b  SIE alpha is linear in thetaE: alpha(theta; thetaE/B) = alpha(theta; thetaE)/B",
  FullSimplify[aSIE[{t1, t2}, tEs/Bv, q] - aSIE[{t1, t2}, tEs, q]/Bv] === {0, 0}];
(* thetaE_i = 4 Pi sigma^2/c^2 * f(q) * D_ls_i/D_s_i : ratio = B for any f, sigma *)
Clear[sig, cc, f];
tEi[i_] := 4 Pi sig^2/cc^2 f[q] {DlA1/DsA1, DlA2/DsA2}[[i]];
check["4c  thetaE1/thetaE2 = B: sigma_v, shape factor f(q) and c/H0 all cancel",
  FullSimplify[tEi[1]/tEi[2] - Bsym] === 0];
(* numerically: tangential critical curve radius along several directions *)
jacSym = D[aSIE[{t1, t2}, tEs, q], {{t1, t2}}];
critR[tEv_?NumericQ, qv_?NumericQ, phi_?NumericQ] := Module[{jacM, detA, r},
  jacM = jacSym /. {tEs -> tEv, q -> qv};
  detA[r_?NumericQ] := Det[IdentityMatrix[2] - (jacM /. {t1 -> r Cos[phi], t2 -> r Sin[phi]})];
  (* lstol / luc are benign here (det -> 0 at the root by construction); the
     ratio checks below are the real test of the root *)
  r /. Quiet[FindRoot[detA[r], {r, tEv}, WorkingPrecision -> 30], {FindRoot::lstol, Det::luc}]];
ratios = Flatten[Table[
   critR[1, qq, ph]/critR[1/B0, qq, ph], {qq, {0.4`30, 0.7`30, 0.95`30}},
   {ph, {0.1`30, 0.7`30, 1.3`30}}]];
Print["    critical-curve radius ratios (q in {0.4,0.7,0.95}, 3 angles): ", N[ratios, 10]];
check["4d  tangential critical-curve radius ratio = B along every direction, every q",
  Max[Abs[ratios - B0]] < 1*^-10];
(* area enclosed by the critical curve: (1/2) Int r^2 dphi; periodic integrand,
   so the 48-point trapezoid rule converges exponentially *)
areaR[tEv_, qv_] := Sqrt[(2 Pi/48) Sum[critR[tEv, qv, k 2 Pi/48]^2/2, {k, 0, 47}]/Pi];
arRatio = areaR[1, 0.6`30]/areaR[1/B0, 0.6`30];
check["4e  area-equivalent Einstein radii of the critical curves: ratio = B (q = 0.6)",
  Abs[arRatio - B0] < 1*^-9];
check["4f  convention change thetaE -> thetaE g(q) (e.g. sqrt q, 1/sqrt q) cancels in eta",
  FullSimplify[{(tEi[1] Sqrt[q])/(tEi[2] Sqrt[q]) - Bsym,
                (tEi[1]/Sqrt[q])/(tEi[2]/Sqrt[q]) - Bsym}] === {0, 0}];

(* [fix pass 2026-10-14, critic F4/C13] eq. mpi_siekappa is Kormann, Schneider &
   Bartelmann (1994) eq. (21b), kappa = sqrt(f)/(2 sqrt(x1^2 + f^2 x2^2)) with
   x = xi/xi0 (their eq. 15), once x -> theta/thetaE and the axes are swapped
   (x1, x2) -> (theta2, theta1): the chapter puts the major axis along theta1,
   KSB94 along x2.  The unswapped identification must FAIL. *)
Clear[tE, x1, x2];
kapCh   = tE Sqrt[q]/(2 Sqrt[q^2 t1^2 + t2^2]);
kapKSB[a_, b_] := Sqrt[q]/(2 Sqrt[a^2 + q^2 b^2]);
check["4g  chapter SIE kappa = KSB94 eq. 21b with axes rotated by 90 deg ((x1,x2) -> (theta2,theta1)); unrotated form differs",
  FullSimplify[kapCh - kapKSB[t2/tE, t1/tE], Assumptions -> tE > 0 && 0 < q < 1] === 0 &&
  (kapCh - kapKSB[t1/tE, t2/tE] /. {tE -> 1, q -> 1/2, t1 -> 1, t2 -> 0}) != 0];
(* [fix pass 2026-10-14, critic F5] Ex. 7(b): with a same-plane external shear the
   whole deflection field scales by 1/B, so the fitted thetaE PARAMETERS have ratio B
   exactly (Solutions check 7b), but the radius of the tangential critical curve does
   not: the SIE part of alpha is degree 0 in theta, the shear part degree 1. *)
gS1 = 0.08`30; gS2 = 0.03`30;
jacShear[s_] := (jacSym /. {tEs -> 1, q -> 0.7`30}) + s {{gS1, gS2}, {gS2, -gS1}};
critRS[ph_?NumericQ, scale_?NumericQ] := Module[{jac = scale jacShear[1], detA, r},
  detA[r_?NumericQ] := Det[IdentityMatrix[2] - (jac /. {t1 -> r Cos[ph], t2 -> r Sin[ph]})];
  r /. Quiet[FindRoot[detA[r], {r, 1.1}, WorkingPrecision -> 30], {FindRoot::lstol, Det::luc}]];
areaRS[scale_] := Sqrt[(2 Pi/48) Sum[critRS[k 2 Pi/48, scale]^2/2, {k, 0, 47}]/Pi];
shRatio = areaRS[1]/areaRS[1/B0];
Print["    SIE (q = 0.7) + shear (0.08, 0.03): area-equivalent critical-curve ratio = ",
      N[shRatio, 6], "  vs B = ", N[B0, 6]];
check["4h  SIE + same-plane shear scaled by 1/B: critical-curve radius ratio != B (parameter ratio = B; Soln 7b)",
  Abs[shRatio - B0] > 1*^-3];

(* =========================================================================
   Section 5: cosmological content -- S_w, S_Om at (0.5, 1.0, 2.0)
   ========================================================================= *)
Print["\n--- Section 5: sensitivity to w and Omega_m ---"];
Clear[z, zp, w0];
check["5a  constant w: zeta(z) = exp[3 Int_0^z (1+w)/(1+z') dz'] = (1+z)^(3(1+w))",
  FullSimplify[Exp[3 Integrate[(1 + w0)/(1 + zp), {zp, 0, z}, Assumptions -> z > 0]] -
     (1 + z)^(3 (1 + w0)), Assumptions -> z > 0] === 0];
Clear[Omx, wx, zx];
E2x = Omx (1 + zx)^3 + (1 - Omx) (1 + zx)^(3 (1 + wx));
check["5j  dE^2/dw = 3(1-Om)(1+z)^(3(1+w)) ln(1+z) > 0 and dE^2/dOm = (1+z)^3 - (1+z)^(3(1+w)) > 0 (w < 0, z > 0)",
  FullSimplify[D[E2x, wx] - 3 (1 - Omx) (1 + zx)^(3 (1 + wx)) Log[1 + zx]] === 0 &&
  FullSimplify[D[E2x, Omx] - ((1 + zx)^3 - (1 + zx)^(3 (1 + wx)))] === 0 &&
  (* (1+z)^3 - (1+z)^(3(1+w)) = (1+z)^3 [1 - exp(3 w ln(1+z))] and 3 w ln(1+z) < 0 *)
  FullSimplify[(1 + zx)^3 - (1 + zx)^(3 (1 + wx)) - (1 + zx)^3 (1 - Exp[3 wx Log[1 + zx]]),
     zx > 0] === 0 &&
  Simplify[3 wx Log[1 + zx] < 0, zx > 0 && wx < 0] === True &&
  Simplify[3 (1 - Omx) (1 + zx)^(3 (1 + wx)) Log[1 + zx] > 0, 0 < Omx < 1 && zx > 0 && wx < 0] === True];
Bc[Om_?NumericQ, w_?NumericQ] := BF[zL, zS1, zS2, Om, w, 70];
hw = 1/10000; hO = 1/10000;
SwFD  = (Log[Bc[0.3, -1 + hw]] - Log[Bc[0.3, -1 - hw]])/(2 hw);
SOmFD = (Log[Bc[0.3 + hO, -1]] - Log[Bc[0.3 - hO, -1]])/(2 hO);
(* independent method: differentiate under the integral sign *)
dchi[zz_, par_] := Module[{Om = 3/10, w = -1, E2},
  E2[zp_, Om_, w_] := Om (1 + zp)^3 + (1 - Om) (1 + zp)^(3 (1 + w));
  NIntegrate[-(1/2) E2[zp, Om, w]^(-3/2) (D[E2[zp, o, ww], par] /. {o -> Om, ww -> w}),
    {zp, 0, zz}, WorkingPrecision -> 25, PrecisionGoal -> 13]];
chiU[zz_] := NIntegrate[1/Eofz[zp, 3/10, -1], {zp, 0, zz}, WorkingPrecision -> 25, PrecisionGoal -> 13];
SAnal[par_] := Module[{cl = chiU[zL], c1 = chiU[zS1], c2 = chiU[zS2],
                       dl = dchi[zL, par], d1 = dchi[zS1, par], d2 = dchi[zS2, par]},
  (d1 - dl)/(c1 - cl) + d2/c2 - d1/c1 - (d2 - dl)/(c2 - cl)];
SwA = SAnal[ww]; SOmA = SAnal[o];
Print["    S_w  : finite difference ", SwFD, ",  analytic ", SwA];
Print["    S_Om : finite difference ", SOmFD, ",  analytic ", SOmA];
check["5b  S_w: finite-difference and differentiate-under-integral agree to 1e-7",
  Abs[SwFD - SwA] < 1*^-7];
check["5c  S_Om: finite-difference and differentiate-under-integral agree to 1e-7",
  Abs[SOmFD - SOmA] < 1*^-7];
check["5d  S_w = d ln B/dw = -0.0330 < 0 at (0.5, 1, 2), Om = 0.3, w = -1",
  SwA < 0 && Abs[SwA - (-0.03301)] < 5*^-6];
check["5e  S_Om = d ln B/d Om = -0.0357 < 0 at (0.5, 1, 2)",
  SOmA < 0 && Abs[SOmA - (-0.03569)] < 5*^-6];
degS = -SOmA/SwA;
Print["    degeneracy slope dw/dOm|_B = -S_Om/S_w = ", degS];
check["5f  single-lens degeneracy slope dw/dOm|_B = -S_Om/S_w = -1.08 (negative)",
  degS < 0 && Abs[degS - (-1.081)] < 5*^-4];
dw1pct = 0.01/SwA;
Print["    1% error in B  ->  delta w = ", dw1pct];
check["5g  a 1% error in B maps to |delta w| = 0.30 at this geometry",
  Abs[Abs[dw1pct] - 0.303] < 1*^-3];
(* one illustrative wide-separation number for the figure caption *)
Bw07 = BF[zL, zS1, 4.0, 0.3, -0.7, 70]; Bw10 = BF[zL, zS1, 4.0, 0.3, -1, 70];
Print["    B(0.5,1,4): w=-1 -> ", Bw10, ", w=-0.7 -> ", Bw07, "  (", 100 (Bw07/Bw10 - 1), " %)"];
check["5h  raising w from -1 to -0.7 lowers B by 1.75% at z_s2 = 4 (B = 0.582 -> 0.571)",
  Bw07 < Bw10 && Abs[100 (Bw07/Bw10 - 1) - (-1.747)] < 1*^-3 &&
  Abs[Bw10 - 0.5815] < 1*^-4 && Abs[Bw07 - 0.5714] < 1*^-4];

(* [fix pass 2026-10-14, reconciler fix A] the |delta w| = 0.30 of check 5g is the
   projection at FIXED Om.  Exact fixed-Om roots of B(0.3, w)/B(0.3, -1) = 1 -/+ 1%
   are asymmetric; letting Om move along dOm = -dw/2 doubles the shift (linear);
   along the level curve (check 5f) it is unbounded. *)
B0c = Bc[3/10, -1];
wM1 = w /. FindRoot[Bc[3/10, w]/B0c - 99/100, {w, -0.7}];
wP1 = w /. FindRoot[Bc[3/10, w]/B0c - 101/100, {w, -1.3}];
Print["    fixed Om = 0.3: B -1% -> w = ", N[wM1, 6], " (dw = ", N[wM1 + 1, 4],
      ");  B +1% -> w = ", N[wP1, 6], " (dw = ", N[wP1 + 1, 4], ")"];
check["5l  fixed Om: exact -1% in B -> dw = +0.29, +1% -> dw = -0.36 (asymmetric; not the symmetric 0.30)",
  Abs[(wM1 + 1) - 0.288] < 2*^-3 && Abs[(wP1 + 1) - (-0.359)] < 2*^-3 &&
  Abs[Abs[wP1 + 1] - Abs[wM1 + 1]] > 0.05];
dwAlong = 0.01/(SwA - SOmA/2);
Print["    along dOm = -dw/2: |dw| for a 1% error in B = ", Abs[dwAlong]];
check["5m  along dOm = -dw/2 the same 1% needs |dw| = 0.66 (2.2x the fixed-Om 0.30)",
  Abs[Abs[dwAlong] - 0.659] < 1*^-3 && Abs[dwAlong/dw1pct] > 2];
(* [fix pass 2026-10-14, critic F2 / reconciler fix C] the level-curve orientation
   depends on the redshift triplet (Collett+2012 Sec. 4, p. 5) *)
SAt[{zl_, z1_, z2_}, p_] := Module[{bb},
  bb[Om_, w_] := Log[BF[zl, z1, z2, Om, w, 70]];
  If[p === "w", (bb[3/10, -1 + hw] - bb[3/10, -1 - hw])/(2 hw),
                (bb[3/10 + hO, -1] - bb[3/10 - hO, -1])/(2 hO)]];
slopeWide = -SAt[{0.3, 0.6, 3.3}, "Om"]/SAt[{0.3, 0.6, 3.3}, "w"];
Print["    degeneracy slope at (0.3, 0.6, 3.3): ", slopeWide, "  (vs ", degS, " at (0.5, 1, 2))"];
check["5n  level curves of B are differently oriented for different triplets: slope -0.87 at (0.3, 0.6, 3.3) vs -1.08",
  Abs[slopeWide - (-0.873)] < 1*^-3 && Abs[slopeWide/degS - 1] > 0.15];

(* figure: B(z_s2) for w = -1 and -0.7 *)
zgrid = Table[zz, {zz, 1.05, 4.0, 0.05}];
Bl = Table[{zz, BM[zL, zS1, zz, 0.3, -1]}, {zz, zgrid}];
Bq = Table[{zz, BM[zL, zS1, zz, 0.3, -0.7]}, {zz, zgrid}];
check["5i' machine-precision figure B agrees with the high-precision B at z_s2 = 2 and 4",
  Abs[BM[zL, zS1, 2.0, 0.3, -1] - B0] < 1*^-8 && Abs[BM[zL, zS1, 4.0, 0.3, -0.7] - Bw07] < 1*^-8];
pctD = Table[{Bl[[i, 1]], 100 (Bq[[i, 2]]/Bl[[i, 2]] - 1)}, {i, Length[zgrid]}];
p1 = ListLinePlot[{Bl, Bq}, PlotStyle -> {{Black, Thick}, {Red, Thick, Dashed}},
   Frame -> True, FrameLabel -> {None, "\[ScriptCapitalB]"},
   PlotLegends -> Placed[{"w = -1", "w = -0.7"}, {0.75, 0.75}],
   PlotLabel -> Row[{"Flat wCDM, ", Subscript["\[CapitalOmega]", "m"], " = 0.3, ",
       Subscript["z", "l"], " = 0.5, ", Subscript["z", "s1"], " = 1.0"}],
   ImageSize -> 420, AspectRatio -> 0.55, PlotRange -> {{1, 4}, All}];
p2 = ListLinePlot[pctD, PlotStyle -> {Red, Thick}, Frame -> True,
   FrameLabel -> {Subscript["z", "s2"], Row[{"\[CapitalDelta]\[ScriptCapitalB]/\[ScriptCapitalB] (%)"}]},
   ImageSize -> 420, AspectRatio -> 0.3, PlotRange -> {{1, 4}, All}];
fig = Column[{p1, p2}, Spacings -> 0];
Export[FileNameJoin[{figDir, "B_vs_zs2.pdf"}], fig];
check["5k  Delta B/B < 0 for every z_s2 on the figure grid (sign of the w response does not flip)",
  Max[pctD[[All, 2]]] < 0];
check["5i  figure B_vs_zs2.pdf exported",
  FileExistsQ[FileNameJoin[{figDir, "B_vs_zs2.pdf"}]]];

(* =========================================================================
   Section 6: lens-lens coupling when source 1 has mass
   ========================================================================= *)
Print["\n--- Section 6: lens-lens coupling ---"];
(* DSPL form: beta2 = theta - alpha_L/B - (D_s1s2/D_s2) ahat1(D_s1 beta1),
   beta1 = theta - alpha_L.  Recursive N = 2 equation with planes (l, s1), source s2: *)
Clear[ahL, ah1, cs1s2];
DlA2b = kk (chi2 - chil)/(1 + zs2); D12 = kk (chi2 - chi1)/(1 + zs2);
aL = DlA1/DsA1 ahL;
dsplForm = th - aL/Bsym - D12/DsA2 ah1;
recForm  = th - DlA2b/DsA2 ahL - D12/DsA2 ah1;
check["6a  DSPL coupling equation == recursive N = 2 equation (planes l, s1; source s2)",
  FullSimplify[dsplForm - recForm] === 0];
check["6b  massless source 1 (ahat1 = 0): coupling equation -> beta2 = theta - alpha_1/B",
  FullSimplify[(dsplForm /. ah1 -> 0) - (th - aL/Bsym)] === 0];
coupF = (ch2 - ch1)/ch2;          (* D_s1s2/D_s2, flat *)
effL2 = (ch2 - chL)/ch2;          (* D_ls2/D_s2 *)
Print["    D_s1s2/D_s2 = ", coupF, ",  D_ls2/D_s2 = ", effL2, ",  ratio = ", coupF/effL2];
check["6c  D_s1s2/D_s2 = 0.3622 and D_ls2/D_s2 = 0.6354 at (0.5, 1, 2)",
  Abs[coupF - 0.3622] < 5*^-5 && Abs[effL2 - 0.6354] < 5*^-5];
(* SIS + SIS: coupling deflection / main-lens deflection on plane 2 = (s1/sL)^2 D_s1s2/D_ls2 *)
Clear[s1, sL];
thE12 = 4 Pi s1^2/cc^2 D12/DsA2; thEL2 = 4 Pi sL^2/cc^2 DlA2b/DsA2;
check["6d  SIS+SIS: theta_E(1->2)/theta_E(L->2) = (sigma_1/sigma_L)^2 (chi_s2-chi_s1)/(chi_s2-chi_l)",
  FullSimplify[thE12/thEL2 - (s1/sL)^2 (chi2 - chi1)/(chi2 - chil)] === 0];
cr = 0.4^2 coupF/effL2;
Print["    sigma_1/sigma_L = 0.4  ->  coupling/main = ", 100 cr, " %"];
check["6e  sigma_1/sigma_L = 0.4 at (0.5, 1, 2): coupling deflection = 9.1% of main-lens deflection",
  Abs[100 cr - 9.12] < 0.02];
(* arcsec scale: sigma_1 = 100 km/s *)
tE12num = 4 Pi (100/cKms)^2 coupF 206264.806;
Print["    sigma_1 = 100 km/s: theta_E(1->2) = ", tE12num, " arcsec"];
check["6f  sigma_1 = 100 km/s at (0.5, 1, 2): theta_E(1->2) = 0.104 arcsec",
  Abs[tE12num - 0.104] < 1*^-3];

summary[];
