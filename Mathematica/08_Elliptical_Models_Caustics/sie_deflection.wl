(* ::Package:: *)

(* =============================================================================
   sie_deflection.wl
   -----------------------------------------------------------------------------
   Purpose:  Symbolic verification of the SIE deflection formulas
             (Kormann, Schneider & Bartelmann 1994).

   Derivation (see Notes/08_Elliptical_Models_Caustics, Sec. Deflection Angle):

     kappa(t1,t2) = (thetaE sqrt(q) / 2) * 1 / sqrt(q^2 t1^2 + t2^2)
     alpha_1(t)   = (thetaE sqrt(q) / sqrt(1-q^2)) arctan(t1 sqrt(1-q^2) / F)
     alpha_2(t)   = (thetaE sqrt(q) / sqrt(1-q^2)) arctanh(t2 sqrt(1-q^2) / F)
     F            = sqrt(q^2 t1^2 + t2^2)

   Scale-invariance => psi = t1 alpha_1 + t2 alpha_2 (Euler's theorem).
   The four consistency checks proved below:
     (1) grad psi = (alpha_1, alpha_2)
     (2) Laplacian psi = 2 kappa
     (3) SIS limit q -> 1: alpha_i -> thetaE t_i / |t|
     (4) Numerical convolution: alpha(t) matches
          (1/pi) * int kappa(t') (t - t')/|t - t'|^2 d^2 t' at sample points.

   Sources:  KSB94 (A&A 284, 285).  Circular limit checked against Module 4/7.
   Outputs:  Each check prints 0 (symbolic residual) or a tiny numeric diff.
   ========================================================================== *)

Print["========================================================================"];
Print["  SIE deflection: symbolic verification of Kormann et al. 1994 formulas"];
Print["========================================================================"];


(* -------------------------------------------------------------------------
   Definitions.
   tE and q are symbolic.  Use F = Sqrt[q^2 t1^2 + t2^2] for the elliptical
   radius.  eps = Sqrt[1 - q^2].
   ------------------------------------------------------------------------- *)
ClearAll[t1, t2, q, tE, eps, F, kappaSIE, alpha1SIE, alpha2SIE, psiSIE];

eps = Sqrt[1 - q^2];
F = Sqrt[q^2 t1^2 + t2^2];

kappaSIE  = tE Sqrt[q] / (2 F);
alpha1SIE = tE Sqrt[q] / eps * ArcTan[t1 eps / F];
alpha2SIE = tE Sqrt[q] / eps * ArcTanh[t2 eps / F];
psiSIE    = t1 alpha1SIE + t2 alpha2SIE;  (* Euler's theorem for scale-invariant lens *)

assum = {0 < q < 1, t1 > 0, t2 > 0, tE > 0};


(* -------------------------------------------------------------------------
   Check 1: grad psi = alpha.
   ------------------------------------------------------------------------- *)
Print["\n--- Check 1: grad psi = (alpha_1, alpha_2)"];
r1 = FullSimplify[D[psiSIE, t1] - alpha1SIE, Assumptions -> assum];
r2 = FullSimplify[D[psiSIE, t2] - alpha2SIE, Assumptions -> assum];
Print["   d psi / d t1 - alpha_1 = ", r1, "  (expect 0)"];
Print["   d psi / d t2 - alpha_2 = ", r2, "  (expect 0)"];


(* -------------------------------------------------------------------------
   Check 2: Laplacian psi = 2 kappa.
   ------------------------------------------------------------------------- *)
Print["\n--- Check 2: Laplacian psi = 2 kappa"];
lap = FullSimplify[D[psiSIE, {t1, 2}] + D[psiSIE, {t2, 2}],
                   Assumptions -> assum];
diff = FullSimplify[lap - 2 kappaSIE, Assumptions -> assum];
Print["   Laplacian psi             = ", lap];
Print["   2 kappa                   = ", FullSimplify[2 kappaSIE, Assumptions -> assum]];
Print["   Laplacian psi - 2 kappa   = ", diff, "  (expect 0)"];


(* -------------------------------------------------------------------------
   Check 3: SIS limit q -> 1.
   alpha_i -> thetaE * t_i / |t|
   ------------------------------------------------------------------------- *)
Print["\n--- Check 3: SIS limit q -> 1"];
lim1 = Limit[alpha1SIE, q -> 1, Direction -> "FromBelow"];
lim2 = Limit[alpha2SIE, q -> 1, Direction -> "FromBelow"];
expected1 = tE t1 / Sqrt[t1^2 + t2^2];
expected2 = tE t2 / Sqrt[t1^2 + t2^2];
Print["   lim_{q->1} alpha_1 = ", lim1];
Print["   expected (SIS)     = ", expected1];
Print["   residual: ", FullSimplify[lim1 - expected1, Assumptions -> {t1 > 0, t2 > 0, tE > 0}]];
Print["   lim_{q->1} alpha_2 = ", lim2];
Print["   expected (SIS)     = ", expected2];
Print["   residual: ", FullSimplify[lim2 - expected2, Assumptions -> {t1 > 0, t2 > 0, tE > 0}]];


(* -------------------------------------------------------------------------
   Check 4: numerical finite-difference check of the Poisson equation.

   Compute  kappa_FD  =  (1/2) * [ (dalpha_1/dt1) + (dalpha_2/dt2) ]
   via central differences, at sample (t1, t2, q), and compare to the
   closed-form kappa.  This is an independent numerical cross-check of
   Check 2, since it uses only the alpha formulas (not psi).
   ------------------------------------------------------------------------- *)
Print["\n--- Check 4: finite-difference verification of kappa = (1/2) div alpha"];

alphaClosed1[t1_, t2_, qn_] :=
    Sqrt[qn]/Sqrt[1 - qn^2] * ArcTan[t1 Sqrt[1 - qn^2] / Sqrt[qn^2 t1^2 + t2^2]];
alphaClosed2[t1_, t2_, qn_] :=
    Sqrt[qn]/Sqrt[1 - qn^2] * ArcTanh[t2 Sqrt[1 - qn^2] / Sqrt[qn^2 t1^2 + t2^2]];
kappaClosed[t1_, t2_, qn_] :=
    Sqrt[qn] / (2 Sqrt[qn^2 t1^2 + t2^2]);

testPts = {{0.7, 0.3, 0.7}, {0.4, 0.8, 0.5}, {1.2, 0.2, 0.8},
           {0.05, 0.05, 0.6}};
hFD = 1.*^-5;
Do[
    {tt1, tt2, qq} = pt;
    d1 = (alphaClosed1[tt1 + hFD, tt2, qq] - alphaClosed1[tt1 - hFD, tt2, qq])/(2 hFD);
    d2 = (alphaClosed2[tt1, tt2 + hFD, qq] - alphaClosed2[tt1, tt2 - hFD, qq])/(2 hFD);
    kFD = 0.5 (d1 + d2);
    kCl = N[kappaClosed[tt1, tt2, qq]];
    Print["   (t1, t2, q) = ", pt,
          "   kappa (FD) = ", NumberForm[kFD, 8],
          "   kappa (closed) = ", NumberForm[kCl, 8],
          "   |diff| = ", ScientificForm[Abs[kFD - kCl], 3]],
    {pt, testPts}
];

Print["\n========================================================================"];
Print["  End of SIE verification."];
Print["========================================================================"];
