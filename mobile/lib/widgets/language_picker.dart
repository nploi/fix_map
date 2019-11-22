import 'package:fix_map/generated/i18n.dart';
import 'package:flutter/material.dart';

class LanguagePickerWidget extends StatelessWidget {
  final String currentLanguageCode;
  final Function(String) onPicked;
  LanguagePickerWidget(
      {Key key, @required this.currentLanguageCode, @required this.onPicked})
      : assert(languages.containsKey(currentLanguageCode)),
        super(key: key);

  static final Map<String, String> languages = {
    'en': "English",
    'vi': "Tiếng Việt"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).languagePickerTitle),
      ),
      body: ListView.builder(
        itemCount: S.delegate.supportedLocales.length,
        itemBuilder: (context, index) {
          var entry = S.delegate.supportedLocales[index];
          var color = Colors.lightBlue;
          bool isSelected = entry.languageCode == currentLanguageCode;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  languages[entry.languageCode],
                  style: TextStyle(color: isSelected ? color : null),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check,
                        color: color,
                      )
                    : SizedBox(),
                onTap: () {
                  Navigator.of(context).maybePop();
                  onPicked(entry.languageCode);
                },
              ),
              Divider(
                height: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}
