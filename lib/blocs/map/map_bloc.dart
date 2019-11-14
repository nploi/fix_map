import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/blocs/map/bloc.dart';
import 'map_event.dart';


class MapBloc extends Bloc<MapEvent, MapState> {
  @override
  MapState get initialState => InitialMapState();

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    // TODO: Add your event logic
  }
}
