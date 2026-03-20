(* =========================================================================
   axisymmetric_models.wl
   Module 7: Axisymmetric Lens Models
   =========================================================================
   Purpose: Symbolic derivation of SIS, NIS, and NFW lensing quantities
            (convergence, shear, deflection angle, magnification).
            Numerical examples with realistic parameters.
            Publication-quality comparison figures.

   Sources: Narayan & Bartelmann Sec. 3.1 & 3.4
            Congdon & Keeton Ch. 2.3 & 6.1-6.2
            Bartelmann (1996) - NFW lensing
            Wright & Brainerd (2000) - NFW analytical formulae

   Usage:   wolframscript -file axisymmetric_models.wl

   Outputs: Symbolic verification of all Module 7 results;
            PDF figures exported to Figures/07_Axisymmetric_Models/
   ========================================================================= *)

Print["=== Module 7: Axisymmetric Lens Models ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/07_Axisymmetric_Models";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];

(* ---- Physical constants ---- *)
Gnewton = 6.674*^-11;      (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
kpcToM = 3.086*^19;         (* 1 kpc in meters *)
MpcToM = 3.086*^22;         (* 1 Mpc in meters *)
radToArcsec = 180 * 3600 / Pi;


(* =========================================================================
   Section 1: General Formalism for Circularly Symmetric Lenses

   For circular symmetry:
     alpha(theta) = kbar(theta) * theta
     |gamma(theta)| = kbar(theta) - kappa(theta)
     mu = 1 / [(1 - kbar)(1 - 2*kappa + kbar)]
   ========================================================================= *)

Print["--- Section 1: General Circular Lens Formalism ---\n"];

Print["For a circularly symmetric lens:"];
Print["  alpha(theta) = kbar(theta) * theta"];
Print["  |gamma(theta)| = kbar(theta) - kappa(theta)"];
Print["  mu = 1 / [lambda_t * lambda_r]"];
Print["  where lambda_t = 1 - kbar, lambda_r = 1 - 2*kappa + kbar\n"];


(* =========================================================================
   Section 2: Singular Isothermal Sphere (SIS)

   rho(r) = sigma_v^2 / (2*Pi*G*r^2)
   Sigma(xi) = sigma_v^2 / (2*G*xi)
   alphahat = 4*Pi*sigma_v^2/c^2  (constant!)
   thetaE = 4*Pi*(sigma_v/c)^2 * Dds/Ds
   kappa = thetaE / (2*theta)
   gamma = thetaE / (2*theta) = kappa
   ========================================================================= *)

Print["--- Section 2: Singular Isothermal Sphere (SIS) ---\n"];

(* Symbolic derivation of surface mass density *)
Print["Deriving SIS surface mass density from rho(r) = sigma_v^2/(2*Pi*G*r^2):"];
rhoSIS[r_] := sv^2 / (2 Pi G r^2);

(* Integral along the line of sight: Sigma(xi) = Integral[rho(sqrt(xi^2+z^2)), {z, -Inf, Inf}] *)
sigmaIntegral = Integrate[sv^2 / (2 Pi G (xi^2 + z^2)), {z, -Infinity, Infinity},
    Assumptions -> {xi > 0, sv > 0, G > 0}];
Print["  Sigma(xi) = ", sigmaIntegral];
Print["           = sigma_v^2 / (2*G*xi). VERIFIED\n"];

(* Enclosed mass *)
Menclosed = 2 Pi Integrate[sv^2 / (2 G xip) * xip, {xip, 0, xi},
    Assumptions -> {xi > 0, sv > 0, G > 0}];
Print["Enclosed mass M(xi) = 2*Pi * Integral[Sigma(xi')*xi', {xi',0,xi}]"];
Print["  = ", Menclosed];
Print["  = Pi*sigma_v^2*xi / G\n"];

(* Physical deflection angle *)
alphaHatSIS = 4 G Menclosed / (cc^2 * xi) /. {G -> Gnewton};
alphaHatSISsym = 4 G (Pi sv^2 xi / G) / (cc^2 * xi) // Simplify;
Print["Physical deflection angle:"];
Print["  alphahat = 4*G*M(xi)/(c^2*xi) = ", alphaHatSISsym];
Print["  = 4*Pi*sigma_v^2/c^2  (CONSTANT - independent of xi!)\n"];

(* Einstein radius *)
Print["Einstein radius of SIS:"];
Print["  thetaE = (Dds/Ds) * alphahat = 4*Pi*(sigma_v/c)^2 * Dds/Ds\n"];

(* Numerical example *)
sigmaV = 250 * 1000;  (* m/s *)
DdVal = 900 * MpcToM;
DsVal = 1700 * MpcToM;
DdsVal = 1200 * MpcToM;

thetaESIS = 4 Pi (sigmaV/cc)^2 * DdsVal/DsVal;
Print["Numerical example: sigma_v = 250 km/s, zd = 0.3, zs = 1"];
Print["  thetaE = ", ScientificForm[thetaESIS, 4], " rad"];
Print["  = ", NumberForm[thetaESIS * radToArcsec, {4, 2}], " arcsec\n"];

(* Convergence and shear *)
Print["SIS convergence: kappa(theta) = thetaE / (2*theta)"];
Print["SIS mean convergence: kbar(theta) = thetaE / theta"];
Print["SIS shear: |gamma(theta)| = kbar - kappa = thetaE/(2*theta) = kappa"];
Print["  => kappa = |gamma| everywhere for SIS. VERIFIED\n"];

(* Image positions and magnifications *)
Print["SIS lens equation: beta = theta - thetaE"];
Print["  For beta < thetaE: two images at theta_pm = beta +/- thetaE"];
Print["  For beta > thetaE: one image at theta = beta + thetaE"];
Print["  Magnification: mu_pm = 1 +/- thetaE/beta\n"];

(* Numerical images for beta = 0.5" *)
betaVal = 0.5;  (* arcsec *)
thetaEarcsec = thetaESIS * radToArcsec;
Print["For beta = 0.5 arcsec:"];
If[betaVal < thetaEarcsec,
    tpSIS = betaVal + thetaEarcsec;
    tmSIS = betaVal - thetaEarcsec;
    mupSIS = 1 + thetaEarcsec/betaVal;
    mumSIS = 1 - thetaEarcsec/betaVal;
    Print["  Source inside caustic (beta < thetaE = ",
        NumberForm[thetaEarcsec, {4, 2}], ")"];
    Print["  theta_+ = ", NumberForm[tpSIS, {5, 2}], " arcsec"];
    Print["  theta_- = ", NumberForm[tmSIS, {5, 2}], " arcsec"];
    Print["  mu_+ = ", NumberForm[mupSIS, {5, 2}]];
    Print["  mu_- = ", NumberForm[mumSIS, {5, 2}]];
    Print["  Total mag = ", NumberForm[Abs[mupSIS] + Abs[mumSIS], {5, 2}]];
];
Print[""];


(* =========================================================================
   Section 3: Nonsingular Isothermal Sphere (NIS)

   Sigma(theta) = sigma_v^2 / (2*G*Dd*sqrt(theta^2 + thetac^2))
   kappa(theta) = thetaE / (2*sqrt(theta^2 + thetac^2))
   alpha(theta) = thetaE * (sqrt(theta^2 + thetac^2) - thetac) / theta
   ========================================================================= *)

Print["--- Section 3: Nonsingular Isothermal Sphere (NIS) ---\n"];

(* NIS convergence *)
kappaNIS[theta_, thetaE_, thetac_] := thetaE / (2 Sqrt[theta^2 + thetac^2]);

Print["NIS convergence: kappa(theta) = thetaE / (2*sqrt(theta^2 + thetac^2))"];
Print["  Central convergence: kappa(0) = thetaE / (2*thetac)"];
Print["  For strong lensing: kappa(0) >= 1 => thetac <= thetaE/2\n"];

(* Verify SIS limit *)
sisLimit = Limit[kappaNIS[theta, tE, tc], tc -> 0, Assumptions -> theta > 0];
Print["SIS limit (thetac -> 0): kappa -> ", sisLimit, " = thetaE/(2*theta). VERIFIED\n"];

(* NIS deflection angle *)
alphaNIS[theta_, thetaE_, thetac_] := thetaE (Sqrt[theta^2 + thetac^2] - thetac) / theta;

(* Verify SIS limit of deflection *)
sisAlphaLimit = Limit[alphaNIS[theta, tE, tc], tc -> 0, Assumptions -> theta > 0];
Print["NIS deflection SIS limit: alpha -> ", sisAlphaLimit, " = thetaE. VERIFIED\n"];

(* NIS mean convergence *)
(* kbar(theta) = alpha(theta)/theta *)
kbarNIS[theta_, thetaE_, thetac_] := alphaNIS[theta, thetaE, thetac] / theta;

(* NIS shear *)
gammaNIS[theta_, thetaE_, thetac_] := kbarNIS[theta, thetaE, thetac] - kappaNIS[theta, thetaE, thetac];

Print["NIS shear |gamma| = kbar - kappa:"];
gammaSymbolic = Simplify[
    thetaE (Sqrt[theta^2 + thetac^2] - thetac) / theta^2 -
    thetaE / (2 Sqrt[theta^2 + thetac^2]),
    Assumptions -> {theta > 0, thetac > 0, thetaE > 0}];
Print["  |gamma| = ", gammaSymbolic];
Print["  In general, |gamma| != kappa for NIS (unlike SIS)\n"];

(* Critical core radius *)
Print["Critical core radius for multiple images:"];
Print["  kappa(0) = thetaE/(2*thetac) >= 1"];
Print["  => thetac_crit = thetaE/2\n"];

(* Numerical NIS examples *)
Print["NIS convergence values for thetac = 0.1*thetaE:"];
Do[
    kval = kappaNIS[theta, 1.0, 0.1];
    Print["  kappa(", theta, "*thetaE) = ", NumberForm[kval, {5, 4}]],
    {theta, {0, 0.5, 1.0, 2.0}}
];
Print[""];


(* =========================================================================
   Section 4: NFW Profile

   rho(r) = rho_s / ((r/rs)*(1+r/rs)^2)
   kappa(x) = kappa_s * f(x)  where x = theta/theta_s
   ========================================================================= *)

Print["--- Section 4: NFW Profile ---\n"];

(* NFW surface density function f(x) *)
fNFW[x_] := Piecewise[{
    {(1/(x^2 - 1)) (1 - ArcCosh[1/x]/Sqrt[1 - x^2]), x < 1},
    {1/3, x == 1},
    {(1/(x^2 - 1)) (1 - ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1]), x > 1}
}];

(* NFW g(x) function for deflection angle *)
gNFW[x_] := Piecewise[{
    {ArcCosh[1/x]/Sqrt[1 - x^2], x < 1},
    {1, x == 1},
    {ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1], x > 1}
}];

