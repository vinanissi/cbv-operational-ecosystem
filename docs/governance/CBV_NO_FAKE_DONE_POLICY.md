# Policy Không Fake DONE — CBV

## 1. Định nghĩa “DONE”

Một công việc chỉ được coi là **hoàn thành thật** khi:

1. **Tiêu chí trong prompt/task** được thỏa mãn có kiểm chứng.
2. **Test** liên quan không ở trạng thái `FAIL` (theo `CBV_TEST_REPORT_STANDARD.md`).
3. Có **report** (hoặc bằng chứng tương đương trong CI) ghi nhận `checkedAt`, `runBy`, `traceId` (khi áp dụng).
4. Với thay đổi lớn: có **handoff** hoặc ghi chú rõ ràng trong report về bàn giao.

## 2. Hành vi bị cấm

- Khai báo “xong” / “DONE” / “hoàn tất” khi còn test fail hoặc chưa chạy test cần thiết.
- Đánh dấu issue đóng khi `status` report là `FAIL`.
- Viết report thiếu `errors`/`nextStep` khi đã biết có lỗi.

## 3. AI/Cursor

- Không tóm tắt ngắn kiểu “đã fix hết” nếu không có lệnh test hoặc log chứng minh.
- Nếu môi trường không chạy được test, ghi rõ trong report: **TEST_NOT_RUN** với lý do và `nextStep` để người chạy thủ công.

## 4. Liên kết

- Đọc trước khi làm việc: `../guides/CURSOR_README_BEFORE_WORK.md`
