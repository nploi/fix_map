import 'package:cached_network_image/cached_network_image.dart';
import 'package:fix_map/generated/i18n.dart';
import 'package:fix_map/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: MediaQuery.of(context).size.height * 0.07,
                ),
                title: Text(
                  S.of(context).signUpTitle,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
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
                      Navigator.of(context).pushNamed(SettingsScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
