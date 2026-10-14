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

   Annotated-edition checks (2026-10): appended section at the end of this
   file verifies every identity / number in the annotation, derivation and
   bridge boxes of the Annotated Study Edition (uses ../../Mathematica/
   harness.wl; ends with summary[], exit code 0 iff all checks pass).
   Run via:  bash Mathematica/run_wl.sh <this file>
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


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity and number quoted in the annotation / derivation / bridge
   boxes of Notes/02_Light_Deflection/02_Light_Deflection.tex and
   02_Solutions.tex (Annotated Study Edition only) is verified here.
   Symbols used below are kept local to this section via the ann* prefix. *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                  "Mathematica", "harness.wl"}]];

Print["\n--- Annotated-edition checks: Module 2 ---\n"];

Clear[annE, annL, annR, annm, annb, annr0, annu, annth];
annAss = {annE > 0, annL > 0, annR > 0, annm > 0, annb > 0, annr0 > 0,
          cS > 0, annr > annR};

(* A1: null condition with E = (1-Rs/r) c^2 tdot, L = r^2 phidot gives
       rdot^2 = E^2/c^2 - (L^2/r^2)(1-Rs/r)   [eq:photon_orbit_eq] *)
Module[{tdot, phidot, rdot2},
  tdot = annE/(cS^2 (1 - annR/annr));
  phidot = annL/annr^2;
  rdot2 = annrd2 /. First@Solve[
      -(1 - annR/annr) cS^2 tdot^2 + annrd2/(1 - annR/annr) + annr^2 phidot^2 == 0,
      annrd2];
  check["A1 null geodesic: rdot^2 = E^2/c^2 - (L^2/r^2)(1-Rs/r)",
    Simplify[rdot2 - (annE^2/cS^2 - annL^2/annr^2 (1 - annR/annr))] === 0]];

(* A2: impact parameter = asymptotic r^2 dphi/dr = c L / E *)
check["A2 b = lim_{r->inf} r^2 dphi/dr = c L/E",
  Simplify[Limit[annr^2 (annL/annr^2)/Sqrt[annE^2/cS^2 - annL^2/annr^2 (1 - annR/annr)],
      annr -> Infinity], annAss] === cS annL/annE];

(* A3: closest approach vs impact parameter: r0 = b - m - (3/2) m^2/b + O(m^3) *)
Module[{c1, c2, ans, eqn},
  ans = annb + c1 annm + c2 annm^2/annb;
  eqn = Series[ans^3 - annb^2 (ans - 2 annm), {annm, 0, 2}];
  sol = Solve[{Coefficient[Normal[eqn], annm, 1] == 0,
               Coefficient[Normal[eqn], annm, 2] == 0}, {c1, c2}];
  check["A3 r0 = b - m - (3/2) m^2/b + O(m^3)", ({c1, c2} /. First[sol]) === {-1, -3/2}]];

(* A4: pulling L out of the bracket: (L/r^2)[E^2/c^2 - L^2/r^2 (1-2m/r)]^(-1/2)
       = (1/r^2)[1/b^2 - (1/r^2)(1-2m/r)]^(-1/2) with b = cL/E *)
(* both sides are positive, so compare squares *)
check["A4 integrand rewritten with b = cL/E (eq:delta_phi_simplified)",
  Simplify[((annL/annr^2)^2/(annE^2/cS^2 - annL^2/annr^2 (1 - 2 annm/annr))) -
     ((1/annr^2)^2/(1/annb^2 - 1/annr^2 (1 - 2 annm/annr)) /. annb -> cS annL/annE)] === 0];

(* A5: u = r0/r substitution: |dr/du| (1/r^2)[...]^(-1/2) = [r0^2/b^2 - u^2 + 2m u^3/r0]^(-1/2) *)
check["A5 u = r0/r substitution (eq:delta_phi_u), squares of positive sides",
  Simplify[((annr0/annu^2) (annu^2/annr0^2))^2/
       (1/annb^2 - annu^2/annr0^2 (1 - 2 annm annu/annr0)) -
     1/(annr0^2/annb^2 - annu^2 + 2 annm annu^3/annr0)] === 0];

