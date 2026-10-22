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

   Annotated-edition checks (2026-10): appended section at the end of this
   file verifies every identity / number in the annotation, derivation and
   bridge boxes of the Annotated Study Edition (uses ../../Mathematica/
   harness.wl; ends with summary[], exit code 0 iff all checks pass).
   Run via:  bash Mathematica/run_wl.sh <this file>
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

(* Transverse comoving distance D_M: sinh for open (Ok > 0), sin for closed (Ok < 0).
   Fix-pass 2026-10-14 (FACT_CRITIC_03 V4): DAFunc previously returned chi/(1+z) for
   every model, which is wrong for the open Ex 3.3 cosmology (check B25). *)
DMFunc[z_, Om_, OL_] := Module[{chi = chiFunc[z, Om, OL], Ok = 1 - Om - OL,
    dH = clight/H0si/MpcToM},
  Which[Ok > 10^-12, dH/Sqrt[Ok] Sinh[Sqrt[Ok] chi/dH],
        Ok < -10^-12, dH/Sqrt[-Ok] Sin[Sqrt[-Ok] chi/dH],
        True, chi]];

DAFunc[z_, Om_, OL_] := DMFunc[z, Om, OL] / (1 + z);

DLFunc[z_, Om_, OL_] := chiFunc[z, Om, OL] * (1 + z);

(* DdsFunc is the FLAT-universe formula; it is only called with Om + OL = 1 below. *)
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
Print["  Ratio concordance/open = ", ToString[NumberForm[t0Conc/t0Open, {3, 2}]], " (~19% older)"];
Print["  Concordance gives larger age due to late-time acceleration.\n"];


(* =========================================================================
   Exercise 3.3: Angular Diameter Distance Turnover
   ========================================================================= *)

Print["--- Exercise 3.3: Angular Diameter Distance Turnover ---\n"];

Print["(a) DA for three cosmologies:\n"];

(* Fix-pass 2026-10-14: FindMaximum replaces the former 0.1-step grid
   (which printed EdS z_max = 1.3 and, with the curvature-free DAFunc, open 1.5/1445). *)
