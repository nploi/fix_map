import "package:fix_map/models/models.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("Settings", () {
    final json = {
      "dark_mode": true,
      "is_load_first_screen": false,
      "language_code": "vi",
    };

    test("toJson", () {
      final Settings settings = Settings(
          darkMode: true, isLoadFirstScreen: false, languageCode: "vi");

      expect(settings.toJson(), json);
    });

    test("fromJson", () {
      final Settings settings = Settings.fromJson(json);
      expect(settings.toJson(), json);
    });

    test("copyWith", () {
      final settings = Settings.fromJson(json);
      final copy = settings.copyWith(darkMode: false);
      expect(false, copy.darkMode);
      expect(false, copy.isLoadFirstScreen);
      expect("vi", copy.languageCode);
    });

    test("isEqual", () {
      final Settings settings = Settings(
          darkMode: true, isLoadFirstScreen: false, languageCode: "vi");
      final Settings settingsIsEqual = Settings(
          darkMode: true, isLoadFirstScreen: false, languageCode: "vi");
      expect(true, settings.isEqual(settingsIsEqual));
    });
  });
}
