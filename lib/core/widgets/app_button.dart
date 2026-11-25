import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';
import 'app_pressable.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.color = AppColors.yellow,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) => AppPressable(
    label: label,
    onPressed: onPressed,
    color: color,
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(label, style: Theme.of(context).textTheme.labelLarge),
        ),
        if (icon != null) ...[const SizedBox(width: 12), Icon(icon, size: 22)],
      ],
    ),
  );
}
