(* =========================================================================
   lorentz_transforms.wl
   Module 1a: Special Relativity and Tensor Basics
   =========================================================================
   Purpose: Symbolic construction and verification of Lorentz transformations.
            Demonstrates that boosts and rotations preserve the Minkowski metric.

   Sources: Carroll Ch. 1, Secs. 1.3 (eqs. 1.25--1.35)
            Congdon & Keeton Ch. 3.1

   Usage:   wolframscript -file lorentz_transforms.wl

   Outputs: Printed symbolic verification that:
            1. Lorentz boosts preserve the Minkowski metric
            2. Spatial rotations preserve the Minkowski metric
            3. Boost composition yields rapidity addition
            4. Time dilation and length contraction follow from boosts
   ========================================================================= *)

(* ---- Setup ---- *)
Print["=== Module 1a: Lorentz Transformations ===\n"];

(* =========================================================================
   Section 1: The Minkowski Metric

   The Minkowski metric eta_{mu nu} defines the geometry of flat spacetime.
   We use the mostly-plus convention (-,+,+,+), following Carroll eq. 1.15.
   ========================================================================= *)

eta = DiagonalMatrix[{-1, 1, 1, 1}];
Print["Minkowski metric eta_{mu nu}:"];
Print[MatrixForm[eta]];
Print[""];

(* Verify that the inverse metric has the same components *)
etaInv = Inverse[eta];
Print["Inverse metric eta^{mu nu} (should be identical):"];
Print[MatrixForm[etaInv]];
Print["Verify eta . eta^{-1} = identity: ", eta . etaInv == IdentityMatrix[4]];
Print[""];

(* =========================================================================
   Section 2: Lorentz Boost along the x-axis

   A boost with rapidity phi is given by Carroll eq. 1.32:

     Lambda = {{cosh(phi), -sinh(phi), 0, 0},
               {-sinh(phi), cosh(phi), 0, 0},
               {0, 0, 1, 0},
               {0, 0, 0, 1}}

   The rapidity phi is related to the velocity v by:
     v = tanh(phi),  gamma = cosh(phi)
   ========================================================================= *)

Print["--- Lorentz Boost (x-direction) ---\n"];

(* Boost matrix in terms of rapidity parameter phi *)
boostX[phi_] := {
    {Cosh[phi], -Sinh[phi], 0, 0},
    {-Sinh[phi], Cosh[phi], 0, 0},
    {0, 0, 1, 0},
    {0, 0, 0, 1}
};

Print["Boost matrix Lambda(phi):"];
Print[MatrixForm[boostX[\[Phi]]]];
Print[""];

(* ---- Verify the Lorentz condition: eta = Lambda^T . eta . Lambda ---- *)
(* This is the defining property of Lorentz transformations (Carroll eq. 1.28) *)
lorentzCheck = Simplify[Transpose[boostX[\[Phi]]] . eta . boostX[\[Phi]]];
Print["Verification: Lambda^T . eta . Lambda = "];
Print[MatrixForm[lorentzCheck]];
Print["Equals eta? ", lorentzCheck == eta];
Print[""];

(* ---- Express in terms of velocity v ---- *)
(* Using v = tanh(phi), gamma = 1/sqrt(1 - v^2) = cosh(phi) *)
boostXvelocity[v_] := {
    {1/Sqrt[1 - v^2], -v/Sqrt[1 - v^2], 0, 0},
    {-v/Sqrt[1 - v^2], 1/Sqrt[1 - v^2], 0, 0},
    {0, 0, 1, 0},
    {0, 0, 0, 1}
};

Print["Boost matrix in terms of velocity v (Carroll eq. 1.35):"];
Print[MatrixForm[boostXvelocity[v]]];
Print[""];

(* Verify this also preserves the metric *)
lorentzCheckV = FullSimplify[
    Transpose[boostXvelocity[v]] . eta . boostXvelocity[v],
    Assumptions -> {-1 < v < 1}
];
Print["Lambda(v)^T . eta . Lambda(v) = eta? ", lorentzCheckV == eta];
Print[""];

(* =========================================================================
   Section 3: Spatial Rotation in the x-y Plane

   Carroll eq. 1.31. Rotations are a subset of Lorentz transformations
   that don't mix space and time.
   ========================================================================= *)

Print["--- Spatial Rotation (x-y plane) ---\n"];

rotationXY[theta_] := {
    {1, 0, 0, 0},
    {0, Cos[theta], Sin[theta], 0},
    {0, -Sin[theta], Cos[theta], 0},
    {0, 0, 0, 1}
};

Print["Rotation matrix R(theta):"];
Print[MatrixForm[rotationXY[\[Theta]]]];
Print[""];

(* Verify Lorentz condition for rotations *)
rotCheck = Simplify[Transpose[rotationXY[\[Theta]]] . eta . rotationXY[\[Theta]]];
Print["R^T . eta . R = eta? ", rotCheck == eta];
Print[""];

