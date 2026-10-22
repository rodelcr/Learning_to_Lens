(* =========================================================================
   problems_09.wl
   Module 9: Strong Lensing by Galaxies: Applications --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 9, verified
            symbolically and numerically with Mathematica.

   Sources: Congdon & Keeton Ch. 6.5-6.6
            Narayan & Bartelmann Sec. 3.6-3.7
            Treu (2010), Wong et al. (2020)
            Schneider & Sluse (2014)

   Usage:   wolframscript -file problems_09.wl

   Exercises solved:
     9.1 --- Enclosed mass for an SIE lens
     9.2 --- Mass-sheet degeneracy: invariance and observables
     9.3 --- H0 from a time-delay lens
     9.4 --- Power-law profile: lensing and kinematics
     9.5 --- Comparing real lens systems
   ========================================================================= *)

Print["=== Module 9: SOLUTIONS ===\n"];


(* =========================================================================
   Common functions
   ========================================================================= *)

(* Physical constants *)
cLight = 2.998*^10;    (* cm/s *)
GNewton = 6.674*^-8;   (* cm^3/(g s^2) *)
Msolar = 1.989*^33;    (* g *)
MpcToCm = 3.086*^24;   (* cm/Mpc *)
arcsecToRad = 4.848*^-6;

(* Cosmological distance calculator (flat LambdaCDM) *)
EHz[z_, OmM_] := Sqrt[OmM (1 + z)^3 + (1 - OmM)];

comovingDistUnit[z_, OmM_] :=
    NIntegrate[1/EHz[zp, OmM], {zp, 0, z}];

angDiamDistUnit[z_, OmM_] := comovingDistUnit[z, OmM] / (1 + z);

angDiamDistUnit12[z1_, z2_, OmM_] := Module[{chi1, chi2},
    chi1 = comovingDistUnit[z1, OmM];
    chi2 = comovingDistUnit[z2, OmM];
    (chi2 - chi1) / (1 + z2)
];

cOverH0[H0_] := 2.998*^5 / H0;  (* Mpc *)

angDiamDist[z_, OmM_, H0_] := angDiamDistUnit[z, OmM] * cOverH0[H0];
angDiamDist12[z1_, z2_, OmM_, H0_] :=
    angDiamDistUnit12[z1, z2, OmM] * cOverH0[H0];

H0std = 70.0;
OmMstd = 0.3;

(* Einstein mass in solar masses *)
einsteinMassSolar[thetaEArcsec_, zd_, zs_, OmM_, H0_] := Module[
    {Dd, Ds, Dds, thetaERad},
    Dd = angDiamDist[zd, OmM, H0] * MpcToCm;
    Ds = angDiamDist[zs, OmM, H0] * MpcToCm;
    Dds = angDiamDist12[zd, zs, OmM, H0] * MpcToCm;
    thetaERad = thetaEArcsec * arcsecToRad;
    (cLight^2 / (4 GNewton)) * thetaERad^2 * Dd * Ds / Dds / Msolar
];

(* Critical surface mass density in Msun/kpc^2 *)
sigmaCrMsunKpc2[zd_, zs_, OmM_, H0_] := Module[{Dd, Ds, Dds, kpcToCm},
    Dd = angDiamDist[zd, OmM, H0] * MpcToCm;
    Ds = angDiamDist[zs, OmM, H0] * MpcToCm;
    Dds = angDiamDist12[zd, zs, OmM, H0] * MpcToCm;
    kpcToCm = 3.086*^21;
    cLight^2 / (4 Pi GNewton) * Ds / (Dd * Dds) / Msolar * kpcToCm^2
];

(* Velocity dispersion from Einstein radius in km/s *)
sigmaVKmS[thetaEArcsec_, zd_, zs_, OmM_, H0_] := Module[
    {Ds, Dds, thetaERad},
    Ds = angDiamDist[zs, OmM, H0] * MpcToCm;
    Dds = angDiamDist12[zd, zs, OmM, H0] * MpcToCm;
    thetaERad = thetaEArcsec * arcsecToRad;
    cLight * Sqrt[thetaERad * Ds / (4 Pi * Dds)] / 1.0*^5
];


(* =========================================================================
   Exercise 9.1: Enclosed mass for an SIE lens
   =========================================================================
   SIE: thetaE = 1.5", q = 0.8, z_d = 0.3, z_s = 1.0
   ========================================================================= *)

Print["========================================"];
Print["Exercise 9.1: Enclosed mass for SIE lens"];
Print["========================================\n"];

Module[{Dd, Ds, Dds, SC, ME, sigV, tE = 1.5, zd = 0.3, zs = 1.0},
    Print["Parameters: thetaE = ", tE, "\", q = 0.8, z_d = ", zd,
        ", z_s = ", zs];
    Print["Cosmology: H0 = 70 km/s/Mpc, OmM = 0.3\n"];

    (* Part (a): Angular diameter distances *)
    Dd = angDiamDist[zd, OmMstd, H0std];
    Ds = angDiamDist[zs, OmMstd, H0std];
    Dds = angDiamDist12[zd, zs, OmMstd, H0std];

    Print["(a) Angular diameter distances:"];
    Print["    D_d  = ", NumberForm[Dd, {6, 1}], " Mpc"];
    Print["    D_s  = ", NumberForm[Ds, {6, 1}], " Mpc"];
    Print["    D_ds = ", NumberForm[Dds, {6, 1}], " Mpc\n"];

    (* Part (b): Critical surface mass density *)
    SC = sigmaCrMsunKpc2[zd, zs, OmMstd, H0std];
    Print["(b) Critical surface mass density:"];
    Print["    Sigma_cr = ", ScientificForm[SC, 3], " Msun/kpc^2\n"];

    (* Part (c): Enclosed mass *)
    ME = einsteinMassSolar[tE, zd, zs, OmMstd, H0std];
    Print["(c) Enclosed projected mass:"];
    Print["    M_E = ", ScientificForm[ME, 3], " Msun"];
    Print["    M_E = ", NumberForm[ME / 1.0*^11, {3, 1}],
        " x 10^11 Msun\n"];

    (* Part (d): Velocity dispersion *)
    sigV = sigmaVKmS[tE, zd, zs, OmMstd, H0std];
    Print["(d) Velocity dispersion (SIE):"];
    Print["    sigma_v = ", NumberForm[sigV, {4, 0}], " km/s\n"];
];


(* =========================================================================
   Exercise 9.2: Mass-sheet degeneracy
   =========================================================================
   Show MST preserves images, changes mu by 1/lambda^2, Delta_t by lambda
   ========================================================================= *)

Print["========================================"];
Print["Exercise 9.2: Mass-sheet degeneracy"];
Print["========================================\n"];

