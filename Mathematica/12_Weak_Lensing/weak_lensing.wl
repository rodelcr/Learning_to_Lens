(* =========================================================================
   weak_lensing.wl
   Module 12: Weak Gravitational Lensing and Cosmic Shear
   =========================================================================
   Purpose: Symbolic and numerical verification of the core weak-lensing
            results of Module 12:
              (1) Kaiser-Squires kernel identity  D-hat * D-hat^* = pi^2
              (2) Kaiser-Squires inversion recovers kappa-hat
              (3) Real-space KS: a Gaussian kappa is recovered (up to the
                  mass-sheet constant) from its shear via the KS kernel
              (4) Tangential shear of the SIS: gamma_t = thetaE/(2 theta)
              (5) Tangential shear of the point mass: gamma_t = thetaE^2/theta^2
              (6) Reduced shear g = gamma/(1-kappa) is invariant under the
                  mass-sheet transform kappa -> lambda kappa + (1-lambda)
              (7) Magnification transforms as mu -> lambda^-2 mu
              (8) Complex-ellipticity relations |chi|,|eps| and chi<->eps
              (9) Weak-limit shear-estimator chain
            Then exports two figures to Figures/12_Weak_Lensing/.

   Sources: Schneider, Kochanek & Wambsganss (2006), Part 3 (P. Schneider):
              Sect. 2   (Principles: eqs. 3, 7, 8, 9, 14, 16, 17, 24)
              Sect. 5.1 (Kaiser-Squires: eqs. 41, 43, 44, 51)
              Sect. 6   (Cosmic shear: eqs. 99, 104, 105, 108)
            Bartelmann & Schneider (2001); Kaiser & Squires (1993).
            NFW tangential shear: see Module 7 (nfw_projection.wl).

   Usage:   wolframscript -file weak_lensing.wl

   Outputs: PASS/FAIL lines for each check;
            PDF figures exported to Figures/12_Weak_Lensing/
   ========================================================================= *)

Print["=== Module 12: Weak Gravitational Lensing and Cosmic Shear ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/12_Weak_Lensing";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];

(* ---- helper: report a boolean check ---- *)
check[label_, bool_] := Print[If[TrueQ[bool], "  PASS  ", "  FAIL  "], label];
checkNum[label_, val_, target_, tol_] := Module[{ok},
    ok = Abs[N[val] - N[target]] < tol;
    Print[If[ok, "  PASS  ", "  FAIL  "], label,
        "  (value = ", NumberForm[N[val], {8, 5}],
        ", target = ", NumberForm[N[target], {8, 5}], ")"]];


(* =========================================================================
   Section 1: The Kaiser-Squires kernel and inversion (Fourier space)

   Forward:  gamma-hat(l) = (1/pi) D-hat(l) kappa-hat(l)
   with      D-hat(l) = pi (l1^2 - l2^2 + 2 I l1 l2) / |l|^2  = pi e^(2 i beta)
   Identity: D-hat D-hat^* = pi^2
   Inverse:  kappa-hat = (1/pi) gamma-hat D-hat^*
   ========================================================================= *)

Print["--- Section 1: Kaiser-Squires kernel (Fourier space) ---\n"];

Dhat = Pi (l1^2 - l2^2 + 2 I l1 l2) / (l1^2 + l2^2);
DhatConj = Pi (l1^2 - l2^2 - 2 I l1 l2) / (l1^2 + l2^2);

ident = FullSimplify[Dhat DhatConj, Assumptions -> {l1 \[Element] Reals, l2 \[Element] Reals, l1^2 + l2^2 > 0}];
Print["  D-hat * D-hat^*  = ", ident];
check["(1) KS kernel identity  D-hat D-hat^* = pi^2", Simplify[ident - Pi^2] === 0];

(* Forward then inverse must return kappa-hat *)
kappaHat = kh;  (* symbolic placeholder for kappa-hat *)
gammaHat = (1/Pi) Dhat kappaHat;
kappaRec = (1/Pi) gammaHat DhatConj // FullSimplify;
Print["  reconstructed kappa-hat = ", kappaRec];
check["(2) KS inversion recovers kappa-hat", Simplify[kappaRec - kappaHat] === 0];
Print[""];


