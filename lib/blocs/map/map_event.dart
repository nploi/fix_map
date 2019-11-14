import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

@immutable
abstract class MapEvent extends Equatable {
  const MapEvent();
  @override
  List<Object> get props => [];
}

class MapCurrentLocationGetEvent extends MapEvent {
  MapCurrentLocationGetEvent();

  List<Object> get props => [];

  @override
  String toString() => 'MapCurrentLocationUpdateEvent {}';
}


class MapFetchShopsEvent extends MapEvent {
  MapFetchShopsEvent();

  List<Object> get props => [];

  @override
  String toString() => 'MapFetchShopsEvent {}';
}
