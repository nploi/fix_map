import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/generated/i18n.dart';
import 'package:fix_map/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopDetailScreen extends StatefulWidget {
  static const String routeName = "/shop_detail";
  final SettingsBloc settingsBloc;
  const ShopDetailScreen({Key key, this.settingsBloc}) : super(key: key);

  @override
  _ShopDetailScreenState createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).shopDetailTitle),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
          bloc: widget.settingsBloc,
          builder: (context, state) {
            var settings = widget.settingsBloc.settings;

            if (state is SettingsUpdatedSettingsState) {
              settings = state.settings;
            }

            return ListView(
              children: <Widget>[
                Divider(
                  height: 1,
                ),
                ListTile(
                  leading: Icon(Icons.brightness_2),
                  title: Text(S.of(context).darkModeToggleTitle),
                  trailing: CupertinoSwitch(
                    value: settings.darkMode,
                    onChanged: (value) {
                      settings.darkMode = value;
                      widget.settingsBloc
                          .add(SettingsUpdateSettingsEvent(settings));
                    },
                  ),
                  onTap: () {
                    settings.darkMode = !settings.darkMode;
                    widget.settingsBloc
                        .add(SettingsUpdateSettingsEvent(settings));
                  },
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text(S.of(context).languagePickerTitle),
                  trailing: Text(
                      LanguagePickerWidget.languages[settings.languageCode]),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => LanguagePickerWidget(
                            currentLanguageCode: settings.languageCode,
                            onPicked: (languageCode) {
                              settings.languageCode = languageCode;
                              widget.settingsBloc
                                  .add(SettingsUpdateSettingsEvent(settings));
                            }),
                      ),
                    );
                  },
                ),
              ],
            );
          }),
    );
  }
}
