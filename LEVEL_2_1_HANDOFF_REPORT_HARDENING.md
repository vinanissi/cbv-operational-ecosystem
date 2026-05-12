## LEVEL 2.1 — Handoff & Report Format Hardening

### Mục tiêu patch

- “Khóa cứng” (harden) cơ chế **handoff + report** sau khi Level 2 đã đạt **GO**.
- Đảm bảo report xuất ra dễ đọc, newline rõ ràng, và có validate contract tối thiểu trước khi ghi file.
- Không đụng Business Runtime, không tạo production automation/triggers.

### Những gì đã harden

- **AI handoff**:
  - `AI_HANDOFF.md` được cập nhật trỏ đúng report Level 2 **GO/OK** mới nhất (`003_...`).
- **Report runtime**:
  - `scripts/report.ps1` validate các field bắt buộc (theo contract v1 + tối thiểu cho runtime).
  - Tự tìm **prefix** report tiếp theo bằng cách quét max `NNN_` trong `00_SYSTEM_BRAIN/000_REPORTS/`.
  - Không overwrite report cũ (append-only).
  - Markdown xuất theo line-based writer để newline sạch, dễ đọc.

### Cách chạy test/report

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\report.ps1
```

### Điều kiện để lên Level 3

- Có report mới nhất (sau patch) với:
  - `status` = `GO` hoặc `GO_WITH_WARNINGS` (không FAIL)
  - `envelopeOk` = `true`
  - Có **AI HANDOFF SUMMARY**
- Không có production triggers/automation.
- Không có ghi đè report cũ (append-only).

### Không phải production-ready

- Level 2.1 chỉ harden test/report/handoff runtime cho repo; **không** tuyên bố production-ready.

