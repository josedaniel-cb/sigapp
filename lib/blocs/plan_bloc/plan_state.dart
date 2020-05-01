import 'package:equatable/equatable.dart';

abstract class PlanState extends Equatable {
  const PlanState();

  @override
  List<Object> get props => [];
}

class Loading extends PlanState {}

class Ready extends PlanState {}
