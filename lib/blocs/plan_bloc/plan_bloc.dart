import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:SIGApp/models/plan_model/plan_model.dart';
import './bloc.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanModel? modelo;

  // @override
  // PlanState get initialState => Loading();
  PlanBloc() : super(Loading());

  @override
  Stream<PlanState> mapEventToState(
    PlanEvent event,
  ) async* {
    if (event is PlanControllerReady) {
      modelo = event.modelo;
      yield Ready();
    }
  }
}
