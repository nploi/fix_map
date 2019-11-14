import 'package:fix_map/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/i18n.dart';
import 'screens/screens.dart';
import 'utils/utils.dart';

class FixMap extends StatelessWidget {
  final SettingsBloc bloc;

  const FixMap({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: bloc,
      builder: (context, state) {
        var settings = bloc.settings;
        return MaterialApp(
          onGenerateTitle: (BuildContext context) => S.of(context).appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: themeLight,
          darkTheme: themeDark,
          themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
          home: HomeScreen(),
        );
      },
    );
  }
}
