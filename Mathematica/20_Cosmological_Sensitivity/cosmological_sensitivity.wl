(* =========================================================================
   cosmological_sensitivity.wl
   Module 20: Cosmological Sensitivity of Compound-Lens Ratios
   =========================================================================
   Purpose: Verify every derivation, identity and number of Chapter 20.
            (0) the CPL dark-energy density zeta(z) and its LCDM limit;
            (1) the double-source-plane ratio B as a ratio of comoving
                distances, and its independence of H0;
            (2) the sensitivity Jacobian J = dlnB/d(Om, w0, wa) at an
                ILLUSTRATIVE geometry (z_l, z_s1, z_s2) = (0.5, 1.0, 2.0),
                by finite differences AND by differentiating under the
                integral sign (two independent routes);
            (3) the rank of the single-pair constraint, the blind
                direction c*, the bias ray, the external-probe projection
                Delta w0 = delta/(S_w + c S_Om), the c-interval on which the
                fixed-Om number is a lower bound (it is NOT one in general),
                and the Cramer-Rao statement for statistical errors;
            (4) the N-plane coherence identity m_i = m_1 B_i^((3-g)/(g-1)),
                the convex-combination form of the coherent GLS bias and
                the failure of 1/sqrt(N) averaging for coherent errors;
            (5) the dynamic range of B over a box of cosmologies
                (degeneracy vs bias: off-manifold errors).
            Exports the two chapter figures.

   Sources: Angular-diameter distances: Chapter 7 of these notes
            (Notes/03_Cosmological_Distances, eqs. DA_flat, Dds_flat).
            CPL parametrisation w(a) = w0 + wa (1 - a) (Chevallier &
            Polarski 2001; Linder 2003 -- not in references.bib).
            DSPL ratio: Collett et al. (2012), MNRAS 424, 2864.
            Generalised least squares / Fisher bias: standard linear
            algebra (no specific source claimed).

   Usage:   bash Mathematica/run_wl.sh \
              Mathematica/20_Cosmological_Sensitivity/cosmological_sensitivity.wl

   Outputs: PASS/FAIL per check and a SUMMARY line (harness.wl);
            Figures/20_Cosmological_Sensitivity/cs_B_contours.pdf
            Figures/20_Cosmological_Sensitivity/cs_degeneracy_bias.pdf
   ========================================================================= *)

Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "harness.wl"}]];
Print["=== Module 20: Cosmological Sensitivity of Compound-Lens Ratios ===\n"];

figDir = FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                       "Figures", "20_Cosmological_Sensitivity"}];
If[!DirectoryQ[figDir], CreateDirectory[figDir, CreateIntermediateDirectories -> True]];

near[a_, b_, tol_] := TrueQ[Abs[N[a, 30] - N[b, 30]] <= tol];

(* ===================================================================== *)
Print["--- 0. CPL dark energy ---"];
(* ===================================================================== *)
Clear[z, zp, w0, wa, a, om];
wz[z_, w0_, wa_] := w0 + wa z/(1 + z);
zeta[z_, w0_, wa_] := (1 + z)^(3 (1 + w0 + wa)) Exp[-3 wa z/(1 + z)];

