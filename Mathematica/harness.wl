(* =========================================================================
   harness.wl
   Shared PASS/FAIL harness for every Learning to Lens verification script
   =========================================================================
   Purpose: One definition of check[] / summary[] so that every per-module
            .wl and every Solutions/NN/problems_NN.wl reports in the same
            format and exits with a meaningful status code for sweep runners.

   Load (from Mathematica/NN_Module/x.wl):
     Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "harness.wl"}]]
   Load (from Solutions/NN_Module/problems_NN.wl):
     Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "..",
                       "Mathematica", "harness.wl"}]]

   API:
     check[name, cond]  prints "  PASS: name" or "  FAIL: name", tallies,
                        and returns TrueQ[cond].
     report[name, cond] alias of check[] (ported scripts from the
                        202607_Theoretical_spiral_compound project use it).
     summary[]          prints "SUMMARY: p PASS, f FAIL  (of n checks)" and
                        exits with code 0 if f == 0, else 1.  ALWAYS quote
                        the SUMMARY line verbatim in reports; never transcribe
                        a count from prose.

   Usage:   not run directly; Get[] it from a script.
   ========================================================================= *)

$ltlPass = 0; $ltlFail = 0;

check[name_String, cond_] := Module[{ok = TrueQ[cond]},
  If[ok,
    $ltlPass++; Print["  PASS: ", name],
    $ltlFail++; Print["  FAIL: ", name]];
  ok];

report = check;

summary[] := (
  Print["========================================"];
  Print["SUMMARY: ", $ltlPass, " PASS, ", $ltlFail, " FAIL  (of ",
        $ltlPass + $ltlFail, " checks)"];
  Print[If[$ltlFail == 0, "ALL CHECKS PASS", "SOME CHECKS FAILED"]];
  Exit[If[$ltlFail == 0, 0, 1]]);
