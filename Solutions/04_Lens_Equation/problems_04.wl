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
     Annotated-edition checks (2026-10) --- every identity / number quoted in
     the annotation, derivation and bridge boxes of 04_Lens_Equation.tex and
     04_Solutions.tex (appended section at the end; ends with summary[]).
     Fix-pass checks (2026-10-14) --- printed values / conditions changed after
     the 2026-10-14 fact-critic report, each failing on the old printed value.

   Outputs: printed solutions; ex45_*.pdf figures in Figures/04_Lens_Equation/;
            PASS/FAIL lines and a SUMMARY line for the annotated-edition checks
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

(* (b) Galaxy lensing — distances from Module 3 friedmann_equations.wl *)
Print["(b) Galaxy lensing: M = 10^12 Msun, zd = 0.3, zs = 1"];
Mgal = 1*^12 Msolar;
DdGal = 919 MpcToM;
DsGal = 1652 MpcToM;
DdsGal = 1055 MpcToM;
thetaEGal = thetaEfunc[Mgal, DdGal, DsGal, DdsGal];
Print["  Dd = 919 Mpc, Ds = 1652 Mpc, Dds = 1055 Mpc"];
Print["  thetaE = ", ScientificForm[thetaEGal, 4], " rad"];
Print["         = ", NumberForm[thetaEGal * radToArcsec, {4, 2}], " arcsec"];
REgal = DdGal * thetaEGal;
Print["  RE = ", NumberForm[REgal / kpcToM, {4, 1}], " kpc\n"];

(* (c) Cluster lensing — M_E ~ 2e14 inside Einstein radius (realistic
   massive cluster); distances at zd=0.3, zs=2 from Module 3. *)
Print["(c) Cluster lensing: M_E = 2e14 Msun within thetaE, zd = 0.3, zs = 2"];
Mclus = 2*^14 Msolar;
DdClus = 919 MpcToM;
DsClus = 1727 MpcToM;
DdsClus = 1328 MpcToM;
thetaEClus = thetaEfunc[Mclus, DdClus, DsClus, DdsClus];
Print["  Dd = 919 Mpc, Ds = 1727 Mpc, Dds = 1328 Mpc"];
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

(* Relative to this script (was an absolute path into the main checkout, which
   wrote figures outside a git worktree when run from one). *)
baseDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Figures", "04_Lens_Equation"}];

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
        }, LegendMarkerSize -> 15,
           Background -> Directive[White, Opacity[0.9]],
           Frame -> True, FrameStyle -> Gray],
        {0.85, 0.85}],
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
            {3.5, 1.85}]
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


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity and number quoted in the annotation / derivation / bridge
   boxes of Notes/04_Lens_Equation/04_Lens_Equation.tex and 04_Solutions.tex.
   Constants as in the chapter: G = 6.674e-11, c = 2.998e8 (SI), Msun = 1.989e30 kg,
   1 pc = 3.086e16 m.  Flat LambdaCDM, H0 = 70, Om = 0.3, OL = 0.7.            *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Mathematica", "harness.wl"}]];
Print["\n--- Annotated-edition checks (Module 4) ---"];
ClearAll[aG, aC, aMs, aPc, aKpc, aMpc, aAU, aRad2as, aDc, aDA, aDA2, aDd, aDs1, aDds1,
  aDs2, aDds2, aSig, aSigcr, aTE, aRE, aTp, aTm, aB, aMuP, aMuM, aXp, aXm, aU, aT, aBt,
  aDd0, aDs0, aDds0, aM0, aSigma, aTh, aTe];

aG = 6.674*^-11; aC = 2.998*^8; aMs = 1.989*^30;
aPc = 3.086*^16; aKpc = 3.086*^19; aMpc = 3.086*^22; aAU = 1.496*^11;
aRad2as = 180*3600/Pi;

