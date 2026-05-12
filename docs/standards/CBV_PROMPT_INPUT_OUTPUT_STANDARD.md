# Chuẩn Prompt đầu vào / đầu ra — CBV

Quy ước này áp dụng cho mọi phiên làm việc có liên quan AI (Cursor, agent nội bộ, v.v.).

## 1. Vị trí lưu file

### 1.1 Prompt đầu vào (input)

Lưu tại **một trong hai** (ưu tiên thống nhất theo dự án; mặc định phiên ngắn: `ai-runtime/`):

- `ai-runtime/prompts/`
- `00_SYSTEM_BRAIN/000_PROMPTS/` (bản “hệ thống”, audit, prompt mẫu dài hạn)

### 1.2 Đầu ra AI/Cursor (output)

- `ai-runtime/outputs/`

### 1.3 Report

- `ai-runtime/reports/`
- `00_SYSTEM_BRAIN/000_REPORTS/` (bản ghi hệ thống, bootstrap, audit)

**Lưu ý:** Report tuân thủ **append-only** — không ghi đè file report cũ.

### 1.4 Handoff

- `ai-runtime/handoff/`
- `00_SYSTEM_BRAIN/002_HANDOFF/`

### 1.5 Decision

- `ai-runtime/decisions/`
- `00_SYSTEM_BRAIN/001_DECISIONS/`

## 2. Quy ước đặt tên (Naming)

| Loại | Pattern | Ví dụ |
|------|---------|--------|
| Prompt | `PROMPT_[PHASE]_[CONTEXT]_[ACTION].md` | `PROMPT_UAT_FINANCE_ROUNDING_FIX.md` |
| Output | `OUTPUT_[PHASE]_[CONTEXT]_[RESULT].md` | `OUTPUT_DEV_TASK_LISTFILTER_OK.md` |
| Report | `REPORT_[PHASE]_[TYPE].md` | `REPORT_RELEASE_SMOKE.md` |
| Handoff | `HANDOFF_[PHASE]_[CONTEXT].md` | `HANDOFF_SPRINT3_MAIN_CONTROL.md` |
| Decision | `DECISION_[NUMBER]_[CONTEXT].md` | `DECISION_014_USE_CENTRAL_CONFIG.md` |

- `[PHASE]`: mã phase ngắn, không dấu, chữ hoa hoặc SCREAMING_SNAKE_CASE tùy team nhưng **nhất quán trong repo**.
- `[CONTEXT]`: domain/system hoặc ticket id ngắn.
- `[ACTION]` / `[RESULT]` / `[TYPE]`: động từ hoặc kết quả ngắn gọn.

## 3. Nội dung tối thiểu của một Prompt

1. Mục tiêu và phạm vi (in-scope / out-of-scope).
2. Ràng buộc (không xóa lịch sử, không overwrite report…).
3. Tiêu chí xong (definition of done) có liên kết tới test report contract nếu có code.

## 4. Nội dung tối thiểu của Report

Tuân theo `docs/standards/CBV_TEST_REPORT_STANDARD.md` khi report liên quan kiểm thử; report khác (tài liệu, bootstrap) vẫn nên có `traceId`, `checkedAt`, `runBy`, `summary`, `nextStep`.

## 5. Handoff

Phải trả lời: **đang ở đâu**, **đã làm gì**, **chưa làm gì**, **rủi ro**, **lệnh/script** cần chạy tiếp. Dùng template `ai-runtime/templates/HANDOFF_TEMPLATE.md`.
