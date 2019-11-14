import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class MapEvent extends Equatable {
  const MapEvent();
  @override
  List<Object> get props => [];
}

class MapStyleUpdateEvent extends MapEvent {
  final String style;
  MapStyleUpdateEvent(this.style);

  List<Object> get props => [style];

  @override
  String toString() => 'MapStyleUpdateEvent {style: $style}';
}
