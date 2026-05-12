# 002 — LEVEL 2.1 — Handoff & Report Format Hardening (Prompt)

Bạn là CBV Operational Ecosystem Engineer.

Repo PC:
D:\Workspace\projects\CBV Operational Ecosystem\

GitHub:
https://github.com/vinanissi/cbv-operational-ecosystem

Branch hiện tại kỳ vọng:
dev

## MỤC TIÊU

Thực hiện patch:

**LEVEL 2.1 — Handoff & Report Format Hardening**

Lý do:
Level 2 đã GO tại report:
`00_SYSTEM_BRAIN/000_REPORTS/003_LEVEL_2_TESTABLE_RUNTIME_REPORT.md`

Nhưng cần harden trước khi lên Level 3:
1. `AI_HANDOFF.md` vẫn đang ghi trạng thái cũ GO_WITH_WARNINGS / report 002.
2. Report markdown có nguy cơ format newline chưa đẹp.
3. `report.ps1` chưa tự kiểm tra contract tối thiểu trước khi xuất report.
4. Cần tạo report append-only mới xác nhận Level 2.1.

## NGUYÊN TẮC BẮT BUỘC

- Áp dụng CBV Operational Ecosystem Standard.
- Memory-first.
- Runtime-first.
- Append-only.
- Không xóa/sửa report cũ.
- Không fake DONE.
- Không production automation.
- Không tạo production trigger.
- Không phase jump nếu test/report FAIL.
- Test Runtime tách Business Runtime.
- Report phải append-only.
- AI handoff bắt buộc.

## VIỆC CẦN LÀM

1. Đọc repo hiện tại

Kiểm tra:
- `README.md`
- `AI_HANDOFF.md`
- `LEVEL_2_TESTABLE_RUNTIME.md`
- `scripts/test.ps1`
- `scripts/report.ps1`
- `00_SYSTEM_BRAIN/000_TEST_CONSOLE/REPORT_CONTRACT_V1.md`
- `00_SYSTEM_BRAIN/000_TEST_CONSOLE/TEST_RUNTIME_STANDARD.md`
- `00_SYSTEM_BRAIN/000_REPORTS/003_LEVEL_2_TESTABLE_RUNTIME_REPORT.md`

2. Lưu prompt này

Tạo file mới trong:
`00_SYSTEM_BRAIN/000_PROMPTS/`

Tên file theo số tiếp theo:
`XXX_LEVEL_2_1_HANDOFF_REPORT_HARDENING_PROMPT.md`

Không ghi đè file cũ.

3. Cập nhật `AI_HANDOFF.md`

Cập nhật đúng trạng thái mới:

- Current level: LEVEL 2 — Testable Runtime
- Latest report: `00_SYSTEM_BRAIN/000_REPORTS/003_LEVEL_2_TESTABLE_RUNTIME_REPORT.md`
- Latest status: GO
- Latest severity: OK
- Warnings: none
- Git branch: dev
- Level 2 exit criteria: PASSED
- Next recommended phase: LEVEL 3 — Operational AI Runtime

Không ghi sai rằng production-ready.

4. Harden `scripts/report.ps1`

Yêu cầu:
- Đọc `.tmp/test-result.json`.
- Validate tối thiểu các field bắt buộc:
  - ok
  - phase
  - status
  - checkedAt
  - runBy
  - traceId
  - testSuite
  - summary
  - checks
  - warnings
  - errors
  - nextStep
  - severity
  - contractVersion
  - envelopeOk
- Nếu thiếu field thì tạo report FAIL hoặc dừng có thông báo rõ.
- Không overwrite report cũ.
- Tự tìm số prefix tiếp theo 000–999.
- Xuất markdown có newline chuẩn, dễ đọc.
- Report cuối phải có:
  - Metadata
  - Summary
  - Checks
  - Warnings
  - Errors
  - Next Step
  - Raw JSON
  - AI HANDOFF SUMMARY

5. Harden `scripts/test.ps1` nếu cần

Chỉ chỉnh nếu cần để đảm bảo:
- JSON output có đủ field theo `REPORT_CONTRACT_V1`.
- Có checks dạng chuẩn:
  `{ code, ok, severity, message, detail }`
- Không test dữ liệu business thật.
- Không chạy production trigger.

6. Tạo tài liệu ngắn cho Level 2.1

Tạo file:
`LEVEL_2_1_HANDOFF_REPORT_HARDENING.md`

Nội dung:
- Mục tiêu patch
- Những gì đã harden
- Cách chạy test/report
- Điều kiện để lên Level 3
- Không phải production-ready

7. Chạy test và report

Chạy:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\report.ps1
```

Kỳ vọng:
- Tạo report mới trong `00_SYSTEM_BRAIN/000_REPORTS/`
- Tên dạng `XXX_LEVEL_2_TESTABLE_RUNTIME_REPORT.md` hoặc `XXX_LEVEL_2_1_HANDOFF_REPORT_HARDENING_REPORT.md`
- status = GO hoặc GO_WITH_WARNINGS
- Nếu FAIL thì không được đề xuất Level 3.

8. Git

Sau khi hoàn tất:
- git status
- git add .
- git commit -m "phase: harden level 2 handoff and report runtime"
- git push origin dev

Nếu push lỗi do credential:
- Ghi rõ lỗi.
- Không retry phá cấu trúc.
- Vẫn báo commit local nếu đã commit.

## OUTPUT CUỐI CÙNG

Trả về đúng cấu trúc:

1. FILES CREATED
2. FILES UPDATED
3. TEST RESULT
4. NEW REPORT FILE
5. AI_HANDOFF STATUS
6. WARNINGS
7. GIT STATUS
8. COMMIT HASH
9. PUSH RESULT
10. CAN START LEVEL 3? YES/NO
11. CHATGPT HANDOFF SUMMARY