(* --- distances used throughout the chapter --- *)
aDc[z_?NumericQ] := (299792.458/70) NIntegrate[1/Sqrt[0.3 (1 + zz)^3 + 0.7], {zz, 0, z}];
aDA[z_] := aDc[z]/(1 + z);
aDA2[z1_, z2_] := (aDc[z2] - aDc[z1])/(1 + z2);       (* flat universe only *)
aDd = aDA[0.3]; aDs1 = aDA[1.]; aDds1 = aDA2[0.3, 1.]; aDs2 = aDA[2.]; aDds2 = aDA2[0.3, 2.];
Print["  D_d, D_s(1), D_ds(1), D_s(2), D_ds(2) [Mpc] = ",
  NumberForm[{aDd, aDs1, aDds1, aDs2, aDds2}, 5]];
check["distances 919/1652/1055/1727/1328 Mpc reproduced to 1 Mpc (each rounds to the printed value)",
  Round[{aDd, aDs1, aDds1, aDs2, aDds2}] == {919, 1652, 1055, 1727, 1328}];
check["D_ds != D_s - D_d: D_s - D_d = 733 Mpc vs D_ds = 1055 Mpc",
  Round[aDs1 - aDd] == 733 && Round[aDds1] == 1055];
check["flat-universe identity (1+z_s) D_ds = (1+z_s) D_s - (1+z_d) D_d",
  Abs[(2.) aDds1 - (2. aDs1 - 1.3 aDd)] < 10^-6];

check["D_s - D_d underestimates D_ds (and D_ds/D_s) by ~30%: 1 - 733/1055 = 0.30",
  Round[1 - (aDs1 - aDd)/aDds1, 0.01] == 0.30];
check["2D shell theorem: Integrate_0^2pi (a - r cos p)/(a^2 + r^2 - 2 a r cos p) dp = 2pi/a (r<a), 0 (r>a)",
  Simplify[Integrate[(1 - rr Cos[pp])/(1 + rr^2 - 2 rr Cos[pp]), {pp, 0, 2 Pi},
      Assumptions -> 0 < rr < 1] == 2 Pi] &&
  Simplify[Integrate[(1 - rr Cos[pp])/(1 + rr^2 - 2 rr Cos[pp]), {pp, 0, 2 Pi},
      Assumptions -> rr > 1] == 0]];

(* --- small-angle approximation --- *)
check["Series tan(x)/x = 1 + x^2/3 + O(x^4)",
  Normal[Series[Tan[x]/x, {x, 0, 3}]] === 1 + x^2/3];
check["tan(theta)/theta - 1 < 2e-8 even for theta = 37 arcsec",
  Tan[37/aRad2as]/(37/aRad2as) - 1 < 2*^-8];

(* --- lens equation algebra --- *)
check["Ds*beta = (Ds/Dd)(Dd theta) - Dds ah  =>  beta = theta - (Dds/Ds) ah",
  Simplify[(((Ds/Dd) (Dd th) - Dds ah)/Ds) == th - (Dds/Ds) ah]];
check["reduced-deflection prefactor (Dds/Ds)(4G/c^2) Dd = 1/(pi Sigma_cr)",
  Simplify[(Dds/Ds) (4 GG/cc^2) Dd == 1/(Pi (cc^2/(4 Pi GG)) (Ds/(Dd Dds)))]];
check["lensing efficiency Dds/Ds = 0.64 (z_s=1), 0.77 (z_s=2)",
  Round[aDds1/aDs1, 0.01] == 0.64 && Round[aDds2/aDs2, 0.01] == 0.77];
aB = (aDds1/aDs1)/(aDds2/aDs2);
check["DSPL ratio B = (Dds1/Ds1)/(Dds2/Ds2) = 0.830 for z_s = 1, 2",
  Round[aB, 0.001] == 0.830];
check["point mass and SIS: thetaE(z_s2)^2/thetaE(z_s1)^2 resp. thetaE2/thetaE1 equal 1/B",
  Simplify[((Dds2/(Dd Ds2))/(Dds1/(Dd Ds1))) == 1/((Dds1/Ds1)/(Dds2/Ds2))]];

(* --- Sigma_cr --- *)
check["uniform disk: alpha = (Dds/Ds) 4 pi G Sigma Dd theta/c^2 = theta  =>  Sigma = Sigma_cr",
  Simplify[(Solve[(Dds/Ds) 4 Pi GG Sig Dd/cc^2 == 1, Sig])[[1, 1, 2]] ==
    cc^2/(4 Pi GG) Ds/(Dd Dds)]];