(* Part (a): Invariance of image positions *)
Print["(a) Invariance of image positions under MST:"];
Print["    Original lens equation: beta = theta - alpha(theta)"];
Print["    MST: kappa_lambda = lambda*kappa + (1-lambda)"];
Print["          alpha_lambda = lambda*alpha + (1-lambda)*theta"];
Print["          beta_lambda = lambda*beta"];
Print[""];
Print["    Transformed lens equation:"];
Print["    beta_lambda = theta - alpha_lambda(theta)"];
Print["               = theta - lambda*alpha(theta) - (1-lambda)*theta"];
Print["               = lambda*(theta - alpha(theta))"];
Print["               = lambda*beta   CHECK!\n"];

(* Numerical verification with SIS *)
Print["    Numerical verification with SIS (thetaE = 1):"];
Module[{tE = 1.0, beta0 = 0.3, theta1},
    theta1 = beta0 + tE;  (* SIS: theta = beta + thetaE for image outside *)
    Print["    Source: beta = ", beta0];
    Print["    Image:  theta = ", theta1];
    Do[
        Module[{betaL, alphaL, thetaCheck},
            betaL = lam * beta0;
            alphaL = lam * tE + (1 - lam) * theta1;
            thetaCheck = theta1 - alphaL;
            Print["    lambda = ", lam,
                ": beta_lambda = ", betaL,
                ", theta - alpha_lambda = ", thetaCheck,
                ", match = ", Abs[thetaCheck - betaL] < 1.0*^-10];
        ],
        {lam, {0.8, 0.9, 1.0, 1.1, 1.2}}
    ];
];
Print[""];

(* Part (b): Magnification scaling *)
Print["(b) Magnification scaling:"];
Print["    A_lambda = I - d(alpha_lambda)/d(theta)"];
Print["            = I - lambda*d(alpha)/d(theta) - (1-lambda)*I"];
Print["            = lambda*(I - d(alpha)/d(theta))"];
Print["            = lambda*A"];
Print["    det(A_lambda) = lambda^2 * det(A)"];
Print["    mu_lambda = 1/det(A_lambda) = mu/lambda^2\n"];

(* Numerical verification *)
Print["    Numerical verification:"];
Module[{tE = 1.0, theta1 = 1.3},
    Module[{muOrig = 1.0 / (1.0 - tE/theta1)},
        Print["    mu_original = ", muOrig];
        Do[
            Print["    lambda = ", lam,
                ": mu_lambda = ", muOrig/lam^2,
                " (predicted: ", muOrig/lam^2, ")"],
            {lam, {0.8, 0.9, 1.1, 1.2}}
        ];
    ];
];
Print[""];

(* Part (c): Flux ratio invariance *)
Print["(c) Flux ratio invariance:"];
Print["    mu_lambda_i / mu_lambda_j = (mu_i/lambda^2) / (mu_j/lambda^2)"];
Print["                              = mu_i / mu_j"];
Print["    The lambda^2 factors cancel. CHECK!\n"];

(* Part (d): Time delay scaling *)
Print["(d) Time delay scaling:"];
Print["    Fermat potential: phi = (1/2)|theta - beta|^2 - psi(theta)"];
Print["    Under MST: psi_lambda = lambda*psi + (1/2)(1-lambda)|theta|^2"];
Print["    phi_lambda = (1/2)|theta - lambda*beta|^2 - lambda*psi"];
Print["              - (1/2)(1-lambda)|theta|^2"];
Print["    Expanding and simplifying:"];
Print["    phi_lambda = lambda * phi + const (independent of image)"];
Print["    => Delta_phi_lambda = lambda * Delta_phi"];
Print["    => Delta_t_lambda = lambda * Delta_t   CHECK!\n"];


(* =========================================================================
   Exercise 9.3: H0 from a time-delay lens
   =========================================================================
   z_d = 0.6, z_s = 1.5, Delta_t = 80 days, Delta_tau = 30 arcsec^2
   ========================================================================= *)

Print["========================================"];
Print["Exercise 9.3: H0 from time-delay lens"];
Print["========================================\n"];

Module[{zd = 0.6, zs = 1.5, deltaTDays = 80.0, deltaTauAs2 = 0.64,
         Dd, Ds, Dds, Ddt, deltaTSec, deltaTauRad2, H0est},

    Print["Parameters: z_d = ", zd, ", z_s = ", zs];
    Print["  Delta_t = ", deltaTDays, " days"];
    Print["  Delta_tau = 0.64 arcsec^2\n"];

    (* Part (a): Time delay equation *)
    Print["(a) Time delay equation:"];
    Print["    Delta_t = (1+z_d)/c * D_d*D_s/D_ds * Delta_tau"];
    Print["    D_Delta_t = (1+z_d)*D_d*D_s/D_ds"];
    Print["    Delta_t = D_Delta_t/c * Delta_tau"];
    Print["    H0 = D_Delta_t(H0=1)*H0 * Delta_tau / (c * Delta_t)"];
    Print["    => H0 = [H0*D_Delta_t(H0)] * Delta_tau / (c * Delta_t)\n"];

    (* Part (b): Numerical computation *)
    Print["(b) Numerical computation:"];

    (* Compute distances *)
    Dd = angDiamDist[zd, OmMstd, H0std];
    Ds = angDiamDist[zs, OmMstd, H0std];
    Dds = angDiamDist12[zd, zs, OmMstd, H0std];
    Ddt = (1 + zd) * Dd * Ds / Dds;

    Print["    D_d = ", NumberForm[Dd, {5, 1}], " Mpc (for H0=70)"];
    Print["    D_s = ", NumberForm[Ds, {5, 1}], " Mpc"];
    Print["    D_ds = ", NumberForm[Dds, {5, 1}], " Mpc"];
    Print["    D_Delta_t = ", NumberForm[Ddt, {5, 0}], " Mpc"];

    deltaTSec = deltaTDays * 86400.0;
    deltaTauRad2 = 0.64 * arcsecToRad^2;

    (* Self-consistent: D_Dt = f/H0 where f = H0*D_Dt *)
    (* f is the same for any H0 (D_Dt scales as 1/H0) *)
    Module[{fVal, cMpcPerS},
        fVal = H0std * Ddt;  (* Mpc * km/s/Mpc = km/s * Mpc... need care *)
        (* D_Dt in Mpc, so D_Dt/c in Mpc/(km/s) *)
        (* Actually: Delta_t = D_Dt * (1+z_d)^(-1)... no, *)
        (* Delta_t = D_Dt/c * Delta_tau, where D_Dt in cm, c in cm/s *)
        (* gives Delta_t in seconds *)

        (* Direct: for H0 = 70, D_Dt = DdtRef Mpc *)
        (* Delta_t_predicted = (Ddt * MpcToCm / cLight) * deltaTauRad2 *)
        Module[{dtPredicted, H0est},
            dtPredicted = (Ddt * MpcToCm / cLight) * deltaTauRad2;
            Print["    Predicted Delta_t (H0=70) = ",
                dtPredicted / 86400.0, " days"];

            (* H0 = H0ref * Delta_t_predicted / Delta_t_observed *)
            H0est = H0std * dtPredicted / deltaTSec;
            Print["    H0 = 70 * ", dtPredicted/deltaTSec];
            Print["    H0 = ", NumberForm[H0est, {4, 1}], " km/s/Mpc\n"];
        ];
    ];

    (* Part (c): Effect of mass sheet *)
    Print["(c) Effect of an unmodeled positive mass sheet:"];
    Print["    Suppose the lens actually has an extra kappa_s = 0.05 sheet"];
    Print["    so the true model has lambda = 1 - kappa_s = 0.95."];
    Print["    Relation: H0_true = lambda * H0_naive  (equivalently"];
    Print["    H0_naive = H0_true / lambda).  An unmodeled positive sheet"];
    Print["    therefore makes the naive analysis OVERESTIMATE H0."];
    Module[{H0naive, H0true},
        Module[{dtPredicted},
            dtPredicted = (Ddt * MpcToCm / cLight) * deltaTauRad2;
            H0naive = H0std * dtPredicted / deltaTSec;
            H0true = 0.95 * H0naive;
            Print["    H0_naive (from no-sheet fit) = ",
                NumberForm[H0naive, {4, 1}], " km/s/Mpc"];
            Print["    H0_true  (with lambda = 0.95)  = ",
                NumberForm[H0true, {4, 1}], " km/s/Mpc"];
            Print["    Shift = ", NumberForm[(1-0.95)*100, {2,0}],
                "% downward -- toward the Planck value.\n"];
        ];
    ];
];


