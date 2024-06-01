import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/models/horario_model/horario_model.dart';
import './bloc.dart';

class HorarioBloc extends Bloc<HorarioEvent, HorarioState> {
  HorarioModel? currentModel;
  late List<String> semestres;
  late int selectedSemestreIndex;

  // @override
  // HorarioState get initialState => HorarioLoading();
  HorarioBloc() : super(HorarioLoading());

  @override
  Stream<HorarioState> mapEventToState(
    HorarioEvent event,
  ) async* {
    if (event is HorarioControllerReady) {
      currentModel = event.modelo;
      semestres = event.semestres;
      selectedSemestreIndex = 0;
      yield HorarioReady();
    } else if (event is HorarioUserChange) {
      selectedSemestreIndex = event.semestreIndex;
      yield HorarioLoading();
      App.browserController.horarioSolicitarOtro(event.semestreIndex);
    } else if (event is HorarioControllerChanged) {
      currentModel = event.modelo;
      yield HorarioChanged();
    }
  }
}
