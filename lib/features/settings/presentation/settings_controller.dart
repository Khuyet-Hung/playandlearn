import 'package:flutter/foundation.dart';

import '../data/settings_repository.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(this.repository);
  final SettingsRepository repository;
  bool _reduceMotion = false;
  bool _isSaving = false;
  bool _isLoading = false;
  bool _disposed = false;
  bool? _pendingValue;
  String? _errorMessage;

  bool get reduceMotion => _reduceMotion;
  bool get isSaving => _isSaving;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    if (_disposed || _isLoading || _isSaving) return;
    _isLoading = true;
    _notify();
    try {
      final value = await repository.readReduceMotion();
      if (_disposed) return;
      _reduceMotion = value;
      _errorMessage = null;
    } catch (_) {
      if (_disposed) return;
      _errorMessage = 'Chưa đọc được cài đặt. Bạn có thể thử lại.';
    } finally {
      _isLoading = false;
      _notify();
    }
  }

  Future<void> setReduceMotion(bool value) async {
    if (_disposed || _isSaving || _isLoading) return;
    _pendingValue = value;
    _isSaving = true;
    _notify();
    try {
      await repository.writeReduceMotion(value);
      if (_disposed) return;
      _reduceMotion = value;
      _pendingValue = null;
      _errorMessage = null;
    } catch (_) {
      if (_disposed) return;
      _errorMessage = 'Chưa lưu được thay đổi. Bạn có thể thử lại.';
    } finally {
      _isSaving = false;
      _notify();
    }
  }

  Future<void> retry() {
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
