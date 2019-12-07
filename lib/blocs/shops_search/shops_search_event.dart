import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ShopsSearchEvent extends Equatable {
  const ShopsSearchEvent();
  @override
  List<Object> get props => [];
}

class ShopsSearchByQueryEvent extends ShopsSearchEvent {
  final String query;
  ShopsSearchByQueryEvent(this.query);

  List<Object> get props => [this.query];

  @override
  String toString() => 'ShopsSearchByQueryEvent {query: $query}';
}

class ShopsSearchNextOffsetEvent extends ShopsSearchEvent {
  final String query;
  ShopsSearchNextOffsetEvent(this.query);

  List<Object> get props => [this.query];

  @override
  String toString() => 'ShopsSearchNextOffsetEvent {query: $query}';
}