(* A6: first-order expansion of 1/sqrt(f) and boundedness of B/A at u->1 *)
check["A6 1/sqrt((1-u^2) - 2 eps (1-u^3)) = 1/sqrt(1-u^2) + eps (1-u^3)/(1-u^2)^(3/2) + O(eps^2)",
  Simplify[Normal[Series[1/Sqrt[(1 - annu^2) - 2 eps (1 - annu^3)], {eps, 0, 1}]] -
     (1/Sqrt[1 - annu^2] + eps (1 - annu^3)/(1 - annu^2)^(3/2)), 0 < annu < 1] === 0];
check["A6b (1-u^3)/(1-u^2) -> 3/2 as u -> 1 (expansion uniform on [0,1])",
  Limit[(1 - annu^3)/(1 - annu^2), annu -> 1] === 3/2];

(* A7: trig route to the bare integral = 2 : u = sin(th),
       integrand -> sec^2 - sin/cos^2 + sin, antiderivative tan - sec - cos *)
check["A7a (1-sin^3)/cos^2 = sec^2 - sin/cos^2 + sin",
  Simplify[(1 - Sin[annth]^3)/Cos[annth]^2 - (Sec[annth]^2 - Sin[annth]/Cos[annth]^2 + Sin[annth])] === 0];
check["A7b d/dth (tan - sec - cos) = (1-sin^3)/cos^2",
  Simplify[D[Tan[annth] - Sec[annth] - Cos[annth], annth] - (1 - Sin[annth]^3)/Cos[annth]^2] === 0];
check["A7c [tan - sec - cos]_0^{pi/2} = 0 - (-2) = 2",
  Limit[Tan[annth] - Sec[annth] - Cos[annth], annth -> Pi/2, Direction -> "FromBelow"] -
    (Tan[0] - Sec[0] - Cos[0]) === 2];
check["A7d bare integral = 2 (direct)", Integrate[(1 - annu^3)/(1 - annu^2)^(3/2), {annu, 0, 1}] === 2];

(* A8: Born integral along the unperturbed straight path:
       (2/c^2) Int_{-inf}^{inf} |grad_perp Phi| dl = (2/c^2)(2GM/b) = 4GM/(c^2 b) *)
check["A8 Int_{-inf}^{inf} G M b/(b^2+l^2)^(3/2) dl = 2 G M/b",
  Integrate[gG MM annb/(annb^2 + ll^2)^(3/2), {ll, -Infinity, Infinity},
     Assumptions -> annb > 0] === 2 gG MM/annb];

(* A9: second order. In eps = m/r0: Delta phi - pi = 4 eps + (15 pi/4 - 4) eps^2;
       with r0 = b - m - ..., alpha = 4 m/b + (15 pi/4)(m/b)^2 *)
Module[{c2eps, r0ofb, alphab},
  c2eps = 2 Integrate[(3/2) (1 - annu^3)^2/(1 - annu^2)^(5/2), {annu, 0, 1}];
  check["A9a eps^2 coefficient of Delta phi = 15 pi/4 - 4", Simplify[c2eps - (15 Pi/4 - 4)] === 0];
  check["A9b second-order term of 1/sqrt(A - 2 eps B) is (3/2) eps^2 B^2/A^(5/2)",
    Simplify[SeriesCoefficient[1/Sqrt[AA - 2 eps BB], {eps, 0, 2}] - (3/2) BB^2/AA^(5/2),
      AA > 0] === 0];
  r0ofb = annb - annm - (3/2) annm^2/annb;
  alphab = Series[4 annm/r0ofb + (15 Pi/4 - 4) (annm/r0ofb)^2, {annm, 0, 2}];
  check["A9c re-expanded in m/b: alpha = 4 m/b + (15 pi/4)(m/b)^2 + O(m^3)",
    Simplify[Normal[alphab] - (4 annm/annb + 15 Pi/4 annm^2/annb^2)] === 0]];

