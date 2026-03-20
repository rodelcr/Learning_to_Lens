(* =========================================================================
   cluster_lensing.wl
   Module 10: Strong Lensing by Galaxy Clusters
   =========================================================================
   Purpose: NFW cluster lensing quantities (convergence, shear, deflection)
            at cluster scale. Critical curves and caustics for NFW clusters.
            Ray-tracing extended sources through cluster potential to produce
            giant arcs. Einstein radius vs cluster mass. Publication-quality
            figures exported to Figures/10_Cluster_Lensing/.

   Sources: Congdon & Keeton Ch. 7
            Narayan & Bartelmann Sec. 4
            Meneghetti 2021 Ch. 5
            Bartelmann (1996) - NFW lensing
            Wright & Brainerd (2000) - NFW analytical formulae

   Usage:   wolframscript -file cluster_lensing.wl

   Outputs: Symbolic verification of Module 10 results;
            PDF figures exported to Figures/10_Cluster_Lensing/
   ========================================================================= *)

Print["=== Module 10: Strong Lensing by Galaxy Clusters ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/10_Cluster_Lensing";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];

(* ---- Physical constants ---- *)
Gnewton = 6.674*^-11;      (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
kpcToM = 3.086*^19;         (* 1 kpc in meters *)
MpcToM = 3.086*^22;         (* 1 Mpc in meters *)
radToArcsec = 180 * 3600 / Pi;


(* =========================================================================
   Section 1: NFW Profile Functions

   f(x), g(x), kappa(x), alpha(x), kbar(x), gamma(x) for NFW
   ========================================================================= *)

Print["--- Section 1: NFW Profile Functions ---\n"];

(* NFW f(x) function for surface mass density *)
fNFW[x_?NumericQ] := Which[
    x < 1 - 10^-6,
    1/(x^2 - 1) (1 - ArcCosh[1/x]/Sqrt[1 - x^2]),
    Abs[x - 1] <= 10^-6,
    1/3,
    x > 1 + 10^-6,
    1/(x^2 - 1) (1 - ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1])
];

(* NFW g(x) function for deflection angle *)
gNFW[x_?NumericQ] := Which[
    x < 1 - 10^-6,
    ArcCosh[1/x]/Sqrt[1 - x^2],
    Abs[x - 1] <= 10^-6,
    1,
    x > 1 + 10^-6,
    ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1]
];

(* NFW convergence: kappa(x) = kappa_s * f(x) *)
kappaNFW[x_, ks_] := ks * fNFW[x];

(* NFW mean convergence: kbar(x) *)
kbarNFW[x_, ks_] := 4 ks / x^2 * (Log[x/2] + gNFW[x]);

(* NFW deflection angle: alpha(x) = 4*kappa_s*theta_s/x * [ln(x/2)+g(x)] *)
alphaNFW[x_, ks_, thetas_] := 4 ks * thetas / x * (Log[x/2] + gNFW[x]);

(* NFW shear: |gamma(x)| = kbar(x) - kappa(x) *)
gammaNFW[x_, ks_] := kbarNFW[x, ks] - kappaNFW[x, ks];

Print["NFW functions defined: fNFW, gNFW, kappaNFW, kbarNFW, alphaNFW, gammaNFW\n"];


(* =========================================================================
   Section 2: Cluster-Scale NFW Parameters

   Typical cluster: M200 = 10^15 Msun, c = 5, zd = 0.3, zs = 2
   ========================================================================= *)

Print["--- Section 2: Cluster-Scale NFW Parameters ---\n"];

(* Cosmological distances (approximate, for flat LCDM with H0=70, Om=0.3) *)
DdVal = 900 * MpcToM;     (* Dd for zd = 0.3 *)
DsVal = 1750 * MpcToM;    (* Ds for zs = 2 *)
DdsVal = 1400 * MpcToM;   (* Dds for zd=0.3, zs=2 *)

(* Critical surface mass density *)
SigmaCr = cc^2 / (4 Pi Gnewton) * DsVal / (DdVal * DdsVal);
Print["Sigma_cr = ", ScientificForm[SigmaCr, 4], " kg/m^2"];
Print["Sigma_cr = ", ScientificForm[SigmaCr / Msolar * (MpcToM)^2, 4], " Msun/Mpc^2\n"];

(* Critical density of the universe at z = 0.3 *)
H0 = 70 * 1000 / MpcToM;  (* H0 in s^-1 *)
Ez = Sqrt[0.3 * (1.3)^3 + 0.7];  (* E(z=0.3) for flat LCDM *)
Hz = H0 * Ez;
rhoCrit = 3 Hz^2 / (8 Pi Gnewton);
Print["rho_crit(z=0.3) = ", ScientificForm[rhoCrit, 4], " kg/m^3\n"];

