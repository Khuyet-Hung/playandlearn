# Khung ứng dụng Play & Learn

Trạng thái: đã được người dùng chấp thuận để triển khai; xem `docs/verification.md` cho kết quả và giới hạn kiểm chứng.

## Mục đích và những gì đã chốt

Ứng dụng mobile vừa chơi mini-game vừa luyện tiếng Anh, hướng đến Android và iOS. Người dùng đầu tiên là chính chủ dự án. Người dùng đã chọn Flutter, hình thức nhiều mini-game theo kỹ năng và phong cách giao diện theo ảnh Model Pulse cung cấp trong cuộc trò chuyện.

Ưu tiên hiện tại là khung giao diện, điều hướng và animation cơ bản. Mini-game được phát triển sau. Các chi tiết dưới đây là đề xuất của người xây dựng, chưa phải những quyết định người dùng đã duyệt.

## Mục tiêu bản đầu

- Có thể duyệt toàn bộ các màn hình cơ bản bằng thao tác thật.
- Có bộ thành phần giao diện dùng chung và phong cách thống nhất.
- Có phản hồi chuyển động khi nhấn nút, chuyển tab, mở màn hình và bật tắt tùy chọn.
- Chuẩn bị vị trí để thêm mini-game mà không cần thay cấu trúc điều hướng chính.
- Bố cục dùng được trên điện thoại nhỏ, có cuộn khi nội dung dài.

Không triển khai gameplay, chấm điểm tiếng Anh, AI, ghi âm, tài khoản, backend, quảng cáo hay thanh toán. Không trình bày số liệu mẫu như thành tích học tập thật. Không dùng chuyển động liên tục hoặc làm việc điều hướng phải chờ animation.

## Các hướng đã cân nhắc

- Giao diện gọn gàng, hiện đại: ít trang trí; chưa thể hiện đúng ảnh tham chiếu mà người dùng đã chọn.
- Giao diện casual nhiều màu: phù hợp mini-game nhưng cần điều chỉnh sang nền kem, viền đen và bóng cứng theo ảnh tham chiếu.
- Hướng được chọn về thị giác: neo-brutalism dựa trên ảnh người dùng, chuyển sang bố cục mobile.
- Flutter/Dart và React Native/Expo đều đã được giới thiệu. Người dùng chọn Flutter. Flutter là nền tảng của bản thiết kế này; chưa cần game engine.

## Hệ thống giao diện

Màu đề xuất: nền #F3EFE6, bề mặt #FFFEF8, mực #191919, vàng #FFD83D, cam san hô #FF876B, xanh #6088F5. Màu nhấn khác cho từng kỹ năng có thể do người triển khai điều chỉnh để bảo đảm dễ đọc.

Viền 2–3 logical pixels, góc bo khoảng 16–24, bóng cứng lệch 3–5 pixels. Tiêu đề sans-serif đậm, hỗ trợ dấu tiếng Việt; nội dung ưu tiên độ dễ đọc. Font mono chỉ dùng tùy chọn cho nhãn/số. Tài nguyên font phải được đóng gói nếu dùng font ngoài, có giấy phép tương ứng, không phụ thuộc tải font lúc chạy.

Các thành phần dùng chung: nút có hiệu ứng nhấn xuống bóng, thẻ có viền, chip, thanh tiến độ, hàng cài đặt, tiêu đề trang và thanh tab. Không cần hình AI hay mascot ở bản này. Biểu tượng có sẵn là đủ.

## Màn hình và điều hướng

Ba tab chính: Trang chủ, Kỹ năng, Hồ sơ. Giữ vị trí cuộn/trạng thái khi đổi tab. Trang chi tiết kỹ năng và Cài đặt mở bên trên tab hiện tại, có nút quay lại và hỗ trợ nút back hệ thống.

### Trang chủ

Lời chào, nhãn rõ ràng "Bản xem trước", thẻ giới thiệu việc học qua mini-game và bốn thẻ kỹ năng Nghe, Nói, Đọc, Viết. Chạm thẻ mở chi tiết kỹ năng. Có thể có thống kê trình bày bằng dữ liệu mẫu, với nhãn "Dữ liệu minh họa" đặt cạnh nhóm đó. Nút khám phá chuyển đến tab Kỹ năng.

### Kỹ năng và chi tiết kỹ năng

Tab Kỹ năng hiển thị bốn nhóm kỹ năng. Trang chi tiết có mô tả ngắn và các thẻ game mẫu; tên game có thể do người triển khai đề xuất. Tất cả game gắn nhãn "Sắp có". Chạm thẻ hiển thị thông báo ngắn rằng game sẽ được bổ sung sau, không mở màn hình chơi giả. Không gắn trạng thái sắp có cho chính tính năng điều hướng.

