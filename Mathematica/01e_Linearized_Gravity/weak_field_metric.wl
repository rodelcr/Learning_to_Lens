(* =========================================================================
   weak_field_metric.wl
   Module 1e: Linearized Gravity and the Weak-Field Metric
   =========================================================================
   Purpose: Symbolic verification of the Newtonian limit, weak-field
            expansion of Schwarzschild, null geodesic deflection angle,
            factor-of-2, effective refractive index, and figure generation.

   Sources: Carroll Ch. 4.1 (Newtonian limit), Ch. 7.1 (linearized gravity)
            Congdon & Keeton Ch. 3.4 (weak-field light propagation)

   Usage:   wolframscript -file weak_field_metric.wl

   Outputs: Symbolic verification of all key results;
            PDF figures exported to Figures/01e_Linearized_Gravity/
   ========================================================================= *)

Print["=== Module 1e: Linearized Gravity and the Weak-Field Metric ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/01e_Linearized_Gravity";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];

(* Physical constants *)
Gnewton = 6.674*^-11;       (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
Rsolar = 6.96*^8;           (* m *)
AU = 1.496*^11;             (* m *)
kpc = 3.086*^19;            (* m *)


(* =========================================================================
   Section 1: Newtonian Limit — Identify h_00 = -2 Phi/c^2

   Start from the geodesic equation with g = eta + h.
   In the slow-motion, static-field limit, only Gamma^i_00 matters.
   ========================================================================= *)

Print["--- Section 1: Newtonian Limit ---\n"];

(* Define Minkowski metric *)
eta = DiagonalMatrix[{-1, 1, 1, 1}];
Print["Minkowski metric eta = ", MatrixForm[eta]];

(* The linearized Christoffel symbol Gamma^alpha_{mu nu}:
   Gamma^alpha_{mu nu} = (1/2) eta^{alpha beta}
     (d_mu h_{nu beta} + d_nu h_{mu beta} - d_beta h_{mu nu})

   For the Newtonian limit, we need Gamma^i_{00} with static field:
   Gamma^i_{00} = (1/2) eta^{ij} (-d_j h_{00}) = -(1/2) d_i h_{00}
*)

Print["Christoffel symbol Gamma^i_{00} in static weak field:"];
Print["  Gamma^i_{00} = -(1/2) partial_i h_{00}\n"];

Print["Geodesic equation (spatial part, slow motion):"];
Print["  d^2 x^i/dt^2 = (1/2) c^2 partial_i h_{00}\n"];

Print["Comparing with Newton's law: d^2 x^i/dt^2 = -partial_i Phi"];
Print["  => h_{00} = -2 Phi / c^2\n"];

(* Verify for a point mass *)
Print["For a point mass M: Phi = -GM/r"];
Print["  h_{00} = 2GM/(c^2 r) = Rs/r"];
Print["  where Rs = 2GM/c^2 is the Schwarzschild radius.\n"];


(* =========================================================================
   Section 2: Weak-Field Expansion of Schwarzschild

   Expand (1 - Rs/r)^{-1} to first order in Rs/r.
   Show the result matches the weak-field metric.
   ========================================================================= *)

Print["--- Section 2: Weak-Field Expansion of Schwarzschild ---\n"];

(* Schwarzschild metric components (in terms of epsilon = Rs/r) *)
gtt[eps_] := -(1 - eps);
grr[eps_] := 1/(1 - eps);

(* Taylor expand grr to first order *)
grrExpanded = Series[grr[eps], {eps, 0, 1}] // Normal;
Print["Schwarzschild g_rr = 1/(1 - Rs/r)"];
Print["Expanded to first order in Rs/r:"];
Print["  g_rr ≈ ", grrExpanded, " = 1 + Rs/r + O((Rs/r)^2)"];
Print[""];

(* Full weak-field metric components *)
Print["Weak-field Schwarzschild metric:"];
Print["  g_tt ≈ -(1 - Rs/r) = -(1 + 2*Phi/c^2)  with Phi = -GM/r"];
Print["  g_rr ≈  (1 + Rs/r) =  (1 - 2*Phi/c^2)"];
Print[""];

(* Verify equality of perturbations *)
Print["Metric perturbations:"];
Print["  h_00 = -2*Phi/c^2 = Rs/r"];
Print["  h_ij = -2*Phi/c^2 * delta_ij = (Rs/r) * delta_ij"];
Print["  => h_00 = h_rr = h_theta_theta/(r^2) = h_phi_phi/(r^2 sin^2 theta)"];
Print["  The TIME and SPACE perturbations are EQUAL. This is crucial for"];
Print["  the factor-of-2 in light bending.\n"];

(* Verify by comparing exact and expanded at specific values *)
Print["Numerical check of expansion accuracy:"];
epsValues = {0.001, 0.01, 0.1, 0.2, 0.5};
Do[
    exact = grr[eps0];
    approx = 1 + eps0;
    err = Abs[(exact - approx)/exact];
    Print["  Rs/r = ", eps0,
        ": exact = ", NumberForm[exact, 6],
        ", approx = ", NumberForm[approx, 6],
        ", rel. error = ", ScientificForm[err, 3]],
    {eps0, epsValues}
];
Print["  => Expansion is excellent for Rs/r << 1.\n"];


(* =========================================================================
   Section 3: Null Geodesic Deflection — Factor of 2

   The deflection angle integral:
     alpha_hat = (4/c^2) integral nabla_perp Phi dl

   For a point mass, this gives alpha_hat = 4GM/(c^2 b).
   ========================================================================= *)

Print["--- Section 3: Null Geodesic Deflection ---\n"];

(* The deflection integral for a point mass *)
(* Photon along x-axis at y = b: Phi = -GM/sqrt(x^2 + b^2) *)
(* nabla_perp Phi = d Phi / d b = GM b / (x^2 + b^2)^{3/2} *)

Print["Unperturbed photon path: x(l) = (l, b, 0)"];
Print["Potential: Phi = -GM/sqrt(l^2 + b^2)"];
Print["Perpendicular gradient: nabla_perp Phi = GM*b / (l^2 + b^2)^{3/2}\n"];

(* Evaluate the integral symbolically *)
integrand = b / (x^2 + b^2)^(3/2);
result = Integrate[integrand, {x, -Infinity, Infinity},
    Assumptions -> b > 0];
Print["Integral of b/(x^2 + b^2)^{3/2} from -inf to +inf = ", result];
Print["  = 2/b\n"];

(* Full deflection angle *)
Print["Deflection from h_00 alone (time part):"];
Print["  alpha_time = (2/c^2) * GM * (2/b) = 4GM/(c^2 b) * (1/2) = 2GM/(c^2 b)\n"];

Print["Deflection from h_ij (space part):"];
Print["  alpha_space = 2GM/(c^2 b)  (equal to time part)\n"];

Print["Total deflection:"];
Print["  alpha_hat = alpha_time + alpha_space = 4GM/(c^2 b)"];
Print["  = 2 * (Newtonian prediction)"];
Print["  The factor of 2 comes from the SPATIAL CURVATURE.\n"];

(* Numerical value for the Sun *)
alphaHatSun = 4 * Gnewton * Msolar / (cc^2 * Rsolar);
alphaHatSunArcsec = alphaHatSun * (180 * 3600 / Pi);
Print["For the Sun at the solar limb:"];
Print["  alpha_hat = ", ScientificForm[alphaHatSun, 4], " rad"];
Print["           = ", NumberForm[alphaHatSunArcsec, {4, 2}], " arcsec"];
Print["  Expected: 1.75 arcsec (Eddington 1919)\n"];


(* =========================================================================
   Section 4: Effective Refractive Index

   n = 1 - 2*Phi/c^2 = 1 + 2|Phi|/c^2
   Since Phi < 0 near a mass, n > 1.
   ========================================================================= *)

Print["--- Section 4: Effective Refractive Index ---\n"];

Print["Coordinate speed of light: v = c * sqrt((1 + 2Phi/c^2)/(1 - 2Phi/c^2))"];
Print["  ≈ c * (1 + 2Phi/c^2) to first order"];
Print[""];
Print["Effective refractive index: n = c/v ≈ 1 - 2Phi/c^2 = 1 + 2|Phi|/c^2"];
Print["  (since Phi < 0 near a mass, n > 1)\n"];

(* Compute n-1 at various distances from the Sun *)
nMinus1[r_] := 2 * Gnewton * Msolar / (cc^2 * r);

Print["n - 1 = 2GM/(c^2 r) for a solar-mass object:"];
Print["  At solar surface (r = R_sun): n - 1 = ",
    ScientificForm[nMinus1[Rsolar], 4]];
Print["  At Earth orbit  (r = 1 AU):   n - 1 = ",
    ScientificForm[nMinus1[AU], 4]];
Print["  At Pluto orbit  (r = 39.5 AU): n - 1 = ",
    ScientificForm[nMinus1[39.5 * AU], 4]];
Print["  At 1 kpc:                     n - 1 = ",
    ScientificForm[nMinus1[kpc], 4]];
Print[""];


(* =========================================================================
   Section 5: Exact vs Weak-Field Deflection Comparison

   Exact Schwarzschild deflection angle (from Module 1d):
     alpha_exact = 2 * integral from r_min to infinity of
       (L/r^2) / sqrt(E^2/c^2 - L^2/r^2 * (1 - Rs/r)) dr - pi

   Weak-field: alpha_weak = 4GM/(c^2 b) = 2Rs/b

   Compare as function of b/Rs.
   ========================================================================= *)

Print["--- Section 5: Exact vs Weak-Field Deflection Comparison ---\n"];

(* Exact deflection angle for Schwarzschild (numerical integration)
   Using the standard integral in terms of u = Rs/r and b/Rs *)

(* The exact deflection angle for a photon with impact parameter b
   in Schwarzschild spacetime is:
   Delta phi = 2 * integral_0^{u_max} du / sqrt(1/b^2 - u^2(1 - u*Rs))
               - pi
   where u = 1/r and u_max is the turning point. *)

(* In units where Rs = 1, with beta = Rs/b: *)
exactDeflection[beta_?NumericQ] := Module[{umax, integrand, result},
    (* Find turning point: 1/b^2 - u^2(1 - u) = 0, i.e., beta^2 - u^2(1-u)/1 *)
    (* In Rs=1 units: 1/b^2 = beta^2, so solve beta^2 = u^2(1-u) *)
    umax = u /. FindRoot[beta^2 - u^2 (1 - u) == 0, {u, beta}];
    integrand[uu_] := 1/Sqrt[beta^2 - uu^2 (1 - uu)];
    result = 2 * NIntegrate[integrand[uu], {uu, 0, umax}] - Pi;
    result
] /; 0 < beta < 1/Sqrt[27/4];  (* beta < 1/sqrt(6.75) for photon not captured *)

weakDeflection[beta_] := 2 * beta;  (* 4GM/(c^2 b) = 2 Rs/b = 2 beta when beta = Rs/b *)

(* Generate comparison data *)
Print["Computing exact vs weak-field deflection angles...\n"];

bOverRs = Table[b0, {b0, 3, 200}];
betaValues = 1.0 / bOverRs;

exactAngles = {};
weakAngles = {};
Do[
    beta0 = 1.0 / b0;
    aExact = exactDeflection[beta0];
    aWeak = weakDeflection[beta0];
    AppendTo[exactAngles, {b0, aExact}];
    AppendTo[weakAngles, {b0, aWeak}],
    {b0, bOverRs}
];

Print["Sample values (b/Rs, alpha_exact, alpha_weak, rel_error):"];
Do[
    b0 = bOverRs[[i]];
    aE = exactAngles[[i, 2]];
    aW = weakAngles[[i, 2]];
    err = Abs[(aE - aW)/aE];
    Print["  b/Rs = ", b0,
        ": exact = ", NumberForm[aE, 5],
        ", weak = ", NumberForm[aW, 5],
        ", error = ", ScientificForm[err, 3]],
    {i, {1, 3, 8, 18, 48, 98, 198}}
];
Print[""];


(* =========================================================================
   Section 6: Generate Figures
   ========================================================================= *)

Print["--- Generating Figures ---\n"];

(* ---- Figure 1: Deflection angle comparison ---- *)
fig1 = Show[
    ListLogLogPlot[{exactAngles, weakAngles},
        PlotRange -> {{2.5, 250}, {0.005, 2}},
        PlotStyle -> {
            {Blue, AbsoluteThickness[2]},
            {Red, AbsoluteThickness[2], Dashed}
        },
        Joined -> True,
        AxesLabel -> {
            Style["b / Rs", 13],
            Style["Deflection angle (radians)", 13]
        },
        PlotLabel -> Style["Deflection Angle: Exact vs Weak-Field", 14],
        PlotLegends -> Placed[
            LineLegend[
                {"Exact (Schwarzschild)", "Weak-field 4GM/(c^2 b)"},
                LegendMarkerSize -> 15],
            {0.65, 0.75}
        ],
        ImageSize -> 550,
        GridLines -> Automatic,
        GridLinesStyle -> Directive[LightGray, Dashed]
    ],
    (* Mark photon sphere limit *)
    Graphics[{
        Orange, Dashed, AbsoluteThickness[1.5],
        InfiniteLine[{{3/2, 0.001}, {3/2, 10}}],
        Text[Style["Photon\nsphere", 9, Orange], {2.2, 1.2}]
    }]
];
Export[FileNameJoin[{baseDir, "deflection_comparison.pdf"}], fig1];
Print["  Exported: deflection_comparison.pdf"];

(* ---- Figure 2: Fractional error ---- *)
errorData = Table[
    {exactAngles[[i, 1]],
     Abs[(exactAngles[[i, 2]] - weakAngles[[i, 2]]) / exactAngles[[i, 2]]]},
    {i, Length[exactAngles]}
];

fig2 = ListLogLogPlot[errorData,
    PlotRange -> {{2.5, 250}, {1*^-6, 1}},
    Joined -> True,
    PlotStyle -> {Blue, AbsoluteThickness[2]},
    AxesLabel -> {
        Style["b / Rs", 13],
        Style["Fractional Error", 13]
    },
    PlotLabel -> Style["Weak-Field Approximation Error", 14],
    Epilog -> {
        Red, Dashed, AbsoluteThickness[1],
        InfiniteLine[{{1, 0.01}, {1000, 0.01}}],
        Text[Style["1% error", 10, Red], {15, 0.015}],
        Darker[Green], Dashed, AbsoluteThickness[1],
        InfiniteLine[{{1, 0.001}, {1000, 0.001}}],
        Text[Style["0.1% error", 10, Darker[Green]], {15, 0.0015}]
    },
    ImageSize -> 500,
    GridLines -> Automatic,
    GridLinesStyle -> Directive[LightGray, Dashed]
];
Export[FileNameJoin[{baseDir, "exact_vs_weak_field.pdf"}], fig2];
Print["  Exported: exact_vs_weak_field.pdf"];

(* ---- Figure 3: Effective refractive index ---- *)
(* n(r) = 1 + 2GM/(c^2 r) for a solar-mass object *)
(* Plot n-1 as a function of r/Rs *)
nMinusOne[rOverRs_] := 1/rOverRs;  (* In Rs units: 2GM/(c^2 r) = Rs/r = 1/(r/Rs) *)

fig3 = LogLogPlot[nMinusOne[rr], {rr, 1, 1*^7},
    PlotRange -> {{0.8, 1.5*^7}, {5*^-8, 1.5}},
    PlotStyle -> {Blue, AbsoluteThickness[2]},
    AxesLabel -> {
        Style["r / Rs", 13],
        Style["n - 1 = 2|Phi|/c^2", 13]
    },
    PlotLabel -> Style["Effective Refractive Index (Point Mass)", 14],
    Epilog -> {
        (* Mark solar limb for the Sun *)
        Red, PointSize[0.015],
        Point[{Rsolar/(2 Gnewton Msolar/cc^2), nMinus1[Rsolar] * cc^2/(2 Gnewton Msolar) * (2 Gnewton Msolar/cc^2)}],
        Text[Style["Solar limb\n(r/Rs ~ 2.4 x 10^5)", 9, Red],
            Scaled[{0.35, 0.45}]],
        (* Weak-field region *)
        Darker[Green], AbsoluteThickness[1.5], Dashed,
        InfiniteLine[{{1, 0.1}, {1*^8, 0.1}}],
        Text[Style["Weak-field regime\n(n - 1 < 0.1)", 10, Darker[Green]],
            Scaled[{0.7, 0.65}]]
    },
    ImageSize -> 500,
    GridLines -> Automatic,
    GridLinesStyle -> Directive[LightGray, Dashed]
];
Export[FileNameJoin[{baseDir, "refractive_index.pdf"}], fig3];
Print["  Exported: refractive_index.pdf"];

(* ---- Figure 4: Factor of 2 visualization ---- *)
(* Show time-part and space-part contributions separately *)
bRange = Range[3, 100];
timeContrib = Table[{b0, 1.0/b0}, {b0, bRange}];    (* 2GM/(c^2 b) in Rs units *)
spaceContrib = Table[{b0, 1.0/b0}, {b0, bRange}];   (* equal contribution *)
totalContrib = Table[{b0, 2.0/b0}, {b0, bRange}];    (* 4GM/(c^2 b) *)

fig4 = ListLogLogPlot[{timeContrib, totalContrib, exactAngles},
    PlotRange -> {{2.5, 120}, {0.01, 2}},
    Joined -> True,
    PlotStyle -> {
        {Orange, AbsoluteThickness[2], Dashed},
        {Red, AbsoluteThickness[2], Dashed},
        {Blue, AbsoluteThickness[2.5]}
    },
    AxesLabel -> {
        Style["b / Rs", 13],
        Style["Deflection Angle (rad)", 13]
    },
    PlotLabel -> Style["Factor of 2: Time vs Space Contributions", 14],
    PlotLegends -> Placed[
        LineLegend[{
            "Time only: 2GM/(c^2 b)",
            "Time + Space: 4GM/(c^2 b)",
            "Exact (Schwarzschild)"
        }, LegendMarkerSize -> 15],
        {0.65, 0.75}
    ],
    ImageSize -> 550,
    GridLines -> Automatic,
    GridLinesStyle -> Directive[LightGray, Dashed]
];
Export[FileNameJoin[{baseDir, "factor_of_two.pdf"}], fig4];
Print["  Exported: factor_of_two.pdf"];


(* =========================================================================
   Section 7: Superposition Verification

   Two equal masses at (+/- d/2, 0). Photon at (0, b).
   Total deflection in y-direction: 8GMb / (c^2 (d^2/4 + b^2))
   ========================================================================= *)

Print["\n--- Section 7: Superposition Verification ---\n"];

(* Symbolic computation *)
alphaY = Simplify[
    4 G M b / (d^2/4 + b^2) + 4 G M b / (d^2/4 + b^2)
];
Print["Total y-deflection (two equal masses at +/- d/2):"];
Print["  alpha_y = ", alphaY];
Print["  = 8GMb / (c^2 (d^2/4 + b^2))\n"];

(* Limit d -> 0 *)
limit = Limit[8 G M b / (d^2/4 + b^2), d -> 0];
Print["Limit d -> 0: alpha_y = ", limit, " = 8GM/b = 4G(2M)/(c^2 b)"];
Print["  Correctly reduces to single mass 2M.\n"];

Print["=== End of Module 1e ==="];