check["units: c^2/G/length = kg m^-2",
  Simplify[("Meters"/"Seconds")^2/("Meters"^3/("Kilograms" "Seconds"^2))/"Meters"] ==
    "Kilograms"/"Meters"^2];
aSigcr[dd_, ds_, dds_] := aC^2/(4 Pi aG) ds/(dd dds)/aMpc;     (* kg m^-2, inputs in Mpc *)
Print["  Sigma_cr(galaxy) = ", aSigcr[919, 1652, 1055], " kg/m^2 = ",
  aSigcr[919, 1652, 1055]/(aMs/aPc^2), " Msun/pc^2"];
check["1 Msun/pc^2 = 2.09e-3 kg/m^2 = 2.09e-4 g/cm^2; 1 g/cm^2 = 4.79e3 Msun/pc^2",
  Round[aMs/aPc^2, 0.00001] == 0.00209 && Round[10/(aMs/aPc^2), 10] == 4790];
check["Sigma_cr(z_d=0.3, z_s=1) = 5.9 kg/m^2 = 0.59 g/cm^2 = 2.8e3 Msun/pc^2",
  Round[aSigcr[919, 1652, 1055], 0.1] == 5.9 &&
  Round[aSigcr[919, 1652, 1055]/(aMs/aPc^2), 100] == 2800];
check["with c = 3e8 exactly (as in eq. sigma_cr_numerical) Sigma_cr = 2840 Msun/pc^2 to 10",
  Round[(3.*^8)^2/(4 Pi aG) 1652/(919 1055)/aMpc/(aMs/aPc^2), 10] == 2840];
check["c = 3e8 vs 2.998e8 changes Sigma_cr by 0.13% (2837 vs 2833 Msun/pc^2), i.e. ~0.1%",
  Abs[(3.*^8/aC)^2 - 1] < 0.002 && Round[(3.*^8)^2/(4 Pi aG) 1652/(919 1055)/aMpc/(aMs/aPc^2)] == 2837];
check["N&B handy form 0.35 g/cm^2 (D/Gpc)^-1, D = Dd Dds/Ds = 587 Mpc -> 0.59 g/cm^2",
  Round[aC^2/(4 Pi aG)/(1000 aMpc)/10, 0.01] == 0.35 && Round[919 1055/1652.] == 587 &&
  Round[0.347/(919 1055/1652./1000), 0.01] == 0.59];
check["Sigma_cr(z_d=0.3, z_s=2) = 4.9 kg/m^2 = 2.35e3 Msun/pc^2 (ratio to z_s=1 is B)",
  Round[aSigcr[919, 1727, 1328], 0.1] == 4.9 &&
  Round[aSigcr[919, 1727, 1328]/(aMs/aPc^2), 10] == 2350 &&
  Abs[aSigcr[919, 1727, 1328]/aSigcr[919, 1652, 1055] - (1055/1652.)/(1328/1727.)] < 10^-12];
check["kappa_0 = 5000/2833 = 1.8 for the elliptical of Ex. 4.4(d)",
  Round[5000/(aSigcr[919, 1652, 1055]/(aMs/aPc^2)), 0.1] == 1.8];

(* --- Einstein radius --- *)
check["alpha = (Dds/Ds) 4GM/(c^2 Dd theta) = thetaE^2/theta",
  Simplify[(Dds/Ds) 4 GG M/(cc^2 Dd th) == (4 GG M/cc^2 Dds/(Dd Ds))/th]];
check["mean convergence inside thetaE is 1: M = pi (Dd thetaE)^2 Sigma_cr",
  Simplify[Pi (Dd^2 (4 GG M/cc^2 Dds/(Dd Ds))) (cc^2/(4 Pi GG) Ds/(Dd Dds)) == M]];
aTE[m_, dd_, ds_, dds_, unit_] := Sqrt[4 aG m aMs/aC^2 dds/(dd ds)/unit];   (* rad *)
check["4 G Msun/c^2 = 5.91e3 m (twice the Schwarzschild radius of the Sun)",
  Round[4 aG aMs/aC^2, 10] == 5910];
