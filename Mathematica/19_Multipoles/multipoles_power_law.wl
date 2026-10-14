(* =========================================================================
   multipoles_power_law.wl
   Module 19: Azimuthal Multipoles and the Central-Mass Confusion
   =========================================================================
   Purpose: Symbolic + numeric verification of every equation in
            Notes/19_Multipoles/19_Multipoles.tex that is NEW relative to
            Module 8's multipole section (multipole_expansion.wl, which
            already covers the isothermal-scaling multipole, the m=0,2
            limits, external shear and the SIE internal fraction; those
            checks are NOT repeated here).  Covered:
              A. the power-law monopole (kappa_0, psi_0, alpha_0)
              B. the separable Laplacian identity and the closed-form
                 multipole potential psi_m ~ theta^(3-g) cos(m dphi)
                 solving Laplacian psi_m = 2 kappa_m (general m, g);
                 deflection components; isothermal limit -> Module 8
              C. amplitude bookkeeping k_m = a_m (3-g); component
                 round trip; the r-independent deflection ratio
              D. isophotal translation a_m = (g-1) eps_m
              E. zero-enclosed-mass theorem (general integer m >= 1),
                 the Gauss-law form, orthogonality of orders, the point
                 mass as a pure monopole
              F. likelihood-space overlap on a partial arc
              G. first-order shift of the tangential critical curve
                 (multipole: cos(m dphi); point mass: uniform), checked
                 against numerical root finding
              H. the inner-vs-outer residual demonstration (point mass
                 with the ring held fixed vs an m=4 multipole)
              I. the m=1, g=2 resonance
              J. fix-pass checks (2026-10-14): f = 0.01 exceeds the
                 radial-curve annihilation threshold 27/4096 at g = 1.5;
                 radial critical curve only for g < 2; m = 1 sign
                 flip only for g < 2
            Figures: kappa_4 map; radial residual comparison.

   Convention: polar image-plane coordinates (theta, phi); Poisson
               equation Laplacian[psi] = 2 kappa (Module 5); power-law
               convergence kappa_0 = ((3-g)/2)(thE/theta)^(g-1)
               (Module 9, eq:kappa_power_law); g = gamma' (3-D slope).

   Sources: Module 5 (Poisson eq.), Module 8 (multipole series),
            Module 9 (power-law convergence); Congdon & Keeton (2018)
            Sec. 4.1.3 (a linear potential term is a source translation).

   Usage:   bash Mathematica/run_wl.sh Mathematica/19_Multipoles/multipoles_power_law.wl

   Outputs: PASS/FAIL lines + SUMMARY; figures
            Figures/19_Multipoles/kappa4_map.pdf,
            Figures/19_Multipoles/residual_inner_outer.pdf
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "harness.wl"}]];

Print["=== Module 19: multipoles on a power-law base ==="];

figDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Figures", "19_Multipoles"}];
If[!DirectoryQ[figDir], CreateDirectory[figDir, CreateIntermediateDirectories -> True]];

ClearAll[th, ph, phm, g, tE, k, m, n, A, p];
asm = {th > 0, tE > 0, 1 < g < 3, m > 0};
lap[f_] := D[f, {th, 2}] + D[f, th]/th + D[f, {ph, 2}]/th^2;

(* ---------------- A. power-law monopole ---------------- *)
kappa0 = ((3 - g)/2) (tE/th)^(g - 1);
psi0   = tE^(g - 1) th^(3 - g)/(3 - g);
alpha0 = tE^(g - 1) th^(2 - g);
check["A1  Laplacian psi_0 = 2 kappa_0 (power-law monopole potential)",
  FullSimplify[lap[psi0] - 2 kappa0, asm] === 0];
check["A2  alpha_0 = dpsi_0/dtheta = thE^(g-1) theta^(2-g)",
  FullSimplify[D[psi0, th] - alpha0, asm] === 0];
check["A3  alpha_0 = (2/theta) Int_0^theta kappa_0 theta' dtheta'  (enclosed-mass form)",
  FullSimplify[(2/th) Integrate[(kappa0 /. th -> t) t, {t, 0, th}, Assumptions -> asm] - alpha0, asm] === 0];
check["A4  alpha_0(thE) = thE  (Einstein ring)", FullSimplify[(alpha0 /. th -> tE) - tE, asm] === 0];

(* ---------------- B. multipole potential and deflection ---------------- *)
check["B1  Laplacian[theta^p cos(m dphi)] = (p^2 - m^2) theta^(p-2) cos(m dphi)",
  FullSimplify[lap[th^p Cos[m (ph - phm)]] - (p^2 - m^2) th^(p - 2) Cos[m (ph - phm)], th > 0] === 0];
