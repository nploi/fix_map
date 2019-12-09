import "package:bloc/bloc.dart";
import "package:flutter/material.dart";
import "blocs/blocs.dart";
import "fix_map_app.dart";
import "utils/utils.dart";

Future main() async {
  BlocSupervisor.delegate = FixMapBlocDelegate();
  final SettingsBloc settingsBloc = SettingsBloc();

  await settingsBloc.boot();
  await MarkerUtils.initIcons();

  runApp(
    FixMapApp(settingsBloc: settingsBloc),
  );

  await settingsBloc.close();
}
