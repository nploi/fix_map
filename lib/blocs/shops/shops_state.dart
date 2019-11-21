import 'package:equatable/equatable.dart';
import 'package:fix_map/models/models.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ShopsState extends Equatable {
  const ShopsState();
  @override
  List<Object> get props => [];
}

class InitialShopsState extends ShopsState {}

class ShopsLoadingState extends ShopsState {}

class ShopsLoadedState extends ShopsState {
  final int size;

  ShopsLoadedState(this.size);

  List<Object> get props => [this.size];

  @override
  String toString() => 'ShopsLoadedState {size: $size';
}
