(* =========================================================================
   galaxy_lensing.wl
   Module 9: Strong Lensing by Galaxies: Applications
   =========================================================================
   Purpose: Mass from Einstein radius computation, mass-sheet degeneracy
            demonstration, power-law profile analysis, H0 from time delays,
            and figure generation.

   Sources: Congdon & Keeton Ch. 6.5-6.6
            Narayan & Bartelmann Sec. 3.6-3.7
            Treu (2010), Wong et al. (2020), Birrer et al. (2020)
            Schneider & Sluse (2014)

   Usage:   wolframscript -file galaxy_lensing.wl

   Outputs: Symbolic verification of all Module 9 results;
            PDF figures exported to Figures/09_Galaxy_Lensing_Applications/
   ========================================================================= *)

Print["=== Module 9: Strong Lensing by Galaxies --- Applications ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/09_Galaxy_Lensing_Applications";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];


(* =========================================================================
   Section 1: Cosmological Distance Calculator
   =========================================================================
   Angular diameter distances for flat LambdaCDM
   ========================================================================= *)

Print["--- Section 1: Cosmological Distances ---\n"];

(* Hubble parameter E(z) for flat LambdaCDM *)
EHz[z_, OmM_] := Sqrt[OmM (1 + z)^3 + (1 - OmM)];

(* Comoving distance (in units of c/H0) *)
comovingDistanceUnit[z_, OmM_] :=
    NIntegrate[1/EHz[zp, OmM], {zp, 0, z}];

(* Angular diameter distance (in units of c/H0) *)
angDiamDistUnit[z_, OmM_] := comovingDistanceUnit[z, OmM] / (1 + z);

(* Angular diameter distance between z1 and z2 (z1 < z2), flat universe *)
angDiamDistUnit12[z1_, z2_, OmM_] := Module[{chi1, chi2},
    chi1 = comovingDistanceUnit[z1, OmM];
    chi2 = comovingDistanceUnit[z2, OmM];
    (chi2 - chi1) / (1 + z2)
];

(* Convert to physical distance in Mpc *)
cOverH0[H0_] := (2.998*^5 / H0);  (* c/H0 in Mpc, H0 in km/s/Mpc *)

angDiamDist[z_, OmM_, H0_] := angDiamDistUnit[z, OmM] * cOverH0[H0];
angDiamDist12[z1_, z2_, OmM_, H0_] :=
    angDiamDistUnit12[z1, z2, OmM] * cOverH0[H0];

(* Standard cosmology parameters *)
H0std = 70.0;  (* km/s/Mpc *)
OmMstd = 0.3;

(* Physical constants *)
cLight = 2.998*^10;   (* cm/s *)
GNewton = 6.674*^-8;  (* cm^3 / (g s^2) *)
Msolar = 1.989*^33;   (* g *)
MpcToCm = 3.086*^24;  (* cm per Mpc *)
arcsecToRad = 4.848*^-6;  (* radians per arcsec *)
kpcToMpc = 1.0*^-3;

(* Test distances *)
Print["Distance test (flat LambdaCDM, H0=70, OmM=0.3):"];
Print["  D_d(z=0.3) = ", angDiamDist[0.3, OmMstd, H0std], " Mpc"];
Print["  D_s(z=1.0) = ", angDiamDist[1.0, OmMstd, H0std], " Mpc"];
Print["  D_ds(z_d=0.3, z_s=1.0) = ",
    angDiamDist12[0.3, 1.0, OmMstd, H0std], " Mpc"];
Print[""];


(* =========================================================================
   Section 2: Mass from Einstein Radius
   =========================================================================
   M_E = (c^2 / 4G) * thetaE^2 * Dd * Ds / Dds
   ========================================================================= *)

Print["--- Section 2: Mass from Einstein Radius ---\n"];

(* Einstein mass in grams *)
einsteinMass[thetaEArcsec_, zd_, zs_, OmM_, H0_] := Module[
    {Dd, Ds, Dds, thetaERad},
    Dd = angDiamDist[zd, OmM, H0] * MpcToCm;
    Ds = angDiamDist[zs, OmM, H0] * MpcToCm;
    Dds = angDiamDist12[zd, zs, OmM, H0] * MpcToCm;
    thetaERad = thetaEArcsec * arcsecToRad;
    (cLight^2 / (4 GNewton)) * thetaERad^2 * Dd * Ds / Dds
];