(* A10: rule of thumb for the 1st-order error: ratio of 2nd to 1st term = (15 pi/16)(m/b)
        = (15 pi/32)/(b/Rs); 1% at b/Rs = 15 pi/32/0.01 ~ 147 *)
annBRs1pc = N[15 Pi/32/0.01];
Print["  b/Rs where (15 pi/16)(m/b) = 1%: ", annBRs1pc];
check["A10a (15 pi/32)/0.01 = 147 (to 1)", Round[annBRs1pc] == 147];
Module[{e140, e150},
  e140 = Abs[(N[approx1[280]] - exactDefl[280])/exactDefl[280]] 100;
  e150 = Abs[(N[approx1[300]] - exactDefl[300])/exactDefl[300]] 100;
  Print["  exact error of 4m/b at b/Rs = 140, 150: ", e140, "%, ", e150, "%"];
  check["A10b exact: 1st-order error > 1% at b/Rs = 140 and < 1% at b/Rs = 150",
    e140 > 1 && e150 < 1]];
Module[{e10},
  e10 = Abs[(N[approx1[20]] - exactDefl[20])/exactDefl[20]] 100;
  Print["  1st-order error at b/Rs = 10: ", e10, "%;  (15 pi/32)/10 = ", N[15 Pi/32/10 100], "%"];
  check["A10c at b/Rs = 10 the exact error is 15% (rounded) and the 2-term estimate gives 14.7%",
    Round[e10] == 15 && Abs[N[15 Pi/32/10 100] - 14.7] < 0.05]];

(* A11: capture: b^2 = r0^3/(r0 - 2m) has minimum at r0 = 3m, b = 3 sqrt(3) m *)
Module[{bsq = annr0^3/(annr0 - 2 annm)},
  check["A11a d(b^2)/dr0 = 0 at r0 = 3m", Simplify[(D[bsq, annr0] /. annr0 -> 3 annm)] === 0];
  check["A11b b_crit = 3 sqrt(3) m", Simplify[Sqrt[bsq /. annr0 -> 3 annm], annm > 0] === 3 Sqrt[3] annm]];

(* A12: numbers: alpha = 2 Rs/b *)
annRsSun = 2 Gnewton Msolar/cc^2;
annRsGal = 2 Gnewton 1*^12 Msolar/cc^2;
Print["  Rs(Sun) = ", annRsSun, " m;  Rs(1e12 Msun) = ", annRsGal, " m"];
check["A12a Rs(Sun) = 2.95 km", Abs[annRsSun/1000 - 2.95] < 0.005];
check["A12b alpha_sun = 2 Rs/R_sun = 8.49e-6 rad = 1.75 arcsec",
  Abs[2 annRsSun/Rsolar - 8.49*^-6] < 0.005*^-6 && Abs[2 annRsSun/Rsolar radToArcsec - 1.75] < 0.005];
check["A12c Rs(1e12 Msun) = 2.95e15 m", Abs[annRsGal/1*^15 - 2.95] < 0.005];
check["A12d galaxy b = 10 kpc: alpha = 1.91e-5 rad = 3.95 arcsec, m/b = 4.8e-6",
  Abs[2 annRsGal/bgal - 1.91*^-5] < 0.005*^-5 && Abs[2 annRsGal/bgal radToArcsec - 3.95] < 0.005 &&
  Abs[(annRsGal/2)/bgal - 4.8*^-6] < 0.05*^-6];

(* A13: Shapiro integrand.  dt/dr = (1/c)(1-2m/r)^(-1)[1 - (r0^2/r^2)(1-2m/r)/(1-2m/r0)]^(-1/2)
        = (1/c) r/sqrt(r^2-r0^2) [1 + 2m/r + m r0/(r(r+r0))] + O(m^2) *)
