import 'dart:convert';

import 'package:fix_map/models/models.dart';

import 'shared_preferences_repository.dart';

class SettingsRepository extends SharedPreferencesRepository {
  Settings getSettings() {
    var settingValue = this.get(SharedPreferencesRepository.SETTINGS);
    if (settingValue == null) {
      return Settings();
    }
    return Settings.fromMappedJson(jsonDecode(settingValue));
  }

  Future<bool> setSettings(Settings settings) async {
    return await this.set(
        SharedPreferencesRepository.SETTINGS, jsonEncode(settings.toJson()));
  }
}
