(* =========================================================================
   problems_12.wl
   Module 12: Weak Gravitational Lensing and Cosmic Shear --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to the exercises of Module 12, verified
            symbolically and numerically with Mathematica.

   Sources: Schneider, Kochanek & Wambsganss (2006), Part 3 (P. Schneider):
              Sect. 2   (eqs. 8, 9, 14, 16, 17, 24)
              Sect. 5.1 (eqs. 41, 43, 44, 51)
              Sect. 6   (eqs. 104, 105, 113)
            Kaiser & Squires (1993); Bartelmann & Schneider (2001).

   Usage:   wolframscript -file problems_12.wl

   Exercises solved:
     12.1 --- Reduced shear invariance under the mass-sheet transform
     12.2 --- Tangential shear and the excess surface mass density
     12.3 --- The Kaiser-Squires kernel and inversion
     12.4 --- Complex-ellipticity definitions and transforms
     12.5 --- Cosmic-shear correlation functions and parity
   ========================================================================= *)

Print["=== Module 12: SOLUTIONS ===\n"];

check[label_, bool_] := Print[If[TrueQ[bool], "  PASS  ", "  FAIL  "], label];


(* =========================================================================
   Exercise 12.1: Reduced shear and the mass-sheet degeneracy
   ========================================================================= *)

Print["--- Exercise 12.1: Mass-sheet transform ---\n"];

kappaP = lam kap + (1 - lam);
gammaP = lam gam;

Print["(a) g = gamma/(1-kappa) under MST:"];
gInv = Simplify[gammaP/(1 - kappaP) - gam/(1 - kap)];
Print["    g' - g = ", gInv];
check["12.1(a) reduced shear g invariant", gInv === 0];

Print["(b) mu = 1/[(1-kappa)^2 - gamma^2] under MST:"];
muRatio = Simplify[(1/((1 - kappaP)^2 - gammaP^2)) / (1/((1 - kap)^2 - gam^2))];
Print["    mu'/mu = ", muRatio];
check["12.1(b) magnification mu -> lambda^-2 mu", Simplify[muRatio - 1/lam^2] === 0];

Print["(c) Ellipticities measure only g, which is invariant => local"];
Print["    measurement cannot break the degeneracy; magnification (number"];
Print["    counts, mu -> lambda^-2 mu) can.\n"];

Print["(d) Uniform sheet kappa = 1-lambda has psi with grad^2 psi = 2(1-lambda),"];
Print["    i.e. psi = (1-lambda)(theta1^2+theta2^2)/2; its shear is"];
psiSheet = (1 - lam) (t1^2 + t2^2)/2;
g1sheet = (D[psiSheet, {t1, 2}] - D[psiSheet, {t2, 2}])/2;
g2sheet = D[psiSheet, t1, t2];
Print["    gamma1 = ", g1sheet, ",  gamma2 = ", g2sheet, "  => gamma = 0."];
check["12.1(d) uniform mass sheet produces zero shear",
    Simplify[g1sheet] === 0 && Simplify[g2sheet] === 0];
Print[""];


(* =========================================================================
   Exercise 12.2: Tangential shear and the excess surface mass density
   ========================================================================= *)

Print["--- Exercise 12.2: Tangential shear ---\n"];

Print["(a) SIS: kappa = thetaE/(2 theta):"];
kappaSIS[th_] := tE/(2 th);
kbarSIS = Simplify[(2/th^2) Integrate[kappaSIS[tp] tp, {tp, 0, th},
    Assumptions -> {th > 0, tE > 0}], Assumptions -> th > 0];
gtSIS = Simplify[kbarSIS - kappaSIS[th]];
Print["    kbar = ", kbarSIS, ",  gamma_t = kbar - kappa = ", gtSIS];
check["12.2(a) SIS gamma_t = thetaE/(2 theta)", Simplify[gtSIS - tE/(2 th)] === 0];

Print["(b) Point mass: kappa = 0, kbar = thetaE^2/theta^2:"];
gtPM = Simplify[tE^2/th^2 - 0];
Print["    gamma_t = ", gtPM, "  (falls as theta^-2, vs theta^-1 for SIS)"];
check["12.2(b) point-mass gamma_t = thetaE^2/theta^2",
    Simplify[gtPM - tE^2/th^2] === 0];

Print["(c) Multiply <gamma_t> = kbar - <kappa> by Sigma_cr, use kappa=Sigma/Sigma_cr:"];
Print["    gamma_t * Sigma_cr = Sigmabar(<theta) - Sigma(theta) = DeltaSigma."];
(* symbolic identity: Sigma_cr*(Sbar/Sig_cr - S/Sig_cr) = Sbar - S *)
lhs = Scr (Sbar/Scr - Sig/Scr);
check["12.2(c) gamma_t Sigma_cr = Sigmabar - Sigma", Simplify[lhs - (Sbar - Sig)] === 0];