kappaM = (1/2) k (tE/th)^(g - 1) Cos[m (ph - phm)];
psiM   = -k tE^(g - 1) th^(3 - g) Cos[m (ph - phm)]/(m^2 - (3 - g)^2);
check["B2  Laplacian psi_m = 2 kappa_m for general m, g (m^2 != (3-g)^2)",
  FullSimplify[lap[psiM] - 2 kappaM, asm] === 0];
check["B3  exponent matching: theta^(p-2) ~ theta^(1-g) forces p = 3 - g",
  Solve[p - 2 == 1 - g, p] === {{p -> 3 - g}}];
alphaR   = -(3 - g) k tE^(g - 1) th^(2 - g) Cos[m (ph - phm)]/(m^2 - (3 - g)^2);
alphaPhi =  m k tE^(g - 1) th^(2 - g) Sin[m (ph - phm)]/(m^2 - (3 - g)^2);
check["B4  alpha_r = dpsi_m/dtheta", FullSimplify[D[psiM, th] - alphaR, asm] === 0];
check["B5  alpha_phi = (1/theta) dpsi_m/dphi", FullSimplify[D[psiM, ph]/th - alphaPhi, asm] === 0];
(* isothermal limit: Module 8's psi = A theta cos(m dphi) has kappa = A(1-m^2)/(2 theta) cos.
   At g = 2 our psi_m has this form with A = -k thE/(m^2-1). *)
Aiso = -k tE/(m^2 - 1);
check["B6  g=2 limit: psi_m = A theta cos(m dphi) with A = -k thE/(m^2-1)",
  FullSimplify[(psiM /. g -> 2) - Aiso th Cos[m (ph - phm)], th > 0] === 0];
check["B7  ... and Module 8's kappa = A(1-m^2)/(2 theta) cos reproduces kappa_m(g=2)",
  FullSimplify[Aiso (1 - m^2)/(2 th) Cos[m (ph - phm)] - (kappaM /. g -> 2), th > 0 && tE > 0] === 0];
check["B8  m = 0 limit of psi_m with k -> 3-g reproduces the monopole potential psi_0",
  FullSimplify[(psiM /. {m -> 0, k -> (3 - g)}) - psi0, asm] === 0];

(* ---------------- C. amplitude bookkeeping ---------------- *)
amOfk = FullSimplify[(kappaM /. Cos[_] -> 1)/kappa0, asm];
check["C1  a_m = max|kappa_m|/kappa_0 = k/(3-g), independent of theta",
  FullSimplify[amOfk - k/(3 - g), asm] === 0 && FullSimplify[D[amOfk, th], asm] === 0];
check["C2  hence k_m = a_m (3-g)", Simplify[(k /. Solve[amOfk == am, k][[1]]) - am (3 - g)] === 0];
(* component round trip: (e1,e2) = k (cos m phim, sin m phim) *)
e1 = kk Cos[m phm]; e2 = kk Sin[m phm];
check["C3  |(e1,e2)| = k and e1 cos(m phi)+e2 sin(m phi) = k cos(m(phi-phim))",
  FullSimplify[Sqrt[e1^2 + e2^2], kk > 0] === kk &&
  FullSimplify[e1 Cos[m ph] + e2 Sin[m ph] - kk Cos[m (ph - phm)]] === 0];
check["C4  k_m = a_m(3-g): a_m = 0.01 -> k_m = 0.016 (g=1.4), 0.015 (g=1.5), 0.010 (g=2)",
  Abs[0.01 (3 - 1.4) - 0.016] < 10^-12 && Abs[0.01 (3 - 1.5) - 0.015] < 10^-12 && Abs[0.01 (3 - 2) - 0.01] < 10^-12];
ratioSq = FullSimplify[(alphaR^2 + alphaPhi^2)/alpha0^2, asm];
check["C5  |alpha_m|/alpha_0 is independent of theta",
  FullSimplify[D[ratioSq, th], asm] === 0];
check["C6  |alpha_m|^2/alpha_0^2 = k^2[(3-g)^2 cos^2 + m^2 sin^2]/(m^2-(3-g)^2)^2",
  FullSimplify[ratioSq - k^2 ((3 - g)^2 Cos[m (ph - phm)]^2 + m^2 Sin[m (ph - phm)]^2)/(m^2 - (3 - g)^2)^2, asm] === 0];
