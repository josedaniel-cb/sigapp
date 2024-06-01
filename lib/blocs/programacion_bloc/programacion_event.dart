import 'package:equatable/equatable.dart';
import 'package:SIGApp/models/programacion_model.dart';

abstract class ProgramacionEvent extends Equatable {
  const ProgramacionEvent();

  @override
  List<Object> get props => [];
}

class ProgramacionControllerReady extends ProgramacionEvent{
  final ProgramacionModel modelo;

  ProgramacionControllerReady(this.modelo);
}