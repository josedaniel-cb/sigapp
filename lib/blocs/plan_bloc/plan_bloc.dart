import 'package:bloc/bloc.dart';
import 'package:sigapp/models/plan_model/plan_model.dart';
import './bloc.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanModel? modelo;

  PlanBloc() : super(Loading()) {
    on<PlanEvent>(_onPlanEventReceived);
  }

  void _onPlanEventReceived(PlanEvent event, Emitter<PlanState> emit) async {
    if (event is PlanControllerReady) {
      modelo = event.modelo;
      emit(Ready());
    }
  }
}
