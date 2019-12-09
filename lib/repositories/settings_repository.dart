import 'dart:convert';

import 'package:fix_map/models/models.dart';
import 'package:geolocator/geolocator.dart';

import 'shared_preferences_repository.dart';

class SettingsRepository extends SharedPreferencesRepository {
  Settings getSettings() {
    var settingValue = this.get(SharedPreferencesRepository.SETTINGS);
    if (settingValue == null) {
      return Settings();
    }
    return Settings.fromJson(jsonDecode(settingValue));
  }

  Future<bool> setSettings(Settings settings) async {
    return await this.set(
        SharedPreferencesRepository.SETTINGS, jsonEncode(settings.toJson()));
  }

  Future<GeolocationStatus> checkGeolocationPermissionStatus() async {
    return await Geolocator().checkGeolocationPermissionStatus();
  }
}
