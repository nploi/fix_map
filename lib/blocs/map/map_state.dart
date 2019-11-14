import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

@immutable
abstract class MapState extends Equatable {
  const MapState();
  @override
  List<Object> get props => [];
}

class InitialMapState extends MapState {}

class MapCurrentLocationUpdatedState extends MapState {
  final Position position;
  MapCurrentLocationUpdatedState(this.position);

  List<Object> get props => [position];

  @override
  String toString() =>
      'MapCurrentLocationUpdatedState {position: ${position.toJson()}';
}

class MapErrorState extends MapState {
  final String message;

  MapErrorState(this.message);

  List<Object> get props => [message];

  @override
  String toString() => 'MapNotGrantedPermissionState {message: $message}';
}
