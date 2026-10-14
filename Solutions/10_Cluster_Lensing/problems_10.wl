(* =========================================================================
   problems_10.wl
   Module 10: Strong Lensing by Galaxy Clusters --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 10, verified
            symbolically and numerically with Mathematica.

   Sources: Congdon & Keeton Ch. 7
            Narayan & Bartelmann Sec. 4
            Meneghetti 2021 Ch. 5
            Bartelmann (1996) - NFW lensing
            Wright & Brainerd (2000) - NFW analytical formulae

   Usage:   wolframscript -file problems_10.wl

   Exercises solved:
     10.1 --- NFW cluster Einstein radius and enclosed mass
     10.2 --- Ray-tracing a source through a cluster potential
     10.3 --- Magnification of a high-redshift galaxy
     10.4 --- Einstein radii across mass scales
     10.5 --- Weak lensing mass estimate
   Annotated-edition checks (2026-10) appended at the end: every number /
   identity in the derivation, annotation and bridge boxes of 10_Solutions.tex.
   ========================================================================= *)

Print["=== Module 10: SOLUTIONS ===\n"];

(* ---- Physical constants ---- *)
Gnewton = 6.674*^-11;      (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
kpcToM = 3.086*^19;         (* 1 kpc in meters *)
MpcToM = 3.086*^22;         (* 1 Mpc in meters *)
radToArcsec = 180 * 3600 / Pi;

(* ---- Cosmological parameters ---- *)
H0 = 70 * 1000 / MpcToM;   (* H0 in s^-1 *)
Ez03 = Sqrt[0.3 * (1.3)^3 + 0.7];  (* E(z=0.3) *)
Hz03 = H0 * Ez03;
rhoCrit03 = 3 Hz03^2 / (8 Pi Gnewton);

(* Angular-diameter distances computed in the concordance cosmology
   (flat, Om = 0.3, OL = 0.7, H0 = 70) -- replaces the rounded hardcoded
   900/1750/1400 Mpc (fact-critic 2026-09-24).  Values computed here:
   918.8/1726.6/1328.5 Mpc (an earlier comment said 1328.2; fixed 2026-10-14). *)
cKmsDA = 299792.458; H0DA = 70.;
DcMpc[z_?NumericQ] := (cKmsDA/H0DA) NIntegrate[1/Sqrt[0.3 (1 + zz)^3 + 0.7], {zz, 0, z}];
DAMpc[z_] := DcMpc[z]/(1 + z);
DA12Mpc[z1_, z2_] := (DcMpc[z2] - DcMpc[z1])/(1 + z2);
DdVal = DAMpc[0.3] * MpcToM;         (* Dd for zd = 0.3 (~918.8 Mpc), in meters *)
DsVal = DAMpc[2.0] * MpcToM;         (* Ds for zs = 2 (~1726.6 Mpc) *)
DdsVal = DA12Mpc[0.3, 2.0] * MpcToM; (* Dds for zd = 0.3, zs = 2 (~1328.5 Mpc) *)
Print["D_d, D_s, D_ds (Mpc) = ", {DdVal, DsVal, DdsVal}/MpcToM];
DdsOverDs = DdsVal / DsVal;

(* Critical surface mass density *)
SigmaCr = cc^2 / (4 Pi Gnewton) * DsVal / (DdVal * DdsVal);
Print["Sigma_cr = ", ScientificForm[SigmaCr, 4], " kg/m^2"];
Print["Sigma_cr = ", ScientificForm[SigmaCr / Msolar * (MpcToM)^2, 4], " Msun/Mpc^2\n"];


(* ---- NFW Functions ---- *)

fNFW[x_?NumericQ] := Which[
    x < 1 - 10^-6,
    1/(x^2 - 1) (1 - ArcCosh[1/x]/Sqrt[1 - x^2]),
    Abs[x - 1] <= 10^-6,
    1/3,
    x > 1 + 10^-6,
    1/(x^2 - 1) (1 - ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1])
];

gNFW[x_?NumericQ] := Which[
    x < 1 - 10^-6,
    ArcCosh[1/x]/Sqrt[1 - x^2],
    Abs[x - 1] <= 10^-6,
    1,
    x > 1 + 10^-6,
    ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1]
];

kappaNFW[x_, ks_] := ks * fNFW[x];
(* Factor-of-2 (not 4) matches the kappa_s = 2 rho_s r_s/Sigma_cr convention used
   in Notes/10/eq:cl_nfw_alpha and Notes/07/eq:nfw_alpha (Module 7 NFW projection).
   With this convention the cluster_lensing.wl Section 1 definitions agree. *)
kbarNFW[x_, ks_] := 2 ks / x^2 * (Log[x/2] + gNFW[x]);
alphaNFW[x_, ks_, thetas_] := 2 ks * thetas / x * (Log[x/2] + gNFW[x]);
gammaNFW[x_, ks_] := kbarNFW[x, ks] - kappaNFW[x, ks];

(* NFW parameter computation *)
nfwParams[M200Msun_, c_] := Module[
    {M200, r200, rs, rhoS, thetaS, kappaS},
    M200 = M200Msun * Msolar;
    r200 = (3 M200 / (800 Pi rhoCrit03))^(1/3);
    rs = r200 / c;
    rhoS = 200/3 * rhoCrit03 * c^3 / (Log[1 + c] - c/(1 + c));
    thetaS = rs / DdVal;  (* radians *)
    kappaS = 2 rhoS * rs / SigmaCr;
    <|"M200" -> M200, "r200" -> r200, "rs" -> rs, "rhoS" -> rhoS,
      "thetaS" -> thetaS, "kappaS" -> kappaS, "c" -> c|>
];


