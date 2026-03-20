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

Print["\n========================================"];
Print["  PASSED: ", passed, " / ", passed + failed];
If[failed == 0, Print["  ALL TESTS PASSED"],
    Print["  FAILED: ", failed]];
Print["========================================"];
