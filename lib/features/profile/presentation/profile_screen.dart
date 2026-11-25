import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_chip.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/app_progress.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.onOpenSettings});
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) => ListView(
    key: const PageStorageKey('profile-scroll'),
    padding: AppTokens.pagePadding,
    children: [
      const AppPageHeader(
        title: 'Góc của bạn.',
        subtitle: 'Mỗi hành trình đều bắt đầu từ một lần thử.',
      ),
      const SizedBox(height: 28),
      AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 76,
              height: 76,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.yellow,
                border: AppTokens.border,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'N',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Người chơi',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            const AppChip(label: 'Hồ sơ trên thiết bị'),
            const SizedBox(height: 16),
            const Text(
              'Bạn đang khám phá bản xem trước. Chưa cần tài khoản để bắt đầu hành trình này.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      AppCard(
        color: AppColors.mint,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Từng bước tiến bộ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const AppChip(label: 'Dữ liệu minh họa'),
            const SizedBox(height: 20),
            const AppProgress(
              value: 0.4,
              label: 'Ví dụ mục tiêu tuần: 2 / 5 lượt',
            ),
            const SizedBox(height: 12),
            const Text(
              'Tiến độ thật sẽ xuất hiện khi các mini-game được bổ sung.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 26),
      AppButton(
        key: const ValueKey('open-settings'),
        label: 'Cài đặt ứng dụng',
        icon: Icons.tune_rounded,
        color: AppColors.surface,
        onPressed: onOpenSettings,
      ),
      const SizedBox(height: 24),
      Text(
        'PLAY & LEARN · MỖI NGÀY MỘT CHÚT',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: AppColors.muted, letterSpacing: 0.7),
      ),
    ],
  );
}