(* =========================================================================
   Exercise 10.1: NFW Cluster Einstein Radius and Enclosed Mass

   M200 = 5*10^14 Msun, c = 5, zd = 0.3, zs = 2
   ========================================================================= *)

Print["--- Exercise 10.1: NFW Cluster Einstein Radius ---\n"];

p1 = nfwParams[5*^14, 5];

Print["(a) NFW parameters:"];
Print["  r200  = ", NumberForm[p1["r200"] / MpcToM * 1000, {4, 1}], " kpc"];
Print["  rs    = ", NumberForm[p1["rs"] / kpcToM, {4, 1}], " kpc"];
Print["  rhoS  = ", ScientificForm[p1["rhoS"], 3], " kg/m^3"];
Print["  theta_s = ", NumberForm[p1["thetaS"] * radToArcsec, {4, 1}], " arcsec"];
Print["  kappa_s = ", NumberForm[p1["kappaS"], {4, 3}], "\n"];

(* (b) Einstein radius *)
Print["(b) Finding Einstein radius: kbar(x_t) = 1"];
xt1 = x /. FindRoot[kbarNFW[x, p1["kappaS"]] == 1, {x, 0.3}];
thetaE1 = xt1 * p1["thetaS"] * radToArcsec;
Print["  x_t = ", NumberForm[xt1, {4, 3}]];
Print["  theta_E = ", NumberForm[thetaE1, {4, 1}], " arcsec\n"];

(* (c) Enclosed mass within theta_E *)
Print["(c) Enclosed mass within theta_E:"];
thetaE1rad = thetaE1 / radToArcsec;
Mencl1 = Pi * (DdVal * thetaE1rad)^2 * SigmaCr / Msolar;
Print["  M(theta_E) = ", ScientificForm[Mencl1, 3], " Msun\n"];

(* (d) Fraction *)
Print["(d) Fraction of virial mass:"];
fracM = Mencl1 * Msolar / p1["M200"];
Print["  M(theta_E)/M200 = ", NumberForm[fracM, {3, 2}], "\n"];


