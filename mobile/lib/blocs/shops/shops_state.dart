import 'package:equatable/equatable.dart';
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
  final int counter;
  ShopsLoadedState(this.counter);

  List<Object> get props => [counter];

  @override
  String toString() => 'ShopsLoadedState {counter: $counter}';
}
