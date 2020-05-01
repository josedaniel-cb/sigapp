import 'package:equatable/equatable.dart';
// import 'package:sigapp_reborn/models/horario_model/horario_model.dart';

abstract class HorarioState extends Equatable {
  const HorarioState();

  @override
  List<Object> get props => [];
}

class HorarioLoading extends HorarioState {}

class HorarioReady extends HorarioState{}

class HorarioChanged extends HorarioState{}
