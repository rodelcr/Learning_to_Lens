(* =========================================================================
   schwarzschild_metric.wl
   Module 1c: The Schwarzschild Solution
   =========================================================================
   Purpose: Derive and verify the Schwarzschild metric as a vacuum solution
            to Einstein's equation. Compute:
            1. Christoffel symbols for the Schwarzschild metric
            2. Ricci tensor components (verify R_{mu nu} = 0)
            3. Full Riemann tensor
            4. Kretschner scalar K = R_{abcd} R^{abcd} = 12 Rs^2 / r^6

   Sources: Carroll Ch. 5 (eqs. 5.1, 5.12--5.14, 5.21)
            Congdon & Keeton Ch. 3.3

   Usage:   wolframscript -file schwarzschild_metric.wl

   Reuses: computeChristoffel, computeRiemann, computeRicci from Module 1b
   ========================================================================= *)

Print["=== Module 1c: The Schwarzschild Metric ===\n"];

(* ---- Import computation functions from Module 1b ---- *)
computeChristoffel[metric_, coords_] := Module[
    {n, invMetric},
    n = Length[coords];
    invMetric = Simplify[Inverse[metric]];
    Table[
        Simplify[Sum[(1/2) invMetric[[s, rho]] (
            D[metric[[nu, rho]], coords[[mu]]]
            + D[metric[[rho, mu]], coords[[nu]]]
            - D[metric[[mu, nu]], coords[[rho]]]
        ), {rho, 1, n}]],
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
   Section 1: Define the Schwarzschild Metric

   ds^2 = -(1 - Rs/r) c^2 dt^2 + (1 - Rs/r)^{-1} dr^2 + r^2 dOmega^2
   We work in geometrized units c = 1 throughout.
   ========================================================================= *)

Print["--- The Schwarzschild Metric ---\n"];
Print["ds^2 = -(1 - Rs/r) dt^2 + (1 - Rs/r)^{-1} dr^2 + r^2 dOmega^2\n"];

(* Coordinates: {t, r, theta, phi} *)
coords = {t, r, \[Theta], \[Phi]};

(* Metric tensor g_{mu nu} *)
f[r_] := 1 - Rs/r;

metricSchwarzschild = {
    {-f[r], 0, 0, 0},
    {0, 1/f[r], 0, 0},
    {0, 0, r^2, 0},
    {0, 0, 0, r^2 Sin[\[Theta]]^2}
};

Print["Metric components:"];
Print["  g_{tt} = ", metricSchwarzschild[[1, 1]]];
Print["  g_{rr} = ", metricSchwarzschild[[2, 2]]];
Print["  g_{theta theta} = ", metricSchwarzschild[[3, 3]]];
Print["  g_{phi phi} = ", metricSchwarzschild[[4, 4]]];
Print[""];

(* =========================================================================
   Section 2: Christoffel Symbols
   ========================================================================= *)

Print["--- Christoffel Symbols ---\n"];

gamma = computeChristoffel[metricSchwarzschild, coords];

(* Print nonvanishing components *)
count = 0;
Do[
    If[gamma[[s, m, n]] =!= 0,
        Print["  Gamma^", coords[[s]], "_{", coords[[m]], " ",
              coords[[n]], "} = ", gamma[[s, m, n]]];
        count++;
    ],
    {s, 4}, {m, 4}, {n, m, 4}
];
Print["  (", count, " independent nonvanishing components)\n"];

(* =========================================================================
   Section 3: Verify R_{mu nu} = 0 (Vacuum Solution)
   ========================================================================= *)

Print["--- Verifying R_{mu nu} = 0 (Vacuum Einstein Equation) ---\n"];

riemann = computeRiemann[gamma, coords];
ricci = computeRicci[riemann, 4];

Print["Ricci tensor components:"];
Do[
    Print["  R_{", coords[[mu]], " ", coords[[nu]], "} = ",
          Simplify[ricci[[mu, nu]]]],
    {mu, 4}, {nu, mu, 4}
];
Print[""];

allRicciZero = And @@ Flatten[Table[
    Simplify[ricci[[mu, nu]]] === 0,
    {mu, 4}, {nu, 4}
]];
Print["All Ricci components vanish? ", allRicciZero];
Print["=> Schwarzschild IS a vacuum solution. (QED)\n"];

(* =========================================================================
   Section 4: Ricci Scalar
   ========================================================================= *)

ricciScalar = computeRicciScalar[metricSchwarzschild, ricci];
Print["Ricci scalar R = ", ricciScalar];
Print["  (Should be 0 for a vacuum solution.)\n"];

(* =========================================================================
   Section 5: Kretschner Scalar K = R_{abcd} R^{abcd}

   This is the simplest curvature invariant that is nonzero for
   Schwarzschild. We expect K = 12 Rs^2 / r^6.

   To compute R^{abcd}, we need to raise all indices using the metric.
   R^{abcd} = g^{ae} g^{bf} g^{cg} g^{dh} R_{efgh}
   ========================================================================= *)

Print["--- Kretschner Scalar ---\n"];

invMetric = Simplify[Inverse[metricSchwarzschild]];

(* First, lower the first index of the Riemann tensor to get R_{abcd} *)
(* R_{sigma mu nu rho} = g_{sigma alpha} R^alpha_{mu nu rho} *)
riemannDown = Table[
    Simplify[
        Sum[metricSchwarzschild[[sigma, alpha]] *
            riemann[[alpha, mu, nu, rho]],
            {alpha, 1, 4}]
    ],
    {sigma, 4}, {mu, 4}, {nu, 4}, {rho, 4}
];

(* R^{abcd} = g^{ae} g^{bf} g^{cg} g^{dh} R_{efgh} *)
riemannUp = Table[
    Simplify[
        Sum[invMetric[[a, e]] invMetric[[b, ff]] invMetric[[c, g]]
            invMetric[[d, h]] riemannDown[[e, ff, g, h]],
            {e, 4}, {ff, 4}, {g, 4}, {h, 4}]
    ],
    {a, 4}, {b, 4}, {c, 4}, {d, 4}
];

(* Kretschner scalar: K = R_{abcd} R^{abcd} *)
kretschner = Simplify[
    Sum[riemannDown[[a, b, c, d]] riemannUp[[a, b, c, d]],
        {a, 4}, {b, 4}, {c, 4}, {d, 4}],
    Assumptions -> {r > Rs, Rs > 0}
];

Print["K = R_{abcd} R^{abcd} = ", kretschner];
Print["Expected: 12 Rs^2 / r^6"];
Print["Match? ", Simplify[kretschner == 12 Rs^2/r^6, Assumptions -> {r > 0, Rs > 0}]];
Print[""];
Print["At r = Rs: K = ", Simplify[kretschner /. r -> Rs], "  (finite)"];
Print["As r -> 0: K -> infinity  (true singularity)"];
Print["As r -> inf: K -> 0  (flat spacetime)\n"];

(* =========================================================================
   Section 6: Schwarzschild Radius for Astrophysical Objects
   ========================================================================= *)

Print["--- Schwarzschild Radii ---\n"];

(* Physical constants *)
Gnewton = 6.674*^-11;   (* m^3 kg^{-1} s^{-2} *)
cc = 2.998*^8;           (* m/s *)
Msolar = 1.989*^30;     (* kg *)

schwarzschildRadius[mass_] := 2 Gnewton mass / cc^2;

Print["Earth (M = 5.97e24 kg): Rs = ",
    NumberForm[schwarzschildRadius[5.97*^24] * 1000, {4, 1}], " mm"];
Print["Sun (M = 1.99e30 kg):   Rs = ",
    NumberForm[schwarzschildRadius[Msolar] / 1000, {4, 2}], " km"];
Print["Neutron star (1.4 Msun): Rs = ",
    NumberForm[schwarzschildRadius[1.4 Msolar] / 1000, {4, 2}], " km"];
Print["Sgr A* (4e6 Msun):       Rs = ",
    NumberForm[schwarzschildRadius[4*^6 Msolar] / 1000, {5, 0}], " km"];
Print["Galaxy (1e12 Msun):      Rs = ",
    NumberForm[schwarzschildRadius[1*^12 Msolar] / (3.086*^16), {4, 2}], " pc"];
Print[""];

(* =========================================================================
   Section 7: Gravitational Redshift
   ========================================================================= *)

Print["--- Gravitational Redshift ---\n"];

Print["A photon emitted at r_em, observed at r_obs -> infinity:"];
Print["  z_grav = (1 - Rs/r_em)^{-1/2} - 1\n"];

(* Neutron star surface *)
rNS = 10*^3;  (* 10 km in meters *)
rsNS = schwarzschildRadius[1.4 Msolar];
zNS = 1/Sqrt[1 - rsNS/rNS] - 1;
Print["Neutron star (M = 1.4 Msun, R = 10 km):"];
Print["  Rs = ", NumberForm[rsNS/1000, {4, 2}], " km"];
Print["  z_grav = ", NumberForm[zNS, {4, 3}]];
Print["  Wavelength increase: ", NumberForm[(zNS)*100, {4, 1}], "%\n"];

(* Sun surface *)
rSun = 6.96*^8;  (* m *)
rsSun = schwarzschildRadius[Msolar];
zSun = 1/Sqrt[1 - rsSun/rSun] - 1;
Print["Sun (R = 6.96e5 km):"];
Print["  z_grav = ", ScientificForm[zSun, 3]];
Print["  (Tiny! But measurable with precision spectroscopy.)\n"];

Print["=== End of Module 1c: The Schwarzschild Metric ==="];
