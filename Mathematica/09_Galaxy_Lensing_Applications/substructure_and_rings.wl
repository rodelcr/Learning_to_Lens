(* =========================================================================
   substructure_and_rings.wl
   Module 9: Applications — Einstein-ring analytics, folds, and flux ratios
   =========================================================================
   Purpose: Symbolic verification of the new Module 9 results on extended
            sources / Einstein rings, fold-caustic flux relations (relevant
            to flux-ratio anomalies from substructure), and surface-
            brightness conservation.

   Convention: 2D lensing potential psi(theta,phi); Laplacian[psi] = 2 kappa.

   Sources: Schneider, Kochanek & Wambsganss (2006), Part 2 (Kochanek):
            Sec. 8  (substructure & flux-ratio anomalies; fold relation
                     eqs. 122-123), and Sec. 10.1 (analytic Einstein rings,
                     eqs. 140-141; Kochanek, Keeton & McLeod 2001).

   Usage:   wolframscript -file substructure_and_rings.wl

   Outputs: Symbolic PASS/FAIL lines for each result.
   ========================================================================= *)

Print["=== Module 9: Einstein rings, folds, flux ratios — verification ==="];
Print[""];

check[label_, ok_] := (Print[If[TrueQ[ok], "  PASS  ", "  FAIL  "], label]; TrueQ[ok]);
results = {};

(* ---------------------------------------------------------------------------
   Test 1: isothermal lens with arbitrary angular structure.
   psi = b r F(phi)  ==>  kappa = (b/2 r) (F + F'')
   (companion of Module 8 multipole result; underlies the ring formulae)
   --------------------------------------------------------------------------- *)
ClearAll[b, r, phi, F];
lap2D[f_] := D[f, {r, 2}] + (1/r) D[f, r] + (1/r^2) D[f, {phi, 2}];
psiIso = b r F[phi];
kappaIso = Simplify[(1/2) lap2D[psiIso]];
kappaIsoExpected = (b/(2 r)) (F[phi] + F''[phi]);
AppendTo[results,
  check["Isothermal psi=b r F(phi): kappa = (b/2r)(F + F'')",
        Simplify[kappaIso - kappaIsoExpected] === 0]];

(* ---------------------------------------------------------------------------
   Test 2: circular limit F = 1 reproduces the SIS with Einstein radius b.
   kappa = b/(2 r) = thetaE/(2 r) with thetaE = b, and the tangential
   critical curve (lambda_t = 1 - alpha/theta) sits at theta = b.
   --------------------------------------------------------------------------- *)
kappaCirc = Simplify[kappaIso /. {F -> (1 &)}];
AppendTo[results,
  check["Circular isothermal (F=1): kappa = b/(2 r)  [SIS, thetaE=b]",
        Simplify[kappaCirc - b/(2 r)] === 0]];
ClearAll[theta];
alphaSIS = b;                          (* constant deflection of the SIS *)
lambdaT = 1 - alphaSIS/theta;          (* tangential eigenvalue *)
AppendTo[results,
  check["SIS tangential critical curve at theta = b (Einstein radius)",
        Simplify[lambdaT /. theta -> b] === 0]];

(* ---------------------------------------------------------------------------
   Test 3: fold-caustic flux relation (Kochanek eqs. 122-123).
   Near a fold: beta(theta) = -(1/2) c theta^2, muinv(theta) = -c theta,
   with c = psi'''. The two merging images at theta_pm = +/- sqrt(-2 beta0/c)
   have muinv_+ = - muinv_- : equal magnitude, opposite parity, so the
   signed magnifications cancel and the fluxes are equal at leading order.
   A perturber (substructure) that breaks this equality is a flux anomaly.
   --------------------------------------------------------------------------- *)
ClearAll[c, beta0];
thetaP = Sqrt[-2 beta0/c];
thetaM = -Sqrt[-2 beta0/c];
muinv[th_] := -c th;
AppendTo[results,
  check["Fold: muinv(theta_+) = - muinv(theta_-) (equal |mu|, opposite sign)",
        Simplify[muinv[thetaP] + muinv[thetaM]] === 0]];
AppendTo[results,
  check["Fold: the two merging images have equal flux |mu_+| = |mu_-|",
        Simplify[muinv[thetaP]^2 - muinv[thetaM]^2] === 0]];

(* ---------------------------------------------------------------------------
   Test 4: surface-brightness conservation => magnification is a pure
   geometric (area) factor. For a locally linear map beta = A.theta,
   flux ratio = image area / source area = 1/|det A| = |mu|.
   --------------------------------------------------------------------------- *)
ClearAll[k, g1, g2];
Amat = {{1 - k - g1, -g2}, {-g2, 1 - k + g1}};   (* lensing Jacobian A *)
muGeom = 1/Det[Amat];
muExpected = 1/((1 - k)^2 - (g1^2 + g2^2));
AppendTo[results,
  check["SB conservation: mu = 1/det A = 1/((1-k)^2 - |gamma|^2)",
        Simplify[muGeom - muExpected] === 0]];

Print[""];
npass = Count[results, True]; ntot = Length[results];
Print["=== ", npass, "/", ntot, " ring/fold/flux checks passed ==="];
If[npass === ntot,
  Print["ALL MODULE-9 EXTENSION CHECKS PASS"],
  Print["*** SOME CHECKS FAILED ***"]; Exit[1]];
Print["=== End of Module 9 substructure/rings verification ==="];
