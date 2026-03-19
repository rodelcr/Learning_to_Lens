(* =========================================================================
   problems_01a.wl
   Module 1a: Special Relativity and Tensor Basics — SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 1a, verified
            symbolically with Mathematica.

   Sources: Carroll Ch. 1, Congdon & Keeton Ch. 3.1

   Usage:   wolframscript -file problems_01a.wl

   Exercises solved:
     1.1 — Interval classification (timelike/null/spacelike)
     1.2 — Boost composition and velocity addition
     1.3 — Four-velocity norm proof
     1.4 — Photon energy under Lorentz boost (relativistic Doppler)
     1.5 — Electromagnetic field strength tensor operations
   ========================================================================= *)

Print["=== Module 1a: SOLUTIONS ===\n"];

(* ---- Setup: Minkowski metric ---- *)
eta = DiagonalMatrix[{-1, 1, 1, 1}];

(* =========================================================================
   Exercise 1.1: Interval Classification

   Classify event separations as timelike, null, or spacelike.
   ds^2 = -(Dt)^2 + (Dx)^2 + (Dy)^2 + (Dz)^2
   Timelike: ds^2 < 0;  Null: ds^2 = 0;  Spacelike: ds^2 > 0
   ========================================================================= *)

Print["--- Exercise 1.1: Interval Classification ---\n"];

(* Helper function: compute interval and classify *)
classifyInterval[eventA_, eventB_] := Module[{dx, ds2, class},
    dx = eventB - eventA;
    ds2 = dx . eta . dx;
    class = Which[
        ds2 < 0, "Timelike",
        ds2 == 0, "Null (lightlike)",
        ds2 > 0, "Spacelike"
    ];
    {ds2, class}
];

(* (a) A = (0,0,0,0), B = (2,1,1,0) *)
(* ds^2 = -(2)^2 + (1)^2 + (1)^2 + (0)^2 = -4 + 1 + 1 = -2 *)
Print["(a) A = (0,0,0,0), B = (2,1,1,0):"];
{ds2a, classa} = classifyInterval[{0, 0, 0, 0}, {2, 1, 1, 0}];
Print["    ds^2 = ", ds2a, " => ", classa];
Print["    Interpretation: The events CAN be causally connected."];
Print["    A massive particle could travel from A to B.\n"];

(* (b) A = (0,0,0,0), B = (1,1,0,0) *)
(* ds^2 = -(1)^2 + (1)^2 = 0 *)
Print["(b) A = (0,0,0,0), B = (1,1,0,0):"];
{ds2b, classb} = classifyInterval[{0, 0, 0, 0}, {1, 1, 0, 0}];
Print["    ds^2 = ", ds2b, " => ", classb];
Print["    Interpretation: A light ray connects these events."];
Print["    They lie on each other's light cones.\n"];

(* (c) A = (0,0,0,0), B = (3,1,2,2) *)
(* ds^2 = -(3)^2 + (1)^2 + (2)^2 + (2)^2 = -9 + 1 + 4 + 4 = 0 *)
Print["(c) A = (0,0,0,0), B = (3,1,2,2):"];
{ds2c, classc} = classifyInterval[{0, 0, 0, 0}, {3, 1, 2, 2}];
Print["    ds^2 = ", ds2c, " => ", classc];
Print["    Interpretation: Also null — a light ray connects these events."];
Print["    Check: |Dx|^2 = 1+4+4 = 9 = Dt^2. Confirmed.\n"];


(* =========================================================================
   Exercise 1.2: Boost Composition and Velocity Addition

   Show that two successive x-boosts with rapidities phi1, phi2 equal
   a single boost with rapidity phi1 + phi2. Derive the velocity addition
   formula v = (v1 + v2)/(1 + v1*v2).
   ========================================================================= *)

Print["--- Exercise 1.2: Boost Composition ---\n"];

(* Define boost matrix *)
boostX[phi_] := {
    {Cosh[phi], -Sinh[phi], 0, 0},
    {-Sinh[phi], Cosh[phi], 0, 0},
    {0, 0, 1, 0},
    {0, 0, 0, 1}
};

(* Compose two boosts *)
composed = Simplify[boostX[phi1] . boostX[phi2]];
single = boostX[phi1 + phi2];

Print["Lambda(phi1) . Lambda(phi2):"];
Print["  = ", MatrixForm[composed]];
Print[""];
Print["Lambda(phi1 + phi2):"];
Print["  = ", MatrixForm[single]];
Print[""];
Print["Equal? ", Simplify[composed == single]];
Print[""];