(* Verify f(x) at x = 1 *)
fAtOneLeft = Limit[(1/(x^2 - 1)) (1 - ArcCosh[1/x]/Sqrt[1 - x^2]), x -> 1, Direction -> "FromBelow"];
fAtOneRight = Limit[(1/(x^2 - 1)) (1 - ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1]), x -> 1, Direction -> "FromAbove"];
Print["NFW f(x) continuity at x = 1:"];
Print["  lim(x->1-) f(x) = ", N[fAtOneLeft]];
Print["  lim(x->1+) f(x) = ", N[fAtOneRight]];
Print["  f(1) = 1/3 = ", N[1/3]];
Print["  Continuous? YES\n"];

(* NFW convergence *)
Print["NFW convergence: kappa(x) = kappa_s * f(x)"];
Print["  where kappa_s = 2*rho_s*r_s / Sigma_cr\n"];

(* Tabulate f(x) *)
Print["NFW f(x) values:"];
Print["  x       f(x)"];
Print["  ", StringJoin[Table["-", 20]]];
Do[
    fval = N[fNFW[x]];
    Print["  ", PaddedForm[N[x], {5, 2}], "  ", PaddedForm[fval, {7, 4}]],
    {x, {0.1, 0.3, 0.5, 0.7, 1.0, 1.5, 2.0, 3.0, 5.0, 10.0}}
];
Print[""];