### Hồ sơ và Cài đặt

Hồ sơ cục bộ với avatar chữ cái, tên mặc định "Người chơi" và lời giải thích đây là bản xem trước, không có tài khoản hay đăng nhập. Không cần sửa hồ sơ ở bản đầu.

Cài đặt có tùy chọn "Giảm chuyển động" hoạt động thật và được lưu trên thiết bị qua các lần mở app. Luôn tôn trọng cả yêu cầu giảm chuyển động từ hệ điều hành. Các cài đặt âm thanh/rung chưa cần hiển thị khi chưa có chức năng thực tế.

## Animation và khả năng tiếp cận

- Nút: dịch chuyển xuống 2–3 pixels khi nhấn, trở về khi thả/hủy thao tác, khoảng 100–150 ms.
- Chuyển tab: fade nhẹ 150–200 ms, không trượt toàn màn hình.
- Mở trang: chuyển động ngắn khoảng 200–250 ms.
- Thẻ xuất hiện: fade và dịch chuyển nhỏ, chỉ khi trang mở lần đầu; tránh chạy lại mỗi lần rebuild.
- Giảm chuyển động: bỏ dịch chuyển và hiệu ứng lần lượt, dùng chuyển trạng thái ngay hoặc fade ngắn.
- Vùng chạm tối thiểu 48 logical pixels, có nhãn cho screen reader, không dùng màu sắc làm tín hiệu duy nhất. Văn bản hỗ trợ tăng cỡ chữ và cuộn, không tràn trên màn hình nhỏ.

## Cấu trúc kỹ thuật và dữ liệu

Flutter stable, Dart; dùng hệ thống animation có sẵn và điều hướng của Flutter cho phạm vi hiện tại. Chưa thêm Flame, Rive, Lottie hay framework quản lý trạng thái lớn. Có thể dùng ChangeNotifier/ValueNotifier để quản lý tab và cài đặt. Dùng shared_preferences cho tùy chọn giảm chuyển động; không thêm database.

Tách theme/components, màn hình theo tính năng và dữ liệu kỹ năng/game mẫu. Mỗi game mẫu có ID ổn định, skill ID, tiêu đề, mô tả và trạng thái sắp có; sau này có thể nối ID vào màn hình gameplay. Nội dung mặc định tiếng Việt, tên các kỹ năng có thể kèm tên tiếng Anh. Tên app làm việc là "Play & Learn", có thể đổi sau.

Ứng dụng không cần mạng để duyệt khung. Không xin quyền microphone/camera ở bản đầu. Không cần cấu trúc backend hoặc tích hợp dịch vụ đám mây.

## Môi trường và kiểm chứng

Thư mục hiện tại chưa có source app và chưa có Git repository. Không tìm thấy lệnh flutter hoặc dart trên PATH trong lần kiểm tra đầu tiên; cần xác định SDK hiện có hoặc thiết lập trước khi triển khai. Chưa coi việc thiếu PATH là bằng chứng không có SDK trên máy.

Phát triển trên Windows, ưu tiên chạy thử Android. Build/chạy iOS cục bộ cần macOS và Xcode; có thể chuẩn bị source iOS trên Windows nhưng không báo đã kiểm chứng iOS nếu chưa chạy trên môi trường phù hợp. Không mua hoặc cấu hình dịch vụ cloud build trong phạm vi bản đầu.

Kiểm tra formatter và flutter analyze; kiểm tra có ý nghĩa cho điều hướng sang chi tiết/quay lại và việc bật giảm chuyển động. Chạy thử giao diện trên target khả dụng, kiểm tra màn hình nhỏ và tăng cỡ chữ. Nếu không có môi trường chạy, báo rõ giới hạn thay vì xác nhận giao diện đã được kiểm chứng.

## Phần để người triển khai tự quyết

Cấu trúc thư mục cụ thể, chi tiết API nội bộ, tên game mẫu, biểu tượng, font có giấy phép phù hợp, khoảng cách cuối cùng và tinh chỉnh thời gian animation nằm trong quyền quyết định của người triển khai, miễn giữ đúng phong cách, phạm vi và khả năng tiếp cận ở trên.

## Điều kiện hoàn tất

Các tab, nút và đường quay lại hoạt động; thẻ game thể hiện trung thực trạng thái sắp có; tùy chọn giảm chuyển động được lưu; giao diện thống nhất với ảnh tham chiếu trên bố cục mobile; không có lỗi phân tích tĩnh chưa giải thích. Báo cáo rõ những nền tảng đã thực sự chạy thử.
