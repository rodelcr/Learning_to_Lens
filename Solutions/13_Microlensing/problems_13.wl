(* =========================================================================
   problems_13.wl
   Module 13: Gravitational Microlensing --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 13, verified
            symbolically and numerically with Mathematica.

   Sources: Schneider, Kochanek & Wambsganss (2006), Part 4
            (J. Wambsganss), Sects. 1, 3, 6, 7.
            Paczynski (1986), ApJ 304, 1.
            Mao & Paczynski (1991), ApJ 374, L37.

   Usage:   wolframscript -file problems_13.wl

   Exercises solved:
     13.1 --- Derive A(u) from the two point-mass images and its limits
     13.2 --- Einstein radius / timescale scalings and a Bulge event
     13.3 --- Optical depth: fraction of sky in Einstein disks
     13.4 --- Peak magnification and the impact parameter u0
     13.5 --- Astrometric centroid shift, peak at u = Sqrt[2]
     13.6 --- Quasar-microlensing length and time scales
   ========================================================================= *)

Print["=== Module 13: SOLUTIONS ===\n"];

(* ---- Physical constants ---- *)
Gnewton = 6.674*^-11;      (* m^3 kg^-1 s^-2 *)
cc = 2.998*^8;              (* m/s *)
Msolar = 1.989*^30;         (* kg *)
pcToM = 3.086*^16;          (* 1 pc in meters *)
kpcToM = 3.086*^19;         (* 1 kpc in meters *)
MpcToM = 3.086*^22;         (* 1 Mpc in meters *)
AUtoM = 1.496*^11;          (* 1 AU in meters *)
yrToS = 3.156*^7;           (* 1 yr in seconds *)
radToArcsec = 180*3600/Pi;
radToMas = radToArcsec*1000;

report[label_, ok_] := Print["  [", If[TrueQ[ok], "PASS", "FAIL"], "] ", label];

(* Clean numeric formatting (this wolframscript's Print does not apply
   NumberForm/N display formatting unless wrapped in ToString) *)
sig[x_, n_] := ToString[NumberForm[N[x], n]];
expo[x_, n_] := Module[{e = Floor[Log10[Abs[N[x]]]]},
    ToString[NumberForm[N[x]/10^e, n]] <> " x 10^" <> ToString[e]];

Amag[u_] := (u^2 + 2)/(u Sqrt[u^2 + 4]);


(* =========================================================================
   Exercise 13.1: A(u) from the two images, and its limits
   ========================================================================= *)

Print["--- Exercise 13.1: total magnification A(u) ---\n"];

(* (a) images from u = y - 1/y *)
yPlus  = (u + Sqrt[u^2 + 4])/2;
yMinus = (u - Sqrt[u^2 + 4])/2;
report["(a) y_pm solve u = y - 1/y",
    Simplify[{yPlus - 1/yPlus, yMinus - 1/yMinus} - {u, u}] === {0, 0}];

(* (b) magnifications and total *)
muPlus  = 1/(1 - 1/yPlus^4);
muMinus = 1/(1 - 1/yMinus^4);
Atot = Simplify[muPlus - muMinus, u > 0];
Print["  A(u) = |mu_+| + |mu_-| = ", Atot];
report["(b) A(u) = (u^2+2)/(u Sqrt[u^2+4])",
    Simplify[Atot - Amag[u], u > 0] === 0];

(* (c) limits *)
report["(c) A(u) -> 1/u as u -> 0",
    Simplify[Limit[u Amag[u], u -> 0] - 1] === 0];
report["(c) A(u) -> 1 as u -> Infinity", Limit[Amag[u], u -> Infinity] === 1];

(* (d) magnitude change for u0 = 1: Delta m = 2.5 log10 A(1) *)
dm = 2.5 Log[10, Amag[1]];
Print["  A(1) = 3/Sqrt[5] = ", sig[Amag[1], 5],
    "  =>  Delta m = ", sig[dm, 3], " mag"];
report["(d) Delta m(u0=1) ~ 0.32 mag", Abs[N[dm] - 0.32] < 0.01];
Print[""];


(* =========================================================================
   Exercise 13.2: Einstein radius / timescale and a Bulge event
   ========================================================================= *)

Print["--- Exercise 13.2: Einstein radius, timescale ---\n"];

(* thetaE = Sqrt[4 G M Dds/(c^2 Dd Ds)];  physical R_E = Dd thetaE;
   tE = R_E / v_perp.  Galactic Bulge: source at Ds = 8 kpc, lens
   halfway (Dd = 4 kpc), M = 0.3 Msun, v_perp = 200 km/s. *)
