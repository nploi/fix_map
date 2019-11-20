import 'package:equatable/equatable.dart';
import 'package:fix_map/models/models.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object> get props => [];
}

class SettingsUpdateSettingsEvent extends SettingsEvent {
  final Settings settings;
  SettingsUpdateSettingsEvent(this.settings);

  List<Object> get props => [settings];

  @override
  String toString() =>
      'SettingsUpdateSettingsEvent {settings: ${settings.toJson()}';
}

class SettingsRequestPermissionEvent extends SettingsEvent {
  SettingsRequestPermissionEvent();

  List<Object> get props => [];

  @override
  String toString() => 'SettingsRequestPermissionEvent {}';
}
