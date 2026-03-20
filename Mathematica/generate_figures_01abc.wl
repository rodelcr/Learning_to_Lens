(* =========================================================================
   generate_figures_01abc.wl
   Generate publication-quality PDF figures for Modules 1a, 1b, 1c
   =========================================================================
   Usage: wolframscript -file generate_figures_01abc.wl
   Output: PDF files in Figures/01a_..., Figures/01b_..., Figures/01c_...
   ========================================================================= *)

Print["=== Generating Figures for Modules 1a, 1b, 1c ===\n"];

baseDir = "/Users/rosador/Documents/Learning_to_Lens/Figures";

(* =====================================================================
   MODULE 1a FIGURES
   ===================================================================== *)

Print["--- Module 1a Figures ---"];

(* ---- Figure 1: Spacetime Diagram with Light Cones ---- *)
(* Shows the light cone structure dividing spacetime into
   timelike, null, and spacelike regions. Cf. Carroll Fig. 1.5 *)
fig1a1 = Show[
    (* Shade timelike region *)
    RegionPlot[x^2 < t^2, {x, -3, 3}, {t, -3, 3},
        PlotStyle -> Directive[LightBlue, Opacity[0.25]],
        BoundaryStyle -> None],
    (* Light cone lines *)
    Plot[{x, -x}, {x, -3, 3},
        PlotStyle -> {{Orange, Dashed, AbsoluteThickness[2]},
                      {Orange, Dashed, AbsoluteThickness[2]}}],
    (* Worldlines *)
    Graphics[{
        (* Stationary particle *)
        {Blue, AbsoluteThickness[2.5],
         Arrow[{{0, -2.5}, {0, 2.5}}]},
        (* Moving particle v = 0.6c *)
        {Red, AbsoluteThickness[2.5],
         Arrow[{{-0.6*2.5, -2.5}, {0.6*2.5, 2.5}}]},
        (* Labels *)
        {FontSize -> 13,
         Text[Style["Timelike\n(future)", 11, Blue], {-0.9, 1.8}],
         Text[Style["Timelike\n(past)", 11, Blue], {-0.9, -1.8}],
         Text[Style["Spacelike", 11, Darker[Green]], {2.3, 0.3}],
         Text[Style["Null", 11, Darker[Orange]], {2.2, 2.6}],
         Text[Style["v = 0", 10, Blue], {0.3, 2.5}],
         Text[Style["v = 0.6c", 10, Red], {1.8, 2.3}]
        }
    }],
    AxesLabel -> {Style["x", 14, Italic], Style["t", 14, Italic]},
    AspectRatio -> 1,
    ImageSize -> 450,
    PlotRangePadding -> 0.1
];
Export[FileNameJoin[{baseDir, "01a_Special_Relativity", "light_cones.pdf"}], fig1a1];
Print["  Exported: light_cones.pdf"];

(* ---- Figure 2: Lorentz Boost — Tilted Axes ---- *)
(* Shows how the primed coordinate axes tilt toward the light cone
   as v increases. Cf. Carroll Fig. 1.7 *)
vBoost = 0.5;
fig1a2 = Show[
    (* Light cone *)
    Plot[{x, -x}, {x, -3, 3},
        PlotStyle -> {{Orange, Dashed, AbsoluteThickness[1.5]},
                      {Orange, Dashed, AbsoluteThickness[1.5]}}],
    Graphics[{
        (* Unprimed axes (black) *)
        {Black, AbsoluteThickness[1],
         Arrow[{{-3, 0}, {3, 0}}],
         Arrow[{{0, -3}, {0, 3}}]},
        (* t' axis: worldline of x' = 0, i.e. x = v*t *)
        {Red, AbsoluteThickness[2.5],
         Arrow[{{0, 0}, {vBoost*2.7, 2.7}}]},
        (* x' axis: line of t' = 0, i.e. t = v*x *)
        {Darker[Red], AbsoluteThickness[2.5],
         Arrow[{{0, 0}, {2.7, vBoost*2.7}}]},
        (* Labels *)
        {FontSize -> 14,
         Text[Style["t", Italic, Black], {-0.2, 2.9}],
         Text[Style["x", Italic, Black], {2.9, -0.2}],
         Text[Style["t'", Italic, Red, Bold], {vBoost*2.7 + 0.25, 2.85}],
         Text[Style["x'", Italic, Darker[Red], Bold], {2.85, vBoost*2.7 + 0.2}],
         Text[Style["v = 0.5c", 12], {-2, 2.5}]
        }
    }],
    Axes -> False,
    PlotRange -> {{-3.2, 3.2}, {-3.2, 3.2}},
    AspectRatio -> 1,
    ImageSize -> 400
];
Export[FileNameJoin[{baseDir, "01a_Special_Relativity", "lorentz_boost_axes.pdf"}], fig1a2];
Print["  Exported: lorentz_boost_axes.pdf"];

