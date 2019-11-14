import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/generated/i18n.dart';
import 'package:fix_map/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatelessWidget {
  final SettingsBloc settingsBloc;

  HomeDrawer({Key key, this.settingsBloc})
      : assert(settingsBloc != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<SettingsBloc, SettingsState>(
          bloc: settingsBloc,
          builder: (context, state) {
            var settings = settingsBloc.settings;

            return Column(
              children: <Widget>[
                MediaQuery.removePadding(
                  context: context,
                  // DrawerHeader consumes top MediaQuery padding.
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
