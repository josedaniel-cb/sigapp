import 'package:bloc/bloc.dart';
import 'package:sigapp/models/historial_model.dart';
import './bloc.dart';

class HistorialBloc extends Bloc<HistorialEvent, HistorialState> {
  HistorialModel? modelo;

  HistorialBloc() : super(Loading()) {
    on<HistorialEvent>(_onHistorialEventReceived);
  }

  void _onHistorialEventReceived(
      HistorialEvent event, Emitter<HistorialState> emit) async {
    if (event is HistorialControllerReady) {
      modelo = event.modelo;
      emit(Ready());
    }
  }
}
