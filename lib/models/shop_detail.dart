class ShopDetail {
  bool darkMode = false;
  String languageCode = 'en';
  ShopDetail();

  ShopDetail copyWith({
    bool darkMode,
    String languageCode,
  }) {
    ShopDetail settings = ShopDetail();
    settings.darkMode = darkMode != null ? darkMode : this.darkMode;
    settings.languageCode =
        languageCode != null ? languageCode : this.languageCode;
    return settings;
  }

  ShopDetail.fromMappedJson(Map<String, dynamic> json)
      : darkMode = json['dark_mode'] != null ? json['dark_mode'] : false,
        languageCode =
            json['language_code'] != null ? json['language_code'] : 'en';

  Map<String, dynamic> toJson() => {
        'dark_mode': darkMode,
        'language_code': languageCode,
      };

  bool isEqual(ShopDetail settings) {
    return darkMode == settings.darkMode &&
        languageCode == settings.languageCode;
  }
}
