import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';

class AppPageHeader extends StatelessWidget {
  const AppPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onBack,
  });
  final String title;
  final String? subtitle;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (onBack != null) ...[
        IconButton.outlined(
          onPressed: onBack,
          tooltip: 'Quay lại',
          style: IconButton.styleFrom(
            side: const BorderSide(color: AppColors.ink, width: 2),
            minimumSize: const Size(48, 48),
            backgroundColor: AppColors.surface,
          ),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        const SizedBox(height: 24),
      ],
      Text(title, style: Theme.of(context).textTheme.headlineMedium),
      if (subtitle != null) ...[
        const SizedBox(height: 10),
        Text(
          subtitle!,
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: AppColors.muted),
        ),
      ],
    ],
  );
}
