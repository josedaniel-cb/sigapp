import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/models/boletin_model/boletin_model.dart';
import 'package:SIGApp/models/notas_model.dart';
import './bloc.dart';

class BoletinBloc extends Bloc<BoletinEvent, BoletinState> {
  late BoletinModel modelo;
  late List<String> semestres;
  int? selectedSemestreIndex;
  // int selectedCursoNotasIndex;
  NotasModel? notasModel;

  // @override
  // BoletinState get initialState => BoletinLoading();
  BoletinBloc() : super(BoletinLoading());

  @override
  Stream<BoletinState> mapEventToState(
    BoletinEvent event,
  ) async* {
    if (event is BoletinControllerReady) {
      modelo = event.modelo;
      semestres = event.semestres;
      selectedSemestreIndex = 0;
      yield BoletinReady();
    } else if (event is BoletinUserChange) {
      selectedSemestreIndex = event.semestreIndex;
      yield BoletinLoading();
      App.browserController.boletinSolicitarOtro(event.semestreIndex);
    } else if (event is BoletinControllerChanged) {
      modelo = event.modelo;
      yield BoletinReady();
    } else if (event is BoletinControllerLoggedOut) {
      yield BoletinLoggedOut();
    }

    // Notas
    else if (event is BoletinUserRequestNotas) {
      // selectedCursoNotasIndex = event.indexCurso;
      // App.browserController.cargarUrl(currentModel.cursos[selectedCursoNotasIndex].notasUrl);
      App.browserController.boletinSolicitarNotas(event.indexCurso);
      yield BoletinLoadingNotas();
    } else if (event is BoletinControllerNotasReady) {
      notasModel = event.modelo;
      yield BoletinNotasReady(event.modelo);
    }
  }
}
