(* =========================================================================
   problems_03.wl
   Module 3: Cosmological Distances - SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 3, verified
            symbolically and numerically with Mathematica.

   Sources: Carroll Ch. 8, Congdon & Keeton Ch. 3.5,
            Narayan & Bartelmann Sec. 2.2

   Usage:   wolframscript -file problems_03.wl

   Exercises solved:
     3.1 - Deriving the Friedmann equations from the RW metric
     3.2 - Age of the universe for different cosmologies
     3.3 - Angular diameter distance turnover
     3.4 - Distances for Q0957+561
     3.5 - Einstein radius for a typical galaxy lens
   ========================================================================= *)

Print["=== Module 3: SOLUTIONS ===\n"];

(* ---- Physical constants ---- *)
GN = 6.674*^-11;
clight = 2.998*^8;
Msolar = 1.989*^30;
MpcToM = 3.086*^22;
kpcToM = 3.086*^19;
radToArcsec = 180 * 3600 / Pi;
secToGyr = 1 / (3.156*^7 * 1*^9);

H0val = 70.0;
H0si = H0val * 1000 / MpcToM;


(* ---- Reusable distance functions ---- *)

Efunc[z_, Om_, OL_] := Sqrt[Om (1 + z)^3 + OL + (1 - Om - OL) (1 + z)^2];

chiFunc[z_, Om_, OL_] := NIntegrate[
    clight / (H0si * Efunc[zz, Om, OL]) / MpcToM,
    {zz, 0, z},
    Method -> "GaussKronrod"
];

DAFunc[z_, Om_, OL_] := chiFunc[z, Om, OL] / (1 + z);

DLFunc[z_, Om_, OL_] := chiFunc[z, Om, OL] * (1 + z);

DdsFunc[zd_, zs_, Om_, OL_] := Module[{chis, chid},
    chis = chiFunc[zs, Om, OL];
    chid = chiFunc[zd, Om, OL];
    (chis - chid) / (1 + zs)
];


(* =========================================================================
   Exercise 3.1: Deriving the Friedmann Equations
   ========================================================================= *)

Print["--- Exercise 3.1: Deriving the Friedmann Equations ---\n"];

Print["(a) Christoffel symbols for FRW metric"];
Print["  Diagonal metric formulas give 13 nonvanishing components."];
Print["  Key results (verified in friedmann_equations.wl):"];
Print["    Gamma^0_{11} = a*adot/(c^2*(1-kr^2))"];
Print["    Gamma^i_{0i} = adot/a"];
Print[""];

(* Symbolic verification *)
computeChristoffel[metric_, coords_] := Module[
    {n, invMetric, gamma},
    n = Length[coords];
    invMetric = Simplify[Inverse[metric]];
    gamma = Table[
        Simplify[Sum[(1/2) invMetric[[sigma, rho]] (
            D[metric[[nu, rho]], coords[[mu]]]
            + D[metric[[rho, mu]], coords[[nu]]]
            - D[metric[[mu, nu]], coords[[rho]]]),
            {rho, 1, n}]],
        {sigma, 1, n}, {mu, 1, n}, {nu, 1, n}];
    gamma];

coordsFRW = {t, r, \[Theta], \[Phi]};
metricFRW = {
    {-c^2, 0, 0, 0},
    {0, a[t]^2/(1 - k r^2), 0, 0},
    {0, 0, a[t]^2 r^2, 0},
    {0, 0, 0, a[t]^2 r^2 Sin[\[Theta]]^2}
};

gammaFRW = computeChristoffel[metricFRW, coordsFRW];

gamma011 = gammaFRW[[1, 2, 2]];
expected011 = a[t] a'[t] / (c^2 (1 - k r^2));
Print["  Gamma^0_{11} computed: ", gamma011];
Print["  Match with expected? ", Simplify[gamma011 - expected011] === 0];

