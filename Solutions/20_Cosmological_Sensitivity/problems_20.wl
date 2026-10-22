(* =========================================================================
   problems_20.wl
   Module 20: Cosmological Sensitivity of Compound-Lens Ratios - SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to the Problems of Chapter 20, verified
            symbolically and numerically.  Angular-diameter distances are
            computed IN-SCRIPT from the flat CPL Friedmann equation (no
            external cosmology code), as in
            Solutions/03_Cosmological_Distances/problems_03.wl.

   Sources: Chapter 7 (flat-universe D_A and D_ds);
            CPL w(a) = w0 + wa (1 - a);
            Collett et al. (2012) for the DSPL ratio as a w probe.

   Usage:   bash Mathematica/run_wl.sh \
              Solutions/20_Cosmological_Sensitivity/problems_20.wl

   Exercises solved:
     20.1 (ex:cs_cpl)        - the CPL dark-energy density
     20.2 (ex:cs_projection) - the bias ray and its projections
     20.3 (ex:cs_rank)       - rank of the single-pair constraint
     20.4 (ex:cs_coherence)  - coherent per-plane central-mass fractions
     20.5 (ex:cs_nonlinear)  - why a masked span is not a Delta w
     20.6 (ex:cs_design)     - survey design (conceptual; one check)
     20.7 (ex:cs_newgeom)    - the Jacobian at a second geometry
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                  "Mathematica", "harness.wl"}]];
Print["=== Module 20: SOLUTIONS ===\n"];

near[a_, b_, tol_] := TrueQ[Abs[N[a, 30] - N[b, 30]] <= tol];

(* ---- in-script cosmology (flat CPL), distances in units of c/H0 ---- *)
zetaS[z_, w0_, wa_] := (1 + z)^(3 (1 + w0 + wa)) Exp[-3 wa z/(1 + z)];
Hz[z_, om_, w0_, wa_] := Sqrt[om (1 + z)^3 + (1 - om) zetaS[z, w0, wa]];
chiS[z_?NumericQ, om_?NumericQ, w0_?NumericQ, wa_?NumericQ] :=
  NIntegrate[1/Hz[y, om, w0, wa], {y, 0, z}, WorkingPrecision -> 30, PrecisionGoal -> 18];
DAs[z1_, z2_, p__] := (chiS[z2, p] - chiS[z1, p])/(1 + z2);       (* Ch. 7 Dds_flat *)
Bs[{zl_, z1_, z2_}, p_List] := (DAs[zl, z1, Sequence @@ p] DAs[0, z2, Sequence @@ p])/
                               (DAs[0, z1, Sequence @@ p] DAs[zl, z2, Sequence @@ p]);
jac[geo_, p0_] := Module[{f, h = 1/1000},
  f[hh_] := Table[(Log[Bs[geo, p0 + hh UnitVector[3, j]]] -
                   Log[Bs[geo, p0 - hh UnitVector[3, j]]])/(2 hh), {j, 3}];
  (4 f[h/2] - f[h])/3];                                            (* Richardson *)

p0 = {3/10, -1, 0};
geoI = {1/2, 1, 2};                 (* illustrative geometry of the chapter *)
JI = jac[geoI, p0];
{SOm, Sw, Swa} = JI;
Print["  J(0.5;1,2) = ", N[JI, 8]];
check["0a  J at the illustrative geometry: (-0.03569, -0.03301, -0.007255)",
  near[SOm, -0.035690, 5*^-6] && near[Sw, -0.033011, 5*^-6] && near[Swa, -0.0072552, 5*^-7]];

(* ===================================================================== *)
Print["\n--- Exercise 20.1: CPL density ---"];
Clear[z, zp, w0, wa];
check["1a  zeta = exp[3 Int (1+w0+wa z'/(1+z'))/(1+z') dz'] = CPL closed form",
  FullSimplify[Exp[3 Integrate[(1 + w0 + wa zp/(1 + zp))/(1 + zp), {zp, 0, z},
      Assumptions -> z > 0]]/zetaS[z, w0, wa], Assumptions -> z > 0] === 1];
check["1b  zeta(z) -> e^(-3 wa) (1+z)^(3(1+w0+wa)) as z -> infinity (w -> w0 + wa)",
  Limit[zetaS[z, w0, wa]/((1 + z)^(3 (1 + w0 + wa)) Exp[-3 wa]), z -> Infinity] === 1];
