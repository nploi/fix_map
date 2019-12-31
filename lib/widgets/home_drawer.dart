import "package:fix_map/blocs/authentication/authentication_state.dart";
import "package:fix_map/blocs/blocs.dart";
import "package:fix_map/dialogs/dialogs.dart";
import "package:fix_map/generated/i18n.dart";
import "package:fix_map/models/models.dart";
import "package:fix_map/screens/screens.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:url_launcher/url_launcher.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        return FutureBuilder<User>(
            future: BlocProvider.of<AuthenticationBloc>(context).user,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final user = snapshot.data;
              return Column(
                children: <Widget>[
                  DrawerHeader(
                    child: Center(
                      child: ListTile(
                        leading: Icon(
                          Icons.account_circle,
                          size: MediaQuery.of(context).size.height * 0.07,
                        ),
                        title: Text(
                          user.fullName != null
                              ? user.fullName
                              : S.of(context).signInTitle,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: user.fullName != null
                            ? null
                            : () {
                                Navigator.of(context)
                                    .pushNamed(SignInScreen.routeName);
                              },
                      ),
                    ),
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                  ),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Expanded(
                      child: ListView(
                        dragStartBehavior: DragStartBehavior.down,
                        padding: EdgeInsets.all(0),
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.settings),
                            title: Text(S.of(context).settingsTitle),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(SettingsScreen.routeName);
                            },
                          ),
                          user.fullName != null
                              ? ListTile(
                                  leading: Icon(FontAwesomeIcons.signOutAlt),
                                  title: Text(S.of(context).signOutTitle),
                                  onTap: () {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(AuthenticationSignOutEvent());
                                  },
                                )
                              : Container(),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text(S.of(context).feedbackTitle),
                            onTap: () async {
                              const launcherText =
                                  'mailto:nploi1998@gmail.com?subject=[FIX MAP] - GÓP Ý';
                              if (await canLaunch(launcherText)) {
                                await launch(launcherText);
                              }
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.info_outline),
                            title: Text(S.of(context).aboutTitle),
                            onTap: () {
                              showAppAboutDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
      }),
    );
  }
}
