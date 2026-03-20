(* =========================================================================
   lens_equation.wl
   Module 4: The Gravitational Lens Equation
   =========================================================================
   Purpose: Symbolic derivation of the lens equation, Einstein radius,
            point mass image positions, critical surface mass density,
            magnification preview, and publication-quality figure
            generation.

   Sources: Narayan & Bartelmann Sec. 2.1.3-2.1.5
            Congdon & Keeton Ch. 2 & 4
            Saha et al. Sec. 1

   Usage:   wolframscript -file lens_equation.wl

   Outputs: Symbolic verification of lens equation results;
            PDF figures exported to Figures/04_Lens_Equation/
   ========================================================================= *)

Print["=== Module 4: The Gravitational Lens Equation ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/04_Lens_Equation";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];

(* ---- Physical constants ---- *)
Gnewton = 6.674*^-11;      (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
Rsolar = 6.957*^8;          (* m *)
kpcToM = 3.086*^19;         (* 1 kpc in meters *)
MpcToM = 3.086*^22;         (* 1 Mpc in meters *)
radToArcsec = 180 * 3600 / Pi;


(* =========================================================================
   Section 1: The Lens Equation -- Symbolic Setup

   beta = theta - alpha(theta)
   alpha(theta) = (Dds/Ds) * alphahat(Dd * theta)
   For a point mass: alphahat(xi) = 4*G*M / (c^2 * xi)
   ========================================================================= *)

Print["--- Section 1: The Lens Equation (Symbolic) ---\n"];

Print["The lens equation: beta = theta - alpha(theta)"];
Print["  where alpha(theta) = (Dds/Ds) * alphahat(Dd * theta)"];
Print["  and alphahat(xi) = 4*G*M / (c^2 * xi)  for a point mass\n"];

(* Reduced deflection angle for point mass *)
alphaReduced[theta_, thetaE_] := thetaE^2 / theta;

(* Lens equation for point mass *)
lensEq[theta_, beta_, thetaE_] := beta - theta + thetaE^2/theta;

(* Solve symbolically *)
Print["Solving the point mass lens equation: beta = theta - thetaE^2/theta"];
Print["  => theta^2 - beta*theta - thetaE^2 = 0"];
thetaSols = Solve[theta^2 - beta*theta - thetaE^2 == 0, theta];
Print["  Solutions:"];
Print["    theta_+ = ", thetaSols[[2, 1, 2]]];
Print["    theta_- = ", thetaSols[[1, 1, 2]]];
Print[""];

(* Verify Vieta's formulas *)
thetaPlus[beta_, thetaE_] := (beta + Sqrt[beta^2 + 4 thetaE^2])/2;
thetaMinus[beta_, thetaE_] := (beta - Sqrt[beta^2 + 4 thetaE^2])/2;

sumCheck = Simplify[thetaPlus[beta, thetaE] + thetaMinus[beta, thetaE]];
prodCheck = Simplify[thetaPlus[beta, thetaE] * thetaMinus[beta, thetaE]];
Print["Vieta's formulas:"];
Print["  theta_+ + theta_- = ", sumCheck, "  (should be beta)"];
Print["  theta_+ * theta_- = ", prodCheck, "  (should be -thetaE^2)"];
Print[""];

(* Verify that both satisfy the lens equation *)
checkPlus = Simplify[thetaPlus[b, tE] - tE^2/thetaPlus[b, tE] - b,
    Assumptions -> {b > 0, tE > 0}];
checkMinus = Simplify[thetaMinus[b, tE] - tE^2/thetaMinus[b, tE] - b,
    Assumptions -> {b > 0, tE > 0}];
Print["Verification (should be 0):"];
Print["  beta(theta_+) - beta = ", checkPlus];
Print["  beta(theta_-) - beta = ", checkMinus];
Print[""];


(* =========================================================================
   Section 2: The Einstein Radius

   thetaE = sqrt(4*G*M/c^2 * Dds/(Dd*Ds))
   ========================================================================= *)

Print["--- Section 2: The Einstein Radius ---\n"];

thetaEfunc[M_, Dd_, Ds_, Dds_] :=
    Sqrt[4 Gnewton M / cc^2 * Dds / (Dd * Ds)];

(* --- (a) Stellar microlensing --- *)
Mstar = 1 Msolar;
DdStar = 5 * kpcToM;
DsStar = 10 * kpcToM;
DdsStar = 5 * kpcToM;
thetaEStar = thetaEfunc[Mstar, DdStar, DsStar, DdsStar];
Print["(a) Stellar microlensing (M = 1 Msun, Dd = Ds/2 = 5 kpc):"];
Print["  thetaE = ", ScientificForm[thetaEStar, 4], " rad"];
Print["  = ", NumberForm[thetaEStar * radToArcsec * 1000, {3, 2}], " mas"];
REstar = DdStar * thetaEStar;
Print["  RE = ", ScientificForm[REstar, 3], " m"];
Print["     = ", NumberForm[REstar / (1.496*^11), {3, 1}], " AU\n"];

(* --- (b) Galaxy lensing --- *)
Mgal = 1*^12 * Msolar;
DdGal = 900 * MpcToM;
DsGal = 1700 * MpcToM;
DdsGal = 1200 * MpcToM;
thetaEGal = thetaEfunc[Mgal, DdGal, DsGal, DdsGal];
Print["(b) Galaxy lensing (M = 10^12 Msun, zd = 0.3, zs = 1):"];
Print["  thetaE = ", ScientificForm[thetaEGal, 4], " rad"];
Print["  = ", NumberForm[thetaEGal * radToArcsec, {3, 2}], " arcsec"];
REgal = DdGal * thetaEGal;
Print["  RE = ", NumberForm[REgal / kpcToM, {3, 1}], " kpc\n"];

(* --- (c) Cluster lensing --- *)
Mclus = 1*^15 * Msolar;
DdClus = 900 * MpcToM;
DsClus = 1800 * MpcToM;
DdsClus = 1400 * MpcToM;
thetaEClus = thetaEfunc[Mclus, DdClus, DsClus, DdsClus];
Print["(c) Cluster lensing (M = 10^15 Msun, zd = 0.3, zs = 2):"];
Print["  thetaE = ", ScientificForm[thetaEClus, 4], " rad"];
Print["  = ", NumberForm[thetaEClus * radToArcsec, {3, 1}], " arcsec"];
REclus = DdClus * thetaEClus;
Print["  RE = ", NumberForm[REclus / kpcToM, {4, 1}], " kpc\n"];


(* =========================================================================
   Section 3: Critical Surface Mass Density

   Sigma_cr = c^2 / (4*Pi*G) * Ds / (Dd * Dds)
   ========================================================================= *)

Print["--- Section 3: Critical Surface Mass Density ---\n"];

sigmaCr[Dd_, Ds_, Dds_] := cc^2 / (4 Pi Gnewton) * Ds / (Dd * Dds);

(* Galaxy lens configuration *)
sCrGal = sigmaCr[DdGal, DsGal, DdsGal];
Print["Galaxy lens (zd=0.3, zs=1):"];
Print["  Sigma_cr = ", ScientificForm[sCrGal, 4], " kg/m^2"];
Print["           = ", NumberForm[sCrGal * 10, {3, 2}], " g/cm^2"];
(* Convert to Msun/pc^2: 1 pc = 3.086e16 m *)
sCrGalSunPc2 = sCrGal * (3.086*^16)^2 / Msolar;
Print["           = ", NumberForm[sCrGalSunPc2, {4, 0}], " Msun/pc^2\n"];

(* Cluster lens configuration *)
sCrClus = sigmaCr[DdClus, DsClus, DdsClus];
Print["Cluster lens (zd=0.3, zs=2):"];
Print["  Sigma_cr = ", ScientificForm[sCrClus, 4], " kg/m^2"];
sCrClusSunPc2 = sCrClus * (3.086*^16)^2 / Msolar;
Print["           = ", NumberForm[sCrClusSunPc2, {4, 0}], " Msun/pc^2\n"];

(* Check: is a typical elliptical galaxy a strong lens? *)
Print["Typical elliptical galaxy: Sigma_0 ~ 5000 Msun/pc^2"];
Print["  kappa = Sigma_0 / Sigma_cr = ", NumberForm[5000/sCrGalSunPc2, {3, 1}]];
Print["  kappa > 1 => YES, it is a strong lens.\n"];


(* =========================================================================
   Section 4: Magnification of a Point Mass Lens

   mu_pm = (u^2+2) / (2*u*sqrt(u^2+4)) +/- 1/2
   where u = beta / thetaE
   ========================================================================= *)

Print["--- Section 4: Magnification Preview ---\n"];

muPlus[u_] := (u^2 + 2)/(2 u Sqrt[u^2 + 4]) + 1/2;
muMinus[u_] := (u^2 + 2)/(2 u Sqrt[u^2 + 4]) - 1/2;
muTotal[u_] := (u^2 + 2)/(u Sqrt[u^2 + 4]);

Print["Magnification formula: mu_pm = (u^2+2)/(2u*sqrt(u^2+4)) +/- 1/2"];
Print["  where u = beta/thetaE\n"];

(* Verify total magnification > 1 *)
totalMag = Simplify[(u^2 + 2)/(u Sqrt[u^2 + 4]), Assumptions -> u > 0];
Print["Total magnification |mu_+| + |mu_-| = ", totalMag];
Print["  Is it always > 1? For u > 0:"];
Print["  (u^2 + 2)^2 - u^2*(u^2 + 4) = ", Expand[(u^2 + 2)^2 - u^2*(u^2 + 4)]];
Print["  = 4 > 0, so (u^2+2) > u*sqrt(u^2+4), hence mu_total > 1. QED\n"];

(* Table of magnifications *)
Print["Magnification table (thetaE = 1):"];
Print["  u       mu_+      |mu_-|    mu_total"];
Print["  ", StringJoin[Table["-", 45]]];
Do[
    mp = muPlus[u];
    mm = Abs[muMinus[u]];
    mt = muTotal[u];
    Print["  ", PaddedForm[u, {4, 2}], "    ",
        PaddedForm[mp, {6, 3}], "    ",
        PaddedForm[mm, {6, 3}], "    ",
        PaddedForm[mt, {6, 3}]],
    {u, {0.1, 0.2, 0.5, 1.0, 2.0, 5.0, 10.0}}
];
Print[""];


(* =========================================================================
   Section 5: Image Position Table

   For thetaE = 1 arcsec, compute image positions for various beta
   ========================================================================= *)

Print["--- Section 5: Image Positions for thetaE = 1\" ---\n"];

tE = 1.0;  (* arcsec *)
Print["beta (\")    theta_+ (\")    theta_- (\")    Delta_theta (\")"];
Print[StringJoin[Table["-", 60]]];
Do[
    tp = thetaPlus[beta, tE];
    tm = thetaMinus[beta, tE];
    dt = tp - tm;
    Print[PaddedForm[beta, {5, 2}], "       ",
        PaddedForm[tp, {7, 4}], "       ",
        PaddedForm[tm, {8, 4}], "       ",
        PaddedForm[dt, {7, 4}]],
    {beta, {0.01, 0.1, 0.5, 1.0, 2.0, 5.0, 10.0}}
];
Print[""];


(* =========================================================================
   Section 6: Generate Figures
   ========================================================================= *)

Print["--- Section 6: Generating Figures ---\n"];

(* ---- Figure 1: Lensing Geometry Diagram ---- *)
Module[{},
    fig1 = Graphics[{
        (* Observer *)
        {Black, PointSize[0.02], Point[{0, 0}]},
        Text[Style["O (Observer)", 11, Bold], {0, -0.4}],

        (* Lens plane *)
        {Gray, Dashed, Line[{{-4, 5}, {4, 5}}]},
        Text[Style["Lens plane", 10, Gray], {3.8, 5.4}],
        {Black, Disk[{0, 5}, 0.15]},
        Text[Style["L", 12, Bold], {-0.4, 5}],

        (* Source plane *)
        {Gray, Dashed, Line[{{-4, 10}, {4, 10}}]},
        Text[Style["Source plane", 10, Gray], {3.8, 10.4}],

        (* Source position S *)
        {Darker[Green], PointSize[0.02], Point[{-1, 10}]},
        Text[Style["S", 12, Bold, Darker[Green]], {-1.4, 10}],

        (* Image position I *)
        {Blue, PointSize[0.015], Point[{1.5, 5}]},
        Text[Style["I", 12, Bold, Blue], {1.9, 5}],

        (* Optical axis *)
        {Gray, Thin, Line[{{0, 0}, {0, 11}}]},

        (* Light ray from source to lens plane *)
        {Blue, AbsoluteThickness[1.5],
         Arrow[{{-1, 10}, {1.5, 5}}]},

        (* Light ray from lens plane to observer *)
        {Blue, AbsoluteThickness[1.5],
         Arrow[{{1.5, 5}, {0, 0}}]},

        (* Undeflected ray (dashed) *)
        {Red, Dashed, AbsoluteThickness[1],
         Line[{{-1, 10}, {0, 0}}]},

        (* Angle theta *)
        {Blue, AbsoluteThickness[1.5],
         Circle[{0, 0}, 1.5, {Pi/2 - 0.01, Pi/2 + ArcTan[1.5/5]}],
         Text[Style["\[Theta]", 14, Blue], {1.0, 1.8}]},

        (* Angle beta *)
        {Darker[Green], AbsoluteThickness[1.5],
         Circle[{0, 0}, 2.5, {Pi/2, Pi/2 + ArcTan[1/10]}],
         Text[Style["\[Beta]", 14, Darker[Green]], {-0.8, 2.8}]},

        (* Distance labels *)
        {Black, AbsoluteThickness[1],
         Line[{{-3.5, 0}, {-3.5, 5}}],
         Text[Style[Subscript["D", "d"], 12], {-3.9, 2.5}]},
        {Black, AbsoluteThickness[1],
         Line[{{3.5, 0}, {3.5, 10}}],
         Text[Style[Subscript["D", "s"], 12], {3.9, 5}]},
        {Black, AbsoluteThickness[1],
         Line[{{-3.5, 5}, {-3.5, 10}}],
         Text[Style[Subscript["D", "ds"], 12], {-3.9, 7.5}]},

        (* Deflection angle alpha-hat *)
        {Red, AbsoluteThickness[1.5],
         Text[Style[
             "\!\(\*OverscriptBox[\(\[Alpha]\), \(^\)]\)", 14, Red],
             {2.2, 7.5}]}
    },
    PlotRange -> {{-5, 5}, {-1, 11.5}},
    ImageSize -> 450,
    Axes -> False,
    Frame -> False
    ];
    Export[FileNameJoin[{baseDir, "lensing_geometry.pdf"}], fig1];
    Print["  Exported: lensing_geometry.pdf"];
];

(* ---- Figure 2: Image Positions vs Source Position ---- *)
Module[{},
    fig2 = Plot[
        {thetaPlus[beta, 1], thetaMinus[beta, 1], beta, 1, -1},
        {beta, 0, 5},
        PlotStyle -> {
            {Blue, AbsoluteThickness[2]},
            {Red, AbsoluteThickness[2]},
            {Gray, Dashed, AbsoluteThickness[1]},
            {Orange, Dotted, AbsoluteThickness[1.5]},
            {Orange, Dotted, AbsoluteThickness[1.5]}
        },
        PlotRange -> {{0, 5}, {-1.5, 6}},
        AxesLabel -> {
            Style["\[Beta] / \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13],
            Style["\[Theta] / \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13]
        },
        PlotLabel -> Style["Image Positions vs. Source Position (Point Mass Lens)", 13],
        PlotLegends -> Placed[
            LineLegend[{
                Style["\!\(\*SubscriptBox[\(\[Theta]\), \(+\)]\) (primary)", 11],
                Style["\!\(\*SubscriptBox[\(\[Theta]\), \(-\)]\) (secondary)", 11],
                Style["\[Theta] = \[Beta] (unlensed)", 11],
                Style["\[Theta] = \[PlusMinus]\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 11]
            }, LegendMarkerSize -> 15],
            {0.65, 0.65}],
        ImageSize -> 600,
        GridLines -> {None, {0}},
        GridLinesStyle -> Directive[Gray, Thin]
    ];
    Export[FileNameJoin[{baseDir, "image_positions.pdf"}], fig2];
    Print["  Exported: image_positions.pdf"];
];

(* ---- Figure 3: Einstein Ring ---- *)
Module[{nPts = 100, ring, sourceOffsets},
    (* Einstein ring (beta = 0) *)
    ring = Table[{Cos[phi], Sin[phi]}, {phi, 0, 2 Pi, 2 Pi/nPts}];

    (* For beta != 0: show the two images *)
    sourceOffsets = {0.0, 0.3, 0.7};

    fig3 = Graphics[{
        (* Einstein ring for beta = 0 *)
        {Blue, AbsoluteThickness[3],
         Line[ring]},
        Text[Style[
            "\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 14, Blue],
            {1.2, 0.3}],

        (* Lens at center *)
        {Black, Disk[{0, 0}, 0.06]},
        Text[Style["L", 11, Bold], {0.15, -0.15}],

        (* Source at center (beta = 0) *)
        {Darker[Green], AbsoluteThickness[2],
         Line[{{-0.08, -0.08}, {0.08, 0.08}}],
         Line[{{-0.08, 0.08}, {0.08, -0.08}}]},

        (* Show images for offset source *)
        {Red, PointSize[0.015],
         Point[{0, thetaPlus[0.3, 1]}],
         Point[{0, thetaMinus[0.3, 1]}]},
        {Darker[Green], PointSize[0.012],
         Point[{0, 0.3}]},
        Text[Style["\[Beta] = 0.3", 10, Darker[Green]], {0.35, 0.3}],
        Text[Style["\!\(\*SubscriptBox[\(\[Theta]\), \(+\)]\)", 10, Red],
            {0.2, thetaPlus[0.3, 1]}],
        Text[Style["\!\(\*SubscriptBox[\(\[Theta]\), \(-\)]\)", 10, Red],
            {0.2, thetaMinus[0.3, 1]}],

        (* Circle for reference *)
        {Gray, Thin, Dashed, Circle[{0, 0}, 1]}
    },
    PlotRange -> {{-1.8, 1.8}, {-1.8, 1.8}},
    ImageSize -> 450,
    Axes -> False,
    Frame -> False,
    AspectRatio -> 1
    ];
    Export[FileNameJoin[{baseDir, "einstein_ring.pdf"}], fig3];
    Print["  Exported: einstein_ring.pdf"];
];

(* ---- Figure 4: Total Magnification vs Source Position ---- *)
Module[{},
    fig4 = Plot[
        {muTotal[u], Abs[muPlus[u]], Abs[muMinus[u]]},
        {u, 0.1, 5},
        PlotStyle -> {
            {Black, AbsoluteThickness[2]},
            {Blue, AbsoluteThickness[1.5], Dashed},
            {Red, AbsoluteThickness[1.5], DotDashed}
        },
        PlotRange -> {{0, 5}, {0, 10}},
        AxesLabel -> {
            Style["u = \[Beta] / \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13],
            Style["|\[Mu]|", 13]
        },
        PlotLabel -> Style["Magnification vs. Source Position (Point Mass Lens)", 13],
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
            Text[Style["\[Mu] = 1 (no lensing)", 9, Gray], {4, 1.3}]
        },
        ImageSize -> 600
    ];
    Export[FileNameJoin[{baseDir, "magnification.pdf"}], fig4];
    Print["  Exported: magnification.pdf"];
];

Print["\n=== End of Module 4 ==="];
