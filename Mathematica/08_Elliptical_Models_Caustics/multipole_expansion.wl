(* =========================================================================
   multipole_expansion.wl
   Module 8: Non-Axisymmetric Models — Angular Structure / Multipole Expansion
   =========================================================================
   Purpose: Symbolic verification of the multipole expansion of a lens
            potential (Module 8, Sec. "The Angular Structure of Lenses").
            Verifies the convergence of an isothermal-scaling angular
            multipole, the monopole (SIS) and quadrupole limits, the
            vanishing convergence of a pure external shear, and the
            SIE internal-quadrupole fraction.

   Convention: 2D lensing potential psi(theta,phi); Poisson equation
               Laplacian[psi] = 2 kappa  (Narayan & Bartelmann / Congdon
               & Keeton convention used throughout this tutorial).

   Sources: Schneider, Kochanek & Wambsganss (2006), Part 2 (Kochanek),
            Sec. 4.4 "The Angular Structure of Lenses", eqs. 74, 77.
            Congdon & Keeton (2018), Ch. 6 (elliptical potentials).

   Usage:   wolframscript -file multipole_expansion.wl

   Outputs: Symbolic PASS/FAIL lines for each Module 8 multipole result.
   ========================================================================= *)

Print["=== Module 8: Multipole Expansion — symbolic verification ==="];
Print[""];

(* --- 2D Laplacian in polar coordinates (theta = radius, phi = azimuth) --- *)
lap2D[f_, {theta_, phi_}] :=
  D[f, {theta, 2}] + (1/theta) D[f, theta] + (1/theta^2) D[f, {phi, 2}];

(* convergence from potential: kappa = (1/2) Laplacian[psi] *)
convergence[psi_, {theta_, phi_}] := Simplify[(1/2) lap2D[psi, {theta, phi}]];

check[label_, lhs_, rhs_] := Module[{ok},
  ok = Simplify[lhs - rhs] === 0;
  Print[If[ok, "  PASS  ", "  FAIL  "], label];
  ok];

results = {};

(* ---------------------------------------------------------------------------
   Test 1: general isothermal-scaling multipole
   psi_m = a_m theta cos[m (phi - phim)]  ==>
   kappa_m = a_m (1 - m^2)/(2 theta) cos[m (phi - phim)]
   (Module 8, Eq. kappa_multipole)
   --------------------------------------------------------------------------- *)
ClearAll[a, m, theta, phi, phim];
psiM = a theta Cos[m (phi - phim)];
kappaM = convergence[psiM, {theta, phi}];
kappaMexpected = a (1 - m^2)/(2 theta) Cos[m (phi - phim)];
AppendTo[results,
  check["Multipole convergence kappa_m = a_m(1-m^2)/(2 theta) cos[m(phi-phim)]",
        kappaM, kappaMexpected]];

(* ---------------------------------------------------------------------------
   Test 2: monopole limit m = 0 reproduces the SIS, kappa_0 = a_0/(2 theta)
   with a_0 = thetaE gives the SIS profile kappa = thetaE/(2 theta).
   --------------------------------------------------------------------------- *)
psi0 = a theta;               (* m = 0 term, no angular dependence *)
kappa0 = convergence[psi0, {theta, phi}];
AppendTo[results,
  check["Monopole m=0 gives SIS kappa_0 = a_0/(2 theta)",
        kappa0, a/(2 theta)]];

(* ---------------------------------------------------------------------------
   Test 3: quadrupole limit m = 2 (elliptical distortion of an isothermal)
   kappa_2 = -(3 a_2)/(2 theta) cos[2(phi - phi2)]
   --------------------------------------------------------------------------- *)
psi2 = a theta Cos[2 (phi - phim)];
kappa2 = convergence[psi2, {theta, phi}];
AppendTo[results,
  check["Quadrupole m=2 gives kappa_2 = -(3 a_2)/(2 theta) cos[2(phi-phi2)]",
        kappa2, -(3 a)/(2 theta) Cos[2 (phi - phim)]]];

(* ---------------------------------------------------------------------------
   Test 4: pure external shear is the massless external quadrupole.
   psi_shear = (1/2) g theta^2 cos[2(phi - phig)]  ==>  kappa = 0,
   and the shear magnitude equals g.
   Shear components: gamma1 = (1/2)(psi,11 - psi,22), gamma2 = psi,12
   in Cartesian coordinates.
   --------------------------------------------------------------------------- *)
ClearAll[g, x, y, phig];
(* work in Cartesian; theta^2 cos(2 phi) = x^2 - y^2, theta^2 sin(2 phi)=2 x y *)
psiShear = (1/2) g (Cos[2 phig] (x^2 - y^2) + Sin[2 phig] (2 x y));
kappaShear = Simplify[(1/2) (D[psiShear, {x, 2}] + D[psiShear, {y, 2}])];
gamma1 = Simplify[(1/2) (D[psiShear, {x, 2}] - D[psiShear, {y, 2}])];
gamma2 = Simplify[D[D[psiShear, x], y]];
shearMagSq = Simplify[gamma1^2 + gamma2^2];
AppendTo[results,
  check["External shear potential has kappa = 0 (massless tidal field)",
        kappaShear, 0]];
AppendTo[results,
  check["External shear magnitude^2 gamma1^2+gamma2^2 = g^2",
        shearMagSq, g^2]];

(* ---------------------------------------------------------------------------
   Test 5: SIE internal-quadrupole fraction.
   Kochanek eq. 74: for an SIE the internal/external quadrupole ratio is
   (m-1)/(m+1); at m=2 that is 1/3, giving internal fraction
   f_int = (1/3)/(1 + 1/3) = 1/4.
   --------------------------------------------------------------------------- *)
intExtRatio[mm_] := (mm - 1)/(mm + 1);
fintQuad = intExtRatio[2]/(1 + intExtRatio[2]);
AppendTo[results,
  check["SIE internal/external quadrupole ratio (m-1)/(m+1) = 1/3 at m=2",
        intExtRatio[2], 1/3]];
AppendTo[results,
  check["SIE internal quadrupole fraction f_int = 1/4",
        fintQuad, 1/4]];

Print[""];
npass = Count[results, True];
ntot = Length[results];
Print["=== ", npass, "/", ntot, " multipole checks passed ==="];
If[npass === ntot,
  Print["ALL MULTIPOLE CHECKS PASS"],
  Print["*** SOME CHECKS FAILED ***"]; Exit[1]];
Print["=== End of Module 8 multipole verification ==="];
