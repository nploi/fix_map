import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/models/models.dart';
import 'package:fix_map/repositories/settings_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as developer;

import 'bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository = SettingsRepository();

  Settings get settings => _repository.getSettings();

  @override
  SettingsState get initialState => InitialSettingsState();

  Future boot() async {
    await this._repository.boot();
  }

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    try {
      if (event is SettingsUpdateSettingsEvent) {
        yield* _handleUpdateSettingsSettingsEvent(event);
        return;
      }

      if (event is SettingsRequestPermissionEvent) {
        yield* _handleSettingsRequestPermissionEvent(event);
        return;
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'SettingsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  Stream<SettingsState> _handleUpdateSettingsSettingsEvent(
      SettingsUpdateSettingsEvent event) async* {
    if (!event.settings.isEqual(settings)) {
      this._repository.setSettings(event.settings);
      yield SettingsUpdatedSettingsState(settings.copyWith());
    }
  }

  Stream<SettingsState> _handleSettingsRequestPermissionEvent(
      SettingsRequestPermissionEvent event) async* {
    try {
      GeolocationStatus status =
          await _repository.checkGeolocationPermissionStatus();
      if (status == GeolocationStatus.denied) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler().requestPermissions([
          PermissionGroup.location,
        ]);

        if (permissions[PermissionGroup.location] != PermissionStatus.granted) {
          yield SettingsNotGrantedPermissionState();
        } else {
          yield SettingsGrantedPermissionState();
        }
      } else {
        yield SettingsGrantedPermissionState();
      }
    } catch (e) {
      yield SettingsNotGrantedPermissionState();
    }
  }
}