(* =========================================================================
   Exercise 10.2: Ray-Tracing Through a Cluster

   Use the same cluster parameters as Exercise 10.1.
   Source: circular disk, radius 0.5", at beta = 0, 0.5*thetaE, 0.1*thetaE
   (exercise cases i-iii), plus beta = thetaE for comparison.
   Fix pass 2026-10-14 (fact-critic 10-14, VF4): the box was +-1.5 thetaE,
   but for beta = 0.5 and ~1 thetaE the single image lies at ~2-2.7 thetaE,
   OUTSIDE the box, which is why those cases returned 0 pixels.  The box is
   now +-3 thetaE (20.7").
   ========================================================================= *)

Print["--- Exercise 10.2: Ray-Tracing (Giant Arcs) ---\n"];

ks1 = p1["kappaS"];
ts1 = p1["thetaS"];
ts1arcsec = ts1 * radToArcsec;
sourceR = 0.5;  (* arcsec *)

ts1arcsec = ts1 * radToArcsec;

Print["Ray-tracing with source radius = ", sourceR, " arcsec"];
Print["Einstein radius = ", NumberForm[thetaE1, {4, 1}], " arcsec"];

betaVals = {0.0, 0.5 * thetaE1, 0.1 * thetaE1, 1.0 * thetaE1};
betaLabels = {"beta = 0", "beta = 0.5 * thetaE", "beta = 0.1 * thetaE", "beta = thetaE"};
rayCounts = {};   (* {total, on source side (th1 > 0), opposite side (th1 < 0)} *)

Do[
    Module[{beta0, gridRange, step, nPixels, nPos, nNeg, thetaR, xVal, alphaR, ratio, b1, b2},
        beta0 = N[betaVals[[i]]];
        gridRange = N[3 * thetaE1];
        step = N[0.15];  (* finer grid for accuracy *)
        nPixels = 0; nPos = 0; nNeg = 0;
        Do[
            thetaR = Sqrt[th1^2 + th2^2];
            If[thetaR > 0.1,
                xVal = thetaR / ts1arcsec;
                (* Factor 2 (not 4) — see kappa_s convention note above. *)
                alphaR = 2 ks1 * ts1arcsec / xVal * (Log[xVal/2] + gNFW[xVal]);
                ratio = alphaR / thetaR;
                b1 = th1 * (1 - ratio);
                b2 = th2 * (1 - ratio);
                If[Sqrt[(b1 - beta0)^2 + b2^2] <= sourceR,
                    nPixels++; If[th1 > 0, nPos++, nNeg++]
                ];
            ],
            {th1, -gridRange, gridRange, step},
            {th2, -gridRange, gridRange, step}
        ];
        Print["  ", betaLabels[[i]], ": ", nPixels, " image pixels (",
            nPos, " on the source side, ", nNeg, " opposite)"];
        AppendTo[rayCounts, {nPixels, nPos, nNeg}];
    ],
    {i, 1, 4}
];

(* Point-source image analysis on the symmetry axis (arcsec). *)
alphaA[t_?NumericQ] := 2 ks1 ts1arcsec/(t/ts1arcsec) (Log[t/ts1arcsec/2] + gNFW[t/ts1arcsec]);
(* d alpha/d theta = 2 kappa - kbar for a circular lens; finite difference kept as a cross-check *)
dalphaA[t_?NumericQ] := 2 kappaNFW[t/ts1arcsec, ks1] - kbarNFW[t/ts1arcsec, ks1];
dalphaFD[t_?NumericQ] := (alphaA[t + 10^-4] - alphaA[t - 10^-4])/(2 10^-4);
(* radial caustic = maximum of alpha(t) - t (robust; no derivative needed) *)
{betaRad, thetaRad} = Module[{sol = NMaximize[{alphaA[tq] - tq, 0.01 <= tq <= thetaE1}, tq]},
    {sol[[1]], tq /. sol[[2]]}];
imgPos[b_] := tq /. FindRoot[tq - alphaA[tq] == b, {tq, thetaE1 + b}];
(* for beta < beta_r: counter-image (|theta| > theta_r) and radial image (|theta| < theta_r) *)
imgCounter[b_] := tq /. FindRoot[alphaA[tq] - tq == b, {tq, (thetaRad + thetaE1)/2, thetaRad, thetaE1}];
imgRadial[b_] := tq /. FindRoot[alphaA[tq] - tq == b, {tq, thetaRad/4, 0.001, thetaRad}];
muT[t_] := 1/(1 - alphaA[t]/t); muR[t_] := 1/(1 - dalphaA[t]);
Print["  radial critical curve theta_r = ", thetaRad, "'', radial caustic beta_r = ",
    betaRad, "'' = ", betaRad/thetaE1, " thetaE"];
Do[With[{t = imgPos[f thetaE1]},
    Print["  beta = ", f, " thetaE: outer image theta = ", t, "'' = ", t/thetaE1,
      " thetaE; mu_t = ", muT[t], ", mu_r = ", muR[t], ", L/W ~ mu_t/mu_r = ", muT[t]/muR[t]]],
  {f, {0.05, 0.1, 0.12, 0.5, 0.95, 1.0}}];
With[{b = 0.1 thetaE1}, Print["  beta = 0.1 thetaE (inside the radial caustic): counter-image at -",
    imgCounter[b], "'' (mu = ", muT[imgCounter[b]] muR[imgCounter[b]], "), radial image at -",
    imgRadial[b], "'' (mu = ", muT[imgRadial[b]] muR[imgRadial[b]], ")"]];

Print["\nNote: for beta = 0.5 thetaE and beta = thetaE the source lies far outside"];
Print["    the radial caustic (beta_r ~ 1.0'' ~ 0.15 thetaE), so the circular NFW lens forms ONE image, at"];
Print["    ~2 and ~2.7 thetaE.  An earlier +-1.5 thetaE box missed these images"];
Print["    entirely (0 pixels); the cause was the box extent, not the resolution."];
Print["\n(d) For a circular lens the tangential caustic is the point beta = 0,"];
Print["    so arcs with L/W ~ 5-10 need beta ~ 0.05-0.12 thetaE (see the"];
Print["    point-source table above); beta = thetaE gives only L/W ~ 2.\n"];


(* =========================================================================
   Exercise 10.3: Magnification of a High-Redshift Galaxy

   SIS with thetaE = 30", zs = 9, zd = 0.3
   ========================================================================= *)

Print["--- Exercise 10.3: Magnification of High-z Galaxy ---\n"];

thetaESIS = 30.0;  (* arcsec *)

(* (a) SIS magnification: mu_tot = 2*thetaE/beta *)
Print["(a) SIS magnification (thetaE = 30 arcsec):"];
betaVals3 = {3.0, 1.0, 0.1};
Do[
    Module[{mu},
        mu = 2 thetaESIS / beta;
        Print["  beta = ", beta, " arcsec: mu = ", NumberForm[mu, {5, 1}]];
    ],
    {beta, betaVals3}
];
Print[""];

(* (b) Magnitude boost for mu = 600 *)
mu01 = 2 thetaESIS / 0.1;
deltam = -2.5 * Log10[mu01];
Print["(b) For beta = 0.1 arcsec:"];
Print["  mu = ", mu01];
Print["  Delta m = -2.5 * log10(", mu01, ") = ", NumberForm[deltam, {4, 1}], " mag\n"];

(* (c) Required magnification *)
Print["(c) Detection threshold:"];
Print["  Source: m = 31, Detection limit: m = 29"];
Print["  Need Delta m <= -2, i.e., mu >= 10^(2/2.5) = 10^0.8 = ", NumberForm[10^0.8, {4, 1}]];
muMin = 10^0.8;
betaMax = 2 * thetaESIS / muMin;
Print["  beta_max = 2*thetaE/mu_min = ", NumberForm[betaMax, {4, 1}], " arcsec\n"];

(* (d) Discussion *)
Print["(d) Cluster lensing enables detection of galaxies at z~9 that are"];
Print["    ~2 mag below the JWST limit. The magnification bias (steep faint-end"];
Print["    slope) means more sources are boosted above threshold than are lost"];
Print["    to area dilution.\n"];


(* =========================================================================
   Exercise 10.4: Einstein Radii Across Mass Scales

   SIS: thetaE = 4*Pi*(sigma_v/c)^2 * Dds/Ds
   ========================================================================= *)

Print["--- Exercise 10.4: Einstein Radii Across Mass Scales ---\n"];

thetaESISfunc[sigmaV_] := 4 Pi (sigmaV / cc)^2 * DdsOverDs * radToArcsec;

sigmas4 = {250*^3, 500*^3, 1200*^3};
labels4 = {"Galaxy (sigma=250 km/s)", "Group (sigma=500 km/s)", "Cluster (sigma=1200 km/s)"};
masses4 = {10^12, 10^13, 10^15};

Print["(a)-(c) SIS Einstein radii:"];
thetaEs4 = {};
Do[
    Module[{tE},
        tE = thetaESISfunc[sigmas4[[i]]];
        AppendTo[thetaEs4, tE];
        Print["  ", labels4[[i]], ": theta_E = ", NumberForm[tE, {5, 2}], " arcsec"];
    ],
    {i, 1, 3}
];
Print[""];

(* (d) Ratio *)
Print["(d) Ratio cluster/galaxy: ", NumberForm[thetaEs4[[3]] / thetaEs4[[1]], {4, 1}], "\n"];

(* (e) Enclosed mass *)
Print["(e) Enclosed mass within theta_E:"];
Do[
    Module[{tErad, Mencl},
        tErad = thetaEs4[[i]] / radToArcsec;
        Mencl = Pi * (DdVal * tErad)^2 * SigmaCr / Msolar;
        Print["  ", labels4[[i]], ": M(theta_E) = ", ScientificForm[Mencl, 3], " Msun"];
    ],
    {i, 1, 3}
];
Print[""];

(* (f) Discussion *)
Print["(f) Since thetaE ~ sigma_v^2, the angular scale grows quadratically."];
Print["    A cluster with sigma_v ~5x that of a galaxy has thetaE ~25x larger."];
Print["    This means cluster arcs subtend tens of arcseconds --- easily"];
Print["    resolved from the ground --- producing qualitatively different"];
Print["    observational signatures compared to galaxy-scale lensing.\n"];


(* =========================================================================
   Exercise 10.5: Weak Lensing Mass Estimate

   gamma_t(theta) = 0.1 * (theta/1')^{-0.8}
   Estimate mass within 1 Mpc (~5' at zd=0.3)
   ========================================================================= *)

Print["--- Exercise 10.5: Weak Lensing Mass Estimate ---\n"];

(* Sigma_cr for zd=0.3, zs=1 *)
(* Revised 2026-09-24: the problem used to give Sigma_cr = 3.5e15 and
   D_d = 900 Mpc; the concordance values for zd=0.3, zs=1 are computed here. *)
DdMpc = DAMpc[0.3];
SigmaCrWL = (cc^2/(4 Pi Gnewton)) DAMpc[1.0]/(DAMpc[0.3] DA12Mpc[0.3, 1.0] MpcToM)/Msolar MpcToM^2;  (* Msun/Mpc^2 *)
Print["Sigma_cr(zd=0.3, zs=1) = ", ScientificForm[SigmaCrWL, 3], " Msun/Mpc^2;  D_d = ", DdMpc, " Mpc"];

gammaT[thetaArcmin_] := 0.1 * (thetaArcmin)^(-0.8);

(* (a) Mean convergence *)
Print["(a) Approximating kbar ~ gamma_t at large radii:"];
thetaVals5 = {1.0, 3.0, 5.0};
Do[
    Module[{gam, kbar},
        gam = gammaT[theta];
        kbar = gam;  (* approximation *)
        Print["  theta = ", theta, "': gamma_t = ", NumberForm[gam, {4, 3}],
              ", kbar ~ ", NumberForm[kbar, {4, 3}]];
    ],
    {theta, thetaVals5}
];
Print[""];

(* (b) Convert to enclosed mass *)
Print["(b)-(c) Enclosed mass M(theta) = Pi*(Dd*theta)^2 * Sigma_cr * kbar(theta):"];
Do[
    Module[{kbar, thetaRad, Mencl},
        kbar = gammaT[theta];
        thetaRad = theta / 60 * Pi / 180;  (* convert arcmin to radians *)
        Mencl = Pi * (DdMpc * thetaRad)^2 * SigmaCrWL * kbar;  (* Msun *)
        Print["  theta = ", theta, "': M = ", ScientificForm[Mencl, 3], " Msun"];
    ],
    {theta, thetaVals5}
];
Print[""];

(* Specific result for theta = 5' *)
kbar5 = gammaT[5.0];
thetaRad5 = 5.0 / 60 * Pi / 180;
Mencl5 = Pi * (DdMpc * thetaRad5)^2 * SigmaCrWL * kbar5;
Print["Mass within 5' (~1.3 Mpc):"];
Print["  M(5') = ", ScientificForm[Mencl5, 3], " Msun\n"];

Print["(d) This is consistent with a typical cluster virial mass of"];
Print["    ~5x10^14 Msun. At theta=5' (~1.3 Mpc at zd=0.3), we are"];
Print["    probing near r200. Main systematic: the kbar ~ gamma_t"];
Print["    approximation breaks down at small radii where kappa is"];
Print["    not negligible.\n"];


(* =========================================================================
   Summary
   ========================================================================= *)

Print["=== All Module 10 solutions verified. ===\n"];


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity / number introduced in the derivation, annotation and
   bridge boxes of Notes/10_Cluster_Lensing/10_Solutions.tex (Annotated
   Study Edition only).  This script had no check[] of its own, so the
   shared harness is loaded here and summary[] closes the script. *)
Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Mathematica", "harness.wl"}]];
Print["\n--- Annotated-edition checks ---"];
near[a_, b_, tol_] := Abs[a - b] <= tol;

(* 10.1(a) rho_crit,0 and E^2(z=0.3) *)
rhoCrit0 = 3 H0^2/(8 Pi Gnewton);
check["10.1 rho_crit,0 = 3H0^2/(8 pi G) ~ 9.20e-27 kg/m^3", near[rhoCrit0, 9.20*^-27, 0.01*^-27]];
check["10.1 E^2(0.3) = 0.3*1.3^3 + 0.7 = 1.3591", near[Ez03^2, 1.3591, 0.0001]];
check["10.1 M200 = 5e14 Msun = 9.945e44 kg", near[p1["M200"], 9.945*^44, 0.001*^44]];
(* rho_s from equating the two expressions for M200 *)
ClearAll[rs0, rhs0, rc0, cc0];
mOfc[c_] := Log[1 + c] - c/(1 + c);
check["10.1 4 pi rho_s r_s^3 m(c) = (4pi/3) 200 rho_c (c r_s)^3  <=>  rho_s = (200/3) rho_c c^3/m(c)",
  Simplify[(4 Pi ((200/3) rc0 cc0^3/mOfc[cc0]) rs0^3 mOfc[cc0]) - (4 Pi/3) 200 rc0 (cc0 rs0)^3] === 0];
check["10.1 NFW enclosed 3D mass: int_0^{c r_s} 4 pi r^2 rho_s/[(r/r_s)(1+r/r_s)^2] dr = 4 pi rho_s r_s^3 m(c)",
  Simplify[Integrate[4 Pi r^2 rhs0/((r/rs0) (1 + r/rs0)^2), {r, 0, cc0 rs0},
      Assumptions -> {rs0 > 0, cc0 > 0}] - 4 Pi rhs0 rs0^3 mOfc[cc0],
    Assumptions -> {rs0 > 0, cc0 > 0}] === 0];
check["10.1 m(5) = ln 6 - 5/6 ~ 0.9584", near[mOfc[5.], 0.9584, 0.0001]];
check["10.1 r200 ~ 1.478 Mpc", near[p1["r200"]/MpcToM, 1.478, 0.001]];
check["10.1 theta_s = r_s/D_d ~ 3.218e-4 rad ~ 66.4 arcsec",
  near[p1["thetaS"], 3.218*^-4, 0.001*^-4] && near[p1["thetaS"] radToArcsec, 66.4, 0.05]];
check["10.1 Sigma_cr(0.3,2) ~ 4.91 kg/m^2 ~ 2.35e15 Msun/Mpc^2",
  near[SigmaCr, 4.91, 0.01] && near[SigmaCr/Msolar MpcToM^2, 2.35*^15, 0.01*^15]];
check["10.1 kappa_s = 2 rho_s r_s/Sigma_cr ~ 0.404", near[p1["kappaS"], 0.404, 0.001]];
(* rho_crit,0 pitfall: redo the cluster with rho_crit,0 instead of rho_crit(z) *)
nfwParams0[M200Msun_, c_] := Module[{M200, r200, rs, rhoS},
  M200 = M200Msun Msolar; r200 = (3 M200/(800 Pi rhoCrit0))^(1/3); rs = r200/c;
  rhoS = 200/3 rhoCrit0 c^3/(Log[1 + c] - c/(1 + c));
  <|"r200" -> r200, "thetaS" -> rs/DdVal, "kappaS" -> 2 rhoS rs/SigmaCr|>];
p0 = nfwParams0[5*^14, 5];
xt0 = x /. FindRoot[kbarNFW[x, p0["kappaS"]] == 1, {x, 0.1}];
thetaE0 = xt0 p0["thetaS"] radToArcsec;
Print["  [pitfall] with rho_crit,0: r200 = ", p0["r200"]/MpcToM, " Mpc, kappa_s = ",
  p0["kappaS"], ", theta_E = ", thetaE0, " arcsec"];
check["10.1 pitfall: rho_crit,0 gives r200 larger by E^(2/3) = 1.108 (1.637 Mpc)",
  near[p0["r200"]/p1["r200"], Ez03^(2/3), 10^-6] && near[p0["r200"]/MpcToM, 1.637, 0.001]];
check["10.1 pitfall: kappa_s scales as rho_crit^(2/3): 0.404 -> 0.329",
  near[p0["kappaS"]/p1["kappaS"], Ez03^(-4/3), 10^-6] && near[p0["kappaS"], 0.329, 0.0005]];
check["10.1 pitfall (fix 2026-10-14): printed 0.329, not 0.330, at 3 decimals",
  Round[p0["kappaS"], 0.001] == 0.329 && !near[p0["kappaS"], 0.330, 0.0005]];
check["10.1 pitfall: theta_E drops from 6.9'' to ~4.3'' (-38%)", near[thetaE0, 4.31, 0.01] && near[1 - thetaE0/thetaE1, 0.38, 0.005]];
(* 10.1(b) small-x expansion of the NFW mean convergence *)
gLo[x_] := ArcCosh[1/x]/Sqrt[1 - x^2];
serK = Normal[Series[Log[x/2] + gLo[x], {x, 0, 3}]];
check["10.1(b) ln(x/2) + g(x) = (x^2/2)[ln(2/x) - 1/2] + O(x^4 ln x)",
  Simplify[PowerExpand[serK - (x^2/2) (Log[2/x] - 1/2)], x > 0] === 0];
xtApprox = 2 Exp[-1/p1["kappaS"] - 1/2];
check["10.1(b) leading-order root x_t ~ 2 exp(-1/kappa_s - 1/2) ~ 0.102 (exact 0.104)",
  near[xtApprox, 0.102, 0.001] && near[xt1, 0.104, 0.0005]];
check["10.1(b) kbar(0.104) = 1 to 1%", near[kbarNFW[0.104, p1["kappaS"]], 1, 0.01]];
check["10.1(b) theta_E = x_t theta_s ~ 6.90''", near[thetaE1, 6.90, 0.01]];
(* 10.1(c) arithmetic *)
REm = DdVal thetaE1rad;
check["10.1(c) R_E = D_d theta_E ~ 30.7 kpc = 9.49e20 m",
  near[REm/kpcToM, 30.7, 0.1] && near[REm, 9.49*^20, 0.02*^20]];
check["10.1(c) pi R_E^2 ~ 2.83e42 m^2 and x Sigma_cr ~ 1.39e43 kg",
  near[Pi REm^2, 2.83*^42, 0.02*^42] && near[Pi REm^2 SigmaCr, 1.39*^43, 0.01*^43]];
check["10.1(c) M(theta_E) ~ 6.99e12 Msun", near[Mencl1, 6.99*^12, 0.01*^12]];
check["10.1(d) R_E/r200 ~ 0.021", near[REm/p1["r200"], 0.021, 0.0005]];
check["10.1(d) M(theta_E)/M200 ~ 0.014", near[fracM, 0.014, 0.0005]];

(* 10.3 SIS image magnifications *)
ClearAll[bb, tEs];
muSISp = (bb + tEs)/bb; muSISmAbs = (tEs - bb)/bb;
check["10.1 H0 = 70 km/s/Mpc = 2.268e-18 s^-1", near[H0, 2.268*^-18, 0.001*^-18]];
check["10.1 D_d, D_s, D_ds = 918.8, 1726.6, 1328.5 Mpc",
  near[DdVal/MpcToM, 918.8, 0.05] && near[DsVal/MpcToM, 1726.6, 0.05] && near[DdsVal/MpcToM, 1328.5, 0.05]];
check["10.1 r_s = r200/5 ~ 295.6 kpc", near[p1["rs"]/kpcToM, 295.6, 0.05]];
check["10.1(b) arccosh(1/x) = ln(2/x) - x^2/4 + O(x^4)",
  Simplify[PowerExpand[Normal[Series[ArcCosh[1/x], {x, 0, 3}]] - (Log[2/x] - x^2/4)], x > 0] === 0];
check["10.1(b) 1/kappa_s + 1/2 ~ 2.976", near[1/p1["kappaS"] + 1/2, 2.976, 0.001]];
ClearAll[bb2, tE2];
muSIS[th_] := 1/(1 - tE2/Abs[th]);
check["10.3 SIS mu(theta_pm) = theta_pm/beta (signed), theta_pm = beta +- thetaE",
  Simplify[{muSIS[bb2 + tE2] - (bb2 + tE2)/bb2, muSIS[bb2 - tE2] - (bb2 - tE2)/bb2},
    Assumptions -> {0 < bb2 < tE2}] === {0, 0}];
check["10.3 SIS |mu+| + |mu-| = 2 thetaE/beta", Simplify[muSISp + muSISmAbs - 2 tEs/bb] === 0];
check["10.3 SIS signed mu+ + mu- = 2 (parity pitfall)", Simplify[muSISp - muSISmAbs - 2] === 0];
check["10.3(b) log10(600) ~ 2.778 -> Delta m ~ -6.95", near[Log10[600.], 2.778, 0.001] && near[deltam, -6.95, 0.005]];
check["10.3(c) 10^0.8 ~ 6.31 and 60/6.31 ~ 9.51 < 30 (two-image regime)",
  near[muMin, 6.31, 0.005] && near[betaMax, 9.51, 0.005] && betaMax < thetaESIS];

(* 10.4 SIS Einstein radii and masses *)
check["10.4 D_ds/D_s ~ 0.769", near[DdsOverDs, 0.769, 0.0005]];
check["10.4 (250/2.998e5)^2 ~ 6.954e-7; x 4 pi ~ 8.739e-6; x 0.7694 ~ 6.724e-6 rad",
  near[(250/2.998*^5)^2, 6.954*^-7, 0.001*^-7] && near[4 Pi (250/2.998*^5)^2, 8.739*^-6, 0.001*^-6] &&
  near[4 Pi (250*^3/cc)^2 DdsOverDs, 6.723*^-6, 0.002*^-6]];
check["10.4 1 rad = 206265'' ; theta_E(galaxy) ~ 1.387''",
  near[N[radToArcsec], 206264.8, 0.1] && near[thetaEs4[[1]], 1.387, 0.001]];
ClearAll[sv, GG, cL, dd, ds, dds];
thSIS = 4 Pi sv^2/cL^2 dds/ds;
MthE = (cL^2/(4 GG)) (dd ds/dds) thSIS^2;
check["10.4(e) pi (D_d theta_E)^2 Sigma_cr = (c^2/4G)(D_d D_s/D_ds) theta_E^2",
  Simplify[Pi (dd thSIS)^2 (cL^2 ds/(4 Pi GG dd dds)) - MthE] === 0];
check["10.4(e) SIS: M(theta_E) = 4 pi^2 sigma^4 D_d D_ds/(G c^2 D_s)",
  Simplify[MthE - 4 Pi^2 sv^4 dd dds/(GG cL^2 ds)] === 0];
galMass = Pi (DdVal thetaEs4[[1]]/radToArcsec)^2 SigmaCr/Msolar;
check["10.4(e) galaxy: D_d theta_E ~ 6.18e-3 Mpc; pi(.)^2 ~ 1.20e-4 Mpc^2; M ~ 2.82e11 Msun",
  near[DdVal thetaEs4[[1]]/radToArcsec/MpcToM, 6.18*^-3, 0.01*^-3] &&
  near[Pi (DdVal thetaEs4[[1]]/radToArcsec/MpcToM)^2, 1.20*^-4, 0.01*^-4] && near[galMass, 2.82*^11, 0.01*^11]];
check["10.4(e) M ratio cluster/galaxy = (1200/250)^4 = 530.8 = 23.04^2",
  near[(1200/250.)^4, 530.8, 0.1] && near[(thetaEs4[[3]]/thetaEs4[[1]])^2, 530.8, 0.1]];

(* 10.5 weak-lensing mass *)
check["10.5 3^0.8 ~ 2.41, 5^0.8 ~ 3.62", near[3^0.8, 2.41, 0.005] && near[5^0.8, 3.62, 0.005]];
check["10.5 1' = 2.909e-4 rad, 5' = 1.454e-3 rad",
  near[Pi/(180 60.), 2.909*^-4, 0.001*^-4] && near[5 Pi/(180 60.), 1.454*^-3, 0.001*^-3]];
check["10.5 Sigma_cr(0.3,1) ~ 2.83e15 Msun/Mpc^2", near[SigmaCrWL, 2.83*^15, 0.01*^15]];
check["10.5(c) D_d theta = 1.336 Mpc ; pi(.)^2 = 5.61 Mpc^2 ; x Sigma_cr = 1.59e16 ; x 0.0276 = 4.39e14",
  near[DdMpc thetaRad5, 1.336, 0.001] && near[Pi (DdMpc thetaRad5)^2, 5.61, 0.01] &&
  near[Pi (DdMpc thetaRad5)^2 SigmaCrWL, 1.59*^16, 0.01*^16] && near[Mencl5, 4.39*^14, 0.01*^14]];
check["10.5 R = D_d * 5' ~ 1.34 Mpc vs r200 = 1.48 Mpc", near[DdMpc thetaRad5, 1.34, 0.01]];
(* pitfall: kbar ~ gamma_t.  Exact for a power law kbar = A theta^-n:
   kappa = (1/2 theta) d(theta^2 kbar)/d theta = (1 - n/2) kbar ;
   gamma_t = kbar - kappa = (n/2) kbar. *)
ClearAll[AA, nn, th];
kbarPL = AA th^-nn;
kapPL = Simplify[D[th^2 kbarPL, th]/(2 th)];
check["10.5 power law: kappa = (1 - n/2) kbar", Simplify[kapPL - (1 - nn/2) kbarPL] === 0];
check["10.5 power law: gamma_t = kbar - kappa = (n/2) kbar", Simplify[kbarPL - kapPL - (nn/2) kbarPL] === 0];
(* zeta-statistic form: kbar(theta) = 2 int_theta^Inf gamma_t dtheta'/theta' for gamma_t = B theta^-n *)
check["10.5 kbar(theta) = 2 int_theta^Inf gamma_t dtheta'/theta' = (2/n) gamma_t for gamma_t ~ theta^-n",
  Simplify[2 Integrate[BB tp^-nn/tp, {tp, th, Infinity}, Assumptions -> {nn > 0, th > 0}] - (2/nn) BB th^-nn,
    Assumptions -> {nn > 0, th > 0}] === 0];
check["10.5 n = 0.8: kbar = 2.5 gamma_t, kappa/kbar = 0.6 at every radius",
  (2/0.8 == 2.5) && near[1 - 0.8/2, 0.6, 10^-12]];
check["10.5 pitfall: power-law-consistent M(5') = 2.5 x 4.39e14 ~ 1.10e15 Msun",
  near[2.5 Mencl5, 1.10*^15, 0.01*^15]];

(* bridge: source-redshift dependence of Sigma_cr behind one cluster *)
check["10 bridge: Sigma_cr(z_s=1)/Sigma_cr(z_s=2) ~ 1.21 for z_d = 0.3",
  near[SigmaCrWL/(SigmaCr/Msolar MpcToM^2), 1.21, 0.005]];

(* ===== Fix pass 2026-10-14 (fact-critic 10-14: VF2, VF3, VF4) ===== *)
(* VF2, 10.1(d): rho ~ 1/r cusp gives M_3D ~ r^2 and M_2D ~ R^2 ln(2 r_s/R), not M ~ r. *)
ClearAll[rr, xx, rsV, rhoV];
m3D = Integrate[4 Pi r^2 rhoV/((r/rsV) (1 + r/rsV)^2), {r, 0, rr}, Assumptions -> {rr > 0, rsV > 0}];
check["10.1(d) NFW M_3D(<r) = 2 pi rho_s r_s r^2 + O(r^3)  (so M_3D ~ r^2, not r)",
  Simplify[Normal[Series[m3D, {rr, 0, 2}]] - 2 Pi rhoV rsV rr^2] === 0 &&
  Simplify[Normal[Series[m3D, {rr, 0, 1}]]] === 0];
(* projected: M_2D(<R) = pi R^2 Sigma_cr kbar = 2 pi kappa_s Sigma_cr r_s^2 [ln(x/2) + g(x)] *)
check["10.1(d) NFW M_2D(<R) ~ x^2 [ln(2/x) - 1/2] at small x (so ~ R^2 ln(2 r_s/R), not R)",
  Simplify[PowerExpand[Normal[Series[Log[xx/2] + ArcCosh[1/xx]/Sqrt[1 - xx^2], {xx, 0, 2}]] -
     (xx^2/2) (Log[2/xx] - 1/2)], xx > 0] === 0 &&
  Limit[(Log[xx/2] + ArcCosh[1/xx]/Sqrt[1 - xx^2])/xx, xx -> 0, Direction -> "FromAbove"] === 0];
(* VF3, 10.5(d): 4.39e14 / 5e14 -> 12% low, not 10% *)
check["10.5(d) M(5')/5e14 = 0.877: within ~12% (not ~10%)",
  near[1 - Mencl5/5*^14, 0.12, 0.005] && !near[1 - Mencl5/5*^14, 0.10, 0.005]];
check["10.5(d) self-consistent M(5') = 2.5 x 4.39e14 ~ 2.2 x 5e14",
  near[2.5 Mencl5/5*^14, 2.2, 0.05]];
(* VF4, 10.2: extent, single image, caustic geometry, L/W *)
check["10.2 d alpha/d theta = 2 kappa - kbar agrees with a finite difference (theta = 1, 8.5, 18.5'')",
  And @@ (near[dalphaA[#], dalphaFD[#], 10^-5] & /@ {1., 8.5, 18.5})];
check["10.2 radial caustic beta_r ~ 1.01'' ~ 0.146 thetaE, radial critical curve theta_r ~ 2.52''",
  near[betaRad, 1.01, 0.005] && near[betaRad/thetaE1, 0.146, 0.002] && near[thetaRad, 2.52, 0.01] &&
  near[1 - dalphaA[thetaRad], 0, 10^-3]];
check["10.2 beta = 0.1 thetaE lies INSIDE the radial caustic: tangential arc + counter-image + radial image",
  0.1 thetaE1 < betaRad && imgCounter[0.1 thetaE1] > thetaRad && imgRadial[0.1 thetaE1] < thetaRad &&
  rayCounts[[3, 3]] > 0];
check["10.2(d) beta = 0.1 thetaE: arc at ~8.5'' (1.23 thetaE), mu_t ~ 12, mu_r ~ 2.1, L/W ~ 6",
  near[imgPos[0.1 thetaE1], 8.5, 0.05] && near[muT[imgPos[0.1 thetaE1]], 12.3, 0.1] &&
  near[muR[imgPos[0.1 thetaE1]], 2.14, 0.02] && near[muT[imgPos[0.1 thetaE1]]/muR[imgPos[0.1 thetaE1]], 5.8, 0.1]];
check["10.2 tangential critical curve maps to the POINT beta = 0 (not beta = thetaE)",
  near[thetaE1 - alphaA[thetaE1], 0, 10^-3]];
check["10.2 beta = 0.5 thetaE: one image at ~13.5'' (~1.95 thetaE), outside the old +-1.5 thetaE box",
  near[imgPos[0.5 thetaE1], 13.5, 0.05] && imgPos[0.5 thetaE1] > 1.5 thetaE1 && 0.5 thetaE1 > betaRad];
check["10.2 beta = 0.95 thetaE: image at ~18.1''; beta = thetaE: image at ~18.5'' (~2.7 thetaE)",
  near[imgPos[0.95 thetaE1], 18.1, 0.05] && near[imgPos[thetaE1], 18.5, 0.1] && near[imgPos[thetaE1]/thetaE1, 2.7, 0.05]];
check["10.2 no counter-image for beta > beta_r: alpha(t) - t < 0.5 thetaE for all t",
  NMaxValue[{alphaA[tq] - tq, 0.01 <= tq <= 3 thetaE1}, tq] < 0.5 thetaE1];
check["10.2(d) beta = thetaE: mu_t ~ 2.7, mu_r ~ 1.4, L/W ~ 2 (not 5-10)",
  near[muT[imgPos[thetaE1]], 2.7, 0.05] && near[muR[imgPos[thetaE1]], 1.4, 0.05] &&
  near[muT[imgPos[thetaE1]]/muR[imgPos[thetaE1]], 1.95, 0.1]];
check["10.2(d) L/W = 5 at beta ~ 0.12 thetaE, L/W = 10 at beta ~ 0.05 thetaE",
  near[muT[imgPos[0.12 thetaE1]]/muR[imgPos[0.12 thetaE1]], 5, 0.5] &&
  near[muT[imgPos[0.05 thetaE1]]/muR[imgPos[0.05 thetaE1]], 10, 1]];
check["10.2 ray trace with the +-3 thetaE box: every source position now has image pixels",
  And @@ (#[[1]] > 0 & /@ rayCounts)];
check["10.2 beta = 0.5 thetaE and thetaE: all image pixels on the source side (no counter-image)",
  rayCounts[[2, 3]] == 0 && rayCounts[[4, 3]] == 0];

summary[];