check["C7  for m > 3-g the maximum over phi is at sin = +-1: m k/(m^2-(3-g)^2)",
  Simplify[Sqrt[k^2 m^2/(m^2 - (3 - g)^2)^2] - m k/(m^2 - (3 - g)^2), k > 0 && m > 3 - g && 1 < g < 3] === 0];
peak[a_, gg_, mm_] := mm a (3 - gg)/(mm^2 - (3 - gg)^2);
check["C8  peak ratio, a_m=0.01: m=3,g=1.5 -> 0.0066667; m=4,g=1.5 -> 0.0043636",
  Abs[peak[0.01, 1.5, 3] - 0.0066666667] < 10^-9 && Abs[peak[0.01, 1.5, 4] - 0.0043636364] < 10^-9];

(* ---------------- D. isophotal translation ---------------- *)
kIso = CC (th/(1 + eps Cos[m (ph - phm)]))^(-(g - 1));
kIsoLin = Normal[Series[kIso, {eps, 0, 1}]];
check["D1  kappa const on theta_iso = theta0[1+eps cos]: kappa = kappa_0[1 + (g-1) eps cos] + O(eps^2)",
  FullSimplify[kIsoLin - CC th^(1 - g) (1 + (g - 1) eps Cos[m (ph - phm)]), asm] === 0];
check["D2  hence a_m = (g-1) eps_m; eps_m = a_m at g = 2",
  FullSimplify[Coefficient[Expand[kIsoLin/(CC th^(1 - g))], eps] - (g - 1) Cos[m (ph - phm)], asm] === 0];
check["D3  eps_m(a_m=0.01): 0.025 (g=1.4), 0.020 (g=1.5), 0.010 (g=2)",
  Abs[0.01/0.4 - 0.025] < 10^-12 && Abs[0.01/0.5 - 0.02] < 10^-12 && Abs[0.01/1.0 - 0.01] < 10^-12];

(* ---------------- E. zero enclosed mass ---------------- *)
intCos = Integrate[Cos[m (ph - phm)], {ph, 0, 2 Pi}, Assumptions -> Element[m, Integers] && m >= 1];
check["E1  Int_0^{2pi} cos(m(phi-phim)) dphi = 0 for every integer m >= 1 (symbolic m)",
  FullSimplify[intCos, Element[m, Integers] && m >= 1] === 0];
dM = Integrate[(kappaM /. th -> t) t, {t, 0, th}, Assumptions -> asm];
check["E2  radial integral of kappa_m converges for g < 3 (Int_0^theta t^(2-g) dt finite)",
  FreeQ[dM, Integrate] ];
check["E3  delta M_m(<theta) = Int dphi Int kappa_m theta' dtheta' = 0 at every theta (symbolic m)",
  FullSimplify[Integrate[dM, {ph, 0, 2 Pi}, Assumptions -> Element[m, Integers] && m >= 1 && th > 0 && tE > 0 && 1 < g < 3],
    Element[m, Integers] && m >= 1 && th > 0 && tE > 0 && 1 < g < 3] === 0];
check["E4  Gauss form: Oint alpha_r theta dphi = 0 for the multipole (symbolic m)",
  FullSimplify[Integrate[alphaR th, {ph, 0, 2 Pi}, Assumptions -> Element[m, Integers] && m >= 1 && asm],
    Element[m, Integers] && m >= 1 && th > 0] === 0];
check["E5  Gauss form for the monopole: Oint alpha_0 theta dphi = 2 Int kappa_0 dA",
  FullSimplify[2 Pi th alpha0 - 2 (2 Pi) Integrate[(kappa0 /. th -> t) t, {t, 0, th}, Assumptions -> asm], asm] === 0];
check["E6  point mass alpha = tb^2/theta: Oint alpha theta dphi = 2 pi tb^2 for every theta (pure monopole)",
  Integrate[(tb^2/th) th, {ph, 0, 2 Pi}] === 2 Pi tb^2];
check["E7  point mass has zero Fourier content in m >= 1 (symbolic m)",
  FullSimplify[Integrate[(tb^2/th) Cos[m ph], {ph, 0, 2 Pi}, Assumptions -> Element[m, Integers] && m >= 1],
    Element[m, Integers] && m >= 1] === 0];
ortho = Integrate[Cos[m (ph - phm)] Cos[n (ph - phn)], {ph, 0, 2 Pi},
   Assumptions -> Element[m, Integers] && Element[n, Integers] && m >= 1 && n >= 1 && m != n];
check["E8  distinct orders orthogonal for arbitrary orientations (symbolic m != n)",
  FullSimplify[ortho, Element[m, Integers] && Element[n, Integers] && m >= 1 && n >= 1 && m != n] === 0];