gamma101 = gammaFRW[[2, 1, 2]];
Print["  Gamma^r_{tr} computed: ", gamma101];
Print["  Match with adot/a? ", Simplify[gamma101 - a'[t]/a[t]] === 0];
Print[""];

Print["(b) Ricci tensor: see friedmann_equations.wl for full computation"];
Print[""];

Print["(c) Friedmann equations follow from Einstein eqs + perfect fluid"];
Print["  1st: H^2 = 8piG*rho/3 - kc^2/a^2 + Lambda*c^2/3"];
Print["  2nd: addot/a = -4piG/3*(rho+3p/c^2) + Lambda*c^2/3"];
Print[""];

Print["(d) Fluid conservation from differentiating 1st, using 2nd:"];
Print["  drho/dt + 3*(adot/a)*(rho + p/c^2) = 0"];
Print[""];


(* =========================================================================
   Exercise 3.2: Age of the Universe
   ========================================================================= *)

Print["--- Exercise 3.2: Age of the Universe ---\n"];

Print["(a) Einstein-de Sitter (Om=1, OL=0, k=0):"];
ageIntegral = Integrate[1/(1 + z)^(5/2), {z, 0, Infinity}];
Print["  Integral = ", ageIntegral, " => t_0 = 2/(3*H0)"];

t0EdS = 2 / (3 * H0si) * secToGyr;
Print["  For H0 = 70: t_0 = ", NumberForm[t0EdS, {3, 1}], " Gyr\n"];

Print["(b) Concordance (Om=0.3, OL=0.7):"];
t0Conc = NIntegrate[
    1 / ((1 + z) * H0si * Efunc[z, 0.3, 0.7]),
    {z, 0, Infinity}] * secToGyr;
Print["  t_0 = ", NumberForm[t0Conc, {4, 1}], " Gyr\n"];

Print["(c) Open (Om=0.3, OL=0, Ok=0.7):"];
t0Open = NIntegrate[
    1 / ((1 + z) * H0si * Efunc[z, 0.3, 0.0]),
    {z, 0, Infinity}] * secToGyr;
Print["  t_0 = ", NumberForm[t0Open, {4, 1}], " Gyr"];
Print["  Concordance gives larger age due to late-time acceleration.\n"];


(* =========================================================================
   Exercise 3.3: Angular Diameter Distance Turnover
   ========================================================================= *)

Print["--- Exercise 3.3: Angular Diameter Distance Turnover ---\n"];

Print["(a) DA for three cosmologies:\n"];

daConc = Table[{z0, DAFunc[z0, 0.3, 0.7]}, {z0, 0.1, 5.0, 0.1}];
maxConc = Max[daConc[[All, 2]]];
zMaxConc = Select[daConc, #[[2]] == maxConc &][[1, 1]];
Print["  Concordance: z_max=", zMaxConc, ", DA_max=", Round[maxConc], " Mpc"];

daEdS = Table[{z0, DAFunc[z0, 1.0, 0.0]}, {z0, 0.1, 5.0, 0.1}];
maxEdS = Max[daEdS[[All, 2]]];
zMaxEdS = Select[daEdS, #[[2]] == maxEdS &][[1, 1]];
Print["  EdS: z_max=", zMaxEdS, ", DA_max=", Round[maxEdS], " Mpc"];

daOpen = Table[{z0, DAFunc[z0, 0.3, 0.0]}, {z0, 0.1, 5.0, 0.1}];
maxOpen = Max[daOpen[[All, 2]]];
zMaxOpen = Select[daOpen, #[[2]] == maxOpen &][[1, 1]];
Print["  Open: z_max=", zMaxOpen, ", DA_max=", Round[maxOpen], " Mpc\n"];

Print["(b) DA = chi/(1+z). At low z, chi grows faster than (1+z)."];
Print["  At high z, (1+z) dominates, causing DA to decrease.\n"];

(* More precise search *)
daConcFine = Table[{z0, DAFunc[z0, 0.3, 0.7]}, {z0, 1.0, 2.0, 0.01}];
maxConcFine = Max[daConcFine[[All, 2]]];
zMaxConcFine = Select[daConcFine, #[[2]] == maxConcFine &][[1, 1]];
Print["(c) Precise turnover: z_max = ", zMaxConcFine];
Print["  DA_max = ", Round[maxConcFine], " Mpc\n"];


(* =========================================================================
   Exercise 3.4: Distances for Q0957+561
   ========================================================================= *)

Print["--- Exercise 3.4: Distances for Q0957+561 ---\n"];

zdQ = 0.36;
zsQ = 1.41;

DdQ = DAFunc[zdQ, 0.3, 0.7];
DsQ = DAFunc[zsQ, 0.3, 0.7];
DdsQ = DdsFunc[zdQ, zsQ, 0.3, 0.7];

Print["(a) D_d=", Round[DdQ], " Mpc, D_s=", Round[DsQ], " Mpc, D_ds=", Round[DdsQ], " Mpc\n"];

Print["(b) D_s - D_d = ", Round[DsQ - DdQ], " Mpc, but D_ds = ", Round[DdsQ], " Mpc"];
Print["  Ratio D_ds/(D_s-D_d) = ", NumberForm[DdsQ / (DsQ - DdQ), {3, 1}], "\n"];

SigmaCrKgM2 = clight^2 / (4 Pi GN) *
    (DsQ * MpcToM) / ((DdQ * MpcToM) * (DdsQ * MpcToM));
SigmaCrSol = SigmaCrKgM2 / Msolar * kpcToM^2;
Print["(c) Sigma_cr = ", ScientificForm[SigmaCrSol, 3], " Msun/kpc^2\n"];

Mlens = 1*^12 * Msolar;
thetaErad = Sqrt[4 GN Mlens / clight^2 *
    (DdsQ * MpcToM) / ((DdQ * MpcToM) * (DsQ * MpcToM))];
thetaEarcsec = thetaErad * radToArcsec;
Print["(d) theta_E = ", NumberForm[thetaEarcsec, {3, 2}], " arcsec\n"];


(* =========================================================================
   Exercise 3.5: Einstein Radius (z_d=0.3, z_s=1.0)
   ========================================================================= *)

Print["--- Exercise 3.5: Einstein Radius (z_d=0.3, z_s=1.0) ---\n"];

zdStd = 0.3;
zsStd = 1.0;

chiD = chiFunc[zdStd, 0.3, 0.7];
chiS = chiFunc[zsStd, 0.3, 0.7];
DdStd = chiD / (1 + zdStd);
DsStd = chiS / (1 + zsStd);
DdsStd = (chiS - chiD) / (1 + zsStd);

Print["(a) D_d=", Round[DdStd], " D_s=", Round[DsStd], " D_ds=", Round[DdsStd], " Mpc\n"];

Mlens = 1*^12 * Msolar;
thetaEStd = Sqrt[4 GN Mlens / clight^2 *
    (DdsStd * MpcToM) / ((DdStd * MpcToM) * (DsStd * MpcToM))];
thetaEStdArcsec = thetaEStd * radToArcsec;
Print["(b) theta_E = ", NumberForm[thetaEStdArcsec, {3, 2}], " arcsec\n"];

Print["(c) theta_E ~ sqrt(M), so theta_E = ", NumberForm[thetaEStdArcsec, {3, 1}],
    " * sqrt(M / 10^12 Msun)"];
M10arcsec = 1*^12 * (10 / thetaEStdArcsec)^2;
Print["  For theta_E = 10 arcsec: M = ", ScientificForm[M10arcsec, 3], " Msun\n"];

Print["(d) theta_E vs z_d table:"];
Print["  z_d     theta_E (arcsec)"];
Print["  -------------------------"];
zdRange = {0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9};
Do[
    Module[{dd, ds, dds, tE},
        dd = DAFunc[zd0, 0.3, 0.7];
        ds = DAFunc[1.0, 0.3, 0.7];
        dds = DdsFunc[zd0, 1.0, 0.3, 0.7];
        tE = Sqrt[4 GN Mlens / clight^2 *
            (dds * MpcToM) / ((dd * MpcToM) * (ds * MpcToM))];
        Print["  ", NumberForm[zd0, {4, 2}], "     ",
            NumberForm[tE * radToArcsec, {5, 3}]];
    ],
    {zd0, zdRange}
];
Print[""];

Print["=== End of Module 3 Solutions ==="];
