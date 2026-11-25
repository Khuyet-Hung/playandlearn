# Play & Learn

Base Flutter cho ứng dụng học tiếng Anh qua mini-game trên Android và iOS.
Giao diện neo-brutalism: nền kem, viền đen, bóng cứng và điểm nhấn vàng.

Đây là khung ứng dụng: điều hướng, giao diện và cài đặt hoạt động; các game
hiển thị **Sắp có**. Thống kê trong Hồ sơ là **Dữ liệu minh họa**.

## Chạy dự án

SDK dùng khi dựng base: **Flutter 3.50.1 stable / Dart 3.14.0**.
Cần Android SDK, JDK phù hợp và emulator hoặc điện thoại Android để chạy Android.
iOS cần máy Mac, Xcode và công cụ iOS phù hợp; Windows không build iOS cục bộ.

Với Flutter đã nằm trên PATH:

```sh
flutter pub get
flutter devices
flutter run
```

Trên Windows, dự án có wrapper dùng SDK cục bộ ở `.tooling/flutter` nếu có,
hoặc dùng Flutter trên PATH. Cache package nằm trong `.tooling/pub-cache`.

```powershell
.\scripts\flutter.cmd pub get
.\scripts\flutter.cmd devices
.\scripts\flutter.cmd run -d <device-id>
.\scripts\flutter.cmd build apk --debug
```

`.tooling/` là công cụ phát triển cục bộ, không đưa vào source control.
Identifier `dev.playandlearn.play_and_learn` là placeholder phát triển, cần
chọn identifier riêng trước khi phát hành. Chưa cấu hình ký bản phát hành.

## Cấu trúc và trách nhiệm

```text
lib/
  main.dart                 Điểm vào tối giản
  app/
    bootstrap.dart          Khởi tạo storage và dependencies
    app.dart                MaterialApp, theme và motion policy
    app_dependencies.dart   Truyền dependency qua constructor
    navigation/             Route, transition và chặn double tap
    shell/                  Ba tab, giữ vị trí cuộn khi đổi tab
  core/
    design_system.dart      Export các thành phần dùng chung
    theme/                  Palette, typography, spacing, radius, shadow
    motion/                 Chính sách animation và giảm chuyển động
    widgets/                Button, card, chip, progress, header, nav, reveal
  features/
    home/presentation/
    skills/
      domain/               Model kỹ năng và game preview
      data/                 Catalog cục bộ với ID ổn định
      presentation/         Màn hình và component riêng của kỹ năng
    profile/presentation/
    settings/
      data/                 Interface lưu trữ và adapter SharedPreferences
      presentation/         Controller và màn hình cài đặt
test/                       Unit test và widget test
tool/                       Công cụ render ảnh để kiểm tra giao diện
docs/                       Thiết kế, kế hoạch, ảnh preview
android/                    Android host được Flutter tạo
ios/                        iOS host được Flutter tạo
```

`app` ghép các feature với `core`; `core` không import ngược feature.
Component chỉ phục vụ một feature nằm trong feature đó. Tránh đưa mọi widget
vào `core` hoặc tạo trước các tầng chưa dùng. Model hiện là catalog hiển thị,
chưa phải domain gameplay; `Skill` chứa icon/màu phục vụ giao diện.

## Thư viện

| Dependency | Công dụng |
| --- | --- |
| Flutter SDK | Widget, navigation, animation, ChangeNotifier |
| `material_ui` | Bộ Material của template Flutter 3.50; nền để tùy biến giao diện |
| `shared_preferences` | Lưu tùy chọn giảm chuyển động trên thiết bị |
| `flutter_test` | Unit và widget test |
| `flutter_lints` | Phân tích tĩnh |
| `shared_preferences_platform_interface` (test) | Adapter lưu trữ in-memory chính thức để kiểm tra lỗi khởi tạo và retry |

Giữ `pubspec.lock` trong source control để dùng cùng phiên bản dependency.
Chưa cần backend, database, DI container, game engine hay framework state lớn.

## Tái sử dụng component