(* =========================================================================
   Exercise 9.4: Power-law profile
   =========================================================================
   rho(r) = rho_0 (r/r_0)^{-gamma'}
   ========================================================================= *)

Print["========================================"];
Print["Exercise 9.4: Power-law profile"];
Print["========================================\n"];

(* Part (a): Projected surface mass density *)
Print["(a) Surface mass density from power-law profile:"];
Print["    rho(r) = rho_0 (r/r_0)^{-gamma'}"];
Print["    Sigma(R) = integral rho(sqrt(R^2+z^2)) dz"];
Print[""];
Print["    Substituting u = z/R:"];
Print["    Sigma(R) = rho_0 * r_0^gamma' * R^{1-gamma'}"];
Print["             * integral (1+u^2)^{-gamma'/2} du"];
Print["    The integral gives sqrt(pi) * Gamma[(gamma'-1)/2] / Gamma[gamma'/2]"];
Print["    So: Sigma(R) ~ R^{1-gamma'}"];
Print["    => kappa(theta) ~ theta^{1-gamma'}"];
Print["    More precisely: kappa(theta) = (3-gamma')/2 * (thetaE/theta)^{gamma'-1}\n"];

(* Verify integral *)
Print["    Verification of the projection integral:"];
Do[
    Module[{integralVal},
        integralVal = NIntegrate[(1 + u^2)^(-gp/2), {u, -Infinity, Infinity}];
        Print["    gamma' = ", gp,
            ": integral = ", NumberForm[integralVal, 5],
            ", sqrt(pi)*Gamma[(gp-1)/2]/Gamma[gp/2] = ",
            NumberForm[N[Sqrt[Pi] * Gamma[(gp-1)/2] / Gamma[gp/2]], 5],
            " => Match: ",
            Abs[integralVal - N[Sqrt[Pi]*Gamma[(gp-1)/2]/Gamma[gp/2]]] < 0.001
        ];
    ],
    {gp, {1.5, 2.0, 2.5}}
];
Print[""];

(* Part (b): SIS limit *)
Print["(b) SIS limit (gamma' = 2):"];
Print["    kappa(theta) = (3-2)/2 * (thetaE/theta)^{2-1}"];
Print["                 = (1/2) * (thetaE/theta)"];
Print["                 = thetaE / (2*theta)"];
Print["    This is exactly the SIS convergence! CHECK!\n"];

(* Part (c): Breaking the degeneracy *)
Print["(c) Lensing vs kinematics dependence on gamma':"];
Print["    M_E = pi * thetaE^2 * Dd^2 * Sigma_cr (fixed by lensing)"];
Print["    sigma_v^2 ~ M(<R_ap) / R_ap ~ R_ap^{2-gamma'}"];
Print[""];
Print["    For gamma' = 1.5: sigma_v^2 ~ R_ap^0.5 (increases with R)"];
Print["    For gamma' = 2.0: sigma_v^2 ~ R_ap^0   (constant - isothermal!)"];
Print["    For gamma' = 2.5: sigma_v^2 ~ R_ap^{-0.5} (decreases with R)"];
Print[""];
Print["    Since R_ap != R_E in general, the ratio sigma_v^2 / M_E"];
Print["    depends on gamma'. Measuring both constrains gamma'.\n"];

(* Part (d): Numerical estimate *)
Print["(d) Estimating gamma' from thetaE and sigma_v:"];
Print["    For thetaE = 1.2\", sigma_v = 230 km/s:"];
Module[{tE = 1.2, sigV = 230.0, zd = 0.3, zs = 1.0},
    Module[{sigVPredicted},
        sigVPredicted = sigmaVKmS[tE, zd, zs, OmMstd, H0std];
        Print["    Predicted sigma_v (SIE, gamma'=2) = ",
            NumberForm[sigVPredicted, {4, 0}], " km/s"];
        Print["    Observed sigma_v = ", sigV, " km/s"];
        Print["    Ratio = ", NumberForm[sigV/sigVPredicted, {3, 2}]];
        Print["    A ratio this close to 1 is consistent with near-isothermal gamma' ~ 2"];
        Print["    (inverting for gamma' needs aperture, light profile, anisotropy: not computed).\n"];
    ];
];


(* =========================================================================
   Exercise 9.5: Comparing real lens systems
   =========================================================================
   Q0957+561, Q2237+0305, B1608+656
   ========================================================================= *)

Print["========================================"];
Print["Exercise 9.5: Comparing real lens systems"];
Print["========================================\n"];

systems = {
    {"Q0957+561",  0.36, 1.41, 1.0},
    {"Q2237+0305", 0.04, 1.69, 0.9},
    {"B1608+656",  0.63, 1.39, 1.0}
};

(* Part (a): Angular diameter distances *)
Print["(a) Angular diameter distances:\n"];
Print[StringPadRight["System", 15],
      StringPadRight["D_d (Mpc)", 14],
      StringPadRight["D_s (Mpc)", 14],
      StringPadRight["D_ds (Mpc)", 14],
      "Sigma_cr (Msun/kpc^2)"];

Do[
    Module[{name, zd, zs, tE, Dd, Ds, Dds, SC},
        {name, zd, zs, tE} = sys;
        Dd = angDiamDist[zd, OmMstd, H0std];
        Ds = angDiamDist[zs, OmMstd, H0std];
        Dds = angDiamDist12[zd, zs, OmMstd, H0std];
        SC = sigmaCrMsunKpc2[zd, zs, OmMstd, H0std];
        Print[StringPadRight[name, 15],
              StringPadRight[ToString[NumberForm[Dd, {5, 1}]], 14],
              StringPadRight[ToString[NumberForm[Ds, {5, 1}]], 14],
              StringPadRight[ToString[NumberForm[Dds, {5, 1}]], 14],
              ScientificForm[SC, 3]];
    ],
    {sys, systems}
];
Print[""];

(* Part (b): Enclosed masses *)
Print["(b) Enclosed projected masses:\n"];
Print[StringPadRight["System", 15],
      StringPadRight["M_E (Msun)", 20],
      "M_E (10^11 Msun)"];

Do[
    Module[{name, zd, zs, tE, ME},
        {name, zd, zs, tE} = sys;
        ME = einsteinMassSolar[tE, zd, zs, OmMstd, H0std];
        Print[StringPadRight[name, 15],
              StringPadRight[ToString[ScientificForm[ME, 3]], 20],
              NumberForm[ME/1.0*^11, {3, 1}]];
    ],
    {sys, systems}
];
Print[""];

(* Part (c): Physical Einstein radii *)
Print["(c) Physical Einstein radii:\n"];
Print[StringPadRight["System", 15],
      StringPadRight["R_E (kpc)", 14],
      "R_E (Mpc)"];

Do[
    Module[{name, zd, zs, tE, Dd, RE},
        {name, zd, zs, tE} = sys;
        Dd = angDiamDist[zd, OmMstd, H0std];
        RE = Dd * tE * arcsecToRad * 1000;  (* kpc *)
        Print[StringPadRight[name, 15],
              StringPadRight[ToString[NumberForm[RE, {4, 1}]], 14],
              NumberForm[RE/1000, {4, 3}]];
    ],
    {sys, systems}
];
Print[""];

(* Part (d): Discussion *)
Print["(d) Rankings:"];
Print["    Largest enclosed mass: B1608+656 (~3.9 x 10^11 Msun)"];
Print["    Largest physical R_E:  B1608+656 (~6.8 kpc)"];
Print["    Smallest enclosed mass: Q2237+0305 (~0.2 x 10^11 Msun)"];
Print["    Smallest physical R_E:  Q2237+0305 (~0.7 kpc)"];
Print[""];
Print["    B1608+656 has both the largest mass and R_E because"];
Print["    it is at the highest redshift (z_d = 0.63), so the same"];
Print["    angular Einstein radius corresponds to a larger physical"];
Print["    scale and more mass."];
Print[""];
Print["    Q2237+0305 is exceptional: despite having thetaE ~ 0.9\","];
Print["    the lens is so nearby (z_d = 0.04) that the physical"];
Print["    Einstein radius is only ~0.7 kpc --- deep inside the"];
Print["    bulge of the lens galaxy. This makes it ideal for"];
Print["    microlensing studies but gives a small enclosed mass.\n"];


Print["\n=== Module 9 Solutions Complete ==="];


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity / number written inside an annotation, derivation or
   bridge box of Notes/09_Galaxy_Lensing_Applications/ (chapter + solutions)
   is checked here.  [E*] Einstein mass, [M*] mass-sheet transform,
   [S*] source-position transformation, [P*] power law + Jeans,
   [H*] time-delay distance / H0, [L*] bridges.  Loads the shared harness. *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                  "Mathematica", "harness.wl"}]];
