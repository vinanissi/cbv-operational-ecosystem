$ErrorActionPreference = 'Stop'

function New-TraceId {
  $rand = -join ((97..122) | Get-Random -Count 6 | ForEach-Object { [char]$_ })
  return ("trc_{0}_{1}_{2}" -f (Get-Date).ToUniversalTime().ToString('yyyyMMdd'), (Get-Date).ToUniversalTime().ToString('HHmmss'), $rand)
}

function To-IsoUtcNow {
  return (Get-Date).ToUniversalTime().ToString('o')
}

function Add-Check([System.Collections.Generic.List[object]]$checks, [string]$code, [bool]$ok, [string]$severity, [string]$message, $detail) {
  $checks.Add([ordered]@{
    code = $code
    ok = $ok
    severity = $severity
    message = $message
    detail = $detail
  }) | Out-Null
}

$traceId = New-TraceId
$checkedAt = To-IsoUtcNow
$runBy = $env:USERNAME
if ([string]::IsNullOrWhiteSpace($runBy)) { $runBy = 'unknown' }

$checks = New-Object 'System.Collections.Generic.List[object]'
$warnings = New-Object 'System.Collections.Generic.List[string]'
$errors = New-Object 'System.Collections.Generic.List[string]'

New-Item -ItemType Directory -Force -Path ".tmp" | Out-Null

# ---- Required directories/files for Level 2 ----
$requiredDirs = @(
  "00_SYSTEM_BRAIN/000_PROMPTS",
  "00_SYSTEM_BRAIN/000_REPORTS",
  "00_SYSTEM_BRAIN/000_HANDOFF",
  "00_SYSTEM_BRAIN/000_DECISIONS",
  "00_SYSTEM_BRAIN/000_TEST_CONSOLE"
)

$requiredFiles = @(
  "00_SYSTEM_BRAIN/000_TEST_CONSOLE/TEST_RUNTIME_STANDARD.md",
  "00_SYSTEM_BRAIN/000_TEST_CONSOLE/REPORT_CONTRACT_V1.md",
  "scripts/test.ps1",
  "scripts/report.ps1",
  "AI_HANDOFF.md",
  "LEVEL_2_TESTABLE_RUNTIME.md",
  "README.md"
)

$missingDirs = @()
foreach ($d in $requiredDirs) {
  if (-not (Test-Path -LiteralPath $d -PathType Container)) { $missingDirs += $d }
}
Add-Check $checks "LEVEL2_DIRS_PRESENT" ($missingDirs.Count -eq 0) ($(if ($missingDirs.Count -eq 0) { "OK" } else { "ERROR" })) "Required Level 2 directories present." ([ordered]@{ missing = $missingDirs; required = $requiredDirs })

$missingFiles = @()
foreach ($f in $requiredFiles) {
  if (-not (Test-Path -LiteralPath $f -PathType Leaf)) { $missingFiles += $f }
}
Add-Check $checks "LEVEL2_FILES_PRESENT" ($missingFiles.Count -eq 0) ($(if ($missingFiles.Count -eq 0) { "OK" } else { "ERROR" })) "Required Level 2 files present." ([ordered]@{ missing = $missingFiles; required = $requiredFiles })

# ---- Git status (must not modify repo) ----
$gitOk = $true
$branch = $null
$porcelain = $null
try {
  $branch = (git branch --show-current) 2>$null
  $porcelain = (git status --porcelain=v1) 2>$null
} catch {
  $gitOk = $false
}

if (-not $gitOk) {
  Add-Check $checks "GIT_AVAILABLE" $false "ERROR" "Git commands failed. Ensure git is installed and this is a git repo." ([ordered]@{})
  $errors.Add("GIT_UNAVAILABLE") | Out-Null
} else {
  Add-Check $checks "GIT_AVAILABLE" $true "OK" "Git available." ([ordered]@{ branch = $branch })
  $dirty = $false
  $lines = @()
  if ($null -ne $porcelain) {
    $lines = @($porcelain) | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    $dirty = ($lines.Count -gt 0)
  }
  if ($dirty) {
    $warnings.Add("WORKING_TREE_DIRTY") | Out-Null
    Add-Check $checks "GIT_WORKING_TREE_CLEAN" $false "WARNING" "Working tree has uncommitted changes (expected during Level 2 setup before commit)." ([ordered]@{ changed = $lines })
  } else {
    Add-Check $checks "GIT_WORKING_TREE_CLEAN" $true "OK" "Working tree clean." ([ordered]@{})
  }
}

# ---- Determine overall status/severity ----
$hasFail = $false
$overallSeverity = "OK"

foreach ($c in $checks) {
  if (-not $c.ok -and ($c.severity -eq "ERROR" -or $c.severity -eq "CRITICAL")) { $hasFail = $true }
  if ($c.severity -eq "CRITICAL") { $overallSeverity = "CRITICAL" }
  elseif ($overallSeverity -ne "CRITICAL" -and $c.severity -eq "ERROR") { $overallSeverity = "ERROR" }
  elseif ($overallSeverity -notin @("CRITICAL","ERROR") -and $c.severity -eq "WARNING") { $overallSeverity = "WARNING" }
}

if ($missingDirs.Count -gt 0 -or $missingFiles.Count -gt 0) {
  $hasFail = $true
  if ($overallSeverity -eq "OK" -or $overallSeverity -eq "WARNING") { $overallSeverity = "ERROR" }
  $errors.Add("LEVEL2_STRUCTURE_MISSING") | Out-Null
}

$status = "GO"
if ($hasFail) { $status = "FAIL" }
elseif ($warnings.Count -gt 0) { $status = "GO_WITH_WARNINGS" }

$ok = ($status -ne "FAIL")

$summary = switch ($status) {
  "GO" { "Level 2 structure checks passed." }
  "GO_WITH_WARNINGS" { "Level 2 checks passed with warnings." }
  default { "Level 2 checks failed; fix errors and rerun." }
}

$nextStep = switch ($status) {
  "GO" { "Run report script to generate append-only report: .\\scripts\\report.ps1" }
  "GO_WITH_WARNINGS" { "Review warnings, then run report script: .\\scripts\\report.ps1" }
  default { "Fix missing directories/files or git issues, then rerun: .\\scripts\\test.ps1" }
}

$reportText = @"
CBV Operational Ecosystem - Level 2 Testable Runtime (repo-only checks)

- phase: LEVEL_2_TESTABLE_RUNTIME
- status: $status
- severity: $overallSeverity
- traceId: $traceId
- checkedAt: $checkedAt
- runBy: $runBy

Notes:
- This suite checks repo structure and required artifacts only.
- It does NOT run any business runtime, production triggers, or data mutations.
"@

$result = [ordered]@{
  ok = $ok
  phase = "LEVEL_2_TESTABLE_RUNTIME"
  status = $status
  checkedAt = $checkedAt
  runBy = $runBy
  traceId = $traceId
  testSuite = "repo-structure-level-2"
  summary = $summary
  checks = $checks.ToArray()
  warnings = $warnings.ToArray()
  errors = $errors.ToArray()
  nextStep = $nextStep
  severity = $overallSeverity
  reportText = $reportText
  reportJson = [ordered]@{
    requiredDirs = $requiredDirs
    requiredFiles = $requiredFiles
    branch = $branch
  }
  contractVersion = "1.0"
  envelopeOk = $true
}

$outPath = ".tmp/test-result.json"
$result | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $outPath -Encoding UTF8

Write-Host ("Wrote {0}" -f $outPath)
Write-Host ("traceId={0} status={1}" -f $traceId, $status)

