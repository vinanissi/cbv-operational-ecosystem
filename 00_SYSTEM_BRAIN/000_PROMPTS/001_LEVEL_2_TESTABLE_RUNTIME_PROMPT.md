# 001 — LEVEL 2 — Testable Runtime (Prompt)

Bạn là CBV Operational Ecosystem Engineer.

Repo PC:
D:\Workspace\projects\CBV Operational Ecosystem\

GitHub:
https://github.com/vinanissi/cbv-operational-ecosystem

## MỤC TIÊU

Áp dụng LEVEL 2 — Testable Runtime cho repo CBV Operational Ecosystem.

LEVEL 2 nghĩa là:
- Repo có cấu trúc kiểm thử rõ ràng.
- Có script test chạy được.
- Có script report tạo báo cáo.
- Có Test Runtime tách khỏi Business Runtime.
- Có báo cáo append-only.
- Có AI handoff summary sau mỗi lần test.
- Có chuẩn để ChatGPT đọc report và thiết kế phase tiếp theo.

KHÔNG làm automation production ở phase này.
KHÔNG tạo agent tự chạy.
KHÔNG sửa/xóa report cũ.
KHÔNG fake DONE.

## YÊU CẦU BẮT BUỘC TRƯỚC KHI LÀM

1. Đọc toàn bộ repo.
2. Xác định hiện trạng:
   - Có 00_SYSTEM_BRAIN chưa?
   - Có 000_PROMPTS chưa?
   - Có 000_REPORTS chưa?
   - Có scripts/test.ps1 chưa?
   - Có scripts/report.ps1 chưa?
   - Có AI_HANDOFF.md chưa?
   - Có test console/spec/report contract chưa?
3. Lưu prompt này vào:

D:\Workspace\projects\CBV Operational Ecosystem\00_SYSTEM_BRAIN\000_PROMPTS\

Tên file theo số thứ tự tiếp theo:

XXX_LEVEL_2_TESTABLE_RUNTIME_PROMPT.md

Nếu thư mục chưa có thì tạo.

## PHẠM VI TRIỂN KHAI LEVEL 2

Tạo/bổ sung các phần sau nếu chưa có:

### 1. System Brain folders

00_SYSTEM_BRAIN/
  000_PROMPTS/
  000_REPORTS/
  000_HANDOFF/
  000_DECISIONS/
  000_TEST_CONSOLE/

### 2. Test Runtime Standard

Tạo file:

00_SYSTEM_BRAIN/000_TEST_CONSOLE/TEST_RUNTIME_STANDARD.md

Nội dung cần có:
- Test Runtime tách Business Runtime.
- Không test phá dữ liệu thật.
- Không chạy production trigger.
- Report append-only.
- Mỗi lần test phải có traceId.
- Kết quả phải có status: GO / GO_WITH_WARNINGS / FAIL.
- Không phase jump nếu FAIL.
- AI handoff bắt buộc.

### 3. Report Contract

Tạo file:

00_SYSTEM_BRAIN/000_TEST_CONSOLE/REPORT_CONTRACT_V1.md

Report JSON bắt buộc có:

```json
{
  "ok": true/false,
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
  "envelopeOk": true/false
}
```

Check item chuẩn:

```json
{
  "code": "...",
  "ok": true/false,
  "severity": "OK | WARNING | ERROR | CRITICAL",
  "message": "...",
  "detail": {}
}
```

### 4. PowerShell scripts

Tạo/bổ sung:

scripts/test.ps1
scripts/report.ps1

Yêu cầu scripts/test.ps1:
- Chạy kiểm tra cấu trúc repo.
- Kiểm tra các folder bắt buộc.
- Kiểm tra file chuẩn bắt buộc.
- Kiểm tra git status.
- Không sửa dữ liệu runtime thật.
- Xuất kết quả JSON tạm vào:

.tmp/test-result.json

Yêu cầu scripts/report.ps1:
- Đọc .tmp/test-result.json.
- Tạo report markdown append-only vào:

00_SYSTEM_BRAIN/000_REPORTS/

Tên file:

XXX_LEVEL_2_TESTABLE_RUNTIME_REPORT.md

- Không overwrite file cũ.
- Có AI HANDOFF SUMMARY ở cuối file.

### 5. Root docs

Tạo/bổ sung:

README.md
AI_HANDOFF.md
LEVEL_2_TESTABLE_RUNTIME.md

README.md cần ghi:
- Repo là CBV Operational Ecosystem.
- Hiện đang áp dụng Level 2.
- Cách chạy test:

powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\report.ps1

AI_HANDOFF.md cần có:
- Current level
- Current repo status
- Last test result
- Next recommended phase
- Warnings
- What ChatGPT should design next

LEVEL_2_TESTABLE_RUNTIME.md cần có:
- Mục tiêu Level 2
- Thành phần đã tạo
- Cách vận hành
- Exit criteria để lên Level 3

### 6. Git workflow

Sau khi hoàn tất:
- git status
- git add .
- git commit -m "phase: apply level 2 testable runtime"
- git push origin main

Nếu đang không ở main thì:
- báo branch hiện tại
- không tự merge nếu không chắc
- vẫn commit trên branch hiện tại
- ghi rõ trong report

### 7. Không làm các việc sau

- Không tạo production trigger.
- Không tạo auto agent.
- Không xóa file cũ.
- Không sửa dữ liệu nghiệp vụ.
- Không ghi đè report.
- Không tuyên bố production-ready.
- Không chuyển Level 3 nếu chưa có report Level 2 GO.

## OUTPUT CUỐI CÙNG CHO NGƯỜI DÙNG

Trả về đúng cấu trúc:

1. FILES CREATED
2. FILES UPDATED
3. TEST RESULT
4. REPORT FILE
5. CURRENT LEVEL
6. WARNINGS
7. GIT STATUS
8. PUSH RESULT
9. NEXT STEP
10. CHATGPT HANDOFF SUMMARY

