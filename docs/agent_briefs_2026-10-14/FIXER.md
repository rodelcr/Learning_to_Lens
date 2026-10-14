# Fix-pass brief (read COMMON.md first)

You apply the fixes that an independent fact-critic report CONFIRMED for one or more modules of
Learning to Lens. You are working in a git worktree on its own branch; the critic report(s) are in
`Notes/<NN>_*/FACT_CRITIC_*_2026-10-14.md` (and older July/September reports for context).

## Rules (Rodrigo's standing instructions)
1. **Fix only what the critic CONFIRMED (❌ FAIL, or ⚠ SUSPECT with a concrete verified replacement).**
   Items the critic marked "NOT confirmed" or left open are NOT fixed; list them under "Left open".
2. **Every changed number or equation gets a `check[]`** in the module's `.wl` (chapter script and/or
   `Solutions/<NN>_*/problems_<NN>.wl`) that would FAIL on the old value and PASS on the new one. If the
   module's `.wl` printed/encoded the same error (e.g. R_S/c instead of 2R_S/c), fix the script too.
   Run via `bash Mathematica/run_wl.sh`; quote SUMMARY lines.
3. **Correct errors inherited from a source book or note with a footnote naming the source equation;
   never correct silently.** Where the chapter previously said X and now says Y because of a factor or
   convention, keep the equation label and add a short footnote or sentence: "(The factor 2 here
   follows from 4GM/c³ = 2R_S/c.)"
4. **Citations:** only keys in `Notes/references.bib`. If a fix needs a citation that is missing,
   write around it and list it under "Requests for the orchestrator" (UNVERIFIED details).
5. **Annotation layer housekeeping:** where an annotation/derivation box says "flagged for correction"
   or restates a now-fixed visible value, update the box so it agrees with the fixed text (R5 still
   applies). Prose rewrites the critic proposed for annotated-only boxes (LLM tells) may be applied.
6. **Visible-text changes are expected in this pass** (unlike the annotation pass): the student and
   instructor fingerprints WILL change. Run `cd Notes && ANNOT_REQUIRED=1 bash build.sh` and record the
   three fingerprint lines; the build must end "all assertions passed".
7. **Append a `## Resolution — fixes applied 2026-10-14` section** to each critic report you act on,
   with a table `| id | Fix | Backing |` (Backing = the new `.wl` check id, a book page, or a bib key),
   then a "Verification after edits" paragraph (SUMMARY lines before/after, page counts), and a
   "Left open" list. Commit everything on your branch (`git checkout -- Output/` first; never commit
   Output/*.pdf; revert regenerated figure PDFs under Figures/ unless the figure content changed).
8. Touch only the modules assigned to you.

## Report format
Files changed; each fix as "id → what changed → backing check"; SUMMARY lines; build tail; Left open;
Requests for the orchestrator; commit hash.
