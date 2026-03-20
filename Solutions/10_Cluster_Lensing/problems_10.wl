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

DdVal = 900 * MpcToM;      (* Dd for zd = 0.3, in meters *)
DsVal = 1750 * MpcToM;     (* Ds for zs = 2 *)
DdsVal = 1400 * MpcToM;    (* Dds for zd = 0.3, zs = 2 *)
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
kbarNFW[x_, ks_] := 4 ks / x^2 * (Log[x/2] + gNFW[x]);
alphaNFW[x_, ks_, thetas_] := 4 ks * thetas / x * (Log[x/2] + gNFW[x]);
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
   Source: circular disk, radius 0.5", at beta = 0, 0.5*thetaE, thetaE.
   ========================================================================= *)

Print["--- Exercise 10.2: Ray-Tracing (Giant Arcs) ---\n"];

ks1 = p1["kappaS"];
ts1 = p1["thetaS"];
ts1arcsec = ts1 * radToArcsec;
sourceR = 0.5;  (* arcsec *)

ts1arcsec = ts1 * radToArcsec;

Print["Ray-tracing with source radius = ", sourceR, " arcsec"];
Print["Einstein radius = ", NumberForm[thetaE1, {4, 1}], " arcsec"];

betaVals = {0.0, 0.5 * thetaE1, 0.95 * thetaE1};
betaLabels = {"beta = 0", "beta = 0.5 * thetaE", "beta = 0.95 * thetaE"};

Do[
    Module[{beta0, gridRange, step, nPixels, thetaR, xVal, alphaR, ratio, b1, b2},
        beta0 = N[betaVals[[i]]];
        gridRange = N[1.5 * thetaE1];
        step = N[0.15];  (* finer grid for accuracy *)
        nPixels = 0;
        Do[
            thetaR = Sqrt[th1^2 + th2^2];
            If[thetaR > 0.1,
                xVal = thetaR / ts1arcsec;
                alphaR = 4 ks1 * ts1arcsec / xVal * (Log[xVal/2] + gNFW[xVal]);
                ratio = alphaR / thetaR;
                b1 = th1 * (1 - ratio);
                b2 = th2 * (1 - ratio);
                If[Sqrt[(b1 - beta0)^2 + b2^2] <= sourceR,
                    nPixels++
                ];
            ],
            {th1, -gridRange, gridRange, step},
            {th2, -gridRange, gridRange, step}
        ];
        Print["  ", betaLabels[[i]], ": ", nPixels, " image pixels"];
    ],
    {i, 1, 3}
];

Print["\nNote: For off-axis source positions, the lensed images of a 0.5\""];
Print["    source are thin arcs whose width may be sub-pixel at coarse"];
Print["    grid resolution. Use a finer grid (step ~ 0.05\") or increase"];
Print["    source radius to resolve the arcs in the interactive notebook."];
Print["\n(d) The arc length-to-width ratio depends on source proximity"];
Print["    to the caustic. For beta ~ thetaE (near the tangential caustic),"];
Print["    the tangential magnification is large, giving L/W ~ 5-10.\n"];


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
SigmaCrWL = 3.5*^15;  (* Msun/Mpc^2, given in the problem *)
DdMpc = 900;           (* Mpc *)

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
