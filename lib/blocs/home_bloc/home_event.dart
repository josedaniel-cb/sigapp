import 'package:equatable/equatable.dart';
import 'package:sigapp/models/home_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// By user
class HomeUserLogOut extends HomeEvent {}

class HomeUserHorario extends HomeEvent {}

class HomeUserBoletin extends HomeEvent {}

class HomeUserPlan extends HomeEvent {}

class HomeUserHistorial extends HomeEvent {}

class HomeUserInforme extends HomeEvent {}

class HomeUserProgramacion extends HomeEvent {}

// By Controller
class HomeControllerReady extends HomeEvent {
  final HomeModel homeModel;

  const HomeControllerReady(this.homeModel);
}

class HomeControllerLoggedOut extends HomeEvent {}

class HomeControllerHorario extends HomeEvent {}

class HomeControllerBoletin extends HomeEvent {}

class HomeControllerPlan extends HomeEvent {}

class HomeControllerInforme extends HomeEvent {}

class HomeControllerHistorial extends HomeEvent {}

class HomeControllerProgramacion extends HomeEvent {}

class HomeControllerError extends HomeEvent {
  final String mensaje;

  const HomeControllerError(this.mensaje);
}
