(* =========================================================================
   problems_01d.wl
   Module 1d: Geodesics and Orbits in Schwarzschild Spacetime — SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 1d, verified
            symbolically with Mathematica.

   Sources: Carroll Ch. 5 (Secs. 5.4--5.5), Congdon & Keeton Ch. 3.3.3

   Usage:   wolframscript -file problems_01d.wl

   Exercises solved:
     1.1 — Derive V_eff from the normalization condition
     1.2 — ISCO derivation (r = 6, L = 2*Sqrt[3])
     1.3 — Photon sphere at r = 3 (unstable)
     1.4 — Mercury perihelion precession (43 arcsec/century)
     1.5 — Plot V_eff for L = 4, identify circular orbits and ISCO
   ========================================================================= *)

Print["=== Module 1d: SOLUTIONS ===\n"];

(* ---- Setup: Schwarzschild in G = c = M = 1 units ---- *)
(* In these units: Rs = 2GM/c^2 = 2, so f(r) = 1 - 2/r *)
f[r_] := 1 - 2/r;

(* Effective potential for general epsilon *)
(* epsilon = 1 for massive particles, 0 for photons *)
Veff[r_, L_, eps_] := -eps/r + L^2/(2 r^2) - L^2/r^3;

(* Newtonian effective potential (no 1/r^3 term) *)
VeffNewton[r_, L_] := -1/r + L^2/(2 r^2);


(* =========================================================================
   Exercise 1.1: Derive V_eff from the Normalization Condition

   Start with:
     -f(r)(dt/dlambda)^2 + f(r)^{-1}(dr/dlambda)^2 + r^2(dphi/dlambda)^2 = -epsilon
   Substitute:
     E = f(r) dt/dlambda,  L = r^2 dphi/dlambda
   Rearrange to get 1D energy equation:
     (1/2)(dr/dlambda)^2 + V_eff(r) = (1/2)(E^2 - epsilon)
   ========================================================================= *)

Print["--- Exercise 1.1: Derive V_eff from Normalization Condition ---\n"];

Print["Step 1: The normalization condition (Carroll eq. 5.63):"];
Print["  -f(r)(dt/dl)^2 + f(r)^{-1}(dr/dl)^2 + r^2(dphi/dl)^2 = -epsilon"];
Print["  where f(r) = 1 - Rs/r = 1 - 2/r  (G=c=M=1 units)\n"];

Print["Step 2: Substitute conserved quantities:"];
Print["  E = f(r) dt/dl  =>  dt/dl = E / f(r)"];
Print["  L = r^2 dphi/dl  =>  dphi/dl = L / r^2\n"];

(* Symbolic substitution *)
Print["Step 3: Substitute into normalization condition:"];
Print["  -f * (E/f)^2 + (1/f) * (dr/dl)^2 + r^2 * (L/r^2)^2 = -epsilon"];
Print["  -E^2/f + (1/f)(dr/dl)^2 + L^2/r^2 = -epsilon\n"];

Print["Step 4: Multiply through by f(r) and rearrange:"];
Print["  (dr/dl)^2 = E^2 - f(r) * (epsilon + L^2/r^2)"];
Print["  (dr/dl)^2 = E^2 - (1 - 2/r)(epsilon + L^2/r^2)\n"];

(* Verify by expanding *)
expr = (1 - 2/r) * (eps + L^2/r^2) // Expand;
Print["  f(r)*(epsilon + L^2/r^2) = ", expr];
Print["    = epsilon - 2*epsilon/r + L^2/r^2 - 2L^2/r^3\n"];

Print["Step 5: Write as (1/2)(dr/dl)^2 + V_eff = E_eff:"];
Print["  (1/2)(dr/dl)^2 + [-epsilon/r + L^2/(2r^2) - L^2/r^3]"];
Print["    = (1/2)(E^2 - epsilon)\n"];

Print["  Therefore:"];
Print["  V_eff(r) = -epsilon/r + L^2/(2r^2) - L^2/r^3"];
Print["           = -epsilon*GM/r + L^2/(2r^2) - GM*L^2/(c^2 r^3)  (restoring units)\n"];

(* Verify the symbolic derivation *)
(* Start from normalization and derive V_eff *)
normalization = -f[r] * (EE / f[r])^2 + (1/f[r]) * rdot^2 + r^2 * (L/r^2)^2 + eps;
normSimp = Simplify[normalization];
Print["  Symbolic check: normalization = ", normSimp];
(* Solve for rdot^2 / 2 *)
rdotSq = Solve[normSimp == 0, rdot][[2, 1, 2]]^2 // Simplify;
halfRdotSq = rdotSq / 2 // Expand;
Print["  (1/2)(dr/dl)^2 = ", halfRdotSq];
Print[""];

