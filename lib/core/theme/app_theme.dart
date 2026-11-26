import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',
      scaffoldBackgroundColor: AppColors.background,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: AppColors.yellow,
            brightness: Brightness.light,
          ).copyWith(
            primary: AppColors.ink,
            onPrimary: AppColors.surface,
            surface: AppColors.surface,
            onSurface: AppColors.ink,
            secondary: AppColors.yellow,
          ),
    );
    return base.copyWith(
      textTheme: base.textTheme
          .copyWith(
            headlineLarge: base.textTheme.headlineLarge?.copyWith(
              fontFamily: 'Baloo2',
              fontSize: 38,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: 0,
            ),
            headlineMedium: base.textTheme.headlineMedium?.copyWith(
              fontFamily: 'Baloo2',
              fontSize: 30,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: 0,
            ),
            headlineSmall: base.textTheme.headlineSmall?.copyWith(
              fontFamily: 'Baloo2',
              fontWeight: FontWeight.w700,
              height: 1.25,
              letterSpacing: 0,
            ),
            titleLarge: base.textTheme.titleLarge?.copyWith(
              fontFamily: 'Baloo2',
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.25,
              letterSpacing: 0,
            ),
            titleMedium: base.textTheme.titleMedium?.copyWith(
              fontFamily: 'Baloo2',
              fontSize: 17,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
            bodyLarge: base.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            bodyMedium: base.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            labelLarge: base.textTheme.labelLarge?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          )
          .apply(bodyColor: AppColors.ink, displayColor: AppColors.ink),
      dividerColor: AppColors.ink,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.ink,
        contentTextStyle: TextStyle(
          fontFamily: 'Nunito',
          color: AppColors.surface,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
    );
  }
}
