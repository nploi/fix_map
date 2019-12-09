class Settings {
  bool darkMode = false;
  bool isLoadFirstScreen = false;
  String languageCode = "en";
  Settings({this.darkMode, this.isLoadFirstScreen, this.languageCode});

  Settings copyWith({
    bool darkMode,
    String languageCode,
    bool isLoadFirstScreen,
  }) {
    final Settings settings = Settings();
    settings.darkMode = darkMode != null ? darkMode : this.darkMode;
    settings.isLoadFirstScreen =
        isLoadFirstScreen != null ? isLoadFirstScreen : this.isLoadFirstScreen;
    settings.languageCode =
        languageCode != null ? languageCode : this.languageCode;
    return settings;
  }

  Settings.fromJson(Map<String, dynamic> json)
      : darkMode = json["dark_mode"] != null ? json["dark_mode"] : false,
        isLoadFirstScreen = json["is_load_first_screen"] != null
            ? json["is_load_first_screen"]
            : false,
        languageCode =
            json["language_code"] != null ? json["language_code"] : "en";

  Map<String, dynamic> toJson() => {
        "dark_mode": darkMode,
        "is_load_first_screen": isLoadFirstScreen,
        "language_code": languageCode,
      };

  bool isEqual(Settings settings) {
    return darkMode == settings.darkMode &&
        isLoadFirstScreen == settings.isLoadFirstScreen &&
        languageCode == settings.languageCode;
  }
}
