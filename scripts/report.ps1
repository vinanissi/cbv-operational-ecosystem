$ErrorActionPreference = 'Stop'

function Pad3([int]$n) {
  return $n.ToString("000")
}

function Get-NextReportNumber([string]$reportsDir) {
  if (-not (Test-Path -LiteralPath $reportsDir -PathType Container)) {
    return 1
  }

  $existing = Get-ChildItem -LiteralPath $reportsDir -File -ErrorAction SilentlyContinue
  $max = 0
  foreach ($f in $existing) {
    if ($f.Name -match '^(\d{3})_') {
      $n = [int]$Matches[1]
      if ($n -gt $max) { $max = $n }
    }
  }
  return ($max + 1)
}

function New-TraceId {
  $rand = -join ((97..122) | Get-Random -Count 6 | ForEach-Object { [char]$_ })
  return (
    "trc_{0}_{1}_{2}" -f
      (Get-Date).ToUniversalTime().ToString('yyyyMMdd'),
      (Get-Date).ToUniversalTime().ToString('HHmmss'),
      $rand
  )
}

function Require-Fields($obj, [string[]]$required) {
  $missing = New-Object 'System.Collections.Generic.List[string]'
  foreach ($k in $required) {
    if ($null -eq $obj.PSObject.Properties[$k]) {
      $missing.Add($k) | Out-Null
    }
  }
  return $missing.ToArray()
}

$requiredFields = @(
  "ok",
  "phase",
  "status",
  "checkedAt",
  "runBy",
  "traceId",
  "testSuite",
  "summary",
  "checks",
  "warnings",
  "errors",
  "nextStep",
  "severity",
  "reportText",
  "reportJson",
  "contractVersion",
  "envelopeOk"
)

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

$reportSuffix = "LEVEL_2_1_NEWLINE_ENCODING_HARDENING_REPORT"

$reportPath = Join-Path $reportsDir ("{0}_{1}.md" -f $prefix, $reportSuffix)

if (Test-Path -LiteralPath $reportPath) {
  throw "Refusing to overwrite existing report: $reportPath"
}

$missing = Require-Fields $json $requiredFields

if ($missing.Count -gt 0) {
  $trace = $null
  if ($null -ne $json.PSObject.Properties["traceId"]) { $trace = $json.traceId }
  if ([string]::IsNullOrWhiteSpace($trace)) { $trace = New-TraceId }

  $failObj = [ordered]@{
    ok = $false
    phase = "LEVEL_2_1_HANDOFF_REPORT_HARDENING"
    status = "FAIL"
    checkedAt = (Get-Date).ToUniversalTime().ToString('o')
    runBy = $env:USERNAME
    traceId = $trace
    testSuite = "report-contract-validate"
    summary = "Report generation blocked: missing required fields in .tmp/test-result.json."
    checks = @(
      [ordered]@{
        code = "REPORT_CONTRACT_VALIDATE_REQUIRED_FIELDS"
        ok = $false
        severity = "ERROR"
        message = "Missing required fields."
        detail = [ordered]@{ missing = @($missing); required = $requiredFields }
      }
    )
    warnings = @()
    errors = @("MISSING_REQUIRED_FIELDS")
    nextStep = "Fix test output to include required fields, rerun scripts/test.ps1, then rerun scripts/report.ps1."
    severity = "ERROR"
    reportText = "FAIL: report.ps1 refused to produce a GO report because required fields were missing."
    reportJson = [ordered]@{ missing = @($missing); required = $requiredFields }
    contractVersion = "1.0"
    envelopeOk = $false
  }

  $raw = ($failObj | ConvertTo-Json -Depth 10)
  $json = $failObj | ConvertFrom-Json
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
    $detailInline = $detailJson.Replace("`r`n", " ").Replace("`n", " ").Replace("`r", " ")
    $checksMd += ("  - detail: `{0}`n" -f $detailInline)
  }
}

$warningsMd = ""
if ($null -ne $json.warnings -and $json.warnings.Count -gt 0) {
  foreach ($w in $json.warnings) { $warningsMd += ("- {0}`n" -f $w) }
} else {
  $warningsMd = "- (none)`n"
}

$errorsMd = ""
if ($null -ne $json.errors -and $json.errors.Count -gt 0) {
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

$lines = New-Object 'System.Collections.Generic.List[string]'

$lines.Add("# $reportSuffix") | Out-Null
$lines.Add("") | Out-Null
$lines.Add(("**phase:** {0}  " -f $phase)) | Out-Null
$lines.Add(("**status:** {0}  " -f $status)) | Out-Null
$lines.Add(("**severity:** {0}  " -f $severity)) | Out-Null
$lines.Add(("**checkedAt:** {0}  " -f $checkedAt)) | Out-Null
$lines.Add(("**runBy:** {0}  " -f $runBy)) | Out-Null
$lines.Add(("**traceId:** {0}  " -f $traceId)) | Out-Null
$lines.Add(("**testSuite:** {0}  " -f $suite)) | Out-Null
$lines.Add(("**contractVersion:** {0}  " -f $json.contractVersion)) | Out-Null
$lines.Add("") | Out-Null

$lines.Add("## Summary") | Out-Null
$lines.Add("") | Out-Null
$lines.Add([string]$json.summary) | Out-Null
$lines.Add("") | Out-Null

$lines.Add("## Checks") | Out-Null
$lines.Add("") | Out-Null
$splitPattern = "`r`n|`n|`r"
foreach ($ln in ($checksMd -split $splitPattern)) { $lines.Add($ln) | Out-Null }
$lines.Add("") | Out-Null

$lines.Add("## Warnings") | Out-Null
$lines.Add("") | Out-Null
foreach ($ln in ($warningsMd -split $splitPattern)) { $lines.Add($ln) | Out-Null }
$lines.Add("") | Out-Null

$lines.Add("## Errors") | Out-Null
$lines.Add("") | Out-Null
foreach ($ln in ($errorsMd -split $splitPattern)) { $lines.Add($ln) | Out-Null }
$lines.Add("") | Out-Null

$lines.Add("## Next Step") | Out-Null
$lines.Add("") | Out-Null
$lines.Add([string]$json.nextStep) | Out-Null
$lines.Add("") | Out-Null

$lines.Add("## Raw JSON (verbatim)") | Out-Null
$lines.Add("") | Out-Null
$lines.Add("~~~json") | Out-Null
foreach ($ln in ($raw -split $splitPattern)) { $lines.Add($ln) | Out-Null }
$lines.Add("~~~") | Out-Null
$lines.Add("") | Out-Null

foreach ($ln in ($handoff -split $splitPattern)) { $lines.Add($ln) | Out-Null }
$lines.Add("") | Out-Null

$encoding = New-Object System.Text.UTF8Encoding($false)
$newline = "`r`n"
[System.IO.File]::WriteAllText($reportPath, ($lines -join $newline), $encoding)

Write-Host ("Wrote report: {0}" -f $reportPath)
Write-Host ("traceId={0} status={1}" -f $traceId, $status)

