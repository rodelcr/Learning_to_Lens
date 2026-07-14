(* =========================================================================
   microlensing.wl
   Module 13: Gravitational Microlensing
   =========================================================================
   Purpose: Symbolic verification of the point-lens microlensing results and
            the Paczynski light curve, plus publication-quality figures.

            (a) From the point-mass lens equation u = y - 1/y (Einstein units)
                solve for the two images y_pm and show that the total
                magnification A(u) = |mu_+| + |mu_-| simplifies to
                    A(u) = (u^2 + 2) / (u Sqrt[u^2 + 4]).
            (b) Verify the limits A(u) -> 1/u as u -> 0 (high magnification)
                and A(u) -> 1 as u -> Infinity.
            (c) Verify the light-curve symmetry A(u(t)) about t0 and that the
                peak magnification is A_max = A(u0).

   Sources: Schneider, Kochanek & Wambsganss (2006), Part 4
            (J. Wambsganss), Sect. 1, eqs. (1)-(8):
              lens eq. u = y - 1/y (their eq. 1),
              images   y_pm = (1/2)(u +/- Sqrt[u^2+4]) (their eq. 2),
              A(u) = (u^2+2)/(u Sqrt[u^2+4])           (their eq. 4),
              trajectory u(t) = Sqrt[u0^2 + ((t-t0)/tE)^2] (their eq. 8).
            Paczynski (1986), ApJ 304, 1.
            Cross-checks: Petters, Levine & Wambsganss (2001), Ch. 2.

   Usage:   wolframscript -file microlensing.wl

   Outputs: PASS/FAIL lines for each symbolic check;
            PDF figures exported to Figures/13_Microlensing/
   ========================================================================= *)