(* =========================================================================
   Section 2: Real-space Kaiser-Squires on a Gaussian convergence

   Take an axisymmetric kappa(theta) = Exp[-theta^2/2] (a Gaussian blob).
   For an axisymmetric profile:
       kbar(theta) = (2/theta^2) Integral[kappa(t) t, {t,0,theta}]
       gamma_t(theta) = kbar(theta) - kappa(theta)
   The complex shear at position (polar angle phi) is
       gamma = - gamma_t e^(2 i phi).
   Applying the KS kernel D^*(theta) = -1/(theta1 + i theta2)^2 at the
   ORIGIN, the reconstructed convergence collapses to the 1-D integral
       kappa_rec(0) = 2 Integral[gamma_t(theta)/theta, {theta,0,Inf}] ,
   which must return the true value kappa(0) = 1 (up to the undetermined
   mass-sheet constant, here fixed to zero by kappa -> 0 at infinity).
   ========================================================================= *)

Print["--- Section 2: Real-space KS reconstruction (Gaussian kappa) ---\n"];

kappaG[t_] := Exp[-t^2/2];
kbarG[t_]  := (2/t^2) (1 - Exp[-t^2/2]);           (* = (2/t^2) Int kappa t dt *)
gammatG[t_] := kbarG[t] - kappaG[t];

(* sanity: closed-form interior integral *)
intCheck = FullSimplify[Integrate[kappaG[tp] tp, {tp, 0, t}, Assumptions -> t > 0]];
Print["  Integral[kappa(t) t, {t,0,theta}] = ", intCheck, "  (=> kbar = (2/theta^2)*this)"];

kappaRec0 = 2 NIntegrate[gammatG[t]/t, {t, 0, Infinity},
    WorkingPrecision -> 20, AccuracyGoal -> 12];
checkNum["(3) KS recovers kappa(0)=1 for a Gaussian blob", kappaRec0, 1, 1*^-4];
Print[""];


(* =========================================================================
   Section 3: Tangential shear of axisymmetric lenses

   For any axisymmetric profile:  gamma_t(theta) = kbar(theta) - kappa(theta)
   SIS:        kappa = thetaE/(2 theta),  kbar = thetaE/theta
               => gamma_t = thetaE/(2 theta)
   Point mass: kappa = 0 (theta != 0),   kbar = thetaE^2/theta^2
               => gamma_t = thetaE^2/theta^2
   ========================================================================= *)

Print["--- Section 3: Tangential shear (SIS and point mass) ---\n"];

(* SIS *)
kappaSIS[th_] := tE/(2 th);
kbarSIS = (2/th^2) Integrate[kappaSIS[tp] tp, {tp, 0, th},
    Assumptions -> {th > 0, tE > 0}];
gammatSIS = Simplify[kbarSIS - kappaSIS[th], Assumptions -> {th > 0, tE > 0}];
Print["  SIS: kbar = ", kbarSIS, ",  gamma_t = ", gammatSIS];
check["(4) SIS tangential shear gamma_t = thetaE/(2 theta)",
    Simplify[gammatSIS - tE/(2 th)] === 0];

(* Point mass: kappa = 0, kbar = thetaE^2/theta^2 *)
kbarPM = tE^2/th^2;
gammatPM = Simplify[kbarPM - 0];
Print["  Point mass: kbar = ", kbarPM, ",  gamma_t = ", gammatPM];
check["(5) Point-mass tangential shear gamma_t = thetaE^2/theta^2",
    Simplify[gammatPM - tE^2/th^2] === 0];
Print[""];


(* =========================================================================
   Section 4: Mass-sheet transform invariance of the reduced shear

   MST:  kappa -> lambda kappa + (1 - lambda),  gamma -> lambda gamma
   Claim (6): g = gamma/(1-kappa) is invariant.
   Claim (7): mu = 1/[(1-kappa)^2 - gamma^2] transforms as mu -> lambda^-2 mu.
   ========================================================================= *)