(* =========================================================================
   Section 4: Composition of Boosts — Rapidity Addition

   Two successive boosts along the x-axis with rapidities phi1 and phi2
   should compose to a single boost with rapidity phi1 + phi2.
   This is the group property of Lorentz boosts and corresponds to
   the relativistic velocity addition formula.
   ========================================================================= *)

Print["--- Boost Composition (Rapidity Addition) ---\n"];

(* Compose two boosts *)
composedBoost = Simplify[boostX[\[Phi]1] . boostX[\[Phi]2]];
singleBoost = boostX[\[Phi]1 + \[Phi]2];

Print["Lambda(phi1) . Lambda(phi2) = Lambda(phi1 + phi2)? "];
Print[Simplify[composedBoost == singleBoost]];
Print[""];

(* Derive the velocity addition formula *)
(* If v1 = tanh(phi1) and v2 = tanh(phi2), then the combined velocity is
   v = tanh(phi1 + phi2) = (tanh(phi1) + tanh(phi2))/(1 + tanh(phi1)*tanh(phi2))
   = (v1 + v2)/(1 + v1*v2) *)
velocityAddition = FullSimplify[TrigExpand[Tanh[\[Phi]1 + \[Phi]2]]];
Print["Combined velocity v = tanh(phi1 + phi2):"];
Print["  = ", velocityAddition];

(* Substitute tanh -> v *)
vAdd = FullSimplify[(v1 + v2)/(1 + v1 v2)];
Print["  = (v1 + v2)/(1 + v1*v2) = ", vAdd];
Print["  This is the relativistic velocity addition formula."];
Print[""];

(* =========================================================================
   Section 5: Time Dilation and Length Contraction

   Derive these directly from the boost transformation.
   ========================================================================= *)

Print["--- Time Dilation and Length Contraction ---\n"];

(* Time dilation: A clock at rest in S' has Delta x' = 0.
   The boost gives: Delta t = gamma * Delta t'
   We apply the INVERSE boost to go from S' to S coordinates. *)
Print["Time dilation:"];
Print["  A clock at rest in S' (Delta x' = 0) with proper time interval Delta t':"];

(* Apply inverse boost (just negate v) to event (Delta t', 0, 0, 0) *)
restClockEvent = {dtp, 0, 0, 0};  (* event in S' frame *)
eventInS = FullSimplify[
    boostXvelocity[-v] . restClockEvent,
    Assumptions -> {-1 < v < 1}
];
Print["  In frame S: Delta t = ", eventInS[[1]]];
Print["  Time dilation factor: gamma = 1/Sqrt[1 - v^2]"];
Print[""];

(* Length contraction: A rod at rest in S' has endpoints measured
   simultaneously in S (Delta t = 0). *)
Print["Length contraction:"];
Print["  A rod of proper length L0 at rest in S', measured in S (Delta t = 0):"];

(* From x' = gamma(x - v*t), if we measure simultaneously in S (t = 0):
   x' = gamma * x, so L0 = gamma * L, giving L = L0/gamma *)
Print["  L = L0 / gamma = L0 * Sqrt[1 - v^2]"];
Print[""];

(* =========================================================================
   Section 6: The Invariant Interval Under Boosts

   Verify that the spacetime interval is preserved by a boost.
   ========================================================================= *)

Print["--- Invariance of the Spacetime Interval ---\n"];

(* Define a general event separation 4-vector *)
dx = {dt, dxx, dy, dz};

(* Compute interval in original frame *)
intervalOriginal = dx . eta . dx // Expand;
Print["Interval in S: ds^2 = ", intervalOriginal];

(* Boost the event separation *)
dxPrime = boostXvelocity[v] . dx // Simplify;
Print["Boosted separation dx': ", dxPrime];

(* Compute interval in boosted frame *)
intervalBoosted = FullSimplify[
    dxPrime . eta . dxPrime,
    Assumptions -> {-1 < v < 1}
];
Print["Interval in S': ds'^2 = ", intervalBoosted];
Print["Intervals equal? ", Simplify[intervalOriginal == intervalBoosted,
    Assumptions -> {-1 < v < 1}]];
Print[""];

(* =========================================================================
   Section 7: Four-Velocity Norm

   Verify that U^mu U_mu = -1 for any massive particle.
   ========================================================================= *)

Print["--- Four-Velocity Norm ---\n"];

(* Four-velocity: U^mu = gamma * (1, vx, vy, vz) *)
gamma = 1/Sqrt[1 - vx^2 - vy^2 - vz^2];
Umu = gamma * {1, vx, vy, vz};

(* Compute U^mu U_mu = eta_{mu nu} U^mu U^nu *)
normU = FullSimplify[
    Umu . eta . Umu,
    Assumptions -> {vx^2 + vy^2 + vz^2 < 1}
];
Print["U^mu U_mu = ", normU];
Print["(Should be -1 for any subluminal velocity.)"];
Print[""];

Print["=== End of Module 1a: Lorentz Transformations ==="];
