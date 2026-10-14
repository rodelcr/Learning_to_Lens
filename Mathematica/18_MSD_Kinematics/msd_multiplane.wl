(* =========================================================================
   msd_multiplane.wl
   Module 18: The Mass-Sheet Degeneracy in Multi-Plane Lenses and
              Kinematic Breaking
   =========================================================================
   Purpose: Deterministic verification of every derivation in
            Notes/18_MSD_Kinematics/18_MSD_Kinematics.tex:
              A. single-plane MST: positions (general, SIS + sheet,
                 power law + sheet), Jacobian/eigenvalues, flux ratios,
                 Einstein radius, Fermat potential, time delays, H0
                 (sign convention of Module 9, eq:mst_H0);
              B. one deflector, two source planes: a physical sheet with
                 KNOWN distances is not an MST on both planes (theta_E1
                 moves, eta moves); with the distance ratio FREE, per-plane
                 MSTs with lambda_1 != lambda_2 leave both image sets and
                 eta invariant and shift the inferred distance ratio;
                 the two-lens-plane MST of Schneider (2014, A&A 568, L2),
                 eqs. (6)-(11) and (18)-(20), incl. the sign alternation;
              C. the "local MST": to first order about theta_E an MST of a
                 power law equals a slope change gamma'-1 -> lambda(gamma'-1);
                 the second-order MST invariant xi; time delays of a power
                 law ~ (gamma'-1)(thA^2 - thB^2)/2;
              D. kinematics: SIS exact (sigma^2 -> lambda sigma^2),
                 spherical Jeans for a power-law mass + power-law tracer
                 with constant anisotropy (sigma_r^2, LOS projection,
                 aperture average), the normalisation F(gamma', nu, beta),
                 Delta lambda/lambda = 2 Delta sigma/sigma, anisotropy and
                 aperture systematics, internal (cored) vs external sheet.
            Figure: kappa profiles of a power law under three lambda values
            with the fixed image positions marked.

   Sources: Falco, Gorenstein & Shapiro (1985) -- the MST
            Schneider (2014), A&A 568, L2 -- two-plane MST (read from
              arXiv:1406.6152v2; eqs. 4-11, 14-20 checked against the PDF)
            Schneider (2019), A&A 624, A54 (arXiv:1409.0015) -- generalized
              multi-plane MST, alternating scalings (Sect. 4.3)
            Congdon & Keeton (2018) Sect. 4.7.2; Meneghetti (2021) Sect. 5.9,
              eqs. 5.146-5.150; Saha et al. (2024) Sect. 3.7, eq. 51
            Binney & Tremaine-style spherical Jeans equation (derived here)

   Usage:   bash Mathematica/run_wl.sh Mathematica/18_MSD_Kinematics/msd_multiplane.wl

   Outputs: PASS/FAIL per check + SUMMARY line;
            Figures/18_MSD_Kinematics/msd_powerlaw_kappa.pdf
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "harness.wl"}]];
Print["=== Module 18: MSD in multi-plane lenses and kinematic breaking ===\n"];

figDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Figures",
                       "18_MSD_Kinematics"}];
If[!DirectoryQ[figDir], CreateDirectory[figDir, CreateIntermediateDirectories -> True]];

zeroQ[x_List] := And @@ (zeroQ /@ Flatten[x]);
zeroQ[x_] := TrueQ[FullSimplify[x] == 0];

(* ===================================================================== *)
Print["--- A. Single-plane MST ---"];
(* ===================================================================== *)
Clear[lam, th1, th2, a1, a2, b1, b2];
thV = {th1, th2}; alV = {a1, a2};
betaV = thV - alV;
alLam = lam alV + (1 - lam) thV;
check["s1  alpha_lam = lam alpha + (1-lam) theta  =>  theta - alpha_lam = lam beta",
  zeroQ[(thV - alLam) - lam betaV]];

(* a uniform sheet kappa0 deflects as kappa0 theta (axisymmetric: alpha = <kappa> theta) *)
Clear[k0, t];
check["s2  sheet: alpha(theta) = <kappa> theta = kappa0 theta; div alpha = 2 kappa0",
  zeroQ[(1/t) Integrate[2 k0 tp, {tp, 0, t}] - k0 t] &&
  zeroQ[D[k0 th1, th1] + D[k0 th2, th2] - 2 k0]];

