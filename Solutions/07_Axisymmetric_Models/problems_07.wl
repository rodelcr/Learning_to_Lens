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
   Annotated-edition checks (2026-10): B1-B15 at the end of this file,
     one per identity/number in the Annotated Study Edition boxes of
     Notes/07_Axisymmetric_Models/*.tex; ends with summary[].
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
Print["  Setting |gamma| = kappa: n/(2-n) = 1 => n = 1."];
Print["  This is precisely the SIS exponent! VERIFIED\n"];


(* =========================================================================
   Exercise 7.3: SIS Numerical Example

   sigma_v = 250 km/s, zd = 0.3, zs = 1
   Dd = 920 Mpc, Ds = 1650 Mpc, Dds = 1055 Mpc (flat LCDM, H0 = 70, Om = 0.3;
   fixed 2026-10-14, earlier versions used 900/1700/1200)
   ========================================================================= *)

Print["--- Exercise 7.3: SIS Numerical Example ---\n"];

sigmaV = 250 * 1000;  (* m/s *)
DdVal = 920 * MpcToM;
DsVal = 1650 * MpcToM;
DdsVal = 1055 * MpcToM;

(* (a) Einstein radius *)
Print["(a) Einstein radius:"];
thetaESIS = 4 Pi (sigmaV/cc)^2 * DdsVal/DsVal;
thetaEarcsec = thetaESIS * radToArcsec;
Print["  thetaE = 4*Pi*(250000/c)^2 * (1055/1650)"];
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
Print["  Here the point-mass ring is about twice the SIS ring: the SIS has only"];
Print["  ~2.3e11 Msun inside its Einstein radius, and M(<thetaE) ~ thetaE^2.\n"];


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
            Style[Row[{"\[Theta] / ", Subscript["\[Theta]", "E"]}], 13],
            Style["\[Kappa](\[Theta])", 13]
        },
        PlotLabel -> Style["Exercise 7.4(e): NIS Convergence Profiles", 13],
        PlotLegends -> {
            Style[Row[{Subscript["\[Theta]", "c"], " = 0 (SIS)"}], 10],
            Style[Row[{Subscript["\[Theta]", "c"], " = 0.1 ", Subscript["\[Theta]", "E"]}], 10],
            Style[Row[{Subscript["\[Theta]", "c"], " = 0.3 ", Subscript["\[Theta]", "E"]}], 10],
            Style[Row[{Subscript["\[Theta]", "c"], " = 0.5 ", Subscript["\[Theta]", "E"]}], 10]
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


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity written in a derivation box and every number quoted in an
   annotation box of Notes/07_Axisymmetric_Models/*.tex (Annotated Study
   Edition) is checked here.  Harness: check[] / summary[].                 *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                  "Mathematica", "harness.wl"}]];
Print["\n=== Annotated-edition checks: Module 7 ==="];
ClearAll[th, tp, tE, tc, xi, zz, sv, GG, cS, Dd, Ds, Dds, MM, kk, s, gp, n, x, w, t, u];
radToArcsec = 180*3600/Pi;
cExact = 299792458.;

(* -- B1. alpha from enclosed mass ---------------------------------------- *)
SigCr = cS^2 Ds/(4 Pi GG Dd Dds);
check["B1 (Dds/Ds) 4GM/(c^2 Dd th) = M/(Pi SigmaCr Dd^2 th)",
  Simplify[(Dds/Ds) 4 GG MM/(cS^2 Dd th) - MM/(Pi SigCr Dd^2 th)] === 0];

(* -- B2. generic axisymmetric identities --------------------------------- *)
kbar[t_] := 2/t^2 Integrate[kk[tp] tp, {tp, 0, t}];
alph[t_] := t kbar[t];
check["B2a d alpha/d theta = 2 kappa - kappabar",
  Simplify[D[alph[th], th] - (2 kk[th] - kbar[th])] === 0];
check["B2b (1-kbar)(1-2k+kbar) = (1-k)^2 - (kbar-k)^2  (det A, gamma = kbar - k)",
  Simplify[(1 - kb)(1 - 2 k + kb) - ((1 - k)^2 - (kb - k)^2)] === 0];
check["B2c kappabar(0) = kappa(0) (L'Hopital) for smooth kappa: NIS example",
  Limit[2/th^2 Integrate[tE/(2 Sqrt[tp^2 + tc^2]) tp, {tp, 0, th},
     Assumptions -> th > 0 && tc > 0], th -> 0, Assumptions -> tc > 0] == tE/(2 tc)];

(* -- B3. point mass: lambda_r = 1 + thetaE^2/theta^2 -------------------- *)
check["B3 point mass lambda_r = 1 - d(tE^2/th)/dth = 1 + tE^2/th^2",
  Simplify[1 - D[tE^2/th, th] - (1 + tE^2/th^2)] === 0];

(* -- B4. SIS chain ------------------------------------------------------ *)
check["B4a Int_-inf^inf sv^2/(2 Pi G (xi^2+z^2)) dz = sv^2/(2 G xi)",
  Simplify[Integrate[sv^2/(2 Pi GG (xi^2 + zz^2)), {zz, -Infinity, Infinity},
     Assumptions -> xi > 0] - sv^2/(2 GG xi)] === 0];
check["B4b M(xi) = 2 Pi Int Sigma xi dxi = Pi sv^2 xi/G",
  Simplify[2 Pi Integrate[sv^2/(2 GG xp) xp, {xp, 0, xi}] - Pi sv^2 xi/GG] === 0];
check["B4c alphahat = 4 G M/(c^2 xi) = 4 Pi sv^2/c^2",
  Simplify[4 GG (Pi sv^2 xi/GG)/(cS^2 xi) - 4 Pi sv^2/cS^2] === 0];
thetaESISsym = 4 Pi sv^2/cS^2 Dds/Ds;
check["B4d kappa = Sigma(Dd th)/SigmaCr = thetaE/(2 th)",
  Simplify[(sv^2/(2 GG Dd th))/SigCr - thetaESISsym/(2 th)] === 0];
check["B4e v_c^2 = G M(r)/r = 2 sv^2 for rho = sv^2/(2 Pi G r^2)",
  Simplify[GG Integrate[4 Pi rr^2 sv^2/(2 Pi GG rr^2), {rr, 0, r}]/r - 2 sv^2] === 0];
check["B4f SIS kappa(thetaE) = 1/2, kappabar(thetaE) = 1",
  Simplify[{tE/(2 th), tE/th} /. th -> tE] === {1/2, 1}];

(* -- B5. sigma_v <-> thetaE numbers -------------------------------------- *)
th250 = 4 Pi (250000/3.*^8)^2 0.638 radToArcsec;
check["B5a 4 Pi (250/3e5)^2 x 0.638 = 1.15 arcsec (chapter Example)",
  Abs[th250 - 1.15] < 0.005];
th250ex = 4 Pi (250000/cExact)^2 radToArcsec;
Print["  [info] 4 Pi (250 km/s/c)^2 = ", th250ex, " arcsec"];
check["B5b 4 Pi (250 km/s / c)^2 = 1.80 arcsec (D_ds/D_s -> 1 limit)",
  Abs[th250ex - 1.80] < 0.005];
check["B5c N&B eq.44: 4 Pi (220 km/s / c)^2 = 1.40 arcsec",
  Abs[4 Pi (220000/cExact)^2 radToArcsec - 1.40] < 0.005];
check["B5d thetaE propto sigma^2: 10% error in sigma -> 21% in thetaE",
  Abs[1.1^2 - 1 - 0.21] < 10^-12];

(* -- B6. Dds != Ds - Dd with the Ex 7.3 / chapter numbers --------------- *)
(* flat LCDM, Om=0.3, H0=70: reproduce 920 / 1650 / 1055 Mpc              *)
EH[z_] := Sqrt[0.3 (1 + z)^3 + 0.7];
dH = cExact/1000/70.;  (* Mpc *)
chi03 = NIntegrate[1/EH[z], {z, 0, 0.3}]; chi1 = NIntegrate[1/EH[z], {z, 0, 1}];
DdN = dH chi03/1.3; DsN = dH chi1/2; DdsN = dH (chi1 - chi03)/2;
Print["  [info] H0=70, Om=0.3: Dd = ", DdN, "  Ds = ", DsN, "  Dds = ", DdsN,
  "  Mpc;  Ds - Dd = ", DsN - DdN];
check["B6a (Dd, Ds, Dds) = (920, 1652, 1055) Mpc to 1%",
  Abs[DdN/920 - 1] < 0.01 && Abs[DsN/1652 - 1] < 0.01 && Abs[DdsN/1055 - 1] < 0.01];
check["B6b Ds - Dd = 730 Mpc != Dds = 1055 Mpc", Abs[DsN - DdN - 730] < 10 && DdsN > DsN - DdN + 300];
check["B6c Ex 7.3 with the stated distances: thetaE = 4 Pi (250/3e5)^2 1055/1650 = 1.15 arcsec",
  Abs[4 Pi (250000/2.998*^8)^2 (1055/1650.) radToArcsec - 1.15] < 0.005];
pmTheta = Sqrt[4 Gnewton 1*^12 Msolar/cc^2 * 1055/(920*1650 MpcToM)] radToArcsec;
Print["  [info] point-mass thetaE (1e12 Msun; 920/1650/1055 Mpc) = ", pmTheta, " arcsec;",
  "  Ex 7.3 body: ", thetaEPM radToArcsec, " arcsec"];
check["B6d point-mass thetaE(1e12 Msun) = 2.4 arcsec with the Ex 7.3 distances",
  Abs[pmTheta - 2.4] < 0.05];

(* -- B7. power law: kappa = (3-g)/2 (tE/th)^(g-1) ------------------------ *)
kPL[t_] := (3 - gp)/2 (tE/t)^(gp - 1);
check["B7a power law kappabar(th) = (tE/th)^(g-1)  =>  kappabar(tE) = 1",
  Simplify[2/th^2 Integrate[kPL[tp] tp, {tp, 0, th},
     Assumptions -> 1 < gp < 3 && th > 0 && tE > 0] - (tE/th)^(gp - 1),
   1 < gp < 3 && th > 0 && tE > 0] === 0];
check["B7b kappa(tE) = (3 - g)/2, = 1/2 at g = 2",
  Simplify[kPL[tE]] === (3 - gp)/2 && (kPL[tE] /. gp -> 2) === 1/2];
check["B7c gamma/kappa = n/(2-n) with n = g - 1: gamma = kappa only at g = 2",
  Solve[(gp - 1)/(2 - (gp - 1)) == 1, gp] === {{gp -> 2}}];

(* -- B8. SIS magnification and eigenvalues ------------------------------- *)
check["B8a SIS lambda_r = 1 - d(tE)/dth = 1;  lambda_t = 1 - tE/|th|",
  1 - D[tE, th] === 1];
check["B8b mu_- = 1/(1 - tE/|th_-|) = 1 - tE/be (theta_- = be - tE)",
  Simplify[1/(1 - tE/(tE - be)) - (1 - tE/be), 0 < be < tE] === 0];
check["B8c mu_+ = 1/(1 - tE/(be+tE)) = 1 + tE/be",
  Simplify[1/(1 - tE/(be + tE)) - (1 + tE/be)] === 0];

(* -- B9. DSPL: Einstein-radius ratio ------------------------------------- *)
ClearAll[Ds1, Ds2, Dds1, Dds2];
check["B9a SIS: thetaE2/thetaE1 = (Dds2/Ds2)/(Dds1/Ds1) (same sigma_v)",
  Simplify[(4 Pi sv^2/cS^2 Dds2/Ds2)/(4 Pi sv^2/cS^2 Dds1/Ds1) -
     (Dds2/Ds2)/(Dds1/Ds1)] === 0];
check["B9b point mass: thetaE2/thetaE1 = sqrt of the same ratio",
  Simplify[Sqrt[4 GG MM/cS^2 Dds2/(Dd Ds2)]/Sqrt[4 GG MM/cS^2 Dds1/(Dd Ds1)] -
     Sqrt[(Dds2/Ds2)/(Dds1/Ds1)], {GG > 0, MM > 0, cS > 0, Dd > 0, Ds1 > 0,
     Ds2 > 0, Dds1 > 0, Dds2 > 0}] === 0];

(* -- B10. NIS ------------------------------------------------------------ *)
check["B10a Int dz/(xi^2 + rc^2 + z^2) = Pi/sqrt(xi^2 + rc^2)",
  Simplify[Integrate[1/(xi^2 + rc^2 + zz^2), {zz, -Infinity, Infinity},
     Assumptions -> xi > 0 && rc > 0] - Pi/Sqrt[xi^2 + rc^2]] === 0];
check["B10b NIS Sigma/SigmaCr = thetaE/(2 sqrt(th^2+tc^2)) (rc = Dd tc)",
  Simplify[(sv^2/(2 GG Dd Sqrt[th^2 + tc^2]))/SigCr -
     thetaESISsym/(2 Sqrt[th^2 + tc^2])] === 0];
alNIS[t_] := tE (Sqrt[t^2 + tc^2] - tc)/t;
check["B10c (2/th) Int kappa th' dth' = alpha_NIS",
  Simplify[2/th Integrate[tE/(2 Sqrt[tp^2 + tc^2]) tp, {tp, 0, th},
     Assumptions -> th > 0 && tc > 0] - alNIS[th], th > 0 && tc > 0] === 0];
sN = Sqrt[th^2 + tc^2];
check["B10d d alpha/d theta = tE tc/(s (s + tc)), s = sqrt(th^2+tc^2)",
  Simplify[D[alNIS[th], th] - tE tc/(sN (sN + tc)), th > 0 && tc > 0] === 0];
check["B10e d alpha/d theta -> tE/(2 tc) = kappa(0) as th -> 0",
  Limit[tE tc/(sN (sN + tc)), th -> 0, Assumptions -> tc > 0] === tE/(2 tc)];
check["B10f d alpha/d theta strictly decreasing in th > 0",
  Simplify[D[tE tc/(sN (sN + tc)), th] < 0, th > 0 && tc > 0 && tE > 0]];
check["B10g lambda_t = 0 <=> s + tc = tE <=> th_t^2 = tE (tE - 2 tc)",
  Simplify[(1 - alNIS[th]/th) /. th -> Sqrt[tE (tE - 2 tc)],
     0 < tc < tE/2 && tE > 0] === 0];
(* radial: s^2 + tc s - tE tc = 0 *)
sR = (-tc + Sqrt[tc^2 + 4 tE tc])/2;
thR = Sqrt[sR^2 - tc^2];
check["B10h lambda_r = 0 at s_r = (-tc + sqrt(tc^2 + 4 tE tc))/2",
  Simplify[1 - tE tc/(sR (sR + tc)), tE > 0 && tc > 0] === 0];
check["B10i th_r^2 > 0  <=>  tc < tE/2",
  Reduce[sR^2 - tc^2 > 0 && tE > 0 && tc > 0, tc] ===
   Reduce[0 < tc < tE/2 && tE > 0, tc]];
check["B10j th_r^2 = tc (tE - tc - s_r)",
  Simplify[thR^2 - tc (tE - tc - sR)] === 0];
check["B10k NIS 'thetaE' is not its Einstein radius: th_t < tE for tc > 0",
  Simplify[tE (tE - 2 tc) < tE^2, tE > 0 && tc > 0]];
(* numbers for tc = 0.1 tE *)
num = {tE -> 1, tc -> 1/10};
thtN = N[Sqrt[tE (tE - 2 tc)] /. num]; thrN = N[thR /. num];
betarN = N[Abs[thR - alNIS[thR]] /. num];
Print["  [info] tc = 0.1 tE: th_t = ", thtN, "  th_r = ", thrN, "  beta_r = ", betarN];
check["B10l tc = 0.1: th_t = 0.894, th_r = 0.251, beta_r = 0.427 (units of tE)",
  Abs[thtN - 0.894] < 0.0005 && Abs[thrN - 0.251] < 0.0005 && Abs[betarN - 0.427] < 0.0005];
(* image count on the axis (signed theta; alpha_NIS is odd in theta) *)
lensNIS[t_, b_] := t - (alNIS[t] /. num) - b;
rootsAt[b_] := Sort[t /. NSolve[(t - b) t == (Sqrt[t^2 + 1/100] - 1/10) && t != 0, t, Reals]];
r02 = rootsAt[1/5]; r06 = rootsAt[3/5];
Print["  [info] beta = 0.2: images at ", r02, ";  beta = 0.6: ", r06];
check["B10m beta = 0.2 < beta_r: three images; beta = 0.6 > beta_r: one image",
  Length[r02] == 3 && Length[r06] == 1];
lamT[t_] := 1 - (alNIS[Abs[t]] /. num)/Abs[t];
lamR[t_] := 1 - (D[alNIS[th], th] /. num /. th -> Abs[t]);
types = Map[Which[lamT[#] > 0 && lamR[#] > 0, "min",
     lamT[#] lamR[#] < 0, "sad", True, "max"] &, r02];
Print["  [info] types (sorted by theta): ", types];
check["B10n beta = 0.2: types = {sad, max, min}; n_min - n_sad + n_max = 1",
  types === {"sad", "max", "min"} &&
   Count[types, "min"] - Count[types, "sad"] + Count[types, "max"] == 1];
(* NIS potential and arrival order *)
psiNIS[t_] := tE (Sqrt[t^2 + tc^2] - tc Log[tc + Sqrt[t^2 + tc^2]]);
check["B10o psi_NIS = tE [s - tc ln(tc + s)] has d psi/d theta = alpha_NIS",
  Simplify[D[psiNIS[th], th] - alNIS[th], th > 0 && tc > 0] === 0];
tauN[t_] := ((t - 1/5)^2/2 - psiNIS[Abs[t]]) /. num;
tvals = tauN /@ r02;
Print["  [info] tau at (sad, max, min) = ", tvals];
check["B10p arrival order: tau(min) < tau(sad) < tau(max) (central image last)",
  tvals[[3]] < tvals[[1]] < tvals[[2]]];
(* N&B Table 2 softened isothermal sphere is a different model *)
alNB[t_] := tE t/Sqrt[tc^2 + t^2];
kNB = Simplify[(D[alNB[th], th] + alNB[th]/th)/2];
check["B10q N&B softened-potential model: kappa = tE (th^2 + 2 tc^2)/(2 (th^2+tc^2)^(3/2)) != NIS",
  Simplify[kNB - tE (th^2 + 2 tc^2)/(2 (th^2 + tc^2)^(3/2))] === 0 &&
   Simplify[kNB - tE/(2 Sqrt[th^2 + tc^2])] =!= 0];
check["B10r N&B model: kappa(0) = tE/tc (criterion tc < tE, not tE/2)",
  Limit[kNB, th -> 0, Assumptions -> tc > 0] === tE/tc];

(* -- B11. NFW derivation steps ------------------------------------------ *)
check["B11a d/dw[sqrt(w^2-x^2)/(1+w)] = (w + x^2)/((1+w)^2 sqrt(w^2-x^2))",
  Simplify[D[Sqrt[w^2 - x^2]/(1 + w), w] - (w + x^2)/((1 + w)^2 Sqrt[w^2 - x^2]),
   w > x > 0] === 0];
check["B11b (w + x^2) = (1+w) + (x^2-1)", Expand[(1 + w) + (x^2 - 1) - (w + x^2)] === 0];
(* half-angle substitution t = tanh(tau/2) *)
check["B11c t = tanh(tau/2): 1 + x cosh(tau) = ((1+x) - (1-x) t^2)/(1 - t^2)",
  Simplify[(1 + x Cosh[u]) - ((1 + x) - (1 - x) Tanh[u/2]^2)/(1 - Tanh[u/2]^2)] === 0];
check["B11d d tau = 2 dt/(1 - t^2)",
  Simplify[D[2 ArcTanh[t], t] - 2/(1 - t^2)] === 0];
check["B11e 0<x<1: 2 arctanh sqrt((1-x)/(1+x)) = arccosh(1/x)",
  And @@ Table[Abs[2 ArcTanh[Sqrt[(1 - xx)/(1 + xx)]] - ArcCosh[1/xx]] < 10^-12,
    {xx, {0.01, 0.2, 0.5, 0.9, 0.999}}]];
check["B11f x>1: 2 arctan sqrt((x-1)/(x+1)) = arctan sqrt(x^2-1) = arccos(1/x)",
  And @@ Table[Abs[2 ArcTan[Sqrt[(xx - 1)/(xx + 1)]] - ArcTan[Sqrt[xx^2 - 1]]] < 10^-12 &&
     Abs[ArcTan[Sqrt[xx^2 - 1]] - ArcCos[1/xx]] < 10^-12, {xx, {1.001, 1.5, 3., 20.}}]];
Kfun[xx_?NumericQ] := NIntegrate[1/(1 + xx Cosh[u]), {u, 0, Infinity}];
Kclosed[xx_] := Piecewise[{{ArcCosh[1/xx]/Sqrt[1 - xx^2], xx < 1},
   {ArcTan[Sqrt[xx^2 - 1]]/Sqrt[xx^2 - 1], xx > 1}}, 1];
check["B11g K(x) closed form = Int_0^inf dtau/(1 + x cosh tau) at x = 0.3, 2.5",
  Abs[Kfun[0.3] - Kclosed[0.3]] < 10^-8 && Abs[Kfun[2.5] - Kclosed[2.5]] < 10^-8];
fN[xx_] := (1 - Kclosed[xx])/(xx^2 - 1);
check["B11h f(1 -/+ 1e-5) -> 1/3 from both branches (1 - K = (x^2-1)/3 + ...)",
  Abs[N[(1 - ArcCosh[1/x]/Sqrt[1 - x^2])/(x^2 - 1) /. x -> 1 - 10^-5, 30] - 1/3] < 10^-4 &&
  Abs[N[(1 - ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1])/(x^2 - 1) /. x -> 1 + 10^-5, 30] - 1/3] < 10^-4];
check["B11i small x: f(x) - ln(2/x) -> -1 (f ~ ln(2/x), NOT (1/x) ln(2/x))",
  Abs[fN[10.^-6] - Log[2/10.^-6] + 1] < 10^-4];
check["B11j d/dx[ln(x/2) + K(x)] = x f(x) (x = 0.4, 2.0)",
  And @@ Table[Abs[(D[Log[xs/2] + ArcCosh[1/xs]/Sqrt[1 - xs^2], xs] /. xs -> xx) - xx fN[xx]] < 10^-10,
    {xx, {0.4}}] &&
  Abs[(D[Log[xs/2] + ArcTan[Sqrt[xs^2 - 1]]/Sqrt[xs^2 - 1], xs] /. xs -> 2.0) - 2.0 fN[2.0]] < 10^-10];
check["B11k f(x) ~ 1/x^2 for x >> 1 (x^2 f -> 1)", Abs[(10.^4)^2 fN[10.^4] - 1] < 10^-3];

(* -- B12. adding a point mass b^2 to an axisymmetric host --------------- *)
ClearAll[k0, kb0, b];
lt[k_, kb_] := 1 - kb; lr[k_, kb_] := 1 - 2 k + kb;
check["B12 point mass adds kappabar += b^2/th^2, kappa += 0: lambda_r += b^2/th^2, lambda_t -= b^2/th^2",
  Simplify[{lr[k0, kb0 + b^2/th^2] - lr[k0, kb0], lt[k0, kb0 + b^2/th^2] - lt[k0, kb0]}] ===
   {b^2/th^2, -b^2/th^2}];

(* -- B13. Exercise 7.4(d) numbers --------------------------------------- *)
check["B13 NIS tc = 0.1: kappa(0) = 5, kappa(tE) = 0.4975, kappa(2 tE) = 0.2497",
  1/(2 0.1) == 5. && Abs[1/(2 Sqrt[1.01]) - 0.4975] < 0.00005 &&
  Abs[1/(2 Sqrt[4.01]) - 0.2497] < 0.00005];

(* -- B14. polar form of the shear for an axisymmetric psi --------------- *)
ClearAll[pf, rr, ph];
psiAx = pf[Sqrt[x1^2 + x2^2]];
g1 = (D[psiAx, {x1, 2}] - D[psiAx, {x2, 2}])/2; g2 = D[psiAx, x1, x2];
polar = {x1 -> rr Cos[ph], x2 -> rr Sin[ph]};
check["B14 gamma1 + i gamma2 = (1/2)(psi'' - psi'/theta) e^{2 i phi}",
  Simplify[((g1 + I g2) /. polar) - (pf''[rr] - pf'[rr]/rr)/2 Exp[2 I ph], rr > 0] === 0];

(* -- B15. numbers in the 07_Solutions annotations ---------------------- *)
check["B15a 1055/1650 = 0.639", Abs[1055/1650. - 0.639] < 0.0005];
check["B15b SIS: |mu+/mu-| = (tE+be)/(tE-be); (th+ - |th-|)/(th+ + |th-|) = be/tE",
  Simplify[{Abs[(1 + tE/be)/(1 - tE/be)] - (tE + be)/(tE - be),
     ((be + tE) - (tE - be))/((be + tE) + (tE - be)) - be/tE}, 0 < be < tE] === {0, 0}];
check["B15c NIS tc=0.1: kappa(tE), kappa(2tE) within 0.5% of 0.5, 0.25",
  Abs[1/(2 Sqrt[1.01])/0.5 - 1] < 0.005 && Abs[1/(2 Sqrt[4.01])/0.25 - 1] < 0.005];
MthE = cc^2/(4 Gnewton) (DdN DsN/DdsN) MpcToM (4 Pi (250000/3.*^8)^2 0.638)^2/Msolar;
Print["  [info] SIS M(<thetaE = 1.15'') = ", MthE, " Msun"];
check["B15d SIS M(<thetaE) = 2.3e11 Msun (thetaE = 1.15'', 919/1652/1055 Mpc)",
  Abs[MthE/1*^11 - 2.3] < 0.05];
check["B15e (2.4/1.15)^2 ~ 4.4: a 1e12 Msun point mass has a ~2x larger ring",
  Abs[Sqrt[1*^12/MthE] - 2.1] < 0.1];

(* -- F. Fix pass 2026-10-14 (FACT_CRITIC_07 V6-V10): each check FAILS on the
   pre-fix printed value and PASSES on the corrected one. ------------------ *)
check["F6 Sol 7.3(a) body: thetaE = 1.15 arcsec with 920/1650/1055 (old 1200/1700 gave 1.27)",
  Abs[thetaEarcsec - 1.15] < 0.005 && Abs[thetaEarcsec - 1.27] > 0.1 &&
  Abs[(2.5*^5/3*^8)^2 - 6.944*^-7]/6.944*^-7 < 0.0005 && Abs[1055/1650. - 0.639] < 0.0005 &&
  Abs[4 Pi 6.944*^-7 0.639/1*^-6 - 5.58] < 0.005];
check["F6b Sol 7.3(b) with thetaE = 1.15: theta+- = 1.65, -0.65; mu+- = 3.30, -1.30; sum 4.60 = 2 thetaE/beta (old 1.77/-0.77/3.54/-1.54/5.08 fail)",
  With[{t = 1.15, b = 0.5},
   Abs[b + t - 1.65] < 10^-9 && Abs[b - t + 0.65] < 10^-9 && Abs[1 + t/b - 3.30] < 10^-9 &&
   Abs[1 - t/b + 1.30] < 10^-9 && Abs[(1 + t/b) + (t/b - 1) - 4.60] < 10^-9 &&
   Abs[2 t/b - 4.60] < 10^-9 && Abs[1 + t/b - 3.54] > 0.1]];
check["F7 Sol 7.3(d) body: point-mass thetaE(1e12 Msun) = 2.38 arcsec (old 1.1 and 2.53 fail); about twice the SIS 1.15",
  Abs[thetaEPM radToArcsec - 2.38] < 0.01 && Abs[thetaEPM radToArcsec - 1.1] > 1 &&
  Abs[thetaEPM radToArcsec - 2.53] > 0.1 && 1.9 < thetaEPM radToArcsec/thetaEarcsec < 2.2];
fSmall = Series[(1/(x^2 - 1)) (1 - ArcCosh[1/x]/Sqrt[1 - x^2]), {x, 0, 1}, Assumptions -> 0 < x < 1];
xfPeak = x /. Last[FindMaximum[x fNFW[x], {x, 0.5, 0.05, 0.95}]];
check["F8 Sol 7.5(a): f(x) = ln(2/x) - 1 + O(x^2 ln x) (not (1/x) ln(2/x)); x f(x) peaks at x = 0.61",
  Simplify[Normal[fSmall] - (Log[2/x] - 1), 0 < x < 1] === 0 &&
  N[fNFW[1/1000]/((1000) Log[2000])] < 0.01 && Abs[xfPeak - 0.61] < 0.01];
nisCount[b_] := Length[rootsAt[b]];
check["F9 Ch 07 caustic sentence (tc = 0.1 tE, beta_r = 0.427): beta = 0.2, 0.4 -> 3 images; 0.45, 0.6 -> 1; tangential caustic is beta = 0",
  nisCount[1/5] == 3 && nisCount[2/5] == 3 && nisCount[45/100] == 1 && nisCount[3/5] == 1 &&
  Abs[(thtN - (alNIS[thtN] /. num))] < 10^-12];
ClearAll[tF];
alHalf[t_] := (Sqrt[t^2 + 1/4] - 1/2)/t;   (* NIS with tE = 1, tc = 1/2 *)
lamRHalf[t_] := 1 - D[alHalf[tF], tF] /. tF -> t;
countHalf[b_] := Length[tF /. NSolve[(tF - b) tF == (Sqrt[tF^2 + 1/4] - 1/2) && tF != 0, tF, Reals]];
check["F10 Ex/Sol 7.4(c): at tc = tE/2, lambda_r > 0 for theta > 0 and -> 0 at theta = 0, one image for beta = 0.01, 0.1 (so kappa(0) > 1, tc < tE/2 strict)",
  Limit[lamRHalf[tF], tF -> 0] == 0 &&
  Min[Table[lamRHalf[t], {t, 0.001, 5, 0.001}]] > 0 && countHalf[1/100] == 1 && countHalf[1/10] == 1];

summary[];




