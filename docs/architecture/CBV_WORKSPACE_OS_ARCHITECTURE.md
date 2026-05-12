# Kiến trúc CBV Operational Workspace OS

## 1. Định nghĩa

**Workspace OS** là lớp “hệ điều hành” cho môi trường làm việc của team CBV: repo, IDE (Cursor), biến môi trường, quyền Google Cloud / Workspace, và cách **không** làm ô nhiễm production.

## 2. Nguyên tắc

1. **Một repo — một sự thật** cho chuẩn tài liệu (`docs/`).
2. **Phân vùng runtime**: dev / staging / prod rõ ràng trong `config/env/` (chỉ mẫu) và cấu hình IDP nếu có.
3. **Manual-first**: thao tác nguy hiểm phải có checklist; sau đó mới script hóa.
4. **Guided-operation**: script in hướng dẫn và xác nhận bước.
5. **Auto-later**: tự động hóa sau khi ổn định.

## 3. Cursor / AI trong Workspace OS

- Agent đọc `ai-runtime/context/CURSOR_WORKING_RULES.md` và `CURRENT_SYSTEM_CONTEXT.md` trước khi sửa mã.
- Mọi thay đổi lớn để lại dấu vết trong `ai-runtime/reports/` hoặc `00_SYSTEM_BRAIN/000_REPORTS/`.

## 4. An toàn

- Không commit secret.
- Không xóa lịch sử git/report để “làm sạch”.
- Không khai báo xong khi test FAIL.

## 5. Liên kết

- Chuẩn ecosystem V1: `docs/standards/CBV_OPERATIONAL_ECOSYSTEM_STANDARD_V1.md`
- Governance: `docs/governance/CBV_ENGINEERING_GOVERNANCE.md`