check["microlensing (5,10,5 kpc): thetaE^2 = 1.91e-17, thetaE = 4.38e-9 rad = 0.90 mas",
  Round[aTE[1, 5, 10, 5, aKpc]^2*10^17, 0.01] == 1.91 &&
  Round[aTE[1, 5, 10, 5, aKpc]*10^9, 0.01] == 4.38 &&
  Round[aTE[1, 5, 10, 5, aKpc] aRad2as 1000, 0.01] == 0.90];
check["microlensing R_E = Dd thetaE = 6.8e11 m = 4.5 AU",
  Round[5 aKpc aTE[1, 5, 10, 5, aKpc]/10^11, 0.1] == 6.8 &&
  Round[5 aKpc aTE[1, 5, 10, 5, aKpc]/aAU, 0.1] == 4.5];
check["galaxy (1e12 Msun; 919/1652/1055): Dds/(Dd Ds) = 6.95e-4 /Mpc, thetaE = 1.15e-5 rad = 2.4\", R_E = 10.6 kpc",
  Round[1055/(919 1652.)*10^4, 0.01] == 6.95 &&
  Round[aTE[10^12, 919, 1652, 1055, aMpc] 10^5, 0.01] == 1.15 &&
  Round[aTE[10^12, 919, 1652, 1055, aMpc] aRad2as, 0.1] == 2.4 &&
  Round[919000 aTE[10^12, 919, 1652, 1055, aMpc], 0.1] == 10.6];
check["cluster M_E = 2e14 (919/1727/1328): thetaE = 1.79e-4 rad = 37\", R_E = 165 kpc",
  Round[aTE[2 10^14, 919, 1727, 1328, aMpc] 10^4, 0.01] == 1.79 &&
  Round[aTE[2 10^14, 919, 1727, 1328, aMpc] aRad2as] == 37 &&
  Round[919000 aTE[2 10^14, 919, 1727, 1328, aMpc], 5] == 165];
check["cluster with M = 1e15 inserted literally: thetaE = 83\" (sqrt 5 larger), R_E = 0.37 Mpc",
  Round[aTE[10^15, 919, 1727, 1328, aMpc] aRad2as] == 83 &&
  Round[919 aTE[10^15, 919, 1727, 1328, aMpc], 0.01] == 0.37];
check["scaling: thetaE = 0.90 mas (M/Msun)^(1/2) (Dd Ds/(Dds 10 kpc))^(-1/2); galaxy case Dd Ds/Dds = 1439 Mpc -> 2.4\"",
  Round[Sqrt[4 aG aMs/aC^2/(10 aKpc)] aRad2as 1000, 0.01] == 0.90 &&
  Round[919 1652/1055.] == 1439 &&
  Round[0.90*^-3 Sqrt[10^12] (919 1652/1055. 10^3/10)^(-1/2), 0.1] == 2.4];

(* --- Solutions-file derivation boxes (Ex. 4.1, 4.3, 4.4) --- *)
check["tan(x)/x - 1 < 1e-8 for x <= 1e-4 rad", Tan[1.*^-4]/1.*^-4 - 1 < 10^-8];
check["Ex 4.3(a): R_E = 2.2e-5 pc; thetaE = 9.0e-4 arcsec",
  Round[5 aKpc aTE[1, 5, 10, 5, aKpc]/aPc*10^5, 0.1] == 2.2 &&
  Round[aTE[1, 5, 10, 5, aKpc] aRad2as 10^4, 0.1] == 9.0];
check["Ex 4.3(b): 4GM/c^2 = 5.91e15 m; Dds/(Dd Ds) = 2.25e-26 /m; thetaE^2 = 1.33e-10",
  Round[4 aG 10^12 aMs/aC^2/10^15, 0.01] == 5.91 &&
  Round[1055/(919 1652.)/aMpc 10^26, 0.01] == 2.25 &&
  Round[aTE[10^12, 919, 1652, 1055, aMpc]^2 10^10, 0.01] == 1.33];