same = Integrate[Cos[m (ph - phm)] Cos[m (ph - phn)], {ph, 0, 2 Pi}, Assumptions -> Element[m, Integers] && m >= 1];
check["E9  same order: Int cos(m(phi-phim)) cos(m(phi-phin)) = pi cos(m(phim-phin))",
  FullSimplify[same - Pi Cos[m (phm - phn)], Element[m, Integers] && m >= 1] === 0];

(* ---------------- F. partial-arc overlap (likelihood is not kappa) ---------------- *)
(* least-squares amplitude of a phi-independent template fitted to A cos(m phi) on |phi| < D *)
lsAmp = Integrate[Cos[m ph], {ph, -Dl, Dl}]/Integrate[1, {ph, -Dl, Dl}];
check["F1  LS projection of cos(m phi) onto a constant over |phi|<D = sin(mD)/(mD)",
  FullSimplify[lsAmp - Sin[m Dl]/(m Dl), Dl > 0 && m > 0] === 0];
check["F2  full circle (D = pi, integer m >= 1): projection vanishes",
  FullSimplify[lsAmp /. Dl -> Pi, Element[m, Integers] && m >= 1] === 0];
check["F3  m=4 on a quarter-arc (D = pi/8): projection = 2/pi ~ 0.637",
  FullSimplify[lsAmp /. {m -> 4, Dl -> Pi/8}] === 2/Pi];

(* ---------------- G. critical-curve shift ---------------- *)
(* polar Hessian (orthonormal frame) cross-checked against the Cartesian Hessian *)
hessPolar[f_] := {{D[f, {th, 2}], D[f, th, ph]/th - D[f, ph]/th^2},
                  {D[f, th, ph]/th - D[f, ph]/th^2, D[f, th]/th + D[f, {ph, 2}]/th^2}};
ftest = th^3 Cos[2 ph] + th^2 Sin[ph];
fxy = ftest /. {th -> Sqrt[x^2 + y^2], ph -> ArcTan[x, y]};
hxy = {{D[fxy, {x, 2}], D[fxy, x, y]}, {D[fxy, x, y], D[fxy, {y, 2}]}};
rot = {{Cos[ph], Sin[ph]}, {-Sin[ph], Cos[ph]}};
check["G1  polar-frame Hessian formula agrees with the rotated Cartesian Hessian (test function)",
  FullSimplify[(rot . hxy . Transpose[rot] /. {x -> th Cos[ph], y -> th Sin[ph]}) - hessPolar[ftest],
    th > 0 && -Pi < ph < Pi] === {{0, 0}, {0, 0}}];
detA[f_] := Det[IdentityMatrix[2] - hessPolar[f]];
psiTot = psi0 + e psiM;
detLin = Normal[Series[detA[psiTot] /. th -> tE (1 + e d), {e, 0, 1}]];
check["G2  det A vanishes at theta = thE for the monopole alone",
  FullSimplify[(detA[psi0] /. th -> tE), asm] === 0];
dSol = d /. Solve[Coefficient[detLin, e] == 0, d][[1]];
dPred = k (m^2 - (3 - g)) Cos[m (ph - phm)]/((g - 1) (m^2 - (3 - g)^2));
check["G3  first order: delta theta/thE = k (m^2-(3-g)) cos(m dphi)/[(g-1)(m^2-(3-g)^2)]",
  FullSimplify[dSol - dPred, asm] === 0];
check["G4  in terms of a_m: = a_m (3-g)(m^2-3+g) cos/[(g-1)(m^2-(3-g)^2)]",
  FullSimplify[(dPred /. k -> am (3 - g)) - am (3 - g) (m^2 - 3 + g) Cos[m (ph - phm)]/((g - 1) (m^2 - (3 - g)^2)), asm] === 0];
check["G5  isothermal g=2: delta theta/thE = a_m cos(m dphi) for every m (critical curve = kappa=1/2 contour)",
  FullSimplify[(dPred /. {k -> am (3 - g)} /. g -> 2) - am Cos[m (ph - phm)]] === 0];
check["G6  zero azimuthal mean of the multipole critical-curve shift (symbolic m)",
  FullSimplify[Integrate[dPred, {ph, 0, 2 Pi}, Assumptions -> Element[m, Integers] && m >= 1 && asm],
    Element[m, Integers] && m >= 1] === 0];
