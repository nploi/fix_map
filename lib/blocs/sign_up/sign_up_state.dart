import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object> get props => [];
}

class InitialSignUpState extends SignUpState {}
