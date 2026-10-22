(* =========================================================================
   problems_01b.wl
   Module 1b: Differential Geometry — SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 1b, verified
            symbolically with Mathematica.

   Sources: Carroll Ch. 2-3, Congdon & Keeton Ch. 3.2

   Usage:   wolframscript -file problems_01b.wl

   Exercises solved:
     1.1 — Christoffel symbols of the 2-sphere
     1.2 — Polar coordinates: Christoffel, Riemann, geodesics
     1.3 — Riemann tensor, Ricci tensor, Ricci scalar for 2-sphere
     1.4 — Parallel transport on the sphere
     1.5 — Great circles as geodesics
   Annotated-edition checks (2026-10): a delimited section at the end of
     this file check[]s every identity / number written in the derivation,
     annotation and bridge boxes of the matching _Solutions.tex (Annotated
     Study Edition).  The script ends with summary[] (exit 0 iff all PASS).
   Fix pass (2026-10-14): checks backing the fact-critic fixes of the
     2026-10-14 reports (Notes/01?_*/FACT_CRITIC_*_annotated_2026-10-14.md);
     each fails on the old (pre-fix) value.
     Run:  bash Mathematica/run_wl.sh <this file>
   ========================================================================= *)

Print["=== Module 1b: SOLUTIONS ===\n"];

(* ---- Import computation functions (same as christoffel_symbols.wl) ---- *)

computeChristoffel[metric_, coords_] := Module[
    {n, invMetric},
    n = Length[coords];
    invMetric = Simplify[Inverse[metric]];
    Table[
        Simplify[
            Sum[(1/2) invMetric[[s, rho]] (
                D[metric[[nu, rho]], coords[[mu]]]
                + D[metric[[rho, mu]], coords[[nu]]]
                - D[metric[[mu, nu]], coords[[rho]]]
            ), {rho, 1, n}]
        ],
        {s, 1, n}, {mu, 1, n}, {nu, 1, n}
    ]
];

computeRiemann[gamma_, coords_] := Module[{n},
    n = Length[coords];
    Table[
        Simplify[
            D[gamma[[rho, nu, sigma]], coords[[mu]]]
            - D[gamma[[rho, mu, sigma]], coords[[nu]]]
            + Sum[
                gamma[[rho, mu, lam]] gamma[[lam, nu, sigma]]
                - gamma[[rho, nu, lam]] gamma[[lam, mu, sigma]],
                {lam, 1, n}
            ]
        ],
        {rho, 1, n}, {sigma, 1, n}, {mu, 1, n}, {nu, 1, n}
    ]
];

computeRicci[riemann_, n_] := Table[
    Simplify[Sum[riemann[[lam, mu, lam, nu]], {lam, 1, n}]],
    {mu, 1, n}, {nu, 1, n}
];

computeRicciScalar[metric_, ricci_] := Module[{inv},
    inv = Simplify[Inverse[metric]];
    Simplify[Sum[inv[[mu, nu]] ricci[[mu, nu]],
        {mu, Length[metric]}, {nu, Length[metric]}]]
];

(* =========================================================================
   Exercise 1.1: Christoffel Symbols of the 2-Sphere
   ========================================================================= *)

Print["--- Exercise 1.1: Christoffel Symbols of 2-Sphere ---\n"];

coords = {\[Theta], \[Phi]};
metric = {{Rsph^2, 0}, {0, Rsph^2 Sin[\[Theta]]^2}};

gamma = computeChristoffel[metric, coords];

Print["Metric: ds^2 = R^2 (dtheta^2 + sin^2(theta) dphi^2)\n"];
Print["By formula: Gamma^sigma_{mu nu} = (1/2) g^{sigma rho}(",
    "d_mu g_{nu rho} + d_nu g_{rho mu} - d_rho g_{mu nu})\n"];

Print["Nonvanishing components:"];
Print["  Gamma^theta_{phi phi} = ", gamma[[1, 2, 2]],
    "  (= -sin(theta)cos(theta))"];
Print["  Gamma^phi_{theta phi} = ", gamma[[2, 1, 2]],
    "  (= cot(theta))"];
Print["  All others vanish (verified symbolically).\n"];