gfac[gg_, mm_] := (3 - gg) (mm^2 - 3 + gg)/((gg - 1) (mm^2 - (3 - gg)^2));
check["G7  m=4: delta theta/thE = 3.163636 a_m at g=1.5 (3.16% of thE for a_m=0.01); = a_m at g=2",
  Abs[gfac[1.5, 4] - 3.1636363636] < 10^-9 && Abs[gfac[2, 4] - 1] < 10^-12];
(* numerical cross-check by root finding at phi = phim (cos = 1), g = 1.5, m = 4 *)
numShift[am_] := Module[{f, sol},
  f = detA[psiTot] /. {e -> 1, k -> am 3/2, g -> 3/2, m -> 4, tE -> 1, ph -> phm};
  sol = FindRoot[f == 0, {th, 1.0 + 0.0001}, WorkingPrecision -> 30];
  (th /. sol) - 1];
s1 = numShift[1/1000]; s2 = numShift[1/500];
check["G8  numerical root of det A (a_m=0.001, m=4, g=1.5) matches linear shift to O(a_m^2)",
  Abs[s1/(gfac[1.5, 4] 0.001) - 1] < 0.01 && Abs[(s2/(gfac[1.5, 4] 0.002) - 1)/(s1/(gfac[1.5, 4] 0.001) - 1) - 2] < 0.2];
(* point mass with base FIXED: uniform shift f/(g-1) *)
psiPM = psi0 + e fb tE^2 Log[th];
detPM = Normal[Series[detA[psiPM] /. th -> tE (1 + e d), {e, 0, 1}]];
check["G9  point mass (base fixed): delta theta/thE = f/(g-1), phi-independent (m = 0 only)",
  FullSimplify[(d /. Solve[Coefficient[detPM, e] == 0, d][[1]]) - fb/(g - 1), asm] === 0];
check["G10 ... and with the base rescaled to hold the ring (alpha(thE)=thE), the tangential curve stays at thE",
  FullSimplify[((1 - fb) alpha0 + fb tE^2/th)/th /. th -> tE, asm] === 1];

(* ---------------- H. residual demonstration ---------------- *)
thR[gg_] := (2 - gg)^(1/(gg - 1));
check["H1  radial critical curve of the power law: 1 - dalpha_0/dtheta = 0 at theta_r = thE (2-g)^(1/(g-1))",
  And @@ Table[Simplify[((1 - D[alpha0, th]) /. th -> tE (2 - g)^(1/(g - 1))) /. g -> gg, tE > 0] === 0,
     {gg, {11/10, 6/5, 3/2, 7/4, 19/10}}]];
check["H2  g = 1.5: theta_r = 0.25 thE", thR[3/2] === 1/4];
dAlphaPM = fb tE ((tE/th) - (th/tE)^(2 - g));   (* ring held fixed *)
check["H3  ring held fixed: delta alpha_PM = (1-f)alpha_0 + f thE^2/theta - alpha_0 = f thE[(thE/theta) - (theta/thE)^(2-g)]",
  FullSimplify[((1 - fb) alpha0 + fb tE^2/th - alpha0) - dAlphaPM, asm] === 0];
check["H4  delta alpha_PM vanishes on the ring and is positive inside, negative outside",
  FullSimplify[dAlphaPM /. th -> tE, asm] === 0 &&
  (And @@ Flatten[Table[Sign[dAlphaPM /. {fb -> 1/100, tE -> 1, g -> gg, th -> tt}] == Sign[1 - tt],
     {gg, {6/5, 3/2, 2, 5/2}}, {tt, {1/10, 1/2, 9/10, 11/10, 2, 5}}]])];
check["H5  delta alpha_PM / alpha_0 = f[(thE/theta)^(3-g) - 1]",
  FullSimplify[dAlphaPM/alpha0 - fb ((tE/th)^(3 - g) - 1), asm] === 0];
pmRes[t_] := 0.01 (1/t - t^(1/2));             (* f = 0.01, g = 1.5, thE = 1, ring held fixed *)
mpRes[t_] := peak[0.01, 1.5, 4] t^(1/2);         (* a_4 = 0.01, g = 1.5, peak over phi *)
check["H6  point mass, ring fixed (f=0.01, g=1.5): |delta alpha|/thE = 0.0350 at theta_r, 0.00262 at 1.2 thE",
  Abs[pmRes[0.25] - 0.035] < 10^-12 && Abs[Abs[pmRes[1.2]] - 0.0026210] < 10^-6];
check["H7  m=4 multipole (a_4=0.01, g=1.5): peak |delta alpha|/thE = 0.00218 at theta_r, 0.00478 at 1.2 thE",
  Abs[mpRes[0.25] - 0.0021818] < 10^-6 && Abs[mpRes[1.2] - 0.0047801] < 10^-6];