daNum[z_?NumericQ, om_, ol_] := DAFunc[z, om, ol];
daMaxFn[om_, ol_, z0_] := FindMaximum[daNum[zt, om, ol], {zt, z0}];
{maxConc, zMaxConc} = {#[[1]], zt /. #[[2]]} &[daMaxFn[0.3, 0.7, 1.6]];
Print["  Concordance: z_max=", ToString[NumberForm[zMaxConc, {4, 3}]], ", DA_max=", Round[maxConc], " Mpc"];
{maxEdS, zMaxEdS} = {#[[1]], zt /. #[[2]]} &[daMaxFn[1.0, 0.0, 1.3]];
Print["  EdS: z_max=", ToString[NumberForm[zMaxEdS, {4, 3}]], ", DA_max=", Round[maxEdS], " Mpc"];
{maxOpen, zMaxOpen} = {#[[1]], zt /. #[[2]]} &[daMaxFn[0.3, 0.0, 1.8]];
Print["  Open (D_M with sinh): z_max=", ToString[NumberForm[zMaxOpen, {4, 3}]], ", DA_max=", Round[maxOpen], " Mpc\n"];

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
(* Added 2026-09-24 (fact-critic): the (d) solution previously claimed a
   maximum of theta_E at z_d ~ 0.3-0.4.  In fact theta_E decreases
   monotonically in z_d; it is the PHYSICAL radius R_E = D_d theta_E that
   peaks at intermediate z_d. *)
tEofZd[z_] := Sqrt[4 GN Mlens/clight^2 * (DdsFunc[z, 1.0, 0.3, 0.7] MpcToM)/
    ((DAFunc[z, 0.3, 0.7] MpcToM) (DAFunc[1.0, 0.3, 0.7] MpcToM))];
zgrid = Range[0.02, 0.98, 0.02];
tEvals = tEofZd /@ zgrid;
REvals = MapThread[#1 DAFunc[#2, 0.3, 0.7] &, {tEvals, zgrid}];   (* Mpc *)
Print["  theta_E strictly decreasing in z_d on [0.02,0.98]: ",
    And @@ Negative[Differences[tEvals]]];
reNum[z_?NumericQ] := tEofZd[z] DAFunc[z, 0.3, 0.7];
Module[{reMax = FindMaximum[{reNum[zt], 0.05 <= zt <= 0.95}, {zt, 0.35}]},
  Print["  R_E = D_d theta_E peaks at z_d = ", ToString[NumberForm[zt /. reMax[[2]], {3, 3}]],
    " (R_E = ", ToString[NumberForm[1000 reMax[[1]], {3, 1}]], " kpc)"]];
Print[""];

Print["=== End of Module 3 Solutions ==="];


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity and number quoted in the annotation / derivation / bridge
   boxes of Notes/03_Cosmological_Distances/03_Cosmological_Distances.tex and
   03_Solutions.tex (Annotated Study Edition only) is verified here.
   Reuses GN, clight, MpcToM, H0si, Efunc, chiFunc, DAFunc, DdsFunc,
   computeChristoffel, gammaFRW, metricFRW, coordsFRW defined above. *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                  "Mathematica", "harness.wl"}]];

Print["\n--- Annotated-edition checks: Module 3 ---\n"];

(* ---------- B1: all 13 Christoffel symbols of the RW metric (x^0 = t) ---------- *)
Module[{ad = a'[t], aa = a[t], expect},
  expect = {
    {1, 2, 2} -> aa ad/(c^2 (1 - k r^2)),
    {1, 3, 3} -> aa ad r^2/c^2,
    {1, 4, 4} -> aa ad r^2 Sin[\[Theta]]^2/c^2,
    {2, 1, 2} -> ad/aa, {3, 1, 3} -> ad/aa, {4, 1, 4} -> ad/aa,
    {2, 2, 2} -> k r/(1 - k r^2),
    {2, 3, 3} -> -r (1 - k r^2),
    {2, 4, 4} -> -r (1 - k r^2) Sin[\[Theta]]^2,
    {3, 2, 3} -> 1/r, {3, 4, 4} -> -Sin[\[Theta]] Cos[\[Theta]],
    {4, 2, 4} -> 1/r, {4, 3, 4} -> Cos[\[Theta]]/Sin[\[Theta]]};
  check["B1a the 13 listed Christoffel symbols match computeChristoffel",
    And @@ (Simplify[gammaFRW[[Sequence @@ #[[1]]]] - #[[2]]] === 0 & /@ expect)];
  check["B1b no other independent nonvanishing component",
    Count[Flatten[Table[If[m <= n && gammaFRW[[s, m, n]] =!= 0, 1, 0],
        {s, 4}, {m, 4}, {n, 4}]], 1] == 13]];

(* ---------- B2: Ricci tensor, scalar, Einstein tensor (x^0 = t) ---------- *)
annRiemann[gam_, x_] := Table[
    D[gam[[rh, nu, si]], x[[mu]]] - D[gam[[rh, mu, si]], x[[nu]]] +
    Sum[gam[[rh, mu, la]] gam[[la, nu, si]] - gam[[rh, nu, la]] gam[[la, mu, si]], {la, 4}],
    {rh, 4}, {si, 4}, {mu, 4}, {nu, 4}];
annRiem = annRiemann[gammaFRW, coordsFRW];
annRic = Table[Simplify[Sum[annRiem[[la, mu, la, nu]], {la, 4}]], {mu, 4}, {nu, 4}];
annGinv = Inverse[metricFRW];
annRs = Simplify[Sum[annGinv[[i, j]] annRic[[i, j]], {i, 4}, {j, 4}]];
Print["  R_00 (x^0 = t) = ", annRic[[1, 1]]];
check["B2a with x^0 = t: R_00 = -3 a''/a (no 1/c^2)",
  Simplify[annRic[[1, 1]] + 3 a''[t]/a[t]] === 0];
check["B2b with x^0 = c t: R_00 = -3 a''/(c^2 a)  (R_{t t}/c^2)",
  Simplify[annRic[[1, 1]]/c^2 + 3 a''[t]/(c^2 a[t])] === 0];
check["B2c R_11 = (a a'' + 2 a'^2 + 2 k c^2)/(c^2 (1 - k r^2))",
  Simplify[annRic[[2, 2]] - (a[t] a''[t] + 2 a'[t]^2 + 2 k c^2)/(c^2 (1 - k r^2))] === 0];
check["B2d R = (6/c^2)(a''/a + a'^2/a^2 + k c^2/a^2)",
  Simplify[annRs - 6/c^2 (a''[t]/a[t] + a'[t]^2/a[t]^2 + k c^2/a[t]^2)] === 0];
check["B2e g^00 R_00 = 3 a''/(c^2 a) and g^ij R_ij = 3(a a''+2a'^2+2kc^2)/(c^2 a^2)",
  Simplify[annGinv[[1, 1]] annRic[[1, 1]] - 3 a''[t]/(c^2 a[t])] === 0 &&
  Simplify[Sum[annGinv[[i, i]] annRic[[i, i]], {i, 2, 4}] -
     3 (a[t] a''[t] + 2 a'[t]^2 + 2 k c^2)/(c^2 a[t]^2)] === 0];
annG00 = Simplify[annRic[[1, 1]] - annRs metricFRW[[1, 1]]/2 + \[CapitalLambda] metricFRW[[1, 1]]];
check["B2f G_00 + Lambda g_00 = 3(a'^2/a^2 + k c^2/a^2) - Lambda c^2",
  Simplify[annG00 - (3 (a'[t]^2/a[t]^2 + k c^2/a[t]^2) - \[CapitalLambda] c^2)] === 0];
check["B2g (00) equation = 8 pi G rho  <=>  H^2 = 8 pi G rho/3 - k c^2/a^2 + Lambda c^2/3",
  Module[{adsq},
    Simplify[(adsq /. First@Solve[(annG00 /. a'[t] -> Sqrt[adsq]) == 8 Pi G \[Rho], adsq]) -
      a[t]^2 (8 Pi G \[Rho]/3 - k c^2/a[t]^2 + \[CapitalLambda] c^2/3)] === 0]];

(* B3: spatial equation divided by g_11, combined with the first equation *)
annG11 = Simplify[(annRic[[2, 2]] - annRs metricFRW[[2, 2]]/2 + \[CapitalLambda] metricFRW[[2, 2]])/
    metricFRW[[2, 2]]];
check["B3a (G_11 + Lambda g_11)/g_11 = -(1/c^2)(2a''/a + a'^2/a^2 + k c^2/a^2) + Lambda",
  Simplify[annG11 - (-(1/c^2) (2 a''[t]/a[t] + a'[t]^2/a[t]^2 + k c^2/a[t]^2) + \[CapitalLambda])] === 0];
Module[{acc},
  acc = a''[t] /. First@Solve[(annG11 == 8 Pi G p/c^4) /.
       a'[t]^2 -> a[t]^2 (8 Pi G \[Rho]/3 - k c^2/a[t]^2 + \[CapitalLambda] c^2/3), a''[t]];
  check["B3b => a''/a = -(4 pi G/3)(rho + 3p/c^2) + Lambda c^2/3",
    Simplify[acc/a[t] - (-(4 Pi G/3) (\[Rho] + 3 p/c^2) + \[CapitalLambda] c^2/3)] === 0]];

(* B4: fluid equation from d/dt of Friedmann I + Friedmann II *)
Module[{HH, rhoDotSol},
  (* Friedmann I with rho(t):  a'^2 = a^2 (8 pi G rho/3 - k c^2/a^2 + Lambda c^2/3) ; differentiate *)
  rhoDotSol = rhoD /. First@Solve[
      2 a'[t] a''[t] == D[a[t]^2 (8 Pi G rho[t]/3 + \[CapitalLambda] c^2/3), t] /. rho'[t] -> rhoD,
      rhoD];
  rhoDotSol = rhoDotSol /. a''[t] -> a[t] (-(4 Pi G/3) (rho[t] + 3 p/c^2) + \[CapitalLambda] c^2/3) /.
      a'[t]^2 -> a[t]^2 (8 Pi G rho[t]/3 - k c^2/a[t]^2 + \[CapitalLambda] c^2/3);
  check["B4 rho' = -3 (a'/a)(rho + p/c^2)",
    Simplify[rhoDotSol + 3 a'[t]/a[t] (rho[t] + p/c^2)] === 0]];
check["B4b d/dt of Friedmann I: 2H(a''/a - H^2) = (8 pi G/3) rho' + 2 k c^2 a'/a^3",
  Simplify[D[a'[t]^2/a[t]^2 - (8 Pi G rho[t]/3 - k c^2/a[t]^2 + \[CapitalLambda] c^2/3), t] -
    (2 a'[t]/a[t] (a''[t]/a[t] - a'[t]^2/a[t]^2) - (8 Pi G/3) rho'[t] - 2 k c^2 a'[t]/a[t]^3)] === 0];

(* B5: rho(a) for constant w and for CPL w(a) = w0 + wa (1 - a) *)
check["B5a rho' + 3(a'/a)(1+w) rho = 0 solved by rho = rho0 a^(-3(1+w))",
  Simplify[D[r0c a[t]^(-3 (1 + w)), t] + 3 a'[t]/a[t] (1 + w) r0c a[t]^(-3 (1 + w))] === 0];
Module[{lnrho, zeta},
  (* d ln rho / d ln a = -3 (1 + w(a))  =>  ln(rho/rho0) = 3 Int_a^1 (1+w(a'))/a' da' *)
  lnrho = 3 Integrate[(1 + w0 + wa (1 - x))/x, {x, aa, 1}, Assumptions -> 0 < aa < 1];
  check["B5b CPL: rho_DE/rho_DE0 = a^(-3(1+w0+wa)) exp(-3 wa (1-a))",
    Simplify[Exp[lnrho] - aa^(-3 (1 + w0 + wa)) Exp[-3 wa (1 - aa)], 0 < aa < 1] === 0];
  zeta = (1 + zz)^(3 (1 + w0 + wa)) Exp[-3 wa zz/(1 + zz)];
  check["B5c with a = 1/(1+z): zeta(z) = (1+z)^(3(1+w0+wa)) exp(-3 wa z/(1+z))",
    Simplify[(aa^(-3 (1 + w0 + wa)) Exp[-3 wa (1 - aa)] /. aa -> 1/(1 + zz)) - zeta, zz > 0] === 0];
  check["B5d zeta: =1 at z=0; = (1+z)^(3(1+w)) for wa=0; =1 for (w0,wa)=(-1,0)",
    (zeta /. zz -> 0) === 1 && Simplify[(zeta /. wa -> 0) - (1 + zz)^(3 (1 + w0))] === 0 &&
    (zeta /. {w0 -> -1, wa -> 0}) === 1];
  check["B5e numerical: d ln rho/d ln a = -3(1+w(a)) at a = 0.4, (w0,wa) = (-0.9, 0.3)",
    Abs[(D[Log[aa^(-3 (1 + w0 + wa)) Exp[-3 wa (1 - aa)]], aa] aa /. {aa -> 0.4, w0 -> -0.9, wa -> 0.3}) -
      (-3 (1 + (-0.9) + 0.3 (1 - 0.4)))] < 10^-12]];

(* B6: single-component scale factors *)
check["B6a matter: a = (3/2 H0 sqrt(Om) t)^(2/3) solves (a'/a)^2 = H0^2 Om a^-3",
  Simplify[(D[(3/2 h0 Sqrt[om] t)^(2/3), t]/(3/2 h0 Sqrt[om] t)^(2/3))^2 -
    h0^2 om (3/2 h0 Sqrt[om] t)^(-2), h0 > 0 && om > 0 && t > 0] === 0];
check["B6b radiation: a = (2 H0 sqrt(Or) t)^(1/2) solves (a'/a)^2 = H0^2 Or a^-4",
  Simplify[(D[(2 h0 Sqrt[or] t)^(1/2), t]/(2 h0 Sqrt[or] t)^(1/2))^2 -
    h0^2 or (2 h0 Sqrt[or] t)^(-2), h0 > 0 && or > 0 && t > 0] === 0];

(* B7: comoving distance change of variables: c dt/a = c da/(a^2 H) = -c dz/H with a = 1/(1+z) *)
check["B7 c da/(a^2 H) with a = 1/(1+z): da/dz/a^2 = -1",
  Simplify[D[1/(1 + zz), zz]/(1/(1 + zz))^2] === -1];

(* B8: Hubble distance, Hubble time, critical density for H0 = 70 *)
annDH = clight/H0si/MpcToM;
Print["  D_H = ", annDH, " Mpc = ", clight/H0si, " m; t_H = ", secToGyr/H0si, " Gyr; rho_cr = ",
      3 H0si^2/(8 Pi GN), " kg/m^3"];
check["B8a D_H = c/H0 = 4283 Mpc = 1.32e26 m",
  Round[annDH] == 4283 && Abs[clight/H0si/1*^26 - 1.32] < 0.005];
check["B8b t_H = 1/H0 = 13.97 Gyr and 977.8/h relation",
  Abs[secToGyr/H0si - 13.97] < 0.005 && Abs[70 secToGyr/H0si - 977.8] < 0.5];
check["B8c rho_cr,0 = 9.2e-27 kg/m^3", Abs[3 H0si^2/(8 Pi GN)/1*^-27 - 9.2] < 0.05];

(* B9: d chi = dr/sqrt(1 - k r^2) => r = S_k(chi) *)
check["B9 Int dr/sqrt(1 - r^2) = arcsin r; Int dr/sqrt(1 + r^2) = arcsinh r",
  Simplify[D[ArcSin[r], r] - 1/Sqrt[1 - r^2]] === 0 && Simplify[D[ArcSinh[r], r] - 1/Sqrt[1 + r^2]] === 0];

(* B10: Hogg eq. 19 from the sinh subtraction formula (open case) *)
Module[{DM, R0 = r0curv},
  DM[x_] := R0 Sinh[x/R0];
  check["B10a R0 sinh((chis-chid)/R0) = DM(s) sqrt(1 + DM(d)^2/R0^2) - DM(d) sqrt(1 + DM(s)^2/R0^2)",
    Simplify[R0 Sinh[(xs - xd)/R0] -
      (DM[xs] Sqrt[1 + DM[xd]^2/R0^2] - DM[xd] Sqrt[1 + DM[xs]^2/R0^2]),
      R0 > 0 && xs > xd > 0] === 0];
  check["B10b Omega_k D_M^2/D_H^2 = D_M^2/R0^2 when R0 = D_H/sqrt(Omega_k)",
    Simplify[ok DM[xd]^2/dh^2 /. R0 -> dh/Sqrt[ok], ok > 0 && dh > 0] ===
      Simplify[DM[xd]^2/R0^2 /. R0 -> dh/Sqrt[ok], ok > 0 && dh > 0]]];
check["B10c closed case: sin subtraction formula",
  Simplify[R0c Sin[(xs - xd)/R0c] - (R0c Sin[xs/R0c] Cos[xd/R0c] - R0c Sin[xd/R0c] Cos[xs/R0c])] === 0];

(* B11: comoving-distance table (concordance) *)
annChiTab = Table[chiFunc[zz0, 0.3, 0.7], {zz0, {0.1, 0.5, 1.0, 2.0, 5.0}}];
Print["  chi(z) for z = 0.1,0.5,1,2,5: ", annChiTab];
check["B11 chi table within 1% of 420, 1880, 3300, 5200, 7775 Mpc",
  And @@ MapThread[Abs[#1/#2 - 1] < 0.01 &, {annChiTab, {420, 1880, 3300, 5200, 7775}}]];

(* B12: turnover: dD_A/dz = 0 <=> c(1+z)/H(z) = chi(z) *)
annChiFlat[z_?NumericQ] := chiFunc[z, 0.3, 0.7];
annZmax = zt /. FindRoot[clight/(H0si Efunc[zt, 0.3, 0.7] MpcToM) (1 + zt) == annChiFlat[zt], {zt, 1.6}];
annDAmax = DAFunc[annZmax, 0.3, 0.7];
Print["  concordance turnover: z_max = ", annZmax, ", D_A,max = ", annDAmax, " Mpc"];
check["B12a concordance: z_max = 1.60 (to 0.01) and D_A,max = 1748 Mpc (to 1)",
  Abs[annZmax - 1.60] < 0.01 && Round[annDAmax] == 1748];
check["B12b dD_A/dz = [chi'(z)(1+z) - chi]/(1+z)^2 (quotient rule)",
  Simplify[D[ch[zz]/(1 + zz), zz] - (ch'[zz] (1 + zz) - ch[zz])/(1 + zz)^2] === 0];
Module[{s, f},
  (* EdS: D_A = (2c/H0)(1 - (1+z)^(-1/2))/(1+z) = (2c/H0)(1-s)s^2, s = (1+z)^(-1/2) *)
  check["B12c EdS: chi = (2c/H0)(1 - (1+z)^(-1/2))",
    Simplify[Integrate[(1 + x)^(-3/2), {x, 0, zz}, Assumptions -> zz > 0] - 2 (1 - (1 + zz)^(-1/2))] === 0];
  f = (1 - s) s^2;
  check["B12d EdS: max of (1-s)s^2 at s = 2/3 => z = 5/4, D_A,max = (8/27) c/H0",
    (s /. Solve[D[f, s] == 0 && s > 0, s][[1]]) === 2/3 && (1/(2/3)^2 - 1) === 5/4 &&
    2 (f /. s -> 2/3) === 8/27]];
annEdSmax = 8/27 annDH;
(* open case uses D_M = D_H/sqrt(Ok) sinh(sqrt(Ok) chi/D_H); find its D_A maximum directly *)
annDAopen[z_?NumericQ] := annDH/Sqrt[0.7] Sinh[Sqrt[0.7] chiFunc[z, 0.3, 0.0]/annDH]/(1 + z);
annOpenMax = FindMaximum[annDAopen[zt], {zt, 1.5}];
annDAnum[z_?NumericQ, om_, ol_] := DAFunc[z, om, ol];
annEdSnum = FindMaximum[annDAnum[zt, 1.0, 0.0], {zt, 1.3}];
Print["  EdS: (8/27) D_H = ", annEdSmax, " Mpc; numerical max ", annEdSnum];
Print["  open (sinh, correct D_M): ", annOpenMax];
annDAflatOpen[z_?NumericQ] := chiFunc[z, 0.3, 0.0]/(1 + z);
Print["  open with chi/(1+z) (curvature ignored in D_M; the pre-2026-10-14 DAFunc): ",
      FindMaximum[annDAflatOpen[zt], {zt, 1.5}]];
check["B12e EdS: (8/27) c/H0 = 1269 Mpc and numerical maximum at z = 1.25",
  Round[annEdSmax] == 1269 && Abs[(zt /. annEdSnum[[2]]) - 1.25] < 0.01 &&
  Abs[annEdSnum[[1]] - annEdSmax] < 1];
check["B12f open (Om=0.3, Ok=0.7) with D_M = (D_H/sqrt(Ok)) sinh(sqrt(Ok) chi/D_H): z_max = 1.90, D_A,max = 1583 Mpc",
  Abs[(zt /. annOpenMax[[2]]) - 1.90] < 0.005 && Round[annOpenMax[[1]]] == 1583];

(* B13: the Section-12 example and the asymmetry D_A(z2,z1) = (1+z2)/(1+z1) D_A(z1,z2) *)
annDd = DAFunc[0.5, 0.3, 0.7]; annDs = DAFunc[2.0, 0.3, 0.7]; annDds = DdsFunc[0.5, 2.0, 0.3, 0.7];
Print["  zd=0.5, zs=2: Dd=", annDd, " Ds=", annDs, " Dds=", annDds, " Ds-Dd=", annDs - annDd];
check["B13a Dd = 1259, Ds = 1727, Dds = 1097, Ds - Dd = 468 Mpc (to 1)",
  Round[annDd] == 1259 && Round[annDs] == 1727 && Round[annDds] == 1097 && Round[annDs - annDd] == 468];
annDsd = (chiFunc[2.0, 0.3, 0.7] - chiFunc[0.5, 0.3, 0.7])/(1 + 0.5);
Print["  D_A(z=2 -> z=0.5) = ", annDsd, "  ratio = ", annDsd/annDds];
check["B13b reversed order: D_A(2.0 -> 0.5) = 2 D_A(0.5 -> 2.0) = 2194 Mpc",
  Abs[annDsd/annDds - 3.0/1.5] < 10^-12 && Round[annDsd] == 2194];
check["B13c the subtraction trap: Ds - Dd = [chis - chid - zs Dd... ] i.e. Dds - (Ds - Dd) = Dd (zs - zd)/(1+zs)",
  Simplify[((xs - xd)/(1 + zs)) - (xs/(1 + zs) - xd/(1 + zd)) - (xd/(1 + zd)) (zs - zd)/(1 + zs)] === 0];
check["B13d numeric: Dds - (Ds - Dd) = Dd (zs - zd)/(1+zs) = 630 Mpc",
  Abs[(annDds - (annDs - annDd)) - annDd (2.0 - 0.5)/3.0] < 10^-9 && Round[annDd 1.5/3.0] == 630];

(* B14: flat w0waCDM chain chi(z) -> D_A(z1,z2) *)
annEw[z_, om_, w0_, wa_] := Sqrt[om (1 + z)^3 + (1 - om) (1 + z)^(3 (1 + w0 + wa)) Exp[-3 wa z/(1 + z)]];
annChiW[z_?NumericQ, om_, w0_, wa_] := annDH NIntegrate[1/annEw[x, om, w0, wa], {x, 0, z}];
annDAW[z1_?NumericQ, z2_?NumericQ, om_, w0_, wa_] := (annChiW[z2, om, w0, wa] - annChiW[z1, om, w0, wa])/(1 + z2);
annDw1 = annDAW[0.5, 2.0, 0.3, -1, 0];
annDw2 = annDAW[0.5, 2.0, 0.3, -0.9, 0];
annDw3 = annDAW[0.5, 2.0, 0.3, -0.9, 0.3];
Print["  D_A(0.5,2.0): LCDM ", annDw1, "; w0=-0.9 ", annDw2, "; (w0,wa)=(-0.9,0.3) ", annDw3];
check["B14a w0wa chain reproduces LCDM D_A(0.5,2.0) = 1097 Mpc for (w0,wa)=(-1,0)",
  Abs[annDw1 - annDds] < 10^-6 annDds && Round[annDw1] == 1097];
check["B14b (w0,wa) = (-0.9,0): D_A(0.5,2.0) = 1072 Mpc; (-0.9,0.3): 1047 Mpc",
  Round[annDw2] == 1072 && Round[annDw3] == 1047];

(* B15: DSPL ratio B = D_ls1 D_s2/(D_s1 D_ls2) — flat: all (1+z) and c/H0 cancel *)
check["B15a flat: B = (chi1 - chil) chi2/(chi1 (chi2 - chil))",
  Simplify[(((x1 - xl)/(1 + z1)) (x2/(1 + z2)))/((x1/(1 + z1)) ((x2 - xl)/(1 + z2))) -
    (x1 - xl) x2/(x1 (x2 - xl))] === 0];
annB[zl_, z1_, z2_, om_, w0_, wa_] := Module[{cl, c1, c2},
  {cl, c1, c2} = annChiW[#, om, w0, wa] & /@ {zl, z1, z2};
  (c1 - cl) c2/(c1 (c2 - cl))];
annB0 = annB[0.3, 0.8, 2.0, 0.3, -1, 0];
annBp = annB[0.3, 0.8, 2.0, 0.3, -0.99, 0];
annBm = annB[0.3, 0.8, 2.0, 0.3, -1.01, 0];
annDlnBdw = (Log[annBp] - Log[annBm])/0.02;
Print["  B(0.3, 0.8, 2.0) LCDM = ", annB0, ";  dlnB/dw0 = ", annDlnBdw,
      ";  B(w0=-0.9) = ", annB[0.3, 0.8, 2.0, 0.3, -0.9, 0],
      ";  B(Om=0.25) = ", annB[0.3, 0.8, 2.0, 0.25, -1, 0]];
check["B15b example zl=0.3, z1=0.8, z2=2.0 (Om=0.3, LCDM): B = 0.743 (to 0.0005), B < 1",
  Abs[annB0 - 0.743] < 0.0005 && annB0 < 1];
check["B15c B unchanged by H0 (chi scale cancels): ratio form is degree-0 homogeneous",
  Simplify[((s x1 - s xl) s x2/(s x1 (s x2 - s xl))) - (x1 - xl) x2/(x1 (x2 - xl))] === 0];
check["B15d d ln B / d w0 at w0 = -1 = -0.032 (to 0.0005): a 0.1 shift in w0 moves B by 0.3%",
  Abs[annDlnBdw + 0.032] < 0.0005 && Abs[annB[0.3, 0.8, 2.0, 0.3, -0.9, 0]/annB0 - 1 + 0.003] < 0.0005];

(* B16: lensing efficiency peak and monotone distance ratio *)
annEff[zd_?NumericQ, zs_] := DAFunc[zd, 0.3, 0.7] DdsFunc[zd, zs, 0.3, 0.7]/DAFunc[zs, 0.3, 0.7];
annPk1 = FindMaximum[annEff[zt, 1.0], {zt, 0.4}];
annPk2 = FindMaximum[annEff[zt, 2.0], {zt, 0.5}];
Print["  efficiency peak zs=1: ", annPk1, "; zs=2: ", annPk2];
check["B16a efficiency Dd Dds/Ds peaks at zd = 0.35 (zs=1) and 0.5 (zs=2), to 0.05",
  Abs[(zt /. annPk1[[2]]) - 0.35] < 0.05 && Abs[(zt /. annPk2[[2]]) - 0.5] < 0.05];
check["B16b flat: Dd Dds/Ds = chid (chis - chid)/((1+zd) chis)",
  Simplify[(xd/(1 + zd)) ((xs - xd)/(1 + zs))/(xs/(1 + zs)) - xd (xs - xd)/((1 + zd) xs)] === 0];
Module[{chis = chiFunc[1.0, 0.3, 0.7], chiPk},
  chiPk = chiFunc[zt /. annPk1[[2]], 0.3, 0.7];
  Print["  zs=1: chi at efficiency peak / chi_s = ", chiPk/chis];
  check["B16c the peak sits short of the comoving midpoint (chi_d/chi_s < 0.5) for zs = 1",
    chiPk/chis < 0.5]];
annDratio = Table[DdsFunc[zd0, 1.0, 0.3, 0.7]/(DAFunc[zd0, 0.3, 0.7] DAFunc[1.0, 0.3, 0.7]),
   {zd0, 0.02, 0.98, 0.02}];
check["B16d calD = Dds/(Dd Ds) strictly decreasing in zd on [0.02, 0.98] (zs = 1)",
  And @@ Negative[Differences[annDratio]]];

(* B17: handy Sigma_cr factor *)
annSigFac = clight^2/(4 Pi GN) MpcToM/Msolar/1*^6;   (* Msun kpc^-2 per (Mpc^-1) *)
Print["  c^2/(4 pi G) = ", clight^2/(4 Pi GN), " kg/m = ", annSigFac, " Msun kpc^-2 x Mpc"];
check["B17a c^2/(4 pi G) = 1.07e26 kg/m = 1.663e12 Msun kpc^-2 Mpc",
  Abs[clight^2/(4 Pi GN)/1*^26 - 1.07] < 0.005 && Abs[annSigFac/1*^12 - 1.663] < 0.0005];
check["B17b Q0957: Sigma_cr = 1.663e12 x Ds/(Dd Dds)[Mpc^-1] reproduces 2.4e9 Msun/kpc^2",
  Abs[annSigFac DsQ/(DdQ DdsQ) - SigmaCrSol] < 10^-6 SigmaCrSol && Abs[SigmaCrSol/1*^9 - 2.4] < 0.05];

(* B18: ages *)
annT0closed = 2/(3 Sqrt[0.7]) ArcSinh[Sqrt[0.7/0.3]];
Print["  H0 t0 (flat LCDM closed form) = ", annT0closed, "; t0 = ", annT0closed secToGyr/H0si,
      " Gyr; numeric ", t0Conc, "; open ", t0Open, "; EdS ", t0EdS, "; ratio ", t0Conc/t0Open];
check["B18a flat LCDM: H0 t0 = (2/(3 sqrt(OL))) arcsinh(sqrt(OL/Om)) = 0.964 = numerical",
  Abs[annT0closed - 0.964] < 0.0005 && Abs[annT0closed secToGyr/H0si - t0Conc] < 10^-4];
check["B18b t0: concordance 13.5, open 11.3, EdS 9.3 Gyr; ratio conc/open = 1.19",
  Abs[t0Conc - 13.5] < 0.05 && Abs[t0Open - 11.3] < 0.05 && Abs[t0EdS - 9.3] < 0.05 &&
  Abs[t0Conc/t0Open - 1.19] < 0.005];
check["B18c t = Int dt = Int da/(a H) = Int dz/((1+z) H)",
  Simplify[-D[1/(1 + zz), zz]/((1/(1 + zz)) hh) - 1/((1 + zz) hh)] === 0];
check["B18d EdS: Int_0^inf (1+z)^(-5/2) dz = 2/3", Integrate[(1 + x)^(-5/2), {x, 0, Infinity}] === 2/3];

(* B19: worked-solution numbers *)
annChi036 = chiFunc[0.36, 0.3, 0.7]; annChi141 = chiFunc[1.41, 0.3, 0.7];
Print["  chi(0.36) = ", annChi036, ", chi(1.41) = ", annChi141, "; Dd, Ds, Dds = ", {DdQ, DsQ, DdsQ},
      "; thetaE = ", thetaEarcsec, "; ", thetaErad, " rad"];
check["B19a Q0957: chi = 1411, 4194; Dd = 1038, Ds = 1740, Dds = 1155 Mpc; Dds/(Ds-Dd) = 1.6",
  Round[annChi036] == 1411 && Round[annChi141] == 4194 && Round[DdQ] == 1038 &&
  Round[DsQ] == 1740 && Round[DdsQ] == 1155 && Abs[DdsQ/(DsQ - DdQ) - 1.6] < 0.05];
check["B19b Q0957: thetaE = 1.1e-5 rad = 2.3 arcsec",
  Abs[thetaErad/1*^-5 - 1.1] < 0.05 && Abs[thetaEarcsec - 2.3] < 0.05];
Print["  Ex 3.5: chiD, chiS = ", {chiD, chiS}, "; Dd, Ds, Dds = ", {DdStd, DsStd, DdsStd},
      "; thetaE = ", thetaEStdArcsec, "; M10 = ", M10arcsec];
check["B19c Ex 3.5: chi = 1194, 3304; Dd = 919, Ds = 1652, Dds = 1055 Mpc",
  Round[chiD] == 1194 && Round[chiS] == 3304 && Round[DdStd] == 919 && Round[DsStd] == 1652 &&
  Round[DdsStd] == 1055];
check["B19d Ex 3.5: thetaE = 2.38 arcsec, M(10 arcsec) = 1.8e13 Msun, R_S = 2.95e15 m = 0.096 pc",
  Abs[thetaEStdArcsec - 2.38] < 0.005 && Abs[M10arcsec/1*^13 - 1.8] < 0.05 &&
  Abs[2 GN 1*^12 Msolar/clight^2/1*^15 - 2.95] < 0.005 &&
  Abs[2 GN 1*^12 Msolar/clight^2/(kpcToM/1000) - 0.096] < 0.0005];
(* handy thetaE formula: thetaE = 2.9" sqrt(M/1e12) sqrt(calD / Gpc^-1) *)
annThFac = Sqrt[4 GN 1*^12 Msolar/clight^2/(1000 MpcToM)] radToArcsec;
Print["  thetaE prefactor for M = 1e12 Msun and calD = 1 Gpc^-1: ", annThFac, " arcsec"];
check["B19e thetaE = 2.85 arcsec sqrt(M/1e12 Msun) sqrt(calD/Gpc^-1)", Abs[annThFac - 2.85] < 0.005];
check["B19f Ex 3.5: calD = Dds/(Dd Ds) = 0.695 Gpc^-1 and 2.85 sqrt(0.695) = 2.38",
  Abs[1000 DdsStd/(DdStd DsStd) - 0.695] < 0.0005 &&
  Abs[annThFac Sqrt[1000 DdsStd/(DdStd DsStd)] - thetaEStdArcsec] < 10^-9];


(* B20: small numbers quoted in the H(z) / comoving-distance boxes *)
Print["  H0 = ", H0si, " s^-1; cz/H0 at z=0.1: ", 0.1 annDH, " Mpc vs chi = ", chiFunc[0.1, 0.3, 0.7],
      "; Or(1+z)^4/(Om(1+z)^3) at z=3 with Or=9e-5: ", 9*^-5 4/0.3];
check["B20a H0 = 70 km/s/Mpc = 2.268e-18 s^-1", Abs[H0si/1*^-18 - 2.268] < 0.0005];
check["B20b c z/H0 at z = 0.1 is 428 Mpc, 2% above chi(0.1)",
  Round[0.1 annDH] == 428 && Round[100 (0.1 annDH/chiFunc[0.1, 0.3, 0.7] - 1)] == 2];
check["B20c radiation/matter at z = 3 for Or = 9e-5, Om = 0.3 is ~1e-3 (1.2e-3)",
  Abs[9*^-5 (1 + 3)/0.3 - 1.2*^-3] < 0.05*^-3];
check["B20d (w0,wa)=(-0.9,0) changes D_A(0.5,2.0) by about 2% (2.3%)",
  Abs[100 (1 - annDw2/annDw1) - 2.3] < 0.05];


(* B21: hand computation of R_11 grouped into the four terms of the Ricci formula *)
Module[{g = gammaFRW, x = coordsFRW, t1, t2, t3, t4, kk = k r/(1 - k r^2)},
  t1 = Sum[D[g[[l, 2, 2]], x[[l]]], {l, 4}];
  t2 = -Sum[D[g[[l, 2, l]], x[[2]]], {l, 4}];
  t3 = Sum[g[[l, l, s]] g[[s, 2, 2]], {l, 4}, {s, 4}];
  t4 = -Sum[g[[l, 2, s]] g[[s, 2, l]], {l, 4}, {s, 4}];
  check["B21a R_11 term 1 = (a'^2 + a a'')/(c^2(1-kr^2)) + d/dr[kr/(1-kr^2)]",
    Simplify[t1 - ((a'[t]^2 + a[t] a''[t])/(c^2 (1 - k r^2)) + D[kk, r])] === 0];
  check["B21b R_11 term 2 = -d/dr[kr/(1-kr^2) + 2/r]",
    Simplify[t2 + D[kk + 2/r, r]] === 0];
  check["B21c R_11 term 3 = 3 a'^2/(c^2(1-kr^2)) + kk^2 + 2k/(1-kr^2)",
    Simplify[t3 - (3 a'[t]^2/(c^2 (1 - k r^2)) + kk^2 + 2 k/(1 - k r^2))] === 0];
  check["B21d R_11 term 4 = -[2 a'^2/(c^2(1-kr^2)) + kk^2 + 2/r^2]",
    Simplify[t4 + (2 a'[t]^2/(c^2 (1 - k r^2)) + kk^2 + 2/r^2)] === 0];
  check["B21e terms 1+2 (spatial parts) = 2/r^2, total = R_11",
    Simplify[D[kk, r] - D[kk + 2/r, r] - 2/r^2] === 0 && Simplify[t1 + t2 + t3 + t4 - annRic[[2, 2]]] === 0]];
(* B22: fluid-equation algebra with k kept *)
check["B22 a''/a - H^2 = -4 pi G (rho + p/c^2) + k c^2/a^2 (using both Friedmann eqs)",
  Simplify[(-(4 Pi G/3) (\[Rho] + 3 p/c^2) + \[CapitalLambda] c^2/3) -
     (8 Pi G \[Rho]/3 - k c^2/aa^2 + \[CapitalLambda] c^2/3) -
     (-4 Pi G (\[Rho] + p/c^2) + k c^2/aa^2)] === 0];
(* B23: Q0957 subtraction-gap and open-universe age in H0 units *)
check["B23a Q0957: Dds - (Ds - Dd) = Dd (zs-zd)/(1+zs) = 452 Mpc",
  Abs[(DdsQ - (DsQ - DdQ)) - DdQ (zsQ - zdQ)/(1 + zsQ)] < 10^-9 && Round[DdQ (zsQ - zdQ)/(1 + zsQ)] == 452];
check["B23b open (Om=0.3, Ok=0.7): H0 t0 = 0.809", Abs[t0Open H0si/secToGyr - 0.809] < 0.0005];
check["B23c Ex 3.5(c): (10/2.38)^2 x 1e12 = 1.77e13 Msun", Abs[M10arcsec/1*^13 - 1.77] < 0.005];


(* B24: Q0957 thetaE via the scaling form; SIS Einstein-radius ratio = B *)
check["B24a Q0957: calD = 0.64 Gpc^-1, sqrt = 0.80, 2.85 x sqrt(calD) = 2.28 arcsec = thetaE",
  Abs[1000 DdsQ/(DdQ DsQ) - 0.64] < 0.005 && Abs[Sqrt[1000 DdsQ/(DdQ DsQ)] - 0.80] < 0.005 &&
  Abs[annThFac Sqrt[1000 DdsQ/(DdQ DsQ)] - thetaEarcsec] < 10^-9 && Abs[thetaEarcsec - 2.28] < 0.005];
check["B24b SIS: thetaE = 4 pi (sigma/c)^2 Dls/Ds  =>  thetaE1/thetaE2 = Dls1 Ds2/(Ds1 Dls2)",
  Simplify[(4 Pi sg^2/cS^2 Dls1/Ds1)/(4 Pi sg^2/cS^2 Dls2/Ds2) - Dls1 Ds2/(Ds1 Dls2)] === 0];

(* ---- Fix-pass 2026-10-14 (FACT_CRITIC_03 V3-V6, N4, X2): each check fails on the old value ---- *)
(* B25: V4 Ex 3.3(a) turnover table: new rows vs the old 1.61/1770, 1.25/1180, 1.44/1300 *)
check["B25a concordance row 1.605 / 1748 Mpc (old 1770 fails)",
  Abs[zMaxConc - 1.605] < 0.001 && Round[maxConc] == 1748 && Abs[maxConc - 1770] > 10];
check["B25b EdS row 1.25 / 1269 Mpc (old 1180 fails)",
  Abs[zMaxEdS - 1.25] < 0.001 && Round[maxEdS] == 1269 && Abs[maxEdS - 1180] > 50];
check["B25c open row via DAFunc (sinh D_M): 1.90 / 1583 Mpc (old 1.44 / 1300 fail)",
  Abs[zMaxOpen - 1.90] < 0.005 && Round[maxOpen] == 1583 &&
  Abs[zMaxOpen - 1.44] > 0.3 && Abs[maxOpen - 1300] > 200];
check["B25d DAFunc reduces to chi/(1+z) for flat models (D_A(1) concordance)",
  Abs[DAFunc[1.0, 0.3, 0.7] - chiFunc[1.0, 0.3, 0.7]/2] < 10^-9];

(* B26: V3 Ex 3.2(c): open age 11.3 Gyr, concordance ~19% older (old 11.0 Gyr / 23% fail) *)
check["B26 open t0 = 11.3 Gyr (not 11.0); conc/open - 1 = 19% (not 23%)",
  Abs[t0Open - 11.3] < 0.05 && Abs[t0Open - 11.0] > 0.2 &&
  Round[100 (t0Conc/t0Open - 1)] == 19];

(* B27: V5/V6 efficiency peak at chi_d/chi_s = 0.42 (z_s = 1), not 0.5; calD has no interior maximum *)
Module[{pk, zd, ratio},
  pk = FindMaximum[annEff[zt, 1.0], {zt, 0.35}];
  zd = zt /. pk[[2]];
  ratio = chiFunc[zd, 0.3, 0.7]/chiFunc[1.0, 0.3, 0.7];
  Print["  efficiency peak (z_s = 1): z_d = ", zd, ", chi_d/chi_s = ", ratio];
  check["B27a efficiency peak z_d = 0.350, chi_d/chi_s = 0.42 (not the midpoint 0.5)",
    Abs[zd - 0.350] < 0.002 && Abs[ratio - 0.42] < 0.005 && ratio < 0.45]];
(* calD monotonic: already asserted by B16d. *)

(* B28: N4 chi(0.1) < cz/H0 because H(z) > H0: chi ~ (c/H0)[z - (1+q0) z^2/2], q0 = Om/2 - OL;
        EdS (decelerating) gap 7%, LCDM 2%, pure Lambda 0% -- acceleration SHRINKS the gap *)
Module[{dH = clight/H0si/MpcToM, q0 = 0.3/2 - 0.7, gapL, gapE, gapV},
  gapL = 1 - chiFunc[0.1, 0.3, 0.7]/(dH 0.1);
  gapE = 1 - chiFunc[0.1, 1.0, 0.0]/(dH 0.1);
  gapV = 1 - chiFunc[0.1, 0.0, 1.0]/(dH 0.1);
  Print["  cz/H0 excess at z=0.1: LCDM ", gapL, ", EdS ", gapE, ", pure Lambda ", gapV];
  check["B28a second-order chi(0.1) = (c/H0)[z - (1+q0)z^2/2] within 0.1% of numerical",
    Abs[dH (0.1 - (1 + q0) 0.1^2/2)/chiFunc[0.1, 0.3, 0.7] - 1] < 0.001];
  check["B28b gaps: LCDM 2%, EdS 7%, pure Lambda 0 (more deceleration, larger gap)",
    Round[100 gapL] == 2 && Round[100 gapE] == 7 && Abs[gapV] < 10^-6 && gapE > gapL > gapV]];

(* B29: X2 age as a fraction of t_H: open 0.81 < concordance 0.96 *)
check["B29 H0 t0: open 0.81 < concordance 0.96 (t_H overstates the open age by more)",
  Abs[t0Open H0si/secToGyr - 0.81] < 0.005 && Abs[t0Conc H0si/secToGyr - 0.96] < 0.005 &&
  t0Open < t0Conc];

summary[];