(* Newtonian limit: drop 1/r^3 term *)
Print["Step 6: Newtonian limit (drop the 1/r^3 GR correction term):"];
Print["  V_eff^Newton = -GM/r + L^2/(2r^2)"];
Print["  This is the standard Newtonian effective potential ---"];
Print["  the centrifugal barrier L^2/(2r^2) diverges as r -> 0,"];
Print["  preventing particles from reaching the center."];
Print["  The GR term -L^2/r^3 breaks this barrier at small r.\n"];

(* Verify Newtonian limit *)
VeffGR[r_] := -1/r + L^2/(2 r^2) - L^2/r^3;
VeffN[r_] := -1/r + L^2/(2 r^2);
Print["  V_eff(GR) - V_eff(Newton) = -L^2/r^3  (the GR correction)"];
Print["  This term vanishes for large r or large L (weak-field limit).\n"];


(* =========================================================================
   Exercise 1.2: ISCO Derivation

   Solve dV/dr = 0 and d^2V/dr^2 = 0 simultaneously.
   In G=c=M=1 units: r_ISCO = 6, L_ISCO = 2*Sqrt[3].
   ========================================================================= *)

Print["--- Exercise 1.2: ISCO Derivation ---\n"];

(* First derivative *)
dVdr = D[Veff[r, L, 1], r] // Simplify;
Print["dV_eff/dr = ", dVdr];
Print["  = epsilon/r^2 - L^2/r^3 + 3L^2/r^4  (for eps=1)\n"];

(* Second derivative *)
d2Vdr2 = D[Veff[r, L, 1], {r, 2}] // Simplify;
Print["d^2V_eff/dr^2 = ", d2Vdr2];
Print[""];

(* Solve dV/dr = 0 for r (multiply by r^4) *)
Print["Step 1: From dV/dr = 0, multiply by r^4:"];
Print["  r^2 - L^2 r + 3L^2 = 0"];
circEq = r^2 - L^2 r + 3 L^2;
circSol = Solve[circEq == 0, r];
Print["  r = ", r /. circSol[[1]], " and r = ", r /. circSol[[2]]];
Print[""];

Print["Step 2: For ISCO, the two solutions coincide => discriminant = 0:"];
Print["  discriminant = L^4 - 12L^2 = L^2(L^2 - 12) = 0"];
Print["  => L^2 = 12, i.e., L = 2*Sqrt[3]\n"];

(* Solve both conditions simultaneously *)
iscoSystem = {
    D[Veff[r, L, 1], r] == 0,
    D[Veff[r, L, 1], {r, 2}] == 0
};
iscoSol = Solve[iscoSystem, {r, L}] // Simplify;
Print["Simultaneous solution of dV/dr = 0, d^2V/dr^2 = 0:"];
Do[
    Print["  r = ", r /. sol, ", L = ", L /. sol],
    {sol, iscoSol}
];
Print[""];

(* Physical solution: r > 0, L > 0 *)
Print["Physical ISCO (r > 0, L > 0):"];
Print["  r_ISCO = 6  (= 6GM/c^2 = 3*Rs in geometric units)"];
Print["  L_ISCO = 2*Sqrt[3] = ", N[2 Sqrt[3], 6]];
Print[""];