check["Ex 4.4(b): c^2/(4 pi G) = 1.07e26 kg/m; Ds/(Dd Dds) = 5.52e-26 /m; product 5.92 kg/m^2",
  Round[aC^2/(4 Pi aG)/10^26, 0.01] == 1.07 &&
  Round[1652/(919 1055.)/aMpc 10^26, 0.01] == 5.52 &&
  Round[aSigcr[919, 1652, 1055], 0.01] == 5.92];
check["Ex 4.4(c) shortcut: (1727/1328)/(1652/1055) = 0.83; 0.83 x 2833 = 2.35e3",
  Round[(1727/1328.)/(1652/1055.), 0.01] == 0.83 && Round[0.83 2833, 50] == 2350];
check["Ex 4.4(d) at z_s = 2: kappa_0 = 5000/2350 = 2.1", Round[5000/2350., 0.1] == 2.1];

(* --- point-mass quadratic --- *)
aTp = (b + Sqrt[b^2 + 4 t^2])/2; aTm = (b - Sqrt[b^2 + 4 t^2])/2;
check["theta(beta) = theta - t^2/theta times theta: theta^2 - beta theta - t^2 = 0 has roots theta_pm",
  Simplify[{aTp^2 - b aTp - t^2, aTm^2 - b aTm - t^2}] == {0, 0}];
check["Vieta: theta_+ theta_- = -thetaE^2 and theta_+ + theta_- = beta",
  Simplify[{aTp aTm, aTp + aTm}] == {-t^2, b}];
check["for beta>0, thetaE>0: theta_+ > thetaE > 0 > theta_- > -thetaE (Reduce)",
  Reduce[Exists[{b, t}, b > 0 && t > 0 && !(aTp > t && t > 0 && 0 > aTm && aTm > -t)], Reals] === False];
check["Vieta route: theta_+ |theta_-| = thetaE^2 with theta_+ > |theta_-| => geometric mean is thetaE",
  Simplify[aTp (-aTm) == t^2] && Simplify[aTp - (-aTm) == b]];
check["separation Delta theta = sqrt(beta^2 + 4 thetaE^2) >= 2 thetaE",
  Simplify[aTp - aTm == Sqrt[b^2 + 4 t^2]]];
check["large beta: theta_+ = beta + t^2/beta - t^4/beta^3 + ..., theta_- = -t^2/beta + t^4/beta^3 + ...",
  Simplify[Normal[Series[aTp /. b -> 1/e, {e, 0, 3}]] - (1/e + t^2 e - t^4 e^3), e > 0 && t > 0] == 0 &&
  Simplify[Normal[Series[aTm /. b -> 1/e, {e, 0, 3}]] - (-t^2 e + t^4 e^3), e > 0 && t > 0] == 0];

