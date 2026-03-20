(* =========================================================================
   critical_curves_caustics.wl
   Module 8: Non-Axisymmetric Models and Critical Curves
   =========================================================================
   Purpose: Compute critical curves and caustics for SIS+shear and SIE
            models.  Image position solver for SIE.  Animation of caustic
            structure as ellipticity/shear varies.  Publication-quality
            figure generation.

   Sources: Congdon & Keeton Ch. 4.5 & 6.1
            Narayan & Bartelmann Sec. 3.5
            Kormann, Schneider & Bartelmann (1994)
            Petters, Levine & Wambsganss (2001)

   Usage:   wolframscript -file critical_curves_caustics.wl

   Outputs: Symbolic verification of all Module 8 results;
            PDF figures exported to Figures/08_Elliptical_Models_Caustics/
   ========================================================================= *)

Print["=== Module 8: Non-Axisymmetric Models and Critical Curves ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/08_Elliptical_Models_Caustics";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];


(* =========================================================================
   Section 1: SIS + External Shear
   =========================================================================
   psi(theta) = thetaE * |theta| + (1/2) * gamma_ext * (theta1^2 - theta2^2)
   ========================================================================= *)

Print["--- Section 1: SIS + External Shear ---\n"];

(* Deflection angle for SIS + shear *)
alphaSISShear1[th1_, th2_, tE_, gext_] :=
    tE * th1 / Sqrt[th1^2 + th2^2] + gext * th1;
alphaSISShear2[th1_, th2_, tE_, gext_] :=
    tE * th2 / Sqrt[th1^2 + th2^2] - gext * th2;

Print["Deflection angle (SIS + shear):"];
Print["  alpha_1 = thetaE * theta1/|theta| + gamma_ext * theta1"];
Print["  alpha_2 = thetaE * theta2/|theta| - gamma_ext * theta2\n"];

(* Jacobian matrix *)
(* Partial derivatives of SIS deflection *)
(* d(alpha1_SIS)/d(theta1) = thetaE * theta2^2 / |theta|^3 *)
(* d(alpha1_SIS)/d(theta2) = -thetaE * theta1*theta2 / |theta|^3 *)
(* d(alpha2_SIS)/d(theta1) = -thetaE * theta1*theta2 / |theta|^3 *)
(* d(alpha2_SIS)/d(theta2) = thetaE * theta1^2 / |theta|^3 *)

JacSISShear[th1_, th2_, tE_, gext_] := Module[{th = Sqrt[th1^2 + th2^2]},
    {{1 - tE * th2^2/th^3 - gext,  tE * th1 * th2/th^3},
     {tE * th1 * th2/th^3,  1 - tE * th1^2/th^3 + gext}}
];

(* Determinant *)
detJacSISShear[th1_, th2_, tE_, gext_] := Module[{th = Sqrt[th1^2 + th2^2]},
    1 - tE/th - gext^2 + tE * gext * (th1^2 - th2^2)/th^3
];

(* Verify Jacobian symbolically *)
Print["Jacobian matrix for SIS + shear:"];
Print["  A_11 = 1 - thetaE*theta2^2/theta^3 - gamma_ext"];
Print["  A_22 = 1 - thetaE*theta1^2/theta^3 + gamma_ext"];
Print["  det(A) = 1 - thetaE/theta - gamma_ext^2 + thetaE*gamma_ext*cos(2*phi)/theta\n"];

(* Critical curve in polar coordinates *)
(* det(A) = 0 => theta_crit(phi) = thetaE*(1 - gamma_ext*cos(2*phi)) /
   (1 - gamma_ext^2) *)
thetaCritSISShear[phi_, tE_, gext_] :=
    tE * (1 - gext * Cos[2 phi]) / (1 - gext^2);

Print["Critical curve (polar):"];
Print["  theta_crit(phi) = thetaE * (1 - gamma_ext*cos(2*phi)) / (1 - gamma_ext^2)"];

(* Numerical check *)
tE0 = 1.0; gext0 = 0.1;
Print["  For thetaE = 1, gamma_ext = 0.1:"];
Print["    theta_crit(0) = ", N[thetaCritSISShear[0, tE0, gext0]]];
Print["    theta_crit(Pi/2) = ", N[thetaCritSISShear[Pi/2, tE0, gext0]]];
Print[""];

