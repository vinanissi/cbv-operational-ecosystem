# Chuẩn CBV Operational Ecosystem — Phiên bản 1

Tài liệu này là **chuẩn gốc** cho toàn bộ hệ sinh thái vận hành CBV. Mọi con người, Cursor/AI và quy trình CI phải căn cứ vào đây trước khi thay đổi mã, cấu hình hoặc dữ liệu vận hành.

## 1. Khái niệm bắt buộc

| Thuật ngữ | Định nghĩa |
|-----------|------------|
| **Ecosystem** | Toàn bộ hệ sinh thái CBV — con người, quy trình, mã nguồn, AppSheet, Apps Script, webapp, AI runtime và báo cáo. |
| **Workspace OS** | Môi trường vận hành nơi repo, công cụ, biến môi trường và quyền truy cập được chuẩn hóa để làm việc an toàn, lặp lại được. |
| **Engineering Platform** | Nền tảng chuẩn hóa phát triển: cấu trúc repo, script, test, báo cáo, governance và handoff giữa các phiên làm việc. |
| **System** | Hệ điều phối nhiều domain — ví dụ **MAIN_CONTROL** điều phối luồng tổng thể. |
| **Domain** | Vùng nghiệp vụ lớn: **TASK**, **FINANCE**, **HO_SO**, v.v. Mỗi domain lớn có **test console** riêng (xem chuẩn domain/module). |
| **Module** | Khối kỹ thuật nhỏ nằm trong một Domain (màn hình, luồng, gói cài đặt, endpoint…). |
| **Runtime** | Luồng vận hành thực tế trên môi trường (dev/staging/prod), gồm dữ liệu, trigger và người dùng cuối. |
| **AI Runtime** | Không gian lưu **prompt**, **output**, **report**, **handoff**, **memory**, **decision** — tách biệt với business runtime để tránh trộn lẫn dữ liệu vận hành. |

## 2. Mapping cấu trúc khái niệm

```
CBV Operational Ecosystem
├─ CBV Operational Workspace OS
├─ CBV Engineering Platform
├─ MAIN_CONTROL System
├─ TASK Domain
├─ FINANCE Domain
├─ HO_SO Domain
└─ AI Work Brain
```

**AI Work Brain** tương ứng với thư mục `00_SYSTEM_BRAIN/` và `ai-runtime/` — nơi lưu trí có kiểm soát cho hoạt động AI và audit.

## 3. Nguyên tắc vận hành

1. **Không xóa lịch sử** — không xóa report, handoff, decision đã ghi nhận; chỉ bổ sung (append) khi cần chỉnh sửa ý nghĩa.
2. **Không ghi đè báo cáo** — report theo chuẩn append-only; mỗi lần chạy tạo file mới hoặc phần append có đánh dấu thời gian/version.
3. **Không fake DONE** — chỉ đánh dấu hoàn thành khi có bằng chứng: test pass, report, và (nếu đổi lớn) handoff.
4. **Không nhảy phase khi test FAIL** — xử lý lỗi, ghi report, rồi mới chuyển phase.
5. **Thay đổi lớn** phải có **prompt** (đầu vào rõ ràng), **report** (kết quả kiểm chứng), **handoff** (bối cảnh cho phiên sau).
6. **Test runtime tách khỏi business runtime** — môi trường kiểm thử không dùng chung dữ liệu sản xuất trừ khi có quy trình sandbox được phê duyệt.
7. **Ưu tiên manual-first → guided-operation → auto-later** — tự động hóa chỉ sau khi quy trình thủ công/hướng dẫn đã ổn định.

## 4. Liên kết tài liệu

- Cấu trúc repo: `docs/standards/CBV_REPO_STRUCTURE_STANDARD.md`
- Domain & module: `docs/standards/CBV_DOMAIN_MODULE_STANDARD.md`
- AI runtime: `docs/standards/CBV_AI_RUNTIME_STANDARD.md`
- Test & report: `docs/standards/CBV_TEST_REPORT_STANDARD.md`
- Prompt I/O: `docs/standards/CBV_PROMPT_INPUT_OUTPUT_STANDARD.md`
- Kiến trúc: `docs/architecture/`
- Governance: `docs/governance/`

## 5. Phiên bản và thay đổi

- **contractVersion**: `1` cho bộ chuẩn V1 này.
- Mọi thay đổi breaking vào chuẩn gốc phải tạo **DECISION** và bump phiên bản tài liệu có kiểm soát.