(* --- magnification --- *)
check["polar area elements: d^2beta/d^2theta = (beta dbeta)/(theta dtheta) = (beta/theta)(dbeta/dtheta) for a radial map",
  Simplify[Det[{{D[bt[r] Cos[p], r], D[bt[r] Cos[p], p]}, {D[bt[r] Sin[p], r], D[bt[r] Sin[p], p]}}]/
           Det[{{D[r Cos[p], r], D[r Cos[p], p]}, {D[r Sin[p], r], D[r Sin[p], p]}}] ==
    (bt[r]/r) bt'[r]]];
check["point mass: (beta/theta) = 1 - thetaE^2/theta^2, dbeta/dtheta = 1 + thetaE^2/theta^2, product 1 - thetaE^4/theta^4",
  Simplify[{(th - t^2/th)/th, D[th - t^2/th, th], (th - t^2/th)/th D[th - t^2/th, th]} ==
    {1 - t^2/th^2, 1 + t^2/th^2, 1 - t^4/th^4}]];
aXp = (aU + Sqrt[aU^2 + 4])/2; aXm = (aU - Sqrt[aU^2 + 4])/2;
check["x_- = -1/x_+, so x_-^4 = 1/x_+^4", Simplify[aXm == -1/aXp, aU > 0]];
check["x_+^2 + x_-^2 = u^2 + 2 and x_+^2 - x_-^2 = u sqrt(u^2+4)",
  Simplify[{aXp^2 + aXm^2, aXp^2 - aXm^2} == {aU^2 + 2, aU Sqrt[aU^2 + 4]}]];
aMuP = aXp^4/(aXp^4 - 1); aMuM = aXm^4/(aXm^4 - 1);
check["signed mu_+ + mu_- = 1 for every u > 0", Simplify[aMuP + aMuM == 1, aU > 0]];
check["(x_+^4+1)/(x_+^4-1) = (u^2+2)/(u sqrt(u^2+4)), hence mu_pm = 1/2 +- (u^2+2)/(2u sqrt(u^2+4)) signed",
  Simplify[(aXp^4 + 1)/(aXp^4 - 1) == (aU^2 + 2)/(aU Sqrt[aU^2 + 4]), aU > 0] &&
  Simplify[{aMuP, aMuM} == {1/2 + (aU^2 + 2)/(2 aU Sqrt[aU^2 + 4]), 1/2 - (aU^2 + 2)/(2 aU Sqrt[aU^2 + 4])}, aU > 0]];
check["u = 1: |mu_+| = 1.171, |mu_-| = 0.171, total 1.342 (N&B eq. 29: 1.17 + 0.17 = 1.34)",
  Round[{aMuP, -aMuM, aMuP - aMuM} /. aU -> 1., 0.001] == {1.171, 0.171, 1.342}];
check["u -> 0: total magnification = 1/u + O(u)",
  Normal[Series[(aU^2 + 2)/(aU Sqrt[aU^2 + 4]), {aU, 0, 0}]] === 1/aU];
check["Ex. 4.5 row beta = 0.5: sqrt(4.25) = 2.0616; (u^2+2)/(2u sqrt(u^2+4)) = 1.0914",
  Round[Sqrt[4.25], 0.0001] == 2.0616 && Round[2.25/Sqrt[4.25], 0.0001] == 1.0914];
check["Ex. 4.5 row beta = 0.5\": theta = +1.2808, -0.7808, Delta = 2.0616, |mu| = 1.591, 0.591",
  Round[{aTp, aTm, aTp - aTm} /. {b -> 0.5, t -> 1.}, 0.0001] == {1.2808, -0.7808, 2.0616} &&
  Round[{aMuP, -aMuM} /. aU -> 0.5, 0.001] == {1.591, 0.591}];
check["Ex. 4.5 row beta = 0.1\" (flag): theta = +1.0512, -0.9512, Delta = 2.0025; |mu| = 5.519, 4.519",
  Round[{aTp, aTm, aTp - aTm} /. {b -> 0.1, t -> 1.}, 0.0001] == {1.0512, -0.9512, 2.0025} &&
  Round[{aMuP, -aMuM} /. aU -> 0.1, 0.001] == {5.519, 4.519}];
check["Ex. 4.5 table: the pre-2026-10-14 beta = 0.1 row (1.025, -0.975) was the beta = 0.05 row",
  Round[{aTp, aTm} /. {b -> 0.05, t -> 1.}, 0.001] == {1.025, -0.975}];

(* ===== Fix-pass checks (2026-10-14, FACT_CRITIC_04_annotated_2026-10-14.md) =====
   Each check compares the value PRINTED in the visible text (a literal below)
   with the computed value, so it fails if the old printed value is restored. *)
Print["\n--- Fix-pass checks 2026-10-14 (Module 4) ---"];
ClearAll[fxPrinted, fxTE, fxRE, fxSig, fxPsi, fxAx, fxAy, fxImgs];

(* F1: Ex 4.3(a) microlensing, 04_Solutions.tex (old: 5.906e-10, 1.914e-30, 1.38e-15 rad, 0.28 mas, 14 AU) *)
fxPrinted = <|"4GM/c2 m" -> 5.906*^3, "thetaE^2" -> 1.914*^-17, "thetaE rad" -> 4.38*^-9,
   "thetaE mas" -> 0.90, "RE m" -> 6.8*^11, "RE Mpc" -> 2.2*^-11, "RE pc" -> 2.2*^-5, "RE AU" -> 4.5|>;
fxTE = aTE[1, 5, 10, 5, aKpc]; fxRE = 5 aKpc fxTE;
check["F1 Ex 4.3(a) printed 4GM/c^2 = 5.906e3 m and thetaE^2 = 5.906e3/3.086e20 = 1.914e-17 (to 0.1%)",
  Abs[fxPrinted["4GM/c2 m"]/(4 aG aMs/aC^2) - 1] < 0.001 &&
  Abs[fxPrinted["thetaE^2"]/(fxPrinted["4GM/c2 m"]/(10 aKpc)) - 1] < 0.001 &&
  Abs[fxPrinted["thetaE^2"]/fxTE^2 - 1] < 0.002];
check["F1 Ex 4.3(a) printed thetaE = 4.38e-9 rad = 0.90 mas (agrees with eq. thetaE_microlensing)",
  Round[fxTE, 10^-11] == fxPrinted["thetaE rad"] &&
  Round[fxTE aRad2as 1000, 0.01] == fxPrinted["thetaE mas"]];
check["F1 Ex 4.3(a) printed R_E = 6.8e11 m = 2.2e-11 Mpc = 2.2e-5 pc = 4.5 AU",
  Round[fxRE, 10^10] == fxPrinted["RE m"] && Round[fxRE/aMpc, 10^-12] == fxPrinted["RE Mpc"] &&
  Round[fxRE/aPc, 10^-6] == fxPrinted["RE pc"] && Round[fxRE/aAU, 0.1] == fxPrinted["RE AU"]];

(* F2: Ex 4.3(c) statement now gives M_E = 2e14 inside thetaE (old statement: M = 1e15) *)
fxPrinted = <|"M_E statement" -> 2*^14, "M200" -> 10^15, "thetaE arcsec" -> 37, "RE kpc" -> 165|>;
check["F2 Ex 4.3(c): statement mass M_E = 2e14 Msun reproduces the solution's 37\" and 165 kpc",
  Round[aTE[fxPrinted["M_E statement"], 919, 1727, 1328, aMpc] aRad2as] == fxPrinted["thetaE arcsec"] &&
  Round[919000 aTE[fxPrinted["M_E statement"], 919, 1727, 1328, aMpc], 5] == fxPrinted["RE kpc"]];
check["F2 Ex 4.3(c): the total M200 = 1e15 would NOT give 37\" (gives 83\")",
  Round[aTE[fxPrinted["M200"], 919, 1727, 1328, aMpc] aRad2as] == 83];

(* F3: Ex 4.5 table, beta = 0.1 row (old: +1.025, -0.975, 2.000) *)
fxPrinted = {0.1, 1.051, -0.951, 2.002, 5.519, 4.519};
check["F3 Ex 4.5 printed row beta = 0.1: theta+ = 1.051, theta- = -0.951, Delta = 2.002, |mu| = 5.519, 4.519",
  Round[{aTp, aTm, aTp - aTm} /. {b -> fxPrinted[[1]], t -> 1.}, 0.001] == fxPrinted[[2 ;; 4]] &&
  Round[{aMuP, -aMuM} /. aU -> fxPrinted[[1]], 0.001] == fxPrinted[[5 ;; 6]] &&
  Round[fxPrinted[[2]] + fxPrinted[[3]], 0.001] == fxPrinted[[1]]];

(* F5: Ex 4.4 (b) 2830 with c = 2.998e8 (old 2840), (c) 2350 (old 2360), (d) 5000/2830 = 1.8 *)
fxSig[ds_, dds_] := aSigcr[919, ds, dds]/(aMs/aPc^2);
check["F5 Ex 4.4(b) printed Sigma_cr = 2830 Msun/pc^2 with c = 2.998e8 (2840 only with c = 3e8)",
  Round[fxSig[1652, 1055], 10] == 2830 &&
  Round[(3.*^8/aC)^2 fxSig[1652, 1055], 10] == 2840];
check["F5 Ex 4.4(c) printed Sigma_cr(z_s = 2) = 2350 Msun/pc^2 = 4.9 kg/m^2 (D_ds = 1328 Mpc)",
  Round[fxSig[1727, 1328], 10] == 2350 && Round[aSigcr[919, 1727, 1328], 0.1] == 4.9];
check["F5 Ex 4.4(d) printed kappa_0 = 5000/2830 = 1.8; (c)-ratio (1727/1328)/(1652/1055) = 0.83",
  Round[5000/2830., 0.1] == 1.8 && Round[(1727/1328.)/(1652/1055.), 0.01] == 0.83];

(* X8: D_ds(z_d = 0.3, z_s = 2) printed as 1328 Mpc (old 1329; computed 1328.49) *)
check["X8 D_ds(0.3, 2) = 1328 Mpc to the nearest Mpc (flat LCDM, H0 = 70, Om = 0.3)",
  Round[aDds2] == 1328];
check["X8 the 1329 -> 1328 change moves no printed number: thetaE 37\", R_E 165 kpc, Sigma_cr 2350, B 0.830",
  Round[aTE[2 10^14, 919, 1727, 1329, aMpc] aRad2as] == Round[aTE[2 10^14, 919, 1727, 1328, aMpc] aRad2as] &&
  Round[919000 aTE[2 10^14, 919, 1727, 1329, aMpc], 5] == Round[919000 aTE[2 10^14, 919, 1727, 1328, aMpc], 5] &&
  Round[fxSig[1727, 1329], 10] == Round[fxSig[1727, 1328], 10] &&
  Round[(1055/1652.)/(1329/1727.), 0.001] == Round[(1055/1652.)/(1328/1727.), 0.001]];

(* F-a: bridge "source redshift enters only through Dds/Ds (Sigma_cr and D_Delta t)" *)
check["F-a Sigma_cr and the time-delay distance (1+zd) Dd Ds/Dds depend on (Ds, Dds) only through Ds/Dds",
  Simplify[D[(cc^2/(4 Pi GG)) (rr/Dd) /. rr -> Ds/Dds, Ds] Ds + D[(cc^2/(4 Pi GG)) (rr/Dd) /. rr -> Ds/Dds, Dds] Dds == 0] &&
  Simplify[D[(1 + zd) Dd Ds/Dds, Ds] Ds + D[(1 + zd) Dd Ds/Dds, Dds] Dds == 0]];

(* F4: kappa < 1 bullet now "axisymmetric" (C&K Sec. 2.5). Counter-example to the old
   unqualified claim: cored isothermal sphere psi = b sqrt(s^2 + theta^2), b = 1, s = 1.25,
   so kappa <= kappa(0) = b/s = 0.8 < 1 everywhere, plus external shear 0.4 -> 3 images;
   the same lens without shear (axisymmetric) gives 1 image. *)
fxImgs[gx_, src_] := Module[{ax, ay, sols},
  fxPsi = 1. Sqrt[1.25^2 + x^2 + y^2] + gx (x^2 - y^2)/2;
  ax = D[fxPsi, x]; ay = D[fxPsi, y];
  sols = Quiet@Flatten[Table[Check[{x, y} /. FindRoot[{x - ax == src[[1]], y - ay == src[[2]]},
        {{x, x0}, {y, y0}}], Nothing], {x0, -3, 3, 0.5}, {y0, -3, 3, 0.5}], 1];
  sols = Select[sols, Norm[({x - ax, y - ay} /. {x -> #[[1]], y -> #[[2]]}) - src] < 10^-8 &];
  Length[DeleteDuplicates[Round[sols, 10^-4]]]];
check["F4 kappa <= 0.8 everywhere for the cored isothermal (max at the centre = b/s)",
  Simplify[(D[Sqrt[s^2 + x^2 + y^2], {x, 2}] + D[Sqrt[s^2 + x^2 + y^2], {y, 2}])/2 /. {x -> 0, y -> 0}, s > 0] == 1/s &&
  Simplify[D[(D[Sqrt[s^2 + r^2], r, r] + D[Sqrt[s^2 + r^2], r]/r)/2, r] < 0, s > 0 && r > 0] && 1/1.25 == 0.8];
check["F4 with external shear 0.4 the kappa < 1 lens makes 3 images of beta = (0.02, 0.01); axisymmetric (no shear): 1",
  fxImgs[0.4, {0.02, 0.01}] == 3 && fxImgs[0., {0.02, 0.01}] == 1];

summary[];
