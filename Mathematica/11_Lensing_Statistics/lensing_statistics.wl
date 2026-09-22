(* =========================================================================
   lensing_statistics.wl
   Module 11: Lensing Statistics and Cross-Sections
   =========================================================================
   Purpose: Symbolic derivation and verification of the point-mass and SIS
            lensing cross-sections, and the magnification-bias factor for
            power-law source counts.  Exports one figure.

   Sources: Schneider, Kochanek & Wambsganss (2006), Part 1 (Schneider),
            Sec. 5: cross-sections (eqs. 97-101; see Test 6 for the
            H(mu-2) factor in printed eq. 101), optical depth
            (eqs. 104-107), magnification bias (eqs. 108-111).

   Usage:   wolframscript -file lensing_statistics.wl

   Outputs: Symbolic PASS/FAIL lines; figure
            Figures/11_Lensing_Statistics/point_mass_cross_section.pdf
   ========================================================================= *)

Print["=== Module 11: Lensing Statistics — symbolic verification ==="];
Print[""];

check[label_, ok_] := (Print[If[TrueQ[ok], "  PASS  ", "  FAIL  "], label]; TrueQ[ok]);
results = {};

(* ---------------------------------------------------------------------------
   Test 1: point-mass magnification cross-section (eqs. 97-98).
   Total magnification mu_p(y) = (y^2+2)/(y Sqrt[y^2+4]); the threshold
   mu_p(y) > mu corresponds to y^2 < 2 (mu/Sqrt[mu^2-1] - 1).
   Verify: substituting y^2 = 2(mu/Sqrt[mu^2-1]-1) into mu_p returns mu.
   --------------------------------------------------------------------------- *)
ClearAll[y, mu];
muP[yy_] := (yy^2 + 2)/(yy Sqrt[yy^2 + 4]);
y2ofMu = 2 (mu/Sqrt[mu^2 - 1] - 1);
muBack = FullSimplify[muP[Sqrt[y2ofMu]], Assumptions -> mu > 1];
AppendTo[results,
  check["Point mass: y^2(mu)=2(mu/Sqrt[mu^2-1]-1) inverts mu_p(y)",
        Simplify[muBack - mu, Assumptions -> mu > 1] === 0]];

(* Test 2: high-magnification limit y^2(mu) -> 1/mu^2  (=> sigma ~ mu^-2,
   equivalently the differential p(mu) ~ -d sigma/d mu ~ mu^-3). *)
leading = Limit[mu^2 y2ofMu, mu -> Infinity];
AppendTo[results,
  check["Point mass: y^2(mu) -> 1/mu^2 at large mu  (sigma ~ mu^-2, p(mu) ~ mu^-3)",
        leading === 1]];

(* ---------------------------------------------------------------------------
   Test 3: point-mass brightness-ratio cross-section (eq. 99).
   Image magnifications mu_pm = 1/2 +/- (y^2+2)/(4 y Sqrt[y^2+4]).
   Flux ratio r = mu_+/|mu_-|.  Setting y = r^(1/4) - r^(-1/4) must
   reproduce r, giving sigma(r) = pi thetaE^2 (r^(1/2)+r^(-1/2)-2).
   --------------------------------------------------------------------------- *)
ClearAll[r];
(* point-lens image magnifications: mu_pm = (mu_p(y) +/- 1)/2 *)
muPlus[yy_]  := (muP[yy] + 1)/2;
muMinusAbs[yy_] := (muP[yy] - 1)/2;
(* check total magnification consistency mu_+ + |mu_-| = mu_p *)
AppendTo[results,
  check["Point mass: mu_+ + |mu_-| = mu_p(y)",
        Simplify[muPlus[y] + muMinusAbs[y] - muP[y]] === 0]];
yOfr = r^(1/4) - r^(-1/4);
rBack = FullSimplify[muPlus[yOfr]/muMinusAbs[yOfr], Assumptions -> r > 1];
AppendTo[results,
  check["Point mass: y=r^(1/4)-r^(-1/4) reproduces flux ratio r",
        Simplify[rBack - r, Assumptions -> r > 1] === 0]];
