(* =========================================================================
   verify_against_textbooks.wl
   Master Verification Script
   =========================================================================
   Purpose: Cross-validate ALL key results from the Learning to Lens
            tutorial against published textbook equations AND against
            Mathematica's built-in ResourceFunction tools.

   Sources verified against:
     - Carroll, Spacetime and Geometry (2004)
     - Congdon & Keeton, Principles of Gravitational Lensing (2018)
     - Narayan & Bartelmann, Lectures on Gravitational Lensing (1997)

   Usage:   wolframscript -file verify_against_textbooks.wl
   ========================================================================= *)

Print["=== MASTER VERIFICATION: Learning to Lens vs Textbooks ===\n"];

passed = 0; failed = 0;
check[name_, condition_] := If[condition,
    Print["  PASS: ", name]; passed++,
    Print["  FAIL: ", name]; failed++];

Gc = 6.674*^-11; cc = 2.998*^8; Msun = 1.989*^30;

computeChristoffel[metric_, coords_] := Module[{n, inv},
    n = Length[coords]; inv = Simplify[Inverse[metric]];
    Table[Simplify[Sum[(1/2) inv[[s, rho]] (
        D[metric[[nu, rho]], coords[[mu]]] +
        D[metric[[rho, mu]], coords[[nu]]] -
        D[metric[[mu, nu]], coords[[rho]]]
    ), {rho, n}]], {s, n}, {mu, n}, {nu, n}]];
computeRiemann[gam_, coords_] := Module[{n}, n = Length[coords];
    Table[Simplify[D[gam[[rho, nu, sig]], coords[[mu]]] -
        D[gam[[rho, mu, sig]], coords[[nu]]] +
        Sum[gam[[rho, mu, l]] gam[[l, nu, sig]] -
            gam[[rho, nu, l]] gam[[l, mu, sig]], {l, n}]],
    {rho, n}, {sig, n}, {mu, n}, {nu, n}]];
computeRicci[riem_, n_] := Table[
    Simplify[Sum[riem[[l, mu, l, nu]], {l, n}]], {mu, n}, {nu, n}];

(* 1. Christoffel: custom vs ResourceFunction *)
Print["=== 1. Christoffel Cross-Validation ==="];
coords2 = {th, ph}; metric2 = {{R^2, 0}, {0, R^2 Sin[th]^2}};
check["2-sphere: custom == ResourceFunction",
    Simplify[computeChristoffel[metric2, coords2] -
    ResourceFunction["ChristoffelSymbol"][metric2, coords2]] ===
    ConstantArray[0, {2,2,2}]];

coordsS = {t, r, th, ph}; fS[r_] := 1 - Rs/r;
metricS = {{-fS[r],0,0,0},{0,1/fS[r],0,0},{0,0,r^2,0},{0,0,0,r^2 Sin[th]^2}};
custS = computeChristoffel[metricS, coordsS];
check["Schwarzschild: custom == ResourceFunction",
    Simplify[custS - ResourceFunction["ChristoffelSymbol"][metricS, coordsS]] ===
    ConstantArray[0, {4,4,4}]];
check["Carroll 5.12: Gamma^t_{tr}",
    Simplify[custS[[1,1,2]] - Rs/(2r(r-Rs))] === 0];
check["Carroll 5.12: Gamma^r_{tt}",
    Simplify[custS[[2,1,1]] - Rs(r-Rs)/(2r^3)] === 0];

