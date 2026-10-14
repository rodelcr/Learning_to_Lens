# Reconciliation brief — Part V chapter vs the spiral project's record (read COMMON.md + CRITIC.md first)

You are an independent reviewer. The chapter you are given was ported from one or two study notes of
`~/Documents/AGEL/202607_Theoretical_spiral_compound/theory/` and already has a fact-critic report in
its `Notes/<NN>_*/` directory. The spiral project has ITS OWN verification record for those notes (see
`docs/spiral_reconciliation_2026-10-14/README.md` and the digest files there). Your job:

1. Read the chapter, its solutions, its FACT_CRITIC report, the digest(s) for its source note(s), and the
   other spiral files listed in the README (TESTS rows, HANDOFF §5–6, earlier critic reports, defect notes).
2. For EVERY FAIL and SUSPECT row in the digest(s) that concerns your note(s), decide and record:
   **inherited** (the chapter carries the same problem — give line numbers and the fix), **already fixed in
   the port** (say where), or **n.a.** (the row concerns stripped project content). Do the same for every
   retraction/correction in the TESTS rows and HANDOFF §5 that touches your note's results.
3. Cross-check the "source-note errors" the chapter's critic claimed against the spiral record: does the
   project already know (retracted, defect note, test row)? Say so explicitly either way.
4. Re-verify numerically anything the spiral record and the chapter disagree on (scratch .wl via
   `bash Mathematica/run_wl.sh`; quote SUMMARY).
5. Append `## Reconciliation with the spiral project's record (2026-10-14)` to the chapter's FACT_CRITIC
   report: a table `| spiral id | claim | status in chapter | action |`, then a short list "New fixes for
   the fix pass" (only items not already in the report's Flagged section) and "Feedback to the spiral
   project" (errors in the notes that the spiral record does not yet know about — be precise: note, line,
   what is wrong, what the chapter says, the check that proves it).
6. Do not edit chapter text. Commit the report on your worktree branch. Final message = the table + the
   two lists.
