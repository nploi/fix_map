import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'blocs/blocs.dart';
import 'fix_map.dart';

Future main() async {
  BlocSupervisor.delegate = FixMapBlocDelegate();
  // ignore: close_sinks
  final SettingsBloc settingsBloc = SettingsBloc();
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await settingsBloc.boot();

  runApp(
    FixMap(settingsBloc: settingsBloc),
  );
}
