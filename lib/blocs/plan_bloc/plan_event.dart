import 'package:equatable/equatable.dart';
import 'package:sigapp/models/plan_model/plan_model.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => [];
}

class PlanControllerReady extends PlanEvent {
  final PlanModel modelo;

  const PlanControllerReady(this.modelo);
}
