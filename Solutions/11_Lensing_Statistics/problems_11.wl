(* =========================================================================
   problems_11.wl
   Module 11: Solutions to Exercises — symbolic verification
   =========================================================================
   Purpose: Verify the answers to the Module 11 problem set (lensing
            statistics): the point-mass magnification cross-section, the
            SIS total magnification / flux ratio, and the beta = 1 null
            of magnification bias.

   Sources: Schneider, Kochanek & Wambsganss (2006), Part 1, Sec. 5.

   Usage:   wolframscript -file problems_11.wl
   ========================================================================= *)

Print["=== Module 11: Solutions — symbolic verification ==="];
Print[""];
check[label_, ok_] := (Print[If[TrueQ[ok], "  PASS  ", "  FAIL  "], label]; TrueQ[ok]);
results = {};

(* --- Exercise 11.1: point-mass magnification cross-section --- *)
ClearAll[y, mu, u];
muP[yy_] := (yy^2 + 2)/(yy Sqrt[yy^2 + 4]);
(* (a) with u = y^2, mu_p^2 = mu^2 gives (mu^2-1)u^2 + 4(mu^2-1)u - 4 = 0;
   verify the stated root u = 2(mu/Sqrt[mu^2-1]-1) satisfies it. *)
uRoot = 2 (mu/Sqrt[mu^2 - 1] - 1);
quad = (mu^2 - 1) u^2 + 4 (mu^2 - 1) u - 4;
AppendTo[results,
  check["11.1(a) u=2(mu/Sqrt[mu^2-1]-1) solves the cross-section quadratic",
        Simplify[quad /. u -> uRoot, Assumptions -> mu > 1] === 0]];
(* also confirm it inverts mu_p(y) directly *)
AppendTo[results,
  check["11.1(a) y^2(mu) inverts mu_p(y)",
        Simplify[muP[Sqrt[uRoot]] - mu, Assumptions -> mu > 1] === 0]];
(* (b) high-mu limit: sigma ~ mu^-2 (=> p(mu) ~ mu^-3) *)
AppendTo[results,
  check["11.1(b) mu^2 * y^2(mu) -> 1 as mu->Infinity (sigma ~ mu^-2)",
        Limit[mu^2 uRoot, mu -> Infinity] === 1]];

(* --- Exercise 11.2: SIS magnification and flux ratio --- *)
ClearAll[yv];
muSISplus = 1 + 1/yv; muSISminusAbs = 1/yv - 1;
AppendTo[results,
  check["11.2 SIS total magnification mu = 2/y",
        Simplify[(muSISplus + muSISminusAbs) - 2/yv] === 0]];
AppendTo[results,
  check["11.2 SIS flux ratio r = (1+y)/(1-y)",
        Simplify[muSISplus/muSISminusAbs - (1 + yv)/(1 - yv)] === 0]];
(* threshold r -> y = (r-1)/(r+1) *)
ClearAll[r];
AppendTo[results,
  check["11.2 flux ratio < r  <=>  y < (r-1)/(r+1)",
        Simplify[((1 + yv)/(1 - yv) == r) /. yv -> (r - 1)/(r + 1)]]];

(* --- Exercise 11.3: beta = 1 null of magnification bias --- *)
ClearAll[A, S, beta, muc];
N0[s_] := A s^(-beta);
Nlensed = (1/muc) N0[S/muc];
AppendTo[results,
  check["11.3 N(>S) = N0(>S) * muc^(beta-1) for constant mu",
        Simplify[Nlensed - N0[S] muc^(beta - 1),
                 Assumptions -> {S > 0, muc > 0}] === 0]];
AppendTo[results,
  check["11.3 counts unchanged at beta = 1",
        Simplify[(Nlensed - N0[S]) /. beta -> 1,
                 Assumptions -> {S > 0, muc > 0}] === 0]];

Print[""];
npass = Count[results, True]; ntot = Length[results];
Print["=== ", npass, "/", ntot, " Module 11 solution checks passed ==="];
If[npass === ntot,
  Print["ALL MODULE-11 SOLUTION CHECKS PASS"],
  Print["*** SOME CHECKS FAILED ***"]; Exit[1]];
