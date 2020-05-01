import 'package:equatable/equatable.dart';
import 'package:SIGApp/models/notas_model.dart';

abstract class BoletinState extends Equatable {
  const BoletinState();

  @override
  List<Object> get props => [];
}

class BoletinLoading extends BoletinState {}

class BoletinReady extends BoletinState {}

class BoletinLoadingNotas extends BoletinState {}

class BoletinNotasReady extends BoletinState{
  final NotasModel notasModel;

  BoletinNotasReady(this.notasModel);
}

class BoletinLoggedOut extends BoletinState {}
