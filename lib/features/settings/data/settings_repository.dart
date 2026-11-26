import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SettingsRepository {
  Future<bool> readReduceMotion();
  Future<void> writeReduceMotion(bool value);
  Future<String?> readLanguageCode();
  Future<void> writeLanguageCode(String value);
}

class PreferencesSettingsRepository implements SettingsRepository {
  PreferencesSettingsRepository({
    SharedPreferencesAsync Function()? createPreferences,
  }) : _createPreferences = createPreferences ?? SharedPreferencesAsync.new;

  final SharedPreferencesAsync Function() _createPreferences;
  SharedPreferencesAsync? _preferences;
  SharedPreferencesAsync get preferences =>
      _preferences ??= _createPreferences();
  static const _reduceMotionKey = 'settings.reduce_motion';
  static const _languageCodeKey = 'settings.language_code';

  @override
  Future<String?> readLanguageCode() => preferences.getString(_languageCodeKey);

  @override
  Future<void> writeLanguageCode(String value) =>
      preferences.setString(_languageCodeKey, value);

  @override
  Future<bool> readReduceMotion() async =>
      await preferences.getBool(_reduceMotionKey) ?? false;

  @override
  Future<void> writeReduceMotion(bool value) =>
      preferences.setBool(_reduceMotionKey, value);
}
