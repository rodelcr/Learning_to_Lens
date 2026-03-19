(* =========================================================================
   problems_01c.wl
   Module 1c: The Schwarzschild Spacetime — SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 1c, verified
            symbolically and numerically with Mathematica.

   Sources: Carroll Ch. 5, Congdon & Keeton Ch. 3.3

   Usage:   wolframscript -file problems_01c.wl

   Exercises solved:
     1.1 — Verify R_{mu nu} = 0 for Schwarzschild metric
     1.2 — Kretschner scalar K = 12 Rs^2/r^6
     1.3 — Schwarzschild radii for Earth, Sun, galaxy lens
     1.4 — Gravitational redshift from a neutron star surface
     1.5 — Flamm's paraboloid embedding derivation

   Physical constants (SI):
     G     = 6.674e-11 m^3/(kg s^2)
     c     = 2.998e8 m/s
     Msun  = 1.989e30 kg
   ========================================================================= *)

Print["=== Module 1c: SOLUTIONS ===\n"];

(* ---- Physical constants ---- *)

Gconst = 6.674*10^(-11);    (* m^3 / (kg s^2) *)
clight = 2.998*10^8;        (* m/s *)
Msun   = 1.989*10^30;       (* kg *)

schwarzR[mass_] := 2 Gconst mass / clight^2;

(* ---- GR computation functions (same as problems_01b.wl) ---- *)

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
   Exercise 1.1: Verify R_{mu nu} = 0 for the Schwarzschild Metric
   =========================================================================
   The Schwarzschild metric in coordinates (t, r, theta, phi) is:
       ds^2 = -(1 - Rs/r) c^2 dt^2 + dr^2/(1 - Rs/r)
              + r^2 dtheta^2 + r^2 sin^2(theta) dphi^2
   where Rs = 2GM/c^2. We work in geometric units (c = G = 1) so
   Rs = 2M. The metric is a vacuum solution: R_{mu nu} = 0.
   ========================================================================= *)

Print["--- Exercise 1.1: Verify R_{mu nu} = 0 for Schwarzschild ---\n"];

(* Define Schwarzschild coordinates and metric *)
(* We use symbolic Rs for the Schwarzschild radius *)
coordsSch = {t, r, \[Theta], \[Phi]};

metricSch = {
    {-(1 - Rs/r),  0,             0,                        0},
    {0,            1/(1 - Rs/r),  0,                        0},
    {0,            0,             r^2,                      0},
    {0,            0,             0,     r^2 Sin[\[Theta]]^2}
};

Print["Schwarzschild metric (geometric units c = G = 1):"];
Print["  g_{tt}         = -(1 - Rs/r)"];
Print["  g_{rr}         = 1/(1 - Rs/r)"];
Print["  g_{theta theta} = r^2"];
Print["  g_{phi phi}     = r^2 sin^2(theta)\n"];

(* Step 1: Compute Christoffel symbols *)
Print["Computing Christoffel symbols..."];
gammaSch = computeChristoffel[metricSch, coordsSch];

(* Display nonvanishing Christoffel symbols *)
Print["Nonvanishing Christoffel symbols:"];
Do[
    If[gammaSch[[s, m, n]] =!= 0,
        Print["  Gamma^", coordsSch[[s]], "_{", coordsSch[[m]], " ",
              coordsSch[[n]], "} = ", gammaSch[[s, m, n]]]
    ],
    {s, 4}, {m, 4}, {n, m, 4}
];
Print[""];

(* Step 2: Compute Riemann tensor *)
Print["Computing Riemann tensor (this may take a moment)..."];
riemannSch = computeRiemann[gammaSch, coordsSch];

(* Step 3: Contract to Ricci tensor *)
Print["Computing Ricci tensor R_{mu nu}..."];
ricciSch = computeRicci[riemannSch, 4];

Print["Ricci tensor components:"];
Do[
    Print["  R_{", coordsSch[[m]], " ", coordsSch[[n]], "} = ",
          ricciSch[[m, n]]],
    {m, 4}, {n, m, 4}
];

(* Verify all components are zero *)
allRicciZero = And @@ Flatten[Table[
    ricciSch[[m, n]] === 0,
    {m, 4}, {n, 4}
]];
Print["\nAll R_{mu nu} = 0? ", allRicciZero];
Print["-> Schwarzschild is a vacuum solution: VERIFIED\n"];