(* ---- Figure 3: Lorentz Factor gamma vs velocity ---- *)
fig1a3 = Plot[1/Sqrt[1 - v^2], {v, 0, 0.999},
    PlotRange -> {0, 25},
    AxesLabel -> {Style["v/c", 14, Italic], Style["\[Gamma]", 14, Italic]},
    PlotLabel -> Style["Lorentz Factor \[Gamma] = 1/\!\(\*SqrtBox[\(1 - v\^2/c\^2\)]\)", 13],
    PlotStyle -> {Blue, AbsoluteThickness[2]},
    GridLines -> {{0.5, 0.9, 0.99}, {1, 2, 5, 10, 20}},
    GridLinesStyle -> Directive[Gray, Dashed],
    Epilog -> {
        {PointSize[0.015], Red,
         Point[{0.5, 1/Sqrt[1 - 0.5^2]}],
         Point[{0.9, 1/Sqrt[1 - 0.9^2]}],
         Point[{0.99, 1/Sqrt[1 - 0.99^2]}]},
        Text[Style["(0.5, 1.15)", 9], {0.55, 2.8}],
        Text[Style["(0.9, 2.29)", 9], {0.82, 4.5}],
        Text[Style["(0.99, 7.09)", 9], {0.88, 9}]
    },
    ImageSize -> 450
];
Export[FileNameJoin[{baseDir, "01a_Special_Relativity", "lorentz_factor.pdf"}], fig1a3];
Print["  Exported: lorentz_factor.pdf"];

(* =====================================================================
   MODULE 1b FIGURES
   ===================================================================== *)

Print["--- Module 1b Figures ---"];

(* ---- Figure 1: Parallel Transport on a Sphere ---- *)
(* A vector transported around a triangular path on the sphere rotates.
   This is the classic illustration of curvature. Cf. Carroll Fig. 3.2 *)
fig1b1 = Module[{sphere, path1, path2, path3, vectors},
    sphere = ParametricPlot3D[
        {Sin[th] Cos[ph], Sin[th] Sin[ph], Cos[th]},
        {th, 0, Pi}, {ph, 0, 2 Pi},
        PlotStyle -> Directive[LightBlue, Opacity[0.3]],
        Mesh -> {8, 12},
        MeshStyle -> Directive[Gray, Opacity[0.2]]
    ];
    (* Path: equator from phi=0 to phi=Pi/3, then north to pole,
       then south along phi=0 back to equator *)
    path1 = ParametricPlot3D[
        {Cos[ph], Sin[ph], 0}, {ph, 0, Pi/3},
        PlotStyle -> {Red, AbsoluteThickness[3]}];
    path2 = ParametricPlot3D[
        {Sin[th] Cos[Pi/3], Sin[th] Sin[Pi/3], Cos[th]},
        {th, Pi/2, 0.01},
        PlotStyle -> {Red, AbsoluteThickness[3]}];
    path3 = ParametricPlot3D[
        {Sin[th], 0, Cos[th]}, {th, 0.01, Pi/2},
        PlotStyle -> {Red, AbsoluteThickness[3]}];
    (* Vectors at start and end *)
    vectors = Graphics3D[{
        (* Initial vector at (1,0,0): pointing in phi direction = (0,1,0) *)
        {Blue, AbsoluteThickness[3],
         Arrow[{{1, 0, 0}, {1, 0.4, 0}}]},
        (* Final vector after transport: rotated by alpha = Pi/3 *)
        {Darker[Green], AbsoluteThickness[3],
         Arrow[{{1, 0, 0}, {1, 0.4 Cos[Pi/3], 0.4 Sin[Pi/3]}}]},
        (* Labels *)
        Text[Style["Initial V", 11, Blue], {1, 0.5, -0.1}],
        Text[Style["Final V", 11, Darker[Green]], {1.1, 0.15, 0.35}],
        Text[Style["\[Alpha] = 60\[Degree]", 12, Red], {0.5, 0.5, -0.3}]
    }];
    Show[sphere, path1, path2, path3, vectors,
        Boxed -> False,
        ViewPoint -> {2.5, 1.5, 1.5},
        ImageSize -> 450,
        PlotLabel -> Style["Parallel Transport on S\[CapitalTwo]", 13]
    ]
];
Export[FileNameJoin[{baseDir, "01b_Differential_Geometry", "parallel_transport_sphere.pdf"}], fig1b1];
Print["  Exported: parallel_transport_sphere.pdf"];

