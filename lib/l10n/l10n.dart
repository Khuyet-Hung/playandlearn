import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

final vietnameseStrings = lookupAppLocalizations(const Locale('vi'));

extension LocalizedContext on BuildContext {
  AppLocalizations get l10n =>
      Localizations.of<AppLocalizations>(this, AppLocalizations) ??
      vietnameseStrings;
}