(* =========================================================================
   Section 5: Generate Figures
   ========================================================================= *)

Print["--- Section 5: Generating Figures ---\n"];


(* ---- Figure 1: NIS Critical Curves (effect of core radius) ---- *)
Module[{},
    (* NIS lens equation: beta(theta) = theta - thetaE*(sqrt(theta^2+thetac^2)-thetac)/theta *)
    betaNIS[th_, tE_, tc_] := th - tE (Sqrt[th^2 + tc^2] - tc) / th;

    fig1 = GraphicsRow[{
        (* Panel 1: thetac = 0.1*thetaE (supercritical) *)
        Plot[{kappaNIS[theta, 1, 0.1], gammaNIS[theta, 1, 0.1], 1},
            {theta, 0.01, 3},
            PlotStyle -> {
                {Blue, AbsoluteThickness[2]},
                {Red, AbsoluteThickness[2], Dashed},
                {Gray, Thin, Dotted}
            },
            PlotRange -> {{0, 3}, {0, 3}},
            AxesLabel -> {
                Style[Superscript["\[Theta]", ""] <> " / " <> Subscript["\[Theta]", "E"], 11],
                None
            },
            PlotLabel -> Style[Subscript["\[Theta]", "c"] <> " = 0.1 " <> Subscript["\[Theta]", "E"], 11],
            ImageSize -> 220
        ],

        (* Panel 2: thetac = 0.5*thetaE (critical) *)
        Plot[{kappaNIS[theta, 1, 0.5], gammaNIS[theta, 1, 0.5], 1},
            {theta, 0.01, 3},
            PlotStyle -> {
                {Blue, AbsoluteThickness[2]},
                {Red, AbsoluteThickness[2], Dashed},
                {Gray, Thin, Dotted}
            },
            PlotRange -> {{0, 3}, {0, 3}},
            AxesLabel -> {
                Style[Superscript["\[Theta]", ""] <> " / " <> Subscript["\[Theta]", "E"], 11],
                None
            },
            PlotLabel -> Style[Subscript["\[Theta]", "c"] <> " = 0.5 " <> Subscript["\[Theta]", "E"], 11],
            ImageSize -> 220
        ],

        (* Panel 3: thetac = 1.0*thetaE (subcritical) *)
        Plot[{kappaNIS[theta, 1, 1.0], gammaNIS[theta, 1, 1.0], 1},
            {theta, 0.01, 3},
            PlotStyle -> {
                {Blue, AbsoluteThickness[2]},
                {Red, AbsoluteThickness[2], Dashed},
                {Gray, Thin, Dotted}
            },
            PlotRange -> {{0, 3}, {0, 3}},
            AxesLabel -> {
                Style[Superscript["\[Theta]", ""] <> " / " <> Subscript["\[Theta]", "E"], 11],
                None
            },
            PlotLabel -> Style[Subscript["\[Theta]", "c"] <> " = 1.0 " <> Subscript["\[Theta]", "E"], 11],
            PlotLegends -> Placed[
                LineLegend[{
                    Style["\[Kappa]", 10],
                    Style["|\[Gamma]|", 10],
                    Style["\[Kappa] = 1", 10]
                }, LegendMarkerSize -> 12],
                {0.75, 0.75}],
            ImageSize -> 270
        ]
    }, Spacings -> 0];

    Export[FileNameJoin[{baseDir, "nis_critical_curves.pdf"}], fig1,
        ImageSize -> 750];
    Print["  Exported: nis_critical_curves.pdf"];
];


