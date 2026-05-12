# Quy tắc làm việc cho Cursor trong repo CBV

## 1. Trước khi sửa mã

1. Đọc đủ danh sách trong `docs/guides/CURSOR_README_BEFORE_WORK.md`.
2. Đọc file này và `CURRENT_SYSTEM_CONTEXT.md`.
3. Xác định **domain** và **phạm vi file** được phép thay đổi.

## 2. Trong khi sửa mã

- Không xóa file/thư mục lịch sử hoặc report để “dọn dẹp” nếu không có yêu cầu rõ ràng và policy cho phép.
- Không ghi đè nội dung file chuẩn đã tồn tại; nếu cần bổ sung, **append** có mục lục và ngày.
- Không nhúng secret (API key, private key) vào repo hoặc `ai-runtime/`.
- Ưu tiên thay đổi nhỏ, có test hoặc hướng dẫn test thủ công rõ ràng.

## 3. Sau khi sửa mã

- Xuất **report** mới (append-only) khi task thuộc loại bootstrap, release, hoặc migration.
- Nếu còn việc dở: tạo **handoff** theo template.
- Nếu có lựa chọn kiến trúc: tạo **decision** theo template.

## 4. Ngôn ngữ và tài liệu

- Tài liệu chuẩn trong repo này dùng **tiếng Việt** trừ khi team quyết định khác bằng DECISION.

## 5. Git

- Commit message rõ ràng; không force-push lên main/shared branch trừ khi được ủy quyền.
