import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SignInState extends Equatable {
  const SignInState();
  @override
  List<Object> get props => [];
}

class InitialSignInState extends SignInState {}