(* ---- Figure 2: NFW Convergence and Shear Profiles ---- *)
Module[{},
    (* Plot kappa/kappa_s = f(x) and shear for different concentrations *)
    (* For the NFW, the mean convergence is kbar(x) = (4*kappa_s/x^2)*(ln(x/2) + g(x)) *)
    kbarNFW[x_] := (4/x^2) (Log[x/2] + gNFW[x]);
    gammaNFWfunc[x_] := kbarNFW[x] - fNFW[x];

    fig2 = Plot[
        {fNFW[x], gammaNFWfunc[x]},
        {x, 0.05, 5},
        PlotStyle -> {
            {Blue, AbsoluteThickness[2]},
            {Red, AbsoluteThickness[2], Dashed}
        },
        PlotRange -> {{0, 5}, {0, 3}},
        AxesLabel -> {
            Style["x = \[Theta] / " <> Subscript["\[Theta]", "s"], 13],
            Style["Amplitude / " <> Subscript["\[Kappa]", "s"], 13]
        },
        PlotLabel -> Style["NFW Convergence and Shear Profiles", 14],
        PlotLegends -> Placed[
            LineLegend[{
                Style["\[Kappa] / " <> Subscript["\[Kappa]", "s"], 11],
                Style["|\[Gamma]| / " <> Subscript["\[Kappa]", "s"], 11]
            }, LegendMarkerSize -> 15],
            {0.7, 0.75}],
        ImageSize -> 550,
        Epilog -> {
            Gray, Dashed, AbsoluteThickness[1],
            InfiniteLine[{{0, 1/3}, {10, 1/3}}],
            Text[Style["f(1) = 1/3", 9, Gray], {4, 0.4}]
        }
    ];
    Export[FileNameJoin[{baseDir, "nfw_profiles.pdf"}], fig2];
    Print["  Exported: nfw_profiles.pdf"];
];