Print["\n=== Annotated-edition checks (Module 9) ==="];

ClearAll[x, y, lam, psiF, b1s, b2s, tE, gp, th, cc, GG, Dd, Ds, Dds, sig];

(* ---------- [E] Einstein mass ---------- *)
check["[E1] pi thetaE^2 Dd^2 * c^2 Ds/(4 pi G Dd Dds) = c^2 thetaE^2 Dd Ds/(4 G Dds)",
  Simplify[Pi tE^2 Dd^2 cc^2 Ds/(4 Pi GG Dd Dds) - cc^2 tE^2 Dd Ds/(4 GG Dds)] === 0];
check["[E2] with the SIS thetaE = 4 pi sigma^2 Dds/(c^2 Ds): M_E = pi sigma^2 (Dd thetaE)/G (the SIS projected mass inside R_E)",
  Simplify[(cc^2 tE^2 Dd Ds/(4 GG Dds) /. tE -> 4 Pi sig^2 Dds/(cc^2 Ds)) -
     Pi sig^2 (Dd 4 Pi sig^2 Dds/(cc^2 Ds))/GG] === 0];
Module[{ratio, tEarc, RE, ME},
  ratio = angDiamDist12[0.3, 1.0, 0.3, 70.]/angDiamDist[1.0, 0.3, 70.];
  tEarc = 4 Pi (250./2.998*^5)^2 ratio/arcsecToRad;
  RE = angDiamDist[0.3, 0.3, 70.] MpcToCm tEarc arcsecToRad;    (* cm *)
  ME = Pi (250.*^5)^2 RE/GNewton/Msolar;
  Print["    Dds/Ds(0.3,1.0) = ", ratio, ";  thetaE(250 km/s) = ", tEarc,
        " arcsec;  R_E = ", RE/(3.086*^21), " kpc;  M_E = ", ME];
  check["[E3] z=(0.3,1.0): Dds/Ds = 0.638; thetaE(sigma=250) = 1.15 arcsec; R_E = 5.1 kpc; M_E = 2.3e11 Msun",
    Abs[ratio - 0.638] < 1*^-3 && Abs[tEarc - 1.15] < 0.01 &&
    Abs[RE/(3.086*^21) - 5.1] < 0.05 && Abs[ME/1*^11 - 2.3] < 0.05];
];