(* Einstein mass in solar masses *)
einsteinMassSolar[thetaEArcsec_, zd_, zs_, OmM_, H0_] :=
    einsteinMass[thetaEArcsec, zd, zs, OmM, H0] / Msolar;

(* Critical surface mass density in g/cm^2 *)
sigmaCr[zd_, zs_, OmM_, H0_] := Module[{Dd, Ds, Dds},
    Dd = angDiamDist[zd, OmM, H0] * MpcToCm;
    Ds = angDiamDist[zs, OmM, H0] * MpcToCm;
    Dds = angDiamDist12[zd, zs, OmM, H0] * MpcToCm;
    cLight^2 / (4 Pi GNewton) * Ds / (Dd * Dds)
];

(* Velocity dispersion from Einstein radius (SIE) in cm/s *)
sigmaVFromThetaE[thetaEArcsec_, zd_, zs_, OmM_, H0_] := Module[
    {Ds, Dds, thetaERad},
    Ds = angDiamDist[zs, OmM, H0] * MpcToCm;
    Dds = angDiamDist12[zd, zs, OmM, H0] * MpcToCm;
    thetaERad = thetaEArcsec * arcsecToRad;
    cLight * Sqrt[thetaERad * Ds / (4 Pi * Dds)]
];

(* Compute for the three case study systems *)
systems = {
    {"Q0957+561",  0.36, 1.41, 1.0},
    {"Q2237+0305", 0.04, 1.69, 0.9},
    {"B1608+656",  0.63, 1.39, 1.0}
};

Print["Einstein masses for real lens systems:"];
Print[StringPadRight["System", 15],
      StringPadRight["z_d", 8],
      StringPadRight["z_s", 8],
      StringPadRight["thetaE", 10],
      StringPadRight["M_E (Msun)", 18],
      StringPadRight["R_E (kpc)", 12],
      "sigma_v (km/s)"];

