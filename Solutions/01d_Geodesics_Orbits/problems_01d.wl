(* =========================================================================
   problems_01d.wl
   Module 1d: Geodesics and Orbits in Schwarzschild Spacetime — SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 1d, verified
            symbolically with Mathematica.

   Sources: Carroll Ch. 5 (Secs. 5.4--5.5), Congdon & Keeton Ch. 3.3.3

   Usage:   wolframscript -file problems_01d.wl

   Outputs: printed worked solutions; Figures/01d_Geodesics_Orbits/
            veff_L4_exercise.pdf; PASS/FAIL checks for the Annotated Study
            Edition (section at the end of this file) and a SUMMARY line.

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
Print["  For L > 0: d^2V/dr^2 = -L^2/81 < 0"];
Print["  => V_eff has a MAXIMUM at r = 3 => UNSTABLE circular orbit\n"];

Print["Physical interpretation:"];
Print["  A photon placed exactly at r = 3GM/c^2 will orbit the black hole,"];
Print["  but any perturbation will cause it to either:"];
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
(* Repo-relative so the script writes into the checkout it is run from
   (was a hardcoded absolute path to the main checkout; changed 2026-10). *)
baseDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
    "Figures", "01d_Geodesics_Orbits"}];
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];
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


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity / number that appears inside an annotation, derivation or
   bridge box of Notes/01d_Geodesics_Orbits/*.tex is checked here.
   Symbols are prefixed "an" so nothing above is shadowed. *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                  "Mathematica", "harness.wl"}]];
Print["\n=== Annotated-edition checks (2026-10) ===\n"];

anChrist[g_, X_] := Module[{gi = Simplify[Inverse[g]], n = Length[X]},
  Table[Simplify[Sum[gi[[a, d]] (D[g[[d, m]], X[[k]]] + D[g[[d, k]], X[[m]]]
        - D[g[[m, k]], X[[d]]])/2, {d, n}]], {a, n}, {m, n}, {k, n}]];

(* --- A1  Schwarzschild Christoffels (c = 1) and the conserved E, L --- *)
anX = {ant, anr, anth, anph};
anf[r_] := 1 - anRs/r;
anG = anChrist[DiagonalMatrix[{-anf[anr], 1/anf[anr], anr^2, anr^2 Sin[anth]^2}], anX];
check["A1a Gamma^t_tr = Rs/(2 r (r - Rs))",
  Simplify[anG[[1, 1, 2]] - anRs/(2 anr (anr - anRs))] === 0];
check["A1b Gamma^phi_r phi = 1/r", Simplify[anG[[4, 2, 4]] - 1/anr] === 0];
check["A1c d/dlam[f tdot] = 0 on geodesics: f' - 2 f Gamma^t_tr = 0",
  Simplify[D[anf[anr], anr] - 2 anf[anr] anG[[1, 1, 2]]] === 0];
check["A1d d/dlam[r^2 phidot] = 0 on geodesics: (r^2)' - 2 r^2 Gamma^phi_r phi = 0",
  Simplify[D[anr^2, anr] - 2 anr^2 anG[[4, 2, 4]]] === 0];
check["A1e Gamma^r_tt = Rs (r - Rs)/(2 r^3)",
  Simplify[anG[[2, 1, 1]] - anRs (anr - anRs)/(2 anr^3)] === 0];

(* --- A2  r-component of the geodesic equation == -V'(r) (c = 1, GM = Rs/2) --- *)
anV1[r_] := -aneps anRs/(2 r) + anL^2/(2 r^2) - anRs anL^2/(2 r^3);
anRdd = -(anG[[2, 1, 1]] (anE/anf[anr])^2 + anG[[2, 2, 2]] anrd2 +
          anG[[2, 4, 4]] (anL/anr^2)^2) /. anth -> Pi/2 /.
        anrd2 -> anE^2 - anf[anr] (aneps + anL^2/anr^2);
check["A2 radial geodesic eq. reproduces rddot = -dV_eff/dr",
  Simplify[anRdd + D[anV1[anr], anr]] === 0];

(* --- A3  restored units: E = f c dt/dlam, g(u,u) = -eps c^2 --- *)
anfc[r_] := 1 - 2 anGN anM/(anc^2 r);
anVc[r_] := -aneps anGN anM/r + anL^2/(2 r^2) - anGN anM anL^2/(anc^2 r^3);
(* -f c^2 tdot^2 + rdot^2/f + r^2 phidot^2 = -eps c^2 with tdot = E/(f c) *)
anRd2 = Solve[-anfc[anr] anc^2 (anE/(anfc[anr] anc))^2 + anrd2/anfc[anr] +
     anL^2/anr^2 == -aneps anc^2, anrd2][[1, 1, 2]];
check["A3 [superseded convention E = f c dt/dlam; text now uses E = f c^2 dt/dlam, see F1a] (1/2) rdot^2 + V_eff = (1/2)(E^2 - eps c^2)",
  Simplify[anRd2/2 + anVc[anr] - (anE^2 - aneps anc^2)/2] === 0];
(* photon normalisation with the energy-type E' = f c^2 dt/dlam *)
anRd2p = Solve[-anfc[anr] anc^2 (anEp/(anfc[anr] anc^2))^2 + anrd2/anfc[anr] +
     anL^2/anr^2 == 0, anrd2][[1, 1, 2]];
check["A3b photons, E' = f c^2 dt/dlam: rdot^2 = E'^2/c^2 - f L^2/r^2",
  Simplify[anRd2p - (anEp^2/anc^2 - anfc[anr] anL^2/anr^2)] === 0];
check["A3c b = L/|rdot|_inf = c L/E'",
  Simplify[anL/Sqrt[Limit[anRd2p, anr -> Infinity]] - anc anL/anEp,
    Assumptions -> {anc > 0, anEp > 0, anL > 0}] === 0];
(* Newtonian specific energy: E = c + e/c *)
check["A3d [superseded convention, see F1g] (1/2)(E^2 - c^2) = e + e^2/(2c^2) for E = c + e/c",
  Simplify[((anc + ane/anc)^2 - anc^2)/2 - (ane + ane^2/(2 anc^2))] === 0];

(* --- A4  circular orbits (units): factorisation of V' and stability --- *)
anrp = anL^2/(2 anGN anM) (1 + Sqrt[1 - 12 anGN^2 anM^2/(anL^2 anc^2)]);
anrm = anL^2/(2 anGN anM) (1 - Sqrt[1 - 12 anGN^2 anM^2/(anL^2 anc^2)]);
check["A4a dV/dr = (GM r^2 - L^2 r + 3GML^2/c^2)/r^4 (eps=1)",
  Simplify[(D[anVc[anr], anr] /. aneps -> 1) -
    (anGN anM anr^2 - anL^2 anr + 3 anGN anM anL^2/anc^2)/anr^4] === 0];
check["A4b GM r^2 - L^2 r + 3GML^2/c^2 = GM (r - r+)(r - r-)",
  Simplify[Expand[anGN anM (anr - anrp) (anr - anrm)] -
    (anGN anM anr^2 - anL^2 anr + 3 anGN anM anL^2/anc^2)] === 0];
check["A4c V''(r+-) = +-GM (r+ - r-)/r+-^4 (so r+ min, r- max)",
  Simplify[(D[(anGN anM (anr - anrp) (anr - anrm))/anr^4, anr] /. anr -> anrp) -
    anGN anM (anrp - anrm)/anrp^4] === 0];
check["A4d discriminant zero, L^2 = 12 G^2M^2/c^2 => r = 6 GM/c^2",
  Simplify[(anL^2/(2 anGN anM)) /. anL -> Sqrt[12] anGN anM/anc] ===
    6 anGN anM/anc^2];

(* G = c = M = 1 versions *)
anrpG[L_] := L^2/2 (1 + Sqrt[1 - 12/L^2]);
anrmG[L_] := L^2/2 (1 - Sqrt[1 - 12/L^2]);
anV[r_, L_] := -1/r + L^2/(2 r^2) - L^2/r^3;
check["A4e r-(L) -> 3 (photon sphere) as L -> Infinity",
  Limit[anrmG[anLL], anLL -> Infinity] === 3];
check["A4f r+(L) increasing for L^2 > 12 (r_ISCO = min r+)",
  Reduce[D[anrpG[anLL], anLL] <= 0 && anLL > 2 Sqrt[3], anLL, Reals] === False];
check["A4g r+-(L=4) = {12, 4}; r+-(L=2 Sqrt3) = 6",
  Simplify[{anrpG[4], anrmG[4], anrpG[2 Sqrt[3]], anrmG[2 Sqrt[3]]}] === {12, 4, 6, 6}];

(* --- A5  ISCO binding energy --- *)
check["A5a V_eff(r=6, L^2=12) = -1/18", anV[6, Sqrt[12]] === -1/18];
check["A5b E^2/c^2 = 1 + 2 V = 8/9 at the ISCO", 1 + 2 anV[6, Sqrt[12]] === 8/9];
anEta = 1 - Sqrt[8/9];
Print["    ISCO efficiency 1 - sqrt(8/9) = ", N[anEta, 6]];
check["A5c efficiency 1 - 2 Sqrt2/3 = 0.0572 (3 s.f.)",
  Round[N[anEta], 0.0001] == 0.0572 && anEta === 1 - 2 Sqrt[2]/3];

(* --- A6  photon sphere, critical impact parameter --- *)
check["A6a photon dV/dr = (L^2/r^4)(3GM/c^2 - r)",
  Simplify[(D[anVc[anr], anr] /. aneps -> 0) -
    anL^2/anr^4 (3 anGN anM/anc^2 - anr)] === 0];
check["A6b V_photon(3) = L^2/54 (G=c=M=1)",
  Simplify[(anL^2/(2 anr^2) - anL^2/anr^3) /. anr -> 3] === anL^2/54];
(* turning point at r: 1/b^2 = (1 - 2/r)/r^2; at r = 3 -> b = 3 Sqrt3 *)
check["A6c b_crit = 3 Sqrt3 GM/c^2 = (3 Sqrt3/2) R_S",
  Sqrt[1/((1 - 2/3)/3^2)] === 3 Sqrt[3] && 3 Sqrt[3] == (3 Sqrt[3]/2)*2];
check["A6d E^2/2 = L^2/54 <=> b^2 = L^2/E^2 = 27",
  Simplify[(anLsq /. Solve[anE^2/2 == anLsq/54, anLsq][[1]])/anE^2] === 27];
Print["    3 Sqrt3/2 = ", N[3 Sqrt[3]/2, 5]];

(* --- A7  perihelion: orbit equation and secular term --- *)
(* (1/2)L^2 u'^2 - GM u + (1/2) L^2 u^2 - (GM L^2/c^2) u^3 = calE *)
anU = anu[anphi];
anEn = anL^2 D[anU, anphi]^2/2 - anGN anM anU + anL^2 anU^2/2 -
       anGN anM anL^2 anU^3/anc^2;
check["A7a d/dphi(energy eq.) = L^2 u' (u'' + u - GM/L^2 - 3GM u^2/c^2)",
  Simplify[D[anEn, anphi] - anL^2 D[anU, anphi] (D[anU, {anphi, 2}] + anU -
     anGN anM/anL^2 - 3 anGN anM anU^2/anc^2)] === 0];
check["A7b x = L^2 u/(GM): (L^2/GM)(GM/L^2 + 3GMu^2/c^2) = 1 + 3G^2M^2 x^2/(L^2c^2)",
  Simplify[(anL^2/(anGN anM)) (anGN anM/anL^2 + 3 anGN anM anuu^2/anc^2) -
    (1 + 3 anGN^2 anM^2 anxx^2/(anL^2 anc^2)) /.
      anuu -> anGN anM anxx/anL^2] === 0];
anx1 = aneps1 ((1 + ane^2/2) - (ane^2/6) Cos[2 anphi] + ane anphi Sin[anphi]);
check["A7c x1'' + x1 = eps (1 + e cos phi)^2 for the particular solution",
  Simplify[D[anx1, {anphi, 2}] + anx1 - aneps1 (1 + ane Cos[anphi])^2] === 0];
check["A7d 1 + e cos((1-eps)phi) = 1 + e cos phi + eps e phi sin phi + O(eps^2)",
  Simplify[Normal[Series[1 + ane Cos[(1 - aneps1) anphi], {aneps1, 0, 1}]] -
    (1 + ane Cos[anphi] + aneps1 ane anphi Sin[anphi])] === 0];
check["A7e 2Pi/(1-eps) - 2Pi = 2 Pi eps + O(eps^2)",
  Simplify[Normal[Series[2 Pi/(1 - aneps1) - 2 Pi, {aneps1, 0, 1}]] - 2 Pi aneps1] === 0];
check["A7f Kepler: r_peri + r_apo = 2a with r = (L^2/GM)/(1 + e cos phi) => L^2 = GM a (1-e^2)",
  Simplify[(Solve[(anp/(1 + ane) + anp/(1 - ane)) == 2 ana, anp][[1, 1, 2]]) -
    ana (1 - ane^2)] === 0];
check["A7g 2 Pi * 3G^2M^2/(L^2c^2) with L^2 = GMa(1-e^2) = 6 Pi GM/(c^2 a (1-e^2))",
  Simplify[(2 Pi 3 anGN^2 anM^2/(anL2 anc^2) /. anL2 -> anGN anM ana (1 - ane^2)) -
    6 Pi anGN anM/(anc^2 ana (1 - ane^2))] === 0];

(* --- A8  Mercury numbers (constants as in the solution) --- *)
anGMc2 = 6.674*^-11 1.989*^30/(2.998*^8)^2;
anDphi = 6 Pi anGMc2/(5.79*^10 (1 - 0.2056^2));
anArc = anDphi 180 3600/Pi;
anNorb = 100 365.25/87.97;
Print["    GM_sun/c^2 = ", anGMc2, " m;  GM/(c^2 a) = ", anGMc2/5.79*^10];
Print["    dphi = ", anDphi, " rad/orbit = ", anArc, " arcsec/orbit; N = ",
  anNorb, "; per century = ", anArc anNorb];
check["A8a GM_sun/c^2 = 1477 m (4 s.f.)", Round[anGMc2] == 1477];
check["A8b GM_sun/(c^2 a_Merc) = 2.55e-8", Abs[anGMc2/5.79*^10 - 2.55*^-8] < 0.005*^-8];
check["A8c 1 - e^2 = 0.9577", Abs[(1 - 0.2056^2) - 0.9577] < 0.00005];
check["A8d dphi = 5.02e-7 rad/orbit (3 s.f.)", Abs[anDphi - 5.02*^-7] < 0.005*^-7];
check["A8e dphi = 0.1036 arcsec/orbit (4 s.f.)",
  Abs[anArc - 0.1036] < 0.00005];
check["A8h 0.1034 x 415.2 = 42.93 (the former slip 0.1034 would give 42.9, not 43.0)",
  Abs[0.1034 415.2 - 42.93] < 0.005];
check["A8f N_orbits/century = 415.2", Abs[anNorb - 415.2] < 0.05];
check["A8g precession = 43.0 arcsec/century", Abs[anArc anNorb - 43.0] < 0.05];

(* --- A9  epicyclic (near-circular) precession --- *)
(* circular orbit: L^2 = r^2/(r - 3); kappa^2 = V''(r); Omega = L/r^2 *)
anKap2 = D[anV[anr, anLL], {anr, 2}] /. anLL -> Sqrt[anr^2/(anr - 3)];
check["A9a kappa^2/Omega^2 = 1 - 6/r on circular orbits (G=c=M=1)",
  Simplify[anKap2/(Sqrt[anr^2/(anr - 3)]/anr^2)^2 - (1 - 6/anr),
    Assumptions -> anr > 6] === 0];
check["A9b r = 12 -> L = 4", Sqrt[12^2/(12 - 3)] === 4];
anAdv12 = 2 Pi (1/Sqrt[1 - 6/12] - 1);
Print["    advance per radial period at r = 12: ", N[anAdv12], " rad = ",
  N[anAdv12 180/Pi], " deg"];
check["A9c advance at r = 12 = 2 Pi (Sqrt2 - 1) = 2.60 rad = 149 deg",
  Simplify[anAdv12 - 2 Pi (Sqrt[2] - 1)] === 0 && Round[N[anAdv12], 0.01] == 2.60 &&
  Round[N[anAdv12 180/Pi]] == 149];
check["A9d weak-field limit: 2Pi(1/Sqrt(1-6/r) - 1) -> 6 Pi/r",
  Simplify[Normal[Series[2 Pi (1/Sqrt[1 - 6 anw] - 1), {anw, 0, 1}]] - 6 Pi anw] === 0];

(* --- A10 Exercise 1.5 values --- *)
check["A10a r^2 - 16 r + 48 = 0 roots {4, 12}",
  Sort[anr /. Solve[anr^2 - 16 anr + 48 == 0, anr]] === {4, 12}];
check["A10b V(12) = -1/27 and V(4) = 0 for L = 4",
  anV[12, 4] === -1/27 && anV[4, 4] === 0];
check["A10c V(4) = 0 => E^2 = 1 (marginally bound)", 1 + 2 anV[4, 4] === 1];

(* --- A11 photon orbit: u-equation and first-order deflection --- *)
(* eq. photon_orbit with b = cL/E': (du/dphi)^2 = 1/b^2 - u^2 (1 - Rs u) *)
check["A11a (du/dphi)^2 = u^4 (r^4/L^2)(E'^2/c^2 - L^2 u^2 (1 - Rs u)) = 1/b^2 - u^2 (1 - Rs u)",
  Simplify[(anuu^4/anL^2/anuu^4) (anEp^2/anc^2 - anL^2 anuu^2 (1 - anRs anuu)) -
    (1/anb^2 - anuu^2 (1 - anRs anuu)) /. anb -> anc anL/anEp] === 0];
anW = anw[anphi];
check["A11b differentiating: 2u'u'' = -2uu' + 3 Rs u^2 u'  => u'' + u = (3/2) Rs u^2",
  Simplify[D[D[anW, anphi]^2 - (1/anb^2 - anW^2 (1 - anRs anW)), anphi] -
    2 D[anW, anphi] (D[anW, {anphi, 2}] + anW - 3 anRs anW^2/2)] === 0];
anUsol = Sin[anphi]/anb + anRs/(2 anb^2) (1 + Cos[anphi]^2);
check["A11c u = sin(phi)/b + (Rs/2b^2)(1 + cos^2 phi) solves u''+u=(3/2)Rs u^2 to O(Rs)",
  Simplify[Coefficient[Expand[D[anUsol, {anphi, 2}] + anUsol - 3 anRs anUsol^2/2],
    anRs, 1]] === 0 &&
  Simplify[Coefficient[Expand[D[anUsol, {anphi, 2}] + anUsol - 3 anRs anUsol^2/2],
    anRs, 0]] === 0];
check["A11d (Rs/4b^2)(4 - 2 sin^2 phi) = (Rs/2b^2)(1 + cos^2 phi)",
  Simplify[anRs/(4 anb^2) (4 - 2 Sin[anphi]^2) - anRs/(2 anb^2) (1 + Cos[anphi]^2)] === 0];
(* asymptotes: u = 0 at phi = -delta1 and phi = Pi + delta2, to first order *)
check["A11e u(-delta) = 0 => delta = Rs/b (first order)",
  Simplify[Normal[Series[(anUsol /. anphi -> -anRs/anb), {anRs, 0, 1}]]] === 0];
check["A11f u(Pi + delta) = 0 => delta = Rs/b; total 2Rs/b = 4GM/(c^2 b)",
  Simplify[Normal[Series[(anUsol /. anphi -> Pi + anRs/anb), {anRs, 0, 1}]]] === 0 &&
  Simplify[2 anRs/anb /. anRs -> 2 anGN anM/anc^2] === 4 anGN anM/(anc^2 anb)];

(* --- A12 Kerr --- *)
anDel = anr^2 - anRs anr + ana^2;
check["A12a Delta = 0 <=> r = (Rs +- Sqrt(Rs^2 - 4a^2))/2 = GM/c^2 +- Sqrt((GM/c^2)^2 - a^2)",
  Sort[anr /. Solve[anDel == 0, anr]] ===
    Sort[{(anRs - Sqrt[anRs^2 - 4 ana^2])/2, (anRs + Sqrt[anRs^2 - 4 ana^2])/2}] &&
  Simplify[((anRs + Sqrt[anRs^2 - 4 ana^2])/2 /. anRs -> 2 anm) -
    (anm + Sqrt[anm^2 - ana^2]), Assumptions -> anm > ana > 0] === 0];
check["A12b g_tt = 0 <=> r^2 - Rs r + a^2 cos^2 theta = 0 (outer root)",
  Simplify[(anr^2 + ana^2 Cos[anth]^2 - anRs anr /. anr -> (anRs + Sqrt[anRs^2 -
     4 ana^2 Cos[anth]^2])/2)] === 0];
anZ1[a_] := 1 + (1 - a^2)^(1/3) ((1 + a)^(1/3) + (1 - a)^(1/3));
anZ2[a_] := Sqrt[3 a^2 + anZ1[a]^2];
anIsco[a_, s_] := 3 + anZ2[a] - s Sqrt[(3 - anZ1[a]) (3 + anZ1[a] + 2 anZ2[a])];
check["A12c Kerr ISCO closed form: a=0 -> 6; a=1 -> 1 (pro), 9 (retro) [GM/c^2]",
  Simplify[{anIsco[0, 1], anIsco[0, -1], anIsco[1, 1], anIsco[1, -1]}] === {6, 6, 1, 9}];

(* --- A13 scale check for Part V: SMBH vs galaxy-scale impact parameters --- *)
anMs = 1.989*^30; anPc = 3.086*^16;
anRs9 = 2 6.674*^-11 1*^9 anMs/(2.998*^8)^2;
Print["    R_S(1e9 Msun) = ", anRs9, " m = ", anRs9/anPc, " pc; 1 kpc / R_S = ",
  1000 anPc/anRs9];
check["A13a R_S(1e9 Msun) = 2.95e12 m = 9.6e-5 pc",
  Abs[anRs9 - 2.95*^12] < 0.005*^12 && Abs[anRs9/anPc - 9.6*^-5] < 0.05*^-5];
check["A13b b = 1 kpc => b/R_S = 1.0e7", Abs[1000 anPc/anRs9 - 1.0*^7] < 0.05*^7];
check["A13c R_S(Sun) = 2.95 km", Abs[2 anGMc2 - 2954] < 1];

(* --- A14 extra checks quoted in the annotated boxes --- *)
check["A1f Gamma^r_rr = -Rs/(2 r (r - Rs))",
  Simplify[anG[[2, 2, 2]] + anRs/(2 anr (anr - anRs))] === 0];
check["A1g Gamma^r_phiphi = -(r - Rs) at theta = Pi/2",
  Simplify[(anG[[2, 4, 4]] /. anth -> Pi/2) + (anr - anRs)] === 0];
check["A1h Gamma^t_tr = f'/(2f)",
  Simplify[anG[[1, 1, 2]] - D[anf[anr], anr]/(2 anf[anr])] === 0];
check["A3e (GM L^2/(c^2 r^3)) / (L^2/(2 r^2)) = 2GM/(c^2 r) = R_S/r",
  Simplify[(anGN anM anL^2/(anc^2 anr^3))/(anL^2/(2 anr^2)) - 2 anGN anM/(anc^2 anr)] === 0];
check["A3f dimensions: [GM L^2/(c^2 r^3)] = m^2/s^2 when [L] = m^2/s",
  Simplify[(anmm^3/anss^2) (anmm^2/anss)^2/((anmm/anss)^2 anmm^3)] === anmm^2/anss^2];
check["A8i R_S/a for Mercury = 2 GM/(c^2 a) = 5.1e-8", Abs[2 anGMc2/5.79*^10 - 5.1*^-8] < 0.05*^-8];
check["A8j 6 Pi GM/c^2 = 2.784e4 m; a(1 - e^2) = 5.545e10 m",
  Abs[6 Pi anGMc2 - 2.784*^4] < 0.0005*^4 && Abs[5.79*^10 (1 - 0.2056^2) - 5.545*^10] < 0.0005*^10];
check["A12d ergosurface: r = Rs at the equator, = horizon r+ at the poles",
  Simplify[((anRs + Sqrt[anRs^2 - 4 ana^2 Cos[anth]^2])/2) /. anth -> Pi/2,
     Assumptions -> anRs > 0] === anRs &&
  Simplify[(((anRs + Sqrt[anRs^2 - 4 ana^2 Cos[anth]^2])/2) /. anth -> 0) -
     (anRs + Sqrt[anRs^2 - 4 ana^2])/2] === 0];
check["A13d b = 100 pc => b/R_S = 1.0e6", Abs[100 anPc/anRs9 - 1.0*^6] < 0.05*^6];
check["A13e b/R_S(Sun) = 6.96e8/2954 = 2.36e5", Abs[6.96*^8/(2 anGMc2) - 2.36*^5] < 0.005*^5];
check["A14a point-mass bend accrued within |x| < b: 1/Sqrt2 = 0.71; within |x| < 10b: 0.995",
  Simplify[Integrate[1/(anl^2 + 1)^(3/2), {anl, -1, 1}]/2] === 1/Sqrt[2] &&
  Round[N[Integrate[1/(anl^2 + 1)^(3/2), {anl, -10, 10}]/2], 0.001] == 0.995];
check["A15a 2 (r^2 - L^2 r + 3L^2) + (-2r^2 + 3L^2 r - 12 L^2) = L^2 (r - 6)",
  Expand[2 (anr^2 - anL^2 anr + 3 anL^2) + (-2 anr^2 + 3 anL^2 anr - 12 anL^2)] ===
    Expand[anL^2 (anr - 6)]];
check["A15b r^5 V''(r) = -2 r^2 + 3 L^2 r - 12 L^2 (G=c=M=1)",
  Simplify[anr^5 D[anV[anr, anL], {anr, 2}] - (-2 anr^2 + 3 anL^2 anr - 12 anL^2)] === 0];
check["A15c r = 6 in r^2 - L^2 r + 3 L^2 = 0 => L^2 = 12",
  Solve[36 - 6 anLsq + 3 anLsq == 0, anLsq] === {{anLsq -> 12}}];
check["A15d circular orbit: r^2 - L^2 r + 3L^2 = 0 <=> L^2 = r^2/(r - 3)",
  Simplify[(anr^2 - anLsq anr + 3 anLsq) /. anLsq -> anr^2/(anr - 3)] === 0];

(* ===== Fix-pass checks (2026-10-14; FACT_CRITIC_01d_annotated_2026-10-14 F1-F3) =====
   Each check passes on the corrected text and is written to FAIL on the old value. *)
Print["\n=== Fix-pass checks (2026-10-14) ===\n"];

(* --- F1  one normalisation of E: E = f c^2 dt/dlam (Congdon & Keeton eq. 3.76a) --- *)
fxf[r_] := 1 - 2 fxG fxM/(fxc^2 r);
fxV[r_] := -fxeps fxG fxM/r + fxL^2/(2 r^2) - fxG fxM fxL^2/(fxc^2 r^3);
(* normalisation -f c^2 tdot^2 + rdot^2/f + r^2 phidot^2 = -eps c^2, tdot = E/(f c^2) *)
fxRd2 = Solve[-fxf[fxr] fxc^2 (fxE/(fxf[fxr] fxc^2))^2 + fxrd2/fxf[fxr] +
     fxL^2/fxr^2 == -fxeps fxc^2, fxrd2][[1, 1, 2]];
check["F1a (1/2) rdot^2 + V_eff = (1/2)(E^2/c^2 - eps c^2) with E = f c^2 dt/dlam; old (1/2)(E^2 - eps c^2) fails",
  Simplify[fxRd2/2 + fxV[fxr] - (fxE^2/fxc^2 - fxeps fxc^2)/2] === 0 &&
  Simplify[fxRd2/2 + fxV[fxr] - (fxE^2 - fxeps fxc^2)/2] =!= 0];
check["F1b old c=1 normalisation (RHS -eps, E = f dt/dlam) does not give the printed V_eff with explicit c",
  Module[{rd = Solve[-fxf[fxr] (fxE/fxf[fxr])^2 + fxrd2/fxf[fxr] + fxL^2/fxr^2 == -fxeps,
        fxrd2][[1, 1, 2]]},
    Simplify[D[rd/2 + fxV[fxr], fxr]] =!= 0]];
(* photons (eps = 0) with the SAME E: eq. photon_orbit and b = c L/E *)
fxRd2p = fxRd2 /. fxeps -> 0;
check["F1c eps = 0: dphi/dr = (L/r^2)[E^2/c^2 - (L^2/r^2) f]^(-1/2)  (eq. photon_orbit)",
  Simplify[(fxL/fxr^2)/Sqrt[fxRd2p] - (fxL/fxr^2) (fxE^2/fxc^2 - fxL^2/fxr^2 fxf[fxr])^(-1/2)] === 0];
check["F1d b = L/|rdot|_inf = c L/E (and not L/E)",
  Module[{bb = fxL/Sqrt[Limit[fxRd2p, fxr -> Infinity]]},
    Simplify[bb - fxc fxL/fxE, Assumptions -> {fxc > 0, fxE > 0, fxL > 0}] === 0 &&
    Simplify[bb - fxL/fxE, Assumptions -> {fxc > 0, fxE > 0, fxL > 0}] =!= 0]];
check["F1e Killing: -K_mu u^mu = -g_tt tdot = f c^2 tdot with g_tt = -f c^2",
  Simplify[-(-fxf[fxr] fxc^2) fxtd - fxf[fxr] fxc^2 fxtd] === 0];
check["F1f Gamma^t_tr = (1/2) g^tt d_r g_tt = f'/(2f), independent of c",
  Simplify[(1/2) (1/(-fxf[fxr] fxc^2)) D[-fxf[fxr] fxc^2, fxr] - D[fxf[fxr], fxr]/(2 fxf[fxr])] === 0];
check["F1g E = c^2 + e => (1/2)(E^2/c^2 - c^2) = e + e^2/(2c^2); old E = c + e/c fails with new E-cal",
  Simplify[((fxc^2 + fxe)^2/fxc^2 - fxc^2)/2 - (fxe + fxe^2/(2 fxc^2))] === 0 &&
  Simplify[((fxc + fxe/fxc)^2/fxc^2 - fxc^2)/2 - (fxe + fxe^2/(2 fxc^2))] =!= 0];
check["F1h circular orbit (rdot = 0): (E/c^2)^2 = 1 + 2 V_eff/c^2; ISCO (G=c=M=1) E/c^2 = 2 Sqrt2/3",
  Simplify[(fxEsq /. Solve[(fxEsq/fxc^2 - fxc^2)/2 == fxVV, fxEsq][[1]])/fxc^4 - (1 + 2 fxVV/fxc^2)] === 0 &&
  Simplify[Sqrt[1 + 2 (-1/18)] - 2 Sqrt[2]/3] === 0];
check["F1i photon (G=c=M=1): E-cal = E^2/(2c^2) < L^2/54 <=> b^2 = c^2 L^2/E^2 > 27",
  Simplify[Reduce[fxE^2/2 < fxL^2/54 && fxE > 0 && fxL > 0, fxL] ===
           Reduce[fxL^2/fxE^2 > 27 && fxE > 0 && fxL > 0, fxL]]];

(* --- F2  Mercury, 01d_Solutions Ex 4 (solution's own constants) --- *)
check["F2a Step 1: dphi = 5.02e-7 rad/orbit at 3 s.f. (old 5.01e-7 fails)",
  Round[anDphi 10^7, 0.01] == 5.02 && Round[anDphi 10^7, 0.01] != 5.01];
check["F2b Step 2: 0.1036 arcsec/orbit at 4 s.f. (old 0.1034 fails)",
  Round[anArc, 0.0001] == 0.1036 && Round[anArc, 0.0001] != 0.1034];
check["F2c Step 4: 0.1036 x 415.2 = 43.0 (boxed value stands); 0.1034 x 415.2 = 42.9 != 43.0",
  Round[0.1036 415.2, 0.1] == 43.0 && Round[0.1034 415.2, 0.1] != 43.0];

(* --- F3  Ex 5(b): advance near r = 12 GM/c^2 is large; small only for r >> 6 GM/c^2 --- *)
fxAdv[rc_] := 2 Pi (1/Sqrt[1 - 6/rc] - 1);
Print["    advance per orbit: r=12 ", N[fxAdv[12]], " rad; r=600 ", N[fxAdv[600]],
  " rad (6Pi/r = ", N[6 Pi/600], ")"];
check["F3a advance at r = 12 is 2.6 rad = 149 deg (> 1 rad: NOT a small angle)",
  Round[N[fxAdv[12]], 0.1] == 2.6 && Round[N[fxAdv[12] 180/Pi]] == 149 && N[fxAdv[12]] > 1];
check["F3b r = 600 >> 6: advance small (< 0.04 rad) and within 1.5% of 6 Pi/r",
  N[fxAdv[600]] < 0.04 && Abs[N[fxAdv[600]/(6 Pi/600)] - 1] < 0.015];

(* --- F3c  Fig. precessing_orbit (geodesic_equation.wl Fig. 4: L = 4.2, u(0) = 1.3/L^2):
       the plotted orbit's advance is 2.07 rad = 119 deg per radial period, NOT "small";
       weak-field 6 Pi/p = 1.07 rad for p = L^2.  Caption corrected 2026-10-14. --- *)
Module[{Lv = 4.2, ev = 0.3, pp, solF, uF, peri, periX, adv},
  pp = Lv^2;
  solF = NDSolve[{u''[phi] + u[phi] == 1/pp + 3 u[phi]^2, u[0] == (1 + ev)/pp, u'[0] == 0},
                 u, {phi, 0, 12 Pi}, PrecisionGoal -> 10, AccuracyGoal -> 10];
  uF = u /. First[solF];
  peri = Reap[Do[If[uF'[x] > 0 && uF'[x + 0.01] < 0, Sow[x]], {x, 0.5, 12 Pi - 0.02, 0.01}]][[2, 1]];
  periX = Map[phi /. FindRoot[uF'[phi] == 0, {phi, #}] &, peri];
  adv = Differences[periX] - 2 Pi;
  Print["    plotted orbit: r_peri = ", N[pp/(1 + ev)], ", advance per radial period = ", adv,
        " rad; 6 Pi/p = ", N[6 Pi/pp]];
  check["F3c plotted orbit (L=4.2): r_peri = 13.57, advance = 2.07 rad = 119 deg per orbit (> 1 rad)",
    Round[N[pp/(1 + ev)], 0.01] == 13.57 && Length[adv] >= 2 &&
    And @@ (Round[#, 0.01] == 2.07 & /@ adv) && Round[adv[[1]] 180/Pi] == 119 && adv[[1]] > 1];
  check["F3d weak-field estimate 6 Pi/p = 1.07 rad underestimates the plotted advance by ~2x",
    Round[N[6 Pi/pp], 0.01] == 1.07 && 1.8 < adv[[1]]/(6 Pi/pp) < 2.1];
];

summary[];
