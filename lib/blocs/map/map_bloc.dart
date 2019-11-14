import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/blocs/map/bloc.dart';
import 'package:fix_map/repositories/repostiories.dart';
import 'package:geolocator/geolocator.dart';
import 'map_event.dart';
import 'dart:developer' as developer;

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository _mapRepository = MapRepository();
  bool _isLoading = false;
  Position _currentLocation = Position();

  Future<Position> get lastKnownLocation async =>
      await _mapRepository.getLastKnownLocation();
  bool get isLoading => _isLoading;

  @override
  MapState get initialState => InitialMapState();

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    try {
      if (event is MapCurrentLocationGetEvent) {
        yield* _handleMapCurrentLocationGetEvent(event);
        return;
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'MapBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  Stream<MapState> _handleMapCurrentLocationGetEvent(
      MapCurrentLocationGetEvent event) async* {
    _currentLocation = await _mapRepository.getCurrentLocation();
    yield MapCurrentLocationUpdatedState(_currentLocation);
  }
}