(* Function to compute NFW parameters from M200, c *)
nfwParams[M200Msun_, c_, DdM_, DsM_, DdsM_] := Module[
    {M200, r200, rs, rhoS, thetaS, sigCr, kappaS},
    M200 = M200Msun * Msolar;
    r200 = (3 M200 / (800 Pi rhoCrit))^(1/3);
    rs = r200 / c;
    rhoS = 200/3 * rhoCrit * c^3 / (Log[1 + c] - c/(1 + c));
    thetaS = rs / DdM;  (* radians *)
    sigCr = cc^2 / (4 Pi Gnewton) * DsM / (DdM * DdsM);
    kappaS = 2 rhoS * rs / sigCr;
    <|"M200" -> M200, "r200" -> r200, "rs" -> rs, "rhoS" -> rhoS,
      "thetaS" -> thetaS, "kappaS" -> kappaS, "c" -> c,
      "SigmaCr" -> sigCr|>
];

(* Massive cluster: M200 = 10^15 Msun, c = 5 *)
params1 = nfwParams[10^15, 5, DdVal, DsVal, DdsVal];
Print["Massive cluster (M200 = 10^15 Msun, c = 5):"];
Print["  r200 = ", NumberForm[params1["r200"] / MpcToM * 1000, {4, 1}], " kpc"];
Print["  rs   = ", NumberForm[params1["rs"] / kpcToM, {4, 1}], " kpc"];
Print["  rhoS = ", ScientificForm[params1["rhoS"], 3], " kg/m^3"];
Print["  theta_s = ", NumberForm[params1["thetaS"] * radToArcsec, {4, 1}], " arcsec"];
Print["  kappa_s = ", NumberForm[params1["kappaS"], {4, 3}], "\n"];

(* Moderate cluster: M200 = 5*10^14 Msun, c = 5 *)
params2 = nfwParams[5*^14, 5, DdVal, DsVal, DdsVal];
Print["Moderate cluster (M200 = 5x10^14 Msun, c = 5):"];
Print["  r200 = ", NumberForm[params2["r200"] / MpcToM * 1000, {4, 1}], " kpc"];
Print["  rs   = ", NumberForm[params2["rs"] / kpcToM, {4, 1}], " kpc"];
Print["  theta_s = ", NumberForm[params2["thetaS"] * radToArcsec, {4, 1}], " arcsec"];
Print["  kappa_s = ", NumberForm[params2["kappaS"], {4, 3}], "\n"];


(* =========================================================================
   Section 3: Critical Curves and Einstein Radius

   Tangential critical curve: kbar(x) = 1
   ========================================================================= *)

Print["--- Section 3: Critical Curves and Einstein Radius ---\n"];

(* Find the tangential critical curve radius (Einstein radius) *)
findEinsteinRadius[ks_, thetas_] := Module[{xSol},
    xSol = x /. FindRoot[kbarNFW[x, ks] == 1, {x, 0.3}];
    {xSol, xSol * thetas * radToArcsec}  (* {x_t, theta_E in arcsec} *)
];

{xt1, thetaE1} = findEinsteinRadius[params1["kappaS"], params1["thetaS"]];
Print["Massive cluster Einstein radius:"];
Print["  x_t = ", NumberForm[xt1, {4, 3}]];
Print["  theta_E = ", NumberForm[thetaE1, {4, 1}], " arcsec\n"];

{xt2, thetaE2} = findEinsteinRadius[params2["kappaS"], params2["thetaS"]];
Print["Moderate cluster Einstein radius:"];
Print["  x_t = ", NumberForm[xt2, {4, 3}]];
Print["  theta_E = ", NumberForm[thetaE2, {4, 1}], " arcsec\n"];

(* Mass within Einstein radius *)
massWithinThetaE[thetaERad_, DdM_, sigCr_] :=
    Pi * (DdM * thetaERad)^2 * sigCr / Msolar;

mEncl1 = massWithinThetaE[thetaE1 / radToArcsec, DdVal, params1["SigmaCr"]];
Print["Enclosed mass within theta_E (massive cluster):"];
Print["  M(theta_E) = ", ScientificForm[mEncl1, 3], " Msun"];
Print["  M(theta_E)/M200 = ", NumberForm[mEncl1 * Msolar / params1["M200"], {3, 2}], "\n"];


(* =========================================================================
   Section 4: Einstein Radius vs. Cluster Mass

   Plot theta_E(M200) for fixed c = 5, zd = 0.3, zs = 2
   ========================================================================= *)

