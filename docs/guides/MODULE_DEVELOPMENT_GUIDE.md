# Hướng dẫn phát triển Module trong Domain

## 1. Chọn đúng Domain và vị trí repo

| Domain | Mã | Thư mục chính |
|--------|-----|----------------|
| Điều phối | MAIN_CONTROL | `apps-script/main-control/`, `appsheet/main-control/`, `tests/main-control/` |
| Tác vụ | TASK | `apps-script/task/`, … |
| Tài chính | FINANCE | `apps-script/finance/`, … |
| Hồ sơ | HO_SO | `apps-script/ho_so/`, … |

## 2. Checklist phát triển module

1. **Contract dữ liệu**: tên bảng/cột, kiểu, quyền đọc/ghi — ghi vào report hoặc doc domain nếu thay đổi schema.
2. **Phân quyền**: ai được gọi hành động này (role trong AppSheet / webapp).
3. **Idempotency**: thao tác tiền/hồ sơ có thể gọi lại an toàn không?
4. **Logging**: traceId hoặc request id nếu có luồng web/script.
5. **Test**: thêm case vào `tests/<domain>/` và/hoặc kịch bản test console.

## 3. Cài đặt và triển khai

- Template cấu hình: `config/install-templates/`, `config/modules/`.
- Script: `scripts/clasp/`, `scripts/appscript-deploy/`.
- Log sau cài: `00_SYSTEM_BRAIN/004_INSTALL_LOGS/` (append).

## 4. Handoff giữa dev

- Dùng `ai-runtime/templates/HANDOFF_TEMPLATE.md`.
- Ghi rõ file đã đụng, biến môi trường, và lệnh test đã chạy.

## 5. Liên kết

- Chuẩn domain/module: `docs/standards/CBV_DOMAIN_MODULE_STANDARD.md`
