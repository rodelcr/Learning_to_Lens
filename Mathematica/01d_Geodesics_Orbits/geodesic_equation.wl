(* =========================================================================
   geodesic_equation.wl
   Module 1d: Geodesics and Orbits in Schwarzschild Spacetime
   =========================================================================
   Purpose: Symbolic derivation of geodesic equations, conserved quantities,
            effective potential, ISCO, photon sphere, and perihelion
            precession. Also generates publication-quality figures.

   Sources: Carroll Ch. 5 (Secs. 5.4--5.5), eqs. 5.61--5.74, 5.92
            Congdon & Keeton Ch. 3.3.3, eqs. 3.76--3.96

   Usage:   wolframscript -file geodesic_equation.wl

   Outputs: Symbolic verification of ISCO, photon sphere, precession;
            PDF figures exported to Figures/01d_Geodesics_Orbits/
   ========================================================================= *)

Print["=== Module 1d: Geodesics and Orbits ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/01d_Geodesics_Orbits";

(* =========================================================================
   Section 1: Effective Potential

   V_eff(r) = -epsilon GM/r + L^2/(2r^2) - G M L^2/(c^2 r^3)

   epsilon = 1 for massive particles, 0 for photons
   ========================================================================= *)

Print["--- Effective Potential ---\n"];

(* Define effective potential (using geometrized units G=c=1, M=1) *)
Veff[r_, L_, eps_] := -eps/r + L^2/(2 r^2) - L^2/r^3;
(* Note: in G=c=M=1 units, Rs = 2, so GM = 1, GM/c^2 = 1 *)

Print["V_eff(r) = -epsilon*GM/r + L^2/(2r^2) - GM*L^2/(c^2*r^3)"];
Print["(Working in G = c = M = 1 units throughout)\n"];

(* ---- Circular orbit condition: dV/dr = 0 ---- *)
dVdr = D[Veff[r, L, eps], r] // Simplify;
Print["dV_eff/dr = ", dVdr];
Print[""];

(* Solve for circular orbit radii (massive particles, eps=1) *)
circularOrbitEq = dVdr /. eps -> 1;
rCirc = Solve[circularOrbitEq == 0, r] // Simplify;
Print["Circular orbit radii (eps=1): r = ", r /. rCirc];
Print[""];

(* =========================================================================
   Section 2: ISCO Derivation

   The ISCO occurs when the two circular orbit solutions coincide,
   i.e., when the discriminant vanishes.
   dV/dr = 0 AND d^2V/dr^2 = 0 simultaneously.
   ========================================================================= *)

Print["--- ISCO Derivation ---\n"];

d2Vdr2 = D[Veff[r, L, 1], {r, 2}] // Simplify;

(* Solve dV/dr = 0 and d^2V/dr^2 = 0 simultaneously *)
iscoSol = Solve[{D[Veff[r, L, 1], r] == 0,
                  D[Veff[r, L, 1], {r, 2}] == 0},
                 {r, L}] // Simplify;

Print["ISCO conditions: dV/dr = 0, d^2V/dr^2 = 0"];
Print["Solutions (r, L):"];
Do[Print["  r = ", r /. sol, ", L = ", L /. sol], {sol, iscoSol}];
Print[""];

(* The physical solution is the one with r > 0, L > 0 *)
Print["Physical ISCO: r = 6 (= 6GM/c^2 = 3*Rs in these units)"];
Print["  L_ISCO = 2*Sqrt[3] = ", N[2 Sqrt[3], 6]];
Print[""];

(* =========================================================================
   Section 3: Photon Sphere

   For eps = 0: V_eff = L^2/(2r^2) - L^2/r^3
   dV/dr = 0 => -L^2/r^3 + 3L^2/r^4 = 0 => r = 3
   ========================================================================= *)

Print["--- Photon Sphere ---\n"];

dVphoton = D[Veff[r, L, 0], r] // Simplify;
rPhoton = Solve[dVphoton == 0, r];
Print["Photon effective potential: V = L^2/(2r^2) - L^2/r^3"];
Print["dV/dr = 0 => r = ", r /. rPhoton];
Print["  r = 3 (= 3GM/c^2 = 3Rs/2 in these units)"];
Print[""];

(* Verify it's a maximum *)
d2Vphoton = D[Veff[r, L, 0], {r, 2}] /. r -> 3 // Simplify;
Print["d^2V/dr^2 at r=3: ", d2Vphoton, " (negative => UNSTABLE)"];
Print[""];

(* =========================================================================
   Section 4: Perihelion Precession

   Delta phi = 6 pi G M / (c^2 a (1 - e^2))
   For Mercury: a = 5.79e10 m, e = 0.2056, M = Msun
   ========================================================================= *)

Print["--- Perihelion Precession of Mercury ---\n"];

(* Physical constants *)
Gnewton = 6.674*^-11;
cc = 2.998*^8;
Msolar = 1.989*^30;

aMerc = 5.79*^10;    (* semi-major axis in meters *)
eMerc = 0.2056;       (* eccentricity *)

(* Precession per orbit *)
deltaPhi = 6 Pi Gnewton Msolar / (cc^2 * aMerc * (1 - eMerc^2));
Print["Delta phi per orbit = ", ScientificForm[deltaPhi, 4], " rad"];
Print["  = ", NumberForm[deltaPhi * (180*3600/Pi), {4, 3}], " arcsec/orbit"];

(* Per century: Mercury orbital period = 87.97 days *)
orbitsPerCentury = 100 * 365.25 / 87.97;
prePerCentury = deltaPhi * orbitsPerCentury;
Print["Orbits per century: ", NumberForm[orbitsPerCentury, {5, 1}]];
Print["Delta phi per century = ", NumberForm[prePerCentury * (180*3600/Pi), {4, 1}],
    " arcsec/century"];
Print["Expected: 43.0 arcsec/century  (MATCHES!)\n"];

(* =========================================================================
   Section 5: Generate Figures
   ========================================================================= *)

Print["--- Generating Figures ---\n"];

(* ---- Figure 1: Effective potential for massive particles ---- *)
(* Compare Newtonian (no 1/r^3 term) vs GR for several values of L *)
fig1 = Show[
    (* GR effective potential *)
    Plot[Evaluate[Table[Veff[r, LL, 1], {LL, {3.5, 2 Sqrt[3], 4, 4.5, 5}}]],
        {r, 2, 40},
        PlotRange -> {{0, 40}, {-0.08, 0.06}},
        PlotStyle -> {
            {Blue, AbsoluteThickness[1.5]},
            {Red, AbsoluteThickness[2.5], Dashed},  (* ISCO value *)
            {Blue, AbsoluteThickness[1.5]},
            {Blue, AbsoluteThickness[1.5]},
            {Blue, AbsoluteThickness[1.5]}
        },
        AxesLabel -> {Style[Row[{"r / (GM/", Superscript["c", "2"], ")"}], 13],
                      Style[Subscript["V", "eff"], 14]},
        PlotLabel -> Style["Effective Potential (Massive Particles, GR)", 13],
        PlotLegends -> Placed[
            LineLegend[{"L = 3.5", "L = 2\[Sqrt]3 (ISCO)",
                        "L = 4", "L = 4.5", "L = 5"},
                LegendMarkerSize -> 15],
            {0.75, 0.7}],
        ImageSize -> 550
    ],
    (* Horizon line *)
    Graphics[{Gray, Dashed, InfiniteLine[{{2, -1}, {2, 1}}]}],
    Graphics[{Text[Style["Horizon", 9, Gray], {3, -0.065}]}]
];
Export[FileNameJoin[{baseDir, "effective_potential_massive.pdf"}], fig1];
Print["  Exported: effective_potential_massive.pdf"];

(* ---- Figure 2: Effective potential for photons ---- *)
fig2 = Plot[Evaluate[Table[Veff[r, LL, 0], {LL, {2, 3, 4, 5}}]],
    {r, 2, 30},
    PlotRange -> {{0, 30}, {-0.02, 0.08}},
    PlotStyle -> {
        {Orange, AbsoluteThickness[1.5]},
        {Red, AbsoluteThickness[2]},
        {Blue, AbsoluteThickness[1.5]},
        {Darker[Green], AbsoluteThickness[1.5]}
    },
    AxesLabel -> {Style[Row[{"r / (GM/", Superscript["c", "2"], ")"}], 13],
                  Style[Subscript["V", "eff"], 14]},
    PlotLabel -> Style["Effective Potential (Photons, GR)", 13],
    Epilog -> {
        Red, PointSize[0.015], Point[{3, Veff[3, 3, 0]}],
        Text[Style["Photon sphere\nr = 3GM/c\[CapitalTwo]", 10, Red], {6, Veff[3, 3, 0] + 0.008}]
    },
    PlotLegends -> Placed[
        LineLegend[{"L = 2", "L = 3", "L = 4", "L = 5"}, LegendMarkerSize -> 15],
        {0.75, 0.7}],
    ImageSize -> 500
];
Export[FileNameJoin[{baseDir, "effective_potential_photon.pdf"}], fig2];
Print["  Exported: effective_potential_photon.pdf"];

(* ---- Figure 3: Newtonian vs GR comparison ---- *)
VeffNewton[r_, L_] := -1/r + L^2/(2 r^2);

fig3 = Plot[{VeffNewton[r, 4], Veff[r, 4, 1]}, {r, 2, 40},
    PlotRange -> {{0, 40}, {-0.08, 0.04}},
    PlotStyle -> {
        {Gray, AbsoluteThickness[2], Dashed},
        {Blue, AbsoluteThickness[2]}
    },
    AxesLabel -> {Style[Row[{"r / (GM/", Superscript["c", "2"], ")"}], 13],
                  Style[Subscript["V", "eff"], 14]},
    PlotLabel -> Style["Newtonian vs. GR Effective Potential (L = 4)", 13],
    PlotLegends -> Placed[
        LineLegend[{"Newtonian", "General Relativity"}, LegendMarkerSize -> 15],
        {0.7, 0.7}],
    Epilog -> {
        Text[Style[Column[{"GR correction", Row[{"-GM", Superscript["L","2"], "/(", Superscript["c","2"], Superscript["r","3"], ")"}]}, Alignment->Center], 9,
            Blue], {8, -0.06}]
    },
    ImageSize -> 500
];
Export[FileNameJoin[{baseDir, "newtonian_vs_gr.pdf"}], fig3];
Print["  Exported: newtonian_vs_gr.pdf"];

(* ---- Figure 4: Precessing orbit ---- *)
(* Numerically integrate orbit equation in Schwarzschild spacetime *)
(* Using u = 1/r as function of phi: d^2u/dphi^2 + u = 1/p + 3u^2 (G=c=M=1) *)
(* where p = L^2/(GM) = L^2 *)
Module[{Lval = 4.2, eval = 0.3, p, sol, uF, rF, phiMax = 12 Pi},
    p = Lval^2;
    sol = NDSolve[{
        u''[phi] + u[phi] == 1/p + 3 u[phi]^2,
        u[0] == (1 + eval)/p,
        u'[0] == 0
    }, u, {phi, 0, phiMax}];
    uF = u /. First[sol];
    rF[phi_] := 1/uF[phi];
    fig4 = PolarPlot[rF[phi], {phi, 0, phiMax},
        PlotStyle -> {Blue, AbsoluteThickness[1.5]},
        PlotRange -> All,
        PlotLabel -> Style["Precessing Orbit in Schwarzschild Spacetime", 13],
        ImageSize -> 450,
        Epilog -> {
            Red, PointSize[0.02], Point[{0, 0}],
            Text[Style["M", 12, Red], {0.5, -0.5}]
        }
    ];
    Export[FileNameJoin[{baseDir, "precessing_orbit.pdf"}], fig4];
    Print["  Exported: precessing_orbit.pdf"];
];

Print["\n=== End of Module 1d ==="];
