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
            child: Center(child: Text(S.of(context).appName)),
          ),
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
                      Navigator.of(context).pushNamed(SettingsScreen.routeName);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(S.of(context).shopDetailTitle),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ShopDetailScreen.routeName);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
