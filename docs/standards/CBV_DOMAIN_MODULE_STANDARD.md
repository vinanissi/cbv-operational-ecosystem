# Chuẩn Domain và Module — CBV

## 1. Phân cấp

- **System** (ví dụ `MAIN_CONTROL`): điều phối luồng chéo domain, menu, phân quyền cấp cao, trạng thái tổng.
- **Domain**: đơn vị nghiệp vụ lớn, có ranh giới dữ liệu và quy trình rõ: **TASK**, **FINANCE**, **HO_SO**.
- **Module**: đơn vị triển khai nhỏ trong domain — một luồng, một bảng nhóm, một library Apps Script, một bundle webapp.

## 2. Ranh giới (boundary)

1. Domain **không** truy cập trực tiếp bảng “nội bộ” của domain khác nếu không qua contract (API Apps Script, webhook, hoặc bảng trung gian được đặt tên và version).
2. Module trong cùng domain giao tiếp qua **interface nội bộ domain** (hàm chung, namespace, hoặc service layer) để giảm coupling.
3. Mọi thay đổi schema AppSheet/Sheet liên quan domain phải ghi trong report kiểu **schema** hoặc handoff.

## 3. Test console theo domain

- Mỗi **domain lớn** phải có **test console** riêng (webapp hoặc màn AppSheet/App Script debug) để:
  - chạy kiểm tra smoke,
  - xem log/traceId,
  - tái lập lỗi không đụng production business runtime.
- Đường dẫn gợi ý repo: `webapp/test-console/` với submodule hoặc route theo domain; `tests/<domain>/` cho automation.

## 4. Đặt tên và cấu trúc thư mục

| Domain | `apps-script/` | `appsheet/` | `tests/` |
|--------|----------------|-------------|----------|
| Điều phối tổng | `main-control/` | `main-control/` | `main-control/` |
| TASK | `task/` | `task/` | `task/` |
| FINANCE | `finance/` | `finance/` | `finance/` |
| Hồ sơ | `ho_so/` | `ho_so/` | `ho_so/` |

## 5. Phát hành module

- Cấu hình mẫu cài đặt: `config/install-templates/`, `config/modules/`.
- Log cài đặt runtime: `00_SYSTEM_BRAIN/004_INSTALL_LOGS/` (append-only).

## 6. Liên kết

- Kiến trúc tổng: `docs/architecture/CBV_OPERATIONAL_ECOSYSTEM_ARCHITECTURE.md`
- Chuẩn test/report: `docs/standards/CBV_TEST_REPORT_STANDARD.md`
