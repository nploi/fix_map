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

class ShopsDownloadedState extends ShopsState {
  ShopsDownloadedState();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsDownloadedState {}';
}

class ShopsDataNotFoundState extends ShopsState {
  ShopsDataNotFoundState();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsDataNotFoundState {}';
}

class ShopsDownloadingState extends ShopsState {
  ShopsDownloadingState();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsDownloadingState {}';
}

class ShopsLoadedState extends ShopsState {
  final int counter;
  ShopsLoadedState(this.counter);

  List<Object> get props => [counter];

  @override
  String toString() => 'ShopsLoadedState {counter: $counter}';
}

class ShopsCanRefreshState extends ShopsState {
  ShopsCanRefreshState();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsCanRefreshState {}';
}
