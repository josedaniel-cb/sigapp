import 'package:bloc/bloc.dart';
import 'package:sigapp/app/app.dart';
import 'package:sigapp/models/horario_model/horario_model.dart';
import './bloc.dart';

class HorarioBloc extends Bloc<HorarioEvent, HorarioState> {
  HorarioModel? currentModel;
  late List<String> semestres;
  late int selectedSemestreIndex;

  // @override
  // HorarioState get initialState => HorarioLoading();
  HorarioBloc() : super(HorarioLoading()) {
    on<HorarioEvent>(_onEvent);
  }

  void _onEvent(HorarioEvent event, Emitter<HorarioState> emit) async {
    if (event is HorarioControllerReady) {
      currentModel = event.modelo;
      semestres = event.semestres;
      selectedSemestreIndex = 0;
      emit(HorarioReady());
    } else if (event is HorarioUserChange) {
      selectedSemestreIndex = event.semestreIndex;
      emit(HorarioLoading());
      App.browserController.horarioSolicitarOtro(event.semestreIndex);
    } else if (event is HorarioControllerChanged) {
      currentModel = event.modelo;
      emit(HorarioChanged());
    }
  }
}