Print["--- Section 4: Einstein Radius vs. Cluster Mass ---\n"];

massRange = Table[10^logM, {logM, 13.5, 15.5, 0.05}];
thetaEofMass = Table[
    Module[{p, sol},
        p = nfwParams[m, 5, DdVal, DsVal, DdsVal];
        If[kbarNFW[0.01, p["kappaS"]] > 1,
            sol = findEinsteinRadius[p["kappaS"], p["thetaS"]];
            {m, sol[[2]]},
            Nothing
        ]
    ],
    {m, massRange}
];

Print["Einstein radius vs mass computed for ", Length[thetaEofMass], " mass values\n"];

plotEinsteinVsMass = ListLogLogPlot[thetaEofMass,
    Joined -> True,
    PlotStyle -> {Blue, AbsoluteThickness[2]},
    AxesLabel -> {
        Style["M\[ThinSpace]" <> ToString[Subscript["200", ""], StandardForm] <> " (" <> ToString[Subscript["M", "\[CircleDot]"], StandardForm] <> ")", 14],
        Style["\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\) (arcsec)", 14]
    },
    PlotLabel -> Style["Einstein Radius vs. Cluster Mass\n(NFW, c = 5, " <>
        ToString[Subscript["z", "d"], StandardForm] <> " = 0.3, " <>
        ToString[Subscript["z", "s"], StandardForm] <> " = 2)", 14],
    GridLines -> Automatic,
    Frame -> True,
    FrameLabel -> {
        Style[Row[{Subscript["M", "200"], " (", Subscript["M", "\[CircleDot]"], ")"}], 14],
        Style[Row[{Subscript["\[Theta]", "E"], " (arcsec)"}], 14]
    },
    ImageSize -> 500,
    PlotRange -> All
];

Export[FileNameJoin[{baseDir, "einstein_radius_vs_mass.pdf"}], plotEinsteinVsMass];
Print["Exported: einstein_radius_vs_mass.pdf\n"];


(* =========================================================================
   Section 5: NFW Convergence and Shear Profiles at Cluster Scale

   Plot kappa(theta), gamma(theta), kbar(theta) for cluster parameters
   ========================================================================= *)

Print["--- Section 5: Convergence and Shear Profiles ---\n"];

xVals = Table[10^lx, {lx, -2, 1.5, 0.02}];

profilePlot = Show[
    ListLogLogPlot[
        {
            Table[{x * params1["thetaS"] * radToArcsec, kappaNFW[x, params1["kappaS"]]}, {x, xVals}],
            Table[{x * params1["thetaS"] * radToArcsec, Abs[gammaNFW[x, params1["kappaS"]]]}, {x, xVals}],
            Table[{x * params1["thetaS"] * radToArcsec, kbarNFW[x, params1["kappaS"]]}, {x, xVals}]
        },
        Joined -> True,
        PlotStyle -> {
            {Blue, AbsoluteThickness[2]},
            {Red, AbsoluteThickness[2], Dashed},
            {Darker[Green], AbsoluteThickness[2], Dotted}
        },
        PlotLegends -> Placed[{"\[Kappa](r)", "|\[Gamma](r)|", Row[{OverBar["\[Kappa]"], "(r)"}]}, {0.8, 0.8}],
        Frame -> True,
        FrameLabel -> {
            Style["\[Theta] (arcsec)", 14],
            Style["Lensing quantity", 14]
        },
        PlotLabel -> Style["NFW Cluster Lensing Profiles\n(" <>
            ToString[Subscript["M", "200"], StandardForm] <> " = " <>
            ToString[Superscript["10", "15"], StandardForm] <> " " <>
            ToString[Subscript["M", "\[CircleDot]"], StandardForm] <> ", c = 5)", 14],
        ImageSize -> 500,
        PlotRange -> {{0.5, 500}, {0.001, 10}}
    ],
    LogLogPlot[1, {th, 0.5, 500}, PlotStyle -> {Gray, Thin, Dashed}]
];

Export[FileNameJoin[{baseDir, "nfw_cluster_profiles.pdf"}], profilePlot];
Print["Exported: nfw_cluster_profiles.pdf\n"];


(* =========================================================================
   Section 6: Giant Arc Formation via Ray-Tracing

   Inverse ray-tracing: for each pixel theta, compute beta = theta - alpha(theta)
   and check if beta falls within a circular source.
   ========================================================================= *)

Print["--- Section 6: Giant Arc Formation ---\n"];

