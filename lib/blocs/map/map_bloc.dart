import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/blocs/map/bloc.dart';
import 'package:fix_map/utils/utils.dart';
import 'map_event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  String _style = mapStyleLight;

  String get style => _style;

  @override
  MapState get initialState => InitialMapState();

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is MapStyleUpdateEvent) {
      yield* _handleMapStyleUpdateEvent(event);
      return;
    }
  }

  Stream<MapState> _handleMapStyleUpdateEvent(
      MapStyleUpdateEvent event) async* {
    _style = event.style;
    yield MapStyleUpdatedState(event.style);
  }
}
