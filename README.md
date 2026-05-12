# CBV Operational Ecosystem

Repo này là **CBV Operational Ecosystem**: hệ sinh thái vận hành gồm tiêu chuẩn, cấu trúc repo, và các module theo domain (Apps Script / AppSheet / webapp / tests).

## Current level

- **LEVEL 2 — Testable Runtime**

Level 2 tập trung vào **repo-only checks**:

- Có cấu trúc kiểm thử rõ ràng
- Có script test chạy được
- Có script report tạo báo cáo append-only
- Test Runtime tách khỏi Business Runtime
- Có AI handoff summary sau mỗi lần test

## Run Level 2 (PowerShell)

Chạy kiểm tra (xuất `.tmp/test-result.json`):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1
```

Tạo report append-only (xuất vào `00_SYSTEM_BRAIN/000_REPORTS/`):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\report.ps1
```

## Key docs

- `LEVEL_2_TESTABLE_RUNTIME.md`
- `AI_HANDOFF.md`
- `00_SYSTEM_BRAIN/000_TEST_CONSOLE/TEST_RUNTIME_STANDARD.md`
- `00_SYSTEM_BRAIN/000_TEST_CONSOLE/REPORT_CONTRACT_V1.md`
