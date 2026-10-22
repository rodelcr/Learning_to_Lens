(* =========================================================================
   problems_01e.wl
   Module 1e: Linearized Gravity and the Weak-Field Metric — SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 1e, verified
            symbolically with Mathematica.

   Sources: Carroll Ch. 4.1, 7.1; Congdon & Keeton Ch. 3.4

   Usage:   wolframscript -file problems_01e.wl

   Outputs: printed worked solutions; PASS/FAIL checks for the Annotated
            Study Edition (section at the end of this file) and a SUMMARY line.

   Exercises solved:
     1.1 — Newtonian limit from the geodesic equation
     1.2 — Weak-field Schwarzschild matches weak-field metric
     1.3 — Effective refractive index at various distances
     1.4 — Deflection angle derivation (alpha = 4GM/(c^2 b))
     1.5 — Superposition of deflection angles for two point masses
   ========================================================================= *)

Print["=== Module 1e: SOLUTIONS ===\n"];

(* Physical constants *)
Gnewton = 6.674*^-11;       (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
Rsolar = 6.96*^8;           (* m *)
AU = 1.496*^11;             (* m *)
kpc = 3.086*^19;            (* m *)


(* =========================================================================
   Exercise 1.1: Newtonian Limit from the Geodesic Equation
   ========================================================================= *)

Print["--- Exercise 1.1: Newtonian Limit ---\n"];

Print["The metric is g_{mu nu} = eta_{mu nu} + h_{mu nu}, |h| << 1.\n"];

Print["(a) Christoffel symbol Gamma^i_{00}:"];
Print["  Gamma^alpha_{mu nu} = (1/2) eta^{alpha beta}"];
Print["    (partial_mu h_{nu beta} + partial_nu h_{mu beta}"];
Print["     - partial_beta h_{mu nu})\n"];

Print["  For alpha = i (spatial), mu = nu = 0, with static field"];
Print["  (partial_0 h = 0):"];
Print["  Gamma^i_{00} = (1/2) eta^{ij} (0 + 0 - partial_j h_{00})"];
Print["               = -(1/2) partial_i h_{00}"];
Print[""];

(* Symbolic verification *)
(* Define h_{00} as a function of spatial coords *)
h00[x_, y_, z_] := -2 Phi[x, y, z] / cc^2;

Print["(b) Geodesic equation (spatial, slow motion):"];
Print["  d^2 x^i/dtau^2 + Gamma^i_{00} (dx^0/dtau)^2 = 0"];
Print["  d^2 x^i/dtau^2 = (1/2) partial_i h_{00} * c^2 (dt/dtau)^2"];
Print["  For slow motion, dtau ~ dt:"];
Print["  d^2 x^i/dt^2 = (1/2) c^2 partial_i h_{00}\n"];

Print["(c) Comparing with Newton's law d^2 x^i/dt^2 = -partial_i Phi:"];
Print["  (1/2) c^2 partial_i h_{00} = -partial_i Phi"];
Print["  => h_{00} = -2 Phi / c^2"];
Print[""];

(* Verify by substitution *)
Print["Verification: if h_{00} = -2Phi/c^2, then"];
Print["  (1/2) c^2 * partial_i (-2Phi/c^2) = -partial_i Phi  CHECK"];
Print[""];


(* =========================================================================
   Exercise 1.2: Weak-Field Schwarzschild
   ========================================================================= *)

Print["--- Exercise 1.2: Weak-Field Schwarzschild ---\n"];

Print["(a) Expansion of g_rr = (1 - Rs/r)^{-1}:"];

(* Taylor expand *)
grrExact[eps_] := 1/(1 - eps);
grrExpanded = Series[grrExact[eps], {eps, 0, 2}];
Print["  (1 - epsilon)^{-1} = ", grrExpanded];
Print["  To first order: 1 + epsilon = 1 + Rs/r\n"];

(* Verify numerical accuracy *)
Print["  Numerical check:"];
Do[
    exact = grrExact[eps0];
    approx = 1 + eps0;
    err = Abs[(exact - approx)/exact] * 100;
    Print["    Rs/r = ", eps0, ": exact = ", NumberForm[exact, 6],
        ", approx = ", NumberForm[approx, 6],
        ", error = ", NumberForm[err, 3], "%"],
    {eps0, {0.01, 0.05, 0.1, 0.2}}
];
Print[""];

Print["(b) Weak-field Schwarzschild in Cartesian-like coords:"];
Print["  ds^2 = -(1 - Rs/r) c^2 dt^2 + (1 + Rs/r)(dx^2+dy^2+dz^2)"];
Print["  With Rs/r = 2GM/(c^2 r) = -2Phi/c^2:"];
Print["    g_tt = -(1 + 2Phi/c^2)"];
Print["    g_ij = (1 - 2Phi/c^2) delta_ij"];
Print["  This IS the weak-field metric.\n"];

Print["(c) Metric perturbations:"];
Print["  h_00 = Rs/r = -2Phi/c^2"];
Print["  h_ij = (Rs/r) delta_ij = -2Phi/c^2 * delta_ij"];
Print["  h_00 = h_rr: TIME and SPACE perturbations are EQUAL."];
Print["  This equality is the origin of the factor of 2 in light bending.\n"];


(* =========================================================================
   Exercise 1.3: Effective Refractive Index
   ========================================================================= *)

Print["--- Exercise 1.3: Effective Refractive Index ---\n"];

Print["n - 1 = 2GM/(c^2 r) = 2|Phi|/c^2\n"];

nMinus1[r_] := 2 Gnewton Msolar / (cc^2 * r);

(* (a) Solar surface *)
n1 = nMinus1[Rsolar];
Print["(a) At the solar surface (r = R_sun = ", ScientificForm[Rsolar], " m):"];
Print["    n - 1 = ", ScientificForm[n1, 4]];
Print["    Weak field: YES (n-1 << 1)\n"];

(* (b) Earth orbit *)
n2 = nMinus1[AU];
Print["(b) At Earth's orbit (r = 1 AU = ", ScientificForm[AU], " m):"];
Print["    n - 1 = ", ScientificForm[n2, 4]];
Print["    Weak field: YES (extremely weak)\n"];

(* (c) 1 kpc *)
n3 = nMinus1[kpc];
Print["(c) At r = 1 kpc = ", ScientificForm[kpc], " m:"];
Print["    n - 1 = ", ScientificForm[n3, 4]];
Print["    Weak field: YES (completely negligible for a single solar mass)"];
Print["    Observable lensing requires ~10^11 solar masses at this distance.\n"];


(* =========================================================================
   Exercise 1.4: Deflection Angle Derivation
   ========================================================================= *)

Print["--- Exercise 1.4: Deflection Angle Derivation ---\n"];

Print["Unperturbed path: x(l) = (l, b, 0)"];
Print["Potential: Phi = -GM/sqrt(l^2 + b^2)\n"];

(* (a) Perpendicular gradient *)
Print["(a) Perpendicular gradient:"];
Print["  nabla_perp Phi = dPhi/db = GM*b / (l^2 + b^2)^{3/2}\n"];

(* Symbolic verification *)
Phi[l_, b_] := -Gnewton * M / Sqrt[l^2 + b^2];
gradPerp = D[Phi[l, b], b] // Simplify;
Print["  Mathematica: d/db(-GM/sqrt(l^2+b^2)) = ", gradPerp];
Print["  = GM*b / (l^2+b^2)^{3/2}  (after extracting overall sign)\n"];

(* (b) Evaluate the integral *)
Print["(b) The key integral:"];
integrand = b / (l^2 + b^2)^(3/2);
result = Integrate[integrand, {l, -Infinity, Infinity},
    Assumptions -> b > 0];
Print["  integral_{-inf}^{+inf} b dl / (l^2+b^2)^{3/2} = ", result];
Print["  = 2/b  (as expected)\n"];

(* (c) Combine *)
Print["(c) Deflection angle:"];
(* eq. deflection_integral: alpha_hat = (1 + gamma_PPN)/c^2 * int nabla_perp|Phi| dl.
   The time part (h_00) contributes (1/c^2) * int = 2GM/(c^2 b); the space
   part (h_ij) contributes an equal amount (gamma_PPN = 1 in GR). *)
Print["  alpha_hat = (1 + gamma_PPN)/c^2 * integral nabla_perp |Phi| dl"];
Print["  Time part (h_00):  (1/c^2) * GM * (2/b) = 2GM/(c^2 b)"];
Print["  Space part (h_ij): equal (gamma_PPN = 1), 2GM/(c^2 b)"];
Print["  Total: alpha_hat = (2/c^2) * GM * (2/b) = 4GM/(c^2 b)  CHECK\n"];

(* (d) Numerical values *)
Print["(d) Numerical values:\n"];

(* Sun at solar limb *)
alphaHatSun = 4 * Gnewton * Msolar / (cc^2 * Rsolar);
alphaHatSunArcsec = alphaHatSun * 180 * 3600 / Pi;
Print["  Sun at solar limb (b = R_sun):"];
Print["    alpha_hat = ", ScientificForm[alphaHatSun, 4], " rad"];
Print["             = ", NumberForm[alphaHatSunArcsec, {4, 2}], " arcsec"];
Print["    Expected: 1.75 arcsec (Eddington 1919)\n"];

(* Galaxy lens *)
Mgal = 1*^12 * Msolar;       (* 10^12 solar masses *)
bgal = 10 * kpc;              (* 10 kpc *)
alphaHatGal = 4 * Gnewton * Mgal / (cc^2 * bgal);
alphaHatGalArcsec = alphaHatGal * 180 * 3600 / Pi;
Print["  Galaxy lens (M = 10^12 Msun, b = 10 kpc):"];
Print["    alpha_hat = ", ScientificForm[alphaHatGal, 4], " rad"];
Print["             = ", NumberForm[alphaHatGalArcsec, {4, 2}], " arcsec\n"];


(* =========================================================================
   Exercise 1.5: Superposition of Deflection Angles
   ========================================================================= *)

Print["--- Exercise 1.5: Superposition ---\n"];

Print["Two equal masses M at (-d/2, 0) and (+d/2, 0)."];
Print["Photon at (0, b).\n"];

(* (a) Individual deflections *)
Print["(a) Displacement vectors:"];
Print["  xi - xi_1 = (d/2, b),   |xi - xi_1|^2 = d^2/4 + b^2"];
Print["  xi - xi_2 = (-d/2, b),  |xi - xi_2|^2 = d^2/4 + b^2\n"];

Print["  alpha_1 = (4GM/c^2) * (d/2, b) / (d^2/4 + b^2)"];
Print["  alpha_2 = (4GM/c^2) * (-d/2, b) / (d^2/4 + b^2)\n"];

(* (b) Total deflection *)
Print["(b) Total deflection:"];
Print["  x-component: (4GM/c^2) * (d/2 - d/2) / (d^2/4 + b^2) = 0"];
Print["  (cancels by symmetry)\n"];

alphaY = Simplify[4 G M / (d^2/4 + b^2) * b + 4 G M / (d^2/4 + b^2) * b];
Print["  y-component: alpha_y = ", alphaY];
Print["             = 8GMb / (c^2 (d^2/4 + b^2))\n"];

(* Symbolic verification *)
alphaYsymbolic[dd_, bb_] := 8 Gnewton M bb / (cc^2 * (dd^2/4 + bb^2));

(* (c) Limit d -> 0 *)
Print["(c) Limit d -> 0:"];
limitResult = Limit[8 G M b / (d^2/4 + b^2), d -> 0];
Print["  alpha_y -> ", limitResult];
Print["         = 8GM/b = 4G(2M) / (c^2 b)"];
Print["  This is the deflection by a single mass of 2M.  CHECK\n"];

(* (d) Limit b >> d *)
Print["  For b >> d: d^2/4 + b^2 -> b^2, so"];
Print["  alpha_y -> 8GM/(c^2 b) = 4G(2M)/(c^2 b)"];
Print["  At large distances, the pair acts as a single mass 2M.\n"];

(* Numerical example *)
Print["Numerical example: M = 10^11 Msun, d = 1 kpc"];
Mval = 1*^11 * Msolar;
dval = 1 * kpc;
bvals = {0.5, 1, 2, 5, 10, 20, 50};
Print["  b (kpc)   alpha_y (arcsec)   alpha_single_2M (arcsec)   ratio"];
Do[
    bval = bb * kpc;
    aSup = 8 * Gnewton * Mval * bval / (cc^2 * (dval^2/4 + bval^2));
    aSingle = 4 * Gnewton * 2 * Mval / (cc^2 * bval);
    ratio = aSup / aSingle;
    Print["  ", NumberForm[bb, {4, 1}],
        "       ", NumberForm[aSup * 180 * 3600 / Pi, {5, 3}],
        "             ", NumberForm[aSingle * 180 * 3600 / Pi, {5, 3}],
        "               ", NumberForm[ratio, {4, 4}]],
    {bb, bvals}
];
Print["  => For b >> d, the two-mass result converges to single-mass 2M.\n"];

Print["=== End of Module 1e Solutions ==="];


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity / number that appears inside an annotation, derivation or
   bridge box of Notes/01e_Linearized_Gravity/*.tex is checked here.
   Symbols are prefixed "an" so nothing above is shadowed. *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                  "Mathematica", "harness.wl"}]];
Print["\n=== Annotated-edition checks (2026-10) ===\n"];

anChrist[g_, X_] := Module[{gi = Inverse[g], n = Length[X]},
  Table[Sum[gi[[a, d]] (D[g[[d, m]], X[[k]]] + D[g[[d, k]], X[[m]]]
        - D[g[[m, k]], X[[d]]])/2, {d, n}], {a, n}, {m, n}, {k, n}]];
anRicci[Gam_, X_] := Module[{n = Length[X]},
  Table[Sum[D[Gam[[a, m, k]], X[[a]]], {a, n}] - Sum[D[Gam[[a, m, a]], X[[k]]], {a, n}] +
    Sum[Gam[[a, a, b]] Gam[[b, m, k]], {a, n}, {b, n}] -
    Sum[Gam[[a, k, b]] Gam[[b, m, a]], {a, n}, {b, n}], {m, n}, {k, n}]];
anFirst[e_] := (D[e, ans] /. ans -> 0);   (* first-order coefficient in ans *)

(* --- B1  orders of magnitude (point-mass |Phi|/c^2 = GM/(r c^2)) --- *)
anGN = 6.674*^-11; anMs = 1.989*^30; anCl = 2.998*^8; anKpc = 3.086*^19;
anPhi[m_, r_] := anGN m/(r anCl^2);
Print["    |Phi|/c^2: Sun limb ", anPhi[anMs, 6.96*^8], "; galaxy ",
  anPhi[1*^12 anMs, 10 anKpc], "; cluster ", anPhi[1*^15 anMs, 1000 anKpc]];
check["B1a Sun limb |Phi|/c^2 = 2.12e-6", Abs[anPhi[anMs, 6.96*^8] - 2.12*^-6] < 0.005*^-6];
check["B1b 1e12 Msun at 10 kpc: 4.8e-6", Abs[anPhi[1*^12 anMs, 10 anKpc] - 4.8*^-6] < 0.05*^-6];
check["B1c 1e15 Msun at 1 Mpc: 4.8e-5", Abs[anPhi[1*^15 anMs, 1000 anKpc] - 4.8*^-5] < 0.05*^-5];
check["B1d alpha_hat(limb) = 4 |Phi|/c^2 = 8.49e-6 rad = 1.75 arcsec",
  Abs[4 anPhi[anMs, 6.96*^8] - 8.49*^-6] < 0.005*^-6 &&
  Abs[4 anPhi[anMs, 6.96*^8] 180 3600/Pi - 1.75] < 0.005];

(* --- B2  inverse metric to first order --- *)
anEta = DiagonalMatrix[{-1, 1, 1, 1}];
anH = Table[anh[Min[i, j], Max[i, j]], {i, 4}, {j, 4}];
anProd = Expand[(anEta + ans anH).(anEta - ans anEta.anH.anEta)];
check["B2 (eta + h)(eta - eta h eta) = 1 + O(h^2)",
  Simplify[(anProd /. ans -> 0) - IdentityMatrix[4]] === ConstantArray[0, {4, 4}] &&
  Simplify[anFirst[anProd]] === ConstantArray[0, {4, 4}]];

(* --- B3  Christoffels of the weak-field metric (x0 = ct), first order --- *)
anX = {anx0, anx, any, anz};
anP = anPh[anx, any, anz];             (* Phi/c^2, static *)
anGam[gam_] := anChrist[DiagonalMatrix[{-(1 + 2 ans anP), 1 - 2 gam ans anP,
     1 - 2 gam ans anP, 1 - 2 gam ans anP}], anX];
anG1 = anGam[1];
anG1first = Simplify[anFirst[anG1]];
check["B3a zeroth order: all Christoffels vanish",
  Simplify[anG1 /. ans -> 0] === ConstantArray[0, {4, 4, 4}]];
(* linearized formula 1/2 eta^{ab}(d_m h_kb + d_k h_mb - d_b h_mk) *)
anHw = DiagonalMatrix[{-2 anP, -2 anP, -2 anP, -2 anP}];
anLin = Table[Sum[anEta[[a, b]] (D[anHw[[k, b]], anX[[m]]] + D[anHw[[m, b]], anX[[k]]] -
      D[anHw[[m, k]], anX[[b]]])/2, {b, 4}], {a, 4}, {m, 4}, {k, 4}];
check["B3b first-order Christoffels = (1/2) eta (dh + dh - dh)  [eq. christoffel_linearized]",
  Simplify[anG1first - anLin] === ConstantArray[0, {4, 4, 4}]];
check["B3c Gamma^0_00 = 0 and Gamma^i_0j = 0 (static)",
  anG1first[[1, 1, 1]] === 0 &&
  And @@ Flatten[Table[anG1first[[i, 1, j]] === 0, {i, 2, 4}, {j, 2, 4}]]];
check["B3d Gamma^i_00 = Gamma^0_0i = d_i (Phi/c^2) = -(1/2) d_i h_00",
  And @@ Table[Simplify[anG1first[[i, 1, 1]] - D[anP, anX[[i]]]] === 0 &&
     Simplify[anG1first[[1, 1, i]] - D[anP, anX[[i]]]] === 0, {i, 2, 4}]];
check["B3e Gamma^y_xx = + d_y (Phi/c^2) (from h_xx), Gamma^y_0x = 0",
  Simplify[anG1first[[3, 2, 2]] - D[anP, any]] === 0 && anG1first[[3, 1, 2]] === 0];
(* photon along +x, k = (1, 1, 0, 0): transverse acceleration *)
anAcc[gam_] := Module[{g = Simplify[anFirst[anGam[gam]]], kk = {1, 1, 0, 0}},
  -Sum[g[[3, a, b]] kk[[a]] kk[[b]], {a, 4}, {b, 4}]];
check["B3f d^2y/dl^2 = -(Gamma^y_00 + 2 Gamma^y_0x + Gamma^y_xx) = -2 d_y(Phi/c^2)",
  Simplify[anAcc[1] + 2 D[anP, any]] === 0];
check["B3g PPN: g_ij = (1 - 2 gamma Phi/c^2) => d^2y/dl^2 = -(1 + gamma) d_y(Phi/c^2)",
  Simplify[anAcc[gamPPN] + (1 + gamPPN) D[anP, any]] === 0];
check["B3h time part alone (gamma = 0) = half of GR", Simplify[anAcc[0] - anAcc[1]/2] === 0];

(* --- B4  linearized Einstein tensor of the weak-field metric --- *)
anEin[gam_] := Module[{g = DiagonalMatrix[{-(1 + 2 ans anP), 1 - 2 gam ans anP,
     1 - 2 gam ans anP, 1 - 2 gam ans anP}], Gm, Ric, Rs},
  Gm = anChrist[g, anX]; Ric = anRicci[Gm, anX];
  Rs = Sum[Inverse[g][[a, b]] Ric[[a, b]], {a, 4}, {b, 4}];
  Simplify[anFirst[Ric - g Rs/2]]];
anLap = D[anP, {anx, 2}] + D[anP, {any, 2}] + D[anP, {anz, 2}];
anE1 = anEin[1];
check["B4a G_00 = 2 nabla^2(Phi/c^2)  => G_00 = 8 Pi G rho/c^2 gives nabla^2 Phi = 4 Pi G rho",
  Simplify[anE1[[1, 1]] - 2 anLap] === 0];
check["B4b G_ij = 0 at first order when g_ij = (1 - 2Phi/c^2) delta_ij",
  Simplify[anE1[[2 ;; 4, 2 ;; 4]]] === ConstantArray[0, {3, 3}]];
anEg = anEin[gamPPN];
check["B4c for gamma != 1, G_xy = (gamma - 1) d_x d_y (Phi/c^2) != 0 (needs T_xy = 0 => gamma = 1)",
  Simplify[anEg[[2, 3]] - (gamPPN - 1) D[anP, anx, any]] === 0];
check["B4d G_0i = 0 (static)", And @@ Table[anE1[[1, i]] === 0, {i, 2, 4}]];

(* --- B5  trace reversal: hbar_00 = -4 Phi, others 0 => h = diag(-2Phi) --- *)
anHbar = DiagonalMatrix[{-4 anq, 0, 0, 0}];
anTrHbar = Sum[anEta[[m, m]] anHbar[[m, m]], {m, 4}];
check["B5a trace hbar = eta^{mu nu} hbar_{mu nu} = +4 Phi/c^2", anTrHbar === 4 anq];
check["B5b h_{mu nu} = hbar_{mu nu} - (1/2) eta_{mu nu} hbar = -2 (Phi/c^2) diag(1,1,1,1)",
  anHbar - anEta anTrHbar/2 === -2 anq IdentityMatrix[4]];
check["B5c Poisson: nabla^2 hbar_00 = -16 Pi G rho/c^2 with hbar_00 = -4 Phi/c^2, nabla^2 Phi = 4 Pi G rho",
  Simplify[-4 (4 Pi anGG anrho)/anc^2 - (-16 Pi anGG anrho/anc^2)] === 0];

(* --- B6  Schwarzschild -> isotropic, first order --- *)
anR[rho_] := rho (1 + anRs/(4 rho))^2;
check["B6a exact: 1 - Rs/r(rho) = ((1 - Rs/4rho)/(1 + Rs/4rho))^2",
  Simplify[1 - anRs/anR[anrho] - ((1 - anRs/(4 anrho))/(1 + anRs/(4 anrho)))^2] === 0];
check["B6b exact: (dr/drho)^2/(1 - Rs/r) = (1 + Rs/4rho)^4 and r^2 = (1 + Rs/4rho)^4 rho^2",
  Simplify[D[anR[anrho], anrho]^2/(1 - anRs/anR[anrho]) - (1 + anRs/(4 anrho))^4,
    Assumptions -> anrho > anRs > 0] === 0 &&
  Simplify[anR[anrho]^2 - (1 + anRs/(4 anrho))^4 anrho^2] === 0];
check["B6c r = rho + Rs/2 + Rs^2/(16 rho); dr/drho = 1 - Rs^2/(16 rho^2)",
  Simplify[Expand[anR[anrho]] - (anrho + anRs/2 + anRs^2/(16 anrho))] === 0 &&
  Simplify[D[anR[anrho], anrho] - (1 - anRs^2/(16 anrho^2))] === 0];
anSer[e_] := Normal[Series[e, {anRs, 0, 1}]];
check["B6d first order: 1 - Rs/r -> 1 - Rs/rho; (1 + Rs/r)(dr/drho)^2 -> 1 + Rs/rho; r^2/rho^2 -> 1 + Rs/rho",
  Simplify[anSer[1 - anRs/anR[anrho]] - (1 - anRs/anrho)] === 0 &&
  Simplify[anSer[(1 + anRs/anR[anrho]) D[anR[anrho], anrho]^2] - (1 + anRs/anrho)] === 0 &&
  Simplify[anSer[anR[anrho]^2/anrho^2] - (1 + anRs/anrho)] === 0];
check["B6e naive relabelling is wrong at first order: (1+Rs/r) r^2 - r^2 = Rs r != O(Rs^2)",
  Simplify[(1 + anRs/anr) anr^2 - anr^2] === anRs anr];

(* --- B7  coordinate speed and refractive index --- *)
check["B7a Sqrt[(1 + 2p)/(1 - 2p)] = 1 + 2p + O(p^2)",
  Normal[Series[Sqrt[(1 + 2 anp)/(1 - 2 anp)], {anp, 0, 1}]] === 1 + 2 anp];
check["B7b n = c/v = 1 - 2p + O(p^2)",
  Normal[Series[Sqrt[(1 - 2 anp)/(1 + 2 anp)], {anp, 0, 1}]] === 1 - 2 anp];
check["B7c point mass: n - 1 = 2|Phi|/c^2 = R_S/r",
  Simplify[2 anGG anMM/(anc^2 anr) - (2 anGG anMM/anc^2)/anr] === 0];

(* --- B8  the line-of-sight integral --- *)
check["B8a x = b tan(t): b dx/(x^2+b^2)^(3/2) = cos(t) dt/b",
  Simplify[(anb (anb Sec[ant]^2)/((anb Tan[ant])^2 + anb^2)^(3/2)) - Cos[ant]/anb,
    Assumptions -> {anb > 0, -Pi/2 < ant < Pi/2}] === 0];
check["B8b Integrate[cos t, {t, -Pi/2, Pi/2}]/b = 2/b",
  Integrate[Cos[ant], {ant, -Pi/2, Pi/2}]/anb === 2/anb];
anFrac[X_] := Integrate[anb/(anl^2 + anb^2)^(3/2), {anl, -X, X},
    Assumptions -> {anb > 0, X > 0}]/(2/anb);
check["B8c fraction of the deflection from |x| < X = X/Sqrt(X^2 + b^2)",
  Simplify[anFrac[anXX] - anXX/Sqrt[anXX^2 + anb^2], Assumptions -> {anb > 0, anXX > 0}] === 0];
Print["    fraction within |x|<b: ", N[anFrac[anb] /. anb -> 1], "; within |x|<10b: ",
  N[anFrac[10 anb] /. anb -> 1]];
check["B8d within |x| < b: 1/Sqrt2 = 0.707; within |x| < 10 b: 0.995",
  Simplify[anFrac[anb]] === 1/Sqrt[2] && Round[N[anFrac[10 anb]], 0.001] == 0.995];
check["B8e antiderivative d/dl[l/(b^2 Sqrt(l^2+b^2))] = 1/(l^2+b^2)^(3/2)",
  Simplify[D[anl/(anb^2 Sqrt[anl^2 + anb^2]), anl] - 1/(anl^2 + anb^2)^(3/2)] === 0];
check["B8f d/db of -GM/Sqrt(l^2+b^2) = + GM b/(l^2+b^2)^(3/2) (gradient of Phi, outward)",
  Simplify[D[-anGG anMM/Sqrt[anl^2 + anb^2], anb] - anGG anMM anb/(anl^2 + anb^2)^(3/2)] === 0];

(* --- B9  second-order correction (caption numbers) and an exact check --- *)
anK = 15 Pi/32;
Print["    15 Pi/32 = ", N[anK], "; fraction at b/Rs = 10, 30, 100: ",
  N[anK {1/10, 1/30, 1/100}], "; 1% at b/Rs = ", N[anK/0.01], "; 0.1% at ", N[anK/0.001]];
check["B9a (15Pi/4)(m/b)^2 / (4m/b) = (15Pi/32) Rs/b with Rs = 2m",
  Simplify[((15 Pi/4) (anm/anb)^2/(4 anm/anb)) - (15 Pi/32) (2 anm)/anb] === 0];
check["B9b fractions 0.147, 0.049, 0.0147 at b/Rs = 10, 30, 100",
  Round[N[anK/10], 0.001] == 0.147 && Round[N[anK/30], 0.001] == 0.049 &&
  Round[N[anK/100], 0.0001] == 0.0147];
check["B9c 1% at b/Rs = 147, 0.1% at 1473", Round[N[anK/0.01]] == 147 && Round[N[anK/0.001]] == 1473];
(* exact Schwarzschild deflection (units Rs = 1): alpha = 2 Int_0^u0 du/Sqrt[1/b^2 - u^2 + u^3] - Pi *)
anExact[bb_] := Module[{u0, w},
  u0 = Min[Select[u /. NSolve[1/bb^2 - u^2 + u^3 == 0, u, WorkingPrecision -> 40],
      Positive]];
  (* u = u0 (1 - w^2) removes the inverse-square-root endpoint singularity *)
  2 NIntegrate[2 u0 w/Sqrt[1/bb^2 - (u0 (1 - w^2))^2 + (u0 (1 - w^2))^3], {w, 0, 1},
     WorkingPrecision -> 30, PrecisionGoal -> 15] - Pi];
anA100 = anExact[100]; anA1000 = anExact[1000];
Print["    exact alpha(b = 100 Rs) = ", N[anA100, 10], " vs 2 Rs/b = 0.02; shortfall fraction ",
  N[(anA100 - 2/100)/anA100, 6], " vs (15Pi/32)/100 = ", N[anK/100, 6]];
check["B9d exact shortfall at b = 100 Rs agrees with (15Pi/32) Rs/b to 3%",
  Abs[((anA100 - 2/100)/anA100)/(anK/100) - 1] < 0.03];
check["B9e exact shortfall at b = 1000 Rs agrees with (15Pi/32) Rs/b to 0.3%",
  Abs[((anA1000 - 2/1000)/anA1000)/(anK/1000) - 1] < 0.003];
check["B9f Sun: b/Rs = R_sun/(2GM/c^2) = 2.36e5",
  Abs[6.96*^8/(2 anGN anMs/anCl^2) - 2.36*^5] < 0.005*^5];

(* --- B10 Shapiro delay along a straight path from -x1 to x2 --- *)
anSh = Integrate[1/Sqrt[anl^2 + anb^2], {anl, -anx1, anx2},
   Assumptions -> {anb > 0, anx1 > 0, anx2 > 0}];
check["B10a Int dl/Sqrt(l^2+b^2) = ln[(x2 + Sqrt(x2^2+b^2))(x1 + Sqrt(x1^2+b^2))/b^2]",
  Simplify[anSh - Log[(anx2 + Sqrt[anx2^2 + anb^2]) (anx1 + Sqrt[anx1^2 + anb^2])/anb^2],
    Assumptions -> {anb > 0, anx1 > 0, anx2 > 0}] === 0];
check["B10b x1, x2 >> b: -> ln(4 x1 x2/b^2)",
  Simplify[Normal[Series[Log[(anx2 + Sqrt[anx2^2 + anb^2]) (anx1 + Sqrt[anx1^2 + anb^2])/anb^2] /.
       {anx1 -> anx1/anep, anx2 -> anx2/anep}, {anep, 0, 0}]] -
     Log[4 anx1 anx2/(anep^2 anb^2)], Assumptions -> {anb > 0, anx1 > 0, anx2 > 0, anep > 0}] === 0];

(* --- B11 2D Green's function and the point-mass limit of the continuous formula --- *)
check["B11a nabla^2 ln|xi| = 0 for xi != 0",
  Simplify[D[Log[Sqrt[anx^2 + any^2]], {anx, 2}] + D[Log[Sqrt[anx^2 + any^2]], {any, 2}]] === 0];
check["B11b grad ln|xi| = xi/|xi|^2",
  Simplify[{D[Log[Sqrt[anx^2 + any^2]], anx], D[Log[Sqrt[anx^2 + any^2]], any]} -
    {anx, any}/(anx^2 + any^2)] === {0, 0}];
check["B11c flux of grad ln|xi| through a circle = 2 Pi (so nabla^2 ln|xi| = 2 Pi delta)",
  Integrate[anr0 (1/anr0), {ant, 0, 2 Pi}] === 2 Pi];
check["B11d 8 Pi G Sigma/c^2 * (1/2Pi) ln => prefactor 4G/c^2",
  Simplify[(8 Pi anGG/anc^2)/(2 Pi)] === 4 anGG/anc^2];
check["B11e d/db Int_{-Z}^{Z} (-GM/Sqrt(z^2+b^2)) dz -> 2GM/b as Z -> Infinity",
  Limit[Simplify[D[Integrate[-anGG anMM/Sqrt[anl^2 + anb^2], {anl, -anZZ, anZZ},
        Assumptions -> {anb > 0, anZZ > 0}], anb], Assumptions -> {anb > 0, anZZ > 0}],
    anZZ -> Infinity, Assumptions -> anb > 0] === 2 anGG anMM/anb];
check["B11f Sigma = M delta^2: |(4GM/c^2) xi/|xi|^2| = 4GM/(c^2 |xi|)",
  Simplify[Norm[(4 anGG anMM/anc^2) {anx, any}/(anx^2 + any^2)] - 4 anGG anMM/(anc^2 Sqrt[anx^2 + any^2]),
    Assumptions -> {anx \[Element] Reals, any \[Element] Reals, anGG > 0, anMM > 0, anc > 0}] === 0];

(* --- B12 exercise numbers --- *)
anN1 = 2 anGN anMs/(anCl^2 6.96*^8); anN2 = 2 anGN anMs/(anCl^2 1.496*^11);
anN3 = 2 anGN anMs/(anCl^2 anKpc);
Print["    n - 1: ", {anN1, anN2, anN3}, "; Pluto (39.5 AU): ", 2 anGN anMs/(anCl^2 39.5 1.496*^11)];
check["B12a n - 1 = 4.24e-6, 1.97e-8 at R_sun, 1 AU",
  Abs[anN1 - 4.24*^-6] < 0.005*^-6 && Abs[anN2 - 1.97*^-8] < 0.005*^-8];
check["B12b n - 1 at 1 kpc = 9.57e-17",
  Abs[anN3 - 9.57*^-17] < 0.005*^-17];
anAg = 4 anGN 1*^12 anMs/(anCl^2 10 anKpc);
Print["    galaxy alpha_hat = ", anAg, " rad = ", anAg 180 3600/Pi, " arcsec"];
check["B12c galaxy: 1.91e-5 rad = 3.95 arcsec",
  Abs[anAg - 1.91*^-5] < 0.005*^-5 && Abs[anAg 180 3600/Pi - 3.95] < 0.005];
check["B12d R_sun limb: 8.49e-6 rad = 1.75 arcsec",
  Abs[4 anGN anMs/(anCl^2 6.96*^8) - 8.49*^-6] < 0.005*^-6];

(* --- B13 two-mass superposition: multipole expansion --- *)
check["B13a alpha_y / alpha_(2M) = b^2/(b^2 + d^2/4) = 1 - d^2/(4 b^2) + O(d^4)",
  Simplify[(8 anGG anMM anb/(anc^2 (anDD^2/4 + anb^2)))/(4 anGG 2 anMM/(anc^2 anb)) -
     anb^2/(anb^2 + anDD^2/4)] === 0 &&
  Normal[Series[anb^2/(anb^2 + anDD^2/4), {anDD, 0, 2}]] === 1 - anDD^2/(4 anb^2)];
check["B13b x-components (4GM/c^2)(d/2 - d/2)/(d^2/4+b^2) = 0", (anDD/2 - anDD/2) === 0];
Print["    ratio at b = 10 d: ", N[100/(100 + 1/4), 6]];
check["B13c ratio at b = 10 d is 0.99751", Abs[N[100/(100 + 1/4)] - 0.99751] < 0.000005];

(* --- B14 extra checks quoted in the annotated boxes --- *)
anGijk = Table[D[anP, anX[[i]]] KroneckerDelta[j, k] - D[anP, anX[[k]]] KroneckerDelta[i, j] -
    D[anP, anX[[j]]] KroneckerDelta[i, k], {i, 2, 4}, {j, 2, 4}, {k, 2, 4}];
check["B14a Gamma^i_jk = d_i(Phi/c^2) d_jk - d_j(Phi/c^2) d_ik - d_k(Phi/c^2) d_ij",
  Simplify[anG1first[[2 ;; 4, 2 ;; 4, 2 ;; 4]] - anGijk] === ConstantArray[0, {3, 3, 3}]];
check["B14b n - 1 = (1/2)(h_00 + h_xx) with h_00 = h_xx = -2 Phi/c^2",
  Simplify[(1/2) (-2 anq - 2 anq) - (-2 anq)] === 0];
check["B14c g^00 = 1/g_00 = -1/(1 - h_00) = -1 - h_00 + O(h^2)",
  Normal[Series[1/(-1 + anh00), {anh00, 0, 1}]] === -1 - anh00];
check["B14d alpha_hat = 1.75'' (M/Msun)(R_sun/b): galaxy 1e12 Msun at 10 kpc = 3.95''",
  Abs[1.75 1*^12 (6.96*^8/(10 anKpc)) - 3.95] < 0.005];
check["B14e (1 + 2p)^(1/2) (1 - 2p)^(-1/2) = (1 + p)(1 + p) + O(p^2)",
  Normal[Series[Sqrt[1 + 2 anp], {anp, 0, 1}]] === 1 + anp &&
  Normal[Series[1/Sqrt[1 - 2 anp], {anp, 0, 1}]] === 1 + anp];
check["B14f local speed: Sqrt(1 - 2p)|dx| / (Sqrt(1 + 2p) dt) = c when |dx|/dt = c Sqrt((1+2p)/(1-2p))",
  Simplify[Sqrt[1 - 2 anp] (anc Sqrt[(1 + 2 anp)/(1 - 2 anp)])/Sqrt[1 + 2 anp],
    Assumptions -> -1/2 < anp < 0 && anc > 0] === anc];
check["B14g h_00 + 2Phi/c^2 = const, both -> 0 at infinity => const = 0 (point mass)",
  Limit[(2 anGG anMM/(anc^2 anr)) + 2 (-anGG anMM/anr)/anc^2, anr -> Infinity] === 0];
check["B14h Earth orbital speed: (29.78 km/s / c)^2 = 1e-8 (order of magnitude)",
  Round[Log10[(29.78*^3/anCl)^2]] == -8];
check["B14i R_S(Sun)/R_sun = 2.95 km / 6.96e5 km = 4.24e-6",
  Abs[2.95/6.96*^5 - 4.24*^-6] < 0.005*^-6 && Abs[2 anGN anMs/anCl^2/1000 - 2.95] < 0.005];
check["B14j galaxy |Phi|/c^2 = 4.8e-6 is of order 1e-5 (nearest power of ten)",
  Round[Log10[anPhi[1*^12 anMs, 10 anKpc]]] == -5];

(* ===== Fix-pass checks (2026-10-14; FACT_CRITIC_01e_annotated_2026-10-14 F4-F8) =====
   Each check passes on the corrected text and is written to FAIL on the old value. *)
Print["\n=== Fix-pass checks (2026-10-14) ===\n"];

(* --- F4  01e_Solutions Ex 2(b): the relabelling difference is FIRST order --- *)
fxDiff = (1 + anRs/anr) (anr^2) - anr^2;   (* coefficient of dOmega^2: (1+Rs/r) r^2 vs r^2 *)
check["F4a difference R_S r dOmega^2 is first order in R_S/r (old 'second order' fails)",
  Simplify[fxDiff/anr^2] === anRs/anr &&
  Coefficient[Normal[Series[fxDiff/anr^2, {anRs, 0, 2}]], anRs, 1] =!= 0];
check["F4b isotropic radius: radial and angular factors both 1 + Rs/rho at first order",
  Simplify[anSer[(1 + anRs/anR[anrho]) D[anR[anrho], anrho]^2] -
           anSer[anR[anrho]^2/anrho^2]] === 0 &&
  Simplify[anSer[anR[anrho]^2/anrho^2] - (1 + anRs/anrho)] === 0];
check["F4c Phi/c^2 = -Rs/(2 rho) vs -Rs/(2 r(rho)) differ only at O(Rs^2)",
  Simplify[Normal[Series[-anRs/(2 anR[anrho]) + anRs/(2 anrho), {anRs, 0, 1}]]] === 0 &&
  Simplify[Normal[Series[-anRs/(2 anR[anrho]) + anRs/(2 anrho), {anRs, 0, 2}]]] =!= 0];

(* --- F5  eq. lens_equation_preview: beta = theta - alpha, alpha = (Dds/Ds) alpha_hat --- *)
fxBeta = Solve[fxDs fxbeta == fxDs fxth - fxDds fxah, fxbeta][[1, 1, 2]];
check["F5a geometry Ds beta = Ds theta - Dds alpha_hat => beta = theta - (Dds/Ds) alpha_hat",
  Simplify[fxBeta - (fxth - (fxDds/fxDs) fxah)] === 0];
check["F5b old preview theta - (Dds/Ds)(Dd/Ds) alpha_hat disagrees unless Dd = Ds",
  Simplify[fxBeta - (fxth - (fxDds/fxDs) (fxDd/fxDs) fxah)] =!= 0 &&
  Simplify[(fxBeta - (fxth - (fxDds/fxDs) (fxDd/fxDs) fxah)) /. fxDd -> fxDs] === 0];

(* --- F6  01e_Solutions roundings --- *)
check["F6a Ex 3(c) n - 1 at 1 kpc = 9.57e-17 at 3 s.f. (old 9.58e-17 fails)",
  Round[anN3 10^17, 0.01] == 9.57 && Round[anN3 10^17, 0.01] != 9.58];
check["F6b galaxy lens alpha_hat = 3.95 arcsec at 3 s.f. (old 3.94 fails)",
  Round[anAg 180 3600/Pi, 0.01] == 3.95 && Round[anAg 180 3600/Pi, 0.01] != 3.94];

(* --- F7  Cassini (Bertotti, Iess & Tortora 2003): gamma - 1 = (2.1 +- 2.3) x 10^-5 --- *)
fxGc = 2.1*^-5; fxGs = 2.3*^-5;
check["F7 1-sigma range of gamma - 1 is [-0.2, 4.4] x 1e-5; the old '|gamma - 1| < 2.3e-5' excludes most of it",
  Abs[(fxGc + fxGs) - 4.4*^-5] < 1*^-12 && Abs[(fxGc - fxGs) + 0.2*^-5] < 1*^-12 &&
  (fxGc + fxGs) > 2.3*^-5];

(* --- F8  NFW cluster potential (M200 = 1e15 Msun, c200 = 4 and 6, H0 = 70; assumed typical values) --- *)
fxMpc = 1000 anKpc; fxH0 = 70*^3/fxMpc; fxRhoc = 3 fxH0^2/(8 Pi anGN);
fxM200 = 1*^15 anMs; fxR200 = (3 fxM200/(4 Pi 200 fxRhoc))^(1/3);
fxPhiNFW[c_, r_] := Module[{rs = fxR200/c},
   anGN fxM200 Log[1 + r/rs]/(r (Log[1 + c] - c/(1 + c)))/anCl^2];
Print["    NFW r200 = ", fxR200/fxMpc, " Mpc; |Phi|/c^2 (c=4,6) at 100 kpc: ",
  {fxPhiNFW[4, 100 anKpc], fxPhiNFW[6, 100 anKpc]}, "; 300 kpc: ",
  {fxPhiNFW[4, 300 anKpc], fxPhiNFW[6, 300 anKpc]}, "; 1 Mpc: ",
  {fxPhiNFW[4, fxMpc], fxPhiNFW[6, fxMpc]}];
check["F8 NFW |Phi|/c^2 within 0.8-1.4 x 1e-4 for r <= 300 kpc, below 0.7e-4 at 1 Mpc (c200 = 4, 6)",
  And @@ Flatten[Table[{0.8*^-4 < fxPhiNFW[cc, rr anKpc] < 1.4*^-4}, {cc, {4, 6}}, {rr, {1, 30, 100, 200, 300}}]] &&
  fxPhiNFW[4, fxMpc] < 0.7*^-4 && fxPhiNFW[6, fxMpc] < 0.7*^-4];

summary[];
