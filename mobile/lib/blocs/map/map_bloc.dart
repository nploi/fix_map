import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/blocs/blocs.dart';
import 'package:fix_map/blocs/map/bloc.dart';
import 'package:fix_map/repositories/repostiories.dart';
import 'package:geolocator/geolocator.dart';
import 'map_event.dart';
import 'dart:developer' as developer;

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository _mapRepository = MapRepository();
  StreamSubscription _settingsSubscription;
  final SettingsBloc settingsBloc;

  MapBloc({this.settingsBloc}) : assert(settingsBloc != null) {
    _settingsSubscription = settingsBloc.listen((state) {
      if (state is SettingsGrantedPermissionState) {
        this.add(MapGetCurrentLocationEvent());
      }
    });
  }

  Future<Position> get currentLocation async =>
      await _mapRepository.getCurrentLocation();

  @override
  MapState get initialState => InitialMapState();

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    try {
      if (event is MapGetCurrentLocationEvent) {
        yield* _handleMapCurrentLocationGetEvent(event);
        return;
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'MapBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  Stream<MapState> _handleMapCurrentLocationGetEvent(
      MapGetCurrentLocationEvent event) async* {
    var currentLocation = await _mapRepository.getCurrentLocation();
    yield MapCurrentLocationUpdatedState(currentLocation);
  }

  @override
  Future<void> close() {
    _settingsSubscription.cancel();
    return super.close();
  }
}