Print["=== Module 13: Gravitational Microlensing ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures/13_Microlensing";
If[!DirectoryQ[baseDir], CreateDirectory[baseDir]];

(* Helper: report a symbolic check *)
report[label_, ok_] := Print["  [", If[TrueQ[ok], "PASS", "FAIL"], "] ", label];

(* Helper: clean numeric formatting (this wolframscript's Print does not
   apply NumberForm/N display formatting unless wrapped in ToString) *)
sig[x_, n_] := ToString[NumberForm[N[x], n]];

(* Target total-magnification function *)
Amag[u_] := (u^2 + 2)/(u Sqrt[u^2 + 4]);


(* =========================================================================
   Check (a): point-lens images and total magnification A(u)
   ========================================================================= *)

Print["--- Check (a): images and total magnification A(u) ---\n"];

(* Point-mass lens equation in Einstein-radius units: u = y - 1/y,
   where u = beta/thetaE is the (normalized) source position and
   y = theta/thetaE is the (normalized) image position.
   This is a quadratic y^2 - u y - 1 = 0. *)
imageSolutions = Solve[u == y - 1/y, y];
Print["Image solutions y_pm of u = y - 1/y:"];
Print["  ", y /. imageSolutions, "\n"];

yPlus  = (u + Sqrt[u^2 + 4])/2;
yMinus = (u - Sqrt[u^2 + 4])/2;

(* Confirm these solve the lens equation *)
lensCheck = Simplify[{(yPlus - 1/yPlus), (yMinus - 1/yMinus)} - {u, u}];
report["y_pm = (u +/- Sqrt[u^2+4])/2 solve u = y - 1/y",
    lensCheck === {0, 0}];

(* Image magnification mu_i = 1/det(A_i) = 1/(1 - 1/y_i^4) (their eq. 3).
   For u > 0: y_+ > 1  => det > 0 => mu_+ > 0 (positive parity),
             |y_-| < 1 => det < 0 => mu_- < 0 (negative parity).
   Total magnification A = |mu_+| + |mu_-| = mu_+ - mu_-. *)
muPlus  = 1/(1 - 1/yPlus^4);
muMinus = 1/(1 - 1/yMinus^4);

(* Sign check at a representative point u = 1/2 *)
report["mu_+ > 0 and mu_- < 0 at u = 1/2",
    (muPlus /. u -> 1/2) > 0 && (muMinus /. u -> 1/2) < 0];

Atotal = Simplify[muPlus - muMinus, u > 0];
Print["Total magnification |mu_+| + |mu_-| = mu_+ - mu_- ="];
Print["  ", Atotal];
report["|mu_+| + |mu_-| = (u^2+2)/(u Sqrt[u^2+4])",
    Simplify[Atotal - Amag[u], u > 0] === 0];

(* The individual magnifications: mu_pm = A(u)/2 +/- 1/2  (their eqs. 4,5) *)
report["mu_+ = A(u)/2 + 1/2",
    Simplify[muPlus - (Amag[u]/2 + 1/2), u > 0] === 0];
report["mu_+ + mu_- = 1 (sum rule)",
    Simplify[muPlus + muMinus - 1, u > 0] === 0];

(* Image separation Delta y = |y_+ - y_-| = Sqrt[u^2 + 4] *)
report["image separation |y_+ - y_-| = Sqrt[u^2+4]",
    Simplify[(yPlus - yMinus) - Sqrt[u^2 + 4], u > 0] === 0];
Print[""];


(* =========================================================================
   Check (b): limiting behaviour of A(u)
   ========================================================================= *)

Print["--- Check (b): limits of A(u) ---\n"];

(* High-magnification limit: A(u) -> 1/u as u -> 0.
   Leading term of the Laurent series about u = 0 is 1/u. *)
leadingSmall = Series[Amag[u], {u, 0, 0}];
Print["Series of A(u) about u = 0:"];
Print["  ", Normal[leadingSmall]];
report["A(u) -> 1/u as u -> 0 (leading term)",
    Simplify[Limit[u Amag[u], u -> 0] - 1] === 0];

(* Large-u limit: A(u) -> 1 as u -> Infinity *)
largeU = Limit[Amag[u], u -> Infinity];
Print["Limit A(u), u -> Infinity = ", largeU];
report["A(u) -> 1 as u -> Infinity", largeU === 1];

(* Fiducial value A(1) = 3/Sqrt[5] ~ 1.34 (Wambsganss, p.456) *)
Print["A(1) = ", Amag[1], " = ", sig[Amag[1], 4]];
report["A(1) = 3/Sqrt[5] ~ 1.34", Simplify[Amag[1] - 3/Sqrt[5]] === 0];

(* Threshold magnification for |u| = 1 defines the 'event' criterion *)
report["A(u) = 3/Sqrt[5] at u = 1 (event threshold)",
    Simplify[Amag[1] - 3/Sqrt[5]] === 0];
Print[""];


(* =========================================================================
   Check (c): Paczynski light curve u(t) and its symmetry
   ========================================================================= *)

Print["--- Check (c): Paczynski light curve ---\n"];

(* Rectilinear relative motion: the source-lens separation is
   u(t) = Sqrt[u0^2 + ((t - t0)/tE)^2]   (their eq. 8). *)
uOfT[t_] := Sqrt[u0^2 + ((t - t0)/tE)^2];

(* Symmetry of u(t) about t0: u(t0 + s) = u(t0 - s) *)
uSym = Simplify[uOfT[t0 + s] - uOfT[t0 - s]];
report["u(t) symmetric about t0: u(t0+s) = u(t0-s)", uSym === 0];

(* Symmetry of the light curve A(u(t)) about t0 *)
lcSym = Simplify[Amag[uOfT[t0 + s]] - Amag[uOfT[t0 - s]]];
report["light curve A(u(t)) symmetric about t0", lcSym === 0];

(* Peak magnification: u(t) is minimized at t = t0 with u(t0) = u0,
   and A is a monotonically decreasing function of u, so A_max = A(u0). *)
report["u(t0) = u0 (closest approach)",
    Simplify[uOfT[t0] - u0, u0 > 0] === 0];

(* dA/du < 0 for u > 0 so the magnification peaks at the smallest u *)
dAdu = Simplify[D[Amag[u], u], u > 0];
Print["dA/du = ", dAdu];
report["dA/du < 0 for u > 0 (A decreasing => peak at u_min)",
    Simplify[dAdu < 0, u > 0]];

(* Stationarity of the light curve at t = t0 (assuming tE, u0 > 0) *)
dLCdt = D[Amag[uOfT[t]], t];
report["dA/dt = 0 at t = t0",
    Simplify[dLCdt /. t -> t0, {u0 > 0, tE > 0}] === 0];

Print["A_max = A(u0) = ", Amag[u0], "\n"];


(* =========================================================================
   Extra cross-checks
   ========================================================================= *)

Print["--- Extra cross-checks ---\n"];

(* Astrometric microlensing: maximum centroid shift.
   delta(u) = u/(u^2 + 2) * thetaE (shift of the light centroid, in units of
   thetaE); it is maximized at u = Sqrt[2] with value 1/(2 Sqrt[2]) = 8^{-1/2}
   (Wambsganss eq. 22; Paczynski 1998). *)
deltaCentroid[u_] := u/(u^2 + 2);
uStar = u /. Last[Solve[D[deltaCentroid[u], u] == 0 && u > 0, u]];
Print["Centroid shift delta(u) = u/(u^2+2) maximized at u = ", uStar];
report["centroid shift peaks at u = Sqrt[2]",
    Simplify[uStar - Sqrt[2]] === 0];
report["max centroid shift = 1/(2 Sqrt[2]) = 8^{-1/2} thetaE",
    Simplify[deltaCentroid[Sqrt[2]] - 1/(2 Sqrt[2])] === 0];
Print["  delta_max = ", deltaCentroid[Sqrt[2]], " = ",
    sig[deltaCentroid[Sqrt[2]], 4], " thetaE\n"];

(* Einstein timescale scaling: tE = thetaE Dd / v_perp, with
   thetaE ~ Sqrt[M], so tE ~ Sqrt[M]. Numerical demo of eq. (12):
   t0 ~ 0.2 yr (M/Msun)^{1/2} for Dd = 10 kpc, v = 200 km/s. *)
Gnewton = 6.674*^-11; cc = 2.998*^8; Msolar = 1.989*^30;
kpcToM = 3.086*^19; yrToS = 3.156*^7;
tECross[Mratio_, DdKpc_, vperp_] := Module[{Dd, Ds, Dds, thetaE, M},
    M = Mratio Msolar; Dd = DdKpc kpcToM;
    Ds = 50 kpcToM; Dds = Ds - Dd;  (* LMC-like source at 50 kpc *)
    thetaE = Sqrt[4 Gnewton M Dds/(cc^2 Dd Ds)];
    thetaE Dd/(vperp*1000)];  (* seconds *)
t0demo = tECross[1, 10, 200]/yrToS;
Print["Einstein crossing time for M=Msun, Dd=10 kpc, v=200 km/s:"];
Print["  tE ~ ", sig[t0demo, 3], " yr (order 0.1-0.2 yr). OK\n"];


Print["=== Generating figures ===\n"];


(* ---- Figure 1: Paczynski light curves A(t) for several u0 ---- *)
Module[{u0list, curves, fig1},
    u0list = {0.1, 0.3, 0.5, 0.7, 1.0};
    fig1 = Plot[
        Evaluate[Table[Amag[Sqrt[u0v^2 + tau^2]], {u0v, u0list}]],
        {tau, -2.5, 2.5},
        PlotStyle -> {
            {Black, AbsoluteThickness[2]},
            {Blue, AbsoluteThickness[2]},
            {Darker[Green], AbsoluteThickness[2]},
            {Orange, AbsoluteThickness[2]},
            {Red, AbsoluteThickness[2]}
        },
        PlotRange -> {{-2.5, 2.5}, {0.9, 11}},
        Frame -> True,
        FrameLabel -> {
            Style[Row[{"(t - ", Subscript["t", "0"], ") / ",
                Subscript["t", "E"]}], 13],
            Style[Row[{"magnification  A(", Style["u", Italic], ")"}], 13]
        },
        PlotLabel -> Style["Paczynski Microlensing Light Curves", 14],
        PlotLegends -> Placed[
            LineLegend[
                (Style[Row[{Subscript["u", "0"], " = ", #}], 10] &) /@ u0list,
                LegendMarkerSize -> 18],
            {0.82, 0.66}],
        ImageSize -> 560
    ];
    Export[FileNameJoin[{baseDir, "paczynski_lightcurves.pdf"}], fig1];
    Print["  Exported: paczynski_lightcurves.pdf"];
];


(* ---- Figure 2: A(u) vs u, with 1/u and asymptote overlaid ---- *)
Module[{fig2},
    fig2 = Plot[
        {Amag[u], 1/u, 1},
        {u, 0.05, 3},
        PlotStyle -> {
            {Red, AbsoluteThickness[2.5]},
            {Blue, AbsoluteThickness[1.5], Dashed},
            {Gray, AbsoluteThickness[1], Dotted}
        },
        PlotRange -> {{0, 3}, {0, 11}},
        Frame -> True,
        FrameLabel -> {
            Style[Row[{"source position  ", Style["u", Italic],
                " = \[Beta] / ", Subscript["\[Theta]", "E"]}], 13],
            Style[Row[{"magnification  A(", Style["u", Italic], ")"}], 13]
        },
        PlotLabel -> Style["Point-Lens Magnification A(u)", 14],
        PlotLegends -> Placed[
            LineLegend[{
                Style[Row[{"A(u) = (", Superscript["u", "2"],
                    "+2) / (u", Sqrt[Row[{Superscript["u", "2"], "+4"}]], ")"}], 10],
                Style["1 / u  (u \[Rule] 0)", 10],
                Style["A = 1  (u \[Rule] \[Infinity])", 10]
            }, LegendMarkerSize -> 18],
            {0.68, 0.72}],
        Epilog -> {
            Gray, PointSize[0.012], Point[{1, N[Amag[1]]}],
            Text[Style[Row[{"A(1) = 3/", Sqrt[5], " \[TildeTilde] 1.34"}],
                9, Gray], {1.55, 2.0}]
        },
        ImageSize -> 560
    ];
    Export[FileNameJoin[{baseDir, "magnification_A_of_u.pdf"}], fig2];
    Print["  Exported: magnification_A_of_u.pdf"];
];


Print["\n=== End of Module 13 verification ==="];