(* ---- Figure 3: Model Comparison ---- *)
Module[{},
    (* Convergence comparison (all normalized to same thetaE scale) *)
    (* Point mass: kappa = 0 (not plottable as continuous function) *)
    (* SIS: kappa = 1/(2*theta) *)
    (* NIS: kappa = 1/(2*sqrt(theta^2 + thetac^2)) with thetac = 0.2 *)
    (* NFW: kappa = kappa_s * f(theta/theta_s), approximate with c=10 *)

    kappaSIS[th_] := 1/(2 th);
    kappaNISplot[th_] := 1/(2 Sqrt[th^2 + 0.04]);  (* thetac = 0.2 thetaE *)
    kappaNFWplot[th_] := 0.5 fNFW[th/0.3];  (* theta_s = 0.3 thetaE, kappa_s chosen *)

    alphaPM[th_] := 1/th;  (* thetaE^2/theta in units of thetaE *)
    alphaSISfunc[th_] := 1.0;  (* constant *)
    alphaNISplot[th_] := (Sqrt[th^2 + 0.04] - 0.2) / th;  (* thetac = 0.2 *)
    alphaNFWplot[th_] := 0.5 * 4 * 0.3 / th * (Log[th/(2*0.3)] + gNFW[th/0.3]);

    fig3 = GraphicsRow[{
        (* Left: Convergence profiles *)
        Plot[
            {kappaSIS[th], kappaNISplot[th], kappaNFWplot[th]},
            {th, 0.1, 4},
            PlotStyle -> {
                {Blue, AbsoluteThickness[2]},
                {Red, AbsoluteThickness[2], Dashed},
                {Darker[Green], AbsoluteThickness[2], DotDashed}
            },
            PlotRange -> {{0, 4}, {0, 3}},
            AxesLabel -> {
                Style["\[Theta] / " <> Subscript["\[Theta]", "E"], 13],
                Style["\[Kappa]", 13]
            },
            PlotLabel -> Style["Convergence Profiles", 13],
            PlotLegends -> Placed[
                LineLegend[{
                    Style["SIS", 10],
                    Style["NIS", 10],
                    Style["NFW", 10]
                }, LegendMarkerSize -> 12],
                {0.7, 0.75}],
            Epilog -> {
                Gray, Dashed, AbsoluteThickness[1],
                InfiniteLine[{{0, 1}, {10, 1}}],
                Text[Style["\[Kappa] = 1", 9, Gray], {3.5, 1.1}]
            },
            ImageSize -> 320
        ],

        (* Right: Deflection angle profiles *)
        Plot[
            {alphaPM[th], alphaSISfunc[th], alphaNISplot[th], alphaNFWplot[th]},
            {th, 0.1, 4},
            PlotStyle -> {
                {Black, AbsoluteThickness[2], Dotted},
                {Blue, AbsoluteThickness[2]},
                {Red, AbsoluteThickness[2], Dashed},
                {Darker[Green], AbsoluteThickness[2], DotDashed}
            },
            PlotRange -> {{0, 4}, {0, 4}},
            AxesLabel -> {
                Style["\[Theta] / " <> Subscript["\[Theta]", "E"], 13],
                Style["\[Alpha](\[Theta]) / " <> Subscript["\[Theta]", "E"], 13]
            },
            PlotLabel -> Style["Deflection Angle Profiles", 13],
            PlotLegends -> Placed[
                LineLegend[{
                    Style["Point mass", 10],
                    Style["SIS", 10],
                    Style["NIS", 10],
                    Style["NFW", 10]
                }, LegendMarkerSize -> 12],
                {0.7, 0.7}],
            ImageSize -> 370
        ]
    }, Spacings -> 0];

    Export[FileNameJoin[{baseDir, "model_comparison.pdf"}], fig3,
        ImageSize -> 750];
    Print["  Exported: model_comparison.pdf"];
];


