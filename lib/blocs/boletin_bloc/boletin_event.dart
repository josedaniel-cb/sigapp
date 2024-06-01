import 'package:equatable/equatable.dart';
import 'package:SIGApp/models/boletin_model/boletin_model.dart';
import 'package:SIGApp/models/notas_model.dart';

abstract class BoletinEvent extends Equatable {
  const BoletinEvent();

  @override
  List<Object> get props => [];
}

class BoletinControllerReady extends BoletinEvent {
  final BoletinModel modelo;
  final List<String> semestres;

  BoletinControllerReady(this.modelo, this.semestres);
}

class BoletinControllerChanged extends BoletinEvent {
  final BoletinModel modelo;

  BoletinControllerChanged(this.modelo);
}

class BoletinUserChange extends BoletinEvent {
  final int? semestreIndex;

  BoletinUserChange(this.semestreIndex);
}

// Excepci[on
class BoletinControllerLoggedOut extends BoletinEvent {}

// Notas
class BoletinUserRequestNotas extends BoletinEvent {
  final int indexCurso;

  BoletinUserRequestNotas(this.indexCurso);
}

class BoletinControllerNotasReady extends BoletinEvent {
  final NotasModel modelo;
  
  BoletinControllerNotasReady(this.modelo);
}
