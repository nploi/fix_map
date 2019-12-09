import "package:shared_preferences/shared_preferences.dart";

abstract class SharedPreferencesRepository {
  static const String SETTINGS = "settings";
  static const String LAST_LOCATION = "last location";
  static const String USER = "user";

  SharedPreferences _prefs;

  Future boot() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  String get(String key) {
    return _prefs.get(key);
  }

  Future<bool> set(String key, String value) async {
    return await _prefs.setString(key, value);
  }
}