Do[
    Module[{name, zd, zs, tE, ME, RE, sigV, Dd},
        {name, zd, zs, tE} = sys;
        ME = einsteinMassSolar[tE, zd, zs, OmMstd, H0std];
        Dd = angDiamDist[zd, OmMstd, H0std];
        RE = Dd * tE * arcsecToRad * 1000;  (* in kpc *)
        sigV = sigmaVFromThetaE[tE, zd, zs, OmMstd, H0std] / 1.0*^5;  (* km/s *)
        Print[StringPadRight[name, 15],
              StringPadRight[ToString[zd], 8],
              StringPadRight[ToString[zs], 8],
              StringPadRight[ToString[tE] <> "\"", 10],
              StringPadRight[ScientificForm[ME, 3] // ToString, 18],
              StringPadRight[ToString[NumberForm[RE, {4, 1}]], 12],
              ToString[NumberForm[sigV, {4, 0}]]];
    ],
    {sys, systems}
];
Print[""];

(* Detailed computation for the example in the text *)
Print["Detailed example: SIE with thetaE = 1.5\", z_d = 0.3, z_s = 1.0:"];
Module[{Dd, Ds, Dds, SC, ME, sigV},
    Dd = angDiamDist[0.3, OmMstd, H0std];
    Ds = angDiamDist[1.0, OmMstd, H0std];
    Dds = angDiamDist12[0.3, 1.0, OmMstd, H0std];
    SC = sigmaCr[0.3, 1.0, OmMstd, H0std];
    ME = einsteinMassSolar[1.5, 0.3, 1.0, OmMstd, H0std];
    sigV = sigmaVFromThetaE[1.5, 0.3, 1.0, OmMstd, H0std] / 1.0*^5;
    Print["  D_d = ", Dd, " Mpc"];
    Print["  D_s = ", Ds, " Mpc"];
    Print["  D_ds = ", Dds, " Mpc"];
    Print["  Sigma_cr = ", ScientificForm[SC], " g/cm^2"];
    Print["  M_E = ", ScientificForm[ME, 3], " Msun"];
    Print["  sigma_v = ", NumberForm[sigV, {4, 0}], " km/s"];
];
Print[""];


(* =========================================================================
   Section 3: Mass-Sheet Degeneracy Demonstration
   =========================================================================
   kappa_lambda = lambda * kappa + (1 - lambda)
   beta_lambda = lambda * beta
   mu_lambda = mu / lambda^2
   Delta_t_lambda = lambda * Delta_t
   ========================================================================= *)

Print["--- Section 3: Mass-Sheet Degeneracy ---\n"];

(* SIS convergence and deflection for demonstration *)
kappaSIS[theta_, tE_] := tE / (2 theta);
alphaSIS[theta_, tE_] := tE;  (* radial deflection for SIS *)

(* MST-transformed convergence *)
kappaMST[theta_, tE_, lambda_] := lambda * kappaSIS[theta, tE] + (1 - lambda);

(* MST-transformed deflection *)
alphaMST[theta_, tE_, lambda_] := lambda * tE + (1 - lambda) * theta;

(* Verify lens equation invariance *)
Print["MST verification for SIS (thetaE = 1):"];
tEval = 1.0;
betaOrig = 0.3;  (* source position *)
thetaImg = 1.3;  (* an image position satisfying beta = theta - alpha *)

Print["  Original: beta = theta - alpha(theta) = ",
    thetaImg, " - ", alphaSIS[thetaImg, tEval], " = ",
    thetaImg - alphaSIS[thetaImg, tEval]];

Do[
    Module[{betaL, alphaL, residual},
        betaL = lambda * betaOrig;
        alphaL = alphaMST[thetaImg, tEval, lambda];
        residual = thetaImg - alphaL - betaL;
        Print["  lambda = ", lambda, ": beta_lambda = ", betaL,
            ", theta - alpha_lambda = ", thetaImg - alphaL,
            ", residual = ", residual];
    ],
    {lambda, {0.8, 0.9, 1.0, 1.1, 1.2}}
];
Print["  -> Image position unchanged for all lambda! (residual = 0)\n"];

(* Magnification scaling *)
Print["Magnification scaling under MST:"];
Print["  For SIS at theta = 1.3, thetaE = 1.0:"];
muOrig = 1.0 / (1 - tEval / thetaImg);
Print["    mu_original = ", muOrig];
Do[
    Module[{muL},
        muL = muOrig / lambda^2;
        Print["    lambda = ", lambda, ": mu_lambda = ", muL,
            " (= mu/lambda^2 = ", muOrig, "/", lambda^2, ")"];
    ],
    {lambda, {0.8, 0.9, 1.1, 1.2}}
];
Print[""];

(* Time delay scaling *)
Print["Time delay scaling under MST:"];
Print["  Delta_t_lambda = lambda * Delta_t"];
Print["  H0_inferred = lambda * H0_true"];
Print["  For lambda = 0.95 (kappa_s = 0.05):"];
Print["    H0_inferred/H0_true = 0.95 => 5% bias\n"];


(* =========================================================================
   Section 4: Power-Law Profile Analysis
   =========================================================================
   rho(r) = rho_0 (r/r_0)^{-gamma'}
   kappa(theta) = (3-gamma')/2 * (thetaE/theta)^{gamma'-1}
   ========================================================================= *)

Print["--- Section 4: Power-Law Profile ---\n"];

(* Convergence for power-law profile *)
kappaPL[theta_, tE_, gammaP_] := (3 - gammaP)/2 * (tE/theta)^(gammaP - 1);

(* Verify SIS limit gamma' = 2 *)
Print["Power-law convergence kappa(theta) = (3-gamma')/2 * (thetaE/theta)^(gamma'-1):"];
Print["  gamma' = 2 (SIS): kappa = ", kappaPL[1.3, 1.0, 2.0],
    " vs SIS: ", kappaSIS[1.3, 1.0], " => Match!\n"];

(* Mean convergence within theta *)
meanKappaPL[theta_, tE_, gammaP_] := Module[{},
    If[gammaP == 1,
        (3 - gammaP)/2 * Log[tE/theta],
        (3 - gammaP) / (2 (3 - gammaP)) *
        (tE/theta)^(gammaP - 1) *
        (3 - gammaP) / (3 - gammaP)
    ]
];

(* Compute kappa for various gamma' values *)
Print["Convergence profiles for different gamma':"];
Do[
    Print["  gamma' = ", gp, ": kappa(thetaE) = ",
        kappaPL[1.0, 1.0, gp],
        ", kappa(2*thetaE) = ", kappaPL[2.0, 1.0, gp]],
    {gp, {1.5, 1.8, 2.0, 2.2, 2.5}}
];
Print[""];

(* Enclosed mass scaling *)
Print["Enclosed 3D mass M(<r) for power-law:"];
Print["  M(<r) = 4*pi*rho_0*r_0^gamma' / (3-gamma') * r^(3-gamma')"];
Print["  For gamma' = 2: M(<r) ~ r (isothermal)"];
Print["  For gamma' = 1.5: M(<r) ~ r^1.5 (shallower)"];
Print["  For gamma' = 2.5: M(<r) ~ r^0.5 (steeper)\n"];

(* Velocity dispersion scaling *)
Print["Velocity dispersion sigma_v^2 ~ M(<R)/R ~ R^(2-gamma'):"];
Do[
    Print["  gamma' = ", gp, ": sigma_v^2 ~ R^", 2 - gp],
    {gp, {1.5, 2.0, 2.5}}
];
Print["  For gamma' = 2: sigma_v is independent of R (isothermal!) \n"];


(* =========================================================================
   Section 5: H0 from Time Delays
   =========================================================================
   Delta_t = (1+z_d)/c * Dd*Ds/Dds * Delta_tau
   H0 = (1+z_d) * Delta_tau / (c * Delta_t) * (c/H0 distances factor)
   ========================================================================= *)

Print["--- Section 5: H0 from Time Delays ---\n"];

(* Time-delay distance D_Delta_t = (1+z_d)*Dd*Ds/Dds *)
timeDelayDist[zd_, zs_, OmM_, H0_] := Module[{Dd, Ds, Dds},
    Dd = angDiamDist[zd, OmM, H0];
    Ds = angDiamDist[zs, OmM, H0];
    Dds = angDiamDist12[zd, zs, OmM, H0];
    (1 + zd) * Dd * Ds / Dds
];

(* H0 from time delay *)
(* Method: compute predicted Delta_t for reference H0, then scale.
   Delta_t = D_Delta_t/c * Delta_tau (D_Delta_t in cm, c in cm/s)
   Since D_Delta_t ~ 1/H0, we have H0 = H0_ref * dt_pred/dt_obs *)
h0FromTimeDelay[deltaTDays_, deltaTauArcsec2_, zd_, zs_, OmM_,
    H0ref_: 70.0] :=
    Module[{DdtRef, DdtCm, deltaTSec, deltaTauRad2, dtPredicted},
    DdtRef = timeDelayDist[zd, zs, OmM, H0ref];
    DdtCm = DdtRef * MpcToCm;
    deltaTSec = deltaTDays * 86400.0;
    deltaTauRad2 = deltaTauArcsec2 * arcsecToRad^2;
    dtPredicted = DdtCm / cLight * deltaTauRad2;  (* seconds *)
    H0ref * dtPredicted / deltaTSec
];

(* Example: Exercise 9.3 *)
Print["H0 from time delay (Exercise 9.3 parameters):"];
Print["  z_d = 0.6, z_s = 1.5, Delta_t = 80 days, Delta_tau = 0.64 arcsec^2"];

Module[{DdtRef, deltaTSec, deltaTauRad2, H0est},
    DdtRef = timeDelayDist[0.6, 1.5, OmMstd, H0std];
    Print["  D_Delta_t (H0=70) = ", DdtRef, " Mpc"];

    (* Self-consistent approach:
       Delta_t = D_Delta_t/c * Delta_tau
       where D_Delta_t in cm, c in cm/s => Delta_t in seconds.
       Since D_Delta_t scales as 1/H0:
       H0_true = H0_ref * Delta_t_predicted(H0_ref) / Delta_t_observed *)
    deltaTSec = 80.0 * 86400.0;
    deltaTauRad2 = 0.64 * arcsecToRad^2;

    Module[{DdtCm, dtPredicted},
        DdtCm = DdtRef * MpcToCm;  (* D_Delta_t in cm for H0=70 *)
        dtPredicted = DdtCm / cLight * deltaTauRad2;  (* seconds *)
        Print["  Predicted Delta_t (H0=70) = ",
            dtPredicted / 86400.0, " days"];
        H0est = H0std * dtPredicted / deltaTSec;
        Print["  H0 = H0_ref * (Delta_t_predicted / Delta_t_observed)"];
        Print["  H0 = 70 * ", dtPredicted / deltaTSec];
        Print["  H0 = ", NumberForm[H0est, {4, 1}], " km/s/Mpc"];
    ];
];
Print[""];

(* Effect of mass sheet on H0 *)
Print["Mass-sheet effect on H0:"];
Do[
    Print["  kappa_s = ", 1 - lambda,
        " (lambda = ", lambda, "): H0_inferred = ",
        lambda * 73.0, " km/s/Mpc"],
    {lambda, {0.90, 0.95, 0.98, 1.00, 1.02, 1.05}}
];
Print[""];


(* =========================================================================
   Section 6: Generate Figures
   ========================================================================= *)

Print["--- Section 6: Generating Figures ---\n"];


(* ---- Figure 1: Mass from Einstein Radius ---- *)
(* Plot M_E vs thetaE for different redshift configurations *)
Module[{configs, colors, labels, fig1},
    configs = {
        {0.3, 1.0, "z_d=0.3, z_s=1.0"},
        {0.5, 1.5, "z_d=0.5, z_s=1.5"},
        {0.2, 0.6, "z_d=0.2, z_s=0.6"}
    };
    colors = {Blue, Red, Darker[Green]};

    fig1 = Plot[
        Evaluate[Table[
            einsteinMassSolar[tE, configs[[i, 1]], configs[[i, 2]],
                OmMstd, H0std] / 1.0*^11,
            {i, 3}
        ]],
        {tE, 0.3, 3.0},
        PlotStyle -> Table[{colors[[i]], AbsoluteThickness[2]}, {i, 3}],
        AxesLabel -> {
            Style["Einstein radius " <> ToString[Subscript["\[Theta]", "E"], StandardForm] <> " (arcsec)", 13],
            Style[Row[{"Enclosed mass ", Subscript["M", "E"],
                " (", Superscript["10", "11"], " ", Subscript["M", "\[CircleDot]"], ")"}], 13]
        },
        PlotLabel -> Style["Einstein Mass vs Einstein Radius", 14, Bold],
        PlotRange -> {{0.3, 3.0}, {0, 20}},
        PlotLegends -> Placed[
            LineLegend[colors, Table[Style[configs[[i, 3]], 11], {i, 3}],
                LegendMarkerSize -> 20],
            {0.3, 0.75}
        ],
        Frame -> True,
        FrameLabel -> {
            Style[Row[{Subscript["\[Theta]", "E"], " (arcsec)"}], 13],
            Style[Row[{Subscript["M", "E"], " (", Superscript["10", "11"],
                " ", Subscript["M", "\[CircleDot]"], ")"}], 13]
        },
        GridLines -> Automatic,
        ImageSize -> 500
    ];

    Export[FileNameJoin[{baseDir, "einstein_mass_vs_radius.pdf"}], fig1,
        ImageSize -> 500];
    Print["  Exported: einstein_mass_vs_radius.pdf"];
];


(* ---- Figure 2: Mass-Sheet Degeneracy Visualization ---- *)
Module[{lambdaVals, colors, fig2},
    lambdaVals = {0.8, 0.9, 1.0, 1.1, 1.2};
    colors = {Red, Orange, Black, Blue, Darker[Green]};

    fig2 = GraphicsRow[{
        (* Left: Convergence profiles *)
        Plot[
            Evaluate[Table[
                kappaMST[theta, 1.0, lam],
                {lam, lambdaVals}
            ]],
            {theta, 0.3, 3.0},
            PlotStyle -> Table[{colors[[i]], AbsoluteThickness[2],
                If[lambdaVals[[i]] == 1.0, Identity, Dashed]}, {i, 5}],
            Frame -> True,
            FrameLabel -> {
                Style["\[Theta] (arcsec)", 13],
                Style["\[Kappa](\[Theta])", 13]
            },
            PlotLabel -> Style["Convergence profiles", 13],
            PlotRange -> {{0.3, 3.0}, {-0.5, 2.5}},
            ImageSize -> 300,
            Epilog -> {
                Gray, Dashed, AbsoluteThickness[1],
                InfiniteLine[{{0, 1}, {10, 1}}],
                Text[Style["\[Kappa] = 1", 10, Gray],
                    Scaled[{0.85, 0.42}]]
            }
        ],

        (* Right: Magnification scaling *)
        Module[{muOrigVals, lambdaRange},
            muOrigVals = {2, 5, 10};
            Plot[
                Evaluate[Table[
                    mu0 / lam^2,
                    {mu0, muOrigVals}
                ]],
                {lam, 0.7, 1.3},
                PlotStyle -> {
                    {Blue, AbsoluteThickness[2]},
                    {Red, AbsoluteThickness[2]},
                    {Darker[Green], AbsoluteThickness[2]}
                },
                Frame -> True,
                FrameLabel -> {
                    Style["\[Lambda]", 13],
                    Style[Row[{Subscript["\[Mu]", "\[Lambda]"]}], 13]
                },
                PlotLabel -> Style[Row[{Subscript["\[Mu]", "\[Lambda]"],
                    " = \[Mu]/", Superscript["\[Lambda]", "2"]}], 13],
                PlotRange -> {{0.7, 1.3}, {0, 25}},
                ImageSize -> 300,
                PlotLegends -> Placed[
                    LineLegend[{Blue, Red, Darker[Green]},
                        {Style["\[Mu] = 2", 10],
                         Style["\[Mu] = 5", 10],
                         Style["\[Mu] = 10", 10]},
                        LegendMarkerSize -> 15],
                    {0.75, 0.8}
                ],
                Epilog -> {
                    Gray, Dashed, AbsoluteThickness[1],
                    InfiniteLine[{{1, 0}, {1, 100}}]
                }
            ]
        ]
    }, Spacings -> 1];

    Export[FileNameJoin[{baseDir, "mass_sheet_degeneracy.pdf"}], fig2,
        ImageSize -> 700];
    Print["  Exported: mass_sheet_degeneracy.pdf"];
];


(* ---- Figure 3: Power-Law Convergence Profiles ---- *)
Module[{gammaVals, colors, fig3},
    gammaVals = {1.5, 1.8, 2.0, 2.2, 2.5};
    colors = {Red, Orange, Black, Blue, Darker[Green]};

    fig3 = GraphicsRow[{
        (* Left: Convergence profiles *)
        LogLogPlot[
            Evaluate[Table[kappaPL[theta, 1.0, gp], {gp, gammaVals}]],
            {theta, 0.1, 5.0},
            PlotStyle -> Table[{colors[[i]], AbsoluteThickness[2],
                If[gammaVals[[i]] == 2.0, Identity, Dashed]}, {i, 5}],
            Frame -> True,
            FrameLabel -> {
                Style[Row[{"\[Theta]/", Subscript["\[Theta]", "E"]}], 13],
                Style["\[Kappa](\[Theta])", 13]
            },
            PlotLabel -> Style["Convergence profiles", 13],
            PlotRange -> {{0.1, 5}, {0.01, 10}},
            ImageSize -> 300,
            PlotLegends -> Placed[
                LineLegend[colors,
                    Table[Style["\[Gamma]' = " <> ToString[gp], 10],
                        {gp, gammaVals}],
                    LegendMarkerSize -> 15],
                {0.75, 0.8}
            ]
        ],

        (* Right: Enclosed mass scaling *)
        Plot[
            Evaluate[Table[theta^(3 - gp), {gp, gammaVals}]],
            {theta, 0.1, 3.0},
            PlotStyle -> Table[{colors[[i]], AbsoluteThickness[2],
                If[gammaVals[[i]] == 2.0, Identity, Dashed]}, {i, 5}],
            Frame -> True,
            FrameLabel -> {
                Style["r / " <> ToString[Subscript["r", "0"], StandardForm], 13],
                Style["M(<r) / " <> ToString[Subscript["M", "0"], StandardForm], 13]
            },
            PlotLabel -> Style[Row[{"M(<r) \[Proportional] ",
                Superscript["r", "3-\[Gamma]'"]}], 13],
            PlotRange -> {{0.1, 3.0}, {0, 6}},
            ImageSize -> 300
        ]
    }, Spacings -> 1];

    Export[FileNameJoin[{baseDir, "power_law_profiles.pdf"}], fig3,
        ImageSize -> 700];
    Print["  Exported: power_law_profiles.pdf"];
];


(* ---- Figure 4: H0 from Time Delays --- Effect of MSD ---- *)
Module[{fig4},
    fig4 = GraphicsRow[{
        (* Left: H0 inferred vs lambda *)
        Plot[lambda * 73.3, {lambda, 0.8, 1.2},
            PlotStyle -> {Blue, AbsoluteThickness[2]},
            Frame -> True,
            FrameLabel -> {
                Style["\[Lambda]", 13],
                Style[Row[{Subscript["H", "0"],
                    " (km/s/Mpc)"}], 13]
            },
            PlotLabel -> Style[Row[{Superscript["H", "inferred"], " = \[Lambda] ",
                Superscript["H", "true"]}], 13],
            PlotRange -> {{0.8, 1.2}, {55, 95}},
            ImageSize -> 300,
            Epilog -> {
                (* Planck band *)
                {LightBlue, Opacity[0.5],
                 Rectangle[{0.75, 66.9}, {1.25, 67.9}]},
                (* SH0ES band *)
                {LightRed, Opacity[0.5],
                 Rectangle[{0.75, 72.0}, {1.25, 74.0}]},
                (* H0LiCOW point *)
                {Red, PointSize[0.02], Point[{1.0, 73.3}]},
                (* Labels *)
                Text[Style["Planck", 9, Blue],
                    {1.15, 67.4}],
                Text[Style["H0LiCOW", 9, Red],
                    {1.12, 73.3}],
                (* Lambda = 1 line *)
                {Gray, Dashed, AbsoluteThickness[1],
                 InfiniteLine[{{1, 0}, {1, 100}}]}
            }
        ],

        (* Right: Time delay vs H0 *)
        Plot[{
            80.0 * (70.0 / h0),    (* Delta_t scales as 1/H0 *)
            80.0 * (70.0 / h0) * 0.95  (* with lambda = 0.95 *)
        }, {h0, 60, 85},
            PlotStyle -> {
                {Blue, AbsoluteThickness[2]},
                {Red, AbsoluteThickness[2], Dashed}
            },
            Frame -> True,
            FrameLabel -> {
                Style[Row[{Subscript["H", "0"],
                    " (km/s/Mpc)"}], 13],
                Style["\[CapitalDelta]t (days)", 13]
            },
            PlotLabel -> Style["\[CapitalDelta]t \[Proportional] 1/" <>
                ToString[Subscript["H", "0"], StandardForm], 13],
            PlotRange -> {{60, 85}, {50, 110}},
            ImageSize -> 300,
            PlotLegends -> Placed[
                LineLegend[{Blue, Red},
                    {Style["\[Lambda] = 1", 10],
                     Style["\[Lambda] = 0.95", 10]},
                    LegendMarkerSize -> 15],
                {0.7, 0.8}
            ]
        ]
    }, Spacings -> 1];

    Export[FileNameJoin[{baseDir, "h0_time_delay.pdf"}], fig4,
        ImageSize -> 700];
    Print["  Exported: h0_time_delay.pdf"];
];


(* ---- Figure 5: Lensing + Kinematics: breaking the degeneracy ---- *)
Module[{fig5},
    (* Plot sigma_v^2/sigma_v0^2 vs gamma' for fixed M_E *)
    fig5 = Plot[
        {
            (* Rough scaling: sigma_v^2 ~ R_ap^(2-gamma') * M_E^1 *)
            (* Normalized to gamma'=2 *)
            (0.5)^(2 - gp) / (0.5)^0  (* R_ap/R_E = 0.5 *)
        },
        {gp, 1.2, 2.8},
        PlotStyle -> {Blue, AbsoluteThickness[2]},
        Frame -> True,
        FrameLabel -> {
            Style["\[Gamma]' (density slope)", 13],
            Style[Row[{Superscript["\[Sigma]", "2"], "/",
                Subscript[Superscript["\[Sigma]", "2"], "iso"]}], 13]
        },
        PlotLabel -> Style[Row[{Superscript["\[Sigma]", "2"],
            " vs \[Gamma]' for fixed ", Subscript["M", "E"]}], 14, Bold],
        PlotRange -> {{1.2, 2.8}, {0, 3}},
        ImageSize -> 450,
        Epilog -> {
            (* Mark isothermal *)
            {Gray, Dashed, AbsoluteThickness[1],
             InfiniteLine[{{2, 0}, {2, 10}}]},
            {Gray, Dashed, AbsoluteThickness[1],
             InfiniteLine[{{0, 1}, {10, 1}}]},
            Text[Style["isothermal\n(\[Gamma]' = 2)", 10, Gray],
                {2.0, 1.5}],
            (* SLACS range *)
            {LightGreen, Opacity[0.3],
             Rectangle[{1.8, 0}, {2.2, 3}]},
            Text[Style["SLACS\nrange", 9, Darker[Green]],
                {2.5, 2.5}]
        },
        GridLines -> Automatic
    ];

    Export[FileNameJoin[{baseDir, "lensing_kinematics.pdf"}], fig5,
        ImageSize -> 450];
    Print["  Exported: lensing_kinematics.pdf"];
];


Print["\n=== Module 9 complete. All figures exported. ==="];
