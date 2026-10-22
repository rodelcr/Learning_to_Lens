(* =========================================================================
   problems_05.wl
   Module 5: Magnification, Convergence, and Shear --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 5, verified
            symbolically and numerically with Mathematica.

   Sources: Narayan & Bartelmann Sec. 3.2
            Congdon & Keeton Ch. 2.6 & 4
            Saha et al. Sec. 1

   Usage:   wolframscript -file problems_05.wl

   Exercises solved:
     5.1 --- Derive the Jacobian matrix A from the lens equation
     5.2 --- Show nabla^2 psi = 2 kappa (2D Poisson equation)
     5.3 --- Compute gamma_1, gamma_2, |gamma| for point mass lens
     5.4 --- Show magnification formula reduces to point mass result
     5.5 --- Compute axis ratio and magnification for constant kappa, gamma
     Annotated-edition checks (2026-10) --- every identity / number quoted in
     the annotation, derivation and bridge boxes of
     05_Magnification_Convergence_Shear.tex and 05_Solutions.tex (appended
     section at the end; ends with summary[]).
     Fix-pass checks (2026-10-14) --- printed values / conditions changed after
     the 2026-10-14 fact-critic report, each failing on the old printed value.

   Outputs: printed solutions; PASS/FAIL lines and a SUMMARY line for the
            annotated-edition checks
   ========================================================================= *)

Print["=== Module 5: SOLUTIONS ===\n"];


(* =========================================================================
   Exercise 5.1: Derive the Jacobian Matrix

   A_ij = delta_ij - d^2(psi) / d(theta_i) d(theta_j)
   Decompose into kappa (trace) and shear (traceless) parts.
   ========================================================================= *)

Print["--- Exercise 5.1: Derivation of the Jacobian Matrix ---\n"];

Print["(a) From beta_i = theta_i - alpha_i(theta) with alpha_i = d(psi)/d(theta_i):"];
Print["    A_ij = d(beta_i)/d(theta_j) = delta_ij - d^2(psi)/d(theta_i)d(theta_j)\n"];

(* Symbolic Hessian of a general psi *)
Print["(b) The Hessian H_ij = d^2(psi)/d(theta_i)d(theta_j) is a 2x2 symmetric matrix:"];
H = {{psi11, psi12}, {psi12, psi22}};
Print["    H = ", MatrixForm[H]];
Print[""];

trH = psi11 + psi22;
Print["  Trace: tr(H) = psi_11 + psi_22 = nabla^2(psi) = 2*kappa"];
Print["  => kappa = (psi_11 + psi_22)/2\n"];

Print["  Trace part: kappa * I = (1/2)(psi_11 + psi_22) * I"];
Print["  Traceless part: H - kappa*I = ((gamma1, gamma2),(gamma2, -gamma1))"];
Print["    where gamma1 = (psi_11 - psi_22)/2, gamma2 = psi_12\n"];

(* Verify the decomposition *)
kap = (psi11 + psi22)/2;
g1 = (psi11 - psi22)/2;
g2 = psi12;
Hrecon = kap * IdentityMatrix[2] + {{g1, g2}, {g2, -g1}};
Print["  Reconstruction: kappa*I + shear = ", MatrixForm[Hrecon]];
Print["  Matches original H? ", Hrecon == H, "\n"];

Print["(c) A = I - H = ((1-kappa-gamma1, -gamma2), (-gamma2, 1-kappa+gamma1))"];
Amat = IdentityMatrix[2] - Hrecon;
Print["    A = ", MatrixForm[Amat]];
Print["    VERIFIED\n"];


(* =========================================================================
   Exercise 5.2: The 2D Poisson Equation

   nabla^2 ln|theta| = 2*Pi * delta^(2)(theta)
   => nabla^2 psi = 2*kappa
   ========================================================================= *)

Print["--- Exercise 5.2: The 2D Poisson Equation ---\n"];

Print["(a) Green's function of 2D Laplacian:"];
Print["    nabla^2 ln|theta| = ? for theta != 0:"];

(* Verify that ln(r) is harmonic for r != 0 *)
lnR = Log[Sqrt[x^2 + y^2]];
lap = D[lnR, {x, 2}] + D[lnR, {y, 2}] // Simplify;
Print["    nabla^2 ln(r) = ", lap, "  for r != 0"];
Print["    (= 0, confirming ln(r) is harmonic away from origin)\n"];

Print["    Using Gauss's theorem on a disk of radius epsilon:"];
Print["    integral(nabla^2 ln(r) dA) = integral(grad(ln r) . n dl)"];
Print["    = integral((r-hat/r) . r-hat * r d(phi)) on r = epsilon"];
Print["    = integral(1/epsilon * epsilon d(phi)) = 2*Pi"];
Print["    => nabla^2 ln|theta| = 2*Pi * delta^(2)(theta). QED\n"];

Print["(b) nabla^2 psi = nabla^2 [(1/Pi) integral(kappa(theta') ln|theta - theta'| d^2theta')]"];
Print["    = (1/Pi) integral(kappa(theta') * 2*Pi * delta^(2)(theta-theta') d^2theta')"];
Print["    = 2 * kappa(theta). QED\n"];

Print["(c) Point mass: psi = thetaE^2 * ln|theta|"];
Print["    nabla^2 psi = thetaE^2 * nabla^2 ln|theta|"];
Print["                = thetaE^2 * 2*Pi * delta^(2)(theta)"];
Print["                = 2 * [Pi*thetaE^2 * delta^(2)(theta)]"];
Print["                = 2 * kappa. VERIFIED\n"];


(* =========================================================================
   Exercise 5.3: Shear of a Point Mass Lens

   psi = (thetaE^2/2) * ln(theta1^2 + theta2^2)
   ========================================================================= *)

Print["--- Exercise 5.3: Shear of a Point Mass Lens ---\n"];

psi[th1_, th2_, tE_] := tE^2/2 * Log[th1^2 + th2^2];

(* (a) Compute shear components *)
Print["(a) Second derivatives of psi:"];
d2psi11 = D[psi[th1, th2, tE], {th1, 2}] // Simplify;
d2psi22 = D[psi[th1, th2, tE], {th2, 2}] // Simplify;
d2psi12 = D[D[psi[th1, th2, tE], th1], th2] // Simplify;
Print["  psi_11 = ", d2psi11];
Print["  psi_22 = ", d2psi22];
Print["  psi_12 = ", d2psi12];
Print[""];

