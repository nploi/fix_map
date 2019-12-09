import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "package:geolocator/geolocator.dart";

@immutable
abstract class MapState extends Equatable {
  const MapState();
  @override
  List<Object> get props => [];
}

class InitialMapState extends MapState {}

class MapCurrentLocationUpdatedState extends MapState {
  final Position position;
  const MapCurrentLocationUpdatedState(this.position);

  List<Object> get props => [position];

  @override
  String toString() =>
      "MapCurrentLocationUpdatedState {position: ${position.toJson()}";
}

class MapDataUpdatedState extends MapState {
  const MapDataUpdatedState();

  List<Object> get props => [];

  @override
  String toString() => "MapDataUpdatedState {}";
}

class MapErrorState extends MapState {
  final String message;

  const MapErrorState(this.message);

  List<Object> get props => [message];

  @override
  String toString() => "MapNotGrantedPermissionState {message: $message}";
}

class MapMarkerPressedState extends MapState {
  final String markerId;
  const MapMarkerPressedState(this.markerId);

  List<Object> get props => [markerId];

  @override
  String toString() => "MapMarkerPressedState {markerId: $markerId}";
}
