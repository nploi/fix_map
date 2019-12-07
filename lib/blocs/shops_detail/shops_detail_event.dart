import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ShopsDetailEvent extends Equatable {
  const ShopsDetailEvent();
  @override
  List<Object> get props => [];
}

class ShopsDetailByQueryEvent extends ShopsDetailEvent {
  final String query;
  ShopsDetailByQueryEvent(this.query);

  List<Object> get props => [this.query];

  @override
  String toString() =>
      'ShopsDetailByQueryEvent {query: $query}';
}

class ShopsDetailNextOffsetEvent extends ShopsDetailEvent {
  final String query;
  ShopsDetailNextOffsetEvent(this.query);

  List<Object> get props => [this.query];

  @override
  String toString() =>
      'ShopsDetailNextOffsetEvent {query: $query}';
}
