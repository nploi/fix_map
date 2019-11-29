import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:fix_map/models/models.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class AuthenticationSignInEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String accessToken;
  AuthenticationSignInEvent(this.email, this.password, this.accessToken);

  List<Object> get props => [this.email, this.password, this.accessToken];

  @override
  String toString() =>
      'AuthenticationSignInEvent {email: $email, password: $password, accessToken: $accessToken}';
}

class AuthenticationSignUpEvent extends AuthenticationEvent {
  final User user;
  AuthenticationSignUpEvent(
    this.user,
  );

  List<Object> get props => [user];

  @override
  String toString() => 'AuthenticationSignUpEvent {user: ${user.toJson()}}';
}

class AuthenticationSignOutEvent extends AuthenticationEvent {
  AuthenticationSignOutEvent();

  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationSignUpEvent {}';
}

class AuthenticationCheckSignInEvent extends AuthenticationEvent {
  AuthenticationCheckSignInEvent();

  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationCheckSignInEvent {}';
}