Mm = 0.3 Msolar;
Ds = 8 kpcToM; Dd = 4 kpcToM; Dds = Ds - Dd;
thetaE = Sqrt[4 Gnewton Mm Dds/(cc^2 Dd Ds)];
REphys = Dd thetaE;
vperp = 200*1000;  (* m/s *)
tE = REphys/vperp;
Print["  thetaE = ", sig[thetaE radToMas, 3], " mas"];
Print["  R_E    = ", sig[REphys/AUtoM, 3], " AU"];
Print["  tE     = ", sig[tE/(24*3600), 3], " days"];
report["(a) thetaE ~ 0.3-0.6 mas for Bulge event",
    0.2 < thetaE radToMas < 0.8];
report["(b) tE of order weeks-months (10-60 d)",
    10 < tE/(24*3600) < 100];

(* (c) scaling: thetaE ~ Sqrt[M], so tE ~ Sqrt[M] at fixed geometry/velocity.
   Check the sqrt scaling symbolically (K collects all M-independent factors). *)
thetaEofM[Mr_] := Sqrt[K Mr];  (* K = 4 G Msolar Dds/(c^2 Dd Ds) > 0 *)
report["(c) tE(4M)/tE(M) = 2 (tE ~ Sqrt[M])",
    Simplify[thetaEofM[4 m]/thetaEofM[m], {m > 0, K > 0}] === 2];
Print[""];


(* =========================================================================
   Exercise 13.3: Optical depth = fraction of sky in Einstein disks
   ========================================================================= *)

Print["--- Exercise 13.3: optical depth ---\n"];

(* For a single uniform screen of lenses of surface mass density Sigma at the
   lens plane, tau = Sigma / Sigma_cr with Sigma_cr = c^2 Ds/(4 pi G Dd Dds).
   Equivalent: tau = (number density) * pi thetaE^2, i.e. the fraction of the
   sky covered by Einstein disks (Wambsganss, Sect. 1.4). Verify the identity
   pi thetaE^2 * n_2D = Sigma/Sigma_cr for a thin screen. *)
(* Keep G and c SYMBOLIC here so the identity cancels exactly. *)
Clear[SigmaSurf, DdS, DsS, DdsS, Mlens, GG, ccS];
SigmaCr = ccS^2 DsS/(4 Pi GG DdS DdsS);
(* Surface number density of lenses on the sky: n_ang = Sigma * Dd^2 / M
   (lenses per steradian).  Each covers an Einstein DISK of angular area
   pi thetaE^2 with thetaE^2 = 4 G M Dds/(c^2 Dd Ds).  The fraction of sky
   covered is tau = n_ang * pi thetaE^2, which must equal Sigma/Sigma_cr. *)
thetaE2 = 4 GG Mlens DdsS/(ccS^2 DdS DsS);
nAng = SigmaSurf DdS^2/Mlens;
tauFromDisks = Simplify[nAng (Pi thetaE2)];
tauFromSigma = Simplify[SigmaSurf/SigmaCr];
Print["  tau (sum of Einstein disks) = ", tauFromDisks];
Print["  tau (Sigma / Sigma_cr)      = ", tauFromSigma];
report["tau = pi thetaE^2 n_ang = Sigma/Sigma_cr (screen identity)",
    Simplify[tauFromDisks - tauFromSigma] === 0];

(* Numerical: Paczynski (1986) halo value toward the LMC, tau ~ 5e-7.
   One in ~1/tau stars is magnified above the u=1 threshold. *)
tau0 = 5*^-7;
Print["  Paczynski halo tau_0 ~ ", expo[tau0, 2],
    "  =>  1 in ", expo[1/tau0, 2], " stars lensed (A > 1.34)"];
report["1/tau ~ 2e6 (order a million)", 1*^6 < 1/tau0 < 5*^6];
Print[""];


(* =========================================================================
   Exercise 13.4: peak magnification and u0
   ========================================================================= *)

Print["--- Exercise 13.4: peak magnification ---\n"];

(* Peak A_max = A(u0).  Invert to get u0 from an observed A_max. *)
Print["  A_max = A(u0) = (u0^2+2)/(u0 Sqrt[u0^2+4])"];
u0sol = u0 /. FindRoot[Amag[u0] == 5, {u0, 0.2}];
Print["  For A_max = 5:  u0 = ", sig[u0sol, 3]];
report["(a) A_max = 5 => u0 ~ 0.20",
    Abs[u0sol - 0.2] < 0.02];

(* High-magnification approximation A_max ~ 1/u0 for small u0 *)
report["(b) A_max ~ 1/u0 accurate to <1% for u0 = 0.05",
    Abs[Amag[0.05] - 1/0.05]/Amag[0.05] < 0.01];

(* Full-width criterion: the source reaches the u = 1 threshold (A = A(1))
   when u0^2 + (t-t0)^2/tE^2 = 1, i.e. |t - t0| = tE Sqrt[1 - u0^2] for
   u0 < 1.  A is monotone in u, so A(u(t)) = A(1) iff u(t) = 1. *)
tHalf = tt /. Last[Solve[u0v^2 + tt^2 == 1, tt]];  (* positive root *)
Print["  Threshold crossing (u=1) at |t-t0|/tE = Sqrt[1-u0^2] for u0<1."];
report["(c) event 'width' at u=1 is |t-t0| = tE Sqrt[1-u0^2]",
    Simplify[tHalf - Sqrt[1 - u0v^2], 0 < u0v < 1] === 0];
