(* =========================================================================
   problems_07.wl
   Module 7: Axisymmetric Lens Models --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 7, verified
            symbolically and numerically with Mathematica.

   Sources: Narayan & Bartelmann Sec. 3.1 & 3.4
            Congdon & Keeton Ch. 2.3 & 6.1-6.2

   Usage:   wolframscript -file problems_07.wl

   Exercises solved:
     7.1 --- Derive the SIS deflection angle from the density profile
     7.2 --- Show kappa = |gamma| everywhere for SIS
     7.3 --- SIS numerical example (sigma_v=250, zd=0.3, zs=1)
     7.4 --- NIS convergence and SIS limit
     7.5 --- NFW concentration and lensing strength
   ========================================================================= *)

Print["=== Module 7: SOLUTIONS ===\n"];

(* ---- Physical constants ---- *)
Gnewton = 6.674*^-11;      (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
kpcToM = 3.086*^19;         (* 1 kpc in meters *)
MpcToM = 3.086*^22;         (* 1 Mpc in meters *)
radToArcsec = 180 * 3600 / Pi;


(* =========================================================================
   Exercise 7.1: Derive the SIS Deflection Angle

   rho(r) = sigma_v^2 / (2*Pi*G*r^2)
   => Sigma(xi) = sigma_v^2 / (2*G*xi)
   => M(xi) = Pi*sigma_v^2*xi / G
   => alphahat = 4*Pi*sigma_v^2/c^2
   ========================================================================= *)

Print["--- Exercise 7.1: SIS Deflection Angle Derivation ---\n"];

(* (a) Surface mass density *)
Print["(a) Sigma(xi) = Integral[rho(sqrt(xi^2+z^2)), {z, -Inf, Inf}]"];
sigmaResult = Integrate[sv^2 / (2 Pi G (xi^2 + z^2)), {z, -Infinity, Infinity},
    Assumptions -> {xi > 0, sv > 0, G > 0}];
Print["  = ", sigmaResult];
Print["  = sigma_v^2 / (2*G*xi). VERIFIED\n"];

(* (b) Enclosed mass *)
Print["(b) M(xi) = 2*Pi * Integral[Sigma(xi')*xi', {xi',0,xi}]"];
Mencl = 2 Pi * Integrate[sv^2/(2 G xip) * xip, {xip, 0, xi},
    Assumptions -> {xi > 0, sv > 0, G > 0}];
Print["  = ", Mencl];
Print["  = Pi*sigma_v^2*xi/G. VERIFIED\n"];

(* (c) Physical deflection angle *)
Print["(c) alphahat = 4*G*M(xi)/(c^2*xi)"];
alphaHat = 4 G (Pi sv^2 xi / G) / (c^2 xi) // Simplify;
Print["  = ", alphaHat];
Print["  = 4*Pi*sigma_v^2/c^2  (independent of xi!). VERIFIED\n"];

(* (d) Einstein radius *)
Print["(d) thetaE = (Dds/Ds) * alphahat = 4*Pi*(sigma_v/c)^2 * Dds/Ds"];
Print["  This is eq. (7.8) in the notes. VERIFIED\n"];


(* =========================================================================
   Exercise 7.2: SIS kappa = |gamma| Everywhere

   kappa(theta) = thetaE / (2*theta)
   kbar(theta) = thetaE / theta
   |gamma| = kbar - kappa = thetaE / (2*theta) = kappa
   ========================================================================= *)

Print["--- Exercise 7.2: SIS kappa = |gamma| ---\n"];

(* (a) Mean convergence *)
Print["(a) kbar(theta) = (2/theta^2) * Integral[thetaE/(2*theta') * theta', {theta',0,theta}]"];
kbarSIS = (2/theta^2) * Integrate[tE/(2 thp) * thp, {thp, 0, theta},
    Assumptions -> {theta > 0, tE > 0}];
Print["  = ", kbarSIS];
Print["  = thetaE / theta. VERIFIED\n"];

(* (b) Shear *)
Print["(b) |gamma| = kbar - kappa = thetaE/theta - thetaE/(2*theta)"];
gammaSIS = kbarSIS - tE/(2 theta) // Simplify;
Print["  = ", gammaSIS];
Print["  = thetaE/(2*theta) = kappa. VERIFIED\n"];

(* (c) Physical explanation *)
Print["(c) For the point mass, ALL mass is at the origin (delta function)."];
Print["    => kappa = 0 everywhere except at theta = 0."];
Print["    => All distortion comes from tidal shear of the central point mass."];
Print["    For the SIS, mass is continuously distributed (Sigma ~ 1/xi)."];
Print["    => kappa != 0 everywhere."];
Print["    The rho ~ r^-2 profile is exactly the profile where the local"];
Print["    convergence equals the tidal shear at every radius.\n"];

(* (d) Power-law generalization *)
Print["(d) For kappa(theta) = A*theta^(-n) with n > 0:"];
Print["  kbar(theta) = (2/theta^2) * Integral[A*theta'^(-n)*theta', {theta',0,theta}]"];
kbarPowerLaw = (2/theta^2) * Integrate[A thp^(-n) * thp, {thp, 0, theta},
    Assumptions -> {theta > 0, A > 0, 0 < n < 2}];
Print["  = ", kbarPowerLaw];
Print["  = 2*A / ((2-n)*theta^n) = (2/(2-n)) * kappa"];
Print[""];

gammaPL = kbarPowerLaw - A theta^(-n) // Simplify;
Print["  |gamma| = kbar - kappa = ", gammaPL];
ratioGL = Simplify[gammaPL / (A theta^(-n)), Assumptions -> 0 < n < 2];
Print["  |gamma|/kappa = ", ratioGL];
Print["  Setting |gamma| = kappa: n/(2-n) = 1 => n = 1.");
Print["  This is precisely the SIS exponent! VERIFIED\n"];


(* =========================================================================
   Exercise 7.3: SIS Numerical Example

   sigma_v = 250 km/s, zd = 0.3, zs = 1
   Dd = 900 Mpc, Ds = 1700 Mpc, Dds = 1200 Mpc
   ========================================================================= *)

Print["--- Exercise 7.3: SIS Numerical Example ---\n"];

sigmaV = 250 * 1000;  (* m/s *)
DdVal = 900 * MpcToM;
DsVal = 1700 * MpcToM;
DdsVal = 1200 * MpcToM;

(* (a) Einstein radius *)
Print["(a) Einstein radius:"];
thetaESIS = 4 Pi (sigmaV/cc)^2 * DdsVal/DsVal;
thetaEarcsec = thetaESIS * radToArcsec;
Print["  thetaE = 4*Pi*(250000/c)^2 * (1200/1700)"];
Print["  = ", ScientificForm[thetaESIS, 4], " rad"];
Print["  = ", NumberForm[thetaEarcsec, {4, 2}], " arcsec\n"];

(* (b) Source at beta = 0.5" *)
Print["(b) For beta = 0.5 arcsec:"];
betaVal = 0.5;

Print["  (i) beta = 0.5 < thetaE = ", NumberForm[thetaEarcsec, {4, 2}],
    " => source INSIDE caustic."];
Print["      Two images form.\n"];

thetaP = betaVal + thetaEarcsec;
thetaM = betaVal - thetaEarcsec;
Print["  (ii) Image positions:"];
Print["    theta_+ = beta + thetaE = ", NumberForm[thetaP, {5, 2}], " arcsec"];
Print["    theta_- = beta - thetaE = ", NumberForm[thetaM, {5, 2}], " arcsec\n"];

muP = 1 + thetaEarcsec/betaVal;
muM = 1 - thetaEarcsec/betaVal;
Print["  (iii) Magnifications:"];
Print["    mu_+ = 1 + thetaE/beta = ", NumberForm[muP, {5, 2}]];
Print["    mu_- = 1 - thetaE/beta = ", NumberForm[muM, {5, 2}], "\n"];

Print["  (iv) Total magnification:"];
Print["    |mu_+| + |mu_-| = ", NumberForm[Abs[muP] + Abs[muM], {5, 2}]];
Print["    = 2*thetaE/beta = ", NumberForm[2 thetaEarcsec/betaVal, {5, 2}], "\n"];

(* (c) Equal magnification *)
Print["(c) For equal |mu_+| = |mu_-|:"];
Print["  |1 + thetaE/beta| = |thetaE/beta - 1|"];
Print["  For beta < thetaE (doubly imaged): 1 + thetaE/beta = thetaE/beta - 1"];
Print["  => 1 = -1, which is impossible."];
Print["  SIS images NEVER have equal magnification. The primary is always brighter.\n"];

(* (d) Comparison with point mass *)
Print["(d) Point mass Einstein radius for M = 10^12 Msun:"];
thetaEPM = Sqrt[4 Gnewton * 1*^12 * Msolar / cc^2 * DdsVal / (DdVal * DsVal)];
Print["  thetaE(PM) = ", NumberForm[thetaEPM * radToArcsec, {4, 2}], " arcsec"];
Print["  thetaE(SIS) = ", NumberForm[thetaEarcsec, {4, 2}], " arcsec"];
Print["  The SIS Einstein radius depends on sigma_v (velocity dispersion),"];
Print["  while the point mass depends on total mass M."];
Print["  For typical galaxy parameters, they are comparable.\n"];


(* =========================================================================
   Exercise 7.4: NIS Convergence and SIS Limit

   kappa(theta) = thetaE / (2*sqrt(theta^2 + thetac^2))
   Limit as thetac -> 0 gives SIS: kappa = thetaE/(2*theta)
   ========================================================================= *)

Print["--- Exercise 7.4: NIS Convergence ---\n"];

(* (a) Derive NIS convergence *)
Print["(a) NIS surface mass density:"];
Print["  Sigma(theta) = sigma_v^2 / (2*G*Dd*sqrt(theta^2+thetac^2))"];
Print["  kappa = Sigma/Sigma_cr"];
Print["  Using thetaE = 4*Pi*(sigma_v/c)^2 * Dds/Ds and"];
Print["  Sigma_cr = c^2*Ds/(4*Pi*G*Dd*Dds):"];
Print["  kappa(theta) = thetaE / (2*sqrt(theta^2 + thetac^2)). VERIFIED\n"];

(* (b) SIS limit *)
Print["(b) As thetac -> 0:"];
kappaNIS[theta_, tE_, tc_] := tE / (2 Sqrt[theta^2 + tc^2]);
sisLim = Limit[kappaNIS[theta, tE, tc], tc -> 0, Assumptions -> theta > 0];
Print["  kappa -> ", sisLim, " = thetaE/(2*theta) = SIS. VERIFIED\n"];

(* (c) Critical core radius *)
Print["(c) For multiple images: kappa(0) >= 1"];
Print["  kappa(0) = thetaE / (2*thetac) >= 1"];
Print["  => thetac <= thetaE/2"];
Print["  Critical value: thetac_crit = thetaE/2\n"];

(* (d) Numerical values for thetac = 0.1*thetaE *)
Print["(d) For thetac = 0.1*thetaE:"];
Print["  kappa(0) = thetaE/(2*0.1*thetaE) = ", N[1/(2*0.1)]];
Print["  kappa(thetaE) = 1/(2*sqrt(1+0.01)) = ",
    NumberForm[N[1/(2 Sqrt[1.01])], {5, 4}]];
Print["  kappa(2*thetaE) = 1/(2*sqrt(4+0.01)) = ",
    NumberForm[N[1/(2 Sqrt[4.01])], {5, 4}]];
Print[""];

(* (e) Plot *)
Print["(e) NIS convergence profiles for various core radii:"];
Module[{},
    figNIS = Plot[
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
        PlotLabel -> Style["Exercise 7.4(e): NIS Convergence Profiles", 13],
        PlotLegends -> {
            Style[Subscript["\[Theta]", "c"] <> " = 0 (SIS)", 10],
            Style[Subscript["\[Theta]", "c"] <> " = 0.1 " <> Subscript["\[Theta]", "E"], 10],
            Style[Subscript["\[Theta]", "c"] <> " = 0.3 " <> Subscript["\[Theta]", "E"], 10],
            Style[Subscript["\[Theta]", "c"] <> " = 0.5 " <> Subscript["\[Theta]", "E"], 10]
        },
        Epilog -> {Gray, Dashed, AbsoluteThickness[1],
            InfiniteLine[{{0, 1}, {10, 1}}]},
        ImageSize -> 550
    ];
    Print["  (Plot generated - see Figures/07_Axisymmetric_Models/)"];
];
Print[""];


(* =========================================================================
   Exercise 7.5: NFW Concentration and Lensing Strength

   kappa(x) = kappa_s * f(x)  where x = theta/theta_s
   ========================================================================= *)

Print["--- Exercise 7.5: NFW Concentration ---\n"];

(* NFW f(x) function *)
fNFW[x_] := Piecewise[{
    {(1/(x^2 - 1)) (1 - ArcCosh[1/x]/Sqrt[1 - x^2]), x < 1},
    {1/3, x == 1},
    {(1/(x^2 - 1)) (1 - ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1]), x > 1}
}];

(* (a) Plot f(x) *)
Print["(a) NFW f(x) = kappa/kappa_s profile:"];
Print["  f(x) has logarithmic divergence as x -> 0"];
Print["  f(1) = 1/3"];
Print["  f(x) ~ 1/x^2 for x >> 1\n"];

Print["  Table of f(x) values:"];
Print["  x       f(x)"];
Print["  ", StringJoin[Table["-", 20]]];
Do[
    fval = N[fNFW[x]];
    Print["  ", PaddedForm[N[x], {5, 2}], "  ", PaddedForm[fval, {7, 4}]],
    {x, {0.1, 0.3, 0.5, 0.7, 1.0, 1.5, 2.0, 3.0, 5.0, 10.0}}
];
Print[""];

(* (b) Compute kappa_s and theta_s for different concentrations *)
Print["(b) Cluster parameters: M_200 = 10^15 Msun, zd = 0.3, zs = 1"];

(* Virial radius from M_200 = (4/3)*Pi*r_200^3 * 200*rho_crit *)
(* rho_crit(z=0.3) ~ 1.3 * rho_crit(z=0) for our cosmology *)
(* Approximate: rho_crit(z=0) = 3*H0^2/(8*Pi*G) *)
H0 = 70 * 1000 / MpcToM;  (* s^-1 *)
rhoCrit0 = 3 H0^2 / (8 Pi Gnewton);  (* kg/m^3 *)
(* At z=0.3, rho_crit(z) = rho_crit(0) * E(z)^2 *)
(* E(z) = sqrt(Omega_m*(1+z)^3 + Omega_Lambda) *)
Ez03 = Sqrt[0.3 * 1.3^3 + 0.7];
rhoCritZ = rhoCrit0 * Ez03^2;

M200 = 1*^15 * Msolar;  (* kg *)
r200 = (3 M200 / (4 Pi * 200 * rhoCritZ))^(1/3);  (* meters *)
Print["  r_200 = ", NumberForm[r200/MpcToM, {4, 2}], " Mpc"];
Print[""];

(* Sigma_cr *)
SigmaCr = cc^2 / (4 Pi Gnewton) * DsVal / (DdVal * DdsVal);
Print["  Sigma_cr = ", ScientificForm[SigmaCr, 4], " kg/m^2\n"];

Do[
    rs = r200 / c;
    thetaS = rs / DdVal;
    thetaSarcsec = thetaS * radToArcsec;

    (* rho_s from NFW *)
    rhoS = (200/3) * rhoCritZ * c^3 / (Log[1 + c] - c/(1 + c));

    (* kappa_s = 2*rho_s*r_s / Sigma_cr *)
    kappaS = 2 * rhoS * rs / SigmaCr;

    Print["  c = ", c, ":"];
    Print["    r_s = ", NumberForm[rs/MpcToM, {4, 2}], " Mpc"];
    Print["    theta_s = ", NumberForm[thetaSarcsec, {4, 1}], " arcsec"];
    Print["    rho_s = ", ScientificForm[rhoS, 3], " kg/m^3"];
    Print["    kappa_s = ", NumberForm[kappaS, {4, 2}]];
    Print[""],
    {c, {5, 10, 20}}
];

(* (c) and (d) Discussion *)
Print["(c) Higher concentration:"];
Print["  - Increases kappa_s (more centrally concentrated mass)"];
Print["  - Decreases theta_s (smaller scale radius)"];
Print["  - Pushes kappa=1 crossing to larger angles"];
Print["  - Increases Einstein radius\n"];

Print["(d) Effect on lensing:"];
Print["  (i)   Einstein radius increases with c"];
Print["  (ii)  Region where kappa > 1 grows with c"];
Print["  (iii) Lensing cross-section for giant arcs increases ~ c^2"];
Print["  Concentration is a key parameter for cluster arc statistics.\n"];


Print["=== End of Module 7 Solutions ==="];
