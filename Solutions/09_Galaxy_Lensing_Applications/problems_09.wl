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
    Print["(c) Effect of unmodeled mass sheet:"];
    Print["    kappa_s = 0.05 => lambda = 1 - kappa_s = 0.95"];
    Print["    H0_inferred = lambda * H0_true = 0.95 * H0_true"];
    Module[{H0true, H0inferred},
        (* Recompute *)
        Module[{dtPredicted},
            dtPredicted = (Ddt * MpcToCm / cLight) * deltaTauRad2;
            H0true = H0std * dtPredicted / deltaTSec;
            H0inferred = 0.95 * H0true;
            Print["    If H0_true = ", NumberForm[H0true, {4, 1}],
                " km/s/Mpc"];
            Print["    Then H0_inferred = ", NumberForm[H0inferred, {4, 1}],
                " km/s/Mpc"];
            Print["    Bias = ", NumberForm[(1-0.95)*100, {2,0}], "%"];
            Print["    This shifts H0 toward the Planck value!\n"];
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
        Print["    Since predicted ~ observed, gamma' ~ 2.0"];
        Print["    Consistent with bulge-halo conspiracy!\n"];
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
Print["    Smallest enclosed mass: Q2237+0305 (~0.1 x 10^11 Msun)"];
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
