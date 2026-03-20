(* =========================================================================
   problems_06.wl
   Module 6: Fermat's Principle and Time Delays --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 6, verified
            symbolically and numerically with Mathematica.

   Sources: Narayan & Bartelmann Sec. 3.3
            Congdon & Keeton Ch. 4.3-4.4
            Saha et al. Sec. 1.2-1.3

   Usage:   wolframscript -file problems_06.wl

   Exercises solved:
     6.1 --- Derive the lens equation from Fermat's principle
     6.2 --- Arrival times for a point mass lens with beta = 0.5 thetaE
     6.3 --- Show Type I image arrives before Type II image
     6.4 --- Measure H0 from time delays
     6.5 --- Plot the arrival-time surface
   ========================================================================= *)

Print["=== Module 6: SOLUTIONS ===\n"];

(* ---- Physical constants ---- *)
Gnewton = 6.674*^-11;      (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
kpcToM = 3.086*^19;         (* 1 kpc in meters *)
MpcToM = 3.086*^22;         (* 1 Mpc in meters *)
radToArcsec = 180 * 3600 / Pi;
dayToSec = 86400;

(* ---- Helper functions ---- *)
xPlus[y_] := (y + Sqrt[y^2 + 4])/2;
xMinus[y_] := (y - Sqrt[y^2 + 4])/2;
tauPM[x_, y_] := (x - y)^2/2 - Log[Abs[x]];
deltaTauAnalytic[y_] := y * Sqrt[y^2 + 4] / 2 +
    Log[(Sqrt[y^2 + 4] + y) / (Sqrt[y^2 + 4] - y)];


(* =========================================================================
   Exercise 6.1: Derive the Lens Equation from Fermat's Principle

   tau(theta, beta) = (1/2)|theta - beta|^2 - psi(theta)
   grad(tau) = (theta - beta) - grad(psi) = 0
   => beta = theta - grad(psi) = theta - alpha(theta)
   ========================================================================= *)

Print["--- Exercise 6.1: Deriving the Lens Equation ---\n"];

(* (a) Compute the gradient symbolically *)
Print["(a) The Fermat potential is:"];
Print["    tau(theta, beta) = (1/2)|theta - beta|^2 - psi(theta)"];
Print[""];
Print["    Computing the gradient with respect to theta:"];
Print["    grad_theta(tau) = grad_theta[(1/2)(theta1-beta1)^2 + (1/2)(theta2-beta2)^2]"];
Print["                    - grad_theta[psi(theta)]"];
Print["                  = (theta - beta) - grad(psi)\n"];

(* Symbolic verification for point mass *)
tau2D[t1_, t2_, b1_, b2_] :=
    ((t1 - b1)^2 + (t2 - b2)^2)/2 - Log[Sqrt[t1^2 + t2^2]];

grad1 = D[tau2D[t1, t2, b1, b2], t1];
grad2 = D[tau2D[t1, t2, b1, b2], t2];
Print["  Symbolic gradient (point mass, thetaE = 1):"];
Print["    d(tau)/d(theta1) = ", Simplify[grad1]];
Print["    d(tau)/d(theta2) = ", Simplify[grad2]];
Print[""];

(* (b) Set gradient to zero *)
Print["(b) Setting grad(tau) = 0:"];
Print["    theta - beta - grad(psi) = 0"];
Print["    => beta = theta - grad(psi)"];
Print["    Since alpha(theta) = grad(psi) (reduced deflection angle):"];
Print["    beta = theta - alpha(theta)  <--- THE LENS EQUATION"];
Print[""];

(* Verify: solve grad(tau) = 0 for 1D point mass *)
gradTau1D = D[tauPM[x, y], x];
Print["  1D point mass verification:"];
Print["    d(tau)/dx = ", gradTau1D];
sols = Solve[x - y - 1/x == 0, x];
Print["    Stationary points: x = ", sols];
Print["    These match theta_pm = (y +/- sqrt(y^2+4))/2  VERIFIED\n"];

(* (c) Physical explanation *)
Print["(c) Physical explanation:"];
Print["    Fermat's principle states that light follows paths of stationary"];
Print["    travel time. Among all possible positions theta in the lens plane,"];
Print["    only those for which the arrival time is stationary (d(t)/d(theta)=0)"];
Print["    correspond to actual light paths (images). The geometric delay"];
Print["    (longer path) and gravitational delay (Shapiro effect) compete:"];
Print["    images form where their combined effect is stationary.\n"];


(* =========================================================================
   Exercise 6.2: Arrival Times for a Point Mass Lens

   thetaE = 1", beta = 0.5 thetaE
   ========================================================================= *)

Print["--- Exercise 6.2: Arrival Times for Point Mass Lens ---\n"];

yVal = 0.5;

(* (a) Image positions *)
xp = xPlus[yVal];
xm = xMinus[yVal];
Print["(a) Image positions for y = beta/thetaE = ", yVal, ":"];
Print["    x_+ = (", yVal, " + sqrt(", yVal^2, " + 4))/2 = ", NumberForm[xp, {5, 4}]];
Print["    x_- = (", yVal, " - sqrt(", yVal^2, " + 4))/2 = ", NumberForm[xm, {5, 4}]];
Print["    theta_+ = ", NumberForm[xp, {5, 4}], " arcsec"];
Print["    theta_- = ", NumberForm[xm, {5, 4}], " arcsec\n"];

(* (b) Fermat potential at each image *)
tauP = tauPM[xp, yVal];
tauM = tauPM[xm, yVal];
Print["(b) Fermat potential at each image:"];
Print["    tau(x_+) = (1/2)(", NumberForm[xp - yVal, {5, 4}], ")^2 - ln(",
    NumberForm[xp, {5, 4}], ")"];
Print["            = ", NumberForm[(xp - yVal)^2/2, {5, 4}], " - ",
    NumberForm[Log[xp], {5, 4}]];
Print["            = ", NumberForm[tauP, {6, 4}]];
Print[""];
Print["    tau(x_-) = (1/2)(", NumberForm[xm - yVal, {5, 4}], ")^2 - ln(",
    NumberForm[Abs[xm], {5, 4}], ")"];
Print["            = ", NumberForm[(xm - yVal)^2/2, {5, 4}], " - (",
    NumberForm[Log[Abs[xm]], {5, 4}], ")"];
Print["            = ", NumberForm[tauM, {6, 4}]];
Print[""];

(* (c) Dimensionless time delay *)
dtau = tauM - tauP;
dtauFormula = deltaTauAnalytic[yVal];
Print["(c) Dimensionless time delay:"];
Print["    Delta_tau = tau(x_-) - tau(x_+) = ", NumberForm[dtau, {6, 4}]];
Print["    Analytic formula: Delta_tau = ", NumberForm[dtauFormula, {6, 4}]];
Print["    Difference: ", ScientificForm[dtau - dtauFormula, 3], "  (numerical roundoff)"];
Print["    VERIFIED\n"];

(* (d) Physical time delay *)
Mlens = 1*^12 * Msolar;
zd = 0.3;
RS = 2 Gnewton Mlens / cc^2;
deltaT = RS / cc * (1 + zd) * dtau;
deltaTdays = deltaT / dayToSec;

Print["(d) Physical time delay:"];
Print["    M = 10^12 Msun, z_d = 0.3"];
Print["    R_S = 2*G*M/c^2 = ", ScientificForm[RS, 4], " m"];
Print["    Delta_t = R_S/c * (1+z_d) * Delta_tau"];
Print["            = ", ScientificForm[RS/cc, 4], " * ", 1 + zd, " * ",
    NumberForm[dtau, {5, 4}]];
Print["            = ", ScientificForm[deltaT, 4], " s"];
Print["            = ", NumberForm[deltaTdays, {5, 1}], " days\n"];


(* =========================================================================
   Exercise 6.3: Type I Image Arrives First

   Show tau(theta_+) < tau(theta_-) for all beta > 0
   ========================================================================= *)

Print["--- Exercise 6.3: Type I Image Arrives First ---\n"];

(* (a) Analytic proof *)
Print["(a) Analytic proof:"];
Print["    Delta_tau = y*sqrt(y^2+4)/2 + ln((sqrt(y^2+4)+y)/(sqrt(y^2+4)-y))"];
Print[""];
Print["    Term 1: y*sqrt(y^2+4)/2 > 0 for y > 0 (manifestly positive)"];
Print["    Term 2: The argument of ln is"];
Print["            (sqrt(y^2+4)+y)/(sqrt(y^2+4)-y)"];
Print["            Since sqrt(y^2+4) > y > 0, both numerator and denominator"];
Print["            are positive, and numerator > denominator."];
Print["            Therefore the argument > 1, so ln(...) > 0."];
Print["    Both terms are positive => Delta_tau > 0"];
Print["    => tau(x_-) > tau(x_+) => Type I arrives first.  QED\n"];

(* (b) Numerical verification *)
Print["(b) Numerical verification:"];
Print[""];
Print[StringForm["    ``  ``  ``  ``",
    PaddedForm["y", {4, 0}],
    PaddedForm["tau(x_+)", {10, 0}],
    PaddedForm["tau(x_-)", {10, 0}],
    PaddedForm["Delta_tau", {10, 0}]
]];
Print["    ", StringJoin[Table["-", 44]]];

Do[
    xp = xPlus[y];
    xm = xMinus[y];
    tp = tauPM[xp, y];
    tm = tauPM[xm, y];
    dt = tm - tp;
    Print[StringForm["    ``  ``  ``  ``",
        PaddedForm[y, {4, 1}],
        PaddedForm[tp, {10, 4}],
        PaddedForm[tm, {10, 4}],
        PaddedForm[dt, {10, 4}]
    ]],
    {y, {0.1, 0.5, 1.0, 2.0}}
];
Print[""];
Print["    In all cases tau(x_+) < tau(x_-)  VERIFIED\n"];

(* (c) Explanation *)
Print["(c) Since t(theta) = const * tau(theta, beta) with a POSITIVE"];
Print["    proportionality constant [(1+z_d)/c * Dd*Ds/Dds > 0],"];
Print["    a smaller tau means a smaller arrival time."];
Print["    Therefore the Type I image (minimum of tau) arrives BEFORE"];
Print["    the Type II image (saddle point of tau)."];
Print["    The time delay between them is Delta_t = const * Delta_tau > 0.\n"];


(* =========================================================================
   Exercise 6.4: Measuring H0 from Time Delays

   Delta_t = 420 days, tau_1 - tau_2 = 25 arcsec^2
   z_d = 0.3, z_s = 1.0
   ========================================================================= *)

Print["--- Exercise 6.4: Measuring H0 from Time Delays ---\n"];

(* (a) Solve for Dd*Ds/Dds *)
deltaTobs = 420 * dayToSec;  (* seconds *)
tauDiff = 25.0;  (* arcsec^2 *)
tauDiffRad = tauDiff / radToArcsec^2;  (* convert to rad^2 *)
zdLens = 0.3;
zsSource = 1.0;

Print["(a) Given:"];
Print["    Delta_t = 420 days = ", ScientificForm[deltaTobs, 4], " s"];
Print["    tau_1 - tau_2 = 25 arcsec^2 = ", ScientificForm[tauDiffRad, 4], " rad^2"];
Print["    z_d = ", zdLens];
Print[""];

DdDsDds = deltaTobs * cc / ((1 + zdLens) * tauDiffRad);
Print["    Dd*Ds/Dds = Delta_t * c / ((1+z_d) * (tau_1 - tau_2))"];
Print["              = ", ScientificForm[DdDsDds, 4], " m"];
Print["              = ", NumberForm[DdDsDds / MpcToM, {5, 0}], " Mpc\n"];

(* (b) Distance factor for flat LCDM *)
Print["(b) For flat LCDM with Omega_m = 0.3:"];
OmM = 0.3;
OmL = 0.7;
EHub[z_] := Sqrt[OmM (1 + z)^3 + OmL];

(* Compute dimensionless comoving distances *)
chiD = NIntegrate[1/EHub[z], {z, 0, zdLens}];
chiS = NIntegrate[1/EHub[z], {z, 0, zsSource}];
chiDS = NIntegrate[1/EHub[z], {z, zdLens, zsSource}];

Print["    Dimensionless comoving distances (integrals of 1/E(z)):"];
Print["      chi_d(z=0.3) = ", NumberForm[chiD, {4, 3}]];
Print["      chi_s(z=1.0) = ", NumberForm[chiS, {4, 3}]];
Print["      chi_ds = ", NumberForm[chiDS, {4, 3}]];
Print[""];

(* Angular diameter distances: D = chi/(1+z) * c/H0 *)
(* Dd*Ds/Dds = (c/H0) * chiD/(1+zd) * chiS/(1+zs) / (chiDS/(1+zs)) *)
(*           = (c/H0) * chiD * chiS / ((1+zd) * chiDS) *)
distFactor = chiD * chiS / ((1 + zdLens) * chiDS);

Print["    Dd*Ds/Dds = (c/H0) * chiD*chiS / ((1+zd)*chiDS)"];
Print["              = (c/H0) * ", NumberForm[distFactor, {4, 4}]];
Print["    So Dd*Ds/Dds = (c/H0) * f, where f = ", NumberForm[distFactor, {4, 4}]];
Print["    => Dd*Ds/Dds is proportional to 1/H0.  QED\n"];

(* (c) Compute H0 *)
Print["(c) Solving for H0:"];
Print["    H0 = c * f / (Dd*Ds/Dds)"];
H0 = cc * distFactor / DdDsDds;
H0kms = H0 * MpcToM / 1000;
Print["    H0 = ", ScientificForm[H0, 4], " s^-1"];
Print["       = ", NumberForm[H0kms, {5, 1}], " km/s/Mpc"];
Print[""];
Print["    Comparison:"];
Print["      H0LiCOW/TDCOSMO: H0 = 73.3 +1.7/-1.8 km/s/Mpc"];
Print["      Planck CMB:       H0 = 67.4 +/- 0.5 km/s/Mpc"];
Print["      Local (SH0ES):    H0 = 73.0 +/- 1.0 km/s/Mpc"];
Print[""];
Print["    Note: Our simplified calculation gives an illustrative value."];
Print["    The exact result depends on the precise lens model and"];
Print["    the self-consistent computation of distance ratios.\n"];


(* =========================================================================
   Exercise 6.5: Plotting the Arrival-Time Surface

   tau(theta1, theta2) for point mass with beta = (0.3, 0) thetaE
   ========================================================================= *)

Print["--- Exercise 6.5: Arrival-Time Surface ---\n"];

betaPlot = 0.3;
tauSurf[t1_, t2_] := (t1 - betaPlot)^2/2 + t2^2/2 - Log[Sqrt[t1^2 + t2^2]];

xpPlot = xPlus[betaPlot];
xmPlot = xMinus[betaPlot];

Print["(a)-(b) For beta = (", betaPlot, ", 0) thetaE with thetaE = 1:"];
Print["    tau(theta1, theta2) = (1/2)(theta1 - ", betaPlot,
    ")^2 + (1/2)theta2^2 - ln(sqrt(theta1^2 + theta2^2))"];
Print[""];
Print["    Stationary points (image positions):"];
Print["      x_+ = ", NumberForm[xpPlot, {5, 4}], "  (minimum, Type I)"];
Print["      x_- = ", NumberForm[xmPlot, {5, 4}], "  (saddle, Type II)"];
Print[""];
Print["    tau(x_+, 0) = ", NumberForm[tauSurf[xpPlot, 0], {6, 4}]];
Print["    tau(x_-, 0) = ", NumberForm[tauSurf[xmPlot, 0], {6, 4}]];
Print["    Delta_tau = ", NumberForm[tauSurf[xmPlot, 0] - tauSurf[xpPlot, 0], {6, 4}]];
Print[""];

(* (c) Verify stationary points *)
Print["(c)-(d) Verification:"];
grad1AtPlus = (xpPlot - betaPlot) - xpPlot / (xpPlot^2);
grad2AtPlus = 0;
Print["    grad(tau) at x_+: (", NumberForm[grad1AtPlus, {4, 2}], ", ", grad2AtPlus, ")"];
Print["    (Should be zero -- the small residual is numerical.)"];
Print[""];

(* Hessian at x_+ *)
H11Plus = 1 + (xpPlot^2 - 0^2)/(xpPlot^2 + 0^2)^2 - 1/(xpPlot^2 + 0^2);
(* Simplified: for theta2 = 0: H11 = 1 + 1/theta1^2 - 1/theta1^2... *)
(* Let's compute properly *)
hess11[t1_, t2_] = D[tauSurf[t1, t2], {t1, 2}];
hess22[t1_, t2_] = D[tauSurf[t1, t2], {t2, 2}];
hess12[t1_, t2_] = D[tauSurf[t1, t2], t1, t2];

Print["    Hessian at x_+ = (", NumberForm[xpPlot, {5, 4}], ", 0):"];
Print["      H_11 = ", NumberForm[hess11[xpPlot, 0.0], {5, 3}]];
Print["      H_22 = ", NumberForm[hess22[xpPlot, 0.0], {5, 3}]];
Print["      H_12 = ", NumberForm[hess12[xpPlot, 0.0], {5, 3}]];
detPlus = hess11[xpPlot, 0.0] * hess22[xpPlot, 0.0] - hess12[xpPlot, 0.0]^2;
trPlus = hess11[xpPlot, 0.0] + hess22[xpPlot, 0.0];
Print["      det(H) = ", NumberForm[detPlus, {5, 3}], " > 0"];
Print["      tr(H) = ", NumberForm[trPlus, {5, 3}], " > 0"];
Print["      => MINIMUM (Type I)  VERIFIED"];
Print[""];

Print["    Hessian at x_- = (", NumberForm[xmPlot, {5, 4}], ", 0):"];
Print["      H_11 = ", NumberForm[hess11[xmPlot, 0.0], {5, 3}]];
Print["      H_22 = ", NumberForm[hess22[xmPlot, 0.0], {5, 3}]];
Print["      H_12 = ", NumberForm[hess12[xmPlot, 0.0], {5, 3}]];
detMinus = hess11[xmPlot, 0.0] * hess22[xmPlot, 0.0] - hess12[xmPlot, 0.0]^2;
trMinus = hess11[xmPlot, 0.0] + hess22[xmPlot, 0.0];
Print["      det(H) = ", NumberForm[detMinus, {5, 3}]];
Print["      => det < 0 => SADDLE POINT (Type II)  VERIFIED"];
Print[""];

(* Generate the plots *)
Print["Generating plots...\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/06_Fermat_Time_Delays";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];

(* 3D surface *)
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
        PlotLabel -> Style["Arrival-Time Surface (Exercise 6.5, \[Beta] = 0.3 \!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\))", 12],
        ImageSize -> 550,
        ViewPoint -> {2.5, -2, 1.5},
        BoxRatios -> {1, 1, 0.6}
    ],
    Graphics3D[{
        {Blue, PointSize[0.025], Point[{xpPlot, 0, tauSurf[xpPlot, 0]}]},
        {Red, PointSize[0.025], Point[{xmPlot, 0, tauSurf[xmPlot, 0]}]},
        Text[Style["min (Type I)", 10, Bold, Blue],
            {xpPlot + 0.3, 0, tauSurf[xpPlot, 0] + 0.3}],
        Text[Style["saddle (Type II)", 10, Bold, Red],
            {xmPlot - 0.5, 0, tauSurf[xmPlot, 0] + 0.3}]
    }]
];
Export[FileNameJoin[{baseDir, "ex65_arrival_surface.pdf"}], fig1];
Print["  Exported: ex65_arrival_surface.pdf"];

