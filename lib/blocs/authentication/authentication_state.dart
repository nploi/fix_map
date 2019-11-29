import 'package:equatable/equatable.dart';
import 'package:fix_map/models/user.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class InitialAuthenticationState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSignedUpState extends AuthenticationState {
  final User user;
  AuthenticationSignedUpState(this.user);

  List<Object> get props => [user];

  @override
  String toString() => 'AuthenticationSignedUpState {user: ${user.toJson()}';
}

class AuthenticationSignedInState extends AuthenticationState {
  final User user;
  AuthenticationSignedInState(this.user);

  List<Object> get props => [user];

  @override
  String toString() => 'AuthenticationSignedInState {user: ${user.toJson()}';
}

class AuthenticationSignedOutState extends AuthenticationState {
  AuthenticationSignedOutState();

  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationSignedOutState {}';
}

class AuthenticationUserNotFoundState extends AuthenticationState {
  AuthenticationUserNotFoundState();

  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationUserNotFoundState {}';
}

class AuthenticationErrorState extends AuthenticationState {
  final String message;
  AuthenticationErrorState(this.message);

  List<Object> get props => [message];

  @override
  String toString() => 'AuthenticationErrorState {message: $message';
}