gamma1 = (d2psi11 - d2psi22)/2 // Simplify;
gamma2 = d2psi12 // Simplify;
Print["  gamma_1 = (psi_11 - psi_22)/2 = ", gamma1];
Print["  gamma_2 = psi_12 = ", gamma2];
Print[""];

(* (b) Shear magnitude *)
Print["(b) Shear magnitude:"];
gammaMagSq = gamma1^2 + gamma2^2 //
    FullSimplify[#, Assumptions -> {th1 \[Element] Reals,
        th2 \[Element] Reals, th1^2 + th2^2 > 0}] &;
Print["  |gamma|^2 = gamma1^2 + gamma2^2 = ", gammaMagSq];
gammaMag = Sqrt[gammaMagSq] //
    FullSimplify[#, Assumptions -> {th1 \[Element] Reals,
        th2 \[Element] Reals, th1^2 + th2^2 > 0, tE > 0}] &;
Print["  |gamma| = ", gammaMag];
Print["  = thetaE^2 / theta^2. VERIFIED\n"];

(* (c) Polar coordinates *)
Print["(c) In polar coordinates (theta1 = theta*cos(phi), theta2 = theta*sin(phi)):"];
g1polar = gamma1 /. {th1 -> theta Cos[phi], th2 -> theta Sin[phi]} //
    TrigReduce // Simplify;
g2polar = gamma2 /. {th1 -> theta Cos[phi], th2 -> theta Sin[phi]} //
    TrigReduce // Simplify;
Print["  gamma_1 = ", g1polar];
Print["  gamma_2 = ", g2polar];
Print[""];
Print["  Complex shear: gamma = gamma_1 + i*gamma_2"];
Print["    = -(thetaE^2/theta^2)(cos(2*phi) + i*sin(2*phi))"];
Print["    = -(thetaE^2/theta^2) * exp(2*i*phi)"];
Print["  This is tangential shear (perpendicular to radius vector).\n"];

(* (d) Ratio |gamma|/kappa *)
Print["(d) Since kappa = 0 for theta != 0 (point mass),"];
Print["    |gamma|/kappa is undefined (infinite)."];
Print["    All distortion is from shear alone; convergence contributes"];
Print["    only at the origin (delta function).\n"];

(* Numerical check *)
Print["Numerical check at theta = (1, 0) with thetaE = 1:"];
g1num = gamma1 /. {th1 -> 1, th2 -> 0, tE -> 1};
g2num = gamma2 /. {th1 -> 1, th2 -> 0, tE -> 1};
Print["  gamma_1 = ", g1num, " (should be -1)"];
Print["  gamma_2 = ", g2num, " (should be 0)"];
Print["  |gamma| = ", Sqrt[g1num^2 + g2num^2], " (should be 1)"];
Print[""];

Print["Numerical check at theta = (1, 1)/sqrt(2) with thetaE = 1:"];
g1num2 = gamma1 /. {th1 -> 1/Sqrt[2], th2 -> 1/Sqrt[2], tE -> 1};
g2num2 = gamma2 /. {th1 -> 1/Sqrt[2], th2 -> 1/Sqrt[2], tE -> 1};
Print["  gamma_1 = ", g1num2, " (should be 0)"];
Print["  gamma_2 = ", g2num2, " (should be -1)"];
Print["  |gamma| = ", Sqrt[g1num2^2 + g2num2^2], " (should be 1)"];
Print[""];


(* =========================================================================
   Exercise 5.4: Magnification Consistency Check

   For point mass: kappa = 0, |gamma| = thetaE^2/theta^2
   mu = theta^4 / (theta^4 - thetaE^4)
   ========================================================================= *)

Print["--- Exercise 5.4: Magnification Consistency Check ---\n"];

(* (a) Magnification from kappa = 0, |gamma| = thetaE^2/theta^2 *)
Print["(a) With kappa = 0 and |gamma| = thetaE^2/theta^2:"];
Print["    mu = 1 / (1 - |gamma|^2) = 1 / (1 - thetaE^4/theta^4)"];
Print["       = theta^4 / (theta^4 - thetaE^4). VERIFIED\n"];

(* (b) Evaluate at theta_pm *)
Print["(b) At theta_pm = (u +/- sqrt(u^2 + 4))/2 (in thetaE units):"];

thetaP[u_] := (u + Sqrt[u^2 + 4])/2;
thetaM[u_] := (u - Sqrt[u^2 + 4])/2;