(* SIS + sheet, 1-D: alpha = thE Sign[theta] *)
Clear[thE, b];
sisImgs = {b + thE, b - thE};               (* images for 0 < b < thE *)
alSIS[x_] := thE Sign[x];
alSISlam[x_] := lam thE Sign[x] + (1 - lam) x;
check["s3  SIS + sheet: images b +- thE solve theta - alpha_lam = lam b (0<b<thE)",
  And @@ (TrueQ[FullSimplify[(# - alSISlam[#]) - lam b,
            Assumptions -> {0 < b < thE, lam > 0}] == 0] & /@ sisImgs)];

(* power law + sheet, 1-D, symbolic identity *)
Clear[gp, x];
alPL[x_, g_] := thE Sign[x] (Abs[x]/thE)^(2 - g);
alPLlam[x_, g_] := lam alPL[x, g] + (1 - lam) x;
check["s4  power law: theta - alpha_lam(theta) - lam b == lam (theta - alpha(theta) - b) identically",
  zeroQ[(x - alPLlam[x, gp] - lam b) - lam (x - alPL[x, gp] - b)]];

(* numerical root comparison for a concrete power law *)
Module[{g = 22/10, bb = 2/10, rootsOrig, rootsLam, ok = True},
  rootsOrig = {x /. FindRoot[x - alPL[x, g] == bb /. thE -> 1, {x, 1.2}, WorkingPrecision -> 30],
               x /. FindRoot[x - alPL[x, g] == bb /. thE -> 1, {x, -0.8}, WorkingPrecision -> 30]};
  Do[
    rootsLam = {x /. FindRoot[x - alPLlam[x, g] == l bb /. {thE -> 1, lam -> l}, {x, 1.2}, WorkingPrecision -> 30],
                x /. FindRoot[x - alPLlam[x, g] == l bb /. {thE -> 1, lam -> l}, {x, -0.8}, WorkingPrecision -> 30]};
    ok = ok && Max[Abs[rootsLam - rootsOrig]] < 10^-20,
    {l, {7/10, 9/10, 12/10}}];
  Print["      gamma'=2.2, beta=0.2 thE: images ", N[rootsOrig, 8]];
  check["s5  power law (gamma'=2.2, beta=0.2): FindRoot images identical for lam = 0.7, 0.9, 1.2", ok]];

(* Jacobian, eigenvalues, magnification, flux ratios *)
Clear[pxx, pyy, pxy, qxx, qyy, qxy];
Amat = {{1 - pxx, -pxy}, {-pxy, 1 - pyy}};
AmatLam = {{1 - (lam pxx + (1 - lam)), -lam pxy}, {-lam pxy, 1 - (lam pyy + (1 - lam))}};
check["s6  A_lam = lam A", zeroQ[Flatten[AmatLam - lam Amat]] ];
check["s7  det A_lam = lam^2 det A", zeroQ[Det[AmatLam] - lam^2 Det[Amat]]];
check["s8  eigenvalues 1-kappa+-gamma scale by lam (critical curves invariant)",
  zeroQ[(CharacteristicPolynomial[AmatLam, mu]) - lam^2 (CharacteristicPolynomial[Amat, mu] /. mu -> mu/lam)] ];
Bmat = {{1 - qxx, -qxy}, {-qxy, 1 - qyy}};
check["s9  flux ratio mu1/mu2 invariant (lam^-2 cancels)",
  zeroQ[(1/Det[lam Amat])/(1/Det[lam Bmat]) - (1/Det[Amat])/(1/Det[Bmat])]];

(* Einstein radius of a power law is invariant: <kappa_lam>(thE) = 1 *)
meanKPL[x_, g_] := (thE/x)^(g - 1);
check["s10 <kappa_lam>(theta) = lam <kappa> + 1 - lam equals 1 at theta = thE (theta_E invariant)",
  zeroQ[(lam meanKPL[x, gp] + 1 - lam - 1) /. x -> thE]];
check["s11 power-law kappa = (3-g)/2 (thE/theta)^(g-1) has <kappa> = (thE/theta)^(g-1)",
  TrueQ[FullSimplify[(2/x^2) Integrate[(3 - gp)/2 (thE/s)^(gp - 1) s, {s, 0, x},
     Assumptions -> {1 < gp < 3, x > 0, thE > 0}] - meanKPL[x, gp],
     Assumptions -> {1 < gp < 3, x > 0, thE > 0}] == 0]];

(* Fermat potential and delays *)
Clear[f, X, Y, bx, by];
fermat = ((X - bx)^2 + (Y - by)^2)/2 - f[X, Y];
fermatL = ((X - lam bx)^2 + (Y - lam by)^2)/2 - (lam f[X, Y] + (1 - lam) (X^2 + Y^2)/2);
check["s12 tau_lam - lam tau = lam(lam-1)|beta|^2/2 (theta-independent)",
  zeroQ[fermatL - lam fermat - lam (lam - 1) (bx^2 + by^2)/2]];
Module[{tA, tB},
  tA = fermat /. {X -> xa, Y -> ya}; tB = fermat /. {X -> xb, Y -> yb};
  check["s13 Delta tau_lam = lam Delta tau  =>  Delta t_lam = lam Delta t",
    zeroQ[((fermatL /. {X -> xa, Y -> ya}) - (fermatL /. {X -> xb, Y -> yb})) - lam (tA - tB)]]];
(* H0 bookkeeping: Delta t_obs = (Ddt(H0)/c) Delta tau, Ddt = K/H0 *)
Clear[Kc, dtObs, dtau];
H0from[dtauModel_] := Kc dtauModel/dtObs;        (* H0 = K dtau / dt_obs *)
check["s14 eq:mst_H0 convention: H0(true, sheet lam) = lam H0(naive, lam=1)",
  zeroQ[H0from[lam dtau] - lam H0from[dtau]]];

(* ===================================================================== *)
Print["\n--- B. One deflector, two source planes ---"];
(* ===================================================================== *)
(* kappa_i = Sigma / Sigma_cr,i ; Brat = Sigma_cr2/Sigma_cr1 = kappa_1/kappa_2 < 1
   (plane 1 = nearer source, plane 2 = farther source). *)
Clear[lm, Ss, Sc1, Sc2, Br, l1, l2];
(* B1 physical transformation Sigma -> lm Sigma + Ss; is it an MST on BOTH planes? *)
solB1 = Solve[{lm == l1, Ss/Sc1 == 1 - l1, lm == l2, Ss/Sc2 == 1 - l2}, {lm, Ss, l1, l2}];
check["t1  physical rescale+sheet is an MST on both planes only if lm = 1 (Sc1 != Sc2)",
  AllTrue[solB1, TrueQ[Simplify[(lm /. #) == 1, Sc1 != Sc2]] &]];
Print["      solutions: ", solB1];

(* B2 known distances: MST lam2 on far plane induces kappa_1' = lam2 kappa_1 + Br(1-lam2) *)
Clear[k1];
k1prime = l2 k1 + Br (1 - l2);
check["t2a far-plane MST induces near-plane kappa_1' = lam2 kappa_1 + Brat(1-lam2)",
  zeroQ[Br (l2 (k1/Br) + (1 - l2)) - k1prime]];
(* near-plane lens equation is NOT a uniform rescaling unless lam2=1 or Br=1 *)
check["t2b near-plane: theta - alpha_1' = (1 - Br(1-lam2)) theta - lam2 alpha_1 (not prop. to theta-alpha_1)",
  zeroQ[(x - (l2 a1 + Br (1 - l2) x)) - ((1 - Br (1 - l2)) x - l2 a1)] &&
  Solve[{1 - Br (1 - l2) == l2, Br != 1}, l2] === {{l2 -> 1}}];
(* power law: theta_E1 moves by (lam2/(1 - Br(1-lam2)))^(1/(g-1)) *)
Clear[tE1];
sol = Solve[l2 (tE1/y)^(gp - 1) + Br (1 - l2) == 1, y];
ratioE1 = (l2/(1 - Br (1 - l2)))^(1/(gp - 1));
check["t2c power law, known distances: theta_E1'/theta_E1 = [lam2/(1-Brat(1-lam2))]^(1/(g'-1))",
  TrueQ[FullSimplify[(l2 (1/ratioE1)^(gp - 1) + Br (1 - l2)) == 1,
     Assumptions -> {0 < Br < 1, 0 < l2, 1 < gp < 3, 1 - Br (1 - l2) > 0}]]];
Module[{v = ratioE1 /. {gp -> 2, Br -> 7/10, l2 -> 9/10}},
  Print["      e.g. g'=2, Brat=0.7, lam2=0.9: theta_E1'/theta_E1 = ", N[v, 6],
        "  => eta'/eta = ", N[v, 6], " (theta_E2 unchanged)"];
  check["t2d example g'=2, Brat=0.7, lam2=0.9: theta_E1 moves by 0.9/0.93 = 0.967742",
    v == 90/93 && Abs[N[v] - 0.967742] < 10^-6]];

(* B3 distance ratio FREE: model with Br' ; per-plane MSTs lam1 (near), lam2 (far) *)
Clear[Brp];
solB3 = Solve[{l1 == l2 Brp/Br, 1 - l1 == Brp (1 - l2)}, {Brp, l1}];
BrpSol = Brp /. First[solB3]; l1Sol = l1 /. First[solB3];
check["t3a free ratio: Brat' = 1/(1 - lam2 + lam2/Brat)",
  zeroQ[BrpSol - 1/(1 - l2 + l2/Br)]];
check["t3b free ratio: lam1 = lam2/(Brat(1-lam2) + lam2)",
  zeroQ[l1Sol - l2/(Br (1 - l2) + l2)]];
(* both planes: model kappa_1 = Br' kappa_2' with kappa_2' = lam2 kappa_2 + 1 - lam2 equals MST lam1 of kappa_1 = Br kappa_2 *)
Clear[k2];
check["t3c with Brat', Brat' kappa_2' == lam1 kappa_1 + (1 - lam1) for every kappa_2 (exact MST on plane 1)",
  zeroQ[(BrpSol (l2 k2 + 1 - l2)) - (l1Sol (Br k2) + 1 - l1Sol)]];
check["t3d lam1 - lam2 = lam2(1-lam2)(1-Brat)/(Brat(1-lam2)+lam2): equal only if lam2 = 1 (DIFFERENT lambdas)",
  zeroQ[(l1Sol - l2) - l2 (1 - l2) (1 - Br)/(Br (1 - l2) + l2)]];
check["t3e eta = thE1/thE2 invariant: each plane's <kappa_i>=1 radius is fixed by its own MST",
  zeroQ[(l1 meanKPL[x, gp] + 1 - l1 - 1) /. x -> thE] && zeroQ[(l2 meanKPL[x, gp] + 1 - l2 - 1) /. x -> thE]];
Module[{v = {BrpSol, l1Sol} /. {Br -> 7/10, l2 -> 9/10}},
  Print["      e.g. Brat=0.7, lam2=0.9: Brat' = ", N[v[[1]], 6], ", lam1 = ", N[v[[2]], 6]];
  check["t3f example Brat=0.7, lam2=0.9: Brat' = 70/97 = 0.721649, lam1 = 90/97 = 0.927835",
    v == {70/97, 90/97}]];
(* first order: d ln Brat'/d lam2 at lam2 = 1 *)
check["t3g first order: Brat' ~ Brat [1 + (1-Brat)(1-lam2)]  (d Brat'/d lam2 |_1 = -Brat(1-Brat))",
  zeroQ[(D[BrpSol, l2] /. l2 -> 1) + Br (1 - Br)]];
(* power-law reading: Brat = eta^(g-1); at fixed eta a Brat shift needs a slope shift *)
Clear[eta];
check["t3i sheet ratio (1-lam1)/(1-lam2) = Brat': the two per-plane sheets are ONE physical sheet at z_d, seen through the model's distance ratio",
  zeroQ[(1 - l1Sol)/(1 - l2) - BrpSol]];
check["t3h Brat = eta^(g'-1): dBrat/dlam = 0 at fixed (eta, g'); dBrat/dg' = Brat ln eta",
  D[eta^(gp - 1), lam] === 0 && zeroQ[D[eta^(gp - 1), gp] - eta^(gp - 1) Log[eta]]];

(* B4 Schneider (2014, A&A 568, L2): two LENS planes (mass at z2), eqs. (5)-(11) *)
Clear[A1, A2, be, nu3, K2, th, t2];
(* 1-D components are enough: equations are linear in the unknown functions *)
th2orig = th - be A1;                           (* eq. 5a, A1 = alpha_1(theta) *)
th3orig = th - A1 - A2;                         (* eq. 5b, A2 = alpha_2(theta_2) *)
alpha1p = lam A1 + (1 - lam)/be th;            (* eq. 6 *)
th2p = th - be alpha1p;
check["t4a Schneider14 eq.(7): theta_2' = lam theta_2",
  zeroQ[th2p - lam th2orig]];
(* eq. 10 ansatz: alpha_2'(theta_2') = nu3 A2 + K2 theta_2' with theta_2' = lam theta_2 *)
th3p = th - alpha1p - (nu3 A2 + K2 lam th2orig);
solS = Solve[Thread[CoefficientList[th3p - nu3 th3orig, {th, A1, A2}] == 0] // Flatten // DeleteDuplicates, {nu3, K2}];
check["t4b Schneider14 eq.(11): unique solution nu3 = 1, K2 = (lam-1)/(lam beta)",
  Length[solS] == 1 && zeroQ[(nu3 /. First[solS]) - 1] &&
  zeroQ[(K2 /. First[solS]) - (lam - 1)/(lam be)]];
check["t4c sign alternation: plane-1 sheet (1-lam)/beta and plane-2 sheet K2 have opposite signs",
  zeroQ[((1 - lam)/be) * ((lam - 1)/(lam be)) + (1 - lam)^2/(lam be^2)]];
(* eq. 13: alpha(theta/lam | kappa) = alpha(theta | lam^-1 kappa(theta/lam)) for a power law (scale+amp) *)
check["t4d Schneider14 eq.(13) for a power law: alpha_PL(theta/lam) = deflection of lam^-1 kappa(theta/lam)",
  Module[{kap, alFromK},
    kap[s_] := (3 - gp)/2 (thE/s)^(gp - 1);
    alFromK[y_, kk_] := (2/y) Integrate[kk[s] s, {s, 0, y}, Assumptions -> {1 < gp < 3, s > 0, y > 0, thE > 0, lam > 0}];
    TrueQ[FullSimplify[alPL[x/lam, gp] - alFromK[x, Function[s, kap[s/lam]/lam]],
       Assumptions -> {1 < gp < 3, x > 0, thE > 0, lam > 0}] == 0]]];
(* eqs. 18-20: change of cosmology beta -> beta' is MST-like *)
Clear[bp, nu2, K1];
th2pp = th - bp (lam A1 + K1 th);
solC1 = Solve[Thread[CoefficientList[th2pp - nu2 th2orig, {th, A1}] == 0] // Flatten // DeleteDuplicates, {nu2, K1}];
check["t4e Schneider14 eq.(18): nu2 = beta' lam/beta, K1 = 1/beta' - lam/beta",
  zeroQ[(nu2 /. First[solC1]) - bp lam/be] && zeroQ[(K1 /. First[solC1]) - (1/bp - lam/be)]];
nu2s = nu2 /. First[solC1]; K1s = K1 /. First[solC1];
th3pp = th - (lam A1 + K1s th) - (nu3 A2 + K2 nu2s th2orig);
solC2 = Solve[Thread[CoefficientList[th3pp - nu3 th3orig, {th, A1, A2}] == 0] // Flatten // DeleteDuplicates, {nu3, K2}];
check["t4f Schneider14 eq.(20): nu3 = (beta/beta')(1-beta')/(1-beta), K2 = (1/beta')[1 - nu3/lam]",
  zeroQ[(nu3 /. First[solC2]) - (be/bp) (1 - bp)/(1 - be)] &&
  zeroQ[(K2 /. First[solC2]) - (1/bp) (1 - (be/(lam bp)) (1 - bp)/(1 - be))]];
check["t4f2 Schneider14 NMS1: lam = beta/beta' gives K1 = 0, nu2 = 1, K2 = (beta'-beta)/(beta'(1-beta))",
  zeroQ[K1s /. lam -> be/bp] && zeroQ[(nu2s /. lam -> be/bp) - 1] &&
  zeroQ[(K2 /. First[solC2] /. lam -> be/bp) - (bp - be)/(bp (1 - be))]];
Print["      Schneider14 eq.20 K2 (Mathematica): ", FullSimplify[K2 /. First[solC2]]];
(* massless near source (single deflector): K2 = 0 => nu3 = lam and Brat' of B3a *)
check["t4g single-deflector limit (K2=0, alpha_2=0): nu3 = lam and 1/beta' = 1 - lam + lam/beta (= B3a)",
  Module[{s = Solve[{lam == nu3, 1 - K1s == nu3}, {nu3, bp}]},
    zeroQ[(bp /. First[s]) - 1/(1 - lam + lam/be)]]];

(* ===================================================================== *)
Print["\n--- C. Local MST: slope <-> sheet near theta_E ---"];
(* ===================================================================== *)
Clear[d, g2];
(* radial deflection near thE, theta = thE + d (theta > 0) *)
alPos[y_, g_] := thE (y/thE)^(2 - g);                 (* theta > 0 branch *)
alPosLam[y_, g_] := lam alPos[y, g] + (1 - lam) y;
serPL[g_] := Normal[Series[alPos[thE + d, g], {d, 0, 2}]] // PowerExpand // Simplify[#, thE > 0] &;
serLam = Normal[Series[alPosLam[thE + d, gp], {d, 0, 2}]] // PowerExpand // Simplify[#, thE > 0] &;
c0[e_] := Coefficient[Expand[e], d, 0]; cc1[e_] := Coefficient[Expand[e], d, 1]; cc2[e_] := Coefficient[Expand[e], d, 2];
g2val = 1 + lam (gp - 1);
check["l1  0th order: alpha_lam(thE) = alpha_PL(g2)(thE) = thE",
  zeroQ[c0[serLam] - thE] && zeroQ[c0[serPL[g2val]] - thE]];
check["l2  1st order: alpha_lam'(thE) = alpha_PL'(thE; g2) iff g2 - 1 = lam (g' - 1)",
  zeroQ[cc1[serLam] - cc1[serPL[g2val]]] &&
  zeroQ[cc1[serLam] - (1 - lam (gp - 1))]];
check["l3  2nd order differs: 2 thE (alpha''_lam - alpha''_PL(g2))/2 = lam (1-lam)(g'-1)^2, nonzero for lam != 1",
  Module[{diff = FullSimplify[2 thE (cc2[serLam] - cc2[serPL[g2val]])]},
    Print["      2 thE * (second-order coefficient difference) = ", diff];
    zeroQ[diff - lam (1 - lam) (gp - 1)^2] ]];
(* lens equation to first order: source rescaled by lam *)
check["l4  1st-order lens map: theta - alpha_PL(g2) == lam (theta - alpha_PL(g')) + O(d^2)",
  zeroQ[(c0[thE + d - serPL[g2val]] + cc1[thE + d - serPL[g2val]] d) -
        lam (c0[thE + d - serPL[gp]] + cc1[thE + d - serPL[gp]] d)]];
(* radial eigenvalue and kappa_E *)
check["l5  power law at thE: radial eigenvalue 1 - alpha' = g'-1; 1-kappa_E = (g'-1)/2; both x lam under MST",
  zeroQ[(1 - D[alPos[y, gp], y] /. y -> thE) - (gp - 1)] &&
  zeroQ[(1 - (3 - gp)/2) - (gp - 1)/2] &&
  zeroQ[(1 - D[alPosLam[y, gp], y] /. y -> thE) - lam (gp - 1)]];
(* MST invariant xi = thE alpha''(thE)/(1-kappa_E); power law: 2(g'-2) *)
xiOf[al_] := Module[{a2v, kE},
  a2v = D[al[y], {y, 2}] /. y -> thE;
  kE = (1/2) (al[y]/y + D[al[y], y]) /. y -> thE;
  FullSimplify[thE a2v/(1 - kE), Assumptions -> {thE > 0, 1 < gp < 3, lam > 0}]];
check["l6  xi = thE alpha''/(1-kappa_E) = 2(g'-2) for a power law, MST-invariant",
  zeroQ[xiOf[alPos[#, gp] &] - 2 (gp - 2)] && zeroQ[xiOf[alPosLam[#, gp] &] - 2 (gp - 2)]];
check["l7  so PL(g2) has xi = 2(g2-2) != 2(g'-2) unless lam=1 (second order breaks local equivalence)",
  zeroQ[xiOf[alPos[#, g2val] &] - 2 (g2val - 2)] &&
  Solve[2 (g2val - 2) == 2 (gp - 2) && gp != 1, lam] === {{lam -> 1}}];

(* time delays of a power law in terms of the images *)
psiPL[t_, g_] := Abs[t]^(3 - g)/(3 - g);          (* thE = 1 *)
alPL1[t_, g_] := Sign[t] Abs[t]^(2 - g);
tauPL[t_, bb_, g_] := (t - bb)^2/2 - psiPL[t, g];
Module[{res = {}},
  Do[Module[{tA, tB, bb = 1/200},
      tA = x /. FindRoot[x - alPL1[x, g] == bb, {x, 1.01}, WorkingPrecision -> 30];
      tB = x /. FindRoot[x - alPL1[x, g] == bb, {x, -0.99}, WorkingPrecision -> 30];
      AppendTo[res, {g, (tauPL[tB, bb, g] - tauPL[tA, bb, g])/((tA^2 - tB^2)/2), (tauPL[tB, bb, g] - tauPL[tA, bb, g])/(2 bb)}]],
    {g, {16/10, 2, 24/10}}];
  Print["      {g', Dtau/((thA^2-thB^2)/2), Dtau/(2 beta thE)} = ", N[res, 6]];
  check["l8  power law, beta = 0.005 thE: Delta tau = (g'-1)(thA^2-thB^2)/2 to < 1e-4 (g' = 1.6, 2, 2.4)",
    AllTrue[res, Abs[#[[2]] - (#[[1]] - 1)] < 10^-4 &]];
  check["l9  ... while Delta tau = 2 beta thE to < 1e-4 (the source position absorbs the slope)",
    AllTrue[res, Abs[#[[3]] - 1] < 10^-4 &]];
  check["l10 delay ratio at fixed images between slopes g2 = 1+lam(g'-1) and g' equals lam",
    Module[{l = (res[[1, 1]] - 1)/(res[[3, 1]] - 1)}, Abs[res[[1, 2]]/res[[3, 2]] - l] < 10^-3]]];

(* ===================================================================== *)
Print["\n--- D. Kinematics ---"];
(* ===================================================================== *)
Clear[sig, cc, Dd, Ds, Dds, GG, sv];
(* D1 SIS exact *)
thESIS[s_] := 4 Pi s^2/cc^2 Dds/Ds;
check["k1  SIS: lam kappa_SIS(thE) = kappa_SIS(lam thE)  and  thE prop sigma^2 => sigma'^2 = lam sigma^2",
  zeroQ[lam (thE/(2 x)) - (lam thE)/(2 x)] &&
  zeroQ[thESIS[Sqrt[lam] sv] - lam thESIS[sv]]];

(* D2 spherical Jeans, power-law mass, power-law tracer, constant anisotropy *)
Clear[Ms, rr, nu, ba, Atr, M0, r0];
Mr[r_] := M0 (r/r0)^(3 - gp);
rhoS[r_] := Atr r^(-nu);
sr2[r_] := GG Mr[r]/(r (nu + gp - 2 - 2 ba));
jeansRes = D[rhoS[rr] sr2[rr], rr] + 2 ba rhoS[rr] sr2[rr]/rr + rhoS[rr] GG Mr[rr]/rr^2;
check["k2  sigma_r^2 = G M(r) / [r (nu + g' - 2 - 2 beta_a)] solves d(rho* sr2)/dr + 2 beta_a rho* sr2/r = -rho* G M/r^2",
  zeroQ[Simplify[jeansRes, rr > 0]]];
check["k3  SIS + isothermal tracer, isotropic: sigma_r^2 = G M(r)/(2r) = sigma_SIS^2 (M = 2 sigma^2 r/G)",
  zeroQ[(sr2[rr] /. {gp -> 2, nu -> 2, ba -> 0, M0 -> 2 sv^2 r0/GG}) - sv^2]];

(* D4 projection along the line of sight: closed forms used in the text *)
projI[p_, R_] := Sqrt[Pi] R^(1 - p) Gamma[(p - 1)/2]/(2 Gamma[p/2]);   (* Int_R^Inf r^-p r dr/Sqrt[r^2-R^2] *)
check["k4  Int_R^Inf r^(1-p)/sqrt(r^2-R^2) dr = sqrt(pi) R^(1-p) Gamma((p-1)/2)/(2 Gamma(p/2)): numeric at p = 1.5, 2.3, 3.7, R=0.7",
  AllTrue[{3/2, 23/10, 37/10},
    Abs[NIntegrate[r^(1 - #)/Sqrt[r^2 - (7/10)^2], {r, 7/10, Infinity}, WorkingPrecision -> 25, PrecisionGoal -> 12] - N[projI[#, 7/10], 25]] < 10^-10 &]];
(* sigma_los^2(R) Sigma_*(R) = 2 Int (1 - ba R^2/r^2) rho* sr2 r dr/sqrt(r^2-R^2) *)
Clear[RR];
pp = nu + gp - 2;
SigS[R_] := 2 Atr projI[nu, R];
losNum[R_] := 2 (GG M0 r0^(gp - 3) Atr/(nu + gp - 2 - 2 ba)) (projI[pp, R] - ba R^2 projI[pp + 2, R]);
sigLos2[R_] := losNum[R]/SigS[R];
check["k5  SIS, nu=2, isotropic: sigma_los^2(R) = sigma_SIS^2 at every R",
  zeroQ[(sigLos2[RR] /. {gp -> 2, nu -> 2, ba -> 0, M0 -> 2 sv^2 r0/GG})  - sv^2]];
check["k6  sigma_los^2(R) is linear in M0 and scales as R^(2-g')",
  zeroQ[D[sigLos2[RR], {M0, 2}]] &&
  zeroQ[Simplify[RR D[Log[sigLos2[RR]], RR], RR > 0] - (2 - gp)]];
(* aperture average (luminosity weighted, circular aperture) *)
Clear[Rap];
(* convergence at R -> 0 needs nu < 3 and nu + g' < 5 *)
apAss = {Rap > 0, 1 < gp < 3, 1 < nu < 3, 3 < nu + gp < 5};
apAvg = Integrate[SigS[s] sigLos2[s] s, {s, 0, Rap}, Assumptions -> apAss]/
        Integrate[SigS[s] s, {s, 0, Rap}, Assumptions -> apAss];
apFactor = Normal[FullSimplify[apAvg/sigLos2[Rap], Assumptions -> apAss]];
Print["      sigma_ap^2 / sigma_los^2(R_ap) = ", apFactor];
check["k7  aperture average: sigma_ap^2 = sigma_los^2(R_ap) (3-nu)/(5-nu-g')",
  zeroQ[apFactor - (3 - nu)/(5 - nu - gp)]];
(* lensing normalisation: <kappa>(thE)=1  =>  M3D(r) = lam M_E (r/R_E)^(3-g') * 2Gamma(g'/2)/(sqrt(pi)Gamma((g'-1)/2)) *)
Clear[rho0, ME, RE];
M2Dpl[R_] := 2 Pi rho0 Sqrt[Pi] Gamma[(gp - 1)/2]/Gamma[gp/2] R^(3 - gp)/(3 - gp);
M3Dpl[r_] := 4 Pi rho0 r^(3 - gp)/(3 - gp);
check["k8  projection of rho0 r^-g': M2D(<R) = 2 pi rho0 sqrt(pi) Gamma((g'-1)/2)/Gamma(g'/2) R^(3-g')/(3-g')",
  TrueQ[FullSimplify[2 Pi Integrate[rho0 Sqrt[Pi] Gamma[(gp - 1)/2]/Gamma[gp/2] s^(1 - gp) s, {s, 0, RR},
        Assumptions -> {RR > 0, 1 < gp < 3}] - M2Dpl[RR], Assumptions -> {RR > 0, 1 < gp < 3}] == 0] &&
  Abs[NIntegrate[(1 + u^2)^(-23/20), {u, -Infinity, Infinity}] - N[Sqrt[Pi] Gamma[(23/10 - 1)/2]/Gamma[23/20]]] < 10^-8];
m3m2 = FullSimplify[M3Dpl[RR]/M2Dpl[RR]];
check["k9  M3D(r)/M2D(r) = 2 Gamma(g'/2)/(sqrt(pi) Gamma((g'-1)/2)); = 2/pi for g'=2",
  zeroQ[m3m2 - 2 Gamma[gp/2]/(Sqrt[Pi] Gamma[(gp - 1)/2])] && zeroQ[(m3m2 /. gp -> 2) - 2/Pi]];
(* full aperture dispersion in units of G M_E / R_E *)
FF[g_, n_, b_] := Module[{expr},
  expr = (apFactor sigLos2[RR]) /. {M0 -> 1, r0 -> 1, GG -> 1, Atr -> 1};
  (* replace M(r) normalisation: M3D(r) = (2Gamma(g/2)/(sqrt pi Gamma((g-1)/2))) (r/RE)^(3-g) with RE = 1, M_E = 1 *)
  (expr /. {gp -> g, nu -> n, ba -> b, RR -> 1}) * 2 Gamma[g/2]/(Sqrt[Pi] Gamma[(g - 1)/2])];
sigAp2[g_, n_, b_, l_, rap_] := l FF[g, n, b] rap^(2 - g);   (* units G M_E/R_E, rap = R_ap/R_E *)
check["k10 F(2,2,0) = 1/pi  =>  sigma_ap^2 = lam (c^2/4pi) thE Ds/Dds: the SIS result times lam",
  zeroQ[FF[2, 2, 0] - 1/Pi] &&
  zeroQ[(lam FF[2, 2, 0] GG Pi (cc^2 Ds/(4 Pi GG Dd Dds)) (Dd thE)) - lam (cc^2/(4 Pi)) thE Ds/Dds]];
Fclosed[g_, n_, b_] := (3 - n)/(5 - n - g) (n + g - 2 - b (n + g - 3))/(n + g - 2 - 2 b) *
   Gamma[g/2] Gamma[n/2] Gamma[(n + g - 3)/2]/(Sqrt[Pi] Gamma[(g - 1)/2] Gamma[(n - 1)/2] Gamma[(n + g)/2]);
check["k10b closed form F(g',nu,beta_a) printed in the text (eq:ms_F) equals the Jeans + projection + aperture result",
  zeroQ[FF[gp, nu, ba] - Fclosed[gp, nu, ba]] &&
  AllTrue[{{22/10, 2, 0}, {19/10, 25/10, 1/10}, {21/10, 2, -3/10}}, Abs[N[FF @@ #] - N[Fclosed @@ #]] < 10^-12 &]];
check["k10c isotropic isothermal mass: F(2,nu,0) = 2/(nu pi)  =>  sigma_ap^2 = lam (2/nu) sigma_SIS^2",
  zeroQ[FF[2, nu, 0] - 2/(nu Pi)]];
check["k11 sigma_ap^2 strictly linear in lam  =>  lam = (sigma_obs/sigma_pred)^2, Delta lam/lam = 2 Delta sigma/sigma",
  zeroQ[D[sigAp2[gp, nu, ba, lam, Rap], {lam, 2}]] &&
  zeroQ[(D[Log[sobs^2/Spred], sobs] sobs) - 2]];
(* numbers: anisotropy systematic *)
Module[{n = 2, g = 2, fr},
  fr = Table[{b, N[FF[g, n, b]/FF[g, n, 0], 6]}, {b, {-2/10, 2/10}}];
  Print["      F(2,2,beta_a)/F(2,2,0) for beta_a = -0.2, +0.2: ", fr];
  check["k12 isothermal, nu=2: F(beta_a)/F(0) = (2 - beta_a ... ) closed form (1 - beta_a/2)/(1 - beta_a)",
    zeroQ[FullSimplify[FF[2, 2, ba]/FF[2, 2, 0]] - (1 - ba/2)/(1 - ba)]];
  check["k13 isothermal, nu=2: |beta_a| = 0.2 shifts sigma_ap^2 by +12.5% / -8.33% (hence lam by the same fraction)",
    Abs[N[fr[[2, 2]]] - 1.125] < 10^-6 && Abs[N[fr[[1, 2]]] - 0.916667] < 10^-6]];
Module[{cf = FullSimplify[FF[2, nu, ba]/FF[2, nu, 0], Assumptions -> {1 < nu < 3, ba < 1, nu - 2 ba > 0}], fr},
  fr = N[{cf /. {nu -> 5/2, ba -> -2/10}, cf /. {nu -> 5/2, ba -> 2/10}}];
  Print["      g'=2: F(nu,beta_a)/F(nu,0) = ", cf, " ; nu=2.5, beta_a=-0.2,+0.2: ", fr];
  check["k14 g'=2: F(nu,beta_a)/F(nu,0) = (nu + beta_a - beta_a nu)/(nu - 2 beta_a); nu=2.5: 0.965517 / 1.047619",
    zeroQ[cf - (nu + ba - ba nu)/(nu - 2 ba)] &&
    Abs[fr[[1]] - 28/29] < 10^-6 && Abs[fr[[2]] - 22/21] < 10^-6]];
Module[{cfg = FullSimplify[FF[gp, nu, ba]/FF[gp, nu, 0], Assumptions -> {1 < gp < 3, 1 < nu < 3, 3 < nu + gp < 5, ba < 1, nu + gp - 2 - 2 ba > 0}]},
  Print["      general: F(g',nu,beta_a)/F(g',nu,0) = ", cfg];
  check["k14b general anisotropy factor F(beta_a)/F(0) = (nu+g'-2 - beta_a(nu+g'-3))/(nu+g'-2-2 beta_a); = D14 at g'=2",
    zeroQ[cfg - (nu + gp - 2 - ba (nu + gp - 3))/(nu + gp - 2 - 2 ba)] &&
    zeroQ[(cfg /. gp -> 2) - (nu + ba - ba nu)/(nu - 2 ba)]]];
(* aperture/slope covariance *)
check["k15 at fixed sigma_ap: d ln lam/d g' = ln(R_ap/R_E) - d ln F/d g'  (aperture term vanishes at R_ap = R_E)",
  zeroQ[(-D[Log[sigAp2[gp, nu, ba, 1, Rap]], gp]) - (Log[Rap] - D[Log[FF[gp, nu, ba]], gp])] ];
check["k16 projected-mass proxy: ln M2D,defl(<R) = ln lam + ln M_E + (3-g') ln(R/R_E); no g' at R = R_E",
  zeroQ[Log[lam (RR/RE)^(3 - gp)] - (Log[lam] + (3 - gp) Log[RR/RE]) // PowerExpand] &&
  zeroQ[D[Log[lam] + (3 - gp) Log[RR/RE] /. RR -> RE, gp]]];
Module[{dF = Table[{n, N[D[Log[FF[g, n, 0]], g] /. g -> 2, 8]}, {n, {2, 5/2}}]},
  Print["      d ln F/d g' at g'=2, isotropic, nu = 2, 2.5: ", dF, "  => decoupling radius R*/R_E = ", N[Exp[dF[[All, 2]]], 6]];
  check["k17 isothermal, nu=2, isotropic: d ln F/d g' = 1/2 exactly, so lam decouples from g' at R_ap = e^(1/2) R_E = 1.6487 R_E",
    zeroQ[(D[Log[FF[g, 2, 0]], g] /. g -> 2) - 1/2]]];
(* internal sheet realised by a large core: homogeneous sphere contribution to sigma_r^2 *)
Clear[rhoc, rc];
srCore2[r_] := (4 Pi/3) GG rhoc r^2/(nu - 2 - 2 ba);
check["k18 homogeneous core (rho_c): sigma_r^2 = (4pi/3) G rho_c r^2/(nu - 2 - 2 beta_a) solves Jeans",
  zeroQ[Simplify[D[rhoS[rr] srCore2[rr], rr] + 2 ba rhoS[rr] srCore2[rr]/rr + rhoS[rr] GG (4 Pi/3) rhoc rr^3/rr^2, rr > 0]]];
check["k19 uniform sphere (radius r_c): central column 2 rho_c sqrt(r_c^2-R^2) -> 2 rho_c r_c; with rho_c = (1-lam)Sigma_cr/(2 r_c) its sigma_r^2 share relative to G pi Sigma_cr R_E -> 0 as r_c -> Infinity",
  zeroQ[Integrate[rhoc, {zz, -Sqrt[rc^2 - RR^2], Sqrt[rc^2 - RR^2]}] - 2 rhoc Sqrt[rc^2 - RR^2]] &&
  zeroQ[Limit[(srCore2[RR] /. rhoc -> (1 - lam) Sig0/(2 rc))/(GG Pi Sig0 RE), rc -> Infinity]] &&
  zeroQ[rc D[(srCore2[RR] /. rhoc -> (1 - lam) Sig0/(2 rc)), rc] + (srCore2[RR] /. rhoc -> (1 - lam) Sig0/(2 rc))]];

(* ===================================================================== *)
Print["\n--- F. Figure ---"];
(* ===================================================================== *)
Module[{g = 22/10, bb = 2/10, imgs, kap, curves, fig, cols, lams = {8/10, 1, 12/10}, p1, p2},
  imgs = {x /. FindRoot[x - alPL1[x, g] == bb, {x, 1.2}],
          x /. FindRoot[x - alPL1[x, g] == bb, {x, -0.8}]};
  kap[t_, l_] := l (3 - g)/2 (1/t)^(g - 1) + 1 - l;
  cols = {RGBColor[0.15, 0.35, 0.75], Black, RGBColor[0.8, 0.2, 0.15]};
  p1 = LogLinearPlot[Evaluate[Table[kap[t, l], {l, lams}]], {t, 0.1, 5},
      PlotStyle -> Table[{cols[[i]], Thickness[0.006], If[i == 2, Dashing[{}], Dashing[{0.02, 0.01}]]}, {i, 3}],
      PlotRange -> {-0.4, 3}, Frame -> True, ImageSize -> 420, AspectRatio -> 0.8,
      FrameLabel -> {Style[Row[{"\[Theta] / ", Subscript["\[Theta]", "E"]}], 13], Style["\[Kappa](\[Theta])", 13]},
      PlotLabel -> Style[Row[{"Power law ", Superscript["\[Gamma]", "\[Prime]"], " = 2.2 under the MST"}], 13],
      Epilog -> {Gray, Dashed, Line[{{Log[Abs[imgs[[1]]]], -0.4}, {Log[Abs[imgs[[1]]]], 3}}],
                 Line[{{Log[Abs[imgs[[2]]]], -0.4}, {Log[Abs[imgs[[2]]]], 3}}],
                 Black, Dotted, Line[{{Log[0.1], 0}, {Log[5], 0}}],
                 Text[Style["A", 12], {Log[Abs[imgs[[1]]]] + 0.12, 2.6}],
                 Text[Style["B", 12], {Log[Abs[imgs[[2]]]] - 0.12, 2.6}]}];
  p2 = Plot[Evaluate[Table[(t - (l Sign[t] Abs[t]^(2 - g) + (1 - l) t)), {l, lams}]], {t, -2, 2},
      PlotStyle -> Table[{cols[[i]], Thickness[0.006], If[i == 2, Dashing[{}], Dashing[{0.02, 0.01}]]}, {i, 3}],
      Frame -> True, PlotRange -> {-1.2, 1.2}, ImageSize -> 420, AspectRatio -> 0.8,
      FrameLabel -> {Style[Row[{"\[Theta] / ", Subscript["\[Theta]", "E"]}], 13],
                     Style[Row[{"\[Theta] - ", Subscript["\[Alpha]", "\[Lambda]"], "(\[Theta])"}], 13]},
      PlotLabel -> Style[Row[{"Lens equation: roots at \[Lambda]\[Beta] (", "\[Beta] = 0.2", Subscript["\[Theta]", "E"], ")"}], 13],
      Epilog -> Join[
        Table[{cols[[i]], Dashing[{0.01, 0.01}], Line[{{-2, lams[[i]] bb}, {2, lams[[i]] bb}}]}, {i, 3}],
        Table[{cols[[i]], PointSize[0.018], Point[{#, lams[[i]] bb} & /@ imgs]}, {i, 3}],
        {Gray, Dashed, Line[{{imgs[[1]], -1.2}, {imgs[[1]], 1.2}}], Line[{{imgs[[2]], -1.2}, {imgs[[2]], 1.2}}]}]];
  fig = Column[{GraphicsRow[{p1, p2}, ImageSize -> 880, Spacings -> 20],
     LineLegend[Table[cols[[i]], {i, 3}], Table[Row[{"\[Lambda] = ", N[lams[[i]], 2]}], {i, 3}],
       LegendLayout -> "Row", LegendMarkerSize -> {30, 10}]}, Alignment -> Center];
  Export[FileNameJoin[{figDir, "msd_powerlaw_kappa.pdf"}], fig];
  check["f1  figure exported: msd_powerlaw_kappa.pdf", FileExistsQ[FileNameJoin[{figDir, "msd_powerlaw_kappa.pdf"}]]];
  Print["      image positions (thE units): ", N[imgs, 6]]];

summary[];
