import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class MapState extends Equatable {
  const MapState();
  @override
  List<Object> get props => [];
}

class InitialMapState extends MapState {}

class MapStyleUpdatedState extends MapState {
  final String style;
  MapStyleUpdatedState(this.style);

  List<Object> get props => [style];

  @override
  String toString() => 'MapStyleUpdatedState {style: $style}';
}