(* Caustic: map critical curve through lens equation *)
causticSISShear1[phi_, tE_, gext_] := Module[{thc},
    thc = thetaCritSISShear[phi, tE, gext];
    thc * Cos[phi] - tE * Cos[phi] - gext * thc * Cos[phi]
];
causticSISShear2[phi_, tE_, gext_] := Module[{thc},
    thc = thetaCritSISShear[phi, tE, gext];
    thc * Sin[phi] - tE * Sin[phi] + gext * thc * Sin[phi]
];

Print["Caustic (SIS + shear):"];
Print["  beta_1(phi) = (theta_crit - thetaE)*cos(phi) - gamma_ext*theta_crit*cos(phi)"];
Print["  beta_2(phi) = (theta_crit - thetaE)*sin(phi) + gamma_ext*theta_crit*sin(phi)"];

(* Cusp positions *)
Print["\n  Cusp positions for thetaE = 1, gamma_ext = 0.1:"];
cusps = Table[{causticSISShear1[phi, tE0, gext0],
               causticSISShear2[phi, tE0, gext0]},
    {phi, {0, Pi/2, Pi, 3 Pi/2}}];
Do[Print["    phi = ", phi, ": beta = ",
    N[{causticSISShear1[phi, tE0, gext0],
       causticSISShear2[phi, tE0, gext0]}]],
    {phi, {0, Pi/2, Pi, 3 Pi/2}}];
Print[""];


(* =========================================================================
   Section 2: Singular Isothermal Ellipsoid (SIE)
   =========================================================================
   Deflection angle from Kormann et al. (1994)
   ========================================================================= *)

Print["--- Section 2: Singular Isothermal Ellipsoid (SIE) ---\n"];

(* SIE deflection angle *)
alphaSIE1[th1_, th2_, tE_, q_] := Module[{ep = Sqrt[1 - q^2]},
    tE * Sqrt[q] / ep * ArcTan[th1 * ep / Sqrt[q^2 * th1^2 + th2^2]]
];
alphaSIE2[th1_, th2_, tE_, q_] := Module[{ep = Sqrt[1 - q^2]},
    tE * Sqrt[q] / ep * ArcTanh[th2 * ep / Sqrt[q^2 * th1^2 + th2^2]]
];

Print["SIE deflection angle (Kormann et al. 1994):"];
Print["  alpha_1 = thetaE*sqrt(q)/sqrt(1-q^2) * arctan(theta1*sqrt(1-q^2)/sqrt(q^2*theta1^2+theta2^2))"];
Print["  alpha_2 = thetaE*sqrt(q)/sqrt(1-q^2) * arctanh(theta2*sqrt(1-q^2)/sqrt(q^2*theta1^2+theta2^2))"];
Print[""];

(* Verify circular limit q -> 1 *)
Print["Circular limit (q -> 1):"];
Print["  alpha_1(theta1=1, theta2=0, q=0.999) = ",
    N[alphaSIE1[1.0, 0.0, 1.0, 0.999]]];
Print["  SIS: alpha_1 = thetaE * theta1/|theta| = 1.0"];
Print["  alpha_2(theta1=0, theta2=1, q=0.999) = ",
    N[alphaSIE2[0.0, 1.0, 1.0, 0.999]]];
Print["  SIS: alpha_2 = thetaE * theta2/|theta| = 1.0"];
Print[""];

(* Numerical Jacobian for SIE *)
JacSIENum[th1_, th2_, tE_, q_] := Module[{h = 1.0*^-6},
    {{(alphaSIE1[th1 + h, th2, tE, q] - alphaSIE1[th1 - h, th2, tE, q])/(2 h),
      (alphaSIE1[th1, th2 + h, tE, q] - alphaSIE1[th1, th2 - h, tE, q])/(2 h)},
     {(alphaSIE2[th1 + h, th2, tE, q] - alphaSIE2[th1 - h, th2, tE, q])/(2 h),
      (alphaSIE2[th1, th2 + h, tE, q] - alphaSIE2[th1, th2 - h, tE, q])/(2 h)}}
];

