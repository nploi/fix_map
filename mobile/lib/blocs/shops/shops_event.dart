import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class ShopsEvent extends Equatable {
  const ShopsEvent();
  @override
  List<Object> get props => [];
}

class ShopsLoadingEvent extends ShopsEvent {}

class ShopsSearchEvent extends ShopsEvent {
  final LatLngBounds bounds;
  ShopsSearchEvent(this.bounds);

  List<Object> get props => [this.bounds];

  @override
  String toString() => 'ShopsSearchEvent {bounds: ${bounds.toString()}';
}
