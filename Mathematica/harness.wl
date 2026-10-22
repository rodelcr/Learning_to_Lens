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

   MCP mode (added 2026-10-14): when the kernel was launched by the Wolfram
   AgentTools MCP server (Claude Code tool "Wolfram", env MCP_SERVER_NAME set),
   output goes through Print[] (WriteString["stdout"] is not captured by the
   MCP evaluator) and summary[] returns <|"pass","fail"|> instead of calling
   Exit[] (which would kill the server's persistent kernel).  Under
   wolframscript nothing changes.
   ========================================================================= *)

$ltlMCP = StringQ[Environment["MCP_SERVER_NAME"]];

ltlOut[s__String] := If[$ltlMCP,
  Print[StringTrim[StringJoin[s], "\n"]],
  WriteString["stdout", s]];

$ltlPass = 0; $ltlFail = 0;

(* WriteString["stdout", ...] instead of Print: under wolframscript, Print output
   interleaved with messages can drop lines (observed 2026-10-14); the tally is
   unaffected either way, but the per-check lines should be reliable. *)
check[name_String, cond_] := Module[{ok = TrueQ[cond]},
  If[ok,
    $ltlPass++; ltlOut["  PASS: ", name, "\n"],
    $ltlFail++; ltlOut["  FAIL: ", name, "\n"]];
  ok];

report = check;

summary[] := (
  ltlOut["========================================\n"];
  ltlOut["SUMMARY: ", ToString[$ltlPass], " PASS, ", ToString[$ltlFail],
        " FAIL  (of ", ToString[$ltlPass + $ltlFail], " checks)\n"];
  ltlOut[If[$ltlFail == 0, "ALL CHECKS PASS", "SOME CHECKS FAILED"], "\n"];
  If[$ltlMCP,
    <|"pass" -> $ltlPass, "fail" -> $ltlFail|>,
    Exit[If[$ltlFail == 0, 0, 1]]]);

(* MCP mode only: zero the tally so a second Get[] of a script starts fresh. *)
resetChecks[] := ($ltlPass = 0; $ltlFail = 0;);
