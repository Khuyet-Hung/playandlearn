import 'package:flutter/widgets.dart';

import '../../../l10n/app_localizations.dart';
import '../data/settings_repository.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(this.repository);
  final SettingsRepository repository;
  bool _reduceMotion = false;
  bool _isSaving = false;
  bool _isLoading = false;
  bool _disposed = false;
  bool? _pendingValue;
  String? _pendingLanguageCode;
  String _languageCode = 'vi';
  bool? _writeError;

  bool get reduceMotion => _reduceMotion;
  bool get isSaving => _isSaving;
  bool get isLoading => _isLoading;
  Locale get locale => Locale(_languageCode);
  String? get errorMessage {
    final error = _writeError;
    if (error == null) return null;
    final strings = lookupAppLocalizations(locale);
    return error ? strings.settingsWriteError : strings.settingsReadError;
  }

  Future<void> load() async {
    if (_disposed || _isLoading || _isSaving) return;
    _isLoading = true;
    _notify();
    try {
      final value = await repository.readReduceMotion();
      final language = await repository.readLanguageCode();
      if (_disposed) return;
      _reduceMotion = value;
      _languageCode = language == 'en' ? 'en' : 'vi';
      _writeError = null;
    } catch (_) {
      if (_disposed) return;
      _writeError = false;
    } finally {
      _isLoading = false;
      _notify();
    }
  }

  Future<void> setReduceMotion(bool value) async {
    if (_disposed || _isSaving || _isLoading) return;
    _pendingValue = value;
    _pendingLanguageCode = null;
    _isSaving = true;
    _notify();
    try {
      await repository.writeReduceMotion(value);
      if (_disposed) return;
      _reduceMotion = value;
      _pendingValue = null;
      _writeError = null;
    } catch (_) {
      if (_disposed) return;
      _writeError = true;
    } finally {
      _isSaving = false;
      _notify();
    }
  }

  Future<void> setLanguageCode(String value) async {
    if (_disposed ||
        _isSaving ||
        _isLoading ||
        (value != 'vi' && value != 'en')) {
      return;
    }
    _pendingLanguageCode = value;
    _pendingValue = null;
    _isSaving = true;
    _notify();
    try {
      await repository.writeLanguageCode(value);
      if (_disposed) return;
      _languageCode = value;
      _pendingLanguageCode = null;
      _writeError = null;
    } catch (_) {
      if (_disposed) return;
      _writeError = true;
    } finally {
      _isSaving = false;
      _notify();
    }
  }

  Future<void> retry() {
    final language = _pendingLanguageCode;
    if (language != null) return setLanguageCode(language);
    final value = _pendingValue;
    return value == null ? load() : setReduceMotion(value);
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
