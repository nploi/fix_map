import "package:fix_map/blocs/blocs.dart";
import "package:fix_map/blocs/shops/bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "generated/i18n.dart";
import "screens/screens.dart";
import "utils/utils.dart";

class FixMapApp extends StatefulWidget {
  final SettingsBloc settingsBloc;

  const FixMapApp({Key key, this.settingsBloc}) : super(key: key);

  @override
  _FixMapAppState createState() => _FixMapAppState();
}

class _FixMapAppState extends State<FixMapApp> {
  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    super.initState();
    authenticationBloc = AuthenticationBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: widget.settingsBloc,
      builder: (context, state) {
        final settings = widget.settingsBloc.settings;
        return MaterialApp(
          onGenerateTitle: (BuildContext context) => S.of(context).appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: Locale(settings.languageCode, ""),
          supportedLocales: S.delegate.supportedLocales,
          theme: themeLight,
          darkTheme: themeDark,
          themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: this.widget.settingsBloc.settings.isLoadFirstScreen
              ? HomeScreen.routeName
              : IntroThreePage.routeName,
          routes: {
            SignInScreen.routeName: (context) =>
                SignInScreen(authenticationBloc: authenticationBloc),
            SignUpScreen.routeName: (context) =>
                SignUpScreen(authenticationBloc: authenticationBloc),
            IntroThreePage.routeName: (context) => IntroThreePage(
                  settingsBloc: widget.settingsBloc,
                ),
            HomeScreen.routeName: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<SettingsBloc>(
                      create: (context) => widget.settingsBloc,
                    ),
                    BlocProvider<AuthenticationBloc>(
                      create: (context) => authenticationBloc,
                    ),
                    BlocProvider<MapBloc>(
                      create: (context) =>
                          MapBloc(settingsBloc: widget.settingsBloc),
                    ),
                    BlocProvider<ShopsBloc>(
                      create: (context) => ShopsBloc(),
                    ),
                  ],
                  child: HomeScreen(),
                ),
            SettingsScreen.routeName: (context) => SettingsScreen(
                  settingsBloc: widget.settingsBloc,
                ),
          },
          // ignore: missing_return
          onGenerateRoute: (routeSettings) {
            if (routeSettings.name == ShopDetailScreen.routeName) {
              final shop = routeSettings.arguments;
              return MaterialPageRoute(
                  builder: (context) => ShopDetailScreen(
                        shop: shop,
                      ));
            }
            if (routeSettings.name == ReviewScreen.routeName) {
              final List<dynamic> arguments = routeSettings.arguments;
              if (arguments.length >= 2) {
                final rating = arguments[0];
                final shop = arguments[1];
                return MaterialPageRoute(
                    builder: (context) => ReviewScreen(
                          rating: rating,
                          shop: shop,
                        ));
              }
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    authenticationBloc.close();
  }
}
