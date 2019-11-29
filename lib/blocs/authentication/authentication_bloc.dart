import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/models/models.dart';
import 'package:fix_map/repositories/repostiories.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';
import 'dart:developer' as developer;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  Future<User> get user async => await authenticationRepository.getUser();

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
      if (event is AuthenticationCheckSignInEvent) {
        yield* _handleAuthenticationCheckSignInEvent(event);
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
      await authenticationRepository.setUser(user);
      yield AuthenticationSignedInState(user);
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
      yield AuthenticationSignedOutState();
    } else {
      yield AuthenticationErrorState("Cant not sign out");
    }
  }

  Stream<AuthenticationState> _handleAuthenticationCheckSignInEvent(
      AuthenticationCheckSignInEvent event) async* {
    yield AuthenticationLoadingState();

    var user = await authenticationRepository.getUser();
    if (user == null) {
      yield AuthenticationUserNotFoundState();
    } else {
      yield AuthenticationSignedInState(user);
    }
  }
}