(* Velocity addition: v = tanh(phi), so
   v_combined = tanh(phi1 + phi2)
             = (tanh(phi1) + tanh(phi2)) / (1 + tanh(phi1)*tanh(phi2))
             = (v1 + v2) / (1 + v1*v2) *)
Print["Velocity addition derivation:"];
Print["  v1 = tanh(phi1), v2 = tanh(phi2)"];
Print["  v_combined = tanh(phi1 + phi2)"];

(* Verify the identity symbolically *)
lhs = TrigExpand[Tanh[phi1 + phi2]];
rhs = (Tanh[phi1] + Tanh[phi2]) / (1 + Tanh[phi1] Tanh[phi2]);
Print["  tanh(phi1+phi2) = (tanh(phi1)+tanh(phi2))/(1+tanh(phi1)*tanh(phi2))?"];
Print["  ", FullSimplify[lhs == rhs]];
Print[""];
Print["  Therefore: v = (v1 + v2) / (1 + v1*v2)"];
Print["  Note: For v1, v2 << 1, this reduces to v ~ v1 + v2 (Galilean limit)"];
Print["  For v1 = v2 = c (v1 = v2 = 1): v = 2/(1+1) = 1 = c (speed of light preserved)\n"];


(* =========================================================================
   Exercise 1.3: Four-Velocity Norm

   Prove that U^mu U_mu = -1 for any massive particle (c = 1 units).
   U^mu = dx^mu/dtau = gamma * (1, vx, vy, vz)
   ========================================================================= *)

Print["--- Exercise 1.3: Four-Velocity Norm ---\n"];

Print["Proof:"];
Print["  The four-velocity is U^mu = dx^mu/d(tau)"];
Print["  For a particle with 3-velocity v^i = dx^i/dt:"];
Print["    U^mu = (dt/d(tau)) * (1, v^1, v^2, v^3)"];
Print["         = gamma * (1, v^1, v^2, v^3)"];
Print["  where gamma = dt/d(tau) = 1/sqrt(1 - v^2).\n"];

(* Symbolic computation *)
gamma = 1/Sqrt[1 - vx^2 - vy^2 - vz^2];
Umu = gamma * {1, vx, vy, vz};

(* Compute U^mu U_mu = eta_{mu nu} U^mu U^nu *)
UmuUmu = FullSimplify[
    Umu . eta . Umu,
    Assumptions -> {vx^2 + vy^2 + vz^2 < 1}
];

Print["  U^mu U_mu = eta_{mu nu} U^mu U^nu"];
Print["            = gamma^2 * (-1 + vx^2 + vy^2 + vz^2)"];
Print["            = gamma^2 * (-(1 - v^2))"];
Print["            = (1/(1-v^2)) * (-(1-v^2))"];
Print["            = -1"];
Print[""];
Print["  Mathematica verification: U^mu U_mu = ", UmuUmu, "  (QED)\n"];


(* =========================================================================
   Exercise 1.4: Photon Energy Under Lorentz Boost (Relativistic Doppler)

   A photon with energy E in frame S, propagating at angle theta to the
   x-axis, is observed in frame S' moving with velocity v along x.

   (a) Show E' = gamma * E * (1 - v cos(theta))
   (b) Specialize to theta = 0 and theta = pi/2
   ========================================================================= *)

Print["--- Exercise 1.4: Photon Energy (Relativistic Doppler) ---\n"];

Print["(a) Derivation:"];
Print["  A photon with energy E has four-momentum:"];
Print["    p^mu = E * (1, cos(theta), sin(theta), 0)"];
Print["  (using |p| = E for massless particles, c = 1)\n"];

(* Photon four-momentum *)
pPhoton[En_, th_] := En * {1, Cos[th], Sin[th], 0};

(* Boost matrix along x with velocity v *)
boostXv[vel_] := Module[{gam = 1/Sqrt[1 - vel^2]},
    {
        {gam, -vel*gam, 0, 0},
        {-vel*gam, gam, 0, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 1}
    }
];

(* Transform the photon four-momentum *)
pPrime = Simplify[boostXv[v] . pPhoton[En, th]];
EPrime = pPrime[[1]];  (* The 0-component is the energy *)

Print["  Boosted four-momentum p'^mu:"];
Print["    p'^0 = E' = ", Simplify[EPrime]];
Print[""];
Print["  Simplifying: E' = gamma * E * (1 - v*cos(theta))"];

(* Verify *)
expected = En / Sqrt[1 - v^2] * (1 - v * Cos[th]);
Print["  Matches expected formula? ",
    FullSimplify[EPrime == expected, Assumptions -> {-1 < v < 1}]];
