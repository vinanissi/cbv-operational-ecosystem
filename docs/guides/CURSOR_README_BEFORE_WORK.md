# Cursor phải đọc trước khi làm việc

Trước khi sửa code hoặc tạo file mới, Cursor phải đọc:

1. docs/standards/CBV_OPERATIONAL_ECOSYSTEM_STANDARD_V1.md
2. docs/standards/CBV_REPO_STRUCTURE_STANDARD.md
3. docs/standards/CBV_DOMAIN_MODULE_STANDARD.md
4. docs/standards/CBV_AI_RUNTIME_STANDARD.md
5. docs/standards/CBV_TEST_REPORT_STANDARD.md
6. docs/standards/CBV_PROMPT_INPUT_OUTPUT_STANDARD.md
7. ai-runtime/context/CURRENT_SYSTEM_CONTEXT.md
8. ai-runtime/context/CURSOR_WORKING_RULES.md

## Nguyên tắc

- Không xoá lịch sử.
- Không overwrite report.
- Không fake DONE.
- Không nhảy phase nếu test FAIL.
- Mọi thay đổi lớn phải có prompt, report, handoff.
- Mỗi domain lớn phải có test console riêng.
- Test runtime tách khỏi business runtime.
- Report append-only.
- Ưu tiên manual-first, guided-operation, auto-later.

## Ghi chú thêm cho người vận hành

Sau khi đọc các file trên, nếu task liên quan kiến trúc hoặc governance, bổ sung đọc `docs/architecture/` và `docs/governance/`. Khi thêm domain mới, cập nhật `CURRENT_SYSTEM_CONTEXT.md` và tạo `DECISION` nếu có trade-off đáng kể.
