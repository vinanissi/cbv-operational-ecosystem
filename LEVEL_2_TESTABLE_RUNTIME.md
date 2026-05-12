## LEVEL 2 — Testable Runtime (CBV Operational Ecosystem)

### Mục tiêu Level 2

- Repo có cấu trúc kiểm thử rõ ràng.
- Có script test chạy được.
- Có script report tạo báo cáo.
- Test Runtime tách khỏi Business Runtime.
- Report append-only.
- Có AI handoff summary sau mỗi lần test.
- Có chuẩn để ChatGPT đọc report và thiết kế phase tiếp theo.

### Thành phần đã tạo / chuẩn hóa

- **System Brain (Level 2 additions)**:
  - `00_SYSTEM_BRAIN/000_TEST_CONSOLE/`
  - `00_SYSTEM_BRAIN/000_HANDOFF/`
  - `00_SYSTEM_BRAIN/000_DECISIONS/`
- **Test Runtime Standard**:
  - `00_SYSTEM_BRAIN/000_TEST_CONSOLE/TEST_RUNTIME_STANDARD.md`
- **Report Contract v1**:
  - `00_SYSTEM_BRAIN/000_TEST_CONSOLE/REPORT_CONTRACT_V1.md`
- **Scripts**:
  - `scripts/test.ps1` → xuất `.tmp/test-result.json`
  - `scripts/report.ps1` → tạo report markdown append-only trong `00_SYSTEM_BRAIN/000_REPORTS/`

### Cách vận hành (runbook)

Chạy test (repo-only checks):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1
```

Tạo report append-only:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\report.ps1
```

### Exit criteria để lên Level 3

- Có ít nhất 1 report Level 2 mới nhất với `status` = **GO**.
- Workflow chạy được trên máy dev (không cần CI ở phase này).
- Report tuân contract v1 (`contractVersion: "1.0"`) và có AI HANDOFF SUMMARY.
- Không có hành vi kích hoạt production runtime / production triggers.

