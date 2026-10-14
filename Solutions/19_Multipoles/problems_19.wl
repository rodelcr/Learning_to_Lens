(* =========================================================================
   problems_19.wl
   Module 19: Azimuthal Multipoles and the Central-Mass Confusion --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises of Module 19, verified
            symbolically and numerically with Mathematica.  Every number
            quoted in Notes/19_Multipoles/19_Solutions.tex and in the
            chapter's annotation boxes has a check here.

   Sources: Module 5 (Poisson equation), Module 8 (multipole series),
            Module 9 (power-law convergence); Congdon & Keeton (2018)
            Sec. 4.1.3 (constant deflection = source translation).

   Conventions: kappa_m = (1/2) k_m (thE/theta)^(g-1) cos[m(phi-phi_m)],
                kappa_0 = ((3-g)/2)(thE/theta)^(g-1), g = gamma',
                a_m = k_m/(3-g) (fractional convergence amplitude),
                f = thetaBH^2/thE^2 (central point-mass fraction).

   Usage:   bash Mathematica/run_wl.sh Solutions/19_Multipoles/problems_19.wl

   Exercises solved:
     19.1 (ex:mu_potential)  --- potential, deflection, r-independent ratio
     19.2 (ex:mu_isophote)   --- a_m = (g-1) eps_m and its numbers
     19.3 (ex:mu_zero_mass)  --- zero enclosed mass, orthogonality, arcs
     19.4 (ex:mu_critical)   --- first-order tangential critical-curve shift
     19.5 (ex:mu_residual)   --- inner-vs-outer residual demonstration
     19.6 (ex:mu_convention) --- amplitude/orientation bookkeeping
     19.7 (ex:mu_dipole)     --- the m = 1 resonance
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Mathematica", "harness.wl"}]];
Print["=== Module 19: SOLUTIONS ==="];

ClearAll[th, ph, phm, g, tE, k, m, n];
asm = {th > 0, tE > 0, 1 < g < 3, m > 0};
lap[f_] := D[f, {th, 2}] + D[f, th]/th + D[f, {ph, 2}]/th^2;
intAsm = Element[m, Integers] && m >= 1;

kappa0 = ((3 - g)/2) (tE/th)^(g - 1);
alpha0 = tE^(g - 1) th^(2 - g);
kappaM = (1/2) k (tE/th)^(g - 1) Cos[m (ph - phm)];
psiM   = -k tE^(g - 1) th^(3 - g) Cos[m (ph - phm)]/(m^2 - (3 - g)^2);
alphaR   = -(3 - g) k tE^(g - 1) th^(2 - g) Cos[m (ph - phm)]/(m^2 - (3 - g)^2);
alphaPhi =  m k tE^(g - 1) th^(2 - g) Sin[m (ph - phm)]/(m^2 - (3 - g)^2);
kmOf[a_, gg_] := a (3 - gg);
peak[a_, gg_, mm_] := mm kmOf[a, gg]/(mm^2 - (3 - gg)^2);

(* ============ Exercise 19.1 ============ *)
Print["--- Exercise 19.1 ---"];
check["1a  Laplacian psi_m = 2 kappa_m", FullSimplify[lap[psiM] - 2 kappaM, asm] === 0];
check["1b  alpha_r = dpsi_m/dtheta", FullSimplify[D[psiM, th] - alphaR, asm] === 0];
check["1c  alpha_phi = (1/theta) dpsi_m/dphi", FullSimplify[D[psiM, ph]/th - alphaPhi, asm] === 0];
check["1d  a_m = max|kappa_m|/kappa_0 = k_m/(3-g)",
  FullSimplify[(kappaM /. Cos[_] -> 1)/kappa0 - k/(3 - g), asm] === 0];
ratioSq = FullSimplify[(alphaR^2 + alphaPhi^2)/alpha0^2, asm];
check["1e  d/dtheta (|alpha_m|/alpha_0) = 0", FullSimplify[D[ratioSq, th], asm] === 0];
check["1f  peak (sin = +-1, m > 3-g) = m k/(m^2-(3-g)^2)",
  Simplify[Sqrt[ratioSq /. {Cos[m (ph - phm)] -> 0, Sin[m (ph - phm)] -> 1}] - m k/(m^2 - (3 - g)^2),
    k > 0 && m > 3 - g && 1 < g < 3] === 0];
check["1g  m=3, g=1.40, a=0.01: 0.0074534", Abs[peak[0.01, 1.4, 3] - 0.0074534161] < 10^-9];
check["1h  m=4, g=1.40, a=0.01: 0.0047619", Abs[peak[0.01, 1.4, 4] - 0.0047619048] < 10^-9];
check["1i  m=3, g=1.50, a=0.01: 0.0066667", Abs[peak[0.01, 1.5, 3] - 0.0066666667] < 10^-9];
check["1j  m=4, g=1.50, a=0.01: 0.0043636", Abs[peak[0.01, 1.5, 4] - 0.0043636364] < 10^-9];
check["1k  m=3 exceeds m=4 by factor 1.565 (g=1.4) and 1.528 (g=1.5)",
  Abs[peak[0.01, 1.4, 3]/peak[0.01, 1.4, 4] - 1.5652174] < 10^-6 &&
  Abs[peak[0.01, 1.5, 3]/peak[0.01, 1.5, 4] - 1.5277778] < 10^-6];
check["1l  large-m limit: peak -> k/m (deflection response ~ 1/m)",
  Limit[(m k/(m^2 - (3 - g)^2))/(k/m), m -> Infinity] === 1];
check["1m  thE = 1 arcsec, g=1.5: 6.7 mas (m=3), 4.4 mas (m=4)",
  Abs[1000 peak[0.01, 1.5, 3] - 6.6667] < 10^-4 && Abs[1000 peak[0.01, 1.5, 4] - 4.3636] < 10^-4];

(* ============ Exercise 19.2 ============ *)
Print["--- Exercise 19.2 ---"];
kIso = CC (th/(1 + eps Cos[m (ph - phm)]))^(-(g - 1));
kIsoLin = Normal[Series[kIso, {eps, 0, 1}]];
check["2a  first-order expansion kappa_0[1 + (g-1) eps cos]",
  FullSimplify[kIsoLin - CC th^(1 - g) (1 + (g - 1) eps Cos[m (ph - phm)]), asm] === 0];
check["2b  second-order term is (g-1)(g-2)/2 eps^2 cos^2 (sets validity of linearisation)",
  FullSimplify[SeriesCoefficient[kIso, {eps, 0, 2}] - CC th^(1 - g) (g - 1) (g - 2)/2 Cos[m (ph - phm)]^2, asm] === 0];
epsOf[a_, gg_] := a/(gg - 1);
check["2c  eps(0.01,1.40)=0.025, eps(0.03,1.40)=0.075",
  Abs[epsOf[0.01, 1.4] - 0.025] < 10^-12 && Abs[epsOf[0.03, 1.4] - 0.075] < 10^-12];
check["2d  eps(0.01,1.50)=0.020, eps(0.03,1.50)=0.060",
  Abs[epsOf[0.01, 1.5] - 0.02] < 10^-12 && Abs[epsOf[0.03, 1.5] - 0.06] < 10^-12];
check["2e  eps(0.01,2)=0.010, eps(0.03,2)=0.030", epsOf[1/100, 2] === 1/100 && epsOf[3/100, 2] === 3/100];
check["2f  eps(g=1.4)/eps(g=2) = 2.5; eps(g=1.5)/eps(g=2) = 2", epsOf[1, 7/5]/epsOf[1, 2] === 5/2 && epsOf[1, 3/2]/epsOf[1, 2] === 2];
check["2g  k_m and eps_m differ: k_m/a_m = 3-g but eps_m/a_m = 1/(g-1); equal only at g=2",
  Reduce[(3 - g) == 1/(g - 1) && 1 < g < 3, g] === (g == 2)];

(* ============ Exercise 19.3 ============ *)
Print["--- Exercise 19.3 ---"];
check["3a  Int_0^2pi cos(m(phi-phim)) = 0, symbolic integer m >= 1",
  FullSimplify[Integrate[Cos[m (ph - phm)], {ph, 0, 2 Pi}, Assumptions -> intAsm], intAsm] === 0];
dM = Integrate[(kappaM /. th -> t) t, {t, 0, th}, Assumptions -> asm];
check["3b  delta M_m(<theta) = 0 at every theta, symbolic m",
  FullSimplify[Integrate[dM, {ph, 0, 2 Pi}, Assumptions -> intAsm && th > 0 && tE > 0 && 1 < g < 3],
    intAsm && th > 0 && tE > 0 && 1 < g < 3] === 0];
check["3c  orthogonality of distinct orders, symbolic m != n",
  FullSimplify[Integrate[Cos[m (ph - phm)] Cos[n (ph - phn)], {ph, 0, 2 Pi},
     Assumptions -> intAsm && Element[n, Integers] && n >= 1 && m != n],
   intAsm && Element[n, Integers] && n >= 1 && m != n] === 0];
check["3d  same order: pi cos(m(phim - phin))",
  FullSimplify[Integrate[Cos[m (ph - phm)] Cos[m (ph - phn)], {ph, 0, 2 Pi}, Assumptions -> intAsm] - Pi Cos[m (phm - phn)], intAsm] === 0];
check["3e  m=3 at 20 deg and m=4 at 30 deg: overlap 0",
  Abs[N[Integrate[Cos[3 (p - 20 Degree)] Cos[4 (p - 30 Degree)], {p, 0, 2 Pi}]]] < 10^-12];
check["3f  point mass alpha = tb^2/theta has zero Fourier content for m >= 1",
  FullSimplify[Integrate[(tb^2/th) Cos[m ph], {ph, 0, 2 Pi}, Assumptions -> intAsm], intAsm] === 0];
lsAmp = Integrate[Cos[m ph], {ph, -Dl, Dl}]/(2 Dl);
check["3g  LS monopole amplitude absorbed on an arc |phi|<Dl: sin(m Dl)/(m Dl); m=4: 2/pi (Dl=pi/8), 0 (Dl=pi/4), 0 (Dl=pi)",
  FullSimplify[lsAmp - Sin[m Dl]/(m Dl), Dl > 0 && m > 0] === 0 &&
  (lsAmp /. {m -> 4, Dl -> Pi/8}) === 2/Pi && (lsAmp /. {m -> 4, Dl -> Pi/4}) === 0 && (lsAmp /. {m -> 4, Dl -> Pi}) === 0];
check["3h  m=4, arc of half-width 30 deg: absorbed fraction sin(2pi/3)/(2pi/3) = 0.4135",
  Abs[N[lsAmp /. {m -> 4, Dl -> Pi/6}] - 0.41349667] < 10^-7];

(* ============ Exercise 19.4 ============ *)
Print["--- Exercise 19.4 ---"];
hessPolar[f_] := {{D[f, {th, 2}], D[f, th, ph]/th - D[f, ph]/th^2},
                  {D[f, th, ph]/th - D[f, ph]/th^2, D[f, th]/th + D[f, {ph, 2}]/th^2}};
detA[f_] := Det[IdentityMatrix[2] - hessPolar[f]];
psi0 = tE^(g - 1) th^(3 - g)/(3 - g);
check["4a  monopole eigenvalues at thE: lambda_t = 0, lambda_r = g - 1",
  FullSimplify[(1 - D[psi0, th]/th /. th -> tE), asm] === 0 &&
  FullSimplify[(1 - D[psi0, {th, 2}] /. th -> tE) - (g - 1), asm] === 0];
check["4b  d lambda_t/d theta at thE = (g-1)/thE",
  FullSimplify[(D[1 - D[psi0, th]/th, th] /. th -> tE) - (g - 1)/tE, asm] === 0];
detLin = Normal[Series[detA[psi0 + e psiM] /. th -> tE (1 + e d), {e, 0, 1}]];
dSol = d /. Solve[Coefficient[detLin, e] == 0, d][[1]];
check["4c  delta theta/thE = k(m^2-(3-g)) cos/[(g-1)(m^2-(3-g)^2)]",
  FullSimplify[dSol - k (m^2 - (3 - g)) Cos[m (ph - phm)]/((g - 1) (m^2 - (3 - g)^2)), asm] === 0];
gfac[gg_, mm_] := (3 - gg) (mm^2 - 3 + gg)/((gg - 1) (mm^2 - (3 - gg)^2));
check["4d  coefficient of a_m cos: m=3: 10/3 (g=1.5), 1 (g=2); m=4: 3.1636 (g=1.5), 1 (g=2)",
  gfac[3/2, 3] === 10/3 && gfac[2, 3] === 1 && Abs[gfac[1.5, 4] - 3.1636364] < 10^-6 && gfac[2, 4] === 1];
check["4e  area inside the critical curve unchanged at first order: Int (thE+dtheta)^2/2 dphi - pi thE^2 = O(a^2)",
  FullSimplify[Integrate[2 tE^2 dSol, {ph, 0, 2 Pi}, Assumptions -> intAsm && asm]/2, intAsm] === 0];
detPM = Normal[Series[detA[psi0 + e fb tE^2 Log[th]] /. th -> tE (1 + e d), {e, 0, 1}]];
check["4f  point mass (base fixed): uniform shift f/(g-1) = 0.02 thE at f=0.01, g=1.5",
  FullSimplify[(d /. Solve[Coefficient[detPM, e] == 0, d][[1]]) - fb/(g - 1), asm] === 0 &&
  (fb/(g - 1) /. {fb -> 1/100, g -> 3/2}) === 1/50];

(* ============ Exercise 19.5 ============ *)
Print["--- Exercise 19.5 ---"];
dAlphaPM = fb tE ((tE/th) - (th/tE)^(2 - g));
check["5a  ring matched: base rescaled by (1-f) keeps alpha(thE) = thE",
  FullSimplify[((1 - fb) alpha0 + fb tE^2/th) /. th -> tE, asm] === tE &&
  FullSimplify[(1 - fb) alpha0 + fb tE^2/th - alpha0 - dAlphaPM, asm] === 0];
check["5b  dalpha_PM/alpha_0 = f[(thE/theta)^(3-g) - 1]",
  FullSimplify[dAlphaPM/alpha0 - fb ((tE/th)^(3 - g) - 1), asm] === 0];
check["5c  slope change at fixed thE: dalpha_0/dg = -alpha_0 ln(theta/thE); PM linear term = -f(3-g) ln(theta/thE)",
  FullSimplify[D[alpha0, g] + alpha0 Log[th/tE], asm] === 0 &&
  FullSimplify[(D[dAlphaPM/alpha0 /. th -> tE Exp[x], x] /. x -> 0) + fb (3 - g), asm] === 0];
resRefit = fb ((tE/th)^(3 - g) - 1 - (3 - g) Log[tE/th]);
check["5d  with dg = -f(3-g): residual f[u^p - 1 - p ln u], second order at the ring",
  FullSimplify[dAlphaPM/alpha0 + fb (3 - g) Log[th/tE] - resRefit, asm] === 0 &&
  FullSimplify[(D[resRefit /. th -> tE Exp[x], x] /. x -> 0), asm] === 0];
thR = (2 - 3/2)^(1/(3/2 - 1));
check["5e  g=1.5: theta_r = 0.25 thE (radial critical curve)", thR === 1/4];
pm2Res[t_] := t^(1/2) 0.01 ((1/t)^(3/2) - 1 - (3/2) Log[1/t]);
mpRes[t_] := peak[0.01, 1.5, 4] t^(1/2);
check["5f  numbers: PM(ring+slope) 0.02460 & 3.747e-4; multipole 0.002182 & 0.004780 at (theta_r, 1.2 thE)",
  Abs[pm2Res[0.25] - 0.0246028] < 10^-6 && Abs[pm2Res[1.2] - 0.000374731] < 10^-8 &&
  Abs[mpRes[0.25] - 0.00218182] < 10^-8 && Abs[mpRes[1.2] - 0.00478012] < 10^-8];
check["5g  ratios: PM/mp = 11.28 inside, 0.0784 outside; inner/outer: PM 65.65, mp 0.4564",
  Abs[pm2Res[0.25]/mpRes[0.25] - 11.2763] < 10^-3 && Abs[pm2Res[1.2]/mpRes[1.2] - 0.078394] < 10^-5 &&
  Abs[pm2Res[0.25]/pm2Res[1.2] - 65.6545] < 10^-3 && Abs[mpRes[0.25]/mpRes[1.2] - 0.456435] < 10^-5];
check["5h  azimuthal content: PM residual is phi-independent; multipole residual averages to zero on every circle",
  FreeQ[dAlphaPM, ph] && FullSimplify[Integrate[alphaR, {ph, 0, 2 Pi}, Assumptions -> intAsm && asm], intAsm] === 0];

(* ============ Exercise 19.6 ============ *)
Print["--- Exercise 19.6 ---"];
e1 = 0.015 Cos[4 30 Degree]; e2 = 0.015 Sin[4 30 Degree];
check["6a  a_4=0.01, phi_4=30 deg, g=1.5: k=0.015, (e1,e2) = (-0.0075, 0.012990)",
  Abs[kmOf[0.01, 1.5] - 0.015] < 10^-12 && Abs[e1 + 0.0075] < 10^-12 && Abs[e2 - 0.0129904] < 10^-7];
check["6b  inverse: k = |e| = 0.015, phi_4 = atan2(e2,e1)/4 = 30 deg",
  Abs[Sqrt[e1^2 + e2^2] - 0.015] < 10^-12 && Abs[ArcTan[e1, e2]/4/Degree - 30] < 10^-9];
check["6c  setting |e| = 0.01 by mistake injects a_m = 0.01/(3-g): 0.00667 (g=1.5), 0.00625 (g=1.4)",
  Abs[0.01/1.5 - 0.0066667] < 10^-7 && Abs[0.01/1.6 - 0.00625] < 10^-12];
check["6d  i.e. 33.3% (g=1.5) and 37.5% (g=1.4) below the intended a_m",
  Abs[1 - 1/1.5 - 0.333333] < 10^-6 && Abs[1 - 1/1.6 - 0.375] < 10^-12];
check["6e  orientation degeneracies: phi_m -> phi_m + 2pi/m is identity; phi_m -> phi_m + pi/m flips the sign of k",
  FullSimplify[Cos[m (ph - phm - 2 Pi/m)] - Cos[m (ph - phm)]] === 0 &&
  FullSimplify[Cos[m (ph - phm - Pi/m)] + Cos[m (ph - phm)]] === 0];

(* ============ Exercise 19.7 ============ *)
Print["--- Exercise 19.7 ---"];
check["7a  m^2 - (3-g)^2 = 0 at m=1 iff g=2 (for 1<g<3)", Solve[1 - (3 - g)^2 == 0 && 1 < g < 3, g] === {{g -> 2}}];
harm = th Cos[ph - phm];
check["7b  theta cos(phi-phim) harmonic; gradient uniform unit vector",
  FullSimplify[lap[harm], th > 0] === 0 &&
  FullSimplify[{D[harm, th], D[harm, ph]/th}, th > 0] === {Cos[ph - phm], -Sin[ph - phm]}];
check["7c  m=1 denominators: -1.56 (g=1.4), -1.25 (g=1.5), -0.21 (g=1.9)",
  (1 - (3 - 7/5)^2) === -39/25 && (1 - (3 - 3/2)^2) === -5/4 && (1 - (3 - 19/10)^2) === -21/100];
pk1[a_, gg_] := a (3 - gg)^2/Abs[1 - (3 - gg)^2];   (* m=1: max over phi at cos=+-1, ratio p k/|1-p^2| *)
check["7d  m=1 peak |alpha_1|/alpha_0 = a p^2/|1-p^2|: 0.018 (g=1.5), 0.0576 (g=1.9) for a=0.01",
  Abs[pk1[0.01, 1.5] - 0.018] < 10^-12 && Abs[pk1[0.01, 1.9] - 0.0576190] < 10^-6];
check["7e  for m < p the maximum of sqrt(p^2 cos^2 + m^2 sin^2) is p (at cos = +-1)",
  Maximize[{Sqrt[(3/2)^2 Cos[x]^2 + Sin[x]^2], 0 <= x <= Pi}, x][[1]] === 3/2];
check["7f  the m=1 peak exceeds every m>=2 peak at the same amplitude (g=1.5: 0.018 > 0.01714 for m=2; g=1.9 likewise)",
  And @@ Flatten[Table[pk1[0.01, gg] > peak[0.01, gg, mm], {gg, {1.5, 1.9}}, {mm, 2, 10}]]];

summary[];
