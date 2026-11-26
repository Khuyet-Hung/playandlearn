import 'package:flutter/services.dart';

/// Use the same bundled font families in widget tests and visual previews.
Future<void> loadAppFonts() async {
  const families = {
    'Baloo2': ['Bold', 'ExtraBold'],
    'Nunito': ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold'],
  };
  for (final entry in families.entries) {
    final loader = FontLoader(entry.key);
    for (final weight in entry.value) {
      loader.addFont(
        rootBundle.load('assets/fonts/${entry.key}/${entry.key}-$weight.ttf'),
      );
    }
    await loader.load();
  }
}
