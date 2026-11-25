import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:play_and_learn/features/settings/data/settings_repository.dart';
import 'package:play_and_learn/features/settings/presentation/settings_controller.dart';

class MemorySettingsRepository implements SettingsRepository {
  bool value = false;
  bool failRead = false;
  bool failWrite = false;
  Completer<void>? pendingWrite;

  @override
  Future<bool> readReduceMotion() async {
    if (failRead) throw StateError('storage unavailable');
    return value;
  }

  @override
  Future<void> writeReduceMotion(bool value) async {
    if (failWrite) throw StateError('disk full');
    await pendingWrite?.future;
    this.value = value;
  }
}

void main() {
  test('defaults to full motion when no preference exists', () async {
    final controller = SettingsController(MemorySettingsRepository());
    addTearDown(controller.dispose);
    await controller.load();
    expect(controller.reduceMotion, isFalse);
    expect(controller.errorMessage, isNull);
  });

  test('restores a saved preference in a fresh controller', () async {
    final repository = MemorySettingsRepository();
    final first = SettingsController(repository);
    final second = SettingsController(repository);
    addTearDown(first.dispose);
    addTearDown(second.dispose);
    await first.setReduceMotion(true);
    await second.load();
    expect(second.reduceMotion, isTrue);
  });

  test('failed read keeps the app usable and retry clears the error', () async {
    final repository = MemorySettingsRepository()..failRead = true;
    final controller = SettingsController(repository);
    addTearDown(controller.dispose);
    await controller.load();
    expect(controller.reduceMotion, isFalse);
    expect(controller.errorMessage, isNotNull);
    repository
      ..failRead = false
      ..value = true;
    await controller.retry();
    expect(controller.reduceMotion, isTrue);
    expect(controller.errorMessage, isNull);
  });

  test(
    'failed save retains the last confirmed preference and can retry',
    () async {
      final repository = MemorySettingsRepository()..failWrite = true;
      final controller = SettingsController(repository);
      addTearDown(controller.dispose);
      await controller.setReduceMotion(true);
      expect(controller.reduceMotion, isFalse);
      expect(controller.errorMessage, isNotNull);
      repository.failWrite = false;
      await controller.retry();
      expect(controller.reduceMotion, isTrue);
      expect(controller.errorMessage, isNull);
      final fresh = SettingsController(repository);
      addTearDown(fresh.dispose);
      await fresh.load();
      expect(fresh.reduceMotion, isTrue);
    },
  );

  test('overlapping save is ignored while first save is pending', () async {
    final repository = MemorySettingsRepository()..pendingWrite = Completer();
    final controller = SettingsController(repository);
    addTearDown(controller.dispose);
    final save = controller.setReduceMotion(true);
    expect(controller.isSaving, isTrue);
    await controller.setReduceMotion(false);
    repository.pendingWrite!.complete();
    await save;
    expect(controller.reduceMotion, isTrue);
    expect(controller.isSaving, isFalse);
  });

  test(
    'completion after disposal does not notify a disposed controller',
    () async {
      final repository = MemorySettingsRepository()..pendingWrite = Completer();
      final controller = SettingsController(repository);
      final save = controller.setReduceMotion(true);
      controller.dispose();
      repository.pendingWrite!.complete();
      await expectLater(save, completes);
    },
  );
}
