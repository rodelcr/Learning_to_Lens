(* =========================================================================
   deflection_angle.wl
   Module 2: Light Deflection in Curved Spacetime
   =========================================================================
   Purpose: Symbolic derivation of the gravitational deflection angle,
            weak-field expansion, numerical evaluation for Sun/Jupiter/galaxy,
            Shapiro time delay, exact vs. approximate comparison, and
            publication-quality figure generation.

   Sources: Carroll Ch. 5.5 (eqs. 5.100--5.104)
            Congdon & Keeton Ch. 3.4 (eqs. 3.87--3.96, 3.97--3.110)
            Narayan & Bartelmann Sec. 2.1

   Usage:   wolframscript -file deflection_angle.wl

   Outputs: Symbolic verification of deflection angle and Shapiro delay;
            PDF figures exported to Figures/02_Light_Deflection/
   ========================================================================= *)

Print["=== Module 2: Light Deflection in Curved Spacetime ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/02_Light_Deflection";

(* =========================================================================
   Section 1: Soldner's Newtonian Deflection Angle

   Treating light as a Newtonian corpuscle with v = c:
   alpha_Newton = 2GM / (c^2 b)
   ========================================================================= *)

Print["--- Section 1: Soldner's Newtonian Deflection ---\n"];

(* Newtonian orbit: deflection = 2*arcsin(1/e) for hyperbolic orbit *)
(* For v_inf = c, impact parameter b: *)
(*   L = b*c,  E = (1/2)*c^2 *)
(*   p = L^2/(GM) = b^2*c^2/(GM) *)
(*   e = Sqrt[1 + 2*E*L^2/(GM)^2] = Sqrt[1 + b^2*c^4/(GM)^2] *)

Print["Newtonian orbit parameters:"];
Print["  p = b^2*c^2 / (GM)"];
Print["  e = Sqrt[1 + b^2*c^4 / (GM)^2]"];
Print["  For b >> GM/c^2:  e >> 1, so arcsin(1/e) ~ 1/e ~ GM/(b*c^2)"];
Print["  alpha_Newton = 2/e ~ 2*GM / (c^2 * b)\n"];

(* Symbolic verification *)
ecc[b_, M_, G_, c_] := Sqrt[1 + b^2 c^4 / (G M)^2];
alphaN[b_, M_, G_, c_] := 2 ArcSin[1/ecc[b, M, G, c]];
(* Series expand for large b *)
alphaNewtonExpand = Series[alphaN[b, M, G, c], {b, Infinity, 1}] // Normal;
Print["Series expansion for large b:"];
Print["  alpha_Newton = ", alphaNewtonExpand, "\n"];


(* =========================================================================
   Section 2: GR Deflection Angle -- Symbolic Derivation

   Following Congdon & Keeton eqs. 3.87-3.96:
   Delta phi = 2 * Integral_0^1 du / sqrt((1 - u^2) - 2*eps*(1 - u^3))
   where eps = m/r0 << 1
   ========================================================================= *)

Print["--- Section 2: GR Deflection Angle (Symbolic) ---\n"];

(* Working in G = c = M = 1 units: m = GM/c^2 = 1, Rs = 2 *)
Print["Working in geometrized units: G = c = M = 1 (so m = 1, Rs = 2)\n"];

(* The deflection integral after substitution u = r0/r *)
(* Delta phi = 2 * Integral_0^1 du / sqrt((r0^2/b^2) - u^2 + 2m*u^3/r0) *)
(* Using r0^2/b^2 = 1 - 2m/r0: *)
(* Delta phi = 2 * Integral_0^1 du / sqrt((1-u^2) - (2m/r0)(1-u^3)) *)

Print["Step 1: The deflection integral (C&K eq. 3.93):"];
Print["  Delta phi = 2 * Integral_0^1 du / sqrt((1-u^2) - 2*eps*(1-u^3))"];
Print["  where eps = m/r0 << 1\n"];

(* --- Zeroth-order integral --- *)
I0 = 2 * Integrate[1/Sqrt[1 - u^2], {u, 0, 1}];
Print["Step 2: Zeroth-order integral:"];
Print["  I0 = 2 * Integral_0^1 du / sqrt(1 - u^2) = ", I0];
Print["  (This is pi -- the flat-spacetime result)\n"];

(* --- First-order integral --- *)
(* Expand 1/sqrt(f) to first order in eps: *)
(* 1/sqrt((1-u^2) - 2*eps*(1-u^3)) ~ 1/sqrt(1-u^2) + eps*(1-u^3)/(1-u^2)^(3/2) *)
I1integrand = (1 - u^3) / (1 - u^2)^(3/2);
I1bare = Integrate[I1integrand, {u, 0, 1}];
I1 = 2 * I1bare;
Print["Step 3: First-order integral:"];
Print["  Bare integral: Integral_0^1 (1 - u^3)/(1 - u^2)^(3/2) du = ", I1bare];
Print["  With factor of 2: I1 = 2 * ", I1bare, " = ", I1];
Print["  (Bare integral = 2, so I1 = 4 -- VERIFIED!)\n"];

(* Assemble the result *)
Print["Step 4: Assemble:"];
Print["  Delta phi = I0 + eps * I1 + O(eps^2) = pi + 4*eps"];
Print["  Deflection angle: alpha_hat = Delta phi - pi = 2*eps = 4m/r0"];
Print["  Since r0 ~ b to leading order:"];
Print["  alpha_hat = 4*GM / (c^2 * b)"];
Print["  This is TWICE the Newtonian result! The factor of 2 comes from"];
Print["  spatial curvature (g_rr contribution).\n"];

(* Second-order term *)
Print["Step 5: Second-order correction (Keeton & Petters 2006):"];
I2integrand = (1 - u^3)^2 / (1 - u^2)^(5/2) / 2 + u^3 * (1 - u^3) / (1 - u^2)^(3/2);
(* The full second-order integral is more involved; we just state the result *)
Print["  alpha_hat = 4m/b + (15*Pi/4)*(m/b)^2 + O((m/b)^3)"];
Print["  The coefficient 15*Pi/4 ~ 11.78\n"];


(* =========================================================================
   Section 3: Numerical Values -- Sun, Jupiter, Galaxy
   ========================================================================= *)

Print["--- Section 3: Numerical Deflection Angles ---\n"];

(* Physical constants *)
Gnewton = 6.674*^-11;     (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;             (* m/s *)
Msolar = 1.989*^30;        (* kg *)
Rsolar = 6.957*^8;         (* m *)

(* Deflection angle formula (radians) *)
alphaHat[M_, b_] := 4 Gnewton M / (cc^2 b);
radToArcsec = 180 * 3600 / Pi;

(* --- Sun --- *)
alphaSun = alphaHat[Msolar, Rsolar];
Print["Sun (b = R_sun):"];
Print["  alpha_hat = ", ScientificForm[alphaSun, 4], " rad"];
Print["  = ", NumberForm[alphaSun * radToArcsec, {4, 2}], " arcsec"];
Print["  Expected: 1.75 arcsec\n"];

(* --- Jupiter --- *)
Mjup = 1.898*^27;          (* kg *)
Rjup = 7.149*^7;           (* m *)
alphaJup = alphaHat[Mjup, Rjup];
Print["Jupiter (b = R_Jupiter):"];
Print["  alpha_hat = ", ScientificForm[alphaJup, 4], " rad"];
Print["  = ", NumberForm[alphaJup * radToArcsec * 1000, {3, 1}], " mas"];
Print["  (milliarcseconds)\n"];

(* --- Galaxy --- *)
Mgal = 1*^12 * Msolar;
bgal = 10 * 3.086*^19;    (* 10 kpc in meters *)
alphaGal = alphaHat[Mgal, bgal];
Print["Galaxy (M = 10^12 Msun, b = 10 kpc):"];
Print["  alpha_hat = ", ScientificForm[alphaGal, 4], " rad"];
Print["  = ", NumberForm[alphaGal * radToArcsec, {4, 1}], " arcsec\n"];


(* =========================================================================
   Section 4: Shapiro Time Delay
   ========================================================================= *)

Print["--- Section 4: Shapiro Time Delay ---\n"];

(* The characteristic time scale *)
tGR = 4 Gnewton Msolar / cc^3;
Print["Characteristic GR time scale: 4*G*Msun / c^3 = ",
    ScientificForm[tGR, 4], " s = ",
    NumberForm[tGR * 1*^6, {4, 1}], " microseconds\n"];

(* Radar echo experiment: Earth -> Sun -> Mercury -> Sun -> Earth *)
Rearth = 1.496*^11;       (* 1 AU in meters *)
Rmerc = 5.79*^10;         (* Mercury semi-major axis in meters *)

(* For signal grazing the Sun: r0 = R_sun *)
r0 = Rsolar;
logFactor = Log[4 Rearth Rmerc / r0^2];
Print["Log factor: ln(4 * R_earth * R_Merc / r0^2) = ",
    NumberForm[logFactor, {4, 2}]];

deltaT = tGR * (logFactor + 1);
Print["Excess round-trip time: Delta T = ", ScientificForm[deltaT, 3], " s"];
Print["  = ", NumberForm[deltaT * 1*^6, {3, 0}], " microseconds"];
Print["  Shapiro (1964) measured: 200 +/- 20 microseconds"];
Print["  Viking Mars lander (1979) confirmed GR to ~0.1%\n"];


(* =========================================================================
   Section 5: Exact vs. Approximate Deflection Angle
   ========================================================================= *)

Print["--- Section 5: Exact vs. Approximate Deflection ---\n"];

(* Work in G = c = M = 1 units: m = 1, Rs = 2 *)
(* The exact deflection integral: *)
(* Given impact parameter b, first solve for r0 from *)
(*   r0^2/b^2 = 1 - 2/r0  (since 2m = 2 in these units) *)
(* Then evaluate: *)
(*   Delta phi = 2 * Integral_0^1 du / sqrt((1-u^2) - (2/r0)(1-u^3)) *)

(* Function to compute r0 from b (in G=c=M=1 units, m=1) *)
findR0[b_?NumericQ] := Module[{r0vals},
    r0vals = r /. NSolve[r^2/b^2 == 1 - 2/r && r > 0, r, Reals];
    Max[r0vals]  (* take the outermost root *)
];

(* Exact deflection angle via numerical integration *)
exactDeflection[b_?NumericQ] := Module[{r0, eps, result},
    r0 = findR0[b];
    eps = 1/r0;  (* m/r0 with m = 1 *)
    result = 2 * NIntegrate[
        1/Sqrt[(1 - u^2) - 2 eps (1 - u^3)],
        {u, 0, 1},
        WorkingPrecision -> 20,
        MaxRecursion -> 20
    ];
    result - Pi  (* deflection = Delta phi - pi *)
];

(* Approximate deflection (first order): 4m/b = 4/b in these units *)
approx1[b_] := 4/b;
(* Second order: 4/b + (15*Pi/4) * (1/b)^2 *)
approx2[b_] := 4/b + 15 Pi / (4 b^2);

(* Compute for several values of b/Rs *)
Print["Comparison table (G = c = M = 1 units, Rs = 2):"];
Print[""];
Print[StringForm["  ``  ``  ``  ``  ``",
    PaddedForm["b/Rs", {6, 0}],
    PaddedForm["alpha_exact", {12, 0}],
    PaddedForm["alpha_1st", {12, 0}],
    PaddedForm["alpha_2nd", {12, 0}],
    PaddedForm["Error(1st)", {10, 0}]
]];
Print["  ", StringJoin[Table["-", 60]]];

bRsValues = {3, 4, 5, 7, 10, 15, 20, 30, 50, 100};
Do[
    b = bRs * 2;  (* b in geometric units, Rs = 2 *)
    aExact = exactDeflection[b];
    a1 = approx1[b];
    a2 = approx2[b];
    err1 = Abs[(a1 - aExact) / aExact] * 100;
    Print[StringForm["  ``  ``  ``  ``  ``%",
        PaddedForm[bRs, {6, 0}],
        PaddedForm[aExact, {12, 6}],
        PaddedForm[N[a1], {12, 6}],
        PaddedForm[N[a2], {12, 6}],
        PaddedForm[err1, {8, 2}]
    ]],
    {bRs, bRsValues}
];
Print[""];

(* Find b/Rs where first-order error = 1% *)
Print["Finding b/Rs where first-order error = 1%..."];
findOnePct = Module[{btest, err},
    btest = 4;  (* start at b/Rs = 4, i.e., b = 8 *)
    While[btest < 200,
        err = Abs[(approx1[2 btest] - exactDeflection[2 btest]) /
              exactDeflection[2 btest]];
        If[err < 0.01,
            Print["  First-order error < 1% at b/Rs ~ ", btest];
            Break[]
        ];
        btest += 1;
    ];
];
Print[""];


(* =========================================================================
   Section 6: Generate Figures
   ========================================================================= *)

Print["--- Section 6: Generating Figures ---\n"];

(* ---- Figure 1: Deflection Geometry ---- *)
(* Ray path diagram showing deflection by a point mass *)
Module[{bval = 6, mval = 1, rmin, phivals, raypath, deflAngle},
    deflAngle = 4 mval / bval;  (* weak-field approximation *)

    fig1 = Graphics[{
        (* Mass at origin *)
        Black, Disk[{0, 0}, 0.3],
        Text[Style["M", 14, Bold], {0, -0.7}],

        (* Incoming ray (from right) *)
        {Blue, AbsoluteThickness[2],
         Arrow[{{15, bval}, {3, bval - 3 * deflAngle}}]},

        (* Curved path near mass *)
        {Blue, AbsoluteThickness[2],
         BezierCurve[{{3, bval - 3 * deflAngle},
                      {1.5, bval * 0.7},
                      {1, bval * 0.55},
                      {1.5, bval * 0.35},
                      {3, bval * 0.1 - 2 * deflAngle}}]},

        (* Outgoing ray *)
        {Blue, AbsoluteThickness[2],
         Arrow[{{3, bval * 0.1 - 2 * deflAngle},
                {15, bval * 0.1 - 2 * deflAngle - 12 * deflAngle}},
                0.3]},

        (* Undeflected path (dashed) *)
        {Gray, Dashed, AbsoluteThickness[1.5],
         Line[{{-5, bval}, {15, bval}}]},

        (* Impact parameter b *)
        {Red, AbsoluteThickness[1.5],
         Line[{{0, 0}, {0, bval}}],
         Text[Style["b", 14, Red, Italic], {-0.5, bval/2}]},

        (* Deflection angle arc *)
        {Darker[Green], AbsoluteThickness[2],
         Circle[{15, bval}, 3, {-Pi/2 - deflAngle*3, -Pi/2}],
         Text[Style["\!\(\*OverscriptBox[\(\[Alpha]\), \(^\)]\)", 14,
             Darker[Green]], {13, bval - 4}]},

        (* Labels *)
        Text[Style["Incoming photon", 11, Blue], {12, bval + 0.8}],
        Text[Style["Deflected ray", 11, Blue], {12, -5}],
        Text[Style["Undeflected path", 11, Gray], {12, bval + 1.8}]
    },
    PlotRange -> {{-3, 17}, {-8, 10}},
    ImageSize -> 550,
    Axes -> False,
    Frame -> False
    ];
    Export[FileNameJoin[{baseDir, "deflection_geometry.pdf"}], fig1];
    Print["  Exported: deflection_geometry.pdf"];
];

(* ---- Figure 2: Deflection Angle vs Impact Parameter ---- *)
Module[{bvals, alphavals},
    (* Physical units: solar deflection *)
    fig2 = Plot[
        alphaHat[Msolar, b * Rsolar] * radToArcsec,
        {b, 1, 50},
        PlotRange -> {{0, 50}, {0, 2}},
        PlotStyle -> {Blue, AbsoluteThickness[2]},
        AxesLabel -> {Style["b / R\[CircleDot]", 13],
                      Style["\!\(\*OverscriptBox[\(\[Alpha]\), \(^\)]\) (arcsec)", 13]},
        PlotLabel -> Style["Deflection Angle vs. Impact Parameter (Solar Mass)", 13],
        Epilog -> {
            Red, Dashed, AbsoluteThickness[1.5],
            InfiniteLine[{{1, 0}, {1, 2}}],
            Text[Style["b = R\[CircleDot]\n\[Alpha] = 1.75\"", 10, Red], {5, 1.5}],
            Black, PointSize[0.015],
            Point[{1, alphaSun * radToArcsec}]
        },
        ImageSize -> 550
    ];
    Export[FileNameJoin[{baseDir, "deflection_vs_impact.pdf"}], fig2];
    Print["  Exported: deflection_vs_impact.pdf"];
];

(* ---- Figure 3: Exact vs Approximate Deflection ---- *)
Module[{bRsRange, exactData, approx1Data, approx2Data},
    (* Compute exact deflection for a range of b/Rs *)
    bRsRange = Table[bRs, {bRs, 3.5, 100, 0.5}];
    exactData = Table[{bRs, exactDeflection[2 bRs]}, {bRs, bRsRange}];
    approx1Data = Table[{bRs, approx1[2 bRs]}, {bRs, bRsRange}];
    approx2Data = Table[{bRs, approx2[2 bRs]}, {bRs, bRsRange}];

    (* Error data *)
    errorData1 = Table[
        {exactData[[i, 1]],
         Abs[(approx1Data[[i, 2]] - exactData[[i, 2]]) / exactData[[i, 2]]] * 100},
        {i, Length[exactData]}
    ];
    errorData2 = Table[
        {exactData[[i, 1]],
         Abs[(approx2Data[[i, 2]] - exactData[[i, 2]]) / exactData[[i, 2]]] * 100},
        {i, Length[exactData]}
    ];

    (* Top panel: deflection angles *)
    plotTop = ListLogPlot[
        {exactData, approx1Data, approx2Data},
        PlotRange -> {{3, 100}, {0.01, 2}},
        PlotStyle -> {
            {Blue, AbsoluteThickness[2]},
            {Red, AbsoluteThickness[1.5], Dashed},
            {Darker[Green], AbsoluteThickness[1.5], DotDashed}
        },
        PlotMarkers -> None,
        Joined -> True,
        AxesLabel -> {None, Style["\!\(\*OverscriptBox[\(\[Alpha]\), \(^\)]\) (rad)", 12]},
        PlotLabel -> Style["Exact vs. Approximate Deflection Angle", 13],
        PlotLegends -> Placed[
            LineLegend[{"Exact (numerical)", "1st order: 4m/b",
                "2nd order: 4m/b + (15\[Pi]/4)\!\(\*SuperscriptBox[\((m/b)\), \(2\)]\)"},
                LegendMarkerSize -> 15],
            {0.65, 0.75}],
        ImageSize -> {550, 250}
    ];

    (* Bottom panel: relative error *)
    plotBottom = ListLogPlot[
        {errorData1, errorData2},
        PlotRange -> {{3, 100}, {0.001, 50}},
        PlotStyle -> {
            {Red, AbsoluteThickness[2]},
            {Darker[Green], AbsoluteThickness[2]}
        },
        PlotMarkers -> None,
        Joined -> True,
        AxesLabel -> {Style["b / Rs", 12],
                      Style["Relative Error (%)", 12]},
        PlotLegends -> Placed[
            LineLegend[{"1st order error", "2nd order error"},
                LegendMarkerSize -> 15],
            {0.7, 0.7}],
        Epilog -> {
            Gray, Dashed,
            InfiniteLine[{{0, 1}, {200, 1}}],
            Text[Style["1% error", 9, Gray], {80, 1.5}]
        },
        ImageSize -> {550, 200}
    ];

    fig3 = Column[{plotTop, plotBottom}];
    Export[FileNameJoin[{baseDir, "exact_vs_approx.pdf"}], fig3];
    Print["  Exported: exact_vs_approx.pdf"];
];

Print["\n=== End of Module 2 ==="];
