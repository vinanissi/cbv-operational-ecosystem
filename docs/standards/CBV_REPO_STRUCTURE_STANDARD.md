# Chuẩn cấu trúc repo — CBV Operational Ecosystem

Tài liệu mô tả **vị trí cố định** của từng nhóm tài sản trong repo để Cursor/AI đọc một lần là định vị được mọi thứ.

## 1. Thư mục gốc và vai trò

| Thư mục | Vai trò |
|---------|---------|
| `00_SYSTEM_BRAIN/` | “Não” hệ thống: prompt gốc, report gốc, quyết định, handoff, bộ nhớ runtime, log cài đặt, cơ sở tri thức lỗi. Ưu tiên cho **audit** và **bản ghi nội bộ dài hạn**. |
| `docs/` | Chuẩn, kiến trúc, hướng dẫn, governance, onboarding — **nguồn sự thật** cho con người và AI. |
| `ai-runtime/` | Không gian làm việc **hàng ngày** của AI: prompt/output/report/handoff/memory/decision/context/templates. |
| `apps-script/` | Mã Google Apps Script theo domain: `main-control`, `task`, `finance`, `ho_so`. |
| `webapp/` | Ứng dụng web: admin console, module installer, test console (theo domain/system). |
| `appsheet/` | Đặc tả hoặc export liên quan AppSheet theo domain (cấu trúc bảng, doc, snapshot cấu hình — tuân repo thực tế). |
| `config/` | Biến môi trường, module, template cài đặt, gói kết nối — **không** nhúng secret thật vào git nếu policy cấm. |
| `scripts/` | Script hỗ trợ: clasp, git, triển khai apps script, xuất báo cáo. |
| `tests/` | Kiểm thử theo domain/system; **tách** khỏi mã nghiệp vụ chính khi có thể. |
| `governance/` | Tài liệu hoặc checklist governance bổ sung (nếu khác `docs/governance/` — dùng thống nhất một nơi làm chính theo quyết định dự án). |
| `src/` | Mã nguồn ứng dụng (template hiện có) — giữ nguyên khi đã tồn tại; mở rộng theo module. |

## 2. Quy tắc đặt file

1. **Chuẩn và kiến trúc** chỉ nằm dưới `docs/`.
2. **Bằng chứng làm việc của AI** (report, output, handoff) ưu tiên `ai-runtime/` cho tiện theo dõi theo phiên; bản **lưu trữ hệ thống** có thể mirror vào `00_SYSTEM_BRAIN/`.
3. **Không xóa** thư mục hoặc file lịch sử đã commit; chỉ thêm mới hoặc append có kiểm soát.
4. File môi trường thật (`.env` local) không commit; chỉ mẫu trong `config/env/` hoặc `.example`.

## 3. Đọc trước khi sửa code

Luôn đọc `docs/guides/CURSOR_README_BEFORE_WORK.md` và các file chuẩn được liệt kê trong đó.

## 4. Đồng bộ với Engineering Platform

Cấu trúc thư mục là một phần của **Engineering Platform**: mọi thay đổi cấu trúc gốc cần **DECISION** và cập nhật tài liệu này cùng lúc.
