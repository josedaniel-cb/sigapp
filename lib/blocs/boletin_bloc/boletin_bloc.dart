import 'package:bloc/bloc.dart';
import 'package:sigapp/app/app.dart';
import 'package:sigapp/models/boletin_model/boletin_model.dart';
import 'package:sigapp/models/notas_model.dart';
import './bloc.dart';

class BoletinBloc extends Bloc<BoletinEvent, BoletinState> {
  late BoletinModel modelo;
  late List<String> semestres;
  int? selectedSemestreIndex;
  // int selectedCursoNotasIndex;
  NotasModel? notasModel;

  // @override
  // BoletinState get initialState => BoletinLoading();
  BoletinBloc() : super(BoletinLoading()) {
    on<BoletinEvent>(_onEvent);
  }

  void _onEvent(BoletinEvent event, Emitter<BoletinState> emit) async {
    if (event is BoletinControllerReady) {
      modelo = event.modelo;
      semestres = event.semestres;
      selectedSemestreIndex = 0;
      emit(BoletinReady());
    } else if (event is BoletinUserChange) {
      selectedSemestreIndex = event.semestreIndex;
      emit(BoletinLoading());
      App.browserController.boletinSolicitarOtro(event.semestreIndex);
    } else if (event is BoletinControllerChanged) {
      modelo = event.modelo;
      emit(BoletinReady());
    } else if (event is BoletinControllerLoggedOut) {
      emit(BoletinLoggedOut());
    }

    // Notas
    else if (event is BoletinUserRequestNotas) {
      // selectedCursoNotasIndex = event.indexCurso;
      // App.browserController.cargarUrl(currentModel.cursos[selectedCursoNotasIndex].notasUrl);
      App.browserController.boletinSolicitarNotas(event.indexCurso);
      emit(BoletinLoadingNotas());
    } else if (event is BoletinControllerNotasReady) {
      notasModel = event.modelo;
      emit(BoletinNotasReady(event.modelo));
    }
  }
}