sigmaR = Simplify[yOfr^2];   (* sigma/(pi thetaE^2) *)
AppendTo[results,
  check["Point mass: sigma(r)/(pi thetaE^2) = r^(1/2)+r^(-1/2)-2",
        Simplify[sigmaR - (Sqrt[r] + 1/Sqrt[r] - 2)] === 0]];

(* ---------------------------------------------------------------------------
   Test 4: SIS total magnification and flux ratio (eq. sis_mu_r).
   SIS image magnifications mu_pm = 1 +/- thetaE/beta = 1 +/- 1/y.
   For y<1: mu = |mu_+| + |mu_-| = 2/y ; r = |mu_+|/|mu_-| = (1+y)/(1-y).
   --------------------------------------------------------------------------- *)
ClearAll[yv];
muSISplus = 1 + 1/yv;               (* > 0 *)
muSISminusAbs = 1/yv - 1;           (* |1 - 1/yv| for 0<yv<1 *)
AppendTo[results,
  check["SIS: total magnification mu = 2/y",
        Simplify[(muSISplus + muSISminusAbs) - 2/yv] === 0]];
AppendTo[results,
  check["SIS: flux ratio r = (1+y)/(1-y)",
        Simplify[muSISplus/muSISminusAbs - (1 + yv)/(1 - yv)] === 0]];

(* ---------------------------------------------------------------------------
   Test 5: magnification bias null at beta = 1 (eqs. 108-111).
   For locally constant mu, N(>S) = (1/mu) N0(>S/mu) with N0 = A S^-beta.
   At beta = 1 this returns N0(>S) exactly.
   --------------------------------------------------------------------------- *)
ClearAll[A, S, beta, muc];
N0[s_] := A s^(-beta);
Nlensed = (1/muc) N0[S/muc];
AppendTo[results,
  check["Mag bias: N(>S) = A S^-beta muc^(beta-1) for constant mu",
        Simplify[Nlensed - A S^(-beta) muc^(beta - 1),
                 Assumptions -> {S > 0, muc > 0}] === 0]];
AppendTo[results,
  check["Mag bias: counts unchanged at beta = 1 (any mu)",
        Simplify[(Nlensed - N0[S]) /. beta -> 1,
                 Assumptions -> {S > 0, muc > 0}] === 0]];

(* ---------------------------------------------------------------------------
   Test 6: SIS combined cross-section (eq. sis_cross_full; cf. Schneider
   2006 Part 1 eq. 101).  Integrate directly over the source plane:
     sigma/(pi thetaE^2) = Integral 2y dy over {y<1, 2/y>mu, (1+y)/(1-y)<r}
   and compare with [Min((r-1)/(r+1), 2/mu)]^2 on a grid that includes
   thresholds mu < 2.  The book's printed extra factor H(mu-2) would give
   0 for mu < 2; the direct integral shows it must be absent.
   --------------------------------------------------------------------------- *)
ClearAll[yy, m, rr];
sigSISdirect[m_, rr_] := Integrate[
   2 yy Boole[0 < yy < 1 && 2/yy > m && (1 + yy)/(1 - yy) < rr], {yy, 0, 1}];
