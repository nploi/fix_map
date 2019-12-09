import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";

@immutable
abstract class ShopsSearchEvent extends Equatable {
  const ShopsSearchEvent();
  @override
  List<Object> get props => [];
}

class ShopsSearchByQueryEvent extends ShopsSearchEvent {
  final String query;
  const ShopsSearchByQueryEvent(this.query);

  List<Object> get props => [query];

  @override
  String toString() => "ShopsSearchByQueryEvent {query: $query}";
}

class ShopsSearchNextOffsetEvent extends ShopsSearchEvent {
  final String query;
  const ShopsSearchNextOffsetEvent(this.query);

  List<Object> get props => [query];

  @override
  String toString() => "ShopsSearchNextOffsetEvent {query: $query}";
}