check["H8  multipole residual inner/outer ratio is (theta_in/theta_out)^(2-g) for any a_m, m",
  FullSimplify[(alphaR /. th -> t1)/(alphaR /. th -> t2) - (t1/t2)^(2 - g), t1 > 0 && t2 > 0 && 1 < g < 3] === 0];
check["H9  dalpha_PM/alpha_0 = f (thE/theta)^(3-g)[1 - (theta/thE)^(3-g)]  (grows inward as (thE/theta)^(3-g))",
  FullSimplify[dAlphaPM/alpha0 - fb (tE/th)^(3 - g) (1 - (th/tE)^(3 - g)), asm] === 0];
(* slope degeneracy near the ring: at fixed thE, d alpha_0/d g = -alpha_0 ln(theta/thE) *)
check["H10 at fixed thE: d alpha_0/d gamma' = -alpha_0 ln(theta/thE)",
  FullSimplify[D[alpha0, g] + alpha0 Log[th/tE], asm] === 0];
check["H11 near the ring dalpha_PM/alpha_0 = -f(3-g) ln(theta/thE) + O(ln^2): same shape as a slope change",
  FullSimplify[(D[dAlphaPM/alpha0 /. th -> tE Exp[x], x] /. x -> 0) + fb (3 - g), asm] === 0];
(* re-fit slope: delta g = -f (3-g) removes the linear term; residual f[u^p - 1 - p ln u], u = thE/theta *)
resRefit = fb ((tE/th)^(3 - g) - 1 - (3 - g) Log[tE/th]);
check["H12 ring+slope matched: dalpha/alpha_0 = f[u^p - 1 - p ln u] (u = thE/theta, p = 3-g) = PM term + slope term with dg = -f(3-g)",
  FullSimplify[dAlphaPM/alpha0 + (-fb (3 - g)) (-Log[th/tE]) - resRefit, asm] === 0];
check["H13 ... which vanishes with zero slope at the ring (second order in ln(theta/thE))",
  FullSimplify[resRefit /. th -> tE, asm] === 0 &&
  FullSimplify[(D[resRefit /. th -> tE Exp[x], x] /. x -> 0), asm] === 0 &&
  FullSimplify[(D[resRefit /. th -> tE Exp[x], {x, 2}] /. x -> 0) - fb (3 - g)^2, asm] === 0];
pm2Res[t_] := t^(1/2) 0.01 ((1/t)^(3/2) - 1 - (3/2) Log[1/t]);
check["H14 g=1.5, f=0.01, ring+slope matched: |delta alpha|/thE = 0.02460 at theta_r, 3.747e-4 at 1.2 thE",
  Abs[pm2Res[0.25] - 0.0246028] < 10^-6 && Abs[pm2Res[1.2] - 0.000374731] < 10^-8];
check["H15 opposite ordering: PM/multipole = 11.28 at theta_r but 0.0784 at 1.2 thE",
  Abs[pm2Res[0.25]/mpRes[0.25] - 11.2763] < 10^-3 && Abs[pm2Res[1.2]/mpRes[1.2] - 0.078394] < 10^-5];
check["H16 multipole inner/outer = (0.25/1.2)^(1/2) = 0.4564; PM (ring+slope) inner/outer = 65.65",
  Abs[mpRes[0.25]/mpRes[1.2] - 0.45644] < 10^-5 && Abs[pm2Res[0.25]/pm2Res[1.2] - 65.6545] < 10^-3];
crossLo = t /. FindRoot[pm2Res[t] == mpRes[t], {t, 0.6}];
crossHi = t /. FindRoot[pm2Res[t] == mpRes[t], {t, 2.0}];
check["H17 the multipole dominates between the crossings theta ~ 0.58 thE and ~ 2.09 thE",
  0.57 < crossLo < 0.59 && 2.08 < crossHi < 2.10 && pm2Res[1.0] < mpRes[1.0]];
Print["    crossings: ", crossLo, "  ", crossHi];

(* ---------------- I. m = 1, g = 2 resonance ---------------- *)
check["I1  denominator m^2-(3-g)^2 vanishes at m = 1, g = 2", (m^2 - (3 - g)^2 /. {m -> 1, g -> 2}) === 0];
harm = th Cos[ph - phm];
check["I2  theta cos(phi-phim) is harmonic (zero convergence)", FullSimplify[lap[harm], th > 0] === 0];
check["I3  its gradient is a uniform unit vector: a pure source translation",
  FullSimplify[{D[harm, th], D[harm, ph]/th}, th > 0] === {Cos[ph - phm], -Sin[ph - phm]} &&
  FullSimplify[D[harm, th]^2 + (D[harm, ph]/th)^2] === 1];