(* =========================================================================
   Exercise 1.2: Kretschner Scalar
   =========================================================================
   The Kretschner scalar is the full contraction of the Riemann tensor:
       K = R^{alpha beta gamma delta} R_{alpha beta gamma delta}
   For the Schwarzschild metric: K = 48 M^2 / r^6 = 12 Rs^2 / r^6.
   Key point: K is finite at r = Rs (coordinate singularity) but
   diverges at r = 0 (true curvature singularity).
   ========================================================================= *)

Print["--- Exercise 1.2: Kretschner Scalar ---\n"];

(* Lower the first index of Riemann to get R_{alpha beta gamma delta} *)
(* R_{alpha beta mu nu} = g_{alpha rho} R^rho_{beta mu nu} *)
invMetricSch = Simplify[Inverse[metricSch]];

riemannDown = Table[
    Simplify[
        Sum[metricSch[[alpha, rho]] riemannSch[[rho, beta, mu, nu]],
            {rho, 1, 4}]
    ],
    {alpha, 4}, {beta, 4}, {mu, 4}, {nu, 4}
];

(* Raise all indices of the second Riemann factor *)
(* R^{alpha beta mu nu} = g^{alpha a} g^{beta b} g^{mu m} g^{nu n} R_{a b m n} *)
riemannUp = Table[
    Simplify[
        Sum[invMetricSch[[alpha, a]] invMetricSch[[beta, b]] *
            invMetricSch[[mu, m]] invMetricSch[[nu, n]] *
            riemannDown[[a, b, m, n]],
            {a, 4}, {b, 4}, {m, 4}, {n, 4}]
    ],
    {alpha, 4}, {beta, 4}, {mu, 4}, {nu, 4}
];

(* Contract: K = R^{abcd} R_{abcd} *)
Print["Computing Kretschner scalar K = R^{abcd} R_{abcd}..."];
kretschner = Simplify[
    Sum[riemannUp[[a, b, c, d]] riemannDown[[a, b, c, d]],
        {a, 4}, {b, 4}, {c, 4}, {d, 4}]
];

Print["  K = ", kretschner];
Print[""];

(* Verify against the known result K = 12 Rs^2 / r^6 *)
kExpected = 12 Rs^2 / r^6;
kMatch = Simplify[kretschner - kExpected] === 0;
Print["Expected: K = 12 Rs^2 / r^6"];
Print["Match? ", kMatch];
Print[""];

(* Check behavior at r = Rs (should be finite) *)
kAtHorizon = kretschner /. r -> Rs;
Print["At the horizon (r = Rs):"];
Print["  K(r=Rs) = ", Simplify[kAtHorizon]];
Print["  = 12/Rs^4 (FINITE — the horizon is a coordinate singularity, not physical)\n"];

(* Check behavior at r -> 0 (should diverge) *)
kLimit0 = Limit[kretschner, r -> 0, Direction -> "FromAbove"];
Print["As r -> 0:"];
Print["  K -> ", kLimit0];
Print["  (DIVERGENT — r = 0 is a true curvature singularity)\n"];


(* =========================================================================
   Exercise 1.3: Schwarzschild Radii for Astrophysical Objects
   =========================================================================
   Compute Rs = 2GM/c^2 for:
   (a) Earth (M = 5.972e24 kg, R = 6371 km)
   (b) Sun   (M = 1.989e30 kg, R = 6.957e8 m)
   (c) Galaxy lens (M ~ 10^12 Msun, R ~ 50 kpc)
   Compare Rs to the physical radius in each case.
   ========================================================================= *)

Print["--- Exercise 1.3: Schwarzschild Radii ---\n"];

(* (a) Earth *)
Mearth = 5.972*10^24;       (* kg *)
Rearth = 6.371*10^6;        (* m *)
rsEarth = schwarzR[Mearth];

Print["(a) Earth:"];
Print["  M = ", ScientificForm[Mearth, 4], " kg"];
Print["  Rs = 2GM/c^2 = ", ScientificForm[rsEarth, 4], " m"];
Print["  Rs = ", NumberForm[rsEarth*1000, {4, 2}], " mm"];
Print["  Physical radius R = ", ScientificForm[Rearth, 4], " m"];
Print["  Rs/R = ", ScientificForm[rsEarth/Rearth, 3]];
Print["  -> Rs is about 9 mm: Earth is VERY far from being a black hole."];
Print["     GR corrections are tiny: ~Rs/R ~ 10^{-9}.\n"];

(* (b) Sun *)
Rsun = 6.957*10^8;          (* m *)
rsSun = schwarzR[Msun];

