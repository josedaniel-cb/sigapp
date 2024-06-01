import 'package:equatable/equatable.dart';
import 'package:SIGApp/models/horario_model/horario_model.dart';

abstract class HorarioEvent extends Equatable {
  const HorarioEvent();

  @override
  List<Object> get props => [];
}

class HorarioControllerReady extends HorarioEvent{
  final HorarioModel modelo;
  final List<String> semestres;

  HorarioControllerReady(this.modelo, this.semestres);
}

class HorarioControllerChanged extends HorarioEvent{
  final HorarioModel modelo;

  HorarioControllerChanged(this.modelo);
}

class HorarioUserChange extends HorarioEvent{
  final int semestreIndex;

  HorarioUserChange(this.semestreIndex);
}
