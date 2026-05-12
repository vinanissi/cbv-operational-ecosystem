# Policy Append-Only — CBV

## 1. Mục đích

**Append-only** đảm bảo **lịch sử không bị rewrite**: audit, truy vết lỗi, và trách nhiệm pháp lý/nội bộ.

## 2. Phạm vi áp dụng

Áp dụng tối thiểu cho:

- `00_SYSTEM_BRAIN/000_REPORTS/` — mọi report.
- `ai-runtime/reports/` — report phiên AI.
- `00_SYSTEM_BRAIN/004_INSTALL_LOGS/` — log cài đặt.
- `00_SYSTEM_BRAIN/005_ERROR_KNOWLEDGE_BASE/` — bài học lỗi (thêm mục mới, không xóa mục cũ).

Và khuyến nghị cho: handoff, decision (thêm file mới thay vì sửa nội dung cũ để đổi ý nghĩa đã công bố).

## 3. Quy tắc

1. **Không** dùng `git revert` thay cho việc ghi nhận sự thật nếu policy dự án cấm xóa dấu vết — tuân repo thực tế; tối thiểu **không xóa file report đã merge** khỏi main mà không quy trình.
2. Sửa lỗi chính tả trên report **đã phát hành**: tạo file **supplement** hoặc append khối “Errata” có timestamp.
3. Report mới cho mỗi lần chạy test/regression quan trọng.

## 4. Ngoại lệ (cần DECISION)

- Ẩn thông tin nhạy cảm: **không** sửa file cũ; rotate secret và thay thế bằng bản redacted **mới** + decision ghi lý do.

## 5. Liên kết

- Chuẩn test/report: `../standards/CBV_TEST_REPORT_STANDARD.md`
