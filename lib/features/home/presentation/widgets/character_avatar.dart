import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_colors.dart';

/// Temporary character art. Supply [assetPath] when the final assets are ready.
class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({
    super.key,
    required this.emoji,
    this.size = 68,
    this.assetPath,
  });
  final String emoji;
  final double size;
  final String? assetPath;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.ink, width: 2),
      ),
      padding: const EdgeInsets.all(7),
      child: assetPath == null
          ? Center(
              child: Text(
                emoji,
                textScaler: TextScaler.noScaling,
                style: TextStyle(fontSize: size * 0.58, height: 1.1),
              ),
            )
          : ClipOval(child: Image.asset(assetPath!, fit: BoxFit.contain)),
    ),
  );
}
