
import 'package:equatable/equatable.dart';
import 'package:fix_map/models/models.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class InitialSettingsState extends SettingsState {}

class SettingsUpdatedSettingsState extends SettingsState {
  final Settings settings;
  SettingsUpdatedSettingsState(this.settings);

  List<Object> get props => [settings];

  @override
  String toString() => 'SettingsUpdatedSettingsState {settings: ${settings.toJson()}';
}
