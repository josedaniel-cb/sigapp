import 'package:equatable/equatable.dart';
import 'package:SIGApp/models/plan_model/plan_model.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => null;
}

class PlanControllerReady extends PlanEvent{
  final PlanModel modelo;

  PlanControllerReady(this.modelo);
}