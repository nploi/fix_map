import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/blocs/map/bloc.dart';
import 'package:fix_map/models/shop.dart';
import 'package:fix_map/repositories/repostiories.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_event.dart';
import 'dart:developer' as developer;

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository _mapRepository = MapRepository();
  final ShopRepository _shopRepository = ShopRepository();
  bool _isLoading = false;
  Position _currentLocation = Position();

  Future<Position> get lastKnownLocation async =>
      await _mapRepository.getLastKnownLocation();
  Future<Position> get currentLocation async =>
      await _mapRepository.getCurrentLocation();
  bool get isLoading => _isLoading;

  List<Shop> _shops = [];

  List<Shop> get shops => _shops;

  @override
  MapState get initialState => InitialMapState();

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    try {
      if (event is MapCurrentLocationGetEvent) {
        yield* _handleMapCurrentLocationGetEvent(event);
        return;
      }

      if (event is MapFetchShopsEvent) {
        yield* _handleMapFetchShopsEvent(event);
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

  Stream<MapState> _handleMapFetchShopsEvent(MapFetchShopsEvent event) async* {
    this._shops = _shopRepository.getShops(mock: true);
    print(this.shops);
    yield MapDataUpdatedState();
  }
}
