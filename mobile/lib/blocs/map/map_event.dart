import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class MapEvent extends Equatable {
  const MapEvent();
  @override
  List<Object> get props => [];
}

class MapGetCurrentLocationEvent extends MapEvent {
  MapGetCurrentLocationEvent();

  List<Object> get props => [];

  @override
  String toString() => 'MapGetCurrentLocationEvent {}';
}