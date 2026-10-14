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
   Annotated-edition checks (2026-10) appended at the end: every number /
   identity in the derivation, annotation and bridge boxes of 12_Solutions.tex.
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


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity / number in the derivation, annotation and bridge boxes of
   Notes/12_Weak_Lensing/12_Solutions.tex (Annotated Study Edition).  This
   script defines its own check[] (print-only), so the harness is NOT loaded;
   annCheck wraps it and keeps a tally for the SUMMARY line below. *)
Print["--- Annotated-edition checks ---\n"];
annRes = {};
annCheck[label_, bool_] := (check[label, bool]; AppendTo[annRes, TrueQ[bool]]);
ClearAll[kk, gg, eps, al, lam, x, r, dl, th, v, l, A, MM, Scr0, Dd0, Ds0, Dds0, GG0, cc0];

(* 12.1(c): number counts in the weak limit *)
muWL = 1/((1 - kk)^2 - gg^2);
annCheck["12.1(c) mu = 1 + 2 kappa + O(kappa^2, gamma^2)",
  Normal[Series[muWL /. {kk -> eps kk, gg -> eps gg}, {eps, 0, 1}]] === 1 + 2 eps kk];
annCheck["12.1(c) n/n0 = mu^(alpha-1) = 1 + 2(alpha-1) kappa to first order",
  Simplify[Normal[Series[(1 + 2 eps kk)^(al - 1), {eps, 0, 1}]] - (1 + 2 (al - 1) eps kk)] === 0];
annCheck["12.1(c) alpha = 1: n/n0 = 1 for any mu (no number-count signal)",
  Simplify[(MM^(al - 1)) /. al -> 1] === 1];
(* reduced-shear pitfall: SIS at theta = 2 thetaE *)
kSIS2 = 1/(2*2); gSIS2 = 1/(2*2);
annCheck["12.1 SIS at theta = 2 thetaE: kappa = gamma = 1/4, g = 1/3 (33% above gamma)",
  kSIS2 == 1/4 && gSIS2/(1 - kSIS2) == 1/3 && (1/3)/(1/4) - 1 == 1/3];
annCheck["12.1 MST: gamma' = lambda gamma differs from gamma (shear itself not invariant)",
  Simplify[lam gam - gam] =!= 0];

(* 12.2(b): thetaE^2 = M/(pi Sigma_cr Dd^2) for a point mass *)
annCheck["12.2(b) M/(pi Sigma_cr Dd^2) = 4 G M Dds/(c^2 Dd Ds) = thetaE^2",
  Simplify[MM/(Pi (cc0^2 Ds0/(4 Pi GG0 Dd0 Dds0)) Dd0^2) - 4 GG0 MM Dds0/(cc0^2 Dd0 Ds0)] === 0];

(* 12.2(d): NFW asymptotics *)
annCheck["12.2(d) small x: g(x) = ln(2/x) + O(x^2 ln x)",
  Simplify[PowerExpand[Normal[Series[gNFWlo[x], {x, 0, 1}]] - Log[2/x]], x > 0] === 0];
annCheck["12.2(d) small x: f(x) = (1-g)/(x^2-1) -> ln(2/x) - 1",
  Simplify[PowerExpand[Normal[Series[(1 - gNFWlo[x])/(x^2 - 1), {x, 0, 1}]] - (Log[2/x] - 1)], x > 0] === 0];
annCheck["12.2(d) small x: kbar/kappa_s -> ln(2/x) - 1/2",
  Simplify[PowerExpand[Normal[Series[(2/x^2) (Log[x/2] + gNFWlo[x]), {x, 0, 1}]] - (Log[2/x] - 1/2)], x > 0] === 0];
annCheck["12.2(d) large x: g(x) = pi/(2x) - 1/x^2 + O(x^-3)",
  Simplify[Normal[Series[gNFWhi[x], {x, Infinity, 2}]] - (Pi/(2 x) - 1/x^2)] === 0];
annCheck["12.2(d) large x: f(x) = 1/x^2 + O(x^-3)",
  Simplify[Normal[Series[(1 - gNFWhi[x])/(x^2 - 1), {x, Infinity, 2}]] - 1/x^2] === 0];

(* 12.4(b),(c) *)
annCheck["12.4(b) 1 - |chi|^2 = 4 r^2/(1+r^2)^2",
  Simplify[1 - chiMod^2 - 4 r^2/(1 + r^2)^2] === 0];
annCheck["12.4(c) r = 1 - d: |eps| = d/(2-d), |chi| = (2d - d^2)/(2 - 2d + d^2)",
  Simplify[(epsMod /. r -> 1 - dl) - dl/(2 - dl)] === 0 &&
  Simplify[(chiMod /. r -> 1 - dl) - (2 dl - dl^2)/(2 - 2 dl + dl^2)] === 0];
annCheck["12.4(c) |chi| and 2|eps| both = d + d^2/2 + O(d^3); difference O(d^3)",
  Simplify[Normal[Series[(2 dl - dl^2)/(2 - 2 dl + dl^2), {dl, 0, 2}]] - (dl + dl^2/2)] === 0 &&
  Simplify[Normal[Series[2 dl/(2 - dl), {dl, 0, 2}]] - (dl + dl^2/2)] === 0 &&
  Normal[Series[(2 dl - dl^2)/(2 - 2 dl + dl^2) - 2 dl/(2 - dl), {dl, 0, 2}]] === 0];

(* 12.5(c) *)
annCheck["12.5(c) int_0^Inf J_0(x) dx = int_0^Inf J_4(x) dx = 1",
  Integrate[BesselJ[0, x], {x, 0, Infinity}] === 1 && Integrate[BesselJ[4, x], {x, 0, Infinity}] === 1];
annCheck["12.5(c) substitution x = l theta: int_0^Inf J_0(l theta) dl = 1/theta",
  Simplify[Integrate[BesselJ[0, l th], {l, 0, Infinity}, Assumptions -> th > 0] - 1/th] === 0];
annCheck["12.5(c) int_theta^Inf dv/v^2 = 1/theta, int_theta^Inf dv/v^4 = 1/(3 theta^3)",
  Integrate[1/v^2, {v, th, Infinity}, Assumptions -> th > 0] === 1/th &&
  Integrate[1/v^4, {v, th, Infinity}, Assumptions -> th > 0] === 1/(3 th^3)];

(* bridge: MST keeps g; image positions too (beta -> lambda beta) *)
annCheck["12 bridge: MST alpha' = lambda alpha + (1-lambda) theta maps beta -> lambda beta",
  Simplify[(th - (lam aa + (1 - lam) th)) - lam (th - aa)] === 0];

nA = Length[annRes]; pA = Count[annRes, True];
Print["SUMMARY: ", pA, " PASS, ", nA - pA, " FAIL  (of ", nA, " annotated-edition checks)"];
If[pA =!= nA, Exit[1]];