sigSISform[m_, rr_] := Min[(rr - 1)/(rr + 1), 2/m]^2;
grid = Tuples[{{1/2, 1, 3/2, 2, 3, 5, 10}, {11/10, 3/2, 3, 5, 20}}];
directVals = sigSISdirect @@@ grid;
AppendTo[results,
  check["SIS: sigma(r,mu)/(pi thetaE^2) = Min[(r-1)/(r+1),2/mu]^2 (direct integral, 35 grid pts incl. mu<2)",
        And @@ MapThread[Simplify[#1 - sigSISform @@ #2] === 0 &, {directVals, grid}]]];
(* Document the source-book factor explicitly: at mu=3/2, r=3 the true
   cross-section is 1/4, while H(mu-2) would force 0. *)
AppendTo[results,
  check["SIS: direct sigma(mu=3/2, r=3) = 1/4 > 0  (so no H(mu-2) factor)",
        sigSISdirect[3/2, 3] === 1/4]];

(* ---------------------------------------------------------------------------
   Test 7: optical depth, proper -> comoving form (eqs. 106 -> 107).
   D_ang = f_K/(1+z), dr_prop = dw/(1+z), n = (1+z)^3 n_com  =>
   D_ang^2 (dr_prop/dw) n = f_K^2 n_com.
   --------------------------------------------------------------------------- *)
ClearAll[z, fK, ncom];
AppendTo[results,
  check["Optical depth: D_ang^2 (dr_prop/dw) n = f_K^2 n_com",
        Simplify[(fK/(1 + z))^2 (1/(1 + z)) (1 + z)^3 ncom - fK^2 ncom] === 0]];

(* ---------------------------------------------------------------------------
   Test 8: the SIS optical-depth volume factor is larger with Omega_Lambda.
   Flat universe, fixed comoving density, sigma ~ (D_ds/D_s)^2 ~ ((ws-w)/ws)^2,
   tau ~ Integral f_K^2 ((ws-w)/ws)^2 dw  (units c/H0).  z_s = 2.
   Ratio (Omega_m, Omega_L) = (0.3, 0.7) vs (1, 0) quoted as "about three
   times" in the text; independent Python/scipy recompute gave 2.93.
   --------------------------------------------------------------------------- *)
tauSIS[om_, zs_] := Module[{w, ws, ez},
   ez[x_] := Sqrt[om (1 + x)^3 + 1 - om];
   w[zz_?NumericQ] := NIntegrate[1/ez[x], {x, 0, zz}];
   ws = w[zs];
   NIntegrate[w[zz]^2 ((ws - w[zz])/ws)^2/ez[zz], {zz, 0, zs}]];
tauRatio = tauSIS[0.3, 2]/tauSIS[1.0, 2];
Print["    tau(0.3,0.7)/tau(1,0) at z_s=2: ", ToString[NumberForm[tauRatio, 4]]];
AppendTo[results,
  check["Optical depth: Lambda volume factor ~3x (flat 0.3/0.7 vs EdS, z_s=2)",
        2.8 < tauRatio < 3.1]];

(* ---------------------------------------------------------------------------
   Figure: point-mass cross-section y^2(mu) vs mu, with the mu^-2 asymptote.
   --------------------------------------------------------------------------- *)
Print[""];
Print["--- Generating figure ---"];
figDir = FileNameJoin[{
   ParentDirectory[ParentDirectory[DirectoryName[$InputFileName]]],
   "Figures", "11_Lensing_Statistics"}];
If[! DirectoryQ[figDir], CreateDirectory[figDir, CreateIntermediateDirectories -> True]];
y2fun[m_] := 2 (m/Sqrt[m^2 - 1] - 1);
fig = LogLogPlot[{y2fun[m], 1/m^2}, {m, 1.01, 100},
   PlotStyle -> {{Thick, RGBColor[0.8, 0.1, 0.1]}, {Dashed, Gray}},
   PlotLegends -> {"y^2(mu_p)", "1/mu_p^2"},
   AxesLabel -> {"mu_p", "sigma/(pi thetaE^2)"},
   PlotLabel -> "Point-mass magnification cross-section",
   ImageSize -> 480];
outfile = FileNameJoin[{figDir, "point_mass_cross_section.pdf"}];
Export[outfile, fig];
Print["  Exported: ", outfile];

Print[""];
npass = Count[results, True]; ntot = Length[results];
Print["=== ", npass, "/", ntot, " statistics checks passed ==="];
If[npass === ntot,
  Print["ALL MODULE-11 CHECKS PASS"],
  Print["*** SOME CHECKS FAILED ***"]; Exit[1]];
Print["=== End of Module 11 verification ==="];