check["I4  g = 1.5: m=1 denominator = 1 - 2.25 = -1.25 (sign-flipped, large response)",
  (1 - (3 - 3/2)^2) === -5/4];

(* ---------------- J. fix-pass checks (fact-critic 2026-10-14) ---------------- *)
(* J1-J3 (N4): f = 0.01 used in the worked comparison exceeds the annihilation
   threshold of Chapter 15 eq:pl_mcrit at g = 1.5, so the composite lens has no
   radial critical curve; theta_r = 0.25 thE is the radial critical curve of the
   BASE only.  (J2 fails if the composite lens still had a radial curve.) *)
mcrit[gg_] := (2 - gg) (gg - 1)/2 ((2 - gg) (3 - gg)/2)^((3 - gg)/(gg - 1));
check["J1  m_crit(1.5) = 27/4096 ~ 0.0066 < f = 0.01 (worked comparison is above threshold)",
  mcrit[3/2] === 27/4096 && 27/4096 < 1/100];
lamRfixed[t_, ff_] := (1 - D[tt^(1/2) + ff/tt, tt]) /. tt -> t;            (* thE = 1, g = 1.5, base fixed *)
lamRring[t_, ff_]  := (1 - D[(1 - ff) tt^(1/2) + ff/tt, tt]) /. tt -> t;   (* ring matched *)
minFixed = NMinValue[{lamRfixed[t, 1/100], 10^-4 < t < 1}, t];
minRing  = NMinValue[{lamRring[t, 1/100], 10^-4 < t < 1}, t];
minThr   = NMinValue[{lamRfixed[t, 27/4096], 10^-4 < t < 1}, t];
minBase  = NMinValue[{lamRfixed[t, 0], 10^-4 < t < 1}, t];
Print["    min lambda_r (f=0.01): fixed base ", minFixed, ", ring matched ", minRing,
      "; at f=27/4096: ", minThr, "; base alone: ", minBase];
check["J2  f = 0.01, g = 1.5: min lambda_r > 0 (no radial critical curve), fixed and ring-matched base; base alone < 0",
  minFixed > 0.1 && minRing > 0.1 && minBase < 0];
check["J3  ... and at f = 27/4096 (fixed base) min lambda_r = 0 (the threshold is where the curve disappears)",
  Abs[minThr] < 10^-6];
(* J4 (F2): a power law has a radial critical curve only for g < 2 *)
check["J4  radial critical curve only for g < 2: 1 - alpha_0' = 1 - (2-g)(thE/th)^(g-1) has no zero for 2 <= g < 3",
  FullSimplify[(1 - D[alpha0, th]) - (1 - (2 - g) (tE/th)^(g - 1)), asm] === 0 &&
  FullSimplify[1 - (2 - g) (tE/th)^(g - 1) >= 1, {th > 0, tE > 0, 2 <= g < 3}] === True &&
  Simplify[(1 - (2 - g) (tE/th)^(g - 1)) /. {g -> 3/2, th -> tE/4}] === 0];
(* J5 (F6): the m = 1 prefactor 1-(3-g)^2 has the opposite sign to the m >= 2 ones only for g < 2 *)
check["J5  m=1 denominator < 0 iff g < 2 (-1.25 at 1.5) but > 0 for g > 2 (+0.75 at 2.5, same sign as m>=2)",
  Reduce[Xor[1 - (3 - g)^2 < 0, g < 2] && 1 < g < 3, g, Reals] === False &&
  (1 - (3 - 5/2)^2) === 3/4 && (4 - (3 - 5/2)^2) > 0];

