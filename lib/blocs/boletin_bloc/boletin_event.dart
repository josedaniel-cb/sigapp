import 'package:equatable/equatable.dart';
import 'package:sigapp/models/boletin_model/boletin_model.dart';
import 'package:sigapp/models/notas_model.dart';

abstract class BoletinEvent extends Equatable {
  const BoletinEvent();

  @override
  List<Object> get props => [];
}

class BoletinControllerReady extends BoletinEvent {
  final BoletinModel modelo;
  final List<String> semestres;

  const BoletinControllerReady(this.modelo, this.semestres);
}

class BoletinControllerChanged extends BoletinEvent {
  final BoletinModel modelo;

  const BoletinControllerChanged(this.modelo);
}

class BoletinUserChange extends BoletinEvent {
  final int? semestreIndex;

  const BoletinUserChange(this.semestreIndex);
}

// Excepci[on
class BoletinControllerLoggedOut extends BoletinEvent {}

// Notas
class BoletinUserRequestNotas extends BoletinEvent {
  final int indexCurso;

  const BoletinUserRequestNotas(this.indexCurso);
}

class BoletinControllerNotasReady extends BoletinEvent {
  final NotasModel modelo;

  const BoletinControllerNotasReady(this.modelo);
}