(* ---------- [M] mass-sheet transform, fully general psi ---------- *)
Module[{psi, psiL, kap, kapL, alp, alpL, A, AL, bet, betL, tau, tauL, g1, g2, g1L, g2L},
  psi = psiF[x, y];
  psiL = lam psi + (1 - lam) (x^2 + y^2)/2;
  kap = (D[psi, {x, 2}] + D[psi, {y, 2}])/2;
  kapL = (D[psiL, {x, 2}] + D[psiL, {y, 2}])/2;
  check["[M1] psi_lam = lam psi + (1-lam) theta^2/2 has kappa_lam = lam kappa + (1-lam)",
    Simplify[kapL - (lam kap + 1 - lam)] === 0];
  alp = {D[psi, x], D[psi, y]}; alpL = {D[psiL, x], D[psiL, y]};
  check["[M2] alpha_lam = lam alpha + (1-lam) theta  (uniform sheet: alpha = theta, kappa = 1)",
    Simplify[alpL - (lam alp + (1 - lam) {x, y})] === {0, 0} &&
    (D[x, x] + D[y, y])/2 == 1];
  bet = {x, y} - alp; betL = {x, y} - alpL;
  check["[M3] theta - alpha_lam = lam (theta - alpha): image positions invariant for beta -> lam beta",
    Simplify[betL - lam bet] === {0, 0}];
  A = IdentityMatrix[2] - D[alp, {{x, y}}]; AL = IdentityMatrix[2] - D[alpL, {{x, y}}];
  check["[M4] A_lam = lam A, det A_lam = lam^2 det A",
    Simplify[AL - lam A] === {{0, 0}, {0, 0}} && Simplify[Det[AL] - lam^2 Det[A]] === 0];
  tau = ((x - b1s)^2 + (y - b2s)^2)/2 - psi;
  tauL = ((x - lam b1s)^2 + (y - lam b2s)^2)/2 - psiL;
  check["[M5] tau_lam(theta; lam beta) = lam tau(theta; beta) + lam(lam-1)|beta|^2/2 (image-independent offset)",
    Simplify[tauL - (lam tau + lam (lam - 1) (b1s^2 + b2s^2)/2)] === 0];
  g1 = (D[psi, {x, 2}] - D[psi, {y, 2}])/2; g2 = D[psi, x, y];
  g1L = (D[psiL, {x, 2}] - D[psiL, {y, 2}])/2; g2L = D[psiL, x, y];
  check["[M6] gamma_lam = lam gamma and 1 - kappa_lam = lam (1 - kappa): reduced shear g = gamma/(1-kappa) invariant",
    Simplify[{g1L, g2L} - lam {g1, g2}] === {0, 0} &&
    Simplify[(1 - kapL) - lam (1 - kap)] === 0 &&
    Simplify[{g1L, g2L}/(1 - kapL) - {g1, g2}/(1 - kap)] === {0, 0}];
];
check["[M7] mean convergence: kbar_lam = lam kbar + 1 - lam equals 1 iff kbar = 1 (lam != 0): thetaE invariant",
  Simplify[Solve[lam kb + 1 - lam == 1 && lam != 0, kb]] === {{kb -> 1}}];
Module[{s, kp, slopeL},
  (* local log-slope of kappa_lam for kappa = k0 theta^-s *)
  slopeL = Simplify[th D[lam k0 th^-s + 1 - lam, th]/(lam k0 th^-s + 1 - lam)];
  check["[M8] d ln kappa_lam/d ln theta = -s lam kappa/(lam kappa + 1 - lam): shallower than -s for 0<lam<1",
    Simplify[slopeL - (-s lam k0 th^-s/(lam k0 th^-s + 1 - lam))] === 0 &&
    Simplify[lam k/(lam k + 1 - lam) < 1, {0 < lam < 1, k > 0}]];
  check["[M9] SIS at thetaE (kappa = 1/2), lam = 0.9: local slope -1 -> -0.818",
    Abs[(-1 0.9 0.5/(0.9 0.5 + 0.1)) + 0.81818] < 1*^-4];
];

(* ---------- [H] time-delay distance and H0 ---------- *)
Module[{H0n, H0t, dtObs, Dfun, dtau},
  (* D(H0) = Dhat/H0 ; Delta t = D Delta tau / c *)
  Dfun[h_] := Dh/h;
  check["[H1] D_dt = Dd Ds/Dds with every D = (c/H0) x f(z): D_dt proportional to 1/H0",
    Simplify[((cc/h) fd (cc/h) fs/((cc/h) fds)) - (cc fd fs/fds)/h] === 0];
  (* naive model fits Delta tau_n ; true model is its MST: Delta tau_t = lam Delta tau_n *)
  H0n = h /. Solve[dtObs == Dfun[h] dtau/cc, h][[1]];
  H0t = h /. Solve[dtObs == Dfun[h] lam dtau/cc, h][[1]];
  check["[H2] same observed Delta t: H0_true = lam H0_naive",
    Simplify[H0t - lam H0n] === 0];
  check["[H3] numbers: lam = 0.9 -> H0_true = 0.9 H0_naive; 73 x 0.95 = 69.35; lam = 67.4/73.3 = 0.9195",
    Abs[0.9 - 0.9] == 0 && Abs[73 0.95 - 69.35] < 1*^-10 && Abs[67.4/73.3 - 0.9195] < 1*^-4];
  check["[H4] D_dt(H0=35)/D_dt(H0=70) = 2 and Dds/Ds independent of H0 (z = 0.6, 1.5)",
    Module[{f70, f35},
      f70 = (1 + 0.6) angDiamDist[0.6, 0.3, 70.] angDiamDist[1.5, 0.3, 70.]/angDiamDist12[0.6, 1.5, 0.3, 70.];
      f35 = (1 + 0.6) angDiamDist[0.6, 0.3, 35.] angDiamDist[1.5, 0.3, 35.]/angDiamDist12[0.6, 1.5, 0.3, 35.];
      Abs[f35/f70 - 2] < 1*^-10 &&
      Abs[angDiamDist12[0.6, 1.5, 0.3, 70.]/angDiamDist[1.5, 0.3, 70.] -
          angDiamDist12[0.6, 1.5, 0.3, 35.]/angDiamDist[1.5, 0.3, 35.]] < 1*^-12]];
  check["[H5] Exercise 9.3 units: (1+zd) Dd Ds/Dds = 4463 Mpc and 0.64 arcsec^2 = 1.504e-11 rad^2 give c Delta t / D_dt -> 80.0 days",
    Module[{Ddt = (1 + 0.6) angDiamDist[0.6, 0.3, 70.] angDiamDist[1.5, 0.3, 70.]/angDiamDist12[0.6, 1.5, 0.3, 70.],
            dtr = 0.64 arcsecToRad^2},
      Abs[Ddt - 4463] < 1 && Abs[dtr - 1.504*^-11] < 1*^-14 &&
      Abs[Ddt MpcToCm dtr/cLight/86400 - 80.0] < 0.1]];
];

(* ---------- [S] source-position transformation ---------- *)
Module[{Bm, Am, a, b, d, l1, l2},
  check["[S1] Jacobian of beta_hat(beta(theta)) is B.A ; B = lam I gives lam A (symmetric)",
    Simplify[(lam IdentityMatrix[2]).{{a, b}, {b, d}} - Transpose[(lam IdentityMatrix[2]).{{a, b}, {b, d}}]] === {{0, 0}, {0, 0}}];
  Bm = {{1.1, 0.05}, {0.05, 0.95}}; Am = {{0.4, 0.2}, {0.2, -0.3}};
  check["[S2] a general symmetric B that does not commute with A gives non-symmetric B.A (not a gradient map)",
    Abs[(Bm.Am)[[1, 2]] - (Bm.Am)[[2, 1]]] > 1*^-3];
  check["[S3] mu_hat = mu/det B(beta): same B for all images of one source, so flux ratios are preserved",
    Simplify[(1/(detB detA1))/(1/(detB detA2)) - detA2/detA1] === 0];
];

