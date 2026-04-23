(* ::Package:: *)

(* =============================================================================
   nfw_projection.wl
   -----------------------------------------------------------------------------
   Purpose:  Step-by-step symbolic verification of the NFW surface mass density
             Sigma(x), convergence kappa(x), and deflection angle alpha(x).

   Derivation outline (mirrors Notes/07_Axisymmetric_Models, Sec. on NFW):

       Sigma(xi)  =  int_{-infty}^{infty} rho( sqrt(xi^2 + z^2) ) dz
                  =  2 rho_s r_s * I(x),      x = xi / r_s

       I(x)       =  int_0^infty du / [ sqrt(x^2+u^2) (1 + sqrt(x^2+u^2))^2 ]
                  =  int_x^infty dw / [ (1+w)^2 sqrt(w^2 - x^2) ]     (w = sqrt(x^2+u^2))
                  =  [ 1 - K(x) ] / (x^2 - 1)          (integration by parts identity)

       K(x)       =  int_x^infty dw / [ (1+w) sqrt(w^2 - x^2) ]
                  =  int_0^infty dtau / (1 + x cosh tau)            (w = x cosh tau)

       K(x)       =  arccosh(1/x) / sqrt(1-x^2),       x < 1
                  =  arctan(sqrt(x^2-1)) / sqrt(x^2-1), x > 1
                  -> 1 at x = 1 (by L'Hopital)

       Sigma(x)   =  2 rho_s r_s * f(x),  f(x) = [1 - K(x)] / (x^2 - 1)

   Then, from the axisymmetric lens relation alpha(theta) = theta * kappabar(theta),

       kappabar(x)  =  (2 / x^2) int_0^x f(x') x' dx'
                    =  (2 / x^2) [ ln(x/2) + g(x) ],     g(x) = K(x)

       alpha(x)     =  (2 kappa_s theta_s / x) [ ln(x/2) + g(x) ],
       with          kappa_s = 2 rho_s r_s / Sigma_cr.

   Sources:  Bartelmann 1996 (A&A 313, 697); Wright & Brainerd 2000 (ApJ 534, 34).
   Outputs:  All checks print "True" or a small residual.  No file export.
   ========================================================================== *)

Print["========================================================================"];
Print["  NFW projection and deflection: symbolic verification"];
Print["========================================================================"];

(* -------------------------------------------------------------------------
   Step 0.  Closed-form NFW functions f(x), g(x), K(x).
   Use the three-branch piecewise form with the x < 1 and x > 1 cases.
   (Extending symbolically to all x > 0; x=1 handled by Limit below.)
   ------------------------------------------------------------------------- *)
Kfun[x_] := Piecewise[{
    {ArcCosh[1/x] / Sqrt[1 - x^2], 0 < x < 1},
    {1,                           x == 1},
    {ArcTan[Sqrt[x^2 - 1]] / Sqrt[x^2 - 1], x > 1}
}];

fNFW[x_] := Piecewise[{
    {(1 - Kfun[x]) / (x^2 - 1), x != 1},
    {1/3,                       x == 1}
}];

gNFW[x_] := Kfun[x];  (* In this derivation g(x) and K(x) coincide. *)

hNFW[x_] := Log[x/2] + gNFW[x];  (* The antiderivative h(x) = int_0^x f(x')x' dx'. *)


(* -------------------------------------------------------------------------
   Step 1.  The projection integral I(x) equals f(x).

   I(x) = int_0^infty du / [sqrt(x^2+u^2) (1 + sqrt(x^2+u^2))^2]

   Numerical check at representative values of x (inner, x=1, outer).
   ------------------------------------------------------------------------- *)
Print["\n--- Step 1: projection integral  I(x) = int_0^inf du/(sqrt(x^2+u^2)(1+sqrt(x^2+u^2))^2)"];
Print["--- Compare to f(x) = [1 - K(x)] / (x^2 - 1)."];

testXs = {0.2, 0.5, 0.9, 1.0, 1.1, 2.0, 5.0};
Do[
    Iint = NIntegrate[1/(Sqrt[xv^2 + u^2] (1 + Sqrt[xv^2 + u^2])^2),
                      {u, 0, Infinity},
                      Method -> {"GlobalAdaptive", "MaxErrorIncreases" -> 10000},
                      PrecisionGoal -> 10];
    Iclosed = N[fNFW[xv], 15];
    residual = Abs[Iint - Iclosed];
    Print["   x = ", NumberForm[xv, {4, 2}],
          "   I(x) (numeric) = ", NumberForm[Iint, 10],
          "   f(x) (closed)  = ", NumberForm[Iclosed, 10],
          "   |diff| = ", ScientificForm[residual, 3]],
    {xv, testXs}
];


(* -------------------------------------------------------------------------
   Step 2.  The change of variables w = sqrt(x^2 + u^2) gives

       I(x) = int_x^infty dw / [(1+w)^2 sqrt(w^2 - x^2)].

   Check numerically for a few x.
   ------------------------------------------------------------------------- *)
Print["\n--- Step 2: after substitution  w = sqrt(x^2+u^2):  int_x^inf dw / ((1+w)^2 sqrt(w^2-x^2))"];
Do[
    Iw = NIntegrate[1/((1 + w)^2 Sqrt[w^2 - xv^2]),
                    {w, xv, Infinity},
                    Method -> {"GlobalAdaptive", "MaxErrorIncreases" -> 10000},
                    PrecisionGoal -> 10];
    Iu = NIntegrate[1/(Sqrt[xv^2 + u^2] (1 + Sqrt[xv^2 + u^2])^2),
                    {u, 0, Infinity}, PrecisionGoal -> 10];
    Print["   x = ", NumberForm[xv, {4, 2}],
          "   w-integral = ", NumberForm[Iw, 10],
          "   u-integral = ", NumberForm[Iu, 10],
          "   |diff| = ", ScientificForm[Abs[Iw - Iu], 3]],
    {xv, testXs}
];


(* -------------------------------------------------------------------------
   Step 3.  Integration-by-parts identity:

       d/dw [ sqrt(w^2 - x^2) / (1 + w) ]
           = (w + x^2) / [(1+w)^2 sqrt(w^2 - x^2)].

   Hence I(x) = [1 - K(x)] / (x^2 - 1),  with  K(x) = int_x^inf dw / ((1+w) sqrt(w^2-x^2)).
   ------------------------------------------------------------------------- *)
Print["\n--- Step 3: verify d/dw[sqrt(w^2-x^2)/(1+w)] = (w+x^2)/[(1+w)^2 sqrt(w^2-x^2)]"];
dCheck = FullSimplify[
    D[Sqrt[w^2 - x^2]/(1 + w), w] - (w + x^2)/((1 + w)^2 Sqrt[w^2 - x^2]),
    Assumptions -> {w > x > 0}];
Print["   residual = ", dCheck, "   (expect 0)"];


(* -------------------------------------------------------------------------
   Step 4.  With w = x cosh(tau), K(x) = int_0^inf dtau / (1 + x cosh tau).
   Closed-form integral for both x < 1 and x > 1 (Weierstrass substitution).
   ------------------------------------------------------------------------- *)
Print["\n--- Step 4: K(x) from hyperbolic substitution w = x cosh(tau)."];
Do[
    Knum = NIntegrate[1/(1 + xv Cosh[tau]), {tau, 0, Infinity}, PrecisionGoal -> 10];
    Kclosed = N[Kfun[xv], 15];
    Print["   x = ", NumberForm[xv, {4, 2}],
          "   K(x) (num) = ", NumberForm[Knum, 10],
          "   K(x) (closed) = ", NumberForm[Kclosed, 10],
          "   |diff| = ", ScientificForm[Abs[Knum - Kclosed], 3]],
    {xv, testXs}
];


(* -------------------------------------------------------------------------
   Step 5.  Continuity at x = 1:  lim f(x) = 1/3, lim g(x) = 1.
   ------------------------------------------------------------------------- *)
Print["\n--- Step 5: continuity at x = 1."];
Print["   lim_{x->1-} f(x) = ", Limit[(1 - ArcCosh[1/x]/Sqrt[1 - x^2])/(x^2 - 1), x -> 1, Direction -> "FromBelow"]];
Print["   lim_{x->1+} f(x) = ", Limit[(1 - ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1])/(x^2 - 1), x -> 1, Direction -> "FromAbove"]];
Print["   lim_{x->1-} g(x) = ", Limit[ArcCosh[1/x]/Sqrt[1 - x^2], x -> 1, Direction -> "FromBelow"]];
Print["   lim_{x->1+} g(x) = ", Limit[ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1], x -> 1, Direction -> "FromAbove"]];


(* -------------------------------------------------------------------------
   Step 6.  The antiderivative h(x) = int_0^x f(x') x' dx'.

   Claim:  h(x) = ln(x/2) + g(x).   We verify two things:
     (a)  d/dx [ ln(x/2) + g(x) ]  =  x f(x).
     (b)  lim_{x->0+} [ ln(x/2) + g(x) ]  =  0  (the integral from 0).
   ------------------------------------------------------------------------- *)
Print["\n--- Step 6: verify h(x) = ln(x/2) + g(x) is the antiderivative of x f(x)."];

Print["   (a) d/dx[ln(x/2)+g(x)] - x f(x) for x < 1:"];
residA1 = FullSimplify[
    D[Log[x/2] + ArcCosh[1/x]/Sqrt[1 - x^2], x]
      - x*(1 - ArcCosh[1/x]/Sqrt[1 - x^2])/(x^2 - 1),
    Assumptions -> {0 < x < 1}];
Print["       residual (symbolic) = ", residA1, "   (expect 0)"];

Print["   (a) d/dx[ln(x/2)+g(x)] - x f(x) for x > 1:"];
residA2 = FullSimplify[
    D[Log[x/2] + ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1], x]
      - x*(1 - ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1])/(x^2 - 1),
    Assumptions -> {x > 1}];
Print["       residual (symbolic) = ", residA2, "   (expect 0)"];

Print["   (b) lim_{x->0+} [ln(x/2) + g(x)] = ",
    Limit[Log[x/2] + ArcCosh[1/x]/Sqrt[1 - x^2], x -> 0, Direction -> "FromAbove"]];


(* -------------------------------------------------------------------------
   Step 7.  Numerical check: int_0^x f(x') x' dx' == h(x).
   ------------------------------------------------------------------------- *)
Print["\n--- Step 7: numerical confirmation that  int_0^x f(x')x' dx' = ln(x/2) + g(x)."];
Do[
    hNum = NIntegrate[Re[(fNFW[xp] /. {xp -> xp}) xp],
                      {xp, 10^-6, xv},
                      Method -> "LocalAdaptive",
                      PrecisionGoal -> 8];
    hClosed = N[hNFW[xv], 15];
    Print["   x = ", NumberForm[xv, {4, 2}],
          "   num integral = ", NumberForm[hNum, 8],
          "   closed h(x) = ", NumberForm[hClosed, 8],
          "   |diff| = ", ScientificForm[Abs[hNum - hClosed], 3]],
    {xv, {0.3, 0.5, 0.9, 1.5, 3.0}}
];


(* -------------------------------------------------------------------------
   Step 8.  Which factor is correct for alpha(x) and kappabar(x)?
   Derivation:
       alpha(theta) = theta * kappabar(theta) = (2/theta) * int_0^theta kappa(theta')theta' dtheta'
   With theta = x theta_s, kappa(theta) = kappa_s f(x):
       int_0^theta kappa(theta') theta' dtheta' = kappa_s theta_s^2 h(x)
   so  alpha(theta) = (2 kappa_s theta_s / x) h(x)
   and kappabar(x)  = (2 kappa_s / x^2)  h(x).
   (Factor of 2, not 4, given the convention kappa_s = 2 rho_s r_s / Sigma_cr.)

   Direct cross-check:  compute kappabar numerically via definition and compare
   to (2/x^2) h(x).  Use kappa = f(x) (set kappa_s = 1 throughout).
   ------------------------------------------------------------------------- *)
Print["\n--- Step 8: establish the correct factor in alpha and kappabar."];
Print["   Using kappa(x) = kappa_s f(x) with kappa_s = 2 rho_s r_s / Sigma_cr."];
Print["   Definition:     kappabar(x) = (2/x^2) int_0^x kappa(x')/kappa_s * x' dx'."];
Print["   Expected:       kappabar(x) / kappa_s = (2/x^2) h(x)    (factor 2)"];
Do[
    kbarDef = (2/xv^2) NIntegrate[Re[fNFW[xp] xp], {xp, 10^-6, xv}, PrecisionGoal -> 8];
    kbarFactor2 = N[(2/xv^2) hNFW[xv], 15];
    kbarFactor4 = N[(4/xv^2) hNFW[xv], 15];
    Print["   x = ", NumberForm[xv, {4, 2}],
          "   kbar/kappa_s (num) = ", NumberForm[kbarDef, 6],
          "   2h/x^2 = ", NumberForm[kbarFactor2, 6],
          "   4h/x^2 = ", NumberForm[kbarFactor4, 6],
          "   match with factor-2? ", Abs[kbarDef - kbarFactor2] < 1.*^-4],
    {xv, {0.3, 0.5, 0.9, 1.5, 3.0}}
];


Print["\n========================================================================"];
Print["  End of NFW projection verification."];
Print["========================================================================"];
