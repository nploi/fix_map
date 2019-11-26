import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/blocs/shops/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/i18n.dart';
import 'screens/screens.dart';
import 'utils/utils.dart';

class FixMapApp extends StatelessWidget {
  final SettingsBloc settingsBloc;
  FixMapApp({Key key, this.settingsBloc}) : super(key: key);

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
          initialRoute: this.settingsBloc.settings.isLoadFirstScreen
              ? HomeScreen.routeName
              : IntroThreePage.routeName,
          routes: {
            IntroThreePage.routeName: (context) => IntroThreePage(
                  settingsBloc: settingsBloc,
                ),
            HomeScreen.routeName: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<SettingsBloc>(
                      builder: (context) => settingsBloc,
                    ),
                    BlocProvider<MapBloc>(
                      builder: (context) => MapBloc(settingsBloc: settingsBloc),
                    ),
                    BlocProvider<ShopsBloc>(
                      builder: (context) => ShopsBloc(),
                    ),
                  ],
                  child: HomeScreen(),
                ),
            SettingsScreen.routeName: (context) => SettingsScreen(
                  settingsBloc: settingsBloc,
                ),
          },
          // ignore: missing_return
          onGenerateRoute: (routeSettings) {
            if (routeSettings.name == ShopDetailScreen.routeName) {
              var shop = routeSettings.arguments;
              return MaterialPageRoute(
                  builder: (context) => ShopDetailScreen(
                        shop: shop,
                      ));
            }
          },
        );
      },
    );
  }
}
