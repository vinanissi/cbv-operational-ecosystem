# LEVEL 2 - TESTABLE RUNTIME REPORT

**phase:** $phase  
**status:** $status  
**severity:** $severity  
**checkedAt:** $checkedAt  
**runBy:** $runBy  
**traceId:** $traceId  
**testSuite:** $suite  
**contractVersion:** $(@{ok=True; phase=LEVEL_2_TESTABLE_RUNTIME; status=GO_WITH_WARNINGS; checkedAt=2026-05-12T07:54:42.8679720Z; runBy=tchcm; traceId=trc_20260512_075442_bduypo; testSuite=repo-structure-level-2; summary=Level 2 checks passed with warnings.; checks=System.Object[]; warnings=System.Object[]; errors=System.Object[]; nextStep=Review warnings, then run report script: .\\scripts\\report.ps1; severity=WARNING; reportText=CBV Operational Ecosystem â€” Level 2 Testable Runtime (repo-only checks)

- phase: LEVEL_2_TESTABLE_RUNTIME
- status: GO_WITH_WARNINGS
- severity: WARNING
- traceId: trc_20260512_075442_bduypo
- checkedAt: 2026-05-12T07:54:42.8679720Z
- runBy: tchcm

Notes:
- This suite checks repo structure and required artifacts only.
- It does NOT run any business runtime, production triggers, or data mutations.; reportJson=; contractVersion=1.0; envelopeOk=True}.contractVersion)  

## Summary

Level 2 checks passed with warnings.

## Checks

- **LEVEL2_DIRS_PRESENT**: PASS (OK) - Required Level 2 directories present.
  - detail: {     "missing":  [                  ],     "required":  [                      "00_SYSTEM_BRAIN/000_PROMPTS",                      "00_SYSTEM_BRAIN/000_REPORTS",                      "00_SYSTEM_BRAIN/000_HANDOFF",                      "00_SYSTEM_BRAIN/000_DECISIONS",                      "00_SYSTEM_BRAIN/000_TEST_CONSOLE"                  ] }
- **LEVEL2_FILES_PRESENT**: PASS (OK) - Required Level 2 files present.
  - detail: {     "missing":  [                  ],     "required":  [                      "00_SYSTEM_BRAIN/000_TEST_CONSOLE/TEST_RUNTIME_STANDARD.md",                      "00_SYSTEM_BRAIN/000_TEST_CONSOLE/REPORT_CONTRACT_V1.md",                      "scripts/test.ps1",                      "scripts/report.ps1",                      "AI_HANDOFF.md",                      "LEVEL_2_TESTABLE_RUNTIME.md",                      "README.md"                  ] }
- **GIT_AVAILABLE**: PASS (OK) - Git available.
  - detail: {     "branch":  "dev" }
- **GIT_WORKING_TREE_CLEAN**: FAIL (WARNING) - Working tree has uncommitted changes (expected during Level 2 setup before commit).
  - detail: {     "changed":  [                     " M README.md",                     "?? 00_SYSTEM_BRAIN/000_DECISIONS/",                     "?? 00_SYSTEM_BRAIN/000_HANDOFF/",                     "?? 00_SYSTEM_BRAIN/000_PROMPTS/001_LEVEL_2_TESTABLE_RUNTIME_PROMPT.md",                     "?? 00_SYSTEM_BRAIN/000_TEST_CONSOLE/",                     "?? AI_HANDOFF.md",                     "?? LEVEL_2_TESTABLE_RUNTIME.md",                     "?? scripts/report.ps1",                     "?? scripts/test.ps1"                 ] }

## Warnings

- WORKING_TREE_DIRTY

## Errors

- (none)

## Next Step

Review warnings, then run report script: .\\scripts\\report.ps1

## Report JSON (verbatim)

