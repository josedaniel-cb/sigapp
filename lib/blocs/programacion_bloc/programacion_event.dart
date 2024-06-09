import 'package:equatable/equatable.dart';
import 'package:sigapp/models/programacion_model.dart';

abstract class ProgramacionEvent extends Equatable {
  const ProgramacionEvent();

  @override
  List<Object> get props => [];
}

class ProgramacionControllerReady extends ProgramacionEvent {
  final ProgramacionModel modelo;

  const ProgramacionControllerReady(this.modelo);
}
