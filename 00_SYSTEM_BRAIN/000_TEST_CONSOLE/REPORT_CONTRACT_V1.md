## REPORT_CONTRACT_V1 — Level 2 (contractVersion 1.0)

Mục tiêu: định nghĩa **contract JSON** tối thiểu cho mọi lần chạy test/runtime check của CBV Operational Ecosystem.

### 1) Root object (bắt buộc)

Report JSON bắt buộc có cấu trúc (tối thiểu):

```json
{
  "ok": true,
  "phase": "...",
  "status": "GO | GO_WITH_WARNINGS | FAIL",
  "checkedAt": "...",
  "runBy": "...",
  "traceId": "...",
  "testSuite": "...",
  "summary": "...",
  "checks": [],
  "warnings": [],
  "errors": [],
  "nextStep": "...",
  "severity": "OK | WARNING | ERROR | CRITICAL",
  "reportText": "...",
  "reportJson": {},
  "contractVersion": "1.0",
  "envelopeOk": true
}
```

### 2) Ý nghĩa field (tóm tắt)

- **ok**: `true` chỉ khi kết quả tổng thể cho phép đi tiếp (thường là `GO` hoặc `GO_WITH_WARNINGS` theo policy).
- **phase**: tên phase đang chạy (ví dụ `LEVEL_2_TESTABLE_RUNTIME`).
- **status**: `GO` / `GO_WITH_WARNINGS` / `FAIL`.
- **checkedAt**: ISO-8601.
- **runBy**: username/agent/service.
- **traceId**: duy nhất cho run.
- **testSuite**: tên suite.
- **summary**: tóm tắt ngắn.
- **checks**: danh sách check item chuẩn (mục 3).
- **warnings**: danh sách cảnh báo.
- **errors**: danh sách lỗi.
- **nextStep**: bước tiếp theo cụ thể.
- **severity**: mức độ nghiêm trọng tổng thể.
- **reportText**: bản tường thuật cho con người.
- **reportJson**: object embed thêm (tùy chọn), nhưng field phải tồn tại.
- **contractVersion**: `"1.0"` (string).
- **envelopeOk**: `true` nếu đủ field bắt buộc và kiểu dữ liệu hợp lệ.

### 3) Check item chuẩn

Mỗi phần tử trong `checks` phải có tối thiểu:

```json
{
  "code": "...",
  "ok": true,
  "severity": "OK | WARNING | ERROR | CRITICAL",
  "message": "...",
  "detail": {}
}
```

### 4) Quy tắc status/severity (khuyến nghị)

- Nếu có bất kỳ check `severity` là `ERROR` hoặc `CRITICAL` và `ok=false` ⇒ status phải là `FAIL`.
- Nếu không FAIL nhưng có warning ⇒ status nên là `GO_WITH_WARNINGS`.
- Nếu không warning và tất cả check ok ⇒ status `GO`.

### 5) Append-only

- Report markdown xuất ra `00_SYSTEM_BRAIN/000_REPORTS/` phải **không overwrite** file cũ.
- Mỗi lần chạy tạo file mới có số thứ tự tăng dần theo prefix `NNN_`.

### 6) Liên kết

- Chuẩn report tổng quát: `docs/standards/CBV_TEST_REPORT_STANDARD.md`
- Policy append-only: `docs/governance/CBV_APPEND_ONLY_POLICY.md`