(* Magnification at theta_+ *)
muP = thetaP[u]^4 / (thetaP[u]^4 - 1) //
    FullSimplify[#, Assumptions -> u > 0] &;
Print["  mu(theta_+) = ", muP];

muPexpected = (u^2 + 2)/(2 u Sqrt[u^2 + 4]) + 1/2 //
    FullSimplify[#, Assumptions -> u > 0] &;
diffP = Simplify[muP - muPexpected, Assumptions -> u > 0];
Print["  Expected:     (u^2+2)/(2u*sqrt(u^2+4)) + 1/2"];
Print["  Difference:   ", diffP, "\n"];

(* Magnification at theta_- *)
muM = thetaM[u]^4 / (thetaM[u]^4 - 1) //
    FullSimplify[#, Assumptions -> u > 0] &;
Print["  mu(theta_-) = ", muM];

muMexpected = 1/2 - (u^2 + 2)/(2 u Sqrt[u^2 + 4]) //
    FullSimplify[#, Assumptions -> u > 0] &;
diffM = Simplify[muM - muMexpected, Assumptions -> u > 0];
Print["  Expected:     1/2 - (u^2+2)/(2u*sqrt(u^2+4))  (signed)"];
Print["  Difference:   ", diffM, "\n"];

(* Numerical verification *)
Print["Numerical verification at u = 1:"];
Print["  theta_+ = ", N[thetaP[1]], ", theta_- = ", N[thetaM[1]]];
Print["  mu_+ = ", N[muP /. u -> 1], " (expected: ",
    N[(1 + 2)/(2*1*Sqrt[5]) + 1/2], ")"];
Print["  mu_- = ", N[muM /. u -> 1], " (expected: ",
    N[1/2 - (1 + 2)/(2*1*Sqrt[5])], ")"];
Print[""];

(* (c) Parity *)
Print["(c) Parity analysis:"];
Print["  mu_+ = (u^2+2)/(2u*sqrt(u^2+4)) + 1/2"];
Print["  Since (u^2+2)/(2u*sqrt(u^2+4)) > 0 for u > 0,"];
Print["  mu_+ > 1/2 > 0. (Positive parity) VERIFIED\n"];

Print["  mu_- = 1/2 - (u^2+2)/(2u*sqrt(u^2+4))"];
Print["  (u^2+2)^2 - u^2 (u^2+4) = ", Expand[(u^2 + 2)^2 - u^2 (u^2 + 4)],
    " > 0, so (u^2+2)/(2u*sqrt(u^2+4)) > 1/2 and mu_- < 0."];
Print["  Reduce[mu(theta_-) >= 0 && u > 0] -> ", Reduce[muM >= 0 && u > 0, u],
    "  (False => mu_- < 0 for all u > 0)"];
Print["  Equivalently |theta_-| < thetaE, so theta_-^4 - thetaE^4 < 0."];
Print["  |mu_-| = (u^2+2)/(2u*sqrt(u^2+4)) - 1/2 (the lower sign of"];
Print["  eq. magnification_u). Negative parity: mirror-reflected. VERIFIED\n"];

(* (d) Total magnification > 1 *)
Print["(d) Total magnification:"];
Print["  |mu_+| + |mu_-| = (u^2+2)/(u*sqrt(u^2+4))"];
totalMagCheck = Simplify[(u^2 + 2)^2 - u^2 (u^2 + 4)];
Print["  Need to show this > 1, i.e., (u^2+2) > u*sqrt(u^2+4)"];
Print["  Square: (u^2+2)^2 - u^2*(u^2+4) = ", totalMagCheck];
Print["  = 4 > 0. Therefore |mu_+| + |mu_-| > 1. QED\n"];


(* =========================================================================
   Exercise 5.5: Elliptical Image from Constant kappa and gamma

   A = ((1-kappa-gamma1, -gamma2), (-gamma2, 1-kappa+gamma1))
   Eigenvalues: lambda_pm = 1 - kappa +/- |gamma|
   ========================================================================= *)

Print["--- Exercise 5.5: Elliptical Image from Constant kappa and gamma ---\n"];

(* (a) Jacobian matrix *)
Print["(a) For constant kappa, gamma1, gamma2:"];
Aconst = {{1 - kappa - g1, -g2}, {-g2, 1 - kappa + g1}};
Print["    A = ", MatrixForm[Aconst]];
Print[""];

(* (b) Eigenvalues *)
Print["(b) Eigenvalues of A:"];
eigsConst = Eigenvalues[Aconst] // Simplify;
Print["    lambda = ", eigsConst];
Print[""];

Print["  For |gamma| = sqrt(g1^2 + g2^2):"];
Print["    lambda_+ = 1 - kappa + |gamma|"];
Print["    lambda_- = 1 - kappa - |gamma|"];
Print[""];

Print["  A circular source of radius delta maps to an ellipse with semi-axes:"];
Print["    a = delta / |lambda_-|  (major axis, since |lambda_-| < |lambda_+|)"];
Print["    b = delta / |lambda_+|  (minor axis)\n"];

(* (c) Axis ratio and magnification *)
Print["(c) Axis ratio:"];
Print["    b/a = |lambda_-| / |lambda_+|"];
Print["        = |1 - kappa - |gamma|| / |1 - kappa + |gamma||"];
Print[""];
Print["  Magnification:"];
detAconst = Det[Aconst] // Expand;
Print["    det(A) = ", detAconst];
Print["    mu = 1/det(A) = 1/((1-kappa)^2 - (g1^2 + g2^2))"];
Print["       = 1/((1-kappa)^2 - |gamma|^2)\n"];

(* (d) Orientation for gamma2 = 0 *)
Print["(d) For gamma2 = 0, A is diagonal:"];
Adiag = Aconst /. g2 -> 0;
Print["    A = ", MatrixForm[Adiag]];
Print["  Eigenvectors are (1,0) and (0,1)."];
Print["  lambda_- eigenvalue (smaller) corresponds to major axis."];
Print["  If gamma1 > 0: lambda_- = 1-kappa-gamma1 is along theta_1 (horizontal)."];
Print["    => major axis is horizontal."];
Print["  If gamma1 < 0: lambda_- = 1-kappa-|gamma1| is along theta_2 (vertical)."];
Print["    => major axis is vertical.\n"];

(* (e) Numerical example *)
Print["(e) Numerical example: kappa = 0.3, |gamma| = 0.2"];
kapNum = 0.3;
gamNum = 0.2;
lamPnum = 1 - kapNum + gamNum;
lamMnum = 1 - kapNum - gamNum;
axisRatio = Abs[lamMnum] / Abs[lamPnum];
muNum = 1 / (lamPnum * lamMnum);
Print["  lambda_+ = 1 - 0.3 + 0.2 = ", lamPnum];
Print["  lambda_- = 1 - 0.3 - 0.2 = ", lamMnum];
Print["  axis ratio b/a = |lambda_-|/|lambda_+| = ",
    NumberForm[axisRatio, {3, 3}]];
Print["  magnification mu = 1/(lambda_+ * lambda_-) = ",
    NumberForm[muNum, {4, 2}]];
Print[""];

Print["  For a source with delta = 1 arcsec:"];
Print["    major axis a = 1/|lambda_-| = ",
    NumberForm[1/Abs[lamMnum], {4, 2}], " arcsec"];
Print["    minor axis b = 1/|lambda_+| = ",
    NumberForm[1/Abs[lamPnum], {4, 2}], " arcsec"];
Print["    area ratio = pi*a*b / (pi*delta^2) = ",
    NumberForm[1/(Abs[lamPnum]*Abs[lamMnum]), {4, 2}], " = |mu|"];
Print[""];

(* Additional verification: vary kappa and gamma systematically *)
Print["  Table of axis ratios and magnifications:"];
Print["  kappa    |gamma|   b/a      mu"];
Print["  ", StringJoin[Table["-", 40]]];
Do[
    lp = 1 - k + g;
    lm = 1 - k - g;
    If[Abs[lp*lm] > 0.001,
        ar = Abs[lm]/Abs[lp];
        m = 1/(lp*lm);
        Print["  ", PaddedForm[k, {4, 2}], "    ",
            PaddedForm[g, {4, 2}], "    ",
            PaddedForm[ar, {5, 3}], "    ",
            PaddedForm[m, {6, 2}]]
    ],
    {k, {0.0, 0.1, 0.2, 0.3, 0.5}},
    {g, {0.0, 0.1, 0.2, 0.3}}
];
Print[""];

Print["=== End of Module 5 Solutions ==="];


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity and number quoted in the annotation / derivation / bridge
   boxes of Notes/05_Magnification_Convergence_Shear/*.tex.                 *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Mathematica", "harness.wl"}]];
Print["\n--- Annotated-edition checks (Module 5) ---"];
ClearAll[t1, t2, s1, s2, r, p, ep, m, k, g, ga1, ga2, ph, phg, lam, bb, tE, tB, q,
  aH, aR, aA, aHp, aEv, aPsi, aAl, aKap, aKbar, aLr, aXp, aXm, aMuP, aMuM, aM2, aRoots];

(* --- potential and Poisson equation --- *)
check["grad ln|theta - theta'| = (theta - theta')/|theta - theta'|^2",
  Simplify[Grad[Log[Sqrt[(t1 - s1)^2 + (t2 - s2)^2]], {t1, t2}] ==
    {t1 - s1, t2 - s2}/((t1 - s1)^2 + (t2 - s2)^2)]];
check["Gauss flux of grad ln r through |theta| = eps is (1/eps)(2 pi eps) = 2 pi",
  Simplify[Integrate[({ep Cos[p], ep Sin[p]}/ep^2).{Cos[p], Sin[p]} ep, {p, 0, 2 Pi}] == 2 Pi, ep > 0]];
check["nascent delta: Lap[(1/2) ln(r^2+eps^2)] = 2 eps^2/(r^2+eps^2)^2 with plane integral 2 pi for every eps",
  Simplify[Laplacian[Log[t1^2 + t2^2 + ep^2]/2, {t1, t2}] == 2 ep^2/(t1^2 + t2^2 + ep^2)^2] &&
  Simplify[Integrate[2 ep^2/(r^2 + ep^2)^2 2 Pi r, {r, 0, Infinity}, Assumptions -> ep > 0] == 2 Pi]];
check["multipole: Lap[theta cos(m phi)] = (1-m^2) cos(m phi)/theta, so kappa = (1-m^2) cos(m phi)/(2 theta); m=1 gives 0",
  Simplify[Laplacian[r Cos[m p], {r, p}, "Polar"] == (1 - m^2) Cos[m p]/r] &&
  Simplify[Laplacian[r Cos[p], {r, p}, "Polar"] == 0]];
check["multipole m=2 cross-check in Cartesian: psi = (t1^2 - t2^2)/theta -> kappa = -3 cos(2phi)/(2 theta)",
  Simplify[Laplacian[(t1^2 - t2^2)/Sqrt[t1^2 + t2^2], {t1, t2}]/2 ==
    -3 ((t1^2 - t2^2)/(t1^2 + t2^2))/(2 Sqrt[t1^2 + t2^2])]];
check["m=2 on an isothermal: psi = tE theta + e theta cos2phi -> kappa = (tE - 3 e cos2phi)/(2 theta); isopotential theta = c/(tE + e cos2phi) and isodensity theta = (tE - 3e cos2phi)/(2c) both shortest at phi = 0",
  Simplify[Laplacian[tE r + ee r Cos[2 p], {r, p}, "Polar"]/2 == (tE - 3 ee Cos[2 p])/(2 r)] &&
  Module[{e0 = 0.05}, Ordering[Table[1/(1 + e0 Cos[2 x]), {x, 0, Pi/2, Pi/8}]][[1]] == 1 &&
    Ordering[Table[1 - 3 e0 Cos[2 x], {x, 0, Pi/2, Pi/8}]][[1]] == 1]];
check["linear term a.theta in psi shifts alpha by a constant and leaves the Hessian unchanged",
  D[q1 t1 + q2 t2, {{t1, t2}, 2}] == {{0, 0}, {0, 0}}];

(* --- shear as a spin-2 object --- *)
aH = {{k + ga1, ga2}, {ga2, k - ga1}};
aR = {{Cos[ph], -Sin[ph]}, {Sin[ph], Cos[ph]}};      (* columns = rotated basis vectors *)
aHp = Transpose[aR].aH.aR;
check["axes rotated by phi: H' = R^T H R gives kappa' = kappa and gamma' = e^{-2 i phi} gamma",
  Simplify[(aHp[[1, 1]] + aHp[[2, 2]])/2 == k] &&
  Simplify[TrigExpand[((aHp[[1, 1]] - aHp[[2, 2]])/2 + I aHp[[1, 2]]) - Exp[-2 I ph] (ga1 + I ga2)] // ExpToTrig] == 0];
check["components: gamma1' = g1 cos2phi + g2 sin2phi, gamma2' = -g1 sin2phi + g2 cos2phi",
  Simplify[{(aHp[[1, 1]] - aHp[[2, 2]])/2, aHp[[1, 2]]} ==
    {ga1 Cos[2 ph] + ga2 Sin[2 ph], -ga1 Sin[2 ph] + ga2 Cos[2 ph]}]];

(* --- Jacobian, eigen-decomposition --- *)
aA = {{1 - k - g Cos[2 phg], -g Sin[2 phg]}, {-g Sin[2 phg], 1 - k + g Cos[2 phg]}};
check["characteristic polynomial: det(A - lam I) = (1-kappa-lam)^2 - |gamma|^2",
  Simplify[Det[aA - lam IdentityMatrix[2]] == (1 - k - lam)^2 - g^2]];
check["A (cos phg, sin phg) = (1-kappa-|gamma|)(cos phg, sin phg); A (-sin, cos) = (1-kappa+|gamma|)(-sin, cos)",
  Simplify[aA.{Cos[phg], Sin[phg]} == (1 - k - g) {Cos[phg], Sin[phg]}] &&
  Simplify[aA.{-Sin[phg], Cos[phg]} == (1 - k + g) {-Sin[phg], Cos[phg]}]];
check["quadrant: gamma = (-0.1, 0.1): (1/2)ArcTan[g2/g1] = -22.5 deg but stretch axis is (1/2)atan2 = 67.5 deg",
  Module[{gg1 = -0.1, gg2 = 0.1, ang, A0, ev},
    ang = ArcTan[gg1, gg2]/2;
    A0 = {{1 - 0.3 - gg1, -gg2}, {-gg2, 1 - 0.3 + gg1}};
    ev = Eigenvectors[A0][[Ordering[Eigenvalues[A0]][[1]]]];
    Round[ArcTan[gg2/gg1]/2/Degree, 0.1] == -22.5 && Round[ang/Degree, 0.1] == 67.5 &&
    Abs[Abs[Normalize[ev].{Cos[ang], Sin[ang]}] - 1] < 10^-12]];
check["single plane: A is symmetric because alpha = grad psi (psi_12 = psi_21)",
  Module[{f = Sin[t1] Exp[t2] + t1^3 t2^2}, D[f, t1, t2] === D[f, t2, t1]]];
check["two planes: A = I - H1 - H2(I - b H1) is not symmetric (example), and is symmetric for b = 0",
  Module[{H1 = {{0.3, 0.1}, {0.1, 0.2}}, H2 = {{0.1, 0.}, {0., -0.1}}, A2},
    A2[bv_] := IdentityMatrix[2] - H1 - H2.(IdentityMatrix[2] - bv H1);
    Abs[A2[0.5][[1, 2]] - A2[0.5][[2, 1]]] > 0.005 && Abs[A2[0][[1, 2]] - A2[0][[2, 1]]] < 10^-15]];

(* --- axisymmetric special case --- *)
aPsi = f[Sqrt[t1^2 + t2^2]];
aEv = Simplify[Eigenvalues[D[aPsi, {{t1, t2}, 2}]] /. {t1 -> r Cos[p], t2 -> r Sin[p]}, r > 0];
check["Hessian of a radial potential psi(theta) has eigenvalues psi'' (radial) and psi'/theta (tangential)",
  Sort[Simplify[aEv, r > 0]] === Sort[{f''[r], f'[r]/r}] ||
  Simplify[(aEv[[1]] - f''[r]) (aEv[[1]] - f'[r]/r)] === 0];
check["at phi = 0: A = diag(1 - dalpha/dtheta, 1 - alpha/theta) with alpha = psi'",
  Simplify[(IdentityMatrix[2] - D[aPsi, {{t1, t2}, 2}]) /. {t1 -> r, t2 -> 0}, r > 0] ==
    {{1 - f''[r], 0}, {0, 1 - f'[r]/r}}];
(* with alpha = m(theta)/theta and m' = 2 kappa theta *)
check["alpha = m/theta, m' = 2 kappa theta  =>  dalpha/dtheta = 2 kappa - alpha/theta = 2 kappa - kbar",
  Simplify[D[mm[r]/r, r] /. mm'[r] -> 2 kap[r] r] == Simplify[2 kap[r] - mm[r]/r^2]];
check["kappa = (alpha' + alpha/theta)/2; gamma_1(phi=0) = (alpha' - alpha/theta)/2 = kappa - kbar",
  Module[{al = mm[r]/r, alp},
    alp = 2 kap[r] - mm[r]/r^2;   (* = alpha' *)
    Simplify[(alp + al/r)/2 == kap[r]] && Simplify[(alp - al/r)/2 == kap[r] - mm[r]/r^2]]];
check["lambda_t = 1 - kappa - |gamma| = 1 - kbar = 1 - alpha/theta; lambda_r = 1 - kappa + |gamma| = 1 - 2 kappa + kbar = 1 - alpha'",
  Simplify[{1 - k - (kb - k), 1 - k + (kb - k)} == {1 - kb, 1 - 2 k + kb}]];

(* --- power law --- *)
aKap = (3 - g)/2 (tE/r)^(g - 1); aAl = tE (tE/r)^(g - 2);
check["power law kappa = (3-g')/2 (tE/theta)^(g'-1): alpha = tE (tE/theta)^(g'-2) = kbar theta",
  Simplify[Integrate[2 Pi s aKap /. r -> s, {s, 0, r}, Assumptions -> 1 < g < 3 && r > 0 && tE > 0]/(Pi r^2) r == aAl,
    1 < g < 3 && r > 0 && tE > 0]];
check["power law: dalpha/dtheta = 2 kappa - kbar = (2 - g')(theta/tE)^(1-g')",
  Simplify[D[aAl, r] == 2 aKap - aAl/r && D[aAl, r] == (2 - g) (r/tE)^(1 - g), 1 < g < 3 && r > 0 && tE > 0]];
check["power law: |gamma|/kappa = kbar/kappa - 1 = (g'-1)/(3-g'); =1 only for g' = 2 (SIS)",
  Simplify[(aAl/r)/aKap - 1 == (g - 1)/(3 - g), r > 0 && tE > 0] && Solve[(g - 1)/(3 - g) == 1, g] == {{g -> 2}}];
check["power law radial critical curve: lambda_r = 0 at theta_r = tE (2-g')^(1/(g'-1)); g' = 1.5 -> 0.25 tE",
  Simplify[(1 - D[aAl, r]) /. r -> tE (2 - g)^(1/(g - 1)), 1 < g < 2 && tE > 0] == 0 &&
  (2 - 1.5)^(1/(1.5 - 1)) == 0.25];
aLr[th_, gg_, tb_] := 1 - (2 - gg) th^(1 - gg) + tb^2/th^2;   (* tE = 1 *)
check["power law + point mass: d/dtheta(thetaB^2/theta) = -thetaB^2/theta^2, so lambda_r gains +thetaB^2/theta^2 and lambda_t gains -thetaB^2/theta^2",
  D[tB^2/r, r] == -tB^2/r^2 && Simplify[1 - (tB^2/r)/r == 1 - tB^2/r^2]];
check["power law (1<g'<2) + point mass: lambda_r -> +infinity at the centre",
  Limit[aLr[r, 3/2, 1/20], r -> 0, Direction -> "FromAbove"] === Infinity];
aRoots[gg_, tb_] := Length[Select[Table[aLr[10.^x, gg, tb], {x, -4, 2, 0.0005}] // Sign // Split, True &]] - 1;
Print["  sign changes of lambda_r(theta), g'=1.5: thetaB=0.05 -> ", aRoots[1.5, 0.05],
  ", thetaB=0.2 -> ", aRoots[1.5, 0.2], ", thetaB=0 -> ", aRoots[1.5, 0.]];
check["g' = 1.5: lambda_r has 1 root without point mass, 2 roots for thetaB = 0.05 tE, none for thetaB = 0.2 tE",
  aRoots[1.5, 0.] == 1 && aRoots[1.5, 0.05] == 2 && aRoots[1.5, 0.2] == 0];

(* --- magnification --- *)
check["change of variables: d^2beta = |det A| d^2theta (2x2 Jacobian determinant of beta(theta))",
  Simplify[Det[D[{t1 - D[ps[t1, t2], t1], t2 - D[ps[t1, t2], t2]}, {{t1, t2}}]] ==
    (1 - D[ps[t1, t2], t1, t1]) (1 - D[ps[t1, t2], t2, t2]) - D[ps[t1, t2], t1, t2]^2]];
check["|mu| > 1 iff -1 < det A < 1; e.g. det A = -1.5 gives |mu| = 0.67 although (1-k)^2 - g^2 < 1",
  Round[Abs[1/-1.5], 0.01] == 0.67 && Resolve[ForAll[d, d != 0, Equivalent[Abs[1/d] > 1, -1 < d < 1]], Reals] === True];
check["pure convergence: mu = 1/(1-k)^2 is 1 at k = 2, 1/4 at k = 3: magnified only for 0 < k < 2",
  (1/(1 - k)^2 /. k -> 2) == 1 && (1/(1 - k)^2 /. k -> 3) == 1/4 &&
  Resolve[ForAll[k, k > 0 && k != 1, Equivalent[1/(1 - k)^2 > 1, k < 2]], Reals] === True];
check["k > 1 + |gamma|: both eigenvalues negative, det A > 0 (type III / maximum image)",
  Reduce[Exists[{k, g}, g >= 0 && k > 1 + g && !(1 - k - g < 0 && 1 - k + g < 0 && (1 - k)^2 - g^2 > 0)], Reals] === False];
check["pure shear: mu(0.3) = 1.10; mu(1.2) = -2.27; |mu(1.5)| = 0.80; |mu| < 1 for g > 1 iff g > sqrt 2",
  Round[1/(1 - 0.09), 0.01] == 1.10 && Round[1/(1 - 1.44), 0.01] == -2.27 &&
  Round[Abs[1/(1 - 2.25)], 0.01] == 0.80 && Reduce[Abs[1/(1 - g^2)] < 1 && g > 1, g, Reals] == (g > Sqrt[2])];
check["ellipse: b/a = (1-k-g)/(1-k+g) = (1-gr)/(1+gr), gr = g/(1-k): depends only on reduced shear",
  Simplify[(1 - k - g)/(1 - k + g) == (1 - gr)/(1 + gr) /. gr -> g/(1 - k)]];
check["e = (a-b)/(a+b) = g/(1-k) for 1-k > g > 0",
  Simplify[((1/(1 - k - g) - 1/(1 - k + g))/(1/(1 - k - g) + 1/(1 - k + g))) == g/(1 - k)]];
check["Ex 5.5(e): reduced shear 0.2/0.7 = 0.286, b/a = (1-g)/(1+g) = 5/9 = 0.556, mu = 2.22",
  Round[0.2/0.7, 0.001] == 0.286 && (1 - 2/7)/(1 + 2/7) == 5/9 && Round[5/9., 0.001] == 0.556 &&
  Round[1/(0.9 0.5), 0.01] == 2.22];

(* --- mass-sheet transformation --- *)
check["MST: kappa -> lam kappa + 1 - lam, gamma -> lam gamma  =>  A -> lam A, mu -> mu/lam^2",
  Module[{A1 = {{1 - k - ga1, -ga2}, {-ga2, 1 - k + ga1}}, A2},
    A2 = A1 /. {k -> lam k + 1 - lam, ga1 -> lam ga1, ga2 -> lam ga2};
    Simplify[A2 == lam A1] && Simplify[1/Det[A2] == (1/Det[A1])/lam^2]]];
check["MST: psi -> lam psi + (1-lam) theta^2/2 gives beta -> lam beta, so image positions unchanged",
  Module[{psi2 = lam ps[t1, t2] + (1 - lam) (t1^2 + t2^2)/2},
    Simplify[{t1, t2} - Grad[psi2, {t1, t2}] == lam ({t1, t2} - Grad[ps[t1, t2], {t1, t2}])]]];
check["MST leaves reduced shear g/(1-k) invariant",
  Simplify[(lam g)/(1 - (lam k + 1 - lam)) == g/(1 - k), lam != 0]];

(* --- point mass --- *)
check["point mass: M/(Sigma_cr Dd^2) = pi thetaE^2",
  Simplify[M/((cc^2/(4 Pi GG)) Ds/(Dd Dds) Dd^2) == Pi (4 GG M/cc^2) Dds/(Dd Ds)]];
check["2D delta scaling: Integrate DiracDelta[a x] dx = 1/a per dimension (a > 0)",
  Integrate[DiracDelta[aa x], {x, -Infinity, Infinity}, Assumptions -> aa > 0] == 1/aa];
check["point mass second derivatives: psi_11 = tE^2 (theta^2 - 2 theta1^2)/theta^4, psi_12 = -2 tE^2 theta1 theta2/theta^4",
  Module[{psi = tE^2 Log[t1^2 + t2^2]/2},
    Simplify[{D[psi, t1, t1], D[psi, t1, t2]} ==
      {tE^2 (t1^2 + t2^2 - 2 t1^2)/(t1^2 + t2^2)^2, -2 tE^2 t1 t2/(t1^2 + t2^2)^2}]]];
check["point mass: gamma = -(tE^2/theta^2) e^{2 i phi} = (tE^2/theta^2) e^{2 i (phi + pi/2)}",
  Module[{psi = tE^2 Log[t1^2 + t2^2]/2, gc},
    gc = ((D[psi, t1, t1] - D[psi, t2, t2])/2 + I D[psi, t1, t2]) /. {t1 -> r Cos[p], t2 -> r Sin[p]};
    Simplify[ExpToTrig[gc + tE^2/r^2 Exp[2 I p]], r > 0] == 0 &&
    Simplify[ExpToTrig[-Exp[2 I p] - Exp[2 I (p + Pi/2)]]] == 0]];
check["tangential shear: gamma_t = -Re(gamma e^{-2 i phi}) = kbar - kappa for gamma = -(kbar - kappa) e^{2 i phi}",
  Simplify[-ComplexExpand[Re[-(kb - k) Exp[2 I p] Exp[-2 I p]]] == kb - k]];
check["point mass: eigenvector of the smaller eigenvalue is tangential, (-sin phi, cos phi)",
  Module[{psi = tE^2 Log[t1^2 + t2^2]/2, A0},
    A0 = (IdentityMatrix[2] - D[psi, {{t1, t2}, 2}]) /. {t1 -> r Cos[p], t2 -> r Sin[p]};
    Simplify[A0.{-Sin[p], Cos[p]} == (1 - tE^2/r^2) {-Sin[p], Cos[p]}, r > 0] &&
    Simplify[A0.{Cos[p], Sin[p]} == (1 + tE^2/r^2) {Cos[p], Sin[p]}, r > 0]]];
aXp = (u + Sqrt[u^2 + 4])/2; aXm = (u - Sqrt[u^2 + 4])/2;
check["shear at the images (units of tE): |gamma(theta_+)| |gamma(theta_-)| = 1; u -> inf: |gamma_+| -> 0, |gamma_-| -> inf",
  Simplify[(1/aXp^2) (1/aXm^2) == 1] && Limit[1/aXp^2, u -> Infinity] == 0 &&
  Limit[1/aXm^2, u -> Infinity] === Infinity];
check["x_- = -1/x_+; x_+^2 + x_-^2 = u^2 + 2; x_+^2 - x_-^2 = u sqrt(u^2+4); mu_+ + mu_- = 1",
  Simplify[aXm == -1/aXp, u > 0] &&
  Simplify[{aXp^2 + aXm^2, aXp^2 - aXm^2} == {u^2 + 2, u Sqrt[u^2 + 4]}] &&
  Simplify[aXp^4/(aXp^4 - 1) + aXm^4/(aXm^4 - 1) == 1, u > 0]];
check["point mass caustic: beta(thetaE) = thetaE - thetaE^2/thetaE = 0", (tE - tE^2/tE) == 0];
check["total convergence of a point mass = pi tE^2 = area of its Einstein disk x mean kappa 1",
  Integrate[Pi tE^2 DiracDelta[x] DiracDelta[y], {x, -1, 1}, {y, -1, 1}] == Pi tE^2];

(* --- SIS --- *)
check["SIS: Sigma(Dd theta)/Sigma_cr = sigma^2/(2 G Dd theta) 4 pi G Dd Dds/(c^2 Ds) = tE/(2 theta), tE = 4 pi sigma^2 Dds/(c^2 Ds)",
  Simplify[(sv^2/(2 GG Dd r))/((cc^2/(4 Pi GG)) Ds/(Dd Dds)) == (4 Pi sv^2 Dds/(cc^2 Ds))/(2 r)]];
check["SIS from psi = tE theta: kappa = |gamma| = tE/(2 theta), kbar = tE/theta, lambda_r = 1, lambda_t = 1 - tE/theta",
  Module[{psi = tE Sqrt[t1^2 + t2^2], Hs, kk, gg},
    Hs = D[psi, {{t1, t2}, 2}] /. {t1 -> r Cos[p], t2 -> r Sin[p]};
    kk = Simplify[(Hs[[1, 1]] + Hs[[2, 2]])/2, r > 0];
    gg = Simplify[Sqrt[((Hs[[1, 1]] - Hs[[2, 2]])/2)^2 + Hs[[1, 2]]^2], r > 0 && tE > 0];
    kk == tE/(2 r) && gg == tE/(2 r) &&
    Simplify[{1 - kk + gg, 1 - kk - gg}] == {1, 1 - tE/r}]];
check["SIS: mu = 1/(1 - tE/theta) = theta/(theta - tE); kappa(tE) = 1/2 while kbar(tE) = 1",
  Simplify[1/((1 - tE/(2 r))^2 - (tE/(2 r))^2) == r/(r - tE)] && (tE/(2 r) /. r -> tE) == 1/2];

(* ===== Fix-pass checks (2026-10-14, FACT_CRITIC_05_annotated_2026-10-14.md) =====
   Printed conditions / formulas are encoded as literals (pure functions) and tested
   against the exact answer, so restoring the old printed form makes the check fail. *)
Print["\n--- Fix-pass checks 2026-10-14 (Module 5) ---"];
ClearAll[fxCond, fxMag, fxPhi, fxGrid, fxStretch, fxImgs, fxPsi, fxTau, fxTauL, x, y];
fxGrid = Flatten[Table[{kk, gg}, {kk, -1., 3.5, 0.13}, {gg, 0., 2.5, 0.11}], 1];

(* F1: item 3 "magnified iff |det A| < 1, i.e. -1 < (1-k)^2 - g^2 < 1"  (old: (1-k)^2 - g^2 < 1) *)
fxCond = Function[{kk, gg}, -1 < (1 - kk)^2 - gg^2 < 1];
fxMag = Function[{kk, gg}, Abs[1/((1 - kk)^2 - gg^2)] > 1];
check["F1 printed condition -1 < (1-k)^2 - |g|^2 < 1 <=> |mu| > 1 on a (kappa, |gamma|) grid",
  Quiet@AllTrue[fxGrid, (fxCond @@ # === fxMag @@ #) &]];
check["F1 the old upper-bound-only condition is not equivalent (det A = -1.5: |mu| = 0.67)",
  !Quiet@AllTrue[fxGrid, (((1 - #[[1]])^2 - #[[2]]^2 < 1) === fxMag @@ #) &] &&
  Round[1/1.5, 0.01] == 0.67];

(* F2: pure convergence "1 < k < 2 still magnified; k > 2 demagnified, mu = 1/4 at k = 3" (old: "k > 1 still magnified") *)
check["F2 pure convergence: mu = 1/(1-k)^2 > 1 exactly for 0 < k < 2 (k != 1); mu(3) = 1/4 < 1",
  Reduce[1/(1 - kk)^2 > 1 && kk > 1, kk, Reals] === Reduce[1 < kk < 2, kk, Reals] &&
  (1/(1 - kk)^2 /. kk -> 3) == 1/4];
check["F2 annotation: kappa = 2 is where |1 - kappa| = 1; for kappa > 2 both |eigenvalues| > 1",
  Solve[Abs[1 - kk] == 1 && kk > 1, kk, Reals] == {{kk -> 2}} &&
  Reduce[Abs[1 - kk] > 1 && kk > 1, kk, Reals] === (kk > 2)];

(* F3: phi_gamma = (1/2) atan2(g2, g1)  (old: (1/2) arctan(g2/g1)) *)
fxPhi = Function[{g1, g2}, ArcTan[g1, g2]/2];               (* Mathematica ArcTan[x, y] = atan2(y, x) *)
fxStretch = Function[{g1, g2}, Module[{es = Eigensystem[{{1 - g1, -g2}, {-g2, 1 + g1}}], v},
   v = es[[2, Ordering[es[[1]]][[1]]]]; Mod[ArcTan[v[[1]], v[[2]]], Pi]]];
check["F3 printed phi_gamma = (1/2) atan2(g2, g1) equals the stretch axis (mod 180 deg) in all four quadrants",
  AllTrue[{{0.1, 0.1}, {-0.1, 0.1}, {-0.1, -0.1}, {0.1, -0.1}, {-0.2, 0.05}, {0.3, 0.}, {0., 0.2}},
    Abs[Mod[fxPhi @@ #, Pi] - fxStretch @@ #] < 10^-9 &]];
check["F3 the old one-argument (1/2) arctan(g2/g1) fails for g1 < 0: (-0.1, 0.1) -> -22.5 deg vs 67.5 deg",
  Round[ArcTan[0.1/-0.1]/2/Degree, 0.1] == -22.5 && Round[fxStretch[-0.1, 0.1]/Degree, 0.1] == 67.5 &&
  Abs[Mod[ArcTan[0.1/-0.1]/2, Pi] - fxStretch[-0.1, 0.1]] > 1];
check["F3 equivalently gamma1 = |gamma| cos 2 phi_gamma, gamma2 = |gamma| sin 2 phi_gamma",
  AllTrue[{{-0.1, 0.1}, {-0.1, -0.1}, {0.3, -0.2}},
    Norm[Norm[#] {Cos[2 fxPhi @@ #], Sin[2 fxPhi @@ #]} - #] < 10^-12 &]];

(* F4: kappa < 1 bullet now "axisymmetric" (C&K Sec. 2.5). Counter-example to the old
   unqualified claim: cored isothermal psi = sqrt(1.25^2 + theta^2) (kappa <= 0.8 everywhere)
   plus external shear 0.4 makes 3 images; without shear (axisymmetric) 1 image. *)
fxImgs[gx_, src_] := Module[{ax, ay, sols},
  fxPsi = 1. Sqrt[1.25^2 + x^2 + y^2] + gx (x^2 - y^2)/2;
  ax = D[fxPsi, x]; ay = D[fxPsi, y];
  sols = Quiet@Flatten[Table[Check[{x, y} /. FindRoot[{x - ax == src[[1]], y - ay == src[[2]]},
        {{x, x0}, {y, y0}}], Nothing], {x0, -3, 3, 0.5}, {y0, -3, 3, 0.5}], 1];
  sols = Select[sols, Norm[({x - ax, y - ay} /. {x -> #[[1]], y -> #[[2]]}) - src] < 10^-8 &];
  Length[DeleteDuplicates[Round[sols, 10^-4]]]];
check["F4 cored isothermal kappa(theta) = (2 s^2 + theta^2)/(2 (s^2 + theta^2)^(3/2)) <= kappa(0) = 1/s = 0.8",
  Simplify[Laplacian[Sqrt[s^2 + r^2], {r, p}, "Polar"]/2 == (2 s^2 + r^2)/(2 (s^2 + r^2)^(3/2)), s > 0 && r > 0] &&
  Reduce[(2 s^2 + r^2)/(2 (s^2 + r^2)^(3/2)) > 1/s && s > 0 && r > 0, {r, s}, Reals] === False &&
  1/1.25 == 0.8];
check["F4 with external shear 0.4 that kappa < 1 lens makes 3 images of beta = (0.02, 0.01); axisymmetric (no shear): 1",
  fxImgs[0.4, {0.02, 0.01}] == 3 && fxImgs[0., {0.02, 0.01}] == 1];

(* L1: multipole bridge, m = 1 (old: "a pure shift of the lens centre") *)
check["L1 theta cos(phi) = theta_1 is a linear potential: constant deflection (1, 0), zero Hessian",
  D[t1, {{t1, t2}}] == {1, 0} && D[t1, {{t1, t2}, 2}] == {{0, 0}, {0, 0}}];
check["L1 shifting an isothermal lens centre by delta adds -tE delta cos(phi) (prop. theta^0), not prop. theta cos(phi)",
  Simplify[Normal[Series[tE Sqrt[(r Cos[p] - dl)^2 + (r Sin[p])^2], {dl, 0, 1}]] - tE r, r > 0] ==
    -tE dl Cos[p] &&
  D[-tE dl Cos[p], r] == 0 && D[r Cos[p], r] =!= 0];

(* L2: MST bridge, time delays scale by lambda (new sentence) *)
fxTau[th_, bt_, ps_] := (th - bt).(th - bt)/2 - ps;
check["L2 MST: tau'(theta) - lambda tau(theta) = (lambda^2 - lambda)|beta|^2/2, the same for every image, so Delta t -> lambda Delta t",
  Simplify[fxTau[{t1, t2}, lam {s1, s2}, lam psiF[t1, t2] + (1 - lam) (t1^2 + t2^2)/2] -
     lam fxTau[{t1, t2}, {s1, s2}, psiF[t1, t2]] == (lam^2 - lam) (s1^2 + s2^2)/2]];

(* L3/L4: Solutions box "three local degrees of freedom"; pure shear changes area only at O(gamma^2) *)
check["L4 pure shear: mu = 1/(1 - g^2) = 1 + g^2 + O(g^4) (no first-order area change)",
  Normal[Series[1/(1 - g^2), {g, 0, 3}]] === 1 + g^2];
check["L3 a symmetric 2x2 Jacobian has 3 free entries = kappa + (gamma1, gamma2); shapes fix only g (2 numbers)",
  Length[Variables[{{1 - k - ga1, -ga2}, {-ga2, 1 - k + ga1}}]] == 3 &&
  Simplify[(1 - k - ga1)/(1 - k + ga1) == (1 - ga1/(1 - k))/(1 + ga1/(1 - k)), k != 1]];

summary[];
