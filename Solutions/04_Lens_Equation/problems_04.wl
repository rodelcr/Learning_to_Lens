(* =========================================================================
   problems_04.wl
   Module 4: The Gravitational Lens Equation --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 4, verified
            symbolically and numerically with Mathematica.

   Sources: Narayan & Bartelmann Sec. 2.1.3-2.1.5
            Congdon & Keeton Ch. 2 & 4
            Saha et al. Sec. 1

   Usage:   wolframscript -file problems_04.wl

   Exercises solved:
     4.1 --- Derive the lens equation from the lensing geometry
     4.2 --- Solve the point mass lens equation; show two images always form
     4.3 --- Compute thetaE for microlensing, galaxy, and cluster
     4.4 --- Show Sigma_cr has units of mass/area; compute for typical configs
     4.5 --- Image positions and magnification for point mass lens
   ========================================================================= *)

Print["=== Module 4: SOLUTIONS ===\n"];

(* ---- Physical constants ---- *)
Gnewton = 6.674*^-11;      (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
kpcToM = 3.086*^19;         (* 1 kpc in meters *)
MpcToM = 3.086*^22;         (* 1 Mpc in meters *)
radToArcsec = 180 * 3600 / Pi;


(* =========================================================================
   Exercise 4.1: Derive the Lens Equation

   From the geometry:
     eta = (Ds/Dd) * xi - Dds * alphahat(xi)
   Substituting xi = Dd*theta, eta = Ds*beta:
     Ds*beta = Ds*theta - Dds*alphahat(Dd*theta)
     beta = theta - (Dds/Ds)*alphahat(Dd*theta)
          = theta - alpha(theta)
   ========================================================================= *)

Print["--- Exercise 4.1: Derivation of the Lens Equation ---\n"];

Print["(a) From the lensing geometry, the physical position in the source"];
Print["    plane is: eta = (Ds/Dd)*xi - Dds*alphahat(xi)"];
Print["    The first term projects the image position to the source plane."];
Print["    The second term accounts for the deflection over the"];
Print["    lens-source distance Dds.\n"];

Print["(b) Substituting xi = Dd*theta and eta = Ds*beta:"];
Print["    Ds*beta = Ds*theta - Dds*alphahat(Dd*theta)"];
Print["    Dividing by Ds:"];
Print["    beta = theta - (Dds/Ds)*alphahat(Dd*theta)\n"];

Print["(c) Defining the reduced deflection angle:"];
Print["    alpha(theta) = (Dds/Ds)*alphahat(Dd*theta)"];
Print["    The lens equation becomes:"];
Print["    beta = theta - alpha(theta)  QED\n"];


(* =========================================================================
   Exercise 4.2: Point Mass Lens Equation

   alphahat = 4GM/(c^2 * xi), xi = Dd*theta
   alpha(theta) = (Dds/Ds) * 4GM/(c^2 * Dd * theta) = thetaE^2/theta
   Lens eq: beta = theta - thetaE^2/theta
   => theta^2 - beta*theta - thetaE^2 = 0
   => theta_pm = (beta +/- sqrt(beta^2 + 4*thetaE^2)) / 2
   ========================================================================= *)

Print["--- Exercise 4.2: Point Mass Lens Equation ---\n"];

(* (a) Derive lens equation *)
Print["(a) For a point mass:"];
Print["    alphahat(xi) = 4GM/(c^2 * xi)"];
Print["    alpha(theta) = (Dds/Ds) * 4GM/(c^2 * Dd * theta)"];
Print["                 = thetaE^2 / theta"];
Print["    where thetaE^2 = (4GM/c^2) * (Dds/(Dd*Ds))"];
Print["    Lens equation: beta = theta - thetaE^2/theta\n"];

(* (b) Solve the quadratic *)
Print["(b) Multiplying by theta: theta^2 - beta*theta - thetaE^2 = 0"];
sols = Solve[theta^2 - beta theta - thetaE^2 == 0, theta];
Print["    Solutions: ", sols];
Print["    theta_+ = (beta + sqrt(beta^2 + 4*thetaE^2)) / 2"];
Print["    theta_- = (beta - sqrt(beta^2 + 4*thetaE^2)) / 2\n"];

(* (c) Discriminant always positive *)
Print["(c) Discriminant = beta^2 + 4*thetaE^2"];
Print["    For thetaE > 0, this is always > beta^2 >= 0."];
Print["    Therefore two real solutions always exist."];
Print["    A point mass lens ALWAYS produces two images.\n"];

(* (d) Vieta's formulas *)
thetaP[b_, tE_] := (b + Sqrt[b^2 + 4 tE^2])/2;
thetaM[b_, tE_] := (b - Sqrt[b^2 + 4 tE^2])/2;

sumRoots = Simplify[thetaP[b, tE] + thetaM[b, tE]];
prodRoots = Simplify[thetaP[b, tE] * thetaM[b, tE]];
Print["(d) Vieta's formulas:"];
Print["    theta_+ + theta_- = ", sumRoots, "  (should be beta)"];
Print["    theta_+ * theta_- = ", prodRoots, "  (should be -thetaE^2)"];
Print["    VERIFIED\n"];

(* (e) Show theta_+ > thetaE and |theta_-| < thetaE *)
Print["(e) For beta > 0:"];
Print["    theta_+ = (beta + sqrt(beta^2 + 4*thetaE^2))/2 > 0 (obvious)"];
Print["    To show theta_+ > thetaE:"];
Print["      beta + sqrt(beta^2 + 4*thetaE^2) > 2*thetaE"];
Print["      sqrt(beta^2 + 4*thetaE^2) > 2*thetaE - beta"];
Print["      If 2*thetaE - beta <= 0, trivially true."];
Print["      If 2*thetaE - beta > 0, square both sides:"];
Print["        beta^2 + 4*thetaE^2 > 4*thetaE^2 - 4*beta*thetaE + beta^2"];
Print["        0 > -4*beta*thetaE, which is true for beta > 0. QED"];
Print[""];
Print["    |theta_-| = (sqrt(beta^2 + 4*thetaE^2) - beta)/2 < thetaE"];
Print["      sqrt(beta^2 + 4*thetaE^2) - beta < 2*thetaE"];
Print["      sqrt(beta^2 + 4*thetaE^2) < 2*thetaE + beta"];
Print["      Square: beta^2 + 4*thetaE^2 < 4*thetaE^2 + 4*beta*thetaE + beta^2"];
Print["      0 < 4*beta*thetaE. True for beta > 0. QED\n"];

(* Numerical verification *)
Print["Numerical check with thetaE = 1, beta = 0.5:"];
tp = thetaP[0.5, 1.0];
tm = thetaM[0.5, 1.0];
Print["  theta_+ = ", tp, " (> 1 = thetaE) CHECK"];
Print["  theta_- = ", tm, " (|theta_-| = ", Abs[tm], " < 1 = thetaE) CHECK\n"];


(* =========================================================================
   Exercise 4.3: Einstein Radius for Various Systems

   thetaE = sqrt(4*G*M/c^2 * Dds/(Dd*Ds))
   ========================================================================= *)

Print["--- Exercise 4.3: Einstein Radius for Various Systems ---\n"];

thetaEfunc[M_, Dd_, Ds_, Dds_] :=
    Sqrt[4 Gnewton M / cc^2 * Dds / (Dd * Ds)];

(* (a) Stellar microlensing *)
Print["(a) Stellar microlensing: M = 1 Msun, Dd = Dds = 5 kpc, Ds = 10 kpc"];
Mstar = 1 Msolar;
DdStar = 5 kpcToM;
DsStar = 10 kpcToM;
DdsStar = 5 kpcToM;
thetaEStar = thetaEfunc[Mstar, DdStar, DsStar, DdsStar];
Print["  thetaE = ", ScientificForm[thetaEStar, 4], " rad"];
Print["         = ", NumberForm[thetaEStar * radToArcsec * 1000, {4, 2}], " mas"];
REstar = DdStar * thetaEStar;
Print["  RE = ", NumberForm[REstar / (1.496*^11), {4, 1}], " AU"];
Print["     = ", ScientificForm[REstar / kpcToM, 3], " kpc\n"];

(* (b) Galaxy lensing *)
Print["(b) Galaxy lensing: M = 10^12 Msun, zd = 0.3, zs = 1"];
Mgal = 1*^12 Msolar;
DdGal = 900 MpcToM;
DsGal = 1700 MpcToM;
DdsGal = 1200 MpcToM;
thetaEGal = thetaEfunc[Mgal, DdGal, DsGal, DdsGal];
Print["  Dd = 900 Mpc, Ds = 1700 Mpc, Dds = 1200 Mpc"];
Print["  thetaE = ", ScientificForm[thetaEGal, 4], " rad"];
Print["         = ", NumberForm[thetaEGal * radToArcsec, {4, 2}], " arcsec"];
REgal = DdGal * thetaEGal;
Print["  RE = ", NumberForm[REgal / kpcToM, {4, 1}], " kpc\n"];

(* (c) Cluster lensing *)
Print["(c) Cluster lensing: M = 10^15 Msun, zd = 0.3, zs = 2"];
Mclus = 1*^15 Msolar;
DdClus = 900 MpcToM;
DsClus = 1800 MpcToM;
DdsClus = 1400 MpcToM;
thetaEClus = thetaEfunc[Mclus, DdClus, DsClus, DdsClus];
Print["  Dd = 900 Mpc, Ds = 1800 Mpc, Dds = 1400 Mpc"];
Print["  thetaE = ", ScientificForm[thetaEClus, 4], " rad"];
Print["         = ", NumberForm[thetaEClus * radToArcsec, {4, 1}], " arcsec"];
REclus = DdClus * thetaEClus;
Print["  RE = ", NumberForm[REclus / kpcToM, {5, 1}], " kpc\n"];


(* =========================================================================
   Exercise 4.4: Critical Surface Mass Density

   Sigma_cr = c^2 / (4*Pi*G) * Ds / (Dd * Dds)
   ========================================================================= *)

Print["--- Exercise 4.4: Critical Surface Mass Density ---\n"];

sigmaCr[Dd_, Ds_, Dds_] := cc^2 / (4 Pi Gnewton) * Ds / (Dd * Dds);

(* (a) Dimensional analysis *)
Print["(a) Dimensional analysis:"];
Print["  [c^2 / (4*Pi*G)] = (m/s)^2 / (m^3 kg^-1 s^-2)"];
Print["                    = m^2 s^-2 * kg s^2 / m^3"];
Print["                    = kg / m"];
Print["  [Ds / (Dd * Dds)] = m / (m * m) = 1/m"];
Print["  [Sigma_cr] = (kg/m) * (1/m) = kg/m^2 = mass/area. QED\n"];

(* (b) Galaxy lens *)
sCrGal = sigmaCr[DdGal, DsGal, DdsGal];
Print["(b) Galaxy lens (zd=0.3, zs=1):"];
Print["  Sigma_cr = ", ScientificForm[sCrGal, 4], " kg/m^2"];
Print["           = ", NumberForm[sCrGal * 10, {3, 2}], " g/cm^2"];
pcToM = 3.086*^16;
sCrGalSunPc2 = sCrGal * pcToM^2 / Msolar;
Print["           = ", NumberForm[sCrGalSunPc2, {4, 0}], " Msun/pc^2\n"];

(* (c) Cluster lens *)
sCrClus = sigmaCr[DdClus, DsClus, DdsClus];
Print["(c) Cluster lens (zd=0.3, zs=2):"];
Print["  Sigma_cr = ", ScientificForm[sCrClus, 4], " kg/m^2"];
sCrClusSunPc2 = sCrClus * pcToM^2 / Msolar;
Print["           = ", NumberForm[sCrClusSunPc2, {4, 0}], " Msun/pc^2\n"];

(* (d) Is a typical elliptical galaxy a strong lens? *)
Print["(d) Typical elliptical galaxy: Sigma_0 ~ 5000 Msun/pc^2"];
kappa0 = 5000 / sCrGalSunPc2;
Print["  kappa = Sigma_0 / Sigma_cr = ", NumberForm[kappa0, {3, 1}]];
Print["  kappa > 1 => YES, it is supercritical => STRONG LENS\n"];


(* =========================================================================
   Exercise 4.5: Image Positions and Magnification

   theta_pm = (beta +/- sqrt(beta^2 + 4*thetaE^2)) / 2
   mu_pm = (u^2 + 2)/(2*u*sqrt(u^2+4)) +/- 1/2  where u = beta/thetaE
   ========================================================================= *)

Print["--- Exercise 4.5: Image Positions for thetaE = 1\" ---\n"];

tE = 1.0;  (* arcsec *)

muPlusFunc[u_] := (u^2 + 2)/(2 u Sqrt[u^2 + 4]) + 1/2;
muMinusFunc[u_] := Abs[(u^2 + 2)/(2 u Sqrt[u^2 + 4]) - 1/2];
muTotalFunc[u_] := (u^2 + 2)/(u Sqrt[u^2 + 4]);

(* (a) Table of image positions *)
Print["(a) Image positions and magnifications:"];
Print[""];
Print[StringForm["  ``  ``  ``  ``  ``  ``  ``",
    PaddedForm["beta", {6, 0}],
    PaddedForm["theta_+", {8, 0}],
    PaddedForm["theta_-", {8, 0}],
    PaddedForm["Delta_th", {9, 0}],
    PaddedForm["|mu_+|", {7, 0}],
    PaddedForm["|mu_-|", {7, 0}],
    PaddedForm["mu_tot", {7, 0}]
]];
Print["  ", StringJoin[Table["-", 65]]];

betaVals = {0.1, 0.5, 1.0, 2.0, 5.0};
Do[
    tp = thetaP[beta, tE];
    tm = thetaM[beta, tE];
    dt = tp - tm;
    u = beta / tE;
    mp = muPlusFunc[u];
    mm = muMinusFunc[u];
    mt = muTotalFunc[u];
    Print[StringForm["  ``  ``  ``  ``  ``  ``  ``",
        PaddedForm[beta, {6, 2}],
        PaddedForm[tp, {8, 4}],
        PaddedForm[tm, {8, 4}],
        PaddedForm[dt, {9, 4}],
        PaddedForm[mp, {7, 3}],
        PaddedForm[mm, {7, 3}],
        PaddedForm[mt, {7, 3}]
    ]],
    {beta, betaVals}
];
Print[""];

(* (b) and (c): Plots *)
Print["(b)-(c) Generating plots...\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/04_Lens_Equation";

(* Image positions plot *)
fig1 = Plot[
    {thetaP[beta, 1], thetaM[beta, 1], beta, 1, -1},
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
        Style["\[Beta] (arcsec)", 13],
        Style["\[Theta] (arcsec)", 13]
    },
    PlotLabel -> Style["Image Positions (Exercise 4.5b)", 13],
    PlotLegends -> Placed[
        LineLegend[{
            Style["\!\(\*SubscriptBox[\(\[Theta]\), \(+\)]\)", 11],
            Style["\!\(\*SubscriptBox[\(\[Theta]\), \(-\)]\)", 11],
            Style["\[Theta] = \[Beta]", 11],
            Style["\[Theta] = \[PlusMinus]\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 11]
        }, LegendMarkerSize -> 15],
        {0.65, 0.65}],
    ImageSize -> 550,
    GridLines -> {None, {0}},
    GridLinesStyle -> Directive[Gray, Thin]
];
Export[FileNameJoin[{baseDir, "ex45_image_positions.pdf"}], fig1];
Print["  Exported: ex45_image_positions.pdf"];

(* Image separation plot *)
fig2 = Plot[
    Sqrt[beta^2 + 4],
    {beta, 0, 5},
    PlotStyle -> {Purple, AbsoluteThickness[2]},
    PlotRange -> {{0, 5}, {1.5, 6}},
    AxesLabel -> {
        Style["\[Beta] (arcsec)", 13],
        Style["\[CapitalDelta]\[Theta] (arcsec)", 13]
    },
    PlotLabel -> Style["Image Separation (Exercise 4.5c)", 13],
    Epilog -> {
        Orange, Dashed, AbsoluteThickness[1.5],
        InfiniteLine[{{0, 2}, {10, 2}}],
        Text[Style["min = 2\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 10, Orange],
            {1, 2.15}]
    },
    ImageSize -> 550
];
Export[FileNameJoin[{baseDir, "ex45_image_separation.pdf"}], fig2];
Print["  Exported: ex45_image_separation.pdf"];

(* Total magnification plot *)
fig3 = Plot[
    {muTotalFunc[u], muPlusFunc[u], muMinusFunc[u]},
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
    PlotLabel -> Style["Magnification (Exercise 4.5d)", 13],
    PlotLegends -> Placed[
        LineLegend[{
            Style["Total", 11],
            Style["|\!\(\*SubscriptBox[\(\[Mu]\), \(+\)]\)|", 11],
            Style["|\!\(\*SubscriptBox[\(\[Mu]\), \(-\)]\)|", 11]
        }, LegendMarkerSize -> 15],
        {0.7, 0.7}],
    Epilog -> {
        Gray, Dashed, AbsoluteThickness[1],
        InfiniteLine[{{0, 1}, {10, 1}}],
        Text[Style["\[Mu] = 1", 9, Gray], {4.5, 1.3}]
    },
    ImageSize -> 550
];
Export[FileNameJoin[{baseDir, "ex45_magnification.pdf"}], fig3];
Print["  Exported: ex45_magnification.pdf"];

Print[""];
Print["Minimum image separation: Delta_theta_min = 2*thetaE = 2\""];
Print["  (occurs at beta = 0, the Einstein ring)\n"];

Print["For beta = thetaE (u = 1):"];
Print["  mu_total = (1 + 2)/(1 * sqrt(5)) = 3/sqrt(5) = ",
    NumberForm[3/Sqrt[5.0], {4, 3}]];
Print[""];

Print["=== End of Module 4 Solutions ==="];