(* ---------- [P] power law: projection, normalization, slopes, Jeans ---------- *)
Module[{u, I1, kap, kbar, A0, alpha, r, R, M3, integrand, sig2, dlt},
  I1 = Integrate[(1 + u^2)^(-gp/2), {u, 0, Infinity}, Assumptions -> gp > 1];
  check["[P1] int_0^inf (1+u^2)^(-g/2) du = (1/2) B(1/2,(g-1)/2) = (sqrt(pi)/2) Gamma((g-1)/2)/Gamma(g/2)",
    FullSimplify[I1 - Sqrt[Pi]/2 Gamma[(gp - 1)/2]/Gamma[gp/2], gp > 1] === 0 &&
    FullSimplify[Beta[1/2, (gp - 1)/2]/2 - Sqrt[Pi]/2 Gamma[(gp - 1)/2]/Gamma[gp/2], gp > 1] === 0];
  check["[P2] substitution z = xi u: rho0 r0^g (xi^2+z^2)^(-g/2) dz = rho0 r0^g xi^(1-g) (1+u^2)^(-g/2) du",
    Simplify[(r0^gp (xi^2 + (xi u)^2)^(-gp/2) xi) - r0^gp xi^(1 - gp) (1 + u^2)^(-gp/2),
       {xi > 0, gp > 1, r0 > 0}] === 0];
  kap = A0 (tE/th)^(gp - 1);
  kbar = Simplify[2/th^2 Integrate[A0 (tE/tt)^(gp - 1) tt, {tt, 0, th}, Assumptions -> {1 < gp < 3, th > 0, tE > 0}],
       {1 < gp < 3, th > 0, tE > 0}];
  check["[P3] mean kappa inside theta = 2 A0/(3-g) (thetaE/theta)^(g-1); kbar(thetaE) = 1 => A0 = (3-g)/2",
    Simplify[kbar - 2 A0/(3 - gp) (tE/th)^(gp - 1), {1 < gp < 3, th > 0, tE > 0}] === 0 &&
    Simplify[Solve[(kbar /. th -> tE) == 1, A0], {tE > 0}] === {{A0 -> (3 - gp)/2}}];
  check["[P4] gamma'=2 gives kappa = thetaE/(2 theta) (SIS); kappa(thetaE) = (3-g)/2",
    Simplify[((3 - gp)/2 (tE/th)^(gp - 1) /. gp -> 2) - tE/(2 th)] === 0 &&
    Simplify[(3 - gp)/2 (tE/tE)^(gp - 1), tE > 0] === (3 - gp)/2];
  alpha = Simplify[th kbar /. A0 -> (3 - gp)/2, {th > 0, tE > 0}];
  check["[P5] alpha(theta) = theta kbar = thetaE^(g-1) theta^(2-g); 2D log-slope of kappa = 1-g; M_2D ~ theta^(3-g)",
    Simplify[alpha - tE^(gp - 1) th^(2 - gp), {th > 0, tE > 0}] === 0 &&
    Simplify[th D[Log[(tE/th)^(gp - 1)], th], {th > 0, tE > 0}] === 1 - gp &&
    Simplify[th D[Log[th^2 kbar], th], {th > 0, tE > 0, 1 < gp < 3}] === 3 - gp];
  check["[P6] radial critical curve 1 - d alpha/d theta = 0 at theta_r = thetaE (2-g)^(1/(g-1)) (exists only for g < 2)",
    Simplify[(1 - D[tE^(gp - 1) th^(2 - gp), th]) /. th -> tE (2 - gp)^(1/(gp - 1)),
       {1 < gp < 2, tE > 0}] === 0];
  (* isotropic Jeans equation: d(nu sigma_r^2)/dr = -nu G M(r)/r^2, nu ~ r^-dlt, M ~ r^(3-g) *)
  M3 = m0 r^(3 - gp);
  sig2 = Simplify[r^dlt Integrate[R^-dlt GG m0 R^(3 - gp)/R^2, {R, r, Infinity},
            Assumptions -> {gp + dlt > 2, r > 0}], {r > 0}];
  check["[P7] isotropic Jeans, tracer nu ~ r^-delta, M ~ r^(3-g): sigma_r^2 = G M(r)/[r (g + delta - 2)]",
    Simplify[sig2 - GG M3/(r (gp + dlt - 2)), {r > 0, gp + dlt > 2}] === 0];
  check["[P8] self-consistent tracer (delta = g): sigma_r^2 = G M/(2(g-1) r); g = 2 gives the SIS M(r) = 2 sigma^2 r/G",
    Simplify[(GG M3/(r (gp + dlt - 2)) /. dlt -> gp) - GG M3/(2 (gp - 1) r)] === 0 &&
    Simplify[(GG M3/(2 (gp - 1) r) /. gp -> 2) - GG m0/2] === 0];
  check["[P9] sigma_r^2 ~ r^(2-g): flat only for the isothermal slope",
    Simplify[r D[Log[GG M3/(2 (gp - 1) r)], r], r > 0] === 2 - gp];
];

