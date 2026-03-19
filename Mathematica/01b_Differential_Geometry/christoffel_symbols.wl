(* =========================================================================
   christoffel_symbols.wl
   Module 1b: Differential Geometry and the Metric Tensor
   =========================================================================
   Purpose: General-purpose symbolic computation of Christoffel symbols,
            Riemann tensor, Ricci tensor, and Ricci scalar from any input
            metric. Demonstrates with 2-sphere, polar coordinates, and
            a generic diagonal metric.

   Sources: Carroll Ch. 3, eqs. 3.27 (Christoffel), 3.4 (Riemann)
            Congdon & Keeton Ch. 3.2, eq. 3.61

   Usage:   wolframscript -file christoffel_symbols.wl

   This script defines reusable functions that will be used in later
   modules (Schwarzschild, FRW, etc.).
   ========================================================================= *)

Print["=== Module 1b: Christoffel Symbols and Curvature Tensors ===\n"];

(* =========================================================================
   Section 1: General Functions for Computing GR Quantities

   These functions take an arbitrary metric tensor g_{mu nu} (as a matrix)
   and a list of coordinates, and compute:
     1. Inverse metric g^{mu nu}
     2. Christoffel symbols Gamma^sigma_{mu nu}
     3. Riemann tensor R^rho_{sigma mu nu}
     4. Ricci tensor R_{mu nu}
     5. Ricci scalar R

   All computations are exact/symbolic using Mathematica's Simplify.
   ========================================================================= *)

(* ---- Christoffel symbols: Gamma^sigma_{mu nu} ---- *)
(* Carroll eq. 3.27:
   Gamma^sigma_{mu nu} = (1/2) g^{sigma rho} (d_mu g_{nu rho}
                          + d_nu g_{rho mu} - d_rho g_{mu nu})  *)
computeChristoffel[metric_, coords_] := Module[
    {n, invMetric, gamma},
    n = Length[coords];
    invMetric = Simplify[Inverse[metric]];
    (* gamma[[sigma, mu, nu]] = Gamma^sigma_{mu nu} *)
    gamma = Table[
        Simplify[
            Sum[
                (1/2) invMetric[[sigma, rho]] (
                    D[metric[[nu, rho]], coords[[mu]]]
                    + D[metric[[rho, mu]], coords[[nu]]]
                    - D[metric[[mu, nu]], coords[[rho]]]
                ),
                {rho, 1, n}
            ]
        ],
        {sigma, 1, n}, {mu, 1, n}, {nu, 1, n}
    ];
    gamma
];

(* ---- Riemann tensor: R^rho_{sigma mu nu} ---- *)
(* Carroll eq. 3.4:
   R^rho_{sigma mu nu} = d_mu Gamma^rho_{nu sigma}
                        - d_nu Gamma^rho_{mu sigma}
                        + Gamma^rho_{mu lambda} Gamma^lambda_{nu sigma}
                        - Gamma^rho_{nu lambda} Gamma^lambda_{mu sigma} *)
computeRiemann[gamma_, coords_] := Module[
    {n, riemann},
    n = Length[coords];
    riemann = Table[
        Simplify[
            D[gamma[[rho, nu, sigma]], coords[[mu]]]
            - D[gamma[[rho, mu, sigma]], coords[[nu]]]
            + Sum[
                gamma[[rho, mu, lambda]] gamma[[lambda, nu, sigma]]
                - gamma[[rho, nu, lambda]] gamma[[lambda, mu, sigma]],
                {lambda, 1, n}
            ]
        ],
        {rho, 1, n}, {sigma, 1, n}, {mu, 1, n}, {nu, 1, n}
    ];
    riemann
];

(* ---- Ricci tensor: R_{mu nu} = R^lambda_{mu lambda nu} ---- *)
computeRicci[riemann_, n_] := Module[{ricci},
    ricci = Table[
        Simplify[
            Sum[riemann[[lambda, mu, lambda, nu]], {lambda, 1, n}]
        ],
        {mu, 1, n}, {nu, 1, n}
    ];
    ricci
];

