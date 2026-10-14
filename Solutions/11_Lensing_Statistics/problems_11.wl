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
            (or: bash Mathematica/run_wl.sh Solutions/11_Lensing_Statistics/problems_11.wl)

   Exercises solved: 11.1 point-mass cross-section; 11.2 SIS flux ratio;
            11.3 beta = 1 null of magnification bias.
   Annotated-edition checks (2026-10) appended at the end: every number /
   identity in the derivation, annotation and bridge boxes of 11_Solutions.tex.
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


(* ===== Annotated-edition checks (2026-10) ===== *)
(* Every identity / number in the derivation, annotation and bridge boxes of
   Notes/11_Lensing_Statistics/11_Solutions.tex (Annotated Study Edition).
   This script defines its own check[], so the harness is NOT loaded; the
   results are appended to `results` and tallied below. *)
Print[""]; Print["--- Annotated-edition checks ---"];
ClearAll[mu, u, rr];
(* 11.1(a) quadratic formula *)
aQ = mu^2 - 1; bQ = 4 (mu^2 - 1); cQ = -4;
AppendTo[results, check["11.1(a) discriminant b^2 - 4ac = 16 mu^2 (mu^2 - 1)",
  Simplify[bQ^2 - 4 aQ cQ - 16 mu^2 (mu^2 - 1)] === 0]];
AppendTo[results, check["11.1(a) (-b + Sqrt[disc])/(2a) = -2 + 2 mu/Sqrt[mu^2-1]",
  Simplify[(-bQ + 4 mu Sqrt[mu^2 - 1])/(2 aQ) - (-2 + 2 mu/Sqrt[mu^2 - 1]), Assumptions -> mu > 1] === 0]];
AppendTo[results, check["11.1(a) other root -2 - 2 mu/Sqrt[mu^2-1] < 0 (rejected)",
  Simplify[(-bQ - 4 mu Sqrt[mu^2 - 1])/(2 aQ) + 2 + 2 mu/Sqrt[mu^2 - 1], Assumptions -> mu > 1] === 0]];
(* 11.1(b) series *)
AppendTo[results, check["11.1(b) y^2(mu) = mu^-2 + (3/4) mu^-4 + O(mu^-6)",
  Simplify[Normal[Series[uRoot, {mu, Infinity, 5}]] - (mu^-2 + 3/4 mu^-4)] === 0]];
AppendTo[results, check["11.1(b) -d(y^2)/dmu -> 2 mu^-3 (p(mu) ~ mu^-3)",
  Limit[-D[uRoot, mu] mu^3, mu -> Infinity] === 2]];
AppendTo[results, check["11.1 y^2(mu) = 1 at mu = 3/Sqrt[5] ~ 1.342 (Einstein-radius threshold)",
  Simplify[(uRoot /. mu -> 3/Sqrt[5]) - 1] === 0 && Abs[N[3/Sqrt[5]] - 1.342] < 0.0005]];
(* 11.2 cross-section for flux ratio below r *)
sigR[r_] := ((r - 1)/(r + 1))^2;   (* in units of pi thetaE^2 *)
AppendTo[results, check["11.2 r = 10: y < 9/11, sigma = 0.669 pi thetaE^2",
  sigR[10] === 81/121 && Abs[N[sigR[10]] - 0.669] < 0.0005]];
AppendTo[results, check["11.2 solving (1+y)/(1-y) = r for y gives (r-1)/(r+1)",
  (yv /. Solve[(1 + yv)/(1 - yv) == rr, yv][[1]]) === (rr - 1)/(rr + 1) ||
  Simplify[(yv /. Solve[(1 + yv)/(1 - yv) == rr, yv][[1]]) - (rr - 1)/(rr + 1)] === 0]];
AppendTo[results, check["11.2 signed mu+ + mu- = 2 (not 2/y)", Simplify[(1 + 1/yv) + (1 - 1/yv) - 2] === 0]];
(* 11.3 substitution and the beta -> 2 divergence of the bias integral *)
ClearAll[AA, SS, bt, mm];
AppendTo[results, check["11.3 A (S/mu)^-beta = A S^-beta mu^beta",
  PowerExpand[AA (SS/mm)^-bt - AA SS^-bt mm^bt] === 0]];
AppendTo[results, check["11.3 int_1^Inf mu^-3 mu^beta dmu = 1/(2-beta) for beta<2 (diverges as beta->2)",
  Simplify[Integrate[mm^(bt - 3), {mm, 1, Infinity}, Assumptions -> bt < 2] - 1/(2 - bt)] === 0 &&
  ! FreeQ[Quiet@Check[Integrate[mm^(2 - 3), {mm, 1, Infinity}], $Failed], $Failed | Integrate | DirectedInfinity]]];

ClearAll[sv, cL, d1, d2, s1, s2];
thSISr[dls_, ds_] := 4 Pi sv^2/cL^2 dls/ds;
AppendTo[results, check["11 bridge: SIS Einstein-radius ratio (D_ds1/D_s1)/(D_ds2/D_s2) is independent of sigma_v",
  Simplify[thSISr[d1, s1]/thSISr[d2, s2] - (d1/s1)/(d2/s2)] === 0 &&
  Simplify[D[thSISr[d1, s1]/thSISr[d2, s2], sv]] === 0]];

npassA = Count[results, True]; ntotA = Length[results];
Print["SUMMARY: ", npassA, " PASS, ", ntotA - npassA, " FAIL  (of ", ntotA, " checks, incl. annotated-edition)"];
If[npassA =!= ntotA, Exit[1]];
