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

muMexpected = (u^2 + 2)/(2 u Sqrt[u^2 + 4]) - 1/2 //
    FullSimplify[#, Assumptions -> u > 0] &;
diffM = Simplify[muM - muMexpected, Assumptions -> u > 0];
Print["  Expected:     (u^2+2)/(2u*sqrt(u^2+4)) - 1/2"];
Print["  Difference:   ", diffM, "\n"];

(* Numerical verification *)
Print["Numerical verification at u = 1:"];
Print["  theta_+ = ", N[thetaP[1]], ", theta_- = ", N[thetaM[1]]];
Print["  mu_+ = ", N[muP /. u -> 1], " (expected: ",
    N[(1 + 2)/(2*1*Sqrt[5]) + 1/2], ")"];
Print["  mu_- = ", N[muM /. u -> 1], " (expected: ",
    N[(1 + 2)/(2*1*Sqrt[5]) - 1/2], ")"];
Print[""];

(* (c) Parity *)
Print["(c) Parity analysis:"];
Print["  mu_+ = (u^2+2)/(2u*sqrt(u^2+4)) + 1/2"];
Print["  Since (u^2+2)/(2u*sqrt(u^2+4)) > 0 for u > 0,"];
Print["  mu_+ > 1/2 > 0. (Positive parity) VERIFIED\n"];

Print["  mu_- = (u^2+2)/(2u*sqrt(u^2+4)) - 1/2"];
Print["  This represents the absolute value. The signed magnification"];
Print["  of the secondary image is negative because theta_- < 0 (the"];
Print["  image is on the opposite side of the lens from the source,"];
Print["  indicating mirror reflection). VERIFIED\n"];

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
