import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/repositories/repostiories.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';
import 'dart:developer' as developer;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    try {
      if (event is AuthenticationSignInEvent) {
        yield* _handleSignInEvent(event);
        return;
      }
      if (event is AuthenticationSignUpEvent) {
        yield* _handleSignUpEvent(event);
        return;
      }
      if (event is AuthenticationSignOutEvent) {
        yield* _handleSignOutEvent(event);
        return;
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'AuthenticationBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  Stream<AuthenticationState> _handleSignInEvent(
      AuthenticationSignInEvent event) async* {
    yield AuthenticationLoadingState();
    try {
      var user = await authenticationRepository.signIn(
          email: event.email,
          password: event.password,
          accessToken: event.accessToken);
      yield AuthenticationSignedUpState(user);
    } catch (exception) {
      yield AuthenticationErrorState(exception.message);
    }
  }

  Stream<AuthenticationState> _handleSignUpEvent(
      AuthenticationSignUpEvent event) async* {
    yield AuthenticationLoadingState();
    try {
      var user = await authenticationRepository.signUp(user: event.user);
      yield AuthenticationSignedUpState(user);
    } catch (exception) {
      yield AuthenticationErrorState(exception.message);
    }
  }

  Stream<AuthenticationState> _handleSignOutEvent(
      AuthenticationSignOutEvent event) async* {
    yield AuthenticationLoadingState();

    var success = await authenticationRepository.removeUser();
    if (success) {
      AuthenticationSignedOutState();
      return;
    }
    yield AuthenticationErrorState("Cant not sign out");
  }
}