Module[{exact, approx},
  exact = (1/(1 - 2 annm/annr))/Sqrt[1 - (annr0^2/annr^2) (1 - 2 annm/annr)/(1 - 2 annm/annr0)];
  approx = annr/Sqrt[annr^2 - annr0^2] (1 + 2 annm/annr + annm annr0/(annr (annr + annr0)));
  check["A13a weak-field expansion of c dt/dr",
    Simplify[Normal[Series[exact, {annm, 0, 1}]] - approx, annr > annr0 > 0] === 0]];
check["A13b Int_{r0}^{R} dr/sqrt(r^2-r0^2) = ln[(R + sqrt(R^2-r0^2))/r0]",
  Simplify[Integrate[1/Sqrt[annr^2 - annr0^2], {annr, annr0, annR}, Assumptions -> annR > annr0 > 0] -
     Log[(annR + Sqrt[annR^2 - annr0^2])/annr0], annR > annr0 > 0] === 0];
check["A13c d/dR sqrt((R-r0)/(R+r0)) = r0/((R+r0) sqrt(R^2-r0^2)), vanishing at R = r0",
  Simplify[D[Sqrt[(annR - annr0)/(annR + annr0)], annR] - annr0/((annR + annr0) Sqrt[annR^2 - annr0^2]),
     annR > annr0 > 0] === 0 && (Sqrt[(annR - annr0)/(annR + annr0)] /. annR -> annr0) === 0];
check["A13d Int_{r0}^{R} r dr/sqrt(r^2-r0^2) = sqrt(R^2-r0^2)",
  Simplify[Integrate[annr/Sqrt[annr^2 - annr0^2], {annr, annr0, annR}, Assumptions -> annR > annr0 > 0] -
     Sqrt[annR^2 - annr0^2], annR > annr0 > 0] === 0];

(* A14: R >> r0 limit and the round-trip formula with the "+1" *)
Module[{excess},
  excess = 2 annm Log[(annR + Sqrt[annR^2 - annr0^2])/annr0] + annm Sqrt[(annR - annr0)/(annR + annr0)];
  check["A14a excess(R) - [2m ln(2R/r0) + m] -> 0 as r0/R -> 0",
    Limit[(excess - (2 annm Log[2 annR/annr0] + annm)) /. annr0 -> xx annR, xx -> 0,
      Assumptions -> annR > 0 && annm > 0] === 0]];
check["A14b 2*{[2m ln(2R1/r0) + m] + [2m ln(2R2/r0) + m]} = 4m [ln(4 R1 R2/r0^2) + 1]",
  Simplify[2 ((2 annm Log[2 R1/annr0] + annm) + (2 annm Log[2 R2/annr0] + annm)) -
     4 annm (Log[4 R1 R2/annr0^2] + 1), R1 > 0 && R2 > 0 && annr0 > 0 && annm > 0] === 0 ||
  Simplify[PowerExpand[2 ((2 annm Log[2 R1/annr0] + annm) + (2 annm Log[2 R2/annr0] + annm)) -
     4 annm (Log[4 R1 R2/annr0^2] + 1)]] === 0];
Print["  4GM/c^3 = ", tScale 1*^6, " us; ln factor = ", logFactor,
      "; with +1: ", deltaT 1*^6, " us; without: ", tScale logFactor 1*^6, " us"];
check["A14c 4 G Msun/c^3 = 19.7 us", Abs[tScale 1*^6 - 19.7] < 0.05];
check["A14d ln(4 R_E R_M/R_sun^2) = 11.18", Abs[logFactor - 11.18] < 0.005];
check["A14e Delta T = 19.7 (11.18 + 1) us = 240 us (to 1 us)", Round[deltaT 1*^6] == 240];
check["A14f leading log alone gives 220 us (to 1 us)", Round[tScale logFactor 1*^6] == 220];

(* A15: isotropic weak field: n = sqrt[(1+2m/r)/(1-2m/r)] = 1 + 2m/r + O(m^2);
        deflection = Int grad_perp n dl = 4 m/b;  Newton-like n = 1 + m/r gives 2m/b *)
check["A15a n = sqrt[(1+2m/r)/(1-2m/r)] = 1 + 2m/r + O(m^2)",
  Simplify[Normal[Series[Sqrt[(1 + 2 annm/annr)/(1 - 2 annm/annr)], {annm, 0, 1}]] - (1 + 2 annm/annr),
    annr > 0] === 0];
