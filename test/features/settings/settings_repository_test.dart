import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:play_and_learn/features/settings/data/settings_repository.dart';
import 'package:play_and_learn/features/settings/presentation/settings_controller.dart';

void main() {
  test(
    'storage initialization failure allows startup and a successful retry',
    () async {
      final previous = SharedPreferencesAsyncPlatform.instance;
      addTearDown(() => SharedPreferencesAsyncPlatform.instance = previous);
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      var available = false;
      final repository = PreferencesSettingsRepository(
        createPreferences: () {
          if (!available) throw StateError('plugin unavailable during startup');
          return SharedPreferencesAsync();
        },
      );
      final controller = SettingsController(repository);
      addTearDown(controller.dispose);
      await controller.load();
      expect(controller.reduceMotion, isFalse);
      expect(controller.errorMessage, isNotNull);
      available = true;
      await controller.retry();
      expect(controller.errorMessage, isNull);
      await controller.setReduceMotion(true);
      final fresh = SettingsController(PreferencesSettingsRepository());
      addTearDown(fresh.dispose);
      await fresh.load();
      expect(fresh.reduceMotion, isTrue);
    },
  );
}
