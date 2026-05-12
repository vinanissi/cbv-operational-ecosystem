# Chuẩn Test và Report — CBV

Tài liệu định nghĩa **contract** của báo cáo kiểm thử/kiểm chứng để máy và người đọc cùng một ngôn ngữ. Định dạng có thể là **JSON** hoặc **YAML** trong repo; trường bắt buộc dưới đây phải có mặt ở **root object** của report machine-readable. Phần văn bản tự do đặt trong `reportText`.

## 1. Trường contract (bắt buộc)

| Trường | Kiểu ý nghĩa | Mô tả |
|--------|----------------|-------|
| `ok` | boolean | `true` chỉ khi envelope và logic nghiệp vụ chấp nhận được (thường đồng nghĩa status GO hoặc GO_WITH_WARNINGS tùy policy). |
| `phase` | string | Mã phase (ví dụ `BOOTSTRAP`, `DEV`, `UAT`, `RELEASE`). |
| `status` | string | Một trong: `GO`, `GO_WITH_WARNINGS`, `FAIL` (xem mục 2). |
| `checkedAt` | string (ISO-8601) | Thời điểm kiểm tra. |
| `runBy` | string | Người hoặc agent/service thực hiện. |
| `traceId` | string | Mã theo dõi duy nhất cho lần chạy. |
| `testSuite` | string | Tên suite hoặc nhóm kiểm thử. |
| `summary` | string | Tóm tắt một đoạn. |
| `checks` | array/object | Danh sách hoặc map các bước kiểm tra và kết quả chi tiết. |
| `warnings` | array | Cảnh báo không chặn release (tùy policy). |
| `errors` | array | Lỗi nghiệp vụ/kỹ thuật. |
| `nextStep` | string | Hành động tiếp theo rõ ràng. |
| `severity` | string | Mức nghiêm trọng tổng thể: `OK`, `WARNING`, `ERROR`, `CRITICAL` (xem mục 3). |
| `reportText` | string | Bản tường thuật đầy đủ cho con người. |
| `reportJson` | object | Bản sao chính thức của payload (hoặc subset) để embed trong tool. |
| `contractVersion` | string/number | Phiên bản contract (ví dụ `1`). |
| `envelopeOk` | boolean | `true` nếu schema/envelope hợp lệ (đủ trường bắt buộc, kiểu đúng). |

## 2. Giá trị `status`

| Giá trị | Ý nghĩa |
|--------|---------|
| `GO` | Đạt; không có lỗi chặn; có thể không có cảnh báo hoặc cảnh báo đã được chấp nhận theo policy. |
| `GO_WITH_WARNINGS` | Đạt có điều kiện; có cảnh báo cần ghi nhận và owner; không FAIL. |
| `FAIL` | Không đạt; **không** được nhảy phase hoặc khai báo hoàn thành giả. |

## 3. Giá trị `severity`

| Giá trị | Ý nghĩa |
|--------|---------|
| `OK` | Không có vấn đề đáng kể. |
| `WARNING` | Rủi ro trung bình; cần theo dõi. |
| `ERROR` | Lỗi cần sửa trước khi coi là xong. |
| `CRITICAL` | Nguy cơ cao (an toàn dữ liệu, mất tiền, pháp lý); dừng release. |

## 4. Quy tắc append-only

- File report đã xuất **không sửa nội dung cũ**; lần sau tạo file mới hoặc append khối có tiêu đề thời gian/version.
- Khi `status` là `FAIL`, báo cáo phải chứa `errors` và `nextStep` cụ thể.

## 5. Ví dụ JSON tối thiểu (tham khảo)

```json
{
  "ok": false,
  "phase": "UAT",
  "status": "FAIL",
  "checkedAt": "2026-05-12T12:00:00Z",
  "runBy": "cursor-agent",
  "traceId": "trc_20260512_abc123",
  "testSuite": "finance-smoke",
  "summary": "Thanh toán batch: sai tổng tiền ở case edge.",
  "checks": [
    { "id": "pay-001", "result": "fail", "detail": "Expected 1000000, got 999999" }
  ],
  "warnings": [],
  "errors": ["TOTAL_MISMATCH"],
  "nextStep": "Sửa làm tròn tiền trong module FINANCE; chạy lại suite.",
  "severity": "ERROR",
  "reportText": "Chi tiết điều tra…",
  "reportJson": {},
  "contractVersion": 1,
  "envelopeOk": true
}
```

## 6. Liên kết

- Governance append-only: `docs/governance/CBV_APPEND_ONLY_POLICY.md`
- Không fake DONE: `docs/governance/CBV_NO_FAKE_DONE_POLICY.md`
