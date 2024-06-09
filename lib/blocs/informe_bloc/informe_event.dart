import 'package:equatable/equatable.dart';
import 'package:sigapp/models/informe_model.dart';

abstract class InformeEvent extends Equatable {
  const InformeEvent();

  @override
  List<Object> get props => [];
}

class InformeControllerReady extends InformeEvent {
  final InformeModel modelo;

  const InformeControllerReady(this.modelo);
}