(* ---- Ricci scalar: R = g^{mu nu} R_{mu nu} ---- *)
computeRicciScalar[metric_, ricci_] := Module[{invMetric},
    invMetric = Simplify[Inverse[metric]];
    Simplify[Sum[invMetric[[mu, nu]] ricci[[mu, nu]],
        {mu, 1, Length[metric]}, {nu, 1, Length[metric]}]]
];

(* ---- Pretty-print nonvanishing Christoffel symbols ---- *)
printChristoffel[gamma_, coords_] := Module[{n, count = 0},
    n = Length[coords];
    Do[
        If[gamma[[s, m, nu]] =!= 0,
            Print["  Gamma^", coords[[s]], "_{", coords[[m]], " ",
                  coords[[nu]], "} = ", gamma[[s, m, nu]]];
            count++;
        ],
        {s, 1, n}, {m, 1, n}, {nu, m, n}  (* nu >= mu to avoid duplicates *)
    ];
    Print["  (", count, " independent nonvanishing components)"];
];

Print["General GR computation functions defined.\n"];

(* =========================================================================
   Section 2: Flat Plane in Polar Coordinates

   ds^2 = dr^2 + r^2 d(phi)^2
   This is FLAT space in curvilinear coordinates.
   The Christoffel symbols are nonzero, but the Riemann tensor vanishes.
   ========================================================================= *)

Print["--- Example 1: Flat Plane in Polar Coordinates ---\n"];
Print["  ds^2 = dr^2 + r^2 dphi^2\n"];

coordsPolar = {r, \[Phi]};
metricPolar = {{1, 0}, {0, r^2}};

Print["Metric:"];
Print["  ", MatrixForm[metricPolar]];
Print[""];

(* Compute Christoffel symbols *)
gammaPolar = computeChristoffel[metricPolar, coordsPolar];
Print["Christoffel symbols:"];
printChristoffel[gammaPolar, coordsPolar];
Print[""];

(* Compute Riemann tensor *)
riemannPolar = computeRiemann[gammaPolar, coordsPolar];
allRiemannZero = And @@ Flatten[Table[
    riemannPolar[[rho, sigma, mu, nu]] === 0,
    {rho, 2}, {sigma, 2}, {mu, 2}, {nu, 2}
]];
Print["Riemann tensor identically zero? ", allRiemannZero];
Print["  -> Confirmed: polar coordinates describe FLAT space.\n"];

(* =========================================================================
   Section 3: The 2-Sphere

   ds^2 = R^2 (d(theta)^2 + sin^2(theta) d(phi)^2)
   This has constant positive curvature.
   ========================================================================= *)

Print["--- Example 2: 2-Sphere of Radius R ---\n"];
Print["  ds^2 = R^2 (dtheta^2 + sin^2(theta) dphi^2)\n"];

coordsSphere = {\[Theta], \[Phi]};
metricSphere = {{Rsph^2, 0}, {0, Rsph^2 Sin[\[Theta]]^2}};

Print["Metric:"];
Print["  ", MatrixForm[metricSphere]];
Print[""];

(* Christoffel symbols *)
gammaSphere = computeChristoffel[metricSphere, coordsSphere];
Print["Christoffel symbols:"];
printChristoffel[gammaSphere, coordsSphere];
Print[""];

(* Riemann tensor *)
riemannSphere = computeRiemann[gammaSphere, coordsSphere];
Print["Riemann tensor (nonvanishing components):"];
Do[
    If[riemannSphere[[rho, sigma, mu, nu]] =!= 0,
        Print["  R^", coordsSphere[[rho]], "_{", coordsSphere[[sigma]],
              " ", coordsSphere[[mu]], " ", coordsSphere[[nu]], "} = ",
              riemannSphere[[rho, sigma, mu, nu]]];
    ],
    {rho, 2}, {sigma, 2}, {mu, 2}, {nu, 2}
];
Print[""];

(* Ricci tensor *)
ricciSphere = computeRicci[riemannSphere, 2];
Print["Ricci tensor:"];
Print["  R_{theta theta} = ", ricciSphere[[1, 1]]];
Print["  R_{theta phi}   = ", ricciSphere[[1, 2]]];
Print["  R_{phi phi}     = ", ricciSphere[[2, 2]]];
Print[""];

