# Chuẩn AI Runtime — CBV

## 1. Mục đích

**AI Runtime** là không gian lưu trữ và quy ước cho mọi hoạt động của Cursor/AI:

- tách **AI Work** khỏi **business runtime** (dữ liệu thật, trigger production),
- đảm bảo **traceability**: prompt → output → report → handoff,
- hỗ trợ **append-only** cho report và các bản ghi kiểm chứng.

## 2. Hai lớp lưu trữ

| Lớp | Đường dẫn | Khi dùng |
|-----|-----------|----------|
| Làm việc hằng ngày | `ai-runtime/` | Prompt/output/report của phiên hiện tại, template, context ngắn hạn. |
| System Brain | `00_SYSTEM_BRAIN/` | Bản ghi quan trọng dài hạn, prompt mẫu hệ thống, report audit, KB lỗi. |

Có thể **mirror** nội dung quan trọng từ `ai-runtime/` sang `00_SYSTEM_BRAIN/` sau mỗi milestone (kèm handoff).

## 3. Thư mục con `ai-runtime/`

| Thư mục | Nội dung |
|----------|----------|
| `prompts/` | Đầu vào đã chuẩn hóa cho từng phase/context. |
| `outputs/` | Đầu ra thô hoặc bán thành phẩm của AI (không thay thế report chính thức). |
| `reports/` | Báo cáo kết quả làm việc, bootstrap, test — **append-only** theo policy. |
| `handoff/` | Bối cảnh chuyển giao giữa phiên/người. |
| `memories/` | Ghi nhớ ngắn/dài hạn đã được con người duyệt hoặc máy tự tóm tắt có version. |
| `decisions/` | Bản ghi quyết định kỹ thuật/sản phẩm. |
| `context/` | Context hệ thống hiện tại, quy tắc làm việc cho Cursor. |
| `templates/` | Mẫu PROMPT/REPORT/HANDOFF/DECISION. |

## 4. Quy tắc bắt buộc

1. **Không overwrite** file report đã tồn tại; tạo file report mới hoặc append có header thời gian.
2. **Không fake DONE** — trạng thái hoàn thành phải khớp với test report contract (xem `CBV_TEST_REPORT_STANDARD.md`).
3. Mọi file quan trọng nên có **traceId** hoặc liên kết tới report chứa `traceId`.
4. Secret không được lưu trong `ai-runtime/` dưới dạng plaintext; dùng secret manager hoặc biến môi trường local ngoài repo.

## 5. Đồng bộ với Prompt I/O

Đường dẫn và naming: `docs/standards/CBV_PROMPT_INPUT_OUTPUT_STANDARD.md`.