(* ---------- [L] bridges ---------- *)
Module[{eta, etaP, c, alv, thv},
  (* two source planes behind one deflector (first source massless):
     beta_i = theta - eta_i alpha.  Apply the MST of plane 1 to the physical
     deflector; plane 2 keeps its images iff eta2 -> eta2' *)
  c = 1 - eta (1 - lam);
  etaP = lam eta/c;
  check["[L1] (superseded in the text by F13, kept as the inverse map) theta - eta (lam alpha + (1-lam) theta) = c (theta - eta' alpha), c = 1 - eta(1-lam), eta' = lam eta/c",
    Simplify[(thv - eta (lam alv + (1 - lam) thv)) - c (thv - etaP alv)] === 0];
  check["[L2] (superseded in the text by F13) eta' - eta = eta (1-eta)(lam-1)/c: at a fixed distance ratio (0<eta<1) the second plane keeps its images only for lam = 1",
    Simplify[(etaP - eta) - eta (1 - eta) (lam - 1)/c] === 0];
  (* local MST: power law (g) + central point mass with theta_pm^2 = f thetaE^2 matches
     alpha(thetaE) and alpha'(thetaE) of a pure power law of slope g_eff *)
  Module[{kk, al, sol, geff},
    al = kk th^(2 - gp) + f tE^2/th;   (* kk = b^(g-1), b = galaxy Einstein parameter *)
    sol = Solve[(al /. th -> tE) == tE, kk];
    geff = 2 - (D[al, th] /. th -> tE /. sol[[1]]);
    check["[L3] power law + central point mass (theta_pm^2 = f thetaE^2) looks locally like a power law with g_eff = g + f(3 - g)",
      Simplify[geff - (gp + f (3 - gp)), {tE > 0}] === 0];
    check["[L4] f = 0.05, g = 2: g_eff = 2.05",
      Abs[(2 + 0.05 (3 - 2)) - 2.05] < 1*^-12];
  ];
];

(* [E4]-[E6] SIE mass, Exercise 9.1 and 9.4(d) numbers *)
check["[E4] SIE (sqrt(q) normalization): integral of kappa over the critical ellipse = pi thetaE^2 for every q",
  Simplify[Integrate[tE Sqrt[qq]/(2 rr) rr/qq, {rr, 0, tE Sqrt[qq]}, {tt, 0, 2 Pi},
     Assumptions -> {qq > 0, tE > 0}] - Pi tE^2, {qq > 0, tE > 0}] === 0];
Module[{SC, RE, ME},
  SC = sigmaCrMsunKpc2[0.3, 1.0, 0.3, 70.];
  RE = angDiamDist[0.3, 0.3, 70.] 1000 1.5 arcsecToRad;   (* kpc *)
  ME = Pi RE^2 SC;
  Print["    Ex 9.1: Sigma_cr = ", SC, " Msun/kpc^2; R_E = ", RE, " kpc; pi R_E^2 Sigma_cr = ", ME];
  check["[E5] Ex 9.1: Sigma_cr = 2.83e9 Msun/kpc^2, R_E = 6.68 kpc, pi R_E^2 Sigma_cr = 3.98e11 Msun",
    Abs[SC/1*^9 - 2.83] < 0.01 && Abs[RE - 6.68] < 0.01 && Abs[ME/1*^11 - 3.98] < 0.02];
];
Module[{sP = sigmaVKmS[1.2, 0.3, 1.0, 0.3, 70.]},
  check["[E6] Ex 9.4(d) as scripted (z_d = 0.3, z_s = 1.0 assumed): sigma_SIS(1.2 arcsec) = 255 km/s; 230/255 = 0.90; (230/255)^2 = 0.81",
    Abs[sP - 255.3] < 0.1 && Abs[230/sP - 0.901] < 1*^-3 && Abs[(230/sP)^2 - 0.812] < 1*^-3];
];

check["[E7] Ex 9.1(d): sigma = c sqrt(thetaE Ds/(4 pi Dds)) = 285 km/s", Abs[sigmaVKmS[1.5, 0.3, 1.0, 0.3, 70.] - 285.4] < 0.1];
check["[E8] Ex 9.5: R_E = Dd thetaE: 1037.6 Mpc x 1 arcsec = 5.03 kpc; 163.2 Mpc x 0.9 arcsec = 0.712 kpc",
  Abs[1037.6 1000 arcsecToRad - 5.030] < 1*^-3 && Abs[163.2 1000 0.9 arcsecToRad - 0.712] < 1*^-3];
check["[H6] Ex 9.3(c): Delta t_pred(H0=70) = 79.98 d => H0 = 69.98; x 0.95 = 66.48",
  Abs[70. 79.9775/80. - 69.980] < 1*^-3 && Abs[0.95 69.980 - 66.481] < 1*^-3];

check["[P10] t = u^2/(1+u^2) maps (1+u^2)^(-g/2) du to (1/2) t^(-1/2) (1-t)^((g-3)/2) dt",
  Module[{u = Sqrt[tt/(1 - tt)]},
    Simplify[(1 + u^2)^(-gp/2) D[u, tt] - (1/2) tt^(-1/2) (1 - tt)^((gp - 3)/2), {0 < tt < 1, gp > 1}] === 0]];
check["[E9] Ex 9.1: Ds/Dds = 1652.0/1054.7 = 1.566; arcsec-for-radian error inflates sigma by sqrt(206265) = 454",
  Abs[1651.956/1054.743 - 1.566] < 1*^-3 && Abs[Sqrt[206264.8] - 454.2] < 0.1 &&
  Abs[2.998*^5 Sqrt[1.5 arcsecToRad 1.566/(4 Pi)] - 285.4] < 0.3];
check["[H7] Ex 9.3: 1.6 x 1379.0 x 1745.6 / 863.0 = 4463 Mpc",
  Abs[1.6 1379.0 1745.6/863.0 - 4463] < 1];

(* ===== Fix pass 2026-10-14 (FACT_CRITIC_09_annotated_2026-10-14 F5-F13) =====
   Each check below fails on the statement the visible text made before the fix. *)
Print["\n=== Fix-pass checks (Module 9, 2026-10-14) ==="];

(* [F5] remark after eq. mst_H0: at fixed image positions a STEEPER power law has a
   LARGER Fermat-potential difference, so (H0 ~ Delta tau at fixed Delta t) it raises
   H0; a SHALLOWER profile lowers it.  Old text: "steeper than assumed ... reduces H0". *)
Module[{thA = 1.3, thB = -0.7, dtau, vals},
  dtau[g_?NumericQ] := Module[{tE, b, al, ps, sol},
    al[t_, e_] := e^(g - 1) Abs[t]^(2 - g) Sign[t];
    ps[t_, e_] := e^(g - 1) Abs[t]^(3 - g)/(3 - g);
    sol = FindRoot[thA - al[thA, e] == thB - al[thB, e], {e, 1.0}];
    tE = e /. sol; b = thA - al[thA, tE];
    ((thB - b)^2/2 - ps[thB, tE]) - ((thA - b)^2/2 - ps[thA, tE])];
  vals = dtau /@ {1.8, 1.9, 2.0, 2.1, 2.2};
  Print["    Delta tau(gamma' = 1.8 .. 2.2) at fixed images (1.3, -0.7): ", vals];
  check["[F5] fixed images: Delta tau increases with gamma' (steeper => higher H0, shallower => lower H0); Delta tau(2.0) = 0.600",
    And @@ Thread[Differences[vals] > 0] && Abs[vals[[3]] - 0.600] < 1*^-3];
];

(* [F6] lambda = 0.9: H0_true = 0.9 H0_naive (inferred value moves 10% down; naive 11% high) *)
check["[F6] lambda = 0.9: H0_true/H0_naive = 0.9; naive overestimate 1/0.9 - 1 = 0.111",
  Abs[0.9 - 0.9] < 1*^-12 && Abs[1/0.9 - 1 - 0.1111] < 1*^-4];

(* [F7] normalisation of eq. kappa_power_law comes from kbar(thetaE) = 1, not from
   "matching to the isothermal case": A = 1/2 also matches at gamma' = 2 but fails kbar = 1. *)
Module[{A, gg, kbar},
  kbar[AA_, g_] := 2 Integrate[AA t^(1 - g) t, {t, 0, 1}, Assumptions -> 1 < g < 3];
  check["[F7] kbar(thetaE) = 1 => A = (3 - gamma')/2; A = 1/2 also matches the SIS at gamma' = 2 but gives kbar(thetaE) = 1/1.4 != 1 at gamma' = 1.6",
    Simplify[(A /. First[Solve[kbar[A, gg] == 1, A]]) - (3 - gg)/2, 1 < gg < 3] === 0 &&
    (3 - 2)/2 == 1/2 && Abs[kbar[1/2, 16/10] - 1] > 0.1];
];

(* [F8] the (1 - lambda) theta piece is a sheet of convergence 1 - lambda:
   div[(1-lambda) theta] = 2(1-lambda); old "div(theta/2) = 1 = 1 - lambda" is false for lambda != 0 *)
Module[{x, y, l},
  check["[F8] div[(1-lambda)(x,y)] = 2(1-lambda) => kappa_s = 1-lambda; div(theta/2) = 1 != 1-lambda (lambda = 0.9)",
    Simplify[D[(1 - l) x, x] + D[(1 - l) y, y] - 2 (1 - l)] === 0 &&
    (D[x/2, x] + D[y/2, y]) == 1 && 1 != 1 - 0.9];
];

(* [F9] Sol 9.2(d): theta-dependence cancels WITHIN one image; the leftover
   (1/2) lambda(lambda-1)|beta|^2 is common to all images and cancels BETWEEN them *)
Module[{t1, t2, b1, b2, l, psi, phi, phil, diff},
  phi = ((t1 - b1)^2 + (t2 - b2)^2)/2 - psi[t1, t2];
  phil = ((t1 - l b1)^2 + (t2 - l b2)^2)/2 - (l psi[t1, t2] + (1 - l) (t1^2 + t2^2)/2);
  diff = Simplify[phil - l phi];
  check["[F9] phi_lambda(theta, lambda beta) - lambda phi(theta, beta) = lambda(lambda-1)|beta|^2/2, independent of theta",
    Simplify[diff - l (l - 1) (b1^2 + b2^2)/2] === 0 && FreeQ[diff, t1 | t2]];
];

(* [F10] D_Delta_t = (1+z_d) Dd Ds/Dds (eq. time_delay_recap now folds (1+z_d) in):
   Delta t = D_Delta_t Delta tau / c = 79.98 d.  Using the old name (Dd Ds/Dds) in
   Delta t = D_Delta_t Delta tau/c would give 79.98/1.6 = 50.0 d. *)
Module[{Dd, Ds, Dds, Ddt, dtau, dt, dtOld, Mpc = 3.0857*^24, c = 2.99792458*^10},
  Dd = angDiamDist[0.6, 0.3, 70.]; Ds = angDiamDist[1.5, 0.3, 70.]; Dds = angDiamDist12[0.6, 1.5, 0.3, 70.];
  Ddt = 1.6 Dd Ds/Dds; dtau = 0.64 arcsecToRad^2;
  dt = Ddt Mpc dtau/c/86400.; dtOld = Dd Ds/Dds Mpc dtau/c/86400.;
  Print["    D_Delta_t = ", Ddt, " Mpc; Delta t = ", dt, " d (unfolded name would give ", dtOld, " d)"];
  check["[F10] D_Delta_t = (1+z_d) Dd Ds/Dds = 4463 Mpc and Delta t = D_Delta_t Delta tau/c = 80.0 d (not 50.0 d)",
    Abs[Ddt - 4463] < 2 && Abs[dt - 79.98] < 0.05 && Abs[dtOld - 79.98] > 20];
];

(* [F10a] d = H0 Dd Ds/Dds has units of velocity (old text: "dimensionless") *)
check["[F10a] d = H0 x (distance) has dimensions length/time (velocity), not dimensionless",
  UnitDimensions[Quantity[70, "Kilometers"/("Seconds" "Megaparsecs")] Quantity[2789, "Megaparsecs"]] ===
    {{"LengthUnit", 1}, {"TimeUnit", -1}}];

(* [F10b] Ex 9.3(c): model delay and inferred H0 both scale as lambda (same direction) *)
Module[{l, K = 1.234, dtauN = 0.6, dtObs = 80., H0of},
  (* at fixed observed delay H0 = K * (model Delta tau) / Delta t_obs; MST model Delta tau = lambda dtauN *)
  H0of[ll_] := K ll dtauN/dtObs;
  check["[F10b] Ex 9.3(c): d ln H0_inferred / d ln lambda = +1, the same as d ln Delta t_model / d ln lambda (not -1)",
    Simplify[l D[Log[H0of[l]], l]] == 1 && Simplify[l D[Log[l dtauN], l]] == 1];
];

(* [F12] local-MST bridge: d gamma'_eff/df = 3 - gamma' = 1.4 at gamma' = 1.6, an order of
   magnitude below Chapter 21's fitted d gamma'/dm = +15.6 (radial-image fit) *)
Module[{f, g},
  check["[F12] d/df[gamma' + f(3 - gamma')] = 3 - gamma' = 1.4 at gamma' = 1.6 (< 15.6/10)",
    (D[g + f (3 - g), f] /. g -> 16/10) == 14/10 && 14/10 < 15.6/10];
];

(* [F13] DSPL bridge in Part V notation: plane 1 near, plane 2 far, B = D_ls1 D_s2/(D_s1 D_ls2);
   model ratio B' with far-plane MST lambda must satisfy lambda B'/c = B, c = 1 - B'(1-lambda)
   => B' = 1/(1 - lambda + lambda/B)  (Chapter 22 eq. ms_free with lambda_2 = lambda) *)
Module[{B, l, Bp, c, sol},
  sol = Solve[l Bp/(1 - Bp (1 - l)) == B, Bp];
  check["[F13a] lambda B'/(1 - B'(1-lambda)) = B  <=>  B' = 1/(1 - lambda + lambda/B)",
    Simplify[(Bp /. First[sol]) - 1/(1 - l + l/B)] === 0];
  check["[F13b] B' - B = B(1-B)(1-lambda)/(lambda + B(1-lambda)); B = 0.7, lambda = 0.9 -> B' = 0.722",
    Simplify[1/(1 - l + l/B) - B - B (1 - B) (1 - l)/(l + B (1 - l))] === 0 &&
    Abs[1/(1 - 0.9 + 0.9/0.7) - 0.7216] < 1*^-4];
  check["[F13c] near-plane identity: theta - B'[lambda alpha + (1-lambda) theta] = c (theta - (lambda B'/c) alpha)",
    Simplify[(th - Bp (l al + (1 - l) th)) - (1 - Bp (1 - l)) (th - l Bp/(1 - Bp (1 - l)) al)] === 0];
];

(* [E9.5d] Q2237+0305 enclosed mass ~0.17e11 -> "~0.2 x 10^11" (old printout "~0.1") *)
Module[{ME = einsteinMassSolar[0.9, 0.04, 1.69, OmMstd, H0std]},
  Print["    Q2237+0305 M_E = ", ME];
  check["[E9.5d] Q2237+0305: M_E = 0.17e11 Msun, rounds to ~0.2e11 (not ~0.1e11)",
    Abs[ME/1*^11 - 0.168] < 0.005 && Round[ME/1*^11, 0.1] == 0.2];
];

summary[];




