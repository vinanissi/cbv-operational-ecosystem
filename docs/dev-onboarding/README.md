# Dev Onboarding — CBV Operational Ecosystem

Chào mừng bạn đến với repo. Hoàn tất các bước sau trong **ngày đầu tiên**.

## 1. Đọc bắt buộc

1. `docs/guides/CURSOR_README_BEFORE_WORK.md` (áp dụng cho cả dev và AI).
2. `docs/standards/CBV_OPERATIONAL_ECOSYSTEM_STANDARD_V1.md`
3. `docs/standards/CBV_REPO_STRUCTURE_STANDARD.md`

## 2. Thiết lập môi trường

1. Clone repo và cài dependency theo `package.json` (nếu làm việc với phần Node).
2. Sao chép mẫu biến môi trường từ `config/env/` (khi có file `.example`) — **không** commit file secret.
3. Làm quen `scripts/` cho clasp/deploy nếu bạn làm Apps Script.

## 3. Quy trình làm việc

- `docs/guides/AI_WORKFLOW_GUIDE.md` — cách để lại dấu vết prompt/report/handoff.
- `docs/guides/MODULE_DEVELOPMENT_GUIDE.md` — phát triển theo domain.

## 4. Câu hỏi thường gặp

- **Hỏi:** Report sai sau khi merge? **Đáp:** Tạo file supplement append-only, không rewrite lịch sử.
- **Hỏi:** Test không chạy local? **Đáp:** Ghi `TEST_NOT_RUN` trong report và nhờ staging/UAT chạy suite.
