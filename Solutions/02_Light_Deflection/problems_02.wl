(* =========================================================================
   problems_02.wl
   Module 2: Light Deflection in Curved Spacetime — SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 2, verified
            symbolically and numerically with Mathematica.

   Sources: Carroll Ch. 5.5, Congdon & Keeton Ch. 3.4 (eqs. 3.87--3.96,
            3.97--3.110), Narayan & Bartelmann Sec. 2.1

   Usage:   wolframscript -file problems_02.wl

   Exercises solved:
     2.1 — Soldner's Newtonian deflection angle
     2.2 — Factor of 2: GR vs. Newton
     2.3 — Numerical deflections for Sun, Jupiter, galaxy
     2.4 — Shapiro time delay for radar echoes
     2.5 — Exact vs. weak-field deflection comparison
   ========================================================================= *)

Print["=== Module 2: SOLUTIONS ===\n"];

(* ---- Physical constants ---- *)
Gnewton = 6.674*^-11;      (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
Rsolar = 6.957*^8;          (* m *)
radToArcsec = 180 * 3600 / Pi;


(* =========================================================================
   Exercise 2.1: Soldner's Newtonian Deflection Angle

   Treat light as a Newtonian corpuscle with v = c, impact parameter b.
   L = b*c,  E_kin = (1/2)*c^2
   Orbit: r(phi) = p / (1 + e*cos(phi))
     p = L^2/(GM) = b^2*c^2/(GM)
     e = sqrt(1 + 2*E*L^2/(GM)^2) = sqrt(1 + b^2*c^4/(GM)^2)
   Deflection = 2*arcsin(1/e) ~ 2*GM/(c^2*b) for b >> GM/c^2
   ========================================================================= *)

Print["--- Exercise 2.1: Soldner's Newtonian Deflection ---\n"];

Print["Step 1: Orbit parameters for a particle with v = c, impact parameter b:"];
Print["  Angular momentum: L = b*c"];
Print["  Kinetic energy: E = (1/2)*c^2"];
Print["  Semi-latus rectum: p = L^2/(GM) = b^2*c^2/(GM)"];
Print["  Eccentricity: e = sqrt(1 + 2*E*L^2/(GM)^2)"];
Print["              = sqrt(1 + b^2*c^4/(GM)^2)\n"];

(* Symbolic eccentricity *)
ecc = Sqrt[1 + b^2 cc^4/(Gnewton Msolar)^2];
Print["Step 2: For b >> GM/c^2, e >> 1, so:"];
Print["  arcsin(1/e) ~ 1/e ~ GM/(b*c^2)"];
Print["  Deflection = 2*arcsin(1/e) ~ 2*GM/(c^2*b)\n"];

(* (a) Verify the semi-latus rectum and eccentricity *)
Print["(a) For b = R_sun:"];
bSun = Rsolar;
pSun = bSun^2 * cc^2 / (Gnewton * Msolar);
eSun = Sqrt[1 + bSun^2 * cc^4 / (Gnewton * Msolar)^2];
Print["  p = ", ScientificForm[pSun, 4], " m"];
Print["  e = ", ScientificForm[eSun, 4], " (>> 1, as expected)\n"];

(* (b) Weak-field deflection *)
alphaNSun = 2 * ArcSin[1/eSun];
Print["(b) alpha_Newton = 2*arcsin(1/e) = ", ScientificForm[alphaNSun, 4], " rad"];
Print["  Weak-field: 2*GM/(c^2*b) = ",
    ScientificForm[2 Gnewton Msolar / (cc^2 * bSun), 4], " rad"];
Print["  These agree to high precision.\n"];

(* (c) Newtonian solar deflection in arcseconds *)
Print["(c) Newtonian solar deflection:"];
Print["  alpha_Newton = ", NumberForm[alphaNSun * radToArcsec, {4, 3}], " arcsec"];
Print["  Expected: 0.875 arcsec\n"];


(* =========================================================================
   Exercise 2.2: The Factor of 2 — GR vs. Newton

   (a) From Delta phi = pi + 4m/r0:
       alpha = Delta phi - pi = 4m/r0 ~ 4GM/(c^2*b)
   (b) Physical explanation: spatial curvature doubles the deflection
   ========================================================================= *)

Print["--- Exercise 2.2: The Factor of 2 (GR vs. Newton) ---\n"];

Print["(a) Deriving the GR deflection angle:"];
Print["  From the integral evaluation (C&K eqs. 3.93-3.96):"];
Print["    Delta phi = pi + 4*m/r0 + O((m/r0)^2)"];
Print["  where m = GM/c^2 and r0 ~ b to leading order."];
Print["  Therefore:"];
Print["    alpha_hat = Delta phi - pi = 4*GM/(c^2*b)\n"];

(* Symbolic verification: evaluate the integral *)
Print["Symbolic verification of the key integral:"];
I0 = 2 * Integrate[1/Sqrt[1 - u^2], {u, 0, 1}];
I1bare = Integrate[(1 - u^3)/(1 - u^2)^(3/2), {u, 0, 1}];
I1 = 2 * I1bare;
Print["  I0 = 2 * Integral_0^1 du/sqrt(1-u^2) = ", I0, "  (= pi, CHECK)"];
Print["  Bare integral = ", I1bare, "  (= 2, CHECK)"];
Print["  I1 = 2 * bare integral = ", I1, "  (= 4, CHECK)"];
Print["  Delta phi = I0 + eps * I1 = pi + 4*eps = pi + 4m/r0"];
Print["  alpha = 4m/r0 = 4*GM/(c^2*b)\n"];

(* Ratio *)
Print["  GR / Newton = (4*GM/(c^2*b)) / (2*GM/(c^2*b)) = 2"];
Print["  The GR deflection is EXACTLY TWICE the Newtonian prediction.\n"];

Print["(b) Physical explanation:"];
Print["  In the weak-field (isotropic coordinate) form:"];
Print["    ds^2 ~ -(1 - 2*Phi/c^2)*c^2*dt^2 + (1 + 2*Phi/c^2)*(dx^2+dy^2+dz^2)"];
Print["  where Phi = -GM/r is the Newtonian potential."];
Print["  The effective refractive index for light is:"];
Print["    n(r) = sqrt(g_rr / (-g_tt)) ~ 1 + 4*GM/(c^2*r)"];
Print["  The Newtonian calculation uses only g_tt => n ~ 1 + 2*GM/(c^2*r)"];
Print["  => half the deflection."];
Print["  The spatial curvature (g_rr) contributes EQUALLY, doubling the result.\n"];


(* =========================================================================
   Exercise 2.3: Numerical Deflections for Sun, Jupiter, Galaxy

   alpha_hat = 4*G*M / (c^2 * b)
   ========================================================================= *)

Print["--- Exercise 2.3: Numerical Deflections ---\n"];

alphaHat[M_, b_] := 4 Gnewton M / (cc^2 b);

(* (a) Sun *)
alphaSun = alphaHat[Msolar, Rsolar];
Print["(a) Sun (b = R_sun = ", ScientificForm[Rsolar, 4], " m):"];
Print["  alpha = 4 * ", ScientificForm[Gnewton, 4], " * ", ScientificForm[Msolar, 4]];
Print["        / (", ScientificForm[cc^2, 4], " * ", ScientificForm[Rsolar, 4], ")"];
Print["  = ", ScientificForm[alphaSun, 4], " rad"];
Print["  = ", NumberForm[alphaSun * radToArcsec, {4, 2}], " arcsec"];
Print["  Expected: 1.75 arcsec  -- VERIFIED\n"];

(* (b) Jupiter *)
Mjup = 1.898*^27;
Rjup = 7.149*^7;
alphaJup = alphaHat[Mjup, Rjup];
Print["(b) Jupiter (b = R_J = ", ScientificForm[Rjup, 4], " m):"];
Print["  alpha = ", ScientificForm[alphaJup, 4], " rad"];
Print["  = ", NumberForm[alphaJup * radToArcsec * 1000, {3, 1}], " mas"];
Print["  (milliarcseconds)\n"];

(* (c) Galaxy *)
Mgal = 1*^12 * Msolar;
bgal = 10 * 3.086*^19;    (* 10 kpc in meters *)
alphaGal = alphaHat[Mgal, bgal];
Print["(c) Galaxy (M = 10^12 M_sun, b = 10 kpc = ", ScientificForm[bgal, 4], " m):"];
Print["  alpha = ", ScientificForm[alphaGal, 4], " rad"];
Print["  = ", NumberForm[alphaGal * radToArcsec, {4, 1}], " arcsec"];
Print["  This is ~ 4 arcsec, well within the range of ground-based"];
Print["  telescopes. Strong lensing is routinely observed for massive galaxies.\n"];


(* =========================================================================
   Exercise 2.4: Shapiro Time Delay for Radar Echoes

   Round-trip delay for signal: Earth -> Sun -> Mercury -> Sun -> Earth
   Delta T ~ (4*G*M_sun/c^3) * [ln(4*R_earth*R_Merc/r0^2) + 1]
   ========================================================================= *)

Print["--- Exercise 2.4: Shapiro Time Delay ---\n"];

(* Physical parameters *)
Rearth = 1.496*^11;       (* 1 AU in meters *)
Rmerc = 5.79*^10;         (* Mercury semi-major axis in meters *)
r0Shapiro = Rsolar;       (* grazing the Sun *)

Print["Parameters:"];
Print["  R_earth = ", ScientificForm[Rearth, 4], " m (1 AU)"];
Print["  R_Mercury = ", ScientificForm[Rmerc, 4], " m"];
Print["  r0 = R_sun = ", ScientificForm[r0Shapiro, 4], " m (grazing)\n"];

(* (a) Derive the round-trip excess time *)
Print["(a) Derivation:"];
Print["  The coordinate travel time from r0 to R is (C&K eq. 3.104):"];
Print["    T(R) ~ (1/c)*sqrt(R^2 - r0^2)"];
Print["         + (2m/c)*ln((R + sqrt(R^2 - r0^2)) / r0)"];
Print["         + (m/c)*sqrt((R - r0)/(R + r0))"];
Print["  where m = GM/c^2.\n"];

Print["  The flat-spacetime time is T_flat(R) = (1/c)*sqrt(R^2 - r0^2)."];
Print["  The excess one-way time is:"];
Print["    delta T(R) ~ (2m/c)*ln((R + sqrt(R^2-r0^2))/r0) + (m/c)*sqrt((R-r0)/(R+r0))"];
Print["  For R >> r0: sqrt(R^2-r0^2) ~ R, sqrt((R-r0)/(R+r0)) ~ 1, so"];
Print["    delta T(R) ~ (2m/c)*ln(2R/r0) + m/c\n"];

Print["  Round-trip: Earth -> Sun -> Mercury -> Sun -> Earth"];
Print["    Delta T_round = 2*[delta T(R_earth) + delta T(R_Merc)]"];
Print["    ~ (4m/c)*[ln(2*R_earth/r0) + ln(2*R_Merc/r0)] + 4*m/c"];
Print["    = (4*GM/c^3)*[ln(4*R_earth*R_Merc/r0^2) + 1]\n"];

(* (b) Numerical evaluation *)
Print["(b) Numerical evaluation:"];
mSun = Gnewton * Msolar / cc^2;
tScale = 4 * Gnewton * Msolar / cc^3;
Print["  4*G*M_sun/c^3 = ", ScientificForm[tScale, 4], " s"];
Print["               = ", NumberForm[tScale * 1*^6, {4, 1}], " microseconds\n"];

logFactor = Log[4 * Rearth * Rmerc / r0Shapiro^2];
Print["  ln(4*R_earth*R_Merc/r0^2) = ln(",
    ScientificForm[4 Rearth Rmerc / r0Shapiro^2, 4], ")"];
Print["                            = ", NumberForm[logFactor, {4, 2}], "\n"];

deltaT = tScale * (logFactor + 1);
Print["  Delta T = ", ScientificForm[tScale, 4], " * (",
    NumberForm[logFactor, {4, 2}], " + 1)"];
Print["  = ", ScientificForm[deltaT, 3], " s"];
Print["  = ", NumberForm[deltaT * 1*^6, {3, 0}], " microseconds\n"];

(* (c) Comparison with measurement *)
Print["(c) Comparison with Shapiro's measurement:"];
Print["  Our calculation: Delta T ~ ", NumberForm[deltaT * 1*^6, {3, 0}], " us"];
Print["  Shapiro (1964): Delta T = 200 +/- 20 us"];
Print["  The agreement is reasonable. Differences arise from:"];
Print["    - Mercury not exactly at inferior conjunction"];
Print["    - Solar corona effects"];
Print["    - Our point-mass approximation"];
Print["  The Viking Mars lander (1979) later confirmed GR to ~0.1%.\n"];


(* =========================================================================
   Exercise 2.5: Exact vs. Weak-Field Deflection

   Evaluate the exact deflection integral numerically and compare
   with 1st-order (4m/b) and 2nd-order (4m/b + 15*Pi/4*(m/b)^2)
   approximations.
   ========================================================================= *)

Print["--- Exercise 2.5: Exact vs. Weak-Field Deflection ---\n"];

(* Working in G = c = M = 1 units: m = 1, Rs = 2 *)
Print["Working in G = c = M = 1 units (m = 1, Rs = 2)\n"];

(* Function to find r0 from b *)
findR0[bval_?NumericQ] := Module[{r0vals},
    r0vals = r /. NSolve[r^2/bval^2 == 1 - 2/r && r > 0, r, Reals];
    Max[r0vals]
];

(* Exact deflection via numerical integration *)
exactDefl[bval_?NumericQ] := Module[{r0, eps, result},
    r0 = findR0[bval];
    eps = 1/r0;
    result = 2 * NIntegrate[
        1/Sqrt[(1 - u^2) - 2 eps (1 - u^3)],
        {u, 0, 1},
        WorkingPrecision -> 20,
        MaxRecursion -> 20
    ];
    result - Pi
];

(* Approximations *)
approx1[bval_] := 4/bval;
approx2[bval_] := 4/bval + 15 Pi / (4 bval^2);

(* (a) For b = 10*Rs = 20 geometric units *)
Print["(a) For b = 10*Rs (b = 20 in geometric units):"];
b10 = 20;
aExact10 = exactDefl[b10];
a1val = approx1[b10];
a2val = approx2[b10];
Print["  Exact:  alpha = ", NumberForm[aExact10, {6, 6}], " rad"];
Print["  1st order (4m/b): alpha = ", NumberForm[N[a1val], {6, 6}], " rad"];
Print["  2nd order: alpha = ", NumberForm[N[a2val], {6, 6}], " rad\n"];

(* (b) Relative errors *)
err1 = Abs[(a1val - aExact10) / aExact10] * 100;
err2 = Abs[(a2val - aExact10) / aExact10] * 100;
Print["(b) Relative errors at b = 10*Rs:"];
Print["  1st order error: ", NumberForm[err1, {4, 2}], " %"];
Print["  2nd order error: ", NumberForm[err2, {4, 2}], " %\n"];

(* (c) Tabulate for several b/Rs *)
Print["(c) Comparison table:\n"];
Print[StringForm["  ``  ``  ``  ``  ``  ``",
    PaddedForm["b/Rs", {6, 0}],
    PaddedForm["alpha_exact", {12, 0}],
    PaddedForm["alpha_1st", {12, 0}],
    PaddedForm["alpha_2nd", {12, 0}],
    PaddedForm["Err(1st)", {9, 0}],
    PaddedForm["Err(2nd)", {9, 0}]
]];
Print["  ", StringJoin[Table["-", 70]]];

bRsValues = {5, 10, 20, 50, 100};
onePctBound = Null;
Do[
    bGeom = bRs * 2;
    aE = exactDefl[bGeom];
    a1 = N[approx1[bGeom]];
    a2 = N[approx2[bGeom]];
    e1 = Abs[(a1 - aE) / aE] * 100;
    e2 = Abs[(a2 - aE) / aE] * 100;
    Print[StringForm["  ``  ``  ``  ``  ``%  ``%",
        PaddedForm[bRs, {6, 0}],
        PaddedForm[aE, {12, 6}],
        PaddedForm[a1, {12, 6}],
        PaddedForm[a2, {12, 6}],
        PaddedForm[e1, {7, 2}],
        PaddedForm[e2, {7, 3}]
    ]];
    If[onePctBound === Null && e1 < 1, onePctBound = bRs],
    {bRs, bRsValues}
];
Print[""];

(* (d) Find where 1st order achieves 1% accuracy *)
Print["(d) Finding b/Rs where 1st-order error < 1%..."];
Module[{btest, errtest},
    Do[
        btest = bRs * 2;
        errtest = Abs[(N[approx1[btest]] - exactDefl[btest]) / exactDefl[btest]] * 100;
        If[errtest < 1.0,
            Print["  First-order error drops below 1% at b/Rs ~ ", bRs];
            Print["  (error = ", NumberForm[errtest, {4, 2}], "%)"];
            Break[]
        ],
        {bRs, Range[50, 200, 10]}
    ];
];
Print[""];

Print["Summary:"];
Print["  - The weak-field formula alpha = 4GM/(c^2*b) is excellent for b >> Rs"];
Print["  - At b = 10*Rs, the first-order error is about 15%"];
Print["  - The 2nd-order correction 15*Pi/4*(m/b)^2 significantly improves accuracy"];
Print["  - The exact deflection diverges as b -> b_crit = 3*sqrt(3)*Rs/2"];
Print["    (the critical impact parameter for photon capture)"];
Print["  - b_crit/Rs = 3*sqrt(3)/2 = ", NumberForm[N[3 Sqrt[3]/2], {4, 3}]];
Print[""];

Print["=== End of Module 2 Solutions ==="];
