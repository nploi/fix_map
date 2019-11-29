import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  @override
  SignUpState get initialState => InitialSignUpState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // TODO: Add your event logic
  }
}
