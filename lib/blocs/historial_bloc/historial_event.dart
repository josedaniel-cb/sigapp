import 'package:equatable/equatable.dart';
import 'package:SIGApp/models/historial_model.dart';

abstract class HistorialEvent extends Equatable {
  const HistorialEvent();

  @override
  List<Object> get props => [];
}

class HistorialControllerReady extends HistorialEvent{
  final HistorialModel modelo;

  HistorialControllerReady(this.modelo);
}
