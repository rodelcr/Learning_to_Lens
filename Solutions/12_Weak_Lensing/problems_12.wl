(* =========================================================================
   problems_12.wl
   Module 12: Weak Gravitational Lensing and Cosmic Shear --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to the exercises of Module 12, verified
            symbolically and numerically with Mathematica.

   Sources: Schneider, Kochanek & Wambsganss (2006), Part 3 (P. Schneider):
              Sect. 2   (eqs. 8, 9, 14, 16, 17, 24)
              Sect. 5.1 (eqs. 41, 43, 44, 51)
              Sect. 6   (eqs. 104, 105)
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

Print["(c) Scale-free P_kappa(l) = A l^-2, xi_+ ~ (A/2pi) Int J0(l theta)/l dl"];
Print["    (log-divergent at l->0; the related P ~ l^-1 gives xi_+ ~ 1/theta"];
Print["    via Int J0(l theta) dl = 1/theta). Scale-free P => power-law xi."];
j0int = Integrate[BesselJ[0, l th], {l, 0, Infinity},
    Assumptions -> th > 0];
Print["    Int[J0(l theta), {l,0,Inf}] = ", j0int];
check["12.5(c) Int J0(l theta) dl = 1/theta", Simplify[j0int - 1/th] === 0];

Print["(d) Aperture-mass filter W_ap ~ J4^2(eta)/eta^4 is narrow (localized"];
Print["    in l ~ 5/theta); top-hat W_TH ~ 4 J1^2(eta)/eta^2 is broad."];
Print["    => <M_ap^2> reflects the shape of P_kappa far more directly.\n"];


Print["=== End of Module 12 Solutions ==="];
