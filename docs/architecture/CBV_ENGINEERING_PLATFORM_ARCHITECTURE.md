# Kiến trúc CBV Engineering Platform

## 1. Định nghĩa

**Engineering Platform** là tập hợp chuẩn, công cụ và cấu trúc repo giúp:

- onboard nhanh,
- giảm lỗi do hiểu sai bối cảnh,
- có **bằng chứng** (report, test) cho mỗi thay đổi quan trọng.

## 2. Thành phần

| Thành phần | Vị trí | Vai trò |
|-------------|--------|---------|
| Chuẩn tài liệu | `docs/standards/` | Contract cho AI, test, prompt, repo. |
| Kiến trúc | `docs/architecture/` | Bản đồ hệ thống và ranh giới. |
| Hướng dẫn | `docs/guides/` | Quy trình làm việc hằng ngày. |
| Governance | `docs/governance/` | Policy append-only, no-fake-done. |
| Script | `scripts/` | clasp, git helper, deploy, export report. |
| Test theo domain | `tests/` | Tự động hóa theo domain/system. |
| AI runtime | `ai-runtime/` | Artifact phiên AI. |
| System brain | `00_SYSTEM_BRAIN/` | Lưu trữ dài hạn, audit. |

## 3. Vòng đời thay đổi

1. Đọc `CURSOR_README_BEFORE_WORK.md`.
2. Cập nhật `CURRENT_SYSTEM_CONTEXT.md` nếu bối cảnh đổi.
3. Thực hiện thay đổi trong phạm vi module/domain.
4. Chạy test console / suite tương ứng.
5. Xuất **REPORT** theo contract; nếu đổi lớn: **HANDOFF** + **DECISION** (khi cần).

## 4. CI/CD (khi áp dụng)

- Pipeline chỉ promote khi `status` trong report không phải `FAIL`.
- Secret quản lý ngoài repo; `config/env/` chỉ chứa mẫu.

## 5. Liên kết

- Ecosystem tổng thể: `CBV_OPERATIONAL_ECOSYSTEM_ARCHITECTURE.md`
