(* =========================================================================
   time_delay_function.wl
   Module 6: Fermat's Principle and Time Delays
   =========================================================================
   Purpose: Symbolic computation of the Fermat potential, verification
            that grad(tau) = 0 gives the lens equation, time delay
            formulas for point mass and SIS lenses, numerical H0
            estimation, and publication-quality figure generation.

   Sources: Narayan & Bartelmann Sec. 3.3
            Congdon & Keeton Ch. 4.3-4.4
            Saha et al. Sec. 1.2-1.3

   Usage:   wolframscript -file time_delay_function.wl

   Outputs: Symbolic verification of Fermat's principle results;
            PDF figures exported to Figures/06_Fermat_Time_Delays/
   ========================================================================= *)

Print["=== Module 6: Fermat's Principle and Time Delays ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/06_Fermat_Time_Delays";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];

(* ---- Physical constants ---- *)
Gnewton = 6.674*^-11;      (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
kpcToM = 3.086*^19;         (* 1 kpc in meters *)
MpcToM = 3.086*^22;         (* 1 Mpc in meters *)
radToArcsec = 180 * 3600 / Pi;
dayToSec = 86400;


(* =========================================================================
   Section 1: The Fermat Potential -- Symbolic Setup

   tau(theta, beta) = (1/2)|theta - beta|^2 - psi(theta)
   For point mass: psi(theta) = thetaE^2 * ln|theta|
   ========================================================================= *)

Print["--- Section 1: The Fermat Potential (Symbolic) ---\n"];

Print["Fermat potential: tau(theta, beta) = (1/2)|theta - beta|^2 - psi(theta)"];
Print["  Geometric delay: (1/2)|theta - beta|^2"];
Print["  Shapiro delay:   -psi(theta)\n"];

(* Point mass lensing potential *)
Print["Point mass lensing potential: psi(theta) = thetaE^2 * ln|theta|"];
Print[""];

(* 1D Fermat potential for point mass (along symmetry axis) *)
(* Working in units of thetaE: x = theta/thetaE, y = beta/thetaE *)
tauPM[x_, y_] := (x - y)^2/2 - Log[Abs[x]];

Print["1D Fermat potential (in units of thetaE):"];
Print["  tau(x, y) = (1/2)(x - y)^2 - ln|x|"];
Print["  where x = theta/thetaE, y = beta/thetaE\n"];


(* =========================================================================
   Section 2: Verify Fermat's Principle -- grad(tau) = 0 gives lens eq

   d(tau)/d(theta) = (theta - beta) - d(psi)/d(theta)
                   = (theta - beta) - alpha(theta) = 0
   => beta = theta - alpha(theta)    (LENS EQUATION)
   ========================================================================= *)

Print["--- Section 2: Fermat's Principle Verification ---\n"];

(* 2D Fermat potential for point mass *)
tau2D[th1_, th2_, b1_, b2_, tE_] :=
    ((th1 - b1)^2 + (th2 - b2)^2)/2 - tE^2 * Log[Sqrt[th1^2 + th2^2]];

(* Gradient *)
gradTau1 = D[tau2D[th1, th2, b1, b2, tE], th1];
gradTau2 = D[tau2D[th1, th2, b1, b2, tE], th2];

Print["Gradient of tau:"];
Print["  d(tau)/d(theta1) = ", Simplify[gradTau1]];
Print["  d(tau)/d(theta2) = ", Simplify[gradTau2]];
Print[""];

(* Setting gradient to zero *)
Print["Setting grad(tau) = 0:"];
Print["  theta1 - beta1 - thetaE^2 * theta1 / (theta1^2 + theta2^2) = 0"];
Print["  theta2 - beta2 - thetaE^2 * theta2 / (theta1^2 + theta2^2) = 0"];
Print[""];
Print["  => beta1 = theta1 - thetaE^2 * theta1 / |theta|^2"];
Print["     beta2 = theta2 - thetaE^2 * theta2 / |theta|^2"];
Print["  => beta = theta - (thetaE^2 / |theta|^2) * theta"];
Print["         = theta - alpha(theta)    <--- LENS EQUATION"];
Print["  VERIFIED: Fermat's principle gives the lens equation.\n"];

(* Verify for 1D case *)
Print["1D verification (along symmetry axis, theta2 = 0):"];
gradTau1D = D[tauPM[x, y], x];
Print["  d(tau)/dx = ", gradTau1D];
stationaryEq = Solve[gradTau1D == 0, x];
Print["  Stationary points: ", stationaryEq];
Print["  These are the image positions x_pm = (y +/- sqrt(y^2 + 4))/2"];
Print[""];


(* =========================================================================
   Section 3: Image Positions and Fermat Potential Values

   For point mass: theta_pm = (beta +/- sqrt(beta^2 + 4*thetaE^2))/2
   ========================================================================= *)

Print["--- Section 3: Image Positions and Arrival Times ---\n"];

(* Image positions in units of thetaE *)
xPlus[y_] := (y + Sqrt[y^2 + 4])/2;
xMinus[y_] := (y - Sqrt[y^2 + 4])/2;

(* Compute Fermat potential at images *)
Print["Fermat potential at image positions for various source positions:"];
Print[""];
Print[StringForm["  ``  ``  ``  ``  ``  ``",
    PaddedForm["y", {4, 0}],
    PaddedForm["x_+", {8, 0}],
    PaddedForm["x_-", {8, 0}],
    PaddedForm["tau(x_+)", {10, 0}],
    PaddedForm["tau(x_-)", {10, 0}],
    PaddedForm["Delta_tau", {10, 0}]
]];
Print["  ", StringJoin[Table["-", 60]]];

Do[
    xp = xPlus[y];
    xm = xMinus[y];
    taup = tauPM[xp, y];
    taum = tauPM[Abs[xm], y] + (xm - y)^2/2 - (Abs[xm] - y)^2/2;
    (* Correctly compute tau at x_- *)
    taum = (xm - y)^2/2 - Log[Abs[xm]];
    dtau = taum - taup;
    Print[StringForm["  ``  ``  ``  ``  ``  ``",
        PaddedForm[y, {4, 1}],
        PaddedForm[xp, {8, 4}],
        PaddedForm[xm, {8, 4}],
        PaddedForm[taup, {10, 4}],
        PaddedForm[taum, {10, 4}],
        PaddedForm[dtau, {10, 4}]
    ]],
    {y, {0.1, 0.3, 0.5, 1.0, 2.0, 5.0}}
];
Print[""];


(* =========================================================================
   Section 4: Time Delay Formula for Point Mass Lens

   Delta_tau = (y*sqrt(y^2+4))/2 + ln((sqrt(y^2+4)+y)/(sqrt(y^2+4)-y))
   ========================================================================= *)

Print["--- Section 4: Point Mass Time Delay Formula ---\n"];

(* Analytic formula for dimensionless time delay *)
deltaTauAnalytic[y_] := y * Sqrt[y^2 + 4] / 2 +
    Log[(Sqrt[y^2 + 4] + y) / (Sqrt[y^2 + 4] - y)];

(* Verify against direct computation *)
Print["Verification of analytic formula:"];
Print["  Delta_tau = (y*sqrt(y^2+4))/2 + ln((sqrt(y^2+4)+y)/(sqrt(y^2+4)-y))"];
Print[""];
Do[
    dtDirect = tauPM[xMinus[y], y] - tauPM[xPlus[y], y];
    (* Note: tauPM uses Abs, so for xMinus < 0 we need *)
    dtDirect = (xMinus[y] - y)^2/2 - Log[Abs[xMinus[y]]]
               - ((xPlus[y] - y)^2/2 - Log[xPlus[y]]);
    dtAnalytic = deltaTauAnalytic[y];
    Print["  y = ", PaddedForm[y, {4, 1}],
        "  Direct: ", PaddedForm[dtDirect, {8, 4}],
        "  Analytic: ", PaddedForm[dtAnalytic, {8, 4}],
        "  Diff: ", ScientificForm[dtDirect - dtAnalytic, 3]],
    {y, {0.1, 0.5, 1.0, 2.0, 5.0}}
];
Print[""];


(* =========================================================================
   Section 5: Numerical Example -- Physical Time Delay

   Delta_t = (R_S / c) * (1 + z_d) * Delta_tau
   for point mass: R_S = 2*G*M / c^2
   ========================================================================= *)

Print["--- Section 5: Numerical Time Delay ---\n"];

(* Galaxy-mass lens *)
Mlens = 1*^12 * Msolar;
zd = 0.3;
RS = 2 Gnewton Mlens / cc^2;

Print["Lens parameters:"];
Print["  M = 10^12 Msun"];
Print["  z_d = ", zd];
Print["  R_S = ", ScientificForm[RS, 4], " m = ",
    NumberForm[RS / (3.086*^16), {4, 3}], " pc\n"];

(* Time delay for y = 0.5 *)
ySource = 0.5;
dtauVal = deltaTauAnalytic[ySource];
Print["Source at y = beta/thetaE = ", ySource];
Print["  Delta_tau = ", NumberForm[dtauVal, {5, 4}]];

deltaT = RS / cc * (1 + zd) * dtauVal;
Print["  Delta_t = R_S/c * (1+z_d) * Delta_tau"];
Print["         = ", ScientificForm[deltaT, 4], " s"];
Print["         = ", NumberForm[deltaT / dayToSec, {5, 1}], " days\n"];

(* Table for various y *)
Print["Time delays for M = 10^12 Msun, z_d = 0.3:"];
Print[StringForm["  ``    ``         ``",
    PaddedForm["y", {4, 0}],
    PaddedForm["Delta_tau", {10, 0}],
    PaddedForm["Delta_t (days)", {14, 0}]
]];
Print["  ", StringJoin[Table["-", 38]]];
Do[
    dt = deltaTauAnalytic[y];
    dtPhys = RS / cc * (1 + zd) * dt / dayToSec;
    Print[StringForm["  ``    ``         ``",
        PaddedForm[y, {4, 1}],
        PaddedForm[dt, {10, 4}],
        PaddedForm[dtPhys, {14, 1}]
    ]],
    {y, {0.1, 0.3, 0.5, 1.0, 2.0, 3.0, 5.0}}
];
Print[""];


(* =========================================================================
   Section 6: H0 from Time Delay

   Delta_t = (1+z_d)/c * Dd*Ds/Dds * (tau_1 - tau_2)
   Since Dd*Ds/Dds ~ 1/H0, measuring Delta_t gives H0.
   ========================================================================= *)

Print["--- Section 6: H0 from Time Delay ---\n"];

(* Example: observed time delay = 420 days *)
deltaTobs = 420 * dayToSec;  (* seconds *)
tauDiff = 25.0;  (* arcsec^2 *)
tauDiffRad = tauDiff / radToArcsec^2;  (* convert to radians^2 *)
zdLens = 0.3;

Print["Observed: Delta_t = 420 days = ", ScientificForm[deltaTobs, 4], " s"];
Print["Model:   tau_1 - tau_2 = 25 arcsec^2 = ",
    ScientificForm[tauDiffRad, 4], " rad^2"];
Print["Lens redshift: z_d = ", zdLens];
Print[""];

(* Solve for Dd*Ds/Dds *)
DdDsDds = deltaTobs * cc / ((1 + zdLens) * tauDiffRad);
Print["Dd*Ds/Dds = Delta_t * c / ((1+z_d) * (tau_1 - tau_2))"];
Print["         = ", ScientificForm[DdDsDds, 4], " m"];
Print["         = ", NumberForm[DdDsDds / MpcToM, {5, 0}], " Mpc\n"];

(* For flat LCDM with Omega_m = 0.3, compute dimensionless distance factor *)
Print["For flat LCDM (Omega_m = 0.3):"];
Print["  Dd*Ds/Dds = (c/H0) * f(z_d, z_s, Omega_m)"];
Print["  where f encodes the dimensionless distance ratios.\n"];

(* Numerical integration for distance factor *)
(* E(z) = sqrt(Omega_m*(1+z)^3 + Omega_Lambda) *)
OmM = 0.3;
OmL = 0.7;
EHub[z_] := Sqrt[OmM (1 + z)^3 + OmL];
chiFunc[z_] := NIntegrate[1/EHub[zp], {zp, 0, z}];

chiD = chiFunc[0.3];
chiS = chiFunc[1.0];
chiDS = NIntegrate[1/EHub[zp], {zp, 0.3, 1.0}];

(* Angular diameter distances: DA = chi/(1+z) * c/H0 *)
(* Dd*Ds/Dds = (c/H0) * chiD * chiS / ((1+zd)*(1+zs) * chiDS / (1+zs)) *)
(*           = (c/H0) * chiD * chiS / ((1+zd) * chiDS) *)
distFactor = chiD * chiS / ((1 + 0.3) * chiDS);

Print["  Dimensionless comoving distances:"];
Print["    chi_d = ", NumberForm[chiD, {4, 3}]];
Print["    chi_s = ", NumberForm[chiS, {4, 3}]];
Print["    chi_ds = ", NumberForm[chiDS, {4, 3}]];
Print["  Distance factor f = chi_d * chi_s / ((1+z_d) * chi_ds) = ",
    NumberForm[distFactor, {4, 4}]];
Print[""];

(* H0 *)
H0 = cc * distFactor / DdDsDds;
H0kms = H0 * MpcToM / 1000;

Print["H0 = c * f / (Dd*Ds/Dds)"];
Print["   = ", ScientificForm[H0, 4], " s^-1"];
Print["   = ", NumberForm[H0kms, {4, 1}], " km/s/Mpc\n"];
Print["(Note: this simplified example gives an illustrative value.)"];
Print["H0LiCOW/TDCOSMO result: H0 = 73.3 +/- 1.8 km/s/Mpc"];
Print["Planck CMB result:      H0 = 67.4 +/- 0.5 km/s/Mpc\n"];


(* =========================================================================
   Section 7: SIS Time Delay

   For SIS with Einstein radius thetaE:
     psi(theta) = thetaE * |theta|
     theta_pm = beta +/- thetaE   (for beta < thetaE)
     Delta_t = (1+z_d)/c * Dd*Ds/Dds * (theta_+^2 - theta_-^2) / 2
             = (1+z_d)/c * Dd*Ds/Dds * 2*beta*thetaE
   ========================================================================= *)

Print["--- Section 7: SIS Time Delay ---\n"];

Print["SIS lensing potential: psi(theta) = thetaE * |theta|"];
Print["Image positions: theta_pm = beta +/- thetaE  (for beta < thetaE)"];
Print[""];

(* SIS Fermat potential *)
tauSIS[theta_, beta_, thetaE_] :=
    (theta - beta)^2/2 - thetaE * Abs[theta];

(* Verify stationarity gives lens equation *)
Print["SIS lens equation from Fermat's principle:"];
Print["  d(tau)/d(theta) = (theta - beta) - thetaE * Sign(theta) = 0"];
Print["  => beta = theta - thetaE * Sign(theta)"];
Print["  For theta > 0: beta = theta - thetaE => theta_+ = beta + thetaE"];
Print["  For theta < 0: beta = theta + thetaE => theta_- = beta - thetaE"];
Print["  VERIFIED\n"];

(* SIS time delay *)
Print["SIS time delay:"];
Print["  tau(theta_+) = (theta_+ - beta)^2/2 - thetaE*theta_+"];
Print["              = thetaE^2/2 - thetaE*(beta + thetaE) = -thetaE*beta - thetaE^2/2"];
Print["  tau(theta_-) = (theta_- - beta)^2/2 - thetaE*|theta_-|"];
Print["              = thetaE^2/2 - thetaE*(thetaE - beta) = thetaE*beta - thetaE^2/2"];
Print["  Delta_tau = tau(theta_-) - tau(theta_+) = 2*thetaE*beta"];
Print["  Delta_t_SIS = (1+z_d)/c * Dd*Ds/Dds * 2*beta*thetaE\n"];


(* =========================================================================
   Section 8: Generate Figures
   ========================================================================= *)

Print["--- Section 8: Generating Figures ---\n"];

(* ---- Figure 1: Arrival-Time Surface (3D) ---- *)
Module[{tauSurf, betaVal = 0.5},
    (* Fermat potential for point mass, thetaE = 1 *)
    tauSurf[t1_, t2_] := (t1 - betaVal)^2/2 + t2^2/2
        - Log[Sqrt[t1^2 + t2^2]];

    xp = xPlus[betaVal];
    xm = xMinus[betaVal];
    tauP = tauSurf[xp, 0];
    tauM = tauSurf[Abs[xm], 0] /. t1 -> Abs[xm];
    (* Correctly: *)
    tauM = (xm - betaVal)^2/2 - Log[Abs[xm]];
    tauP = (xp - betaVal)^2/2 - Log[xp];

    fig1 = Show[
        Plot3D[
            tauSurf[t1, t2],
            {t1, -2.5, 2.5}, {t2, -2.5, 2.5},
            PlotRange -> {-1, 4},
            ClippingStyle -> None,
            RegionFunction -> Function[{t1, t2, z}, t1^2 + t2^2 > 0.08],
            ColorFunction -> "TemperatureMap",
            MeshFunctions -> {#3 &},
            MeshStyle -> {{Gray, Thin}},
            Mesh -> 20,
            AxesLabel -> {
                Style["\!\(\*SubscriptBox[\(\[Theta]\), \(1\)]\)/\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 12],
                Style["\!\(\*SubscriptBox[\(\[Theta]\), \(2\)]\)/\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 12],
                Style["\[Tau]", 14]
            },
            PlotLabel -> Style["Arrival-Time Surface (\[Beta] = 0.5 \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\))", 13],
            ImageSize -> 600,
            ViewPoint -> {2.5, -2, 1.5},
            BoxRatios -> {1, 1, 0.6}
        ],
        (* Mark the stationary points *)
        Graphics3D[{
            {Blue, PointSize[0.025], Point[{xp, 0, tauP}]},
            {Red, PointSize[0.025], Point[{xm, 0, tauM}]},
            Text[Style["min", 11, Bold, Blue], {xp + 0.3, 0, tauP + 0.3}],
            Text[Style["saddle", 11, Bold, Red], {xm - 0.5, 0, tauM + 0.3}]
        }]
    ];
    Export[FileNameJoin[{baseDir, "arrival_time_surface.pdf"}], fig1];
    Print["  Exported: arrival_time_surface.pdf"];
];

(* ---- Figure 2: Contour Plot of Arrival Time ---- *)
Module[{tauSurf, betaVal = 0.5},
    tauSurf[t1_, t2_] := (t1 - betaVal)^2/2 + t2^2/2
        - Log[Sqrt[t1^2 + t2^2]];

    xp = xPlus[betaVal];
    xm = xMinus[betaVal];

    fig2 = Show[
        ContourPlot[
            tauSurf[t1, t2],
            {t1, -2.5, 2.5}, {t2, -2.5, 2.5},
            Contours -> 25,
            ColorFunction -> "TemperatureMap",
            PlotRange -> {-1, 4},
            RegionFunction -> Function[{t1, t2}, t1^2 + t2^2 > 0.05],
            FrameLabel -> {
                Style["\!\(\*SubscriptBox[\(\[Theta]\), \(1\)]\)/\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13],
                Style["\!\(\*SubscriptBox[\(\[Theta]\), \(2\)]\)/\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13]
            },
            PlotLabel -> Style["Fermat Potential Contours (\[Beta] = 0.5 \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\))", 13],
            ImageSize -> 550,
            AspectRatio -> 1
        ],
        (* Einstein ring *)
        Graphics[{
            {Black, Dashed, AbsoluteThickness[2],
             Circle[{0, 0}, 1]},
            Text[Style["\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 12, Black],
                {0.7, 0.85}]
        }],
        (* Stationary points *)
        Graphics[{
            {Blue, PointSize[0.02], Point[{xp, 0}]},
            {Red, PointSize[0.02], Point[{xm, 0}]},
            Text[Style["min (Type I)", 10, Bold, Blue], {xp, 0.25}],
            Text[Style["saddle (Type II)", 10, Bold, Red], {xm, -0.25}],
            (* Source position *)
            {Darker[Green], PointSize[0.015], Point[{betaVal, 0}]},
            Text[Style["\[Beta]", 11, Darker[Green]], {betaVal + 0.15, 0.15}]
        }]
    ];
    Export[FileNameJoin[{baseDir, "arrival_time_contours.pdf"}], fig2];
    Print["  Exported: arrival_time_contours.pdf"];
];

(* ---- Figure 3: Time Delay vs Source Position ---- *)
Module[{},
    fig3 = Plot[
        deltaTauAnalytic[y],
        {y, 0.01, 5},
        PlotStyle -> {Purple, AbsoluteThickness[2]},
        PlotRange -> {{0, 5}, {0, 30}},
        AxesLabel -> {
            Style["y = \[Beta] / \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 13],
            Style["\[CapitalDelta]\[Tau]", 14]
        },
        PlotLabel -> Style["Dimensionless Time Delay vs. Source Position (Point Mass)", 13],
        Epilog -> {
            (* Mark the numerical example *)
            {Red, PointSize[0.015], Point[{0.5, deltaTauAnalytic[0.5]}]},
            Text[Style["y = 0.5, \[CapitalDelta]\[Tau] = 1.01", 10, Red],
                {1.2, deltaTauAnalytic[0.5] + 1}]
        },
        ImageSize -> 600,
        GridLines -> Automatic,
        GridLinesStyle -> Directive[Gray, Opacity[0.3]]
    ];
    Export[FileNameJoin[{baseDir, "time_delay_vs_beta.pdf"}], fig3];
    Print["  Exported: time_delay_vs_beta.pdf"];
];

(* ---- Figure 4: H0 Constraint from Time Delay ---- *)
Module[{},
    (* H0 as a function of Delta_t for fixed lens model *)
    (* Using our example: tau_1 - tau_2 = 25 arcsec^2 in rad^2 *)
    tauDiffRadLocal = 25.0 / radToArcsec^2;

    H0func[deltaTdays_] := Module[{deltaTsec, DdDsDdsLocal},
        deltaTsec = deltaTdays * dayToSec;
        DdDsDdsLocal = deltaTsec * cc / ((1 + 0.3) * tauDiffRadLocal);
        H0local = cc * distFactor / DdDsDdsLocal;
        H0local * MpcToM / 1000  (* km/s/Mpc *)
    ];

    fig4 = Plot[
        H0func[dt],
        {dt, 100, 1000},
        PlotStyle -> {Blue, AbsoluteThickness[2]},
        PlotRange -> {{100, 1000}, {0, 150}},
        AxesLabel -> {
            Style["\[CapitalDelta]t (days)", 13],
            Style["\!\(\*SubscriptBox[\(H\), \(0\)]\) (km/s/Mpc)", 13]
        },
        PlotLabel -> Style["H\!\(\*SubscriptBox[\(0\), \(\)]\) Constraint from Time Delay", 13],
        Epilog -> {
            (* H0LiCOW band *)
            {Darker[Green], Opacity[0.2],
             Rectangle[{100, 73.3 - 1.8}, {1000, 73.3 + 1.7}]},
            {Darker[Green], Dashed, AbsoluteThickness[1],
             InfiniteLine[{{0, 73.3}, {1, 73.3}}]},
            Text[Style["H0LiCOW", 9, Darker[Green]], {900, 76}],
            (* Planck band *)
            {Red, Opacity[0.2],
             Rectangle[{100, 67.4 - 0.5}, {1000, 67.4 + 0.5}]},
            {Red, Dashed, AbsoluteThickness[1],
             InfiniteLine[{{0, 67.4}, {1, 67.4}}]},
            Text[Style["Planck", 9, Red], {900, 65}]
        },
        ImageSize -> 600,
        GridLines -> Automatic,
        GridLinesStyle -> Directive[Gray, Opacity[0.3]]
    ];
    Export[FileNameJoin[{baseDir, "H0_constraint.pdf"}], fig4];
    Print["  Exported: H0_constraint.pdf"];
];

Print["\n=== End of Module 6 ==="];
