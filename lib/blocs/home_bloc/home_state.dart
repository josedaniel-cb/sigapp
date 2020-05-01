import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeReady extends HomeState {}

class HomeHorario extends HomeState{}

class HomeBoletin extends HomeState{}

class HomePlan extends HomeState{}

class HomeProgramacion extends HomeState{}

class HomeHistorial extends HomeState{}

class HomeInforme extends HomeState{}

class HomeLogOut extends HomeState {}

class HomeCriticalError extends HomeState {
  final String mensaje;

  HomeCriticalError(this.mensaje);
}