zeta1 = zetaS[1, -9/10, -3/10];
check["1c  zeta(1; w0=-0.9, wa=-0.3) = 2^(-0.6) e^(0.45) = 1.0347",
  near[zeta1, 1.03469, 5*^-5]];
check["1f  (w0,wa)=(-0.9,-0.3): w crosses -1 at z = 0.5; zeta(1) is 3.5% above zeta(0)",
  (Solve[-9/10 - 3/10 zz/(1 + zz) == -1, zz] === {{zz -> 1/2}}) && near[zeta1 - 1, 0.0347, 0.0005]];
check["1d  z/(1+z) <= 1/2 for z <= 1 and <= 2/3 for z <= 2 (monotone increasing)",
  Reduce[ForAll[z, 0 <= z <= 1, z/(1 + z) <= 1/2]] === True &&
  Reduce[ForAll[z, 0 <= z <= 2, z/(1 + z) <= 2/3]] === True];
check["1e  wa enters w(z) through z/(1+z) <= 1/2 for z <= 1: |S_wa/S_w0| = 0.22 here",
  near[Swa/Sw, 0.2198, 0.0005]];

(* ===================================================================== *)
Print["\n--- Exercise 20.2: projections ---"];
Clear[jo, jw, del, cc, uo, uw];
dp = del/({jo, jw} . {uo, uw}) {uo, uw};
check["2a  ray solves J.Delta p = delta; u = e_w0 gives Delta w0 = delta/S_w",
  Simplify[{jo, jw} . dp - del] === 0 && Simplify[(dp /. {uo -> 0, uw -> 1}) - {0, del/jw}] === {0, 0}];
check["2b  u = (c,1): Delta w0 = delta/(S_w + c S_Om)",
  Simplify[(dp /. {uo -> cc, uw -> 1})[[2]] - del/(jw + cc jo)] === 0];
d1 = 1/100;
check["2c  delta = 1%: 0.303 (fixed Om), 0.197 (c=+1/2), 0.659 (c=-1/2)",
  near[Abs[d1/Sw], 0.3029, 0.0005] && near[Abs[d1/(Sw + SOm/2)], 0.1966, 0.0005] &&
  near[Abs[d1/(Sw - SOm/2)], 0.6592, 0.0005]];
cStar = -Sw/SOm;
check["2d  c* = -0.925; lower-bound interval [2c*, 0] = [-1.850, 0]",
  near[cStar, -0.92496, 5*^-5] && near[2 cStar, -1.84992, 1*^-4]];
check["2e  at c = 2c* the bias equals the fixed-Om value (in magnitude); beyond it, smaller",
  near[Abs[d1/(Sw + 2 cStar SOm)], Abs[d1/Sw], 1*^-12] &&
  Abs[d1/(Sw + (2 cStar - 1/10) SOm)] < Abs[d1/Sw]];

(* ===================================================================== *)
Print["\n--- Exercise 20.3: rank ---"];
Clear[ja];
check["3a  1 x 2 and 1 x 3 rows: J^T J has rank 1",
  MatrixRank[{{jo}, {jw}} . {{jo, jw}}] === 1 && MatrixRank[{{jo}, {jw}, {ja}} . {{jo, jw, ja}}] === 1];
nvec = {Sw, -SOm};
angN = ArcTan[nvec[[1]], nvec[[2]]] 180/Pi;
Print["  null direction angle from +Om axis = ", N[angN, 6]];
check["3b  null direction (S_w, -S_Om) at 132.8 deg from the +Om axis (slope dw0/dOm = -1.081)",
  near[angN, 132.77, 0.02] && near[-SOm/Sw, -1.0811, 0.0005]];
(* a time delay in the same system: D_dt = (1+z_l) D_l D_s / D_ls (Ch. 10); its log-gradient
   in (Om, w0) at fixed H0 points in a different direction -> rank 2 *)
lnDdt[p_List, {zl_, zs_}] := Log[(1 + zl) DAs[0, zl, Sequence @@ p] DAs[0, zs, Sequence @@ p]/
                                  DAs[zl, zs, Sequence @@ p]];
Jdt = Table[(lnDdt[p0 + 1/1000 UnitVector[3, j], {1/2, 1}] -
             lnDdt[p0 - 1/1000 UnitVector[3, j], {1/2, 1}])/(2/1000), {j, 2}];
