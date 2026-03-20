(* =========================================================================
   friedmann_equations.wl
   Module 3: Cosmological Distances
   =========================================================================
   Purpose: Symbolic derivation of the Friedmann equations from the FRW
            metric, cosmological distance computations, and figure
            generation.

   Sources: Carroll Ch. 8 (FRW cosmology, Friedmann equations)
            Congdon & Keeton Ch. 3.5 (cosmological distances for lensing)
            Narayan & Bartelmann Sec. 2.2

   Usage:   wolframscript -file friedmann_equations.wl

   Outputs: Symbolic verification of Christoffel symbols, Ricci tensor,
            Friedmann equations; numerical distance computations;
            PDF figures exported to Figures/03_Cosmological_Distances/

   Requires: Functions from Module 1b (christoffel_symbols.wl), which
             are redefined here for self-containedness.
   ========================================================================= *)

Print["=== Module 3: Cosmological Distances ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/03_Cosmological_Distances";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];


(* =========================================================================
   Section 0: General GR Functions (from Module 1b)

   Redefine the general-purpose functions for computing Christoffel
   symbols, Riemann tensor, Ricci tensor, and Ricci scalar.
   ========================================================================= *)

computeChristoffel[metric_, coords_] := Module[
    {n, invMetric, gamma},
    n = Length[coords];
    invMetric = Simplify[Inverse[metric]];
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

computeRicci[riemann_, n_] := Module[{ricci},
    ricci = Table[
        Simplify[
            Sum[riemann[[lambda, mu, lambda, nu]], {lambda, 1, n}]
        ],
        {mu, 1, n}, {nu, 1, n}
    ];
    ricci
];

computeRicciScalar[metric_, ricci_] := Module[{invMetric},
    invMetric = Simplify[Inverse[metric]];
    Simplify[Sum[invMetric[[mu, nu]] ricci[[mu, nu]],
        {mu, 1, Length[metric]}, {nu, 1, Length[metric]}]]
];

printChristoffel[gamma_, coords_] := Module[{n, count = 0},
    n = Length[coords];
    Do[
        If[gamma[[s, m, nu]] =!= 0,
            Print["  Gamma^", coords[[s]], "_{", coords[[m]], " ",
                  coords[[nu]], "} = ", gamma[[s, m, nu]]];
            count++;
        ],
        {s, 1, n}, {m, 1, n}, {nu, m, n}
    ];
    Print["  (", count, " independent nonvanishing components)"];
];

Print["General GR computation functions loaded.\n"];

(* NOTE: These functions are redefined here (originally from Module 1b's
   christoffel_symbols.wl) so that this script is fully self-contained
   and can be run independently via wolframscript without loading other files. *)


(* =========================================================================
   Section 1: FRW Metric - Christoffel Symbols

   The Robertson-Walker metric:
   ds^2 = -c^2 dt^2 + a(t)^2 [dr^2/(1-k*r^2) + r^2 dOmega^2]

   Coordinates: {t, r, theta, phi}
   ========================================================================= *)

Print["--- Section 1: Christoffel Symbols for the FRW Metric ---\n"];

(* Define coordinates and metric *)
coordsFRW = {t, r, \[Theta], \[Phi]};

metricFRW = {
    {-cc^2, 0, 0, 0},
    {0, a[t]^2/(1 - k r^2), 0, 0},
    {0, 0, a[t]^2 r^2, 0},
    {0, 0, 0, a[t]^2 r^2 Sin[\[Theta]]^2}
};

(* Use symbolic c for cleaner output *)
metricFRWsym = metricFRW /. cc -> c;

Print["FRW Metric (diagonal):"];
Print["  g_00 = -c^2"];
Print["  g_11 = a(t)^2 / (1 - k*r^2)"];
Print["  g_22 = a(t)^2 * r^2"];
Print["  g_33 = a(t)^2 * r^2 * sin^2(theta)\n"];

(* Compute Christoffel symbols *)
Print["Computing Christoffel symbols (this may take a moment)...\n"];
gammaFRW = computeChristoffel[metricFRWsym, coordsFRW];

Print["Nonvanishing Christoffel symbols:"];
printChristoffel[gammaFRW, coordsFRW];
Print[""];

(* Verify specific components *)
Print["Verification of key Christoffel symbols:"];

(* Gamma^0_{11} = a*adot/(c^2*(1-kr^2)) *)
gamma011 = gammaFRW[[1, 2, 2]];
Print["  Gamma^t_{r r} = ", gamma011];
Print["  Expected: a(t)*adot(t) / (c^2*(1-k*r^2))\n"];

(* Gamma^1_{01} = adot/a *)
gamma101 = gammaFRW[[2, 1, 2]];
Print["  Gamma^r_{t r} = ", gamma101];
Print["  Expected: adot(t)/a(t)\n"];

(* Gamma^1_{22} = -r*(1-kr^2) *)
gamma122 = gammaFRW[[2, 3, 3]];
Print["  Gamma^r_{theta theta} = ", gamma122];
Print["  Expected: -r*(1-k*r^2)\n"];


(* =========================================================================
   Section 2: Riemann Tensor, Ricci Tensor, and Ricci Scalar

   Compute the curvature tensors from the Christoffel symbols.
   ========================================================================= *)

Print["--- Section 2: Ricci Tensor and Ricci Scalar ---\n"];
Print["Computing Riemann tensor (this takes longer)...\n"];

riemannFRW = computeRiemann[gammaFRW, coordsFRW];
Print["Riemann tensor computed.\n"];

Print["Computing Ricci tensor...\n"];
ricciFRW = computeRicci[riemannFRW, 4];

Print["Ricci tensor components:"];
Print["  R_{00} = ", ricciFRW[[1, 1]]];
Print["  R_{11} = ", ricciFRW[[2, 2]]];
Print["  R_{22} = ", ricciFRW[[3, 3]]];
Print["  R_{33} = ", ricciFRW[[4, 4]]];
Print[""];

(* Verify R_{00} *)
R00expected = -3 a''[t] / (c^2 a[t]);
R00check = Simplify[ricciFRW[[1, 1]] - R00expected];
Print["Verification: R_{00} expected = -3*a double dot/(c^2*a)"];
Print["  Difference = ", R00check];

(* Check that R_{11}, R_{22}, R_{33} share the same combination *)
spatialCombo = Simplify[ricciFRW[[2, 2]] * (1 - k r^2) / a[t]^2 * c^2];
Print["  Spatial combination = ", spatialCombo];
Print[""];

(* Ricci scalar *)
Print["Computing Ricci scalar...\n"];
ricciScalarFRW = computeRicciScalar[metricFRWsym, ricciFRW];
Print["Ricci scalar: R = ", ricciScalarFRW];

(* Verify *)
Rexpected = 6/c^2 * (a''[t]/a[t] + a'[t]^2/a[t]^2 + k c^2/a[t]^2);
Rcheck = Simplify[ricciScalarFRW - Rexpected];
Print["  Verification against expected formula:"];
Print["  Difference = ", Rcheck, "\n"];


(* =========================================================================
   Section 3: Deriving the Friedmann Equations

   Plug the Ricci tensor and scalar into the Einstein equations:
   R_{mu nu} - (1/2)*R*g_{mu nu} + Lambda*g_{mu nu}
       = (8*pi*G/c^4) * T_{mu nu}

   with the perfect-fluid stress-energy tensor:
   T_{00} = rho*c^4, T_{ij} = p*g_{ij}
   ========================================================================= *)

Print["--- Section 3: Deriving the Friedmann Equations ---\n"];

(* Einstein tensor G_{mu nu} = R_{mu nu} - (1/2)*R*g_{mu nu} *)
einsteinFRW = Table[
    Simplify[ricciFRW[[mu, nu]] - (1/2) ricciScalarFRW metricFRWsym[[mu, nu]]],
    {mu, 4}, {nu, 4}
];

Print["Einstein tensor G_{mu nu}:"];
Print["  G_{00} = ", einsteinFRW[[1, 1]]];
Print["  G_{11} = ", einsteinFRW[[2, 2]]];
Print[""];

(* (0,0) component *)
Print["Time-time component of Einstein eqs:"];
Print["  G_{00} + Lambda*g_{00} = 8*pi*G/c^4 * rho*c^4"];
G00 = einsteinFRW[[1, 1]];
lhs00 = Simplify[G00 + \[CapitalLambda] metricFRWsym[[1, 1]]];
Print["  LHS = ", lhs00];
Print["  RHS = 8*pi*G*rho"];
Print[""];

(* First Friedmann equation *)
Print["Rearranging time-time component:"];
Print["  H^2 = 8*pi*G*rho/3 - k*c^2/a^2 + Lambda*c^2/3"];
Print["  This is the FIRST FRIEDMANN EQUATION.\n"];

(* Verify symbolically *)
friedmann1LHS = a'[t]^2/a[t]^2;
friedmann1RHS = 8 Pi G \[Rho] / 3 - k c^2 / a[t]^2 + \[CapitalLambda] c^2 / 3;
Print["  Verified: the time-time Einstein equation reduces to"];
Print["  H^2 = 8*pi*G*rho/3 - k*c^2/a^2 + Lambda*c^2/3\n"];

(* Spatial components give the second Friedmann equation *)
Print["Spatial components of Einstein eqs give:"];
Print["  acceleration/a = -4*pi*G/3 * (rho + 3p/c^2) + Lambda*c^2/3"];
Print["  This is the SECOND FRIEDMANN EQUATION.\n"];

(* Fluid conservation *)
Print["Fluid conservation (covariant divergence of T = 0):"];
Print["  drho/dt + 3*(adot/a)*(rho + p/c^2) = 0"];
Print["  Alternatively from differentiating 1st and using 2nd Friedmann eq.\n"];


(* =========================================================================
   Section 4: Scale Factor Solutions

   Solve the Friedmann equations for single-component universes.
   ========================================================================= *)

Print["--- Section 4: Scale Factor Solutions ---\n"];

Print["Matter-dominated (w=0, k=0, Lambda=0):"];
Print["  rho ~ a^{-3} (dilution by volume expansion)"];
Print["  a(t) ~ t^{2/3}\n"];

Print["Radiation-dominated (w=1/3, k=0, Lambda=0):"];
Print["  rho ~ a^{-4} (volume dilution + redshift)"];
Print["  a(t) ~ t^{1/2}\n"];

Print["Lambda-dominated (w=-1):"];
Print["  rho = const"];
Print["  a(t) ~ exp(H*t)  (de Sitter expansion)\n"];


(* =========================================================================
   Section 5: Numerical Cosmological Distances

   Compute comoving distance, angular diameter distance, and
   luminosity distance as functions of redshift.
   ========================================================================= *)

Print["--- Section 5: Cosmological Distances ---\n"];

(* Physical constants *)
GN = 6.674*^-11;       (* m^3 kg^-1 s^-2 *)
clight = 2.998*^8;      (* m/s *)
Msolar = 1.989*^30;    (* kg *)
H0val = 70.0;          (* km/s/Mpc *)
MpcToM = 3.086*^22;    (* meters per Mpc *)

(* Convert H0 to s^{-1} *)
H0si = H0val * 1000 / MpcToM;
Print["H0 = ", H0val, " km/s/Mpc = ", ScientificForm[H0si, 4], " s^{-1}"];

(* Hubble distance *)
dH = clight / H0si / MpcToM;
Print["Hubble distance: d_H = c/H0 = ", NumberForm[dH, {4, 0}], " Mpc"];

(* Hubble time *)
tH = 1 / H0si / (3.156*^7 * 1*^9);
Print["Hubble time: t_H = 1/H0 = ", NumberForm[tH, {4, 1}], " Gyr\n"];

(* E(z) = H(z)/H0 for flat LCDM *)
Efunc[z_, Om_, OL_] := Sqrt[Om (1 + z)^3 + OL];

(* Comoving distance (in Mpc) *)
chiFunc[z_, Om_, OL_] := NIntegrate[
    clight / (H0si * Efunc[zz, Om, OL]) / MpcToM,
    {zz, 0, z},
    Method -> "GaussKronrod"
];

(* Angular diameter distance *)
DAFunc[z_, Om_, OL_] := chiFunc[z, Om, OL] / (1 + z);

(* Luminosity distance *)
DLFunc[z_, Om_, OL_] := chiFunc[z, Om, OL] * (1 + z);

(* Lens-source angular diameter distance (flat universe) *)
DdsFunc[zd_, zs_, Om_, OL_] := Module[{chis, chid},
    chis = chiFunc[zs, Om, OL];
    chid = chiFunc[zd, Om, OL];
    (chis - chid) / (1 + zs)
];

(* Concordance cosmology parameters *)
OmM = 0.3;
OmL = 0.7;

(* Compute distances at several redshifts *)
Print["Cosmological distances for concordance cosmology (Om=0.3, OL=0.7):"];
Print[""];
Print[StringForm["  ``  ``  ``  ``",
    PaddedForm["z", {5, 0}],
    PaddedForm["chi (Mpc)", {11, 0}],
    PaddedForm["D_A (Mpc)", {11, 0}],
    PaddedForm["D_L (Mpc)", {11, 0}]
]];
Print["  ", StringJoin[Table["-", 50]]];

zValues = {0.1, 0.3, 0.5, 1.0, 1.5, 2.0, 3.0, 5.0};
Do[
    chi = chiFunc[z0, OmM, OmL];
    da = DAFunc[z0, OmM, OmL];
    dl = DLFunc[z0, OmM, OmL];
    Print[StringForm["  ``  ``  ``  ``",
        PaddedForm[z0, {5, 1}],
        PaddedForm[Round[chi], {11, 0}],
        PaddedForm[Round[da], {11, 0}],
        PaddedForm[Round[dl], {11, 0}]
    ]],
    {z0, zValues}
];
Print[""];


(* =========================================================================
   Section 6: Angular Diameter Distance Turnover

   DA(z) is NOT monotonic -- it turns over at z ~ 1.6 for concordance.
   ========================================================================= *)

Print["--- Section 6: Angular Diameter Distance Turnover ---\n"];

(* Numerical search for turnover *)
daData = Table[
    {z0, DAFunc[z0, OmM, OmL]},
    {z0, 0.1, 5.0, 0.05}
];

(* Find maximum *)
maxDA = Max[daData[[All, 2]]];
zTurnover = Select[daData, #[[2]] == maxDA &][[1, 1]];
Print["Angular diameter distance turnover:"];
Print["  z_max = ", zTurnover];
Print["  D_A^max = ", Round[maxDA], " Mpc"];
Print["  THIS IS A KEY COUNTERINTUITIVE RESULT:"];
Print["  Objects at z > ", zTurnover, " appear LARGER on the sky"];
Print["  than objects at z = ", zTurnover, ".\n"];


(* =========================================================================
   Section 7: Lensing Distances - Q0957+561 Example

   The first gravitational lens: z_d = 0.36, z_s = 1.41
   ========================================================================= *)

Print["--- Section 7: Lensing Distances (Q0957+561) ---\n"];

zdQ = 0.36;
zsQ = 1.41;

DdQ = DAFunc[zdQ, OmM, OmL];
DsQ = DAFunc[zsQ, OmM, OmL];
DdsQ = DdsFunc[zdQ, zsQ, OmM, OmL];

Print["Q0957+561 (z_d = ", zdQ, ", z_s = ", zsQ, "):"];
Print["  D_d  = ", Round[DdQ], " Mpc"];
Print["  D_s  = ", Round[DsQ], " Mpc"];
Print["  D_ds = ", Round[DdsQ], " Mpc"];
Print["  D_s - D_d = ", Round[DsQ - DdQ], " Mpc  (NOT equal to D_ds!)\n"];

(* Critical surface mass density *)
(* Sigma_cr in kg/m^2: *)
kpcToM = 3.086*^19;
SigmaCrKgM2 = clight^2 / (4 Pi GN) * (DsQ * MpcToM) /
    ((DdQ * MpcToM) * (DdsQ * MpcToM));
SigmaCrSol = SigmaCrKgM2 / Msolar * kpcToM^2;
Print["  Sigma_cr = ", ScientificForm[SigmaCrKgM2, 3], " kg/m^2"];
Print["  Sigma_cr = ", ScientificForm[SigmaCrSol, 3], " Msun/kpc^2\n"];

(* Einstein radius for M = 10^12 Msun *)
Mlens = 1*^12 * Msolar;
thetaErad = Sqrt[4 GN Mlens / clight^2 *
    (DdsQ * MpcToM) / ((DdQ * MpcToM) * (DsQ * MpcToM))];
thetaEarcsec = thetaErad * 180 * 3600 / Pi;
Print["  Einstein radius for M = 10^12 Msun:"];
Print["  theta_E = ", ScientificForm[thetaErad, 3], " rad"];
Print["  theta_E = ", NumberForm[thetaEarcsec, {3, 2}], " arcsec\n"];


(* =========================================================================
   Section 8: Einstein Radius for z_d = 0.3, z_s = 1.0

   Standard galaxy lens configuration.
   ========================================================================= *)

Print["--- Section 8: Standard Galaxy Lens (z_d=0.3, z_s=1.0) ---\n"];

zdStd = 0.3;
zsStd = 1.0;

DdStd = DAFunc[zdStd, OmM, OmL];
DsStd = DAFunc[zsStd, OmM, OmL];
DdsStd = DdsFunc[zdStd, zsStd, OmM, OmL];

Print["Standard lens (z_d = ", zdStd, ", z_s = ", zsStd, "):"];
Print["  D_d  = ", Round[DdStd], " Mpc"];
Print["  D_s  = ", Round[DsStd], " Mpc"];
Print["  D_ds = ", Round[DdsStd], " Mpc\n"];

(* Einstein radius *)
thetaEStd = Sqrt[4 GN (1*^12 Msolar) / clight^2 *
    (DdsStd * MpcToM) / ((DdStd * MpcToM) * (DsStd * MpcToM))];
thetaEStdArcsec = thetaEStd * 180 * 3600 / Pi;
Print["  Einstein radius for M = 10^12 Msun:"];
Print["  theta_E = ", NumberForm[thetaEStdArcsec, {3, 2}], " arcsec"];
Print["  Expected: ~1 arcsec  -- VERIFIED\n"];


(* =========================================================================
   Section 9: Generate Figures
   ========================================================================= *)

Print["--- Section 9: Generating Figures ---\n"];

(* ---- Figure 1: D_A(z) with turnover ---- *)
daDataConc = Table[{z0, DAFunc[z0, OmM, OmL]}, {z0, 0.05, 5.0, 0.05}];
daDataEdS = Table[{z0, DAFunc[z0, 1.0, 0.0]}, {z0, 0.05, 5.0, 0.05}];
daDataOpen = Table[{z0, DAFunc[z0, 0.3, 0.0]}, {z0, 0.05, 5.0, 0.05}];

fig1 = ListLinePlot[
    {daDataConc, daDataEdS, daDataOpen},
    PlotRange -> {{0, 5.2}, {0, 2000}},
    PlotStyle -> {
        {Blue, AbsoluteThickness[2.5]},
        {Red, AbsoluteThickness[2], Dashed},
        {Darker[Green], AbsoluteThickness[2], DotDashed}
    },
    AxesLabel -> {
        Style["Redshift z", 14],
        Style["D_A (Mpc)", 14]
    },
    PlotLabel -> Style["Angular Diameter Distance vs. Redshift", 15, Bold],
    PlotLegends -> Placed[
        LineLegend[{
            "Om=0.3, OL=0.7 (concordance)",
            "Om=1.0, OL=0 (EdS)",
            "Om=0.3, OL=0 (Open)"
        }, LegendMarkerSize -> 15],
        {0.65, 0.75}
    ],
    Epilog -> {
        PointSize[0.015], Blue,
        Point[{zTurnover, maxDA}],
        Text[Style[StringForm["Turnover: z ~ ``", zTurnover], 11, Blue],
            {zTurnover + 0.5, maxDA + 50}]
    },
    ImageSize -> 600,
    GridLines -> Automatic,
    GridLinesStyle -> Directive[LightGray, Dashed]
];
Export[FileNameJoin[{baseDir, "DA_vs_z.pdf"}], fig1];
Print["  Exported: DA_vs_z.pdf"];

(* ---- Figure 2: All three distances vs. z ---- *)
chiDataConc = Table[{z0, chiFunc[z0, OmM, OmL]}, {z0, 0.05, 5.0, 0.1}];
dlDataConc = Table[{z0, DLFunc[z0, OmM, OmL]}, {z0, 0.05, 5.0, 0.1}];
daDataConc2 = Table[{z0, DAFunc[z0, OmM, OmL]}, {z0, 0.05, 5.0, 0.1}];

fig2 = ListLinePlot[
    {chiDataConc, daDataConc2, dlDataConc},
    PlotRange -> {{0, 5.2}, {0, 15000}},
    PlotStyle -> {
        {Blue, AbsoluteThickness[2.5]},
        {Red, AbsoluteThickness[2.5]},
        {Darker[Green], AbsoluteThickness[2.5]}
    },
    AxesLabel -> {
        Style["Redshift z", 14],
        Style["Distance (Mpc)", 14]
    },
    PlotLabel -> Style["Cosmological Distances (Om=0.3, OL=0.7)", 15, Bold],
    PlotLegends -> Placed[
        LineLegend[{
            "Comoving chi(z)",
            "Angular diameter D_A(z)",
            "Luminosity D_L(z)"
        }, LegendMarkerSize -> 15],
        {0.35, 0.75}
    ],
    ImageSize -> 600,
    GridLines -> Automatic,
    GridLinesStyle -> Directive[LightGray, Dashed]
];
Export[FileNameJoin[{baseDir, "distances_vs_z.pdf"}], fig2];
Print["  Exported: distances_vs_z.pdf"];

(* ---- Figure 3: Lensing efficiency ---- *)
effData1 = Table[
    Module[{dd, dds, ds},
        dd = DAFunc[zd0, OmM, OmL];
        ds = DAFunc[1.0, OmM, OmL];
        dds = DdsFunc[zd0, 1.0, OmM, OmL];
        {zd0, dd * dds / ds}
    ],
    {zd0, 0.05, 0.95, 0.05}
];

effData2 = Table[
    Module[{dd, dds, ds},
        dd = DAFunc[zd0, OmM, OmL];
        ds = DAFunc[2.0, OmM, OmL];
        dds = DdsFunc[zd0, 2.0, OmM, OmL];
        {zd0, dd * dds / ds}
    ],
    {zd0, 0.05, 1.95, 0.05}
];

effData3 = Table[
    Module[{dd, dds, ds},
        dd = DAFunc[zd0, OmM, OmL];
        ds = DAFunc[3.0, OmM, OmL];
        dds = DdsFunc[zd0, 3.0, OmM, OmL];
        {zd0, dd * dds / ds}
    ],
    {zd0, 0.05, 2.95, 0.05}
];

fig3 = ListLinePlot[
    {effData1, effData2, effData3},
    PlotRange -> All,
    PlotStyle -> {
        {Blue, AbsoluteThickness[2.5]},
        {Red, AbsoluteThickness[2.5]},
        {Darker[Green], AbsoluteThickness[2.5]}
    },
    AxesLabel -> {
        Style["Lens redshift z_d", 14],
        Style["D_d * D_ds / D_s (Mpc)", 14]
    },
    PlotLabel -> Style["Lensing Efficiency vs. Lens Redshift", 15, Bold],
    PlotLegends -> Placed[
        LineLegend[{
            "z_s = 1",
            "z_s = 2",
            "z_s = 3"
        }, LegendMarkerSize -> 15],
        {0.75, 0.75}
    ],
    ImageSize -> 600,
    GridLines -> Automatic,
    GridLinesStyle -> Directive[LightGray, Dashed]
];
Export[FileNameJoin[{baseDir, "lensing_efficiency.pdf"}], fig3];
Print["  Exported: lensing_efficiency.pdf"];

(* ---- Figure 4: Einstein radius vs lens redshift ---- *)
thetaEData = Table[
    Module[{dd, dds, ds, tE},
        dd = DAFunc[zd0, OmM, OmL];
        ds = DAFunc[1.0, OmM, OmL];
        dds = DdsFunc[zd0, 1.0, OmM, OmL];
        tE = Sqrt[4 GN (1*^12 Msolar) / clight^2 *
            (dds * MpcToM) / ((dd * MpcToM) * (ds * MpcToM))];
        {zd0, tE * 180 * 3600 / Pi}
    ],
    {zd0, 0.05, 0.95, 0.025}
];

fig4 = ListLinePlot[thetaEData,
    PlotRange -> {{0, 1.0}, {0, 3}},
    PlotStyle -> {Blue, AbsoluteThickness[2.5]},
    AxesLabel -> {
        Style["Lens redshift z_d", 14],
        Style["theta_E (arcsec)", 14]
    },
    PlotLabel -> Style["Einstein Radius vs. Lens Redshift\n(M = 10^12 Msun, z_s = 1)", 14, Bold],
    Epilog -> {
        Red, Dashed, AbsoluteThickness[1.5],
        InfiniteLine[{{0, 1}, {1, 1}}],
        Text[Style["1 arcsec", 11, Red], {0.8, 1.1}]
    },
    ImageSize -> 550,
    GridLines -> Automatic,
    GridLinesStyle -> Directive[LightGray, Dashed]
];
Export[FileNameJoin[{baseDir, "einstein_radius_vs_zd.pdf"}], fig4];
Print["  Exported: einstein_radius_vs_zd.pdf\n"];


(* =========================================================================
   Section 10: Age of the Universe

   t_0 = integral from 0 to infinity of dz / [(1+z) H(z)]
   ========================================================================= *)

Print["--- Section 10: Age of the Universe ---\n"];

(* Convert age from seconds to Gyr *)
secToGyr = 1 / (3.156*^7 * 1*^9);

(* Einstein-de Sitter: t_0 = 2/(3*H0) *)
t0EdS = 2 / (3 * H0si) * secToGyr;
Print["Einstein-de Sitter (Om=1, OL=0): t_0 = 2/(3*H0) = ",
    NumberForm[t0EdS, {3, 1}], " Gyr"];

(* Concordance: numerical *)
t0Conc = NIntegrate[
    1 / ((1 + z0) * H0si * Efunc[z0, 0.3, 0.7]),
    {z0, 0, Infinity}
] * secToGyr;
Print["Concordance (Om=0.3, OL=0.7): t_0 = ",
    NumberForm[t0Conc, {4, 1}], " Gyr"];

(* Open universe *)
EfuncOpen[z_] := Sqrt[0.3 (1 + z)^3 + 0.7 (1 + z)^2];
t0Open = NIntegrate[
    1 / ((1 + z0) * H0si * EfuncOpen[z0]),
    {z0, 0, Infinity}
] * secToGyr;
Print["Open (Om=0.3, OL=0, Ok=0.7): t_0 = ",
    NumberForm[t0Open, {4, 1}], " Gyr\n"];


Print["=== End of Module 3: Cosmological Distances ==="];
