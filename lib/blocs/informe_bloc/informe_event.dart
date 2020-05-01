import 'package:equatable/equatable.dart';
import 'package:SIGApp/models/informe_model.dart';

abstract class InformeEvent extends Equatable {
  const InformeEvent();

  @override
  List<Object> get props => [];
}

class InformeControllerReady extends InformeEvent {
  final InformeModel modelo;

  InformeControllerReady(this.modelo);
}