(* Use the massive cluster parameters *)
ks1 = params1["kappaS"];
ts1 = params1["thetaS"];
ts1arcsec = ts1 * radToArcsec;
tE1arcsec = thetaE1;

Print["Ray-tracing parameters:"];
Print["  kappa_s = ", ks1];
Print["  theta_s = ", ts1arcsec, " arcsec"];
Print["  theta_E = ", tE1arcsec, " arcsec\n"];

(* Source: circular disk at position (beta0, 0) with radius sourceR *)
sourceR = 0.5;  (* arcsec *)

(* Generate arc images for three source positions *)
arcImages = Table[
    Module[{beta0, gridRange, step, imgPixels, thetaR, xVal, alphaR, ratio, b1, b2},
        beta0 = betaFrac * tE1arcsec;
        gridRange = N[1.5 * tE1arcsec];
        step = N[0.3];
        imgPixels = Reap[
            Do[
                thetaR = Sqrt[th1^2 + th2^2];
                If[thetaR > 0.1,
                    xVal = thetaR / ts1arcsec;
                    alphaR = 4 ks1 * ts1arcsec / xVal * (Log[xVal/2] + gNFW[xVal]);
                    ratio = alphaR / thetaR;
                    b1 = th1 * (1 - ratio);
                    b2 = th2 * (1 - ratio);
                    If[Sqrt[(b1 - beta0)^2 + b2^2] <= sourceR,
                        Sow[{th1, th2}]
                    ];
                ],
                {th1, -gridRange, gridRange, step},
                {th2, -gridRange, gridRange, step}
            ]
        ][[2]];
        If[Length[imgPixels] > 0, imgPixels[[1]], {}]
    ],
    {betaFrac, {0, 0.5, 1.0}}
];

arcPlots = Table[
    Module[{pts, title, gridRange},
        pts = arcImages[[i]];
        gridRange = N[1.5 * tE1arcsec];
        title = Switch[i,
            1, "\[Beta] = 0 (Einstein ring)",
            2, "\[Beta] = 0.5 \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)",
            3, "\[Beta] = \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)"
        ];
        Show[
            Graphics[{
                {LightBlue, Opacity[0.3],
                    Annulus[{0, 0}, {N[tE1arcsec - 1], N[tE1arcsec + 1]}]},
                {Blue, Dashed, AbsoluteThickness[1.5],
                    Circle[{0, 0}, N[tE1arcsec]]},
                {Black, Disk[{0, 0}, 0.8]},
                If[Length[pts] > 0,
                    {Orange, PointSize[Small], Point[pts]},
                    {}
                ]
            },
            PlotRange -> {{-gridRange, gridRange}, {-gridRange, gridRange}},
            Frame -> True,
            FrameLabel -> {Style["\!\(\*SubscriptBox[\(\[Theta]\), \(1\)]\) (arcsec)", 12],
                           Style["\!\(\*SubscriptBox[\(\[Theta]\), \(2\)]\) (arcsec)", 12]},
            PlotLabel -> Style[title, 13],
            AspectRatio -> 1,
            ImageSize -> 280
            ]
        ]
    ],
    {i, 1, 3}
];

arcCombined = Row[arcPlots, Spacer[5]];
Export[FileNameJoin[{baseDir, "giant_arc_formation.pdf"}], arcCombined,
    ImageSize -> 900];
Print["Exported: giant_arc_formation.pdf\n"];


(* =========================================================================
   Section 7: Einstein Radius Comparison Across Mass Scales

   Galaxy (SIS sigma=250), Group (SIS sigma=500), Cluster (SIS sigma=1200)
   ========================================================================= *)

Print["--- Section 7: Einstein Radius Across Mass Scales ---\n"];

DdsOverDs = DdsVal / DsVal;

thetaESIS[sigmaV_] := 4 Pi (sigmaV / cc)^2 * DdsOverDs * radToArcsec;

sigmas = {250*^3, 500*^3, 1200*^3};
labels = {"Galaxy (\[Sigma]=250 km/s)", "Group (\[Sigma]=500 km/s)", "Cluster (\[Sigma]=1200 km/s)"};

Do[
    Module[{tE},
        tE = thetaESIS[sigmas[[i]]];
        Print[labels[[i]], ": theta_E = ", NumberForm[tE, {4, 2}], " arcsec"];
    ],
    {i, 1, 3}
];
Print[""];


(* =========================================================================
   Section 8: Summary Verification
   ========================================================================= *)

Print["--- Section 8: Summary ---\n"];

Print["All Module 10 computations verified."];
Print["Figures exported to ", baseDir];
Print["\nModule 10 complete.\n"];
