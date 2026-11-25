import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_page_header.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.controller});
  final SettingsController controller;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) => ListView(
              padding: AppTokens.pagePadding,
              children: [
                AppPageHeader(
                  title: 'Thoải mái\ntheo cách bạn.',
                  subtitle: 'Điều chỉnh trải nghiệm của riêng mình.',
                  onBack: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 28),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.accessibility_new_rounded, size: 32),
                      const SizedBox(height: 20),
                      Text(
                        'Giảm chuyển động',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Giảm hiệu ứng dịch chuyển khi nhấn nút và chuyển màn hình.',
                      ),
                      const SizedBox(height: 12),
                      Semantics(
                        label: 'Giảm chuyển động',
                        child: Switch(
                          value: controller.reduceMotion,
                          onChanged: controller.isSaving || controller.isLoading
                              ? null
                              : controller.setReduceMotion,
                          activeThumbColor: AppColors.ink,
                          activeTrackColor: AppColors.yellow,
                          inactiveThumbColor: AppColors.ink,
                          inactiveTrackColor: AppColors.background,
                        ),
                      ),
                      if (controller.isSaving || controller.isLoading)
                        const Text(
                          'Đang lưu hoặc đọc cài đặt…',
                          semanticsLabel: 'Đang xử lý cài đặt',
                        ),
                      const SizedBox(height: 8),
                      Text(
                        'Ứng dụng cũng luôn tôn trọng tùy chọn giảm chuyển động của thiết bị.',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                if (controller.errorMessage != null) ...[
                  const SizedBox(height: 20),
                  AppCard(
                    color: AppColors.coral,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          liveRegion: true,
                          child: Text(controller.errorMessage!),
                        ),
                        const SizedBox(height: 16),
                        AppButton(
                          label: 'Thử lại',
                          color: AppColors.surface,
                          onPressed: controller.isSaving || controller.isLoading
                              ? null
                              : controller.retry,
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                const Text(
                  'Thay đổi được lưu trên thiết bị sau khi lưu thành công. Bạn có thể dùng khung ứng dụng khi không có mạng.',
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
