import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'blocs/blocs.dart';
import 'fix_map_app.dart';

Future main() async {
  BlocSupervisor.delegate = FixMapBlocDelegate();
  // ignore: close_sinks
  final SettingsBloc settingsBloc = SettingsBloc();
  await settingsBloc.boot();

  runApp(
    FixMapApp(settingsBloc: settingsBloc),
  );
}
