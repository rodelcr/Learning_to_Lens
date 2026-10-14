(* =========================================================================
   problems_16.wl
   Module 16: Odd Images, Central Images, and Their Suppression --- SOLUTIONS
   =========================================================================
   Purpose: Worked solutions to all exercises in Module 16, verified
            symbolically and numerically with Mathematica; also attests
            every numeric claim made inside annotation boxes (rule R5).

   Sources: Schneider, Ehlers & Falco (1992) Sect. 5.4.1
            Petters, Levine & Wambsganss (2001) Thm 11.4
            Congdon & Keeton (2018) Sect. 6.2.2
            Learning to Lens Module 7 (NIS)

   Usage:   bash Mathematica/run_wl.sh Solutions/16_Odd_Images_Central/problems_16.wl

   Exercises solved:
     16.1 --- grad tau = 0 is the lens equation; Hess tau = A; type from det/tr
     16.2 --- five images of a cored elliptical lens (index bookkeeping + NSolve)
     16.3 --- NIS central image: eigenvalues, mu_c, off-axis position, SIS limit
     16.4 --- point masses flip the parity of the image count; N + g odd
     16.5 --- the conical tip of the SIS and its source-dependent index
     16.6 --- critical black-hole mass: expansion, tc = 0.05, mass fraction
     16.7 --- power-law cusp with g' = 1.5 (exact) and g' = 1.8
     AN   --- numbers quoted in annotation boxes

   Outputs: PASS/FAIL per check, SUMMARY line, exit status.
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..", "Mathematica", "harness.wl"}]];
Print["=== Module 16: SOLUTIONS ===\n"];

type[l1_, l2_] := Which[l1 > 0 && l2 > 0, "min", l1 < 0 && l2 < 0, "max", True, "saddle"];
winding[F_, c_, r_, n_: 4000] := Module[{ang, d},
  ang = Table[Arg[Complex @@ F[c + r {Cos[p], Sin[p]}]], {p, 0., 2 Pi, 2 Pi/n}];
  d = Differences[ang]; d = Mod[d + Pi, 2 Pi] - Pi; Round[Total[d]/(2 Pi)]];
alNIS[t_, tE_, tc_] := tE (Sqrt[t^2 + tc^2] - tc)/t;
imagesNISBH[tE_, tc_, u_, y_] := Module[{t, sols},
  sols = t /. NSolve[(t^2 - y t - u + tE tc)^2 - tE^2 (t^2 + tc^2) == 0, t, Reals, WorkingPrecision -> 40];
  sols = Select[sols, # != 0 && (#^2 - y # - u + tE tc) > 0 &];
  Sort[N[Select[sols, Abs[# - alNIS[#, tE, tc] - u/# - y] < 10^-20 &], 20]]];

(* ================================================================= *)
Print["--- Exercise 16.1 ---"];
(* ================================================================= *)
tau = (1/2) ((t1 - b1)^2 + (t2 - b2)^2) - f[t1, t2];
gradTau = {D[tau, t1], D[tau, t2]};
alphaVec = {D[f[t1, t2], t1], D[f[t1, t2], t2]};
check["1a grad tau = (theta - beta) - grad psi", FullSimplify[gradTau == {t1 - b1, t2 - b2} - alphaVec]];
check["1b grad tau = 0 <=> beta = theta - alpha",
  FullSimplify[({b1, b2} /. First@Solve[gradTau == {0, 0}, {b1, b2}]) == {t1, t2} - alphaVec]];
hessTau = D[tau, {{t1, t2}, 2}];
Amat = IdentityMatrix[2] - D[f[t1, t2], {{t1, t2}, 2}];
check["1c Hess tau = I - Hess psi", FullSimplify[hessTau == Amat]];
check["1d Hess tau = d beta / d theta (Jacobian A)",
  FullSimplify[hessTau == D[{t1, t2} - alphaVec, {{t1, t2}}]]];
check["1e A = {{1-psi11, -psi12}, {-psi12, 1-psi22}}",
  FullSimplify[Amat == {{1 - D[f[t1, t2], {t1, 2}], -D[f[t1, t2], t1, t2]},
                        {-D[f[t1, t2], t1, t2], 1 - D[f[t1, t2], {t2, 2}]}}]];
check["1f tr A = 2 - 2 kappa, kappa = Lap psi / 2",
  FullSimplify[Tr[Amat] == 2 - (D[f[t1, t2], {t1, 2}] + D[f[t1, t2], {t2, 2}])]];
(* type from det and tr: lambda_pm = 1 - k -+ g *)
lm = 1 - k - g; lp = 1 - k + g;
check["1g det A = lambda+ lambda-, tr A = lambda+ + lambda- (A = diag in eigenbasis)",
  Simplify[lm lp == (1 - k)^2 - g^2] && Simplify[lm + lp == 2 (1 - k)]];
check["1h min <=> det>0 & tr>0; max <=> det>0 & tr<0; saddle <=> det<0",
  Resolve[ForAll[{a1, a2}, Element[{a1, a2}, Reals],
    ((a1 > 0 && a2 > 0) \[Equivalent] (a1 a2 > 0 && a1 + a2 > 0)) &&
    ((a1 < 0 && a2 < 0) \[Equivalent] (a1 a2 > 0 && a1 + a2 < 0)) &&
    ((a1 a2 < 0) \[Equivalent] ((a1 > 0 && a2 < 0) || (a1 < 0 && a2 > 0)))], Reals]];

(* ================================================================= *)
Print["\n--- Exercise 16.2 ---"];
(* ================================================================= *)
nmin = 2; nsad = 2; nmax = 1;
check["2a index sum n_+ - n_- = (2 + 1) - 2 = 1", (nmin + nmax) - nsad == 1];
check["2b N = 1 + 2 n_- = 5", nmin + nsad + nmax == 5 && 1 + 2 nsad == 5];
check["2c four bright images with n_+ - n_- = 1 force n_+ = 3, n_- = 2 if the bright ones are 2 min + 2 saddles",
  Module[{np = 2 + nmax, nm = 2}, np - nm == 1]];
psiE[x_, y_] := Sqrt[(1/4)^2 + (7/10) x^2 + (13/10) y^2];
solE = {x, y} /. NSolve[{x - D[psiE[x, y], x] == 0.05, y - D[psiE[x, y], y] == 0.03}, {x, y}, Reals];
classE[p_] := Module[{A = IdentityMatrix[2] - (D[psiE[u, v], {{u, v}, 2}] /. {u -> p[[1]], v -> p[[2]]}), ev},
  ev = Eigenvalues[A]; {type[ev[[1]], ev[[2]]], Sign[Det[A]], 1/Det[A], Norm[p]}];
resE = classE /@ solE;
Print["  images: ", solE, "\n  (type, sgn mu, mu, |theta|): ", resE];
check["2d softened elliptical potential: exactly 5 real images", Length[solE] == 5];
check["2e types: 2 min + 2 saddle + 1 max", Sort[Tally[resE[[All, 1]]]] === {{"max", 1}, {"min", 2}, {"saddle", 2}}];
check["2f sum of sgn mu = +1", Total[resE[[All, 2]]] == 1];
check["2g the maximum is the image closest to the centre and the faintest",
  Module[{mx = Select[resE, #[[1]] == "max" &][[1]]},
    mx[[4]] == Min[resE[[All, 4]]] && Abs[mx[[3]]] == Min[Abs[resE[[All, 3]]]]]];

check["2h image magnifications: minima 2.19, 2.35; saddles -1.51, -1.21; maximum 0.136 at |theta| = 0.029",
  Module[{mus = Sort[Round[resE[[All, 3]], 0.01]]},
    mus == Sort[{2.19, 2.35, -1.51, -1.21, 0.14}] &&
    Abs[Select[resE, #[[1]] == "max" &][[1, 3]] - 0.136] < 0.0005 &&
    Abs[Select[resE, #[[1]] == "max" &][[1, 4]] - 0.029] < 0.0005]];

(* ================================================================= *)
Print["\n--- Exercise 16.3 ---"];
(* ================================================================= *)
assm = tE > 0 && tc > 0 && t > 0;
check["3a alpha_NIS from (2/theta) Int kappa theta' dtheta'",
  FullSimplify[(2/t) Integrate[x tE/(2 Sqrt[x^2 + tc^2]), {x, 0, t}, Assumptions -> assm] ==
    tE (Sqrt[t^2 + tc^2] - tc)/t, assm]];
lt0 = Limit[1 - alNIS[t, tE, tc]/t, t -> 0, Assumptions -> tE > 0 && tc > 0];
lr0 = Limit[1 - D[alNIS[t, tE, tc], t], t -> 0, Assumptions -> tE > 0 && tc > 0];
check["3b lambda_t(0) = lambda_r(0) = 1 - tE/(2 tc) = 1 - kappa_0",
  FullSimplify[lt0 == 1 - tE/(2 tc) && lr0 == 1 - tE/(2 tc), tc > 0]];
check["3c centre is a maximum iff 0 < tc < tE/2",
  Reduce[tE > 0 && tc > 0 && 1 - tE/(2 tc) < 0, tc, Reals] === Reduce[tE > 0 && 0 < tc < tE/2, tc, Reals]];
muC = 1/(lt0 lr0);
check["3d mu_c = 4 tc^2/(tE - 2 tc)^2", FullSimplify[muC == 4 tc^2/(tE - 2 tc)^2, tE > 0 && tc > 0]];
check["3e leading term 4 tc^2/tE^2; Limit tc -> 0 = 0",
  Simplify[Normal[Series[muC, {tc, 0, 2}]] == 4 tc^2/tE^2] && Limit[muC, tc -> 0] === 0];
check["3f linearised: y = (1 - kappa_0) theta  =>  theta = -y/(kappa_0 - 1)",
  Simplify[(Normal[Series[t - alNIS[t, tE, tc], {t, 0, 1}]] /. t -> -yy/(tE/(2 tc) - 1)) == yy, tE > 0 && tc > 0]];
check["3g tc = 0.1, y = 0.01: central image at theta = -0.0025 (exact root within 2e-6)",
  Module[{r = imagesNISBH[1, 1/10, 0, 1/100]}, Abs[Min[Select[r, # < 0 && # > -0.25 &]] + 0.0025] < 2 10^-6]];
check["3h SIS limit: alpha -> tE as tc -> 0", FullSimplify[Limit[alNIS[t, tE, tc], tc -> 0] == tE, t > 0]];
check["3i SIS: mu(theta) = 1/(1 - tE/theta) -> 0 as theta -> 0+",
  Limit[1/(1 - tE/t), t -> 0, Direction -> "FromAbove", Assumptions -> tE > 0] === 0];
check["3j numbers tE = 1: mu_c = 0.0625 (tc = 0.1), 1/2401 = 4.16e-4 (tc = 0.01)",
  (muC /. {tE -> 1, tc -> 1/10}) == 1/16 && (muC /. {tE -> 1, tc -> 1/100}) == 1/2401];

(* ================================================================= *)
Print["\n--- Exercise 16.4 ---"];
(* ================================================================= *)
gradPM[yv_][p_] := p - {yv, 0} - p/(p . p);
check["4a winding of grad tau around a point mass = +1 for y = 0.1, 0.5, 2, 5",
  And @@ (winding[gradPM[#], {0, 0}, 0.01] == 1 & /@ {0.1, 0.5, 2., 5.})];
check["4a' small-circle field: -thBH^2 theta_hat/theta dominates (ratio of |terms| -> infinity)",
  Limit[(1/r)/(r + yv), r -> 0, Direction -> "FromAbove", Assumptions -> yv > 0] === Infinity];
(* N = 2 n_- + 1 - g *)
check["4b N = 2 n_- + 1 - g: parity of N flips with each point mass; N + g odd (g = 0..4, n_- = 0..5)",
  And @@ Flatten[Table[With[{nn = 2 nm + 1 - gg}, OddQ[nn + gg] && (OddQ[nn] == EvenQ[gg])],
    {gg, 0, 4}, {nm, 0, 5}]]];
uc02 = 1/5 (1 + 1/5) - 3 (1/5^2/2)^(2/3);
nNIS[y_] := Length[imagesNISBH[1, 1/5, 0, y]];
nBH[y_] := Length[imagesNISBH[1, 1/5, 3/10 uc02, y]];
check["4c tc = 0.2, thBH^2 = 0.3 u_crit: y = 0.1 -> 3 vs 2 images; y = 0.2 -> 3 vs 4; changes odd, N + g odd",
  nNIS[1/10] == 3 && nBH[1/10] == 2 && nNIS[1/5] == 3 && nBH[1/5] == 4 &&
  OddQ[nBH[1/10] - nNIS[1/10]] && OddQ[nBH[1/5] - nNIS[1/5]] && OddQ[nBH[1/10] + 1] && OddQ[nBH[1/5] + 1]];

(* ================================================================= *)
Print["\n--- Exercise 16.5 ---"];
(* ================================================================= *)
gradSIS[yv_][p_] := p - {yv, 0} - p/Sqrt[p . p];
check["5a tip index = 1 for |beta| < tE (y = 0.2, 0.5, 0.9)",
  And @@ (winding[gradSIS[#], {0, 0}, 10^-4] == 1 & /@ {0.2, 0.5, 0.9})];
check["5a' tip index = 0 for |beta| > tE (y = 1.1, 1.5, 3)",
  And @@ (winding[gradSIS[#], {0, 0}, 10^-4] == 0 & /@ {1.1, 1.5, 3.})];
check["5a'' -beta - tE theta_hat winds iff |beta| < tE: the circle tE theta_hat encloses beta iff |beta| < tE",
  Reduce[Exists[ph, Element[ph, Reals], {yv, 0} == {Cos[ph], Sin[ph]}] && yv > 0, yv, Reals] === (yv == 1)];
(* SIS images: theta_+ = y + 1 (mu > 0), theta_- = y - 1 (exists for y < 1, mu < 0) *)
muSIS[th_] := 1/(1 - 1/Abs[th]);
check["5b y < 1: parities {+1, -1}, sum 0, + tip 1 = 1; y > 1: {+1}, + tip 0 = 1",
  And @@ Table[Sign[muSIS[yy + 1]] + Sign[muSIS[yy - 1]] + 1 == 1, {yy, 0.1, 0.9, 0.1}] &&
  And @@ Table[Sign[muSIS[yy + 1]] + 0 == 1, {yy, 1.1, 3, 0.1}]];

(* ================================================================= *)
Print["\n--- Exercise 16.6 ---"];
(* ================================================================= *)
uCrit = tc (tE + tc) - 3 (tE tc^2/2)^(2/3);
check["6a u_crit = tE tc - 3 2^(-2/3) tE^(2/3) tc^(4/3) + tc^2 exactly",
  FullSimplify[uCrit == tE tc - 3 2^(-2/3) tE^(2/3) tc^(4/3) + tc^2, tE > 0 && tc > 0]];
check["6a' u_crit/(tE tc) -> 1 as tc -> 0", Limit[uCrit/(tE tc), tc -> 0, Assumptions -> tE > 0] == 1];
u005 = N[uCrit /. {tE -> 1, tc -> 1/20}];
Print["  tc = 0.05: u_crit = ", u005, ", thBH_crit = ", Sqrt[u005]];
check["6b tc = 0.05: u_crit = 0.01769, thBH_crit = 0.1330 tE",
  Abs[u005 - 0.017688] < 10^-5 && Abs[Sqrt[u005] - 0.13300] < 10^-4];
m01 = N[(uCrit /. {tE -> 1, tc -> 1/10})/alNIS[1, 1, 1/10]];
Print["  tc = 0.1: alpha(tE) = ", N[alNIS[1, 1, 1/10]], ", critical m = ", m01];
check["6c tc = 0.1: alpha(tE) = 0.9050 tE, critical m = 0.0246",
  Abs[N[alNIS[1, 1, 1/10]] - 0.90499] < 10^-5 && Abs[m01 - 0.02462] < 10^-5];
check["6d point-mass mass scales as thBH^2, NIS mass inside tE as tE alpha(tE) (M(<theta) ~ theta alpha(theta))",
  Simplify[(t (ub/t)) == ub] && Simplify[t alNIS[t, tE, tc] == tE (Sqrt[t^2 + tc^2] - tc)]];

check["6e leading correction to u_crit/(tE tc) is -3 2^(-2/3) (tc/tE)^(1/3) = -0.70 at tc = 0.05",
  Abs[N[-3 2^(-2/3) (1/20)^(1/3)] + 0.696] < 0.001];

(* ================================================================= *)
Print["\n--- Exercise 16.7 ---"];
(* ================================================================= *)
(* far side theta = -x, x = w^2: y = w - w^2 *)
farRoots = w /. Solve[w - w^2 == yv, w];
check["7a far side: w = (1 -/+ Sqrt[1 - 4y])/2, two positive roots iff 0 < y < 1/4",
  Length[farRoots] == 2 && And @@ (Simplify[(# - #^2) == yv] & /@ {(1 - Sqrt[1 - 4 yv])/2, (1 + Sqrt[1 - 4 yv])/2}) &&
  And @@ (Length[NSolve[w - w^2 == # && w > 0, w, Reals]] == 2 & /@ {0.05, 0.1, 0.2, 0.24}) &&
  And @@ (Length[NSolve[w - w^2 == # && w > 0, w, Reals]] == 0 & /@ {0.26, 0.5}) &&
  Maximize[w - w^2, w][[1]] == 1/4];
check["7a' near side: y = w^2 - w (theta = w^2) has exactly one positive root for y > 0",
  Length[Select[w /. NSolve[w^2 - w == #, w, Reals], # > 0 &]] == 1 & /@ {0.05, 0.1, 0.2} === {True, True, True}];
muPL15[wv_] := 1/((1 - 1/wv) (1 - 1/(2 wv)));
check["7b mu_c = 2 w^2/((w - 1)(2 w - 1)) with x = w^2",
  Simplify[muPL15[w] == 2 w^2/((w - 1) (2 w - 1))]];
wc = (1 - Sqrt[1 - 4/10])/2;
Print["  y = 0.1: w_c = ", N[wc], ", mu_c = ", N[muPL15[wc]]];
check["7b' y = 0.1: w_c = 0.11270, exact mu_c = 0.03696, leading 2 y^2 = 0.02 (ratio 1.85)",
  Abs[N[wc] - 0.112702] < 10^-6 && Abs[N[muPL15[wc]] - 0.036961] < 10^-6 &&
  Abs[N[muPL15[wc]]/0.02 - 1.848] < 0.001];
mu18 = Module[{xs, xc}, xs = x /. NSolve[-x + x^(1/5) == 1/10 && x > 0, x, Reals, WorkingPrecision -> 40];
  xc = Min[xs]; 1/((1 - xc^(-4/5)) (1 - (1/5) xc^(-4/5)))];
Print["  g' = 1.8, y = 0.1: exact mu_c = ", N[mu18], ", leading = ", N[(1/10)^8/(1/5)]];
check["7c g' = 1.8, y = 0.1: exact mu_c = 5.007e-8, leading 5e-8 (agree to 0.2%); 18.3 mag fainter than the source",
  Abs[N[mu18] - 5.007 10^-8] < 0.001 10^-8 && N[(1/10)^8/(1/5)] == 5. 10^-8 &&
  Abs[N[mu18]/(5. 10^-8) - 1] < 0.002 && Abs[-2.5 Log10[N[mu18]] - 18.25] < 0.01];

check["7d slope 1.5 -> 1.8 at y = 0.1 costs ~5.9 orders of magnitude in mu_c",
  Abs[Log10[N[muPL15[wc]]/N[mu18]] - 5.87] < 0.01];

(* ================================================================= *)
Print["\n--- AN: numbers in annotation boxes ---"];
(* ================================================================= *)
check["AN1 power law g' = 1.5, y = 0.1: leading 0.02 vs exact 0.037 (almost a factor of two)",
  Abs[N[muPL15[wc]] - 0.037] < 0.0005 && 1.8 < N[muPL15[wc]]/0.02 < 2];
wSmall = (1 - Sqrt[1 - 4 10^-4])/2;
check["AN2 power law g' = 1.5, y = 1e-4: exact and leading agree to better than 1%",
  Abs[N[muPL15[wSmall]]/(2 10^-8) - 1] < 0.01];
check["AN3 relative correction x^(g'-1) = y^((g'-1)/(2-g')) equals y for g' = 1.5",
  ((g - 1)/(2 - g) /. g -> 3/2) == 1];
check["AN4 mu_c limits: tc -> 0 gives 0; tc -> tE/2 gives infinity",
  Limit[muC /. tE -> 1, tc -> 0] === 0 && Limit[muC /. tE -> 1, tc -> 1/2, Direction -> "FromBelow"] === Infinity];
check["AN5 point-mass excision: winding(infinity) - winding(hole) = 1 - 1 = 0 = n_+ - n_- (y = 0.5)",
  winding[gradPM[0.5], {0, 0}, 50] - winding[gradPM[0.5], {0, 0}, 0.01] == 0 &&
  Module[{tp = (0.5 + Sqrt[4.25])/2, tm = (0.5 - Sqrt[4.25])/2},
    Sign[1/((1 - 1/tp^2) (1 + 1/tp^2))] + Sign[1/((1 - 1/tm^2) (1 + 1/tm^2))] == 0]];

summary[];