Print["(b) Sun:"];
Print["  M = ", ScientificForm[Msun, 4], " kg"];
Print["  Rs = 2GM/c^2 = ", ScientificForm[rsSun, 4], " m"];
Print["  Rs ~ ", NumberForm[rsSun, {5, 0}], " m (about 3 km)"];
Print["  Physical radius R = ", ScientificForm[Rsun, 4], " m"];
Print["  Rs/R = ", ScientificForm[rsSun/Rsun, 3]];
Print["  -> GR corrections at the surface are ~Rs/R ~ 4 x 10^{-6}."];
Print["     Still small, but measurable (e.g., gravitational redshift).\n"];

(* (c) Galaxy lens *)
Mgalaxy = 1.0*10^12 * Msun; (* kg *)
Rgalaxy = 50 * 3.086*10^19;  (* 50 kpc in meters *)
rsGalaxy = schwarzR[Mgalaxy];

Print["(c) Galaxy-scale lens (M ~ 10^12 Msun):"];
Print["  M = ", ScientificForm[Mgalaxy, 4], " kg"];
Print["  Rs = 2GM/c^2 = ", ScientificForm[rsGalaxy, 4], " m"];
Print["  Rs ~ ", ScientificForm[rsGalaxy/(3.086*10^16), 3], " pc"];
Print["  Physical extent R ~ 50 kpc = ", ScientificForm[Rgalaxy, 3], " m"];
Print["  Rs/R = ", ScientificForm[rsGalaxy/Rgalaxy, 3]];
Print["  -> Rs is about 0.1 pc, vastly smaller than the galaxy (~50 kpc)."];
Print["     The thin-lens approximation is excellent for galaxy lensing.\n"];


(* =========================================================================
   Exercise 1.4: Gravitational Redshift from a Neutron Star
   =========================================================================
   A neutron star with M = 1.4 Msun, R = 10 km.
   (a) Compute the gravitational redshift z from the surface.
   (b) Find the wavelength increase for a photon emitted at 500 nm.
   (c) Compare to the Sun's gravitational redshift.
   ========================================================================= *)

Print["--- Exercise 1.4: Gravitational Redshift from a Neutron Star ---\n"];

(* Neutron star parameters *)
Mns = 1.4 * Msun;          (* mass in kg *)
Rns = 1.0*10^4;            (* radius: 10 km = 10^4 m *)
rsNS = schwarzR[Mns];

Print["Neutron star: M = 1.4 Msun = ", ScientificForm[Mns, 4], " kg"];
Print["              R = 10 km = ", Rns, " m"];
Print["              Rs = ", ScientificForm[rsNS, 4], " m"];
Print["              Rs/R = ", NumberForm[rsNS/Rns, {4, 4}], "\n"];

(* (a) Gravitational redshift *)
(* z = 1/sqrt(1 - Rs/r) - 1, evaluated at r = R (surface) *)
zNS = 1/Sqrt[1 - rsNS/Rns] - 1;

Print["(a) Gravitational redshift from the surface:"];
Print["  z = 1/sqrt(1 - Rs/R) - 1"];
Print["  z = 1/sqrt(1 - ", NumberForm[rsNS/Rns, {4, 4}], ") - 1"];
Print["  z = ", NumberForm[zNS, {4, 4}]];
Print["  -> A very large redshift! Photons lose ~", NumberForm[zNS/(1+zNS)*100, {3, 1}],
      "% of their energy escaping.\n"];

(* (b) Wavelength increase for 500 nm photon *)
lambda0 = 500;  (* nm *)
lambdaObs = lambda0 * (1 + zNS);

Print["(b) Wavelength increase:"];
Print["  Emitted wavelength: lambda_em = ", lambda0, " nm"];
Print["  Observed: lambda_obs = lambda_em * (1 + z) = ",
      NumberForm[lambdaObs, {5, 1}], " nm"];
Print["  Wavelength increase: Delta lambda = ",
      NumberForm[lambdaObs - lambda0, {5, 1}], " nm"];
Print["  -> Blue/green light shifted to the near-infrared!\n"];

(* (c) Compare to the Sun *)
rsSunSurf = schwarzR[Msun];
zSun = 1/Sqrt[1 - rsSunSurf/Rsun] - 1;

Print["(c) Comparison to the Sun:"];
Print["  Sun: Rs = ", ScientificForm[rsSunSurf, 4], " m"];
Print["  Sun: z = ", ScientificForm[zSun, 4]];
Print["  Neutron star: z = ", NumberForm[zNS, {4, 4}]];
Print["  Ratio z_NS / z_Sun = ", ScientificForm[zNS/zSun, 3]];
Print["  -> The neutron star redshift is ~", NumberForm[zNS/zSun, {4, 0}],
      " times larger than the Sun's!"];