```dart
import 'package:material_ui/material_ui.dart';
import 'package:play_and_learn/core/design_system.dart';

AppButton(
  label: 'Tiếp tục',
  icon: Icons.arrow_forward_rounded,
  onPressed: () { /* hành động thực tế */ },
);

const AppCard(
  color: AppColors.mint,
  child: Text('Một nội dung mới'),
);
```

- `AppPressable`: mặt nổi có border/shadow, phản hồi chuột/chạm/bàn phím,
  xử lý hủy nhấn và semantics. Dùng khi cần card bấm được.
- `AppButton`, `AppCard`, `AppChip`, `AppProgress`: các thành phần nhỏ độc lập.
- `AppPageHeader`, `AppBottomNav`: bố cục và điều hướng dùng chung.
- `AppReveal`: entrance chạy một lần, không lặp theo rebuild.
- `MotionScope`: kết hợp tùy chọn ứng dụng với accessibility của hệ điều hành.

Đổi phong cách tại `AppColors`, `AppTokens`, `AppTheme`, thay vì rải giá trị
trong nhiều màn hình. Dùng cỡ chữ co giãn và nội dung cuộn, tránh fixed height
cho thẻ có văn bản. Không tải font qua mạng khi ứng dụng chạy.

## State và lưu cài đặt

`bootstrap()` tạo `SettingsRepository` → `SettingsController` → `AppDependencies`.
`PlayAndLearnApp` sở hữu vòng đời controller được truyền vào và dispose khi đóng.
Controller chỉ cập nhật preference sau khi lưu thành công, chặn thao tác lưu
chồng nhau và giữ ý định để thử lại nếu lỗi. Lỗi đọc lúc khởi động không làm
ứng dụng mất khả năng mở; có thể thử lại trong Cài đặt.

Để thay storage, implement `SettingsRepository`, rồi thay adapter tại bootstrap.
Không thay widget hoặc tạo API storage trực tiếp trong màn hình.
Key hiện tại: `settings.reduce_motion`.

## Thêm mini-game sau này

1. Thêm metadata với ID ổn định trong `preview_catalog.dart`.
2. Tạo feature gameplay riêng khi có yêu cầu cụ thể.
3. Nối ID game với route trong `AppRoutes`; thay callback “Sắp có” tại card.
4. Chỉ thêm trạng thái game chơi được khi gameplay thực sự có; giữ nhãn sắp có
   cho các game còn lại. Hiện mọi `GamePreview` đều là nội dung chưa triển khai.

Giữ logic tính điểm/luật game trong feature game; `core` chỉ giữ thành phần
thực sự dùng chung. Bổ sung âm thanh, ghi âm hoặc AI cùng chức năng cần nó.
Hiện app không yêu cầu microphone/camera và duyệt khung không cần mạng.

## Kiểm tra

```powershell
.\scripts\flutter.cmd analyze
.\scripts\flutter.cmd test
.\.tooling\flutter\bin\dart.bat format --output=none --set-exit-if-changed lib test tool
```

Nếu dùng SDK trên PATH, thay wrapper bằng `flutter` và `dart` tương ứng.
Các test kiểm tra lưu/khôi phục preference, lỗi và retry, giảm chuyển động
của OS, nhấn/hủy nút, điều hướng/back, double tap, giữ scroll và viewport
320×640 với cỡ chữ 200%. Widget test không thay thế chạy thử trên thiết bị.

Ảnh kiểm tra trực quan có thể tạo lại bằng:

```powershell
.\scripts\flutter.cmd test tool/capture_preview.dart
```

Công cụ dùng font Roboto từ Flutter SDK cục bộ. Với SDK ở nơi khác, đặt
`PREVIEW_FONT_DIR` trỏ đến `bin/cache/artifacts/material_fonts`. Ảnh nằm trong
`docs/preview/`; đây là ảnh render widget để duyệt giao diện, không phải bằng
chứng đã chạy trên điện thoại.

## Tài liệu

- [Thiết kế](docs/superpowers/specs/2026-11-26-app-shell-design.md)
- [Kế hoạch triển khai](docs/superpowers/plans/2026-11-26-flutter-base.md)
- [Báo cáo kiểm chứng, quyết định và điểm còn lại](docs/verification.md)
- [Ảnh chạy trên Android](docs/preview/android-home.png)