(* (d) NFW tangential shear (Module 7 convention: kappa = kappa_s f(x),
   kbar = (2 kappa_s/x^2)[ln(x/2) + g(x)], x = theta/theta_s).  Added
   2026-09-22 after the fact-critic pass found that an earlier solution
   claimed gamma_t "peaks near x ~ 1"; it does not.  Checks: finite central
   value kappa_s/2; large-x asymptote (2 kappa_s/x^2)[ln(x/2) - 1/2];
   strictly decreasing on a log grid x in [1e-3, 1e2]. *)
Print["(d) NFW: gamma_t/kappa_s = kbar - kappa (x = theta/theta_s):"];
gNFWlo[x_] := ArcCosh[1/x]/Sqrt[1 - x^2];
gNFWhi[x_] := ArcTan[Sqrt[x^2 - 1]]/Sqrt[x^2 - 1];
gNFW[x_?NumericQ] := If[x < 1, gNFWlo[x], If[x == 1, 1, gNFWhi[x]]];
fNFW[x_?NumericQ] := If[x == 1, 1/3, (1 - gNFW[x])/(x^2 - 1)];
gtNFW[x_?NumericQ] := (2/x^2) (Log[x/2] + gNFW[x]) - fNFW[x];
gt0 = Limit[(2/x^2) (Log[x/2] + gNFWlo[x]) - (1 - gNFWlo[x])/(x^2 - 1), x -> 0,
    Direction -> "FromAbove"];
Print["    gamma_t(x->0)/kappa_s = ", Simplify[gt0]];
check["12.2(d) NFW gamma_t -> kappa_s/2 at the centre (finite, unlike SIS)",
    Simplify[gt0 - 1/2] === 0];
asym = Normal[Series[x^2 ((2/x^2) (Log[x/2] + gNFWhi[x]) - (1 - gNFWhi[x])/(x^2 - 1)),
    {x, Infinity, 0}]];
Print["    x^2 gamma_t/kappa_s at large x -> ", Simplify[asym]];
check["12.2(d) NFW gamma_t ~ (2/x^2)[ln(x/2) - 1/2] at large x",
    Simplify[asym - 2 (Log[x/2] - 1/2), Assumptions -> x > 2] === 0];
xgrid = N[10^Range[-3, 2, 1/40]];
gtvals = gtNFW /@ xgrid;
check["12.2(d) NFW gamma_t strictly decreasing (no peak), 201-pt log grid",
    And @@ Negative[Differences[gtvals]]];
slopes = Table[x0 (gtNFW[1.001 x0] - gtNFW[0.999 x0])/(0.002 x0 gtNFW[x0]), {x0, {0.1, 1.001, 10}}];
Print["    d ln gamma_t / d ln x at x = 0.1, 1, 10: ", ToString[NumberForm[slopes, 3]]];
Print[""];


(* =========================================================================
   Exercise 12.3: The Kaiser-Squires kernel
   ========================================================================= *)

Print["--- Exercise 12.3: Kaiser-Squires kernel ---\n"];

Dhat = Pi (l1^2 - l2^2 + 2 I l1 l2)/(l1^2 + l2^2);
DhatC = Pi (l1^2 - l2^2 - 2 I l1 l2)/(l1^2 + l2^2);

Print["(a) D-hat D-hat^*:"];
idn = FullSimplify[Dhat DhatC,
    Assumptions -> {l1 \[Element] Reals, l2 \[Element] Reals, l1^2 + l2^2 > 0}];
Print["    = ", idn];
check["12.3(a) D-hat D-hat^* = pi^2", Simplify[idn - Pi^2] === 0];

Print["(b) inversion: kappa-hat = (1/pi) gamma-hat D-hat^*"];
gammaHat = (1/Pi) Dhat khat;             (* forward *)
kappaBack = FullSimplify[(1/Pi) gammaHat DhatC];
Print["    reconstructed kappa-hat = ", kappaBack];
check["12.3(b) KS inversion returns kappa-hat", Simplify[kappaBack - khat] === 0];

Print["(c) D-hat is undefined at l=0 => zero-mode of kappa undetermined"];
Print["    (the additive constant kappa_0 = mass-sheet degeneracy).\n"];

Print["(d) with D-hat = pi e^(2 i beta), gamma-hat = e^(2 i beta) kappa-hat:"];
Print["    |gamma-hat|^2 = |kappa-hat|^2  =>  P_gamma = P_kappa."];
gh = Exp[2 I beta] khat;
check["12.3(d) P_gamma = P_kappa (|e^(2 i beta)| = 1)",
    FullSimplify[Abs[gh]^2 - Abs[khat]^2,
        Assumptions -> {beta \[Element] Reals, khat \[Element] Reals}] === 0];
Print[""];


(* =========================================================================
   Exercise 12.4: Complex ellipticity
   ========================================================================= *)

Print["--- Exercise 12.4: Complex ellipticity ---\n"];

chiMod = (1 - r^2)/(1 + r^2);
epsMod = (1 - r)/(1 + r);