Print[""];

(* (b) Special cases *)
Print["(b) Special cases:"];
Print[""];

(* Head-on: theta = 0 (photon moving in +x direction, observer moving in +x) *)
EPrimeHeadOn = Simplify[EPrime /. th -> 0, Assumptions -> {-1 < v < 1}];
Print["  theta = 0 (photon along +x, same direction as boost):"];
Print["    E' = E * gamma * (1 - v) = E * sqrt((1-v)/(1+v))"];
EPrimeHeadOnSimp = FullSimplify[En * Sqrt[(1 - v)/(1 + v)],
    Assumptions -> {0 < v < 1}];
Print["    = ", EPrimeHeadOnSimp];
Print["    This is a REDSHIFT (E' < E): the photon loses energy"];
Print["    as seen by an observer moving in the same direction.\n"];

(* Transverse: theta = pi/2 *)
EPrimeTransverse = Simplify[EPrime /. th -> Pi/2, Assumptions -> {-1 < v < 1}];
Print["  theta = pi/2 (transverse):"];
Print["    E' = E * gamma = E / sqrt(1 - v^2) = ", EPrimeTransverse];
Print["    This is the TRANSVERSE Doppler effect — a purely relativistic"];
Print["    effect with no classical analogue. The photon is blueshifted"];
Print["    even though it propagates perpendicular to the boost.\n"];


(* =========================================================================
   Exercise 1.5: Electromagnetic Field Strength Tensor

   (a) Show F_{mu nu} is antisymmetric
   (b) Compute F^{mu nu} and check sign changes
   (c) Compute the Lorentz scalar F_{mu nu} F^{mu nu}
   ========================================================================= *)

Print["--- Exercise 1.5: Electromagnetic Field Strength Tensor ---\n"];

(* Define F_{mu nu} (Carroll eq. 1.69) *)
Fdown = {
    {0, -e1, -e2, -e3},
    {e1, 0, b3, -b2},
    {e2, -b3, 0, b1},
    {e3, b2, -b1, 0}
};

Print["F_{mu nu}:"];
Print[MatrixForm[Fdown]];
Print[""];

(* (a) Check antisymmetry: F_{mu nu} = -F_{nu mu} *)
Print["(a) Antisymmetry: F_{mu nu} + F_{nu mu} = 0?"];
antisymCheck = Simplify[Fdown + Transpose[Fdown]];
Print["    F + F^T = ", MatrixForm[antisymCheck]];
Print["    All zeros? ", antisymCheck == ConstantArray[0, {4, 4}]];
Print["    Therefore F_{mu nu} is antisymmetric. (QED)\n"];

(* (b) Raise both indices: F^{mu nu} = eta^{mu alpha} eta^{nu beta} F_{alpha beta} *)
(* In matrix notation: F^{mu nu} = eta . F . eta *)
Print["(b) Raising indices: F^{mu nu} = eta^{mu a} eta^{nu b} F_{a b}"];
Fup = eta . Fdown . eta;
Print["    F^{mu nu}:"];
Print["    ", MatrixForm[Fup]];
Print[""];
Print["    Comparing with F_{mu nu}:"];
Print["    - Electric field components: E_i in F_{0i} -> -E_i in F^{0i}"];
Print["      (sign flip due to raising the time index)"];
Print["    - Magnetic field components: unchanged (both spatial indices)\n"];

(* (c) Compute F_{mu nu} F^{mu nu} *)
Print["(c) Lorentz scalar F_{mu nu} F^{mu nu}:"];

(* Sum over all indices *)
scalar = Sum[Fdown[[mu, nu]] * Fup[[mu, nu]], {mu, 1, 4}, {nu, 1, 4}];
scalarSimp = Simplify[scalar];
Print["    F_{mu nu} F^{mu nu} = ", scalarSimp];
Print[""];

(* Express in terms of E^2 and B^2 *)
(* E^2 = e1^2 + e2^2 + e3^2, B^2 = b1^2 + b2^2 + b3^2 *)
Esquared = e1^2 + e2^2 + e3^2;
Bsquared = b1^2 + b2^2 + b3^2;
expected = 2*(Bsquared - Esquared);
Print["    In terms of E and B fields:"];
Print["    F_{mu nu} F^{mu nu} = 2(B^2 - E^2)"];
Print["    Verification: ", Simplify[scalarSimp == expected]];
Print[""];
Print["    This is a Lorentz invariant: all observers agree on the"];
Print["    value of B^2 - E^2 for any electromagnetic field.\n"];

Print["=== End of Module 1a Solutions ==="];