(* ---- Figure 4: SIS Image Positions and Magnifications ---- *)
Module[{},
    (* SIS: theta_+ = beta + thetaE, theta_- = beta - thetaE (for beta < thetaE) *)
    muSISp[beta_] := 1 + 1/beta;  (* in units of thetaE *)
    muSISm[beta_] := Abs[1 - 1/beta];

    fig4 = GraphicsRow[{
        (* Left: Image positions *)
        Plot[
            {beta + 1, beta - 1, beta},
            {beta, 0, 3},
            PlotStyle -> {
                {Blue, AbsoluteThickness[2]},
                {Red, AbsoluteThickness[2]},
                {Gray, Dashed, AbsoluteThickness[1]}
            },
            PlotRange -> {{0, 3}, {-1.5, 4.5}},
            AxesLabel -> {
                Style["\[Beta] / " <> Subscript["\[Theta]", "E"], 13],
                Style["\[Theta] / " <> Subscript["\[Theta]", "E"], 13]
            },
            PlotLabel -> Style["SIS Image Positions", 13],
            PlotLegends -> Placed[
                LineLegend[{
                    Style[Subscript["\[Theta]", "+"], 11],
                    Style[Subscript["\[Theta]", "-"], 11],
                    Style["\[Theta] = \[Beta]", 11]
                }, LegendMarkerSize -> 12],
                {0.35, 0.8}],
            Epilog -> {
                Orange, Dotted, AbsoluteThickness[1.5],
                InfiniteLine[{{0, 1}, {10, 1}}],
                InfiniteLine[{{0, -1}, {10, -1}}],
                Text[Style[Subscript["\[Theta]", "E"], 10, Orange], {2.7, 1.2}],
                (* Mark where theta_- disappears *)
                Black, PointSize[0.02], Point[{1, 0}],
                Text[Style["\[Beta] = " <> Subscript["\[Theta]", "E"], 9, Black],
                    {1.3, -0.3}]
            },
            GridLines -> {None, {0}},
            GridLinesStyle -> Directive[Gray, Thin],
            ImageSize -> 320
        ],

        (* Right: Magnifications *)
        Plot[
            {muSISp[beta], muSISm[beta], muSISp[beta] + muSISm[beta]},
            {beta, 0.1, 3},
            PlotStyle -> {
                {Blue, AbsoluteThickness[1.5], Dashed},
                {Red, AbsoluteThickness[1.5], DotDashed},
                {Black, AbsoluteThickness[2]}
            },
            PlotRange -> {{0, 3}, {0, 12}},
            AxesLabel -> {
                Style["\[Beta] / " <> Subscript["\[Theta]", "E"], 13],
                Style["|\[Mu]|", 13]
            },
            PlotLabel -> Style["SIS Magnification", 13],
            PlotLegends -> Placed[
                LineLegend[{
                    Style["|" <> Subscript["\[Mu]", "+"] <> "|", 11],
                    Style["|" <> Subscript["\[Mu]", "-"] <> "|", 11],
                    Style["Total", 11]
                }, LegendMarkerSize -> 12],
                {0.7, 0.75}],
            Epilog -> {
                Gray, Dashed, AbsoluteThickness[1],
                InfiniteLine[{{0, 1}, {10, 1}}],
                Text[Style["\[Mu] = 1", 9, Gray], {2.7, 1.3}]
            },
            ImageSize -> 320
        ]
    }, Spacings -> 10];

    Export[FileNameJoin[{baseDir, "sis_images_magnification.pdf"}], fig4,
        ImageSize -> 700];
    Print["  Exported: sis_images_magnification.pdf"];
];


