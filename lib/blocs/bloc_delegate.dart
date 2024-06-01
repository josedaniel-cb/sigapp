import 'package:bloc/bloc.dart';

class SigappBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    _print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _print(transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    _print(error);
  }

  void _print(Object mensaje) {
    print("🤡: $mensaje");
  }
}
