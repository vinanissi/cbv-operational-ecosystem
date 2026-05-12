## TEST_RUNTIME_STANDARD — Level 2 (Testable Runtime)

Mục tiêu: chuẩn hóa **Test Runtime** để kiểm chứng repo và hệ sinh thái CBV theo nguyên tắc **testable, traceable, append-only**.

### 1) Tách Test Runtime khỏi Business Runtime

- **Test Runtime**: mọi thứ phục vụ kiểm thử/kiểm chứng (script test, console test, fixture, report, contract).
- **Business Runtime**: runtime nghiệp vụ thật (Apps Script/AppSheet/webapp/backend) — **không** được kích hoạt bởi Level 2.
- Level 2 chỉ tạo “khung” để chạy kiểm tra repo + xuất report; **không** tạo automation production.

### 2) Nguyên tắc an toàn

- **Không test phá dữ liệu thật**: không ghi/xóa/sửa dữ liệu production.
- **Không chạy production trigger**: không gọi deploy, không chạy job/cron/trigger thật.
- Nếu cần test có side-effect trong tương lai: phải có **fixture** và môi trường test riêng, kèm decision.

### 3) Report append-only

- Report xuất vào `00_SYSTEM_BRAIN/000_REPORTS/` là **append-only**:
  - Không sửa/xóa report cũ.
  - Mỗi lần chạy tạo **file report mới**.
- Nếu phát hiện sai chính tả/thiếu thông tin trong report cũ: tạo report mới hoặc bổ sung “Errata” trong report mới (không rewrite lịch sử).

### 4) Traceability

- Mỗi lần test/run phải có **traceId** duy nhất (khuyến nghị format: `trc_yyyyMMdd_HHmmss_<rand>`).
- Mọi artifact liên quan (JSON result, markdown report, handoff) phải tham chiếu traceId.

### 5) Kết quả bắt buộc và trạng thái

- Kết quả chạy test phải có **status**:
  - `GO`
  - `GO_WITH_WARNINGS`
  - `FAIL`
- **Không phase jump nếu FAIL**: nếu `FAIL` thì chỉ được thiết kế “nextStep” để sửa và chạy lại.
- Report phải tuân theo contract: xem `REPORT_CONTRACT_V1.md`.

### 6) AI handoff bắt buộc

- Mỗi lần tạo report markdown phải có phần **AI HANDOFF SUMMARY** ở cuối file.
- Handoff phải đủ thông tin để ChatGPT đọc report và đề xuất phase tiếp theo **không cần hỏi lại**.

### 7) Phạm vi Level 2 (repo-only)

- Level 2 cho repo này tập trung vào:
  - kiểm tra cấu trúc repo,
  - kiểm tra sự tồn tại của chuẩn/folder/file,
  - kiểm tra git status,
  - xuất JSON + markdown report theo contract.
- Không tuyên bố production-ready ở Level 2.

### 8) Liên kết chuẩn hiện có trong repo

- Chuẩn report tổng quát: `docs/standards/CBV_TEST_REPORT_STANDARD.md`
- Policy append-only: `docs/governance/CBV_APPEND_ONLY_POLICY.md`
