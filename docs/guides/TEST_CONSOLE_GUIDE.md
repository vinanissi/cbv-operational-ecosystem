# Hướng dẫn Test Console theo Domain

## 1. Mục đích

**Test console** là giao diện hoặc bộ lệnh cho phép team:

- chạy smoke test theo domain,
- xem kết quả và log mà **không** đụng trực tiếp luồng business production,

tuân thủ nguyên tắc **test runtime tách khỏi business runtime**.

## 2. Vị trí trong repo

- Mã webapp test: `webapp/test-console/` (chia route hoặc package theo domain nếu cần).
- Dữ liệu fixture / kịch bản: `tests/<domain>/` và có thể thư mục `config/` cho mẫu.

## 3. Thiết kế tối thiểu

1. **Chọn môi trường**: dev/staging — mặc định không prod.
2. **Chạy suite**: nút hoặc API nội bộ gọi tới Apps Script/web backend test-only.
3. **Hiển thị report**: render theo contract `CBV_TEST_REPORT_STANDARD.md` (ít nhất `status`, `summary`, `errors`, `traceId`).
4. **Export**: cho phép tải `reportJson` / `reportText` để đính vào `ai-runtime/reports/`.

## 4. Quy tắc

- Không dùng test console để “sửa tay” số liệu production.
- Mọi lần chạy full regression nên có `traceId` duy nhất.
- Nếu `FAIL`, ghi `nextStep` và tạo handoff nếu cần người khác xử lý.

## 5. Liên kết

- Chuẩn test/report: `docs/standards/CBV_TEST_REPORT_STANDARD.md`