check["0a  w(a)=w0+wa(1-a) with a=1/(1+z) gives w(z)=w0+wa z/(1+z)",
  Simplify[(w0 + wa (1 - a)) /. a -> 1/(1 + z)] - wz[z, w0, wa] // Simplify // # === 0 &];

zetaInt = Exp[3 Integrate[(1 + wz[zp, w0, wa])/(1 + zp), {zp, 0, z},
                          Assumptions -> z > 0]];
check["0b  zeta(z)=exp[3 Int_0^z (1+w)/(1+z') dz'] equals the CPL closed form",
  FullSimplify[zetaInt/zeta[z, w0, wa], Assumptions -> z > 0] === 1];

(* fluid equation in a: d ln rho / d ln a = -3 (1 + w(a)) *)
rhoA = zeta[1/a - 1, w0, wa];
check["0c  fluid equation: d ln zeta / d ln a = -3(1 + w0 + wa(1-a))",
  FullSimplify[a D[Log[rhoA], a] + 3 (1 + w0 + wa (1 - a)), Assumptions -> 0 < a < 1] === 0];

check["0d  LCDM limit: zeta == 1 for w0 = -1, wa = 0",
  Simplify[zeta[z, -1, 0]] === 1];
check["0e  constant-w limit: zeta = (1+z)^(3(1+w0)) for wa = 0 (Ch. 7 rho ~ a^-3(1+w))",
  Simplify[zeta[z, w0, 0] - (1 + z)^(3 (1 + w0))] === 0];

EE[z_, om_, w0_, wa_] := Sqrt[om (1 + z)^3 + (1 - om) zeta[z, w0, wa]];
check["0f  flat normalisation E(0) = 1 for every (Om, w0, wa)",
  Simplify[EE[0, om, w0, wa]] === 1];

(* ===================================================================== *)
Print["\n--- 1. The ratio B ---"];
(* ===================================================================== *)
(* comoving distance in units of the Hubble distance c/H0 *)
chi[z_?NumericQ, om_?NumericQ, w0_?NumericQ, wa_?NumericQ] :=
  NIntegrate[1/EE[x, om, w0, wa], {x, 0, z},
    WorkingPrecision -> 30, PrecisionGoal -> 18, AccuracyGoal -> 25];
(* flat angular-diameter distance between z1 < z2 (Ch. 7, eq. Dds_flat), units c/H0 *)
DA[z1_, z2_, om_, w0_, wa_] := (chi[z2, om, w0, wa] - chi[z1, om, w0, wa])/(1 + z2);
(* B = D_{l s1} D_{s2} / (D_{s1} D_{l s2}) *)
BB[zl_, z1_, z2_, om_, w0_, wa_] :=
  (DA[zl, z1, om, w0, wa] DA[0, z2, om, w0, wa])/
  (DA[0, z1, om, w0, wa] DA[zl, z2, om, w0, wa]);

Clear[cl, c1, c2, zl, z1, z2, DH];
Bsym = (((c1 - cl)/(1 + z1)) (c2/(1 + z2)))/((c1/(1 + z1)) ((c2 - cl)/(1 + z2)));
check["1a  (1+z) factors cancel: B = (1 - chi_l/chi_1)/(1 - chi_l/chi_2)",
  Simplify[Bsym - (1 - cl/c1)/(1 - cl/c2)] === 0];
check["1b  H0-free (symbolic): scaling every chi by D_H = c/H0 leaves B unchanged",
  Simplify[(Bsym /. {cl -> DH cl, c1 -> DH c1, c2 -> DH c2}) - Bsym] === 0];
check["1c  B -> 1 as z_s2 -> z_s1 (chi_2 -> chi_1)",
  Simplify[((1 - cl/c1)/(1 - cl/c2)) /. c2 -> c1] === 1];

(* illustrative geometry: NOT any particular observed system *)
zlI = 1/2; z1I = 1; z2I = 2;
p0 = {3/10, -1, 0};
B0 = BB[zlI, z1I, z2I, Sequence @@ p0];
Print["  B(0.5, 1, 2; LCDM 0.3) = ", N[B0, 12]];
check["1d  0 < B < 1 at the illustrative geometry; B = 0.674156",
  0 < B0 < 1 && near[B0, 0.674156, 5*^-7]];

(* numeric H0 test: dimensional distances in Mpc for two H0 values *)
cKms = 299792458/1000;
BdimH0[H0_] := Module[{dh = cKms/H0},
  ((dh DA[zlI, z1I, Sequence @@ p0]) (dh DA[0, z2I, Sequence @@ p0]))/
  ((dh DA[0, z1I, Sequence @@ p0]) (dh DA[zlI, z2I, Sequence @@ p0]))];
check["1e  H0-free (numeric): B identical for H0 = 67 and 73 km/s/Mpc",
  near[BdimH0[67], BdimH0[73], 1*^-20]];

(* independent LCDM implementation (no CPL code path) *)
chiL[z_?NumericQ, om_?NumericQ] := NIntegrate[1/Sqrt[om (1 + x)^3 + 1 - om], {x, 0, z},
    WorkingPrecision -> 30, PrecisionGoal -> 18];
BL = (1 - chiL[zlI, 3/10]/chiL[z1I, 3/10])/(1 - chiL[zlI, 3/10]/chiL[z2I, 3/10]);
check["1f  CPL code at (w0,wa)=(-1,0) == independent LCDM implementation",
  near[B0, BL, 1*^-15]];

(* ===================================================================== *)
Print["\n--- 2. The sensitivity Jacobian (illustrative geometry) ---"];
(* ===================================================================== *)
lnB[p_List] := Log[BB[zlI, z1I, z2I, Sequence @@ p]];
fdJ[h_] := Table[(lnB[p0 + h UnitVector[3, j]] - lnB[p0 - h UnitVector[3, j]])/(2 h), {j, 3}];
Jfd  = fdJ[1/1000];
Jfd2 = fdJ[1/2000];

(* route 2: differentiate under the integral sign.
   d chi/dp = -1/2 Int E^-3 d(E^2)/dp dz ; then chain rule on
   lnB = ln(chi1 - chil) - ln chi1 + ln chi2 - ln(chi2 - chil). *)
Clear[om, w0, wa, x];
E2[x_, om_, w0_, wa_] := om (1 + x)^3 + (1 - om) zeta[x, w0, wa];
dE2 = Table[D[E2[x, om, w0, wa], v], {v, {om, w0, wa}}];
dchi[zz_, j_] := NIntegrate[
   -1/2 (dE2[[j]] E2[x, om, w0, wa]^(-3/2)) /. Thread[{om, w0, wa} -> p0],
   {x, 0, zz}, WorkingPrecision -> 30, PrecisionGoal -> 18];
{chl, ch1, ch2} = chi[#, Sequence @@ p0] & /@ {zlI, z1I, z2I};
Jan = Table[
   With[{dl = dchi[zlI, j], d1 = dchi[z1I, j], d2 = dchi[z2I, j]},
     (d1 - dl)/(ch1 - chl) - d1/ch1 + d2/ch2 - (d2 - dl)/(ch2 - chl)], {j, 3}];
Print["  J (finite diff.)       = ", N[Jfd, 10]];
Print["  J (under integral)     = ", N[Jan, 10]];
(* central differences carry an O(h^2) truncation error; Richardson-extrapolate *)
Jrich = (4 Jfd2 - Jfd)/3;
check["2a  S_Om: finite difference (Richardson) == derivative under the integral (1e-10)",
  near[Jrich[[1]], Jan[[1]], 1*^-10]];
check["2b  S_w0: finite difference (Richardson) == derivative under the integral (1e-10)",
  near[Jrich[[2]], Jan[[2]], 1*^-10]];
check["2c  S_wa: finite difference (Richardson) == derivative under the integral (1e-10)",
  near[Jrich[[3]], Jan[[3]], 1*^-10]];
check["2d  plain central difference at h = 1e-3 already good to 2e-7 (O(h^2) truncation)",
  Max[Abs[Jfd - Jan]] < 2*^-7 && Max[Abs[Jfd2 - Jan]] < 0.3 Max[Abs[Jfd - Jan]]];
{SOm, Sw, Swa} = Jan;
check["2e  S_Om = -0.03569, S_w0 = -0.03301, S_wa = -0.007255 (all negative)",
  near[SOm, -0.035689, 5*^-6] && near[Sw, -0.033011, 5*^-6] && near[Swa, -0.0072552, 5*^-7]];
check["2f  1/S_w0 = -30.29 (fixed-Om conversion factor at this geometry)",
  near[1/Sw, -30.29, 0.01]];

(* ===================================================================== *)
Print["\n--- 3. One pair: rank, blind direction, projections ---"];
(* ===================================================================== *)
Clear[jo, jw, ja, del, uo, uw, cc, sig, sB, sO];
Jrow = {{jo, jw, ja}};
check["3a  single pair: J^T C^-1 J (3x3) has rank 1; null space is 2-dimensional",
  MatrixRank[Transpose[Jrow] . Jrow] === 1 && Length[NullSpace[Transpose[Jrow] . Jrow]] === 2];
JtJnum = Transpose[{Jan}] . {Jan};
ev = Sort[Abs[Eigenvalues[N[JtJnum, 25]]]];
check["3b  numeric J^T J: one eigenvalue |J|^2, two zero",
  ev[[1]] < 1*^-20 && ev[[2]] < 1*^-20 && near[ev[[3]], Jan . Jan, 1*^-20]];

(* the ray in the (Om, w0) plane *)
J2 = {jo, jw}; u2 = {uo, uw};
dpRay = del/(J2 . u2) u2;
check["3c  the ray Delta p = delta u/(J.u) solves J.Delta p = delta for any u",
  Simplify[J2 . dpRay - del] === 0];
check["3d  n = (S_w, -S_Om) spans the null direction in (Om, w0): J.n = 0",
  Simplify[J2 . {jw, -jo}] === 0];
cStar = SetPrecision[-Sw/SOm, 30];
check["3e  blind direction c* = -S_w/S_Om = -0.9250",
  near[cStar, -0.92496, 5*^-5]];
(* along the blind direction the response is second order *)
ratioBlind[tt_] := Abs[(lnB[p0 + tt {cStar, 1, 0}] - lnB[p0])/(lnB[p0 + tt {0, 1, 0}] - lnB[p0])];
rb1 = ratioBlind[1/100]; rb2 = ratioBlind[1/200];
Print["  blind/axis response ratio at t = 0.01, 0.005: ", N[{rb1, rb2}, 4]];
check["3f  along (c*,1) the response is 2nd order: 3.8% of the w0-axis response at t=0.01, ~ halves with t",
  near[rb1, 0.0378, 0.0005] && near[rb2/rb1, 1/2, 0.05]];

(* an external probe constrains q = Om - c w0 (it is blind along dOm = c dw0);
   minimise chi^2 = (J.dp - del)^2/sB^2 + (e.dp)^2/sO^2 *)
eVec = {1, -cc};
Fm = Outer[Times, J2, J2]/sB^2 + Outer[Times, eVec, eVec]/sO^2;
dpExt = Simplify[Inverse[Fm] . (J2 del/sB^2)];
check["3g  external probe blind along (c,1): Delta w0 = delta/(S_w + c S_Om), any precision",
  Simplify[dpExt - {cc del/(jw + cc jo), del/(jw + cc jo)}] === {0, 0}];
check["3h  c = 0 (Om pinned by a prior centred on the truth): Delta w0 = delta/S_w, Delta Om = 0",
  Simplify[(dpExt /. cc -> 0) - {0, del/jw}] === {0, 0}];

(* when is the fixed-Om number a LOWER bound?  |S_w + c S_Om| <= |S_w| *)
lbRegion = Reduce[Abs[Sw + c SOm] <= Abs[Sw], c, Reals];
testCs = {2 cStar - 1/100, 2 cStar + 1/100, cStar, -1/100, 1/100, 1/2, -1/2};
check["3i  fixed-Om |Delta w0| is a lower bound ONLY for c in [2c*, 0] = [-1.850, 0]",
  (And @@ ((TrueQ[lbRegion /. c -> #] === TrueQ[2 cStar <= # <= 0]) & /@ testCs)) &&
  TrueQ[lbRegion /. c -> 2 cStar] && TrueQ[lbRegion /. c -> 0]];
Print["  region: ", N[lbRegion, 6]];
fac[c_] := Sw/(Sw + c SOm);
check["3j  amplification factor |S_w/(S_w + c S_Om)|: 2.18 at c=-1/2, 0.649 at c=+1/2",
  near[Abs[fac[-1/2]], 2.176, 0.001] && near[Abs[fac[1/2]], 0.6490, 0.0005]];
dl1 = 1/100;
check["3k  delta = 1%: |Delta w0| = 0.303 (fixed Om), 0.659 (c=-1/2), 0.197 (c=+1/2)",
  near[Abs[dl1/Sw], 0.3029, 0.0005] && near[Abs[dl1/(Sw - SOm/2)], 0.6592, 0.0005] &&
  near[Abs[dl1/(Sw + SOm/2)], 0.1966, 0.0005]];
check["3l  |Delta w0| is unbounded as c -> c* (at 0.99 c*: > 50x the fixed-Om value)",
  Abs[dl1/(Sw + 0.99 cStar SOm)] > 50 Abs[dl1/Sw]];

(* GLS bias vector: Delta p = (J^T C^-1 J)^-1 J^T C^-1 delta minimises
   chi^2 = (J dp - delta)^T C^-1 (J dp - delta); generic 3 rows x 2 params, diagonal C *)
Clear[a11, a12, a21, a22, a31, a32, e1, e2, e3, s1, s2, s3, x1, x2];
Jg = {{a11, a12}, {a21, a22}, {a31, a32}}; Ci = DiagonalMatrix[{1/s1, 1/s2, 1/s3}];
dg = {e1, e2, e3};
dpGLS = Inverse[Transpose[Jg] . Ci . Jg] . Transpose[Jg] . Ci . dg;
chi2g = (Jg . {x1, x2} - dg) . Ci . (Jg . {x1, x2} - dg);
check["3n  GLS bias vector is the stationary point of chi^2 (generic 3x2 J, diagonal C)",
  Simplify[(D[chi2g, #] & /@ {x1, x2}) /. Thread[{x1, x2} -> dpGLS]] === {0, 0}];
JgSq = {{a11, a12}, {a21, a22}};
check["3o  square invertible J: GLS reduces to Delta p = J^-1 delta (C drops out)",
  Simplify[Inverse[Transpose[JgSq] . DiagonalMatrix[{1/s1, 1/s2}] . JgSq] . Transpose[JgSq] .
     DiagonalMatrix[{1/s1, 1/s2}] . {e1, e2} - Inverse[JgSq] . {e1, e2}] === {0, 0}];

(* Cramer-Rao: for STATISTICAL errors the fixed-parameter error is a true lower bound *)
FisherP = {{jo^2/sB^2 + 1/sO^2, jo jw/sB^2}, {jo jw/sB^2, jw^2/sB^2}};
check["3m  statistical: marginal sigma(w0)^2 = (F^-1)_ww >= 1/F_ww (fixed-Om error)",
  Simplify[Inverse[FisherP][[2, 2]] - 1/FisherP[[2, 2]],
    Assumptions -> sB > 0 && sO > 0 && jw != 0] === sO^2 jo^2/jw^2];

(* ===================================================================== *)
Print["\n--- 4. Many planes: coherence ---"];
(* ===================================================================== *)
Clear[g, AA, MM, eps, Bi, i];
(* efficiency eps_i = D_{l s_i}/D_{s_i}; power law: thetaE_i^(g-1) = AA eps_i;
   point mass: thetaBH_i^2 = MM eps_i; m_i = thetaBH_i^2/thetaE_i^2;
   B_i = eps_1/eps_i *)
mFrac[e_] := MM e/(AA e)^(2/(g - 1));
check["4a  N-plane identity m_i/m_1 = B_i^((3-g)/(g-1)), B_i = eps_1/eps_i (any i)",
  FullSimplify[mFrac[eps[i]]/mFrac[eps[1]] - (eps[1]/eps[i])^((3 - g)/(g - 1)),
    Assumptions -> eps[i] > 0 && eps[1] > 0 && AA > 0 && MM > 0 && 1 < g < 3] === 0];
check["4b  SIS limit g'=2: m_i = m_1 B_i",
  Simplify[(3 - g)/(g - 1) /. g -> 2] === 1];
check["4c  exponent > 0 for 1<g'<3, so 0 < B_i < 1 => 0 < m_i < m_1 (same sign, monotone)",
  Reduce[ForAll[g, 1 < g < 3, (3 - g)/(g - 1) > 0]] === True];

(* GLS bias for one parameter, equal variances, n ratios:
   Delta = Sum J_i d_i / Sum J_i^2 = Sum w_i b_i, b_i = d_i/J_i, w_i = J_i^2/Sum J^2 *)
Clear[J1, J2s, J3, d1, d2, d3];
Js = {J1, J2s, J3}; ds = {d1, d2, d3};
gls = (Js . ds)/(Js . Js);
wts = Js^2/(Js . Js);
check["4d  coherent GLS bias = weighted mean of per-plane biases b_i = delta_i/J_i",
  Simplify[gls - wts . (ds/Js)] === 0 && Simplify[Total[wts]] === 1];
check["4e  weights are positive => min_i b_i <= Delta <= max_i b_i (no averaging down)",
  Simplify[And @@ Thread[wts > 0], Assumptions -> J1 != 0 && J2s != 0 && J3 != 0 &&
     Element[{J1, J2s, J3}, Reals]]];
Clear[nn, Jc, dc];
check["4f  equal J, coherent delta: bias delta/J for every n; independent rms delta/(J sqrt n)",
  Simplify[(nn Jc dc)/(nn Jc^2) - dc/Jc] === 0 &&
  Simplify[Sqrt[nn Jc^2 dc^2]/(nn Jc^2) - dc/(Jc Sqrt[nn]), Assumptions -> Jc > 0 && dc > 0 && nn > 0] === 0];
check["4g  same-sign J_i: coherent/independent ratio Sum J/|J| lies in [1, sqrt(n)] (n=3)",
  Reduce[ForAll[{J1, J2s, J3}, J1 > 0 && J2s > 0 && J3 > 0,
     (J1 + J2s + J3)^2 >= Js . Js && (J1 + J2s + J3)^2 <= 3 Js . Js], Reals] === True];

(* illustrative three-plane system: sources at z = 1, 2, 3; ratios relative to plane 1 *)
z3I = 3;
lnB13[p_List] := Log[BB[zlI, z1I, z3I, Sequence @@ p]];
J13 = Table[(lnB13[p0 + 1/1000 UnitVector[3, j]] - lnB13[p0 - 1/1000 UnitVector[3, j]])/(2/1000), {j, 3}];
Print["  J row for (0.5;1,3)    = ", N[J13, 10]];
check["4h  three-plane rows share sign pattern (all entries negative)",
  And @@ Thread[Jfd < 0] && And @@ Thread[J13 < 0]];
angDeg = ArcCos[(Jan[[1 ;; 2]] . J13[[1 ;; 2]])/(Norm[Jan[[1 ;; 2]]] Norm[J13[[1 ;; 2]]])] 180/Pi;
Print["  angle between (Om,w0) rows = ", N[angDeg, 6], " deg"];
check["4i  rows nearly parallel: angle between (S_Om,S_w0) rows = 5.5 deg",
  near[angDeg, 5.53, 0.01]];
J22 = {Jan[[1 ;; 2]], J13[[1 ;; 2]]};
svals = SingularValueList[N[J22, 25]];
Print["  condition number (2x2) = ", N[svals[[1]]/svals[[2]], 6]];
check["4j  2x2 (Om,w0) Jacobian of the 3-plane system is ill-conditioned (cond = 22.7)",
  near[svals[[1]]/svals[[2]], 22.71, 0.01]];
check["4l  plane-1/plane-3 row = (-0.0600, -0.0456, -0.0114)",
  near[J13[[1]], -0.0600, 5*^-5] && near[J13[[2]], -0.0456, 5*^-5] && near[J13[[3]], -0.0114, 5*^-5]];
Bthree = {B0, BB[zlI, z1I, z3I, Sequence @@ p0]};
check["4k  illustrative B_2 = 0.6742, B_3 = 0.6095 (both < 1)",
  near[Bthree[[1]], 0.6742, 5*^-5] && near[Bthree[[2]], 0.6095, 5*^-5]];

(* ===================================================================== *)
Print["\n--- 5. Dynamic range of B: bias vs no cosmology at all ---"];
(* ===================================================================== *)
fB[om_?NumericQ, w_?NumericQ] := N[BB[zlI, z1I, z2I, om, w, 0]/B0 - 1, 20];
(* B(w0) at Om = 0.3, wa = 0 is NOT monotonic: interior maximum *)
wMax = Quiet@FindMaximum[fB[3/10, w], {w, -2.2, -2.6, -1.8}, WorkingPrecision -> 20];
Print["  max of B(w0)/B0-1 at Om=0.3: ", N[wMax[[1]], 6], " at w0 = ", N[w /. wMax[[2]], 5]];
check["5a  B(w0) at Om=0.3, wa=0 has an interior maximum: +1.81% at w0 = -2.2",
  near[wMax[[1]], 0.0181, 0.0002] && near[w /. wMax[[2]], -2.2, 0.06]];
(* box Om in [0.2, 0.4], w0 in [-2.5, -0.5], wa = 0 *)
grid = Flatten[Table[{om, w, fB[om, w]}, {om, 0.2, 0.4, 0.05}, {w, -2.5, -0.5, 0.25}], 1];
bmax = Max[grid[[All, 3]]]; bmin = Min[grid[[All, 3]]];
Print["  box excursion: [", N[bmin, 5], ", ", N[bmax, 5], "]"];
check["5b  over Om in [0.2,0.4], w0 in [-2.5,-0.5], wa = 0 (grid): B/B0 - 1 in [-1.7%, +3.3%]",
  near[bmin, -0.0174, 0.0001] && near[bmax, 0.0330, 0.0001]];
check["5c  a 25% error in B lies far outside that range (off the model manifold)",
  0.25 > 5 Max[Abs[bmin], Abs[bmax]]];
check["5d  naive linearisation of a 25% span at this geometry: |0.25/S_w| = 7.57 (meaningless)",
  near[Abs[0.25/Sw], 7.573, 0.005]];

(* ===================================================================== *)
Print["\n--- Figures ---"];
(* ===================================================================== *)
fBm[om_?NumericQ, w_?NumericQ] := Module[{cl0, c10, c20},
  {cl0, c10, c20} = NIntegrate[1/Sqrt[om (1 + x)^3 + (1 - om) (1 + x)^(3 (1 + w))], {x, 0, #}] & /@
     {0.5, 1., 2.};
  100 ((1 - cl0/c10)/(1 - cl0/c20)/N[B0] - 1)];

fig1 = ContourPlot[fBm[om, w], {om, 0.1, 0.5}, {w, -2.0, -0.4},
  Contours -> Range[-3, 2, 0.5], PlotPoints -> 30, MaxRecursion -> 2,
  ContourShading -> None, ContourLabels -> All,
  ContourStyle -> (If[# == 0, Directive[Black, Thick], Directive[GrayLevel[0.45]]] & /@
                   Range[-3, 2, 0.5]),
  Epilog -> {Black, PointSize[0.018], Point[{0.3, -1}]},
  FrameLabel -> {Subscript["\[CapitalOmega]", "m"], Subscript["w", "0"]},
  PlotLabel -> Row[{"100 (", "\[ScriptCapitalB]", "/", Subscript["\[ScriptCapitalB]", "0"],
     " - 1),  ", Subscript["z", "l"], " = 0.5, ", Subscript["z", "s1"], " = 1, ",
     Subscript["z", "s2"], " = 2,  ", Subscript["w", "a"], " = 0"}],
  ImageSize -> 420, BaseStyle -> {FontSize -> 12}];
Export[FileNameJoin[{figDir, "cs_B_contours.pdf"}], fig1];

(* figure 2: blind direction + bias vectors for a +0.5% error in B *)
dFig = 0.005;
SOmN = N[SOm]; SwN = N[Sw]; cS = N[cStar]; pf = {0.3, -1.};
fixedVec = {0, dFig/SwN};
posVec = dFig/(SwN + 0.5 SOmN) {0.5, 1};
negVec = dFig/(SwN - 0.5 SOmN) {-0.5, 1};
(* EXACT (non-linear) solutions of B(pf + t (c,1)) = (1 + dFig) B0 along each ray *)
ray[c_, t_?NumericQ] := fBm[pf[[1]] + c t, pf[[2]] + t];
tFix = t /. FindRoot[ray[0, t] == 100 dFig, {t, -0.15}];
tPos = t /. FindRoot[ray[0.5, t] == 100 dFig, {t, -0.1}];
rayMaxNeg = Quiet@FindMaximum[ray[-0.5, t], {t, -0.12}];
Print["  exact Delta w0: c=0 ", tFix, ", c=+1/2 ", tPos,
      ";  max of 100(B/B0-1) along c=-1/2 ray: ", rayMaxNeg[[1]]];
check["F0b exact solutions: Delta w0 = -0.162 (c=0), -0.091 (c=+1/2) vs linear -0.151, -0.098",
  near[tFix, -0.1616, 0.0005] && near[tPos, -0.0915, 0.0005]];
check["F0c along c=-1/2 B rises by at most 0.09%: a 0.5% error has NO solution on that ray",
  rayMaxNeg[[1]] < 0.1 && rayMaxNeg[[1]] > 0.08];
fig2 = Show[
  ContourPlot[fBm[om, w], {om, 0.1, 0.55}, {w, -1.6, -0.6},
    Contours -> {0, 100 dFig}, ContourShading -> None, PlotPoints -> 30, MaxRecursion -> 2,
    ContourStyle -> {Directive[Black, Thick], Directive[Black, Dashed, Thick]}],
  Graphics[{
    {GrayLevel[0.5], Dotted, Thick, Line[{pf - 0.35 {cS, 1}, pf + 0.45 {cS, 1}}]},
    {Blue, Thick, Arrowheads[0.04], Arrow[{pf, pf + fixedVec}]},
    {Darker[Green], Thick, Arrowheads[0.04], Arrow[{pf, pf + posVec}]},
    {Red, Thick, Arrowheads[0.04], Arrow[{pf, pf + negVec}]},
    {Black, PointSize[0.018], Point[pf]},
    {Blue, Thick, Circle[pf + {0, tFix}, {0.008, 0.018}]},
    {Darker[Green], Thick, Circle[pf + tPos {0.5, 1}, {0.008, 0.018}]},
    Text[Style["c = 0", Blue, 12], pf + fixedVec + {0.045, 0.01}],
    Text[Style["c = +1/2", Darker[Green], 12], pf + posVec + {-0.06, -0.01}],
    Text[Style["c = -1/2 (linear only)", Red, 12], pf + negVec + {-0.02, -0.045}],
    Text[Style[Row[{"blind direction (", Subscript["c", "*"], ", 1)"}], GrayLevel[0.4], 12],
      {0.25, -0.79}]
  }],
  Frame -> True, FrameLabel -> {Subscript["\[CapitalOmega]", "m"], Subscript["w", "0"]},
  PlotRange -> {{0.1, 0.55}, {-1.6, -0.6}}, AspectRatio -> 1,
  PlotLabel -> Row[{"solid: ", "\[ScriptCapitalB]", " = ", Subscript["\[ScriptCapitalB]", "0"],
     ";  dashed: ", "\[ScriptCapitalB]", " = 1.005 ", Subscript["\[ScriptCapitalB]", "0"]}],
  ImageSize -> 420, BaseStyle -> {FontSize -> 12}];
Export[FileNameJoin[{figDir, "cs_degeneracy_bias.pdf"}], fig2];
check["F0  figure-2 vectors: |Delta w0| = 0.151 (c=0), 0.098 (c=+1/2), 0.330 (c=-1/2) at delta=0.5%",
  near[Abs[fixedVec[[2]]], 0.1515, 0.0005] && near[Abs[posVec[[2]]], 0.0983, 0.0005] &&
  near[Abs[negVec[[2]]], 0.3297, 0.0005]];
check["F1  figures exported",
  FileExistsQ[FileNameJoin[{figDir, "cs_B_contours.pdf"}]] &&
  FileExistsQ[FileNameJoin[{figDir, "cs_degeneracy_bias.pdf"}]]];

summary[];