Print["  dlnD_dt/d(Om,w0) at (0.5;1) = ", N[Jdt, 6]];
angDt = ArcCos[Abs[Jdt . JI[[1 ;; 2]]]/(Norm[Jdt] Norm[JI[[1 ;; 2]]])] 180/Pi;
Print["  angle between B-row and D_dt-row = ", N[angDt, 5]];
check["3c  time-delay row (-0.0174, -0.1043) at 38 deg to the B row: (Om,w0) rank 2",
  MatrixRank[N[{JI[[1 ;; 2]], Jdt}, 20], Tolerance -> 1*^-8] === 2 &&
  near[Jdt[[1]], -0.0174, 5*^-5] && near[Jdt[[2]], -0.1043, 5*^-5] && near[angDt, 37.8, 0.1]];

(* ===================================================================== *)
Print["\n--- Exercise 20.4: coherence ---"];
g = 16/10; ex = (3 - g)/(g - 1);
check["4a  exponent (3-g')/(g'-1) = 7/3 at g' = 1.6", ex === 7/3];
check["4b  m2/m1 = 0.7^(7/3) = 0.43507; m3/m1 = 0.5^(7/3) = 0.19843",
  near[0.7^ex, 0.435073, 1*^-6] && near[0.5^ex, 0.198425, 1*^-6]];
check["4c  0 < m3/m1 < m2/m1 < 1: same sign, monotone in B",
  0 < 0.5^ex < 0.7^ex < 1];
Clear[b1, b2, w1, w2];
check["4d  GLS bias is a convex combination: lies between per-plane biases b1, b2",
  Reduce[ForAll[{b1, b2, w1, w2}, w1 > 0 && w2 > 0 && b1 < b2,
     b1 <= (w1 b1 + w2 b2)/(w1 + w2) <= b2], Reals] === True];

(* ===================================================================== *)
Print["\n--- Exercise 20.5: non-linearity ---"];
check["5a  naive |0.25/S_w| = 7.57 at the illustrative geometry", near[Abs[0.25/Sw], 7.573, 0.005]];
fB[om_?NumericQ, w_?NumericQ] := N[Bs[geoI, {om, w, 0}]/Bs[geoI, p0] - 1, 15];
gridB = Flatten[Table[fB[om, w], {om, 0.2, 0.4, 0.05}, {w, -2.5, -0.5, 0.25}]];
Print["  B/B0-1 range over the box: ", N[{Min[gridB], Max[gridB]}, 4]];
check["5b  box Om in [0.2,0.4], w0 in [-2.5,-0.5]: B/B0-1 in [-1.7%, +3.3%]; 25% is ~8x outside",
  near[Min[gridB], -0.0174, 0.0001] && near[Max[gridB], 0.0330, 0.0001] &&
  0.25 > 7 Max[Abs[gridB]]];

(* ===================================================================== *)
Print["\n--- Exercise 20.6: design (conceptual) ---"];
Clear[nn, s1];
check["6a  N lenses with a SHARED systematic s: mean bias s for all N (no 1/sqrt N)",
  Simplify[Sum[s1, {k, 1, nn}]/nn] === s1];

(* ===================================================================== *)
Print["\n--- Exercise 20.7: a second geometry ---"];
geoII = {3/10, 8/10, 3};
JII = jac[geoII, p0];
BII = Bs[geoII, p0];
Print["  B(0.3;0.8,3) = ", N[BII, 8], "   J = ", N[JII, 8], "   c* = ", N[-JII[[2]]/JII[[1]], 6]];
check["7a  B(0.3; 0.8, 3) = 0.7038",
  near[BII, 0.7038, 5*^-5]];
check["7b  J(0.3; 0.8, 3) = (-0.03960, -0.04086, -0.007386)",
  near[JII[[1]], -0.03960, 1*^-5] && near[JII[[2]], -0.04086, 1*^-5] && near[JII[[3]], -0.007386, 1*^-6]];
check["7c  c* differs between geometries (-1.032 vs -0.925): the blind direction is geometric",
  near[-JII[[2]]/JII[[1]], -1.0317, 0.0005] && Abs[(-JII[[2]]/JII[[1]]) - cStar] > 0.1];

check["7d  S_w0 at (0.3;0.8,3) is 24% larger than at (0.5;1,2)",
  near[JII[[2]]/Sw, 1.238, 0.002]];

summary[];