(* Verify: at r=6, L=2*Sqrt[3], both derivatives vanish *)
rISCO = 6; LISCO = 2 Sqrt[3];
Print["Verification:"];
Print["  dV/dr at r=6, L=2Sqrt[3] = ",
    D[Veff[r, L, 1], r] /. {r -> rISCO, L -> LISCO} // Simplify];
Print["  d^2V/dr^2 at r=6, L=2Sqrt[3] = ",
    D[Veff[r, L, 1], {r, 2}] /. {r -> rISCO, L -> LISCO} // Simplify];
Print["  V_eff at ISCO = ", Veff[rISCO, LISCO, 1] // Simplify];
Print[""];

(* In physical units *)
Print["In physical units:"];
Print["  r_ISCO = 6 GM/c^2 = 3 R_S"];
Print["  For the Sun: r_ISCO = 6 * (1.48 km) = 8.87 km"];
Print["  For Sgr A*: r_ISCO ~ 6 * 6.2e9 m = 3.7e10 m ~ 0.25 AU\n"];


(* =========================================================================
   Exercise 1.3: Photon Sphere Derivation

   Set eps = 0 in V_eff: V_eff = L^2/(2r^2) - L^2/r^3
   Solve dV/dr = 0: r = 3 (= 3GM/c^2 = 3Rs/2)
   Show d^2V/dr^2 < 0 (unstable, a maximum)
   ========================================================================= *)

Print["--- Exercise 1.3: Photon Sphere ---\n"];

Print["For photons (epsilon = 0):"];
Print["  V_eff = L^2/(2r^2) - L^2/r^3\n"];

(* Find circular photon orbit *)
dVphoton = D[Veff[r, L, 0], r] // Simplify;
Print["  dV/dr = ", dVphoton];
Print["  Setting dV/dr = 0 and multiplying by r^4/L^2:"];
Print["  -r + 3 = 0  =>  r = 3\n"];

rPhotonSol = Solve[dVphoton == 0, r];
Print["  Mathematica confirms: r_photon = ", r /. rPhotonSol];
Print["  i.e., r = 3GM/c^2 = 3Rs/2\n"];

(* Check stability: second derivative at r = 3 *)
d2Vphoton = D[Veff[r, L, 0], {r, 2}] /. r -> 3 // Simplify;
Print["  d^2V/dr^2 at r = 3: ", d2Vphoton];
Print["  For L > 0: d^2V/dr^2 = -2L^2/81 < 0"];
Print["  => V_eff has a MAXIMUM at r = 3 => UNSTABLE circular orbit\n"];

Print["Physical interpretation:"];
Print["  A photon placed exactly at r = 3GM/c^2 will orbit the black hole,"];
Print["  but any perturbation will cause it to either:");
Print["    - spiral inward and fall into the black hole, or"];
Print["    - escape to infinity."];
Print["  This is the 'photon sphere' observed by the Event Horizon Telescope."];
Print["  The 'photon ring' in black hole images corresponds to photons"];
Print["  that orbit near this radius before reaching the observer.\n"];


(* =========================================================================
   Exercise 1.4: Mercury Perihelion Precession

   DeltaPhi = 6*Pi*G*M / (c^2 * a * (1 - e^2))
   Mercury: a = 5.79e10 m, e = 0.2056, M = Msun
   Convert to arcsec/century using period = 87.97 days
   ========================================================================= *)

Print["--- Exercise 1.4: Mercury Perihelion Precession ---\n"];

(* Physical constants *)
Gnewton = 6.674*^-11;        (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;               (* m/s *)
Msolar = 1.989*^30;          (* kg *)

(* Mercury orbital parameters *)
aMerc = 5.79*^10;            (* semi-major axis, meters *)
eMerc = 0.2056;              (* eccentricity *)
TMerc = 87.97;               (* orbital period, days *)

Print["Given:"];
Print["  G = ", ScientificForm[Gnewton], " m^3 kg^-1 s^-2"];
Print["  c = ", ScientificForm[cc], " m/s"];
Print["  M_sun = ", ScientificForm[Msolar], " kg"];
Print["  a_Mercury = ", ScientificForm[aMerc], " m"];
Print["  e_Mercury = ", eMerc];
Print["  T_Mercury = ", TMerc, " days\n"];

(* Step 1: Compute precession per orbit *)
deltaPhi = 6 Pi Gnewton Msolar / (cc^2 * aMerc * (1 - eMerc^2));

Print["Step 1: Precession per orbit"];
Print["  DeltaPhi = 6*Pi*G*M / (c^2 * a * (1 - e^2))"];
Print["  = 6*Pi * ", ScientificForm[Gnewton], " * ", ScientificForm[Msolar]];
Print["    / (", ScientificForm[cc^2], " * ", ScientificForm[aMerc],
    " * ", 1 - eMerc^2, ")"];
Print["  = ", ScientificForm[deltaPhi, 4], " rad/orbit\n"];

(* Step 2: Convert to arcseconds *)
deltaPhiArcsec = deltaPhi * (180 * 3600 / Pi);
Print["Step 2: Convert to arcseconds"];
Print["  DeltaPhi = ", ScientificForm[deltaPhi, 4], " rad * (180*3600/Pi arcsec/rad)"];
Print["  = ", NumberForm[deltaPhiArcsec, {5, 4}], " arcsec/orbit\n"];

(* Step 3: Compute orbits per century *)
orbitsPerCentury = 100 * 365.25 / TMerc;
Print["Step 3: Orbits per century"];
Print["  N_orbits = 100 yr * 365.25 days/yr / 87.97 days"];
Print["  = ", NumberForm[orbitsPerCentury, {6, 1}], " orbits/century\n"];

(* Step 4: Precession per century *)
prePerCentury = deltaPhiArcsec * orbitsPerCentury;
Print["Step 4: Precession per century"];
Print["  DeltaPhi/century = ", NumberForm[deltaPhiArcsec, {5, 4}],
    " arcsec * ", NumberForm[orbitsPerCentury, {6, 1}], " orbits"];
Print["  = ", NumberForm[prePerCentury, {4, 1}], " arcsec/century"];
Print[""];
Print["  RESULT: DeltaPhi = ", NumberForm[prePerCentury, {4, 1}], " arcsec/century"];
Print["  Expected: 43.0 arcsec/century"];
Print["  This matches the observed anomalous precession of Mercury,"];
Print["  which was one of the first confirmations of general relativity.\n"];


(* =========================================================================
   Exercise 1.5: Plot V_eff for L = 4, Identify Circular Orbits

   (a) Plot V_eff(r) for L = 4 in G=c=M=1 units.
   (b) Find stable and unstable circular orbit radii.
   (c) Identify ISCO on the plot.
   ========================================================================= *)

Print["--- Exercise 1.5: V_eff for L = 4, Circular Orbits ---\n"];

Lval = 4;

(* Find circular orbit radii: solve dV/dr = 0 for L = 4 *)
dVdrL4 = D[Veff[r, Lval, 1], r] // Simplify;
circularOrbits = Solve[dVdrL4 == 0, r];
Print["For L = ", Lval, ":"];
Print["  dV/dr = 0 gives:"];
Do[
    rval = r /. sol;
    d2V = D[Veff[r, Lval, 1], {r, 2}] /. r -> rval // Simplify;
    stability = If[d2V > 0, "STABLE (minimum)", "UNSTABLE (maximum)"];
    Vval = Veff[rval, Lval, 1];
    Print["    r = ", rval, " = ", N[rval, 6],
        "  V_eff = ", N[Vval, 6], "  d^2V/dr^2 = ", N[d2V, 4],
        "  => ", stability],
    {sol, circularOrbits}
];
Print[""];

(* Compute numerical values *)
rStable = r /. circularOrbits[[2]];   (* outer root = stable *)
rUnstable = r /. circularOrbits[[1]]; (* inner root = unstable *)
Print["  Stable circular orbit: r_+ = ", N[rStable, 6]];
Print["  Unstable circular orbit: r_- = ", N[rUnstable, 6]];
Print["  ISCO (for reference): r_ISCO = 6.0 (occurs at L = 2*Sqrt[3] ~ 3.464)\n"];

(* Generate the plot *)
Print["Generating V_eff plot for L = 4..."];

rStableN = N[rStable];
rUnstableN = N[rUnstable];
VeffStable = Veff[rStableN, Lval, 1];
VeffUnstable = Veff[rUnstableN, Lval, 1];

plotVeff = Show[
    (* GR effective potential *)
    Plot[Veff[r, Lval, 1], {r, 2, 40},
        PlotRange -> {{0, 40}, {-0.08, 0.04}},
        PlotStyle -> {Blue, AbsoluteThickness[2]},
        AxesLabel -> {"r (GM/c^2)", Subscript["V", "eff"]},
        PlotLabel -> "Effective Potential for L = 4 (G=c=M=1)",
        ImageSize -> 550
    ],
    (* Newtonian comparison *)
    Plot[VeffNewton[r, Lval], {r, 2, 40},
        PlotStyle -> {Gray, AbsoluteThickness[1.5], Dashed}
    ],
    (* Mark circular orbit radii *)
    Graphics[{
        (* Stable orbit *)
        Darker[Green], PointSize[0.02],
        Point[{rStableN, VeffStable}],
        Text[Style["Stable\n(r = " <> ToString[NumberForm[rStableN, {4, 2}]] <> ")",
            10, Darker[Green]], {rStableN + 4, VeffStable}],
        (* Unstable orbit *)
        Red, PointSize[0.02],
        Point[{rUnstableN, VeffUnstable}],
        Text[Style["Unstable\n(r = " <> ToString[NumberForm[rUnstableN, {4, 2}]] <> ")",
            10, Red], {rUnstableN + 3, VeffUnstable + 0.008}],
        (* ISCO reference line *)
        Orange, Dashed, AbsoluteThickness[1],
        InfiniteLine[{{6, -1}, {6, 1}}],
        Text[Style["ISCO (r=6)", 9, Orange], {8, -0.065}],
        (* Horizon *)
        Gray, Dashed,
        InfiniteLine[{{2, -1}, {2, 1}}],
        Text[Style["Horizon", 9, Gray], {3, -0.075}]
    }]
];

(* Export the figure *)
baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/01d_Geodesics_Orbits";
Export[FileNameJoin[{baseDir, "veff_L4_exercise.pdf"}], plotVeff];
Print["  Exported: veff_L4_exercise.pdf\n"];

Print["(b) Orbit classification for E slightly above V_eff(r_+):"];
Print["  When E_eff is slightly above the minimum at r_+, the particle"];
Print["  oscillates between r_min (perihelion) and r_max (aphelion)."];
Print["  Due to the GR correction, the orbit does not close: the"];
Print["  perihelion advances each orbit => BOUND PRECESSING ELLIPSE."];
Print["  This is the same physics responsible for Mercury's perihelion"];
Print["  precession (Exercise 1.4).\n"];

Print["=== End of Module 1d Solutions ==="];
