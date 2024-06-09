import 'package:equatable/equatable.dart';
import 'package:sigapp/models/horario_model/horario_model.dart';

abstract class HorarioEvent extends Equatable {
  const HorarioEvent();

  @override
  List<Object> get props => [];
}

class HorarioControllerReady extends HorarioEvent {
  final HorarioModel modelo;
  final List<String> semestres;

  const HorarioControllerReady(this.modelo, this.semestres);
}

class HorarioControllerChanged extends HorarioEvent {
  final HorarioModel modelo;

  const HorarioControllerChanged(this.modelo);
}

class HorarioUserChange extends HorarioEvent {
  final int semestreIndex;

  const HorarioUserChange(this.semestreIndex);
}
