(* =========================================================================
   problems_18.wl
   Module 18: The Mass-Sheet Degeneracy in Multi-Plane Lenses and
              Kinematic Breaking -- worked solutions
   =========================================================================
   Purpose: Deterministic attestation of every symbolic and numeric answer
            in Notes/18_MSD_Kinematics/18_Solutions.tex.

   Exercises solved:
     ex:ms_three_lines   MST in three lines: positions, Jacobian, flux ratios
     ex:ms_delays        delays scale as lambda; H0 bookkeeping; DSPL ratio
     ex:ms_two_planes    one deflector, two source planes (known vs free ratio)
     ex:ms_schneider     two-lens-plane MST of Schneider (2014), sign alternation
     ex:ms_sigma_budget  sigma -> lambda error budget, anisotropy bias
     ex:ms_local         the local MST: slope <-> sheet near theta_E
     ex:ms_aperture      aperture choice and the lambda-gamma' covariance
     ex:ms_core_vs_bh    cored vs point-mass internal directions
                         (8d-8e added 2026-10-14: core solution with the
                         boundary condition at infinity)

   Sources: Ported from the exercise solutions of an analytic study note on
            the MSD (Falco, Gorenstein & Shapiro 1985; Schneider 2014,
            A&A 568, L2; Schneider 2019, A&A 624, A54); project-specific
            numbers replaced by generic illustrative values.

   Usage:   bash Mathematica/run_wl.sh Solutions/18_MSD_Kinematics/problems_18.wl

   Outputs: PASS/FAIL per check + SUMMARY line (no files written).
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Mathematica", "harness.wl"}]];
Print["=== Module 18 problems ===\n"];
zeroQ[x_List] := And @@ (zeroQ /@ Flatten[x]);
zeroQ[x_] := TrueQ[FullSimplify[x] == 0];

(* ---------------- Exercise 1: three lines ---------------- *)
Print["--- Ex 1 (ex:ms_three_lines) ---"];
Clear[lam, th1, th2, a1, a2];
thV = {th1, th2}; alV = {a1, a2};
check["1a theta - [lam alpha + (1-lam) theta] = lam (theta - alpha) = lam beta",
  zeroQ[(thV - (lam alV + (1 - lam) thV)) - lam (thV - alV)]];
Amat = {{1 - pxx, -pxy}, {-pxy, 1 - pyy}};
AmatLam = {{1 - (lam pxx + (1 - lam)), -lam pxy}, {-lam pxy, 1 - (lam pyy + (1 - lam))}};
check["1b A_lam = lam A", zeroQ[AmatLam - lam Amat]];
check["1c det A_lam = lam^2 det A", zeroQ[Det[AmatLam] - lam^2 Det[Amat]]];
check["1d mu_lam = mu/lam^2", zeroQ[1/Det[AmatLam] - (1/Det[Amat])/lam^2]];
Bmat = {{1 - qxx, -qxy}, {-qxy, 1 - qyy}};
check["1e flux ratio invariant", zeroQ[(1/Det[lam Amat])/(1/Det[lam Bmat]) - Det[Bmat]/Det[Amat]]];
check["1f both eigenvalues 1-kappa-+gamma scale by lam: tangential critical curve (lambda_t = 0) invariant",
  zeroQ[{(1 - (lam k + 1 - lam) - lam g) - lam (1 - k - g), (1 - (lam k + 1 - lam) + lam g) - lam (1 - k + g)}]];

(* ---------------- Exercise 2: delays and H0 ---------------- *)
Print["\n--- Ex 2 (ex:ms_delays) ---"];
Clear[X, Y, bx, by, f];
fermat = ((X - bx)^2 + (Y - by)^2)/2 - f[X, Y];
fermatL = ((X - lam bx)^2 + (Y - lam by)^2)/2 - (lam f[X, Y] + (1 - lam) (X^2 + Y^2)/2);
check["2a tau_lam - lam tau = lam(lam-1)|beta|^2/2", zeroQ[fermatL - lam fermat - lam (lam - 1) (bx^2 + by^2)/2]];
check["2b Delta tau_lam = lam Delta tau",
  zeroQ[((fermatL /. {X -> xa, Y -> ya}) - (fermatL /. {X -> xb, Y -> yb})) -
        lam ((fermat /. {X -> xa, Y -> ya}) - (fermat /. {X -> xb, Y -> yb}))]];
H0from[dtauModel_] := Kc dtauModel/dtObs;
check["2c H0 = K Delta tau/Delta t_obs: H0(true, lam) = lam H0(naive) (eq:mst_H0)",
  zeroQ[H0from[lam dtau] - lam H0from[dtau]]];
check["2d D_dt(true) = D_dt(naive)/lam", zeroQ[(dtObs Kc/(lam dtau)) - (dtObs Kc/dtau)/lam]];
check["2e lam = 0.9: H0 naive overestimates by 1/0.9 = 1.1111 (11.1%)", Abs[N[1/0.9] - 1.111111] < 10^-6];
check["2f DSPL ratio Brat = eta^(g'-1): no lam dependence; dBrat/dg' = Brat ln eta",
  D[eta^(gp - 1), lam] === 0 && zeroQ[D[eta^(gp - 1), gp] - eta^(gp - 1) Log[eta]]];

(* ---------------- Exercise 3: two source planes ---------------- *)
Print["\n--- Ex 3 (ex:ms_two_planes) ---"];
Clear[Br, l2, l1, Brp];
ratE1 = (l2/(1 - Br (1 - l2)))^(1/(gp - 1));
check["3a known distances, power law: (theta_E1'/theta_E1)^(g'-1) = lam2/(1-Brat(1-lam2))",
  TrueQ[FullSimplify[l2 (1/ratE1)^(gp - 1) + Br (1 - l2) == 1,
     Assumptions -> {0 < Br < 1, l2 > 0, 1 < gp < 3, 1 - Br (1 - l2) > 0}]]];
v3b = ratE1 /. {gp -> 2, Br -> 7/10, l2 -> 9/10};
check["3b g'=2, Brat=0.7, lam2=0.9: theta_E1'/theta_E1 = 90/93 = 0.967742 (3.2% shift of eta)",
  v3b == 30/31 && Abs[N[v3b] - 0.967742] < 10^-6];
sol = First[Solve[{l1 == l2 Brp/Br, 1 - l1 == Brp (1 - l2)}, {Brp, l1}]];
check["3c free ratio: Brat' = 1/(1 - lam2 + lam2/Brat), lam1 = lam2/(Brat(1-lam2)+lam2)",
  zeroQ[(Brp /. sol) - 1/(1 - l2 + l2/Br)] && zeroQ[(l1 /. sol) - l2/(Br (1 - l2) + l2)]];
v3d = {Brp, l1} /. sol /. {Br -> 7/10, l2 -> 9/10};
check["3d Brat=0.7, lam2=0.9: Brat' = 70/97 = 0.721649, lam1 = 90/97 = 0.927835",
  v3d == {70/97, 90/97} && Abs[N[v3d[[1]]] - 0.721649] < 10^-6 && Abs[N[v3d[[2]]] - 0.927835] < 10^-6];
(* power-law reading with eta fixed: eta = Brat^(1/(g'-1)), g' = 2 => eta = 0.7 *)
gNew = 1 + Log[70/97]/Log[7/10];
check["3e eta fixed (g'=2 => eta = 0.7): a power-law fit reproducing Brat' needs g'-1 = ln Brat'/ln eta = 0.914602 (g' = 1.914602)",
  Abs[N[gNew] - 1.914602] < 10^-6];
Print["      g'_new = ", N[gNew, 7]];
check["3f fractional shift of Brat: Brat'/Brat - 1 = 3.093% (= 1/0.97 - 1)",
  Abs[N[(70/97)/(7/10) - 1] - 0.0309278] < 10^-6];

(* ---------------- Exercise 4: Schneider (2014) two lens planes ---------------- *)
Print["\n--- Ex 4 (ex:ms_schneider) ---"];
Clear[A1, A2, be, nu3, K2, th];
th2o = th - be A1; th3o = th - A1 - A2;
a1p = lam A1 + (1 - lam)/be th;
check["4a theta_2' = lam theta_2", zeroQ[(th - be a1p) - lam th2o]];
th3p = th - a1p - (nu3 A2 + K2 lam th2o);
solS = Solve[DeleteDuplicates[Flatten[Thread[CoefficientList[th3p - nu3 th3o, {th, A1, A2}] == 0]]], {nu3, K2}];
check["4b nu3 = 1, K2 = (lam - 1)/(lam beta)",
  Length[solS] == 1 && zeroQ[(nu3 /. First[solS]) - 1] && zeroQ[(K2 /. First[solS]) - (lam - 1)/(lam be)]];
v4 = {(1 - lam)/be, (lam - 1)/(lam be)} /. {lam -> 95/100, be -> 7/10};
check["4c lam=0.95, beta=0.7: K1 = +0.071429, K2 = -0.075188 (opposite signs)",
  Abs[N[v4[[1]]] - 0.0714286] < 10^-6 && Abs[N[v4[[2]]] + 0.0751880] < 10^-6];
check["4d K1/K2 = -lam for all lam, beta", zeroQ[((1 - lam)/be)/((lam - 1)/(lam be)) + lam]];
check["4e lam = 1 forces K2 = 0: no MST acting on the second lens plane alone",
  ((lam - 1)/(lam be) /. lam -> 1) === 0];

(* ---------------- Exercise 5: sigma budget ---------------- *)
Print["\n--- Ex 5 (ex:ms_sigma_budget) ---"];
s0 = 250; ds = 10;
check["5a sigma = 250 +- 10 km/s: Delta lam/lam = 2 x 10/250 = 0.08", 2 ds/s0 == 2/25];
check["5b 1% on lam needs Delta sigma/sigma = 0.5%, i.e. 1.25 km/s at 250 km/s",
  (1/100)/2 == 1/200 && s0/200 == 5/4];
check["5c propagation: lam = sigma^2/S => d ln lam = 2 d ln sigma", zeroQ[D[Log[sg^2/S], sg] sg - 2]];
Fratio[g_, n_, b_] := (n + g - 2 - b (n + g - 3))/(n + g - 2 - 2 b);
check["5d isothermal (g'=2, nu=2): true beta_a = +0.2 analysed as isotropic biases lam high by F(0.2)/F(0) = 1.125",
  Fratio[2, 2, 2/10] == 9/8];
check["5e ... and beta_a = -0.2 biases lam low by 11/12 = 0.916667", Fratio[2, 2, -2/10] == 11/12];
check["5f a flat prior beta_a in [-0.2, 0.2] => lam range [0.9167, 1.125]: half-width 10.4%, i.e. larger than the 8% statistical error",
  Abs[N[(9/8 - 11/12)/2] - 0.1041667] < 10^-6 && N[(9/8 - 11/12)/2] > 0.08];

sig5g = 299792.458 Sqrt[(1.15/206264.806) (1/0.638)/(4 Pi)];
Print["      sigma from thE = 1.15 arcsec, Dds/Ds = 0.638: ", sig5g, " km/s"];
check["5g units check (Sect. ms_kin_sys annotation): thE = 1.15'', Dds/Ds = 0.638 => sigma_v = c sqrt(thE Ds/(4 pi Dds)) = 250 km/s (to 1 km/s)",
  Abs[sig5g - 250] < 1];

(* ---------------- Exercise 6: local MST ---------------- *)
Print["\n--- Ex 6 (ex:ms_local) ---"];
alPos[y_, g_] := thE (y/thE)^(2 - g);
serA = Normal[Series[lam alPos[thE + d, gp] + (1 - lam) (thE + d), {d, 0, 2}]] // PowerExpand;
serB = Normal[Series[alPos[thE + d, 1 + lam (gp - 1)], {d, 0, 2}]] // PowerExpand;
check["6a orders 0 and 1 agree for g2 = 1 + lam(g'-1)",
  zeroQ[{Coefficient[Expand[serA - serB], d, 0], Coefficient[Expand[serA - serB], d, 1]}]];
check["6b order 2 differs by lam(1-lam)(g'-1)^2/(2 thE)",
  zeroQ[Coefficient[Expand[serA - serB], d, 2] - lam (1 - lam) (gp - 1)^2/(2 thE)]];
check["6c g'=2, lam=0.9: g2 = 1.9; delays at fixed images scale by (g2-1)/(g'-1) = 0.9 = lam",
  (1 + 9/10 (2 - 1)) == 19/10 && (19/10 - 1)/(2 - 1) == 9/10];
check["6d xi = 2(g'-2): 0 for the MST'd isothermal, -0.2 for the g' = 1.9 power law",
  2 (2 - 2) == 0 && 2 (19/10 - 2) == -1/5];

(* ---------------- Exercise 7: aperture ---------------- *)
Print["\n--- Ex 7 (ex:ms_aperture) ---"];
check["7a proxy: ln M2D,defl(<R) = ln lam + const + (3-g') ln(R/R_E) => d ln lam/dg' |_M = ln(R/R_E)",
  zeroQ[D[-(3 - gp) Log[rr], gp] - Log[rr]]];
dl = N[Log[1/2] - 1/2];
check["7b isothermal-tracer Jeans: d ln lam/dg' = ln(R_ap/R_E) - 1/2; at R_ap = 0.5 R_E: -1.19315",
  Abs[dl + 1.193147] < 10^-5];
check["7c ... so a slope error dg' = +0.1 biases lam by -11.9%; zero-covariance radius e^(1/2) R_E = 1.64872 R_E",
  Abs[0.1 dl + 0.1193147] < 10^-6 && Abs[N[Exp[1/2]] - 1.648721] < 10^-6];

(* ---------------- Exercise 8: core vs point mass ---------------- *)
Print["\n--- Ex 8 (ex:ms_core_vs_bh) ---"];
Clear[Mbh, GG, nu, ba, rr, Atr, rhoc];
rhoS[r_] := Atr r^(-nu);
srBH[r_] := GG Mbh/(r (nu + 1 - 2 ba));
check["8a point mass: sigma_r^2 = G M_bh/[r (nu + 1 - 2 beta_a)] solves Jeans (rises as 1/r inward)",
  zeroQ[Simplify[D[rhoS[rr] srBH[rr], rr] + 2 ba rhoS[rr] srBH[rr]/rr + rhoS[rr] GG Mbh/rr^2, rr > 0]]];
srCore[r_] := (4 Pi/3) GG rhoc r^2/(nu - 2 - 2 ba);
check["8b uniform core: sigma_r^2 = (4 pi/3) G rho_c r^2/(nu - 2 - 2 beta_a) solves Jeans (falls as r^2 inward)",
  zeroQ[Simplify[D[rhoS[rr] srCore[rr], rr] + 2 ba rhoS[rr] srCore[rr]/rr + rhoS[rr] GG (4 Pi/3) rhoc rr^3/rr^2, rr > 0]]];
check["8c log-slopes of the two sigma_r^2 contributions differ by 3 (-1 vs +2): different radial directions",
  zeroQ[rr D[Log[srBH[rr]], rr] + 1] && zeroQ[rr D[Log[srCore[rr]], rr] - 2]];
(* fix pass 2026-10-14: the r^2 core law is the small-r limit of the boundary-condition solution
   only for nu > 2 + 2 beta_a; exact solution for a uniform sphere of radius rc *)
Clear[rp, rc];
srCoreBC[r_, n_, b_] := r^(n - 2 b) (
   Integrate[(4 Pi/3) GG rhoc rp^(1 - n + 2 b), {rp, r, rc}, Assumptions -> {0 < r < rc}] +
   Integrate[GG (4 Pi/3) rhoc rc^3 rp^(-n - 2 + 2 b), {rp, rc, Infinity}, Assumptions -> {rc > 0, n + 1 - 2 b > 0}]);
check["8d uniform core, rho* sr2 -> 0 at infinity: sr2 = (4pi G rho_c/3)[r^2/(nu-2-2ba) - 3 rc^(2-nu+2ba) r^(nu-2ba)/((nu+1-2ba)(nu-2-2ba))]; at nu=2, ba=0: (4pi/3) G rho_c r^2 [ln(rc/r) + 1/3]",
  zeroQ[Simplify[srCoreBC[rr, nu, ba] - (4 Pi GG rhoc/3) (rr^2/(nu - 2 - 2 ba) -
        3 rc^(2 - nu + 2 ba) rr^(nu - 2 ba)/((nu + 1 - 2 ba) (nu - 2 - 2 ba))),
        {0 < rr < rc, nu + 1 - 2 ba > 0, nu - 2 - 2 ba > 0}] // PowerExpand] &&
  zeroQ[FullSimplify[srCoreBC[rr, 2, 0], 0 < rr < rc] - (4 Pi/3) GG rhoc rr^2 (Log[rc/rr] + 1/3)]];
check["8e r^2 law is the r -> 0 limit for nu > 2+2ba (nu=2.5: ratio -> 1); nu = 1.8: exact sr2 > 0 ~ r^1.8 while r^2/(nu-2) < 0",
  Limit[FullSimplify[srCoreBC[rr, 5/2, 0], 0 < rr < rc]/(srCore[rr] /. {nu -> 5/2, ba -> 0}), rr -> 0, Assumptions -> rc > 0] == 1 &&
  (srCoreBC[rr, 9/5, 0] /. {rr -> 1/10, rc -> 1, rhoc -> 1, GG -> 1}) > 0 &&
  (srCore[rr] /. {nu -> 9/5, ba -> 0, rr -> 1/10, rhoc -> 1, GG -> 1}) < 0 &&
  zeroQ[Limit[PowerExpand[FullSimplify[srCoreBC[rr, 9/5, 0], 0 < rr < rc]]/rr^(9/5), rr -> 0, Assumptions -> rc > 0] - (50/7) Pi GG rhoc rc^(1/5)]];

summary[];