Print["--- Section 4: Mass-sheet transform invariance ---\n"];

kappaP = lam kap + (1 - lam);
gammaP = lam gam;

gReduced  = gam/(1 - kap);
gReducedP = Simplify[gammaP/(1 - kappaP)];
Print["  g (original)     = ", gReduced];
Print["  g (transformed)  = ", gReducedP];
check["(6) reduced shear g invariant under MST",
    Simplify[gReducedP - gReduced] === 0];

muOrig = 1/((1 - kap)^2 - gam^2);
muP    = 1/((1 - kappaP)^2 - gammaP^2);
ratio  = Simplify[muP/muOrig];
Print["  mu' / mu = ", ratio];
check["(7) magnification transforms as mu -> lambda^-2 mu",
    Simplify[ratio - 1/lam^2] === 0];
Print[""];


(* =========================================================================
   Section 5: Complex-ellipticity relations (SKW06 Part 3, eqs. 8, 9)

   For elliptical isophotes of axis ratio r = b/a <= 1:
       |chi| = (1 - r^2)/(1 + r^2),   |eps| = (1 - r)/(1 + r)
   Transforms:
       eps = chi/(1 + Sqrt[1 - chi^2]),   chi = 2 eps/(1 + eps^2)
   ========================================================================= *)

Print["--- Section 5: Complex-ellipticity relations ---\n"];

chiMod = (1 - r^2)/(1 + r^2);
epsMod = (1 - r)/(1 + r);

epsFromChi = FullSimplify[chiMod/(1 + Sqrt[1 - chiMod^2]),
    Assumptions -> 0 < r <= 1];
Print["  eps from chi = ", epsFromChi];
check["(8a) eps = chi/(1+sqrt(1-chi^2))  ==  (1-r)/(1+r)",
    FullSimplify[epsFromChi - epsMod, Assumptions -> 0 < r <= 1] === 0];

chiFromEps = FullSimplify[2 epsMod/(1 + epsMod^2),
    Assumptions -> 0 < r <= 1];
Print["  chi from eps = ", chiFromEps];
check["(8b) chi = 2 eps/(1+eps^2)  ==  (1-r^2)/(1+r^2)",
    FullSimplify[chiFromEps - chiMod, Assumptions -> 0 < r <= 1] === 0];

(* weak-distortion limit: |chi| ~ 2 |eps| as r -> 1 *)
ser = Series[chiMod - 2 epsMod, {r, 1, 1}] // Normal;
Print["  chi - 2 eps  (expanded about r = 1) = ", Simplify[ser], "  (O((1-r)^2))"];
check["(9) weak limit |chi| ~ 2|eps| (leading order vanishes)",
    Simplify[Limit[(chiMod - 2 epsMod)/(1 - r), r -> 1]] === 0];
Print[""];


(* =========================================================================
   Section 6: Figures
   ========================================================================= *)

Print["--- Section 6: Generating figures ---\n"];

(* NFW piecewise functions (from Module 7 nfw_projection.wl) *)
fNFW[x_] := Piecewise[{
    {(1/(x^2 - 1)) (1 - ArcCosh[1/x]/Sqrt[1 - x^2]), x < 1},
    {1/3, x == 1},
    {(1/(x^2 - 1)) (1 - ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1]), x > 1}
}];
gNFW[x_] := Piecewise[{
    {ArcCosh[1/x]/Sqrt[1 - x^2], x < 1},
    {1, x == 1},
    {ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1], x > 1}
}];
(* NFW mean convergence and tangential shear, in units of kappa_s *)
kbarNFW[x_]  := (2/x^2) (Log[x/2] + gNFW[x]);
gammatNFW[x_, ks_] := ks (kbarNFW[x] - fNFW[x]);