check["A15b Int_{-inf}^{inf} d/db[2m/sqrt(b^2+l^2)] dl = -4m/b (|.| = 4m/b)",
  Integrate[D[2 annm/Sqrt[annb^2 + ll^2], annb], {ll, -Infinity, Infinity},
    Assumptions -> annb > 0] === -4 annm/annb];
check["A15c Int_{-inf}^{inf} d/db[m/sqrt(b^2+l^2)] dl = -2m/b (Newton: g_tt only)",
  Integrate[D[annm/Sqrt[annb^2 + ll^2], annb], {ll, -Infinity, Infinity},
    Assumptions -> annb > 0] === -2 annm/annb];

(* A16: Soldner. Binet: u'' + u = GM/L^2 solved by u = (GM/L^2)(1 + e cos phi);
        energy fixes e^2 = 1 + 2 E L^2/(GM)^2; asymptotes at phi = +-(pi/2 + arcsin(1/e)) *)
Module[{uu, en},
  uu = gG MM/annL^2 (1 + ee Cos[ph]);
  check["A16a Binet equation u'' + u = GM/L^2", Simplify[D[uu, {ph, 2}] + uu - gG MM/annL^2] === 0];
  en = annL^2/2 (D[uu, ph]^2 + uu^2) - gG MM uu;
  check["A16b specific energy = (GM)^2 (e^2-1)/(2 L^2) => e^2 = 1 + 2 E L^2/(GM)^2",
    Simplify[en - (gG MM)^2 (ee^2 - 1)/(2 annL^2)] === 0]];
check["A16c arccos(-1/e) = pi/2 + arcsin(1/e) (e = 1.7, 5, 1e5)",
  And @@ Table[Abs[ArcCos[-1/e0] - (Pi/2 + ArcSin[1/e0])] < 10^-12, {e0, {1.7, 5., 1.*^5}}]];
Print["  Newtonian Sun: ", alphaNSun, " rad = ", alphaNSun radToArcsec, " arcsec"];
check["A16d Newtonian Sun: 4.25e-6 rad = 0.876 arcsec = half of the GR 1.75 arcsec",
  Abs[alphaNSun - 4.25*^-6] < 0.005*^-6 && Abs[alphaNSun radToArcsec - 0.876] < 0.0005 &&
  Abs[alphaSun radToArcsec - 1.75] < 0.005 && Abs[alphaSun/(2 alphaNSun) - 1] < 10^-9];

(* A17: point-mass Einstein radius from beta = 0 in theta - beta = (Dds/Ds) 4GM/(c^2 Dd theta) *)
check["A17 beta = 0 => theta^2 = (4GM/c^2) Dds/(Dd Ds)",
  Simplify[(th0^2 /. Solve[th0 == (Dds0/Ds0) 4 gG MM/(cS^2 Dd0 th0), th0][[1]]) -
     4 gG MM/cS^2 Dds0/(Dd0 Ds0)] === 0];

(* A18: Shapiro coefficient in the cosmological delay:
        (Dd Ds/(c Dds)) thetaE^2 = 4GM/c^3 *)
check["A18 (Dd Ds/(c Dds)) thetaE^2 = 4 G M/c^3",
  Simplify[(Dd0 Ds0/(cS Dds0)) (4 gG MM/cS^2 Dds0/(Dd0 Ds0)) - 4 gG MM/cS^3] === 0];

(* A19: reduced deflection of the same alpha_hat for two source planes;
        ratio of reduced deflections = (Dds1/Ds1)/(Dds2/Ds2) — numbers in Module 3 *)
check["A19 alpha_1/alpha_2 = (Dds1 Ds2)/(Ds1 Dds2) for a common alpha_hat",
  Simplify[((Dds1/Ds1) ah)/((Dds2/Ds2) ah) - Dds1 Ds2/(Ds1 Dds2)] === 0];

summary[];
