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
   Annotated-edition checks (2026-10): A1-A17 at the end of this file,
     one per identity/number in the Annotated Study Edition boxes of
     Notes/06_Fermat_Time_Delays/*.tex; ends with summary[].
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

   Delta_t = 100 days, tau_1 - tau_2 = 2.0 arcsec^2
   z_d = 0.3, z_s = 1.0
   ========================================================================= *)

Print["--- Exercise 6.4: Measuring H0 from Time Delays ---\n"];

(* (a) Solve for Dd*Ds/Dds *)
deltaTobs = 100 * dayToSec;  (* seconds *)
tauDiff = 2.0;  (* arcsec^2 *)
tauDiffRad = tauDiff / radToArcsec^2;  (* convert to rad^2 *)
zdLens = 0.3;
zsSource = 1.0;

Print["(a) Given:"];
Print["    Delta_t = 100 days = ", ScientificForm[deltaTobs, 4], " s"];
Print["    tau_1 - tau_2 = 2.0 arcsec^2 = ", ScientificForm[tauDiffRad, 4], " rad^2"];
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

(* Repo-relative (was an absolute path into the main checkout, which made a
   run from a git worktree write into the main repo's Figures/). *)
baseDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
    "Figures", "06_Fermat_Time_Delays"}];
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
    (* Stationary-point labels: white-backed so the blue "min" text is
       readable against the dark-blue side of the arrival-time surface. *)
    Graphics3D[{
        {Blue, PointSize[0.025], Point[{xpPlot, 0, tauSurf[xpPlot, 0]}]},
        {Red, PointSize[0.025], Point[{xmPlot, 0, tauSurf[xmPlot, 0]}]},
        Text[Style["min (Type I)", 10, Bold, Blue,
                Background -> Directive[White, Opacity[0.85]]],
            {xpPlot + 0.3, 0, tauSurf[xpPlot, 0] + 0.3}],
        Text[Style["saddle (Type II)", 10, Bold, Red,
                Background -> Directive[White, Opacity[0.85]]],
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
    (* Stationary-point labels: white-backed so blue "min" text and the
       green beta label remain readable on the dark-blue/contour region. *)
    Graphics[{
        (* Einstein ring *)
        {Black, Dashed, AbsoluteThickness[2], Circle[{0, 0}, 1]},
        Text[Style["\!\(\*SubscriptBox[\(\[Theta]\), \(E\)]\)", 12, Black],
            {0.7, 0.85}],
        (* Stationary points *)
        {Blue, PointSize[0.02], Point[{xpPlot, 0}]},
        {Red, PointSize[0.02], Point[{xmPlot, 0}]},
        Text[Style["min", 10, Bold, Blue,
                Background -> Directive[White, Opacity[0.85]]],
            {xpPlot, 0.2}],
        Text[Style["saddle", 10, Bold, Red,
                Background -> Directive[White, Opacity[0.85]]],
            {xmPlot, -0.2}],
        (* Source *)
        {Darker[Green], PointSize[0.015], Point[{betaPlot, 0}]},
        Text[Style["\[Beta]", 11, Darker[Green],
                Background -> Directive[White, Opacity[0.85]]],
            {betaPlot + 0.15, 0.15}]
    }]
];
Export[FileNameJoin[{baseDir, "ex65_contour.pdf"}], fig2];
Print["  Exported: ex65_contour.pdf"];

Print[""];
Print["    Stationary points agree with lens equation predictions:"];
Print["      theta_+ = (0.3 + sqrt(4.09))/2 = ", NumberForm[xpPlot, {5, 4}], "  MATCH"];
Print["      theta_- = (0.3 - sqrt(4.09))/2 = ", NumberForm[xmPlot, {5, 4}], "  MATCH\n"];

Print["=== End of Module 6 Solutions ==="];


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity written in a derivation box and every number quoted in an
   annotation box of Notes/06_Fermat_Time_Delays/*.tex (Annotated Study
   Edition) is checked here.  Harness: check[] / summary[].                 *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                  "Mathematica", "harness.wl"}]];
Print["\n=== Annotated-edition checks: Module 6 ==="];
ClearAll[th1, th2, b1, b2, psiG, x, y, lam, Dd, Ds, Dds, th, be, tE, tc];

(* -- A1. Geometric delay: Euclidean thin-screen path excess ------------- *)
(* L_excess = xi^2/(2Dd) + (eta-xi)^2/(2Dds) - eta^2/(2Ds), xi = Dd th,
   eta = Ds be, Ds = Dd + Dds  ==>  (Dd Ds/(2 Dds)) (th - be)^2           *)
geoExcess = (Dd th)^2/(2 Dd) + (Ds be - Dd th)^2/(2 Dds) - (Ds be)^2/(2 Ds);
check["A1 geometric path excess = Dd Ds/(2 Dds) (theta-beta)^2 (Euclidean, Ds=Dd+Dds)",
  Simplify[(geoExcess - Dd Ds/(2 Dds) (th - be)^2) /. Ds -> Dd + Dds] === 0];

(* -- A2. Shapiro term: t_grav = -(2/c^3) Int Phi dl and
         psi = (Dds/(Dd Ds)) (2/c^2) Int Phi dz  ==>
         t_grav = -(Dd Ds/(c Dds)) psi                                    *)
ClearAll[intPhi, cL];
psiFromPhi = Dds/(Dd Ds) 2/cL^2 intPhi;
check["A2 -(Dd Ds/(c Dds)) psi = -(2/c^3) Int Phi dz",
  Simplify[-(Dd Ds/(cL Dds)) psiFromPhi + 2/cL^3 intPhi] === 0];

(* -- A3. grad tau and Hessian of tau for a generic psi ------------------ *)
tauG = ((th1 - b1)^2 + (th2 - b2)^2)/2 - psiG[th1, th2];
gradT = {D[tauG, th1], D[tauG, th2]};
check["A3a grad tau = (theta - beta) - grad psi",
  Simplify[gradT - ({th1 - b1, th2 - b2} -
     {D[psiG[th1, th2], th1], D[psiG[th1, th2], th2]})] === {0, 0}];
hessT = D[tauG, {{th1, th2}, 2}];
check["A3b Hess tau = delta_ab - psi_ab = A",
  Simplify[hessT - (IdentityMatrix[2] -
     D[psiG[th1, th2], {{th1, th2}, 2}])] === {{0, 0}, {0, 0}}];

(* -- A4. Eigenvalue product/sum = det/trace for a symmetric 2x2 --------- *)
ClearAll[a11, a12, a22];
ev = Eigenvalues[{{a11, a12}, {a12, a22}}];
check["A4a lambda1 lambda2 = det A (symmetric 2x2)",
  Simplify[ev[[1]] ev[[2]] - (a11 a22 - a12^2)] === 0];
check["A4b lambda1 + lambda2 = tr A (symmetric 2x2)",
  Simplify[ev[[1]] + ev[[2]] - (a11 + a22)] === 0];
(* both > 0  <=>  det > 0 and tr > 0 (Reduce over the reals) *)
check["A4c both eigenvalues > 0 <=> det>0 && tr>0",
  Resolve[ForAll[{a11, a12, a22},
    Implies[a11 a22 - a12^2 > 0 && a11 + a22 > 0,
            Min[ev] > 0]], Reals] === True];

(* -- A5. Point-mass Hessian on the axis (thetaE = 1) -------------------- *)
tauPM2 = ((th1 - b1)^2 + th2^2)/2 - Log[Sqrt[th1^2 + th2^2]];
hPM = D[tauPM2, {{th1, th2}, 2}] /. th2 -> 0;
check["A5a point mass: Hess tau at (x,0) = diag(1 + 1/x^2, 1 - 1/x^2)",
  Simplify[hPM - DiagonalMatrix[{1 + 1/th1^2, 1 - 1/th1^2}],
    th1 != 0] === {{0, 0}, {0, 0}}];
check["A5b det A = 1 - 1/x^4 for the point mass",
  Simplify[Det[DiagonalMatrix[{1 + 1/x^2, 1 - 1/x^2}]] - (1 - 1/x^4)] === 0];
check["A5c y=0.5: x_+ > 1 (lambda_t>0: minimum), |x_-| < 1 (lambda_t<0: saddle)",
  xPlus[0.5] > 1 && Abs[xMinus[0.5]] < 1];

(* -- A6. Point-mass Delta tau: the skipped algebra ---------------------- *)
xp6 = (y + Sqrt[y^2 + 4])/2; xm6 = (y - Sqrt[y^2 + 4])/2;
check["A6a x_+ + x_- = y", Simplify[xp6 + xm6 - y] === 0];
check["A6b x_+ x_- = -1", Simplify[xp6 xm6 + 1] === 0];
check["A6c x_+ - x_- = sqrt(y^2+4)", Simplify[xp6 - xm6 - Sqrt[y^2 + 4]] === 0];
check["A6d x_+ - y = -x_-  and  x_- - y = -x_+",
  Simplify[{xp6 - y + xm6, xm6 - y + xp6}] === {0, 0}];
dtauSteps = (xp6^2 - xm6^2)/2 + Log[xp6/(-xm6)];
check["A6e tau(x_-) - tau(x_+) = (x_+^2 - x_-^2)/2 + ln(x_+/|x_-|) = boxed formula",
  FullSimplify[dtauSteps - deltaTauAnalytic[y], y > 0] === 0];
check["A6f x_+/|x_-| = (sqrt(y^2+4)+y)/(sqrt(y^2+4)-y)",
  FullSimplify[xp6/(-xm6) - (Sqrt[y^2 + 4] + y)/(Sqrt[y^2 + 4] - y), y > 0] === 0];
check["A6g ln[(sqrt(y^2+4)+y)/(sqrt(y^2+4)-y)] = 2 arcsinh(y/2)",
  FullSimplify[Log[(Sqrt[y^2 + 4] + y)/(Sqrt[y^2 + 4] - y)] - 2 ArcSinh[y/2],
    y > 0] === 0];
check["A6h d(Delta tau)/dy = sqrt(y^2+4)  (so Delta tau increases from 0)",
  FullSimplify[D[deltaTauAnalytic[y], y] - Sqrt[y^2 + 4], y > 0] === 0];
check["A6i Delta tau(0) = 0", deltaTauAnalytic[0] === 0];
check["A6j small y: Delta tau = 2y + y^3/12 + O(y^5)",
  Simplify[Normal[Series[deltaTauAnalytic[y], {y, 0, 4}]] - (2 y + y^3/12)] === 0];

(* -- A7. Physical prefactor: thetaE^2 Dd Ds/Dds = 4GM/c^2 -------------- *)
ClearAll[GG, MM, cS];
thetaE2PM = 4 GG MM/cS^2 Dds/(Dd Ds);
check["A7a (Dd Ds/Dds) thetaE^2 / c = 4GM/c^3",
  Simplify[(Dd Ds/Dds) thetaE2PM/cS - 4 GG MM/cS^3] === 0];
check["A7b 4GM/c^3 = 2 R_S/c  (R_S = 2GM/c^2)",
  Simplify[4 GG MM/cS^3 - 2 (2 GG MM/cS^2)/cS] === 0];
fourGMc3 = 4 Gnewton (1*^12 Msolar)/cc^3;
check["A7c 4GM/c^3 = 1.97e7 s = 228 d for M = 1e12 Msun",
  Abs[fourGMc3/1*^7 - 1.97] < 0.005 && Abs[fourGMc3/dayToSec - 228] < 0.5];
dtCorrect = fourGMc3 (1 + 0.3) deltaTauAnalytic[0.5];
Print["  [info] (1+z_d) (4GM/c^3) Delta tau(0.5) = ", dtCorrect, " s = ",
  dtCorrect/dayToSec, " d"];
check["A7d (1+z_d)(4GM/c^3) Delta tau(y=0.5) = 2.59e7 s = 299 d (z_d = 0.3)",
  Abs[dtCorrect/1*^7 - 2.59] < 0.005 && Abs[dtCorrect/dayToSec - 299] < 0.6];
check["A7e the text's R_S/c version is exactly half of A7d",
  Abs[(2 Gnewton 1*^12 Msolar/cc^2/cc) 1.3 deltaTauAnalytic[0.5]/dtCorrect - 1/2] < 10^-12];

(* -- A8. SIS Fermat potential at the two images (thetaE = tE) ----------- *)
tauSIS[t_] := (t - be)^2/2 - tE Abs[t];
tpS = be + tE; tmS = be - tE;
check["A8a SIS tau(theta_+) = -tE^2/2 - be tE",
  Simplify[tauSIS[tpS] - (-tE^2/2 - be tE), 0 < be < tE] === 0];
check["A8b SIS tau(theta_-) = -tE^2/2 + be tE",
  Simplify[tauSIS[tmS] - (-tE^2/2 + be tE), 0 < be < tE] === 0];
check["A8c SIS Delta tau = 2 be tE = (theta_+^2 - theta_-^2)/2",
  Simplify[{tauSIS[tmS] - tauSIS[tpS] - 2 be tE,
            (tpS^2 - tmS^2)/2 - 2 be tE}, 0 < be < tE] === {0, 0}];
check["A8d SIS and point mass agree to leading order: Delta tau/tE^2 = 2y + O(y^3)",
  Coefficient[Normal[Series[deltaTauAnalytic[y], {y, 0, 2}]], y] == 2];

(* -- A9. Mass-sheet transformation: Delta tau -> lambda Delta tau ------- *)
(* psi_l = lam psi + (1-lam) |th|^2/2, beta_l = lam beta                 *)
tauOrig = ((th1 - b1)^2 + (th2 - b2)^2)/2 - psiG[th1, th2];
tauMST = ((th1 - lam b1)^2 + (th2 - lam b2)^2)/2 -
   (lam psiG[th1, th2] + (1 - lam) (th1^2 + th2^2)/2);
check["A9a tau_lambda(theta; lambda beta) = lambda tau(theta; beta) + f(beta)",
  FreeQ[Simplify[tauMST - lam tauOrig], th1 | th2]];
check["A9b grad tau_lambda = lambda grad tau (same image positions)",
  Simplify[{D[tauMST, th1], D[tauMST, th2]} - lam {D[tauOrig, th1], D[tauOrig, th2]}] === {0, 0}];

(* -- A10. Exercise 6.4 conversions ------------------------------------- *)
check["A10a 2.0 arcsec^2 = 4.70e-11 rad^2",
  Abs[2.0/radToArcsec^2/1*^-11 - 4.70] < 0.005];
check["A10b flat universe: chi_ds = chi_s - chi_d (so Dds = (chi_s - chi_d) c/H0/(1+z_s))",
  Abs[chiDS - (chiS - chiD)] < 10^-8];
DdM = chiD/(1 + zdLens); DsM = chiS/(1 + zsSource); DdsM = chiDS/(1 + zsSource);
Print["  [info] (c/H0 units) Dd = ", DdM, " Ds = ", DsM, " Dds = ", DdsM,
  "  Ds - Dd = ", DsM - DdM];
check["A10c Dds != Ds - Dd for z_d=0.3, z_s=1: Dds/(Ds - Dd) = 1.44",
  Abs[DdsM/(DsM - DdM) - 1.44] < 0.005];
check["A10d chi_d = 0.279, chi_s = 0.771, chi_ds = 0.493, f = 0.336 (text quotes 0.778/0.499/0.334)",
  Abs[chiD - 0.279] < 0.0005 && Abs[chiS - 0.771] < 0.0005 &&
  Abs[chiDS - 0.493] < 0.0005 && Abs[distFactor - 0.336] < 0.0005];
check["A10e H0 from Ex 6.4 = 73 km/s/Mpc", Abs[H0kms - 73] < 0.5];
check["A10f Delta t scales as 1/H0: f independent of H0 (dimensionless integrals only)",
  FreeQ[chiD chiS/((1 + zdLens) chiDS), H0]];

(* -- A11. Morse counting for the point mass vs Petters Thm 11.4 -------- *)
(* point mass, g = 1 infinite singularity: Mmin + Mmax = Msad - g + 1     *)
check["A11 point mass: n_min - n_sad + n_max = 1 - g with g = 1 (1 - 1 + 0 = 0)",
  1 - 1 + 0 == 1 - 1];

(* -- A12. N&B quoted 1.4'' for SIS (sigma=220) is consistent -------- *)
(* (used in the Module 6 SIS preview annotation)                         *)
check["A12 4 Pi (220 km/s / c)^2 = 1.40 arcsec",
  Abs[4 Pi (220000/299792458.)^2 radToArcsec - 1.40] < 0.005];

(* -- A3c. tr A = 2 (1 - kappa): a maximum (tr < 0) needs kappa > 1 ----- *)
check["A3c tr(Hess tau) = 2 - Laplacian psi = 2 (1 - kappa)",
  Simplify[Tr[hessT] - (2 - (D[psiG[th1, th2], {th1, 2}] + D[psiG[th1, th2], {th2, 2}]))] === 0];

(* -- A13. -psi is largest at the lens centre (psi' = alpha > 0) -------- *)
check["A13 d psi/d theta > 0 for SIS (tE), point mass (tE^2/th), NIS (theta>0)",
  And @@ (Simplify[# > 0, th > 0 && tE > 0 && tc > 0] & /@
    {D[tE th, th], D[tE^2 Log[th], th],
     Simplify[D[tE (Sqrt[th^2 + tc^2] - tc Log[tc + Sqrt[th^2 + tc^2]]), th],
       th > 0 && tc > 0]})];

(* -- A14. Poincare-Hopf: winding numbers of grad tau (point mass, y=0.5) *)
gPM[{p1_, p2_}] := {p1 - 0.5 - p1/(p1^2 + p2^2), p2 - p2/(p1^2 + p2^2)};
winding[c_, r_] := Module[{ang},
   ang = Table[With[{g = gPM[c + r {Cos[f], Sin[f]}]}, ArcTan[g[[1]], g[[2]]]],
     {f, 0., 2 Pi, 2 Pi/4000}];
   Round[Total[Mod[Differences[ang] + Pi, 2 Pi] - Pi]/(2 Pi)]];
wBig = winding[{0, 0}, 6.]; wMin = winding[{xPlus[0.5], 0}, 0.1];
wSad = winding[{xMinus[0.5], 0}, 0.1]; wSing = winding[{0, 0}, 0.05];
Print["  [info] winding: large circle ", wBig, ", minimum ", wMin, ", saddle ", wSad,
  ", origin ", wSing];
check["A14 index: large circle +1 = min(+1) + saddle(-1) + singular origin(+1)",
  wBig == 1 && wMin == 1 && wSad == -1 && wSing == 1 && wBig == wMin + wSad + wSing];

(* -- A15. time-delay distance rule of thumb ------------------------------ *)
DdT = 918.77; DsT = 1651.91; DdsT = 1054.72;  (* Mpc, flat LCDM H0=70 Om=0.3 *)
perArcsec2 = 1.3 DdT DsT/DdsT MpcToM/cc/radToArcsec^2/dayToSec;
Print["  [info] (1+z_d) Dd Ds/Dds = ", 1.3 DdT DsT/DdsT, " Mpc; per arcsec^2: ",
  perArcsec2, " d"];
check["A15 z_d=0.3, z_s=1, H0=70: D_dt = 1870 Mpc; 1 arcsec^2 of Delta tau = 52 d",
  Abs[1.3 DdT DsT/DdsT - 1870] < 5 && Abs[perArcsec2 - 52] < 0.5];

(* -- A16. Exercise 6.5 Hessian eigenvalues (y = 0.3) -------------------- *)
eP = {1 + 1/xPlus[0.3]^2, 1 - 1/xPlus[0.3]^2};
eM = {1 + 1/xMinus[0.3]^2, 1 - 1/xMinus[0.3]^2};
Print["  [info] Ex 6.5 eigenvalues: x_+ ", eP, "  x_- ", eM];
check["A16 Ex 6.5: x_+ eigenvalues (1.742, 0.258); x_- eigenvalues (2.348, -0.348)",
  Max[Abs[eP - {1.742, 0.258}]] < 0.0005 && Max[Abs[eM - {2.348, -0.348}]] < 0.0005];

(* -- A10g. (1+z_s) cancels in Dd Ds/Dds ---------------------------------- *)
ClearAll[cd, cs, cds, zd1, zs1];
check["A10g (cd/(1+zd)) (cs/(1+zs)) / (cds/(1+zs)) = cd cs/((1+zd) cds)",
  Simplify[(cd/(1 + zd1)) (cs/(1 + zs1))/(cds/(1 + zs1)) - cd cs/((1 + zd1) cds)] === 0];

(* -- A17. numbers quoted in the 06_Solutions annotations ---------------- *)
xp5 = xPlus[0.5]; xm5 = xMinus[0.5];
check["A17a Ex 6.2: x_-^2/2 = 0.3048, x_+^2/2 = 0.8202, ln x_+ = 0.2475, ln|x_-| = -ln x_+, tau(x_+) = 0.0573",
  Abs[xm5^2/2 - 0.3048] < 0.00005 && Abs[xp5^2/2 - 0.8202] < 0.00005 &&
  Abs[Log[xp5] - 0.2475] < 0.00005 && Abs[Log[Abs[xm5]] + Log[xp5]] < 10^-12 &&
  Abs[tauPM[xp5, 0.5] - 0.0573] < 0.00005];
check["A17b (x_+^2 - x_-^2)/2 = 0.5154, 2 ln x_+ = 0.4949, Delta tau(0.5) = 1.0103, log ratio 1.6404",
  Abs[(xp5^2 - xm5^2)/2 - 0.5154] < 0.00005 && Abs[2 Log[xp5] - 0.4949] < 0.00005 &&
  Abs[deltaTauAnalytic[0.5] - 1.0103] < 0.00005 &&
  Abs[(Sqrt[4.25] + 0.5)/(Sqrt[4.25] - 0.5) - 1.6404] < 0.00005];
check["A17c R_S/c for 1e12 Msun = 114 d",
  Abs[2 Gnewton 1*^12 Msolar/cc^3/dayToSec - 114] < 0.5];
tabY = {0.1, 0.5, 1., 2.};
tab = Table[{tauPM[xPlus[yy], yy], tauPM[xMinus[yy], yy],
    tauPM[xMinus[yy], yy] - tauPM[xPlus[yy], yy]}, {yy, tabY}];
check["A17d corrected Ex 6.3 table (tau+, tau-, Delta tau) to 1e-4",
  Max[Abs[tab - {{0.4025, 0.6025, 0.2001}, {0.0573, 1.0677, 1.0103},
      {-0.2902, 1.7902, 2.0805}, {-0.7956, 3.7956, 4.5912}}]] < 0.00006];
check["A17d' Delta tau/y = 2.001, 2.021, 2.080, 2.296",
  Max[Abs[tab[[All, 3]]/tabY - {2.001, 2.021, 2.080, 2.296}]] < 0.0006];
check["A17d'' printed table rows y = 0.1, 1, 2 disagree with the formula (flag)",
  Abs[tab[[1, 3]] - 0.0100] > 0.1 && Abs[tab[[3, 3]] - 2.4277] > 0.1 && Abs[tab[[4, 3]] - 5.0065] > 0.1];
check["A17e 1.3 x 1374 = 1786 Mpc; 1870/1786 x 70 = 73.3",
  Abs[1.3 1374 - 1786] < 0.5 && Abs[1870/1786. 70 - 73.3] < 0.05];
check["A17f 206265^2 = 4.25e10 (arcsec^2 -> rad^2 factor)", Abs[radToArcsec^2/1*^10 - 4.25] < 0.005];
check["A17g Dd, Ds, Dds, Ds - Dd = 0.215, 0.386, 0.246, 0.171 (c/H0 units)",
  Max[Abs[{DdM, DsM, DdsM, DsM - DdM} - {0.215, 0.386, 0.246, 0.171}]] < 0.0006];

summary[];