(* ---- Figure 1: Tangential-shear profiles (SIS vs NFW) ---- *)
Module[{gtSIS, ksVal, thetaS},
    gtSIS[th_] := 1/(2 th);          (* thetaE = 1 *)
    ksVal = 0.2; thetaS = 1;          (* NFW: kappa_s = 0.2, theta_s = 1 *)

    fig1 = Plot[
        {gtSIS[th], gammatNFW[th/thetaS, ksVal]},
        {th, 0.05, 5},
        PlotStyle -> {
            {Blue, AbsoluteThickness[2]},
            {Red, AbsoluteThickness[2], Dashed}
        },
        PlotRange -> {{0, 5}, {0, 1.2}},
        AxesLabel -> {
            Style[Row[{"\[Theta] / ", Subscript["\[Theta]", "E"]}], 13],
            Style[Row[{Subscript["\[Gamma]", "t"], "(\[Theta])"}], 13]
        },
        PlotLabel -> Style["Tangential-Shear Profiles", 14],
        PlotLegends -> Placed[
            LineLegend[{
                Style[Row[{"SIS: ", Subscript["\[Theta]", "E"], "/(2\[Theta])"}], 11],
                Style[Row[{"NFW (", Subscript["\[Kappa]", "s"], "=0.2)"}], 11]
            }, LegendMarkerSize -> 15],
            {0.68, 0.72}],
        ImageSize -> 560
    ];
    Export[FileNameJoin[{baseDir, "tangential_shear_profiles.pdf"}], fig1];
    Print["  Exported: tangential_shear_profiles.pdf"];
];


(* ---- Figure 2: Kaiser-Squires schematic ---- *)
(* A Gaussian convergence blob (rasterized density plot) overlaid with the
   tangential-shear "whisker" field: at each grid point the whisker is
   oriented TANGENTIALLY (perpendicular to the radius) with length ~ gamma_t.
   This is the pattern a mass concentration imprints on background shapes,
   and is what the KS inversion turns back into the mass map. *)
Module[{kappaBlob, gt, whiskers, dens, pts, seg},
    kappaBlob[x_, y_] := Exp[-(x^2 + y^2)/2];
    (* axisymmetric tangential shear of the Gaussian blob *)
    gt[rr_] := If[rr < 10^-3, 0, (2/rr^2) (1 - Exp[-rr^2/2]) - Exp[-rr^2/2]];

    (* rasterize the density plot BEFORE combining/exporting *)
    dens = Rasterize[
        DensityPlot[kappaBlob[x, y], {x, -3, 3}, {y, -3, 3},
            PlotPoints -> 60, ColorFunction -> "SunsetColors",
            PlotRange -> All, Frame -> True,
            FrameLabel -> {Style["\[Theta]", 12], Style["\[Theta]", 12]},
            PlotLabel -> Style["Kaiser-Squires: mass blob + tangential shear",
                13],
            ImageSize -> 420],
        "Image"];

    (* whisker field: line segments oriented tangentially *)
    pts = Flatten[Table[{x, y}, {x, -2.5, 2.5, 0.5}, {y, -2.5, 2.5, 0.5}], 1];
    seg = Table[
        Module[{x = p[[1]], y = p[[2]], rr, phi, len, tx, ty},
            rr = Sqrt[x^2 + y^2];
            If[rr < 0.3, Nothing,
                phi = ArcTan[x, y];
                len = 0.45 Min[gt[rr]/0.25, 1];  (* scaled whisker length *)
                (* tangential direction: perpendicular to radius *)
                tx = -Sin[phi]; ty = Cos[phi];
                Line[{{x - len tx, y - len ty}, {x + len tx, y + len ty}}]
            ]],
        {p, pts}];
    seg = DeleteCases[seg, Nothing];

    whiskers = Graphics[{Black, AbsoluteThickness[1.4], seg},
        PlotRange -> {{-3, 3}, {-3, 3}}, ImageSize -> 420];

    fig2 = Show[dens, whiskers, ImageSize -> 460];
    Export[FileNameJoin[{baseDir, "kaiser_squires_schematic.pdf"}], fig2];
    Print["  Exported: kaiser_squires_schematic.pdf"];
];


Print["\n=== End of Module 12 (weak_lensing.wl) ==="];