(* =========================================================================
   Exercise 1.2: Polar Coordinates
   ========================================================================= *)

Print["--- Exercise 1.2: Flat Plane in Polar Coordinates ---\n"];

coordsP = {r, \[Phi]};
metricP = {{1, 0}, {0, r^2}};
gammaP = computeChristoffel[metricP, coordsP];

Print["(a) Christoffel symbols for ds^2 = dr^2 + r^2 dphi^2:"];
Print["  Gamma^r_{phi phi} = ", gammaP[[1, 2, 2]]];
Print["  Gamma^phi_{r phi} = ", gammaP[[2, 1, 2]]];
Print[""];

Print["(b) Riemann tensor:"];
riemannP = computeRiemann[gammaP, coordsP];
allZero = And @@ Flatten[Table[
    riemannP[[a, b, c, d]] === 0,
    {a, 2}, {b, 2}, {c, 2}, {d, 2}
]];
Print["  All components vanish? ", allZero];
Print["  -> The space is FLAT, as expected.\n"];

Print["(c) Geodesic equations in polar coordinates:"];
Print["  r'' - r (phi')^2 = 0"];
Print["  phi'' + (2/r) r' phi' = 0\n"];
Print["  For a straight line: x = a + b*lambda, y = c + d*lambda"];
Print["  Converting: r(lambda) = sqrt((a+b*lambda)^2 + (c+d*lambda)^2)"];
Print["              phi(lambda) = arctan((c+d*lambda)/(a+b*lambda))"];
Print["  Substituting and simplifying (tedious!) confirms the equations"];
Print["  are satisfied. (Best verified numerically — see notebook.)\n"];


(* =========================================================================
   Exercise 1.3: Curvature Tensors of the 2-Sphere
   ========================================================================= *)

Print["--- Exercise 1.3: Curvature of the 2-Sphere ---\n"];

riemann = computeRiemann[gamma, coords];

Print["(a) Riemann tensor R^theta_{phi theta phi}:"];
Print["  R^theta_{phi theta phi} = ", riemann[[1, 2, 1, 2]]];
Print["  = sin^2(theta)\n"];

ricciT = computeRicci[riemann, 2];
Print["(b) Ricci tensor:"];
Print["  R_{theta theta} = ", ricciT[[1, 1]]];
Print["  R_{theta phi}   = ", ricciT[[1, 2]]];
Print["  R_{phi phi}     = ", ricciT[[2, 2]]];
Print[""];

ricciS = computeRicciScalar[metric, ricciT];
Print["(c) Ricci scalar:"];
Print["  R = g^{mu nu} R_{mu nu} = ", ricciS];
Print["  = 2/R^2 (constant positive curvature)"];
Print["  Verified: ", Simplify[ricciS == 2/Rsph^2]];
Print[""];


(* =========================================================================
   Exercise 1.4: Parallel Transport on the Sphere
   ========================================================================= *)

Print["--- Exercise 1.4: Parallel Transport ---\n"];

Print["A vector initially pointing east (V^theta = 0, V^phi = 1)"];
Print["at the equator (theta = pi/2, phi = 0) is parallel-transported:"];
Print["  1. North along phi = 0 to the pole"];
Print["  2. South along phi = alpha back to the equator\n"];

Print["Along path 1 (phi = 0, theta decreases from pi/2 to 0):"];
Print["  The parallel transport equations become:"];
Print["  dV^theta/dtheta = 0  (since dphi/dlambda = 0)"];
Print["  dV^phi/dtheta + cot(theta) V^phi * (dtheta/dlambda)^(-1) * 0 = 0"];
Print["  Actually, parameterize by theta going from pi/2 to 0."];
Print["  With dphi/dlambda = 0, the transport eqs give dV/dlambda = 0"];
Print["  along a meridian. The vector components stay constant!\n"];

Print["At the pole, the vector still has V^phi = 1 in the phi=0 chart."];
Print["Now we descend along phi = alpha. By the same argument,"];
Print["V components are constant along this meridian too.\n"];

Print["However, the coordinate basis at the equator has rotated by"];
Print["alpha between phi=0 and phi=alpha. The physical vector has"];
Print["rotated by angle alpha relative to its starting orientation.\n"];

