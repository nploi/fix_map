class Settings {
  bool darkMode = false;
  String languageCode = 'en';
  Settings();

  Settings copyWith({
    bool darkMode,
    String languageCode,
  }) {
    Settings settings = Settings();
    settings.languageCode =
        languageCode != null ? languageCode : this.languageCode;
    return settings;
  }

  Settings.fromMappedJson(Map<String, dynamic> json)
      : darkMode = json['dark_mode'] != null ? json['dark_mode'] : false,
        languageCode =
            json['language_code'] != null ? json['language_code'] : 'en';

  Map<String, dynamic> toJson() => {
        'dark_mode': darkMode,
        'language_code': languageCode,
      };

  bool isEqual(Settings settings) {
    return darkMode == settings.darkMode &&
        languageCode == settings.languageCode;
  }
}