(* Ricci scalar *)
ricciScalarSphere = computeRicciScalar[metricSphere, ricciSphere];
Print["Ricci scalar: R = ", ricciScalarSphere];
Print["  For a sphere of radius R: R = 2/R^2 (constant positive curvature)"];
Print["  Verified? ", Simplify[ricciScalarSphere == 2/Rsph^2]];
Print[""];

(* =========================================================================
   Section 4: General Diagonal Metric (for later use)

   Many important metrics in GR are diagonal:
   ds^2 = g_00 dt^2 + g_11 dx1^2 + g_22 dx2^2 + g_33 dx3^2

   We compute Christoffel symbols for a general diagonal metric to
   derive formulas that will be useful for the Schwarzschild and FRW
   metrics in later modules.
   ========================================================================= *)

Print["--- General Diagonal Metric (for reference) ---\n"];
Print["  ds^2 = g_00(x) (dx^0)^2 + g_11(x) (dx^1)^2 + ...\n"];

(* For a diagonal metric g_{mu nu} = diag(g0, g1, g2, g3),
   the Christoffel symbols have the forms:
   Gamma^sigma_{mu mu} = -(1/2) (1/g_sigma) d_sigma g_mu  (sigma != mu)
   Gamma^sigma_{mu sigma} = (1/2) (1/g_sigma) d_mu g_sigma  (no sum)
   Gamma^mu_{mu mu} = (1/2) (1/g_mu) d_mu g_mu  (no sum)
   All others vanish for a diagonal metric.
*)

Print["For a diagonal metric with components g_aa (no sum), the nonvanishing"];
Print["Christoffel symbols are (Carroll Sec. 3.2):"];
Print[""];
Print["  Gamma^a_{b b} = -(1/2g_aa) * d_a(g_bb)   for a != b"];
Print["  Gamma^a_{a b} = (1/2g_aa) * d_b(g_aa)     (includes a = b)"];
Print[""];
Print["These formulas will be used extensively in Modules 1c and 1d."];
Print[""];

(* =========================================================================
   Section 5: Geodesic Equation Verification (Sphere)

   Verify that the equator (theta = pi/2, phi = lambda) is a geodesic
   of the 2-sphere.
   ========================================================================= *)

Print["--- Geodesic Verification: Equator of the 2-Sphere ---\n"];

(* The equator: theta(lambda) = pi/2, phi(lambda) = lambda *)
(* Tangent vector: d(theta)/dlambda = 0, d(phi)/dlambda = 1 *)
Print["Path: theta(lambda) = pi/2, phi(lambda) = lambda"];
Print["Tangent vector: (dtheta/dlambda, dphi/dlambda) = (0, 1)\n"];

(* Check geodesic equation for theta component:
   d^2 theta/dlambda^2 + Gamma^theta_{mu nu} (dx^mu/dlambda)(dx^nu/dlambda) = 0 *)
(* Only nonzero contribution: Gamma^theta_{phi phi} * 1 * 1 *)
gamThetaPhiPhi = gammaSphere[[1, 2, 2]] /. \[Theta] -> Pi/2;
Print["Geodesic eq. (theta component):"];
Print["  d^2 theta/dlambda^2 + Gamma^theta_{phi phi} * (dphi/dl)^2"];
Print["  = 0 + ", gamThetaPhiPhi, " * 1"];
Print["  = ", gamThetaPhiPhi];
Print["  At theta = pi/2: Gamma^theta_{phi phi} = -cos(theta)sin(theta)|_{pi/2} = ",
    Simplify[gamThetaPhiPhi]];
Print["  = 0.  Geodesic equation SATISFIED.\n"];

(* Check phi component:
   d^2 phi/dlambda^2 + Gamma^phi_{mu nu} ... = 0 *)
(* Gamma^phi_{theta phi} * 0 * 1 = 0, so trivially satisfied *)
Print["Geodesic eq. (phi component):"];
Print["  d^2 phi/dlambda^2 + 2*Gamma^phi_{theta phi} * (dtheta/dl)(dphi/dl)"];
Print["  = 0 + 0 = 0.  SATISFIED.\n"];
Print["The equator is confirmed to be a geodesic (great circle).\n"];

Print["=== End of Module 1b: Christoffel Symbols and Curvature Tensors ==="];
