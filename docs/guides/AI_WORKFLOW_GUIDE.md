# Hướng dẫn quy trình làm việc với AI (Cursor)

## 1. Trước khi bắt đầu

1. Mở và đọc `docs/guides/CURSOR_README_BEFORE_WORK.md`.
2. Đọc `ai-runtime/context/CURRENT_SYSTEM_CONTEXT.md` để biết phase, domain đang active, và blocker hiện tại.
3. Nếu task kéo dài nhiều phiên: đọc `HANDOFF` mới nhất trong `ai-runtime/handoff/` hoặc `00_SYSTEM_BRAIN/002_HANDOFF/`.

## 2. Trong phiên làm việc

1. **Prompt**: lưu bản prompt đã chuẩn hóa vào `ai-runtime/prompts/` (hoặc `00_SYSTEM_BRAIN/000_PROMPTS/` nếu là mẫu hệ thống) theo naming trong `CBV_PROMPT_INPUT_OUTPUT_STANDARD.md`.
2. **Output**: ghi nhận kết quả trung gian vào `ai-runtime/outputs/` khi cần tái lập hoặc review.
3. **Code**: chỉ sửa phạm vi đã thống nhất; không refactor lan man.
4. **Test**: chạy suite hoặc test console domain tương ứng; **không** dùng dữ liệu production làm chứng cứ duy nhất.

## 3. Kết thúc phiên

1. **Report**: tạo file mới trong `ai-runtime/reports/` hoặc `00_SYSTEM_BRAIN/000_REPORTS/` — **append-only**, không overwrite.
2. Nếu còn việc dở: **Handoff** theo template.
3. Nếu có quyết định kiến trúc/sản phẩm: **Decision** theo template.

## 4. Khi test FAIL

- Cập nhật report với `status: FAIL`, `errors`, `nextStep` cụ thể.
- Không đánh dấu hoàn thành task; không merge/promote nếu policy cấm.

## 5. Liên kết

- Chuẩn AI runtime: `docs/standards/CBV_AI_RUNTIME_STANDARD.md`
- Chuẩn test/report: `docs/standards/CBV_TEST_REPORT_STANDARD.md`
