import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({super.key, required this.value, required this.label});
  final double value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final bounded = value.isFinite ? value.clamp(0.0, 1.0) : 0.0;
    return Semantics(
      label: label,
      value: '${(bounded * 100).round()}%',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.ink, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: bounded,
                child: const ColoredBox(color: AppColors.yellow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