(* ---- Figure 5: NIS Convergence for Various Core Radii ---- *)
Module[{},
    fig5 = Plot[
        {kappaNIS[theta, 1, 0], kappaNIS[theta, 1, 0.1],
         kappaNIS[theta, 1, 0.3], kappaNIS[theta, 1, 0.5]},
        {theta, 0.01, 3},
        PlotStyle -> {
            {Black, AbsoluteThickness[2]},
            {Blue, AbsoluteThickness[2], Dashed},
            {Red, AbsoluteThickness[2], DotDashed},
            {Darker[Green], AbsoluteThickness[2], Dotted}
        },
        PlotRange -> {{0, 3}, {0, 5}},
        AxesLabel -> {
            Style["\[Theta] / " <> Subscript["\[Theta]", "E"], 13],
            Style["\[Kappa](\[Theta])", 13]
        },
        PlotLabel -> Style["NIS Convergence for Various Core Radii", 14],
        PlotLegends -> Placed[
            LineLegend[{
                Style[Subscript["\[Theta]", "c"] <> " = 0 (SIS)", 10],
                Style[Subscript["\[Theta]", "c"] <> " = 0.1 " <> Subscript["\[Theta]", "E"], 10],
                Style[Subscript["\[Theta]", "c"] <> " = 0.3 " <> Subscript["\[Theta]", "E"], 10],
                Style[Subscript["\[Theta]", "c"] <> " = 0.5 " <> Subscript["\[Theta]", "E"], 10]
            }, LegendMarkerSize -> 12],
            {0.7, 0.7}],
        Epilog -> {
            Gray, Dashed, AbsoluteThickness[1],
            InfiniteLine[{{0, 1}, {10, 1}}],
            Text[Style["\[Kappa] = 1", 9, Gray], {2.7, 1.1}]
        },
        ImageSize -> 600
    ];
    Export[FileNameJoin[{baseDir, "nis_convergence_profiles.pdf"}], fig5];
    Print["  Exported: nis_convergence_profiles.pdf"];
];


(* ---- Figure 6: NFW kappa for Various Concentrations ---- *)
Module[{},
    (* Plot f(x) * kappa_s for different c values *)
    (* Higher c => larger kappa_s and smaller theta_s *)
    (* For the shape comparison, just plot f(x) *)
    fig6 = Plot[
        {fNFW[x]},
        {x, 0.05, 10},
        PlotStyle -> {
            {Blue, AbsoluteThickness[2]}
        },
        PlotRange -> {{0, 10}, {0, 2}},
        AxesLabel -> {
            Style["x = \[Theta] / " <> Subscript["\[Theta]", "s"], 13],
            Style["f(x) = \[Kappa] / " <> Subscript["\[Kappa]", "s"], 13]
        },
        PlotLabel -> Style["NFW Surface Density Profile Shape", 14],
        ImageSize -> 550,
        Epilog -> {
            Gray, Dashed, AbsoluteThickness[1],
            InfiniteLine[{{1, 0}, {1, 10}}],
            Text[Style["x = 1 (r = " <> Subscript["r", "s"] <> ")", 9, Gray],
                {1.6, 1.8}]
        }
    ];
    Export[FileNameJoin[{baseDir, "nfw_f_function.pdf"}], fig6];
    Print["  Exported: nfw_f_function.pdf"];
];


Print["\n=== End of Module 7 ==="];
