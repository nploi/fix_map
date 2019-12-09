import 'package:fix_map/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Settings', () {
    var json = {
      'dark_mode': true,
      'is_load_first_screen': false,
      'language_code': 'vi',
    };

    test('toJson', () {
      Settings settings = Settings(
          darkMode: true, isLoadFirstScreen: false, languageCode: "vi");

      expect(settings.toJson(), json);
    });

    test('fromJson', () {
      Settings settings = Settings.fromJson(json);
      expect(settings.toJson(), json);
    });

    test('copyWith', () {
      Settings settings = Settings.fromJson(json);
      var copy = settings.copyWith(darkMode: false);
      expect(false, copy.darkMode);
      expect(false, copy.isLoadFirstScreen);
      expect("vi", copy.languageCode);
    });

    test('isEqual', () {
      Settings settings = Settings(
          darkMode: true, isLoadFirstScreen: false, languageCode: "vi");
      Settings settingsIsEqual = Settings(
          darkMode: true, isLoadFirstScreen: false, languageCode: "vi");
      expect(true, settings.isEqual(settingsIsEqual));
    });
  });
}
