# HANDOFF — Annotated Study Edition + Part V port (2026-10-14, session cut at the 5 h limit)

## TL;DR
- Branch **`annotated-edition`** (off `main` @ d18d3bf). NOT merged to main, NOT published.
- Three editions build with all assertions passing: **student 360 pp / instructor 444 pp / annotated 569 pp**,
  511 annotation boxes, 0 `??`, no duplicate labels. Master verification **28/28** (12 original + 16 new).
- **Part V (chapters 18–25 = module dirs 14–21)** fully written from the spiral project's theory notes
  (pure textbook, project results stripped), each with a chapter `.wl` + `problems_NN.wl`
  (all ALL CHECKS PASS, re-run by the orchestrator), 7–10 exercises with solutions, 1–3 figures.
- **Annotation layer** on all 17 original modules (deep 01d–09, solutions-only 01a–c, 10–13); student and
  instructor fingerprints verified identical to the pre-annotation baseline for every module.
- **Fact-critic pass COMPLETE**: one independent Opus critic per Part V chapter (14–21) and per annotation
  group (01a–c, 01d–e, 02–03, 04–05, 06–07, 08–09, 10–13); all 24 reports merged into `annotated-edition`
  (`Notes/*/FACT_CRITIC_*_2026-10-14.md`). Every Part V derivation survived independent re-derivation
  (critics' scratch scripts: 25–59 checks each, 0 FAIL); FAILs are prose/scope/citation items. The critics
  CONFIRMED ~60 pre-existing visible-text errors in Chapters 1–17 (listed with exact replacement text in
  the tracker and reports). Plumbing fixed on the way: `\annot{}` → `\unskip` (stray space), Ch 15 tags.
- **Fix pass NOT started.** Input list: `NOTES_fixpass_tracker_2026-10-14.md` (every visible-text error the
  agents and critics flagged, by module — several are serious, e.g. Module 6 point-mass delay factor 2,
  Module 4 Ex 4.3(a) numbers, Module 7 Sol 7.3 distances). Brief: `docs/agent_briefs_2026-10-14/FIXER.md`.

## ⚠ Rodrigo's instruction at the cut (2026-10-14, NOT yet applied)
"Be sure not to run the fact critics without reading the materials produced by the other agents in the
theoretical spiral compound dir." The spiral project has a packet-level critic run TODAY by another session:
`~/Documents/AGEL/202607_Theoretical_spiral_compound/theory/FACT_CRITIC_STUDY_PACKET_2026-10-14.md`
(untracked there; 1092 verdicts, 693 PASS / 240 SUSPECT / 159 FAIL, grouped by note), plus
`theory/FACT_CRITIC_study_notes_2026-07-11.md`, `theory/solutions/FACT_CRITIC_SOLUTIONS_2026-07-24.md`,
`TESTS_AND_DIAGNOSTICS.md` rows A2/A4/A9/C11/C11b/H0/H3/D2, `HANDOFF_arc_2026-09-21.md` §5–6,
`NOTES_mcrit_label_defect_2026-08-03.md`, `lit_review/VERIFIED_ANCHORS_2026-07-16.md`,
`Reference_papers/README.md`. The critics launched this session did NOT read these. **Before the fix pass:**
(1) extract from the packet critic the FAIL/SUSPECT rows for notes 1, 1b, 2, 2b, 3, 4, 5, 6, 9, 10;
(2) run a reconciliation pass per Part V chapter: for each spiral verdict, inherited / already fixed in the
port / n.a.; (3) only then fix. A draft "REQUIRED READING" addendum for `CRITIC.md` was written but the
file copy in `docs/agent_briefs_2026-10-14/CRITIC.md` may not contain it — add it.

## State of the tree
- Worktrees: `~/Documents/Learning_to_Lens_wt/<name>` (15), branches `wt/<name>`; `Reference_Texts` symlinked.
  All synced to the merged branch at 8427187 or later. Remove with `git worktree remove` after merging.
- `Output/build_fingerprints_phase0.txt` = stubs-only baseline (262/317/317); current fingerprints in
  `Output/build_fingerprints.txt`. Annotation-only commits must keep student/instructor lines unchanged.
- Mathematica: `Mathematica/harness.wl` (check/report/summary), `Mathematica/run_wl.sh` (3-kernel semaphore).
- Bib: +11 CrossRef-verified keys (Part V + CPL), all tagged `learning_to_lens` in Zotero.
- Docs updated: CLAUDE.md (three editions, 28/28), DEPLOYMENT.md, VERIFICATION.md (Level 0 + Level 3 rows).
  Still to do: VERIFICATION.md Level-1 rows for the 8 new chapters, README, PROGRESS_LOG entry.

## Findings to feed back to the spiral project (verified here; not yet written there)
- Reference manifest: "Schneider 2014 A&A 568 A106 (1409.0015)" conflates Schneider 2014 A&A 568 **L2**
  (10.1051/0004-6361/201424450) with Schneider 2019 A&A 624 **A54** (arXiv 1409.0015). Its
  `Schneider2014_multiplane_MST.pdf` is the 2019 paper; `SchneiderSluse2013_SPT.pdf` is the 2014 SPT paper.
  (The packet critic found the same — row S8-001.)
- Burke 1981 DOI is 10.1086/183466 (183472 is Storey et al.).
- note 2: SIS+PM "faint central counter-image" root is on the wrong branch (exactly two images).
- note 2b §3: t₁→2 at fixed θ_B collapses the whole lens; joint limit θ_B→0 is the right one (cf. C11b).
- note 4: with one point mass the image count is EVEN; τ→+∞ at a point mass; Ex 4 parity statement wrong.
- sol_note3: annihilation boundary HAS a closed form: θ* = [(2−γ')(3−γ')/2]^(1/(γ'−1)),
  m_crit = ½(2−γ')(γ'−1)θ*^(3−γ') (verified to 1e−30). Reconcile with A4 / NOTES_mcrit_label_defect.
- note 9 / brief: "fixed-Ω_m |Δw| is a lower bound" false in general (Ch 20 critic confirmed the corrected
  statement: holds only for c ∈ [2c*, 0]).
- note 10: "B_i → 0 = source infinitely far" wrong (B_i > d₁); source-plane vs image-plane c differ (10.46 vs
  2.08) — Ch 21 critic: the leverage story holds only for unit-weight (source-plane) fits.
- `Learning_to_Autolens/Mathematica/14_multi_plane.wl` has no computation and wrong formulas.
- ROADMAP item "theory notes ported into Learning to Lens" → done here (Part V); CLAUDE.md learning thread
  should point at Ch 18–25. Not yet edited in the spiral repo.

## Next steps, in order
1. Merge remaining `wt/*` critic reports; `cd Notes && ANNOT_REQUIRED=1 bash build.sh`.
2. Reconciliation with the spiral packet critic (see ⚠ above).
3. Fix pass (FIXER.md brief; one agent per module group; every fix → `.wl` check + Resolution table).
4. VERIFICATION.md Level-1 rows, README, PROGRESS_LOG, HANDOFF update; synergy review of Part V notation
   (Ch 19 uses f_• because `\mBH` = m clashes with the multipole order).
5. Spiral repo: stamp ROADMAP/CLAUDE.md + write the feedback note above.
6. Rodrigo's call: merge to main, publish (DEPLOYMENT.md, third PDF).
