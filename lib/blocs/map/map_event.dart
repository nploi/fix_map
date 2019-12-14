import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";

@immutable
abstract class MapEvent extends Equatable {
  const MapEvent();
  @override
  List<Object> get props => [];
}

class MapGetCurrentLocationEvent extends MapEvent {
  const MapGetCurrentLocationEvent();

  List<Object> get props => [];

  @override
  String toString() => "MapGetCurrentLocationEvent {}";
}

class MapMarkerPressedEvent extends MapEvent {
  final String markerId;
  final int index;
  const MapMarkerPressedEvent(this.markerId, this.index);

  List<Object> get props => [markerId, index];

  @override
  String toString() =>
      "MapMarkerPressedEvent {markerId: $markerId, index: $index}";
}