Print["(a) From Q11 ~ a^2, Q22 ~ b^2, r = b/a:"];
Print["    |chi| = (a^2-b^2)/(a^2+b^2) = (1-r^2)/(1+r^2)"];
Print["    |eps| = (a^2-b^2)/(a^2+b^2+2ab) = (1-r)/(1+r)"];
(* verify the algebra a^2-b^2 = (a-b)(a+b), etc. with a=1,b=r *)
check["12.4(a) |chi|,|eps| from axis ratio",
    Simplify[(1 - r^2)/(1 + r^2) - chiMod] === 0 &&
    Simplify[((1 - r)(1 + r))/(1 + r)^2 - epsMod] === 0];

Print["(b) transforms:"];
epsFromChi = FullSimplify[chiMod/(1 + Sqrt[1 - chiMod^2]), Assumptions -> 0 < r <= 1];
chiFromEps = FullSimplify[2 epsMod/(1 + epsMod^2), Assumptions -> 0 < r <= 1];
Print["    eps(chi) = ", epsFromChi, " ;  chi(eps) = ", chiFromEps];
check["12.4(b) eps = chi/(1+sqrt(1-chi^2))",
    FullSimplify[epsFromChi - epsMod, Assumptions -> 0 < r <= 1] === 0];
check["12.4(b) chi = 2 eps/(1+eps^2)",
    FullSimplify[chiFromEps - chiMod, Assumptions -> 0 < r <= 1] === 0];

Print["(c) weak limit r -> 1: |chi| ~ 2|eps|"];
check["12.4(c) leading behaviour |chi| - 2|eps| -> O((1-r)^2)",
    Simplify[Limit[(chiMod - 2 epsMod)/(1 - r), r -> 1]] === 0];
Print[""];


(* =========================================================================
   Exercise 12.5: Cosmic-shear correlation functions
   ========================================================================= *)

Print["--- Exercise 12.5: Cosmic-shear correlation functions ---\n"];

Print["(a) xi_+ and xi_- are both Hankel transforms of the SAME P_kappa"];
Print["    (with J0 and J4); hence not independent -- either determines"];
Print["    P_kappa and thus the other.\n"];

Print["(b) Parity: gamma_t -> gamma_t, gamma_cross -> -gamma_cross, so"];
Print["    xi_cross = <gamma_t gamma_cross> -> -xi_cross => xi_cross = 0."];
(* model the parity flip: xi_x is odd under sign flip of gamma_cross *)
xiCross = gt gx;                         (* gamma_t * gamma_cross *)
xiCrossFlip = gt (-gx);                  (* after parity: gamma_cross -> -gamma_cross *)
check["12.5(b) xi_cross = -xi_cross => 0 (parity)",
    Simplify[xiCrossFlip + xiCross] === 0];

(* (c) Revised 2026-09-22: the original P ~ l^-2 makes xi_+ diverge (J0/l at
   l -> 0); the exercise now uses P = A l^-1. *)
Print["(c) Scale-free P_kappa(l) = A l^-1:"];
xiP = Integrate[l/(2 Pi) BesselJ[0, l th] A/l, {l, 0, Infinity}, Assumptions -> th > 0];
xiM = Integrate[l/(2 Pi) BesselJ[4, l th] A/l, {l, 0, Infinity}, Assumptions -> th > 0];
Print["    xi_+ = ", xiP, ",  xi_- = ", xiM];
check["12.5(c) xi_+ = A/(2 pi theta) for P = A/l", Simplify[xiP - A/(2 Pi th)] === 0];
check["12.5(c) xi_- = xi_+ for P = A/l", Simplify[xiM - xiP] === 0];
rel = Integrate[(1/v) (A/(2 Pi v)) (4 - 12 th^2/v^2), {v, th, Infinity},
    Assumptions -> th > 0];
check["12.5(c) consistent with xi_+ = xi_- + Int (dv/v) xi_-(v)[4 - 12 th^2/v^2] (Schneider 2006 Pt3 eq.113)",
    Simplify[xiM + rel - xiP] === 0];
divP2 = Quiet@Check[Integrate[l/(2 Pi) BesselJ[0, l th] A/l^2, {l, 0, Infinity},
    Assumptions -> th > 0], $Failed];
Print["    P = A l^-2 gives: ", divP2];
check["12.5(c) P = A l^-2 does NOT give a finite xi_+ (log divergence at l->0)",
    ! FreeQ[{divP2}, $Failed] || ! FreeQ[{divP2}, Integrate] || ! FreeQ[{divP2}, DirectedInfinity]];

Print["(d) Aperture-mass filter W_ap ~ J4^2(eta)/eta^4 is narrow (localized"];
Print["    in l ~ 5/theta); top-hat W_TH ~ 4 J1^2(eta)/eta^2 is broad."];
Print["    => <M_ap^2> reflects the shape of P_kappa far more directly.\n"];


Print["=== End of Module 12 Solutions ==="];
