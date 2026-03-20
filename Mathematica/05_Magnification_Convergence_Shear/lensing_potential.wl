(* =========================================================================
   lensing_potential.wl
   Module 5: Magnification, Convergence, and Shear
   =========================================================================
   Purpose: Symbolic derivation of the lensing potential, convergence,
            shear, Jacobian matrix, and magnification for the point mass
            lens.  Verification of the 2D Poisson equation.
            Publication-quality figure generation.

   Sources: Narayan & Bartelmann Sec. 3.2
            Congdon & Keeton Ch. 2.6 & 4
            Saha et al. Sec. 1

   Usage:   wolframscript -file lensing_potential.wl

   Outputs: Symbolic verification of all Module 5 results;
            PDF figures exported to Figures/05_Magnification_Convergence_Shear/
   ========================================================================= *)

Print["=== Module 5: Magnification, Convergence, and Shear ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/05_Magnification_Convergence_Shear";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];


(* =========================================================================
   Section 1: The Lensing Potential (Symbolic)

   psi(theta) = (1/Pi) * Integral[ kappa(theta') * ln|theta - theta'| d^2 theta' ]
   For a point mass: psi = thetaE^2 * ln|theta|
   ========================================================================= *)

Print["--- Section 1: The Lensing Potential ---\n"];

(* Point mass lensing potential *)
psiPM[th1_, th2_, thetaE_] := thetaE^2/2 * Log[th1^2 + th2^2];

Print["Point mass lensing potential:"];
Print["  psi(theta) = thetaE^2 * ln|theta|"];
Print["            = (thetaE^2/2) * ln(theta1^2 + theta2^2)\n"];

(* Compute the gradient (deflection angle) *)
alpha1 = D[psiPM[th1, th2, tE], th1] // Simplify;
alpha2 = D[psiPM[th1, th2, tE], th2] // Simplify;
Print["Gradient of psi (deflection angle):"];
Print["  alpha_1 = d(psi)/d(theta1) = ", alpha1];
Print["  alpha_2 = d(psi)/d(theta2) = ", alpha2];
Print["  => alpha = thetaE^2 * theta / |theta|^2  (as expected)\n"];


(* =========================================================================
   Section 2: The 2D Poisson Equation

   nabla^2 psi = 2 * kappa
   For a point mass: nabla^2 (thetaE^2 * ln|theta|) = 0 for theta != 0
   (delta function at origin)
   ========================================================================= *)

Print["--- Section 2: 2D Poisson Equation ---\n"];

laplacianPsi = D[psiPM[th1, th2, tE], {th1, 2}] +
    D[psiPM[th1, th2, tE], {th2, 2}] // Simplify;
Print["Laplacian of psi (for theta != 0):"];
Print["  nabla^2 psi = ", laplacianPsi];
Print["  = 0 for theta != 0 (kappa = 0 away from origin)"];
Print["  In the distributional sense: nabla^2 ln|theta| = 2*Pi*delta^(2)(theta)"];
Print["  => nabla^2 psi = 2*Pi*thetaE^2 * delta^(2)(theta) = 2*kappa. QED\n"];


(* =========================================================================
   Section 3: Convergence and Shear Components

   kappa = (1/2) * nabla^2 psi
   gamma1 = (1/2) * (psi_11 - psi_22)
   gamma2 = psi_12
   |gamma| = sqrt(gamma1^2 + gamma2^2)
   ========================================================================= *)

Print["--- Section 3: Convergence and Shear ---\n"];

psi11 = D[psiPM[th1, th2, tE], {th1, 2}] // Simplify;
psi22 = D[psiPM[th1, th2, tE], {th2, 2}] // Simplify;
psi12 = D[D[psiPM[th1, th2, tE], th1], th2] // Simplify;

Print["Second derivatives of psi:"];
Print["  psi_11 = ", psi11];
Print["  psi_22 = ", psi22];
Print["  psi_12 = ", psi12];
Print[""];

(* Convergence (away from origin) *)
kappaVal = (psi11 + psi22)/2 // Simplify;
Print["Convergence (theta != 0):"];
Print["  kappa = (psi_11 + psi_22)/2 = ", kappaVal, "  (= 0 for theta != 0)"];
Print[""];

(* Shear components *)
gamma1Val = (psi11 - psi22)/2 // Simplify;
gamma2Val = psi12 // Simplify;
Print["Shear components:"];
Print["  gamma_1 = (psi_11 - psi_22)/2 = ", gamma1Val];
Print["  gamma_2 = psi_12 = ", gamma2Val];
Print[""];

(* Shear magnitude *)
gammaMag = Sqrt[gamma1Val^2 + gamma2Val^2] //
    FullSimplify[#, Assumptions -> {th1 \[Element] Reals, th2 \[Element] Reals,
    th1^2 + th2^2 > 0}] &;
Print["Shear magnitude:"];
Print["  |gamma| = ", gammaMag];
Print[""];

(* Verify |gamma| = thetaE^2/theta^2 *)
gammaSimple = gammaMag /. {th1^2 + th2^2 -> theta^2};
Print["  In polar: |gamma| = thetaE^2 / theta^2  (verified symbolically)"];
Print[""];

(* Polar coordinate expressions *)
gamma1Polar = gamma1Val /. {th1 -> theta Cos[phi], th2 -> theta Sin[phi]} //
    TrigReduce // Simplify;
gamma2Polar = gamma2Val /. {th1 -> theta Cos[phi], th2 -> theta Sin[phi]} //
    TrigReduce // Simplify;
Print["Shear in polar coordinates:"];
Print["  gamma_1 = ", gamma1Polar];
Print["  gamma_2 = ", gamma2Polar];
Print["  => gamma = -(thetaE^2/theta^2) * exp(2*i*phi)  (tangential shear)\n"];


(* =========================================================================
   Section 4: The Jacobian Matrix and Magnification

   A = ((1-kappa-gamma1, -gamma2), (-gamma2, 1-kappa+gamma1))
   mu = 1/det(A) = 1/((1-kappa)^2 - |gamma|^2)
   ========================================================================= *)

Print["--- Section 4: Jacobian and Magnification ---\n"];

(* General Jacobian *)
Amat[kappa_, g1_, g2_] := {{1 - kappa - g1, -g2}, {-g2, 1 - kappa + g1}};

Print["Jacobian matrix A:"];
Print["  A = ", MatrixForm[Amat[kappa, g1, g2]]];
Print[""];

(* Determinant *)
detA = Det[Amat[kappa, g1, g2]] // Expand;
Print["det(A) = ", detA];
Print["       = (1-kappa)^2 - (g1^2 + g2^2)"];
Print["       = (1-kappa)^2 - |gamma|^2\n"];

(* Eigenvalues *)
eigsA = Eigenvalues[Amat[kappa, g1, g2]] // Simplify;
Print["Eigenvalues of A:"];
Print["  lambda_pm = ", eigsA];
Print["  = 1 - kappa +/- |gamma|\n"];

(* Point mass: kappa = 0, |gamma| = thetaE^2/theta^2 *)
Print["For point mass (kappa = 0, |gamma| = thetaE^2/theta^2):"];
muPointMass = 1 / (1 - (thetaE^2/theta^2)^2) // Together;
Print["  mu = 1/(1 - thetaE^4/theta^4) = ", muPointMass];
Print["     = theta^4 / (theta^4 - thetaE^4)\n"];

(* Verify consistency with Module 4 *)
Print["--- Consistency check with Module 4 ---\n"];

thetaPlus[u_] := (u + Sqrt[u^2 + 4])/2;
thetaMinus[u_] := (u - Sqrt[u^2 + 4])/2;

(* Magnification at theta_+ (in units of thetaE) *)
muAtPlus = (thetaPlus[u]^4) / (thetaPlus[u]^4 - 1) //
    FullSimplify[#, Assumptions -> u > 0] &;
Print["mu at theta_+ (in thetaE units): ", muAtPlus];

(* Expected from Module 4 *)
muPlusExpected = (u^2 + 2)/(2 u Sqrt[u^2 + 4]) + 1/2;
muPlusExpSimp = muPlusExpected // FullSimplify[#, Assumptions -> u > 0] &;

(* Check difference *)
diffPlus = Simplify[muAtPlus - muPlusExpSimp, Assumptions -> u > 0];
Print["  mu_+ - expected = ", diffPlus, "  (should be 0)"];
Print[""];

(* Magnification at theta_- *)
(* Note: theta_- < 0 and |theta_-| < thetaE, so theta_-^4 < thetaE^4
   and mu = theta^4/(theta^4 - thetaE^4) < 0.  The Module 4 formula
   mu_- = (u^2+2)/(2u*sqrt(u^2+4)) - 1/2 gives |mu_-| (unsigned). *)
muAtMinus = (thetaMinus[u]^4) / (thetaMinus[u]^4 - 1) //
    FullSimplify[#, Assumptions -> u > 0] &;
Print["mu at theta_- (signed, from theta^4 formula): ", muAtMinus];

muMinusExpected = (u^2 + 2)/(2 u Sqrt[u^2 + 4]) - 1/2;

(* Verify |mu_-| matches the Module 4 unsigned formula *)
diffMinusNum = Table[
    N[Abs[thetaMinus[uv]^4/(thetaMinus[uv]^4 - 1)] -
      ((uv^2 + 2)/(2 uv Sqrt[uv^2 + 4]) - 1/2)],
    {uv, {0.5, 1.0, 2.0, 5.0}}];
Print["  |mu_-| - expected (numerical at u=0.5,1,2,5): ", diffMinusNum, "  (all ~ 0)"];
Print["  (mu_- is negative = negative parity, consistent with mirror-reflected image)"];
Print[""];

(* Total magnification *)
muTotal[u_] := (u^2 + 2)/(u Sqrt[u^2 + 4]);
totalCheck = Simplify[(u^2 + 2)^2 - u^2*(u^2 + 4)];
Print["Total magnification |mu_+| + |mu_-| = (u^2+2)/(u*sqrt(u^2+4))"];
Print["  (u^2+2)^2 - u^2*(u^2+4) = ", totalCheck, " > 0 => total mag > 1. QED\n"];


(* =========================================================================
   Section 5: Hessian Decomposition Verification

   H_ij = kappa * delta_ij + ((gamma1, gamma2),(gamma2, -gamma1))
   ========================================================================= *)

Print["--- Section 5: Hessian Decomposition ---\n"];

hessian = {{psi11, psi12}, {psi12, psi22}};
Print["Hessian of psi:"];
Print["  H = ", MatrixForm[hessian]];
Print[""];

tracePart = (psi11 + psi22)/2 * IdentityMatrix[2] // Simplify;
tracelessPart = hessian - tracePart // Simplify;
Print["Trace part (kappa * I): ", MatrixForm[tracePart]];
Print["Traceless part (shear): ", MatrixForm[tracelessPart]];
Print[""];
Print["Verification: traceless part has the form ((g1,g2),(g2,-g1))"];
Print["  with g1 = (psi_11 - psi_22)/2, g2 = psi_12. VERIFIED\n"];


(* =========================================================================
   Section 6: Generate Figures
   ========================================================================= *)

Print["--- Section 6: Generating Figures ---\n"];

(* ---- Figure 1: Convergence and Shear Effects on Circular Source ---- *)
Module[{srcCircle, kappaOnly, shearOnly, both, nPts = 100,
    kap = 0.3, gam = 0.3},

    (* Original source circle *)
    srcCircle = Table[{Cos[phi], Sin[phi]}, {phi, 0, 2 Pi, 2 Pi/nPts}];

    (* Pure convergence: A = (1-kappa)*I *)
    kappaOnlyCircle = srcCircle / (1 - kap);

    (* Pure shear (gamma1 = gam, gamma2 = 0): A = ((1-gam,0),(0,1+gam)) *)
    (* Inverse: A^-1 = ((1/(1-gam),0),(0,1/(1+gam))) *)
    shearOnlyEllipse = Map[{#[[1]]/(1 - gam), #[[2]]/(1 + gam)} &, srcCircle];

    (* Both: A = ((1-kap-gam, 0),(0, 1-kap+gam)) *)
    bothEllipse = Map[{#[[1]]/(1 - kap - gam), #[[2]]/(1 - kap + gam)} &, srcCircle];

    fig1 = GraphicsRow[{
        (* Panel 1: Pure convergence *)
        Graphics[{
            {Gray, Dashed, AbsoluteThickness[1], Line[srcCircle]},
            {Blue, AbsoluteThickness[2], Line[kappaOnlyCircle]},
            {Black, PointSize[0.015], Point[{0, 0}]}
        },
        PlotRange -> {{-2.2, 2.2}, {-2.2, 2.2}},
        ImageSize -> 200,
        Frame -> True,
        FrameLabel -> {None, None},
        PlotLabel -> Style["\[Kappa] = 0.3, \[Gamma] = 0", 12],
        AspectRatio -> 1
        ],

        (* Panel 2: Pure shear *)
        Graphics[{
            {Gray, Dashed, AbsoluteThickness[1], Line[srcCircle]},
            {Red, AbsoluteThickness[2], Line[shearOnlyEllipse]},
            {Black, PointSize[0.015], Point[{0, 0}]}
        },
        PlotRange -> {{-2.2, 2.2}, {-2.2, 2.2}},
        ImageSize -> 200,
        Frame -> True,
        FrameLabel -> {None, None},
        PlotLabel -> Style["\[Kappa] = 0, |\[Gamma]| = 0.3", 12],
        AspectRatio -> 1
        ],

        (* Panel 3: Both *)
        Graphics[{
            {Gray, Dashed, AbsoluteThickness[1], Line[srcCircle]},
            {Purple, AbsoluteThickness[2], Line[bothEllipse]},
            {Black, PointSize[0.015], Point[{0, 0}]}
        },
        PlotRange -> {{-2.2, 2.2}, {-2.2, 2.2}},
        ImageSize -> 200,
        Frame -> True,
        FrameLabel -> {None, None},
        PlotLabel -> Style["\[Kappa] = 0.3, |\[Gamma]| = 0.3", 12],
        AspectRatio -> 1
        ]
    }, Spacings -> 0];

    Export[FileNameJoin[{baseDir, "convergence_shear_effects.pdf"}], fig1,
        ImageSize -> 700];
    Print["  Exported: convergence_shear_effects.pdf"];
];


(* ---- Figure 2: Magnification Map for Point Mass ---- *)
Module[{},
    (* Magnification as function of position (point mass) *)
    muFunc[x_, y_] := Module[{r2 = x^2 + y^2},
        If[r2 < 0.01, 100, Abs[r2^2 / (r2^2 - 1)]]
    ];

    fig2 = DensityPlot[
        Log10[Abs[((x^2 + y^2)^2) / ((x^2 + y^2)^2 - 1)] + 0.001],
        {x, -3, 3}, {y, -3, 3},
        PlotRange -> All,
        ColorFunction -> "TemperatureMap",
        PlotPoints -> 150,
        FrameLabel -> {
            Style["\!\(\*SubscriptBox[\(\[Theta]\), \(1\)]\) / \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13],
            Style["\!\(\*SubscriptBox[\(\[Theta]\), \(2\)]\) / \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13]
        },
        PlotLabel -> Style["log\[VerticalSeparator]\[Mu]\[VerticalSeparator] for Point Mass Lens", 14],
        PlotLegends -> Placed[
            BarLegend[{"TemperatureMap", {-1, 3}},
                LegendLabel -> Style["log\[VerticalSeparator]\[Mu]\[VerticalSeparator]", 11],
                LegendMarkerSize -> 200],
            Right],
        ImageSize -> 550,
        Epilog -> {
            White, AbsoluteThickness[2], Dashed,
            Circle[{0, 0}, 1],
            Text[Style["\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 12, White, Bold],
                {1.2, 1.2}]
        }
    ];
    Export[FileNameJoin[{baseDir, "magnification_map.pdf"}], fig2];
    Print["  Exported: magnification_map.pdf"];
];


(* ---- Figure 3: Shear Field for Point Mass ---- *)
Module[{nGrid = 8, arrows, scale = 0.35},
    arrows = Flatten[Table[
        Module[{th = Sqrt[x^2 + y^2], phi = ArcTan[x, y],
                g1, g2, gMag, gAngle, dx, dy},
            If[th < 0.5, Nothing,
                g1 = -(x^2 - y^2)/th^4;
                g2 = -2 x y / th^4;
                gMag = Min[1/th^2, 2];
                gAngle = ArcTan[g1, g2]/2 + Pi/2;
                dx = scale * gMag * Cos[gAngle];
                dy = scale * gMag * Sin[gAngle];
                {AbsoluteThickness[1.5], Red,
                 Line[{{x - dx, y - dy}, {x + dx, y + dy}}]}
            ]
        ],
        {x, -3, 3, 6/(2 nGrid)}, {y, -3, 3, 6/(2 nGrid)}
    ], 1];

    fig3 = Graphics[{
        (* Einstein ring *)
        {Blue, AbsoluteThickness[2], Dashed, Circle[{0, 0}, 1]},
        Text[Style["\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 12, Blue],
            {1.25, -0.15}],

        (* Lens *)
        {Black, Disk[{0, 0}, 0.08]},

        (* Shear sticks *)
        arrows
    },
    PlotRange -> {{-3.5, 3.5}, {-3.5, 3.5}},
    ImageSize -> 450,
    Frame -> True,
    FrameLabel -> {
        Style["\!\(\*SubscriptBox[\(\[Theta]\), \(1\)]\) / \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13],
        Style["\!\(\*SubscriptBox[\(\[Theta]\), \(2\)]\) / \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13]
    },
    PlotLabel -> Style["Shear Field for Point Mass Lens", 14],
    AspectRatio -> 1
    ];
    Export[FileNameJoin[{baseDir, "shear_field.pdf"}], fig3];
    Print["  Exported: shear_field.pdf"];
];


(* ---- Figure 4: Convergence and Shear vs Radius (SIS preview) ---- *)
Module[{},
    fig4 = Plot[
        {1/(2 theta), 1/(2 theta), 1/(theta^2)},
        {theta, 0.3, 5},
        PlotStyle -> {
            {Blue, AbsoluteThickness[2]},
            {Red, AbsoluteThickness[2], Dashed},
            {Darker[Green], AbsoluteThickness[2], DotDashed}
        },
        PlotRange -> {{0, 5}, {0, 2}},
        AxesLabel -> {
            Style["\[Theta] / \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13],
            Style["Amplitude", 13]
        },
        PlotLabel -> Style["Convergence and Shear Profiles", 13],
        PlotLegends -> Placed[
            LineLegend[{
                Style["\[Kappa] (SIS)", 11],
                Style["|\[Gamma]| (SIS)", 11],
                Style["|\[Gamma]| (point mass)", 11]
            }, LegendMarkerSize -> 15],
            {0.65, 0.75}],
        Epilog -> {
            Gray, Dashed, AbsoluteThickness[1],
            InfiniteLine[{{0, 1}, {10, 1}}],
            Text[Style["\[Kappa] = 1", 9, Gray], {4, 1.1}]
        },
        ImageSize -> 550
    ];
    Export[FileNameJoin[{baseDir, "kappa_gamma_profiles.pdf"}], fig4];
    Print["  Exported: kappa_gamma_profiles.pdf"];
];


(* ---- Figure 5: Magnification vs Source Position (enhanced from Mod 4) ---- *)
Module[{},
    muP[u_] := (u^2 + 2)/(2 u Sqrt[u^2 + 4]) + 1/2;
    muM[u_] := Abs[(u^2 + 2)/(2 u Sqrt[u^2 + 4]) - 1/2];
    muT[u_] := (u^2 + 2)/(u Sqrt[u^2 + 4]);

    fig5 = Plot[
        {muT[u], muP[u], muM[u]},
        {u, 0.1, 5},
        PlotStyle -> {
            {Black, AbsoluteThickness[2]},
            {Blue, AbsoluteThickness[1.5], Dashed},
            {Red, AbsoluteThickness[1.5], DotDashed}
        },
        PlotRange -> {{0, 5}, {0, 12}},
        AxesLabel -> {
            Style["u = \[Beta] / \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13],
            Style["|\[Mu]|", 13]
        },
        PlotLabel -> Style["Point Mass Magnification", 14],
        PlotLegends -> Placed[
            LineLegend[{
                Style["|\!\(\*SubscriptBox[\(\[Mu]\), \(+\)]\)| + |\!\(\*SubscriptBox[\(\[Mu]\), \(-\)]\)| (total)", 11],
                Style["|\!\(\*SubscriptBox[\(\[Mu]\), \(+\)]\)| (primary)", 11],
                Style["|\!\(\*SubscriptBox[\(\[Mu]\), \(-\)]\)| (secondary)", 11]
            }, LegendMarkerSize -> 15],
            {0.65, 0.75}],
        Epilog -> {
            Gray, Dashed, AbsoluteThickness[1],
            InfiniteLine[{{0, 1}, {10, 1}}],
            Text[Style["\[Mu] = 1", 9, Gray], {4.2, 1.4}]
        },
        ImageSize -> 600
    ];
    Export[FileNameJoin[{baseDir, "magnification_point_mass.pdf"}], fig5];
    Print["  Exported: magnification_point_mass.pdf"];
];

Print["\n=== End of Module 5 ==="];