Print["Alternatively: the enclosed solid angle of the triangle"];
Print["(equator to pole along phi=0, pole to equator along phi=alpha,"];
Print["equator from phi=alpha back to phi=0) is alpha."];
Print["On a unit sphere, the rotation angle = enclosed solid angle = alpha."];
Print["This is a direct manifestation of curvature.\n"];


(* =========================================================================
   Exercise 1.5: Great Circles as Geodesics
   ========================================================================= *)

Print["--- Exercise 1.5: Equator is a Geodesic ---\n"];

Print["Path: theta(lambda) = pi/2, phi(lambda) = lambda"];
Print["Tangent: (dtheta/dl, dphi/dl) = (0, 1)"];
Print["Second derivatives: (d^2 theta/dl^2, d^2 phi/dl^2) = (0, 0)\n"];

Print["Geodesic eq (theta):"];
Print["  0 + Gamma^theta_{phi phi} * 1 * 1"];
gamTpp = gamma[[1, 2, 2]] /. \[Theta] -> Pi/2;
Print["  = ", gamma[[1, 2, 2]], " evaluated at theta = pi/2"];
Print["  = ", gamTpp, "  -> SATISFIED\n"];

Print["Geodesic eq (phi):"];
Print["  0 + 2 * Gamma^phi_{theta phi} * 0 * 1 = 0  -> SATISFIED\n"];

Print["Therefore the equator is a geodesic."];
Print["By the symmetry of the sphere, ANY great circle is a geodesic.\n"];

Print["=== End of Module 1b Solutions ==="];

(* ===== Annotated-edition checks (2026-10) ===== *)
(* Checks every identity and number written in the derivation / annotation /
   bridge boxes of Notes/01b_Differential_Geometry/01b_Solutions.tex
   (Annotated Study Edition only).  Self-contained helpers, chapter conventions
   eq:christoffel and eq:riemann (Carroll eqs. 3.27, 3.4). *)
Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                  "Mathematica", "harness.wl"}]];
Print["\n--- Annotated-edition checks (Module 1b) ---"];

annChr[g_, x_] := Module[{gi = Simplify[Inverse[g]], n = Length[x]},
  Table[Simplify[1/2 Sum[gi[[s, l]] (D[g[[n2, l]], x[[m]]] + D[g[[l, m]], x[[n2]]]
        - D[g[[m, n2]], x[[l]]]), {l, n}]], {s, n}, {m, n}, {n2, n}]];
annRiem[G_, x_] := Module[{n = Length[x]},
  Table[Simplify[D[G[[r, nn, s]], x[[m]]] - D[G[[r, m, s]], x[[nn]]]
     + Sum[G[[r, m, l]] G[[l, nn, s]] - G[[r, nn, l]] G[[l, m, s]], {l, n}]],
   {r, n}, {s, n}, {m, n}, {nn, n}]];

