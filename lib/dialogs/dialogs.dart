import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/blocs/shops/bloc.dart';
import 'package:fix_map/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showDownloadDialog(BuildContext context, ShopsBloc bloc) {
  showDialog(
      context: context,
      builder: (context) => WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: BlocListener(
              bloc: bloc,
              listener: (context, state) async {
                if (state is ShopsDownloadedState) {
                  Navigator.of(context).pop();
                }
              },
              child: SimpleDialog(
                title: Text("Downloading ..."),
                children: <Widget>[
                  Container(
//                    height: MediaQuery.of(context).size.height / 2,
//                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      children: <Widget>[
                        CupertinoActivityIndicator(),
                        Text("Downloading ...")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
}

void showRequestPermissionDialog(BuildContext context) {
  showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(S.of(context).requestPermissionDialogTitle),
      content: Text(S.of(context).requestPermissionDialogContent),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(S.of(context).doNotAllowLabelButton),
          onPressed: () =>
              Navigator.pop(context, S.of(context).doNotAllowLabelButton),
        ),
        CupertinoDialogAction(
          child: Text(S.of(context).allowLabelButton),
          onPressed: () {
            BlocProvider.of<SettingsBloc>(context)
                .add(SettingsRequestPermissionEvent());
          },
        ),
      ],
    ),
  );
}
