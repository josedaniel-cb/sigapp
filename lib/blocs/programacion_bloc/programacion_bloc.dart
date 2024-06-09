import 'package:bloc/bloc.dart';
import 'package:sigapp/models/programacion_model.dart';
import './bloc.dart';

class ProgramacionBloc extends Bloc<ProgramacionEvent, ProgramacionState> {
  late ProgramacionModel modelo;

  ProgramacionBloc() : super(Loading()) {
    on<ProgramacionEvent>(_onProgramacionEventReceived);
  }

  void _onProgramacionEventReceived(
      ProgramacionEvent event, Emitter<ProgramacionState> emit) async {
    if (event is ProgramacionControllerReady) {
      modelo = event.modelo;
      emit(Ready());
    }
  }
}
