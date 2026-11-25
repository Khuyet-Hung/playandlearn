# Bàn giao base Flutter

## Phần đã dựng

- Flutter/Dart, Android/iOS scaffolds và bootstrap truyền dependency rõ ràng.
- `app/`: điều hướng có chặn nhấn liên tục, ba tab giữ trạng thái và vị trí cuộn.
- `core/`: palette, typography, tokens, motion policy và component dùng chung.
- `features/`: Trang chủ, Kỹ năng, chi tiết kỹ năng, Hồ sơ và Cài đặt.
- Component: AppButton, AppPressable, AppCard, AppChip, AppProgress,
  AppPageHeader, AppBottomNav và AppReveal; export qua `core/design_system.dart`.
- Lưu giảm chuyển động, xử lý lỗi đọc/khởi tạo/lưu, retry và ưu tiên accessibility OS.
- Catalog mẫu có ID ổn định; game đều ghi “Sắp có”; tiến độ ghi “Dữ liệu minh họa”.

## Bằng chứng kiểm tra

| Kiểm tra | Kết quả |
| --- | --- |
| Flutter SDK | 3.50.1 stable; Dart 3.14.0 |
| Full unit/widget suite | 21/21 qua sau các sửa chữa từ review |
| `flutter analyze --no-pub` | No issues found |
| Formatter | 42 file, 0 thay đổi; exit 0 |
| Render preview | 5 màn hình; đã xem ảnh và sửa lỗi kế thừa typography |
| Viewport nhỏ/chữ lớn | Widget test 320×640, text scale 200% qua |
| Android APK | Build debug thành công, exit 0; `build/app/outputs/flutter-apk/app-debug.apk` |
| Android runtime | Đã cài/mở app, đổi tab, mở Cài đặt trên emulator API 37; giảm chuyển động giữ nguyên sau force-stop và mở lại |
| iOS runtime/build | Chưa kiểm chứng; máy hiện tại là Windows |

Ảnh render ở `docs/preview/` là ảnh widget dùng font và icon của Flutter SDK,
không tự nó chứng minh app đã chạy trên điện thoại. Các lệnh chạy/test nằm
trong README. Log chi tiết cục bộ ở `.superpowers/sdd/2026-11-26-flutter-base/`.

Ảnh `android-home.png`, `android-profile.png`, `android-settings.png` là ảnh
chụp từ emulator. Image Android lần đầu khởi động gặp hộp thoại System UI/
Pixel Launcher không phản hồi; sau khi giải phóng Gradle và đóng hộp thoại
launcher, ứng dụng hiển thị và thao tác được. Lần tự động hóa đầu sau restart
chạy trước khi splash kết thúc nên không dùng làm bằng chứng; lần xác nhận
cuối kiểm tra đúng từng màn hình và XML switch checked=true. Chưa thử thiết
bị vật lý hoặc đánh giá hiệu năng trên điện thoại.

## Rà soát độc lập

Một reviewer với context riêng đã đọc source, test, platform config, spec và plan.
Không có lỗi Critical; bốn lỗi Important đã được tái hiện bằng test trước khi sửa:

1. Khởi tạo storage có thể ném lỗi trước `runApp`: adapter nay tạo plugin lazy
   trong thao tác được controller bắt lỗi, có test factory lỗi rồi retry thành công.
2. Tab ẩn có thể nhận focus bàn phím: thêm ExcludeFocus, có test yêu cầu focus
   và kích hoạt bằng Enter khi tab đã bị ẩn.
3. Track tiến độ co theo phần fill: track nay chiếm chiều rộng có sẵn; kiểm tra
   hình học tại 0%, 40%, 100% và chụp lại Hồ sơ.
4. Screen reader không đọc mô tả game: nhãn semantics nay gồm cả mô tả và trạng
   thái; vẫn giữ một mục tiêu kích hoạt duy nhất.

Toàn bộ suite qua sau lượt sửa. Không dispatch lượt review thứ hai; dùng test
tái hiện và suite xanh để xác nhận các sửa chữa.

## Rulings I made

1. Làm trong workspace hiện có, không tự tạo Git repository/worktree/commit vì
   dự án chưa có Git. Giữ ledger/log thay vì xóa sau review. Đánh đổi: chưa có
   lịch sử commit để rollback.
2. Tải workflow references và Flutter SDK vào `.tooling/`, không đổi PATH toàn
   máy. Đánh đổi: dùng thêm dung lượng đĩa cục bộ.
3. Dùng `material_ui` của template Flutter 3.50 vì import Material cũ đã deprecated.
   Đánh đổi: base yêu cầu Flutter >=3.50.1 và Dart ^3.14.0 như pubspec.
4. Dùng wrapper Windows `.cmd` thay `.ps1` vì execution policy chặn PowerShell
   script; không đổi policy toàn máy. Đánh đổi: wrapper này dành cho Windows;
   macOS/Linux dùng Flutter/Dart trên PATH.
5. Router là instance thuộc shell và truyền callback bằng constructor. Đánh đổi:
   khi cần deep link, phải mở rộng routing có chủ đích.
6. Test cuộn bằng `scrollUntilVisible` để materialize nội dung lazy list trước
   thao tác. Đánh đổi: widget test dài hơn một chút, giữ nguyên mục tiêu kiểm tra.
7. Công cụ capture nạp font ngoài đồng hồ giả của widget test. Đánh đổi: cần
   thư mục font từ Flutter SDK để tạo lại ảnh.
8. Chỉ kết luận build/runtime theo lệnh và thiết bị thực sự đã chạy; iOS luôn
   được ghi rõ chưa kiểm chứng trên Windows. Đánh đổi: còn lượt xác nhận trên Mac.
9. Giữ gameplay, backend, signing và branding phát hành ngoài phạm vi. Đánh đổi:
   đây là base tái sử dụng, chưa phải sản phẩm có game hoặc sẵn sàng đưa lên store.
10. Giữ identifier phát triển do template tạo. Android là
    `dev.playandlearn.play_and_learn`, iOS là `dev.playandlearn.playAndLearn`.
    Đánh đổi: cần thay identifier và thiết lập signing trước khi phát hành.

## Deferred minors

- Mở rộng test 200% chữ để bấm trực tiếp Explore và game card; thêm assertion
  scroll offset riêng qua detail push/pop. Các test hiện có đã kiểm tra layout,
  điều hướng và giữ scroll khi đổi tab.
- Entrance hero có thể chạy lại nếu lazy list hủy element rồi dựng lại sau khi
  cuộn rất xa; đây là chi tiết animation cần tinh chỉnh sau.
- README chưa tách riêng identifier Android/iOS; dùng hai giá trị chính xác nêu
  trong báo cáo này khi chuẩn bị phát hành.

## Giới hạn còn lại

Không đăng nhập, API, AI, ghi âm, gameplay, chấm điểm hoặc thành tích thật.
Không xin quyền microphone/camera. Flutter launcher icon và signing hiện vẫn
là cấu hình phát triển. Không merge/push/publish và không tạo repository mới.
