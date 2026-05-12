# CBV Engineering Governance

## 1. Phạm vi

Tài liệu này tóm tắt **quy tắc quản trị kỹ thuật** cho CBV Operational Ecosystem: cách ghi nhận, cách chứng minh hoàn thành, và cách xử lý lỗi.

## 2. Trách nhiệm

| Vai trò | Trách nhiệm |
|---------|-------------|
| Owner domain | Phê duyệt thay đổi schema/nghiệp vụ trong domain; đảm bảo test console domain hoạt động. |
| Maintainer repo | Giữ cấu trúc chuẩn, review PR không phá vỡ policy append-only và no-fake-done. |
| AI/Cursor | Đọc `CURSOR_README_BEFORE_WORK.md` trước khi sửa code; xuất report khi task lớn. |

## 3. Policy bắt buộc (đọc chi tiết trong file riêng)

- **Append-only**: `CBV_APPEND_ONLY_POLICY.md`
- **No fake DONE**: `CBV_NO_FAKE_DONE_POLICY.md`

## 4. Thay đổi chuẩn gốc

- Mọi thay đổi breaking vào `docs/standards/*` cần **DECISION** và thông báo trong handoff.
- Bump `contractVersion` trong các contract liên quan (test report, v.v.).

## 5. Liên kết

- Chuẩn ecosystem V1: `../standards/CBV_OPERATIONAL_ECOSYSTEM_STANDARD_V1.md`