(* ---------------- Figures ---------------- *)
gPlot = 1.5; amPlot = 0.05; mPlot = 4;
kap4[x_, y_] := (1/2) amPlot (3 - gPlot) (1/Sqrt[x^2 + y^2])^(gPlot - 1) Cos[mPlot ArcTan[x, y]];
kapTot[x_, y_] := ((3 - gPlot)/2) (1/Sqrt[x^2 + y^2])^(gPlot - 1) (1 + amPlot Cos[mPlot ArcTan[x, y]]);
p1 = DensityPlot[kap4[x, y], {x, -2, 2}, {y, -2, 2}, PlotPoints -> 120,
   ColorFunction -> (Blend[{RGBColor[0.2, 0.3, 0.8], White, RGBColor[0.8, 0.2, 0.2]}, #] &),
   PlotRange -> {-0.06, 0.06}, ClippingStyle -> Automatic,
   Epilog -> {Black, Dashed, Circle[{0, 0}, 1]},
   FrameLabel -> {Row[{Subscript["\[Theta]", "x"], " / ", Subscript["\[Theta]", "E"]}],
                  Row[{Subscript["\[Theta]", "y"], " / ", Subscript["\[Theta]", "E"]}]},
   PlotLabel -> Row[{Subscript["\[Kappa]", "4"], "  (", Subscript["a", "4"], " = 0.05, \[Gamma]' = 1.5)"}],
   PlotLegends -> Automatic, Exclusions -> None, ImageSize -> 300];
crit[t_] := 1 + gfac[gPlot, mPlot] amPlot Cos[mPlot t];
p2 = Show[
   ContourPlot[kapTot[x, y], {x, -2, 2}, {y, -2, 2}, Contours -> {0.35, 0.5, 0.75, 1.0, 1.5},
     ContourShading -> None, ContourStyle -> Directive[Gray], PlotPoints -> 80],
   ParametricPlot[crit[t] {Cos[t], Sin[t]}, {t, 0, 2 Pi}, PlotStyle -> Directive[Red, AbsoluteThickness[2]]],
   Graphics[{Black, Dashed, Circle[{0, 0}, 1]}],
   Frame -> True, PlotRange -> {{-2, 2}, {-2, 2}}, AspectRatio -> 1,
   FrameLabel -> {Row[{Subscript["\[Theta]", "x"], " / ", Subscript["\[Theta]", "E"]}], None},
   PlotLabel -> Row[{"contours of \[Kappa]; first-order critical curve (red)"}], ImageSize -> 300];
fig1 = GraphicsRow[{p1, p2}, ImageSize -> 700];
Export[FileNameJoin[{figDir, "kappa4_map.pdf"}], fig1, "PDF", "AllowRasterization" -> True, ImageResolution -> 150];
Print["  Exported kappa4_map.pdf"];

fig2 = Show[
   LogLogPlot[{Abs[pmRes[t]], pm2Res[t], mpRes[t]}, {t, 0.1, 3},
     PlotStyle -> {Directive[RGBColor[0.85, 0.5, 0.5], AbsoluteThickness[1.2], Dotted],
                   Directive[Red, AbsoluteThickness[2]],
                   Directive[Blue, AbsoluteThickness[2], Dashed]},
     PlotRange -> {10^-4, 0.2}, PlotPoints -> 200, Exclusions -> None,
     PlotLegends -> Placed[LineLegend[{Directive[RGBColor[0.85, 0.5, 0.5], AbsoluteThickness[1.2], Dotted],
                   Directive[Red, AbsoluteThickness[2]], Directive[Blue, AbsoluteThickness[2], Dashed]},
        {Row[{"point mass, ", Subscript["f", "\[Bullet]"], " = 0.01, ring matched"}],
         Row[{"point mass, ", Subscript["f", "\[Bullet]"], " = 0.01, ring + slope matched"}],
         Row[{"m = 4 multipole, ", Subscript["a", "4"], " = 0.01 (peak over \[CurlyPhi])"}]}], Below],
     Frame -> True,
     FrameLabel -> {Row[{"\[Theta] / ", Subscript["\[Theta]", "E"]}],
                    Row[{"|\[Delta]\[Alpha]| / ", Subscript["\[Theta]", "E"]}]},
     PlotLabel -> Row[{"power-law base, \[Gamma]' = 1.5"}], ImageSize -> 480],
   Graphics[{GrayLevel[0.4], Dashed, Line[{{Log[0.25], Log[10^-4]}, {Log[0.25], Log[0.2]}}],
             Line[{{0, Log[10^-4]}, {0, Log[0.2]}}],
             Text[Style[Subscript["\[Theta]", "r"], 12], {Log[0.25] + 0.12, Log[1.6 10^-4]}],
             Text[Style[Subscript["\[Theta]", "E"], 12], {0.12, Log[1.6 10^-4]}]}]];
Export[FileNameJoin[{figDir, "residual_inner_outer.pdf"}], fig2];
Print["  Exported residual_inner_outer.pdf"];
check["FIG figures written", FileExistsQ[FileNameJoin[{figDir, "kappa4_map.pdf"}]] &&
  FileExistsQ[FileNameJoin[{figDir, "residual_inner_outer.pdf"}]]];

summary[];