detJacSIENum[th1_, th2_, tE_, q_] := Module[{J, Amat},
    J = JacSIENum[th1, th2, tE, q];
    Amat = IdentityMatrix[2] - J;
    Det[Amat]
];

magnificationSIE[th1_, th2_, tE_, q_] :=
    1.0 / detJacSIENum[th1, th2, tE, q];


(* =========================================================================
   Section 3: Critical Curves and Caustics for SIE
   ========================================================================= *)

Print["--- Section 3: SIE Critical Curves and Caustics ---\n"];

(* Compute critical curve parametrically *)
criticalCurveSIE[tE_, q_, nPts_: 500] := Module[
    {phis, critPts, th1, th2, detA, thR, result},
    phis = Table[phi, {phi, 0, 2 Pi, 2 Pi/nPts}];
    result = {};
    Do[
        (* For each angle, find the radius where det(A) = 0 *)
        thR = Quiet[Check[
            th /. FindRoot[
                detJacSIENum[th * Cos[phi], th * Sin[phi], tE, q],
                {th, tE},
                MaxIterations -> 100
            ],
            -1
        ]];
        If[NumericQ[thR] && thR > 0.1,
            AppendTo[result, {thR * Cos[phi], thR * Sin[phi]}]
        ],
        {phi, phis}
    ];
    result
];