`json
{
    "ok":  true,
    "phase":  "LEVEL_2_TESTABLE_RUNTIME",
    "status":  "GO_WITH_WARNINGS",
    "checkedAt":  "2026-05-12T07:54:42.8679720Z",
    "runBy":  "tchcm",
    "traceId":  "trc_20260512_075442_bduypo",
    "testSuite":  "repo-structure-level-2",
    "summary":  "Level 2 checks passed with warnings.",
    "checks":  [
                   {
                       "code":  "LEVEL2_DIRS_PRESENT",
                       "ok":  true,
                       "severity":  "OK",
                       "message":  "Required Level 2 directories present.",
                       "detail":  {
                                      "missing":  [

                                                  ],
                                      "required":  [
                                                       "00_SYSTEM_BRAIN/000_PROMPTS",
                                                       "00_SYSTEM_BRAIN/000_REPORTS",
                                                       "00_SYSTEM_BRAIN/000_HANDOFF",
                                                       "00_SYSTEM_BRAIN/000_DECISIONS",
                                                       "00_SYSTEM_BRAIN/000_TEST_CONSOLE"
                                                   ]
                                  }
                   },
                   {
                       "code":  "LEVEL2_FILES_PRESENT",
                       "ok":  true,
                       "severity":  "OK",
                       "message":  "Required Level 2 files present.",
                       "detail":  {
                                      "missing":  [

                                                  ],
                                      "required":  [
                                                       "00_SYSTEM_BRAIN/000_TEST_CONSOLE/TEST_RUNTIME_STANDARD.md",
                                                       "00_SYSTEM_BRAIN/000_TEST_CONSOLE/REPORT_CONTRACT_V1.md",
                                                       "scripts/test.ps1",
                                                       "scripts/report.ps1",
                                                       "AI_HANDOFF.md",
                                                       "LEVEL_2_TESTABLE_RUNTIME.md",
                                                       "README.md"
                                                   ]
                                  }
                   },
                   {
                       "code":  "GIT_AVAILABLE",
                       "ok":  true,
                       "severity":  "OK",
                       "message":  "Git available.",
                       "detail":  {
                                      "branch":  "dev"
                                  }
                   },
                   {
                       "code":  "GIT_WORKING_TREE_CLEAN",
                       "ok":  false,
                       "severity":  "WARNING",
                       "message":  "Working tree has uncommitted changes (expected during Level 2 setup before commit).",
                       "detail":  {
                                      "changed":  [
                                                      " M README.md",
                                                      "?? 00_SYSTEM_BRAIN/000_DECISIONS/",
                                                      "?? 00_SYSTEM_BRAIN/000_HANDOFF/",
                                                      "?? 00_SYSTEM_BRAIN/000_PROMPTS/001_LEVEL_2_TESTABLE_RUNTIME_PROMPT.md",
                                                      "?? 00_SYSTEM_BRAIN/000_TEST_CONSOLE/",
                                                      "?? AI_HANDOFF.md",
                                                      "?? LEVEL_2_TESTABLE_RUNTIME.md",
                                                      "?? scripts/report.ps1",
                                                      "?? scripts/test.ps1"
                                                  ]
                                  }
                   }
               ],
    "warnings":  [
                     "WORKING_TREE_DIRTY"
                 ],
    "errors":  [

               ],
    "nextStep":  "Review warnings, then run report script: .\\\\scripts\\\\report.ps1",
    "severity":  "WARNING",
    "reportText":  "CBV Operational Ecosystem â€” Level 2 Testable Runtime (repo-only checks)\n\n- phase: LEVEL_2_TESTABLE_RUNTIME\n- status: GO_WITH_WARNINGS\n- severity: WARNING\n- traceId: trc_20260512_075442_bduypo\n- checkedAt: 2026-05-12T07:54:42.8679720Z\n- runBy: tchcm\n\nNotes:\n- This suite checks repo structure and required artifacts only.\n- It does NOT run any business runtime, production triggers, or data mutations.",
    "reportJson":  {
                       "requiredDirs":  [
                                            "00_SYSTEM_BRAIN/000_PROMPTS",
                                            "00_SYSTEM_BRAIN/000_REPORTS",
                                            "00_SYSTEM_BRAIN/000_HANDOFF",
                                            "00_SYSTEM_BRAIN/000_DECISIONS",
                                            "00_SYSTEM_BRAIN/000_TEST_CONSOLE"
                                        ],
                       "requiredFiles":  [
                                             "00_SYSTEM_BRAIN/000_TEST_CONSOLE/TEST_RUNTIME_STANDARD.md",
                                             "00_SYSTEM_BRAIN/000_TEST_CONSOLE/REPORT_CONTRACT_V1.md",
                                             "scripts/test.ps1",
                                             "scripts/report.ps1",
                                             "AI_HANDOFF.md",
                                             "LEVEL_2_TESTABLE_RUNTIME.md",
                                             "README.md"
                                         ],
                       "branch":  "dev"
                   },
    "contractVersion":  "1.0",
    "envelopeOk":  true
}

`

### AI HANDOFF SUMMARY (required)

- **Current level**: LEVEL 2 - Testable Runtime
- **Last test**: repo-structure-level-2
- **traceId**: trc_20260512_075442_bduypo
- **status**: GO_WITH_WARNINGS
- **severity**: WARNING
- **What was verified**:
  - Repo structure and required Level 2 artifacts
  - Append-only report workflow (this file is new; no overwrite)
  - Git visibility (branch + working tree state)
- **Warnings**:
- WORKING_TREE_DIRTY

- **Errors**:
- (none)

- **Next recommended phase**:
  - If status is GO or GO_WITH_WARNINGS: tighten test checks (add more repo invariants) + connect to domain tests later (Level 3)
  - If status is FAIL: fix missing items, rerun scripts/test.ps1, then regenerate a new report
- **What ChatGPT should design next**:
  - Propose Level 3 scope only after Level 2 report is GO (or policy-approved GO_WITH_WARNINGS)
  - Define concrete domain smoke suites in 	ests/<domain>/ without touching production runtime
