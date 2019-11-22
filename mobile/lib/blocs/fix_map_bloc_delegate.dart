import 'package:bloc/bloc.dart';

class FixMapBlocDelegate extends BlocDelegate {
  final bool debug;

  FixMapBlocDelegate({this.debug = true});
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    if (debug) {
      print(event);
    }
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (debug) {
      print(transition);
    }
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    if (debug) {
      print(error);
    }
  }
}