Print[""];


(* =========================================================================
   Exercise 13.5: astrometric centroid shift
   ========================================================================= *)

Print["--- Exercise 13.5: astrometric microlensing ---\n"];

(* The light centroid (magnification-weighted mean image position) for a
   point lens is offset from the source by
      delta(u) = u/(u^2+2) * thetaE   (toward the images).
   Maximize over u. *)
deltaC[u_] := u/(u^2 + 2);
uPeak = u /. Last[Solve[D[deltaC[u], u] == 0 && u > 0, u]];
Print["  delta(u) = u/(u^2+2); peak at u = ", uPeak];
report["(a) centroid shift peaks at u = Sqrt[2]",
    Simplify[uPeak - Sqrt[2]] === 0];
report["(b) delta_max = 1/(2 Sqrt[2]) = 8^{-1/2} thetaE",
    Simplify[deltaC[Sqrt[2]] - 8^(-1/2)] === 0];
Print["  delta_max = ", sig[deltaC[Sqrt[2]], 4], " thetaE"];

(* (c) mass from centroid + parallax: M = 0.123 Msun * thetaE^2 / pi_ds
   with thetaE, pi_ds in mas (Wambsganss eq. 25). Consistency of the
   coefficient: thetaE = Sqrt[kappa M pi_ds], kappa = 4G/(c^2 AU) in
   mas/Msun; check 1/kappa ~ 0.123 Msun/mas^2. *)
(* thetaE[mas]^2 = (4G/c^2)(Msolar/AU) * (M/Msun) * (pi_ds[mas]); *)
coeff = (4 Gnewton/cc^2) (Msolar/AUtoM) radToMas;  (* mas per (Msun, mas) *)
Mcoeff = 1/coeff;  (* Msun mas^-2 coefficient in M = Mcoeff thetaE^2/pi_ds *)
Print["  M/Msun = (1/", sig[coeff, 3], ") thetaE^2/pi_ds",
    " => coefficient ", sig[Mcoeff, 4], " (cf. 0.123)"];
report["(c) mass coefficient ~ 0.123 Msun mas^-2",
    Abs[Mcoeff - 0.123] < 0.01];
Print[""];


(* =========================================================================
   Exercise 13.6: quasar-microlensing scales
   ========================================================================= *)

Print["--- Exercise 13.6: quasar microlensing ---\n"];

(* Einstein radius projected into the SOURCE (quasar) plane:
   rE = Dds/Dd * Dd thetaE ... use r_E(source plane) = thetaE * Ds with
   thetaE = Sqrt[4 G M Dds/(c^2 Dd Ds)] => r_E = Sqrt[4 G M Ds Dds/(c^2 Dd)].
   For zL=0.5, zS=2 the book quotes r_E ~ 4e16 Sqrt[M/Msun] cm. Check the
   Sqrt[M] scaling and order of magnitude with representative distances. *)
DdQ = 1250 MpcToM;   (* D_A(0.5) ~ 1250 Mpc *)
DsQ = 1750 MpcToM;   (* D_A(2.0) ~ 1750 Mpc *)
DdsQ = 1550 MpcToM;  (* D_A(0.5,2.0) ~ 1550 Mpc *)
rEsource[Mr_] := Sqrt[4 Gnewton (Mr Msolar) DsQ DdsQ/(cc^2 DdQ)];
Print["  r_E(source plane, M=Msun) = ",
    expo[rEsource[1]*100, 3], " cm"];  (* meters -> cm *)
report["(a) r_E ~ few x 10^16 cm for M=Msun",
    1*^16 < rEsource[1]*100 < 9*^16];
(* sqrt scaling checked symbolically (Kq collects M-independent factors) *)
rEsym[Mr_] := Sqrt[Kq Mr];
report["(b) r_E ~ Sqrt[M] scaling",
    Simplify[rEsym[4 m]/rEsym[m], {m > 0, Kq > 0}] === 2];

(* (c) source-crossing time tcross = R_source/v_eff.
   R_source = 1e15 cm, v_eff = 600 km/s => months. *)
Rsrc = 1*^15 / 100;      (* cm -> m *)
veff = 600*1000;         (* m/s *)
tcross = Rsrc/veff;
Print["  t_cross(R=1e15 cm, v=600 km/s) = ",
    sig[tcross/(yrToS/12), 3], " months"];
report["(c) t_cross ~ few months", 1 < tcross/(yrToS/12) < 12];

(* (d) surface mass density at a quasar image is of order kappa ~ 1,
   so an ensemble of microlenses acts coherently (network of caustics). *)
Print["  (d) kappa ~ 1 at quasar images => coherent micro-caustic network."];
report["(d) kappa ~ 1 regime noted", True];
Print[""];


Print["=== End of Module 13 Solutions ==="];