(* 2. Schwarzschild vacuum *)
Print["\n=== 2. Schwarzschild R_μν = 0 ==="];
riem = computeRiemann[custS, coordsS];
ric = computeRicci[riem, 4];
check["Carroll 5.3: all R_μν = 0", And @@ (# === 0 & /@ Flatten[ric])];

(* 3. 2-sphere Ricci scalar *)
Print["\n=== 3. 2-Sphere R = 2/R^2 ==="];
riem2 = computeRiemann[computeChristoffel[metric2, coords2], coords2];
ric2 = computeRicci[riem2, 2];
scalar2 = Simplify[Sum[Inverse[metric2][[i,j]] ric2[[i,j]], {i,2},{j,2}]];
check["R = 2/R^2", Simplify[scalar2 - 2/R^2] === 0];
check["Matches ResourceFunction RicciScalar",
    Simplify[scalar2 - ResourceFunction["RicciScalar"][metric2, coords2]] === 0];

(* 4. Mercury precession *)
Print["\n=== 4. Mercury Precession ==="];
dphi = 6Pi Gc Msun/(cc^2 * 5.79*^10 * (1 - 0.2056^2));
dphiC = dphi * (180*3600/Pi) * (100*365.25/87.97);
check["Carroll 5.98: 43.0 arcsec/century", Abs[dphiC - 43.0] < 0.1];

(* 5. Solar deflection *)
Print["\n=== 5. Solar Deflection ==="];
aS = 4Gc Msun/(cc^2 * 6.957*^8) * 180*3600/Pi;
check["C&K 3.96: 1.75 arcsec", Abs[aS - 1.75] < 0.01];

(* 6. Key integral *)
Print["\n=== 6. Deflection Integral ==="];
check["C&K 3.95: integral = 2",
    Integrate[(1-u^3)/(1-u^2)^(3/2), {u,0,1}] === 2];

(* 7. D_A turnover *)
Print["\n=== 7. D_A Turnover ==="];
Hz[z_] := 70.0 Sqrt[0.3(1+z)^3 + 0.7];
chi[z_] := NIntegrate[2.998*^5/Hz[zp], {zp, 0, z}];
DA[z_] := chi[z]/(1+z);
daV = Table[{z, DA[z]}, {z, 0.5, 3, 0.1}];
check["Turnover at z ~ 1.6", Abs[MaximalBy[daV, Last][[1,1]] - 1.6] <= 0.1];

(* 8. D_ds != D_s - D_d *)
Print["\n=== 8. D_ds ≠ D_s - D_d ==="];
Dd = DA[0.36]; Ds = DA[1.41]; Dds = (chi[1.41]-chi[0.36])/(1+1.41);
check["Q0957+561: D_ds differs from D_s-D_d by >100 Mpc",
    Abs[Dds - (Ds-Dd)] > 100];

(* =====================================================================
   Sections 9-13 added 2026-10-14 for Part V (compound lenses).
   Sources: Congdon & Keeton 2018 §4.8 eqs. 4.94-4.99 and §4.7.2 eq. 4.88;
            Meneghetti 2021 §5.2 eqs. 5.39, 5.40, 5.42;
            Schneider, Ehlers & Falco 1992 §9.1.1 eq. 9.1 (physical form).
   ===================================================================== *)

(* 9. Multi-plane lens equation: recursion (C&K 4.99) == explicit ray trace (SEF 9.1) *)
Print["\n=== 9. Multi-plane lens equation (C&K 4.94-4.99; SEF 9.1) ==="];
(* Two point-mass planes at D1 < D2, source at Ds. Physical deflection of a point
   mass: ahat(xi) = 4GM/(c^2 |xi|) * xi/|xi| (1-D, signed). Work in units G=c=1. *)
ClearAll[ahat, red];
ahat[M_, xi_] := 4 M/xi;                      (* 1-D, xi > 0 *)
ClearAll[M1, M2, D1, D2, Ds, D12, D1s, D2s, th1];
(* explicit ray trace in physical coordinates, SEF 9.1 / C&K 4.94 + 4.96 (all symbolic) *)
xi2  = D2 th1 - D12 ahat[M1, D1 th1];
etaS = Ds th1 - D1s ahat[M1, D1 th1] - D2s ahat[M2, xi2];
betaTrace = etaS/Ds;
(* recursive reduced form, C&K 4.97-4.99: alpha_i(theta) = (D_is/D_s) ahat_i(D_i theta) *)
red[M_, Di_, Dis_, th_] := (Dis/Ds) ahat[M, Di th];
beta12 = D12 Ds/(D2 D1s);
th2  = th1 - beta12 red[M1, D1, D1s, th1];
betaRec = th1 - red[M1, D1, D1s, th1] - red[M2, D2, D2s, th2];
mpAssume = {M1 > 0, M2 > 0, D1 > 0, D2 > D1, Ds > D2, D12 > 0, D1s > 0, D2s > 0, th1 > 0};
check["C&K 4.99 recursion == SEF 9.1 explicit ray trace (two point-mass planes, symbolic)",
      Simplify[betaTrace - betaRec, Assumptions -> mpAssume] === 0];
check["C&K 4.97: theta_2 equals physical impact position xi_2/D_2",
      Simplify[th2 - xi2/D2, Assumptions -> mpAssume] === 0];
check["C&K 4.99 collapses to the single-plane equation when M_1 -> 0",
      Simplify[(betaRec /. M1 -> 0) - (th1 - (D2s/Ds) ahat[M2, D2 th1]), Assumptions -> mpAssume] === 0];
check["C&K 4.98: beta_12 -> 0 when D_12 -> 0 (same-plane limit gives theta_2 = theta_1)",
      ((beta12 /. D12 -> 0) === 0) && (Simplify[(th2 /. D12 -> 0) - th1] === 0)];
(* numeric spot check of the same identity, D in Mpc-like units *)
check["Recursion == ray trace numerically (M1=0.1, M2=1/7, D1=2, D2=5, Ds=9, theta_1=1.5)",
      Abs[(betaTrace - betaRec) /. {M1 -> 0.1, M2 -> 1/7, D1 -> 2, D2 -> 5, Ds -> 9, D12 -> 3, D1s -> 7, D2s -> 4, th1 -> 1.5}] < 1*^-12];

(* 10. DSPL distance ratio: one deflector, two source planes *)
Print["\n=== 10. Double-source-plane ratio (C&K 4.95 with one deflector) ==="];
(* With a single deflector the reduced deflections to the two source planes differ
   only by their efficiency factors; B = (D_ls1 D_s2)/(D_s1 D_ls2). Uses the flat
   LCDM distances from section 7 (H0 = 70): B must be independent of H0. *)
DAz[z1_, z2_, h_] := (chi[z2] - chi[z1]) (70.0/h)/(1 + z2);   (* chi scales as 1/H0 *)
Bratio[zl_, z1_, z2_, h_] := (DAz[zl, z1, h] DAz[0, z2, h])/(DAz[0, z1, h] DAz[zl, z2, h]);
check["B = D_ls1 D_s2/(D_s1 D_ls2) is independent of H0 (h = 60 vs 80)",
      Abs[Bratio[0.5, 1.0, 2.0, 60] - Bratio[0.5, 1.0, 2.0, 80]] < 1*^-10];
check["B < 1 for z_s1 < z_s2 (lensing efficiency increases with source redshift)",
      Bratio[0.5, 1.0, 2.0, 70] < 1];
check["Power law: alpha_2/alpha_1 = 1/B  =>  theta_E2 = theta_E1 B^(-1/(gamma'-1))",
      Simplify[((tE1 B^(-1/(g - 1)))^(g - 1)/tE1^(g - 1)) - 1/B, Assumptions -> {tE1 > 0, B > 0, g > 1}] === 0];

(* 11. Power-law lens (Meneghetti 5.39-5.40) *)
Print["\n=== 11. Power-law lens (Meneghetti 5.39, 5.40) ==="];
(* m(x) = x^(3-n) in Einstein units (Meneghetti 5.38); kappa = m'(x)/(2x); alpha = m/x *)
mPL[x_] := x^(3 - n);
check["Meneghetti 5.39: kappa(x) = (3-n)/2 x^(1-n)",
      Simplify[D[mPL[x], x]/(2 x) - (3 - n)/2 x^(1 - n), Assumptions -> x > 0] === 0];
check["Meneghetti 5.40: alpha(x) = x^(2-n)",
      Simplify[mPL[x]/x - x^(2 - n), Assumptions -> x > 0] === 0];
check["kappa(theta_E) = (3-n)/2  (= 1/2 for the SIS, n = 2)",
      Simplify[(D[mPL[x], x]/(2 x) /. x -> 1) - (3 - n)/2] === 0 && ((3 - n)/2 /. n -> 2) === 1/2];

(* 12. Radial critical radius (Meneghetti 5.41-5.42) *)
Print["\n=== 12. Radial critical curve (Meneghetti 5.42) ==="];
lamR[x_] := 1 - D[mPL[x]/x, x];        (* lambda_r = 1 - d alpha/dx *)
check["Meneghetti 5.42: lambda_r = 0 at x_r = (2-n)^(1/(n-1))",
      Simplify[lamR[x] /. x -> (2 - n)^(1/(n - 1)), Assumptions -> {1 < n < 2}] === 0];
check["x_r is real and inside the Einstein ring only for 1 < n < 2 (n = 1.5: x_r = 1/4)",
      (((2 - n)^(1/(n - 1)) /. n -> 3/2) === 1/4) && !Element[(2 - n)^(1/(n - 1)) /. n -> 5/2, Reals]];

(* 13. Mass-sheet transformation (C&K 4.88) *)
Print["\n=== 13. Mass-sheet transformation (C&K 4.87-4.88) ==="];
(* SIS potential psi = x in Einstein units (alpha = 1). Transformed potential
   psi~ = (1-k0) psi + k0 x^2/2, source beta~ = (1-k0) beta. Same image positions. *)
psiSIS[x_] := Abs[x];
psiT[x_] := (1 - k0) psiSIS[x] + k0 x^2/2;
lensEq[psi_, x_, bb_] := bb - (x - D[psi, x]);
check["C&K 4.88: beta~ = (1-k0) beta and psi~ = (1-k0) psi + k0 x^2/2 preserve the lens equation",
      Simplify[lensEq[psiT[x], x, (1 - k0) bet] - (1 - k0) lensEq[psiSIS[x], x, bet], Assumptions -> x > 0] === 0];
(* 2-D convergence from the axisymmetric Laplacian: kappa = (psi'' + psi'/r)/2 *)
lap2[psi_, r_] := (D[psi, {r, 2}] + D[psi, r]/r)/2;
check["MST: convergence maps to kappa~ = (1-k0) kappa + k0 (2-D Laplacian, SIS: kappa = 1/(2r))",
      Simplify[lap2[(1 - k0) r + k0 r^2/2, r] - ((1 - k0) lap2[r, r] + k0), Assumptions -> r > 0] === 0];
check["MST: Jacobian scales by (1-k0), so magnification scales by (1-k0)^-2 (1-D)",
      Simplify[D[x - D[psiT[x], x], x] - (1 - k0) D[x - D[psiSIS[x], x], x], Assumptions -> x > 0] === 0];

Print["\n========================================"];
Print["  PASSED: ", passed, " / ", passed + failed];
If[failed == 0, Print["  ALL TESTS PASSED"],
    Print["  FAILED: ", failed]];
Print["========================================"];