Print["     The Sun's redshift (~2e-6) is barely detectable;"];
Print["     the neutron star's (~0.3-0.4) dramatically alters spectra.\n"];


(* =========================================================================
   Exercise 1.5: Flamm's Paraboloid — Embedding the Equatorial Slice
   =========================================================================
   Take the Schwarzschild spatial slice at t = const, theta = pi/2:
       dl^2 = dr^2/(1 - Rs/r) + r^2 dphi^2
   Embed this in 3D Euclidean space (cylindrical coords):
       dl^2 = dz^2 + dr^2 + r^2 dphi^2
   where z = z(r). Matching:
       dz^2 + dr^2 = dr^2/(1 - Rs/r)
       => (dz/dr)^2 = 1/(1 - Rs/r) - 1 = (Rs/r)/(1 - Rs/r)
       => dz/dr = sqrt(Rs/(r - Rs))
   Integrating: z(r) = 2*sqrt(Rs) * sqrt(r - Rs) = 2*sqrt(Rs*(r - Rs))
   ========================================================================= *)

Print["--- Exercise 1.5: Flamm's Paraboloid ---\n"];

Print["Starting from the equatorial spatial slice (t = const, theta = pi/2):"];
Print["  dl^2 = dr^2/(1 - Rs/r) + r^2 dphi^2\n"];

Print["Embed in flat 3D space with cylindrical coordinates:"];
Print["  dl^2_{flat} = dz^2 + dr^2 + r^2 dphi^2\n"];

Print["The r^2 dphi^2 terms match automatically. Matching the radial parts:"];
Print["  dz^2 + dr^2 = dr^2/(1 - Rs/r)"];
Print["  (dz/dr)^2 = 1/(1-Rs/r) - 1 = Rs / (r(1 - Rs/r)) = Rs/(r - Rs)\n"];

(* Verify the integral symbolically *)
Print["Integrating dz/dr = sqrt(Rs/(r - Rs)):"];

dzdr = Sqrt[Rs/(r - Rs)];
zEmbed = Simplify[Integrate[dzdr, r], Assumptions -> {r > Rs, Rs > 0}];
Print["  z(r) = Integrate[sqrt(Rs/(r-Rs)), r] = ", zEmbed];
Print[""];

(* Check against the expected result *)
zExpected = 2 Sqrt[Rs (r - Rs)];
zMatch = Simplify[zEmbed^2 - zExpected^2, Assumptions -> {r > Rs, Rs > 0}] === 0;
Print["Expected: z(r) = 2 sqrt(Rs (r - Rs)) = 2 sqrt(Rs) sqrt(r - Rs)"];
Print["Match? ", zMatch];
Print[""];

(* Verify the induced metric *)
Print["Verification: compute the induced metric on the embedded surface."];
Print["  dz = (dz/dr) dr, so:"];
Print["  dl^2 = (1 + (dz/dr)^2) dr^2 + r^2 dphi^2"];

dzdrCheck = D[2 Sqrt[Rs (r - Rs)], r];
dzdrSq = Simplify[dzdrCheck^2, Assumptions -> {r > Rs, Rs > 0}];
inducedGrr = Simplify[1 + dzdrSq, Assumptions -> {r > Rs, Rs > 0}];

Print["  (dz/dr)^2 = ", dzdrSq];
Print["  1 + (dz/dr)^2 = ", inducedGrr];

expectedGrr = Simplify[1/(1 - Rs/r), Assumptions -> {r > Rs, Rs > 0}];
grrMatch = Simplify[inducedGrr - expectedGrr, Assumptions -> {r > Rs, Rs > 0}] === 0;
Print["  Expected g_rr = 1/(1 - Rs/r) = ", expectedGrr];
Print["  Match? ", grrMatch];
Print["  -> The embedding correctly reproduces the Schwarzschild spatial geometry.\n"];

(* Properties of Flamm's paraboloid *)
Print["Properties of Flamm's paraboloid:"];
Print["  1. Minimum radius at r = Rs (the 'throat'), where z = 0."];
Print["  2. At large r, z ~ 2 sqrt(Rs * r) — paraboloid opens slowly."];
Print["  3. The surface is NOT a potential diagram! It shows spatial"];
Print["     curvature, not gravitational potential."];
Print["  4. The throat connects two asymptotically flat regions"];
Print["     (Einstein-Rosen bridge), though this is not traversable.\n"];

Print["=== End of Module 1c Solutions ==="];
