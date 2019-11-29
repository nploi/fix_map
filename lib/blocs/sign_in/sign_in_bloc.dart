import 'dart:async';
import 'package:bloc/bloc.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  @override
  SignInState get initialState => InitialSignInState();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    // TODO: Add your event logic
  }
}