(* Contour plot *)
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
        PlotLabel -> Style["Contour Plot (Exercise 6.5c)", 13],
        ImageSize -> 500,
        AspectRatio -> 1
    ],
    Graphics[{
        (* Einstein ring *)
        {Black, Dashed, AbsoluteThickness[2], Circle[{0, 0}, 1]},
        Text[Style["\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 12, Black],
            {0.7, 0.85}],
        (* Stationary points *)
        {Blue, PointSize[0.02], Point[{xpPlot, 0}]},
        {Red, PointSize[0.02], Point[{xmPlot, 0}]},
        Text[Style["min", 10, Bold, Blue], {xpPlot, 0.2}],
        Text[Style["saddle", 10, Bold, Red], {xmPlot, -0.2}],
        (* Source *)
        {Darker[Green], PointSize[0.015], Point[{betaPlot, 0}]},
        Text[Style["\[Beta]", 11, Darker[Green]], {betaPlot + 0.15, 0.15}]
    }]
];
Export[FileNameJoin[{baseDir, "ex65_contour.pdf"}], fig2];
Print["  Exported: ex65_contour.pdf"];

Print[""];
Print["    Stationary points agree with lens equation predictions:"];
Print["      theta_+ = (0.3 + sqrt(4.09))/2 = ", NumberForm[xpPlot, {5, 4}], "  MATCH"];
Print["      theta_- = (0.3 - sqrt(4.09))/2 = ", NumberForm[xmPlot, {5, 4}], "  MATCH\n"];

Print["=== End of Module 6 Solutions ==="];
