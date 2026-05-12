# 00_SYSTEM_BRAIN — Não hệ thống CBV

Thư mục này lưu **bản ghi dài hạn** và **audit trail** của hệ sinh thái: prompt hệ thống, report, quyết định, handoff, bộ nhớ runtime, log cài đặt, và cơ sở tri thức lỗi.

## Nguyên tắc

- **Append-only** cho report và log (xem `docs/governance/CBV_APPEND_ONLY_POLICY.md`).
- Không dùng thư mục này làm nơi chứa secret thật.
- Ưu tiên mirror các artifact quan trọng từ `ai-runtime/` sau mỗi milestone lớn.

## Cấu trúc con

| Thư mục | Mô tả |
|---------|--------|
| `000_PROMPTS/` | Prompt mẫu và prompt hệ thống. |
| `000_REPORTS/` | Báo cáo bootstrap, audit, kết quả kiểm chứng quan trọng. |
| `001_DECISIONS/` | Quyết định kiến trúc/sản phẩm. |
| `002_HANDOFF/` | Bàn giao giữa phiên/người. |
| `003_RUNTIME_MEMORY/` | Ghi nhớ vận hành đã được duyệt. |
| `004_INSTALL_LOGS/` | Log triển khai/cài đặt module. |
| `005_ERROR_KNOWLEDGE_BASE/` | Bài học lỗi và cách xử lý. |

Mỗi thư mục con có `README.md` riêng mô tả quy ước chi tiết.