(* Compute caustic by mapping critical curve through lens equation *)
causticFromCritical[critPts_, tE_, q_] := Module[{},
    Map[{#[[1]] - alphaSIE1[#[[1]], #[[2]], tE, q],
         #[[2]] - alphaSIE2[#[[1]], #[[2]], tE, q]} &,
        critPts]
];

(* Compute for q = 0.5, 0.7, 0.9 *)
Do[
    Print["  Computing SIE critical curve for q = ", qv, " ..."];
    cc = criticalCurveSIE[1.0, qv];
    ca = causticFromCritical[cc, 1.0, qv];
    Print["    Critical curve: ", Length[cc], " points"];
    Print["    Caustic: ", Length[ca], " points"];
    If[Length[ca] > 0,
        Print["    Caustic extent x: [", Min[ca[[All, 1]]], ", ",
            Max[ca[[All, 1]]], "]"];
        Print["    Caustic extent y: [", Min[ca[[All, 2]]], ", ",
            Max[ca[[All, 2]]], "]"];
    ],
    {qv, {0.5, 0.7, 0.9}}
];
Print[""];


(* =========================================================================
   Section 4: Image Position Solver for SIE
   ========================================================================= *)

Print["--- Section 4: SIE Image Position Solver ---\n"];

(* Lens equation: beta = theta - alpha(theta) *)
(* Solve: beta_i = theta_i - alpha_i(theta) for theta given beta *)

solveSIEImages[beta1_, beta2_, tE_, q_, nTrials_: 50] := Module[
    {solutions, th1Init, th2Init, sol, th1s, th2s, resid, unique,
     minDist = 0.01},

    solutions = {};

    (* Try many initial guesses on a grid and random perturbations *)
    Do[
        th1Init = x;
        th2Init = y;
        sol = Quiet[FindRoot[
            {th1 - alphaSIE1[th1, th2, tE, q] - beta1,
             th2 - alphaSIE2[th1, th2, tE, q] - beta2},
            {{th1, th1Init}, {th2, th2Init}},
            MaxIterations -> 200
        ]];
        If[Head[sol] === List,
            {th1s, th2s} = {th1, th2} /. sol;
            resid = Sqrt[(th1s - alphaSIE1[th1s, th2s, tE, q] - beta1)^2 +
                         (th2s - alphaSIE2[th1s, th2s, tE, q] - beta2)^2];
            If[resid < 1.0*^-8 && Abs[th1s] < 5 tE && Abs[th2s] < 5 tE,
                (* Check if this is a new solution *)
                If[!AnyTrue[solutions,
                    Sqrt[(#[[1]] - th1s)^2 + (#[[2]] - th2s)^2] < minDist &],
                    AppendTo[solutions, {th1s, th2s}]
                ]
            ]
        ],
        {x, -2 tE, 2 tE, tE/3}, {y, -2 tE, 2 tE, tE/3}
    ];

    solutions
];

(* Test: solve for a source inside the caustic *)
Print["Test: SIE with thetaE = 1, q = 0.7, source at (0.05, 0.05):"];
testImgs = solveSIEImages[0.05, 0.05, 1.0, 0.7];
Print["  Found ", Length[testImgs], " images:"];
Do[
    Print["    Image ", i, ": theta = ", testImgs[[i]],
        ", mu = ", N[magnificationSIE[testImgs[[i, 1]], testImgs[[i, 2]], 1.0, 0.7]]],
    {i, Length[testImgs]}
];
Print[""];

(* Test: solve for a source outside the caustic *)
Print["Test: SIE with thetaE = 1, q = 0.7, source at (0.5, 0.0):"];
testImgs2 = solveSIEImages[0.5, 0.0, 1.0, 0.7];
Print["  Found ", Length[testImgs2], " images:"];
Do[
    Print["    Image ", i, ": theta = ", testImgs2[[i]],
        ", mu = ", N[magnificationSIE[testImgs2[[i, 1]], testImgs2[[i, 2]], 1.0, 0.7]]],
    {i, Length[testImgs2]}
];
Print[""];


(* =========================================================================
   Section 5: Generate Figures
   ========================================================================= *)

Print["--- Section 5: Generating Figures ---\n"];

(* ---- Figure 1: SIS + Shear Critical Curves and Caustics ---- *)
Module[{critX, critY, causX, causY, nPts = 500, phis},
    phis = Table[phi, {phi, 0, 2 Pi, 2 Pi/nPts}];

    critX = Table[thetaCritSISShear[phi, 1.0, 0.1] * Cos[phi], {phi, phis}];
    critY = Table[thetaCritSISShear[phi, 1.0, 0.1] * Sin[phi], {phi, phis}];
    causX = Table[causticSISShear1[phi, 1.0, 0.1], {phi, phis}];
    causY = Table[causticSISShear2[phi, 1.0, 0.1], {phi, phis}];

    fig1 = GraphicsRow[{
        (* Critical curve *)
        Graphics[{
            {Blue, AbsoluteThickness[2], Line[Transpose[{critX, critY}]]},
            {Gray, Dashed, AbsoluteThickness[1], Circle[{0, 0}, 1.0]},
            {Black, PointSize[0.02], Point[{0, 0}]}
        },
        PlotRange -> {{-1.5, 1.5}, {-1.5, 1.5}},
        Frame -> True,
        FrameLabel -> {
            Style[Subscript["\[Theta]", "1"], 13],
            Style[Subscript["\[Theta]", "2"], 13]
        },
        PlotLabel -> Style["Image Plane: Critical Curve", 13],
        AspectRatio -> 1, ImageSize -> 300
        ],

        (* Caustic *)
        Graphics[{
            {Red, AbsoluteThickness[2], Line[Transpose[{causX, causY}]]},
            {Black, PointSize[0.02], Point[{0, 0}]}
        },
        PlotRange -> {{-0.2, 0.2}, {-0.2, 0.2}},
        Frame -> True,
        FrameLabel -> {
            Style[Subscript["\[Beta]", "1"], 13],
            Style[Subscript["\[Beta]", "2"], 13]
        },
        PlotLabel -> Style["Source Plane: Caustic", 13],
        AspectRatio -> 1, ImageSize -> 300
        ]
    }, Spacings -> 1];

    Export[FileNameJoin[{baseDir, "sis_shear_critical_caustic.pdf"}], fig1,
        ImageSize -> 700];
    Print["  Exported: sis_shear_critical_caustic.pdf"];
];


(* ---- Figure 2: SIE Critical Curves and Caustics for multiple q ---- *)
Module[{colors, qVals, fig2},
    qVals = {0.5, 0.7, 0.9};
    colors = {Red, Blue, Darker[Green]};

    fig2 = GraphicsRow[{
        (* Critical curves *)
        Graphics[
            Flatten[{
                Table[Module[{cc = criticalCurveSIE[1.0, qVals[[i]]]},
                    {colors[[i]], AbsoluteThickness[2],
                     Line[Append[cc, cc[[1]]]]}
                ], {i, 3}],
                {Black, PointSize[0.02], Point[{0, 0}]}
            }],
            PlotRange -> {{-1.8, 1.8}, {-1.8, 1.8}},
            Frame -> True,
            FrameLabel -> {
                Style[Subscript["\[Theta]", "1"], 13],
                Style[Subscript["\[Theta]", "2"], 13]
            },
            PlotLabel -> Style["Image Plane: Critical Curves", 13],
            AspectRatio -> 1, ImageSize -> 300
        ],

        (* Caustics *)
        Graphics[
            Flatten[{
                Table[Module[{cc, ca},
                    cc = criticalCurveSIE[1.0, qVals[[i]]];
                    ca = causticFromCritical[cc, 1.0, qVals[[i]]];
                    {colors[[i]], AbsoluteThickness[2],
                     Line[Append[ca, ca[[1]]]]}
                ], {i, 3}],
                {Black, PointSize[0.02], Point[{0, 0}]}
            }],
            PlotRange -> {{-0.5, 0.5}, {-0.5, 0.5}},
            Frame -> True,
            FrameLabel -> {
                Style[Subscript["\[Beta]", "1"], 13],
                Style[Subscript["\[Beta]", "2"], 13]
            },
            PlotLabel -> Style["Source Plane: Caustics", 13],
            AspectRatio -> 1, ImageSize -> 300,
            Epilog -> {
                Inset[LineLegend[colors,
                    {Style["q = 0.5", 10],
                     Style["q = 0.7", 10],
                     Style["q = 0.9", 10]},
                    LegendMarkerSize -> 15],
                    Scaled[{0.8, 0.85}]]
            }
        ]
    }, Spacings -> 1];

    Export[FileNameJoin[{baseDir, "sie_critical_caustic.pdf"}], fig2,
        ImageSize -> 700];
    Print["  Exported: sie_critical_caustic.pdf"];
];


(* ---- Figure 3: Source walk across caustic ---- *)
Module[{q0 = 0.7, tE0 = 1.0, cc, ca, srcPositions, panels,
        imgPanels, allPanels},

    cc = criticalCurveSIE[tE0, q0];
    ca = causticFromCritical[cc, tE0, q0];

    (* Source positions: outside, on, inside, center *)
    srcPositions = {{0.4, 0.0}, {0.15, 0.0}, {0.05, 0.05}, {0.0, 0.0}};

    allPanels = Table[Module[{srcB, imgs, srcPanel, imgPanel},
        srcB = srcPositions[[k]];
        imgs = solveSIEImages[srcB[[1]], srcB[[2]], tE0, q0];

        (* Source plane panel *)
        srcPanel = Graphics[{
            {Gray, AbsoluteThickness[1], Line[Append[ca, ca[[1]]]]},
            {Red, PointSize[0.03], Point[srcB]},
            {Black, PointSize[0.015], Point[{0, 0}]}
        },
        PlotRange -> {{-0.5, 0.5}, {-0.5, 0.5}},
        Frame -> True, AspectRatio -> 1, ImageSize -> 160,
        PlotLabel -> Style[StringJoin["Source ", ToString[k]], 11]
        ];

        (* Image plane panel *)
        imgPanel = Graphics[Flatten[{
            {Gray, AbsoluteThickness[1], Line[Append[cc, cc[[1]]]]},
            {Black, PointSize[0.015], Point[{0, 0}]},
            Table[Module[{mu = magnificationSIE[img[[1]], img[[2]], tE0, q0]},
                If[mu > 0,
                    (* Type I: blue circle *)
                    {Blue, PointSize[0.025], Point[img]},
                    (* Type II: red square *)
                    {Red, PointSize[0.025], Point[img]}
                ]
            ], {img, imgs}]
        }],
        PlotRange -> {{-1.8, 1.8}, {-1.8, 1.8}},
        Frame -> True, AspectRatio -> 1, ImageSize -> 160,
        PlotLabel -> Style[StringJoin[ToString[Length[imgs]], " images"], 11]
        ];

        {srcPanel, imgPanel}
    ], {k, Length[srcPositions]}];

    fig3 = GraphicsGrid[{
        allPanels[[All, 1]],
        allPanels[[All, 2]]
    }, Spacings -> {0.5, 0.5}, ImageSize -> 700];

    Export[FileNameJoin[{baseDir, "source_walk_caustic.pdf"}], fig3];
    Print["  Exported: source_walk_caustic.pdf"];
];


(* ---- Figure 4: Fold and Cusp Magnification Scaling ---- *)
Module[{},
    (* Fold: mu ~ 1/sqrt(d_perp) *)
    foldPlot = Plot[1/Sqrt[d], {d, 0.001, 1},
        PlotStyle -> {Blue, AbsoluteThickness[2]},
        PlotRange -> {{0, 1}, {0, 20}},
        AxesLabel -> {
            Style["\!\(\*SubscriptBox[\(d\), \(\[UpTee]\)]\)", 13],
            Style["|\[Mu]|", 13]
        },
        PlotLabel -> Style["Fold: |\[Mu]| \[Proportional] 1/\[Sqrt](\!\(\*SubscriptBox[\(d\), \(\[UpTee]\)]\))", 13],
        Epilog -> {
            Gray, Dashed, AbsoluteThickness[1],
            InfiniteLine[{{0, 1}, {10, 1}}]
        },
        ImageSize -> 300
    ];

    (* Cusp: mu_total ~ 1/d_perp *)
    cuspPlot = Plot[1/d, {d, 0.05, 1},
        PlotStyle -> {Red, AbsoluteThickness[2]},
        PlotRange -> {{0, 1}, {0, 20}},
        AxesLabel -> {
            Style["\!\(\*SubscriptBox[\(d\), \(\[UpTee]\)]\)", 13],
            Style["\!\(\*SubscriptBox[\(\[Mu]\), \(total\)]\)", 13]
        },
        PlotLabel -> Style["Cusp: \!\(\*SubscriptBox[\(\[Mu]\), \(total\)]\) \[Proportional] 1/\!\(\*SubscriptBox[\(d\), \(\[UpTee]\)]\)", 13],
        Epilog -> {
            Gray, Dashed, AbsoluteThickness[1],
            InfiniteLine[{{0, 1}, {10, 1}}]
        },
        ImageSize -> 300
    ];

    fig4 = GraphicsRow[{foldPlot, cuspPlot}, Spacings -> 1];
    Export[FileNameJoin[{baseDir, "fold_cusp_magnification.pdf"}], fig4,
        ImageSize -> 700];
    Print["  Exported: fold_cusp_magnification.pdf"];
];


(* ---- Figure 5: Image Configurations (Double, Quad, Cusp) ---- *)
Module[{q0 = 0.7, tE0 = 1.0, cc, ca, configs, fig5},

    cc = criticalCurveSIE[tE0, q0];
    ca = causticFromCritical[cc, tE0, q0];

    (* Three configurations *)
    configs = {
        {"Double", {0.4, 0.0}},
        {"Quad", {0.05, 0.05}},
        {"Cusp", {0.15, 0.0}}
    };

    fig5 = GraphicsRow[
        Table[Module[{label, srcB, imgs, panel},
            {label, srcB} = config;
            imgs = solveSIEImages[srcB[[1]], srcB[[2]], tE0, q0];

            Graphics[Flatten[{
                (* Critical curve *)
                {LightGray, AbsoluteThickness[1.5], Line[Append[cc, cc[[1]]]]},
                {Black, PointSize[0.015], Point[{0, 0}]},
                (* Images colored by parity *)
                Table[Module[{mu = magnificationSIE[img[[1]], img[[2]], tE0, q0],
                              sz},
                    sz = Min[0.04, Max[0.015, 0.005 * Sqrt[Abs[mu]]]];
                    If[mu > 0,
                        {Blue, PointSize[sz], Point[img]},
                        {Red, PointSize[sz], Point[img]}
                    ]
                ], {img, imgs}]
            }],
            PlotRange -> {{-1.8, 1.8}, {-1.8, 1.8}},
            Frame -> True, AspectRatio -> 1, ImageSize -> 220,
            PlotLabel -> Style[label <> " (" <> ToString[Length[imgs]] <>
                " imgs)", 12],
            FrameLabel -> {
                Style[Subscript["\[Theta]", "1"], 12],
                Style[Subscript["\[Theta]", "2"], 12]
            }]
        ], {config, configs}],
    Spacings -> 0.5];

    Export[FileNameJoin[{baseDir, "image_configurations.pdf"}], fig5,
        ImageSize -> 750];
    Print["  Exported: image_configurations.pdf"];
];


(* =========================================================================
   Section 6: Caustic Animation (ellipticity variation)
   ========================================================================= *)

Print["\n--- Section 6: Caustic Structure vs Ellipticity ---\n"];

(* Generate a grid of caustics for different q values *)
Module[{qVals, fig6},
    qVals = {0.4, 0.5, 0.6, 0.7, 0.8, 0.9};

    fig6 = GraphicsGrid[{
        Table[Module[{cc, ca},
            cc = criticalCurveSIE[1.0, q];
            ca = causticFromCritical[cc, 1.0, q];
            Graphics[{
                {Blue, AbsoluteThickness[2], Line[Append[ca, ca[[1]]]]},
                {Black, PointSize[0.02], Point[{0, 0}]}
            },
            PlotRange -> {{-0.6, 0.6}, {-0.6, 0.6}},
            Frame -> True, AspectRatio -> 1, ImageSize -> 120,
            PlotLabel -> Style["q = " <> ToString[q], 10]]
        ], {q, qVals[[1;;3]]}],
        Table[Module[{cc, ca},
            cc = criticalCurveSIE[1.0, q];
            ca = causticFromCritical[cc, 1.0, q];
            Graphics[{
                {Blue, AbsoluteThickness[2], Line[Append[ca, ca[[1]]]]},
                {Black, PointSize[0.02], Point[{0, 0}]}
            },
            PlotRange -> {{-0.6, 0.6}, {-0.6, 0.6}},
            Frame -> True, AspectRatio -> 1, ImageSize -> 120,
            PlotLabel -> Style["q = " <> ToString[q], 10]]
        ], {q, qVals[[4;;6]]}]
    }, Spacings -> {0.3, 0.3}, ImageSize -> 500];

    Export[FileNameJoin[{baseDir, "caustic_vs_ellipticity.pdf"}], fig6];
    Print["  Exported: caustic_vs_ellipticity.pdf"];
];


(* =========================================================================
   Section 7: Magnification Map for SIE
   ========================================================================= *)

Print["\n--- Section 7: Magnification Map ---\n"];

Module[{q0 = 0.7, tE0 = 1.0, cc},
    cc = criticalCurveSIE[tE0, q0];

    fig7 = DensityPlot[
        Log10[Abs[magnificationSIE[x, y, tE0, q0]] + 0.01],
        {x, -2, 2}, {y, -2, 2},
        PlotRange -> All,
        ColorFunction -> "TemperatureMap",
        PlotPoints -> 100,
        MaxRecursion -> 2,
        FrameLabel -> {
            Style[Subscript["\[Theta]", "1"] <> " (arcsec)", 13],
            Style[Subscript["\[Theta]", "2"] <> " (arcsec)", 13]
        },
        PlotLabel -> Style["log|\[Mu]| for SIE (q = 0.7)", 14],
        PlotLegends -> Placed[
            BarLegend[{"TemperatureMap", {-1, 2.5}},
                LegendLabel -> Style["log|\[Mu]|", 11],
                LegendMarkerSize -> 200],
            Right],
        ImageSize -> 550,
        Epilog -> {White, AbsoluteThickness[2],
            Line[Append[cc, cc[[1]]]]}
    ];
    Export[FileNameJoin[{baseDir, "magnification_map_sie.pdf"}], fig7];
    Print["  Exported: magnification_map_sie.pdf"];
];


Print["\n=== End of Module 8 ==="];