(* Ex 1.1 / 1.3 / 1.4 / 1.5: the 2-sphere of radius R; index 1 = theta, 2 = phi *)
Module[{th, ph, R, x, g, G, Riem, Ric, cond, V, lam, sol},
  cond = R > 0 && 0 < th < Pi;
  x = {th, ph}; g = DiagonalMatrix[{R^2, R^2 Sin[th]^2}];
  G = annChr[g, x];
  check["1b ann: only nonzero metric derivative d_th g_phph = 2 R^2 sin cos",
    D[g, ph] == {{0, 0}, {0, 0}} && Simplify[D[g, th] == {{0, 0}, {0, 2 R^2 Sin[th] Cos[th]}}]];
  check["1b ann: Gamma^th_thth = Gamma^th_thph = 0",
    G[[1, 1, 1]] === 0 && G[[1, 1, 2]] === 0];
  check["1b ann: Gamma^th_phph = -(1/2) g^thth d_th g_phph = -sin cos",
    Simplify[G[[1, 2, 2]] == -1/2 (1/R^2) D[R^2 Sin[th]^2, th] == -Sin[th] Cos[th]]];
  check["1b ann: Gamma^ph_thth = Gamma^ph_phph = 0",
    G[[2, 1, 1]] === 0 && G[[2, 2, 2]] === 0];
  check["1b ann: Gamma^ph_thph = Gamma^ph_phth = d_th g_phph/(2 g_phph) = cot",
    Simplify[G[[2, 1, 2]] == G[[2, 2, 1]] == D[g[[2, 2]], th]/(2 g[[2, 2]]) == Cot[th]]];
  check["1b ann: Christoffels independent of R (constant rescaling of g)",
    FreeQ[G, R]];
  Riem = annRiem[G, x];
  check["1b ann: R^th_phthph = d_th G^th_phph - G^th_phph G^ph_thph = sin^2",
    Simplify[Riem[[1, 2, 1, 2]] ==
      D[G[[1, 2, 2]], th] - G[[1, 2, 2]] G[[2, 1, 2]] == Sin[th]^2]];
  check["1b ann: -(cos^2 - sin^2) + cos^2 = sin^2",
    Simplify[-(Cos[th]^2 - Sin[th]^2) + Cos[th]^2 == Sin[th]^2]];
  check["1b ann: G^th_phph G^ph_thph = -cos^2", Simplify[G[[1, 2, 2]] G[[2, 1, 2]] == -Cos[th]^2]];
  check["1b ann: R^ph_thphth = -d_th cot - cot^2 = csc^2 - cot^2 = 1",
    Simplify[Riem[[2, 1, 2, 1]] == -D[Cot[th], th] - Cot[th]^2 == 1]];
  check["1b ann: R^th_ththth = 0 (antisymmetry in last pair)", Riem[[1, 1, 1, 1]] === 0];
  Ric = Table[Sum[Riem[[l, m, l, n]], {l, 2}], {m, 2}, {n, 2}];
  check["1b ann: R_thth = 1, R_phph = sin^2, off-diagonal 0, all R-independent",
    Simplify[Ric == {{1, 0}, {0, Sin[th]^2}}]];
  check["1b ann: Ricci scalar 2/R^2, Gaussian curvature R/2 = 1/R^2",
    Simplify[Sum[Inverse[g][[a, b]] Ric[[a, b]], {a, 2}, {b, 2}] == 2/R^2]];
  (* Ex 1.4: parallel transport along a meridian, parametrised by theta *)
  check["1b ann: along meridian, dV^th/dth = 0 (no Gamma^th_th. terms)",
    G[[1, 1, 1]] === 0 && G[[1, 1, 2]] === 0];
  sol = DSolve[V'[lam] + Cot[lam] V[lam] == 0, V[lam], lam];
  check["1b ann: dV^ph/dth + cot(th) V^ph = 0  =>  V^ph = C/sin(th)",
    Simplify[(V[lam] /. sol[[1]]) Sin[lam]] === C[1]];
  check["1b ann: orthonormal component R sin(th) V^ph is constant",
    Simplify[D[R Sin[lam] (C[1]/Sin[lam]), lam] == 0]];
  check["1b ann: area of the lune-triangle (unit sphere, equator to pole, width alpha) = alpha",
    Integrate[Sin[t2], {p2, 0, alpha}, {t2, 0, Pi/2}] == alpha];
  (* Ex 1.5 *)
  check["1b ann: contracting 1st & 4th indices gives -R_{mu nu}",
    Simplify[Table[Sum[Riem[[l, m, n, l]], {l, 2}], {m, 2}, {n, 2}] == -Ric]];
  check["1b ann: phi-equation coefficient Gamma^ph_thph + Gamma^ph_phth = 2 cot",
    Simplify[G[[2, 1, 2]] + G[[2, 2, 1]] == 2 Cot[th]]];
];

(* Ex 1.5: a tilted great circle needs the factor 2 *)
Module[{s, i0 = Pi/5, P, th, ph, eqTh, eqPh2, eqPh1, s0 = 7/10},
  P = {Cos[s], Sin[s] Cos[i0], Sin[s] Sin[i0]};
  th = ArcCos[P[[3]]]; ph = ArcTan[P[[1]], P[[2]]];
  eqTh = D[th, {s, 2}] - Sin[th] Cos[th] D[ph, s]^2;
  eqPh2 = D[ph, {s, 2}] + 2 Cot[th] D[th, s] D[ph, s];
  eqPh1 = D[ph, {s, 2}] + Cot[th] D[th, s] D[ph, s];
  check["1b ann: tilted great circle (i = pi/5) solves both geodesic eqs with the factor 2",
    Abs[N[eqTh /. s -> s0, 30]] < 10^-20 && Abs[N[eqPh2 /. s -> s0, 30]] < 10^-20];
  check["1b ann: ... and fails the phi-equation if the factor 2 is dropped",
    Abs[N[eqPh1 /. s -> s0]] > 10^-3];
];

(* Ex 1.2: plane in polar coordinates; index 1 = r, 2 = phi *)
Module[{r, ph, x, g, G, Riem, a, b, c, d, lam, X, Y, rr, pp, geoR, geoP},
  x = {r, ph}; g = DiagonalMatrix[{1, r^2}];
  G = annChr[g, x];
  check["1b ann: polar Gamma^r_phph = -(1/2) d_r r^2 = -r", G[[1, 2, 2]] === -r];
  check["1b ann: polar Gamma^ph_rph = (1/(2 r^2)) 2 r = 1/r", Simplify[G[[2, 1, 2]] == 1/r]];
  Riem = annRiem[G, x];
  check["1b ann: R^r_phrph = -1 - 0 + 0 - (-r)(1/r) = 0",
    Simplify[Riem[[1, 2, 1, 2]] == D[-r, r] - (-r)(1/r) == 0]];
  check["1b ann: all polar Riemann components vanish", Simplify[Flatten[Riem]] === Table[0, {16}]];
  check["1b ann: in n = 2, n^2 (n^2 - 1)/12 = 1 independent Riemann component",
    (2^2 (2^2 - 1))/12 == 1];
  (* geodesic equations from x''^mu + Gamma^mu_ab x'^a x'^b *)
  check["1b ann: geodesic r-eq = r'' - r phi'^2, phi-eq = phi'' + (2/r) r' phi'",
    Simplify[G[[1, 2, 2]] == -r && G[[2, 1, 2]] + G[[2, 2, 1]] == 2/r]];
  X = a + b lam; Y = c + d lam;
  rr = Sqrt[X^2 + Y^2]; pp = ArcTan[X, Y];
  check["1b ann: r^2 phi' = x y' - y x' = a d - b c (constant)",
    Simplify[rr^2 D[pp, lam] == X D[Y, lam] - Y D[X, lam] == a d - b c]];
  check["1b ann: x'^2 + y'^2 = r'^2 + r^2 phi'^2",
    Simplify[D[rr, lam]^2 + rr^2 D[pp, lam]^2 == b^2 + d^2]];
  check["1b ann: straight line satisfies r'' - r phi'^2 = 0",
    Simplify[D[rr, {lam, 2}] - rr D[pp, lam]^2 == 0]];
  check["1b ann: straight line satisfies phi'' + (2/r) r' phi' = 0",
    Simplify[D[pp, {lam, 2}] + 2/rr D[rr, lam] D[pp, lam] == 0]];
  check["1b ann: d/dlam (r^2 phi') = r (r phi'' + 2 r' phi')",
    Simplify[D[rr^2 D[pp, lam], lam] == rr (rr D[pp, {lam, 2}] + 2 D[rr, lam] D[pp, lam])]];
];

(* ===== Fix pass 2026-10-14 (FACT_CRITIC_01b_annotated_2026-10-14.md, X1 + N10) ===== *)
(* X1: visible Ex 1.4 text.  The old text claimed dV^mu/dlambda = 0 along a meridian
   (all coordinate components constant).  The checks below fail on that claim. *)
Module[{t, C0},
  check["1b fix X1: on a meridian Gamma^ph_thph (dth/dlam) V^ph = cot(th) V^ph != 0 (old claim dropped it)",
    Simplify[Cot[t] C0/Sin[t]] =!= 0 && N[Cot[1.0]] != 0];
  check["1b fix X1: coordinate V^ph = C/sin(th) is NOT constant (dV^ph/dth != 0)",
    Simplify[D[C0/Sin[t], t]] =!= 0];
  check["1b fix X1: equator leg: Gamma^th_phph = -sin cos and Gamma^ph_phth = cot vanish at th = pi/2",
    (-Sin[t] Cos[t] /. t -> Pi/2) == 0 && (Cot[t] /. t -> Pi/2) == 0];
];
(* Independent route: parallel transport in the R^3 embedding of the unit sphere,
   dV/ds = -(V . dn/ds) n, which uses no Christoffel symbols. *)
Module[{nn, eth, eph, tr, V0, V1, V2, al = 9/10, t, ph = 3/10, Vf, comp},
  nn[t_, p_] := {Sin[t] Cos[p], Sin[t] Sin[p], Cos[t]};
  eth[t_, p_] := {Cos[t] Cos[p], Cos[t] Sin[p], -Sin[t]};        (* d_theta *)
  eph[t_, p_] := {-Sin[t] Sin[p], Sin[t] Cos[p], 0};              (* d_phi   *)
  (* transport along the meridian phi = p from theta = t0 to theta = t1 *)
  tr[V_, p_, t0_, t1_] := Module[{s},
    Module[{w1, w2, w3, sol},
      sol = NDSolve[{Thread[D[{w1[s], w2[s], w3[s]}, s] ==
          -({w1[s], w2[s], w3[s]} . D[nn[s, p], s]) nn[s, p]],
          w1[t0] == V[[1]], w2[t0] == V[[2]], w3[t0] == V[[3]]},
          {w1, w2, w3}, {s, Min[t0, t1], Max[t0, t1]},
          PrecisionGoal -> 10, AccuracyGoal -> 12];
      {w1[t1], w2[t1], w3[t1]} /. sol[[1]]]];
  V0 = 0.2 eth[Pi/2, ph] + 0.7 eph[Pi/2, ph];
  V1 = tr[V0, ph, N[Pi/2], 0.1];
  comp = LeastSquares[Transpose[{eth[0.1, ph], eph[0.1, ph]}], V1];
  check["1b fix X1 (embedding): V^th stays 0.2 and sin(th) V^ph stays 0.7 at th = 0.1",
    Abs[comp[[1]] - 0.2] < 10^-6 && Abs[Sin[0.1] comp[[2]] - 0.7] < 10^-6];
  check["1b fix X1 (embedding): coordinate V^ph changes (0.7 -> ~7.0), so 'components constant' fails",
    Abs[comp[[2]] - 0.7] > 1 && Abs[comp[[2]] - 0.7/Sin[0.1]] < 10^-5];
  (* holonomy: east vector up phi = 0 to the pole, down phi = alpha to the equator *)
  V1 = tr[eph[Pi/2, 0], 0, N[Pi/2], 0.];
  V2 = tr[V1, N[al], 0., N[Pi/2]];
  check["1b fix X1 (embedding): returning vector makes angle alpha (= enclosed area) with local east",
    Abs[ArcCos[V2 . eph[Pi/2, N[al]]] - al] < 10^-6 && Abs[Norm[V2] - 1] < 10^-8];
];
(* N10: the dropped factor 2 is harmless on the equator AND on the meridians *)
Module[{s, th, ph, eqPh1, eqPh2, bad},
  th = s; ph = 3/10;   (* a meridian: phi const, theta = s (unit speed) *)
  eqPh1 = D[ph, {s, 2}] + Cot[th] D[th, s] D[ph, s];
  eqPh2 = D[ph, {s, 2}] + 2 Cot[th] D[th, s] D[ph, s];
  check["1b fix N10: a meridian satisfies the phi-equation with OR without the factor 2 (old 'any tilted' fails)",
    eqPh1 === 0 && eqPh2 === 0 && (D[th, {s, 2}] - Sin[th] Cos[th] D[ph, s]^2) === 0];
  bad = Table[Module[{P, t2, p2},
      P = {Cos[s], Sin[s] Cos[i0], Sin[s] Sin[i0]};
      t2 = ArcCos[P[[3]]]; p2 = ArcTan[P[[1]], P[[2]]];
      Abs[N[(D[p2, {s, 2}] + Cot[t2] D[t2, s] D[p2, s]) /. s -> 7/10]]], {i0, {3/10, 1, 7/5}}];
  check["1b fix N10: other great circles (i = 0.3, 1.0, 1.4) fail without the factor 2",
    Min[bad] > 10^-3];
];

summary[];
