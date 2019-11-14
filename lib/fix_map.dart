import 'package:fix_map/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/i18n.dart';
import 'screens/screens.dart';
import 'utils/utils.dart';

class FixMap extends StatelessWidget {
  final SettingsBloc settingsBloc;
  FixMap({Key key, this.settingsBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: settingsBloc,
      builder: (context, state) {
        var settings = settingsBloc.settings;
        return MaterialApp(
          onGenerateTitle: (BuildContext context) => S.of(context).appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: Locale(settings.languageCode, ''),
          supportedLocales: S.delegate.supportedLocales,
          theme: themeLight,
          darkTheme: themeDark,
          themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: HomeScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<SettingsBloc>(
                      builder: (context) => settingsBloc,
                    ),
                    BlocProvider<HomeBloc>(
                      builder: (context) => HomeBloc(),
                    ),
                    BlocProvider<MapBloc>(
                      builder: (context) => MapBloc(),
                    ),
                  ],
                  child: HomeScreen(),
                ),
            SettingsScreen.routeName: (context) => SettingsScreen(
                  settingsBloc: settingsBloc,
                ),
            ShopDetailScreen.routeName: (context) => ShopDetailScreen(
                  settingsBloc: settingsBloc,
                ),
          },
        );
      },
    );
  }
}