(* ---- Figure 2: Geodesics on a Sphere (Great Circles) ---- *)
fig1b2 = Module[{sphere, gc1, gc2, gc3},
    sphere = ParametricPlot3D[
        {Sin[th] Cos[ph], Sin[th] Sin[ph], Cos[th]},
        {th, 0, Pi}, {ph, 0, 2 Pi},
        PlotStyle -> Directive[LightBlue, Opacity[0.25]],
        Mesh -> None
    ];
    (* Three great circles at different orientations *)
    gc1 = ParametricPlot3D[{Cos[t], Sin[t], 0}, {t, 0, 2 Pi},
        PlotStyle -> {Red, AbsoluteThickness[2.5]}];
    gc2 = ParametricPlot3D[{Cos[t], 0, Sin[t]}, {t, 0, 2 Pi},
        PlotStyle -> {Blue, AbsoluteThickness[2.5]}];
    gc3 = ParametricPlot3D[{0, Cos[t], Sin[t]}, {t, 0, 2 Pi},
        PlotStyle -> {Darker[Green], AbsoluteThickness[2.5]}];
    Show[sphere, gc1, gc2, gc3,
        Boxed -> False,
        ViewPoint -> {2, 2, 1.5},
        ImageSize -> 400,
        PlotLabel -> Style["Geodesics on S\[CapitalTwo] (Great Circles)", 13]
    ]
];
Export[FileNameJoin[{baseDir, "01b_Differential_Geometry", "geodesics_sphere.pdf"}], fig1b2];
Print["  Exported: geodesics_sphere.pdf"];

(* =====================================================================
   MODULE 1c FIGURES
   ===================================================================== *)

Print["--- Module 1c Figures ---"];

(* ---- Figure 1: Gravitational Time Dilation ---- *)
fig1c1 = Plot[Sqrt[1 - 1/x], {x, 1.01, 20},
    PlotRange -> {{0, 20}, {0, 1.05}},
    AxesLabel -> {Style["r / R\[LetterSpace]s", 14],
                  Style["d\[Tau]/dt", 14, Italic]},
    PlotLabel -> Style["Gravitational Time Dilation", 13],
    PlotStyle -> {Blue, AbsoluteThickness[2]},
    Filling -> Axis,
    FillingStyle -> Directive[LightBlue, Opacity[0.2]],
    Epilog -> {
        {Red, Dashed, AbsoluteThickness[1.5],
         InfiniteLine[{{1, 0}, {1, 1}}]},
        Text[Style["Event\nhorizon\nr = Rs", 10, Red], {1.8, 0.15}],
        {Gray, Dashed, InfiniteLine[{{0, 1}, {20, 1}}]},
        Text[Style["Flat spacetime limit", 10, Gray], {12, 1.03}]
    },
    ImageSize -> 450
];
Export[FileNameJoin[{baseDir, "01c_Schwarzschild", "time_dilation.pdf"}], fig1c1];
Print["  Exported: time_dilation.pdf"];

(* ---- Figure 2: Gravitational Redshift ---- *)
fig1c2 = Plot[1/Sqrt[1 - 1/x] - 1, {x, 1.01, 20},
    PlotRange -> {{1, 20}, {0, 3}},
    AxesLabel -> {Style["r / R\[LetterSpace]s", 14],
                  Style["z\[LetterSpace]grav", 14, Italic]},
    PlotLabel -> Style["Gravitational Redshift", 13],
    PlotStyle -> {Red, AbsoluteThickness[2]},
    Epilog -> {
        (* Neutron star: r/Rs ~ 10/4.1 ~ 2.4 *)
        {PointSize[0.015], Black,
         Point[{2.42, 1/Sqrt[1 - 1/2.42] - 1}]},
        Text[Style["Neutron star\nz \[TildeTilde] 0.3", 9, Black],
            {4, 1/Sqrt[1 - 1/2.42] - 1 + 0.3}],
        (* Sun: off the chart on the right *)
        Text[Style[Row[{"Sun: z ~ 2\[Times]", Superscript["10","-6"]}], 9, Gray],
            {12, 0.3}]
    },
    ImageSize -> 450
];
Export[FileNameJoin[{baseDir, "01c_Schwarzschild", "gravitational_redshift.pdf"}], fig1c2];
Print["  Exported: gravitational_redshift.pdf"];

(* ---- Figure 3: Flamm's Paraboloid ---- *)
(* The embedding of the equatorial Schwarzschild spatial geometry
   as a surface of revolution: z(r) = 2*sqrt(Rs*(r-Rs)) *)
fig1c3 = Module[{Rs = 1},
    RevolutionPlot3D[
        {r, 2 Sqrt[Rs] Sqrt[r - Rs]}, {r, Rs, 8 Rs},
        RevolutionAxis -> "Z",
        PlotStyle -> Directive[LightBlue, Opacity[0.7],
            Specularity[White, 20]],
        MeshStyle -> Directive[Gray, Opacity[0.4]],
        Mesh -> {15, 24},
        AxesLabel -> {Style["x", 12], Style["y", 12],
                      Style["z", 12]},
        PlotLabel -> Style["Flamm's Paraboloid\n(Schwarzschild Embedding)", 13],
        BoxRatios -> {1, 1, 0.6},
        ImageSize -> 500,
        Boxed -> False,
        ViewPoint -> {2.5, 1.5, 2}
    ]
];
Export[FileNameJoin[{baseDir, "01c_Schwarzschild", "flamm_paraboloid.pdf"}], fig1c3];
Print["  Exported: flamm_paraboloid.pdf"];

Print["\n=== All figures generated ==="];
