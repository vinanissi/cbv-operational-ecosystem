$ErrorActionPreference = 'Stop'

function Get-NextReportNumber([string]$reportsDir) {
  if (-not (Test-Path -LiteralPath $reportsDir -PathType Container)) { return 1 }
  $existing = Get-ChildItem -LiteralPath $reportsDir -File -Filter "*_LEVEL_2_TESTABLE_RUNTIME_REPORT.md" -ErrorAction SilentlyContinue
  $max = 0
  foreach ($f in $existing) {
    if ($f.Name -match '^(\d{3})_') {
      $n = [int]$Matches[1]
      if ($n -gt $max) { $max = $n }
    }
  }
  return ($max + 1)
}

function Pad3([int]$n) {
  return $n.ToString("000")
}

$inputPath = ".tmp/test-result.json"
if (-not (Test-Path -LiteralPath $inputPath -PathType Leaf)) {
  throw "Missing $inputPath. Run: powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1"
}

$raw = Get-Content -LiteralPath $inputPath -Raw -Encoding UTF8
$json = $raw | ConvertFrom-Json

$reportsDir = "00_SYSTEM_BRAIN/000_REPORTS"
New-Item -ItemType Directory -Force -Path $reportsDir | Out-Null

$n = Get-NextReportNumber $reportsDir
$prefix = Pad3 $n
$reportPath = Join-Path $reportsDir ("{0}_LEVEL_2_TESTABLE_RUNTIME_REPORT.md" -f $prefix)

if (Test-Path -LiteralPath $reportPath) {
  throw "Refusing to overwrite existing report: $reportPath"
}

$checkedAt = $json.checkedAt
$traceId = $json.traceId
$status = $json.status
$severity = $json.severity
$phase = $json.phase
$runBy = $json.runBy
$suite = $json.testSuite

$checksMd = ""
foreach ($c in $json.checks) {
  $ok = [bool]$c.ok
  $marker = $(if ($ok) { "PASS" } else { "FAIL" })
  $checksMd += ("- **{0}**: {1} ({2}) - {3}`n" -f $c.code, $marker, $c.severity, $c.message)
  if ($null -ne $c.detail) {
    $detailJson = ($c.detail | ConvertTo-Json -Depth 10)
    $checksMd += ("  - detail: `{0}`n" -f ($detailJson -replace "\r?\n"," "))
  }
}

$warningsMd = ""
if ($json.warnings.Count -gt 0) {
  foreach ($w in $json.warnings) { $warningsMd += ("- {0}`n" -f $w) }
} else {
  $warningsMd = "- (none)`n"
}

$errorsMd = ""
if ($json.errors.Count -gt 0) {
  foreach ($e in $json.errors) { $errorsMd += ("- {0}`n" -f $e) }
} else {
  $errorsMd = "- (none)`n"
}

$handoff = @"
### AI HANDOFF SUMMARY (required)

- **Current level**: LEVEL 2 - Testable Runtime
- **Last test**: $suite
- **traceId**: $traceId
- **status**: $status
- **severity**: $severity
- **What was verified**:
  - Repo structure and required Level 2 artifacts
  - Append-only report workflow (this file is new; no overwrite)
  - Git visibility (branch + working tree state)
- **Warnings**:
$warningsMd
- **Errors**:
$errorsMd
- **Next recommended phase**:
  - If status is `GO` or `GO_WITH_WARNINGS`: tighten test checks (add more repo invariants) + connect to domain tests later (Level 3)
  - If status is `FAIL`: fix missing items, rerun `scripts/test.ps1`, then regenerate a new report
- **What ChatGPT should design next**:
  - Propose Level 3 scope only after Level 2 report is `GO` (or policy-approved `GO_WITH_WARNINGS`)
  - Define concrete domain smoke suites in `tests/<domain>/` without touching production runtime
"@

$md = @"
# LEVEL 2 - TESTABLE RUNTIME REPORT

**phase:** $phase  
**status:** $status  
**severity:** $severity  
**checkedAt:** $checkedAt  
**runBy:** $runBy  
**traceId:** $traceId  
**testSuite:** $suite  
**contractVersion:** $($json.contractVersion)  

## Summary

$($json.summary)

## Checks

$checksMd
## Warnings

$warningsMd
## Errors

$errorsMd
## Next Step

$($json.nextStep)

## Report JSON (verbatim)

~~~json
$raw
~~~

$handoff
"@

Set-Content -LiteralPath $reportPath -Value $md -Encoding UTF8

Write-Host ("Wrote report: {0}" -f $reportPath)
Write-Host ("traceId={0} status={1}" -f $traceId, $status)

