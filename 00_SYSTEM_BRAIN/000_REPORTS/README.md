# 000_REPORTS — Báo cáo hệ thống

Lưu **report** loại bootstrap, audit, hoặc kết quả kiểm chứng cần tồn tại lâu dài.

## Quy ước append-only

- **Không** overwrite file report đã tồn tại.
- Mỗi lần kiểm chứng đáng kể: tạo file mới hoặc append khối có timestamp (nếu policy file đơn cho phép).

## Contract

- Report có cấu trúc machine-readable: tuân `docs/standards/CBV_TEST_REPORT_STANDARD.md` khi áp dụng.
